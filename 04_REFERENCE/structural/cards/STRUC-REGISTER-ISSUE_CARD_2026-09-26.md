# Structural drawing register, revisions and issue — command card (draft, 26 Sep 2026)

**Status:** DRAFT. Priority set by Tim 25 Sep 2026 (UX-STRUC-06: register/revisions/issue is the second
drawing-journey stage tackled after D1, after QA against the markup). Behaviour largely already ruled 14 Sep
2026 (the "Drawing register, revisions and issue", "Issue completion" and "Revision history and remembered
decisions" sections of `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`), plus UX-STRUC-01 (25 Sep, closed-sheet
writes). **Nothing here is built.** No code starts until Tim approves this card. This is journey stage 7 of 7
(`areas\structural.md` UX plan note).
**Read from:** `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`
(UX-STRUC-01), and the shipping CE Sheets code on `claude/struc-d1-prep`
(`Modules/Structural/Commands/SheetsCommands.cs`, `Modules/Structural/Models/CeSheetsModels.cs`,
`Modules/Structural/Services/CeSheets*.cs`).

---

## FOR TIM

### 1. What this card covers

1. **One shared sheet list** that updates itself as sheets are added, renamed, reordered or removed.
2. **Suggested affected sheets** when you issue a change — CE proposes, you confirm which sheets get a new
   revision.
3. **One combined PDF** for a Structural issue, with a preview before anything plots.
4. **Revision clouds and triangles after Revision A**, showing only the current revision's changes.
5. **What CE Sheets already does today** for issue, publish and sync — this is a mature, working system already,
   not a blank page.

### 2. What works today, in drawing terms

1. **CESHEETS already scans your project folder and builds one shared sheet list** — job number, sheet number,
   layout name, drawn-by/designed-by, revision — with a working spine of "scan → edit → Update Drawings →
   Publish".
2. **CE Sheets already knows which drawings are open in AutoCAD and which are closed**, and already writes to
   closed drawings safely (a side-database write, not opening them), reporting which ones it touched. This is
   exactly the behaviour Tim confirmed 25 Sep (UX-STRUC-01: *"Keep, with a notice"*) — **already built, matches
   the ruling, not something this card needs to change.**
3. **CE Sheets already publishes a combined PDF — but one per DWG, not one for the whole job.** If your job has
   more than one Structural DWG (a common split), today's Publish gives you one combined PDF per file, not the
   single job-wide combined PDF the 14 Sep ruling asks for.
4. **CE Sheets already tracks an Issue record**: an issue ID, date, revision, discipline code, whether it is for
   council approval, an output folder, and a snapshot of every sheet in it (number, title, revision, drawn/
   designed by, issue date).
5. **CE Sheets already has renaming and reordering support** (a pending-rename model) and a sheet-naming
   suggestion service for inserting a new sheet after an existing one.
6. **What is missing: suggesting which sheets an issue affects.** Today you would have to know yourself which
   sheets a change touches; there is no "CE thinks these N sheets are affected by what changed, confirm the
   list" step.
7. **What is missing: revision clouds and triangles.** No code anywhere in CE Sheets draws a revision cloud or a
   revision triangle, or tracks what changed between one issued revision and the next well enough to know where
   to draw one.
8. **What is missing: an issue preview** listing sheets, revisions, dates and unresolved QA items before you
   plot — today's Publish plots from the issue record directly.
9. **What is missing: the "learning from QA decisions" and "Remembered decisions" list** the 14 Sep ruling asks
   for at issue time — this overlaps with, and should reuse, the Markup QA card's own Remembered/Checked-state
   work rather than build a second one.

### 3. What Tim already ruled 14 September 2026 — not asked again

**Setup and register (batch 1, item 10; and the dedicated register/revisions/issue batches):**

1. Maintain one shared sheet list; update the drawing register when sheets are added, renamed, reordered or
   removed.
2. CE suggests sheets affected by an issue or change; you confirm which sheets actually receive a new revision.
3. Unchanged sheets keep their existing revision and date — a set-wide issue date must never overwrite them.
4. Apply the confirmed revision and date to affected title blocks and the register together, through one shared
   sheet/issue authority (do not build a second register for Structural alone).
5. Preliminary revisions typically progress P1, P2, P3 and then A — but the sequence depends on the job, and
   some jobs use **T1, T2, etc. for a tender issue before A.** Never hard-code a fixed P-to-T-to-A sequence or a
   fixed number of preliminary/tender issues.
6. Before plotting, show an issue preview listing sheets, revisions, dates and unresolved QA items.
7. **Always a combined PDF** for a Structural issue — individual-sheet PDFs are not the default output.
8. Prepare the PDF filename and dated issue folder automatically, with preview and editable naming.

**Issue completion:**

9. Combined PDF normally includes the full current drawing set, including unchanged sheets; allow selecting a
   smaller set when needed.
10. Suggest revision descriptions from confirmed changes, with your editing and approval of the wording.
11. Add revision clouds and triangles **after Revision A**, showing what changed between A, B and the next
    revision (whether earlier clouds stay or are replaced is answered below, item 15).
12. Clearly present unresolved QA and require an explicit decision before proceeding; **learning from decisions**
    is also required (scope covered by the Markup QA card's Remembered/Checked-state work — reuse it here, do
    not rebuild it).
13. Failed or cancelled plotting leaves the issue unfinalised, preserves your drafting work, and allows retry
    without advancing revisions again.
14. Following a successful issue, retain the exact sheets, revisions, date and issued PDF for later reference and
    comparison.

**Revision history and remembered decisions:**

15. When issuing revision C, show only B-to-C changes, **replacing** the previous revision's clouds and
    triangles. Earlier issued PDFs keep the history; clouds/triangles start only after Revision A.
16. Remember an agreed QA decision for the relevant item on that job; ask again only when its drawing or
    instruction changes.
17. Repeated decisions across jobs may become a proposed office preference — you must approve it first.
18. A simple Remembered-decisions list where you can see, correct or remove a learned decision.

**Whole-plan proposal (item 6):** accepting a proposal, including an issue, is one Undo operation, returning the
drawing to its pre-acceptance state.

### 4. Keep / Modify / Rebuild / Missing, step by step

1. **The shared sheet list, scanning, renaming and reordering — Keep.** Already matches the ruling; no changes
   asked for in this card.
2. **Closed-sheet writes with a notice — Keep.** Already matches UX-STRUC-01 exactly; nothing to change.
3. **Combined PDF — Modify.** Change from "one combined PDF per DWG" to "one combined PDF for the whole issue",
   with the option to select a smaller set (item 9 above). This is the one clear functional change to existing,
   working code.
4. **The Issue record and its sheet snapshots — Keep**, extended (not rebuilt) to carry: the suggested-affected-
   sheets list and your confirmation of it, the issue preview data, and the revision description text.
5. **Suggested affected sheets — Missing.** New: work out which sheets a confirmed drawing change (or a
   confirmed QA fix, or an issued markup round) touches, and propose that list for your confirmation.
6. **Issue preview — Missing.** New: before Publish runs, show the sheet/revision/date list plus any unresolved
   QA items, with a clear stop if you have not made an explicit decision on each.
7. **Revision clouds and triangles — Missing.** New: draw a cloud and triangle around what changed since the
   last issued revision, starting after Revision A, replacing the previous revision's clouds each time (item 15
   above). This needs a real "what changed" comparison between the last issued snapshot and today's drawing —
   closely related to, and should reuse, the QA card's drawing-to-drawing compare mode (UX-QA-08) rather than
   build a second comparison engine.
8. **Revision description suggestions — Missing.** New: propose wording from confirmed changes, editable before
   you approve it.
9. **Remembered decisions / learning at issue time — reuse, do not rebuild.** Owned by the Markup QA card
   (Checked state, Remembered decisions, office-preference proposal); this card's issue-time gate reads that
   card's open-item list, it does not keep a second one.
10. **Failed/cancelled plotting leaves the issue unfinalised — Modify (confirm, then harden).** CE Sheets already
    has issue/publish plumbing; needs a build-time check that a failed plot genuinely leaves nothing half-issued
    (no revision advanced, no register row changed) before this is called done.

### 5. The full experience

1. **Where you start:** CESHEETS, same entry point as today (already ribbon-mapped, Schedules panel per the
   ribbon card).
2. **Trigger:** the existing "scan → edit → Update Drawings → Publish" spine; this card adds an **Issue** step
   between Update Drawings and Publish, and folds today's direct-to-Publish flow into it.
3. **Prompts:** confirm the affected-sheets suggestion; confirm or edit the proposed revision description;
   confirm the combined-PDF sheet set (full set by default, per item 9 above).
4. **Selection:** none required beyond the confirmations above — CE Sheets already knows every sheet from its
   scan.
5. **Preview:** the issue preview (sheets, revisions, dates, unresolved QA) before anything plots; revision
   clouds/triangles preview on the affected sheets before they are committed to the title block and register.
6. **Drawing output:** revision clouds/triangles on the drawing (new, no-plot-safe layer per the existing CE
   convention — review highlights never print, but an accepted revision cloud is a real, plotted annotation, not
   a review highlight — these are different things and must not share a layer); the title block and register
   revision/date fields (existing); the combined PDF (existing, changed to job-wide).
7. **Cancel / Escape:** leaves the drawing, register and any prior issue exactly as they were.
8. **One Undo:** accepting an issue (title block writes, register update and revision cloud placement together)
   is one Undo, as already ruled (14 Sep, "Whole-plan proposal" item 6).
9. **Save/reopen:** the issue record, sheet snapshots, revision history and cloud/triangle state persist with
   the project, surviving a reopen or a colleague opening the same job.
10. **Settings:** the office's revision-sequence convention (P1/P2/P3/A, or the T-series tender variant) is a
    per-job choice, not a hard-coded sequence (14 Sep, item 5) — recommend it lives on the Settings page as an
    editable default, consistent with R-00.

### 6. Example drawing and checklist

1. **Test drawing set DWG-S3a/b/c:** three small made-up Structural sheets (S01 general notes, S03 footing plan,
   S07 framing plan) forming one job, with one already-issued Revision A baseline, no client content.
2. **Automated guard:** issuing Revision B after a confirmed change to S03 only produces a combined PDF
   containing all three sheets (unchanged S01/S07 included, unchanged revision/date), with a cloud/triangle only
   on S03.
3. **Automated guard:** a failed/cancelled plot (simulate a locked output file) leaves the register, title
   blocks and revision numbers byte-identical to before the attempt; retrying afterwards succeeds without
   double-advancing the revision.
4. **Automated guard:** issuing Revision C replaces Revision B's clouds/triangles with B-to-C changes only;
   the issued Revision B PDF itself is untouched in the job's issue history.
5. **Tim's AutoCAD checklist, once built:**
   - Open the job, change S03 only, run Issue: CE suggests "S03" as the affected sheet (not S01/S07); confirm.
   - Preview shows S03 at the new revision, S01/S07 unchanged, and any open QA items listed.
   - Publish: one combined PDF containing all three sheets; S03 carries a revision cloud/triangle around the
     changed area; S01/S07 do not.
   - Close AutoCAD, reopen the job later: the issue history, revisions and clouds are exactly as issued.
   - Repeat with one sheet closed in AutoCAD at issue time: CE writes to it and tells you plainly which sheet it
     touched while closed (per UX-STRUC-01, already built — confirming, not new work).

### 7. Slices, smallest first

1. **Slice 1 — job-wide combined PDF**, changing today's per-DWG combined output to one PDF for the whole issue
   with an optional smaller-set selection. Smallest, most contained change to already-working code.
2. **Slice 2 — issue preview**, reading today's existing Issue record and sheet snapshots; no new comparison
   logic yet.
3. **Slice 3 — suggested affected sheets**, once there is something to compare against (a confirmed drawing
   change or a QA-card fix).
4. **Slice 4 — revision description suggestions.**
5. **Slice 5 — revision clouds and triangles**, the largest new piece; depends on a "what changed since the last
   issued revision" comparison, which should reuse the Markup QA card's drawing-to-drawing compare engine
   (UX-QA-08) rather than build a second one — sequence after that card's slice 6.
6. **Slice 6 — the issue-time unresolved-QA gate**, reading the Markup QA card's item states directly once both
   exist.

### Open questions

1. **When a job has more than one Structural DWG, does "one combined PDF" mean truly one PDF across every DWG in
   the issue, or does "per DWG, but always combined across that DWG's own sheets" already satisfy the 14 Sep
   ruling?** *Recommended: truly one PDF across the whole issue, sheets in register order, since that is what
   "always a combined PDF" plainly means to an engineer opening one file for council — the current per-DWG
   behaviour is the gap to close, not the target.*
2. **What exactly counts as "a confirmed change" for the revision-cloud comparison** — a drawing edit CE itself
   made, any edit at all since the last issue, or only edits tied to a Checked QA item? *Recommended: any
   geometry/annotation change on a sheet since its last issued snapshot, not limited to CE-made edits — an
   engineer's own manual fix must cloud too, or the cloud becomes unreliable.*
3. **Where does the office's revision-sequence convention (P1/P2/P3/A vs a T-series) get set for a given job —
   Settings default, or a per-job choice at first issue?** *Recommended: a Settings default (R-00) that a job
   can override once, at its first issue, then locked for that job's own sequence so it cannot drift mid-job.*

---

*Everything below this line is for the builder. Nothing below needs Tim to read, decide or do anything.*

---

## For the builder

### Pinned source (read 26 Sep 2026)

1. **Shipping Structural line:** `origin/claude/struc-d1-prep`, tip `0945bdf6`.
2. **Commands:** `Modules/Structural/Commands/SheetsCommands.cs` — `CESHEETS`, `CESHEETSMANAGER` (same route),
   `CESHEETSCLASSIC` (legacy route). File comment confirms today's intended spine: "scan → edit → Update
   Drawings → Publish."
3. **Models:** `Modules/Structural/Models/CeSheetsModels.cs` — `CeSheetManifest` (project root, sheets, support
   drawings, issues, pending renames, scan diagnostics, shared title-mapping profiles, per-file
   `DrawingLastScannedUtc` for Smart Rescan), `CeSheetEntry`, `CeIssueEntry` (issue ID, date, revision,
   discipline code, `ForCouncilApproval`, output folder, `Sheets: List<CeIssueSheetSnapshot>`),
   `CeIssueSheetSnapshot` (sheet ID, DWG path, layout, sheet number/title, revision code, drawn/designed by,
   issue date), `CePendingRenameEntry`.
4. **Services:** `CeSheetsIssueService.cs` (`PublishIssue` doc comment: "Publishes all sheets in the issue to PDF
   using default settings (**combined PDF per DWG**)" — confirmed by direct read, this is the exact gap slice 1
   closes; `PlanIssuePublish` / `CeSheetsPublishPlanner.PlanCombinedPublish` is the planning counterpart to
   extend), `CeSheetsIssueHistoryService.cs`, `CeSheetsSyncService.cs` (`IsOpenInAutoCAD` tracking per drawing,
   `"Drawing is open in AutoCAD."` message — confirmed the closed-sheet-write mechanism UX-STRUC-01 approved
   already exists here), `CeSheetsUpdateService.cs`, `CeSheetsValidationService.cs`, `CeSheetsScannerService.cs`,
   `CeSheetsStructureService.cs`, `CeSheetsNamingService.cs` (`SuggestInsertAfter` — sheet-number suggestion,
   not an affected-sheets suggestion; do not confuse the two), `CeSheetsReconciliationService.cs`,
   `CeSheetsManifestService.cs`, `CeSheetsPathService.cs`, `CeSheetsPdfPublisher.cs`,
   `CeSheetsActiveDocViewGuard.cs` (protects against Publish/Update silently changing a colleague's open view/
   layout/UCS while they work — read this before touching any issue-time drawing access).
4. **Confirmed absent by direct grep** (`revision cloud|combined pdf|publish` across the Sheets services and
   models, 26 Sep 2026): no revision-cloud or revision-triangle drawing code anywhere in the Structural source
   tree; no affected-sheets-suggestion service; `CeIssueEntry` has no field for a proposed-vs-confirmed sheet
   list or a revision description.
5. **Shared owner note:** the 14 Sep rulings say this register/issue authority must stay one shared owner, not a
   Structural-only build (`STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, "Area ownership" table: "Schedules &
   Sheets... through existing shared owner"). Confirm whether Civil already has its own sheet/issue system this
   card's work should align with (or eventually merge into) before slice 1 — do not build a second, competing
   register.

### Automated guards to write with this card

1. Combined-PDF output contains every sheet in the issue (or the explicitly selected smaller set), in register
   order, as one file — not one file per source DWG.
2. Unchanged sheets never have their revision or date fields written by a set-wide issue.
3. A failed/cancelled plot leaves the manifest, title blocks and issue history byte-identical to their pre-
   attempt state; a retry after a failure does not skip or double a revision letter/number.
4. Revision clouds/triangles for revision N+1 replace revision N's on the same sheet; the previously issued PDF
   for revision N is never modified.
5. `CeSheetsActiveDocViewGuard` coverage extends to any new issue-time read/write this card adds — no new code
   path may change a colleague's open-drawing view, layout tab or UCS.

### Open dependencies before a builder starts

1. Tim's answers to the three Open questions above.
2. The revision-cloud comparison engine should reuse the Markup QA card's drawing-to-drawing compare (UX-QA-08,
   slice 6 of that card) rather than be built twice — sequence this card's slice 5 after that one lands.
3. The issue-time unresolved-QA gate (this card's slice 6) reads the Markup QA card's item-state model directly
   — needs that card's slice 1 (the state model) before this card's slice 6 can start, though slices 1-4 here
   are independent and can proceed first.
4. Confirm whether Civil already owns a shared sheet/issue system this card's work must align with (see "Shared
   owner note" above) before slice 1.
