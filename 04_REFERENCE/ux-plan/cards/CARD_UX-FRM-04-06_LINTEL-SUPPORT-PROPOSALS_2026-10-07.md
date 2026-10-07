# CARD UX-FRM-04 and 06: propose lintels and supports (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Upper floors. Class: **Missing**.
Tim's words: UX-FRM-04 "Propose, you accept (Recommended)" (lintels over every opening in a loadbearing wall); UX-FRM-06 "Suggest, you confirm (Recommended)" (support where a beam lands on a stud wall). Sizes stay Unknown until a timber calculation exists (STRUC-COMPS), never invented.

1. **Before:** you scan the first floor for openings in loadbearing walls and place and tag each lintel by hand. You also check every beam end for a post or stud under it.
2. **After (lintels):** CE finds openings in walls you marked loadbearing (LBW), draws a proposed lintel over each in grey preview, tagged L1, L2 and so on, size "Unknown". You tick or untick each, then Accept.
3. **After (supports):** where a beam ends on a stud wall with nothing under it, CE proposes DS1 (double stud) or TS1 (triple stud) in the preview, by the load if known, otherwise "Unknown". You confirm each.
4. **Command and prompts (proposed name CSLINTELPROPOSE):** "Select walls or Enter for the whole plan:", then a list "L1 over W2 opening, 1200 wide: [Accept/Skip]". Final line "Accept 7 proposals? [Yes/No]".
5. **Never silent:** a proposal that touches a wall CE cannot read (an Xref wall, a locked layer) is listed as skipped with the reason.
6. **Cancel and Undo:** Esc or No draws nothing. One accepted batch is one U.
7. **Native protection:** locked layers are reported and skipped, never unlocked; Xref and REFEDIT items are never copied around or exploded.
8. **Settings values:** opening width above which a lintel is proposed, layer names, tag prefixes (L, RL, DS, TS), whether a proposal needs the plan level set (CSPLANLEVEL).
9. **Tested without AutoCAD:** an opening found in a wall, no proposal in a non-loadbearing wall, numbering continues after existing marks, a beam with support under it gets no proposal.
10. **Only Codex in AutoCAD can see:** the preview is readable on a busy plan, opening detection on a real wall with a door and a window, Esc, one U.
11. **Questions for Tim (typed):**
    1. **What counts as an opening?** Rec: a gap in a wall line wider than the Settings value (start 600 mm), with the wall marked loadbearing. Job example: a 900 mm window gets L1; a 450 mm service hatch does not.
    2. **One lintel mark for matching openings?** Rec: no, each lintel its own mark, as you ruled for beams (UX-MARK-07). Job example: two identical 1800 openings are L2 and L3.
    3. **Propose supports in the same command?** Rec: yes, one pass, two kinds of proposal in one list. Job example: one list shows 5 lintels and 2 double studs.
