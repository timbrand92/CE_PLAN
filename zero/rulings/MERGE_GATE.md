# Current rulings: The merge gate (how a fix reaches the main line, root causes, rounds, design pages, merged against proven)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (this page holds D-308 to D-372 on its subject). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

(Added subject, 20 Nov 2026: the gate a fix goes through to reach the main line did not fit one named page. HOW_WE_WORK keeps the obstacle course as the gate every TOOL passes (D-216) and the four facts built, tested, installed, accepted.)

**Every ruling on this page except D-308 and D-329 is the planning chat's or the control room's call, Tim's to overturn.** None has been confirmed by Tim in words.

## What is decided now

### The gate (D-346, given after he asked "whats our plan to resolve this quickly and efficiently?")

1. **Findings are grouped by root cause** and fixed one cause at a time, not one finding at a time (D-346 item 1; the planning chat's call, Tim's to overturn).
2. **For each cause the failing tests are written first;** that list is the definition of done (D-346 item 2; planning chat's call).
3. **Order:** unsafe edits, wrong figures, rulings not built, then the missing AutoCAD commands (D-346 item 3; planning chat's call).
4. **A fix merges when** its list is green with the whole suite, one independent check confirms the list is honest, and one adversarial pass finds no blocker (D-346 item 4; planning chat's call).
5. **A blocker is only:** a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way; anything less goes on a follow-up list and does not bounce the work (D-346 item 4; planning chat's call).
6. **At most two fix rounds,** then held with a one-page open list (D-346 item 4; planning chat's call).
7. **Merged and proven are two separate facts (D-346 added to, 20 Nov, about 4:35 am; planning chat's call):** on the first overnight pass all 24 checks said HOLD, most because "live proof owed in AutoCAD" was listed as a blocker while AutoCAD testing was stopped. A proof owed in AutoCAD is not a blocker for the main line. A fix merges on its bench tests and one honest check; what must still be shown in AutoCAD is kept as an owed list for that cause. A cause is counted "merged" then, and "proven" only when its owed list has passed in AutoCAD.

### After two rounds: a design page first

8. **No third patch rounds (D-347; method given with "stage it", planning chat's call):** a cause that has failed two rounds gets a design page first, as copy identity did. The night's result that led to it: 1 of 25 root causes merged from 359 Codex jobs; 11 held after two rounds.
9. **Pipe size, the first named case (D-372 item 4; control room's call):** because the size fault survived two fix rounds (the check room, 20 Nov), no third patch: one short design page on what size a pipe holds and where it is kept, joined to the one-reader design of D-349, then one build.
10. **Design pages checked by the planning chat, Tim's calls taken, then "the one rebuild may start":** copy identity (D-340, `design\COPY_IDENTITY.md`; its first test, what AutoCAD really does to a pointer on each copy route, comes first); detention chain (D-343, `design\DETENTION_CHAIN.md`); edit doorway (D-348, `design\EDIT_DOORWAY.md`, which delivers the copy rule of D-340 with it); sums, pipe and print (D-349, D-350, causes C9 and C11).

### Checks on Codex work (Tim's words)

11. **"make sure codex abides by our rules and decisions" (D-308):** every Codex job carries `CODEX_STANDING_BRIEF.md` at the top, names the rulings it touches, is reviewed against them, and is checked by the build chat before merging; a run that breaks a line is thrown away.
12. **"i wouldnt mind something checking what codex is doing and it can also do work of its own" (D-329):** one Team checker (Opus) reads every Codex result against the rulings, separate from Codex's own review.
13. **Every bar stands when Codex runs flat out (D-342):** standing brief, failing test first, its own review and the Team check before the main line.

## Changed along the way

1. **"Both reviews must pass with nothing found" was replaced by D-346 (19 Nov; planning chat's call),** because it let nothing merge on the night of 19 Nov.
2. **"Live proof owed in AutoCAD" as a blocker was dropped by the addition to D-346 (20 Nov, about 4:35 am; planning chat's call):** merged and proven are two facts.
3. **Third patch rounds were stopped by D-347 (20 Nov; planning chat's call):** design page first.

## Still open on this subject

1. **Tim has not confirmed D-346 or D-347's method in words;** both are the planning chat's calls. Waits on: Tim (to overturn only).
2. **The design page on what size a pipe holds** (D-372 item 4). Waits on: the build room.
3. **Owed AutoCAD proofs for each merged cause** (D-346 addition), including the copy identity first test (D-340). Waits on: the AutoCAD test room.

## Where the detail lives

1. `DECISIONS.md` D-308, D-329, D-340, D-342, D-343, D-346 (and its addition of 20 Nov), D-347 to D-350, D-372.
2. `CODEX_STANDING_BRIEF.md`; `stage6\ONE_JOB_RELEASE.md`; design pages in `C:\CE_CIVIL` branches design/copy-identity, design/detention-chain, design/edit-doorway, design/sums-pipe-and-print.
