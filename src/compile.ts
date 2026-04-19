import fs from "fs";
import solc from "solc";
import path from "path";
import { spinnerStart, spinnerSucceed, spinnerFailed } from "./utils/ora.spinner";

export function compile(contractPath: string) {
  const fileName = path.basename(contractPath);
  const source = fs.readFileSync(contractPath, "utf-8");

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
    },
  };

  function findImports(importPath: string) {
    try {
      const fullPath = path.resolve("node_modules", importPath);
      const content = fs.readFileSync(fullPath, "utf-8");
      return { contents: content };
    } catch {
      return { error: "File not found" };
    }
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

  const contracts = output.contracts[fileName];

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

    const artifact = {
      contractName: name,
      abi: contract.abi,
      bytecode,
    };

    fs.writeFileSync(
      path.join(artifactsDir, `${name}.json`),
      JSON.stringify(artifact, null, 2),
    );

    compiledCount++;
  }

  spinnerSucceed(
    `Compiled ${contractNames.length} contract(s) (${compiledCount} deployable)`,
  );

  return contracts;
}