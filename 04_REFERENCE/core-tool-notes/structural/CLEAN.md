# TOOL NOTE: Clean the drawing and save (CLEAN, with FASTSAVE)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **CLEAN tidies the whole drawing, then saves it.** In order: purge, put every Xref on layer XREF, put all text on one text style (Arial Narrow), set dimensions, leaders and multileaders to ByLayer, regenerate, save.
2. **It saves, by Tim's decision of 5 Nov.** CLEAN is the one Structural tool where saving is part of the job.
3. **It sets drawing defaults for what you draw next:** colour, linetype and lineweight ByLayer, hatches as SOLID on layer HATCH 21 with no background, current text style STANDARD.
4. **FASTSAVE is a separate typed command.** With the shipped settings it only regenerates and saves: no purge, no Xref move, no text or ByLayer step. A Settings-file switch ("FASTSAVE also purges and moves Xrefs") brings the older clean-up back. That switch has no box on CESETTINGS.
5. **Help lists FASTSAVE as another name for CLEAN.** It is not: they run different steps.

## 2. What it changes in the drawing

1. **Purge:** every unused layer, block, style and similar named item is removed (purge all, no confirmation).
2. **Xrefs:** every Xref reference in the drawing is moved onto layer XREF (colour 7, Continuous; made if missing). A reference on a locked layer is counted "failed" and left.
3. **Text:** every single-line text, multiline text and multileader text outside Xrefs is set to STANDARD. STANDARD itself is changed to font ARIALN.TTF, height 0, width 1, no slant. Dimension styles use STANDARD. The current text style becomes STANDARD.
4. **ByLayer:** every dimension, leader and multileader gets colour, lineweight and linetype ByLayer. Dimension styles and multileader styles are set the same way.
5. **Existing hatches are left alone.** Only the defaults for the next hatch change (layer HATCH 21, made if missing).
6. **Settings that stay changed after it ends:** the current colour, linetype and lineweight, the dimension colour and linetype settings, the hatch defaults.
7. **The file is saved over itself** by CE's own save, in the running AutoCAD's own file version. A rolling backup copy may then be written to the CE backup folder (Settings: "Write rolling backups", on by default).
8. **The backup copy is made after the save,** so it holds the cleaned drawing, not the one before.

## 3. What it will not do

1. **Does not ask before it starts or before it saves.**
2. **Never unlocks a layer.** A locked layer makes steps fail instead (see section 7).
3. **Does not delete text styles,** only re-points text at STANDARD.
4. **Does not refuse a read-only drawing, a layout tab or REFEDIT.** It runs. On a read-only drawing CE's own save declines, and CLEAN then sends a plain QSAVE.
5. **Does not follow Settings > Xref Layer.** The layer name XREF, HATCH 21 and the Arial Narrow font are fixed inside CLEAN.
6. **A recovery or autosave drawing is cleaned but not saved.** It prints "[CLEAN] Recovery/autosave save-protection active (reason). Cleanup will run, but automatic save will be skipped."
7. **Keeps no copy of the drawing from before the clean-up.**

## 4. What it asks you, and what Enter means

1. **It asks nothing.** There is no prompt, so Enter and Esc have no meaning. What Esc does while a step is running is not known.
2. **It prints as it goes:** "[CLEAN] Native cleanup pipeline started.", the drawing summary lines, then a result line: "[CLEAN] Done in N s: N steps done, N failed, drawing saved." (or "not saved"), then one line per step marked OK or FAIL.
3. **Last line:** "[CLEAN] saved " followed by the file path, or "[CLEAN] WARNING: drawing was NOT SAVED. Save it yourself now. Current file=" followed by the path.

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.**
2. **"FAIL" against a step** means that whole step was dropped and nothing from it was kept. The reason shown is AutoCAD's own word (for a locked layer, eOnLockedLayer).
3. **"drawing saved" is printed whenever a save was attempted by QSAVE,** even if that save was not checked (see section 7).
4. **"NOT SAVED" is the only line to trust as a fault.** Save the drawing yourself when you see it.

## 6. How to undo it

1. **U once should undo the clean-up in memory.** The clean-up is wrapped in one undo mark, so one U is intended. Not proven in AutoCAD.
2. **U does not undo the save.** The file on disk already holds the cleaned drawing; it changes back only when you save again after U.
3. **A record says CLEAN adds an extra empty undo step** (BUG-425), so a second U may seem to do nothing.
4. **The Settings that stay changed** (section 2 item 6) are not undone by U. Not proven either way.

## 7. Known faults

**Still open**
1. **BUG-425 (item S2-013):** CLEAN and FASTSAVE add an extra empty Undo step. The audit's reading; not re-derived here. The entry's recorded fixes are Civil and Manager pull requests, not Structural.
2. **BUG-411:** the F2 key runs CLEAN (found by Codex on 5 Oct). Where F2 is bound is not known; nothing in the Structural source files searched binds it.
3. **BUG-1278:** hatches cannot be edited since the plugin loaded (Associative and Annotative greyed). CLEAN is named as an unproven suspect because it opens every object in the drawing for writing, changed or not. Cause not found.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-620:** FASTSAVE purged and moved Xrefs before saving. With the shipped settings it no longer does either. It still regenerates.

**New in code, no bug covers it**
1. **The words disagree.** The tooltip says "Does not save: save the drawing yourself." and the Settings page says "CE never saves; AutoCAD's own automatic save still runs." Both are wrong for CLEAN; its long description and the code save.
2. **One object on any locked layer fails whole steps.** The text step and the ByLayer step open every object in the drawing for writing. One object of any kind on a locked layer drops the whole step, and it prints "FAIL" with AutoCAD's raw word. The other steps and the save still run, so you can get "drawing saved" after a half clean-up.
3. **A failed save can still print "saved".** If CE's own save fails, CLEAN sends QSAVE and counts it done without checking. On a read-only drawing AutoCAD's own Save As box may appear; what happens then is not known.
4. **A never-saved drawing may be saved over its template (hunt DS-04, HIGH if real).** CE's save uses the drawing's recorded file name and refuses only autosave file types. Whether a new drawing's name is its template is not measured on AutoCAD 2027.
5. **No read-only, layout or REFEDIT check at the start.**
6. **Ignores Settings > Xref Layer,** and the FASTSAVE switch has no Settings box.
7. **The next hatch is SOLID on HATCH 21 for the rest of the session** after CLEAN, whatever you had set.
8. **Attribute definitions inside block definitions are caught as text** and set to STANDARD, while the step prints "attributes=preserved". By reading; not seen.
9. **Saved in the running AutoCAD's own file version,** not AutoCAD's Save As format setting. Whether a drawing cleaned on 2027 then opens on 2022 to 2024 is not known.
10. **Help text is stale.** The FASTSAVE row still says "lighter cleanup sequence" and "May normalize object properties/layers". CLEAN's prompts line reads "Command-specific prompts (legacy workflow)".

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the CLEAN or save files, and the 2022 to 2024 build compiles the same source. Whether it behaves the same there, and the file-version question in section 7, are not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1:** `Services\CleanPipelineService.cs:109-172`; stage order from `128-147`.
2. **1.2:** `CleanPipelineService.cs:68-70, 149-150`; `Assets\Config\command-registry.json:4146, 4151` (B-178).
3. **1.3:** `CleanPipelineService.cs:468-479, 561-564, 708`; `453`.
4. **1.4:** `Commands\LegacyPortCommands.cs:14-15`; `Services\CleanPipelinePlan.cs:11-18`; `Models\UserSettings.cs:372`; `Services\SettingsService.LoadRecovery.cs:1322`; no FastSave name in `UI\Dialogs\CeSettingsDialog.xaml(.cs)`.
5. **1.5, 7 new 10:** `command-registry.json:4136-4139, 4157-4173`; `Services\CommandRegistryService.cs:525-538`.
6. **2.1:** `CleanPipelineService.cs:111-116`.
7. **2.2:** `CleanPipelineService.cs:16, 299-354` (305 layer colour 7; 336-346 failed count).
8. **2.3:** `CleanPipelineService.cs:18-19, 356-463`.
9. **2.4:** `CleanPipelineService.cs:465-567, 569-594`.
10. **2.5:** `CleanPipelineService.cs:17, 483, 551-552`.
11. **2.6:** `CleanPipelineService.cs:468-479, 561-564`.
12. **2.7:** `Services\DrawingAutoSaveService.cs:129-269` (198 `db.SaveAs(... DwgVersion.Current ...)`, 207-219 backup); `Models\UserSettings.cs:422`.
13. **2.8:** `DrawingAutoSaveService.cs:198-219, 308-312` (backup made after the save, "only ever copies the drawing's own last-saved bytes").
14. **3.1:** `CleanPipelineService.cs:59-212` (no prompt anywhere in the file).
15. **3.2:** `CleanPipelineService.cs:409, 526` (opened for write, locked layers not forced).
16. **3.3:** `CleanPipelineService.cs:455-457`.
17. **3.4, 7 new 5:** `CleanPipelineService.cs:59-90` (null checks only); `DrawingAutoSaveService.cs:163-167`; `CleanPipelineService.cs:167-168`.
18. **3.5, 7 new 6:** `CleanPipelineService.cs:16-19, 305, 483` against `UI\Dialogs\CeSettingsDialog.xaml.cs:171-173, 403-405`.
19. **3.6:** `CleanPipelineService.cs:71-78, 153-158, 246-259`.
20. **3.7:** `CleanPipelineService.cs:59-212` (no copy step).
21. **4.2, 4.3:** `CleanPipelineService.cs:97, 101-102, 194-199, 204, 208, 731-753`.
22. **5.2, 7 new 2:** `CleanPipelineService.cs:215-244` (a failed step is caught and counted), `232-236`; summary `746-751`.
23. **5.3, 7 new 3:** `CleanPipelineService.cs:167-171, 284-287, 208`.
24. **6.1, 6.2:** `CleanPipelineService.cs:83, 151-172, 187-188, 658-689`.
25. **6.3, 7 BUG-425:** carpark BUG-425 (item S2-013); `CleanPipelineService.cs:658-689`.
26. **6.4:** `CleanPipelineService.cs:468-479, 561-564`.
27. **7 BUG-411:** carpark BUG-411; a search of the Structural source (`*.cs`, `*.lsp`, `*.json`, `*.xml`) found no F2 binding.
28. **7 BUG-1278:** carpark BUG-1278 (CE 05 note, 5 Nov); `CleanPipelineService.cs:409, 526`.
29. **7 BUG-620:** `CleanPipelineService.cs:105-126, 143-147`; `CleanPipelinePlan.cs:11-13`; `Models\UserSettings.cs:372` (default false).
30. **7 new 1:** `command-registry.json:4145-4146`; `UI\Dialogs\CeSettingsDialog.xaml:557`.
31. **7 new 4:** `Services\DrawingSafetyService.cs:187-206, 356-362`; `DrawingAutoSaveService.cs:129-143, 198`; hunt note `release-v3-colleagues-HUNT_DATALOSS_SILENT_2026-10-12.md`, finding DS-04 (never given a bug number).
32. **7 new 7:** `CleanPipelineService.cs:561-563`.
33. **7 new 8:** `CleanPipelineService.cs:133, 414-428`.
34. **7 new 9:** `DrawingAutoSaveService.cs:198`.
35. **7 new 10:** `command-registry.json:4147-4149, 4164, 4168`.
36. **8.1:** no `#if` in `CleanPipelineService.cs`, `CleanPipelinePlan.cs`, `DrawingAutoSaveService.cs`, `LegacyPortCommands.cs`; `CE_STRUC_SUITE.csproj:27`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 03:10. Nothing was run in AutoCAD.
