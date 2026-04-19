import crypto from "crypto";
import { SECRET } from "../config/env";

const ALGO = "aes-256-cbc";

export function encrypt(text: string) {
  const iv = crypto.randomBytes(16);
  const key = crypto.createHash("sha256").update(SECRET).digest();

  const cipher = crypto.createCipheriv(ALGO, key, iv);

  let encrypted = cipher.update(text, "utf8", "hex");
  encrypted += cipher.final("hex");

  return {
    iv: iv.toString("hex"),
    encrypted,
  };
}

export function decrypt(encryptedData: string, ivHex: string) {
  const key = crypto.createHash("sha256").update(SECRET).digest();
  const iv = Buffer.from(ivHex, "hex");

  const decipher = crypto.createDecipheriv(ALGO, key, iv);

  let decrypted = decipher.update(encryptedData, "hex", "utf8");
  decrypted += decipher.final("utf8");

  return decrypted;
}
