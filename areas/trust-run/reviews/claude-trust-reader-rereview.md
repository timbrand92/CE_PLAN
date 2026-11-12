# Re-review: draft PR 2040, `claude/trust-reader` (step 0: the read-only reader, the scorer, and now the part that fills the copy)

**Reviewer:** lane trust-review (sixth run), Fri 13 Nov 2026, 01:28 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO is evidence for testing on copies, never acceptance.
**What was read:** `git diff 71382aa0...origin/claude/trust-reader` at head `222a303e` (three commits since my third-run review: `3eb415c9` the eight review fixes, `ab4fc1f7` the part that fills the reader's copy from a real drawing, `222a303e` the old palette blocks found in AutoCAD; 23 files, all under `Services\TrustReader`, `Services\TrustReaderFill`, their tests and fixtures, plus `REGRESSION_LOG.md`). The earlier head `71382aa0` is an ancestor (no rewrite). Checked against my review `reviews\claude-trust-reader.md`, the lane file `areas\trust-run\trust-reader.md` (defaults list) and `areas\trust-run\OLD_BLOCKS_FOUND.md`.

---

# FOR TIM

1. **All eight faults from the last review are fixed.** The marking tool can no longer be fooled by a reader that reads nothing, metre and millimetre copies of a job read the same pit sizes, and when CE's record and the plan disagree the reader now says Unknown with both values.
2. **New: the part that copies a real drawing for the reader.** It only reads (one read-only pass, nothing opened for writing, CE's record read as plain text, CE's record update never started), and a test fails if any write is ever added.
3. **New: the reader now knows the old palette pit ("Stormwater Pit"), the old level blocks, the old "100 DIA. PIPE" blocks, the old downpipe and the old tanks,** all offered as proposals, never as facts.

**Verdict: GO** for the robot to run the reader on copies (probe P3). Built yes (by its lane). Tested: unit tests only, by its lane (138 of 138 trust-reader tests after the fixes, net10 and net48; the filler and palette counts are in its commits); not re-run here. Installed no (nothing calls it yet). Accepted no.

---

## 1. The eight FIX FIRST items, one by one

1. **The scorer took CE identity from the reading it marks: FIXED.** Identity now comes from the drawing copy (in CE's record, CE's pipe object, CE pipe data on the line, a CE tag, a stored LPD; `TrustReadingScorer.cs` 240-271), deliberately not shared with the reader's code. A reader that reads nothing fails all five made-up jobs (`TrustReadingScorerTests.cs` 59-64), and on MADEUP_CURRENT for the right reason ("25 Unknown on objects that carry CE's identity", 66-74). A reader that says Unknown everywhere fails the five jobs where the drawing shows something (76-84); on the hand-drawn job the honest reading is Unknown everywhere, so only the unrecognised-blocks list can catch a reader that skips it, and it does (86-95).
2. **The nearer-pit twin failed only because of a hand edit: FIXED.** MADEUP_TWOPITS now gives the shared label to the farther pit; the twin is a real nearest-pit reader, with no hand edit, and fails on its own with "1 Proposed wrong" on the nearer pit (test 118-129).
3. **Pit sizes in a metre drawing: FIXED.** `PitSizeFromBlock` (`TrustDrawingReader.cs` 328 on) uses CE's existing units-change rule, so a pit at 0.001 in metres reads 600, not Unknown; a pit scaled by hand, or a scale-1 pit in a metre drawing, stays Unknown with the reason. MADEUP_METRES now has realistic 0.001 pits and a 900 pit drawn 0.9 wide; a twin that skips the units change fails the metre job and passes the millimetre one, which is exactly why the metre job exists (test 133-144).
4. **Record against label and block kept as one answer: FIXED.** Record and label disagreeing on a number gives Unknown with both values (585); record and block disagreeing on a size gives Unknown with both (297). Pit type is deliberately not compared yet (the wording has not been checked on a real job), and that is listed as a DRAFT default.
5. **Oldest names Sure by name: FIXED.** "PIT BLOCK" and "PIT LABEL" with nothing of CE's on them are Proposed, "oldest CE name, not yet confirmed from old jobs" (81-84); Sure only when in CE's record.
6. **A copied downpipe read as two Sure downpipes: FIXED.** The same CE tag on two blocks gives both Proposed, "same identity twice", every value offered, not stated (368-378).
7. **Personal Settings changed the reading: FIXED.** One doorway, `TrustReaderSettings.FromOfficeSetup`, returns built-in office values only; nothing is read from the person's Settings file; layer renames are deliberately not read until the office setup carries them; the wrong comment is gone. This settles queue item 6 as "into the office setup", as asked.
8. **Defaults unlisted and partly unmarked: FIXED.** The four unlisted defaults (possible pipe, drawn width as a size, no units read as millimetres, record against drawing) are items 10 to 13 of the lane file's defaults list; the downpipe-label reach moved into the office values; the scorer's defaults are marked in its code; every reach and pattern in the new code says "DRAFT default, Tim to confirm".

## 2. The new parts

1. **The filler (`Services\TrustReaderFill\TrustSnapshotFiller.cs`): reads only.** One open-close transaction, every object opened for read, no commit needed and none made; blocks (effective name, attributes, dynamic sizes, scale, CE tag and its label), polylines (vertices, drawn width, CE pipe object or older form, CE pipe data), lines, single and multi-line text, and CE's record through the existing detached reader that Check Current Drawing uses (`CurrentDrawingCheckService.TryReadProjectData`, already at `cf059dcf` line 582). The CE tag readers it calls open for read only (`SourceTagService.cs` 375-388, 814-826). The record is read as raw text, so CE's own model classes cannot put 450 x 450, GRATED PIT or UPVC into a blank. Guard: a test follows every call the compiled filler can make and fails on a write, a normal transaction, a lock, a system variable, a command or a path into CE's record update, with three broken twins (`TrustSnapshotFillerTests.cs` 39-107).
2. **The old palette blocks: proposals only.** "Stormwater Pit" (any capitals) is a Proposed pit; a plain number or level text beside it within 2000 mm is Proposed with the distance, converted for drawing units (`TrustDrawingReader.OldPalette.cs` 164); a text within reach of two pits, or two texts beside one pit, is Unknown with both named, never the nearer. Twins: ignores the old pit, reads it as Sure, gives a shared text to the nearer pit; each must fail.
3. **No new FIX FIRST.**

## 3. Worth knowing (not blocking the robot)

1. **The filler does not fill CE's stored LPDs yet** (change log, filler item 5; TRUST-07 rewrites them). On a real copy whose answer sheet lists an LPD, the scorer will count that LPD as Unknown on a CE object and fail the job. Either leave LPDs off the sheets for now or score LPDs separately until the filler reads them.
2. **Model space only.** Drainage inside an Xref (plan case 4) and schedules on layouts (case 5) are not in the copy; the reading should say so on such a drawing rather than read as complete.
3. **The answer sheets now carry "shown on the drawing" lists.** An Unknown counts as honest wherever the sheet does not list the value as shown, so the template for real sheets (T01 to T10) needs that column filled with care, or a lazy sheet lets a lazy reader pass. Add it to the template notes (my last review, section 3 item 2: also which end is "start", and how an LPD is named).
4. **Office pipe sizes start at 100** (no 90); "EX DRAIN HATCH" is in the pipe layer list (taken from CE's layer names). Both DRAFT defaults; worth a glance when Tim confirms the list.
5. **Earlier "worth knowing" items 3 to 6** (downpipe words inside other names such as STANDPIPE, non-Western digits, 2024 against 2027 number format, a fill offered as a proposal in the unit check) are unchanged; the scorer still catches the last one on a made-up job.

## 4. Not checked

1. Did not build or run tests; counts are the lane's.
2. The filler has never run on a real DWG (nothing calls it); whether a CE pipe object reads as a polyline when its enabler is missing on a PC (it would come through as a proxy and be left out) is not proven.
3. No real old LISP job or old palette drawing was read by me; the palette rules rest on `OLD_BLOCKS_FOUND.md`.
4. Raingardens, Structural blocks and paper space are outside the reader.
