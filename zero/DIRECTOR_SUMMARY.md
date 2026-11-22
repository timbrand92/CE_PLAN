# Director's summary (the page Tim gets every time he asks "how are things going")

**Why this file exists.** Tim, 17 Nov 2026: "i need a way to understand wht we have planned, what we have built, how close we are to finishing or getting a ready version for me to test and bugs and anythign else thats important if i was a director looking to get summaries. i need this everytime i ask how things are going and also you need to keep me on track with planning, building annd beyond". The control room updates this page before every progress answer and always uses these seven headings in this order.

**Last updated:** Sun 22 Nov 2026, 11:17 pm (clock read). Board to item 211. Decisions run to D-464. Scope: the one-job release, Stage 1 only (Parts 1 to 3), measured by `stage6\STAGE1_TIMS_EYES.md`. Questions waiting for Tim: `interview\FROM_CONTROL_ROOM.md` sections M to Z.

## 1. Headline

Since 3 pm Sunday the tool runs in AutoCAD's engine after every build, and about 17 builds have merged in eight hours under one loop (build, test, engine run, merge). Every engine regression check that can run is green: PASS 96 / FAIL 0 / NOT TESTED 10. Tim's own Stage 1 list, run as a second scorecard: PASS 7 / FAIL 5 / BLOCKED 1. Nothing is installed: built 2 of 9, checked 0, installed 0, accepted 0.

## 2. Planned

1. **Stage 1 of the one-job release:** Part 1 drawing safety, Part 2 Pit and Pipe, Part 3 cover and grade checks.
2. **Target for Monday 8:40 am (no promise):** Pit and Pipe on the main line with every engine check green.
3. **Parts 4 to 9 and everything in the parking lot:** not started, by his ruling of 19 Nov.

## 3. Built (four separate facts)

1. **On the main line (55764eb):** rounding, CE Settings store, the Pit window with pit levels, the pipe run, labels, units refusal in inch drawings, the council level check, the EXPLODE fix, the duplicate pit number check, the marker, the reverse-run check, the engine runner and the fast pre-flight.
2. **Built, not merged yet:** the edit routes (STRETCH, TRIM, EXTEND), the resize fix for hand-typed labels, shaped grips (waits on the edit routes), and fixes for four of the five fails on his Stage 1 list.
3. **Proven in AutoCAD's engine:** what lands in the drawing, on test drawings, in about 12 seconds per run. NOT proven: windows, grips, mouse picks, previews, the ribbon. Full AutoCAD has been stopped since 19 Nov.
4. **Installed: 0. Accepted by Tim: 0.**

## 4. How close to a version you can test (no guessed dates)

1. **What the drawing gets:** close. The engine proves it on every build; five fails on his own list remain.
2. **What the hand feels (windows, grips, picks):** not proven at all. It needs full AutoCAD driven by a robot, which is stopped on his PC; a sealed test computer would lift that and waits on his word.
3. **Stages left:** merge the edit routes, the label fix and shaped grips; clear the five fails; prove windows and grips in full AutoCAD somewhere safe; install on his word.

## 5. Problems and bugs

1. **The build room sat idle from about 8:30 pm to 10:47 pm Sunday** after its jobs finished; restarted by a nudge. About two and a quarter hours lost.
2. **Five fails on his Stage 1 list:** resize overwrote a hand-typed label; an unpicked middle pit gave one pipe, not two; the far-end level in two places is missing; a branch that doubles back does not join; the MIN. ending on a label.
3. **Windows, grips and mouse picks cannot be proven by the engine.**
4. **Usage over the line:** 46 per cent of the Claude week, top model 55, after about 2.4 days (line 44). No Claude helpers; all builds and checks on Codex. Team account spent until 1 Dec.
5. **API key billed by mistake on Friday** (about 321 million tokens). Ruled out for good (D-457); the Windows-wide variable is still set, his to remove.
6. **Block drawings:** local use only (D-464); the four findings are still unread. Two pit checks stay NOT TESTED until one combined blocks drawing exists.

## 6. Waiting on Tim

1. **Pit EXPLODE:** same as the pipe (plain pieces, one notice, one Undo restores), or something else.
2. **Combined blocks drawing for testing:** from the 18 supplied drawings, from his office master, or neither for now.
3. **A sealed test computer** for full-AutoCAD robot runs at night.
4. **Stryker download** for a one-hour trial of a test hunter, yes or no.
5. **Pipe window layout:** option 1 or option 2.
6. **Typed pipe length on a split;** the block drawing findings; the API key variable; the Team limit.

## 7. Next step (one only)

The build room merges the edit routes, the label fix and shaped grips overnight and reports at 6 am against the 8:40 am target.
