# Review: draft PR 2040, `claude/trust-reader` (step 0: the read-only reader, old LISP text, made-up jobs, the scorer)

**Reviewer:** lane trust-review (third run), Thu 12 Nov 2026, 23:55 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO here would be evidence, not acceptance.
**What was read:** `git diff cf059dcf...origin/claude/trust-reader` at head `71382aa0` (three commits, 25 files, all new except `REGRESSION_LOG.md`), `gh pr view 2040`, `areas\TRUST_READER_DESIGN_12NOV.md`, `areas\TRUST_TEST_SET_12NOV.md`, `areas\trust-run\trust-reader.md`, and the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf) for the helpers the reader calls.

---

# FOR TIM

1. **The reader only reads and never picks the nearer of two.** It works on a plain copy of the drawing and has no way to change one; two pits, labels or texts in reach give Unknown.
2. **The marking tool can be fooled.** A reader that reads nothing at all would pass every made-up job, and the "picks the nearer pit" test only fails because the test also changes a second pit by hand.
3. **Two reading rules need fixing:** pit sizes read in a millimetre copy but come out Unknown in a metre copy of the same job, and when CE's record and the label on the plan disagree, the record wins as a fact.

**Verdict: FIX FIRST** (eight items below). Built yes (by its lane). Tested: unit tests only, by its lane (82 of 82, net10 and net48); I did not run them. Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Can it ever write? NO, by construction.**
   1. Every new file is plain data and plain arithmetic. No AutoCAD type, no file, clock, setting or log access in `Services\TrustReader\` (the source guard in `TrustDrawingReaderTests.ReaderFiles_HoldNoDrawingWorkSettingsReadClockOrFileAccess` checks the folder; I re-read every file).
   2. The helpers it calls outside that folder are pure: `DrawingAreaUnits` (unit sums), `SourceFamilies.CategoryOf` / `Find`, `LayerNameRule.Resolve` (re-read at cf059dcf; no writes, no logging).
   3. The copy is unchanged after reading (`ItOnlyReads_TheCopyIsUnchangedAfterReading`, and every made-up job compares the copy before and after).
   4. The only route to a real drawing is the part that fills the copy, which is not built. That is where "only reads" must be proven next (queue item 6).
2. **Can it pick the nearer of two? NO, for every rule I traced.**
   1. Label to pit: all candidates are worked out first; two pits in reach, two labels for one pit, a label whose only pit already has a stored label, and a label stored as linked to two pits all give Unknown (`TrustDrawingReader.cs` 409-499; context 687-695).
   2. Old LISP text: two texts beside one line, one text beside two lines (CE pipes counted as candidates), and an "IL" near two pipe ends all give Unknown (`TrustDrawingReader.OldLisp.cs` 55-97).
   3. Drawn width and text disagreeing gives Unknown (`OldLisp.cs` 104-108); record and pipe data disagreeing gives Unknown (`TrustDrawingReader.cs` 358-363).
   4. Exception: CE's record against the label and against the block is not treated as two answers (FIX FIRST 4).
3. **Same output every run? YES within one build, with one soft spot.**
   1. Objects are sorted by handle before reading (`ReadContext`, 670-673), rows by kind then handle (121-126), values in a fixed order with extra stored values sorted (593), the unrecognised list is a sorted dictionary, notes come in a fixed order.
   2. Every number is written with the invariant culture (`Number`, every `Count.ToString`), every comparison is ordinal or invariant, every pattern is culture-invariant. I found no culture-dependent call.
   3. Soft spot: LPD rows are named by their place in the stored list ("LPD-1", "LPD-2", 553-557), so their names depend on the order the filler hands them over. See Worth knowing 1.
4. **Reaches converted for drawing units? YES for every reach; NO for pit size.** Label, pipe-text, invert-text and DP-label reaches all go through `DrawingAreaUnits.MillimetresToDrawingUnits`; the drawn width goes back through `DrawingUnitsToMillimetres`. The label reach has no pit-width part at all (centre to centre, 5000 mm), so no unit-blind pit width enters a reach. The pit's own size does not convert: FIX FIRST 3.
5. **Does "Sure" rest only on CE's identity? NO.** Pits, pit labels and other CE symbols are Sure by block name alone (the design allows "Sure what it is" by name); tagged sources are Sure by tag even when two blocks carry the same tag. FIX FIRST 5 and 6.
6. **Five marks, and a wrong Proposed value fails the job? YES.** `TrustReadingScorer.ScoreObject`: a differing value on a Proposed row or a proposed value is Proposed wrong, and the pass rules fail on any Wrong, Proposed wrong or Invented (112-117). But the "no Unknown on CE objects" rule is fooled: FIX FIRST 1.
7. **Could the deliberately faulty readers be caught for the wrong reason? YES, one of the three.**
   1. Fills 100: caught for the right reason by the scorer (Proposed wrong on pipe 1030). The unit check catches it only because the twin states 100 as a fact; a fill offered as a proposal would pass `PlainPipesAreNeverSure` (Worth knowing 6).
   2. Picks the nearer pit: the unit check is right; the scorer catch is not (FIX FIRST 2).
   3. Takes the nearer text: caught by its own check for the right reason; no made-up job puts it through the scorer.
8. **The nine defaults in `trust-reader.md` on Settings or clearly marked? NOT on Settings (by plan, queue item 6); marked in the change log and PR, only partly in the code, and four more defaults are taken but not listed.** FIX FIRST 8.
9. **Only what the card needs? YES.** New files and one change-log entry; `ProjectDataService*` and `CurrentDrawingCheckService` untouched; nothing calls the reader.

## 2. FIX FIRST

1. **The scorer takes "carries CE's identity" from the reading it is marking.**
   1. `TrustReadingScorer.cs` 136: `bool ce = row?.HasCeIdentity ?? false;`. A sheet object the reader did not read at all, or read without claiming identity, scores Unknown with "not a CE object", which is allowed (118-120).
   2. So a reader that hands back an empty reading passes every made-up job: all objects Unknown, nothing Invented, two identical readings. MADEUP_CURRENT would print "pits 0 of 2 Right, 2 Unknown ... PASS". The test set's rule ("no Unknown on anything that carries CE's own identity") is about what the object carries in the drawing, not what the reader says.
   3. Fix: take identity from the truth (a flag on the answer sheet, or from the copy: in CE's record, a CE pipe object, CE pipe data, a CE tag), and add a broken twin that reads nothing, or says Unknown everywhere, which must FAIL MADEUP_CURRENT.
2. **The nearer-pit twin fails the made-up job only because the test edits a second pit by hand.**
   1. `TrustReadingScorerTests.cs` 72-75 writes P4 onto both 4001 (the nearer pit) and 4002 (the farther pit); the assertion (78) is on 4002. A real nearer-picking reader numbers only 4001, and MADEUP_TWOPITS's sheet says 4001 is P4, so it scores Right and the job PASSES.
   2. The sheet also gives 4002 the number P5, which appears nowhere in the made-up drawing (sheets come from the labels on the plan).
   3. Fix: make the made-up truth the case the rule protects against (the shared label belongs to the farther pit), drop the hand edit of 4002, and show the scorer fails the twin on its own.
3. **Pit sizes in a metre drawing (the pit width part).**
   1. In a metre drawing CE's pit block sits at scale 0.001, and AutoCAD reports its width at drawn size (0.6 for a 600 pit; `Rules\PitBlockScale.cs` 7-20, BUG-308). The reader refuses any scale other than 1 (`TrustDrawingReader.cs` 283-284), so every pit in a metre copy reads "size Unknown" while the millimetre copy reads 600 x 600. Design 5.4 and test set 6.4 require the two copies to read the same.
   2. MADEUP_METRES hides this: its pits are at scale 1 and carry no size at all, so both copies say "carries no size".
   3. Fix: use the existing units-change rule (`PitBlockScale.IsUnitsChangeScale` and `ToBlockUnits`) so a 0.001 pit in metres reads its real size, keep Unknown for a pit truly scaled by hand, and give MADEUP_METRES realistic pits (scale 0.001, width 0.6).
4. **Two answers kept as one: CE's record against the label and the block.**
   1. When the record holds a pit number and the label on the plan reads another, the record value is kept as a stored fact and the label only goes in the note (`SetPitNumber`, 504-510). The record's pit size is never compared with the block's own size (`ReadPit`, 253-260).
   2. Design rule 3 says two answers is Unknown, and the pipe rule already does exactly that (358-363). CE knows this case is real: CDINSPECTOR's red row "Plan label reads P10 but the stored ID is P8" (BUG-098). The test set's truth comes from the labels, so on such a job the reader states the stale number as a fact.
   3. No test pins the current behaviour. Fix: number (record against label) and size (record against block) disagreeing give Unknown with both values in the reason, with a test each.
5. **The oldest block names are Sure by name although the design says they are not yet recognised.**
   1. "PIT BLOCK" and "PIT LABEL" (version 1) are Sure (`TrustDrawingReader.cs` 30-42, 248, 174). The plugin ships no master drawing for them, and design section 4 says a version is not "recognised" until it has a written rule, a test-set example and a robot check. None exists yet.
   2. Both names are generic. Another firm's block called "PIT BLOCK" in a hand-drawn job reads Sure, where the test set says a hand-drawn job must claim nothing Sure (item 14).
   3. Fix: version 1 names are Proposed, reason "oldest CE name, not yet confirmed from old jobs", until section 4 is met.
6. **A copied CE downpipe reads as two Sure downpipes with the same tag.**
   1. COPY carries the source tag, so two blocks can both carry DP1. Both read Sure with CE's identity (`ReadTaggedSource`, 292-309). The reader already treats an object listed twice in the record as Unknown, but not a tag used twice.
   2. The plan's "cases every card must answer", item 2, names copied objects carrying CE's identity.
   3. Fix: a tag on more than one block gives both rows Proposed or Unknown with the reason "tag DP1 is on two blocks", with a test.
7. **The person's own Settings change the reading.**
   1. `TrustReaderSettings.FromUserSettings` (76-103) takes the label reach, the size list, the downpipe words and the layer renames from the user's own settings file. Design rule 1: "No settings of the person opening the drawing may change what a thing is. Reaches come from the office setup." The doorway's own test shows a 1500 mm personal reach changing which pit a label gets (`TrustDrawingReaderTests.cs` 343-357).
   2. The comment at 97-98 and the test message at 352 say a drawing "reads the same on a PC with or without the rename". It does not: lines on the replacement layer are pipes only on the PC that has the rename.
   3. Fix: feed the reader from the office setup (TRUST-03, PR 2043) or from fixed built-in values until that exists; correct the comment and the message. This also decides queue item 6: the nine defaults go into the office setup, not a personal Settings row.
8. **Defaults: four taken but not listed, and the code marks only some.**
   1. Not listed anywhere as DRAFT: (a) a plain line on a pipe layer is offered as a possible pipe (design decision 1, OPEN); (b) a drawn width is used as a size at all (design decision 2, OPEN; only the 0.5 mm tolerance is listed); (c) a drawing with no units is read as millimetres, so every reach becomes 1000 times longer if it was really drawn in metres (`AddDrawingNotes`, 134-138, says so in the reading only); (d) the record wins over the label (item 4, if kept).
   2. In the code: the DP-label reach is a fixed constant outside the settings object (`TrustDrawingReader.cs` 76), so it cannot move to Settings without a code change; the width tolerance says "DRAFT default 0.5" without "Tim to confirm"; the scorer's three defaults (object Right only when every value is Right, Unknown counts Right where the drawing shows nothing, numbers compare as numbers) carry no DRAFT mark in `TrustReadingScorer.cs`.
   3. Fix: list (a) to (d) as "DRAFT default, Tim to confirm" in the change log, the PR and `trust-reader.md`; move the DP reach into `TrustReaderSettings`; mark the scorer defaults in its code.

## 3. For the controller (plan and lane records, not code)

1. **Queue item 6 and FIX FIRST 7 meet.** "Move the nine defaults to Settings" should read "into the office setup" (TRUST-03), or the reader breaks its own rule 1 the day it is wired.
2. **The answer-sheet template needs two notes** before any real sheet is written: which end of a pipe is "start" (the reader uses the polyline's drawing order, invisible to a drafter reading the plan), and how an LPD is named on the sheet (Worth knowing 1).

## 4. Worth knowing (not blocking)

1. **LPD names follow the stored order.** If the filler reads the older record and the newer set in another order, LPD-1 and LPD-2 swap and the sheet no longer matches. Matching LPDs by their pit and pipe would be steadier.
2. **`NotDrainage` on the answer sheet is never read** (`TrustReadingScorer.cs` 41). Anything not on the sheet is Invented anyway, so it has no effect; remove it or use it.
3. **Downpipe words match anywhere in a block name, on any layer.** "STANDPIPE" and "ROADPLAN" contain "DP" and would be Proposed downpipes. Same as CE's existing background detection (`XrefDownpipeDetectionService.cs` 80-92); on a real job the scorer would show them as Invented.
4. **A pipe text in non-Western digits** matches the pattern (`\d`) but `int.Parse` would then throw (`OldLispTextRules.cs` 68). Very unlikely in a drawing.
5. **2024 against 2027 output not compared.** Readings are identical within one build; the "0.###" number format at a half-way value may differ between the two .NET versions. Low risk; real sizes are whole numbers.
6. **The fill-100 unit check misses a fill offered as a proposal.** `PlainPipesAreNeverSure` only flags values stated as fact; the scorer still catches it on a made-up job. A check that a plain line with no width and no text has no size would close it.

## 5. Not checked

1. Did not build or run any test; 82 of 82 is the lane's count. The full suite was not run by the lane either.
2. The part that fills the copy from a real drawing does not exist, so nothing here was read from a DWG.
3. No real old LISP drawing, old block library or tool palette was opened; the LISP patterns rest on one reader's pass over the LISP source (design 2b).
4. Raingardens, Structural blocks and paper-space schedules are outside the reader today.
