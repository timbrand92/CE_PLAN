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

## BATCH 3 (NARROW) INSTALLED (controller, Sun 15 Nov 2026 01:49 PC clock)

On Tim's standing trial approval. Installed by the controller.

1. **What:** Civil 3.0.90.4 became `3.0.90.5+3c620efe` = the two Pit Schedule fixes (2039 at `fdf93a25`, 2107 at `9f8a73e4`). The widened `b0184cea` build was withdrawn and never installed; it returns as batch 4 = 3.0.90.6.
2. **Before:** no acad or accoreconsole running; payload read by the controller at 01:39 and 01:48, equal to the narrow section (Modern `0921DE7F...`, manifest `8C64207B...`). An earlier try at 01:33 aborted on the script's AutoCAD check and changed nothing.
3. **Ran:** `install_batch14c.ps1`. 832 candidate files, 832 live, bad 0, extra 0; all three lanes 3.0.90.5; CE_SHARED identical to Manager x3; four settings files unchanged; "INSTALL VERIFIED".
4. **Live Modern DLL SHA-256 read back by the controller:** `0921DE7F77C6A2F38986100A23336B1ACDAFE5163C08FB5974F89B70C2E41A11`.
5. **Backup kept:** `CE_CVL_SUITE_PRE_dadac7e7_20261115-014806.backup`. Put-back: `restore_batch14c.ps1` (not rehearsed).
6. **Not yet done:** nothing has run in AutoCAD on 3.0.90.5. Not accepted.

## BATCH 4 (PREPARED, NOT INSTALLED): Civil 3.0.90.6 = batch 3 (3.0.90.5) + the mix-up layers + steps 0, 1 and 5 + the CDEDIT hold on its own narrow switch

Written Sun 15 Nov 2026 02:10 by lane trust-safety-fixes, on the controller's order ("The widened order I sent at 00:19 becomes BATCH 4, on top of 3.0.90.5"). It has its own folder (`b14civ4`) and its own version (3.0.90.6). **Install it only after batch 3** (the install script refuses unless live Civil reads 3.0.90.5+3c620efe). The controller installs (Tim's standing trial approval), outside his hours, AutoCAD closed.

### 1. What is in it (each at a final head with a read-only GO on that head)

1. **Mix-up layers (BUG-1456), no switch:** **2100 at `4a4d7c33`**, carrying **2089 at `7707d158`** and **2090 at `2e604481`**. Re-reviewed 15 Nov: 2089 GO (both FIX FIRST items closed), 2090 GO kept, 2100 GO (all four items closed). Optional item left: CDJOINT and CDSLABEREGEN still print "complete" after a refusal line.
2. **The CDEDIT hold on its own narrow switch `trust.cdeditCancelWritesNothing` (ships OFF):**
   - **Draft:** on **2064 at `19569d86`** (read-only GO). Under the switch, CDEDIT and Edit Pit hold CE's record update until Save; Cancel, Esc or an error puts the record back exactly and writes nothing; PITEDIT and PIPEEDIT leave the forced-write list (a save really waiting is still written).
   - **Only the CDEDIT code is in batch 4:** commits b926f903, f3292c51 and 19569d86, lifted onto the stack. **The rest of 2064 is NOT in:** its big switch `trust.cancelledCommandWritesNothing`, 2049 (step 6) and 2050 (proof checks).
   - **The lift differs from 2064 in three lines only** (reviewed GO): TrustSettings gains only the narrow key; the command-end flush asks `IsForcedWriteCommand` on the installed path; two test lines that named the big switch are dropped.
   - **Known:** the two middle lifted commits do not compile on their own (they still name the big switch); the finished stack does.
3. **Step 0, the read-only reader: 2040 at `ebf7a21a`** (GO; command CETRUSTREAD; its switch `diag.trustReaderCommand` ships OFF). One small fix still owed (an LPD-only copy reads "format not stated").
4. **Step 1, the opening line: 2041 at `31f426ab`; step 5, record changes made visible: 2045 at `d0cf644c`** (both GO; 2045 carries 2041). Both are ON by default (section 3).
5. **Test only:** **2092 at `47b1f45e`** (the keyword guard exercises CDRUNSOLVE's split letters A to Z; the whole test run needs it). No change to what CE does.

### 2. What is NOT in it, and why

1. **2064's big switch, 2049 (step 6) and 2050:** the controller's rule ("The rest of 2064's switch stays out of batch 4"). Step 6 is not one of steps 0, 1 and 5.
2. **2078** (BUG-1456 opening line for another drawing's data, GO): not on the list. It also carries 2041.
3. **2038** (ribbon) and the settings-for-everyone drafts: left out by the controller's rule.
4. **Steps 2, 7 and 8 drafts** (2058, 2051 and others): not on the list.
5. **Nothing on the list was dropped.** Every listed draft merged cleanly (only test tooling and the change log conflicted; both sides kept) and the whole Civil test run passes.

### 3. How it was put together, and what Tim will see

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14d`, on `3c620efe` (batch 3).
   - **The order:** merges of 2100, 2045, 2040 and 2092; then the three lifted CDEDIT commits; then one line in the change-door guard list with its pinned count.
   - **Build commit `35cdad78`:** "Version: Civil 3.0.90.6". Staging kept until the install.
2. **The one added line (not on any draft):** `RecordOwnerRule.AskForASaveWithoutTheChangeCheck` names TRUST-05's `PrepareRecordForReadOnlyTool`, and the guard test's pinned count goes from 8 to 9.
   - **Why:** 2045 predates the change door. Every route through that routine binds CE's record to this drawing before anything is written.
   - **Review:** read-only GO (also given for the withdrawn build).
   - **For later:** for 2045's owner to confirm at merge.
3. **Whole Civil test run on the merged code** (`Drainage.Tests`, Release, net10, at `35cdad78`): **22,647 passed, 0 failed, 32 skipped** (8 min 4 s), first run.
4. **ON by default in this batch (Tim will see these):**
   - `trust.sayDrawingStateOnOpen`: one line when a Civil drawing opens.
   - `trust.readOnlyToolsNeverUpdateRecord`: CDGRAPH, CDDIAG and CDDASHBOARD stop updating CE's record.
   - `trust.sayWhatRecordUpdateChanged`: one line whenever CE's record update really changes something.
   - Also new: a refusal line on the command line if CE ever refuses to write one drawing's record into another (2090; it should never appear in ordinary work).
   - **OFF by default:** `trust.cdeditCancelWritesNothing` and `diag.trustReaderCommand`.
   - (Unlike the withdrawn build, `trust.reachesFollowDrawingUnits` is NOT in this batch, since it came with 2049.)

### 4. Turning a switch on for ONE scratch session, without touching Tim's settings files

CE reads its Civil settings from `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, unless the variable `CE_LOG_DIR_OVERRIDE` is set for the AutoCAD process. Then it reads `<that folder>\settings\CD_Settings.json` and writes its logs under that folder. This is the same redirect the test project uses (`SettingsService.ResolveSettingsFolder`, `LogFolderRedirect`).

1. **Make the scratch folder:** for example `C:\CE_WORK\robot\b14d_switch\settings\`. Copy Tim's `CD_Settings.json` into it (a read of his file, never a write). Hash his real file before and after; it must not change.
2. **Edit the COPY only:** in its `"trust"` group set `"cdeditCancelWritesNothing": true`. For CETRUSTREAD, in `"diag"` set `"trustReaderCommand": true`.
3. **Start that AutoCAD with the variable:**
   - **The catch:** an Explorer hand-off does NOT pass a variable set in the robot's own shell.
   - **What works:** use a `.cmd` in the scratch folder that does `set CE_LOG_DIR_OVERRIDE=C:\CE_WORK\robot\b14d_switch` and then starts `acad.exe` on the scratch copy, and hand that `.cmd` to Explorer.
   - **Check it took:** the CE log for that session appears under `C:\CE_WORK\robot\b14d_switch\` and says "Settings initialized from: C:\CE_WORK\robot\b14d_switch\settings\CD_Settings.json".
   - **If the log is in the usual place:** the switch is NOT on; stop.
4. **Off again:** close that AutoCAD. The next AutoCAD started normally reads Tim's own file, where the switch is off. Nothing to undo in his files.
5. **Never:** edit `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, or set the variable for the whole Windows session.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ4\CE_CVL_SUITE.bundle`, 832 files.
   - **The build:** `build_installer.ps1` exit 0; Legacy, Net8 and Modern lanes verified; shared config verified (9 files). Every dotnet call passes `-p:SkipDevBundle=true`; nothing under ApplicationPlugins was written.
   - **Staging-only fixes:** toolset override and the installed transform module.
2. **DLL `3.0.90.6+35cdad78ad4373db10d57f2af1ff9ad16496f5c0` SHA-256:**
   - Legacy `93475DED65EC1681AC58B60CBFB3E6D09150DBF801E40F0F94824C94503A0B7F`
   - Net8 `A0A614C455F09751F1B54530B9A1CF406D67E5C919487075ED62491B7638BE4C`
   - Modern `57F6FCCF7401E4F0EDAD892608995D57A5A72A02AEE37F19C7F313E50461FC8E`
3. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ4_manifest.txt`, 832 rows, SHA-256 `F6B9D2A5095399348C2CD55BF8E93111181B6D7BD853EB3A76D15470646353BC`.
4. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones; the installed bytes were put in; CE_SHARED is identical to Manager x3. The three natives are the installed bytes.
5. **Against batch 3 (3.0.90.5, `b14civ3`): 11 files differ** (CE_CVL_SUITE.dll and .pdb x3; PackageContents.xml; command-registry.json x4, which adds CETRUSTREAD), 0 added, 0 removed.
6. **Product files changed against 3.0.90.5:** 58, listed in `C:\CE_WORK\scratch\trust_install\b14civ4_files_changed.txt`, all in `Modules/Drainage` plus the version line. No native, shared, Manager or Structural file.

### 6. Install and put back

1. **Install (after batch 3):** `C:\CE_WORK\scratch\trust_install\install_batch14d.ps1`. It is a copy of `install_batch14c.ps1`, NOT RUN; it parses clean.
   - It refuses unless live Civil reads `3.0.90.5+3c620efe`, and keeps `CE_CVL_SUITE_PRE_3c620efe_<time>.backup`.
   - It reads every file back, checks 3.0.90.6 in all three lanes and CE_SHARED against Manager, and checks the settings are unchanged. Log: `install_batch14d.log`.
2. **Put back:** `restore_batch14d.ps1`, back to 3.0.90.5, checked against `b14civ3_manifest.txt`. NOT RUN; it parses clean. Further back: `restore_batch14c.ps1` (3.0.90.4), `restore_batch14b.ps1`, `restore_batch14.ps1`.

### 7. Robot list per item (scratch copies only)

1. **First start:** "CE_CVL_SUITE v3.0.90.6 Started"; the opening line on a Civil copy (`PENDING_TESTS.md`, step 1, cases 1 to 4); no line on a Structural or blank drawing.
2. **Mix-up layers:**
   - The BUG-1456 smoke list (20 sequences).
   - `PENDING_TESTS.md` "BUG-1456 fourth door" cases 2 to 6, and "change door" cases 2 to 4, 9, 10 and 12. Row 11 only as rewritten 14 Nov.
   - The refusal line must NEVER appear in ordinary one-drawing work.
3. **Step 5 (on by default):** `PENDING_TESTS.md` step 5 cases 1 to 4. CDGRAPH and CDDIAG leave the stored record identical; Edit Pit after one stray polyline says one "CE updated its record (...)" line.
4. **CDEDIT, switch OFF (as shipped):** CDEDIT, PITEDIT and Edit Pipe each with Cancel and Esc behave as on 3.0.90.5.
5. **CDEDIT, switch ON (section 4, one scratch session):**
   - **Cancel:** a plain polyline on the pipe layer, then CDEDIT on a pit, then Cancel. CE's stored record is byte-identical before and after, and the drawing is not marked changed (DBMOD 0).
   - **PITEDIT typed, Cancel:** DBMOD 0.
   - **Save:** the pit edit and the new pipe are in the record, and they are still there after save and reopen. One U takes both back.
   - **Then:** close and restart without the variable.
6. **Step 0 reader (switch ON in a scratch session):** CETRUSTREAD on the six EVIDENCE_READER copies (`PENDING_TESTS.md` step 0, cases 1 and 2); the drawing is never marked changed.
7. **Regression:** the Pit Schedule left-out line (batch 3) and CDRUNSOLVE design flows (batch 2), once each.

### 8. Stop rules

As section 5 at the top. If any pass fails, batch 4 is put back with `restore_batch14d.ps1`; batch 3 stays. I can rebuild the stack without any one item in about 30 minutes.

### 9. Batch 4 against Tim's four "never by itself" rules (added 15 Nov 02:40; ask chat 01:57: CE never, without him, changes a level or size, renumbers pits, moves or deletes his labels, changes layers or colours)

All lines below are read in batch 4's build code, `C:\CE_WORK\build\wtB14d` at `35cdad78`.

**Answer: none of the settings ON by default in batch 4 touches any of the four rules. No hold is needed on these grounds.**

1. **`trust.reachesFollowDrawingUnits` is NOT in batch 4.** No source file in the build mentions it. It came with 2049 (step 6), which is not in this batch. It was only in the withdrawn widened build.
2. **`trust.sayDrawingStateOnOpen` (ON):** could only touch the four by writing while it checks.
   - **It reads and prints.** `DrawingStateLineOnOpenService.cs:144-160` builds the line and calls `Editor.WriteMessage`. The check is `CurrentDrawingCheckService.cs:510-531` (`ReadForOpenLine`), which opens the drawing through a read-only `StartOpenCloseTransaction` and the same observation CDCHECKCURRENT uses.
   - **Guard:** `DrawingStateLineRule.cs:92-101` reads the drawing's changed counter before and after the check and logs a warning if it moved.
   - **Writes nothing:** no level, size, pit number, label, layer or colour.
3. **`trust.openCheckMaxObjects` (50000, a number):** only decides whether the opening check runs at all (`CurrentDrawingCheckService.cs:516`). Above the limit it reads one thing (is there a record) and says "large drawing, not checked". It writes nothing.
4. **`trust.readOnlyToolsNeverUpdateRecord` (ON):** this switch REMOVES writing.
   - **What it does:** with it on, CDGRAPH, CDDIAG, the Civil health routine and CDDASHBOARD no longer run CE's record update, which is the update that can fill in a made-up pipe size.
   - **Instead:** they bind the record without writing and read only (`ProjectDataService.ReadOnlyTools.cs:42-77`; the bind that writes nothing is line 66, `BindToDrawingForRightClick`).
   - **The lists:** CDGRAPH and the dashboard list only the pipes the record holds (`LinkService.RepairAudit.Analysis.cs:31-35` and `284-295`).
   - **Writes nothing:** no level, size, number, label, layer or colour.
5. **`trust.sayWhatRecordUpdateChanged` (ON):** words only. It decides whether the "CE updated its record: ..." line is printed (`ProjectDataService.ReadOnlyTools.cs:201-202`). The update it describes runs exactly as on 3.0.90.5 whether this switch is on or off. It changes nothing in the drawing.
6. **Changes with no switch, for completeness:**
   - **The mix-up layers 2089, 2090 and 2100:** they only refuse a write of one drawing's record into another, and say so on the command line. In one-drawing work they allow everything as before.
   - **`LayerService.cs:45`:** a new read-only list of the pipe layer names, used by the opening check. It does not create or change any layer or colour.
   - **`PitBlockMigrationService.cs:190`:** only tells the opening line that pit symbols were updated. The symbol update on opening is the installed behaviour, unchanged by this batch. It does not touch layers, colours, labels or levels.
7. **OFF by default and untouched unless switched on for a scratch session:** `trust.cdeditCancelWritesNothing` (it only holds and puts back CE's own record; it never changes a level or label by itself) and `diag.trustReaderCommand` (reads only).
8. **Not proven by reading:** that no other routine reached by these tools writes indirectly. The robot list (section 7) checks DBMOD and the stored record before and after for CDGRAPH, CDDIAG and the opening line.

## BATCH 5 (PREPARED, NOT INSTALLED): Civil 3.0.90.7 = batch 4 (3.0.90.6) + CDLPD only recorded pipes + CDRENUMBER names unreached pits and loop pipes

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order ("These go into batch 5 (3.0.90.7, its own folder b14civ5)"). Its own folder and version. **Install only after batch 4** (the script refuses unless live Civil reads 3.0.90.6+35cdad78). The controller installs.

### 1. What is in it (each at a final head with a read-only GO on that head)

1. **PR 2099 (CDLPD, BUG-1298) at `28dd045c`** (GO).
   - **The ruling:** Tim, 15 Nov 01:47: "No, only recorded pipes".
   - **Both routes, one rule:** clicking a line and picking a point near a pipe end both accept a line only when CE's record holds a pipe with that line's handle. A plain polyline on a pipe layer is refused with the same plain line as any other non-CE line (the L-06 case). A line CE turned into a pipe object on opening without recording it is refused too. A recorded pipe still works.
   - **Record first:** CDLPD binds CE's record to this drawing before either route asks it.
   - **Side effect:** the downpipe on-pipe-end check asks the same routine, so a downpipe on the end of a bare line is no longer said to be on a pipe end (a warning-only check).
2. **PR 2093 (CDRENUMBER) at `a8fca9cc`** (GO). Display lines only, both before the Yes/No question; nothing about the numbering changes.
   - **(a) BUG-1306:** the pits not joined to the outlet by pipes are named. A plain P number goes after the main network in its old order, and a mark of its own (such as EP1) is kept.
   - **(b) BUG-968, the open half:** when CE's pipe records loop back on themselves, the line names the pipes as recorded ("P10 to P9 and P9 to P10") as well as the pits, and points to CDREVERSEFLOW.
   - **Finding:** in Codex's 14 Nov run no loop line appeared, so by reading (not proven) CE's records held no loop there. The second pipe was most likely recorded running the same way as the first.

### 2. Not in it

Nothing else. Batches 3 and 4 are underneath (install order: 3, then 4, then 5).

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14e`, on `35cdad78` (batch 4): merges of 2099 and 2093 (REGRESSION_LOG conflicts only, both sides kept). **Build commit `9b977125`**, "Version: Civil 3.0.90.7".
2. **Product files changed against 3.0.90.6:** `LpdCommand.cs`, `LpdService.cs`, `PitRenumberCommand.cs`, `PitRenumberPlanner.cs` and the two version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ5_files_changed.txt`.
3. **Whole Civil test run on the merged code:** **22,663 passed, 0 failed, 32 skipped** (8 min 29 s).

### 4. Against Tim's four "never by itself" rules

1. **No ON-by-default setting is added in batch 5.**
2. **CDLPD only refuses more lines.** It never changes a level, size, number, label, layer or colour by itself. Storing an LPD is the drafter's own act, after the picks.
3. **CDRENUMBER renumbers only after the drafter's Yes, exactly as before.** The two new lines are words before the question (`PitRenumberCommand.cs`, the `UnreachedLine` and `LoopLine` writes come before the `[Yes/No]` prompt; pinned by source-order tests).

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ5\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0; three lanes verified; shared config verified; every dotnet call passes `-p:SkipDevBundle=true`.
2. **DLL `3.0.90.7+9b977125e86d583230181171077402953bef1310` SHA-256:**
   - Legacy `564225633F66D110F60839F3137CBCC43176727308E720E0F9E7FD2029248671`
   - Net8 `5CF02DDCBF502BA17642566F178E4AAB0AB55080E5AF7F508C868E92A3D9A077`
   - Modern `1111E937330B398458B613D3D54B873620B5A39259C2C06086B6F96FD36F835B`
3. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ5_manifest.txt`, SHA-256 `24BD504CE12463ACA95C8225CC6FFE645DC146A27807709D2CC998D169778A24`.
4. **Stamp check:** clean (0 bytes outside the stamp zones); the installed CE_SHARED and CE.AI.Core bytes were put in; CE_SHARED is identical to Manager x3. Natives are the installed bytes.
5. **Against batch 4 (`b14civ4`):** 7 files differ (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed.

### 6. Install and put back

1. **Install (after batch 4):** `C:\CE_WORK\scratch\trust_install\install_batch14e.ps1`. It refuses unless live Civil reads `3.0.90.6+35cdad78`, and keeps `CE_CVL_SUITE_PRE_35cdad78_<time>.backup`. Log: `install_batch14e.log`. NOT RUN; it parses clean.
2. **Put back:** `restore_batch14e.ps1`, back to 3.0.90.6, checked against `b14civ4_manifest.txt`. NOT RUN; it parses clean.

### 7. Robot and Codex list (scratch copies)

1. **First start:** "CE_CVL_SUITE v3.0.90.7 Started".
2. **CDLPD, the L-06 case:**
   - A plain polyline on STORMWATER PIPE clicked as the pipe: the plain refusal line, no marker, no LPD stored, drawing unchanged.
   - A recorded CE pipe: the LPD is stored as before, and is still there after save and reopen.
   - The pick-a-point route near a bare line's end: no pipe end found, nothing stored.
   - The robot's click tools may not reach CDLPD's pick; if so it is for Codex, as on 14 Nov.
3. **Downpipe on a recorded pipe end:** still said to be on it.
4. **CDRENUMBER:**
   - A copy with a pit not joined to the outlet: the "Not joined" line names it before the question.
   - A copy whose records really hold two opposite pipes (make one by turning a pipe round with CDREVERSEFLOW): the loop line names both pipes before the question.
   - No: nothing changes.
5. **Regression:** batch 4's list items 1 and 2, once.

### 8. Stop rules

As section 5 at the top. If a pass fails, batch 5 is put back with `restore_batch14e.ps1`; batch 4 stays.

## Notes added 15 Nov 03:30 for batches 4 and 5 (Tim's answers, TIM_INTERVIEW_15NOV.md section 11)

### Batch 4 against Q25, Q27 and Q28 (no code change; gaps noted)

1. **Q25** (CE Health, CDGRAPH, CDDIAG and the dashboard stop changing CE's record now): **met by `trust.readOnlyToolsNeverUpdateRecord` (ON).**
   - **CDGRAPH and CDDIAG:** go through the read-only door, `PrepareRecordForReadOnlyTool` (`LinkCommands.cs:474` and `:2231`; `DiagnosticsCommand.cs:35`).
   - **The dashboard:** the same door (`DashboardCommands.cs:32`).
   - **CE Health:** Civil's own health routine (`HealthCheckCommand.cs:38`) goes through the same door. On a PC where Manager hosts the plugins, Manager's CEHEALTH runs instead. It reads plugin state only, and the 13 Nov probe found Civil's record unchanged after it.
2. **Q27** (one command-line line per record change, every guess counted, no window): **mostly met.**
   - **Already true:** the line is one command-line line ("CE updated its record (TOOL): ...", no window). It counts these guesses: pipe sizes filled in as 100, pipe materials, lid classes, pit numbers, and pits given CE's own code in place of a number (`RecordUpdateSummaryRule.cs:344-353`).
   - **Gap:** a pit type filled in as "GRATED PIT" is not counted among the guesses. Later work; no change for batch 4.
3. **Q28** (the Pit Schedule's write-back of a drawn pipe size STAYS, said in a line): batch 4 does not remove the write-back.
   - **Already said:** the schedule's relink is counted and said (`PitScheduleViewModel.Data.cs:1078` and `:3024`).
   - **Not checked by reading:** whether the on-open size write-back itself prints a line. If it does not, that is later work.

### Batch 5 and draft 2049 (Unknown instead of made-up values): LEFT OUT

**Reason, one line:** Tim's Q13 says a bare pipe-layer line enters CE's record only on his tick. Under 2049's switch, CE's record update still adds the line by itself, only with its size blank. Stopping that is new work in the record update, not a trim of 2049.

1. **Against his answers, line by line:**
   - **Q9 (no size or material = Unknown, never 100, UPVC or 225):** met, with its switch on.
   - **Q10 (lid class and pit type Unknown, never Class C or grated pit):** met, with its switch on.
   - **Q12 (a blank invert stays worked out from the lowest connected pipe, marked as worked out):** met. The worked-out level is kept beside the invert, and CDCHECKCURRENT says "Worked out by CE"; it is never turned into Unknown.
   - **Q11:** an unlabelled pit is never given a number, which is met. The pipe's direction is "proposed from drawn order" for his tick, which is not met (no proposal yet).
   - **Q8 (a label within reach of two pits is Unknown, showing both):** not met; the nearer pit still wins.
   - **Q7 (Unknown not drawn on the plan, "?" in windows and lists, a warning before a schedule is placed):** only partly met. 2049 keeps an unknown pit off the placed schedule, rather than showing "?" with a warning.
   - **Q13:** not met (above).
   - **Q14 (a drawn width only proposes a size):** not met. 2049's second setting `trust.reachesFollowDrawingUnits` ships ON and reads a 0.225 wide line in a metre drawing as 225.
2. **Not built (later ideas, as ordered):** reading missing values from a Pit Schedule drawn on the sheet, offered as Proposed (Q9, Q10, Q12 follow-ups); Q6 tick rules; Q15 units asked once.
3. **So batch 5 stays as prepared:** Civil 3.0.90.7+9b977125, CDLPD and CDRENUMBER only. `trust.showUnknownInsteadOfGuess` is not in it at all.
4. **What would let 2049 go in later:**
   - **(a)** a separate, reviewed change to the record update so a bare line is not added by itself (listed as a possible pipe instead, as the reader 2040 already proposes).
   - **(b)** the Q8 "both pits" label rule.
   - **(c)** `reachesFollowDrawingUnits` split from the width-as-size reading, or shipped off.

### Batch 4: known gaps (added 15 Nov 04:00, no code now)

1. **Q27:** the record-change line does not count a pit type filled in as "GRATED PIT" among its guesses. It counts sizes, materials, lid classes, pit numbers and stand-in codes only.
2. **Q28:** whether the Pit Schedule's on-open write-back of a drawn pipe size prints a line is UNCHECKED. Tim wants it said in a line.
   - **Added to the PITSCHEDULE robot list (batch 4, section 7, and every later batch):** open the Pit Schedule on a copy where a pipe's drawn size differs from CE's record. Read the command line for a "CE updated its record (...)" line naming the size read from the drawing, then read CE's record. Line present: PASS. Size written with no line: FAIL, to log as a gap.

## TRIAL: 2027-ONLY BUNDLE (PREPARED, NOT INSTALLED)

Written Sun 15 Nov 2026 04:20 by lane trust-safety-fixes, on the controller's order: prove what Tim's PC does with a Civil bundle missing the older-year sets BEFORE any script change (Tim, queue item 10, 02:32: the check comes first). Made by hand from the batch 5 payload. No repo file, build script or rule text was changed. Plan: `BUILD_2027_ONLY_PLAN.md`.

**Runs only after batch 5's own robot list has passed on the three-set build.** Then the only difference in the trial is the missing sets.

### 1. The payload

1. **Folder:** `C:\ce_rc_scratch\b14civ5_MODERNONLY\CE_CVL_SUITE.bundle`, 298 files. The name says MODERNONLY so it can never be taken for `b14civ5`.
2. **Made from batch 5** (`b14civ5`, 3.0.90.7+9b977125, checked against its manifest first, bad 0). The version string is unchanged (`3.0.90.7+9b977125` in the Modern DLL; `AppVersion="3.0.90.7"`).
3. **Removed in the copy:** `Contents\Win64\Legacy` (268 files) and `Contents\Win64\Net8` (266 files).
4. **`PackageContents.xml` trimmed:**
   - **Removed:** exactly the two `<Components>` blocks whose module is `./Contents/Win64/Legacy/...` (R24.1 to R24.9) and `./Contents/Win64/Net8/...` (R25.0 to R25.9). That is 116 lines with their command lists; nothing added.
   - **Left, all 2027:** Modern net10 build (R26.0 to R27.0), native action grips (R26.0 to R26.9), CE object enabler (R26.0 to R26.9). It parses as XML, and no `/Win64/Legacy/` or `/Win64/Net8/` path remains.
   - **Header comment:** kept as it was. It still describes the older blocks in words.
5. **Every other file equals batch 5 byte for byte** (0 differ), including the shared config at `Contents\Assets\Config`. That config came from the net48 build in batch 5; the planned switch would take it from net10, built from the same tracked files.
6. **Hashes:**
   - **Manifest:** `C:\CE_WORK\scratch\trust_install\b14civ5_MODERNONLY_manifest.txt`, 298 rows, SHA-256 `398732E280F8610744D7DD3375B22B7FA22B2C5623FEB3D192047AC429B8B7D9`.
   - **Modern `CE_CVL_SUITE.dll`:** `1111E937330B398458B613D3D54B873620B5A39259C2C06086B6F96FD36F835B` (the same as batch 5).
   - **`PackageContents.xml`:** `3675778F60725DF313B126D0A159AD5C4B8C359E32C3C938137EADA885608179`.
   - **CE_SHARED:** the Modern copy is identical to Manager's Modern copy.
7. **How it was made:** `make_modernonly.ps1` (scratchpad, throwaway). A first try trimmed too much, because the header comment mentions `<Components>`. The parse check caught it, and that copy was deleted before anything else was done.

### 2. Beside it: Manager and Structural (both still three-set, untouched)

1. **Manager 1.1.89:** its own bundle with Legacy, Net8 and Modern. In AutoCAD 2027 only its Modern set loads.
   - **CE_SHARED:** one assembly identity (first loaded wins). Civil's Modern CE_SHARED is byte-identical to Manager's Modern, so which loads first makes no difference. The install script checks this.
   - **Reading Civil's bundle:** Manager's plugin list (`CePluginRegistryService`) picks the entry for the running lane, which in 2027 is the Modern entry, still present. So Civil's version should show as before.
2. **Structural 1.0.126.1:** its own three-set bundle, no shared file with Civil's lanes; in 2027 its Modern set loads as today. Not touched.
3. **AutoCAD 2022 to 2026:** not tested (Tim's ruling). By reading, an older AutoCAD would find no Civil entry for itself in the trimmed file and would load no Civil, rather than fail on a missing file.

### 3. Install (one step; AutoCAD closed, outside Tim's hours, after batch 5 passed)

1. Run `C:\CE_WORK\scratch\trust_install\install_trial_modernonly.ps1` (NOT RUN; it parses clean). It:
   - refuses unless the trial manifest's hash is the reported one;
   - refuses unless live Civil reads `3.0.90.7+9b977125` with all three sets present;
   - hashes and copies the settings files aside;
   - renames live Civil to `CE_CVL_SUITE_PRE_9b977125_<time>.backup` and copies the trial in.
2. **Then it reads back:**
   - every file against the candidate (bad 0, extra 0);
   - no `Win64\Legacy` or `Win64\Net8` left;
   - Modern version `3.0.90.7+9b977125`;
   - `PackageContents.xml` equals the trial's, and names no older set;
   - CE_SHARED identical to Manager's Modern;
   - settings unchanged.
   - Log: `install_trial_modernonly.log`.

### 4. What the evidence lane checks (two AutoCAD 2027 starts, scratch copies)

1. **First start:**
   - "CE_CVL_SUITE v3.0.90.7 Started" in the CE log.
   - "Standalone CE Civil ribbon built" with the same panel count as on the three-set batch 5.
   - CE Civil, Manager and Structural menu groups load.
   - No "unable to load", missing-file, version-mismatch or bundle error line in the CE logs or AutoCAD's text window.
   - Manager's plugin list shows Civil 3.0.90.7.
2. **Smoke list:** the BUG-1456 smoke list once; PIT placed, saved, reopened; CDHELP; CDS; CDEDIT with Esc; Pit Schedule opened; CDLPD opened (batch 5's own change); CDRENUMBER to its question, then No.
3. **Second start:** close AutoCAD and start it again, with the same first-start checks (bundle loading is also remembered between starts).
4. **PASS means:** every check as on the three-set batch 5 and nothing new in the logs. Then the controller decides whether to keep it or put it back, and only then does the `-ModernOnly` switch go into one draft pull request on Tim's order.

### 5. Put back (one action, AutoCAD closed)

1. Run `C:\CE_WORK\scratch\trust_install\restore_trial_modernonly.ps1` (NOT RUN; it parses clean).
   - It renames the 2027-only bundle aside as `CE_CVL_SUITE_MODERNONLY_REMOVED_<time>.removed` and renames `CE_CVL_SUITE_PRE_9b977125_<time>.backup` back. If that backup is missing, it copies `C:\ce_rc_scratch\b14civ5\CE_CVL_SUITE.bundle`.
   - It then checks every file against `b14civ5_manifest.txt` (832), all three lane versions, CE_SHARED against Manager in all three lanes, and the settings files.
2. **Further back:** `restore_batch14e.ps1` (3.0.90.6), then the earlier ones.

### 6. Stop rules

1. Any load error, a missing ribbon panel or command, Manager showing Civil wrong, or settings changed: put back at once.
2. Any doubt about the PC's state: put back.

## BATCHES 4 AND 5 INSTALLED BACK TO BACK (controller, Sun 15 Nov 2026 03:15 and 03:16 PC clock)

On Tim's standing trial approval. Installed by the controller, after the evidence lane reported batch 3 with no FAIL and its AutoCAD closed (03:14).

1. **Why back to back:** testing, not fixing, was the hold-up (one AutoCAD). One combined robot and Codex list now runs on 3.0.90.7. If anything fails, the controller steps back one batch at a time with the restore scripts to find which batch caused it.
2. **Before:** no acad or accoreconsole running; autocad.json mode auto, a Sunday. Payloads read by the controller: batch 4 Modern `57F6FCCF...`, manifest `F6B9D2A5...`; batch 5 Modern `1111E937...`, manifest `24BD504C...`; both equal to their runbook sections. Batch 4's never-by-itself write-up (section 9) read by the controller first.
3. **Ran:** `install_batch14d.ps1` (03:15, "INSTALL VERIFIED: batch 4 (Civil 3.0.90.6)"), then, only after confirming live read `3.0.90.6+35cdad78` and the log said verified, `install_batch14e.ps1` (03:16, "INSTALL VERIFIED: batch 5 (Civil 3.0.90.7)"). Each: every file matches its candidate, CE_SHARED identical to Manager, settings unchanged.
4. **Live now:** `3.0.90.7+9b977125`, Modern SHA-256 `1111E937330B398458B613D3D54B873620B5A39259C2C06086B6F96FD36F835B`, read back by the controller.
5. **Backups kept, newest last:** `CE_CVL_SUITE_PRE_dadac7e7_20261115-014806.backup` (3.0.90.4), `CE_CVL_SUITE_PRE_3c620efe_20261115-031354.backup` (3.0.90.5), `CE_CVL_SUITE_PRE_35cdad78_20261115-031503.backup` (3.0.90.6). Put-back, one step each: `restore_batch14e.ps1`, then `restore_batch14d.ps1`, then `restore_batch14c.ps1`. None rehearsed.
6. **Not yet done:** nothing has run in AutoCAD on 3.0.90.6 or 3.0.90.7. Not accepted. Batch 3's numbered-pits case and Export CSV were not run before this install.

## SUPERSEDED BY BATCH 7, NEVER INSTALLED (15 Nov 06:20): BATCH 6, Civil 3.0.90.8. Do not install anything from this section; its folder `b14civ6` stays until batch 7 is installed, then it can go. The original heading was: BATCH 6 (PREPARED, NOT INSTALLED): Civil 3.0.90.8 = batch 5 (3.0.90.7) + draft 2049 (Unknown instead of made-up values) with Q13 and Q14, switch OFF

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order ("2049 is your next job, on that existing draft, as batch 6"). Its own folder and version. **Install only on the three-set batch 5:** the script refuses unless live Civil reads `3.0.90.7+9b977125` AND still has its Legacy and Net8 sets, so the 2027-only trial must be put back first. The controller installs.

### 1. What is in it

1. **PR 2049 (TRUST-06) at `f5fd98ea`.** Draft, auto-merge off. Each step was reviewed read-only, the review's findings were fixed, and the fixes were checked again.
2. **Q13 (Tim: "Listed as possible pipes, I tick"), met.** With `trust.showUnknownInsteadOfGuess` on:
   - **Not added by itself:** a line drawn by hand on a pipe layer is not added to CE's record. It gets no size, no CE identity and no links to pits.
   - **Where the gates are:** CE's record update, the relink's record step and its three callers, CDSYNC, CDUPGRADE and the dangling-pipe link step.
   - **Named in the record-change line:** "N lines on a pipe layer were not added to CE's record: they are possible pipes (CDCHECKCURRENT lists them)". It is said once for each new set of lines, not at every command.
   - **Named in CDCHECKCURRENT:** under the heading "Possible pipe: a line on a pipe layer is not in the CE record".
   - **No new window** (mock-up rule). There is no tick screen yet, so a line stays listed until that screen exists.
   - **Still recovered:** a pipe CE made, known by its CE pipe data, its CE link data (older pipes) or its Civil pipe identity.
   - **Switch off:** everything works as installed.
3. **Q14 (a drawn width only proposes a size), met by splitting the two.**
   - **`trust.reachesFollowDrawingUnits` (ON) now only changes reaches** (pit to its label, pit to its level text, restoring typed values by position).
   - **A drawn width is never stored as a size:** with the switch on it is left blank (Unknown).
   - **With the switch off the width reads exactly as installed.** On a metre drawing that means 0.225 as it stands, then the relink's old "at least 100" rule. The old converter is kept unused for a later proposal list.
4. **Q9 and Q10 (no size, material, lid class or pit type made up): met, with the switch on. Q12 (a blank invert stays worked out from the lowest connected pipe): met, the switch does not change it.**

### 2. Not in it, and why the switch ships OFF

1. **Q8 (a label within reach of two pits is Unknown, showing both): NOT met.** The nearer pit still wins. This is larger than a small change: it touches the record update's label matching, CDUPGRADE's label matching, CDUPGRADE's level-text matching (one text can be taken by two pits) and a CDCHECKCURRENT entry. **Handed over as the next step on 2049, separately.**
2. **Q11 (the pipe's direction proposed from drawn order for his tick): not met** (no proposal yet). An unlabelled pit is never given a number, which is met.
3. **Q7 ("?" in windows and lists, a warning before a schedule is placed): partly met.** An Unknown pit is kept off the placed schedule rather than shown with a "?" and a warning.
4. **So `trust.showUnknownInsteadOfGuess` ships OFF** (controller's rule: ON only if 2049 meets the answers and the whole test run passes). Q8 is the point not met. The robot turns it on for one scratch session only (section 6).
5. **Not built (later ideas, as ordered):** reading missing values from a drawn Pit Schedule; Q6 tick rules; Q15 units asked once; the tick screen.

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14f`, on `9b977125` (batch 5): a merge of 2049 at `f5fd98ea` as `1ebb6c4c`.
   - **TrustSettings:** both sides kept.
   - **REGRESSION_LOG:** both sides kept.
   - **`PitScheduleViewModel.Data.cs`:** batch 5's one left-out rule (BUG-1274), then 2049's Unknown check after it, unchanged.
   - **Build commit `62458eda`,** "Version: Civil 3.0.90.8".
2. **Product files changed against 3.0.90.7:** 22, all in `Modules/Drainage` plus the version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ6_files_changed.txt`. No native, shared, Manager or Structural file.
3. **Whole Civil test run on the merged code (Release, net10):** **22,715 passed, 0 failed, 32 skipped** (7 min 39 s).
4. **Staging-only slip, harmless:** in the build stack's `TrustSettings.cs` the merge dropped one `/// <summary>` comment line above `showUnknownInsteadOfGuess`. It is a code comment only, with no effect in AutoCAD. The draft 2049 itself is correct.

### 4. Against Tim's four "never by itself" rules (read in `wtB14f` at `62458eda`)

1. **`trust.showUnknownInsteadOfGuess` (OFF):** when on it only REMOVES fill-ins and additions. It never changes a level, size, number, label, layer or colour.
2. **`trust.reachesFollowDrawingUnits` (ON), the one point to weigh:**
   - **What it changes:** only in drawings whose units are metres (or another non-millimetre unit), how far from a pit CE looks for that pit's number label and level text when it reads the drawing (`ProjectDataService.Recovery.cs:352`, `LinkCommands.cs:1987` and `:2029`). It also changes how far CE looks when it restores typed values by position (`:844`).
   - **The effect:** today on a metre drawing the label reach is about 2,600 m (a 600 pit plus 2000, read as metres), so almost any text is in reach. With the switch on it is 2.6 m. It can only make CE read FEWER texts, never more.
   - **Writes nothing to the drawing:** it changes no level, label, layer or colour.
   - **The catch:** on a metre drawing, a level CE reads from Tim's own text into its record can differ from the installed build. That happens when the only text in reach before was too far away to belong to that pit.
   - **Not changed:** millimetre drawings and drawings with no units set.
   - **If the controller counts this as touching the levels rule:** switch it off in the settings, or hold batch 6. I can rebuild without it in about 30 minutes.
3. **No other ON setting is added.** The batch 5 and earlier switches are unchanged.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ6\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0; three sets (Legacy, Net8, Modern) verified; shared config verified; every dotnet call passes `-p:SkipDevBundle=true -nr:false --disable-build-servers`; nothing under ApplicationPlugins was written.
2. **DLL `3.0.90.8+62458eda4117a09839c56d1ec79bf85dc01cc08c` SHA-256:**
   - Legacy `58FE74C52335E7E6BBE73A9C1BF0C221E941EAB6997DE4CA99DBB92BD21BC417`
   - Net8 `DB2863E9EE8F6AB5463F2D5B09C2F1A8076FAF85848710BF1B071442304C4476`
   - Modern `44B634BD16DC38784C9D07A9EFA1A689305C04E2175257981D1A8268FF8EF573`
3. **`PackageContents.xml`:** `43808E90A2BB7D1F159F3C44BE0F41C95376F7E12AFEA11854C6B695B47CAC7D`, `AppVersion="3.0.90.8"`.
4. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ6_manifest.txt`, 832 rows, SHA-256 `7FB134D91E26BDE9D1B70759B1014A05D4C14B77BE605B4B2F9CCF81D699854B`.
5. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones. The installed bytes were put in, and CE_SHARED is identical to Manager x3. The natives are the installed bytes.
6. **Against batch 5 (`b14civ5`):** 7 files differ (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed.

### 6. Turning the switch on for ONE scratch session

As batch 4, section 4, with the folder `C:\CE_WORK\robot\b14f_switch`.

1. **Edit the COPY only:** in the copy of `CD_Settings.json`, in its `"trust"` group, set `"showUnknownInsteadOfGuess": true`.
2. **Start AutoCAD through a `.cmd`** that sets `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\robot\b14f_switch`, handed to Explorer.
3. **Check it took:** the CE log must say "Settings initialized from: C:\CE_WORK\robot\b14f_switch\settings\CD_Settings.json". If it does not, stop.
4. **Never touch** Tim's own `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. Hash it before and after; it must not change.

### 7. Robot and Codex list (scratch copies)

1. **First start, switch OFF (as shipped):** "CE_CVL_SUITE v3.0.90.8 Started". Then batch 5's list items 2 to 4 once, and the BUG-1456 smoke list once. Everything as on 3.0.90.7.
2. **Switch ON (section 6), the controller's 2049 list:**
   - **Edit Pit on a bare pipe-layer line:** draw a plain polyline on STORMWATER PIPE, then Edit Pit on a pit it touches. The pipe shows Unknown size and material, never 100 dia or UPVC. The command line has the possible-pipe line once ("1 line on a pipe layer was not added to CE's record ..."). CE's stored record does not gain the line.
   - **Edit Pit on an unlabelled pit:** a pit symbol with no number label shows Unknown, never a CE number, 350 x 350, Class C or grated pit.
   - **Cancel changes nothing:** CE's stored record is byte-identical before and after, and DBMOD stays 0.
   - **Pit Schedule:** the unlabelled pit and the bare line show as Unknown, or are left out and listed. Never 100 dia UPVC, never 350 x 350.
   - **CDCHECKCURRENT:** it lists the bare line under "Possible pipe: a line on a pipe layer is not in the CE record", and the unknown pit as Unknown.
   - **A CE-made pipe still comes back:** on a copy whose CE record is missing or lost (as the recovery cases in `PENDING_TESTS.md` make one), a pipe drawn with CE's own command is recovered; the bare line is not.
   - **Said once:** run CDCHECKCURRENT and Edit Pit again. The possible-pipe line is not repeated until another bare line is drawn.
   - **Metre drawing (`INSUNITS` 6) with a 0.225 wide bare line:** the size stays Unknown, never 225 and never 100.
3. **Q28 on the PITSCHEDULE list (as batch 4, known gaps item 2).**
4. **Then close AutoCAD and restart without the variable:** the switch is off again; Tim's file is unchanged.

### 8. Install and put back

1. **Install (after batch 5, trial put back if it was used):** `C:\CE_WORK\scratch\trust_install\install_batch14f.ps1`. NOT RUN; it parses clean.
   - It refuses unless live Civil reads `3.0.90.7+9b977125` with its Legacy and Net8 sets present.
   - It keeps `CE_CVL_SUITE_PRE_9b977125_<time>.backup`.
   - It reads every file back, checks 3.0.90.8 and CE_SHARED against Manager, and checks the settings are unchanged. Log: `install_batch14f.log`.
2. **Put back:** `restore_batch14f.ps1`, back to 3.0.90.7, checked against `b14civ5_manifest.txt`. NOT RUN; it parses clean. Further back: `restore_batch14e.ps1`, then `restore_batch14d.ps1`.

### 9. Stop rules

As section 5 at the top. If a pass fails, batch 6 is put back with `restore_batch14f.ps1`, and batch 5 stays.

## SUPERSEDED BY BATCH 8, NEVER INSTALLED (15 Nov 07:30): BATCH 7, Civil 3.0.90.9. Do not install anything from this section; its folder `b14civ7` stays until batch 8 is installed, then it can go. Its robot list is carried into BATCH 8, section 7. The original heading was: BATCH 7 (PREPARED, NOT INSTALLED; SUPERSEDES BATCH 6): Civil 3.0.90.9 = batch 5 (3.0.90.7) + draft 2049 (Unknown instead of made-up values, with Q8, Q13 and Q14) + 2092's flow-box words + 2093's CDRENUMBER fix, switch OFF

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order ("build batch 7 now, and make it SUPERSEDE batch 6 so only one of them is ever installed and tested"). One build, one version, one folder. **Install only on the three-set batch 5:** the script refuses unless live Civil reads `3.0.90.7+9b977125` and still has its Legacy and Net8 sets, so the 2027-only trial must be put back first. A live batch 6 is refused too, though batch 6 was never installed. The controller installs.

### 1. What is in it (each on its draft at a final head with a read-only GO)

1. **PR 2049 (TRUST-06) at `2e23413f`:** everything in batch 6 (Q13 possible pipes, Q14 width never a size, Q9, Q10, Q12), plus:
   - **Q8, "Unknown, show both":** with the switch on, a pit number label or a CL or IL text within reach of two or more pits is given to none of them.
     - **Command line:** said once ("1 label is within reach of more than one pit: CE gave it to none (CDCHECKCURRENT lists it).").
     - **CDCHECKCURRENT:** lists "Unknown: 'IL 9.10' could be P2 or P3 (invert level)" until the value is typed into one pit.
     - **One matching rule:** the record update and CDUPGRADE now share it. With the switch off it equals the installed matching on 500 random layouts.
   - **Batch build fix:** the record-touch guard in this batch's tests caught CDUPGRADE editing pits taken from CE's record outside the record service. The note is now set as each pit is built, and the pruning lives in the record service. Nothing was added to the guard's reviewed list.
2. **PR 2092 (CDRUNSOLVE) at `263e604d`:** the three no-flow lines now say where the box is: "Type each pipe's Design flow (Q) in Pipe Edit (CDEDIT: click More…, then the Levels & Flow tab), then run CDRUNSOLVE again." Words only; no window change.
3. **PR 2093 (CDRENUMBER) at `644cb90e`:** fixes what was seen in AutoCAD on batch 5 (`INSTALL_BATCH_RESULT_14NOV.md`, item 5b).
   - **The not-joined line and the loop line** are said every time, including when nothing needs renumbering (then no question is asked).
   - **The loop finder** looks at the whole drawing, not only from the outlet.
   - **"Nothing to renumber" is never said alone:** when pits were left out or a loop was found, the last line is "The pits joined to this outlet already read downhill to uphill - nothing to renumber. Nothing was changed."
   - **Unchanged:** with neither condition, the output is exactly as installed; the numbering and the question are as before.
   - **Why the batch 5 tests missed it:** they checked each line's words and the source order, never the command's path when nothing needs renumbering, and never a loop cut off from the outlet. The new tests run the real network builder on exactly cases (a) and (b).

### 2. The switch, and what is still not met

1. **`trust.showUnknownInsteadOfGuess` ships OFF** (controller's rule: ON only if 2049 meets the answers).
   - **Met now:** Q8, Q9, Q10, Q12, Q13 and Q14.
   - **Q11 not met:** the pipe's direction proposed from drawn order. That needs a screen, so it is left and noted for the ask chat.
   - **Q7 only partly met:** "?" in lists and a warning before a schedule is placed. The words-only part is the next step on 2049.
2. **Note for Tim (not a bug):** where pits sit close together, more labels may show as Unknown under Q8. That follows his words as given.

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14g`. It starts from the batch 6 merge `1ebb6c4c` (batch 5 + 2049 at `f5fd98ea`), then merges 2049 at `2e23413f`, 2092 at `263e604d` and 2093 at `644cb90e`.
   - **Conflicts:** REGRESSION_LOG only, both sides kept.
   - **One comment line** the batch 6 merge had dropped in `TrustSettings.cs` is restored.
   - **Build commit `b50778b9`,** "Version: Civil 3.0.90.9".
2. **Every product file equals its draft** (checked file by file for the 2049, 2092 and 2093 files).
3. **Product files changed against 3.0.90.7:** 26, all in `Modules/Drainage` plus the version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ7_files_changed.txt`. No native, shared, Manager or Structural file.
4. **Whole Civil test run on the merged code (Release, net10):** **22,742 passed, 0 failed, 32 skipped** (7 min 54 s).
   - **An earlier build of this batch was thrown away unreported:** it lacked 2093, and its run had found the record-touch guard point above. That folder was deleted; this is the only `b14civ7`.

### 4. Against Tim's four "never by itself" rules

1. **No ON-by-default setting is added beyond batch 6's.** `trust.reachesFollowDrawingUnits` (ON) is the same point to weigh as in batch 6, section 4 item 2. It narrows the label and level-text reach on metre drawings, can only read fewer texts, and writes nothing to the drawing.
2. **Q8 (switch OFF by default):** it only gives labels to fewer pits. It writes nothing to the drawing, and the note is in CE's record only.
3. **CDRUNSOLVE:** words only.
4. **CDRENUMBER:** more lines before the question. It still renumbers only after the drafter's Yes; when nothing needs renumbering it asks nothing and changes nothing.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ7\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0; three sets (Legacy, Net8, Modern) verified; shared config verified; every dotnet call passes `-p:SkipDevBundle=true -nr:false --disable-build-servers`; nothing under ApplicationPlugins was written.
2. **DLL `3.0.90.9+b50778b9646d94d83cf947a658213542597de65b` SHA-256:**
   - Legacy `31FD0B3C12E1568455330A1789DFA735497A9A32EE8F36BC65003FD8D7C452A7`
   - Net8 `DB2357E6E96E82DE876B1C3D9B7F525262D648C40F9DC73D3484E9C839B1FFA0`
   - Modern `EA934066DED68F5858A314EA41472DD765F66A6F90BC33C7A2380CED49E199EA`
3. **`PackageContents.xml`:** `0D9060DDE0C46031F3229AF85BC3007B82975C39AC7FF8B3D2E7794CDA5CA7B8`, `AppVersion="3.0.90.9"`.
4. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ7_manifest.txt`, 832 rows, SHA-256 `E23AC3BE922E674019A1BD9DE3E21E7E18C9CA81FB2CC5E61A3E32E8C212F70B`.
5. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones. The installed bytes were put in, and CE_SHARED is identical to Manager x3. The natives are the installed bytes.
6. **Against batch 5 (`b14civ5`):** 7 files differ (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed.

### 6. Turning the switch on for ONE scratch session

As batch 6, section 6, with the folder `C:\CE_WORK\robot\b14g_switch`.

1. **Edit the COPY only:** in its `"trust"` group set `"showUnknownInsteadOfGuess": true`.
2. **Start AutoCAD through a `.cmd`** that sets `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\robot\b14g_switch`, handed to Explorer.
3. **Check it took:** the CE log must say "Settings initialized from: C:\CE_WORK\robot\b14g_switch\settings\CD_Settings.json". If it does not, stop.
4. **Never touch** Tim's own `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. Hash it before and after.

### 7. Robot and Codex list (scratch copies)

1. **First start, switch OFF (as shipped):** "CE_CVL_SUITE v3.0.90.9 Started". Then batch 5's list items 2 to 4 once, and the BUG-1456 smoke list once. Everything as on 3.0.90.7, except items 6 and 7 below.
2. **Switch ON (section 6), the controller's list:**
   - **A bare pipe-layer line is a possible pipe and is not added.** Draw a plain polyline on STORMWATER PIPE, then run Edit Pit on a pit it touches. The command line has "1 line on a pipe layer was not added to CE's record: it is a possible pipe (CDCHECKCURRENT lists it)." once. CE's stored record does not gain the line. CDCHECKCURRENT lists it under "Possible pipe: a line on a pipe layer is not in the CE record".
   - **A label near two pits is Unknown, showing both.** Use a copy whose record is missing, with a pit label (or an "IL 9.10" text) placed halfway between two unnumbered pit blocks, both within reach. Run any command that updates the record, or CDUPGRADE. Neither pit takes that number or level. The command line says "1 label is within reach of more than one pit: CE gave it to none (CDCHECKCURRENT lists it).", and CDCHECKCURRENT lists "Unknown: '<label>' could be ... or ...". A label near one pit only is still read.
   - **A drawn width is never a size.** On a metre drawing (`INSUNITS` 6), a 0.225 wide bare line keeps its size Unknown, never 225 and never 100.
   - **A worked-out invert is kept and marked.** A pit with a blank IL joined to pipes that have inverts gets the lowest pipe invert. CDCHECKCURRENT says "1 pit invert level was worked out from the pipes" (evidence "Worked out by CE"). It is never turned into Unknown.
   - **Edit Pit Cancel changes nothing.** Edit Pit on an unlabelled pit shows Unknown (never a CE number, 350 x 350, Class C or grated pit). Then Cancel: CE's stored record is byte-identical before and after, and DBMOD stays 0.
   - **Pit Schedule and CDCHECKCURRENT** show Unknown or list the pit, never 100 dia UPVC or 350 x 350.
3. **Switch either way:**
   - **CDRUNSOLVE on a run with no design flow:** the line ends "... in Pipe Edit (CDEDIT: click More…, then the Levels & Flow tab), then run CDRUNSOLVE again." Nothing changed.
   - **CDRENUMBER, case (a):** the standard copy plus a lone pit P8. Before the end it says "Not joined to this outlet by pipes: P8. CDRENUMBER does not number them from this outlet. Check them." The last line is "The pits joined to this outlet already read downhill to uphill - nothing to renumber. Nothing was changed." There is no question and the drawing is unchanged.
   - **CDRENUMBER, case (b):** P10 to P9 and P9 to P10 after CDREVERSEFLOW Yes. It names "The pipe records loop back on themselves: P10 to P9 and P9 to P10. ..." and the not-joined pits if any, with the same last line. Nothing changed.
   - **CDRENUMBER with a real renumber:** as batch 5's list. The lines come before "[Yes/No]", and No changes nothing.
4. **Q28 on the PITSCHEDULE list** (as batch 4, known gaps item 2).
5. **Then close AutoCAD and restart without the variable:** the switch is off again; Tim's file is unchanged.

### 8. Install and put back

1. **Install (after batch 5; trial put back if it was used):** `C:\CE_WORK\scratch\trust_install\install_batch14g.ps1`. NOT RUN; it parses clean.
   - It refuses unless live Civil reads `3.0.90.7+9b977125` with its Legacy and Net8 sets present.
   - It keeps `CE_CVL_SUITE_PRE_9b977125_<time>.backup`.
   - It reads every file back, checks 3.0.90.9 and CE_SHARED against Manager, and checks the settings are unchanged. Log: `install_batch14g.log`.
2. **Put back:** `restore_batch14g.ps1`, back to 3.0.90.7, checked against `b14civ5_manifest.txt`. NOT RUN; it parses clean. Further back: `restore_batch14e.ps1`, then `restore_batch14d.ps1`.
3. **After batch 7 is installed and verified,** `C:\ce_rc_scratch\b14civ6` (batch 6, never installed) can be deleted.

### 9. Stop rules

As section 5 at the top. If a pass fails, batch 7 is put back with `restore_batch14g.ps1`, and batch 5 stays.

## BATCH 8 (PREPARED, NOT INSTALLED; SUPERSEDES BATCH 7): Civil 3.0.90.10 = batch 7's sources + 2039's left-out words + 2049's Q7, switch OFF

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order ("build batch 8 now and make it SUPERSEDE batch 7 ... same pattern as 7 over 6"). One build, one version, one folder. **Install only on the three-set batch 5:** the script refuses unless live Civil reads `3.0.90.7+9b977125` with its Legacy and Net8 sets, so the 2027-only trial must be put back first. The controller installs. **No further batch is built until the controller says** (testing first).

### 1. What is in it

1. **Everything in batch 7** (section BATCH 7, items 1 to 3): 2049 (Q8, Q9, Q10, Q12, Q13, Q14), 2092's flow-box words, 2093's CDRENUMBER fix.
2. **PR 2039 (BUG-1274 follow-up) at `5d5cb372`, read-only review GO:** the Pit Schedule's left-out line now names only controls the one-page Edit Pit window really has (seen by Codex on 3.0.90.7, PSN15 N1).
   - **Plastic pits:** "... The plastic-pit preset keeps them unnumbered and unscheduled." It promises no route, because the one-page window has none. The ask chat has a mock-up note for the missing button.
   - **Pits switched off for the schedule:** "... To add one, in Edit Pit (CDEDIT) turn on Pit label block on plan, then click More… and turn on Included in pit schedule (Drawing & Schedule tab)."
   - **Saved settings:** an old built-in sentence saved in settings reads as the new one; a sentence the drafter typed is kept.
   - **"1 row listed"**, and the left-out sentence and "Drawing check: ..." each have their own line in the window's banner.
3. **PR 2049 at `07511157` adds Q7, words and values only (switch on), read-only review GO:**
   - **The Pit Schedule:** a pipe that is there but has no size shows "?", in the window and on the placed schedule. The refresh after each command keeps it, and moving the table is not read as an edit. "?" is never written back as a size.
   - **Placing or updating a schedule:** one line first, "3 pipes have no size; the schedule will show ?.", then CE carries on.
   - **CDCHECKCURRENT:** "Unknown: N pipes have no size in CE's record".

### 2. The switch

`trust.showUnknownInsteadOfGuess` ships OFF.
- **Met:** Q7 (words-only part), Q8, Q9, Q10, Q12, Q13 and Q14.
- **Not met:** Q11 (direction proposed from drawn order) needs a screen and is in the ask queue.

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14g`: batch 7's stack `9fffa7bd` (before its version commit), then merges of 2039 at `5d5cb372` and 2049 at `07511157`.
   - **Conflicts:** REGRESSION_LOG only, both sides kept.
   - **Build commit `fcf465a9`,** "Version: Civil 3.0.90.10".
2. **Every product file equals its draft** for the 2039 and 2049 files. The shared Pit Schedule file carries both changes (checked by reading).
3. **Product files changed against 3.0.90.7:** 32, all in `Modules/Drainage` plus the version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ8_files_changed.txt`.
4. **Whole Civil test run on the merged code, after every review fix (Release, net10):** **22,757 passed, 0 failed, 32 skipped** (7 min 6 s).

### 4. Against Tim's four "never by itself" rules

As batch 7, section 4.
- **2039:** words only.
- **Q7:** shows "?" and says one line. It never writes a size, level, number, label, layer or colour.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ8\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0; three sets verified; shared config verified; every dotnet call passes `-p:SkipDevBundle=true -nr:false --disable-build-servers`; nothing under ApplicationPlugins was written.
2. **DLL `3.0.90.10+fcf465a957ea2a726d917ba41140c3c46dc6aaaf` SHA-256:**
   - Legacy `067550B1ECAAF3D3A5A08E865F128555704B6532BB44D26E3E036E3518C44D3E`
   - Net8 `12B63F1C70BFE5F87B6608099A18242D02008EA127207F3EFBDA87C39995D9D3`
   - Modern `1D59E3B16F879EE09F6581F13963D37ECC97844E122D1AD1090AFD6749C0FE79`
3. **`PackageContents.xml`:** `8FF7683D4AABD073523A5EDDCEC0BFA1803BC89FC3CA3F088E2FDDE6A2A901E5`, `AppVersion="3.0.90.10"`.
4. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ8_manifest.txt`, 832 rows, SHA-256 `EC2B393F0F7CA69E7DC0B5BC7742132EF6E5C1EE378512BB0938B25E6AECC8A6`.
5. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones. The installed bytes were put in, and CE_SHARED is identical to Manager x3. The natives are the installed bytes.
6. **Against batch 5 (`b14civ5`):** 7 files differ (CE_CVL_SUITE.dll and .pdb x3, PackageContents.xml), 0 added, 0 removed.

### 6. Turning the switch on for ONE scratch session

As batch 7, section 6, with the folder `C:\CE_WORK\robot\b14h_switch`. The CE log must say "Settings initialized from: C:\CE_WORK\robot\b14h_switch\settings\CD_Settings.json". Tim's own settings file must not change.

### 7. ONE robot and Codex list for batches 7 and 8 (scratch copies)

1. **First start, switch OFF (as shipped):** "CE_CVL_SUITE v3.0.90.10 Started". Then batch 5's list items 2 to 4 once, and the BUG-1456 smoke list once. Everything as on 3.0.90.7, except items 3 and 4 below.
2. **Switch ON (section 6):** all of batch 7's section 7, item 2: the possible pipe not added; a label near two pits Unknown showing both; a width never a size; a worked-out invert kept and marked; Edit Pit Cancel changes nothing; Pit Schedule and CDCHECKCURRENT never show 100 dia UPVC or 350 x 350. Then:
   - **Q7, the schedule:** on a copy with a CE pipe whose size is Unknown, open the Pit Schedule. Its size cell shows "?".
     - **Place the schedule:** the command line says "1 pipe has no size; the schedule will show ?." before the insertion point is asked, and the placed table shows "?".
     - **Then run PITEDIT and Cancel** (any CE command): the placed "?" is still there.
     - **MOVE the table:** no "is not a number" line and no change to CE's record.
   - **Q7, the check list:** CDCHECKCURRENT lists "Unknown: 1 pipe has no size in CE's record".
3. **Switch either way:**
   - **CDRUNSOLVE on a run with no design flow:** the line names "Pipe Edit (CDEDIT: click More…, then the Levels & Flow tab)". Nothing changed.
   - **CDRENUMBER, case (a), lone P8; case (b), the P10/P9 loop after CDREVERSEFLOW:** as batch 7, section 7, item 3, last line "The pits joined to this outlet already read downhill to uphill - nothing to renumber. Nothing was changed." No question, drawing unchanged.
   - **CDRENUMBER with a real renumber:** the lines come before "[Yes/No]", and No changes nothing.
4. **Pit Schedule left-out line (2039):**
   - **Plastic:** on the 4 Nov copy with unnumbered plastic pits, the window's banner names them and ends "The plastic-pit preset keeps them unnumbered and unscheduled." No button is named.
   - **Switched off:** a pit with Included in pit schedule turned off. The line names "in Edit Pit (CDEDIT) turn on Pit label block on plan, then click More… and turn on Included in pit schedule (Drawing & Schedule tab)". Do exactly that in Edit Pit: the pit joins the schedule.
   - **One row:** with exactly one row listed, the window says "1 row listed".
   - **With a drawing-check issue as well:** the two sentences show on separate lines.
5. **Q28 on the PITSCHEDULE list** (as batch 4, known gaps item 2).
6. **Then close AutoCAD and restart without the variable.**

### 8. Install and put back

1. **Install (after batch 5; trial put back if it was used):** `C:\CE_WORK\scratch\trust_install\install_batch14h.ps1`. NOT RUN; it parses clean.
   - It refuses unless live Civil reads `3.0.90.7+9b977125` with its Legacy and Net8 sets present.
   - It keeps `CE_CVL_SUITE_PRE_9b977125_<time>.backup`.
   - It reads every file back, checks 3.0.90.10 and CE_SHARED against Manager, and checks the settings are unchanged. Log: `install_batch14h.log`.
2. **Put back:** `restore_batch14h.ps1`, back to 3.0.90.7, checked against `b14civ5_manifest.txt`. NOT RUN; it parses clean. Further back: `restore_batch14e.ps1`, then `restore_batch14d.ps1`.
3. **After batch 8 is installed and verified,** `C:\ce_rc_scratch\b14civ6` and `b14civ7` (never installed) can be deleted.

### 9. Stop rules

As section 5 at the top. If a pass fails, batch 8 is put back with `restore_batch14h.ps1`, and batch 5 stays.

### 10. Fixtures for 2049 (added 15 Nov 09:35 by lane trust-safety-fixes, on the controller's order)

Four scratch test drawings for the 2049 checks the evidence lane could not run.

**How they were made:**
- **Tool:** the core console in the isolated profile (09:30, about 16 s in all, under the shared lock "Claude-trustfixtures", released after), with batch 8's own Civil (3.0.90.10).
- **Method:** each drawing was made from AutoCAD's metric template with CE's own routines (pit and label blocks by `BlockService.InsertBlock`, pipe link data by `LinkService.RegisterPipe`). CE's record was written by CE's own writer (`ProjectDataService.SaveToDrawing`), or removed where the check needs it missing. Each saved file was then read back.
- **Nothing live touched:** Tim's live CE log, telemetry, settings file and the installed plug-in were checked untouched.
- **Never in a repo.** Folder: `C:\CE_WORK\scratch\fixtures2049\out\` (read-back: `fixtures-report.txt`). Probe and runner: `C:\CE_WORK\scratch\fixtures2049\`.
- **Open COPIES, as with every scratch drawing.** "Record update" below means any command that updates CE's record. For example, Edit Pit (CDEDIT) on a pit then Cancel, or PITSCHEDULE. Read-only tools such as CDCHECKCURRENT do not update it.

1. **`FIX2049_1_Q8_label_between_two_pits.dwg`** (millimetres, no CE record).
   - **Contents:** pits at 0,0 and 1500,0; label P4 at 600,300 (600 from the first pit, about 960 from the second, both within reach); text "IL 9.10" at 600,-300. The control: a pit at 10000,0 with label P7 and "IL 8.50" near it only.
   - **Switch ON:**
     - After the record update, the record line includes "1 label is within reach of more than one pit: CE gave it to none (CDCHECKCURRENT lists it)."
     - The two near pits get no number; the far pit is P7.
     - CDCHECKCURRENT lists "Unknown: 'P4' could be an unnumbered pit or an unnumbered pit", plus a "number is not known" item for each near pit.
     - Then CDUPGRADE: neither near pit reads IL 9.10. CDCHECKCURRENT adds "Unknown: 'IL 9.10' could be ... (invert level)". The far pit reads IL 8.50.
   - **Switch OFF (as installed):**
     - The nearer pit (0,0) takes P4, and the other gets a CE number, counted as guessed.
     - CDUPGRADE gives IL 9.10 to both near pits.
2. **`FIX2049_2_Q14_metre_drawing.dwg`** (INSUNITS metres, no CE record).
   - **Contents:**
     - A pit at 0,0 with label P5 2 m away (2,0).
     - A pit at 100,0 with label P6 30 m away (130,0). Both pit and label blocks are at scale 0.001, as a metre drawing has them.
     - A bare line on STORMWATER PIPE drawn 0.225 wide (10,-10 to 40,-10), drawn by hand.
     - A line on STORMWATER PIPE 0.225 wide (10,-20 to 40,-20) that CE made (CE pipe link data, size 0) but whose record is missing.
   - **Reaches (switch "reaches follow the drawing's units" ON, the default):** P5 is matched to its pit (2 m is inside the pit's width plus 2 m). P6 at 30 m is not.
     - **Show Unknown ON:** the pit at 100,0 has no number.
     - **Show Unknown OFF:** it gets a CE number.
     - **With the units switch OFF:** both labels are read, because the reach is read as 2,600 units.
   - **Show Unknown ON:**
     - The bare line is not added: the line "1 line on a pipe layer was not added to CE's record: it is a possible pipe ..." appears, and CDCHECKCURRENT lists "Possible pipe ...".
     - The CE-made line is recovered with its size Unknown (blank): never 225, never 100.
   - **Show Unknown OFF:** both lines are added as installed. Neither size may read 225.
3. **`FIX2049_3_Q12_worked_out_invert.dwg`** (millimetres, CE record present).
   - **Contents:** P1 (0,0) has no invert in the record. Pipes P2 to P1 (ends 9.800) and P3 to P1 (ends 9.750), both 225, linked to the pits.
   - **Switch ON:** after the record update, P1's invert reads 9.750. CDCHECKCURRENT lists "1 pit invert level was worked out from the pipes" (evidence "Worked out by CE"). It is never Unknown.
   - **Switch OFF:** P1's invert reads 9.750 as installed, with no "worked out" item.
4. **`FIX2049_4_Q7_pipes_with_no_size.dwg`** (millimetres, CE record present).
   - **Contents:** P1 at 0,0 with three pipes into it from P2, P3 and P4. All three are recorded with no size, and their CE link data holds size 0. Every pit has a number, 600 x 600 and levels, so all four are on the schedule.
   - **Switch ON:**
     - **The window:** in the Pit Schedule, every pipe-size cell for those three pipes shows "?".
     - **Placing:** Place schedule says "3 pipes have no size; the schedule will show ?." before the insertion point is asked, and the placed table shows "?".
     - **After placing:** PITEDIT then Cancel leaves the "?". MOVE on the table gives no "is not a number" line and leaves the record as it was.
     - **CDCHECKCURRENT:** "Unknown: 3 pipes have no size in CE's record".
   - **Switch OFF (as installed):** blank size cells, no line before placing, no CDCHECKCURRENT item. If CE's record update fills a size in, the record line counts it as guessed.

**One note from making them:** CE's draw-order step at the end of the core console command logged "eLockViolation". That was after each drawing was saved, so the files are unaffected; it is a headless-only effect.

## TRIAL 2027-ONLY BUNDLE INSTALLED (controller, Sun 15 Nov 2026 07:32 PC clock)

On Tim's queue item 10 answer (ask chat, 02:32: "Take them out of the build", the check on his own PC first) and his standing trial approval. A trial: it is put back after its short list.

1. **What:** the same Civil 3.0.90.7+9b977125 build with the 2027 set only (no Win64 Legacy, no Win64 Net8, PackageContents trimmed to the 2027 entries), 298 files. Structural and Manager untouched (still three-set).
2. **Before:** no acad or accoreconsole running; trial manifest read by the controller `398732E2...`, PackageContents `3675778F...`, 298 files, Modern folder only; install script read by the controller.
3. **Ran:** `install_trial_modernonly.ps1`: 298 candidate, 298 live, bad 0, extra 0; no Legacy, no Net8; Modern reads 3.0.90.7+9b977125; PackageContents equals the trial's; CE_SHARED identical to Manager's Modern; four settings files unchanged; "TRIAL INSTALL VERIFIED".
4. **Backup of the three-set build:** `CE_CVL_SUITE_PRE_9b977125_20261115-073054.backup`. Put-back: `restore_trial_modernonly.ps1` (not rehearsed).
5. **Not yet done:** AutoCAD has not been started on it.

## TRIAL 2027-ONLY BUNDLE PUT BACK (controller, Sun 15 Nov 2026 07:44 PC clock)

1. **Trial result (evidence lane, two AutoCAD 2027 starts, 07:33 and 07:38):** "v3.0.90.7 Started" both; ribbon "CE (9 panels)" both; no error or load-failure lines in the CE logs; opening line both; mix-up smoke 3 of 3; Pit Schedule opens; CDCHECKCURRENT runs. **Open:** both starts printed "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and the same for CE_SUITE_MANAGER_MENU on the command line; whether the three-set build prints the same was not captured before, so one three-set comparison start is being run. Detail: `INSTALL_BATCH_RESULT_14NOV.md`, "2027-ONLY TRIAL".
2. **Put back:** `restore_trial_modernonly.ps1`, the first put-back script run in this work. The put-back WORKED: the 2027-only bundle renamed aside (`CE_CVL_SUITE_MODERNONLY_REMOVED_20261115-074353.removed`), the three-set backup renamed back, 832 manifest files, bad 0, extra 0; Legacy, Net8, Modern all 3.0.90.7+9b977125; CE_SHARED identical to Manager x3.
3. **A bug in the script, found by running it:** its settings loop reuses the name of its scratch-folder variable (`$s` and `$S` are the same name in PowerShell), so it crashed before its settings lines and its final "VERIFIED" line. The controller then read by hand: live Modern `1111E937...`, 832 files, three sets, and the four settings files equal to the copies taken before the trial. The same bug is likely in the other unrun put-back scripts; the fix lane is correcting them. Until then a put-back still works but must be finished by hand as above.

## BATCH 8 INSTALLED (controller, Sun 15 Nov 2026 07:48 PC clock)

On Tim's standing trial approval. Batches 6 and 7 were superseded and never installed.

1. **What:** Civil 3.0.90.7 became `3.0.90.10+fcf465a9` = batch 5 + draft 2049 at `07511157` (Unknown instead of made-up values with Tim's answers Q7 to Q10, Q12 to Q14; its switch OFF) + 2093 at `644cb90e` (CDRENUMBER lines print when nothing needs renumbering) + 2092 at `263e604d` (CDRUNSOLVE message says where the Design flow box is) + 2039 at `5d5cb372` (Pit Schedule words that match the one-page Edit Pit window). `trust.reachesFollowDrawingUnits` comes ON with it (read by the controller in the code: converts the pit label and level-text search distance to the drawing's units; writes nothing; millimetre drawings unchanged).
2. **Before:** the 2027-only trial put back and checked; no acad or accoreconsole running; payload read by the controller, Modern `1D59E3B1...`, manifest `EC2B393F...`, equal to the runbook.
3. **Ran:** `install_batch14h.ps1`: 832 candidate, 832 live, bad 0, extra 0; all three sets 3.0.90.10; CE_SHARED identical to Manager x3; four settings files unchanged; "INSTALL VERIFIED".
4. **Live Modern DLL SHA-256 read back by the controller:** `1D59E3B16F879EE09F6581F13963D37ECC97844E122D1AD1090AFD6749C0FE79`.
5. **Backup:** `CE_CVL_SUITE_PRE_9b977125_20261115-074708.backup` (3.0.90.7). Put-back `restore_batch14h.ps1` (not run; the settings-loop bug found at 07:44 is being corrected in it).
6. **Not yet done:** nothing has run in AutoCAD on 3.0.90.10. Not accepted.

## BATCH 9 (PREPARED, NOT INSTALLED): Civil 3.0.90.11 = batch 8's sources + 2039 at 102bb87f + 2049 at f9d35d0c + 2111 at 43436c90, switches OFF

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order of 15:15: "build BATCH 9 as one trial payload under his standing trial approval, same method as batch 8". One build, one version, one folder. **Install only on batch 8:** the script refuses unless live Civil reads `3.0.90.10+fcf465a9` with all three sets. The controller installs. No merge, nothing to colleagues.

### 1. What is in it

1. **Everything in batch 8** (section BATCH 8, item 1), unchanged.
2. **PR 2039 at `102bb87f`** (Tim's picture OKs of 15 Nov):
   - **Pit Schedule:** the unnumbered plastic pits left out become one quiet grey count under the table, "3 plastic pits not listed (no number)" (singular "1 plastic pit not listed (no number)"), with the full sentence on hover. Tim: "OK as shown" and "OK as written", 10:21.
   - **Edit Pit:** "Number and schedule this one anyway" is behind More…, beside "Included in pit schedule" (his choice B). The Pit Schedule's plastic line can name that route again.
3. **PR 2049 at `f9d35d0c`, Q11** (his picture 2, "Both", 10:16): with `trust.showUnknownInsteadOfGuess` on, a pipe the record update adds to a pit with no number gets a Proposed flow direction.
   - **Check this drawing:** the pipe is listed as "Pipe P7 to pit ?" with an amber "Proposed", Correct and Reverse. The buttons run the new hidden CDPIPEDIRECTION, one Undo.
   - **Edit Pipe:** a Flow direction row; the press is held until Save.
   - **Switch off:** nothing.
4. **PR 2111 at `43436c90`, New Pipe on one page** (Tim: "build New Pipe"). With `trust.newPipeOnePage` on, CD opens the one-page window:
   - the answer card with its sum and a status word;
   - size, material, grade, start and end level, each saying where it came from;
   - More…, which opens today's full window;
   - Draw pipe and Cancel.

   It fills the same New Pipe answers; CD draws as before. **Switch off:** today's window.

### 2. The switches

1. **As shipped:** `trust.showUnknownInsteadOfGuess` OFF, `trust.newPipeOnePage` OFF; every other switch as batch 8.
2. **Picture differences** are listed in `04_REFERENCE/mockups/BUILT_VS_PICTURE_15NOV.html`. One to watch: CE rounds a worked-out fall up to the next 10 mm, so the New Pipe page's sum shows "= 18.126, kept as 18.12 end".

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14g`: batch 8's stack `75c75f23` (before its version commit), then merges of 2039 at `102bb87f` (`a66d3ae5`) and 2111 at `43436c90` (`45468827`; it carries 2049 at `f9d35d0c`).
   - **Conflicts:**
     - `PitScheduleViewModel.Data.cs`: two different methods added at the same place; both kept.
     - `CrossModuleGuardTests.cs`: Civil command count, batch 8's 148 (CETRUSTREAD) plus CDPIPEDIRECTION = 149.
     - `REGRESSION_LOG.md`: both sides kept.
   - **One build-stack change (`471c6402`, never pushed):** Q11's two record routines (`MarkProposedDirections`, `MarkPipeDirectionSure`) now ask batch 8's BUG-1456 change door first ("never change another drawing's record"), as every routine that changes the record does. The door exists only in batch 8's code, so this lives in the stack. It goes into 2049 when 2049 is brought up to batch 8.
   - **Build commit `249b9f8d`,** "Version: Civil 3.0.90.11".
   - **The first build of the stack (15:16) was thrown away.** Its whole-suite run failed 9 of 22,835 tests. All 9 were real faults in the drafts that the narrower runs had missed. They are now fixed and pushed on the drafts:
     - **2049 (`f9d35d0c`):** Edit Pipe accepted the record hold before its "no changes" exit when only Correct or Reverse was pressed. CDPIPEDIRECTION's keywords were not written as plain words, so the keyword guards could not read them.
     - **2039 (`102bb87f`):** the window-inventory test still recorded the missing Edit Pit button. Tim's choice B reverses that expectation, and the test says so.
     - **Stack:** the change door (above).
2. **Every draft file equals its draft**, except files batch 8 also changed. Those were checked by reading: the only differences are batch 8's own lines (Q7's "?" in the Pit Schedule, the CDEDIT hold, the TRUST-06 schedule check).
3. **Product files changed against batch 8 (`fcf465a9`):** 30, all in `Modules/Drainage` (including its tests) plus the version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ9_files_changed.txt`.
4. **Whole Civil test run on the merged code (Release, net10):** **22,804 passed, 0 failed, 32 skipped** (6 min 16 s), on the second build.

### 4. Against Tim's four "never by itself" rules

1. **Grey count and Edit Pit button:** words and one button. The button numbers and schedules one plastic pit only when the drafter presses it (his choice B).
2. **Q11:** nothing is written until Correct or Reverse is pressed. Reverse turns the pipe round with CDREVERSEFLOW's own step; locked layers, Xrefs and REFEDIT refuse as before.
3. **New Pipe page:** it only collects answers. It never writes a level, size, number, label, layer or colour; CD does the drawing exactly as today.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ9\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0; every dotnet call passes `-p:SkipDevBundle=true -nr:false --disable-build-servers`; nothing under ApplicationPlugins was written.
2. **DLL `3.0.90.11+249b9f8d67fd939f527fae1e4a61d97a225cc1f4` SHA-256:**
   - Legacy `5CDED12E6A080D0A9A0381ADF41D6FAC6A2EC79EF4433D4406061FDFF9664B99`
   - Net8 `13BDAB7CA94B89C0505CD92B9DF458003D47773CB34EA9245D14EBD82B6CE40D`
   - Modern `107F9BD7F9198737FCA0685404A3B4071D76A00D0A0CE26376707989FF1FDC74`
3. **`PackageContents.xml`:** `351CA810B8CB8905C5D20705FE0131679283DDDD9D502407E6FBEE64CE5A965D`, `AppVersion="3.0.90.11"`.
4. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ9_manifest.txt`, 832 rows, SHA-256 `F27979CD707AC9AA3F38A9C55753C9AECD2177DDDB29C47EBEA0C8945B7CCB1F`.
5. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones. The installed bytes were put in, and CE_SHARED is identical to Manager x3. The natives are the installed bytes.
6. **Against batch 8 (`b14civ8`, live):** 11 files differ, 0 added, 0 removed. They are CE_CVL_SUITE.dll and .pdb x3, `command-registry.json` x4 (the hidden CDPIPEDIRECTION entry) and PackageContents.xml.

### 6. Turning a switch on for ONE scratch session

As batch 7, section 6, with the folder `C:\CE_WORK\robot\b14i_switch`.
1. **Edit the COPY only:** in its `"trust"` group, set `"newPipeOnePage": true` for the New Pipe items. For Q11, also set `"showUnknownInsteadOfGuess": true`.
2. **Start AutoCAD** through a `.cmd` that sets `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\robot\b14i_switch`, handed to Explorer.
3. **Check it took:** the CE log must say "Settings initialized from: C:\CE_WORK\robot\b14i_switch\settings\CD_Settings.json". If it does not, stop.
4. **Tim's own settings:** never touch `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. Hash it before and after.

### 7. ONE robot and Codex list for batch 9 (scratch copies)

1. **First start, switches OFF (as shipped):**
   - The log reads "CE_CVL_SUITE v3.0.90.11 Started".
   - Run the BUG-1456 smoke list once.
   - **New Pipe, switch off:** CD opens today's New Pipe window, unchanged (same window as 3.0.90.10). Draw one pipe P to P; one U takes it back.
   - **Pit Schedule grey count (2039):** use the 4 Nov copy with unnumbered plastic pits. Under the table: "N plastic pits not listed (no number)" in quiet grey (singular "1 plastic pit not listed (no number)"). The full sentence shows on hover. No plastic pit is added to the table.
   - **Edit Pit More… button (2039):**
     - On a plastic pit, open Edit Pit (CDEDIT) and click More… On the Drawing & Schedule tab, "Number and schedule this one anyway" sits beside "Included in pit schedule".
     - Cancel: nothing changes.
     - Press it, then Save: that one pit gets a number and joins the Pit Schedule, and it stays plastic. One U puts it back.
   - **Q11 with the switch off:** on the fixture below, Check this drawing shows no "Proposed" item, and Edit Pipe shows no Flow direction row.
2. **Switch session with `newPipeOnePage` ON (section 6):**
   - **Opens:** CD, pick a route from one pit to another. The one-page New Pipe window opens. The title reads "New pipe: P.. to P..", and the answer card shows size, material, grade, the sum and a status word.
   - **Cancel:** nothing drawn; the command line says CD was cancelled. Esc does the same.
   - **Draw P to P:** press Draw pipe. The pipe is drawn as CD draws it today: same layer, label, arrow and record row. Its levels match the page: the end level shown "worked out from the grade" is the one written.
   - **One U:** a single U takes the whole pipe back.
   - **Save and reopen:** draw a pipe, save, close and reopen the copy. The pipe, its label and its record row are still there.
   - **More…:** opens today's full New Pipe window with the same size, material and levels. Cancel there comes back to the one page, answers kept. Draw pipe there draws the pipe.
   - **Both levels typed:** the answer shows no "at 1 in" grade, the grade box cannot be typed in, and the note reads "worked out from your two levels".
3. **Switch session with `showUnknownInsteadOfGuess` ON, Q11 on the fixture:**
   - **Setup:** on a copy of `C:\CE_WORK\scratch\fixtures2049\out\FIX2049_2_Q14_metre_drawing.dwg`, or any copy where the record update adds a pipe that runs to an unnumbered pit, run a command that updates the record (Edit Pit then Cancel).
   - **Check this drawing (CDCHECKCURRENT):** "Pipe P.. to pit ?" with an amber "Proposed", plus Correct and Reverse.
   - **Correct:** the item goes, and the command line says "...direction marked Sure. Ctrl+Z once puts it back."
   - **Reverse** (on another such pipe): the pipe turns round with its arrow, and the command line ends "turned round and marked Sure."
   - **One U** puts it back.
   - **Edit Pipe on a Proposed pipe:** the Flow direction row shows. Press Reverse, then Cancel: nothing changes. Press Reverse, then Save: the pipe turns round.
   - **While another command is running,** the list's buttons type nothing.
4. **Then close AutoCAD and restart without the variable.**

### 8. Install and put back

1. **Install (on batch 8):** `C:\CE_WORK\scratch\trust_install\install_batch14i.ps1`. NOT RUN.
   - **What it checks:** it refuses unless live Civil reads `3.0.90.10+fcf465a9` with all three sets. It also checks the candidate against `b14civ9_manifest.txt` and CE_SHARED against the live Manager.
   - **What it does:** keeps `CE_CVL_SUITE_PRE_fcf465a9_<time>.backup`, then reads every file back. It checks 3.0.90.11, CE_SHARED and the settings. Log: `install_batch14i.log`.
   - **`-CheckOnly`:** changes nothing. Run here: at 15:50: "CHECKS PASSED: nothing was renamed, copied or changed". Live reads 3.0.90.10+fcf465a9 with all three sets; the candidate against its manifest is 832 rows, bad 0, extra 0; the candidate CE_SHARED is identical to the live Manager x3; 4 settings files were read.
2. **Put back:** `restore_batch14i.ps1`, back to 3.0.90.10, checked against `b14civ8_manifest.txt`. NOT RUN.
   - **`-CheckOnly`** was run here at 15:17 against today's live batch 8: "PUT-BACK VERIFIED: Civil equals the 3.0.90.10 payload file for file" (832, bad 0, extra 0; CE_SHARED identical x3; settings unchanged).
   - **Further back:** `restore_batch14h.ps1`.

### 9. Stop rules

As section 5 at the top. If a pass fails, batch 9 is put back with `restore_batch14i.ps1`, and batch 8 stays.

## BATCH 10 (PREPARED, NOT INSTALLED): Civil 3.0.90.12 = batch 9's sources + 2111 at 568f63b1 (New Pipe one page: Esc and More… fixes from NP16), switches OFF

Written Sun 15 Nov 2026 by lane trust-safety-fixes, on the controller's order after Codex's NP16 P1 run. That run was on Civil 3.0.90.11 in real AutoCAD with the switch on (`C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_NP16_P1_20261115_1754.md`). The order was the controller's, inside Tim's "build New Pipe" and his standing trial approval. One build, one version, one folder. **Install only on batch 9:** the script refuses unless live Civil reads `3.0.90.11+249b9f8d` with all three sets. The controller installs. No merge, nothing to colleagues.

### 1. What is in it

1. **Everything in batch 9** (section BATCH 9, item 1), unchanged.
2. **PR 2111 at `568f63b1`** (one commit on top of batch 9's `43436c90`):
   - **Esc (NP16 P-02 FAIL):** one Esc now closes the page exactly as Cancel does, wherever the keyboard is on the page.
     - **Cause:** AutoCAD's command line, where CD was typed, kept the keyboard. AutoCAD 2027's command line takes key messages before the page while it holds the keyboard.
     - **Fix:** the page takes the keyboard when it opens and when it comes back to the front (draws nothing), and an Esc meant for the page is caught first.
     - **The same fix:** Enter (Draw pipe) now reaches the page too. An open size or material list closes first, as in every Windows list.
   - **More… (NP16-18):** opens the window CD shows today with the switch off, chosen and sized by CD's own step: the tabbed New Pipe window, or the older one fitted to the screen if the tabbed one does not fit. Batch 9 had opened the older window at its own smaller size, with the level boxes out of sight.
3. **Starting size (NP16 check, nothing changed):** the robot run opened `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\CLDTP_B9NP.dwg` and Codex opened `C:\Lisp Files\_TEST_COPIES_20260923\CLDTP_NP16.dwg`. They are not the same drawing copy: two folders, so two jobs.
   - A new pipe starts from the size last drawn in this job (the drawing's folder). With no pipe yet, it starts from the office default, 100.
   - The settings copy remembers a 225 drawn in `_TEST_COPIES_20260923` on 29 Sep. No pipe was drawn between the runs. Same rule as today's window.

### 2. The switches

1. **As shipped:** `trust.showUnknownInsteadOfGuess` OFF, `trust.newPipeOnePage` OFF; every other switch as batch 9.
2. **Look:** unchanged from batch 9. No new render.

### 3. How it was put together

1. **Build stack** (local, detached, never pushed) in `C:\CE_WORK\build\wtB14g`: batch 9's stack `471c6402` (before its version commit), then a merge of 2111 at `568f63b1` (`158752be`). The only conflict was `REGRESSION_LOG.md`, with both sides kept. The three product and test files equal the draft byte for byte.
2. **Build commit `af50b86a`,** "Version: Civil 3.0.90.12".
3. **Product files changed against batch 9 (`249b9f8d`):** 4: `NewPipeOnePageWindow.cs`, `DialogService.cs`, and the two version lines. List: `C:\CE_WORK\scratch\trust_install\b14civ10_files_changed.txt`.
4. **Whole Civil test run on the merged code (Release, net10):** **22,812 passed, 0 failed, 32 skipped** (7 min 8 s).
5. **The new tests:**
   - A real Esc key message sent to the shown page, 6 cases. The 3 cases with AutoCAD's kind of key-taking command line in front failed on the batch 9 page.
   - The page has the keyboard as soon as it is drawn.
   - More… goes through CD's own window step.
   - All three sets build with 0 errors on the draft.

### 4. Against Tim's four "never by itself" rules

Unchanged from batch 9. The page only collects answers; Esc only cancels; More… shows today's window on the same answers.

### 5. Payload

1. **Payload:** `C:\ce_rc_scratch\b14civ10\CE_CVL_SUITE.bundle`, 832 files. `build_installer.ps1` exit 0. Every dotnet call passes `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Nothing under ApplicationPlugins was written.
2. **DLL `3.0.90.12+af50b86a40ab144485f4c04f1031dc5960f9144f` SHA-256:**
   - Legacy `C0549D4BA220507156016E5F7E8960F521B1082917AC176055C7915E656AEAB6`
   - Net8 `5367C10C5FECBE5DE022962EFAE77706A91FC2D132AD8A8D17C45011C9714AD3`
   - Modern `3043D73A8D2C89D7369635CEF417B3940D22319BBBFA3A8F8DE12B32560002E4`
3. **`PackageContents.xml`:** `5E7ED47D1DA84D5C1EA8F8DC832112985C5738A452DD941CBD9CC959264022C2`, `AppVersion="3.0.90.12"`.
4. **Manifest** `C:\CE_WORK\scratch\trust_install\b14civ10_manifest.txt`, 832 rows, SHA-256 `D0B3F1A97B88021F05387C58846554F179B0C2B1C94910F4F7D1CA8B936F3FC4`.
5. **Stamp check:** CE_SHARED and CE.AI.Core x3 have 0 bytes different outside the stamp zones. The installed bytes were put in, and CE_SHARED is identical to Manager x3. The natives are the installed bytes.
6. **Against batch 9 (`b14civ9`, live):** 7 files differ, 0 added, 0 removed: CE_CVL_SUITE.dll and .pdb x3, and PackageContents.xml.

### 6. Turning the switch on for ONE scratch session

As batch 9, section 6 (folder `C:\CE_WORK\robot\b14i_switch`, `"newPipeOnePage": true` in the COPY's `"trust"` group, the log line "Settings initialized from: …" must show the copy, Tim's own settings hashed before and after).

### 7. ONE robot and Codex list for batch 10 (scratch copies)

1. **First start, switches OFF (as shipped):**
   - The log reads "CE_CVL_SUITE v3.0.90.12 Started".
   - Run the BUG-1456 smoke list once.
   - **CD:** opens today's New Pipe window, unchanged. Draw one pipe P to P; one U takes it back.
2. **Switch session with `newPipeOnePage` ON:**
   - **Opens:** CD, pick a route from one pit to another. The one-page window opens with its title bar active (not grey), with nothing clicked.
   - **Esc, nothing clicked:** press Esc once, straight after it opens. The page closes, the command line says "[CE] CD command cancelled.", and nothing is drawn.
   - **Esc in a level box:** run CD again, click in the Start level box, press Esc once. Same result.
   - **Esc on a size button:** run CD again, click a size button, press Esc once. Same result; the size pressed is not drawn.
   - **Enter:** run CD again, nothing clicked, press Enter once. The pipe is drawn as Draw pipe draws it, then today's next-pipe prompt shows; Esc there stops CD. One U takes the pipe, its label and arrow back.
   - **More…:** opens the same window CD opens with the switch off, at the same size, with its level boxes in sight.
     - Cancel there comes back to the page, answers kept.
     - Esc on the page then closes it.
     - Draw there draws the pipe.
   - **Save and reopen (not yet seen in NP16):** draw a pipe, save once without the command-line suggestion box showing, close and reopen the copy. The pipe, its label and its record row are still there.
   - **Starting size (optional):** in a drawing whose folder has no pipe yet, the page starts at 100. In `C:\Lisp Files\_TEST_COPIES_20260923` it starts at 225, that job's last pipe.
3. **Batch 9's other items carry over unchanged** (section BATCH 9, item 7: the Pit Schedule grey count, the Edit Pit More… button, Q11 on the fixture), for any not yet passed.
4. **Then close AutoCAD and restart without the variable.**

### 8. Install and put back

1. **Install (on batch 9):** `C:\CE_WORK\scratch\trust_install\install_batch14j.ps1`. NOT RUN.
   - **What it checks:** it refuses unless live Civil reads `3.0.90.11+249b9f8d` with all three sets. It also checks the candidate against `b14civ10_manifest.txt` and CE_SHARED against the live Manager.
   - **What it does:** keeps `CE_CVL_SUITE_PRE_249b9f8d_<time>.backup`, then reads every file back. It checks 3.0.90.12, CE_SHARED and the settings. Log: `install_batch14j.log`.
   - **`-CheckOnly`:** changes nothing. Run here: at 18:33: "CHECKS PASSED: nothing was renamed, copied or changed". Live reads 3.0.90.11+249b9f8d with all three sets; the candidate against its manifest is 832 rows, bad 0, extra 0; the candidate CE_SHARED is identical to the live Manager x3; 4 settings files were read.
2. **Put back:** `restore_batch14j.ps1`, back to 3.0.90.11, checked against `b14civ9_manifest.txt`. NOT RUN.
   - **`-CheckOnly`** was run here at 18:29 against today's live batch 9: "PUT-BACK VERIFIED: Civil equals the 3.0.90.11 payload file for file" (832, bad 0, extra 0; CE_SHARED identical x3; settings unchanged).
   - **Further back:** `restore_batch14i.ps1` (to 3.0.90.10).

### 9. Stop rules

As section 5 at the top. If a pass fails, batch 10 is put back with `restore_batch14j.ps1`, and batch 9 stays.
