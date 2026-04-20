# CLM CLI Version 0.0.1 (Brief)

This document summarizes version 0.0.1 command usage with options and examples.

## Global usage

```bash
clm [options] [command]
```

Global options:

- `-V, --version` Show CLI version
- `-h, --help` Show help

## Commands summary

- `privadd`: save a private key by name
- `compile`: compile Solidity into artifacts
- `deploy`: deploy a compiled contract
- `call`: call a contract function

## 1) privadd

Save a private key in local key storage.

Syntax:

```bash
clm privadd -a <name> -v <private-key>
```

Options:

- `-a, --name <name>` Required. Key alias.
- `-v, --value <value>` Required. Raw private key.

Examples:

```bash
clm privadd --name address1 --value 0xabc123...
clm privadd -a deployer -v 0xabc123...
```

## 2) compile

Compile a Solidity file and write artifacts.

Syntax:

```bash
clm compile <file> [options]
```

Options:

- `-w, --watch` Recompile automatically when file changes.

Examples:

```bash
clm compile contract/myContract.sol
clm compile contract/myContract.sol --watch
```

## 3) deploy

Deploy contract bytecode from a Solidity file.

Syntax:

```bash
clm deploy <file> [options]
```

Options:

- `-n, --network <network>` Network name. Default: `sepolia`.
- `--dev` Deploy to local persistent dev chain.
- `--prod` Strip `console.log` and console imports before deploy build.
- `-k, --key <name>` Use a saved key name.
- `--privatekey <value>` Use raw private key.
- `-p, --params <params>` Constructor params as comma-separated values.
- `-c, --contract <name>` Choose contract when file has multiple contracts.

Rules:

- Use either `--dev` or `--prod` (not both).
- Use either `--key` or `--privatekey` (not both).
- If neither `--dev` nor `--prod` is provided, default mode is normal Sepolia flow.

Examples:

```bash
clm deploy contract/myContract.sol --key address1
clm deploy contract/withParams.sol --contract CounterLab --params 12 --dev
clm deploy contract/myContract.sol --prod --privatekey 0xabc123...
clm deploy contract/voting.sol --network sepolia --key address1
```

## 4) call

Call a function on a deployed contract using artifact ABI/address.

Syntax:

```bash
clm call <contract> <function> [args...] [options]
```

Options:

- `-n, --network <network>` Network name. Default: `sepolia`.
- `--dev` Call on local persistent dev chain.
- `-k, --key <name>` Use a saved key name.
- `--privatekey <value>` Use raw private key.

Notes:

- `view` and `pure` functions return result directly.
- state-changing functions send a transaction and print tx details/logs.

Examples:

```bash
clm call MyContract message
clm call MyContract setMessage "hello" --key address1
clm call MyContract setMessage "good boy" --dev -k address1
clm call CounterLab readCount --dev
```

## Release note

Version `0.0.1` closed the initial command set with compile, deploy, call, and key management workflows.
