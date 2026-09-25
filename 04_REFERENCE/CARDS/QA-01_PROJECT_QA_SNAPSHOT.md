# QA-01 — held Project QA snapshot foundation

**Status:** Managed foundation, Shared contributor and visible read-only Manager presentation implemented; public routing and AutoCAD acceptance remain held.

## Approved capability

1. One synchronous, read-only refresh composes the existing frozen Review reading, Check Current Drawing result and linked pit-schedule QA result.
2. The result is detached and immutable. It always contains the six approved gates: Data, Engineering Design, Plan Presentation, Details/Notes, Schedules and Issue Readiness.
3. A gate with no completed approved evidence owner is `Unknown`; it never becomes Pass because it was skipped, unavailable or not applicable.
4. The in-memory cache receives only a completed result. Reading the cache returns a separate `CachedUnverified` view, disables navigation and tells the Manager to refresh before relying on it.
5. Navigable finding rows have unique, nonblank opaque tokens. Display-only rows deliberately expose a blank token, so Shared cannot dispatch them. AutoCAD `Document`, `Database`, entity handles and evidence fingerprints stay inside the Civil service.

## Current evidence boundary

| Gate | Existing owner used now | Held result |
|---|---|---|
| Data | Check Current Drawing | Pass, Advisory or Unknown from its completed read |
| Engineering Design | frozen `ReviewReading` rule rows | Pass, Advisory, Fail or Unknown from the established severity |
| Plan Presentation | no complete approved owner in this slice | Unknown |
| Details/Notes | no complete approved owner in this slice | Unknown |
| Schedules | linked pit-schedule QA | Pass, Fail or Unknown; not-applicable remains Unknown |
| Issue Readiness | human/project evidence not yet composed | Unknown |

Because three gates remain unexamined, this foundation cannot report **Ready to Issue**. It does not add a new engineering rule or infer a project stage, checklist, detail, note or plot requirement.

## Read-only and navigation protection

- Refresh fails closed unless the calling Windows thread is the exact thread that owns AutoCAD's main window, then requires the exact active drawing and performs all AutoCAD reads synchronously under one temporary read-only document lock. Navigation repeats the same thread guard. The future Shared contributor may call these methods inline only from that proved main-thread boundary; it must not dispatch them from a background worker. There is no timer, background scan or opening scan.
- One capture generation reads the drawing-resident ProjectData once and passes that same detached object to Review, Check Current Drawing and source fingerprinting. It never substitutes `ProjectDataService.Current` or the process cache. Review and Check Current Drawing each run once; raw drawing/XREF and schedule evidence run at the opening and closing boundaries. The schedule fingerprint includes source identities, source data fingerprints and placed row authority rather than only the displayed summary/count.
- Attached DWG content is SHA-256 hashed from fresh bytes and never reused by a later generation. Surface geometry bypasses the process size/time cache, is bracketed by exact byte fingerprints, and must match both outer drawing-source fingerprints. File size and modified time remain additional evidence, not cache keys; changed bytes with identical size/time or during extraction stale the reading.
- Navigation remains a held Civil resolution seam. It accepts only the exact current snapshot object, exact active opening document/database fingerprint and one listed unique token. It takes one fresh generation and compares the aggregate fingerprint, then compares the exact target entity's private geometry/owner/layer fingerprint before returning an AutoCAD object ID for read access.
- Cached, replaced, invalidated, changed-drawing, malformed-handle and missing-object requests refuse with no selection, zoom, repair or drawing write.

## Excluded from this slice

- No `CDDASHBOARD` or Manager route change.
- No Apply, Fix, Fix All, repair, relink, migration, cache adoption into `ProjectDataService.Current`, or drawing write.
- No new Plan, Details/Notes, issue-stage, exception, dependency-graph or engineering decision owner.
- No Manager UI or public route. The Shared registry supplies the opaque reading ID; the Civil contributor keeps all AutoCAD types and exact navigation evidence private.
- This held refresh remains a synchronous foreground read on AutoCAD's main thread. It performs one call to each approved evidence owner and one exact content hash per unique attached DWG in each generation. It makes no non-blocking or large-drawing performance claim and must remain guarded by measured native acceptance.

## Nonvisual Shared contributor

- Registration publishes metadata only. It does not inspect the active drawing, start a scan or call an availability getter.
- `GetCached` reads only the contributor's last completed detached display result. The Shared registry presents it as stale and unverified; no AutoCAD document or evidence owner is touched.
- Explicit `Refresh` calls the held main-thread snapshot owner synchronously. The contributor can report `Ready` only when that exact six-gate snapshot is current and all six gates pass; the present missing owners remain `Unknown`, so the result remains `Needs attention`.
- Current readings are privately pinned to the exact active AutoCAD document. Only an exact privately bound object row exports its opaque token; display-only findings export a blank token. Navigation passes the same snapshot and nonblank token back to the existing full-evidence recapture, then selects/zooms only the exact revalidated object. A stale, changed-drawing or display-only row refuses without consuming a valid current reading.
- Document activation, document close and plugin unload invalidate accepted Shared readings, private AutoCAD state and the detached cache. No drawing data is repaired or written.

## Internal Manager presentation

- The held Manager page renders the exact six gates, read-only finding details and six fixed finding rows per page. It has no Fix or Apply action, and missing evidence remains visibly `Unknown`.
- Opening the page calls only the VM's passive metadata/cache activation. `Refresh drawing` and `Show in drawing` queue one explicit callback on AutoCAD Idle; the host removes that callback before entering Civil and never uses a background task for drawing access.
- The queued action is cancelled when the contributor, tab, active drawing or Manager window changes. The Idle callback also requires the same active drawing, selected visible QA tab and an idle AutoCAD command state before it can call the VM's exact-generation execution seam.
- The existing Manager Project QA tab is visible as a quiet read-only workspace. It has no `CDDASHBOARD` route, and its explicit Refresh still runs through the checked foreground Idle owner. No non-blocking claim is made for the synchronous evidence read.

## Managed evidence

- Pure tests cover six-gate completeness, false-clean prevention, existing-owner status projection, immutable detachment, cached-stale navigation suppression, unique opaque tokens, one call per core owner, exact opening/closing boundaries, one shared drawing-resident ProjectData object, per-generation XREF hash reuse, same-size/time byte changes and source changes during a surface projection.
- Production-boundary tests pin the three existing read owners, exact active-document/current-snapshot freshness checks, read-only entity resolution, passive cache behavior, contributor lifecycle hooks, and absence of `ForWrite`, Current/Ensure/save or background tasks. Selection/zoom occurs only after explicit navigation and exact recapture.

## Native AutoCAD acceptance still required

After the Shared contributor and Manager page are reviewed and wired: open Project QA, confirm no DBMOD change, inspect a known warning/Unknown/true Pass, switch drawings, change one reviewed object, test stale navigation refusal, refresh, navigate a current row, close/reopen and confirm cached results remain visibly unverified.
