1. **FOR TIM — DONE:** PR #2005, B-186 / BUG-1046 fix-first patch prepared on 5 November 2026, Melbourne time. Not pushed.
2. **Finding:** the fetched PR already had the exact dashboard exclusion requested by the review. This patch strengthens its regression test; the drawing behaviour is unchanged.
3. **Built:** Release net10.0-windows Civil test project, 0 errors / 54 warnings; native prerequisite, 0 errors / 1 warning.
4. **Tested:** focused BUG-1046 fixture 20 passed / 0 failed / 0 skipped. Full Civil project: 21,611 passed / 0 failed; console reports 32 skipped, TRX records 60 NotExecuted. Unexecuted cases are not passes.
5. **NOT proven:** real AutoCAD opening, layout refusal, dashboard zoom, REFEDIT behaviour, visual acceptance, net48 and net8 builds. Not installed or accepted; BUG-1046 stays open.
6. **Decision:** CE 02 or CE 05 decides whether to push. No PR was changed, retargeted, merged or closed.
7. **Files:** `C:\CE_PLAN\areas\PATCH_PR2005_FIXFIRST_03NOV.patch` and this report. Own worktree cleaned and removed after verification; local branch retained.

---

1. **Read and starting point:** read `C:\TimOS\RULES.md`, `ROUTER.md`, CE_PLAN start/map and `PREREVIEW_FIXES_316_323_03NOV.md`, B-186 detail, points 1–6. Fetched origin. PR head was `c27c29961c966925522146b457bbf42ff2297651`, branch `claude/b186-w1046`, base `claude/rel-20261102a`. The review described the older head `abe5d2b9`; commit `9de8882d` had already removed CDDASHBOARD, updated the settings summary/log and moved the dashboard into refused cases. Later `c27c2996` guarded Label Style Apply during REFEDIT; retained unchanged.
2. **Isolation and ancestry:** created `C:\CE_WORK\build\fx2005`, own branch `codex/n3-pr2005-fixfirst`, at the fetched PR tip. It already contains `origin/master` (`650c0c19b4f69b5aebb778fdcc168a6a8269e6ea`); `git merge origin/master` returned “Already up to date”. No rebase or conflict. Own worktree was clean, so no WIP takeover commit was needed. The main checkout's unrelated untracked work was left untouched.
3. **Smallest remaining change:** in `Modules/Drainage.Tests/Services/Bug1046OfficeEditorsOpenAnywhereTests.cs`, moved the existing dashboard case into a dedicated test and added the lower-case, padded command. Each checks ON, explicit OFF and null settings, and pins the dashboard's existing REFEDIT permission. Existing tests still pin the three permitted office commands, old OFF refusals and ON defaults through both settings reads. Added this session's entry at the top of `REGRESSION_LOG.md`, retaining all prior entries. No product code, protected file, Shared/CE_SHARED source, window, alias or theme changed. No new window pictures were needed for this test-only patch; no visual acceptance is claimed.
4. **Build prerequisites and unsuccessful attempts:** the first managed build stopped at MSB3030 because the native `CE_TRANSFORM_2027.arx` was missing from this fresh worktree (1 error, 216 warnings). I first selected Visual Studio 2022 MSBuild; it lacked C++ targets and failed with MSB4019. Visual Studio 18 MSBuild built the existing native project successfully using its documented ProductionIntegration option. No placeholder binary, copied live binary, source workaround or new build script was used. Initial test discovery without AutoCAD dependencies on PATH loaded no tests; this was not counted as success. Adding the AutoCAD 2027 folder to this shell's PATH resolved discovery without launching AutoCAD.
5. **Commands actually used:** working directory `C:\CE_WORK\build\fx2005`. Native prerequisite:

   ```powershell
   & 'C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe' Modules\Shared.Transform.Native2027\CE_TRANSFORM_TRIAL_2027.vcxproj /p:Configuration=Release /p:Platform=x64 /p:ProductionIntegration=true /p:SkipDevBundle=true /nr:false /m:2
   ```

   Civil test project build, with README safety flags and explicit reference paths:

   ```powershell
   dotnet build Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2 '-p:_AcadRef48=C:\TimOS\refs\autocad\autocad-2024-ref' '-p:_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref' '-p:_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027'
   ```

   Test process environment and focused test:

   ```powershell
   $env:PATH = 'C:\Program Files\Autodesk\AutoCAD 2027;' + $env:PATH
   dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Release --no-build --no-restore -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2 --filter FullyQualifiedName~Bug1046OfficeEditorsOpenAnywhereTests --logger 'trx;LogFileName=fx2005-final.trx' --results-directory C:\CE_WORK\codex\fx2005-test-results
   ```

   Full project run used the same command without `--filter`, with `LogFileName=fx2005-project.trx`. No other test project ran. The existing suite settings/log isolation was read before execution.
6. **Counts checked from files:** focused TRX: 20 total, 20 executed, 20 passed, 0 failed, 0 unexecuted. Full-project console: 21,643 total, 21,611 passed, 0 failed, 32 skipped, duration 5 min 36 s. Full-project TRX contains 21,671 result records: 21,611 Passed and 60 NotExecuted. The console and TRX count unexecuted cases differently; both counts are preserved rather than treating any as passes. No failures occurred, so the brief's “more than 11 failures” stop condition was not reached. No historical failure comparison is claimed.
7. **Evidence outside the code worktree:** `C:\CE_WORK\codex\fx2005-build-final.log`, `fx2005-native-build-18.log`, `fx2005-test-final.log`, `fx2005-test-project.log`, and `fx2005-test-results\fx2005-final.trx` / `fx2005-project.trx`. Failed initial build/discovery logs also remain there. These logs were not added to either repository or the patch.
8. **Patch and saved tips:** local commits `bf7f3fac12d6495d810ad7b2d2a1b4c4877ca4be` (test/log) and `f6a7bb4810220a55fe8f0515eb0e2d273e8d60ca` (full TRX count clarification). Final branch tip `f6a7bb4810220a55fe8f0515eb0e2d273e8d60ca`. Patch is a plain binary-capable Git diff from PR tip `c27c2996` to that final tip, affecting only the test and regression log. `git diff --check` passed, and `git apply --reverse --check` verified the saved patch against the completed worktree. Apply it to `c27c2996` with `git apply --check` first; it does not repeat the product fix already in `9de8882d`. Undo: reverse this patch. Nothing pushed.
9. **Still needs real AutoCAD proof:** on a copy, Layout1 → PSPACE → CDPARTS and CDLABELSTYLE should open; CDDASHBOARD should retain the paper-space refusal. During REFEDIT, the office windows should open but Label Style Apply to drawing should refuse. Check ON and OFF using the established settings backup/restore procedure. This session did not perform those steps, inspect dashboard zoom, validate drawing counts/Undo, or establish acceptance.
