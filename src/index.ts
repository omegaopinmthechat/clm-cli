#!/usr/bin/env node
import { readFileSync } from "fs";
import { resolve } from "path";
import { Command } from "commander";
import { deploy } from "./deploy";
import { addPrivateKey } from "./privadd";
import { compile } from "./compile";
import chokidar from "chokidar";
import { callContract } from "./call";
import { initProject } from "./init";
import { addRpcConfig } from "./config/rpc";

const program = new Command();

const cliVersion = (() => {
  try {
    const packageJsonPath = resolve(__dirname, "..", "package.json");
    const packageJson = JSON.parse(readFileSync(packageJsonPath, "utf8"));

    if (typeof packageJson.version === "string") {
      return packageJson.version;
    }
  } catch {
    // Fall back to default version.
  }

  return "0.0.0";
})();

// initialization
program.name("clm").description("CLM SMART CONTRACT CLI").version(cliVersion);

// This is for adding private keys
program
  .command("privadd")
  .requiredOption("-a, --name <name>", "key name")
  .requiredOption("-v, --value <value>", "private key")
  .requiredOption("--password <value>", "Password used to encrypt saved key")
  .action(async (options) => {
    try {
      const password = options.password;

      if (!password || !password.trim()) {
        throw new Error("Password cannot be empty or whitespace only");
      }
      addPrivateKey(options.name, options.value, password);
    } catch (err) {
      console.log("Error", err);
    }
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

// Add RPC configuration
program
  .command("addrpc")
  .description("Configure network RPC (currently supports sepolia via Alchemy)")
  .option("-n, --network <network>", "Network name", "sepolia")
  .option("--apikey <value>", "Alchemy API key (optional; prompts if omitted)")
  .action(async (options) => {
    try {
      await addRpcConfig(options.network, options.apikey);
    } catch (err) {
      console.log("Error", err);
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
  .option("--password <value>", "Password for decrypting saved key")
  .action(async (contract, func, args, options) => {
    try {
      await callContract(contract, func, args, {
        mode: options.dev ? "dev" : "default",
        network: options.network,
        pkey: options.privatekey,
        keyName: options.key,
        keyPassword: options.password,
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
  .option("--password <value>", "Password for decrypting saved key")
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
        options.password,
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