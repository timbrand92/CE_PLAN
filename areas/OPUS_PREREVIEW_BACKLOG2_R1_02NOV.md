# Opus pre-review, backlog second pass group r1: PRs #1893, #1894, #1886, #1012, #1014 (Structural)

Written Monday 2 November 2026, 01:50 Melbourne, by an independent read-only Opus reviewer for CE 05 (at CE 00's and CE 01's request).
Target line checked: `claude/rel-20261026s` at 204dfad2 (Structural 1.0.125, the installed Structural line), confirmed with `git ls-remote` at the time of review. Civil tip `claude/rel-20261102a` at 3fbb9da5.
Heads reviewed: #1893 4bfdbf62, #1894 0224c2e2, #1886 bb822e60, #1012 597439fb, #1014 aca6a37c. All five are DRAFT and OPEN.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the five diffs, the carpark entries (BUG-1136, BUG-1199, BUG-1183, BUG-499, BUG-502), the triage file `areas\DRAFT_BACKLOG_TRIAGE2_02NOV.md` and the decisions folder. None of the five has a `BUGFIX_*_REPORT` file; I judged from the diff, the PR description and the carpark entry. I ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.

## FOR TIM

1. **#1893, a damaged footing register is kept, never saved over (BUG-1136): CHANGE-NEEDED, Structural FULL.** The idea is right and is what the bug asks for. Example: footings 1 to 40 would no longer vanish from the schedule when you place footing 41. But it was written against an old copy of the footing code. The Structural line you have installed has a rewritten version of that code, so this cannot be dropped in. It has to be rebuilt on the Structural line.
2. **#1894, footing sizes removed by Undo are forgotten (BUG-1199): KEEP-WITH-NOTE, Structural area + smoke.** Example: THCL 81 at 600 x 600, U, THCL 82. CE now saves only 82, and typing 81 again asks you for the size. It drops onto the Structural line cleanly. U and REDO are safe: the size list is only read while a THCL-type command is running.
3. **#1886, pier schedule SYNC checks which pier each row is (BUG-1183): KEEP-WITH-NOTE, Structural area + smoke.** Example: you swap the 300 and 600 rows of the Bored Pier Schedule and run STRSCHEDSYNC. The piers keep their own sizes. It is already on the Structural line and merges cleanly. One gap is known: on a table with no HANDLE column, if you swap rows AND edit a value in the same go, CE writes by row position, as it does today.
4. **#1012, bracing panel leaves BT1 roof trusses out of the wall totals (BUG-499): CHANGE-NEEDED, Structural area + smoke, and it needs your word first.** Codex's note on this bug (14 Oct) says "wall-only" is your engineering decision and must not be changed without it. It also clashes in code with the newer bracing fix BUG-950 (mixed brace types show "unknown", not a tick), so it has to be redone either way.
5. **#1014, subfloor grid questions say "assumed" (BUG-502): KEEP-WITH-NOTE, Structural area + smoke.** By default only the wording of the CSSUBFLOORGRID questions changes, for example "Bearer size/species (assumed starter size, not checked)". Enter still gives 150x50 F17. It merges cleanly onto the Structural line.
6. **Merging:** all five touch the Structural Settings list and the top of the change log. Keep both sides in both places. #1893 and #1894 are on the Civil line and must be copied across as single changes (cherry-picks), not merged. A whole-branch merge would drag about 4,600 Civil-line changes into the Structural line.
7. **Settings tests:** only #1886 checks its new switch through CE's real settings reader at start-up. The other four check a simpler reader, so their "a settings file without the key reads the default" claim is likely true but not proven.
8. **Nobody has opened any of the five in AutoCAD.** All five are built and unit-tested only, and every bug stays OPEN. No test touched your real settings or AppData.

---

## DETAIL

### Group facts

1. **Bases.**
   1. #1886 is one commit on the Structural tip 204dfad2 (0 behind). `git merge-tree` onto the tip is clean, with no conflicts.
   2. #1893 and #1894 are one commit each on `claude/rel-20261102a` at 91963bd0 (11 behind the Civil tip). Their merge-base with the Structural line is 01380d16, with 4,622 commits on their side. **Never merge these branches into the Structural line; cherry-pick the single commit.**
   3. #1012 and #1014 are one commit each on `claude/rel-20261009t` c822a8ec, 295 commits behind the Structural tip. Cherry-pick or rebase.
2. **The triage claim "no two touch the same function" is true inside the group but not against the line.** #1893 conflicts with the Structural line's own rewrite of `FoundationRegistryService.Load` and `Invalidate`. #1012 conflicts with BUG-950 (b86a2f01) in `BracingPanelCalculator.Summarise` and `BracingPanelService.BuildSnapshot`.
3. **Simulated cherry-picks onto 204dfad2 (`git merge-tree --merge-base=<commit>^`):**
   1. **#1893:** conflicts in `UserSettings.cs` (keep both), `REGRESSION_LOG.md` (keep both) and **`FoundationRegistryService.cs` (real code conflict, see below)**.
   2. **#1894:** `CeTextService.cs` auto-merges. Conflicts in `UserSettings.cs` and `REGRESSION_LOG.md` only, keep both.
   3. **#1886:** clean.
   4. **#1012:** conflicts in `UserSettings.cs`, `REGRESSION_LOG.md`, **`BracingPanelCalculator.cs` and `BracingPanelService.cs` (real code conflicts)**.
   5. **#1014:** `UserSettings.cs` and `TimberSubfloorService.cs` auto-merge; `REGRESSION_LOG.md` only, keep both.
4. **Pairwise:** #1893 and #1894 both add a bool at the same place in `OptionsSettings` (keep both). #1012 x #1014 clash only in `REGRESSION_LOG.md`. #1886 adds to `ScheduleSetSettings`, #1012 to `BracingSettings`, #1014 to `TimberSubfloorSettings`, so there is no overlap except the log.
5. **Protected files:** none of the five touches `LinkService.Persistence.cs`, `ProjectDataService.Persistence.cs` or `RulebookEngine.cs`. #1886 *calls* Structural `ProjectDataService.ScanFromDrawing` (a read, the same call STRSCHEDREFRESH already makes at `ScheduleService.cs:195/303/333`).
6. **"Both start-up reads":** on the Structural line the real reader is `SettingsService.DeserializeSettingsTolerant`, used on the normal path and on the value-by-value path, then `EnsureDefaultsAndMigrate` (`SettingsService.cs:462`, `:668`). The pattern to copy is `Structural.Tests/Models/S45NewSwitchDefaultsTests.cs`. #1886 does this (`ScheduleRowIdentityTests.cs:189-205`). #1893, #1894, #1012 and #1014 use `new UserSettings()` and/or plain `JsonConvert.DeserializeObject` only. That is a test gap, not a known fault.

---

### #1893 BUG-1136: damaged footing register kept (CHANGE-NEEDED)

1. **What changes for the drafter.** If the footing register stored in the drawing exists but cannot be read, CE now does four things:
   1. It copies the stored text to `%APPDATA%\CE_STRUC_SUITE\Recovery\FootingRegister_DAMAGED_<drawing>_<time>.txt` (PR head `FoundationRegistryService.cs:168-180`).
   2. It prints one line.
   3. Every later `Save` prints "This footing change was NOT saved to the register" and writes nothing (`:58-62`).
   4. Nothing stored at all is still treated as empty and saves normally.

   This is exactly the carpark's "Expected behaviour" ("refuse every footing save with one plain line and leave the stored register untouched"). No decision overrides it.
2. **Why CHANGE-NEEDED: it targets old code.**
   1. On the Structural line (204dfad2), `Load` is `Memory.Load(GetDrawingKey(db), () => LoadCore(db))` (`:30`). The register memory is a separate `FoundationRegistryMemory` keyed by the drawing's native pointer. There are also `Query` readers (`:44`, `:55`, `:106`, `:147`) and `ForgetAfterCommand` after U, REDO and MREDO (`:128-132`).
   2. The PR replaces a `CacheByDrawing` dictionary that does not exist on this line.
   3. The bug itself is still live on the Structural line: `LoadCore` at `:292`, with the silent `?? new FoundationRegistryData()` at `:328` and the bare `catch` at `:336`. So the fix is still needed.

   What the re-port must do:
   1. **Carry the damaged mark next to `FoundationRegistryMemory`.** The mark must not be cleared by `ForgetAfterCommand`. If it is cleared, every U re-detects the damage, re-prints the line and writes another Recovery file. Clear it only on `ForgetDrawing` (close) and on `Invalidate`.
   2. **Make the `Query` readers see the damage as well,** not only `Load`. Example: `IsRegisteredDriverHandle` and `IsScheduleOutOfDate` currently read the cached empty register.
   3. **Print the refusal once per command, not once per `Save` call.** There are 17 save callers (14 in `FoundationService.cs`, 1 each in `.Grips`, `.LoadPath` and `.Marks`), so one footing command could print the same line several times.
   4. **Pin the switch through `DeserializeSettingsTolerant` on both paths.**
3. **Switch.** `Options.KeepDamagedFootingRegister`, default true. That is correct per R-00/R-27 practice (it fixes data loss). OFF: `ShouldRefuseSave(false, …)` is false and Load does not set the mark, so it saves over as before. The one difference with OFF is that `LoadCore` now returns an empty register instead of `?? new` on the same inputs. That is the same result, so the old behaviour is effectively exact. No engineering value is hard-coded.
4. **No-hard-blocks (R-27).** No modal window, and the drafter's command is not stopped: the footing is still drawn. Only the register write is refused. That is what the carpark asks for, and it protects data, so I accept it.

   Consequence to state on the line: footing 41 appears on screen but is not in the register or the schedule until the register is repaired. There is no repair route yet (BUG-1154 is the related cause). That is acceptable for a pilot, but the message should say what to do (for example "send the Recovery file to CE support") rather than only "until it is repaired".
5. **Protection and REDO.** No layer, Xref or REFEDIT path changes. The new write is a text file under the CE settings folder, outside the drawing, so it is REDO-neutral. **Risk:** the PR's `catch` marks the register damaged on *any* exception once the key is found (`:389`). A transient read error would then block footing saves for the rest of the session. The re-port should mark damaged only on a parse failure, or on an exception from the register record itself.
6. **Not proven, and an extra hazard to check.** With the mark set, `Load` hands back an EMPTY register. Any footing schedule regeneration in the same command could then rebuild the schedule table with no rows. That changes the drawing, and the refusal does not cover it. The robot must check this.
7. **Tests.** 12 pure tests (parse, damaged versus nothing stored, refusal truth table, copy-aside file name and text). They fail before the change only by not compiling (new methods). The copy test writes to `%TEMP%\CE-Footing-Damaged-<guid>` and deletes it. No test calls `SettingsService.Current` or touches the real AppData. Nothing tests the `Load`/`Save` wiring (a native Database aborts the test host), so the refusal in a real drawing is unproven.
8. **Robot (CE 02) and Codex.**
   1. Copy of a drawing with 3 pad footings and a placed footing schedule.
   2. Damage the register Xrecord text in the copy (truncate the JSON), save, reopen.
   3. THC to place footing 4. Expect one "could not be read" line and a file in `Recovery`. The register text must be byte-identical before and after, and the schedule table rows must be unchanged.
   4. U, then REDO: expect no second Recovery file and no repeated warning.
   5. Control with `KeepDamagedFootingRegister:false` set before launch: the old overwrite returns.

   No Codex window look is needed (no window change). The Settings checkbox is owed to Codex, as the PR says.
9. **Verdict: CHANGE-NEEDED.** Re-port onto `claude/rel-20261026s` against `FoundationRegistryMemory`, covering items 2.1 to 2.4 and 5. Train class: **Structural FULL** (every footing command saves through this).

### #1894 BUG-1199: footing sizes after Undo (KEEP-WITH-NOTE)

1. **What changes.** With the switch ON, `GetFstData` reads the size library from the drawing on every lookup and never fills the per-file memory (PR head `CeTextService.cs:5364`, `ResolveFstData`; `SaveFstData` skips the memory at `:5404`).

   Example: THCL 81 (600 x 600), U, THCL 82 (900 x 900). Only 82 is saved, and 81 asks again. This matches the carpark's "Read the current drawing library on each lookup and merge only the newly accepted entry before saving".
2. **Switch.** `Options.FootingSizesReadFromDrawing`, default true, fix-ON as is normal. OFF: `ResolveFstData(false, …)` is byte-for-byte the old cache logic, so the old behaviour is exact. No engineering value is added.
3. **R-27.** No new stop. Re-asking for a size is the intended behaviour, not a block.
4. **REDO.** The only callers of `GetFstData` on the Structural line are `TryGetOrPromptRectSize` (`CeTextService.cs:2167`) and `TryGetOrPromptSfWidth` (`:2205`). Both run inside a footing-text command, and that command then draws, so REDO is spent by the command itself, not by the read. There is no idle or panel read, so the BUG-256 trap (a transaction read straight after U throws REDO away) does not apply. No write happens during U or REDO. No layer, Xref or REFEDIT change.
5. **Note (more exposure to an old weakness).** `FstMemoryService.Load` swallows any read error and returns an empty library (`FstMemoryService.cs:70-73`). Before this change that could only happen at the first lookup for a drawing. Now it can happen on every lookup, and the next `Save` writes the whole library as "empty plus the new size". It is the same class as BUG-1136, not new, but worth one line in the log and a robot check.
6. **Merge.** The cherry-pick auto-merges `CeTextService.cs` onto 204dfad2. The Structural line's `GetFstData` (`:5544-5557`) and `SaveFstData` (`:5559-5572`) match the PR's starting text. Keep both sides in `UserSettings.cs` (beside #1893 and the BUG-256 switch in `OptionsSettings`) and in `REGRESSION_LOG.md`.
7. **Tests.** 4 tests on the pure `ResolveFstData` with a fake loader. They fail before by not compiling. `SwitchOff_OldMemoryReturnsExactly` proves the old fault is reproduced with the switch OFF, which is good. No real Undo is tested. No AppData is touched. The switch is not pinned through `DeserializeSettingsTolerant` (add one test).
8. **Robot.** Use the carpark case: a fresh unique drawing; THCL 81 (600 x 600, centre 0,0, text 500,500); U; THCL 82 (900 x 900, centre 2000,0). Read FST_DATA/TH after each step: only 82 should be there. Then THCL 81 must ask for the X size. Control: switch false, set before launch, and 81 is reused. No Codex look is needed.
9. **Verdict: KEEP-WITH-NOTE.** Before merge, add the tolerant-reader test and the log line about the empty-read exposure. Cherry-pick, never merge the branch. Train: **Structural area + smoke**.

### #1886 BUG-1183: pier schedule SYNC row identity (KEEP-WITH-NOTE)

1. **What changes.** Before writing, STRSCHEDSYNC now checks each Bored Pier Schedule row against its pier (`ScheduleService.cs:777-812` at the PR head, new `ScheduleRowLink.ReconcileRowIdentity`):
   1. **With a HANDLE column:** the handle printed on the row wins when it is one of the recorded piers. An unknown handle, or one shown on two rows, leaves those rows alone and prints a plain line.
   2. **Without a HANDLE column:** rows are matched by MARK / DIA MM / VISIBILITY, but only when the set is exactly the drawing's piers in a different order. Anything else is treated as an ordinary edit and written by position, as before.

   This is what the carpark asks for ("use a validated row identity … if ambiguous, leave only those rows unchanged and say why").
2. **Switch.** `ScheduleSet.PierSyncChecksRowIdentity`, default true, pinned through `DeserializeSettingsTolerant` on both paths and with a saved OFF (`ScheduleRowIdentityTests.cs:189-205`). OFF: `identity` stays null and the loop calls the old `HandleForRow`, so the old behaviour is exact (source guard at `:212`). No engineering value is added.
3. **R-27.** No stop or modal window. Rows CE cannot place are skipped with a line. That is a warning plus "leave alone", which is allowed.
4. **Protection and REDO.**
   1. It writes the same `Visibility1` property in the same transaction as before.
   2. A pier on a locked layer behaves exactly as today. `GetObject ForWrite` was already there, so this PR does not change it. (BUG-503 item 7 already covers the raw error word on a locked layer.)
   3. The new `ProjectDataService.ScanFromDrawing(table.Database)` (`:797`) runs a nested transaction-manager read inside SYNC's own command transaction. That is fine inside a command, and REDO is spent by SYNC's write anyway.
   4. It replaces `ProjectDataService.Current` with a fresh scan that keeps confirmed job data, the same as STRSCHEDREFRESH does.
   5. It is only called in the no-HANDLE-column path, and only once.
5. **Note.** The no-HANDLE match relies on two things matching the scanned pier: the table's DIA MM text must equal `FormatPierDiameter` (`ScheduleService.cs:478`), and the VISIBILITY text must equal the pier's `Visibility`. Both are written by the same code when the table is made (`:462-463`). If a drafter retyped "600" as "600.0", the match fails safe: it falls back to by-position, which is today's behaviour. The scan reads model space only, so piers elsewhere also fall back to by-position.
6. **Merge.** One commit on the tip, merge-tree clean. In the group it clashes only in `REGRESSION_LOG.md` and `UserSettings.cs` (a different class, so a textual keep-both at most).
7. **Tests.** 17 focused tests on the pure rule, including the RD14-01 fixture with and without a HANDLE column, an ordinary edit, a duplicate or unknown handle, an erased pier and twin piers. They fail before by not compiling. The behavioural "before" is pinned by the existing `ScheduleRowLinkTests`. No AppData is touched. The real table write is not tested.
8. **Robot (RD14-01).** BP 300 at 0,0 and BP 600 at 3000,0; STRSCHEDCREATE; STRSCHEDREFRESH; swap data rows 2 and 3 with the supplied AutoLISP; STRSCHEDSYNC.
   1. Read each pier's Visibility1: 300 stays 300 and 600 stays 600, and the "matched each row … by the HANDLE" line appears.
   2. Repeat with `PierTableWithoutLayerAndHandle` true.
   3. One row 600 to 300 without moving rows: that pier changes.
   4. Control: switch false, set before launch, and the swap resizes the wrong piers as before.

   A Codex look is not needed.
9. **Verdict: KEEP-WITH-NOTE.** The note is the known mixed swap-and-edit gap; it must stay in the bug entry. Train: **Structural area + smoke**.

### #1012 BUG-499: bracing panel leaves BT1 roof trusses out (CHANGE-NEEDED)

1. **What changes.** `BracingPanelCalculator.Summarise` skips any instance whose type starts with "BT" (`BracingPanelCalculator.cs:82` at the PR head; `IsRoofTruss`). CSBRACINGPANEL then shows wall bracing only.

   Example: 2700 AB plus 4000 BT1 running north-south against 5000 required. Before, the panel read 6700 provided; after, it reads 2700 with a cross. The "BT" prefix covers what BT1 really writes (Codex saw a "BT9" tag placed by BT1, carpark BUG-499, 14 Oct).
2. **Why CHANGE-NEEDED: two reasons.**
   1. **An engineering decision is open.** The carpark's 14 Oct Codex observation says: "Keep proposed wall-only/type combination rules as unresolved engineering decisions … no unauthorised total-rule repair". The original entry also says "Right result (I think)". RULES 4.5 says engineering-judgement items need Tim's word. So CE 00 cannot settle this alone; it goes in Tim's next question batch with a recommendation. I recommend leaving BT out: roof bracing trusses are not wall bracing under AS 1684.2, so counting them overstates wall capacity. Decision 168 (29 Oct) parks only "bracing lengths per job", not this, and I found no ruling on BT in the wall totals.
   2. **The code conflicts with BUG-950** (b86a2f01, `Bracing.UnknownWhenTypesDiffer`, ON, `UserSettings.cs:816` on the Structural line). On the Structural line `Summarise` already has a fourth optional bool, `unknownWhenTypesDiffer`, and it gathers each direction's types (`:63-104`). The re-port must:
      1. Add `includeRoofTrusses` as a fifth parameter.
      2. Skip BT instances **before** they are added to the per-direction type set. Otherwise a BT truss alone makes "types differ" and turns a direction "unknown".
      3. Pass both bools by name in `BracingPanelService.cs:22` and `:31`. A careless keep-both could put `PanelCountsRoofTrusses` into the `unknownWhenTypesDiffer` slot. The PR's source guard (`includeRoofTrusses: settings.PanelCountsRoofTrusses`) would catch half of that.
3. **What the bug looks like on today's Structural line.** With BUG-950 in, A plus BT1 in one direction already shows "unknown", not a green tick. But the total still reads 6700. A direction with BT trusses only (one type) still turns green against a wall requirement. So the fault is real today, only partly hidden.
4. **Switch.** `Bracing.PanelCountsRoofTrusses`, default false (the new behaviour). true restores the old sum exactly. This setting is phrased the other way round from the usual "switch ON = fix", which is acceptable, but if Tim rules the other way the default flips. The default is pinned only with `new BracingSettings()`; add the tolerant-reader test. No engineering value is hard-coded beyond the "BT" prefix rule.
5. **R-27, protection and REDO.** The panel is read-only and goes through the open-close scan (BUG-256), so REDO is kept. No stops and no drawing writes.
6. **Tests.** Two calculator tests (BT1 left out and the setting brings it back) and two Structural tests (default and source guard). They fail before by not compiling. No AppData is touched.
7. **Robot.** CSBRACINGREQUIRED North-South 5000; one 2700 AB north-south; one 4000 BT1 north-south; CSBRACINGPANEL.
   1. Expect 2700 provided and a cross.
   2. Add a second case with BT1 only and no wall braces: expect 0 and a cross, not a green tick.
   3. Control: `PanelCountsRoofTrusses:true`, set before launch, gives 6700 and unknown (BUG-950).

   A Codex look at the panel window is needed for the "no type" line the PR defers.
8. **Verdict: CHANGE-NEEDED.** Hold for Tim's ruling on "BT out of wall totals". Then re-port onto `claude/rel-20261026s` on top of BUG-950 as in 2.2, and add the tolerant-reader test. Train: **Structural area + smoke**.

### #1014 BUG-502: subfloor grid says "assumed" (KEEP-WITH-NOTE)

1. **What changes.** The CSSUBFLOORGRID and CSTAGBEARERS questions now say "(assumed starter figure)" for the spacings and "(assumed starter size, not checked)" for the sizes (`TimberSubfloorService.cs:79-82`, `:175`, `:182` at the PR head). A new `TimberSubfloor.OfferStarterSizes` set to false gives no size default: Enter then reads "Unknown" (`SizeDefault`, `:443`).

   This covers the carpark's "the word 'assumed' wherever a starter figure is offered" in full. The carpark's "no size default unless Tim has set one" is covered only as an option, because the default keeps today's sizes. That follows INT-073 (build on the recommended answer and keep today's behaviour until Tim answers), and it is correct per R-00/R-27 practice.
2. **Switch.**
   1. Default true means today's sizes, so OFF = old is not quite exact.
   2. One small change at the default: a configured size that is blank now offers "Unknown" instead of a blank. That is harmless and arguably right, but it is not byte-identical, so say so in the log.
   3. The prompt wording changes regardless of the setting.
   4. The spacings 3000 and 1800 are already Settings values (R-00), not hard-coded.
   5. Pin the default through the tolerant reader.
3. **R-27, protection and REDO.** These are wording and default changes only. Nothing changes in the stops, layers, Xref, REFEDIT or REDO behaviour.
4. **Merge.** The cherry-pick onto 204dfad2 auto-merges the code. The Structural line's prompts at `:81-82`, `:175` and `:182` match the PR's starting text. Only `REGRESSION_LOG.md` needs a keep-both.
5. **Tests.** 5 tests (default, `SizeDefault` three ways and a source guard on the four prompt texts). They fail before by not compiling. No AppData is touched.
6. **Robot.** CSSUBFLOORGRID on a 10 x 8 m closed polyline, Enter at every question, Yes.
   1. Each prompt contains "assumed", and the bearers are tagged 150x50 F17.
   2. Control: `OfferStarterSizes:false` set before launch, and the bearer tag reads "Unknown".

   No Codex look is needed beyond the owed Settings row.
7. **Verdict: KEEP-WITH-NOTE.** Add the tolerant-reader test and a log line about blank becoming Unknown. Train: **Structural area + smoke**. Last in the group, as the triage says.

### What I could not verify

1. I did not build or run any test, so the PR authors' green counts are taken from their descriptions.
2. I did not try the #1893 or #1012 re-ports, so the extra work is estimated from reading the conflicts, not measured.
3. I did not trace every one of the 17 footing save callers in #1893 to count how many fire in one THC.
4. The "empty schedule after a damaged register" hazard in #1893 is reasoned from the code shape, not traced end to end.
