# Evidence for the "fixed in code, never seen" bugs (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 02:10. **Build tested: the INSTALLED one** (Civil 3.0.90, commit `cf059dcf`, AutoCAD 2027), real AutoCAD on fresh copies of the standard test drawing under `C:\CE_WORK\scratch\trustprobe`. No status in `BUG_CARPARK.md` was edited; the controller does that from this file under RULES 13.3. Nothing installed, no CE setting changed (four settings files hashed before and after: identical; FILEDIA was set to 0 for one try and put back to 1, read back).

**Three words only:** seen fixed, seen still broken, could not be tested this way. Built / Tested / Installed / Accepted: nothing here is Tim-accepted. "Seen fixed" is robot evidence in real AutoCAD on a copy; Codex looks were not part of this.

---

# FOR TIM

1. **BUG-650, Esc in the floor waste command wiping stored pit inverts: SEEN FIXED.** On a copy with 8 pits holding levels (P1 16.930, P2 17.080, P3 17.250, P4 17.400, P5 17.530, P6 17.670, P7 17.650, C1 16.820) and 25 pipes holding levels, I typed CDFW and pressed Esc at its first question: every one of the 8 pit levels and 25 pipe levels was still there. Then I placed a floor waste properly: the levels were still there. One U after each put CE's record back exactly.
   1. **One thing it still does:** a cancelled CDFW rewrites CE's record quietly. The only changes are the stored format number (2.2 to 2.3) and an identity added to each of the 49 pipes. No level or size changed. That is the "CE changes its record without telling" fault, not the level loss.
2. **BUG-1255, Pit Schedule Excel export: COULD NOT BE TESTED THIS WAY.** The driver never presses an Export button, and the save box is AutoCAD's own window. What I could read: AutoCAD 2027 still ships ClosedXML 0.102.2 and CE's bundle still ships 0.102.3 (the clash that caused the fault is still there). The installed code has a fix for it (it answers a refused request with AutoCAD's own copy, switch on by default). Whether it works is not seen.
3. **BUG-458, commands running while a reference is open for editing: COULD NOT BE TESTED THIS WAY.** Starting the reference edit opens AutoCAD's own "Reference Edit" dialog, which the driver cannot press. I got as far as picking the reference and answering the nesting question; the dialog then blocked everything, and Esc closed it. Nothing was changed.
4. **Still to do from the ten Tim should care about:** BUG-683, 681, 290, 968, 674, 780, 785, 756 and 969 were not attempted tonight. The queue's other items came first. Each needs its own drawing set-up.

---

# DETAIL

## BUG-650 (CDFW cancel clears stored pit inverts)

1. **Drawing:** copy of the standard test drawing, 11 pits, 49 pipes, millimetres. CE's record read as before (`TRUST_PROBES_13NOV.md` section 0).
2. **Before:** 8 pits with a stored invert (list above), 25 pipes with a stored from or to invert.
3. **Test A, Esc at the first question:** typed CDFW; the command line showed "Specify floor waste insertion point"; one Esc: "CDFW cancelled - nothing was placed." After: the same 8 pit inverts, the same 25 pipes with inverts. Drawing fingerprint unchanged (1,034 objects). The record text grew from 600,382 to 603,310 characters. Compared field by field with CE's random ids ignored, the only differences are the top-level format number "2.2" to "2.3" and 49 pipes each gaining an identity key. No pit or pipe value changed.
4. **Undo after test A:** one U ("CDFW" in the undo line): record back to 600,382 characters, the exact opening hash.
5. **Test B, a floor waste placed** (typed insertion point on empty ground): "Floor waste placed. Tag: FW1." Objects 1,036. The same 8 pit inverts and 25 pipe inverts. One U ("CDFW"): record and drawing back exactly to the opening state.
6. **Matches the carpark entry's guard:** "Both established inverts must remain ... and no floor waste/tag may remain." Seen for both the cancel and the placement. Not tried: the strip-and-AGI drawing the entry used (it is not among the test copies), a pit with a sump bottom, and save and reopen.
7. **Why it is fixed (not tested here):** `trust-safety-fixes` found the fix at commit `da006db6`, in since Civil 3.0.70; this evidence is consistent with that.

## BUG-1255 (Pit Schedule Export Excel)

1. **Cannot be pressed:** the driver's never-press list contains "Export"; the Pit Schedule is a window on the driver's read list and its Export button is not on any press list.
2. **Files read (read only):** `C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll` is 0.102.2.0; the installed bundle's `Modern\ClosedXML.dll` is 0.102.3.0; same publisher key. So the clash condition in the carpark entry is unchanged.
3. **The claimed fix, from the code copy at the installed commit:** `PluginInitialization.cs:61-63` registers a handler that answers a refused request for the Excel library with AutoCAD's copy; `UserSettings.UseAutoCadLoadedClosedXml` defaults to true; `PitScheduleViewModel.Schedule.cs:126-147` also turns a library load fault into one plain line. Whether the save box then opens is not seen.
4. **What would settle it:** a person (or Codex with screen control) pressing Export Excel in the Pit Schedule on a copy and reporting whether the save box opens. Nothing else can.

## BUG-458 (commands during REFEDIT)

1. **Set-up that worked:** a made-up drawing attached as a reference to a copy, zoomed, then `-REFEDIT`, a pick on the reference, "Select nesting level [Ok/Next] <Next>:" answered with Ok.
2. **What blocked it:** after Ok, AutoCAD opened its own Reference Edit dialog (even with FILEDIA at 0). The driver rejects typed text while it is open and has no way to press it. One Esc closed it; AutoCAD was idle again. I restored FILEDIA to 1 and read it back.
3. **So PIT, PP, CD and the Pit Schedule were never run with a reference open for editing.** The claimed fix (`DrawingSafetyService.cs:78-90`) is unseen.
4. **What would settle it:** a person or Codex clicking OK in that dialog on a copy, then typing PIT, PP and PITSCHEDULE.

## Tidy-up

AutoCAD closed with the driver's quit; lock released; the four settings files byte-identical. My scratch build copies and DXF exports were deleted; C: free rose from 34.6 to 38 GB. The reference test left no file in the testset folder (it used a copy).

---

# Added Fri 13 Nov 03:45: second session, BUG-290, BUG-968, and what could not be done

**Same rules as above:** the installed build (Civil 3.0.90, `cf059dcf`), real AutoCAD 2027, fresh copies of the standard test drawing, a SECOND and separate AutoCAD start (a different process from the first), no status edited, nothing installed, four settings files checked at the end.

## FOR TIM

1. **BUG-650 (CDFW cancel wiping pit inverts): SEEN FIXED IN TWO SEPARATE AUTOCAD SESSIONS.** The second session gave the same answer as the first: after Esc at CDFW's first question, and after placing a floor waste, the 8 stored pit inverts and the 25 pipe levels are unchanged (the stored levels have the same fingerprint, 86745A395C46, before and after). So the "two sessions" rule of 24 Oct is met for this fix, on the robot's evidence.
2. **BUG-290 (a hidden refresh overwriting levels, in CDAGI, CDSTRIP, CDRUNSOLVE): SEEN FIXED for the case I could drive; the full case was not tried.** In all three commands, pressing Esc at the first question left every stored pit and pipe level unchanged (same fingerprint). Not tried: typing a level into a window first and then running the command (the original fault).
   1. **One thing each of them still does:** the Esc rewrites CE's record quietly (the stored text gets shorter by 148 characters, no level changes). One U puts it back (shown earlier for PIT).
3. **BUG-968 (CDRENUMBER closing AutoCAD with two pipes running opposite ways between the same two pits): SEEN FIXED.** I drew two pipes between P10 and P9, one each way. CDRENUMBER ran: it asked for the main outlet (C1 or X1), showed its list ("P9 to P8, P10 to P9"), asked "Apply?", and Esc at that question left the drawing and CE's record exactly as before. AutoCAD never closed (same process throughout).
4. **Could not be done this way:** BUG-674, 780 and 785 (they need the Edit Pit Save and Pit Schedule Place buttons, which the driver never presses); BUG-969 (it makes a new drawing file in a job folder, not something to do on a copy here). **Not attempted:** BUG-683, 681 (need a typed-length pipe and a Pit Schedule row compared by eye) and BUG-756 (the long section). Say so rather than guess.

## DETAIL

1. **BUG-650 second session.** Session start 03:02. Before: record 600,382 characters, levels fingerprint 86745A395C46 (8 pits with a stored invert, 25 pipes with one). CDFW then Esc ("CDFW cancelled - nothing was placed."): record 603,308 characters, same fingerprint. After a reopen: same fingerprint again. CDFW with a point ("Floor waste placed. Tag: FW1."): record 605,005, same fingerprint. Record growth is the quiet identity and format-number rewrite described above (no level value).
2. **BUG-290.** Each from a fresh reopen. CDAGI: first question "AG drain pipe property [None/Charged/Suspended]", Esc: "CDAGI command cancelled."; fingerprint unchanged; record 600,382 to 600,234 characters. CDSTRIP: first question "Justification [Top/Center/Bottom]", Esc: "CDSTRIP cancelled - nothing was drawn."; fingerprint unchanged; 600,234. CDRUNSOLVE: first question "Select the start pit (upstream end) of the run to solve", it waited at it (my script's 60-second wait ended, then one Esc), Esc: cancelled; fingerprint unchanged; 600,234.
3. **BUG-968.** Two pipes drawn with CD (New Pipe window, levels left blank, Start Pipe pressed through the v3 driver), P10 to P9 then P9 to P10: objects 1,034 to 1,040. CDRENUMBER: "More than one pit discharges outside the network - its main outlet is not obvious: C1 X1"; Esc: "Renumber cancelled - nothing changed." Run again, answer C1: "Renumber downhill to uphill: P9 -> P8, P10 -> P9", "2 pit(s) will be renumbered. Apply? [Yes/No] <No>", Esc: "Renumber cancelled - nothing changed." Record and drawing fingerprints identical to before CDRENUMBER (604,422 characters). The AutoCAD process number was the same at the end. I did not answer Yes (it would renumber the copy).
4. **Not seen:** whether the original crash needed a different drawing (the entry says "before the list appeared"; here the list appeared and nothing closed).
5. **Set-up notes for whoever repeats these:** the New Pit window needs a cover level typed before Continue placement enables; the driver's v2 press list refuses the renamed "New pit, Continue placement" and "New pipe, Start Pipe" buttons, the v3 `ui-press` accepts them; a CE command left at a prompt is ended with the driver's one-Esc verb.

## Added 04:10: BUG-681 tried, BUG-683 tried, both could not be completed

1. **BUG-681 (CD, uphill answer Yes/flip): COULD NOT BE TESTED THIS WAY, but the set-up works.** CD between P10 and P9 with typed levels 10.00 upstream and 10.50 downstream makes CD ask, at the command line: "Pipe was drawn P10 (IL 10.000) to P9 (IL 10.500), but the entered levels indicate P9 (IL 10.500) to P10 (IL 10.000). Is this correct? Choose: Use level direction [UseLevelDirection], Keep nominated direction [KeepNominatedDirection], or [Review] <Review>". On this build the answer is a WORD, and the driver can only send digits and punctuation at a CE prompt (it refuses a typed word: "a CE command is waiting at a prompt ... use answer <digits>"). So neither "Use level direction" nor "Keep nominated direction" could be sent, and the stored From/To against the plan levels was never compared. Esc at that question: "CD command cancelled." Nothing placed; the record and drawing were unchanged (no quiet rewrite this time).
   1. **What would settle it:** a person (or Codex) typing UseLevelDirection and KeepNominatedDirection in turn on a copy, then reading the Pit Schedule row and the plan levels for that pipe. The drawing and the numbers to type are above.
2. **BUG-683 (CD, typed real length after the level is worked out): COULD NOT BE TESTED THIS WAY.** The same-plan break question is behind the "More" button on the New Pipe window; the driver's press lists do not carry it (the carpark entry says the same for run 36). Not tried further.
3. **Still not attempted:** BUG-756 (the long section).
4. **A pattern worth knowing:** CE commands cancelled at their first question rewrite CE's record quietly (shorter by 148 characters, no values) in PIT, CDAGI, CDSTRIP, CDRUNSOLVE; CDFW also adds identities and the format number; CDRENUMBER and CD (at the uphill question) did not. One U restores each of those where tested.

## Added Fri 13 Nov 09:30 (PC clock): BUG-756, BUG-674, BUG-780, BUG-785, BUG-969, exactly where the robot stops

**FOR TIM**

1. **BUG-756 (CDPROFILE, a pipe just before a size increase drawn one size too tall on the long section): COULD NOT BE TESTED on the test drawing.** CDPROFILE asks "Select starting CE pit for profile review"; I gave it the position of a real pit block (PIT BLOCK 3 on the standard test drawing). The Profiles window opened, but it says "No pit selected" and "The selected pit has no exact carrying PIT_LINK and spine identity", and its Preview New, Preview Update and Apply buttons stay greyed out. So the window refuses to draw a long section from this drawing's pits. Nothing was drawn.
   1. **What would settle it:** a drawing whose pits carry CE's link and identity (one drawn fresh with the New Pit and New Pipe windows, with a size increase part-way along the run), then Preview New and Apply by a person or Codex, and read the long section by eye.
2. **BUG-674 (Edit Pit window, batch Apply), BUG-780 and BUG-785 (Pit Schedule, Place): STOP at the buttons.** They need Save or Apply on the Edit Pit window and Place on the Pit Schedule window; the robot's press list never presses those (they write to the drawing). Not tried.
3. **BUG-969: STOP.** It makes a new drawing file in a job folder; not something to do from here. Not tried.
4. **Everything above is still "not seen". None of these is claimed fixed.**

**DETAIL**

1. The Profiles window controls: a Choose Pit button, Refresh, a Route (required) picker, Schedule set, Datum RL (m), Horizontal 1:100, Vertical 1:10 (10x), then a table (Pit, Chainage, Cover, Invert, Depth, Dia, Grade, Velocity, Full flow). Closed again by the robot with its own Close; the drawing was not changed (the copy's modified count is unchanged by CDPROFILE).

## Added Sat 14 Nov 00:25 (PC clock): BUG-1298 (CDLPD) and BUG-1355 (CDRUNSOLVE), seen on the installed Civil 3.0.90.2

**Same rules:** the build installed on Tim's PC today (Civil 3.0.90.2 = 3.0.90 + PR 2073 + PR 2083; CDLPD and CDRUNSOLVE code identical to 3.0.90), real AutoCAD 2027 started by me at 23:41 Fri, scratch copies of the standard test drawing and a blank drawing only, nothing installed, AutoCAD closed by me 00:25, the four settings files the same at the end. Robot only; not Codex-looked.

### FOR TIM

1. **BUG-1298 (CDLPD takes a plain line as the pipe): COULD NOT BE SEEN; the robot stops at the CDLPD window.** I drew a plain polyline on layer 0 in a copy of the standard drawing and ran CDLPD. Its window opened ("Legal point of discharge": connection type, "Pick a point instead of selecting a pipe, pit or block" OFF, "Continue in drawing", Close). The robot is not allowed to press "Continue in drawing" (it is on neither of its press lists), so the click on the line was never reached. I closed the window; nothing was drawn and no LPD was stored. **Seen on the way:** closing that window still rewrote CE's record (format number 2.2 to 2.3, same length): CDLPD rewrites the record even when cancelled. And in a blank, never-used drawing CDLPD first asks "This drawing isn't tagged yet. Is this a Civil drainage drawing? [Yes/No] <Yes>" (Esc: "CDLPD cancelled - drawing type not set").
2. **BUG-1355 (CDRUNSOLVE goes down whichever pipe is listed first): SEEN.** In a copy of the standard drawing I made pit P10 split two ways: first a pipe P10 to P9 (a dead end, no levels), then a pipe P10 to P4 (which carries on P4, P3, P2, P1, C1 to the stored LPD). CDRUNSOLVE from P10, Enter at "downstream end pit (or press Enter to use the furthest downstream pit)": **"[CDRUNSOLVE] Run: P10 -> P9 (anchor P9), 1 pipe(s)."** It went down the dead-end leg, the first one listed, not the leg to the LPD. **Same with the LPD in the drawing and with the LPD removed** (two separate copies). In this set-up it then refused to solve ("Downstream anchor pit 'P9' has no invert level ... set the connection IL first"), so no level was written; with a dead end that HAS a level it would have solved down the wrong leg (not tried).
3. **Also seen:** with an LPD stored in the drawing, CDRUNSOLVE still asked for a downstream end pit (the review expected it would not ask).
4. **Not tested:** picking an end pit on the other leg (my typed picks on the 900 mm pits P4 and P1 were refused, "That is not a pit. Pick a pit.", three times; the run then fell back to "furthest downstream" = the same P10 -> P9). Swapping the order the two pipes are listed (to show the choice really follows the list and not, say, the shorter pipe) was not done.

### DETAIL

1. **CDLPD.** Copy `CLDTP_LPD2.dwg` (standard drawing, 11 pits, 49 pipes, an LPD already stored on the council stub). Polyline on layer 0, handle 11C55B, 150000,-250000 to 170000,-250000 to 170000,-240000. CDLPD window "Creative Engineering | Legal point of discharge (CDLPD)". Driver: "window ... is not on the V2 press / set allow-list" and "no button 'Continue in drawing' that is on the v3 press list". Closed with its Close button. Record before 600,382 characters, version 2.2; after 600,382, version 2.3; pits 11, pipes 49 both times.
2. **CDRUNSOLVE.** Copies `CLDTP_RS1.dwg` (LPD kept) and `CLDTP_RS2.dwg` (LPD dictionary removed by me through AutoCAD's automation on the copy). New pipes drawn with CD: record order #50 P10->P9 (no levels), #51 P10->P4 (17.88 / 17.40, set by CD). Start pit picked on P10's outline (54436.3,-69718.6; a pick at its centre hit a pipe end: "That is not a pit"). Result lines quoted above, identical on both copies; record size unchanged before and after each run (604,436 and 604,216 characters).
3. **Where the robot stops (for whoever repeats this):** CDLPD needs "Continue in drawing" pressed (a person or Codex); CDRUNSOLVE's end-pit pick needs a mouse click on the pit (typed points on the 900 mm pit blocks are refused); the driver's `answer` cannot reach CDRUNSOLVE's questions (they reach the log only after they are answered), so all answers were chained in one typed line.

## Added Sat 14 Nov 01:05 (PC clock): pull request 2099 (BUG-1298, CDLPD takes only a CE pipe) at head 9c3f088e

**FOR TIM**

1. **SEEN BEFORE: COULD NOT TEST.** On the installed build the robot gets as far as CDLPD's window and stops: it may not press "Continue in drawing" (Fri/Sat night 23:47, above).
2. **CORE CONSOLE AFTER: COULD NOT TEST.** CDLPD only works through its window, and the core console has no windows.
3. **REAL AUTOCAD AFTER: needs the batch install, and a person (or Codex) to press "Continue in drawing".** Three things to check then, on a copy: a plain line on layer 0 clicked as the pipe gives "[CE] That line is not a CE pipe, so it cannot be the LPD pipe. Nothing was changed. Run CDLPD again and pick a CE pipe, a pit or a block, or choose to pick a point." with no marker, no note and no LPD stored; a real CE pipe sets the LPD as before; an older polyline on a CE pipe layer is accepted.
4. **What IS shown:** the head builds (0 errors), and the new wording is inside the built program file. That proves the words are there, not that the check works.

**DETAIL**

1. Built in my own folder from `9c3f088e` (Civil net10, Release, SkipDevBundle), snapshot `C:\CE_WORK\scratch\trustprobe\build_s2099`, DLL `3.0.90+9c3f088eb81dc2fe00817b3e5378ceb40ca00c39`, SHA-256 `811E803E7D1C92AEAE8949F3551B6ED82C1C628F21C45464E479929A3371BD1E`. This is the net10 DLL only, for the batch's own payload build to use as a cross-check; it is not an install package.
2. The builder's own figures (not re-run here): 287 of 287 unit tests, both broken twins fail.

## Added Sat 14 Nov 01:15 (PC clock): pull request 2092 (BUG-1355, CDRUNSOLVE at a split) at head d686e787

**FOR TIM**

1. **SEEN BEFORE (real AutoCAD, installed 3.0.90.2, 00:10 to 00:23):** at pit P10 with two pipes leaving it, CDRUNSOLVE went down the first one listed (P10 to P9, a dead end) instead of the leg to the end of the network. Written above.
2. **CORE CONSOLE AFTER: SEEN WORKING.** The builder's new check lays out the same pits and pipes in the same order (P10 to P9 listed first, then P10 to P4, on to P3, P2, P1, C1) and runs CDRUNSOLVE's real route-finding. On the fixed build:
   1. Enter at the end-pit question: the run stops at P10 and names both pipes (it no longer guesses).
   2. End pit C1 picked: the run follows P10 to P4 to P3 to P2 to P1 to C1.
   3. Asked which way at P10 ("to P9, to P4"), choosing P4: it follows on to C1.
   4. Esc at that question: it stops at P10 and changes nothing.
3. **The same check on your installed 3.0.90.2 FAILS, as it should:** with no end pit it goes P10 to P9; **even with end pit C1 picked it still goes P10 to P9**; and it cannot ask which way. So the fault is worse than the run in AutoCAD could show (there my typed end-pit picks were refused).
4. **REAL AUTOCAD AFTER: needs the batch install.** On a copy of the same layout: Enter at the end pit, then answer B at the new "Which way does the run go? A = to P9, B = to P4" question: the run goes P10 to P4 and on; Esc changes nothing. The question wording is a DRAFT for you.

**DETAIL**

1. Built from `d686e787` in my own folder (Civil net10, Release, SkipDevBundle, 0 errors): `C:\CE_WORK\scratch\trustprobe\build_s2092`, DLL `3.0.90+d686e78774066c1ed21f855d0971dd753f6d03d3`, SHA-256 `0B0AD26F4438562F8B0B02262D0E7B1BACF443C1CA90735963315B41AB5603BF`.
2. Check `CEPROOFRUNSPLIT` (RUNSOLVE-SPLIT-01), harness at the same head, AutoCAD 2027 core console, nothing installed. Fixed build 01:11: `PASS`. Installed copy (`3.0.90.2+5c89ce30`, the Modern lane copied to scratch) 01:11: `FAIL`, detail "Enter at the end-pit question: P10 -> P9; end pit C1: P10 -> P9; asked and chose to P4: (this build cannot ask)". Evidence folders `%TEMP%\ce-headless-proof\run-20261114-011115` and `run-20261114-011126`.
3. The check builds the pit and pipe records in memory and runs the real walk; it does not draw, show the preview window or write levels. The preview wording change (no "connection pit", no "council assets untouched" when the run stops at a split) is NOT seen.
