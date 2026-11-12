# Re-review: PR 2064 `claude/trust-09-cancel-writes-nothing` (trust queue item 7: a cancelled command writes nothing)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 06:58 PC clock (written 06:52 to 06:58). **Head reviewed:** `9d44a9c0` (since `d64e9a72`: `ed190724` review fixes; `784bfd03` merge of PR 2073 `claude/bug-1456-record-own-drawing` at `1a28c3b3`; `9d44a9c0` a mark asked for after placing). Base of the PR: `claude/trust-proof-checks` (PR 2050). **Against:** the FIX FIRST list in `reviews\claude-trust-09-cancel-writes-nothing.md`. **Four states:** Built yes (lane: net48 and net10.0-windows, 0 errors; headless proof project compiles). Tested unit only (lane: 22,353 ran, 0 failed). The two core-console checks are written, not run. Installed no. Accepted no.

---

## FOR TIM

1. With its switch on (it ships off), a CE tool you close or Esc out of without accepting anything now leaves nothing behind for your next command: the "Civil" mark is dropped on Esc too, and a real change CE's hidden update made is written inside the tool that made it, not in your next command's Undo step.
2. The fix for the Help and Settings mix-up (BUG-1456) is no longer behind this switch; it comes in from its own change (PR 2073), unchanged.
3. Nothing here has run in AutoCAD yet, including the two new command-line checks.

**Verdict: GO** for the core-console checks first, then the robot on copies with the switch on and off. One small new item listed.

---

## The four items left from the last review

1. **Esc leaving an owed Civil mark that the next command writes: FIXED.** The cancelled and failed handlers now drop an owed mark before anything else runs (`Modules\Drainage\Services\LinkService.Reactors.cs` 1434, 1443), and the ordinary end drops it whatever the switch says (2088-2093). Dropping is memory only (`ProjectDataService.CancelWritesNothing.cs` 275). A mark asked for after the tool has placed something (CDTG, CDSL, CDWT with PR 2055) is written then, not owed (`Rules\RecordWriteRule.cs` 67; `CancelWritesNothing.cs` 150-177, 201): CE notes AutoCAD's next free object number as each command starts (`Reactors.cs` 1684) and compares. The owed mark is written only inside the record's own write, so it can only go into the drawing the record belongs to (`CancelWritesNothing.cs` 228-234; PR 2073's owner check runs just before that write).
2. **A real update after Esc landing in the next command's Undo step: FIXED as asked.** When the update ends, a save it asked for is dropped if nothing changed, otherwise written there by the installed "write now or wait" rule (`CancelWritesNothing.cs` 100-135, `Persistence.cs` 392-393). So only the changed-nothing case differs from the installed build. The one remaining wait (less than 350 ms since the last write, or AutoCAD's lock backoff) is the installed build's own, same as today. A record kept for a drawing and brought back on attach is written at once again (`ProjectDataService.Mutations.cs` 188-199).
3. **A proof that never touches Esc, a second drawing or a positive case: PARTLY FIXED; the rest is the robot's.**
   1. Esc: TRUST-CANCEL-02 hands AutoCAD's "command cancelled" notice to CE's own cancel handler (`Drainage.HeadlessProof\TrustChecks.cs` 385-467), on a drawing whose Civil mark was removed first, then draws a line and ends that command; its faulty version (no cancel notice) must write the mark and be noticed. If AutoCAD will not let the check build the notice it says BLOCKED, not PASS (407).
   2. Second drawing: TRUST-CANCEL-01 makes CE's record "another drawing's" first, so the attach really reads this drawing's record in (309-324). The other drawing is a database in memory, not an open drawing (the same limit as PR 2073's check).
   3. Positive case: a real change (a pipe's ends renamed through CE's own call) must be written at the command's end (331-343). Not checked: that one U takes it back, and the "update really changed something, then Esc" path (unit level only: an IL check that the settle routine performs the write, with a broken twin).
   4. Both checks are written, not run.
4. **Wording that overclaims: FIXED.** The PR text now says "if CE's update found nothing new", says what it does not promise (the hidden update in PIT and Edit Pit before their windows), and lists what is not covered (Esc in a real command, one U, a cancelled preview).

## Does it sit cleanly on 2073: yes

1. 2073 is merged at its reviewed head `1a28c3b3`. Its own five files are byte-identical at `9d44a9c0` (`RecordOwnerRule.cs`, `ProjectDataService.RecordOwner.cs`, `LinkService.cs`, `Bug1456RecordOwnDrawingTests.cs`, `CrossDrawingChecks.cs`).
2. `ProjectDataService.Persistence.cs` keeps all three of 2073's checks; 2064's additions sit around them (the housekeeping return before the lock writes nothing; the mark goes in inside the checked write).
3. The merge's only extra change is in `CancelWritesNothingTests.cs`: the listed-commands test now expects 14 names (Help and CD Settings off) and checks none of 2073's "never write at their end" commands is on the list. That is the right resolution, not a weakening.
4. For whoever merges: PR 2064's diff on GitHub now carries 2073's changes too; 2073 should go first.

## New, small

1. **A transparent command in the middle of a CE tool upsets the mark (switch on only).** `NoteCommandStarted` runs at every command start, including a ZOOM or PAN started from the navigation bar or typed with an apostrophe while a CE tool is waiting for a pick (`Reactors.cs` 1684, before the outer-or-nested test at 1691-1692). It resets the "has this command already added something" mark to the zoom's start. And the zoom's own end reaches the ordinary end routine, whose `finally` drops any owed mark (2088-2093; ZOOM and PAN are not display-refresh commands, 2209-2215). So in a new drawing, a zoom during the first CE tool can lose its Civil mark. Effect is mild (a drawing whose record holds pits or pipes counts as Civil anyway), but a tool that places nothing into the record (a spot level) can leave the drawing unmarked. Fix: note the start and drop the mark only for the outer command (the code at 1691-1692 already tells outer from nested).

## Still true from before

1. Switch off = the installed build plus 2073, by reading: no mark is ever owed, the update compare and the held save do nothing, the attach saves as before; the new start note reads one number and writes nothing.
2. No accepted change I followed is lost.

## What I did not check

1. Nothing run: no build, no tests, no core console, no AutoCAD.
2. The IL-level unit tests beyond their names and the lines quoted.
3. Every branch of CDMA, CDTAG, CDLPDRESET and the pipe override commands (as before).
4. A cancelled preview counting as "the command added something" (the PR lists it as not checked).
5. `PENDING_TESTS.md` queue item 7 case 4 still describes the switch-off comparison as showing the fault; on this branch 2073 stops it with the switch off too (the installed build still shows it). Case 14 refers to CDTG, CDSL, CDWT "when merged" (PR 2055).
