# Train C-60 finalizer report (Civil ONLY), Thu 22 Oct 2026 (real clock 17:05 to about 18:10 Melbourne)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Model: the C-59 finalizer report and REVIEWLANE_LOG entries 1575 to 1593.

## ANSWER FIRST

1. **GO at `4095a678e9bac9532492b630585bd8289da8ea3e`.**
2. **Final head:** `claude/rel-20261022m` @ `4095a678e9bac9532492b630585bd8289da8ea3e` (normal fast-forward push from `037b9311`, leak scan clean). The start head `037b93112d363b7c6f4ad819e3169d8fa6dbf9de` matched the assembly report and `git ls-remote` at the start and again just before the push. Installed base: C-59 `claude/rel-20261022l` @ `375a4ebc` (Civil 3.0.69 / Manager 1.1.69). No version bumped.
3. **What I changed: 1 commit, formatting only (`4095a678`).** REGRESSION_LOG.md: one blank line put back before the C-59 heading "CDS > Advanced fits a 1920x1080 screen ...". The #1517 branch had merged the C-59 line and joined its fix-round paragraph to that heading. No code, no wording, no setting changed.
4. **Manager unchanged: not rebuilt, not run.** `git diff --stat 375a4ebc..HEAD -- Shared Installer Installer.Tests Modules/Manager CE.Host` is empty. The payload builder only re-stamps Manager's version (1.1.69 to 1.1.70) so Civil and Manager stay matched. CE_SHARED is unchanged, so both carry the same copy.
5. **Tests (Release, on the final head 4095a678):**
   1. **Whole solution: 0 errors** (888 warnings), 17 min 39 s.
   2. **Civil net10 full: 19,154 total, 19,134 passed, 19 skipped, 1 failed** = the known Glen Eira back-test (`BackTest_GlenEira24115_Computed_WithinTolerance`), the only red by name. Same totals as the assembler.
   3. **Civil net48 focused: 348 of 348** (DoubleClick, CheckIgnore, IgnoreFindingPicker, IgnoredChecks, Bug859, KeywordPromptBracketTag, CrossModuleGuard, SettingsWindowV3, SettingsLoadRobustness, SettingsValueCatalog, AdvancedSettings, DownpipeSettings, RedoSafe).
   4. **Manager net10: not run** (no Manager file changed).
6. **What Tim will see in AutoCAD, in plain words:**
   1. **Downpipe double-click (BUG-859):** double-click the outer circle, the red centre or the angled DP text of a placed downpipe and CE's small Edit source window opens (tag DP1, Show label, Remove), instead of AutoCAD's attribute editor. This now also works in a roof plan that has downpipes but no pits or pipes yet. Cancel says "Nothing was changed."
   2. **Everything else keeps AutoCAD's editor:** a pit, a pit label or a title block still opens AutoCAD's own editor. Typing EATTEDIT, the ribbon button and Ctrl+1 still open AutoCAD's editor too.
   3. **Switch OFF:** with Settings > double-click > source Edit window OFF, a downpipe double-click opens AutoCAD's editor again.
   4. **CDCHECKIGNORE:** does nothing until Settings > Checks > "Allow a finding to be ignored, with your reason, name and date" is ticked (it says so and changes nothing). Ticked: it asks Ignore or Unignore, lists the findings numbered, asks which one, why (1 Survey, 2 Council requirement, 3 Engineer's judgement, 4 Other) and a note, and saves the answer in the drawing. One U takes it back. Unignore brings one back.
7. **New defaults, judged (no switch added or changed by this train):**
   1. **`doubleClick.sourceEditWindow`: ON, same as C-58 and C-59.** #1520 only moves the `true` into one named constant `SourceEditWindowDefault`. A settings file without the key loads ON (pinned by `ASettingsFileWithNeitherKey_LeavesPitLabelSwitchOff_AndSourceSwitchOn`, which reads `{}`). What Tim sees changes by default (downpipe double-click opens CE's window), and that is right: the old behaviour (AutoCAD's attribute editor on a downpipe) IS the BUG-859 defect. Kept ON.
   2. **`checks.allowIgnoreFinding`: OFF**, unchanged (`UserSettings.cs`, `= false`). Missing key loads OFF (plain property default; `IgnoredChecksTests` pins the saved value false). Nothing visible until ticked. Kept OFF.
   3. **`doubleClick.opensEditWindow` (the pit-label switch): OFF and untouched** (`OpensEditWindowDefault = false`; `git diff` of `Modules/Drainage/Models` has no change to it). Same `{}` test pins it OFF. Tim's call after a Codex look (entry 1588 item 10).
8. **Switches without a Settings page row (I built none):** `doubleClick.sourceEditWindow` (owed, entry 1582 item 5), and from earlier trains `checks.leaveOutRemovedPits`, `tidyLeaderOut`, `layerChecks.wrongLayerRows`, `layerChecks.layerDiffersRows`, `checks.showProgressWhenSlow`, `checks.progressAfterSeconds`, Manager `update.finishWhenAutoCadCloses`. `checks.allowIgnoreFinding` and `doubleClick.opensEditWindow` HAVE rows (CDS > Advanced and the Civil settings page).
9. **Installer safety: the train cannot affect the signed-update gate (OfficialReleaseGate) or SafeBundleInstaller.** By diff: 0 files under `Shared/` (where OfficialReleaseGate lives), `Installer/`, `Installer.Tests/`, `CE.Host` or `Modules/Manager`; no `.csproj`, props, targets, PackageContents.xml or Plugin.cs changed. One command added to Civil's own registry (CDCHECKIGNORE, hidden), which the command-count guard expects (146).
10. **Do not mark FIXED:**
    1. **BUG-859:** needs a robot PASS plus a Codex PASS in AutoCAD, on copies: circle, centre and DP text open the Edit source window; a pit label and a title block still open AutoCAD's editor on the right block; source switch OFF gives AutoCAD's editor; a downpipe-only copy (no pits, no pipes) opens the Edit source window; Cancel and Esc change nothing; one U undoes an OK.
    2. **UX-DI-03 CDCHECKIGNORE:** needs a Codex PASS with the switch ticked (Escape at each question changes nothing; one U takes an Ignore back; Unignore brings it back; switch OFF says so).
    3. **Codex look still owed from C-59:** CDS > Advanced at 150% on 1920x1080.
11. **Four words:** built and unit-tested. Not installed. Nobody has opened any of it in AutoCAD. Nothing is Tim-accepted or Codex-accepted.

## 1. Review of the merged PRs

1. **#1520 (BUG-859), reviewed head 3563aa9d to merged head 9daa061d:** the change after the reviewed head is exactly entry 1588 item 5 and no wider:
   1. **Code:** one line in `TryRedirectToCdEdit`: `if (!hasCeEntities && !exactDbTextDoorwayOnly && !DoubleClickEditTable.IsWatchedForSourceWindow(cmd, sourceEditWindow))`, plus a two-line comment. `cmd` and `sourceEditWindow` are both parameters of that method (the second added by 3563aa9d and passed from `OnCommandWillStart`). `IsWatchedForSourceWindow` is true only for EATTEDIT with the source switch ON, so every other command keeps the BUG-043 "no civil data" bypass.
   2. **Why it is safe:** with the pit-label switch OFF, step 0b in `ResolveCompoundRoot` returns only a `BlockReference` that carries a CE source tag (`IsTaggedSourceBlock`, pits excluded) and null for anything else, so a Structural drawing (no tagged sources) gets AutoCAD's editor. With the pit-label switch ON (not the default) step 0b is skipped and the pit / pit-label steps run, which find nothing without CE data.
   3. **Test:** `TheNoCivilDataBypass_IsExemptForTheSourceSwitchAttributeEditor` finds the bypass line inside `TryRedirectToCdEdit` and requires the exact exemption text on that line. On 3563aa9d the line ends at `!exactDbTextDoorwayOnly)`, so the test is red by construction on the old code. One REGRESSION_LOG entry added (9daa061d moved it beside the PR's own entry).
   4. **Entry 1588 items 3, 4 and 11 still hold in the merged code:** `NeedsRecentDoubleClick` still lists EATTEDIT, so a typed EATTEDIT, the ribbon button and Ctrl+1 return before any redirect; a pit label or title block resolves to null in step 0b, so AutoCAD's editor runs; source switch OFF makes the gate exactly the C-59 gate; the resolve is a read-only transaction and CDTAG opens the window only after `TryCheckSourceProtection` (locked layer, Xref, locked label or hitbox: "Nothing was changed"); Cancel writes nothing; CE adds no undo step, so no REDO is lost by CE.
2. **#1517 (UX-DI-03), reviewed head bd84d3cf to merged head 440b13fa** (fix round 9621f604, then a merge of the C-59 line):
   1. **MEDIUM 1 fixed:** `new PromptKeywordOptions("\nIgnore or Un-ignore a finding")`, then `Keywords.Add("Ignore")`, `Keywords.Add("Unignore")`, `Keywords.Default = "Ignore"`, `AppendKeywordsToMessage = true`, `AllowNone = true`. The message carries no bracket tag of its own; the BUG-174 guard passes (inside the 348).
   2. **MEDIUM 2 fixed:** `CrossModuleGuardTests` expects 146 with the CDCHECKIGNORE note; passes on net48 and net10.
   3. **LOW 1 fixed:** Unignore lists 40, then "... and N more (type their number to bring one back).", and accepts any number up to the full count, same as Ignore.
   4. **LOW 2 holds:** `IgnoredChecksStore.Ignore` stores `Note = string.IsNullOrWhiteSpace(note) ? null : note.Trim()`, so a blank note is none.
   5. **Entry 1575 points re-confirmed:** switch OFF prints "Ignoring a finding is switched off in CE Settings. Nothing was changed." and returns before reading anything; every question returns on Escape before any write; the only writes are `ProjectDataService.WriteIgnoredChecksInDrawing` (unchanged by this train: own key in CE's project record, one transaction, then a re-read of the drawing, inside a Modal command, so one U takes it back and U / REDO stay right); no drawing object, layer or Xref is opened for write; `IgnoreFindingPicker.Candidates` skips `CheckStatus.Ok` rows and keys starting `couldnot|`, so a fine row and a "CE could not check" row are never offered.
3. **Merge conflicts, read adversarially:** the two PRs share only REGRESSION_LOG.md (#1520: 7 files, #1517: 6 files, no other overlap). Both CDCHECKIGNORE paragraphs sit at the top (lines 1 to 10), both BUG-859 entries at the end (lines 44435 to 44450 after my fix), 0 conflict markers. The one defect was the missing blank line before the C-59 heading (fixed, item 3 above). Placement (new entries at the end for BUG-859, at the top for CDCHECKIGNORE) left as merged: harmless, both present.
4. **Scope:** nothing under Shared/, Installer/ or Modules/Manager changed (diff empty), so Manager need not be rebuilt and Civil and Manager carry the same CE_SHARED.

## 2. Build and test evidence

1. Private worktree `C:\ce-fin\c60` (detached at 037b9311, then my commit), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers` (solution `-m:1`), Below Normal. Refs as in the assembly report (`_AcadRef48` CERef 24.3.0, `_AcadRefNet8` autocad-2026-ref, `_AcadRefNet10` AutoCAD 2027, `_AcadRef100` autocad-net8-ref), AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder created (untracked build output), fresh Temp folder and CE log folder inside it per step.
2. **Build lock:** taken by exclusive create only while each command ran, removed after each; not present at the end.
3. **AutoCAD was not running** (0 acad.exe at 17:06 and 18:01). The build started at 17:08, inside Tim's 3:00 to 5:30 pm window, at Below Normal; with AutoCAD closed it competed with nothing.
4. **My own mistakes (cost time only, no effect on results or on Tim's PC):**
   1. My first solution build started with its arguments dropped (no solution name, Debug, no `-m:1`); I saw it within a minute and stopped it. `-p:SkipDevBundle=true` was on, so the live bundle was never at risk.
   2. My net48 focused filter first included the bare word `Settings`, which matched the whole net48 suite: three full net48 runs (about 15 minutes) before I switched to the named Settings classes the assembler used. By-product: full net48 gives 19,005 total, 18,244 passed, 391 skipped, 370 failed; none of the 370 is a test this train touched (checked by name), and all 370 carry the usual AutoCAD-stub load errors. I did not run a base comparison for full net48 (not asked; not used for the verdict).
5. **Tim's four settings files, before (17:06) and after (18:01): unchanged**, same content and modified times: `TIM_CE_CADTOOLS\CD_Settings.json` acd64e7 (15,270 bytes, 11 Mar 08:22), `TIM_CE_CADTOOLS\CS_Settings.json` 622a246 (351,713 bytes), `CE_CVL_SUITE\settings.json` efe307c (672 bytes), `CE_STRUC_SUITE\CS_Settings.json` 2972ce7 (35,259 bytes, 22 Oct 14:37, before this job, as the assembler found).
6. **Not run:** Manager (unchanged), Structural, Installer.Tests (compiled only), Civil net8, anything in AutoCAD, accoreconsole, Codex. Nothing deployed or installed.

## 3. Risks

1. **Carried LOW (entry 1588 item 7), now slightly wider:** any block with attributes that is not a downpipe (a pit label, a title block) passes through CE's read and pick re-set before AutoCAD's editor, and after the 1588 fix this also happens in drawings with no CE pits or pipes (for example a Structural or architect's drawing). CE then lets AutoCAD's editor run on the same pick. The Codex look must double-click one pit label and one title block, ideally in a drawing with no CE data too, and see AutoCAD's editor on the right block.
2. **Green DP label** still opens AutoCAD's text edit (separate cause, entry 1588 item 9; not in this train).
3. **The 150% CDS > Advanced fit** still has 20 px of room (tallest tab 670 px, unchanged by this train).

## 4. Hygiene

Worktree `C:\ce-fin\c60` removed (`git worktree remove --force`, then pruned), `C:\ce-fin\c60logs` deleted; main checkout unchanged. DESK_LOG.md not edited. No PR merged, closed or deleted by me; no version bumped; nothing installed.
