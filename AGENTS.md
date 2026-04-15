# Ralph Agent Instructions

## Overview

Ralph is an autonomous AI agent loop that runs AI coding tools (Amp, Claude Code, Codex CLI, or Kimi CLI) repeatedly until all PRD items are complete. Each iteration is a fresh instance with clean context.

## Commands

```bash
# Run the flowchart dev server
cd flowchart && npm run dev

# Build the flowchart
cd flowchart && npm run build

# Run Ralph with Amp (default)
./ralph.sh [max_iterations]

# Run Ralph with Claude Code
./ralph.sh --tool claude [max_iterations]

# Run Ralph with Codex CLI
./ralph.sh --tool codex [max_iterations]

# Run Ralph with Kimi CLI
./ralph.sh --tool kimi [max_iterations]
```

## Key Files

- `ralph.sh` - The bash loop that spawns fresh AI instances (supports `--tool amp`, `--tool claude`, `--tool codex`, or `--tool kimi`)
- `prompt.md` - Instructions given to each AMP instance
- `CLAUDE.md` - Instructions given to each Claude Code instance
- `CODEX.md` - Instructions given to each Codex CLI instance
- `KIMI.md` - Instructions given to each Kimi CLI instance
- `prd.json.example` - Example PRD format
- `flowchart/` - Interactive React Flow diagram explaining how Ralph works

## Bootstrapping Ralph in Another Project

When the user says "使用 ralph" (or "use ralph" / "set up ralph"), copy the following files from `/Users/dujiepeng/project/AI/ralph/` into the target project's root (or a `scripts/ralph/` subdirectory if the project already has a `scripts/` convention):

### Required core files
- `ralph.sh`
- `prompt.md`
- `CLAUDE.md`
- `CODEX.md`
- `KIMI.md`

### Recommended files (enforce PRD quality and workflow)
- `prd.json.example`
- `skills/prd/SKILL.md`
- `skills/ralph/SKILL.md`

### Optional
- `AGENTS.md` — only if the target project does not already have one; merge rather than overwrite if it exists.

After copying, ensure `ralph.sh` is executable (`chmod +x ralph.sh`) and remind the user to create or generate `prd.json` before running `./ralph.sh --tool <tool>`.

## Flowchart

The `flowchart/` directory contains an interactive visualization built with React Flow. It's designed for presentations - click through to reveal each step with animations.

To run locally:
```bash
cd flowchart
npm install
npm run dev
```

## Patterns

- Each iteration spawns a fresh AI instance (Amp, Claude Code, Codex CLI, or Kimi CLI) with clean context
- Memory persists via git history, `progress.txt`, and `prd.json`
- Stories should be small enough to complete in one context window
- Always update AGENTS.md with discovered patterns for future iterations
- Keep a dedicated prompt file per CLI so tool-specific instructions do not leak across Amp, Claude, Codex, and Kimi runs
