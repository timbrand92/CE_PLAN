# TOOL NOTE: Help (CDHELP)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the CE Civil help guide,** at the section for the last CE command you ran in the last 10 minutes.
2. **On AutoCAD 2027 (and 2025, 2026)** it opens inside AutoCAD; on older AutoCAD it opens in your web browser.
3. **If the guide file is missing,** it says so and shows a small built-in help window.

## 2. What it changes in the drawing

1. **Nothing** in the drawing or CE's record.

## 3. What it will not do

1. **Does not open a web address** unless a Settings switch (off by default) allows it and the local guide is missing.
2. **No start-up checks** (it opens in any drawing).

## 4. What it asks you, and what Enter means

1. **No questions.** Esc closes the guide window. The small fallback window has only a Close button.

## 5. When it says Unknown or "needs checking"

1. **Guide missing or cannot open:** "The CE help guide is missing ..." or "... could not be opened ...".

## 6. How to undo it

1. **Nothing to undo.**

## 7. Known faults

**Still there in this build**
1. **BUG-1217:** Help invites inputs to the Pump System and WSUD calculators, which are read-only.
2. **BUG-1216 (filed under CDRAINFALL):** Help opens at the previous command for CDRAINFALL, CDDESIGN, CDCHECKS, CDRUNSOLVE and several others it does not track.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-555:** no web fallback unless the switch is on (off by default). The company web addresses are still in the command list.
2. **BUG-1215:** Help now says Send report saves a copy and tries the office folder in one step (the CDFEEDBACK window itself still has the old words).
3. **BUG-1220:** Help for Reverse Flow now says no preview window and no Apply button.

**New in code, no bug covers it**
1. **The 10-minute "last command" window** is fixed in code.
2. **On 2022 to 2024 it logs a warning every time** before falling back to the browser.

## 8. On AutoCAD 2022 to 2024

1. **Opens in the web browser,** not inside AutoCAD.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 7 new 1:** `Commands\CdCommand.cs:1575-1580`; `Services\HelpLauncher.cs:24-84`; `Services\CdHelpService.cs:28, 100-126`.
2. **1.2, 8.1, 7 new 2:** `HelpLauncher.cs:37-69` (`#if NET8_0_OR_GREATER`).
3. **1.3, 5.1:** `CdHelpService.cs:145-166`; `Services\HelpWebFallbackRule.cs:22-31`.
4. **2.1, 3.2:** no record update or `CommandPreFlight` on this path.
5. **3.1, 7 BUG-555:** `Models\HelpSettings.cs:14`; `CdHelpService.cs:147-148`; `HelpLauncher.cs:79`; `Assets\Config\command-registry.json:26, 34, 54`.
6. **4.1:** `Dialogs\CivilHelpGuideView.xaml.cs:142-143`; `Dialogs\CdHelpDialog.xaml:184`.
7. **7 BUG-1217:** `Assets\Help\guide-content.js:64`; `Dialogs\CalculationsV2Dialog.xaml:780, 1005`.
8. **7 BUG-1216:** `CdHelpService.cs:40-53`.
9. **7 BUG-1215:** `guide-content.js:100`. **7 BUG-1220:** `guide-content.js:103`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:03. Nothing was run in AutoCAD.
