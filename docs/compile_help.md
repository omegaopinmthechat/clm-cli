# compile command help

The `compile` command compiles a Solidity file and writes deployable artifacts.

## Usage

```bash
clm compile [options] <file>
```

## Arguments

- `<file>` (required): path to the Solidity file

## Options

- `-w, --watch`: watch file for changes and auto-compile on save

## What this command does

1. Reads the Solidity file.
2. Compiles with `solc` standard JSON input.
3. Resolves imports in this order:
   - Relative to the contract file location
   - Relative to workspace root (`process.cwd()`)
   - Relative to `node_modules`
4. Prints warnings, but fails on Solidity error diagnostics.
5. Writes deployable artifacts into `artifacts/`.

## Artifacts output

For each deployable contract, an artifact is created at:

- `artifacts/<ContractName>.json`

Artifact shape:

```json
{
  "contractName": "MyContract",
  "abi": [],
  "bytecode": "..."
}
```

Contracts with no deployable bytecode are skipped.

## Watch mode (`-w`)

When `--watch` is enabled:

1. CLI starts file watcher on the target file.
2. On each file change:
   - Console clears
   - `Recompiling...` is printed
   - Compile runs again
3. Process keeps running until you stop it (for example, `Ctrl + C`).

## File locations

- Command registration: `src/index.ts`
- Compile implementation: `src/compile.ts`
- Spinner utility: `src/utils/ora.spinner.ts`

## Examples

Compile once:

```bash
clm compile contract/voting.sol
```

Compile and watch:

```bash
clm compile contract/voting.sol --watch
```

## Troubleshooting

1. Compilation failed
   - Fix Solidity errors printed under the compile output.
2. Import file not found
   - Verify the import path and ensure the file exists in one of the supported lookup locations.
3. No artifacts generated for one contract
   - That contract likely has no deployable bytecode (for example, abstract/interface-style output).