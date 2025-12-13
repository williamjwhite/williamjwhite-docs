// Type declarations for Docusaurus theme component overrides.
// These make TypeScript aware of @theme/* aliases when you override them in src/theme.

declare module "@theme/ClientRoot" {
  import type { ReactNode } from "react";

  export interface Props {
    children: ReactNode;
  }

  export default function ClientRoot(props: Props): JSX.Element;
}

declare module "@theme/Heading" {
  import type { ComponentProps } from "react";

  // Docusaurus Heading behaves like a normal HTML heading wrapper.
  // Keeping props broad avoids churn across Docusaurus versions.
  export type Props = ComponentProps<"h1"> & {
    as?: "h1" | "h2" | "h3" | "h4" | "h5" | "h6";
  };

  export default function Heading(props: Props): JSX.Element;
}

// If you override other theme components later (e.g. Layout, Navbar),
// add similar declarations here so TS recognizes them.
