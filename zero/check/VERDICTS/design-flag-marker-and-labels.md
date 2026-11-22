# Answers: design\FLAG_MARKER.md (b2a3722) and design\LABELS.md (3f193e4)

Written Sun 22 Nov 2026, about 3:05 pm. Both pages were read by the check room alone, by reading only. The verdict words follow D-460.

## 1. design\FLAG_MARKER.md at b2a3722: BUILD FROM IT WITH FOLLOW-UPS

1. **What the page does:** it maps all 50 accepted cases (31 methods, `Stage1FlagMarkerTests.cs` at 5073aed) to 13 numbered rules. It states what the drafter sees in each, and the ruling for each.
2. **The behaviour is right, rule by rule:**
   - **The marker itself:** one amber triangle for "Needs a look" or "Wrong", none for grey alone, its words on hover and in the window, and cleared when the last fault is fixed.
   - **Placement:** at office settings, its size and gap equal one text height, measured clear of the actual label, with a fixed order of spots.
   - **Layers:** it sits on CE NO PLOT in grey 8, with the marker entity amber 40.
   - **Protected content (D-348, D-422):** on a locked layer, the edit saves, no marker is drawn, and the fault and layer are named. On a hidden layer, the marker is drawn but stays hidden, and the command says so.
   - **Editing:** markers move, copy and erase with their owners, in one Undo.
   - **Pit numbers:** they are read through the ONE number reader. "P4", "p4", " P4 " and "4" are the same.
3. **The owed probes are right:**
   - the locked D-422 row run as a target;
   - unused values (a 17.50 m loose pipe, " p27b ");
   - the real `PipeCommands.Say` output boundary;
   - the settings store per drawing (size, gap and layer changed one at a time, with a second drawing on office values).

   The pre-flight items follow D-459, with zero restatements planned and a ceiling of ten.
4. **Follow-up (E):** the "Build dependencies" section describes main 03119b1, which lacks the Pit reader. Main d6f89d7 now has `PitTool.DrawingNumber`, `ReadBlockAttribute` and `PitNumber.Read`, so the build cuts from d6f89d7 and reuses them. Only the WAITING numbered-pipe case needs the pipe run.

## 2. design\LABELS.md at 3f193e4: BUILD FROM IT WITH FOLLOW-UPS

1. **What the page does:** it maps all 127 accepted methods (202 cases) from main 1b26285 to 14 numbered rules for the existing Pipe command. One shared placement routine serves pit and pipe text.
2. **Figures checked by hand:**
   - **A run of inverts:** three 10 m pipes at 1 in 100 with a 0.020 m drop give 12.60/12.50, 12.48/12.38 and 12.36/12.26.
   - **A cover:** 5.755 prints CL 5.76.
   - **A grade:** a 0.20 m fall over 18.92 m works out at 1 in 94.6, printed "1 IN 95".
   - **A grade check:** a grade of 200.04 against 200.00 warns (D-380).
3. **Agreement with Tim's own answers:**
   - **Reversal:** a two-typed-end reversal keeps both ends, turns the arrow and shows red "Wrong: runs uphill", as D-406 item 3 says.
   - **A held length:** after a stretch, the typed length is kept with a marker (D-410).
   - **"MIN.":** it goes only when both ends are typed (D-383 item 9).
   - **Units:** cm and m are refused before the first click (D-403).
4. **The owed probes are right:** the kind picker (verdict section 27), the settings store with unused values in two drawings, one number route (with a planted Window-form writer), selection safety between two pipes sharing pits, and host observations owed on test copies. The pre-flight follows D-459, with zero restatements.
5. **Follow-ups (E):**
   - **The base:** the build needs `RunRoute`, `PipeNumberSequence`, `PipeRunEdits` and `PipeRunNative`, which exist only on team/pipe-run-build. So it is cut after the pipe run merges, or from that branch, and merges after it.
   - **Two cut-off lines:** two lines in the page text are cut off in its own rendering ("Cut the build from main after the required", "Stop befor"). The writer should complete them.
