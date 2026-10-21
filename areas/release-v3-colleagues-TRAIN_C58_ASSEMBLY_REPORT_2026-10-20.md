# Train C-58 assembly report (Civil + Manager), job dated Tue 20 Oct 2026 (run on the real clock Wed 21 Oct 16:24 to 17:10)

## ANSWER FIRST

1. **Branch and head:** `claude/rel-20261020l` at `2e63cc7a` (normal push, branch new on origin). Base `origin/claude/rel-20261020k` @ `5d1f9864` (installed Civil 3.0.67 / Manager 1.1.67, C-57). No version bumped.
2. **Merged: 3 PRs** (live head re-checked with gh immediately before each merge and equal to the head in its Opus entry): #1511 (a6bf49fa), #1512 (a5a1017a), #1499 (c897bdf2). One merge commit each, plain `git merge --no-ff`.
3. **Left out, with reasons:**
   1. **#1514 STOPPED: its live head is not the head named in Opus entry 1544.** Entry 1544 names `b18a07e9`; the live head is `57259b24` ("Fix round for #1514 (Opus 1544): progress line wording"). The old head is an ancestor of the new one (a plain fast-forward fix round: 3 files, 5 lines: the wording in `SlowWorkProgressTicker.cs`, its test, and REGRESSION_LOG). It looks like exactly the LOW wording fix from entry 1544, but nobody has reviewed `57259b24`, so I did not merge it. The finalizer or the next Opus review can take it at `57259b24` (merge note: base is rel-20261020k, only REGRESSION_LOG.md is expected to clash).
   2. Not on this train by the job text: #1508, #1515, #1516, #1507, the Structural PRs (train S-40), #1382, #1384, #1419, #1423, #1191, #1183, #1180.
4. **Shared/:** no merged PR touches `Shared/` (0 files). **Manager: no merged PR touches `Modules/Manager` or `Installer/` (0 files), so Manager does NOT need to ship with this train.** All three change Civil (`Modules/Drainage`) only.
5. **Build:** whole solution Release, 0 errors, 895 warnings (it took 19 min 48 s, not the usual 3 min, because the PC was busy).
6. **Tests (Release):**
   1. **Civil net10 full: 19,068 total, 19,048 pass, 19 skipped, 1 FAILED = the known Glen Eira red** (`BackTest_GlenEira24115_Computed_WithinTolerance`). No new red.
   2. **Manager net10 full: 837 of 837.** (My first two Manager runs showed 8 reds; see 3.1 below, that was my own test setup, not the code.)
   3. **Civil net48 focused: 178 of 178** (SourceEditWindow, ChecksWrongLayer, PitLayerFact, RedoSafe, DoubleClick, CrossModuleGuard, CeVersion).
   4. Installer.Tests: compiled in the solution build, not run (rule).
7. **Switches (the Settings-switch rule):**
   1. **#1512:** `layerChecks.wrongLayerRows`, default **OFF** (`UserSettings.cs` line 1978 `= false`). No Settings page row yet (known, Codex window lane).
   2. **#1499:** `doubleClick.sourceEditWindow`, default **ON**, deliberately: Tim asked for it on 20 Oct ("Double-click on a downpipe (DP1) opens a small Edit window like pipes", yes), and OFF gives the old command-line question. No Settings page row yet.
   3. **#1511:** no switch (pure, no caller).
8. **For the finalizer:**
   1. Take #1514 at `57259b24` if you review it (item 3.1), or leave it for the next train.
   2. The DP1 Edit window (#1499) has never been seen on screen: a Codex look is needed (RULES 5.7). BUG-748 / BUG-531 and the plan items UX-LYR-02, UX-PERF-01 must NOT be marked FIXED (REVIEWLANE entry 1560).
   3. **Tim's four settings files unchanged** (before and after, first 7 hex of SHA256): `TIM_CE_CADTOOLS\CD_Settings.json` acd64e7 (15,270 bytes), `CS_Settings.json` 622a246, `CE_CVL_SUITE\settings.json` efe307c, `CE_STRUC_SUITE\CS_Settings.json` f68eeb5. The `CD_Settings.json` swap seen on 20 and 21 Oct did not happen during this run.
   4. **I probably overwrote two small files in `C:\ce-asm`:** `hash.sh` and `hash_before.txt` (both now dated 21 Oct 16:24; `hash_after.txt` from 19 Oct is untouched). They may have held an earlier run's content. Nothing else outside my own worktree and folders was touched.

## 1. Merge list

1. **#1511 @ a6bf49fa6bc927ee6ffa650360a1c282654fb0a4** (UX-LYR-02 slice 1, wrong-layer section in the one Checks list). PR base `claude/rel-20261020k`. Not an ancestor (checked). Merge `e9836fcc`. **No conflict.** Numstat file list equals the PR's file list (3 files).
2. **#1512 @ a5a1017a15abc1c06bd039c7a2db3710f01c5d6f** (CDCHECK reads each pit's layer, switch OFF). PR base `claude/b4-wire-wronglayer` (= #1511, already in). Not an ancestor. Merge `dddf1093`. **No conflict.** File list equals the PR's (4 files).
3. **#1499 @ c897bdf20904859a2d38449fef63496755c69301** (DP1 double-click Edit window; round 12 LOW fixed). PR base `claude/rel-20261020i` (an older train, already in the base). Not an ancestor. Merge `2e63cc7a`. **Conflict: `REGRESSION_LOG.md` only** (one block); kept both sides by removing only the three marker lines, then checked that every line either side added is present (0 missing each way, no markers left). File list equals the PR's (7 files; REGRESSION_LOG.md +11).
4. **#1514: NOT merged** (item ANSWER 3.1; live `57259b24`, named `b18a07e9`).
5. Method held: no squash, rebase or cherry-pick; no PR closed; no branch deleted; no version edited; DESK_LOG.md not edited; nothing installed or deployed.

## 2. Test evidence

1. **Environment:** private worktree `C:\ce-asm\c58`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, no AutoCAD or accoreconsole. Net10 ref `C:\TimOS\refs\autocad\autocad-2026-ref` (`_AcadRefNet8`); net48 ref `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; AutoCAD 2027 folder on PATH; empty `CE_TRANSFORM_2027.arx` placeholder (git-ignored). Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each command ran (gone at the end). Run was in Tim's AutoCAD hours (3:00 to 5:30 pm window); Below Normal priority, and it explains the slow solution build.
2. **Civil total 19,068 is in the thousands**, so the wrong-ref-name trap is not in play. Net10 test duration 5 m 36 s.
3. **Manager first runs were red for my own reason:** I pointed `CE_LOG_DIR_OVERRIDE` at a folder outside the Temp folder, and 8 Bug842 / TestHygiene guard tests refuse that ("this test must only ever touch the run's temporary settings file"). With the log folder under `C:\Users\TimothyBrand\AppData\Local\Temp` the suite is 837 of 837. My first fix of the script mangled the path and made a stray folder in the main checkout (`SERSTIMOTHYBRANDAPPDATAocaltemp`); I removed it (empty), and the main checkout status is as it was at the start.
4. **The Civil net10 run used a log folder outside Temp too** (`C:\ce-asm\c58logs\celog_civil10`); its one red is Glen Eira and no Bug842 guard failed there.
5. **Not run:** Installer.Tests, Structural, full net48, Manager release-candidate build (Manager not touched), base re-run (no new red to compare), anything in AutoCAD.

## 3. Hygiene

1. Worktree `C:\ce-asm\c58` and `C:\ce-asm\c58logs` removed after this report is pushed; the scratch files I made in `C:\ce-asm` (`a.txt`, `b.txt`, `h.txt`, `m.txt`, `mb.txt`, `t.txt`) removed too.
2. **Four words:** built and unit-tested (one known red). Not installed. Nobody has opened it in AutoCAD.
