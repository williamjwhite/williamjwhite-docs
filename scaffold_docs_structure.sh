#!/usr/bin/env bash
# scaffold_docs_structure.sh
#
# Creates a Docusaurus docs structure for williamjwhite-docs WITHOUT overwriting existing files.
# - Safe: will create missing folders/files only
# - Robust front-matter for Markdown docs
# - _category_.json files for generated indexes and sidebar organization
#
# Usage:
#   1) cd /path/to/williamjwhite-docs
#   2) bash scaffold_docs_structure.sh
#
# Notes:
# - This script assumes your Docusaurus docs root is: ./docs
# - It will NOT overwrite any existing file. It will report what it skipped.

set -euo pipefail

ROOT_DIR="$(pwd)"
DOCS_DIR="${ROOT_DIR}/docs"

# ---------------------------
# Helpers
# ---------------------------
log()  { printf "%s\n" "$*"; }
ok()   { printf "✅ %s\n" "$*"; }
skip() { printf "⏭️  %s\n" "$*"; }
warn() { printf "⚠️  %s\n" "$*"; }

ensure_dir() {
  local d="$1"
  if [[ -d "$d" ]]; then
    skip "Dir exists: $d"
  else
    mkdir -p "$d"
    ok "Created dir: $d"
  fi
}

write_file_no_overwrite() {
  local f="$1"
  local content="$2"

  if [[ -f "$f" ]]; then
    skip "File exists (not overwriting): $f"
    return 0
  fi

  # ensure parent dir
  mkdir -p "$(dirname "$f")"
  printf "%s" "$content" > "$f"
  ok "Created file: $f"
}

category_json() {
  local label="$1"
  local position="$2"
  local description="$3"

  cat <<EOF
{
  "label": "${label}",
  "position": ${position},
  "link": {
    "type": "generated-index",
    "description": "${description}"
  }
}
EOF
}

md_frontmatter() {
  local title="$1"
  local sidebar_position="$2"
  local slug="$3"
  local description="$4"
  local tags="$5"
  local last_updated="$6"

  cat <<EOF
---
title: "${title}"
sidebar_position: ${sidebar_position}
slug: "${slug}"
description: "${description}"
tags: [${tags}]
last_update:
  date: "${last_updated}"
  author: "William J. White"
---

EOF
}

md_body_placeholder() {
  local heading="$1"
  local purpose="$2"

  cat <<EOF
# ${heading}

${purpose}

## Overview
- Purpose:
- Audience:
- Scope:

## Key Points
-

## References
-
EOF
}

today_iso() {
  date +"%Y-%m-%d"
}

# ---------------------------
# Preconditions
# ---------------------------
if [[ ! -d "$ROOT_DIR" ]]; then
  warn "Root directory not found: $ROOT_DIR"
  exit 1
fi

# We expect to run from repo root; create docs/ if missing
ensure_dir "$DOCS_DIR"

log ""
log "Scaffolding Docusaurus docs structure at:"
log "  Repo root: $ROOT_DIR"
log "  Docs root: $DOCS_DIR"
log ""

DATE_TODAY="$(today_iso)"

# ---------------------------
# Directory structure
# ---------------------------
ensure_dir "$DOCS_DIR/about"
ensure_dir "$DOCS_DIR/professional-experience"
ensure_dir "$DOCS_DIR/general"

ensure_dir "$DOCS_DIR/developer-guides"
ensure_dir "$DOCS_DIR/developer-guides/tooling"
ensure_dir "$DOCS_DIR/developer-guides/frontend"
ensure_dir "$DOCS_DIR/developer-guides/backend"

ensure_dir "$DOCS_DIR/deep-dives"
ensure_dir "$DOCS_DIR/deep-dives/architecture"
ensure_dir "$DOCS_DIR/deep-dives/performance"

ensure_dir "$DOCS_DIR/projects"
ensure_dir "$DOCS_DIR/projects/trakteam"
ensure_dir "$DOCS_DIR/projects/codevault"

ensure_dir "$DOCS_DIR/cheatsheets"
ensure_dir "$DOCS_DIR/connect"
ensure_dir "$DOCS_DIR/sites"

# ---------------------------
# Category JSON files
# ---------------------------
write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/_category_.json" \
  "$(category_json "Developer Guides" 10 "Practical guides and standards for development workflows.")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/tooling/_category_.json" \
  "$(category_json "Tooling" 11 "Tooling setup and operational workflows (Node, Git, editors, automation).")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/frontend/_category_.json" \
  "$(category_json "Frontend" 12 "Frontend implementation guides (React, Vite, shadcn/ui, Tailwind).")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/backend/_category_.json" \
  "$(category_json "Backend" 13 "Backend guides (PHP, Laravel, APIs, deployment patterns).")"

write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/_category_.json" \
  "$(category_json "Deep Dives" 20 "In-depth technical explorations and architectural decision records.")"

write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/architecture/_category_.json" \
  "$(category_json "Architecture" 21 "Architecture patterns: monorepos, deployment, environments, boundaries.")"

write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/performance/_category_.json" \
  "$(category_json "Performance" 22 "Performance profiling, optimization playbooks, and measurement.")"

write_file_no_overwrite \
  "$DOCS_DIR/projects/_category_.json" \
  "$(category_json "Projects" 30 "Project documentation, roadmaps, setup instructions, and technical notes.")"

write_file_no_overwrite \
  "$DOCS_DIR/projects/trakteam/_category_.json" \
  "$(category_json "Trakteam" 31 "Trakteam project documentation (multi-platform SwiftUI operations tooling).")"

write_file_no_overwrite \
  "$DOCS_DIR/projects/codevault/_category_.json" \
  "$(category_json "CodeVault" 32 "CodeVault documentation (snippet management, sync, and UX patterns).")"

write_file_no_overwrite \
  "$DOCS_DIR/cheatsheets/_category_.json" \
  "$(category_json "Cheatsheets" 40 "Fast-reference material and operational checklists.")"

# ---------------------------
# Markdown docs with robust front-matter
# ---------------------------

# ABOUT
write_file_no_overwrite \
  "$DOCS_DIR/about/index.md" \
  "$(md_frontmatter "About Me" 1 "/about" "Profile, background, and professional summary." "\"about\", \"profile\", \"bio\"" "$DATE_TODAY")$(md_body_placeholder "About Me" "This page introduces William J. White, the work philosophy, and focus areas.")"

# PROFESSIONAL EXPERIENCE
write_file_no_overwrite \
  "$DOCS_DIR/professional-experience/index.md" \
  "$(md_frontmatter "Professional Experience" 2 "/professional-experience" "Career timeline, roles, and core competencies." "\"experience\", \"career\", \"timeline\"" "$DATE_TODAY")$(md_body_placeholder "Professional Experience" "High-level career summary with links to role highlights and resume.")"

write_file_no_overwrite \
  "$DOCS_DIR/professional-experience/resume.md" \
  "$(md_frontmatter "Resume" 3 "/professional-experience/resume" "Resume-focused overview with role summaries and impact bullets." "\"resume\", \"experience\"" "$DATE_TODAY")$(md_body_placeholder "Resume" "Resume-style content, impact bullets, technologies, and achievements.")"

write_file_no_overwrite \
  "$DOCS_DIR/professional-experience/highlights.md" \
  "$(md_frontmatter "Highlights" 4 "/professional-experience/highlights" "Selected achievements and outcomes across roles and projects." "\"highlights\", \"impact\"" "$DATE_TODAY")$(md_body_placeholder "Highlights" "Curated list of outcomes, metrics, and notable work across roles.")"

# GENERAL
write_file_no_overwrite \
  "$DOCS_DIR/general/index.md" \
  "$(md_frontmatter "General" 5 "/general" "General notes, conventions, and cross-cutting reference material." "\"general\", \"reference\"" "$DATE_TODAY")$(md_body_placeholder "General" "Cross-cutting topics and quick links across the documentation set.")"

# DEVELOPER GUIDES
write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/getting-started.md" \
  "$(md_frontmatter "Getting Started" 10 "/developer-guides/getting-started" "How to navigate these docs and set up the baseline dev environment." "\"developer-guides\", \"getting-started\"" "$DATE_TODAY")$(md_body_placeholder "Getting Started" "Start here for environment setup, conventions, and how this docs site is organized.")"

# TOOLING
write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/tooling/node.md" \
  "$(md_frontmatter "Node Tooling" 11 "/developer-guides/tooling/node" "Node, npm, version management, and CI compatibility notes." "\"node\", \"tooling\", \"npm\"" "$DATE_TODAY")$(md_body_placeholder "Node Tooling" "Guidance for Node versions, npm usage, and avoiding tooling mismatches in local vs CI.")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/tooling/git.md" \
  "$(md_frontmatter "Git Workflows" 12 "/developer-guides/tooling/git" "Branching, commits, multi-account GitHub SSH, and repo hygiene." "\"git\", \"ssh\", \"workflows\"" "$DATE_TODAY")$(md_body_placeholder "Git Workflows" "Conventions for branching, commit messages, and multi-identity SSH configuration.")"

# FRONTEND
write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/frontend/react.md" \
  "$(md_frontmatter "React + Vite" 13 "/developer-guides/frontend/react" "React + Vite conventions, structure, and deployment considerations." "\"react\", \"vite\", \"frontend\"" "$DATE_TODAY")$(md_body_placeholder "React + Vite" "Project structure guidance and production considerations for React/Vite apps.")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/frontend/shadcn.md" \
  "$(md_frontmatter "shadcn/ui" 14 "/developer-guides/frontend/shadcn" "Component usage conventions, styling rules, and update workflow." "\"shadcn\", \"tailwind\", \"ui\"" "$DATE_TODAY")$(md_body_placeholder "shadcn/ui" "Rules for component installation, customization patterns, and avoiding upgrade regressions.")"

# BACKEND
write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/backend/php.md" \
  "$(md_frontmatter "PHP" 15 "/developer-guides/backend/php" "PHP runtime standards, local server patterns, and environment notes." "\"php\", \"backend\"" "$DATE_TODAY")$(md_body_placeholder "PHP" "PHP versioning strategy, local hosting patterns (MAMP, built-in server), and best practices.")"

write_file_no_overwrite \
  "$DOCS_DIR/developer-guides/backend/laravel.md" \
  "$(md_frontmatter "Laravel" 16 "/developer-guides/backend/laravel" "Laravel conventions, structure, deployment, and admin tooling notes." "\"laravel\", \"backend\", \"filament\"" "$DATE_TODAY")$(md_body_placeholder "Laravel" "Laravel project conventions, environment config, and deployment checklists.")"

# DEEP DIVES
write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/architecture/monorepos.md" \
  "$(md_frontmatter "Monorepos" 21 "/deep-dives/architecture/monorepos" "Deep dive on monorepo structure, workspaces, and deployment patterns." "\"monorepo\", \"workspaces\", \"architecture\"" "$DATE_TODAY")$(md_body_placeholder "Monorepos" "Rationale, layout options, and operational tradeoffs for monorepos.")"

write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/architecture/deployment.md" \
  "$(md_frontmatter "Deployment" 22 "/deep-dives/architecture/deployment" "Deployment patterns for static sites, apps, and multi-repo systems." "\"deployment\", \"ci\", \"github-pages\"" "$DATE_TODAY")$(md_body_placeholder "Deployment" "Recommended CI/CD patterns, environment separation, and deployment validation steps.")"

write_file_no_overwrite \
  "$DOCS_DIR/deep-dives/performance/profiling.md" \
  "$(md_frontmatter "Profiling" 23 "/deep-dives/performance/profiling" "Profiling methodologies, tooling, and performance regression prevention." "\"performance\", \"profiling\"" "$DATE_TODAY")$(md_body_placeholder "Profiling" "How to measure performance, identify bottlenecks, and validate improvements.")"

# PROJECTS
write_file_no_overwrite \
  "$DOCS_DIR/projects/trakteam/overview.md" \
  "$(md_frontmatter "Trakteam Overview" 31 "/projects/trakteam/overview" "Trakteam scope, architecture, and operational workflows." "\"trakteam\", \"swiftui\", \"projects\"" "$DATE_TODAY")$(md_body_placeholder "Trakteam Overview" "High-level purpose, architecture, and how-to sections for Trakteam.")"

write_file_no_overwrite \
  "$DOCS_DIR/projects/codevault/overview.md" \
  "$(md_frontmatter "CodeVault Overview" 32 "/projects/codevault/overview" "CodeVault scope, architecture, and feature roadmap." "\"codevault\", \"swiftui\", \"projects\"" "$DATE_TODAY")$(md_body_placeholder "CodeVault Overview" "High-level purpose, architecture, and roadmap notes for CodeVault.")"

# CHEATSHEETS
write_file_no_overwrite \
  "$DOCS_DIR/cheatsheets/git.md" \
  "$(md_frontmatter "Git Cheatsheet" 41 "/cheatsheets/git" "Fast reference for common Git commands and workflows." "\"cheatsheet\", \"git\"" "$DATE_TODAY")$(md_body_placeholder "Git Cheatsheet" "Commands you use often, with minimal commentary and safe defaults.")"

write_file_no_overwrite \
  "$DOCS_DIR/cheatsheets/node.md" \
  "$(md_frontmatter "Node Cheatsheet" 42 "/cheatsheets/node" "Fast reference for Node/npm commands, versioning, and troubleshooting." "\"cheatsheet\", \"node\", \"npm\"" "$DATE_TODAY")$(md_body_placeholder "Node Cheatsheet" "Commands for package management, builds, and environment sanity checks.")"

write_file_no_overwrite \
  "$DOCS_DIR/cheatsheets/dns.md" \
  "$(md_frontmatter "DNS Cheatsheet" 43 "/cheatsheets/dns" "DNS record quick reference and debugging commands." "\"cheatsheet\", \"dns\"" "$DATE_TODAY")$(md_body_placeholder "DNS Cheatsheet" "DNS record types, common setups (GitHub Pages), and dig/curl diagnostics.")"

# CONNECT
write_file_no_overwrite \
  "$DOCS_DIR/connect/index.md" \
  "$(md_frontmatter "Contact Info" 50 "/connect" "Primary contact channels and response expectations." "\"connect\", \"contact\"" "$DATE_TODAY")$(md_body_placeholder "Contact Info" "How to reach me, preferred channels, and what to include in a message.")"

write_file_no_overwrite \
  "$DOCS_DIR/connect/client-portal.md" \
  "$(md_frontmatter "Client Portal" 51 "/connect/client-portal" "Client access and engagement workflow." "\"connect\", \"client-portal\"" "$DATE_TODAY")$(md_body_placeholder "Client Portal" "Client onboarding, portal access, deliverables, and communication cadence.")"

write_file_no_overwrite \
  "$DOCS_DIR/connect/hiring-inquiries.md" \
  "$(md_frontmatter "Hiring Inquiries" 52 "/connect/hiring-inquiries" "Information for recruiters and hiring teams." "\"connect\", \"hiring\"" "$DATE_TODAY")$(md_body_placeholder "Hiring Inquiries" "Role fit criteria, availability, and what to include in outreach.")"

# SITES
write_file_no_overwrite \
  "$DOCS_DIR/sites/index.md" \
  "$(md_frontmatter "Sites" 60 "/sites" "Index of personal and external sites and profiles." "\"sites\", \"links\"" "$DATE_TODAY")$(md_body_placeholder "Sites" "Links to the main site, docs, and external profiles (LinkedIn, GitHub, etc.).")"

log ""
ok "Scaffolding complete. No existing files were overwritten."
log ""
log "Next:"
log "  1) npm run start"
log "  2) Confirm docs appear in sidebar (autogenerated)."
log "  3) Curate navbar dropdown links in docusaurus.config.ts as needed."
