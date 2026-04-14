# Using this knowledge pack with Codex-style coding agents

## Recommended pattern

Use this repository as retrieval input for an orchestrator, prompt builder, or custom agent wrapper around Codex.

Recommended flow:

1. classify the user request into a topic
2. load the matching topic JSON into the prompt context
3. use `route_family_id` to resolve the route family from `knowledge-pack/routes.json`
4. fetch the relevant official BACKND page from `source_routes` when exactness matters
5. ask the coding agent to draft code or an explanation using both the topic summary and the verified official details

## Practical integration options

### Option A: retrieval-first prompt assembly

Your wrapper can do this before the model call:

1. load `knowledge-pack/manifest.json`
2. choose one or more topic files
3. attach the topic JSON to the prompt
4. attach small excerpts or verified facts from the official route
5. call the coding agent

### Option B: sidecar reference repository

Mount this repository next to the main codebase and let the agent search it as part of the workspace.

## Suggested prompt contract

```text
You have access to the official BACKND agent knowledge pack.
Use it to identify the right documentation area quickly.
Before giving exact API names, method signatures, version-specific setup, or download links, verify the current official BACKND documentation from source_routes.
```

## Good fit

- custom RAG pipelines
- prompt assembly before agent execution
- consistent BACKND topic routing across runs

## Bad fit

- sending only this pack and skipping official verification for exact API details
- assuming route names or signatures that are not confirmed in the current upstream docs
