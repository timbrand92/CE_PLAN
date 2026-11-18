# Slab joints: CONSTRUCTIONJOINT / CJ, SAWCUT / SSC, ARTICULATIONJOINT / AJ, JOINTSWAP / JS

**Revision:** 1 (Wed 18 Nov 2026, late afternoon, Melbourne time). IDs: JT-01 onwards, never reused.
**Sources:**
1. **This tool:** TA-009, TA-025, TA-033, TA-120 to TA-125 in `interview_tools\ANSWERS.md`.
2. **Old code:** the old `JointDraftingService`, read only.
3. **Old jobs:** 21 old jobs in the local evidence store, read only; counts only.

**Status:** planning only, in words; no picture until the approved style (D-286). In the first release (D-201).

## Today (old code and old jobs)

1. **What today's command does:** pick start and end, and it draws one straight line on SLAB CJ (green, PHANTOM) or SLAB SC (yellow, DASHDOT2). It writes "CJ" or "SC" 2.5 mm high at the middle, 50 mm off the line, on the side with less clutter, and asks "Mirror label?" when unsure. CJSS swaps one to the other.
2. **The old jobs:**
   - **Labels:** always the short form, "SC" 349 times and "CJ" 43 times, 2.5 mm on the sheet.
   - **Two sets of layers:** SLAB CJ and SLAB SC, used by the commands; and CONSTRUCTION JOINT and SAWCUT, used by the palette line blocks.
   - **Articulation joints:** in 2 jobs, on CENTER linetype, labelled "A.J".
3. **Why the dashes go wrong:** most of those drawings have LTSCALE 1000 with paper-space linetype scaling off. Dashes are right in a 1:100 viewport and five times too big in a 1:20 one. The command never set a linetype scale.

## The new tools

1. **JT-01 Three joints:**
   - **CONSTRUCTIONJOINT / CJ:** SLAB CJ, PHANTOM (TA-009, TA-121).
   - **SAWCUT / SSC:** SLAB SC, DASHDOT2 (TA-009, TA-121).
   - **ARTICULATIONJOINT / AJ:** CENTER linetype, label "A.J" (TA-123). Its layer is to be named; the old jobs used ARTICULATION JOINT.
2. **JT-02 The line:** pick points, with bends allowed (TA-033). Enter starts the next joint; Enter again finishes (TA-124).
3. **JT-03 Dashes:** each joint line's own linetype scale comes from DIMSCALE, so the dashes look right on the sheet it is drawn for (TA-122, TA-033).
4. **JT-04 Label:** "CJ", "SC" or "A.J", 2.5 mm on the sheet x DIMSCALE (TA-120). It is placed like 25T / 25B, on the clear side of the line (TA-025, TA-114). A label moved by hand keeps its offset and moves with the line.
5. **JT-05 Legend:** the first time a joint kind is used on a sheet, "What else changes" offers its legend line, for example "SC DENOTES SAW CUT". One tick, never forced (TA-120).
6. **JT-06 JOINTSWAP / JS:** pick joints and choose CJ, SC or AJ. Line, layer, linetype and label all change together (TA-125).

## Still open

1. **The articulation joint's layer name and colour.**
2. **The exact legend wording** for each joint.
3. **The joint window's look:** waits for the approved style.
