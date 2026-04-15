#!/bin/bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cp "$REPO_ROOT/ralph.sh" "$TMP_DIR/"
cp "$REPO_ROOT/prompt.md" "$TMP_DIR/"
cp "$REPO_ROOT/CLAUDE.md" "$TMP_DIR/"

if [ -f "$REPO_ROOT/CODEX.md" ]; then
  cp "$REPO_ROOT/CODEX.md" "$TMP_DIR/"
fi

mkdir -p "$TMP_DIR/bin"

cat > "$TMP_DIR/bin/codex" <<'EOF'
#!/bin/bash
set -euo pipefail
touch "$(dirname "$0")/../codex-invoked"
cat > /dev/null
echo "<promise>COMPLETE</promise>"
EOF
chmod +x "$TMP_DIR/bin/codex"

OUTPUT_FILE="$TMP_DIR/output.txt"

set +e
PATH="$TMP_DIR/bin:$PATH" "$TMP_DIR/ralph.sh" --tool codex 1 >"$OUTPUT_FILE" 2>&1
STATUS=$?
set -e

if [ "$STATUS" -ne 0 ]; then
  echo "Expected codex run to succeed, but it exited with $STATUS"
  cat "$OUTPUT_FILE"
  exit 1
fi

if ! grep -q "Ralph completed all tasks!" "$OUTPUT_FILE"; then
  echo "Expected completion output from Ralph"
  cat "$OUTPUT_FILE"
  exit 1
fi

if [ ! -f "$TMP_DIR/codex-invoked" ]; then
  echo "Expected mocked codex binary to be invoked"
  exit 1
fi

echo "PASS: codex smoke test"
