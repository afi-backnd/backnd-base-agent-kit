# Backnd Base Agent Kit

A community-maintained BACKND knowledge pack for using BACKND Base with AI agents.

This repository complements the official BACKND documentation with route maps, topic metadata, and agent-friendly summaries so an AI system can reason about BACKND Base efficiently without depending on a private local docs checkout.

## Goals

- Provide a public, reusable knowledge layer for AI agents
- Preserve canonical BACKND documentation routes in `/sdk-docs/...` form
- Summarize workflows, prerequisites, and pitfalls without copying official docs verbatim
- Stay model-agnostic so the pack can be used beyond Claude Code
- Route agents to `https://docs.backnd.com` when exact or mutable facts must be verified

## What is included

- `docs/positioning.md`
  - project scope, source-of-truth policy, and content boundaries
- `knowledge-pack/manifest.json`
  - pack metadata and verification policy
- `knowledge-pack/routes.json`
  - canonical route families for BACKND Base and Function docs
- `knowledge-pack/topics/*.json`
  - narrow topic summaries for agent retrieval and routing
- `schemas/topic.schema.json`
  - minimal schema for topic validation

## Topic coverage

Current topics:

- startup
- sdk-initialize
- user-auth
- user-federation
- all-errors
- function-product
- game-information
- player-data
- rank
- receipt
- notify

## How coding agents should use this repository

This repository is a shared knowledge index for coding agents.

Agents should use it in this order:

1. classify the request into a topic or route family
2. read the matching topic JSON from `knowledge-pack/topics/`
3. use `route_family_id` to join into `knowledge-pack/routes.json`
4. append each `/sdk-docs/...` route to `https://docs.backnd.com` when exactness or freshness matters
5. answer, plan, or generate code only after upstream verification for mutable facts

Use this repository for:

- topic routing
- prerequisite checks
- common pitfall detection
- narrowing the official docs search space
- deciding what must be reverified before answering

Do not use this repository alone for:

- exact API signatures
- exact SDK download links
- version-sensitive setup steps
- current console labels
- current provider support matrices
- exact error code wording when freshness matters

## Design rule

This pack should behave like a stable router, not a second source of truth.

That means:

- keep stable structure and workflow guidance in the pack
- keep mutable facts out of the pack when possible
- store verification rules for mutable facts instead of storing those facts as long-lived truth
- defer to the official docs for current provider lists, setup steps, signatures, limits, and labels

## Non-goals

- Replacing the official BACKND documentation
- Republishing official documentation pages in full
- Replacing the official BACKND documentation site or API reference
- Claiming official endorsement for this repository

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
- add `verification_required_for` and `verification_strategy` for mutable details
- keep topic boundaries narrow and retrieval-friendly
- do not store mutable support matrices unless there is a deliberate refresh process

## Status

Version 0.3.0: verification-routed knowledge pack with thin federation routing.
