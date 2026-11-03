STAGE A RESULT: MERGE CLEAN

Payload 117 stage A (Sonnet 5.5, Tue 3 Nov 2026, 00:56 to 01:16 Melbourne). Local only: nothing pushed, no bundle built, nothing installed.

1. **Heads checked (git ls-remote origin):** rel-20261110a = `d4ce878ebfff53ec58e4a330fd0079ee4b999c67` (as required); rel-20261108a = `cf059dcfd3dcd4bc325423f7d7110f0da924f6cc` (as required). C79b2 finalizer report line 7 reads "1. **GO at `d4ce878ebfff53ec58e4a330fd0079ee4b999c67`.**", line 8 "CLASS: AREA".
2. **Head before the merge:** `d4ce878ebfff53ec58e4a330fd0079ee4b999c67`.
3. **Local merge commit:** `02c1a090700255c989ca7e9fc8f668c4e8a1e1a3` on local branch `p117-b2` (parents d4ce878e and cf059dcf). Message: "Merge C-79b1 version commit (Civil 3.0.90) into C-79b2 train" plus the Co-Authored-By line. Strategy: ort, no conflict.
4. **Proof it is one commit:** `git log d4ce878e..cf059dcf --oneline` gives exactly 1 line: `cf059dcf Version: Civil 3.0.90 (C-79b1)`. bab2dbf8 is an ancestor of d4ce878e (`merge-base --is-ancestor` exit 0).
5. **`git diff d4ce878e HEAD --stat`:**
   ```
    Installer/PackageContents.xml        | 2 +-
    Modules/Drainage/CE_CVL_SUITE.csproj | 2 +-
    2 files changed, 2 insertions(+), 2 deletions(-)
   ```
   The changed lines are only AppVersion="3.0.89" to "3.0.90" and `<Version>3.0.89</Version>` to `<Version>3.0.90</Version>`.
6. **Trap results:**
   1. **(a) UserSettings.cs BOM:** first three bytes EF BB BF in d4ce878e, in cf059dcf and in the merged worktree. UserSettings.cs is identical to d4ce878e (empty diff). The two diff files have no BOM in either parent or in the merge (3C3F78 and 3C5072), so nothing changed there.
   2. **(b) Summary openers / change log:** the whole diff is the two version lines, so nothing dropped or doubled.
   3. **(c) Versions:** `3\.0\.89` matches nothing in *.cs *.csproj *.xml *.props *.targets *.json *.xaml *.ps1 (no fixture or history text carries it). `3\.0\.90` matches exactly the two lines above. `1\.1\.89` has the same 2 matches in d4ce878e and HEAD (Modules\Manager\CE_SUITE_MANAGER.csproj line 12 and Modules\Manager\Installer\PackageContents.xml line 3): Manager unchanged.
7. **Tests** (net10.0-windows, Drainage test project, Release, run after AutoCAD count reached 0 at 01:13, one class per call; build 0 errors). Total, passed, failed:
   1. C79b2NewSwitchDefaultsTests: 46, 46, 0
   2. C79b2FinalizerGuardsTests: 24, 24, 0
   3. C79b1NewSwitchDefaultsTests: 44, 44, 0
   4. C79b1FinalizerGuardsTests: 23, 23, 0
   5. BundleManifestTests: 14, 14, 0
   6. HelpGuideVersionTests: 2, 2, 0
   7. WhatsNewHeadingVersionTests: 4, 4, 0
   8. WhatsNewVersionGateTests: 15, 15, 0
   9. C60AuditSourcePinGuardTests: 42, 39 passed, 3 skipped, 0 failed
   10. CalculationExportStampAndNumbersTests: 20, 20, 0
   11. PinnedEndMapTests: 4, 4, 0
   12. Bug351bPlanMarkerTests: 20, 20, 0
   13. Every test with Version, Pin or Stamp in its class or method name (one run): 188 total, 185 passed, 3 skipped, 0 failed.
   No pin test names 3.0.89, so there was no expected red.
8. **Not done / not run:**
   1. ZzRealSettingsFileGuard not run (settings_guard.json exists as a file but was not asked for in step 5; the file was absent when I looked at 00:56 and I did not run it).
   2. Manager tests not run (Manager untouched by this merge).
   3. No net48 build (the method does not call for one in this stage).
   4. Nothing opened in AutoCAD. This is built-and-unit-tested at most.
9. **Odd:** the main checkout (`C:\Lisp Files\CE_ACAD_PLUGIN`) shows untracked `.codex/`, `Modules/Structural.Tests/Models/BracingLengthSettingsTests.cs` and `payload114_probe_c78.ps1`. They are not mine (I wrote nothing there); another job's.
10. **Worktree state left for stages B and C:** `C:\CE_WORK\build\wt117` (branch `p117-b2`, HEAD 02c1a090, clean), `subst R:` points at it. Scripts in `C:\CE_WORK\scratch\p117_scripts`, temp in `C:\CE_WORK\scratch\p117_tmp`. A 0-byte `CE_TRANSFORM_2027.arx` placeholder sits in the worktree's gitignored bin folder (it was not copied from the installed bundle). Release test build output is in the worktree.

**Commands to re-create the merge** (run from `C:\Lisp Files\CE_ACAD_PLUGIN`):
```
git fetch origin
git ls-remote origin refs/heads/claude/rel-20261110a refs/heads/claude/rel-20261108a
git worktree add -b p117-b2 C:\CE_WORK\build\wt117 origin/claude/rel-20261110a
subst R: C:\CE_WORK\build\wt117
cd R:\
git log d4ce878ebfff53ec58e4a330fd0079ee4b999c67..cf059dcfd3dcd4bc325423f7d7110f0da924f6cc --oneline
git merge --no-ff -F <file holding the message above> origin/claude/rel-20261108a
git diff d4ce878ebfff53ec58e4a330fd0079ee4b999c67 HEAD --stat
```
(The merge hash will differ on a re-run because of the new commit time.) Scripts: p117_wt.ps1, p117_merge.ps1, p117_traps.ps1, p117_pinbuild.ps1, p117_pinrun.ps1 in the scripts folder above.
