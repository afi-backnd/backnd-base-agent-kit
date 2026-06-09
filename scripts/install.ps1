#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Install the backnd-base agent skill into a target project for one or more AI coding tools.

.DESCRIPTION
  Copies the skill folder (SKILL.md + knowledge-pack + schemas + LICENSE) into each
  selected tool's skills root under the target project. The skill folder is self-contained,
  so each tool discovers /backnd-base independently without touching existing config.

  Tools and their skills roots:
    agents  -> .agents/skills/backnd-base   (Codex + Cursor, vendor-neutral; always installed)
    claude  -> .claude/skills/backnd-base   (Claude Code)
    copilot -> .github/skills/backnd-base   (GitHub Copilot, agent mode)
    cursor  -> .cursor/skills/backnd-base   (Cursor; .agents already covers it)
    codex   -> .codex/skills/backnd-base    (Codex; .agents already covers it)

  With -WithAgentsMd, also appends an idempotent marker block to the project's AGENTS.md
  that points rule-based agents at the installed SKILL.md (content outside the markers is
  preserved; the block is created if AGENTS.md does not exist).

.EXAMPLE
  ./scripts/install.ps1 -ProjectRoot ../my-game
  Auto-detects tools from existing .claude/.github/.cursor/.codex folders (plus .agents).

.EXAMPLE
  ./scripts/install.ps1 -ProjectRoot ../my-game -Tools claude,copilot -WithAgentsMd
#>
param(
  [string]$ProjectRoot = ".",
  [string[]]$Tools = @(),
  [switch]$WithAgentsMd
)

$ErrorActionPreference = "Stop"
$SkillName = "backnd-base"
$KitRoot = Split-Path -Parent $PSScriptRoot
$proj = (Resolve-Path $ProjectRoot).Path

$items = @("SKILL.md", "knowledge-pack", "schemas", "LICENSE")
$roots = @{
  agents  = ".agents/skills"
  claude  = ".claude/skills"
  copilot = ".github/skills"
  cursor  = ".cursor/skills"
  codex   = ".codex/skills"
}

# Verify we are running from inside the kit
if (-not (Test-Path (Join-Path $KitRoot "SKILL.md"))) {
  throw "SKILL.md not found at kit root ($KitRoot). Run this script from the kit's scripts/ folder."
}

# Resolve target tool set
if ($Tools.Count -eq 0) {
  $Tools = @("agents")
  if (Test-Path (Join-Path $proj ".claude")) { $Tools += "claude" }
  if (Test-Path (Join-Path $proj ".github")) { $Tools += "copilot" }
  if (Test-Path (Join-Path $proj ".cursor")) { $Tools += "cursor" }
  if (Test-Path (Join-Path $proj ".codex"))  { $Tools += "codex" }
}
if ($Tools -notcontains "agents") { $Tools = @("agents") + $Tools }
$Tools = $Tools | Select-Object -Unique

Write-Host "Installing '$SkillName' into $proj for: $($Tools -join ', ')"

foreach ($t in $Tools) {
  if (-not $roots.ContainsKey($t)) { Write-Warning "skip unknown tool: $t"; continue }
  $dest = Join-Path $proj (Join-Path $roots[$t] $SkillName)
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  foreach ($it in $items) {
    $s = Join-Path $KitRoot $it
    if (Test-Path $s) { Copy-Item $s -Destination $dest -Recurse -Force }
  }
  Write-Host "  installed -> $($roots[$t])/$SkillName"
}

if ($WithAgentsMd) {
  $agents = Join-Path $proj "AGENTS.md"
  $begin = "<!-- BEGIN backnd-base-agent-kit (auto-managed) -->"
  $end   = "<!-- END backnd-base-agent-kit -->"
  $block = @(
    $begin,
    "## BACKND Base",
    "When a task involves BACKND Base, read and follow .agents/skills/$SkillName/SKILL.md:",
    "classify the request into a topic, read knowledge-pack/topics/<topic>.json, then verify",
    "mutable facts (API signatures, providers, limits) at https://docs.backnd.com before writing code.",
    $end
  ) -join "`n"

  if (Test-Path $agents) {
    $c = [System.IO.File]::ReadAllText($agents)
    if ($c.Contains($begin) -and $c.Contains($end)) {
      $i = $c.IndexOf($begin)
      $j = $c.IndexOf($end) + $end.Length
      $c = $c.Substring(0, $i) + $block + $c.Substring($j)
    } else {
      $c = $c.TrimEnd() + "`n`n" + $block + "`n"
    }
  } else {
    $c = $block + "`n"
  }
  [System.IO.File]::WriteAllText($agents, $c, (New-Object System.Text.UTF8Encoding $false))
  Write-Host "  updated AGENTS.md (backnd-base marker)"
}

Write-Host "Done."
