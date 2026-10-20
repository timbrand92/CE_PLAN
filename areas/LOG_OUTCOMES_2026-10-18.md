<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->
_Updated 2026-10-21 03:09 Melbourne time._

# CE log outcomes: Sun 18 Oct 2026 00:00 to Sun 18 Oct 2026 23:59 (Melbourne time, PC clock)

**Answer first.**

1. **Commands seen:** 62 command runs in the logs (23 with a start/end line or a command record, 39 recognised from lines or files that name the command).
2. **Worked:** 40. **Refused (CE said no in plain words):** 17. **Cancelled:** 1. **Warned:** 0. **Failed:** 2. **Unknown (no outcome line):** 2.
3. **New warnings/errors today:** 13 message types not seen on an earlier day. **Failure candidates added:** 0.
4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim's use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.
5. **Read:** 5 files, 50485 lines; 76 warnings/errors outside any command run.
6. **Background sync steps (not counted above):** 55. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it.

## 2. Civil: every command, by outcome

1. **CD**: worked 3, unknown 2 (total 5); 02:14 to 17:41; build 3.0.53, 3.0.54, 3.0.55.
2. **CDCHECKDWG**: worked 1 (total 1); 05:50 to 05:50; build 3.0.53.
3. **CDEDIT**: worked 4, refused 5 (total 9); 06:01 to 17:50; build 3.0.53, 3.0.54, 3.0.55.
   - **refused:** CDEDIT: pipe 10A98D has ambiguous pipe-text attachment ownership or roles; edit refused. Cause: A pipe-text-layer child has no exact supported text role: it is unclassified, recorded before CE stored… (x11, first 06:01)
4. **CDFIXTAGS**: failed 1 (total 1); 17:30 to 17:30; build 3.0.55.
   - **failed:** CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. (x3, first 17:30)
   - **failed:** CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. (x1, first 17:30)
   - **refused:** [Source] CDFIXTAGS not renamed: block 109474 AGI -> AGI 1: A source child does not have exactly one matching claim by the selected source. (x3, first 17:30)
5. **CDTAG**: failed 1 (total 1); 17:31 to 17:31; build 3.0.55.
   - **failed:** CDTAG failed: InvalidOperationException: The requested source tag is not unique in the drawing. (x1, first 17:31)
6. **CDTIDYLABELS**: refused 12 (total 12); 05:47 to 17:42; build 3.0.53, 3.0.54, 3.0.55.
   - **refused:** [TidyUp] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border"). (x14, first 05:47)
   - **refused:** [TidyUp] pipe P8 -> P11 end invert text: no clear spot among its usual positions, left where it is (on "pit P11"). (x1, first 08:44)
   - **refused:** [TidyUp] pipe P8 -> P11 label: no clear spot among its usual positions, left where it is (on "pit P11"). (x1, first 08:44)
7. **PIT**: worked 10 (total 10); 04:19 to 18:01; build 3.0.53, 3.0.54, 3.0.55.

## 3. Structural: every command, by outcome

1. **AD**: worked 3 (total 3); 09:46 to 09:58; build 1.0.118 (installed now).
2. **BL**: worked 3 (total 3); 09:45 to 09:57; build 1.0.118 (installed now).
3. **CECHECKLIST**: worked 1 (total 1); 11:32 to 11:32; build 1.0.118 (installed now).
4. **CEHATCH**: worked 1 (total 1); 11:12 to 11:12; build 1.0.118 (installed now).
5. **CESETTINGS**: worked 1 (total 1); 11:05 to 11:05; build 1.0.118 (installed now).
6. **CH**: worked 3 (total 3); 09:44 to 09:56; build 1.0.118 (installed now).
7. **FPFC**: worked 1 (total 1); 09:40 to 09:40; build 1.0.118 (installed now).
8. **LBUH**: worked 3 (total 3); 09:44 to 09:56; build 1.0.118 (installed now).
9. **PFC**: worked 1 (total 1); 09:40 to 09:40; build 1.0.118 (installed now).
10. **Q**: worked 1 (total 1); 11:31 to 11:31; build 1.0.118 (installed now).
11. **RCBEAM**: worked 1 (total 1); 11:08 to 11:08; build 1.0.118 (installed now).
12. **RCCIRCCOL**: worked 1 (total 1); 11:10 to 11:10; build 1.0.118 (installed now).
13. **RCRECTCOL**: worked 1 (total 1); 11:09 to 11:09; build 1.0.118 (installed now).
14. **SBEAM**: worked 1 (total 1); 11:07 to 11:07; build 1.0.118 (installed now).
15. **SM**: cancelled 1 (total 1); 09:38 to 09:38; build 1.0.118 (installed now).

## 4. Used successfully (use evidence, not an acceptance)

This lists commands that WORKED at least 2 times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5).

1. **Civil CD** on build 3.0.55: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
2. **Civil CDEDIT** on build 3.0.55: worked 4 times, refused 2, warned 0, cancelled 0, no failure.
3. **Civil PIT** on build 3.0.53: worked 5 times, refused 0, warned 0, cancelled 0, no failure.
4. **Civil PIT** on build 3.0.54: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
5. **Civil PIT** on build 3.0.55: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
6. **Structural AD** on build 1.0.118 (installed now): worked 3 times, refused 0, warned 0, cancelled 0, no failure.
7. **Structural BL** on build 1.0.118 (installed now): worked 3 times, refused 0, warned 0, cancelled 0, no failure.
8. **Structural CH** on build 1.0.118 (installed now): worked 3 times, refused 0, warned 0, cancelled 0, no failure.
9. **Structural LBUH** on build 1.0.118 (installed now): worked 3 times, refused 0, warned 0, cancelled 0, no failure.

## 5. New warnings and errors (not seen on an earlier day)

1. **[WRN] Civil, (no command marker):** [BUG-385] Project data for <dwg> could not be saved before CE switched to another drawing; it is kept and written at that drawing's next command or save. (x2, first 05:53)
2. **[WRN] Civil, (no command marker):** Runtime linking: the project record was the drawing's only unsaved change, so CE wrote it before the save question (BUG-190/BUG-257); if the close is cancelled, one U takes back only that record write (x3, first 05:56)
3. **[WRN] Civil, CDEDIT:** CDEDIT: pipe 10A98D has ambiguous pipe-text attachment ownership or roles; edit refused. Cause: A pipe-text-layer child has no exact supported text role: it is unclassified, recorded before CE stored… (x16, first 06:01)
4. **[WRN] Civil, CDEDIT:** PipeEdit: exact pipe-text roles unavailable for 10A98D — A pipe-text-layer child has no exact supported text role: it is unclassified, recorded before CE stored text roles. (x16, first 06:01)
5. **[WRN] Civil, (no command marker):** [NetworkEdit] MOVE: The AutoCAD geometry remains as edited, but CE did not change its linked records. Pipe 10A98D in the drawing does not match a single pipe in the project record. Run CE Repair/Audi… (x3, first 08:35)
6. **[ERR] Structural, (no command marker):** Error disposing palette: Object reference not set to an instance of an object. (x1, first 11:42)
7. **[WRN] Civil, (sync step: CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT):** LayerService: layer '25DIMS' is locked; properties were left unchanged. (x1, first 15:23)
8. **[WRN] Civil, (no command marker):** [InlineSplit] not split: No inline pipe segment found at owner point. considered=49, geometryRejected=41, hitboxRejected=8, nearestPipe=10A901, nearestDistance=23054.184. (x2, first 17:29)
9. **[ERR] Civil, CDFIXTAGS:** CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. (x3, first 17:30)
10. **[ERR] Civil, CDFIXTAGS:** CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. (x1, first 17:30)
11. **[WRN] Civil, CDFIXTAGS:** [Source] CDFIXTAGS not renamed: block 119FF8 DP3 -> DP4: The captured object has no unique matching drawing/project spine identity. (x1, first 17:30)
12. **[WRN] Civil, CDFIXTAGS:** [Source] CDFIXTAGS not renamed: block 109474 AGI -> AGI 1: A source child does not have exactly one matching claim by the selected source. (x3, first 17:30)
13. **[ERR] Civil, CDTAG:** CDTAG failed: InvalidOperationException: The requested source tag is not unique in the drawing. (x1, first 17:31)

## 6. Ribbon clicks seen

1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).

## 7. What the logs could not tell us

1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim's normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.
2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.
3. **Manager** and the checkdwg / xcdimport tools write no per-command outcome here.
4. **Structural build number** is not in its logs; the installed build is read from the plugin file.
5. **Sources read:** ce_cvl_structured_20261018.log, native_grip_2027.log, runtime_20261018.jsonl, struct_commands_20261018.log, ce_struc_suite.log, ce_struc_structured_20261018.log.


---

## Run log

<!-- RUN LOG: newest first -->

### Run at 2026-10-21 03:09 Melbourne

1. **Since the last run:** 62 more command runs (worked 40, refused 17, cancelled 1, warned 0, failed 2, unknown 2).
2. **Day so far:** worked 40, refused 17, cancelled 1, warned 0, failed 2, unknown 2; 13 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** backfill of a past day.

