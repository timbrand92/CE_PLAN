# Test check: PR #2033 geometry failures (5 Nov 2026)

## FOR TIM
1. **Same failures on base: YES.** All 12 geometry tests fail the same way on origin/claude/rel-20261026s (8de95c34) and on #2033's head (433bfb32). #2033 did not cause them.
2. **Failing on both (12):** PickInAMovedUcs_IsCarriedToWorld, PickInARotatedUcs_FollowsTheRotation, WorldUcs_ChangesNothing, AnOverLongBrace_IsDrawnAtTheLengthPicked_NotCutToTheLimit, AUnchangedBrace_HasTheSameLengthEndPointAndRotationAsBefore (2 cases), ProductionPlannerAndMatrix_ExecuteEveryApprovedDetailedFamily, ProductionSectionMatrix_MapsPlannerAnchorToExactPickedPoint (4 cases), CompiledProductionRoute_BindsRealEntryNativeProtectionDirectStorageAndC0.
3. **My own mistakes:** the report gave no test names, so I picked tests by keyword (Ucs, Brace, SectionMatrix, ProductionPlanner, CompiledProductionRoute). My base run hit the 10-minute cap and was cut short, so the base list comes from the failures printed before the cut, not a clean summary. PR run: 12 failed, 0 passed of exactly those 12.
4. **Not run:** net8/net10 targets (net48 only, AutoCAD 2024 reference DLLs); the rest of the suite; I did not find WHY they fail (they fail in 1 ms, which looks like an environment or reference problem, not geometry).
5. Isolation: APPDATA/LOCALAPPDATA under C:\CE_WORK\scratch\sbeamlogtest. No deploy, no repo change, worktrees removed.
