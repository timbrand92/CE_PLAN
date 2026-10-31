# CARD SM: section mark (ST3-9 and ST3-10). APPROVED by Tim, "sm card approved" (decision 171); this file is the written card. Open design point: BUG-631 only.

**Status:** Card APPROVED (Tim, Sat 31 Oct 2026, "sm card approved", decision 171). It stays marked DRAFT FOR TIM only for the one open design point in section 7 (BUG-631, the link between cut line, bubbles and labels). Nothing is built, tested or installed. Written 31 Oct 2026 (job z4).
**Classification:** REBUILD the look (bubble from Tim's SECT MARK block instead of lines the command draws itself) and the order of questions (preview first, place last). KEEP the command names SM, SECTION and CE_SECTIONMARK, the Left / Right / Up / Down view direction, the identifier and sheet reference, and the record each cut line keeps of its number and sheet.
**Source:** Tim decisions 164, 170, 171 ("my block in my standard blocks file", "assumptions 1yes", "sm card approved"). Bugs BUG-630, BUG-631, BUG-632 (C:\CE_PLAN\BUG_CARPARK.md). Code read on Structural origin/claude/rel-20261026s: Commands/SectionMarkCommands.cs, Services/SectionMarkRegistry.cs.

## 1. What works now
1. **Type SM.** Questions, in this order: Pick or ? ; start point; end point; view direction [Left / Right / Up / Down] (default Left, remembered); section identifier (A, 1, 01); sheet reference (blank = same sheet).
2. **Result:** a cut line on the dimension layer, and at each end a bubble that CE draws itself from basic parts: a circle, a solid half-circle on the view-direction side, the identifier in the middle and the sheet reference below. Bubble radius is 4 x DIMSCALE; identifier height follows the label height setting; sheet text 1.8 x DIMSCALE.
3. **Behind a Settings switch (off today):** SectionMarkOfferNextIdentifier asks the sheet first and offers the next free number (A after B...), skip-letters list; SectionMarkIdentifierInClearHalf puts the identifier in the clear half of the bubble.
4. **The cut line keeps a hidden record** of its identifier and sheet, so the next-number offer can see it.
5. **One Undo** removes the whole mark.

## 2. What is wrong or missing
1. **BUG-630:** the questions come before the picture. The mark is written the moment the sheet answer is given; the drafter never sees the complete cut line, both bubbles, view side and labels before they exist, and there is no final click.
2. **BUG-631:** MOVE on the cut line moves only the line. Both bubbles and both labels stay behind. (Undo restores it. No saved split specimen was claimed.)
3. **BUG-632:** part of the identifier disappears against the solid half of the bubble.
4. **The bubble is not Tim's block.** The plugin draws its own lookalike; the SECT MARK block in Tim's standard blocks file is not used.

## 3. The SECT MARK block (found, not opened)
1. **Confirmed by Tim** (decisions 170 and 171): the bubble is the SECT MARK block in his standard blocks file. No longer a guess.
2. **Which file:** the office standard blocks file, CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg (in Tim's Drawings Templates folder). The plugin already knows how to find it: it looks first at the path set in Settings (Installation tab), then in Tim's Drawings Templates folders, then in the shared assets folder, then in the plugin's own Assets\Blocks. The plugin's own Assets\Blocks does NOT contain a SECT MARK file today (14 block files there, none of them this one), so on a colleague's PC the block comes only from the standard blocks file.
3. **What the block is, from the office-file inventory the repo already holds (I read the text inventory only; I did not open any drawing):**
   - Name SECT MARK; a dynamic block (it has parameters such as a view side that change its shape).
   - 8 parts inside it: lines, a nested block, and attribute fields.
   - Two fill-in fields, tagged DWG and SEC. Reading the tags: DWG is the sheet or drawing reference, SEC is the section letter or number. UNCONFIRMED: that is my reading of the tag names; the inventory does not say.
   - It is in 12 of the structural drawings the office analysed (about 30 percent), so it is a real office standard.
   - Two relatives sit beside it in the same file: "Section Flag" (a smaller dynamic block, 2 parts) and "Section Title Block" (a dynamic block with fill-in fields, 9 parts). Whether either is part of the section mark workflow is not recorded.
4. **Not recorded anywhere I could read:** the block's dynamic choices (does it offer Left / Right / Up / Down, or a flip, or a rotate), its layer, its insertion size (does it expect scale = DIMSCALE), and whether the solid half is part of the block. These must be read from the block before design is final (question 1 in section 8).

## 4. Tim's words
1. "4my block in my standard blocks file" (decision 164).
2. "assumptions 1yes" (decision 170): the bubble is the SECT MARK block in his standard blocks file.
3. "sm card approved" (decision 171): build the section mark from that block under this card. BUG-631 still needs a design pass inside the card.

## 5. Full experience (approved shape, ST3-9 and ST3-10)
1. **Trigger:** SM (also SECTION, CE_SECTIONMARK) and the existing ribbon button. Nothing new to find.
2. **Prompts, in this order (BUG-630 expected):**
   1. **Identifier first**, then sheet reference (blank = same sheet). With the switch on, CE offers the next free number for that sheet and Enter takes it.
   2. Start point.
   3. End point.
   4. View direction [Left / Right / Up / Down], with the complete mark showing on screen while you choose.
   5. **Final click or Enter to place.** Escape cancels.
3. **Preview:** the complete mark, as it will be drawn: cut line, both SECT MARK bubbles with the identifier and sheet reference filled in, the view side marked. Temporary until placed; not in the drawing and not in Undo.
4. **Drawing output:** one cut line plus two SECT MARK blocks with the fill-in fields (SEC and DWG) set, the block inserted at the scale the office expects (DIMSCALE, UNCONFIRMED until the block is read). The hidden record of identifier and sheet stays on the cut line so the next-number offer keeps working. The identifier is part of the block, so the BUG-632 clipping goes away if the block's own look is right.
5. **Cancel / Escape:** at any prompt, nothing is added; the remembered direction is not changed.
6. **Undo:** one Undo removes cut line and both blocks together; one Redo brings them back.
7. **Save and reopen:** the blocks reopen as the SECT MARK block; changing the fill-in fields later works with the normal AutoCAD attribute edit.
8. **Locked layers, Xrefs, REFEDIT:** the new objects go on their own layer. If the layer is locked CE says so and places nothing. No layer is ever unlocked.
9. **Dependencies:** the standard blocks file must be found. If it is not found: one plain line naming where CE looked, and CE falls back to today's drawn bubble (warn and carry on, never block, R-27).
10. **Performance:** one block insertion per bubble; no noticeable delay.
11. **How a drafter discovers it:** same command, same ribbon button; Help text for SM says the bubble is the office SECT MARK block.
12. **Existing marks:** marks already drawn the old way are left alone and still counted by the next-number offer.
13. **Switch:** a Settings switch "Use the office SECT MARK block" shipped ON; OFF draws today's bubble exactly.

## 6. Example drawings and expected results
1. **Plain section.** Model space, DIMSCALE 100. Type SM, identifier A, sheet S02, start 400,650, end 1200,650, direction Left, click to place. Expected: cut line with two SECT MARK bubbles, A and S02 readable, one Undo removes all three objects.
2. **Next number.** Second section on S02. Expected: CE offers B; Enter takes it.
3. **Escape at the preview.** Expected: nothing added, no ghost picture left.
4. **Block missing.** Rename the standard file on a copy PC. Expected: one plain line, old-style bubble drawn.
5. **BUG-631 check (after the design point is settled):** MOVE the cut line, then from a bubble, then from a label. Expected per section 7.

## 7. The one open design point: BUG-631, the link between cut line, bubbles and labels
BUG-631: after SM, a normal MOVE on the cut line moves only the line. Approved ST3-10 says the cut line, both bubbles, identifiers and sheet references move together as one section.
1. **Recommendation (a design suggestion, NOT decided by Tim):** make the finished section mark one normal AutoCAD group of the cut line and the two bubble blocks, behind a Settings switch shipped ON, the same way Tim approved for the FFL tag (decision 163: "move as one normal AutoCAD group"). Picking any part then selects all three, MOVE and COPY and ERASE act on the whole mark, and nothing nearby is selected by accident. A drafter can still pick a single part with Ctrl+Shift+A or by ungrouping, as AutoCAD normally allows.
2. **Why not widen the selection:** BUG-631 says "do not solve with broad nearby-object selection". A group does not guess; it holds exactly the three objects.
3. **COPY:** a copy gets a fresh group. The identifier would repeat, so CE warns "A already used on S02" and carries on (never blocks).
4. **Edit and safe erase:** ERASE of one part removes the whole mark only if the drafter selects the group; erasing a single bubble leaves the rest and CE reports it.
5. **To be proved in AutoCAD:** MOVE, COPY, ROTATE, MIRROR, Undo and Redo, save and reopen, and a group inside a block or on a locked layer.

## 8. Open questions for Tim (each has a recommendation)
1. **THE ONE QUESTION NOT ANSWERED:** how should the cut line, the two bubbles and the labels be linked so they move together (BUG-631)? Recommendation: one normal AutoCAD group, as for the FFL tag (section 7). The card itself is approved; this is the only part still open.
2. **Reading the block:** may a robot or Codex open the standard blocks file (a copy) to record the block's dynamic choices, layer and size? Recommendation: yes, on a copy only. Needed before design is final.
3. **BUG-632 and the "identifier in the clear half" switch:** once the office block is used, retire that switch? Recommendation: keep it but unused, retire after the block passes.
4. **Section Flag and Section Title Block:** part of the SM workflow, or separate commands? Not recorded; not decided.
5. **Drawing order:** place the bubbles on the layer the block itself carries, or force the dimension layer as today? Recommendation: the block's own layer.

## 9. Guard tests and Tim's AutoCAD checklist (proposal)
1. **Guards (no AutoCAD):** question order (identifier before points), the next-number rule (already tested), switch OFF gives today's mark exactly, the "block not found" fall-back message, group holds exactly three objects.
2. **Checklist (Codex look, because the drafter must see the preview and the bubble):** examples 1 to 5 above, at 1:20 and 1:100, in model space and on a layout, with one Undo / Redo and save and reopen.
3. **Not provable without AutoCAD:** how the dynamic block behaves at each direction, and the grouped MOVE.
