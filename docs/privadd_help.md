# privadd command help

The `privadd` command stores a private key under a name so you can deploy without passing the raw key each time.

## Usage

```bash
clm privadd --name <name> --value <value> [--password <value>]
```

## Options

- `--name <name>` (required): alias used to store and retrieve the private key
- `--value <value>` (required): raw private key string
- `--password <value>` (optional): password used to derive the encryption key

## What this command does

1. Creates a `.clm` directory in the current working directory if it does not exist.
2. Loads `.clm/keys.json` if present.
3. Derives an encryption key from your password using `scrypt`.
4. Encrypts the given private key using AES-256-GCM.
5. Saves encrypted output under the provided key name.

## File locations

- Key store file: `.clm/keys.json`
- Command implementation: `src/privadd.ts`
- Encryption helpers: `src/utils/hashing.ts`

## Encryption notes

- No encryption key is stored in files or `.env`.
- You must use the same password later when decrypting a saved key.
- Stored object format:

```json
{
  "address1": {
    "version": 1,
    "kdf": "scrypt",
    "cipher": "aes-256-gcm",
    "salt": "<hex>",
    "iv": "<hex>",
    "authTag": "<hex>",
    "encrypted": "<hex>"
  }
}
```

## Examples

Save a key:

```bash
clm privadd --name address1 --value 0xyourprivatekey
```

Save a key with explicit password (non-interactive):

```bash
clm privadd --name address1 --value 0xyourprivatekey --password mypass
```

Expected output:

```text
Private key saved as "address1"
```

## Troubleshooting

1. Key not found later during deploy
   - Check the exact `--name` used when adding the key.
2. Decryption fails after it worked before
  - Verify the same password is being used.