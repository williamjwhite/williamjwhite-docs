export type ThemeMode = "dark" | "light";

const COOKIE_NAME = "wjjw_theme";
const COOKIE_DOMAIN = ".williamjwhite.me";

export function getThemeCookie(): ThemeMode {
  if (typeof document === "undefined") return "dark";

  const match = document.cookie.match(
    new RegExp(`(?:^|; )${COOKIE_NAME}=(dark|light)`)
  );

  return (match?.[1] as ThemeMode) ?? "dark";
}

export function setThemeCookie(theme: ThemeMode) {
  if (typeof document === "undefined") return;

  document.cookie = [
    `${COOKIE_NAME}=${theme}`,
    "Path=/",
    `Domain=${COOKIE_DOMAIN}`,
    "Max-Age=31536000",
    "SameSite=Lax",
    "Secure",
  ].join("; ");
}
