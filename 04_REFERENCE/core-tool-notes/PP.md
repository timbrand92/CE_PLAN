# TOOL NOTE: Quick plastic pit (PP)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Places a 350 x 350 plastic grated pit** using the same placing steps as PIT, with the plastic pit settings filled in for you.
2. **Point first, then the window,** then the cover text. Carries on to the next pit until Esc.

## 2. What it changes in the drawing

1. **Same as PIT:** draws the pit and its cover text, stores it in CE's record, splits a pipe it lands on and rejoins pipe ends, runs the quiet record update before the point question, and saves the window's values as next time's starting values.
2. **Filled in for you:** grated pit, 350 x 350, lid class C (unless a lid was already chosen), cover text on at BR (unless another corner was chosen), no invert shown, text above, text below and remarks cleared.
3. **No number and no schedule row by default.** A plastic pit has its number label and schedule row switched off; the "Number and schedule" button in the window switches both back on for this pit.

## 3. What it will not do

1. **Same refusals as PIT:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first), locked pit, label, number or cover text layer (checked after the window).
2. **Blank cover level** blocks the Place Pit button ("Enter the cover level.").
3. **Metre drawings:** the pit is sized straight from 350 mm at scale 1, with no conversion.

## 4. What it asks you, and what Enter means

1. **"Specify pit insertion point":** Enter is not accepted. Esc ends with "PP command cancelled."
2. **New Pit window:** PP opens the **older tabbed window**, not the one-page window PIT uses. Enter = **Place Pit**. Cancel or Esc ends.
3. **Inspect drawing:** "Press Enter to reopen PP". Enter reopens, Esc ends.
4. **Pit label point:** asked only if you switched numbering on. Enter not accepted; Esc places no label, and a numbered plastic pit then goes back to unnumbered and out of the schedule.
5. **"Click to place cover text (Enter = <BR>)":** Enter = the corner shown. Esc places no cover text (a Settings switch, off by default, puts it at the usual corner instead).
6. **Next pit:** "Pick the next pit, or press Esc to stop."

## 5. When it says Unknown or "needs checking"

1. **No Unknown.** A blank cover level is refused, not shown as Unknown.
2. **Unnumbered:** "Plastic pit retained unnumbered (no label) and excluded from the schedule." when a label was asked for and Esc was pressed.

## 6. How to undo it

1. **U once per pit.**
2. **Not undone by U:** the remembered window values on your PC.

## 7. Known faults

**Still there in this build**
1. **BUG-1042** (filed under PIT, same window rule): a blank cover level blocks placing.
2. **BUG-287** (filed under PIT): a metre drawing gets the pit sized in millimetres with no warning.

**Already fixed in this build, not yet seen working in AutoCAD** (shared with PIT)
1. **BUG-458:** refuses while REFEDIT is open.
2. **BUG-690 to 693:** splitting a pipe under the new pit.

**New in code, no bug covers it**
1. **PP and PIT open different windows.** The code says PP keeps its old window "until separately reviewed". A drafter moving between PIT and PP sees two different layouts.

No bugs are filed under PP itself.

## 8. On AutoCAD 2022 to 2024

1. **Same questions.**
2. **The window shows no real pit block picture** (the picture is built only for AutoCAD 2027).

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.2:** `Commands\PitCommand.cs:68-72`, `650-673` (the preset).
2. **1.2, 2.1, 3.1, 4.1, 4.3, 4.6, 6.1:** the shared PIT path, `PitCommand.cs:74-231` (same lines as the PIT note).
3. **2.3:** `ViewModels\PitViewModel.cs:741-771`; `Rules\PitPresetLocks.cs:55-56`; `PitViewModel.cs:993-1001` (Number and schedule button); `PitCommand.cs:857-861`.
4. **3.2, 7 BUG-1042:** `Rules\PitStartReadiness.cs:124-125`.
5. **3.3:** `PitCommand.cs:394-399`, `715-720`.
6. **4.2, 7 new 1:** `Dialogs\WorkshopPitCreation.cs:18-22` (only a command named PIT gets the one-page window); `Dialogs\WorkshopEditorSession.cs:90-98`; `Dialogs\PitDialog.xaml:629` (Place Pit is the default button), `658` (Cancel); `PitViewModel.cs:292`.
7. **4.4, 5.2:** `PitCommand.cs:475-530`, `633-644`.
8. **4.5:** `PitCommand.cs:532-557`, `988-1004`; `Models\UserSettings.cs:1425`.
9. **6.2:** `PitViewModel.cs:980-991`, `1229-1258`.
10. **7 BUG-458, 690-693:** as in the PIT note (`Services\DrawingSafetyService.cs:78-90`; `Services\LinkService.Split.cs:1555-1665`).
11. **8.2:** `Dialogs\PitDialog.xaml.cs:44-60` (`#if NET10_0_OR_GREATER`; the build for AutoCAD 2022 to 2024 is net48).

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:34. Nothing was run in AutoCAD.
