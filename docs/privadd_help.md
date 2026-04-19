# privadd command help

The `privadd` command stores a private key under a name so you can deploy without passing the raw key each time.

## Usage

```bash
clm privadd --name <name> --value <value>
```

## Options

- `--name <name>` (required): alias used to store and retrieve the private key
- `--value <value>` (required): raw private key string

## What this command does

1. Creates a `.clm` directory in the current working directory if it does not exist.
2. Loads `.clm/keys.json` if present.
3. Encrypts the given private key using AES-256-CBC.
4. Saves encrypted output under the provided key name.

## File locations

- Key store file: `.clm/keys.json`
- Command implementation: `src/privadd.ts`
- Encryption helpers: `src/utils/hashing.ts`

## Encryption notes

- Encryption/decryption key is derived from `SECRET` in `.env`.
- If `SECRET` changes later, previously stored keys may fail to decrypt.
- Stored object format:

```json
{
  "address1": {
    "iv": "<hex>",
    "encrypted": "<hex>"
  }
}
```

## Examples

Save a key:

```bash
clm privadd --name address1 --value 0xyourprivatekey
```

Expected output:

```text
Private key saved as "address1"
```

## Troubleshooting

1. Key not found later during deploy
   - Check the exact `--name` used when adding the key.
2. Decryption fails after it worked before
   - Verify `SECRET` in `.env` has not changed.