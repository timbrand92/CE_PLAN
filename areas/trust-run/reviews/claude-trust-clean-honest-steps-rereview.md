# Re-review: PR 2074 `claude/trust-clean-honest-steps` (BUG-1439, 1442, 1447: CLEAN and FASTSAVE skip locked objects and say so)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:36 PC clock. **Head reviewed:** `a38626fa` (pushed 07:21), since `42610102` (reviewed FIX FIRST at 06:19, `reviews\claude-trust-clean-honest-steps.md`). One commit. Base `8de95c34`. Read only.

---

# FOR TIM

1. **Fixed:** CLEAN and FASTSAVE no longer refuse on a layout tab. Type CLEAN wherever you are and it cleans and saves, as the installed build does today.
2. **Kept:** they still stop first, with one plain line and nothing changed, on a read-only drawing and while a block or Xref is open for in-place editing (REFEDIT).
3. **Your question stays listed:** whether CLEAN should run from a layout tab at all is yours; the default is "yes, as today".

**Verdict: GO** for the robot on copies (the earlier small items still worth doing, below).

---

# Findings (file and line at `a38626fa`)

1. **Layout-tab stop gone from both: FIXED.** `Services/CleanPipelineService.cs:72-79` (stops at 76 and 78): CLEAN and FASTSAVE share this one `Run` (the command name is chosen by `lightweight`), which now calls `DrawingSafetyService.CommandPreFlight` (document, drawing and read-only only; `DrawingSafetyService.cs:18-44`) and then the new `StopForRefEditOnly`. `CommandPreFlightModelSpace` (which also stops on a layout tab) is no longer called from `Run`.
2. **REFEDIT stop kept, and it cannot stop on a layout tab.** `StopForRefEditOnly` (`DrawingSafetyService.cs:109-132`) reads only `REFEDITNAME` and passes viewport 2 (Model) and "readable" to the shared `ModelSpaceWriteGuard.StopLine` (`Core/Symbols/ModelSpaceWriteGuard.cs`), so only the REFEDIT line or "could not check" can come back. An unreadable REFEDIT stops CLEAN (changes nothing it cannot check). Nothing is unlocked or closed for the drafter.
3. **Read-only stop kept.** Its line is the older "[CE_STRUC] CLEAN: the drawing is read-only. Save a copy you can edit first." Plain; it does not use the "cleaned and saved nothing" ending the REFEDIT line uses. Cosmetic.
4. **Tests.** `Clean_StopsFirstOnAReadOnlyDrawingOrRefEdit_BeforeAnythingElse` (order of the two stops before the recovery check and the purge) and `Clean_DoesNotStopOnALayoutTab_...` (no layout helper in `Run`, no `CVPORT` anywhere in the file or in the REFEDIT helper): text searches, enough for an order and absence pin.
5. **Still worth doing from the first review (small):** the copy line prints after every CLEAN; once PR 2048's timed copies exist, "CE kept no copy" needs re-checking against them.

# What I did not check

1. No build or test run.
2. CLEAN run from a layout tab on the branch (same as the installed build by reading, robot to see).
