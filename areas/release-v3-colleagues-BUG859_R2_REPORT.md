# BUG-859 round 2: the double-click finds nothing picked (Thu 22 Oct 2026, about 22:10 Melbourne)

## ANSWER FIRST

1. **Cause:** AutoCAD's own double-click on a block with an attribute starts the attribute editor with the block handed over inside the command. The "already selected" set CE reads at that moment is empty (log: `nothing picked for EATTEDIT (status "Error", count 0)`). The gate (#1520) was fine; there was simply nothing to read.
2. **Chosen method:** keep where the double-click was (the code already noted its time) and, only when the selected set is empty, the command is the attribute editor and the double-click note is fresh, find the single block whose outline holds that position. A pure function decides (`DoubleClickHitTest`), tested. Zero, several, Xref/overlay, or any failure leaves AutoCAD's editor exactly as before.
3. **Why this one:** the BEDIT route works because AutoCAD fills the selected set for a block-editor double-click, so CE reads it and puts the same pick back. For the attribute editor the set is empty, so there is nothing to read or put back. Option (b), cancelling the command and switching pick-first handling on, would change AutoCAD's behaviour for every command, so it was rejected. Option (a) is read-only and local.
4. **PR:** #1522 (draft) against `claude/rel-20261022m`. **Head:** `8799d200` on `b04/bug-859-r2-pick-at-doubleclick`, off `9daa061d` (confirmed with `git ls-remote`: `claude/rel-20261022m` contains it).
5. **Tests:** new `Bug859Round2HitTestTests` (13 tests: in/out of the outline, pick box, several candidates, pit vs source, Xref, both readings of the position, the log wording, order-of-checks pin, read-only pin). Civil net10 full: **19,107 total, 19,087 passed, 19 skipped, 1 failed**; the one red is the known `BackTest_GlenEira24115_Computed_WithinTolerance` (34.6 percent vs 30 allowed; the same red as in the earlier reports). net48 build of the Civil plugin: 0 errors. Not run: Structural, Manager, Installer tests, AutoCAD.
6. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. BUG-859 is NOT fixed.
7. **What the real-AutoCAD test must check (Codex, on a copy):**
   1. Double-click the placed downpipe circle: CE's Edit source window opens, not the attribute editor.
   2. Read the CE log: it must show `double-click position X,Y; as a drawing point N block(s), as a screen position M block(s)` and `double-click hit-test: 1 block(s) under the pointer; source tag = DP1`. If it says 0 or 2, the line says why.
   3. Double-click a pit label and a plain attributed block: AutoCAD's own editor opens, and nothing is left selected afterwards.
   4. Typed EATTEDIT, the ribbon button, Ctrl+1: unchanged (log says no double-click had been noted).
   5. Source switch OFF: AutoCAD's editor untouched. Downpipe on a locked layer or in an Xref: no change, plain refusal as before.

## What I read (not guessed)

1. **The noting code:** `Modules/Drainage/Services/CompoundEditModeService.cs`, `OnBeginDoubleClick` stored only the time. The hook `TryRedirectToCdEdit` read `ed.SelectImplied()` and left at "nothing picked".
2. **The position:** the decompiled `BeginDoubleClickEventArgs` (C:\Tools\AcadDecomp, 2024/2026/2027) has `Location` as a `Point3d`. The ObjectARX help for `AcEditorReactor::beginDoubleClick` says "Passed in point clicked on (in WCS)". The .NET help adds nothing. Other reports say a screen pixel position. **Not proven on this machine**, so both readings are tried (`Editor.PointToWorld(Point)` exists in the decompile for the pixel reading) and a result is used only when they do not contradict.
3. **No Editor selection used:** the decompiled/ARX help does not say whether `SelectCrossingWindow` corners are in the current UCS or WCS, and a hidden or frozen-layer block must not count. So the hit-test reads the current space's block references (read only, outline in WCS), skips off/frozen layers, and decides by position.
4. **Guard order kept:** switch guard, then the double-click recency (typed/ribbon/Ctrl+1 return before anything is read), then the BUG-043 guard, then the implied-selection read, then the hit-test only if that read is empty, then the existing owner resolution (tagged source only with the source switch; pit label rules unchanged), then CDEDIT and the existing protections (locked layer, Xref/overlay, locked label in CDTAG's `TryCheckSourceProtection`). A source-pin test freezes that order.
5. **Pick put back:** a block found by position is never added to the pick set, so there is nothing to restore; AutoCAD's own command still receives its block inside the command.

## Housekeeping inside the PR

1. `RedoSafeReviewedHooks.baseline.txt`: the Edit Pipe starter's compiler name moved from `d__38` to `d__40` (a method was added above it). Same hook, same reach.
2. `PitLabelDoubleClickTests` BUG-430 pin: its read window widened from 700 to 2500 characters; the "nothing picked" log line is still required.
3. `REGRESSION_LOG.md` entry added at the top.

## Honest limits

1. The button is not distinguished (left vs right): `BeginDoubleClick` carries no button, and the recency window plus the EATTEDIT command start already gate it.
2. Several blocks on top of each other (a pit label over a pit) are treated as ambiguous and left to AutoCAD, because CE cannot know which one AutoCAD picked.
3. The scan is linear in the blocks of the current space; it runs only on a double-click with an empty pick set. Not timed on a large drawing.
4. Build setup: private worktree `C:\ce-fx\r2` (to be removed), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD refs from the C-57 assembly report, AutoCAD 2027 on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, own TEMP. Nothing installed, no settings, bundle or ProgramData touched, no AutoCAD or accoreconsole started.
