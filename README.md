# backnd-base-agent-kit

A community-maintained, unofficial knowledge pack for using BACKND Base with AI agents.

This repository is not the official BACKND documentation. It packages route maps, topic metadata, and agent-friendly summaries so an AI system can reason about BACKND Base without depending on a private local docs checkout.

## Goals

- Provide a public, reusable knowledge layer for AI agents
- Preserve links to canonical BACKND documentation routes
- Summarize workflows, prerequisites, and pitfalls without copying official docs verbatim
- Stay model-agnostic so the pack can be used beyond Claude Code

## What is included

- `docs/positioning.md`
  - project scope, non-affiliation, and content boundaries
- `knowledge-pack/manifest.json`
  - pack metadata and included topics
- `knowledge-pack/routes.json`
  - canonical route families for BACKND Base and Function docs
- `knowledge-pack/topics/*.json`
  - initial topic summaries for agent retrieval
- `schemas/topic.schema.json`
  - minimal schema for topic validation

## Initial topic coverage

- startup
- sdk-initialize
- user-auth
- all-errors
- function-product

## How coding agents should use this repository

This repository is a shared knowledge index for coding agents.

Agents should use it in this order:

1. classify the request into a topic or route family
2. read the matching topic JSON from `knowledge-pack/topics/`
3. use `route_family_id` to join into `knowledge-pack/routes.json`
4. use `source_routes` to jump to the current official BACKND docs when exactness matters
5. answer, plan, or generate code after upstream verification

Use this repository for:

- topic routing
- prerequisite checks
- common pitfall detection
- narrowing the official docs search space

Do not use this repository alone for:

- exact API signatures
- exact SDK download links
- version-sensitive setup steps
- current console labels
- exact error code wording when freshness matters

## Agent-specific examples

- Claude Code: `examples/claude-code.md`
- Cursor: `examples/cursor.md`
- GitHub Copilot: `examples/copilot.md`
- Codex-style agents: `examples/codex.md`

## Non-goals

- Replacing the official BACKND documentation
- Republishing official documentation pages in full
- Claiming official support or affiliation with BACKND

## Licensing and third-party materials

The original code and repository structure in this project are provided under the MIT License.

This repository may reference BACKND product names, trademarks, and official documentation routes. Those third-party materials remain the property of their respective owners and are not relicensed by this repository.

## Repository layout

```text
.
├─ docs/
│  └─ positioning.md
├─ knowledge-pack/
│  ├─ manifest.json
│  ├─ routes.json
│  └─ topics/
├─ schemas/
│  └─ topic.schema.json
└─ README.md
```

## Contribution direction

When adding new topics:

- prefer paraphrased summaries over copied text
- keep canonical route references in `source_routes`
- add prerequisites and common pitfalls
- keep topic boundaries narrow and retrieval-friendly

## Status

P0 seed release: public structure, route map, schema, and core topic metadata.
