# Review: PR 2067 `claude/trust04-b1300-lpd-move-clears` (BUG-1300: moving the LPD takes the LPD tag off the earlier pipe)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:40 PC clock. Read only. **Head reviewed:** `2d825913`, one own commit on installed Civil `cf059dcf` (ancestor, checked; base `claude/rel-20261108a`). **Read against:** the BUG-1300 carpark entry; CDLPD and CDLPDRESET in the installed code at `C:\CE_WORK\scratch\audit_civil`; every place that writes the LPD tag. **Four states:** Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: 497 ran, 495 passed, 2 skipped; broken twin 3 of 9 fail). Installed no. Accepted no.

---

## FOR TIM

1. When you move the LPD with CDLPD to another pipe end, the pipe end it used to sit at now loses the "LPD" CE wrote there, so only one pipe reads as ending at the LPD, and the command line says "LPD moved: pipe ... no longer ends at the LPD."
2. It leaves alone an end you have since set to a real pit, the other end of the pipe, and the case where your LPD setting is a real pit number.
3. One U still takes back the whole CDLPD. Not yet seen in AutoCAD; the robot's check is the PR's two-pipe case.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Findings

1. **Fixes what the bug says (by reading).** CDLPD reads the LPD record from before this run inside its transaction (`Commands\LpdCommand.cs`, branch 196-202), binds CE's record to this drawing (237), then clears the earlier end (239, `ClearLpdTagFromEarlierPipe` 25-42) before it tags the picked pipe (240-253). The earlier pipe and the LPD record both come from this drawing, so BUG-1456 is not touched.
2. **The rule** (`Rules\LpdMoveRule.cs`, new) changes the earlier pipe only when: there was an earlier LPD, the end index is 0 or 1, it is not the same end of the same pipe, the tag is not a real pit number in the job, and that end still holds the tag. Only that end is blanked. CDLPD writes the tag only into a blank or "-" end (branch 246-249), so blank is what that end was before, with one exception (Small item 5).
3. **Only CDLPD writes the tag** (searched every use of the LPD identifier setting and of `SetLpdData`: one writer, `LpdCommand.cs`). CDDESIGN's Confirm LPD and others read it.
4. **Lost work: none found.** An end the drafter has typed a real pit into is left alone (rule 38-47). Moving the LPD to the other end of the same pipe clears the end it left, then tags the new end from the freshly read pipe (240-244).
5. **One U.** Both changes go through `UpdatePipeEndpointsByHandle`, the same call the picked pipe already used, inside the one CDLPD command (CDLPD is on CE's end-of-command write list, so the record is written in the same Undo step; see the PR 2064 review).
6. **Words:** "LPD moved: pipe P3 no longer ends at the LPD." Plain; the pipe is named by CE's pipe name (`PipeData.Id`).
7. **Tests: the rule runs for real; the plumbing does not.** Nine cases call the same `LpdMoveRule.TryClearEarlierEnd` the command calls (`Drainage.Tests\Rules\Trust04B1300LpdMoveTests.cs`); the lane's broken twin failed 3 of 9. The order "clear before tag" is a text search. `ClearLpdTagFromEarlierPipe` (the pit-number check, the record write, the line) never runs in a test.

## Small (not blocking the robot)

1. **Location is not looked at.** If the old end and the new end are at the same point (two pipes ending at the LPD, or a pick that lands on the next pipe's start at a pipe-to-pipe joint), the old pipe loses its tag although it still ends there. Rare; one robot case, or compare the two end points before clearing.
2. **A tag written under an older setting stays.** If the LPD identifier in Settings was changed between the two CDLPD runs, the earlier end still holds the old word. Rare.
3. **CE's record changes are not rolled back if CDLPD then fails** (the catch at 282-286 drops the drawing transaction but not the in-memory record). Same as the picked pipe's existing write; not new.
4. **Merge note:** PRs 2058 and 2061 also change `LpdCommand.cs`; expect a conflict.
5. **An end that held "-" before CDLPD comes back blank, not "-".** The step 1 opening line (PR 2041) counts a "-" end as linked and a blank end as not linked, so after a move such an end would show as not linked. Rare; remembering the earlier value, or writing "-" back when the end was "-", closes it.

## For the controller (outside this bug)

1. **CDLPDRESET leaves the tag behind too.** "Clear current LPD and label?" clears the LPD record and label (`LpdCommand.cs` installed 556-563) but not the "LPD" in the pipe's From or To, so after a reset a pipe still reads as ending at an LPD that no longer exists. Same family as BUG-1300; not in this PR. Worth a carpark line if none exists.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: CDEDIT on the earlier pipe after a move, the Pit Schedule's reading of the blank end, one U.
3. What a pipe with no CE name prints in the new line.
4. No client name, street, suburb or job number in the diff (checked).
