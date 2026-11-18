# The loop queue (what the planning chat does at each timed wake-up)

**Why this file exists.** Tim, 17 Nov 2026 night: "you cant create loops to keep things moving in a positive direction between everything on our plans". The planning chat is woken on a timer. At each wake-up it reads this file, does the FIRST item that is not done and not blocked, ticks it, updates `DIRECTOR_SUMMARY.md`, commits by file name and pushes. One item per wake-up. If nothing can move, it says so in one line and stops.

## Limits at every wake-up (never loosened by the loop)

1. Nothing starts AutoCAD. No trials. Rule 1.9 stands in full.
2. Nothing is installed; nothing on Tim's PC changes outside `C:\CE_PLAN\zero`, `C:\CE_CIVIL` (build chat only) and scratch under `C:\CE_WORK`.
3. No new scope: only work Tim has already said yes to. A new kind of work goes on the "Waiting on Tim" list, not into the queue.
4. Anything that is Tim's call: the recommended answer, marked DRAFT, listed for him. Never guessed silently.
5. No client names, job addresses or job numbers anywhere.
6. If a side chat is idle with work left, message it to carry on. If it is stuck on the same thing twice, stop it and write down why.
7. Keep usage light: one helper at a time, Sonnet builds, Opus reviews.

## Queue

1. [x] Build chat saves its five clean-ups and clears its DRAFT list (check `C:\CE_CIVIL` git log and BUILD_LOG.md). If idle and not done, nudge it.
2. [x] (done 18 Nov 02:25 on the third try: all seven windows driven by real clicks, 635 of 646 steps; wrong figures found, see DIRECTOR_SUMMARY section 5) The planning chat tries all seven bench windows itself by real clicks and typing (Tim: "can you try them all first and then tell me how to try"). Write what was found, window by window: works / odd / broken.
3. [x] (done 18 Nov 06:30: two rounds of faults fixed; third independent run found no wrong figure) Send every fault found to the build chat as one list; it fixes with a separate review; re-try the fixed windows.
4. [x] (final 18 Nov 06:30, sent to Tim) Write the "try the windows" pack for Tim: one double-click, a ten-minute list, what to look for (`stage6\TRY_THE_WINDOWS.md`), and send it to him.
5. [x] (18 Nov 06:35) Refresh `DIRECTOR_SUMMARY.md` and `STATE.md` so the morning answer is ready.
6. [x] (18 Nov: junction pit sourced from an approval letter, enter; step irons 0.9 not sourced well enough, left blank; build chat told) Check the reference files for a council document behind the two council figures of D-148; tell the build chat the result.

## Waiting on Tim (the loop does not start these)

1. Step 16: his verdict on the windows.
2. Whether the build chat may start the AutoCAD part (the foundation inside AutoCAD, then the Pit tool) as written code that is compiled but NOT run in AutoCAD.
3. Slab thicknesses; detention blue on a real plot; AS 3500.3 underside-of-pavement check; first-trial leftovers.
4. The grip crash and the double-click overlap: any more AutoCAD trials need his yes for that day.

## Added 18 Nov 2026 after D-158 to D-160 (Tim: start the AutoCAD part; AutoCAD on test copies every night in his hours; a robot may close a TEST AutoCAD it started)

The limit "Nothing starts AutoCAD. No trials." above now reads: AutoCAD may be started ONLY on test copies, ONLY inside Tim's hours (5:30 pm to 8:30 am weekdays, all weekend), ONLY when none of Tim's own AutoCAD windows is open, by the normal double-click route. Rule 1.9 in full, with its one exception (D-160).

7. [x] (18 Nov: 24 of 25 in real AutoCAD; explode-from-code gap open) Build chat: the AutoCAD foundation (hidden note on ordinary objects, join as a soft pointer on the object, position stamp, self-check on open, the no-plugin proof), built and reviewed, then tested in AutoCAD on a test copy at night. Follow the method and findings in `stage4\TRIAL_RESULTS.md`.
8. [~] (18 Nov 08:30: built and reviewed on the pretend drawing; first AutoCAD run tonight) Build chat: the Pit tool in AutoCAD (typed command PIT / PT, the window, draws ordinary objects), through the tool loop and the night loop in `stage6\LOOPS.md`.
9. [ ] Build chat: the Pipe tool in AutoCAD (PIPE / CD), same loops. Ordinary AutoCAD grips only until the grip crash of 17 Nov is understood.
10. [ ] After each of 7 to 9: refresh `DIRECTOR_SUMMARY.md`. When Pit and Pipe both pass the night loop, tell Tim there is something he can try in AutoCAD and ask his yes to load it.

## Added 18 Nov 2026 afternoon (after Tim's rulings D-162 to D-196)

Items 8 and 9 above are built on the pretend drawing (Pit, Pipe) and so is the Long section tool; none has run in AutoCAD. The queue from here, build chat unless said:
11. [ ] The eight gaps from `design\SITUATIONS.md` (join later; a real outlet; end kinds; ends follow the pit wall; a pit in a blank drawing; grey for not known; following and labels that move with the pit; the standards a drawing was designed with) and bends on every pipe (D-189). Before any new tool.
12. [ ] Speed timing in the night run (D-165), then tonight's first AutoCAD run of Pit and Pipe after 5:30 pm with no acad running: CETEST, CEPIT1 to 6, CEPIPE1 to 6. Planning chat: read the result, update the director's summary, tell Tim in the morning.
13. [ ] Window work on the bench: the rose scheme (D-168), the new preview (D-167), the Schedule Columns card and scale out (D-169), LONGSECTION / LG (D-196), TANK / WT (D-170), tabs on small screens (D-193). Then a separate UI critic, then the independent tester re-tries all seven by real clicks at night.
14. [ ] Typing cuts 1 to 3 of `design\INPUT_AUDIT.md` (defaults fill themselves; one fact in one place; head, orifice and pit size worked out). Cuts 4 and 5 wait for Tim's answers.
15. [ ] Planning chat: put the build chat's collected DRAFT calls (Pit, Pipe, Long section) to Tim as clickable batches, each with context and a real-job example, once item 11 has settled which are still live.
16. [ ] Planning chat: bring back, one at a time on a part-drawn job, how the top water level is first chosen; whether the orifice pit is always the last pit; tank re-use against detention.
17. [ ] Then the Inlets tool (after `SITUATIONS.md` has been read against it), Tank, Detention, Schedule.

## Standing job at EVERY wake-up, before the queue (added 18 Nov 2026, D-226, R-71)

Tim: "in future i dont want to be the one managing anything apart from what is in chat". So at every wake-up, first: (1) read `BOARD.md`; (2) add anything new from Tim's answers and the side chats' reports since the last wake-up, with the next ID in its list; (3) move answered items to "closed this week" with the decision number; (4) if something waiting on Tim blocks building and has not been put to him today, put it to him as one clickable question with context and a real example; (5) once a night run the checks in `BOARD_HOW_IT_IS_KEPT.md` and fix what fails before new work; (6) commit by file name and push. Then the queue.

## Added 18 Nov 2026, 5:20 pm (after D-246 to D-294)

Done since the list above: item 15 (the build chat's draft calls: 104 of 104 closed, D-258 to D-293); from item 16, tank re-use against detention (D-278). Items 11 to 14 and 17 stay with the build chat in its own order, AFTER its fix-first list.

18. [~] The ONE mock-up for Tim's look (screen rules D-286, his changes D-294): `pictures\detention_fixed_mockup.html` version 4, with the separate checker; then to Tim. Nothing is restyled until he says yes.
19. [ ] Build chat, fix first (screen rule 3): the wrong-figure and pretend-to-work list N-039 to N-056, each confirmed, then fixed with a fail-first test. Planning chat: read each report, update the board.
20. [ ] Tonight after 5:30 pm, no acad running, PC idle: build chat's pass with round 39; trials chat's grip tests (hover menu, drag with one undo, Ctrl-copy, many grips, locked layer) and the second double-click fix. Planning chat in the morning: results in the director's summary.
21. [x] (done 18 Nov 5:30 pm: `design\STYLE_APPROVED_18NOV.md`, sent to the build and interview chats; the preview part is open, D-297) Planning chat, once Tim approves the style: write the shared-parts brief (card, field, pill, button, status band, preview panel, three-step layout; inputs boxed, worked-out plain; one-line why) from the approved mock-up into `design\UI_PLAN.md`, send to the build and interview chats.
22. [x] (done 18 Nov evening: to D-297, reviewed by a second reader, 23 fixes applied; the board's record check still to re-run) Planning chat: bring `rulings\` up to D-294 (they stop at D-229) and re-run the board's record check (section 10).
23. [x] (pipe label picture sent 18 Nov; kerb and existing-pit symbols looked up 18 Nov 6:50 pm: none exist in the blocks review, board item 77, a question for Tim) Planning chat: owed pictures: a shorter pipe label for tight spaces (D-268); what the Blocks palette holds for a kerb symbol and an existing-pit look (D-275).
24. [ ] Planning chat: still to put to Tim one at a time on a part-drawn job: what a new pipe opens with is settled (D-263); side panel against Job window (D-048 against D-099, D-171); how the top water level is first chosen; whether the orifice pit is always the last pit.
25. [ ] Housekeeping: compact the memory index file (it is near its size limit); correct board times written from memory.
