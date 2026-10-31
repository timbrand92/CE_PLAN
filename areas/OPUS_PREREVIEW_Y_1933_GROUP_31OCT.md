# Opus pre-review Y: PRs #1933, #1934, #1898, #1899, #1900, #1901 (Structural FFL stack and early S-series)

Written Saturday 31 October 2026 (Melbourne) by an independent read-only Opus reviewer, brief from CE 05 at CE 00's request.
Heads reviewed (read with gh and a read-only git fetch):
1. **#1933 B-107:** 8dcd66c5, branch claude/z1-ffl-source-preview, one commit on claude/rel-20261026s 204dfad2.
2. **#1934 B-108:** 85a7e636, branch claude/z2-ffl-group, stacked on #1933 (base is the #1933 branch).
3. **#1898 B-077:** 731349f5, branch claude/s2-footing-memory, on 204dfad2.
4. **#1899 B-078:** 1969701f, branch claude/s3-links-loads, on 204dfad2.
5. **#1900 B-081:** 7fd49669, branch claude/s5-cemember-names, on 204dfad2.
6. **#1901 B-080:** 468b252c, branch claude/bug616-xrl-confirm-31oct, on 204dfad2.

Nothing was built, tested, installed or opened in AutoCAD by this review. I read the code, the tests, the carpark entries, Tim's decisions 162 and 163 and the authors' reports, and ran read-only merge checks only. All six are **built and unit-tested only. Nobody has opened any of them in AutoCAD.** No bug here may be marked FIXED.

## FOR TIM

1. **#1933 FFL asks Manual or Unknown, then the mark follows the cursor: CHANGE-NEEDED (one line), Structural levels area plus start-up check.** It does what you said in item 162. One likely fault: if the drawing's UCS is not World, the mark may land away from the cursor. Most of your drafting is in World UCS, where it is fine. The fix is to delete one line.
2. **#1934 FFL triangle, tail and value move as one group: KEEP-WITH-NOTE, same train, straight after #1933.** It does what you said in item 163. It only works the normal way while PICKSTYLE is 1 (AutoCAD's default). If you want to nudge just the value text, hold Ctrl when you click it, or turn the switch off.
3. **#1898 footing-size memory per drawing, newer footing data kept: KEEP-WITH-NOTE, wider Structural area (footings, THCL, FST, beam links) plus start-up check.** Two small tidy-ups are listed below for the finaliser. It does not change anything you draw.
4. **#1899 copied beam starts with no links, reopened old drawings convert again, damaged point-load list kept: KEEP-WITH-NOTE, beams and links area plus start-up check.** One rule point: CSPOINTLOAD now refuses to place a load when the saved list is damaged. That is a hard stop, but the tool is hidden and off by default, and the carpark asked for this refusal.
5. **#1900 CEMEMBER no longer turns 114.3x6 into 114.3x6.4CHS: KEEP, CEMEMBER area plus start-up check.** I checked every name in the section list. No common name (310UB32, 200UC46, 89x89x3.5SHS and the rest) is broken by it.
6. **#1901 XRL says how many Xrefs will move and waits for Apply: CHANGE-NEEDED (one line), XRL area plus start-up check.** Risk: pressing Enter at "Apply or Cancel? <Apply>" may cancel instead of applying, the opposite of what the prompt shows. Other CE prompts already allow for this; this one does not.
7. **Merging:** all six merge cleanly onto the Structural train except the change-log file (REGRESSION_LOG.md), where every pair clashes. Keep both entries. The settings file merges by itself. #1933 must go in before #1934.
8. **Still not seen by anyone:** every one of these in AutoCAD, including Undo and REDO, save and reopen, and the FFL preview and grouping. Each switch is still only in the settings file. Decision 126 (the new Switches tab) covers where they go, so you are not being asked again.

---

## DETAIL

### #1933 B-107, BUG-626: FFL level source (Manual or Unknown) and live preview

**1. What changes for the drafter**
1. **With the switch ON (the default):** typing FFL now asks "Level source [Manual/Unknown] <Manual>:" first.
   - **Manual or Enter:** asks "Level value (e.g. +150, RL42.350, -50):". An empty answer stops with nothing drawn, as before.
   - **Unknown:** asks nothing more and writes the plain word "Unknown" (`Core/Symbols/FflSourcePreviewRule.cs` 30, 48-53).
2. **Placing:** the whole mark (triangle, tail and value) then follows the cursor. F flips the side, a click places it, and Escape or Enter draws nothing (`Commands/LevelMarkSourceFlow.cs` 61-70 and the jig 160-195).
3. **What is drawn:** the same three objects as before, on 25DIMS and 25TEXT, at the same sizes. These are 5, 10, 1.25 and 2 times DIMSCALE, the same as the old `CreateLevelSymbol` and `GetTailStart`; I compared them line by line (`FflSourcePreviewRule.cs` 92-115 against `LevelMarkCommands.cs` 306-329).
4. **Small difference:** the tail and text are now placed at height Z = 0. The old code used the picked point's Z. This only matters if someone snaps to a 3D point, and the triangle was already at Z = 0.
5. **RL, SSL and NGL are untouched:** the branch tests `type == LevelMarkType.FFL` (`LevelMarkCommands.cs` 161).
6. **Matches Tim's decision 162 ("2yes"):** "ship Manual and Unknown only, with preview, F to flip and click to place; real level sources later." Yes, exactly. The carpark's "confirm the value" step is the value prompt itself; there is no separate confirmation step. That is acceptable for Manual.

**2. Settings switch**
1. `Annotation.FflOffersSourceAndPreview`, default true (`Models/UserSettings.cs` 355).
2. **Pinned:** in `new UserSettings()` and through `DeserializeSettingsTolerant` on "{}", on an old file without the key, and on a typed false (`Bug626FflSourcePreviewTests.SwitchDefault_IsOn_ThroughBothStartUpReads_AndATypedOffStays`). Structural has only the tolerant start-up read, so "both reads" here means the new object plus the tolerant read. That is the same as the other Structural switches.
3. **OFF:** `RunDirect` falls through to the untouched old prompts (point, side, value, draw), so the old behaviour returns exactly. A source guard pins the old prompt text and the branch position.
4. **R-00:** no new engineering value. The sizes and the layer names 25DIMS and 25TEXT are pre-existing hard-coded values. They now live in two places: the old path, and `Compute` for the new path. When they move to Settings, both copies must change. Not a blocker.
5. **Settings page:** the switch is in the file only, with no row on the Settings page. It goes on the Switches tab (decision 126).

**3. No-hard-blocks (R-27)**
1. **Locked 25DIMS or 25TEXT:** stops with one line, as before (`LevelMarkSourceFlow.cs` 33-39). It now stops before any question, which is better.
2. **REFEDIT open:** stops, as before (`LevelMarkCommands.cs` 156). Both stops come from the native-protection rule, not new blocks. No modal window.

**4. Native protection and REDO**
1. CE never unlocks anything (pinned by a test), touches no Xref and adds no system-variable change.
2. Nothing is written until the click; the transaction starts after `ed.Drag` (pinned).
3. One undo mark wraps the three objects, as before. No view change and no regen.

**5. FINDING A (CHANGE-NEEDED, small): the point may be converted twice in a non-World UCS**
1. **Where:** the jig takes the point from `prompts.AcquirePoint` and then calls `LegacyToolCommon.ToWcs(_ed, res.Value)` (`LevelMarkSourceFlow.cs` 176).
2. **Why it is likely wrong:** a jig's AcquirePoint already returns world coordinates. Every other jig in Structural uses `res.Value` directly: `BeamService.cs` 1174-1183, `MLeaderCalloutService.cs` 402, `ConnectedGripJig.cs` 92-101 and `FoundationService.Grips.cs` 472. The old FFL used `ed.GetPoint`, which returns UCS points, so its `ToWcs` was right.
3. **What a drafter would see:** with a rotated or moved UCS, both the preview and the placed mark sit away from the cursor. In World UCS there is no difference.
4. **Fix:** use `res.Value` as it is (delete the `ToWcs` call). I have not verified this in AutoCAD, so the robot case below includes a UCS step.

**6. Tests**
1. **11 tests. Real ones:** source parsing, Unknown never giving 0 or blank, the layout numbers against the old geometry, the flip, and the drag outcome.
2. **Source guards:** these fail correctly if the switch branch moves after the old prompts, or if the lock check moves after the questions.
3. **Gap:** nothing tests the UCS conversion (finding A).
4. **%APPDATA%:** the author's environment pointed to C:\CE_WORK\scratch\z1. The tests are pure (in-memory JSON and source text). I did not check the real folders myself.

**7. Robot (CE 02) and Codex**
1. **Robot N107_ffl_source:** on a drawing copy, type FFL, then Enter, then 12.345. Move the cursor, press F, then click.
   - Read back one closed polyline on 25DIMS, one line on 25DIMS and DBText "12.345" on 25TEXT on the left side.
   - Then U (all three gone), wait, and REDO (all three back).
2. **Unknown case:** FFL, U (for Unknown), click. Expect the text "Unknown".
3. **Escape case:** at the preview, Escape. Expect nothing new.
4. **UCS case:** UCS Z 30, then FFL at a known snapped point. Read back the triangle tip equal to the snapped point in world coordinates. This proves or disproves finding A.
5. **Control:** set `Annotation.FflOffersSourceAndPreview` false before launch. Expect the old point, side and value prompts.
6. **Codex look:** the preview following the cursor, the flip, and the text being readable at DIMSCALE 100.

**8. Verdict:** CHANGE-NEEDED: remove `ToWcs` in the jig sampler (line 176), and add one guard test that the sampler does not convert. Train: Structural levels area plus the start-up smoke (decision 161). The `LoadRecovery.cs` edit is one label line only.

---

### #1934 B-108, BUG-627: FFL triangle, tail and value as one AutoCAD group

**1. What changes**
1. Both FFL paths (new flow `LevelMarkSourceFlow.cs` 97; old flow `LevelMarkCommands.cs` 259) put the three objects into one anonymous, selectable group, in the same transaction (`Commands/LevelMarkGrouping.cs` 22-31: `new Group("CE level mark", true)`, `SetAt("*")`).
2. MOVE, COPY and ERASE on any piece then take all three. Each placement makes its own group. Marks already in a drawing are not changed, and RL, SSL and NGL are not grouped.
3. **Matches decision 163 ("3yes"):** "move as one normal AutoCAD group, behind a Settings switch ON by default." Yes.

**2. Settings switch**
1. `Annotation.LevelMarkGroupsComponents`, default true (`UserSettings.cs` 358). It is pinned through the new object and the tolerant read, including an old file carrying only the #1933 key, and a typed false.
2. **OFF:** `Apply` never calls the group-maker, so the result is three loose objects exactly as before. No R-00 value.

**3. R-27:** adds no stop, refusal or window.

**4. Native protection and REDO**
1. **New write:** one group object in the drawing's group dictionary, inside the same undo mark and transaction. No layer is touched.
2. **REDO:** a U then REDO of the group is a native operation and should be safe. It is not proven, so the robot must check it.
3. **PICKSTYLE:** the group only selects as one when PICKSTYLE is 1 or 3. BUG-627 recorded PICKSTYLE 1 on Tim's PC. Drafters who run PICKSTYLE 0 will see no change.
4. **Workflow note:** to nudge only the value text, hold Ctrl while clicking it, or turn the switch off.

**5. Tests**
1. **6 tests.** They test the rule (when a group is made and what goes in it) with a fake group-maker. They are real but thin.
2. **Gap:** no test checks that both FFL paths actually call `GroupIfOn`. If a later edit drops one call, every test stays green. Add one source guard (finding, small, not blocking).
3. **%APPDATA%:** scratch environment C:\CE_WORK\scratch\z2, per the author. I did not check this myself.

**6. Robot and Codex**
1. **Robot N108_ffl_group:** after N107, run MOVE, pick the triangle only and move it 1000 right. Read back all three objects shifted by 1000.
2. **Undo, REDO and reopen:** U restores them; REDO moves them again; GROUP or a list read shows one group with three members; save, reopen and repeat MOVE.
3. **COPY case:** COPY one piece. Expect six objects and two groups.
4. **Control:** switch false before launch. Expect the triangle to move alone, as in BUG-627.
5. **Record PICKSTYLE** in the log.

**7. Verdict:** KEEP-WITH-NOTE (add the source-guard test that both paths call `GroupIfOn`). Same train as #1933, merged straight after it. Structural levels area plus the start-up smoke.

---

### #1898 B-077, BUG-1146, BUG-1147, BUG-1159: footing-size memory, newer data, unreadable entries

**1. What changes**
1. **BUG-1146:** THCL and FST's remembered size list is now kept per open drawing, by the same drawing identity the footing register already uses (`CeTextService.cs` 5576-5583, `FstMemoryCacheKey.cs`). It is forgotten on open, close, U, UNDO and REDO (`FoundationRegistryService.cs` 122 and 157-160).
   - Two new drawings from one template no longer share sizes, which matches the carpark's expected fix.
2. **BUG-1147, footing register:** a register whose SchemaVersion is above 2 is not saved over. CE writes one command-line line and carries on (`FoundationRegistryService.cs` 74-79).
3. **BUG-1147, size library:** a library whose stored SCHEMA_VERSION is above this build's is left alone, with one line (`FstMemoryService.cs` 107-112).
4. **BUG-1147, unknown fields:** fields this build does not know are kept on save, on the register, system, element and beam-link records (`[JsonExtensionData]`, `FoundationUnknownFields.cs`). This matches "catch-all for unknown fields, and refuse to save over a newer version".
5. **BUG-1159:** a stored size entry CE cannot read is written back exactly as stored, after the readable ones. A list holding only such entries is not erased (`FstMemoryService.cs` 437-446 and `SerializeList`).
   - The carpark asked "do not rewrite that list". Keeping the odd entries while still saving the drafter's new size is better, because nothing is lost and the new size is not refused.
6. **Drawing output:** nothing changes on the drawing.

**2. Settings switches**
1. `FootingWidth.FootingSizeMemoryKeyedByDrawing`, `FootingDataKeepsNewerVersions` and `FootingSizeListKeepsUnreadableEntries`, all default true (`UserSettings.cs` 1402-1408).
2. **Pinned** through the new object, "{}", an old file and a typed false.
3. **OFF restores the old behaviour:** the file-name key (the same fallbacks, "DB_" plus fingerprint, then "DB_FALLBACK"), the old serialiser (the extension data is stripped by a resolver), and odd entries dropped. "OFF gives the old bytes" is tested.
4. **No R-00 value.** All three are file-only; they go on the Switches tab (decision 126).

**3. R-27**
1. Neither refusal stops the drafter's command, so neither is a hard block in the R-27 sense. CE only declines to overwrite the newer record and says so.
2. **Side effect to record:** in a drawing saved by a newer build, footing commands still draw and erase outlines, but the register is not updated. The register then no longer matches the drawing until the newer build is used again. That is the lesser evil compared with stripping the newer data, and it only happens when an older build opens a newer drawing.

**4. Native protection and REDO**
1. No entity, layer, view or system variable is touched. The writes are the same named-dictionary records as before; the refusal path aborts its own transaction.
2. Forgetting the memory after U, UNDO and REDO is memory only. It helps BUG-1199 (RD18-01) rather than harming REDO.

**5. Findings (small, for the finaliser)**
1. **B1:** `SaveFstData` (`CeTextService.cs` 5563-5579) stores the new list in memory even when `FstMemoryService.Save` refused it.
   - **Effect:** in the newer-build drawing, THCL then offers a size for the rest of the session that is not in the drawing.
   - **Fix:** cache only when Save returns true.
2. **B2:** this build's register version is written twice, as the constant 2 (`FoundationUnknownFields.cs` 18) and the default 2 (`FoundationModels.cs` 245).
   - **Risk:** if a future build raises one and not the other, it will refuse to save its own registers.
   - **Fix:** add a test that the two are equal.
3. **B3:** the "byte-for-byte as before" tests compare the new serialiser with `JsonConvert` on the new classes, not against output from the old build. The comparison is still valid because an empty extension dictionary writes nothing, but it would not catch a field rename.
4. **One PR for three bugs:** keep it as one. They share the same files and one B number.

**6. Tests**
1. 28 new tests. They are real: the key rules, odd-entry finding including a quoted bracket, idempotent re-save, the newer-version rules, unknown fields surviving `Clone`, and OFF behaviour.
2. The re-pinned `Stage3B2bWriterBoundaryTests` text is labelled and dated, which is acceptable.
3. **Real folders:** the author compared real folders before and after. No settings file changed; log files changed while an accoreconsole ran. I did not repeat the check.

**7. Robot and Codex**
1. **Robot N077_fst_two_drawings:** QNEW twice from the office template. In Drawing1, THCL 81 = 600x600. In Drawing2, THCL 81 must ask for a size, not reuse 600x600. Back in Drawing1, it is still 600x600.
2. **Undo case:** U in Drawing1, then THCL reads the drawing again.
3. **Newer-build case:** use a drawing copy whose footing register SchemaVersion is set to 3 and whose FST SCHEMA_VERSION is set to 4 (made by a headless writer). Run FST on a pad. Expect the "newer CE build" line, and the register text unchanged byte for byte.
4. **Odd-entry case:** a copy with one hand-made odd entry in the PF list. Add a size, then read the list. The odd entry must still be there.
5. **No Codex look needed.**

**8. Verdict:** KEEP-WITH-NOTE (B1 and B2 are small and can go in the finaliser). Train: Structural footings, THCL, FST and beam-link save area plus the start-up smoke. This is wider than one tool, because the register and beam-link writers serve many commands.

---

### #1899 B-078, BUG-1139, BUG-1204, BUG-1162: copied beam links, discarded first open, damaged point loads

**1. What changes**
1. **BUG-1139:** when a beam carries a link record naming a different beam (it was made by COPY), RegisterBeam now starts it with an empty record of its own. Before, it took over the original's label and columns (`BeamLinkService.cs` 82-111). This matches "treat a record whose stored owner is a different beam as a copy and start it empty".
   - It agrees with the existing clone handling in `BeamLinkService.AttachmentUpdates.cs` 316-329, which already clears such records.
2. **BUG-1204:** the "already converted" note is now cleared when the drawing closes (`DocumentDestroyed`) and when a conversion fails (`LinkMigrationService.cs` 62-85 and 135). An old drawing closed without saving converts again on reopen. This matches the carpark's expected fix.
3. **BUG-1162:** CSPOINTLOAD refuses to place a load when any saved group cannot be read. It says how many, that nothing was changed, and to restore the last good save (`PointLoadMarkerService.cs` 166-167, `RoofPointLoadMarkers.cs` 163-171). The carpark expected "refuse to save when any group was skipped".

**2. Settings switches**
1. `Beams.CopiedBeamStartsWithEmptyLinks`, `Beams.LinkMigrationRetriedAfterDiscardedOpen` and `RoofPointLoad.RefuseWhenAGroupIsDamaged`, all true (`UserSettings.cs` 535, 540 and 1604).
2. **Pinned** through both reads: the new object and the tolerant read on blank, old-line, bad-value and typed files.
3. **OFF:** each OFF returns the old code path exactly (tested per bug).
4. **No R-00 value.**

**3. R-27**
1. **The BUG-1162 refusal is a hard stop**, outside the two allowed hard blocks.
2. **Mitigations:** it follows the existing "newer build" refusal in the same method, which was already there; the carpark asked for a refusal; and CSPOINTLOAD is hidden and off by default (`MarkerEnabled` false). Practical effect: nil for the pilot.
3. **Warn-not-block alternative for later:** place the load, number it above every tag in the damaged text, and write the damaged groups back unchanged, the way #1898 does for odd size entries. Record this in the regression entry as the R-27 exception and its reason; no rework now.

**4. Native protection and REDO**
1. No layer, view or system variable changes.
2. **BUG-1139:** writes the same beam record as before, in the same transaction.
3. **BUG-1204:** memory only.
4. **BUG-1162:** the refusal happens before any write.

**5. Not proven**
1. **BUG-1204 depends on a name match:** it needs `DocumentDestroyedEventArgs.FileName` to equal `doc.Name`. If they differ in AutoCAD, nothing is forgotten, which is exactly the old behaviour. So it fails safe, but the fix would then do nothing.
2. **BUG-1139:** that a native COPY really leaves the copied record for RegisterBeam to find. The author says so too.

**6. Tests**
1. 13 new tests plus the defaults tests, and they are real.
2. The re-pinned fingerprint in `Stage3ConnectedDesignBoundaryTests` is labelled and dated.
3. **Real folders:** the author's comparison showed log and telemetry changes, but no settings change. I did not repeat it.

**7. Robot**
1. **N078_copy_beam:** beam B3 with a column at each end and a label. COPY B3 to the next bay, then place a column under the copy's end. Read back the copy's link record: owner is the copy, and there is one attachment, the new column. B3's record is unchanged. MOVE the copy: B3's label does not move. Then U and REDO.
2. **N078_reopen:** open an old pre-link drawing copy (the RD19-03 fixture) and close without saving. Reopen in the same session, MOVE the line, and LABEL-A follows.
3. **CSPOINTLOAD:** only if MarkerEnabled is set on a test copy before launch; a damaged-group fixture shows the refusal line and the record unchanged.
4. **Controls:** each switch false before launch.

**8. Verdict:** KEEP-WITH-NOTE (record the BUG-1162 R-27 exception and the warn-not-block alternative). Train: Structural beams, links and roof point loads area plus the start-up smoke.

---

### #1900 B-081, BUG-1121: CEMEMBER section-name prefix stops at a decimal point

**1. What changes**
1. Typing 114.3x6, 168.3x6, 60.3x4 or 89x89x3 at "Section name" now gives "no section called ... Type the full name." Before, it silently took the 6.4, 6.4, 4.5 or 3.5 wall.
2. 114.3x6.4, 114.3x6.4chs and 310UB3 (giving 310UB32) still work (`CeMemberPrompts.cs` 114).
3. **Section list check:** I read the shipped list, `Assets/Config/section-catalogue.json`, 372 names. Every name with a decimal is a hollow section's wall, such as 89x89x3.5SHS or 250x150x6.3RHS. There is no "310UB32.0"-style name, so the common short names (310UB32, 200UC46, 380PFC) are unaffected.
4. **Carpark note:** the carpark says "never a digit or decimal point" but also "310UB3 still finds 310UB32", which is a digit. The PR follows the example, so the digit half is not built. Typing 250x250x1 would still pick 250x250x12.5SHS if it were the only match. That is low risk, and the carpark contradicts itself, so no change is needed.

**2. Settings switch**
1. `CeMember.SectionNamePrefixStopsAtDecimalPoint`, true (`UserSettings.cs` 932). It is read in the command (`CeMemberCommands.cs` 385).
2. **Pinned:** new object, blank file, old file, damaged file and typed false.
3. **OFF:** tested to return the 6.4 wall as before.
4. `FindByName` has only one caller, so the method's default of true changes nothing elsewhere. No R-00 value.

**3. R-27:** no new stop. The prompt simply asks again, as it already did for an unknown name.

**4. Native protection and REDO:** no drawing write is added.

**5. Tests**
1. Two new tests. They fail before the change: on the old code, 114.3x6 returns one match where the test expects zero.
2. Four defaults tests.
3. **%APPDATA%:** the tests are pure, and the author's real-folder comparison is in the report.

**6. Robot**
1. **N081_cemember_names:** type CEMEMBER, then 114.3x6. Expect the line "no section called" and the prompt again. Then type 114.3x6.4 and draw.
2. **Short-name check:** CEMEMBER, then 310UB3. Expect it to draw 310UB32.
3. **Control:** switch false before launch. Expect 114.3x6 to draw 114.3x6.4CHS.

**7. Verdict:** KEEP. Train: Structural CEMEMBER area plus the start-up smoke.

---

### #1901 B-080, BUG-616: XRL counts, highlights and waits for Apply

**1. What changes**
1. After the counts and the locked-layer check, XRL highlights every Xref instance and asks "N Xref instances will move to layer XREF. Apply or Cancel? [Apply/Cancel] <Apply>:" (`NativeXrefLayerService.cs` 70 and 131-157).
2. **Cancel or Escape:** moves nothing, does not create the XREF layer, and writes "Cancelled. Nothing was changed."
3. **Highlight:** screen only, and always removed (in a finally block).
4. **Fast and silent modes:** XRLFAST and XRLSILENT never ask.
5. **Matches the carpark:** count and highlight first, explicit Apply, Escape makes no change.

**2. Settings switch**
1. `XrefLayer.ConfirmBeforeMove`, true (`UserSettings.cs` 1024).
2. **Pinned:** new object and tolerant read (blank, old, damaged and typed).
3. **OFF:** `ShouldAsk` is false, so the old path is unchanged. No R-00 value. The `LoadRecovery.cs` edit is one label line.

**3. R-27:** the question is the approved ST5-11 review step, with Apply as the default. It is not a block.

**4. Native protection and REDO**
1. Asked after the BUG-617 locked-layer refusal and before the layer is created. Nothing is unlocked (pinned by a test).
2. The highlight does not write to the drawing. One undo mark, as before.
3. No view, regen or system-variable change.

**5. FINDING C (CHANGE-NEEDED, one line): Enter may cancel**
1. **The code:** `apply = answer.Status == PromptStatus.OK && ...` (line 150), with `AllowNone = true` (line 148).
2. **Why it is a risk:** with AllowNone on, AutoCAD can return "None" when Enter is pressed. CE's own code treats that as the default answer: `BeamLinkService.CascadeErase.cs` 538, `ReoBarService.cs` 822 and the CEMEMBER view prompt. If AutoCAD returns None here, Enter cancels XRL, the reverse of what the prompt shows and of what the report claims.
3. **Fix:** treat None as Apply (`answer.Status == PromptStatus.None || (OK && not Cancel)`), plus a source guard.
4. I have not verified which status AutoCAD returns here. The robot case decides it, but the fix is safe either way.

**6. Small wording note:** N counts every Xref instance, including ones already on XREF. So "will move" can overstate; "N Xref instances will be put on layer XREF" would be exact. Optional.

**7. Tests**
1. Rule, wording and source-order guards, and they are real.
2. **Gap:** nothing pins how the Apply answer is read (finding C).
3. **%APPDATA%:** the author's comparison shows no settings change.

**8. Robot and Codex**
1. **N32_xrl_apply (the author's design):** a drawing copy with one DWG attached twice. Type XRL then Escape: the cancel line shows, the layers are unchanged, and there is no XREF layer.
2. **Enter case (NEW):** type XRL, then press Enter only (not "A"). Both instances must be on XREF.
3. **Undo and reopen:** U restores both, wait, REDO; save and reopen.
4. **Control:** switch false before launch. Expect no question.
5. **Codex look:** the highlight is visible and is removed after the answer.

**9. Verdict:** CHANGE-NEEDED: accept Enter (None) as Apply, and add a guard. Train: Structural XRL area plus the start-up smoke (decision 161; the LoadRecovery edit is a label only).

---

### Merge check (read-only git merge-tree)

1. **Against claude/rel-20261026s (204dfad2, the Structural train):** every PR merges with no conflict. All five base branches sit exactly on 204dfad2, so none is behind.
2. **Pairwise between #1933, #1898, #1899, #1900 and #1901, and #1934 against the four S-series PRs:** the only conflict is `REGRESSION_LOG.md`, because every PR adds an entry at the top. Keep both entries.
   - `UserSettings.cs` merges by itself in every pair: different classes and lines (Annotation 355-358, Beams 535-540, CeMember 932, XrefLayer 1024, FootingWidth 1402-1408, RoofPointLoad 1604).
   - `SettingsService.LoadRecovery.cs` (#1933, #1934, #1901) also merges by itself.
3. **Stacking:** #1934's base is #1933's branch, and #1934 adds lines after #1933's lines in `LevelMarkSourceFlow.cs`. The order #1933 then #1934 is right. If #1933 changes for finding A, rebase #1934 on top or merge it forward with both sides kept.
4. **claude/rel-20261102a (Civil):** not a target for these. It does not contain 204dfad2, and 350 Structural files differ between the lines, so a merge there would show unrelated conflicts. I did not treat that as a finding.
5. **Other open Structural PRs on the same base** (#1895, #1902-#1916 and others) were not checked line by line. The authors expect only UserSettings.cs and REGRESSION_LOG.md overlaps there, and I did not verify that.

### What this review could NOT verify

1. Anything in AutoCAD: findings A and C are reasoned from the code and from CE's own patterns, not observed.
2. The real %APPDATA% folders: I took the authors' before-and-after comparisons on trust.
3. The full Structural suite, the net48 tests and the net8 lane: the authors ran filtered test sets only. Each reports 0 errors on the net48 compile.
4. Line-by-line clashes with the other open S-series PRs.
