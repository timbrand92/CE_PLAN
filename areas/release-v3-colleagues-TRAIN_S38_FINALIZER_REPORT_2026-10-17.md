# S-38 Opus finalizer: Structural train claude/rel-20261017s

Independent check of what S-38 adds on top of S-37 (`claude/rel-20261010d` = `0dfbd1d6`, Structural 1.0.117). Sat 17 Oct 2026, about 04:01 to 05:05 Melbourne time (PC clock). Opus 5.5 on the Max account, for the desk (plan/03). Worked in my own isolated worktree on a local branch `s38fin` (the branch name itself is still checked out in the assembler's worktree), pushed to `claude/rel-20261017s` as a normal fast-forward. I did not start AutoCAD or accoreconsole, deployed nothing, wrote nothing under ApplicationPlugins or `Shared/`, changed no version field, csproj or Plugin.cs, and never wrote to Tim's settings files.

## ANSWER FIRST

1. **GO at `bf33ad789b25a2109129d3314621bfad27fa17e7`.** Nothing HIGH, nothing MEDIUM left. Four LOWs, none blocking.
2. **One commit of mine, `bf33ad78`:** the BUG-632 section mark layout (letter in the clear half of the bubble) now ships OFF. Test red first. One REGRESSION_LOG entry in AutoCAD words.
3. **The two fix heads with no Opus re-check are right:** #1304 `dc7dfe19` (F keeps the typed note, Esc after F adds nothing, the preview redraws straight after F) and #1300 `bf7a3e82` (no handle on the command line, names "Dim scale linear" in Properties).
4. **The assembler's two allow-list additions are right and kept** (AskYesOrCancel; the two beam files that read the drawing units only to name them).
5. **Tests at my head:**
   1. **Structural net10:** 5148 passed, 0 failed (assembler 5149; counting difference explained in section 4).
   2. **Structural net48:** 4411 passed, 36 failed, 698 not run (assembler 4412 / 36 / 698). The 36 sit in the same nine old classes.
   3. **Guards:** all pass on both lanes.
6. **Tim's three settings files are unchanged** before and after my run (sizes and hashes in section 5).
7. **Built and unit-tested only. Nobody has opened this train in AutoCAD.**

## 1. The new defaults, one by one

1. **Options.RestoreCurrentAppearance, ON: keep ON.**
   1. **Why:** Tim's approved ST3-2 says commands "must restore the drafter's previous layer, style, snaps and other AutoCAD settings afterward". The old behaviour (AD, LD, Q, QD, RD leave TIM LEADER current; 25C leaves lineweight ByLayer) is the bug, BUG-621 and BUG-646.
   2. **What the drafter sees:** after AD then Esc, the dimension style, colour, linetype and lineweight are what they were before.
2. **Options.RebuildDimensionAfterScaleChange, ON: keep ON.**
   1. **Why:** approved ST3-12 and BUG-635's expected result say the stored scale and the visible number must agree. Changing the factor and leaving the old number on screen is the bug. The new part only warns, never blocks.
   2. **What the drafter sees:** DSET, DSET1 and DUP redraw the dimension. If it still shows the old number, one line says so and names Dim scale linear in Properties (Ctrl+1).
3. **Layouts.FollowAnyDrawingScale, ON: keep ON.**
   1. **Why:** approved ST5-6 ("supporting normal scales such as 1:20, 1:50 and 1:100") and ST3-11 (break line sized to the plotted scale). The old refusal at 1:50 was also a hard block (R-27).
   2. **What the drafter sees:** CEHATCH and BL work at 1:50. At 1:20 and 1:100 nothing changes.
4. **Annotation.SectionMarkIdentifierInClearHalf, was ON: now OFF (my commit).**
   1. **Why:** no ruling covers the new bubble layout. BUG-632's own record asks to confirm Tim's bubble layout "before geometry changes".
   2. **The catch:** with Tim's default Left view, a two-character identifier such as 01 or A1 comes out about 2.3 mm instead of 2.5 mm. Every such mark also prints an extra "drawn smaller" line.
   3. **What the drafter sees now:** SM is exactly as on 1.0.117. Turning the switch on brings the new layout back.
5. **Options.FastSaveAlsoCleans, OFF: FASTSAVE now only saves. Tim should hear this.**
   1. **Why it is right:** it follows his approved ST5-14 ("save is not cleanup").
   2. **Why he should hear it:** anyone used to FASTSAVE purging and moving Xrefs onto the XREF layer will notice it no longer does. CLEAN still does that. The switch brings the old FASTSAVE back.
6. **Other new switches, OFF or equal to today:** SectionMarkOfferNextIdentifier OFF; SectionMarkSkipLetters blank; RafterJoist.SizeReadbackToleranceMm 0.5 (warn only).
7. **On Tim's PC:** his Structural Settings file stores none of these keys, so every default above reaches his PC (read-only search, nothing written).

## 2. The two fix heads and the assembler's test lists

1. **#1304 at `dc7dfe19` (BUG-622, MLL and MLR "F swaps the side"): right.**
   1. **F:** the drag is started again whenever AutoCAD returns the F keyword (`MLeaderSideRule.DragUntilNotKeyword`, `MLeaderCalloutService.cs:53`). The note object and its words are kept; only the side flips.
   2. **Esc:** Esc returns Cancel, the loop ends, and the note is thrown away with nothing added (line 56).
   3. **Preview:** a "side just changed" flag makes the first sample after F redraw, even with the mouse still (`Sampler`, lines 406 to 421).
   4. **Loop safety:** each repeat waits for the drafter, and a cap of 1000 protects against a host that does not wait.
   5. **Tests:** six tests (F then click, F twice, Esc after F, click only, redraw after F, and a source check that no single drag call remains).
2. **#1300 at `bf7a3e82` (BUG-635 wording): right.** The command line now reads like "The scale was changed, yet the dimension reads 5000 but should read about 1000 (length 5000 x Dim scale linear 0.2). Nothing was blocked. Look at its Dim scale linear in Properties (Ctrl+1, Primary Units)." The handle goes to the CE log only.
3. **Assembler commit `d13c6768`, both judged allow-list additions kept:**
   1. **AskYesOrCancel:** it takes the plain "Use N2? " from its one caller, and AutoCAD adds "[Yes/No] <Yes>" once. That is exactly what the doubled-question guard's helper list is for.
   2. **The two beam prompt files (#1294):** they read the drawing units only to name them in the refusal line (`BeamCommandAutoCadPromptAdapter.cs:38`, `BeamSpecialCommandAutoCadPromptSession.cs:96`). They work out no size from them.
   3. **The host-file list (`BeamDrawingUnitsUnsupportedException.cs`):** a new file, by intent.

## 3. Tim's rules, whole train

1. **Redo-safe (guardrail 8 item 17):** the redo guard passes on both lanes. #1282 added 13 baseline lines itself; I proved them rather than trusting them:
   1. `RegisterPendingRestore` has no caller.
   2. `HookRestoreHandlers` is called only from it, so the three restore event handlers are never attached.
   3. Even if they were, `OnRestoreCommandFinished` returns at the end of U, UNDO, REDO and MREDO (`DimensionCommands.cs:1093`).
   4. The restore that really runs sits in the finally of the drafter's own command.
   5. I added no baseline lines.
   6. The other added transactions (CEHATCHAUDIT, XRL, SM) and the restore's SetSystemVariable all run inside commands the drafter starts. None runs on an idle, document-switch, selection, palette, overrule or timer path.
2. **Locked layers, Xrefs, REFEDIT:** nothing unlocks a layer. ABS, DSET, DSET1, DUP and XRL check the layer before any write and say "Unlock it and run ... again". CXREF only reads. Nothing touches REFEDIT.
3. **No hard blocks (R-27):** the new checks warn (the dimension read-back, the size read-back, the MLL wrong-side line) or are questions (the wind class). #1294's beam units refusal is an existing stop, now named earlier: a beam cannot be sized in feet or unitless. FollowAnyDrawingScale removes a hard block.
4. **Settings-first (R-00):** every new behaviour has a switch. Fixed numbers remain (the 1.5/2/2 mm sheet break sizes, the bubble 4 mm and letter-width estimate), already logged as LOWs in entries 1061 and 1067.
5. **No blue, plain English:** no blue added. The one new window colour is OrangeRed status text. Messages name the AutoCAD command or field.
6. **Integrity:**
   1. No version field changed, and `Shared/` is untouched.
   2. The Structural command registry is still 375 entries and valid JSON. Only #1304's two prompt strings changed.
   3. REGRESSION_LOG only gained lines (254 added, 0 removed), stored LF, 0 control characters in added lines. The 2 repeated headings are the old ones.

## 4. Builds and tests

1. **Builds:** Release, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, build lock taken and released for every build and test run. net48 refs from the CERef folder; net10 off the AutoCAD 2027 install.
   1. **Results:** Structural.Tests plus Structural, net10 and net48, both 0 errors.
   2. **Restore:** the Hosted assets needed one `restore -p:EnableUnifiedHostAdapters=true` first.
   3. **Not built:** net8 and DesignCore. My change does not touch DesignCore.
2. **Red first:** `TheSwitch_IsOffByDefault_UntilTimRulesOnTheBubbleLayout` failed 1 of 16 before the change. After it, all 16 pass, plus 178 of 178 in the neighbouring classes (MLeader, dimension read-back, redo, appearance, drawing scale, section marks).
3. **Structural net10: 5148 passed, 0 failed.**
   1. **Method:** the assembler's 413-class list in chunks, NUnit workers 1, a 600 s kill timer, `CE_LOG_DIR_OVERRIDE` at a scratch folder and AutoCAD 2027 on PATH.
   2. **What hangs:** `SbeamEditAutoCadEvidenceReaderTests` hangs on its own (killed at 120 s, my process tree only). That is the evidence class the assembler left out. A whole-assembly run without it also hung (killed at 540 s).
   3. **The 1 short of the assembler's 5149:** my filter matched whole class names between dots, so it misses tests inside nested classes. A separate run of the nested-class tests gave 7 of 7 passed. I could not reconcile the totals to one exact number. No run had a failure.
4. **Structural net48: 4411 passed, 36 failed, 698 not run.**
   1. **The 36:** 26 test names. They sit only in BeamWallClashGeometryTests, DbTextMoveAnchorReconcilerTests, SbeamAutoCadPlacementAdapterTests, BracingLengthSettingsTests, BeamCommandAutoCadPromptAdapterTests, S2UndoReviewFixTests, StructuralWindowRenderTests, HatchBackgroundContractTests and CeSharedBinaryCompatibilityTests, the same nine old classes as the assembler and S-37.
   2. **The 1 short:** the same filter cause as net10.
5. **Guards:** all pass on both lanes, run inside the full runs and again by name: the command-class list, the Foundations choice list, the AutoCAD-copy-off guard, the doubled-question guard, the Plugin.cs pin, the units allow-list (skipped on net48 by design), and the redo call-graph scan.
6. **Not run:** net8 tests, DesignCore, the evidence class, Drainage, Manager, Installer. Nothing was opened in AutoCAD.

## 5. Hygiene

1. **Tim's settings files, before (04:04) and after (04:58), identical:**
   1. Structural CS_Settings: 34,217 bytes, `C5186042053FF7C5`.
   2. TIM_CE_CADTOOLS CS_Settings: 351,713 bytes, `622A246F7D3B1629`.
   3. CD_Settings: 15,270 bytes, `ACD64E79A33BE9C1`.
2. **Processes:** acad.exe was not running at either check. No testhost was left behind, and the build lock was released.
3. **Pictures:** test passes rewrote six pictures under `docs/image/V3_WINDOWS`. I restored them, and `git status` was clean before the commit.
4. **Push:** `d13c6768..bf33ad78` to `origin/claude/rel-20261017s`, fast-forward. The leak scan was clean. #1300 and #1304 heads were re-read on GitHub before the push: unchanged.
5. **For the controller:** the assembler's worktree (`agent-adfd2217...`) still has `claude/rel-20261017s` checked out at `d13c6768`. Fast-forward it before reuse.

## 6. Findings

1. **LOW 1: CXREF can still print raw program text.** When the failure is not an AutoCAD error (for example the clipboard file cannot be written), `NativeCopyPasteXrefService.FailureWords` puts the .NET message on the command line (`NativeCopyPasteXrefService.cs:158`). The CE log has the details anyway. Does not block.
2. **LOW 2: the test total cannot be pinned to one number** with class-name chunks. Nested-class tests need their own filter. Does not block.
3. **LOW 3: the new switches have no Settings window rows.** They live in the file only, a standing R-00 gap. A Codex check of the Settings window will not find them. Does not block.
4. **LOW 4: open LOWs carried, not fixed:**
   1. **Entry 1062:** a digit in a dimension prefix; DIMLUNIT 6 not judged; the read-back happens before commit.
   2. **Entry 1063:** the MLL side tolerance at other scales.
   3. **Entry 1064:** blank-sheet marks pooled across layouts.
   4. **Entry 1066:** the "no style overrides" wording.
   5. **Entry 1067:** sheet text in metre drawings; break sizes in two places; footing labels on the sheet.

## 7. What Codex should check in AutoCAD (copies only)

1. **MLL F:** type `MLL`, click the arrow point, type a two-line note, move the mouse, type `F`. The note jumps to the other side at once. Type `F` again, then click. One note with both lines, on the left.
2. **MLL Esc after F:** `MLL`, arrow point, note, `F`, then Esc. Nothing is added.
3. **DSET1 on a 5000 mm TIM LEADER dimension:** the dimension reads 1000 straight away. If it does not, one line names Dim scale linear in Properties and no handle appears.
4. **AD then Esc:** set Standard and colour green first. Afterwards Standard and green are still current.
5. **CEHATCH at DIMSCALE 50 / LTSCALE 500:** the preview and the placed hatch work, and there is no refusal.
6. **SM:** Left view, A, sheet S02. The A is at the centre of each bubble, as on 1.0.117.
7. **FASTSAVE** on a copy with an unused layer and an Xref on layer 0: it saves only. The unused layer stays, and the Xref stays on 0.

OPUS SIGN-OFF train claude/rel-20261017s GO (bf33ad789b25a2109129d3314621bfad27fa17e7)
