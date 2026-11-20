# Answer on a design page: `design\PIPE_SIZE.md`, branch design/pipe-size at 7c8d90c (the size a pipe holds and where it is kept; D-372)

**Answer: FIX THE PAGE FIRST. Do not build from it yet.** Written Fri 20 Nov 2026, about 1:05 pm, by the check room. A check of a page, by reading; no code was built or run.

**In one line.** The core of the design is right and closes every finding of the two A5 checks: one home for the size (the pipe as drawn), one reader, a run hands its size on, an older pipe is never redrawn from a guess. But Tim has ruled several of its "open" questions since it was written, the page would build three of them the opposite way, and it leaves ordinary cases undefined so the builder would have to guess. The fixes are about a page of words, not a redesign. It then needs one more read.

**Who read it.** Honest read: Team helper, Claude Opus 5.5, `C:\CE_WORK\check\reports\design-pipe-size_honest_REPORT.md` (D-372, D-263 and D-349 statement by statement; every finding with its rule and test; 26 cases walked). Adversarial read: Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\design-pipe-size_adv_REPORT.md` (12 must-fix items, 7 questions). Both say fix first, for overlapping reasons. The check room read both and the rulings D-372 to D-383.

## 1. Where the page now goes against a ruling (written since the page was saved at 11:57 am)

1. **A size typed for a run is HELD on every pipe of that run** (D-379, Tim: "All five are held"). The page's section 2.3 and test 5 hand it down as worked out with only the first pipe held. That was the control room's draft; Tim overturned it.
2. **A pipe resized bigger: offer once, then flag** (D-373 item 3). The page says the pipes below are simply not changed (sections 1.3, 2.4, 8.4). It must say: one offer to change the pipes downstream in the same Undo; if refused, each is flagged "Needs a look"; an offer never touches a held size without asking (D-379); merely opening a pipe never triggers it. It must also say WHO makes that several-pipe change (the edit doorway, D-348, which is built later): either this build carries the offer, or it carries the flag only and the offer waits for the doorway; and where "Needs a look" shows in Stage 1 (U-082).
3. **A typed size smaller than a pipe arriving: draw it, amber "Needs a look", never blocked** (D-373 item 2). The page has no rule; its test 6 expects only the 150 drawn. The window must show both sizes in words ("150 is smaller than the 225 running into P1").
4. **A typed size that no longer matches the drawing** (D-380, confirmed by Tim): the drawn size is shown, with both figures in words, and one click to put the typed size back. The page's sections 1.2, 3.4 and 6.2 pull against each other on what OK then writes; one size-and-source pair cannot keep both facts. It must say: the window, the label the tool wrote, the cover check, the next pipe, storage and schedule all use the DRAWN size; the typed figure is kept and shown until the drafter resolves it; OK without touching the size changes neither width nor label and does not lose the typed figure.
5. **A drawing in metres is refused, saying why** (D-344, confirmed in D-380). The page's section 3.1 and test 12 pass a 0.375 m pipe as editable. The command test must be the refusal, with nothing changed.
6. **"Live" means the preview panel inside the window** (D-382): nothing is painted on the drawing behind the window. Section 4A.5 and test 17 must say so; the preview's sizes come from the same plan that is then drawn.
7. **Only the ordinary pipe is in Stage 1** (D-377): twin barrels, detention, charged, suspended are later. Section 4.3 (twins) stays as a door, not as Stage 1 work.
8. **A run starting or ending on a pipe joins it part way; the old pipe stays one** (D-374), and a pipe started off a pipe opens at that pipe's size (D-263; D-373 item 4: "100, unless it joins a pipe"). The page counts only pipes ending at a pit. It must say whether a start on a pipe is in this build or with A6, and give the test either way.
9. **A picked polyline with an arc, closed, on a locked layer or in an xref is refused, with the reason** (D-375). And picking an already recognised PIPE as the path must open that pipe's edit window, never erase it as "a path" (section 4A).
10. **An arriving pipe that cannot be read: open at the biggest it can read, saying which pipe could not be read** (D-379 item 2). The page leaves it open. It must also say what happens when the ONLY arriving pipe cannot be read: an empty list of readable sizes must not become "nothing joined, so 100".

## 2. Ordinary cases the page leaves undefined (the builder would have to guess)

1. **What OK writes to the pipe's note, case by case:** first open; OK untouched; an unrelated edit; second open; for a size typed, read off, and worked out. Section 1.2 says every OK stores the size; section 3.4 says no size goes into the note unless typed; test 9 expects one of them. Opening, REGEN and Cancel write nothing. A size worked out or read off must never reopen as typed. Say what reads each stored figure, or do not store it.
2. **Clearing a typed size:** it goes back to the read-off size (existing pipe) or the worked-out size (new pipe), dashed, and OK removes the hold. No rule and no test today; both A5 checks listed it.
3. **A width that cannot be read, for everything that depends on it:** the window says "Not known"; cover and storage say "Cannot check yet"; the label the tool wrote and the schedule row read "TBC", not the old "300 DIA."; a missing contribution never gives a storage total as if complete. Name every unreadable width: zero or less, not a number, tapered, different widths along it, a one-point line, a recognised pipe with its band missing.
4. **A width that is not an office size (230, 373.9):** kept as drawn (this held up on the bench); say what the label prints and what the material lookup (D-239) does with it.
5. **Which pipes "arrive" after a pipe's flow is reversed in its window** (D-370: the first click is upstream until reversed): the end that offers its size must swap.
6. **How the widths along a pipe are carried and written.** Today one width is read (the first corner's) and the writer sets one width for the whole pipe. The page must say the reader returns every piece's width or a reason, and the writer never flattens a pipe the reader could not read; a typed size on a tapered pipe makes every piece that size.
7. **A failed write half way through a run or a picked path:** the original path, widths, notes, labels and joins are all as before; nothing is erased until the last pipe is written. The page keeps main's own roll-back, which the doorway design (D-348) replaces: say which.

## 3. One reader (D-349): what the page must add

1. **Name every place that reads a pipe's size today and send each through the one reader:** the Pipe window (`src/CeCivil.Hands/Pipe/PipeTool.cs:178`, `bench/CeCivil.Bench.Core/PipeToolWindow.cs:52`), finding which pipe a click is on (`PipeTool.cs:367`), the Pit window's joined pipes (`src/CeCivil.Hands/Pit/PitTool.cs:668`), levels along a run (`src/CeCivil.Hands/Run/RunTool.cs:224`), and two width readers in `src/CeCivil.Acad/AcadDrawing.cs:127, 582`. With a 375 pipe whose note says 300, the Pit and Levels windows would still show 300 without touching a width: a text search for "width" would pass.
2. **The order of work:** the page's section 7.2 puts the rest of the reader (C9) after the doorway and cites D-342, which is about something else. The build room's order is held-depth, A6, pipe size, A7, C11, the rest of the reader, then the doorway. The page and the order must agree, and the control room's calls of 12:10 pm (first piece of the single reader; build order) are not written in `DECISIONS.md`: they should be.
3. **Does this first piece work the size out each time it is asked** (nothing kept, nothing stale) until the reader runs after every edit? Say so.

## 4. The acceptance tests on the page

1. **They must run on the route the command takes.** The page requires it; the A6 test host (`codex/tests-a6b`) runs the real command against a pretend drawing, but it clears "last used" before and after every run, returns no pick-first selection, and does nothing at the end of a command. So: the "last size never carries" test needs two commands in one session; the edit tests need both ways in (pick-first and Select); a preview must be told apart from what was saved.
2. **Three faults that pass all 17 tests today:** no amber words on a typed smaller size; a typed hold lost on OK of a disagreeing pipe (tests 9 and 10 use pipes with no hold); a picked path erased before the last pipe's write fails.
3. **Tests to add:** a note of 300 on a pipe drawn 375, ground 10.00, invert 9.38, 300 needed: window shows 375 and "Wrong, 55 mm short"; then OK untouched, label side only, grade only: still 375 (the proven fault of the last round has no test on the page). A malformed size word in the note. A run of three 100s, 150 typed on the top one, Yes then No. Reopen a typed 150: still solid. OK on an upstream pipe, then a new pipe at the far end of an untouched 100 below: opens at 100. A tapered pipe whose pit is moved keeps every width.

## 5. What is right and held up when attacked

A run can increase part way (225, 225, 375, 375, 375 with a 375 arriving at the third pit); odd widths are kept; a pipe leaving a pit never counts as arriving; only pipes arriving directly count, so nothing walks back up the system or round a loop; the last typed size and the width of a plain picked polyline never become a size. Every one of the six findings of the two A5 checks has a rule and a test.

## 6. Questions for Tim the page raises (for Tim's room; none holds the fixes above)

1. **Only an unreadable pipe arrives:** what may be drawn before he gives a size?
2. **How far the one offer reaches:** a held pipe, a larger side pipe, a fork or a loop below; and does joining a NEW bigger pipe into a pit with an existing smaller outlet make the same offer?
3. **A typed size on a copied pipe:** does the copy open solid with the 300, or dashed until someone types on the copy?
4. **"Always last used" for the pipe** (D-263's setting) against "a pipe's size never carries" (D-372): recommended, the setting carries the pipe's kind and choices, never its size.
5. **A size that is not an office size:** keep and label as drawn with amber words, or offer to snap?
6. **An old joined pipe with no record of which way it flows.**
7. **The sleeve under a garage** (a 100 inside a 150): which size opens the next pipe and which is used for cover. Already with Tim's room (D-378).

## 7. What happens next

The designer corrects the page; the check room reads the corrected page once more (one reader is enough if the changes are those above); then the build, checked against D-372 with D-373, D-374, D-375, D-379, D-380 and D-382, line by line, both halves.

## 8. Ruled by the control room at about 1:15 pm by its clock: D-384 (the corrected page is read against it)

1. **The order in the drawing code is written:** held-depth, command order, PIPE SIZE as the first piece of the single reader, labels, C11, the rest of the reader, the doorway. The page's section 7.2 is to follow it.
2. **The pipe-size build carries the FLAG only** for pipes downstream of a resized pipe; the one offer to change several pipes (D-373) waits for the doorway.
3. **Until Tim rules where a flag shows in Stage 1:** "Needs a look" shows in the window's band for that part and once on the command line.
4. **The page is corrected against D-373 to D-383 and read once more by the check room before any build.** The questions in section 6 have gone to Tim's room.
