export type ThemeMode = "dark" | "light";
const COOKIE_NAME = "wjjw_theme";

export function getThemeCookie(): ThemeMode | null {
  const match = document.cookie
    .split("; ")
    .find((c) => c.startsWith(`${COOKIE_NAME}=`));
  if (!match) return null;

  const value = decodeURIComponent(match.split("=").slice(1).join("="));
  return value === "dark" || value === "light" ? value : null;
}

export function setThemeCookie(mode: ThemeMode) {
  const maxAge = 60 * 60 * 24 * 365;
  const host = window.location.hostname;
  const isProd = host.endsWith("williamjwhite.me");
  const domainPart = isProd ? "Domain=.williamjwhite.me; " : "";
  const securePart = window.location.protocol === "https:" ? "Secure; " : "";

  document.cookie = `${COOKIE_NAME}=${encodeURIComponent(
    mode
  )}; Path=/; ${domainPart}Max-Age=${maxAge}; SameSite=Lax; ${securePart}`.trim();
}
