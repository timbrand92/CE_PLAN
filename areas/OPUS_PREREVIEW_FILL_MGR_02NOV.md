# Opus pre-review FILL-MGR: Manager PRs #1836 (BUG-090), #1473 (BUG-851) and #1515 (BUG-478 slice 2, stacked on #1508)

Written Monday 2 November 2026, 15:12 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request (queue filler 6).
Newest release branch checked: claude/rel-20261112a at ccaf0783 (C-79c finalizer), and claude/rel-20261108a at cf059dcf (Civil 3.0.90, C-79b1), both confirmed with `git ls-remote` at the time of review.
Heads reviewed: #1836 3db30bfe, #1473 09cbed4a, #1515 dbf85cd2, and its parent #1508 c62d4344. All four are still OPEN and DRAFT on GitHub.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the PR text, the carpark entries, the code on the newest train and the shipped plug-in manifests. I ran read-only `git fetch`, `git ls-remote`, `git merge-base` and `git log` only.

## FOR TIM

1. **The main finding: all three are already in your installed CE. The queue listed them by mistake.** Each draft was merged into a release some time ago and never closed on GitHub. #1473 went out in Manager 1.1.57 (19 Oct). #1508 and #1515 went out in 1.1.69 (22 Oct). #1836 went out in 1.1.86 (29 Oct). So this is a check of code already shipped, not a check before shipping.
2. **#1836, the About CE Suite window (CE_VERSION) now grows to show every row (BUG-090): KEEP-WITH-NOTE, Manager area + smoke.** Before, the AutoCAD row was cut in half and the Runtime row was missing. Now the window gets taller to fit them, and its width stays the same. Note: on 29 Oct you said "ce version should just be within cemanager from now on". This fix is a stopgap until that move happens. Nobody has looked at the window since it shipped.
3. **#1473, "Disable on Restart" in CEMANAGER switches off only the CE tools, not the pipe-object file (BUG-851): KEEP-WITH-NOTE, Manager area + smoke.** Example: you disable Civil and restart. A drawing with CE pipes should still show real pipes with grips, not grey boxes. It changes one file only, the plug-in's list of files to load (PackageContents.xml). It renames, moves or deletes nothing. It has no Settings switch, so the old behaviour cannot be brought back with one setting.
4. **#1515, the rule for when Manager may finish a ready update (BUG-478, part 2 of 3): KEEP-WITH-NOTE, Manager area + smoke.** It is a rule only. Nothing in CE uses it yet, and its switch has no Settings row. You will see no change. The step that would actually start the installer is still to be written. Opus said earlier that step needs your word before it starts.
5. **The #1508 and #1515 stack is sound.** #1515 includes #1508's fix round. Both went into the same release in the right order (#1508 first).
6. **Nothing clashes with anything else.** All four commits are already on every current release branch, so merging them again would change nothing.
7. **Recommendation:** CE 05 closes the four drafts on GitHub as "merged by the release train" so they stop coming back in the queue. That needs your OK or CE 00's, because it is a change on GitHub. I have not done it.
8. **Not proven:** nobody has opened the About window since 1.1.86. Nobody has used Disable on Restart with a pipe drawing in AutoCAD. BUG-090, BUG-851 and BUG-478 all stay OPEN.

---

## DETAIL

### Group facts

1. **Where each PR went (from the merge commits on claude/rel-20261112a):**
   1. #1473 head 09cbed4a, merged d285e4b8 "Merge pull request #1473 (head 09cbed4a) into claude/rel-20261019b", 19 Oct 21:33. First release: C-46, Civil 3.0.57 / Manager 1.1.57 (0bbf4882). The carpark says "fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1473". That does not contradict the merge date: 1.1.70 is probably the first build installed on your PC that included it.
   2. #1508 head c62d4344, merged 9c6058a4 into claude/rel-20261022l, 22 Oct 10:29. #1515 head dbf85cd2, merged 919161f0 five seconds later. First release: C-59, Civil 3.0.69 / Manager 1.1.69 (375a4ebc).
   3. #1836 head 3db30bfe, merged 77c11854 "Merge PR #1836 (BUG-090) at 3db30bfe", 29 Oct 10:30. First release: C-76, Civil 3.0.86 / Manager 1.1.86 (5888ee75). RELEASE_SCOREBOARD line 128 records it as kept in C-76, "needs a Codex look".
2. **Changes since merge (`git diff <head> rel-20261112a`):**
   1. CeVersionWindow.xaml and .xaml.cs: unchanged since #1836.
   2. CePluginRegistryService.cs: two later changes in other parts of the file. Lines 320 (NETLOAD now goes through CeManagerCommandSender, BUG-1017) and 586/592 (the words "Settings" and "Repair Centre"). The #1473 lines 236-301 are byte-for-byte as reviewed.
   3. CeFinishUpdateStartRule.cs line 36: the waiting message was later reworded from "It will finish when every AutoCAD window on this PC is closed." to "Close every AutoCAD window on this PC, then ask your CE administrator to finish the update." That is more honest, because nothing finishes the update yet.
3. **Opus history:** #1508 had Opus review 1546 and #1515 had Opus 1547 (PR comments of 21 Oct). Their fix rounds are in the merged heads. #1836 and #1473 have no Opus comment on GitHub. This is their first Opus look, and it comes after shipping.

---

### #1836: About CE Suite window grows to fit its rows (BUG-090), switch `aboutWindowFitsItsRows`, ON

1. **What changes for the drafter.**
   1. You type CE_VERSION and get the About CE Suite window. Before, it was fixed at 470 x 390 px and could not be resized (CeVersionWindow.xaml lines 6-8). The rows need about 415 px of content, so the AutoCAD row was cut and the Runtime row and hover hint were missing.
   2. Now CeVersionWindow.xaml.cs line 19 calls `FitToRows`, and lines 28-33 set `SizeToContent.Height`. The window becomes as tall as its rows. The width stays 470, and the XAML file is unchanged.
   3. Is it what was asked? The carpark Expected behaviour is "every loaded module row, AutoCAD/runtime row ... readable ... The window may grow/scroll rather than hide evidence". The row half is covered. The other half, "exact source/deployment identity" (the source commit), is not part of this PR. The PR says so itself (item 7).
   4. **Your decision of 29 Oct (carpark BUG-090, H31):** "ce version should just be within cemanager from now on". This PR does not move CE_VERSION into CEMANAGER. On the newest train, PluginManagerCommands.cs line 33 still opens CeVersionWindow. It is a sound stopgap until that move is built, and it does not conflict with your decision.
2. **Switch.**
   1. The key is in Manager's switch file, `%APPDATA%\CE_SUITE\manager-switches.json`, not in CD_Settings. It is read each time the window opens (CeOneGlanceStatus.cs lines 309-337 on the train), not at AutoCAD start. So the "both start-up reads" idea does not apply here; there is one read, when the window opens.
   2. Default ON, per R-27 (a switch guarding a bug fix ships ON). No file, a broken file, a missing key or any value other than a plain false all read ON. This is pinned by the PR's own 15 tests and by C76ManagerSwitchDefaultsTests.cs, added by the C-76 finalizer. That finalizer test also proves the new key does not change any of the seven earlier Manager switches.
   3. OFF gives `SizeToContent.Manual`, so the XAML's own fixed 470 x 390 applies. That restores the old window exactly.
   4. There is no row in any window for the Manager switches. Turning this off means editing the JSON file by hand. That is the same as the other seven Manager switches, so it is not new.
   5. No engineering value is involved, so R-00 does not apply.
3. **No hard blocks (R-27):** none added. The window was already modal (`Application.ShowModalWindow`, PluginManagerCommands.cs line 33), and it only shows information.
4. **Native protection and REDO:** nothing in the drawing changes, and no Undo step is added. The REGRESSION_LOG entry says the BUG-1085 "no Undo step" guard still passes; I did not run it. No protected file is touched.
5. **Merge and stack:** a single commit on rel-20261026z (0 behind at the time). Already on every current train, so there is nothing to merge. No other PR in this group touches CeVersionWindow or CeOneGlanceStatus.
6. **Tests.**
   1. On the base, the new tests would not even compile, because `FitToRows` and the switch reader do not exist there. So "red first" is automatic.
   2. The meaningful one is `TheOldFixedWindow_IsShorterThanItsRows_SoTheBottomRowsAreCutOff` (test file lines 42-54). It measures the real window's rows with the switch OFF and shows they need more than 390 px. That reproduces the fault without AutoCAD.
   3. **Real %APPDATA%:** `TheWindowAsBuilt_FitsItsRows_WithTheDefaultSwitch` calls the reader with no path. It depends on the test project's override, which points DefaultPath away from the real switch file (comment at CeOneGlanceStatus.cs, "Tests only: when set, DefaultPath returns this instead of the real %APPDATA% file"). The file test uses a temp folder. I found no test touching your real files. I did not run the tests.
   4. Minor wording mismatch: the code comment says the rows need "about 480 pixels" (xaml.cs line 25), but the log and the test measure 415 px. It is harmless, but one of them is wrong.
7. **Not proven, and the AutoCAD scenario.**
   1. Nobody has looked at this window since 1.1.86. The C-76 runner report (RUNNER_C76_PROOFS_REPORT line 72) lists BUG-090 as "Not run ... a window, out of scope".
   2. **Codex look (a re-run of D8-01):** in AutoCAD 2027 with Manager 1.1.86 or later, type CE_VERSION.
      - Right result: Civil Suite, Structural Suite, Suite Manager, AutoCAD (for example 26.0) and Runtime (for example .NET 10.0.x) are all readable in full. The line "Hover over a version to see which file was loaded." and the Close button show. There is no blank band at the bottom.
      - Repeat at 150 % Windows display scaling, if the Codex PC allows it.
   3. **Robot (CE 02):** it can read the window's text through UI automation (AutomationId "AboutCE"). It can check that the Runtime row text exists and that the window height is more than 390. Being able to read the text does not prove it is visible on screen, so the Codex look is still needed.
8. **Verdict: KEEP-WITH-NOTE.** Notes:
   1. It is already shipped; close the draft PR.
   2. It is a stopgap under your 29 Oct decision to move CE_VERSION into CEMANAGER.
   3. The source-commit half of BUG-090 is not addressed.
   4. Fix the 480/415 comment when the file is next touched.

   **Train class: Manager area + smoke** (already carried by C-76).

---

### #1473: Disable on Restart switches off the plug-in DLL only (BUG-851), no switch

1. **What changes for the drafter.**
   1. CEMANAGER > Civil > Disable on Restart (PluginManagerWindow.xaml.cs lines 559-580 call `TrySetLoadOnStartup`).
   2. Before, every ComponentEntry in Civil's PackageContents.xml was set to `LoadOnAutoCADStartup="False"`. That included the pipe-object file CE_CVL_OBJECTS_2027.dbx and the grip file CE_CVL_NATIVE_GRIP_2027.arx, so a drawing with CE pipes would open with grey proxy objects.
   3. Now, when switching off, only the entries returned by `MainDllEntries` change (CePluginRegistryService.cs lines 240-253 and 273 on the train). Those are the entries whose file name equals the plug-in's own DLL name, or, if that name is unknown, every `.dll` entry.
   4. Switching back on sets every entry to True (line 273). That also repairs a manifest an older Manager switched off completely.
   5. This is exactly the carpark's Expected behaviour: "Only the main CE_CVL_SUITE.dll entries change; the object and grips files keep loading."
2. **Which files it can change (question 4, read with extra care).**
   1. **Exactly one file per click:** the `PackageContents.xml` of the bundle shown in CEMANAGER (`descriptor.ManifestPath`, set at line 392). The bundles are found under `C:\ProgramData\Autodesk\ApplicationPlugins`, `%APPDATA%\Autodesk\ApplicationPlugins` and `%LOCALAPPDATA%\Autodesk\ApplicationPlugins` (lines 336-343).
   2. **It changes only the `LoadOnAutoCADStartup` value** on the chosen entries, then saves the file again: UTF-8 with a byte-order mark, two-space indent (lines 280-288).
   3. **It renames nothing, moves nothing, deletes nothing.** It does not touch any .dll, .dbx or .arx file, CE_SHARED, CD_Settings or project data. No protected file is touched.
   4. **Earlier risk, not new with this PR:** line 287 rewrites the manifest in place (`XmlWriter.Create(path)` empties the file and then writes it). If the PC lost power or the disk failed during that write, the manifest could be left empty or broken, and AutoCAD would then load nothing from that bundle at the next start. The same code was there before #1473. It is LOW, and worth an ideas-inbox line: write a temporary file, then swap it in.
3. **Checked against the real shipped manifests on the newest train.**
   1. **Civil (Installer/PackageContents.xml):** three entries, CE_CVL_SUITE.dll in Legacy, Net8 and Modern, all with the same file name, so all three lanes are switched off. The .arx and .dbx entries are left on. All five ship `True`, so "switch on sets every entry True" puts back exactly the shipped state.
   2. **Structural and Manager:** DLL entries only, in three lanes with one file name each. For those two the behaviour is the same as before.
   3. **Reading the state back (lines 459-477):** Manager decides "on or off" from the first entry in the current runtime lane. In Civil's Modern lane the DLL entry comes before the .arx and .dbx, so after Disable Manager correctly reads Civil as off. This depends on the order of the entries. If a future manifest lists the .arx or .dbx first in a lane, Manager would show Civil as still on after Disable. **Note for whoever edits the Civil manifest.**
   4. **CE.Host manifest (CE.Host/Installer/PackageContents.xml, the future one-bundle host):** all nine entries are `CE.Host.dll`. If that bundle is ever listed in CEMANAGER, Disable on any one module would switch off all three, Manager included. The old code did the same, so this is not a regression. It matters only when CE.Host ships.
4. **Switch (question 2):**
   1. There is none. The PR says "no Settings key". Under R-27 a switch guarding a bug fix would ship ON. Without one, the old "switch everything off" behaviour cannot be brought back from Settings, only by reverting the code. Since this shipped in 1.1.57 and nobody has reported a problem, I do not ask for a switch now.
   2. No engineering value is involved.
5. **No hard blocks:** none added. The existing warning box when the file is read-only (lines 568-574) is unchanged and is a warning after a failed action, not a refusal.
6. **Native AutoCAD protection and REDO:** no drawing is touched. The point of the fix is that drawings holding CE objects keep their real object behaviour while the tools are off. That matches your ruling quoted in the carpark: the object file works with or without the CE ribbon.
7. **Merge:** a single commit on rel-20261019a (0 behind at the time). It shares no file with #1836 or #1515 except REGRESSION_LOG.md, and all are already merged.
8. **Tests:**
   1. CeDisableOnRestartMainOnlyTests.cs has 4 tests on a scratch manifest in the temp folder (SetUp lines 254-269), so nothing real is touched.
   2. The claim "2 of 4 fail on the base" is believable from the code. On the base, switching off set every entry False, so tests 1 and 4 fail; tests 2 and 3 cover switching on, which the base already did. I did not run them.
   3. **Gap:** no test checks that Manager reads Civil as "off" after Disable when the .dbx and .arx are still on. That is the order dependence in item 3.3.
9. **Not proven, and the AutoCAD scenario.**
   1. **Robot or Codex, on a copy bundle only, never your live one:** open CEMANAGER, choose Civil, click Disable on Restart, close AutoCAD and start it again.
      - Right: CEMANAGER shows Civil as disabled, and there is no CE Civil ribbon and no CD commands.
      - Open a drawing that already holds CE pipes. Right: the pipes are real CE objects, not grey proxy boxes. LIST shows the CE type, and the grips appear.
   2. Then click Enable, restart, and check that Civil is back.
   3. Check with Notepad that PackageContents.xml still has all five entries, with only the three DLL lines changed.
   4. **Not known:** whether the grip file (.arx) behaves properly when the CE tools DLL is not loaded. Only that run can show it.
10. **Verdict: KEEP-WITH-NOTE.** Notes:
   1. It is already shipped; close the draft PR.
   2. Reading the state back depends on the order of entries in the manifest (item 3.3).
   3. The earlier in-place rewrite of the manifest is a LOW idea for the inbox (item 2.4).
   4. There is no switch to bring the old behaviour back.

   **Train class: Manager area + smoke, with one restart case** (already carried by C-46).

---

### #1515: start decision for a ready update (BUG-478 slice 2), switch `update.finishWhenAutoCadCloses`, OFF; stacked on #1508

1. **What changes for the drafter: nothing yet.**
   1. `CeFinishUpdateStartRule.Decide` (CeFinishUpdateStartRule.cs lines 27-38) answers one of four things:
      - Off: the switch is off.
      - NotReady: no plan, or the plan is not ready; it passes on the planner's plain reason.
      - WaitForAutoCad: either of two looks found AutoCAD open, or could not tell (any count other than zero).
      - StartNow.
   2. On the newest train it is called from nowhere: `git grep` finds only its own file and its tests. #1508's planner is the same: only its tests use it.
   3. BUG-478 asks for "a Finish update step that starts the installer with the right folders after AutoCAD closes". This is the decision part of that step. The step itself, the Settings row and the Codex run are listed as still owed.
2. **Switch.**
   1. The key `update.finishWhenAutoCadCloses` (line 25) is only a name. Nothing reads it from Settings yet, and there is no defaults test for it, because there is no reader to test.
   2. The rule treats "switch off" as do nothing and say nothing (test `Decide_SwitchOff_DoesNothingAndSaysNothing`). OFF is the right default for a new feature that starts an installer.
   3. **Owed with slice 3:** a Settings row, a reader, and a defaults test pinning it OFF through both start-up reads.
3. **No hard blocks:** none. An unknown AutoCAD count makes it wait; it never refuses or blocks drafting.
4. **Native protection and protected files:** nothing touches the drawing or any protected file.
   1. The real risk is in slice 3, which will start an installer that replaces the live bundle.
   2. Opus 1547 already asked for a separate helper that keeps running after AutoCAD closes, a signature check, and your word before that slice starts. Those notes are carried in the queue file (PR comment, 21 Oct 05:21).
   3. The rule asks for two looks but does not set the time between them. The caller in slice 3 must space them out.
5. **The stack (question 5): sound.**
   1. #1515's history is: slice 1 a691708d, then slice 2 e31c66dc, then a merge of #1508's fix round c62d4344 (dbf85cd2 "keep both log entries"). So #1515 contains #1508 exactly as #1508 stands.
   2. Both were merged into rel-20261022l in order (#1508 at 9c6058a4, then #1515 at 919161f0), with no gap and no duplicate commit.
   3. #1508's base, rel-20261020k, moved on by one commit after the PR was cut. That did not matter, because the train was assembled from the heads.
   4. No other PR in this group touches these files.
6. **Tests:**
   1. CeFinishUpdateStartRuleTests.cs has 9 cases (with #1508's 7, that makes 16). The PR admits "tests and rule were written together; not run against an empty rule". On the base the class does not exist, so the tests cannot compile there.
   2. The cases match the rule line for line, including "could not check counts as still open" (lines 59-65).
   3. The waiting test checks only that the message contains "AutoCAD", so the later rewording still passes. That is good.
   4. The tests use no files at all, so nothing can touch %APPDATA%.
7. **Not proven:** there is nothing to show in AutoCAD or Manager until slice 3 exists. No robot or Codex case is possible yet. When slice 3 arrives, the run is:
   1. Turn the switch on.
   2. Get update ready on a test PC with a copy bundle.
   3. Close every AutoCAD.
   4. Check that the installer runs once, that the bundle's DLL hash then matches the approved build, and that the rollback folder holds the old copy.
   5. Repeat with AutoCAD left open, and check that nothing starts.
8. **Verdict: KEEP-WITH-NOTE.** Notes:
   1. It is already shipped and does nothing for now; close #1515 and #1508.
   2. Slice 3 (starting the installer) needs your word first, and the Settings row, reader and OFF defaults test.

   **Train class: Manager area + smoke** (already carried by C-59).

---

### What I could not verify

1. I ran no test and built nothing, so every test count here is the author's or the finalizer's report.
2. I did not look at any window or open AutoCAD.
3. I did not check whether editing PackageContents.xml upsets any later signed-content or bundle-health check in Manager or the installer. The behaviour is the same before and after #1473, because both versions edit that file.
4. I did not confirm which Manager build is installed on your PC today.
