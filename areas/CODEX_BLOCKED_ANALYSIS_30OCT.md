# Codex blocked-looks analysis — Fri 30 Oct 2026, 06:20 to 09:33 Melbourne

Read-only analyst pass, written Fri 30 Oct 2026 (Melbourne). Installed build checked: Civil 3.0.86 / Manager 1.1.86
(commit 5888ee75), Structural 1.0.125. Source read at that commit (not master). BUG_CARPARK.md read only, not edited.
17 Codex reports read, plus screenshots and the CE logs Codex copied.

## FOR TIM

1. **The answer.** Of the 17 Codex runs, 4 show real faults in CE. 10 were held up by how the test was run, not by CE.
   1 is unclear. The rest passed.

2. **Real fault 1: Export to Excel does not work in AutoCAD 2027 (BUG-1255).** AutoCAD 2027 brings its own copy of
   the Excel-writing part (version 0.102.2). CE brings a slightly newer copy (0.102.3). AutoCAD's copy loads first,
   so CE's Excel export crashes and you only see "Pit Schedule rendering error". No file box appears. The same clash
   very likely hits Structural's Excel exports in 2027 too. This one matters for colleagues.

3. **Real fault 2: a hand-moved pipe label slides when its pit moves (BUG-1252, waiting on your question 19).** CE
   remembers each label as "halfway along the pipe, this far off it". Move the pit 500 mm and the middle of the
   pipe moves 250 mm, so the label moves 250 mm. The "hand-placed labels stay" switch is only read by Tidy labels,
   never by a pit move.

4. **Real fault 3: after a pit move, an invert text can land on its own pipe (BUG-1253).** Seen twice (G5 and C6).
   CE never counts a text's own pipe as something to keep clear of, so it does not notice. Same family as
   BUG-1034.

5. **Real fault 4 (small): the X-Civil import Close line uses code words (BUG-1256).** Close on the second page prints
   "Import aborted at pre-flight gate — no entities were inserted." The plain sentence only prints on the first page.

6. **Not a fault, probably: the CDCHECKDWG list "cut-off row" (BUG-1254).** A scrolling list always shows a sliver of
   the next row. The same window on the same build passed 90 minutes later (C6-01), and there the wheel scrolled.
   Recommend closing BUG-1254 as a test-wording fault.

7. **The test problems, in plain words.**
   1. **Typing went astray (H1, C1, and partly A1).** Codex typed before AutoCAD had settled. The text either went into
      the drawing as a paste, or AutoCAD's suggestion list swapped it for an AutoCAD command (COMMANDMACROSCLOSE) and
      Enter ran that.
   2. **The drawing never opened (H6).** AutoCAD sat empty for 103 seconds, so there was no ribbon to time.
   3. **The view was set up wrong (G6).** The copied pit's cover text was off the top of the screen.
   4. **The test asked for something CE does on purpose (H5).** "Work out design" is greyed out until every input is
      answered. The checklist on the window already showed "The council and its rules — Set", which is the
      thing the test wanted.
   5. **The screen tool cannot click inside the Help window (H2).** It is a separate web program. I read the
      installed help text directly instead: the Feedback words are already right (BUG-1215 is fixed in the files).
   6. **The cover box stayed blank (H4).** The same box took "19.000" fine in G7 two hours earlier, so the typing
      went somewhere else.
   7. **Picture saver and a stuck queue line (G4 first run, G3 first run).** Both reruns worked.

8. **One result to throw away.** A1 said "BUG-1086 not seen". But its Undo undid COMMANDMACROSCLOSE, not CE_VERSION,
   so it never tested BUG-1086.

9. **What I recommend next (one line).** Do the readings with the AutoCAD driver, not by typing. Give Codex a saved
   drawing that already has P8 and its pipe. Then rerun H1, C1, H4, H5, H6, G6, C6-04 and A1 (undo half only).

---

## Detail for the desk, look by look

Classification key: **(a)** real PRODUCT fault; **(b)** CODEX or TEST-FIXTURE fault; **(c)** unclear.

### 1. G3 06:21 — NOT TESTED

1. **Class:** (b) gate fault.
2. **Why:** queue.log held a START for verifyG1b_c84 at 20:56 the night before with no END. Gate 2.4 stopped the run.
   The 06:45 rerun passed, so nothing was lost but 4 minutes.
3. **Next time:** the launcher should write an END line when a job dies, or gate 2.4 should ignore a START older than
   3 hours when no acad.exe or accoreconsole.exe is running.

### 2. G7 06:27 — G7-01 FAIL (hand-placed description moved 250 mm when P8 moved 500 mm)

1. **Class:** (a) product. **BUG-1252** (exists, OPEN – ON HOLD for Monday question 19).
2. **Cause found in source:**
   1. Each pipe label is stored as segment + fraction along the pipe (T) + offset
      (`Modules/Drainage/Services/LinkService.SegmentAnalysis.cs`, the PipeAttachment builder around lines 260–280).
      A description at the middle (T ≈ 0.5) moves half of the end's movement: 250 mm of 500 mm. That is the "half"
      the entry calls "fits neither design". It is (a) with the hand offset kept, anchored mid-pipe.
   2. `PlacedByHand` is only read by the tidy (`LinkService.TextClashTidyUp.cs` lines 244–346). The pit-move
      re-placement never reads it, so the switch cannot keep a label put.
   3. The mark is only written by the "atomic attachment move" route (`LinkService.Reactors.cs` ~1293–1296) inside a
      tidy pass. That is why Tidy labels counted "Placed by hand 0".
3. **Also seen:** the description re-worded from "1 IN 100" (typed, Keep) to "1 IN 101" after the pit move. Same family
   as the BUG-357 "unlocked control re-words to 1 IN 101" note. Not new.
4. **Next time:** nothing for Codex until Tim answers question 19. Add this cause to BUG-1252 (desk bookkeeper).

### 3. G3 06:45 — PASS

1. **Class:** no fault. Downpipe DP1, raingarden, one U removed only the raingarden.
2. **Observation:** the drawn tag reads "DP", not "DP1", and the raingarden has no drawn "RG1". That is **BUG-1242**
   (exists). Nothing new.

### 4. G4 07:02 — NOT TESTED ×2

1. **Class:** (b) Codex evidence fault. The screenshot saver kept writing the first image.
2. **Next time:** check the saver hash after every save, not in batches. The 07:27 rerun fixed it.

### 5. G6 07:14 — G6-01 BLOCKED (copied pit)

1. **Class:** (b) test set-up (view framing).
2. **Why:** the prescribed view centre (53778,-32350) with height 6000 put the copy (at y ≈ -30570) near the top. The
   cover text ran off the top edge and the floating command history covered the bottom of the number circle.
   Everything Codex could see was right: P8 (not P3), circle, cover text, the Check levels line, one U removed all.
3. **Next time:** centre on the copy, (53778,-30570), height 9000. Push the history off first (a few blank princ lines,
   or shrink the floating history), then capture.

### 6. G4 07:27 — G4-01 FAIL (CDCHECKDWG list), G4-02 PASS (About)

1. **Class:** (b) test wording. **BUG-1254** (exists) is probably not a product fault.
2. **Why:**
   1. `Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml` gives the list a star-sized row with a vertical scrollbar.
      A partial row at the bottom is normal for any scrolling list.
   2. C6-01 at 08:57, same build, same fixture, same window: Codex judged it PASS, and one wheel turn scrolled ten new
      rows. The "wheel did nothing" in G4 was most likely the pointer not over the list.
3. **Next time:** the brief's "no cell cut off at an edge" should exclude the last partly shown row of a scrolling list.
   Recommend the desk closes BUG-1254 as a brief fault, or keeps it only as LOW polish (fit the list to whole rows).

### 7. G5 07:39 — G5-01 FAIL (upper-left IL 18.24 on its blue pipe strip after P3 moved 2 m)

1. **Class:** (a) product. **BUG-1253** (exists). Seen again independently in C6-03 at 08:54.
2. **Cause found in source:** in `LinkService.TextClashTidyUp.cs` the pipe itself, its strip (mline) and its own texts
   go into `ownIds` (lines 273–286). `Filter` then skips them as obstacles (lines 687 and 704). So a text sitting on
   its own pipe strip is never a clash. After the pit moves, the texts are re-placed by the stored along/offset values
   on a pipe whose angle has changed, and nothing notices the overlap.
3. **Related:** **BUG-1034** (Tidy labels puts IL text on its own pipe line) has the same root. Fix both together.
4. **Caution:** DRV1_B1 is a legacy drawing. In C6-04 CE said "Pipe 109E23 does not match a single pipe in the project
   record". The fault is still what a drafter sees on an old job, but the robot should also repeat it on a fresh pit.

### 8. H1 07:52 — H1-01 BLOCKED, H1-02 NOT TESTED

1. **Class H1-01:** (b) Codex input. The profile reading went into the drawing as a paste (PASTECLIP, "Specify
   insertion point:"). Same pattern as the October _pasteclip notes in BUG_CARPARK (around lines 1686–1698).
2. **Class H1-02:** correct gate, not a fault. The installed 3.0.86 still warns on the TYPED head
   (`ViewModels/ChargedSystemCalcViewModel.cs`, MinimumHeadWarning, ~lines 241–252: compares typed head only). The
   head-minus-loss fix is not in this build. It is a follow-on to **BUG-1097**.
3. **Next time:** see the shared input fix in item 18. Rerun H1-02 only when a build with the head-minus-loss change is
   installed, and put that version in FIX-IN.

### 9. H2 07:56 — H2-01 BLOCKED (Help), H2-02 PASS (Feedback window)

1. **Class H2-01:** (b) tool limit. The Help Centre is drawn by a separate WebView2 program (msedgewebview2.exe), and
   the screen tool refuses clicks on anything that is not acad.exe.
2. **Extra evidence I gathered (read-only):** the installed Modern bundle's help text
   (`CE_CVL_SUITE.bundle\Contents\Win64\Modern\Assets\Help\guide-content.js`, line 98) reads: Send report saves a
   copy on this PC and tries the office folder in the same step; if the folder can't be reached the copy stays and
   the command line says to email it. "Save report" and "separate from sending" do not appear anywhere in the help
   files. **BUG-1215's wording is fixed in 3.0.86 files**; only the on-screen look is outstanding.
3. **Next time:** run CDFEEDBACK, Cancel, then CDHELP straight away. CDHELP opens at the last CE command's entry
   (`Services/HelpLauncher.cs`, OpenContextHelp), so no search-box click is needed. Or give the screen tool access to
   msedgewebview2.exe.

### 10. H3 08:07 — H3-01 BLOCKED (Excel export)

1. **Class:** (a) product. **BUG-1255** (exists, "to check") — cause now found.
2. **Cause found in the CE log** (copied by H4 at 08:20, `logs_start\CE_CVL_SUITE\ce_cvl_structured_20261030.log`,
   08:13:13 and 08:13:22): FileLoadException, "Could not load file or assembly 'ClosedXML, Version=0.102.3.0' ... The
   located assembly's manifest definition does not match", thrown at
   `ViewModels/PitScheduleViewModel.Schedule.cs:113` (ExportExcel).
3. **Why:** AutoCAD 2027 ships `C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll` version **0.102.2.0** (same
   publisher key). CE Civil and CE Structural both reference **0.102.3** (`Modules/Drainage/CE_CVL_SUITE.csproj:192`,
   `Modules/Structural/CE_STRUC_SUITE.csproj:193`) and ship it in their bundles. AutoCAD's older copy wins, CE's
   request fails.
4. **Reach:** every ClosedXML export in Civil on AutoCAD 2027 (Pit Schedule Excel; likely the CDCALC XLSX export too),
   and very likely Structural's Excel exports. Probably worked earlier on other AutoCAD years, which is why BUG-571's
   Excel tests on 14 Oct could run.
5. **Second, smaller fault:** the window guard (`Services/DialogService.cs`, CrashLineWords) turns the crash into
   "rendering error — see CE log". A drafter gets no file box and no reason. Worth a plain line such as "Excel export
   could not start on this AutoCAD; use Export CSV".
6. **Fix options for the builder:** build the net10 (Modern) lane against ClosedXML 0.102.2 to match AutoCAD 2027, or
   load ClosedXML in CE's own load context. A 10-minute accoreconsole probe can prove which works.
7. **NEW to flag:** "Structural Excel exports crash on AutoCAD 2027 (same ClosedXML clash)". Not yet seen in AutoCAD;
   needs one robot check before filing.
8. **BUG-1198 halves:** CSV cancel PASS in substance (0 extra drawing-write lines). The Excel cancel half cannot run
   until BUG-1255 is fixed.

### 11. H4 08:20 — H4-01 BLOCKED (cover box blank)

1. **Class:** (b) most likely Codex input, confidence medium.
2. **Why:** G7 at 06:27, same build, same fixture, same point, same New Pit window: typing 19.000 worked and the footer
   showed "Cover level: Was Unknown → Now 19.000 m AHD" (G7-00-pit-cover.png). In H4 the box shows the gold focus
   edge but no text and no caret (H4-02-cover-detail.png). H4 pressed Ctrl+A before typing; G7 did not. The keystrokes
   probably went to the AutoCAD frame, not the New Pit window.
3. **Next time:** use G7's exact steps (click the box, type, no Ctrl+A). Check the footer line before Continue. Better:
   the desk saves G7's built set-up (P8 plus 100 mm pipe, inverts 18.000/17.900) once as a ready fixture, so H4, G7
   and C6-04 start without making a pit.

### 12. H5 08:28 — H5-01 BLOCKED (Work out design greyed)

1. **Class:** (b) stale brief.
2. **Why:** "Work out design" is deliberately disabled until every required step is answered
   (`ViewModels/CivilDesignWindowViewModel.cs` lines 106 and 778; `Rules/CivilDesignWorkflow.cs`, CanCalculate and
   Outstanding). The not-ready list IS the Design checklist on the window. Codex saw it: "The council and its rules —
   Set". No "rules could not be read" line. That is the BUG-1106 result the look wanted.
3. **Next time:** judge on the checklist, not on clicking Work out design. On today's evidence BUG-1106 can be
   Claude-accepted; Codex-accept on a rerun with the checklist as the criterion.
4. **Question for Tim (not a fault):** a greyed-out button is a hard stop, and R-27 says warn, don't block. "Next
   missing input" is beside it, so this looks intended. Queue for the questions chat only if the desk thinks it
   conflicts.
5. **Observation, by design:** "The council in Design (Glen Eira) was not saved ... choose Save Draft" — correct,
   because the brief forbade Save Draft.

### 13. H6 08:36 — H6-01 NOT TESTED (CE Tools at startup)

1. **Class:** (b) set-up. The drawing never opened.
2. **Why:** H6-04-after90s.png shows AutoCAD's no-drawing state: menus File, Window, Help only, no drawing tab, no
   ribbon, no command line. AutoCAD hides the ribbon in that state, so BUG-1206 cannot be judged. The four identical
   picture hashes are because the screen genuinely did not change.
3. **Next time:** start the clock only when the title bar shows the drawing name. If no drawing after 60 s, open it with
   the driver. Take ribbon pictures at 10, 20, 40 and 60 s after that.

### 14. A1 08:42 — A1-01 PASS, A1-02 BLOCKED

1. **Class A1-02:** (b) environment. No display on this PC runs at 150%.
2. **Next time:** either Tim agrees to set the second monitor to 150% for 5 minutes, or an automated WPF render test of
   the About window at 150% DPI (no AutoCAD needed). Recommend the render test.
3. **Discard one reading:** "BUG-1086 NOT SEEN" is not valid. U echoed COMMANDMACROSCLOSE, so U undid an AutoCAD
   command that ran after CE_VERSION (see item 18), not CE_VERSION. Rerun: CE_VERSION, Close, U, with no typed
   readings in between, via the driver.

### 15. C6 08:54 — C6-01 PASS, C6-02 PASS, C6-03 FAIL, C6-04 SEEN

1. **C6-03:** (a) product, **BUG-1253** again (see item 7).
2. **C6-04 (question 19):** (c) unclear, because of the fixture. The hand move of IL 17.25 was NOT recorded: CE said
   "Pipe 109E23 ... does not match a single pipe in the project record". So the next pit move worked from CE's old
   record. The numbers also don't fit (a) cleanly: the text ended exactly at its original spot P0, 600 mm of travel for
   a 500 mm pit move. That is not what a colleague gets on a drawing whose pipes CE knows.
3. **Next time:** rerun question 19 on a fresh pit and pipe (the G7 set-up fixture in item 11). Tim's answer to
   question 19 should not rest on C6-04.
4. **C6-01 vs G4-01:** see item 6.

### 16. C3 09:13 — C3-01 PASS, C3-02 PASS, C3-03 DIFFERENT, C3-04 SEEN

1. **C3-03:** (a) small product wording fault, **BUG-1256** (exists). Cause: two Close paths.
   1. Close on the first (Source) page prints the plain sentence, `Commands/LinkCommands.ImportXcivil.cs:71`.
   2. Close on the schedule page after Read source goes down the pre-flight "declined" path,
      `Services/XcivilImportService.cs:886`, which prints "Import aborted at pre-flight gate — no entities were
      inserted."
   3. Same look: "CHECK THE SCALE" and the pre-flight summary printed twice, and "DEGRADED" in capitals. Add both to
      BUG-1256 as wording polish.
2. **C3-04:** observation only. The screen said "Nothing was sent" twice, but the CE log has no matching line. Not a
   fault on its own; worth one log line per refusal so the log can prove it. Candidate for the desk, LOW.

### 17. C1 09:29 — 7 looks BLOCKED

1. **Class:** (b) Codex input, as H1. Codex typed while startup was still settling (CE Tools appeared late).
2. **Evidence:** C1-04-typing-closeup.png shows AutoCAD's command-line suggestion box offering COMMANDMACROSCLOSE over
   the typed reading. Enter took the suggestion. History: "(list (getvar ...))*Cancel*" then COMMANDMACROSCLOSE.
   COMMANDMACROSCLOSE is not in CE source; it is AutoCAD's.
3. **Next time:** see item 18. Most of C1 is "is anything blue" in windows; a robot screenshot pass can do several of
   these without typed readings.

### 18. Shared fix for the typing failures (H1, C1, A1's undo, H4, H5's GRAPHSCR, C3's GRAPHSCR)

1. **Do the readings with the AutoCAD driver** (`C:\Lisp Files\_ACAD_DRIVER`), not typed by Codex. Codex keeps the
   looking and clicking; the driver does every getvar/list reading and the U/REDO steps.
2. **If typing must stay:** wait for the CE Tools tab plus a plain "Command:" prompt plus 20 seconds after the drawing
   opens. Click inside the command-line text, never its left-hand icon. Screenshot before Enter. If a suggestion box
   shows, press Esc twice and retype; never press Enter on it.
3. **After TEXTSCR:** close the text window with its own X, not by typing GRAPHSCR into whatever has focus (that caused
   PASTECLIP in H5 and C3).

## Bug numbers matched

1. **BUG-1252** — G7-01. Real. Cause added above. Stays ON HOLD for question 19.
2. **BUG-1253** — G5-01 and C6-03. Real. Cause added above; fix together with **BUG-1034**.
3. **BUG-1254** — G4-01. Probably not a fault; recommend close as brief wording (C6-01 passed).
4. **BUG-1255** — H3-01. Real. Cause found: ClosedXML 0.102.2 (AutoCAD 2027) vs 0.102.3 (CE).
5. **BUG-1256** — C3-03. Real, small wording. Cause added above.
6. **BUG-1242** — G3 observation (DP tag shows "DP", no RG1). Existing.
7. **BUG-1097** — H1-02 gate. Fix not in 3.0.86.
8. **BUG-1215** — H2. Words fixed in the installed help file; look outstanding.
9. **BUG-1106** — H5. Checklist shows council Set; brief needs the checklist as criterion.
10. **BUG-1086** — A1's NOT SEEN is invalid evidence.
11. **BUG-1180, BUG-1206, BUG-517, BUG-525, BUG-090 (150% half)** — untested, set-up faults only.

## NEW candidates (not filed; one writer at a time)

1. **Structural Excel exports on AutoCAD 2027** — same ClosedXML clash as BUG-1255. Needs one robot check first.
2. **"Rendering error" line hides the real reason** for a crashed button (DialogService CrashLineWords). LOW.
3. **AI refusal not written to the CE log** (C3-04). LOW.
4. **Gate 2.4 stuck by a dead job's START** (G3 06:21). Desk tooling, not product.
