# Opus re-check: fixes after review (Group 1) and new PRs (Group 2), 31 October 2026

Written Saturday 31 October 2026, evening (Melbourne), by an independent read-only Opus reviewer, brief by CE 05 at CE 00's request.
Tips checked: Civil `claude/rel-20261102a` at 3fbb9da5 (3.0.88); Structural `claude/rel-20261026s` at 204dfad2 (1.0.125).
What I did: read every diff (old head to new head for Group 1, base to head for Group 2), the author reports and the earlier reviews R, S, T, X, Y, Z; ran read-only `git fetch` and `git merge-tree` only.
What I did NOT do: build, run any test, open AutoCAD, or read any real settings file. Every "fails before, passes after" below is the author's claim plus my reading of the test; I did not run it.

## FOR TIM

1. **Civil fixes after review, #1887, #1891, #1882, #1940 with #1943: all fixed, all may go on C-79.** #1882 KEEP; the other four KEEP-WITH-NOTE (small tidy-ups only).
2. **#1945, the "approved under another file name" warning in CDDESIGN: CHANGE-NEEDED, one word.** The template-file fix works. The extra "drawing never saved" check can never fire, because it compares two drawings the one way that always says "different". The change log says that check works. It does not.
3. **Structural fixes after review, #1885, #1929, #1931, #1932, #1933 with #1934, #1901, #1898, #1930, #1906: all fixed, all KEEP-WITH-NOTE.** Two joins need both sides kept (Level marks file, Structural settings file). Both are simple.
4. **#1899 CSPOINTLOAD: confirmed warn and carry on (R-27).** A damaged point-load list is copied inside the drawing, you get one line, and the load is placed. It no longer refuses.
5. **New Civil PRs, small: #1947, #1949, #1951, #1959, #1962: KEEP or KEEP-WITH-NOTE, area plus smoke.** Example (#1949): a 150 pipe arriving at 10.000 and a 300 leaving at 9.980 now also gets "outlet pipe top is 130 mm above the inlet pipe top".
6. **New Civil PRs that touch sizing, labels or the saved CE record: #1946, #1950, #1952, #1955, #1960: KEEP-WITH-NOTE, FULL train.** #1952 and #1955 both change the protected record file. Both read correctly and both have a switch that puts the old behaviour back.
7. **Your word needed on #1948 before it ships.** The rainfall note on the computations sheet will say the office curve "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much". That goes to councils. Say if you want other words.
8. **Stacked PRs, merge order fixed:** #1880, then #1951, #1953, #1955, #1958 (Inspector). #1954 and #1956 ride on #1874 (Rainwater reuse). #1874's branch is 110 commits old, so its settings-file join needs care (detail, Group 2 merge facts).
9. **#1957 (CDMENU on AutoCAD 2022 to 2024) and #1961 (Manningham reuse credit on the council profile): KEEP-WITH-NOTE.** Neither can be proven on AutoCAD 2027; #1957 needs a 2022 to 2024 run.
10. **Nothing in this file has been opened in AutoCAD, and no bug is fixed.** Built and unit-tested by the authors only. Totals: KEEP 3, KEEP-WITH-NOTE 30, CHANGE-NEEDED 1.

---

## DETAIL

### Group 1 merge facts

1. **Civil.** #1887, #1891 and #1882 sit 11 commits behind the tip; each clashes only in REGRESSION_LOG.md (keep both). #1940, #1943 and #1945 sit on the tip and merge clean.
2. **Structural.** All ten heads sit on 204dfad2 and each merges clean alone.
3. **Pairs (Structural).** Only two code clashes, both keep-both:
   1. **#1885 x #1934, `LevelMarkCommands.cs` about line 357:** keep #1885's always-written CE_LEVELMARK tag block, then #1934's `LevelMarkGrouping.GroupIfOn(...)` line, both before `tr.Commit()`.
   2. **#1898 x #1906, Structural `UserSettings.cs` about line 1401:** keep #1898's three footing switches and #1906's `RectTextCommitsOnceAccepted`, one after the other.
   3. Every other pair clashes in REGRESSION_LOG.md only.

### Group 1, one PR at a time

#### #1887 BUG-1092, head 0d5e3d98 (was d7bfa1d4), review R

1. **Finding B (wrong place named, CDRULES):** fixed. The log line now names the CD warning window, Edit Pipe, CDDASHBOARD and the grade suggestion, and says CDRULES is not where it shows. The report retargets the robot case to the CD warning window.
2. **Finding C (new refusal on the markup route, R-27):** fixed. `MarkupToChangePlanService.TryValidateProposedInverts` sets a new `DesignStandards.KeepToleranceForUphill = true` (`[JsonIgnore]`, never saved). `CheckReverseFall` then uses the old tolerance rule on that route only. A 0.5 mm uphill markup passes as "flat" as before; 4 mm is still refused as before.
3. **Test:** `MarkupRoute_HalfAMillimetreUphill_IsNotDropped_ButAFourMillimetreUphillStillIs` calls the real private method by reflection. On the old head it fails (0.5 mm is dropped). `ValidatePipe_StillRedForHalfAMillimetreUphill_WhenTheMarkupFlagIsNotSet` pins that the rest of CE stays strict.
4. **Nothing else changed:** five files, all on topic.
5. **Note:** the REGRESSION_LOG entry now has two items numbered "6." (review fix and Undo). Renumber in the finaliser.
6. **Verdict: KEEP-WITH-NOTE.** Train: C-79, Civil design area plus smoke.

#### #1891 BUG-1246, head 4f21fc9d (was 7e19a867), review S

1. **Finding (label drawn on a locked layer):** fixed. Before the label is drawn, `LinkService.CopiedSourceOwnTag.cs` reads the label layer's `LayerTableRecord.IsLocked` (read only). Locked: no label, layer untouched, and one line names the layer. The tag DP3 is still given (it lives on the downpipe, not on a layer).
2. **Switch OFF:** the new check sits inside the switch-ON route only, so OFF is still exactly the old behaviour.
3. **Tests:** three new ones in `Bug1246CopiedDownpipeOwnTagTests`: the line, no line when drawn, and a source guard that the lock is read first and nothing unlocks. They cannot pass on the old head (the line did not exist).
4. **Notes:**
   1. The REDO list guard (`RedoSafeReviewedHooks.baseline.txt`) was not re-run by the author; the new code is a read only, so I expect it to pass, but the train's full run must show it.
   2. Review S's other two robot cases are still owed: CR with the old label selected too, and U then U again.
   3. With two copies, the line reads "The label for DP3, DP4 was not drawn"; plain enough.
5. **Verdict: KEEP-WITH-NOTE.** Train: FULL (copy clean-up shared by COPY, CR, grip copy).

#### #1882 BUG-1093, head 84d5a659 (was 58c4473d), review R

1. **Finding A (a lid typed "12,5" could get a false cover warning against RL 0):** fixed. New `CoverLevelKnownRule.TryReadLid` reads "12,5" and "12.5" alike, and says Unknown for "abc", "1,012.500" or blank. The proposal builder now takes both the level and the "known" answer from that one reading (switch ON). OFF keeps the old reader exactly.
2. **Redesign path:** `NetworkRedesignDrawingProjector` already refuses a pit whose cover will not read as a plain number (`MathHelper.TryParseInvariantDouble`, Float style, no commas), so a comma lid never reaches it. The known-flag change there is for consistency only, as the author says. I checked this.
3. **Test:** 4 of 25 in `Bug1093CoverZeroTests` fail with the two service files put back (author's run); the "101,5" false-warning case is among them.
4. **One plain consequence:** a comma lid now gets a real cover check at its real level (it got none before). That is a warning, never a block.
5. **Verdict: KEEP.** Train: C-79, network design area plus smoke.

#### #1940 BUG-1144, head c55494e0 (was a4d98bad), review T

1. **Finding 7.1 (doubled "Undo" line, missing blank line):** fixed.
2. **Finding 7.2 (warning claims a copy that may not exist):** fixed. `KeepDamagedCopy` now returns whether it made the copy; `WriteInTransaction` passes that up. The coordinator swaps the ticket's neutral warning for `WarningWithCopyOutcome(copyMade)`: "CE kept a copy..." only when it did, otherwise "No copy of the damaged record was kept, because CE could not make one."
3. **Ticket unchanged in meaning:** the warning inside the ticket no longer claims anything about a copy.
4. **Test:** two new tests in `Bug1144DamagedOutletRolesTests`; they need `WarningWithCopyOutcome`, which did not exist on the old head.
5. **Still true from review T (not new):** two damage shapes (wrong-type dictionary or record) still stop Apply through the existing preflight; that is not this PR.
6. **Verdict: KEEP-WITH-NOTE.** Train: FULL.

#### #1943 BUG-1153, head 62c8f363 (was 3b1310b4), review T

1. **What changed:** one merge commit bringing #1940's fix in. I checked that the merge adds exactly #1940's five-file fix and nothing else, and that the doubled log line is gone in this branch too.
2. **Review T's other notes stay open, unchanged:** duplicate LPD read, double blank line in `UserSettings.cs`.
3. **Verdict: KEEP-WITH-NOTE.** Rides in #1940's train, merged after it (FULL).

#### #1945 BUG-1158, head a6a892bc (was 4d778d2c), review T

1. **Finding 6.1 (template path recorded):** fixed for the case review T described. `LpdSaveAsCopyRule.PathToRecord` now records nothing for a `.dwt` or `.dws` file name. The new test `ANeverSavedDrawing_RecordsNoPath_NotEvenTheTemplateItWasStartedFrom` fails on the old head.
2. **Finding 6.2 (wording):** fixed: "Approve the outlets again in CDLPD to clear this warning."
3. **FAULT (new): the DWGTITLED check is dead code.** `LpdService.DrawingHasBeenSaved` runs `if (doc == null || !ReferenceEquals(doc.Database, db)) return true;`. AutoCAD hands back a NEW `Database` wrapper object on every `doc.Database` call, so `ReferenceEquals` is always false. The method therefore always says "saved" and DWGTITLED is never read. (Known trap in this repo: Document wrappers are cached, Database wrappers are not; compare with `==` or `LinkService.SameDatabase`.)
4. **What that costs:** the `.dwt` test still protects the common case. A drawing started from a `.dwg` used as a template, approved before its first save, would still record that `.dwg` path and warn every time. The REGRESSION_LOG item 7a says DWGTITLED = 0 records nothing; that is not what the code does.
5. **Fix:** change `ReferenceEquals(doc.Database, db)` to `doc.Database == db` (or `LinkService.SameDatabase`). One word. A unit test cannot reach it (it needs AutoCAD), so a source guard against `ReferenceEquals(doc.Database` would do.
6. **Verdict: CHANGE-NEEDED (one word).** Train: Civil CDLPD and CDDESIGN area plus smoke. The folder-path question to Tim is still pending and unchanged.

#### #1885 BUG-625 (Structural), head 529155aa (was 044cf047), review R item 4

1. **Finding (no CE_LEVELMARK tag on marks drawn with the switch OFF):** fixed. The `if` around the tag write is gone; every new FFL, RL, SSL and NGL value label gets the invisible tag.
2. **Test:** `NewLevelMark_TagIsWrittenWhateverTheSwitchSays` is a source guard (the draw needs AutoCAD). It fails on the old head (1 failed of 17, author's run).
3. **Plain note on the switch:** with LMU's switch OFF, drawing a mark now also writes the invisible tag and its application name. That is the change the review asked for. OFF still restores the old Level Update exactly.
4. **Still owed:** Preview and Apply for LMU is not built, so BUG-625 can only be partly fixed. CE 00 to record the older-mark position fallback beside BUG-625.
5. **Merge:** clashes with #1934 in `LevelMarkCommands.cs` (keep both; see merge facts).
6. **Verdict: KEEP-WITH-NOTE.** Train: Structural levels area plus smoke.

#### #1929 B-101 BUG-1262, head 77f53a0f (was a0587173), review X

1. **Fault A (Publish Issue picks the empty "no sheets" row):** fixed. New `CeSheetsIssueService.PickIssueToPublish` skips `NoSheets` rows; the Sheets Manager button uses it. Blank revision after a "no sheets" record now publishes the last real issue or says "Create an issue snapshot first".
2. **Switch OFF:** no "no sheets" rows are ever recorded, so the filter changes nothing. Old behaviour exact.
3. **Tests:** three new cases on the lookup (new method, red before).
4. **Still owed:** the Sheets panel label question from review X; the window itself unseen.
5. **Verdict: KEEP-WITH-NOTE.** Train: Structural area plus smoke.

#### #1931 B-105 BUG-613, head 563ef353 (was 19e62e72), review X

1. **Fault B (copied details warn falsely):** fixed by a trade-off. A detail id with more than one outline in the same space is treated as copied, and nothing is said for it. The author states the cost: a part-move of a copied detail is not warned either.
2. **Start-up made fail-safe and visible:** `RcDetailMoveWarningService.Initialize()` now runs first in `AdminTelemetryService.Initialize`, in its own try, and logs a failure. It has its own `_initialized` guard, so a retry cannot attach twice.
3. **Tests:** rule cases with two outlines sharing one id; start-up order.
4. **Not proven:** that a real RC beam or column detail has exactly one outline piece. If any detail type draws two outlines, the warning would never fire for it. Robot COPY then MOVE, and a part-move of a fresh detail, decide it.
5. **Verdict: KEEP-WITH-NOTE.** Train: FULL (start-up step), unless Tim answers QUESTIONS 89 otherwise.

#### #1932 B-106 BUG-1132 and BUG-818 names, head 2ffc95fb (was 5813608b), review X

1. **Fault C (SBEAM edit refuses a beam drawn as 310UB32):** fixed. The edit window looks the beam up under its current name (`ListKeyForStoredMember`) and accepts it only when the stored name is a former name of the current row AND every size and mass is unchanged (`MembersMatchAllowingFormerName`). Exact match is still tried first.
2. **Switch OFF:** the list has no former names, so the map is empty, the key is unchanged and only the exact check runs. Old behaviour exact.
3. **Tests:** `SbeamEditOldSectionNameTests` on the real list, all 35 renamed rows (new methods, red before).
4. **Notes:** the PR body still says 34 rows and 250UC73 held (stale); the REGRESSION_LOG entry has no blank line before the "Train S-45" heading; SBEAM favourites and recents saved under an old name are not covered (author says so).
5. **Verdict: KEEP-WITH-NOTE.** Train: Structural steel area (CEMEMBER, SBEAM, section picker) plus smoke.

#### #1933 B-107 BUG-626 and #1934 B-108 BUG-627, heads 49151e90 and aeca169f, review Y

1. **#1933 finding (FFL preview turned by the UCS twice):** fixed. The jig sampler now uses `AcquirePoint`'s answer as World (it already is), not `ToWcs(...)` again. A source guard test pins it.
2. **#1934:** one normal merge commit bringing #1933's fix in; the merge adds exactly #1933's three files.
3. **Still owed:** review Y's #1934 source guard (both FFL paths call `GroupIfOn`) was not added; the robot UCS case (UCS Z 30, FFL at a snapped point) is still the proof.
4. **Verdicts: #1933 KEEP-WITH-NOTE; #1934 KEEP-WITH-NOTE.** Train: Structural levels area plus start-up smoke; #1933 before #1934.

#### #1901 B-080 BUG-616, head bfb779fa (was 468b252c), review Y

1. **Finding (Enter at "Apply or Cancel? <Apply>" may cancel):** fixed. `XrlMoveConfirm.AnswerApplies`: Enter (status None) applies; only the Cancel keyword or Escape cancels.
2. **Tests:** five rule cases and a source check.
3. **Not proven:** which status AutoCAD really returns for Enter on that prompt; the robot Enter case decides it.
4. **Verdict: KEEP-WITH-NOTE.** Train: Structural XRL area plus start-up smoke.

#### #1899 B-078 BUG-1139, BUG-1204, BUG-1162, head e3873ac2 (was 1969701f), review Y

1. **R-27 check, as asked: it is now warn and carry on.** The refusal call is gone. With the switch ON and a damaged group, `TryKeepDamagedCopy` writes the stored list to a new record (`CE_ROOF_POINT_LOADS_DAMAGED`, then `_DAMAGED2` ...) in the same transaction. The load is placed, the list is rewritten with the readable loads, and one line says what happened. If the copy fails, the line says so and it still carries on.
2. **Order:** the copy is written before the list is rewritten (author's test pins this). If a later existing refusal fires (locked layer), the whole transaction is dropped, copy included, so nothing half-done is left.
3. **Pre-existing refusals unchanged:** "recorded by a newer version of CE", "something else is stored under CE's name" and "layer is locked" were all on 204dfad2 before this PR.
4. **Switch OFF:** old behaviour (damaged groups dropped silently).
5. **Notes:** the setting is still named `RefuseWhenAGroupIsDamaged` although it no longer refuses (its comment says so); new tags restart from the readable loads, so a new P-number can repeat a damaged one's number (the line and the kept copy make that recoverable).
6. **Verdict: KEEP-WITH-NOTE.** Train: Structural beams, links and roof point loads area plus start-up smoke.

#### #1898 B-077 BUG-1146, BUG-1147, BUG-1159, head 18ca497f (was 731349f5), review Y

1. **B1 (a refused size save still remembered for the session):** fixed. `CeTextService.SaveFstData` returns early when `FstMemoryService.Save` returns false.
2. **B2 (register version written as two separate 2s):** fixed. `SchemaVersion` defaults to `FoundationUnknownFields.CurrentRegistryVersion`.
3. **Tests:** a source check for each plus an equality test.
4. **Small side effect (any switch state):** `Save` also returns false when it throws for any other reason; the session memory is now skipped then too. Before, it was kept. Harmless (THCL then offers only what the drawing holds), but not strictly "OFF = old".
5. **Merge:** clashes with #1906 in Structural `UserSettings.cs` (keep both).
6. **Verdict: KEEP-WITH-NOTE.** Train: Structural footings, THCL, FST and beam-link save area plus start-up smoke.

#### #1930 B-104 BUG-578, head ce69c24f (was 29323ac1), review X

1. **What changed:** the duplicate-row line now reads "CE kept PF1 and removed the duplicate 1 row; sizes are the same." It is always written to the CE log, and shown once per drawing keyed on the file name (steadier than the old per-object key).
2. **Tests:** both cases (same sizes, different sizes); wording red before.
3. **Still Tim's call (review X item 2):** whether CE should drop the duplicate "1" row at all. Not answered.
4. **Verdict: KEEP-WITH-NOTE.** Train: Structural area plus smoke.

#### #1906 B-084 BUG-1185 and BUG-1200, head 9f5e8b3c (was 314acd00), review Z

1. **Finding (preview outline not rotated):** fixed. New `RectOutlinePreview.CornersRotated` turns the four corners about the centre by the same `additionalRotationUcs` the real outline is later turned by (`RotateEntityAroundPoint(..., additionalRotationUcs)`), then each goes through `ToWorld` as before.
2. **Tests:** geometry (1200 x 600 at 30 degrees).
3. **Not done:** review Z's "same place" wording correction and the unused `TryMidpointAlong` tidy. The preview shows the outline before any slab nudge (said in the code).
4. **Verdict: KEEP-WITH-NOTE.** Train: FULL. The Codex look (THCL 83, 1200 x 600, rotation 30) is still needed.

---

### Group 2 merge facts

1. **On the tip.** #1946, #1947, #1948, #1949, #1950, #1952, #1957, #1959, #1960, #1961 and #1962 are each one commit on 3fbb9da5 and merge clean alone.
2. **Pairs among those eleven:** REGRESSION_LOG.md only. Civil `UserSettings.cs` joins cleanly in every pair.
3. **Inspector stack:** #1880 (one commit on 91963bd0, 11 behind the tip) then #1951, #1953, #1955, #1958, each on the one before. The whole stack clashes with the tip in REGRESSION_LOG.md only. #1962 also edits `InspectorPaletteService.cs` and joins with the stack cleanly.
4. **Reuse stack, take care:** #1954 and #1956 sit on #1874 (`fb/bug1096-reuse-boxes`), whose base is 09126560, 110 commits behind the tip. Against the tip, both clash in `UserSettings.cs`:
   1. The tip retired the comment on `MinDetentionPipeGradeRatio` ("RETIRED by GB-01 slice 1 ..."). The stack inserts its new switches right before that old comment.
   2. **Right join:** keep #1874's `RainwaterReuseBoxes`, then #1954's `ReuseMinimumUsesReuseShare`, then #1956's `DesignDraftKeepsUnknownFields`, each with its own `/// <summary>` line, then the tip's RETIRED comment on the old property.
   3. #1954 against #1956 also clashes there; keep both, and give the second block its own `/// <summary>` (the clash splits one shared opening line).
   4. This is #1874's merge first; then #1954 and #1956 follow.

### Group 2, one PR at a time

#### #1946 B-126 BUG-321, label sizes in a metre drawing (8ef5e68e)

1. **What the drafter sees:** in a metre drawing, new pipe labels are 0.25 tall (were 250), level text 0.18, label offset 0.125, flow-arrow offset 0.125, pit hover 0.45. Millimetre and unitless drawings are multiplied by exactly 1.0. Labels already drawn keep their height.
2. **One place:** `Rules/LabelUnitsRule` (millimetres to drawing units), read by `TextService.PIPE_TEXT_HEIGHT` and `INVERT_TEXT_HEIGHT`, quick-mode placement, the arrow and the hover.
3. **Switch:** `options.labelSizesReadDrawingUnits`, ON, pinned through both start-up reads; OFF = factor 1.0, old numbers exactly. No new engineering value.
4. **No-hard-blocks:** none added. Protection and REDO: no new write path; heights and offsets only.
5. **Notes:**
   1. **DIMSCALE:** the author did NOT multiply by DIMSCALE, contrary to the brief, with a sound reason (millimetre drawings do not either). CE 04 to confirm against Tim's 20 Oct ruling 12. Not a new question to Tim unless CE 04 reads the ruling differently.
   2. **Not converted, so mixed in a metre drawing:** `TextService.TEXT_OFFSET` (70, the manual offset), and the X-Civil import offsets (`Math.Max(160.0, ...)` against a now-converted height). X-Civil import in a metre drawing will now put 0.25 text 160 m off. It was already wrong (250 text), so no worse in size, but now mismatched.
   3. **Settings heights:** anyone who typed `pipeTextHeight` 0.25 in Settings to work around metre drawings would now get 0.00025 in a metre drawing. Unlikely, since Settings is shared with millimetre drawings.
   4. `PitHoverService` now reads the switch and the drawing units on every cursor move; cheap, but not measured.
6. **Tests:** `Bug321LabelUnitsTests` (13, new rule, red before).
7. **Not proven:** anything in a real metre drawing; the Pit Schedule label re-place path.
8. **Verdict: KEEP-WITH-NOTE.** Train: FULL (label sizes shared by CD, PIT, LPD, text tools, X-Civil).

#### #1947 B-130 BUG-685, typed level held to the nearest 10 mm (b2ecdfb3)

1. **What the drafter sees:** typing 10.125 with "work the other end out from the grade" still gives 10.13; now one line says "[CE] Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)." Only when the typed level was really rounded.
2. **Checked:** `ApplyCalculatedInvertRule` rounds the typed (preserved) end to Calculated decimals, so the line is true.
3. **Switch:** `pipe.typedLevelRoundingNote`, ON, both reads; OFF = no line. The step comes from Settings (Calculated decimals); nothing hard-coded.
4. **No-hard-blocks, protection, REDO:** a command-line note only; no write.
5. **Note:** the several-pipe Edit Pipe path (`PipeEditCommand.Batch.cs` 547) has the same rounding and prints no line. Not checked whether that path takes typed levels; say so in the log or cover it later.
6. **Verdict: KEEP-WITH-NOTE.** Train: Civil CD and Edit Pipe area plus smoke.

#### #1948 B-130 BUG-866, rainfall curve note (d6f6ac2b)

1. **What the drafter and the client see:** on a job with no rainfall curve of its own, CDDESIGN and the computations sheet stop saying the office curve "reads about 7 to 9 per cent high". They say it "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much". No curve number changes.
2. **Switch:** `detention.rainfallNoteHighOrLow`, ON, both reads; OFF = the old sentence exactly. The two golden sheet files were updated to the new words.
3. **No-hard-blocks, protection, REDO:** wording only.
4. **Engineering judgement:** this sentence is printed on a sheet that goes to councils, and "2.5 times" is an engineering claim. Decision 16 lets it go as a draft for Tim to object to; it should not ship on a train until Tim has seen the words (rule 4.5).
5. **Not checked:** whether any saved approval or sheet hash includes this sentence (a change of words could mark older sheets as changed).
6. **Verdict: KEEP-WITH-NOTE (Tim's word on wording before install).** Train: Civil detention area plus smoke.

#### #1949 B-130 BUG-907, outlet pipe top above inlet pipe top (8a16a42e)

1. **What the drafter sees:** in CDRULES, Design Check and Project Review, the "Pit invert drop" rule can now also show a WARN line at a pit where the main outlet pipe's top (invert plus diameter) sits above an incoming pipe's top, with a Fix suggestion "Lower the outlet IL ..." (CDEDIT).
2. **One code path:** the new check uses the same pipe reading as the drop rule (`ReadPipes` now also hands back the pipes), so the same incoming pipes and the same nominated main outlet.
3. **Switch:** `inverts.pitDropWarnsOutletTopAboveInletTop`, ON, both reads; OFF = no extra lines. Unknown levels or sizes give no finding (nothing guessed). No engineering tolerance added (a one-billionth-of-a-mm noise guard only).
4. **No-hard-blocks:** warning only.
5. **Notes:**
   1. A pit now carries two findings under the same rule id (Pass plus Warn). Check that rule counts, Ignore keys and Fix All treat that sensibly; not traced.
   2. Box culverts: "top" is invert plus the `Diameter` field. If a box's Diameter holds its width, the top is wrong. Not checked.
6. **Verdict: KEEP-WITH-NOTE.** Train: Civil rules area plus smoke.

#### #1950 B-120 BUG-1152, refused twin detention pipe upgrade puts the route back (649df208)

1. **What the drafter sees:** on open, if CE cannot upgrade an old twin detention pipe, its main line goes back to the barrel route it had (it used to stay on the centreline while the record still said barrel). One CE log line; nothing blocked.
2. **How:** `TryReplaceRootVertices` now snapshots every vertex (position, bulge, widths) before the rewrite; on a refusal or an exception, `TryRestoreTwinRoot` puts them back in a new transaction and removes the pipe from the "route changed" list. If the object is already a pipe object, it leaves it.
3. **Switch:** `linking.twinUpgradeRestoresRouteOnRefusal`, ON, both reads; OFF = old behaviour (never restored).
4. **No-hard-blocks:** none; a failed restore is logged only. Protection: the restore uses the same `SafeOpenForWrite` as the rewrite.
5. **Not proven:** the real put-back (needs a refused upgrade in AutoCAD); the restore always sets the polyline open, which matches a pipe.
6. **Verdict: KEEP-WITH-NOTE.** Train: FULL (drawing-open upgrade path).

#### #1954 B-120 BUG-1108, Manningham 2,000 L tested against the reuse share (da8e8f68, on #1874)

1. **What the drafter sees today: nothing.** The reuse share is the tank less "detention litres", and nothing sets detention litres yet (CDDESIGN has no box; Codex window brief item 11). The author says so plainly.
2. **Switch:** `detention.reuseMinimumUsesReuseShare`, ON, both reads; OFF = whole tank tested as before.
3. **No-hard-blocks:** a "no credit" reason line only.
4. **Merge:** rides on #1874; see the reuse-stack join above.
5. **Verdict: KEEP-WITH-NOTE (dormant until the box exists).** Train: with #1874, Civil detention area plus smoke.

#### #1956 B-120 BUG-1156, Save Draft keeps fields a newer build wrote (8b7ade95, on #1874)

1. **What changes:** every part of the CDDESIGN Design draft (setup inputs, pending outlet, sources, agreed design and its parts) gains a JSON catch-all, deep-copied on every copy, so an older CE no longer wipes the orifice head and "detention required" answers a newer CE saved.
2. **Switch:** `detention.designDraftKeepsUnknownFields`, ON, both reads; OFF strips every catch-all on read (old behaviour).
3. **No-hard-blocks, protection, REDO:** none affected; the draft is the same record, written by the same Save Draft.
4. **Note:** a newer build's answer can now travel unchanged after the older build changed the inputs it depended on (for example the site area). The newer build will then read an answer made for the old figures. That is the usual price of keeping unknown fields; worth one line in the log.
5. **Verdict: KEEP-WITH-NOTE.** Train: with #1874, Civil CDDESIGN area plus smoke.

#### #1960 B-120 BUG-80, one maximum-speed table (02d582e3)

1. **What the drafter sees:** a uPVC connection pipe in auto-design is sized to 3.0 m/s (can come out one size bigger at high flow), and the Edit Pipe grade strip warns a uPVC pipe above 3.0 m/s. Concrete stays 6.0.
2. **Authority:** plan rule R-01 (one house-rule table; QUESTIONS 112 says "NOT ASKED: the plan already has R-01"); the CPAA manual gives no uPVC figure (author read the note). Values come only from the Settings table.
3. **Switch:** `pipeSpeedChecks.sizingReadsMaterialTable`, ON, both reads. **OFF is exact:** I checked `PipeSizingStandards.CreateDefault()` is `ForEveryMaterial(CurrentOffice())`, which OFF returns.
4. **No-hard-blocks:** a speed above the limit warns only.
5. **Notes:** the new property was inserted between `ForEveryMaterial`'s doc comment and the method, so that comment ("DISAGREEMENT kept as today ... waiting for Tim") now sits on the wrong member and is stale; the file's first-line byte-order mark was removed (harmless).
6. **Verdict: KEEP-WITH-NOTE.** Train: Civil design and auto-design area plus smoke (it changes a sizing result, so the auto-design cases must run).

#### #1951 B-127 BUG-1265, one shared live-or-saved rule (d34c51b8, on #1880)

1. **What changes:** nothing a drafter sees. CDCHECK and the Inspector now both ask `ProjectRecordReadRule.Choose`. I compared the logic line by line: identical to both old copies. A wrong switch name in a comment is fixed.
2. **Switch:** none needed (both existing switches still feed it).
3. **Verdict: KEEP.** Train: with #1880, Civil Inspector area plus smoke.

#### #1953 B-127 BUG-1263, Inspector shows the list CE is keeping for a drawing it could not save (c6a04c9a)

1. **What the drafter sees:** after a change in drawing A that could not be saved, then a switch to B and back, picking a pit in A shows CE's newer kept values, not the last saved ones.
2. **How:** `TryReadKeptRecordCopy` peeks (never takes) the kept record under the lock, only for the same native drawing AND the same path, and hands back a copy. Only replaces the "read the saved list" answer.
3. **Switch:** `linking.inspectorShowsRecordWaitingToSave`, ON, both reads; OFF = today exactly.
4. **No-hard-blocks, protection, REDO:** read only, memory only.
5. **Not proven:** that the kept record's stored path matches `doc.Name` in the same form (both look like the full path; if they differ, the peek never matches and the fix silently does nothing). The two-drawing Codex case decides it.
6. **Verdict: KEEP-WITH-NOTE.** Train: with #1880 stack, Civil Inspector area plus smoke.

#### #1955 B-127 BUG-1264, Undo in drawing A after a pick in B (f5d89113)

1. **What the drafter sees:** an Undo in A back before its first CE save now clears CE's pit list for A even if a pit in B was picked in between (the Inspector no longer lists a pit the Undo removed).
2. **How:** the one "record embedded in this drawing" note becomes a per-drawing set (`EmbeddedRecordMemory`), forgotten when a drawing closes.
3. **Switch:** `linking.undoRemembersEachDrawingsRecord`, ON, both reads; OFF = only the last drawing noted, and nothing forgotten at close, exactly as before.
4. **Protected file:** this PR also edits `ProjectDataService.Persistence.cs` (the brief named only #1952). The change is memory only and reads correctly.
5. **Notes:** in that protected file the new `EveryDrawingsEmbeddedRecordSwitchOn` was inserted under the BUG-971 doc comment of `ForgetUnreadableRecordHold`, so that comment now describes the wrong method; move it back. The author ran the REDO safety scan (25 of 25).
6. **Verdict: KEEP-WITH-NOTE.** Train: FULL (Undo path, protected file).

#### #1958 B-127 BUG-1266, unreadable saved list logged once per drawing (9d25604c)

1. **What changes:** the Inspector stops re-reading and re-logging an unreadable saved list on every pick; one log line per drawing. Values still show Unknown. The note is dropped when a list is in memory, when the drawing closes, and on Save As (the key includes the path).
2. **Switch:** `linking.inspectorUnreadableRecordLoggedOnce`, ON, both reads; OFF = today.
3. **Note:** if the saved list becomes readable again without CE loading it into memory, the Inspector keeps showing Unknown until a CE command runs. Acceptable, but say it in the log.
4. **Verdict: KEEP-WITH-NOTE.** Train: with #1880 stack, Civil Inspector area plus smoke.

#### #1952 B-118 BUG-1070, Undo lifts the "cannot save over an unreadable record" hold (6845a095), PROTECTED FILE

1. **What the drafter sees:** if a CE record became unreadable, then U brings the good record back, CE starts saving again (before, the hold stayed on and later CE changes were quietly not stored). REDO back to the damaged state puts the hold back.
2. **How:** one place decides, `UnreadableRecordHold.Update` (held, released, or unchanged). The normal open, the U/REDO re-read and its idle retry all call it. The U/REDO re-read now uses `TryLoadFromDrawingLightDetailed`; I checked it is the same open-close read as before plus the "record had text" answer, so the REDO-safe read is kept.
3. **Safety checked:** a release after U happens only when the record read fine or is absent. When it read fine, `DecideHistoryReload` always loads that good record into memory (`UseDrawingRecord`), so CE never saves an old in-memory list over a good record. A transient failure leaves the hold alone. No command-line line from U/REDO.
4. **Switch:** `linking.undoRefreshesUnreadableRecordHold`, ON, both reads; OFF = the re-reads never move the hold (old). BUG-971's `keepUnreadableDrawingRecord` still wins.
5. **Tests:** `Bug1070UndoRefreshesHoldTests` (open damaged, U, REDO, U: true, false, true, false), plus the re-pointed BUG-971 source guard; RedoSafe call-graph scan passed (author's run).
6. **Not proven:** U and REDO in AutoCAD.
7. **Verdict: KEEP-WITH-NOTE.** Train: FULL (protected record file, Undo path).

#### #1957 B-129 BUG-1211, CDMENU checks the Civil menu is really loaded, AutoCAD 2022 to 2024 (4e1574d6)

1. **What the drafter sees:** CDMENU or Restore CE Civil Tools asks AutoCAD (late-bound `MenuGroups`) whether CE_CVL_SUITE_MENU is loaded. If not, it loads it again; it says "loaded" only when AutoCAD confirms. The Repair window no longer says "OK" just because the file exists.
2. **Switch:** `install.restoreMenuChecksLoadedGroup`, ON, both reads; OFF = old lines and old skip.
3. **No-hard-blocks:** none.
4. **Note:** when AutoCAD cannot answer (null), the explicit restore now reloads the menu in the same session. The old code deliberately never reloaded it in one session. If the group was in fact loaded, this is a second load of a loaded group; not tested on any year.
5. **Not proven:** anything on 2022 to 2024; there is no robot lane for those years.
6. **Verdict: KEEP-WITH-NOTE.** Train: Civil install area plus smoke on the net48 lane.

#### #1959 B-129 BUG-1214, CDASK From file offers no PDFs on AutoCAD 2022 to 2024 (d7c1e154)

1. **What the drafter sees:** on 2022 to 2024 the picker lists images (PNG, JPG) and All files only. A PDF picked through All files still gets the old "PDF support requires AutoCAD 2025 or later" line. 2025 and later unchanged.
2. **Checked:** the lane test uses `#if NET8_0_OR_GREATER`, the same guard the PDF reader itself uses.
3. **Switch:** `ai.markupFilePickerMatchesLane`, ON, both reads; OFF = old list exactly.
4. **Verdict: KEEP.** Train: Civil CDASK area plus smoke on the net48 lane. (A byte-order mark was added to the file's first line; harmless.)

#### #1961 B-131 BUG-538 part, Manningham reuse credit on its council profile (58aae852)

1. **What the drafter sees:** nothing. Same 0.25 x SSR x roof share, 2,000 L, 50 m2; now read from the Manningham profile with its source (OSD Guidelines v001.6, March 2021, pp. 12 to 13).
2. **No switch:** the author argues none is needed because the numbers do not move (a test pins five tank cases) and removing the profile line returns the built-in rule. I accept that; it is a data move, not a behaviour change.
3. **CDRULES fingerprint:** the source entries of four fields CDRULES never reads are now left out of the fingerprint, so Manningham's saved CDRULES runs do not go stale. I checked the shipped profile file has no such entries for any other council today, so no other council's fingerprint moves.
4. **Notes:** the "Sourced" status rests on our written note of the council document; the council PDF was not opened. Five more council numbers are questions for Tim in the n17 report (not asked here).
5. **Verdict: KEEP-WITH-NOTE.** Train: Civil detention area plus smoke.

#### #1962 B-131 BUG-1094, Inspector shows a pipe flatter than minimum in red (7f7bc477)

1. **What the drafter sees:** 1 in 235 against a 1 in 200 minimum is now red, as CDRULES says (it was amber up to 1 in 240).
2. **Switch:** `grade.inspectorFlatterThanMinimumShowsRed`, ON, both reads; OFF = the old 1.2 band exactly. The minimum still comes from Settings.
3. **Note:** a pipe at 1 in 200.3 displays "1:200" but is now red. Same as CDRULES's strict answer, but it may look odd on screen.
4. **Verdict: KEEP-WITH-NOTE.** Train: Civil Inspector area plus smoke. (Civil `UserSettings.cs` loses its byte-order mark here; it joins cleanly with every other PR.)

---

### Verdicts in one place

1. **KEEP (3):** #1882, #1951, #1959.
2. **KEEP-WITH-NOTE (30):** #1887, #1891, #1940, #1943, #1885, #1929, #1931, #1932, #1933, #1934, #1901, #1899, #1898, #1930, #1906, #1946, #1947, #1948, #1949, #1950, #1954, #1956, #1960, #1953, #1955, #1958, #1952, #1957, #1961, #1962.
3. **CHANGE-NEEDED (1):** #1945 (one word: compare the drawings with `==`, not `ReferenceEquals`).

### What I could not verify

1. Any test result: I ran none. "Red before, green after" is from the authors, checked only by reading the tests.
2. Anything in AutoCAD, on any year.
3. Whether the stored kept-record path matches `doc.Name` (#1953), how many outline pieces an RC detail has (#1931), what status AutoCAD returns for Enter at the XRL prompt (#1901), and whether AutoCAD 2022 to 2024 answer the `MenuGroups` read (#1957).
4. Whether the #1948 sentence feeds any saved sheet or approval hash.
