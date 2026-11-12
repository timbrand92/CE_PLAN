# Review: draft PR 2038, `claude/trust-core-ribbon-e13111` (step 2, the two-tab core ribbon)

**Reviewer:** lane trust-review (second run), 12 Nov 2026, 23:40 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO here would be evidence, not acceptance.
**What was read:** `git diff cf059dcf...origin/claude/trust-core-ribbon-e13111` at head `5b6747a1` (two commits, 9 files), `gh pr view 2038`, card `04_REFERENCE\ux-plan\cards\TRUST-02_CORE_RIBBON_CARD_DRAFT_2026-11-12.md`, `areas\CIVIL_COMMAND_SORT_06NOV.md`, and the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf).

---

# FOR TIM

1. **With the new switch off, your ribbon is exactly today's.** I checked the code path and the new test that pins all 9 panels and 49 buttons in order; a moved button would fail it.
2. **With it on, 38 of the 47 buttons lose today's plain tooltips** and show older wording with software words in it. Floor Waste and Pit Schedule are on the tab, though the card recommends them off.
3. **New Job would be a dead button on AutoCAD 2025 and 2026,** because that command only exists in the 2027 build.

**Verdict: FIX FIRST** (five items below). Built yes (by its lane). Tested: unit tests only, by its lane; I did not run them. Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Switch off = today's ribbon, button for button: YES, proven as far as code and unit tests can.**
   1. The only change on the off path is a choice at `CeCvlRibbonContributor.cs` (TabTitle, GetPanels): with the core switch off it calls the same unchanged `GetPanels(checks)` as cf059dcf.
   2. `CeCvlCoreRibbon.DecideAtStartup` registers nothing when off, so the ribbon builder finds no second tab (`StandaloneCivilRibbonService.cs`, new block uses `SingleOrDefault` on a registry that refuses duplicate ids, `Shared\CE_SHARED\Services\CeRibbonRegistry.cs:26`).
   3. `CeCvlTodaysRibbonUnchangedTests` compares 58 lines (panel title, collapse order, drawing type, launcher; button command, words, keytip, size, split face, drop-down and gallery commands) as an ordered list. I compared its list with cf059dcf `CeCvlRibbonContributor.cs:45-279`: it matches. A moved, missing or extra button fails it, and `SwitchOn_TheReadBackDiffers` shows the comparison can fail.
   4. It does not compare tooltip text or button pictures. Those paths are unchanged in the diff, so that is acceptable.
   5. Tests read a temporary settings folder, not your real file (`SettingsService.cs:46-56`), so the result does not depend on your own switches.
2. **One easy list: YES.** `Services\CeCvlCoreRibbonList.cs` lays out both tabs; a button moves by moving one line. The test keeps a deliberate second copy so any move is on purpose.
3. **Every placement resting on an open question marked DRAFT: YES.** All 47 buttons match the Civil sort exactly (6 + 11 + 11 + 2 + 2 + 6 + 9). Civil sort questions 3 to 11 and card decisions 2 to 7 each carry a "DRAFT default, Tim to confirm" note. One attribution is wrong, see item 6.
4. **`Shared\CE_SHARED` changed: NO.** The diff touches no Shared file, so Civil and Manager stay byte-identical.
5. **Pipe, Pit and Source pop-up tabs still appear: YES by the code.** The contributor still supplies them, and the new block sits before `if (classic)`, so the pop-up branch is still reached when the old-tabs switch is off. Not seen in AutoCAD.
6. **New words a drafter sees in plain words: MOSTLY, but see FIX FIRST 2.** The new button words and the fault lines are plain; the fallback tooltips are not.
7. **No existing test weakened: YES.** No existing test file is changed; two new test files only.
8. **Regression log in drafting words: PARTLY.** Items 1, 5, 6 and 10 are drafting words. Items 2 to 4 and 7 to 9 lean on code names (contributor, byte-identical, `git revert`). Item 1 says "AutoCAD 2025 or later", which is not true for New Job (FIX FIRST 3). Item 7 repeats a test claim that is not what the test checks (FIX FIRST 4).

## 2. FIX FIRST

1. **Follow the card's recommended answer for decision 4, or record why not.**
   1. Card decision 4 recommends CDFW and PITSCHEDULE **off** until fixed; the run rule is "cards are built on the recommended answers" (`TRUST_AUTONOMOUS_RUN_12NOV.md` 2.3). The list has both `show: true` (`CeCvlCoreRibbonList.cs`, the CDFW and PITSCHEDULE entries).
   2. The two fault lines are also out of date. The installed code already holds a fix for BUG-650 (`Commands\FloorWasteCommand.cs:41-45`, `Services\ProjectDataService.cs:964-992`, re-read by me) and a workaround for BUG-1255 (`Models\UserSettings.cs:3643`, switch on; `PluginInitialization.cs:61`). Neither is proven in AutoCAD.
   3. "Known fault, being fixed" claims work that is not queued for FO (BUG-1236). Plain status words such as "Fix in this build, not yet proven in AutoCAD" are truer.
2. **Keep today's plain tooltips.**
   1. Today each button carries hand-written short and long tooltip words (cf059dcf `CeCvlRibbonContributor.cs:51-171`). The core list passes words for only 9 buttons; the other 38 fall back to the command list's description (`Item()`, `CeCvlRibbonContributor.cs:352`) and lose the long text entirely.
   2. Examples the drafter would read: CDHELP "Open the task guide, version info and workflow help hub." (today "Open the CE Help Centre."); CDTAG "... into the CE data model."; CDINSPECTOR "Open the CE Inspector context palette."; DP/IO/OF "... source block and auto-tag it."; CDPROFILE "... longitudinal-section block ...". Lost long text includes CD's "Enter accepts the default" and CDTIDYLABELS's "One Undo puts every label back".
   3. Fix: reuse today's words per button from one place (design rule 1), not a second copy.
3. **New Job on AutoCAD 2025 and 2026.**
   1. `CDNEWDWG` is compiled only for the 2027 build (`Commands\NewJobDrawingCommand.cs:1`, `#if NET10_0_OR_GREATER`). The 2025/2026 build (net8, `CE_CVL_SUITE.csproj:4`) has a ribbon but no such command, so the left-most button would answer "Unknown command".
   2. `EveryListedCommand_..._IsATypedCommandInTheCode` searches the source text, so it passes anyway.
   3. Fix: leave the button off where the command is not built, or say "AutoCAD 2027 only" on it; make the test check per build.
4. **Tests whose names claim more than they check.**
   1. `SharedAndTheTwoToTwentyFourMenuAreNotTouchedByThisDraft` only checks that one Shared file exists. Regression log item 7 repeats "CE_SHARED contract ... untouched". (Shared is in fact unchanged; I checked the diff.)
   2. `ClassicLayoutIsStillKeptBehindItsSwitch_EvenWhenTheCoreSwitchIsOn` forces the core switch off.
   3. `ADeliberatelyWrongList_IsCaught` removes a button from an array and compares it with the expected list; it proves the comparison works, not that the code is caught.
   4. `ListedCommands_..._EveryButtonResolvesAPicture` checks only that a picture name is set; a missing picture falls back to "tool" (`CeCvlRibbonContributor.cs`, `ResolveIconKey`), so it cannot fail.
   5. Fix: rename them to what they check, or make them real (for example compare the Shared files' hashes with cf059dcf; run the classic test with the core switch on).
5. **Name the two failing tests and compare them with cf059dcf.** The lane reports two failures in `SourceAtomicCoordinatorDependencyTests` "not yet compared against the baseline". They read compiled IL of source-placement methods. Lane trust-foundations reports (PR 2041) that two tests in that class fail on a Debug build with or without any change and pass on Release, so pre-existing is likely; the core-ribbon lane should confirm the names match and re-run on Release (RULES 6.1).

## 3. For the controller (plan and card text, not code)

1. **The card and the plan still name the wrong way back.** Card TRUST-02 2.9, 3.1 and 4.3 and `trust-plan.md` step 2 item 5 say "Show the old CE tabs" is the undo. It is the older three-tab layout (`Models\UserSettings.cs:2302`). The way back is the new switch off. The builder already corrected its own words.
2. **Two card requirements are not done** and are only partly recorded: card 2.1 (say on screen when the layout switch is changed; there is no Settings row, so nothing can say it) and card 3.2 (the 2022 to 2024 menu reads the same list).
3. **"Tim, 12 Nov" is cited for leaving the 2022 to 2024 menu alone** (`CeCvlCoreRibbonList.cs`, last tab-level default). Tim said the first colleague is on 2027 (A3); leaving the menu is the controller's INTERPRETATION (`TRUST_PLAN_INTERVIEW_12NOV.md` line 96). The wording should say so.
4. **BUG-650 looks already fixed in the installed build** (see FIX FIRST 1.2). Step 4's queue lists BUG-650 as a fix to lift; it may need AutoCAD proof rather than new code.

## 4. Worth knowing (not blocking)

1. **Move + Rotate and Copy + Rotate on the Pipes panel cannot move a pipe on 2027.** The 2027 transform accepts eight plain object types by exact type (`Modules\Shared.Transform.Native2027\TransformCommands.cpp:157-167`, re-read): it refuses the CE pipe object, its outline, callouts and hatches. "Does not work on every object yet" undersells it; putting them on Pipes (a DRAFT default) is questionable.
2. **Visible renames and keytip moves** a drafter will notice: "Help Centre" to "Help", "Profile" to "Long Section", "Check Current Drawing" to "Check this drawing"; Rainfall keytip RF to RA; CK moves to Check this drawing. Fine for a draft; list them for Codex's look.
3. **Old-tabs switch turned on mid-session:** the core answer is fixed at start-up but the old-tabs switch is read live, so a later Manager rebuild would show "CE Civil" with "CE Design" beside it. Unlikely (no Settings row).
4. **One try block:** if building CE Design throws, the pop-up tabs are not registered either (`StandaloneCivilRibbonService.cs`, the new block shares the build's try). Low risk.

## 5. Not checked

1. Did not build or run any test; the lane's counts (17 + 3 new, 22,183 passed) are its own.
2. Did not see either tab; panel fit, pictures and narrow widths are unseen.
3. Manager's rebuild with two Civil tabs, and tab order when Structural builds first, were read in code only (`Modules\Manager\Services\CeUnifiedRibbonService.cs:157-172`).
4. The net8 (2025/2026) build was not built or read beyond New Job.
5. The click log and the MCP tool listing that also reads ribbon tabs (`CeMcpServerService.cs:75`) were not checked with the switch on.
