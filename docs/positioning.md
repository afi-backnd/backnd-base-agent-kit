# Positioning

## Purpose

`backnd-base-agent-kit` is a public, community-maintained knowledge pack for AI agents that need to work with BACKND Base.

The project exists because many agent runtimes cannot access a maintainer's local documentation checkout. Instead of relying on a private repo, this repository exposes a small, structured layer of public metadata that can be shipped with an agent or indexed by a retrieval system.

## What this repository is

- a community-maintained knowledge pack for coding agents
- a structured route map for important BACKND Base documentation areas
- a set of compact topic files describing capabilities, prerequisites, common pitfalls, and verification rules
- a starting point for agent adapters, retrieval pipelines, or prompt engineering

## What this repository is not

- a replacement for the official BACKND documentation site or API reference
- an SDK distribution
- a mirror of the official documentation site
- a guarantee that a route or API detail has not changed upstream
- an official BACKND repository or endorsed support channel

## Source-of-truth policy

The official BACKND documentation at `https://docs.backnd.com` remains the source of truth for:

- exact API signatures
- current SDK download links
- version-specific installation behavior
- console setup flows and screenshots
- product naming or navigation changes
- supported provider lists
- permission or scope requirements
- exact error wording and current examples

This repository only stores enough structure to help an agent decide what to read, what to verify, and what to watch out for.

## Route policy

This repository stores canonical routes in `/sdk-docs/...` form.

Agents should append those routes to `https://docs.backnd.com` before presenting mutable or exact claims as current.

Examples:

- `/sdk-docs/backend/base/start-up`
- `/sdk-docs/backend/base/user/federation/signup-and-login`
- `/sdk-docs/function/intro`

## Content boundary

Allowed content in this repository:

- route families and canonical path references
- original summaries written for agent consumption
- prerequisite lists
- workflow outlines
- common failure patterns and agent-facing guidance
- explicit verification rules for mutable facts

Content to avoid storing here:

- large verbatim excerpts from official documentation
- copied screenshots or downloadable SDK assets
- long-lived copies of mutable support matrices
- claims of official endorsement

## Retrieval model

Recommended retrieval flow:

1. classify the request into a topic
2. read the topic JSON from `knowledge-pack/topics/`
3. inspect the matching route family in `knowledge-pack/routes.json`
4. append the selected `/sdk-docs/...` path to `https://docs.backnd.com`
5. verify upstream when the question depends on mutable or exact facts
6. answer with awareness that this repository complements the official BACKND docs and must defer to upstream pages for current details

## Maintenance rule

If a topic depends on exact values such as provider lists, download URLs, SDK versions, function signatures, console labels, or permission requirements, agents should store verification guidance rather than storing the value itself as durable truth.

Thin routing topics are preferred over thick fact caches for areas that change upstream.
