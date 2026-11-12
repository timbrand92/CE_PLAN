# Last-pass audit: the three BUG-1456 pull requests as ONE change (2073, 2083, 2078)

**Reviewer:** lane trust-review (fifteenth run). **Written:** 2026-11-13 08:57 PC clock. **Heads:** 2073 `claude/bug-1456-record-own-drawing` `1a28c3b3`; 2083 `claude/bug-1456b-record-change-door` `522e5502`; 2078 `claude/trust-01b-other-drawings-data` `e1bdc16e`. All drafts, auto-merge off. Read only: no build, no test run, no AutoCAD, no branch or worktree made (merges dry-run with `git merge-tree`). Evidence read: `EVIDENCE_CROSS_DRAWING.md` parts 1 to 3 and the cure section; `EVIDENCE_BRANCHES.md` section H.

---

# FOR TIM

1. **Installed together on Civil 3.0.90, the three stop every mix-up seen in AutoCAD,** by reading: Help or Settings first in a second drawing, after opening it or switching tabs, in both directions, and the blank drawing. Help and Settings no longer write CE's data at all when they end, and CE now refuses to write or change one drawing's data while another drawing is the one in front. The writing rule is proven in AutoCAD's core console; the seen sequences themselves have not yet been repeated in real AutoCAD on these builds.
2. **They merge cleanly in the order 2073, 2083, 2078, apart from the change-log file,** but 2078 cannot come alone: it sits on the opening line (pull request 2041), which adds a new line on every Civil drawing opening, switched on for everyone. So "three" is really four.
3. **Give 2073 first, on its own.** It is the smallest (no window, no new words on screen, no switch) and by itself stops every seen sequence. Then 2083 once its corrected check passes in the 2:00pm window; then 2041 with 2078, which only warns about drawings already saved with another job's data.

**Verdict: GO** for testing the set on copies in the order 2073, 2083, 2078 (with 2041). Smallest safe first set: **2073 alone.** Not fit to merge or install until the real-AutoCAD repeat on the cure build is done.

---

# Findings (file and line at the head named; product code only unless stated)

## 1. What a colleague would actually receive

1. **2073:** one commit on `cf059dcf`. Product files: `Rules/RecordOwnerRule.cs` (new), `Services/ProjectDataService.RecordOwner.cs` (new), `Services/ProjectDataService.Persistence.cs` (three checks), `Services/LinkService.cs` (Help and Settings off the end-write list). Nothing on screen; one log line when it refuses.
2. **2083:** one commit on 2073's head. Adds 53 lines to the end of `RecordOwnerRule.cs` and changes nothing else of 2073's (`git diff --numstat 1a28c3b3 522e5502`); a check before 55 change routines across 13 record-service files. A refusal is log only.
3. **2078:** three commits on PR 2041's head `31f426ab` (its PR base is the branch `claude/trust-01-open-line`, not the release line). So installing 2078 means installing 2041 too: the opening line (`Services/DrawingStateLineOnOpenService.cs`, `Rules/DrawingStateLineRule.cs`, hooks in `PluginInitialization.cs`, `LayerService.cs`, `PipeObjectUpgradeOnOpenService.cs`, `PitBlockMigrationService.cs`, `CurrentDrawingCheckService.cs`), ON by default (`Models/TrustSettings.cs:21` `sayDrawingStateOnOpen = true`; 2078's own warning `:37`, also true).
4. **No interplay between the halves:** the added lines of 2041 and 2078 make no call into CE's record service (searched for `ProjectDataService.`, `SaveProjectData`, `FlushPendingSave`, `SetDrawingPath`, `SyncWithDrawing`: none); they read the stored record from the drawing as text. So 2073's and 2083's checks never see them, and they never write.

## 2. Each seen sequence, with all three installed

The rule the set adds, in one line: CE's record belongs to the drawing it was last attached to; nothing writes it into, or changes it for, any other drawing (`ProjectDataService.RecordOwner.cs`, `RecordChangeDoor.cs`).

1. **Sequence 1 and R1** (CDDIAG in A, open B, CDHELP first): stopped twice. (a) CDHELP is off the end-write list (`LinkService.cs:64`); it opens Help only (`Commands/CdCommand.cs:1576`, `HelpLauncher`), and no record call exists in the Help launcher, the Help window, the Settings window or CDFEEDBACK (searched). (b) Any write still aimed at B finds the record attached to A, with A open: the save door (`Persistence.cs:347`), the forced-write door (`:468`) and the last door before writing (`:602`) all refuse; nothing is written in B.
2. **R3** (CDS alone): the same; CDS only shows the Settings window (`CdCommand.cs:1559-1566`).
3. **Sequence 2 and R2** (blank drawing): nothing written; the drawing keeps no CE dictionaries and its changed counter is not moved by CE.
4. **C3** (the other order): the same rule in the other direction.
5. **R5** (tab switch, no new open): the same. The doors compare the drawing being written with the drawing the record is attached to; how B came to the front does not matter.
6. **Cancelled PIT or CD first in B** (both stay on the end-write list): the forced write at their end is refused when nothing is waiting and the record is not B's (`Persistence.cs:468`, step Drop).
7. **The reverse, not seen but closed by 2083:** a tool in B that never attaches, changing A's record in memory, would with 2073 alone have its change kept and later written into A. 2083 refuses the change itself while B is in front (core tools attach first, so this was always rare).
8. **Part 2, a drawing already saved with another job's data:** the set does not repair it. On opening, CE takes its stored record as its own, as today. 2078 then says on the opening line, and in Check Current Drawing, that the drawing holds another drawing's data and not to run CDSYNC; but only until the first CE tool saves there and refreshes the stored file name, after which it is silent for good (said in the 2078 review). The ways back are unchanged (U straight after; the `_PRE_C7_` copy; the unsaved original).
9. **CDFEEDBACK** (unmeasured on the installed build): not on the list and no record call, and the doors refuse anyway.

**Answer: no seen sequence can write one drawing's CE data into another with the three installed,** by reading. 2073 alone already stops every seen sequence; 2083 adds the unseen reverse; 2078 writes nothing.

## 3. What is still open (none of it a seen sequence)

1. **One more writer outside the three doors (for the controller):** the batch edit write (`Services/CeBatchEditApplyCoordinator.cs:197-198`) writes CE's whole record from memory straight into the drawing it is given, without the owner check. Every caller I opened attaches the record first: CDEDIT's pipe and pit batches, reached only through the Hub's routing (`HubCommands.cs:187`, then `:290` and `:292`), CDDASHBOARD's proposals (`DashboardCommands.cs:31`), CDRUNSOLVE's (`RunSolveCommand.cs:78`). Not opened: the CE Assistant palette's apply (`Controls/CeAssistantControl.xaml.cs:610`, through the pipe-size proposals) and CDRULES' approved fix. With 2083 the per-pipe changes inside would be refused while another drawing is in front, but the whole-record write has no check of its own. One owner check there, the same rule as the three doors, would close it.
2. **The kept-record write** (`ProjectDataService.KeptRecords.cs:267`) also goes straight to the writer; it is kept per drawing and dropped when that drawing closes (`:281`), so by design it only ever writes a drawing's own record. Outside the doors, not a seen path.
3. **About 20 other whole-record writers** (`WriteSnapshotInTransaction`): the twelve whose source I traced take the record from the drawing itself, or from memory only when it is that drawing's (`ProjectDataService.Spine.cs:70-77` refuses otherwise). The rest not traced.
4. **Proof:** core console only. `CEPROOFCROSSDRAWING` PASS on 2073 and 2083; `CEPROOFCROSSCHANGE` FAIL is the check's own fault (`reviews\claude-bug-1456b-record-change-door-rereview.md`), to be rerun at 2:00pm on the corrected check. The seen sequences R1, R2, R3, C3 and the tab switch have not been repeated on the cure build in real AutoCAD (needs the build loaded, which this run may not do).

## 4. Merging in the order 2073, 2083, 2078

1. **Dry runs** (`git merge-tree --write-tree`, nothing checked out): 2073 onto `cf059dcf`: clean. 2083 onto 2073: clean (it is built on 2073's head). 2078 onto 2083's head: **one conflict, `REGRESSION_LOG.md`** (both add entries at the top; keep both). No code file is changed by both sides (file lists compared).
2. **No behaviour clash by reading:** with 2073, Help and Settings no longer refresh the stored file name as a side effect, so 2078's first condition (stored name is another drawing) is true a little more often; its second condition (the other job's pits and pipes not drawn here) carries the decision, and it stays quiet on Save As, copies and renamed files.
3. **2078's base:** merged as it stands, 2078 lands in 2041's branch. For the release line, 2041 must go first (or 2078 be re-pointed), and 2041's open case-file points (O18, O20, the word "record") are still with the controller.
4. **With 2064** (also holds 2073, merged at `784bfd03`): a dry run of 2083 with 2064's head conflicts only in `REGRESSION_LOG.md` (`ProjectDataService.cs` merges on its own). 2064's head moved to `dde7825e` and is not re-reviewed in this run.

## 5. The smallest safe set first

1. **2073 alone.** Four product files, no switch, nothing a drafter sees, one log line; core-console check passed; stops every seen sequence twice over (list removal plus the doors). Before Tim: the real-AutoCAD repeat of R1, R2, R3, C3 and the tab switch on this build, each leaving the second drawing's record exactly as it was.
2. **Then 2083:** wider (55 routines) and a refusal silently drops a tool's change (log only, Tim's decision on the command line still open). Owed: the corrected `CEPROOFCROSSCHANGE` run, and the robot showing no real change is refused (X-Civil import opening its source drawing; the Inspector palette).
3. **Then 2041 with 2078:** a warning for drawings already saved with another job's data; visible to everyone on every Civil opening.

# What I did not check

1. No build, no test run, no AutoCAD, no core console (Tim's hours).
2. The CE Assistant palette and CDRULES routes into the batch write; about eight whole-record writers not traced.
3. 2041's code at `31f426ab` not re-read (reviewed GO earlier at that head); 2078 read at `e1bdc16e` for its interplay only.
4. What a later CE tool does with a record left waiting for its own drawing after a refusal in another (kept, then written into its own drawing at that drawing's next command end, by reading; not run).
