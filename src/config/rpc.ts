import { spawnSync } from "child_process";
import fs from "fs";
import inquirer from "inquirer";
import path from "path";

const CLM_DIR = path.join(process.cwd(), ".clm");
const RPC_FILE = path.join(CLM_DIR, "rpc.json");

interface RpcConfig {
  networks: Record<
    string,
    {
      provider: string;
      rpcUrl: string;
      updatedAt: string;
    }
  >;
}

function hideDirOnWindows(dirPath: string): void {
  if (process.platform !== "win32") {
    return;
  }

  try {
    spawnSync("attrib", ["+h", dirPath], { stdio: "ignore", windowsHide: true });
  } catch {
    // Keep going even if hidden-attribute update fails.
  }
}

function ensureClmDir(): void {
  if (!fs.existsSync(CLM_DIR)) {
    fs.mkdirSync(CLM_DIR, { recursive: true });
  }

  hideDirOnWindows(CLM_DIR);
}

function normalizeNetwork(network: string): string {
  return network.trim().toLowerCase();
}

function ensureSupportedNetwork(network: string): void {
  if (network !== "sepolia") {
    throw new Error(
      `Network "${network}" is not supported yet. Currently supported: sepolia.`,
    );
  }
}

function buildAlchemyRpcUrl(network: string, apiKey: string): string {
  if (network === "sepolia") {
    return `https://eth-sepolia.g.alchemy.com/v2/${apiKey}`;
  }

  throw new Error(`Alchemy RPC URL template for network "${network}" is not implemented yet.`);
}

function readRpcConfig(): RpcConfig {
  if (!fs.existsSync(RPC_FILE)) {
    return { networks: {} };
  }

  try {
    const parsed = JSON.parse(fs.readFileSync(RPC_FILE, "utf-8")) as RpcConfig;

    if (!parsed || typeof parsed !== "object" || !parsed.networks) {
      return { networks: {} };
    }

    return parsed;
  } catch {
    return { networks: {} };
  }
}

function writeRpcConfig(config: RpcConfig): void {
  ensureClmDir();
  fs.writeFileSync(RPC_FILE, JSON.stringify(config, null, 2));
}

async function promptAlchemyApiKey(network: string): Promise<string> {
  const { apiKey } = await inquirer.prompt([
    {
      type: "password",
      name: "apiKey",
      message: `Enter Alchemy API key for ${network}`,
      mask: "*",
      validate: (value: string) =>
        value.trim().length > 0 || "Alchemy API key cannot be empty",
    },
  ]);

  return apiKey.trim();
}

export async function addRpcConfig(
  networkInput: string,
  providedApiKey?: string,
): Promise<void> {
  const network = normalizeNetwork(networkInput);
  ensureSupportedNetwork(network);

  const apiKey = providedApiKey?.trim() || await promptAlchemyApiKey(network);
  const rpcUrl = buildAlchemyRpcUrl(network, apiKey);

  const config = readRpcConfig();
  config.networks[network] = {
    provider: "alchemy",
    rpcUrl,
    updatedAt: new Date().toISOString(),
  };

  writeRpcConfig(config);

  console.log(`Saved ${network} RPC in .clm/rpc.json`);
}

export function getRpcUrl(networkInput: string): string {
  const network = normalizeNetwork(networkInput);
  ensureSupportedNetwork(network);

  const config = readRpcConfig();
  const rpcUrl = config.networks[network]?.rpcUrl;

  if (!rpcUrl) {
    throw new Error(
      `No RPC configured for ${network}. Run: clm addrpc -n ${network}`,
    );
  }

  return rpcUrl;
}