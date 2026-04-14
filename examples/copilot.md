# Using this knowledge pack with GitHub Copilot

## Recommended pattern

Treat this repository as a lightweight context package that Copilot Chat can search before it answers BACKND questions.

Recommended flow:

1. identify the likely BACKND topic
2. read the matching topic JSON
3. use `route_family_id` to resolve the route family in `knowledge-pack/routes.json`
4. use `source_routes` to jump to the official documentation for exact details
5. generate the answer or code suggestion

## Practical integration options

### Option A: keep the repo in the same workspace

Open the target project together with `backnd-base-agent-kit` so Copilot Chat can inspect the topic files and route catalog.

Then instruct Copilot in repository guidance or chat context:

```text
For BACKND tasks, use backnd-base-agent-kit as an unofficial knowledge index.
Read topic JSON first, then verify exact API details from the official BACKND routes listed in source_routes.
Do not treat this repository as the official source of truth.
```

### Option B: vendor the knowledge pack

If needed, copy `knowledge-pack/` into the target repository under a clearly named folder such as `reference/backnd/`.

## What Copilot should rely on here

- topic summaries for routing
- prerequisites for early checks
- common_pitfalls for debugging hints
- related_topics for follow-up navigation

## What Copilot should not rely on here alone

- exact SDK download URLs
- exact method signatures
- current console labels
- version-sensitive setup details

Those must be rechecked from the official docs.
