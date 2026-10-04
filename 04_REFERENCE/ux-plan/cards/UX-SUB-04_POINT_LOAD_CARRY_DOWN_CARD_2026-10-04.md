# UX-SUB-04: mark a roof point load and carry it down (card, 4 Oct 2026)

Status: **DRAFT, not approved.** No code. Written by Team build 02 (headless run 68) because the job asked to wire
`RoofPointLoadCarryDownMatcher` into a command and no approved workflow card for that command exists (review gate,
AGENTS.md). The slice is stopped here for Tim.
Class: **Missing** (the command). The matcher is **Keep** (built, installed, called by no command).

**Authority:** Tim, 27 Sep 19:54, verbatim: **"Mark and carry down"** (`decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`
line 2373: "A point load marked on the roof plan is carried down to the beam or lintel below and into its computation,
shown as a small arrow symbol"). Also UX-SUB-03 ("Trusses by others, CE shows layout ... girder trusses and point loads
shown"), UX-STRUC-13 (roof down), UX-LOAD-01 (markers from above). Rules R-00, R-27, native protection, one U.

## 0. What exists (read in code on `origin/claude/rel-20261015y`, 8e88af4e, Structural 1.0.101)

1. `Modules/Structural/Core/Roofs/RoofPointLoadCarryDown.cs`: pure. A roof point load (X, Y, kN above 0, note) is
   matched by plan position to ONE beam or lintel line under it (within a tolerance): Matched / NoSupportBelow /
   Ambiguous (two or more: CE never guesses). Gives the point on the member for the arrow. It does NOT add the load to
   any beam calculation. Same drawing only (roof and the floor below share one XY grid).
2. Nothing in the plugin records a roof point load today (no command, no block, no record). The load trace
   (`LoadTraceEngine`, UX-LOAD-01) already has a `PointLoad` source kind "ready for when one does".
3. Beam lines with marks: the beam commands (BEAM/BDL and the beam registry) give handle, mark and end points.

## 1. What the drafter would do (proposal)

1. **On the roof plan:** Roof > Point load (typed CSPOINTLOAD). Pick the point (girder truss seat, post top). Type the
   load in kN, or Enter = Unknown. CE places a small point-load marker with its tag (P1, P2 ...) and the load or
   "Unknown". One U.
2. **Carry down:** CE finds the beam or lintel directly under each marker (the matcher) and draws a small arrow symbol on
   that member with the tag ("P1 from roof"). Two members under one load: CE asks you to pick one (it never guesses).
   Nothing under it: a quiet QA line with Show where (as UX-LOAD-02), never a block.
3. **Switched OFF by default:** Settings `RoofPointLoads.CarryDown` (false). Off = the marker command still works, no
   arrow is drawn.
4. **Into the computation:** the carried load is listed against the member (beam schedule / beam design input) as
   "P1 x kN from roof" or "Unknown". CE adds nothing to a size; the engineer's calculation uses it.
5. **Footings:** a carried load that reaches the footing plan feeds Propose footings (CSFDNPROPOSE, UX-LOAD-03) as a
   known load instead of Unknown.

## 2. Cancel, Undo, save, protection

1. Escape at any prompt writes nothing. One placed marker = one U; one carry-down run = one U.
2. Markers and arrows are rebuilt from a drawing record (like the level-above markers); erasing one by hand is reported,
   not repeated silently.
3. Locked layers, Xrefs, REFEDIT: the arrow is not drawn on a locked layer (one plain line); nothing unlocked, detached
   or exploded.

## 3. Settings (R-00), every value Needs Tim's acceptance

1. `RoofPointLoads.CarryDown` (off). Match tolerance (mm, Assumed: suggest the load path support tolerance, one value,
   not a second). Marker and arrow layer, size from the one Structural text height.

## 4. Tests

1. Pure: matcher results unchanged; tag numbering; Unknown load stays Unknown; ambiguous asks.
2. Codex in AutoCAD (synthetic drawing): roof plan + first floor beams in one drawing; two point loads, one over a beam,
   one over two beams, one over nothing; switch on; arrows, pick prompt, QA line; Escape; U; save, reopen.

## 5. QUESTIONS FOR TIM (short, typed)

1. **How is a roof point load marked today?** Rec: a new CE marker you place (CSPOINTLOAD) with the kN typed or
   Unknown. Example: pick the girder seat, type 18, CE tags it P1.
2. **Roof and the floor below in ONE drawing (same XY), or separate drawings?** The matcher works in one drawing only.
   Rec: one drawing first; separate drawings later with the plan levels (CSPLANLEVEL). Example: roof framing frozen
   over the first floor plan.
3. **The arrow symbol:** an office block, or CE draws a plain arrow? Rec: plain arrow until you name a block. Example:
   a 300 mm arrow pointing down onto beam B3 with "P1 from roof".
4. **"Into its computation":** today only listed against the member (no beam calc uses it). Rec: listed now, the
   S5 beam calculation reads it later. Example: beam B3 row: "P1 18 kN from roof".
