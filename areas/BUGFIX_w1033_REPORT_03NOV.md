# BUGFIX w1033 report — BUG-1033 Pump System tab Read-only banner (3 Nov 2026)

## FOR TIM

1. **What you will see:** open CDCALC, go to "Older calculators — Pump System". A banner now sits across the top: "Read-only — an Older calculator, under review before its rules are signed. Use it to check an existing calculation." It is the same style as the WSUD tab. The boxes still refuse typing, as before.
2. **Mistakes of my own:** I put the closing tag of my window change in the wrong tab first (the build caught it at once, nothing wasted beyond one build). Fixed before commit.
3. **NOT proven:** nobody has opened this in AutoCAD. I have not seen whether the banner fits at the 1200 x 820 window size, or whether it squeezes the INPUTS and RESULTS boxes. The unit tests check the switch and that the banner is in the tab; they cannot show the picture. BUG-1033 stays OPEN.
4. **Switch:** `options.pumpTabReadOnlyBanner`, ON. Set it false and restart AutoCAD to get the old tab (no banner).
5. **Robot case that proves it:** N33_pump_banner (to be written by the runner team). It opens CDCALC, presses the Pump System tab, reads the text of control `PumpReadOnlyBanner` and checks it starts "Read-only — an Older calculator". Switch-off control: the same case with `options.pumpTabReadOnlyBanner` false, checking the control is not shown. It also types 7 into Total site area and checks the value is still 321.
6. **Disk-folder check:** one real file changed while my job ran: `TIM_CE_CADTOOLS\CD_RecentValues.json` (13,253 to 13,311 bytes, 19:53). My test run ended 19:46 and my tests never touch recent values, so it was another session or your own AutoCAD. The Manager and Admin folders under `CE_CADTOOLS` and `TIM_CE_CADTOOLS` also moved their last-write time (19:44 to 19:45), the same cause is likely; I ran no Manager tests. Say if you want that checked.

## Technical

1. **Confirmed on base 3fbb9da5 (origin/claude/rel-20261102a):** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml` Pump tab (line 780 onward) had a tooltip only; the WSUD tab's banner is at about line 1024.
2. **PR:** #2011 (draft), base claude/rel-20261102a, branch claude/w1033-pump-readonly-banner, one commit. Title starts B-198.
3. **Files:** CalculationsV2Dialog.xaml (Pump tab wrapped in a DockPanel, banner docked top, Grid keeps its own DataContext), PumpSystemCalcViewModel.cs (`ShowReadOnlyBanner`), UserSettings.cs (`OptionSettings.PumpTabReadOnlyBanner`, "Default: on."), Bug1033PumpTabBannerTests.cs, REGRESSION_LOG.md. CE_SHARED untouched.
4. **Tests:** `Bug1033PumpTabBannerTests`, 5 of 5 pass on net10 and net48 (net48 compile is the end check); net8 matched none (filter, expected). Covers default on, both start-up reads (DeserializeSettings and DeserializeSettingsTolerant) for `{}` and a file without the key, typed false through both reads, and a source guard. Not added to a shared new-switch-defaults fixture; the new test holds the pin itself.
5. **Run:** one test project, with filter, isolation vars set (TEMP, TMP, CE_LOG_DIR_OVERRIDE under C:\CE_WORK\scratch\w1033), slot count 0, C: free 73 GB.
6. **Real-folder listings** before and after: `C:\CE_WORK\scratch_w1033_before.txt` and `scratch_w1033_after.txt` (differences as in FOR TIM item 6; the CS_Settings.json of Structural is unchanged at 35,613 bytes, 30 Oct).
7. **Open for CE 01:** the banner wording is mine (the WSUD text plus "Use it to check an existing calculation"); Codex should check the look at 1200 x 820.
