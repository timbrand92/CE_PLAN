# Tim's tick-list: the 191 fixes already installed, waiting for your yes

**Written:** Mon 12 Oct 2026, about 01:00 Melbourne (PC clock). Desk plan/03, headless Sonnet job.
**What this is:** every bug the burndown says is already fixed in an installed build, grouped by the command you use, in the order you work. One line each. Walk it in one sitting.
**Source lists:** `areas\release-v3-colleagues-BUG_BURNDOWN_QUEUE_2026-10-10.md` section 3 and its `_lists.txt`. Steps come from each bug's own entry in `C:\CE_PLAN\BUG_CARPARK.md`.

---

## Read this first (one minute)

1. **What is installed on your PC right now** (I read the version numbers off the installed files tonight, 12 Oct): Civil 3.0.47, Manager 1.1.47, Structural 1.0.115. The fixes below were counted as part of Civil 3.0.45 and Structural 1.0.114, so the installed builds are newer. I did not check that every fix is still included in 3.0.47 and 1.0.115. If one fails, tell the desk the version you saw.
2. **Four words stay separate.** Fixed and installed is not accepted. Only your tick (or a Codex pass you can see) makes a bug accepted. Today your accepted count is 0.
3. **"Robot PASS" means a test robot saw it work on a test copy. It is evidence only.** A robot saw it on the build that was installed on that day, not always on 3.0.47. Tick those fast, or skip them if you are short of time.
4. **Items the robots could not check come first in each section.** Those are the ones I most want your eyes on.
5. **Use a copy of a real drawing, not a live job.** Save nothing. Then close without saving.
6. **If AutoCAD does the wrong thing, do not fight it.** Write the bug number and what you saw next to the box. The desk files it.
7. **One thing is not our fault.** If you zoom in one drawing, switch to another drawing, switch back and press REDO, AutoCAD may say "Nothing to redo". A robot saw this in plain AutoCAD with no CE loaded (run 19, 11 Oct). Do not count it as a fail of any bug here. It is BUG-558, parked.
8. **Multi-part bugs.** Where one bug has several items, the line tests the main one. The carpark entry lists the leftovers.

---

# PART 1: CIVIL

## 1. Start AutoCAD, close it, Save As

**Robots could not check:**

- [ ] **BUG-231** Close AutoCAD with a drawing that has unsaved changes, choose Save. **See:** it closes cleanly, no crash message.
- [ ] **BUG-214** Type CEFIND on a clean new drawing, press Esc at the question, then close the drawing. **See:** no "Save changes?" box (Find must not change the drawing).
- [ ] **BUG-170** After an update, start AutoCAD once. **See:** the What's New window is big enough to read, easy colours, and only describes things that exist.
- [ ] **BUG-356** Same first start. **See:** What's New does not lock AutoCAD. You can click and type in the drawing with it open.
- [ ] **BUG-189** Place and edit pits, pipes and labels for about 15 minutes, then draw a SPLINE. **See:** the spline is as quick as on a fresh start, no stalls.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-164** Close AutoCAD five times (QUIT, QUIT with two drawings, X on the main window). **See:** no crash message. Robot PASS (Codex pass 17, three clean shutdowns, Civil 3.0.12).
- [ ] **BUG-224** Save As to a new name, then close that drawing with X and No. **See:** AutoCAD closes the drawing, no crash. Robot PASS in part (Codex C1 V7.02, one close cycle).

## 2. Ribbon, tabs, tooltips, window looks

**Robots could not check:**

- [ ] **BUG-172** Look along the CE Civil tab. **See:** every button has its own right picture, same size, level with its neighbours like CE STRUC.
- [ ] **BUG-173** Open PIT, Edit Pit, and double-click a pipe for Edit Pipe. **See:** all three look like the New Pipe window: same layout, nothing cramped, preview not tiny.
- [ ] **BUG-174** Run CDDESIGN and read the question about looking through the job's folders. **See:** the choices are only Yes and No (not "Yes / CE").
- [ ] **BUG-226** Type CDDISCIPLINE, then hover the ribbon button on a brand new drawing. **See:** the tooltip says the drawing is not set and lists Civil, Structural, Clear (no "Both").
- [ ] **BUG-227** Hover the Settings button. **See:** the words match the six tabs in CDS (Drafting, Pipes & Pits, Design, Survey, Display, Advanced). No Personal/Project/Firm promise.
- [ ] **BUG-228** Hover Data Diagnostics, run CDDIAG. **See:** no "PL-032" or "coming in v2.1" wording. The tooltip says what the command really does.
- [ ] **BUG-360** Click through Edit Pit, Edit Pipe and the Inspector palette. **See:** rows say "P3" or a pipe name, never a long code word or a bare handle like P:109601.
- [ ] **BUG-365** Open New Pit, CDDESIGN, Foundations manager, Drawing sheets, Repair Center. **See:** no code words in tab or row names. (Only visible to someone using a screen reader or a robot, so skip if short on time.)

**Robot already saw PASS (evidence only):**

- [ ] **BUG-180** With a drawing open, click one CE pipe. **See:** the Pipe tab comes to the front. Esc or CDCLOSETAB puts the ribbon back. Robot PASS in part (Codex C1: a single pipe worked; the Pit tab Close button was a different bug).

## 3. CD: draw a new pipe

**Robots could not check:**

- [ ] **BUG-187** CD between two pits, open Existing, More, turn "Include known grade" off, then Back to Stormwater. **See:** the proposed pipe and its "AT 1 IN 100" label show again in the preview.
- [ ] **BUG-447** Re-import a consultant job with a short real pipe whose two ends land on one pit wall. **See:** the pipe is not drawn as a zero-length dot. The line says "both its ends were matched to the same point... check it, and draw it with CD if it is needed".
- [ ] **BUG-427** CD from P10 to P9 with the same level (for example 18.500) at both ends. **See:** a plain flat-pipe warning, one clear sentence, not two.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-205** CD, two open ends, types levels 18.00 and 17.80, press Start Pipe, choose "Use level direction". **See:** the pipe flows from 18.00 down to 17.80, no uphill warning. Robot PASS (Codex C1 V8.03, for the Use level direction case).
- [ ] **BUG-442** CD P10 to P9 with 18.500 at both ends, press Start Pipe. **See:** the flat-pipe warning reads as one clear sentence. Robot PASS (Codex W-32, #789 flat label).

## 4. Edit Pipe (CDEDIT on one pipe)

**Robots could not check:**

- [ ] **BUG-166** Double-click an IL level text (for example "IL 16.98") beside a pipe. **See:** Edit Pipe opens, not AutoCAD's plain text editor.
- [ ] **BUG-171** Upgrade an older stormwater pipe (drawn before 23 Sep), double-click it. **See:** Edit Pipe says Stormwater, not Detention.
- [ ] **BUG-175** Double-click a pipe on a layer that looks like a rising main but is not one. **See:** the destination field and arrow match what the pipe really is.
- [ ] **BUG-223** CDEDIT a pipe with two "Open end" ends, change the levels the opposite way, Save. **See:** the direction follows the levels, or a plain warning. Never silently uphill.
- [ ] **BUG-244** Same pipe: drag one end grip, then reopen CDEDIT. **See:** the direction still follows the levels. No uphill return.
- [ ] **BUG-260** CD with "Use level direction", then open Edit Pipe at once. **See:** the "Flow:" line shows two different pits (not "P1 to P1"), and agrees with the arrow.
- [ ] **BUG-261** Draw a pipe with two free ends, levels 10.00 left and 11.00 right, "Use level direction". Change only the diameter 100 to 150, Save. **See:** no "flows uphill" warning.
- [ ] **BUG-278** Run CDFIXPIPEENDS on a pipe, then Edit Pipe and Save. **See:** the recorded flow direction is not flipped back.
- [ ] **BUG-160** Hold the pipe's bottom level (typed by hand), drag the pipe end longer. **See:** the preview window shows your typed number and the automatic number side by side. Plan text and schedule end up showing the same number.
- [ ] **BUG-255** In Edit Pipe look at the size suggestion on a pipe with an office minimum cover of 900 mm. **See:** the cover check uses 900, not a fixed 600.
- [ ] **BUG-252** CDEDIT a pipe whose material is STORMPRO, CMP or "EXISTING PIPE". **See:** no roughness number appears silently. It says Unknown, or uses a value from your Settings.
- [ ] **BUG-422** Size a pipe whose ground level is 0 or blank. **See:** the answer says cover cannot be checked. It does not say it works.
- [ ] **BUG-234** MOVE a pipe straight onto two other pits, then open Edit Pipe. **See:** From and To name the new pits on the right sides.
- [ ] **BUG-093** Grip a linked pipe's label or arrow and drag it. **See:** the label or arrow follows, then lands where you let go. (The carpark says the old fault class was removed in code.)

**Robot already saw PASS (evidence only):**

- [ ] **BUG-208** Fresh CD pipe on an unlocked drawing: stretch its end grip. **See:** the pipe end and CE's record move together. Robot PASS in part (Codex C1 V8.04, unlocked drawings only).
- [ ] **BUG-446** Edit Pipe, change a level, then Stop overriding. **See:** the red check marker is on layer CE GRADE CHECK, and REDO works. Robot PASS (Codex W-37, marker and REDO).

## 5. Edit 2 or more pipes at once (batch)

**Robots could not check:**

- [ ] **BUG-186** Select P10 to P11 and P11 to P8, grade 1 in 100, "Carry downstream". Preview, then Apply. **See:** all three pipes change as previewed. One U puts them back.
- [ ] **BUG-324** Select two pipes where one is an older pipe. **See:** the editor opens for the others, and a plain line names the one it left out.
- [ ] **BUG-339** Same two pipes, Apply with "No" to the downstream recalculation. **See:** it writes. Levels change as previewed.
- [ ] **BUG-350** Batch Apply with a grade like 1 in 54 or 68. **See:** it applies, no "did not retain the accepted grade". And a typed Pit Schedule edit then Revert keeps the pit named C1, not PC1.
- [ ] **BUG-351** Type a new pit number C2 in the Pit Schedule. **See:** it stays C2, not PC2. And a typed level on a fixed-grade pipe changes only that end.
- [ ] **BUG-353** Batch Apply on the IO8 to P3 pipe. **See:** plan level and Pit Schedule agree (both 18.29 or both 18.10). The pipe label is not left at the old grade.
- [ ] **BUG-346** Copy a pit, then move the copy after a CDREPAIR. **See:** the number label and cover text follow it.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-289** Run CDFIXPIPEENDS on a pipe, then look at the Pit Schedule and the flow arrow. **See:** both refresh straight after the repair, not at the next edit. (Robot saw the OOPS wording line of BUG-339 PASS: "OOPS brought back pit P2 with its label, and pipe", Codex C6-07.)

## 6. Move, copy, erase and paste pits and pipes

**Robots could not check:**

- [ ] **BUG-210** Erase a pit, then COPY another pit onto the junction. **See:** the new pit links to the pipes at once (Edit Pit and the Pit Schedule agree).
- [ ] **BUG-266** In a big drawing (about 300 pipes) COPY one pit far from every pipe. **See:** it finishes in about a second, not 5 seconds.
- [ ] **BUG-269** ARRAY or COPY many pipes (about 300). **See:** a quiet progress line, and it finishes in well under 48 seconds.
- [ ] **BUG-267** Erase a pit, then OOPS. **See:** pit, number label, cover text and pipe all come back, and one U removes them together.
- [ ] **BUG-285** Erase one pipe, OOPS, then MOVE its end pit. **See:** the pipe follows the pit.
- [ ] **BUG-268** Copy pits so a pipe's record was wrong, then Edit Pipe and Save. **See:** the record is repaired, not put back wrong.
- [ ] **BUG-342** Paste CE pits and pipes into a drawing with no drainage yet. **See:** one plain line telling you to run CDREPAIR.
- [ ] **BUG-305** Paste pits from another drawing, then MOVE the pasted pit. **See:** a line pointing to CDREPAIR, and the pit labels move with the pit.
- [ ] **BUG-312** Lock the label layer, edit a pit, close and reopen, then Refresh the Pit Schedule. **See:** the held-back labels are brought up to date.
- [ ] **BUG-257** MOVE a pit, click the drawing tab X, choose Cancel, press U. **See:** the pit goes back. REDO works.
- [ ] **BUG-192** MOVE a pit, then U, then REDO (nothing typed between). **See:** the pit goes back, then forward again.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-256** U then REDO in Civil and Structural. **See:** "Everything has been redone". Robot PASS in part (run 9 on Civil 3.0.42: 5 of 5; run 13: 4 of 4). It is not true after a drawing switch (note 7 above).
- [ ] **BUG-325** Erase a pit, its label and a pipe together, OOPS. **See:** a plain CE line saying what came back. Robot PASS in part (Codex C5: things came back, one U removed them together).
- [ ] **BUG-258** Place a perimeter drain (CDPERIMETER), ERASE the line, OOPS. **See:** the line and its PD1 text both return. (Robot saw this fail on 3.0.17 before the fix: no PASS yet.)

## 7. PIT and Edit Pit

**Robots could not check:**

- [ ] **BUG-317** Insert a pit at scale 0.001, check the tooltip and size in Edit Pit. **See:** a real size (not 0 x 0 mm), and Pit Schedule and CDCHECK show the same size.
- [ ] **BUG-098** Rename or renumber a pit, then look at the plan label, CDINSPECTOR and the schedule. **See:** all three say the same number.
- [ ] **BUG-426** In Edit Pit or the Pit Schedule, type a pit number another pit already uses (for example 9 when P9 exists). **See:** a plain refusal naming P9. (Codex W-20 saw the refusal message; the full check is open.)
- [ ] **BUG-420** In the Pit Schedule type a bare "2" over P1 when P2 exists. **See:** a plain refusal, P1 keeps its number.
- [ ] **BUG-176** CDRG four boundary points, Close, Place, pick a fresh straight pipe. **See:** the grated inlet lands or one plain line says why not.

## 8. Pit Schedule

**Robots could not check:**

- [ ] **BUG-212** On an older drawing, PITSCHEDULE, Place schedule. **See:** a schedule is drawn, or the window offers a one-click repair. No "could not be stored together".
- [ ] **BUG-232** Lock the schedule layer, MOVE a pit. **See:** the cell is skipped and the pit named. Nothing written.
- [ ] **BUG-246** Same lock, unlock afterwards. **See:** the window shows that pit's row out of date until refreshed.
- [ ] **BUG-262** Lock a layer, then edit a pit. **See:** the line names the pit, the layer and the column. It does not say only a number like 114438.
- [ ] **BUG-396** Double-click a placed Pit Schedule table cell, type C2 into P5's cell. **See:** the pit is renamed. If nothing happens, tell the desk (not a regression, but the feature then does nothing).
- [ ] **BUG-376** Open the Pit Schedule on pit P3 (from WT10). **See:** IL (Inlet) and IL (Outlet) are filled in, not blank.
- [ ] **BUG-385** Revert Row Override on a row. **See:** the row stays. Rows do not disappear.
- [ ] **BUG-387** Open PITSCHEDULE, edit, close, U, reopen. **See:** type CLAYER. It names your current layer (never blank).
- [ ] **BUG-408** Stop overriding on a row. **See:** the footer sentence "Stop treating this row as an override. The values you typed stay."
- [ ] **BUG-309** In a metre drawing, edit a diameter in the Pit Schedule. **See:** the pipe label grade stays sensible (1 IN 100, not 1 IN 100000).
- [ ] **BUG-322** Same edit in a metre drawing. **See:** the pipe label stays near the pipe, not hundreds of metres away. A hand-moved label does not jump back.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-207** Edit a pit cover 20.00 to 20.10. **See:** the drawn schedule shows 20.10 straight away. Robot PASS (Codex C1 V8.04, unlocked drawings).

## 9. CDCALC, council figures, sheets

**Robots could not check:**

- [ ] **BUG-158** Run CDCALC export with Detention, Pipe Flows, Catchments and WSUD all ticked. **See:** five sections, the computations sheet first. If the sheet cannot be built, a plain warning on screen.
- [ ] **BUG-233** Open the computations sheet PDF on a detention job with an orifice. **See:** every source reads as a document name and page. No file path, no web link.
- [ ] **BUG-239** Run CDRULES and CDAUTO on a job with council rules. **See:** sources read as document name and page. No path or link.
- [ ] **BUG-251** Kingston commercial job: check PSD storm and time of concentration. **See:** the commercial values from K02 page 14 (PSD 1 in 10, Tc 7 minutes), or a plain note. This needs your word on the pre-development C rule.
- [ ] **BUG-432** CDTG trench grate: press Enter at the cover-level question, then draw a pipe from it and open Edit Pipe. **See:** the cover level is blank (Unknown), not 0.000, and no "Insufficient upstream cover -45300mm".
- [ ] **BUG-242** Open an older metre drawing with a raingarden, select it. **See:** the area shows with a note it can be re-measured. Not a plain "0.0 m2".

## 10. Catchments, pavement, raingardens, falls

**Robots could not check:**

- [ ] **BUG-209** CDCATCHMENT New, draw a small closed rectangle beside a grated pit (about 28 m2), pick the pit. **See:** about 28 m2 and no false capacity warning.
- [ ] **BUG-230** In a metre drawing and a mm drawing draw the same pavement. **See:** PAVE, the raingarden tool and the design window agree on the area.
- [ ] **BUG-243** In a metre drawing show the surface overlay. **See:** labels are a readable size.
- [ ] **BUG-216** CDFALLSUGGEST, place one arrow, press Enter at "Next level". **See:** the command ends and reports the count.
- [ ] **BUG-217** CDPERIMETER two points, accept. **See:** the drain is labelled PD1 on the plan.
- [ ] **BUG-236** ERASE, MOVE and COPY a perimeter drain. **See:** its PD1 text follows or goes, and the text height reads from Settings.
- [ ] **BUG-012** Run CDFALL. **See:** the "1" of "1:80" sits directly under the "F" of FALL, at any arrow angle.

## 11. Import from X-Civil or LandXML

**Robots could not check:**

- [ ] **BUG-058** Import the 26612 package, run CDCHECKDWG. **See:** no "has no ProjectData entry" for the 18 IO/OF pits.
- [ ] **BUG-059** Import once, then re-import. **See:** one consultant pipe is one CE pipe. No doubles. DesignCheck shows no identical pairs.
- [ ] **BUG-060** After the import, run DesignCheck. **See:** no "P1 to P1" and no circular dependency.
- [ ] **BUG-283** Lock a layer, then import. **See:** the layer stays locked, or the import names it and asks.
- [ ] **BUG-417** Import with a locked layer in the drawing. **See:** the import asks or skips. It never unlocks quietly.
- [ ] **BUG-551** CDIMPORTXCIVIL with "try AI extraction" at its default. **See:** nothing is sent out. (A robot watched the network and saw nothing sent in a short test, run 11. The on-screen wording was not read.)

**Robot already saw PASS (evidence only):**

- [ ] **BUG-440** Re-import the W26-26 copy into a blank drawing. **See:** the post-import check and one U takes the whole import back. Robot PASS (Codex W-38, Civil 3.0.39).

## 12. Metre and non-mm drawings

**Robots could not check:**

- [ ] **BUG-328** In a metre drawing CD a 10 m pipe at 1 in 100. **See:** "1 IN 100" and sensible levels (not "1 IN 1").
- [ ] **BUG-331** In a metre drawing CD a pipe 1 m or shorter. **See:** it is allowed. A pipe at 1 in 100 reads right after a pit move.
- [ ] **BUG-323** Metre drawing, CD a 30 m pipe, open Edit Pipe, More, Levels & Flow. **See:** route 30 m (not 30 mm), a real fall, a suggestion.
- [ ] **BUG-330** Metre drawing: look at the Pipe tab route and the detention length. **See:** metres everywhere (not "30000 mm").
- [ ] **BUG-393** Open an older metre drawing saved before the BUG-331 fix and check pipe lengths in Edit Pipe and the Pit Schedule. **See:** lengths are right, not 1000 times short.
- [ ] **BUG-270** Metre drawing: move a pit near a pipe end. **See:** the pipe re-links to the pit.
- [ ] **BUG-271** Same in a drawing with unusual units. **See:** same result, or a plain note on a unitless drawing.
- [ ] **BUG-281** Metre drawing: split a pipe at a downpipe source. **See:** the right reach is used (not 150 m).
- [ ] **BUG-329** Metre drawing: edit and refresh. **See:** no label jumps to its default spot after a hand move.

## 13. Locked layers, Xrefs and protection

**Robots could not check:**

- [ ] **BUG-284** Lock a layer, then edit an item on it. **See:** one plain line naming the layer. No error box and no silent change.
- [ ] **BUG-313** Lock the pipe layer, try to change a pipe. **See:** the line names the locked layer. Nothing changes.
- [ ] **BUG-384** Lock the pipe layer, Edit Pipe and Save. **See:** the message is plain and names the layer.
- [ ] **BUG-363** Lock the pipe layer, MOVE pit P11. **See:** pit and labels move, pipes stay, one [CE] line, one U puts it back.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-254** Lock the pit layer, COPY or relink a pit. **See:** the record is untouched and named. Robot PASS in part (Codex C5-08 b).
- [ ] **BUG-364** Lock the pipe layer, MOVE a pit. **See:** one line, labels stay "1 IN 100". Robot PASS (desk driver run 6).

## 14. Plain wording on the command line

**Robots could not check:**

- [ ] **BUG-372** STRETCH or MOVE a pit so an IL text has no clear spot. **See:** the line names the pit or pipe (P8), not a code and a block name.
- [ ] **BUG-377** Trigger the warning that used to show "\U+2192". **See:** an arrow or the word "to".
- [ ] **BUG-389** Run the CDCHECK list on old pipe names. **See:** readable names, not "AGI\U+2192C1". Robot partly checked (run 22, 6 PASS; this exact line not named).
- [ ] **BUG-378** Open a drawing holding old pipes. **See:** they upgrade at once on the first open, not on a second open.

---

# PART 2: STRUCTURAL (roof down to footings last)

## 15. Start-up, launcher, settings

**Robots could not check:**

- [ ] **BUG-220** Close AutoCAD, double-click a Structural drawing. **See:** no launcher window opens by itself.
- [ ] **BUG-203** Open a Structural drawing and draw for 10 minutes. **See:** no lag. Civil stays asleep.
- [ ] **BUG-265** Open a Structural drawing, place a column. **See:** no "[SUPPORT-DEBUG]" or "[BEAM-DEBUG]" lines, and no pointless restart request.
- [ ] **BUG-204** Open CESETTINGS. **See:** your rules are all still there, and the settings file stays small (under about 200 KB).
- [ ] **BUG-429** Open CESETTINGS and check your floor and mark rules. **See:** they are all there. Structural 1.0.105 and later rewrote your settings file at the first start (24,377 bytes to a smaller file), so read it over.
- [ ] **BUG-272** In AutoCAD 2027 run CSUNITTOOLS or CSUNITCOPY. **See:** no "Method not found" warning, and the job file is saved next to the drawing.
- [ ] **BUG-273** Same commands with the job file read-only. **See:** one plain line, and the command still finishes normally.

## 16. Roof, floor and wind setout

**Robots could not check:**

- [ ] **BUG-433** Run CSROOFSETOUT, read the rafter spacing question. **See:** the default shows once ("<450>"), not twice.
- [ ] **BUG-443** Run CSFLOORSETOUT, read "Spacing in mm". **See:** the default shows once, and Enter takes your Settings value.
- [ ] **BUG-424** BTX: press Enter at once with nothing picked. **See:** the same as picking nothing on purpose. No error.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-394** Run the wind class command, BEXTEND and the roof-down chain. **See:** each list shows once, and Enter keeps your saved choice. CSREOBAR shows bar size, number, spacing and face once each. Robot PASS (driver run 26 for the roof-down chain; Codex W-44 on 1.0.110 for CSREOBAR).

## 17. Beams

**Robots could not check:**

- [ ] **BUG-185** In a metre drawing place a beam at exactly 45 degrees from a rectangular column. **See:** it places like any other angle.
- [ ] **BUG-211** Place a column, place a beam on it, ERASE the column. **See:** a question or a clear message about the beam. U puts it all back.
- [ ] **BUG-237** ERASE a column that has a beam, then OOPS. **See:** the beam is linked to the column again. MOVE the column and the beam follows.
- [ ] **BUG-250** Same with the older "command 8" beam linking switched on. **See:** the beam follows, or one plain line says why not.

## 18. Columns, supports and bracing

**Robots could not check:**

- [ ] **BUG-437** Place C1 and, at "Pick desired support text location", press Enter. **See:** Enter means auto, or the prompt tells you to type A. No "Invalid point" loop.
- [ ] **BUG-450** Same prompt, press Enter. **See:** "Label on the right: enter its text, then click where it goes." It does not say "Text placed" before anything is placed.
- [ ] **BUG-434** Start C1 or TS1 and cancel at the rotation question. **See:** your current layer is as it was before. No "Duplicate definition of block _Dot" line.
- [ ] **BUG-218** Type CSBRACINGPANEL. **See:** the bracing panel is on screen and in front.
- [ ] **BUG-428** Place a BB brace. **See:** it places once with a sensible label. (Seven minor items sit in the entry.)

**Robot already saw PASS (evidence only):**

- [ ] **BUG-438** C1: cancel at the text-location question. **See:** current layer back to what it was, and the half-placed column disappears. Robot PASS for the cancel (Codex W-28 on 1.0.107, #810). The label after a bare Enter at append-number failed on W31-03 then, so look at that too.

## 19. Annotate, revision cloud, bars and schedules

**Robots could not check:**

- [ ] **BUG-169** Run RC, draw a cloud, press Enter to repeat. **See:** your current layer is restored, not forced to 25CONT. Same for the other Structural commands.
- [ ] **BUG-215** Draw a cloud with RC, then press U once. **See:** the cloud is gone with one U.
- [ ] **BUG-264** Open the Annotate flyouts (text, hatch, symbol). **See:** they fit on screen and scroll, with one entry per command.
- [ ] **BUG-263** Run XCLMTXT review with one low-confidence item. **See:** the row is visible and you can select it. The banner matches the header about past jobs.
- [ ] **BUG-195** XCLMTXT import of a CSV with no floor column. **See:** the rows are not silently put on First and Second Floor. The review says they need attention.
- [ ] **BUG-277** Drag a rebar grip. **See:** the live length shows and the label follows.
- [ ] **BUG-368** LINE, then CSREOBAR, then U, U. **See:** the second U removes the LINE. Robot saw it fail on 1.0.93, then PASS (desk driver run 11 on 1.0.94: "U1 echoes CSREOBAR"; Codex W-44 on 1.0.110: one U removes the bar, REDO restores it).
- [ ] **BUG-369** CSREOBAR, RBL, RBC, STR, BWT with 35CONT frozen. **See:** the layer is left as you had it, or a plain line says so.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-366** STR typed, and CSBARSCHEDULE on an empty drawing. **See:** one U takes each back, the settings file untouched. Robot PASS (desk driver run 8, 1.0.92).
- [ ] **BUG-367** CSREOBAR on a drawing with no 35CONT layer. **See:** the bar and the new layer go with one U. Robot PASS (desk driver, 1.0.93).
- [ ] **BUG-370** LINE, CSREOBAR, U, U, then a bar and CSBARSCHEDULE with U. **See:** each U takes back exactly one thing. Robot PASS (desk driver run 11, all).
- [ ] **BUG-388** FDELETE: pick a footing line. **See:** the question shows "[Yes/No]" once, not twice. Robot PASS in part (desk driver run 21, prompt wording).
- [ ] **BUG-423** Run CDFIXFLATPIPES on flat pipes and read the line. **See:** a pipe held at 1 in 5 now gets a "steep, check it" line where it used to say "Check by hand". Tell the desk if that is what you want. (Real login or computer names still appear in three places: old report files, the Manager report, support-zip names. That is a question for you.)

## 20. Sheets and issue

**Robots could not check:**

- [ ] **BUG-398** Preview an issue revision on a job where some sheets have not changed. **See:** the preview and the real issue agree. Unchanged sheets are not re-stamped.
- [ ] **BUG-405** Make a Structural support or fault report and open it. Then look in `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox\machines`. **See:** no login name and no computer name in the report or in the Civil file name (the Civil name showed your real login and PC name when a robot looked on 5 Oct).

## 21. Footings (FST, FEDIT, FDELETE) last

**Robots could not check:**

- [ ] **BUG-333** Lock 25TEXT, STRETCH a strip footing, unlock, then FREGEN. **See:** one outline, not two. A line names the locked layer.
- [ ] **BUG-334** MOVE a pad's line, then press U. **See:** the line goes back too (one U takes back your edit).
- [ ] **BUG-335** Grip a pad from 600 to 900. **See:** the schedule says 900 x 900 and CSLOADPATH checks the new place. ERASE PF2 then PFC: the schedule no longer lists PF2.
- [ ] **BUG-336** FDELETE on a footing with a locked outline layer. **See:** the line names the layer. No pieces left.
- [ ] **BUG-341** STRETCH one side of a pad with a crossing window. **See:** the schedule and outline agree, and one line says if the pad is no longer a rectangle.
- [ ] **BUG-344** In a metre or inch drawing run a footing command. **See:** it reads the drawing in its own units with one plain line. No Yes/No question.
- [ ] **BUG-348** Same drawing, centimetres but drawn in mm: run CSFOOTINGSCHEDULE. **See:** "600 x 600", not "6000". (Known open item: the entry lists a leftover.)
- [ ] **BUG-352** Raft-only drawing set to cm but drawn in mm: FREGEN. **See:** the 300 beam stays 300 in the schedule.
- [ ] **BUG-362** FEDIT near a strip footing edge close to a pad. **See:** the command names the right mark.
- [ ] **BUG-276** SAVEAS a copy of a drawing with a confirmed level. **See:** the copy shows it as a suggestion until you confirm.
- [ ] **BUG-381** Open and close the Foundations manager. **See:** the drawing is not marked changed (no Save prompt on close).
- [ ] **BUG-382** Look at the FST status line. **See:** one plain sentence, no "elements=4 orphans=0 generated=4" tail.
- [ ] **BUG-418** Run SF, BSF or STRIPLAYERSMERGE with a locked layer in the drawing. **See:** the locked layer is untouched, and the tidy-up runs quietly.
- [ ] **BUG-413** FEDIT on a pad. **See:** five questions, each once. LIST confirms 600 x 600. Robot PASS (Codex W-11c on 1.0.102).
- [ ] **BUG-315** Footing schedule with DIMSCALE 0. **See:** text height sensible. (One open question for you in the entry.)
- [ ] **BUG-303** FST delete or ERASE a footing. **See:** the footing and R.C. beam schedules update.
- [ ] **BUG-314** Close a Structural drawing, open another. **See:** the second drawing does not show the first one's footings. REDO still works.

**Robot already saw PASS (evidence only):**

- [ ] **BUG-355** Pad MOVE or STRETCH then U and REDO. **See:** pad and outline come back together. Click a pad OUTLINE with FEDIT and it edits that pad. Robot PASS in part (desk driver run 1, S-01 to S-03; the real mouse click is open).
- [ ] **BUG-358** Lock the schedule layer, run FREGENALL or FSTEXPORT. **See:** a plain "on a locked layer" line, layer stays locked. Robot PASS (desk driver run 2, S-06; also ERASE plus FREGENALL took two U on 1.0.93).
- [ ] **BUG-454** FSF Enter and FPFC label. **See:** each behaves as the entry describes. Robot PASS in part (Codex W-44: 2 of 5; the Enter and label items were open).

---

# PART 3: MANAGER, SETTINGS, ADMIN

## 22. Manager, updates, blocks, settings

**Robots could not check:**

- [ ] **BUG-165** Start AutoCAD and read the Manager update line. **See:** no "staging CE_CVL_SUITE 2026.0420.1549" and Civil stays on its version.
- [ ] **BUG-188** Place a block from CEBLOCKS that has attribute tags. **See:** the tag text shows, and the block moves and rotates live under the cursor.
- [ ] **BUG-306** Place a pit and watch CD_Settings.json. **See:** only the recent values are saved, or the file only changes when you press Save in Settings. This needs your keep-or-move ruling.
- [ ] **BUG-259** CDDESIGN, run Confirm setup. **See:** the outlet is kept, and During opens after a successful confirm, or a plain line says what is missing. (The entry says a design-from-scratch job may not record an agreed design yet: that part is a known limit.)
- [ ] **BUG-435** Start AutoCAD, read the command line. **See:** the start-up lines are plain. Commands that are switched off say so in one sentence.
- [ ] **BUG-357** Lock the pit layer, MOVE a pit on a modern CE pipe (not an old one). **See:** the line says CE left the pit's record as it was and never unlocks a layer. One U puts it back. Robot PASS in part (desk driver run 6, #557 line).

**Robot already saw PASS (evidence only):**

- [ ] **BUG-380** Open CEMANAGER with Civil loaded. **See:** "3 of 3 installed CE tools running". Confirm LPD is grey with a plain hover reason on the non-Start tabs. Robot PASS (Codex W-3, 3 of 6).

---

# SKIP: nothing to see in AutoCAD, or too hard to trigger by hand (13 bugs)

These are code or test fixes, or a failure that only happens when something else breaks. No tick from you. The AI closes each after a Codex pass or by reading the test result.

- [ ] **BUG-299** Settings save after a failed file swap (wording and a leftover file). Only shows when a save fails.
- [ ] **BUG-302** Wording in the code about a metre-drawing ruling for FADOPT. No visible change.
- [ ] **BUG-316** Structural settings and units follow-ups (four code items).

- [ ] **BUG-247** Installer tests agree with each other.
- [ ] **BUG-253** One shared pipe write check instead of two copies. Behaviour unchanged.
- [ ] **BUG-275** Structural health palette no longer attaches itself again on every scan in AutoCAD 2027.
- [ ] **BUG-279** Structural code that compares drawings by identity in AutoCAD 2027 (the footing lookup item is not fixed).
- [ ] **BUG-318** Test hygiene (four tests that fail in some orders).
- [ ] **BUG-332** Structural test and code tidy-ups from S-4.
- [ ] **BUG-375** Test tidy-ups, not Tim-facing.
- [ ] **BUG-407** CSFDNPROPOSE guard tests (hidden command).
- [ ] **BUG-425** Second source audit follow-ups (25 items, no single check).
- [ ] **BUG-457** REDO test gaps (no defect found). Robot evidence: run 10 and run 14 saw #881, #887, #893 and #902 PASS.

---

# The 10 checks that matter most for real jobs

1. **Metre drawing levels (BUG-328, 331, 323).** CD a 10 m pipe at 1 in 100. Wrong levels here put a wrong number on a council drawing.
2. **Catchment area (BUG-209, 230).** CDCATCHMENT must give about 28 m2, not 28,000,000, and no false capacity warning.
3. **Pipe direction and levels (BUG-205, 260, 261).** Draw a pipe with two levels. It must flow downhill, with no uphill warning.
4. **Pit Schedule follows your edit (BUG-207, 208, 350, 351).** Change a cover or an IL: the drawn schedule, plan text and record agree.
5. **CDCALC sheet is in the export (BUG-158, 233).** Five sections, the computations sheet first, no file paths in the sources.
6. **Council values (BUG-251, 252, 255).** Kingston commercial storm, material roughness and minimum cover. Wrong values reach a council.
7. **Locked layers respected (BUG-254, 284, 232).** Lock a layer, edit a pit, and nothing on the locked layer changes.
8. **Crash on closing or Save As (BUG-164, 224, 231).** A crash loses a colleague's work.
9. **Import does not double pipes (BUG-058, 059, 060).** Re-import must not stack pipes on top of each other.
10. **Footing schedule matches the pad after a grip edit (BUG-334, 335, 341).** And one U takes back your edit, not CE's redraw.

Also worth a look: **Undo and Redo after a pit MOVE (BUG-192, 256, 257).** Robots saw it work on 3.0.42 (run 9, run 13).

---

# How long this should take

1. **Civil sections 1 to 14:** about 2 hours 15 minutes. Many ticks share one drawing session.
2. **Structural sections 15 to 21:** about 1 hour 30 minutes.
3. **Manager section 22 and the skip list:** about 20 minutes.
4. **Total: about 4 hours. Skipping the robot-checked lines saves about 30 minutes.**
5. **This is my estimate, not measured.** Split it across two sittings (Civil, then Structural and Manager). Do the top 10 first, about 40 minutes.

---

# What I did not do

1. **I did not run anything in AutoCAD.** Robot PASS lines are quoted from the carpark entries and the driver and Codex reports. I did not open the evidence screenshots.
2. **I did not check that every fix covers every item** in the multi-part bugs. Some lines test only the main item.
3. **Robot evidence was matched by bug number and by what the carpark quotes.** If a Codex report tested a fix without naming the bug number, I would not have found it. So some lines marked "robots could not check" may already have a PASS.
4. **I did not check that each fix is still included in 3.0.47 and 1.0.115.** I read the version numbers only.
5. **Where the carpark only quoted a hypothesis from reading code, I wrote the steps from its "Steps for Tim/Codex" line.** BUG-396, 425 and 432 were too vague for a clean step. 396 and 425 went to the skip list.
