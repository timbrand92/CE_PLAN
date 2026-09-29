# UX-UNDO-01 / UX-CMD-01 / UX-CMD-03 / UX-CMD-04 - command-line and cursor card (29 Sep 2026)

Source rulings (Tim, `C:\CE_PLAN\decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Command line and cursor" 26 Sep 12:13 and
"Undo names, resuming, recent jobs" 27 Sep 01:34). Class: **Modify** (CD's prompts and cursor feedback); nothing is retired, hidden or renamed.
Both new behaviours sit behind a Settings switch that is **OFF** until Codex accepts them. Status: **card for Tim's approval; CMD-01 (part)
and CMD-04 are built, CMD-03 needs nothing new, UNDO-01 is not built.**

## What exists already (checked 29 Sep, `origin/claude/rel-20260929c`)

1. **UX-CMD-02 (size, grade, length beside the cursor):** built (PR #377, "225 mm at 1 in 100, 12.4 m pipe, lands on pit P6").
2. **UX-RESUME-01 pipe half (CD opens on the last size/type used in that job):** built in 3.0.15. That is the "last values" half of UX-CMD-03.
3. **Nothing** for plain Undo names, AutoCAD-style CD prompts or the snap glow/marker existed.

## UX-CMD-01 - AutoCAD-style prompt (part built, switch OFF): CD's route prompts

- **Today:** `Select point 3 (or Enter to finish with 2 segments):` - no options; the only way to take a point back is Esc and start again.
- **With "AutoCAD-style CD prompts" ON:** from the third point on it reads `Specify next point or [Undo] <Enter to finish, 2 segments>:`.
  Click [Undo] (or type U, Enter) and the last picked point comes off the route, the cursor words and rubber-band go back one point, and the
  prompt asks again. Enter still finishes; Esc still cancels the whole pipe with nothing drawn.
- **Undo is not offered** while only two points are picked, and it never touches the drawing: no pipe exists until the route is accepted, so
  this adds **no AutoCAD Undo step** and no undo grouping is touched.
- **Not built (needs Tim):** the `[Size/Grade/Undo]` half of the example. What Size and Grade do at the command line, and what happens in
  draw-first CD where the New Pipe window has not opened yet, is not answered by the ruling.

## UX-CMD-04 - snap glow and marker (built, switch OFF)

- **Today:** words beside the cursor say "lands on pit P6"; the pit itself does not react.
- **With "Show where a pipe end will join" ON:** while CD asks for the first, second or next point and the cursor is inside a pit's reach
  (outline plus the Settings catch margin - the same reach CE uses to actually join), a soft blue band appears round that pit's outline and a
  small amber square sits at its centre. Move away and both disappear. Screen-only, like the rubber band: nothing is written to the drawing.
- **Respects OSMODE:** if snaps are off (OSMODE 0, or F3 off) neither shows. CD runs with the office's drawing OSMODE from Settings.
- **Size follows the screen:** band about 6 pixels, marker about 10 pixels, capped so they never swamp a small pit.
- **Pits only** (the object a CD pipe end joins). Joining onto another pipe run is not covered - a question for Tim.

## UX-CMD-03 - Enter/Space repeat (nothing new to build)

- AutoCAD repeats the last command on Enter/Space, and CD then opens on the last size/type (UX-RESUME-01). No CE flag switches history off
  for CD, PIT, CDEDIT or the other daily commands (only four helper commands used by palettes are `NoHistory`).
- **Not built:** the pit half (PIT opening on the last pit size/type) needs `PitCommand.cs` / pit recent values, outside this lane.
  Whether Enter repeats a CE command started from a ribbon button or palette is AutoCAD behaviour I cannot verify from here: Codex step 4.

## UX-UNDO-01 - plain Undo names (NOT built: needs a probe and a decision)

Whether AutoCAD lets a plug-in name a step in its Undo/Redo list is not answerable from the code or docs here (Autodesk's internals are
closed). Guessing would put undo grouping at risk for a label. See the PR for the recommended probe.

## Tests

- Pure rules: `SnapTargetFeedbackRulesTests` (switch off, OSMODE off, no outline; box, rotated box, circle; screen-size clamps).
- Pure rules: `CdRoutePromptRulesTests` (old wording unchanged when off; new wording; Undo only from the third point).
- Source guards: both switches default OFF; the CD route prompts are wrapped by the glow; Undo removes exactly one point.

## Codex steps (AutoCAD 2027, a copy of a job drawing with 3+ pits; both switches ON)

1. CD, pick a first point in empty space: no glow. Move the cursor onto pit P3: blue band round P3, amber square at its centre; cursor words
   still say "Starts at pit P3". Move off: both gone. Screenshot each.
2. Set OSMODE 0 (or press F3), CD again over P3: no band, no marker. Restore OSMODE afterwards.
3. CD, pick 4 points, click [Undo]: the rubber-band goes back one point and the prompt asks again. [Undo] down to two points: the option
   disappears. Esc: no pipe, no leftover band or marker.
4. Finish a pipe (New Pipe window, OK), press Enter at the empty command line: CD starts again and opens on the same size and type.
5. Both switches OFF: the old `Select point N (or Enter ...)` prompt and no glow.
