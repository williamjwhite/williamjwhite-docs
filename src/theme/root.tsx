import React, { useEffect } from "react";
import type { Props } from "@theme/Root";
import { getThemeCookie } from "../lib/theme-cookie";

export default function Root({ children }: Props) {
  useEffect(() => {
    const theme = getThemeCookie();
    document.documentElement.setAttribute("data-theme", theme);
  }, []);

  return <>{children}</>;
}
