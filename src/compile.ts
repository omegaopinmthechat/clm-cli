import fs from "fs";
import solc from "solc";
import path from "path";

export function compile(contractPath: string){
    const fileName = path.basename(contractPath);
    const source = fs.readFileSync(contractPath, "utf-8");

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
    }; // end of input

    const output = JSON.parse(solc.compile(JSON.stringify(input)));

    if (output.errors) {
        for (const err of output.errors) {
          console.error(err.formattedMessage);
        }
        if (output.errors.some((err: { severity?: string }) => err.severity === "error")) {
          throw new Error("Compilation failed. Check Solidity errors above.");
        }
    }
    if (!output.contracts || !output.contracts[fileName]) {
      throw new Error("Compilation failed. No contracts were generated.");
    }


    const contractName = Object.keys(output.contracts[fileName])[0];
    const contract = output.contracts[fileName][contractName];

    const abi = contract.abi;
    const bytecode = contract.evm.bytecode.object;

    if (!bytecode) {
      throw new Error("Compilation failed. Bytecode is empty.");
    }

    return { abi, bytecode, contractName};


}