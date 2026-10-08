# Bug hunt, Civil, Day 1 steps 1 to 13 (hunt_civil run 1)

**Written Fri 9 Oct 2026, 08:41 to 08:53 Melbourne (PC clock). Read-only helper, MAX account, desk plan/03.**

**What was read.** The installed Civil code, release commit `rel-20261009e` (1200744d), read with `git archive` into a scratch folder. Nothing was checked out, built or run. No AutoCAD, no accoreconsole. Every finding below is from reading the code only. **Nobody has seen any of these in AutoCAD.** Where a sentence says what AutoCAD itself does, it is marked "I think".

**Next commit checked too.** `rel-20261009g` is now at 660487d1 (Civil 3.0.41), one version-number commit on top of 319ba688. None of the 15 findings below is touched by it. One side note: on 3.0.41 the Pit Schedule line "Override enabled for linked row." becomes "Your typed value is waiting. Right-click the row and choose Stop overriding to write it to the drawing." So DAY1 step 10's expected wording changes with the next install.

**Carpark checked.** `C:\CE_PLAN\BUG_CARPARK.md` (next ID BUG-458) was searched for each one: locked layers, REFEDIT, metre drawings, decimals, text style, SPS, tolerance, read-only, "Nothing was changed". Metre-drawing faults are already covered in depth (BUG-330, BUG-331, BUG-337 and the C-6 entries), so none is repeated here. Esc at the pit label pick leaving a pit unlabelled is already in the Batch 1 card (Tim INT-074 item 2), so it is left out.

**Paths.** File paths are inside `Modules/Drainage/` at 1200744d unless named otherwise.

---

## The 15 findings, most valuable first

### HUNT-C-01 (HIGH): PIT, CD, Edit Pit and the Pit Schedule all run during an in-place Xref edit (REFEDIT)

1. **What the drafter sees.** Type `REFEDIT`, pick a consultant's Xref, then `PIT` and place a pit. The pit goes in, then the command line says "[CE] Pit retained without its number label: the label could not be written safely." The pit has no number.
2. **Why (the code shows).** The one start check every Civil command uses, `Services/DrawingSafetyService.cs:32-89`, checks read-only, UCS, paper space and discipline. It never checks for an open reference edit. The pit-number writer does check, and refuses (`Services/BlockService.cs:2500`), so the pit lands but its number does not. CD (`Commands/CdCommand.cs:38-247`) and Edit Pit (`Commands/PitEditCommand.cs:631-652`, which calls `Services/CeBatchEditApplyCoordinator.cs:292-321`) have no reference-edit check either.
3. **I think.** AutoCAD adds new objects made during REFEDIT to the reference being edited, so a pit or pipe could be saved back into the consultant's Xref at REFCLOSE. Not verified. This breaks the native protection rule in AGENTS.md ("respect ... REFEDIT").
4. **Steps in AutoCAD.** Copy of a job drawing with an Xref attached. `REFEDIT`, pick the Xref, OK. Type `PIT`, click a spot, fill the window, place it. Read the command line. Then `REFCLOSE`, Discard.
5. **Right result.** PIT refuses at once with one plain line, for example "Finish or close the reference edit (REFCLOSE) first. Nothing was placed."
6. **Test today.** None. No test covers a CE start check during REFEDIT (searched `Modules/Drainage.Tests`).
7. **Smallest fix.** Add one check to `CommandPreFlightCore`: if `REFEDITNAME` is not empty, say the line above and stop. One place covers PIT, PP, CD and Edit Pit. Call the same check when the Pit Schedule opens (see HUNT-C-07).

### HUNT-C-02 (MEDIUM): Edit Pit with the pit's label or cover text on a locked layer changes the pit, then stops with a vague error

1. **What the drafter sees.** Lock the pit label layer (or the pipe text layer, where cover text lives). `PITEDIT`, change a 450 pit to 600, Save. The pit grows, the label does not move, and the command line says only "[CE] Error during PITEDIT - see CE log for details." There is no "press Undo" advice. The schedule still says 450.
2. **Why (the code shows).** The pre-check only looks at the pit itself (`Commands/PitEditCommand.cs:631-652`), although its own comment says it catches locked layers. The pit size is written first (`:573`). Then the label move fails quietly (`ShiftAnnotation`, `:1574-1627`, which logs and carries on). Then the number write opens the label for writing with no lock check (`:1347` into `Services/BlockService.cs:2400`, `rejectLockedLayer: false`, then `:2289`). The cover text is opened for writing with no lock check too (`UpdateCoverTextContents`, `:1423`). I think AutoCAD refuses those writes on a locked layer. The refusal escapes past the step ledger, so the careful "Part of this edit already reached the drawing ... press Undo once" message (`Commands/Editing/CeEditRetryPolicy.cs:83-86`) is never shown. The outer catch prints the vague line (`:470-474`). The project record is not updated, so the drawing and the schedule disagree.
3. **Steps in AutoCAD.** Copy drawing. `LAYER`, lock the pit label layer. `PITEDIT`, pick a pit, change X size 450 to 600, Save. Read the command line. Look at the pit and its label. Open `PITSCHEDULE` and read that pit's size.
4. **Right result.** Refused before anything changes: "The pit label is on locked layer PIT LABEL. Unlock it and press Save again. Nothing was changed."
5. **Test today.** None for this route.
6. **Smallest fix.** In `PreFlightPitEdit`, run the same writable check on each pit attachment (label and cover text) before the first write. Also write the existing-label number with `protectNative: true`, as PIT does.

### HUNT-C-03 (MEDIUM): PIT with the pit label layer locked leaves an empty label circle it cannot remove

1. **What the drafter sees.** With the pit label layer locked, `PIT` places the pit, asks for the label spot, and then says "[CE] Pit retained. Its number label could not be verified or removed; review that label before issue." An empty label sits on the locked layer.
2. **Why (the code shows).** PIT checks only the pit layer for a lock (`Commands/PitCommand.cs:303-310`). The label block is inserted with no lock check (`:428-434`, `Services/BlockService.cs:854-884` has none). The number write then refuses the locked layer (`Services/BlockService.cs:2508-2509`). The clean-up erase opens the label for writing (`Commands/PitCommand.cs:541-559`). I think AutoCAD refuses that on a locked layer, so the empty label stays. The cover text layer is not checked either.
3. **Steps in AutoCAD.** Copy drawing. Lock the pit label layer. `PIT`, click a spot, type P99 and a cover level, place, click the label spot, click the cover spot. Read the lines. Look for an empty circle.
4. **Right result.** Refused before the pit goes in, the same way a locked pit layer is: "Pit not inserted - layer 'PIT LABEL' is locked. Unlock the layer, then run PIT or PP again."
5. **Test today.** None.
6. **Smallest fix.** At `PitCommand.cs:304`, also check the label layer (when Add label is ticked) and the cover text layer (when Add cover text is ticked).

### HUNT-C-04 (MEDIUM): CDRULES and CDCHECK can say "Nothing was changed" after something was changed

1. **What the drafter sees.** "[CE] CDRULES could not read the drawing. Nothing was changed." when CDRULES has already written its run into the drawing, or (with `pReview`) already applied an approved level fix. CDCHECK prints "Nothing in the drawing was changed." before the Connect, Disconnect, Flow and Main actions it then offers, which do change the drawing.
2. **Why (the code shows).** CDRULES records the run in the drawing (`Commands/RulesCommand.cs:111`), then saves its list file (`:112`), then may apply fixes (`:116`, `:204`). Any failure after line 111 lands in the one catch (`:118-121`) with the untrue sentence. CDCHECK says "Nothing in the drawing was changed" at `Commands/SpineCheckCommand.cs:161`, then runs the item actions inside the same try (`:183-191`, `:334-359`). Its catch (`:193-201`) also says "Nothing was changed", and calls a failed file save "could not read the drawing".
3. **Steps in AutoCAD (Codex, on a copy).** The easiest trigger is a failed list save: make `%APPDATA%\CE_CVL_SUITE\logs` read-only for the test, run `CDRULES`, `P`. Read the last line, then `CLOSE` and see if AutoCAD asks to save. Put the folder back afterwards.
4. **Right result.** The sentence says what happened: "The check ran and was recorded in the drawing, but the list could not be saved: <reason>."
5. **Test today.** None for these sentences.
6. **Smallest fix.** Track whether the run record (or a fix) was written, and choose the end sentence from that. In CDCHECK, move "Nothing in the drawing was changed" after the actions, or say "No change so far".

### HUNT-C-05 (MEDIUM, R-00): the New Pipe "typed grade does not match the levels" question uses a fixed 10 per cent, not the Settings value

1. **What the drafter sees.** Two parts of CE disagree about the same pipe. Set my own grade 1 in 100 with levels that give about 1 in 111: New Pipe asks the mismatch question, but the Pit Schedule shows no grade note. With levels that give about 1 in 90.5: New Pipe says nothing, the Pit Schedule shows the red CHECK note.
2. **Why (the code shows).** New Pipe uses a fixed `0.10` on the 1-in-N figure (`Commands/CdCommand.Grade.cs:244-250`). The Pit Schedule note reads the Settings value "achieved grade note tolerance" (`ViewModels/PitScheduleViewModel.Data.cs:1891-1892`, default 10 in `Models/UserSettings.cs:670`) and compares the fall per metre (`Services/PitScheduleGradeNote.cs:94-98`). Change the Settings value to 5 and only the Pit Schedule follows it.
3. **Steps in AutoCAD.** `CD` between two pits about 10 m apart, Pipe grade "Set my own" 1 in 100, untick the work-it-out box, type levels 20.00 and 19.91 (about 1 in 111). Note whether the question appears. Then repeat with 20.00 and 19.89 (about 1 in 90).
4. **Right result.** Both places follow the one Settings value and the same sum.
5. **Test today.** `Modules/Drainage.Tests/Commands/GradeAutoCalcTests.cs` checks the fixed 10 per cent, so it locks the hard-coded value in.
6. **Smallest fix.** New Pipe calls the same comparison the schedule uses, with the Settings value.

### HUNT-C-06 (MEDIUM, R-00): levels typed in the Pit Schedule are rounded to 2 decimals in code; PIT writes them exactly as typed

1. **What the drafter sees.** Type 20.055 in an IL cell, Stop overriding: the plan reads 20.05 or 20.06, never 20.055. Type cover 21.5 in PIT: the plan reads "CL 21.5". Change it in the Pit Schedule: "CL 21.50". Three rules for one kind of number.
2. **Why (the code shows).** The schedule writes `"0.00"` for IL (`ViewModels/PitScheduleViewModel.Data.cs:1852`) and cover (`:1752`). CD's worked-out levels read the Settings value "calculated decimals" (`Commands/CdCommand.cs:499`, `Models/UserSettings.cs:604`). PIT writes the cover text as typed (`Services/PitAnnotationTextFormatter.cs:28-29`). Rounding a typed level also goes against Tim's ruling that a typed level is never moved (INT-059 item 23).
3. **I think.** 20.055 may round to 20.05 in the AutoCAD 2027 copy and 20.06 in the 2022-2024 copy, because the two .NET versions round that number differently. Not verified.
4. **Steps in AutoCAD.** `PITSCHEDULE`, pick a pit's IL (Inlet) cell, F2, type 20.055, Enter, right-click the row, Stop overriding, Close. Zoom to the IL text.
5. **Right result.** The typed figure is kept, or one Settings value decides the decimals everywhere, and the drafter is told if it was rounded.
6. **Test today.** `Modules/Drainage.Tests/Commands/C8ScheduleLevelWriteTests.cs` uses 2-decimal levels only.
7. **Smallest fix.** One level formatter that reads the Settings decimals, used by the schedule, PIT and Edit Pit.

### HUNT-C-07 (MEDIUM): the Pit Schedule skips the read-only check, so typed levels can be lost

1. **What the drafter sees.** A colleague has the job drawing open, so it opens read-only. PIT, CD and Edit Pit refuse: "[CE] PIT cannot run - drawing is read-only." The Pit Schedule lets the drafter type levels and Stop overriding, which writes IL text and the CHECK marker. Then `QSAVE` fails and the work is lost.
2. **Why (the code shows).** `Commands/PitScheduleCommand.cs:19-40` opens the window with no `DrawingSafetyService.CommandPreFlight` call. Nothing in the schedule view-model checks for read-only (searched for `IsReadOnly`; editing is gated only on Xref mode, `ViewModels/PitScheduleViewModel.cs:390`).
3. **Steps in AutoCAD.** Open a job copy with File > Open > Open Read-Only. `PITSCHEDULE`, type a level, Stop overriding, Close. Then `QSAVE`.
4. **Right result.** The window opens to read, the edit cells are greyed, and one line says "This drawing is read-only, so the schedule can be viewed but not changed."
5. **Test today.** None for read-only.
6. **Smallest fix.** Check read-only when PITSCHEDULE opens and open the window in view-only mode. Add the REFEDIT check from HUNT-C-01 there too.

### HUNT-C-08 (LOW): pit cover text takes whatever text style is current

1. **What the drafter sees.** Set an architect's text style current for a note, then place a pit. That pit's "CL 21.00" text uses the architect's font. Earlier pits use another font. Pipe labels always use Standard.
2. **Why (the code shows).** Cover text uses the drawing's current text style: `Commands/PitCommand.cs:730`, `Commands/PitEditCommand.cs:1795`, `Commands/PitEditCommand.Batch.cs:862`. Pipe labels use `Services/TextService.cs:1455` with the Standard style helper at `:1756-1772`.
3. **Steps in AutoCAD.** `STYLE`, make a new style with another font current. `PIT`, place a pit with cover text. `LIST` the cover text and read its style.
4. **Right result.** All CE pit text uses the same style, ideally a Settings value.
5. **Test today.** None.
6. **Smallest fix.** Use the same style helper as pipe labels in those three places.

### HUNT-C-09 (LOW, R-00): pit text sizes and offsets are fixed in code

1. **What the drafter sees.** Nothing different today. An office that wants a 200 cover text height or a 300 offset cannot set it.
2. **Why (the code shows).** Cover text height 180 (`Services/TextService.cs:27`). Cover corner offset 200, or 250 for a detention tank. These are written twice: `Commands/PitCommand.cs:27-28` and `Commands/PitEditCommand.cs:28-29`. SPS label heights 300 and 250 (`Commands/PitCommand.cs:30-31`). Settings has the matching idea for joint labels (`labelOffsetMm`, `Models/UserSettings.cs:1436`) but not for pits.
3. **Steps in AutoCAD.** None needed: the code is the evidence.
4. **Right result.** Settings values with today's numbers as defaults (R-00).
5. **Test today.** `Modules/Drainage.Tests/Commands/SpsLabelTests.cs` checks the fixed 300 and 250.
6. **Smallest fix.** Move the five numbers to Settings and read them in both commands.

### HUNT-C-10 (LOW): Edit Pit on a round pump pit (SPS) ignores the radius for its labels

1. **What the drafter sees.** `PITEDIT` an SPS and change the radius from 900 to 1500. The pipe ends move out to the new wall, but the label and cover text stay put, inside the bigger circle. A cover text placed at a new corner from Edit Pit also lands inside the circle.
2. **Why (the code shows).** The label step-out uses X and Y widths only (`Commands/PitEditCommand.cs:343-349`, `:1873-1893`). Pipe ends are re-snapped on a radius change (`:395-400`). The cover corner ignores the radius (`:2214-2242`), while PIT uses the diameter for an SPS (`Commands/PitCommand.cs:868-873`).
3. **Steps in AutoCAD.** Copy drawing with an SPS. `PITEDIT`, pick it, change the SPS radius 900 to 1500, Save. Look at the label and the cover text.
4. **Right result.** Both step out with the wall, as they do for a square pit.
5. **Test today.** None for the SPS radius.
6. **Smallest fix.** For an SPS, use the diameter as the width in the step-out and corner sums, as PIT does.

### HUNT-C-11 (LOW): SPS numbering can repeat a number

1. **What the drafter sees.** With SPS1 and SPS3 in the drawing (SPS2 was deleted), the next SPS is numbered SPS3 again. Two schedule rows read SPS3. A number typed in the window for an SPS is overwritten without a word.
2. **Why (the code shows).** The number is worked out from how many SPS pits there are, not from the numbers in use (`Commands/PitCommand.cs:955-956`, `:962-992`). It is set after the window closes (`:412-413`), so the window's "Pit number already used" check (`ViewModels/PitViewModel.cs:166-170`) never sees it.
3. **Steps in AutoCAD.** Copy drawing. Place three SPS pits, erase the middle one, place another SPS. Read its label.
4. **Right result.** The next free number (SPS2 or SPS4), never a repeat.
5. **Test today.** `SpsLabelTests` tests count-to-label only.
6. **Smallest fix.** Work out the next free SPS number from the existing numbers, before the window opens.

### HUNT-C-12 (LOW): Civil quietly puts back a CE layer's colour and linetype every time it draws

1. **What the drafter sees.** Set the pit layer to grey (colour 8) for an "existing" sheet. The next `PIT` turns it back to the CE colour, with no message. The same happens to pipe and text layers on `CD`.
2. **Why (the code shows).** `Services/LayerService.cs:439-451` recolours an existing, unlocked layer to the CE colour (or the CDLAYERMANAGER override) and resets its linetype. A locked layer is left alone (`:433-437`). The Structural copy of this is already parked as BUG-367 (S-9 finalizer item 1). This is the separate Civil code, not listed there.
3. **Steps in AutoCAD.** Copy drawing. `LAYER`, set the pit layer to colour 8. `PIT`, place a pit. Check the layer colour.
4. **Right result.** CE sets colours when it creates a layer, and leaves a drafter's later change alone (or says once what it changed).
5. **Test today.** None for an existing layer.
6. **Smallest fix.** Only set colour and linetype when the layer is new.

### HUNT-C-13 (LOW): with "draw the route first" off, a flat pipe gets the Uphill Pipe Warning box

1. **What the drafter sees.** With Settings "draw the route first" switched off, `CD` with the same level at both ends shows "Uphill Pipe Warning ... This pipe flows uphill or is level." Yes flips the levels (no change for a flat pipe). No converts it to a Rising Main. Cancel erases it. With the default (on), the box is skipped and the flat line shows, as DAY1 step 9 expects.
2. **Why (the code shows).** `Commands/CdCommand.cs:831` tests `secondInvert >= firstInvert`, so equal levels count as uphill. The draw-first route skips this check (`:816`).
3. **Steps in AutoCAD.** Settings, switch "draw the route first" off. `CD`, type 20.00 at both ends, Start Pipe, pick the route.
4. **Right result.** Flat goes to the "Pipe is essentially flat" line, not the uphill box.
5. **Test today.** None for equal levels in window-first mode.
6. **Smallest fix.** Use `>` (strictly uphill) on line 831.

### HUNT-C-14 (LOW): Esc at "Press Enter to reopen PIT" reopens the window

1. **What the drafter sees.** After Inspect Drawing, pressing Esc at "Press Enter to reopen PIT:" (or PITEDIT) opens the window again instead of stopping.
2. **Why (the code shows).** The answer is ignored: `Commands/PitCommand.cs:152-157`, `Commands/PitEditCommand.cs:282-287`.
3. **Steps in AutoCAD.** `PIT`, click a spot, press Inspect Drawing, then Esc at the prompt.
4. **Right result.** Esc ends the command: "PIT command cancelled."
5. **Test today.** None.
6. **Smallest fix.** If the answer is Cancel, stop with that line.

### HUNT-C-15 (LOW): CDCHECK leaves the item it jumped to selected

1. **What the drafter sees.** `CDCHECK`, Enter, type 3 at "Jump to item number", then Enter to finish. The pipe stays selected with grips. The next `ERASE` or `MOVE` acts on it at once, without asking what to select.
2. **Why (the code shows).** `Commands/SpineCheckCommand.cs:292`, `:306`, `:324` set the selection and nothing clears it when CDCHECK ends.
3. **Steps in AutoCAD.** Copy drawing. `CDCHECK`, Enter, `3`, Enter at Action, Enter to finish. Type `ERASE` and watch whether it asks to select objects. Then `U`.
4. **Right result.** The selection is cleared when CDCHECK finishes, or CDCHECK says the item is still selected.
5. **Test today.** None.
6. **Smallest fix.** Clear the selection when CDCHECK ends, unless the drafter chose Edit.

---

## What was NOT checked

1. **AutoCAD.** Nothing above was run. Every "I think" needs a Codex run on a copy.
2. **Day 1 steps not reached in depth.** CD's pit-wall snap and pipe-fit questions, and the crossing split after CD, were skimmed, not traced. The New Pipe window's own checks were not read.
3. **Undo and REDO.** Not re-reviewed. BUG-457 (second Opus review, 9 Oct) already covers the redo-safety paths.
4. **Structural and Manager.** Out of scope (the hunt_struc and hunt_mgr helpers own them).
5. **Tests.** Not run (no builds allowed). "Test today" means a search of `Modules/Drainage.Tests` at 1200744d.

## For the desk: draft IDs to carpark

HUNT-C-01 to HUNT-C-15 are draft IDs. They become BUG numbers only when the desk files them in `BUG_CARPARK.md`. This helper did not edit the carpark.
