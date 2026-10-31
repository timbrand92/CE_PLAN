# C-79b1 case writing, job W2 (Opus writer, Sun 1 Nov 2026)

## Answer first

1. **Two of my six PRs have a robot case plus a broken twin: #1892 and #1952.** Four files are written. All four are HELD, not runnable: they use F1's damage setups, which type Lisp, and the robot refuses typed Lisp today.
2. **Where:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c79b1_01nov\held_dmg_lisp_blocked\` (next to F1's probes), so the main folder still validates clean. The cases are W1892, W1892_BROKEN, W1952 and W1952_BROKEN.
3. **#1940 and #1943 have no case.** CE shows their warnings only in the Civil Hub redesign Apply result. No case has ever driven CDHUB, and none of its control ids is known. They need a Codex look, or a Civil Hub control probe first.
4. **#1958 has no case.** The fix only acts when CE has NO pit list in memory, which means a drawing OPENED with the damage already in it. A live damage setup cannot give that, and the runner cannot reopen inside a case. It needs a Codex look, or a damaged drawing file saved as a fixture.
5. **#1950 has no case (Codex look).** No robot fixture in `C:\ce_rc_drv` is recorded as holding an older twin detention pipe. The drainage corpus is real job drawings, so the robot may not use it. The fix also needs a PC where the pipe-object upgrade is refused, and I found no setting that forces that.
6. **Offline checks:** the main folder validates with 4 files and 0 invalid (another writer's W1246 and W658). The held folder has 8 of 8 invalid, and every error is the same one: "typed text may not contain '('". The control-id check says every control id is known in both folders. No file contains the word print, a 17.x level or a street name.
7. **Nothing was run.** No AutoCAD, no build and no test. Nothing was committed or pushed.
8. **Robot accepts alone (both families):** command-line lines and their counts, Civil log lines, and the damaged record's text read back.
9. **Codex must see (#1892):** after the MOVE of pit P2, its pipe end follows the pit.
10. **Headless:** W1892 maybe (the drag is the Codex part). W1952 maybe: typed commands only, but U and REDO must behave as they do in the full AutoCAD.
11. **Logic evidence for the four no-case PRs:** Bug1144DamagedOutletRolesTests (#1940), Bug1153UnreadableLpdTests (#1943), Bug1266InspectorUnreadableRecordOnceTests (#1958), Bug1152TwinUpgradeRestoreTests (#1950).
12. **One unblock serves both families:** the record-write route F1 asked for (a v3 record verb, or the runner passing -AllowLisp on). That needs CE 00 or Tim.

---

## Per PR

### 1. #1892 (B-070, BUG-1141), head 9545489c: family w1892

1. **Cases:** W1892 (`W1892_unreadable_pit_link_skipped.case.txt`) and its twin W1892_BROKEN.
2. **What it does in AutoCAD:**
   - The setup SETUP-DMG-LINKS spoils the saved link record on pit P3 (handle 109D56).
   - The case draws a 1 m line far from the network and takes it back with U. It does this twice. At each U, CE forgets what is joined to what and reads every pit's link record again.
   - It reads P3's record back to check that it is still damaged.
   - It moves pit P2 (handle 109768) up 2 m.
3. **Right looks like:**
   - Exactly one command-line line starting `[CE] The CE link record on one pit (drawing handle 109D56, at `.
   - The same line ends `could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is.`
   - Exactly one Civil log line `[Link] BUG-1141: pit 109D56 has a link record that cannot be read; skipped by the cache rebuild and left as it is.`
   - No line names 109768. MOVE says "1 found". No CE window is left open.
4. **Source:**
   - The words are in `Rules/UnreadableLinkRecordRule.cs` (new file, lines 22-31) and in `LinkService.Persistence.cs` NameUnreadableCacheRecord (PR hunk @@ -834, new lines about 885-892).
   - "Once per drawing" comes from NamedKey plus the HashSet UnreadableCacheRecordsNamed.
   - The rebuild at U is at `LinkService.Reactors.cs:924` (RebuildRuntimeCaches "undo/redo", lightReads).
5. **Derived, never seen on a run:**
   - that both U rebuilds really read P3 through ReadPitLinkDataForCache (full or incremental path; both are patched);
   - that 109768 is pit P2 (taken from CE_PLAN notes, not read from the fixture);
   - the "at x, y" part of the line, so the check stops before the coordinates.
6. **Arithmetic:** none. The lines are at 190000,-95000 and 190000,-96000, 1000 mm long and far from the network. The MOVE is 0,2000.
7. **What the twin breaks:** `linking.unreadableLinkRecordSkippedOnOpen false`, which gives the old throwing read. It fails on `history count ... = 1` because it finds 0 lines.
8. **Robot accepts alone:** the line count, the log count, the record still damaged after U, and "1 found".
9. **Codex must see:** pit P2's pipe end follows the 2 m MOVE. A CE pipe object gives no points through ent-read, so the robot cannot read this.
10. **Headless:** maybe. The checks are text only, but the drag is a Codex look.
11. **Logic evidence:** Bug1141UnreadableLinkRecordTests (PR diff), including the test where ten records with one damaged load nine.

### 2. #1952 (B-118, BUG-1070), head 6845a095: family w1952 (protected file)

1. **Cases:** W1952 (`W1952_undo_lifts_hold_redo_puts_back.case.txt`) and its twin W1952_BROKEN.
2. **What it does in AutoCAD:** SETUP-DMG-PITLIST spoils CE's saved pit and pipe list in one step (call it D). Then the case runs:
   1. LINE, then U. The re-read after U finds the damage, so the hold goes on.
   2. CDREBUILD. Its save is skipped.
   3. U, then U again. The second U takes back D, so the record is good and the hold comes off.
   4. A 12 s pause, then REDO. D is back and the hold goes on again. It reads the record back.
   5. CDREBUILD. Its save is skipped again.
   6. U, then U again. The record is good and the hold is off. It reads the record back.
   7. CDREBUILD. It saves. It reads the record back.
3. **Right looks like:**
   - Exactly 2 lines `[CE] Not saved to the CE record (CE's own record save): the CE record in this drawing could not be read, so CE does not save over it.`
   - 3 lines `[CE] CDREBUILD complete:`.
   - The record reads damaged after REDO, and good after the last two read-backs.
   - The Civil log has `[ProjectData] The CE record in this drawing exists but could not be read (it may have been written by a newer CE). CE will not save over it; the original stays in the drawing.`
4. **Source:**
   - SkippedWriteLine is at `Rules/UnreadableRecordHold.cs:63-65`. Release clears the "already told" list at lines 72-77, which is why the second line appears.
   - SaveRoute is at `ProjectDataService.Persistence.cs:1287`. The hold log line is at :996-998. The switch is checked in NoteUnreadableRecordAfterHistory at :1017-1022.
   - CDREBUILD's SaveProjectData(immediate) is in `Commands/LinkCommands.cs` CdRebuild. All of these are at 6845a095.
5. **Derived, never seen on a run:**
   - that each U takes back exactly the step named here (the D step is one Lisp expression, but I cannot say how AutoCAD groups it), so the record read-backs are the judge;
   - that CDREBUILD under the hold still counts as its own U step.
   - The hold log line is checked as "has", not as a count, because the idle retry may log it twice.
6. **REDO rule:** there is no read and no typed Lisp between the U that takes back D and the REDO. The 12 s sleep is the pattern R11 and R08 found safe.
7. **What the twin breaks:** `linking.undoRefreshesUnreadableRecordHold false`. The hold then never moves in the session, so the 'Not saved' count is 0 and the check fails.
8. **Robot accepts alone:** everything. It is text only.
9. **Codex must see:** nothing.
10. **Headless:** maybe. It uses typed commands only.
11. **Logic evidence:** Bug1070UndoRefreshesHoldTests (open damaged, U to good, REDO to damaged, U again: hold true, false, true, false).

### 3. #1940 (B-121, BUG-1144), head c55494e0: no case

1. **Why:** the warning exists only in the Civil Hub (CDHUB) redesign Apply result and its log (`CV-01H4 apply: Warning: ...`, NetworkRedesignApplyCoordinator). Getting there means nominating outlets, then Preview, then Apply in the Civil Hub window. No case or UI map holds any Civil Hub control id.
2. **Words for the Codex look:**
   - `Warning: the outlet roles saved in this drawing at the last redesign could not be read, so the check of the nominated outlets against them was skipped.`
   - followed by ` CE kept a copy of the damaged record in this drawing (CE_CVL_NETWORK_REDESIGN, OUTLET_ROLES_DAMAGED_COPY) before writing the new roles.`
   - Both are in RedesignOutletRecordRule.cs in the PR.
3. **Switches:** `linking.redesignApplyNoticesDamagedOutletRoles` (ON) and `linking.redesignApplyStopsOnDamagedOutletRoles` (OFF).
4. **To make it a robot case:** a Civil Hub control probe, plus the Lisp unblock.

### 4. #1943 (B-121, BUG-1153), head 62c8f363 (stacked on #1940): no case

1. **Why:** the same as #1940. The warning shows only in the redesign Apply result: `Warning: this drawing has a legal point of discharge (CDLPD) record that CE cannot read, so the check that keeps a Fixed outlet where it is was skipped. Apply does not change the CDLPD record. Open CDLPD to check or re-confirm the outlet.` (RedesignLpdRecordRule.cs).
2. **Codex look:** the same session as #1940 can do both.

### 5. #1958 (B-127, BUG-1266), head 9d25604c: no case

1. **Why:** InspectorPaletteService only reaches the remembered failed read when CE has no list in memory for the drawing. With live damage CE keeps the list it loaded at open, and U keeps it too. Only a drawing opened with the damage shows the fix. That needs a damaged DWG fixture (F1's save-copy idea: a runner-owner decision).
2. **Words:** `[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown.` (PR #1958 diff, about line 977). It should appear once for three pit picks. The switch is `linking.inspectorUnreadableRecordLoggedOnce`.

### 6. #1950 (B-120, BUG-1152), head 649df208: no case (Codex look)

1. **What I checked:**
   - the fixture masters in `C:\ce_rc_drv` (DRV*, CLD*, OLDCOPY_C10 and its note);
   - CE_PLAN notes for any fixture described as holding a twin detention pipe: none;
   - the drainage corpus (`C:\CE_DrawingIntelligence\11_Plugin_Drainage_Corpus`): it holds real job folders, so the robot may not use it. I opened no drawing.
2. **Also needed:** a PC where the pipe-object upgrade is refused. The PR describes this as a colleague's PC, or the enabler saying no. No setting forces it.

---

## Faults and notes (named only, nothing edited)

1. **The whole damaged-record family is blocked on typed Lisp** (as F1 found). Every W1892 and W1952 step that touches the record uses `-AllowLisp`, which neither the validator nor the runner accepts today.
2. **The C79B1 plan counts #1940, #1943 and #1958 as robot cases.** On this evidence they are Codex looks until a Civil Hub probe exists and a damaged DWG fixture exists.
3. **Fixture facts I used but did not read from DRV1_B1:** pit P2 is 109768, and pit P3 is 109D56 with a PIT_LINK record. Both come from CE_PLAN notes.
