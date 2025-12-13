// docusaurus.config.ts
import { themes as prismThemes } from "prism-react-renderer";
import type { Config } from "@docusaurus/types";
import type * as Preset from "@docusaurus/preset-classic";

const MAIN_SITE = "https://williamjwhite.me";
const DOCS_SITE = "https://docs.williamjwhite.me";

const config: Config = {
  title: "William J. White — Developer Guides",
  tagline:
    "Documentation, guides, deep dives, projects, and reference material.",
  favicon: "img/favicon.ico",

  future: {
    v4: true, // Improve compatibility with the upcoming Docusaurus v4
  },

  // Subdomain deployment
  url: DOCS_SITE,
  baseUrl: "/",

  organizationName: "williamjwhite",
  projectName: "williamjwhite-docs",

  onBrokenLinks: "throw",
  markdown: {
    hooks: {
      onBrokenMarkdownLinks: "warn",
    },
  },

  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      {
        docs: {
          // Serve docs at site root
          routeBasePath: "/",
          sidebarPath: "./sidebars.ts",
          editUrl:
            "https://github.com/williamjwhite/williamjwhite-docs/tree/main/",
        },
        blog: false,
        theme: {
          customCss: "./src/css/custom.css",
        },
      },
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    {
      // Replace with your project's social card
      image: "img/docusaurus-social-card.jpg",
      colorMode: {
        respectPrefersColorScheme: true,
      },
      docs: {
        sidebar: {
          autoCollapseCategories: true,
          hideable: false,
        },
      },
      scripts: [
        {
          src: "/theme-sync.js",
          async: false,
          defer: false,
        },
      ],
      navbar: {
        title: "William J. White",
        logo: { alt: "William J. White", src: "img/logo-light.svg" },
        items: [
          // Main-site personal/professional sections (removed from docs routing)
          {
            label: "About",
            href: `${MAIN_SITE}/#about`,
            position: "left",
          },
          {
            label: "Experience",
            href: `${MAIN_SITE}/#experience`,
            position: "left",
          },
          {
            label: "Connect",
            href: `${MAIN_SITE}/#connect`,
            position: "left",
          },

          // Docs (single, clean switcher)
          {
            type: "dropdown",
            label: "Docs",
            position: "left",
            items: [
              { to: "/developer-guides", label: "Developer Guides" },
              { to: "/deep-dives", label: "Deep Dives" },
              { to: "/cheatsheets", label: "Cheatsheets" },
              { to: "/general", label: "General" },
            ],
          },

          // Projects
          {
            type: "dropdown",
            label: "Projects",
            position: "left",
            items: [
              {
                type: "doc",
                docId: "projects/trakteam/overview",
                label: "Trakteam",
              },
              {
                type: "doc",
                docId: "projects/codevault/overview",
                label: "CodeVault",
              },
              { to: "/projects", label: "All Projects" },
            ],
          },

          // Cross-site / external
          {
            type: "dropdown",
            label: "Sites",
            position: "right",
            items: [
              { type: "html", value: "<strong>Personal</strong>" },
              { href: MAIN_SITE, label: "Main Site" },
              { href: DOCS_SITE, label: "Docs" },
              // If/when you actually have a blog route on the main site, keep this.
              // Otherwise remove it to avoid confusion.
              { href: `${MAIN_SITE}/blog`, label: "Blog" },

              { type: "html", value: "<hr/>" },

              { type: "html", value: "<strong>External</strong>" },
              { href: "https://github.com/williamjwhite", label: "GitHub" },
              {
                href: "https://www.linkedin.com/in/william-j-white-ny",
                label: "LinkedIn",
              },
              { href: "https://bsky.app/", label: "Bluesky" },
            ],
          },
        ],
      },

      footer: {
        style: "dark",
        links: [
          {
            title: "Docs",
            items: [
              { label: "Developer Guides", to: "/developer-guides" },
              { label: "Deep Dives", to: "/deep-dives" },
              { label: "Cheatsheets", to: "/cheatsheets" },
              { label: "General", to: "/general" },
            ],
          },
          {
            // Removed docs-based About/Connect/Experience.
            // These now live on the main site.
            title: "Main Site",
            items: [
              { label: "About", href: `${MAIN_SITE}/#about` },
              { label: "Experience", href: `${MAIN_SITE}/#experience` },
              { label: "Connect", href: `${MAIN_SITE}/#connect` },
            ],
          },
          {
            title: "Sites",
            items: [
              { label: "Main Site", href: MAIN_SITE },
              { label: "Docs", href: DOCS_SITE },
              { label: "GitHub", href: "https://github.com/williamjwhite" },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} William J. White.`,
      },

      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
      },
    },
};

export default config;
