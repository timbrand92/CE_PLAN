# DRAFT FOR TIM. CARD CEMEMBER-A4: an RHS laid flat (BUG-1125)

**Status:** DRAFT FOR TIM. Tim said yes ("yes to all four", decision 185, Sat 31 Oct 2026). Needs his approval of this card before any code. Nothing is built, tested or installed. Written 31 Oct 2026 (job n20).
**Classification:** MODIFY. Keep the hollow-section line rules (25cont outer edges, 18hidden one wall in, hatch on the wall only). Add one question for RHS only.
**Source:** BUG-1125 (C:\CE_PLAN\BUG_CARPARK.md; T3 audit finding 5). Code read on origin/claude/rel-20261026s (Structural 1.0.125): the CEMEMBER questions, the catalogue step (RHS is always "depth standing vertical") and the section list (200x100x6RHS: depth 200, width 100). Parent card: release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md, sections 3 and 4.

## 1. What works now
1. **SHS, RHS and CHS** draw with the approved hollow-section rules in side, top and section views.
2. **An RHS always stands on its narrow side:** a 150x50 RHS is 150 deep in the side elevation and the section stands 150 high.

## 2. What is wrong or missing
1. **An RHS laid flat cannot be drawn.** A 150x50 RHS lintel or purlin lying on its 150 face should be 50 deep in the side elevation; CE draws 150.
2. **This overrides an earlier ruling.** On 18 Oct Tim confirmed "SHS, RHS, CHS, one orientation". The new question changes that for RHS only.

## 3. Tim's words
1. "yes to all four" (decision 185, 31 Oct 2026), covering BUG-1125: add an orientation question for an RHS laid flat.
2. Earlier and now superseded for RHS only: "SHS, RHS, CHS, one orientation" (18 Oct 2026).
3. **GUESS: he is happy to add the question.** The decision record says decision 185 overrides his earlier "one orientation" ruling; Tim's own words were "yes to all four", not a separate word on dropping "one orientation". Please confirm (question 1).

## 4. Full experience (proposed)
1. **Trigger:** unchanged.
2. **Prompts:** for an RHS only, after the section name: "RHS sits [Standing/Flat] <Standing>:". Standing = the long side vertical (today). Flat = the long side horizontal. Not asked for SHS or CHS (they look the same either way).
3. **Remembered:** Enter-to-repeat offers the last answer; Reset clears it.
4. **Drawing output with Flat:** side elevation 50 deep (for a 150x50); top elevation 150 wide; section box 150 wide x 50 high. Inside lines still 18hidden one wall thickness in; hatch on the wall only.
5. **Cancel / Escape:** "CEMEMBER cancelled. Nothing changed."
6. **Undo, save and reopen, locked layers, Xrefs:** unchanged.
7. **Dependencies:** the section list as it is today. No system variable changed (REDO-safe).
8. **Performance:** none.
9. **Discoverability:** the question; one line in the help text.
10. **Settings switch:** "CEMEMBER asks how an RHS sits", shipped ON. OFF = today exactly (no question, standing).

## 5. Example drawings and expected results (made-up drawings)
1. **150x50x3RHS side elevation, Flat, 0,0 to 2400,0, Points sit on Bottom.** Expected: 50 deep; two 18hidden lines at 3 in from each edge. (150x50x3RHS is in today's section list; checked.)
2. **Same with Standing (or Enter).** Expected: 150 deep, identical to today.
3. **200x100x6RHS section, Flat, base point Centre.** Expected: box 200 wide x 100 high.
4. **100x100x6SHS.** Expected: no question.
5. **Switch OFF, example 1.** Expected: no question, 150 deep.

## 6. Guard tests and the AutoCAD checklist (proposal)
1. **Guards without AutoCAD:** RHS Flat swaps depth and width in all three views; Standing gives today's lines exactly; SHS and CHS never ask; switch OFF never asks; switch ON through both Settings start-up reads.
2. **Robot case (Claude-acceptable):** S1125_cemember_rhs_flat. Types CEMEMBER, SIde, 200x100x6RHS, Flat, Bottom, None, picks 0,0 and 3000,0; reads the 25cont outline height (expect 100). Control: switch OFF gives 200.
3. **Codex look:** example 3 section.

## 7. Open questions for Tim (each with a recommendation)
1. **Confirm the GUESS: you are happy to drop "one orientation" for RHS and add Standing/Flat?** Recommendation: yes; lintels and flat purlins are common.
2. **Approve this card?** Recommendation: yes.
3. **Default Standing?** Recommendation: yes, so today's drawings come out the same.
