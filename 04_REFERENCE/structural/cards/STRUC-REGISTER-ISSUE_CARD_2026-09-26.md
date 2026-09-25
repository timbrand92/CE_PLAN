# Drawing register, revisions and issue — command card (26 Sep 2026)

**SHARED Civil + Structural card (UX-REG-09 refined, 26 Sep 2026).** Civil uses the same revision and issue
workflow, but a Civil set has no register table or notes page. On a two-discipline job the Structural cover
sheet's register lists the Civil sheets too; each discipline keeps its own revision sequence. A Civil-only job
has no register. This replaces the earlier UX-REG-09 reading that implied a Civil register or one revision
sequence. A pointer for Civil readers is in
`04_REFERENCE\ux-plan\cards\README.md`.

**Status: APPROVED (plan only; not built, tested, installed or Tim-accepted).** Tim settled the register/revisions/issue workflow 25 Sep 2026 —
rulings UX-REG-01 to 08 (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural register, revisions
and issue" and "Structural register and issue, batch 2"), plus the multi-DWG combined-PDF answer recorded under
"Structural cards (release chat, commit d65586a7)" in the same file — on top of the 14 Sep 2026 journey rulings
this card was first drafted from (the "Drawing register, revisions and issue", "Issue completion" and "Revision
history and remembered decisions" sections of `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`) and UX-STRUC-01 (25
Sep, closed-sheet writes). Priority set by Tim 25 Sep 2026 (UX-STRUC-06: register/revisions/issue is the second
drawing-journey stage tackled after D1, after QA against the markup). **26 Sep 2026 addition:** UX-REG-09..12
(`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Issue and submission, Civil and whole plugin") extend
this same card to cover Civil issue, one-click council submission packs, applying the office
plot style/pens at Issue, and a locked read-only DWG snapshot per issue — see §3a, §5 items 11-13, §6 and §8
below. **Nothing here is built.** Approval covers the workflow; the representative drawing and checklist in
section 7 remain the build gate. This is journey stage 7 of 7 (`areas\structural.md`
UX plan note).
**Read from:** `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`, `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`
(UX-STRUC-01, UX-REG-01 to 15), and the shipping CE Sheets code on `claude/struc-d1-prep`
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

### 3. Tim's settled workflow, 25 September 2026 (UX-REG-01 to 08)

**Batch 1** (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural register, revisions and issue",
25 Sep 2026):

1. **UX-REG-01 — what changed.** Tim: *"Compare with last issue (Recommended)".* CE compares each sheet with
   its last issued version and lists changed sheets with a reason; the user ticks which sheets get a new
   revision.
2. **UX-REG-02 — next revision.** Tim: *"Suggest, you pick stage (Recommended)".* After P3, CE offers P4 / T1 /
   A with the likely one pre-picked from this job's own pattern, remembered per job. This is a **suggestion, not
   a lock.**
3. **UX-REG-03 — revision clouds (after A).** Tim: *"CE proposes, you adjust (Recommended)".* CE draws proposed
   clouds and triangles around each change in the preview; the user accepts, moves, reshapes or deletes each one
   before issue.
4. **UX-REG-04 — register location.** Tim: *"On the cover sheet, auto (Recommended)".* The drawing-list table on
   the cover/notes sheet updates automatically from the one shared sheet list, plus an Excel copy is written to
   the issue folder.

**Batch 2** (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural register and issue, batch 2",
25 Sep 2026):

5. **UX-REG-05 — status words.** Tim: *"Yes, from the revision (Recommended)".* P revisions read PRELIMINARY, T
   revisions read FOR TENDER, A onwards reads FOR CONSTRUCTION; shown in the issue preview; the wording itself is
   a Settings value (R-00) and can be changed.
6. **UX-REG-06 — who issues.** Tim: *"Anyone, names the engineer (Recommended)".* Any CE user issues, but picks
   the approving engineer, who prints on the title block; who actually pressed Issue is recorded separately (same
   pattern as UX-CALC-03).
7. **UX-REG-07 — new sheet number.** Tim: *"Next in its group (Recommended)".* A new sheet takes the next number
   in its group; gaps are never filled or renumbered without asking first.
8. **UX-REG-08 — where issue starts.** Tim: *"Sheets window + Project Review (Recommended)".* Issue starts from
   either the Sheets window or Project Review; both open the one shared issue preview.

**Multi-DWG combined PDF** (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Structural cards (release
chat, commit d65586a7)", 25 Sep 2026): Tim: *"One PDF, register order (Recommended)".* A multi-DWG Structural
job gives **one combined PDF across the whole issue, sheets in register order** — this settles this card's own
Open question 1 as first drafted (a truly job-wide PDF, not one PDF per DWG; see section 5 item 3 and "Open
questions" below).

### 3a. Civil and whole-plugin additions, 26 September 2026 (UX-REG-09 to 12)

`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Issue and submission, Civil and whole plugin — 26 Sep
2026 01:07", refined by "Civil drawing sets: register and notes — 26 Sep 01:15". **APPROVED** as a plan.

1. **UX-REG-09 — REFINED 26 Sep.** Tim: *"civil drawings are same as structural but the civil doesnt have drawing
   register or notes page or it is added on structural drawings register".* Civil uses the same revision and
   issue steps (UX-REG-01 to 08) but **has no register table and no notes page of its own**. On a job with both
   disciplines, the Structural set's cover-sheet register lists the Civil sheets. Civil and Structural revisions
   run separately: for example, **STR REV F + CVL REV G**. One dated issue folder may contain both sets as
   separate PDFs or one combined PDF, as chosen in the preview. A Civil-only job has no register; its sheets
   start at C01. The earlier 01:07 reading of UX-REG-09 as a shared register and shared revision sequence is
   superseded by Tim's 01:15 clarification. One sheet list may supply both sets, but does not create a Civil
   register.
2. **UX-REG-10 — one-click council submission pack.** Tim: *"Yes, one pack (Recommended)".* One click builds a
   dated folder containing the drawing-set PDF, the computations sheet, the rating report and the LPD letter,
   named the way the selected council asks. The pack is **reviewed before it is made** (a preview of exactly
   what will go in it, named how), and **CE never sends it** — sending stays a human action outside CE.
3. **UX-REG-11 — office plot style, page setup and pens at Issue.** Tim: *"Yes, from Settings (Recommended)".*
   Issue applies the office's plot style, page setup and pen settings, all Settings values (R-00); a sheet whose
   own plot/page setup differs from the office standard is **flagged in the issue preview**, not silently
   overridden or silently allowed through.
4. **UX-REG-12 — locked read-only DWG snapshot per issue.** Tim: *"Yes, in the issue folder (Recommended)".* A
   locked, read-only DWG snapshot is saved into the dated issue folder beside the PDF at every issue; the
   existing "what changed since last issue" comparison (§5 item 7 above, the revision-cloud engine, reusing the
   Markup QA card's UX-QA-08 compare mode) reads from this snapshot rather than from whatever the drawing looked
   like at some remembered moment — giving that comparison a fixed, exact prior state to diff against.

5. **UX-REG-13 — Check plot.** Tim: *"Yes (Recommended)".* A Check plot button plots the current selected set
   with the issue plot settings, stamps every sheet **CHECK PLOT**, and writes a dated **CHECK PLOT** folder.
   It does not change a revision, register or issued record.
6. **UX-REG-14 — review marks.** Tim: *"Optional tick (Recommended)".* **Include review marks** is off by
   default and prints QA markers on check plots only. Issue plots never print these markers.
7. **UX-REG-15 — engineer mark-up.** Tim: *"Same button, \"For engineer\" option (Recommended)".* The same
   Check plot button offers **For engineer mark-up**. Every plan is stamped **FOR ENGINEER REVIEW**; returned
   mark-up feeds QA against the mark-up (`STRUC-MARKUP-QA_CARD_2026-09-26.md`). This is a review output,
   without a revision or register change.
8. **Council pack missing document — decided 26 Sep.** Tim: *"Warn and list it (Recommended)".* The pack
   preview lists a missing document in amber and permits the pack to be built.

### 4. What Tim already ruled 14 September 2026 — not asked again

**Setup and register (batch 1, item 10; and the dedicated register/revisions/issue batches):**

1. Maintain one shared sheet list; update the **Structural** cover-sheet register when sheets are added,
   renamed, reordered or removed. Civil sheets appear there on two-discipline jobs; no Civil register is made.
2. CE suggests sheets affected by an issue or change; you confirm which sheets actually receive a new revision.
3. Unchanged sheets keep their existing revision and date — a set-wide issue date must never overwrite them.
4. Apply the confirmed revision and date to affected title blocks and, where present, the Structural register
   together, through one sheet/issue authority. Keep Civil and Structural revision sequences separate.
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

### 5. Keep / Modify / Rebuild / Missing, step by step

1. **The shared sheet list, scanning, renaming and reordering — Keep / Modify.** Keep one source of sheet
   identity. Modify register output so only the Structural cover sheet carries a table; include Civil sheets
   there on two-discipline jobs. Do not create a table or notes page for a Civil-only job.
2. **Closed-sheet writes with a notice — Keep.** Already matches UX-STRUC-01 exactly; nothing to change.
3. **Combined PDF — Modify, Tim-confirmed 25 Sep and refined 26 Sep.** For a Structural issue, change from
   "one combined PDF per DWG" to one PDF for the whole issue, sheets in Structural register order (Tim:
   *"One PDF, register order (Recommended)"*). A two-discipline issue may be separate Civil and Structural
   PDFs or one combined PDF, chosen in the preview, in one dated folder. A Civil-only issue has a PDF but no
   register order; use the confirmed sheet-list order. The earlier multi-DWG question is resolved.
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
11. **One-click council submission pack (UX-REG-10) — Missing.** No code today assembles a dated folder of
    drawing-set PDF + computations sheet + rating report + LPD letter, named per council. New: a pack builder
    that reads the same issue folder/PDF this card already produces, plus the D+F card's computations-sheet
    export (`DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md` §2.9) and the rating report/LPD letter already on
    file for the job, with a preview before the pack is written and no send action anywhere in CE. List each
    missing document in amber; allow a partial pack to be built (Tim, UX-REG-10 follow-up).
12. **Office plot style/page setup/pens applied and checked at Issue (UX-REG-11) — Missing.** `CeSheetsIssueService`/
    `CeSheetsPdfPublisher` plot from whatever plot style and page setup each sheet already carries; nothing
    compares that against an office Settings standard or flags a mismatch in the issue preview today. New: a
    Settings-held office plot style/page setup/pen standard (R-00), applied at Issue, with a flag (not a
    silent fix) on any sheet whose own setup differs.
13. **Locked read-only DWG snapshot per issue (UX-REG-12) — Missing.** `CeIssueEntry`/`CeIssueSheetSnapshot`
    already record sheet metadata (number, title, revision, drawn/designed by, issue date) but no full DWG copy.
    New: save a locked, read-only DWG snapshot into the dated issue folder at issue time, and point the existing
    revision-cloud "what changed since last issue" comparison (§5 item 7, UX-QA-08-based) at this snapshot as
    its fixed prior state, rather than a remembered in-memory state that a later drawing edit could disturb.
14. **Separate discipline revisions and Structural-only register — Modify.** Extend the existing issue record
    to hold the Civil and Structural revision choices independently. Render the register on the Structural
    cover sheet only, listing Civil sheets there on two-discipline jobs. A Civil-only set has no register or
    notes page.
15. **Check plot and engineer mark-up — Missing.** Add the button and its two review outputs using Issue's
    plot settings, with stamps and a dated CHECK PLOT folder. Review marks are off by default and may print on
    check plots only. Neither route changes an issue, revision or register. Returned engineer mark-up enters
    the Markup QA card's intake, not a second QA route.

### 6. The full experience

1. **Where you start:** CESHEETS, same entry point as today (already ribbon-mapped, Schedules panel per the
   ribbon card).
2. **Trigger:** the existing "scan → edit → Update Drawings → Publish" spine; this card adds an **Issue** step
   between Update Drawings and Publish, and folds today's direct-to-Publish flow into it.
3. **Prompts:** confirm the affected-sheets suggestion; confirm or edit the proposed revision description;
   choose Civil, Structural or both and separate or combined PDFs when both are present. Confirm the sheet set
   (full current set by default). Civil and Structural revision choices are shown separately.
4. **Selection:** none required beyond the confirmations above — CE Sheets already knows every sheet from its
   scan.
5. **Preview:** the issue preview (sheets, discipline-specific revisions, dates, unresolved QA) before anything plots; revision
   clouds/triangles preview on the affected sheets before they are committed to the title block and register.
6. **Drawing output:** revision clouds/triangles on the drawing (new, no-plot-safe layer per the existing CE
   convention — review highlights never print, but an accepted revision cloud is a real, plotted annotation, not
   a review highlight — these are different things and must not share a layer); the title block and register
   revision/date fields (existing); the Structural register where one exists; the chosen PDF output. Civil
   receives no register table or notes page.
7. **Cancel / Escape:** leaves the drawing, register and any prior issue exactly as they were.
8. **One Undo:** accepting an issue (title block writes, register update and revision cloud placement together)
   is one Undo, as already ruled (14 Sep, "Whole-plan proposal" item 6).
9. **Save/reopen:** the issue record, sheet snapshots, revision history and cloud/triangle state persist with
   the project, surviving a reopen or a colleague opening the same job.
10. **Settings:** the office's revision-sequence convention (P1/P2/P3/A, or the T-series tender variant) is a
    per-job choice, not a hard-coded sequence (14 Sep, item 5) — recommend it lives on the Settings page as an
    editable default, consistent with R-00. The office plot style/page setup/pens (UX-REG-11) are also Settings
    values, checked at Issue rather than hard-coded.
11. **After Issue (UX-REG-10/12):** once an issue is accepted, the same dated issue folder gains the locked
    read-only DWG snapshot (UX-REG-12) automatically, no separate step; the one-click council submission pack
    (UX-REG-10) is a distinct, explicit action a drafter chooses afterwards — reviewed in its own preview,
    never bundled silently into Issue itself, and never sent by CE.
12. **Check plot (UX-REG-13..15):** from the Sheets window or Project Review, choose **Check plot** for the
    current set. The preview shows issue plot settings, dated CHECK PLOT folder, stamp and whether **Include
    review marks** is ticked (off by default). **For engineer mark-up** uses the same button and stamps every
    plan FOR ENGINEER REVIEW. Cancel/Escape writes no plot; neither route advances a revision, changes the
    Structural register or creates an issue. Returned mark-up enters the Markup QA workflow. Save/reopen leaves
    the last issued state unchanged; output files remain in their review folder.

### 7. Example drawing and checklist

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
5. **Automated guard:** a Civil-only issue makes no register or notes page. A combined issue lists Civil
   sheets in the Structural register, keeps STR and CVL revisions independent, and produces the chosen
   separate or combined PDF arrangement in one dated folder.
6. **Automated guard:** Check plot and For engineer mark-up use the issue plot settings and correct stamp,
   leave revision/register/issue history unchanged, and print review marks only when the check-plot tick is
   selected. A normal Issue never prints review marks.
7. **Tim's AutoCAD checklist, once built:**
   - Open the job, change S03 only, run Issue: CE suggests "S03" as the affected sheet (not S01/S07); confirm.
   - Preview shows S03 at the new revision, S01/S07 unchanged, and any open QA items listed.
   - Publish: one combined PDF containing all three sheets; S03 carries a revision cloud/triangle around the
     changed area; S01/S07 do not.
   - Close AutoCAD, reopen the job later: the issue history, revisions and clouds are exactly as issued.
   - Repeat with one sheet closed in AutoCAD at issue time: CE writes to it and tells you plainly which sheet it
     touched while closed (per UX-STRUC-01, already built — confirming, not new work).
   - Check plot the current set, first without and then with **Include review marks**. Every page says CHECK
     PLOT; only the second output shows QA markers. Choose **For engineer mark-up** and check every page says
     FOR ENGINEER REVIEW. Reopen the issue history: revisions and register are unchanged.
   - On a fabricated two-discipline set, issue STR REV F + CVL REV G and choose separate PDFs, then preview a
     combined-PDF issue. Civil sheets appear only in the Structural register; Civil has no notes page.

### 8. Slices, smallest first

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
7. **Slice 7 — locked read-only DWG snapshot per issue (UX-REG-12).** Save the snapshot into the dated issue
   folder at issue time; point Slice 5's revision-cloud comparison at it once both exist. Small, contained, no
   dependency beyond Issue itself already working.
8. **Slice 8 — office plot style/page setup/pens check (UX-REG-11).** Settings-held office standard; apply at
   Issue; flag a differing sheet in the issue preview (extends Slice 2).
9. **Slice 9 — one-click council submission pack (UX-REG-10).** The largest of the additions — depends on the
   D+F card's computations-sheet export and the rating report/LPD letter already being on file for the job;
   sequence after this card's own Slice 1 (job-wide PDF) since the pack includes that PDF.
10. **Slice 10 — separate Civil and Structural issue state.** Use the existing sheet list for both sets; make
    the Structural register include Civil sheets where relevant, omit a Civil register/notes page, and show two
    independent revision sequences. Let one folder carry separate or combined PDFs.
11. **Slice 11 — Check plot.** Plot the selected current set with issue settings and CHECK PLOT stamps into a
    dated review folder, without advancing issue state. Add the off-by-default review-mark tick; then add the
    FOR ENGINEER REVIEW variant and link returned mark-up to Markup QA.

### Open questions

Genuinely unsettled build details only — the multi-DWG combined-PDF question first drafted here is now answered
(Tim, 25 Sep: *"One PDF, register order"*; see section 3 above) and is not repeated as an open item.

1. **What exactly counts as "a confirmed change" for the revision-cloud comparison** — a drawing edit CE itself
   made, any edit at all since the last issue, or only edits tied to a Checked QA item? *Recommended: any
   geometry/annotation change on a sheet since its last issued snapshot, not limited to CE-made edits — an
   engineer's own manual fix must cloud too, or the cloud becomes unreliable.*
2. **Where does the office's revision-sequence convention (P1/P2/P3/A vs a T-series) get set for a given job —
   Settings default, or a per-job choice at first issue?** *Recommended: a Settings default (R-00) that a job
   can override once, at its first issue, then locked for that job's own sequence so it cannot drift mid-job.*
3. **RESOLVED — missing submission document (UX-REG-10).** Tim: *"Warn and list it (Recommended)"* (26 Sep).
   The pack preview lists missing pieces in amber and permits the partial pack. Do not silently omit them.
4. **What counts as a "differently set up" sheet for UX-REG-11's flag** — any deviation at all from the office
   plot style/page setup/pens, or only a deviation that would visibly change the plotted output (e.g. a
   different pen-to-lineweight mapping vs. a cosmetically identical but differently-named plot style)?
   *Recommended: flag any deviation from the exact named office standard, however cosmetically small — Issue is
   the one place a silent mismatch would reach a council, and R-27's "warn, don't hard-block" already means this
   never stops the issue, only names it.*

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
6. Check plot, engineer mark-up and a partial council pack leave the last issued revision and register
   unchanged; the pack preview lists missing documents in amber and still permits Build.

### Open dependencies before a builder starts

1. The remaining build-detail questions above (cloud scope, revision convention and plot-setting mismatch).
2. The revision-cloud comparison engine should reuse the Markup QA card's drawing-to-drawing compare (UX-QA-08,
   slice 6 of that card) rather than be built twice — sequence this card's slice 5 after that one lands, and
   once slice 7 (UX-REG-12 snapshot) exists, point the comparison at the locked snapshot rather than a
   remembered in-memory state.
3. The issue-time unresolved-QA gate (this card's slice 6) reads the Markup QA card's item-state model directly
   — needs that card's slice 1 (the state model) before this card's slice 6 can start, though slices 1-4 here
   are independent and can proceed first.
4. **REFINED 26 Sep 2026 (UX-REG-09):** Civil and Structural use the same issue workflow and sheet authority.
   The Structural register lists both disciplines on a two-discipline job; Civil has no register or notes page,
   including on Civil-only jobs. Revisions remain independent. Check any existing Civil-side issue code against
   this ruling before Slice 1.
5. Slice 9 (council submission pack, UX-REG-10) depends on the D+F card's computations-sheet export
   (`DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md`, APPROVED) and on the rating report/LPD letter already
   being on file for the job — confirm both are reachable from the issue folder's job context before slice 9
   starts.
