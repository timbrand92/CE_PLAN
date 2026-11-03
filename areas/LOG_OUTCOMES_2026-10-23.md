<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->
_Updated 2026-10-23 18:00 Melbourne time._

# CE log outcomes: Fri 23 Oct 2026 00:00 to Fri 23 Oct 2026 18:00 (Melbourne time, PC clock)

**Answer first.**

1. **Commands seen:** 123 command runs in the logs (105 with a start/end line or a command record, 18 recognised from lines or files that name the command).
2. **Worked:** 98. **Refused (CE said no in plain words):** 4. **Cancelled:** 21. **Warned:** 0. **Failed:** 0. **Unknown (no outcome line):** 0.
3. **New warnings/errors today:** 0 message types not seen on an earlier day. **Failure candidates added:** 0.
4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim's use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.
5. **Read:** 4 files, 24024 lines; 99 warnings/errors outside any command run.
6. **Background sync steps (not counted above):** 9. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it.

## 2. Civil: every command, by outcome

1. **CD**: worked 4 (total 4); 07:39 to 17:30; build 3.0.70, 3.0.71.
2. **CDCALC**: worked 1 (total 1); 08:25 to 08:25; build 3.0.70.
3. **CDCHECKCURRENT**: worked 5 (total 5); 08:28 to 16:42; build 3.0.70, 3.0.71.
4. **CDCHECKS**: worked 6 (total 6); 00:03 to 17:01; build 3.0.70, 3.0.71.
5. **CDEDIT**: worked 1 (total 1); 08:46 to 08:48; build 3.0.70.
6. **CDINSPECTOR**: worked 50 (total 50); 00:00 to 17:58; build 3.0.70, 3.0.71.
7. **CDS**: worked 4 (total 4); 00:03 to 01:10; build 3.0.70.
8. **CDSYNC**: worked 1 (total 1); 08:55 to 08:55; build 3.0.70.
9. **CDTAG**: cancelled 1 (total 1); 09:00 to 09:00; build 3.0.70.
10. **CDTIDYLABELS**: worked 2, refused 4 (total 6); 07:36 to 17:33; build 3.0.70, 3.0.71.
   - **refused:** [TidyUp] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "SC"). (x4, first 07:36)
11. **CDTWL**: cancelled 1 (total 1); 08:58 to 08:58; build 3.0.70.
12. **DP**: worked 1, cancelled 10 (total 11); 00:12 to 17:46; build 3.0.70, 3.0.71.
13. **PIT**: worked 7 (total 7); 06:03 to 17:27; build 3.0.70, 3.0.71.
14. **PITSCHEDULE**: worked 8 (total 8); 05:59 to 16:39; build 3.0.70, 3.0.71.

## 3. Structural: every command, by outcome

1. **AD**: worked 4 (total 4); 11:35 to 11:43; build 1.0.122 (installed now).
2. **CEMEMBER**: cancelled 9 (total 9); 10:53 to 11:17; build 1.0.122 (installed now).
3. **LD**: worked 2 (total 2); 11:41 to 11:42; build 1.0.122 (installed now).
4. **Q**: worked 1 (total 1); 11:45 to 11:45; build 1.0.122 (installed now).
5. **QD**: worked 1 (total 1); 11:47 to 11:47; build 1.0.122 (installed now).

## 3b. Manager: every command, by outcome

1. **No command runs found in this period.**

## 4. Used successfully (use evidence, not an acceptance)

This lists commands that WORKED at least 2 times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5).

1. **Civil CD** on build 3.0.71: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
2. **Civil CDCHECKCURRENT** on build 3.0.70: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
3. **Civil CDCHECKCURRENT** on build 3.0.71: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
4. **Civil CDCHECKS** on build 3.0.70: worked 5 times, refused 0, warned 0, cancelled 0, no failure.
5. **Civil CDINSPECTOR** on build 3.0.70: worked 41 times, refused 0, warned 0, cancelled 0, no failure.
6. **Civil CDINSPECTOR** on build 3.0.71: worked 9 times, refused 0, warned 0, cancelled 0, no failure.
7. **Civil CDS** on build 3.0.70: worked 4 times, refused 0, warned 0, cancelled 0, no failure.
8. **Civil CDTIDYLABELS** on build 3.0.71: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
9. **Civil PIT** on build 3.0.70: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
10. **Civil PIT** on build 3.0.71: worked 5 times, refused 0, warned 0, cancelled 0, no failure.
11. **Civil PITSCHEDULE** on build 3.0.70: worked 6 times, refused 0, warned 0, cancelled 0, no failure.
12. **Civil PITSCHEDULE** on build 3.0.71: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
13. **Structural AD** on build 1.0.122 (installed now): worked 4 times, refused 0, warned 0, cancelled 0, no failure.
14. **Structural LD** on build 1.0.122 (installed now): worked 2 times, refused 0, warned 0, cancelled 0, no failure.

## 5. New warnings and errors (not seen on an earlier day)

1. **None.**

## 6. Ribbon clicks seen

1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).

## 7. What the logs could not tell us

1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim's normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.
2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.
3. **Manager and Structural:** builds carrying command outcome lines are read directly; older builds still have gaps. The checkdwg / xcdimport tools write no per-command outcome here.
4. **Structural build number** is not in its logs; the installed build is read from the plugin file.
5. **Sources read:** ce_cvl_structured_20261023.log, native_grip_2027.log, ce_struc_structured_20261023.log, runtime_20261023.jsonl, ce_struc_suite.log.


---

## Run log

<!-- RUN LOG: newest first -->

### Run at 2026-10-23 18:00 Melbourne

1. **Since the last run:** 7 more command runs (worked 7, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 98, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 17:30 Melbourne

1. **Since the last run:** 4 more command runs (worked 4, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 91, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 17:00 Melbourne

1. **Since the last run:** 7 more command runs (worked 7, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 87, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 16:30 Melbourne

1. **Since the last run:** 1 more command runs (worked 1, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 80, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 16:00 Melbourne

1. **Since the last run:** 0 more command runs (worked 0, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 15:30 Melbourne

1. **Since the last run:** 0 more command runs (worked 0, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 15:00 Melbourne

1. **Since the last run:** 0 more command runs (worked 0, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 14:30 Melbourne

1. **Since the last run:** 0 more command runs (worked 0, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 14:00 Melbourne

1. **Since the last run:** 0 more command runs (worked 0, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 13:30 Melbourne

1. **Since the last run:** 2 more command runs (worked 2, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 79, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 13:00 Melbourne

1. **Since the last run:** 4 more command runs (worked 4, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 77, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 12:00 Melbourne

1. **Since the last run:** 9 more command runs (worked 9, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 73, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** a CE log changed.

### Run at 2026-10-23 11:30 Melbourne

1. **Since the last run:** 5 more command runs (worked 0, refused 0, cancelled 5, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 64, refused 4, cancelled 21, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** a CE log changed.

### Run at 2026-10-23 11:00 Melbourne

1. **Since the last run:** 5 more command runs (worked 1, refused 0, cancelled 4, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 64, refused 4, cancelled 16, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 10:30 Melbourne

1. **Since the last run:** 1 more command runs (worked 1, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 63, refused 4, cancelled 12, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 09:30 Melbourne

1. **Since the last run:** 4 more command runs (worked 3, refused 0, cancelled 1, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 62, refused 4, cancelled 12, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** a CE log changed.

### Run at 2026-10-23 09:00 Melbourne

1. **Since the last run:** 7 more command runs (worked 6, refused 0, cancelled 1, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 59, refused 4, cancelled 11, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 08:30 Melbourne

1. **Since the last run:** 3 more command runs (worked 3, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 53, refused 4, cancelled 10, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-23 08:00 Melbourne

1. **Since the last run:** 64 more command runs (worked 50, refused 4, cancelled 10, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 50, refused 4, cancelled 10, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

