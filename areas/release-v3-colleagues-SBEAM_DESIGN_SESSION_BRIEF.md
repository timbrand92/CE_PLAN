# SBEAM design session: brief for a fresh chat with Tim (written by desk plan/03, Sun 18 Oct 2026)

## Why this exists
Tim says he has explained how an SBEAM steel section drawing should look "1000 times" without being understood. The desk chat tried to settle it as a yes/no question ("keep the two lines inside the flanges?") which is the wrong shape. This session replaces the question with a design conversation: Tim describes, the chat DRAWS it back, Tim corrects, until the picture is right.

## What the chat must do differently
1. **Listen first, do not propose.** Ask Tim to describe, in his own words, what he draws today by hand for a steel beam in section, side elevation and front elevation, and what the drawing is FOR (shop drawing, general arrangement, detail on a sheet).
2. **Draw it back after every answer.** Use a simple picture each time (an SVG or a plain text sketch with labelled lines) and ask "is this right, what is wrong". Never ask Tim to confirm words alone.
3. **Write each confirmed point down immediately** in a numbered list "Tim's rule N: ..." so nothing is lost; read the list back at the end.
4. **Do not touch code.** Output is one design card, not a change.

## What is known (do not re-ask these)
1. Command SBEAM (Steel / Timber Beam Section window) and SBEAMEDIT. Card: `C:\CE_PLAN\04_REFERENCE\CARDS\ST-08_SECTIONS_DETAILS.md` section ST8-4 (Keep core, improve workflow). Structural stays on Tim's PC only (ruling B3), so there is no colleague deadline on this.
2. Today (Structural 1.0.118, 610UB125 [UB], seen by Codex look L3-06c, 18 Oct): the Section view is a filled I outline. The Side Elevation shows two solid horizontal lines just inside the top and bottom flange edges. The Front Elevation shows two dashed vertical lines down the centre. Pictures: `C:\Lisp Files\_TEST_COPIES_20260923\` files named L3-17-sbeam-side.png, L3-17-sbeam-side-close.jpg, L3-18-sbeam-front.png (find them with a search for L3-17).
3. The bug entry is BUG-750 in `C:\CE_PLAN\BUG_CARPARK.md`. The draft fix PR #1384 only adds a switch: ON = today's lines, OFF = outline without the inner flange lines. It decides nothing; Tim's picture does.
4. Opus review (REVIEWLANE_LOG entry 1194) says the inner flange-to-web lines are what a drafter normally draws in a side elevation, but this is the reviewer's belief, not Tim's. Treat Tim's description as the only authority.

## Questions to get answered by drawing, not asking
1. Section view: filled outline, outline only, or with the web and flange thickness shown? Hatch or not?
2. Side elevation (looking along the beam from the side): which lines does Tim expect, and which does he NOT want? What do the lines inside the flanges mean to him?
3. Front elevation (looking at the end of the beam): the dashed centre lines: wanted or not, and what do they represent?
4. Timber beams (same command): same rules or different?
5. Scale and line weights: how should the lines look at 1:20, 1:50, 1:100?
6. What does Tim want to change by hand afterwards? (That tells us what the command should do for him.)

## Output
Write `C:\CE_PLAN\areas\release-v3-colleagues-SBEAM_DESIGN_CARD_<date>.md`: Tim's rules (numbered), one picture per view, and what the command should draw, in AutoCAD words. Then tell Tim the card is ready for the Structural train. The desk will turn it into a fix.

## Opening prompt to paste into a new chat (the desk could not open one itself)
RUN CONFIG: Opus (latest), thinking medium; Why: a listening and drawing conversation; Downgrade: Sonnet is fine if usage is tight.
NAME THIS CHAT: CE_ACAD / structural / sbeam design / 01
Prompt: "Read C:\TimOS\RULES.md and C:\CE_PLAN\areas\release-v3-colleagues-SBEAM_DESIGN_SESSION_BRIEF.md and run the SBEAM design session with me exactly as the brief says. Start by asking me to describe how I draw a steel beam in section, side elevation and front elevation by hand, then draw it back to me as a picture after each answer. Do not touch code."
