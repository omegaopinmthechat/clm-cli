export function parseParams(paramStr?: string): any[] {
  if (!paramStr) return [];

  return paramStr.split(",").map((p) => {
    p = p.trim();

    // number
    if (!isNaN(Number(p))) return Number(p);

    // boolean
    if (p === "true") return true;
    if (p === "false") return false;

    // string (remove quotes)
    return p.replace(/^"(.*)"$/, "$1");
  });
}
