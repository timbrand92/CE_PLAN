**Code read on rel-20261009c 446162c2** (installed Civil 3.0.39; re-checked by design run 6, Fri 9 Oct 2026 about 05:25 PC clock).

**TIM'S ANSWERS RECORDED 9 Oct 2026 (INT-074, decisions file last section). Card APPROVED with these changes: Card 1.1 is now KEEP: a plastic pit is labelled on the plan ONLY by 'PP' in its cover level text (CE standard); NO separate P-number label for plastic pits (Tim: "ce standards are that plastic pits are labelled just using the pp in cover level text"); Q3: keep as per standard but upgrade to work within the system (tidy, flip and checks treat the PP cover text like any other cover text); Q12: no clear spot = first rearrange neighbouring CE labels to make room, or move the label out with a leader, only then leave it and list it; Q10: automatic readable-after-rotate/mirror, same idea as the cover-level flip; all other questions: as recommended.**


# Batch 1 card: labels on the Civil plan (Day 1 workflow), 9 Oct 2026

**Status: DRAFT. Not approved. No code may start until Tim answers `TIM_BATCH_QUESTIONS_2026-10-09.md` and approves this card.**
Written by design lane run 4 (headless, Opus), Fri 9 Oct 2026 about 03:00 Melbourne (PC clock). Read-only on plugin code.
~~"Today" below is read from the code on `master` (`Modules/Drainage`), not seen in AutoCAD, and not proof of what the installed Civil
3.0.38 does.~~ *(Superseded 9 Oct 2026, run 6: master stopped at 650c0c19 on 28 Sep. Every "today" claim was re-read on the installed
release commit 446162c2 = Civil 3.0.39; the verdicts are in "Re-check on the release commit" below and the code references at the end
are now release line numbers.)* Still read in code, not seen in AutoCAD. Every "today" line carries its file reference at the end of this card.

## Re-check on the release commit (run 6, 9 Oct 2026)

1. **Card 1.1, plastic pits get no plan label: CONFIRMED.** `Commands/PitCommand.cs:423-462` labels a pit only when
   `PitPresetLocks.CanNumberAndSchedule(plastic, manual override)` allows it; cancelling the label pick on an overridden plastic pit
   still says "Plastic pit retained unnumbered (no label)" (`PitCommand.cs:458-462`, `562-573`). `Rules/PitPresetLocks.cs:40` and
   `Services/PitAnnotationTextFormatter.cs` are unchanged since master.
2. **Card 1.2, no lasting "placed by hand" mark: CONFIRMED.** The tidy only skips labels dragged in the SAME command
   (`userMovedHandles`, `Services/LinkService.TextClashTidyUp.cs:74-81, 209, 219`; the hold message "placed by hand, so it stays" is
   `Rules/TextClashTidyUpRule.cs:117`). No stored mark on any label was found anywhere in `Modules/Drainage`. Reset Position is still
   on the grip action (`Services/LinkService.PipeAttachmentActions.cs:109, 239`).
3. **Card 1.3, Edit Pipe does not re-tidy labels: CONFIRMED.** No tidy call in any `Commands/PipeEditCommand*.cs`; a size change still
   only shifts the label for the wider pipe (`Commands/PipeEditCommand.Update.cs:658, 710`). The tidy runs after CD
   (`Services/PipeCreationService.cs:575`), a source split (`Services/SourcePlacementService.cs:1213`), Pit Edit save
   (`Commands/PitEditCommand.cs:400`) and **also the Pit Edit grip resize** (`Commands/PitEditCommand.Resize.cs:141`, new since master),
   all through `Services/LinkService.PitMoves.cs:529-534`; and after MOVE / grip / STRETCH (`Services/LinkService.Reactors.cs:733,
   748, 1280, 1369`). Still not shown in any preview.
4. **Card 1.4, no Tidy labels command: CONFIRMED.** No `CDTIDYLABELS` or similar in Drainage or Manager. The three nearest commands
   still exist: `CDANNOTATIONEDIT` (`Commands/AnnotationEditCommand.cs:24`), `CDPIPEATTACHMENTACTION`
   (`Commands/PipeAttachmentActionCommand.cs:14`), `CDPITCOVERFLIP` (`Commands/PitCoverTextFlipCommand.cs:17`).
5. **Card 1.5, what tidying avoids: CONFIRMED.** Obstacles are still only polylines, text, multiline text, callouts, dimensions,
   tables and blocks (`Services/LinkService.TextClashTidyUp.cs:566-567`); Xref blocks are dropped (`:787`); hatches, regions and
   lines are not read. A label on a locked layer stays put (`:196-200`; already on master).
6. **Card 1.6, short pipe needs clicks for its callout: CONFIRMED.** Callout above 95% of pipe length (`Services/TextService.cs:91-93,
   158`), two-line wrap above 80% (`:173`), then "Snap callout arrow to pipe" and a drag (`:397-436`).
7. **Card 1.7, no TYP.: CONFIRMED.** No "TYP" string in Drainage code.
8. **Card 1.8, Pit Schedule sort: CONFIRMED.** `Helpers/PitIdComparer.cs` unchanged (LPD, OG, P-numbers, CP-numbers, then plain
   text); the window sorts with it (`ViewModels/PitScheduleViewModel.Data.cs:261, 700`); the 90% saved-order rule is `:886`. Still
   not read: whether the printed table follows the window.
9. **Card 1.9, MIRROR / ROTATE readability: CONFIRMED.** Text is made readable only on a flip (`KeepFlippedTextReadable`,
   `Services/LinkService.PipeAttachmentGrip.cs:1067`). New since master but NOT about readability: MIRROR with "Erase source objects =
   Yes" now hands the original pit's number and record to the mirrored copy (`Services/ProjectDataService.MirrorCarry.cs`,
   `Services/LinkService.Reactors.cs:1108-1114`). Card 1.9's test list should include that case (step 9 of Tim's checklist).
10. **Related bug BUG-197: CHANGED.** The fix is in the release: CD now also slides the MAIN's label off a new branch
    (`Rules/BranchHostLabelTidyRule.cs`, `Services/LinkService.TextClashTidyUp.cs:150`, `Services/PipeCreationService.cs`
    `TidyBranchHostLabels`). Card 1.3 builds on it; it is not work to do again.
11. **Not re-checked:** BUG-329 item 2 (Pit Schedule sync resets a hand-moved pipe label); `ScheduleLinkService.cs` changed by about
    1,500 lines since master, so a builder must re-test it before relying on card 1.2's example.

**Items (9):** UX-PIT-01, UX-LBL-01, UX-LBL-02, UX-LBL-03, UX-LBL-04, UX-CPLAN-24, UX-CPLAN-25, UX-SCHED-06, UX-EDIT-03.
**Commands touched:** PIT and PP (place a pit), CD (draw a pipe), CDEDIT / PIPEEDIT / PITEDIT, PITSCHEDULE, AutoCAD's MOVE, ROTATE,
MIRROR and grip edits, and one new command, "Tidy labels".
**Why first:** these are the labels a drafter sees in Day 1 steps 3 to 11 (`04_REFERENCE\release\DAY1_FOR_TIM_2026-10-09.md`).

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` (UX-PIT-01 line 459; UX-LBL lines 861-868; UX-EDIT-03 line 1794;
UX-SCHED-06 line 2033; UX-CPLAN-23..25 lines 2061-2065), PLACE-01 in `decisions\2026-09-16_TEST_DAY_RESULTS.md` sections 6k-6l (slide
up to a Settings distance, never more than 500 mm from the pipe end, then flip; one rule plugin-wide; one U), and the July CV-01I tidy
plan (`CE_ACAD_PLUGIN\docs\workflows\CV-01I_SMART_ANNOTATION_TIDY_UP_PLAN.md`, NOT approved: its preview layout is reused only as a
starting sketch).

**Related open bugs (do not fix twice):** BUG-197 (a new branch's invert labels overlap; ~~draft PR #388 tidies the main's labels on
draw~~ *superseded 9 Oct 2026, run 6: the fix is in release 446162c2, `Rules/BranchHostLabelTidyRule.cs`*), BUG-329 item 2 (every Pit Schedule sync puts the pipe label back at its default spot, undoing hand moves), BUG-322 item 1 and
BUG-309 (labels re-placed with millimetre offsets in a metre drawing), BUG-069 (imported labels read backwards), BUG-072 and BUG-045
(pit label jumps or is left behind).

---

## Card 1.1 — UX-PIT-01: a plastic pit off the schedule still gets its plan label

1. **Tim ruled (25 Sep):** "Yes, label it (Recommended)."
2. **Today:** the opposite. `PIT` / `PP` draws a plan label for a plastic pit only when that pit's manual "number and schedule" override is
   set. A plain plastic pit gets only its cover text, with a "PP" line. The code's own rule table says "A plastic pit has no number and
   no label block". If the drafter cancels the label pick on an overridden plastic pit, the pit stays, unlabelled and off the schedule.
3. **What works:** the cover text with "PP"; the override path; the schedule leaving plastic pits out.
4. **Wrong or missing:** the ruling. A plastic pit cannot be found on the plan by number.
5. **Classification: MODIFY.**
6. **Proposed:** every plastic pit gets a plan label and a number; it stays OFF the Pit Schedule unless the override is ticked. Question 1
   asks what the label reads (a P-number from the same count, or its own count).
7. **Prompts:** unchanged from PIT: "pick the label spot" then "pick the cover-text spot". Esc at the label pick keeps the pit and places
   the label at the learned office spot (question 2), never leaves it unlabelled.
8. **Cancel / Esc / Undo:** Esc before the pit is placed leaves nothing. One U removes pit, label and cover text together (as Day 1 step 4).
9. **Existing drawings:** old plastic pits keep no label until the drafter runs Tidy labels or edits the pit (question 3).
10. **Discovery:** nothing new; the label simply appears.

## Card 1.2 — UX-LBL-01: a label you moved by hand stays where you put it

1. **Tim ruled (26 Sep):** "Stays where you put it." Hand-placed labels are remembered and never re-tidied; a new clash is listed quietly in Checks.
2. **Today:** CE remembers a hand move only inside the command that made it. During a MOVE or grip edit, the labels you dragged are left
   alone. Nothing is stored on the label afterwards, so the next CE edit (a Pit Schedule sync, BUG-329 item 2) puts it back at the
   default spot. "Reset Position" on the label's grip knows the original spot.
3. **What works:** the tidy rule itself; Reset Position; leaving dragged labels alone within the same MOVE.
4. **Wrong or missing:** a lasting "placed by hand" mark on each pipe label, invert text, flow arrow and pit label; the Checks entry for a
   hand-placed label that now clashes.
5. **Classification: MODIFY.**
6. **Proposed:** moving a CE label with MOVE, a grip or CDANNOTATIONEDIT marks it "placed by hand". From then on no CE tidy moves it.
   Reset Position (already on the grip menu) clears the mark and lets CE place it again. If a later edit makes it clash, Checks shows one
   quiet line: "P3-P4 label was placed by hand and now overlaps P4's cover level. Show where / Reset position."
7. **Save / reopen:** the mark is saved with the drawing.
8. **Undo:** one U after a hand move removes the move and the mark together.

## Card 1.3 — UX-LBL-02: CE labels re-tidy straight after an edit, in the same U

1. **Tim ruled (26 Sep):** "Straight away, in the same U." CE labels that now clash are re-placed in the edit's own preview; one U undoes edit and tidy.
2. **Today:** the tidy runs on its own after CD (draw), a source split, a PITEDIT resize or move, and after AutoCAD MOVE or grip edits (at
   the end of the command). The code says these join the edit's undo step; nobody has proved that in AutoCAD for the tidy itself. **CDEDIT
   (Edit Pipe) does not tidy**: a pipe made bigger keeps its label where it was, even if it now sits on a pit. The tidy does not show in
   any preview.
3. **What works:** PLACE-01's order (slide along the pipe, never more than 500 mm from the end, then flip, then flip and slide, then a lane
   further out), slide step and limit on Settings.
4. **Wrong or missing:** tidy after Edit Pipe; tidy shown in the edit's ghost preview; skipping "placed by hand" labels (card 1.2).
5. **Classification: MODIFY.**
6. **Proposed:** every CE edit (CD, PIT, CDEDIT, PITEDIT, Pit Schedule update, AutoCAD MOVE / STRETCH / grip) finishes with the one
   PLACE-01 tidy over the edited pipes, their pits and neighbours, skipping hand-placed labels. Where the edit has a preview (Edit Pipe,
   Edit Pit, Pit Schedule), the moved labels show in it. One U undoes the edit and every label it moved.
7. **Example:** Edit Pipe P3-P4 from 100 to 225: the wider pipe now covers the label; the preview shows the label slid 150 mm along;
   Save; one U puts the pipe back to 100 and the label back where it was.

## Card 1.4 — UX-LBL-03: a "Tidy labels" command for a sheet or a selection

1. **Tim ruled (26 Sep):** "Yes." Tidies every CE label on a sheet or selection by slide-then-flip, skipping hand-placed ones; preview first; one U.
2. **Today:** no such command. The closest are `CDPIPEATTACHMENTACTION` (flip or reset one label from its grip), `CDPITCOVERFLIP` (flip a
   pit's cover text) and `CDANNOTATIONEDIT` (move, rotate, mirror or flip one label by hand).
3. **Classification: MISSING.**
4. **Proposed name:** typed `CDTIDYLABELS` (working name; question 5), ribbon button "Tidy labels" on the Civil Annotate panel, right-click
   on a pipe or pit "Tidy labels near here".
5. **Prompts:** `Select pipes and pits to tidy, or [All] <All>:` then a preview window: each label that would move shown as a ghost at
   its new spot, with a list "Will move 14 · Placed by hand (left alone) 3 · No clear spot found 2". Each row can be unticked. Apply.
6. **What it moves:** pipe labels, invert (IL) texts, flow arrows and pipe callout text (as today's engine), and pit labels and cover
   texts (new: today's engine moves only pipe attachments; question 6).
7. **Cancel / Esc:** Esc at the prompt or Cancel in the window changes nothing. **Undo:** one U puts every label back.
8. **No clear spot:** the label stays and the list says "No clear spot found: P7 cover level. Move it by hand." Never squeezed onto something else.
9. **Speed:** over a second shows the status-bar progress with Cancel (UX-PERF-01).

## Card 1.5 — UX-LBL-04: what tidying avoids; only CE labels move

1. **Tim ruled (26 Sep):** "Avoid everything, move only CE." CE labels avoid Xref content, other disciplines' text and hatches; only CE labels move.
2. **Today:** the tidy steers clear of model-space text, multiline text, leaders, dimensions, tables, blocks, CE pipes and pit outlines.
   It ignores Xref content, hatches, regions and plain lines. It only ever moves CE pipe attachments.
3. **Wrong or missing:** Xref content (for example the architect's background text and walls) and hatches (paving, slab) are not avoided.
4. **Classification: MODIFY.**
5. **Proposed:** add Xref text and blocks, and hatch outlines, to what the tidy avoids. Locked layers and Xref content are never moved
   (native protection rule). Plain lines stay not avoided (question 7): on a busy architect's background nearly every spot has a line.
6. **Speed risk:** reading Xref content on a big background may be slow. Read only the area around the labels being tidied.

## Card 1.6 — UX-CPLAN-24: a short pipe's label leaders out automatically

1. **Tim ruled (27 Sep):** "Leader out automatically." A label that will not fit moves to the nearest clear space with a leader.
2. **Today:** when the label is wider than about 95% of the pipe, CE switches to a callout (a leader), but the drafter has to click the
   arrow point and drag the text. Labels wider than 80% of the pipe are wrapped onto two lines instead.
3. **Classification: MODIFY.**
4. **Proposed:** CE places the callout itself: arrow on the pipe's middle, text at the nearest clear spot found by the same PLACE-01 tidy,
   no clicks. The drafter can still drag it afterwards (then it is "placed by hand", card 1.2). Question 8 asks whether the two-line wrap stays.
5. **Example:** a 600 mm pipe from a downpipe to a pit: "100 DIA. UPVC PIPE AT 1 IN 100" appears off to the side with a leader to the pipe.
6. **Undo:** part of the CD step; one U removes pipe and callout.

## Card 1.7 — UX-CPLAN-25: every pipe gets its own label, never "TYP."

1. **Tim ruled (27 Sep):** "Label each." No "TYP.".
2. **Today:** no TYP. logic was found in the code: every pipe is labelled. **Classification: KEEP.** Needs only a test that proves it
   (two identical neighbouring pipes, both labelled) so nobody adds TYP. later.

## Card 1.8 — UX-SCHED-06: the Pit Schedule sorts P1, P2 ... P10

1. **Tim ruled (27 Sep):** "Mark order, natural." P1, P2 ... P10, never P1, P10, P2.
2. **Today:** the Pit Schedule window sorts the outlet (LPD) first, then OG, then P1, P2 ... P10 by number, then CP1, CP2 by number, then
   everything else as plain text. So SPS10 comes before SPS2, and P1A sits in the last group after every P number. A saved hand sort
   order wins when at least 90% of rows have one. Not read: whether the printed table in the drawing uses the same order.
3. **Classification: MODIFY (small).**
4. **Proposed:** natural order inside every group (SPS2 before SPS10, JP2 before JP10); P1A straight after P1 (question 9). Confirm the
   printed table follows the window.

## Card 1.9 — UX-EDIT-03: MIRROR or ROTATE keeps CE text readable

1. **Tim ruled (26 Sep):** "Labels stay readable." Geometry mirrors; CE text never reads backwards or upside down, whatever MIRRTEXT says;
   labels re-slide clear (PLACE-01).
2. **Today:** no MIRROR handling. After a ROTATE, CE turns the label with the pipe without checking it still reads the right way up, so a
   180-degree rotate may leave it upside down (read in code, not seen). `CDREFRESHLINKS` puts pit labels back after a MIRROR (position only).
   Labels are made readable only when first placed and when flipped. BUG-069 (imported labels backwards) is the same family.
3. **Classification: MODIFY.**
4. **Proposed:** at the end of MIRROR, ROTATE and grip rotate, every CE label on the moved pipes and pits is turned to read left-to-right
   or bottom-to-top, then the PLACE-01 tidy runs; all inside the same U. Hand-placed labels are turned to read the right way but not moved.

---

## Tests (automated, before Tim)

1. Plastic pit placed with PIT and with PP gets a label; it is not on the Pit Schedule unless overridden.
2. Hand-moved label survives a Pit Schedule sync, an Edit Pipe and a Tidy labels run; Reset Position clears it; the mark survives save and reopen.
3. Edit Pipe 100 to 225 where the label now clashes: label moved; one U restores both.
4. Tidy labels on DWG-B: count moved, left alone, no spot; Esc changes nothing; one U restores every label.
5. Tidy avoids an Xref text and a hatch; never moves a label on a locked layer.
6. Short pipe: callout placed with no clicks, text clear of other CE objects.
7. Two identical neighbouring pipes: both labelled, no "TYP.".
8. Sort: P1, P2, P10; SPS2 before SPS10; P1A after P1.
9. ROTATE 180 and MIRROR (MIRRTEXT 0 and 1): every CE label reads the right way; one U restores.
10. Undo and REDO after each of the above (Day 1 rule: REDO straight after U with nothing typed between).
11. *(Added 9 Oct 2026, run 6.)* MIRROR with "Erase source objects = Yes": the copy keeps the pit number AND its labels read the right way.

## Example drawings

1. `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B.dwg` (Civil fixture) copied to a new name for each run.
2. `DWG-A.dwg` (Civil fixture) for the MIRROR / ROTATE runs.
3. A job copy with an architect's Xref background (job W26-26 copy already in use by Codex, job number only) for card 1.5.

## Tim's AutoCAD checklist (about 10 minutes, on a copy)

1. **Plastic pit:** type `PP`, click a spot. **Should see:** a number label as well as the cover text. Open `PITSCHEDULE`: the plastic pit is not in it.
2. **Hand move stays:** MOVE one pipe label 1 m. Open Edit Pipe on that pipe, change nothing, Save. **Should see:** the label stays where you put it.
3. **Re-tidy in the same U:** Edit Pipe, change the diameter from 100 to 225, Save. **Should see:** the label slides clear. Type `U`: pipe and label both go back.
4. **Tidy labels:** type `CDTIDYLABELS`, press Enter for All. **Should see:** a preview with "Will move / Placed by hand / No clear spot". Apply, then `U`: everything back.
5. **Avoids the background:** on a drawing with the architect's Xref, Tidy labels never lands a label on the architect's text or on a hatch.
6. **Short pipe:** CD a 600 mm pipe. **Should see:** the label off to the side with a leader, no clicks asked.
7. **No TYP.:** two identical pipes side by side both carry their own label.
8. **Sort:** PITSCHEDULE with P1, P2 and P10: they read in that order.
9. **Rotate and mirror:** ROTATE a pit and its pipes 180 degrees, then MIRROR them. **Should see:** no label upside down or backwards. One `U` each puts it back.

## Code references

**On release 446162c2 (run 6, 9 Oct 2026):** the file:line references in "Re-check on the release commit" at the top replace the list
below wherever they differ.

~~Read on master, 9 Oct~~ *(superseded 9 Oct 2026, run 6: master line numbers, kept for history).* All under `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Drainage\`: `Commands/PitCommand.cs:421-460, 455-458, 553-576`;
`Rules/PitPresetLocks.cs:38-56`; `Services/PitAnnotationTextFormatter.cs:25-26`; `Services/QuickModeService.cs:63-114`;
`Services/TextService.cs:152-192, 393-460`; `Rules/LabelPlacementRule.cs:7-119`; `Models/UserSettings.cs:474-485`;
`Services/LinkService.TextClashTidyUp.cs:22-40, 74-131, 155-200, 488-632` (its header comment at line 23 says callouts are not moved;
the code does move them: stale comment); `Services/LinkService.State.cs:334-386`; `Services/LinkService.Reactors.cs:459, 606, 621`;
`Services/PipeCreationService.cs:575`; `Commands/PipeEditCommand.Update.cs:543-553, 1104-1106`; `Commands/PitEditCommand.cs:394-401`;
`Services/CompoundTransformOverrule.cs:9-27`; `Services/LinkService.PipeAttachmentUpdates.cs:213-217, 347-349`;
`Helpers/PitIdComparer.cs:14-72`; `ViewModels/PitScheduleViewModel.Data.cs:253, 682, 814-817, 840-900`.
