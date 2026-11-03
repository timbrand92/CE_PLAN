# CARD DRAFTS 3 of 15: LABELS AND TIDY (Civil)

Written Mon 2 Nov 2026, Melbourne time, by Sonnet 5.5 (Team, read-only) for CE 05 at CE 00's request. Only this file was written. Nothing was built, tested, installed or opened in AutoCAD. The robot was not run. Tim's real settings files were not read or written. Every card below is **DRAFT FOR TIM: nothing is approved.**

## FOR TIM

1. **Five cards** follow, one for each command or workflow you listed: Tidy labels with the automatic tidy after a pit MOVE, the after-MOVE tidy Settings row, the pit-label double-click, label angle and sizes, and the copy workflow. Each is built from the pull-request text, the Opus reviews, the finalizer reports and the code on the branches. None is approved.
2. **Which branch each fix is on.** Only #1867 (a pit copied on top of a pit) is on `claude/rel-20261102a` itself (C-78, Civil 3.0.88). #1875 and #1888 are on `rel-20261106a` (C-79a). #1891 and #1923 are on `rel-20261108a` (C-79b1). #1946 is on `rel-20261110a` (C-79b2). #1975 to #1980 are only on `rel-20261112a` (C-79c). Nothing from C-79b or C-79c is installed yet.
3. **Could not pin down:** (a) the exact Settings tab name for the after-MOVE row on the current line (an earlier review says "Drafting tab"; I did not re-read the tab headers); (b) the exact words CE prints when a copied downpipe's label layer is locked; (c) what "CR" means in your bug notes (I read it as ROTATE with the Copy option).
4. **A stale-words problem you should know about.** The code comments and the ribbon tooltip text still say Tidy labels is "OFF until Codex passes it". The Settings code says it is ON by default (your 29 Oct ruling). I trust the Settings code. The words should be cleaned up.
5. **One result in your favour to confirm:** the C-79c finalizer set the re-test class to AREA, not FULL as the Opus review (AF) advised. That follows your decision 148 ("No full re-test at all"). The tidy after every pit MOVE therefore ships with the area run only.
6. **Questions that need you** (batched, with a recommendation each): the pit-label double-click default and whether it gets a Settings tick box; whether a pit-label tidy that slides a label off its own pipe is what you want after every MOVE; whether "printed size same as a millimetre drawing at the same DIMSCALE" is what you meant for metre drawings; whether copied downpipes with a locked label layer should print a line. See field 18 of each card.
7. **Read:** RULES.md, the Opus reviews AF, J, R, S, T, the final re-check and D, the C-79a, C-79b and C-79c lists and reports, the build register, the carpark entries, the family cards, and the code on the branches (Tidy labels command, summary wording, Settings code, double-click rule, ribbon, command registry, Settings dialogs, label-unit rule).
8. **NOT proven:** nobody has opened any of these changes in AutoCAD as a test. Built: yes for all. Unit-tested: yes. Installed: #1867 (C-78), #1875 and #1888 (C-79a) only, and the install of C-79a was smoke-tested by the robot on other cases. Tim-accepted: none. Every related bug is still OPEN.

---

## CARD 1. DRAFT FOR TIM: nothing is approved. Tidy labels, and the automatic tidy after a pit MOVE

1. **Name, and what it does for a drafter.** "Tidy labels" slides CE pipe labels, invert texts and flow arrows that sit on other text to the nearest clear spot. A smaller version of the same tidy runs by itself at the end of every pit MOVE.
2. **Ribbon or trigger.**
   1. **Ribbon:** tab **CE** (called **CE Civil** if classic tabs are on), panel **Edit**, button **Tidy labels** (key tip TL). Typed: **CDTIDYLABELS**.
   2. **Automatic part:** no trigger. It runs at the end of MOVE, STRETCH, grip moves and the other edit commands, and when a pipe is drawn, Edit Pipe is saved, Edit Pit changes size, or a pipe is split by a source.
3. **Works today.**
   1. **Tidy labels** counts first and writes nothing. Enter at the first prompt means All pipes in the current space. Only a typed Yes moves anything. Labels placed by hand, labels on locked layers and references are left alone. One U puts every label back.
   2. **After a MOVE** the same placement rule slides the moved pit's own labels off other text and prints a line for each ("no clear spot ... left where it is").
   3. **Keep would protect:** count-first, Yes-default-No, one U, hand-placed labels never touched.
4. **What the train or PR changes.** All six are only on `rel-20261112a` (C-79c), none on `rel-20261102a`. All six new switches are ON. They sit in the `linking` group of the Settings file. None has a Settings tick box (I found no row in the Settings window code).
   1. **#1975 (BUG-1253 and BUG-1034), switch `linking.tidyKeepsLabelsOffOwnPipeStrip`, ON.** Text lying across its OWN pipe's blue strip now counts as a clash and is slid to the nearest clear spot. Runs after every pit MOVE for every colleague and on Tidy labels. A spot on the text's own strip is no longer offered. Callouts (MLeaders) are not measured.
   2. **#1976 (BUG-1161), `linking.movedLabelKeepsKeptWording`, ON.** "APPROX." (the kept wording before and after the value) stays when a label is moved, flipped or gripped. The Opus review says the visible effect may be nil.
   3. **#1977 (BUG-873), `linking.tidyLabelsWritesNothingUntilYes`, ON.** Answering No, pressing Esc, refusing the switch-on or getting "nothing to move" leaves the drawing as it was. The drawing is stamped as a CE drainage drawing only after Yes.
   4. **#1978 (BUG-890), `linking.tidyLeaderOutKeepsPlainLabelsPut`, ON.** Only matters when "move a crowded label out with a leader" is on (it is OFF by default). A callout is no longer planned onto a plain label that stays.
   5. **#1979 (BUG-891), `linking.tidyScanCoversOwnSpaceAndFullReach`, ON.** A pipe drawn in a layout is checked against that layout's text. The wider search only matters if the leader-out distance is set above 1,550 mm (default 1,500 mm), so at default Settings it changes nothing.
   6. **#1980 (BUG-962), `linking.tidyScanUsesWindowIndex`, ON.** Same answer, found faster on big drawings. The time saved is not measured.
   7. **Master switch:** `linking.tidyLabelsEnabled` is ON by default (your 29 Oct ruling, B-008). OFF means the button and the typed command only say it is switched off and offer to switch it on.
   8. **Class on the line:** the C-79c finalizer set AREA (decision 148). Opus AF had said FULL.
5. **Suggested class: Modify.** The command's behaviour is kept; six things around it change, one of them (#1975) on every pit MOVE. Suggestion only.
6. **Prompts and windows (exact wording from the code).**
   1. `Tidy labels on [All pipes/Select pipes] <All>:`
   2. If switched off: `[CE] Tidy labels is switched off. Nothing in the drawing was changed.` then `Switch Tidy labels on for this computer now?` (Yes/No, default No).
   3. Count line: `[CE] Will move N · Placed by hand (left alone) N · No clear spot found N` (plus `· On a locked layer (left alone) N` when there is one). Up to 20 lines such as `<label> would move <distance> (<spot name>).`
   4. `Move these N labels now?` (Yes/No, default No; "this label" when N is 1).
   5. After Yes: `[CE] Moved N · ... . Type U once to put every label back.` A pass over 2 seconds adds `That took X.X seconds.`
   6. Nothing to do: `[CE] No CE label needs to move.` No pipes: `[CE] No CE pipes were found in Model space. Nothing was moved.` (or "on this layout", with advice to switch tab).
   7. No window opens.
7. **Selection.** Enter or All takes every CE pipe in the current space only (Model, or the layout you are in). Select lets you pick pipes ("Select pipes to tidy:").
8. **Preview.** A text count and a list on the command line. No ghost picture (the plan still lists a preview window with ghosts as "Codex").
9. **Drawing output.**
   1. **Drawn:** the label text moves; its record is rewritten. The pipe itself never moves. No new objects.
   2. **Protection (read from the code, not seen in AutoCAD):** a text on a locked layer, or any record not marked "Update", gets no spot and is never moved (and is now listed as "no clear spot" after a MOVE, where before it was silent). Xrefs are read only as obstacles. Nothing is written to an Xref or a REFEDIT object; with REFEDIT open Tidy labels says `[CE] Tidy labels is not run while a reference is being edited. Nothing was moved.` A pipe on a locked layer stops the pass with one line.
   3. **Measuring writes nothing:** a copy of each text is turned and measured outside the drawing, then thrown away.
10. **Cancel, Escape, Undo and Redo.** No, Enter at the Yes question and Esc change nothing (with #1977 ON, the stamp is not written either). The automatic tidy runs inside the MOVE's own Undo step, so one U takes back the MOVE and the text the tidy moved together; the finalizer read this from the code and did not see it in AutoCAD. One U after Tidy labels Apply takes back every label. REDO after No has not been driven.
11. **Save and reopen.** Moved labels are ordinary drawing changes and save normally. After Yes with #1977 ON, the CE record is bound without saving at that moment and is saved by the normal save (the Opus review notes the change-log wording says otherwise; wording only).
12. **Assets, data and Settings.** Reads the six switches above, `tidyLabelsEnabled`, `tidyTextAfterMove`, `tidyLeaderOut` (OFF), `tidyLeaderOutMaxMm` (1,500) and the label slide settings. Writes the pipe records. One log line per pass: `[PERF] CDTIDYLABELS count/apply: N ms for N picked pipe(s)`.
13. **Performance.** #1980 should make big drawings faster; **not measured.** The Yes pass still scans again. #1975 adds a text measurement for every label near a moved pit.
14. **Discovery.** Ribbon button with tooltip "Counts first and moves nothing until you answer Yes ..."; typed CDTIDYLABELS; a Help card in CDHELP ("Tidy labels", I saw its first line only).
15. **Example drawing and expected result.** Use the drawing the robot calls the G5 copy. MOVE pit P3 by 0,2000 (2 m up). **Before #1975:** the upper-left IL text can end up lying across P3's own blue pipe (BUG-1253). **After:** that IL text sits clear of the pipe strip, which for a 225 mm pipe means its box does not touch the 112.5 mm either side of the centreline. The other four invert texts, the pit number circle and the cover text keep their old positions (Opus asks for this check; it is the main risk, because a normal invert text sits only about 70 mm clear and could be judged touching).
16. **Older family card.** `C:\Lisp Files\CE_ACAD_PLUGIN\docs\workflows\C2_EXACT_PIPE_LABEL_PREVIEW_2026-09-09.md` is about the wording of the main pipe label, not about sliding labels. It says nothing about the tidy after a MOVE, own-pipe-strip clearance, the No/Esc rule or layouts. The Tidy labels design lives in "Batch 1 card 1.4 (UX-LBL-03)", which I did not find as a file; the code comments quote it. `CV-01_DRAINAGE_NETWORK.md` was not re-read in full (GUESS: it does not cover these changes either).
17. **Tim's AutoCAD checklist.** (Use a copy of a real job; C-79c is not installed yet.)
    1. Open the copy. In the **CE** tab, **Edit** panel, click **Tidy labels**. At the first prompt press Enter.
    2. Read the count line. Press Enter at "Move these N labels now?" (default No). Expect `[CE] Nothing was moved.` Type **DBMOD** and note it is the same as before you started (this is the #1977 check; the Opus review says the count pass may still move it).
    3. Run Tidy labels again, answer **Yes**. Expect "Moved N ... Type U once ...". Type **U**. Every label returns.
    4. Type **MOVE**, pick pit P3, base point 0,0, second point 0,2000. Look at P3's invert texts: none should lie on its blue pipe. Look at the other pits' labels: none should have jumped.
    5. Type **U**, then **REDO**. The MOVE and the text slide come back together.
    6. Lock the layer of one pipe label and repeat step 1 to 3. Expect that label to stay and a "locked layer" count.
18. **Questions only Tim can answer.**
    1. **Context:** #1975 makes CE move text it never moved before, after every pit MOVE.
       **What I understand:** you want invert text clear of its own pipe (BUG-1253: "none of the texts newly sits on a pipe strip"; BUG-1034: "clear of the pit AND of its own pipe line").
       **Recommendation:** keep it ON, because the expected lines you wrote ask for it, and look at one picture of a moved pit first.
       **On a job:** ON means a moved pit's labels may step out a lane; OFF means they can sit on the pipe as today.
    2. **Context:** a hand-picked label position is protected only if CE recorded it as placed by hand.
       **Recommendation:** accept for now and check a label you picked onto the pipe when drawing.
       **On a job:** otherwise it could be moved off the pipe after the next MOVE.
19. **NOT proven.**
    1. **Built:** yes. All six PRs merged on `rel-20261112a`; the finalizer's full Civil net10 run was 22,708 tests, 0 failed (32 skipped); net48 focused had 133 failures the finalizer calls known.
    2. **Tested:** unit tests only. The service wiring of #1975 runs only inside AutoCAD. Robot cases are drafted; I found no record they have run on a C-79c build.
    3. **Installed:** no. C-79c is not installed.
    4. **Tim-accepted:** no. Nobody has driven it.
    5. **Open:** BUG-1253, BUG-1034, BUG-1161, BUG-873, BUG-890, BUG-891, BUG-962 all stay OPEN. Nobody has checked that normal labels do not move after a MOVE.

---

## CARD 2. DRAFT FOR TIM: nothing is approved. After-MOVE label tidy gets its own Settings row

1. **Name, and what it does for a drafter.** A tick box that says whether CE slides its labels off other text after a MOVE, STRETCH or other AutoCAD edit, and says so on the command line.
2. **Ribbon or trigger.** Settings, not a command. Open Settings from the ribbon **Settings** panel ("Open Settings on the last page you used", typed **CDS**), then the page that holds **KEEPING LABELS CLEAR**. An earlier review calls this the **Drafting** tab (I did not re-read the tab headers). In the Civil settings view the same box sits in a group headed **AFTER AN EDIT COMMAND**. Where it sits is not signposted from the Tidy labels button.
3. **Works today.** The tidy after a MOVE runs always (your D9, 14 Sep). The line "no clear spot among its usual positions, left where it is" prints with no way to switch it off (BUG-816, your report of 18 Oct).
4. **What the train or PR changes.** PR #1875 (B-025, BUG-816), on `rel-20261106a` (C-79a), not on `rel-20261102a`.
   1. **Switch:** `linking.tidyTextAfterMove`, ON by default. Same behaviour as today until someone unticks it.
   2. **Box wording on the line:** "After a MOVE, STRETCH or other AutoCAD edit, CE slides its labels off other text, and says so on the command line".
   3. **What the box covers (after the fix passes B-025b and B-025c):** MOVE, STRETCH, ROTATE, SCALE, TRIM, JOIN, grip edits, and also BREAK, MIRROR, COPY, OFFSET, ARRAY, EXPLODE and paste of a CE pipe. It does NOT stop: drawing a pipe (CD), Edit Pipe save, Edit Pit size change, a split by a source, and Tidy labels. The tooltip says so.
   4. **Tidy labels default (B-008):** `linking.tidyLabelsEnabled` is ON by default for new installs and any file without the key (your 29 Oct ruling). A file that says false keeps false.
5. **Suggested class: Modify.** The behaviour is unchanged by default; a control is added. Suggestion only.
6. **Prompts and windows.** Settings window only. The tooltip reads, in part: "This is not the Tidy labels command. Off = after those edits nothing is moved and no line is printed ... Default: on." Nothing is typed.
7. **Selection.** None.
8. **Preview.** None. The tick box shows the "changed" mark when changed (the page uses a change marker).
9. **Drawing output.** None by the row. Unticked, the automatic slide and its command-line lines are skipped on those edit routes. The mark that records a label as placed by hand is still written, so hand-moved labels stay protected. Locked-layer, Xref and REFEDIT behaviour is unchanged.
10. **Cancel, Escape, Undo and Redo.** Settings Cancel discards the change. Nothing in the drawing to undo. Note: labels still travel with the pit end when the box is OFF; only the extra slide-clear step stops (BUG-1252, half-distance, is a different bug).
11. **Save and reopen.** Saved in the Settings file for this computer, read at AutoCAD start (a setting changed mid-session does nothing until restart: memory note from 19 Oct, written for the settings guard; I did not re-check that this row works the same way).
12. **Assets, data and Settings.** Reads/writes `tidyTextAfterMove` in the `linking` group. Written by Apply on the Settings window.
13. **Performance.** No change.
14. **Discovery.** Only by opening Settings. The tooltip explains it. I did not find a Help page for this row (GUESS: none).
15. **Example drawing and expected result.** Tick OFF, then MOVE pit P3 by 0,2000. Expect **no** "no clear spot" line and no "label: moved" line; labels still follow the pit end. Tick ON (default), same MOVE: the "pipe P3 -> P2 label ..." lines print as before. With the box OFF, draw a new pipe with CD into a pit: its start invert text should still slide clear (draw is not switched off).
16. **Older family card.** `docs\workflows\C2_EXACT_PIPE_LABEL_PREVIEW_2026-09-09.md` does not cover Settings or the tidy. Nothing in docs\CARDS or docs\workflows names this row (GUESS from file names; I did not read all 60 files).
17. **Tim's AutoCAD checklist.**
    1. Open **Settings** (ribbon **Settings** panel). Find **KEEPING LABELS CLEAR** (or **AFTER AN EDIT COMMAND**). Read the box and hover for the tooltip.
    2. Check the whole page fits with no scroll bar at your usual zoom (the tallest tab is meant to fit about 670 px; not measured).
    3. Untick, Apply, **close and restart AutoCAD**, open a copy, MOVE P3 0,0 to 0,2000. Expect no "no clear spot" line.
    4. Tick it again, Apply, restart, repeat. Expect the lines back.
18. **Questions only Tim can answer.**
    1. **Context:** unticking leaves COPY, MIRROR, ARRAY and paste with no slide too.
       **What I understand:** the tooltip now lists them, but the row text says only "MOVE, STRETCH or other AutoCAD edit".
       **Recommendation:** accept; the tooltip covers it.
       **On a job:** a drafter who unticks to quieten MOVE messages will also lose the slide after a copy.
    2. **Context:** the row is not near the Tidy labels button.
       **Recommendation:** leave it where it is; add a line to the Tidy labels Help card.
       **On a job:** a drafter wondering why a label moved will not find the box without being told.
19. **NOT proven.**
    1. **Built:** yes (focused 319 passed; full Civil net10 about 20,805 passed at the PR's time).
    2. **Tested:** unit tests and the Settings page height test (reported by the author; the Opus reviewer could not verify the measured height).
    3. **Installed:** yes, in C-79a (Civil 3.0.89) per the register; I did not check the DLL's product-version string. The robot's C-79a smoke run passed 39 cases, none of which I know covers this row.
    4. **Tim-accepted:** no. BUG-816 stays OPEN.

---

## CARD 3. DRAFT FOR TIM: nothing is approved. Double-click on a pit label stops AutoCAD's attribute editor first

1. **Name, and what it does for a drafter.** Double-click the pit's label (the P8 text block) and CE's **Edit Pit** window opens straight away, without AutoCAD's Enhanced Attribute Editor appearing first.
2. **Ribbon or trigger.** No button. It is a double-click on a pit label in Model space. It only works when two switches are ON (see field 4).
3. **Works today.** A pit, a pipe, a DP/IO/OF/FO/TG source and their labels and level text already open CE's edit window on double-click. A pit label still opens AutoCAD's own attribute editor (the code comment: "exactly the installed 3.0.51 behaviour").
4. **What the train or PR changes.** PR #1923 (B-110, BUG-430), on `rel-20261108a` (C-79b1), not on `rel-20261102a` or `rel-20261106a`.
   1. **Switch:** `doubleClick.pitLabelStopsAttributeEditorFirst`, shipped **OFF** (`PitLabelStopsAttributeEditorFirstDefault = false`, read on the line). Your 22 Oct ruling was that it stays OFF until a Codex look.
   2. **It also needs** the master switch `doubleClick.opensEditWindow`, which is OFF. So with both at default, nothing changes for anyone.
   3. **When ON:** CE stops AutoCAD's attribute editor before it opens, so Edit Pit is the only window, and a border, title block or Xref plan around the label no longer makes CE back off.
   4. **History:** the first version shipped ON; CE 05's fix (head 454e3eab) made it OFF and CE 01 verified it in the PR diff. The C-79b1 assembler merged it only on that basis. The merge was last in the list.
5. **Suggested class: Keep (shipped as a dormant fix).** The switch is OFF, so today's behaviour is protected; turning it on is a later Modify. Suggestion only.
6. **Prompts and windows.** No CE prompt. When it fires, Edit Pit opens. One log line only: `TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-430, doubleClick.pitLabelStopsAttributeEditorFirst); pit label`.
7. **Selection.** The label under the pointer must be a linked pit label (the label names its pit AND the pit lists the label). A double-click a moment ago is required, so a typed EATTEDIT, the ribbon button and Ctrl+1 keep AutoCAD's editor.
8. **Preview.** None.
9. **Drawing output.** None by the double-click itself. Edit Pit's own Apply writes as it does today. **Protection (read from the rule):** a label or pit on a locked layer, an Xref block, and anything during REFEDIT keep AutoCAD's own answer; CE never reaches past them.
10. **Cancel, Escape, Undo and Redo.** Closing Edit Pit without Apply changes nothing. Undo is Edit Pit's own. The earlier DBText double-click card says Escape before saving leaves the drawing unchanged; the same engine applies (GUESS: not re-read for this PR).
11. **Save and reopen.** Nothing saved by the double-click. The cache of which labels belong to which pit must be ready for the first double-click after reopen (the older card lists that as a check).
12. **Assets, data and Settings.** Reads `doubleClick.opensEditWindow` (OFF) and `doubleClick.pitLabelStopsAttributeEditorFirst` (OFF). File only; I found **no** Settings window row for either (zero Settings dialog or view-model files mention the switch).
13. **Performance.** No scan: the check reads the per-drawing owner cache and the label under the pointer. Not measured.
14. **Discovery.** None. A drafter cannot find it; it is a double-click.
15. **Example drawing and expected result.** Both switches true before AutoCAD starts. Double-click the label "P3" on a pit drawn inside a border block. **Expected:** the Edit Pit window opens for P3 with no attribute-editor window before it. Control: pit-label switch false: AutoCAD's attribute editor may open first (the BUG-430 symptom).
16. **Older family card.** `docs\workflows\C0_EXACT_DBTEXT_DOUBLE_CLICK_2026-09-13.md` covers invert text (DBText) owning one pipe. It says nothing about attribute blocks (the pit label is a block with attributes: "Ordinary DBText and attributes ... pass to AutoCAD unchanged"), nothing about stopping EATTEDIT before it opens, and nothing about the two-switch rule.
17. **Tim's AutoCAD checklist.** (Needs a build with C-79b1; do not set the switches in your real settings: use a copy, set both before launch.)
    1. Start AutoCAD with `opensEditWindow` and `pitLabelStopsAttributeEditorFirst` both true in the copy's settings.
    2. Double-click a pit label. Expect Edit Pit only; no attribute editor.
    3. Press Esc or Cancel in Edit Pit. Expect nothing changed.
    4. Put the label on a locked layer and double-click. Expect AutoCAD's own editor.
    5. Run REFEDIT on a block and double-click. Expect AutoCAD's own editor.
    6. Double-click a plain block attribute that is not a pit label. Expect AutoCAD's editor.
    7. Restart with both switches false. Expect today's behaviour.
18. **Questions only Tim can answer.**
    1. **Context:** the shipped default is OFF per your 22 Oct word.
       **Recommendation:** keep OFF until a Codex look, then turn it on in one commit with the pass.
       **On a job:** OFF means a pit-label double-click may still show AutoCAD's attribute editor first.
    2. **Context:** there is no Settings row, so a colleague cannot turn it on.
       **Recommendation:** add a row when it is turned on; not before.
       **On a job:** without a row, only a file edit enables it.
19. **NOT proven.**
    1. **Built:** yes, on `rel-20261108a`.
    2. **Tested:** unit tests of the rule, the default and the switch reads; the C-79b1 finalizer's runs. No real double-click has been driven.
    3. **Installed:** no. The C-79b1 install was cleared to go at about 14:40 today; I found no record that it finished.
    4. **Tim-accepted:** no. The robot case N95_pitlabel_dblclick needs both switches true before launch. BUG-430 stays OPEN.

---

## CARD 4. DRAFT FOR TIM: nothing is approved. Pipe label angle in a turned UCS, and label sizes in a metre drawing

1. **Name, and what it does for a drafter.** (A) When you move a pipe label with a turned UCS, the label lies along the pipe. (B) In a drawing in metres, label text heights and offsets are the right size instead of 1,000 times too big.
2. **Ribbon or trigger.**
   1. **(A)** Typed **CDTEXTSEG** ("Move Text Segment"; hidden from the ribbon, command line only), the pick-a-point-to-move-pipe-text prompt in CD, and the Edit Pipe attachments route.
   2. **(B)** No trigger. It applies to new labels from CD, PIT, LPD, the text tools and X-Civil import, and to the pit hover.
3. **Works today.** (A) With the UCS turned 45 degrees, CDTEXTSEG places the label in the right spot but writes a 0-degree angle, so back in World the pipe runs at 45 degrees and the text is flat. (B) In a millimetre drawing label sizes are right (text 250, offset 125).
4. **What the train or PR changes.**
   1. **(A) PR #1888 (B-072, BUG-1195)**, on `rel-20261106a` (C-79a). Switch `linking.pipeTextMoveAngleFollowsUcs`, ON; OFF is the old angle exactly. The angle is now measured in World, like the position.
   2. **(B) PR #1946 (B-126, BUG-321)**, on `rel-20261110a` (C-79b2). Switch `options.labelSizesReadDrawingUnits`, ON; OFF uses the millimetre numbers as drawing units, exactly as before. In a metre drawing: pipe label text 0.25 (was 250), level text 0.18, label offset 0.125, flow-arrow offset 0.125, pit hover 0.45. Millimetre and unitless drawings are multiplied by 1.0, unchanged. Labels already drawn keep their height.
5. **Suggested class: Modify** for both (small corrections to existing placement). Suggestion only.
6. **Prompts and windows.** No new ones. CDTEXTSEG's existing pick prompts. No messages added by either PR.
7. **Selection.** (A) Pick the pipe leg and the new label position as today. (B) None.
8. **Preview.** None.
9. **Drawing output.**
   1. **(A)** The label's rotation is written, in the same place as before. The locked-layer handling (BUG-284) is unchanged. No new write.
   2. **(B)** New label heights and offsets only; no object is rewritten. **Not converted, so mixed in a metre drawing:** the manual text offset (70) and the X-Civil import offsets (a 160 minimum). X-Civil import in a metre drawing would put a 0.25 text 160 m from its pipe (already wrong before; the size is now right and the offset still wrong).
10. **Cancel, Escape, Undo and Redo.** No new write path in either PR; CDTEXTSEG's own Esc and U apply (GUESS: not driven).
11. **Save and reopen.** Heights and rotations are ordinary drawing values and save normally.
12. **Assets, data and Settings.** (A) `linking.pipeTextMoveAngleFollowsUcs`. (B) `options.labelSizesReadDrawingUnits`, the drawing's INSUNITS, and the existing `pipeTextHeight` setting. A person who typed `pipeTextHeight` 0.25 in Settings to work around metre drawings would now get 0.00025. Neither switch has a Settings row.
13. **Performance.** (B) The pit hover now reads the switch and the drawing units on every cursor move; cheap, not measured.
14. **Discovery.** None for (A). (B) none; it just looks right. Neither is in a Help page I could find.
15. **Example drawing and expected result.**
    1. **(A)** Set the UCS 45 degrees about Z (`UCS` Z 45), then `PLAN` Current. CD a pipe from World 0,0 to 10000,10000. Run CDTEXTSEG and pick the leg. **Expected:** label rotation 45 degrees in World. **Steep pipe:** CD a pipe from 0,0 to -3000,10000 (about 106.7 degrees in World); the label should read the right way up on screen at about 107 degrees, but this PR judges "readable" in World, so on a turned screen it may read upside down (Opus finding D: not tested; the PR is kept as is, with a follow-up if it reads upside down).
    2. **(B)** Start a drawing with INSUNITS metres, at DIMSCALE 100. CD a pipe. **Expected:** pipe label text 0.25 and level text 0.18; at 1:100 they print 25 mm and 18 mm high, the same as a millimetre drawing at the same DIMSCALE. The author did NOT multiply by DIMSCALE again (millimetre drawings do not either). CE 04 is to confirm against your 20 Oct ruling 12 ("label sizes follow DIMSCALE").
16. **Older family card.** `docs\workflows\C2_EXACT_PIPE_LABEL_PREVIEW_2026-09-09.md` covers the label wording only. It says nothing about angle in a turned UCS or label sizes in metre drawings. `C7_PIPE_LINKAGE_MODEL_2026-09-16.md` was not re-read (GUESS: not about these).
17. **Tim's AutoCAD checklist.**
    1. **(A)** In a copy: type `UCS`, then `Z`, then `45`. Type `PLAN`, Enter for Current. Draw a pipe with CD from 0,0 to 10000,10000. Type **CDTEXTSEG**, pick the leg and a point. Set `UCS` World. The label should run parallel to the pipe.
    2. **(A)** Repeat with a pipe from 0,0 to -3000,10000. Screenshot the turned view. Note whether the label reads upside down on screen.
    3. **(B)** Start a metre drawing (`UNITS`: metres). Draw a pit and a pipe with CD. Check the text height in Properties (0.25) and that the label sits close to the pipe, not 125 m away.
    4. **(B)** Repeat in a millimetre drawing. Heights should be 250 as before.
18. **Questions only Tim can answer.**
    1. **Context:** in a turned view, a label judged readable in World may read upside down on screen.
       **Recommendation:** accept as shipped; fix after a picture if it shows.
       **On a job:** drafters who work in a turned UCS may see an upside-down label on steep pipes.
    2. **Context:** DIMSCALE (see 15.2).
       **Recommendation:** confirm that "the same printed size as a millimetre drawing at the same DIMSCALE" is what you meant.
       **On a job:** if you meant sizes to scale again with DIMSCALE in metre drawings, they would print 100 times too large at 1:100.
    3. **Context:** the 70 and 160 offsets are not converted in a metre drawing.
       **Recommendation:** list as a known gap; fix separately.
       **On a job:** manual-placed labels and X-Civil imports in a metre drawing look wrong.
19. **NOT proven.**
    1. **Built:** yes (#1888 on `rel-20261106a`, #1946 on `rel-20261110a`).
    2. **Tested:** unit tests (angle maths, 13 label-unit tests). The wiring of #1888 is covered by a source check only. Nothing driven in a turned UCS or a metre drawing.
    3. **Installed:** #1888 yes (C-79a, 3.0.89; DLL version not re-checked). #1946 no.
    4. **Tim-accepted:** no for both. BUG-1195 and BUG-321 stay OPEN.

---

## CARD 5. DRAFT FOR TIM: nothing is approved. The copy workflow: a copied downpipe gets its own tag, and a pit copied on a pit keeps off the original's pipes

1. **Name, and what it does for a drafter.** When you COPY, ROTATE with Copy, SCALE with Copy or grip-copy CE objects, the copy is its own object: a copied downpipe takes the next free tag (DP3), and a pit copied exactly on top of another pit does not take that pit's pipe ends.
2. **Ribbon or trigger.** No CE button. It runs by itself at the end of AutoCAD's own COPY, ROTATE (option **C**), SCALE (option **C**), and grip copy, through the CE copy clean-up.
3. **Works today.**
   1. **Pit copied 5 m away:** behaves correctly, no messages.
   2. **Copy on a loose pipe end:** still joins it.
   3. **Downpipe copied with an exact AutoCAD copy record:** gets a fresh identity. When AutoCAD gives no exact record (your CR in hand check H39), the copy stayed DP2 and CE printed "could not be given its own link on this AutoCAD" (BUG-1246; your word on 29 Oct: "dp2").
   4. **Keep would protect:** the clean-up of copied pipes, attachments and slab boundaries described in the older card, and a copy away from the original.
4. **What the train or PR changes.**
   1. **PR #1867 (B-049a, BUG-1227), on `rel-20261102a` (C-78).** Switch `linking.pitCopyKeepsOriginalPipeEnds`, ON; OFF is today's behaviour exactly. A pit copied on top of another pit no longer takes the original's pipe ends. The original keeps all its pipes; the copy gets none. One line is printed: `P11 sits on pipe ends already joined to P3; they stay joined to P3.` One line per copy command. **Design note:** every pit that is not already joined to a pipe end holds back, not only the new copy, so a second copy on the same spot (SCALE Copy after ROTATE Copy) cannot take the pipes either. The message names only the new copy.
   2. **PR #1891 (B-071, BUG-1246), on `rel-20261108a` (C-79b1); needs #1867, which is in C-78.** Switch `linking.copiedDownpipeGetsOwnTag`, ON; OFF is the old behaviour. The copy takes the next free tag, the same number New DP would give. It gets a fresh identity, its own record (links to the original's pit and pipes cleared) and its own plan label. Line: `[CE] The copied downpipe was given its own tag DP3 (the original stays DP2). Check where it connects.` If the label's layer is locked, no label is drawn, the layer is not touched, and one line names the layer (exact wording not read; for two copies it reads "The label for DP3, DP4 was not drawn" per the Opus re-check).
5. **Suggested class: Modify** (both fix the copy clean-up; neither adds a command). Suggestion only.
6. **Prompts and windows.** No window, no question. The two lines above, on the command line.
7. **Selection.** Whatever the AutoCAD command takes. If the downpipe's old label is selected with the downpipe, AutoCAD copies it too; it would still read DP2. Nothing erases or re-links that stray label (Opus risk; the robot must run one copy with the label selected).
8. **Preview.** None.
9. **Drawing output.**
   1. **#1867:** pipe-end links in CE's record; no object is drawn. Nothing about the original pit changes.
   2. **#1891:** the copy's tag and record, and one new label text placed at a fixed distance up and right of the copy whatever the rotation. No layer is created.
   3. **Protection:** the label layer's lock is read first and never unlocked (fixed after Opus review S found it missing). The copied downpipe's own layer, Xrefs and REFEDIT go through the existing write gate. A copy that cannot be tagged falls back to the old line.
10. **Cancel, Escape, Undo and Redo.** The writes happen at the command's end, inside CE's clean-up. **Not proven:** whether one U removes only the retag or the whole copy; the robot must type U, read the result, then U again. The reviewed REDO list had six lines added for #1891.
11. **Save and reopen.** The tag and record are in the CE record and save normally. Reopen and check DP3 stays DP3 (not driven).
12. **Assets, data and Settings.** The two switches above (file only; no Settings row), CE's pipe and pit records, the label layer.
13. **Performance.** Part of the existing copy clean-up. Not measured.
14. **Discovery.** None. A drafter sees only the command-line line.
15. **Example drawing and expected result.**
    1. **ROTATE Copy on a pit (the robot's R34 drawing).** Pick pit P3. Type `ROTATE`, base point on the pit (53777.7,-25569.9), `C`, `90`. **Before:** six lines such as "Pit schedule cell for P3 ... not updated", and P11 takes P3's pipes. **After:** no such lines; one line `P11 sits on pipe ends already joined to P3; they stay joined to P3.`; P3 keeps all five pipe ends.
    2. **SCALE Copy next.** Pick P3 again. `SCALE`, same base point, `C`, `1.5`. **Expected:** one more line naming P12; P11 does not take P3's pipes either (before: nine lines).
    3. **Copied downpipe.** Downpipe DP2 on a pipe. `ROTATE`, base on the downpipe, `C`, `90`. **Expected:** the copy reads DP3, DP2 is unchanged, one line on the command line, a new green label near DP3.
16. **Older family card.** `docs\workflows\C1_COPY_IDENTITY_2026-09-07.md` covers new identities for copied pipe attachments and slab boundaries and says COPY Multiple gets one exact map per placement. It does not cover: giving a copied downpipe the next tag when AutoCAD gives no exact record; a copy placed exactly on the original pit taking its pipe ends; the "stays joined" line; or the locked label layer. It also lists a still-open item (a copied slab in listings) and Decision 80 (check every CE object kind for the same copy behaviour) is not met by #1891, which covers downpipes only.
17. **Tim's AutoCAD checklist.** (Use a copy; the C-79b1 build is needed for step 4 onward.)
    1. Pick pit P3. Type **ROTATE**, base point on P3's centre, type **C**, then **90**. Read the command line. Expect one line "P11 sits on pipe ends already joined to P3; they stay joined to P3." and no "Pit schedule cell ... not updated" lines.
    2. Open **Pit Schedule**: P3 still lists all its pipes.
    3. Pick P3 again. **SCALE**, same base point, **C**, **1.5**. Expect one line naming P12.
    4. Place a downpipe DP2 (ribbon **DP** button) on a pipe. Pick it. **ROTATE**, base point on it, **C**, **90**. Expect a copy named DP3, an unchanged DP2, and one line.
    5. Press **U**. Note what comes back (the retag only, or the whole copy). Press **U** again. Report both.
    6. Repeat step 4 with DP2's label also selected. Look for a stray "DP2" text.
    7. Lock the layer GUIDELINES (the label layer, as the robot case names it) and repeat step 4. Expect the copy tagged DP3 with no label and a line naming the locked layer.
    8. Copy a pit 5 m away (**COPY**). Expect no message and the normal result.
18. **Questions only Tim can answer.**
    1. **Context:** in #1867, when a copy lands on the original, the original keeps the pipes and the copy gets none.
       **What I understand:** that matches the expected behaviour in BUG-1227 ("may be disturbing the original's own record").
       **Recommendation:** keep, and check ROTATE Copy and SCALE Copy as above.
       **On a job:** a drafter who copies a pit on a pit to re-use it will have to join the copy's pipes after moving it.
    2. **Context:** with a locked label layer the copy is tagged but gets no label.
       **Recommendation:** keep (the tag matters most; the layer is never unlocked).
       **On a job:** the drafter must add the DP3 label by hand once the layer is unlocked.
    3. **Context:** Decision 80 asked for every CE object kind to be checked for copy behaviour; only downpipes are done.
       **Recommendation:** a separate card for the other kinds (pits, inlets, overflows).
       **On a job:** a copied overflow may still keep the original's tag.
19. **NOT proven.**
    1. **Built:** yes. #1867 on `rel-20261102a`; #1891 on `rel-20261108a`.
    2. **Tested:** unit tests (the P3/P11 example with real pit outlines, the copy 5 m away, the switch reads; 10 of 10 tests for #1891 at the PR). The REDO list guard had not been re-run by the author for #1891 and is to show in the train's full run.
    3. **Installed:** #1867 yes (C-78, Civil 3.0.88; DLL version not re-checked); #1891 no (C-79b1 install cleared at about 14:40 today, I found no record that it finished).
    4. **Tim-accepted:** no for both. The control and the robot case for #1867 are drafted (N36 with control C36); I found no run result. BUG-1227 and BUG-1246 stay OPEN.
