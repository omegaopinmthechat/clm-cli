# deploy command help

The `deploy` command compiles a Solidity contract and deploys it using `ethers`.

## Usage

```bash
clm deploy [options] <file>
```

## Arguments

- `<file>` (required): path to the Solidity contract file

## Options

- `-n, --network <network>`: network label (default: `sepolia`)
- `-k, --key <name>`: name of saved key in `.clm/keys.json`
- `--privatekey <value>`: raw private key
- `-p, --params <params>`: constructor params (comma-separated)
- `-c, --contract <name>`: explicit contract name to deploy

## Private key source precedence

1. If `--key` is provided, the CLI decrypts and uses that saved key.
2. Otherwise it uses `--privatekey`.

Validation rules:

- Passing both `--key` and `--privatekey` throws an error.
- If no private key source is provided, deploy throws an error.

## What this command does

1. Compiles the Solidity file with `solc`.
2. Resolves wallet from either saved key (`--key`) or raw key (`--privatekey`).
3. Builds provider with `SEPOLIA_RPC`.
4. Chooses deploy mode based on provided options.
5. Deploys using `ethers.ContractFactory`.
6. Waits for deployment and prints deployed address.

## Deploy modes

Guided mode:

- Trigger: no `--contract` and no `--params`
- Behavior:
   - Shows an interactive contract picker from compiled contracts.
   - Prompts constructor params when required.
   - After each deploy, asks if you want to deploy another contract.

Targeted mode:

- Trigger: `--contract` and/or `--params` is provided
- Behavior:
   - Uses `--contract` if provided.
   - If `--contract` is omitted and multiple contracts exist, throws:
      - `Multiple contracts found. Use --contract to specify one.`
   - If constructor params are provided with `--params`, validates count.
   - If constructor params are required and `--params` is omitted, prompts once for params.

## Constructor params format (`--params`)

- Input is comma-separated: `"hello",42,true`
- Parser behavior:
   - Numeric values become numbers
   - `true`/`false` become booleans
   - Double-quoted values become strings

## Important behavior notes

- Current implementation accepts `--network` but always uses `SEPOLIA_RPC` from `.env`.
- Saved keys must exist in `.clm/keys.json` and be decryptable with the same `SECRET` used when they were stored.
- `--contract` is now honored directly and skips the contract selection loop.

## File locations

- Command registration: `src/index.ts`
- Deploy implementation: `src/deploy.ts`
- Compile implementation: `src/compile.ts`
- Key lookup: `src/keyManager.ts`
- Constructor parser: `src/utils/parser.ts`
- Interactive prompts: `src/utils/contract.inquirer.ts`

## Examples

Deploy with saved key:

```bash
clm deploy contract/myContract.sol --key address1
```

Deploy with raw key:

```bash
clm deploy contract/myContract.sol --privatekey 0xyourprivatekey
```

Deploy a specific contract from a multi-contract file:

```bash
clm deploy contract/paramsAndVoting.sol -k address1 -c Voting
```

Deploy with constructor params inline:

```bash
clm deploy contract/withParams.sol -k address1 -c WithParams -p 42,true,"hello"
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
3. Contract not found
   - Verify exact contract name passed in `--contract`.
4. Param mismatch
   - Make sure `--params` count matches constructor argument count.
5. Compilation failed
   - Fix Solidity errors printed in the terminal output.
6. RPC/wallet errors
   - Verify `SEPOLIA_RPC`, private key format, balance, and RPC access.