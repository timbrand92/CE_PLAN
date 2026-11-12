# TOOL NOTE: Tidy labels (CDTIDYLABELS)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Slides CE pipe labels, level text and flow arrows clear of other text**, trying nearby spots in a fixed order (home spot, along the pipe, the other side, a lane further out).
2. **Counts first, then asks:** it lists what would move and asks before moving anything.
3. **Pit cover text** is tidied only if a Settings switch is on (off by default).

## 2. What it changes in the drawing

1. **Moves** pipe labels, level text, flow arrows, extra pipe notes, and callout text boxes (the leader stays put).
2. **Before anything is asked** it marks the drawing as a CE drawing and makes CE's record this drawing's (an untagged drawing is stamped without asking).
3. **Switching the tool on** (if it is off): a Yes writes your Settings file.

## 3. What it will not do

1. **No start-up checks** for a read-only drawing, Paper Space or a Structural drawing. It works on a layout too.
2. **REFEDIT open:** "Tidy labels is not run while a reference is being edited. Nothing was moved." (this check comes after the step in 2.2).
3. **Leaves alone and counts:** labels on a locked layer, pipes on a locked layer, pipes CE cannot read, labels with no clear spot.
4. **Labels marked placed by hand** stay only if a Settings switch is on (off by default).
5. **Xref content** cannot be selected.
6. **Invert text never moves more than 500 mm** from the pipe end.

## 4. What it asks you, and what Enter means

1. **If switched off:** "Switch Tidy labels on for this computer now?" Enter = No.
2. **"Tidy labels on [All pipes/Select pipes] <All>":** Enter = All (the current layout only). Esc ends quietly.
3. **"Select pipes to tidy"** (if Select).
4. **The count:** "Will move N · Placed by hand (left alone) N · No clear spot found N", up to 20 "would move X mm" lines, and every label with no clear spot.
5. **"Move these N labels now? [Yes/No] <No>":** **Enter = No.** Enter, No or Esc: "Nothing was moved."
6. **No preview window and no ghosts.**

## 5. When it says Unknown or "needs checking"

1. **"No clear spot found"** labels are named and left where they are.
2. **Pipes CE cannot read** are counted with "(see the log)".

## 6. How to undo it

1. **U once.** It says "Type U once." The moves are one step inside one command (pit text in its own steps).
2. **Not undone by U:** switching the tool on (your Settings file).

## 7. Known faults

**Still there in this build**
1. **BUG-873:** it writes to the drawing (CE marker and record binding) before the switch, the pick, the count and the Yes; "switched off. Nothing in the drawing was changed." can print after that write.
2. **BUG-879:** labels are never marked placed by hand by the slide or adjust tools, so "placed by hand" protection rarely applies; pit cover text is always movable.
3. **BUG-891:** only Model Space is searched for obstacles while a layout can be picked; the search margin is fixed.
4. **BUG-893:** the count does not include earlier pipes' proposed moves, but Apply does, so the count and the result can differ.
5. **BUG-894:** pit cover text is planned as a slid box but written turned and re-anchored.
6. **BUG-895:** cover text on a layout is counted as will-move, refused by the writer, and still reported as moved.
7. **BUG-896:** over 1000 nearby texts throws and the pipe is counted unreadable.
8. **BUG-897:** a tiny slide step from Settings (for example 0.001) is accepted and gives a very large number of spots to try (an earlier figure of 500,000 was not confirmed; the review thinks it is nearer a million, counting both sides).
9. **BUG-962:** the whole of Model Space is scanned, twice (count and apply).
10. **BUG-1034:** a level text "in from the pipe end" can be moved onto its own pipe line.
11. **BUG-890:** a label that finds a spot further out has its reserved place moved there even when it is a plain text; only afterwards are plain texts marked "needs a new leader" and left where they were, so a later callout can still land on the plain text.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **None listed.** BUG-890 was listed here by mistake; it is still there (see above).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No version differences found on this path.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Services\LinkService.TextClashTidyUp.cs:36-40`, `305-317`; `Rules\LabelPlacementRule.cs:53-80`.
2. **1.2, 4.4, 4.5:** `Commands\TidyLabelsCommand.cs:55-96`, `196-200`; `Rules\TidyLabelsSummaryRule.cs:64-75`.
3. **1.3, 3.4:** `Models\UserSettings.cs:1136, 1450`; `Services\LinkService.TidyPitText.cs:28`; `TextClashTidyUp.cs:324-325`.
4. **2.2, 7 BUG-873:** `TidyLabelsCommand.cs:35-37`; `Commands\CeCommandBase.cs:35-36`; `Services\ProjectDataService.Persistence.cs:911-922`; `TidyLabelsSummaryRule.cs:27`.
5. **2.3, 4.1, 6.2:** `TidyLabelsCommand.cs:120-136`.
6. **3.1:** no `CommandPreFlight` in `TidyLabelsCommand.cs`; layouts allowed at `169`.
7. **3.2:** `TidyLabelsCommand.cs:37-40`.
8. **3.3:** `TextClashTidyUp.cs:245-249`, `299-304`, `362-367`; `TidyLabelsSummaryRule.cs:50, 65`.
9. **3.5:** `TidyLabelsCommand.cs:188-192`.
10. **3.6:** `LabelPlacementRule.cs:20, 63-65`; `UserSettings.cs:1839`.
11. **4.2, 4.3:** `TidyLabelsCommand.cs:159-173`.
12. **4.6:** `TidyLabelsCommand.cs:24`.
13. **6.1:** `TextClashTidyUp.cs:129-216`; `TidyLabelsCommand.cs:104`.
14. **7 BUG-879:** `TextClashTidyUp.cs:89, 260`; `Services\LinkService.PipeAttachmentActions.cs:340-341`; `Services\LinkService.SegmentAnalysis.cs:278`; `TidyPitText.cs:100`.
15. **7 BUG-891:** `TextClashTidyUp.cs:28, 741`; `TidyLabelsCommand.cs:169-173`.
16. **7 BUG-893:** `TextClashTidyUp.cs:131-134, 375-376, 420`.
17. **7 BUG-894:** `TidyPitText.cs:100, 119`; `Services\LinkService.PitCoverText.cs:150-154`.
18. **7 BUG-895:** `TidyPitText.cs:71, 116`; `Services\LinkService.PipeAttachmentGrip.cs:1016-1020`; `TidyLabelsCommand.cs:104`.
19. **7 BUG-896:** `TextClashTidyUp.cs:210-214, 712-713`.
20. **7 BUG-897:** `TextClashTidyUp.cs:518-522`; `LabelPlacementRule.cs:83-93`.
21. **7 BUG-962:** `TextClashTidyUp.cs:168, 744-759, 821`.
22. **7 BUG-1034:** `TextClashTidyUp.cs:285, 716`; `LabelPlacementRule.cs:65-70`.
23. **7 BUG-890:** `Rules\TidyLeaderOutRule.cs:121` (the reserved place is set for every item); `Services\LinkService.TextClashTidyUp.cs:440-447` (plain texts marked "needs a new leader" only afterwards); `Rules\TextClashTidyUpRule.cs:250-264`; `UserSettings.cs:1458`.
24. **8.1:** no `#if` on this path.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 02:33; corrected after independent review. Nothing was run in AutoCAD.
