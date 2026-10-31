# DRAFT FOR TIM. CARD CEMEMBER-A2: break marks follow the paper on a layout (BUG-910)

**Status:** DRAFT FOR TIM. Tim said yes to the fix ("yes to all four", decision 185, Sat 31 Oct 2026); this card needs his approval before any code. Nothing is built, tested or installed. Written 31 Oct 2026 (job n20).
**Classification:** MODIFY. Keep the break-line shape (the BL Z-kink on 18CONT) and its paper sizes (1.5 mm overshoot, 2 mm kink). Change only the scale CE uses when you are drawing straight onto a layout sheet.
**Source:** BUG-910 (C:\CE_PLAN\BUG_CARPARK.md, ledger F-056; it also names LBUH and LBH). Code read on origin/claude/rel-20261026s (Structural 1.0.125): the CEMEMBER command, its scale step, the CEMEMBER Settings, and the rule CE text already uses on layouts (paper space draws at 1:1). Parent card: release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md, section 7.

## 1. What works now
1. **In model space** (Model tab, or inside a viewport): the break line is 1.5 mm overshoot and 2 mm kink on paper, multiplied by DIMSCALE. At 1:100 that is 150 and 200; at 1:20 it is 30 and 40. Correct.
2. **The two sizes are Settings values** (CEMEMBER group: break overshoot and break kink, mm on paper).
3. **LTSCALE check:** if LTSCALE is not 10 x DIMSCALE you get one warning line and the member is still drawn (Tim, 19 Oct).

## 2. What is wrong or missing (read in the code, not yet seen in AutoCAD)
1. **On a layout sheet CE still multiplies by DIMSCALE.** On a layout, one drawing unit is 1 mm of paper. At DIMSCALE 50 the kink comes out 100 mm on the sheet instead of 2 mm: a break mark bigger than the title block cell.
2. **The LTSCALE warning fires on layouts too,** where it means little. My reading; not seen.
3. **The member itself on a layout is drawn full size** (a 310UB is 310 mm tall on the A1 sheet). The bug does not cover this; see question 2.
4. **The same fault is reported in LBUH and LBH** (BUG-910 names them). This card is CEMEMBER only; I did not trace the LBUH and LBH break path line by line.

## 3. Tim's words
1. "yes to all four" (decision 185, 31 Oct 2026), covering BUG-910: break marks follow paper scale on layouts.

## 4. Full experience (proposed)
1. **Trigger, prompts, selection:** unchanged.
2. **How CE knows where you are:** the same test CE text already uses. On a layout with no viewport active, sizes are paper sizes (scale 1). Inside a viewport, or on the Model tab, DIMSCALE as today.
3. **Drawing output on a layout:** break overshoot 1.5 mm and kink 2 mm, whatever DIMSCALE says. Nothing else about the member changes.
4. **LTSCALE warning:** not shown on a layout (recommendation; question 3).
5. **Cancel / Escape / Undo / save and reopen / locked layers / Xrefs:** unchanged.
6. **Dependencies:** reuses the one paper rule CE text already uses (one code path per behaviour). No system variable is changed (REDO-safe).
7. **Performance:** no change.
8. **Discoverability:** help text gains: "On a layout sheet, break lines are drawn at paper size."
9. **Settings switch:** "CEMEMBER break lines at paper size on layouts", shipped ON. OFF gives today's sizes exactly.

## 5. Example drawings and expected results (made-up drawings)
1. **Model tab, DIMSCALE 100, 310UB32 side elevation, breaks Both.** Expected: kink 200, overshoot 150, same as today.
2. **Layout1 (paper, no viewport active), DIMSCALE 50, same member.** Expected: kink 2, overshoot 1.5.
3. **Layout1, double-click inside the viewport, DIMSCALE 50.** Expected: kink 100, overshoot 75 (model space rule).
4. **Switch OFF, example 2.** Expected: kink 100, overshoot 75 (today).

## 6. Guard tests and the AutoCAD checklist (proposal)
1. **Guards without AutoCAD:** break sizes at scale 1 on paper and at DIMSCALE in model; the paper test is the same rule CE text uses; switch OFF gives DIMSCALE sizes; switch ON through both Settings start-up reads.
2. **Robot case (Claude-acceptable):** S910_cemember_layout_break. On Layout1, paper space, DIMSCALE 50: CEMEMBER, SIde, 310UB32, Centreline, Both, picks 50,50 and 250,50; reads back the break polyline's kink height (expect 2.0, not 100). Control: switch OFF gives 100.
3. **Codex look:** example 2 printed to PDF at 1:1, to see the mark is the right size on the sheet.
4. **Not provable without AutoCAD:** how it plots.

## 7. Open questions for Tim (each with a recommendation)
1. **Approve this card?** Recommendation: yes.
2. **The member itself on a layout:** today it is drawn full size (310 mm tall on the sheet). Leave it (drafters draw details in model space and CE never shrinks geometry without asking), or ask a scale? Recommendation: leave it full size, and CE says once "you are on a layout: the member is full size". Real-world: nobody gets a 1:1 beam on the sheet without being told.
3. **LTSCALE warning on a layout:** drop it? Recommendation: yes, it only applies to model space.
4. **LBUH and LBH:** fix them under this same rule as a separate small card, or in this one? Recommendation: separate card, same paper rule, so CEMEMBER is not held up.
