# Fix wave 2, batch 1 of 5: ledger top-25 fixes 1 to 5 (23 Oct 2026, Team, Sonnet)

**Written:** Fri 23 Oct 2026, 05:15 to 06:22 Melbourne time (free window). Source: `areas/FINDINGS_LEDGER_22OCT.md`, "Top 25 NEW fixes", items 1 to 5.
**Four words:** all five are **built and unit-tested**. None is installed. Nobody has opened any of them in AutoCAD. No bug is marked FIXED; every carpark entry stays OPEN.

## ANSWER FIRST

All five fixes were verified in the code first, all five were real, and all five are now draft PRs. None was skipped. No fix needed Tim's word to proceed, but two have a part left open for him (see 1 and 2 below).

1. **Fix 1: BUG-966 (F-156), CDSPOON rolled every spoon back.** PR **#1552**, head `04fae248061cb59f4adf1cb0fb791763c71b3383`, branch `fw2/bug-966-cdspoon-bylayer-readback`, base `claude/rel-20261022m`. Tests: 2 new (1 red before). Civil net10 total **19,156** run, 19,136 passed, 19 skipped, 1 failed (the known `BackTest_GlenEira24115_Computed_WithinTolerance`). net48 0 errors. In AutoCAD terms: the spoon is drawn ByLayer but CE's own check afterwards wanted the layer's old colour number, so it could never pass; the check now accepts ByLayer.
2. **Fix 2: BUG-967 (F-157), Blue Factor garden and lawn counted as roof and paved.** PR **#1553**, head `39ca847c85cefa0df4381d8a06e15c1aec249e08`, branch `fw2/bug-967-bluefactor-garden-lawn`, base `claude/rel-20261022m`. Tests: 2 new (both red before). Civil net10 total **19,156**, 19,136 passed, 1 failed (the same known one). The 1000 m2 example now offers 500 m2 roof and paved, with a note. **Left for Tim:** how to treat catchments marked "Other". They are counted as roof and paved exactly as before and a note says so (recommendation: keep that until he decides, it errs towards more detention). Not guessed.
3. **Fix 3: BUG-964 (F-153), network redesign stored each pit at the far end of its outgoing pipe.** PR **#1555**, head `ed39ede2ef0a26c5a036fbf081198ee64ac12925`, branch `fw2/bug-964-redesign-pit-level`, **base `cx/eng-pipe-material-c60` (stacked on #1537)**. Tests: 1 new (red before); 4 design pictures and 1 fixed-level solver test updated, differences read (only inverts and depths move). Civil net10 total **19,178**, 19,147 passed, **12 failed, all 12 already failing on #1537's own branch** (compared by name against a run with my change stashed: settings-fingerprint and window-binding tests from #1537's new switch, plus the known BackTest); no new failure. net48 0 errors. In AutoCAD terms: pit B now reads where the pipe leaving it starts (10.200) and the pipe arriving ends 30 mm above that (10.230); before, it dropped 170 mm into the pit.
4. **Fix 4: BUG-970 (F-160), CDTWL merged two schedule sets that both use P1-P2.** PR **#1556**, head `2fb1ff7c78aa9c58387491feeca1ab867eff0ee0`, branch `fw2/bug-970-cdtwl-same-pit-numbers`, **base `cx/eng-twl-units-c60` (stacked on #1538)**. Tests: 5 new (they do not compile before the change; one records the old two-pipe result). Civil net10 total **19,177**, 19,157 passed, 1 failed (the known BackTest). net48 0 errors. In AutoCAD terms: only when the same detention pit number exists in more than one set, CDTWL lists "1 = pit P2 in schedule set A / 2 = ... B", asks for the row number, never guesses a typed "P2", and counts only that set's pipes and pits.
5. **Fix 5: BUG-876 (F-009), Replace erased the old imported pit before checking the new one could be drawn.** PR **#1557**, head `73bc82645778be50dbdc068119da93885f5a944c`, branch `fw2/bug-876-replace-keeps-old-pit`, base `claude/rel-20261022m`. Tests: 5 new (they do not compile before the change). Civil net10 total **19,159**, 19,139 passed, 1 failed (the known BackTest). net48 0 errors. In AutoCAD terms: if a new pit needs a locked layer (new cover text on 25TEXT), the earlier pit with that number stays whole and the report says "did not draw 1 pit and left 1 earlier pit in place". Nothing is unlocked.

**Skipped:** none.

## What each fix does NOT cover (so nobody assumes)

1. **BUG-964:** CDRUNSOLVE and auto-design use the same Design service and will change the same way; not traced or tested separately. Merge #1537 first, then retarget #1555.
2. **BUG-970:** the default volume CDCALC offers for an outlet is still found by pit number only (a value the drafter confirms). Merge #1538 first, then retarget #1556.
3. **BUG-876:** imported PIPES have the same erase-then-skip order problem (a new pipe on a locked layer still erases the old one first). Not changed; needs its own look.
4. **BUG-967:** "Other" is Tim's call (above).

## Settings switches (R-00, R-27)

None added. All five repair a wrong result or a check that could never pass. BUG-970's new question appears only where the old silent answer was wrong. Nothing new that changes what a drafter sees on a normal drawing.

## Evidence and hygiene

1. **Environment:** private worktrees `C:\ce-fx\f966`, `f967`, `f964`, `f970`, `f876`, one per fix, all removed at the end (branches kept on origin). Every dotnet command ran in the foreground with `-c Release -p:SkipDevBundle=true -nr:false --disable-build-servers` and the C-57 references (`_AcadRef48`, `_AcadRefNet8`, `_AcadRefNet10`, `_AcadRef100`, `_AcadRef80`), AutoCAD 2027 folder on PATH, a zero-byte `CE_TRANSFORM_2027.arx` placeholder (ignored, never installable), per-run TEMP and `CE_LOG_DIR_OVERRIDE` under `C:\Temp\fw2-*`. The exclusive build lock `C:\CE_PLAN\desk_jobs\build.lock` was held only while each command ran. The runner script was a throwaway in the session scratchpad, not a repo script.
2. **Red before green:** BUG-966 (1 of 2 failed on the old check), BUG-967 (2 of 2 failed on the old reader), BUG-964 (the new test failed on the old levels). BUG-970 and BUG-876 add new members, so their tests do not compile on the base (a red by construction); BUG-970's third test also records the old result (two pipes counted for two systems).
3. **Test totals** are in the thousands (19,156 to 19,178), so the wrong-ref-name trap is not in play.
4. **Not run:** anything in AutoCAD or accoreconsole; net8.0-windows; Structural; Manager; Installer.Tests; the net48 test run (net48 was built only).
5. **Settings files:** not touched by this job; no hashes taken, so I cannot say they were unchanged. (The C-57 report already noted `CD_Settings.json` swapping during other runs.)
6. **No PR closed, no branch deleted, nothing installed or deployed, no bug marked FIXED, `DESK_LOG.md` and `BUG_CARPARK.md` not edited.** No open PR existed for BUG-966, 967, 964, 970 or 876 (the search hits #474 and #637 are different bugs).
7. **Every REGRESSION_LOG.md entry** is at the top of the file, written to the branch; no other entry touched.
8. **Mistakes of mine, plainly:** the first two test runs wasted about 2 minutes (a bad path from the shell; a compile slip in BUG-966's first helper); two of my scripted edits had their backslash-n collapsed by the shell and were repaired before any commit. No effect on what was pushed.

## Tim's AutoCAD checklist (batched; free window, copies only)

1. **CDSPOON (BUG-966):** fresh mm drawing, CDSPOON, pick 10000,10000 / 12000,10000 / 12000,11000 / 10000,11000, Close: boundary and SOLID hatch stay, both ByLayer; U removes both.
2. **CDDESIGN (BUG-967):** a Blue Factor report listing garden and lawn, answer Yes to the folder search: roof and paved excludes garden and lawn.
3. **CDHUB Network redesign (BUG-964):** a three-pit chain, outlet 10.000: pit B reads the start of B to C and the pipe into B arrives 30 mm above it.
4. **CDTWL (BUG-970):** two schedule sets each P1 to P2, P2 detention: choose 1 then 2, each counts one pipe with its own length; a single-set drawing asks nothing new.
5. **Import Replace (BUG-876):** lock 25TEXT, change a pit's cover level in the file, import with Replace: that pit stays and the report names 25TEXT.
