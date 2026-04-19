import dotenv from "dotenv";

dotenv.config();

const SEPOLIA_RPC: string = process.env.SEPOLIA_RPC as string;
const SECRET: string = process.env.SECRET as string;

export { SEPOLIA_RPC, SECRET };