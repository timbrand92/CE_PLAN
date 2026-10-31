# DRAFT FOR TIM: CH concrete hatch, live preview then Apply (BUG-615)

**Status:** DRAFT FOR TIM. Not approved as a card. Not built, not tested, not installed. Written 31 Oct 2026 (job z4). Tim's ruling 166 says the card must be approved BEFORE any build.
**Classification:** MODIFY. Keep the CH alias, the hatch it makes (a normal AutoCAD associative hatch behind the linework) and the scale rule. Add one step before the hatch is created: see it, adjust it, press Apply.
**Source:** Tim decision 166, "6yes" (C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md). Bug entry BUG-615 in C:\CE_PLAN\BUG_CARPARK.md. Approved workflow ST5-4. Code read on Structural origin/claude/rel-20261026s (HatchCommands.cs, HatchUpgradeCommands.cs).

## 1. What works now (read from the code, and from the 15 Oct robot runs in BUG-615)
1. **Alias:** type CH, answer Objects or Points, select a closed shape (or click inside one), press Enter.
2. **Result:** one normal associative concrete hatch (pattern AR-CONC, layer HATCH 21, sent behind the linework). At DIMSCALE 20 / LTSCALE 200 the pattern scale is 1.0; at 100 / 1000 it is 5.0; other office pairs follow the Layouts switches (BUG-614).
3. **Safe parts that already pass:** one Undo, delayed Redo, save and reopen, HATCHEDIT afterwards, Escape before the selection finishes leaves nothing, an open boundary asks before it is closed, CE restores the hatch settings it borrowed.
4. **Same pattern on the other presets:** EH, WH, LBH, LBUH, BLH, the 21H family and CEHATCH, CEHATCHBATCH and CEHATCHGAP all go straight from selection to a finished hatch (BUG-615 items 7, 8 and the 15 Oct gap note).

## 2. What is wrong or missing
1. **No preview and no Apply.** The hatch is made the instant Enter is pressed. The drafter cannot see the real hatch on the drawing, or adjust Scale, Angle or Origin, before it exists. The CEHATCH picture of the pattern is a thumbnail, not the drawing. Approved ST5-4 wants: alias, Objects or Points, live result on the drawing, adjust Scale / Angle / Origin, Apply.
2. **Cancel wording.** After Escape the line says "No objects selected" or "No points selected"; "Selection cancelled" is the honest wording (BUG-615 item 6). Cosmetic.
3. **WH asks for its origin before you select**, so you cannot see the waffle grid first (BUG-615 item 7).

## 3. Tim's words
1. "6yes" (decision 166). Desk instruction: write the command card first (live preview plus Apply step), get Tim's approval, then build.
2. Earlier approved workflow ST5-4 (alias, Objects or Points, live result, adjust Scale / Angle / Origin, Apply). Escape before Apply leaves no new output.

## 4. Full experience (what a drafter meets, step by step)
1. **Trigger:** type CH (or any hatch alias, or pick it from CEHATCH). No new ribbon button. The same aliases keep working, so nothing is relearned.
2. **Prompts, in order:** Select hatch method [Objects/Points], then pick (as today). NEW: the hatch then appears on the drawing as a preview in its real pattern, colour and scale, with this prompt: **"Hatch preview. Scale <5> Angle <0> Origin, or Apply [Scale/Angle/Origin/Apply] <Apply>:"** Enter takes Apply.
3. **Selection:** exactly as today, including picking the shapes first and then typing CH. Invalid, missing or open boundaries behave as today (the Close-boundary question is kept).
4. **Preview:** a temporary picture only. It is not in the drawing and not in the Undo list until Apply. Changing Scale, Angle or Origin redraws the preview. Origin lets you click a point the pattern lines up to.
5. **Drawing output after Apply:** the same single associative hatch as today, same layer, same send-to-back, nothing extra. The preview values (scale and angle) are the ones written.
6. **Cancel / Escape:** Escape at any step (selection, preview, an adjustment) leaves the drawing exactly as it was: same hatch count, no leftover preview, nothing in Undo. The line says "Selection cancelled" or "Hatch cancelled".
7. **Undo:** one Undo after Apply removes the hatch; one Redo brings it back. Nothing is left on the Undo list from the preview.
8. **Save and reopen:** hatch is the normal AutoCAD hatch, so it reopens linked to its boundary and HATCHEDIT works.
9. **Locked layers, Xrefs, REFEDIT:** the preview does not unlock anything. A boundary on a locked layer or inside an Xref is refused with the plain native-protection line, as AutoCAD would; nothing is bypassed.
10. **Dependencies:** Settings Layouts "follow any drawing scale" and "hatch density follows paper" (already there, BUG-614 and BUG-748). Pattern files as today. No new setting for the pattern values: they stay the office values.
11. **Performance:** the preview draws one hatch for the shapes chosen; with batch (CEHATCHBATCH) it is one preview per run or a "preview first shape only, then apply all" rule (open question 4).
12. **How a drafter finds it:** nothing new to learn. CH works the way it always did, with one extra screen picture before it finishes. Help text for CH gets one sentence.
13. **Switch (R-00, R-27):** a Settings switch "Preview hatches before placing" shipped ON; OFF gives today's straight-to-hatch behaviour exactly. Shown on the Settings page.

## 5. Example drawings and expected results
1. **Slab edge, 1:100.** Model space, DIMSCALE 100, LTSCALE 1000. Draw a 4000 x 3000 closed rectangle. Type CH, Objects, click the rectangle, Enter. Expected: the concrete pattern appears inside the rectangle at scale 5; Enter applies; one hatch on layer HATCH 21.
2. **Change before Apply.** Same rectangle. At the preview type Scale, enter 10, then Angle 45. Expected: preview coarser and rotated; Apply; the finished hatch matches what was previewed (HATCHEDIT shows 10 and 45).
3. **Escape.** Same rectangle, Escape at the preview. Expected: no hatch, hatch count unchanged, nothing to Undo.
4. **Rectangle with a circular opening, Points.** Click inside the rectangle but outside the circle. Expected: preview hatches the ring only; Apply.
5. **Locked layer.** Lock the rectangle's layer. Expected: refused with the one plain protection line, no preview, nothing changed.

## 6. Guard tests and Tim's AutoCAD checklist (proposal)
1. **Guards (no AutoCAD):** the preview and the final hatch use the same scale rule (one code path, design rule 1); switch OFF gives today's sequence exactly; switch default ON through both start-up reads; Escape leaves counts unchanged.
2. **Checklist for the Codex or robot look:** examples 1 to 5 above, plus one Undo then Redo, save and reopen, and a repeat on EH and WH once CH passes. A drafter must SEE the preview, so this needs a Codex look at the real screen (RULES 5.7).
3. **What cannot be proved without AutoCAD:** that the preview looks right at 1:20 and 1:100, and that Escape leaves no ghost picture.

## 7. Open questions for Tim (each has a recommendation)
1. **CH only first, or all hatch aliases together?** Recommendation: build it once for the shared hatch step so every alias gets it (one code path); the first look is CH. If you prefer, switch it on for CH only first.
2. **Origin option:** show it for every pattern or only where a pattern has a visible start point (concrete, waffle)? Recommendation: always offered, default unchanged.
3. **Plain solid hatches (21H family):** need a preview at all? Recommendation: yes, same screen, only Apply or Cancel (nothing to scale).
4. **Batch (CEHATCHBATCH):** one preview of the first shape, then Apply to all? Recommendation: yes.
5. **Wording:** "Selection cancelled" in place of "No objects selected" (recommended).
