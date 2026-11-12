# Review: PR 2062 `claude/trust04-startup-checks` (TRUST-04 queue item 12, BUG-1286: the shared start-up check added to eight tools)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `da1a6e49` (own commits `b12d227b`, `da1a6e49`) on `claude/rel-20261108a` = installed Civil `cf059dcf` (checked). **Against:** `BUG_CARPARK.md` BUG-1286 and Tim's decision 6 (7 Nov): "yes but some of the commands are useful in all drawings as ce tools". **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Six Civil tools (reverse flow, move pipe text, move flow arrow, tidy labels, set destination, pipe system) now refuse a read-only drawing, Paper Space and an open reference edit before asking anything. That is right.
2. But Move and Rotate (MR) and Copy and Rotate (CR), which are general drafting tools, now also get CE Civil's drawing-type question: on a Structural drawing they refuse unless you answer Yes, on an untagged drawing they ask "Is this a Civil drainage drawing?" (Enter tags it Civil), and on a layout tab they refuse.
3. Help, Settings and CE Blocks are not touched.

**Verdict: FIX FIRST** (one item). GO would mean fit for testing on copies, never to merge or install.

---

## FIX FIRST

1. **MR and CR must stay usable on every drawing.** The shared check (`Services\DrawingSafetyService.cs` 18-20, 61-130) ends with Civil's drawing-type gate (`DrawingDisciplineService.EnsureCivilAllowed`, 33-75; outcomes in `DrawingDisciplinePolicy.cs` 118-141). Added to MR and CR on AutoCAD 2027 (`Commands\CopyRotateCommands.cs` line 40) and 2022 to 2026 (lines 125 and 141), it means:
   1. **Structural drawing** (tagged, or "STR" in the file name): "[CE] This is a Structural drawing, so CE Civil is switched off here (MR has not run)." then "Turn on CE Civil for this drawing? <No>"; Enter cancels MR (`DrawingDisciplineService.cs` 101-125).
   2. **Untagged drawing with no CE data** (a survey, a consultant's plan, a title block drawing): "CE: This drawing isn't tagged yet. Is this a Civil drainage drawing? <Yes>"; Enter writes the Civil tag into the drawing before MR has done anything; No tags it Structural and cancels MR (127-162). Either answer is a drawing change MR never made before.
   3. **On a layout tab outside a viewport:** refused ("cannot run in Paper Space"). MR and CR worked there before.
   4. **Any drawing it allows:** Civil's editing watch is switched on for it (`DrawingDisciplineService.cs` 73).
   This contradicts decision 6, and the brief names MR and CR among the all-drawing tools. Suggested fix (DRAFT default for Tim): MR and CR keep the read-only check and the reference-edit check (native protection) but not the drawing-type gate and not the Paper Space refusal. The check's own core already takes the gate as a value (`CommandPreFlightCore(..., disciplineGate)`), so a version with no gate needs no copy of the checks. A test that MR on a made-up Structural drawing and on an untagged drawing asks nothing must fail on today's head.

## Checked and sound (by reading)

1. **The six Civil tools** run the check first, with their own name, before any question or read: CDTEXTSEG (`CdCommand.Arrows.cs` 24-29), CDMA typed only (247-251; CD's window reuses the arrow routine after CD's own check), CDSYSTEM (`PipeSystemCommand.cs` 29-32), CDREVERSEFLOW (`RibbonContextCommands.cs` 35-38), CDDEST (`SourceDestinationCommand.cs` 39-42), CDTIDYLABELS (`TidyLabelsCommand.cs` 33-36). For these Civil tools the drawing-type gate is the same one PIT and CD use: right.
2. **MR and CR are not checked twice:** the 2027 and the 2022 to 2026 versions are separate builds (`#if NET10_0_OR_GREATER`), so one run asks at most once. The older version's own reference-edit refusal stays (lines 159 and 208).
3. **Plain words:** the refusals are the existing lines PIT gives ("[CE] MR cannot run - drawing is read-only.", "... cannot run in Paper Space. Please switch to the Model tab.", the REFEDIT line "Finish or close it (REFCLOSE) first. Nothing was changed."). No software words added.
4. **Help (CDHELP), Settings (CDS) and CE Blocks are not touched** (the diff changes seven command files, none of them).
5. **Seven of BUG-1286's fifteen left out, with a reason** (CDCALC, CDMANAGER, CDRAINFALL, CDRULEBOOK, CDRULES, CDTWL only read or open a window; PITSCHEDULE refuses read-only and REFEDIT itself and may be placed on a layout). Listed as a DRAFT default; sensible, since the shared check would also stop them being used just to read a job on a read-only drawing. The bug entry should say "8 of 15 done, 7 left on purpose" so it is not closed whole.
6. **Tests:** a source guard that each of the eight calls the check with its own name before its first question or read. No behavioural case (needs AutoCAD).

## Worth knowing

1. Whether the Structural plugin also registers MR and CR (it has its own move-and-rotate service) decides which one a Structural drafter gets when both suites are loaded; not checked.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. The Structural suite's own MR and CR, and AutoCAD 2022 to 2024 beyond reading.
