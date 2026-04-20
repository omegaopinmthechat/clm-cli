# call command help

The `call` command executes a contract function using ABI and address from an artifact, then prints transaction logs.

## Usage

```bash
clm call <contract> <function> [args...] [options]
```

## Arguments

- `<contract>` (required): contract name, used to locate `artifacts/<contract>.json`
- `<function>` (required): function name to execute
- `[args...]` (optional): function arguments passed in order

## Options

- `-n, --network <network>`: network label (default: `sepolia`)
- `--dev`: call on local persistent dev chain (`http://127.0.0.1:8545`)
- `-k, --key <name>`: saved key name from `.clm/keys.json`
- `--privatekey <value>`: raw private key
- `--password <value>`: password for decrypting saved key from `--key`

## Validation rules

- Use either `--key` or `--privatekey`, not both.
- In default mode, a private key source is required.
- In `--dev` mode, private key is optional (uses local unlocked account when omitted).
- Artifact file `artifacts/<contract>.json` must exist.
- Artifact must include `abi` and at least one address (`address` or `addresses.<networkKey>`).

## What this command does

1. Resolves call mode and provider:
   - default mode: configured Sepolia RPC from `.clm/rpc.json`
   - `--dev`: local persistent RPC (`127.0.0.1:8545`)
2. Resolves signer:
   - default mode: from saved key or raw private key
   - `--dev`: from provided key/private key, or local unlocked account if omitted
   - if `--key` is used and `--password` is omitted, prompts for password
3. Loads ABI and network-matching address from artifact file.
4. Sends the function transaction with provided arguments.
5. Waits for receipt.
6. Attempts to decode and print emitted logs using the contract ABI.

## Artifact requirement

The deploy command writes addresses to artifacts, which `call` depends on.

Expected artifact fields:

```json
{
  "contractName": "MyContract",
  "abi": [],
  "bytecode": "...",
   "address": "0x...",
   "addresses": {
      "dev": "0x...",
      "sepolia": "0x..."
   }
}
```

## File locations

- Command registration: `src/index.ts`
- Call implementation: `src/call.ts`
- Key lookup: `src/keyManager.ts`

## Examples

Call using saved key:

```bash
clm call MyContract setMessage "hello" --key address1
```

Call using saved key with explicit password:

```bash
clm call MyContract setMessage "hello" --key address1 --password mypass
```

Call using raw private key:

```bash
clm call MyContract setMessage "hello" --privatekey 0xyourprivatekey
```

Call on local dev chain with unlocked local signer:

```bash
clm call MyContract setMessage "hello" --dev
```

Call on local dev chain with explicit key:

```bash
clm call MyContract setMessage "hello" --dev --key address1
```

## Troubleshooting

1. Artifact not found
   - Compile/deploy first so `artifacts/<contract>.json` exists.
2. Contract address not found
   - Deploy the contract so artifact gets an address for the target network.
3. Wrong password for saved key
   - Re-run with the correct `--password` or enter it when prompted.
4. Revert or RPC failure
   - Verify network RPC, deployed address, signer balance, and function arguments.
5. No contract code at address
   - Deploy and call on the same network (`--dev` for local chain, default for sepolia).
6. RPC not configured
   - Run `clm addrpc -n sepolia` before calling on sepolia.
