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
