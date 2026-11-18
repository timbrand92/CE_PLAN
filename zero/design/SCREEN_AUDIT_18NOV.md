# Screen audit against Tim's 31 rules (18 Nov 2026)

**Status:** Step 1 of `SCREEN_RULES_18NOV.md`: change nothing, list every screen in groups, mark each group meets / fails / not checked. Done by a separate checker (not the chat that built the screens), from still pictures and the page code only. Nothing was changed, built or run.

**What was looked at:** the seven bench windows in `C:\CE_CIVIL\bench\shots\` (plain 1080 dark, 1080 light and 1440 dark for each, plus two to six state pictures each) and the two web pages `whole_plugin_few_tools.html` and `final_program_artifact.html` (code read in full, plus photographs in `C:\CE_WORK\scratch\zero_see\shots\`).

## 1. Headline

1. **Groups that meet the rules: 0 of 8.** Every group fails at least 15 of the 28 rules that can be marked (rules 4 to 31).
2. **All marks (8 groups x 28 rules = 224 marks): 37 meet, 127 fail, 60 not checked.**
3. **Not checked means a still picture cannot show it:** motion, undo, tap and click budgets, phone sizes for windows that live inside AutoCAD, and charts on windows that have no chart.
4. **Correction to one of the facts given to me.** The rose pink accent (#FF70B3) is **not** in the seven bench windows. They use a blue-grey ground with a mid-blue accent (OK button, toggles, every tick box, and the pit or pipe drawn in the preview). The rose is only in the two web pages, where it is on almost everything. Both schemes break rule 15, in different ways.
5. **What is getting to Tim, in one line:** every window has two bright things fighting for the eye (the big green and yellow drawing text in the preview, and three or four equal-sized white numbers), colour is spread across six jobs (status, changed, selected, drawing layers, areas, buttons), and the layout behaves two different ways when the window is made bigger.

## 2. Each group, rule by rule

### Group 1: Pit window (bench_pit_*)

Pictures seen: bench_pit_1080_dark, _1080_light, _1440_dark, _B4, _cover_650, _step_irons, _size_refused.

1. **Rule 4 (calm, one design language): FAILS.** At 1440 the four cards stop growing and leave a large empty block bottom right while the preview balloons (bench_pit_1440_dark). Pipe and Long section do the opposite (cards float centred), so the same frame resizes two ways.
2. **Rule 5 (one colour scheme inside AutoCAD): FAILS.** A dark and a light version both exist (bench_pit_1080_dark, bench_pit_1080_light).
3. **Rule 6 (every size): NOT CHECKED.** Only 1080 and 1440 desktop pictures exist; phone sizes do not apply to an AutoCAD window.
4. **Rule 7 (one biggest answer): FAILS.** The biggest text on screen is the preview label "150 DIA. UPVC SN8 PIPE AT 1 IN 100", not the answer; "450 x 450" and "0.57 m deep" are the same size, so there is no single most obvious thing (bench_pit_1080_dark).
5. **Rule 8 (label, answer, working, note): FAILS.** Cards 3 "Pipes joined" and 4 "Shown on the drawing" have no answer line; card 1 goes straight from answer to form fields with no working.
6. **Rule 9 (working as a sum): MEETS.** Card 2 shows cover level minus outlet invert equals depth, signs in their own column, line above, underline under 0.57 (bench_pit_1080_dark).
7. **Rule 10 (three text levels, bold the number): FAILS.** At least six sizes (title bar, card title, big number, field label, field value, grey note) plus two sizes of preview text; card titles are bold.
8. **Rule 11 (every card a picture): FAILS.** Card 1 "Pit" is form fields only.
9. **Rule 12 (squint test): FAILS.** Blurred, the bright green and yellow preview text and the blue pit outline win; the amber warnings in cover_650 are two thin strips.
10. **Rule 13 (colour means something, with a word): FAILS.** Amber means "a pipe end that moves" (legend ring) and also "Needs a look" (banner); green pipe lines and yellow CL text carry no word.
11. **Rule 14 (status colours only): FAILS.** At 1.32 m deep a 450 x 450 pit is over its 0.60 limit, which is "over", so red; it shows amber "Needs a look" (bench_pit_1080_dark_cover_650).
12. **Rule 15 (brand sets the base, accent on main button and selected item only): FAILS.** The blue-grey base is not the CE black-and-white brand; the blue accent is also on every tick box.
13. **Rule 16 (accent unlike any drawing colour): FAILS.** The OK button blue is the same blue as the pit drawn in the preview, and AutoCAD's own blue (colour 5).
14. **Rule 17 (chart colours): NOT CHECKED.** No chart on this window.
15. **Rule 18 (tap, click and command budgets): NOT CHECKED.** No written budget found for this window.
16. **Rule 19 (phone first screen): NOT CHECKED.** Lives inside AutoCAD.
17. **Rule 20 (every field has a source): MEETS.** Sources shown beside figures: measured, from P2 pipe, worked out, chosen.
18. **Rule 21 (undo, not "Are you sure?"): NOT CHECKED.** Cannot be seen in a still.
19. **Rule 22 (home screen "what needs me"): NOT CHECKED.** Not a home screen.
20. **Rule 23 (nothing pretends to work): NOT CHECKED.** The "size refused" picture looks identical to the opening picture with no refusal message (bench_pit_1080_dark_size_refused); either the state did not draw or the window says nothing. Needs a live look.
21. **Rule 24 ("Not known" or "TBC"): FAILS.** Three different wordings for missing values on one card: "not given", "not typed", "not known yet".
22. **Rule 25 (honest live preview): MEETS.** Labelled as made up, and it redraws when the size changes (bench_pit_1080_dark_B4).
23. **Rule 26 (never overwrite what he typed or locked): NOT CHECKED.** No clash state in the pictures.
24. **Rule 27 (spacing scale, corners, icons one size): FAILS.** Padlocks are about half the size of the tick boxes and arrows; three different legend markers. Exact gaps not measured.
25. **Rule 28 (motion): NOT CHECKED.**
26. **Rule 29 (plain words, no build wording): FAILS.** "Bench preview — the real preview will be AutoCAD's own drawing" is build wording; "Over it: not given" is unclear.
27. **Rule 30 (realistic content): MEETS.** Pit numbers, levels and pipe sizes look like a real job.
28. **Rule 31 (separate checker before Tim sees it): FAILS.** This audit is the first separate check found, and most of its questions come back "no".

**Count: 4 meet, 15 fail, 9 not checked.**

### Group 2: Pipe window (bench_pipe_*)

Pictures seen: bench_pipe_1080_dark, _1080_light, _1440_dark, _out_by, _grade_minus50, _overheld_up540.

1. **Rule 4: FAILS.** At 1440 the cards float centred with wide empty margins while the preview fills (bench_pipe_1440_dark); the preview also changes height between states, so the cards jump up and down (compare bench_pipe_1080_dark and _grade_minus50).
2. **Rule 5: FAILS.** Dark and light versions both exist.
3. **Rule 6: NOT CHECKED.** AutoCAD window; only desktop sizes exist.
4. **Rule 7: FAILS.** Three equal-sized answers (150, 0.08, IL 5.20) and the largest text is again the preview pipe label.
5. **Rule 8: FAILS.** Card 4 "Shown on the drawing" has no answer.
6. **Rule 9: FAILS (RISK).** The Levels sum does not add up when an end is held: "5.20 + 0.13 = 5.28" (bench_pipe_1080_dark_out_by) and "5.10 + 0.08 = 5.40" (bench_pipe_1080_dark_overheld_up540). A sum with a line above a false result is a wrong figure dressed as working.
7. **Rule 10: FAILS.** Same six-plus text sizes; bold card titles.
8. **Rule 11: MEETS.** Every card has a picture: size circles, fall triangle, cover section, label sample.
9. **Rule 12: FAILS.** Blurred, the preview's blue pipe and green label dominate; the "Wrong" banner is only on the Fall card, not on the Levels card whose sum is false.
10. **Rule 13: FAILS.** Amber ring = "a level that moves" and amber pill = "Check".
11. **Rule 14: FAILS.** Green also used for drawn pipe lines; amber used for "moves".
12. **Rule 15: FAILS.** Blue accent on OK, both direction toggles, three tick boxes, the selected size circle and the pipe in the preview.
13. **Rule 16: FAILS.** The pipe being changed is drawn in the same blue as the OK button.
14. **Rule 17: NOT CHECKED.** No chart.
15. **Rule 18: NOT CHECKED.** No written budget found.
16. **Rule 19: NOT CHECKED.** AutoCAD window.
17. **Rule 20: MEETS.** Sources shown: measured, chosen, typed over, from Fall card, worked out.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.** Not a home screen.
20. **Rule 23: FAILS (RISK).** With a rejected grade of 1 in -50 the window still works out a fall of -0.16, shows "IL 5.44" as the big answer and says "Moves: Invert at P3 becomes 5.44" (bench_pipe_1080_dark_grade_minus50). It presents a figure built on an input it has just called wrong.
21. **Rule 24: MEETS.** Warns ("Wrong", "Cannot check yet") and does not block; no missing value is shown as 0.
22. **Rule 25: FAILS.** In the wrong states the preview shrinks until labels overlap and cannot be read ("IL 5.2" with a symbol over it, bench_pipe_1080_dark_grade_minus50).
23. **Rule 26: MEETS.** Held values are listed and the clash is shown as "out by 0.05", not silently fixed (bench_pipe_1080_dark_out_by).
24. **Rule 27: FAILS.** Icon sizes mixed (padlock, tick, arrow); preview height not fixed.
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Bench preview" build wording; "Held values on this stretch: P4 to P3 downstream invert 5.20, ..." is a data dump, not a sentence a drafter reads.
27. **Rule 30: MEETS.** Realistic.
28. **Rule 31: FAILS.** As group 1.

**Count: 5 meet, 16 fail, 7 not checked.**

### Group 3: Long section window (bench_run_*)

Pictures seen: bench_run_1080_dark, _1080_light, _1440_dark, _out_by, _grade_1in0, _overheld_p3_540.

1. **Rule 4: FAILS.** Cards float centred at 1440 (bench_run_1440_dark); the bottom strip grows to five lines of pills plus a run-on "Held values" paragraph (bench_run_1080_dark_overheld_p3_540). Cluttered.
2. **Rule 5: FAILS.** Dark and light both exist.
3. **Rule 6: NOT CHECKED.** AutoCAD window.
4. **Rule 7: FAILS.** "6 held", "Uphill" and "0.40" are all the same big size; the answer (cover at P4) is third of four.
5. **Rule 8: FAILS.** Card 2 "Direction" answers with a word and two buttons; card 4 has no answer line.
6. **Rule 9: MEETS.** Cover level minus invert minus pipe equals cover, correctly added in every state seen.
7. **Rule 10: FAILS.** Six-plus sizes; long-section text in mono at several sizes; bold card titles.
8. **Rule 11: FAILS.** Card 2 "Direction" and card 4 "If it does not work" are words and buttons only.
9. **Rule 12: FAILS.** In the wrong state the big "0.18 m cover" stays white; only the strip under it is red (bench_run_1080_dark_overheld_p3_540).
10. **Rule 13: FAILS.** Legend has five marks (blue dot, closed padlock, open padlock, amber ring, pink-red ring); amber ring = "Changed", amber elsewhere = needs a look.
11. **Rule 14: FAILS.** Amber used for "Changed", not status.
12. **Rule 15: FAILS.** Blue on OK, the selected direction button, the whole run in the preview and every flow arrow.
13. **Rule 16: FAILS.** The run is drawn in the button blue.
14. **Rule 17: NOT CHECKED.** The long section is a drawing, not a chart.
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: NOT CHECKED.**
17. **Rule 20: MEETS.** Every figure carries given / measured / standard / chosen / worked out.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.**
20. **Rule 23: FAILS (RISK).** With a grade of 1 in 0 the whole long section goes blank with no words, while the result card quietly switches from "cover at P4" to "0.45 m cover at the connection" and OK stays live (bench_run_1080_dark_grade_1in0).
21. **Rule 24: FAILS.** "unknown", "Not known yet" and "Wrong" all used for the same situation on one screen.
22. **Rule 25: FAILS.** Blank preview at 1 in 0; at "heights drawn 1.2 times taller" the labels overlap the ground line and each other (bench_run_1080_dark_overheld_p3_540).
23. **Rule 26: MEETS.** "Suggestions never apply by themselves"; the person picks.
24. **Rule 27: FAILS.** Icon sizes mixed; greyed suggestion button looks disabled without saying why on the button.
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Bench preview" build wording; "drop at P1 (P2 to P1) (standard) 0.02" is code wording.
27. **Rule 30: MEETS.**
28. **Rule 31: FAILS.**

**Count: 4 meet, 17 fail, 7 not checked.**

### Group 4: Inlet window (bench_inlet_*)

Pictures seen: bench_inlet_1080_dark, _1080_light, _1440_dark, _I3, _I5, _floor_waste.

1. **Rule 4: FAILS.** Same empty block at 1440 as Pit (bench_inlet_1440_dark).
2. **Rule 5: FAILS.** Dark and light both exist.
3. **Rule 6: NOT CHECKED.**
4. **Rule 7: FAILS.** The biggest text is "At the upstream end", a phrase; "DP" and "66.00" compete with it.
5. **Rule 8: FAILS.** Card 4 has no answer; card 3 for IO and FW is one sentence.
6. **Rule 9: FAILS.** No working anywhere; card 3 shows 66.00 as the answer and 66.00 again as the field, not worked.
7. **Rule 10: FAILS.** Six-plus sizes; bold card titles.
8. **Rule 11: FAILS.** Card 3 reads only "Not needed for a IO." (bench_inlet_1080_dark_I3).
9. **Rule 12: FAILS.** The only warning ("Check: 150 inlet on a 100 pipe") is in the bottom strip, not near the size field (bench_inlet_1080_dark_I5).
10. **Rule 13: FAILS.** Amber ring = "text that changes"; amber pill = "Check".
11. **Rule 14: FAILS.** A 150 inlet on a 100 pipe is wrong (red) but shown amber "Check".
12. **Rule 15: FAILS.** Blue on OK, the selected kind tile, tick boxes and the inlet in the preview.
13. **Rule 16: FAILS.** Inlet drawn in the button blue.
14. **Rule 17: NOT CHECKED.** One grey bar only.
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: NOT CHECKED.**
17. **Rule 20: MEETS.** Roof area "measured" or "chosen", position "measured".
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.**
20. **Rule 23: FAILS (RISK).** Changing the inlet to 150 says "Changes: pipe to P4 label reads 150 DIA." while the same strip says the pipe is 100 (bench_inlet_1080_dark_I5). The drawing label would show the wrong pipe size.
21. **Rule 24: MEETS.** "Not used" for a number that does not apply; no false zeros.
22. **Rule 25: MEETS.** Labelled as made up; redraws as the kind changes.
23. **Rule 26: NOT CHECKED.**
24. **Rule 27: FAILS.** Kind tiles use six different icon drawings at slightly different sizes; padlock smaller than everything else.
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Bench preview"; kind tiles show only OF, FO, IO, GIO, FW with no plain words until picked; "Not needed for a IO" is poor English.
27. **Rule 30: MEETS.**
28. **Rule 31: FAILS.**

**Count: 4 meet, 16 fail, 8 not checked.**

### Group 5: Tank window (bench_tank_*)

Pictures seen: bench_tank_1080_dark, _1080_light, _1440_dark, _dims_out, _det_too_big.

1. **Rule 4: FAILS.** Same empty block at 1440 (bench_tank_1440_dark).
2. **Rule 5: FAILS.** Dark and light both exist.
3. **Rule 6: NOT CHECKED.**
4. **Rule 7: FAILS.** "5,000 L", "4,000 L re-use" and "TWL 7.75" all the same size.
5. **Rule 8: FAILS.** Card 4 has no answer.
6. **Rule 9: MEETS.** Tank minus detention equals re-use, and base plus height equals top water level, laid out as sums and correct.
7. **Rule 10: FAILS.** Six-plus sizes plus mono tank note.
8. **Rule 11: FAILS.** Card 4 "Shown on the drawing" is tick boxes and a drop-down only.
9. **Rule 12: FAILS.** "-1,000 L re-use" stays white and large (bench_tank_1080_dark_det_too_big).
10. **Rule 13: FAILS.** Amber ring = "anything else that moves", amber banner = "Needs a look".
11. **Rule 14: FAILS.** Tank size "out by 4,123 L" is wrong, shown amber (bench_tank_1080_dark_dims_out).
12. **Rule 15: FAILS.** Blue on OK, tick boxes, tank outline and the levels diagram.
13. **Rule 16: FAILS.** Tank drawn in the button blue.
14. **Rule 17: NOT CHECKED.**
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: NOT CHECKED.**
17. **Rule 20: MEETS.** Sources on every line.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.**
20. **Rule 23: FAILS (RISK).** Two cases. With detention set to 6,000 L the preview tank note reads "-1000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE", a negative figure headed for the drawing (bench_tank_1080_dark_det_too_big). With the size out by 4,123 L, card 2 still shows a green "Suits: tank holds the 1,000 L needed" worked from the 5,000 L it has just said is wrong (bench_tank_1080_dark_dims_out).
21. **Rule 24: MEETS.** Warns, does not block; no false zeros seen.
22. **Rule 25: MEETS.** Labelled; redraws with size and note text.
23. **Rule 26: MEETS.** Shows both: "holds about 9,123 L, but the tank size is 5,000 L".
24. **Rule 27: FAILS.** Icon sizes mixed; diameter and height sit in white input boxes even when "worked out".
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Bench preview"; "TWL" with no plain word beside it in the answer.
27. **Rule 30: MEETS.**
28. **Rule 31: FAILS.**

**Count: 6 meet, 15 fail, 7 not checked.**

### Group 6: Detention window (bench_detention_*)

Pictures seen: bench_detention_1080_dark, _1080_light, _1440_dark, _D17_rain_not_entered, _two_wrongs.

1. **Rule 4: FAILS.** Six cards, the most crowded window: two answer cards on top, four working cards below, a rainfall row and a plan; at 1440 the cards float centred with wide margins (bench_detention_1440_dark).
2. **Rule 5: FAILS.** Dark and light both exist.
3. **Rule 6: NOT CHECKED.**
4. **Rule 7: FAILS.** Six big numbers the same size; 1.64 appears twice and 5.84 appears twice (top cards and cards 3 and 4).
5. **Rule 8: FAILS.** Card 3 "Storage" and card 4 "Discharge" have no answer at the top; the answer is only at the bottom of the sum.
6. **Rule 9: FAILS.** In card 4 "Flow 5.84" is drawn with the final double line as if it were the result of plate minus half orifice; it is not. In card 3 the line "Needed 1.64 m³ 5 min storm" is wedged between the items and the total.
7. **Rule 10: FAILS.** Seven-plus sizes; bold card titles; bold "Coefficient" label.
8. **Rule 11: FAILS.** Card 1 "What is fixed" is a form only.
9. **Rule 12: FAILS.** Blurred, the purple and pink plan areas and the six equal numbers are what show; the answer (storage suits or is short) is not singled out.
10. **Rule 13: FAILS.** Pink is used for the paving area and a pink-red ring means "Fails a check"; the two read as the same colour.
11. **Rule 14: FAILS.** Purple, pink and grey colour the areas (data), and green also fills the progress bars.
12. **Rule 15: FAILS.** Blue on OK, the "Boyd's" toggle, tick boxes, the detention pipe in the plan and the orifice arrow.
13. **Rule 16: FAILS.** The detention pipe in the plan is the button blue.
14. **Rule 17: FAILS.** Area colours are purple, pink, grey: the fixed order (blue, teal, purple, pink, grey) is skipped at the start, and the colours are on chips, not labels on a chart.
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: NOT CHECKED.**
17. **Rule 20: MEETS.** Each figure says given / chosen / measured / worked out.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.**
20. **Rule 23: FAILS (RISK, needs an engineer's look).** The Storage card reads "1.64 m³ of 1.64 needed · 0.06 spare" (bench_detention_1080_dark). If storage equals what is needed there is no site spare; the 0.06 is spare room in the tank only. Read quickly, it says the site has spare it does not have.
21. **Rule 24: FAILS.** Five wordings for one idea: "unknown" (lower case, as the big answer), "Not known yet", "Cannot work out yet", "not worked out yet", and empty rainfall boxes with no word in them (bench_detention_1080_dark_D17_rain_not_entered). "detention · unknown sp" is cut off.
22. **Rule 25: MEETS.** Plan labelled as made up; redraws with "WT1 ? m³" when rainfall is missing.
23. **Rule 26: NOT CHECKED.**
24. **Rule 27: FAILS.** Chips, pills, inputs and toggles each have their own rounding; icon sizes mixed.
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Boyd's" and "OSD4W" are method names with no plain word; "Tank room"; "Bench preview".
27. **Rule 30: MEETS.**
28. **Rule 31: FAILS.**

**Count: 3 meet, 18 fail, 7 not checked.**

### Group 7: Pit schedule window (bench_schedule_*)

Pictures seen: bench_schedule_1080_dark, _1080_light, _1440_dark, _invert_below_zero, _S7_typed_over.

1. **Rule 4: FAILS.** Empty block under the cards at 1440 (bench_schedule_1440_dark).
2. **Rule 5: FAILS.** Dark and light both exist.
3. **Rule 6: NOT CHECKED.**
4. **Rule 7: FAILS.** "P0 to P11", "10 columns shown" and "1:100" are all big; none is the answer. The schedule itself is the point, and nothing says "17 rows, all checked" or "1 problem".
5. **Rule 8: FAILS.** Card 3 opens "Nothing typed over" with no answer number in the plain state.
6. **Rule 9: NOT CHECKED.** No working on this window (depth to outlet is shown, not worked).
7. **Rule 10: FAILS.** Six-plus sizes plus the schedule's own text.
8. **Rule 11: FAILS.** Cards 1 and 2 are tick lists only.
9. **Rule 12: FAILS.** Blurred, the thin red outline round "-1.00" disappears and the depth "6.75" beside it is never marked (bench_schedule_1080_dark_invert_below_zero).
10. **Rule 13: FAILS.** Amber ring = "Changed", amber banner = "Needs a look".
11. **Rule 14: FAILS.** Holding P3 inlet at 5.30 puts it above P4's outlet at 5.28, so that pipe now falls the wrong way; it shows only amber "Needs a look" (bench_schedule_1080_dark_S7_typed_over). Over or wrong is red.
12. **Rule 15: FAILS.** Blue on OK, "Outlet first", ten tick boxes, the selected cell.
13. **Rule 16: FAILS.** Selected-cell blue is a drawing colour.
14. **Rule 17: NOT CHECKED.**
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: NOT CHECKED.**
17. **Rule 20: MEETS.** "Pit says" beside "Typed over", each with its source.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.**
20. **Rule 23: FAILS (RISK).** A held invert of -1.00 and the depth of 6.75 it causes are printed into the schedule preview, and the strip says "schedule on the sheet redraws" (bench_schedule_1080_dark_invert_below_zero). The depth cell has no mark at all.
21. **Rule 24: MEETS.** "TBC" in the lid column.
22. **Rule 25: MEETS.** "Preview · as it will print", "Rows drawn 2 times closer than on the sheet".
23. **Rule 26: MEETS.** Shows both values and offers "Let it follow the pit".
24. **Rule 27: FAILS.** Icon sizes mixed; padlock inside a table cell overlaps the figure.
25. **Rule 28: NOT CHECKED.**
26. **Rule 29: FAILS.** "Bench preview"; "250 in the drawing at 1:100" is drawing-unit jargon.
27. **Rule 30: MEETS.**
28. **Rule 31: FAILS.**

**Count: 5 meet, 15 fail, 8 not checked.**

### Group 8: The two web pages (whole_plugin_few_tools.html, final_program_artifact.html)

Pictures seen: WP_whole_wide_01, WP_whole_narrow_01, FP_final_wide_01, FP_final_wide_03, FP_final_narrow_01, FP_final_narrow_05; both HTML files read in full.

1. **Rule 4: FAILS.** Dozens of struck-through command names in small mono type on every card (FP_final_wide_01, WP_whole_wide_01): busy, not calm.
2. **Rule 5: FAILS.** Web pages must have dark and light; both pages are dark only (`color-scheme:dark`).
3. **Rule 6: FAILS.** At phone width text and the ribbon run off the right edge and are cut (WP_whole_narrow_01, FP_final_narrow_01, FP_final_narrow_05).
4. **Rule 7: FAILS.** Only the top pair ("146" to "11 windows, 1 list") has a big answer; every other card is a paragraph.
5. **Rule 8: FAILS.** Cards are heading, paragraph, chips; no answer.
6. **Rule 9: NOT CHECKED.** No figures worked.
7. **Rule 10: FAILS.** At least eight text styles (h1, h2, h3, body, small, upper-case label, mono chip, pill) and three font families (Segoe UI, Consolas, plus the mono fallback).
8. **Rule 11: FAILS.** Most cards are words alone.
9. **Rule 12: FAILS.** Blurred, the rose marks (heading bars, arrows, step circles, short names) are what shows.
10. **Rule 13: FAILS.** Rose is on heading bars, arrows, tab underline, step circles, short-name text and card subtitles with no meaning (code lines 11 to 34 and 42 to 56).
11. **Rule 14: FAILS.** Green, amber and rose mark the size of a change ("a line in a list", "a new kind", "a new window") and the four layers, not good / needs me / wrong (final_program_artifact.html, cost pills and layers).
12. **Rule 15: FAILS.** Rose is used on nearly everything except a main button or a selected item; the blue-grey base is not the CE black-and-white brand.
13. **Rule 16: FAILS.** The ribbon mock-up shows short names in rose, close to AutoCAD's magenta (colour 6), so it would clash with drawing colours if carried into AutoCAD.
14. **Rule 17: NOT CHECKED.** No charts.
15. **Rule 18: NOT CHECKED.**
16. **Rule 19: MEETS.** On a phone the headline numbers are on the first screen (FP_final_narrow_01).
17. **Rule 20: NOT CHECKED.** No fields.
18. **Rule 21: NOT CHECKED.**
19. **Rule 22: NOT CHECKED.** Not a home screen.
20. **Rule 23: MEETS.** The final page says plainly "nothing is installed" and lists what is not built. Note: the photographs of the first page are out of date (they show "12 windows", "18 short names" and an Outlet button; the file now says 11, 17 and has no Outlet).
21. **Rule 24: MEETS.** "Not settled, shown honestly" lists the open items.
22. **Rule 25: MEETS.** Marked DRAFT throughout.
23. **Rule 26: NOT CHECKED.**
24. **Rule 27: FAILS.** The code uses gaps of 5, 6, 8, 9, 10, 12, 14, 18 and 26 px and corner roundings of 4, 6, 8 and fully round: not 8 / 16 / 24 / 32, not one rounding.
25. **Rule 28: MEETS.** Nothing moves; no animation in the code.
26. **Rule 29: FAILS.** "D-246", "D-274", "design\FUNCTION_MAP.md", "27-test gate", "The brain", "The hands", "SPS", "STORM report".
27. **Rule 30: MEETS.** Real counts and real tool names.
28. **Rule 31: FAILS.**

**Count: 6 meet, 15 fail, 7 not checked.**

## 3. Ranked, worst offender first

1. **Detention window (18 fail).** Worst offender, and the one to mock up.
   1. **RISK:** "1.64 of 1.64 needed · 0.06 spare" reads as site spare that is really tank room (rule 23).
   2. Six equal big numbers, two of them shown twice; no single answer (rule 7).
   3. Missing values said five ways, with "unknown" as the big answer and empty rainfall boxes (rule 24).
2. **Pipe window (16 fail), but the first to fix under rule 3.** Its risk failure is the most dangerous on any screen.
   1. **RISK:** the Levels sum shows false results when an end is held (5.20 + 0.13 = 5.28; 5.10 + 0.08 = 5.40) (rule 9).
   2. **RISK:** from a rejected grade it still works out IL 5.44 and says the P3 invert will move to it (rule 23).
   3. Preview shrinks until labels overlap in the wrong states, and the cards jump (rules 25, 4).
3. **Long section window (17 fail).**
   1. **RISK:** at a grade of 1 in 0 the long section goes blank without a word, and the result silently moves to "cover at the connection" (rule 23).
   2. The big answer stays white when it is wrong (0.18 m cover) (rule 12).
   3. A five-mark legend and a run-on "Held values" paragraph (rules 13, 29).
4. **Tank window (15 fail).**
   1. **RISK:** preview tank note reads "-1000 lt TO BE USED FOR TOILET FLUSHING" (rule 23).
   2. **RISK:** green "Suits" shown while the tank size is out by 4,123 L (rule 23).
   3. Out by 4,123 L shown amber, not red (rule 14).
5. **Inlet window (16 fail).**
   1. **RISK:** a 150 inlet relabels the 100 pipe as "150 DIA." (rule 23).
   2. Card 3 is one sentence for IO and FW (rule 11).
   3. Kind tiles use bare codes OF, FO, IO, GIO, FW (rule 29).
6. **Pit schedule window (15 fail).**
   1. **RISK:** a held invert of -1.00 and its depth of 6.75 print into the schedule; the depth cell is not marked (rule 23).
   2. A held level that makes a pipe fall the wrong way is only amber (rule 14).
   3. Big text is "P0 to P11", "10" and "1:100"; none is the answer (rule 7).
7. **Pit window (15 fail).**
   1. Possible risk, not confirmed: "size refused" shows no message (rules 23, 29).
   2. A pit past its depth limit is amber, not red (rule 14).
   3. Preview label text is the biggest thing on screen (rule 7).
8. **The two web pages (15 fail).** No risk failure.
   1. Rose on almost everything, with no meaning (rules 13, 15).
   2. Text cut off on the right at phone width (rule 6).
   3. Decision numbers, file names and "27-test gate" on screen (rule 29).

**Risk failures under rule 3 (shows a wrong figure or pretends to work), in fixing order:** Pipe false sum; Pipe figure from a rejected grade; Schedule printing -1.00 and 6.75; Tank negative re-use in the drawing note; Tank green "Suits" while the size is out; Inlet relabelling the pipe 150 DIA.; Long section blank preview; Detention "0.06 spare" wording (needs Tim's engineering read).

## 4. The ten most repeated failures (fix once, in the shared parts)

1. **Two colour schemes for windows inside AutoCAD (rule 5).** All 7 windows. Keep one.
2. **The answer is not the most obvious thing (rules 7, 12).** All 8 groups. The preview's bright drawing text, or three to six equal-sized numbers, beats the answer. The shared card needs one answer size used once per card, and the preview text needs to be quieter than it.
3. **Build wording on screen (rule 29).** All 8. "Bench preview — the real preview will be AutoCAD's own drawing" on every window; decision numbers and file names on the web pages.
4. **Amber means two things (rules 13, 14).** All 7 windows. The amber "changed / moves" ring and the amber "Needs a look" banner are the same colour. "Changed" needs a non-status mark (for example a grey outline with the word).
5. **Over or wrong shown as amber (rule 14).** Pit depth past its limit, tank size out by 4,123 L, a 150 inlet on a 100 pipe, a pipe falling the wrong way in the schedule. The shared status pill needs one rule: over or wrong is always red.
6. **The accent is everywhere and is a drawing colour (rules 15, 16).** All 7 windows use the OK-button blue on every tick box, toggle and drawn pit or pipe. AutoCAD draws in that blue too. The web pages do the same with rose.
7. **Too many text sizes and bold labels (rule 10).** All 8. Six or more sizes per window, with bold card titles.
8. **Cards of words or ticks with no picture and no answer (rules 8, 11).** All 8. "Shown on the drawing", "If it does not work", "What is fixed", the schedule tick lists.
9. **The layout resizes two different ways (rules 4, 27).** All 7 windows. At 1440 Pit, Inlet, Tank and Schedule leave an empty block; Pipe, Long section and Detention float the cards centred. In wrong states the preview height changes and the cards jump. One fixed grid for every window.
10. **A wrong state still shows a confident result (rules 12, 23).** Six windows. The big answer stays white when wrong (0.18, -1,000, IL 5.44), the drawing preview carries the wrong figure, and a sum line shows a held value as if worked. When an input is wrong, the answer needs to show "Not known" in red, not a number.

Runner-up: missing values are worded five ways ("not given", "not typed", "not known yet", "unknown", "cannot work out yet") on Pit, Long section and Detention (rule 24). One wording: "Not known".

## 5. Brief for the mock-up: Detention window, fixed, rule by rule

Made-up content (rule 30): a 600 m² house lot, roof 230 m², paving 150 m², garden 220 m², 5,000 L tank with 1,000 L detention, permitted discharge 6.00 L/s, 69 mm orifice.

1. **Rule 4 (calm, one language).** One fixed grid, the same as every other window: plan on top at a fixed height, then one row of cards that stretch to the window width at 1080 and at 1440. No empty blocks, no floating cards. Built from the shared card, field, pill and button parts.
2. **Rule 5 (one scheme).** One scheme only, chosen to suit AutoCAD's dark model space, with no light copy.
3. **Rule 7 (one answer).** The window answers one question: "Does the site's storage and discharge work?" One big line at top left, for example "Storage short by 0.54 m³", in red with the word "Short". Discharge sits beside it at a smaller size. Every other number is at body size. Nothing appears twice.
4. **Rule 8 (order).** Every card: short label ("Storage"), its answer ("1.64 m³ provided"), the working, then a grey note ("Tank holds 0.06 m³ more than it is asked to"). Cards 3 and 4 get their answer line at the top.
5. **Rule 9 (sum).** Storage: Tank 0.94, + Pipes 0.56, + P1 0.08, + P2 0.06, line, = 1.64 provided, then "Needed 1.64" as its own line below, then the difference with a double line. Discharge: Plate 380, − half orifice 34.5, line, = head 345.5; flow 5.84 L/s on its own line, with the formula named in the grey note, not drawn as the result of the subtraction.
6. **Rule 10 (three levels).** Answer size, body size, grey note size. Bold only on numbers. One font for words and one for figures (CE uses IBM Plex Sans and IBM Plex Mono; headings Montserrat only if Tim wants it inside AutoCAD).
7. **Rule 11 (picture).** Storage: one bar of provided against needed with the gap labelled. Discharge: the head and plate sketch already there. Areas: a three-part bar with labels on the bar. "What is fixed" becomes a short list with each source shown, plus a small "6.00 L/s allowed" answer.
8. **Rule 12 (squint).** Blurred, only the answer line and any red word show. The plan is drawn in quiet greys, with no fills.
9. **Rules 13 and 14 (colour).** Green "Suits", amber "Needs a look", red "Short" or "Wrong", each with its word. "Changed" is a grey outline with the word "Changed", never amber. No colour on areas.
10. **Rules 15 and 16 (accent).** Accent only on OK and on the selected method button. Ticks are grey-white. The accent is chosen to be unlike AutoCAD's index colours 1 to 7 and unlike the office layer colours.
11. **Rule 17 (charts).** If the three areas need colour, use the fixed order: blue, teal, purple. Labels on the bar, no legend.
12. **Rule 20 (sources).** Keep the source word on every figure (given, measured, worked out, chosen).
13. **Rule 23 (honest).** Replace "of 1.64 needed · 0.06 spare" with two plain lines: "Site storage: 1.64 provided, 1.64 needed, nothing spare" and, under the tank, "Tank has 0.06 m³ unused". When the head is below zero, flow shows "Not known" in red with the reason, not a figure.
14. **Rule 24 ("Not known").** Every missing value reads "Not known", capital N, the same everywhere, including inside each empty rainfall box. Warn in the strip; OK still works.
15. **Rule 25 (preview).** Plan labelled once and small: "Plan sketch, not to scale". No build wording.
16. **Rule 26 (show both).** A held figure that clashes shows both values side by side with "Use worked-out value" as the person's choice.
17. **Rule 27 (finish).** Gaps of 8, 16, 24 and 32 only; one corner rounding for cards, fields, pills and buttons; padlock, tick and arrow icons all one size.
18. **Rule 29 (words).** "Boyd's" and "OSD4W" each get a plain name first, with the formal name in brackets after it (Tim to supply the plain names; not guessed here). "Tank room" becomes "Room in tank for detention".
19. **Not to be shown in the mock-up as settled.** Tap and click budget, undo and motion (rules 18, 21, 28). The mock-up should list them as "to be written and tested".

## 6. What this audit did not do

1. Did not open every state picture: about 30 of the 75 bench pictures were seen. The 1440 light pictures and most step-by-step click pictures in `shots\clicks\` were not opened.
2. Did not measure pixel gaps; rule 27 marks rest on visible icon sizes and the web page code.
3. Did not check motion, undo, budgets or phone sizes for the AutoCAD windows.
4. Did not run the windows; the Pit "size refused" picture may be a capture fault rather than a window fault.
5. Did not check that the engineering figures are right beyond simple arithmetic. The sums that were checked add up, except the Pipe Levels sums named above.
