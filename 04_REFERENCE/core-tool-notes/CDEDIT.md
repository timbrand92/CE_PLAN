# TOOL NOTE: Edit the pit or pipe you pick (CDEDIT)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Opens the right editor for what you pick:** Edit Pipe for a pipe, Edit Pit for a pit, Edit Source for a tagged source. Picking a CE label or level text opens its pipe or pit.
2. **Several of one kind selected first** (pits only, or pipes only) opens the batch editor.
3. **Save writes the changes;** Cancel closes the editor.

## 2. What it changes in the drawing

1. **Quiet record update first.** As soon as it knows what you picked, it brings CE's record up to date with the drawing (only if something changed): adds missing pits and pipes, drops records whose object is gone, re-reads details, fills blank pit inverts. Nothing is printed.
2. **Edit Pipe Save:** the pipe record, the pipe, its labels, level text, flow arrow and From/To names, in one step. Then it may ask about downstream levels and tidy clashing text near the pipe. **Save also adds the size, material and both levels to the Recent lists and saves your Settings file, on the button press, even if the save is then refused.**
3. **Edit Pit Save:** the pit block, its label and cover text; if the number changed, the connected pipes' records and notes; then the pit record. A change of size, rotation or SPS radius moves connected pipe ends to the new walls. A drawn Pit Schedule is refreshed.
4. **Edit Pit also saves about 22 values as the next New Pit's starting values** when you press Save, before the drawing is changed, even if the save is then refused.
5. **Edit Pit with nothing changed** still rewrites the pit record and clears its "levels to check" flag.

## 3. What it will not do

1. **Refuses before anything is asked:** a read-only drawing, Paper Space, REFEDIT open, a Structural drawing (asks first).
2. **Mixed selection** (pits with pipes or sources): "CDEDIT edits one type at a time - reselect one family only." The odd objects are left highlighted.
3. **More than one source,** or a source with other things: refused; one source at a time.
4. **Objects that are not CE** in a selection are skipped with a line, the rest carries on.
5. **Edit Pit refuses after Save** if the pit, its label, number or cover text is on a locked layer or in an Xref. It reopens the window with your entries kept. The pit-block line says "unlock it, or leave it out", which means nothing in a single edit.
6. **Edit Pipe single Save: no locked-layer check found.** What happens with a locked pipe or label layer is not known from the code.
7. **Blank cover level** blocks Edit Pit Save ("Enter the cover level.").

## 4. What it asks you, and what Enter means

1. **"Select a pit, pipe, source or CE text to edit":** Esc ends with nothing changed. Enter: not known from the code (an empty answer is not allowed).
2. **Edit Pipe and Edit Pit windows:** Enter = **Save**. Cancel or Esc closes.
3. **Batch window:** Enter = **Apply to Selected**.
4. **"Recalculate downstream inverts?"** (after a pipe Save that changed the downstream level): a Yes/No box, Enter = Yes, then a preview. The pipe is already saved either way.
5. **Older pipe whose label CE cannot read:** "Is the highlighted text ... this pipe's label? [Yes/No] <Yes>". **Enter = Yes and records that text as the pipe's label** straight away; then "an extra note for this pipe? <Yes>" for each other text. Cancel later keeps those answers.
6. **Pipe label position missing:** asks for a point; Esc says "The pipe label position was not picked."
7. **Inspect drawing (single pit):** "Press Enter to reopen PITEDIT". Esc ends. In the batch editor Esc reopens the window instead.
8. **Pit batch, pit with no label:** "Specify pit label insertion point". Esc: "Pit batch cancelled before any drawing change."

## 5. When it says Unknown or "needs checking"

1. **Blank invert on a pipe** is a warning, not a block (switch on).
2. **Batch with a ticked but blank field:** that field is left out and the rest applies (switch on). If the only ticked field is blank, Apply stays off.
3. **Pipe batch:** pipes CE cannot read are left out and named. **Pit batch:** if any pit cannot be read, the whole batch is refused and the pits named.
4. **Partly refused pit edit:** the record is put back but the drawing keeps what was written; it tells you to press U once.

## 6. How to undo it

1. **U once** for a Save: the edit, the moved pipe ends, the schedule refresh and the record. A batch Apply is one step ("One Ctrl+Z undoes all of it").
2. **Not undone by U:** Edit Pit's remembered values on your PC, and Edit Pipe's Recent size, material and level lists (and the Settings file saved with them).
3. **Cancel does not undo the quiet record update** that ran before the window (Edit Pipe holds its own second update until Save; Edit Pit holds nothing).

## 7. Known faults

**Still there in this build**
1. **BUG-1042:** blank cover level blocks Edit Pit Save. Way round: type the level.
2. **BUG-677, part:** a batch on pits with no CE record rewrites the drawn number with a new one. Duplicate numbers are fixed.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-1043:** a blank invert no longer blocks Save (switch on).
2. **BUG-1049:** one blank ticked field no longer blocks a batch (switch on).
3. **BUG-070, 072, 078, 094, 186, 223, 291, 674:** suggestion decimals, label position on resize, moving level text, picking MLINE or polyline pipes, the Edit 2 Pipes "changed after the preview" refusal, flow direction with two open ends, which end is upstream in grade working, multi-pit resize.
4. **BUG-071:** the two popups it names belong to CD, and both are fixed there.

**Reported, could not confirm in code**
1. **BUG-173:** the windows are now the one-page editors; whether they look right cannot be read from code.
2. **BUG-445:** the marker it names is written by the Pit Schedule, not CDEDIT.

**New in code, no bug covers it**
1. **Edit Pipe single Save has no locked-layer or Xref check** found (batch and cascade do).
2. **Edit Pit saves next-pit defaults before checking it may write.**
3. **"Unlock it, or leave it out"** wording in single Edit Pit.
4. **Esc at "Press Enter to reopen"** ends a single pit edit but reopens the batch editor.

## 8. On AutoCAD 2022 to 2026 (every build except 2027)

1. **Same commands and questions.**
2. **Edit Pipe shows a schematic** (also on 2025 and 2026) instead of the real plan beside the pipe.
3. **Edit Pit shows a sketch** (also on 2025 and 2026) instead of the real pit block, and clicking a pipe tag on it does nothing.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1:** `Commands\HubCommands.cs:75`, `125-140` (RouteSingleTarget), `PipeEditCommand.cs`, `PitEditCommand.cs:244, 280`.
2. **1.2, 3.2, 3.3, 3.4:** `HubCommands.cs:100-105`, `185-300` (mixed `227-235`, sources `237-247`, non-CE `254-259`, batch `288`).
3. **2.1:** `HubCommands.cs:134-135`, `188`; `Services\ProjectDataService.cs:595-693`.
4. **2.2:** `ViewModels\CdViewModel.Commands.cs:43-51` (Save adds Recent size, material and levels and saves Settings; Edit Pipe uses this view model, `PipeEditCommand.cs:128`); `Commands\PipeEditCommand.Update.cs:548-567`, `1122-1125`, `1257-1340`; `PipeEditCommand.cs:236-237`; `ViewModels\CdViewModel.Settings.cs:248-251`.
5. **2.3:** `Commands\PitEditCommand.cs:415-445`, `576-659`.
6. **2.4, 7 new 2:** `ViewModels\PitViewModel.cs:980-991`, `1229-1258`.
7. **2.5:** `PitEditCommand.cs:632-647` (line 638).
8. **3.1:** `HubCommands.cs:86`; `Services\DrawingSafetyService.cs:61-131`.
9. **3.5, 7 new 3:** `PitEditCommand.cs:667-725`; `Services\CeBatchEditApplyCoordinator.cs:292-326`; `Rules\PitAnnotationLockRule.cs:36-46`; `Commands\Editing\CeEditRetryPolicy.cs:55-90`.
10. **3.6, 7 new 1:** no lock check in `Commands\PipeEditCommand*.cs` for the single Save; batch `PipeEditCommand.SizeWrite.cs:328-351`, cascade `PipeEditCommand.Batch.Cascade.cs:903-963`.
11. **3.7, 7 BUG-1042:** `Rules\PitStartReadiness.cs:124-125`.
12. **4.1:** `HubCommands.cs:107-116`.
13. **4.2, 4.3:** `Dialogs\PipeEditWorkshopDialog.xaml:493-494`; `Dialogs\PitEditWorkshopDialog.xaml:330-331`; `Dialogs\BatchEditWorkshopDialog.xaml:388-392`; window choice `Services\DialogService.cs:49, 71-105, 241-248`.
14. **4.4:** `PipeEditCommand.Update.cs:2036-2086`; `Services\DialogService.cs:303-306`.
15. **4.5:** `Commands\PipeEditCommand.OlderPipeLabels.cs:21-23`, `164-264`, `414-430`; `Rules\OlderPipeLabelRule.cs:194-207`.
16. **4.6:** `PipeEditCommand.Update.cs:522` (the message).
17. **4.7, 7 new 4:** `PitEditCommand.cs:287-297`; `Commands\BatchEditDialogHost.cs:41-48`.
18. **4.8:** `Commands\PitEditCommand.Batch.cs:546-562`.
19. **5.1, 7 BUG-1043:** `Models\UserSettings.cs:1633-1639`; `Rules\PipeStartReadiness.cs:195-208`.
20. **5.2, 7 BUG-1049:** `UserSettings.cs:626-629`; `ViewModels\Shell\CeBatchEditViewModel.cs:288-300`.
21. **5.3:** `PipeEditCommand.Batch.cs:70-86, 109-138`; `PitEditCommand.Batch.cs:55-65`.
22. **5.4:** `PitEditCommand.cs:649-656`; `CeEditRetryPolicy.cs:63-80`.
23. **6.1:** `HubCommands.cs:154-164`; `PitEditCommand.cs:424-458`; `PitEditCommand.Batch.cs:682-698`.
24. **6.3:** `PipeEditCommand.cs:54-59`, `112`, `225`; no hold in `PitEditCommand*.cs` (update at `PitEditCommand.cs:64`).
25. **7 BUG-677:** `PitEditCommand.Batch.cs:511-515`, `540-542`, `788-792`; `PitEditCommand.cs:1189`.
26. **7 fixed list:** BUG-070 `ViewModels\CdViewModel.GradeSuggestion.cs:486, 540-544`; BUG-072 `Helpers\PitAnnotationShift.cs`, `PitEditCommand.cs:1693`; BUG-078 `PipeEditCommand.Attachments.cs:418-520`; BUG-094 `HubCommands.cs:110, 141, 199`; BUG-186 `PipeEditCommand.Batch.cs:849-862`; BUG-223 `PipeEditCommand.Update.cs:1779-1800`; BUG-291 `PipeEditCommand.Update.cs:239-250`; BUG-674 `PitEditCommand.Batch.cs:681-731`; BUG-071 `Dialogs\GradeMismatchDialog.xaml:6`, `Dialogs\ContinueRisingMainDialog.xaml:6`.
27. **8.2:** `Dialogs\PipeOnePageLayout.cs:246-265` (`#if NET10_0_OR_GREATER`, so every other build). **8.3:** `Dialogs\PitOnePageLayout.cs:96-113` (same `#if`/`#else`). The `#if NET48` in `HubCommands.cs:793` is CDMENU, not CDEDIT.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
