# Test tooling run 1 log (CE_ACAD / release-v3-colleagues / test-tooling / 01)

Headless Sonnet run started Sat 10 Oct 2026 about 00:35 PC clock. Authority: Tim, INT-080, "can we implement the opus research". Source: `release-v3-colleagues-AUTOCAD_TEST_OPTIONS_RESEARCH_2026-10-09.md`. AutoCAD was NOT run by this worker. An acad.exe was running at the start (somebody else's); nothing here touched it.

## Status by item (updated as I go)

1. **Item 1, witness recorder: BUILT and the reader UNIT-TESTED. Not run in AutoCAD.**
   - **Draft PR:** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/977 (branch `claude/tooling01-witness-recorder`, worktree `C:\ce-tt01`). Comment: needs Opus review.
   - **Files:** `tools\witness-recorder\` : `CE.Witness` (net10.0-windows, builds 0 warnings 0 errors), `reader\Test-WitnessRedo.ps1`, `reader\Show-WitnessLog.ps1`, `tests\`, `README.md`.
   - **Not in** `CE_ACAD_PLUGIN.slnx`, any bundle, payload or installer. No CE reference. Records test-copy folders only (same rule as the driver).
   - **Reader tests (RED first):** with no reader, 0 of 14 passed. After writing it, 14 of 14. Now 19 of 19 (with `-FromSeq/-ToSeq` and the viewer). A log with a REGEN in the wait FAILS naming the REGEN and its time; a clean log PASSES.
   - **One deliberate difference from the brief:** object lines carry the handle, the object type and the layer's HANDLE number, not the layer name. A name needs a table lookup, which is a drawing read inside a handler; the brief says none. Names can be resolved offline.
   - **One addition to the assertion:** another command starting in the wait (a REGEN) also fails it, because REDO then does not follow straight after the undo. Lock lines named after U/UNDO/MREDO/REDO themselves are ignored unless `-StrictLocks`. That rule is a guess for the pilot to confirm.
2. **Item 2, driver allowance: DONE as a copy plus patch, needs Opus review. `acad_driver.ps1` is UNCHANGED.**
   - **Copy:** `C:\Lisp Files\_ACAD_DRIVER\acad_driver_witness.ps1`. **Patch:** `PATCH_witness_load_2026-10-10.diff` (original to copy; 195 lines; only 3 original lines changed: the header comment, the `help` text and the watchdog seconds, everything else is added).
   - **New sub-commands:** `witness check` (offline) and `witness load`. `witness load` takes no path. Fixed folder `C:\ce_rc_scratch\witness_bin`, fixed name `CE.Witness.dll`, pinned SHA256 in `CE.Witness.dll.sha256`, folder must hold no other DLL. It refuses unless: the caller holds the shared lock (stricter than other calls), the active drawing is an approved test copy, AutoCAD is idle, and SECURELOAD is 0 or the folder is in TRUSTEDPATHS (so it never triggers a trust question). FILEDIA is set to 0 for the load and back after. 20 s wait for the recorder's own "WitnessLoaded" line, else Esc to a window with a security-looking title, ^C^C, alarm set, and the call fails.
   - **What Opus should look at hardest:** (1) the `witness load` block in `Invoke-WitnessSub` (the only place that sends NETLOAD, bypassing the deny list for one fixed string); (2) `Test-WitnessBin` (TOCTOU: the hash is checked twice, but the file could still change between the second check and AutoCAD reading it); (3) the trust-question window titles, which are UNVERIFIED guesses; (4) that SECURELOAD 1/2 with an untrusted folder refuses rather than prompts.
   - **Tests (no AutoCAD):** `tests\Test-WitnessLoad.ps1`, 49 of 49 pass, includes "the copy's deny list, setvar list, bare-word list and lock list are identical to the original's" and "a typed NETLOAD is still refused".
   - **README:** new section "Witness load" in `_ACAD_DRIVER\README.md`.
   - **Staged:** `C:\ce_rc_scratch\witness_bin\CE.Witness.dll` plus `.sha256` = `ABC560650FE2A3D5BBE961237178D839F00EA0A23829D1D1FCA64AF1E7A1D568` (built from the PR #977 head; if the source changes, rebuild and re-pin). `witness check` reads it as OK.
3. **Item 3, pilot script: WRITTEN, NOT RUN.** `C:\Lisp Files\_ACAD_DRIVER\journeys\witness_pilot.json` (37 steps, about 27 driver calls) and `witness_pilot.md`. Calibration pair C1 to C4 (read, harmless open-for-write, real change). Pit Schedule walk as W35 with a plain-circle walk as the fallback, then the REGEN spoiler. `journey validate` accepts the file; `journey run` refuses it (it is a tester script, marked template). The Stop overriding step is a right-click the driver cannot make, so walk 1 may not be drivable: the pilot says to record that and use walk 2.

## Not mine, not done

1. The Autodesk cloud runner and a second PC or VM (Tim's decision, not authorised).
2. Any run in AutoCAD (Codex and the Claude tester own those windows).


4. **Item 4, "what got drawn": BUILT and UNIT-TESTED. The end-to-end AutoCAD run was NOT done: SKIPPED (an acad.exe was running, and the harness refuses to start then).**
   - **Draft PR:** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/978 (branch `claude/tooling01-what-got-drawn`). Needs Opus review.
   - **What:** new harness step `criteriaTable` (in the test-only partial class; places the CDCALC criteria table at a fixed point with CE's own steps, the same calls as the headless proof) and a `criteriaTable` assertion in `DwgAssertionRunner` that reads the SAVED drawing with ACadSharp 3.4.29: top-left corner at the pick (0.5 mm), row count 6, and VOLUME REQUIRED reads NOT SET. Scenario `TH01_CDCALC_Criteria_NotSet.scenario.json`. `PdfTextCompare` (PdfPig 0.1.9) for sheet text; no golden PDFs yet.
   - **Tests:** 15 of 15 pass, in a NEW project `Tests\CE.TestHarness.AssertionTests`. The assertion tests failed first (6 of 7), the PDF tests were written together with the helper (not strictly red-first). Why a new project: `CE.TestHarness.Tests` does NOT build on master (a Manager window file `SettingsWorkspacePage.xaml.cs` has a missing reference, error CS0234, unrelated to this work). I did not fix that.
   - **Built:** `CE.TestHarness` (net10.0-windows only; net48 and net8 lanes not built here). To build it in the worktree I copied an existing `CE_TRANSFORM_2027.arx` into the gitignored `bin` folder the Civil project expects, because the native build output was missing. That copy is not committed.
   - **Not proved:** that the real placed table reads back the way the synthetic one does (text alignment points, outline extents). The first real run will show it. The criteria block master must be findable next to the staged Civil DLL or the step fails with a clear message.
5. **Item 5, window pictures and ribbon: BUILT and UNIT-TESTED off screen. Not AutoCAD-tested.**
   - **Draft PR:** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/979 (branch `claude/tooling01-window-pictures`). Needs Opus review.
   - **Pictures:** Edit Pit and Edit Pipe, light and dark, 1712 x 889 at 96 DPI, made-up values; per-colour tolerance 6 of 255, fail above 0.01 percent of pixels. The four pictures are in `Modules\Drainage.Tests\Dialogs\WindowGoldens\candidates\` as **UNAPPROVED candidates**. `approved\` is empty, so the four compare-with-approved tests are INCONCLUSIVE (skipped) by design, never green. Only Tim or a Codex-accepted pass moves one across.
   - **Proof the compare fails when it should:** compare tests written first (6 of 6 failed), then 10 passed: two draws of each window are identical (4); one label made longer in a throwaway copy of the live window is caught for all four windows, with a red difference picture (4); the compare on made-up pictures (6). A sample difference picture: `C:\ce_rc_scratch\golden_proof\editpit-light-longer-label-DIFFERENCE.png`. I looked at the candidate and the difference picture: the Pit window shows "No preview for this pit" off screen (the real preview needs AutoCAD).
   - **How the proof was done:** "change one label length in a throwaway copy" was done on the live in-memory window inside the test, not by editing a XAML file; nothing was written to any source file.
   - **Test host needs the AutoCAD 2027 folder on PATH** (the Autodesk assemblies' native parts), otherwise NUnit says "failed to load". Written in the WindowGoldens README.
   - **Ribbon:** `tools\ui-contract`: expected CE tabs from the plan (today: CE, CE STRUC, CE Tools; V3 target: one CE tab, not built) and a comparer, 8 of 8 checks against the real tab strip read on 3 Oct. **A claim in the research note is wrong:** it says a driver `ui tree "Autodesk AutoCAD 2027"` can read the CE tabs. The driver refuses the AutoCAD main window (`Autodesk AutoCAD*` is on its UiWindowDeny list), and the 3 Oct ribbon files came from a one-off supervised probe. A read-only `ui ribbon` call would need Tim's approval and an Opus review. I did not build it.

## Skipped, and things that need Tim or Opus

1. **Opus review needed:** PRs #977, #978, #979 and the driver patch `PATCH_witness_load_2026-10-10.diff` (watch `Invoke-WitnessSub`, TOCTOU on the DLL, the guessed trust-prompt titles).
2. **Tim's decisions:** (a) does he accept the `witness load` allowance in the driver at all (it is the first NETLOAD the driver ever sends); (b) a read-only ribbon call for the driver; (c) whether the four window candidates may be approved from a Codex look at the real windows.
3. **Pilot not run:** it needs AutoCAD, the Claude driver tester and a free PC. The desk launches it. Pilot files: `_ACAD_DRIVER\journeys\witness_pilot.json` and `.md`. The PC had an acad.exe running at the start of this run.
4. **Master is stale** (memory note): I branched all three PRs from `origin/master` (`650c0c19`) as told; the witness and ui-contract folders are standalone and merge cleanly onto any train. The `criteriaTable` dispatch edit and the window tests touch files that the release trains may also have changed, so rebase risk is there.
5. **Not done, not authorised:** Autodesk cloud runner, second PC or VM.
6. **Left in place:** `C:\ce_rc_scratch\witness_bin` (DLL plus pinned hash for the pilot) and `C:\ce_rc_scratch\golden_proof`.

---

# RUN 2 (Sat 10 Oct 2026, started about 01:00 PC clock, headless Sonnet)

Authority as run 1. Brief: do the Opus review fixes first (entries 934 to 939 of the review lane log, and `C:\Lisp Files\_ACAD_DRIVER\REVIEW_witness_load_2026-10-10.md`), RED test first, on the existing branches (no new PRs). AutoCAD was NOT run. Reviewed only: not tested in AutoCAD, not installed, not Tim-accepted.

## A. Driver copy `acad_driver_witness.ps1` + patch: all six driver fixes DONE (needs Opus to confirm)

`acad_driver.ps1` is UNCHANGED (SHA256 c9ba503d...89ee; reverse-applying the new patch to the copy gives it back byte for byte). Offline tests `tests\Test-WitnessLoad.ps1`: new checks written first (many failed), then **82 of 82 pass** (was 49).

1. **HIGH, pin in the driver:** `$script:WitnessPinnedSha256` is a constant in the driver. The `.sha256` file next to the DLL is optional and only a cross-check (if it disagrees, refused). Test: DLL and `.sha256` both swapped (they agree with each other) is refused.
2. **MEDIUM, TOCTOU:** the DLL is opened once with share = Read only, hashed from that handle, and the handle is held until the load finishes, times out or is refused (a `finally`). Tests: while held, write, rename and delete of the DLL and rename of its parent folder all fail; a plain read-only open (what AutoCAD does) still works; the handle is released after.
3. **MEDIUM, folder contents:** exactly the DLL and optionally its `.sha256`; any other file (`.deps.json`, `.exe`, `.config`, `.txt`, a second DLL) or any sub-folder is refused, and a junction or link on the folder path (the folder or any parent) is refused. Tests include real junctions.
4. **MEDIUM, prompt titles:** exactly `*Security*`, `*Unsigned*`, `*File Loading*`, Esc only. `windows_seen` is still recorded.
5. **LOW, rejected send:** `Assert-WitnessSendAccepted` throws BUSY ("nothing was sent") straight after the send for `rejected`, `error*` or `unavailable`: no wait, no ^C^C, no alarm. Tested as a function and as the order inside the load block.
6. **LOW, second load:** the recorder now writes the acad process id in its `WitnessLoaded` line; `Get-WitnessAlreadyLoaded` refuses with "already loaded in this AutoCAD" when a session file names a running acad.exe and was created after that process started (so a reused id does not count). Checked before AutoCAD is touched.
- **Files:** copy `_ACAD_DRIVER\acad_driver_witness.ps1`; patch `PATCH_witness_load_2026-10-10.diff` (regenerated, 254 lines); README section "Witness load" rewritten.
- **Pin now:** `AD8A22D32B3A9E25321B5F3FD8B19AB0F9FD60CC067D3E90B2CA22977B43ED25` = the DLL built from PR #977 head 42b02c79. Staged in `C:\ce_rc_scratch\witness_bin` with a matching `.sha256`; `witness check` reads it as ok_to_load. Any rebuild means a one-line reviewed edit of the constant (that is the point).
- **Unknown, for the pilot:** whether AutoCAD can open the DLL for its own load while the driver holds it with share = Read. A normal read-only open works in the test; AutoCAD's load mode is unverified. The pilot asks.

## B. #977 witness recorder: DONE (branch `claude/tooling01-witness-recorder`, head 42b02c79, PR comment follows)

1. **MEDIUM, no session fallbacks:** lock and system-variable lines now go ONLY to the active recorded drawing's own log; no `?? _session`. DocumentSkipped writes no file name.
2. **MEDIUM, cut-short U:** the reader exits 2 ("the log ends after a U with no REDO following it") when a wait is still open at the end; a real failure earlier still wins (exit 1, noting the cut-short walk). RED fixtures `u_no_redo_at_end`, `u_only`, `fail_then_u_no_redo` were written first (2 of 3 failed), then the reader fixed.
3. **LOW, line cap:** each log holds at most 200,000 lines, then one `LogCapReached` line. Behaviour test by reflection on the real DLL (`tests\Test-WitnessLogClass.ps1`): a cap of 5 gives 5 lines plus the cap line. (This test was written after the code, not strictly red first.)
4. **LOW, re-check after SAVEAS:** the test-copy rule is judged again at every command start and end; a drawing moved out of a test folder writes one `RecordingStopped` line (no name) and is detached. The rule itself is tested on the DLL (SAVEAS to a project folder = not recorded). The wiring (that the handler calls it) is source-checked only; it cannot be run without AutoCAD.
- **Tests:** reader 27 of 27 (was 19); log class 11 of 11. DLL rebuilt (0 warnings, 0 errors).
- **Pilot note taken:** a lock line with no command name between U and REDO fails the walk even when the driver's own COM calls caused it; the calibration pair shows whether that happens.

## C. #978 what got drawn: DONE (branch `claude/tooling01-what-got-drawn`, head 1d6a05e6)

- `ReflectedStep.Require` (new, `Tests\CE.TestHarness.Runner`) throws a clear message when `AnchorAtTopLeft`, `ExplodeAndPopulate` (and now `LoadBlockDefinition`) is not found; the criteria-table step uses it. 3 tests written first (the project did not compile without the helper = RED), then **18 of 18 pass** in `CE.TestHarness.AssertionTests` (was 15). `CE.TestHarness` builds, 0 errors. The end-to-end TH-01 run is still not done (needs AutoCAD closed to run, and the PC).

## Pilot files updated (`C:\Lisp Files\_ACAD_DRIVER\journeys\witness_pilot.json` and `.md`)

- Driver note now says: use the copy only after Opus confirms the fixes; the pin is a driver constant; `witness load` works once per AutoCAD session (quit to run again); reader exit code 2 is a finding; a new question about the DLL hold. The reader is now a stable copy in `C:\ce_rc_scratch\witness_reader` (so the pilot does not depend on which branch a worktree is on). `journey validate` accepts the file.
- **Ready to launch once the desk has Opus confirm the driver fixes.** Nothing else blocks it except a free PC (and Tim's word on the driver copy).

## D. Next tooling item started (research route 2, second scenario): DRAFT PR #980 (stacked on #978)

- **PR:** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/980, branch `claude/tooling01-fall-and-pit-label-checks`, base = #978's branch (retarget to master after #978 merges). Needs Opus review.
- **What:** new test-only step `pitLabel`; scenarios `TH01_CDFALL_Label_Rotation` (four symbols at 0, 90, 180, 270 degrees) and `TH01_PIT_Label_Position` (label 1500 mm east and 800 mm north of each pit); new assertions `attributeRotation`, `attributeNearInsert`, `blockNearBlock`. 13 new tests, 31 of 31 pass, written first and failing before. `CE.TestHarness` builds, 0 errors. REGRESSION_LOG entry added.
- **Not run in AutoCAD: SKIPPED.** Unproven: saved label rotation versus what the eye sees on a flipped symbol; the real label-to-symbol distance (5000 mm is a guess); and a **finding**: ACadSharp 3.4.29 reads a left-aligned attribute's first point offset by the insert point (on real test copy DRV1_B1 the alignment point is sane, the first point is not), so the position check uses the alignment point for text that is not left/baseline aligned. A left-aligned FALL attribute may therefore read wrong on the first real run; the failure message says so.
- **Route 3 (window pictures, ribbon):** done in run 1 as #979; nothing further built. The driver `ui ribbon` read still needs Tim's approval and an Opus review (not built).

## Skipped, and needs Tim or Opus (run 2)

1. **Opus:** confirm the driver fixes (patch and copy), #977 at 42b02c79, #978 at 1d6a05e6, #980. Then the desk can launch the pilot.
2. **Tim:** accept `witness load` in the driver at all; read-only ribbon call; approve window candidates; the Autodesk cloud runner and a second PC stay not authorised.
3. **Left in place:** `C:\ce_rc_scratch\witness_bin` (DLL AD8A22D3... plus `.sha256`), `C:\ce_rc_scratch\witness_reader` (stable copy of the two reader scripts), `C:\ce_rc_scratch\golden_proof`. Worktree `C:\ce-tt01` cleaned (git clean -fdXq), on branch `claude/tooling01-fall-and-pit-label-checks`.

RUN 2 ENDED. Reviewed only: not tested in AutoCAD, not installed, not Tim-accepted.
