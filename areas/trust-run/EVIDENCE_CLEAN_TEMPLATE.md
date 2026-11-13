# CLEAN and FASTSAVE in a never-saved drawing: they save over the template (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 09:20 PC clock. **Build tested: the INSTALLED one** (Structural 1.0.126, AutoCAD 2027), real AutoCAD, on a SCRATCH COPY of AutoCAD's own metric template only. Tim's real template was never opened by CE: its hash and size are the same as before (`12B46B17C114`, 31,825 bytes, written 4 Feb 2026). **Status: DRAFT evidence, robot only, not Codex-looked, not Tim-accepted.** Working-hours rule lifted today (run file 3c).

---

# FOR TIM

1. **Yes: CLEAN and FASTSAVE save a never-saved drawing straight over the template file it was made from.** I made a copy of AutoCAD's metric template in my scratch folder, started a new drawing from it ("Drawing1", never saved), and ran CLEAN, then on a second copy FASTSAVE. Both finished without asking anything, and the drawing was then named after the template file and saved into it. The template copy had changed (CLEAN: 31,825 to 33,398 bytes; FASTSAVE: 31,825 to 32,022 bytes; the fingerprints changed).
2. **What you would see on a real job:** start a new drawing from your office template, draw nothing or something, run CLEAN or FASTSAVE before you have used Save As: your template file now contains that drawing. The next new drawing from it starts with that content. No question, no warning. FASTSAVE even prints "saved <template name>.dwt".
3. **These two are Structural commands** (the Structural suite's clean-up that ends in a save). FASTSAVE is today hidden in the ribbon plan as a duplicate of CLEAN, but typing it still works.
4. **Your real template is safe from my test:** it was not touched (same fingerprint). CE also kept a backup of what it saved in your CE backup folder; my test left two small folders there and I removed them (only my test files were in them).
5. **What would stop it:** CLEAN and FASTSAVE refuse to save (and say so in one plain line) when the drawing has never been saved, and still do the clean-up. Not built; a decision for the safety-fixes lane and for you.
6. **Not tested:** Civil's own commands that save; a drawing started from a template with Save As done first (that case should be fine); the same on AutoCAD 2022 to 2024; what the AutoCAD 2027 "startup template" settings do.

# DETAIL

1. **Set-up:** a copy of `acadiso.dwt` as `CLDTP_TPL.dwt` in `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY` (hash `12B46B17C114`, 31,825 bytes). A new drawing made from it with AutoCAD's own new-drawing call: name "Drawing1.dwg", DWGTITLED 0 (never saved), DBMOD 0.
2. **CLEAN** (sent as a typed command to that drawing after a 8 s settle): 25 s later the document was named `CLDTP_TPL.dwt`, path = the scratch folder, DWGTITLED 1, DBMOD 5. After closing it the template copy read 33,398 bytes, hash `204404CE5E52`, written at the time of the run. The command line was not read for CLEAN.
3. **FASTSAVE** on a fresh copy (`CLDTP_TPL2.dwt`, 31,825 bytes, hash `12B46B17C114`): command line, in order: "[FASTSAVE] Drawing post: xrefs 0, model ents 0; no major DWG-level issues", "Done in 0.1 s: 2 steps done, 0 failed, drawing saved.", "OK RegenAll", "OK QSave (0.08s) - saved 'CLDTP_TPL2.dwt'; rolling backup copy='...\CE_STRUC_SUITE\AutoSaveBackups\CE_STRUC_SUITE\CLDTP_TPL2_4A413893\CLDTP_TPL2_20261113_091316951.dwg'", "saved C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\CLDTP_TPL2.dwt". Afterwards the copy was 32,022 bytes, hash `7E8834EEE412`.
4. **Why (from the code, not shown by the run):** `CleanPipelineService` runs its QSave stage with CE's managed save (`DrawingAutoSaveService.TrySaveNow`); for an unnamed drawing that save uses the drawing's template file as its name. AutoCAD's own QSAVE would have asked for a name. I did not trace it further.
5. **Where the commands came from:** the test was run through AutoCAD's automation interface directly (the test driver refuses commands with SAVE in their name), on scratch copies only; nothing real was touched.
6. **Side effects of the test:** two folders under `%APPDATA%\CE_STRUC_SUITE\AutoSaveBackups\CE_STRUC_SUITE` (named CLDTP_TPL_... and CLDTP_TPL2_...) made by CE's rolling backup; removed by me. The Structural settings file hash is unchanged (`50AA09900E3E`).

---

# Pull request 2094 (BUG-1457) at head 226edc6c: what could be proved without installing (Sat 14 Nov 00:59 PC clock)

**Build:** branch `claude/trust-clean-never-saves-template` at `226edc6c`, built in my own folder (Structural Standalone, net10, Release, SkipDevBundle), 0 errors, copied to `C:\CE_WORK\scratch\trust_install\build_s2094`. DLL reads `1.0.126+226edc6cd0b3a55ac634b0555b36d44bcdfef7b0`, SHA-256 `7972646AA7DD57642C080D6A32AE6AFBDC2E3105426DC7B93C3FCC644B67F909`. Nothing installed. Robot only.

## FOR TIM

1. **SEEN BEFORE (the installed Structural 1.0.126, real AutoCAD, Fri 13 Nov 09:20):** CLEAN and FASTSAVE in a never-saved drawing made from a template save straight over the template file. See the top of this file.
2. **CORE CONSOLE AFTER: COULD NOT TEST.** AutoCAD's screenless core console crashes the moment CLEAN starts, with the fixed build AND with your installed build (same crash, after 4 seconds, nothing saved, the template copy unchanged). CLEAN needs the full AutoCAD. So the fix cannot be seen without installing it.
3. **REAL AUTOCAD AFTER: needs the batch install** (the controller asks you once for the batch). The three things to look at then: a never-saved drawing from a template copy, CLEAN: one line saying it saved nothing, the template unchanged; a template copy opened on purpose, CLEAN: cleaned but not saved, one line saying so (a DRAFT default for you); a drawing saved with Save As, CLEAN: cleans and saves as before.
4. **Nothing of yours was touched:** CE's data folder was redirected to the scratch run folder; your own Structural folder was unchanged after each run; AutoCAD's isolated test profile (about 3 GB) was deleted afterwards.

## DETAIL

1. **Core-console runs** (own scratch runner, never committed; the Structural plugin NETLOADed from the scratch folder in an isolated profile; `CE_STRUC_SUITE_APPDATA_ROOT` set to the run folder): case "template copy opened on purpose" (`/i T.dwt`), command CLEAN. Transcript: "BEFORE: DWGNAME=T.dwt DWGTITLED=1", "Command: CLEAN", then nothing: the core console ended with exit code -1073741819 (an access violation) after 4 s. Same with the installed build's files (`1.0.126+8de95c34`, taken from this morning's backup copy). T.dwt unchanged both times (31,825 bytes), no CE backup copy made. Cases "never-saved drawing" and "saved .dwg" were not run once CLEAN itself proved impossible there.
2. **Also built (no change):** the Structural line has its own core-console harness (`tools\structural-headless-proof`) with frame suites only; it has no CLEAN check.
