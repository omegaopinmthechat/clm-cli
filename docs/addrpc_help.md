# addrpc command help

The `addrpc` command stores RPC endpoints in `.clm/rpc.json` so the CLI does not depend on `.env`.

## Usage

```bash
clm addrpc [options]
```

## Options

- `-n, --network <network>`: network name (currently supports `sepolia` only)
- `--apikey <value>`: Alchemy API key (optional; prompts if omitted)

## What this command does

1. Prompts for an Alchemy API key when `--apikey` is not provided.
2. Builds the Sepolia RPC URL as:
   - `https://eth-sepolia.g.alchemy.com/v2/<apikey>`
3. Stores the result at `.clm/rpc.json` under `networks.sepolia.rpcUrl`.

## Output file

- `.clm/rpc.json`

Example shape:

```json
{
  "networks": {
    "sepolia": {
      "provider": "alchemy",
      "rpcUrl": "https://eth-sepolia.g.alchemy.com/v2/yourApiKey",
      "updatedAt": "2026-04-20T00:00:00.000Z"
    }
  }
}
```

## Examples

Prompt for API key:

```bash
clm addrpc -n sepolia
```

Non-interactive setup:

```bash
clm addrpc -n sepolia --apikey yourAlchemyApiKey
```

## Troubleshooting

1. Network not supported
   - Only `sepolia` is implemented right now.
2. Deploy/call says RPC not configured
   - Run `clm addrpc -n sepolia` first.
