# Codex look briefs H1 to H6: the six pilot-critical window bugs (Thu 29 Oct 2026)

Written Thu 29 Oct 2026, 11:12 to 11:40 Melbourne (PC clock), by the Opus desk assistant, headless Team job "CE_ACAD / robot / draft / 15". Codex weekly use 13 percent (read 11:26); today's cap 16 percent until 17:53. I started nothing: no AutoCAD, no Codex, no conveyor, no job. Your AutoCAD (started 09:14) was open the whole time and was not touched. No existing brief, case, runner file, ledger, DESK_LOG or BUG_CARPARK entry was edited. The briefs live outside CE_PLAN and stay uncommitted.

## ANSWER FIRST

### FOR TIM

1. **My mistakes first.** One small change from the job's instruction: it said "the rest on Friday", but four looks plus the two G looks would go over Friday's limit. So 3 run Friday and the last one (the ribbon) runs Saturday.
2. **What this is.** The pilot test list has 6 bugs that need someone to look at a CE window. The robot can't read those windows. Codex can: it opens AutoCAD on test copies and takes screenshots. I wrote one "look" for each.
3. **The six looks, in the order they run:**
   1. **H1, Thursday evening: CDCALC.**
      1. **What it looks at:** on a new job, the Catchments tab should open with an empty list and a 5-minute storm. The old version showed a made-up 500 m2 catchment with a 15-minute storm.
      2. **What it can close:** BUG-1101.
      3. **What it leaves to you:** in the Charged System tab it types heads of 0.25, 0.40, 0.30 and 0.84 m and copies exactly what the warning says. For example, 0.40 m typed with about 0.22 m of pipe losses leaves about 0.18 m. That is over 300 mm if the rule means the head you type, and under 300 mm if it means the head left after losses. It judges nothing. **BUG-1097 still needs your word on which head the 300 mm rule means.**
   2. **H2, Thursday evening: Help.** The Feedback help page should say "Send report" (which sends to the office straight away), not a "Save report" step that doesn't exist. **Closes BUG-1215.** Nothing left for you.
   3. **H3, Friday evening: Pit Schedule export.** Press Export CSV, then Cancel, then the same for Excel. Check that CE wrote nothing into the drawing. **Closes BUG-1198.** Nothing left for you.
   4. **H4, Friday evening: Manager, Drawing Repair.** On a test copy, Codex breaks one pipe label's link to its pipe, then presses Fix it. The page must no longer say "Nothing has been changed" after it has changed the drawing. **Closes BUG-1180.** Nothing left for you.
   5. **H5, Friday evening: CDDESIGN and a Glen Eira rating report.** Codex makes a fake one-page STORM report for "Glen Eira". The design must then actually use Glen Eira's rules, not say the council is still missing. **Closes BUG-1106.** Nothing left for you.
   6. **H6, Saturday evening: the CE Tools ribbon tab.** In the first minute after AutoCAD starts, there should be one CE Tools tab with its Manager, Version and Health buttons.
      1. **The limit:** this covers only half of BUG-1206. The other half needs the Manager plug-in to load before Civil, and AutoCAD picks the load order itself. Forcing it would mean touching your live install, which a look must never do.
      2. **What finishes it:** a spare Windows login.
4. **Best case: 5 of the 60 pilot-critical bugs close** (BUG-1101, 1215, 1198, 1180 and 1106), plus half of BUG-1206.
   1. **The catch:** H4 and H5 each build their own test material from the program code. If that material doesn't work, the look reports BLOCKED. It never guesses.
5. **Cost, as a share of Codex's weekly limit.** Planned at 3 percent per look (the last looks used 0 to 2 percent each).
   1. **Thursday:** 6 percent, about 28 of 30 with the G looks.
   2. **Friday:** 9 percent, about 43 of 44.
   3. **Saturday:** 3 percent, about 46 of 58.
6. **What you need to do: nothing.** All six are on hold in the queue. The desk releases them after 17:53 on each day.

---

### For the desk

1. **Files written (12), all new, in `C:\Lisp Files\_CODEX_RUNNER\` (not a git repository, so uncommitted).** I listed the folder first: no `verifyH*` file existed.
   1. **Launchers:** `verifyH1_c85.txt` to `verifyH6_c85.txt`. Each one is the G4 launcher with only these changes: the look id, the description, the expected build (Civil 3.0.85 / Manager 1.1.85), the brief name, and one sentence naming what the look may change.
   2. **Full briefs:** `verifyH1_c85_full.txt` to `verifyH6_c85_full.txt`. They have the G-series structure: header; WHAT THIS RUN UNLOCKS; SETTINGS; the rules block; FIXTURE; window facts; TYPED READINGS; ORDER OF WORK; the looks, each with steps, RESULT and THE DRAFTER MUST SEE; and the clean end.
   3. **Rules block:** copied by script from G4 lines 8 to 49, which is the F5 block: N1 to N17 including the N17 nil-zoom line, changes (a) to (h), STANDARD BUILD STEPS, SETUP and CLEAN END. The only edits are "G4" changed to "Hn" and two lines:
      1. **N14:** "The installed build at 29 Oct 11:19 is Civil 3.0.85 and Manager 1.1.85 (Structural 1.0.125)".
      2. **N6:** "The desk saw on 29 Oct 11:15". All four hashes are unchanged from 28 Oct; I re-read them at 11:15.
   4. **Diff check:** I diffed the H1, H3 and H6 blocks against G4. Only those two lines differ.
   5. **Reports Codex will write:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_Hn_<yyyyMMdd_HHmm>.md`, with lock names Codex-H1 to Codex-H6.
2. **Queue lines added to `desk_jobs\CONVEYOR_QUEUE.txt`.** I re-read the file at 11:26 and appended only. git diff shows +10 lines and 0 changed. All six lines are `#HOLD`, under comments that say when to release each one:
   1. **Thursday, release after 17:53 and after the G3, G7 and G4 lines:** `#HOLD verifyH1_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3` and the same line for verifyH2_c85.
   2. **Friday, release after 17:53 and after G6 and G5:** verifyH3_c85, verifyH4_c85 and verifyH5_c85.
   3. **Saturday, release after 17:53:** verifyH6_c85.
   4. **Cap arithmetic:** 3 per look; usage 13 at 11:00.
      1. **Thursday:** 13 + 9 for the G looks + 6 for H1 and H2 = 28, under the cap of 30.
      2. **Friday:** + 6 for G6 and G5 + 9 for H3 to H5 = 43, under 44.
      3. **Saturday:** + 3 = 46, under 58.
   5. **Risk on Thursday:** if cx_ jobs push usage to the full 16 before 17:53, H2 starts at about 28 and could end near 31. PACE refuses a start only when usage + 1 is over the cap, so the worst case is H2 waiting until Friday.
3. **What each look proves, and what it rests on.** All window words were read from the installed source at `09126560` with `git show` / `git grep`. That commit is an ancestor of `origin/claude/rel-20261026z`. The DLLs read 3.0.85+09126560 and 1.1.85+09126560 at 11:19.
   1. **H1 (BUG-1101 PASS/FAIL; BUG-1097 SEEN only):**
      1. **Window and tabs:** "Creative Engineering | Calculations", top-level tabs "Catchments" and "Charged System". The blank start comes from `RationalMethodViewModel(startBlank)`. The warning wording comes from `ChargedSystemCalcViewModel.MinimumHeadWarning`, which uses the typed head.
      2. **Switches:** Tim's `CD_Settings.json` has no `detention` section, so both switches are ON, Tc is 5 and the storm is 1 in 5. `designStandards.chargedMinHeadMm` is 300.
      3. **What Codex records:** for each head, two lines: one for each meaning of the rule.
   2. **H2 (BUG-1215):** the Help Centre's Feedback entry text is quoted from `guide-content.js:98`. The look also checks that the Feedback window's buttons are "Send report" and "Cancel", and presses Cancel only.
   3. **H3 (BUG-1198):**
      1. **How it judges:** CLOSE is forbidden (N4) and a test copy already reads as changed (N9). So the look counts CE's log line "Project data saved to DWG successfully" across three cycles: a plain open/close, Export CSV then Cancel, and Export Excel then Cancel.
      2. **Check that the count works:** the line occurs 17,268 times in the CE_CVL_SUITE logs and 6,519 times in the TIM_CE_CADTOOLS logs, so this PC writes it. I counted only. A "LOG BLIND" rule covers the case where it doesn't.
      3. **Privacy:** no picture of the save box may be kept, because it opens in CE's Civil folder.
   4. **H4 (BUG-1180):**
      1. **Fixture:** the G7 pit and pipe build. One typed `dictremove` deletes the label's PIPE_ATTACHMENT record from its CE_CVL_SUITE_LINKS dictionary. That is the record that `CaptureMissingPipeAttachmentOwnerRepairs` offers to restore.
      2. **The look:** CEMANAGER, Drawing Repair, "Civil exact stored links", Inspect drawing, Fix it pressed once.
      3. **Exceptions:** both actions are named exceptions to change (f), for that one test copy only.
   5. **H5 (BUG-1106):**
      1. **Fixture:** a synthetic one-page PDF (text: "STORM Rating Report", "Municipality: Glen Eira", "Allotment Site m2: 600.00", "STORM Rating %: 101") in `<evidence>\copies\job\Civil\STORM Report - WSUD\`, with the blank drawing copied into `job\Civil\`. That folder layout is what `StormReportReader.HoldsAJobsReports` climbs to.
      2. **How it judges:** the "Council set to" line looks the same before and after the fix. So the look reads the Setup tab and the "Work out design" list for "The council and its rules: ...".
      3. **Check done:** Glen Eira is in all four installed council-profiles.json files (read-only count).
   6. **H6 (BUG-1206, half):** ribbon screenshots at start, then 10, 20, 40 and 60 seconds, plus clicks on two named ribbon tabs. The result line must say "HALF ONLY". The Manager-first half needs a spare login with its own copy of the bundles.
4. **DERIVED (written from source, never run in AutoCAD):**
   1. **H1:** total loss about 0.22 m for the tab's starting figures, from the Hazen-Williams and K formulas in the source, so a typed 0.40 m leaves about 0.18 m.
   2. **H1:** a typed box value is taken only after Tab (WPF default lost-focus binding; not checked in the XAML for these boxes).
   3. **H3:** a plain Pit Schedule open and close adds no "Project data saved" line. If it does, the brief marks the result UNSURE.
   4. **H4:** the description label is one of the pipe's Attachments rows. Removing its PIPE_ATTACHMENT record makes Inspect offer "Restore the exact pipe owner record on attachment <handle>", and CE does not put the record back by itself before Inspect.
   5. **H4:** `(assoc 360 ...)` on the label returns its extension dictionary.
   6. **H5:** PDFium reads the text of a hand-made PDF 1.4 with a Helvetica Type1 font, one line per text block. CDDESIGN on an empty tagged-as-Civil job asks no other question before the window.
   7. **H6:** that the start order cannot be seen from the screen. I found no Manager start-up log line to read it from.
5. **What I did NOT verify (RULES 5.9):**
   1. **Nothing ran.** No brief has been driven in AutoCAD, and the typed LISP lines in H4 have never run. They are bracket-balanced: a script checked every TYPED READING, and I first proved it flags a broken line.
   2. **The H5 PDF builder:** it is described, not written. Codex writes it into its own tools folder.
   3. **Codex's real cost per look:** 3 is a planning figure.
   4. **Window sizes and wording on screen:** whether they match the source.
   5. **Why CE_PLAN said "ahead 1" at 11:26:** after the fetch it read level with origin, so another session most likely pushed its own commit in between. I did not check whose it was. My push carries only my own commits.
6. **Files in CE_PLAN changed by others and NOT committed by me:** BUG_CARPARK.md, the acceptance ledger, desk_jobs/.last_tick and CODEX_MODE.txt (other sessions' work in progress). I committed only this report and the queue file, by name.

## Summary (under 100 words)

I wrote six Codex look briefs, H1 to H6 (12 new files in the runner folder), for the pilot-critical window bugs: CDCALC (BUG-1101; BUG-1097 reported both ways for Tim), Help (BUG-1215), Pit Schedule export cancel (BUG-1198), Drawing Repair (BUG-1180), CDDESIGN with Glen Eira (BUG-1106) and the CE Tools ribbon (BUG-1206, half only). Six held queue lines: two on Thursday (28 of 30), three on Friday (43 of 44), one on Saturday. Nothing ran. The H4 and H5 test material is derived from the program code and has never been tried in AutoCAD.
