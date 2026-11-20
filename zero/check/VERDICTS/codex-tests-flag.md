# Answer: the flag marker test list (the amber no-plot marker), codex/tests-flag at 3189f66

**Answer: HOLD THE LIST. Eight reasons.** Written Fri 20 Nov 2026, about 3:32 pm, by the check room. Checked on the bench only. First answer on this list.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\flag_honest_REPORT.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\flag_adv_REPORT.md`, proofs in `flag_adv_proofs\` (its first run was cut off by a restart of the check room's chat and run again from its kept proofs). A product cheat turned all 685 tests green with a triangle on a plotting layer and no warning beside an ordinary undersized pipe. They agree; graded here.

## 1. Counts seen (the writer's counts are true)

Pretend drawing 685 ran: 11 targets fail, the 1 control passes, 673 older pass; brain 750, bench 438 pass; the saved-drawing reader 19 pass, 2 skipped (main's own). Only test files changed. Every target fails because the product does the wrong thing. The file is `tests/CeCivil.Hands.Tests/Stage1FlagMarkerTests.cs`.

## 2. Reasons to hold

1. **Amber is never checked, and the easy path gives grey** (lines 55-67, 198-214). The office marker layer is made in colour 8, grey (`src/CeCivil.Brain/data/tools.csv:296`); a marker drawn by its layer is grey, which already means "Cannot check yet" (D-219), and every target goes green. D-385: "a small amber marker". Read the marker's colour as it shows.
2. **The marker can print** (helper `Flags()` at 248-250 finds markers by layer NAME; only lines 64-66 look at the plot setting). A second triangle on the plotting pipe layer passed; a marker layer that already exists and is set to plot took a marker. Every target must check that the marker's layer does not plot, look at everything the edit added on every layer, and one case must cover a drawing whose marker layer already plots (its expected result waits on question 2).
3. **The marker can be anywhere, and need not be a triangle** (60-64, 203-207). Three points in a straight line, a kilometre off the run, passed; in the smaller-pipe cases a marker beside the 300 instead of the 150 passes. D-385: "beside the label or part". Check a real triangle, small, nearer its own label or part than any other.
4. **Two pits can still show the same number** (198-245, 342-356). The typed-duplicate target accepts a line holding "P1" and "number" (the amber warning the window already shows) and never presses OK; at another spot the cheat let P5 become the occupied P4, both tags reading P4. The other target writes a hidden name while the tag still reads P2; three real duplicates got 0 markers. D-390 item 3, D-185. Drive it through OK, read the visible tags, and count markers for three, two, then none.
5. **Opening and cancelling can lose his own wording** (105-134). The hand-typed label is checked before the window opens; the cheat rewrote it on opening and Cancel lost it; "150 DIA. (formerly 225 DIA.)" passes the after-click check. D-182, D-103. Check open, Cancel, OK without the remedy, the remedy then OK, and the whole printed label each time.
6. **The clear and erase targets expect the whole marker layer empty** (166-192). That rewards erasing other parts' markers and anything else on that layer: the cheat erased an unrelated circle, one in an xref and one outside the reference-edit set. Expect this part's marker gone and its neighbours untouched (D-348, D-381).
7. **The opposite words pass** (27-49, 72-109): "No overlap" and "No smaller 300" satisfy the contains checks, and a sound pipe can show the notice. Nothing checks that the marker carries its reason or that the window says the same (D-385). Read the reason on the marker's own record and the window's band for that part, and one clean part with neither.
8. **The tests open the bench's window, not the command's** (264-265, 359-360). With the warnings made only in the bench opener the command's own window lost them, and the real end-of-command handler returns early on an empty plan (`src/CeCivil.Acad/Commands.cs:230`), leaving duplicate pits unmarked. Use the command-facing window and the same guard.

## 3. To fix in the same round

1. **Scope, and it matters:** eight of the 11 targets cannot go green without other jobs' work (the smaller-pipe check is pipe size's; "no clear spot" and the hand-typed label are the labels job's), yet D-389 puts the marker BEFORE them. Trigger the marker's own tests (shape, colour, layer, place, clear, erase) on the failed grade check, which the product already has; move the reopened smaller-pipe target to the pipe-size list; tag the overlap and hand-typed targets to the labels job.
2. **The first-spot target refuses 0.04 mm** (line 48): within a tenth of a millimetre is the same point (D-341, D-380).
3. **The two-fault target assumes one marker** (140-160), which is not ruled: test that each live reason is told and that the last warning goes; leave the count until question 3 is ruled.
4. **Take `TESTS_FLAG_RUN.log` out of the commit** (1,215 lines of run output with local paths; no user or machine name found) and leave `TESTS_REPORT.md` off the main line.
5. **Add:** the marker moved, copied and mirrored with its part; the marker layer locked, off or frozen (nothing unlocked: D-348; say why in words); erasing one of two duplicate pits; a pit as well as a pipe; D-400 (ByLayer, Z 0, scale 1).

## 4. For the control room (no ruling found)

1. **Amber against ByLayer.** D-400 says ByLayer for everything; the office marker layer is colour 8, grey. Is the LAYER made amber (which colour number), or does the marker carry its own colour?
2. **The marker layer already exists and is set to plot** (never changed: D-381). Draw no marker and say so in words; or stop the edit; or draw it?
3. **Two reasons on one part:** one marker listing both, or one each?
4. **Does the command line still say it once,** now that the marker exists (the stop-gap of D-384 item 3)?
5. **A marker erased by hand while the fault remains:** when does it come back? And an older drawing that opens with two pits of one number: marked when?
6. **"p4" or " P4 " typed when P4 exists:** the same number?
7. **How small is "small",** and how far off the label?

## 5. Owed in AutoCAD (when a marker build is merged)

The marker on the plan at 1:100 and one other scale; hover words against the window's; a plot of the sheet with an ordinary line as witness (the marker absent); save and reopen; copy, move, mirror; Cancel, one Undo and Redo (the danger: Undo takes the marker and leaves the undersized pipe).

## 6. Ruled since (control room, about 3:36 pm, D-401; all DRAFT until Tim confirms them one by one)

1. **Colour and layer:** the marker is ByLayer; the tool makes its OWN no-plot marker layer coloured amber (AutoCAD colour 40); the office grey layer is not used. The layer's name is a setting, still open.
2. **That layer already exists and is set to plot:** it is never changed; NO marker is drawn; the command line and the window say the fault in words and why there is no marker; the edit is not stopped.
3. **Two reasons on one part:** one marker listing both.
4. **The command line** still says it once per command.
5. **Erased by hand while the fault remains:** it comes back at the tool's next check of that part (an edit of it or of a joined part, or opening its window); never on opening the drawing. An old drawing with two pits of one number: marked at the first edit touching either.
6. **"p4" and " P4 " are P4** (capitals and spaces ignored).
7. **Size and place:** the triangle is as tall as the label's text, one text height clear of the label's end, or beside the part if there is no label; settings.
8. **Agreed:** the marker's own tests are triggered by the failed grade check; targets needing pipe-size or label work are WAITING.


---

# Second answer: codex/tests-flag at 68fcd50 (after its first fix round)

**Answer: HOLD THE LIST. Six reasons; three of them exist only because Tim ruled on the marker layer AFTER this round was written (D-407, 4:36 pm). One fix round left.** Written Fri 20 Nov 2026, about 4:50 pm. Checked on the bench only.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\flagb_honest_REPORT.md` (all eight reasons closed; hold on one stale file). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\flagb_adv_REPORT.md`, proofs in `flagb_adv_proofs\` (the saved cheat now turns NO target green; a new cheat written against this tip turned all 18 green with two triangles on a plotting layer and a faulty pipe unmarked). Graded here.

## 7. Counts seen (the writer's counts are true; the whole solution builds, the AutoCAD plug-in project included)

Pretend drawing 695: 18 targets fail on the original product and with the saved cheat, 1 control passes, 3 waiting tests skipped with their reasons, 673 older pass; brain 750, bench 438 (one known flake passed when run alone), reader 19 and 2 skipped. Only tests changed. The run log is gone from the tip.

## 8. What the round closed

The bench's own window (now the command's factories and the empty-plan guard); 0.1 mm as the same point; every word check exact and taken from the product's own check sentence; the marker's reason and the window compared; a real triangle of the ruled size one text height past its own label; clearing one part's marker leaves the neighbour's and three other objects on the layer; moved, copied, mirrored; locked, off and frozen marker layer; three duplicate pits counted 3, 2, 0; the hand-written label followed through open, Cancel and OK (waiting, for the labels list); the scope is right: the marker's own tests are driven by the failed grade check.

## 9. Reasons to hold

1. **The layer targets now require the opposite of Tim's ruling** (D-407 items 2 and 3, filed after the round). The marker goes on the ONE layer named "CE NO PLOT"; the list forbids that layer and demands a second one (lines 18, 41, 48). A marker layer found set to plot is put back to no-plot by the tool, said once, and the markers keep working; the list demands it be left plotting with no marker drawn (lines 89-118). Restate both; keep a separate plotting layer and a witness line that must stay as they are. The colour waits on question 1.
2. **A marker can still print, and a faulty part can go unmarked.** Markers are found only as three-point polylines (lines 526-527): the new cheat drew two FOUR-point outlines on the plotting pipe layer and passed; "nothing else was added" is checked in two targets only (73, 112); the pit markers have no greatest distance (one sat 1,000,000 mm away and passed: 545-561); a 13 m pipe with a failed grade got no marker. Take stock of every layer before and after in EVERY target; measure the gap to the part's own tag or label; vary the pipe's length and direction.
3. **Clearing can erase the drafter's own linework.** Fixing the grade erased an unrelated triangle on the marker layer, one marked as xref content included; the witnesses in lines 224-262 are all circles. Markers are told by their owner, never by their shape (D-348, D-381): add a triangle of his own and one in a reference set, read back after a repair and an erase.
4. **The two-reason target needs a Detention pipe** (lines 188-214), which is Stage 2 (D-377 item 1; D-399 parks the like check). Use two ordinary Stage 1 reasons, or hand two reasons to the marker's own writer.
5. **The command line:** one line carrying both reasons FAILS the helper, and the same reason said twice passes (203-204, 583-584). D-407 item 4: the marker and ONE line on the command line. Read the lines the command really gives.
6. **A stale report file is in the commit:** `TESTS_REPORT.md` (says 11 targets, the grey layer, links the removed log). Take it off the branch.

## 10. To fix in the same round

1. **The typed-duplicate refusal is now a job of its own** (D-409 item 5): move its two rows to that job's list; here keep the duplicate that arrives another way. Test the number on the office circle tag's own attribute (PIT LABEL 2, PIT_LABEL: D-404), not on plain text; add "p4" and " P4 " (D-401 item 6) and a NEW pit.
2. **The grade reason accepts any name in front of it:** two loose pipes in a drawing with no pits both read "P4 to P3 grade ..."; read the real part's own number (D-398) and joins.
3. **The waiting crowded-pipe-label case expects the first spot and a marker;** Tim now sends a crowded PIPE label onto a pointer (D-405, D-407 item 6); an invert level, pit number or cover level stays at its first spot with the marker: correct it on the labels list and add the pit case.
4. **The waiting cases' words** ("no longer matches", "Follow" or "Restore", "150 is smaller than 300") are the writer's own: for the labels and pipe-size lists to confirm before un-skipping.
5. **Add:** a part with its label ticked off (marker beside the part); a grey "Cannot check yet" part gets no marker (D-219); the layer's name read from the setting, with a second value tried; D-410: a marker when a typed length and the drawn length differ is a DRAFT (waiting).
6. **Merge as one squashed commit** (the first commit still holds the run log in its history).

## 11. For the control room

1. **The colour of "CE NO PLOT".** D-407 names the one layer; the office data makes it colour 8, grey; D-385 says amber and D-400 says ByLayer. If the drawing already has a grey CE NO PLOT with other things on it, may the tool recolour the layer to amber (everything on it changes colour), or does the marker carry its own amber? And on a bare drawing, is the layer made amber (colour 40)?
2. **A marker whose ruled spot is taken** (a turned tag, other text in the gap, or no label): which side or spot next?
3. **The marker layer off or frozen:** is the marker drawn unseen, or not drawn and said in words? (The tests accept either.)
4. **Does every amber "Needs a look" get the marker,** or only the cases D-385 lists? How wide is the triangle (only its height is ruled)?

## 12. Owed in AutoCAD

Section 5 stands, with: the circle tag's real attribute; ByLayer colour, linetype and lineweight; Z 0 and scale 1; the layer found plotting and put back, said once; a plotted sheet with a witness line.
