# deploy command help

The `deploy` command compiles a Solidity contract and deploys it using `ethers`.

## Usage

```bash
clm deploy [options] <file>
```

## Arguments

- `<file>` (required): path to the Solidity contract file

## Options

- `--network <network>`: network label (default: `sepolia`)
- `--key <name>`: name of saved key in `.clm/keys.json`
- `--privatekey <value>`: raw private key

## Private key source precedence

1. If `--key` is provided, the CLI decrypts and uses that saved key.
2. Otherwise it uses `--privatekey`.

If no private key source is provided, deploy throws an error.

## What this command does

1. Compiles the Solidity file with `solc`.
2. Extracts ABI and bytecode.
3. Builds provider with `SEPOLIA_RPC`.
4. Creates an `ethers` wallet from selected private key.
5. Deploys using `ethers.ContractFactory`.
6. Waits for deployment and prints deployed address.

## Important behavior notes

- Current implementation accepts `--network` but always uses `SEPOLIA_RPC` from `.env`.
- Saved keys must exist in `.clm/keys.json` and be decryptable with the same `SECRET` used when they were stored.

## File locations

- Command registration: `src/index.ts`
- Deploy implementation: `src/deploy.ts`
- Compile implementation: `src/compile.ts`
- Key lookup: `src/keyManager.ts`

## Examples

Deploy with saved key:

```bash
clm deploy contract/myContract.sol --key address1
```

Deploy with raw key:

```bash
clm deploy contract/myContract.sol --privatekey 0xyourprivatekey
```

Typical output:

```text
Deploying contract
MyContract deployed at: 0x...
```

## Troubleshooting

1. No keys stored
   - Run `clm privadd --name <name> --value <value>` first.
2. Key not found
   - Verify the exact key name used with `--key`.
3. Compilation failed
   - Fix Solidity errors printed in the terminal output.
4. RPC/wallet errors
   - Verify `SEPOLIA_RPC`, private key format, balance, and RPC access.