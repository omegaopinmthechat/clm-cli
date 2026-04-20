#!/usr/bin/env node
import { Command } from "commander";
import { deploy } from "./deploy";
import { addPrivateKey } from "./privadd";
import { compile } from "./compile";
import chokidar from "chokidar";
import { callContract } from "./call";
import { initProject } from "./init";

const program = new Command();

// initialization
program.name("clm").description("CLM SMART CONTRACT CLI").version("0.0.2");

// This is for adding private keys
program
  .command("privadd")
  .requiredOption("-a, --name <name>", "key name")
  .requiredOption("-v, --value <value>", "private key")
  .action((options) => {
    addPrivateKey(options.name, options.value);
  });

// Initialize project scaffold
program
  .command("init")
  .description("Initialize scripts/ with console.sol support")
  .action(() => {
    try {
      initProject();
    } catch (err) {
      console.error(err);
    }
  });

// Call : call the contract functions
program
  .command("call")
  .argument("<contract>", "Contract name")
  .argument("<function>", "Function name")
  .argument("[args...]", "Function arguments")
  .option("-n, --network <network>", "Network (sepolia)", "sepolia")
  .option("--dev", "Call on local persistent dev chain")
  .option("-k, --key <name>", "Saved key name")
  .option("--privatekey <value>", "Raw private key")
  .action(async (contract, func, args, options) => {
    try {
      await callContract(contract, func, args, {
        mode: options.dev ? "dev" : "default",
        network: options.network,
        pkey: options.privatekey,
        keyName: options.key,
      });
    } catch (err) {
      console.log("Error", err);
    }
  });

// This is depolyment bash keys
program
  .command("deploy")
  .argument("<file>", "Solidity file path")
  .option("-n, --network <network>", "Network (sepolia)", "sepolia")
  .option("--dev", "Deploy to an in-memory dev chain")
  .option(
    "--prod",
    "Deploy a production build that strips console.log and console imports",
  )
  .option("-k, --key <name>", "Saved key name")
  .option("--privatekey <value>", "Raw private key")
  .option("-p, --params <params>", "Constructor params (comma-separated)")
  .option("-c, --contract <name>", "Contract name")
  .action(async (file, options) => {
    try {
      if (options.dev && options.prod) {
        throw new Error("Use either --dev or --prod, not both");
      }

      if (options.key && options.privatekey) {
        throw new Error("Use either --key or --privatekey");
      }

      const mode = options.dev ? "dev" : options.prod ? "prod" : "default";

      await deploy(
        file,
        options.network,
        options.privatekey,
        options.key,
        options.params,
        options.contract,
        mode,
      );
    } catch (err) {
      console.log("Error", err);
    }
  });

  // added a watch that auto recompiles when the file is saved
program
  .command("compile")
  .argument("<file>", "Solidity file path")
  .option("-w, --watch", "Watch file for changes")
  .action((file, options) => {
    if (options.watch) {
      console.log("Watching for changes...");

      chokidar.watch(file).on("change", () => {
        console.clear();
        console.log("Recompiling...");
        try {
          compile(file);
        } catch (err) {
          console.error(err);
        }
      });
    } else {
      try {
        compile(file);
      } catch (err) {
        console.error(err);
      }
    }
  });


program.parse();