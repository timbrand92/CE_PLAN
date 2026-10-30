# Next-40 pack B: robot cases for top-40 items 19 to 31 (N55 to N67), drafted Fri 30 Oct 2026 (Team Opus, CE_ACAD / robot / draft / 34)

**What this is.** A drafting job. Nothing was run in AutoCAD, no runner run, no driver call, no build. Written about 12:09 to 12:30 Melbourne (PC clock). Cases are in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_next40_b_30oct\` (28 files: 14 cases, 14 failing twins). Chain spec: `C:\ce-fx\retest\spec_next40_b.txt`. Source of facts: the installed Civil 3.0.86 code (commit 5888ee75), read only.

---

## ANSWER FIRST

1. **Written: 14 cases and 14 failing twins for the 13 items. The offline check passed all 28 files with 0 invalid.**
2. **The robot can run 8 of the 13 items fully:** N56 (two parts), N57, N58, N60, N61, N62, N64 and N67.
3. **Four items run only partly. Each needs a press-list change, a code change or a new runner verb before it can be proved whole:**
   1. **N55 long section:** the Apply button can't be pressed and the datum box has no name the robot can type into.
   2. **N59 wrong layer:** the row sits past the 20 lines CDCHECKS prints, and the window rows can't be read.
   3. **N65 and N66 one grade for several pipes:** the batch editor's fields and its Apply button are on no press list.
4. **One item can't be tested on 3.0.86:** N63 (MIRROR keeps text readable). Its switch exists, but nothing in the code uses it yet. The case is written but left out of the chain.
5. **Two of the list's plan IDs are wrong:** items 29 and 30 are really UX-PIPE-06c (one grade, Only these pipes or Carry downstream), not UX-PIPE-07 and 08.
6. **The chain is 12 "a" lines and 11 "b" lines**, at most 4 cases each. The two N56 halves must run on back-to-back lines.

---

## FOR TIM

1. **N55, long section drawn from CDPROFILE: needs a Codex look and a code change.** The robot can open the Profiles window on pit P3. It can check there is a Preview New and an Apply button and that Apply is greyed out before a preview. It can't draw the section: Apply isn't on its press list, and the Datum RL box has no name it can type into. Example: on a job, the long section block would be drawn on layer 25CONT, and one U would remove it.
2. **N56, last pipe size comes back next day: robot.** Session one draws a 300 mm pipe in the test folder. After AutoCAD restarts, New Pipe should open at 300. The case then sets 225 back so other tests aren't upset. Example: draw a DN300 on Friday, and on Monday CD offers DN300 again in the same job.
3. **N57, Tidy labels moves only CE labels: robot (Tidy switch on).** A plain text "XX" is typed on top of a CE invert text. Tidy labels must move the IL text clear and leave XX exactly where it is.
4. **N58, pipe ends join within 75 mm: robot (switch on).** A pipe started 74 mm from another pipe's free end is pulled onto it. One started 76 mm away stays a free end.
5. **N59, wrong-layer row in Checks: robot for part only, the rest needs Codex or a new runner verb.** Pit P3 is put on layer 0 and CDCHECKS is run before and after. On the standard test drawing the "P3 pit is on layer 0" row sits past the 20 rows printed on the command line. The robot records both totals but can't yet check that the "to look at" count rose by one.
6. **N60, quiet re-check after a MOVE: robot, but read the warning.** When a MOVE drags a pipe off pit P8, CE should print one line, "A pipe end left pit P8: it is now Not connected yet", and ask nothing. The bigger re-check engine in the plan is built but not connected, so a reviewer may call this item "part".
7. **N61, an ignored finding stays ignored: robot (switch on).** CDCHECKIGNORE hides finding 1 for "Engineer's judgement", and the Unignore list then shows it. BUG-866 turned out to be a different bug (CDDESIGN rainfall), so nothing blocks this case.
8. **N62, AutoCAD-style CD prompts: robot (switch on).** CD should ask "Specify next point or [Undo] <Enter to finish, 2 segments>:", in AutoCAD's own form.
9. **N63, MIRROR keeps pit text readable: cannot be tested yet.** The switch is there, but nothing uses it in 3.0.86. Running it now would only prove the gap. It's written and parked.
10. **N64, BREAK on a CE pipe then U: robot for BREAK only.** BREAK at the middle of a pipe should leave two CE pipes, and one U should put back one. TRIM, EXTEND and JOIN are not covered and need a further case or a Codex look.
11. **N65, one grade for several pipes, "Only these pipes": needs permission.** The robot can open "Edit 2 Pipes" and check that the grade box and both choices are there. It can't type the grade or press Apply until the press list is changed.
12. **N66, "Carry downstream" then U: needs the same permission as N65.** Today it covers the window half only.
13. **N67, Tidy labels Yes then one U: robot (Tidy switch on).** The P8 invert text moves clear of the spot level, and one U puts it back exactly. There is no REDO in the route, so it avoids BUG-861.

**Nothing for you to do.** One change needs a reviewer's yes before the robot can finish N65 and N66: adding the "Edit 2 Pipes" window to the robot's press list. The desk will bring it with the other press-list changes.

---

## Per-case notes (for the desk and the reviewer)

1. **N55 (`N55_cdprofile_apply_draws_section`, twin `_BROKEN`).** The route is R28's (accepted, two passes on 3.0.86) followed by a read of the Profiles window.
   1. **Window half asserted:** Preview New and Apply exist, the window does not show "Profile applied.", and nothing is drawn.
   2. **Missing:** a witness-v2 entry `*Profiles*` with press `Preview New`, `Apply`, `Cancel`, `Close`, plus set `ProfileRoutePicker`.
   3. **Code change:** the Datum RL box needs an automation name (CalculationsV2Dialog.xaml line 465).
   4. **Unknown:** whether a v2 press of Preview New returns before the insertion-point prompt.
   5. **Twin:** expects a non-existent button, "Place profile".
2. **N56a and N56b (twins `N56a_..._BROKEN` and `N56b_..._BROKEN`).** One case cannot span an AutoCAD restart, so the item is split across two runner calls.
   1. **Why it should come back:** the size returns through the per-job memory (ApplyLastJobChoice). Every runner copy lives in `C:\ce_rc_drv`, so that folder counts as one job. Tim's `options.rememberCdSettings` is false, so no SETTING line is used.
   2. **The file hash** of CD_RecentValues.json is a desk step. No runner verb hashes an arbitrary file.
   3. **Missing verb if the desk wants it automated:** `file-hash <path> -> $h` limited to the TIM_CE_CADTOOLS folder.
   4. **Risks:**
      1. Another tester drawing a pipe in `C:\ce_rc_drv` between aN1 and aN2 spoils the check.
      2. A 300 mm pipe at 1 in 200 might open the Grade mismatch window (DERIVED: it should not).
      3. The control value might read "300.0".
   5. **Twins:** both are wrong expectations (375 mm).
3. **N57 (twin `_BROKEN`).**
   1. **Route:** SETUP-R47 and R16's zoom; a plain TEXT is typed with `_S Standard` at the IL 18.000 insertion point, then N27's Tidy chain.
   2. **DERIVED:** that XX alone makes the IL text "would move" (R16 used the SPOT LEVEL block instead).
   3. **Twin:** claims XX moved.
4. **N58 (twin `_BROKEN`).**
   1. **Pattern:** N23's (snaps off, zoom, 1 mm tolerances), on three free pipes 10 m from any pit, each 10 m long after any join so the fall stays 1 in 200.
   2. **Switch key** is lower case: `linking.autoJoinPipeEnds`.
   3. **DERIVED:** the box corners, End is free = 5, Flow = 3.
   4. **Twin:** a wrong expectation (2 joins), not the switch off. With the switch off, pipe B would be 9926 mm long and the Grade mismatch window would block a step.
5. **N59 (twin `_BROKEN`).**
   1. **The read route was checked first:** run 45 report lines 11 and 53-54.
   2. **Corrections to the brief:** CDCHECK never prints this row, only CDCHECKS does, and that needs `checks.checksCommandEnabled` on as well. The rule checks pits only.
   3. **Missing verb, exact:** a step that captures a number from a line, for example `extract $ck1 "Checks: (\d+) to look at" -> $n1`, so that `number $n2 > $n1` can be checked.
   4. **Twin:** claims "Checks: 0 to look at".
6. **N60 (twin `_BROKEN`).**
   1. **Warning:** the plan's re-check engine (PipeEndOffPitRecorder, switch `checks.recordPipeEndsOffPit`) has no caller in 3.0.86. This case proves the link watcher's one-line re-check only.
   2. **DERIVED:** that "left pit P8" prints on this route. The source has a second route that only logs a receipt; if that route runs, the twin would pass, so check the twin's result.
7. **N61 (twin `_BROKEN`).**
   1. **BUG-866 split:** BUG_CARPARK lines 11837-11839. The Undo half is now BUG-CDCHECKIGNORE-UNDO-C60 (fix PR #1524 installed, not yet accepted in AutoCAD). It is NOT driven here.
   2. **"Until something changes"** is not driven: the subject of finding 1 is not known before the run.
   3. **Twin:** expects reason Survey.
8. **N62 (twin `_BROKEN`).**
   1. **Route:** N07's (two passes on 3.0.86 with this switch on), with only the one switch.
   2. **DERIVED:** "Last point taken back." without the second switch.
   3. **Twin:** expects the old wording.
9. **N63 (twin `_BROKEN`), NOT queued.**
   1. **Why:** the code says the ROTATE/MIRROR hook is not built (UserSettings.cs line 1155, ReadableTextRule.cs line 16). This item is class 4, not class 1.
   2. **Key:** `linking.keepTextReadableAfterRotateMirror` is a different key from R34's `cleanUpGripRotateScaleCopies`.
10. **N64 (twin `_BROKEN`).**
    1. **Covers:** BREAK and U only.
    2. **DERIVED:** that both pieces stay CE pipe objects. The code treats the second piece as a new pipe.
    3. **Not covered:** TRIM, EXTEND and JOIN (JOIN may be refused without a proven merge).
    4. **Twin:** claims two pipes after U.
11. **N65 and N66 (twins `_BROKEN`).**
    1. **Window:** `Creative Engineering | Edit 2 Pipes`, opened by picking two pipes and typing CDEDIT (R20's route).
    2. **Pipes:** N65 picks 10A98D and 109E23 (consecutive through P3); N66 picks 10A98D and 10A901 (both into P3).
    3. **Missing permission, exact:**
       1. One witness-v2 window entry, `Creative Engineering | Edit * Pipes`.
       2. Press `Apply to Selected` and `Cancel`.
       3. Set `Change Design grade`, `New Design grade`, `Only these pipes` and `Carry downstream`.
       4. Re-pin `V2AllowListPinnedSha256` (acad_driver_witness_v2.ps1) and `V2AllowExpectedSha` (acad_driver_v3.ps1).
       5. The N66 header lists the exact steps to add once that change is made.
    4. **Twins:** a wrong control name, and a wrong "3 pipes".
12. **N67 (twin `_BROKEN`).**
    1. **Route:** R16's route, then N27's Yes chain, then U.
    2. **REDO:** none, because of BUG-861.
    3. **DERIVED:** "Moved 1", the completed outcome line, and the U echo.
    4. **Twin:** claims the text is still moved after U.

## Chain spec notes

1. **Format:** the same as `spec_gap_cases_ordered.txt`: `tag|folder|only`. The "a" lines carry the twins once; the "b" lines repeat without twins. Each line has 4 cases or fewer, so about 22 minutes or less.
2. **Same switches together:** each line holds cases with the same SETTING lines.
3. **Matching was checked offline:** the runner's own `-Only` matching rule, run on the folder, picks exactly the intended files for all 23 lines.
4. **Order rules:**
   1. aN1 (N56a) and aN2 (N56b) must be consecutive.
   2. aN3 (N56a twin) leaves 300 mm as the job's last size, so aN4 (which holds N56b's twin, the one that sets 225 back) must follow it.
   3. bN1 and bN2 must be consecutive, for the same reason as aN1 and aN2.
5. **Timing:** run the counted passes on 3.0.87 after the C-77 install, as the list says.

## What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** Every line marked DERIVED in a case has never been seen. One AutoCAD process was already running on the PC while I worked; validate did not start it.
2. **The window control names are worked out from the code, not from a dump:** N55's buttons, and N65/N66's grade box and choices. Nobody has dumped those windows on 3.0.86.
3. **The source facts came from four read-only helper searches of commit 5888ee75.** I spot-checked these myself:
   1. The rememberCdSettings key and its default.
   2. That Tim's settings file holds autoJoinPipeEnds false and autoCadStyleCdPrompts false.
   3. The v3 press list (Apply is a never-press button).
   4. The v2 window lists.

   I did not re-read every quoted line number.
4. **Not checked against the runner:** whether "history" includes the setup's own lines in the N58 counts. N58 uses no setup, so this does not affect it.
5. **N59's row count rising by one is recorded, not checked.** N61's "until something changes" is not driven.
6. **No existing case, runner, driver, ledger, acceptance ledger, BUG_CARPARK or DESK_LOG file was edited.**
