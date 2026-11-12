# Review: draft PR 2039, `claude/trust04-b1274-left-out-pits` (BUG-1274, the Pit Schedule says which pits it leaves out)

**Reviewer:** lane trust-review (third run), Thu 12 Nov 2026, 23:58 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff cf059dcf...origin/claude/trust04-b1274-left-out-pits` at head `3ae32c37` (five commits, 6 files; cf059dcf confirmed as its base), each commit on its own, `gh pr view 2039`, the BUG-1274 entry in `BUG_CARPARK.md`, card `TRUST-04`, the earlier review `reviews\claude-b-1274-rebuilt-on-rel-20261112a.md`, and the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf).

---

# FOR TIM

1. **The Pit Schedule window now says which pits it leaves out, and the schedule still lists exactly the same pits as before.** I checked the plastic pit rule line by line: unchanged.
2. **The main fault from the last review is still there:** a plastic pit placed with today's PIT tool has no number, and the line would show AutoCAD's internal object codes (such as "2A3F") instead.
3. **The job's suburb is gone from the files,** but one of this branch's saved steps still holds it.

**Verdict: FIX FIRST** (three items below). Built yes (by its lane, net48 and net10). Tested: unit tests only, by its lane (23 of 23 left-out tests; 930 of 930 Pit Schedule tests before the last guard); I did not run them. Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Earlier finding, the internal object code listed as a pit number: NOT FIXED.** See FIX FIRST 1. The PR's own review section lists the two things it changed (a guard test, the place name) and does not mention this finding.
2. **Earlier finding, real job details in the repository: FIXED at the tip, NOT in the branch history.**
   1. The tip names the case "the 4 Nov job" (`PitScheduleLeftOutNoticeTests.cs` 12, 28); no suburb, street or job number in any file the branch adds or changes, nor in the change log. The only place that suburb's name still appears in the tree is the council list in `council-profiles.json`, which was there before and is unrelated.
   2. Commit `a3f06dd9` on this branch re-commits the suburb (test comment, helper name, change-log line); `7115c129` takes it out again. See FIX FIRST 2.
   3. No job number appears in any of the five commits.
3. **Does a test fail without the change? YES, as far as the lane's broken twin shows.**
   1. Without the new rule file nothing compiles. The guard `TheWindowLoad_AsksForTheLeftOutLine_OnBothPaths` (`PitScheduleLeftOutHeaderTests.cs` 112-129) fails if either window call is removed; the lane ran that twin (1 of 23 failed). I did not re-run it.
   2. The guard searches the source text, so it proves the call is there and after the drawing check, not that it runs. Acceptable as a guard.
4. **The plastic pit rule itself unchanged: YES by reading, NOT pinned by a test.** Before (cf059dcf `PitScheduleViewModel.Data.cs` 851-858): in schedule, not To be removed, and plastic admitted. After: `ReasonLeftOut == None` (`PitScheduleLeftOutNotice.cs` 76-88), which tests the same three. Same pits scheduled. FIX FIRST 3 is about the test.
5. **Checked and sound:**
   1. Display only: it sets the window's existing check line and its colour; nothing is written to the drawing or CE's record; Settings are only read.
   2. The drawing check (`RunPreFlightCheck`) runs only at load (`Data.cs` 241), so nothing later in the same load wipes the line.
   3. Xref schedule: counts only the selected source drawings; the read-only header and the "Open" instruction stay (`Data.cs` 911); when sources clash the window returns before the line, which is fine because placing is blocked then.
   4. The button names in the wording exist in the PIT window: "Number and schedule this one anyway" (`Dialogs\PitDialog.xaml` 353) and "Include in schedule" (347).
   5. Locked layers, Xrefs and REFEDIT: not touched (nothing is written). `Shared\CE_SHARED`: not touched. No existing test weakened.

## 2. FIX FIRST

1. **A plastic pit placed today is listed by its internal object code.**
   1. The chain at cf059dcf: setting a pit to plastic clears its number (`ViewModels\PitViewModel.cs` 696); the new record takes that blank number (`Commands\PitCommand.cs` 828); on load a blank number is replaced by the object's handle (`Services\ProjectDataService.Mutations.cs` 2005-2006).
   2. The line names pits by that value (`PitScheduleLeftOutNotice.cs` 51-53), so the everyday case reads "3 plastic pits are not in this schedule: 2A3F, 2A41, 2A44". The "(no number)" words (135) can never appear after a load.
   3. The test `PitWithNoNumber_IsStillCounted` (129) uses a blank number, which the load never leaves, so it passes while the real case fails.
   4. Fix: a pit whose number equals its own handle counts as "no number" and is counted, not named (for example "4 plastic pits without numbers are not in this schedule"); test it with the number set to the handle, as the load leaves it. Suggested DRAFT default for Tim (from the last review): numbered pits left out are the attention line; unnumbered plastic pits are a quiet count, because leaving them off is the plastic pit rule working.
2. **The suburb is still in this branch's history.**
   1. `a3f06dd9` (cherry-picked unchanged from the held line) adds it in three places; `7115c129` removes it. A plain merge would carry both commits into the line that ships. RULES 11: no job address in any repo file or commit.
   2. Fix: fold the removal into the first commit so no commit on this branch holds the suburb (the lane owns this draft branch), or record that it may only be squash-merged. The controller notes the older copies on PR 2023's branch (RULES 11.3: listed, not deleted).
3. **Pin the plastic pit rule against today's, not against itself.**
   1. The only test comparing the notice with the schedule (`PitScheduleLeftOutNoticeTests.cs` 136-153) compares the new rule with itself: the schedule's filter now calls the notice's rule, so it cannot fail.
   2. Fix: one test that writes out today's three-part check and compares it with the new one for every mix of plastic, "number and schedule anyway", "include in schedule" and To be removed (16 cases). Tim's 5 Sep ruling is then guarded, not just re-worded.

## 3. For the controller

1. **The switch the card rules out is still there** (`pitScheduleSaysWhatItLeavesOut`, `Models\UserSettings.cs` 2569, default on). Card TRUST-04 section 2.2: no off switch for a fix to a wrong result. Unchanged since the last review; your call.
2. **Codex look still needed on the window's top line.** The left-out line goes in front of the data-issue text, joined by " | " (`Data.cs` 878, 911), and that line cuts off long text, so on a narrow window the data-issue part may not show (it stays in the detail panel).

## 4. Worth knowing (not blocking)

1. **"Turn on Include in schedule" cannot always be followed.** In the PIT window that toggle is greyed out unless the pit has a label (`PitViewModel.cs` 783, `IsPitNumberEnabled => CanNumberAndSchedule && AddLabel`; `PitDialog.xaml` 347). A concrete pit with no label and switched off for the schedule gets an instruction the drafter must first unlock by ticking the label.
2. **A second copy of the schedule rule remains** in `Services\PitScheduleSourceSelectionService.cs` 50-56 (finding the same pit number in two Xref drawings). It tests the same conditions today; it was not routed through the one rule.
3. **Pits marked To be removed also turn the line to the attention colour,** although they are left out on purpose. Wording is Tim's call per the bug entry.

## 5. Not checked

1. Did not build or run any test; the counts are the lane's.
2. The window has not been seen; the line's fit and colour are unseen.
3. Project QA (CDCHECK) and the Excel and CSV exports were not read for the same omission.
4. AutoCAD 2022 to 2024 (net48): compiles per the lane; not run.
