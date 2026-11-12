# TOOL NOTE: Place a pit (PIT)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places one pit** at the point you pick, with its number label and cover level text.
2. **Point first, then the window.** You pick the spot, then the New Pit window opens.
3. **Carries on.** After each pit it asks for the next point until you press Esc.

## 2. What it changes in the drawing

1. **Draws** the pit block (layer of the pit), its number label and its cover text (on the pipe text layer).
2. **Stores** the pit in CE's record straight after the block goes in, before the label and cover text questions.
3. **Splits a pipe it lands on** into two pipes, then rejoins every pipe end to the pit it sits in. It prints one line when it splits.
4. **Quiet record update first.** Before asking for the point it brings CE's record up to date with the drawing (only if something changed since the last time): adds drawn pits and pipes the record is missing, drops records whose object is gone, re-reads details, fills blank pit inverts from the pipes. Nothing is printed about it.
5. **Remembered values.** Pressing Continue placement saves the window's values as the next pit's starting values (a file on your PC, not the drawing).
6. **Warns on overlap.** If the new pit overlaps another pit or a source it prints a warning and still places it.

## 3. What it will not do

1. **Refuses before anything is asked:** a read-only drawing, Paper Space, and a drawing with an in-place reference edit open (REFEDIT).
2. **Structural drawings:** it says Civil is switched off and asks "Turn on CE Civil for this drawing?" (Enter = No).
3. **New drawing with no CE content:** it asks once "Is this a Civil drainage drawing?" (the code offers Yes; Esc cancels).
4. **Locked layers:** refuses if the pit layer, label layer, label number layer or cover text layer is locked. It never unlocks. This check comes after the point, the window and any alignment pick.
5. **Blank cover level:** the window will not let you continue until a cover level is typed ("Enter the cover level.").
6. **Will not split** a pipe that is one half of a broken pipe, or a pipe with an arc in it. The pit is still placed and one line says why.
7. **Metre drawings:** it sets the pit size straight from the millimetres typed, at scale 1. Nothing converts for a drawing in metres.

## 4. What it asks you, and what Enter means

1. **"Specify pit insertion point":** Enter is not accepted, it asks again. Esc ends with "PIT command cancelled."
2. **New Pit window (one page):** Enter = **Continue placement**. Cancel or Esc ends with "PIT command cancelled."
3. **Inspect drawing button:** closes the window and asks "Press Enter to reopen PIT". Enter reopens it with your values. Esc ends the command.
4. **Align to pipe or building (if chosen in the window):** pick the line, then "Accept placement? [Accept/Cancel] <Accept>". Enter = Accept.
5. **"Specify pit label insertion point":** Enter is not accepted. Esc places no label (a Settings switch, off by default, puts it at the usual spot instead).
6. **"Click to place cover text (Enter = <BR>)":** Enter puts it at the corner shown (the window's corner, BR if none). Esc places no cover text.
7. **Next pit:** "Pit placed. Pick the next pit, or press Esc to stop." Esc says "Stopped. Everything placed stays; U takes back the last one."

## 5. When it says Unknown or "needs checking"

1. **No Unknown.** A blank cover level is refused rather than shown as Unknown (see 7).
2. **Label could not be written:** "Pit retained without its number label" or "Pit retained. Its number label could not be verified or removed; review that label before issue."
3. **Split failed:** "The pipe under this pit could not be split automatically. Run CDCHECK to review it."
4. **Depth hint in the window:** shows about cover minus invert and "shallow (<0.6 m min)" under 0.6 m.

## 6. How to undo it

1. **U once per pit.** Each pit is its own command, including the split and relink.
2. **Not undone by U:** the remembered window values on your PC.
3. **After Esc at the first point:** the quiet record update has already run inside that command. Whether one U takes it back is not proven.

## 7. Known faults

**Still there in this build**
1. **BUG-1042:** a blank cover level blocks Continue placement. Way round: type the level, or a placeholder you will fix.
2. **BUG-287:** a drawing set to metres with millimetre-sized pits. PIT inserts at scale 1 and sizes the pit in millimetres; no warning.
3. **BUG-793, part (a):** on opening, a block named "PIT BLOCK" or "PIT BLOCK 2" is swapped for CE's pit by name alone. This is the open-time update, not PIT itself.

**Partly fixed**
1. **BUG-465:** cover-text gap, label heights and text height now come from Settings. The cover text still takes the current text style unless a style is set in Settings. The other six items: reported, could not confirm in code.
2. **BUG-793, part (b):** a drawing whose PIT BLOCK 3 already matches is no longer redefined on every open (switch on). Part (a) above remains.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-458:** PIT now refuses while REFEDIT is open.
2. **BUG-690, 691, 692, 693:** splitting a pipe under a new pit: links move to the right half, broken pipes and arc pipes are left whole with a line, callouts follow their arrow.
3. **BUG-1165:** pit blocks now come from the running bundle first (switch on).
4. **BUG-035:** rotated UCS after CD: the pit's rotation is forced back to the one asked for.

**Reported, could not confirm in code**
1. **BUG-267:** OOPS after erasing a pit (records say a fix is installed).
2. **BUG-052, BUG-037:** PIT BLOCK 3 adoption and the installer payload.
3. **BUG-430:** double-click on a pit label opens AutoCAD's attribute editor (records say still failing in AutoCAD; not PIT's own code).
4. **Filed under PIT but belong to other tools:** BUG-426 and BUG-464 (Pit Schedule), BUG-1080 (CDREFRESHBLOCKS).

**New in code, no bug covers it**
1. **Shallow-pit hint is fixed in code at 0.6 m**, not read from Settings.
2. **Locked layers are checked last,** after you have filled in the window and picked any alignment line.

## 8. On AutoCAD 2022 to 2024

1. **Same command and questions.**
2. **The window shows a simple drawn sketch** of the pit, not the real pit block picture, and clicking a pipe tag on the picture does nothing. (The real picture is built only for AutoCAD 2027.)
3. **The buttons** come from the older workspace menu on the net48 build (AutoCAD 2022 to 2024; the comment in the code names only 2023 and 2024), not the CE ribbon builder. 2025 and 2026 use the ribbon builder.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 1.2:** `Commands\PitCommand.cs:113-121` (point), `177` (window), `204` (place).
2. **1.3, 4.7:** `PitCommand.cs:217-221`; `Services\PlacementContinuationService.cs:43-76`, line 71 for the Esc words.
3. **2.1:** `PitCommand.cs:394-399` (pit block), `479-485` (label), `546-556` and `787, 805` (cover text layer).
4. **2.2:** `PitCommand.cs:459-469` (record written before label and cover text).
5. **2.3, 3.6:** `PitCommand.cs:566-585`; `Services\LinkService.Split.cs:1555-1573`; `Rules\PlanEditWordsRule.cs:71-92`; `Rules\PairedPipeSplitRule.cs:30-38` and `Models\UserSettings.cs:1380` (switch on).
6. **2.4:** `PitCommand.cs:111`; `Services\ProjectDataService.cs:595-693`.
7. **2.5, 6.2:** `ViewModels\PitViewModel.cs:980-991`, `1229-1258`.
8. **2.6:** `PitCommand.cs:318-324`, `593-594`.
9. **3.1:** `PitCommand.cs:92`; `Services\DrawingSafetyService.cs:61-123` (REFEDIT at 78-90).
10. **3.2, 3.3:** `Services\DrawingDisciplineService.cs:33-75`, `101-161`.
11. **3.4:** `PitCommand.cs:341-361` (after the point at 115, window at 177, alignment at 314).
12. **3.5, 7 BUG-1042:** `Rules\PitStartReadiness.cs:124-125`; `PitViewModel.cs:1116`.
13. **3.7, 7 BUG-287:** `PitCommand.cs:394-399` (scale 1.0), `715-720` (sizes set as typed).
14. **4.1:** `PitCommand.cs:237-242` (allowNone false), comment at `208`; cancel words `118`.
15. **4.2:** `Dialogs\WorkshopPitCreation.cs:16-22`; `Services\DialogService.cs:53-58`; `Dialogs\PitEditWorkshopDialog.xaml:330-331`; `ViewModels\PitViewModel.Workshop.cs:8`; cancel `PitCommand.cs:198-202`.
16. **4.3:** `PitCommand.cs:180-196`.
17. **4.4:** `Commands\PitCommand.Orientation.cs:47-105`, `234-241`.
18. **4.5:** `PitCommand.cs:479-501`; `Services\BlockService.cs:1369-1378`, `1610-1615` (no Enter in the pick); `Models\UserSettings.cs:1413` (switch off).
19. **4.6:** `PitCommand.cs:532-557`, `988-1004`; `UserSettings.cs:1425` (plastic pit switch off).
20. **5.2, 5.3:** `PitCommand.cs:513-523`, `601-602`; `PlanEditWordsRule.cs:91`.
21. **5.4, 7 new 1:** `PitViewModel.cs:400-427`.
22. **6.1:** `PitCommand.cs:206-216`, `372-381`.
23. **7 BUG-793:** `Services\PitBlockMigrationService.cs:207-244` (by name), `220-222` and `281-290`; `Models\PitMigrationSettings.cs:9`.
24. **7 BUG-465:** `PitCommand.cs:33-37`, `801`, `1025-1030`; `Services\TextService.cs:28-29`, `1765-1771`; `UserSettings.cs:2442`.
25. **7 BUG-458:** `DrawingSafetyService.cs:78-90`.
26. **7 BUG-690 to 693:** `LinkService.Split.cs:1555-1573`, `1624-1626`, `1653-1665`.
27. **7 BUG-1165:** `Services\BlockService.cs:124-128`; `PitMigrationSettings.cs:13`.
28. **7 BUG-035:** `PitCommand.cs:405-426`.
29. **8.2:** `Dialogs\PitOnePageLayout.cs:96-113`.
30. **8.3:** `Services\StandaloneCivilRibbonService.cs:21-25` (`#if NET48`; the `#else` at 48 is the ribbon builder); `CE_CVL_SUITE.csproj:4` (net48 = 2022 to 2024).

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:20; corrected after independent review. Nothing was run in AutoCAD.
