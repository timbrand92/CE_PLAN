# TOOL NOTE: Inspector (CDINSPECTOR)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens or closes the "CE Inspector" palette,** which shows what CE knows about the pit, pipe or source you select.
2. **Compact view by default;** a Settings switch gives the older full-detail view.
3. **Buttons** to zoom to it, select the whole item, or open its editor.

## 2. What it changes in the drawing

1. **Compact view (default): nothing.** It reads the selection and CE's record without changing either.
2. **Full-detail view:** runs CE's whole-drawing record update when it first attaches and on every pick refresh (not while a command is running or straight after U).
3. **Buttons that change things:** Edit opens CDEDIT (writes only if you Save there). In the full-detail view, "Use plan label" renames the pit in CE's record to match its plan label, relabels the plan and refreshes schedule cells, in one command. Repair, Schedule and Label styles open those tools.
4. **Health-count buttons** (full detail) change the selection and zoom only.

## 3. What it will not do

1. **Buttons switch off with a reason** shown in the status line: "Read-only drawing.", "Finish the active AutoCAD command first.", "REFEDIT is active.", "Selection is stale.", "Unsupported object.", "Object is on a locked layer.", "External reference content.", "Object protection could not be checked."
2. **Compact view does not compare a pit's plan label with its record** (the full-detail view does).

## 4. What it asks you, and what Enter means

1. **No questions.** Typing CDINSPECTOR again closes the palette.

## 5. When it says Unknown or "needs checking"

1. **Full detail:** a pit whose plan label and record disagree is warned, with a "Use plan label" button.
2. **Full detail:** a pit not in the record says "Not found in ProjectData".

## 6. How to undo it

1. **Opening and selecting:** nothing to undo.
2. **"Use plan label":** one command, so one U (not proven).

## 7. Known faults

**Still there in this build**
1. **BUG-994:** the compact view shows a pipe length in raw drawing units as "mm" (wrong in a metre drawing). The full-detail view converts.

**Partly fixed**
1. **BUG-098:** the label-against-record warning and "Use plan label" exist only in the full-detail view.
2. **BUG-518:** ribbon buttons now add the command name in brackets (switch on); the palette title is still just "CE Inspector".

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-099:** the cover line uses proper tick, warning and cross marks (full-detail view).
2. **BUG-995:** the health-count buttons zoom correctly in a rotated UCS.

**New in code, no bug covers it**
1. **Cover depth amber band starts at a fixed 400 mm,** not from Settings.
2. **Fallback grade 200 and speed 3.0** when Settings is missing.
3. **"Not found in ProjectData"** is program wording a drafter sees.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 4.1:** `Commands\InspectorCommand.cs:13`; `Services\InspectorPaletteService.cs:176-194`, `330-344`.
2. **1.2:** `InspectorPaletteService.cs:63-65`, `1309-1315`; `ViewModels\Shell\CeEditorShellStateStore.cs:40`.
3. **1.3, 2.3:** `InspectorPaletteService.cs:261-286`, `1261-1281`, `3155-3197`.
4. **2.1:** `InspectorPaletteService.cs:922-1086` (read at 995); `Services\ProjectDataService.cs:160-199`.
5. **2.2:** `InspectorPaletteService.cs:515, 548, 559, 567, 596, 1360-1361, 1589`.
6. **2.4:** `InspectorPaletteService.cs:271-282`, `2939-3008`.
7. **3.1:** `InspectorPaletteService.cs:1061-1076`, `1199-1223`, `1245-1248`.
8. **3.2, 7 BUG-098:** `InspectorPaletteService.cs:1739`, `3106-3145`; `ViewModels\InspectorViewModel.cs:153-181`.
9. **5.2, 7 new 3:** `InspectorPaletteService.cs:3214`.
10. **7 BUG-994:** `InspectorPaletteService.cs:1040` against `1801-1802`.
11. **7 BUG-518:** `PluginInitialization.cs:259-261`; `Models\UserSettings.cs:3668`.
12. **7 BUG-099:** `InspectorPaletteService.cs:3253-3262`. **7 BUG-995:** `InspectorPaletteService.cs:2980-2982`; `Services\DrawingService.cs:576-645`.
13. **7 new 1:** `InspectorPaletteService.cs:3254`. **7 new 2:** `InspectorPaletteService.cs:3403-3404`.
14. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 01:00. Nothing was run in AutoCAD.
