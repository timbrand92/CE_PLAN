# PS-01 — Pit schedule production workflow

**Planning:** approved
**Record:** complete — exact source recovered from the planning review chat, 2026-07-22
**Implementation:** PS-01A placement close, PS-01B read-only XREF discovery, PS-01C host-owned XREF placement, PS-01D1 pure comparison, UI-03A guided shell, PS-01D2–D5 linked status/review/update/final-drawing QA, PS3 read-only geometry safety, PS14 twenty-row right continuation, and PS-01E1/E2 passive watcher coordination/lifecycle adapter implemented in source
**Visual review:** UI-03 PITSCHEDULE proposal approved by Tim 2026-07-23; UI-03A and passive/exact status review built in source
**AutoCAD verification:** not started
**Design rules enforced:** one schedule authority (data is truth, schedule is a view); read-only open; stable row identity; provenance + staleness; preview→apply→one Undo; no silent override
**Source:** planning review chat (this session) — Tim's posted PS-01 card (PS1–PS15) + additions (PS16–PS20) + assistant approvals

**PS14 source checkpoint, 2026-09-10:** the approved V2 delivery brief is
the governing capacity authority: each CE master carries at most 20 rows. The
byte-identical shipped `Pit Schedle.dwg` masters provide the 750-unit row height
and 17,500-unit right-hand pitch, but do not themselves encode the number 20.
Rows 21 and 41 therefore restart at the first row of a complete repeated master
17,500 and 35,000 units to the right. Each master stretches only for its own
rows. The owning schedule record stores the exact continuation block handles;
update and network redesign grow or shrink those blocks with their cells and
baseline in the same transaction. Legacy records with no continuation handles
start as one-master records and never adopt a nearby block. `Right` is the only
implemented side; any other persisted value refuses explicitly. New placement
does not erase pre-existing text by proximity. A pit group that crosses a
20-row boundary repeats its identifying group cells at the top of the next
master while CSV grouping remains unchanged. Rotated, scaled or tilted schedule
masters are an explicit current limitation and refuse before any drawing change.

**PS14 AutoCAD checklist (pending):**

1. Place schedules containing 20, 21 and 41 rows. Expect one, two and three
   complete masters; row 21 and row 41 restart at the top of the next master.
2. Confirm the masters are 17,500 units apart and each `ROW NUMBERS` stretch
   matches only its own rows: 15,000 for 20 rows and 750 for one row.
3. Update one linked schedule from 19→21→19 rows. Expect the right master to be
   added and then removed; one Undo at each step restores the prior complete
   schedule.
4. Repeat with the continuation master on a locked layer, then with a copied
   loose schedule beside it. Expect a full refusal/no change for the protected
   owned child and a visible QA conflict for the copy; neither is adopted.
5. Rotate or scale an owned master, then try update. Expect an explicit
   world-aligned/scale-1 refusal with no master or cell movement.
6. Place a schedule beside existing MText on a schedule text layer and use one
   pit with rows 20 and 21. Expect the nearby text to remain and the pit heading
   to repeat at the top of the second master.
7. Save/reopen the 21-row drawing, update it, then run the same grow/shrink path
   through an approved network redesign. Expect the same owned master handles
   and no duplicate header or loose cell text.

**PS-01E planning gate, approved 2026-07-24:** the dedicated
[XREF network watcher plan](../workflows/PS-01E_XREF_NETWORK_WATCHER_PLAN.md)
and current/proposed visual are approved for the bounded E1–E4 read-only
implementation. It reuses the existing PS-01D2 status/fingerprint, adds no new
checker or command, and never refreshes a schedule automatically.

**PS-01E source checkpoint, 2026-07-24:** E1 now owns the deterministic
one-second quiet/five-second throttle coordinator. E2 now owns the transient
AutoCAD document lifecycle, active-document XREF command-end hints, safe Idle
gate, close/switch cancellation, explicit refresh route and one read-only reuse
of the existing PS-01D2 status authorities. E3 Civil Hub presentation and E4
AutoCAD/DBMOD/Undo runtime evidence remain gated. The final E2 source audit is
PASS; the net48 and net10 watcher/status/discovery suites each pass 78/78 and
net48/net8/net10 builds complete with zero errors.

**PS-01F1 planning gate, 2026-07-24:** Tim reported that the new guarded
`PITSCHEDULE` correctly stopped insertion but did not clearly show every reason
or repair action. The bounded
[Placement Readiness Reasons plan](../workflows/PS-01F1_PLACEMENT_READINESS_REASONS_PLAN.md)
and [current/proposed visual](../image/PS-01/ps-01f1-current-vs-proposed.png)
are now prepared for visual approval. The proposal reuses the existing
status/difference/QA/pre-flight/row-warning evidence through one pure readiness
projection; it adds no second checker. Shallow pits below 0.30 m and existing
outlet-smaller-than-inlet diameter findings are advisory and may be
acknowledged once per placement. Authority/source/duplicate/damaged/read-only/
unverified-XREF conditions remain non-bypassable; `read-only` here means an
unwriteable host/apply target, not a valid XREF whose engineering data is
intentionally read-only. WPF/source implementation is not started and must
wait for Tim's approval through the Control Room.

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# PS-01 — Pit Schedule Production Workflow

### Current AutoCAD state

| Area | Assessment |
|---|---|
| Schedule calculations | Strong and well-tested |
| Linked pit/pipe rows | Working |
| Multiple schedule sets | Working |
| Per-cell overrides | Good foundation |
| Manual rows | Working |
| Placed schedule linking | Working but complicated |
| Opening speed | Major problem on large drawings |
| Existing schedule update | Awkward delete/re-place prompt |
| Automatic relinking | Runs on opening and may silently alter data |
| Interface | Too many controls competing for attention |
| Internal structure | Over 4,000 lines concentrated in one area—high regression risk |

**Recommended direction:** Keep the proven schedule appearance, data and override behaviour. Rebuild the internal workflow into smaller shared services while keeping the command familiar.

```text
Drawing data
     ↓
Lightweight schedule review
     ↓
Preflight and change preview
     ↓
Update existing schedule in place
     ↓
One Undo
```

### PS1–PS15 proposed decisions

| ID | Recommendation |
|---|---|
| PS1 | Keep PITSCHEDULE, its approved appearance and existing drawing compatibility. Rebuild its internal organisation rather than replacing the user-facing workflow. |
| PS2 | CE pit/pipe data is the engineering authority. The placed schedule is a linked presentation of that data—not a second independent model. |
| PS3 | Opening PITSCHEDULE is read-only. It must not automatically relink pipes or rewrite the drawing. Detected problems appear in Preflight with a separate Repair Preview action. |
| PS4 | Schedule interface usable within 1 second p95 on normal jobs and 2 seconds p95 on large networks. Build from cached data first; heavy checking continues at idle. |
| PS5 | Critical problems block placement: duplicate pit IDs, corrupt links, missing pit identity or impossible inlet/outlet ownership. Ordinary warnings allow placement after acknowledgement. |
| PS6 | One visual group per pit. The first row contains pit size, cover, depth, lid and remarks; additional rows show extra inlets without repeating confusing pit information. |
| PS7 | Every excluded asset remains visible in the review as Excluded—with reason. Trench grates remain excluded by the approved rule. Nothing disappears silently. |
| PS8 | Keep schedule sets for multi-dwelling or multi-system projects. Each pit belongs to one set; users can place one set or all sets. Manual rows also belong to a named set. |
| PS9 | Default order is natural pit order: P1, P2, P3 … P10, grouped by schedule set. A deliberately customised group order is stored and survives refresh/reopen. |
| PS10 | Keep manual rows and amber per-cell overrides. Each override displays its original linked value, current override and reason. Restore Cell/Row must persist correctly. |
| PS11 | Editing engineering information from the schedule offers two explicit paths: Update source pit/pipe or Schedule-only override. It never changes engineering truth merely because text was edited. |
| PS12 | Direct edits to placed AutoCAD schedule text are detected and marked Needs review. They never silently change pit, pipe or hydraulic data. |
| PS13 | Update Schedule previews added, removed and changed rows, then updates the existing schedule at its current insertion point. No delete/re-place prompt, no duplicate schedule and one Undo action. |
| PS14 | Schedule graphics come from the approved CE master: layers, text styles, headings, widths and spacing. Long schedules split using a defined continuation format rather than shrinking text. |
| PS15 | CSV export remains available. CSV import must preview every difference and identify its source; it cannot silently overwrite linked drawing data. |

### Override example

```text
P3 outlet IL
Linked source:        42.150
Schedule override:    42.140
Reason:               Match issued council schedule
Status:               ⚠ Schedule differs from drawing
Actions:
  [Update source through CDEDIT]
  [Keep schedule-only override]
  [Restore linked value]
```

### Automated evidence before Tim tests

No duplicate rows or schedules; multiple inlets and outlets; multiple schedule sets; manual rows and overrides; restore cell/row after save and reopen; native text edits detected; update existing schedule in place; cancel and Undo restore the original schedule; old "Pit Schedle" drawings migrate safely; large-network opening performance; schedule values match CDEDIT, Inspector and the hydraulic engine.

**Recommendation:** approve PS1–PS15. No implementation starts.

### PS16–PS20 — five final additions (approved)

| ID | Recommendation |
|---|---|
| PS16 — Stale dialog | If the drawing changes while PITSCHEDULE is open, disable Update until the schedule refreshes. Never apply an old preview. |
| PS17 — Issue status | Store when each schedule set was last updated, against which drawing revision and data fingerprint. Inspector shows Current or Out of date. |
| PS18 — Renumber safely | Changing P3 to P4 updates the pit label, pipe links, schedule and related references atomically. Permanent internal identity stays unchanged. Duplicate numbers are blocked. |
| PS19 — Placed-instance control | Track each placed schedule by set and space/layout. Detect copied or duplicate schedules and identify which one is authoritative. |
| PS20 — Close protection | Closing with unapplied edits asks: Apply, Discard or Continue Editing. Escape never silently loses schedule work. |

```text
Main Schedule
Last updated: Drawing Revision C
Status: ⚠ Out of date
Changes since update:
• P3 outlet IL changed
• P7 added
• P10 lid class changed
```

Scoping ruling (Tim): detailed sheet checking, pit-detail matching and issue-readiness belong to the Project QA section (QA-01), which assesses the complete drawing rather than only the schedule.

## Timothy's approval and refinements — verbatim

### Approval 1 — PS1–PS15

✅ Approve PS1–PS15. This card has the **same DNA as CV-01** — one authority, detect-don't-mutate, preview→apply→one-Undo, nothing silent — which is exactly what you want: the schedule isn't a special case, it's another consumer of the same discipline.

🔑 **Build it on CV-01's shared core — don't grow a schedule-only twin.** PS2 = one authority (same as CV12/HD2); PS3 = read-only open / detect-don't-mutate (same as CV18); PS11 + PS13 = preview→apply→one-Undo (same as CV11); PS10 = Fixed/Designed provenance (same as CV R3); PS7/PS12/PS15 = no silent behaviour (rule #5). The read / preview / apply / rollback engine here must be the **same shared atomic core** (CV R6), not a re-implementation. A separate schedule copy of that logic is exactly how the 4,000-line monolith and the parallel-path bugs happened. The schedule is a view + editor on the one model.

🏆 **The three that fix real pain.** PS3 (read-only open) kills the flagged "auto-relink on open may silently alter data." PS13 (update in place) retires the "awkward delete/re-place prompt" and its duplicate-schedule bug — update-with-preview at the current insertion point, one Undo. PS11 (two explicit edit paths) is domain-literate: the override example (schedule shows 42.140 to match the issued council schedule while the drawing stays 42.150) is a real scenario, handled honestly with three explicit actions instead of a silent guess.

🐛 **One genuine catch on PS11 — override staleness.** The override stores "linked 42.150 → override 42.140." When the linked source later changes (someone updates the pit to 42.130), a schedule-only override must **flag "linked value changed since this override was set — review,"** not keep quietly showing 42.140 against a value that's moved. Otherwise a stale override silently masks a real design change — the two-sources-of-truth trap, just slower. Fold that staleness flag into the override status.

📝 **Two smaller notes.** PS14 retires a bug chain by construction — driving the schedule from the approved CE master + a defined continuation format (not shrinking text) supersedes the ad-hoc step-iron line-break logic that failed four times (BUG-103/108). PS4's budget needs a batched read: the slow open was a per-pipe transaction explosion; 1s/2s p95 is only reachable if the rebuild reads the whole schedule in one pass, not per-entity.

✅ **The evidence list is the right proof** — especially "schedule values match CDEDIT, Inspector and the hydraulic engine," which *proves* PS2 (one authority) is actually holding. And good catch keeping "Pit Schedle" (the real typo'd block name) in the migration set.

### Approval 2 — PS16–PS20

✅ Approve PS16–PS20 — PS-01 closes.

**PS18 is the payoff moment for CT2.** Renumbering safely — P3→P4 updates the label, links, schedule and references atomically while the *identity stays put* — works precisely because you gave every pit a permanent internal identity separate from its display number (CT2). Rename anything, break nothing. Full circle.

**PS17 is professionally the most valuable of the five.** "Last updated: Rev C · ⚠ Out of date · P3 IL changed, P7 added, P10 lid changed" is real issue-management — it tells you the placed schedule is stale *and exactly what moved since you issued it*.

🔧 **One build note — one fingerprint, not three.** PS16 (dialog stale), PS17 (set out of date), and the CV-01 compatibility check all rely on the same idea: has the source data changed since X? Build one data-fingerprint mechanism and reuse it in all three.

📝 **Minor — PS19.** Make the "which placed schedule is authoritative" rule explicit (original placement vs user-designated). A copied schedule should be flagged "copy — not authoritative" and stay inert until the user says otherwise — the CV20 copy-safety rule, applied to schedules.

✅ Scoping agreed — detailed sheet checking, pit-detail matching and issue-readiness go to the Project QA section (QA-01); PS17's out-of-date status is the natural feeder into that section.

## Approved 2026-07-23 addendum — XREF sources and placement completion

### What Tim does

Tim sometimes produces the complete CE Civil drainage design inside a drainage DWG, then attaches that DWG as
an XREF into the final drawing. The issued pit schedule must live in the final drawing while remaining linked to
the drainage source.

### Current failure modes

1. `PITSCHEDULE` reads the active drawing's embedded project data. A final drawing does not currently build its
   schedule from CE data embedded in attached drainage XREFs.
2. Placed schedule cells store local pit/pipe handles only, so a host-drawing cell cannot distinguish or resolve
   a handle belonging to an XREF source.
3. After **Place Schedule**, point selection and insertion complete, but the modal WPF window reappears because
   successful placement never requests a close. Tim must press **Close** unnecessarily.

### PS21–PS22 decisions

| ID | Approved workflow |
|---|---|
| PS21 — XREF schedule source | The final drawing owns the schedule presentation and reads selected loaded or nested CE drainage XREF data read-only. The stored link combines durable source-drawing identity, selected schedule set and durable pit/pipe identity. It never writes engineering values through an XREF. |
| PS22 — Placement completion | **Place Schedule → select point → insert linked schedule → close window.** Cancelled point selection or failed insertion leaves the window open with the user's work intact. |

The host schedule updates at its existing insertion point through PS13 preview → apply → one Undo. It reports
Current, Out of date, Missing or Unloaded using the shared PS16/PS17 fingerprint. When multiple source drawings
are selected, their rows stay source-qualified; duplicate displayed pit numbers block placement until resolved.
Attaching the same source more than once does not duplicate its schedule rows by default.

Implementation staging is locked in
[`PS-01_XREF_SCHEDULE_IMPLEMENTATION_PLAN.md`](../workflows/PS-01_XREF_SCHEDULE_IMPLEMENTATION_PLAN.md).
