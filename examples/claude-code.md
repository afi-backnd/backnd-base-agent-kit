# Using this knowledge pack with Claude Code

## Recommended pattern

Use this repository as a shared BACKND routing layer, not as a replacement for the official docs.

Recommended flow:

1. classify the user request into a topic
2. read the matching topic file from `knowledge-pack/topics/`
3. use `route_family_id` to join into `knowledge-pack/routes.json`
4. use `source_routes` to decide which official BACKND page to verify
5. answer or generate code after checking exact API details upstream

## Practical integration options

### Option A: reference from `CLAUDE.md`

In the target project, explain that BACKND-related work should first consult this repository.

Example guidance:

```md
## BACKND agent workflow

If the task is about BACKND Base:
1. read the relevant topic in `backnd-base-agent-kit/knowledge-pack/topics/`
2. join the topic's `route_family_id` to `backnd-base-agent-kit/knowledge-pack/routes.json`
3. verify exact API names, parameters, and current setup details from `source_routes`
4. do not invent routes or API details that are not confirmed upstream
```

### Option B: wrap it in a Claude Code skill

Create a small skill such as `/backnd-base-answer` that:

1. extracts the intent from the request
2. opens the matching topic JSON
3. checks the official route when exactness matters
4. returns an answer or implementation draft

This is usually better than loading the entire pack into every session.

## When Claude Code should re-check the official docs

Always verify upstream before presenting:

- API signatures
- exact method names
- SDK download links
- current version numbers
- console labels or setup wording
- error code details tied to a live response

## Good fit

- answering BACKND integration questions
- drafting Unity integration code
- routing troubleshooting requests to the right official page
- reducing time spent browsing the documentation tree

## Bad fit

- using this pack as the only source for exact implementation details
- quoting download links or signatures without re-checking the official docs
