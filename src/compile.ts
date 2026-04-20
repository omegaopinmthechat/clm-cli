import fs from "fs";
import solc from "solc";
import path from "path";
import { spinnerStart, spinnerSucceed, spinnerFailed } from "./utils/ora.spinner";

export interface CompileOptions {
  sourceOverride?: string;
  sourceName?: string;
  evmVersion?: string;
}

function resolveImportPath(
  importPath: string,
  rootContractPath: string,
): string | null {
  const contractDir = path.dirname(rootContractPath);

  const candidates = [
    path.resolve(contractDir, importPath),
    path.resolve(process.cwd(), importPath),
    path.resolve(process.cwd(), "node_modules", importPath),
  ];

  for (const candidate of candidates) {
    if (fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
      return candidate;
    }
  }

  return null;
}

export function compile(contractPath: string, options: CompileOptions = {}) {
  const absoluteContractPath = path.resolve(contractPath);
  const fileName = options.sourceName ?? path.basename(absoluteContractPath);
  const source =
    options.sourceOverride ?? fs.readFileSync(absoluteContractPath, "utf-8");

  spinnerStart("Compiling solidity...");

  const input = {
    language: "Solidity",
    sources: {
      [fileName]: { content: source },
    },
    settings: {
      outputSelection: {
        "*": {
          "*": ["abi", "evm.bytecode"],
        },
      },
      ...(options.evmVersion ? { evmVersion: options.evmVersion } : {}),
    },
  };

  function findImports(importPath: string) {
    const fullPath = resolveImportPath(importPath, absoluteContractPath);

    if (!fullPath) {
      return { error: `File not found: ${importPath}` };
    }

    const content = fs.readFileSync(fullPath, "utf-8");
    return { contents: content };
  }

  const output = JSON.parse(
    solc.compile(JSON.stringify(input), { import: findImports }),
  );

  let hasError = false;

  let errorMessages: string[] = [];
  if (output.errors) {
    for (const err of output.errors) {
      if (err.severity === "error") {
        hasError = true;
        errorMessages.push(err.formattedMessage);
      } else {
        console.warn("Warn: ", err.formattedMessage);
      }
    }
  }

  if (hasError) {
    spinnerFailed("Compilation failed");

    console.error("\nSolidity Errors:\n");
    errorMessages.forEach((e) => console.error(e));

    throw new Error("Compilation failed.");
  }

  const contracts = output.contracts?.[fileName];

  if (!contracts) {
    spinnerFailed("Compilation failed");
    throw new Error(`No contracts found in ${fileName}`);
  }

  const artifactsDir = path.join(process.cwd(), "artifacts");
  if (!fs.existsSync(artifactsDir)) {
    fs.mkdirSync(artifactsDir);
  }
  let compiledCount = 0;
  const contractNames = Object.keys(contracts);

  for (const name of contractNames) {
    const contract = contracts[name];

    const bytecode = contract.evm?.bytecode?.object;

    if (!bytecode) {
      console.warn(`${name} has no deployable bytecode`);
      continue;
    }

    const artifactPath = path.join(artifactsDir, `${name}.json`);

    let existingArtifact: Record<string, unknown> = {};
    if (fs.existsSync(artifactPath)) {
      try {
        const raw = fs.readFileSync(artifactPath, "utf-8");
        existingArtifact = JSON.parse(raw);
      } catch {
        // Ignore corrupted artifact and rebuild from compiled output.
        existingArtifact = {};
      }
    }

    const existingAbi = Array.isArray(existingArtifact["abi"])
      ? existingArtifact["abi"]
      : undefined;

    const hasLastDeployedAbi = Array.isArray(
      existingArtifact["lastDeployedAbi"],
    );

    const artifact = {
      ...existingArtifact,
      ...(existingAbi && !hasLastDeployedAbi
        ? { lastDeployedAbi: existingAbi }
        : {}),
      contractName: name,
      abi: contract.abi,
      bytecode,
    };

    fs.writeFileSync(artifactPath, JSON.stringify(artifact, null, 2));

    compiledCount++;
  }

  spinnerSucceed(
    `Compiled ${contractNames.length} contract(s) (${compiledCount} deployable)`,
  );

  return contracts;
}