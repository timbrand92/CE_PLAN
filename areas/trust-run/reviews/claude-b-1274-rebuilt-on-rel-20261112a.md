# Review: claude/b-1274-rebuilt-on-rel-20261112a (BUG-1274, Civil, draft PR #2023)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:10. Read only. Nothing built, run or installed.
**Base checked:** the branch is NOT cut from the installed `cf059dcf`. It sits on `7cc4d306` (the held C-79c build, Civil 3.0.92), 73 changes beyond what is installed. Its own change is three commits, `ad68a773`, `1ce60445`, `7b3fe32b`, diffed with `git diff 7cc4d306...origin/claude/b-1274-rebuilt-on-rel-20261112a`.
**Card:** TRUST-04, Civil item 3. **Bug:** BUG-1274 (seen on a real job on 4 Nov).

---

# FOR TIM

1. **What it does on a drawing:** the Pit Schedule window adds a line such as "6 plastic pits are not in this schedule: P3 to P8. Open PIT on each and press Number and schedule this one anyway." Nothing in the drawing changes and nothing is blocked.
2. **It works for plastic pits that carry a number, like the job you found.** But a plastic pit placed today has no number, and for those the line would print AutoCAD's internal object codes, such as "2A3F, 2A41", instead of anything you would recognise.
3. **Verdict: FIX FIRST** (never show those codes; take the job's suburb out of the test; move it onto the build you have installed).

---

## Findings

1. **FIX FIRST: unnumbered plastic pits are listed by AutoCAD handle.** The PIT tool clears the number when a pit is set to plastic (`Modules/Drainage/ViewModels/PitViewModel.cs` 697 at `cf059dcf`), the new pit's record takes that blank number (`Commands/PitCommand.cs` 828), and on load a blank number is replaced by the drawing handle (`Services/ProjectDataService.Mutations.cs` 2006). The notice names pits by that value (`Rules/PitScheduleLeftOutNotice.cs`, `Build` from line 34, `ListPits` 105). So the everyday case, plastic pits placed with today's tools, prints hex codes. The "(no number)" fallback at line 135 can never fire after the load fills the blank. Fix: name only pits that have a real number; count the rest, for example "4 plastic pits without numbers are not scheduled". Test with a pit whose number is blank and whose handle is filled in, as the load leaves it.
2. **Recommended with item 1, DRAFT default for Tim:** an unnumbered plastic pit left off the schedule is the plastic pit rule working (no number on the plan, nothing for a council reader to miss). Showing it in the accent colour on every drawing with plastic pits will train drafters to ignore the line. Suggest: numbered pits left out are the attention line; unnumbered plastic pits are a quiet count. The bug entry itself says the wording and plastic-pit numbering are Tim's call.
3. **FIX FIRST: a real job's suburb is in the repository.** `Modules/Drainage.Tests/Rules/PitScheduleLeftOutNoticeTests.cs` lines 12, 28 and 42 (a comment and a method name) and the `REGRESSION_LOG.md` entry name the suburb of the job in the bug report. Run rule 3.7 and RULES 11: no job address in any repo file. Rename to a made-up case when lifting. The old commits stay in history on this branch (RULES 11.3: listed here for the controller, not deleted).
4. **FIX FIRST: lift onto the installed build.** Card TRUST-04 says the held builds are not installed whole; this branch carries all of C-79c. A dry run of the three commits onto `cf059dcf` (`git merge-tree --merge-base 7cc4d306 cf059dcf ...`) conflicts only in `REGRESSION_LOG.md`, and every class the change calls exists at `cf059dcf` (`ObjectStatusRule.CountsInPitSchedule`, `PitScheduleSourceReference`, `RunPreFlightCheck`, `PreFlightDetailText`). Not compiled.
5. **The schedule's own pit choice is unchanged (checked).** `IsEligibleScheduledPit` (`ViewModels/PitScheduleViewModel.Data.cs` 854) used to require all three of: in schedule, not To be removed, plastic admitted. It now asks `ReasonLeftOut == None` (`PitScheduleLeftOutNotice.cs` 76), which tests the same three. Same pits scheduled as before, and the notice and the schedule now share one rule (design rule 1).
6. **Minor: an on/off switch the card rules out.** `pitScheduleSaysWhatItLeavesOut` (`Models/UserSettings.cs` 2703, default on). Card TRUST-04 section 2, item 2: no switch for a fix to a wrong result. The three wording strings on Settings are fine (R-00). Controller's call whether the switch stays.
7. **Needs a Codex look: the one-line header may hide the existing check.** The window's header line cuts off long text (`Dialogs/PitScheduleDialog.xaml` 110-111, `TextTrimming=CharacterEllipsis`). The notice is put IN FRONT of the existing "N data issues" text (`PitScheduleViewModel.Data.cs` 878, 911), so on a narrow window the data-issue part may not be visible at all; it is still in the tooltip and the detail panel.
8. **Checked and fine:** display only (sets window text, writes nothing to the drawing or CE's record); the window states it never blocks schedule placing (XAML comment at line 109, and `PreFlightHasIssues` only changes text colour and shows the detail); the Xref schedule path keeps its read-only header and counts only the selected source drawings; no locked-layer, Xref-editing or REFEDIT path; no units involved; no existing test weakened; `Shared\CE_SHARED` untouched.

## What I did not check

1. Nothing was built or run; the window has not been seen.
2. Whether any other schedule filter (beyond the three reasons) also drops pits silently; I read only `IsEligibleScheduledPit`.
3. Project QA (CDCHECK), which the change log says is out of scope.
4. AutoCAD 2022 to 2024.
