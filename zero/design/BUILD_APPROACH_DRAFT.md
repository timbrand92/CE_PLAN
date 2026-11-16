# How I would design, build and implement it (draft view, not researched yet)

**Asked by Tim, 16 Nov 2026:** "IF YOU WERE DESIGNING THIS PLUGIN FROM SCRATCH HOW WOULD YOU DESIGN, BUILT AND IMPLEMENT IT". **Status:** the planning chat's considered view before Stage 4 research. Tim's Stage 4 rule is "read real pages; never answer from memory alone", so everything under "Build" is a leaning with a named trial that must prove it. Nothing here is decided.

## Design (confidence: high; it comes from Tim's decisions and the civil study)

1. Pits, pipes, inlets and tanks are separate elements that join; each holds its own facts once; parts move on their own (D-031, D-037).
2. Everything shown is read from those facts; standards in one office list; council, then AS 3500.3, then office (D-002, D-013, D-022).
3. The engineer designs; the plugin shows, checks, carries and suggests (CONCEPT section 11).
4. What prints is ordinary AutoCAD objects, the office's own blocks and layouts (D-015, D-039).

## Build (confidence: medium until the trials are run)

1. **One program, one install, AutoCAD 2027 only.** Written in the language Autodesk's own 2027 add-on kit is made for (C#, on .NET). Not three programs with a shared part that must match, and no separate hand-built C++ pieces unless a trial proves one is unavoidable.
2. **No special object types.** The present plugin's one-object pipe is what an outsider's AutoCAD cannot show. Use ordinary polylines, text and blocks, each carrying a small hidden note of its facts and what it is joined to (AutoCAD lets an add-on attach its own data to any object, and that data is saved with the drawing and copied with the object). An outsider's AutoCAD ignores the notes and sees plain linework.
3. **Behaviour comes from the plugin watching and helping, not from locking things together.** When a pit moves, the plugin moves the joined pipe ends in the same step. Grips keep their places; the "along / off" behaviour is added on top of the ordinary grips.
4. **Three layers, so most of it can be tested in seconds without AutoCAD:** the brain (facts, joins, sums, checks, standards: no AutoCAD in it); the hands (reads and writes drawing objects); the face (ribbon, side panel, cards).
5. **Standards and council rules are data files,** not written into the program (R-13, R-32).
6. **A self-check on open** instead of repair commands: does what is drawn still match the notes; say what does not, in plain words.

## The four trials that must pass before anything is built (Stage 4)

1. **Joins:** ordinary objects with hidden notes stay joined through move, copy, mirror, rotate, stretch, undo, save and reopen, and copy between drawings.
2. **Grips:** a label, level text and arrow on ordinary objects can be given the along / off / flip behaviour.
3. **No plugin:** a sheet opened on a PC with nothing installed looks and plots identical; edited there and returned, the plugin reports what changed. Tim's live drawing (P-04) is a case.
4. **Speed:** a big industrial sheet (hundreds of elements) stays quick while dragging.

If a trial fails, the build approach changes before any tool is designed in detail.

## Implement (how the work is run; to be settled in Stage 5)

1. **Order:** the four trials; then the foundations (facts and joins, standards list, self-check, no-plugin proof, one-click update); then one tool at a time: pit, pipe, inlets, tank, levels, pit schedule, title and issue, CE tools; then one real house or units job carried start to issue by Tim; then colleagues.
2. **Each tool:** interview, design record and mock-up approved by Tim, built, tested by machine on made-up drawings, tested in real AutoCAD by someone who did not build it, installed once, accepted by Tim. Built, tested, installed and accepted stay four separate facts (R-18).
3. **One builder at a time.** A ceiling on open bugs; nothing new starts while a tool on the ribbon is broken.
4. **The old plugin is a parts bin (Stage 3):** proven sums, council data and the office blocks are taken; the special pipe object, the scattered settings, the repair commands and the install machinery are the likeliest to be left behind. That sorting has not been done yet.
5. **No dates until the trials are done.**
