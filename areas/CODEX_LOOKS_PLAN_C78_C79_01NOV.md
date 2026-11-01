# Codex looks: what, when, who lifts the stop (CE 02, Sun 1 Nov 2026, for CE 00)

## ANSWER FIRST

1. **Three batches, each one Codex session that covers several PRs:** batch A today (Sun 1 Nov, 13:00 to 17:00, on the installed 3.0.88), batch B on the C-79a build (Tue 3 Nov, 09:00 to 13:00, or Tue 17:45 onwards if you keep the Mon/Tue rule), batch C on the C-79b1 build (Wed 4 Nov, 19:00 to 22:00, with Thu 5 Nov 05:30 to 08:20 as the spare window).
2. **The C-79b1 looks cannot run before Wed 4 Nov evening.** All seven need the PR code, which only the C-79b1 build holds. The C-79a build shares no screen with them. Only the batch C looks are tied to the b1 install; A and B are earlier.
3. **Who lifts STOP_CODEX:** I do, one batch at a time, only after your written GO for that batch. I put it back up the moment the batch's reports are in or the window ends, whichever is first, and log both times in the ledger.
4. **Codex meter:** I cannot read it. I need your reading (USAGE.json: 27 percent at Sat 01:14) before and after each batch. My estimate is about 10 percent for A, 12 for B and 15 for C, about 37 percent in all, so about 64 percent by Wed night. That estimate comes from my old rule of about 7 percent per test run; please correct it with the real figure.

## Batch A: Sun 1 Nov, 13:00 to 17:00, on Civil 3.0.88 / Structural 1.0.125 (installed)

Looks that only need what is already installed (the combined look):
1. **K1 Excel** (the export opens and reads right).
2. **Structural BUG-467 and BUG-472** (brief: `desk_jobs\CODEX_LOOK_STRUC_467_472_30OCT.txt`, incl. the clicked second point).
3. **N20 leader label** and the **Grade mismatch box** wording; the **RG label** (plain RG, not numbered).
4. **N33 family, what must be SEEN:** the Grade mismatch window text and the Cancel line.
That is about 4 looks in one session (AutoCAD on a test copy only).

## Batch B: Tue 3 Nov on the C-79a build (installs Mon evening or Tue; if it slips, B slips)

From the C-79a finalizer report (the 7 real looks; item 7 stays parked by decision 181):
1. **Civil screens, one session:** #1857 (New Pipe "630,5" sentence and the two Settings rows), #1875 (Drafting tab row fits at the 670 px limit), #1962 (Inspector Grade line in red at 1 in 235), the CDRULES window answers (#1949 WARN line, #1887 red uphill line, #1857 office-figure speed line).
2. **Drawing looks, same session:** #1888 (CDTEXTSEG in a UCS turned 45 degrees: the label lies along the pipe), #1926 (X-Civil import: CHECK THE SCALE leads).
3. **Manager, a short second session:** #1876, #1936, #1935 (Updates & Rollback, Refresh line, start-up line).
4. **Parked, not in B:** #1957 and #1959 (AutoCAD 2022 to 2024 only; Max is 2027).

## Batch C: Wed 4 Nov 19:00 to 22:00 on the C-79b1 build (spare: Thu 5 Nov 05:30 to 08:20)

The 7 real looks (4 more PRs are settled by the reviewer's logic evidence: #1868, #1943, #1958, #1970), grouped into two sessions:
1. **Civil Hub screen, one session:** #1940 (damaged outlet roles: one warning, the kept copy, Apply carries on) and #1945 (CDDESIGN warns once when approved under another file path). #1943 is settled by logic evidence, but if the Hub is open anyway a glance is free.
2. **Drawing edits, one session:** #1972 (the question comes AFTER the Edit Pipe change is accepted), #1892 (after MOVE of pit P2 its pipe end follows the pit; pit P3 is not dragged), #1950 (older twin detention pipe upgrade: needs an older drawing; if none, parked), #1923 (only if its shipped default is OFF; Tim 22 Oct).
3. **#1969** (comma-decimal PC) cannot run on this PC: parked for Tim's other PC or a Windows regional switch he approves.

## Rules each batch follows

1. **Window:** weekend any hour; Mon 2 and Tue 3 only before 08:30 or after 17:30. I read Tue 3 Nov (Cup Day) as a free day, as CE 01 did; if you read your own rule strictly, B moves to Tue 17:45.
2. **Before a batch:** your GO line; AutoCAD not running (checked twice); no human input for 10 minutes; Tim's real settings back to the 4 Oct copy (my check). The brief for each batch is built from the lists above and the PR text, with the word "follow" kept out (BUG-421).
3. **During:** `STOP_CODEX.flag` removed by me; the robot lane holds (one AutoCAD at a time); the Codex runner at `C:\Lisp Files\_CODEX_RUNNER`.
4. **After:** the flag goes back up, the Codex logs are copied to a safe place (a test run once truncated a live log), results written into the ledger as PASS / FAIL / BLOCKED / NOT TESTED per look. Nothing counts as accepted until the pilot rule's conditions are met (the robot proof plus, for the SEEN part, a Codex PASS; audit sample 1 in 10).
5. **Meter:** your reading before and after each batch, written beside the result.

## Added Sun 1 Nov 16:55 (CE 00 request): look K1-02b for BUG-1268 (CDCALC Export to XLSX), on the build that carries the fix

1. **Why:** K1-02 FAILED on 3.0.88 (the CDCALC Save As closed, no file on disk). CE 05's root cause is in `areas\ROOTCAUSE_BUG1268_CDCALC_XLSX_01NOV.md`; a fix with a switch is approved. This look proves the fix by sight and by file.
2. **Steps for Codex (one AutoCAD session, test copy):** (a) CDCALC, Export to XLSX, type the FULL path of a file in the look's own evidence folder, Save: the file must exist on disk, be non-empty, open in Excel with its sheets, the status line must name it, and the CE log must carry the new line. (b) Cancel in the same box: no file, no error box, a "cancelled" log line. (c) A bad folder: a plain error box. (d) The switch OFF reproduces the old failure only if CE 00 sets the GO flag, as for K1-04.
3. **Where it goes:** the first Codex batch after the build with the BUG-1268 fix is installed (batch B or C, or a small batch of its own), under a separate written GO from CE 00. The brief is written when the fix build exists, from verifyK1_c88 (K1-02 is its parent step) and the root-cause note.

## Added Sun 1 Nov 18:20 (CE 00 18:00): W234 goes to batch C

1. **W234 (wave 1, BUG-234: a flat pipe MOVEd onto two pits records the right pit pair)** is a CODEX LOOK for batch C (Wed 4 Nov 19:00), not a robot proof. The robot case W234 is marked BLOCKED and is NOT counted (one pass of its own before the block); W234_BROKEN stays out of the reruns.
2. **Diagnosis (probe PROBE-W234, 17:37):** after Start Pipe on the flat pipe CE opens 'Creative Engineering | Design Warnings' (14 controls). The driver cannot press it: v2 ui2-press times out (HARD TIMEOUT), v3's press list is pinned and has no such window. A new pressed window would be a change to the test tooling and is Tim's call (CE 00 will put it to him later, optional).
3. **What Codex must do:** place the two pits, draw the flat pipe (the same levels at both ends), press OK on Design Warnings, MOVE the pipe onto the other two pits and read that the flow line records the pit pair named in the case (steps and expected words are in cases\drafts_wave1_31oct\W234_flat_pipe_moved_onto_other_pits.case.txt).

## Added Sun 1 Nov 21:3x (CE 00): decision 186 and W234

1. Tim said yes to item 118 (robot may press OK on the Design Warnings box). Decision 186, decisions/2026-10-29_TIM_ANSWERS.md.
2. Timing is unchanged: no driver or allow-list edit before the 9 Nov release. After it, one reviewed edit (title 'Design Warnings*', button 'OK', pin updated, new fingerprints reported) goes to CE 00 for review first.
3. Until then W234 stays a Codex look in batch C (Wed 4 Nov 19:00).
