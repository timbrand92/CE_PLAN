# Stage 4 trial results (zero plan)

**Run by:** the trial chat, from Mon 16 Nov 2026 20:46 Melbourne. **Brief:** `TRIALS_BRIEF.md`. **Code and evidence:** `C:\CE_WORK\trials\zero\` (nothing in this repository except this file).
**Rule for this file:** it is updated after each trial, so a stopped run still leaves a true record. A trial that has not been run says NOT TESTED.

## Where it stands

1. **Trial 11, any direction:** PASS (pure code, no AutoCAD).
2. **Trial 10, headless predicts full:** PASS for the scripted commands tried (see below). Run under the old limits, before the licence incident. Not repeatable under the new limits.
3. **Trial 1, joins:** PASS for the commands tested (soft pointer wins; end-of-command mover works, close-hook mover fails). Xref bind not tested.
4. **Trial 3, no plugin:** PASS (plot identical, plain edit, plugin reports the change). LT and Tim's drawing not tested.
5. **Trial 2, grips:** NOT TESTED yet.
6. **Trial 4, speed:** PASS for command and mover cost (about 40 ms per move on 2500 objects); mouse-drag feel not measured.
7. **Trial 5, Properties:** BLOCKED for the palette (needs the Properties palette opened, a saved interface setting); the .NET property list works at code level.
8. **Trial 6, window, live preview and Inspect:** PASS at 1920 x 1080 (21 ms redraw, Inspect returns with values); 2560 x 1440 simulated only; mouse pan/zoom during Inspect not tested.
9. **Trial 7, ribbon tab, tips and typed names:** NOT TESTED yet.
10. **Trial 8, double-click:** NOT TESTED yet.
11. **Trial 9, update and rollback:** NOT TESTED yet.

---

## Trial 11. Any direction ("hold what is fixed, the rest is worked out")

**Verdict: PASS.** Pure code. No AutoCAD was started. Run Mon 16 Nov 2026 about 20:50 to 21:10.

1. **What was done.** A small solver written as plain C# on .NET 10 with no AutoCAD in it (`C:\CE_WORK\trials\zero\t11\`, files `Brain.cs` and `Program.cs`). Every level is a whole millimetre; a grade is a whole number "1 in N". A fact has a value, a source (given, chosen, worked out, standard) and a hold flag. A sum can be turned round for any one of its facts. The solver starts from the held facts, works out any sum that has exactly one fact missing, records which sum and which facts each worked-out fact came from, and repeats until nothing new appears. Then it checks every sum that has all its facts known.
2. **What was reproduced from the three mock-ups (all matched, to the figure).**
   1. **Pipe window (8.0 m long):** hold upstream 5.23 and grade 1 in 100, downstream comes out 5.15. Hold downstream 5.15 and grade, upstream 5.23. Hold both inverts, grade 1 in 100. Hold 5.23 and 5.14, grade 1 in 89. Flat pipe: grade stays unknown and the solver says the sum cannot be turned round.
   2. **Pit window:** hold cover 5.75 (outlet 5.13), depth 0.62. Hold depth 0.62, cover 5.75. Hold cover and depth, outlet 5.13.
   3. **Run window (four pits P4 to P1 and the connection):** uphill from the connection 4.95 with all grades 1 in 100 gives inverts 5.28, 5.18, 5.08, 5.00 and cover 0.40 at P4 (the mock-up's figure). Downhill from the top 5.30 arrives at 4.97. Holding one end (P3 outlet 5.22) releases that pipe's grade to 1 in 67 and lifts P4 to 5.32. Holding both top 5.30 and connection 4.95 with all grades held is reported as out by 0.02.
   4. **The drop across a pit is a standard that can be typed over.** Left alone it fills in 0.02. With both sides of a pit held (5.10 in, 5.07 out) it is worked out as 0.03, no error, and a check can compare it with the standard (the mock-up's "Needs a look: drop is 0.03, standard is 0.02").
3. **The branched case (20 pits, 19 pipes, 3 branches into a main run of 8).**
   1. **(a) Hold the outlet invert and every grade:** all 20 pit levels match a separate hand calculation (plain recursion, no shared code) to 1 mm. Same answer in 200 shuffled orders of the sums.
   2. **(b) Hold the outlet invert and the upstream invert at every dead end** (grades held except the one beside each dead end): all 20 levels match (a) and the hand calculation; the four released grades come back as grades that give the same fall as (a). Same answer in 200 shuffled orders.
   3. **(c) A deliberately conflicting set** (dead end A1 held 60 mm too low): one conflict, 60 mm. It names the held facts behind it: the outlet, the dead end, the grades and drops of every pipe on the path between, and nothing from the other two branches or the rest of the main run. Same amount and same list in 100 shuffled orders.
   4. **(d) A set missing one fact:** the solver stalls and says exactly one more fact must be held, and lists the 16 facts (of 77) any one of which would do. Holding each of the 16 in turn was tried: every one finishes the job with the right levels.
   5. **(e) Loops:** two sums that need each other (a + b = 10, a − b = 2) and a flow-depends-on-depth-depends-on-flow pair are both reported as "cannot be worked out here" in 2 steps; they do not hang. Hold one of the facts and the loop breaks. A parallel pair of pipes (a looped pair of branches) balances when consistent and is flagged with the amount (80 mm) when not.
   6. **One-way sums:** a "lowest incoming level minus 20 mm" rule works forwards (outlet 4.98) and is NOT turned round: hold the outlet and the incoming levels stay unknown, and the solver says two facts must be held.
4. **Time for 200 pits.** 200 pits, 199 pipes, 398 sums, a random branched tree and one straight run of 200, uphill and from the dead ends: median 0.16 ms, slowest 2.1 ms over 200 runs each. About 800 steps. That is roughly 500 times faster than the one-second line. Measured in a console program on the owner's PC; inside AutoCAD it will be the same code.
5. **Things found that the plan did not say (these matter).**
   1. **A bug in my first version** hid the true cause of a conflict (a held fact kept a stale "worked out by" note from an earlier run). Fixed; the test that caught it stays. The lesson for the build: a held fact must carry no worked-out history, and the conflict report needs its own test.
   2. **Whole-number grades are not unique.** Falls round to 10 mm in the mock-ups, so a grade worked out from two inverts can be 1 in 59 where the designer typed 1 in 60. Both give the same fall. The plan must say whether grades are held as typed (and shown as typed) or recomputed. This is a design question for Tim, not a fault.
   3. **The sum a conflict is blamed on depends on where the two routes meet.** The amount (60 mm) and the list of held facts were the same in every order; the name of the sum varied across 4 different sums over 100 orders, all on the same path. The report should say "somewhere along P4 to P1", not name one pipe.
   4. **When several standards could give way, the last one filled absorbs the whole difference.** With top, connection and all grades held and the three drops left to the standard, the first two drops stayed 0.02 and the third became 0.04. Which standard gives way is a choice the plan has not made (nearest the held end, shared out evenly, or ask). I made the solver fill in list order only to prove it can; that rule is not a recommendation.
   5. **Inequality checks (cover, minimum grade, velocity) were not part of the solver**, as designed. The cover figure was computed afterwards as a check.
6. **What it was NOT:** not run inside AutoCAD, not reading real drawing objects, not tested on a loop of real pipes (a ring of pipes where flow depends on depth), no flow or velocity sums. The sums used are the ones in the mock-ups and the pit and pipe window text only.
7. **Evidence:** `C:\CE_WORK\trials\zero\evidence\t11_any_direction_results.txt` (every check, PASS or FAIL, with the figures). Re-run: `dotnet run` in `C:\CE_WORK\trials\zero\t11`.
8. **What it means for the build approach.** "Hold what is fixed, the rest is worked out" is buildable as plain code with no AutoCAD in it, it is far faster than needed, and over-held, under-held and looped sets can each be reported in plain words with the facts and the amount. The foundation block "sum" stands. The three open choices above (grade held as typed, which standard gives way, how to name a conflict on a path) go to the build design.

## Trial 10. Headless predicts full

**Verdict: PASS for scripted MOVE, COPY, MIRROR, ROTATE, ERASE, SCALE, UNDO and REDO on a pit block with joined pipes. Caveats below.** Run Mon 16 Nov 2026 about 21:00 to 21:10, both runs BEFORE the licence incident rules (they used a profile switch, SECURELOAD and the headless isolate option, all now forbidden). They cannot be repeated under the new rules.

1. **What was done.** A small trial plugin (`C:\CE_WORK	rials\zero\core\`, referencing only the core and database files) logs every database event, document command event and two overrules (transform and object) on a pit block, three pipe polylines and a text carrying a hidden note. The same 12-step script (move, copy, mirror, rotate, undo twice, redo, erase, undo, redo, scale) ran in the headless engine (run4) and in full AutoCAD (run5), and the logs were compared.
2. **What was seen.**
   1. **The kinds of events are identical:** all 123 database, command and overrule lines (object appended, modified, erased, unappended, reappended, command start and end, transform, copy-clone) match between the two, step by step.
   2. **The drawing ends up identical** after every step (same positions, rotations, scales and notes). Only the object handles are shifted by one in full AutoCAD.
   3. **The transform overrule fires for MOVE** (and for the copies made by COPY and MIRROR), in both. That answers R-002 B item 7 for MOVE.
   4. **Not identical:** the object overrule's "close" call fires more often in full AutoCAD (83 against 65 over the whole run, for example 15 against 10 in the MOVE step). Counting closes is not a safe test; the plugin must treat them as noise.
   5. **The idle event fired 0 times in both runs.** Anything done at idle was not exercised either way.
   6. **Window and crossing selection finds nothing in the headless engine** ("0 found": no graphics to pick with). Scripted steps must select by the object's own ID. STRETCH (which needs a crossing window) therefore could not be scripted; it is not covered by this trial.
   7. **UNDO inside a script:** my first script's "U" undid nothing because my own marker commands counted as commands; fixed by flagging them no-undo-marker. Anything the plugin registers as a command can eat an undo step unless it says otherwise.
3. **Where the two do not agree or were not tried:** grips, selection by pointing, the ribbon, palettes, idle, the live preview, plotting. These need the full program. Not tried: SAVEAS, WBLOCK, INSERT, EXPLODE, clipboard (those belong to trial 1).
4. **Incident disclosure (what my runs did).**
   1. Run4 (full) used the built-in "unnamed" profile and stopped at an "AutoCAD Message: Customization file load failed. File not found: acad" dialog. I ended that AutoCAD with taskkill. This was a forced close.
   2. I copied Tim's profile key to a new key named ZeroTrial and ran run5 with `/p ZeroTrial`. AutoCAD then made ZeroTrial the **current profile** in the registry. My script noticed and **wrote the current-profile value back to "Tim"** (a registry write). Read now: the value is "Tim".
   3. The script also set SECURELOAD to 0 inside the sessions I ran. I have since read Tim's own profile: its SECURELOAD is 0 (I did not set that; my sessions ran under other profiles).
   4. Run2 headless was stuck at a prompt and I ended it with taskkill.
   5. A copy of AutoCAD's own error-reporting start-up log (it carries a device id) sits in `evidence	10
un5-full\ErrorReports`. It was written by AutoCAD, not by me.
5. **Evidence:** `C:\CE_WORK	rials\zero\evidence	10
un4-headless\events.log`, `run5-full\events.log`, `dialog1.png`, the comparison script `scripts\cmp_logs.py`.
6. **What it means for the build approach.** Events and the transform overrule behave the same headless and full for these commands, so move, copy, mirror, rotate, erase and undo logic can be tested headless and trusted to carry over. Anything involving selection by window, idle, or the screen needs full AutoCAD. Under the new rules the headless engine cannot be used without its isolate option (otherwise it loads Tim's live CE plugin and writes to his live files), so unattended headless runs are BLOCKED until Tim decides.

---

## Trial 1. Joins

**Verdict: PASS for the commands tested (with the exceptions listed). One part (Xref bind) is NOT TESTED.** Run Mon 16 Nov 2026 22:19 to 22:35 in real AutoCAD 2027 under Tim's own profile (his installed CE plugins were loaded in it; I typed no CE command). Every edit was done by a trial command inside the plugin, one step at a time, with a read-back after each; the plugin's own log is the evidence.

1. **Why the first attempt jammed (from my own evidence).** The same COPY, issued from inside the plugin (a plain circle first, then the pit and pipes), ran instantly and correctly, so COPY itself, my plugin and Tim's CE plugins are not the cause. What differed was the first attempt: a 289-line typed script run with SCRIPT, with Tim's COPY mode set to repeat until Enter. I have not proven which of those jammed it, so the cause stays unknown; the method that did not jam is one plugin command per test with a read-back and a check for stray windows before each send. No window or prompt appeared in any of this run apart from the ordinary "Save changes?" question at QUIT (on my made-up drawing). I answered No to it by sending a No press to that one window, and AutoCAD then exited normally, three times.
2. **What was done.** A pit block with three pipe polylines and a text label, all ordinary objects, each carrying a small hidden note. Every pipe was joined to its pit three ways at once: **A**, the pit's handle in the note on the pipe; **B**, a soft pointer in a record inside the pipe's own extension dictionary; **C**, a hard pointer in the same kind of record. Every object's facts were also kept in three homes: the note, a record on the object, and a shelf in the drawing keyed by the object's handle.
3. **What happened to the joins (read back after each command).**
   1. **COPY of pit and pipes together (and MIRROR keeping the originals):** B and C re-pointed correctly to the new pit. **A pointed back at the ORIGINAL pit** (20 drawing units away, or 199 for a mirror): wrong, but detectable.
   2. **COPY of a pipe alone:** all three still point at the original pit, now far from the pipe's end: wrong, detectable.
   3. **COPY of the pit alone:** the copy carries its notes but has no pipes, as expected.
   4. **MIRROR with the originals erased, ROTATE, STRETCH, PASTECLIP, WBLOCK then INSERT then EXPLODE:** all three forms stayed correct. STRETCH needed the pit on screen (a zoom first): off-screen it moved nothing.
   5. **Copy to another drawing the way the clipboard and WBLOCK do it:** all three correct for the whole set. **For the pipes alone, the pit was dragged into the new drawing as an ownerless orphan** (not in model space) and the joins resolved to it. This is Autodesk's own warning about hard pointers (R-002 A item 8). I could not separate soft from hard in this test, so I cannot say the soft pointer is safe from it.
   6. **EXPLODE of a pipe:** the resulting line keeps the note and form A but loses the extension dictionary (so B and C and the record). **EXPLODE of the pit:** the pit goes, every pipe join is reported ERASED (clean break, detectable), and the exploded square has no note.
   7. **BLOCK:** model space emptied into the block; **save and read back in the current format, 2013 and 2000 formats:** every note, record, shelf entry and all three joins intact. **-PURGE of registered applications and AUDIT:** notes survived (the application name was still in use).
   8. **The shelf keyed by handle** survived only where the object itself was not copied. It was lost by COPY, PASTECLIP, WBLOCK/INSERT and the copy to another drawing. **It is not usable** as a home for facts.
4. **Moving the joined pipe ends (the two routes).** The plugin watched for a pit changing and moved the pipe ends at the end of the command (route 1), against doing it from the pit's own close step (route 2).
   1. **Route 1 works with all three join forms.** MOVE of the pit moved the pipe ends with it; ROTATE of the pit turned the ends with it; one typed U put the pit AND all three pipes back together; REDO put them forward together. Erasing the pit left the pipes with their joins reported ERASED; U brought everything back together and REDO erased it again.
   2. **Route 2 FAILS.** AutoCAD refused the edit of the pipes from inside the pit's close step ("object was open for write" and, on undo, "open for undo"), the pipes did not move, with every join form. Autodesk's rule against editing other objects at that moment is real here.
   3. **Undo as ONE step** holds for route 1 for MOVE and ROTATE.
5. **Not done or not proven.** Xref attach and bind (my first attempt reused a block name and tested nothing; not rerun), AutoCAD LT, SCALE, a copy made while the mover is switched on, anything on a drawing with hundreds of pits (trial 4), grip moves (trial 2), what a typed alias or the CE plugins would do to the notes, and whether the first U after a move undoes the move only when other commands run between. Tim's CE plugins were loaded the whole time; I did not isolate them.
6. **Evidence:** `evidence\t1\t1_steps.log` (first full run of every command) and `evidence\t1\t1_steps_run2.log` (undo and redo runs), `evidence\t1\dialog_start.png`, `quit_dialog.png`. Plugin: `C:\CE_WORK\trials\zero\core\`.
7. **What it means for the build approach.**
   1. **Store the join as a soft pointer in the object's own extension dictionary (B)**, with the identity in the small note. It is the only form that stayed right through COPY and MIRROR. A handle in the note (A) goes stale after a copy and must be checked and repaired; a hard pointer (C) risks dragging the pit along as an orphan.
   2. **Do not use the drawing shelf for facts.** Copies lose it.
   3. **Keep the "move the joined ends" step at the end of the command, not in the object's close step.** It gives one undo.
   4. **Plan for self-check on open:** every join read back and reported where it is broken (the erased pit, the copied-alone pipe, the exploded pit) in plain words. The detection worked in every case here.
   5. **A pipe copied alone, or a pit exploded, breaks its join:** the plugin must say so, not repair silently.

---

## Trial 3. No plugin (D-015, D-094)

**Verdict: PASS for the sheet, plot, edit and report-back cases below. AutoCAD LT: NOT TESTED (no LT copy). Tim's live drawing: NOT TESTED (no copy supplied). The test AutoCAD that "had nothing loaded" still had Tim's own CE plugins loaded, only my trial plugin was absent.** Run Mon 16 Nov 2026 22:34 to 22:45.

1. **What was done.** A sheet (a pit block, three pipes, a label, all ordinary objects with hidden notes) was built by the trial plugin, given a position stamp for each thing (kept in the object's own extension dictionary), and saved as `dwg\t3_sheet.dwg`. It was then opened in an AutoCAD where my trial plugin was NOT loaded, plotted to PDF through AutoCAD's own PDF printer, edited with plain AutoCAD commands only (the pit moved 5 right and 3 up, the label changed from P3 to P3A), and saved as `t3_edited.dwg`. Finally the plugin was loaded and asked what had changed.
2. **Looks and plots the same.** The same saved sheet, plotted once with the plugin loaded and once without: the two PDFs render to **identical pixels** (150 dpi, 2482 x 1755), with identical drawing operations and text. The files differ only in bytes that are timestamps. Picture: `evidence\t3\with_plugin_b.png`. (My first comparison showed a size difference; that was a stale-extents effect from plotting in the same session that built the drawing, not the plugin, and I redid it properly.)
3. **Editable with plain commands, nothing to explode.** In the no-plugin session the pit moved (Move on the block) and the label text changed with ordinary AutoCAD calls; nothing was locked, nothing needed exploding. Note: plain AutoCAD moved only the pit; the pipe ends stayed where they were (nothing was watching), so the join was left visibly broken on the drawing.
4. **The plugin reports what changed on return.** Reading the edited file, the plugin compared each thing with its stored position stamp and reported, in order: **pit P3 changed** (was 100,100, now 105,103), **label P3-label changed** (text P3 to P3A), **the three pipes unchanged**. It cannot say the pipes now fail to meet the pit unless it also checks the joins (trial 1 showed that check works), so the report should combine both. Evidence: `evidence\zt_default.log` (T3 lines, copied into `t3\`).
5. **Not tested:** AutoCAD LT; a drawing saved down to an old format and edited in LT; Tim's live drawing P-04; paper-space sheets, viewports, Xrefs and dynamic blocks; the stamp's cost on a big drawing; an outsider who changes something and changes it back (no change reported, correctly).
6. **What it means for the build approach.** "No special object types" holds for looks, plotting and plain editing here. The position stamp works and is cheap, but it must be paired with the join check, because plain AutoCAD can move a pit and leave its pipes behind. The stamp lives in the extension dictionary, which survives save and reopen (trial 1); it is lost when a pipe is exploded, so a stamp can also say "this thing no longer exists".

---

## Trial 4. Speed

**Verdict: PASS for command and mover cost; the part Tim cares most about, how a drag FEELS with the mouse, was NOT measured.** Run Mon 16 Nov 2026 22:39, real AutoCAD 2027, Tim's profile (his CE plugins loaded).

1. **What was done.** A made-up sheet of 500 pits, each with three joined pipes and a label: 2500 objects, every one carrying a note, joins and record (built in 273 ms by the plugin). One pit was moved 7 times with the real MOVE command, timed from inside the plugin, three ways: no overrule at all; my overrule switched on (filtered to objects carrying the note) with no mover; and the mover on (pipe ends follow, route 1 from trial 1).
2. **What was measured (per MOVE of one pit on the 2500-object sheet).**
   1. **No overrule:** median 32.1 ms (slowest 50.6).
   2. **Overrule on, filtered by the note, no mover:** median 32.3 ms (slowest 37.1). The filter costs nothing measurable.
   3. **Mover on:** median 40.4 ms (slowest 53.3): about 8 ms more, to find and move 3 pipe ends by scanning all 2500 objects. The "something changed" event fired 1 time per move without the mover and 4 times with it (the pit and the three pipes).
3. **What this means in drafting terms.** A move of one pit with its three pipes on a 500-pit sheet takes about 40 thousandths of a second including the mover. That is not a speed problem. The mover scans the whole sheet each time; a lookup list of which pipes join which pit would make it independent of sheet size. Not needed yet.
4. **Not measured, and this matters.** (a) A mouse drag with the live ghost image: it needs a person or an input robot, and under the rules I did not drive the mouse. The drag copies the pit repeatedly on screen and the pipe ends are only moved when the command ends, so during the drag the pipes would not follow; whether that looks acceptable is for Tim to judge on a screen. (b) Sheets of 5000 pits. (c) The cost of the preview snapshot (trial 6). (d) The overrule with no filter. (e) The first-open self-check on a large sheet (reading 2500 stamps and joins): not timed.
5. **Evidence:** `evidence\t4_speed.log`. **Build meaning:** neither the overrule nor the mover is a speed risk at this size; the open question is the look of a drag, which needs Tim's eyes or a Codex screen look.

---

## Trial 5. Properties palette

**Verdict: BLOCKED for the real question (does AutoCAD's own Properties palette show the rows). The .NET route itself WORKS at the code level.** Run Mon 16 Nov 2026 22:40 to 22:45.

1. **What was done.** A property provider written in plain C# using AutoCAD 2027's own .NET property list (the "type descriptor" in the database file) was added to the polyline, block reference and base entity classes. It returns a heading "CE Pipe" with two rows only for objects that carry the plugin's note: "CE Material" (editable text) and "CE Fall (m)" (read-only number).
2. **What was seen (code level, real AutoCAD 2027).**
   1. **Adding the provider raised no error** on any of the three classes.
   2. **Asked for an object's property list, AutoCAD's own machinery returned my rows** for the pipe polyline (93 properties in all, ours among them) and the pit block (90), and **none for a plain polyline with no note** (89, ours 0). So the list varies per object, as the design needs.
   3. **Editable row writes back:** setting "CE Material" to HDPE then reading it gave HDPE. (My provider stored it in memory only; writing it into the drawing's own note was not part of this test.)
   4. **My rows came back twice** because I added the provider to both the polyline class and its parent class; adding it once is enough. A detail, not a fault.
3. **Why BLOCKED.** The Properties palette in Tim's AutoCAD is collapsed (zero size) in his profile, and showing it changes a saved interface setting, which the rules forbid. Without it on screen I could not see whether the palette asks my provider for rows. No log line shows the palette asked, which is consistent with it being closed, not with it ignoring us.
4. **What Tim would need to allow, in one line:** let me open the Properties palette in a test AutoCAD (it would be left open or closed again by a normal command, a saved interface setting either way), or open it himself, select the pipe in `dwg\t1_seed.dwg`, and look for a "CE Pipe" heading. The test command is ready and takes one minute.
5. **Quick Properties and roll-over tips: NOT TESTED** (same reason).
6. **Fallbacks, if the palette does not read the list (not built, not decided):** a side palette of our own that follows the selection and shows the same cards (cannot be AutoCAD's own Properties palette); or a small C++ helper for the palette alone (touches the "no hand-built C++" line). Both need Tim's ruling.
7. **Evidence:** `evidence\t5\t5_td.log`. **Build meaning so far:** the plugin can already supply a per-object list of facts in AutoCAD's own property form; whether the Properties palette shows it is the one open fact. The plan must not promise "facts in AutoCAD's own Properties" until that is seen.

---

## Trial 6. Window, live preview and Inspect

**Verdict: PASS for the 1920 x 1080 case (a real 80% window, a live preview of real AutoCAD drawing geometry that redraws in about 21 ms, Inspect hides and returns with the typed value kept). PARTIAL for 2560 x 1440 (preview size simulated, window not shown at that size). Not tested with a person panning and zooming by mouse, and not in the dark theme.** Run Mon 16 Nov 2026 22:44 to 22:52, real AutoCAD 2027, Tim's profile.

1. **What was done.** A window written in plain C# (WPF) opened through AutoCAD's own modal-window call, sized 80% of the screen width and height, with a number box ("Pipe length"), an Inspect button, an OK button and a preview. The preview is a picture taken by AutoCAD's off-screen drawing (an off-screen device and view, a snapshot of it, shown as an ordinary image) of a pit square and a thick pipe line, redrawn every time the number changes. The test changed the number 20 times in a row and timed each redraw, saved a picture of the window, then pressed Inspect.
2. **What was seen at 1920 x 1080 (the real screen of this PC).** The window came out 1536 x 864, exactly 80% by 80%. The preview filled 1152 x 744 of it. **The 20 redraws took a median of 21 ms** (slowest 24 ms). The picture of the window (`evidence\t6\window_1920x1080.png`) shows a blue pit square and the pipe line, crisp, the right way up, with the number box, "20 redraws, median 21.3 ms", Inspect and OK on the right. White drawing background only; matching AutoCAD's theme colours was not attempted.
3. **Inspect.** Pressing Inspect used AutoCAD's supported "start user interaction" call. While it ran, Windows reported the window **not visible** (the window toolkit's own "is visible" flag still said yes, so do not trust that one). While the window was hidden the plugin changed the drawing view (a ZOOM window) with no error. When the call ended the window was **visible again with the typed number unchanged**. This ran once per window; a second Inspect in the same window was not tried.
4. **At 2560 x 1440: simulated only.** This PC's screen is 1920 x 1080, so a real 2560 x 1440 window cannot be shown. I asked for 80% of 2560 x 1440 and the window came out 1536 x 864 (the real screen's limit), while the preview was rendered at the larger size, 1664 x 1032: **median 39 ms** (slowest 48 ms). So the cost grows with picture size (about 21 ms for 1152 x 744, 39 ms for 1664 x 1032), still well inside a typing pace, but the larger window itself was not seen.
5. **Not tested.** (a) A person panning, zooming and window-picking while the window is hidden: I changed the view by command only, not by mouse, so "the drawing can be panned and zoomed" is shown only for command-driven view changes. (b) Dark theme and following AutoCAD's colours. (c) Preview of the real pit block and its dynamic properties (I drew plain polylines as drawables, not a block copy in a scratch drawing as the September note proved). (d) Typed key presses queueing: the 20 changes were made by code, not typed. (e) AutoCAD's other screens (laptop and desktop pair).
6. **Evidence:** `evidence\t6\t6_run2.log`, `window_1920x1080.png`, `window_2560x1440.png`. Code: `core\Win.cs`.
7. **What it means for the build approach.** The preview can be a real AutoCAD picture of real objects, redrawn in tens of milliseconds, with no second drawing path. Inspect by the supported call works and keeps the typed values. The remaining unknown is the user's own mouse pan and zoom during Inspect; it needs a person or a screen driver.

---

## What must change in the build approach

*(to be completed when the trials are done; so far nothing has had to change from trial 11)*

## What was not tested and why

*(to be completed when the trials are done)*
