export function encKey(): string {
  return process.env.ENCRYPTION_KEY ?? "tracker_enc_default";
}

// SELECT fragment: CAST(AES_DECRYPT(UNHEX(col), ?) AS CHAR) AS alias
export function dec(col: string, alias?: string): string {
  return `CAST(AES_DECRYPT(UNHEX(${col}), ?) AS CHAR) AS ${alias ?? col.replace(/\w+\./, "")}`;
}

// INSERT/UPDATE fragment: HEX(AES_ENCRYPT(?, ?))
export const ENC = "HEX(AES_ENCRYPT(?, ?))";
