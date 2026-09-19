# PS-01D — Plan–schedule difference and refresh plan

**Decision:** workflow approved under PS13, PS16–PS19 and PS21
**Implementation:** PS-01D1 engine, UI-03A guided shell and PS-01D2–D5 complete in source
**AutoCAD verification:** UI-03A/PS-01D2–D5 not yet verified in AutoCAD
**Deployment:** not authorised
**DATA-01:** remains blocked

**UI-03 visual:** approved by Tim 2026-07-23 in
[`UI-03_PITSCHEDULE_VISUAL_REVIEW.md`](UI-03_PITSCHEDULE_VISUAL_REVIEW.md);
UI-03A is implemented in source

## What staff should see

```text
Plan or drainage XREF changes
              ↓
Inspector quietly shows:  Pit schedule — OUT OF DATE
              ↓
Open PITSCHEDULE / Civil Hub
              ↓
┌────────────────────────────────────────────────────┐
│ SCHEDULE CHANGES                                   │
│ + Added        P7                                  │
│ ↕ Changed      P3 outlet IL   42.15 → 42.13       │
│ ↕ Changed      P10 lid        Class B → Class C    │
│ − Removed      P12                                 │
│                                                    │
│ Schedule-only overrides kept and clearly marked   │
│              [Cancel]  [Update existing schedule] │
└────────────────────────────────────────────────────┘
              ↓
Same insertion point · no duplicate · one Undo
```

Opening or checking the schedule is read-only. Nothing updates until the user
reviews the differences and chooses `Update existing schedule`.

## Audit result

PS-01A/B/C already provide most of the identity foundation:

| Existing part | What it already gives PS-01D |
|---|---|
| `ProjectDataFingerprintService` | Canonical source-data fingerprint |
| `PitScheduleHostInstanceRecord` | Host block, source drawing identities, selected sets, placement and placed fingerprints |
| Qualified XREF asset identities | Same handles in different DWGs cannot collide |
| External cell stored values | Last placed value is available for comparison |
| `PitScheduleBuilder` | Current logical rows from local or selected XREF data |
| Per-cell override store | Schedule-only values and linked originals |

The missing part is one **logical placed-schedule snapshot + pure comparison
service**. The current `RefreshLinkedCells` is an immediate cell writer for local
links; it is not the approved preview/update-in-place workflow and must not be
expanded into the PS-01D engine.

## One comparison model

Every placed logical row needs:

- schedule instance identity;
- source drawing identity;
- permanent pit identity;
- inlet/outlet pipe identities;
- schedule set;
- each displayed field's last linked value;
- each schedule-only override and the linked value it was based on;
- placed source fingerprint and time/revision label.

Comparison is by permanent/qualified identity, never displayed pit number,
object handle alone or file path alone.

## Difference types

| Type | Plain-English display | Apply behaviour |
|---|---|---|
| Added | `P7 added` | Add row at approved natural/custom order |
| Removed | `P12 removed from source` | Remove linked row after preview |
| Changed | `P3 outlet IL 42.15 → 42.13` | Update the exact field |
| Moved/reordered | `P10 moved within Main Schedule` | Preserve deliberate custom order unless user accepts reorder |
| Override still valid | `P5 remarks override unchanged` | Keep and mark amber |
| Override now stale | `Linked IL changed since override was set` | Require Restore / Keep override / Update source decision |
| Source unavailable | `Drainage XREF unloaded` | Preserve graphics; Update disabled |
| Ambiguous identity | `Duplicate P1 across two sources` | Block Update; name both sources |

## Safe increments

### PS-01D1 — pure snapshots and differences

- **Complete in source.** Added an AutoCAD-free placed-row snapshot schema;
- added a pure comparison service returning added, removed, changed, reordered,
  stale-override, unavailable and conflict results;
- stable source-qualified identities support both Current drawing and XREF rows;
- duplicate row identities and duplicate fields fail closed instead of choosing
  one silently;
- the logical snapshot survives JSON save/reopen with override basis intact;
- the comparison engine cannot read or write a DWG.

Focused automated proof: 13/13 cases pass on both `net48` and
`net10.0-windows`. The placed/update workflow does not populate the snapshot
until a later increment, so this completion changes no staff-visible behaviour.

### PS-01D2 — passive status only

- **Complete in source.** Reads placed authority records and fresh source
  fingerprints in one read-only model-space/XREF snapshot;
- shows `Current`, `Out of date`, `Missing`, `Unloaded` or `Conflict` in
  `PITSCHEDULE` and the Inspector project summary;
- names the affected source DWG and preserves the placed schedule when its
  source is missing, unloaded, unreadable or ambiguous;
- an older schedule without a CE authority record is shown as
  `Unlinked schedule`, never mistaken for an empty drawing;
- removed the old command-line offer to delete/re-place an existing schedule
  before the window opens;
- at the D2 boundary, existing-schedule update remained locked. PS-01D4 now
  supplies the explicit update-in-place path. No automatic schedule refresh
  and no new command were added.

Automated proof: 11/11 passive-status/adapter contracts and the 43/43 combined
schedule workflow pass on both `net48` and `net10.0-windows`. The full modern
suite passes 3581/3581 with the unrelated existing PDF-preview test excluded
and 13 intentional live-AutoCAD skips. All three supported build lanes compile
with zero errors using `-p:SkipDevBundle=true`.

This increment makes the new status scan itself read-only. The approved PS3
conversion is now also complete: opening and Refresh do not run drawing repair
or relink calls, passive relinking cannot snap endpoints to pit boundaries, and
elevated/tilted pipe geometry fails closed. Explicit Relink + Recalculate
remains available for deliberate user action.

### UI-03A — guided schedule shell

- **Complete in source.** `PITSCHEDULE` opens on the complete full schedule;
- three clear steps guide staff through Full Schedule, Changes Only and
  Place/update;
- advanced setup and options remain available but start collapsed;
- Changes Only and update actions fail closed until later PS-01D increments
  provide a safe comparison;
- Cancelled insertion returns to the schedule; successful placement keeps the
  existing close-without-reopen behaviour.

Focused state and XAML proof passes 7/7. The combined schedule workflow passes
19/19 on both `net48` and `net10.0-windows`. All three supported build lanes
compile with zero errors using `-p:SkipDevBundle=true`. AutoCAD verification
and deployment remain pending.

### PS-01D3 — visual difference review

- **Complete in source.** Every newly placed linked schedule stores the exact
  logical rows, displayed fields, permanent identities, source fingerprints
  and selected schedule sets that staff approved;
- when that schedule becomes out of date, `Changes Only` shows added, removed,
  moved and exact old → new field values, grouped by source DWG and schedule
  set;
- the complete proposed schedule remains available under `Full Schedule`
  before approval;
- missing/unloaded sources, identity conflicts and stale overrides remain
  visibly blocking. The existing placed schedule is never changed by review;
- at the D3 boundary, older schedules without a snapshot showed
  `Preview unavailable`. PS-01D4 now presents their deliberate
  `FIRST LINKED UPDATE` full-replacement review;
- Update stayed disabled at the D3 boundary. PS-01D4 now enables it only after
  a reviewed, revalidated proposal can use the approved same-block transaction.

Automated proof: 17/17 D1+D3 snapshot/difference cases pass on both `net48` and
`net10.0-windows`; the full modern suite passes 3585 tests with 13 intentional
live-AutoCAD skips and the unrelated PDF-preview test excluded. All three
supported build lanes compile with zero errors using
`-p:SkipDevBundle=true`. No bundle was created or deployed.

### PS-01D4 — update existing schedule

- **Complete in source.** Retains the exact authoritative schedule block and
  its current WCS insertion point; no second block or point prompt is used;
- re-discovers and rebuilds the source immediately before Apply. A changed
  preview, changed authority/baseline, changed source selection, missing or
  unloaded source, duplicate identity or stale override blocks update;
- erases only cells owned by that schedule instance. The first conversion of
  an older linked schedule adopts only CE-layer text exactly on its known grid
  and stops if the block was moved without all of its text;
- row height, replacement MText, every per-cell owner/link record and the new
  placed snapshot/fingerprints commit in one AutoCAD transaction. Any failure
  leaves the old block, cells and baseline intact;
- the complete proposed schedule remains visible before approval. Older linked
  schedules without a snapshot show `FIRST LINKED UPDATE` and require the same
  explicit Update action to establish their first exact baseline;
- Cancel is read-only and successful Apply closes the window without reopening.

Automated proof: 11/11 focused update guards/contracts pass on both `net48` and
`net10.0-windows`; 184/184 modern schedule tests pass. The full modern suite
passes 3596/3596 executed tests with 30 intentional skipped/explicit cases and
the unrelated existing PDF-preview test excluded. All three supported build
lanes compile with zero errors using `-p:SkipDevBundle=true`. AutoCAD proof of
same point, no duplicate, one Undo and save/reopen remains required.

### PS-01D5 — final-drawing checks

- **Complete in source.** `CDCHECKDWG` and the existing `CDDASHBOARD` project
  QA surface consume one shared, read-only final-drawing schedule result;
- final/XREF host drawings report a missing linked schedule, stale or
  unavailable source, duplicate authoritative instances, duplicate displayed
  pit numbers and an older linked schedule whose exact row baseline is not yet
  available. Ordinary Civil source drawings with no host/XREF schedule are not
  incorrectly failed;
- multiple inlet rows for one logical pit are counted once, so they do not
  create a false duplicate-pit warning;
- every new or updated authority records its exact owning block handle.
  AutoCAD copies that retain the original handle, and loose copied graphics
  beside a valid authority, remain inert. A genuinely separate linked
  authority still fails as a conflict;
- the adapter reads model space and the XREF graph only. It has no placement,
  update, save or repair path and registers no new AutoCAD command.
- independent audit corrections keep copied/unlinked visible graphics inert
  but report them beside a valid authority, include every visible
  Warning/Error in the dashboard issue total, reject damaged row/source/field
  baselines, and keep unreadable/read-failed evidence visible as a blocking
  Unknown/Conflict instead of filtering it out.

Automated proof: the original 35/35 PS-01D5/CDCHECKDWG cases and the
post-audit guard set pass together as 57/57 focused checks on both `net48`
and `net10.0-windows`. The modern full suite passes 3630/3630
executed tests with 13 intentional skips and the unrelated WebView2 PDF test
excluded. All three supported release lanes compile with zero errors using
`-p:SkipDevBundle=true`. The broader legacy suite still has its known
out-of-AutoCAD native-host load failures; all D5 tests pass there. The
post-audit guard set adds exact schedule-only issue-count, copied-handle,
unlinked/unavailable, blank/duplicate row identity, source identity and field
identity cases on both testable runtime lanes.

## Required automated situations

| Situation | Expected |
|---|---|
| Same source, same values | Current; empty difference list |
| One field changed | One exact old → new field |
| Pit added/removed | One added/removed logical group, including multiple inlet rows |
| Displayed pit renamed, permanent identity same | Changed name, not remove + add |
| Same handle in two XREFs | Kept separate by drawing identity |
| Source attached twice | One source by default |
| Source unloaded/missing | Preserve schedule; Update disabled |
| Duplicate pit numbers across sources | Conflict; no Apply |
| Manual row | Preserved and source-labelled |
| Valid schedule-only override | Preserved |
| Linked value changed behind override | Stale override requires decision |
| Drawing changes after preview | Apply disabled; recalculate required |
| Cancel | Schedule, block, cells and fingerprint unchanged |
| Apply failure midway | Transaction aborts; old schedule survives |
| Successful Apply | Same insertion point/block authority; one Undo; no duplicate |
| Save/reopen | Status and authoritative-instance identity persist |

## Tim's later AutoCAD check

1. Place one schedule in a disposable final DWG.
2. Change P3 outlet IL, add P7 and change P10 lid in the source.
3. Save/reload the source and confirm the host says `Out of date` without
   changing the placed schedule.
4. Open the preview and confirm the three exact differences.
5. Cancel and confirm the drawing remains unchanged.
6. Preview again, update, and confirm the schedule stays at the same point.
7. Run `U`; confirm the complete previous schedule returns.
8. Unload the XREF; confirm the old graphics remain and Update is disabled.
9. Save/reopen and confirm status and authority remain correct.

## Gate

PS-01D1, UI-03A and PS-01D2–D5 are complete in source. AutoCAD verification
remains required. No deployment is authorised by this planning record.
