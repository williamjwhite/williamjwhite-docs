declare module "@theme/Root" {
  import type { ReactNode } from "react";

  export interface Props {
    children: ReactNode;
  }

  export default function Root(props: Props): JSX.Element;
}

declare module "@theme/Heading" {
  import type { ComponentProps } from "react";

  // Docusaurus Heading component behaves like a normal HTML heading wrapper.
  // Keeping props broad avoids churn across Docusaurus versions.
  export type Props = ComponentProps<"h1"> & {
    as?: "h1" | "h2" | "h3" | "h4" | "h5" | "h6";
  };

  export default function Heading(props: Props): JSX.Element;
}
