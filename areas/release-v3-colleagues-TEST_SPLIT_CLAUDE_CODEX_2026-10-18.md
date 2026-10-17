# Test split: what Claude tests, what Codex must look at (Sun 18 Oct 2026)

Written by a read-only planner on the Max account for the desk (plan/03). Nothing was built, run, installed or opened in AutoCAD. Tim's ruling of 18 Oct: Claude tests everything except the parts that need eyes and a mouse; Codex (weekly allowance resets Thu 22 Oct 17:13, model gpt-6.1-sol, drives AutoCAD by screen and mouse) is used only for those.

## ANSWER FIRST

1. **Claude can take about 91 percent of the 762 cases, but only 37 percent today.** Today (typed commands only): 284 of 762 (37 percent). Once driver v2 is proved: 572 (75 percent). If the driver is also allowed to save and reopen its own test copy: 692 (91 percent).
2. **Codex needs only 62 cases (8 percent), and those collapse into about 14 things to look at** (section 4). Another 8 cases (1 percent) need real office data or a second machine (Tim or later).
3. **The save-and-reopen group is the swing.** 120 cases (16 percent) are not eyes or mouse at all. They are blocked because the driver refuses QSAVE, CLOSE and OPEN. Recommend one narrow "save an owned test copy, close it, reopen it" verb (decision 2 in section 8). Without it those 120 either go to Codex or stay untested.
4. **Of the 139 cases Codex found failing, Claude can retest 110 (79 percent), Codex 26, and 3 need office data.** The retest of fixed bugs is mostly robot work.
5. **The W60 to W80 verify briefs (160 checks): Claude takes 128, Codex 24, office data 8.** Nine of the 21 briefs have no eyes-and-mouse check at all and should go to the robot. W60 to W65 already ran on 12 and 13 Oct on older builds and mostly ended BLOCKED or NOT TESTED, so do not re-run them as they stand.
6. **Codex budget for the week of 22 Oct (95 percent stop line, 7 percent per run):** 13 runs is the ceiling. Plan 7 test runs (5 eyes-and-mouse runs, 2 re-look runs after the next fix trains), about 20 percent for building the Preview-then-Apply windows and Settings rows, and about 21 percent held back. Detail in section 6.
7. **Nothing here is tested.** The lane for each case is my reading of its scope line, not a trial. v2 has no report yet and is not Opus-reviewed. Everything marked "pending v2 proof" stays with Codex until the v2 self-test passes.

## 1. The lanes and the counts (762 cases from the Codex index)

1. **T1, typed commands only (Claude robot today): 284 (37.3 percent).** Placing with typed points, U then 12 seconds then REDO, reading system variables and entity data, hashing the three settings files, command-line wording. Runs 22 to 25 already do exactly this.
2. **T2, needs a CE window button or field, a cancel, a pick by handle, or a settings switch (Claude with driver v2): 288 (37.8 percent), all "pending v2 proof".** It splits into:
   1. **Cancel at a prompt the driver started: 114** (Escape cases; the old driver could not even cancel CDFW, run 22).
   2. **Pick an existing object by handle so a command runs without a mouse pick: 29.**
   3. **Press buttons and fill fields in an allow-listed CE window: 140** (calculator, rainfall, report intake, profile review, checklist, section and RC windows, hatch library, Pit Schedule, Edit Pit, Edit Pipe).
   4. **Switch a setting ON and restore it, or type into a modal: 5.**
3. **T2S, save, close and reopen (needs one more driver ruling than v2): 120 (15.7 percent).** Not eyes or mouse. The driver's deny list holds QSAVE, SAVE, SAVEAS, CLOSE and OPEN, and the allow-list refuses buttons named Save.
4. **T3, eyes and/or mouse (Codex): 62 (8.1 percent).** 26 of them are cases that currently FAIL.
5. **T4, real office data or a second machine (Tim or later): 8 (1.0 percent).** Real Blue Factor report PDFs (RI-02, RI-04, RF-02, RI-09, CR-06), an external-source drawing check (DC-06), older-runtime comparison (CO-06) and older-runtime checklist (CK-09). The big T4 work is not in the index at all: AutoCAD 2022 to 2026, a colleague's PC, plotting.
6. **Outcome mix per lane (PASS / FAIL / UNPROVEN / BLOCKED).** T1 236/45/3/0. T2 227/52/8/5. T2S 104/13/3/0. T3 25/26/7/0. T4 0/3/3/2.
7. **Cheap proof the T1 lane is real:** runs 22 to 25 did U, wait, REDO on Civil and Structural circles, MOVE, CDFW, CDAGI, 25C and AD with no mouse, and caught two new faults (BUG-697, BUG-698) that Codex never saw.

## 2. By feature family (762 cases)

1. **Civil calculations (rainfall, CDCALC, exports, catchment rows, report intake): 102.** T1 0, T2 75, T2S 12, T3 10, T4 5. The T3 are window fit, the PDF pages and the Excel view, and the four Export buttons (the allow-list never presses Export).
2. **Civil catchment overlay, curves, overload, strip drain, AG drain: 44.** T1 21, T2 13, T2S 7, T3 3, T4 0. T3: which pit owns which area, blue-on-blue label, strip drain preview.
3. **Civil levels, spot level, suggest fall, linked fall: 50.** T1 32, T2 12, T2S 4, T3 2, T4 0.
4. **Civil long section, LandXML, drawing check, comparison: 49.** T1 7, T2 30, T2S 6, T3 4, T4 2. T3: title overlap, stale 1:100 block, tiny row text.
5. **Civil pit, pipe, schedule, flat pipe: 60.** T1 41, T2 4, T2S 12, T3 3, T4 0. T3: remarks over the schedule divider, Excel clipping, CDS pages fit.
6. **Civil sources and floor wastes (DP, IO, CDSOURCE, CDFW, connected move): 49.** T1 20, T2 15, T2S 11, T3 3, T4 0. T3: overlap preview, ghost, green preview.
7. **Hatch and Xref tools (library, CH and aliases, gap, audit, XRL, Xref copy): 67.** T1 29, T2 21, T2S 9, T3 8, T4 0. T3: library pictures, and the "no preview before it commits" fails (BUG-615, 616).
8. **Manager and move/rotate: 20.** T1 2, T2 12, T2S 2, T3 4, T4 0. T3: status cards overlap, Light theme header, theme preview.
9. **Structural columns, beams, footings, settings: 41.** T1 18, T2 13, T2S 8, T3 2, T4 0.
10. **Structural dimensions, leaders, text, marks, revision cloud, levels, break line, section marks: 146.** T1 64, T2 45, T2S 25, T3 12, T4 0.
11. **Structural sections, RC, checklist: 62.** T1 0, T2 37, T2S 15, T3 9, T4 1. Window-heavy, so almost all T2; T3 is pictures and the palette splitter.
12. **Structural wind, bracing, roof, floor, purlin, rafter, level: 72.** T1 50, T2 11, T2S 9, T3 2, T4 0.

## 3. The W60 to W80 verify briefs (21 briefs, 160 checks)

Classified from the briefs' index and Tim's tick-list descriptions, not from the full brief text. Counts are T1 / T2 / T3 / T4.

1. **W60 (8): 0 / 2 / 6 / 0.** What's New size and colour, ribbon pictures, three hover tooltips, closing AutoCAD with the Save choice.
2. **W61 (8): 1 / 4 / 2 / 1.** Three editor windows look like New Pipe, double-click on an IL text; the consultant re-import needs real data.
3. **W62 (8): 0 / 6 / 2 / 0.** Grip drags (BUG-244, BUG-160).
4. **W63 (8): 0 / 7 / 1 / 0.** Grip a label or arrow and drag (BUG-093).
5. **W64 (8): 0 / 8 / 0 / 0.** All robot.
6. **W65 (8): 1 / 6 / 1 / 0.** Click the drawing tab X and choose Cancel (BUG-257).
7. **W66 (8): 1 / 6 / 1 / 0.** Double-click a placed schedule cell (BUG-396).
8. **W67 (8): 1 / 7 / 0 / 0.** All robot (metre fixtures to be made; the PDF text can be read as text).
9. **W68 (7): 2 / 3 / 2 / 0.** CDFALL "1:80" alignment, metre overlay label size.
10. **W69 (7): 0 / 2 / 0 / 5.** The five import checks need the real X-Civil import package (client data, local only).
11. **W70 (8): 3 / 5 / 0 / 0.** All robot.
12. **W71 (8): 0 / 7 / 0 / 1.** Metre drawings (robot makes the fixtures); the old-build metre file is T4.
13. **W72 (8): 4 / 4 / 0 / 0.** All robot. The roof and floor setout prompts need their switch ON (settings guard).
14. **W73 (8): 0 / 8 / 0 / 0.** All robot.
15. **W74 (8): 2 / 4 / 2 / 0.** Annotate flyouts fit and scroll, rebar grip drag.
16. **W75 (8): 1 / 6 / 1 / 0.** Pad grip 600 to 900 (BUG-335).
17. **W76 (8): 1 / 6 / 1 / 0.** SAVEAS a copy (BUG-276).
18. **W77 (5): 1 / 4 / 0 / 0.** All robot.
19. **W78 (5): 2 / 2 / 1 / 0.** Block with attribute tags moving live under the cursor (BUG-188).
20. **W79 (8): 1 / 3 / 4 / 0.** Pipe tab comes to the front on a click, grip stretch, Save As then X, closing with X.
21. **W80 (8): 1 / 6 / 0 / 1.** All robot. BUG-256 (U then REDO) has now passed in runs 9, 13, 22, 23 and 24.
22. **Totals: T1 22, T2 106, T3 24, T4 8 (= 160).** Claude 128 (80 percent), Codex 24 (15 percent), office data 8 (5 percent).
23. **Where W60 to W65 ended (read from the Codex reports, 12 and 13 Oct, builds 3.0.47 to 3.0.49):** of about 50 result lines roughly 10 PASS, 4 FAIL, 7 DIFFERENT, 12 NOT TESTED and 19 BLOCKED. Typical causes: opened the wrong copy, a window that "One-attempt rule" would not retry, "Use level direction" not found. Mouse-only Codex is the weakest tool for multi-step workflows; give it single looks.

## 4. What Codex must look at (T3), ordered by value

Value = the chance a wrong picture reaches a council sheet, then how many cases it settles. Each line is one look; none needs a long workflow. All need the fix to be installed first, except the pure mouse items.

1. **Pit Schedule remarks.** After Update, and after reopen, a custom note does not run over the P1/P2 divider or the bottom row (BUG-587; case SCHED-LAYOUT-08).
2. **Long section sheet (CDPROFILE).** The wrapped title clears the table and the scale (BUG-600); after changing the horizontal scale the block redraws at the new scale without a REGEN (BUG-601; PF-20, PF-21); the tiny row and level text is readable at plot scale (PF-12).
3. **Calculation sheet as a reader sees it.** Open the PDF: every page carries DRAFT and the job name, nothing clipped, no blank lead page (BUG-590). Open the Excel at 100 percent: headers not clipped, numbers are numbers, no green text markers (BUG-571, 591). Also press the four Export buttons, which the robot is not allowed to press.
4. **Catchment overlay.** You can tell where P1's area ends and P2's begins (BUG-641); blue text on blue fill, and the label over pit and pipe text, are readable (BUG-642; CT-03, CO-03).
5. **Section marks.** The letter inside the bubble is visible against the filled half in a dark model view (BUG-632; the new layout now ships OFF, so the switch must be ON for this look).
6. **Footing labels.** The PF label is readable at the prepared view scale (BUG-454: 2.5 mm plot height times the annotation scale).
7. **Hatch, break line and dimension text at 1:20, 1:50 and 1:100.** Plot size looks right at each scale, including the dense DOTS hatch (BUG-614, 628; CAH-06).
8. **Preview-then-Apply windows, once Codex has built them.** Before Apply, the drawing highlights what will change: hatch scale/angle/origin (BUG-615), XRL layers (616), levels LMU and FFL (625, 626), section marks (630), dimension scope (634, 636), R2LTXT (645). One look per window.
9. **Cursor previews while the mouse moves.** DP/IO red overlap preview and the full ghost (SP-04, SP-07), the green floor-waste preview (FC-08), the MLR preview text (ML-04), the whole strip-drain preview (SD-01), dimension live previews.
10. **Windows at the real screen size.** Manager status cards do not overlap at default and maximised (BUG-221); Light theme header text visible (BUG-580) and the theme previews at once (EM-06); six CDS pages; 23 Structural Settings pages; Rainfall; the Charged tab; SBEAM; RCBEAM, RCRECTCOL, RCCIRCCOL.
11. **Pictures in windows.** RC beam and ligature thumbnails, hatch library cards and the magenta waffle preview, the SBEAM preview with the inner flange lines hidden, eight bar symbols on the circular column.
12. **Double-click.** In AutoCAD, double-click a pit label, a pipe, an IL text and a block: the CE Edit window opens (the new double-click switch ON); a Q leader note opens a text editor with its content, not blank (BUG-623); double-click a placed schedule cell and rename P5 to C2 (BUG-396).
13. **Grips and drags.** Drag a pipe end, a pipe label and a flow arrow (BUG-244, 093, 160, 208); grip a pad 600 to 900 (BUG-335); rebar grip shows live length (BUG-277); grip-Ctrl copy of a pipe (BUG-665); the block with attribute tags moves live under the cursor (BUG-188); drag the checklist palette splitter (CK-03).
14. **Ribbon, tooltips and AutoCAD's own dialogs.** Ribbon pictures aligned (BUG-172); hover tooltips for CDDISCIPLINE, Settings and CDDIAG (226, 227, 228); clicking a pipe brings the Pipe tab forward (BUG-180); Spot Level button starts CDSL (RIBBON01); What's New big enough and readable (BUG-170); Annotate flyouts fit and scroll (BUG-264); tab X then Cancel (BUG-257); close AutoCAD with unsaved changes and choose Save (BUG-231, 164, 224).

Optional trims for the desk: the Claude robot can take a window screenshot with v2 `shot` and read it as a cheap pre-look on items 10 and 11. That is Claude-seen only, never accepted; only a Codex look counts under RULES 4.5.

## 5. New fixes from this week and their lanes

**Civil C-41 (installed 3.0.52): the three ON-switch tools, all ship OFF**

1. **Tidy labels (CDTIDYLABELS).** Switching it on and its questions: T2 (settings guard, pending v2). Labels end in the right places and none on top of each other: T2 by reading entity positions. "It looks tidy": one Codex look (T3, add to item 7 of the Codex run).
2. **Checks list (CDCHECKS palette, CDHUB and CDCHECKCURRENT routing, pointer line).** Routing and palette rows: T2 (the allow-list already holds a Checks window and its Show where and Check again buttons). The Show where view change and glow: one Codex look (T3).
3. **Double-click opens the Edit window (new switch).** Reading the switch and the list of watched commands: T1. The real mouse double-click: T3 (item 12).
4. **Why none can be proved today.** Run 24 saw all three OFF on Tim's real settings; run 26 tried an isolated settings profile and failed at launch ("Customization file load failed"). The v2 settings guard (change a setting, restore the original) replaces that route: T2, pending v2 proof.

**Civil C-42 (installed 3.0.53): 21 Hunt Civil E fixes, BUG-652 to BUG-696**

1. **Robot-proved already (run 25):** the erased pit label (BUG-667) and 8 more. Nine PASS, no fixed bug still failing.
2. **Two new faults the robot found:** CD "Existing line" refuses every plain polyline (BUG-697, which also hides the BUG-684 retest) and CDSYNC sets 30 pipe sizes to 100 (BUG-698). Both are T1/T2 retests once fixed.
3. **T2 (pending v2, about 15 fixes blocked behind window buttons in run 25):** Recalculate downstream and CDPROPAGATE (652 to 658, the Cascade Preview Apply button is allow-listed), quiet relink direction (659), Edit Pit Save and detention tank rotation (561), copies by ROTATE and SCALE (665, 666, 670 to 672), CDEDIT multi-resize and rotate (674, 679), CD writes before it asks (681 to 683), rotated pit fit (675, 678), lid wording (676), design-flow-only change (687), batch design grade (688, 689), breakline schedule level (694).
4. **T3 (one look each):** grip-Ctrl copy (665, mouse), pipe callout position after MOVE or ROTATE of a run (668), detention tank grated side near 180 degrees (561).
5. **Needs Tim:** BUG-685 stays on hold (a typed 10.125 versus the two-decimal rule).

**Structural S-38 (installed 1.0.118; from the S-38 finalizer report)**

1. **Dimension style, layer and lineweight restored after AD, LD, Q, QD, RD and 25C (BUG-621, 646):** completed routes T1 (run 23 PASS); the Escape routes T2 (cancel at a prompt).
2. **DSET, DSET1 and DUP redraw the number (BUG-635):** data check T2; one Codex look that the drawing shows 1000 and not 5000 (item 7).
3. **Hatch and break line at any scale (BUG-614, 628):** values T1; plot-size look T3 (item 7).
4. **Section mark layout (BUG-632):** now ships OFF. Switch ON T2; the look is item 5.
5. **F keeps the typed note, Esc after F adds nothing, the preview redraws after F (#1304; BUG-622, 644):** typed part T2; preview redraw is a cursor-preview look (item 9). The "Dim scale linear" line (#1300) is read in AutoCAD's own Properties palette, so it is T3.
6. **Locked-layer stop-up-front for ABS, Xref normalise, DSET1, DUP (BUG-583, 617, 636, 638):** lock the layer through a typed command and read the refusal: T2.
7. **FASTSAVE now only saves:** a save, so T2S.

## 6. Codex budget plan, week of 22 Oct

Facts used: allowance resets Thu 22 Oct 17:13; stop line 95 percent; planning cost 7 percent per test run (the desk's figure). The log shows far less for the small W runs: queue.log (last entry 13 Oct) has W60 to W65 at 0 to 1 point each (for example 24 to 25 percent for W65), and the six bj builds 12 points in all. Longer eyes-and-mouse runs with many screenshots will cost more than a W run, so plan on 7.

1. **Ceiling:** 95 divided by 7 is about 13 runs. Do not plan to the ceiling.
2. **Plan to 90 percent, in this order (T3 first):**
   1. **Run E1, "paper output" (7 percent):** items 1 to 4 and 6 of section 4. Needs a build with the BUG-587, 600, 601, 590, 591, 641, 642, 454 fixes installed, so it is the first run after the next Civil and Structural install.
   2. **Run E2, "mouse" (7 percent):** items 12 to 14. These need no fix and no switch except the double-click one. This can run first, on Thu 22 Oct after 17:30, on the installed 3.0.53 and 1.0.118 builds.
   3. **Run E3, "windows and ribbon look" (7 percent):** items 10, 11 and the Tidy labels and Checks look from section 5. Includes the ON-switch looks once the robot has staged the switches.
   4. **Run E4, "previews" (7 percent):** items 8 and 9. Waits for the Preview-then-Apply windows.
   5. **Run E5, "dark view and scales" (7 percent):** items 5 and 7 (needs the section mark switch ON).
   6. **Runs E6 and E7, re-looks (14 percent):** after the next Civil and Structural fix trains, re-look only at the T3 items that failed or were not yet fixed.
   7. **Window building (about 20 percent):** the Preview-then-Apply windows and the Settings rows. The six bj briefs last week cost 12 points in total; eight windows plus rows will cost more, so allow 20.
   8. **Held back (about 21 percent, to reach 90):** two flex runs of 7 percent each for Q4 look passes, and 7 percent slack.
3. **Count:** 7 planned test runs, 2 flex runs, 9 in all of the 13 possible. If the real cost turns out near the 1 to 2 points seen for W60 to W65, the same plan costs about 15 to 20 percent and the spare goes to re-looks.
4. **Timing:** AutoCAD is free for Codex after 5:30 pm weekdays, 2:00 to 3:00 pm, before 8:30 am and weekends. Run E2 can start Thu 22 Oct from 17:30.
5. **Suggested way of working (not proved):** Claude stages the scene (opens the copy, runs the command up to the point to look at, releases the lock) and Codex only looks and records. That should cut Codex cost and the BLOCKED rate seen in W60 to W65.

## 7. Which W briefs to shrink or drop

1. **Drop, hand to the Claude robot (no eyes-and-mouse check):** W64, W67, W70, W71, W72, W73, W77, W80. W69 follows once the import package exists (its five import checks are Tim-or-later). W71 and W67 need the metre fixtures made first; `FIXTURES_TODO_ROBOT.md` already lists them.
2. **Already run, do not run again as they stand:** W60 to W65 (builds 3.0.47 to 3.0.49 are not what is installed now). Re-test only the checks that did not PASS, in the right lane.
3. **Shrink to their T3 part only, then merge into Codex runs E1 to E3:** W60 (6 of 8), W61 (2), W62 (2), W63 (1), W65 (1), W66 (1), W68 (2), W74 (2), W75 (1), W76 (1), W78 (1), W79 (4).
4. **W79 and W80 ("robot already saw PASS") collapse:** W80 goes entirely to Claude; W79 keeps four checks (BUG-180, 208, 224, 164), all in run E2.
5. **bj26 to bj31 are finished builds; no change.**

## 8. What the desk needs to decide or do

1. **Driver v2 self-test:** nothing in section 1 counts as Claude's until the v2 self-test passes. No v2 report exists yet (`DRIVER_V2_REPORT` is missing) and the v2 file is not Opus-reviewed. `launch -Env` still fails at start (run 26), and `CE_STRUC_SUITE_APPDATA_ROOT` is still refused.
2. **Decision for Tim (answer by number):** should the driver get one narrow save-and-reopen verb for its own test copies, hash-checked? Recommend yes: it moves 120 cases (16 percent) from "nobody" to Claude, and the copy is already disposable.
3. **Decision for Tim:** for Q4 ("a tool turns ON by default once Codex has passed it"), does a robot PASS with the switch ON plus one Codex look at the visible part count? Recommend yes. Otherwise every ON switch is a full Codex run.
4. **Allow-list requests for the tooling worker:** let `ui press` press Export on the calculation window for test copies only (4 cases and BUG-158), a Pit Schedule export, and the Cancel on AutoCAD's own "Customization file" message so a direct start recovers.
5. **LISP staging rule:** runs 23, 24 and 25 each asked for a ruling on using `(setvar ...)` and `(handent ...)` through `-AllowLisp` to stage a test. Still unruled. If the answer is no, the 29 pick-by-handle cases and some T1 setup become T2-only.
6. **T4 work not in the index:** AutoCAD 2022 to 2026, a colleague's PC, plotting and real client reports stay with Tim or later.

## 9. What I did not do

1. **I did not try any case.** Lanes come from each case's scope line and key. Expect the counts to move by roughly 5 percent either way once someone runs them.
2. **I read the index, the briefs' index, the triage, runs 22 to 26, the Codex reports W60 to W65, the tick-list, the Q4 flip list, the C-41, C-42 and S-38 finalizer reports and the v2 driver header and allow-list.** I did not read the 21 full briefs, the 70 ledger files beyond the index, or the v2 self-test (none exists).
3. **Cost figures are from queue.log up to 13 Oct.** W66 to W80 never ran, and I have no cost for runs after that.
4. **The 24 UNPROVEN cases** were placed by what they say is missing, which is a guess in some.
5. **Built, tested, installed, accepted:** all of the above is a plan. Nothing is built, tested or accepted by it.
