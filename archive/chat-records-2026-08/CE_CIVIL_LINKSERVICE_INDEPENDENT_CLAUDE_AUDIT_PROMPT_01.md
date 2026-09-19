# Independent Claude Code audit — CE Civil LinkService bounded command tracking

Copy everything below into a fresh Claude Code session.

---

You are performing a fresh, independent, adversarial **read-only source audit** of one isolated CE Civil AutoCAD plugin correction.

## Exact source claim

- Repository: `C:\Lisp Files\CE_ACAD_PLUGIN`
- Worktree to inspect: `C:\Lisp Files\CE_ACAD_PLUGIN\.codex\worktrees\civil-linkservice-bounded-scans`
- Branch: `codex/civil-linkservice-bounded-scans`
- Base commit: `0f77aa480687f1fd16083515c23e415bd212dc91`
- Base tree: `a17d2964bd365a997e06f24486111970c762a566`
- Source correction commit: `94b892f561e9bf6790743c5351e547bd8a9ba7c5`
- Final candidate head: `851707b1e2bcfcbe58f3378b3c9a2cd87fbbe05c`
- Final candidate tree: `c999950920eb97065afd2539bdad831393013e95`
- Remote branch: `origin/codex/civil-linkservice-bounded-scans`

Confirm these exact values before reviewing. Stop and report `SOURCE CLAIM MISMATCH` if the candidate worktree is dirty or the commit/tree differs.

## Important version boundary

The active monorepo source identifies as Civil 2.1.12. A historical standalone archive contains an exact Civil 2.1.10 commit (`4d1c46bdb72bdb36d3f1989363759b0a95fdfeea`), but repository instructions say that archive is not the live development source. No archive or rejected R8-R12 candidate code was copied into this correction. Audit this boundary and report it as a packaging decision, not permission to merge or copy older code.

## Permitted actions

- Read `AGENTS.md` files and the exact candidate diff.
- Read related Civil production source and tests needed to understand invocation and protections.
- Run read-only Git commands such as `status`, `show`, `diff`, `grep` and `log`.
- Report source findings with file and line references.

## Prohibited actions

- Do not edit any file.
- Do not build, test, package, sign, publish or deploy.
- Do not start or control AutoCAD.
- Do not touch ApplicationPlugins.
- Do not inspect or change Structural, Manager or AutoCADLink except where a repository guard test name appears in existing recorded results.
- Do not merge/copy R8, R9, R10, R11, incomplete R12 or the historical standalone 2.1.10 archive.
- Do not broaden the correction.

## Defect to audit

Civil LinkService previously reacted to ordinary AutoCAD commands by synchronously walking all ModelSpace polylines. A Structural drawing with zero Civil pits and roughly 141-218 ordinary polylines showed 213 polylines snapshotted during COPY, followed by another ModelSpace reconciliation pass. `CDDEBUG OFF` hid messages but did not remove the command/cursor lag.

## Required AutoCAD behaviour

1. Structural/non-Civil drawings perform zero Civil full-ModelSpace snapshot or reconciliation work.
2. `MOVE`, `STRETCH`, `ROTATE` and grip transforms never perform clone discovery.
3. `COPY` and `MIRROR` inspect only actual appended/changed objects in a drawing already proven to contain CE Civil data.
4. Ordinary polylines never become Civil pipe candidates merely because they are polylines.
5. While linking is suspended, only relevant changed CE identities are captured; linked children update once at command completion.
6. Cancelled/no-op commands perform no reconciliation, rebuild or scan.
7. Repeated redraw, snap, selection, hover and cursor callbacks perform no new database scan or transaction.
8. Genuine unsafe Civil COPY remains blocked or correctly reconciled. `CDWT` copy protection must not weaken.
9. Xrefs remain read-only; locked-layer, REFEDIT and unsupported-object protections remain intact.
10. `CDDEBUG OFF` produces no Civil debug echo.
11. Nested `C`/`CR`/`MR` command flows do not resume Civil reactors before the outer command finishes.
12. One Undo and save/reopen must preserve an accepted result; source must not add new rebuilds to empty/cancelled commands.

## Exact candidate file scope

- `Modules/Drainage/Services/ExternalMutationCommandPolicy.cs`
- `Modules/Drainage/Services/LinkService.ExternalAttachmentMoves.cs`
- `Modules/Drainage/Services/LinkService.Cache.cs`
- `Modules/Drainage/Services/LinkService.Persistence.cs`
- `Modules/Drainage/Services/LinkService.Reactors.cs`
- `Modules/Drainage/Services/LinkService.RepairAudit.cs`
- `Modules/Drainage/Services/LinkService.SourceMoves.cs`
- `Modules/Drainage/Services/LinkService.State.cs`
- `Modules/Drainage/Services/LinkService.Utilities.cs`
- `Modules/Drainage/Services/LinkService.cs`
- `Modules/Drainage.Tests/Services/LinkServiceCommandPerformanceContractTests.cs`

Confirm no other file changed between base and candidate.

## Recorded Codex checks to challenge, not trust

- Focused bounded-command tests: net10 `27/27`; net48 `27/27`.
- Wider LinkService/WorldDraw/copy group: `72/72`.
- Full net10 Civil suite: `3,508 passed`, `5 failed`, `13 skipped`, `3,526 total`.
- Five failures were recorded as pre-existing cross-module command/asset guards (four) and unrelated pit-suggestion rounding (one).
- Release Civil builds: net10/net8/net48 each completed with `0 errors` and existing warnings.
- Every dotnet command included `-p:SkipDevBundle=true -nr:false --disable-build-servers`.
- No package or live deployment was made.

## Known risks requiring particular scrutiny

1. AutoCAD event order cannot be fully proven outside live AutoCAD.
2. Very old CE drawings with link records but no Civil drawing identity/project record may open as ordinary and require an explicit read-only adoption path.
3. Whole-pipe child COPY/MIRROR mapping is an older protection boundary; confirm this correction does not weaken it or leave clone children sharing the original owner.
4. Check event subscription/unsubscription symmetry for `ObjectAppended`.
5. Check nested command depth on completed, cancelled and failed inner/outer commands.
6. Check that appended ObjectIds remain safe to inspect after command completion, including erased/invalid IDs.
7. Check that moving a child with its owner does not store a false independent position, and moving only the child does persist its visible drafting decision.
8. Check that the ownership gate cannot cause per-command ModelSpace discovery to return through another path.
9. Check all new logging is diagnostic-only and silent when `CDDEBUG` is off.

## Required audit format

Return:

1. `PASS`, `PASS WITH CONDITIONS`, or `FAIL`.
2. Findings ordered Critical, High, Medium, Low.
3. For each finding: exact file/line, evidence, real AutoCAD failure scenario, and smallest safe correction.
4. Direct answer against each of the 12 required behaviours.
5. Whether the candidate is safe to advance to an **unsigned, non-live package build** after Tim's AutoCAD checklist passes.
6. Exact remaining AutoCAD checks that source review cannot prove.
7. Explicit confirmation that no Structural/Manager/AutoCADLink/ApplicationPlugins change is required.

Do not approve engineering design. This is a source safety/performance audit only.

---
