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
  // share to all subdomains
  const domain = ".williamjwhite.me";
  const maxAge = 60 * 60 * 24 * 365; // 1 year

  // Secure requires https (which you have on GitHub Pages with custom domain)
  document.cookie = `${COOKIE_NAME}=${encodeURIComponent(
    mode
  )}; Path=/; Domain=${domain}; Max-Age=${maxAge}; SameSite=Lax; Secure`;
}

// export type ThemeMode = "dark" | "light";

// const COOKIE_NAME = "wjjw_theme";
// const COOKIE_DOMAIN = ".williamjwhite.me";

// export function getThemeCookie(): ThemeMode {
//   if (typeof document === "undefined") return "dark";

//   const match = document.cookie.match(
//     new RegExp(`(?:^|; )${COOKIE_NAME}=(dark|light)`)
//   );

//   return (match?.[1] as ThemeMode) ?? "dark";
// }

// export function setThemeCookie(theme: ThemeMode) {
//   if (typeof document === "undefined") return;

//   document.cookie = [
//     `${COOKIE_NAME}=${theme}`,
//     "Path=/",
//     `Domain=${COOKIE_DOMAIN}`,
//     "Max-Age=31536000",
//     "SameSite=Lax",
//     "Secure",
//   ].join("; ");
// }
