# FB Team batch 8 report: carpark BUG-1050 to BUG-1054 (Sat 24 Oct 2026, night, Melbourne)

Built and unit-tested only. Nobody has opened any of this in AutoCAD. No bug marked FIXED, nothing closed or deleted.

## ANSWER FIRST

1. **BUG-1050 (last custom label style cannot be deleted):** skipped, already fixed by Codex draft PR #1720 (`cx4/fa01-inspection`, head `10d43278518945d0dad67ffb9afafd224382aa01`, finding RD03-11). Checked the diff: it changes the label style dialog, view model and `LabelStyleService`. I commented on the PR.
2. **BUG-1051 (CDSLAB passes a flat slab in a metre drawing):** FIXED IN DRAFT PR #1753, branch `fb/b8-bug1051-slab-fall-units`, commit `0217714d`, base `claude/rel-20261023m` (head `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`). Codex skipped it because one caller is on its protected list (`LinkService.RepairAudit.Analysis.cs`). That file is not protected for this job, so I fixed all five callers. Tests: 4 new cases fail on the old arithmetic (checked by putting the old line back once) and pass now; Civil net10 full run 19,553 total, 0 failed, 22 skipped (two halves, 10,782 + 8,771); Drainage net48 Release build 0 errors.
3. **BUG-1052 (CDAGI and CDPERIMETER grade in a metre drawing):** skipped, already fixed by Codex draft PR #1716 (`cx4/fa02-units`, head `8b95539a8fc1caaf3e4096073cf6bbc346fae759`, finding RD04-02). Diff touches `AgiCommand.cs` and `AgiCommand.Plan.cs`. I commented on the PR.
4. **BUG-1053 (LandXML cover and invert not converted from mm to m):** skipped, same PR #1716 (RD04-03, `LandXmlParser.cs`). Its report notes a merge order with PR #1708 (keep #1708's horizontal scale and apply its cover rounding after the elevation conversion).
5. **BUG-1054 (open AG or perimeter drain closes itself in a metre drawing):** skipped, same PR #1716 (RD04-04, `AgiCommand.Plan.cs`).
6. **Settings:** no new switch. BUG-1051 is a bug fix with no sensible old behaviour to keep (R-00).
7. **Not tested:** AutoCAD (not started), net8, Manager, Structural, Undo/Redo, save and reopen, Settings pages. Shared, Installer and signing untouched. Stored slab coordinates are untouched.

## BUG-1051: what changed (in AutoCAD terms)

1. **Cause confirmed in code:** `ComputeFallForTriangle` multiplied finished levels by 1000 (to mm) but plan X and Y are in drawing units, so in a metre drawing 1 mm over 10 m read 1:10.
2. **Fix:** the level difference is converted into drawing units using the drawing's INSUNITS, so the slope is physical. Millimetre drawings give the same numbers as before.
3. **Where the drawing's units now reach:** the Slab Fall Design window (creation preview), CDSLAB Apply fall arrows, CDSLABEREGEN, the slab edit window, the slab flow review (already had the units, now uses them for the fall) and the Link audit slab minimum-fall check.
4. **Files:** `SlabService.cs`, `SlabFallRegenerationPlan.cs`, `SlabFlow.cs`, `SlabCommand.cs`, `SlabViewModel.cs`, `SlabEditViewModel.cs`, `LinkService.RepairAudit.Analysis.cs`, the new cases in `SlabServiceTests.cs`, and the top entry in `REGRESSION_LOG.md`.

## Real-AutoCAD check for BUG-1051 (steps for Tim or the Codex lane)

1. Make two copies of a drawing: one set to metres (INSUNITS 6) with points A 0,0 / B 10,0 / C 0,10 at FSL 10.001 / 10.000 / 10.001; one set to millimetres (INSUNITS 4) with every X and Y times 1000. Use a registered concrete slab.
2. Type CDSLAB and enter the three points. In the Slab Fall Design window the metre copy must warn the triangle is flatter than 1:100, not say all triangles achieve it.
3. Type CDSLABEREGEN, pick the boundary, read the fall arrow grade: 1:10000 in both copies.
4. Press U once (arrows go), then REDO (they come back).
5. Open the Link audit on the metre copy: the slab must be flagged as below minimum fall.

## Evidence and hygiene

1. **Clock:** started 00:43 AEST Sat 24 Oct. C: free space 20 GB before every build (limit 12 GB).
2. **Builds:** every command with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the refs from the C62 assembly report, foreground. Placeholder 0-byte `CE_TRANSFORM_2027.arx` in the private worktree only. Fresh log folder per run.
3. **Duplicate checks:** `gh pr list --state all --search` on each bug number and its key words, `git ls-remote origin cx4/*`, and the FA01 and FA02 reports. Also commented on #1716 and #1720.
4. **Worktree:** `C:\ce-fx\b8-1051`, removed at the end. Branch kept.
5. **Leak scan:** push of the code branch passed.
