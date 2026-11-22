# Verdict: team/pipe-run-build at 6ae5d08 (the pipe run, from PIPE_RUN.md 3d2ddd1; cut from team/pit-window 8c4dc62; merges only after the Pit window, D-449)

**Verdict: HOLD (first round). Both halves hold it.** Written Sun 22 Nov 2026, about 2:54 am. Both halves ran on Codex with every outside-input variable unset, and with TEMP inside their own folders:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\prb_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `prb_adv_REPORT.md`, with proofs in `prb_adv_proofs\`.

The honest half's whole build stopped at package restore offline. The build room reports CeCivil.Acad compiling with 0 errors.

## Blockers

1. **The branch invert can be wrong or stale** (both halves).
   - **A stale plotted figure:** change the main's upstream invert from 10.00 to 10.25. The worked branch reopens at 10.20, but its plan text still plots 9.95.
   - **A typed level replaced:** a typed 9.97 on the branch shows 10.20 after the main changes; the tick writes a measured value into the level.
   - **The meeting hold unread:** the station calculation (`PipeTool.cs:396-409`) reads only the main's end levels, length and grade, never a hold at the meeting (`JoinStore.cs:70-77`). So the design's held 9.920 at 10.540 m can come out as 9.8946, printed 9.89.
   - **Rulings:** D-413 items 5, 7 and 13; PIPE_RUN sections 1.5 and 2.1. The accepted list's saved-drawing fixture for 9.920 is still owed.
2. **BREAK writes a wrong invert** (honest half). On a 10 m pipe with a held 12.000 far end, a BREAK between 4 and 6 m keeps the hold on the far half and ALSO writes it at the new 4 m cut end (`PipeRunNative.cs:112-134`). The accepted BREAK test counts pipes but not levels (`Stage1PipeRunEntryTests.cs:345`).
3. **A refused native edit damages ordinary linework** (both halves).
   - **A rounded FILLET:** the refused fillet restores the managed pipe, but leaves an ordinary polyline shortened.
   - **A JOIN:** a JOIN refused by a locked label layer loses an adjoining ordinary polyline altogether.
   - **The cause:** the native hook records and restores only objects that carry a managed note (`Commands.cs:264-269, 333-341, 426-427`). D-348, PIPE_RUN section 1.7: "Any write failure aborts it all".
4. **Run writes to an off or frozen pipe** (honest half). A grade change from Run without a resize or reversal skips the proposal, and the old Run writer checks lock, xref and reference edit but not off or frozen layers (`PipeRunEdits.cs:103-107, 133`; `RunTool.cs:522-538`; `PipeRun.cs:408-418`). Rulings: D-348, D-439.
5. **Splitting a pipe loses or misjoins data** (adversarial half).
   - **A lost drop:** a typed 0.130 m drop on the far inlet is lost, because the hold is saved under the new half's temporary identity (`PipeRunEdits.cs:57`, `PipeRun.cs:494`).
   - **A branch on the wrong half:** a branch meeting at 8 m on a 10 m main split at 5 m stays joined to the upstream half, which ends before it (`PipeRunEdits.cs:90, 183, 214`).
   - **Rulings:** D-377, D-413, PIPE_RUN section 1.8.
6. **Reversing a run with both ends held is REFUSED, against a ruling** (adversarial half). D-406 item 3 already decides it: "the arrow turns, a red 'Wrong: runs uphill' shows, his levels never change". D-413 item 8 applies reversal to every pipe in the run. File: `PipeRunEdits.cs:116`.
7. **The Pit window can save a split the drafter did not see** (adversarial half). The window builds one proposal to show and another on OK, so a 1,500 mm bend put on the pipe between the preview and confirmation was saved. Run also calls the planner only after the window closes (`PitCommand.cs:93, 132, 156`; `RunCommand.cs:71`). This is the list's binding probe (one PlanRun proposal shown, checked and saved), built the opposite way.

## For the control room
1. **A held length on a split:** the tool refuses splitting a pipe with a held length. Whether, and how, a held length is apportioned needs a ruling (the honest half). Reversal is already ruled by D-406 item 3; see blocker 6.
2. **The Pipe window cut-off:** at both sizes it is the D-449 design question (on Tim's Monday list). It is not counted here.

**Next:** round 1 of 2. Each blocker comes over as a failing test first.

**Ruled since (D-453, control room, 2:56 am):**
1. **Both ends held:** reversing a run with both ends held follows D-406 item 3 (Tim's TR-153). The arrow turns, a red "Wrong: runs uphill" shows, and the levels never change. The refusal is a fault to fix (blocker 6 stands).
2. **A held (typed) length on a split (DRAFT, on Tim's Monday list):**
   - **The split goes ahead:** not refused, and the length is NOT apportioned.
   - **Each piece:** it takes its drawn length as its length used, carries the amber marker, and shows that the typed length was for the whole (for example "Typed 6.50 m was for the whole pipe; this piece is 3.10 m as drawn").
   - **Before OK:** this is said in the window, in the same Undo; levels and grades follow the pieces' lengths used, shown and never silent.
   - **One reader:** it still gives the one length used (D-410).

---

# Fix round 1, 927f126: findings sent forward as tests (D-462)

Sun 22 Nov 2026, about 3:21 pm. Both halves ran on Codex (prb2_honest, prb2_adv); neither report contains a login name. The base control is clean: every pass of 8c4dc62 and 6ae5d08 passes, and the whole solution builds. All seven first-round findings are closed.
1. **A, reversal (both halves):** the branch meeting is kept from the old start, so it prints IL 9.92 where 9.98 is required. Sent as a test.
2. **D, against D-422 (with D-453 item 2):** a locked CE NO PLOT refuses a typed-length split. Sent as a test.
3. **A, split (adversarial half):** the branch's own far-end join stays on the near half. Sent as a test.
4. **A, BREAK (adversarial half):** the typed length is copied into both pieces (13.00 m used in total), and the cut-end invert is 9.935 where 9.980 is required. Sent as a test.
5. **E:** the unreachable Refuse and Apportion split code goes onto FOLLOWUPS.md.
