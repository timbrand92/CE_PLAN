# Batch install on Tim's PC, Sat 14 Nov 2026: the result (lane trust-acad-evidence)

**Written:** Sat 14 Nov 2026, 15:55 PC clock. **Step log:** `INSTALL_BATCH_14NOV.md` section 8. **Status:** robot evidence only, seen in real AutoCAD 2027 on scratch copies; not Codex-looked; not Tim-accepted. No bug is marked FIXED.

# FOR TIM

1. **What is on your PC now:** Civil **3.0.90.3** and Structural **1.0.126.1**. Manager 1.1.89 is exactly as before, file for file. Your settings files are byte-identical to this morning.
2. **What the three fixes do, and what was seen:**
   1. **CDRUNSOLVE at a pit with two pipes leaving it: SEEN WORKING.** It now asks "2 pipes leave pit P10. Which way does the run go? A = to P9 ..., B = to P4 ...". A went down P9's leg; B went down P4, P3, P2, P1, C1 to the council stub; Enter stopped with "Nothing to solve ... no way was chosen"; Esc said "Cancelled - drawing unchanged." Same with and without an LPD. CE's record was unchanged every time. (On 3.0.90 it silently took the first pipe.)
   2. **CLEAN and FASTSAVE on a never-saved drawing from a template: SEEN WORKING.** Both refused with "This drawing has never been saved, so CE did not run ... and saved nothing. Use Save As ..." and the template copy was unchanged (same size, date and fingerprint). A template opened on purpose: CLEAN cleaned and did not save; FASTSAVE did not save and cleaned nothing; both said so; the template copy unchanged. A normal saved drawing: CLEAN cleaned and saved as before. (On 1.0.126 both saved over the template.)
   3. **CDLPD taking only a CE pipe: NOT SEEN.** The robot pressed "Continue in drawing" (your word), but it could not then click the line: its click tool only clicks when AutoCAD's command line shows a pick question, and CDLPD's question does not show there until it is answered. A person or Codex must do this one: plain line on layer 0 clicked as the pipe should give "That line is not a CE pipe ... Nothing was changed"; a CE pipe should set the LPD as before.
3. **Nothing that worked before is disturbed:** the twenty job mix-up checks passed again (ten, twice, in two AutoCAD starts); Check Current Drawing, the Pit Schedule window, Edit, the New Pit window, CDSYNC, drawing a pipe, saving and reopening all behaved as on Friday's build. No error, no file failing to load, in the Civil or Structural log.
4. **To put back Friday's state (Civil 3.0.90.2, Structural 1.0.126), one action:** with AutoCAD closed, run `C:\CE_WORK\scratch\trust_install\restore_batch14.ps1`. It renames today's bundles aside, puts back `CE_CVL_SUITE_PRE_5c89ce30_20261114-141346.backup` and `CE_STRUC_SUITE_PRE_8de95c34_20261114-141346.backup`, and checks every file.
5. **Two choices still yours (DRAFT defaults are built):** the wording of the A/B question at a split; whether a template opened on purpose is cleaned and left unsaved (built that way) or refused.
6. **Not tested:** CDLPD (above); AutoCAD 2022 to 2026 (only 2027 was started); an older polyline on a CE pipe layer for CDLPD; CDRUNSOLVE with pipes that have design flows (here every pipe had none, so after choosing B it said "could not size these pipes because none of them has a design flow yet" and changed nothing: the route was seen, a solve writing levels was not).

# DETAIL

1. **Installed (read back 14:15 and again 15:52):** Civil `3.0.90.3+11c0093cb7a2afeffa7eddf961f383b6f61240ce` in Legacy, Net8 and Modern (SHA-256 Legacy `E074A231D905...`, Net8 `A1BD5E6D1992...`, Modern `83FD887E7130...`), 832 files = its build manifest, bad 0. Structural `1.0.126.1+d4edbc19c20f1c94a1a6a611271b4737cea988c9` (Legacy `B28198F19FE9...`, Net8 `618E2D7D2A31...`, Modern `113C8E975A70...`), 2,007 files = its build manifest, bad 0. Manager 1.1.89+cf059dcf, its 75 files and the ProgramData copy's 8 = BEFORE_14NOV, bad 0. Four settings files identical; manager-switches.json still absent.
2. **What went in:** Civil = 3.0.90.2 (5c89ce30) + PR 2092 (d686e787) + PR 2099 (9c3f088e); Structural = 1.0.126 (8de95c34) + PR 2094 (2205dfde). All three BATCH-READY in `reviews\batch-14nov-second-review.md`. Tim's word, 14 Nov about 14:10: "you do what you need to, to keep things moving" (the controller's reading is at the end of the runbook).
3. **Seen, item by item:**
   1. First start 14:15: "CE_CVL_SUITE v3.0.90.3 Started", Civil ribbon built (9 panels), CE Civil, Manager and Structural menu groups loaded, Structural initialised, CDHELP opened and closed: **SEEN PASS**.
   2. BUG-1456 mix-up sequences S1 x2, S2 x2, S3 x2, R3, C3, R5, F: pass 1 10/10 (14:17 to 14:49), pass 2 10/10 (14:50 to 15:12): **SEEN PASS** (20 of 20). Transcript `C:\CE_WORK\scratch\trust_install\batch_seq.out`.
   3. Smoke (CDCHECKCURRENT, PITSCHEDULE open/close, CDHELP, CDS, CDEDIT Esc, PIT window, CDSYNC, CD pipe, save-copy, reopen): record sizes and counts identical to 3.0.90.2; pipe 50 in the record after reopening: **SEEN PASS**. Same transcript.
   4. CDRUNSOLVE split, with the LPD and without it (two copies): A, B, Enter **SEEN PASS** (15:16 to 15:24); Esc **SEEN PASS** on a third copy (15:37: "*Cancel*", "[CDRUNSOLVE] Cancelled - drawing unchanged.", record unchanged). Transcripts `batch_tools.out` and `batch_tools2.out`. My first Esc attempt was not a test: the driver adds its own Enter after typed text, so an Enter reached the question first; redone without it.
   5. CDLPD: **NOT RUN (robot cannot click the line).** The Continue button was pressed by UI Automation on my own AutoCAD only (scratch copy `CLDTP_LB2.dwg`), twice; the driver's `answer` and `click-canvas` both refused because the pick question is not in the command-line log yet ("the last finished command-line line is not about a point or objects (last line: 'Command: CDLPD')"). Nothing was clicked; the stored LPD was unchanged both times.
   6. CLEAN and FASTSAVE (copies of AutoCAD's own metric template, 31,825 bytes, SHA-256 `12B46B17C114D235...`, never the office template): never-saved CLEAN, never-saved FASTSAVE, template opened CLEAN, template opened FASTSAVE: template copy UNCHANGED each time; saved .dwg copy: CLEAN saved it: **SEEN PASS** (5 of 5), lines quoted in `batch_tools2.out`. The one CE backup folder the test made (`CLDTP_TPLB_dwg_...`) was removed.
4. **Logs over the whole run (14:17 to 15:48):** Civil 2,685 lines: four "v3.0.90.3 Started", no "[BUG-1456]" line, no ERROR, no load failure or mismatch. Structural 434 lines: no ERROR, FATAL or exception.
5. **AutoCAD:** every AutoCAD was started by me. One (15:13) was ended by me after my script left CDLPD's window open and the driver no longer owned it (scratch copies only, settings checked unchanged); not a crash. The last one was closed at 15:48 by the driver's quit (settings same). No acad.exe is running.
6. **Cleanup:** staging worktrees, drive letter R: and the toolset override removed; local build branches `batch-14nov-civil` and `batch-14nov-struc` kept, never pushed; candidates `C:\ce_rc_scratch\b14civ` and `b14struc` kept; backups `BEFORE_14NOV` and the two `_PRE_..._20261114-141346.backup` folders kept.

---

# CDLPD, Codex look (Sat 14 Nov 16:15 to 16:30 PC clock; Tim: "get codex to do it")

**FOR TIM**

1. **CDLPD now refuses a plain line as the outlet pipe: SEEN by Codex.** A plain polyline on layer 0 clicked as the pipe gave "[CE] That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. Run CDLPD again and pick a CE pipe, a pit or a block, or choose to pick a point." No marker, CE's stored outlet unchanged (screenshot checked by me).
2. **A real CE pipe is still taken, and it survives save and reopen: SEEN by Codex.** Clicking pipe P2 to P1 set the outlet on it ("LPD" note at the P2 end on the screenshot); after save and reopen CE's stored outlet still names that pipe.
3. **Also seen:** a plain LINE (not a polyline) is refused by AutoCAD's own pick filter with "Select a pipe, pit, or any block (kerb outlet, connection point, etc.)." and the question stays open (Esc ends it; nothing changed). An older-style polyline on the CE pipe layer IS accepted as the outlet pipe, as designed. Esc at the pick changes nothing.
4. **Acceptance:** this is a Codex PASS only. The robot could not click the line (it pressed Continue but its click tools refuse at that question), so there is no robot PASS beside it: by RULES 13.3 BUG-1298 stays OPEN, not Codex-accepted.

**DETAIL**

1. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_LPD14_L2_20261114_1618.md`, evidence `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\LPD14_L2_20261114_1618\` (37 screenshots, driver call log). Build read by Codex at start and end: Civil 3.0.90.3+11c0093c, Manager 1.1.89, Structural 1.0.126.1. Settings unchanged; AutoCAD closed; lock released.
2. **Codex's two FAIL lines (L-07, L-08) are my brief's mistake, not the plugin's:** the brief told Codex to expect the outlet to name handle 10F608, read by a point pick (nentselp) on the pipe; that object is not a CE pipe. CE's own record (my read of the same drawing earlier today, `reads\BL_0.record.txt`) gives pipe P2 to P1 as id and entity handle **109835**, which is exactly what CDLPD stored (R1 "PipeHandle":"109835") before and after save and reopen. Desk verdict: L-07 PASS, L-08 PASS.
3. Step results as checked by me: L-00 PASS, L-01 PASS, L-02 PASS (Continue in drawing pressed by Codex), L-03 PASS (screenshot LPD14-17 shows the refusal line), L-04 DIFFERENT (plain LINE: AutoCAD's pick filter wording, prompt stays; unchanged by the fix), L-05 PASS, L-06 SEEN (pipe-layer polyline accepted), L-07 PASS, L-08 PASS (screenshot LPD14-34 shows the LPD note at P2).
4. The first attempt (run L1, 15:57 to 16:09) was blocked by my brief: it sent a bare CDLPD without -Force and the driver refused it; Codex correctly did not add -Force on its own. That AutoCAD was closed by the driver's quit under the look's lock (settings unchanged).

---

# Two jobs mixed up (BUG-1456), Codex look (Sat 14 Nov 16:34 to 17:05 PC clock, runs M2 and M3)

**FOR TIM**

1. **Codex saw no mixing.** In drawing B (the second test job), Help first, CD Settings, and Help again after switching tabs to drawing A and back: every reading of CE's record in B still named B's own file and B's own first pit; drawing A kept its own record. Two separate runs, same answer.
2. **My own check agrees:** I re-read drawing B as Codex saved it at the end: 2 pits, 46 pipes, its own file name, 37,921 characters, exactly as before the test.
3. **But Codex did not mark it PASS:** its four key steps are NOT TESTED (EVIDENCE) because my brief asked for a screenshot of each reading's reply, and Codex cannot photograph its own command replies (it runs them out of sight; the replies are in its log). So by the rule in force BUG-1456 is NOT Codex-accepted: robot PASS (20 of 20) plus Codex "seen in the log, not screenshotted". The controller decides whether a logged driver reading counts as evidence for readings.

**DETAIL**

1. Reports `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_MIX14_M2_20261114_1635.md` (PASS 3, DIFFERENT 1, NOT TESTED 4) and `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_MIX14_M3_20261114_1651.md` (PASS 1, SEEN 3, NOT TESTED 4); evidence folders `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\MIX14_M2_20261114_1635\` and `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\MIX14_M3_20261114_1651\`. No FAIL in either.
2. Run M3's driver log: 12 record readings, 8 name `DWG-A_PASS8.dwg` (drawing B, at the start and after M-03 Help, M-04 Settings, M-05 tab switch then Help) and 4 name `CLDTP_MIX14_A.dwg` (drawing A, at M-01 and M-06); none of B's readings names A's file.
3. Desk read of B's saved copy (my own AutoCAD, 17:00): DBMOD 0, 1,285 objects, record 37,921 characters, path `DWG-A_PASS8.dwg`, 2 pits, 46 pipes, version 2.2.
4. The first attempt (run M1, 16:32) did not start: my launcher text still said "one test copy" and "no Settings window"; fixed.

---

# CLEAN and FASTSAVE (BUG-1457), Codex look (Sat 14 Nov 17:05 to 17:24 PC clock, runs C1 and C2)

**FOR TIM**

1. **The never-saved cases could NOT be reached by Codex.** The driver refuses NEW (it is on its never-type list) and refuses to open a .dwt; typed by hand, NEW brings up AutoCAD's suggestion list, and Codex's rules forbid pressing Enter while that list shows. The other way in (Ctrl+N) can start a drawing from YOUR office template, which this test must never touch, so I did not ask for it. Result: NOT TESTED by Codex; the robot's SEEN PASS (15:45) stands alone, so BUG-1457 is NOT Codex-accepted.
2. **A normal saved drawing: SEEN by Codex, twice.** CLEAN on a saved .dwg copy cleaned it and saved it as before ("6 steps done, 0 failed, drawing saved"; the file changed).
3. **Nothing of yours touched:** the three template copies and your settings files were unchanged at the end of both runs.

**DETAIL**

1. Reports `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_CLN14_C1_20261114_1707.md` (C-01, C-02 BLOCKED: driver refused NEW; C-03 BLOCKED: "only .dwg files can be opened"; C-04 PASS) and `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_CLN14_C2_20261114_1716.md` (C-01, C-02 BLOCKED: suggestion list after the hand-typed NEW; C-03 dropped by the desk; C-04 PASS, D 31,825 to 33,371 bytes). Evidence `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\CLN14_C1_...` and `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\CLN14_C2_...`. No FAIL.
2. To let Codex see the never-saved case, one of these would be needed: the driver allowed to start a NEW drawing from a named template copy, or AutoCAD's suggestion list switched off for the test (a setting change, not allowed). For the controller and Tim.

---

# CDRUNSOLVE at a split (BUG-1355), Codex look (Sat 14 Nov 17:25 to 17:43 PC clock, runs S1 and S2)

**FOR TIM**

1. **Codex saw the new question and every answer behave as designed:** "2 pipes leave pit P10. Which way does the run go? A = to P9, 225 mm, B = to P4, 225 mm. Enter stops the run at P10; Esc cancels and changes nothing." (screenshot checked by me); A went P10 to P9; B went P10, P4, P3, P2, P1, C1, STUB; Enter: "no way was chosen"; Esc: "Cancelled - drawing unchanged."
2. **But not a Codex PASS:** Codex's screenshot tool saved repeated, stale images for the A, B and Enter results, so Codex marked those NOT TESTED (EVIDENCE); the Esc step it marked BLOCKED because my brief described one question more than CDRUNSOLVE actually asks. Codex also noted "the record differs from START": that is my brief's mistake (START was read before the two test pipes were drawn), not a fault. So BUG-1355 is NOT Codex-accepted; the robot's SEEN PASS (15:16 to 15:37) stands alone.
3. **As agreed with the controller:** a Codex PASS here could only ever accept the route (BUG-1355), not the tool CDRUNSOLVE, which stays not accepted because on this build it cannot write levels (every pit's design flow is 0).

**DETAIL**

1. Reports `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSV14_S1_20261114_1726.md` (blocked at CD: my brief lacked the Enter for "Select point 3 (or Enter for straight pipe)") and `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSV14_S2_20261114_1734.md` (S-00 SEEN, S-01 SEEN: both pipes drawn, objects 1,054 to 1,062; S-02 to S-04 NOT TESTED; S-05 BLOCKED but "Cancelled - drawing unchanged." seen). Screenshot hashes in `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSV14_S2_20261114_1734\exports\savercheck.txt` show the repeated images. No FAIL.

---

# CDRENUMBER (BUG-968), Codex look and robot (Sat 14 Nov 17:44 to 17:59 PC clock)

**FOR TIM**

1. **ACCEPTED: BUG-968 is now "FIXED (Codex-accepted, Civil 3.0.90.3, 14 Nov 2026)" in the bug carpark.** With two pipes running opposite ways between pits P10 and P9, CDRENUMBER asked for the main outlet, listed "P9 -> P8, P10 -> P9", and on No said "Renumber cancelled - nothing changed." AutoCAD stayed open (it used to close itself here). Seen by Codex (screenshot) and by the robot (log), both on the build on your PC now.

**DETAIL**

1. Codex: run N1 (17:44) blocked when its hand-typed answer went into the drawing as a paste (my brief); run N2 (17:53) `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_REN14_N2_20261114_1753.md` PASS 3 of 3; screenshot `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\REN14_N2_20261114_1753\screenshots\REN14-06-save-no.png` checked by me (both arrows, the Apply question answered N, the cancel line, AutoCAD open); driver log "P9 -> P8, P10 -> P9; Renumber cancelled - nothing changed."
2. Robot (17:58, installed 3.0.90.3+11c0093c): the same steps; same AutoCAD process before and after; CE's record unchanged (604,424 characters, 11 pits, 51 pipes).

# Codex looks, the count (14 Nov, Codex weekly usage 0% to 4%, cap 30%)

1. **Accepted (robot PASS + Codex PASS on 3.0.90.3):** BUG-968 (CDRENUMBER).
2. **Codex saw it working, but not counted as a Codex PASS (evidence rule):** BUG-1456 mix-up (readings in the log, no screenshot of each reading), BUG-1355 CDRUNSOLVE route (stale screenshots), BUG-1298 CDLPD (Codex PASS, but no robot PASS: the robot cannot click the line).
3. **Not reached by Codex:** BUG-1457 never-saved CLEAN/FASTSAVE (NEW cannot be started by the driver or by hand); the saved-drawing case was seen.
4. **My brief mistakes, fixed as they showed:** a missing -Force (LPD L1), wrong scope lines (MIX M1), a wrong expected handle (LPD L2), a missing Enter after CD (RSV S1), a hand-typed answer (REN N1). None was a plugin fault. No Codex FAIL against the plugin in any run.

---

# Next batch candidate: 2092 at 382999f5 (core console only, Sat 14 Nov 18:05 to 18:14 PC clock; NOT installed)

**FOR TIM**

1. **What it adds:** CDRUNSOLVE reads the flow (Q) typed for each pipe in Edit Pipe, so a run can finally be sized and given levels (today every pit's flow is 0 and nothing can be solved). Reading Q per pipe is the controller's DRAFT default, not yet your answer.
2. **What the core console shows:** with each pipe's Q in CE's records, CE's solver now sizes each pipe for its own flow (never adding a flow twice) and proposes levels that say where each flow came from: **PASS**. The same check on today's installed line **FAILS** as expected (every flow 0, nothing proposed). The split question still works, and the two job mix-up checks still pass, when 382999f5 is put on top of what is on your PC now.
3. **NOT covered until a trial install (which needs your own yes for a new batch):** typing Q in Edit Pipe and CDRUNSOLVE picking it up in a real drawing; levels actually written on the pipes and pits; one Undo putting them back; a typed Q surviving save and reopen. Nothing was installed.

**DETAIL**

1. Branch `claude/trust04-b1355-runsolve-branch` at `382999f5`, built in my own folder (Civil net10 Release, SkipDevBundle, 0 errors), DLL `3.0.90+382999f5`, SHA-256 `06A398DD67B854D972F4167BE9CDC4545A3532CB41EAA55FAF145E20637FF8EC`. RUNSOLVE-FLOW-01 (`CEPROOFRUNFLOW`): PASS on 382999f5; FAIL on d686e787 ("the run inputs do not carry each pipe's Q (every pit 0 is the fault on 3.0.90.3) ... joining flow P4 0.0, P3 0.0, P2 0.0, P1 0.0"). RUNSOLVE-SPLIT-01: PASS on 382999f5. BUG-1456-CROSS-01/02 do not exist on that branch alone (it is cut from 3.0.90): RUN NOT STARTED there, as expected.
2. **The combination that a next batch would install:** today's batch commit `11c0093c` (3.0.90.3) + 382999f5, merged locally only (commit `1bc17a6a`, never pushed; REGRESSION_LOG kept both sides; product files changed against 3.0.90.3: `RunSolveCommand.cs` and `ProposalApplyService.PlanBuilders.cs`), DLL `3.0.90.3+1bc17a6a`, SHA-256 `C21BB3F54D746C04E33DF46C292F1D72AB3F2D42F94AA3A3BD8612C0AE8525D5`: RUNSOLVE-FLOW-01 PASS, RUNSOLVE-SPLIT-01 PASS, BUG-1456-CROSS-01 PASS, BUG-1456-CROSS-02 PASS.

# BATCH 2: Civil 3.0.90.4 (installed by the controller Sat 14 Nov 23:41; robot by trust-acad-evidence from 23:46 PC clock)

## FOR TIM (batch 2)

1. **What is on the PC:** Civil 3.0.90.4+dadac7e7 (yesterday's 3.0.90.3 plus CDRUNSOLVE reading each pipe's design flow, Q, typed in Pipe Edit). Structural and Manager unchanged.
2. **First start: SEEN PASS.** Civil log `C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`: "CE_CVL_SUITE v3.0.90.4 Started" (23:43:29 and 23:46:15); no "[BUG-1456]" line; no ERROR line.
3. **Two jobs mixed up (BUG-1456) smoke: SEEN PASS, 10 of 10** (23:46 to 00:25). The "nothing disturbed" readings (CDCHECKCURRENT, PITSCHEDULE, CDHELP, CDS, CDEDIT Esc, PIT window closed, CDSYNC, one CD pipe, save and reopen with 50 pipes) are the same size, byte for byte, as on batch 1. Transcript `C:\CE_WORK\scratch\trust_install\b2_seq.out`; readings `C:\CE_WORK\scratch\trustprobe\reads\b2_*.record.txt`. AutoCAD closed by the driver, the 4 settings files the same.
4. **CDLPD (BUG-1298), before-and-after record read for the Codex PASS (00:26 to 00:29, on 3.0.90.4, scratch copies, never saved):**
   - BEFORE (copy of the fixture, SHA-256 34BBE37C...): `C:\CE_WORK\scratch\trustprobe\reads\LPDCHK_BEFORE.record.txt`: outlet on pipe 109500, COUNCIL STUB.
   - AFTER (copy of Codex's saved L2 copy, SHA-256 C0E6E545..., unchanged since 16:27): `C:\CE_WORK\scratch\trustprobe\reads\LPDCHK_AFTER.record.txt`: outlet on pipe 109835, KERB & CHANNEL, invert 17.08. 109835 is CE's pipe P2 to P1 (from-invert 17.08) in the same record.
   - Codex screenshots: `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\LPD14_L2_20261114_1618\screenshots\` (LPD14-17, -18 plain line refused; LPD14-30 to -34 CE pipe taken; LPD14-35, -36 saved and reopened). Transcript `C:\CE_WORK\scratch\trust_install\lpd_check.out`.
   - Sent to the controller to check and write; I have not changed the carpark entry.
5. **CDRUNSOLVE, robot on 3.0.90.4 (scratch copies, each closed by the driver, the 4 settings files the same each time):**
   - **No Q anywhere: SEEN PASS** (00:42): "[CDRUNSOLVE] Run: P10 -> P9 -> P8 (anchor P8), 2 pipe(s)." then "Nothing was changed. No pipe in this run has a design flow, so CE cannot size or level it. Type each pipe's Design flow (Q) in Pipe Edit (CDEDIT), then run CDRUNSOLVE again." Record unchanged (606,938 characters before and after). `C:\CE_WORK\scratch\trust_install\b2_rs_part2.out`.
   - **Esc at the start-pit question: SEEN PASS** (00:43): "*Cancel*", record unchanged. Same file.
   - **Split at P10, with and without the LPD (two copies): A, B, Enter SEEN PASS** (00:45 to 00:57): A = "Run: P10 -> P9 (anchor P9), 1 pipe(s)"; B = "Run: P10 -> P4 -> P3 -> P2 -> P1 -> C1 -> STUB (anchor STUB), 6 pipe(s)"; each then says no design flow, nothing changed; Enter = "Nothing to solve ... choose a pipe at P10 when asked". Record unchanged after every answer. `C:\CE_WORK\scratch\trust_install\b2_split.out`. (Its Esc row is not a test: the driver added its own Enter, as in batch 1.)
   - **Esc at the split question: SEEN PASS** (01:00, third copy): "*Cancel*" then "[CDRUNSOLVE] Cancelled - drawing unchanged.", record unchanged. `C:\CE_WORK\scratch\trust_install\b2_splitesc.out`.
   - **NOT done by the robot, and why:** typing Q needs Pipe Edit's **"More…"** button. In the one-page Edit Pipe window the Design flow (Q) box is NOT on the first page (tree `C:\CE_WORK\scratch\trust_install\b2rs_editpipe.tree.txt`), and More… is not on the driver's press list. The preview's Apply is not on it either. So one Q blank, Q on both with the preview rows, Cancel, Esc, Yes then one U, and save/reopen with Q go to the Codex look RSQ15 (brief `C:\Lisp Files\_CODEX_RUNNER\verifyRSQ15_full.txt`, fixture `C:\Lisp Files\_TEST_COPIES_20260923\CLDTP_RSQ15.dwg` = standard copy + pit P8 + pipes P10 to P9 and P9 to P8, no Q, made by `rsq_prep.ps1`).
   - **For Tim (a drafting point, not a fault of the fix):** to type Q a drafter has to open More… in Edit Pipe; the CDRUNSOLVE message says "Type each pipe's Design flow (Q) in Pipe Edit (CDEDIT)" without saying where.
   - My first CDRUNSOLVE pass (00:29 to 00:40) is NOT counted: its typed picks missed ("Nothing Selected", the view had moved off the run). I stopped it and cancelled its open Edit Pipe window without saving.
6. **Note:** my PIT Codex look (verifyTPIT14) had started at 23:41 on the new build; I stopped it and closed the AutoCAD it opened at 23:43 (my own run, scratch copy, nothing saved, settings the same). The 23:43:29 "Started" line above is that AutoCAD.
7. **Codex look RSQ15, first run (01:10 to 01:18): BLOCKED at Q-01 (input), nothing tested.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSQ15_Q1_20261115_0114.md`. Codex found the box (Edit Pipe, More…, a separate "More options" window, tab "Levels & Flow", "Design flow ... L/s"; screenshot `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSQ15_Q1_20261115_0114\screenshots\RSQ15-04-Q01-blank-after-typing.png`), but after Ctrl+A and typing 10.00 (twice) the box stayed blank. Codex calls it an input blocker, not a CE fault; not proven either way. Drawing unchanged, settings the same, AutoCAD closed, Codex usage 4.0% to 4.0%. Second run started 01:2x with single key presses (1, 0) instead.
8. **Codex look RSQ15, second run (01:20 to 01:28): BLOCKED at Q-01 (input) again.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSQ15_Q1_20261115_0123.md`; close-up `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSQ15_Q1_20261115_0123\screenshots\RSQ15-15-input-closeup.png`. Single key presses (1, 0, then Backspace, 1, 0) left the box blank. Codex says its key presses went to the AutoCAD window first and to the Edit Pipe window on the retry, never to the separate "More options" window that holds the box. Drawing and settings unchanged, AutoCAD closed, Codex usage 4% to 5%.

## Batch 2, where it stands (Sun 15 Nov 01:30 PC clock)

1. **SEEN PASS by the robot on 3.0.90.4:** first start; BUG-1456 smoke 10 of 10 (readings identical to batch 1); CDRUNSOLVE no Q anywhere (right words, nothing changed); Esc at the start pit; split at P10 A, B, Enter on two copies; Esc at the split. Nothing failed.
2. **NOT TESTED (neither robot nor Codex could type Q):** one Q blank; Q on both with the preview rows; Cancel; Esc in the preview; Yes then one U; save and reopen with Q kept. The CDRUNSOLVE design-flow fix is therefore NOT seen working in real AutoCAD yet (only in the core console, 14 Nov 18:10).
3. **For Tim, one minute (open question, not a fault yet):** in Edit Pipe, click More…, tab Levels & Flow, click the Design flow box and type 10. Does the 10 appear? If it does not, the fix cannot be used by a drafter and that is a fault; if it does, the gap is only our tools. Two other ways to close it: a reviewed one-line addition of the window "*More options*" (set only) to the driver's pinned list; or a Codex input route that can aim at that window.
4. **Batch 2 stays installed** (nothing failed). AutoCAD is closed. Ready for batch 3.

## Batch 2, CDRUNSOLVE with design flows SET BY THE TEST (controller's order of 01:3x; Q was NOT typed)

1. **How Q got there:** the desk wrote a design flow onto the five pipes of the standard drawing's existing run P4 -> P3 -> P2 -> P1 -> C1 -> STUB (8, 8, 15, 22, 22 L/s, source "set by test", so CE can never call it "typed in Pipe Edit") straight into a SCRATCH copy's CE record, by the AutoCAD core console with CE not loaded (the headless harness's isolated profile, never Tim's). Script `C:\CE_WORK\scratch\trust_install\rsq5_setflow.ps1` with `setq_test.lsp`; copy `C:\CE_WORK\scratch\trustprobe\TRUST_VERIFY\CLDTP_RSQ5.dwg`. Record length 244,096 to 244,254 (the five additions exactly), 958 pieces.
   - First tries did not count: (a) my edit doubled the record and CE said "the CE record in this drawing could not be read, so CE does not save over it" (CE's safety rule working: it left the record alone); (b) a run ending at a new pit P8 with no level was refused, rightly: "Downstream anchor pit 'P8' has no invert level ... set the connection IL first".
2. **Robot, real AutoCAD, 3.0.90.4 (01:41 to 01:45):** CE's record on opening shows all five flows. CDRUNSOLVE at P4, Enter: "[CDRUNSOLVE] Run: P4 -> P3 -> P2 -> P1 -> C1 -> STUB (anchor STUB), 5 pipe(s)." and the Proposal Preview opened: **SEEN PASS.**
   - Preview words: "Whole-run solve — 5 pipe(s), 6 pit(s)"; "9 change(s) to apply (1 already at the proposed value)"; "Design flows used: P4 to P3 8.00 L/s, from set by test; P3 to P2 8.00 ...". Full text `C:\CE_WORK\scratch\trust_install\rsq5_preview.tree.txt`; transcript `C:\CE_WORK\scratch\trust_install\rsq5_robot.out`.
   - **Closing the preview (No): SEEN PASS.** "[CDRUNSOLVE] Cancelled - drawing unchanged."; CE's record identical before and after except the known format number and stored path (593,355 characters each once those two are set aside); all five flows still there.
3. **For Tim's engineering judgement (not judged here):** the proposed levels rise a long way (C1 -> STUB upstream 16.82 to 17.10; P1 -> C1 upstream 16.93 to 18.32; P2 -> P1 upstream 17.08 to 19.30, "DN100 at 1:9, 2.80 m/s") and the preview itself warns "COVER: pipe from 'P2' upstream obvert cover -488 mm < minimum 300 mm", "-889 mm" at P3, "-518 mm" to P2: the pipe tops would be above the lids. A DN100 run held at 1:9 for 22 L/s, climbing from the stub, may not be what a drafter wants; the warnings are shown, nothing is hidden.
4. **Codex look RSQ16 (Esc in the preview, Yes, one Undo, save and reopen, and one more typing try): running from 01:4x.** Brief `C:\Lisp Files\_CODEX_RUNNER\verifyRSQ16_full.txt`, fixture `C:\Lisp Files\_TEST_COPIES_20260923\CLDTP_RSQ16.dwg` (= CLDTP_RSQ5).
5. **Codex look RSQ16 stopped by me at 01:48 before it opened AutoCAD** (controller: batch 3 install waiting). Nothing ran in AutoCAD; fixture unchanged (SHA-256 65818DA038CF...). It reruns as is after batch 3, on whatever is installed then. Esc in the preview, Yes, one Undo, save and reopen: NOT TESTED yet.

# BATCH 3: Civil 3.0.90.5+3c620efe (the two Pit Schedule fixes; installed by the controller Sun 15 Nov 01:49; robot by trust-acad-evidence from 01:49 PC clock)

## FOR TIM (batch 3)

1. **First start: SEEN PASS.** Civil log `C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`: "CE_CVL_SUITE v3.0.90.5 Started"; no "[BUG-1456]" line.
2. **Two jobs mixed up (BUG-1456) smoke: SEEN PASS, 10 of 10** (01:49 to 02:34). All ten "nothing disturbed" readings the same size as on batch 2. Transcript `C:\CE_WORK\scratch\trust_install\b3_seq.out`. AutoCAD closed by the driver, the 4 settings files the same.
3. **Pit Schedule's new top line (BUG-1274), everyday case: SEEN PASS** (02:34 to 02:51, scratch copy of AutoCAD's own blank metric drawing `CLDTP_B3PS1.dwg`; 1 ordinary pit and 3 plastic pits placed with PIT; plastic = plan size 350 x 350, and its Pit number box goes grey, so it has no number):
   - Top line, word for word from the screenshot: "3 plastic pits are not in this schedule: none of them has a number. Open PIT on each and press Number and schedule this one anyway to add it. | Drawing check: 7 data issues may affect this schedule". No internal code (such as 2A3F) anywhere. The table lists only P1, the ordinary pit ("1 rows listed").
   - Closing the window: CE's record and the drawing identical before and after.
   - **Screenshot for Tim's eye (wording he sees):** `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_023410\B3_PITSCHEDULE_case1.png`. Window words `C:\CE_WORK\scratch\trust_install\b3ps_case1.tree.txt`; transcript `C:\CE_WORK\scratch\trust_install\b3_pitsched.out`.
   - My first ordinary pit was not placed: the blank drawing asked "This drawing isn't tagged yet. Is this a Civil drainage drawing? [Yes/No] <Yes>" and my typed point answered it ("Invalid option keyword"); so the case has 1 ordinary pit, not 2. Not a fault.
   - Small wording point for Tim: "1 rows listed".
4. **Pit Schedule, numbered plastic pits P3 to P5: NOT TESTED by the robot.** The robot cannot give a plastic pit a number: the Pit number box is grey for a plastic pit (and New Pit remembers the last pit's plastic size, so it opens grey), and "Number and schedule this one anyway" is not on the driver's press list. The second copy (`CLDTP_B3PS2.dwg`, 3 unnumbered plastic pits) again showed the same correct line, record and drawing unchanged; screenshot `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_025905\B3_PITSCHEDULE_case2.png`; transcript `C:\CE_WORK\scratch\trust_install\b3_ps_case2.out`. Goes to a Codex look.
5. **Next:** CDRUNSOLVE once (robot); Export CSV (Codex look PSX15, brief ready); numbered-plastic case (Codex).
6. **CDRUNSOLVE once on 3.0.90.5 (regression check, robot, 03:09 to 03:12): SEEN PASS**, same as batch 2: design flows set by the test (copy CLDTP_RSQ5), preview 'Whole-run solve — 5 pipe(s), 6 pit(s)', 9 changes; closing it (No) = 'Cancelled - drawing unchanged.', all five flows still in CE's record. Transcript `C:\CE_WORK\scratch\trust_install\b3_rsq_robot.out`.
7. **Export CSV (Codex look PSX15): NOT RUN on 3.0.90.5.** Started 03:12, stopped by me at 03:13 before it opened AutoCAD, for the controller's batch 4 and 5 installs. Brief `C:\Lisp Files\_CODEX_RUNNER\verifyPSX15_full.txt` reruns on 3.0.90.7.
8. **Batch 3 where it stands (03:14):** PASS: first start; smoke 10 of 10; Pit Schedule everyday case (screenshot for Tim above); CDRUNSOLVE once. FAIL: none. NOT RUN / NOT TESTED: Pit Schedule numbered P3 to P5 (new robot route ready: ordinary pits P3 to P5 turned plastic in Edit Pit, script `C:\CE_WORK\scratch\trust_install\b3_ps_numbered.ps1`; "Number and schedule this one anyway" on P4 needs Codex); Export CSV (Codex). Both carry over to the combined list on 3.0.90.7.

# BATCHES 3 TO 5 ON 3.0.90.7 (Civil 3.0.90.7+9b977125; batches 4 and 5 installed by the controller 03:15 and 03:16; robot from 03:17 PC clock)

## Item 1: first start, opening line, read-only tools (03:17 to 03:30, transcript `C:\CE_WORK\scratch\trust_install\b5_open.out`)

1. **First start: SEEN PASS.** Log: "2026-11-15 03:17:45.237 [INFO] CE_CVL_SUITE v3.0.90.7 Started".
2. **Opening line on the standard Civil copy: SEEN PASS** (the "needs checking" form, because this copy has pipes CE cannot link): "CE: needs checking. 22 pipes not linked. Type CDCHECKCURRENT to see them." then "CE: pit blocks were updated when this drawing opened." **Screenshot for Tim:** `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_031154\B5_OPENLINE_civil.png`.
3. **Same copy with one bare polyline on the pipe layer, saved and reopened: SEEN PASS:** "CE: needs checking. 22 pipes not linked, 1 line on a pipe layer not in the CE record. Type CDCHECKCURRENT to see them." Screenshot `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_031154\B5_OPENLINE_stray.png`. CDCHECKCURRENT: "Drawing check complete. 28 items need checking. Nothing has been fixed automatically."
4. **CDGRAPH, CDDIAG, CDDASHBOARD leave CE's record, the drawing and DBMOD unchanged: SEEN PASS, each** (record and drawing fingerprint identical before and after; DBMOD 1 before and after).
5. **Record-change line (step 5): SEEN:** CDEDIT on pit P10 then Cancel, after the bare line: "CE updated its record (CDEDIT): 1 pipe added. Guessed, not read from the drawing: 1 pipe size (100), 1 pipe material." **Against Tim's rule (flagged to the controller):** CE took the bare line into its record as a pipe with a made-up size by itself, on a cancelled edit (hold switch OFF, as shipped; the drawing itself did not change). This is the shipped behaviour Q13 names; the batch 4 hold switch is meant to stop it (tested next, switch ON).
6. **Blank drawing: SEEN PASS** (no CE line; log "[OpenLine] quiet (not a Civil drawing)").
7. **Structural drawing: NOT TESTED** (no Structural test copy found in the test folders). The copy named CLDTP_NONCIVIL holds a CE pit: "CE: 1 pit, 0 pipes, all linked." and "CE: pit blocks were updated when this drawing opened." So it is not a fair non-Civil drawing.
8. AutoCAD closed by the driver, the 4 settings files the same.

## Item 2: mix-up smoke on 3.0.90.7: SEEN PASS, 10 of 10 (03:31 to 04:16)

1. Transcript `C:\CE_WORK\scratch\trust_install\b5_seq.out`; AutoCAD closed by the driver, the 4 settings files the same. No refusal line in this ordinary work.
2. The ten 'nothing disturbed' readings are byte-size identical to batch 3's.

## Item 3a: Pit Schedule, numbered plastic pits: NOT TESTED by the robot (04:16 to 04:40)

1. **Route tried:** 3 ordinary pits on a blank scratch copy (`CLDTP_B3PS3.dwg`; CE numbered them P1, P2, P3 itself, my typed numbers were not taken), then each opened in Edit Pit and set to 350 x 350 (the Pit number box goes grey: plastic).
2. **Blocked:** the robot cannot save Edit Pit on this build. The button is now named "Edit pit, Save" (id C2.PlaceCommand); the driver's pinned list only excuses the old name "Save pit and close", and refuses any other control containing "Save" ("refused by the whole-word deny list"). Nothing was saved; the Edit Pit window was left open.
3. **AutoCAD:** my script was stopped; the driver then refused to close that AutoCAD (the re-taken lock no longer named it), so I ended it myself: my own process (started 04:16:53 by my launch), scratch copy, nothing saved; the 4 settings files identical before and after (CD_Settings ACD64E79A33B...).
4. **Goes to Codex:** numbered plastic pits, the Pit Schedule line naming them, and "Number and schedule this one anyway". Transcripts `C:\CE_WORK\scratch\trust_install\b5_ps_numbered.out`, `C:\CE_WORK\scratch\trust_install\b5_ps_numbered2.out`.
5. **Same reason affects:** batch 4's "Save then one U" with the hold switch on (Edit Pit Save): Codex.

## Item 4: batch 4's CDEDIT hold with the switch ON (one scratch session): BLOCKED (04:38 to 04:49)

1. **Set-up:** a copy of Tim's CD_Settings.json at `C:\ce_rc_scratch\b14d_switch\settings\CD_Settings.json` with `"trust": {"cdeditCancelWritesNothing": true}` (his own file only read; its SHA-256 unchanged, ACD64E79A33B...). Script `C:\CE_WORK\scratch\trust_install\b5_hold.ps1`.
2. **Blocked:** the driver's `launch -Env CE_LOG_DIR_OVERRIDE=C:\ce_rc_scratch\b14d_switch` started AutoCAD (04:38:49) but no drawing opened (window title "Autodesk AutoCAD 2027", no drawing name) and the launch call did not return in 10 minutes; no CE log appeared in the scratch folder, so the switch was not proven on. Nothing was tested. I ended that AutoCAD (my own launch, no drawing open) and the stuck driver call; the 4 settings files the same.
3. **Still owed:** Edit Pit and Edit Pipe Cancel and Esc with the switch on (including the bare pipe-layer line case: the record must stay identical), and Save then one U (Edit Pit Save is Codex-only now). Needs a working switch-on start: either the driver's -Env route fixed (it is marked "THIS COPY ONLY until Opus has reviewed it") or the runbook's own route (a .cmd that sets the variable and starts acad.exe, handed to Explorer), which the driver cannot then drive (it only drives an AutoCAD it launched). Not mine to change the driver.

## Item 5b: batch 5 CDRENUMBER display lines: DIFFERENT (not shown), robot 05:26 to 05:37 (transcript `C:\CE_WORK\scratch\trust_install\b5_ren.out`)

1. **Lone pit P8 not joined to the outlet** (standard copy + one pit at 100000,-90000): CDRENUMBER asked "More than one pit discharges outside the network - its main outlet is not obvious: Which pit is the main outlet? ... [C1/X1] <C1>", then "Pit numbers already read downhill to uphill - nothing to renumber." **P8 was not named.** Drawing unchanged; CE's record gained only an identity link on one pipe (pipe 11362F "from AGI" got a fromSpineKey), no level, size, number, label, layer or colour.
2. **A real loop in CE's records** (two pipes P10 and P9; CDREVERSEFLOW with Yes turned the second round: "End values swapped and arrow reversed"; record then holds 11C651 P10->P9 and 11C67E P9->P10): CDRENUMBER again "nothing to renumber", **no loop line**. Record and drawing unchanged.
3. **Reading (mine, not proven):** the two new lines are written just before the Yes/No question; when nothing needs renumbering no question is asked, so they never appear. The runbook expects them to name the pit and the pipes. A case where renumbering IS needed was not built tonight. Sent to the controller.
4. My first two runs of this did not count (my script's function name "Ren" is PowerShell's own Rename-Item, so it waited; and my Enter answered No to CDREVERSEFLOW's question).

## Item 5a: batch 5 CDLPD (BUG-1298), the re-look: Codex OVERALL PASS + record read (05:40 to 06:01)

1. **Codex look LPD15 run L3 on 3.0.90.7: OVERALL PASS, 8 PASS + 1 SEEN, 0 FAIL.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_LPD15_L3_20261115_0540.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\LPD15_L3_20261115_0540\screenshots\`.
   - **L-03 plain polyline refused: PASS** ("[CE] That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. ..."; record unchanged). LPD15-18-plain-polyline-picked.png, LPD15-19-L03-record-unchanged.png.
   - **L-06 bare polyline on STORMWATER PIPE (Tim's rule, 15 Nov): PASS, refused with the same line**, record unchanged. LPD15-35-L06-picked.png, LPD15-36-L06-unchanged.png.
   - **L-07 CE pipe 109835 taken: PASS** ("LPD set."; R1 PipeHandle 109835). LPD15-41-L07-picked.png to LPD15-43-L07-record-109835.png.
   - **L-08 still 109835 after save and reopen: PASS.** LPD15-44-L08-saved.png, LPD15-45-L08-reopened.png.
   - L-04 (plain LINE) recorded only: older wording "Select a pipe, pit, or any block (kerb outlet, connection point, etc.)." and the question repeats; nothing changed. L-05 Esc: PASS.
   - (A first start at 05:38 was NOT STARTED: Explorer was minimised and Codex's screen check refused; I opened an Explorer window on the test folder and reran.)
2. **Before-and-after CE record read (robot, 05:58 to 06:01, scratch copies, never saved, both hashes unchanged):**
   - BEFORE (copy of the fixture, SHA-256 34BBE37C...): `C:\CE_WORK\scratch\trustprobe\reads\LPD15CHK_BEFORE.record.txt`: outlet on pipe 109500, COUNCIL STUB.
   - AFTER (copy of Codex's saved copy, SHA-256 03FBE1BD..., saved 05:53): `C:\CE_WORK\scratch\trustprobe\reads\LPD15CHK_AFTER.record.txt`: outlet on pipe 109835 (CE's pipe P2 to P1), downstream end, pit 109601, KERB & CHANNEL, invert 16.98.
   - Transcript `C:\CE_WORK\scratch\trust_install\lpd15_check.out`. The driver's quit closed the drawings but AutoCAD stayed open with none; I ended it (my own launch at 05:58:19, nothing open); settings the same.
3. **For the controller to write:** Codex PASS with screenshots + record read, on the installed build, with Tim's pipe-layer rule met. I have not changed the carpark entry.

## Item 3b: Pit Schedule, numbered plastic pits (Codex look PSN15 N1, 06:05 to 06:24): line PASS; its instruction points at a button drafters cannot reach

1. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_PSN15_N1_20261115_0606.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\PSN15_N1_20261115_0606\screenshots\`. OVERALL BLOCKED (N-04).
2. **N-02 PASS:** three pits P1 to P3 turned plastic in Edit Pit (350 x 350, "Edit pit, Save"; "Pit updated." x3).
3. **N-03 PASS:** "3 plastic pits are not in this schedule: P1 to P3. Open PIT on each and press Number and schedule this one anyway to add it. | Drawing check: 6 data issues may affect this schedule"; no internal code; 0 rows listed. PSN15-10-schedule-three.jpg, PSN15-10-schedule-full.jpg.
4. **N-04 BLOCKED, and a finding:** "Number and schedule this one anyway" is NOT in Edit Pit or its More options window (Drawing & Schedule shows a grey "Included in pit schedule" and "Plastic pit: no label block and excluded from schedule"). PSN15-11-missing-override-0.jpg, PSN15-11-missing-override-3.jpg. By reading: the button exists only in the older Pit dialog (`PitDialog.xaml:353`), not in the New Pit / Edit Pit windows drafters use now. **So the schedule's new line tells the drafter to press a button they cannot find.** For Tim (queue item 4, the wording) and the fix lane.
5. N-01 (placing the three pits) NOT TESTED for evidence only: the pits were made (R2 = 3) but the saved screenshots repeated an earlier capture.

## Item 3c: Export CSV (BUG-1342), Codex look PSX15

1. **First run X1 (06:29 to 06:35): BLOCKED at X-01, nothing tested.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_PSX15_X1_20261115_0629.md`. Codex's typing did not reach the Windows Save As box (the same as the More options box), and the driver's dialog-path refused a file that does not exist yet ("REFUSED: the file does not exist"). Save As cancelled; drawing and settings unchanged.
2. **Second run from 06:37:** the desk made both test CSV files first (one PLACEHOLDER line each, SHA-256 3DF839C5AE9E...), so dialog-path accepts them and Codex only clicks Save and Yes; RIGHT now = the placeholder is replaced by the schedule.
3. **Second run X1 (06:36 to 06:42): BLOCKED at X-01 again, nothing tested.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_PSX15_X1_20261115_0636.md`. With the Pit Schedule window open (it holds AutoCAD), the driver's calls time out ("HARD TIMEOUT"), so dialog-path cannot fill the Save As box; Codex's own typing does not reach it either. Placeholders untouched; AutoCAD and Excel closed; settings the same. Seen: "Will be placed: 27 rows · All sets · All systems", "Drawing check: 95 data issues may affect this schedule".
4. **Export CSV stays NOT TESTED** (no product fault seen). It needs a person (one minute: export, then export again with the file open in Excel), or a driver way to fill a Save As box while a CE window is open, or a Codex input route that reaches Windows boxes.

## Item 6: CDRUNSOLVE with design flows set by the test (not typed), Codex look RSQ16 Y1 (06:43 to 06:57): FAIL at one Undo

1. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSQ16_Y1_20261115_0646.md`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSQ16_Y1_20261115_0646\screenshots\`. Copy `CLDTP_RSQ16.dwg` (flows 8, 8, 15, 22, 22 L/s written by the desk, "set by test").
2. **Y-01 Esc in the preview: PASS** ("Cancelled - drawing unchanged", object count 1054). RSQ16-06-preview.png, RSQ16-07-preview-closeup.png, RSQ16-08-after-esc.png.
3. **Y-02 Apply (Yes): PASS** ("Applied 5 change(s)"; P4 level 17.40 to 19.99). RSQ16-12-apply-preview.png, RSQ16-13-applied.png, RSQ16-15-solved-p4.png.
4. **Y-03 run again: PASS** ("every invert already matches the solved design - nothing to apply"). RSQ16-16-already-solved.png.
5. **Y-04 ONE UNDO: FAIL.** One U echoed CDRUNSOLVE, but P4 still showed 19.99 and the next CDRUNSOLVE opened no preview and still said every invert already matches: **the applied levels were not taken back by one U.** RSQ16-17-one-undo.png, RSQ16-18-undo-levels.png, RSQ16-19-undo-p4.png, RSQ16-20-undo-no-preview.png. Sent to the controller at once; not put back by me.
6. **Y-05 save and reopen: BLOCKED** (nothing left to apply after the failed Undo). **Y-06 typing try: BLOCKED** (CDEDIT asked an older-pipe-label question first; Edit Pipe cancelled without saving; the box was not reached).
7. **For Tim (queue item 9):** Apply wrote levels the preview had warned about: "COVER: pipe from 'P4' upstream obvert cover -1226 mm", "pit 'P4' depth -1126 mm < minimum 300 mm" and others. Nothing hidden, but these levels went into the drawing on one press.
8. Not known: whether 3.0.90.4 behaves the same (Apply had never been pressed before tonight).

## Item 6b: the Undo question (controller, 15 Nov ~07:00: RSQ16's U came after a second CDRUNSOLVE run, so it may have undone that run, not the Apply)

1. **The controller is right about RSQ16:** its order was Apply, then a second CDRUNSOLVE ("nothing to apply"), then U; the U echoed CDRUNSOLVE. So RSQ16's Y-04 does NOT show that Apply cannot be undone. **RSQ16 Y-04 FAIL is withdrawn; it is NOT TESTED.**
2. **Codex re-run RSQ17 U1 (07:00 to 07:17): inconclusive again, my brief's fault.** It ordered a ZOOM after Apply, and the first U echoed ZOOM. Then each U took back the second "nothing to apply" run (echo CDRUNSOLVE) and REDO redid it. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSQ17_U1_20261115_0701.md`; record reads `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSQ17_records\` (RU_0 P4 to P3 from 17.40; RU_1 to RU_4 and RU_8 from 19.99).
3. **Learned anyway:** (a) a CDRUNSOLVE run that applies nothing still counts as its own undo step (U echoes CDRUNSOLVE and nothing changes): a small point against "one Undo per change", for the controller to weigh; (b) the applied levels and design flows survive save and reopen (P4 IL 19.99 after reopen; CE then says nothing to apply).
4. **U-06 typing try:** blocked again: the older-pipe-label question came first; the driver refused the typed answer (BUSY) and a hand answer turned into PASTECLIP (cancelled). The Design flow box was not reached.
5. **Clean re-run RSQ18 started 07:2x:** zoom only before the command, Apply, then U at once with nothing between.
6. **Clean re-run RSQ18 U1 (07:17 to 07:29): APPLY THEN ONE U PUTS IT BACK, seen in the readings.** Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_RSQ18_U1_20261115_0718.md`; readings `C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\RSQ18_records\`.
   - RU_0 (before): P4 to P3 from 17.40 to 17.30. RU_1 (after Apply): 19.99 to 19.70, and the drawing carries the label "IL 19.99". RU_2 (after ONE U, which echoed CDRUNSOLVE): **CE's record AND the drawing fingerprint byte-identical to RU_0** (checked by me; no "IL 19.99" text left). Then CDRUNSOLVE offered the same 9 changes again (Codex saw it; Cancel).
   - RU_8: Apply again, save and reopen: 19.99 kept; CE then said nothing to apply.
   - **Evidence class:** robot-style readings (record and drawing before/after). Codex saw each step live but its screenshot saver kept the baseline image, so Codex claims no visual PASS ("NOT TESTED: EVIDENCE").
   - **So: CDRUNSOLVE Apply is undone by one U (record and drawing). The 06:57 FAIL is withdrawn.** Small point still open: a CDRUNSOLVE run that applies nothing counts as its own undo step.
   - Typing try not run (my RSQ18 brief left the step out); the Design flow box stays untested.

# 2027-ONLY TRIAL (Civil 3.0.90.7, Modern set only, installed by the controller 07:32; robot 07:33 to 07:39)

Transcript `C:\CE_WORK\scratch\trust_install\b2027.out`. Live Civil lanes: Modern only. Two separate AutoCAD 2027 starts, scratch copies; each closed by the driver, the 4 settings files the same.

1. **"CE_CVL_SUITE v3.0.90.7 Started": PASS, both starts** (CE log 07:33:19.240 and 07:38:10.103).
2. **Ribbon: PASS, both starts:** "Standalone CE Civil ribbon built: CE (9 panels)." (9 panels, as on the three-set batches). Screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_072831\B2027_start_1.png`, `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_073755\B2027_start_2.png`.
3. **CE logs: PASS:** 0 lines with unable to load, FileNotFound, missing file, mismatch, BadImageFormat, ERROR, FATAL or Exception since each start.
4. **Command line: OPEN QUESTION, both starts:** "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager". Not known whether the three-set build prints the same: none of tonight's earlier transcripts kept that part of the command line, and no AutoCAD log of it was found. The Manager menu is in Manager's own untouched bundle, which suggests it is not caused by the trim, but that is a reading, not proof. **Check needed:** one three-set start after the put-back, reading the same lines and AutoCAD's menu-group list (2 minutes). (Other command-line lines were the drawing's missing backgrounds, "Background not found: XW2626-Title Block" etc., which are the test drawing's own.)
5. **Manager and Structural loading:** no load-failure line in their logs; my log filter did not catch their own "loaded" lines, so not separately proven beyond "no error".
6. **Opening line on a Civil copy: PASS, both starts:** "CE: needs checking. 22 pipes not linked. Type CDCHECKCURRENT to see them." and "CE: pit blocks were updated when this drawing opened."
7. **Short mix-up smoke (3 sequences): PASS:** CDHELP first in a blank drawing: no CE record; CDS in the same blank drawing: no CE record; back in the Civil copy: its record byte-identical to before.
8. **Pit Schedule window opens: PASS** (screenshot `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_072831\B2027_pitschedule.png`), closed cleanly.
9. **CDCHECKCURRENT runs: PASS:** "[CE] Drawing check complete. 27 items need checking. Nothing has been fixed automatically."
10. **Comparison on the three-set build (put back by the controller 07:44; one start 07:45 to 07:46, transcript `C:\CE_WORK\scratch\trust_install\b3set_menu.out`):** the SAME two lines appear: "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager". So **they are not caused by the 2027-only trim**; they are an existing quirk of every start (cause not looked into tonight).
    - AutoCAD's own menu-group list (three-set): ACAD, APPMANAGER, CUSTOM, CE_SUITE_MANAGER_MENU, FEATUREDAPPS, CE_STRUC_SUITE_MENU, CE_CVL_SUITE_MENU, MODELDOC, EXPRESS, DBCONNECT: all three CE menu groups load.
    - **Menus and ribbon actually appear in both cases:** the two screenshots are the same: menu bar "CE CVL - Layout, CE CVL - Sources, CE CVL - Review, CE CVL - Edit, CE CVL - Settings, CE CVL - Import/Export, CE CVL - Admin, CE Manager - Control"; ribbon tab "CE Tools"; status bar "CE MANAGER v1.1.89 [Modern] ... CE CVL SUITE v3.0.90 2026-11-15 [Modern] CE STRUC SUITE v1.0.126". Three-set `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_073926\B3SET_start.png`; 2027-only `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_072831\B2027_start_1.png`. Ribbon line both: "Standalone CE Civil ribbon built: CE (9 panels)."
    - **Trial verdict (mine): every check as on the three-set build; nothing new in the logs or on the command line.**

# BATCH 8 ON 3.0.90.10 (Civil 3.0.90.10+fcf465a9, installed by the controller 07:48; robot from 07:49 PC clock)

## Switch OFF (as shipped), robot, part 1 (07:49 to 07:58, transcript `C:\CE_WORK\scratch\trust_install\b8_a.out`; screenshots in `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_074626\`)

1. **First start: SEEN PASS:** "2026-11-15 07:49:38.769 [INFO] CE_CVL_SUITE v3.0.90.10 Started".
2. **Opening line: SEEN PASS:** "CE: needs checking. 22 pipes not linked. Type CDCHECKCURRENT to see them." / "CE: pit blocks were updated when this drawing opened." (B8_OPENLINE.png).
3. **CDRUNSOLVE with no design flow names where the box is: SEEN PASS:** "[CDRUNSOLVE] Nothing was changed. No pipe in this run has a design flow, so CE cannot size or level it. Type each pipe's Design flow (Q) in Pipe Edit (CDEDIT: click More…, then the Levels & Flow tab), then run CDRUNSOLVE again." (B8_CDRUNSOLVE_noQ.png, for Tim). Drawing unchanged; CE's record changed only its format number and stored path (the known first-CE-action stamp).
4. **CDRENUMBER (a), lone pit P8: SEEN PASS:** "Not joined to this outlet by pipes: X1, P9, P10, P8. CDRENUMBER does not number them from this outlet. Check them." then "The pits joined to this outlet already read downhill to uphill - nothing to renumber. Nothing was changed." No question; record and drawing identical (B8_CDRENUMBER_lone.png, for Tim). (X1, P9 and P10 are also really not joined to C1 in this test drawing.)
5. **CDRENUMBER (b), a real recorded loop (P10 to P9 and P9 to P10 after CDREVERSEFLOW Yes): SEEN PASS:** "The pipe records loop back on themselves: P10 to P9 and P9 to P10. Pits P9 and P10 are on it. Check those pipes (CDREVERSEFLOW turns a pipe round)." then the not-joined line and the same last line. No question; record and drawing identical (B8_CDRENUMBER_loop.png, for Tim).
6. AutoCAD closed by the driver; the 4 settings files the same.

## Switch OFF, robot, part 2: Pit Schedule left-out line (2039 follow-up), 07:58 to 08:08 (transcript `C:\CE_WORK\scratch\trust_install\b8_ps.out`)

1. **Plastic pits: SEEN PASS.** Blank scratch copy, 1 ordinary pit P1 and 3 plastic pits (350 x 350; Pit number box grey). Banner: "3 plastic pits are not in this schedule: none of them has a number. The plastic-pit preset keeps them unnumbered and unscheduled." **No button is named** ("Number and schedule" appears nowhere in the window). **Screenshot for Tim:** `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_075814\B8_PITSCHEDULE_plastic.png`.
2. **"1 row listed": SEEN PASS** (was "1 rows listed").
3. **Two sentences on separate lines: SEEN PASS:** the left-out sentence, then "Drawing check: 7 data issues may affect this schedule" on its own line.
4. **Closing the window: CE's record and the drawing identical before and after.**
5. **Switched-off pit line (name the real route, and check each control it names is in the one-page Edit Pit): NOT RUN by the robot.** Turning "Included in pit schedule" off needs Edit Pit's Save ("Edit pit, Save"), which the driver refuses (press list unchanged, Tim's question 16 open): BLOCKED for the robot; for Codex.

## Unknown switch ON for one scratch session: how to start it (08:08 to 08:30)

1. **Route 1, the driver's `launch -Env CE_LOG_DIR_OVERRIDE=C:\ce_rc_scratch\b14h_switch`: does NOT work, and now we know why.** The driver starts acad.exe directly (not through Explorer). AutoCAD came up with no drawing and sat behind a box: **"AutoCAD Message: Customization file load failed. File not found: acad"** (screen picture `C:\CE_WORK\scratch\trust_install\screen_peek.png`, taken read-only at 08:27). So it never opened the drawing, and the launch call never returned. The driver only removes secret-looking variables (KEY, TOKEN, ...), so why AutoCAD cannot find its menu file this way is for the driver's owner. I ended that AutoCAD (my own start, no drawing); settings the same. Same as the 04:38 attempt.
2. **Route 2, the runbook's `.cmd` handed to Explorer: WORKS.** `C:\CE_WORK\robot\b14h_switch\start_switch_session.cmd` (set CE_LOG_DIR_OVERRIDE, then start acad.exe on the scratch copy). AutoCAD opened the copy; CE's session log `C:\CE_WORK\robot\b14h_switch\CE_CVL_SUITE.log` says "Settings initialized from: C:\CE_WORK\robot\b14h_switch\settings\CD_Settings.json" (the copy with `"trust": {"showUnknownInsteadOfGuess": true}`). The driver could read status, type a command and run CDCHECKCURRENT in it, and its quit closed it. Tim's own CD_Settings.json unchanged (hash checked). Transcript `C:\CE_WORK\scratch\trust_install\b8_switch_route2.out`.

## Unknown switch ON (route 2), one scratch session 08:30 to 08:41 (transcript `C:\CE_WORK\scratch\trust_install\b8_switch_on.out`; screenshots `C:\Lisp Files\_TEST_COPIES_20260923\robot_shots\session_20261115_082943\`)

1. **Switch on: confirmed** ("Settings initialized from: C:\CE_WORK\robot\b14h_switch\settings\CD_Settings.json"). Opening line as with the switch off.
2. **A bare pipe-layer line is a possible pipe and is NOT added: SEEN PASS.** A plain polyline on STORMWATER PIPE from pit P10's edge; then CDEDIT picked at that point (it took the line, not the pit): "1 line on a pipe layer was not added to CE's record: it is a possible pipe (CDCHECKCURRENT lists it)." then "[CE] CDEDIT only works on CE pits, drainage pipes and tagged sources." CE's record: 60 pipe entries before and after, otherwise identical except the format number and stored path; drawing unchanged. (Switch OFF earlier tonight on 3.0.90.7, the same kind of step printed "CE updated its record (CDEDIT): 1 pipe added. Guessed ... 100".) **Screenshot for Tim:** B8SW_possiblepipe.png.
3. **CDCHECKCURRENT: the item count went from 27 to 28** after the bare line (the possible pipe); its own list line was not captured by my filter, so the exact listing words are not yet seen.
4. **Pit Schedule (switch on):** opened; banner "Will be placed: 27 rows ... / Drawing check: 95 data issues may affect this schedule"; no "?" cells (this copy seems to have no pipe without a size, so Q7's "?" is NOT TESTED). B8SW_pitschedule.png.
5. **BLOCKED on this route (the driver refuses an AutoCAD it did not launch for save, reopen and CE-window presses):** Edit Pit Cancel with DBMOD 0 and record identical; saving and reopening; closing the Pit Schedule (so the driver's quit failed and I ended that AutoCAD, my own start; settings the same; Tim's CD_Settings.json unchanged). Also NOT RUN (no fixture built tonight): label near two pits Unknown; drawn width never a size (metre drawing); worked-out invert kept and marked; Q7 placing the schedule with "?".
