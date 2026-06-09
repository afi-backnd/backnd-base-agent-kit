# Backnd Base Agent Kit

A community-maintained **BACKND Base** knowledge pack, packaged as a portable
[Agent Skill](https://agentskills.io) (`SKILL.md`) that works across multiple AI
coding tools — Claude Code, OpenAI Codex, Cursor, GitHub Copilot, and other
agents that read the open `SKILL.md` standard.

This repository **is** the `backnd-base` skill: the repo root is the skill root,
with `SKILL.md` as the entry point and `knowledge-pack/` as its data.

## What this is

- A routing layer that classifies a BACKND Base request into a topic, points to
  the correct `docs.backnd.com` page, and flags what must be verified upstream.
- **33 topics** covering all BACKND Base feature domains (see Topic coverage).
- A thin, stable router — **not** a mirror of the official documentation.

## How it works

When a BACKND Base task comes in, the skill directs the agent to:

1. **Classify** the request into a topic (trigger keywords are in `SKILL.md`).
2. **Read** `knowledge-pack/topics/<topic>.json` for summary, prerequisites,
   pitfalls, and verification rules.
3. **Join** the topic's `route_family_id` to `knowledge-pack/routes.json`.
4. **Verify** mutable/exact facts against the topic's `source_routes`
   (concrete pages) at `https://docs.backnd.com` before generating code.

The official docs at `https://docs.backnd.com` remain the source of truth for
every exact or mutable fact.

## Install

Clone the kit **outside** your game project, then run the installer against your
project. The installer copies the self-contained skill folder into each tool's
skills root, so it coexists with your existing skills and config.

```bash
# 1) clone the kit somewhere outside your project
git clone https://github.com/afi-backnd/backnd-base-agent-kit.git

# 2) install into your game project (auto-detects tools from .claude/.github/.cursor/.codex)
#    Windows (PowerShell):
pwsh backnd-base-agent-kit/scripts/install.ps1 -ProjectRoot /path/to/your-game
#    macOS / Linux:
bash backnd-base-agent-kit/scripts/install.sh --project-root /path/to/your-game
```

Useful flags: `-Tools claude,copilot` / `--tools claude,copilot` to target
specific tools, and `-WithAgentsMd` / `--with-agents-md` to also add a pointer
block to the project's `AGENTS.md` for rule-based agents (idempotent; existing
content is preserved).

### Where it installs

| Tool | Skills root | Notes |
| --- | --- | --- |
| Claude Code | `.claude/skills/backnd-base/` | Claude reads `.claude/skills/` |
| Codex + Cursor | `.agents/skills/backnd-base/` | vendor-neutral; always installed |
| GitHub Copilot | `.github/skills/backnd-base/` | agent mode |
| Cursor / Codex (explicit) | `.cursor/skills/` · `.codex/skills/` | optional; `.agents` already covers both |

Each install is a single self-contained folder (`SKILL.md` + `knowledge-pack/` +
`schemas/` + `LICENSE`). Manual install is just copying that folder into the
skills root above.

## Topic coverage

33 topics across BACKND Base:

- **Setup & fundamentals** — startup, sdk-initialize, knowhow, all-errors, common-errors
- **Auth** — user-auth, user-federation
- **Data & storage** — game-information, player-data, cloud-save, group, chart, probability, game-log
- **Ranking** — leaderboard (current), rank (legacy URank)
- **Social** — friend, message, guild, post, find-user, random-search
- **Commerce** — receipt, coupon, cash (discontinued TBC)
- **Realtime & operations** — notify (+ operation notice/event route families)
- **Platform & utilities** — push, region, country-code, sdk-utils
- **Backend functions** — function-product (+ base-side function route family)
- **Guides** — guideline, tutorial-game

Deprecations are encoded so agents prefer current features: **leaderboard** over
rank/URank, **receipt** over cash/TBC, **UPost** over Social.Post, **RandomPool**
over legacy Social/Guild random, **v2** lookups over legacy nickname search.

## Source-of-truth policy

`https://docs.backnd.com` is authoritative for:

- exact API signatures, method/field names
- SDK download links and version-specific install steps
- supported provider lists and permissions
- payload limits, reserved-field behavior, quotas
- exact error wording and current console labels
- deprecation/version status

This repository stores routing structure and verification rules, not long-lived
copies of mutable facts. Topics carry `verification_required_for` and
`verification_strategy` so agents know what to re-check before answering.

## Repository layout

```text
backnd-base-agent-kit/        (= the backnd-base skill root)
├─ SKILL.md                    entry point (domain-grouped topic index + routing rules)
├─ knowledge-pack/
│  ├─ manifest.json            pack metadata and verification policy
│  ├─ routes.json              canonical route families
│  └─ topics/*.json            33 topic files
├─ schemas/topic.schema.json   topic validation schema
├─ scripts/
│  ├─ install.ps1              installer (Windows PowerShell)
│  └─ install.sh               installer (macOS / Linux)
├─ README.md
└─ LICENSE
```

## Tool compatibility

`SKILL.md` is the cross-tool open standard, read natively (no conversion) by
Claude Code, Codex, Cursor (2.4+), GitHub Copilot (agent mode), and others. The
skill also depends on web fetch access to `docs.backnd.com`; without it, agents
should mark exact/mutable claims as unverified rather than guessing.

## Contributing

When adding or updating a topic:

- keep one topic per **feature domain**, not per documentation page
- list real, current pages in `source_routes` (exclude draft/unlisted pages)
- add prerequisites, common pitfalls, and verification rules
- prefer current features and flag deprecated ones
- keep the pack a thin router; defer mutable facts to the official docs
- validate against `schemas/topic.schema.json` and confirm pages resolve on
  `docs.backnd.com`

## Non-goals

- Replacing the official BACKND documentation or API reference
- Republishing official pages or SDK assets
- Claiming official endorsement

## Licensing and third-party materials

The original code and structure in this project are under the MIT License (see
`LICENSE`). BACKND product names, trademarks, and official documentation routes
remain the property of their respective owners and are not relicensed here.
