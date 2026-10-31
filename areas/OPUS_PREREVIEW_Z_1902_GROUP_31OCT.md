# Opus pre-review Z: PRs #1902 to #1909 (Structural S-series: B-082, B-083, B-084, B-087, B-088)

Written Saturday 31 October 2026, about 10:00 Melbourne time, by an independent read-only Opus reviewer for CE 00 (brief from CE 05).
Base checked: `claude/rel-20261026s` at 204dfad2 (Structural 1.0.125). Every PR in the group is exactly one commit on that tip, so each one on its own merges cleanly.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the five author reports (BUGFIX_s6, s7, s8, s11, s12), the carpark entries and the 29 Oct decisions file, and ran read-only merge checks. I did not read or write any settings file.

## FOR TIM

1. **#1902 SBEAM window (small figures, length in mm): KEEP-WITH-NOTE, Structural area + smoke.** Ix 0.04 shows 0.04, and 6000 in the length box gives 192 kg. One wording fix: the three switches are not on the Settings page, but a damaged-file message would tell you to look for them there.
2. **#1903 XCLMTXT office UB/UC spelling rows: KEEP, area + smoke.** A row such as 250UB26 to 250 UB 25.7 is used again. 250UB26.5 is left alone.
3. **#1904 XCLMTXT writes PLATE for PL everywhere: KEEP, area + smoke.** "TOP PL & BOT PL" becomes "TOP PLATE & BOT PLATE"; PL1 and PL-1 are left alone. It clashes with #1903 in two places; keep both sides.
4. **#1905 SBEAM search finds 410UB59, 460UB75: KEEP-WITH-NOTE, area + smoke.** The matching rule is not the "within 0.5 kg/m" the bug entry asked for (that rule could not find 410UB59). It is the mass cut down or rounded, which you have not ruled on. It never picks a section for you; it only lists it. CEMEMBER and Lysaght names are not done, so BUG-1122 stays open.
5. **#1906 bearer tags and THCL Escape: CHANGE-NEEDED (small), FULL train.** One fault: on a rectangular pad you rotate, the temporary outline you see while picking the text spot is drawn square to the screen, not rotated. Example: 1200 x 600 rotated 30°; the preview sits flat, the real outline lands at 30°. A one-line fix (rotate the preview the same way) before install. The bearer half is right: one label, no extra line.
6. **#1907 RD picks the arc or circle first: KEEP-WITH-NOTE, area + smoke.** Same Settings-page wording fix as #1902. The big unknown is AutoCAD: nobody knows yet whether AutoCAD's own DIMARC, DIMRADIUS and DIMDIAMETER accept the arc CE hands them. Only a robot run can show it.
7. **#1908 BARWEIGHT uses the bar schedule's masses: KEEP-WITH-NOTE, area + smoke.** 100 N20 at 6 m gives 1479.6 kg in both. Same wording fix as #1902. The tests do the sum themselves rather than running BARWEIGHT's own code, so the robot case is the real proof.
8. **#1909 FPFC and FSF keep the typed depth: KEEP-WITH-NOTE, FULL train.** FEDIT should offer 350, and the schedule should show 350, not UNKNOWN. The bug entry asks for a "Modify card" before code; CE 04 should confirm a plain lost-input fix is fine without one. Undo, Redo, save and reopen are not traced. Built and unit-tested only; nothing in this group has been opened in AutoCAD, and no bug is fixed.

---

## DETAIL

### Points common to the whole group

1. **Start-up read.** Structural has one start-up reader, `SettingsService.DeserializeSettingsTolerant`; it tries the normal read and then falls back value by value. The plain `DeserializeSettings` name does not exist on this line (checked: `SettingsService.cs` has no second `static UserSettings Deserialize...`). "Both start-up reads" therefore means the normal path and the value-by-value path of that one reader. Every PR pins its switch ON on a blank file and on a 1.0.125-shaped file. #1902, #1906, #1908 and #1909 also pin a damaged file (the value-by-value path), and #1907 does too in its last case. #1903, #1904 and #1905 pin only blank, old-file and typed-off; they do not force the value-by-value path. That is a small gap, not a fault: the value-by-value path builds from `new UserSettings()`, and each of those tests also pins `new UserSettings()`.
2. **The Settings-page label fault (#1902, #1907, #1908).** `SettingsService.LoadRecovery.cs` has two label tables. `SettingsPageLabels` (line 1282) is for settings that have a box in CESETTINGS. `PlainLabelsWithoutPage` (line 802) is for those that do not. When a settings file is damaged, `SettingLabel` (line 820) sets `OnSettingsPage = true` for the first table. The message then says "Type CESETTINGS to check it" (line 296) instead of "Settings with no page in CESETTINGS stay at their standard value". #1902 (three rows at 1332-1334), #1907 (`Annotation.ArcDimSelectsGeometryFirst`, line 1361) and #1908 (`Options.BarWeightUsesBarCatalogue`, line 1331) put their rows in the page table. None of these switches has a box on the page; I searched `CeSettingsDialog.xaml.cs` and found none. They copied an existing slip: `Options.TimberQuantityAnyNumber` and `Options.ColumnBarsAtRealSize` are already in the page table without a box. #1909 does it right (line 805, plain table). **Fix:** move each row to `PlainLabelsWithoutPage`. Each is a one-line move, and no behaviour changes. #1903, #1904, #1905 and #1906 add no label; they fall back to the plain-words name with `OnSettingsPage = false`, which is correct.
3. **The author reports tell Tim to "untick" the switch in Settings (s6 item 3, s12 items 2 and 3).** There is no box for any of these switches. They are changed only by editing `CS_Settings.json` before AutoCAD starts. The FOR TIM wording in those reports should say so.
4. **No-hard-blocks (R-27).** No PR in the group adds a stop, a refusal or a modal window. The new messages are notes: "That bearer is already selected. It will be tagged once." (#1906), the "not in the bar catalogue" note (#1908) and "(length read as 6000 mm)" (#1902). The RD object pick in #1907 rejects a line or text with AutoCAD's normal "Select an arc, a circle or a polyline arc segment." and asks again. That is a selection filter, not a block.
5. **REDO-safety (BUG-861 rule).** No PR adds a system variable change, a regen or a view change. The new drawing writes are listed per PR below. Each is either a write that already existed, now moved later (#1906 size save), one write removed (#1906 duplicate line), or one more field in the record that was already written (#1909 depth).
6. **Did any test touch the real %APPDATA%?** No new test calls `SettingsService.Current`, `SaveSettings` or a file write. The only `SettingsService.Current` hit is a text string inside a source check in #1905. All settings tests use `DeserializeSettingsTolerant` on an in-memory string. The test assembly also sends every settings path to a temporary folder (`Modules/Structural.Tests/CeStrucTmpRootSetUp.cs`, `CE_STRUC_SUITE_APPDATA_ROOT`). This matters after #1903 and #1904 are merged, because `ExpandMemberAbbreviationCore` then reads `SettingsService.Current` for the PL switch. The authors' real-folder before-and-after listings show no Structural settings file changed. The Civil files that changed are explained by a robot AutoCAD session that was running; I cannot prove that beyond what the authors wrote.
7. **Tests that fail before the fix.** No author ran the new tests against the old code, and #1902 says so plainly. On the old code every new test fails to compile, because the new class or property does not exist, which is a red only in name. The useful guard is the switch-OFF case: where the OFF path reproduces the old fault exactly and the ON path differs, the pair proves the fix. That holds for #1902, #1903, #1904, #1905 and #1908 (the arithmetic only). For #1906, #1907 and #1909 the command flow itself is pinned only by source-text checks or not at all; the robot case is the only real proof.

### 5. Keep-both merge (all PRs)

1. **Against the Structural line `claude/rel-20261026s` (204dfad2):** all eight merge cleanly (`git merge-tree`, exit 0). The Civil line `claude/rel-20261102a` is not relevant: no PR here touches Civil or Shared code.
2. **Inside the group:** every pair clashes on `REGRESSION_LOG.md`, because each PR adds its entry at the top. Keep both, newest first. The only other clashes:
   - **#1903 with #1904:** `Models/UserSettings.cs`. Both add one switch at the same spot in `ExcelSettings` (about line 1032), so keep both. `Services/ExcelMTextService.cs` also clashes: both add a new helper method at the same place, after `ExpandMemberAbbreviation` (about line 5822), so keep both methods. #1904's one-line PL edit inside the method merges cleanly with #1903's new method header.
   - **#1906 with #1909:** `Models/UserSettings.cs`. Both add one switch after `UnknownPadSizeIsNotInvented` in `FootingWidthSettings` (about line 1401), so keep both.
   - #1902 with #1905 both edit `SteelSectionPickerDialog.xaml.cs` at different places (lines 423 and 571-664) and merge cleanly. #1902 and #1908 add adjacent lines in `SettingsService.LoadRecovery.cs` and merge cleanly.
3. **Against the other open drafts on the same line (21 PRs, #1885 to #1933, all fetched and checked pair by pair):** apart from `REGRESSION_LOG.md`, only three pairs clash, all in `Models/UserSettings.cs` and all keep-both switch lines:
   - #1906 with #1898 (B-077 footing memory) and #1906 with #1895 (BUG-1184 bearer marks).
   - #1909 with #1898.
   - #1906 with #1912 (BUG-1186, the same `TimberSubfloorService.cs`) merges with no code clash, only the log. #1903 and #1904 clash with nothing outside the group. #1905 does not clash with #1932 (the section rename) as text, but see #1905 item 5.
4. **Recommended stacking order:** #1903 then #1904 (one keep-both in each of two files). #1902 then #1905 (the picker window). #1898 (B-077, footing size memory) before #1909, then re-run `Bug579FootingDepthKeptTests`, because #1898 changes where the size list keeps the depth #1909 reads (`Size3`). #1906 after #1895 and #1912, which also edit `TimberSubfloorService.cs`. Then #1907 and #1908 in any order. Every step: keep both sides in `REGRESSION_LOG.md` and `UserSettings.cs`.

---

### PR #1902 (B-082): BUG-1126 and BUG-1131, the SBEAM section window

Head 9f01e092, branch `claude/s6-picker-bugs-20261031`. Report: `areas/BUGFIX_s6_REPORT_31OCT.md`.

1. **What the drafter sees.**
   - **BUG-1126:** figures below 10 show three significant figures: Ix 0.04 (was 0), 75 PFC Iy 0.14 (was 0.1), 1.12 kg/m (was 1.1). From 10 up, nothing changes (306, 152.4). `Services/SbeamPickerDisplay.cs` 13-23, called from `SteelSectionPickerDialog.xaml.cs` 666. This is exactly the carpark's "three significant figures". Display only.
   - **BUG-1131:** a length above 100 is read as millimetres. 6000 gives 6 m and "192 kg (length read as 6000 mm)" (`SteelSectionPickerDialog.xaml.cs` 577-591 and 614-620). This matches the carpark: "over 100 read as millimetres, with the unit shown". The converted metres also go into the placement request (`MemberLengthMetres`, dialog line 498), so a newly placed section stores 6 m, not 6000 m. That is right.
   - **Edge cases.** A span typed in metres above 100 (rare) is now read as millimetres, and the window says so. An older placed section that stored "6000" (metres), opened for edit, will show 6000 in the box and be re-read as 6 m. That is the intended correction, but nobody has seen it.
2. **Switches.** `Options.SbeamPickerThreeSignificantFigures` (ON), `Options.SbeamLengthOverThresholdIsMillimetres` (ON) and `Options.SbeamLengthMillimetreThreshold` (100), in `UserSettings.cs` 400-407. They are pinned in `S6PickerSwitchDefaultsTests` on a blank file, an old file and a damaged file, and typed values stay. OFF restores the old behaviour exactly: `FormatDim(v, false)` is the old `ToString("0.#")` in the current culture (the old call also used the current culture), and the length is unchanged. The threshold is in Settings, not hard-coded (R-00 met). The reader falls back to 100 for zero, negative or not-a-number (`SbeamPickerDisplaySettings.cs` 20-28).
3. **Hard blocks:** none.
4. **Native protection and REDO:** window only, with no drawing write, no system variable and no view change.
5. **Merge:** see section 5. It is on the wrong label table (common point 2).
6. **Tests:** `SbeamPickerDisplayTests` covers ON and OFF figures and the 6000 to 192 kg sum. The weight-line wording "(length read as 6000 mm)" is not tested anywhere. It is built inline in the dialog.
7. **NOT proven:** the window itself; the weight line; the edit path for an existing section. **Robot case** (the author's S31/S32 are good): SBEAM, 310UB32, length 6000; read the weight line, expect `192 kg (length read as 6000 mm)`; then 6, expect `192 kg`. Then 40x40x3 EA, read Ix, expect `0.04`. Switch-off controls are set in the file before launch. **Codex look:** one screenshot of the property panel with Ix 0.04 and the weight line, to check that the mm note does not overflow the box.
8. **Verdict: KEEP-WITH-NOTE.** Before install, move the three label rows to `PlainLabelsWithoutPage`, and correct "untick in Settings" in the report and PR body. **Train class: Structural area + smoke.**

### PR #1903 (B-083): BUG-1123, XCLMTXT office UB/UC spelling rows

Head 93bd342d, branch `claude/s7-bug1123-office-spelling-first`. Report: `areas/BUGFIX_s7_REPORT_31OCT.md`.

1. **What the drafter sees.** An office MEMBERS.csv row whose left side is a UB or UC size (250UB26 to 250 UB 25.7) is applied again. Before, the size lock skipped it and printed "250 UB 26". `ExcelMTextService.cs` 5743-5767: the new `ApplyOfficeSizeSpellings` (about 5830-5843) runs before `ProtectExplicitMemberSizes`. Longest rows go first. A guard `(?![A-Za-z0-9]|\.\d)` stops 250UB26 matching inside 250UB26.5, and the same guard stops a chain such as 250UB25 re-matching inside a freshly written "250 UB 25.7". The result is then protected by the existing lock (its pattern accepts decimals), so the later table passes cannot touch it. This is the carpark's first option ("run the office list first").
   - **Side effect, harmless as far as I can see:** when MEMBERS.csv is missing, the built-in `MemberTable` (lines 261-300, 41 UB/UC rows) is used and now also runs before the lock. Every built-in UB/UC row only adds spaces (250UB25 to 250 UB 25), which matches what the lock's spacing gives. I did not open the real office MEMBERS.csv; nobody in this group has. The carpark asks for that look.
2. **Switch.** `Excel.OfficeSpellingBeforeSizeLock` (ON), `UserSettings.cs` about 1032. Pinned through `new UserSettings()` and the tolerant read (blank, old file, typed off). OFF skips the new step, and the rest of the method is the old code unchanged. No engineering value.
3. **Hard blocks:** none.
4. **Native protection and REDO:** no change in what is written, only the text content of the schedule cell.
5. **Merge:** it clashes with #1904 (keep both; section 5).
6. **Tests:** `OfficeSpellingBeforeSizeLockTests` (6 tests). The OFF case reproduces the old fault ("250UB26" stays), so the ON/OFF pair is a real guard.
7. **NOT proven:** XCLMTXT in AutoCAD with a copy of MEMBERS.csv; whether the office file has UB/UC rows at all. **Robot case:** the author's N61 (a MEMBERS.csv copy with 250UB26,250 UB 25.7, cell "250UB26", expect "250 UB 25.7"; the OFF control gives "250 UB 26"). It needs a copy of MEMBERS.csv, never the office one.
8. **Verdict: KEEP. Train class: Structural area + smoke.**

### PR #1904 (B-083): BUG-1128, XCLMTXT PL becomes PLATE everywhere

Head f1438666, branch `claude/s7-bug1128-pl-plate-wholeword`.

1. **What the drafter sees.** Every whole word PL becomes PLATE: "TOP PL & BOT PL" gives "TOP PLATE & BOT PLATE", "250 x 16 PL" gives "250 x 16 PLATE", and "PL 10 x 200" gives "PLATE 10 x 200" (`ExcelMTextService.cs` 5793 and the new `ExpandPlateWord`). PL1, PL-1, SPLICE, PLY and 2/PL are left alone, because a letter, digit, hyphen or slash on either side blocks it. A PL with a digit before it, such as "16PL", is also left alone. The carpark only asked "not followed by a digit"; leaving "16PL" alone is the safer reading. A lowercase "pl" becomes "PLATE" in capitals, as the old rule also did. This matches the carpark.
2. **Switch.** `Excel.PlateWordEverywhere` (ON). Pinned like #1903. OFF is the old two lines exactly (`ExpandPlateWord` 5818-5823). No engineering value.
3. **Hard blocks:** none. 4. **Protection and REDO:** text content only.
5. **Merge:** it clashes with #1903 in `UserSettings.cs` and `ExcelMTextService.cs` (keep both). After both merge, #1903's tests run through the PL step, which reads `SettingsService.Current`. That read lands in the test temp folder (common point 6), and the default is ON, so the #1903 expected strings (no PL in them) are unaffected.
6. **Tests:** `PlateWordEverywhereTests`. The OFF case keeps "TOP PLATE & BOT PL", which is the old fault, so this is a real guard.
7. **NOT proven:** in AutoCAD. **Robot case:** the author's N60 (cell "TOP PL & BOT PL", read the MTEXT, OFF control).
8. **Verdict: KEEP. Train class: Structural area + smoke.**

### PR #1905 (B-083): BUG-1122 (part), SBEAM search by mass spelling

Head bfe41456, branch `claude/s7-bug1122-ub-mass-spelling`.

1. **What the drafter sees.** Typing 410UB59, 410UB60 or 410UB59.7 in the SBEAM search lists 410UB60 (59.7 kg/m). 460UB75 lists 460UB74, and 250UB25 lists 250UB26. 410UB57 and 360UB59 find nothing (`SbeamSelectionPlanner.cs` new `MatchesMassSpelling`). Depth and family must match exactly. A whole number matches if it equals the real mass cut down or rounded; a decimal matches to within 0.05.
   - **This is not the carpark's rule.** The carpark asked for "within 0.5 kg/m". The author shows that rule would not find 410UB59 from 59.7 (0.7 apart). The rule built is a search rule, not an engineering value: it only adds rows to the list, and the drafter still picks. Tim has not ruled on it. Record it in the carpark note for CE 04; no question to Tim is needed unless he wants 0.5 back.
   - **Not done:** CEMEMBER typed names (waiting on #1900) and Lysaght Z15019 (needs the BUG-818 list; see #1932). BUG-1122 stays OPEN after acceptance of this part.
2. **Switch.** `SbeamPicker.MatchMassSpelling` (ON, `UserSettings.cs` about 223). The query's own default is OFF (`SbeamSelectionContract.cs`), so only the dialog turns it on. The dialog passes `SettingsService.Current?.SbeamPicker?.MatchMassSpelling ?? true` (`SteelSectionPickerDialog.xaml.cs` 427). Pinned through the tolerant read (blank, old file, typed off). OFF gives the old plain text match exactly (tested).
3. **Hard blocks:** none. 4. **Protection and REDO:** search only, nothing written.
5. **Merge:** clean with #1902 (same dialog file, different lines). Watch #1932 (B-106, the section rename): once names change, the "depth" and "family" groups in `DepthFamilyMass` must still read the new names. I did not check #1932's names.
6. **Tests:** `SbeamMassSpellingSearchTests` (DesignCore, 11 cases, ON and OFF; the OFF case reproduces the old empty list). `SbeamMassSpellingSwitchTests` has one source-text check plus the defaults.
7. **NOT proven:** the real catalogue file's masses for each section (the tests use a hand-made list); the window. **Robot case:** the author's N62 (SBEAM, search 410UB59, list shows 410UB60; OFF: empty). This is a window read, so it also needs a Codex look.
8. **Verdict: KEEP-WITH-NOTE** (record the rule change from "0.5 kg/m" in the carpark; BUG-1122 stays open for CEMEMBER and Lysaght). **Train class: Structural area + smoke.**

### PR #1906 (B-084): BUG-1185 CSTAGBEARERS and BUG-1200 THCL family

Head 314acd00, branch `claude/s8-bug1185-1200`. Report: `areas/BUGFIX_s8_REPORT_31OCT.md`.

1. **What the drafter sees.**
   - **BUG-1185:** CSTAGBEARERS no longer draws a second line. It adds only the label text, half-way along the bearer's own length (`TimberSubfloorService.cs` 167-175, 222-228; new `DrawBearerTagText` 359-379; `TryGetEndpoints` midpoint 524-535 uses `GetPointAtDist(Length/2)` for a polyline). A bearer picked twice is tagged once and gets a note. This matches the carpark ("label-only writer, keep and deduplicate"). The text height 100 is the same hard-coded figure the old writer used, so nothing new.
   - **Consequence to know:** before, CE's copy line sat on BEARERS - SUBFLOOR whatever layer the hand-drawn bearer was on. Now a bearer drawn on layer 0 stays on layer 0 and nothing new goes on BEARERS - SUBFLOOR. I found no reader that counts lines on that layer. The mark scan (`ScanExistingMembers`) reads text only, and it scans the BEARERS layer although the labels go on 25TEXT. That looks like a separate, existing fault, probably what #1895 (BUG-1184) addresses; I did not check.
   - **BUG-1200:** the typed size is saved only at the end (`CeTextService.cs` 1329-1335). The text spot is asked before the outline exists, with a temporary outline shown (`PickRectTextPointWithPreview`, about 2191-2236). So Esc at the centre leaves no saved size, and Esc at the text spot leaves no outline and no size. This matches the carpark ("defer saving and geometry; transient preview; commit together").
2. **THE FAULT (CHANGE-NEEDED).** The temporary outline is built from `centerUcs ± size/2` with no rotation (2197-2205). The real outline is then rotated by `additionalRotationUcs` (about 1210-1214) and possibly moved by the slab nudge (`EnsureRectInsideSlabPerimeter`). For a rectangular pad or thickening where the drafter typed an extra rotation (the rotation prompt only appears when the two sizes differ), the preview is in the wrong place while they pick the text spot. The report's "same shape in the same place" is true only for a square or unrotated rectangle. **Fix:** rotate the four preview corners about `centerUcs` by `additionalRotationUcs` (`RotatePointAround` already exists in the file) before `ToWorld`. Then correct the wording in the report and REGRESSION_LOG. The slab nudge cannot be previewed without drawing, so say plainly that the preview shows the outline before any nudge. The text-side choice uses only the sign of the offset from the centre, so the side picked is nearly always the same; the problem is what the drafter sees.
3. **Switches.** `TimberSubfloor.TagBearersLabelOnly` (ON, `UserSettings.cs` 1762) and `FootingWidth.RectTextCommitsOnceAccepted` (ON, 1401). Both are pinned in `S8NewSwitchDefaultsTests` on blank, old, damaged and typed-off files. OFF on CSTAGBEARERS calls the old `DrawBearerLabel` with the old chord midpoint, but the duplicate-pick skip is also gated by `labelOnly`, so OFF is exact. OFF on THCL: the old prompt, save and draw order, unchanged. No engineering value added.
4. **Hard blocks:** none.
5. **Native protection and REDO.** One write removed (the duplicate line). The size-memory save is the same write, moved to the end of the same command. The transient outline is screen-only (`TransientManager`, removed in `finally`); it writes nothing to the drawing and changes no system variable. A locked 25TEXT still fails as before; that is #1912's job (BUG-1186), and #1912 edits the same file.
6. **Tests.** `SubfloorBearerTagRuleTests` tests `TryMidpointAlong`, **but the command never calls it.** It uses AutoCAD's own `GetPointAtDist`. Those three point tests therefore test unused code. Either call the rule from `TryGetEndpoints` (for straight-segment polylines) or delete it and its tests. The command order is pinned only by source-text checks. `FootingDrawUnitsG4Tests` had its pinned text changed (labelled).
7. **NOT proven:** the label position on a polyline with an arc; the Esc behaviour; the preview; one Undo after a full THCL; the strip-footing width question, which still saves early (`TryGetOrPromptSfWidth`, outside this bug). **Robot cases:** the author's S8_tagbearers_label, S8_thcl_esc_centre and S8_thcl_esc_text are good, with switch-off controls. Add **S8_thcl_rot_preview:** THCL 83, sizes 1200 and 600, rotation 30, then pause at the text pick. **Codex look:** a screenshot showing the temporary outline lies at 30° on top of where the final outline lands.
8. **Verdict: CHANGE-NEEDED (small): rotate the preview outline, and correct the "same place" wording. Also tidy the unused `TryMidpointAlong`.** **Train class: FULL** (two command families' drawing writes and the footing size memory).

### PR #1907 (B-087): BUG-640, RD asks for the arc or circle first

Head d0b06c5d, branch `claude/s11-dim-arc`. Report: `areas/BUGFIX_s11_REPORT_31OCT.md`.

1. **What the drafter sees.** RD prompts "Select arc or circle to dimension". Pick an arc, and it offers Length/Radius/Diameter; pick a circle, and it offers Radius/Diameter. Then CE hands the picked object to AutoCAD's own DIMARC, DIMRADIUS or DIMDIAMETER (`DimensionCommands.cs` 135-142, new `ArcDimensionGeometryFirst` 184-225, `StartInteractiveDimensionCommand` 585-588). This is the order the approved card ST-03/ST3-5 and the carpark ask for. The last type used stays the default when it fits; a remembered "Length" on a circle offers Diameter.
   - **Escape** at either CE prompt returns before the wrapper changes the layer and dimension style, so there is nothing to put back. Good.
   - **Unsupported geometry:** a polyline is handed over by the picked point. If the pick is on a straight segment, AutoCAD's own command, not CE, will refuse or ask again. The carpark asks for "a clear refusal" for unsupported geometry; CE gives none for that case.
   - **Point coordinates:** I could not verify whether `PickedPoint` is in the coordinate system AutoCAD's command expects when a UCS is not World (rule 12.5: Autodesk internals are closed). The robot should run one case in a rotated UCS.
2. **Switch.** `Annotation.ArcDimSelectsGeometryFirst` (ON, `UserSettings.cs` 332-336). Pinned on blank, old, damaged and typed-off files (`ArcDimensionTypePolicyTests`). OFF runs the old code below the `if`, untouched. It is on the wrong label table (common point 2).
3. **Hard blocks:** none (the pick filter is AutoCAD's normal re-ask).
4. **Protection and REDO.** The pick only reads. A locked-layer arc can still be dimensioned, which is normal AutoCAD. An arc inside an Xref cannot be picked, because the filter rejects the Xref block. No new drawing write. The settings-file save of the last type is the same as before. The layer and dimension style changes are the existing wrapper's.
5. **Merge:** clean apart from REGRESSION_LOG. No other open PR touches `DimensionCommands.cs`.
6. **Tests.** Only the pure policy is tested. The command flow (the hand-over to AutoCAD) has no test, not even a source-text check. The author says so.
7. **NOT proven:** whether DIMARC, DIMRADIUS and DIMDIAMETER accept the handed-over object and then show their normal preview; this is the whole fix. Also not proven: the polyline route, Escape at each step, one Undo, and the remembered type. **Robot case:** the author's S11_rd_geometry_first is good, with a switch-off control. Add a polyline-with-arc case, a straight-segment polyline case (expect AutoCAD's message, no crash), and one in a rotated UCS. **Codex look:** AutoCAD's preview follows the cursor after the type choice.
8. **Verdict: KEEP-WITH-NOTE** (move the label row; robot first, because the hand-over is unproven). **Train class: Structural area + smoke.**

### PR #1908 (B-088): BUG-1129, BARWEIGHT uses the bar catalogue

Head 845ec656, branch `claude/s12-bug1129-one-bar-table`. Report: `areas/BUGFIX_s12_REPORT_31OCT.md`.

1. **What the drafter sees.** BARWEIGHT 100 N20 at 6 m gives 1479.6 kg (was 1482.0), the same as the bar schedule. 50 N16 at 12 m gives 946.8 kg. `RebarService.CalculateWeight` now looks the bar up with `ReinforcementService.FindBar`, the same lookup the schedule uses (`ReoBarService.cs` 855), so there is one table, as design rule 1 requires. N40, R6 and R10, which are not in the catalogue, keep the old built-in mass, with a one-line note (`RebarCommands.cs` 440-442). This matches the carpark ("BARWEIGHT reads rebar-catalogue.json"). Adding N40, R6 and R10 to the catalogue is left to Tim, which is right: those rows carry lap and cover values.
   - If `rebar-catalogue.json` cannot be found at run time (`ReinforcementService.cs` 69-72), every bar falls back to the old mass and prints the note. That is a warning, not a stop.
2. **Switch.** `Options.BarWeightUsesBarCatalogue` (ON, `UserSettings.cs` 385). Pinned on blank, old, damaged and typed-off files. OFF passes `useCatalogue = false` to `BarWeightMassRule.Resolve`, so the old mass is used, and the note is gated on the switch too. OFF is exact. No engineering value hard-coded; masses come from the catalogue. It is on the wrong label table (common point 2).
3. **Hard blocks:** none. 4. **Protection and REDO:** no change; the optional "place result" text is the same write as before.
5. **Merge:** clean apart from REGRESSION_LOG; `LoadRecovery.cs` merges cleanly next to #1902's rows.
6. **Tests.** `Bug1129BarWeightOneTableTests` re-does the sum by reading `rebar-catalogue.json` from the repo itself. It never calls `RebarService.CalculateWeight` or `ReinforcementService.FindBar`, so a fault in the real lookup (a name format such as "N20" against "20", or the plug-in path) would not show. It does pin the rule, the figures and the catalogue contents (N40, R6 and R10 absent). The real lookup is checked only by a source-text check.
7. **NOT proven:** BARWEIGHT's own command-line figure. **Robot case:** the author's S12_barweight_one_table (BARWEIGHT N20 6000 x 100, expect "= 1479.6 kg"; OFF control "= 1482.0 kg"; N40 prints the note). Claude-acceptable without a Codex look, because it is a command-line value.
8. **Verdict: KEEP-WITH-NOTE** (move the label row; the robot proves the lookup). **Train class: Structural area + smoke.**

### PR #1909 (B-088): BUG-579, FPFC and FSF keep the typed depth

Head 5c2261c7, branch `claude/s12-bug579-footing-depth`.

1. **What the drafter sees.** FPFC with depth 350, then FEDIT, offers 350 (was 0), and the footing schedule shows 350 (was UNKNOWN). FSF does the same for strips. A footing placed with no depth still shows UNKNOWN, which is right (rule 12.2). `FoundationService.cs` 1299 (pad) and 1378 (strip) set `Depth = SavedDepthToRecord(...)`, which reads the depth saved for that size in the size list (`Size3`, written by `fst.Upsert(..., depth)` at 4260 and 4302, the same millimetres FEDIT writes back at 2053). This answers the carpark's "explicit 350 stays known across placement, editor and schedule" for the placement half.
   - **The carpark also says "Behaviour-owner Modify card needed before code".** The change adds no prompt and no drawing output; it stops a typed value being dropped. The author flagged it. CE 04 should confirm in the carpark note that this counts as a bug fix under the existing card, not a workflow change. If CE 04 says a card is needed, hold this PR.
   - **A size reused from the list:** if PF1 already has 900 x 700 x 350 in the size list and the drafter places PF1 again (no prompts), the new footing now gets 350. That matches the size list, and I think it is right.
   - **Not covered:** FADOPT, screw piles and stumps; Undo then Redo; save and reopen. BUG-579 stays OPEN after this part is accepted.
2. **Switch.** `FootingWidth.FootingDepthKeptOnPlacement` (ON, `UserSettings.cs` 1401). Pinned on blank, old, damaged and typed-off files. OFF gives depth 0, the old value, exactly (`FootingDepthKept.DepthToRecord(false, ...)`). Correct label table (line 805). No engineering value.
3. **Hard blocks:** none.
4. **Protection and REDO.** One more field (depth) in the footing record CE already writes at placement, in the same write. No new write, regen, view or system variable. Because the depth now travels with the record, Undo and Redo should carry it like the width, but that is a belief, not seen.
5. **Merge:** it clashes with #1906 in `UserSettings.cs` (keep both). It must go after #1898, which reshapes the size memory; re-run the tests after #1898.
6. **Tests.** `Bug579FootingDepthKeptTests` covers the pure rule and a source-text check that both placement lines exist. Neither proves FEDIT or the schedule shows 350.
7. **NOT proven:** everything in AutoCAD. **Robot case:** the author's S12_fpfc_depth_kept is good (FPFC PF2 800 x 800 depth 450, FEDIT reads "<450>", CSFOOTINGSCHEDULE cell 450, then U and REDO and FEDIT again; FSF strip variant; OFF control "<0>" and UNKNOWN). Add a save, close and reopen, then FEDIT. The schedule cell is a drawing value, so it is Claude-acceptable; a Codex look is not needed unless the schedule layout changes.
8. **Verdict: KEEP-WITH-NOTE** (CE 04 to confirm no card is needed; after #1898; BUG-579 stays open for FADOPT, piles, stumps and Undo/Redo). **Train class: FULL** (footing data that FEDIT and the schedule read).

---

### What this review could not verify

1. Anything in AutoCAD, including AutoCAD's own commands accepting a handed-over object (#1907) and how the temporary outline looks (#1906).
2. The real office MEMBERS.csv contents (#1903) and the shipped `section-catalogue.json` masses for every UB and UC (#1905).
3. Whether a test run without the temp-folder set-up could reach the real settings; the set-up file exists, and I did not run anything.
4. The 21 other open drafts were checked only for file clashes, not for meaning, except where noted (#1898 with #1909; #1895 and #1912 with #1906; #1932 with #1905).
