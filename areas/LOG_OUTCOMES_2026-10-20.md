<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->
_Updated 2026-10-21 03:09 Melbourne time._

# CE log outcomes: Tue 20 Oct 2026 00:00 to Tue 20 Oct 2026 23:59 (Melbourne time, PC clock)

**Answer first.**

1. **Commands seen:** 122 command runs in the logs (70 with a start/end line or a command record, 52 recognised from lines or files that name the command).
2. **Worked:** 87. **Refused (CE said no in plain words):** 29. **Cancelled:** 0. **Warned:** 4. **Failed:** 2. **Unknown (no outcome line):** 0.
3. **New warnings/errors today:** 3 message types not seen on an earlier day. **Failure candidates added:** 0.
4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim's use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.
5. **Read:** 9 files, 57888 lines; 51 warnings/errors outside any command run.
6. **Background sync steps (not counted above):** 23. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it.

## 2. Civil: every command, by outcome

1. **CD**: worked 14 (total 14); 05:36 to 21:58; build 3.0.58 to 3.0.66 (9 builds).
2. **CDCHECKS**: worked 1 (total 1); 12:03 to 12:03; build 3.0.60.
3. **CDEDIT**: worked 11 (total 11); 05:27 to 22:02; build 3.0.58 to 3.0.66 (9 builds).
4. **CDFIXTAGS**: failed 2 (total 2); 05:41 to 10:28; build 3.0.58, 3.0.59.
   - **failed:** CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. (x6, first 05:41)
   - **refused:** [Spine] source identity refused for 119FF8: OtherKindOfObject (key CE-CIV-PIT-9C4A3335-7CA4-4853-A791-5D64020776FA). (x2, first 05:41)
   - **refused:** [Source] CDFIXTAGS not renamed: block 109474 AGI -> AGI 1: A source child does not have exactly one matching claim by the selected source. (x6, first 05:41)
5. **CDINSPECTOR**: worked 9 (total 9); 12:02 to 22:12; build 3.0.60 to 3.0.66 (6 builds).
6. **CDRECOVERINVERTS**: worked 5 (total 5); 12:03 to 21:59; build 3.0.60 to 3.0.66 (5 builds).
7. **CDRULES**: worked 13 (total 13); 05:23 to 22:00; build 3.0.58 to 3.0.66 (9 builds).
8. **CDSYNC**: worked 5 (total 5); 12:11 to 22:06; build 3.0.60 to 3.0.66 (5 builds).
9. **CDTAG**: refused 2 (total 2); 05:42 to 10:28; build 3.0.58, 3.0.59.
   - **refused:** CDTAG failed: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. [OtherKindOfObject] (x2, first 05:42)
10. **CDTIDYLABELS**: worked 2, refused 27 (total 29); 05:38 to 22:13; build 3.0.58 to 3.0.66 (9 builds).
   - **refused:** [TidyUp] pipe P4 -> P3 label: no clear spot among its usual positions, left where it is (on "SC"). (x18, first 05:38)
   - **refused:** [TidyUp] pipe P4 -> P3 end invert text: no clear spot among its usual positions, left where it is (on "pit P3"). (x1, first 05:38)
   - **refused:** [TidyUp] pipe P4 -> P3 start invert text: no clear spot among its usual positions, left where it is (on "pit P4"). (x1, first 05:38)
11. **CDTWL**: worked 8 (total 8); 15:31 to 22:00; build 3.0.63 to 3.0.66 (4 builds).
12. **PIT**: worked 12 (total 12); 05:35 to 21:56; build 3.0.58 to 3.0.66 (9 builds).
13. **PITSCHEDULE**: worked 7, warned 4 (total 11); 12:09 to 22:07; build 3.0.60 to 3.0.66 (5 builds).
   - **warned:** [REDO] 1 write(s) reached the drawing between the end of REDO and the start of PITSCHEDULE; AutoCAD discards its Redo list after a write, so Redo was not available in that gap. (x4, first 12:09)

## 3. Structural: every command, by outcome

1. **No command runs found in this period.**

## 4. Used successfully (use evidence, not an acceptance)

This lists commands that WORKED at least 2 times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5).

1. **Civil CD** on build 3.0.58: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
2. **Civil CD** on build 3.0.59: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
3. **Civil CD** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
4. **Civil CD** on build 3.0.65: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
5. **Civil CDEDIT** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
6. **Civil CDEDIT** on build 3.0.65: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
7. **Civil CDINSPECTOR** on build 3.0.61: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
8. **Civil CDINSPECTOR** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
9. **Civil CDINSPECTOR** on build 3.0.66: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
10. **Civil CDRULES** on build 3.0.58: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
11. **Civil CDRULES** on build 3.0.64: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
12. **Civil CDRULES** on build 3.0.66: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
13. **Civil CDTWL** on build 3.0.63: worked 3 times, refused 0, warned 0, cancelled 0, no failure.
14. **Civil CDTWL** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
15. **Civil CDTWL** on build 3.0.65: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
16. **Civil PIT** on build 3.0.59: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
17. **Civil PIT** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
18. **Civil PIT** on build 3.0.65: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
19. **Civil PITSCHEDULE** on build 3.0.64: worked 2 times, refused 0, warned 0, cancelled 0, no failure.
20. **Civil PITSCHEDULE** on build 3.0.66: worked 2 times, refused 0, warned 0, cancelled 0, no failure.

## 5. New warnings and errors (not seen on an earlier day)

1. **[ERR] Civil, CDFIXTAGS:** CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. [OtherKindOfObject] (x2, first 05:41)
2. **[WRN] Civil, CDFIXTAGS:** [Source] CDFIXTAGS not renamed: block 119FF8 DP3 -> DP4: This block already carries the CE identity of another kind of object (such as a pit), not a source block, so CDFIXTAGS left it as it was. (x2, first 05:41)
3. **[ERR] Civil, CDTAG:** CDTAG failed: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. [OtherKindOfObject] (x2, first 05:42)

## 6. Ribbon clicks seen

1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).

## 7. What the logs could not tell us

1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim's normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.
2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.
3. **Manager** and the checkdwg / xcdimport tools write no per-command outcome here.
4. **Structural build number** is not in its logs; the installed build is read from the plugin file.
5. **Sources read:** ce_cvl_structured_20261020.log, native_grip_2027.log, runtime_20261020.jsonl, ce_struc_suite.log, ce_struc_structured_20261020.log.


---

## Run log

<!-- RUN LOG: newest first -->

### Run at 2026-10-21 03:09 Melbourne

1. **Since the last run:** 122 more command runs (worked 87, refused 29, cancelled 0, warned 4, failed 2, unknown 0).
2. **Day so far:** worked 87, refused 29, cancelled 0, warned 4, failed 2, unknown 0; 3 new warning/error types; 0 new failure candidate(s) this run.
3. **Why it ran:** backfill of a past day.

