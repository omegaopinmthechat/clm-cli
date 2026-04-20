import { spawn } from "child_process";

export const DEV_RPC_URL = "http://127.0.0.1:8545";

function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function pingRpc(url: string, timeoutMs = 1200): Promise<boolean> {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);

  try {
    const response = await fetch(url, {
      method: "POST",
      headers: {
        "content-type": "application/json",
      },
      body: JSON.stringify({
        jsonrpc: "2.0",
        id: 1,
        method: "eth_chainId",
        params: [],
      }),
      signal: controller.signal,
    });

    if (!response.ok) {
      return false;
    }

    const payload = (await response.json()) as {
      result?: string;
      error?: unknown;
    };

    return typeof payload.result === "string";
  } catch {
    return false;
  } finally {
    clearTimeout(timer);
  }
}

export async function ensureDevChainRunning(): Promise<{
  started: boolean;
  rpcUrl: string;
}> {
  if (await pingRpc(DEV_RPC_URL)) {
    return { started: false, rpcUrl: DEV_RPC_URL };
  }

  const cliPath = require.resolve("ganache/dist/node/cli.js");

  const child = spawn(
    process.execPath,
    [
      cliPath,
      "--quiet",
      "--server.host",
      "127.0.0.1",
      "--server.port",
      "8545",
      "--chain.chainId",
      "1337",
      "--wallet.totalAccounts",
      "10",
    ],
    {
      detached: true,
      stdio: "ignore",
      windowsHide: true,
    },
  );

  child.unref();

  for (let attempt = 0; attempt < 40; attempt++) {
    if (await pingRpc(DEV_RPC_URL)) {
      return { started: true, rpcUrl: DEV_RPC_URL };
    }

    await sleep(250);
  }

  throw new Error("Failed to start local dev chain at 127.0.0.1:8545");
}
