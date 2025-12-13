import React, { useEffect } from "react";
import { useColorMode } from "@docusaurus/theme-common";
import { getThemeCookie, setThemeCookie } from "@/lib/theme-cookie";

type Props = { children: React.ReactNode };

export default function Root({ children }: Props) {
  const { colorMode, setColorMode } = useColorMode();

  // 1) On first load: cookie -> docusaurus
  useEffect(() => {
    const cookieTheme = getThemeCookie(); // "dark" | "light" | null
    if (!cookieTheme) return;

    // Only change if mismatch; avoids flicker loops.
    if (cookieTheme !== colorMode) {
      setColorMode(cookieTheme);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // 2) When user changes in docs: docusaurus -> cookie
  useEffect(() => {
    setThemeCookie(colorMode);
  }, [colorMode]);

  return <>{children}</>;
}

// import React, { useEffect } from "react";
// import type { Props } from "@theme/Root";
// import { getThemeCookie } from "../lib/theme-cookie";

// export default function Root({ children }: Props) {
//   useEffect(() => {
//     const theme = getThemeCookie();
//     document.documentElement.setAttribute("data-theme", theme);
//   }, []);

//   return <>{children}</>;
// }
