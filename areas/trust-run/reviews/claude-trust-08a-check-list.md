# Review: draft PR 2051, `claude/trust-08a-check-list` (trust plan step 8 slice A, card TRUST-08: the read-only Check this drawing list)

**Reviewer:** lane trust-review (seventh run), Fri 13 Nov 2026, 02:12 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO would be evidence for testing on copies, never acceptance.
**What was read:** PR 2051's description; the step's own two commits `e20017f6` and `29847f4d` (diff `9534fb91..29847f4d`, 8 files); the merge `9534fb91` that brings the reader (PR 2040, head `222a303e`) under it; the reader and its copy-filler as they stand on this branch; step 1's `CurrentDrawingCheckService` and `DrawingStateLineRule`; CE's existing zoom service. Checked against card `TRUST-08_CHECK_THIS_DRAWING_CARD_DRAFT_2026-11-12.md`, my card review `reviews\card-TRUST-08.md`, the window contract `CONTRACT_TRUST-08A_LIST_WINDOW.md`, the plan's nine real-job cases and `TRUST_PROBES_13NOV.md`.

---

# FOR TIM

1. **The new typed list (CDCHECKDRAWING, switched off) really only reads:** nothing in it can change the drawing, CE's record, the links or the Undo list, and no row can arrive ticked because there are no ticks yet.
2. **But it can show a guess as a fact and it can say "all clear" wrongly:** a pit number guessed from the nearest label is printed as if found, two pits with the same number both count as Sure, internal object codes appear in the rows, and a drawing whose drainage is inside an Xref gets "CE: all linked. Nothing to check."
3. **The window contract is nearly complete but points the window at CE's old zoom, which changes the selection and uses the kind of drawing access this step bans,** and it asks the window to light up links the list does not supply.

**Verdict: FIX FIRST** (five items in section 2, three for the contract in section 3). Built yes (by its lane, net48 and net10, 0 errors). Tested: unit tests only, by its lane (22,479 ran, 22,446 passed, 32 skipped, 1 failed, the command count, fixed in `29847f4d`, 27 of 27 re-run; not re-run here). Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Writes nothing (drawing, CE's record, links, Undo steps, the changed counter): YES by reading.** The command skips CE's start-of-command steps (`Commands\CheckThisDrawingCommand.cs` 29-36: only `TryGetContext`, which reads the open document, `CeCommandBase.cs` 19-24). The copy is filled in one open-close transaction, every object opened for read (`Services\TrustReaderFill\TrustSnapshotFiller.cs` 51-73); the record is read as raw text (91-99); step 1's check is read the same way (`CurrentDrawingCheckService.cs` 510-531, reviewed in step 1). No lock, no record update, no save, no Apply. The compiled command is followed call by call and a copy with a drawing write planted in it is caught (`CheckThisDrawingListTests.cs` 299-330). The switch is read before anything else (test 264-272).
2. **When a row is used to zoom:** slice A has no zoom and no window, so nothing to check in code; see the contract, section 3.
3. **No row arrives ticked: YES.** `CheckListRow` has no tick or selected field at all (`Rules\CheckThisDrawingListRule.cs` 10-31).
4. **Copied pits that carry CE's identity shown as Sure without a uniqueness check: NOT MET** (section 2, item 3).
5. **A wrong Proposed value presented as fact: NOT MET** (section 2, item 2).
6. **Read-only drawing:** works; it takes no lock and writes nothing. Slice A has no Apply, so nothing more is needed yet.
7. **Paper space:** it reads model space whatever tab is in front (`TrustSnapshotFiller.cs` 54); layouts are not read and the list does not say so. A Pit Schedule placed on a layout (plan case 5) is not mentioned.
8. **A drawing that is not Civil:** prints "CE: all linked. Nothing to check." (section 2, item 4).
9. **Drainage inside an Xref:** not read and not mentioned; can print the same all-clear (section 2, item 4).
10. **Units not set:** says "Note: the drawing has no units set, so distances are read as millimetres." (reader `TrustDrawingReader.cs` 147-148), except when the all-clear line replaces everything. A drawing really drawn in metres mostly falls to Unknown (pit blocks at 0.001 scale are not read; one label with several pits in a 2 km reach is never matched): the safe direction. A proposal's distance is then quoted in the wrong unit ("label is 2 mm from pit").
11. **Totals against the opening line and CDCHECKCURRENT (one walk, design rule 1): NOT MET** (section 2, item 5).
12. **Plain words:** mostly plain; the exceptions are in section 2 items 1 and 6.
13. **Lower steps:** the reader merge is clean (both sides compared through the merge: byte for byte, only `REGRESSION_LOG.md` conflicted). But step 6 (PR 2049) moved to `e7b9ccdc` at 01:49, after this branch was cut from `68032c9b`, so this branch does not carry step 6's review fixes. Re-stack before the robot runs it.

## 2. FIX FIRST

1. **Internal object codes are shown to the drafter.**
   1. The reader's own words carry them, and the list passes them through unchanged: a label matched to a pit gives `Proposed: pit 2A4F` (the value is the pit's code, `TrustDrawingReader.cs` 571, worded by `CheckThisDrawingListRule.cs` 156); reasons "label is 312 mm from pit 2A4F, the only pit in reach" (570), "2 pits within 2000 mm (2A4F, 2B10)" (550-553), "two labels are stored for this pit (...)" (527), "same identity twice: tag DP1 is on 2 blocks (...)" (372-373); the note "CE's record lists object 2A4F more than once" (161); and LPD rows list the stored pit, pipe and label codes (643-645).
   2. The PR's test that "no line shows an object's internal name" (`CheckThisDrawingListTests.cs` 128-140) runs on a hand-made reading with none of these. The PR's own through-the-reader test (222-236) builds exactly the label case and would print "Proposed: pit A1", but checks only counts.
   3. Fix: word these in the list rule (the pit by its number, or "the pit 1.1 m away"); run the no-code check over readings made by the real reader on every made-up drawing.
2. **A proposed value is printed as a found fact.**
   1. Each row starts with "what CE found", and that includes the pit number whatever its source (`CheckThisDrawingListRule.cs` 143-148). A number taken from the only label in reach is a proposal (`TrustDrawingReader.cs` 572, 593), yet prints as found.
   2. Unknown beats Proposed, and an Unknown row lists only the unknown values (128-140), so every proposal on that object disappears. On an old job with no record almost every pit has no levels, so it lands in Unknown as "Pit: P3, PIT BLOCK 3 (version 3, current). Cover level Unknown, Invert level Unknown (...)": the guessed P3 reads as fact and its reason is gone.
   3. Fix: "what CE found" carries only values read or stored; an Unknown row also lists its proposals with their reasons ("number proposed P3: the only label in reach, 1.1 m away").
3. **Sure without a uniqueness or plan check (card review finding 1, not done).**
   1. The reader's only identity checks are a handle listed twice in CE's record and a source tag on two blocks (`TrustDrawingReader.cs` 797-798, 815-819). A copy always gets a new handle, so the first can never catch a copy. There is no check for two pits holding the same number (the number is what pipes are tied to), nor for two objects carrying the same CE identity key, which is what the repo's own `Rules\CloneOriginRule.cs` says a paste from another job leaves. Two record pits both numbered P3 with all values filled both count as Sure.
   2. A pit number held only in CE's record, with no label on the plan showing it, is taken as fact (`ReadPit`, 266-305; `SetPitNumber` only runs when a label exists). That is exactly the invented "P8" the probes saw (`TRUST_PROBES_13NOV.md` section 4).
   3. The stand-in number CE stores for an unnumbered pit (its internal code; installed record update, card TRUST-06 review item 2) is read as a real number. Step 6's rule for this, `UnknownNotGuessRule.PitNumberIsUnknown`, is now used by shipped code (Check Current Drawing and the Pit Schedule at `e7b9ccdc`) but not by the reader: two rules for one fact.
   4. Fix: same number (or same identity key) on two objects: neither Sure, with the reason; a record number no label shows: Proposed; a number equal to the pit's own code: Unknown, through the one rule.
4. **A false all-clear.** `NothingToCheck` is true whenever there are no rows and step 1's line is quiet (`CheckThisDrawingListRule.cs` 56-58), and step 1's line is quiet for a drawing with no CE record and no CE pit blocks (`DrawingStateLineRule.cs` 49-55). So "CE: all linked. Nothing to check." is printed for a drawing that is not Civil, for one whose drainage is all inside an Xref (the filler reads the host's model space only; step 1's check runs with no Xref review, `CurrentDrawingCheckService.cs` 527-529), for drainage on layers renamed in Settings (the reader uses fixed names, item 5), and for drainage in paper space or inside other blocks. The drawing-wide notes ("no CE record", "no units set") are dropped in that case (`ToLines` 235-239). Fix: "CE found no pits or pipes in this drawing's model space", one line when the drawing has Xrefs ("drainage inside attached drawings is not checked"), and keep the notes.
5. **Two walks, two rules, one printout (design rule 1).** The groups come from the reader's walk; the state line printed under them comes from CDCHECKCURRENT's walk (`Services\CheckThisDrawingService.cs` 25-29). They count "lines on a pipe layer" differently: the reader uses fixed layer names, including EX DRAIN HATCH (`TrustReaderSettings.cs` 68-72), the check uses the layer names after any Settings rename (`LayerService.cs` 45-55, 378-380); the reader takes LINE objects, the check polylines only (`CurrentDrawingCheckService.cs` 576-586); the check skips polylines that belong to another pipe, the reader does not. So one output can say "1 line on a pipe layer not in the CE record" with no row for it, or list a proposed pipe the state line does not count. Fix: derive the state line from the same reading, or one shared rule for "pit block" and "line on a pipe layer", and a test that both counts agree on every made-up drawing.

## 3. The window contract (`CONTRACT_TRUST-08A_LIST_WINDOW.md`)

**Complete enough to build from, apart from these three. It does keep engineering out of the window:** grouping, wording and the Sure rule all stay in the list (contract 1.4, 2.2), and the open questions go to Tim (section 6).

1. **FIX FIRST: the zoom it points to is not safe.** Contract 4.2 says zoom "the way CE's existing Show does where that has been measured safe". CE's existing Show (`CeZoomHighlightService.ZoomAndHighlight`) sets AutoCAD's selection (`SetImpliedSelection`, line 119), which wakes CE's selection observer and the Civil Properties palette (`CivilSelectionObserver.cs` 159, 218), and zooms inside a normal transaction (`DrawingService.ZoomToEntityWithPadding`, `StartTransaction`): the kind of call this step's own write guard rejects. Nothing has measured it. The contract should say: read with an open-close transaction, change only the view, highlight without touching the selection, and prove Undo, Redo, the record and the changed flags on a copy (probe P2) before the window uses it.
2. **FIX FIRST: "light up what it is linked to" needs data the list does not give.** Each row holds one object code. To light up links the window would have to work them out itself, which is engineering in the window and against contract 1.1 ("never calls anything else of CE's"). Either the list supplies each row's linked objects, or link lighting leaves slice A.
3. **FIX FIRST: missing cases.** A row on a layer that is turned off or frozen (zooms to nothing; card review finding 7: say so, never change the layer); a layout tab in front (zooming to a model space object means switching to Model, which changes a drawing setting: say "switch to Model to see it" instead); LPD rows carry a made-up code "LPD-1", not an object; counts in the state line with no rows behind them (pits with no object). And the contract's 3.1 and 1.4 contradict each other while the list's words still hold codes (item 2.1): the window may not re-word, yet must not show codes. The fix belongs in the list.

## 4. Before the robot runs it

1. **AutoCAD's "changed" value (DBMOD) is a set of flags, not a counter.** Once a drawing has unsaved changes, the "objects changed" flag is already set, so a write during the read leaves it unchanged and the list still says "Nothing has been changed" (`CheckThisDrawingService.cs` 21, 33; `CurrentDrawingCheckService.cs` 849-860, which also returns 0 when it cannot read). The write guard in the tests is the real proof; the robot cases must start from a freshly opened drawing and compare CE's record, or count AutoCAD's object-changed events during the read. AutoCAD's documentation also lists a "view changed" flag, so a zoom from the window may move this value: measure it.
2. **Re-stack on step 6's new head `e7b9ccdc`** (section 1 item 13).

## 5. Worth knowing (not blocking)

1. **Plain words:** every list on a drawing with a record prints "Note: CE record format 2..." (reader 158); an Unknown label row can read "attribute PIT_LABEL is blank or missing" (687-688); an LPD row ends "(card TRUST-07)" (640); the state line inside the list says "Type CDCHECKCURRENT to see them", pointing to another command.
2. **Sure is "matches CE's record", not "right".** Values the old hidden update invented (100 UPVC, Class A lid, GRATED PIT) are counted Sure once the rest of the object is filled; a pipe's record size is compared with data on the line but not with its drawn width or its plan label. Card TRUST-06 says a written "100" cannot be told from a real one; the list's Sure words should not promise more than "agrees with CE's record".
3. **Record items with no drawn object** appear only in the state line count; there is no row to look at.
4. **No client name, job number, street or suburb** in the diff, tests or change log.

## 6. Not checked

1. Did not build or run tests; counts are the lane's.
2. Nothing run in AutoCAD: no list on any drawing, no timing, no row count on a real revision.
3. Whether CE's global command watchers (help, telemetry) do anything when CDCHECKDRAWING runs; by name they only log, and CDCHECKCURRENT, which has the same start, was seen to change nothing (`TRUST_PROBES_13NOV.md` section 3).
4. The reader's own rules beyond what the list relies on (reviewed twice under PR 2040).
5. AutoCAD 2022 to 2024 (net48 compiles by the lane's word).
