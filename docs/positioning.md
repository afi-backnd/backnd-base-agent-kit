# Positioning

## Purpose

`backnd-base-agent-kit` is a public knowledge pack for AI agents that need to work with BACKND Base.

The project exists because many agent runtimes cannot access a maintainer's local documentation checkout. Instead of relying on a private repo, this repository exposes a small, structured layer of public metadata that can be shipped with an agent or indexed by a retrieval system.

## What this repository is

- a community-maintained, unofficial helper project
- a structured route map for important BACKND Base documentation areas
- a set of compact topic files describing capabilities, prerequisites, and common pitfalls
- a starting point for agent adapters, retrieval pipelines, or prompt engineering

## What this repository is not

- the official BACKND documentation
- an SDK distribution
- a mirror of the official documentation site
- a guarantee that a route or API detail has not changed upstream

## Source-of-truth policy

The official BACKND documentation remains the source of truth for:

- exact API signatures
- current SDK download links
- version-specific installation behavior
- console setup flows and screenshots
- product naming or navigation changes

This repository only stores enough structure to help an agent decide what to read and what to watch out for.

## Content boundary

Allowed content in this repository:

- route families and canonical path references
- original summaries written for agent consumption
- prerequisite lists
- workflow outlines
- common failure patterns and agent-facing guidance

Content to avoid storing here:

- large verbatim excerpts from official documentation
- copied screenshots or downloadable SDK assets
- claims of official endorsement

## Retrieval model

Recommended retrieval flow:

1. classify the request into a topic
2. read the topic JSON from `knowledge-pack/topics/`
3. inspect the matching route family in `knowledge-pack/routes.json`
4. fetch the official route only when exactness or freshness is required
5. answer with explicit awareness that this repository is unofficial

## Maintenance rule

If a topic depends on exact values such as download URLs, SDK versions, function signatures, or console labels, agents should verify those values from the official documentation before presenting them as current.
