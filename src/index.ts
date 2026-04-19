#!/usr/bin/env node
import { Command } from "commander";
import { deploy } from "./deploy";
import { addPrivateKey } from "./privadd";

const program = new Command();

// initialization
program.name("clm").description("CLM SMART CONTRACT CLI").version("0.0.1");

// This is for adding private keys
program
  .command("privadd")
  .requiredOption("--name <name>", "key name")
  .requiredOption("--value <value>", "private key")
  .action((options) => {
    addPrivateKey(options.name, options.value);
  });

// This is depolyment bash keys
program
  .command("deploy")
  .argument("<file>", "Solidity file path")
  .option("--network <network>", "Network (sepolia)", "sepolia")
  .option("--key <name>", "Saved key name")
  .option("--privatekey <value>", "Raw private key") 
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

program.parse();