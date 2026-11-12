# Review: PR 2074 `claude/trust-clean-honest-steps` (BUG-1439, BUG-1442, BUG-1447: CLEAN on locked layers, CLEAN's first stop, the copy from before the clean-up)

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:19 PC clock. Read only. **Head reviewed:** `42610102`, one own commit on the installed Structural `8de95c34` (base `claude/trust04-base-struc-1.0.126`, checked; found with `gh pr view 2074`). **Read against:** the three carpark entries and the installed code at `C:\CE_WORK\scratch\audit_struc` (`Services\CleanPipelineService.cs`, `Services\DrawingSafetyService.cs`, `Core\Symbols\ModelSpaceWriteGuard.cs`). **Four states:** Built yes (lane). Tested unit only (lane, 71 CLEAN and save tests). Installed no. Accepted no.

---

## FOR TIM

1. CLEAN no longer drops the whole text step and the whole ByLayer step because one object sits on a locked layer: those objects are left alone and counted, nothing is unlocked, and a step that still fails says so in plain words instead of AutoCAD's raw word.
2. CLEAN and FASTSAVE now stop first on a read-only drawing and inside REFEDIT, which is right. But they also now refuse to run on a layout tab, so typing CLEAN (or FASTSAVE, which only regenerates and saves) on a layout no longer saves the drawing. That changes your daily CLEAN-and-save habit and is not a protection AutoCAD needs; it should be your decision, not the default.
3. CE still makes no copy from before the clean-up (that is left as your decision); CLEAN now says so after every save and names AutoCAD's own .bak file with its time.

**Verdict: FIX FIRST** (one item). GO would mean fit for testing on copies, never to merge or install.

---

## FIX FIRST

1. **The layout-tab stop on CLEAN and FASTSAVE.** The new first stop is `DrawingSafetyService.CommandPreFlightModelSpace` (`Services\CleanPipelineService.cs` 74), which the installed code describes as the check "for commands that always write into Model space" (`Services\DrawingSafetyService.cs` 57-67) and which refuses paper space on a layout tab ("You are on a layout tab (paper space), so CE cleaned and saved nothing. Go to the Model tab ...", `Core\Symbols\ModelSpaceWriteGuard.cs`). CLEAN works on the whole drawing (purge, text styles, ByLayer, regenerate, save) and writes nothing into the current space; FASTSAVE by default only regenerates and saves (BUG-620, 113-115). Tim's own ruling for CLEAN is "put qsave back into the CLEAN command", his habit being to type CLEAN and have it save (B-178, 76-78). The bug entry asks for the layout stop, but the entry was written from a code reading, and the native protection rule covers read-only, Xref, REFEDIT and locked layers, not layout tabs; Tim's decision 6 (7 Nov, "some of the commands are useful in all drawings as ce tools") is the nearest ruling. Suggested fix (DRAFT default for Tim): keep the read-only stop and the REFEDIT stop, drop the layout-tab stop (at the very least for FASTSAVE), and list "should CLEAN refuse on a layout tab?" as Tim's question. A test that CLEAN's first stop has no paper-space refusal must fail on today's head.

## Sound (by reading)

1. **Locked layers, BUG-1439:** both steps now open each object for reading first; the text step goes on only for a text, multiline text or multileader whose style is not the standard one (`CleanPipelineService.cs` 425-440), the ByLayer step only for dimensions, leaders and multileaders (556-568); an object on a locked layer is counted and skipped; only an object that will change is opened for writing. The layer is only read (`IsOnLockedLayer`, 656-662); no line sets a layer unlocked anywhere in the file. The same objects change as before on unlocked layers: nothing that used to be cleaned is now missed except what sits on a locked layer.
2. **No raw word:** a failed step shows "did not finish; the details are in the CE log" (245-251; `CleanHonestWording.cs` 22) and the raw message still goes to the log; a partial clean-up adds one line that says how many steps did not finish and whether the drawing was saved (208-210).
3. **Read-only and REFEDIT, BUG-1442:** the stop runs before anything else, before the undo group starts, so a refusal changes nothing (74 against 91).
4. **The copy line, BUG-1447:** it never claims a copy CE does not have; a `.bak` beside the drawing is named with its time as AutoCAD's own, "check its time before you rely on it" (`CleanHonestWording.cs` 36-53). Making a real copy before the clean-up is listed as Tim's decision. Plain words.
5. **One U:** the undo group is unchanged (start 91, end 195-196).

## Small

1. **The copy line prints after every CLEAN save:** two sentences on a command used many times a day. For Codex's look and Tim: fine as a first step, but a cockpit command should be quiet unless something needs a decision. Note also: once PR 2048 (Structural timed copies of unsaved work) is in, a CE copy from before CLEAN may exist in CE's own folder, and "CE kept no copy" would then need re-checking.
2. **The locked count sits inside a run of code words** ("hatches=3; 12 objects on locked layers were left alone, nothing was unlocked, dimstyles=..."). The surrounding summary was already full of them (pre-existing); the new words are plain.
3. **A partial clean-up is still saved,** now said in a line. The bug title complains about that save; B-178 makes saving Tim's choice. Worth Tim knowing.

## Tests

Do they fail without the change through the real code path? Partly. The wording functions are real (they do not exist on the installed build) and the copy line is tested against a fake folder. Read-first, skip-locked, upgrade-only-what-changes, nothing-unlocked and the first stop are text searches of `CleanPipelineService.cs` (`Bug1439CleanHonestyTests.cs`). No step runs on a drawing.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD; the locked case, the read-only copy, REFEDIT and the `.bak` line are all unseen.
3. BUG-1440, 1441, 1443 to 1446 and 1448 (other CLEAN faults, not in this PR).
4. No client name, street, suburb or job number in the diff (checked; the test uses a made-up path).
