# Codex looks D1 to D8: the daily tools, for acceptance (Sat 24 Oct 2026)

Written Sat 24 Oct 2026 about 05:45 Melbourne by the brief writer for the desk (plan/03, Sonnet). Briefs only: nothing here ran Codex, a build or AutoCAD.

## ANSWER FIRST

1. **Eight Codex looks are written and queued.** D1 to D8 cover all 30 daily tools (D01 to D30 of `DAILY_TOOLS_TEST_CASES_2026-10-23.md`) and the eight tools the gap plan names (PIT, CD, Edit Pipe cascade with U and REDO, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts, Tidy labels names the pipe), plus the About CE Suite look that runner case R06 still needs.
2. **Each look is one Codex session** of 50 to 70 minutes on the installed build, run back to back (about 1 point each: queue cost 1, cap 90). Lines are in `C:\CE_PLAN\desk_jobs\CONVEYOR_QUEUE.txt`.
3. **The "_cur" rule:** each brief reads the installed DLL versions live. A different version is information, never a stop.
4. **Each brief asks only what the drafter must SEE** (a window, a picture, a label position, a preview). The drawing values and log lines the runner already reads (cases R01 to R04, R11 to R20) are listed in a short "already covered" note and not repeated.
5. **Two briefs use ONE settings pass:** D6 (three keys: Tidy labels on, hand-placed labels stay, 5 rows per sheet) and D8 (two keys: the CD prompt style and the Undid sentence). The other six call the guard never.

## Files (all in `C:\Lisp Files\_CODEX_RUNNER`)

Each look has a launcher `verifyDn_cur.txt` (about 2.1 KB) and a full brief `verifyDn_cur_full.txt` (20.9 to 24.5 KB, under 25 KB). Look id Dn, model gpt-6.1-sol, effort medium, cap 90. The shared rules file is `lookCOMMON_full.txt`.

## What each look covers

1. **D1: PIT and CD.** Fixture DRV1_B1. Looks:
   1. **D1-01 PIT:** the New Pit window, pit number and "CL 19.000" text (D09), two pits in one run (D01 pit half), one U takes the last.
   2. **D1-02 CD:** the New Pipe window, pipe joins its pit with the flow arrow (D03), next pipe asked for (D01 pipe half), one U.
   3. **D1-03:** pipe end caught within the pit outline plus 100 mm, or left free (D02).
   4. **D1-04:** Esc at the third point throws the pipe away (D04).
2. **D2: the New Pipe window and its texts.** DRV1_B1. D2-01 Recent buttons (D05), D2-02 grade toggle (D06), D2-03 label mid-pipe and readable (D10), D2-04 short pipe on a leader (D11), D2-05 one IL text at each end (D12).
3. **D3: edits.** DRV1_B1. D3-01 Edit Pipe cascade with U and REDO (the named tool), D3-02 quick MOVE of a pit, D3-03 erase a pit (D14), D3-04 copy a pit (D15), D3-05 explode a pit (D16).
4. **D4: repair and list.** DRV1_B1. D4-01 CDSYNC warns and keeps the Pit Schedule (named tool, D27 first half), D4-02 CDREBUILD (D27 second half), D4-03 schedule in number order (D21), D4-04 CE never saves the drawing (D18).
5. **D5: number, level, export.** DRV1_B1. D5-01 CDRENUMBER (D20), D5-02 CDSL spot level (D26), D5-03 Excel export with a Checking sheet (D23), D5-04 the run 47 context (setup), D5-05 Recover Inverts (named tool), D5-06 CDTWL freeboard and its pick list (named tool, BUG-1032 old fault reported).
6. **D6: switch-on tools (one settings pass).** DRV1_B1. D6-01 a hand-moved label stays (D13), D6-02 Tidy labels names the pipe, Esc moves nothing, Yes lands clear (named tool; BUG-1034 sighting reported), D6-03 the drawn Pit Schedule continues below at 5 rows (D22), D6-04 CDEDIT keeps the selection (D17).
7. **D7: a new drawing.** BLANK_TARGET_VC7. D7-01 downpipe and raingarden before any pipe (D07), D7-02 overflow and front overflow (D08), D7-03 existing pipe look, item verdict NOT INSTALLED (D25), D7-04 office layers and CLAYER unchanged (D24).
8. **D8: around the edges (one settings pass).** DRV1_B1. D8-01 About CE Suite (runner case R06), D8-02 CDCHECKDWG (D28), D8-03 CDFEEDBACK Part A only (D29), D8-04 Pipe and Pit ribbon tabs (D30), D8-05 what U undoes and the Undid sentence with switches on (D19).

## Daily tools not covered by any Codex look

1. **None of D01 to D30 is left out.** The gap plan's "40" is the 8 named tools plus the 30; D1 to D8 hold all of them.
2. **Part not tested by design:** D29 Part B (Send report on the spare Windows login) needs Tim's yes. D21 refinement (P1A, SPS2 before SPS10) is off. D25 greyed and demolished pits are not built.

## Lessons applied from the W and X ledgers

1. **No typed zoom between an action and its U.** The view is set once before the action in every look that ends with U.
2. **Exact modal windows named** (New Pit, New Pipe, Edit Pipe, Cascade Preview, Pit Schedule, About CE Suite, Feedback, Check consultant drawing results), with the box answers.
3. **Readable size:** typed zooms with pixel-per-unit figures; under 20 pixels is NOT TESTED: UNREADABLE.
4. **Explorer start route:** `explorer.exe "<dwg>"` (rule N13).
5. **Plural Tidy question** ("Move these 2 labels now?") allowed (X9-03 lesson).
6. **Right handles:** 10A98D is the P4 to P3 pipe; 10B03B is P6 to P5.
7. **The report's first line** says AUTOCAD CLOSED or AUTOCAD STILL RUNNING.
8. **The verb that was typed into AutoCAD as stray text (BUG-421)** appears in no brief (searched in all 16 files).

## What was NOT checked

1. **No brief was run.** Prompt wording was read from the source and the robot and Codex reports on 3.0.70 to 3.0.72; the real words win and a difference is DIFFERENT, not FAIL.
2. **Route unproven in AutoCAD:** CDREBUILD, CDRG typed points, OF and FO, the Existing Pipe selector, the Recent buttons, the drawn schedule's "Continue to Place / update", the mouse picks for the ribbon tabs, the Excel Save dialog.
3. **The settings guard taking a number and a nested key** (pit.scheduleRowsPerSheet 5, options.cdCommandLine.sayWhatWasUndone) is unproven; the briefs say BLOCKED (setting could not be changed) if it refuses.
4. **Runner case review edits** (RUNNER_CASE_REVIEW_2026-10-24.md) are not part of this job.
