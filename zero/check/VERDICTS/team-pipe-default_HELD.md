# HELD: team/pipe-default at 393b649 (Stage 1 item A5, the size a pipe opens at): the one-page open list

**Verdict: HOLD, and held.** Written Fri 20 Nov 2026, about 12:07 pm, by the check room. This was the branch's last fix round under D-346. By the control room's ruling **D-372** there is no third patch: one short design page on what size a pipe holds and where it is kept (`design\PIPE_SIZE.md`, branch design/pipe-size, being checked now), then one build, checked against D-372 line by line. Nothing from this branch merges alone. Checked on the bench only. The first verdict is `team-pipe-default.md`.

**Who checked this round.** Honest re-check: Team helper, Claude Opus 5.5, `C:\CE_WORK\check\reports\pipe-default2_honest_REPORT.md`. Adversarial re-pass: Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\pipe-default2_adv_REPORT.md`, proofs in `pipe-default2_adv_tests\` and `pipe-default2_honest_probes\`. The two agree on every point below; each found the run fault and the unreadable-width fault separately.

**Suite seen.** 1,906 passed, 0 failed, 2 skipped (main's own) at 393b649, with main 22993fa merged in. Green, and still wrong on the drawing: no test goes down the route the command takes for a new run.

## What closed in this round (stays on the branch)

1. **The last size typed no longer carries into the next pipe.** After a typed 375, a new pipe from nothing opens at 100 and is not recorded as typed; the kind and material still carry (D-263). Also after Cancel and after an edit.
2. **A single pipe off a pit opens at the largest size arriving,** when the arriving pipes have a typed size: one 375; two 225s; 150, 225 and 375.
3. **An older pipe with nothing in its note keeps its drawn width** when the width can be read: 375 stays 375 through OK, a label-side change and a grade change; its cover is worked on 375 and reads Wrong, 0.18 short, as it should.
4. **No test was loosened;** the new tests bite.

## The open list (each proven on the bench; each against a line of D-372)

1. **A run loses the size after its first pipe.** A 375 arrives at the first of five pits; click all five, OK, nothing typed: the pipes are drawn 375, 100, 100, 100. With the arrival at the second pit: 100, 375, 100, 100. D-372: on a run each pipe hands its size to the next, never smaller than what feeds it. Cause: every pipe of the run is worked out before any is drawn, and a size is handed on only if it was typed (`src/CeCivil.Hands/Pipe/PipeRun.cs:195-209, 224, 242`; `src/CeCivil.Acad/PipeCommand.cs:97-102`).
2. **An arriving pipe is read from its note, never from the drawing.** A pipe drawn 375 at its opening size, with no size in its note, arrives at a pit: the next pipe opens and draws at 100. An arriving pipe drawn 375 whose note says 300 gives 300 (`src/CeCivil.Hands/Pipe/PipeTool.cs:261-262`; `bench/CeCivil.Bench.Core/PipeToolWindow.cs:90`).
3. **A note that disagrees with the drawn pipe wins silently, and OK redraws the pipe.** A pipe drawn 375 whose note says 300 (for example its width was changed by hand in Properties): the window shows 300 only, nothing shows 375; OK alone, OK after moving the label, and OK after changing the grade each narrow the pipe to 300. Before OK its cover reads "Suits, cover 0.32" when the drawn pipe has 245 mm against 300. D-372: an existing pipe's size is read from the pipe as drawn; D-349: the drawn pipe supplies the figure; screen rule 26: show both (`PipeToolWindow.cs:74`). This was so on main and at 741f0f2 as well.
4. **A width that cannot be read becomes 100, without a word.** A recognised pipe with zero width and no size in its note opens at 100 and OK writes 100 and a "100 DIA." label; with a 225 arriving it becomes 225; with a note of 300, 300. The same for a negative or broken width, an empty or one-point line. D-372: say so, OK leaves it alone, never 100. The builder's statement that this falls to a refusal is not so. On main this case refused and changed nothing: the branch made it worse (`PipeTool.cs:245-246, 498-511`; `PipeToolWindow.cs:77`).
5. **A size read off the drawing is recorded as typed.** The drawn 375 opens as a held figure marked "chosen", in an editable box, and OK writes "375, chosen" into the pipe's note, exactly as if the drafter had typed it. D-372: shown as worked out, never as typed; a typed size is a hold (`PipeToolWindow.cs:78, 137`; `PipeTool.cs:717`).
6. **That write then changes a pipe the drafter never touched.** After OK on the upstream pipe (nothing edited), a NEW pipe started at the far end of an untouched 100 pipe further down opens and is drawn at 375, while the pipe feeding it still measures 100. New in this round.
7. **Only the first corner's width is read; the writer makes the whole pipe one width.** A pipe with different widths along it reads by its first piece and can be redrawn at one width (`src/CeCivil.Acad/AcadDrawing.cs:127, 163`). Traced in the code; not proven on the bench, which holds one width per pipe.
8. **An untyped pipe keeps no size of its own.** The root of 1, 2, 4 and 6: what a pipe opened at is worked out again from its neighbours each time it is needed, instead of being read from the pipe.

## What held up when attacked

A width that is not an office size (373.9, 380) is kept exactly, not snapped. A pipe in a metre or inch drawing keeps its real width. A pipe leaving the start pit does not count as arriving. The first click is upstream; "Work uphill" does not swap it (D-370). In 27 combinations of existing pipe and edit, no pipe downstream was changed at the moment of OK.

## No ruling (asked of the control room; for Tim's room)

1. **One arriving size known and another not** (U-028).
2. **A deliberately smaller typed size on a run with a larger pipe arriving later** (U-108), and **pipes already drawn below a resized pipe** (U-048).
3. **A pit's separate tag clicked as the start; which single size stands for a pipe with different widths along it; an ordinary pipe leaving a twin-barrel pair.**

## Follow-ups (unchanged from the first verdict)

`FOLLOW_UP\part2-pit-and-pipe.md` items 1 to 7: a zero or negative default-size setting still gives figures; a blank or text setting stops the data library opening; clearing a typed size keeps it; no line compares a typed smaller size with what arrives; no underground-storage test for a site with no tank.

## Owed in AutoCAD, when the one build is merged (replaces section 6 of the first verdict; test copy from the office template, outside Tim's hours, after D-364 is met)

1. **A run:** five pits 10 m apart, a 375 arriving at the first; CD, click all five, OK without typing. Right: all four pipes 375 wide, labelled "375 DIA.". With the arrival at the second pit: 100, 375, 375, 375.
2. **Junctions:** two equal sizes arriving; 150, 225 and 375 arriving. Right: the largest.
3. **From nothing:** right: 100, labelled "100 DIA. ... AT 1 IN 100 MIN.".
4. **A typed size stands;** after it a fresh pipe is back at 100, and a pipe off a 225 is 225.
5. **An older pipe arriving:** a pipe drawn 375 with nothing typed comes into a pit; CD from that pit. Right: 375.
6. **A disagreeing pipe:** draw a 300, change its width to 375 in Properties; ground 10.00, invert 9.38, cover needed 300. Open its window. Right: the drawn 375 shown, the typed 300 shown beside it, cover 55 mm short. Then on fresh copies: OK untouched; label side only; grade only. Right: width and label unchanged each time.
7. **A width that cannot be read:** a recognised pipe with its width set to 0. Right: the window says in words the width cannot be read; OK leaves width and label as they were.
8. **Read off, not typed:** the size of an existing pipe shows as worked out from the drawing, not as a typed figure; after OK its note does not say it was typed.
9. **Different widths along one pipe;** a real twin-barrel pair (D-349); a saved copy after open and REGEN alone: record every width and label before and after.
10. **One Undo** after each OK puts back widths, labels and notes together.
