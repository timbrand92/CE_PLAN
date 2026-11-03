# Open questions for Tim, batch of 15, Mon 2 Nov 2026 (night)

Written by Sonnet (Team) for CE 05, to go to Tim through CE 04. Melbourne time. Read-only job: this file is the only thing changed. Nothing built, nothing tested, no AutoCAD opened, robot not run.

(The job brief named the output file `C:\CE_PLANreas\...`. That path has lost a backslash, so it is saved in `C:\CE_PLAN\areas\` with the name asked for. Move it if you meant somewhere else.)

---

## FOR TIM

1. **15 questions below, each with a recommended default.** Answer "as recommended" to any and it stands. Nothing is decided until you answer (rule 3.4).
2. **The three you asked for are first:** BUG-1092 (a tiny downhill fall), the Design Warnings footer for a red row, and BUG-1273 (pit counts in Edit Pipe).
3. **Already answered, so not asked again:** council numbers (decision 176), the pipe sizer (37), pipe grades (GB-01, approved 29 Oct), the FO label (76), and others. The full list is at the bottom.
4. **Which build is which.** The installed Civil 3.0.89 is commit 61fd6fbc. The two draft fixes behind questions 1 and 2 (PRs #1992 and #1993) are NOT in 3.0.89, NOT in candidate b1 (rel-20261108a, cf059dcf) and NOT in rel-20261110a (d4ce878e), as fetched tonight.
5. **Not proven:** I read the bug list and the decision files only. I did not run anything, did not open AutoCAD and did not re-read the code behind any question.
6. **Verdict:** ready to send to CE 04.

---

## THE QUESTIONS

1. **BUG-1092: should a real downhill fall of under 5 mm be a warning at all?**
   1. Context: a 2 m pipe with a real 4 mm fall (1 in 500) is told "no measurable fall". CE 00 has already ruled the wording only (it will say "Very shallow fall: 4 mm over 2.0 m, 1 in 500"). What is left is your call: should a tiny downhill fall get an amber warning, or no warning?
   2. **Default: yes, keep an amber warning, and show the real figure.** A 1 in 500 drain is far flatter than the 1 in 100 minimum you set on 29 Oct. The 5 mm band stays only to stop survey noise turning a flat pipe into a red "flows uphill". Uphill stays red.

2. **BUG-1092 (Design Warnings window): what should the footer say when a row is a red error?**
   1. Context: the window always ends "Warnings are informational - the pipe has been saved." That is wrong under a red "Pipe flows uphill" row.
   2. **Default:** when any row is red, the footer reads "Red items are errors to fix. The pipe has been saved either way." When every row is amber, the footer stays as it is today. Never blocks (R-27).

3. **BUG-1273: Edit Pipe cascade preview says "5 pits", the finished message says "3 pits". Which wording?**
   1. Context: the preview counts the pit you started from (P3) as well. The finished message counts only pits actually changed, and one pit had no CE record so it was skipped.
   2. **Default: the preview says "4 pipes, 5 pits including the one you picked", and the finished message names any pit it left alone** (for example "1 pit has no CE record, left alone"). The other choice is to make the preview count only changed pits, which needs the preview to know in advance which pits have no record.

4. **BUG-1056: where may CE get the habitable floor level for the 300 mm freeboard check at Frankston?**
   1. Context: CDTWL says "That is enough" with the water 100 mm under a floor because it never looks for a floor level. The 300 mm figure itself is settled by decision 176.
   2. **Default: only a floor level you have typed or recorded on the job.** If none is recorded, CDTWL says "Habitable-floor freeboard not checked: floor level is not recorded". CE never reads a floor level off a spot level or a block it cannot be sure of (Unknown stays Unknown).

5. **BUG-095: Glen Eira detention, 1.80 m3 from CE against 2.58 m3 on the file. Which basis is right?**
   1. Context: Boyd's sheet and the Swinburne profile give different storage for the same lot. Under decision 176 CE asks you when two sources disagree.
   2. **Default: use the figure from the sheet Glen Eira actually accepted. If you cannot say, CE shows the larger storage (2.58) with a note.** A tank that is too big wastes a little money; one that is too small floods a lot. No tolerance is widened.

6. **BUG-1020 and BUG-245: when a pit's recorded floor and the drawn pipes disagree, which depth wins?**
   1. Context: on a long section the pit can be drawn 1.00 m deep while a pipe leaves it lower, so the pit bar ends above that pipe. BUG-245 is the same kind of clash for a pipe from a pit to an open end (drawn order versus levels).
   2. **Default: the lowest level wins.** The pit is drawn down to the lowest of its floor and every connected pipe invert, and CE says so in one line. For the open-end pipe the levels win over the drawn order (water runs downhill). Warn, never block.

7. **BUG-056: at an existing council connection, match pipe inverts or pipe tops (obverts)?**
   1. Context: your own drain joins a council pipe. CDRUNSOLVE needs to know where to anchor the levels. There are four open points: invert or obvert, the drop across the connection, how detention pipes are held, and how the connection is marked.
   2. **Default: match the tops (obverts) and warn, never block**, because a smaller new pipe joining a larger council pipe at the same invert would hang above the flow. If the council's own document for that job says otherwise, the council figure wins (decision 176). This is my recommendation, not something I found written down. The carpark says you were handling it yourself, so correct me if you already settled it.

8. **BUG-641: when a paved area drains to two pits, how is it shared?**
   1. Context: CDCATCHMENT should show which part of the paving drains to each grated pit (your "Yes, show catchment", UX-SURF-03). Nobody has said how the split is made.
   2. **Default: the drafter draws or picks each pit's share; CE suggests the nearest pit as the starting guess and shows the areas** so the drafter can check they add up to the whole.

9. **BUG-1006: what advice should the too-slow and too-fast pipe warnings give?**
   1. Context: the audit found the advice points the wrong way: it says to change the pipe size in the direction that makes the speed worse.
   2. **Default: too slow says "Make the pipe steeper if cover allows, or check the flow figure". Too fast says "Make the pipe flatter, or add a drop at a pit".** Pipe size is not mentioned. It is your engineering wording, so change it freely.

10. **BUG-820: Recover Inverts, one of a pipe's two IL texts was erased. Should CE draw the missing one?**
    1. Context: today it prints a plain line saying nothing was drawn for those pipes and asks you to add the text by hand. The wording is accepted; the behaviour is your call.
    2. **Default: yes, draw the missing end** and count it in the totals line. One U undoes it. The surviving text shows what the drafter wanted at that pipe.

11. **BUG-1252: you move a label by hand, then move its pit. Should the label travel with the pipe end or stay where you put it?**
    1. Context: today CE moves the label with the pipe (the Monday question 19). In the Codex look it moved only half the pit's distance, which matches neither choice, so it needs fixing either way.
    2. **Default: (a) the label travels with its pipe end**, keeping the offset you gave it. A label left behind ends up floating away from its pipe. If you choose this, the test card is corrected to match.

12. **BUG-1091: what minimum grade for gravity pipes 450 and larger?**
    1. Context: on 29 Oct you approved a separate figure for 450 and bigger. The guidebook gives none, so the Settings row is blank and CE shows "no minimum fall set for this size". The Settings page currently holds 1 in 200 for DN450 to DN750.
    2. **Default: 1 in 200.** It is the figure already on the Settings page for those sizes, and CE warns but never blocks. If a council states its own, the council figure wins.

13. **BUG-499 (Structural): should roof trusses (BT1) count in the wall bracing total, and how do A and B lengths combine?**
    1. Context: two 4 m roof trusses add 8 m to the wall bracing "provided", so a short wall direction can show a green tick. A and B brace lengths are also added as if they were equal, and a brace with no type is read as type A.
    2. **Default: wall bracing counts wall braces only. A and B are shown separately, not added. A brace with no type shows "Unknown", never A.** The roof truss figure gets its own line.

14. **BUG-080: one maximum speed for UPVC pipes, in every command?**
    1. Context: Edit Pipe holds a UPVC pipe to 3.0 m/s. Auto-design holds the same pipe to 6.0 m/s, so it can pick a smaller pipe. The code has waited since July for the standard's figure.
    2. **Default: one Settings figure for UPVC, starting at 3.0 m/s**, so nothing changes on drawings already checked in Edit Pipe, and auto-design follows it. CE warns but never blocks. A council figure on the job wins (decision 176). Give me the AS/NZS figure when you have it.

15. **BUG-1094: what does amber mean on the Inspector's pipe grade?**
    1. Context: the minimum is 1 in 200. A pipe at 1 in 235 is flatter than the minimum yet shows amber, and only 1 in 241 or flatter shows red. CDRULES warns on both. (Separate finding: Codex's look on 3.0.89 saw no grade line at all. That is being chased and is not part of this question.)
    2. **Default: red for anything flatter than the minimum. Amber only means "within 20 per cent steeper than the minimum, close to the limit".**

---

## DROPPED BECAUSE C:\CE_PLAN ALREADY ANSWERS THEM

1. **BUG-1057, 1058, 1059, 1060 council values, BUG-538, BUG-431:** `decisions\2026-10-29_TIM_ANSWERS.md` item 176 (council numbers rule: CE uses the council's own published number from Settings, warns, records the source). It asks you only when two sources disagree. That is why question 5 stays and 1057 to 1059 go. BUG-1060's "which edition" falls under the same rule and the guidebook ruling in item 23.
2. **BUG-1088 and BUG-1091 sizer:** items 32 and 37 (build both, flattest allowed grade then step up a size) and item 26 (GB-01, no size ladder). The only gap left, the 450 and larger figure, is question 12.
3. **BUG-685 typed level 10.125:** item 47 (keep the 10 mm rule and print one line).
4. **BUG-1236 FO label, BUG-1242 source numbers:** items 76 and 77.
5. **BUG-1239 label gap, BUG-1267, BUG-1262, BUG-1099:** items 78, 122, 150 and 38.
6. **BUG-909, 910, 1124, 1125 CEMEMBER:** item 185 (yes to all four).
7. **BUG-553, 554, 492, 883, 1209:** items 181 to 184.
8. **BUG-311 palette edit on Cancel:** `2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` INT-027 (accept the rollback).
9. **BUG-775 pipe wall thickness:** item 17 and the later table ruling (wall thickness from pipe data, shown as Assumed until ticked).
10. **BUG-454 pad label height:** the 29 Oct answers file, line 511 (2.5 mm plot height times the annotation scale).
11. **BUG-505 no-units note:** item 10 (yes).

## LEFT OUT FOR ANOTHER REASON

1. **Pure wording or card approvals** (BUG-615, 634, 636, 934, 935, 1029, 1230): they need Tim's approval of a draft card, not an engineering answer. CE 04 can batch them separately.
2. **Rollout and privacy choices** (BUG-496, 500, 548, 1176, 557): a different kind of decision from engineering. Kept to the 15-question limit.
3. **BUG-386 (typed cover after "Stop overriding"):** INT-043 on 28 Sep already says the typed value stays. I did not find a later answer to the narrower question CE 05 sent on 1 Nov, so it may still be open.
4. **BUG-338 and BUG-321 (true size in a metre drawing), BUG-1034 (IL text position):** lower priority, and all four office templates read millimetres. They stay in the carpark for a later batch.
5. **BUG-818 steel section list and BUG-950 kN ratings:** need your own numbers or a ten-row check. They are not yes or no questions.

---

## WHAT I READ, BUILT AND TESTED

1. **Read:** `C:\TimOS\RULES.md`; the BUG-1092, 1273, 1094 and 1056 to 1091 entries in `C:\CE_PLAN\BUG_CARPARK.md`; `areas\AUDIT_CLASS_ALL_02NOV.md` (the NEEDS-TIM list); `QUESTIONS_FOR_MONDAY.md`; `decisions\2026-10-29_TIM_ANSWERS.md` and the 20 Oct and 28 Sep decision files; `04_REFERENCE\guidebook-cards\GB-01`.
2. **Git:** ran `git fetch origin` first. Commits d7bfa1d4 and 0d5e3d98 (the uphill rule, PR #1887) and 7f7bc477 (PR #1962) are inside 61fd6fbc, checked with `git merge-base --is-ancestor`. The switch names `shallowFallStatesFigure` and `errorRowsShowRed` are not in 61fd6fbc, rel-20261108a or rel-20261110a. I could not check PR state with `gh` because it is not on this tool's path.
3. **Built:** nothing. **Tested:** nothing. **Installed:** nothing changed.
4. **NOT proven:** I did not read the C# behind any question. Every "today" statement comes from the carpark text and earlier reports, not from AutoCAD tonight. The defaults on questions 7, 9 and 12 are my recommendations, not recorded rulings.
