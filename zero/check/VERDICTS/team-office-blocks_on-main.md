# Verdict: Stage 1 item A4, the office blocks, as merged on main (22993fa): the adversarial half

**Verdict: this would have been HOLD. A4 as it stands on main does not do what it claims, and the pass found two faults on main that put a wrong figure on the plan.** Written Fri 20 Nov 2026, about 1:30 pm, by the check room. A4 reached main at 11:07 am on one check (`C:\CE_WORK\scratch\team\check_a4_REPORT.md`, MERGE); the control room asked for the missing adversarial half. Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\office-blocks_adv_REPORT.md`; proofs in `office-blocks_adv_tests\` (28 cases on the pretend drawing: 16 failed, 12 passed; existing tests re-run 146 of 146 and 10 with 2 skipped). Checked on the bench; the report grades ten items as blockers, graded again here.

**Not a reason to pull it off main:** on a blank drawing today PT picks a point, reports the missing blocks file and draws nothing, which is the safe refusal ruled in D-352. It is a reason not to count A4 as done, and to fix the items below before the AutoCAD test room is asked to show a pit.

## 1. A4 does not meet its own claim (a ruling built short: D-275, D-352, Stage 1 line 4)

1. **The office tag is never used.** With every office block present, the pit's number is drawn as plain single-line text; the tool never places the tag block (PIT LABEL) or fills its attribute; the cover level is plain text with no mask (`src/CeCivil.Hands/Pit/PitTool.cs:195-224, 251-281, 619-625`). Stage 1 line 4: "the office pit block, its tag and its cover text". The first check credited bringing the blocks in; copying a definition into the drawing is not using it. The release list also records that PIT LABEL is not in the office master at all, only in the template copy (`office_blocks.csv:3-10`).
2. **A blocks file made as the build describes cannot supply the first pit on a blank drawing.** The reader gets a pit block's choices (grated, junction) from a placed reference; the shipped file holds definitions only, with no pit placed, so the list comes back empty and PT refuses with "no state called GRATED PIT" (`src/CeCivil.Acad/AcadDrawing.cs:450-473`, `AcadTemplate.cs:45-59`, `PitTool.cs:214-228`). Traced in the code and reproduced with an empty list on the pretend drawing; not proven with a real file, because none exists.
3. **The blocks file is not in the repository or the build** (the first check said so). And the two tests that would scan and prove it are skipped until it exists.
4. **With a usable pit block already in the drawing and the file absent, the tool carries on and draws three plain pieces** instead of saying so and drawing nothing.

## 2. Faults on main that the pass exposed (not caused by A4; each needs its own job)

1. **The plan can keep the old cover level. A wrong figure on the sheet.** P3 with CL 5.75; its leaving pipe invert 4.50; open the Pit window, type a depth of 2.00, OK. The window works out 6.50; the drawing still reads "CL 5.75" (`bench/CeCivil.Bench.Core/ToolWindow.cs:136-148`; `PitTool.cs:251-268, 284-286, 607-625, 651-653`; proof `OfficeBlocksAdversarialTests.cs:100`). The approved Pit window (D-386) has no depth box, but the rule stands for any cover that is changed or worked out: it must match the plan text. It touches team/held-depth, which is being checked now.
2. **A metre drawing is not refused** (`PitTool.cs:167-170`, `src/CeCivil.Hands/Units/DrawingUnits.cs:21-36`): one import and three pieces drawn. D-344, confirmed by Tim in D-380.
3. **Copies** (copy identity, D-340, the doorway's work, not yet built): a copied pit becomes P4 in its record while its number on the plan still reads P3; a copied cover marked assumed still reads "CL 5.75" with no "APPROX."; unticking the number on the original erases the drafter's separately copied number.
4. **A failed edit can lose a label and say everything was put back** (`PitTool.cs:375-381, 651-653`); the edit checks miss a joined pipe on a locked layer, an off or frozen text layer, paper space and reference editing for a new pit (D-348, the doorway).

## 3. The control room's five cases: what it does today

1. **A block of the same name with different contents:** the drawing's own block is NOT replaced or renamed, and existing pits are not redefined: this held. If its choices do not match the tool refuses and leaves everything alone. If they do match it uses the drawing's artwork as it is (different size, base point or attributes included) with no word to the drafter. **No ruling** on which should happen: see section 5.
2. **A locked layer:** the pit, number and cover layers locked each give a named refusal and nothing drawn: this held. Nothing is unlocked, thawed or switched on. Off or frozen layers and a joined pipe on a locked layer are not checked (section 2 item 4).
3. **An xref:** a block defined inside an xref does not count as the drawing's own and is left alone: this held. Reference editing and paper space are not checked for a new pit.
4. **The shipped file missing or damaged:** with no pit block in the drawing, nothing is drawn and no layer or block is left behind: this held; but every cause (missing, empty, locked, wrong version) gives the same "not in the tool's own folder" words. The path setting refuses absolute, network and web paths.
5. **Other units:** millimetres and unitless draw at 1; inches are converted; metres wrongly proceed.

## 4. Follow-ups

`FOLLOW_UP\part2-pit-and-pipe.md` items 34 onward: a block swapped between the first look and the import is not re-checked; editing only the cover of a pit scaled differently in X and Y flattens it; D-381 item 1 (a bare drawing's layers, text styles and linetypes brought in and said once) is not built, having been ruled after A4; the privacy scan of the blocks file does not walk paper space; an old night check still expects the stand-in square; `GapFiveTests.cs` lost its checks that a joined pipe and tag follow an older outline pit.

## 5. No ruling (for Tim's room)

1. **A drawing already holds "PIT BLOCK 3" with different artwork** (twelve pits, an off-centre base point): stop and say so (recommended); use the drawing's own with a warning; or bring the office block in under another name for new pits. Never replace the drawing's own.
2. **Where the circled tag comes from:** it is in the template copy, not the office master. May the release take it from the template copy after a scan?
3. **A drawing with no units set, or in inches:** ask before placing, refuse, or convert?
4. **The words when the blocks file cannot be opened.**

## 6. Owed in AutoCAD

Ten steps, section 5 of the report, for the AutoCAD test room on a night it is allowed and once a real blocks file exists: the first pit on a bare drawing; a same-name block; locked, off and frozen layers; xrefs and reference editing; missing, bad and partial files; what an import drags in and one Undo; units; copies and the 6.50 against 5.75 case.
