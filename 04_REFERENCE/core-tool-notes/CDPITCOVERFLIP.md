# TOOL NOTE: Flip pit cover text (CDPITCOVERFLIP)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Moves a pit's cover level text to another corner** of the pit (flip to the other side, or a chosen corner), turning and anchoring it to suit.
2. **It only works from the cover text's own grips.** Select the cover text on its own, then click its corner grip (flip) or hover it and pick a corner. That queues the move and CE runs this command for you.
3. **Typed, or clicked from the ribbon, it does nothing** unless a grip request is waiting (see 7).

## 2. What it changes in the drawing

1. **Moves and turns the cover text** to the new corner. The invert line goes with it, because PIT writes cover and invert as one text.
2. **Stores the new corner** in the pit's record so later edits keep it.
3. **Nothing else.** No quiet record update, no other text, no pipes.

## 3. What it will not do

1. **Refuses text that is not a pit's cover text:** "This text is not a pit's cover text."
2. **Refuses a locked layer** (names the layer, unlocks nothing), **an Xref** ("belongs to an external reference and is read-only"), **text outside Model Space**, and **REFEDIT open** ("Finish editing the external reference before moving this linked item."). If AutoCAD cannot say whether REFEDIT is open, it refuses.
3. **Already at that corner:** "The cover text is already at the <corner>."
4. **Waits at most 15 seconds** for the grip request; an older request is dropped.
5. **One cover text at a time:** "Select one pit cover text at a time."

## 4. What it asks you, and what Enter means

1. **No questions.** The grip click or the corner picked from the hover menu is the whole answer.

## 5. When it says Unknown or "needs checking"

1. **Not applicable.** Refusals are printed as one "[CE]" line.

## 6. How to undo it

1. **U once.** The move is one change inside one command. Not proven in AutoCAD.

## 7. Known faults

No bugs are filed under this command.

**New in code, no bug covers it**
1. **The ribbon button does nothing.** The Pit tab (shown when a pit is selected) has a "Flip Cover Text" button, and Help says "Select a pit, open the Pit tab, choose Flip Cover Text". The command only acts on a request queued by the cover text's grip, and that request needs the cover text itself selected. From the ribbon it finds no request, writes one line to the CE log, and says nothing on screen.

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version differences found on this path. Whether the grip menu appears the same on older AutoCAD was not checked.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1, 2.1:** `Services\LinkService.PitCoverText.cs:97-155`; cover and invert in one text `Commands\PitCommand.cs:766-772`.
2. **1.2:** `Services\PitCoverTextFlipGripOverrule.cs:13-17`, `105-112`, `139-200`; `Services\PipeAttachmentGripMenuPE.cs:16, 27`.
3. **1.3, 7 new 1:** `Commands\PitCoverTextFlipCommand.cs:10-14`, `23-27`; `PitCoverTextFlipGripOverrule.cs:203-213`; ribbon `Services\CeCvlRibbonContributor.cs:212`; Help `Assets\Help\guide-content.js:105`.
4. **2.2:** `LinkService.PitCoverText.cs:157-166`.
5. **2.3:** no record update call in `PitCoverTextFlipCommand.cs` or `TryMovePitCoverText`.
6. **3.1, 3.3:** `LinkService.PitCoverText.cs:111-116`, `138-143`.
7. **3.2:** `Services\LinkService.PipeAttachmentGrip.cs:980-1057`.
8. **3.4:** `PitCoverTextFlipGripOverrule.cs:32`, `211-212`.
9. **3.5:** `PitCoverTextFlipGripOverrule.cs:149-153`.
10. **6.1:** `LinkService.PitCoverText.cs:109-155` (one transaction).
11. **8.1:** no `#if` in `PitCoverTextFlipCommand.cs`, `PitCoverTextFlipGripOverrule.cs` or `LinkService.PitCoverText.cs`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:34. Nothing was run in AutoCAD.
