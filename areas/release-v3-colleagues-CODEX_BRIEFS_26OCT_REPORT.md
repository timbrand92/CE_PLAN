# Codex briefs for the next four days: report (Mon 26 Oct 2026, written about 07:40 Melbourne)

Written by the Team job (Sonnet) with three helper writers. Briefs only: nothing was run in Codex, AutoCAD, a build or an install, and no settings file was touched. `DESK_LOG.md` and `BUG_CARPARK.md` were not edited.

## FOR TIM

1. **38 new Codex jobs are written and queued: 20 case reviews, 12 AutoCAD looks, 6 bug fixes.** Codex now reviews the robot's test cases itself. A review that passes lets the case count as Claude-accepted, so the accepted numbers can go up without you.
2. **They will not all fit.** At the costs below the queue is 144 points. Codex has about 83 points left until Fri 30 Oct 07:00 (usage is 17 now). The reviews and looks fit; the bug fixes, queued last, mostly will not. Nothing breaks: a job that does not fit is simply not started.
3. **Two settings in the desk's Codex supervisor stop the new reviews and fixes from starting. I did not change the supervisor.** It only starts reviews and builds named cx_rv or cx_bd, so the new cx_cr reviews would never start. It also holds every review and build while any AutoCAD look is still waiting, so the 12 looks (about 9 hours) would run first. The desk job that owns the supervisor needs to allow the name cx_cr, and decide whether the looks go first. This is a desk task, not yours.
4. **Only 38 of the 59 bugs that need a Codex look are covered.** 21 are left over: 10 Structural (outside the 9 Nov release), 3 metre-drawing bugs that have no test drawing, and 8 that need a drag or a setting change nobody has proven. Reasons are in `E6_E12_A2_MAP.txt` in the runner folder.
5. **The six bug fixes are all wrong-answer or lost-data bugs in everyday tools, none needs your word:** a catchment dropped when two share a name, a damaged Design draft overwritten on the next save, Survey Intake hiding the 11th suspect point onwards, a formula text that shows 0.3 beside a number worked from 0.35, Charged System accepting 150 as 150 metres, and Manager not warning that a plug-in switched off will not start next time. Each makes a draft pull request only. Nothing is merged.
6. **Nothing for you to decide now.** Review files go in the robot folder only, so the case review reports are the only thing pushed to the plan repository.

---

## Technical detail (nothing below needs your action)

**Cost numbers used (points of Codex weekly usage).** Reviews 3 each (the earlier read-only review jobs cost 2 to 3). Looks 3 each (D1 to D8 cost 0 to 5 each, the V, W and X lines say 6). Builds 8 each (earlier builds cost 8 to 12).

1. **Set 1, case reviews cx_cr01 to cx_cr20, 20 x 3 = 60.** Filler lines, model gpt-6-astra, high effort. Each is read-only, uses the method and report shape of `RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md` and `RUNNER_CASE_REVIEW_B3B_2026-10-25.md`, and writes `C:\CE_PLAN\areas\CODEX_CASE_REVIEW_<name>.md`. It checks the ledger rows, build strings, case hashes and installs itself. Only for a case it judges ready for its current hash does it write the review file in the R16 format.
   1. cx_cr01: R04, R06.
   2. cx_cr02: R09, R40.
   3. cx_cr03: R11, R12, R13.
   4. cx_cr04: R14, R18.
   5. cx_cr05: R19, R21, R22.
   6. cx_cr06: R24, R25, R26.
   7. cx_cr07: R27, R29, R30.
   8. cx_cr08: R32, R32b, R33.
   9. cx_cr09: R34, R34s.
   10. cx_cr10: R34sn, R34so, R36.
   11. cx_cr11: R36e, R37b.
   12. cx_cr12: R01, R02, R02b.
   13. cx_cr13: R03, R05, R08.
   14. cx_cr14: R07, R10.
   15. cx_cr15: R15, R16, R17.
   16. cx_cr16: R19b, R20, R23.
   17. cx_cr17: R28, R31.
   18. cx_cr18: R35, R37.
   19. cx_cr19: R38, R39, R39b.
   20. cx_cr20: any case added or changed after 07:10 today, plus a tally of the 40 daily-tool checks on the installed build.
   
   Notes: each brief carries the desk's 07:10 reading of every case (file hash, review file and whether its hash matches, ledger counts on 3.0.78). R08 was not in your list; I added it to cx_cr13 because it is an accepted case with a known fault (BUG-861). Groups are 2 to 3 cases, not 3 to 4, because only 49 cases exist. The case folder is not a git repository, so review files are local and only the reports are pushed. A case whose only passes are on an older build can still be judged ready for its text, but the report must say the installed-build count needs two more runs.
2. **Set 2, looks verifyE1_cur to verifyE12_cur, 12 x 3 = 36.** Each is a short launcher plus a full brief, in the shape of D8, with a conveyor line `...|gpt-6.1-sol|medium|90|3`. Appended to `CONVEYOR_QUEUE.txt`.
   1. E1: D3-04 copied pit seen whole; D4-04 open-file hash (read by a shared-read script, hash after QUIT as backup).
   2. E2: D5-01 renumber with the tags in view; D5-05 Recover Inverts (erases both invert texts first so labels get written).
   3. E3: D6-01 hand-placed pipe label stays put; D6-02 Tidy labels (typed handles, no crossing picks).
   4. E4: D6-03 schedule placed in parts (all four tabs read to find what enables Continue); D6-04 selection kept after CDEDIT (typed zoom window, no Zoom Object).
   5. E5: D7-04 unnamed Snap callout arrow prompt (10 m pipe, then a short pipe); D7-01 raingarden label.
   6. E6: About CE Suite (BUG-090, BUG-1087), Feedback, What's New, version agreement; A2 bugs 219 and 170.
   7. E7: CE Settings, every tab, three editor windows; A2 bug 227.
   8. E8: CDCALC windows (Boyd's, Catchments, Charged System, Print, PDF, Excel); A2 bugs 507, 596, 233, 590, 591.
   9. E9: Pit Schedule, Excel export, cell edit, long section; A2 bugs 571, 600, 601, 756, 767.
   10. E10: Manager window, look only (never Update, Install, Roll back or any administrator item); A2 bug 754; 476 marked NOT TESTED: NEEDS TIM.
   11. E11: New Pipe, Edit Pipe, New Pit, Edit Pit windows and plan labels; 13 A2 bugs.
   12. E12: ribbon, tooltips, Inspector, right-click menu, Save As after undo; 10 A2 bugs.
   
   Real on-screen words not seen in earlier reports (What's New route, Pit Schedule cell edit, CDPROFILE, some E11 controls) are written as "copy the real words and mark BLOCKED or DIFFERENT". E4 may run shorter than 55 minutes. The word follow does not appear in any brief (checked by search).
3. **Set 3, builds cx_bd09 to cx_bd14, 6 x 8 = 48.** Filler lines, gpt-6.1-sol, high. Base `origin/claude/rel-20261025r` (head d8840a09, which is the installed Civil 3.0.78 build), own worktree under `C:\ce-cx`, stop if C: has under 8 GB, unit test red then green, `REGRESSION_LOG.md` entry, draft PR, never merged or closed, fix switch ON, CE_SHARED untouched. Choices and rejected candidates are in `BD09_BD14_CHOICES.txt`. The supervisor holds a cx_bd job until C: has 14 GB free (C: has 59 GB now).
   1. cx_bd09: BUG-1113, a Blue Factor catchment sharing a name with another is dropped.
   2. cx_bd10: BUG-1143, a damaged Design draft is replaced by the next Save Draft.
   3. cx_bd11: BUG-1191, Survey Intake cannot show the 11th and later suspect points.
   4. cx_bd12: BUG-1111, the formula text says 0.3 while the number is worked from 0.35 (words only, no council number changes).
   5. cx_bd13: BUG-1103, Charged System takes sizes in metres with no sense check (adds a warning over 2 m; that limit is the one number chosen).
   6. cx_bd14: BUG-1181, Manager does not say a plug-in set to Disable on Restart will not start next time.
   
   The writer read each cause in the code at the base, and checked 600 pull requests and branches and the other cx briefs for overlap. Unverified: nothing was compiled.
4. **Cost against the plan.** 60 + 36 + 48 = 144 points of new work, plus about 9 for the three older read-only audits still queued (cx_rd23 to cx_rd25). Room: usage 17 of 100 at 07:38; the daily cap is 25 today and rises 25 a day to Fri 07:00. About 83 points of room. Over by about 70 at the stated costs. At the observed costs (reviews 2.5, looks 1.3) the reviews and looks come to about 66 and the builds to 48: still over. Expect all 20 reviews and the looks to run and about half the fixes.
5. **Files written.** Briefs in `C:\Lisp Files\_CODEX_RUNNER\`: `cx_cr01.txt` to `cx_cr20.txt`, `verifyE1_cur.txt` to `verifyE12_cur.txt` and the matching `_full.txt` files (24 files), `cx_bd09.txt` to `cx_bd14.txt`, `E6_E12_A2_MAP.txt`, `BD09_BD14_CHOICES.txt`. Queue lines appended to `desk_jobs\CONVEYOR_QUEUE.txt` (12) and `desk_jobs\FILLER_QUEUE.txt` (26). The runner folder is not a git repository, so only this report and the two queue files are pushed.
6. **Not checked.** I did not run a single brief, so none is proven to start. The conveyor builds the look id from the name (E1 to E12), the lock names are Codex-E1 and so on, and each look writes `CODEX_VERIFY_E<n>_*.md`, as the D-series do.
