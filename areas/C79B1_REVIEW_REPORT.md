# C-79b1 paper review, job R (Opus, Sun 1 Nov 2026)

Read-only review. No AutoCAD, robot, build or test run; no case, setup or driver file edited; no slip written; nothing committed. Source of truth: each PR head through `gh pr diff` (heads checked today, all match the writer reports). Batch review under Tim's 1 Nov pilot: this one review covers the whole C-79b1 batch.

## Answer first

1. **Only 1 of the 4 case families can prove its bug on the robot today: bug1246 (#1891).** W1246 and its twin are READY TO RUN.
2. **W658 (#1972) does NOT fail on a build without the fix.** It is R11v87's route, which PASSED on 3.0.88 before #1972 existed. It is a good no-regression guard, but it cannot accept BUG-658. FIX FIRST: line 21 `PROVES_BUGS BUG-658` becomes `PROVES_BUGS` (empty). BUG-658 needs a Codex look.
3. **W1892 (#1892) and W1952 (#1952) are NOT RUNNABLE.** Their damage setups type Lisp, and the robot refuses typed Lisp. On paper both would go red without the fix and green with it.
4. **The 4 damage setups make the right "unreadable" record**, as far as paper can show. LINKS uses #1892's own test bytes exactly. PITLIST makes the shape #1952's hold reads as unreadable (I checked the reader). OUTLETROLES and LPD rely on F1's trace, which I did not re-check line by line.
5. **Counts by file:** READY TO RUN 3 (W1246, W1246_BROKEN, W658_BROKEN). FIX FIRST 1 (W658). NOT RUNNABLE 12 (W1892, W1892_BROKEN, W1952, W1952_BROKEN, 4 probes, 4 setups). NEEDS A CODEX LOOK as a verdict: 0 (the parts Codex must see are listed per family).
6. **Every window and prompt is closed** in the 4 runnable files. One cheap safety line is suggested for W1246 (item 2.1.4).
7. **Riskiest cases:** W1952 (it depends on which step each U takes back). W1246 (CR's prompt order is inside a compiled AutoCAD add-on, not readable in the C# code). W1892 (it depends on fixture handles nobody has read from DRV1_B1).
8. **Logic evidence:** ACCEPT for 4 PRs (#1868, #1943, #1958, #1970). NO for 6 (#1972, #1945, #1892, #1952, #1940, #1950). Reasons in section 4.
9. **Headless (needs no window):** W1892 and W1952 truly need none. W1246 needs no CE window but leans on a pre-selection, so maybe. W658 needs windows.
10. **One unblock serves 2 families and 4 setups:** a sanctioned way to write a damaged record (F1's v3 record verb, or `-AllowLisp` through the runner). That is a CE 00 or Tim decision.
11. **Validate:** main folder 4 files, 0 invalid. Held folder 8 files, 8 invalid, all for the same reason ("typed text may not contain '('"). Control ids: all known.
12. **Nothing is FIXED.** These are unrun drafts.

---

## 1. Offline checks (run once at the start)

1. **Validate, main folder:** `W1246` 38 steps 24 checks; `W1246_BROKEN` 38/17; `W658` 41/16 (SETUP-R47v); `W658_BROKEN` 41/14. 0 invalid.
2. **Validate, `held_dmg_lisp_blocked`:** 8 of 8 invalid. Each error is the typed-Lisp ban (for example SETUP-DMG-PITLIST lines 16 and 18; W1952 step lines 40, 49, 53).
3. **check_ids.ps1 -Folders drafts_c79b1_01nov:** "every control id is known".
4. **PR heads read today:** #1891 4f21fc9d, #1972 32fc1a44, #1892 9545489c, #1952 6845a095, #1868 38c3f825, #1945 7c31c33c, #1970 b3e76c82, #1940 c55494e0, #1943 62c8f363, #1958 9d25604c, #1950 649df208. All OPEN. #1972 is already at CE 05's fix commit.

## 2. Per case

### 2.1 W1246 and W1246_BROKEN (family bug1246, #1891): READY TO RUN, both

1. **Wording checked against the PR diff.** `Rules/CopiedSourceOwnTagRule.cs`:
   1. Line 72 and line 76 use OwnTagLine, the one-copy form: "[CE] The copied downpipe was given its own tag DPn (the original stays DP1). Check where it connects." Each CR copies one downpipe, so the one-copy form is right.
   2. Line 77 uses LockedLabelLayerLine: "[CE] The label for DP3 was not drawn because layer GUIDELINES is locked. CE has not changed the layer; unlock it and the label can be added." Exact.
   3. The switch key `copiedDownpipeGetsOwnTag` is in `Models/UserSettings.cs` (PR hunk at 1195), default true.
2. **Fails without the fix: yes.** Before #1891, `LinkService.Utilities.cs` (hunk at 229-246) only counts the copy as left behind and prints the BUG-1137 line. No own-tag line exists. The twin's switch off takes the same path, so it fails on `history has ... DP2` (a check), not on a stalled step. The twin never reads a field on an empty selection: `$labB` and `$labC` are only counted.
3. **Set-up reaches the state.** The GUIDELINES label is AcDbText, the reading N04 and P02 rely on (`N04_dp_and_raingarden_without_pipe.case.txt` line 8). The label goes on the original label's layer and is skipped when that layer is locked (`LinkService.CopiedSourceOwnTag.cs`, new lines about 62-80). DP2 then DP3 depends on DRV1_B1 having no downpipe beforehand. That is DERIVED, but the first check only asks for "Tag: DP", so a wrong number shows up as a clean red.
4. **Windows and prompts:**
   1. DP is closed by esc-prompt (line 34). Each CR is closed by esc-prompt (lines 46 and 59).
   2. `-LAYER` (line 52) relies on the runner adding one Enter after `GUIDELINES{NL}`. If no Enter is added, `-LAYER` stays open and the next CR is typed into it.
   3. Suggested safety line (optional, not required): after line 53 `wait`, add `  esc-prompt -> $locke`. The same line goes in the twin after its matching `wait`.
5. **Unsourced:** CR's prompt order (base point, second point, angle). On AutoCAD 2027, CR runs through `CE_TRANSFORM_2027.arx` (`Commands/CopyRotateCommands.cs` lines 29-60 at rel-20261102a), and its prompts are not in the C# code. The esc-prompt after each CR covers a leftover prompt. If CR asks in a different order, the case fails on its first CE check. That is a FINDING to report, not a reason to edit the case first.
6. **Coverage:** CR only. COPY, ROTATE Copy, SCALE Copy, grip copy and U are not driven, as the case says. BUG-1246 can be accepted only for the CR route.

### 2.2 W658 and W658_BROKEN (family bug658, #1972): W658 FIX FIRST, W658_BROKEN READY TO RUN (as a guard twin)

1. **Fails without the fix: NO.** Every check passes on a build without #1972:
   1. The cascade line, all 46 invert texts, U taking everything back and the CDEDIT outcome are R11v87's results, which PASSED on 3.0.88.
   2. The two "absent" lines (`PipeEditCommand.Update.cs` PR lines 274 and 284) do not exist before the PR, so they are absent there too.
   3. #1972 adds no success line or log line that the robot could read (I checked every WriteMessage and Logging call in the diff).
2. **Exact fix:** line 21 `PROVES_BUGS BUG-658` becomes `PROVES_BUGS`. Keep `BUG BUG-658`. Keep the case: it guards the risky part of #1972, the cascade moved after the save while still being one U.
3. **Twin:** answering No breaks the route, not the fix. It goes red on a check (the "Updated 4 pipes" line) with every window closed (no preview opens after No). It is honest as a guard twin. It does not satisfy "fails on the build before the fix" for BUG-658.
4. **Windows:** Edit Pipe closes on Save (line 43). The Recalculate box is answered (line 45). Cascade Preview closes on Apply (line 46). The twin's sleep 5 replaces Apply. The end snapshot checks for no Cascade or Edit Pipe window. All closed.
5. **Levels:** copied unchanged from R11v87, not recomputed. #1972 does not touch the cascade arithmetic. #1868 changes minimum falls only for DN450 and larger.

### 2.3 W1892 and W1892_BROKEN (family w1892, #1892): NOT RUNNABLE (typed Lisp)

1. **The paper is otherwise sound.** The wording matches `Rules/UnreadableLinkRecordRule.cs` (PR diff line 281) and the switch key `unreadableLinkRecordSkippedOnOpen` (PR line 242). The rebuild at U is the full `RebuildRuntimeCaches(db, state, "undo/redo", lightReads: true)` at `LinkService.Reactors.cs:924`, reached only when `state.IsCeOwned` is true.
2. **Fails without the fix: yes.** No skipped-record line exists before #1892, so the count is 0. The twin's switch off gives the old throwing read and also fails on that count.
3. **Unverified (fixture):** that 109D56 is pit P3 and holds a PIT_LINK record, and that 109768 is pit P2. Both come from CE_PLAN notes. The probe should read them first.
4. **Improvement:** the writer says the robot cannot see P2's pipe follow the MOVE. Pipes are polylines (#1970's `TryStorePipeInverts` refuses anything else), so I think a pipe-end read before and after the MOVE could replace the Codex look. Not verified against the driver.
5. **Windows:** none opened. LINE, U and MOVE are typed and finished by wait.

### 2.4 W1952 and W1952_BROKEN (family w1952, #1952, protected file): NOT RUNNABLE (typed Lisp)

1. **Fails without the fix: yes.** Before #1952 the hold changes only when the drawing opens. Live damage therefore never holds, the first CDREBUILD saves over it, and the "Not saved" count is 0. The twin (switch off) is the same path, so it is a real red on a check.
2. **Checked:** CDREBUILD asks nothing and prints "[CE] CDREBUILD complete:" every time (`Commands/LinkCommands.cs` 222-265 at 6845a095, "One U undoes it"). `Release` clears the told list (`Rules/UnreadableRecordHold.cs` 72-77), which is why the case expects 2 lines. The words match SkippedWriteLine.
3. **Biggest risk:** each U must take back exactly the step the writer names, starting with the damage step itself (one Lisp expression). If any other CE save is skipped between the first U and the first CDREBUILD, that skip uses up the one line for that hold, and the count reads 1. Both failures show as a red on a check, not a stall. The first run is effectively a probe.
4. **REDO rule kept:** nothing is read and no Lisp is typed between U (d) and REDO; it waits 12 s.

### 2.5 The four setups and four probes: NOT RUNNABLE (typed Lisp)

1. **SETUP-DMG-LINKS:** the text is exactly #1892's test bytes `{"Pipes":[{"PipeHandle":"2A4",` (test file, PR diff line 114). It goes in PIT_LINK as group 1 text. **Same unreadable shape: yes.**
2. **SETUP-DMG-PITLIST:** #1952's test passes a "damaged" flag, not bytes. The truncated JSON makes `JsonConvert.DeserializeObject` throw inside `TryLoadFromDrawing` (`ProjectDataService.Persistence.cs` 1062-1117 at 6845a095). That gives record exists, text present, read failed, which is the hold's unreadable state. **Yes (verified).**
3. **SETUP-DMG-OUTLETROLES:** invalid JSON reads as Damaged (F1, PR #1940 diff lines 628-700). **Yes per F1; not re-checked by me.**
4. **SETUP-DMG-LPD:** invalid legacy DATA reads as Unknown, which #1943 treats as unreadable (F1, MultiLpdDrawingAuthorityReader.cs 150-171). **Yes per F1; not re-checked by me.** Whether DRV1_B1 holds an LPD is unknown. Either way it ends unreadable.
5. **Note:** no family uses OUTLETROLES or LPD yet. #1940 and #1943 have no case because the Civil Hub ids are unknown.

## 3. Pilot: per family, what the robot can accept alone and what Codex must see

1. **bug1246 (#1891):**
   1. **Robot alone:** the two CE lines, the absent old line, and the block and label counts. This covers the CR route only.
   2. **Codex sees:** where the copy's label sits, the schedule or Inspector showing DP2 and DP3 once each, and GUIDELINES still locked.
2. **bug658 (#1972):**
   1. **Robot alone:** nothing toward BUG-658. It only proves nothing regressed.
   2. **Codex sees:** the drawing already shows 17.60 and 17.50 behind the Recalculate box; with the switch off and a restart, the box comes first. Also a refused save that asks nothing.
3. **w1892 (#1892), once unblocked:**
   1. **Robot alone:** the line, the log line, the record left intact, and "1 found".
   2. **Codex sees:** P2's pipe end follows the MOVE. This may become a robot read (item 2.3.4).
4. **w1952 (#1952), once unblocked:**
   1. **Robot alone:** everything.
   2. **Codex sees:** nothing.

## 4. Pilot: LOGIC EVIDENCE verdicts (the unit tests in each PR diff)

1. **#1868, Bug1091RedesignReadsMinFallTests: ACCEPT AS LOGIC EVIDENCE.** It is pure calculation with no source-reading guards. `SwitchOff_RowSetTo200_GivesExactlyTheOldAnswer` reproduces the before-fix answer. The grade proposal shown in the window still needs a Codex look.
2. **#1943, Bug1153 tests: ACCEPT AS LOGIC EVIDENCE.** It is a warning only, the PR says Apply does not change the CDLPD record, and the reader's sorting is tested (`TheReader_CallsOnlyUnknownAndUnsupportedVersionUnreadable...`).
3. **#1958, Bug1266InspectorUnreadableRecordOnceTests: ACCEPT AS LOGIC EVIDENCE.** It only changes how often a log line is written. There is no drawing change. `ManyPicks_OneDrawing_ReadAndLogOnce...` covers it.
4. **#1970, Bug1157LevelWriteNotSavedTests: ACCEPT AS LOGIC EVIDENCE**, with a limit. It only adds a line on a failure path no robot can trigger. The failure paths themselves are proved by source guards only.
5. **#1972: NO, run the case and do the Codex look.** The bug is the ORDER of a window against the drawing change. No unit test shows that.
6. **#1945: NO, run a case (once a fixture exists).** The path rule is pure, but writing the path at approval and reading it in CDDESIGN is drawing work, proved by source guards only.
7. **#1892: NO, run the case.** The tolerant read is tested with real bytes, but the effect is the cache rebuild at U, in a protected file.
8. **#1952: NO, run the case.** The hold sequence test is pure, but wiring it into U and REDO is a REDO-safety risk in a protected file. That needs a live run.
9. **#1940: NO, Codex look.** It writes a kept copy (OUTLET_ROLES_DAMAGED_COPY) into the drawing, and that write is not proved without AutoCAD.
10. **#1950: NO, Codex look.** It restores main-line geometry in the drawing after a refused upgrade.

## 5. Pilot: HEADLESS list, checked

1. **W1892: needs no window. Yes on paper.** Typed commands, a read-back and the log only.
2. **W1952: needs no window. Yes on paper.** Typed commands, U, REDO and the log only.
3. **W1246: maybe.** It opens no CE window, but it relies on a pre-selection before CR and on CE's compiled CR add-on.
4. **W658: no.** It uses the Edit Pipe window, a native message box and Cascade Preview.
5. **Unknown for all:** whether CE's Civil plugin loads in accoreconsole at all. A script run there could hold Lisp, which might also unblock the damage setups. That is a runner-owner question, not tested.

## 6. What this review did not do

1. It ran nothing, and recomputed no W658 level (they are copied from a passed run).
2. It did not re-trace the OUTLETROLES and LPD readers.
3. It read no fixture handle from DRV1_B1.
4. Scratch PR diffs were written to `C:\ce-fx\c79b1_R\` and deleted at the end.
