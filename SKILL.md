---
name: backnd-base
description: >-
  BACKND Base (뒤끝 베이스) routing and verification guide for game backend (BaaS)
  integration. Use this skill for any BACKND / 뒤끝 Base task: SDK setup and
  initialization, usage patterns (knowhow), user auth and federation, data
  (game-information, player-data, cloud-save, group, chart, probability,
  game-log), ranking (leaderboard; legacy rank/URank), social (friend, message,
  guild, post, find-user, random-search), commerce (receipt, coupon; the
  discontinued cash/TBC), realtime notify and operation notices/events, push,
  region and country-code, SDK utilities, the error catalog and common-error
  handling, plus step-by-step guidelines and example games. It classifies the
  request to the right topic, points to the correct docs.backnd.com route, and
  flags which exact or mutable facts (signatures, providers, limits, console
  labels, error wording) must be re-verified upstream before writing code.
---

# BACKND Base agent skill

This skill is a **router**, not a second source of truth. It helps you decide
which topic applies, which official page to verify, and what must be rechecked
upstream before you answer or generate code. The official docs at
`https://docs.backnd.com` remain authoritative for every exact or mutable fact.

## When to use

Activate for any BACKND Base / 뒤끝 task. If the request is not about BACKND, do
not use this skill.

## Routing procedure

1. **Classify** the request into a topic using the index below (match on the
   trigger keywords, including Korean terms).
2. **Read the topic file** `knowledge-pack/topics/<topic>.json` for its
   summary, prerequisites, common pitfalls, and `verification_required_for`.
3. **Join the route** via the topic's `route_family_id` in
   `knowledge-pack/routes.json`.
4. **Verify upstream** using the topic's **`source_routes`** (concrete pages):
   append the chosen `/sdk-docs/...` route to `https://docs.backnd.com` and
   fetch it. The `route_family` is a category identifier — its bare path is
   often **not a page (404)**, so always verify against a narrower
   `source_route`, not the family path.
5. **Answer or generate code** only after upstream verification for mutable
   facts. Carry the topic's pitfalls into the answer.

## Topic index

### Setup & fundamentals
| Topic file | Trigger keywords |
| --- | --- |
| `startup.json` | unity, install, setup, client app id, signature key, inspector, `Backend.Initialize` |
| `sdk-initialize.json` | initialize, `InitializeAsync`, `BackendCustomSetting`, multi-project init |
| `knowhow.json` | sync, async, SendQueue, Param, BackendReturnObject, unmarshal, inDate, optimize cost |
| `all-errors.json` | error catalog, statusCode, errorCode, NotFoundException, BadUnauthorizedException |
| `common-errors.json` | blocked device, bad accessToken, maintenance, too many request, handler, token reissue |

### Auth
| Topic file | Trigger keywords |
| --- | --- |
| `user-auth.json` | signup, login, custom / guest / token account, access/refresh token |
| `user-federation.json` | federation, social login, provider, account migration, platform token |

### Data & storage
| Topic file | Trigger keywords |
| --- | --- |
| `game-information.json` | shared game data, table insert/update/calculate, transaction, where-query |
| `player-data.json` | per-player data, insertData, get-my-data, transaction, reserved columns |
| `cloud-save.json` | cloud save, collection, upload/download, low-cost storage (no backup) |
| `group.json` | group, group table, get-member, segmented group |
| `chart.json` | chart, CDN content, `Backend.CDN.Content`, design/balancing data, local cache |
| `probability.json` | probability, gacha, 확률, `Backend.CDN.Probability`, lotto draw |
| `game-log.json` | game log, `InsertLogV2`, logType |

### Ranking
| Topic file | Trigger keywords |
| --- | --- |
| `leaderboard.json` | leaderboard, 리더보드, `GetLeaderboards`, `UpdateMyDataAndRefreshLeaderboard`, group/guild leaderboard, reward |
| `rank.json` (legacy URank) | URank, updateUserScore, legacy rank — deprecated, use leaderboard |

### Social & community
| Topic file | Trigger keywords |
| --- | --- |
| `friend.json` | friend, `GetFriendList`, friend request, accept/refuse/cancel |
| `message.json` | message, 쪽지, `SendMessage`, sent/received notes |
| `guild.json` | guild, 길드, `CreateGuildV4`, guild master, operator, goods, join |
| `post.json` | post, 우편, mailbox, `UPost`, post kinds (admin/rank/coupon/user) |
| `find-user.json` | find user, lookup by nickname / inDate, `GetUserInfoByNickName`, v2 |
| `random-search.json` | random search, RandomPool, random user/guild (legacy deprecated) |

### Commerce
| Topic file | Trigger keywords |
| --- | --- |
| `receipt.json` | receipt, validate receipt, Unity IAP, Google Play, iOS, ONE Store, refund |
| `coupon.json` | coupon, 쿠폰, `CouponList`, use coupon, web coupon |
| `cash.json` (discontinued) | cash, TBC, the backend cash — discontinued (SDK ≤ 5.18.7) |

### Realtime & operations
| Topic file | Trigger keywords |
| --- | --- |
| `notify.json` | notify, notification, connect, onAuthorize, realtime handler, reconnect |
| _(operation — route family only)_ | operation notice / event lists — see routes.json |

### Platform & utilities
| Topic file | Trigger keywords |
| --- | --- |
| `push.json` | push, 푸시, `PutDeviceToken`, device token, night push, android/ios |
| `region.json` | region, location, `UpdateLocationProperties`, IP-based country |
| `country-code.json` | country code, `CountryCode` enum, GlobalSupport, ISO 3166 |
| `sdk-utils.json` | server time, project status/version, get hash, filesystem |

### Backend functions
| Topic file | Trigger keywords |
| --- | --- |
| `function-product.json` | BACKND Function, backend function authoring, function auth key, dotnet, toolchain |
| _(function-base — route family only)_ | client-side `InvokeFunction` / list functions — see routes.json |

### Guides
| Topic file | Trigger keywords |
| --- | --- |
| `guideline.json` | step-by-step guideline, onboarding, all-code samples, how to implement X end-to-end |
| `tutorial-game.json` | example game, sample project, idle tycoon / idle / highscore |

## Route families without a dedicated topic file

Route straight to `knowledge-pack/routes.json` → the family → a concrete
`docs.backnd.com` child page:

- **Base-side function calls**: `/sdk-docs/backend/base/function`
- **Operation notices**: `/sdk-docs/backend/base/operation/notice`
- **Operation events**: `/sdk-docs/backend/base/operation/event`

## Verification rules (always re-check upstream)

Never present these from memory or from this pack alone — fetch the current
official page first:

- exact API / method signatures and field names
- supported federation provider lists and provider-specific permissions
- SDK download links and version-specific install steps
- payload limits, reserved-field behavior, and quotas
- receipt payload rules and store-console setup per platform
- exact error wording and current error-to-feature mappings
- deprecation/version status (e.g. rank/URank, cash/TBC, legacy Social.* APIs)
- current console labels and navigation

This skill depends on web fetch access to `docs.backnd.com`. If fetching is
unavailable, say so and mark exact/mutable claims as unverified rather than
guessing.

## Hard rules

- Do **not** invent routes, method names, or signatures not confirmed upstream.
- Do **not** verify against a bare `route_family` path; use a `source_route`.
- Prefer current features over deprecated ones: **leaderboard** over rank/URank,
  **receipt** over cash/TBC, **UPost** over Social.Post, **RandomPool** over
  legacy Social/Guild random.
- Do **not** treat `backnd-base` (client SDK) and `backnd-function` (backend
  function authoring) as the same product; Function requires Base.
- Do **not** quote download links, provider lists, or limits without a fresh check.

## Locating the knowledge pack

Paths in this skill are relative to the skill folder — the directory that holds
this `SKILL.md`. The expected layout is:

```text
<skill-root>/            e.g. .claude/skills/backnd-base/  or  .agents/skills/backnd-base/
├─ SKILL.md              ← this file (entry point)
├─ knowledge-pack/
│  ├─ manifest.json
│  ├─ routes.json
│  └─ topics/*.json
└─ schemas/topic.schema.json
```

If `knowledge-pack/` is not beside this file (e.g. the kit was vendored into a
subfolder, or this skill was installed without its data), locate it by searching
for `**/knowledge-pack/routes.json`, then resolve topic and schema paths
relative to that file.
