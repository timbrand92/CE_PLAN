# BUG-1054 draft report (5 Nov 2026)

FOR TIM
1. **Own mistakes first:** my first command batch failed to parse and did nothing; I redid it. I could not take a before/after list of the real CE folders file by file, only a checksum, and it changed.
2. **PR:** #2037 (DRAFT), "B-222 BUG-1054 CDAGI tolerance in drawing units (DRAFT)", one commit on the rel-20261112a line.
3. **What changes in AutoCAD:** in a metre drawing, CDAGI/CDPERIMETER finished 0.5 m short of the start now stay open with four vertices. A pick within 1 mm of the start still closes. A millimetre drawing behaves as before.
4. **Switch:** Settings value surface.agiSnapClosureUsesDrawingUnits, ON by default; OFF gives the old behaviour exactly. Unitless drawings keep the old reading (no block).
5. **Built:** Civil net48 0 errors; net10 builds.
6. **Tested:** 57 of 57 AGI-related unit tests pass on net10 (metre, millimetre, your four-pick case, switch OFF, settings reads). Real-folder guard was inconclusive because an AutoCAD is running; its checksum of the real CE folders changed during my run, consistent with that AutoCAD's own usage logs (outbox/usage files written every few minutes). My run used isolated APPDATA/LOCALAPPDATA.
7. **NOT proven:** nothing run in AutoCAD; the copy paths in LinkService.SurfaceDrainTags.cs (copied-drain remarks/tag) still use the old raw tolerance.
8. **BUG-1052:** a separate local draft exists at C:\CE_WORK\build\w1052 (commit 6b26e852, based on C-78, not pushed, no PR). Mine does not duplicate it; both add a switch at the end of the same Surface settings class and edit AgiCommand.cs, so expect a small merge conflict.
