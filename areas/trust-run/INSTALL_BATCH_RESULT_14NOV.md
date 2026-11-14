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

1. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_LPD14_L2_20261114_1618.md`, evidence `LOOKS\LPD14_L2_20261114_1618\` (37 screenshots, driver call log). Build read by Codex at start and end: Civil 3.0.90.3+11c0093c, Manager 1.1.89, Structural 1.0.126.1. Settings unchanged; AutoCAD closed; lock released.
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

1. Reports `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_MIX14_M2_20261114_1635.md` (PASS 3, DIFFERENT 1, NOT TESTED 4) and `CODEX_VERIFY_MIX14_M3_20261114_1651.md` (PASS 1, SEEN 3, NOT TESTED 4); evidence folders `LOOKS\MIX14_M2_20261114_1635\` and `LOOKS\MIX14_M3_20261114_1651\`. No FAIL in either.
2. Run M3's driver log: 12 record readings, 8 name `DWG-A_PASS8.dwg` (drawing B, at the start and after M-03 Help, M-04 Settings, M-05 tab switch then Help) and 4 name `CLDTP_MIX14_A.dwg` (drawing A, at M-01 and M-06); none of B's readings names A's file.
3. Desk read of B's saved copy (my own AutoCAD, 17:00): DBMOD 0, 1,285 objects, record 37,921 characters, path `DWG-A_PASS8.dwg`, 2 pits, 46 pipes, version 2.2.
4. The first attempt (run M1, 16:32) did not start: my launcher text still said "one test copy" and "no Settings window"; fixed.
