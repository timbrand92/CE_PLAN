# TOOL NOTE: Reverse flow (CDREVERSEFLOW)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Turns one pipe around:** swaps its From and To, with their end levels, and flips the flow arrow.
2. **The pipe route stays where it is,** and each label stays at the same spot on the plan.
3. **Explains what it will do and asks Yes or No first.**

## 2. What it changes in the drawing

1. **The pipe's point order** is reversed (route and curves unchanged).
2. **Each end level** moves to the other physical end, and the level text wording follows. A blank level is never turned into 0.00.
3. **Labels** keep their physical spot (their position along the pipe is mirrored and their side flipped).
4. **The flow arrow** turns 180 degrees.
5. **CE's record:** From and To names and their pit links swap; saved connection decisions swap ends; each connected pit's note of which pipe end it holds is flipped. Nothing else on the pits changes.
6. **No schedule refresh** and no whole-drawing record update.

## 3. What it will not do

1. **No start-up checks.** It does not check for a read-only drawing, Paper Space, or a Structural drawing, and asks nothing about the drawing type.
2. **Refuses after Yes** if the pipe is on a locked layer, in an Xref, or REFEDIT is open: "The pipe is protected by a locked layer, Xref or active reference editing. Nothing was changed." If AutoCAD cannot say whether REFEDIT is open, it refuses.
3. **Also refuses:** a protected label or connected pit end; one half of a linked breakline pair; a level at one end but not the other ("Reverse Flow needs matching invert presence at both ends"); an invalid level; a custom-worded level label; a pipe with no link record ("The pipe has no linked end data. Nothing was changed.").

## 4. What it asks you, and what Enter means

1. **One pipe already selected** is used without asking. Otherwise **"Pick the pipe whose flow should reverse"**. A wrong pick: "That is not a pipe. Click the pipe line or its outline." Esc ends quietly.
2. **"Reverse Flow swaps From/To and their end values, and flips the arrow. The pipe route, barrels and label positions stay put. One Undo. Continue? [Yes/No] <No>":** **Enter = No**. Enter, No or Esc: "Nothing was changed." Nothing is written before Yes.
3. **No preview window and no Apply button.**

## 5. When it says Unknown or "needs checking"

1. **CE's record not loaded for this drawing:** after Yes it may only say "Reverse Flow could not run. Nothing was changed." (read from code, not run).

## 6. How to undo it

1. **U once.** The whole change is one step. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under this command.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1220:** Help used to promise a preview and an Apply button; the shipped Help now says there is no preview window, no Apply button, and Enter means No.

**New in code, no bug covers it**
1. **No start-up checks** (read-only, Paper Space, Structural drawing). REFEDIT is caught only by the writer, after Yes.
2. **The ribbon tooltip still says** "Lists what else changes (ILs, arrow, schedule rows) and asks first"; it lists none of these and no schedule refresh was found.
3. **The command list text says "labels and decisions swap"**; labels in fact keep their spot.

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1 to 1.3, 4.2:** `Commands\RibbonContextCommands.cs:30-73` (question and default at 48-60).
2. **2.1 to 2.4:** `Services\LinkService.NetworkEdits.cs:194`, `250-256`, `309-328`, `354-382`, `453-463`.
3. **2.5:** `LinkService.NetworkEdits.cs:257-273`, `386-406`; `Services\ProjectDataService.Spine.cs:261-275`.
4. **2.6:** no schedule refresh or record update call on this path.
5. **3.1, 7 new 1:** no `CommandPreFlight` in `RibbonContextCommands.cs:30-73`.
6. **3.2:** `LinkService.NetworkEdits.cs:220-225`; `Services\LinkService.Spine.cs:735-762`.
7. **3.3:** `LinkService.NetworkEdits.cs:233, 339, 368, 397, 429, 438, 445`.
8. **4.1:** `RibbonContextCommands.cs:38-44`; `Services\PipePickService.cs:39-45`.
9. **5.1:** `Services\LinkService.Spine.cs:677-682`; `Services\ProjectDataService.Spine.cs:73-74`; `RibbonContextCommands.cs:68-72`.
10. **6.1:** `LinkService.NetworkEdits.cs:277` (one commit).
11. **7 BUG-1220:** `Assets\Help\guide-content.js:103`.
12. **7 new 2:** `Services\CeCvlRibbonContributor.cs:197-198`. **7 new 3:** `Assets\Config\command-registry.json:1063`.
13. **8.1:** the only `#if` in `RibbonContextCommands.cs` (line 25) is in CDCLOSETAB.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:43. Nothing was run in AutoCAD.
