# DRAFT FOR TIM. CARD CEMEMBER-A3: either leg of an unequal angle may stand upright (BUG-1124)

**Status:** DRAFT FOR TIM. Tim said yes ("yes to all four", decision 185, Sat 31 Oct 2026): any UA leg may stand upright, and CE asks which when the angle is unequal. Needs his approval of this card before any code. Nothing is built, tested or installed. Written 31 Oct 2026 (job n20).
**Classification:** MODIFY. Keep the four angle orientations and their line rules (approved 19 Oct, parent card section 3). Add one question for unequal angles only.
**Source:** BUG-1124 (C:\CE_PLAN\BUG_CARPARK.md; T3 audit finding 4). Code read on origin/claude/rel-20261026s (Structural 1.0.125): the CEMEMBER questions, the catalogue step and the section list (section-catalogue.json, UA group). Parent card: release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md; decisions 2026-10-18_CEMEMBER_DESIGN.md.

## 1. What works now
1. **Equal angles (EA) and unequal angles (UA)** get the "how it sits" question: LeftBottom, RightBottom, LeftTop, RightTop (upright leg left or right, flat leg bottom or top).
2. **The four line rules** for each (18cont or 18hidden at one leg thickness t) are as Tim approved.
3. **The section list holds each UA as long leg x short leg** (for example 150x90x10UA: 150, 90, 10).

## 2. What is wrong or missing
1. **The long leg always stands upright.** CE always takes the first figure (150) as the upright leg. A 150x90x10 shelf angle under brickwork with the 90 leg up and the 150 leg flat cannot be drawn: the side elevation is always 150 deep and the section always shows the 150 leg standing.
2. **The only workaround** is draw it wrong and ROTATE, which loses the base-point choice and the line rules (the hidden line ends up on the wrong side).
3. **Equal angles are fine:** both legs are the same, so there is nothing to choose.

## 3. Tim's words
1. "yes to all four" (decision 185, 31 Oct 2026), covering BUG-1124: any UA leg may stand upright; CE asks which leg when the angle is unequal.
2. Earlier (18 Oct): "upright" is the leg standing vertical, "flat" the leg lying horizontal. Unchanged.

## 4. Full experience (proposed)
1. **Trigger:** unchanged. Type CEMEMBER.
2. **Prompts:** for a UA only, straight after "Sits [LeftBottom/RightBottom/LeftTop/RightTop]":
   "Upright leg [Long 150/Short 90] <Long>:" (the figures are the real legs of the angle you typed). Enter keeps today's result. Not asked for EA or any other member.
3. **Remembered:** Enter at the Command prompt to repeat CEMEMBER offers your last answer; Reset clears it, as for the other answers.
4. **Drawing output:** with Short, the 90 leg stands and the 150 leg lies flat. Side elevation 90 deep; top elevation 150 wide; section box 150 wide x 90 high. Line rules unchanged: they already speak of the upright and flat legs, not long and short.
5. **Cancel / Escape at the new question:** "CEMEMBER cancelled. Nothing changed."
6. **Undo, save and reopen, locked layers, Xrefs:** unchanged.
7. **Dependencies:** the section list as it is today; no new data. No system variable changed (REDO-safe).
8. **Performance:** none.
9. **Discoverability:** the question itself; help text adds one line.
10. **Settings switch:** "CEMEMBER asks which UA leg stands upright", shipped ON. OFF = today exactly (no question, long leg up).

## 5. Example drawings and expected results (made-up drawings)
1. **150x90x10UA, side elevation, LeftBottom, Short, Points sit on Bottom, 0,0 to 3000,0.** Expected: member 90 deep; 18hidden line at 10 above the bottom edge.
2. **Same with Long (or Enter).** Expected: 150 deep, identical to today.
3. **150x90x10UA section, RightTop, Short, base point BottomLeft at 0,0.** Expected: outline box 150 wide x 90 high; the 90 leg upright on the right; hatch on the steel only.
4. **100x100x6EA.** Expected: no leg question.
5. **Switch OFF, 150x90x10UA.** Expected: no leg question, 150 deep.

## 6. Guard tests and the AutoCAD checklist (proposal)
1. **Guards without AutoCAD:** UA with Short gives depth 90 and width 150 for all four orientations and all three views; Long gives today's numbers line for line; EA never asks; switch OFF never asks; switch ON through both Settings start-up reads.
2. **Robot case (Claude-acceptable):** S1124_cemember_ua_short. Types CEMEMBER, SIde, 150x90x10UA, LeftBottom, Short, Bottom, None, picks 0,0 and 3000,0; reads the 25cont outline's height (expect 90). Control: switch OFF (no leg question, answers shift by one) gives 150.
3. **Codex look:** example 3, to see the section reads as a shelf angle.

## 7. Open questions for Tim (each with a recommendation)
1. **Approve this card?** Recommendation: yes.
2. **Default answer Long?** Recommendation: yes, so lintels drawn today come out the same.
3. **Ask before or after "Sits"?** Recommendation: after, so the four pictures-in-words stay the same for EA and UA.
