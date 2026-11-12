# Re-review: draft PR 2038, `claude/trust-core-ribbon-e13111` (step 2, the two-tab core ribbon)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:54 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 5b6747a1 b4c46bd3` (the one review-fix commit since my last review; 5 files), the branch's `CeCvlRibbonContributor.cs` (today's words the fix now reuses), `StandaloneCivilRibbonService.cs`, PR 2038's description, the earlier review `reviews\claude-trust-core-ribbon-e13111.md`, and the command list at `C:\CE_WORK\scratch\audit_civil` (cf059dcf). Line numbers are at `b4c46bd3`.

---

# FOR TIM

1. **All five things the last review asked for are done:** Floor Waste and Pit Schedule are off the new tabs, buttons keep today's tooltip words, and New Job is left off on AutoCAD 2025 and 2026.
2. **Two tooltips would now say something untrue:** Pit and Generic Source would describe "the arrow" of a drop-down that the new plain button does not have.
3. **With the switch off your ribbon is still exactly today's.**

**Verdict: GO** for the robot's layout checks and Codex's look on copies, with the two tooltip lines fixed before Codex reads the tooltips (small, item 2.1). Not a merge or install decision. Built yes (lane: net48, net8, net10 clean). Tested unit only (lane: 123 ribbon and settings tests on net10; net48 and net8 tests not run; not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **Floor Waste and Pit Schedule off, fault lines current: FIXED.**
   1. `CeCvlCoreRibbonList.cs` 52 (CDFW) and 88 (PITSCHEDULE) are `show: false`, each with a DRAFT note that one word puts it back. The test `FloorWasteAndPitSchedule_AreInTheList_ButOffTheTabs_TillFixedAndProven` checks both the list and the built tab.
   2. "Known fault, being fixed" is gone; the words are now "Known fault: ..." and name the real state (BUG-650 fix in the installed code, unproven; BUG-1255 workaround, unproven; BUG-1274 open). The Move + Rotate and Copy + Rotate lines now say plainly they move plain AutoCAD objects only on 2027.
2. **Keep today's plain tooltips from one place: FIXED, with one new problem (2.1 below).**
   1. `CeCvlCoreRibbon.TodaysWords` (`CeCvlCoreRibbon.cs` 93) builds today's one-tab layout and its three pop-up tabs and takes each button's words by command. It calls the one-tab builder `GetPanels(checks)` directly, not the switch-aware one, so it cannot loop back into the core tabs.
   2. A button's own short line in the list wins only where the list gives one; I checked the eight new lines (PP, GIO, CDTG, CDRG, CDSOURCE, CDTAG, CDSTRIP, CDAGI): today these are drop-down children with no words of their own, so today they fall back to the command list's description. The new lines are plain. Not a second copy of anything that exists.
   3. The test `ButtonsKeepTodaysPlainTooltips_FromTheOneTabLayoutsOwnWords` checks that each long tooltip starts with today's words and bans the six software phrases the last review quoted.
3. **New Job on AutoCAD 2025 and 2026: FIXED.** `IsBuiltHere` (`CeCvlCoreRibbon.cs` 78) leaves the button off unless the build is the 2027 one; the test `EveryShownButtonsCommand_IsARealTypedCommandInThisBuild_NotJustInTheSourceText` now reads the typed commands out of the built plugin, not the source text. Not run on the 2025/2026 build (the lane ran net10 tests only), so the "left off" half is proven by reading, not by a test run.
4. **Test names that claimed more than they checked: FIXED.** The Shared-file test is renamed to what it checks (the menu file) and says so; the old-layout test now runs with the core switch ON; the broken twin now runs the same comparison helper on the real layout and must throw; the picture test now follows the ribbon's own two steps and fails on a blank or generic picture not on a named list of five.
5. **The two failing IL tests: NAMED, not checked by me.** The change log names `FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`, and says both fail on a Debug build of the installed code with no change and pass on Release (2 of 2). That matches what trust-foundations found. I did not run them.
6. **Also done from "Worth knowing":** a fault building CE Design no longer takes the first tab or the pop-up tabs down (`StandaloneCivilRibbonService.cs`, its own try); CE Design shows nothing if the older three-tab switch is turned on later (`CeCvlCoreRibbon.cs` 171).

## 2. New findings

1. **Two long tooltips describe a drop-down arrow that is not there (fix before Codex reads tooltips).**
   1. Where a command appears more than once today, `TodaysWords` keeps the copy with the longest long tooltip (`CeCvlCoreRibbon.cs` 103-107). For two commands that copy is today's drop-down face:
   2. **Pit** (`CeCvlCoreRibbonList.cs` 35, a plain large button) would get today's gallery words: "The face opens the full Pit window. The arrow drops the preset gallery: PP plastic 350 first, then 350 / 450 / 600 / 900 / 1200 concrete." (`CeCvlRibbonContributor.cs` 73-74). The new button has no arrow and no gallery.
   3. **Generic Source** (`CeCvlCoreRibbonList.cs` 58, a plain button) would get the "More sources" split's words: "The face opens the Sources card on the type strip. The arrow lists the rarer types directly." (`CeCvlRibbonContributor.cs` 98-99).
   4. Fix: when the core button is a plain button, skip a copy that has a gallery or drop-down children (or give these two their own long line in the list), and add both to the tooltip test.
2. **A bug number in a drafter's tooltip.** Front Overflow's fault line ends "(BUG-1236, open, no fix queued yet)" (`CeCvlCoreRibbonList.cs` 49). A drafter does not know what BUG-1236 is; "not yet fixed" says the same. Small.
3. **The change log still credits Tim for leaving the 2022 to 2024 menu alone.** Item 6 says "(Tim, 12 Nov: the first colleague is on 2027)"; the list file now correctly says it is the plan chat's reading of answer A3. One line to align. Small.

## 3. Worth knowing (not blocking)

1. **"CDSYSTEM has no picture at all"**: the Pipe System button on CE Design would be an empty square. It is on the named gap list, so the test allows it; Codex's look should expect it.
2. **CE Design with the older three-tab switch on:** the standalone ribbon skips the tab; Manager's later rebuild would build CE Design with no panels. Whether Manager then shows an empty tab is not checked. No Settings row exists for that switch, so unlikely.
3. **Card 2.1 and 3.2 still not done** (on-screen word when the switch changes; the 2022 to 2024 menu reading the same list). The PR says so.

## 4. Not checked

1. Did not build or run any test; every count is the lane's.
2. Did not see either tab: fit at normal and narrow widths, pictures, tooltips as drawn.
3. The 2025/2026 build's tests (not run by the lane either).
4. Manager's rebuild with two Civil tabs (code read only, earlier run).
