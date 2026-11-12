# TOOL NOTE: Bracing panel, provided against required (CSBRACINGPANEL)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Opens a small window "CE Bracing"** headed "BRACING - PROVIDED vs REQUIRED", with one line for North-South and one for East-West.
2. **Adds up the length of the bracing blocks in the drawing** for each direction and shows it against the required length you typed with CSBRACINGREQUIRED.
3. **Keeps itself up to date** after every command, when you switch drawing, every 5 seconds, and on its Refresh button. It only reads while AutoCAD is idle.
4. **CE does not work out the required bracing.** There is no bracing table in CE. The figure is typed in by you.

## 2. What it changes in the drawing

1. **Nothing.** It reads blocks and draws nothing. The code reads in a way meant to keep REDO available after U (a code comment says so; not proven here).
2. **It never saves the drawing.**
3. **It replaces CE's in-memory job record** with a fresh read of the bracing blocks each time. Nothing is written to the drawing or to a file by the panel.
4. **CSBRACINGREQUIRED (the companion command)** saves your two required figures in CE's Settings file on your PC. Not in the drawing.

## 3. What it will not do

1. **Counts only blocks named BRACING in Model space.** Older-named brace blocks, Xref content and layouts are not counted.
2. **Does not look at layer state.** A brace on a frozen or off layer is counted.
3. **Does not convert units.** A length is added as the block holds it, so a 2.7 m brace in a metre drawing reads as 2.7.
4. **Does not weight by type.** Metres of type A, type B and BT trusses are added together.
5. **Decides the direction from the drawing's own X axis.** A brace within 45 degrees of X counts East-West, and exactly 45 counts East-West. A plan turned on the sheet gets the wrong split.
6. **Does not refuse** any drawing. It opens whenever a drawing is open.

## 4. What it asks you, and what Enter means

1. **The command asks nothing.** It prints "Bracing panel shown at the top right of the AutoCAD window. Set required lengths with CSBRACINGREQUIRED." Typed again, it refreshes the open panel.
2. **If the window cannot open:** "The bracing panel could not open. Try CSBRACINGPANEL again; if it still does not show, tell CE support." If it opens but is not visible: "The bracing panel did not appear on screen. Try CSBRACINGPANEL again; if it still does not show, tell CE support."
3. **CSBRACINGREQUIRED asks:** "Required North-South bracing (mm), or blank to leave <not set>:" then the same for East-West. Enter keeps the figure shown. A typed number that is not read is ignored without a line, and the last line then shows the old figure.
4. **Then it prints** "Required bracing set: North-South <n> mm, East-West <m> mm." or "not set".

## 5. When it says Unknown or "needs checking"

1. **"<n> mm provided / required not set"** with a gold triangle: you have not typed a required figure. Type it with CSBRACINGREQUIRED.
2. **"(lengths only, brace types not weighted)"** with a gold triangle: the direction mixes brace types and the metres reach the figure. CE will not show a green tick. Check the braces by hand.
3. **A green tick** means the metres add up to the figure and the types do not mix. **A red cross** means the metres are short, even when types mix.
4. **The panel cannot say when it could not read the drawing.** See fault 7 new 3.

## 6. How to undo it

1. **Nothing to undo in the drawing.** Close the window with X.
2. **U does not undo** the required figures saved in the Settings file. Type CSBRACINGREQUIRED again.

## 7. Known faults

**Still open**
1. **BUG-499:** the panel adds BT1 roof trusses to the wall bracing "provided". It also adds type A and type B together, and reads a brace with no type tag as type A. The code is unchanged. A draft fix (PR #2047) leaves BT numbers out, and is not in this build. The rule needs Tim's word.
2. **BUG-500 and BUG-533:** the required figures are kept on the PC, not with the job, so the last job's figure shows on the next job. A figure that cannot be read is ignored. There is no way back to "not set": a blank keeps the old figure. 0 and negative figures are accepted, and 0 shows a green tick.
3. **BUG-503 (item 2):** units and direction as in section 3, lines 3 and 5.
4. **BUG-503 (the other items):** listed against this tool. They are about the bracing schedule and other wording, not the panel.

**Partly fixed**
1. **BUG-950:** a direction that mixes brace types now shows the "lengths only" line and never goes green. The metres are still added across types and there is no rating per type. The switch that does this ships on and no box for it was found on the Settings window.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **None.**

**New in code, no bug covers it**
1. **Older-named brace blocks count as zero.** ABS recognises "A - BRACING LEFT", "A - BRACING RIGHT" and "B - BRACING"; the panel reads only the name BRACING. A drawing with old blocks shows too little provided.
2. **Braces on a frozen or off layer are counted,** so the provided figure can be too high.
3. **A failed read keeps the old numbers on screen with no sign.** The panel swallows the error and leaves the last figures as if current.

## 8. On AutoCAD 2022 to 2024

1. **No version difference found on this path** (no `#if` in `BracingPanelCommands.cs`, `BracingPanelWindow.xaml.cs`, `BracingPanelService.cs`, `ProjectDataService.cs` or `BracingPanelCalculator.cs`). Not run on 2022 to 2024.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.
2. **For the record:** the carpark lists BUG-218 (the panel did not appear) as FIXED on a Codex narrow pass on 1.0.116. That is the record, not this note's proof.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\` (the calculator is under `Modules\Structural.DesignCore\`).

1. **1.1:** `Commands\BracingPanelCommands.cs:20-59`; `UI\Dialogs\BracingPanelWindow.xaml:4, 30, 38, 49`.
2. **1.2:** `Services\BracingPanelService.cs:16-32`; `Structural.DesignCore\BracingPanelCalculator.cs:63-106`.
3. **1.3:** `UI\Dialogs\BracingPanelWindow.xaml.cs:32-33, 61-109`; `xaml:54` (Refresh button).
4. **1.4:** `Models\UserSettings.cs:806-812` (the comment says there is no bracing table); `Structural.DesignCore\BracingPanelCalculator.cs:38-45`.
5. **2.1:** `Services\ProjectDataService.cs:223-231, 261-263` (read-only read, BUG-256).
6. **2.2:** no save call in `BracingPanelCommands.cs`, `BracingPanelWindow.xaml.cs`, `BracingPanelService.cs`.
7. **2.3:** `ProjectDataService.cs:234-259, 313`.
8. **2.4, 4.3, 4.4, 7 BUG-500:** `BracingPanelCommands.cs:89-127`; `Models\UserSettings.cs:811-812`.
9. **3.1, 7 new 1:** `ProjectDataService.cs:266-286` (name BRACING only, Model space only); older names read by `Services\BracingService.cs:2079-2104`.
10. **3.2, 7 new 2:** `ProjectDataService.cs:268-286, 316-337` (no layer state read).
11. **3.3, 7 BUG-503:** `ProjectDataService.cs:322`; `BracingPanelService.cs:28-29`; no unit step in `BracingPanelCalculator.cs`.
12. **3.4, 7 BUG-499:** `BracingPanelCalculator.cs:74-89`; `ProjectDataService.cs:282-286, 318-320`; BT1 tag `Commands\BracingCommands.cs:332-334`.
13. **3.5:** `BracingPanelCalculator.cs:54-61, 79`.
14. **3.6:** `BracingPanelCommands.cs:23` (context only, no start check).
15. **4.1, 4.2:** `BracingPanelCommands.cs:48, 54, 58`.
16. **5.1, 5.2, 5.3:** `BracingPanelWindow.xaml.cs:125-155`; `BracingPanelCalculator.cs:108-117`.
17. **5.4, 7 new 3:** `BracingPanelWindow.xaml.cs:111-123` (catch with nothing shown).
18. **7 BUG-950:** `BracingPanelCalculator.cs:97-104, 108-117`; `Models\UserSettings.cs:814-816`; no match for the name in `UI\Dialogs\CeSettingsDialog.xaml.cs`.
19. **7 BUG-500 (0 shows a tick):** `BracingPanelCommands.cs:103-108, 117-121`; `BracingPanelCalculator.cs:112-116`.
20. **8.1:** no `#if` in the five files named.
21. **9.2:** BUG-218 in `C:\CE_PLAN\BUG_CARPARK.md`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026. Nothing was run in AutoCAD.
