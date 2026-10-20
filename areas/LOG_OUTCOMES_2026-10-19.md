<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->
_Updated 2026-10-21 03:09 Melbourne time._

# CE log outcomes: Mon 19 Oct 2026 00:00 to Mon 19 Oct 2026 23:59 (Melbourne time, PC clock)

**Answer first.**

1. **Commands seen:** 20 command runs in the logs (8 with a start/end line or a command record, 12 recognised from lines or files that name the command).
2. **Worked:** 16. **Refused (CE said no in plain words):** 2. **Cancelled:** 0. **Warned:** 0. **Failed:** 1. **Unknown (no outcome line):** 1.
3. **New warnings/errors today:** 1 message types not seen on an earlier day. **Failure candidates added:** 0.
4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim's use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.
5. **Read:** 3 files, 41096 lines; 22 warnings/errors outside any command run.
6. **Background sync steps (not counted above):** 14. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it.

## 2. Civil: every command, by outcome

1. **CD**: worked 3, unknown 1 (total 4); 12:51 to 23:26; build 3.0.56, 3.0.57.
2. **CDEDIT**: worked 2 (total 2); 12:28 to 23:12; build 3.0.56, 3.0.57.
3. **CDFIXTAGS**: failed 1 (total 1); 12:48 to 12:48; build 3.0.56.
   - **failed:** CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. (x3, first 12:48)
   - **failed:** CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. (x1, first 12:48)
   - **refused:** [Source] CDFIXTAGS not renamed: block 109474 AGI -> AGI 1: A source child does not have exactly one matching claim by the selected source. (x3, first 12:48)
4. **CDRECOVERINVERTS**: worked 1 (total 1); 12:53 to 12:53; build 3.0.56.
5. **CDTIDYLABELS**: refused 2 (total 2); 12:52 to 23:21; build 3.0.56, 3.0.57.
   - **refused:** [TidyUp] pipe 11C65B start invert text: no clear spot among its usual positions, left where it is (on "pit P8"). (x1, first 12:52)
   - **refused:** [TidyUp] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border"). (x3, first 12:52)
   - **refused:** [TidyUp] a pipe's start invert text: no clear spot among its usual positions, left where it is (on "pit P8"). (x1, first 23:21)
6. **PIT**: worked 2 (total 2); 12:50 to 23:19; build 3.0.56, 3.0.57.

## 3. Structural: every command, by outcome

1. **CECHECKLIST**: worked 1 (total 1); 15:15 to 15:15; build 1.0.118 (installed now).
2. **CEHATCH**: worked 1 (total 1); 14:52 to 14:52; build 1.0.118 (installed now).
3. **CESETTINGS**: worked 1 (total 1); 14:42 to 14:42; build 1.0.118 (installed now).
4. **Q**: worked 1 (total 1); 15:13 to 15:13; build 1.0.118 (installed now).
5. **RCBEAM**: worked 1 (total 1); 14:45 to 14:45; build 1.0.118 (installed now).
6. **RCCIRCCOL**: worked 1 (total 1); 14:49 to 14:49; build 1.0.118 (installed now).
7. **RCRECTCOL**: worked 1 (total 1); 14:47 to 14:47; build 1.0.118 (installed now).
8. **SBEAM**: worked 1 (total 1); 14:44 to 14:44; build 1.0.118 (installed now).

## 4. Used successfully (use evidence, not an acceptance)

This lists commands that WORKED at least 2 times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5).

1. **Civil CD** on build 3.0.57: worked 2 times, refused 0, warned 0, cancelled 0, no failure.

## 5. New warnings and errors (not seen on an earlier day)

1. **[WRN] Civil, CDFIXTAGS:** [Source] CDFIXTAGS not renamed: block 119FF8 DP3 -> DP4: CE could not match this source block to the drawing's own records, so nothing was changed. Run CDREPAIR, then try again. (x1, first 12:48)

## 6. Ribbon clicks seen

1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).

## 7. What the logs could not tell us

1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim's normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.
2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.
3. **Manager** and the checkdwg / xcdimport tools write no per-command outcome here.
4. **Structural build number** is not in its logs; the installed build is read from the plugin file.
5. **Sources read:** ce_cvl_structured_20261019.log, native_grip_2027.log, runtime_20261019.jsonl, ce_struc_suite.log, ce_struc_structured_20261019.log.


---

## Run log

<!-- RUN LOG: newest first -->

### Run at 2026-10-21 03:09 Melbourne

1. **Since the last run:** 20 more command runs (worked 16, refused 2, cancelled 0, warned 0, failed 1, unknown 1).
2. **Day so far:** worked 16, refused 2, cancelled 0, warned 0, failed 1, unknown 1; 1 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** backfill of a past day.

