# Re-review: draft PR 2039, `claude/trust04-b1274-left-out-pits` (BUG-1274, the Pit Schedule says which pits it leaves out)

**Reviewer:** lane trust-review (sixth run), Fri 13 Nov 2026, 01:33 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 3ae32c37...origin/claude/trust04-b1274-left-out-pits` at head `fd9bcce5` (one new commit since my third-run review; `3ae32c37` is an ancestor, no rewrite; base still `cf059dcf`), the PR description, `PENDING_TESTS.md` row 2 of "TRUST-04 core safety fixes", and the installed check at `cf059dcf` (`PitScheduleViewModel.Data.cs` 851-859). Checked against my review `reviews\claude-trust04-b1274-left-out-pits.md`.

---

# FOR TIM

1. **The main fault is fixed: plastic pits with no number are now counted ("none of them has a number"), never listed by AutoCAD's internal codes.**
2. **The schedule still lists exactly the same pits as the build you have installed,** and a test now proves it against your installed build's own check for all 16 combinations.
3. **The switch to turn the line off is gone,** as the card asked; only the wording stays on Settings.

**Verdict: GO** for the robot and Codex on copies, once the robot steps are corrected (section 3). Built yes (by its lane). Tested: unit tests only, by its lane; not re-run here. Installed no. Accepted no.

---

## 1. The three FIX FIRST items, one by one

1. **Unnumbered plastic pits listed by internal object code: FIXED.** `HasPitNumber` (`Rules\PitScheduleLeftOutNotice.cs` 108-114) treats a number equal to the pit's own object code as no number; `NamePits` (121-129) names numbered pits and counts the rest ("P3, P4 and 2 without a number", "none of them has a number"). The test builds the record exactly as the load leaves it, by running the load's own tidy-up step (`NormalizeProjectData`), and checks no code appears in the line (`PitScheduleLeftOutNoticeTests.cs`, `PlasticPitsAsLoaded_AreCountedWithoutTheirInternalCodes`). That closes the gap the old blank-number test left.
2. **The job's suburb in this branch's history: FIXED by record, not by rewrite.** Commit `a3f06dd9` still holds it; the new change-log entry, item 6, says the branch must be squash-merged only (one of the two fixes my review offered). The PR description does not say so yet (section 3).
3. **The plastic pit rule pinned only against itself: FIXED.** The installed check is written out in the test (`InstalledBuildSchedules`) exactly as at `cf059dcf` (`Data.cs` 851-859: include in schedule, counts in the schedule, plastic admitted) and compared with the new schedule filter for all 16 mixes of plastic, "Number and schedule this one anyway", "Include in schedule" and To be removed; the same test checks the line names a pit exactly when the schedule leaves it out. The written-out check uses the same two helper rules the installed code used, so it pins the way they are combined (the part this change touched), which is what mattered.

## 2. Also changed

1. **The off switch is removed** (`Models\UserSettings.cs` 2561-2565); an old settings file that still holds it loads normally (test `Wording_ShipsAsAgreed_ThroughBothStartUpReads`). No other reference to it is left in the code. This was my "for the controller" item 1.
2. **No new client name, job number, street or suburb** in the new commit, its tests or its change-log entry.

## 3. Before the robot runs (records, not code)

1. **The PR description is out of date:** it still lists `pit.pitScheduleSaysWhatItLeavesOut` "(default on; off = no line)", does not mention the review fixes, and does not say "squash-merge only". Whoever merges reads the description.
2. **`PENDING_TESTS.md` row 2 still ends "Settings `pit.pitScheduleSaysWhatItLeavesOut` false: no line"** (that switch no longer exists), and the older change-log entry's test step ends the same way. Its case uses numbered plastic pits (P3 to P5) only; add the everyday case this fix is about: three plastic pits placed with today's PIT tool (no number), so the line must read "3 plastic pits are not in this schedule: none of them has a number ..." with no internal code shown.

## 4. Worth knowing (unchanged, not blocking)

1. Unnumbered plastic pits still turn the line to the attention colour although leaving them out is the rule working; listed as a DRAFT default for Tim (change log item 5).
2. "Turn on Include in schedule" is greyed out in the PIT window unless the pit has a label (my last review, section 4 item 1).
3. A second copy of the schedule rule remains in `Services\PitScheduleSourceSelectionService.cs` (Xref duplicate numbers); not routed through the one rule.
4. Codex look still needed on the window's top line (fit and colour).

## 5. Not checked

1. Did not build or run tests; the lane's counts are not re-run here.
2. The window has not been seen.
3. AutoCAD 2022 to 2024.
