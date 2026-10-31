# Index: four draft command cards (31 Oct 2026, job z4)

All four are DRAFT FOR TIM except where the card says Tim already approved it. No code, no build, no test, no PR. Each card follows the command review gate in the repo AGENTS.md.

1. **CH hatch: live preview, then Apply (BUG-615, decision 166 "6yes").** File: CARD_CH_HATCH_PREVIEW_APPLY_DRAFT_31OCT.md. Must be approved BEFORE any build. Questions for Tim:
   1. All hatch aliases together or CH first? (recommend one shared step, CH looked at first)
   2. Show the Origin option for every pattern? (recommend yes)
   3. Preview for plain solid hatches too? (recommend yes, Apply or Cancel only)
   4. Batch hatching: preview the first shape, then Apply to all? (recommend yes)
   5. Wording "Selection cancelled" instead of "No objects selected"? (recommend yes)

2. **CESETTINGS: five groups that print on drawings (BUG-526, decision 167 "7yes").** File: CARD_CESETTINGS_FIVE_GROUPS_DRAFT_31OCT.md. Five named (my reading, UNCONFIRMED): Founding note, Foundation plan, Slabs, Layouts, Plan levels. Questions for Tim:
   1. Are these the right five? (recommend yes)
   2. One new tab, or spread across the existing tabs? (recommend one new tab)
   3. Template-drawing paths and drawing-area origins now or later? (recommend later)
   4. Founding note wording editable by any drafter, with a warning line? (recommend yes)

3. **SM section mark (ST3-9 and ST3-10, BUG-630 and BUG-631, decisions 164, 170, 171).** File: CARD_SM_SECTION_MARK_DRAFT_31OCT.md. Card APPROVED by Tim ("sm card approved"); the bubble is the SECT MARK block in his standard blocks file (confirmed). The one question Tim has not answered:
   1. **How should the cut line, the two bubbles and the labels be linked so they move together (BUG-631)?** (recommend one normal AutoCAD group, as for the FFL tag)
   Smaller points inside the card: may a copy of the standard blocks file be opened to record the block's choices; retire the identifier-in-clear-half switch after the block passes; whether Section Flag and Section Title Block belong to SM.

4. **DSET dimension-style tidy (BUG-634, decisions 165 and 172).** File: CARD_DSET_DIMENSION_STYLE_TIDY_DRAFT_31OCT.md. Mapping is Tim's word: every other style becomes TIM LEADER, a dot-leader style becomes TIM DOT LEADER, then the old style is purged. Card stays DRAFT until he approves it. Questions for Tim:
   1. Dimensions in plain STANDARD: convert them (the STANDARD style itself cannot be removed)? (recommend yes)
   2. One Enter to Apply after the list, or fully automatic with the list afterwards? (recommend one Enter)
   3. Whole drawing (type All) as well as a selection? (recommend both)
   4. Leaders included? (recommend yes)
   5. UNCONFIRMED: how a dot-leader style is recognised (dot arrowhead or DOT in the name). (recommend both)
   6. Annotative dimensions: convert with a warning, or leave alone?
