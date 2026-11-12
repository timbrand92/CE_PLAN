# TOOL NOTE: Water tank (CDWT)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a water tank** from the office tank plan drawing, or **tags a block already in the drawing** as the tank.
2. **Records the tank** with its total, detention and reuse litres, a WT tag and a callout.
3. **Optionally adds a riser and a dropper**, tagged R and D.

## 2. What it changes in the drawing

1. **Draws** the tank plan block (copied from the office master drawing) on the water tank layer, a WT label on GUIDELINES, a callout leader on the dimension text layer, and any riser and dropper on DOWNPIPES.
2. **Adopting a block** moves that block to the water tank layer.
3. **Callout words:** "WT1 - N lt WATER TANK / N lt FOR DETENTION / N lt FOR REUSE", or one line for reuse only when detention is 0, plus "BASE RL x.xx" if given.
4. **Stores** a WT record (not in the Pit Schedule): total, base RL, tank facts. Above or below ground is not stored.
5. **Full record update before the window.** It runs CE's forced whole-drawing record update first. Cancel afterwards does not take it back.
6. **Block definitions are loaded early:** the plan block before the callout question, and the riser and dropper each before their question, even if you skip them.
7. **Picking a plan picture in the window saves that pairing to your Settings straight away,** even if you then cancel.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open. A Structural or untagged drawing is asked first, and the answer is applied only when the tank is placed.
2. **Locked water tank, downpipe or dimension text layer:** "CDWT refused - Layer X is locked. Nothing was placed." Checked before the window and again at placing. GUIDELINES is not checked.
3. **Office tank drawing not found** (Settings folder blank, missing, or no master file): the window is skipped with **no message**; Insert is then refused after the first question, naming the files but not the folder.
4. **Block already a source:** "That block is already the source WTn. Tags are never recycled; nothing was changed."
5. **Does not refuse an Xref** picked as the block to adopt.
6. **Metre drawings:** no unit handling found; parts go in at scale 1.

## 4. What it asks you, and what Enter means

1. **Water tank window (AutoCAD 2027 only):** Enter = **Place tank**. Cancel: "CDWT cancelled - nothing was placed." A third button tags a block already in the drawing.
2. **Command line instead** (older AutoCAD, or no office drawing): "Adopt ... or Insert ...?" Enter = Insert; "Tank goes [AboveGround/Underground]" Enter = AboveGround; tank choice (first 9 library tanks) Enter = type the litres; "Detention volume (litres)" Enter = the library figure, or 0; "Total capacity (litres)" Enter not accepted; plan block (first 9) Enter not accepted.
3. **"Specify water tank insertion point":** Enter or Esc: "CDWT cancelled - nothing was placed."
4. **"Specify callout text location (Enter to skip)",** then **"Base RL for the callout (Enter to skip)"** (Esc here cancels).
5. **"Specify RISER insertion point (Enter to skip)",** **"Specify DROPPER insertion point (Enter to skip)".**
6. **Esc at the callout, riser or dropper question only skips that part;** the tank is still placed.

## 5. When it says Unknown or "needs checking"

1. **Detention more than total:** "Detention (X) exceeds Total (Y). Nothing was placed."
2. **No orifice is asked,** so no orifice or site discharge check can run (see 7).

## 6. How to undo it

1. **U once.** It says "One Undo removes all of it." Not proven in AutoCAD.
2. **Not undone by U:** the plan pairing saved to Settings, the record update before the window, and the early-loaded block definitions.

## 7. Known faults

**Still there in this build**
1. **BUG-1081:** riser and dropper lettering is written onto a locked layer; GUIDELINES is not checked either.
2. **BUG-1083:** an attached Xref is accepted as the block to adopt, and moved to the water tank layer.
3. **BUG-1102:** the council underground-detention minimum is never checked; above or below ground is not even stored.
4. **BUG-1104:** no orifice is asked, so the orifice minimum and "tank flows add up to no more than site PSD" are never checked.
5. **BUG-1115:** on the command line a typed detention of 0 becomes the library figure.
6. **BUG-1174:** the window is skipped without saying why.
7. **BUG-1212:** no window or pictures on older AutoCAD; true for 2025 and 2026 as well as 2022 to 2024.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-020:** riser and dropper are tagged R and D and their attributes filled. Whether the tag shows twice could not be confirmed without the block files.

**New in code, no bug covers it**
1. **Esc does not cancel** at the detention, callout, riser and dropper questions.
2. **Window route loses the library tank's details** (make, size, lid), so the make-and-size callout line can never appear.
3. **Only 9 choices on the command line** for tanks and plan blocks.
4. **Full record update before the window,** and early block loads, both left by Cancel.

## 8. On AutoCAD 2022 to 2024

1. **No window and no pictures:** the command-line route only (also on 2025 and 2026).
2. **Plan block chosen by typed key** from the first 9 blocks in the office drawing; 2027 opens a picker window instead.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1, 2.2:** `Commands\WaterTankCommand.cs:46`, `352-376`; `Commands\WaterTankCommand.Apply.cs:85-168`, `229-290`; `Services\WaterTankPlanBlockSource.cs:293, 307`.
2. **2.3:** `Commands\WaterTankCommand.Plan.cs:155-196`; `Models\TankCalloutSettings.cs:13`.
3. **2.4:** `WaterTankCommand.Apply.cs:314-357`.
4. **2.5, 7 new 4:** `WaterTankCommand.cs:57`; `Commands\CeCommandBase.cs:43-47`; `Services\ProjectDataService.cs:264-269`.
5. **2.6:** `WaterTankCommand.cs:194-198`, `668-672`.
6. **2.7:** `Dialogs\WaterTankDialog.xaml.cs:298-312`; `Services\SettingsService.cs:1054-1063`.
7. **3.1:** `WaterTankCommand.cs:51-53`; `WaterTankCommand.Apply.cs:102`.
8. **3.2:** `WaterTankCommand.cs:62`; `WaterTankCommand.Apply.cs:39-47, 80-82`.
9. **3.3, 7 BUG-1174:** `WaterTankCommand.cs:90-93`, `119-124`; `WaterTankPlanBlockSource.cs:23-25, 92-109`; `Models\UserSettings.cs:2158-2167`.
10. **3.4:** `WaterTankCommand.cs:372`.
11. **3.5, 7 BUG-1083:** `WaterTankCommand.cs:352-376`; `WaterTankCommand.Apply.cs:88-97, 229`.
12. **3.6:** no unit handling in `WaterTankPlanBlockSource.cs`; `WaterTankCommand.Apply.cs:236, 252`.
13. **4.1:** `Dialogs\WaterTankDialog.xaml:285-290`; `WaterTankCommand.cs:96`.
14. **4.2:** `WaterTankCommand.cs:336-342`, `438-443`, `477-517`, `628`; `Rules\TankLibrary.cs:210`; `WaterTankPlanBlockSource.cs:170`.
15. **4.3 to 4.6, 7 new 1:** `WaterTankCommand.cs:143-148`, `222-260`, `498-517`, `657`, `690-692`.
16. **5.1:** `WaterTankCommand.cs:598-602`.
17. **6.1:** `WaterTankCommand.Apply.cs:218`.
18. **7 BUG-1081:** `WaterTankCommand.Apply.cs:41, 288`; `Services\BlockService.cs:1475-1499`; `Services\SourceTagService.cs:628-630`.
19. **7 BUG-1102, 1104:** `WaterTankCommand.cs:628`; `WaterTankCommand.Apply.cs:342-357` (no position or orifice field).
20. **7 BUG-1115:** `WaterTankCommand.cs:501`.
21. **7 BUG-1212, 8.1, 8.2:** `WaterTankCommand.cs:425-439, 562`; `Dialogs\WaterTankDialog.xaml.cs:1`; `CE_CVL_SUITE.csproj:272-278`.
22. **7 BUG-020:** `WaterTankCommand.Apply.cs:134, 141, 281-290`.
23. **7 new 2:** `WaterTankCommand.cs:81, 93, 155-157, 171-173`. **7 new 3:** `Rules\TankLibrary.cs:210`; `WaterTankPlanBlockSource.cs:170`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:40. Nothing was run in AutoCAD.
