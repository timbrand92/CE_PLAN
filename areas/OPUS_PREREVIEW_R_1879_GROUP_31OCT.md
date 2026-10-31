# Opus pre-review R: PRs #1879, #1882, #1884, #1887, #1888 (older C-79 candidates)

Written Saturday 31 October 2026 by an independent read-only Opus reviewer, at CE 00's request (brief by CE 05).
Heads reviewed: #1879 8990ae3f, #1882 58c4473d, #1884 f9fa356c, #1887 d7bfa1d4, #1888 0b40e4af. All are against claude/rel-20261102a (tip 3fbb9da5, Civil 3.0.88).
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code and the author reports, and I ran read-only `git fetch` and `git merge-tree` only.

## FOR TIM

1. **#1879 (Level Update, BUG-625): CHANGE-NEEDED, do not put it on any train. Close it.** It was built on the wrong copy of Structural (the July one). The same fix, on the Structural you have installed, is #1885, and that is the one to carry. Its notes are below.
2. **#1882 (a pit lid at exactly RL 0.000 gets the cover check): KEEP-WITH-NOTE, Civil train C-79, network design area plus smoke.** It is a warning only and nothing is blocked. One small fix is recommended: a lid typed with a comma, such as "12,5", could get a false cover warning.
3. **#1884 (test runs must not touch your real settings): KEEP-WITH-NOTE, Civil train C-79, smoke (tests only).** Nothing changes in AutoCAD. Expect its new Civil check to go red on the first full run. Your real Civil settings file changed twice during test runs on 30 October and nobody knows why. A red result there is a real lead, not a faulty test.
4. **#1887 (a pipe even 1 mm uphill is reported as uphill): CHANGE-NEEDED, small.** CDRULES does not use this check, and it already says "flows uphill" for any uphill pipe. So the test steps (draw a 1 m pipe, run CDRULES) cannot show the change. The change really shows in the warning window after CD draws a pipe, in Edit Pipe, and in the dashboard.
5. **#1887, second point:** it also makes CE drop a markup change that leaves a pipe less than 1 mm uphill. Before, that change went through. That is a new refusal (R-27). The fix is one small change: keep the old 1 mm limit on the markup route only.
6. **#1888 (pipe label angle with a turned UCS): KEEP-WITH-NOTE, Civil train C-79, labels area plus smoke.** The label now lies along the pipe. One thing to look at: in a turned UCS and view, steep pipes can get a label that reads upside down on your screen. It reads the right way up in World.
7. **Stacking order for C-79:** #1884, then #1922 (its partner), then #1882, #1887 and #1888 in any order. The only text clash is the top of the change log, and keeping both entries fixes it. The settings file joins cleanly.
8. **Built and unit-tested only, every one.** Nobody has opened any of them in AutoCAD, and every bug stays OPEN.

---

## DETAIL

### #1879: B-065 BUG-625, Level Update only changes CE level marks (reference copy)

**1. What changes for the drafter**

1. **The change:** LMU first sorts what you picked (`LevelMarkCommands.cs` 104-118 of the PR). It keeps only text that is the number of a CE level mark (FFL, RL, SSL, NGL), says how many other texts it left alone, and stops without asking for a value if none qualify.
2. **How a level mark is recognised:**
   - **New marks:** they carry an invisible tag, `CE_LEVELMARK`, written when FFL, RL, SSL or NGL draws them (PR lines 331-341).
   - **Older marks:** they are recognised only when the text sits exactly where CE puts it. It must be on 25TEXT, at the end of a level 25DIMS tail, which sits one bar above a closed three-sided 25DIMS triangle (`LevelMarkRecognition.cs` 80-134, tolerance 2% of the text height).
3. **Wrong base, so this PR should not ship.** The base is claude/rel-20261102a, whose `Modules/Structural` is the 2 July snapshot (version 1.0.42). The author says so in `C:\CE_PLAN\areas\BUGFIX_p5_REPORT_30OCT.md` item 2, and rebuilt the fix as #1885 on claude/rel-20261026s (head 044cf047, which sits on the 26s tip 204dfad2).
4. **#1885 is the same fix.** I compared the two diffs line by line: `LevelMarkRecognition.cs` and `LevelMarkCommands.cs` are identical. #1885 also adds the plain-English label in `SettingsService.LoadRecovery.cs` (1359) and a better defaults test. Everything below therefore applies to #1885 too.
5. **Against the carpark entry:** BUG-625 asks for three things: only recognised marks change, ordinary notes are preserved, and the affected marks are shown with Preview and Apply before writing. This PR does the first two. Preview and Apply is NOT built (the author says so). So even after an AutoCAD pass, BUG-625 can only be partly fixed.
6. **One conflict with the carpark wording.** Item 6 says "use recognised ownership/source relationships, not proximity". The tag is ownership. The older-mark fallback is position-based: it is a very tight match, but it is still proximity. My recommendation is to keep it. Without it, LMU would refuse every mark drawn before this build, which is every mark on every live job. CE 00 should record that choice next to BUG-625 so the acceptance pass does not trip on it.

**2. Settings switch**

1. **The switch:** `Annotation.LevelUpdateOnlyChangesCeLevelMarks`, default true (`UserSettings.cs` 92-97). It is a tick box on the Settings Annotation tab (`CeSettingsDialog.xaml` 344, load at `.xaml.cs` 129, save at 289).
2. **Defaults test:** in #1879 it uses plain `JsonConvert` (`LevelMarkRecognitionTests.cs` 146-156), not the real start-up reads. #1885 renamed and strengthened it ("ThroughBothStartUpReads"). That is another reason to carry #1885.
3. **OFF:** LMU rewrites every picked text, exactly as before (the old loop over `targetIds` with no filter).
4. **One gap:** with the switch OFF, new marks are drawn WITHOUT the tag (PR line 331). Marks drawn while the switch is off are then only found by position after it is turned back on. The tag is invisible and harmless, so it should be written every time. This is a one-line change; do it in #1885.
5. **Hard-coded figures:** the proportions 2.0/2.5 and 1.25/2.5 copy the drawing code's own fixed proportions, and the 2% tolerance is a matching tolerance, not an engineering value. No R-00 issue.

**3. No hard blocks (R-27)**

1. **The "None of the N selected ... nothing was changed" stop** is the behaviour BUG-625 asks for (an ordinary note is refused and preserved). It is a command-line line, not a window. The switch restores the old behaviour. No other stop was added.

**4. Native protection and REDO**

1. **The sorting pass is read-only.** It reads each picked object and, for untagged picks, every object in that space (`FilterToCeLevelMarkLabels`). It writes nothing.
2. **Speed:** this pass reads the whole space once per LMU when any untagged text is picked. On a very large model space that may take a second or two. That is not measured.
3. **New write:** FFL, RL, SSL and NGL now add a registered application name and a tag to the label, inside the same transaction as the mark. One U should remove both. REDO is not proven.
4. **Locked layers, Xrefs and REFEDIT:** behaviour is unchanged. LMU still opens picked text for writing exactly as before.

**5. Merge**

1. **Against rel-20261102a:** the only conflict is `REGRESSION_LOG.md`. `UserSettings.cs` (Structural) auto-merges.
2. **Against the other four PRs:** the only conflict with each is `REGRESSION_LOG.md`.
3. **Stacking:** none. It is not to be stacked on the Civil train. Carry #1885 on the Structural line.

**6. Tests**

1. **What they test:** the 16 recognition tests are real geometry cases: tagged, untagged old mark, note beside a mark, wrong side, no triangle, and two marks. They need the AutoCAD native host, so they are skipped on net48.
2. **What they do not test:** the command wiring (`LevelMarkCommands.cs`) has no test at all.
3. **Real AppData:** the author listed the real settings files before and after the runs, and they were unchanged (report item 6).

**7. NOT proven, and the robot case**

1. **NOT proven:** anything in AutoCAD; the tick box (compiled, never looked at); the switch-OFF route; one U and REDO after FFL; older-mark recognition on real old drawings.
2. **Robot cases:** S21_lmu_ce_mark_only and S21c_lmu_switch_off, as written in the p5 report.
3. **NEW, add to them:** draw an FFL with the switch OFF (set before launch), turn it ON, restart, and run LMU on that mark. It must still be found (by position). Then U and REDO after an FFL.
4. **Codex look:** the Annotation tab with the new tick box, and one real old drawing with existing level marks.

**8. Verdict**

1. **#1879: CHANGE-NEEDED.** Close it as superseded by #1885; no train.
2. **For #1885:** write the tag whatever the switch says, and record the position fallback against the carpark wording. Train: Structural, FULL (the Settings page changed).

---

### #1882: B-069 BUG-1093, a pit lid at exactly RL 0.000 gets the cover check

**1. What changes for the drafter**

1. **The change:** in network design (CDRUNSOLVE and the proposal builder) and in network redesign, a pit whose lid is typed as exactly 0.000 is now a real level. It gets the "COVER: ... mm < minimum" finding at the upstream end, the downstream end and the pit (`NetworkDesignService.cs` 402, 418, 482), and in the BUG-422 re-check (648).
2. **Blank lids:** a blank lid is still Unknown and is not checked. The old trench-grate placeholder ("0.000" on a TG) also stays Unknown, through `PitData.KnownCoverLevelRl()` (`PitData.cs` 72-94).
3. **Against the carpark:** this matches BUG-1093 exactly ("Cover known is its own yes/no").
4. **Findings only.** I checked every consumer of the COVER note and `CoverOk`. None refuses or changes a level. The redesign consistency check (`NetworkRedesignSolverService.OutputValidation.cs` 83-92) uses the same rule as the solver, so redesign does not reject its own answer.
5. **Hidden-but-safe point:** in redesign, a blank lid never reaches the solver anyway, because `TryPitValues` (`NetworkRedesignDrawingProjector.cs` 748-775) refuses an unreadable cover. That is pre-existing. So the redesign path mostly sees "known = true".

**2. Settings switch**

1. **The switch:** `cover.zeroCoverLevelIsReal`, default on (`UserSettings.cs` 320-327). It is pinned through `DeserializeSettings` and `DeserializeSettingsTolerant` (`Bug1093CoverZeroTests.cs` 125-141).
2. **OFF:** producers write nothing, and consumers use the old "0.0 means not set" rule (`CoverLevelKnownRule.cs` 29-35). That is exact.
3. **File only:** the switch is not on the Settings page. The same question applies as QUESTIONS_FOR_MONDAY item 75: add it to that list rather than asking again.
4. **Hard-coded values:** none. The minimum cover is still the Settings or rulebook value.

**3. No hard blocks (R-27)**

1. None added. Findings only.

**4. Native protection and REDO**

1. No drawing write, regen, view or system variable change. It reads pit records only.

**5. Merge**

1. **Against rel-20261102a:** the only conflict is `REGRESSION_LOG.md`. `UserSettings.cs` auto-merges; this PR adds to the Cover group at about line 320.
2. **Against #1887 and #1888:** the only conflict is `REGRESSION_LOG.md`. The three settings additions are in three different groups (Cover, Grade and Linking), so they do not collide.
3. **Other open drafts:** the author's list of other drafts that touch `UserSettings.cs` and `NetworkDesignService.cs` (#1863) still applies. I did not re-check those.

**6. Tests**

1. **Behaviour tests:** these run the real `NetworkDesignService.Design`. A 0.000 lid gives a COVER finding, Unknown gives none, unanswered keeps the old rule, OFF is old, 0.001 is checked either way, plus a truth table. They would fail on the old code.
2. **Source guards only:** the two producers (`ProposalApplyService.PlanBuilders.cs` 618-622, `NetworkRedesignDrawingProjector.cs` 329) and the redesign check are covered by text guards only. A text guard proves the line exists, not that the drawing reaches it.
3. **Real AppData:** the tests use a temporary settings scope. The p9 author saw Tim's real `TIM_CE_CADTOOLS\CD_Settings.json` change its last-write time during the session (see #1884 below). That is not attributed to this PR.

**7. NOT proven, and the robot case**

1. **Finding A, number reading (recommend fixing before install).** `ProposalApplyService.PlanBuilders.cs` 616 reads the lid with `TryParseInvariant` (Float style). The new "known" flag comes from `KnownCoverLevelRl()`, which reads with `NumberStyles.Any`, a looser reader. A lid typed "12,5" or "1,012.500" therefore counts as known while its level stays 0.0, and the pit gets a false COVER finding against RL 0. Before the PR it was simply not checked. Fix: in that builder, use the `KnownCoverLevelRl()` value itself as the level when it has one. The fix is three lines.
2. **NOT proven:** anything in AutoCAD; a full redesign with a 0.000 lid; the CDRUNSOLVE output wording.
3. **Robot cases:** C93_cover_rl0 and C93_cover_rl0_off, as in the p9 report. **Add:** CDRUNSOLVE on the same run as well as redesign, because both routes changed.

**8. Verdict**

1. **#1882: KEEP-WITH-NOTE**, with finding A fixed by the finaliser if possible.
2. **Train:** Civil C-79, network design area plus smoke.

---

### #1884: B-062, test runs must not touch Tim's real settings or logs (tests only)

**1. What changes for the drafter**

1. **Nothing in AutoCAD.** No product file changes; this is test projects and `REGRESSION_LOG.md` only.
2. **Structural tests** on the Civil line now point the Structural settings root and the shared log folder at a throw-away temp folder for the whole run (`RealAppDataIsolationSetup.cs` 47-66, global namespace `[SetUpFixture]`), and delete it afterwards (78-106, with a safe-path check).
3. **Three guards:** each of the Structural, Civil and Manager test projects gains a check that the real settings file was not created, deleted or rewritten. It reads only existence, length and last-write time.
4. **Against Tim's decision 153 ("6yes"):** this does what was asked for settings. Logs on the Structural copy are handled by the partner PR #1922 (y2).

**2. Settings switch**

1. No switch. That is right: this is test-only code and drafting behaviour does not change.

**3. No hard blocks (R-27)**

1. Not applicable.

**4. Native protection and REDO**

1. Not applicable. Nothing touches AutoCAD.

**5. Merge**

1. **Against rel-20261102a:** clean. The branch already merged 02a (merge commit f9fa356c).
2. **Against the other PRs in this group and against #1922:** only `REGRESSION_LOG.md` conflicts. No code file overlaps #1922.
3. **Stacking:** put #1884 first and #1922 straight after. Then the stacked train's full run is guarded.
4. **Stale comment:** when #1922 lands, the "NOT covered: Logger, LoggingService ..." comment in `RealAppDataIsolationSetup.cs` 25-27 becomes wrong. The finaliser should update it.

**6. Tests**

1. **The comparison tests are real.** They cover created, deleted, longer, rewritten at the same length, untouched, never existed, and a reader that works while the file is held open.
2. **Not proven:** the guard firing on a real leak.
3. **Order is not a promise.** The Civil and Manager guards rely on the "Zz" name to run late. NUnit's order is not a promise, and a filtered run skips them. Only Structural has an end-of-run check (`EndIsolation`). The y1 report (section 3) recommends moving Civil and Manager to the same end-of-run check. That is a follow-up, not a blocker.
4. **Early access:** I searched Structural.Tests for anything that could reach the settings before the set-up runs (test-case sources, module initialisers). I found none.
5. **Evidence the Civil guard is needed:** Tim's real `TIM_CE_CADTOOLS\CD_Settings.json` changed during the evening of 30 October, while full Civil runs of p9 and p12 were going. At 22:15 it was 15,404 bytes. By 22:28 to 22:30 it was 15,270 bytes with a last-write date of 11 March. The p9 and p12 reports record this. A plain save stamps the current time, so something copied or back-dated the file. I searched the Civil and Manager code on 02a for anything that back-dates a file. I found nothing aimed at that file, so the cause is still unknown. The Civil guard would have caught it.

**7. NOT proven, and the robot case**

1. **NOT proven:** a guard firing on a real leak; net8; the full Civil and Manager suites with the guard in.
2. **Robot:** none needed.
3. **Desk check:** after the first stacked full Civil run, read the Civil guard result. If it is red with no AutoCAD start named, treat it as the 30 October leak and find the writer.

**8. Verdict**

1. **#1884: KEEP-WITH-NOTE.**
2. **Train:** Civil C-79, smoke (tests only).

---

### #1887: B-069 BUG-1092, a pipe even 1 mm uphill is reported as flowing uphill

**1. What changes for the drafter**

1. **The change:** `DesignValidationService.CheckReverseFall` (`DesignValidationService.cs` 320-349). With the switch on, any uphill beyond rounding noise (1e-9 m) is the red "Pipe flows uphill" error. The tolerance (Settings, `designStandards.reverseFallToleranceMm`, 5 mm) now only decides the "essentially flat" wording.
2. **Against the carpark:** that matches the expected behaviour of BUG-1092.
3. **Finding B: it is NOT CDRULES (fix the wording and the robot case).** CDRULES (`RulesCommand.cs`) uses the rulebook, `RulebookEngine.cs` 384-386. That already reports "flows uphill" for any uphill, using an exact comparison, and never calls `DesignValidationService`.
4. **Where the change really shows:**
   - the warning window after CD draws a pipe (`CdCommand.cs` 1070-1074, a window that already opened for the "flat" warning);
   - the Edit Pipe warnings (`PipeEditCommand.Update.cs` 598-602);
   - CDDASHBOARD and the consultant drawing check (`DesignReviewService`);
   - the grade suggestion (`PipeGradeAdvisorService.cs` 240);
   - the markup change plan (`MarkupToChangePlanService.cs` 454-462).
5. **Effect on the test steps:** the carpark steps, the REGRESSION_LOG entry and robot case C94 all say "run CDRULES". On that route the switch-OFF control would read the same as ON, so the case cannot fail and proves nothing.

**2. Settings switch**

1. **The switch:** `grade.anyUphillFallIsError`, default on (`UserSettings.cs` 1703-1711, Grade group). It is pinned through both start-up reads (`Bug1092UphillTests.cs` 115-129).
2. **OFF:** the old limit and the old sentence exactly (test at 103-113 checks the exact sentence).
3. **File only:** same as #1882; add it to QUESTIONS_FOR_MONDAY item 75.
4. **Hard-coded values:** none. The 1e-9 is rounding noise, not an engineering value.

**3. No hard blocks (R-27)**

1. **Finding C: a new refusal.** `MarkupToChangePlanService.TryValidateProposedInverts` (425-462) sets its own 1 mm tolerance and treats any red error as a blocker. The markup item is then dropped from the change plan with "Requested grade fails design validation" (331-335 and 402-406).
2. **What changes:** before the PR, a markup that left a pipe 0 to 1 mm uphill passed as "flat". Now it is dropped. The drop itself already existed, but this PR widens it.
3. **Recommended fix:** keep the markup route on its old 1 mm limit. That means not treating a GRADE_REVERSE of 1 mm or less as blocking there, which is a few lines. Alternatively, name the change in the REGRESSION_LOG and accept it.
4. **No new window:** the CD draw route already opened the warning window for the flat warning. The window now shows a red uphill line instead.

**4. Native protection and REDO**

1. No drawing write, regen, view or system variable change.

**5. Merge**

1. **Against rel-20261102a and the group:** only `REGRESSION_LOG.md` conflicts. `UserSettings.cs` auto-merges (Grade group).
2. **Other drafts:** none touches `DesignValidationService.cs`, per the author's check; I did not re-check.

**6. Tests**

1. **Behaviour tests:** these run the real `ValidatePipe`: 4 mm and 1 mm uphill are red, 0.4 mm prints "0.4mm", a level pipe stays flat, a small fall stays flat, the tolerance only moves the flat wording, and OFF is exact. They fail on the old code.
2. **Not covered:** the markup route and the CD draw window.
3. **Real AppData:** same as #1882 (temporary scope; the unexplained CD_Settings.json change is not attributed).

**7. NOT proven, and the robot case**

1. **NOT proven:** anything in AutoCAD; the markup route; the CDDASHBOARD wording.
2. **Robot case C94, retargeted:**
   - **Draw:** with CD, draw a 1 m 225 pipe, IL 10.000 at the start and 10.004 at the end.
   - **Check:** the warning window that opens after drawing must show "Pipe flows uphill ... 4mm lower", and not "essentially flat".
   - **Then:** run CDDASHBOARD, where the same pipe must show the uphill error.
   - **Control C94_off:** with the switch off before launch, the same window says "Pipe is essentially flat".
   - **Third check:** a level pipe (10.000 both ends) says "essentially flat".
3. **Codex look:** none needed beyond the robot case.

**8. Verdict**

1. **#1887: CHANGE-NEEDED.** Correct the REGRESSION_LOG and the report to name the real places (finding B), and retarget the robot case. Then either keep the markup route on its old 1 mm limit (recommended), or name the wider refusal in the log (finding C).
2. **Train:** Civil C-79, pipe design checks area plus smoke.

---

### #1888: B-072 BUG-1195, CDTEXTSEG with a turned UCS leaves the pipe label at the wrong angle

**1. What changes for the drafter**

1. **The change:** when CDTEXTSEG, the CD "pick a point to move pipe text" prompt in UCS mode, or Edit Pipe moves a pipe label while the UCS is turned, the label angle is now measured in World, the same way its position already was. A pipe at 45 degrees in World gets a 45-degree label (`PipeTextPlacementService.cs` 72 and 193-206).
2. **Unchanged routes:** routes that already pass World points (CD, `CdCommand.Arrows.cs` 117 and `CdCommand.cs` 836) set the UCS to Identity and are untouched.
3. **Against the carpark:** this matches BUG-1195 (World rotation 45 degrees modulo 180).
4. **Finding D: which way up is judged in World, not on screen.** After the angle is taken in World, the "keep it readable" flip (`GetReadableTextRotation`, 209-215) is applied in World.
5. **Example:** a drafter works with the UCS turned 45 degrees and the view set to PLAN for that UCS. A pipe at World 100 to 135 degrees (or 280 to 315 degrees) runs steeply up the screen. Its label gets flipped by the World rule and reads upside down on that screen. In World it reads correctly.
6. **The alternative:** apply the flip in the UCS, then add the UCS X-axis angle. That gives the same World answer for the test case and keeps the label readable in the drafter's view. I could not verify which convention label creation (CD) uses in a turned UCS. If CD creation also judges in World, this PR is at least consistent with it.
7. **Recommendation:** keep the PR as is, and add the steep-pipe check to the robot case. If the label reads upside down, fix it in a follow-up.

**2. Settings switch**

1. **The switch:** `linking.pipeTextMoveAngleFollowsUcs`, default on (`UserSettings.cs` 784-791). It is pinned through both start-up reads, and the typed OFF is kept (`Bug1195TextSegUcsAngleTests.cs` 91-108).
2. **OFF:** the old angle exactly (test at 41-46).
3. **File only:** same as above; add it to item 75.
4. **Hard-coded values:** none.

**3. No hard blocks (R-27)**

1. None added.

**4. Native protection and REDO**

1. **Writes:** the same write as before (the label's rotation), in the same place. The BUG-284 locked-layer handling (`PipeTextPlacementService.cs` 79) is untouched. No new write, regen, view or system variable change.
2. **Xref and REFEDIT:** behaviour is unchanged.

**5. Merge**

1. **Against rel-20261102a and the group:** only `REGRESSION_LOG.md` conflicts. `UserSettings.cs` auto-merges (Linking group, next to the BUG-1194 key).

**6. Tests**

1. **Pure angle tests:** these cover UCS 45 (World 45 modulo 180), reversed direction, OFF gives the old 0, World UCS the same either way, World points not turned again, and a vertical leg safe. They would fail on the old code.
2. **Wiring:** covered by a source guard only (75-82).
3. **The "readable" test checks World**, so finding D is not tested.
4. **Real AppData:** the p12 author records the same unexplained CD_Settings.json change (p12 report item 2). It is not attributed to this PR.

**7. NOT proven, and the robot case**

1. **NOT proven:** anything in AutoCAD; the Edit Pipe and Attachments route (`PipeEditCommand.Attachments.cs` 664); the flow arrow on the CDEDIT route, which has the same fault, is out of scope, and the author flagged it for the carpark.
2. **Robot case:**
   - **Set up:** UCS Z 45, then PLAN Current.
   - **Diagonal pipe:** CD a pipe from World 0,0 to 10000,10000, then CDTEXTSEG and pick the leg. Read the label rotation: it must be 45 degrees in World.
   - **NEW, steep pipe:** CD a pipe from World 0,0 to -3000,10000 (about 107 degrees in World), then CDTEXTSEG. Record the rotation and take a screenshot. It reads the right way up on screen only if the rotation is about 107 degrees, not about 287.
   - **Control:** the same with the switch off before launch.
3. **Codex look:** one screenshot of the steep-pipe case in the turned view.

**8. Verdict**

1. **#1888: KEEP-WITH-NOTE.**
2. **Train:** Civil C-79, pipe labels area plus smoke.

---

## What I could not verify

1. **Combined merge:** whether all four Civil PRs merge together in one tree. I checked every pair, and the release branch against each one. A chained merge needs a git write, which the brief forbids.
2. **Settings count tests:** whether a settings-count or switch-list test fails only when the three new switches are combined. Each PR's own full Civil run passed, apart from the two known IL tests. The stacked train needs its own full run.
3. **Label creation convention:** whether CD's own label creation in a turned UCS judges which way up in World (relevant to finding D).
4. **The 30 October CD_Settings.json change:** what wrote it.
