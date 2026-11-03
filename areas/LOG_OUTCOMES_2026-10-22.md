<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->
_Updated 2026-10-22 19:00 Melbourne time._

# CE log outcomes: Thu 22 Oct 2026 00:00 to Thu 22 Oct 2026 19:00 (Melbourne time, PC clock)

**Answer first.**

1. **Commands seen:** 37 command runs in the logs (10 with a start/end line or a command record, 6 recognised from lines or files that name the command).
2. **Worked:** 27. **Refused (CE said no in plain words):** 2. **Cancelled:** 8. **Warned:** 0. **Failed:** 0. **Unknown (no outcome line):** 0.
3. **New warnings/errors today:** 0 message types not seen on an earlier day. **Failure candidates added:** 0.
4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim's use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.
5. **Read:** 4 files, 5311 lines; 23 warnings/errors outside any command run.
6. **Background sync steps (not counted above):** 4. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it.

## 2. Civil: every command, by outcome

1. **CD**: worked 1 (total 1); 14:40 to 14:41; build 3.0.69.
2. **CDCHECKCURRENT**: worked 2 (total 2); 13:29 to 15:28; build 3.0.69.
3. **CDCHECKS**: worked 1 (total 1); 13:22 to 13:22; build 3.0.69.
4. **CDEDIT**: worked 2, cancelled 1 (total 3); 14:42 to 15:28; build 3.0.69.
5. **CDHELP**: worked 1 (total 1); 15:27 to 15:27; build 3.0.69.
6. **CDIMPORTXCIVIL**: worked 3 (total 3); 13:03 to 15:22; build 3.0.69.
7. **CDINSPECTOR**: worked 6 (total 6); 12:34 to 18:29; build 3.0.69.
8. **CDRECOVERINVERTS**: worked 1 (total 1); 14:43 to 14:43; build 3.0.69.
9. **CDS**: worked 1 (total 1); 15:26 to 15:26; build 3.0.69.
10. **CDSYNC**: worked 1 (total 1); 14:46 to 14:46; build 3.0.69.
11. **CDTIDYLABELS**: refused 2 (total 2); 14:39 to 14:41; build 3.0.69.
   - **refused:** [TidyUp] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "SC"). (x2, first 14:39)
12. **CDTWL**: worked 1, cancelled 1 (total 2); 14:39 to 14:42; build 3.0.69.
13. **PIT**: worked 1 (total 1); 14:39 to 14:40; build 3.0.69.
14. **PITSCHEDULE**: worked 2 (total 2); 14:46 to 14:47; build 3.0.69.

## 3. Structural: every command, by outcome

1. **25C**: cancelled 1 (total 1); 18:44 to 18:44; build 1.0.121 (installed now).
2. **CEMEMBER**: cancelled 3 (total 3); 14:48 to 18:48; build 1.0.121 (installed now).
3. **CSREOBAR**: worked 1 (total 1); 14:47 to 14:47; build 1.0.121 (installed now).
4. **LBH**: worked 1 (total 1); 14:50 to 14:50; build 1.0.121 (installed now).
5. **LBUH**: worked 2, cancelled 1 (total 3); 14:49 to 18:41; build 1.0.121 (installed now).
6. **SBEAM**: cancelled 1 (total 1); 18:36 to 18:36; build 1.0.121 (installed now).

## 4. Used successfully (use evidence, not an acceptance)

This lists commands that WORKED at least 2 times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5).

1. **Civil CDCHECKCURRENT** on build 3.0.69: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
2. **Civil CDEDIT** on build 3.0.69: worked 2 times, refused 0, warned 0, cancelled 1, no failure.
3. **Civil CDIMPORTXCIVIL** on build 3.0.69: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
4. **Civil CDINSPECTOR** on build 3.0.69: worked 6 times, refused 0, warned 0, cancelled 0, no failure.
5. **Civil PITSCHEDULE** on build 3.0.69: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
6. **Structural LBUH** on build 1.0.121 (installed now): worked 2 times, refused 0, warned 0, cancelled 1, no failure.

## 5. New warnings and errors (not seen on an earlier day)

1. **None.**

## 6. Ribbon clicks seen

1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).

## 7. What the logs could not tell us

1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim's normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.
2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.
3. **Manager** and the checkdwg / xcdimport tools write no per-command outcome here.
4. **Structural build number** is not in its logs; the installed build is read from the plugin file.
5. **Sources read:** ce_cvl_structured_20261022.log, native_grip_2027.log, runtime_20261022.jsonl, struct_commands_20261022.log, ce_struc_suite.log, ce_struc_structured_20261022.log.


---

## Run log

<!-- RUN LOG: newest first -->

### Run at 2026-10-22 19:00 Melbourne

1. **Since the last run:** 5 more command runs (worked 1, refused 0, cancelled 4, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 27, refused 2, cancelled 8, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** the 19:00 closing run.

### Run at 2026-10-22 18:30 Melbourne

1. **Since the last run:** 1 more command runs (worked 1, refused 0, cancelled 0, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 26, refused 2, cancelled 4, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** AutoCAD is running.

### Run at 2026-10-22 16:30 Melbourne

1. **Since the last run:** 31 more command runs (worked 25, refused 2, cancelled 4, warned 0, failed 0, unknown 0).
2. **Day so far:** worked 25, refused 2, cancelled 4, warned 0, failed 0, unknown 0; 0 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** a CE log changed.

