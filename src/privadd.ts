// This saves the address locally
import { spawnSync } from "child_process";
import fs from "fs";
import path from "path";
import { encrypt } from "./utils/hashing";

const CLM_DIR = path.join(process.cwd(), ".clm");
const KEY_FILE = path.join(CLM_DIR, "keys.json");

function hideDirOnWindows(dirPath: string): void {
  if (process.platform !== "win32") {
    return;
  }

  try {
    // Best-effort: hide the folder in File Explorer on Windows.
    spawnSync("attrib", ["+h", dirPath], { stdio: "ignore", windowsHide: true });
  } catch {
    // Ignore failures and continue to keep key storage functional.
  }
}

export function addPrivateKey(name: string, value: string, password: string) {
  if (!fs.existsSync(CLM_DIR)) {
    fs.mkdirSync(CLM_DIR, { recursive: true });
  }

  hideDirOnWindows(CLM_DIR);

  let data: any = {};

  if (fs.existsSync(KEY_FILE)) {
    data = JSON.parse(fs.readFileSync(KEY_FILE, "utf-8"));
  }

  const encrypted = encrypt(value, password);

  data[name] = encrypted;

  fs.writeFileSync(KEY_FILE, JSON.stringify(data, null, 2));

  console.log(`Private key saved as "${name}"`);
}
