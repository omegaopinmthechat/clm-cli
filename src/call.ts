import fs from "fs";
import path from "path";
import { ethers } from "ethers";
import { SEPOLIA_RPC } from "./config/env";
import { getPrivateKey } from "./keyManager";
import { ensureDevChainRunning } from "./devchain";

export type CallMode = "default" | "dev";

interface CallOptions {
  mode?: CallMode;
  network?: string;
  pkey?: string;
  keyName?: string;
}

function resolveAddressFromArtifact(artifact: any, addressKey: string): string {
  if (artifact.addresses && typeof artifact.addresses === "object") {
    const selected = artifact.addresses[addressKey];

    if (!selected) {
      const knownNetworks = Object.keys(artifact.addresses);
      throw new Error(
        `No address for network "${addressKey}" in artifact. Known networks: ${knownNetworks.join(", ") || "none"}`,
      );
    }

    return selected;
  }

  if (!artifact.address) {
    throw new Error("Contract address not found. Save it after deployment.");
  }

  return artifact.address;
}

async function resolveCallContext(options: CallOptions) {
  const mode = options.mode ?? "default";

  if (mode === "dev") {
    if (options.pkey && options.keyName) {
      throw new Error("Use either --privatekey OR --key");
    }

    const { started, rpcUrl } = await ensureDevChainRunning();

    if (started) {
      console.log(`Started local dev chain at ${rpcUrl}`);
    } else {
      console.log(`Using local dev chain at ${rpcUrl}`);
    }

    const provider = new ethers.JsonRpcProvider(rpcUrl);

    if (options.pkey || options.keyName) {
      const privateKey = options.keyName
        ? getPrivateKey(options.keyName)
        : options.pkey;

      if (!privateKey) {
        throw new Error("Private key required");
      }

      return {
        provider,
        signer: new ethers.Wallet(privateKey, provider),
        addressKey: "dev",
      };
    }

    const localSigner = await provider.getSigner(0);

    return {
      provider,
      signer: localSigner,
      addressKey: "dev",
    };
  }

  if (options.network && options.network !== "sepolia") {
    console.warn(
      `Network "${options.network}" is not configured yet. Falling back to sepolia.`,
    );
  }

  if (options.pkey && options.keyName) {
    throw new Error("Use either --privatekey OR --key");
  }

  const privateKey = options.keyName ? getPrivateKey(options.keyName) : options.pkey;

  if (!privateKey) {
    throw new Error("Private key required");
  }

  const provider = new ethers.JsonRpcProvider(SEPOLIA_RPC);

  return {
    provider,
    signer: new ethers.Wallet(privateKey, provider),
    addressKey: "sepolia",
  };
}

export async function callContract(
  contractName: string,
  functionName: string,
  args: any[],
  options: CallOptions = {},
) {
  const { provider, signer, addressKey } = await resolveCallContext(options);

  const artifactPath = path.join(
    process.cwd(),
    "artifacts",
    `${contractName}.json`,
  );

  if (!fs.existsSync(artifactPath)) {
    throw new Error(`Artifact not found for ${contractName}`);
  }

  const artifact = JSON.parse(fs.readFileSync(artifactPath, "utf-8"));

  const abi = artifact.abi;

  const address = resolveAddressFromArtifact(artifact, addressKey);
  const code = await provider.getCode(address);

  if (code === "0x") {
    throw new Error(
      `No contract code at ${address} on network "${addressKey}". Deploy and call must target the same network (try --dev for local chain).`,
    );
  }

  const contract = new ethers.Contract(address, abi, signer);

  console.log(`Calling ${functionName} on ${contractName}...`);

  const tx = await contract[functionName](...args);

  const receipt = await tx.wait();

  console.log("Transaction:", receipt.hash);

  const iface = new ethers.Interface(abi);

  for (const log of receipt.logs) {
    try {
      const parsed = iface.parseLog(log);
      if (!parsed){
        throw new Error("nothing to print")
    }else{
        console.log(...parsed.args);
    }
    } catch (err){
        console.log(err)
    }
  }
}
