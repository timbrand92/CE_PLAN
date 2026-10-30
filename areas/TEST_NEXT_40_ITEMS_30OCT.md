# Test the next 40 plan items: what each built item needs, and the order to run them (Fri 30 Oct 2026, read-only planner, Opus)

**What this is.** A read-only plan. Nothing was built, run, installed or opened in AutoCAD; no git; no agents. The only file written is this one. Written about 11:50 to 12:30 Melbourne (PC clock), while the robot was running pack aB3 on Civil 3.0.86.

**Sources read:** `C:\TimOS\RULES.md`; `areas\PLAN_RECOUNT_29OCT_2026.md`; `areas\COLLEAGUE_READINESS_29OCT.md`; `areas\PILOT_CRITICAL_TEST_LIST_29OCT.md`; `areas\release-v3-colleagues-V3_RECOUNT_2026-10-18.md`; `areas\V3_RECOUNT_2026-10-22.md`; `areas\release-v3-colleagues-Q4_FLIP_LIST_2026-10-18.md`; `areas\TESTED_NOT_TESTED_LIST_29OCT.md` (sections A and C); `areas\CLAUDE_ACCEPTED_TOOLS_30OCT.md`; `PROGRESS.json` (07:43 today); `04_REFERENCE\ux-plan\V3_UX_PLAN.md`; `areas\runner-reports\ledger.json` (1,577 rows, last row 11:49 today) and the 3.0.85 / 3.0.86 run reports (case durations); the `PLAN_ITEM` and `TITLE` lines of every case in `C:\Lisp Files\_ACAD_DRIVER\cases` and its draft folders.

---

## ANSWER FIRST

1. **The 283 built-but-untested plan items split four ways (ESTIMATED by family, see the warning in item 3):**
   1. **Robot can prove it, case can be written now: 95.** (Civil 30, Manager 2, Shared 18, Structural 45.)
   2. **Needs a Codex look (a window, a picture, a colour, a printed sheet): 119.** (Civil 37, Manager 4, Shared 48, Structural 30.)
   3. **Needs Tim's engineering word: 30.** (Civil 12, Structural 18.)
   4. **Cannot be tested until a fix or wiring is installed: 39.** (Civil 21, Manager 3, Structural 15.)
2. **Why 283, not 300.** 300 built and installed, less the 17 counted as tested whole on 29 Oct. Read strictly (PROGRESS.json now says 14), it is 286; the 3 extra are UX-CPLAN-18, 19 and 24, which sit in "robot part plus Codex look" and need no new AutoCAD time, only a ruling.
3. **Warning, said first (RULES 12).** No document lists the 300 installed items one by one. Every recount since 18 Oct carries the 300 as a count only (29 Oct recount, "What I could NOT verify" item 2). I classified by plan family (`V3_UX_PLAN.md`), fitted to the counted area totals (Civil 110, Manager 9, Shared 73, Structural 108). Treat each class count as plus or minus about 10.
4. **The top 40 below would take tested-whole from 14 to 54 of 548 (2.6 to 9.9 percent strict), or 17 to 57 (3.1 to 10.4 percent) as counted.** Each whole item is worth 0.18 percentage points.
5. **AutoCAD cost of the 40: about 7.3 hours** at the robot's measured speeds (two passes plus a failing twin each), about 11 hours allowing for first-run draft mistakes. That is roughly **one percentage point per AutoCAD hour**, and it fills one weekend of free AutoCAD time.
6. **Fastest single gains are free:** four items already have two clean passes on 3.0.86 and need only an Opus review against the plan line (items 1 to 4 of the 40). They cost no AutoCAD time, so run them while the robot works on items 5 onward.

---

## FOR TIM

1. **The short answer.** About a third of what is built (95 items) the robot can prove by itself. A bit over 40 percent (119) needs Codex to look at a window or a sheet. 30 need your engineering word. 39 cannot be proved until a fix goes in.
2. **What moves the number fastest.** Four items have already passed twice on today's build and just need a reviewer to sign them off. Example: when you edit a pipe's levels, the pits and pipes downstream update straight away; the robot has proved that twice today, so the "live updates" plan item can be ticked without opening AutoCAD again.
3. **Keeping AutoCAD busy.** The 40 come to about 7 to 11 hours of AutoCAD time, sized for tonight after 5:30 pm and the weekend. Behind them sit the other 55 robot items (mostly Structural), so the queue will not run dry before Monday.
4. **One answer from you unlocks one item now.** Monday question 19: when you move a pit, should a label you placed by hand ride along with its pipe end (recommended) or stay exactly where you put it? The robot has already passed both halves; your answer decides which one counts.
5. **Nothing for you to test.** Every item in the 40 is for the robot or Codex. Your engineering word is needed only for the 30 items in class 3, and they will come to you as one batch through the questions chat.

---

## 1. The four classes, family by family

**How to read this.** Each line is a plan family, the IDs I believe are installed and not yet tested whole, and why it sits in that class. "Part" means a case already proves part of it. The robot can switch a setting ON for a test through its settings guard (cases N27, N34 and R34sn already do), so a switched-OFF feature is still robot-provable. A feature whose engine is installed but **nothing calls it** cannot be reached by a drafter, so it waits in class 4.

### 1a. Class 1, robot-provable now: 95

1. **Civil (30).**
   1. **Pipes:** UX-PIPE-01 (auto-join within 75 mm, switch ON), 05 (hide grade; N35 drafted), 06, 06b, 07, 08 (one grade for several pipes; carry downstream, switch ON).
   2. **Pit Schedule:** UX-SCHED-06 (part; N09, N29, N33, N34 pass on 3.0.86; N40 drafted), SCHED-01 and 05 (typed value updates the pit; need the grid-edit press reviewed on the allow-list).
   3. **Sources:** UX-SRC-02 (DP and CDRG place like pits; N04, P02, N36 pass), SRC-03 (strip drain its own type).
   4. **Labels:** UX-LBL-03 (Tidy labels for a sheet; R16 passes with the switch ON, Apply/U not covered), LBL-04 (only CE labels move).
   5. **Checks after edits:** UX-DI-01 (quiet re-check), DI-02 (TRIM, EXTEND, BREAK, JOIN on pipes), DI-03 (ignored finding stays ignored; R10 has the OFF half).
   6. **Plan labels:** UX-CPLAN-20 (a later pit takes the next free number), CPLAN-25 (every pipe labelled, no TYP.), CPLAN-27.
   7. **Long section:** UX-LSEC-01 (R28 opens the window; the drawn result is not yet counted).
   8. **Downpipes:** UX-DP-02 (the drafter draws the DP connection pipe).
   9. **Surface drainage:** UX-SURF-01 (trench drain by two points), 02 (fall arrows suggested), 04 (AG and perimeter runs; R37 and R37b pass for perimeter, the AG half has no case), 05 (charged and suspended as pipe properties).
   10. **Tanks:** UX-TANK-02 (R1 and D1 kept).
   11. **Import:** UX-IMP-01 (Compare only compares).
   12. **Overland flow:** UX-OLF-04 (floor freeboard checked; needs its own case, it is not the CDTWL pit-lid freeboard check).
   13. **Civil build-queue extras:** Civil speed (N36 pattern), CD-BRANCH-01.
2. **Manager (2).** UX-SET family: a firm value changed and recorded, read back from the file the program reads (two IDs of UX-SET-02 to 06).
3. **Shared (18).** UX-STD-01 (every placing command carries on until Esc), STD-02 (no "Are you sure?" after a preview); UX-WORD-01 ("Free end" / "Not connected yet"; R19, R19b, N19, N23, R32 already print it); UX-NAMES-01, 02, 06 (old names work, CD/CS/CE names, CDWT and CDLPD stay); UX-EDIT-03 (MIRROR and ROTATE keep CE text readable; R34so, R34sn pass for ROTATE); UX-CMD-01 and 03 (AutoCAD-style prompts, switch ON; Enter repeats); UX-LYR-01 (part; N06, N28, N32 pass; N43, N44, N44b drafted) and LYR-02 (wrong-layer rows, switch ON); UX-RESUME-01 (last size and type come back next start); UX-LIVE-01 (live updates; R11, N11, N26, R12 pass); UX-JOB-01; UX-LAY-01 and 02 (New sheet makes the layout and viewport); UX-TIME-01 and 02 (job timer, CE log lines).
4. **Structural (45), outside the 9 Nov scope.** Typed commands whose result is drawing objects or command-line lines: beams and linking (UX-D2-01 to 06 less 05b, switch ON for Tim's file), beam failure wording (UX-BEAM-01 to 03), tags and marks (UX-MARK-01, 03 to 07), level carry and plan levels (UX-LEVEL-01, 02), symbols (UX-SYM-01 to 03), section mark (UX-SEC-01), framing tags and bracing totals (UX-FRM-01 to 15, the drawn parts), footings and rafts drawn by typed command (UX-FDN, UX-RAFT, UX-LOAD), multi-unit tags (UX-UNIT-01 to 03), the reo bar tool (UX-BSMT, CSREOBAR passed in runs 43 to 47 under driver v2). **Precondition:** no Structural case exists in the case runner and its only fixture (DRV1_B1) is a Civil drawing. One Structural fixture drawing and one proving case must come first (builder time, no AutoCAD).

### 1b. Class 2, needs a Codex look: 119

1. **Civil (37).**
   1. **Pit Schedule:** UX-SCHED-02 (matches the printed schedule column for column; R38 and R25 are the robot half), SCHED-03 (Excel checking sheet; Codex D5-03 PASS on 3.0.77 only).
   2. **Checks:** UX-DI-04 (Show where zooms and glows).
   3. **Plan labels:** UX-CPLAN-22 (pit label at the learned office spot), CPLAN-23 (pipe label reads along the pipe, right way up; R18 has the text, direction needs eyes).
   4. **Survey and surface levels (8):** UX-RL-01, 02, 03, 06; UX-SURV-01, 02, 03, 04. No survey Xref test drawing exists (R26 and the pilot list say so). Codex makes one once, on a copy; after that most of these move to the robot.
   5. **Lids:** UX-LID-01, 02. **Downpipe roof split overlay:** UX-DP-03. **Catchment overlay and overload warning:** UX-SURF-03.
   6. **Design window (7):** UX-DES-01 to 03, UX-STD-07, UX-MODE-01, 03, 04 (CDDESIGN and CDSETUP; R27 only opens the Start tab).
   7. **Calculations:** UX-CALC-03, 04 (CDCALC is not on the robot's read list).
   8. **Import and repair:** UX-IMP-03 (survey files chosen in the window), IMP-04 (import report and PDF), UX-REP-02 (Decide later tab), REP-03 (admin-only delete).
   9. **Project Review:** UX-REV-01 to 05.
   10. **Extras:** Set C items 1 to 7 (Settings-read values that show in windows), Set C item 8 (LandXML circular pits; the file chooser blocks the robot).
2. **Manager (4).** UX-ADMIN-01 (you are the only administrator; Codex W53 PASS on 10 Oct, needs a re-look on 1.1.86); three UX-SET IDs shown only in the Settings window (per-value history, the gold "This job" tag, the LPD note box).
3. **Shared (48).** UX-STD-04 (override reasons quick picks), STD-05 (fix lists pre-ticked), STD-08 (one green line when checks pass); UX-WORD-02, 03 (Send report needs a spare login), 03b; UX-NAMES-04 (plain button words); UX-LEARN-01; UX-MIX-01 (2022 VM); UX-TIP-01 (tooltips); UX-WIN-02, 03; UX-CMD-02, 04 (cursor tooltip, connection glow); UX-NAV family (about 4 IDs; installed set not confirmed); UX-MSG-01 to 03 (the bell, installed hidden and OFF); UX-SET-07, 09; UX-UNIT-04; UX-RIBBON-01 (one tab, green contextual tab; you passed it by hand, Codex D8-04 was DIFFERENT), RIBBON-03; UX-HELP-02 to 05, 08, 09; UX-REG built IDs (about 5; issue register, Structural side, OFF); UX-STDS-01; UX-JOB-03, 04; UX-XREF-01, 03; UX-TIME-03, 04 (admin summary window); UX-CHK-01 to 03 (CECHECKLIST window); UX-NOTES-01.
4. **Structural (30).** Schedules and legends as they look (UX-SSCHED built IDs, framing legend UX-FRM-01 drawn output), the Structural ribbon families (UX-STRUC-02 to 04), the markup QA palettes (UX-QA built IDs), general notes pages (UX-NOTES-02 to 04, 07 to 11), the steel picker (UX-STEEL-02 to 04), sheet set-up (UX-SHEETS-01 to 04).

### 1c. Class 3, needs Tim's engineering word: 30

1. **Civil (12).** UX-LBL-01 (Monday question 19, ride along or stay put; robot evidence N27 and N31 is ready); UX-OLF-01 to 03 (overland flow route, neighbour warning, every overflow goes somewhere); UX-CALC-01, 02 (catchments computed from the rating report; what Apply replaces); UX-RFI-01 to 03 (what the council RFI asked for and whether CE answered it right); the computations-sheet F1 and F2 tables; the B11 orifice-head reader; rulebook B9 and B5.
2. **Structural (18).** Computations in CE (UX-SCALC-01 to 08), footing and pad proposals (UX-FDN-01, 03), subfloor proposals from span tables (UX-SUB-01 to 04), geotech reading and founding notes (UX-SOIL-01, 02), and the design parts of retaining walls, pools, load paths and basements that are installed.
3. **Note.** CDRENUMBER (UX-CPLAN-18, 19) is already counted tested; whether "from the outlet up" is the right engineering order is still your call (accepted-tools list item 17). It is not counted again here.

### 1d. Class 4, cannot be tested until a fix or wiring is installed: 39

1. **Civil (21).**
   1. **Engines with nothing calling them (12):** UX-CPLAN-28, 29, 30 (orifice and tank details), UX-DP-01 (architect downpipe detection), UX-MODE-02 ("Not in markup"), UX-LSEC-02 (crossing services), UX-L3-01, 03 to 06 (the levels proposal engine), K-REQ-01.
   2. **A real fault blocks the test (9):** UX-PIPE-04 (recent buttons missing, BUG-1238; fix B-006 / BUG-1226 not installed); UX-SRC-05 (RG1 label not built; B-007 queued); UX-LBL-02 (part; REDO after a pit pick fails, BUG-861, cause unknown); UX-CPLAN-05 (case K02 FAILS twice on 3.0.86); UX-SCHED-04 (next sheet: Codex D6-03 found "Continue to Place / update" stays disabled, cause not found); UX-IMP-02 (CDCHECKDWG summary: R21 FAILS 3 of 4 on 3.0.86, R40 not run); UX-SIZE-01 to 03 (the sizer picks the smallest pipe at any grade, BUG-1088, and drops the DN450 minimum, BUG-1091; no fix, then your word).
2. **Manager (3).** UX-MGR-01 to 03 (one-glance status is installed but no window shows it).
3. **Structural (15).** Installed engines with no caller (the markup compare and clarification engines, the CEMEMBER record, the member schedule fill) and switches whose Settings rows are on PRs #1063, #1248, #1250, not installed.

---

## 2. The top 40, most tested-percentage per hour of AutoCAD time first

**How the minutes were worked out.** From the robot's own reports on 3.0.85 and 3.0.86: a case takes 0.5 to 6 minutes (median about 2), each item needs two passes in separate AutoCAD starts plus one run of its failing twin, and each start costs about 4 minutes shared across the pack. A Codex look is about 15 to 20 minutes of AutoCAD. Every whole item is +0.18 percentage points of the 548. "Gain per hour" = 0.18 times 60, divided by the minutes. New case names (N45 onward) are proposed names, not files that exist.

### 2a. No AutoCAD time: review only (do these first, alongside the robot)

1. **UX-LIVE-01, live updates straight after each edit.** **Proof:** R11, N11, N26, R12, each two clean passes on 3.0.86. **Job:** Opus review against the plan line; it may come back "part" because "batched with Cancel on big jobs" is not covered. **AutoCAD:** 0 minutes.
2. **UX-SRC-02, downpipe and raingarden place like pits, before pipes.** **Proof:** N04, P02, N36 on 3.0.86. **Job:** Opus review; the RG1 label belongs to UX-SRC-05, not this item. **AutoCAD:** 0.
3. **UX-WORD-01, "Free end" and "Not connected yet".** **Proof:** R19, R19b, N19, N23, R32 print these words on 3.0.86. **Job:** Opus review that every place the plan names is covered. **AutoCAD:** 0.
4. **UX-LBL-01, hand-placed labels stay.** **Proof:** N27 and N31, two passes each on 3.0.86. **Job:** Tim's answer to Monday question 19, then an Opus review. **AutoCAD:** 0.

### 2b. Short new robot cases on the standard drawing (pack 1, no settings changed)

5. **UX-NAMES-02, new commands named CD, CS and CE.** **Case:** N45 `names_cd_cs_ce_answer` (type the new names, no "Unknown command"). **AutoCAD:** about 4 minutes (shared case). **Gain:** about 2.7 points per hour.
6. **UX-NAMES-06, Civil short codes CDWT and CDLPD stay.** **Case:** N45, same case. **AutoCAD:** about 4 minutes.
7. **UX-NAMES-01, old typed names work forever.** **Case:** N46 `old_names_still_work` (aliases from the command register). **AutoCAD:** about 6 minutes. **Gain:** 1.8 per hour.
8. **UX-TIME-01, the job timer starts per job drawing.** **Case:** N47 `job_timer_log_line` (reads the CE log line only). **AutoCAD:** about 6 minutes.
9. **UX-CPLAN-25, every pipe labelled, no TYP.** **Case:** N48 `three_pipes_three_labels`. **AutoCAD:** about 8 minutes. **Gain:** 1.4 per hour.
10. **UX-CMD-03, Enter repeats with the last values.** **Case:** N49 `enter_repeats_cd_last_values`. **AutoCAD:** about 8 minutes.
11. **UX-STD-02, no "Are you sure?" after a preview.** **Case:** N50 `preview_then_apply_asks_nothing` (CDPERIMETER and Tidy preview; only deleting link records may ask). **AutoCAD:** about 8 minutes.
12. **UX-SURF-01, trench drain by two points.** **Case:** N51 `trench_drain_two_points_u`. **AutoCAD:** about 8 minutes.
13. **UX-STD-01, every placing command carries on until Esc.** **Case:** N52 `dp_of_rg_fw_carry_on_until_esc` (R01 covers PIT and CD). **AutoCAD:** about 10 minutes. **Gain:** 1.1 per hour.
14. **UX-DP-02, the drafter draws the DP connection pipe.** **Case:** N53 `cd_from_dp_joins_downpipe`. **AutoCAD:** about 10 minutes.
15. **UX-SURF-04, AG and perimeter drains as simple CE runs.** **Case:** N54 `cdagi_run_places_and_u` (R37 and R37b already cover perimeter). Use the millimetre drawing: BUG-1052 (metre drawings) is not installed. **AutoCAD:** about 10 minutes.
16. **UX-ADMIN-01, Tim the only administrator.** **Look:** Codex re-look of W53 on Manager 1.1.86 (admin list holds one entry). **AutoCAD:** about 10 minutes.

### 2c. Finish part-tested items whose cases are already drafted (pack 2)

17. **UX-SCHED-06, Pit Schedule natural order, whole.** **Case:** N40 and N40_BROKEN (`drafts_gap_30oct`). With N09, N29, N33, N34 already passing, this should complete the card. **AutoCAD:** about 12 minutes. **Gain:** 0.9 per hour.
18. **UX-PIPE-05, hide grade in the pipe label.** **Case:** N35 and N35_BROKEN (`drafts_opus_29oct_b5`, reviewed "go to apply", never run). **AutoCAD:** about 12 minutes. Your redesign idea (UX-NEWPIPE-DECLUTTER) does not stop the test of what is built.
19. **UX-LSEC-01, long section on request.** **Case:** N55 `cdprofile_apply_draws_section` (extends R28 to Apply and counts what is drawn, then U). **AutoCAD:** about 12 minutes.
20. **UX-RESUME-01, last pipe size and type come back next start.** **Case:** N56 `new_pipe_defaults_survive_restart` (the runner's fresh start per pass is the "next day"). Copy and hash `CD_RecentValues.json` before and after, as the pilot list asks for P01. **AutoCAD:** about 12 minutes.

### 2d. Switched-OFF features driven ON through the settings guard (pack 3, one SETTING start)

21. **UX-LBL-04, only CE labels move under Tidy, everything else is avoided.** **Case:** N57 `tidy_moves_only_ce_labels` (a plain TEXT beside a CE label stays put; Tidy switch ON). **AutoCAD:** about 12 minutes.
22. **UX-PIPE-01, auto-join to a pit or pipe end within 75 mm.** **Case:** N58 `auto_join_74_caught_76_free` (switch `AutoJoinPipeEnds` ON; boundary pair like N23). **AutoCAD:** about 12 minutes.
23. **UX-LYR-02, wrong layer is a pre-ticked fix in Checks.** **Case:** N59 `cdcheck_wrong_layer_row` (switch `layerChecks.wrongLayerRows` ON; earlier robot run 45 UNPROVEN, so check the read route first). **AutoCAD:** about 12 minutes.
24. **UX-DI-01, CE re-checks quietly after ordinary edits.** **Case:** N60 `quiet_recheck_after_move`. **AutoCAD:** about 12 minutes.
25. **UX-DI-03, ignored findings stay ignored until something changes.** **Case:** N61 `cdcheckignore_on_stays_ignored` (switch `checks.allowIgnoreFinding` ON; R10 has the OFF half). Check BUG-866's split first (the pilot list says the number covers two bugs). **AutoCAD:** about 10 minutes.
26. **UX-CMD-01, AutoCAD-style prompts with clickable options.** **Case:** N62 `cd_autocad_style_prompt_words` (switch `AutoCadStyleCdPrompts` ON). **AutoCAD:** about 10 minutes.
27. **UX-EDIT-03, MIRROR and ROTATE keep CE text readable.** **Case:** N63 `mirror_pit_text_reads_right_way` (R34so and R34sn cover ROTATE Copy; switch `KeepTextReadableAfterRotateMirror` ON). **AutoCAD:** about 10 minutes.
28. **UX-DI-02, TRIM, EXTEND, BREAK and JOIN work on pipes.** **Case:** N64 `trim_break_join_ce_pipe_u`. **AutoCAD:** about 15 minutes. **Gain:** 0.7 per hour.
29. **UX-PIPE-07, one grade for several pipes, "Only these pipes" by default.** **Case:** N65 `one_grade_only_these_pipes`. **AutoCAD:** about 15 minutes.
30. **UX-PIPE-08, "Carry downstream".** **Case:** N66 `one_grade_carry_downstream_u`. **AutoCAD:** about 15 minutes.
31. **UX-LBL-03, Tidy labels for a sheet, Apply and one U.** **Case:** N67 `tidy_labels_apply_u` (R16 has the preview and Esc). Avoid REDO after a pick (BUG-861) or the case will fail on a known fault. **AutoCAD:** about 15 minutes.

### 2e. Codex looks (same AutoCAD, booked into Codex windows)

32. **UX-SCHED-03, Excel export with a checking sheet.** **Look:** re-run D5-03 on 3.0.86 and open the workbook. **AutoCAD:** about 15 minutes.
33. **UX-RIBBON-01, selecting a pipe or pit brings its green tab forward.** **Look:** G-series look with a corrected brief (D8-04 was probably a brief mismatch). **AutoCAD:** about 15 minutes.
34. **UX-DI-04, Show where zooms and glows.** **Look:** new look on CDCHECK's Show where. **AutoCAD:** about 15 minutes.
35. **UX-CPLAN-22, pit label at the office spot.** **Look:** N25 proves the label lands on the click; Codex judges the spot. **AutoCAD:** about 15 minutes.
36. **UX-STD-08, quiet when OK: one green line.** **Look:** colour and folding are on screen only. **AutoCAD:** about 15 minutes.
37. **UX-STD-04, override reasons as quick picks.** **Look:** the four picks and the optional note in the window. **AutoCAD:** about 15 minutes.
38. **UX-CPLAN-23, pipe label along the pipe, right way up.** **Case plus look:** R18 has not run on 3.0.86 (absent from the ledger); run it twice, then a Codex look at direction (cx_cr04 said the robot cannot read text angle). You passed it by hand (H15), which counts as your word, not as a test. **AutoCAD:** about 20 minutes.
39. **UX-SCHED-02, Pit Schedule matches the printed schedule column for column.** **Case plus look:** R38 and R25 on 3.0.86 (R25 is absent from the ledger), then a Codex look at the drawn table. **AutoCAD:** about 20 minutes.
40. **UX-LYR-01, office layers, whole.** **Case:** N43, N44, N44b and their twins (`drafts_gap_30oct`). With N06, N28, N32 passing this may complete the card, IF "an existing layer is never recoloured" holds; the 29 Oct readiness report says that half is not built, so N43 may prove a fault instead. **AutoCAD:** about 30 minutes. **Gain:** 0.36 per hour.

**Totals for the 40:** about 438 AutoCAD minutes (7.3 hours) before retries. 36 items use AutoCAD: 27 robot only, 7 Codex look only (items 16, 32 to 37), 2 both (items 38, 39). Four items need no AutoCAD at all.

---

## 3. Keeping AutoCAD busy (both of Tim's goals at once)

1. **Order of the queue.** Packs 1 to 3 (items 5 to 31) go to the robot in that order; the Codex looks (items 16, 32 to 39) go in Codex's windows; reviews (items 1 to 4) run on paper at the same time and never hold AutoCAD.
2. **Windows (RULES 1.8).** Free: today 2:00 to 3:00 pm, after 5:30 pm tonight, all weekend, before 8:30 am Monday. That is about 60 free hours to Monday morning, far more than the 7 to 11 needed, so the 40 can finish this weekend if the cases are written today.
3. **The C-77 install today restarts the two-pass clock** for the areas it touches (area-plus-smoke rule). Write the new cases now but run their counted passes on 3.0.87 after the install, so they are not re-run twice.
4. **What fills AutoCAD after the 40 (so it never sits idle).**
   1. **The other 25 Civil and Shared robot items** in class 1 (section 1a), next packs N68 onward.
   2. **The Structural fixture and first proving case**, then the 45 Structural robot items. They count toward the 548 even though Structural is outside the 9 Nov scope.
   3. **Codex makes the survey Xref test drawing once** (`RD15_NESTED.dwg` in the pilot list). That moves 8 survey items from class 2 to the robot and unlocks BUG-1190 too.
   4. **The pilot-critical cases P01 and P02** have three passes on 3.0.86 already; they need their twins red and a review, not more AutoCAD time.
5. **Do not queue class 4 items** until their fix is installed; a case written against a known fault only proves the fault.

---

## 4. What unlocks most of class 4 (for the build desk, not for Tim)

1. **Wiring the installed engines that nothing calls (12 Civil, 3 Manager, up to 15 Structural).** This waits on ruling A open question 2 ("does wiring an already-built engine count as new?"). I found no answer recorded in the files I read; it is a question for Tim, not a decision.
2. **B-006 (BUG-1226 / BUG-1238, recent buttons)** unlocks UX-PIPE-04; draft case N30 exists.
3. **B-007 (RG1 label)** unlocks UX-SRC-05.
4. **The CDCHECKDWG fault (R21 failing on 3.0.86)** unlocks UX-IMP-02.
5. **BUG-861 (REDO after a pit pick)** unlocks the REDO half of UX-LBL-02.
6. **BUG-1088 and BUG-1091 (sizer)** unlock UX-SIZE-01 to 03, then they move to Tim's word.

---

## 5. What I did NOT verify (RULES 5.9)

1. **No item-by-item installed list exists.** Every class count is my estimate by plan family, fitted to the counted totals of 18 Oct (Civil 110, Manager 9, Shared 73, Structural 108). Some IDs I placed as installed may be on unshipped PRs, and the reverse. Plus or minus about 10 per class.
2. **Nothing was run.** No AutoCAD, no runner, no Codex. Case names N45 to N67 are proposals; no file was written for them.
3. **Minutes are estimates** from measured medians on 3.0.85 and 3.0.86 reports; a brand-new case often needs one or two fix-ups before it runs clean, so allow about 50 percent more.
4. **Mapping a passing case to a plan item is a reviewer's call.** Items 1 to 4 may come back "part"; I have not judged any case as whole.
5. **Switch names** are from the 18 Oct Q4 flip list and the case files; I did not read the code on the installed 3.0.86 line to confirm each default.
6. **CDTWL freeboard (R14, R14h x3)** passes on 3.0.86 but I could not match it to a plan ID (it is named check C39 in the everyday tools). It is not in these counts.
7. **The robot's read lists** (which windows it can read and which buttons it may press) were taken from the pilot list and case titles, not from the allow-list files themselves.
8. **Tim's hand passes** (for example UX-CPLAN-23, UX-RIBBON-01, UX-PIPE-05) are his word, not tests, under the 28 Oct definition; they are not added to the tested count here.

---

## Summary (under 100 words)

283 built plan items are not yet tested whole (286 strict). By family estimate: robot-provable now 95, Codex look 119, Tim's engineering word 30, waiting for a fix or wiring 39. The top 40 take tested-whole from 14 to 54 of 548 (2.6 to 9.9 percent strict) for about 7.3 hours of AutoCAD (about 11 with retries), roughly one point per hour. Four need no AutoCAD at all (UX-LIVE-01, UX-SRC-02, UX-WORD-01, UX-LBL-01 after Tim's question 19). Not verified: no itemised installed list exists; nothing was run.
