**Code read on Structural rel-20261009n 24238160** (Structural 1.0.112, train S-31, 9 Oct 15:27; read with `git show` / `git grep` on that
commit, no checkout; never master). **Installed today:** Structural 1.0.110 (`9babe787`, read from the bundle DLL product version, Fri 9 Oct
about 16:08). Every markup file cited below is identical between 9babe787 and 24238160.

# Batch 15 card: QA against the engineer's markup, roof down (third Structural roof-down batch), 9 Oct 2026

**Status: DRAFT. Not approved by Tim.** The workflow itself was settled by Tim on 25 Sep (UX-QA-01 to 08) and written up as
`04_REFERENCE\structural\cards\STRUC-MARKUP-QA_CARD_2026-09-26.md` (APPROVED-IN-PRINCIPLE; that card stays the authority for the workflow).
This batch card re-reads it on the release commit, records what has been built since (slice 1, 8 Oct), closes two of its three open
questions with Tim's 5 Oct answers, orders everything roof down, and gives every remaining choice a recommended answer. Under INT-073
(extended by the desk at 08:05 to every batch card with recommended answers), builders MAY build it on the **Recommended** answers below, as
DRAFT PRs, tests red first, every new behaviour behind a Settings value and OFF, nothing retired, no old command removed, locked layers /
Xref / REFEDIT protection unchanged. Tim's answer by number in `TIM_BATCH_QUESTIONS_8_9_2026-10-09.md` (questions 9 to 15) replaces a
recommended default in a follow-up.
Written by design lane run 9 (headless, Opus), Fri 9 Oct 2026 about 16:13 Melbourne (PC clock). Read-only on plugin code. Code lines are
not proof of what installed Structural 1.0.110 does on screen.
**Numbering:** this is **Batch 15** in `REVIEW_BATCHES_2026-10-09.md` ("QA against the engineer's markup"); the question file calls it
"card 9". The next Structural batch after it is Batch 16 (detail library and tags).

## PRIVACY FLAG FOR THE CONTROLLER (read first; found by this run, not in BUG_CARPARK)

Today, `CEMARKUPPARSE` (and the CEMARKUP window's Read PDF) in **Hand** or **Hybrid** mode, and **Hybrid is the default**
(`Commands/MarkupAICommands.cs:79` "Source mode [Bluebeam/Hand/hYbrid] <Hybrid>:"), **uploads the WHOLE markup PDF, title block included, to
OpenAI's file store** (`Services/MarkupAIVisionParser.cs:59, 106-117`: purpose "user_data", model "gpt-4.1",
`Models/MarkupAIModels.cs:222-228`), whenever an `OPENAI_API_KEY` environment variable is set on that PC. With no key it skips with "Vision
parser skipped: API key not configured." Tim's UX-QA-05 permission (25 Sep) is **Claude only, page image only, title block blanked first,
and a page whose title block cannot be blanked is not sent at all**. The two disagree on provider, on whole file versus one page, and on
the title block. The CEMARKUP chat (`Services/MarkupAIChatService.cs:38-48`, `ChatEnabled = true`) also goes to OpenAI. **Recommended
(question 10):** a small fix ahead of this batch: the OpenAI markup reading and chat are switched off (Settings "Markup reading by AI",
default OFF), Hybrid falls back to the typed Bluebeam comments only and says "Handwriting was not read: AI reading is off.", and the only
future sender is card 15.5. The controller should file it as a bug (no BUG ID is taken by this design run).

**House rules (INT-074 to INT-078), apply to everything below:**
1. **No blue** in the QA list, the overlay toggle or the clarification PDF (gold, black, white / grey). Review highlights never print.
2. **Plain name and command name together during the transition**, e.g. ribbon "Check against markup (CEMARKUPCHECK)", behind "Show
   AutoCAD command names", default ON.
3. **Roof down** (UX-STRUC-13, Tim 26 Sep and 4 Oct): the item list is grouped by round, and within a round by sheet in drafting order:
   **roof framing first, then upper floors, then the ground floor, footings last.** The checklist below runs in the same order.
4. **Unknown stays Unknown:** an item CE cannot read or match is "Can't verify" / Needs clarification, never guessed (Tim 30 Sep, C4 (c):
   "Different" only where a size is stated).
5. **No hard blocks:** open markup items at issue warn and are recorded; they never stop an issue (R-27; INT-059 item 11 "Warn on any
   departure").

**Items (9):** UX-STRUC-06 (priority), UX-QA-01 (reading), 02 (faded page + side list), 03 (when it runs), 04 (four states), 05 (provider
permission), 06 (rounds), 07 (clarification PDF), 08 (engineer-drafted changes).
**Commands touched:** CEMARKUP (window "Markup Review"), CEMARKUPPARSE ("Read Markup PDF"), CEMARKUPREGISTER ("Set Drawing for Markup"),
CEMARKUPSTATUS, CEMARKUPBENCH (admin only, unchanged); new: **CEMARKUPCHECK** ("Check against markup"), **CEMARKUPCLARIFY** ("Clarification
list"), **CEMARKUPCOMPARE** ("Compare with the last copy"). The draw-from-markup commands (CEMARKUPPLAN, PREVIEW, RUN, UNDO) are unchanged.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` lines 691-736 (UX-STRUC-06 25 Sep 23:19; QA batch 1 23:23; batch 2
23:28); `STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`; `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` INT-059 items 9 ("Place and meaning"),
10 ("Latest saved copy"), 11 ("Warn on any departure"), 12 (both title blocks), 30 Sep C4 (c) ("Only when a size is stated"), INT-073,
INT-075.

**What the 26 Sep card's open questions became:**
1. Same item across rounds: **ANSWERED** (Tim 5 Oct, INT-059 item 9, "Place and meaning"): same place on the same sheet AND the same member
   mark and the same kind of instruction; anything less sure is a new item. **Built** (slice 1). Its distance is blank: question 13.
2. Which "last version" UX-QA-08 compares with: **ANSWERED** (INT-059 item 10, "Latest saved copy"; falls back to the last issue and says
   which).
3. Does DATA-01 (the old markup corpus privacy hold) touch live QA reading: **still open**; recommended (as the 26 Sep card): no, provided
   card 15.5's rules hold; a reviewer confirms before slice 2.

**Who does what (INT-073: windows stay Codex's):**
1. **Claude (behaviour):** the item engine wiring, the "is it drawn" matching, rounds, the roof-down sort, the AI sending path with title-block
   blanking and the refusal, the markup page underlay on a non-plotting layer and its removal, the clarification PDF content, the compare
   engine, every command and prompt, Settings values, tests.
2. **Codex (windows):** the docked QA list palette (rows, state buttons, snippet pictures, the open count), the "Show markup" toggle, the
   clarification PDF's look, the Settings rows, and every AutoCAD acceptance run (it looks at the faded page and the PDF).

---

## Card 15.0 — UX-STRUC-06: the order after beams

1. **Tim ruled (25 Sep 23:19):** after D1, (1) QA against the markup, (2) register, revisions and issue, (3) background preparation; the
   detail browser later.
2. **Today:** recorded; this batch is item (1). Register / issue is Batch 17; background preparation is Batch 19.
3. **Classification: KEEP** (a ruling, nothing to build). The only build tie: UX-QA-03's "before issue" hook waits for Batch 17's issue tool.

## Card 15.1 — UX-QA-01: CE reads the markup and proposes; you correct

1. **Tim ruled (25 Sep):** "CE proposes, you correct". Each item with its markup snippet beside it; fix or delete a wrong item; click a mark
   CE missed to add it; CE learns from corrections (UX-LEARN-01: shows why, never silently changes a rule).
2. **Today:**
   - The reader exists for **draw-from-markup**: CEMARKUPPARSE asks "Select markup PDF:" (Codex PASS7 item 187), then "Source mode
     [Bluebeam/Hand/hYbrid] <Hybrid>:"; typed Bluebeam comments are read on the PC; handwriting goes to OpenAI (privacy flag above). It
     builds a list of CE commands to draw what it read, with a confidence score (`Services/MarkupAIWorkflowService.cs:38-90`,
     `MarkupAICommandPlanner`).
   - The review window lists planned items by page; there is **no snippet picture** of the mark beside an item, no Fix / Delete / Add-missed
     on a QA item, and nothing learns from corrections.
3. **What works:** the PDF reading and its page / item model; Bluebeam comments read locally; CEMARKUPREGISTER ties a package to a drawing.
4. **Classification: MODIFY** (reader kept) / **MISSING** (the QA correction step).
5. **Proposed:**
   - CEMARKUPCHECK reads the registered markup package (it does not re-read the PDF) and turns each mark into a QA item.
   - Each row: the snippet (the mark cropped from the page), CE's reading in plain words ("B1 to 300PFC"), sheet, round, state.
   - **Fix** (edit CE's words), **Delete** (not a real instruction, kept in a "Deleted" filter with who and when), **Add a missed mark**
     (click on the faded page, card 15.2, type what it says).
   - Every correction is saved with the job and written to the local learning record with the before and after words; nothing changes a
     rule or an office setting by itself (14 Sep: a repeated decision may become a PROPOSED office preference only after Tim approves).
6. **Esc / Undo:** a correction is a list change, not a drawing change; each has its own Undo inside the list (Ctrl+Z in the palette).

## Card 15.2 — UX-QA-02: the markup page faded under the plan, with a list docked beside it

1. **Tim ruled (25 Sep):** "Faded over the plan + side list". The page sits lined up and faded under the drawing (toggle on / off); the
   list is docked beside; clicking an item zooms there.
2. **Today:** nothing. No PDF underlay is used anywhere in Structural (no `PdfReference` / underlay code on the commit); the review window is
   a separate window with a page picker.
3. **Classification: MISSING.**
4. **Proposed (questions 11 and 12):**
   - CE attaches the markup page as an AutoCAD **PDF underlay** on a CE review layer that **never plots** ("CE-MARKUP-REVIEW", plot off),
     faded (underlay fade from a Settings value, start 60), behind everything.
   - **Lining up:** when the markup is a print of this sheet, CE lines it up by the sheet border (the office A1 horizontal or A3 classic
     title block, INT-059 item 12, both known). When it cannot, it asks: "Pick a point on the markup page:", "Pick the same point on the
     drawing:", twice (two pairs), and says how far off the fit is.
   - **Toggle** "Show markup" in the list (and typed CEMARKUPCHECK option "Show/Hide").
   - The underlay is **removed** when the QA list closes, and always before a plot or issue (the 14 Sep rule: review highlights never on an
     issued sheet). If AutoCAD is saved with it on, it is on the non-plotting layer and removed at the next open of the list or the next
     plot.
   - The docked list = a palette that stays open (UX-WIN-04), Codex's window. Click a row: Show where (Batch 2 card 2.4: zoom to about a
     third of the screen, glow in the attention colour, never the drafter's selection, Esc clears).
   - Native protection: if the drawing is read-only or the review layer cannot be made, CE says so and shows the snippet list only; it never
     unlocks or changes another layer.
5. **Undo:** attaching and removing the underlay are each one U and touch nothing else in the drawing.

## Card 15.3 — UX-QA-03: on demand, and before issue; a quiet open count

1. **Tim ruled (25 Sep):** "On demand + at issue". A "Check against markup" button, always before issue, and a quiet open-item count;
   never pop-ups.
2. **Today:** no QA run exists. **No Structural issue command exists on this commit** (none found for issue, publish, plot or revision),
   so "before issue" has nowhere to hook yet.
3. **Classification: MISSING.**
4. **Proposed:**
   - New command **CEMARKUPCHECK**, ribbon Markup > "Check against markup (CEMARKUPCHECK)". Prompts:
     1. No markup registered for this drawing: "No markup is set for this drawing. Pick the markup PDF:" (file dialog, starts in the job's
        markup folder).
     2. "Markup round name <P1>:" (next free round offered: P2, P3 ...).
     3. Then the list opens; the page fades in (card 15.2).
   - Quiet count: on the CE panel and the list header, "Markup: 3 open (P2) · 12 checked". Nothing pops up.
   - Before issue: when Batch 17's issue tool exists, it shows "3 markup items are still open (P2). Issue anyway? [Issue/Show them]" and
     records the answer; it never stops the issue (R-27, INT-059 item 11).
   - Behind the Settings switch "Markup QA list" (exists: `MarkupAI.QaEnabled = false`, `Models/MarkupAIModels.cs:240-242`); stays OFF until
     Codex passes the list.
5. **Esc / Undo:** Esc at either prompt: "Nothing was changed." Running the check writes nothing to the drawing except the underlay (card
   15.2).

## Card 15.4 — UX-QA-04: four states; CE may set Drafted; only a person sets Checked

1. **Tim ruled (25 Sep):** "Yes, those four". To do, Drafted, Needs clarification, Checked. CE may set Drafted when it sees the item drawn;
   only a person marks Checked.
2. **Today: the engine is BUILT, OFF, with no caller** (slice 1, commit 3c860da6, 8 Oct; `Services/CeMarkupQaList.cs`): the four states;
   CE can only set Drafted; CE never touches a Checked item; plain refusal lines ("Only a person can mark P1-3 Checked."); an open count
   that leaves out Checked and superseded items.
3. **Missing:** how CE "sees the item drawn". Nothing compares an item with the drawing yet.
4. **Classification: KEEP** (engine) / **MISSING** (the drawn check).
5. **Proposed:**
   - CE sets **Drafted** only when the item names a member mark AND states a size, and the drawing now has that mark at that size (from the
     member tags and the member schedule, Batches 13 and 14), for example "B1 to 300PFC" and B1 is now 300PFC. (Tim 30 Sep, C4 (c): only
     when a size is stated.)
   - Every other item waits for a person. A small second word says why an item is not Checked yet: "Missing" (mark not on the drawing),
     "Different" (mark there, size stated, size differs), "Can't verify" (no size stated, or CE could not read it).
   - Needs clarification is set by a person, or proposed by CE for a mark it could not read (the person confirms).
   - States, who and when are saved with the job (save, close, reopen: unchanged).
6. **Undo:** a state change has its own Undo in the list; nothing in the drawing changes.

## Card 15.5 — UX-QA-05: only the markup page, only to Claude, title block blanked, or not sent

1. **Tim ruled (25 Sep):** "Yes, Claude only, page only". Only the markup page image goes, only to Claude through CE's connection, never
   kept for training; title block blanked first where possible. And: "Don't send; say so" when it cannot be blanked (the user tags that
   page's marks by hand).
2. **Today: CONFLICTS** (privacy flag at the top): whole PDF, OpenAI, title block included. The shared AI runtime already has a Claude
   client that sends images (`CE.AI.Core/AnthropicChatClient.cs:272-282`), but **Structural does not reference CE.AI.Core** (its project
   references only CE_SHARED and DesignCore), so wiring it is a module change to plan, not a one-line swap.
3. **Classification: REBUILD** (the sending path).
4. **Proposed:**
   - One sender: each page is turned into a picture on the PC; the title-block area is painted white (its position known from the office
     A1 horizontal / A3 classic title blocks, or the sheet border found on the page); **only that picture** goes to Claude through CE's
     connection with the no-training setting.
   - A page where CE cannot find the title block is **not sent**: "Page 2 was not sent: CE could not cover the title block. Add its marks by
     hand (click on the faded page)."
   - The permission is recorded once (who, when, the exact wording of UX-QA-05), shown in Settings as read-only text; a drafter cannot widen
     it to another provider.
   - The OpenAI path is switched off by the small fix in question 10 and not used again.
   - Behind the Settings switch "Markup reading by AI" (default **OFF**).
5. **Undo:** nothing in the drawing; a cancelled read sends nothing further.

## Card 15.6 — UX-QA-06: one list, grouped by round; a changed item is "superseded by P3"

1. **Tim ruled (25 Sep):** "One list, grouped by round". New round's items join the list tagged by round; earlier open items stay open;
   items a new round changes are marked "superseded by P3". And 5 Oct (INT-059 item 9): "Place and meaning".
2. **Today: BUILT in the engine** (slice 1): same sheet, within a distance on the sheet, sharing the same member marks, exactly one earlier
   candidate, the same kind of instruction (size change, remove, add; a check note never replaces anything); nothing deleted; a round name
   used twice is refused in plain words. **The distance is blank** (`MarkupAI.QaSameItemDistanceMm = null`): until Tim gives it every new
   mark is a new item and CE says "The same-item distance is not set in Settings, so every P2 mark is listed as a new item."
3. **Classification: KEEP** (engine) / **MODIFY** (wire it to the list; sort roof down).
4. **Proposed (question 13):**
   - The list groups by round (newest first), then by sheet in **roof-down order**: roof framing, upper floor framing, ground floor,
     footings and slab last; within a sheet, top-left to bottom-right.
   - Sheet order comes from each plan's level (CSPLANLEVEL, Batch 13) where set; a sheet with no level goes last with "level not set".
   - Superseded items stay visible, struck through, "superseded by P3", with their state kept.
   - The same-item distance is Tim's number on the Settings page (question 13; recommended start 15 mm on the printed sheet).

## Card 15.7 — UX-QA-07: a clarification list as a PDF, with snippets; CE never emails

1. **Tim ruled (25 Sep):** "Yes, a PDF list with snippets". Needs-clarification items become a one-page PDF with markup and plan snippets;
   the user sends it; CE never emails.
2. **Today:** nothing. (CEMARKUPDWGEXPORT, "Export Drawing Standards for Markup", is a different thing.)
3. **Classification: MISSING.**
4. **Proposed (question 14):**
   - New command **CEMARKUPCLARIFY**, list button "Clarification list (PDF)". Prompts: "Clarification list for round <P2>:", then it
     makes the PDF and opens it.
   - Content: job number, round, date; one row per Needs-clarification item: item number, sheet, the markup snippet and the plan snippet side
     by side, and the drafter's question (typed in the list; blank = "Please confirm"). Roof-down order. One page when it fits, more pages
     only when it must. No title-block contents of the engineer's markup page.
   - Saved in the job folder `Markups\Clarifications P2 2026-10-09.pdf` (question 14); a second run the same day replaces it.
   - **No send, no email, no upload anywhere** (an automated guard proves it).
5. **Esc / Undo:** Esc: "Nothing was made." Nothing in the drawing changes.

## Card 15.8 — UX-QA-08: the engineer drafted the changes; CE compares with the last copy

1. **Tim ruled (25 Sep):** "Yes, compare drawing versions"; 5 Oct (INT-059 item 10): "Latest saved copy" (falls back to the last issue and
   says which was used).
2. **Today:** no drawing compare in Structural. Civil has CDXREFCOMPARE (background Xrefs) and CDIMPORTCOMPARE, different jobs.
3. **Classification: MISSING.**
4. **Proposed (question 15):**
   - CE keeps a small record of the Structural objects (marks, sizes, positions, footings, schedules' typed cells) each time the drawing is
     saved by a CE user: "the latest saved copy".
   - New command **CEMARKUPCOMPARE**, ribbon "Compare with the last copy (CEMARKUPCOMPARE)": "Compare with [Saved/Issued] <Saved>:"; if no
     saved record exists it uses the last issue and says "Compared with the last issue (9 Oct): no saved copy was recorded."
   - Differences become items in the same list as round "ENG 9 Oct": added, removed, size changed, moved more than the Settings distance
     (question 15; recommended 100 mm), each with the same four states and Show where.
   - It compares objects, not pictures: a change in an Xref or a plain line is not listed (says "Only CE objects were compared.").
5. **Esc / Undo:** Esc: "Nothing was changed." Nothing in the drawing changes.

---

## Recommended answers a builder may use now (INT-073)

1. **Privacy fix first:** OpenAI markup reading and chat OFF; Hybrid uses typed Bluebeam comments only and says handwriting was not read.
2. Faded page lined up by the sheet border; two point pairs when it cannot.
3. Faded page = PDF underlay on a non-plotting CE layer, removed when the list closes and before any plot.
4. Same-item distance: **blank until Tim types it** (recommended start 15 mm on the sheet); until then every new mark is a new item.
5. Clarification PDF saved in the job's `Markups` folder, opened, never sent.
6. Compare: CE objects only; moved more than 100 mm counts; falls back to the last issue and says so.
7. List order: round, then sheet roof down (roof, upper floors, ground, footings last).
8. Drafted only when a size is stated and matches (Tim 30 Sep); the person sets everything else.

## Slices (smallest first; slice 1 is built)

1. ~~Slice 1: item list, four states, rounds~~ BUILT 8 Oct (3c860da6), OFF, no caller.
2. **Slice 0 (new): the privacy fix** (question 10), before anything else.
3. Slice 2: the drawn check (card 15.4) and the roof-down sort, headless, against fixtures.
4. Slice 3: CEMARKUPCHECK and the docked list (Codex window) with Show where; typed Bluebeam comments only.
5. Slice 4: the faded page underlay and its removal (card 15.2).
6. Slice 5: the Claude page sender with title-block blanking (card 15.5), after a reviewer signs off DATA-01 open question 3.
7. Slice 6: the clarification PDF (card 15.7).
8. Slice 7: the compare (card 15.8).
9. Slice 8: the before-issue warning, when Batch 17's issue tool exists.

## Tests (automated, before Codex)

1. Privacy: with a key set and AI reading OFF, no request leaves the PC in any source mode (network call guard); Hybrid says handwriting was
   not read; no code path uploads a whole PDF.
2. Blanking: a fixture page with the office A1 title block: the picture sent has that area white; a page with no recognisable title block is
   refused with the plain line and nothing is sent.
3. Drawn check: "B1 to 300PFC" with B1 300PFC on the drawing: Drafted; with B1 250PFC: "Different"; "check B1" never Drafted; a Checked item
   never changed by CE.
4. Rounds and sort: P1 then P2 on roof, first floor, ground and footing sheets: newest round first, sheets roof to footings; with the
   distance blank no supersede happens and the plain line says why.
5. Underlay: attaching puts the page on a non-plotting layer and nothing else changes (drawing fingerprint of all other objects identical);
   closing the list removes it; a plot request removes it first; U restores the previous state.
6. Clarification PDF: contains only Needs-clarification items, roof-down order, both snippets per row; no send / email / upload call exists in
   that code path.
7. Compare: saved record then a B1 size change and a removed post: two items in round "ENG"; with no saved record it uses the last issue and
   says so; an Xref change is not listed.
8. Save / reopen: states, rounds, corrections and superseded marks unchanged.

## Example drawings

1. Synthetic only (no client job, DATA-01): a fresh two-drawing test job made from Codex's Structural copies in
   `C:\Lisp Files\_TEST_COPIES_20260923` (the DWG-S family), with a roof framing sheet, a first floor sheet, a ground floor sheet and a
   footing sheet, plan levels set (CSPLANLEVEL).
2. A made-up markup PDF, round P1, printed from those sheets with the office A1 title block: on the roof sheet one item drawn as marked
   ("R1 to 240x45"), on the first floor one missing ("ADD FB3 2/240x45"), on the ground floor one different ("B1 to 300PFC", drawn 250PFC),
   on the footing sheet one unreadable scribble; round P2 changing the first-floor item; one page with its title block cut off (to prove
   "not sent").
3. The same job copied after "the engineer" changes B1 and removes one post, for the compare.

## Tim's AutoCAD checklist (about 10 minutes; Codex first; roof first, footings last)

1. **Privacy (do this first):** with AI reading OFF, Read Markup PDF in Hybrid. **Should see:** "Handwriting was not read: AI reading is
   off." Nothing is sent.
2. **Roof sheet:** Markup > Check against markup, pick the P1 PDF, round P1. **Should see:** the page faded under the roof plan, lined up;
   the list docked with the roof item first; "Show markup" turns it off and on.
3. **Upper floor:** click the "ADD FB3" row. **Should see:** the drawing zooms there with a glow; the row says "Missing". Draw FB3, mark it
   Checked yourself (CE cannot).
4. **Ground floor:** the "B1 to 300PFC" row says "Different"; change B1 to 300PFC. **Should see:** CE sets it Drafted by itself.
5. **Footings last:** the scribble row: set Needs clarification, type a question, Clarification list (PDF). **Should see:** a PDF in the job's
   Markups folder with the markup and plan snippets side by side; nothing emailed.
6. **Next round:** load P2. **Should see:** the first-floor item "superseded by P2" (after you have typed the same-item distance in
   Settings); other P1 items unchanged.
7. **Engineer's own changes:** Compare with the last copy. **Should see:** "B1 size changed" and "post removed" as items in round ENG.
8. **Close and reopen:** every state as you left it; plot preview shows no faded markup and no glow.

## Code references (Structural release commit 24238160)

Under `Modules\Structural\`: `Commands/MarkupAICommands.cs:30, 53, 79, 113, 159, 185, 216, 251, 268, 285, 304, 339-380, 418`;
`Commands/UiCommands.cs:91` (CEMARKUP); `Services/MarkupAIWorkflowService.cs:38-90`; `Services/MarkupAIOrchestratorService.cs:20, 64, 95`;
`Services/MarkupAIVisionParser.cs:19, 31-80, 106-117, 205`; `Services/MarkupAIChatService.cs:38-48, 247`; `Services/CeMarkupQaList.cs:1-205`
(slice 1, commit 3c860da6, 8 Oct); `Models/MarkupAIModels.cs:64, 222-247`; `Assets/Config/command-registry.json:85-87, 654-826` (labels
"Markup Review", "Read Markup PDF", "Set Drawing for Markup", "Markup Progress" ...); `CE_STRUC_SUITE.csproj:162, 175` (references: CE_SHARED
and DesignCore only). Shared: `CE.AI.Core/AnthropicChatClient.cs:272-282` (image sending exists, not referenced by Structural).
Not found on that commit: any PDF underlay, any title-block blanking, any Claude call from Structural, any drawn-versus-markup matching, any
clarification PDF, any Structural drawing compare, any Structural issue / publish / revision command.
Codex: `CODEX_TEST_REPORT_PASS7_2026-09-24.md` items 184-189 (CEMARKUP commands open and refuse cleanly with no package; nothing sent).
