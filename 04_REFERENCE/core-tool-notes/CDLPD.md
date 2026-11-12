# TOOL NOTE: Legal point of discharge (CDLPD)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Marks the legal point of discharge** at the end of a pipe already drawn. It finds the pipe end nearest what you pick; it does not draw a pipe.
2. **Adds a standard LPD note** with an arrow to that pipe end, and a small "LPD" marker that does not plot.
3. **Stores the LPD** so the Pit Schedule, redesign, CDDEST and linking can read where the network ends.

## 2. What it changes in the drawing

1. **Draws** the note (a leader on 25TEXT, arrow at the pipe end) and an "LPD" word on GUIDELINES (does not plot).
2. **Stores** the LPD record: the point, which pipe and which end, the pit, any block you picked, the connection words, the invert, the note.
3. **Writes "LPD" into the pipe's From or To** in CE's record, only where that end is blank or "-".
4. **Replaces the old one:** an earlier LPD note is removed and a new one added.
5. **No quiet record update.** It does not run CE's whole-drawing record update.
6. **GUIDELINES layer:** its colour is set and it is made non-plotting on every run (unless locked).

## 3. What it will not do

1. **Refuses before the window:** a read-only drawing, Paper Space, REFEDIT open, a Structural drawing (asks first).
2. **Refuses when the newer Design outlets already exist** (CDDESIGN). You only find out after answering every question, and all it says is "Error during CDLPD - see CE log for details."
3. **Refuses a pick with no pipe end near it:** "No pipe end found near selection." (or "near point", or "within 2.5m of the selected block").
4. **Does not refuse an Xref block** picked as the target; it is treated as an ordinary block.
5. **Not used by CDRUNSOLVE or CDRENUMBER,** which look for a pit named LPD instead.

## 4. What it asks you, and what Enter means

1. **LPD window:** choose pick-an-object or pick-a-point, and the connection words. Buttons: Continue in drawing, Close. **Enter does nothing** (no default button). Esc or Close ends with nothing drawn.
2. **"Select pipe/pit/block for LPD or press Enter to pick point":** Enter goes to the point question. Esc ends with nothing drawn.
3. **"Pick LPD point (pipe end)":** Enter is not accepted. Esc ends with nothing drawn.
4. **"Specify LPD label location <LPD point>":** Enter puts the label at the pipe end.
5. **All writes happen after the last answer,** so Esc at any question leaves the drawing as it was.

## 5. When it says Unknown or "needs checking"

1. **Unknown invert is left out, not shown.** If the pipe end has no level (or a stored 0) the "AT APPROX IL" part of the note is dropped. Nothing tells you.
2. **Blank connection and unknown level:** no note is drawn at all, yet it still prints "LPD set." (see 7).

## 6. How to undo it

1. **U once.** Everything is inside the one CDLPD command and the record is written at its end. Not proven in AutoCAD.

## 7. Known faults

**Partly fixed**
1. **BUG-1158:** Save As copies keep the same drawing identity. A warning exists, but only CDDESIGN prints it, and it tells you to approve again in CDLPD, which then refuses once Design outlets exist.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1153:** redesign now warns when the LPD record cannot be read (stop switch off by default, so Apply still goes ahead). This is a CDDESIGN fault, not CDLPD.

**New in code, no bug covers it**
1. **Metre drawings:** the search distances from Settings are millimetres but are compared with drawing units, so in a metre drawing 250 mm becomes 250 m and the nearest pipe end anywhere is taken.
2. **Any plain polyline** is accepted as the pipe when you pick an object (the point route does check).
3. **Locked 25TEXT layer** gives only the general error line; the GUIDELINES change has already been made.
4. **Old note on a locked layer** stays and a second note is added.
5. **Moving the LPD** leaves "LPD" in the earlier pipe's From or To.
6. **No note drawn but "LPD set." printed** when the connection is blank and the level is unknown; the old note is left without a link.
7. **The real reason for a Design refusal** is only in the CE log.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 3.3:** `Commands\LpdCommand.cs:50-142`; refusal words `91, 107, 115, 134`.
2. **1.2, 2.1:** `LpdCommand.cs:204, 456-510`; `Services\LpdService.cs:381-422`.
3. **1.3:** `Services\PitScheduleBuilder.cs:1276, 1296`; `Services\NetworkRedesignCurrentDrawingReader.cs:621, 878`; `Commands\SourceDestinationCommand.cs:179`; `Services\LinkService.Geometry.cs:1097`.
4. **2.2:** `LpdCommand.cs:164-208`.
5. **2.3, 7 new 5:** `LpdCommand.cs:210-229`.
6. **2.4, 7 new 4:** `LpdCommand.cs:457-475`.
7. **2.5:** no call to the record update in `LpdCommand.cs` (logging, settings and theme only at `35-37`; `SetDrawingPath` at `85, 214` binds the record only, `Services\ProjectDataService.Mutations.cs:151-188`).
8. **2.6:** `Services\LayerService.cs:698-757`.
9. **3.1:** `LpdCommand.cs:28`; `Services\DrawingSafetyService.cs:61-131`.
10. **3.2, 7 new 7:** `LpdCommand.cs:170`, `257-261`; `Services\LpdService.ReadCompatibility.cs:357-407`.
11. **3.4:** `LpdCommand.cs:77-111` (no Xref test).
12. **3.5:** `Commands\RunSolveCommand.cs:239-247`.
13. **4.1:** `LpdCommand.cs:39`; `Dialogs\LpdWindow.xaml:95-96` (no IsDefault or IsCancel); `ViewModels\LpdWindowViewModel.cs:9-46`.
14. **4.2:** `LpdCommand.cs:50-56`, `123`, `143-146`.
15. **4.3:** `LpdCommand.cs:125-128` (no AllowNone).
16. **4.4:** `LpdCommand.cs:148-159`.
17. **4.5, 6.1:** `LpdCommand.cs:164` (single write transaction after the questions); `Services\LinkService.cs:61-81` (CDLPD on the end-of-command record flush list).
18. **5.1, 5.2, 7 new 6:** `Rules\SourceFamilies.cs:265-302`, `387-388`; `LpdCommand.cs:205-208`, `253-255`, `457-461`.
19. **7 BUG-1158:** `Services\LpdService.cs:164-206`, `244-275`; `Commands\CivilDesignCommand.cs:112-115`; `Models\UserSettings.cs:823`.
20. **7 BUG-1153:** `NetworkRedesignCurrentDrawingReader.cs:878-893`; `Services\NetworkRedesignApplyTicketService.cs:894-905`; `UserSettings.cs:805, 813`.
21. **7 new 1:** `LpdCommand.cs:89, 105, 132, 187`; `LpdService.cs:498, 520`; `Models\ReachSettings.cs:29-32`.
22. **7 new 2:** `LpdCommand.cs:65-76`; `Services\PipePickService.cs:28-32`; point route check `LpdService.cs:700-706`.
23. **7 new 3:** `LayerService.cs:474-475`, `706-733`.
24. **8.1:** no `#if` in `LpdCommand.cs`, `Services\LpdService*.cs`, `Dialogs\LpdWindow*` or `ViewModels\LpdWindowViewModel.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:34. Nothing was run in AutoCAD.
