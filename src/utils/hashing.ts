import crypto from "crypto";

const CIPHER = "aes-256-gcm";
const KEY_LENGTH = 32;
const SALT_LENGTH = 16;
const IV_LENGTH = 12;

export interface EncryptedPayload {
  version: 1;
  kdf: "scrypt";
  cipher: "aes-256-gcm";
  salt: string;
  iv: string;
  authTag: string;
  encrypted: string;
}

function ensurePassword(password: string): void {
  if (!password || password.trim().length === 0) {
    throw new Error("Password is required.");
  }
}

function deriveKey(password: string, saltHex: string): Buffer {
  return crypto.scryptSync(password, Buffer.from(saltHex, "hex"), KEY_LENGTH);
}

function isEncryptedPayload(value: unknown): value is EncryptedPayload {
  if (!value || typeof value !== "object") {
    return false;
  }

  const payload = value as Record<string, unknown>;

  return (
    payload.version === 1
    && payload.kdf === "scrypt"
    && payload.cipher === "aes-256-gcm"
    && typeof payload.salt === "string"
    && typeof payload.iv === "string"
    && typeof payload.authTag === "string"
    && typeof payload.encrypted === "string"
  );
}

export function encrypt(text: string, password: string): EncryptedPayload {
  ensurePassword(password);

  const salt = crypto.randomBytes(SALT_LENGTH).toString("hex");
  const iv = crypto.randomBytes(IV_LENGTH).toString("hex");
  const key = deriveKey(password, salt);

  const cipher = crypto.createCipheriv(
    CIPHER,
    key,
    Buffer.from(iv, "hex"),
  );

  const encrypted = Buffer.concat([
    cipher.update(text, "utf8"),
    cipher.final(),
  ]).toString("hex");

  return {
    version: 1,
    kdf: "scrypt",
    cipher: "aes-256-gcm",
    salt,
    iv,
    authTag: cipher.getAuthTag().toString("hex"),
    encrypted,
  };
}

export function decrypt(payload: unknown, password: string): string {
  ensurePassword(password);

  if (!isEncryptedPayload(payload)) {
    throw new Error(
      "Saved key uses a legacy format. Re-save it with clm privadd using a password.",
    );
  }

  const key = deriveKey(password, payload.salt);

  try {
    const decipher = crypto.createDecipheriv(
      CIPHER,
      key,
      Buffer.from(payload.iv, "hex"),
    );
    decipher.setAuthTag(Buffer.from(payload.authTag, "hex"));

    const decrypted = Buffer.concat([
      decipher.update(Buffer.from(payload.encrypted, "hex")),
      decipher.final(),
    ]).toString("utf8");

    return decrypted;
  } catch {
    throw new Error("Failed to decrypt saved key. Check your password.");
  }
}
