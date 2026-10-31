# BUGFIX x8 report, B-114: separate 75 mm cover row for reinforced concrete (31 Oct 2026)

## FOR TIM

1. **Answer: NO PR opened. I need your word on one thing first.** CE has no way to tell a reinforced-concrete slab from any other slab, and you said not to invent a new surface choice. B-114 is held until CE 04 asks you.
2. **What a drafter picks today.** The Pit window "Surface" list has exactly five choices: Garden, Footpath, Driveway, Driveway (larger vehicles), Road. None of them means "reinforced concrete". Today Footpath and Driveway both read 100 mm plus the slab thickness (built in B-102).
3. **A possible mix-up in the 100 / 75 figures. Please check this one.** Your decision 154 says "100 mm (75 mm for reinforced concrete)". The Frankston guideline table we hold (CE_PLAN\02_COUNCIL_RULES\COUNCIL_FRANKSTON_DEV_GUIDELINES.md, lines 80 to 83) says the opposite way round: reinforced concrete pavement, heavy vehicles = 100 mm below the underside; brick or un-reinforced concrete, light vehicles = 75 mm below the underside. I have not read the original PDF, only our notes of it. If the table is right, a plain residential driveway should be 75 and the reinforced/heavy one 100.
4. **Options (my pick is 1).**
   1. **Add one new Surface choice, "Driveway (reinforced concrete)", with its own Settings row (your figure, 75 or 100 once item 3 is settled).** The drafter picks it in the Pit window like any other surface. The cover line in CDRULES and the Inspector reads, for example, "Driveway (reinforced concrete); 75 mm plus 100 mm slab". Small Civil job, switch ON, warns never blocks. Costs one extra pick in a list the drafter already uses. Needs your yes because you said no new choice without asking.
   2. **No new pick; change the Driveway row in Settings only.** Zero code today: set Driveway to 75 (or 100) in the cover table. Every driveway then gets that one figure, reinforced or not. Cheapest, but CE cannot tell the two apart.
   3. **A tick-box "slab is reinforced" on each pit.** Most exact, but it adds a field to the Pit window and the saved pit data. I do not recommend it.
5. **Questions for you (one batch).**
   1. Which way round is it: reinforced = 75 (your note) or reinforced = 100 (Frankston table)?
   2. Option 1, 2 or 3?
   3. If option 1: should the existing Driveway row stay 100 (or move to 75), and should the new reinforced row get the lid class B or C?

## Draft command/workflow card (for the review gate)

1. **Command / place:** Pit window, Surface list; CDRULES and the Inspector "cover" line. Classification proposed: Modify (add one row, keep the rest).
2. **What the drafter sees (option 1).** Surface list gains "Driveway (reinforced concrete)". Pick it, run CDRULES. A pipe end in that pit is checked against the reinforced figure plus the slab thickness. Warning only, never a block.
3. **Example numbers (assuming 75 reinforced, slab 100 mm, as in your note).** Pipe top 150 mm below the finished surface: warns (needs 175). 180 mm below: passes. Plain "Driveway" at 100 plus 100 = 200: the same 180 mm warns. Slab set to 0: the reinforced row needs 75 from the top.
4. **Unchanged:** Garden 300, Driveway (larger vehicles) 450, Road 600; a council figure (Frankston 250) or project override still wins as built in B-103.
5. **Switch:** one Settings value for the new row (default from your answer) with a switch ON; OFF returns the old table exactly, so the new pick falls back to the single office minimum.
6. **Cancel / Undo / save-reopen:** nothing new is written to the drawing beyond the Surface text already stored on the pit.
7. **Robot case for CE 02 (once built), name C114_reinforced_cover:** in a test pit set Surface = "Driveway (reinforced concrete)", slab 100, pipe top 150 mm below the surface, run CDRULES, read the R-04 cover line: expect a warning mentioning the reinforced figure. Control: switch OFF, rerun, expect the line to name no reinforced row.

## Technical detail

1. **Surface list:** Modules/Drainage/ViewModels/PitViewModel.cs lines 592 to 595 (SurfaceOptions); fixed (non-editable) ComboBoxes at Dialogs/PitDialog.xaml line 198 and Dialogs/PitEditWorkshopDialog.xaml line 123. Stored as free text in PitData.Surface (Models/PitData.cs line 113).
2. **Cover rows:** UserSettings.ShippedMinCoverBySurfaceMm (Models/UserSettings.cs ~2667 to 2674); slab and paved list at 2680 to 2696; MinCoverFor at Rules/RulebookValues.cs lines 105 to 138. A row is added to the slab only if its name is in minCoverPavedSurfaces, so a new row would be a name in both lists. The lid-class table (UserSettings.cs ~2264 to 2271) also keys on surface names.
3. **Why no existing choice fits:** "Driveway" is documented as "under concrete or brick paving" (UserSettings.cs line 2664), so it cannot be both the plain and the reinforced case.
4. **Overlap check (gh pr list, open drafts):** #1920 (B-096, cover measure) changes UserSettings.cs, MinimumCoverForChecks.cs, the Inspector, Hub, health and repair-audit files; #1897 (its base) changes the same plus Smartify/PitEdit/grade-suggestion. A new surface row would touch UserSettings.cs and the PitViewModel list, so a build would need to sit on #1920 to avoid a UserSettings.cs clash. #1919, #1924, #1925, #1927, #1928 were not read in detail (none is a cover change by title). Base of my planned PR was origin/claude/rel-20261102a (3fbb9da5, Civil 3.0.88).
5. **Mistakes of my own:** none that cost anything.

## What I did NOT test

1. No code changed, no build, no test, nothing run in AutoCAD, so no real-files before/after listing was needed.
2. I did not read the Frankston PDF; the 100 / 75 reading comes from our notes of it.

## Housekeeping

1. Worktree C:\CE_WORK\build\x8 created and removed; scratch C:\CE_WORK\scratch\x8 removed. Nothing left at the root of C:.
2. C: free space: 43.16 GB at start, 43.00 GB at the end (about 0.16 GB moved, other activity).
3. Finished Sat 31 Oct 2026, 5:34 pm (PC clock).
