#!/usr/bin/env bash
#
# Install the backnd-base agent skill into a target project for one or more AI coding tools.
#
# Copies the self-contained skill folder (SKILL.md + knowledge-pack + schemas + LICENSE)
# into each selected tool's skills root, so each tool discovers /backnd-base independently
# without touching existing config.
#
#   agents  -> .agents/skills/backnd-base   (Codex + Cursor, vendor-neutral; always installed)
#   claude  -> .claude/skills/backnd-base   (Claude Code)
#   copilot -> .github/skills/backnd-base   (GitHub Copilot, agent mode)
#   cursor  -> .cursor/skills/backnd-base   (.agents already covers it)
#   codex   -> .codex/skills/backnd-base    (.agents already covers it)
#
# Usage:
#   ./scripts/install.sh --project-root ../my-game
#   ./scripts/install.sh --project-root ../my-game --tools claude,copilot --with-agents-md
#
set -euo pipefail

SKILL_NAME="backnd-base"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(dirname "$SCRIPT_DIR")"

PROJECT_ROOT="."
WITH_AGENTS_MD=0
TOOLS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --project-root) PROJECT_ROOT="$2"; shift 2 ;;
    --tools) IFS=',' read -ra TOOLS <<< "$2"; shift 2 ;;
    --with-agents-md) WITH_AGENTS_MD=1; shift ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

[ -f "$KIT_ROOT/SKILL.md" ] || { echo "SKILL.md not found at kit root ($KIT_ROOT)" >&2; exit 1; }
PROJ="$(cd "$PROJECT_ROOT" && pwd)"

root_for() {
  case "$1" in
    agents)  echo ".agents/skills" ;;
    claude)  echo ".claude/skills" ;;
    copilot) echo ".github/skills" ;;
    cursor)  echo ".cursor/skills" ;;
    codex)   echo ".codex/skills" ;;
    *) echo "" ;;
  esac
}

if [ ${#TOOLS[@]} -eq 0 ]; then
  TOOLS=("agents")
  [ -d "$PROJ/.claude" ] && TOOLS+=("claude")
  [ -d "$PROJ/.github" ] && TOOLS+=("copilot")
  [ -d "$PROJ/.cursor" ] && TOOLS+=("cursor")
  [ -d "$PROJ/.codex" ]  && TOOLS+=("codex")
fi
case " ${TOOLS[*]} " in *" agents "*) ;; *) TOOLS=("agents" "${TOOLS[@]}") ;; esac

echo "Installing '$SKILL_NAME' into $PROJ for: ${TOOLS[*]}"

ITEMS=("SKILL.md" "knowledge-pack" "schemas" "LICENSE")
for t in "${TOOLS[@]}"; do
  root="$(root_for "$t")"
  [ -z "$root" ] && { echo "  skip unknown tool: $t"; continue; }
  dest="$PROJ/$root/$SKILL_NAME"
  rm -rf "$dest"; mkdir -p "$dest"
  for it in "${ITEMS[@]}"; do
    [ -e "$KIT_ROOT/$it" ] && cp -R "$KIT_ROOT/$it" "$dest/"
  done
  echo "  installed -> $root/$SKILL_NAME"
done

if [ "$WITH_AGENTS_MD" -eq 1 ]; then
  AGENTS="$PROJ/AGENTS.md"
  BEGIN="<!-- BEGIN backnd-base-agent-kit (auto-managed) -->"
  END="<!-- END backnd-base-agent-kit -->"
  BLOCK="$BEGIN
## BACKND Base
When a task involves BACKND Base, read and follow .agents/skills/$SKILL_NAME/SKILL.md:
classify the request into a topic, read knowledge-pack/topics/<topic>.json, then verify
mutable facts (API signatures, providers, limits) at https://docs.backnd.com before writing code.
$END"

  if [ -f "$AGENTS" ] && grep -qF "$BEGIN" "$AGENTS"; then
    awk -v b="$BEGIN" -v e="$END" -v blk="$BLOCK" '
      $0==b { print blk; skip=1; next }
      $0==e { skip=0; next }
      skip!=1 { print }
    ' "$AGENTS" > "$AGENTS.tmp" && mv "$AGENTS.tmp" "$AGENTS"
  else
    { [ -f "$AGENTS" ] && cat "$AGENTS"; printf '\n'; printf '%s\n' "$BLOCK"; } > "$AGENTS.tmp" && mv "$AGENTS.tmp" "$AGENTS"
  fi
  echo "  updated AGENTS.md (backnd-base marker)"
fi

echo "Done."
