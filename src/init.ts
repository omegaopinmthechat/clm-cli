function printYellowClMBanner() {
  // ANSI yellow: \x1b[33m ... \x1b[0m
  const banner = `\x1b[33m
  00000000000000      00         0000       0000
  00000000000000      00         00000     00000
  0000                00         000 00   00 000
  0000                00         000  00 00  000
  0000                00         000   000   000
  0000                00         000    0    000
  00000000000000      00         000         000
  00000000000000      00         000         000
\x1b[0m`;
  console.log(banner);
}
import fs from "fs";
import path from "path";

const SCRIPTS_DIR = path.join(process.cwd(), "scripts");
const GITIGNORE_PATH = path.join(process.cwd(), ".gitignore");

const STARTER_CONTRACT_TARGET = path.join(SCRIPTS_DIR, "MyContract.sol");
const GITIGNORE_ENTRIES = ["artifacts/", ".clm", "node_modules/"];

const STARTER_CONTRACT_CONTENT = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "clm-cli/console.sol";

contract MyContract {
  string public message = "Hello CLM";

  function setMessage(string memory newMessage) public {
    console.log(newMessage);
    message = newMessage;
  }
}
`;

function ensureDirectory(dirPath: string): boolean {
  if (fs.existsSync(dirPath)) {
    return false;
  }

  fs.mkdirSync(dirPath, { recursive: true });
  return true;
}

function writeIfMissing(targetPath: string, content: string): boolean {
  if (fs.existsSync(targetPath)) {
    return false;
  }

  fs.writeFileSync(targetPath, content, "utf-8");
  return true;
}

function ensureGitignoreEntries(targetPath: string, entries: string[]) {
  const exists = fs.existsSync(targetPath);
  const existingLines = exists
    ? fs.readFileSync(targetPath, "utf-8").split(/\r?\n/)
    : [];

  const normalized = new Set(existingLines.map((line) => line.trim()));
  const added: string[] = [];

  for (const entry of entries) {
    if (!normalized.has(entry)) {
      existingLines.push(entry);
      normalized.add(entry);
      added.push(entry);
    }
  }

  if (!exists || added.length > 0) {
    let output = existingLines.join("\n");
    if (!output.endsWith("\n")) {
      output += "\n";
    }
    fs.writeFileSync(targetPath, output, "utf-8");
  }

  return {
    created: !exists,
    added,
  };
}

export function initProject() {
  const setupActions: string[] = [];

  if (ensureDirectory(SCRIPTS_DIR)) {
    setupActions.push("Created scripts/");
  }

  if (writeIfMissing(STARTER_CONTRACT_TARGET, STARTER_CONTRACT_CONTENT)) {
    setupActions.push("Created scripts/MyContract.sol");
  }

  const gitignoreStatus = ensureGitignoreEntries(
    GITIGNORE_PATH,
    GITIGNORE_ENTRIES,
  );

  if (gitignoreStatus.created) {
    setupActions.push("Created .gitignore");
  }

  if (gitignoreStatus.added.length > 0) {
    setupActions.push(
      `Updated .gitignore: ${gitignoreStatus.added.join(", ")}`,
    );
  }

  console.log("CLM project initialization complete.");

  if (setupActions.length === 0) {
    console.log("Nothing new was created. Existing project files were kept.");
  } else {
    for (const action of setupActions) {
      console.log(action);
    }
  }

  console.log(
    'Use import "clm-cli/console.sol" in your contracts to access console.log.',
  );

  printYellowClMBanner();
}

export const initproject = initProject;
