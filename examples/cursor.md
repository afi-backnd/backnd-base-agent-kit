# Using this knowledge pack with Cursor

## Recommended pattern

Use the repository as a local knowledge index inside the same workspace or as a nearby reference repository.

Recommended flow:

1. classify the request into a BACKND topic
2. open the corresponding topic JSON in `knowledge-pack/topics/`
3. use `route_family_id` and `source_routes` to identify the official docs to verify
4. generate code or an explanation only after checking the current official page when exactness matters

## Practical integration options

### Option A: add this repo to the workspace

Open `backnd-base-agent-kit` alongside the actual game project so Cursor can search both.

Then add a project rule such as:

```text
For BACKND Base tasks:
- consult backnd-base-agent-kit/knowledge-pack/topics first
- use route_family_id to resolve the official docs area
- verify exact API names and setup details from source_routes before finalizing code
- treat backnd-base-agent-kit as an unofficial routing layer, not the source of truth
```

### Option B: copy the pack into a docs/reference folder

If a multi-root workspace is not convenient, copy or vendor the `knowledge-pack/` and `schemas/` directories into a reference folder in the main project.

## What Cursor should read first

- `knowledge-pack/manifest.json`
- `knowledge-pack/routes.json`
- one or more files from `knowledge-pack/topics/`

## When upstream verification is required

Always re-check the official docs for:

- API signatures
- SDK versions
- installation steps
- auth key setup
- error-code specifics

## Good fit

- keeping Cursor from wandering across unrelated docs
- making BACKND answers more consistent across sessions
- improving feature-to-doc routing before code generation
