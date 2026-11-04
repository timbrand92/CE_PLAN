# BUGFIX w1083 report, 5 Nov 2026 (BUG-1083, job B-211)

## FOR TIM
1. **PR:** draft #2026 against claude/rel-20261112a, title starts B-211.
2. **In AutoCAD:** CDWT, Adopt, click an Xref (attached or overlaid): CE now says "That is an Xref ... nothing was changed" and the pick is refused. The same check runs again at Apply, before any layer, tag or record change. Ordinary blocks adopt as before.
3. **Switch:** Settings, waterTank.rejectXrefAsAdoptedTank, default on. Off gives the old behaviour exactly.
4. **Built:** all three targets compile (net48, net8, net10). **Tested:** 11 of 11 new unit tests pass on net10 (rule truth table, switch default through both start-up reads, source guards that the check sits before any write).
5. **NOT proven:** nothing was run in AutoCAD; BUG-1083 stays OPEN. Robot case to add: N-style "CDWT Adopt Xref": attach AUDIT-REFERENCE.dwg on AUDIT-XREF, type CDWT, Adopt, pick the rectangle edge; checks the command line holds the Xref message and the layer and tag count are unchanged; control = switch off, the old WT1 result returns.
6. **My own mistakes:** a bare python call hung for two minutes (stopped, no effect); the first test run failed because the empty CE_TRANSFORM_2027.arx placeholder was missing (created, per the brief).
7. **Disk:** C: had about 60 GB free before the build.

## Technical
- Not already fixed on the base: Apply only checked the current space for Xref, never the picked block. Files: Commands/WaterTankCommand.cs (IsXrefReference, pick), Commands/WaterTankCommand.Apply.cs (Revalidate), Rules/XrefAdoptRule.cs, Models/UserSettings.cs, Services/B211XrefAdoptTests.cs, REGRESSION_LOG.md. CE_SHARED untouched.
- Test run isolation: CE_LOG_DIR_OVERRIDE, TEMP, TMP under C:\CE_WORK\scratch\w1083. Only the new fixture ran (filter, one project, net10).
- Real-folder listings (before 37017 files, after 37018, CSVs in C:\CE_WORK\scratch\w1083\before.csv and after.csv): the changed files are live logs and sessions of an AutoCAD that was running on this PC (CE_CVL_SUITE and CE_STRUC_SUITE logs, CE_Admin sessions, one usage outbox file), not written by this run. The test's real-folder guard said Inconclusive for that reason (0 differences seen).
