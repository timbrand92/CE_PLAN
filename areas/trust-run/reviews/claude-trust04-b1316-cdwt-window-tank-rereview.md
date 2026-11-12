# Re-review: PR 2082 `claude/trust04-b1316-cdwt-window-tank` (BUG-1316, CDWT by its window keeps the library tank's details)

**Reviewer:** lane trust-review (fifteenth run). **Written:** 2026-11-13 08:53 PC clock. **Head reviewed:** `570743f3` (one commit since `d2bf2395`, the head of the first review, `reviews\claude-trust04-b1316-cdwt-window-tank.md`). Draft, auto-merge off. Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **Both things I asked for are done, in words only:** the pull request now says plainly that a tank placed from the office list through the window, with a base level, is counted in the detention storage (where today it is left out), and that this figure is yours to confirm.
2. **The robot's AutoCAD steps are now right:** read CE's stored record for make, size and lid; turn the "add make and size to the tank callout" switch on for the copy before looking at the callout; and run CDTWL to see the tank now counted.
3. **No code changed since the first review,** so the fix itself is as I read it then: right.

**Verdict: GO** for the robot on copies. The detention figure stays Tim's to confirm (DRAFT default: count it).

---

# Findings

1. **What moved:** only `REGRESSION_LOG.md` (3 lines in, 2 out). `git diff --stat cf059dcf 570743f3`: the code files (`WaterTankCommand.cs`, `WaterTankDialog.xaml.cs`, the test file) are byte-identical to `d2bf2395`.
2. **Item 1 of the first review (engineering figure not listed): FIXED.** REGRESSION_LOG item 3 and PR body item 5 say "ENGINEERING FIGURE, FOR TIM TO CONFIRM", name orifice level, tank top level, top water level and baffle wall height, give today's "no rated capacity or no height recorded" behaviour, and say tanks already placed keep their old record. The PR title now ends "(detention figure changes: Tim to confirm)".
3. **Item 2 (robot steps wrong): FIXED** in all three places (REGRESSION_LOG item 5, PR body item 6, `PENDING_TESTS.md` row 26): (a) read the stored record for make, library name, size and trafficable lid, with "no CE window shows make or size, the lid is shown nowhere"; (b) the callout only with the Settings switch ON on the copy, then put back; (c) CDTWL on a detained branch with a base level; (d) typed 4000 L gives litres only.
4. **Small, words only, not blocking:** step (c) says "before and after placing a window tank": on the PR build alone that shows the tank counted, not that today's build leaves it out. To show the change itself, place the same tank through the window on the installed build too (its CDTWL names it as left out). Worth a few words in row 26.
5. **For the controller:** the detention figure is not yet in `areas\TRUST_QUESTIONS_FOR_TIM.md` (searched for "tank", "detention", "1316", "2082": no entry for it). Add it with the DRAFT default "count it", or it will be decided by default without Tim seeing it.

# What I did not check

1. No build or test run (Tim's hours); the lane's figures not re-run.
2. The first review's own "not checked" items stand (the real window in AutoCAD; whether CDTWL's figures with such a tank are right in themselves).
