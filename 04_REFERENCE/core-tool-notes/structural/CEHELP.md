# TOOL NOTE: Command help (CEHELP)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Opens a window called "Command help" with the version number,** a searchable list of CE commands with a short summary, the typed command, its other names, the steps in AutoCAD, the layer behaviour and notes.
2. **Search matches** the command name, its plain label, its descriptions, its group and its other names. The best match is selected for you.
3. **"Show advanced commands"** adds the commands marked expert. Hidden commands never show.
4. **Three buttons:** Copy command, Open command hub (the palette's Commands tab) and Run command.
5. **Other names:** CE_HELP and ?CE open the same window. The window is not tied to a drawing and changes no drawing.

## 2. What it changes in the drawing

1. **Nothing in the drawing.**
2. **It does write CE's settings file** (CS_Settings.json): the search text you last typed, the "advanced" tick, and the list of recent commands when you press Run command.
3. **Run command starts the selected command straight away.** That command then does whatever it does (CLEAN, for one, saves the drawing).

## 3. What it will not do

1. **Does not show hidden commands** (63 of the 375 registered) and does not show advanced ones until the tick is on (39 are marked advanced).
2. **Does not list the Foundations group** (25 commands, 19 of them neither hidden nor advanced, for example FPFC, FSF, FST, BP). They are counted in the "N commands" label but the list has no place to show them (see section 7).
3. **Does not ask before Run command.** There is no confirmation.
4. **Does not check Help text is true.** It prints whatever the command list says (see section 7).

## 4. What it asks you, and what Enter means

1. **It asks nothing on the command line.** The command list says it takes "Optional filter text", but no such prompt exists.
2. **Esc closes the window.** Enter on a selected command in the list shows its details; on a heading it opens or closes that heading.
3. **Typing in the search box** filters the list at once.

## 5. When it says Unknown or "needs checking"

1. **"No summary yet."**, **"No details yet."** and **"Prompt sequence not documented."** mean the command list has no text for that command.
2. **"No matching command"** means nothing matched your search, including a search left over from last time (section 7).
3. **"Select a command"** is shown when nothing is selected.

## 6. How to undo it

1. **Nothing in the drawing to undo.**
2. **Run command** is undone the way that command is. Close the window with Esc; the remembered search and recent list stay in the settings file.

## 7. Known faults

**Still open**
1. **BUG-1219 (LOW):** Help for "Beam Settings" (typed 8) and "Rafter/Joist Settings" (RJSET) lists placement steps (Start point, End point, Text/suffix; Direction, Extent, Tag text). Neither command asks them; both open CE Settings. Still in the installed command list.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1077:** Help for BSET now reads "Pick a point inside the building so CE can put lintel labels outside." with a plain explanation. No "seed", "persistent store" or "J11.2".
2. **BUG-1079:** Help for Export Layout to PDF no longer says "via AsyncCommandService" or "asynchronously".

**Partly fixed**
1. **BUG-1078:** the details for Open Saved Markup Review, Set Drawing for Markup and Apply Next Markup Group are in plain words now. The three are still filed under Admin, which the entry also complained of.

**New in code, no bug covers it**
1. **It opens already filtered by whatever you searched last time.** If that search finds nothing you see "No matching command" and an empty list until you clear the box.
2. **Foundations commands never appear in the list.** They show only when you type their exact name; the details appear but the list stays without them.
3. **The settings file is written on every key you type** in the search box, every tick of "advanced" and every Run.
4. **Run command has no confirmation,** and it will run a command that saves (CLEAN) or changes the drawing.
5. **Many entries say nothing.** The three schedule commands and CLEAN list their steps as "Command-specific utility prompts" or "legacy workflow"; CE Settings has no description at all. Refresh Schedule is marked advanced, so it is hidden until the tick is on.
6. **The "optional filter text" prompt is listed but never asked.**

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the help files. Whether the window sits the same way over the older AutoCAD windows is not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1:** `UI\Dialogs\CommandHelpWindow.xaml.cs:30, 304-345`; `UI\Dialogs\CommandHelpWindow.xaml:50-54, 190, 200`.
2. **1.2:** `CommandHelpWindow.xaml.cs:236-264`, `101`.
3. **1.3:** `CommandHelpWindow.xaml.cs:47, 71`; `UI\Dialogs\CommandHelpWindow.xaml:73`; `Services\CommandRegistryService.cs:83-91`.
4. **1.4:** `CommandHelpWindow.xaml:228-230`; `CommandHelpWindow.xaml.cs:409-421, 444-462`.
5. **1.5:** `Commands\AdminCommands.cs:14-20, 199-215`.
6. **2.2:** `CommandHelpWindow.xaml.cs:347-366, 423-442`.
7. **2.3:** `CommandHelpWindow.xaml.cs:414-421`.
8. **3.1:** counts of `"hidden": true` (63), `"expert": true` (39) and `"command":` (375) in `Assets\Config\command-registry.json`; `Services\CommandRegistryService.cs:460-474, 505-539`.
9. **3.2, 7 new 2:** `CommandHelpWindow.xaml.cs:16, 110-143` (only six named categories are built); `Services\CommandRegistryService.cs:99-114` (group "Foundations" gives panel "Foundations"); `CommandHelpWindow.xaml.cs:113` (the count), `266-272` (details shown with no list item). The 25 and 19 are counts of `"group": "Foundations"` rows in the registry.
10. **3.3:** `CommandHelpWindow.xaml.cs:409-421`.
11. **4.1:** `command-registry.json:345-347`; `Commands\AdminCommands.cs:17-20` (no prompt).
12. **4.2:** `CommandHelpWindow.xaml.cs:385-407, 464-471`.
13. **4.3:** `CommandHelpWindow.xaml.cs:347-356`.
14. **5.1-5.3:** `CommandHelpWindow.xaml.cs:226, 306-308, 334-335, 106, 288`.
15. **7 BUG-1219:** `command-registry.json:2071-2085` (command "8"), `2672-2686` (RJSET) prompts; `Commands\BeamSettingsCommands.cs:22` and `Commands\RafterJoistCommands.cs:90` per the carpark entry (not re-read).
16. **7 BUG-1077:** `command-registry.json:2158-2170` (line 2164 short text).
17. **7 BUG-1079:** `command-registry.json:4212-4226` (long text 4219, notes 4224).
18. **7 BUG-1078:** `command-registry.json:671-678, 739-746, 756-763`; group `"Administration"` on each.
19. **7 new 1:** `CommandHelpWindow.xaml.cs:43-49, 101-107`.
20. **7 new 3:** `CommandHelpWindow.xaml.cs:347-366, 441`.
21. **7 new 4:** `CommandHelpWindow.xaml.cs:409-421`.
22. **7 new 5:** `command-registry.json:1941-1943, 1959-1961, 1977-1979, 4147-4149, 75-83`; `CommandHelpWindow.xaml.cs:47, 71`; `command-registry.json:1965`.
23. **7 new 6:** `command-registry.json:345-347`.
24. **8.1:** no `#if` in `CommandHelpWindow.xaml.cs`, `AdminCommands.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 03:20. Nothing was run in AutoCAD.
