# Structural bug hunt: bracing, lintels, reo, marks, schedules, sheets (written 19 Oct 2026)

Helper: headless HUNT job (desk plan/03, Team usage governor). Read-only code audit, Opus. Written Mon 19 Oct 2026, Melbourne time. The file name keeps the date the job was planned (12 Oct).

**What was read:** the INSTALLED Structural, **1.0.118 at commit 9a8e5d4e** (`origin/claude/rel-20261017s`). This was checked against the DLL product version in `%APPDATA%\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle` (Legacy, Modern and Net8 all say `1.0.118+9a8e5d4e`). Installed Civil is 3.0.56 at 21462f9c (`rel-20261019a`). The Structural copy inside that Civil branch is an old 1.0.42 snapshot, so it was not used. The code was read in a detached worktree at `C:\ce-hunt\struc-brace`, which has since been removed. Nothing was built or run, and nothing was opened in AutoCAD.

**How it was done:** four read-only auditors each took one area: bracing; lintels and steel schedules; reo, marks and units; drawing sheets and Publish Issue. Each was given the list of known findings to skip. I re-read the code for every item marked CONFIRMED below, apart from those marked "auditor's trace".

**Already known, so NOT repeated:**
- Every finding in HUNT_STRUC, HUNT2_STRUC, HUNT_STRUC_FRAMING, R00_STRUC and HUNT3_CROSS.
- The carpark entries on CSREOBAR (double default, frozen layer, Undo step), ABSWITCH eOnLockedLayer, BUG-818/819, and BUG-051/055.
- Where a finding below is a new trigger or a new result of a known one, it says so.

**Severity:** HIGH = wrong output on a drawing, data loss, crash, or refuses real work. **Confidence:** CONFIRMED = read end to end in the code. PLAUSIBLE = depends on something at run time that could not be read (block contents, AutoCAD behaviour).

---

## FOR TIM: the 10 worst, in plain English

1. **Publish Issue sends out PDFs with the OLD revision on the title block.**
   - Example: you type D in Publish Issue. The folder says REV D and the register says D, but every PDF title block still says C.
   - Why: Publish never writes the new revision into the drawings before plotting. Only "Update Drawings" does that.
2. **Clicking into the "Structural Rev" box and out again changes every Structural sheet's revision.**
   - You don't need to type anything. Six sheets at B and one at C all become B.
   - On a 3 and 3 tie, the whole set drops back to the earlier letter.
3. **Renumber Sheets, then Update Drawings, renames only some tabs. Publish then stops with "Layout 'S05' was not found".**
   - Example: you add a sheet and shuffle S03 to S05 up by one. Only the last tab gets renamed.
   - The register then calls a sheet S04 while its tab and title block still say S03.
4. **On a job with more than one drawing file, the CESHEETS list starts out of order. Renumber Sheets then gives sheets the wrong numbers.**
   - Example: S01 to S03 in one DWG and S04 to S05 in another show as S01, S04, S02, S05, S03.
   - Press Renumber and the old S04 becomes S02.
5. **STRSCHEDSYNC can swing a brace off its wall when nothing was edited.**
   - Example: a brace turned with AutoCAD ROTATE gets turned a second time when you sync the bracing schedule.
6. **The bracing panel and schedule ignore AutoCAD ROTATE on a brace.**
   - Example: copy a North-South brace and rotate the copy to brace an East-West wall. It still counts as North-South, so you see N-S 4800 and E-W 0 instead of 2400 and 2400.
7. **FPFC "Increment" can reuse an old mark and its old size without asking.**
   - Example: you have PF1 at 600, PF2 at 900 and PF3 at 1200, then erase PF2. The next new pad becomes "PF2" at 900 x 900, with no size question.
   - A typed BPF1 increments to a plain "PF" mark.
8. **A drawing with an A1 tab and A3 tabs plots the A1 tab on A3 paper**, when the drawing's "CE TO PDF" page setup is set to A3. The setup's paper size is used for every tab.
9. **The typed STR (stirrup) command draws a stirrup with a sloping top bar and a square notch instead of a 135° hook.**
   - Example: on a 300 x 500 section the top bar runs on a slope from x 30 to x 210.
   - STR is hidden from the ribbon but still works when typed. Your locked rule says STR was deleted permanently, so it should not be typeable at all.
10. **STRSCHEDSYNC shows AutoCAD's crash box if a brace in the table was erased, or its layer is locked.** Nothing gets synced.

**One thing for you to settle (not a bug):** the Engineering Rulebook still says "AB bracing capped 2700 mm". Your later answer (INT-066 C, 28 Sep: "B & C as recommended", meaning "keep the drawn length and warn") replaced that, and the code follows INT-066. The rulebook line is stale and should be marked superseded. BB now gives the same "over 2700" warning as AB (BUG-428). The rulebook says "BB/BT1 not capped". Please confirm a warning on BB is what you want.

**Not tested:** none of this was seen in AutoCAD. Every item needs a check on a copy, by Codex or by you.

---

## Findings, most serious first

### SHEETS-01. Publish Issue never writes the new revision (or issue date) into the drawings, so the PDFs show the old revision (HIGH)
- **File:**
  - `Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml.cs:507-562`. `PublishFromChoiceAsync` calls `ApplyIssueRevision`, then `TryCreateIssue`, then `CeSheetsIssueService.PublishIssue` straight away. There is no title-block write in between.
  - `Services/CeSheetsIssueService.cs:256-300` (`PublishIssueCore`) plots the saved DWG.
  - `Services/CeTitleBlockWriter.cs:38-43`: "its visible values are AutoCAD fields bound to DWGPROPS custom properties … The issue date is a SaveDate field and is left alone."
  - Only Update Drawings (`CeSheetsUpdateService`) writes DWGPROPS.
  - The window's only pre-publish warning is about unsaved open drawings (`CeSheetsWindow.xaml.cs:486-499`).
- **Steps:** sheets at rev C, then CESHEETS → Publish Issue, type D → Publish. Do not press Update Drawings first.
- **Wrong:** the folder is `…STR REV D` and the register and job file say D. Every PDF title block says C. The date on the sheet is the drawing's last-saved date, not the issue date.
- **Right:** before plotting, Publish writes the issue revision (and an issue-date property) into each issued sheet, or refuses with "Update Drawings first".
- **Confidence:** CONFIRMED for the revision. PLAUSIBLE for the date, which depends on the title block's field codes.
- **Fix:** have Publish run the same DWGPROPS write as Update Drawings on the issued sheets before plotting, and stop if that write fails.
- **Unit test RED:** no (needs AutoCAD). A source guard can pin "Publish calls the writer".

### SHEETS-02. Leaving the "Structural Rev" box re-stamps every sheet of the discipline, with no typing (HIGH)
- **Relation to known:** a new trigger, separate from HUNT2-S-01. No Publish is needed, and it ignores `IssueStampsOnlyIncludedSheets`.
- **File:** `UI/Dialogs/CeSheetsWindow.xaml.cs`.
  - Lines 230-238: the box is pre-filled with `MostCommonRevision(...)` and has `box.LostFocus += DisciplineRev_LostFocus;`.
  - Lines 247-257: a tie goes to the alphabetically first revision (`.ThenBy(g => g.Key)`).
  - Lines 262-270 and 290-295: `foreach (CeSheetEntry sheet in SheetsOfDiscipline(discipline)) sheet.CurrentRevision = trimmed;`
- **Steps:** S01 to S06 are at B and S07 is at C. Open CESHEETS, click or Tab into "Structural Rev", then click elsewhere.
- **Wrong:** S07 drops back to B in the grid and in the job file, including sheets left out of the issue. The next Update Drawings or Publish uses B. With 3 sheets at A and 3 at B, everything becomes A.
- **Right:** leaving the box without changing it does nothing. A typed value touches only the sheets in the issue.
- **Confidence:** CONFIRMED.
- **Fix:** apply only if the text changed, only to `SheetsToStampWithRevision`, and break ties towards the latest revision.
- **Unit test RED:** the tie rule, yes (pure). The focus behaviour, no.

### SHEETS-03. Update Drawings tab renames collide; Publish then throws "Layout 'S05' was not found" (HIGH)
- **File:**
  - `Services/CeSheetsUpdateService.cs:195-219` builds the rename list and never updates `sheet.LayoutName` afterwards. The older sync did: `CeSheetsSyncService.cs:316` `sheet.LayoutName = sheet.LayoutTabName;`.
  - `Services/CeTitleBlockWriter.cs:182-186`: `if (existingNames.Contains(newName)) { warnings.Add(...already exists...); continue; }`
  - `Services/CeSheetsPdfPublisher.cs:214-216` throws when the recorded layout name is missing.
- **Steps:** one DWG has tabs S01 to S05. Add or move a sheet so S03→S04, S04→S05 and S05→S06. Then Renumber Sheets → Update Drawings → Publish Issue in the same window.
- **Wrong:**
  - S03→S04 and S04→S05 are skipped because those names exist at that moment. Only S05→S06 is renamed.
  - The register says S04 for the tab still called S03.
  - Publish asks for "S05", which is now S06, and throws part-way. By then the revision and date are already stamped and an empty issue folder has been made.
  - Swapping S01 and S02 renames nothing.
- **Right:** rename in two passes through temporary names, record the new layout name, and rescan before Publish.
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** yes for the rename ordering, if it is moved into a pure planner.

### SHEETS-04. Multi-DWG jobs start with the sheet list scrambled; Renumber Sheets writes wrong numbers (HIGH)
- **File:**
  - `Services/CeSheetsScannerService.cs:616-624`: `SheetOrder = layout.TabOrder`, which restarts at 1 in every DWG.
  - Lines 227-238 only fill an order when it is 0 or less, so the clashes stay.
  - `CeSheetsManifestService.cs:135` keeps the earlier order.
  - `UI/Dialogs/CeSheetsWindow.xaml.cs:352-354` orders by `SheetOrder`, then by plain text (S10 before S2).
  - Lines 691-697 renumber in that order.
- **Steps:**
  - (a) DWG A holds S01 to S03 and DWG B holds S04 and S05. The grid reads S01, S04, S02, S05, S03. Renumber Sheets, then Update Drawings: the old S04 becomes S02.
  - (b) One sheet per DWG, S1 to S12. The list reads S1, S10, S11, S12, S2… and Renumber turns S10 into S02.
- **Right:** one job-wide order in natural sheet-number order.
- **Confidence:** CONFIRMED.
- **Fix:** after the scan, number every sheet 1..n job-wide using the existing `NaturalSheetNumberComparer` (`CeSheetsPublishPlanner`).
- **Unit test RED:** yes (pure ordering).

### BRACE-01. STRSCHEDSYNC turns a ROTATEd brace a second time, off its wall (HIGH)
- **File:**
  - `Services/BracingService.cs:1677-1707`: AB, BB and BT1 insert the block at `Rotation = 0.0` and set the block's own ROTATION parameter.
  - `Services/ProjectDataService.cs:322-326`: `double rotation = GetDynamicDouble(br, new[] { "ROTATION", ... }); if (Math.Abs(rotation) < 0.0001) rotation = br.Rotation;`
  - `Services/ScheduleService.cs:750-753` writes that value back into the ROTATION parameter on every row, edited or not: `SetDynamicValue(br, new[] { "ROTATION", "ROTATION_A", "ROTATION_B" }, rotRad);`
- **Steps:** AB a brace left to right (parameter 0). ROTATE it 90° (the block rotation is now 90). STRSCHEDCREATE (the row shows 90). STRSCHEDSYNC, pick the table, with no edits.
- **Wrong:** the parameter becomes 90 on top of the block's 90. The brace now points 180°, back along the wall the wrong way, and its far end is off the wall.
- **Right:** a sync with no edits changes nothing, and the angle written is the true angle.
- **Confidence:** CONFIRMED.
- **Fix:** write back only the cells the drafter changed. Treat the angle as block rotation plus parameter, and write the difference.
- **Unit test RED:** no.

### BRACE-02. The bracing panel and schedule ignore AutoCAD ROTATE on a brace (MEDIUM-HIGH)
- **Relation to known:** HUNT2-S-10 is about which axis counts as North-South. This is different: the rotation is not read at all.
- **File:** `Services/ProjectDataService.cs:322-326`, as above. The block rotation is used only when the parameter is exactly 0.
- **Steps:** AB a 2400 brace bottom to top (parameter 90). COPY it, ROTATE the copy 90° onto an East-West wall, then CSBRACINGPANEL.
- **Wrong:** N-S 4800, E-W 0.
- **Right:** N-S 2400, E-W 2400.
- **Also:** rotating a whole plan 90° flips the 0° braces but leaves the 90°, 180° and 270° braces counted as before, so the totals come out mixed. The schedule ROTATION column shows the parameter, not the angle on the sheet.
- **Confidence:** CONFIRMED.
- **Fix:** angle = block rotation + parameter, allowing for mirroring.
- **Unit test RED:** yes once the angle sum is a Core helper.

### MARK-03. FPFC / FSF / FTHC / REB / RIB "Increment" fills gaps, so a new pad silently takes a deleted pad's size; band marks lose their B (HIGH)
- **Relation to known:** HUNT-S-01 is the size taken from the typed mark. This is a different trigger (gap reuse) with the same kind of result. MARK-02 is CSMARKSRENUMBER; this is the placing commands.
- **File:**
  - `Services/FoundationService.cs:4118-4130`: `for (int i = 1; i <= 999; i++) { string candidate = prefix + i.ToString(); if (!allLabels.Contains(candidate)) return candidate; }`
  - Then `TryGetOrPromptRectSize` at 4143-4149 returns the remembered size without asking.
  - The size memory is never purged.
  - The prefix is fixed at "PF" (lines 1102-1116), so a typed BPF loses its B.
- **Steps:** FPFC PF1 at 600, PF2 at 900, PF3 at 1200. ERASE PF2. FPFC, Enter at `<PF3>`, Enter at "Use anyway? [Yes/No/Increment] <Increment>".
- **Wrong:** "Auto-incremented to 'PF2'" and a 900 x 900 pad, with no size question.
- **Right:** PF4 (highest + 1, never reuse a gap, as `Core/Marks/MemberMarkEngine.cs` already does), and a size question.
- **Same fault, other inputs:** BPF1 then Increment gives PF1 (or the first free PF), not BPF2. "PF3 (assumed size)" labels from the load path do not match "PF3", so PF3 can be handed out again.
- **Confidence:** CONFIRMED (auditor's trace of the size path; the loop was re-read).
- **Fix:** use `MemberMarkEngine.NextUnusedMark` with the typed family letters.
- **Unit test RED:** yes if the loop is extracted.

### SHEETS-05. The drawing's "CE TO PDF" page setup forces its paper size onto every tab (HIGH for mixed-size drawings)
- **File:**
  - `Services/CeIssuePlotSettingsBuilder.cs:85-90`: `if (namedSetup != null) { ps.CopyFrom(namedSetup); intendedPaperSizeMm = ps.PlotPaperSize; …`
  - The setup is found once per DWG (`CeSheetsPdfPublisher.cs:164`) and used for every layout.
- **Steps:** one DWG holds an A1 GA tab and A3 detail tabs, with "CE TO PDF" set to A3 landscape. Publish Issue.
- **Wrong:** the A1 page is plotted on A3. It is cropped at 1:1, or shrunk to about 35% with "fit". Portrait tabs get landscape.
- **Right:** each tab keeps its own paper and orientation. The setup supplies only the device and pen table, or is used only when its paper matches the tab's (the 5 mm tolerance in `CeMediaSizeMatcher`).
- **Confidence:** CONFIRMED that the setup's paper is applied. PLAUSIBLE on the exact look, which depends on the setup's scale.
- **Fix:** as in Right.
- **Unit test RED:** the match decision, yes.

### REO-01. Typed STR / STIRRUP draws a sloping top bar and a square notch, not a closed lig with 135° hooks (HIGH on the detail; command hidden)
- **File:** `Modules/Structural/Commands/RebarCommands.cs:36-37` (still registered) and 364-370:
  `AddVertexAt(3, (p3.X - hook, p3.Y))`, `AddVertexAt(4, (p3.X - hook, p3.Y - hook))`, `AddVertexAt(5, p4)`. p4 is the top-left corner at the same height as p3.
- **Steps:** type STR, pick R10 at 200 and the corners of a 300 x 500 section, cover 30. The hook is max(30, 6 × 10) = 60.
- **Wrong:** from the top-right corner (270,470) the line runs to (210,470), drops to (210,410), then runs diagonally up to (30,470). The top bar is a slope of about 18°, and there is a square notch.
- **Right:** a closed rectangle at cover with 135° hook legs at one corner (locked rule 2026-06-18).
- **Rule conflict:** the Rulebook says "STR + BWT commands deleted permanently 🔒". They are hidden from the ribbon but still typed (carpark run notes 3220, 3290).
- **Confidence:** CONFIRMED.
- **Fix:** either retire STR and STIRRUP as the rule says (recommended), or redraw with the lig-detail hook rule.
- **Unit test RED:** yes if the vertex list moves into a pure helper. A source guard can pin "no CommandMethod STR".

### BRACE-03. STRSCHEDSYNC crashes on an erased brace or pier, or a locked brace layer (MEDIUM-HIGH)
- **Relation to known:** the known locked-layer crash is ABSWITCH. Trigger (b) is a new result of HUNT2-S-04 (stale rows stay).
- **File:**
  - `Services/ScheduleService.cs:735` (braces) and about 783 (piers): `tr.GetObject(id, OpenMode.ForWrite)`, with no erased check, no locked-layer check and no try.
  - The handle lookup at 846-847 returns an erased object's id as valid.
  - `Commands/UtilityCommands.cs:92-96` has no preflight, unlike STRSCHEDREFRESH.
- **Steps:**
  - (a) Lock WALL BRACING TYPE A, then STRSCHEDSYNC.
  - (b) Four braces, STRSCHEDCREATE, ERASE one, then STRSCHEDSYNC in the same session.
- **Wrong:** AutoCAD's "Unhandled exception" box (eOnLockedLayer or eWasErased), and nothing is synced.
- **Right:** skip those rows with one plain line each.
- **Confidence:** CONFIRMED for the locked layer. CONFIRMED by reading for the erased object; the exact exception text is AutoCAD's.
- **Fix:** check `IsErased` and the locked layer before opening for write, and add CommandPreFlight.
- **Unit test RED:** no.

### SHEETS-06. Renumber Sheets counts straight through every discipline and ignores the filter (MEDIUM-HIGH)
- **File:** `UI/Dialogs/CeSheetsWindow.xaml.cs:691-697`: `foreach (CeSheetEntry row in _rows) { … row.SheetNumber = prefix + index.ToString("00"); index++; }`
- **Steps:** S01 to S05 and C01 to C03. Filter to Civil, then Renumber.
- **Wrong:**
  - Civil becomes C06 to C08, and the hidden Structural sheets are renumbered too.
  - Excluded and unmanaged sheets are renumbered.
  - "S1.01" becomes "S0n", and a number with no letter becomes "S…".
- **Right:** count per prefix and touch only the visible, managed rows.
- **Confidence:** CONFIRMED (auditor's trace; the loop was re-read).
- **Fix:** group by prefix, and renumber only the filtered rows.
- **Unit test RED:** yes once the rule leaves the window.

### MARK-04. Changing a mark prefix in Settings splits footing marks and sizes into two families (MEDIUM-HIGH, only after a prefix is changed)
- **File:** `Services/FoundationService.cs`:
  - Lines 1102-1116: FPFC, FSF, FTHC, REB and RIB are fixed at "PF", "SF", "TH", "EB" and "IB".
  - Lines 74-76: the label reader knows only `BEB|BIB|BTH|BPF|BSF|EB|IB|TH|PF|SF|BP|SP|ST`.
  - Lines 1967 and 2032: FEDIT uses `GetPrefixForKind` (Settings).
  - Line 3041: a blank-label redraw uses `BuildAutoLabel` with the Settings prefix.
  - `FoundationService.Marks.cs:212-216`: renumber uses the Settings prefix.
- **Steps:** Settings → Mark prefixes → Pad footing = GPF (offered under INT-077 item 15). FPFC PF2 at 600, FEDIT it to 900, then FPFC another PF2.
- **Wrong:** FEDIT saved 900 under GPF/"PF2" and FPFC reads PF/"2", so the second PF2 is drawn at 600. CSMARKSRENUMBER treats every "PF" pad as hand-typed. A blank-label redraw always becomes "GPF1".
- **Right:** one prefix source and one memory bucket for every command.
- **Confidence:** CONFIRMED in code (auditor's trace). Whether the Settings page exposes the prefix rows was not checked.
- **Fix:** have the placing commands use `GetPrefixForKind`, and build the label reader from Settings.
- **Unit test RED:** partly (the key mismatch is pure).

### BRACE-04. ABS (A/B switch) turns a long B brace into an A brace with no length warning (MEDIUM)
- **File:** `Commands/BracingCommands.cs:475-528`. `var newType = currentType == "A" ? "B" : "A";` changes only the attribute and layer. `BracingLengthPolicy` is never called (nor in `BracingService.cs:2151-2188` `ConvertLegacyToNew`).
- **Steps:** BB a 3600 brace, then ABS and pick it.
- **Wrong:** a 3600 A brace with no message.
- **Right:** the same "longer than 2700, check it" warning that AB gives (INT-066 C).
- **Confidence:** CONFIRMED.
- **Fix:** run `BracingLengthPolicy.EvaluateInDrawingUnits` when switching to A.
- **Unit test RED:** no.

### SCHED-09. STRSCHEDSYNC: typing B over A in the TYPE column leaves the brace on the A layer (MEDIUM-LOW)
- **File:** `Services/ScheduleService.cs:742-743`: `if (!string.IsNullOrWhiteSpace(newType)) SetAttributeValue(br, "A", newType);`. The layer is not changed and the value is not checked. Also `ProjectDataService.cs:320` shows a blank type as "A", and sync then writes "A" in.
- **Steps:** in the bracing schedule, type B over an A, then STRSCHEDSYNC.
- **Wrong:** the brace stays red DASHDOT2 on WALL BRACING TYPE A and plots as A, while the schedule and panel call it B. A lower-case "b" is stored as "b", and ABS then cannot tell A from B.
- **Right:** go through the ABS switch (attribute and layer together), and accept only A, B or BTn.
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** no.

### BRACE-05. Older brace blocks are left out of the panel and schedule with no message (MEDIUM)
- **File:** `Services/ProjectDataService.cs:282-283` counts only the EffectiveName "BRACING". ABS still knows "A - BRACING LEFT/RIGHT", "B - BRACING" and so on (`BracingService.cs:2089-2141`).
- **Steps:** an older job, or a pasted office typical, with "A - BRACING LEFT" blocks, then CSBRACINGPANEL or STRSCHEDCREATE.
- **Wrong:** those braces add nothing to the provided totals and get no rows.
- **Right:** count them, or print "N older brace blocks not counted; convert with ABS".
- **Confidence:** CONFIRMED in code. How common old blocks are in live jobs is PLAUSIBLE.
- **Fix:** as in Right.
- **Unit test RED:** no.

### BRACE-06. AB, BB and BT1 snap any brace within 1° of square, so the far end misses the picked point (MEDIUM-LOW)
- **File:** `Services/BracingService.cs:38` `CardinalSnapToleranceDegrees = 1.0`. It is used by `NormalizeAngle` (2217-2220) at insert (line 1704) and by `SafeAngleDegrees`. The length stays the full picked distance.
- **Steps:** a background plan rotated 0.8° (site-aligned). AB end to end of a 2700 wall.
- **Wrong:** the brace is drawn at 0°. Its far end is 2700 × sin 0.8° ≈ 38 mm off the wall end.
- **Right:** follow the picked angle, or snap only when the end moves less than about 1 mm.
- **Confidence:** CONFIRMED.
- **Fix:** make the tolerance a distance, not an angle.
- **Unit test RED:** yes (`NormalizeAngle(0.8)` returns 0).

### LINTEL-01. CSLINTELPROPOSE does not see DS1/TS1 studs, so it proposes a second stud on top (HIGH once switched on; command is off by default)
- **File:** `Services/LintelProposalService.cs:220` matches only the Settings layers "SUPPORT DS" and "SUPPORT COLUMN". DS1 and TS1 go on layer "SUPPORT" (`Commands/SupportBlockCommands.cs:67-68`).
- **Steps:** a beam ends on a loadbearing wall with a DS1 under it. CSLINTELPROPOSE, then Enter (Accept).
- **Wrong:** "DS1 (load Unknown)" (or the next DS number) is drawn on top of the existing stud.
- **Right:** anything on SUPPORT counts as an existing support.
- **Confidence:** CONFIRMED.
- **Fix:** read the support layers from the SupportBlockCommands config.
- **Unit test RED:** no.

### LINTEL-02. CSLINTELPROPOSE ignores lintels drawn with beam commands 1 and 2, so it proposes a duplicate lintel and studs at both jambs (HIGH once switched on)
- **File:**
  - `Services/LintelProposalService.cs:212`: only Lines on layer LINTEL count as lintels.
  - Line 219: BEAM lines are read as beams. Command 2 puts lintels on BEAM LOWER (`BeamDraftingStandards.cs:20-21`).
  - Mark counting, `Core/Roofs/RoofSetoutPlanner.cs:93,113`: `"^\s*" + p + "(\d+)\s*(@|\(|$)"` does not count "L3 CANT." or "L3 LOWER".
- **Steps:** L1 over a 900 opening with command 2, then CSLINTELPROPOSE.
- **Wrong:** "L2 (size Unknown)" over the same opening. With command 1 (layer BEAM) the lintel ends also get "DS (load Unknown)" studs. With L1, L2 and "L3 CANT." on the plan, the next proposal is L3 again.
- **Right:** BEAM and BEAM LOWER lines with a lintel label count as existing lintels, and the next mark is L4.
- **Confidence:** CONFIRMED.
- **Fix:** use `Beams.IsLintelLabel` on BEAM and BEAM LOWER lines, and use the one mark grammar for counting.
- **Unit test RED:** yes for `NextFree("L", ["L1","L2","L3 CANT."])` returning L3.

### SHEETS-07. Each PDF is named after the DWG, so it carries the DWG's old revision letter (MEDIUM)
- **File:** `Services/CeSheetsPublishPlanner.cs:51-56`: `Path.GetFileNameWithoutExtension(dwgPath) + ".pdf"`. The code's own example is `25-105_STR_69 Mills Street, Hampton_A.pdf`.
- **Steps:** the DWG is named `…_A.dwg`. Publish Issue at rev B.
- **Wrong:** the folder `…STR REV B` holds `…_A.pdf`.
- **Right:** swap the revision token for the issue revision (`ExtractA3RevisionToken` already finds it).
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** yes.

### SHEETS-08. Update Drawings says it succeeded on a drawing open read-only (MEDIUM)
- **File:** `Services/CeSheetsSyncService.cs:830-844` writes into an open document and reports success ("use QSAVE to persist"). There is no `IsReadOnly` check anywhere in the Sheets services. The lock-file guard at 864 is skipped for documents open in this session.
- **Steps:** open `S-GA.dwg` read-only because a colleague has it. CESHEETS → Update Drawings.
- **Wrong:** "Updated 1 drawing(s)". QSAVE fails, the disk file never changes, and the next Publish uses the old values.
- **Right:** skip it with "open read-only (in use by …)".
- **Confidence:** CONFIRMED for the missing check. PLAUSIBLE for AutoCAD's exact QSAVE text.
- **Fix:** check `IsReadOnly`.
- **Unit test RED:** no.

### SHEETS-09. Same revision, same day, a smaller second batch deletes the morning's PDFs and issue record (MEDIUM; may be Tim's INT-059 "replace earlier set")
- **File:**
  - `Services/CeSheetsIssueService.cs:168-176` removes the earlier issue with the same ID. The ID is date + discipline + revision.
  - `Services/CeIssueSetReplacer.cs:61-66` deletes the earlier PDFs.
- **Steps:** in the morning issue S01 to S05 at REV C. In the afternoon issue S06 to S08 at REV C.
- **Wrong:** the morning PDFs and record are gone. Where they share a DWG, that DWG's PDF now holds only the afternoon sheets.
- **Right:** warn when the new set differs, then keep or merge.
- **Confidence:** CONFIRMED.
- **Fix:** compare the sheet lists, and ask before replacing.
- **Unit test RED:** yes (temp-folder test like the existing replacer tests).

### SHEETS-10. Drawing Register.xlsx is in plain text order: S1, S10, S11, S2 (MEDIUM-LOW)
- **Relation to known:** SCHED-08 covers other schedules. This is the register.
- **File:** `Services/CeSheetsRegisterExportService.cs:60-63`: `.OrderBy(sheet => sheet.SheetNumber, StringComparer.OrdinalIgnoreCase)`
- **Wrong:** S100 comes before S99, and the register order differs from the PDF page order, which uses natural sort.
- **Right:** use `NaturalSheetNumberComparer`.
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** yes.

### SHEETS-11. Register Status says "FOR CONSTRUCTION" for any all-letter revision, including P, T, PRELIM and DA (MEDIUM-LOW)
- **File:** `Services/CeRevisionStatusWordService.cs:17,35`: `^[A-Za-z]+$` maps to Construction. P and T count only with a number (`^P\d+$`).
- **Steps:** issue at rev "P" or "DA".
- **Wrong:** the preview and register say FOR CONSTRUCTION on a preliminary set.
- **Right:** a single letter other than P or T means construction; anything else is blank.
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** yes.

### MARK-05. FADOPT and the placing commands read band-mark memory keys differently: BEB3 gets EB3's width (MEDIUM)
- **File:** `Services/FoundationService.cs:4624-4637` (`ExtractMemoryKey`, used by FADOPT) strips the B and returns "3". Lines 4711-4724 (`ResolveMemoryKeyFromText`, used by REB, RIB, FSF, FPFC and FEDIT) return "BEB3".
- **Steps:** REB BEB3 at 1200 and EB3 at 300. FADOPT older linework labelled BEB3.
- **Wrong:** adopted at 300.
- **Right:** 1200.
- **Confidence:** CONFIRMED in code. PLAUSIBLE that a drawing has both.
- **Fix:** one key function.
- **Unit test RED:** yes.

### BRACE-07. A 45° splay puts both wall directions into East-West (LOW-MEDIUM)
- **File:** `Modules/Structural.DesignCore/BracingPanelCalculator.cs:58-59`: `distanceToEastWestAxis <= toleranceDegrees ? EastWest : NorthSouth`. The tie at 45° goes to East-West.
- **Steps:** bay-window braces at 45° and 135°, then CSBRACINGPANEL.
- **Wrong:** all of it is counted East-West.
- **Right:** split by components, or list them separately.
- **Confidence:** CONFIRMED.
- **Fix:** as in Right.
- **Unit test RED:** yes (`ClassifyDirection(135)` returns EastWest).

### REO-02. RBL bar count rounds down: one bar short whenever the length is not an exact multiple (MEDIUM-LOW; off by default)
- **File:** `Core/Rebar/ReoBarCore.cs:293`: `(int)Math.Floor((L + 1e-6) / s) + 1`
- **Steps:** Settings ReoBars.MarkRblRbcBars ON. RBL N12 at 200 across 3500, then CSBARSCHEDULE.
- **Wrong:** 18 bars, which is 205.9 centres, over the 200 maximum.
- **Right:** 19 (ceiling + 1).
- **Confidence:** CONFIRMED.
- **Fix:** `Math.Ceiling(L / s - 1e-6) + 1`.
- **Unit test RED:** yes.

### REO-03. CSREOBAR offers N40, R6 and R10 but the bar schedule cannot weigh them; two bar tables (MEDIUM-LOW)
- **File:** the size list is in `Services/StandardsService.cs:76-89` (R6, R10, N10 to N40). Schedule mass comes from `Assets/Config/rebar-catalogue.json` (N10 to N36) via `Services/ReoBarService.cs:845-849`.
- **Steps:** CSREOBAR N40, then CSBARSCHEDULE.
- **Wrong:** MASS shows UNKNOWN, and the total reads "x + UNKNOWN".
- **Right:** N40 = 9.86 to 9.87 kg/m (1257 mm² × 7850).
- **Masses checked:** N10 0.617, N12 0.888, N16 1.58, N20 2.47 and so on agree with AS/NZS 4671 nominal areas × 7850 kg/m³. The brief's "N10 0.632" was wrong; the code's 0.617 is right.
- **Confidence:** CONFIRMED.
- **Fix:** one bar table.
- **Unit test RED:** yes.

### REO-04. RBL, RBC, STR and BWT ignore drawing units while CSREOBAR converts, so they differ 1000× in a metre drawing (LOW-MEDIUM)
- **File:** `Commands/RebarCommands.cs:91-95, 212, 334, 481`, against `Services/ReoBarService.cs:869-883`.
- **Relation to known:** not the commands listed in HUNT-S-06, BEAM-07 or BEAM-09.
- **Confidence:** CONFIRMED.
- **Fix:** use `ComputeBarAnnotationSizes` for all four.
- **Unit test RED:** yes for a shared helper.

### LOWER (one line each, all CONFIRMED unless marked)
1. **RBL/RBC overwrite the Settings defaults** that CSREOBAR starts from (`RebarCommands.cs:78-81, 205-207`). This breaks Settings-first. LOW.
2. **CSBRACINGREQUIRED inputs are not checked** (`BracingPanelCommands.cs:102-120`). It ignores "12m" yet says "set". It accepts 0 or a negative (0 shows a green tick), cannot be cleared, and Esc at the first question still asks the second. LOW.
3. **A frozen or off brace layer gives an invisible brace** (`BracingService.cs:1601-1607`). Only locked layers are checked. The drafter redraws it and the panel counts it twice. LOW-MEDIUM.
4. **BT1 truss number is limited to 1-9** (`BracingCommands.cs:288-294`). BT10 is impossible. LOW.
5. **The Wall option cannot pick a wall line inside the architect's Xref** (`BracingCommands.cs:611-617`). The option is off by default. LOW.
6. **CEADMIN BRACING REFRESH/NORMALIZE add the attributes a second time** on braces that already have them (`BracingDiagnosticsService.cs:177, 269`). The text overlaps. LOW, admin only.
7. **ABS leaves BRACING_LETTER on the old letter** (`BracingCommands.cs:512` writes only "A"). It matters if that attribute is the visible one. PLAUSIBLE (BRACING.dwg not readable).
8. **ABS conversion of an older brace block uses only the block's parameters** (`BracingService.cs:2163-2188`). It may lose the insert angle, the LEFT/RIGHT side and the display state. PLAUSIBLE.
9. **STRSCHEDCREATE on a layout tab** puts the tables in Model space at the paper point (`ScheduleService.cs:210-221`, uses `CommandPreFlight`, not `…ModelSpace`). This is the same kind as HUNT-S-07, in a new command. MEDIUM.
10. **CSLINTELPROPOSE misses an opening that runs up to a perpendicular wall** with no nib, and gives no message (`LintelProposalPlanner.cs:202-214`). MEDIUM, pure, can be RED.
11. **CSLINTELPROPOSE numbers proposed studs DS1, DS2, DS3…** (`LintelProposalPlanner.cs:338-343`). The office uses DS1 as a repeating type. Tim's call.
12. **CSLINTELPROPOSE puts the tag on the inside of south and east walls** (`LintelProposalService.cs:370-373`), against the "lintel labels outside" rule. A locked LOADBEARING WALL layer makes it find nothing (it only reads, so it need not refuse). LOW-MEDIUM.
13. **CSLINTELPROPOSE reads polyline vertices in the polyline's own plane** (`LintelProposalService.cs:265, 282, 309`). Mirrored or exploded-mirrored walls come out at mirrored X. PLAUSIBLE.
14. **CSLINTELTABLE ignores a rotated UCS** (`LintelTableService.cs:145, 168`). The table style may be "Ignore"-cloned, so the text height comes from this drawing's Standard. PLAUSIBLE for the style.
15. **Mark readers reject the locked grammar's level and (O)/(U) parts**: `Core/LevelCarry/LevelCarryGeometry.cs:31` ("1C1"), `Core/Schedules/MemberScheduleRead.cs:31-35` ("2L1(O)", "FB1 CANT." read as size "CANT."), `Services/BoredPierPlacementService.cs:293` ("BP2(O)", "BP1A"). LOW today (the commands are off or hidden).
16. **CESHEETSCLASSIC:**
    - Issue history uses `ToDictionary` on sheet numbers (`CeSheetsIssueHistoryService.cs:45`), which can throw on duplicates, uncaught in a selection handler. PLAUSIBLE.
    - Bump Revision has no Z→AA, refuses "-" and "A1", and does not skip I and O. LOW.
    - A typed Issue Revision names only the folder. LOW-MEDIUM.
17. **CSREOBAR drawn on a layout measures paper length** ("x 55 LG"). PLAUSIBLE, LOW.
18. **The rebar catalogue's "lap = 40d"** is labelled AS 3600 13.2.2 but is shorter than a 13.2.2 lap for N12 in 32 MPa. No command reads it today.

---

## What I did NOT check
1. Inside BRACING.dwg and the CE A3 TITLE SHEET block. They are compressed DWGs, so the visible attribute, the parameter names and the date field format are unknown. This limits BRACE items 7 and 8 and SHEETS-01's date part.
2. Most of `CeSheetsSyncService.cs` (2,537 lines): the on-drawing register table sync, superseded backups, and shared-title Xref writes. Also not read: `CeSharedTitleMappingService`, `CeSheetsStructureService`, `CeSheetsReconciliationService`, `CeIssuePreviewBuilder`, `CeIssueDwgSnapshotService`.
3. Whether `LayoutManager.RenameLayout` on a side-loaded drawing acts on the right database. This needs AutoCAD.
4. The auto-flip scoring maths in BracingService (about lines 985-1400), Markup AI bracing beyond the length check, STRUCEXPORTCSV, and the bracing panel window layout.
5. The XCLMTXT and ExcelMTextService detail (6,480 lines; only spot-read), CSFOOTINGSCHEDULE, CSRCBEAMSCHEDULE, CSWALLSCHEDULE, CSPUMPPITSCHEDULE, and the RC section, column and lig windows.
6. Mesh (SL/RL): no mesh table or command was found in scope.
7. Whether the Settings page lets a drafter edit the mark-prefix rows (MARK-04 assumes it does).
8. Nothing was built, run, or opened in AutoCAD. No unit test was written or run.

## Summary

This read-only hunt of the installed Structural 1.0.118 (9a8e5d4e) found about 30 new defects across drawing sheets, bracing, footing marks, reo and the lintel proposal tool, none of them on the known lists. The most serious are in CESHEETS:
- Publish Issue plots drawings whose title blocks still carry the old revision.
- Leaving the discipline Rev box rewrites every sheet's revision.
- Renumber plus Update Drawings leaves tabs half-renamed and makes Publish throw.
- Multi-drawing jobs start with a scrambled sheet order that Renumber then bakes in.
- Mixed A1/A3 drawings plot every tab on the page setup's paper.

In bracing, STRSCHEDSYNC can swing ROTATEd braces off their walls or crash, and the panel and schedule ignore AutoCAD ROTATE. FPFC "Increment" quietly reuses a deleted pad's mark and size. The still-typeable STR draws a malformed stirrup, against both the 135° hook rule and Tim's ruling that STR is deleted. One Rulebook line (AB capped at 2700) is stale against Tim's INT-066 C ruling and should be marked superseded. Nothing here has been seen in AutoCAD; every item needs a Codex or Tim check on a copy, and no BUG numbers were filed (the controller does that).
