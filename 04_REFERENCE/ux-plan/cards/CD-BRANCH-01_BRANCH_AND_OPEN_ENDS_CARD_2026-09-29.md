# CD workflow card: open pipe ends and branches onto a main

**Status: PROPOSED, awaiting Tim's approval before any code.** 29 Sep 2026.
Authority: `decisions/2026-09-29_PIPE_ENDS_AND_BRANCH_JUNCTIONS.md` (Tim's two rulings), reconciliation ruling D3 (main stays one pipe with a node), CV21 (never choose silently), R-00 (Settings own values), R-27 (warn, do not block).

## What works today, and what is wrong

1. **Draw-time refusal.** The CD window will not start a pipe whose end is not on a pit, downpipe or outlet ("Cancel and redraw it on one"). A free end and a mid-span end on another pipe are both refused.
2. **After-the-fact detection.** A pipe end within 100 mm of another pipe's centreline (away from its ends) is read as a Possible junction. CDCHECK Connect or CDBREAK records it. The main stays one pipe with a node. This works.
3. **Downpipe landing on a pipe run.** Today the placement code splits the pipe there. That contradicts D3 and Tim's "main stays one pipe".
4. **Missing.** Branch invert from the main, the junction in the Pit Schedule, and the junction in the long section (branch pits are simply left out, "v2 will show full branches").

## Tim's intended result

1. **Free end:** allowed. The pipe is drawn, the end shows as an open end, and it is listed in CDCHECK and Project Review until connected.
2. **Branch onto a main between pits:** accepted at draw time. The main is not split. A junction node is recorded at the chainage. Branch invert equals the main's invert interpolated at that chainage. The rule lives on the Settings page; the default is Match inverts.

## Classification

1. **Draw-time refusal:** Modify (accept, warn, never block).
2. **Junction detection, CDBREAK, CDCHECK Connect:** Keep.
3. **Downpipe run-split:** Modify (junction node instead of a split).
4. **Branch invert from main:** Missing.
5. **Pit Schedule, long section, Inspector rows:** Missing.
6. **Open-end flag and list:** Missing.

## The full experience

1. **Trigger:** the CD window as today. Nothing new to learn.
2. **Pick and snap:** with a pipe under the cursor, the end snaps onto the centreline and the tip reads "Branch on P3, 12.40 m from start". A pit within 100 mm wins, and the tip says so. Empty space gives "Open end".
3. **Preview:** the branch shows a junction dot on the main and the branch invert value, for example "IL 24.31 (from main)". An open end shows a hollow circle.
4. **Command line:** "Branch joins P3 at 12.40 m. Invert 24.31 taken from the main." Or "End is free: open end flagged, connect it later."
5. **Cancel or Escape:** nothing is written. **Undo:** one Undo removes the pipe, the node and the level together.
6. **Save and reopen:** the junction and open-end flag survive, and nothing is re-guessed on open.
7. **Pit Schedule:** a "Junction" row per branch: main, chainage, branch invert, main invert at that point.
8. **Long section:** the main profile shows a junction marker with the branch label and invert. The branch can be profiled as its own run starting at the marker.
9. **Inspector:** the branch shows "Joins P3 at 12.40 m" and "Level from main". An open end shows "Open end".
10. **CDCHECK and Project Review:** open ends and Possible junctions are listed as warnings with Connect or Leave.
11. **Labels:** the branch label shows its own invert. The main's label is unchanged.
12. **Downpipes:** a downpipe line drawn to a main uses the same rule. The downpipe becomes the branch, the main is not split, and the pipe keeps the source as its start owner.

## Edge cases

1. **Main moved or regraded:** the branch level follows the main and is marked Stale in the CE data until re-checked (D4). The branch is never silently rewritten.
2. **Within 100 mm of a pit:** the pit wins and a pit connection is made. The tolerance is a Settings value.
3. **Twin or detention mains:** the branch asks which one (CV21). CE never picks.
4. **Main crosses a breakline:** the interpolation uses the main's own inverts only. The breakline is ignored.
5. **Main invert Unknown at that point:** branch invert is Unknown and flagged. Never guessed.
6. **Branch end lower than the main's crown:** warn only (R-27).

## Example drawings

1. **A:** 300 mm main P1 to P2 (40 m), branch ending at 12 m. Expect a node and a matching invert.
2. **B:** downpipe 8 m from a main, ending mid-span.
3. **C:** free end in a lawn.
4. **D:** branch end 60 mm from pit P2 (pit wins).
5. **E:** main with Unknown invert.

## Checks

1. **Automated:** interpolation at the chainage (start, middle, near-end, Unknown); 100 mm pit-wins boundary; the main stays one pipe with one node; the downpipe no longer splits; the Settings rule is read, not hard-coded; open-end flag round-trip; one-Undo; Pit Schedule and long-section rows.
2. **Codex:** drive examples A to E in AutoCAD. Report PASS/FAIL/BLOCKED with drawing evidence. Codex makes evidence and only Tim accepts.

## Tim's 5-step AutoCAD check

1. Draw a branch ending mid-span on a main (example A). Confirm it is accepted and the invert matches.
2. Draw a pipe ending in empty space. Confirm it is drawn with an open-end mark, then run CDCHECK.
3. Draw from a downpipe onto a main. Confirm the main is not split.
4. Open the Pit Schedule and the long section. Confirm the junction shows in both.
5. Press Undo once, then save and reopen. Confirm everything went, then came back correctly.

## Open questions

1. **Long section of a branch:** show the branch as its own second profile, or only a junction marker on the main? Recommend the marker in this batch and the second profile later.
2. **Branch crown above the main's crown:** warn only, or ask each time? Recommend warn only (R-27).
3. **Old downpipes already split on a run:** leave them as drawn? Recommend leave, and offer no automatic change.
