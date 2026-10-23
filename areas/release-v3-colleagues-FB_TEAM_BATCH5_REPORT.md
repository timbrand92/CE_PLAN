# FB Team batch 5: carpark BUG-1035 to BUG-1039 (24 Oct 2026, Melbourne time)

Built and unit-tested only. Nobody has opened any of this in AutoCAD. No bug is marked FIXED. Nothing was closed, deleted, deployed or installed.

## ANSWER FIRST

All five were real (checked in the code) and not already fixed. No open or closed PR, no `cx4/*` branch (only `cx4/fa03-drainage` and `cx4/fa04-rd08-desk` exist) and no CODEX_FIXAUDIT report covers any of them (RD01 and RD02 are not in Codex's fix list). Five draft PRs, one per bug.

1. **BUG-1035 (Pit Schedule "Shallow" from a hidden 300 mm): fixed in draft PR #1722, head `544022b8`.** The line is now a Settings value `linking.shallowPitDepthMm` (300 mm unless changed), a warning only. **Settings page box NOT added** (needs Tim's layout word, options in the PR). Tests: new Bug1035 tests plus fingerprint, settings-default and depth-rule tests, 134 of 134 pass. Civil net10 full run 19,555 total: 19,531 passed, 22 skipped, 2 failed; one failure was my own doc line (fixed, passes), the other a log-timing test that passes alone. No full re-run after that one-line fix.
2. **BUG-1036 (Pipe Flows note quotes 0.013 / 0.010): fixed in draft PR #1728, head `7620849b`.** Wording only: the note now says "(from the pipe material, per office Settings)" with no fixed numbers. Tests: new Bug1036 tests fail on the base, pass after; Calc-filtered 465 of 465. Civil net10 full run 19,550 total: 19,525 passed, 22 skipped, 3 failed (two timeout tests and the PDF load test, all load-sensitive; the 3 pass alone, 3 of 3).
3. **BUG-1037 (column bar circles one fixed size): fixed in draft PR #1729, head `0d215deb`, base claude/rel-20261023s.** Circle diameter = picked bar's real diameter x member scale (N12 at DIMSCALE 20 = radius 6 mm). Switch `options.columnBarsAtRealSize`, ships ON. Tests: 10 new, all pass. Structural net10: 4,137 passed, 0 failed (main run), 474 of 474 (Settings, Sheets, Template and WindowRender classes). Net48 compile of the main project: 0 C# errors.
4. **BUG-1038 (bar counts pick-only): fixed in draft PR #1731, head `115a5c19`, base claude/rel-20261023s.** The RCBEAM, RCRECTCOL and RCCIRCCOL count boxes accept a typed whole number, 1 to 999 (999 is only a loop safety limit). Switch `options.barCountsTypedFreely`, ships ON. Tests: 3 real window runs plus the entry rule, all pass. Structural net10: 4,128 passed, 0 failed (main run was ended by my hang timer, see below), 474 of 474 (the Settings group). **Column warning rules for unusual arrangements not added** (none exist today; I did not invent engineering rules).
5. **BUG-1039 (timber quantity limited to 1 to 9): fixed in draft PR #1732, head `91530aef`, base claude/rel-20261023s.** Any whole number of 1 or more accepted. Switch `options.timberQuantityAnyNumber`, ships ON. I rewrote the one existing test that pinned "10 is refused" (said so in the PR). Structural net10: 4,128 passed, 0 failed (main run, hang-timer end), 488 of 488 (Settings group plus the picker classes).

**Real-AutoCAD checks:** each PR carries its own numbered steps (also copied below). None has been done.

**What I did NOT test**
1. Anything in AutoCAD (no AutoCAD, Codex or accoreconsole started by me; AutoCAD 2027 was already running on the PC all night).
2. The net48 test lanes (net48 test hosts do not load per the known trap). Net48 compile of the main Structural project: 0 C# errors for BUG-1037; the build then stops at a post-build binary check that needs powershell on the shell PATH (setup gap). BUG-1038 and BUG-1039: the full net48 Release build of the main Structural project succeeded with 0 errors (with powershell on the shell PATH).
3. Structural slow classes `Sbeam`, `R16`, `CompiledProductionRoute` were excluded from the Structural runs (they fail or crawl on the untouched base per the known traps). On all three Structural runs one test hung near the end and my `--blame-hang-timeout 150s` ended the host: "Test Run Aborted", 0 failures, 4,128 to 4,137 reported passes. I did not identify the hanging test or prove it hangs on the base.
4. The Civil full suite was not re-run after the BUG-1035 one-line doc fix.
5. Window pictures under `docs/image` (the BUG-1038 count boxes now look like editable boxes): the render tests regenerate them; I reverted the regenerated PNGs and did not commit any.
6. No Settings page rows were added for any of the new keys (layout is Tim's call).

## Per bug detail

### BUG-1035 (PR #1722, branch `fb/b5-bug1035-shallow-pit-setting`)
1. **Cause (verified):** `PitScheduleViewModel.ShallowDepthThreshold` was a private constant 0.30; `UpdateWarning` compared the depth against it.
2. **Fix:** new `LinkingSettings.ShallowPitDepthMm` (default 300), read through `PitScheduleDepthRule.ShallowPitDepthMetres` (0, negative or non-number falls back to 300).
3. **Trap found and avoided:** I first put the value in the design standards group; 13 pinned CDRULES job-fingerprint tests failed (a new design-standards key moves every saved check fingerprint). Moved to the linking group.
4. **Options for the Settings box (Tim to choose):** (a) a new row in the pit group of CDS > Pipes and Pits (my suggestion); (b) beside the step-iron depth on the Design page.
5. **Real-AutoCAD check:** close AutoCAD, back up the Settings file, set `shallowPitDepthMm` to 450 under `linking`, start AutoCAD. PITSCHEDULE, untick "Auto-calculate depth", "+ Add Row" three times, type Depth 0.29, 0.30, 0.31 (Tab after each). Right: all three read "Shallow". Restore the Settings file byte for byte; with 300, 0.29 is Shallow and 0.30, 0.31 are OK.

### BUG-1036 (PR #1728, branch `fb/b5-bug1036-roughness-note`)
1. **Cause (verified):** `CalculationsV2Dialog.xaml` lines 588 and 590 carried the literal text.
2. **Fix:** the hover and the note carry no fixed numbers.
3. **Real-AutoCAD check:** isolated Settings profile with UPVC and PVC Manning n both 0.015; one 300 mm UPVC pipe; CDCALC > Pipe Flows, choose the pipe. Right: Roughness 0.015, note "(from the pipe material, per office Settings)", hover with no 0.013 or 0.010.

### BUG-1037 (PR #1729, branch `fb/b5-bug1037-column-bar-size`)
1. **Cause (verified):** `ColumnDetailCommands` drew the bar dots at `dimScale * 2.0` across, for both RCRECTCOL and RCCIRCCOL.
2. **Fix:** new pure rule `ColumnBarDotRule.DrawnDiameter`, both commands call it, with the `options.columnBarsAtRealSize` switch (ON) and the old constant removed.
3. **Real-AutoCAD check:** DIMSCALE 20, INSUNITS 4. RCRECTCOL 400 x 400, N12, two per face, N10 ties, cover 40, at 0,0: LIST the circle centred 56,56: radius 6. Repeat at 1000,0 with N24: radius 12. RCCIRCCOL 450, eight N12: radius 6. U once removes each column.

### BUG-1038 (PR #1731, branch `fb/b5-bug1038-typed-bar-count`)
1. **Cause (verified):** the four count boxes were non-editable `ComboBox`es and the code read only `SelectedItem`.
2. **Fix:** the boxes become editable (switch ON), every read goes through one helper, a bad typed count is refused with a "[CE]" message (never defaulted), 999 is a loop safety limit.
3. **Real-AutoCAD check:** RCCIRCCOL 600 dia, N20, N10 ties, cover 40, type 14 in Total bars, Place Section at 0,0: label 14N20 and exactly 14 bar circles; repeat 18. RCRECTCOL 800 x 800 with 7 per face: 24 bars. RCBEAM, type 14 bottom bars: kept. Clear a box or type 0 and press OK: a message, window stays open.

### BUG-1039 (PR #1732, branch `fb/b5-bug1039-timber-quantity`)
1. **Cause (verified):** `MaxTimberQuantity = 9` in `TryParseTimberQuantity`.
2. **Fix:** the ceiling only applies when the switch `options.timberQuantityAnyNumber` is off; message reads "must be a whole number, 1 or more".
3. **Real-AutoCAD check:** SBEAM, Timber, MGP10, width 45, depth 190, quantity 9 (OK enabled), then 10: stays, OK stays enabled, label "10 No 45 x 190 MGP10". 0 or 2.5: message and OK greyed.

## Environment notes
1. Base heads: Civil `origin/claude/rel-20261023m` = `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`; Structural `origin/claude/rel-20261023s` = `e6d597c0fbc25e78118760887a70810e0890c9a9`.
2. Builds were `-c Release`, always `-p:SkipDevBundle=true -nr:false --disable-build-servers`, refs from the C-62 and S-42 reports. Free space stayed above 21 GB. Private worktrees `C:\ce-fx\w1035` to `w1039`, one per fix, cleaned up at the end (branches stay on origin).
3. Shared and Installer untouched. No settings file, installed bundle or ProgramData touched.
4. The PC was heavily loaded (other lanes' builds, AutoCAD at 97 per cent CPU); the first Civil full run took 25 minutes and the load-sensitive failures above are why.
5. The `gh` tool needed `C:\Program Files\GitHub CLI` and Git on PATH; nothing else unusual.
