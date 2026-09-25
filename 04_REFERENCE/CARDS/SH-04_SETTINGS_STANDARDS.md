# SH-04 — Shared settings and project standards

**Planning:** approved
**Record:** complete — exact source recovered from the planning review chat, 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** one authority; three tiers (personal / project / firm); project data stays with the project; settings never retroactively change existing objects; fail closed; secrets never in shareable config
**Source:** planning review chat (this session) — Tim's posted SH-04 card + assistant approval

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# SH-04 — My recommended approvals

| # | Recommendation |
|---|---|
| 1 | One main command: CESETTINGS. |
| 2 | Sections: General · Civil · Structural · Project · Advanced/Admin. |
| 3 | Personal preferences saved per user. |
| 4 | Project engineering decisions saved with the project/drawing—not on one person's PC. |
| 5 | Firm standards controlled by the CE Rulebook and read-only for normal staff. |
| 6 | Existing drawing objects never change merely because settings changed. |
| 7 | Updating an existing drawing requires Preview → Apply → one Undo. |
| 8 | Old commands such as CDS redirect to the correct CESETTINGS page for one Stable release. |
| 9 | Advanced detection tolerances hidden from ordinary users. |
| 10 | Reset choices: current page, personal settings, or project settings—never one dangerous global reset. |
| 11 | Import/export excludes passwords, AI keys and client paths. |
| 12 | Corrupt settings produce a clear warning and recoverable backup. |
| 13 | Unconfirmed engineering values—especially scour velocity—cannot be silently changed or treated as approved. |
| 14 | Missing layers/styles show a repair preview; CE never silently overwrites working standards. |
| 15 | Target: 90% automated checks plus one ≤10-minute AutoCAD acceptance. |

## Timothy's approval and refinements — verbatim

✅ SH-04 (1–15) approved.

Clean settings architecture, and the shape is right: **three tiers — personal · project · firm** — each with the correct mutability. That mapping is the whole design:

| Tier | Who can change it | Where it lives |
|---|---|---|
| **Personal** (#3) | the user, freely | their PC (survives updates, RS11) |
| **Project** (#4) | via Preview→Apply | **with the drawing/project — not one PC** |
| **Firm** (#5) | admin only, via the Rulebook | central §11, read-only for staff |

🏆 **#4 is the standout — and a real correctness fix.** "Project engineering decisions saved *with the project*, not on one person's PC" fixes a genuine class of silent errors: drafter A sets the job up with Kingston rules, drafter B opens it on their machine with different local defaults, and **the design quietly changes**. Storing the project's decisions *in* the project makes it self-describing and portable — the job carries its own rules wherever it goes. This is "one authority" applied to settings.

🛡️ **#6 + #7 are the safety pair — keep them exactly as written.** A setting change is a **new default for future work (#6), never a retroactive rewrite** — so changing the default cover doesn't silently recalculate every existing pit. If you *do* want to push a changed setting onto existing objects, that's the **explicit Preview→Apply→one Undo (#7)**. Together they kill the "I changed a setting and my whole drawing moved" nightmare. Same no-silent-mutation principle as CV18/PS3/QA2.

🎯 **One genuine catch — where #4 meets #5.** A project stored under firm-rulebook **v2026-05**, opened after the firm updates to **v2026-07**: which rules apply? Per HV1 ("never silently update an existing job's rule version") and #6, the project must **keep the version it was built against** — and the drift must be **surfaced, not silently applied**: *"This project uses Rulebook v2026-05; current firm standard is v2026-07 — review to adopt."* So project settings store the rulebook version they were built against, and a firm update appears as a reviewable "project on older rules" status (adopt via Preview→Apply) — exactly the PS17/QA7 staleness pattern, one layer up. This ties #4 + #5 + #13 + HV1 together; without it you'd get either dangerous silent re-versioning or projects frozen forever with no visibility.

🔗 **Two hard-won lessons, correctly encoded.**
- **#11** (export excludes passwords/AI keys/client paths) is the **secrets-drawer + privacy** rule at the settings layer — the direct lesson of SEC-001. Shareable config must never carry a key or a client path.
- **#13** (unconfirmed values can't be silently approved via settings) protects **rulebook integrity** — you can't launder an unverified scour velocity into "approved" by typing it into a settings box. Approval stays a property of the rule (HD4), earned through the comparison test, not the UI.
- **#12** fixes the specific silent-config bug the audit found (`CeJsonLoader` returned null on any parse error → bad config failed invisibly). Now it warns loudly + keeps a recoverable backup.

📝 **Minor.** Even the scoped project reset (#10) should confirm + be undoable — it's changing the project's engineering decisions (#4), so treat it like any other project change, not a light action.

🔒 Locked, nothing starts. Consistent with the rulebook hierarchy (HD3), the provenance model, and the secrets drawer. The three-tier model with #4 at its core is the right foundation.
