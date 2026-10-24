# Independent review: pilot-critical batch 3 PRs (and batch 2 status), Sat 24 Oct 2026

Reviewer: Opus 5.5, independent (did not build these). Method as `REVIEW_PILOT_CRITICAL_24OCT.md`. Base `origin/claude/rel-20261024m` at `5467f705` (installed Civil 3.0.73 / Manager 1.1.73). Each PR read at its live head, not from its text: #1752 `ab07e0c0`, #1755 `ee893e44`, #1756 `62a26660`, #1757 `c40af2a2`, #1761 `3a0c8a5e`. All five are single commits sitting straight on the base.

**Batch 2: NOT reviewed.** `areas\release-v3-colleagues-PILOT_CRITICAL_BATCH2_REPORT.md` did not exist at 14:55 or at the end of this review (checked again on origin/main at 15:10). Its builder was still holding the build lock with a full test run. Two batch 2 draft PRs already exist (#1758 BUG-1150, #1760 BUG-1196). I only checked whether they collide with batch 3. They do not: trial merges are clean apart from the log.

## ANSWER FIRST

1. **Counts:** MERGE 5, MERGE-WITH-FIXES 0, HOLD 0, REJECT 0 (five PRs, all batch 3).
2. **Safe to merge today:** all five: #1752 (BUG-1142), #1755 (BUG-1190), #1756 (BUG-1189), #1757 (BUG-1194), #1761 (BUG-1106).
   - **Train:** C-65.
   - **Could go in C-64:** the desk can promote them if the C-64 assembler has not started yet. Against the 40 C-64 PRs they add no clash of their own (details under "Conflicts").
3. **Top points (limits to tell Tim, none blocks a merge):**
   - **#1756, one question for Tim:** if the survey XREF is DETACHED after CDSURVEY approved it, CE now also stops offering its stored levels. It prints a line saying the XREF "is no longer in this drawing". If a drafter's habit is "approve the survey, then detach the heavy XREF", every survey offer stops. Typed levels still work, and the switch can turn the check off.
     - **My recommendation:** keep it as built. CE cannot check a survey it can no longer see.
     - **If Tim wants otherwise:** a detached XREF could get a warning only, with levels still offered. That is a small follow-up.
   - **#1755 does not fix surveys already stored:** a survey approved before this build keeps the wrong positions until CDSURVEY is run again. #1756 cannot catch this because the XREF has not moved.
     - **On a job:** any job with a turned or scaled survey XREF that holds level blocks needs CDSURVEY run again once.
   - **#1752 only makes one step tolerant:** a damaged pit record no longer stops pipe linking. The other 90 or so places that read a pit's record still stop on it, so moving or editing THAT pit can still fail. Nothing repairs the record; the change only stops one bad pit from breaking every other pit.
   - **Noticed, not caused by these PRs (worth a carpark entry):** Edit Pipe's prompt "Pick a point to move arrow to that segment" compares the pick in the current UCS with the pipe's world position (`PipeEditCommand.Attachments.cs` `PromptMoveArrowToSegment`, `ppr.Value` is not converted). In a turned UCS it can still pick the wrong leg. The CD and CDTEXTSEG routes do convert the pick.
4. **Protected files:** CE_SHARED, Installer, Manager, signing, deploy and PackageContents files are untouched by all five (checked on the combined tree against the base).
5. **No new hard block, nothing hard-coded:**
   - Every change warns and carries on.
   - **Survey check tolerance:** the one new number in #1756 is a rounding tolerance (0.000001 on the XREF placement), not an engineering value.
6. **Batch 3 report claims checked (RULES 6.1):**
   - **Test counts:** correct (5, 10, 7, 11 and 8).
   - **Shared, Installer, Manager, signing:** untouched, as the report says.
   - **One correction for the desk:** the report says 27 of the builder's 38 steps ran WITHOUT the shared build lock, at low priority. The report states this itself; the desk should rule on whether that is acceptable.

## Checks I ran

1. **Combined tree:** base plus all five PRs merged locally, in `C:\ce-rv6\m`.
   - **Clashes:** the five clash with each other ONLY in `REGRESSION_LOG.md`.
   - **Settings file:** three of the five add a switch to `UserSettings.cs`. These merged by themselves, and all three switches are present.
   - Nothing was pushed.
2. **One build:** Civil tests project, net10, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, with the shared build lock taken. Result: 0 errors. C: had 18 GB free before. No bundle written, nothing deployed.
3. **Focused tests on the combined tree:** 937 of 937 pass. That covers every class matching the five bugs, Survey, PipeTextSegment, CdCreationPlanPoint, StormReport, Council, UserSettings, SettingsService, PitLink and Defaults.
   - **The five new test classes alone:** 41 of 41 pass, which matches the claimed 5 + 10 + 7 + 11 + 8.
4. **Full Civil suite: NOT run.** It is 15:00 to 17:30, Tim's AutoCAD time (RULES 1.8), so I left the long run out. The builder's full runs per branch were 19,811 to 19,817 tests with 0 real failures. I did not re-run them.
5. **RED (each test fails without its fix):** checked by reading, not by running. Every PR's source-guard test asserts text that the base does not have, or forbids text that the base does have:
   - **#1752:** the scan still calls `ReadPitLinkData(blockRef, tr)`.
   - **#1755:** the base still contains `nestedRef.BlockTransform * parentTransform`.
   - **#1757:** the base still calls `NearestSegmentToPoint` in the callers.
   - **#1756 and #1761:** the new call text is missing from the base.
   - Each one would fail on the base.
6. **Conflicts:**
   - **Against C-64:** I fetched all 40 C-64 PR heads and compared trial merges with and without batch 3 on top. No C-64 PR gains a new clash. The only shared product file is `UserSettings.cs` (11 C-64 PRs add switches there), and none of the names collide.
   - **Against #1748 and batch 2:** #1748 (batch 1, waiting for its wording fix) and batch 2's #1758 and #1760 also gain no clash.

## One item per PR

1. **#1752 BUG-1142 (DATA LOSS): one damaged pit record no longer makes every new CD pipe link to no pit. Verdict MERGE. Train C-65.**
   - **Cause is real:**
     - **Where it reads:** on the base, `RemovePipeLinksFromAllOwners` (`LinkService.Geometry.cs`) reads EVERY block's pit-link record in model space with a reader that throws on bad text.
     - **What the throw does:** it runs inside `LinkPipeEndpointsToPits` before the transaction commits, so one bad record threw out the whole link step for CD, Edit Pipe save, the scoped pit relink and source changes (all three callers).
   - **The fix:**
     - **The scan:** reads through a tolerant reader. A record that is not valid text is skipped BEFORE anything is written to that pit, logged, and named once per drawing per session on the command line.
     - **The other pits:** the same reads and writes as before. Locked-layer refusal on the relink route is unchanged.
     - **If the pipe ends on the damaged pit itself:** the later "add link" step throws on that pit inside its own catch, logs it and writes nothing. The damaged record is therefore never overwritten. I checked `AddPipeLinkToBlock`, which is wrapped in try and catch in `LinkPipeEndpointsToPits`.
   - **Redo, locked layers, Xrefs:** no new drawing write (it removes one). Command-line text only. Nothing writes between U and REDO.
   - **No switch:** accepted. Switching it off would only bring back the data loss. The predecessor review accepted the same reasoning for #1747.
   - **Limits:**
     - **Wording overclaims slightly:** the line says CE "linked the pipe to the other pits". When the pipe's own end is on the damaged pit, that end links to nothing.
     - **Other readers still stop:** the other readers of a pit's record (about 90 places) still stop on the damaged pit.
     - **Stale link remains:** the damaged pit's old link to this pipe cannot be removed.
     - **No repair route:** there is still no repair route for the damaged record (a later job).

2. **#1755 BUG-1190 (WRONG ANSWER): a level inside a block nested in a turned survey XREF is stored where the drawing shows it. Verdict MERGE. Train C-65.**
   - **Cause is real:** `SurveyService.CollectEntitiesFromBlock` composed `nestedRef.BlockTransform * parentTransform`. In AutoCAD that applies the XREF's turn first and the nested block's offset second. So a level visibly at 0,10 was stored at 10,0.
   - **The fix:** `ComposeNestedTransform(parent, nested) = parent * nested`. That is the order the X-Civil reader, the pit-block preview and the long section already use. I searched the whole Drainage module: this was the only reversed product. CDSURVEY reads XREFs only through this reader.
   - **Tests:** they use real AutoCAD geometry maths on net10:
     - **Turned XREF:** a level at 0,0 inside a block at 10,0, in an XREF turned 90 degrees, lands at 0,10.
     - **Metre XREF in a millimetre drawing:** a scaled and moved XREF gives 15000,0.
     - **Switch off:** gives back the old 10,0.
   - **Switch:** `survey.nestedSurveyBlocksKeepTheirPlace`, ON. An older settings file with no such line loads it ON, and a typed OFF is kept (both tested).
   - **Redo, locked layers:** read-only (it reads the survey at CDSURVEY time).
   - **Limit:** stored surveys keep the old positions until CDSURVEY is approved again (ANSWER FIRST item 3).
   - **Cosmetic:** one code comment says "a level at 10,0 inside a block" where the test means "the block at 10,0". No change needed.

3. **#1756 BUG-1189 (WRONG ANSWER): survey levels are not offered from a survey XREF that moved since approval. Verdict MERGE (one question for Tim, ANSWER FIRST item 3). Train C-65.**
   - **Cause is real:** CDSURVEY already records each XREF's handle and exact placement at approval (`CdSurveyCommand.ReadXrefIdentity`). On the base, nothing after Apply ever compared it again.
   - **The fix:**
     - **One loader:** a pure rule (`SurveyXrefCurrencyRule`) runs inside `SurveyService.TryLoadSurveyPayload`, the one loader behind New Pit, Edit Pit, CDSL, slabs, CD grade suggestions, the cover-level source and the AI pit tool. This is design rule 1: one code path.
     - **What the drafter sees:** a moved, turned or scaled XREF holds the levels back and prints why. New Pit prints its line every time; the others print once per drawing per reason.
     - **Status line:** CDSURVEY's "Current survey" line and the dashboard add "NEEDS A REREAD".
   - **Re-approval clears it:** I checked that `SurveyIntakeApplyCoordinator` writes a brand-new provenance from the new capture. So approving again at the new position clears the warning; old records are not appended.
   - **Units:** an XREF whose units change on reload also shows as moved, because the scale changes. That covers part of the audit's "units" ask.
   - **Typing still works:** a typed level always works (warn, never block; R-27 respected).
   - **Older surveys:** a survey stored before placements were recorded, or a raw survey file, works exactly as before.
   - **Switch:** `survey.storedLevelsFollowXrefPosition`, ON. Older file loads ON and a typed OFF is kept (both tested).
   - **Redo, locked layers, Xrefs:** read-only. It opens the XREF reference for reading in a short read-only transaction, never touches the XREF or a locked layer, and writes nothing. Command-line text only.
   - **Side effect, correct in my view:** Edit Pit now tags a re-saved cover level as "typed", not "survey", while the survey is held back.
   - **Limits:**
     - **Detach case:** the detach question (ANSWER FIRST item 3).
     - **Changed file content:** a survey file changed ON DISK at the same position is not detected (the audit's disk part, out of scope).
     - **Evidence service:** `SurveyProvenanceEvidenceService` (which the audit also listed) still reports "Approved". Only the status line and the offers changed.
     - **Log noise:** each held-back lookup writes one CE log line.
     - **Long PIT runs:** New Pit repeats its line on every pit. The builder flagged this too, and it is the intended loudness.

4. **#1757 BUG-1194: CDTEXTSEG and the arrow prompts use the pipe leg you clicked. Verdict MERGE. Train C-65.**
   - **Cause is real:** `PipeTextSegmentChooser.NearestSegmentToPoint` ranks legs by distance to each leg's MIDPOINT. A click on a long leg near a bend can be closer to the short leg's midpoint.
   - **The fix:**
     - **New rule:** `NearestSegmentToPick` measures to the leg itself (clamped to its ends). A click exactly on a bend goes to the leg with the nearer midpoint.
     - **Where it is used:** the four picked-point callers. Those are CDTEXTSEG, the CD arrow-and-text prompt, the CD arrow on a picked leg, and Edit Pipe's arrow prompt.
     - **Unchanged on purpose:** the lookups that find which leg an EXISTING arrow sits on keep the midpoint rule, because arrows sit at midpoints.
     - **Old test rewritten:** one old source pin (`CdCreationPlanPointTests`) was rewritten to the new call name, and the PR says so.
   - **Switch:** `linking.pipeTextFollowsClickedLeg`, ON (older file loads ON, tested).
   - **Redo, locked layers:** same move code as before, only a different leg chosen. No new write path.
   - **Noticed, not caused:** the Edit Pipe UCS point in ANSWER FIRST item 3.

5. **#1761 BUG-1106 (WRONG ANSWER): a rating report naming a two-word council sets a council CE can find. Verdict MERGE. Train C-65.**
   - **Cause is real:** `StormReportOffer.BuildCouncil` saved the matched NAME ("Glen Eira") as the council. CE looks councils up by id ("glen-eira"), so the job silently had no council rules. One-word councils only worked because the name and the id differ only in capitals.
   - **The fix:**
     - **Match and save by id:** the match is turned into the profile id (by id, then by name) before it is compared with the job's council and before it is saved.
     - **Messages:** "Council set to Glen Eira" names the council.
     - **Old jobs heal:** a job that an earlier build saved with the NAME is now treated as the same council, not asked "Which one is right?". Accepting the offer stores the proper id.
     - **Old tests unchanged:** called without the lookup, the rule behaves as before, which keeps the existing name-only tests valid.
   - **No switch:** accepted. Switching it off would only save an id CE cannot find.
   - **Redo:** CDDESIGN state only, the same write as before.

## Train

1. **C-65 for all five**, one install (RULES 8.5). Merge order does not matter; keep both sides of `REGRESSION_LOG.md` each time.
2. **Switches for C-65's new-switch defaults test:** pin `survey.nestedSurveyBlocksKeepTheirPlace`, `survey.storedLevelsFollowXrefPosition` and `linking.pipeTextFollowsClickedLeg` ON.
3. **Settings page rows:** none of the three has a row (window lane).

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing was opened in AutoCAD. No damaged pit record, moved survey XREF, nested survey block, bent pipe or STORM report was tried there. Built and unit-tested only. Nobody has seen any of these work in AutoCAD.
2. **Full suite and RED by run:** the full Civil suite was not run (Tim's working hours). RED was proven by reading the source guards, not by running the tests against the base.
3. **Other projects:** net48, Manager and Structural were not built or tested.
4. **Batch 2:** no report existed, so I did not review #1758, #1760 or any other batch 2 PR. I only checked that they do not clash with batch 3.
5. **The 8 skipped batch 3 bugs** (BUG-1088, BUG-1095, BUG-1099, BUG-1091, BUG-1192, BUG-1031, BUG-865, BUG-816) have no PR and were not reviewed.
6. **C-64 checks:** the C-64 conflict check was by trial merge only. Clashes in meaning with C-64 PRs were checked for the shared `UserSettings.cs` only (no repeated switch names).
