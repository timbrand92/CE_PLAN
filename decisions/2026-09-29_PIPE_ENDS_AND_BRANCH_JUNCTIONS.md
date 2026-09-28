# Pipe ends anywhere, and branch pipes onto a main — Tim's rulings, 29 Sep 2026 (release chat 04)

Tim asked (29 Sep, verbatim): "can you place pipe ends anywhere and the system still allows you to draw the pipe? Also, what about situations where we want to draw a pipe end on top of a pipe that's already been drawn as sort of a branch off of that pipe or in a lot of cases when we draw from a downpipe it typically branches towards a main pipeline that goes between pits."

What the code does today (read from `claude/rel-20260929a`, installed Civil 3.0.13): the draw-first CD window refuses an end that is not on a pit, downpipe or outlet ("Cancel and redraw it on one", `PipeStartReadiness.cs`); a pipe ending mid-span on another pipe is refused at draw time too, then detected afterwards as a "Possible" junction (`CivilSpineProjector.AddJunctionEnds`, 100 mm) and confirmed with CDCHECK Connect / CDBREAK "Branch Junction" (main stays one pipe with a node - ruling D3, 4 Sep). Missing: branch level from the main at the junction chainage, junction in the Pit Schedule and the long section.

Tim's answers (clickable choices, 29 Sep 2026):
1. **Free pipe end (empty space): "Allow, flag it"** - the pipe is drawn; that end shows as an open end and is listed in CDCHECK / Project Review until connected (R-27 warn, don't block).
2. **Branch onto a main between pits - level at the junction: "Match inverts"** - the branch invert equals the main's invert at that point (interpolated at the junction chainage). The value/rule lives on the Settings page (R-00), default = match inverts.

Next: a workflow card (AGENTS.md review gate) for "CD branch onto an existing pipe": draw-time acceptance of a mid-span end, junction node on the main (D3), branch invert = main invert at chainage, Pit Schedule / long section display, one Undo; then build.
