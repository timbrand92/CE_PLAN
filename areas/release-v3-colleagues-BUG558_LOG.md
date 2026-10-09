# CE_ACAD / release-v3-colleagues / build / 05 (bug558) - log

## Run 1 (Sat 10 Oct 2026, from about 07:50 PC clock, Sonnet, headless)

1. **Not pushed yet.** Item 1 is coded and compiles (net48 and net8); the unit tests are waiting for AutoCAD to be closed (acad.exe is open on the PC; rule: unit tests only when it is not). I will say "ITEM 1 PUSHED" at the top of this file the moment it is.
2. **Base:** `origin/claude/rel-20261009r` (Civil 3.0.45, contains the installed rel-o 3.0.44). Worktree `C:\ce-b558`.
3. **Lines checked against the decompile note:** `RedoWindowGuard.cs` (per drawing), `LinkService.Reactors.cs` Idle handler and `TryRebuildCachesDeferred`, `LinkService.Cache.cs` `RebuildRuntimeCaches(lightReads)`, QA `:423`, `BlockService.GetEffectiveBlockName`, Manager `CeSuiteManagerMenuService`.
4. **Note for Opus review:** the pinned test `LinkServiceIdleCacheRefreshContractTests` matches the literal text `RebuildRuntimeCaches(db, state, trigger, fallbackReason);` and `TryRebuildRuntimeCachesIncremental(db, state, dirtyHandles, trigger)`, so the light-read switch is a private static flag (`_lightIdleReads`, set in `TryRebuildCachesDeferred` with try/finally) instead of a new argument.
5. **Environment:** the net10 build in a new worktree needs `CE_TRANSFORM_2027.arx`; I copied the built file from another worktree's ignored `bin` folder into `C:\ce-b558\Modules\Shared.Transform.Native2027\bin\x64\Release` (not tracked).
