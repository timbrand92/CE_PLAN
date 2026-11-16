# CE plugin, plan from zero: start here

**Started:** Mon 16 Nov 2026. **Scope now (R-66, R-67):** AutoCAD 2027 only; civil, the CE tools (everyday drafting helpers) and the Manager. Structural joins only when those work.
**This folder is the one place for the new plan.** The old plan elsewhere in `C:\CE_PLAN` is a parts bin, not authority, until Tim has been offered each piece back as keep / change / drop (Stage 3).

## How this folder is organised (R-65: built to be added to)

Every kind of knowledge has ONE home, and every item in it has a number that is never reused. To add something, add an item to the right register; do not start a new document.

1. **`RULES.md`**: Tim's rules, R-numbers, his words. The only rulebook for this plan (with `C:\TimOS\RULES.md`).
2. **`DECISIONS.md`**: every decision Tim has made for this plan, D-numbers, his words, dated; superseded ones kept and marked.
3. **`PARKING_LOT.md`**: things raised and set aside, P-numbers.
4. **`OPEN_QUESTIONS.md`**: what is still not known, Q-numbers, each saying who can answer it (Tim, a file not yet read, research, a test).
5. **`reference\`**: what is TRUE about the office today, organised by topic, written to be looked up, each fact pointing to its evidence. This is the working library for every future task.
   1. `reference\README.md`: the index and the rules for adding to it.
   2. `reference\process\`: how a job runs.
   3. `reference\design\`: job kinds (K-), sums (S-), rules and limits (L-), inputs and outputs.
   4. `reference\drafting\`: the element catalogue (E-), sheet set-up, tables and boxes, title block.
   5. `reference\standards\`: layers, text sizes, colours and pens, linetypes, offsets, wording patterns, kept as plain data files so they can become the plugin's standards file.
   6. `reference\councils\`: one file per council.
   7. `reference\today\`: what is installed and used today, and how it reaches a PC.
6. **`evidence\`**: the dated study notes exactly as written (interview record, studies A to D, digests). Never edited after the day they were made, except the interview record, which only grows. The reference library cites these.
7. **`design\`**: the new plugin. The concept first, then one design record per tool (R-15) as each is approved.
8. **`pictures\`**: pages made for Tim (HTML, opened in a browser).

## The numbers

1. **R-** rules. **D-** decisions. **P-** parked items. **Q-** open questions.
2. **K-** job kinds. **S-** sums. **L-** rules and limits. **E-** drawing elements. **C-** councils. **T-** tools of today.
3. Later, when building starts (R-31): **B-** bugs, **I-** ideas, **TS-** tests.
4. A number is never reused. A changed item keeps its number; the old words stay, marked superseded with the date.

## The stages (from Tim's prompt of 16 Nov 2026) and where each stands

1. **Stage 1, how we design and draw:** civil studied in depth (13 jobs, 3 drawings taken apart, workbooks, guidebook, templates); explained to Tim in `pictures\how_we_design_and_draw_civil.html`. Tim has not yet said "approved". Structural: two sets read, then parked (P-05).
2. **Stage 2, what the plugin should do:** started on Tim's word of 16 Nov ("i want to see what your interpretation of the new plugin would be like"): see `design\CONCEPT.md`. Not approved.
3. **Stage 3, parts bin:** not started. One early look at what is installed and at the old evidence notes, on Tim's word.
4. **Stage 4, research:** not started.
5. **Stage 5, how we work:** not started.
6. **Stage 6, the plan:** not started.

## Rules for anyone working here

1. Read `RULES.md`, `DECISIONS.md` and this file first. Say which stage and item you are on.
2. Record Tim's decisions the moment he makes them, in his words, in `DECISIONS.md`, and his full words in `evidence\STAGE1_INTERVIEW.md`.
3. No client names, addresses, job numbers, staff names or secrets in any file here. Jobs are coded (JOB_A, CIV-01). Keys to the codes stay on Tim's PC only.
4. Unknown stays unknown: put it in `OPEN_QUESTIONS.md`, never fill it in.
5. Commit by file name and push after each sitting.
