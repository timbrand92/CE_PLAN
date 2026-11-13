# Trial install on Tim's PC, Fri 13 Nov 2026: the result (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 15:20 PC clock. **Step-by-step log:** `INSTALL_TRIAL_13NOV.md` section 8. **Status:** robot evidence only, seen in real AutoCAD on copies; not Codex-looked; not Tim-accepted.

# FOR TIM

1. **What is on your PC now:** Civil **3.0.90.2**: today's 3.0.90 plus only the two job mix-up fixes (pull requests 2073 and 2083). Manager 1.1.89 and Structural 1.0.126 are exactly as this morning, file for file. Your settings files are byte-identical to this morning.
2. **What it fixes:** CE could write the pits and pipes of one job into another job's drawing (open job A, run a CE tool, open job B, run Help or CD Settings: job B's record became job A's). On 3.0.90 I saw that happen seven ways this morning. On the fixed version every one of those seven ways was run twice, in two separate AutoCAD starts, and job B kept its own record every time.
3. **What else was checked and works as before:** Check Current Drawing, the Pit Schedule window, Edit (Esc), the New Pit window, CDSYNC, drawing a pipe with CD, placing a pit, Undo, two copies worked in turn, and saving then reopening (the new pit and the new pipe are still there). No error, no file failing to load.
4. **The one difference you may notice:** Help and CD Settings no longer quietly refresh the drawing's stored file name and format number. The next real CE edit (placing a pit, drawing a pipe) does it instead. Nothing you see on the drawing changes.
5. **How to tell which version you have:** the AutoCAD status bar still shows "v3.0.90" (it shows three numbers only). The CE log line at start-up reads "CE_CVL_SUITE v3.0.90.2 Started".
6. **To put back 3.0.90 exactly as it was this morning (one action):** with AutoCAD closed, run `C:\CE_WORK\scratch\trust_install\restore_stateB.ps1`. It renames today's bundle aside and renames `CE_CVL_SUITE_PRE_cf059dcf_20261113-123246.backup` back to `CE_CVL_SUITE.bundle` in `%APPDATA%\Autodesk\ApplicationPlugins`, then checks every file against this morning's backup.
7. **Not tested:** erasing a pit (my typed erase never reached AutoCAD); a change being refused because CE held another job's record (with these fixes in place I could not make CE hold another job's record any more; it is proven only in the core console); AutoCAD 2022 to 2024 and 2025/2026 (only AutoCAD 2027 was started); a real client drawing (never touched).
8. **Found on the way, for whoever makes the next release:** Visual Studio updated itself on Thursday night and removed the compiler version two small native parts of Civil ask for, so the normal install-package build now stops part-way. Details in `FINDING_NATIVE_TOOLSET_13NOV.md`. It did not affect what is installed.

# DETAIL

1. **Builds.** Trial A step one: commit `0f6caa40` = `9573b97a` (3.0.90 `cf059dcf` + PR 2073 `1a28c3b3`) + version 3.0.90.1. Step two (installed now): commit `5c89ce30` = `9714ffdd` (adds PR 2083 `8a6decef`) + version 3.0.90.2. Both on local build branches only (`trial-a-build-13nov`, `trial-a2-build-13nov`), never pushed; the shared branch is the foundations lane's `claude/trust-trial-a-bug1456`. Review `reviews\trial-a-branch-check.md`: YES. Built with `Installer\build_installer.ps1` in a staging worktree (since removed), with a one-line toolset override that was never committed and is now deleted.
2. **What differs from this morning's Civil bundle:** 7 of 832 files: `CE_CVL_SUITE.dll` and `.pdb` in Legacy, Net8 and Modern, and `PackageContents.xml` (AppVersion 3.0.90.2). The natives, `CE_SHARED.dll` and `CE.AI.Core.dll` are this morning's bytes (the newly built shared files differed only in their version stamp, 0 bytes outside it, so the installed ones were kept and Civil and Manager still share one identical CE_SHARED).
3. **Installed Civil DLLs (3.0.90.2+5c89ce30):** Legacy `FF0D76077C1F...`, Net8 `C40F7B53F3DB...`, Modern `183E7DC88AEC...`. Full end-state list: `C:\CE_WORK\scratch\trust_install\END_STATE_13NOV_hashes.txt` (2,922 files): Civil = the 3.0.90.2 build manifest (832, bad 0); Manager 75, Structural 2,007 and the ProgramData Manager copy 8 = `BEFORE_13NOV` (bad 0).
4. **Results, seen sequences** (second job's record before and after; pass = unchanged): 3.0.90 baseline 11:38: 7 FAIL, 3 PASS. 3.0.90.1 pass 1 and pass 2: 10/10 and 10/10. 3.0.90.2 pass 1 and pass 2: 10/10 and 10/10. 2083's cases on 3.0.90.2: one-drawing work PASS, two copies in turn PASS (after fixing my own script), PIT placed + saved + reopened PASS.
5. **CE log:** in every trial start, the right version line, no "[BUG-1456]" refusal line, no ERROR, no load failure or version mismatch. End check 15:12: AutoCAD started on a copy, "CE_CVL_SUITE v3.0.90.2 Started", "Standalone CE Civil ribbon built: CE (9 panels)", the CE, Manager and Structural menu groups loaded, Help opened and closed, AutoCAD closed.
6. **Backups kept:** `C:\CE_WORK\scratch\trust_install\BEFORE_13NOV\` (2,922 files, rechecked by hash at 15:11, bad 0); in ApplicationPlugins `CE_CVL_SUITE_PRE_cf059dcf_20261113-123246.backup` (3.0.90) and `CE_CVL_SUITE_PRE_0f6caa40_20261113-134421.backup` (3.0.90.1); candidates `C:\ce_rc_scratch\t13a` (3.0.90.1) and `t13b` (3.0.90.2).
7. **Not done today (controller, 13:44):** Trials B, C and D. Pull requests 2089, 2090 and 2100 are not on the PC.

## Added by the controller, Fri 13 Nov 16:20: one related route is still open on 3.0.90.2

1. **By reading the code only, NOT seen in AutoCAD:** with two jobs open, if CDJOINT is the first CE tool run in the second job, the second job's slab and joint list can be put into the first job's CE data, and the first job's next CE save writes it in. Slabs and joints only; pits and pipes are not touched. The two changes on Tim's PC do not stop it.
2. **A fix is drafted** (pull request 2100), not reviewed, not installed.
3. **Cautious habit until it is tested:** with two jobs open in one AutoCAD, do not make CDJOINT the first CE tool you run in the second job.
4. **Also still open, but not reachable on Tim's PC:** the CE Assistant pipe-size route (that feature is switched off on his PC; closed in draft pull request 2089, which needs a fix first).
5. **Owed:** one robot run of the CDJOINT sequence on 3.0.90.2 as it stands.

## Correction by the controller, Fri 13 Nov 17:47: the CDJOINT route above is NOT real as described

1. **An independent review read the installed code line and found the fault is not there:** CDJOINT's very first step attaches CE's data to the drawing in front, before it asks anything. So running CDJOINT first in a second job does NOT put that job's slabs into the first job. The controller checked this in the code itself (CDJOINT's first step, and what that step calls).
2. **The cautious habit in item 3 above is withdrawn.** It is not needed.
3. **One narrow case is left, not verified:** starting CDJOINT in one job, switching to another job part-way through its questions, running a CE tool there, then coming back to finish. It is not known whether AutoCAD even allows this. The drafted change (pull request 2100) would cover it.
4. **Pull request 2100:** safe, but FIX FIRST (its description of the fault is wrong; four fixes listed in `areas\trust-run\reviews\pr-2100-cdjoint-route.md`).
