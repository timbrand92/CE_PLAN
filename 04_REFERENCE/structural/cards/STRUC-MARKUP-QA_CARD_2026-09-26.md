# Structural QA against the engineer's markup — command card (26 Sep 2026)

**Status: APPROVED-IN-PRINCIPLE.** Tim settled every workflow choice for this stage on 25 Sep 2026 — rulings
UX-QA-01 to 08, `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` ("Structural QA against the markup", batch
1 and 2), on top of the 14 Sep 2026 rulings this card was first drafted from
(`STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`). Priority set 25 Sep (UX-STRUC-06): QA against the markup is the
first drawing-journey stage tackled after D1. **Nothing here is built.** No code starts until Tim confirms the
test drawing and checklist in section 7 — approval-in-principle covers the workflow, not the build.
This is journey stage 6 of 7 (`areas\structural.md` UX plan note).
**Read from:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`,
and the shipping MarkupAI code on `claude/struc-d1-prep` (`Modules/Structural/Commands/MarkupAICommands.cs`,
`Modules/Structural/Services/MarkupAI*.cs`, `Modules/Structural/UI/Palette/MarkupAIPanel.xaml`,
`Modules/Structural/UI/Dialogs/MarkupPreviewWindow.xaml.cs`).

---

## FOR TIM

### 1. What this card covers

1. **QA against the markup:** the step where you go through the engineer's markup versus what is actually drawn,
   so nothing is missed — labels and marks included. You told this chat 14 Sep this is one of your main time
   costs, and on 25 Sep you settled exactly how it should work.
2. **CE reads the handwriting itself** (AI vision) and proposes each item; you correct, delete or add what it
   missed, and CE learns from your corrections.
3. **The markup shown faded under the drawing**, lined up, with a toggle — plus a docked list beside it.
4. **Four states per item:** To do, Drafted, Needs clarification, Checked — only a person can mark something
   Checked.
5. **A narrow, explicit permission** for CE to send a markup page image to Claude to read it — nothing else,
   never for training, title block blanked first where possible.

### 2. What works today, in drawing terms

1. **CEMARKUP opens a panel** where you browse to a markup PDF and click "Read PDF". CE parses it (Bluebeam
   markup, hand markup, or a mix) and works out a project type (Structural or Civil).
2. **CE plans a list of CE commands** it thinks would draw what the markup shows, and shows you that list —
   counts of items found, items it could not place with confidence, and a rough confidence score.
3. **You run the plan**, item by item or as a group, and CE places the commands on the drawing. One Undo per
   group. CEMARKUPSTATUS shows progress; CEMARKUPUNDO reverses the last group.
4. **A standards check runs alongside this**, but it checks the *drawing* is ready to receive CE's own commands
   (right layers, right blocks, right text/dimension styles exist) — it does not compare what is already drawn
   against what the markup says.
5. **What this adds up to: CEMARKUP is a one-way "read the markup, draw it" pipeline today.** It is not yet the
   "go through what's already drawn and tell me what the markup says that isn't there, or is different" QA tool
   you settled on 25 Sep. Both jobs can share the same PDF-reading engine, but the QA workflow below is new work.
6. **The markup is not shown lined up and faded under the drawing today**, and there is no toggle for it. The
   panel is a text box for the PDF path, a Browse/Read PDF button pair, and a table of planned items with a page
   number to pick from — a list, not the overlay-plus-docked-list view you settled on (UX-QA-02).
7. **Nothing today has the four item states (To do / Drafted / Needs clarification / Checked), round grouping,
   the clarification-PDF export, or the drawing-to-drawing compare mode.** All five are new.
8. **CEMARKUPBENCH exists as a separate, internal accuracy-testing tool** ("Check Markup Reading Accuracy") —
   useful for proving the reading engine works, not something a drafter runs.

### 3. Tim's settled workflow, 25 September 2026

Each one is approved-in-principle; only a genuine build gap is asked as an Open question in section 8.

1. **UX-QA-01 — reading the markup.** Tim: *"CE proposes, you correct (Recommended)".* CE reads the handwriting
   (AI vision) and proposes each item with its markup snippet beside it. You fix or delete a wrong item, and
   click any mark CE missed to add it yourself. CE learns from your corrections (the same learning principle as
   UX-LEARN-01: it shows why it suggested something and never silently changes an engineering rule).
2. **UX-QA-02 — where the markup shows.** Tim: *"Faded over the plan + side list (Recommended)".* The marked-up
   page sits lined up and faded under the drawing, with a toggle to turn it on or off, and the item list is
   docked beside the drawing. Clicking an item zooms you straight to it.
3. **UX-QA-03 — when it runs.** Tim: *"On demand + at issue (Recommended)".* A "Check against markup" button
   runs it whenever you want; it also always runs before issue. It shows a quiet open-item count in the QA
   panel — never a pop-up (matches your 4 Sep cockpit rule and UX-STD-08's "one green line").
4. **UX-QA-04 — item states.** Tim: *"Yes, those four (Recommended)".* **To do, Drafted, Needs clarification,
   Checked.** CE may set an item to Drafted the moment it sees that item drawn; only a person can mark an item
   Checked. This is the one state each item shows you — it supersedes the 14 Sep record's rougher three-way
   language ("Missing / Different from markup / Unable to verify") as what you actually see and click; CE still
   works out which of those three describes *why* an item isn't Checked yet, but the four states above are the
   settled workflow status.
5. **UX-QA-05 — AI provider permission.** Tim: *"Yes, Claude only, page only (Recommended)".* Only the markup
   page image goes, only to Claude through CE's own connection, never kept for training; the title-block area is
   blanked first where possible. This is your recorded provider permission for this one purpose — **engineer
   markup page images, for QA reading only.** It is not a permission for any other AI provider, and not a
   permission for any other job data.
6. **UX-QA-06 — markup rounds.** Tim: *"One list, grouped by round (Recommended)".* A new markup round's items
   join the one list, tagged by round. Earlier open items stay open. An item a new round changes is marked
   "superseded by P3" (for example), not deleted.
7. **UX-QA-07 — the clarification list.** Tim: *"Yes, a PDF list with snippets (Recommended)".* Every "Needs
   clarification" item becomes a one-page PDF with the markup snippet and the plan snippet side by side. You
   send it to the engineer yourself — **CE never emails it.**
8. **UX-QA-08 — engineer-drafted changes.** Tim: *"Yes, compare drawing versions (Recommended)".* When the
   engineer drafts changes directly instead of marking up a PDF, CE compares the engineer's drawing with the
   last version and lists the differences as items, with the same four states and the same highlighting.

### 4. What Tim already ruled 14 September 2026 that still stands

Not superseded by the 25 Sep batch above; still governs the build.

1. Continue through the rest of the plan when handwriting, a size or a location is unclear; flag the uncertain
   item for your decision rather than guessing (this is what lands an item in Needs clarification).
2. Let you accept the clear parts and adjust or reject others within the same review, not an all-or-nothing pass.
3. Highlight schedule changes during review; **never leave review highlighting on an issued sheet.**
4. A repeated decision across several jobs may become a *proposed* office preference — you must approve it
   before it applies more broadly (UX-LEARN-01's "the whole office" learning source, gated by your approval).

### 5. What is Missing (build classification)

1. **Missing** — the vision-based reading step itself: sending a markup page image to Claude through CE's own
   connection, getting back proposed items with snippets, and the title-block-blanking step before anything is
   sent.
2. **Missing** — the faded, lined-up overlay of the markup page under the AutoCAD drawing view, with its on/off
   toggle.
3. **Missing** — the docked side list, its click-to-zoom behaviour, and the four-state item status (To do,
   Drafted, Needs clarification, Checked) with the CE-sets-Drafted / person-sets-Checked rule.
4. **Missing** — round grouping and "superseded by [round]" tagging when a later round changes an earlier item.
5. **Missing** — the one-page clarification PDF export (markup snippet + plan snippet) for Needs-clarification
   items. **Confirmed not built:** CE has no email-sending capability in this workflow by design — the person
   sends it.
6. **Missing** — the engineer-drafted-changes compare mode (drawing-to-drawing rather than markup-PDF-to-
   drawing), reusing the same item list, states and highlights.
7. **Missing** — the "propose as an office preference" step and your approval gate for it (14 Sep, still open).
8. **Rebuild, not Modify** — the QA workflow is a different job to today's "draw from markup" plan, even though
   both can share the underlying PDF-reading and item-matching engine. Building QA as a bolt-on mode of today's
   planner risks mixing "what to draw" and "does this already match" into one confusing list.
9. **Keep** — the PDF parsing, page/item extraction, confidence scoring and Bluebeam/Hand/Hybrid source-mode
   choice that already exist; QA reads the same registered package, it does not re-parse the PDF.
10. **Keep** — CEMARKUPREGISTER (setting which drawing a markup package belongs to).

### 6. The full experience

1. **Where you start:** CEMARKUP, same entry point as today. A new choice appears once a markup package is
   registered against a drawing: "Draw from this markup" (today's existing flow) or "Check against markup" (the
   new QA flow this card adds, UX-QA-03).
2. **Trigger:** ribbon button on the CE Structural tab, Administration/Markup family (per the ribbon card,
   section 5); already there today as CEMARKUP. "Check against markup" also runs automatically before issue
   (coordinate with the register/issue card).
3. **Prompts:** pick the markup PDF (unchanged); QA adds no new prompts beyond what CEMARKUP already asks — it
   works from the same registered package and round.
4. **Selection:** none required from you to start; CE checks the whole registered markup round against the
   whole drawing.
5. **Preview:** the markup page faded in, lined up under your drawing view, with an on/off toggle; the item list
   docked beside it, one row per item with its state (To do / Drafted / Needs clarification / Checked) and its
   round tag; clicking a row zooms the drawing to that item. A quiet open-item count sits at the top — never a
   pop-up.
6. **Drawing output:** the QA check itself makes **no** drawing changes — it is a read-only comparison and
   proposal. Any fix you accept happens through CE's normal placing/editing commands, or through accepting one
   of CE's proposed items from "Draw from this markup", each with its own preview and Undo, as already built.
7. **Cancel / Escape:** leaves the drawing and the markup package exactly as they were; closing the QA panel
   does not lose progress — item states and round tags are saved as you set them.
8. **One Undo:** not applicable to the QA check itself (nothing is drawn); applies as normal to whatever fix
   command you run afterwards.
9. **Save/reopen:** item states, round tags and the "superseded by" markers persist with the job, so reopening
   later does not lose your review progress or re-ask a question already answered.
10. **Settings:** none of this is an engineering value; nothing new goes on the Settings page. Your AI provider
    permission (UX-QA-05) is recorded once, scoped to this exact purpose, not a Settings toggle a drafter can
    casually widen.

### 7. Example drawing and checklist

1. **Test drawing DWG-S2:** a small made-up Structural sheet (a handful of beams, columns, one footing) with a
   matching made-up markup PDF, round P1, containing: one item exactly as drawn, one item missing from the
   drawing, one item different from the drawing (a size or mark that disagrees), and one item CE cannot read
   confidently (illegible handwriting). A second markup PDF, round P2, changes one of P1's items. No client
   content.
2. **Automated guard:** given a known package and a known drawing snapshot, the four fixture items land in the
   expected states (To do / To do / Needs clarification / To do, before any drafting or review) — headless, no
   AutoCAD needed for the matching logic.
3. **Automated guard:** loading round P2 marks the one item it changes "superseded by P2" and leaves the other
   P1 items open and untouched.
4. **Automated guard:** QA makes zero drawing-database writes — a before/after fingerprint of the drawing must
   be identical after a QA run, whatever the results say.
5. **Automated guard:** the title-block area of a markup page image is blanked (or the send is refused with a
   plain reason) before anything leaves the machine — test against a fixture page with a known title-block
   region.
6. **Tim's AutoCAD checklist, once built:**
   - Open DWG-S2, run "Check against markup": the markup page fades in under the drawing, lined up; toggle it
     off and on; the docked list shows the four items with plain descriptions.
   - Click a Needs-clarification item: the drawing zooms to it.
   - Mark the "Different" item's fix as drawn: CE sets it to Drafted on its own; you mark it Checked yourself —
     confirm CE cannot set Checked for you.
   - Export the clarification list: a one-page PDF appears with the markup and plan snippets side by side; CE
     does not attempt to send it anywhere.
   - Load round P2: the one changed item shows "superseded by P2"; the other P1 items are unchanged.
   - Close and reopen the drawing: every state, round tag and the Checked item are exactly as you left them.
   - Confirm nothing on the drawing changed from any QA step above (undo history stays empty until you
     deliberately accept a fix).

### 8. Slices, smallest first

1. **Slice 1 — the comparison engine and its item/state model**, working headless against saved fixtures (no
   AI reading, no UI yet). Proves the matching and state logic before the vision step or any window work.
2. **Slice 2 — the vision-reading step**, gated on UX-QA-05's provider permission: send a title-block-blanked
   page image to Claude, get back proposed items with snippets. Build and test the blanking guard first.
3. **Slice 3 — the review window**: the faded overlay with its toggle, the docked list, click-to-zoom, and the
   four visible states.
4. **Slice 4 — round grouping and "superseded by" tagging.**
5. **Slice 5 — the clarification-PDF export.**
6. **Slice 6 — the engineer-drafted-changes compare mode** (drawing-to-drawing), reusing slices 1 and 3.
7. **Slice 7 — the office-preference proposal step**, gated on Tim's explicit approval once a decision repeats
   across more than one job (14 Sep, still open — lowest priority, no drafter waits on it).

### Open questions

Genuinely unsettled build details only — the workflow itself is approved-in-principle above.

1. **When the title-block cannot be blanked (a hand-marked sketch with no clean title-block region, say), what
   happens?** *Recommended: refuse to send that page and say so plainly on the command line ("Can't blank the
   title block on this page — not sent"), rather than sending it unblanked. You can always redact it yourself
   and re-supply the page if you want CE to read it anyway.*
2. **What exactly counts as "the same item" across rounds, so a P2 change is recognised as superseding a P1
   item rather than showing as a brand-new one?** *Recommended: position on the page plus the item's read
   content — if a later round's mark sits over the same drawing location as an open item, treat it as
   superseding that item; anything CE cannot match with confidence lands as a new item instead, never a guessed
   supersede.*
3. **Which "last version" does UX-QA-08's engineer-drafted-changes compare use** — the last version CE itself
   holds a record of, the last saved DWG before the engineer's edit, or the last issued revision? *Recommended:
   the last version CE has a stored comparison snapshot for (the same "before" state QA already needs to detect
   drift), falling back to the last issued revision if no CE snapshot exists, and saying plainly which one it
   used.*
4. **Does DATA-01's Gate 0 privacy hold (`04_REFERENCE\CARDS_INDEX.md`: "DATA-01 is failed/blocked... before
   broad AI/corpus access") touch this card at all?** *Recommended: no — DATA-01 concerns the historical
   CEMARKUP corpus (old snapshot files with identifying names), not a fresh markup page sent live for one job's
   QA reading under UX-QA-05's narrow, explicit, non-training permission. A builder should confirm this reading
   before slice 2, since the two are easy to conflate by name alone.*

---

*Everything below this line is for the builder. Nothing below needs Tim to read, decide or do anything.*

---

## For the builder

### Pinned source (read 26 Sep 2026)

1. **Shipping Structural line:** `origin/claude/struc-d1-prep`, tip `0945bdf6`.
2. **Rulings:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, sections "Structural QA against the
   markup, batch 1" (UX-QA-01 to 04) and "batch 2" (UX-QA-05 to 08), both 25 Sep 2026, following directly from
   "Structural drawing journey — priority after D1" (UX-STRUC-06) in the same file.
3. **Commands:** `Modules/Structural/Commands/MarkupAICommands.cs` — `CEMARKUPVIEW`, `CEMARKUPPARSE`,
   `CEMARKUPLOAD` (and, per the registry, `CEMARKUPPLAN`, `CEMARKUPPREVIEW`, `CEMARKUPREGISTER`, `CEMARKUPRUN`,
   `CEMARKUPSTATUS`, `CEMARKUPUNDO`, `CEMARKUPDWGEXPORT`, `CEMARKUPBENCH`; 11 commands total in the
   Administration/Markup registry group plus `CEMARKUPDWGEXPORT` in the ungrouped 27).
4. **Services:** `Services/MarkupAIWorkflowService.cs` (`ParsePdf`, `LoadPackage`), `MarkupAIOrchestratorService`,
   `MarkupAICommandPlanner` (produces the placement plan CE runs, not a drawing-vs-markup comparison),
   `MarkupAIStandardsValidationService.cs` (drawing-readiness checks: missing layers/blocks/text/dim styles —
   confirmed by direct read, this is the only "Missing X" concept in the codebase today, and it is about
   drawing readiness, not markup comparison), `MarkupAIStructuralExecutionService.cs`,
   `MarkupAIPyAutocadWorkerService.cs`, `MarkupAIChatService.cs`.
5. **UI:** `UI/Palette/MarkupAIPanel.xaml(.cs)` (PDF path textbox, Browse/Read PDF buttons — confirmed by direct
   read, no image/PDF-page viewer control present), `UI/Dialogs/MarkupPreviewWindow.xaml.cs` (item/row table
   with a page combo box `cmbPage`, `DrawingPreviewSnapshot`; confirmed no rendered markup-page image control in
   the reviewed portion, and no faded-overlay-on-the-drawing-view mechanism anywhere in this file), `UI/
   MarkupWindow.xaml` (host window).
6. **Runtime state:** `MarkupAIRuntimeState.Instance` holds `CurrentPackage`, `CurrentCommandPlans`,
   `LastPackagePath`, `CurrentDrawingPreview` — the package/plan model the QA workflow should read from, not
   duplicate.
7. **Confirmed absent by direct grep** (`missing|unable to verify|different from markup|qa\b` across
   `Services/MarkupAI*.cs` and `Models/*.cs`, 26 Sep 2026): no item-state model, no round/supersede model, no
   clarification-PDF export, no drawing-to-drawing compare, no AI-vision call, anywhere in the Structural source
   tree.
8. **CEMARKUPDWGEXPORT** (`MarkupAICommands.cs:418`, per the civil-system-design planner's registry-gap
   disposition, 16 Sep 2026 reading) exports drawing standards for markup use — a specialist route, not part of
   this card's scope; do not confuse with the clarification-list PDF export in slice 5.
9. **Provider-permission record:** UX-QA-05 is the source-of-truth grant for this feature; record it alongside
   (not instead of) the existing DATA-01 corpus Gate 0 status (`04_REFERENCE\CARDS_INDEX.md`, "Gate 0 —
   privacy") so a later reviewer does not read one as clearing the other. Open question 4 above needs a builder
   sign-off before slice 2 starts.

### Automated guards to write with this card

1. Comparison engine returns the fixture's known item states exactly, headless, no AutoCAD.
2. Round supersede-tagging: a second round's matching item is marked superseded; non-matching items are
   untouched; nothing is deleted.
3. QA run makes zero writes to the drawing database (fingerprint test).
4. Title-block blanking (or refusal) happens before any page image leaves the machine — no code path sends an
   unblanked page.
5. Office-preference proposal never auto-applies; requires an explicit Tim-approval record before it changes
   behaviour on a second job.
6. No outbound email/send call exists anywhere in the clarification-PDF export path (matches UX-QA-07: "CE
   never emails").

### Open dependencies before a builder starts

1. Tim's answers to the four Open questions above (build details only — the workflow is already approved).
2. The register/issue card's "always before issue" hook (UX-QA-03) needs this card's QA-run entry point to
   exist first, or to be built in the same slice — sequence with that card before wiring the issue-time trigger.
3. The ribbon card's family/gallery work is independent of this card and does not block it; CEMARKUP's ribbon
   entry point already exists today under Administration/Markup.
