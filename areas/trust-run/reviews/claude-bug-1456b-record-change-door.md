# Review: PR 2083 `claude/bug-1456b-record-change-door` (BUG-1456, the change door: a change to CE's record is refused when the record is another drawing's)

**Reviewer:** lane trust-review (fourteenth run), strict review as asked (no switch; a real change in the right drawing never refused; a deliberately faulty version fails). **Written:** 2026-11-13 07:32 PC clock. **Head reviewed:** `522e5502` (one commit on `1a28c3b3`, the head of PR 2073 reviewed GO at 05:53; 2073's own three doors in `ProjectDataService.RecordOwner.cs` and `KeptRecords.cs` untouched). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **This closes the gap the cure (2073) left:** if CE is still holding job A's pits and pipes and a tool in job B tries to add, edit or clear them without first picking up B's own, CE now refuses the change instead of quietly changing job A's list. No switch.
2. **Your ordinary work in one drawing is never refused, by reading:** every path I followed (the drawing tools, the erase clean-up at the end of a command, the Inspector, the X-Civil import) either picks up the drawing's own record first or runs in that drawing. The one exception the builder names (a window left open on job A while job B is in front) I could not make happen with any CE window: the Pit Schedule and the Hub windows are modal, the Inspector follows the drawing in front.
3. **A refusal is written only to CE's log for now.** That should never happen in ordinary work, so a line on the command line too would cost nothing and would catch a case nobody foresaw. That is your decision (listed by the builder); I would say yes.

**Verdict: GO** for the core-console checks first (`CEPROOFCROSSCHANGE` and `CEPROOFCROSSDRAWING`), then the robot on copies. Two small items for the robot cases and one door left open for the controller (below).

---

# Findings (file and line at `522e5502` unless stated)

1. **No switch: confirmed.** No new setting; the check runs whenever AutoCAD is present (`ProjectDataService.RecordChangeDoor.cs:27`). Worth knowing: "the record's drawing has closed" counts only while BUG-1225's own switch `reopenedDrawingLoadsItsOwnRecord` is ON (line 46; default ON, `UserSettings.cs:725`). With it OFF, a closed drawing's record is judged by a memory address a newly opened drawing can reuse. Same as 2073, not new here.
2. **The rule (`Rules/RecordOwnerRule.cs:71-90`), case by case.**
   1. Nothing attached yet: allowed. Cannot read the drawing in front: allowed. Both "never refuse on a guess"; 2073's save check still keeps the record out of any other drawing.
   2. A drawing named by the caller: refused only if the record is not that drawing's (or its drawing closed). The record's own drawing named: never refused, whatever is in front.
   3. No drawing named: the drawing in front decides, unless a command is running in the record's own drawing (the X-Civil import, which opens its source drawing in front: installed `XcivilImportService.Pipeline.cs:775`). Same-drawing test compares the native drawing, not the wrapper (`LinkService.PipeAttachmentGrip.cs:485-499`), so a fresh wrapper of the same drawing is never "another drawing".
3. **A real change in the right drawing is never refused, by reading.**
   1. Drawing tools attach the record to their drawing before they change it (2073 review; HubCommands 134-135 and 187-188, Inspector 566 and 1588 call `SetDrawingPath` for the drawing in front first).
   2. The erase clean-up (`LinkService.Utilities.cs:3456-3490`, installed) runs from `OnCommandEnded` in the drawing whose command ended (`LinkService.Reactors.cs:943`, `1129`), which is the drawing in front.
   3. The X-Civil import: allowed by the running-command rule, if `Document.CommandInProgress` reads the import's name in the target drawing while the source is in front. Not proven: PENDING cases 4 and 5.
   4. The named exception (a window on job A, job B in front, an edit typed in the window): of the modeless CE windows (Inspector, the two check palettes, the CE Assistant, Help, What's New), the Inspector attaches the drawing in front and the check palettes act by running a command in the drawing in front. The Pit Schedule (`PitScheduleCommand.cs:47-48`, `ShowDialog`) and the Hub (`CivilHubService.cs:37`) are modal. I found no CE window that reaches this case.
4. **A deliberately faulty version fails: confirmed by reading the tests.**
   1. `Bug1456RecordChangeDoorTests.TwoDeliberatelyFaultyVersions_...`: the installed build (never refuses) is wrong on all four refused cases; "go by the drawing in front alone" is wrong on exactly the X-Civil case.
   2. On the compiled plugin: every public routine of the record service that reaches a save (`SaveProjectData`, `RequestSaveIfReady`, `RequestSaveCore`, directly or through its private helpers and the compiler's helper types) must call the check as its first call; the eight let through are named with reasons and each must really be a saver; at least 60 routines found (guard against an empty scan); four broken copies (check replaced by "not refused" in the compiled code) are each caught.
   3. Core-console check `BUG-1456-CROSS-02` (`Drainage.HeadlessProof/CrossDrawingChecks.cs`): with the record tied to another drawing, add a pit, change a pipe's ends, clear everything; nothing may change; a change made with no check must be noticed, or the check fails itself; blocked on a build without the door. Written, not run.
5. **Door left open (for the controller; the PR lists it).** Code outside the record service that edits a pit or pipe object it took from the record and then asks for a save: 36 call sites ask for a save from outside the service (Pit Schedule view models 9, LinkService files 15 or so, Edit Pit 2, X-Civil 2, others). Every one I opened runs inside a command, or at a command's end, after the record is attached to that drawing, so the door is reachable only by a tool that changes the record before attaching, which is exactly what CDHELP and CDS did (closed by 2073). Not traced for all 36. A follow-up guard pinning "every command that edits a record object attaches first" (by the call graph, as here) would close it.
6. **Small: PENDING_TESTS case 6 cannot be run as written.** "The Pit Schedule window left open on job A, job B brought to the front": the Pit Schedule window is modal, so job B cannot be brought forward while it is open. Use the Inspector palette (edit a pit's number there with job B in front) or the "What CE Found" palette, or record the case as not reachable.
7. **Small: the refused case answers like "nothing to change".** For example `AddPit` returns quietly (`ProjectDataService.Mutations.cs:358`), so a tool that never attached would draw a pit and may still say it placed it; only CE's log says why (line 74-86, at most one line per 5 seconds with a count). This is the "log only" decision listed for Tim (finding in FOR TIM 3).
8. **Merges.** 2083 sits on 2073; 2064 also merged 2073 and edits the end-of-command list next to these files. Expect text conflicts between 2064 and 2083 in `RecordOwnerRule.cs`; no behaviour clash seen.

# What I did not check

1. No build or test run; the lane's 22,233 ran, 0 failed, and the four broken copies not re-run. The core-console checks have not been run by anyone.
2. Whether `Document.CommandInProgress` names the X-Civil import in the target drawing while the source drawing is in front (finding 3.3).
3. All 36 outside save requests (finding 5); I opened the Pit Schedule, Edit Pit, the erase clean-up and the Inspector paths.
4. Background threads: the check reads the list of open drawings inside the record lock; if a background thread ever reached it, the read would fail and the change be allowed (caught, line 88-92). Not traced whether any does.
