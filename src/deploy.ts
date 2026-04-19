import { ethers } from "ethers";
import { SEPOLIA_RPC } from "./config/env";
import { compile } from "./compile";
import { getPrivateKey } from "./keyManager";
import {
  spinnerStart,
  spinnerSucceed,
  spinnerFailed,
  spinnerText
} from "./utils/ora.spinner";

// For now we will be using sepolia rpc so the network tha is passed is not used
export async function deploy(
  contractPath: string,
  network: string,
  pkey?: string,
  keyName?: string,
) {
  const contracts = compile(contractPath);

  const contractName = Object.keys(contracts)[0];
  const contract = contracts[contractName];

  const abi = contract.abi;
  const bytecode = contract.evm.bytecode.object;

  if (pkey && keyName) {
    throw new Error("Use either --privatekey OR --key, not both");
  }

  let privateKey = keyName ? getPrivateKey(keyName) : pkey;

  if (!privateKey) {
    throw new Error("Wallet Private key is required.");
  }

  const provider = new ethers.JsonRpcProvider(SEPOLIA_RPC);

  let wallet;
  try {
    wallet = new ethers.Wallet(privateKey, provider);
  } catch {
    throw new Error("Invalid private key");
  }

  spinnerStart("Deploying contract...");

  try {
    const factory = new ethers.ContractFactory(abi, bytecode, wallet);
    const deployed = await factory.deploy();

    spinnerText("Waiting for confirmation...");
    await deployed.waitForDeployment();

    const address = await deployed.getAddress();

    spinnerSucceed(`Deployed ${contractName}`);
    console.log(`${contractName} deployed at: ${address}`);
  } catch (err) {
    spinnerFailed("Deployment failed");
    throw err;
  }
}