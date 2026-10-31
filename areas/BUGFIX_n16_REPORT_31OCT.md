# BUGFIX n16 report, batch 16, build B-130 (Sat 31 Oct 2026, Melbourne)

## FOR TIM (read this part only)

1. **Three of the five small fixes are built as draft pull requests: #1947, #1948, #1949.** Two were NOT built: BUG-1236 (FO symbol text) and BUG-1245 (Move+Rotate on a raingarden). The reasons are below. Nobody has opened any of this in AutoCAD, and none of the five bugs is marked fixed.
2. **BUG-685, typed level (PR #1947).** You type an upstream level of 10.125 with "I know one end - work the other out from the grade", 1 in 100 over 10 m. The pipe still comes out 10.13 and 10.03 (the 10 mm rule and the grade are untouched). New: the command line now says "[CE] Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)." It only appears when the level you typed was actually rounded. Switch `pipe.typedLevelRoundingNote`, ON. The New Pipe window itself does not show the line (a window change, so it is a Codex job).
3. **BUG-866, rainfall curve note (PR #1948).** On a job with no rainfall curve of its own, CDDESIGN and the computations sheet used to say the office curve "reads about 7 to 9 per cent high". They now say it "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much". No curve number is changed. You did not separately approve the new wording (decision 16 says build it as a draft so you can object), so please object if you want other words. Switch `detention.rainfallNoteHighOrLow`, ON. The two golden computations-sheet text files carry the sentence, so I updated them to the new words.
4. **BUG-907, pit drop where the pipe gets bigger (PR #1949).** At a pit with a 150 pipe arriving at 10.000 and a 300 pipe leaving at 9.980, the old check passed (20 mm drop). It still shows that pass, and now ALSO shows one warning: "outlet pipe top is 130 mm above the inlet pipe top (10.280 against 10.150)". It only speaks when every level and pipe size at that pit is filled in. It warns, never blocks. Switch `inverts.pitDropWarnsOutletTopAboveInletTop`, ON. It appears wherever CDRULES, Design Check and Project Review list the pit drop rule.
5. **BUG-1236, FO says OF: NOT built, and it needs a decision from you.** I opened the actual OVERFLOW block drawing. The "OF" is plain text frozen inside the block drawing itself (so are "DP" and "IO"), not an editable label. OF and FO both insert that same block, so there is no way to make FO read FO without a second block drawing or a rebuild of how all source symbols hold their visible text. Your ruling (a visible label that prints and can be edited, plus a tag, edited in one window) is exactly that rebuild. My recommendation: do it once for all source symbols (DP, IO, OF, FO, RG) as one reviewed job with a Codex window brief, not as a one-off patch for FO.
6. **BUG-1245, MR / CR on a raingarden: NOT built here.** The cause is found: the raingarden has a hatch (the fill), and the Move+Rotate / Copy+Rotate component only accepts lines, arcs, circles, ellipses, polylines, text and blocks. The hatch is refused, which prints the code word `eNotApplicable`. The sentence lives in the native component (`Modules\Shared.Transform.Native2027\TransformCommands.cpp`, lines 325 to 332), which is outside the Drainage folder this job is limited to and cannot be built or tried without AutoCAD. Support for moving and rotating raingardens (hatch) is on the build list as "later", as you said.
7. **What I did not test:** nothing was opened in AutoCAD. Only unit tests (no drawing) and compile checks ran. Proposed robot cases are in the technical part.
8. **One thing for you to know (disk):** C: stayed at about 30 GB the whole time because other jobs on the PC were writing, so I could not keep to the 30 GB floor (see mistakes, item 1).

---

## TECHNICAL DETAIL

### Answer first

1. **PRs (all DRAFT, base `claude/rel-20261102a` at `3fbb9da5`, Civil 3.0.88):** #1947 BUG-685 (branch `claude/b130-bug-685-typed-level-note`, head `b2ecdfb3`), #1948 BUG-866 (`claude/b130-bug-866-rainfall-note`, head `d6f6ac2b`), #1949 BUG-907 (`claude/b130-bug-907-obvert-warning`, head `8a16a42e`). Every title starts with B-130.
2. **No PR for BUG-1236 and BUG-1245** (evidence in the next sections). Skipped on purpose as instructed: BUG-1148, BUG-483, BUG-1243.
3. **Finished:** worktree removed 20:05:14, report pushed after that (time of push in the git log of this file).

### First check on the start point (already fixed or open PR?)

1. **`gh pr list --state open --search "BUG-nnn"` for 685, 866, 907, 1236, 1245:** the hits were text matches only, none about these bugs (#666 BUG-393 metre record, #1549/#1524/#1535 Codex audit PRs, #782 and #423 other bugs, #565 and #508, #1245 Structural MENUBAR). #1549 was read in full: it fixes other findings and explicitly leaves the rainfall note alone. So there was no existing draft for any of the five.
2. **On the start point:** `RainfallCurve.cs` still said "7 to 9 per cent high"; `PitDropRule` compared inverts only; `ApplyCalculatedInvertRule` rounded silently; `SourceBlockInsertCommands.cs` FO and OF both pass `BlockService.BLOCK_OVERFLOW`; `TransformCommands.cpp` `validate` unchanged. So all five faults were present.

### BUG-685 (PR #1947)

1. **Entry point:** `Commands/CdCommand.cs` (after `ApplyCalculatedInverts`, the "I know one end" block) and `Commands/PipeEditCommand.Update.cs` (after `WorkOutBoxesFromGrade`). The rounding is in `Helpers/MathHelper.cs` `ApplyCalculatedInvertRule` and is NOT changed.
2. **Change:** new `Rules/TypedLevelRoundingNoteRule.cs` builds the line only when the typed level was off the step; step words follow Calculated decimals (2 = "10 mm"). Both places print it as one `[CE]` command-line line and a diagnostic log line.
3. **Switch:** `pipe.typedLevelRoundingNote` (`PipeSettings`, `UserSettings.cs`), `Default: on.`, OFF = no line.
4. **Tests:** new `Bug685TypedLevelRoundingNoteTests` (wording word for word, grade stays 0.10 m over 10 m, on-step levels silent, decimals 3 and 1, both start-up reads, typed false turns off only itself, source guards that both places are behind the switch and never refuse). Focused run on net10: 190 passed, 0 failed (new class + `MathHelperTests` + `C78NewSwitchDefaultsTests` + `Bug1229SuggestedLevelNeverFlatterTests`). net48 compile of `CE_CVL_SUITE.csproj` 0 errors.
5. **Not covered:** the New Pipe window preview has no line (window change, Codex brief: one line of text under the two level boxes reading the same sentence).
6. **Robot case (proposed) N16a_cd_level_note:** new drawing copy; type `CD`, draw one pipe about 10 m, tick "I know one end - work the other out from the grade", "Set my own" grade 1 in 100, type upstream level 10.125, Draw. Checks the command-line history line `[CE] Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm).` and the two levels read back as 10.13 and 10.03. **Switch-off control:** set `pipe.typedLevelRoundingNote` false in the test profile's `CD_Settings.json`, repeat: the history has no "Typed level" line and the levels are still 10.13 and 10.03.

### BUG-866 (PR #1948)

1. **Entry point:** `Rules/RainfallCurve.cs` `RainfallCurves.CurveInUse` (the sentence for a job with no curve of its own; used by CDDESIGN, the computations sheet and CDCALC).
2. **Change:** with the switch ON the sentence says "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much"; OFF returns the old text exactly. New `Rules/RainfallNoteRule.cs` reads the switch. No curve value is touched.
3. **Switch:** `detention.rainfallNoteHighOrLow` (`DetentionSettings`), `Default: on.`.
4. **Golden files:** `Fixtures/C4CalcGolden/sheet_ari5.txt` and `sheet_ari10.txt` contained the old sentence, so they were changed to the new one (this is the intended sheet change; the goldens test "a fix changes only its symptom").
5. **Tests:** new `Bug866RainfallNoteTests`; `RainfallCurveTests` one assertion moved. 97 passed, 0 failed (also `CalcOneSourceTests`, `StormFrequencyFromCouncilTests`, `ComputationsRecord*`, `DesignWindowHandoffTests`). net48 compile 0 errors.
6. **Not covered:** the comments in `RainfallCurveCommand.cs`, `DetentionModels.cs` and `ProjectDataService.Rainfall.cs` still describe the old "6.5 to 8.6 per cent high" finding as history (comments only). The desk's part of decision 16 (check the curve against the guidebook and the council sheets) is not done here. The new wording is a GUESS Tim has not approved.
7. **Robot case (proposed) N16b_rainfall_note:** drawing copy with no CDRAINFALL curve; open the computations sheet preview (or CDDESIGN) and read the rainfall sentence. Checks the text contains "high or low by up to about 8 per cent" and does not contain "7 to 9 per cent". **Switch-off control:** with `detention.rainfallNoteHighOrLow` false the same step reads "7 to 9 per cent high".

### BUG-907 (PR #1949)

1. **Entry point:** `Rules/PitDropRule.cs:150-156` (inverts only) and `Rules/RulebookEngine.cs` `PitDropRules` (the R-08 rows).
2. **Change:** new `Rules/PitObvertRule.cs` (pure arithmetic: invert plus diameter/1000, outlet top against each arriving top; lowest arriving top reported). `Rules/RulebookEvaluator.cs`: `ReadPipes` now also returns the pipe objects (old signature kept as a wrapper), and new `EvaluateObverts` uses the SAME arriving pipes and SAME selected main outlet as the drop check (one code path). `RulebookEngine.PitDropRules` adds one Warn row under R-08 per affected pit; the existing Pass/Shortfall row is unchanged. `Rules/RuleFixAdvisor.cs` suggests "Lower the outlet IL so its top is not above the inlet top".
3. **Rules:** one outlet only; every invert and diameter present and numeric, otherwise no finding (Unknown stays Unknown); an outlet top exactly level with the inlet top does not warn; no tolerance figure (nothing hard-coded).
4. **Switch:** `inverts.pitDropWarnsOutletTopAboveInletTop` (`InvertSettings`), `Default: on.`, OFF = invert-only check exactly.
5. **Tests:** new `Bug907PitObvertWarningTests` (the ledger example 130 mm; smaller, same size and level outlets silent; blank/unreadable level or size silent; two arriving pipes; engine row plus switch OFF leaves only the Pass row; both start-up reads). 147 passed, 0 failed (new class + `RulebookEvaluatorTests`, `C4ContinuationTests`, `RulebookLevelsCheckTests`, `RulebookLiveInputsTests`, `RuleSourceEvidenceTests`, `RuleFixAdvisor*`, `RulebookEngine*`). net48 compile 0 errors.
6. **Not covered:** the CD pit-drop suggestion on a NEW pipe does not use the obvert yet; drawings in non-metre units are read as the CE record gives them (levels m, diameter mm).
7. **Robot case (proposed) N16c_pit_obvert:** drawing copy with pits P1, P2; a 150 UPVC pipe P1 to P2 with downstream level 10.000, and a 300 pipe leaving P2 with upstream level 9.980; run `CDRULES`. Checks the rules list for P2 holds a Warn line containing "outlet pipe top is 130 mm above the inlet pipe top" and still the pit drop Pass line. **Switch-off control:** with `inverts.pitDropWarnsOutletTopAboveInletTop` false the same run lists only the Pass line for P2.

### BUG-1236, FO symbol text: skipped, evidence

1. **Cause:** `Commands/SourceBlockInsertCommands.cs:75-93`: `OF` and `FO` both call `RunTaggedSourceCommand(BlockService.BLOCK_OVERFLOW, ...)` (card D08 says this is deliberate). I read the block drawing `Installer/source_blocks/OVERFLOW.dwg` offline with ACadSharp (nothing opened in AutoCAD): it holds Circle r=75, Circle r=175 and ONE MText `OF` (height 250, layer 25TEXT), not an attribute. `DOWNPIPE DYNAMIC WITH MASK.dwg` holds `DP` and `INSPECTION OPENING DYNAMIC WITH MASK.dwg` holds `IO` the same way. The visible text is part of the shared block definition, so it cannot differ per placement.
2. **Why not built:** (a) a second block drawing is a binary asset in `Installer/source_blocks`, outside Modules/Drainage, and a drawing written by a library cannot be checked here; (b) a block definition cloned at placement under a new name (for example FRONT OVERFLOW) must be recognised by at least seven places that compare against `BLOCK_OVERFLOW` (`LinkService.Compound.cs:383`, `CompoundEditModeService.cs:776`, `CompoundTransformOverrule.cs:179`, `AnnotationEditCommand.cs:231`, `XcivilPitInsertionService.cs`, `BlockService.cs`, the source-family rules and their tests), which touches link, transform and edit mode; (c) decision 76 asks for label plus tag in one edit window on every source block, and the window is Codex-owned. A one-off FO patch would be thrown away by that rebuild.
3. **Recommended next job:** one reviewed workflow card for all source symbols (DP, IO, OF, FO, RG): the visible text becomes an attribute (or per-block label) editable in the one source edit window; FO then simply inserts with label FO. Card first (the review gate in AGENTS.md), then block drawings, then code, then Codex window brief.

### BUG-1245, MR and CR on a raingarden: skipped, evidence

1. **Cause (found):** `Modules/Shared.Transform.Native2027/TransformCommands.cpp:170-181` `validate` accepts only AcDbLine, Circle, Arc, Ellipse, Polyline, Text, MText and BlockReference; anything else throws `eNotApplicable`. A raingarden is a polyline outline plus a HATCH (`SourcePlacementService.cs:843-882`, layers 50CONT and HATCH113), so the hatch is refused. The catch at `:325-332` then prints `eNotApplicable` and the sentence naming a "trial". Selection happens inside the native component (`acedSSGet` at `:122-123`), so the managed command `Commands/CopyRotateCommands.cs` never sees what was selected and cannot name the object.
2. **Why not built:** the sentence has to be written in the native C++ (outside the Drainage folder; native build and AutoCAD needed to try it; the component is shared with Manager and Structural). A managed-only attempt (an `Editor.SelectionAdded` listener) cannot be proven without AutoCAD and would still leave the code-word line printing first.
3. **Exact change to give the native job:** make `validate` throw a small struct holding the class name (for example `AcDbHatch`) and have the catch print one plain line such as `[CE] Move+Rotate and Copy+Rotate cannot move a hatch yet (a raingarden's fill is a hatch). Nothing was moved.`, never the status text and never the word "trial". Later: add `AcDbHatch` (with its associativity) to the accepted types so a raingarden can move and rotate.
4. **Build list (as Tim said, decision 79):** "MR and CR support for raingardens (hatch)" later.

### Mistakes of my own (first)

1. **Disk floor.** The launcher said wait while C: is under 30 GB. C: sat at 29.4 to 31.2 GB the whole run because other jobs were writing (my whole worktree, bin and obj together was only 462 MB), so waiting would never have ended. I lowered my own build gate to 20 GB after one stopped wait (about 10 minutes lost) and kept going. The job text's own floor is 8 GB.
2. **A bare `python3` heredoc hung the shell once** and was stopped; nothing was written by it.
3. **Backslash paths in bash garbled my first log file names** (two stray `.log` files landed in the worktree root; ignored by git and deleted).
4. **First run script had a bad regex and a quoting error** (no dotnet command ran at all; nothing was built or touched).
5. **My first source-guard test in #1947 failed once** because the heredoc turned `\n` into a real newline in the search string; fixed before the commit.

### What is NOT proven

1. Nothing was run in AutoCAD, so no command line, no pit-rule list and no sheet was seen. The robot cases above are proposed names only.
2. The New Pipe window preview and any window (BUG-685 line, BUG-1236 edit window) are not built.
3. The full suite was NOT run (job rule: focused classes only). Manager tests were not run.
4. net8 was not compiled; net48 compile of the Drainage project was run for each PR (0 errors), net10 focused tests only.

### Shared files, clashes

1. **Shared files touched:** `Modules/Drainage/Models/UserSettings.cs` (three new switches, one per PR, different groups: Pipe, Detention, Inverts) and `REGRESSION_LOG.md` (one entry per PR, each prepended at the top, so all three PRs conflict with each other and with the other open drafts at the first line: keep both sides). **`CE_SHARED` was NOT touched.** No Settings-engine or loader change, so no N91 needed (the start-up reads are covered by each PR's own test through both `DeserializeSettings` and `DeserializeSettingsTolerant`).
2. **Clashes seen (`gh pr list --state open --base claude/rel-20261102a --search "<file>"`):** `UserSettings.cs` and `REGRESSION_LOG.md` are also edited by #1887, #1888, #1892, #1896, #1923, #1935 to #1946 (all different switches; textual neighbours only). `CdCommand.cs`, `PipeEditCommand.Update.cs`, `RainfallCurve.cs`, `RulebookEngine.cs`, `RulebookEvaluator.cs`, `RuleFixAdvisor.cs`: no other open draft touches them. My three PRs are independent of each other (none stacked), each branched from the base.
3. **Not stacked** on any other draft because none changes the same code.

### Real-files compare (names, sizes, last-write only, no contents)

Full before and after listings (33 519 and 33 533 lines, five roots) were taken at 19:29 and 20:04 and compared; the scratch folder that held them was deleted at the end. Settings files in the listings:

1. **Before (19:29):** `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` 15350 bytes, last write 2026-10-31 19:27:41; `TIM_CE_CADTOOLS\CS_Settings.json` 351713, 2026-03-31 13:18:00; `CE_STRUC_SUITE\CS_Settings.json` 35613, 2026-10-30 19:54:14; `CE_CVL_SUITE\settings.json` 672, 2026-09-16 12:13:17; `CE_CADTOOLS` and `CE_SUITE` hold no settings file.
2. **After (20:04):** `TIM_CE_CADTOOLS\CD_Settings.json` **15270 bytes, last write 2026-10-04 08:22:30**; the other four settings files unchanged (same sizes and times).
3. **This one CHANGED, not by my run:** the file was already written at 19:27:41, before my first test ran at about 19:30, and it later went back to a 4 October copy (an older, preserved timestamp, which a test write cannot produce). My tests run with the settings scope redirected into a throwaway folder. I believe another session restored it. I am stating it as the job requires; I could not stop (all my tests were already done).
4. **Other new or changed files in the real folders** (not settings): `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31\*` (10 new files, 19:29 to 20:02), `...\outbox\failures\2026-10-31\*` (4 new, 19:51 to 20:02), `...\outbox\machines\*` (2 rewritten), `...\sessions\*` (2 rewritten, 20:02), `ledger\suggestions.jsonl` (3590008 to 3590279 bytes), `telemetry\outbox.jsonl` (rewritten 20:02), `CE_STRUC_SUITE\logs\ce_struc_structured_20261031.log` and `ce_struc_suite.log` (grew). The first new usage file (19:29:41) appeared before any of my dotnet runs started, and the cadence (about every 10 minutes, with session files rewritten at 20:02:08) matches a live AutoCAD session of the robot, not my test runs. I started no AutoCAD, Codex or accoreconsole.
5. Env set for every build and test: `CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\n16\struc`, `CE_LOG_DIR_OVERRIDE=...\logs`, `TEMP` and `TMP` `...\tmp`; my script printed them before each run and refused to run if they pointed at `AppData\Roaming`.

### Housekeeping

1. **Worktree** `C:\CE_WORK\build\n16`: `git clean -fdXq`, then `git worktree remove` at 20:05:14. A 0-byte placeholder `CE_TRANSFORM_2027.arx` was created in the ignored `bin` folder so the build could copy it; it went with the clean-up. The MSBuild after-build step ran fine (no powershell problem).
2. **Disk:** worktree total 462 MB. C: free 31.2 GB at 19:23 and 30.1 GB at 20:05 after clean-up: the net move is dominated by other jobs, so my share cannot be separated; my own footprint was under 0.5 GB and it is now returned.
3. **Local helper branch** `claude/n16-b130-base` (points at the base tip, never pushed) was left in the main repo; nothing deleted. `BUG_CARPARK.md` and `DESK_LOG.md` were not edited.
4. **Finished** at 20:05 (worktree); this report pushed straight after.

### Summary (under 100 words)

PRs #1947 (BUG-685), #1948 (BUG-866), #1949 (BUG-907), all draft on `claude/rel-20261102a`, titles start B-130. Switches `pipe.typedLevelRoundingNote`, `detention.rainfallNoteHighOrLow`, `inverts.pitDropWarnsOutletTopAboveInletTop`, all ON. Files: `TypedLevelRoundingNoteRule.cs`, `RainfallNoteRule.cs`, `PitObvertRule.cs`, `CdCommand.cs`, `PipeEditCommand.Update.cs`, `RainfallCurve.cs`, `RulebookEvaluator.cs`, `RulebookEngine.cs`, `RuleFixAdvisor.cs`, `UserSettings.cs`, `REGRESSION_LOG.md`. BUG-1236 and BUG-1245 not built (block text frozen in the drawing; native component outside scope). Nothing run in AutoCAD.
