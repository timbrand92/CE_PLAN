# BUG-1223 fix report: floor waste at an inspection opening (Wed 28 Oct 2026, about 19:05 to 20:10 Melbourne)

Job: desk plan/03, Team, Opus. Base: C-74 tip `claude/rel-20261026y` @ `94f521cc` (Civil 3.0.84). Branch `fb/bug1223-floor-waste-opening` @ `7e93456c`. **DRAFT PR #1833**, not merged.

## ANSWER FIRST

**FOR TIM**

1. **Read this first: a floor waste is still NOT placed on an inspection opening.** I looked at what CE was doing: each of those four openings is itself a CE source, and it owns the pipe ends there. CE has a deliberate rule: a new source never sits on top of another one. So I kept that refusal. I only made its message true and plain. If you want floor wastes allowed on top of an opening, that is your call and a separate change.
2. **What was wrong:** at an opening, CDFW said "A nearby pipe's Civil record changed while you picked. Pick again". Nothing had changed. When you pick, CE fills in a few missing details on its own copy of each nearby pipe. Then it compared that copy against the saved record, which does not have those details yet. They could never match, so every pick there was refused.
3. **What a drafter sees now:** type CDFW and pick an opening. CE says, for example, "IO2 is already at this point, and a new source cannot sit on top of it. Move clear of IO2 and pick again, or press Esc." Nothing is placed. A floor waste or downpipe picked on a pipe end with nothing on it now goes in, where before it could get the same false message.
4. **Fix:** draft PR #1833. It has a Settings switch, `linking.sourcePickComparesPipeRecordLikeForLike`, ON by default. It is not installed. Nobody has opened it in AutoCAD.
5. **My mistakes, first:**
   1. My first full test run had one failure. I had put the new message code one step too early. I moved it after the elevated-pipe check, and the second run was clean. This cost one 8-minute run.
   2. Moving that code stripped the Windows line endings from one file. I put them back before the commit.
   3. For a moment I made an empty stray file at `C:\ce-fx\b1223_edit.txt`, outside my own folder. I deleted it at once.
   4. I spent a few minutes on a slow search for robot evidence and on a wrong remote name. No harm done.
6. **Robot cases that prove it:** R36e, R36e_p2, R36e_p3 and R36e_p4 (in `C:\Lisp Files\_ACAD_DRIVER\cases\`, with p2 to p4 in `variants`).
   1. Once this build is installed, their check for no "Civil record changed" line should go from FAIL to pass.
   2. **They will NOT become whole passes.** Their checks for "Floor waste placed.", one block and one FW text still expect a placement. Those checks will keep failing until you decide.
   3. R36 (floor waste in open ground) must still pass.
7. **One question for you (already on the list):** should a floor waste be allowed on top of an inspection opening? My recommendation is no: keep it as it is now, with the plain refusal. A floor waste and an opening at the same point would be two drainage objects claiming the same pipe end.
   1. **"No"** means CE keeps refusing, with the plain message. The robot cases then change to expect that message.
   2. **"Yes"** needs a new rule for how the two share the pipe end. That is new work, not this fix.

---

## Detail

1. **Cause, with file and line (C-74 tip):** `Modules/Drainage/Services/LinkService.SourceLanding.cs`, `ReadCompleteSourceLanding`, the nearby-pipe check at lines 418 to 421 (the refusal text is the constant at line 372). It compared the live pipe row (`ProjectDataService.TryPeekCurrent`) with `before.RowJson`. That row is built at lines 280 to 285 of `BuildCompleteSourceLandingIndex` after `SourceChangePipeDirectionPolicy.FillMissingVerifiedOwnerKeys` (`Services/SourceChangePlan.cs` lines 15 to 36) has filled empty `FromSpineKey` and `ToSpineKey`. The fill reaches the live record only when a placement commits, and the refusal comes before any commit. The robot's own log (runs b6a3 and b6a4) has about 20 lines "CDRG index filled pipe ... end key 'CE-CIV-SRC-...'" before every refusal. The nearby pit check had the same mismatch, and it was fixed on 14 Sep 2026 by comparing live with live-at-read (lines 96 to 101 and 387 to 390). The pipe check never got that fix.
2. **Second suspect (lower):** the 14 Sep drift between the in-memory record and the drawing's own record snapshot. The fix covers it too, because it compares live with live and never compares live with the snapshot.
3. **Why it is deliberate after the fix:** the filled keys are `CE-CIV-SRC-...`, which are source identities. Pairs like 1094BE To and 109500 From share one key, so each opening is an inline source between two pipes. `Rules/SourceLanding.cs` line 112 (`SourceCompleteLandingRule.Decide`) refuses when `sourceCount > 0`, and line 128 refuses an end with existing hydraulic ownership. Both are deliberate.
4. **What the change does, in code terms:**
   1. New `Rules/SourcePickPipeRecordRule.cs`.
   2. The index captures `LivePipeRow` beside `LivePitRow`. It is not part of the fingerprint, so the preview-to-pick freshness check is unchanged.
   3. The pick check uses `SourcePickPipeRecordRule.Unchanged`. A real change to the pipe's record still refuses with the same sentence.
   4. After the elevated-run check, a refusal with Decide's "more than one possible connection" words is reworded, only when exactly one tagged source and no pit is under the pick. The opening's own tag is read with `SourceTagService.TryGetTag`, which is read-only.
   5. The switch is in `Models/UserSettings.cs` (LinkingSettings). It is documented like `reopenedDrawingLoadsItsOwnRecord` (#1830) and read at each pick. If it cannot be read, it reads ON.
5. **Safety:** the pick only reads. It makes no write, command, regen, view or system variable change, so REDO is untouched, and this is guarded by a source test. Nothing unlocks a layer or reaches into an Xref or REFEDIT. CE_SHARED is unchanged.
6. **Tests:**
   1. New `Bug1223FloorWasteOpeningTests`, 15 tests. With the real PipeData, the real fill and the real JSON writer, switch OFF reproduces the false refusal and switch ON passes.
   2. A real diameter change still refuses.
   3. The switch is ON for an empty settings file and for an older one, through both start-up reads. It is OFF only when typed false, and then it turns off only itself.
   4. Source guards check the new code paths.
   5. Focused run: 60 passed. Full Civil net10 suite: 20703 passed, 0 failed, 32 skipped. The first run had one failure in `SourceAtomicCoordinatorDependencyTests` (an IL-shape guard), fixed by moving the code. The PDF page test did not fail, so no lone re-run was needed.
   6. Civil net48 compile: 0 errors.
   7. Every build used `-p:SkipDevBundle=true -nr:false --disable-build-servers` with the C-62 refs. Nothing was deployed.
7. **Not tested:** nothing has run in AutoCAD.
   1. I have not checked that CE finds the opening as the one tagged source under a typed point at each of the four openings. If it does not, the old "more than one possible connection" sentence, or another existing refusal, shows instead of the named one.
   2. Real mouse picks were not tried.
   3. DP, OF and GIO at a free pipe end whose keys were never saved should now place. No robot case covers that yet.
8. **Robot follow-up (no case edited by this job):** after Tim's answer, R36e and p2 to p4 need either "contains '<IO tag> is already at this point'" and count 0 (for "No"), or the current placement checks (for "Yes", after new work). A new case for a floor waste at a truly free pipe end on a drawing whose pipe end keys were never saved would cover the placing half of part 1.
9. **Housekeeping:** worktree `C:\ce-fx\b1223` and scratch folder `C:\ce-fx\b1223j` were removed at the end. DESK_LOG.md and BUG_CARPARK.md were not edited.
