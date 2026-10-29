# Guidebook build list (kept by Claude; Tim does not need to read this)

**Updated 29 Oct 2026.** One line per slice. Tim approves cards, not slices. A slice moves down this list only when the one above it has passed Codex in real AutoCAD on copies (RULES 4.5, item 7). Nothing installs without Tim's "AutoCAD is closed, deploy". Status words: Waiting / Building / Built / Codex-checked / Installed. Never a percentage.

## Approved cards (build in this order)

1. **GB-01 slice 1, falls.** BUILT and unit-tested only (25 new tests pass; net10 and net48 build 0 errors); draft PR #1841 on `claude/gb01-slice1-falls`, 29 Oct. Not Codex-checked, not installed. Known: every saved CDRULES run shows Stale once; a saved old ladder moves to 1 in 100 once at load; the Edit Pipe strip does not know a pipe is a detention pipe (only CDRULES applies the 1 in 200 allowance); two IL-shape tests fail and were not compared with the base; Settings window rows for the three new values do not exist yet (Codex window work). Next: finalizer review, then Codex steps in `PENDING_TESTS.md` "GB-01 slice 1". Open: someone names the minimum fall for 450 and larger gravity pipes (blank until then).
2. **GB-01 slice 2, cover table.** Waiting for slice 1.
3. **GB-01 slice 3, minimum pit depth.** Waiting.
4. **GB-01 slice 4, lid class and garages.** Waiting.
5. **GB-01 slice 5, pit-size table to Settings.** Waiting.
6. **GB-02 council data (all items).** Approved 29 Oct. Waiting for GB-01 slice 1 to land (same council profile and Settings files; two writers never touch the same files).
7. **GB-03 calculations (slices: sheet layout, rainfall for new Boyd's jobs, pump, soakage, collate the package).** Approved 29 Oct. Waiting for GB-02.
8. **GB-04 ready to submit (slices: seven every-council checks, Kingston/Monash/Frankston extras, Bayside and the rest, record on the job).** Approved 29 Oct. Waiting for GB-03 (may start the checks that need no splay earlier if builders are free and files do not overlap). Splay method settled 29 Oct (drawn line on a named layer set once in Settings; none drawn = Unknown).

## Cards waiting for Tim's approval (no build until approved)

1. **GB-05 Claude assistant.** Draft; also needs the 22 Oct privacy finding confirmed fixed.

## Planned, not started

1. **GB-06 update the guidebook (stage 4).** After GB-01 to GB-04 pass Codex. Plan: `GB-06_UPDATE_THE_GUIDEBOOK.md`. The book itself is untouched.

## Who keeps this list

From 29 Oct 2026 the desk (the chat that runs builders, trains and Codex hand-offs) keeps this list current: after each builder or Codex report it moves the slice and updates `areas/council-rulebook.md`. The side session that wrote the audit and cards is no longer needed once this is read. Tim never needs to open it.

## Open items that block or shape builds

1. Minimum fall for 450 to 750 gravity pipes (GB-01 slice 1; QUESTIONS_FOR_MONDAY GB-A).
2. Maximum pipe speed and its document (engineers; question 7).
3. Bayside 1 in 20 pump rule source (question 14).
5. Claude provider, model, cost ceiling, who gets it (GB-05; QUESTIONS_FOR_MONDAY GB-D).

## After every build

The builder writes the Codex steps into `C:\CE_PLAN\PENDING_TESTS.md` and updates `areas/council-rulebook.md`. Claude updates this list in the same reply it hears back.
