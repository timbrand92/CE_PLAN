# CARD DRAFTS 4 of 15: NEW PIPE (CD) — Mon 2 Nov 2026

Written by Sonnet (Team, read-only) at CE 05's request for CE 00. Every card below is a DRAFT FOR TIM: nothing is approved. I read files and code only. I did not run AutoCAD, the robot, a build or a test. Times are Melbourne.

## FOR TIM

1. **Five cards follow**, one per command group you listed. All five are the CD command (ribbon: tab CE, panel Draw, big button "Pipe") and its New Pipe window; card 5 also touches Edit Pipe (CDEDIT) and CDRULES.
2. **Which PRs are where (read from REGRESSION_LOG on each branch):** on rel-20261102a (C-78, 3fbb9da5): #1858, and the F-023 / B-035b / B-046 starting-settings work only. On rel-20261106a (C-79a): add #1928, #1947, #1949. On rel-20261110a (C-79b2): add #1919, #1927, #1960. rel-20261108a (C-79b1) holds none of the seven. rel-20261112a has everything 110a has.
3. **A fault to know about first:** the Codex look A78c (1 Nov, Civil 3.0.88) says Esc did NOT close the Grade mismatch window; the Cancel button did. #1858 is meant to make Esc cancel. On rel-20261110a the window only appears if you switch the new warning line OFF, so this matters mainly as a fallback.
4. **Nothing could not be pinned down** except: where exactly "Recall Last" sits in the one-page New Pipe window (the older card says Pipe tab, the code has the button in CdDialog.xaml), and the CDRULES ribbon button (the Checks button only shows once `checks.checksCommandEnabled` is ON; CDRULES is typed-only).
5. **Questions only you can answer:** (a) is "steeper than the grade also warns" what you meant by "2no but warn" (card 1); (b) should colleagues' windows refill the last pipe's levels (Recall last ticked) (card 3); (c) CPAA 8 m/s against house 6.0 for concrete (card 5); plus small wording asks on cards 1, 2 and 4.
6. **What was read:** the Opus pre-review files U, E, AB, AC, AD, RECHECK; BUILD REGISTER; both train PR lists; carpark entries; QUESTIONS_FOR_MONDAY; your 29 and 31 Oct answers; REGRESSION_LOG and code on the four branches.
7. **NOT proven for any card:** nobody has opened any of these changes in AutoCAD on a build that has them and recorded it as accepted. Built and unit-tested: yes for all (per the log entries). Installed: C-78 (3.0.88) and C-79a (3.0.89) per the register; C-79b2 is not installed (installs are on HOLD). Tim-accepted: none.
8. **Verdict:** drafts complete; two of your decisions are interpretations (steeper warning, colleagues' Recall) and one is still open (CPAA 8 against 6.0).

---

## CARD 1 — New Pipe "Grade mismatch" window (PR #1858, then PR #1919)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** the question New Pipe asks when the levels you typed do not match the Custom grade you chose (for example Custom 1 in 100 but your levels give 1 in 200). #1919 turns the question into one warning line.
2. **Ribbon or trigger:** tab "CE" (tab "CE Civil" if classic tabs are shown), panel "Draw", large button "Pipe" (command CD; registry label "Pipe Layout (CD)"). The check runs when you press Start Pipe and the pipe is drawn.
3. **Works today (what Keep would protect):** the question only appears in Custom ("Set my own") grade, when both levels are typed and the real grade is more than the Settings percentage (10) off the typed grade. Your own suggested level is already skipped (B-057, `pipe.mismatchBoxSkipsOwnSuggestion`).
4. **What the train or PR changes:**
   1. **#1858 (BUG-857, B-023, in C-78):** switch `grade.mismatchBoxCloseCancels`, ON. The window gets a Cancel button. Cancel, Esc and the X place no pipe. Enter still presses "Keep". OFF = the old two-button window where Esc and the X placed the pipe.
   2. **#1919 (B-093, C-79b2 only):** `pipe.gradeMismatchIsWarningLine` ON: no window; one line and the pipe is drawn with your levels. `pipe.steeperThanGradeWarns` ON: steeper pipes warn too. `pipe.flatterThanMinimumWarnsInDefault` ON: in Default grade with two typed levels, a pipe flatter than the minimum grade (1 in 100 as shipped, read from Settings) warns. All three OFF = the window as before (with #1858's Cancel).
5. **Suggested class: Modify.** The behaviour changes from a window to a warning line by your ruling (items 118 to 120). Suggestion only.
6. **Prompts and windows (exact wording):**
   1. Window title: "Creative Engineering | Grade mismatch". Heading: "Grade mismatch detected". Body: "You typed Custom 1 IN 100, but the inverts produce an actual grade of about 1 IN 200. Which value should the pipe label show?" then, with #1858 ON: "Cancel (or Esc, or the X) places no pipe." Buttons: "Use 1 IN 200", "Keep 1 IN 100" (the default button), "Cancel".
   2. Cancel line on the command line: "[CE] Grade mismatch box cancelled - no pipe placed. Run CD again to place it (nothing was changed)."
   3. #1919 line (command line, prefixed "[CE] "): "Levels typed give 1 in 200, flatter than the 1 in 100 grade chosen. Your levels are used." Steeper: same with "steeper than". Default minimum: "Levels typed give 1 in 200, flatter than the 1 in 100 minimum grade. Your levels are used." The same text also shows in the New Pipe window's existing warning strip (the one that says "Upstream invert is lower than downstream").
7. **Selection:** none of its own; you have already picked the pipe points. It reads your typed levels and the pipe length.
8. **Preview:** the window's warning strip shows the #1919 line while you type (it listens to length and grade changes). The old window has no preview.
9. **Drawing output:** nothing is drawn by the question or the line. The pipe is drawn as usual with your typed levels. No layer, Xref or REFEDIT handling is touched (the log says so for both PRs; the pipe draw keeps the existing native protections). The pipe label keeps the grade you chose: Opus review U found that in Set my own the label still says 1 IN 100 when your levels give 1 in 200, same as pressing Enter on the old window.
10. **Cancel, Escape, Undo and Redo:** #1858: Cancel, Esc, X stop before anything is drawn, so nothing to undo. #1919: no window, so nothing to cancel; the pipe is drawn like any other, one Undo removes it. **Fault seen on 3.0.88 (Codex A78c): Esc did not close the window.** The XAML binds Esc to the Cancel action (`EscapeCommand`) as a key binding; GUESS: it does not fire when the window does not have keyboard focus. Not investigated further.
11. **Save and reopen:** nothing is saved by the question or the line. The pipe saves as normal.
12. **Assets, data and Settings:** reads `grade.mismatchBoxCloseCancels`, the three #1919 switches, the 10 percent threshold, `grade.defaultMinimumValue`. Settings file `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`. Writes nothing. The switches are not on the Settings page. A missing file or group reads ON.
13. **Performance:** one arithmetic check per pipe draw. No concern read in the code. Not measured.
14. **Discovery:** no Help page text for the line was found; the Help guide entry for CD (`guide-content.js`) is general. The line appears on the command line and in the window strip, so you meet it by doing it. GUESS: needs a Help sentence.
15. **Example drawing and expected result:**
    1. Custom 1 in 100, 20 m pipe, inverts 18.000 and 17.900 (fall 0.100 = 1 in 200). On C-78: window with three buttons. On C-79b2: no window, the line "Levels typed give 1 in 200, flatter than the 1 in 100 grade chosen. Your levels are used." and the pipe drawn with 18.000 / 17.900.
    2. Custom 1 in 100, 10 m, 18.000 and 17.800 (1 in 50): on C-79b2 the "steeper than" line.
    3. Default grade, empty ground, 20 m, 18.000 and 17.900: the "minimum grade" line.
16. **Older family card:** `docs\CARDS\CV-01_DRAINAGE_NETWORK.md` and `docs\workflows\C2_EDITOR_TABS_2026-09-06.md` (6 Sep). They no longer cover: the Grade mismatch window at all (no hit for "mismatch"), Cancel / Esc / X, the warning line, the Default-grade minimum warning, or the 1 in 100 minimum ruling of 29 Oct. C2 only lists `CustomGrade` as moved to the Levels & Flow tab.
17. **Tim's AutoCAD checklist (copies of drawings only):**
    1. On C-78 or with #1919's first switch set to false in CD_Settings.json and AutoCAD restarted: type CD, choose Set my own, type 1 in 100, pick two points 20 m apart, type 18.000 and 17.900, press Start Pipe. Expect three buttons.
    2. Click Cancel. Expect no pipe and the "[CE] Grade mismatch box cancelled" line.
    3. Run again; press Esc. Expect the same. **If the window stays open, that is the fault Codex saw.**
    4. Run again; click the X. Expect the same.
    5. Run again; press Enter. Expect the pipe at 1 IN 100.
    6. On C-79b2 (switch ON): same inputs. Expect no window, one "[CE] Levels typed give 1 in 200..." line, the pipe drawn, and the same words in the window's warning strip before you press Start Pipe.
    7. Type 18.000 and 17.800 over 10 m: expect the "steeper than" line.
    8. Switch to Default grade, 20 m, 18.000 and 17.900: expect the "minimum grade" line.
    9. Press U: the pipe goes in one step.
18. **Questions only Tim can answer:**
    1. **Steeper pipes warn.** Context: your voice answer was "2no but warn". I read it as: no window, but the same warning line (item 119, marked GUESS there). Recommendation: keep as built, because a 1 in 50 pipe on a job built for 1 in 100 is usually a typing slip and a line costs nothing. If you meant "warn only when flatter than the 1 in 100 minimum", say so and the steeper switch goes OFF.
    2. **Label wording.** Context: the pipe label still says 1 IN 100 when the levels give 1 in 200. Opus recommends the line also say "Label shows 1 IN 100". Recommendation: yes, so nobody is surprised on a council submission. On a job: a drafter reads the line, sees the label says 1 IN 100 and corrects one or the other.
    3. **Esc fault.** Not a question; it needs a fix. The X-button question is noted in the carpark as still with you.
19. **NOT proven:** Built: yes (#1858 unit-tested; #1919 unit-tested, C-79b2 net10 tests reported 0 failed). Tested: unit tests only; one Codex look at 3.0.88 saw Cancel work and Esc not close the window. Installed: #1858 on 3.0.88 and the C-79a build 3.0.89; #1919 NOT installed. Tim-accepted: no. Nobody has driven the #1919 line in AutoCAD. CDRULES does not show the typed-against-chosen line (the stored pipe does not keep the chosen grade). BUG-857 stays OPEN in the carpark.

---

## CARD 2 — Recall Last, then a new upstream level (PR #1927, BUG-1267, B-095)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** after you press Recall Last in New Pipe and then type a new upstream level, the downstream level is worked out from the standard grade for this pipe's length instead of copying the last pipe's fall.
2. **Ribbon or trigger:** tab CE, panel Draw, button "Pipe" (CD), then the "Recall Last" button in the window (`CdDialog.xaml`, `RecallLastSettingsCommand`). Edit Pipe's equivalent is labelled "Use last settings". The window also refills by itself when "Recall last settings" is ticked.
3. **Works today:** Recall Last refills the last pipe's size, material and both levels. Typing in the downstream box yourself sets a fall you control.
4. **What it changes:** #1927, switch `pipe.recallLastNewUpstreamUsesStandardGrade` ON, on rel-20261110a (C-79b2) and later only. Stacked on #1919; in the train they go together. OFF = old behaviour exactly.
5. **Suggested class: Modify.** Your word: "5as recommened" (item 122).
6. **Prompts and windows:** no new prompt or window and no layout change. It is not on the Settings page.
7. **Selection:** none.
8. **Preview:** the downstream box fills as you type the upstream level.
9. **Drawing output:** nothing drawn by it; the pipe uses the levels in the boxes. No layer, Xref or REFEDIT handling (log: a calculation inside the window only).
10. **Cancel, Escape, Undo and Redo:** as New Pipe. Typing in the downstream box clears the "recalled" mark, so a fall you set is held as before.
11. **Save and reopen:** nothing saved by it. Recall data is the existing remembered settings.
12. **Assets, data and Settings:** reads the Custom grade in the box (else the table grade) and Settings "Calculated decimals". Writes nothing new.
13. **Performance:** one calculation per keystroke in the window; not measured.
14. **Discovery:** none specific. GUESS: needs no page; it is a correction.
15. **Example and expected result:** recalled upstream 19.00 and downstream 18.50. You type 19.45 on a 4.1 m pipe at 1 in 100. Fall 4.1 / 100 = 0.041, rounded up to 0.05, downstream 19.40 (it was 18.95). At 1 in 200 on the same pipe my arithmetic gives a fall of 0.0205 rounded up to 0.03, so downstream about 19.42 (GUESS; Opus asked for exactly this test and the log lists only 1 in 100).
16. **Older family card:** `docs\workflows\C2_EDITOR_TABS_2026-09-06.md` lines 88 and 127 say Recall Last moves to the Pipe or Preferences tab; the code on the line has the button in `CdDialog.xaml`. It no longer covers the recalled-level rule, the BUG-076 heuristic, or the new switch. CV-01 has no Recall Last text.
17. **Tim's AutoCAD checklist:**
    1. Place a pipe with upstream 19.00 and downstream 18.50. Open CD again, choose Set my own, type 1 in 100.
    2. Click Recall Last. Do NOT clear the upstream box.
    3. Pick two points 4.1 m apart. Type 19.45 in the upstream box. Expect downstream 19.40.
    4. Type a figure in the downstream box. Expect it held.
    5. Repeat with the switch false and AutoCAD restarted. Expect 18.95.
    6. Repeat at Custom 1 in 200. Expect a downstream different from 19.40 that follows 1 in 200.
18. **Questions only Tim can answer:** **Wording.** Context: right after Recall Last, #1919's line can say "Levels typed give 1 in 8..." for levels you did not type (Opus U point 6). Recommendation: change "typed" to "Levels give". On a job: you would not think CE mis-read you.
19. **NOT proven:** Built: yes. Tested: unit tests only (worked example, switch OFF 18.95, other lengths); no 1 in 200 test. Installed: no (C-79b2 not installed). Tim-accepted: no. Opus U also saw your real CD_Settings.json change size during this builder's work (4 Oct stamp); nobody proved why. BUG-1267 stays OPEN.

---

## CARD 3 — New Pipe starting settings for colleagues' fresh logins (PR #1928, B-094) and the pipe-object default (B-035 / F-023 / B-046)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** what a colleague's New Pipe window looks like the very first time CE starts on their PC.
2. **Ribbon or trigger:** none; it applies at first start with no CD_Settings.json, then shows in CD (tab CE, panel Draw, button "Pipe").
3. **Works today:** an existing settings file is never touched, even an empty or damaged one. A key the shipped file lacks keeps the built-in value.
4. **What it changes:**
   1. **F-023 (C-77, on all lines):** shipped `Assets\Config\colleague-defaults.json`, switch `settings.firstStartUsesColleagueDefaults` ON (OFF is set inside the shipped file). Waiting for your approval of the value list (log: the list is the desk's export; your item 63 ruling is "defualt on for everyone").
   2. **B-035b (C-78):** removed your remembered water-tank plan picks from that file.
   3. **B-046 (in the log of C-79b2; also referenced in rel-20261102a's log):** `options.pipeObjectAutomaticIsOnForEveryone` ON: with the setting left Automatic, every login on AutoCAD 2027 draws the one-piece CE pipe object. Nothing written to anyone's file. On 2022 to 2024 nothing changes.
   4. **#1928 (B-094, C-79a on, last in C-79a):** adds `grade.method` "custom" and `grade.customValue` "100", so New Pipe opens on "Set my own" with 1 in 100. The current shipped file also carries `options.rememberCdSettings` true ("Recall last settings" ticked), pipe object "On", snaps 1151 and 0, dark theme, rising main destination WT, pit lid "Class A Grate".
5. **Suggested class: Modify** (shipped defaults change). Suggestion only.
6. **Prompts and windows:** none new. The New Pipe window opens with "Set my own" ticked and 1 in 100 typed.
7. **Selection:** none.
8. **Preview:** none.
9. **Drawing output:** none by itself. The one-piece object default changes what CD draws (a CE pipe object instead of an ordinary polyline) on AutoCAD 2027.
10. **Cancel, Escape, Undo and Redo:** nothing is written to disk until the first real save. To undo: the switch in the shipped file, or a settings file.
11. **Save and reopen:** the first save writes the settings file; after that your colleague's own saved values win.
12. **Assets, data and Settings:** reads the shipped JSON; the file is checked for folder-path-looking text (dropped). No keys or secrets.
13. **Performance:** one small file read at first start only.
14. **Discovery:** the Settings page shows the values after first save; the starting-settings switch is not on the Settings page.
15. **Example and expected result:** a new colleague logs in with no settings file, types CD. Expect "Set my own" ticked with 1 in 100, "Recall last settings" ticked, pipe object On. With the 20 m, 18.000 / 17.900 example, they get the card 1 warning rather than the old window.
16. **Older family card:** `docs\CARDS\SH-04_SETTINGS_STANDARDS.md` (not read in this pass; GUESS it predates F-023). CV-01 and C2 do not mention colleague starting settings.
17. **Tim's AutoCAD checklist (a test Windows login or the robot's clean profile; never your real settings file):**
    1. Start AutoCAD on a login with no CD_Settings.json. Type CD.
    2. Expect "Set my own" ticked and 1 in 100 in the grade box; "Recall last settings" ticked.
    3. Place one pipe, close the window, type CD again: expect the last pipe's size, material and levels refilled.
    4. Check Settings > Advanced > One-piece pipes reads On or Automatic that behaves as On on 2027.
    5. Quit, set `settings.firstStartUsesColleagueDefaults` false in the shipped file on a test copy: expect the old built-in start.
18. **Questions only Tim can answer:**
    1. **Should colleagues' New Pipe refill the last pipe's levels too?** Context: to make Custom 1 in 100 stick, #1928 also ticks "Recall last settings", so every colleague window refills size, material, text choices AND both levels (Opus U; QUESTIONS item 97 treated it as an FYI, a later list asks one yes or no). Your own window works this way. Recommendation: yes, matches "colleagues get your exact setup". On a job: a colleague drawing a run of 150 uPVC pipes does not retype size each time, but also may forget to change levels. Combined with card 2, the downstream works from 1 in 100 for the new length.
    2. **Approve the value list in colleague-defaults.json** (log says it is unapproved). Recommendation: approve after you read the nine lines above.
19. **NOT proven:** Built: yes (B094ColleaguesStartNewPipeInCustom100Tests; shipped file read back). Tested: unit tests only; nobody has started CE on a clean profile and looked (F-023 log says so). Installed: B-094 on C-79a 3.0.89 per the register; F-023 on C-77/78. Tim-accepted: no (list unapproved). Decision 161 asks the area plus N91 and Settings smoke S1 re-test.

---

## CARD 4 — Typed level held to the nearest 10 mm (PR #1947, BUG-685, B-130)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** when "work the other end out from the grade" holds your typed level to the nearest 10 mm, CE says so in one line.
2. **Ribbon or trigger:** CD (tab CE, panel Draw, button "Pipe") and Edit Pipe (CDEDIT).
3. **Works today:** levels are held to the nearest 10 mm ("Calculated decimals" 2). A typed 10.125 comes out 10.13 and 10 m at 1 in 100 gives 10.03, silently.
4. **What it changes:** #1947, switch `pipe.typedLevelRoundingNote` ON, in C-79a (rel-20261106a) and later. Rounding and grade unchanged. OFF = no line.
5. **Suggested class: Modify** (a note added). **What ships:** your ruling is recorded. QUESTIONS 21h and decision 47 say "recommended answer" (keep the 10 mm rule and say it in one line). The BUILD REGISTER item 87 older text said BUG-685 was waiting; item 193 later says decision 47 answered it. The line follows your words: "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm). The grade stays exactly 1 in 100."
6. **Prompts and windows:** one command-line line, also in the diagnostic log: "[CE] Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". The step in the words follows Calculated decimals (10 mm at 2). The New Pipe window preview does not show it (a Codex window brief is left over).
7. **Selection:** none.
8. **Preview:** none in the window (stated gap).
9. **Drawing output:** nothing; a message only. No layer, Xref or REFEDIT effect (log).
10. **Cancel, Escape, Undo and Redo:** nothing to undo; the pipe itself undoes as usual.
11. **Save and reopen:** nothing saved; the rounded levels are saved as before.
12. **Assets, data and Settings:** reads Calculated decimals and the switch. Writes nothing.
13. **Performance:** none read.
14. **Discovery:** command line only; no Help text found.
15. **Example and expected result:** CD, "I know one end - work the other out from the grade", decimals 2, upstream 10.125, 1 in 100, 10 m. Expect pipe 10.13 and 10.03 and the line above. Typed 10.12 gives no line (already on a step).
16. **Older family card:** CV-01 CV5 says "Display values consistently to two decimals"; it does not mention the typed-level note or holding a typed level. Carpark line 848 (Pit Schedule -0.004 shown "0.00") is a possible link to the same rule.
17. **Tim's AutoCAD checklist:**
    1. Type CD. Tick "I know one end - work the other out from the grade". Settings: Calculated decimals 2.
    2. Type upstream 10.125, grade 1 in 100, pick points 10 m apart. Press Start Pipe.
    3. Expect on the command line: "[CE] Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". Pipe 10.13 and 10.03.
    4. Type 10.12: expect no line.
    5. Open the pipe in CDEDIT, repeat from the grade: expect the same line.
    6. Set `pipe.typedLevelRoundingNote` false, restart: no line.
18. **Questions only Tim can answer:** **Should the New Pipe window show the line too?** Context: today it only prints on the command line after you press Start Pipe. Recommendation: yes, a one-line label under the level boxes, so you see it before drawing. On a job: you spot the 10 mm change while typing, not after the pipe is placed.
19. **NOT proven:** Built: yes. Tested: unit tests only (worked example, switch, both start-up reads). Installed: C-79a 3.0.89 per the register. Tim-accepted: no. BUG-685 stays open until the robot and Codex confirm on an installed build. Opus RECHECK: KEEP-WITH-NOTE.

---

## CARD 5 — Outlet pipe top above inlet pipe top (PR #1949, BUG-907) and one maximum-speed table (PR #1960, BUG-80)

**DRAFT FOR TIM: nothing is approved.**

1. **Name, and what it does for a drafter:** (a) CDRULES, Design Check and Project Review also warn where the pipe leaving a pit is bigger and its top sits above the arriving pipe's top; (b) the connection pipe CE sizes for you and the Edit Pipe grade strip judge speed against the same table as the rest of Edit Pipe.
2. **Ribbon or trigger:** (a) CDRULES (typed only), the Design Check dashboard and Project Review; the single "Checks" button on the Review panel appears only when `checks.checksCommandEnabled` is ON, otherwise the three older buttons. (b) CDEDIT (Edit Pipe) grade strip and the auto-design connection pipe step (CDDESIGN). Exact button for Project Review not read.
3. **Works today:** the pit drop check compares inverts only, and the connection pipe and grade strip use 6.0 m/s for every material, while the rest of Edit Pipe uses uPVC 3.0, concrete 6.0, metal 4.0.
4. **What it changes:**
   1. **#1949 (B-130, C-79a on):** switch `inverts.pitDropWarnsOutletTopAboveInletTop` ON. One Warn row under R-08. OFF = invert-only check.
   2. **#1960 (B-120, C-79b2 only):** switch `pipeSpeedChecks.sizingReadsMaterialTable` ON. Table: uPVC 3.0, concrete 6.0, metal 4.0, unknown 6.0 m/s, "house rule", on Settings (`designStandards.scourVelocityByMaterial`). OFF = 6.0 everywhere in those two places. **Engineering result change:** a uPVC connection pipe on a high flow can come out ONE SIZE LARGER. Changed shipped figure: smoke set S1 applies.
5. **Suggested class: Modify** for both.
6. **Prompts and windows:** #1949 row text: "outlet pipe top is 130 mm above the inlet pipe top (10.280 against 10.150): the pipe gets bigger, so the outlet invert needs to be lower". Fix suggestion: "Lower the outlet IL so its top is not above the inlet top". #1960: the existing strip warns on a uPVC pipe above 3.0 m/s; no new wording found.
7. **Selection:** #1949 reads the pit's arriving pipes and its one selected main outlet. #1960: the pipe you open.
8. **Preview:** #1960: the Edit Pipe grade strip updates as before with the new limit. #1949: none.
9. **Drawing output:** #1949 reads the project record only; no drawing write. #1960: warnings and sizing only; never a block. Neither touches locked layers, Xrefs or REFEDIT in the log's wording. Only a pit with one outlet and every invert and diameter present is checked; otherwise nothing is said. Several arriving pipes: the lowest arriving top is used.
10. **Cancel, Escape, Undo and Redo:** #1949: read-only, nothing to undo. #1960: auto-design inserting a pipe undoes as usual (GUESS: one Undo; not read).
11. **Save and reopen:** nothing new is saved; the warning is recomputed.
12. **Assets, data and Settings:** the table values come only from Settings (a typed figure moves both places). No tolerance in #1949 (zero, no engineering value in code). Network-wide sizing screens and the `pipeSpeedChecks.useMaterialLimit` switch (BUG-527, default OFF) keep today's behaviour. The CD pit-drop suggestion on a new pipe does not use the obvert yet (stated gap).
13. **Performance:** one extra row per pit in the rule check; 510 related tests passed (author's number). Not measured on a large drawing.
14. **Discovery:** warnings appear in the check lists; the Settings page shows the speed table. No Help page text found.
15. **Example and expected result:** (a) 150 pipe arriving at 10.000 (top 10.150), 300 leaving at 9.980 (top 10.280): 20 mm drop passes the old check; now also "outlet pipe top is 130 mm above the inlet pipe top". (b) uPVC DN150 at about 4 m/s: flagged with the switch ON (3.0), not flagged OFF.
16. **Older family card:** `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md` (not read in this pass) and CV-01 CV5 ("advisory until the engineering rulebook is verified"). They no longer cover the obvert warning or the single speed table.
17. **Tim's AutoCAD checklist:**
    1. Place a pit with a 150 pipe arriving at 10.000 and a 300 leaving at 9.980.
    2. Type CDRULES (or use Checks if the switch is on). Expect the 130 mm row under R-08.
    3. Set the 300 outlet to 9.860: expect the row gone.
    4. Open a uPVC DN150 pipe in CDEDIT carrying about 4 m/s: expect a speed warning in the grade strip.
    5. Run CDDESIGN on a uPVC connection with high flow: expect one size larger than on C-78.
    6. Set the two switches false, restart: expect the old results.
18. **Questions only Tim can answer:**
    1. **CPAA 8 m/s against house 6.0 for concrete.** Context: the CPAA manual gives 8 m/s for precast concrete pipe and states no uPVC figure; #1960 ships the house table (R-01, your plan rule). Recommendation: keep 6.0 until you decide, because the table is on Settings and one figure moves both places. On a job: a concrete 450 at 7 m/s warns against 6.0 and would pass against 8.
    2. **Is a one-size-larger uPVC connection pipe acceptable?** Context: R-01 already decided the table; this is the visible effect. Recommendation: yes, since the pipe was previously checked against a looser limit than the rest of Edit Pipe.
19. **NOT proven:** Built: yes. Tested: unit tests (Bug907PitObvertWarningTests, Bug80OneVelocityTableTests, 7 tests). Installed: #1949 on C-79a 3.0.89 per the register; #1960 NOT installed. Tim-accepted: no. BUG-907 and BUG-80 stay open. The CPAA 8 against 6.0 question is open.
