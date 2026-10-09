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

(items 4 and 5 follow below when done)
