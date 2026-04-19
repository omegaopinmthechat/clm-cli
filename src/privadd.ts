// This saves the address locally
import fs from "fs";
import path from "path";
import { encrypt } from "./utils/hashing";

const CLM_DIR = path.join(process.cwd(), ".clm");
const KEY_FILE = path.join(CLM_DIR, "keys.json");

export function addPrivateKey(name: string, value: string) {
  if (!fs.existsSync(CLM_DIR)) {
    fs.mkdirSync(CLM_DIR);
  }

  let data: any = {};

  if (fs.existsSync(KEY_FILE)) {
    data = JSON.parse(fs.readFileSync(KEY_FILE, "utf-8"));
  }

  const encrypted = encrypt(value);

  data[name] = encrypted;

  fs.writeFileSync(KEY_FILE, JSON.stringify(data, null, 2));

  console.log(`Private key saved as "${name}"`);
}
