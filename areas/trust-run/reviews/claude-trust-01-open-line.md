# Review: draft PR 2041, `claude/trust-01-open-line` (step 1, the opening line, card UX-OPEN-01)

**Reviewer:** lane trust-review (second run), 12 Nov 2026, about 23:45 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff cf059dcf...origin/claude/trust-01-open-line` at head `00c3baf5` (13 files), PR 2041's description, card `04_REFERENCE\ux-plan\cards\UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md`, and the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf).

---

# FOR TIM

1. **The opening line is built carefully: it only reads, and a test proves no path from it can write to the drawing.**
2. **Two things could make it wrong on real jobs:** the drawing that starts AutoCAD (double-clicked from Explorer) may never get a line, and good jobs may say "needs checking" if outlet or downpipe pipe ends count as "not linked".
3. **Both need a robot case on copies before your trial,** plus a few small fixes to the wording and the list of defaults.

**Verdict: FIX FIRST** (five items). Built yes, Tested unit only (both by its lane: Release run 22,199 passed, 1 unrelated failure; 31 new cases pass). Installed no. Accepted no.

---

## 1. Checked and sound

1. **Writes nothing, by code.** The open-time read uses open-close reads only, no lock, no normal transaction (`CurrentDrawingCheckService.ReadForOpenLine`, `ReadObservation` with `networkOnly`). The changed-drawing counter is read before and after (`DrawingStateLineRule.Run`); if it moves, the line says "could not check" and shows no count.
2. **The proof is strong.** `DrawingStateLineOpenTests` follows the compiled plugin from the three AutoCAD hooks and `PitSymbolsWereUpdated`, asserts the reading path was really walked, and catches four deliberately broken copies (a layer write in three places, a normal transaction). This is the right shape of test.
3. **The Redo inventory entry is the intended process, not a weakening.** `RedoWindowGuardTests` makes every new Idle hook be classified; the entry points at the new call-graph test.
4. **One walk for the line and CDCHECKCURRENT** (design rule 1): with the switch on, CDCHECKCURRENT lists the same "not in the CE record" items. Switch off returns CDCHECKCURRENT to exactly before.
5. **Card wording followed:** "all linked", never "Up to date"; quiet on non-Civil drawings; the pit symbol line (decision 3); the large-drawing line; "could not check".
6. **The edit to the pit symbol update** (`PitBlockMigrationService.cs`) only adds bookkeeping and one message call inside its existing lock, wrapped in try/catch. The update itself is unchanged.

## 2. FIX FIRST

1. **The drawing that is already open when CE loads.**
   1. The line only listens for drawings created after CE starts (`DrawingStateLineOnOpenService.Initialize` hooks `DocumentCreated`). A drawing that AutoCAD opened before CE finished loading (AutoCAD started by double-clicking a DWG, or the start-up drawing) is never added to the waiting list, so it gets no line.
   2. The pipe conversion on opening uses the same pattern (`PipeObjectUpgradeOnOpenService.cs:33`), so it may be fine in practice, but nothing proves it.
   3. Fix: add the drawings already open at start-up to the waiting list, or prove with a robot case (start AutoCAD by opening a test copy) that it is not needed.
2. **"Pipes not linked" may fire on every good job.**
   1. The count reuses the existing open-end rule: an end with no From/To name and no recorded junction is "not linked" (`CurrentDrawingCheckService.cs:384-395`, cf059dcf).
   2. CDLPD writes "LPD" into a blank pipe end (`LpdCommand.cs` 210-229, per the tool-note reader), which helps the outlet pipe. Whether a pipe that starts at a downpipe, a source or a connection point has a name there is not shown. Card "not known" item 4 says these must not count.
   3. Fix: unit cases with an outlet pipe ending at the LPD, a pipe starting at a downpipe and one at a connection point, all counted as linked; and the robot case O1 on a current job before any trial.
3. **List the silent large drawing as a default.** A drawing above the size limit with no CE record says nothing (`DrawingStateLineRule.Compose`, the TooLarge branch). That is a choice (an old large LISP job gets silence) and is missing from the defaults list (a) to (h).
4. **One word for one thing.** The no-record line says "pit blocks" and the needs-checking line says "pit symbols" for the same objects. Pick one before Codex's look.
5. **The case file and this build disagree in three places** (see `reviews\cases-UX-OPEN-01.md`): an unreadable record says "needs checking. The CE record ... could not be read" here but "could not check this drawing" in case O18; scripts are not skipped here (only accoreconsole) but case O20 expects silence; the look brief bans the word "record" that the card's own approved line uses. The controller should settle each, and the losing side changes, before the robot runs.

## 3. Worth knowing (not blocking)

1. **Default ON, as the card says.** A merge therefore turns it on for everyone and adds up to 26 more items per kind to CDCHECKCURRENT's list. Correct per the card; say it in the release note.
2. **Only polylines count as pipe lines** (`entity is Polyline`). A plain LINE on a pipe layer is not counted. The card says polylines.
3. **Only CE's three pit block names count** (`BlockService.cs:349`: PIT BLOCK, PIT BLOCK 2, PIT BLOCK 3). An old job drawn with office blocks of other names gets silence. That is the reader's job later.
4. **A no-record drawing with pipe-layer lines and no pit blocks gets silence.** Reasonable (a consultant drawing could use a similar layer), but worth one line in the defaults.
5. **Scripts in full AutoCAD get the line.** The card says batch work is skipped; only accoreconsole is. If scripted opens were skipped, the robot could not test the line through a script either; the controller should decide.
6. **The symbols line can appear later, mid-work,** when the pit symbol update was held back by a U. Listed as default (d). Fine.
7. **The pit symbol update never forgets a closed drawing** (keyed by memory address, existing behaviour); the builder found and reported it. Not changed here.

## 4. Not checked

1. Did not build or run tests; the counts above are the lane's.
2. Did not open any drawing; timing, the moment the line appears, the "save changes?" question and Redo are unproven, as the lane says.
3. The stacked branch `claude/trust-05-sync-visible` (step 5, on top of this one) is not reviewed here.
4. net48 (2022 to 2024): compiles per the lane; not run.
