# Guidebook build list (kept by Claude; Tim does not need to read this)

**Updated 29 Oct 2026.** One line per slice. Tim approves cards, not slices. A slice moves down this list only when the one above it has passed Codex in real AutoCAD on copies (RULES 4.5, item 7). Nothing installs without Tim's "AutoCAD is closed, deploy". Status words: Waiting / Building / Built / Codex-checked / Installed. Never a percentage.

## Approved cards (build in this order)

1. **GB-01 slice 1, falls.** BUILT and unit-tested only (25 new tests pass; net10 and net48 build 0 errors); draft PR #1841 on `claude/gb01-slice1-falls`, 29 Oct. Not Codex-checked, not installed. Known: every saved CDRULES run shows Stale once; a saved old ladder moves to 1 in 100 once at load; the Edit Pipe strip does not know a pipe is a detention pipe (only CDRULES applies the 1 in 200 allowance); two IL-shape tests fail and were not compared with the base; Settings window rows for the three new values do not exist yet (Codex window work). Next: finalizer review, then Codex steps in `PENDING_TESTS.md` "GB-01 slice 1". Open: someone names the minimum fall for 450 and larger gravity pipes (blank until then).
2. **GB-01 slice 2, cover table.** BUILT and unit-tested only (17 new tests; full net10 run 20,821 pass, the same 2 unrelated IL tests fail; net48 0 errors); draft PR 1850 stacked on B-012 (PR 1848), 29 Oct. Not Codex-checked, not installed. Rows CONFIRMED by Tim 29 Oct ("Keep as built"). No surface = single office 300, also by his word (the card's Unknown is not used). Other screens still use the single number until B-022.
3. **GB-01 slice 3, minimum pit depth.** BUILT and unit-tested only (7 new tests; full net10 run 20,827 pass, the same 2 unrelated IL tests fail; net48 0 errors); draft PR 1851 stacked on 1850 on B-012 (1848), 29 Oct. Not Codex-checked, not installed. Open: the pipe wall table ships only UPVC 225 and concrete 375, so other sizes say 'wall Unknown'; the engineers need to supply walls per size.
4. **GB-01 slice 4, lid class and garages.** LID CLASS HALF BUILT and unit-tested only (21 new cases, 131 pit tests pass, net10 and net48 0 errors); draft PR 1843 stacked on 1842, 29 Oct. GARAGES HALF BUILT (Tim said yes 29 Oct): draft PR 1849 stacked on 1843; closed outline on a named Settings layer, none named or drawn = Unknown; R-33. 12 new tests, 3,777 rules tests pass on net10; the drawing read has NOT been run in AutoCAD; net48 build waiting for CE 01's build pause to end.
5. **GB-01 slice 5, pit-size table to Settings.** BUILT and unit-tested only (19 new cases, 4,101 pit tests pass, net10 and net48 0 errors); draft PR 1842 on `claude/gb01-slice5-pit-sizes`, 29 Oct. Not Codex-checked, not installed. Built out of order (it touches no cover code); slices 2 and 3 wait for CE 01's B-012 (cover to pipe outside) and B-022 (cover screens agree).
6. **GB-02 council data (all items).** Approved 29 Oct. Waiting for CE 01's B-017 (BUG-1095, same council-profiles.json and CouncilRuleValues.cs); CE 01 gives the PR number, expected Fri 30 Oct.
7. **GB-03 calculations (slices: sheet layout, rainfall for new Boyd's jobs, pump, soakage, collate the package).** Approved 29 Oct. Waiting for GB-02.
8. **GB-04 ready to submit (slices: seven every-council checks, Kingston/Monash/Frankston extras, Bayside and the rest, record on the job).** Approved 29 Oct. Waiting for GB-03 (may start the checks that need no splay earlier if builders are free and files do not overlap). Splay method settled 29 Oct (drawn line on a named layer set once in Settings; none drawn = Unknown).

## Last in the queue

1. **GB-05 Claude assistant.** Approved 29 Oct (recommended answers). Starts after GB-04 works; slice 1 also needs the 22 Oct privacy finding fixed and Codex-checked.

## Planned, not started

1. **GB-06 update the guidebook (stage 4).** Approved 29 Oct but ON HOLD until Tim supplies the updated council guidebooks; then the desk compares them with the council profiles first (any difference goes to Tim). Also after GB-01 to GB-04 pass Codex. Plan: `GB-06_UPDATE_THE_GUIDEBOOK.md`. The book itself is untouched.

## Who keeps this list

From 29 Oct 2026 the desk (the chat that runs builders, trains and Codex hand-offs) keeps this list current: after each builder or Codex report it moves the slice and updates `areas/council-rulebook.md`. The side session that wrote the audit and cards is no longer needed once this is read. Tim never needs to open it.

## Open items that block or shape builds

1. Minimum fall for 450 to 750 gravity pipes (GB-01 slice 1; QUESTIONS_FOR_MONDAY GB-A).
2. Maximum pipe speed and its document (engineers; question 7).
3. Bayside 1 in 20 pump rule source (question 14).
5. Tim to supply the updated council guidebooks (GB-06 start condition).

## After every build

The builder writes the Codex steps into `C:\CE_PLAN\PENDING_TESTS.md` and updates `areas/council-rulebook.md`. Claude updates this list in the same reply it hears back.
