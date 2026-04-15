# Codex CLI Adaptation Design

## Goal

Add first-party support for running Ralph with Codex CLI via `./ralph.sh --tool codex` without changing the existing Amp and Claude flows.

## Scope

- Add a `codex` tool option to the main loop.
- Add a Codex-specific prompt file.
- Document Codex installation and usage in the README.
- Keep Amp and Claude behavior unchanged.

## Approach

### Option 1: Add a dedicated Codex branch and prompt

This adds a `codex` execution branch in `ralph.sh` and a new `CODEX.md` prompt template. The Codex branch uses `codex exec` in non-interactive mode and preserves Ralph's existing completion contract by scanning stdout for `<promise>COMPLETE</promise>`.

This is the chosen approach because it is the smallest compatible change and avoids mixing Amp-specific or Claude-specific instructions into Codex runs.

### Option 2: Reuse `prompt.md`

This would reduce file count but would leak Amp-specific details into Codex, including thread URL conventions that do not map cleanly.

### Option 3: Merge prompts into a shared template

This would be cleaner long-term but is a broader refactor that is outside the approved scope.

## Design Decisions

- `ralph.sh` will accept `amp`, `claude`, and `codex`.
- Codex runs will use `codex exec --full-auto` so the invocation stays non-interactive and close to the current autonomous model.
- `CODEX.md` will follow the `AGENTS.md` update convention from `prompt.md`, not the `CLAUDE.md` convention from `CLAUDE.md`.
- The progress log format in `CODEX.md` will not include an Amp-specific thread URL.

## Verification

- Add a script-level smoke test that uses a mocked `codex` binary.
- Verify the test fails before implementation because `--tool codex` is rejected.
- Implement support and re-run the test until it passes.
- Run `bash -n ralph.sh` as a syntax check.

## Risks

- Codex CLI flags can evolve. The script should stick to the minimal set required for non-interactive execution.
- Codex availability and authentication are still external prerequisites and should be documented, not handled in the script.
