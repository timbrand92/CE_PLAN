# FB Team batch 7: carpark BUG-1045 to BUG-1049 (24 Oct 2026, Melbourne, Saturday)

Built and unit-tested only. Nobody has opened any of it in AutoCAD. Nothing installed, nothing deployed, no bug marked FIXED, no PR closed, no branch deleted.

## ANSWER FIRST

1. **BUG-1045 (read-only drawing loses the inspection tools): partly fixed.** Structural half: draft PR #1749, head `57c1b06020ab028fd42d2631a758ad7ca4e9d76f`, base `claude/rel-20261023s`. CE_INSPECT now runs on a read-only drawing. Tests: Structural net10 Commands/Core/Models/Rules groups 1,571 of 1,571 pass, Hatch/Settings/DrawingSafety groups 422 of 422, net48 builds 0 errors. Real-AutoCAD check: open a synthetic DWG with Open Read-Only, type CE_INSPECT, pick the line: report appears and the DWG is unchanged. **Skipped:** Civil CDDIAG and CDDASHBOARD (they open the project data, which writes; needs a separate read-only route, an option for Tim is below) and CEEXPORTNOTES (not checked). CDPARTS is covered by Codex PR #1720 (head `10d43278`); I commented there.
2. **BUG-1046 (CDPARTS and CDLABELSTYLE refuse on a layout or in REFEDIT): skipped, already fixed in Codex draft PR #1720** (branch `cx4/fa01-inspection`, head `10d43278518945d0dad67ffb9afafd224382aa01`, base `claude/rel-20261023m`, report `CODEX_FIXAUDIT_FA01_23OCT.md` item 8). Left over after that PR: CDDIAG and CDDASHBOARD in paper space and REFEDIT. I commented on #1720 and did not duplicate.
3. **BUG-1047 (CE Blocks refuses a frozen layer): fixed in draft PR #1738**, head `81d1772c48137ac9e28017655d0f1e313c746558`, base `claude/rel-20261023m`. Manager net10 **939 total, 938 passed, 1 skipped, 0 failed**; Manager net48 builds 0 errors. Real-AutoCAD check: block on layer AUDIT-BLOCKS, freeze (not lock) it, CEBLOCKS, click the block, place at 0,0: a "[CE] The layer is frozen, so the block will be hidden until you thaw it. CE has not thawed it." line, one insert, layer still frozen. Then lock instead: refused as before.
4. **BUG-1048 (Hatch Change refuses every hatch if one has a coloured background): fixed in draft PR #1746**, head `518741ee645e86a5e3a78ca8570ef97d33a3d069`, base `claude/rel-20261023s`. Tests: Structural net10 Commands/Core/Models/Rules groups 1,573 of 1,573 pass, Hatch/Settings/new tests 424 of 424, net48 builds 0 errors. Real-AutoCAD check: two hatches in separate rectangles, H-B with a background colour. CEHATCHCHANGE, select both, Enter, PT slab, Apply preset: H-A changes, a warning names H-B, one U puts H-A back.
5. **BUG-1049 (batch edit: one blank ticked field disables Apply): fixed in draft PR #1743**, head `7afad0d4e54c1fd0905cd5ee938cf792450312af`, base `claude/rel-20261023m`. Civil net10 full run **19,556 total, 19,532 passed, 22 skipped, 2 failed**; net48 builds 0 errors. The 2 failures are `SourceAtomicCoordinatorDependencyTests.FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision` and `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`, compiled-shape tests in files this change does not touch. I did **not** run the base to confirm they fail there too (the C-62 assembly report had a clean net10 run of 19,545 with 0 failed, so say if you want the base run by name). Real-AutoCAD check: two 300 mm pipes with different materials, CDEDIT, tick Diameter 375, tick Material and leave it empty, Apply: both 375, materials unchanged, one U restores both.

## Switches (all ship ON because each guards a bug fix; none has a Settings page row)

1. **BUG-1047:** `FrozenLayerWarnsAndPlaces` in `ce-blocks-settings.xml` (Manager CE Blocks file). OFF = old refusal.
2. **BUG-1048:** `Options.HatchChangeSkipsRefusedAndChangesTheRest` (Structural), label line added to the Settings words list. OFF = old whole-selection refusal.
3. **BUG-1049:** `linking.batchBlankFieldIsLeftOut` (Civil `LinkingSettings`). OFF = old grey Apply.
4. **BUG-1045:** `Options.InspectRunsOnReadOnlyDrawing` (Structural), label line added. OFF = old refusal.

## What did not get done, and why

1. **BUG-1045 Civil half (CDDIAG, CDDASHBOARD): needs a design word.** They initialise the project data (which writes) and the dashboard calls the protected link service (Codex FA01 item 7 says the same). Option A, recommended: add a detached read-only route that reads the drawing without initialising project data, and run these two on it. Option B: leave them refusing on read-only and say in the message that the drawing can be opened as a copy. A is better for a drafter asked to inspect a read-only drawing; B is two lines of wording only. Needs Tim's word before code.
2. **BUG-1045 CEEXPORTNOTES:** I did not check whether `NoteStorage.GetNotes` writes a record into the drawing. Not changed.
3. **BUG-1046 leftover (CDDIAG, CDDASHBOARD on a layout / REFEDIT):** same route as 1 above; not done.
4. **No Settings page rows** for any of the four switches (a layout decision, not guessed).

## What I did NOT test

1. **Anything in AutoCAD, accoreconsole or any picture of a window.** The CDEDIT batch window was not rendered, and the pit batch window was not looked at (it shares the same view model and sets the same switch).
2. **Structural Services group and the Sbeam tests.** A full Structural net10 run did not finish in 30 minutes (killed); a run without Sbeam also did not finish. I ran the Commands, Core, Models and Rules groups plus the Hatch, Settings and DrawingSafety filters instead. Structural therefore has no full-suite total in this batch.
3. **Manager net48 tests** (the net48 test lane does not load); only the net48 compile was checked for Manager, Civil and Structural.
4. **The two Civil failures above against the base by name.**
5. **Real file-writing of CE_INSPECT** next to a read-only drawing: if that folder is also read-only the report write will fail with CE's normal error line; I did not add a fallback folder.

## Duplicates and checks

1. `gh pr list --search` for each bug id and key words: BUG-1045, BUG-1046, BUG-1047, BUG-1048, BUG-1049 each had no real fix (the only hits were unrelated PRs: #637, #764, #676, #659, #508). CEHATCHCHANGE hits (#1498, #1382, #1265, #1547, #138) are other bugs.
2. `git ls-remote origin 'cx4/*'` showed `cx4/fa01-inspection` to `cx4/fa07-native-protection`. `CODEX_FIXAUDIT_FA01_23OCT.md` is the only report that names RD03-06 to RD03-10: it fixed RD03-06 (office editors) and RD03-07 and skipped RD03-08, RD03-09 and RD03-10 as protected.
3. Bases: `origin/claude/rel-20261023m` was `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil 3.0.72 / Manager 1.1.72); `origin/claude/rel-20261023s` was `e6d597c0fbc25e78118760887a70810e0890c9a9` (Structural 1.0.122, S-42).
4. CE_SHARED not changed in any PR. Installer, signing and Tim's settings files not touched. Free space on C: stayed between 18 and 21 GB (above the 12 GB stop line) before every build.
5. One older Structural source-shape test (`HatchUpgradeContractTests.ExistingHatchChangeAndAudit_...`) was changed on PR #1746 and says so in the REGRESSION_LOG entry.
6. Each REGRESSION_LOG.md entry is at the top of its branch. Each commit names its bug in full. Private worktrees `C:\ce-fx\f1045`, `f1047`, `f1048`, `f1049` removed; branches left in place.

## Tim's checklist (all four together, after a deploy)

1. Frozen layer CE Blocks: warning, one insert, layer still frozen; locked still refuses.
2. CDEDIT two pipes: Diameter 375 plus blank Material: Apply works, materials kept.
3. CEHATCHCHANGE with one background-coloured hatch: the other changes, the awkward one is named, one U undoes.
4. CE_INSPECT on a read-only drawing: report appears, DWG unchanged.
