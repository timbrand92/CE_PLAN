# Train C-55 finalizer report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020i` at `8e76e1d9f0d07be4ba4b716fee79b3d4335b0d26` (ls-remote equal to the assembly report at start and at end). Base: the installed line `claude/rel-20261020h` @ `6644752b` (Civil 3.0.64 / Manager 1.1.64, C-54).
3. **What I changed:** nothing on the train. No commit, no push to the plugin repo. No fix was needed.
4. **Manager must ship: NO.** The train touches no file under `Modules/Manager`, `Shared/`, `Installer/` or `Installer.Tests/` (checked: `git diff --name-only 6644752b 8e76e1d9` gives 3 files, all Civil). Civil and Manager keep the same CE_SHARED. I did not run the Manager release build because no Manager file changed.
5. **Tests (Release, final head):**
   1. **Whole solution:** 0 errors.
   2. **Civil net10 full:** 18,957 total, 18,937 pass, 19 skipped, 1 failed (Glen Eira back-test, the known red).
   3. **Manager net10 full:** 832 of 832.
   4. **Civil net48 focused:** 286 run, 284 pass, 2 failed (the two known `BranchHostLabelTidyRuleTests` stub failures, which the assembler proved also fail on the base `6644752b`). All 8 new BUG-856 tests pass on net48 and net10.
6. **What Tim will see in AutoCAD:** on the Tidy labels preview (CDTIDYLABELS), a pipe that has one pit and one open end is now named. Before: "a pipe's start invert text would move 235 mm (the other side)". Now: "pipe P8 -> open end start invert text would move 235 mm (the other side)". An open start reads "open end -> P11". Pipes between two pits, or with their own name, read exactly as before. Nothing moves differently. The same name now also appears in the locked-layer line after a pit move, the CDEDIT batch line, CDRECOVERINVERTS, the rising-main line and the CDRUNSOLVE outcome line.
7. **Do not mark FIXED:** BUG-856 (only unit-tested; nobody has run Tidy labels on it in AutoCAD).
8. **Switches without a Settings row (standing list, unchanged):** `fleetTelemetry.heartbeatEnabled`, `linking.tidyIgnoresSheetFrame`. This train adds no switch and changes no default.
9. **Risks:**
   1. **LOW wording:** "open end" is said whenever CE's record has no pit name at that end. A pipe joined to a pit that has no name yet would also read "open end". Rare (pits get names when placed); words only.
   2. **LOW wording:** the two halves of a rising main may now read "P8 -> open end" and "open end -> P11", because the join between the halves has no pit. Words only.
   3. **LOW test gap:** no test runs the tidy-up plan to prove the move counts are unchanged; I proved it by reading every place the name goes (it only ever builds message text). The existing Tidy tests (net10 full, net48 focused) all pass as before.
   4. **Structural settings file (carried from the assembler):** `CE_STRUC_SUITE\CS_Settings.json` was already `f68eeb5e` when I started (changed at 18:24:30, during the assembler's run). It did not change during my run. No Civil or Manager code or test refers to that file, so the Civil tests are an unlikely cause. Someone should still look at it.

## 1. Re-review of MERGE-WITH-FIXES PRs

1. **None on this train.** The only merged PR is #1486, which had no review at all, so it got the full review below.
2. **Shared/:** unchanged (0 files). Installer/: unchanged (0 files).

## 2. #1486 (BUG-856) full review: GO, 0 fixes

1. **What it does:** the pipe-name helper (`PitMoveLockedPipeRule.PipeName`) used to give no name to a pipe with one pit and an open end. It now names it by its one pit plus "open end". A real pipe id still wins; two pits read as before; a pipe with no pit at either end still gets no name, and a drawing handle is still never shown.
2. **Does every Tidy line name the pipe and the end?** Yes. The Will move, Placed by hand and No clear spot lines all take their words from the same item words (`DrafterNameRule.PipeTextWords(pipeName, role)`), which carry the pipe name plus which text it is (start invert text, end invert text, the pipe label, the callout). An ordinary-block obstacle does not change this: the block is the obstacle, the moving item is still the named pipe text. The open-end pipe is the case the PR adds.
3. **Is the decision code untouched?** Yes. I followed the name into every caller (Tidy labels, locked-layer move line, CDEDIT batch, PipeBatchReadRule, CDRECOVERINVERTS, rising main, CDRUNSOLVE, source split, Agi). Every one only builds message text. The tidy-up's only word-based decision is "is this obstacle a block" (words start with "the block "), and pipe words start with "pipe " or "a pipe's", so it is not affected. The locked-layer line counts all pipes the same way; only the "and N more" split between named and unnamed changes.
4. **Plain wording:** yes ("pipe P8 -> open end start invert text"). Slightly long but clear.
5. **Settings page:** nothing hard-coded that belongs there (no number, no switch).
6. **Redo-safe:** yes. No drawing write, no transaction.
7. **Millimetre and metre drawings:** no units involved; the distance words are unchanged.
8. **Tests:** 8 new cases prove the words, including the unchanged cases and "never the handle". Written red first per its log entry.
9. **Files:** Civil only. No Manager or Shared file.

## 3. New defaults

1. **Switches or defaults added by the train:** none.
2. **Behaviour change without a switch:** the new wording. The old wording ("a pipe's", no name) is itself the bug (BUG-856), so no switch is needed. Tim sees the new words by default.

## 4. Installer safety

1. **#1475 is not on this train.** It landed earlier (entry 1481) and touched only `Installer/SafeBundleInstaller.cs`.
2. **Between the installed line `6644752b` and `8e76e1d9` nothing under `Installer/`, `Installer.Tests/` or `Shared/` changed.** `OfficialReleaseGate` is unchanged, so this train cannot affect the signed-update gate in any way. Installer.Tests compiled in the solution build; not run (rule).

## 5. Test evidence

1. **Environment:** private worktree `C:\ce-fin\c55` (detached at 8e76e1d9), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, 0-byte `CE_TRANSFORM_2027.arx` placeholder, AutoCAD 2027 on a short PATH, fresh TEMP and CE log folder per step, Below Normal. Build lock held only while each command ran; gone at the end.
2. **Two set-up slips of mine (no code cause), both re-run:**
   1. The first solution build gave 1 error: Installer.Tests could not run `git` because my short PATH left git out. I added git to PATH and re-ran: **0 errors** (5.0 min, 69 warnings on the incremental build; the first full pass showed the usual 889).
   2. The first Manager run had 8 failures because my CE log folder sat outside the test temp folder, and those tests check that every path is inside it. Moved inside and re-ran: **832 of 832**.
3. **Timings:** solution 9.6 + 5.0 min; Civil net10 5.5 min; Manager under 1 min; net48 focused under 1 min. Ran 18:31 to 18:53, outside Tim's AutoCAD hours. AutoCAD was not running.
4. **net48 filter:** RedoSafe, DoubleClick, Bug856, PitMoveLockedPipe, Tidy, DrafterName, PlanEditWords, PipeBatchRead. Failures: `SamePlanBreak_DoesNotAskForTheMainToBeTidied` and `XcivilImport_DoesNotAskForTheMainToBeTidied`, InvalidProgramException in the AutoCAD reference stub; the same two fail on the base (assembly report section 2.4). They pass on net10.
5. **Tim's settings files (before / after my run): unchanged.** `TIM_CE_CADTOOLS\CD_Settings.json` acd64e79 / acd64e79; `TIM_CE_CADTOOLS\CS_Settings.json` 622a246f / 622a246f; `CE_CVL_SUITE\settings.json` efe307c4 / efe307c4; `CE_STRUC_SUITE\CS_Settings.json` f68eeb5e / f68eeb5e (it had already changed before I started; see risk 9.4).
6. **Not run:** Installer.Tests (compile only), Manager release-candidate build (no Manager file changed), Structural, full net48, AutoCAD or accoreconsole.

## 6. Hygiene

1. Worktree `C:\ce-fin\c55`, `c55logs` and `c55tmp` removed. `C:\ce-fin\logs` is not mine and was left as found.
2. No PR closed, no branch deleted, no version bumped, nothing installed or deployed, DESK_LOG.md not edited.
3. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.
