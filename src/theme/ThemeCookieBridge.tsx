import React, { useEffect } from "react";
import { useColorMode } from "@docusaurus/theme-common";
import { getThemeCookie, setThemeCookie } from "../lib/theme-cookie";

export default function ThemeCookieBridge() {
  const { colorMode, setColorMode } = useColorMode();

  // 1) On mount: read cookie -> force Docusaurus colorMode
  useEffect(() => {
    const cookie = getThemeCookie();
    if (cookie && cookie !== colorMode) {
      setColorMode(cookie);
    }
    // run once on mount
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // 2) Any change in Docusaurus mode -> write cookie for cross-subdomain sync
  useEffect(() => {
    setThemeCookie(colorMode === "dark" ? "dark" : "light");
  }, [colorMode]);

  // 3) Re-sync when tab regains focus / becomes visible (other site may have toggled)
  useEffect(() => {
    const syncFromCookie = () => {
      const cookie = getThemeCookie();
      if (cookie && cookie !== colorMode) {
        setColorMode(cookie);
      }
    };

    const onVisibility = () => {
      if (!document.hidden) syncFromCookie();
    };

    window.addEventListener("focus", syncFromCookie);
    document.addEventListener("visibilitychange", onVisibility);

    return () => {
      window.removeEventListener("focus", syncFromCookie);
      document.removeEventListener("visibilitychange", onVisibility);
    };
  }, [colorMode, setColorMode]);

  return null;
}
