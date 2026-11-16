# The foundation: the few blocks everything is made from

**Why this page exists.** Tim, 16 Nov 2026 (D-085, D-086): "theres so many variables and it feels like too many to take care of and it feels like the ui / ux dont get designed for this and then i add stuff it doesnt feel like its being built onna foundation that is scalable and or can be built on" and "this is where were going wrong were getting caught on tangents". He agreed the idea "hold what is fixed, the rest is worked out" as the foundation for every number. This page is the planning chat's write-up of that foundation. **Status: draft for Tim; the hold idea is agreed (D-086), the rest is proposed.** It serves R-65 (always scalable, always able to be built upon) and D-002 (type it once).

**The test of this page:** adding a new variable, a new kind of thing or a new council rule must be a new LINE IN A LIST, never a new piece of screen and never a special case.

## The seven blocks

1. **Fact.** One number or word about a thing, held once. Every fact has the same three parts: its value; where it came from (given, measured, chosen, worked out, assumed); and whether it is HELD. A held fact is never changed by the plugin.
2. **Sum.** A plain relation between facts, such as "fall = length ÷ grade" or "depth = cover level − outlet invert". A sum has no direction: whichever facts are held, the others are worked out. If too many are held to all be true, the plugin says which, and by how much. Sums live in one list (reference\design\SUMS.md is its start).
3. **Thing** (element). A pit, a pipe, an inlet, a tank. A thing is: a list of its facts; the sums that tie them; how it looks (ordinary AutoCAD objects and the office's own blocks); and its parts (labels, level texts, arrows) at their standard spots.
4. **Join.** A link between two things (pipe end to pit). Sums can run across a join: a pit's outlet invert is the downstream pipe's upstream invert. That is how working levels along a whole run, from either end, is the same mechanism as one pipe.
5. **Standard.** A value from the office list: sizes, text heights, label offsets, drops at a pit, minimum cover and grade, layer and colour. Order of authority: the council, then AS 3500.3, then the office (D-022). A standard fills a fact in; it can be typed over, and then shows as typed over.
6. **Check.** A sum that gives a status in words: green "Suits", amber "Needs a look", red "Wrong". A check never blocks (D-049, D-050).
7. **View.** Anything that SHOWS facts: the window, AutoCAD's Properties, the label on the drawing, the pit schedule row, the criteria box. A view holds nothing of its own. Change the fact and every view follows.

## What this does to the windows

1. A window is not designed fact by fact. It is laid out by the UI plan (design\UI_PLAN.md): preview, numbered cards, "What else changes", button bar. The cards are filled from the thing's list of facts.
2. Every fact is drawn with the SAME part: label, value, where it came from, hold. A word fact that comes from a list is pick-or-type where the list allows it (D-079, D-080).
3. So there is no "upstream then grade then downstream" built into the Pipe window. Hold the upstream invert and the grade, and the downstream is worked out. Hold the downstream (the council's connection) and the grade, and the upstream is worked out. Hold both inverts, and the grade is worked out. Same window, no special cases.
4. "What else changes" is what the joins and sums moved because of this change.

## What this does to "designing from the other direction"

1. **One pipe:** hold the other end.
2. **A whole run:** hold what is truly fixed on this site (the connection invert, cover levels, top water level and orifice: D-018) and let the rest be worked out up or down the run. Where it cannot be made to work, the check says where and by how much (too little cover at P4 by 0.06).
3. **Assumptions:** an assumed fact is just a fact whose source is "assumed". When the real value arrives it is typed once and everything worked out from it follows (D-002, D-030).

## Rulings from the first trial (D-123 to D-125)

1. **A printed grade is what the printed inverts give.** A typed grade is the aim; levels round to the sheet's precision; the label shows the true grade between the two printed inverts.
2. **The plugin never bends a standard by itself.** When held values do not fit, it says how far out and shows what could be changed; the person decides.
3. **A clash is reported by stretch and amount** ("Out by 0.06 between P4 and P1"), listing the held values on that stretch; no single pipe is blamed.

## How a new thing is added later (the scalability test)

1. Write its list of facts (name, unit, where it normally comes from, whether it is normally held).
2. Name the sums that tie them, adding any new sum to the one list.
3. Name its look: which office block or linework, which layer, which parts at which standard spots.
4. Name its checks.
5. Say which window style it uses: at one spot (square preview) or along a line (wide preview).
Nothing else. No new screen design, no new typed-over rule, no new place where a number lives.

## What is deliberately NOT in the foundation

1. Anything about how it is programmed. That is Stage 4, and trial 1 (joins) and a new trial for sums that work in any direction must prove it.
2. The list of facts for each thing. That is the interview, one thing at a time, and it is now a short, repeatable question: "what are its facts, and which are normally fixed?"

## Honest limits

1. Sums that work in any direction are simple for one pipe and one pit. Along a branched run with many held values it is a harder problem; whether it stays quick and predictable must be proven in Stage 4 before it is promised.
2. The Pit and Pipe mock-ups approved on 16 Nov show the approved LOOK. They were built before this page and work in one direction with typed-over as a special case; they are being rebuilt on the hold idea.
