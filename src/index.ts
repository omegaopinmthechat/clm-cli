#!/usr/bin/env node
import { Command } from "commander";
import { deploy } from "./deploy";
import { addPrivateKey } from "./privadd";
import { compile } from "./compile";
import chokidar from "chokidar";

const program = new Command();

// initialization
program.name("clm").description("CLM SMART CONTRACT CLI").version("0.0.1");

// This is for adding private keys
program
  .command("privadd")
  .requiredOption("-a, --name <name>", "key name")
  .requiredOption("-v, --value <value>", "private key")
  .action((options) => {
    addPrivateKey(options.name, options.value);
  });

// This is depolyment bash keys
program
  .command("deploy")
  .argument("<file>", "Solidity file path")
  .option("-n, --network <network>", "Network (sepolia)", "sepolia")
  .option("-k, --key <name>", "Saved key name")
  .option("-p, --privatekey <value>", "Raw private key") 
  .action(async (file, options) => {
    try {
      await deploy(
        file,
        options.network,
        options.privatekey, 
        options.key, 
      );
    } catch (err) {
      console.log("Error", err);
    }
  });

  // added a watch that auto recompiles when the file is saved
program
  .command("compile")
  .argument("<file>", "Solidity file path")
  .option("--watch", "Watch file for changes")
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