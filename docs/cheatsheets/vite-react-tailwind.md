

# 🚀 Vite + Tailwind + TypeScript + shadcn/ui Setup & DNS Guide

This guide combines project setup, configuration cheatsheets, and DNS troubleshooting into one reference.


## 🛠️ Project Setup commands

```bash
npm create vite@latest vite-tailwind-ts --template react-ts
```

Answer the prompts:
- Select a framework: React
- Select a variant: TypeScript
- Use rolldown-vite (Experimental)?: No
- Install with npm and start now?: Yes

---

## 📦 Install dependencies

Open a new terminal tab:

```bash
cd vite-tailwind-ts
npm install
```

---

## 🎨 Add Tailwind CSS

```bash
npm install tailwindcss @tailwindcss/vite
```

Replace EVERYTHING in `src/index.css` with:

```css
/* src/index.css */
@import "tailwindcss";
```

---

## ⚙️ TypeScript config updates

### tsconfig.json

```json
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### tsconfig.app.json

```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

---

## ⚡ Vite config update

Install Node types:

```bash
npm install -D @types/node
```

Update `vite.config.ts`:

```ts
import path from "path"
import tailwindcss from "@tailwindcss/vite"
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
```

---

## 🧩 shadcn/ui setup

Initialize:

```bash
npx shadcn@latest init
```

Prompt:
- Which color would you like to use as base color? › Neutral

### Add a single component

```bash
npx shadcn@latest add button
```

Usage:

```tsx
// src/App.tsx
import { Button } from "@/components/ui/button"

function App() {
  return (
    <div className="flex min-h-svh flex-col items-center justify-center">
      <Button>Click me</Button>
    </div>
  )
}

export default App
```

### Add all components

```bash
npx shadcn@latest add --all
```

Or interactively:

```bash
npx shadcn@latest add
```
