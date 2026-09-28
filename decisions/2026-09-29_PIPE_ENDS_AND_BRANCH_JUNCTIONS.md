# Pipe ends anywhere, and branch pipes onto a main — Tim's rulings, 29 Sep 2026 (release chat 04)

Tim asked (29 Sep, verbatim): "can you place pipe ends anywhere and the system still allows you to draw the pipe? Also, what about situations where we want to draw a pipe end on top of a pipe that's already been drawn as sort of a branch off of that pipe or in a lot of cases when we draw from a downpipe it typically branches towards a main pipeline that goes between pits."

What the code does today (read from `claude/rel-20260929a`, installed Civil 3.0.13): the draw-first CD window refuses an end that is not on a pit, downpipe or outlet ("Cancel and redraw it on one", `PipeStartReadiness.cs`); a pipe ending mid-span on another pipe is refused at draw time too, then detected afterwards as a "Possible" junction (`CivilSpineProjector.AddJunctionEnds`, 100 mm) and confirmed with CDCHECK Connect / CDBREAK "Branch Junction" (main stays one pipe with a node - ruling D3, 4 Sep). Missing: branch level from the main at the junction chainage, junction in the Pit Schedule and the long section.

Tim's answers (clickable choices, 29 Sep 2026):
1. **Free pipe end (empty space): "Allow, flag it"** - the pipe is drawn; that end shows as an open end and is listed in CDCHECK / Project Review until connected (R-27 warn, don't block).
2. **Branch onto a main between pits - level at the junction: "Match inverts"** - the branch invert equals the main's invert at that point (interpolated at the junction chainage). The value/rule lives on the Settings page (R-00), default = match inverts.

Next: a workflow card (AGENTS.md review gate) for "CD branch onto an existing pipe": draw-time acceptance of a mid-span end, junction node on the main (D3), branch invert = main invert at chainage, Pit Schedule / long section display, one Undo; then build.

## Card CD-BRANCH-01 open questions - Tim's answers, 29 Sep 2026 (clickable)
3. **Long section of a branch:** "Marker on main now" - a junction mark with the branch size on the main's long section; the branch's own profile later.
4. **Branch crown above the main's crown:** "Warn only" - draw it, amber note, listed in CDCHECK.
5. **Existing downpipes that split a run the old way:** "Leave as drawn" - no automatic change; only new work uses one-pipe-with-junction.

Interpretation (release chat, not Tim's words): all of the card's open questions are answered, so the card is treated as approved to build under the charter's always-building rule. Tim can still reject it.

## Codex drafting tests - Tim, 29 Sep 2026
Tim (verbatim): "with the codex drafting test, instead of making up a job, why don't we make it do an existing job, find a really easy one, but don't tell it the context of which job it is. And that way we can compare what it did versus let's say what the engineer designed slash drafted as well. Or should we do this whole test at a later date once we're more built towards version three?"
Answers (clickable): **"Both: made-up Thu, real later"** - the synthetic drafting test runs Thu 1 Oct; the real-job comparison runs once branch junctions and the speed work are in (~1-2 weeks). **"Yes, you pick"** - the release chat may choose a simple single-dwelling stormwater job itself (DATA-01 exception granted for this test): only its inputs are copied to `C:\Lisp Files\_TEST_COPIES_*`, the job name/address never enters any repo, report, branch or commit, and Codex is given no job context. Supersedes the 23 Sep "Tim names the project for Part P" (Queued item 15) for this test.

## Pipe ends at the INSIDE face of the pit wall - Tim, 29 Sep 2026
Tim (verbatim, abridged): "if it's in the zone of influence of the pit and it doesn't hit ... the pit wall ... some people might draw it to the middle of the pit, and that's not technically the right length ... I think it's on ... what would technically be drawn as the inside of the pit wall ... because that's where a pipe would be in real life."
Found in code: the pit outline IS the inside opening (a 600 pit = 600 inside); pit MOVES already pull pipe ends to it (`LinkService.PitMoves.cs` ~267, `PitOutline.TrySnapToWall`); new CD pipes do NOT - the end stays where clicked.
Answer (clickable): **"Snap automatically + note"** - a new pipe end inside a pit's reach is moved to the inside wall face along the pipe's line, shown in the preview, with one command-line line (e.g. "Pipe end moved to the inside wall of P3 (was 300 mm inside the pit)."); Undo restores. Being built with CD-BRANCH-01 part 1 (same draw path).

## CDSLAB falls follow the CDFALL rule - Tim, 29 Sep 2026
Asked: "CDSLAB still sets fall text its own way. Should it follow the same rule as CDFALL?" Tim: "yes should follow cdslab".
Interpretation (release chat): yes - CDSLAB's fall symbols use the same FALL SYMBOL 2 rule as CDFALL (arrow follows the fall bearing, block flip for left-pointing falls, cardinal snap, the block evaluates itself, one text-patch path). Builder dispatched on top of PR #370.
