# Train C-53 finalizer report (Civil + Manager), Tue 20 Oct 2026 (14:57 to 15:12 by the PC clock)

Opus 5.5 (claude-opus-5-5), Team, headless, desk plan/03.

**ANSWER FIRST**

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020g` @ `7375e3875605ef9be8f18b7b0b8f06fe1c761462` (normal fast-forward push from `ac4bab78`; `git ls-remote` equals local). The start head `ac4bab78` equalled the assembly report.
3. **What I changed:** one commit, `7375e387`, text only: the BUG-557 entry in `REGRESSION_LOG.md` had a tab character where `\t` belonged, so the outbox folder read "CE_CVL_SUITE<tab>elemetry"; it now reads `%APPDATA%\CE_CVL_SUITE\telemetry\outbox.jsonl` (Fable LOW, entry 1463). No code changed, nothing backed out, nothing held.
4. **Manager must ship: YES.** #1226 and #1169 change Manager files. **Civil ships too.** Nothing under `Shared/` or `Installer/`, no csproj, props or slnx changed between the installed line `7a4dd8de` and the final head, so CE_SHARED is identical for Civil and Manager.
5. **Tests (Release, final head):** whole solution **0 errors** (889 warnings). **Civil net10 full: 18,938 run, 18,918 pass, 19 skipped, 1 failed** (`BackTest_GlenEira24115_Computed_WithinTolerance`, the known red, also red on C-52). **Manager net10: 823 of 823.** **Civil net48 focused: 190 of 190** (the six new test classes plus RedoSafe, DoubleClick, RulebookValues, DetentionTwl). Nothing new is red.
6. **What Tim will see in AutoCAD, in plain words:**
   1. **CDIMPORTXCIVIL (#1228):** when the source drawing's units disagree with CE's size-based guess (for example the drawing says millimetres but the pits look metre-sized, so CE would make the job 1000 times bigger), a line starting "CHECK THE SCALE:" appears before the "Proceed with import? Yes/No" question. A normal metre or millimetre drawing shows nothing new. It never blocks; No still cancels.
   2. **CDTWL and CDRULES (#1239):** the detention freeboard is one value. **On Tim's PC no number changes:** his `CD_Settings.json` has both copies at 150 mm (read, not written). A drafter only sees a different number if someone had edited one copy and not the other; then both commands now print the same figure. **Tim does not need to be asked:** no default moved, and two disagreeing values was the bug.
   3. **Manager (#1226):** before an office administrator exists, the status line and the "Set up CE administrator" question now say only the person who looks after CE should answer Yes, otherwise "ask Tim". Both buttons use one wording.
   4. **Manager (#1169):** nothing visible. Dead Azure upload code and the empty `blob-config.json` are no longer shipped.
   5. **Civil start-up (#1171):** nothing visible. A new switch `fleetTelemetry.heartbeatEnabled` (ON = today) can stop the start-up heartbeat.
   6. **#1166:** nothing visible; a test that keeps every typed command name working.
7. **Do not mark FIXED:** BUG-516, BUG-505, BUG-476, BUG-557, BUG-556 and the command-name guard item (UX-NAMES-01/06). Built and unit-tested only; nobody has opened them in AutoCAD.
8. **Switches without a Settings row:** `fleetTelemetry.heartbeatEnabled` (new, ON, today's behaviour) and the standing `linking.tidyIgnoresSheetFrame` (ON). Also, neither detention freeboard copy (Design Standards or Pipe) has a Settings row: an R-00 gap that predates this train. No rows built.
9. **Risks:**
   1. #1239: someone who changed the Design Standards freeboard and later typed it back to exactly 150 while the old Pipe copy holds another number gets the Pipe number (LOW, needs both copies edited).
   2. #1228 opens the source drawing once more to read its units (a second read-only open; a few seconds on a large drawing at most).
   3. #1171 OFF also holds back the queued AI schedule-reading counts (the start-up send is the only send); safe for privacy.
   4. Installer.Tests compiled, not run (rule). Full net48 lane, Structural and AutoCAD not run.
10. **Tim's settings files: unchanged** (same at 14:57 and 15:10): `CD_Settings.json` 15,270 `acd64e79`; `CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.

---

## 1. Re-review (step 1)

1. **No MERGE-WITH-FIXES PR is on this train.** The round 11 verdicts were all plain MERGE: #1239 (entry 1432), #1228 (1436), #1226 (1437), #1171 (1463), #1169 (1465), #1166 (1468). Every merged head equals the reviewed head (assembly report, checked against the merge commit titles). So step 1 became the full Opus review below.
2. **Shared/:** `git diff 7a4dd8de..7375e387 -- Shared Installer *.csproj *.props *.slnx` is empty.

## 2. Opus review of each merge (step 2)

1. **#1239 BUG-516 (b), merge 78c7c668: MERGE, 1 LOW.** Root cause fixed: two settings both called `detentionFreeboardMm` (Pipe, read by CDTWL; Design Standards, printed by CDRULES) could disagree. One pure rule `DetentionFreeboardRule.Resolve` now feeds both: CDTWL (`DetentionTwlService.FreeboardMm`) and CDRULES (`RulebookValues.Resolve`, passed the Pipe copy from `ProjectDataService.Rulebook`). Design Standards wins when changed; an older file that only changed the Pipe copy is still honoured; nothing written; zero, negative or NaN never becomes the answer. Both default 150, `DetentionTwlSolver.DefaultFreeboardMm` 150. No project or council layer overrides freeboard, so no third source. Freeboard is millimetres, independent of drawing units. No switch needed: the old behaviour is the bug and default files give the same 150. LOW: typed-back-to-150 edge (risk 1). Tests: 9 in `Bug516bOneFreeboardTests`, pass on both targets.
2. **#1228 BUG-505, merge 50b02251: MERGE, 1 LOW.** The x1000 scale guess is now compared with the source drawing's INSUNITS; any disagreement (mm vs metre, cm/inch/foot read as mm, undefined or unreadable with a x1000 guess) adds one "CHECK THE SCALE" sentence at the top of the pre-flight lines and to the import warnings, before the Yes/No. Scale never changed, never blocks (R-27). Source opened read-only (`OpenForReadAndAllShare`, disposed), any failure is a debug line and -1; nothing is written to Tim's drawing, so locked layers, Xrefs and REFEDIT are untouched and undo/redo are unaffected. Plain words, no names. The 500 split only classifies the existing 1 or 1000 guess, not an engineering value. LOW: unusual units print as "units code N".
3. **#1226 BUG-476, merge 2ef21c83: MERGE.** Wording only: status line points to Admin Dashboard (a non-administrator can reach it) and both set-up buttons use `CeAdminPolicyService.FirstSetupQuestion`. The extra assembly conflict in `CeAdminPolicyServiceTests.cs` kept both groups: no duplicate test names, BUG-843 tests intact, 823 of 823 pass.
4. **#1171 BUG-557, merge 6d3c4f02: MERGE, 1 LOW (fixed).** Switch read first, before anything is queued; missing settings or missing group = ON = today. `SettingsService.Current` initialises itself on first read, so the switch is honoured at start-up. Groups `windowPlacement` and `fleetTelemetry` both kept in `UserSettings.cs`. LOW (entry 1463) tab character in REGRESSION_LOG: fixed in `7375e387`.
5. **#1169 BUG-556, merge c193846b: MERGE.** Deletes `CeAzureBlobService.cs`, `CeAzurePublishService.cs`, `blob-config.json` and the tests for them. Nothing references them: whole-repo search for the type names, `blob-config`, `ReadSasUrl` and `BlobConfig` finds only the new guard test, `.gitignore` (local file name), docs and a forbidden-words list in `ManagerUxRolloutAndHubTests`. The Manager csproj copies `Assets\Config\**\*` by wildcard, so no csproj or PackageContents line named the file; no PrivacyInventory file exists in the repo. `OfficialReleaseGate`, `ReleaseAuthorityPackaging`, `SafeBundleInstaller` and `CeApprovedReleaseService` are untouched, so the signed-update path and bundle verification (which hashes the files actually built) are unchanged. Manager builds 0 errors and passes 823 of 823; Installer.Tests compile.
6. **#1166 command-name guard, merge ac4bab78: MERGE.** Test only; all 139 names found as `CommandMethod` registrations; passes on net10 and net48. Optional LOWs from entry 1468 left (CDCHECKS, CDTIDYLABELS not listed; log says 137).

## 3. New defaults (step 3)

1. **`fleetTelemetry.heartbeatEnabled`, ON:** does not change what Tim sees (ON = today's heartbeat). Allowed: no behaviour change by default. No Settings row.
2. **No other switch or default added.** Behaviour changes without a switch, each because the old behaviour is the bug: the "CHECK THE SCALE" line (#1228; old: silent wrong scale), one freeboard (#1239; old: two disagreeing values, same 150 on default files), the administrator wording (#1226; old: misleading wording). Nothing turned OFF; no commit needed.

## 4. Installer safety (step 4)

1. **#1475 is not on C-53.** As entry 1481 recorded, it landed earlier (in the installed line) as `Installer/SafeBundleInstaller.cs` only.
2. **C-53 cannot affect the signed-update gate in any way:** no file under `Installer/` or `Shared/` (where `OfficialReleaseGate` and `CE.Release` live) changed between `7a4dd8de` and `7375e387`.

## 5. Build and test evidence (step 5)

1. **Environment:** private worktree `C:\ce-fin\c53` at `7375e387`; Release; `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`; `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`; AutoCAD 2027 folder on a short PATH; 0-byte `CE_TRANSFORM_2027.arx` placeholder; Below Normal; every command in the foreground; TEMP and a fresh CE log folder per run in `C:\ce-fin\c53tmp`. Build lock held only while each command ran (checked gone). Nothing deployed. AutoCAD and accoreconsole not running (checked).
2. **Timings:** solution 3 m 34 s; Civil net10 5 m 4 s; Manager 5 s; net48 focused 4 s.
3. **Hygiene:** worktree, `c53tmp` and `c53logs` removed; the local branch I made in the main clone was deleted (remote untouched); main checkout status as found. `C:\ce-fin\logs` is not mine and was left.

## 6. Not done

Installer.Tests run (compile only), full net48 lane, Structural, anything in AutoCAD. No version bump, no install, no PR closed or deleted, `DESK_LOG.md` not edited.
