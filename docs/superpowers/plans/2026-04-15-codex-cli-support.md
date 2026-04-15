# Codex CLI Support Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add `./ralph.sh --tool codex` support with a dedicated prompt and minimal documentation updates.

**Architecture:** Keep the current Ralph outer loop intact and add a new execution branch for Codex. Use a dedicated `CODEX.md` prompt so Codex-specific instructions stay separate from Amp and Claude templates.

**Tech Stack:** Bash, Markdown, shell smoke tests

---

### Task 1: Add a failing smoke test for Codex support

**Files:**
- Create: `tests/ralph_codex_smoke.sh`
- Modify: none
- Test: `tests/ralph_codex_smoke.sh`

- [ ] **Step 1: Write the failing test**

```bash
bash tests/ralph_codex_smoke.sh
```

The test should expect `./ralph.sh --tool codex 1` to complete successfully against a mocked `codex` binary.

- [ ] **Step 2: Run test to verify it fails**

Run: `bash tests/ralph_codex_smoke.sh`
Expected: FAIL because current `ralph.sh` rejects `--tool codex`

### Task 2: Add Codex execution support

**Files:**
- Create: `CODEX.md`
- Modify: `ralph.sh`
- Test: `tests/ralph_codex_smoke.sh`

- [ ] **Step 1: Write minimal implementation**

Update `ralph.sh` so `codex` is accepted and add a `codex exec --full-auto` execution branch that reads from `CODEX.md`.

- [ ] **Step 2: Run test to verify it passes**

Run: `bash tests/ralph_codex_smoke.sh`
Expected: PASS

### Task 3: Document Codex usage

**Files:**
- Modify: `README.md`
- Modify: `AGENTS.md`
- Test: none

- [ ] **Step 1: Update docs**

Add Codex CLI to prerequisites, setup, run commands, and key file descriptions. Add a short reusable project pattern to `AGENTS.md` reflecting the dedicated prompt-per-tool structure.

### Task 4: Final verification

**Files:**
- Modify: none
- Test: `tests/ralph_codex_smoke.sh`

- [ ] **Step 1: Run syntax and smoke verification**

Run: `bash -n ralph.sh`
Expected: PASS

Run: `bash tests/ralph_codex_smoke.sh`
Expected: PASS
