# Batch install on Tim's PC, 14 Nov 2026: the runbook (PREPARED, NOT INSTALLED)

**Owner: lane trust-acad-evidence (one owner, nobody else installs).** Controller: chat CE_ACAD / trust plan / plan / 01. Pattern: `INSTALL_TRIAL_13NOV.md`.

**The install waits for two things, both written here before anything is touched:** (1) the second review of the three heads saying **BATCH-READY** (a head marked NOT YET drops out of the batch and its bundle is not installed); (2) **Tim's own yes to this list**, asked by the controller ("One batch, ask me once", Tim 14 Nov 00:28). Outside his hours only.

## 1. What goes on, and what does not

1. **Civil 3.0.90.3** = what is on his PC now (3.0.90.2, build commit `5c89ce30` = 3.0.90 + PR 2073 + PR 2083) **plus PR 2092** (CDRUNSOLVE at a split, head `d686e787`) **plus PR 2099** (CDLPD takes only a CE pipe, head `9c3f088e`). Local build branch `batch-14nov-civil` (never pushed), build commit `11c0093c`. Product files changed against 3.0.90.2: four (`LpdCommand.cs`, `LpdService.cs`, `RunSolveCommand.cs`, `ProposalApplyService.PlanBuilders.cs`); no native, shared, Manager or Structural file. The merge of 2092 met test-tooling conflicts only (proof project, its command list, its README, REGRESSION_LOG), resolved by keeping both sides.
2. **Structural 1.0.126.1 (PR 2094 now at its second-review fix head `2205dfde`; BATCH-READY at the third look, 01:38, reviewsbatch-14nov-second-review.md)** = what is on his PC now (1.0.126, `8de95c34`) **plus PR 2094** (CLEAN and FASTSAVE never save a never-saved drawing or a template, head `226edc6c`). Local build branch `batch-14nov-struc` (never pushed), build commit `3c805169`. Product files changed: `CleanPipelineService.cs`, `DrawingAutoSaveService.cs`, `CeSheetsSyncService.cs`, the new `DrawingSaveGuard.cs`, and the version lines. No native file (the INSTALLED native module is reused, as for 1.0.126).
3. **Manager 1.1.89: untouched.** Civil's `CE_SHARED.dll` and `CE.AI.Core.dll` in the batch bundle are the INSTALLED bytes (after a stamp-only byte check), so Civil and Manager keep one identical CE_SHARED.
4. **Not in the batch:** PR 2096 (parked), 2089, 2090, 2100, 2078, 2041, everything else.
5. **Payloads (built to scratch, nothing under ApplicationPlugins touched):** see section 7 for paths, file counts and hashes.

## 2. Before anything is installed

1. No `acad.exe` (checked twice, a minute apart); re-read `C:\Users\TimothyBrand\.timos\autocad.json`.
2. **Backup:** the install script renames each live bundle to `<name>_PRE_<commit>_<time>.backup`; in addition a full copy of the three bundles to `C:\CE_WORK\scratch\trust_install\BEFORE_14NOV\` with a SHA-256 file list, checked, exactly as on 13 Nov.
3. The live state must equal the 13 Nov end state file for file (`END_STATE_13NOV_hashes.txt`, 2,922 files). If it does not, stop and tell the controller.
4. Settings files hashed; they must be identical at the end. C: over 25 GB free.

## 3. Install

1. `C:\CE_WORK\scratch\trust_install\install_batch14.ps1 -StrucBundle <path in section 7>` (a copy of the C-79b1 install method; refuses unless the live lines read Civil 3.0.90.2+5c89ce30 and Structural 1.0.126+8de95c34). `-CivilOnly` or `-StrucOnly` if one side drops out.
2. Read-back: every candidate file equals the live file (SHA-256), no extra file, versions 3.0.90.3 and 1.0.126.1 in Legacy, Net8 and Modern, CE_SHARED identical to Manager, settings unchanged. Then Manager and the ProgramData Manager copy checked against the backup file for file.
3. First start on a copy: the CE log shows "CE_CVL_SUITE v3.0.90.3 Started", the CE ribbon is built, no line about a file failing to load or a version mismatch.

## 4. The robot passes on scratch copies (each twice, in two separate AutoCAD starts)

1. **No regression of the mix-up fix:** the ten seen BUG-1456 sequences (S1 CDHELP, S1 CDS, S2 blank x2, S3 x2, R3, C3, R5, F) twice = 20 passes, as on 13 Nov; plus the nothing-disturbed list and PIT placed, saved, reopened.
2. **CDRUNSOLVE (2092):** the P10 split layout (P10 to P9 drawn first, P10 to P4 second) on a copy of the standard drawing: (a) with the stored LPD, Enter at the end-pit question: the new question "2 pipes leave pit P10. Which way does the run go? A = to P9, B = to P4"; answer B: the run reads P10 -> P4 and on; (b) the same with the LPD removed; (c) Esc at the question: "Cancelled - drawing unchanged.", record unchanged; (d) a picked end pit on the P4 leg: follows it without asking (the typed pick on 900 mm pits was refused on 14 Nov 00:16; if it is refused again, write COULD NOT TEST and leave it to Codex). Each of A, B, Enter and Esc is tried for real at the new question (second review, 01:22: the core-console check did not run the question itself). How the robot does it: letters and Enter can only be sent chained in ONE typed line before the question appears (for example CDRUNSOLVE, the P10 point, Enter at the end-pit question, then B); its `answer` verb cannot send a letter at a CE prompt and cannot see CDRUNSOLVE's questions; Esc is sent with its one-Esc verb once the question is waiting. If a chained letter is not taken, that step is for Codex or Tim.
3. **CDLPD (2099):** as far as the robot's press list allows: CDLPD opens its window; the robot may NOT press "Continue in drawing" (controller, 14 Nov; Tim to be asked). **A person or Codex must press it**, then: a plain polyline on layer 0 clicked as the pipe gives "[CE] That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. Run CDLPD again ..." with no marker, no note, no LPD stored; a real CE pipe sets the LPD as before; an older polyline on a CE pipe layer is accepted.
4. **CLEAN and FASTSAVE (2094), on a COPY of AutoCAD's own metric template only (never the office template):** for each case write the template copy's size, date and SHA-256 before and after. (a) new drawing from the template copy, never saved, CLEAN: one line "This drawing has never been saved, so CE did not run CLEAN and saved nothing ...", the copy unchanged; the same with FASTSAVE; (b) the template copy opened on purpose, CLEAN: cleaned, not saved, "This is a template or standards file (.dwt or .dws). CE cleaned it but did not save it ...", the copy unchanged (DRAFT default for Tim); (c) after Save As to a .dwg copy, CLEAN cleans and saves as before. CE's backup folder entries made by the test are removed afterwards (only the test's own).

## 5. Stop rules (as 13 Nov)

1. An install whose files do not match: run the put-back, verify, write it up.
2. A put-back whose files do not match the 13 Nov end state: stop everything, URGENT at the top of the status file, message the controller. No second method.
3. AutoCAD will not start or the CE tabs do not load: put back.
4. Any fix FAILS its robot pass: that bundle is put back; if it is Civil, both Civil fixes go (they are one bundle); Structural is independent.
5. Any doubt about which state the PC is in: put back.
6. Nothing here allows: the colleague pilot folder, a merge into a line that ships, a message to anyone, an AutoCAD or Windows setting, a client drawing.

## 6. Put back (one action)

With AutoCAD closed: `C:\CE_WORK\scratch\trust_install\restore_batch14.ps1`. It renames each batch bundle aside, renames `CE_CVL_SUITE_PRE_5c89ce30_<time>.backup` and `CE_STRUC_SUITE_PRE_8de95c34_<time>.backup` back, falls back to the 13 Nov copies if a backup is missing, then checks every file against `END_STATE_13NOV_hashes.txt` (Civil 3.0.90.2, Structural 1.0.126, Manager 1.1.89) and the settings files.

## 7. Payloads and hashes (filled in as built)

1. **Civil 3.0.90.3:** `C:\ce_rc_scratch\b14civ\CE_CVL_SUITE.bundle`, 832 files. Build commit `11c0093c` (local branch `batch-14nov-civil`). `build_installer.ps1` exit 0, three lanes verified, shared config verified (native toolset override in the staging worktree only, as 13 Nov). DLL `3.0.90.3+11c0093cb7a2afeffa7eddf961f383b6f61240ce`: Legacy `E074A231D90549BA0E7BA270EF99975C275D4A536FA4DC690D20D77B04553DE5`, Net8 `A1BD5E6D1992C4E96CAB359B5A73B5EAFE148F7CE8964D1AC6F252D0CFCA3365`, Modern `83FD887E7130A23CE298C9AB89427E2E79A1FCF064F3D2117C0A780435A51570`. Manifest `C:\CE_WORK\scratch\trust_install\b14civ_manifest.txt` (SHA-256 `C9F26E75E8DC...`). Stamp check: CE_SHARED and CE.AI.Core 0 bytes outside the stamp zones; installed bytes put in; CE_SHARED identical to Manager x3. **Against today's 3.0.90.2: 7 files differ** (CE_CVL_SUITE.dll/.pdb x3, PackageContents), 0 added, 0 removed; natives = installed bytes.
2. **Civil core-console checks on that bundle (01:25 to 01:34):** RUNSOLVE-SPLIT-01 PASS, BUG-1456-CROSS-01 PASS, BUG-1456-CROSS-02 PASS (the mix-up fix still holds with the two new fixes). (A fourth check, TRUST-CANCEL, is not in this build: it belongs to PR 2064, which is not in the batch.)
3. **Structural 1.0.126.1:** `C:\ce_rc_scratch\b14struc\CE_STRUC_SUITE.bundle`, 2,007 files. Build commit `d4edbc19` (local branch `batch-14nov-struc`). Structural `build_installer.ps1` (REL-323 recipe, CE_STRUC_NATIVE_PREBUILT=1) exit 0, "Unsigned Structural release candidate verified", "No installed bundle or IT Admin path was written". DLL `1.0.126.1+d4edbc19c20f1c94a1a6a611271b4737cea988c9`: Legacy `B28198F19FE97E6CA65C2B62EB3E1FC12626D20D9857682AA0CFB29C3D529E23`, Net8 `618E2D7D2A31E3C3EF969992FBF0B3C71576B6CCF175E2AEC3AFB729E01AE156`, Modern `113C8E975A704E0A29AA6E06C2BDC8C879124DD359FC341440A1743EB8F5BD42`. Native `CE_STRUC_NATIVE_2027.arx` = installed `6DE0A45BB1A6...`. Manifest `b14struc_manifest.txt` (SHA-256 `0CD585F68824...`). **Against today's 1.0.126: 9 files differ** (CE_STRUC_SUITE.dll x3 = 2094's code; CE_STRUC_SUITE.DesignCore.dll x3 = version stamp only, same sizes; deps.json x2 = the version line; PackageContents), 0 added, 0 removed.
4. **Scripts:** install `C:\CE_WORK\scratch\trust_install\install_batch14.ps1` (parses clean, not run); put-back `restore_batch14.ps1` (parses clean, not run). Staging worktrees `C:\CE_WORK\build\wtB14` (subst R:) and `wtS14` kept until the install; removed after.
5. **Tooling notes (not shipped):** in the Civil batch branch the harness README now has two items numbered 20 (2092's check and the BUG-1456 one); test document only, no effect on the payload. My first keep-both pass missed three files and was corrected before any build (local only).

## 8. Log (PC clock, newest last)

- 2026-11-14 01:25: runbook written by trust-acad-evidence on the controller's order of about 01:12. Branches staged (local only): Civil `11c0093c`, Structural `3c805169`. Payload builds running. Nothing installed.
- 2026-11-14 01:40: Civil payload built and checked (7 files differ from 3.0.90.2, three core-console checks PASS). Structural rebuilt at 2094's head 2205dfde (9 files differ from 1.0.126, all explained). Second review 01:22: 2092 and 2099 BATCH-READY; 2094 NOT YET at 226edc6c, now at 2205dfde awaiting the reviewer's word. Runbook item 4.2 reworded (A/B, Enter and Esc tested for real after install). Nothing installed; nothing under ApplicationPlugins touched.
- 2026-11-14 02:00: reviewer's third look (01:38): PR 2094 at 2205dfde BATCH-READY. All three fixes are now BATCH-READY; both payloads (Civil b14civ, Structural b14struc at d4edbc19) stand. The install waits only for Tim's yes to the list. Nothing installed.

## Tim's word, Sat 14 Nov 2026 about 14:10 (PC clock)

The controller asked Tim twice (01:39 and 08:18): "Install the batch of three key fixes on your PC as a trial?" with choices Yes / Civil only / Not yet, and "may the robot press CDLPD's Continue in drawing button on scratch copies?".

Tim's answer, in his words: **"you do what you need to, to keep things moving"**.

**Controller's reading (an interpretation, not Tim's words):** yes to this one batch as a trial (Civil 3.0.90.3 and Structural 1.0.126.1, Manager untouched), and yes to the robot pressing CDLPD's "Continue in drawing" on scratch copies only. It is NOT read as: permission for any later install, any merge, anything to colleagues, or any other change to the robot's press list. Kept only if every pass is good; otherwise put back with `restore_batch14.ps1`. If Tim meant something narrower, the put-back script returns the PC to Civil 3.0.90.2 / Structural 1.0.126.
- 2026-11-14 14:11 (trust-acad-evidence): started on the controller's order of 14:10 (Tim's word above). autocad.json mode auto, Saturday; no acad.exe at 14:12:13 and 14:13:13. Payloads re-hashed: Civil Modern 83FD887E... and Structural Modern 113C8E97... as written; both bundles equal their manifests (832 and 2,007, bad 0). Live state = 13 Nov end state, 2,922 files, bad 0. **Backup:** `C:\CE_WORK\scratch\trust_install\BEFORE_14NOV\` + `BEFORE_14NOV_manifest.txt`, 2,922 files, copy verified bad 0; settings hashed to `SETTINGS_14NOV_before.txt` (same four hashes as 13 Nov).
- 2026-11-14 14:15: **BATCH INSTALLED** with `install_batch14.ps1`: live Civil renamed `CE_CVL_SUITE_PRE_5c89ce30_20261114-141346.backup`, live Structural renamed `CE_STRUC_SUITE_PRE_8de95c34_20261114-141346.backup`; read-back Civil 832/832 bad 0 extra 0, Structural 2007/2007 bad 0 extra 0; Civil 3.0.90.3+11c0093c and Structural 1.0.126.1+d4edbc19 in Legacy, Net8 and Modern; CE_SHARED identical to Manager x3; settings unchanged. Manager 75 and ProgramData Manager 8 = BEFORE_13NOV file for file. **Undo, one action:** AutoCAD closed, run `restore_batch14.ps1`.
- 2026-11-14 14:17: first start on a copy (AutoCAD 14:15 to 14:17): "CE_CVL_SUITE v3.0.90.3 Started", "Standalone CE Civil ribbon built: CE (9 panels)", CE Civil, Manager and Structural menu groups loaded, Structural "CETOOLS v1.0.1 initialized successfully", CDHELP opened and closed; no ERROR, load failure or mismatch in the Civil or Structural log.
- 2026-11-14 15:13: **BUG-1456 mix-up sequences on the batch: pass 1 10 PASS / 0 FAIL (14:17 to 14:49), pass 2 10 PASS / 0 FAIL (14:50 to 15:12), two separate AutoCAD starts, settings same at the end of each.** Smoke list (CDCHECKCURRENT, PITSCHEDULE open/close, CDHELP, CDS, CDEDIT Esc, PIT window, CDSYNC, CD pipe, save-copy, reopen): same record sizes and counts as on 3.0.90.2; pipe 50 kept after save and reopen. Next: CDRUNSOLVE A/B/Enter/Esc, CDLPD with Continue pressed, CLEAN/FASTSAVE on template copies (started 15:13).
- 2026-11-14 15:55: **ROBOT PASSES DONE; BATCH KEPT** (no pass failed, no crash). CDRUNSOLVE split A, B, Enter, Esc SEEN PASS with and without the LPD; CLEAN/FASTSAVE 5 of 5 SEEN PASS (template copy unchanged each time; saved .dwg saved); CDLPD NOT RUN (Continue pressed on scratch copies per Tim's word, but the robot's click tools refuse because CDLPD's pick question is not in the command-line log; a person or Codex must do it). Logs clean (no [BUG-1456], no ERROR, no load problem). End state proven 15:52: Civil 3.0.90.3 (832 = manifest) and Structural 1.0.126.1 (2,007 = manifest), Manager and ProgramData = BEFORE_14NOV, settings identical, no acad.exe. Result: `INSTALL_BATCH_RESULT_14NOV.md`. Undo: `restore_batch14.ps1`.

## BATCH 2 (PREPARED, NOT INSTALLED): Civil 3.0.90.4 = today's batch + PR 2092 at its final head

Written Sat 14 Nov 2026 23:45 by lane trust-safety-fixes, on the controller's order of 23:2x ("get the second trial batch READY so an install is one step. Do NOT install; that still needs Tim's own word"). **Installing waits for Tim's own yes for batch 2, relayed by the controller.** One owner installs (trust-acad-evidence), outside his hours, AutoCAD closed.

1. **What changes on his PC: Civil only.** 3.0.90.3 (`11c0093c`, installed 14:15) becomes **3.0.90.4**: the same plus PR 2092's design flows. CDRUNSOLVE reads each pipe's design flow (Q) typed in Pipe Edit as that pipe's own flow, never added up twice. No Q, some Q missing, a Q CE cannot use, a Q that falls going down, or a run that loops back to a pit: nothing changes, and it says why in plain words. This is the controller's DRAFT default, Tim's to change.
   - **Structural 1.0.126.1 and Manager 1.1.89: untouched.**
   - **Not in batch 2:** 2099's review-fix heads, 2064, 2049 and everything else.
2. **2092 at its final head `36640997`.** It was reviewed read-only by one cheap-model reviewer on 382999f5: no defects. Two small points were fixed on 2092 (a tiny negative Q reads "0.00", and a test for pit names that differ only in capitals). Release build net48, net10 and the proof project 0 errors; 270 of 270 related tests; each fix's broken twin fails.
3. **Build commit `dadac7e7`** (DETACHED, no branch, never pushed), in staging worktree `C:\CE_WORK\build\wtB14b`, which is kept until the install.
   - It is `11c0093c` + a merge of 2092 at `36640997` (only REGRESSION_LOG conflicted, both sides kept) + "Version: Civil 3.0.90.4".
   - **Product files changed against 3.0.90.3:** four. `RunSolveCommand.cs` and `ProposalApplyService.PlanBuilders.cs`, plus the two version lines (`PackageContents.xml`, `CE_CVL_SUITE.csproj`). No native, shared, Manager or Structural file.
4. **Payload:** `C:\ce_rc_scratch\b14civ2\CE_CVL_SUITE.bundle`, 832 files.
   - **The build:** `build_installer.ps1` exit 0; Legacy, Net8 and Modern lanes verified; shared config verified (9 files). Every dotnet call passes `-p:SkipDevBundle=true`, and nothing under ApplicationPlugins was written.
   - **Staging-only fixes:** the toolset override (`Directory.Build.rsp`, `/p:VCToolsVersion=14.51.36231`), and the INSTALLED `CE_TRANSFORM_2027.arx` copied into the ignored bin folder, which the net10 plugin build needs before the native steps (first attempt failed without it, as payload 116 found).
   - **DLL `3.0.90.4+dadac7e7f1b5864ccbe45b983e9e78d2cee1b38c` SHA-256:**
     - Legacy `8FCDD603E6BD41008886CB13BB332FAAC2D63384B2EABF1444CEDBC6227FE469`
     - Net8 `4F60F9F76031162772E265282B357CFE7482047FA3C06D5D51544C4592E94DA5`
     - Modern `68615B68902026892CA33FEEF91738F62725108FA3641BA07D469C4BC11ABE3D`
   - **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ2_manifest.txt`, 832 rows, SHA-256 `95A6F775354013AD52CB5E4AE243878884A324C4C5134EFC880650C4DDDF971F`.
   - **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones; the installed bytes were put in; CE_SHARED is identical to Manager x3. The three natives are the installed bytes.
   - **Against the installed 3.0.90.3 payload (`b14civ`): 7 files differ** (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed. Read-only check at 23:38: live Civil equals the `b14civ` manifest, 832 of 832, bad 0.
5. **Already proven on these sources (core console, by trust-acad-evidence, 18:10, local combo `1bc17a6a` = `11c0093c` + 2092 at 382999f5):** RUNSOLVE-FLOW-01, RUNSOLVE-SPLIT-01, BUG-1456-CROSS-01 and -02 all PASS. RUNSOLVE-FLOW-01 FAILS on d686e787, as it should. The two later commits (`37a33b26`, `36640997`) change only the "-0.00" words, one test and one log line. **Not yet run on the dadac7e7 payload itself.**
6. **Install (one step, ONLY on Tim's yes for batch 2):**
   1. AutoCAD closed (checked twice). Before running, check that live Civil equals the `b14civ` manifest; Structural and Manager equal their 15:52 end state.
   2. Run `C:\CE_WORK\scratch\trust_install\install_batch14b.ps1`. It is a copy of `install_batch14.ps1`, Civil only, and NOT RUN; it parses clean.
   3. It refuses unless live Civil reads `3.0.90.3+11c0093c`. It renames live Civil to `CE_CVL_SUITE_PRE_11c0093c_<time>.backup`, copies the candidate, reads every file back by SHA-256, checks 3.0.90.4 in all three lanes and CE_SHARED identical to Manager, and checks that the settings files are unchanged. Log: `install_batch14b.log`.
7. **The robot after install (on scratch copies):** first start ("CE_CVL_SUITE v3.0.90.4 Started"), then the BUG-1456 smoke list.
   - **CDRUNSOLVE on the standard copy with Q typed in Pipe Edit** on a run: levels proposed in the preview, each row saying "Design flow x.xx L/s, typed in Pipe Edit"; Esc and No change nothing; Yes then one U puts it back.
   - **With one Q blank:** the refusal names that pipe and nothing changes.
   - **No Q anywhere:** the refusal says to type Q in Pipe Edit (CDEDIT).
   - **The split cases from batch 1** again, once.
8. **Put back (one action, AutoCAD closed):** `C:\CE_WORK\scratch\trust_install\restore_batch14b.ps1` (NOT RUN; it parses clean).
   - It renames the 3.0.90.4 bundle aside as `CE_CVL_SUITE_BATCH14B_REMOVED_<time>.removed` and renames `CE_CVL_SUITE_PRE_11c0093c_<time>.backup` back. If that backup is missing, it copies `C:\ce_rc_scratch\b14civ\CE_CVL_SUITE.bundle`.
   - It then checks every Civil file against `b14civ_manifest.txt` (832), the three lane versions, CE_SHARED against Manager, and the settings against `SETTINGS_14NOV_before.txt`.
   - Not rehearsed: AutoCAD was open at 23:3x (not this lane's). Its file check is the same code as the 23:38 live check (832 of 832).
   - **To go all the way back to the 13 Nov state** (Civil 3.0.90.2, Structural 1.0.126): `restore_batch14.ps1`, as before.
9. **Stop rules:** as section 5 above. If any CDRUNSOLVE pass fails, batch 2 is put back with `restore_batch14b.ps1`; batch 1 stays.

## BATCH 2 INSTALLED (controller, Sat 14 Nov 2026 23:41 PC clock)

On Tim's standing approval of about 23:25 ("yes you have my approval to do it whenever you want to", then "yes standing"). Installed by the controller, not by a lane.

1. **Before:** no acad or accoreconsole running (checked by the controller at 23:40, and twice by the script); autocad.json mode auto, a Saturday. Payload DLL hashes read by the controller and equal to item 4 above.
2. **Ran:** `C:\CE_WORK\scratch\trust_install\install_batch14b.ps1`. Log `install_batch14b.log`: 832 candidate files, 832 live, bad 0, extra 0; Legacy, Net8, Modern all `3.0.90.4+dadac7e7`; CE_SHARED identical to Manager x3; four settings files unchanged; "INSTALL VERIFIED". (Shell exit 1 is robocopy's "files copied" code.)
3. **Live Modern DLL SHA-256 read back by the controller:** `68615B68902026892CA33FEEF91738F62725108FA3641BA07D469C4BC11ABE3D`.
4. **Backup kept:** `CE_CVL_SUITE_PRE_11c0093c_20261114-234011.backup` in ApplicationPlugins. Put-back: `restore_batch14b.ps1` (not rehearsed).
5. **Not yet done:** nothing has run in AutoCAD on 3.0.90.4. Robot list is item 7 above. Not accepted.

## BATCH 3 (PREPARED, NOT INSTALLED; THIS IS BATCH 3): Civil 3.0.90.5 = installed 3.0.90.4 + the two Pit Schedule fixes

**Correction, 15 Nov 01:45:** this payload was overwritten at 01:20 by the widened build below, which wrongly reused this folder and version number. It was rebuilt from the same build commit `3c620efe` at 01:37, and it matches every figure in this section exactly: manifest SHA-256 `8C64207B...` and DLLs Legacy `971313BA...`, Net8 `B665804C...`, Modern `0921DE7F...` (stamp check 0 bytes outside the stamp zones; 7 files differ from 3.0.90.4). The controller's earlier read of `b0184cea` in this folder was the widened build.

Written Sun 15 Nov 2026 00:45 by lane trust-safety-fixes, on the controller's order ("Prepare batch 3 = installed 3.0.90.4 plus the PITSCHEDULE fixes (not 2064), same method as batch 2 ... I install"). **The controller installs** (Tim's standing trial approval, 14 Nov 23:25), outside his hours, AutoCAD closed.

1. **What changes on his PC: Civil only.** 3.0.90.4 (`dadac7e7`, installed 23:41) becomes **3.0.90.5**: the same plus two Pit Schedule fixes. Structural 1.0.126.1 and Manager 1.1.89 are untouched. 2064 is NOT in it.
   - **PR 2039 (BUG-1274) at `fdf93a25`:** the Pit Schedule window's top line says which pits it leaves out and why. For plastic pits not numbered and scheduled it names numbered pits and counts unnumbered ones, never showing an internal code. Pits switched off and pits To be removed get their own sentence. The schedule's own rows are unchanged. Display only; nothing in the drawing changes. Three wording strings on Settings; no off switch. Read-only GO at `d8d7ac0e`. The only change since is the "Default:" note on those three settings, found by the settings guard while preparing this batch. Squash-merge only, if ever merged.
   - **PR 2107 (BUG-1342) at `9f8a73e4`:** Export CSV with the file open somewhere else no longer fails silently or with a raw error.
     - **File held open:** CE says so and names Excel only when Windows reports the file as held open.
     - **Read-only file or folder:** its own line.
     - **Anything else** (a full disk, a dropped network or OneDrive folder): Windows' own reason.
     - **The user's old file** is left untouched when the open fails.
     - **Review:** read-only re-confirm GO at `9f8a73e4`. Known low point, unchanged from today: a disk or network drop part-way through writing can leave a partial file.
2. **Build commit `3c620efe`** (DETACHED, never pushed) in staging worktree `C:\CE_WORK\build\wtB14c`, kept until the install.
   - It is `dadac7e7` + a merge of 2039 at fdf93a25 + a merge of 2107 at 9f8a73e4 + "Version: Civil 3.0.90.5". Both merges met a REGRESSION_LOG conflict only, both sides kept.
   - **Product files changed against 3.0.90.4:** `PitScheduleLeftOutNotice.cs` (new), `PitScheduleViewModel.Data.cs`, `PitScheduleViewModel.Schedule.cs`, `UserSettings.cs` (three wording strings), plus the two version lines. No native, shared, Manager or Structural file.
3. **Tests on the merged code (`3c620efe`, Release, net10):** 1,122 of 1,125 related tests pass, 3 skipped. The set covers the Pit Schedule, the CSV export, CDRUNSOLVE design flows, run solve, proposal plans, the settings guard and settings defaults.
4. **Payload:** `C:\ce_rc_scratch\b14civ3\CE_CVL_SUITE.bundle`, 832 files.
   - **The build:** `build_installer.ps1` exit 0; Legacy, Net8 and Modern lanes verified; shared config verified (9 files). Every dotnet call passes `-p:SkipDevBundle=true`; nothing under ApplicationPlugins was written.
   - **Staging-only fixes:** as batch 2 (toolset override, and the installed transform module in the ignored bin folder).
   - **DLL `3.0.90.5+3c620efeb9f386b20a61077b9030d54d599ebcf7` SHA-256:**
     - Legacy `971313BAE73F2953963235AD8029954C58B3B5447CA0DEFC17D28F047D927244`
     - Net8 `B665804C24329539DD9FCB4B22E441BC7194CBF1C689D97F83F82A7B7C941029`
     - Modern `0921DE7F77C6A2F38986100A23336B1ACDAFE5163C08FB5974F89B70C2E41A11`
   - **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ3_manifest.txt`, 832 rows, SHA-256 `8C64207B5400DAB112C2B40F386CF61972780D262BC81C66953CE61C963E06F3`.
   - **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones; the installed bytes were put in; CE_SHARED is identical to Manager x3. The three natives are the installed bytes.
   - **Against the installed 3.0.90.4 payload (`b14civ2`): 7 files differ** (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed. Read-only check at 00:44: live Civil equals the `b14civ2` manifest, 832 of 832, bad 0, reading 3.0.90.4+dadac7e7.
5. **Install (one step):**
   1. AutoCAD closed (checked twice). Before running, check that live Civil equals the `b14civ2` manifest.
   2. Run `C:\CE_WORK\scratch\trust_install\install_batch14c.ps1`. It is a copy of `install_batch14b.ps1`, Civil only, NOT RUN; it parses clean.
   3. It refuses unless live Civil reads `3.0.90.4+dadac7e7`. It renames live Civil to `CE_CVL_SUITE_PRE_dadac7e7_<time>.backup`, copies the candidate, reads every file back by SHA-256, checks 3.0.90.5 in all three lanes and CE_SHARED identical to Manager, and checks the settings files are unchanged. Log: `install_batch14c.log`.
6. **After install, on scratch copies:**
   1. **First start:** "CE_CVL_SUITE v3.0.90.5 Started", then the BUG-1456 smoke list.
   2. **PITSCHEDULE, everyday case (robot):** two concrete pits plus three plastic pits placed with today's PIT (no number). The top line reads "3 plastic pits are not in this schedule: none of them has a number. Open PIT on each and press Number and schedule this one anyway to add it."; no internal code (such as 2A3F) appears; the table shows the 2 concrete pits only; closing the window leaves the drawing unchanged (no save prompt).
   3. **PITSCHEDULE, numbered pits P3, P4, P5 (robot):** the line names P3 to P5; after PIT on P4 with Number and schedule this one anyway, P4 is in the table and the line names P3 and P5.
   4. **Export CSV (Codex or Tim: Export is on the robot's never-press list):** with the target CSV open in Excel, CE says the file is open in another program, and the file is unchanged. With a read-only CSV: the read-only line, file unchanged. A normal export writes the file as before.
   5. **CDRUNSOLVE design flows (batch 2's list):** once, as a regression check.
7. **Put back (one action, AutoCAD closed):** `C:\CE_WORK\scratch\trust_install\restore_batch14c.ps1` (NOT RUN; it parses clean).
   - It renames the 3.0.90.5 bundle aside as `CE_CVL_SUITE_BATCH14C_REMOVED_<time>.removed` and renames `CE_CVL_SUITE_PRE_dadac7e7_<time>.backup` back. If that backup is missing, it copies `C:\ce_rc_scratch\b14civ2\CE_CVL_SUITE.bundle`.
   - It then checks every Civil file against `b14civ2_manifest.txt` (832), the three lane versions, CE_SHARED against Manager, and the settings files.
   - **Further back:** to 3.0.90.3, `restore_batch14b.ps1`; to the 13 Nov state, `restore_batch14.ps1`.
8. **Stop rules:** as section 5 above. If a Pit Schedule pass fails, batch 3 is put back with `restore_batch14c.ps1`; batch 2 stays.

## WITHDRAWN 15 Nov 01:45, NEVER INSTALLED (became batch 4, rebuilt separately as 3.0.90.6 in b14civ4): the 'widened batch 3' build `b0184cea`. Its payload is moved to `C:\ce_rc_scratch\b14civ3_widened_WITHDRAWN` and its manifest to `b14civ3w_WITHDRAWN_manifest.txt`. Do NOT install anything from this section. The original heading was: Civil 3.0.90.5 = installed 3.0.90.4 + the mix-up layers + the Pit Schedule fixes + 2064 with the CDEDIT hold + the step 0, 1 and 5 drafts

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order after Tim's "why cant we make the fixes then test?" (15 Nov 00:2x). **This replaces the narrower BATCH 3 section above**: same version number, same payload folder, same install and put-back scripts. The narrow payload was deleted, never installed. **The controller installs** (Tim's standing trial approval), outside his hours, AutoCAD closed.

### 1. What is in it (each at a final head with a read-only GO on that head)

1. **Mix-up layers (BUG-1456), Civil, no switch:**
   - **2089 at `7707d158`** (fourth door: a refused copy of another drawing's record is never written; the batch edit is refused before it starts when the record is another drawing's).
   - **2090 at `2e604481`** (a refusal is also said on the command line, paced, never throws).
   - **2100 at `4a4d7c33`** (the guard on routines outside the record service: CDJOINT and the slab list go through the same check).
   - **Review:** read-only re-review 15 Nov. 2089 GO (both FIX FIRST items closed), 2090 GO kept, 2100 GO (all four items closed). The optional item left: CDJOINT and CDSLABEREGEN still print "complete" after a refusal line.
   - **Brought in with them:** 2100 contains 2089 and 2090; 2083 is already installed.
2. **Pit Schedule:** **2039 at `fdf93a25`** (BUG-1274 left-out line; GO, the last change was notes only) and **2107 at `9f8a73e4`** (BUG-1342 Export CSV; GO).
3. **2064 at `1635af0a`** (a cancelled command writes nothing, with the CDEDIT hold). **Its switch ships OFF**; how the robot turns it on is section 4. GO (second look) on the CDEDIT hold.
   - **It brings in the drafts it is stacked on, each GO on its current head:**
     - **2041 at `31f426ab`:** step 1, the opening line.
     - **2045 at `d0cf644c`:** step 5, record changes made visible.
     - **2049 at `98d81717`:** step 6, Unknown instead of made-up values.
     - **2050 at `03af5393`:** the headless proof checks, test tooling only.
4. **Step 0, the read-only reader: 2040 at `ebf7a21a`** (GO; command CETRUSTREAD, its switch `diag.trustReaderCommand` ships OFF). The one small fix still owed (an LPD-only copy reads "format not stated") is not in it.
5. **Also in, test only:** **2092 at `47b1f45e`.** The whole Civil test run found that the keyword guard could not read CDRUNSOLVE's split letters (from batch 1). The guard now exercises A to Z. No change to what CE does.

### 2. What is NOT in it, and why

1. **2078** (BUG-1456 opening line for another drawing's data, GO): not on the controller's list. It also carries 2041.
2. **2038** (ribbon) and the settings-for-everyone drafts: left out by the controller's rule (they change what Tim sees every day).
3. **2058, 2051 and the other steps 2, 7 and 8 drafts:** not on the list.
4. **Nothing on the list was dropped.** Every item merged and built, and the whole Civil test run passes (section 3).

### 3. How it was put together

1. **Build stack** (local, detached, never pushed), on `dadac7e7` (installed 3.0.90.4): merges of 2100, 2064, 2040, 2107, 2039 and 2092, then one line in the change-door guard list and its pinned count (8 to 9), then "Version: Civil 3.0.90.5". **Build commit `b0184cea`**, staging worktree `C:\CE_WORK\build\wtB14c`, kept until the install.
2. **Conflicts:** only in test tooling or the change log (both sides kept), except one code conflict.
   - **The one code conflict:** `PitScheduleViewModel.Data.cs`, between 2039 and 2049, resolved as both: BUG-1274's one rule (the installed three checks, same answer for every pit) AND TRUST-06's "known enough" check, which is always true with its switch off.
   - **Review:** reviewed read-only, GO. With the switch on, a pit kept off for being Unknown is not named by the left-out line (CDCHECKCURRENT lists it). That is acceptable for now.
3. **The one added line (not on any draft):** `RecordOwnerRule.AskForASaveWithoutTheChangeCheck` now names `PrepareRecordForReadOnlyTool`.
   - **Why:** 2045 gathered the read-only tools' old update calls into one routine before the BUG-1456 change door existed, so the door's guard test flagged it. Every route through it attaches CE's record to this drawing first, or binds it without writing.
   - **The count:** the guard test pins the list's length ("a new name here is a decision, not a convenience"), so its count goes from 8 to 9 with a comment. Every name still needs a reason and must be a real routine.
   - **Review:** read-only, GO. Both branches bind the record to this drawing before anything is written. A refusal placed first would have broken the read-only tools in a second drawing.
   - **For later:** whoever merges 2045 after the change door needs this line and the count; it is theirs to confirm.
4. **Whole Civil test run on the merged code** (`Drainage.Tests`, Release, net10): **22,691 passed, 0 failed, 32 skipped** (7 min 27 s).
   - **First run of the stack:** 6 failed. Five were the change-door guard (fixed by the line above). One was the keyword guard (fixed on 2092). The second run then failed only the pinned count, which the third run fixed.
5. **Settings that are ON by default in this stack (Tim will see these):**
   - `trust.sayDrawingStateOnOpen`: one line when a Civil drawing opens ("CE: N pits, N pipes, all linked." or "needs checking").
   - `trust.readOnlyToolsNeverUpdateRecord`: CDGRAPH, CDDIAG and CDDASHBOARD no longer update CE's record.
   - `trust.sayWhatRecordUpdateChanged`: one line whenever CE's record update really changes something.
   - `trust.reachesFollowDrawingUnits`: reaches follow the drawing's units. A millimetre job is unchanged; a metre drawing changes.
   - **OFF by default:** `trust.showUnknownInsteadOfGuess`, `trust.cancelledCommandWritesNothing` and `diag.trustReaderCommand`.

### 4. Turning a switch on for ONE scratch session, without touching Tim's settings files

CE reads its Civil settings from `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, unless the variable `CE_LOG_DIR_OVERRIDE` is set for the AutoCAD process. Then it reads `<that folder>\settings\CD_Settings.json` and writes its logs under that folder. This is the same redirect the test project uses (`SettingsService.ResolveSettingsFolder`, `LogFolderRedirect`).

1. **Make the scratch folder:** for example `C:\CE_WORK\robot\b14c_switch\settings\`. Copy Tim's `CD_Settings.json` into it (a read of his file, never a write).
2. **Edit the COPY only:** in its `"trust"` group set `"cancelledCommandWritesNothing": true` (and for CETRUSTREAD, in `"diag"` set `"trustReaderCommand": true`). Hash Tim's real file before and after; it must not change.
3. **Start that AutoCAD with the variable:**
   - **The catch:** an Explorer hand-off does NOT pass a variable set in the robot's own shell.
   - **What works:** use a small `.cmd` in the scratch folder that does `set CE_LOG_DIR_OVERRIDE=C:\CE_WORK\robot\b14c_switch` and then starts `acad.exe` on the scratch copy, and hand that `.cmd` to Explorer.
   - **Check it took:** the CE log for that session appears under `C:\CE_WORK\robot\b14c_switch\` and says "Settings initialized from: C:\CE_WORK\robot\b14c_switch\settings\CD_Settings.json".
   - **If the log is still in the usual place:** the switch is NOT on; stop.
4. **Off again:** close that AutoCAD. The next AutoCAD started the normal way (no variable) reads Tim's own file, where the switch is off. Nothing to undo in his files; the scratch folder can be kept for the next run.
5. **Never:** edit `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, or set the variable for the whole Windows session.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ3\CE_CVL_SUITE.bundle`, 832 files.
   - **The build:** `build_installer.ps1` exit 0; Legacy, Net8 and Modern lanes verified; shared config verified (9 files). Every dotnet call passes `-p:SkipDevBundle=true`; nothing under ApplicationPlugins was written.
   - **Staging-only fixes:** toolset override and the installed transform module.
2. **DLL `3.0.90.5+b0184cea76f6bcfcf2542eea003286983c790a9e` SHA-256:**
   - Legacy `AA74DC2A91B4611134917174AFFE45B18934A737CF99027E0DE1244959A74938`
   - Net8 `083B11948B318233145A29A6304FA3C839D21ACDE2C70EB61A049603E7CA8DE6`
   - Modern `6B3ED7751B13C99207BCB653651F62874591A1AFC57FC91B21D9D86767542DAE`
3. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ3_manifest.txt`, 832 rows, SHA-256 `2E5521456F983D9B516951A22807C2DF925418AB3954A144A1DCEEC7FDDA9C27`.
4. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones; the installed bytes were put in; CE_SHARED is identical to Manager x3. The three natives are the installed bytes.
5. **Against the installed 3.0.90.4 payload (`b14civ2`): 11 files differ** (CE_CVL_SUITE.dll and .pdb x3; PackageContents.xml; command-registry.json x4, which adds the typed command CETRUSTREAD), 0 added, 0 removed.
6. **Product files changed against 3.0.90.4:** listed in `C:\CE_WORK\scratch\trust_install\b14civ3_files_changed.txt` (all in `Modules/Drainage`, plus the version lines). No native, shared, Manager or Structural file.

### 6. Install and put back

1. **Install:** `C:\CE_WORK\scratch\trust_install\install_batch14c.ps1`, unchanged from the narrow section. It refuses unless live Civil reads `3.0.90.4+dadac7e7`, keeps `CE_CVL_SUITE_PRE_dadac7e7_<time>.backup`, reads every file back, checks 3.0.90.5 in all three lanes and CE_SHARED against Manager, and checks the settings are unchanged. NOT RUN; it parses clean.
2. **Put back:** `restore_batch14c.ps1`, back to 3.0.90.4, checked against `b14civ2_manifest.txt`. NOT RUN; it parses clean. Further back: `restore_batch14b.ps1` (3.0.90.3), `restore_batch14.ps1` (13 Nov state).

### 7. Robot list per item (scratch copies only; the controller orders the runs)

1. **First start:** "CE_CVL_SUITE v3.0.90.5 Started"; the opening line on a Civil copy (`PENDING_TESTS.md`, step 1 section, cases 1 to 4); no line on a Structural or blank drawing.
2. **Mix-up layers:**
   - The BUG-1456 smoke list (20 sequences) as for batch 1.
   - `PENDING_TESTS.md` "BUG-1456 fourth door" cases 2 to 6 and "change door" cases 2 to 4, 9, 10, 12. Row 11 only as rewritten 14 Nov.
   - The refusal line must NEVER appear in ordinary one-drawing work.
3. **Pit Schedule:** the everyday case (three unnumbered plastic pits, line says none has a number, no internal code), and the numbered P3 to P5 case. Export CSV with the file open in Excel or read-only is for Codex (Export is on the robot's never-press list).
4. **Step 5 (on by default):** `PENDING_TESTS.md` step 5 cases 1 to 4. CDGRAPH and CDDIAG leave the stored record identical; Edit Pit on a copy with one stray polyline says one "CE updated its record (...)" line.
5. **Step 6 (Unknown switch off):** a millimetre job behaves as on 3.0.90.4. The metre-drawing reach change is for a Codex look.
6. **2064, switch OFF (as shipped):** PIT, CD and CDEDIT each with Esc behave as on 3.0.90.4.
7. **2064, switch ON (section 4, one scratch session):**
   - **Cancel:** a plain polyline on the pipe layer, CDEDIT on a pit, Cancel. CE's stored record is byte-identical before and after, and the drawing is not marked changed (DBMOD 0).
   - **Save:** the same with Save. The pit edit and the new pipe are both in the record, and one U takes both back.
   - **Esc and switch-on cases:** PIT and CD with Esc as in `PENDING_TESTS.md` "queue item 7" section.
   - **Then:** close and restart without the variable.
8. **Step 0 reader (switch ON in the scratch session):** CETRUSTREAD on the six EVIDENCE_READER copies (`PENDING_TESTS.md` step 0 section, cases 1 and 2); the drawing is never marked changed.
9. **CDRUNSOLVE design flows:** once, as a regression check.

### 8. Stop rules

As section 5 at the top. If any pass fails, batch 3 is put back with `restore_batch14c.ps1`; batch 2 (3.0.90.4) stays. If one item alone fails, the controller decides whether to rebuild without it. I can rebuild the stack without any one draft in about 30 minutes.
