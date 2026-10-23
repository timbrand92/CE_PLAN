# Fix round for train C-62 (Fri 23 Oct 2026, run 13:00 to 14:45 Melbourne time; Sonnet 5.5, headless)

Input: `REVIEW_FIXWAVE2_A_2026-10-23.md` and `REVIEW_FIXWAVE2_B_2026-10-23.md`. Base for every merge: `claude/rel-20261023l` @ 88bd62f7 (C-61, installed Civil 3.0.71, Manager 1.1.71). Method: one private worktree per PR under `C:\ce-fx`, `origin/claude/rel-20261023l` merged into the PR branch (no rebase), normal push, one fix commit on top of the merge commit, worktree removed after each PR. Every build and test: Release, net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the AutoCAD refs from the C-57 report, foreground, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, TEMP redirected. No AutoCAD, Codex or accoreconsole was started. Nothing closed, deleted, installed or marked FIXED. No PR base was changed (the PRs still target the older C-60 branch; retarget when C-62 is cut).

## ANSWER FIRST

1. **All 14 listed A PRs plus #1611, #1612 and #1617 are done, and the new CDRG fault is confirmed and fixed in a new draft PR #1645.** Every Civil full run passed with 0 failures (19,452 to 19,459 tests; the Glen Eira back-test passes on this base). Manager PRs: 918 tests, 0 failed. Built and unit-tested only. Nobody has opened any of it in AutoCAD.
2. **Fix PRs (new head, fix, tests):**
   1. **#1553** BUG-967, head `a51a9216112a73e833a9cee79a34a4d26d352405`. The old "N m2 is not in any catchment" note now counts the listed garden and lawn, so the 1000 m2 example no longer contradicts the pervious note. A report that lists only garden and lawn says "No roof or paved catchments were found". 2 tests added, 1 extended. Civil 19,455 total, 19,433 passed, 22 skipped, 0 failed.
   2. **#1556** BUG-970, head `2bd5c2bec6a7e779c5b05727f75b238484d84f67`. When the same pit mark repeats across schedule sets the typed answer is read as a row number first, so marks "2" and "2" can still pick row 2. A drawing with all-different marks reads as before. 2 tests added. Re-run on the merged C-61 train with the drawing-units switch ON. Civil 19,459 total, 19,437 passed, 22 skipped, 0 failed.
   3. **#1558** BUG-877, head `980069886b8058767f3959c6b3e8eb793ea73a7d`. "Default: on." added to the switch note (stays ON). Civil 19,458 total, 19,436 passed, 22 skipped, 0 failed (the settings census test passes).
   4. **#1562** BUG-874, head `f119d8e7a4f52787f491f7dc5e4af9d6955eee50`. "Default: on." added (stays ON). Civil 19,462 total, 19,440 passed, 22 skipped, 0 failed (includes the redo-safety call-graph test on the merged tree).
   5. **#1567** BUG-963, head `111b8e0a7a8efce26e2ab51800b1dda552c388c9`. "Default: on." added (stays ON). Civil 19,457 total, 19,435 passed, 22 skipped, 0 failed.
   6. **#1570** BUG-965, head `92e83fa5ef6c7bb60c61108aec40778e235aa07f`. "Default: on." added (stays ON). Civil 19,458 total, 19,436 passed, 22 skipped, 0 failed.
   7. **#1612** BUG-1011, head `8690ce145a3c5d4bb35d7953502582b137ab9ddb`. The invert is set first, then the status line reads "Outlet invert changes from ... to ... Your typed value is waiting ...", so the first sentence is no longer overwritten. A row that is already waiting (a remark typed first) now solves a typed depth too. The REGRESSION_LOG wording now says the outlet invert cell changes and Stop overriding writes it to the pit, and the AutoCAD check uses a pit with no recorded floor plus one with a floor. 2 tests added or changed. Civil 19,455 total, 19,433 passed, 22 skipped, 0 failed.
   8. **#1617** BUG-999, head `eadc79ee54da6d99d189a248601e610615e70b3f`. The command line now reads "[CDRUNSOLVE] Nothing was changed. CE could not size these pipes because none of them has a design flow yet." For any other reason: "CE could not solve N pipe(s). The first was A to C: <reason in plain words>." No infeasible, no INVALID_FLOW, no doubled command name, and the older "Plan could not be built -" lead-in is gone. 5 reason cases tested. Civil 19,459 total, 19,437 passed, 22 skipped, 0 failed.
3. **Clean MERGE PRs (C-61 merged in, nothing else changed, build checked):**
   1. **#1552** head `277ca0de5e409026e456a07013d5f04d66766df4`. Civil 19,453 total, 19,431 passed, 22 skipped, 0 failed.
   2. **#1557** head `951e5b50e312693a563fcaa2ac1ff7c59da36681`. Civil 19,456 total, 19,434 passed, 22 skipped, 0 failed.
   3. **#1586** head `ea52fbb5dc48ba74cc155b0c0e4026ad1de47a8e`. Civil 19,452 total, 19,430 passed, 22 skipped, 0 failed.
   4. **#1591** head `2759f760bd15cb6e43017435a5d8c88c21795cb7`. Civil 19,454 total, 19,432 passed, 22 skipped, 0 failed.
   5. **#1594** (Manager) head `5fc37df6c866ad85a184ff98e4eef96c83246b6d`. Manager 918 total, 917 passed, 1 skipped, 0 failed.
   6. **#1595** (Manager) head `6db38faf98b2854e878750ca97f64eb9990f6d6a`. Manager 918 total, 917 passed, 1 skipped, 0 failed.
   7. **#1611** head `b32cb106e2459de8ca23374cb6afc26afab927fe`. Civil 19,453 total, 19,431 passed, 22 skipped, 0 failed. (The review said MERGE, no fix, so only C-61 was merged in.)
4. **Recorded only (batch B, not touched, no merge pushed):** #1609 `498f0f7a4059c45f8a76416df581aac901594c88`, #1610 `78a2303fcf041927a814b4187d60e93d4fc60f80`, #1613 `f514c8ef591afc4e6f9cfbbb09ee12bbf0945c14`, #1619 `a47286eef36381160013f23e4ce4ea0efd2a1aed`, #1623 `e0397253747bd872c403e315db51d030f6a0976f`, #1625 `08e3002651098817ddac9acfbe37ce28d2215468`, #1632 `1899db506693d7002db73a25782075211b3cbfd3` (already based on C-61).
5. **Not touched, as told:** #1576 and #1555 (HOLD), #1621 (REJECT), #1630, #1624, #1622 (duplicates), every other PR.
6. **Dry merge of all 22 listed PRs onto C-61, in the order given (`git merge-tree`, objects only):** every one clashes in `REGRESSION_LOG.md` only (keep every entry), except **#1562, which also clashes in `Modules/Drainage/Models/UserSettings.cs`** (it adds its switch at the top of `LinkingSettings`, next to the blocks #1567 and #1570 added earlier in the chain: keep all of them). No other code clash. The dry merge proves the text merges, not that the merged train compiles. Detail in section 2.
7. **CDRG: CONFIRMED from the code, fixed, new DRAFT PR #1645, branch `fw2/cdrg-rollback`, head `80b77a157b378c280079f5f9aede6bbf32372e51`, off C-61.** Details in section 3. Civil 19,452 total, 19,430 passed, 22 skipped, 0 failed. Not seen in AutoCAD, so it is still only "from the code". The carpark entry for it is still to be filed by the desk (I was told not to edit `BUG_CARPARK.md`).
8. **Left undone from the reviews (they were not in this brief):** the LOW items (for example #1557 two summaries on one method, #1562 failed-handler source pin, #1567 reason wording, #1610 `e.Handled` pin), the five CDS rows and the C62 copy of `C61NewSwitchDefaultsTests` for the new switches, the #1632 log line, and the net48 build (batches 2 and 3 never built net48; I built net10 only, so the C-62 finalizer still owes the net48 build).
9. **Hygiene:** Tim's settings files were not modified (no settings file under the Roaming folder is newer than 12:40 today; `CD_Settings.json` still dated 11 Mar). No installed bundle, ProgramData or `DESK_LOG.md` touched. All my worktrees are removed (the `t3*` worktrees under `C:\ce-fx` belong to another lane and were left alone). The build lock was taken and released around every command.

## 1. What I changed, in AutoCAD terms (what to look at when these are driven)

1. **#1553 CDDESIGN rating report:** a Blue Factor report with 400 roof, 100 drive, 300 garden, 200 lawn on a 1000 m2 site still offers "Roof and paved area 500 m2" and now shows only the garden-and-lawn note. Before the fix it also said "500 m2 is not in any catchment", which contradicted it.
2. **#1556 CDTWL:** two schedule sets each with a detention pit marked "2": CDTWL lists rows 1 and 2 and typing 2 now picks set B.
3. **#1558, #1562, #1567, #1570:** no change on screen. Each switch still ships ON; only its documentation line changed so the C-61 settings census test passes.
4. **#1612 Pit Schedule typed depth:** untick Auto-calculate depth on a pit with no recorded floor, type 1.15 over cover 42.350 and outlet IL 41.250. Expect the outlet IL cell 41.20 and a status line that begins "Outlet invert changes from 41.25 m to 41.20 m" and ends "Your typed value is waiting...". The same now works on a row where a remark was typed first. Stop overriding then writes it (one U undoes it). On a pit with a recorded floor the floor sentence appears and nothing changes.
5. **#1617 CDRUNSOLVE:** with no flow set it prints the plain "none of them has a design flow yet" line and changes nothing.

## 2. Dry-merge order and result (base C-61 88bd62f7)

Order as given: #1613, #1632, #1610, #1609, #1619, #1625, #1623, #1611, #1617, #1612, #1552, #1553, #1586, #1591, #1557, #1558, #1570, #1567, #1562, #1556, #1594, #1595. Tips used are the heads in this report.

1. #1613, #1632, #1610, #1609, #1619, #1625, #1623, #1611, #1617, #1612, #1552, #1553, #1586, #1591, #1557, #1558, #1570, #1567: each conflicts in `REGRESSION_LOG.md` only.
2. **#1562: conflicts in `REGRESSION_LOG.md` and `Modules/Drainage/Models/UserSettings.cs`.** Resolution: keep every switch block (the `LinkingSettings` additions of #1567, #1570 and #1562 sit side by side).
3. #1556, #1594, #1595: each conflicts in `REGRESSION_LOG.md` only. (#1594 and #1595 both touch `PluginManagerCommands.cs` and merge cleanly.)
4. **Practical note for the assembler:** the order is fine; resolve `REGRESSION_LOG.md` each time by keeping both sides (newest on top). The one code clash is the `UserSettings.cs` one at #1562. Do not add #1630, #1624, #1622 or #1621 to this train (they overlap #1619, #1623, #1625 and #1632).

## 3. CDRG (raingarden) result: CONFIRMED from the code

1. **The writer:** `SourcePlacementService.AppendRaingardenGeometry` sets `ColorIndex = ByLayerColourIndex` (256) on both the outline polyline and the hatch (card 5.3, commit 8f743e93).
2. **The check:** `RaingardenPlacementPlan.RequireExactAuthoredAppearance` (called from `RequireRaingardenGeometry`, `SourcePlacementService.cs` line 940 on C-61) demanded colour 3 for the outline and 113 for the hatch, so with 256 it threw "The raingarden boundary or hatch appearance changed during placement." and the placement is rolled back. Same fault as CDSPOON (BUG-966).
3. **The fix (same one-line approach as CDSPOON):** the check accepts ByLayer (256) only, through one helper `RaingardenColourReadbackAccepted`. A wrong pattern or any other colour still refuses.
4. **The tests:** `RaingardenAtomicPlacementTests` had the stale expectation (colours 3 and 113); it now feeds 256 and checks that 3 and 113 are refused. A new source pin checks that the writer sets ByLayer on both objects and the readback accepts exactly that. I did not run the old code to see the red; it is red by reading (the old check throws on 256).
5. **Not proven:** one real CDRG in AutoCAD. Check: on a copy run CDRG with a 4 x 2 m outline; expect the outline and hatch stay, `LIST` shows Color BYLAYER on both, no "appearance changed" message, one U removes both.
6. **Carpark:** needs a new BUG number from the desk (the next free one); I did not edit `BUG_CARPARK.md`.

## 4. What I did NOT test

1. No AutoCAD, no window, no picture, no accoreconsole, no Codex.
2. No net48 build of any of these.
3. Structural tests (no PR touches Structural).
4. The Manager PRs ran Manager tests only; Civil was not rebuilt for them (#1594 and #1595 change Manager files only).
5. The red-before of any new test (I relied on the builders' claims and, for the new CDRG test, on reading).
6. The merged train as one tree: the dry merge shows text clashes only.

Four words: **built and unit-tested. Not installed. Nobody has opened any of it in AutoCAD. None Tim-accepted or Codex-accepted.**

## 5. Test totals in one place (Civil net10, Release; all 0 failed)

1. #1553 19,455; #1556 19,459; #1558 19,458; #1562 19,462; #1567 19,457; #1570 19,458; #1612 19,455; #1617 19,459.
2. #1552 19,453; #1557 19,456; #1586 19,452; #1591 19,454; #1611 19,453; #1645 19,452.
3. Manager net10: #1594 918; #1595 918 (917 passed, 1 skipped).
4. One Manager run failed 8 tests at first on #1594 because my own log-folder override sat outside the TEMP folder the Manager hygiene tests insist on; with the override removed all passed. That was my test setup, not the PR.
5. One new test of mine on #1612 failed on the first run (the Stop overriding step needs a live AutoCAD in the test) and one on #1617 failed on the first run (the real solver note is a sentence, not the code word); both were fixed and re-run green.
