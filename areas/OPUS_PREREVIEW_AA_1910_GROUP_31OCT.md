# Opus pre-review AA: PRs #1910 to #1916 (Structural S-13 to S-16: B-089, B-090, B-091, B-092)

Written Saturday 31 October 2026, about 8:50 pm Melbourne time, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Base for all seven: `claude/rel-20261026s` at 204dfad2 (Structural 1.0.125). Each PR is one commit on that tip exactly; the base has not moved.
Heads reviewed: #1910 d8d214b0, #1911 297b4197, #1912 27b51979, #1913 77001e12, #1914 b8853b02, #1915 c1b6058c, #1916 519ac717.
I read the diffs and the code around them, the carpark entries, Tim's decisions and the four author reports (BUGFIX_s13 to s16). I ran read-only merge checks only.
I did not build, test, install or open AutoCAD. Every point below is from reading the code.

## FOR TIM

1. **#1910 (four Structural numbers get boxes in CESETTINGS): KEEP-WITH-NOTE, area plus smoke.** You will see two new brace-length boxes on the Bracing page and a new Footings page with the strip and beam footing widths. Nothing a command draws changes. Small note: a typed footing width of 0 is quietly ignored with no message.
2. **#1911 (CSLOADPATH pad round-up and the size of a pier with no size): KEEP, area plus Settings smoke.** Nothing changes until someone edits the two new figures in the settings file. They are file-only for now, because you parked the layout talk (decision 168).
3. **#1912 (bearer tagging stops on a locked layer): KEEP-WITH-NOTE, area plus Settings smoke.** This matches your answer "a command that would write to a locked layer stops up front with one sentence naming the layer". One fault: the check comes after the drafter has picked every bearer and stump, not up front, so all those picks are thrown away. The fix is small.
4. **#1913 (a mistyped layer lineweight no longer quietly becomes Default): KEEP-WITH-NOTE, area plus Settings smoke.** The layer stays as it was and CE says why. Two notes:
   - the refusal also wipes the drafter's other edits on that row, and their typing;
   - it clashes with #1918 in the settings file. Keep both sides.
5. **#1914 (member schedule treats 310UB32 and 310 UB 32 as one size): KEEP-WITH-NOTE, area plus Settings smoke.** It does what the bug asks. One tidy-up: a code comment was put in the wrong place (it does not change behaviour).
6. **#1915 (unticked "Background refresh" really stops the start-up scan): KEEP, area plus Settings smoke plus the start-up smoke N91.** It changes what Structural does when AutoCAD starts, so the start-up check must run (your decision 161).
7. **#1916 (Help for Beam Settings 8 and RJSET): KEEP, area plus smoke.** Wording only.
8. **Built and unit-tested only, all seven. Nobody has opened any of them in AutoCAD. None is fixed.** The seven merge into each other cleanly apart from the change-log file, where the fix is to keep every entry. The robot cases and Codex looks are listed in the detail below.

---

## DETAIL

### Shared findings (all seven)

1. **Merge, against the train tip:** each PR merges cleanly onto `claude/rel-20261026s` 204dfad2 (`git merge-tree`, no conflicts).
2. **Merge, inside the group:** all 21 pairs clash in `REGRESSION_LOG.md` only. Each PR puts its entry at the very top of the file, so the fix is to keep all of them.
   - **`UserSettings.cs`:** #1911 (LoadPathSettings, about 1627-1636), #1912 (TimberSubfloorSettings, 1746-1747), #1913 (OptionsSettings, 359-360), #1914 (MemberScheduleSettings, 1209-1212) and #1915 (XclmTxtSettings, 1138-1142) all edit different classes. Every pair merges cleanly.
   - **`SettingsService.LoadRecovery.cs`:** #1912 (line 1338) and #1913 (line 1322) also merge cleanly.
3. **Merge, against other open Structural drafts:** see the section "Clashes with other open drafts" at the end.
4. **Suggested stacking order:**
   1. #1916, #1910 and #1914 first, because they have no start-up or protection effect;
   2. then #1911 and #1913, with #1913 kept-both against #1918;
   3. then #1912;
   4. #1915 last, because it changes start-up.
   
   Every step is a both-keep merge in REGRESSION_LOG.md. One nit: #1914's entry has no blank line before the next heading (REGRESSION_LOG.md, its line 9).
5. **Settings switch pins:** Structural has one start-up read, `SettingsService.DeserializeSettingsTolerant`. It takes one of two paths: the normal one, or the value-by-value path when a bad value is found. #1911, #1912, #1913, #1914 and #1915 each pin their new switch ON through `new UserSettings()`, `{}`, a 1.0.125-style file and a damaged file that forces the value-by-value path. Those are the two start-up reads. #1910 and #1916 add no switch. That is right, because neither changes behaviour.
6. **Real `%APPDATA%`:** none of the new tests opens the real settings folder.
   - **#1910** redirects the settings file to a temp folder through the existing test seam.
   - **The other tests** are pure, or read repository files only.
   - **The authors' before-and-after listings** found the real settings files unchanged by their runs: s13 report items 6 and 7, s14 item 8, s15 "Real-files compare", s16 item 8. Some live log files changed during s13 and s15; the authors trace those to a robot AutoCAD running at the same time, not to their tests. I did not re-check those listings.
7. **REDO-safety (BUG-861 rule):**
   - **No new system variables:** none of the seven sets a system variable or changes a view.
   - **No new drawing writes:** #1912 adds a read-only lock check before anything is created. #1913's refusal path only re-reads the layer table. #1915 removes start-up work rather than adding it.
8. **net48 compile:** the s13, s14, s15 and s16 reports each record a net48 Release compile with 0 errors. I did not re-run any of them.
9. **Recovery-message labels (low, three PRs):** the settings file has a list of "this setting has a box in CESETTINGS" names. When a value in the file is damaged, CE uses it to say either "Type CESETTINGS to check it" or "this setting has no page".
   - **#1910:** the footing widths stay in the "no page" list (`SettingsService.LoadRecovery.cs` 805-806), although they now have a page. The brace-length labels there ("Longest wall brace (mm)", 1317-1318) do not match the new box labels.
   - **#1912 and #1913:** each adds its file-only switch to the "has a page" list (1338 and 1322). A damaged value would then send the drafter to CESETTINGS, where there is no box for it. The existing file-only Options switches are already listed the same way, so this is house practice, not new damage.
   - **Fix:** a one-line move per entry. Optional.

### #1910: B-089, BUG-535 (part): CESETTINGS shows the footing widths and wall brace lengths

1. **What changes for the drafter:**
   - **Bracing page:** CESETTINGS gets two boxes in the empty right-hand column: "Longest wall brace before CE warns (mm)" and "Brace length when you press Enter (mm)", both 2700 (`CeSettingsDialog.xaml` 352-361).
   - **New Footings page:** "Strip footing width offered (mm)" and "Footing beam width offered (mm)", both 300 (`CeSettingsDialog.xaml` 364-383).
   - **Loading and saving:** the boxes are filled at `CeSettingsDialog.xaml.cs` 138-142 and saved at 363-368, and they are added to the BUG-841 number check (`CeSettingsNumberBoxes.cs`).
   - **Commands:** AB, BB, BT1 and the footing prompts already read these four values, so nothing they draw changes.
2. **Against the carpark and Tim's decisions:** this is exactly items (1) and (2) of BUG-535, with the labels and pages the entry proposes. Decision 168 parks "the tab layout" together with the rest of BUG-535 (wind class, founding note, lintels). The new Footings page is a small layout choice made before that talk, but it is the page the carpark entry itself names. Recommend keep. Mention it in the parked talk so Tim sees it once.
3. **Switch and R-00:** there is no switch, and that is right: no command behaves differently. This PR reduces R-00 debt (four file-only values now visible).
4. **No hard blocks (R-27):** a word in a box refuses Save and names the box. That is the existing BUG-841 rule, a check on what was typed, not a block. **Note:** a typed 0 or a minus figure in a footing width is quietly ignored (`xaml.cs` 367-368). Save succeeds, and on reopen the box shows the old 300 with no message. That is a small silent substitution. Suggest one status line ("A footing width must be above 0; the old width was kept"), or let BUG-841's check refuse it with the box named. Not a blocker.
5. **Blank box:** a blank brace-length box keeps the stored value. It cannot clear a brace length back to "not set"; a 0 does that. This matches every other box and is documented.
6. **Native protection and REDO:** a window only; nothing in the drawing is touched.
7. **Tests (`Bug535SettingsRowsTests`, 6):**
   - **They exercise the real window:** they build it, use `FindName` on the real boxes, and invoke the real `OnSaveClick`. Then they read the saved JSON back from a temp file.
   - **They fail before the change:** before this PR, `FindName` returns null and the `Box` helper fails, so they genuinely fail before and pass after.
   - **Gap:** the zero-footing test checks the value is kept, but there is no message to check (see item 4).
8. **NOT proven:**
   - **The look:** the window in AutoCAD, the dark theme and the 150% fit. The author looked at the light-theme pictures only.
   - **A footing drawn after the change:** for example FSF with no recorded width offering 450 after the box is changed to 450.
9. **Robot case (CE 02), S13_settings_rows:** run as the author wrote it (s13 report, technical item 8), **with one correction.**
   - **The file to read back** is `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`. That is the file Structural reads and writes (`SettingsService.cs` 68 and 623). The report names `%APPDATA%\TIM_CE_CADTOOLS\CS_Settings.json`, which is the old legacy file (last written 31 March) and would show nothing.
   - **Codex look:** the Bracing and Footings pages in light and dark theme, at 100% and 150%.
10. **Verdict: KEEP-WITH-NOTE.**
    - **Notes:** the zero-width message (optional); the recovery label move (shared item 9); the robot file path correction.
    - **Train:** Structural, area plus smoke (CESETTINGS window area plus the Settings smoke S1). The ledger already records the same class (ACCEPTANCE_LEDGER line 243).

### #1911: B-090, BUG-536 (part): CSLOADPATH reads the pad round-up and unsized-pier size from Settings

1. **What changes for the drafter:**
   - **Nothing at first:** the defaults equal the old built-in figures, 50 and 450.
   - **Pad round-up:** after someone edits `LoadPath.PadRoundUpMm`, the pad CSLOADPATH offers is rounded up to that step. The value is passed at `FoundationService.LoadPath.cs` 770-771 into `FootingSizingPlaceholder.SizeSquarePad` (`LoadPathEngine.cs` about 211-224).
   - **Pier with no size:** a pier, screw pile or stump that prints no size is counted as `LoadPath.UnsizedPierDiameterMm` when CSLOADPATH looks for support under a post (`FoundationService.LoadPath.cs` 336-340, `LoadPathEngine.cs` 140-143).
   - **Against the carpark:** this is exactly the two load-path parts the BUG-536 evidence note lists as still fixed numbers. The office-block sizes are parked by decision 168, and the PR leaves them alone.
2. **Switch:**
   - **Default:** `LoadPath.ReadsPadRoundUpAndUnsizedPierFromSettings` ships ON (`UserSettings.cs` 1636).
   - **OFF restores the old exactly:** both callers then call the old overloads, which use the constants 450 and 50.
   - **Zero or a minus figure:** falls back to 50 or 450. That is safe, though silent; it is a file-only value.
   - **Pinned:** through both start-up reads (`S14LoadPathSettingsDefaultsTests`).
3. **R-00:** the two new figures are file-only, like the other `LoadPath` figures. Tim parked the layout talk (decision 168), so this is not a fault of this PR. Add them to that talk's list.
4. **R-27:** no new stop or window.
5. **Native protection and REDO:** read-only settings read; no new drawing write. The pad offer path is unchanged apart from the size.
6. **Tests:**
   - **`LoadPathSettingsValuesTests` (7):** the arithmetic is right. 20 kN at 100 kPa gives 447 mm, which rounds to 450 at a 50 step and 500 at a 100 step. They fail before (the new overloads do not exist).
   - **`S14LoadPathSettingsDefaultsTests.BothCallers_...`:** a text check on the source, sensitive to the exact indentation. It checks the right thing (the switch picks the overload), but it will break on a harmless reformat. Acceptable.
7. **NOT proven:** CSLOADPATH in AutoCAD with an edited figure.
8. **Robot case:** N90_lp_roundup as the author wrote it (s14 report item 7). Before launch, set `PadRoundUpMm` 100 in the scratch copy. Expect `Offered pad footing 500x500`.
   - **Control:** switch OFF gives `450x450`.
   - **Second case for the pier figure:** a post sitting 250 to 300 mm from an unsized pier. It is supported at 600 and not at 450. The author did not write this case; CE 02 should add it.
9. **Verdict: KEEP. Train:** Structural, area plus Settings smoke S1.

### #1912: B-091, BUG-1186: CSTAGBEARERS and CSSUBFLOORGRID refuse to write onto a locked layer

1. **What changes for the drafter:** if a layer the command would write on is locked, CE says so and adds nothing.
   - **Which layers:** 25TEXT, BEARERS - SUBFLOOR, and STUMPS AND PIERS (the last only when stumps are being placed).
   - **The line:** "[CSTAGBEARERS] Layer 25TEXT is locked, so CE drew no bearer tags. Unlock it and try again. Nothing changed." (`TimberSubfloorService.cs` 247-265, rule in the new `Core/Subfloor/SubfloorLockedLayerRule.cs`).
   - **CE never unlocks:** the check only reads the layer table (`LayerService.FirstLockedLayer`, existing).
2. **Against the carpark and Tim:** BUG-1186 asks to "refuse or skip with one named-layer message; never unlock or redirect; no partial objects". Decision 99 item 6: "A command that would write to a locked layer stops up front with one sentence naming the layer." The refusal and the wording match.
3. **Fault (MEDIUM, wasted work, not a drawing fault): the check is not "up front".** In CSTAGBEARERS it runs at line 197, after the drafter has done all of this:
   - picked every bearer (the loop at 163);
   - typed the size;
   - answered the stump question;
   - picked every stump.
   
   In CSSUBFLOORGRID it runs at line 92, after the outline, the direction and four typed values. On a real subfloor that can be twenty picks thrown away.
   - **Fix:** in CSTAGBEARERS, check 25TEXT and BEARERS - SUBFLOOR before the first pick, and check STUMPS AND PIERS straight after "Also place stump/pier supports? Yes". In CSSUBFLOORGRID, check before the outline pick. Keep the present check as the last guard: a layer can be locked during the command with a transparent command, which is rare.
   - **Cost:** about ten lines plus one test.
4. **R-27:** this stop is the native locked-layer protection that Tim's decision 99 item 6 approves, so it is allowed. The second check, at Apply, is still a refusal rather than a skip. That is what Tim asked for.
5. **Message wording (low):** for a locked STUMPS AND PIERS the line says "drew no bearer tags". Saying "drew no bearer tags or stumps" would be clearer.
6. **Switch:** `TimberSubfloor.LockedLayerRefusesTagging` ships ON (`UserSettings.cs` 1747).
   - **OFF:** the rule returns nothing and the old path runs exactly; on an old file a missing value counts as ON (`?? true`).
   - **Pinned:** through both start-up reads (`SubfloorLockedLayerRuleTests.TheSwitchShipsOn_ThroughTheRealTolerantReader`).
   - **R-00:** no engineering value added.
7. **REDO:** one read-only check before the preview; no write, no system variable.
8. **Tests (`SubfloorLockedLayerRuleTests`, 7):**
   - **What they cover:** the pure rule and the message text. They fail before (the type does not exist).
   - **Gap:** nothing checks that the two commands actually call the rule. A source-order guard would help; the "up front" fix should bring one.
9. **NOT proven:**
   - **No command run:** neither command in AutoCAD with a real locked layer.
   - **Undo and Redo:** after a refused run, nothing should be on the undo list.
10. **Robot case:** S15_tagbearers_locked25text as written (s15 report, item 4.1).
    - **After the fix:** expect the refusal before the "Select a hand-drawn bearer" prompt.
    - **Control:** switch OFF. The label is added onto the locked 25TEXT.
    - **Add a CSSUBFLOORGRID case:** lock BEARERS - SUBFLOOR.
11. **Verdict: KEEP-WITH-NOTE**, with the fix in item 3 strongly recommended before install. **Train:** Structural, area plus Settings smoke S1.

### #1913: B-091, BUG-1187: a mistyped layer lineweight keeps the layer unchanged and says why

1. **What changes for the drafter:** this happens in CEADMINSETTINGS, Drawing Layers, Save Layer Changes.
   - **Wrong weight:** a Lineweight cell that is not a valid weight ("typo", empty, "0.47") is now refused. The layer stays as it was, and the status line plus a warning box say: Lineweight "typo" is not a lineweight, so layer AUDIT-WEIGHT was not changed... (`LayerManagerWindow.xaml.cs` 194-202, `LayerService.LineweightFieldError` 733-739).
   - **Before:** the layer quietly became Default and the window said "Updated layer".
   - **Against the carpark:** this matches BUG-1187's "keep the original on invalid input; show a plain field error". The pick-list is not built, as the PR says.
2. **Switch:** `Options.LayerLineweightTypoKeepsOriginal` ships ON (`UserSettings.cs` 360).
   - **OFF:** the method returns nothing and the old quiet Default runs exactly.
   - **Pinned:** through both start-up reads.
3. **R-27:**
   - **The refusal:** refusing to write a value that is not a weight is a check on what was typed, not a hard block.
   - **The pop-up (low):** the refusal also opens a warning box that has to be clicked away (`CeAlertDialog.Show`, line 200) as well as the status line. The carpark asks only for "a plain field error"; the status line alone would do. Optional.
   - **Lost edits (MEDIUM, usability):** `RefreshLayers()` (line 198) reloads every row from the drawing. Any other edits the drafter made on that row, such as colour or linetype, are thrown away, and so is the bad text itself. The PR and its log entry admit this. A kinder fix: keep the row as typed, show the message, and save nothing. The drafter then corrects the one cell and presses Save again. Not a blocker.
4. **Pre-existing, not new (low):** the weight reader accepts any whole number through `Enum.TryParse`.
   - **"47" slips past the new check:** it reaches the layer update and fails there with the old "Update Failed" error. The layer is still unchanged.
   - **"50" works by accident:** it is read as 0.50 mm.
   
   This could be a carpark line; it does not need this PR.
5. **Native protection and REDO:**
   - **Drawing writes:** the refused path writes nothing.
   - **Locked layers:** the valid path is the existing `LayerService.UpdateLayer`. This PR does not change how it treats a locked layer; I did not check that function here.
6. **Tests (`Bug1187LayerLineweightTests`):**
   - **What they cover:** the pure method (refused and accepted values, switch off) and the switch pin. They fail before (the method does not exist).
   - **Gap:** the window path, the box and the reload are not tested.
7. **Clash:** it clashes with #1918 (B-100, BUG-1224) in `UserSettings.cs`, because both add a property straight after `DebugLogging` in `OptionsSettings` (my merge check; the #1918 group review says the same). Keep both.
8. **NOT proven:** the window in AutoCAD; the layer's real weight after the refusal; the warning box.
9. **Robot case:** S15_layerweight_typo as written (s15 report item 4.2). Read the layer's weight back as 50 (0.50 mm), and the status-line text.
   - **Control:** switch OFF gives Default.
   - **Codex look:** the warning box and the reloaded row.
10. **Verdict: KEEP-WITH-NOTE**, with two notes: keep both sides against #1918; keep the row's edits on refusal (recommended, optional). **Train:** Structural, area plus Settings smoke S1.

### #1914: B-092, BUG-1134: the member schedule counts 310UB32 and 310 UB 32 as one size

1. **What changes for the drafter:** in CSMEMBERSCHED (still off by default), two FB3 beams labelled `310UB32` and `310 UB 32` now give one row, "FB3 310 UB 32", with no "drawn with different sizes" line.
   - **How sizes are compared:** spaces are ignored, case is ignored, and the times sign counts as X (`MemberScheduleFromPlan.cs` 220 and the new `DistinctSizes`, 327-352). `310 UB 32` against `250 UB 26` still gives Unknown.
   - **Against the carpark:** this matches BUG-1134 exactly.
2. **Which spelling is shown:** the one with the most spaces. So "90x45 MGP10" against "90 X 45 mgp10" prints the lower-case "mgp10". This is cosmetic and rare; first-drawn on a tie is fine.
3. **Switch:** `MemberSchedule.CompareSizesIgnoringSpaces` ships ON (`UserSettings.cs` 1212).
   - **OFF:** runs the exact old `.Distinct(OrdinalIgnoreCase)`.
   - **Pinned:** through both start-up reads (test `Bug1134_SwitchDefaultsOn_ThroughBothStartUpReads`).
   - **R-00:** no engineering value added.
4. **Tidy-up (low):** the new method was inserted between `SplitMark`'s description comment (323-326) and `SplitMark` itself (354). `DistinctSizes` now carries two descriptions and `SplitMark` none. This is harmless to the build, but swap them back.
5. **R-27, native protection, REDO:** pure calculation; no stop, no drawing change.
6. **Tests:** five new tests in `MemberScheduleFromPlanTests`. The spacing, switch-off and real-difference tests check the real rows and notes, so they fail before and pass after. The X-and-case test's row count would pass before, but its notes check would not, so it is a real test.
7. **NOT proven:** CSMEMBERSCHED in AutoCAD.
8. **Robot case:** S16_bug1134_size_spacing as written (s16 report item 6), with `MemberSchedule.Enabled` on before launch.
   - **Expect:** the row `FB3 310 UB 32`.
   - **Control:** OFF gives `FB3 Unknown` and the note.
9. **Verdict: KEEP-WITH-NOTE**, with one note: move the comment back. **Train:** Structural, area plus Settings smoke S1.

### #1915: B-092, BUG-1203: unticked Background refresh stops the start-up schedule-history scan

1. **What changes for the drafter:** when "Background refresh enabled" (CESETTINGS, XCLMTXT) is unticked, AutoCAD start-up no longer loads the schedule-history cache or scans the folders (`Plugin.cs` 156-161). The automatic stale-cache refresh also obeys the tick (`XclmTxtCorpusIndexService.cs` 53-54 and 60-61).
   - **Unchanged:** XCLMTXT still loads the cache the first time it is used, and its own Refresh button is not gated.
   - **Against the carpark:** this matches BUG-1203 ("honour the switch at the common automatic-refresh entry point; keep an explicit refresh separate; avoid eagerly loading a large cache when disabled").
2. **Start-up order checked:** the gate reads `SettingsService.Current`, which initialises the settings itself if needed (`SettingsService.cs` 93-99), and the settings are initialised earlier in start-up anyway. So the gate sees the real tick, not an empty one. On an empty value it allows the refresh (the old behaviour), which is the safe side.
3. **Switch:** `XclmTxt.BackgroundRefreshSwitchIsHonoured` ships ON (`UserSettings.cs` 1142).
   - **OFF restores the old exactly:** start-up calls `Initialize()` unconditionally, and the stale check ignores the tick. The command-side check in `XclmTxtService.Run` (30-34) was already there and is unchanged.
   - **Pinned:** through both start-up reads.
4. **One side effect (low, intended):** with the box unticked, the cache load moves from start-up to the first XCLMTXT of the session. That first XCLMTXT may take a moment longer.
5. **R-27, native protection, REDO:** removes start-up work; no stop, no drawing change.
6. **Tests (`Bug1203BackgroundRefreshSwitchTests`, 6):**
   - **What they cover:** the pure rule (fails before, because the method does not exist), the switch pin, and a source-order guard (the start-up check comes before `Initialize()`; the stale check is gated before anything is scheduled).
   - **Gap:** the real start-up is not run. The author says so.
7. **Train class:** it changes start-up (`Plugin.cs`), so under decision 161 it is area plus the start-up smoke N91 (always included), plus Settings smoke S1.
8. **NOT proven:** a real AutoCAD start with the box unticked; the log; `LastCorpusRefreshUtc` staying empty.
9. **Robot case:** S16_bug1203_no_refresh as written (s16 report item 6).
   - **Setup:** set `BackgroundRefreshEnabled` false and clear `LastCorpusRefreshUtc` in the scratch settings before launch. Do not run XCLMTXT.
   - **Read back:** the value, and the Structural log.
   - **Control:** with `BackgroundRefreshSwitchIsHonoured` false, a refresh time appears.
   - **Then:** run XCLMTXT once and check that it still opens with its suggestions.
10. **Verdict: KEEP. Train:** Structural, area plus Settings smoke S1 plus start-up smoke N91. Stack it last.

### #1916: B-092, BUG-1219: CEHELP for Beam Settings (8) and RJSET says they open CE Settings

1. **What changes for the drafter:** CEHELP (Show advanced commands) for "Beam Settings (8)" and RJSET now says three things:
   - "Nothing is asked on the command line: CE Settings opens on the Beam page" (or the Rafter / Joist page);
   - "Change the values on the page.";
   - "Click Save to keep them, or Cancel to leave them unchanged."
   
   The placement prompts are gone (`command-registry.json` 2079-2083 and 2680-2684). This matches BUG-1219.
2. **Other copies of the text:** the toolbar file `ce_toolbar_layout.json` 991 still has the one-liner "Configure R1/FJ1 behavior.", which is not wrong. The old prompt text also survives in `Docs/CommandSummaries*.md` (documents, not shown in AutoCAD).
3. **Switch:** none, which is right (wording only).
4. **R-27, native protection, REDO:** none apply.
5. **Tests (`Bug1219SettingsCommandsHelpWordsTests`, 5 cases):**
   - **They read the real registry:** they fail before (the old prompts contain "Start point" and the other placement steps) and pass after.
   - **The command check:** it confirms both commands still call `CeSettingsUiService.Open` on the right page.
6. **NOT proven:** CEHELP in AutoCAD; whether Save closes the window. The author says so, and the wording does not claim it.
7. **Robot case:** S16_bug1219_help_text as written. There is no switch; the control is the old build.
8. **Verdict: KEEP. Train:** Structural, area plus smoke (Help area).

### Clashes with other open drafts

1. **What I checked:** a read-only `git merge-tree` of each of the seven heads against every other open draft based on `claude/rel-20261026s`. That is 22 other PRs: #1885, 1886, 1895, 1898 to 1909, 1918, 1921 and 1929 to 1933. Clashes in `REGRESSION_LOG.md` are left out, because every pair has one and the fix is always to keep both entries.
2. **The only real clash:** #1913 against #1918 (B-100, BUG-1224), in `Modules/Structural/Models/UserSettings.cs`. Both add a switch straight after `DebugLogging` in `OptionsSettings`. Keep both properties.
3. **No other clash:** nothing else clashes outside REGRESSION_LOG.md, including #1912 against #1906 in `TimberSubfloorService.cs` and #1911, #1914 and #1915 against the other `UserSettings.cs` drafts (#1885, 1886, 1895, 1898, 1899, 1905, 1906, 1908, 1909).
4. **Not checked:** I did not test a merge of all 29 drafts at once. I checked only pairs of PRs.
