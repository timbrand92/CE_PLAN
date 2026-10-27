# Robot draft cases N01 to N12: pre-flight check before the robot runs them (27 Oct 2026)

Written Tue 27 Oct 2026, about 22:30 Melbourne, by an Opus pre-flight checker (reading only). No AutoCAD, Codex, accoreconsole, build or install was started. Installed build read from the DLL: Civil 3.0.83+96455f13 (branch claude/rel-20261026x). Checked against: that branch's source (read with git show), the passing cases in `C:\Lisp Files\_ACAD_DRIVER\cases`, the run reports in `runner-reports` and the Codex D3, D4, D5, D7 and D8 reports.

## ANSWER FIRST

### FOR TIM

1. **Result:** 11 of the 12 new robot checks are ready to run. 1 is not (N10, "hide grade in the pipe label"). 0 needed a wording fix.
2. **Ready to run (11):** N01 CDREBUILD warns and never saves, N02 EXPLODE a pit, N03 OF and FO, N04 downpipe and raingarden with no pipe, N05 pit label and cover level, N06 office layers, N07 Undo names, N08 CDRENUMBER, N09 Pit Schedule order, N11 Edit Pipe cascade levels in the schedule, N12 COPY of a pit.
3. **Fixed (0):** every typed command, prompt answer and expected sentence matched CE's own wording in the installed build.
4. **Doubtful (1): N10.** It tries to switch "Show grade in pipe text" off in your settings file before AutoCAD starts. But CE keeps that switch in a second file (your "last values used" file) and that second file wins. So the label would still read "... AT 1 IN 200" and the check would fail even though CE is right. I put a "do not run" note at the top of N10 and its twin. It needs a new route, or a Codex look that clicks the button.
5. **What it saves:** skipping N10 saves about 25 minutes of AutoCAD time and stops a false "fault" being reported.
6. **Biggest risks for the robot run:**
   1. **The 8:30 am stop.** The runner still refuses to start AutoCAD in your weekday hours unless the job switches on its "Tim is away" setting. The job file does not say to. If the run goes past 8:30 am Wednesday, the rest comes back BLOCKED.
   2. **Four routes the robot has never driven:** typed corners into the raingarden outline (N04), a mouse click to place the cover text (N05), and two never-read numbers: the schedule levels after the cascade (N11) and the raingarden area of 12.0 m² (N04). If one of these trips, it is a route problem, not a CE fault.
   3. **One very long CE sentence (N01):** the CDREBUILD warning is 270 characters. The longest CE line the robot has read so far is 214. If AutoCAD's log splits long lines, N01's first check fails on wording although CE is right.
7. **Something the desk should know (not a draft mistake):** the robot's safety net restores your 4 settings files after every run, but not your "last values used" file. That file was rewritten tonight at 21:22 during robot runs. So every robot PIT or CD changes the pit size, cover level and pipe size CE offers you next.
8. **What you need to do:** nothing.

---

## Technical detail

### A. Per draft (main case and twin)

1. **N01 CDREBUILD (ready).** Every line matches `LinkCommands.cs` CdRebuild at 96455f13 (warning first, "CDREBUILD complete: {pits} pits, {pipes} pipes", the last "does not save" line; no prompt). Codex D4-02 saw "11 pits, 49 pipes" on an untouched copy, which agrees with R13's 12 and 50 after SETUP-R47 (one pit and one pipe added). CDREBUILD is in `command-registry.json` (line 510), so the outcome logger writes "Command outcome: CDREBUILD completed". UNCONFIRMED by a run: the U echo word (CDSYNC, built the same way, echoes CDSYNC in R13). Twin: the same save-copy route as R04_SAVE_BROKEN (failed as intended on 3.0.83, runs x83a3 and x83b3). Run it alone and last.
2. **N02 EXPLODE (ready).** `ExplodeLeftScheduleMessagePolicy.Describe` builds exactly "P3 is now plain linework and has left the schedule; 6 pipes now have ends not connected yet. U restores it." The six pipe handles and their layer come from R19b. The Pit Schedule is opened, read and closed exactly as R13 does. Its own undo step makes the first U echo PITSCHEDULE (R13, Codex D3-05). Sub-rows such as "Pit P3, pipe from WT10=" do not match "Pit P3=", so the not-contains check is sound. Twin fails on the restore check (no U), the right reason.
3. **N03 OF and FO (ready).** OF and FO go through the same `RunTaggedSourceCommand` as DP. The robot drove DP by typed route on 3.0.83 tonight (R09, "Downpipe placed. Tag: DP1. Nothing nearby. ...", with the next-DP prompt seen). Tonight's run also shows CE does not treat the robot's typing as a script. "[CE] Stopped. Everything placed stays; U takes back the last one." is printed once per Esc (`PlacementContinuationService.cs` line 71), so the count of 2 is right. Not read back by any run: the effective block name OVERFLOW (taken from the `BlockService` constant). Twin fails on the FO line, the right reason.
4. **N04 downpipe and raingarden (ready, risk).** "DOWNPIPE DYNAMIC WITH MASK" is confirmed as the name read back in R09 on 3.0.83. The CDRG prompts and keywords (Close, Place/Skip <Skip>) match the source. `RaingardenPlacementPlan.AreaText` prints the area with one decimal plus " m²". INSUNITS 4 on DRV1_B1 is confirmed by Codex V10 and D3, so a 4000 x 3000 outline prints "4 vertices, 12.0 m²". The check "placed. 4 vertices, 12.0 m" matches that. Risk: the robot has never typed points into CDRG's drag prompt. Twin (no U) fails for the right reason only if CDRG placed.
5. **N05 pit label and cover level (ready, risk).** Label prompt, PIT LABEL block on STORMWATER PIT LABEL, PIT_LABEL attribute = pit number, "Pit placed successfully." and "[CE] Pit placed. Pick the next pit, or press Esc to stop." are all confirmed (`PitCommand.cs`; R01 counts the last line on the mouse route). The cover text is "CL " + the typed cover level exactly as typed (`PitAnnotationTextFormatter.FormatCoverText`). The IL line is off (remembered pit.showInvert false). So "CL 19.000" is right. The first new pit is P8 (Codex D4-03, D8-05). Risk: the cover-text click at 151500,-81500 is new. Twin: linking.pitLabelOnEsc is absent from CD_Settings.json (default off), so Esc leaves no label and no cover text: right reason.
6. **N06 office layers (ready, strong).** On 3.0.83 tonight, SETUP-P8 in R04_SAVE_BROKEN (run x83b3) added exactly 6 objects: the pit on STORMWATER PIT, the pipe on STORMWATER PIPE, the label on 25TEXT, two IL texts on 20TEXT and the arrow on ARROW. None is on 0 or BLOCKS. CLAYER is on the v3 setvar list, so the twin's change to 0 is allowed.
7. **N07 Undo names (ready).** Both keys sit under `options` (OptionSettings: autoCadStyleCdPrompts, cdCommandLine.sayWhatWasUndone). Neither is a remembered value, so the guard's setting holds. The [Undo] answer lives in the draw-first point collection, and draw-first is on in Tim's file (options.cdDrawFirst true). The sentence is "Undid: " + "point 3 of the pipe route" + "." (`CdCommandLineSpecRules`); off gives "Last point taken back." (twin, right reason). The PIT and MOVE parts copy SETUP-P8 and R12.
8. **N08 CDRENUMBER (ready).** Prompts and lines match `PitRenumberCommand.cs`. Codex D5-01 saw the same lines on an untouched copy, including the "[Yes/No] <No>:" display and U echo CDRENUMBER. Schedule rows after Yes and after U are DERIVED (planner's note stands). Twin answers No and fails on the P10 row: right reason.
9. **N09 Pit Schedule order (ready, strong).** The R13 run RUN-20261027-1842 rows read Pit P1 ... P7, P8 (added by SETUP-R47), P9, P10, in that order. P9 and P10 exist on the untouched copy (Codex D4-03; CDREBUILD names them). The regex lookaheads are sound on the single-line ui-cells text.
10. **N10 hide grade (doubtful, do not run).** `pipe.nonExistingPipeShowGrade` is in `SettingsService.RememberedValuePaths`, and `LoadFromDisk` lays `CD_RecentValues.json` on top of `CD_Settings.json`. That file on this PC holds the key as true (read 22:15). The guard and v2 settings-temp accept only CD_Settings.json, CS_Settings.json and settings.json. So the SETTING line has no effect and the case fails for a route reason. Its twin fails for a meaningless reason. Change made: one PREFLIGHT comment line at the top of both files (originals kept as `.pre_preflight` beside them); no step or check changed.
11. **N11 cascade levels in the schedule (ready, risk).** Same route as R11 (accepted on 3.0.80). Codex D3-01 ran it on an untouched copy with the same result: "Updated 4 pipes and 3 pits from P3 (IL 17.50)", P3 17.30 to 17.50 and 17.25 to 17.45, P2 17.13 to 17.33 and 17.08 to 17.28, U echo CDEDIT, REDO "Everything has been redone", final U CDEDIT. The rows-before pattern matches the recorded P3 and P2 rows exactly. The after-cascade cells are DERIVED. The patterns accept 2 or 3 decimals: new levels show 3 decimals in the schedule ("18.000" for P8), fixture levels 2.
12. **N12 COPY (ready, strong).** The COPY chain is the one R33 drove: it ends cleanly at "<Exit>:", one U echoes COPY and puts the count back (RUN-20261026-0706-C3.0.78-b4c2). "1 pit copied and numbered as new. Check levels: ..." matches `CopiedLevelsRule.CommandLineSummary`. P8 is confirmed by Codex D3-04. Twin (expects P3) fails for the right reason.

### B. Checks made for every draft

1. **Format check:** `case_runner.ps1 validate` on the draft folder: 24 file(s) checked, 0 invalid. Run before and after the N10 comment. The `.pre_preflight` copies are not picked up as cases.
2. **3.0.82 to 3.0.83:** the source changes (C-73) are BUG-861 diagnostic switches, all default off (`DiagSettings.cs`, `LinkService.Reactors.cs`, `PostUndoWriteWatch.cs`, `RedoGapWatch.cs`). No command, prompt or message used by the drafts changed.
3. **Verbs:** every step and check verb used is handled in `case_runner_lib.ps1`. `select` "=" is exact and case-sensitive. `contains` and `history` are case-insensitive substrings. `equals` is case-sensitive after trimming. `matches` is a case-sensitive .NET regex. The drafts' quoting fits these rules.
4. **Twins:** every twin fails at a check, not at a step, so the ledger records it as a real red (from_check). N10_BROKEN is the exception in value only (see A10).

### C. Risks for the robot job, in order

1. **Tim's-hours guard:** `Get-CaseFreeMinutes` and `Test-V3InUseHours` still block weekday 8:30 am to 2:00 pm and 3:00 to 5:30 pm unless `CE_RUNNER_TIM_AWAY=1` is set. The job file `desk_jobs/tester_run69_validate_n_cases.txt` says "ignore the working-hours rule" but does not set the switch. Sessions after 8:30 am Wed 28 Oct would come back BLOCKED. A pointer case (N05) needs 22 free minutes and an unlocked screen.
2. **AutoCAD was already running at 22:23** (an AutoCAD command-line log on a CLD copy was being written). The job must wait for the lock, as it says.
3. **R11 and R13 not yet re-run on 3.0.83:** N02, N08 and N11 copy their schedule and U/REDO routes. 3.0.83 adds only default-off diagnostics, so no change is expected.
4. **Long line (N01):** see FOR TIM item 6.3. If check 1 fails while the evidence shows the sentence split over two log lines, that is a log matter, not a CE finding.
5. **Not-guarded remembered values:** `CD_RecentValues.json` (last modified 21:22 tonight, during robot runs) is outside the settings guard. Today's drafts do not depend on a value in it changing, but the robot's PIT and CD runs keep rewriting it. Desk to decide.

### D. What this check did not do (RULES 5.9)

1. Nothing was run in AutoCAD. Only the offline format check ran.
2. No review.txt, ledger, carpark, DESK_LOG, existing case, runner, driver or job file was touched. In the draft folder only the two N10 files gained one comment line each (originals kept as `.pre_preflight`).
3. The derived values (N04's 12.0 m², N08's rows after Yes, N11's cells) are reasoned from source and Codex, not seen.

## Summary

Read-only pre-flight of the 24 draft files against 3.0.83 source, passing cases and Codex reports. 11 of 12 main cases are ready to run. No wording fix was needed. N10 cannot work as written: its setting is overridden by CE's remembered-values file, which the guard cannot touch. It is marked do-not-run. The main risks are the runner's 8:30 am weekday block (CE_RUNNER_TIM_AWAY not set by the job), four routes or values the robot has never seen (N04, N05, N11), and N01's 270-character line.
