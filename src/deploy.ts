import { ethers } from "ethers";
import { SEPOLIA_RPC } from "./config/env";
import { compile } from "./compile";
import { getPrivateKey } from "./keyManager";
import { spinnerStart, spinnerSucceed } from "./utils/ora.spinner";

// For now we will be using sepolia rpc so the network tha is passed is not used
export async function deploy(contractPath: string, network: string, pkey?:string, keyName?: string){
    const { abi, bytecode, contractName} = compile(contractPath);
    let privateKey: string | undefined;
    if (keyName){
        privateKey = getPrivateKey(keyName);
    }else{
        privateKey = pkey;
    }
    if (!privateKey) {
      throw new Error("Wallet Private key is required. Provide --privatekey or --keyName");
    }

    const provider = new ethers.JsonRpcProvider(SEPOLIA_RPC);
    const wallet = new ethers.Wallet(privateKey, provider)

    spinnerStart("I will change this later")

    const factory = new ethers.ContractFactory(abi, bytecode, wallet);
    const contract = await factory.deploy();
    await contract.waitForDeployment();

    const address = await contract.getAddress();

    console.log(`${contractName} deployed at: ${address}`);


}