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
