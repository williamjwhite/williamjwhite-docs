import React from "react";
import OriginalClientRoot from "@theme-original/ClientRoot";
import ThemeCookieBridge from "./ThemeCookieBridge";

export default function ClientRoot(props: { children: React.ReactNode }) {
  return (
    <OriginalClientRoot {...props}>
      {/* Now safely inside ColorModeProvider */}
      <ThemeCookieBridge />
    </OriginalClientRoot>
  );
}
