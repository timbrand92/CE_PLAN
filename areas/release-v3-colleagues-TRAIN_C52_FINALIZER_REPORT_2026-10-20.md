# Train C-52 finalizer report (Civil only), Tue 20 Oct 2026 (14:03 to 14:20 by the PC clock)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03. Read `C:\TimOS\RULES.md` and the C-52 assembly report first.

**ANSWER FIRST**

1. **Verdict: GO.**
2. **Final head:** `5bc9616746a0b62ffea7e52044fcd3718798305e` on `claude/rel-20261020f` (`git ls-remote` equal to the assembly report at the start and at the end). Base: `claude/rel-20261020e` @ `279c231c`, the INSTALLED line (Civil 3.0.61 / Manager 1.1.61, C-51).
3. **What I changed: nothing.** No commit on the train, nothing pushed to the plugin repo. #1485 needed no fix.
4. **Manager must ship: no.** The train changes four files, all Civil: one new test file, `TidyObstacleRule.cs` (+14), `LinkService.TextClashTidyUp.cs` (+5), `REGRESSION_LOG.md`. No Manager, Installer, Shared, csproj, props or slnx file, so Civil and Manager keep the same CE_SHARED.
5. **Tests (Release, final head):**
   1. Whole solution: **0 errors** (889 warnings).
   2. Civil net10 full: **18,913 run, 18,893 pass, 19 skipped, 1 failed** — `BackTest_GlenEira24115_Computed_WithinTolerance`, the known red. Same total as the assembly run (C-51 18,909 + the 4 new tests).
   3. Manager net10 full: **824 of 824.**
   4. Civil net48 focused (same ten filters as the assembly): **222 run, 221 pass, 1 failed** — `Bug141_TheBlocksAtThePipeEnds_AreNotObstacles_ButOtherBlocksAndTextAre`, the known net48 reference-DLL stub failure, already failing on C-49, C-50 and C-51 (including the C-51 finalizer run on its final head). The 4 new `Bug141TextObstacleLineTests` pass on both targets.
   5. Nothing new is red.
6. **What Tim will see in AutoCAD:** nothing different on the drawing. Tidy labels moves labels exactly as before. Only when CDDEBUG is On, the CE log gets one extra line for each text a label bumps into, for example: `[TidyUp] SC (1A2B) on layer SLAB SC corners in drawing units (60000.50,-25000.00)-(61200.25,-24500.00) kept as an obstacle against the search window (...)`. That line tells us which "SC" text blocks the P3 -> P2 label and where it sits.
7. **Do not mark FIXED:** BUG-141 (built and unit-tested only; nobody has opened it in AutoCAD; this PR is diagnostic only and fixes nothing on the drawing).
8. **Switches without a Settings row:** no new ones on C-52. Standing list unchanged: `linking.tidyIgnoresSheetFrame` (ON, old behaviour is the bug) still has no Settings row.
9. **Installer and the signed-update gate:** C-52 does not touch the installer or `OfficialReleaseGate` at all, so it **cannot** affect the signed-update gate. #1475 is not new on C-52: its fixed head `f2c6f848` was merged into `claude/rel-20261020a` (merge `2eb72895`) and is already in the installed line. What it actually landed is 47 lines in `Installer/SafeBundleInstaller.cs` and its tests (clear read-only marks before deleting the installer's own generated folders). It does not touch `OfficialReleaseGate` either. **Correction to REVIEWLANE entry 1477:** that entry said #1475 "is not on this train ... edits OfficialReleaseGate.cs and three CE_SHARED files". It was already in the ancestry, and those files show up only because the PR's file list is compared with its stale base `claude/rel-20261019a`; they came from other PRs on the same train.
10. **Risks:** low. (a) The log line text is built for every kept text even when CDDEBUG is Off (one short string per text per pipe; the existing block line does the same) — negligible cost, not changed. (b) The line uses the text's own words, not "the text ...": a kept text reads `SC (handle)`, which is clear enough next to "on layer". (c) Leftover folder not mine: `C:\ce-fin\logs` (64 MB, test logs from 19 Oct 08:33 to 22:43) — left as found, it belongs to an earlier job.
11. **Your settings files:** unchanged (size and first 8 of SHA-256, before and after): `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `ACD64E79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622A246F`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24D8E5F7`; `CE_CVL_SUITE\settings.json` 672 `EFE307C4`.

---

## 1. Re-review of MERGE-WITH-FIXES PRs, and Shared/

1. The train holds one merged PR, #1485. No PR on C-52 carried a MERGE-WITH-FIXES verdict, so there is nothing to re-review in that sense.
2. `git diff 279c231c 5bc96167` lists four files and nothing under `Shared/`. CE_SHARED is identical for Civil and Manager.

## 2. #1485 full review (BUG-141 text obstacle, diagnostic only) — MERGE (GO)

Reviewed the merged diff `279c231c..5bc96167` and the surrounding code at the final head.

1. **(a) What the line says.** `TidyObstacleRule.KeptTextLine` writes: the text's words (the same shortened words the "no clear spot" message uses, line breaks removed, long notes cut), its handle, its layer (`?` if none), its corners and the search window's corners, two decimals, invariant culture. It goes through `LoggingService.Diagnostic`, which returns at once unless CDDEBUG logging is On. It is written for single-line text and multiline text (`DBText`, `MText`) only; callouts, dimensions and tables are still not named (out of scope, no change).
2. **(b) Decision untouched.** The scan only adds a new dictionary entry (text id -> layer) beside the existing list; the obstacle list, the sheet-frame check, the own-text skip and the 1,000-obstacle stop are unchanged. In `Filter` the new `else if` only adds a log call; `obstacles.Add(item.Box)` still runs on every path that reached it before. No new switch, no new number, no changed default — so no Settings row is needed. **Agreement test:** `TheScan_LogsATextAndStillKeepsItAsAnObstacle_NothingElseChanges` is a source guard that the line is written immediately before `obstacles.Add` with no `continue` in between, so a logged text is always a kept text. A text is never a sheet frame (only plain blocks are checked), so there is no "reason" that could disagree.
3. **(c) Safety.** Reads `entity.Layer` inside the scan's existing read-only transaction; no new transaction, no write, nothing drawn, no layer unlocked, redo-safe (nothing is added to the undo record). Wording says "in drawing units" (as #1483); figures are two decimals, so a metre drawing reads `0.40`, not `0`, and a millimetre drawing reads `60000.50`. Tested.
4. **(d) Performance.** **One line per text kept, per pipe search, with no separate cap.** Only texts that overlap that pipe's search window are logged (the label's own texts are skipped first). The hard upper bound is the existing stop at 1,000 obstacles per window. The callout-drag words (L8) scan once before the drag, not per mouse move. With CDDEBUG Off nothing is written.
5. **Tests:** 4 new (`Bug141TextObstacleLineTests`), pass on net10 and net48.

## 3. New defaults

1. **None.** C-52 adds no switch and changes no default. Nothing changes what Tim sees on the drawing by default.

## 4. Build and test evidence

1. **Environment:** private detached worktree `C:\ce-fin\c52` at `5bc96167`; Release; `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`; `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`; AutoCAD 2027 folder on PATH; 0-byte `CE_TRANSFORM_2027.arx` placeholder; Below Normal; every command in the foreground; Temp, logs and a fresh CE log folder per run inside `C:\ce-fin`. Build lock `C:\CE_PLAN\desk_jobs\build.lock` written only while each command ran (checked gone). Nothing deployed. AutoCAD and accoreconsole not running (checked).
2. **Timings:** solution 3 m 42 s; Civil net10 4 m 55 s; Manager 5 s; net48 focused 4 s.
3. **Not run:** Installer.Tests (compile only, rule), full net48 lane, Structural, anything in AutoCAD or accoreconsole.
4. **Clean-up:** worktree removed with `git worktree remove --force` and pruned; `c52logs`, `c52tmp` and the run script deleted.

## 5. What to test in AutoCAD (copy only)

1. Before starting AutoCAD, turn CDDEBUG logging on (or type `CDDEBUG` and turn it On in the session).
2. Open a copy of the run 31 downpipe drawing and run Tidy labels on pipe P3 -> P2 (and P4 -> P3).
3. Right looks like: the labels land exactly where they did on 3.0.61; the CE log has a `[TidyUp] ... on layer ... corners in drawing units ... kept as an obstacle against the search window ...` line for each text the label bumps into, including an "SC" text on layer SLAB SC. Send that line.
