# PS-01F1 — Placement readiness reasons

**Stage:** planning and current/proposed visual review only
**Decision:** awaiting Tim's visual approval through the CE AutoCAD Control Room
**Implementation:** not started
**AutoCAD verification:** not started
**Deployment:** not authorised
**DATA-01:** remains blocked

Visual review pack:

- [Current versus proposed placement readiness](../image/PS-01/ps-01f1-current-vs-proposed.png)
- [Advisory-only confirmation and state rules](../image/PS-01/ps-01f1-advisory-confirmation.png)

No WPF or product source may be changed until Tim approves this visual.

## User-reported bug

| Record | Exact result |
|---|---|
| Tim did | Opened the new `PITSCHEDULE` workflow and tried to continue/place. |
| Tim expected | CE to state every reason placement was stopped, identify the affected drawing/XREF/schedule/pit/pipe, and say what to fix. |
| Tim saw | CE correctly stopped insertion, but the reason and repair route were not clear. |
| Current cause | `PitScheduleWorkflowState.CanPlaceOrUpdate` collapses readiness to one Boolean. Disabled Place/Continue controls have no visible reason, and the fallback can be only `Update blocked — review the listed schedule issue.` |
| Regression guard | Behaviour tests must prove every existing finding becomes a visible advisory or blocker, every disabled primary action has the same visible reason and tooltip, and no blocked/cancelled path writes, dirties the DWG, creates Undo, or duplicates a schedule. |

## Current versus proposed

```text
CURRENT
placed status + reviewed differences → one true/false workflow switch
                                      → disabled Place / Continue may be vague

QA, informational pre-flight and row warnings exist separately today;
they do not feed CanPlaceOrUpdate.

PROPOSED
the same existing findings (no new checker)
                   ↓
one pure placement-readiness projection
         ↙                         ↘
ADVISORY — may acknowledge once    BLOCKING — cannot bypass
         ↓                         ↓
exact asset + fix + route          exact asset + fix + route
```

The complete schedule stays visible while the Problems panel is visible. The
panel is not a replacement for Full Schedule or Changes Only.

## One reused readiness model

PS-01F1 will add one AutoCAD-free projection model, tentatively
`PitSchedulePlacementReadiness`. It does not inspect a DWG, calculate a second
status, compare a second snapshot, or invent another fingerprint.

It consumes only already-produced evidence:

| Existing authority | Evidence reused |
|---|---|
| `PitScheduleStatusResult` | Current, Out of date, Missing, Unloaded, Conflict and exact source detail |
| `PitScheduleDifferenceResult` | Added/removed/changed rows and blocking source, identity or stale-override conflicts |
| `PitScheduleQaResult` | Missing/duplicate/damaged/unlinked authority, duplicate displayed pit number and unprovable baseline |
| `ProjectDataSanityResult.Findings` | Existing duplicate IDs/handles, orphan references and missing/unparsable source data |
| Existing schedule rows | Existing depth/diameter warning computation, source identities, pit/pipe handles, schedule set and row count. Readiness consumes the computed warning evidence before the `Highlight warnings` presentation toggle masks row styling. |
| Existing source options | Display name, source path, load/readiness state and read-only XREF identity |
| `PitScheduleUpdateGuardResult` | Last-moment authority/source/preview change reason before a write transaction |

The projection shapes each existing finding into one immutable display item:

```text
Severity + stable finding key + headline + exact reason
+ drawing/XREF + schedule set + pit/pipe/authority where known
+ plain-English repair action + available route(s)
```

Unknown or incomplete evidence fails closed as **BLOCKING — Could not verify;
review required**. The last proven schedule/status remains visible.

## Classification

### Advisory — placement is allowed after one acknowledgement

| Existing finding | Required wording and action |
|---|---|
| Existing shallow-depth result where depth is below `0.30 m` | `Shallow pit (<300 mm) — advisory only; placement is allowed.` Name every affected pit/source/set and show the measured depth. Ask staff to confirm cover/inverts or correct the source. The `IsShallow` orange-row presentation flag is not the authority for readiness. |
| Existing diameter warning (`OUTLET SMALLER THAN INLET`) | `Outlet diameter is smaller than inlet — advisory only; placement is allowed.` Name the pit and affected inlet/outlet pipe values. Ask staff to confirm deliberate restriction or correct the source. |

Orange colour is supplementary. Every advisory also has the `△ ADVISORY`
heading, warning icon, words `advisory only`, and words `placement is allowed`.

### Blocking — never bypassable

| Existing evidence | Required visible result |
|---|---|
| Status is Out of date but differences have not been reviewed | Name the linked schedule/source and require **Review Changes**. |
| Missing, unloaded, unreadable or unverified XREF/source | Name every XREF and affected schedule/pits where known; require load/repair followed by **Refresh**. Preserve placed graphics. |
| Difference `BlocksUpdate`, stale override, unavailable source or identity conflict | Show the exact difference and require its existing review/repair action. |
| Duplicate displayed pit numbers or pit IDs | Name every pit and every source drawing; require rename/correction in the source. |
| Duplicate, unlinked, copied-authority, unreadable, read-failed or otherwise damaged authority/baseline | Identify the schedule/block/drawing evidence that can be shown; require deliberate authority repair/replacement. Never choose one silently. |
| Duplicate pipe handle, orphan/corrupt link, missing permanent identity or impossible ownership affecting a selected schedule row | Name every affected pit/pipe/source and require source repair/relink. |
| Source identity/data is unreadable or cannot be proven, or the host schedule/apply target cannot be written safely | Name the source or host authority and direct staff to Refresh, reopen or repair it. |
| No selected source or zero proposed rows | State `Nothing can be placed — the selected schedule contains 0 rows.` Direct staff to select a source/set, include eligible pits, then Refresh. |
| Last-moment guard fails | Show the exact guard message, keep the old schedule, and require Refresh/Reopen/Review as stated. No transaction starts. |

A valid selected XREF shown as `Ready · read-only` is expected and
**non-blocking**: its engineering data must remain read-only while the host owns
the placed schedule. `Read-only` becomes a blocker only when the host/apply
target cannot be written safely or when the XREF/source evidence is unreadable
or unproven.

Existing pre-flight kinds are mapped individually rather than promoted as one
blanket blocker:

| `ProjectDataSanityResult` kind | Readiness treatment |
|---|---|
| Duplicate pit ID | Hard blocker under PS5; list every duplicate identity/source. |
| Orphan pipe reference | Hard only when it is the corrupt link/impossible ownership of a selected schedule row; otherwise show it as an advisory source repair. |
| Duplicate pipe handle | Hard only when it makes a selected row's pipe ownership ambiguous; otherwise show it as an advisory source repair. |
| Missing/unparsable pit level, pipe invert or pipe diameter | Advisory source-data warning unless an existing status/difference/QA authority separately proves the source or placement baseline damaged/unverified. |
| Excluded from schedule | Remains visible in Full Schedule with its reason under PS7; it is not itself a placement problem or acknowledgement. |

This preserves the current informational pre-flight contract while applying the
approved PS5 critical rules at the selected placement scope.

A current placed schedule is not labelled damaged: its disabled Update action
must visibly say `Already current — no update is required.`

## Routes

Each finding shows only routes that are meaningful and safe:

- **Review Changes** — existing read-only comparison view;
- **Refresh** — existing explicit refresh route;
- **Open source DWG** — existing close-then-open route for XREF engineering data;
- **Locate** — existing current-drawing highlight/identity route, or source-qualified
  navigation after opening the source. A missing identity never becomes a guessed
  selection.

Routes never weaken the placement guard. A disabled Place/Update/Continue
control has:

1. a visible reason beside it;
2. the same concise tooltip with `ToolTipService.ShowOnDisabled`;
3. no Enter/default-button path that can invoke the mutation command.

## Advisory acknowledgement

When blockers are zero and advisories are non-zero, the primary action becomes:

`Proceed once with N warning(s)`

Activation opens a confirmation that repeats every advisory and the exact
placement/update scope. The user must choose **Cancel** or
**Confirm and place/update**.

The acknowledgement is:

- bound to this placement/update proposal, source fingerprint(s), schedule
  instance/set and stable advisory keys;
- invalidated by Refresh, source/schedule change, row change, dialog reopen or
  cancelled point selection;
- recorded with the placed/update review evidence as an acknowledgement of
  the warnings shown;
- never a global setting, suppression, remembered preference, or permission to
  bypass a hard blocker.

The final command reuses the existing last-moment guard. If readiness changes
between confirmation and write, CE stops and returns to the Problems panel.

## Visual and interaction contract

| Area | Required behaviour |
|---|---|
| Full schedule | Remains visible before approval; the Problems panel occupies a stable right column and scrolls independently. |
| Problems panel | Always visible. Clean state says `✓ No placement problems`. Findings are separated under `■ BLOCKING` and `△ ADVISORY`. |
| Primary action | Hard blockers: disabled with visible reason. Advisory only: `Proceed once with N warning(s)`. Clean: existing Place/Update text. |
| Focus | On open, focus remains on Full Schedule. A new blocker moves accessible focus to the Problems heading, not unpredictably into a button. |
| Tab order | Full Schedule → Review Changes → source actions → Problems findings/routes → Cancel/back → primary action. |
| Enter | Invokes only an enabled, visually identified primary action. It cannot bypass warning confirmation or a hard blocker. |
| Escape | Closes the confirmation first; from the main window it follows existing Cancel/close protection. No drawing write, dirty state or Undo. |
| Targets | Every action is at least 44 DIP high/wide enough for its label. |
| DPI | No clipped reason, route or primary action at 100%, 125%, 150% or 200%; schedule and Problems panel scroll independently at minimum size. |
| Runtime tiers | Same wording, order, keyboard behaviour and safety on net48/AutoCAD 2022–24, net8/2025–26 and net10/2027+. Only the approved WPF presentation resources may differ. |
| Colour | Red/orange/green never carries meaning alone; icons, headings and explicit words always remain. |
| Highlight warnings toggle | May hide orange row styling only. It never removes a shallow/diameter advisory, changes readiness, clears acknowledgement requirements or enables Place/Update. Reuse the existing warning computation; do not add a second checker. |

## Required behavioural tests before implementation can close

1. Shallow-depth advisory and diameter advisory each allow only the one-time
   confirmation path; acknowledgement is proposal-bound and recorded.
2. Status-only Out of date requires Review Changes; current status explains
   why Update is unavailable.
3. Every blocking comparison conflict is listed, not just the first.
4. Missing/unloaded/unverified XREF lists every affected source and preserves
   the placed schedule.
5. Duplicate/unlinked/copied/damaged/read-failed authority is non-bypassable.
6. Duplicate pit number/ID and corrupt link list every known drawing, pit and
   pipe plus a repair action.
7. Zero rows and no selected source show a visible reason before any click.
8. Disabled buttons expose the same visible reason and tooltip; Enter cannot
   invoke them.
9. Cancel/Escape, cancelled point selection and failed confirmation create no
   DWG write, DBMOD change or Undo record.
10. Successful update still uses the same authority/insertion point, creates
    no duplicate schedule and remains one AutoCAD Undo.
11. Keyboard/focus and 44-DIP targets pass at 100/125/150/200% DPI in all
    three runtime presentation tiers.
12. Tests exercise public behaviour and rendered accessibility state, not
    source-text matching.
13. With `Highlight warnings` off, orange row styling may disappear but the
    same shallow/diameter advisory remains in Problems and still requires the
    one-time acknowledgement.

Use the smallest proving layer:

| Test layer | What it must prove |
|---|---|
| Pure unit tests | Deterministic classification, ordering, exact affected assets/routes, fail-closed unknowns, proposal-bound advisory keys and zero-row readiness. |
| ViewModel integration tests | Existing status/difference/QA/pre-flight/row evidence feeds one readiness result; commands, visible reason and tooltip state agree; blocked/default/Enter paths cannot invoke placement. |
| WPF interaction tests | Logical focus/tab order, disabled-button help, confirmation Escape/Enter behaviour and 44-DIP controls through the rendered control/accessibility tree. Do not prove this by searching XAML text. |
| Visual regression matrix | Full Schedule and Problems remain readable at the minimum window size and 100/125/150/200% DPI for Legacy, Modern and Fluent presentation resources. |
| AutoCAD acceptance | DBMOD/Undo/no-duplicate/no-XREF-write evidence for Cancel, cancelled point, blocked, advisory-confirmed, successful place and successful update paths. |

## Implementation boundary after visual approval

The later source increment may add the pure readiness projection, ViewModel
bindings, WPF panel/confirmation, acknowledgement evidence and behaviour tests.
It must not add a command, palette, checker, fingerprint, XREF writer/reloader,
schedule mutation bypass, periodic scan or deployment step.

## Gate

This checkpoint stops at the plan and visual pack. Implementation starts only
after Tim approves the proposed visual through the Control Room.
