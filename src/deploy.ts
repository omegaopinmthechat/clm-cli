import { ethers } from "ethers";
import { SEPOLIA_RPC } from "./config/env";
import { compile } from "./compile";
import { getPrivateKey } from "./keyManager";
import {
  spinnerStart,
  spinnerSucceed,
  spinnerFailed,
  spinnerText,
} from "./utils/ora.spinner";
import { parseParams } from "./utils/parser";
import {
  selectContract,
  askConstructorParams,
} from "./utils/contract.inquirer";

export async function deploy(
  contractPath: string,
  network: string,
  pkey?: string,
  keyName?: string,
  paramsStr?: string,
  contractNameArg?: string,
) {
  const contracts = compile(contractPath);
  const contractNames = Object.keys(contracts);
  const hasExplicitContract = Boolean(contractNameArg);
  const hasExplicitParams = Boolean(paramsStr && paramsStr.trim().length > 0);

  // Wallet setup
  if (pkey && keyName) {
    throw new Error("Use either --privatekey OR --key, not both");
  }

  const privateKey = keyName ? getPrivateKey(keyName) : pkey;

  if (!privateKey) {
    throw new Error("Wallet Private key is required.");
  }

  const provider = new ethers.JsonRpcProvider(SEPOLIA_RPC);
  const wallet = new ethers.Wallet(privateKey, provider);

  // Interactive mode is only for the fully guided flow.
  // Passing --contract and/or --params should skip contract selection loop.
  const isInteractive = !hasExplicitContract && !hasExplicitParams;

  try {
    // INTERACTIVE MODE
    if (isInteractive) {
      const deployedContracts = new Set<string>();

      while (true) {
        const contractName = await selectContract(contractNames);
        const contract = contracts[contractName];

        if (deployedContracts.has(contractName)) {
          console.warn(`${contractName} already deployed`);
        }

        const abi = contract.abi;
        const bytecode = contract.evm?.bytecode?.object;

        if (!bytecode) {
          console.warn(`Skipping ${contractName}`);
          continue;
        }

        const constructorAbi = abi.find((x: any) => x.type === "constructor");
        const inputs = constructorAbi?.inputs || [];

        let params: any[] = [];

        if (inputs.length > 0) {
          params = await askConstructorParams(inputs);
        } else {
          console.log("No constructor params required");
        }

        spinnerStart(`Deploying ${contractName}...`);

        const factory = new ethers.ContractFactory(abi, bytecode, wallet);
        const deployed = await factory.deploy(...params);

        await deployed.waitForDeployment();
        const address = await deployed.getAddress();

        spinnerSucceed(`Deployed ${contractName}`);
        console.log(`📍 Address: ${address}`);

        deployedContracts.add(contractName);

        const { again } = await import("inquirer").then((i) =>
          i.default.prompt([
            {
              type: "confirm",
              name: "again",
              message: "Deploy another contract?",
              default: false,
            },
          ]),
        );

        if (!again) break;
      }
    }

    // QUICK MODE (--contract and/or --params)
    else {
      let params: any[] = hasExplicitParams ? parseParams(paramsStr) : [];

      let selectedContractName: string;

      if (contractNameArg) {
        if (!contracts[contractNameArg]) {
          throw new Error(`Contract "${contractNameArg}" not found`);
        }
        selectedContractName = contractNameArg;
      } else {
        if (contractNames.length > 1) {
          throw new Error(
            "Multiple contracts found. Use --contract to specify one.",
          );
        }
        selectedContractName = contractNames[0];
      }

      const contract = contracts[selectedContractName];
      if (!contract) {
        throw new Error(`Contract "${selectedContractName}" not found`);
      }

      const abi = contract.abi;
      const bytecode = contract.evm?.bytecode?.object;

      if (!bytecode) {
        throw new Error(`Contract "${selectedContractName}" has no deployable bytecode`);
      }

      const constructorAbi = abi.find((x: any) => x.type === "constructor");
      const inputs = constructorAbi?.inputs || [];
      const expected = inputs.length;

      if (hasExplicitParams) {
        if (params.length !== expected) {
          throw new Error(`Expected ${expected} params, got ${params.length}`);
        }
      } else if (expected > 0) {
        params = await askConstructorParams(inputs);
      } else {
        console.log("No constructor params required");
      }

      spinnerStart(`Deploying ${selectedContractName}...`);

      const factory = new ethers.ContractFactory(abi, bytecode, wallet);
      const deployed = await factory.deploy(...params);

      await deployed.waitForDeployment();
      const address = await deployed.getAddress();

      spinnerSucceed(`Deployed ${selectedContractName}`);
      console.log(`Address: ${address}`);
    }
  } catch (err) {
    spinnerFailed("Deployment failed");
    throw err;
  }
}
