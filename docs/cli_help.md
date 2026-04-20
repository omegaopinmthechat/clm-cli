# CLM CLI Documentation

This is the top-level help page for the CLM CLI.

## Global usage

```bash
clm [options] [command]
```

Global options:

- `-V, --version` output the version number
- `-h, --help` display help for command

## Command docs

- [privadd_help.md](./privadd_help.md)
- [addrpc_help.md](./addrpc_help.md)
- [deploy_help.md](./deploy_help.md)
- [compile_help.md](./compile_help.md)
- [call_help.md](./call_help.md)

## Additional docs

- [artifacts_help.md](./artifacts_help.md)

## Quick summary

- `clm privadd --name <name> --value <value> [--password <value>]`- `clm addrpc -n sepolia`
- `clm deploy [options] <file>`
- `clm compile [options] <file>`
- `clm call <contract> <function> [args...] [options]`