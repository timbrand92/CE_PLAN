# Review: a sample of the Structural tool notes, and the six "worst" new Structural faults

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:16 PC clock. **Code:** Structural 1.0.126, commit `8de95c34`, read-only copy `C:\CE_WORK\scratch\audit_struc` (HEAD checked: `8de95c34`). **Notes:** `04_REFERENCE\core-tool-notes\structural\` BEAM_1, AB, BB, DS, C1, CLEAN, STRSCHEDSYNC. **Faults:** the six at the top of `areas\trust-run\STRUCTURAL_NEW_FAULTS_TO_FILE.md`. Read line by line by a helper reader; the code behind all six faults and three of the note errors re-read by me. Nothing run.

Paths below are under `C:\CE_WORK\scratch\audit_struc\Modules\`. S = `Structural\`, D = `Structural.DesignCore\`.

---

## FOR TIM

1. The Structural notes are much better than their speed suggested: about 330 lines checked, 6 wrong and about 11 half right; AB and BB are clean.
2. All six "worst" faults are real in the code; two are narrower than written (the brace turning twice, and the A/B switch losing a brace).
3. The one to test first, on a throw-away copy only: CLEAN or FASTSAVE on a drawing that has never been saved may save over the template it was started from.

**Verdict: FIX FIRST** for five notes (BEAM_1, DS, C1, CLEAN, STRSCHEDSYNC; GO for AB and BB). Faults: file all six, with the corrections below. GO would mean fit to use, never merge or install.

---

## 1. The notes, line by line

1. **BEAM_1: about 58 lines, 1 wrong, 1 half right, 1 line number off. FIX FIRST (one line).**
   1. **5.2 wrong:** the quoted "Beam result is uncertain. Do not repeat the command; inspect the drawing." shows only with no reason code, and an uncertain result always carries one. The drafter sees "Beam result is uncertain: CE cannot confirm whether the beam was written. Do not repeat the command — check the drawing and the Undo list first." (D `ConnectedDesign\BeamRefusalWording.cs` 311-314; D `ConnectedDesign\BeamAtomicCommitCoordinator.cs` 96-105).
   2. **3.6 half right:** the 50 mm minimum is checked only when both ends are picked as points (S `Services\ConnectedDesign\Host\BeamCommandAutoCadPromptAdapter.cs` 404-408).
   3. **3.8:** the catch is at `BeamAtomicWriteSession.cs` 120-125, not 112-116; the note also misses that a no-plot or Xref layer is refused too, and only after Accept (S `Services\ConnectedDesign\Commit\BeamAtomicLayerWriter.cs` 54-71).
2. **AB: about 42 lines, 0 wrong, 1 half right. GO.** 3.2: AB refuses every unit except millimetres and unset, feet included, not only metres, centimetres and inches (S `Core\Day1UnitsGuard.cs` 11-17). Paths to `Structural.DesignCore` sit under `Modules\`, not `Modules\Structural\`.
3. **BB: about 43 lines, 0 wrong, same half-right 3.2 and path drift. GO.**
4. **DS: about 46 lines, 2 wrong, 1 half right. FIX FIRST.**
   1. **2.2 wrong:** "a link written into the beam's own record and the marker". Only the beam's record is written; the marker's own beam list is updated only if it already has one, and a newly placed marker never does (S `Services\BeamLinkService.cs` 419-420, `BeamLinkService.Persistence.cs` 132-140, `BeamLinkService.SupportStore.cs` 56-58; re-read by me).
   2. **4.1 wrong:** the "shown as ..." value is the schedule size shortened, not the size the block shows (S `Commands\SupportBlockCommands.cs` 251-257). That gap is fault 3.
   3. **3.4 half right:** a drawing with units not set goes ahead; the stop is lifted by turning the Settings value OFF, not on.
   4. **4.3:** "Enter takes AutoCAD's default angle of 0" is AutoCAD's own default, normally the last angle used; cannot be settled from CE's code.
5. **C1: about 62 lines, 2 wrong (the same as DS 2.2 and 4.1), 3 half right. FIX FIRST.** The remembered label is kept per command, CL1 and CR1 separately (S `Services\CeTextService.cs` 23, 1988, 5523-5541); the 260 search distance belongs to the switch commands such as SC1, not C1 (S `Commands\SupportBlockCommands.cs` 562, 672). "75 SHS drawn as 89 SHS" depends on the block's own size list, not read.
6. **CLEAN: about 46 lines, 1 wrong, 1 half right, 1 self-contradicting. FIX FIRST.**
   1. **3.7 wrong:** "Keeps no copy of the drawing from before the clean-up." CE's save tells AutoCAD to keep the old file as a .bak (S `Services\DrawingAutoSaveService.cs` 198, second argument `true`; re-read by me). CE writes no copy of its own.
   2. **5.2 half right:** a FAIL does not undo the ByLayer step's current colour, linetype, lineweight and dimension settings, which are set before that step's write (S `Services\CleanPipelineService.cs` 468-479).
   3. **6.4** says "not undone by U" and then "not proven either way".
7. **STRSCHEDSYNC: about 33 lines, 0 wrong, 3 half right. FIX FIRST (the headline fault is overstated, see fault 1).** The "AutoCAD error" after an erased brace happens only in the same session; after save and reopen the row is skipped silently (S `Services\ScheduleService.cs` 838-853). Its "not known" about a cancelled pick is answered: anything but OK ends the command with nothing changed (358-359).

**Overall:** about 330 lines checked, 6 wrong, about 11 half right, 2 line-number or path drifts. Not the rush job feared; five notes still carry a wrong line and must be corrected before anyone relies on them.

## 2. The six "worst" faults

1. **Schedule sync turns braces again: HALF RIGHT.** AB and BB draw the brace with the block turned 0 and the angle in the brace's own turning value (S `Services\BracingService.cs` 1677-1681, 1706-1708). The table takes that value, and only when it is 0 uses the block's turn (S `Services\ProjectDataService.cs` 322-326). Sync writes the table's angle back into the brace's own value (`ScheduleService.cs` 750-753). All re-read by me. So the angle doubles only for a brace drawn flat (within 1 degree, or the Enter default) and later turned with ROTATE, on the first sync. Braces drawn at an angle and then turned show the wrong angle in the table, but sync writes the same value back and nothing moves. The two-decimal rewrite of every length and angle is right and negligible.
2. **The A/B switch loses an older brace and says it was kept: CONFIRMED, narrow trigger.** If the BRACING block cannot be loaded, ABS only warns and carries on (S `Commands\BracingCommands.cs` 395-398); it erases the old brace and keeps that change (`BracingService.cs` 2169-2174); the insert then fails, "Block 'BRACING' not found" (1670-1673); and the line says "Could not convert one older bracing block. It was left as it was." (`BracingCommands.cs` 496-499). All re-read by me. One U brings the brace back.
3. **A schedule size the block cannot show is drawn as the default size: CONFIRMED, C2 included.** The line names the schedule size (`SupportBlockCommands.cs` 251-257); the block falls back to the command's default size and counts it as success (322-325, 1474-1484); C2's error fires only when even the default fails (326-330). Re-read by me. The fallback is in the log only.
4. **BDL has no units handling: CONFIRMED, one correction.** No units check in BDL or its start check (S `Commands\BeamPlacementCommands.cs` 97); minimum length 50 drawing units, lower-line offset 100, wall and opening search 2000 (`BeamService.cs` 65-68; `BeamPlacementCommands.cs` 145, 187-188). Correction: it is a wall and opening search, not a support search. In a metre drawing almost every beam would be refused as too short.
5. **Beam tools 1 and 2 refuse with "CE hit an internal problem": CONFIRMED, as the faults file words it.** It is about the layers CE draws the new beam and mark on (BEAM, BEAM LOWER, 25TEXT), not the beams you pick. CE refuses such a layer if it is locked, off, frozen, no-plot, from an Xref, or a different colour or linetype (`BeamAtomicLayerWriter.cs` 54-71, re-read by me); AutoCAD itself would add a line to an off or frozen layer. The refusal code is put behind a general "not completed" code (D `BeamAtomicCommitCoordinator.cs` 107-117), the message uses only the first code (S `BeamCommandAutoCadRoute.cs` 450-466), neither code has wording anywhere (searched), so the drafter answers every question, presses Accept, then reads "CE hit an internal problem it could not put into a plain reason" (D `BeamRefusalWording.cs` 80-84). Tool 2 also fails this way if the HIDDEN linetype is not loaded.
6. **CLEAN or FASTSAVE on a never-saved drawing: CONFIRMED IN CODE; the template overwrite is not measured.** Both run the same save step (S `Commands\LegacyPortCommands.cs` 11-15; `CleanPipelineService.cs` 151-172). The save goes to the drawing database's file name first (S `Services\DrawingSafetyService.cs` 354-361, re-read by me); the only refusals are automatic-save and recovery files; there is no "never saved" or template check anywhere in that path. The write is a Save As keeping a .bak (`DrawingAutoSaveService.cs` 198). If it fails, CE sends QSAVE and reports "saved" without checking (`CleanPipelineService.cs` 167-171, re-read by me). Whether the template is overwritten depends on the file name AutoCAD gives a never-saved drawing's database, which is usually the template's: test it first, and only on a throw-away copy of a template in a scratch folder, never the office template.

## What I did not check

1. The block files: the BRACING block's dynamic settings, the SUPPORT BLOCK's size list, which brace letter text is visible.
2. AutoCAD behaviour: ROTATE's default, an unsaved drawing's file name, whether U undoes CLEAN's settings.
3. The bug records the notes cite; the other 25 notes; the faults file's other 98 lines and its total of 104.
4. AutoCAD 2022 to 2024.
