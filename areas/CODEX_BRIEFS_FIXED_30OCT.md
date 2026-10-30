# Corrected Codex look briefs for the blocked looks — Fri 30 Oct 2026

Job CE_ACAD / robot / draft / 36, written 12:10 to 12:40 Melbourne by the Opus desk assistant. Drafting only:
no AutoCAD, no runner, no driver call, no build. Spec: `CODEX_BLOCKED_ANALYSIS_30OCT.md` (read in full).

**ANSWER:** eight briefs are written and ready for CE 02 to queue: seven corrected (b) briefs and one new one.
Each fixes the blocker the analysis named. All of them now use the AutoCAD driver for commands and readings
instead of Codex typing at the command line. None has been run yet, so none is proven.

## FOR TIM

1. **What happened this morning.** Codex ran 17 looks. Ten were spoiled by how the test was run, not by CE.
   The main cause: Codex typed into AutoCAD's command line too early. AutoCAD pasted or swapped the text.
   One example: in A1 it ran an AutoCAD command called COMMANDMACROSCLOSE instead of the reading.

2. **The fix in one line.** The robot's own driver now types every command and reading for Codex.
   Codex only looks, clicks inside CE windows, and takes screenshots.
   Each look now fits one session of 15 to 20 minutes, on copies only.

3. **verifyA1b_c86: About window and the Undo check (15 min).** Draws a circle, opens CE_VERSION, closes it, presses U.
   Right looks like: U takes back the circle, not the About window (BUG-1086).
   It also re-checks the About window shows all five version rows (BUG-090). Removes: the typed reading that ran the wrong command.

4. **verifyH1b_c85: CDCALC Catchments on a new job (15 to 20 min).** Right looks like: an empty catchment list and a 1 in 5, 5-minute storm (BUG-1101).
   Wrong looks like: a ready-made "C1, 500 m2" catchment you never typed.
   Removes: the reading that got pasted into the drawing. The 300 mm head-loss part is left out: that change is not built yet.

5. **verifyH5b_c85: Glen Eira council from a rating report (15 to 20 min).** Right looks like: the Design checklist says "The council and its rules: Set" (BUG-1106).
   Removes: the old brief asked Codex to press "Work out design", which stays greyed out on purpose until everything is filled in.
   The brief now judges the checklist on the window instead.

6. **verifyH4b_c85: Drawing Repair wording (15 to 20 min).** Draws one pipe, breaks one label link, presses Fix it once.
   Right looks like: "Items fixed: 1" and never "Nothing has been changed" (BUG-1180).
   Removes: the blank cover-level box. No pit is made now; the driver draws the pipe and fills its two levels.

7. **verifyH6b_c85: CE Tools tab at start-up (15 min).** Right looks like: one CE Tools tab with Manager, Version and Health within 20 seconds (BUG-1206).
   Removes: the drawing never opened, so there was no ribbon to time.
   The clock now starts only once the drawing is open, and the driver opens it if AutoCAD sits empty for 60 seconds.

8. **verifyG6b_c84: a copied pit (15 min).** Right looks like: a whole second pit, numbered P8, with its cover text and a "check levels" warning.
   Removes: the cover text was cut off the top of the screen.
   The view is now 9000 high and centred 1000 below the copy, so there is three times the room above it.

9. **verifyC1b_c86: no blue, part 1 (20 min).** The ribbon pictures plus the New Pit, New Pipe, Edit Pipe and CE Manager windows, each opened and cancelled.
   Wrong looks like: a blue button, blue row or blue ribbon picture anywhere.
   Removes: the typing fault. The old 60 to 80 minute look is split in two to fit 20 minutes.

10. **verifyH9_c86 (new): no blue, part 2 (20 min).** The Calculations window and the computations sheet printed to a PDF.
    Right looks like: letterhead, title and headings all in black on white.
    This is the old C1 PDF half, moved to its own session.

11. **H2 (Help, Feedback page): nothing to run.** The robot cannot click inside the Help window, so I read the installed help file instead.
    It says Send report saves a copy on this PC and tries the office folder in the same step; if that fails, email the file.
    "Save report" appears nowhere in the installed files: BUG-1215's words are fixed, only the on-screen look is unchecked.

12. **One thing to know.** At 12:15 another robot run had one of your Civil settings changed for a test (its safety record was present).
    I touched nothing. The briefs say a changed setting at the start is a note, never a stop.

---

## Queue lines, in the order to run (CE 02 queues them; this job edited no queue file)

A1b goes first because it is the cheapest proof that the new driver route works for Codex. The pilot-critical
looks come next, then the polish looks.

1. `verifyA1b_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
2. `verifyH1b_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
3. `verifyH5b_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
4. `verifyH4b_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
5. `verifyH6b_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
6. `verifyG6b_c84|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
7. `verifyC1b_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
8. `verifyH9_c86|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`

If A1b comes back with driver refusals (its report lists them under "DRIVER CALLS"), hold the rest and fix D1 to D12 first.

## What changed in every brief

1. **Files.** `C:\Lisp Files\_CODEX_RUNNER\<name>.txt` (launcher, 2.6 KB) and `<name>_full.txt` (29 to 35 KB), plain ASCII,
   Unix line ends, the same as the 29 Oct briefs. Nothing existing was overwritten (the writer refused existing names).
   Lock names from the launcher rule (`launch_codex_retry.ps1` LockName): Codex-A1b, H1b, H5b, H4b, H6b, G6b, C1b, H9.
2. **N1 to N17 copied word for word** from `verifyA1_c86_full.txt`. Only N14's build sentence changed: "The installed
   build at 30 Oct 12:15 is Civil 3.0.86 and Manager 1.1.86 (Structural 1.0.125; commit 5888ee75)". Checked by diff:
   exactly that one line differs in each of the eight.
3. **New block D1 to D12, the driver rules.** They win over N2, N8, N17, change (d) and shared 2.6, 5.4, 5.9 and 9.2.
   1. Verbs allowed: lock, settings-temp status, status, getvar, history, type, pick-first, and (only where a step names them) ui set and esc-prompt; restore at the end. Never launch, quit, setvar, cancel, ui press or click.
   2. Readings: `getvar` for system variables (no undo step), `history 15` for the command line (no TEXTSCR or GRAPHSCR any more), and LISP readings only from a file with `type -InputFile ... -AllowLisp`.
   3. Commands: one `type` call carrying the whole command and its answers, using the robot's proven strings (CD and PIT from cases R31 and N05, COPY from N16).
   4. Refusal = copy the words, never retry, then one careful hand-typing fallback (analysis item 18.2: wait for CE Tools plus "Command:" plus 20 seconds, click inside the text, screenshot before Enter, never Enter on a suggestion box).
   5. Yes/No questions that are already open are answered by hand (the untagged question, CDDESIGN's job question): the 30 Oct faults all happened at "Command:".
   6. Clean end: SAVETIME back by driver, `restore` (puts AutoCAD's log switch back), close AutoCAD with its X, no typed QUIT.
   7. Cap 40 driver calls; START CHECK no longer reads TRUSTEDPATHS (the driver refuses that word).
4. **Shared changes (a) to (i).** (a) also ignores a START line older than 3 hours with no AutoCAD running (analysis item 1).
   (i) holds every session to 15 to 20 minutes, no new look after 25 minutes.
5. **Every look** now says what to screenshot and what PASS, FAIL and DIFFERENT look like on a drafter's job.
6. **The word that caused stray typed text (BUG-421)** appears in none of the 16 files (checked by the writer script and by grep afterwards).
7. **Fixtures.** No saved drawing with P8 and its pipe exists on this PC (searched `C:\ce_rc_drv` and
   `C:\Lisp Files\_TEST_COPIES_20260923` at 12:20). So H4b draws a pipe with no pits in empty ground, which needs no
   New Pit window. Every brief copies its fixture into its own evidence folder under `_TEST_COPIES_20260923`, never Tim's files.

## Per-brief detail for the desk

1. **A1b.** One chain: CIRCLE, CE_VERSION (`-NoWait`: the About window is not on the driver's window list), Close by pixel,
   getvar only, then U and REDO by driver. The 08:42 "BUG-1086 NOT SEEN" is written as VOID. The 150 percent half is
   left out (analysis item 14 prefers an automated render test). The job text said "BUG-1090 About checks"; BUG-1090
   is the hydraulic grade line row, so I took it to mean BUG-1086 and BUG-090, the two About-window bugs A1 owes.
2. **H1b.** H1-01 only. H1-02 dropped and written as one NOT IN THIS BRIEF line: 3.0.86 still compares the typed head.
3. **H5b.** Same synthetic PDF fixture as H5 (H5's copy was read by CE: "Council set to Glen Eira"). Never presses Work out design.
   Judges the checklist row and the Setup tab. Lines hidden behind the window are read with `history` after Close.
4. **H4b.** Inverts 18.000 and 17.900 over 20 m (exactly 1 in 200), so no Grade mismatch window is expected.
   Three LISP readings remain (text near the pipe, owner read, owner remove), all sent from files by the driver.
5. **H6b.** The one brief allowed `D2 open`, once, if AutoCAD shows no drawing 60 seconds after the start.
6. **G6b.** No LISP at all; the numbers are left to the robot's N16 and R34a.
7. **C1b.** No object counts typed; `history` shows whether a pit or pipe was placed after Cancel.
8. **H9.** Never presses Export to XLSX (BUG-1255 crashes it on AutoCAD 2027). The only hand typing is the PDF file name in the Windows save box.

## What I did NOT verify

1. **No brief has run.** Built only; nothing tested in AutoCAD.
2. **The driver has never been used by Codex for these verbs.** It has only been proven for the Claude robot, and always on an AutoCAD the driver itself launched.
   Here Codex starts AutoCAD through explorer.exe. I read the driver source: `getvar`, `type`, `history`, `pick-first`, `status` and `restore`
   check only that the open drawing is under `_TEST_COPIES*`, not who launched it. But `ui set` (H4b), `esc-prompt` (H4b, C1b) and `open` (H6b) are not proven
   in that situation. Each has a refusal path in the brief.
3. **`-NoWait` with a window that is not on the driver's list** (CE_VERSION in A1b, CDDESIGN in H5b) is unproven: the call may return while AutoCAD stays busy.
4. **`type "SAVETIME`n0"`** is unproven. The word SAVETIME is not on the driver's deny list; that is all I checked.
5. **A typed LISP line once froze AutoCAD** in a Claude run (22 Oct). H4b still needs three LISP readings; D6 says stop and go to the clean end if one hangs.
6. **G6b's view and the fading command history** are desk arithmetic from the 30 Oct screenshots, not seen on screen.
7. **No offline validate was run.** `case_runner.ps1 validate` checks runner case files, and this job wrote none.
8. **The other runner's live settings change** (guard file present, CD_Settings.json written 12:13) was seen, not investigated.
