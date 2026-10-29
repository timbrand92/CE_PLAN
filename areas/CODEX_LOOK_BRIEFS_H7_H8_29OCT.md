# Codex look briefs H7 and H8: the Boyd's look and the CDDESIGN Darebin look (Thu 29 Oct 2026)

**Who and how.** CE 02 Robot and Codex Testing, headless Team job "CE_ACAD / robot / draft / 20" (Opus), 12:30 to about 12:45 Melbourne by the PC clock. Reading and writing documents only. AutoCAD, the runner, the ledger, DESK_LOG, BUG_CARPARK and the H1 to H6 and G briefs were not touched. Source was read with `git show` / `git grep` only, on `origin/claude/rel-20261026z` (the 3.0.85 line) and the fix branch `origin/cx6/bug-1095-bd21`.

---

# ANSWER FIRST

1. **Both looks are written and parked in the queue.** H7 checks the Boyd's tab. H8 checks the Design window on a Darebin test job that the look makes for itself.
2. **Neither can pass yet.** None of the fixes is in the installed build (Civil 3.0.85). On today's build each look runs as a **"before" reading**: it writes down today's wrong numbers as evidence, and says NOT TESTED.
3. **They release only after two things happen:** CE 01 builds and installs the fixes, and the desk types into each launcher the first version that carries each fix.

---

# FOR TIM

1. **What H7 checks (Boyd's tab in CDCALC, about 1 hour).**
   1. **BUG-905:** on a 746 m2 lot (414 m2 roof and paving, 332 m2 garden, 7.9 L/s allowed), the tab should give C 0.633 and **2.08 m3** of storage, using your 0.9 for roof and paving. Today it gives C 0.688 and **2.56 m3**, because it still uses 1.0.
   2. **BUG-1095 (Boyd's half):** on a Darebin job, a 600 m2 lot with 400 m2 roof and paving, at 5 L/s allowed, should come out at **C 0.80 and 3.86 m3**, with a line saying the council minimum governs. Today it is C 0.767 and 3.54 m3.
2. **What H8 checks (the Design window, CDDESIGN, about 1.5 hours).**
   1. **BUG-1095 (Design half):** the same Darebin lot should read **"Weighted C 0.80"** with the council-minimum note. Today it reads 0.70.
   2. **BUG-1088:** a connection pipe carrying about 40 L/s should come out **DN225 at 1 in 200**. Today it is DN100 at 1 in 3, running at about 5 m/s.
   3. **BUG-1091:** a big lot (9,000 m2) needing about 190 L/s should get **DN450 at 1 in 200**, not a flatter grade nobody chose.
3. **What these looks can close.**
   1. **BUG-905, BUG-1095 and BUG-1091 (Design route):** a Codex PASS closes them. You have already ruled on 905 and 1095 is the council's own rule.
   2. **BUG-1088 stays partly yours.** A PASS shows only that CE does what was built. **Whether "go up a size before going steeper" is the right rule is still your call: Monday question 21(a).**
   3. **Not covered:** the bug entry's other BUG-1091 example, redesigning an existing DN450 at 30 L/s (1 in 1,509 today). No test drawing has one. It stays open.
4. **Cost.** About 3 percent of the Codex week each, so 6 percent for both.
5. **When they can run.** After CE 01 builds and installs the fixes (target Thu 5 Nov). Codex runs in AutoCAD's free windows, after 5:30 pm or at weekends. **Nothing for you to do or test.**

---

# BELOW THE LINE

## 1. Files written (none overwritten; the folder was checked first and had no H7 or H8)

1. `C:\Lisp Files\_CODEX_RUNNER\verifyH7_c85.txt`: short launcher. It carries `FIX-IN-905 = NOT YET KNOWN` and `FIX-IN-1095 = NOT YET KNOWN`.
2. `C:\Lisp Files\_CODEX_RUNNER\verifyH7_c85_full.txt`: full brief. Looks H7-00, H7-01 (BUG-905), H7-02 (make the Darebin job: Setup, council Darebin, Save Draft, reopen to check), H7-03 (BUG-1095 Boyd's half), H7-99.
3. `C:\Lisp Files\_CODEX_RUNNER\verifyH8_c85.txt`: short launcher. It carries `FIX-IN-1095`, `FIX-IN-1088`, `FIX-IN-1091`, `SWITCH-1088` and `SWITCH-1091`, all NOT YET KNOWN.
4. `C:\Lisp Files\_CODEX_RUNNER\verifyH8_c85_full.txt`: full brief. Looks H8-00, H8-01 (make the Darebin job), H8-02 (BUG-1095 Design half), H8-03 (BUG-1088, two readings), H8-04 (BUG-1091 Design route), H8-99.
5. **Copied word for word from H1 by script, not retyped:** RULES N1 to N17 (checked by diff: identical to H1 and to G7 apart from G7's older dates), the "changes to the shared file" (a) to (h), the standard build steps, SETUP and CLEAN END. Only the look id changed (H1 to H7 / H8). All four files are plain ASCII.
6. **One deliberate change to a copied line:** the TIME line's 50 minutes reads 60 for H7 and 75 for H8. This is stated in each brief's first paragraph, because the H8 work needs more than 50 minutes.

## 2. How each brief meets the job's conditions

1. **FIX-IN gate in the launcher.** A shut gate means every step still runs, and every number read is written as a BEFORE READING. A line "BEFORE MATCHES TWIN: YES/NO" is added and the result is NOT TESTED FIX NOT INSTALLED. This overrides N14's "write FAIL for an old fault", as in H1.
2. **The Darebin job is built on the test copy only.** The copy is F-BLANK. The council is chosen in CDDESIGN Setup and kept with "Save Draft", which writes only into the copy's own CE record; the copy is never saved to disk. If Darebin is missing, or the council will not save, the dependent looks are BLOCKED (fixture).
3. **Why "Save Draft" is needed (source):** the Boyd's tab on the fix branch reads the council from the job's record (`ProjectDataService.GetJobCouncilId(PeekLoadedProject())`). `SaveCouncilIfChanged` in `CivilDesignCommand.cs` writes that record on Save Draft. This answers the plan's UNKNOWN "how the Boyd's tab learns the job's council".
4. **No outlet pick is needed (source):** the "Legal point of discharge" step is met by the tick box "I have confirmed where this site legally discharges". The window says this "does not place an LPD marker or change the drawing". Confirm LPD, Confirm setup, Clear and outlet picks are forbidden in both briefs.
5. **Connection flow (source):** the connection pipe is sized for "Q minor" (`AutoDesignService.cs`, step 8), which the Results tab prints. This answers the plan's UNKNOWN on how CDDESIGN reaches the connection flow. The CONNECTION PIPE section prints only diameter and grade, so the look judges size and grade against the printed Q minor, using the plan's ladder rule.
6. **Settings:** none changed and the settings guard is not called. Both looks only read switches from Tim's settings file.
7. **Time:** H7 is planned at 45 to 60 minutes and H8 at 70 to 90. Neither may go past 90.

## 3. Things found while writing (for the desk)

1. **Plan arithmetic slip:** the plan gives the BUG-905 twin C as 0.689. 513.6 / 746 = 0.68847, which the tab's three decimals show as **0.688**. H7 says 0.688 and notes the plan's figure.
2. **Plan wording:** "DN225 at about 1 in 15, at the 6 m/s cap" for 150 L/s. The grade is right, but the speed is about 3.8 m/s, not 6. H8 says "about 1:15".
3. **Darebin's own soft-ground C is 0.35** (`council-profiles.json`). CDDESIGN prints its own soft C line. If that line reads 0.35, the calculated C is 0.72, not 0.70. H8 computes from the printed figures. The fixed answer, 0.80, does not change.
4. **With BUG-1095 fixed, the H7-03 Boyd's answer is 3.86 m3 whether or not BUG-905 is in,** because both calculated C values (0.700 and 0.767) are under 0.80. So H7-03 judges BUG-1095 on its own.
5. **H8's lot sizes are desk choices, DERIVED, not proven:** 2,000 / 1,800 m2 for about 40 L/s and 9,000 / 8,800 m2 for about 190 L/s, assuming Darebin's 1 in 5 storm at its 10 minute Tc is about 85 mm/hr. Each look has a one-retry rule (rescale the site to the printed flow) and then judges whatever flow the window prints.
6. **BUG-1088 grade ladder:** the ladder capacities are the plan's, from the installed Settings defaults. If Tim's own ladder differs, or CE 01 builds a different rule, the result is DIFFERENT, not FAIL, and the desk checks it.
7. **Desk to fill in before release:** the FIX-IN versions, and SWITCH-1088 and SWITCH-1091 (setting name and default, or NONE). Until then each gate stays shut.

## 4. Queue lines appended (append only; re-read just before)

`C:\CE_PLAN\desk_jobs\CONVEYOR_QUEUE.txt`, after the H6 line:

1. `# H7 and H8 (written Thu 29 Oct 2026 12:40 ...): release only after the first build carrying the fix is installed AND the desk has recorded it in the launcher; Codex weekly cost about 3 percent each; daily caps in daily_cap.sh`
2. `#HOLD verifyH7_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`
3. `#HOLD verifyH8_c85|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|medium|97|3`

## 5. NOT verified

1. **Nothing has been run.** Neither brief has been read by Codex or tried in AutoCAD.
2. **Every number is DERIVED** (plan arithmetic, re-checked by hand), except the bug entries' own figures. None has been seen on screen.
3. **The installed DLL version** was not read. 3.0.85 is the plan's and the brief's statement.
4. **Window wording** was read from the 3.0.85 source, not from a screen. The briefs say the real words win.
5. **Whether "Save Draft" keeps the legal-discharge tick, the job mode and the head** was not traced. H8-01 re-sets anything that does not come back, in the window only.
6. **Untraced:** Darebin's real 10 minute intensity, and so the real Q minor values.
7. **Not covered:** the CDHUB redesign route for BUG-1091.
8. **Not checked:** CE 01's eventual switch names and fix behaviour for BUG-1088 and BUG-1091, because they are not built yet.
9. **Not edited:** BUG_CARPARK, the test list, cases, the runner, the ledger, DESK_LOG, and the H1 to H6 and G briefs.
