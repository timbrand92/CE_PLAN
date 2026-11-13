# Batch install on Tim's PC, 14 Nov 2026: the runbook (PREPARED, NOT INSTALLED)

**Owner: lane trust-acad-evidence (one owner, nobody else installs).** Controller: chat CE_ACAD / trust plan / plan / 01. Pattern: `INSTALL_TRIAL_13NOV.md`.

**The install waits for two things, both written here before anything is touched:** (1) the second review of the three heads saying **BATCH-READY** (a head marked NOT YET drops out of the batch and its bundle is not installed); (2) **Tim's own yes to this list**, asked by the controller ("One batch, ask me once", Tim 14 Nov 00:28). Outside his hours only.

## 1. What goes on, and what does not

1. **Civil 3.0.90.3** = what is on his PC now (3.0.90.2, build commit `5c89ce30` = 3.0.90 + PR 2073 + PR 2083) **plus PR 2092** (CDRUNSOLVE at a split, head `d686e787`) **plus PR 2099** (CDLPD takes only a CE pipe, head `9c3f088e`). Local build branch `batch-14nov-civil` (never pushed), build commit `11c0093c`. Product files changed against 3.0.90.2: four (`LpdCommand.cs`, `LpdService.cs`, `RunSolveCommand.cs`, `ProposalApplyService.PlanBuilders.cs`); no native, shared, Manager or Structural file. The merge of 2092 met test-tooling conflicts only (proof project, its command list, its README, REGRESSION_LOG), resolved by keeping both sides.
2. **Structural 1.0.126.1** = what is on his PC now (1.0.126, `8de95c34`) **plus PR 2094** (CLEAN and FASTSAVE never save a never-saved drawing or a template, head `226edc6c`). Local build branch `batch-14nov-struc` (never pushed), build commit `3c805169`. Product files changed: `CleanPipelineService.cs`, `DrawingAutoSaveService.cs`, `CeSheetsSyncService.cs`, the new `DrawingSaveGuard.cs`, and the version lines. No native file (the INSTALLED native module is reused, as for 1.0.126).
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
2. **CDRUNSOLVE (2092):** the P10 split layout (P10 to P9 drawn first, P10 to P4 second) on a copy of the standard drawing: (a) with the stored LPD, Enter at the end-pit question: the new question "2 pipes leave pit P10. Which way does the run go? A = to P9, B = to P4"; answer B: the run reads P10 -> P4 and on; (b) the same with the LPD removed; (c) Esc at the question: "Cancelled - drawing unchanged.", record unchanged; (d) a picked end pit on the P4 leg: follows it without asking (the typed pick on 900 mm pits was refused on 14 Nov 00:16; if it is refused again, write COULD NOT TEST and leave it to Codex). The robot answers by chaining the answers in one typed line (its `answer` verb cannot see CDRUNSOLVE's questions).
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

(see the log below)

## 8. Log (PC clock, newest last)

- 2026-11-14 01:25: runbook written by trust-acad-evidence on the controller's order of about 01:12. Branches staged (local only): Civil `11c0093c`, Structural `3c805169`. Payload builds running. Nothing installed.
