# Re-review: PR 2064 `claude/trust-09-cancel-writes-nothing`, head `dde7825e` (since `9d44a9c0`)

**Reviewer:** lane trust-review (sixteenth run). **Written:** Fri 13 Nov 2026, 11:49 PC clock. **Diff read:** `9d44a9c0..dde7825e`, one commit (`dde7825e`), six files. Draft, auto-merge off. Read only.

---

# FOR TIM

1. **The one small item from the last review is fixed.** Typing a ZOOM or PAN in the middle of a CE tool no longer makes CE forget to mark a new drawing as a Civil drawing.
2. **Nothing else changed,** and nothing in it changes what you see. It is behind its switch, which is off by default.
3. **Not for your PC today.** It is not part of State A.

**Verdict: GO holds** (core-console checks CEPROOFTRUSTCANCEL and CEPROOFTRUSTESC first, then the robot on copies, switch on and off).

---

# Findings (file and line at `dde7825e`)

1. **What changed:**
   - **A nesting counter** (`Rules/RecordWriteRule.cs:3-40`, `RunningCommandNesting`) tells the outer command's start and end from those of a command started inside it.
   - **Start:** the command-start hook counts a start as the outer one only when AutoCAD lists no other running command, using the same running-command list BUG-254 already reads (`LinkService.Reactors.cs:1687-1695`). If the list cannot be read, the start is taken as outer, as before (`RecordWriteRule.cs:105`).
   - **End:** every end route (ordinary `:547`, cancelled `:1433`, failed `:1445`) calls `NoteCommandEnding` before the owed mark is dropped or written. A nested end neither drops nor writes the owed mark (`ProjectDataService.CancelWritesNothing.cs:263-265`, `:296-300`).
2. **New and right: a mark owed is dropped at the next outer start** (`CancelWritesNothing.cs:166-168`). So a missed end notice can never leave a mark to be written by a later command.
3. **The safe direction when counts are missed:**
   - A missed nested start makes its end act as before (the mark is dropped; that is the Civil mark only, not drafting work).
   - A missed nested end makes the outer end look nested (mark neither written nor dropped), and the next outer start drops it.
   - Either way the worst case is a new drawing without its Civil mark, never a write.
4. **The core-console check now stands on Esc alone:** the LINE's own start was removed on purpose (`TrustChecks.cs:428-429`), because a command start now also drops an owed mark and would hide a faulty Esc path. Honest.
5. **Tests:** 87 lines in `CancelWritesNothingTests.cs` (counter rules, outer-start rule, drop-at-end rule). The hook wiring is still checked by text search only.
6. **Switch OFF:** unchanged by reading. The counter only feeds the owed-mark rule, which applies only with `trust.cancelledCommandWritesNothing` on.

# What I did not check

1. No build, no test run, no core console.
2. A CE tool that runs another CE command inside itself (counted as nested by design; not traced tool by tool).
3. The merge of this branch with 2083 or 2089 (2064 holds 2073 only, at `784bfd03`).
