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
- `--dev`: deploy to a local persistent dev chain at `http://127.0.0.1:8545` (no private key required)
- `--prod`: deploy a production build with `console.log(...)` and `console.sol` imports stripped from publish output only
- `-k, --key <name>`: name of saved key in `.clm/keys.json`
- `--privatekey <value>`: raw private key
- `--password <value>`: password for decrypting saved key from `--key`
- `-p, --params <params>`: constructor params (comma-separated)
- `-c, --contract <name>`: explicit contract name to deploy

Validation rules:

- `--dev` and `--prod` are mutually exclusive.
- Passing both `--key` and `--privatekey` throws an error.

## Private key source precedence (default and `--prod`)

1. If `--key` is provided, the CLI decrypts and uses that saved key (prompts for password if `--password` is omitted).
2. Otherwise it uses `--privatekey`.

Validation rules:

- If no private key source is provided, deploy throws an error.
- In `--dev` mode, wallet flags are ignored and a signer from the local dev chain is used.

## What this command does

1. Compiles the Solidity file with `solc`.
2. If `--prod` is set, strips `console.log(...)` and matching `console.sol` import lines only in the compiled deployment source.
3. Resolves signer from mode:
   - `--dev`: local dev chain signer (`127.0.0.1:8545`)
   - default/`--prod`: wallet from `--key` or `--privatekey` on configured Sepolia RPC (`.clm/rpc.json`)
4. Chooses deploy mode based on provided options.
5. Deploys using `ethers.ContractFactory`.
6. Waits for deployment and prints deployed address.
7. Stores deployed address into `artifacts/<ContractName>.json`:
   - `address`: last deployed address (backward compatibility)
   - `addresses.<networkKey>`: network-specific address (`dev` or `sepolia`)

## Deploy modes

Environment mode:

- `--dev`: runs deployment against a local persistent Ganache RPC (`127.0.0.1:8545`).
- `--prod`: deploys a sanitized publish build without `console.log` calls/imports.
- default (no flag): deploys source as-is.

## Why `console.log(...)` Works On Sepolia

- In this project, `console.log(...)` comes from the custom `console.sol` library and emits Solidity events (for example `LogString`), not a chain-specific debug opcode.
- Because events are normal EVM behavior, they work on Sepolia when you deploy without `--prod`.
- The `call` command reads transaction receipt logs and decodes those events, which is why the printed value appears in CLI output.
- If you deploy with `--prod`, console imports/calls are stripped before compilation, so those log events are not present in the deployed contract.

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
  - If `--contract` is omitted and multiple contracts exist, throws `Multiple contracts found. Use --contract to specify one.`
  - If constructor params are provided with `--params`, validates count.
  - If constructor params are required and `--params` is omitted, prompts once for params.

## Constructor params format (`--params`)

- Input is comma-separated: `"hello",42,true`
- Parser behavior:
   - Numeric values become numbers
   - `true`/`false` become booleans
   - Double-quoted values become strings

## Important behavior notes

- `--network sepolia` uses the RPC configured via `clm addrpc`.
- Saved keys must exist in `.clm/keys.json` and be decryptable with the same password used during `privadd`.
- `--contract` is honored directly and skips the contract selection loop.
- `--prod` stripping happens only in-memory for compilation and does not modify your Solidity source files.
- In `--dev` mode, the CLI ensures a local Ganache RPC is running and reuses it for future `--dev` calls.
- In `--dev` mode, contracts are compiled with an EVM-compatible target for local Ganache execution.
- If you want `console.log(...)` events on testnet, deploy without `--prod`.

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

Deploy with saved key and explicit password:

```bash
clm deploy contract/myContract.sol --key address1 --password mypass
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

Deploy to local dev chain:

```bash
clm deploy contract/withParams.sol --dev -c CounterLab -p 5
```

Deploy production build with console logging stripped for publish output:

```bash
clm deploy contract/myContract.sol --prod -k address1 -c MyContract
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
3. Wrong password for saved key
   - Re-run with the correct `--password` or enter it when prompted.
4. Contract not found
   - Verify exact contract name passed in `--contract`.
5. Param mismatch
   - Make sure `--params` count matches constructor argument count.
6. Compilation failed
   - Fix Solidity errors printed in the terminal output.
7. RPC/wallet errors
   - Verify `clm addrpc -n sepolia` has been set, and check private key format, balance, and RPC access.
8. `--dev` deploy works but `call` cannot find contract
   - Ensure deploy and call target the same network (`--dev` for local chain, default for sepolia).
9. `console.log(...)` does not print
   - Ensure contract was not deployed with `--prod` and that the call targets the same network used during deploy.