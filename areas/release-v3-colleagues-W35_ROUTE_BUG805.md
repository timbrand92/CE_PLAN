# W35: the exact route that makes the #805 grade CHECK marker appear

Written Thu 8 Oct 13:35 Melbourne by Team build/04 (run 46, read-only, no code change). Read from PR #805 head 00020c33 (inside C-24 / Civil 3.0.38). Files read: PitScheduleViewModel.Data.cs (SyncInvert, ShowGradeMarkerOnPlan, PreserveOverrideEditsToPlanOnDemote, OnRowPropertyChanged, TrackOverriddenField), PitScheduleViewModel.cs (SyncLinkedOverrideFlag, ConfigureScheduleWorkflow), PitScheduleWorkflowState.cs, GradeNoteMarker.cs, PitScheduleGradeNote.cs, PitSchedulePlanLevels.cs. NOT run in AutoCAD.

## 1. The answer first

**Typing in the IL cell does not write to the drawing. It only makes a pending override. That is by design. The level and the red marker are written when you STOP OVERRIDING the row.**

1. **Why Codex saw nothing:** any edit in a linked row's IL, Cover, Depth or diameter cell makes the row an override at once (status "Override enabled for linked row."). The code that writes a typed level to the pipe (SyncInvert) is skipped for override rows. The typed value waits as a proposal for Review, then Update.
2. **The route that writes the level AND the marker:** Stop overriding. It pushes each typed IL cell through SyncInvert, which writes the typed level to the pipe, rewrites its IL label, then draws the marker.
3. **Continue to Place / update is NOT part of this route.** It is only for placing or updating the table on the sheet. It writes no marker and is not needed. The Drawing check count does not need fixing first.

## 2. The click-by-click route (AutoCAD words)

1. **Open** the drawing with the held-grade pipe. The pipe label must show a held grade (for example 100 DIA. UPVC PIPE AT 1 IN 100). A pipe that takes its grade from its levels never gets a marker.
2. **Open the Pit Schedule** (CDPITSCHEDULE), Rows tab.
3. **Pick the row and cell** by which end you change:
   1. **Downstream pit** (for P10 to P9 that is the P9 row): the **IL (Inlet)** cell. The pipe is the inlet pipe at P9.
   2. **Upstream pit** (the P10 row): the **IL (Outlet)** cell. The pipe is the outlet pipe at P10.
4. **Type a level** that makes the fall differ from the held grade by MORE than the tolerance (Settings, achieved-grade note tolerance, default 10 percent). Example: a 15 m pipe held 1 in 100 needs 0.150 m fall; leave the upstream end at 20.00 and type 19.91 at the downstream end (fall 0.09 m, about 1 in 167). Typing 19.86 (about 1 in 107) is inside 10 percent and draws NO marker.
5. **Press Enter.** Expect the status line "Override enabled for linked row." The plan does not change yet.
6. **Right-click the row, choose Stop overriding.** Expect together: the pipe end takes the typed level, the IL text on the plan changes, the red marker appears under the pipe label, and the command line prints the "[CE] ... the label grade is 1 IN 100 but its levels now give about 1 IN ..." line.
7. **Look at the plan.** The marker is red text on the layer **CE GRADE CHECK** (non-plotting), 1.8 label text heights below the pipe's own label, along the same slope. Zoom to the pipe.

**Edit Pipe (CDEDIT / PIPEEDIT) does not draw the marker.** Its only link is the removal of an old marker when the levels change (ScheduleLinkService.cs line 510, RemoveStale). Use Edit Pipe only to prove the marker goes away.

## 3. Exact sentence texts Codex should see

1. **Marker on the plan:** `CHECK: LABEL GRADE 1 IN 100, LEVELS GIVE ABOUT 1 IN 167` (the N comes from the two levels and the drawn length, so it differs per pipe).
2. **Other two forms:** `CHECK: LABEL GRADE 1 IN 100, LEVELS GIVE NO FALL` (ends within 0.5 mm of each other) and `CHECK: LABEL GRADE 1 IN 100, LEVELS RUN UPHILL`.
3. **Pit Schedule WARNING column, both pit rows of the pipe:** the same words without the CHECK: prefix (upstream row says OUTLET, downstream row says INLET).
4. **Command line:** `[CE] <pipe name>: the label grade is 1 IN 100 but its levels now give about 1 IN 167. Only the end at P9 changed; the far end was not moved. Check the grade, or set it in Edit Pipe (CDEDIT).`
5. **Window status after the typing:** `Override enabled for linked row.`
6. **Locked marker layer:** one line from the shared locked-layer message, no marker, the level is still written.
7. **REFEDIT open:** `[CE] The grade warning marker for <pipe> was not drawn: a reference edit (REFEDIT) is open, and CE will not put a marker into a block or Xref being edited. Close the reference edit; the marker comes with the next level you type.`
8. **No marker and no line at all** when: the Settings switch for the plan marker is off; the pipe has no main label; the pipe is not held grade; the fall is within the tolerance; the drawing has mixed units (length not known); or the row is an Xref row.

## 4. The route to U, 12 s, REDO

1. Do section 2 steps 1 to 7. Confirm the marker is visible.
2. **Close the Pit Schedule window.**
3. **Type U once.** Expect the level to go back, and the marker with it if the marker and the level share one Undo. That grouping is NOT proven headless (the PR says so): it is exactly what this test proves. If the marker stays after U, report that as a finding.
4. **Wait 12 seconds.** In the wait do REGEN and one pick on any object.
5. **Type REDO.** Expect the level and marker back together. Head 00020c33 defers the stale-marker clean-up while an undo or redo is open (RedoWindowGuard), so nothing is written between the U and the REDO. A marker made stale by the Undo is only cleaned at the next level change or Pit Schedule refresh after the redo window has closed.
6. **Do not** open the Pit Schedule between the U and the REDO; its refresh writes and would end the redo.

## 5. Is the route reachable on a normal drawing?

**Yes.** It needs no clean drawing, only a linked row with a held-grade pipe and a fall more than 10 percent off. Reasons the marker can still be absent on a real drawing, most likely first:
1. The pipe's grade is not held (taken from levels).
2. The typed level is within 10 percent of the held grade.
3. Mixed units (UNITS and pit size disagree).
4. The pipe has no main label.
5. The row is an Xref row.

**Clean drawing if you want one:** blank drawing, UNITS to match the pit sizes, two pits placed with CD pit (P1, P2) 15 m apart, join with CD pipe, set Edit Pipe grade 1 in 100 and Save, give the upstream end IL 20.00. Then run section 2.

## 6. Why typing the Pit Schedule IL (Inlet) cell writes nothing

**By design.** Rule in the code (TrackOverriddenField comment, BUG-193): every typed cell except PIT SIZE becomes a pending override, resolved through Review then Update, or pushed by Stop overriding. Only PIT SIZE edits the real pit at once. The straight grid-to-plan IL write is only reached for a row that is not an override, which a typed IL on a linked row never is. So what Codex saw (pending override, plan unchanged, no marker) is the intended behaviour, not a fault.

**Two things for Tim, nothing changed here:**
1. **A design question for Tim:** a drafter who types a level and presses Enter sees nothing on the plan, and the marker only comes after Stop overriding. If Tim wants the marker on Enter, that is a design change and his call.
2. **The status line** says "Override enabled for linked row." but not how to write the level. A small window change for Codex, suggested wording: "Typed level is waiting. Right-click the row and choose Stop overriding to write it to the drawing."

## 7. Why Continue to Place / update was disabled

Rule (PitScheduleWorkflowState.cs line 37): output rows selected AND no blocking schedule difference. Footer sentences: "No output rows selected. Choose a schedule set and system that contains rows." or "Update blocked — review the listed schedule issue." The "N data issues" headline is separate and does not by itself disable the button. I cannot tell from code which case Codex had; the footer sentence says. It does not matter for the marker route above.
