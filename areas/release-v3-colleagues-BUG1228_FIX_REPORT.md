# BUG-1228 fix report: DP takes about 30 seconds to place (Thu 29 Oct 2026, about 09:15 to 10:35 Melbourne)

Job: CE 01 Build and Bug Fixes, fix agent (Opus, Max). Base: C-75 tip `claude/rel-20261026z` @ `09126560` (Civil 3.0.85). Branch `fb/bug1228-dp-speed` @ `157013c4`. **DRAFT PR #1837**, not merged.

## ANSWER FIRST

**FOR TIM**

1. **What was slow:** every time you place a downpipe, CE reads the whole drawing to work out where the downpipe lands. It does this four times for one downpipe: when the prompt opens, when you click, just before it draws, and a check just after. On the robot's test drawing each read took about 5 seconds. That is the 30 seconds.
2. **Why each read was slow:** inside each read, CE goes pipe by pipe and asks "what pit or downpipe is at this end of the pipe?" For every pipe end it looked again at every object in the drawing: every line, text, block and xref, about 1,083 of them, twice. With 49 pipes that is about 200,000 looks per read. A bigger drawing is slower still.
3. **What I changed:** within one read, CE now looks at each object properly once and remembers the answer ("this is a line, not a pit", or "this is a pit, here is its outline"). For the other pipe ends it only does the quick distance check. The same pit, pipe end or refusal comes out; it just gets there faster. Nothing is remembered between reads or between commands, so a change you make in the drawing is always seen.
4. **What you should see:** type DP, click a point. The downpipe should go in within a few seconds instead of about 30. OF, CDFW and the other sources use the same read, so they should speed up the same way.
5. **Not proven yet, said plainly:** nobody has run this in AutoCAD and I have NOT measured the new time. I found the cause in the CE log of the robot's 28 Oct run and in the code. I expect each read to drop from about 5 seconds to well under 1. Other work in the read, and the four reads themselves, still cost something, so I cannot promise 1 to 2 seconds until the robot measures it.
6. **Fix:** draft PR #1837, not installed.
   1. Settings switch `linking.sourceLandingReadsEachObjectOnce`, ON by default. Turn it off and CE reads exactly as before.
   2. A second switch, `linking.sourceLandingTimingLog`, OFF by default. When on, it writes one line per read in the CE log saying how long it took. It changes nothing in the drawing.
7. **My mistakes, first:**
   1. My first version moved the speed-up into small helper pieces. Older checks look inside those exact parts of the code and would have failed. I rewrote it in place before any test run. Cost: about 15 minutes, no wasted run.
   2. My first full test run had one failure: the new timing switch was missing the written-out "off" value that a settings check requires. I added it and ran the full suite again (cost: one 6-minute run).
8. **Robot case to prove it: N31_dp_time,** with a switch-off twin C31 that should bring the old 30 seconds back. Details in item 9 below.

---

## Detail

1. **Evidence (CE log `%APPDATA%\CE_CVL_SUITE\logs\ce_cvl_structured_20261028.log`, read only; run RUN-20261028-1447-C3.0.84-p1n13a, case N13a, "DP completed 32406 ms"):**
   1. 14:48:16.2: DP starts (record switch and save lines).
   2. 16.3 to 21.4 s: first landing index read, its "CDRG index filled pipe" lines stepping through the 49 pipes about 100 ms apart. 21.88: the downpipe block is resolved and the prompt opens.
   3. 22.0 to 26.4: second read (the pick, `TryRefreshTrackedPreviewAuthority`). 26.9 to 31.7: third read (the revalidate in `ApplyCompleteSourcePlacement`). 31.7 to 38.1: the after-write check `CaptureSourceChangeDrawing` (its "[Source] pipe 1136A4 left out of this placement" line comes at 38.1, at the end of the pipe list).
   4. 38.45 to 44.3: the next DP prompt reads the drawing again (no "filled" lines now, because the keys were saved). 48.6: Esc, "DP completed 32406 ms". That figure includes about 4 s of the robot waiting at the next prompt.
   5. The robot reports show the same for every source: DP 27.6 to 32.4 s, OF 26.8 to 29.3 s, CDFW 21.6 to 28.6 s.
2. **Cause, with file and line (C-75 tip):** `Modules/Drainage/Services/LinkService.Geometry.cs`, `FindBestPitOwnerAtPoint` (lines 1265 to 1311) and `FindBestTaggedOwnerAtPoint` (lines 1358 to 1440).
   1. With `exactCandidates == null`, each walks `model.Cast<ObjectId>()` (lines 1274 and 1370).
   2. For every object each walk calls `TryGetBlockReference` (GetObject, evidence `Seen`, then `Touch` with two JSON serialisations and about 20 number observations per block) and `IsPitBlock`.
   3. For pits it calls `ReadPitOutline` (dynamic block properties and `GeometricExtents`). For other blocks it calls `context.Tag` (four record reads), `RequireSourcePitAssociation` and the saved connection. When the end is outside the connection circle it also calls `GeometricExtents`.
   4. These are reached for every pipe end from `ResolveOwnerAtEndpoint` and `FindOwnerAtPoint` (lines 1114 to 1227). That is called per pipe in `BuildCompleteSourceLandingIndex` (`LinkService.SourceLanding.cs` line 277) and in `CaptureSourceChangeDrawing` (`LinkService.SourceChangeCapture.cs` line 83).
   5. So one read is O(pipes x objects): 49 pipes x 2 ends x 2 walks x about 1,083 objects.
3. **Second suspect (not changed): the number of reads.** Each of these rebuilds everything on purpose, to prove nothing changed between preview and pick and between pick and write. Cutting them would change what is proved, so I left them.
   1. `SourcePlacementService.TryRefreshTrackedPreviewAuthority` (line 245, and a further read at line 266 when the record moved).
   2. The revalidate in `ApplyCompleteSourcePlacement` (`LinkService.SourceLanding.cs` line 610).
   3. The verifyAll capture (line 729).
4. **Not the cause (checked in the code):** the BUG-1225 index capture (PR #1830) and the BUG-1223 live pipe rows only serialise the 11 pit and 49 pipe rows once per read (milliseconds). `SourceEvidenceIdentityRule` is one string build per observation.
5. **What the change does, in code terms:**
   1. New `Rules/OwnerScanMemo.cs` (headless). `Look(id)` answers ReadInFull, PassOver or Reuse; `NotThisKind(id)` and `Remember(id, facts)` record what a full read proved. With the switch off every call answers ReadInFull and nothing is kept (no collections are even made).
   2. `LinkService.Geometry.cs`: both walks keep their `foreach` over the same candidates in the same order and go through the memo. Only answers proven without the point are remembered:
      1. not a live block (`TryGetBlockReference` now says when the object WAS read and is not a live block; a caught read failure is not remembered);
      2. a block that is not a pit, or a pit (for the source walk);
      3. no source name, or a source joined to a pit.
   3. A pit's outline, and a free source's tag, saved connection and (the first time they are needed) extents, are kept. Everything after that runs every time: the existing-link reach, `OfferIfTouching`, the connection circle, the extents fallback and its evidence line.
   4. `BuildCompleteSourceLandingIndex` and `CaptureSourceChangeDrawing` turn the memo on for their own read context, before `Prepare`, from the switch. They are the only two callers (a test pins this). Both only read from start to end, and the context dies with the read.
   5. Evidence: everything a skipped look would have recorded was already recorded, with the same value, by the first full look. An observation that repeats with the same value changes nothing, so the landing fingerprint and every "changed while you picked" check are unchanged.
   6. New `Rules/SourceLandingSpeedRule.cs` holds the switch readers and the timing line. New `Services/LinkService.SourceScanMemo.cs` holds:
      1. the facts each walk keeps;
      2. the context's two memos and their counters;
      3. the switch readers, which read ON / OFF when Settings cannot be read;
      4. the timing line, which never throws.
   7. `Models/UserSettings.cs` adds `linking.sourceLandingReadsEachObjectOnce` (ON, "Default: on.") and `linking.sourceLandingTimingLog` (OFF, "Default: off."). Neither is on the Settings page; the other source fix switches (BUG-1223, BUG-1225) are not either.
6. **Safety:**
   1. Reads only: no drawing write, command, regen, view or system variable change (REDO-safe, BUG-861 rule).
   2. Nothing unlocks a layer or reaches into an Xref or REFEDIT. CE_SHARED unchanged.
   3. The Cecil IL guards that look inside the two walks (`ReadPitOutline`, `OfferIfTouching`, `WasPitLinkedToPipeEnd`, `Cast`) and inside `BuildCompleteSourceLandingIndex` still pass.
7. **Tests:**
   1. New `Bug1228DpSpeedTests`, 24 tests, all pass. They cover:
      1. the two switches through both start-up reads (an empty file, a C-75-shaped file and a partial linking group). Each typed value changes only itself, and the neighbouring BUG-1223 and BUG-1225 keys stay ON;
      2. the memo, walked exactly as the two methods now walk, over a made-up drawing of about 500 objects and 87 pipe ends. ON gives the same pit, source, distance, count and refusal, and the same recorded evidence and failures, as OFF (also with an unreadable object and a broken one). Full reads drop from 87 x 500 x 2 to 500 x 2, and extents reads to at most one per source;
      3. an unreadable object is read again on every walk, and a broken object refuses every pipe end the same way ON and OFF;
      4. source guards.
   2. Focused Civil net10 run (BUG-1228, BUG-1223, BUG-1225, the C-74 and C-75 switch tests, the source landing, placement, capture and coordinator IL guards, pit outline): 397 passed, 0 failed.
   3. Full Civil net10 suite: first run 20,797 passed, 1 failed (`C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault`, my missing `= false`). After the fix: **20,798 passed, 0 failed, 32 skipped** of 20,830. The PDF page test did not fail, so it needed no lone re-run.
   4. Civil net48 compile: 0 errors, no warnings from the changed files.
   5. Every dotnet run used `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs, AutoCAD 2027 on PATH and below-normal priority, one at a time. The first full run waited about 9 minutes for another agent's build to finish. Nothing was deployed.
8. **Not tested / not proven:**
   1. Nothing has run in AutoCAD. The new DP time is not measured.
   2. The headless tests prove the memo's rule (same answers, same evidence, far fewer reads) on made-up objects. They do not run AutoCAD's own objects. That the real walks give the same results rests on the code only reading during one read, and on the robot.
   3. Still uncut and unmeasured:
      1. per pipe end, each pit's link record is still parsed (`WasPitLinkedToPipeEnd`, 11 pits x 98 ends);
      2. per read, each block is still read once by `ReadPlacementOwner`;
      3. the four reads per DP remain.
   4. If N31 shows a read still over about 1.5 s, the timing line names which read, and those are the next places to look.
9. **Robot case proposal: N31_dp_time** (fixture DRV1_B1, fresh copy, `linking.sourceLandingTimingLog` true in the case's settings overlay):
   1. **Steps:** DP, pick 150000,-80000, Esc at the next DP prompt.
   2. **Checks:**
      1. history has "Downpipe placed. Tag: DP", and no "could not be refreshed";
      2. count of new DOWNPIPE DYNAMIC WITH MASK inserts = 1;
      3. every new CE log line "[BUG-1228] Source landing index read in N ms" and "[BUG-1228] Source change read in N ms" has N under 1,500 and says "reads each object once: on";
      4. "Command outcome: DP completed N ms" has N under 10,000. That figure includes the runner's own wait at the next prompt, about 4 s on 28 Oct.
   3. **Control C31_dp_time_switch_off:** the same with `linking.sourceLandingReadsEachObjectOnce` false. Expect the read lines at about 4,000 to 6,000 ms with "reads each object once: off", DP completed at about 29,000 ms, and the same placement line. This is the failing broken twin for the Claude-accepted rule.
   4. **Twins worth adding later:** the same for OF (N31b) and CDFW (N31c), and a DP on a pipe end, to show the same tag and join line ON and OFF.
10. **Housekeeping:**
    1. Worktree `C:\ce-fx\b1228` kept for follow-up, with its build output removed (`git clean -fdXq`). Its run logs are in `C:\ce-fx\b1228j`, with the temp folders removed. C: has 51 GB free.
    2. DESK_LOG.md and BUG_CARPARK.md were not edited.
