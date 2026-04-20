# artifacts help

This page explains every component stored inside `artifacts/<ContractName>.json`.

## What an artifact is

An artifact is the JSON output used by this CLI to:

- deploy contracts (`abi` + `bytecode`)
- call contracts (`abi` + saved deployed address)
- track latest and historical deployed addresses per network

## Where artifacts are stored

Artifacts are written to:

- `artifacts/<ContractName>.json`

Example:

- `artifacts/MyContract.json`
- `artifacts/CounterLab.json`

## Artifact lifecycle

1. `clm compile ...`
   - Writes/updates compile data: `contractName`, `abi`, `bytecode`
  - Preserves existing deployment metadata if already present
  - Keeps or bootstraps `lastDeployedAbi` so deploy can compute ABI diffs
2. `clm deploy ...`
  - Updates address metadata (`addresses`, `address`, `network`, `lastDeployedAt`, `deploymentHistory`)
  - Appends ABI diff data to each history entry as `+abi` and `-abi`
  - Updates `lastDeployedAbi` to the latest deployed ABI

## Top-level fields

## 1) `contractName`

- Type: `string`
- Meaning: Solidity contract name in that artifact file.

Example:

```json
"contractName": "MyContract"
```

## 2) `abi`

- Type: `array`
- Meaning: Contract ABI (Application Binary Interface).
- Used by `ethers` to encode function calls and decode logs/events.

Each ABI item can represent:

- function
- event
- constructor

Common ABI item fields:

- `type`: `"function" | "event" | "constructor"`
- `name`: function/event name (constructors have no `name`)
- `inputs`: parameter list
- `outputs`: return list (functions)
- `stateMutability`: `view`, `pure`, `nonpayable`, `payable` (functions/constructor)
- `anonymous`: boolean (events only)

Input/output entries usually contain:

- `name`
- `type` (EVM type like `uint256`, `string`, `address`)
- `internalType` (Solidity type label)
- `indexed` (events only)

## 3) `bytecode`

- Type: `string`
- Meaning: Deployable contract bytecode (hex string).
- Used by `ethers.ContractFactory` during deploy.

Example:

```json
"bytecode": "6080604052..."
```

## 4) `addresses`

- Type: `object`
- Meaning: Latest deployed address per network key.

Typical network keys used by this CLI:

- `dev` (local Ganache chain)
- `sepolia` (testnet)

Example:

```json
"addresses": {
  "dev": "0x6f96dD3657B2bbA6E90b17a6CD5D657570A12cb4",
  "sepolia": "0x9a34686235451842341422e940ab3d87dF94d008"
}
```

## 5) `address`

- Type: `string`
- Meaning: Last deployed address overall (latest deployment regardless of network).
- Backward-compatible convenience field.

Example:

```json
"address": "0x9a34686235451842341422e940ab3d87dF94d008"
```

## 6) `network`

- Type: `string`
- Meaning: Network key of the latest deployment.

Example:

```json
"network": "sepolia"
```

## 7) `lastDeployedAt`

- Type: `string` (ISO timestamp)
- Meaning: Timestamp of the latest deployment saved in this artifact.

Example:

```json
"lastDeployedAt": "2026-04-20T06:41:24.142Z"
```

## 8) `deploymentHistory`

- Type: `array`
- Meaning: Append-only history of deployments.
- New entry is added on each deploy.

Each entry contains:

- `network`
- `address`
- `deployedAt`
- `+abi` (ABI entries that are newly added compared to the previously deployed ABI)
- `-abi` (ABI entries that existed before but are removed in the current deploy)

Example:

```json
"deploymentHistory": [
  {
    "network": "dev",
    "address": "0x82704F414CC99F46B565A44268e00b6aD1BbBc2b",
    "deployedAt": "2026-04-20T06:41:08.609Z",
    "+abi": [
      {
        "type": "function",
        "name": "setCount",
        "inputs": [
          { "internalType": "uint256", "name": "nextCount", "type": "uint256" }
        ],
        "outputs": [],
        "stateMutability": "nonpayable"
      }
    ],
    "-abi": []
  },
  {
    "network": "dev",
    "address": "0x6f96dD3657B2bbA6E90b17a6CD5D657570A12cb4",
    "deployedAt": "2026-04-20T06:41:24.142Z",
    "+abi": [],
    "-abi": [
      {
        "type": "function",
        "name": "oldFunction",
        "inputs": [],
        "outputs": [],
        "stateMutability": "nonpayable"
      }
    ]
  }
]
```

## 9) `lastDeployedAbi`

- Type: `array`
- Meaning: Snapshot of the ABI from the most recent deploy.
- Purpose: Used internally to compute ABI diffs for the next deploy.

Example:

```json
"lastDeployedAbi": [
  {
    "type": "function",
    "name": "setMessage",
    "inputs": [{ "name": "_msg", "type": "string" }],
    "outputs": [],
    "stateMutability": "nonpayable"
  }
]
```

## `addresses` vs `address` vs `network`

Given:

```json
"addresses": {
  "sepolia": "0x9a34686235451842341422e940ab3d87dF94d008"
},
"address": "0x9a34686235451842341422e940ab3d87dF94d008",
"network": "sepolia"
```

Meaning:

- `addresses.sepolia` is the latest known address specifically on Sepolia.
- `address` is the latest deployment address overall.
- `network` tells you which network that latest `address` belongs to.

If you deploy later on `dev`, then:

- `addresses.sepolia` stays unchanged
- `addresses.dev` is added/updated
- `address` switches to the new dev address
- `network` becomes `"dev"`

## Redeploy behavior (latest address saving)

Every time you redeploy a contract:

1. `addresses.<networkKey>` is overwritten with the newest address for that network
2. `address` is overwritten with newest overall address
3. `network` is overwritten with latest network key
4. `lastDeployedAt` is overwritten with current timestamp
5. `+abi` is filled with ABI entries newly added compared to the previous deployed ABI
6. `-abi` is filled with ABI entries removed compared to the previous deployed ABI
7. A new object is appended to `deploymentHistory` (including `+abi` and `-abi`)
8. `lastDeployedAbi` is updated to the current ABI

## Minimal examples

Compile-only artifact (before any deploy metadata exists):

```json
{
  "contractName": "MyContract",
  "abi": [
    { "type": "function", "name": "setMessage", "inputs": [{ "type": "string", "name": "_msg" }], "outputs": [], "stateMutability": "nonpayable" }
  ],
  "bytecode": "6080604052..."
}
```

Deployed artifact (after one or more deploys):

```json
{
  "contractName": "MyContract",
  "abi": [
    { "type": "event", "name": "LogString", "inputs": [{ "indexed": false, "name": "", "type": "string" }], "anonymous": false },
    { "type": "function", "name": "message", "inputs": [], "outputs": [{ "name": "", "type": "string" }], "stateMutability": "view" },
    { "type": "function", "name": "setMessage", "inputs": [{ "name": "_msg", "type": "string" }], "outputs": [], "stateMutability": "nonpayable" }
  ],
  "bytecode": "6080604052...",
  "addresses": {
    "dev": "0x6f96dD3657B2bbA6E90b17a6CD5D657570A12cb4",
    "sepolia": "0x9a34686235451842341422e940ab3d87dF94d008"
  },
  "address": "0x9a34686235451842341422e940ab3d87dF94d008",
  "network": "sepolia",
  "lastDeployedAt": "2026-04-20T06:41:24.142Z",
  "lastDeployedAbi": [
    { "type": "event", "name": "LogString", "inputs": [{ "indexed": false, "name": "", "type": "string" }], "anonymous": false },
    { "type": "function", "name": "message", "inputs": [], "outputs": [{ "name": "", "type": "string" }], "stateMutability": "view" },
    { "type": "function", "name": "setMessage", "inputs": [{ "name": "_msg", "type": "string" }], "outputs": [], "stateMutability": "nonpayable" }
  ],
  "deploymentHistory": [
    {
      "network": "dev",
      "address": "0x82704F414CC99F46B565A44268e00b6aD1BbBc2b",
      "deployedAt": "2026-04-20T06:41:08.609Z",
      "+abi": [
        { "type": "function", "name": "setMessage", "inputs": [{ "name": "_msg", "type": "string" }], "outputs": [], "stateMutability": "nonpayable" }
      ],
      "-abi": []
    },
    {
      "network": "dev",
      "address": "0x6f96dD3657B2bbA6E90b17a6CD5D657570A12cb4",
      "deployedAt": "2026-04-20T06:41:24.142Z",
      "+abi": [],
      "-abi": []
    }
  ]
}
```
