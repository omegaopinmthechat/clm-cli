# CLM CLI Documentation

This document describes every command currently available in the `clm` CLI.

## Overview

- CLI name: `clm`
- Current version: `0.0.1`
- Entry point: `src/index.ts`
- Primary workflows:
  - Save encrypted private keys locally
  - Compile and deploy a Solidity contract

## Global Usage

```bash
clm [options] [command]
```

Global options:

- `-V, --version`: prints CLI version
- `-h, --help`: prints help

## Commands Summary

- `clm privadd --name <name> --value <value>`
- `clm deploy [options] <file>`

---

## Command: `privadd`

Add and save a private key under a custom name.

Usage:

```bash
clm privadd --name <name> --value <value>
```

Options:

- `--name <name>` (required): alias used to store and retrieve the private key
- `--value <value>` (required): raw private key value

What it does:

1. Creates a local `.clm` folder in the current working directory if it does not exist.
2. Reads `.clm/keys.json` if present.
3. Encrypts the private key using AES-256-CBC.
4. Stores encrypted data under the provided key name.

Storage path:

- `.clm/keys.json` (relative to the directory where you run the command)

Encryption details:

- Encryption helper: `src/utils/hashing.ts`
- Key derivation: SHA-256 hash of `SECRET` from `.env`
- Stored object shape per key name:

```json
{
  "myKey": {
    "iv": "...",
    "encrypted": "..."
  }
}
```

Example:

```bash
clm privadd --name address1 --value 0xyourprivatekey
```

Expected output:

- `Private key saved as "address1"`

---

## Command: `deploy`

Compile and deploy a Solidity contract.

Usage:

```bash
clm deploy [options] <file>
```

Arguments:

- `<file>` (required): path to Solidity contract file

Options:

- `--network <network>`: target network name, default is `sepolia`
- `--key <name>`: name of a saved key in `.clm/keys.json`
- `--privatekey <value>`: raw private key value

Private key source precedence:

1. If `--key` is provided, CLI loads and decrypts that saved key.
2. Otherwise it uses `--privatekey`.

If neither is provided, command throws:

- `Private key is required. Provide --privatekey <value> or --key <name>`

What it does:

1. Reads and compiles the Solidity file with `solc`.
2. Extracts ABI and bytecode.
3. Connects to Sepolia RPC via `SEPOLIA_RPC` from `.env`.
4. Creates wallet from the selected private key.
5. Deploys contract with `ethers.ContractFactory`.
6. Waits for deployment and prints deployed address.

Important implementation note:

- `--network` is accepted by CLI, but current implementation always uses `SEPOLIA_RPC` from `.env`.

Examples:

Deploy using saved key:

```bash
clm deploy contract/myContract.sol --key address1
```

Deploy using raw private key:

```bash
clm deploy contract/myContract.sol --privatekey 0xyourprivatekey
```

Example output:

- `Deploying contract`
- `<ContractName> deployed at: 0x...`

---

## Environment Variables

Required in `.env`:

- `SEPOLIA_RPC`: RPC URL used by deploy
- `SECRET`: encryption secret used for key storage

If `SECRET` changes after keys are stored, existing saved keys may fail to decrypt.

---

## Compiler Behavior

The deploy flow compiles the contract via `src/compile.ts` using Solidity standard JSON input with `outputSelection`.

Compiler error handling:

- Solidity warnings/errors are printed from `output.errors`
- Any error-level diagnostic fails the command
- Missing contracts or empty bytecode also fail the command

---

## Troubleshooting

1. `No keys stored`
   - Run `privadd` first to create `.clm/keys.json`.

2. `Key "<name>" not found`
   - Use a valid name passed earlier to `--name` in `privadd`.

3. `Compilation failed. Check Solidity errors above.`
   - Fix Solidity syntax/compile errors shown in output.

4. Deployment fails with RPC/wallet errors
   - Verify `SEPOLIA_RPC`, private key format, account balance, and network reachability.