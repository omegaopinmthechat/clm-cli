import fs from "fs";
import path from "path";
import { decrypt } from "./utils/hashing";

const KEY_FILE = path.join(process.cwd(), ".clm", "keys.json");

export function getPrivateKey(name: string): string {
  if (!fs.existsSync(KEY_FILE)) {
    throw new Error("No keys stored");
  }

  const data = JSON.parse(fs.readFileSync(KEY_FILE, "utf-8"));

  if (!data[name]) {
    throw new Error(`Key "${name}" not found`);
  }

  return decrypt(data[name].encrypted, data[name].iv);
}
