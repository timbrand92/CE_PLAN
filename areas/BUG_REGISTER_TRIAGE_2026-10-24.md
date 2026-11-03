# Bug register triage: how to work the 1,170 bugs down before Mon 9 Nov (Sat 24 Oct 2026)

**Who and how.** The bug-register triager (Opus 5.5, Max), Sat 24 Oct 2026, about 08:15 to 09:15 Melbourne (PC clock). Read-only: no code changed, nothing built, run, installed or opened in AutoCAD, nothing closed, no bug marked fixed. `BUG_CARPARK.md`, `DESK_LOG.md` and `QUEUE.md` untouched. The only file written is this one.

**What is installed, read by me from the nine DLL product-version strings at about 08:30:** Civil 3.0.72 and Manager 1.1.72 at f7f7d551 (C-62); Structural 1.0.122 at e6d597c0 (S-42). Same as the 24 Oct recount, so nothing has been installed since.

**Sources read:** `C:\TimOS\RULES.md` (rule 4 and the 24 Oct Claude-accepted amendment), `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`, `decisions/2026-10-20_TIM_ANSWERS.md` (ruling A, the pause), every heading and Status line of `BUG_CARPARK.md` (1,170 numbered entries, BUG-001 to BUG-1220, plus the full text of about 250), `areas/V3_RECOUNT_2026-10-24.md`, `areas/FIX_BRIEFS_9NOV_2026-10-23.md`, `areas/DAILY_TOOLS_TEST_CASES_2026-10-23.md` (cards D01 to D30), `areas/RUNNER_CASE_REVIEW_2026-10-24.md`, the 20 runner cases in `C:\Lisp Files\_ACAD_DRIVER\cases` (R01 to R20; R11 to R20 landed at 08:05 today and are not yet reviewed), `areas/PR_PILE_TRIAGE_2026-10-24.md`, all sixteen `areas/REVIEW_*_24OCT.md` (171 PR verdicts), `areas/RELEASE_9NOV_GAP_PLAN_2026-10-22.md`, the open PR list (1,327 open at about 08:36, titles and bodies), and the commit messages on the installed lines, on C-63 (`claude/rel-20261024m` @ 28987b73, 28 PRs) and S-43 (`claude/rel-20261024s` @ 9ad9f605, 5 PRs).

---

## ANSWER FIRST

1. **Where the 1,170 stand today (my count, same rule as the recount plus the name-misses I found):** 43 closed, **552 fix installed and waiting for acceptance**, 242 built but not installed, **333 with no fix**. The recount's 498 / 238 / 258 covered 1,037 entries; the 133 new ones (BUG-1088 to BUG-1220) all have no fix.
2. **Acceptance backlog by route:** **348 the runner can prove with no looking (A1)**, 59 need a Codex look (A2), 21 need your engineering word (A3), 52 need real job data or another PC (A4), 72 are not ready for any check (still failing, no real fix, no AutoCAD route, or a bundle of findings to split).
3. **Fastest way to move "accepted":** 54 runner cases cover all 298 Civil and Manager A1 bugs; the ten biggest would clear 106 bugs. Start with the ones on daily tools (D cards), because they move the plan numbers too.
4. **Install backlog (242):** 33 in C-63 and 4 in S-43 (both built, not installed); 55 reviewed for C-64 and 37 for S-44; 113 are not in any train yet.
5. **Pilot-critical with no fix: 60** (section C). 7 hit a colleague on day one (the hand install and start-up); 23 are wrong-answer or data-loss risks. Only 5 have any draft work.
6. **Your question:** no, do not start plan items before Thu 29 Oct (your own 20 Oct ruling says the same). The meters are separate, so it is not a token clash; the clash is the install window, the Opus reviews, the Codex looks and your attention, which are exactly what is short. **Stop the new audits**: they filed 354 bugs in three days (BUG-867 to BUG-1220) while no bug was newly accepted.

---

## (A) THE ACCEPTANCE BACKLOG: 552 bugs whose fix is installed

**How I got 552, not 498.** 503 by the recount's rule (the bug number in a commit message on the installed lines), plus 49 installed under another name:

1. **Hunt or audit labels, found by FIX_BRIEFS on 23 Oct (35):** BUG-248, BUG-386, BUG-400, BUG-414, BUG-458, BUG-459, BUG-460, BUG-461, BUG-462, BUG-463, BUG-464, BUG-477, BUG-479, BUG-480, BUG-482, BUG-488, BUG-489, BUG-490, BUG-506, BUG-507, BUG-508, BUG-510, BUG-593, BUG-596, BUG-598, BUG-651, BUG-756, BUG-757, BUG-759, BUG-761, BUG-762, BUG-763, BUG-774, BUG-776, BUG-778. I spot-checked ten labels in the installed history (HUNT-C-01, HUNT-C-07, HUNT-M-02, HUNT-M-07, HUNT2-C-02, IJK-01, IJK-26, #641, BUG-408b, W8-09): all there.
2. **Named by an audit label, found by me (2):** BUG-862 (installed as 95eafe45 "audit HIGH 1", an ancestor of f7f7d551) and BUG-867 (installed as c079f67e, "Fix rulebook grade and speed checks to use real pipe length").
3. **Already installed, according to the Opus reviewers who rejected the duplicate PR (12):** BUG-465, BUG-481, BUG-484, BUG-485, BUG-486, BUG-487, BUG-509, BUG-511, BUG-512, BUG-513, BUG-514, BUG-515.
4. **Caution:** "installed" is an upper limit. A number in a commit can be a test or half a fix, and the carpark Status lines lag (most still say "installed in 3.0.70, not yet tested").

**The rule for each route** (RULES 4.5 and the 24 Oct amendment): A1 = a drawing value, a command-line or CE log line, a file hash or a count, run twice in separate sessions, red on a broken variant, reviewed by Opus, then "Claude-accepted". A2 = something the drafter must see (window, label position, picture, print), so a Codex look. A3 = engineering or design judgement, so your word. A4 = cannot be run on test copies on your PC (consultant packages, the update and install route, a second login or PC, old saved drawings).

### Counts

1. **A1, runner, no looking:** 348 (Civil 286, Manager 12, Structural 50).
2. **A2, Codex look:** 59.
3. **A3, your word:** 21.
4. **A4, real job data or another PC:** 52.
5. **Not ready for any acceptance:** 72 (still failing 7; carpark says no real fix 3; no AutoCAD route 19; multi-finding bundles to split first 43).
6. **Filed before about 20 Sep (66 of the 552):** these predate V3; check the entry still means something on 3.0.72 before writing its check: BUG-011, BUG-012, BUG-027, BUG-057, BUG-058, BUG-059, BUG-060, BUG-061, BUG-062, BUG-063, BUG-064, BUG-065, BUG-066, BUG-067, BUG-068, BUG-070, BUG-071, BUG-072, BUG-073, BUG-074, BUG-075, BUG-076, BUG-077, BUG-078, BUG-079, BUG-093, BUG-098, BUG-099, BUG-101, BUG-102, BUG-103, BUG-104, BUG-105, BUG-106, BUG-127, BUG-128, BUG-129, BUG-130, BUG-131, BUG-132, BUG-133, BUG-134, BUG-135, BUG-136, BUG-137, BUG-138, BUG-139, BUG-140, BUG-142, BUG-143, BUG-144, BUG-145, BUG-146, BUG-147, BUG-158, BUG-165, BUG-166, BUG-171, BUG-172, BUG-174, BUG-175, BUG-186, BUG-187, BUG-188, BUG-192, BUG-195.

### (A1) Runner cases, ranked by how many bugs one case clears (Civil and Manager first)

Each case names its daily-tool card (D number) or the existing runner case it extends. "New case" means nothing exists yet. Every case still needs the four Claude-accepted conditions; a case that covers part of a bug counts for that part only.

1. **V1, 14 bugs: CDSURVEY intake on a synthetic survey Xref (mm and metre hosts): levels kept, outliers warned, nothing stored on a refusal.** D26 (survey half); no runner case yet. BUG-134, BUG-142, BUG-144, BUG-699, BUG-700, BUG-701, BUG-702, BUG-703, BUG-704, BUG-705, BUG-706, BUG-707, BUG-708, BUG-709.
2. **W9, 14 bugs: Words sweep: one command each, compare the exact command-line line.** R05 (outcome line) plus a new sweep case. BUG-104, BUG-133, BUG-174, BUG-265, BUG-360, BUG-372, BUG-377, BUG-389, BUG-400, BUG-523, BUG-776, BUG-778, BUG-814, BUG-862.
3. **X1, 12 bugs: LandXML import from synthetic files: Read source writes nothing, Replace keeps hand-drawn pipes, levels kept.** No D card; fixtures from FB-16/FB-17 (C-63). BUG-512, BUG-513, BUG-602, BUG-603, BUG-604, BUG-605, BUG-721, BUG-722, BUG-732, BUG-876, BUG-877, BUG-878.
4. **MG1, 10 bugs: Manager on Tim's PC: support zip, click log, ribbon click while a command waits, coded names, menu bar.** No D card; new case. BUG-481, BUG-482, BUG-484, BUG-488, BUG-489, BUG-490, BUG-828, BUG-847, BUG-853, BUG-1017.
5. **Q1, 10 bugs: CDPROFILE review and drawn long section values (datum, grade, depth, cover, rows).** No D card; new case. BUG-542, BUG-599, BUG-757, BUG-758, BUG-759, BUG-761, BUG-762, BUG-763, BUG-768, BUG-769.
6. **T1, 10 bugs: Metre drawing (INSUNITS 6): PIT, CD, Edit Pipe and relink measure in metres.** No D card; new case on a metre fixture. BUG-270, BUG-271, BUG-293, BUG-309, BUG-317, BUG-323, BUG-328, BUG-330, BUG-331, BUG-393.
7. **C1, 9 bugs: CDCHECK and Checks results: counts, names, "Nothing was changed" truth, real pipe length.** D28. BUG-461, BUG-514, BUG-588, BUG-589, BUG-753, BUG-800, BUG-808, BUG-809, BUG-867.
8. **L2, 9 bugs: Locked pipe layer during edits: CE refuses or names what it skipped, never unlocks.** Native protection rule; new case. BUG-232, BUG-254, BUG-284, BUG-286, BUG-313, BUG-384, BUG-657, BUG-712, BUG-797.
9. **M1, 9 bugs: Pit MOVE, grip and STRETCH: labels and pipe ends follow once, records updated.** R12, extend. BUG-130, BUG-131, BUG-140, BUG-145, BUG-146, BUG-160, BUG-208, BUG-234, BUG-244.
10. **S1, 9 bugs: Pit Schedule cell edits stick: typed, deleted, reverted, Stop overriding.** D21 / D23; new case. BUG-385, BUG-386, BUG-408, BUG-420, BUG-463, BUG-783, BUG-791, BUG-792, BUG-1011.
11. **D1, 8 bugs: CDDESIGN draft and summary: orifice head kept, outlet kept, grade printed, own rainfall and C used.** No D card; extend R14 area. BUG-259, BUG-506, BUG-508, BUG-509, BUG-510, BUG-511, BUG-515, BUG-1004.
12. **K1, 8 bugs: Edit Pipe cascade at a junction: blank level, kept hand level, low-end pipe, hidden IL.** R11 (card C40), extend. BUG-290, BUG-652, BUG-653, BUG-654, BUG-655, BUG-656, BUG-782, BUG-963.
13. **K3, 8 bugs: Edit Pipe single save: Q-only save kept, direction kept, no false uphill warning.** D17; R20 neighbour. BUG-175, BUG-223, BUG-260, BUG-261, BUG-291, BUG-292, BUG-297, BUG-687.
14. **L1, 7 bugs: Locked pit text layers: PIT, Edit Pit and COPY refuse cleanly and name the item; REFEDIT refused.** Native protection rule; new case. BUG-262, BUG-312, BUG-458, BUG-459, BUG-460, BUG-565, BUG-672.
15. **N1, 7 bugs: CD direction: uphill answer, Cancel in the Uphill box, level 0.00, Start Pipe direction.** D01 / D04; R17 neighbour. BUG-076, BUG-205, BUG-560, BUG-582, BUG-681, BUG-682, BUG-686.
16. **R1, 7 bugs: Source tags and names: ROOF DRAIN 1 kept, WT2 offered, no duplicate DP3, no orphan record.** D07 / D08. BUG-465, BUG-740, BUG-741, BUG-742, BUG-744, BUG-746, BUG-813.
17. **R2, 7 bugs: Perimeter, AG, trench grate, spoon and strip drains: tag drawn, level asked, Close keeps the run.** D07 / D08 neighbours. BUG-101, BUG-217, BUG-236, BUG-647, BUG-743, BUG-774, BUG-966.
18. **R3, 7 bugs: Floor waste, CDFW, tanks and sources: Cancel keeps pit levels, no false refusal.** D07 neighbour. BUG-102, BUG-103, BUG-132, BUG-137, BUG-139, BUG-147, BUG-650.
19. **S2, 7 bugs: Pit Schedule rows and columns: FROM names, inlet rows, row order, IL cells, twin sizes.** D21. BUG-098, BUG-376, BUG-694, BUG-780, BUG-784, BUG-786, BUG-965.
20. **K2, 6 bugs: Batch editor: Design grade, Carry downstream, two pipes, held ends.** D17. BUG-186, BUG-253, BUG-324, BUG-339, BUG-688, BUG-689.
21. **M2, 6 bugs: ERASE and OOPS bring the pit or pipe back with its labels, one log line.** R19 (D14), extend. BUG-248, BUG-258, BUG-267, BUG-285, BUG-325, BUG-667.
22. **P1, 6 bugs: CDSYNC, CDREPAIR, CDREBUILD and CDUPGRADE keep links and direction.** D27; R13, extend. BUG-659, BUG-660, BUG-661, BUG-662, BUG-670, BUG-987.
23. **S4, 6 bugs: Pit Schedule placement, continuation sheets, read-only refusal, CDNEWDWG title.** D22. BUG-212, BUG-387, BUG-464, BUG-573, BUG-798, BUG-969.
24. **T2, 6 bugs: Metre drawing sources and messages: downpipe split, crossing split, trench grate, stray label reach.** No D card; same fixture as T1. BUG-281, BUG-663, BUG-695, BUG-696, BUG-718, BUG-745.
25. **I1, 5 bugs: Edit Pit and CDEDIT on pits: resize keeps pipe ends on walls, lid wording kept, numbering.** D09 neighbour. BUG-414, BUG-674, BUG-676, BUG-677, BUG-679.
26. **M3, 5 bugs: COPY makes a real CE copy: new number, no twin, labels and arrow come with it.** D15. BUG-210, BUG-288, BUG-665, BUG-666, BUG-671.
27. **N2, 5 bugs: Grade and length text: same-plan break length, one grade rule, mismatch tolerance from Settings, MIN suffix, pit drop.** D06 / D10; R18 neighbour. BUG-027, BUG-077, BUG-329, BUG-462, BUG-683.
28. **S3, 5 bugs: Pit Schedule depth and refresh: depth to pit floor, no -0.00, MOVE of the table writes nothing.** D21 / D23. BUG-246, BUG-779, BUG-785, BUG-807, BUG-869.
29. **V2, 5 bugs: CDSL and slab spot levels: number check, blank spot skipped, P/RL/m read alike, slab surface used.** D26. BUG-711, BUG-713, BUG-714, BUG-715, BUG-716.
30. **W1, 5 bugs: Open, look, close: no "Save changes?" (PIT BLOCK 3, CEFIND, Inspector count, Structural drawing, shutdown).** D18; R04, extend. BUG-203, BUG-214, BUG-231, BUG-793, BUG-892.
31. **E1, 4 bugs: Settings save and read back: velocity kept, Enter in search does not save, CEMANAGER does not undo CDS, Reset Civil.** R07, extend. BUG-825, BUG-830, BUG-839, BUG-957.
32. **G1, 4 bugs: CDTWL and detention numbers: two systems, levels below RL 0, highest obvert, metre pipes.** R14 (card C39), extend. BUG-777, BUG-871, BUG-970, BUG-1019.
33. **G3, 4 bugs: CDCALC tabs: no calculated zero for missing input, blank area clears results, WSUD area limits, sheet in the package.** No D card; new case. BUG-158, BUG-592, BUG-597, BUG-772.
34. **G4, 4 bugs: Cover and sizing read the Settings minimum cover, never a fixed 600.** No D card; new case. BUG-255, BUG-282, BUG-422, BUG-521.
35. **G5, 4 bugs: CDCATCHMENT areas: curved boundary, area message, stale catchment.** No D card; new case. BUG-209, BUG-593, BUG-598, BUG-643.
36. **H1, 4 bugs: Inspector values read by control text: pipe type, invert, Use plan label, raingarden area.** No D card; FB-08 recipe. BUG-191, BUG-242, BUG-572, BUG-574.
37. **N4, 4 bugs: Existing line and Esc paths: arcs kept, own polyline accepted, callout kept after Esc.** D04 neighbour; R17. BUG-187, BUG-684, BUG-697, BUG-874.
38. **P2, 4 bugs: Pipe end repair and Recover Inverts: schedule refreshed, Save keeps the repair, text redrawn.** R15 (card C38), extend. BUG-278, BUG-289, BUG-298, BUG-789.
39. **R4, 4 bugs: Raingarden, fall arrows and CDFALLSUGGEST: no false refusal, attributes justified, Enter finishes.** D07. BUG-012, BUG-079, BUG-216, BUG-773.
40. **U1, 4 bugs: U and REDO: across a drawing switch, after the tab X Cancel, the REDO family.** D19; R08. BUG-192, BUG-256, BUG-257, BUG-558.
41. **N3, 3 bugs: Pit fit and Upsize on a rotated pit, record versus label number, pit size list.** No D card; new case. BUG-138, BUG-675, BUG-680.
42. **W2, 3 bugs: Commands that must not write: CDCHECKIGNORE off, CDCHECKDWG report beside a consultant drawing, New Pit settings write.** R10 (card C16), extend; D18. BUG-306, BUG-606, BUG-863.
43. **X2, 3 bugs: CDIMPORTCOMPARE on synthetic drawings: missing pits and pipes counted, open reference read.** No D card; new case. BUG-607, BUG-726, BUG-727.
44. **C2, 2 bugs: Project QA and Design Review use the office Settings and go stale after CE edits.** D28 neighbour. BUG-790, BUG-801.
45. **E2, 2 bugs: Damaged settings file variants: no silent reset to standard values.** R07 neighbour; needs a guarded copy. BUG-827, BUG-842.
46. **M4, 2 bugs: Paste between drawings: a line says what arrived; paste into a drawing with no drainage.** No D card; new case. BUG-305, BUG-342.
47. **N5, 2 bugs: Callout picks use NEAREST only while a callout point is picked.** No D card; old (14-15 Sep). BUG-106, BUG-127.
48. **Y1, 2 bugs: Speed: COPY of one pit and ARRAY of 299 pipes under a time limit.** No D card; timing case. BUG-266, BUG-269.
49. **Z1, 2 bugs: Old pipes upgraded on first open, then Edit Pipe shows the right type.** No D card; old-pipe fixture DRV17_B1. BUG-171, BUG-378.
50. **I2, 1 bug: CDRENUMBER with two pipes recorded opposite ways.** D20. BUG-968.
51. **MG2, 1 bug: CE Blocks insert keeps block attribute tags.** No D card. BUG-188.
52. **O1, 1 bug: Double-click an IL text opens Edit Pipe.** R09 neighbour (C04). BUG-166.
53. **P3, 1 bug: CDXREFREPAIR never points an Xref at the host or a stale copy.** No D card. BUG-795.
54. **P9, 1 bug: PIT on one half of a broken pipe: the other half is left alone (with FB-02/07 in C-63).** D02 / D03 neighbour. BUG-691.

**Structural A1 (50 bugs, after 9 Nov: Structural stays on your PC):**

1. **ST1, 8 bugs: Structural Undo and footing redraw.** BUG-215, BUG-274, BUG-314, BUG-333, BUG-334, BUG-336, BUG-341, BUG-368.
2. **ST2, 10 bugs: Structural settings and job file.** BUG-204, BUG-272, BUG-273, BUG-276, BUG-299, BUG-316, BUG-429, BUG-504, BUG-520, BUG-575.
3. **ST3, 9 bugs: Structural dimensions and annotation (DSET, DUP, MLL, BL, 25C).** BUG-621, BUG-622, BUG-629, BUG-633, BUG-635, BUG-636, BUG-637, BUG-638, BUG-646.
4. **ST4, 11 bugs: Structural members, beams and columns.** BUG-185, BUG-211, BUG-237, BUG-250, BUG-277, BUG-302, BUG-344, BUG-577, BUG-584, BUG-585, BUG-612.
5. **ST5, 12 bugs: Structural schedules, references and prompts.** BUG-220, BUG-303, BUG-335, BUG-381, BUG-382, BUG-388, BUG-394, BUG-418, BUG-532, BUG-617, BUG-618, BUG-619.

**Daily-tool cases first.** The gap plan needs 30 of its 40 daily-tool checks accepted by Fri 30 Oct. The cases that sit on a D card are N1, N2, N4 (D01 to D06, D10, D12), M1 to M3 (D14, D15), K2 and K3 (D17), W1 and W2 (D18), U1 (D19), I2 (D20), S1 to S4 (D21 to D23), R1 to R4 (D07, D08), V2 (D26), P1 (D27) and C1, C2 (D28): 137 bugs.

### (A2) Codex looks (59)

1. **Labels, symbols and drawn output on the plan or long section (27):** BUG-011, BUG-072, BUG-074, BUG-075, BUG-078, BUG-093, BUG-105, BUG-128, BUG-129, BUG-135, BUG-136, BUG-143, BUG-243, BUG-321, BUG-322, BUG-600, BUG-601, BUG-614, BUG-624, BUG-628, BUG-632, BUG-669, BUG-678, BUG-748, BUG-756, BUG-767, BUG-858.
2. **Window look and layout (17):** BUG-070, BUG-071, BUG-073, BUG-099, BUG-170, BUG-173, BUG-219, BUG-224, BUG-239, BUG-263, BUG-416, BUG-476, BUG-507, BUG-583, BUG-596, BUG-620, BUG-754.
3. **Ribbon, tooltips and buttons (11):** BUG-172, BUG-177, BUG-180, BUG-194, BUG-226, BUG-227, BUG-228, BUG-264, BUG-518, BUG-524, BUG-850.
4. **Printed or exported PDF (3):** BUG-233, BUG-590, BUG-591.
5. **Exported Excel workbook (1):** BUG-571.

Batch these into Codex look briefs by window or command, the same way as the D-series looks now being written. BUG-224 needs a Save As, which runner cases forbid, so it is here too.

### (A3) Your word (21)

1. **BUG-057:** CDDASHBOARD "Propose fixes" results (July; recorded as "Tim handling").
2. **BUG-063:** X-Civil import: council connection stub and existing council pipes (design item).
3. **BUG-065:** X-Civil import: imported pipes ending at the pit outline.
4. **BUG-066:** X-Civil import: the quality bar for imported labels (needs your screenshot).
5. **BUG-176:** a raingarden or grated inlet landing on a pipe.
6. **BUG-230:** CDCATCHMENT on a drawing with units unset: Unknown on every job, or a default.
7. **BUG-252:** pipe roughness defaults (your AS/NZS values).
8. **BUG-287:** metre drawings with millimetre-sized pits: the 0.1 m reach.
9. **BUG-308:** the New Pipe footer layout (may be intended).
10. **BUG-315:** Structural: schedule text with DIMSCALE 0.
11. **BUG-353:** grade label 1 in 193 against levels giving 1 in 136 (question b of BUG-351).
12. **BUG-401:** should New Pit offer the last cover level after a restart.
13. **BUG-417:** X-Civil import onto locked layers: ask or skip.
14. **BUG-423:** real names left in three places (privacy question on #745).
15. **BUG-468:** Structural: columns placed with beam linking off, against the roof-down card.
16. **BUG-478:** how a colleague finishes an update.
17. **BUG-531:** Structural: text heights ("do not change without consulting Tim").
18. **BUG-649:** office minimum fall for AG drains.
19. **BUG-834:** installer and an old prepared update: refuse or warn.
20. **BUG-967:** how a Blue Factor "Other" area counts.
21. **BUG-999:** is CDRUNSOLVE meant to solve levels, or say it could not.

### (A4) Real job data or another PC (52)

1. **X-Civil import of a consultant package (needs a real DWG plus PDF schedule) (22):** BUG-058, BUG-059, BUG-060, BUG-061, BUG-062, BUG-064, BUG-067, BUG-068, BUG-651, BUG-717, BUG-730, BUG-731, BUG-733, BUG-734, BUG-735, BUG-736, BUG-737, BUG-738, BUG-739, BUG-747, BUG-781, BUG-794.
2. **The update and install route (approval, staging, installer; tests of it have run live deploy scripts before) (13):** BUG-165, BUG-356, BUG-477, BUG-479, BUG-486, BUG-487, BUG-823, BUG-824, BUG-832, BUG-835, BUG-838, BUG-851, BUG-947.
3. **Needs a second Windows login, a colleague PC, offline office folder or a PC without Structural (15):** BUG-405, BUG-480, BUG-485, BUG-522, BUG-829, BUG-833, BUG-836, BUG-843, BUG-844, BUG-845, BUG-848, BUG-849, BUG-852, BUG-946, BUG-948.
4. **Needs a real council job (Kingston) (1):** BUG-251.
5. **Needs a drawing saved wrong by an old build (1):** BUG-268.

The ENV group lines up with the gap plan's spare-login rehearsal: run them in the same sitting as the hand-install rehearsal.

### Not ready for any acceptance (72)

1. **Fix installed but still failing on record (7), back to a builder, not a tester:** BUG-396, BUG-430, BUG-505, BUG-642, BUG-788, BUG-859, BUG-861. BUG-859 (downpipe double-click) fails runner R09 on 3.0.72 and has round 3 waiting in C-63; BUG-861 (REDO after a pick) fails R08 5 of 5, cause not yet proven to be CE.
2. **Carpark says no runtime fix, despite the number on the installed line (3):** BUG-586 (tests only), BUG-594 (its fix is PR #1277, not installed) and BUG-866 (the rainfall note; the installed "BUG-866" commits are the other bug with the same number, CDCHECKIGNORE Undo, #1524). The doubled BUG-866 heading needs a new number from the desk.
3. **No AutoCAD route (19): latent code, test-only or internal; accept by review or close (your call, D6):** BUG-167, BUG-247, BUG-275, BUG-279, BUG-280, BUG-294, BUG-318, BUG-398, BUG-407, BUG-457, BUG-549, BUG-551, BUG-556, BUG-557, BUG-673, BUG-770, BUG-831, BUG-837, BUG-846.
4. **Bundles of several findings in one entry (43): split into one bug each before any check (old finalizer leftovers and Codex W-pass notes from 3 to 9 Oct):** BUG-195, BUG-296, BUG-332, BUG-346, BUG-347, BUG-348, BUG-350, BUG-351, BUG-352, BUG-355, BUG-357, BUG-358, BUG-362, BUG-363, BUG-364, BUG-365, BUG-366, BUG-367, BUG-369, BUG-370, BUG-375, BUG-380, BUG-413, BUG-424, BUG-425, BUG-426, BUG-427, BUG-428, BUG-432, BUG-433, BUG-434, BUG-435, BUG-437, BUG-438, BUG-440, BUG-442, BUG-443, BUG-446, BUG-447, BUG-450, BUG-452, BUG-454, BUG-544.

---

## (B) INSTALL BACKLOG: 242 built, not installed

1. **In C-63, built, not installed (33):** BUG-373, BUG-570, BUG-664, BUG-690, BUG-692, BUG-693, BUG-719, BUG-720, BUG-723, BUG-724, BUG-725, BUG-728, BUG-729, BUG-760, BUG-764, BUG-771, BUG-796, BUG-802, BUG-817, BUG-868, BUG-875, BUG-884, BUG-886, BUG-889, BUG-899, BUG-917, BUG-934, BUG-942, BUG-943, BUG-964, BUG-971, BUG-1028, BUG-1030. C-63 also carries follow-up fixes for six bugs whose first fix is installed: BUG-290, BUG-859 (round 3), BUG-869, BUG-967, BUG-969 and BUG-1019. It holds the engineering HIGH 2 fix (BUG-868, pipe material in the solver) and the FB briefs FB-02, FB-04 to FB-07, FB-11, FB-13, FB-14, FB-16, FB-17, FB-19, FB-20.
2. **In S-43, built, not installed (4):** BUG-818, BUG-955, BUG-956, BUG-1014.
3. **Reviewed MERGE or MERGE-WITH-FIXES for C-64 (55):** BUG-491, BUG-552, BUG-555, BUG-710, BUG-766, BUG-799, BUG-803, BUG-810, BUG-811, BUG-812, BUG-904, BUG-906, BUG-918, BUG-927, BUG-944, BUG-945, BUG-960, BUG-961, BUG-979, BUG-980, BUG-981, BUG-982, BUG-988, BUG-990, BUG-991, BUG-992, BUG-993, BUG-994, BUG-995, BUG-996, BUG-997, BUG-998, BUG-1000, BUG-1001, BUG-1002, BUG-1003, BUG-1005, BUG-1007, BUG-1008, BUG-1009, BUG-1010, BUG-1012, BUG-1021, BUG-1022, BUG-1024, BUG-1032, BUG-1035, BUG-1036, BUG-1067, BUG-1068, BUG-1074, BUG-1075, BUG-1085, BUG-1086, BUG-1087. Add BUG-1042, BUG-1044 and BUG-1045: PR #1720 (audit RD03, MERGE for C-64) fixes them but names only its audit code, so no count by number sees it.
4. **Reviewed for S-44 (37):** BUG-534, BUG-566, BUG-608, BUG-610, BUG-644, BUG-645, BUG-752, BUG-755, BUG-826, BUG-840, BUG-841, BUG-880, BUG-881, BUG-911, BUG-912, BUG-950, BUG-951, BUG-953, BUG-972, BUG-973, BUG-974, BUG-975, BUG-976, BUG-977, BUG-978, BUG-983, BUG-984, BUG-985, BUG-986, BUG-1013, BUG-1015, BUG-1016, BUG-1025, BUG-1037, BUG-1038, BUG-1039, BUG-1082.
5. **Not in any train (113):**
   1. **Reviewed HOLD (10):** BUG-546, BUG-548, BUG-609, BUG-751, BUG-787, BUG-860, BUG-925, BUG-1080, BUG-1081, BUG-1083. BUG-860 (green downpipe label, #1521) is held only for its command card; BUG-787 (#1423) and BUG-925 (#1661) are held too.
   2. **Reviewed REJECT with nothing installed (6):** BUG-750, BUG-949, BUG-952, BUG-1064, BUG-1065, BUG-1066. BUG-750 was superseded by your decision (close candidate); BUG-949, BUG-952 and BUG-1064 to BUG-1066 had only an audit or routing note, so they really have no fix.
   3. **Reviewed, mixed verdicts (2):** BUG-496, BUG-500.
   4. **In an open PR nobody has reviewed (66):** Civil and Manager BUG-069, BUG-225, BUG-283, BUG-403, BUG-471, BUG-547, BUG-559, BUG-561, BUG-563, BUG-580, BUG-668, BUG-805, BUG-870, BUG-879, BUG-882, BUG-885, BUG-887, BUG-893, BUG-894, BUG-895, BUG-896, BUG-897, BUG-928, BUG-929, BUG-930, BUG-931, BUG-932, BUG-933, BUG-935, BUG-936, BUG-937, BUG-938, BUG-939, BUG-940, BUG-941, BUG-954, BUG-989, BUG-1006, BUG-1018, BUG-1020, BUG-1023, BUG-1026, BUG-1027, BUG-1029, BUG-1040, BUG-1041, BUG-1043, BUG-1047; Structural BUG-406, BUG-439, BUG-453, BUG-497, BUG-498, BUG-499, BUG-501, BUG-502, BUG-503, BUG-517, BUG-519, BUG-527, BUG-530, BUG-541, BUG-543, BUG-545, BUG-550, BUG-576. Two of these block the 9 Nov gap plan: **BUG-885** (#1649, delivered files must equal the tested build) and **BUG-517** (no blue, #1029, #1041, #1043). BUG-225 (#1706, FB-12) was left out of C-63 on purpose; BUG-668 (#1539, FB-01) is a first slice only.
   5. **No open PR at all (29):** BUG-053, BUG-080, BUG-083, BUG-084, BUG-085, BUG-086, BUG-088, BUG-089, BUG-090, BUG-091, BUG-092, BUG-094, BUG-864, BUG-913, BUG-914, BUG-915, BUG-916, BUG-919, BUG-920, BUG-921, BUG-922, BUG-923, BUG-924, BUG-926, BUG-1056, BUG-1057, BUG-1058, BUG-1059, BUG-1060. BUG-913 to BUG-916, BUG-919 to BUG-924 and BUG-926 sit in #1534 (on HOLD; its title names no bug). BUG-053, BUG-080, BUG-083 to BUG-086, BUG-088 to BUG-092 and BUG-094 are July to September work never finished on V3: re-check or close (your call). BUG-1056 to BUG-1060 have only the rejected routing note #1715.

**What this means:** the next two installs (C-63, then C-64 with #1720) would move 91 bugs from built to installed. 113 have no train and 95 of those have never been reviewed.

---

## (C) PILOT-CRITICAL WITH NO FIX: the 60 a colleague would meet in week one

**Which 60:** 59 bugs with no fix plus BUG-866, whose number is shared with an installed fix for a different bug (section A).

**How ranked:** severity in the carpark times how often a drafter meets the tool in the first week (start-up and install every day; PIT, CD, Edit, MOVE/COPY and the Pit Schedule many times a day; survey and long section weekly; CDDESIGN once a job). **WRONG ANSWER** or **DATA LOSS** marks the ones that can put a wrong number on an issued drawing or silently lose work. "PR" says whether any draft exists (searched by bug number, branch name, PR body and the audit code).

### Day one: the hand install and start-up

1. **BUG-1167, MEDIUM.** Copying your settings file to a colleague carries your own office-folder paths (the hand install copies your switches). PR: none.
2. **BUG-1165, MEDIUM.** An old Civil bundle in the all-users plug-ins folder supplies the pit blocks first. PR: none.
3. **BUG-1169, MEDIUM, UNSURE.** A colleague's old July Structural may load an older shared file with the same version number (first loaded wins). PR: none.
4. **BUG-1166, MEDIUM.** Civil and Manager look for the office folders in different places (CDFEEDBACK, CE Blocks, CDNEWDWG, CDWT, job time). PR: none.
5. **BUG-1206, MEDIUM.** Manager loaded before Civil leaves the CE Tools tab missing. PR: none.
6. **BUG-1138, MEDIUM.** **DATA LOSS.** On a PC without the pipe-object add-on, CDSYNC and every relink empty all pits' pipe lists. PR: none.
7. **BUG-1135, HIGH.** **DATA LOSS.** An older CE silently deletes newer parts of the job record (a colleague on the pilot build opening a drawing you saved on a newer build). PR: none.

### Daily drafting: PIT, CD, Edit, paste and the Pit Schedule

8. **BUG-1196, HIGH.** **WRONG ANSWER.** Pit Schedule refresh after Edit Pit ignores a lower second outgoing pipe: depth and step-iron note change. PR: none.
9. **BUG-540, MEDIUM-HIGH.** **WRONG ANSWER.** Step-iron depth read from two places that can disagree (Pit Schedule and pit set-up). PR: built on branch claude/b4-r00-step-iron-depth; its PR #1192 was REJECTED in review B3.
10. **BUG-1049, MEDIUM.** Batch edit: one ticked but blank field disables Apply for the whole batch. PR: none.
11. **BUG-1150, MEDIUM.** **DATA LOSS.** A network pasted into a new drawing goes quiet after reopening: pits move without their pipes. PR: none.
12. **BUG-1148, MEDIUM.** **WRONG ANSWER.** Pasting a pit from a Save As sister drawing gives it this drawing's pit values. PR: none.
13. **BUG-1140, MEDIUM.** A pasted downpipe keeps a link to the original's label, so MOVE or CDREPAIR acts on the wrong object. PR: none.
14. **BUG-857, LOW, your word.** Grade mismatch box: X still places the pipe. PR: none.
15. **BUG-685, MEDIUM, your ruling.** **WRONG ANSWER.** CD "work it out from the grade" rounds the typed level. PR: none.
16. **BUG-855, LOW.** Pit Schedule "data issues" count goes up by one after the first CDSYNC (FB-15). PR: none.
17. **BUG-587, MEDIUM.** Drawn Pit Schedule remarks cross the row lines on the issued sheet. PR: related PR #1286 (BUG-586/637), unreviewed; check whether it covers this.
18. **BUG-1145, MEDIUM.** An Xref'd Pit Schedule says OUT OF DATE and fails Project QA when nothing changed. PR: none.
19. **BUG-1149, MEDIUM.** After BIND of a CE Xref the schedule says SOURCE MISSING and QA fails for good. PR: none.
20. **BUG-1198, MEDIUM.** Cancel on a Pit Schedule export still saves the row order into the drawing. PR: none.
21. **BUG-1031, MEDIUM.** No "Delete cell" on the Pit Schedule cell right-click menu. PR: none.
22. **BUG-1194, MEDIUM.** CDTEXTSEG moves the label to the nearest leg, not the leg you clicked. PR: none.
23. **BUG-865, LOW-MEDIUM.** Every double-click on a block scans every block: slow in survey drawings. PR: none.
24. **BUG-816, LOW-MEDIUM.** A "no clear spot" line prints after MOVE even with Tidy labels off. PR: none.
25. **BUG-1142, MEDIUM.** **DATA LOSS.** One unreadable pit record stops new pipes linking to any pit, while the pipe looks saved. PR: none.

### Survey and long section (weekly)

26. **BUG-1189, HIGH.** **WRONG ANSWER.** Approved survey levels stay in use after the survey Xref is moved. PR: none.
27. **BUG-1190, HIGH.** **WRONG ANSWER.** Levels inside a nested, rotated survey block land in the wrong places. PR: none.
28. **BUG-1192, HIGH.** **WRONG ANSWER.** The long section throws away survey levels more than 1.20 m from the cover line, hiding a depression. PR: none.

### Design numbers (CDDESIGN ships with its warning; CDCALC and CDRULES)

29. **BUG-1088, HIGH.** **WRONG ANSWER.** The automatic pipe sizer picks the smallest pipe at any grade, up to 1 in 1. PR: none.
30. **BUG-1095, HIGH.** **WRONG ANSWER.** The council minimum after-development C is never applied (Darebin, Maribyrnong, Boroondara). PR: none.
31. **BUG-1099, HIGH.** **WRONG ANSWER.** Maroondah and Yarra Ranges: the council's own before-development C and Tc table are stored but never used. PR: none.
32. **BUG-1091, MEDIUM.** **WRONG ANSWER.** Redesign and auto-design drop the minimum grade for DN450 and larger. PR: none.
33. **BUG-1106, MEDIUM.** A rating report naming a two-word council (Glen Eira, Yarra Ranges) sets a council CE cannot find. PR: none.
34. **BUG-901, MEDIUM.** **WRONG ANSWER.** Cover is measured to the inside top of the pipe, so it is over-stated by the wall thickness. PR: none.
35. **BUG-907, MEDIUM.** **WRONG ANSWER.** Pit drop where the pipe gets bigger compares inverts only (a 150 in, 300 out can pass). PR: none.
36. **BUG-905, MEDIUM.** **WRONG ANSWER.** CDCALC Boyd's tab and CDDESIGN use different hard-ground C, so one job gets two storage figures. PR: none.
37. **BUG-902, MEDIUM.** Cover is checked only at the two pits, not under a lower garden bed between them. PR: none.
38. **BUG-903, MEDIUM.** Different screens judge one pipe against different minimum grades and cover. PR: none.
39. **BUG-1090, MEDIUM.** Nothing says the hydraulic grade line and pit losses were not checked (the computations sheet goes to council). PR: none.
40. **BUG-1101, MEDIUM.** CDCALC Catchments opens with a made-up catchment and a 15-minute storm. PR: none.
41. **BUG-1097, HIGH.** The 300 mm minimum head on a charged downpipe system is never checked. PR: none.
42. **BUG-1096, HIGH.** The rainwater-tank reuse credit never runs on a real job (errs towards more storage). PR: none.
43. **BUG-866, HIGH, your word.** **WRONG ANSWER.** CDDESIGN says the office rainfall curve reads "7 to 9 per cent high" (engineering HIGH 3; gap plan blocker). PR: none (Monday question 1).

### Manager, feedback and the colleague pack

44. **BUG-1215, MEDIUM.** Feedback Help promises a "Save report" step that does not exist (CDFEEDBACK is the colleague's only bug route). PR: none.
45. **BUG-1179, MEDIUM.** A failed read of the office approval file can still show "CE is current.". PR: none (compare BUG-480, installed as HUNT-M-05).
46. **BUG-1171, LOW.** Civil's reports to you never arrive and pile up on a colleague's PC. PR: none.
47. **BUG-1173, LOW.** The colleague pack's backup step saves only 2 of the CE settings folders. PR: none.
48. **BUG-1170, MEDIUM, UNSURE.** Going back restores an old Manager that may stage updates by itself. PR: none.
49. **BUG-1168, MEDIUM.** The job-time folder is fixed on the first start. PR: none.
50. **BUG-1202, MEDIUM.** The weekly time export runs on the AutoCAD start-up thread (same as BUG-1177). PR: none.
51. **BUG-1180, MEDIUM.** Drawing Repair says "Nothing has been changed" after a successful repair. PR: none.

### Only if the colleague is on AutoCAD 2022 to 2024 (his AutoCAD year is not recorded: gap plan question 7)

52. **BUG-1209, HIGH.** A downpipe cannot be placed directly on a pit. PR: none.
53. **BUG-1137, HIGH.** **DATA LOSS.** One downpipe in a COPY cancels the copy clean-up for every pit and pipe in it. PR: none.
54. **BUG-1210, MEDIUM.** Edit Pipe and Edit Pit lose the plan and picture selection. PR: none.
55. **BUG-1151, MEDIUM.** Moving a pit leaves CE pipe-object ends behind with no message. PR: none.

### Imports and drains (weekly, not daily)

56. **BUG-1188, HIGH.** **WRONG ANSWER.** A LandXML pipe with no grade prints an invented "AT 1 IN 100". PR: none.
57. **BUG-1053, HIGH.** **WRONG ANSWER.** LandXML cover and invert levels are not converted from millimetres to metres. PR: draft PR #1716 (HOLD for C-64) and #1727 (rebased, unreviewed).
58. **BUG-1052, HIGH (metre drawings).** **WRONG ANSWER.** CDAGI and CDPERIMETER pass a flat drain in a metre drawing. PR: draft PR #1716 (HOLD) and #1727.
59. **BUG-648, MEDIUM.** AG drain grade is checked but never labelled (FB-18). PR: none (#1268 is BUG-649).
60. **BUG-525, LOW-MEDIUM.** The other blues (release gate item 9, "no blue"). PR: built on branches codex/noblue-civil, -manager, -shared; no PR names it.

**HIGH data-loss or wrong-answer risks (23):** BUG-540, BUG-685, BUG-866, BUG-901, BUG-905, BUG-907, BUG-1052, BUG-1053, BUG-1088, BUG-1091, BUG-1095, BUG-1099, BUG-1135, BUG-1137, BUG-1138, BUG-1142, BUG-1148, BUG-1150, BUG-1188, BUG-1189, BUG-1190, BUG-1192, BUG-1196.

**Left out of the 60 because a fix exists elsewhere:** BUG-1042, BUG-1044, BUG-1045 (PR #1720, C-64) and BUG-867 (installed). **Also check:** of FIX_BRIEFS' 31 briefed bugs, 26 are now built or installed (18 in C-63, 5 reviewed for C-64, 3 installed); BUG-855 (FB-15), BUG-648 (FB-18) and BUG-765 (FB-21, skipped for your word) have no PR; BUG-225 (FB-12, #1706) and BUG-668 (FB-01, #1539) are unreviewed.

---

## (D) PARK LIST: the other 271 no-fix bugs, and why each can wait until after 9 Nov

Nothing here is closed (D6). "Close candidate" means you may close it on one look; the desk asks you once, in a batch.

1. **Structural only (85).** Structural stays on your PC for 9 Nov (ruling B3). BUG-202, BUG-300, BUG-304, BUG-349, BUG-383, BUG-399, BUG-409, BUG-410, BUG-411, BUG-448, BUG-451, BUG-466, BUG-467, BUG-469, BUG-470, BUG-472, BUG-473, BUG-474, BUG-475, BUG-493, BUG-494, BUG-495, BUG-526, BUG-529, BUG-533, BUG-535, BUG-536, BUG-537, BUG-564, BUG-578, BUG-579, BUG-611, BUG-613, BUG-615, BUG-616, BUG-623, BUG-625, BUG-626, BUG-627, BUG-630, BUG-631, BUG-634, BUG-640, BUG-749, BUG-819, BUG-909, BUG-910, BUG-1048, BUG-1061, BUG-1062, BUG-1063, BUG-1072, BUG-1073, BUG-1076, BUG-1077, BUG-1078, BUG-1079, BUG-1084, BUG-1121, BUG-1122, BUG-1123, BUG-1126, BUG-1127, BUG-1128, BUG-1129, BUG-1130, BUG-1131, BUG-1132, BUG-1133, BUG-1136, BUG-1139, BUG-1146, BUG-1147, BUG-1154, BUG-1159, BUG-1183, BUG-1184, BUG-1185, BUG-1186, BUG-1187, BUG-1199, BUG-1200, BUG-1203, BUG-1204, BUG-1219.
2. **Old (May to early October), no evidence on a V3 build (34).** Re-test before any brief; many are probably overtaken. BUG-014, BUG-015, BUG-016, BUG-017, BUG-020, BUG-021, BUG-022, BUG-023, BUG-024, BUG-025, BUG-026, BUG-028, BUG-030, BUG-032, BUG-033, BUG-034, BUG-035, BUG-036, BUG-037, BUG-038, BUG-041, BUG-049, BUG-050, BUG-051, BUG-206, BUG-229, BUG-235, BUG-310, BUG-319, BUG-320, BUG-340, BUG-343, BUG-415, BUG-436.
3. **Needs your word or a council value (rule 3.4: never turned into a decision for you) (26).** BUG-003, BUG-054, BUG-056, BUG-095, BUG-213, BUG-222, BUG-245, BUG-249, BUG-311, BUG-337, BUG-338, BUG-419, BUG-431, BUG-483, BUG-492, BUG-538, BUG-539, BUG-641, BUG-765, BUG-1094, BUG-1109, BUG-1110, BUG-1116, BUG-1120, BUG-1124, BUG-1125.
4. **Needs a feature or a plan item, not a fix of shipped behaviour (paused by ruling A until 29 Oct) (17).** BUG-029, BUG-031, BUG-042, BUG-052, BUG-553, BUG-554, BUG-883, BUG-888, BUG-908, BUG-1100, BUG-1102, BUG-1104, BUG-1105, BUG-1114, BUG-1117, BUG-1119, BUG-1160.
5. **Rare tool or rare set-up: metre drawings, imports, damaged records, a second AutoCAD, Help pages for rarely used tools (41).** BUG-397, BUG-581, BUG-595, BUG-658, BUG-821, BUG-822, BUG-898, BUG-900, BUG-1046, BUG-1051, BUG-1054, BUG-1055, BUG-1070, BUG-1089, BUG-1093, BUG-1103, BUG-1107, BUG-1108, BUG-1113, BUG-1118, BUG-1141, BUG-1143, BUG-1144, BUG-1153, BUG-1155, BUG-1156, BUG-1157, BUG-1158, BUG-1161, BUG-1163, BUG-1164, BUG-1176, BUG-1177, BUG-1178, BUG-1191, BUG-1193, BUG-1195, BUG-1197, BUG-1201, BUG-1205, BUG-1207.
6. **Cosmetic or wording, low (15).** BUG-528, BUG-1033, BUG-1050, BUG-1092, BUG-1111, BUG-1112, BUG-1172, BUG-1174, BUG-1175, BUG-1181, BUG-1182, BUG-1216, BUG-1217, BUG-1218, BUG-1220.
7. **Switched off or not reachable for colleagues (Tidy labels, AI, hidden commands, window-position memory, latent until another bug is fixed) (15).** BUG-775, BUG-804, BUG-806, BUG-873, BUG-890, BUG-891, BUG-958, BUG-959, BUG-962, BUG-1034, BUG-1071, BUG-1098, BUG-1134, BUG-1162, BUG-1208.
8. **AutoCAD 2022 to 2024 only, low (6).** Move up if the colleague is on an older AutoCAD. BUG-1115, BUG-1152, BUG-1211, BUG-1212, BUG-1213, BUG-1214.
9. **Test tools, the test PC or evidence records, not product faults (FIX_BRIEFS group 6) (32).** Close candidates. BUG-007, BUG-096, BUG-097, BUG-240, BUG-295, BUG-307, BUG-326, BUG-345, BUG-354, BUG-361, BUG-371, BUG-374, BUG-390, BUG-391, BUG-392, BUG-395, BUG-402, BUG-404, BUG-412, BUG-421, BUG-441, BUG-444, BUG-445, BUG-455, BUG-456, BUG-562, BUG-567, BUG-568, BUG-569, BUG-639, BUG-872, BUG-1069.

**Close candidates (duplicates or obsolete; for you to decide, D6):**

1. **BUG-007:** a tracking entry for the 8 May Monday batch, not a bug.
2. **BUG-052:** PIT BLOCK 3 adoption, overtaken by the automatic migration (BUG-793).
3. **BUG-192:** tracked under BUG-256, BUG-558 and BUG-861 (its own status says so).
4. **BUG-307:** same red Glen Eira back-test as BUG-095 and BUG-872.
5. **BUG-402:** same start-up line "[CE_StrucPlus] LISP not found" as BUG-354.
6. **BUG-564:** FEDIT Esc then U: same Esc fault family as BUG-469.
7. **BUG-821:** works as designed (FIX_BRIEFS 23 Oct group 8).
8. **BUG-872:** same red Glen Eira back-test as BUG-095 and BUG-307.
9. **BUG-1177:** same weekly time export at start-up as BUG-1202.
10. **BUG-1179:** check against BUG-480 (HUNT-M-05, installed): same "CE is current" line.
11. **BUG-750:** superseded by your SBEAM side-elevation decision (review B6).
12. **The 32 test-tool and evidence entries in item 9 above** (not product faults).
13. **BUG-866 and BUG-036, BUG-612:** not closures. BUG-866 is two different bugs under one number; BUG-036 and BUG-612 each carry a sub-heading. The desk should renumber the second BUG-866.

---

## (E) MY RECOMMENDATION

### First: install what is built, and keep the runner busy on it (Sat 24 to Tue 27 Oct)

1. **Before C-63 goes in:** edit runner cases R08, R09 and R10 as the runner review says and re-run them red on 3.0.72, so a green on C-63 counts at once (Max, the runner).
2. **Install C-63 at your next "AutoCAD is closed, deploy"** (it is built and reviewed; 33 bugs plus six follow-ups, including engineering HIGH 2 and the downpipe double-click round 3).
3. **Opus-review the two gap-plan blockers nobody has reviewed:** #1649 (BUG-885, delivered files equal the tested build) and the no-blue PRs #1029, #1041, #1043 (BUG-517). Write BUG-860's command card so #1521 can leave HOLD (Max, Opus).
4. **Assemble C-64** from the 55 reviewed bugs plus #1720, then the pilot fixes from step 9 as they pass review. One train, one install (RULES 8.5).

### Second: turn "installed" into "accepted" (from now to Fri 30 Oct checkpoint)

5. **Runner (Claude-accepted):** the Opus review of R11 to R20 first (they landed at 08:05, unreviewed), then write the daily-tool cases in section A1 (N1, N2, N4, M1 to M3, K2, K3, W1, W2, U1, S1 to S4, R1 to R4, V2, P1, C1, C2). Sonnet on Team writes each case, Opus on Max fills `reviewed_against`, and every case gets a real red (a switch) where one exists. These move the bug count and the gap plan's 30-of-40 daily checks together.
6. **Codex (PACE mode, inside the daily share):** looks only, in batches by window: the A2 list (59) plus the D-series look briefs already being written. No Codex building until the looks are done.
7. **Your word, once, in work hours:** the 21 A3 bugs plus the "Tim's word" items in sections C and D, as one batch of plain questions with a recommendation each. The rainfall note (BUG-866) and CD rounding (BUG-685) first.
8. **Spare-login sitting:** run the A4 ENV and INSTALL checks in the same sitting as the hand-install rehearsal the gap plan needs by Fri 30 Oct.

### Third: fix only the pilot-critical 60, day-one items first

9. **Team (Sonnet builders, Opus review):** write briefs for section C in its order: the 7 day-one items (they decide whether the hand install works at all), then BUG-1196 and BUG-540 (wrong step irons), the paste and Xref schedule faults, then survey and the design numbers. Max's AutoCAD year decides whether the four older-lane bugs move up: ask that question this week.

### Stop doing

10. **Stop new audits** until accepted bugs pass about 100. The last three days filed 354 bugs (BUG-867 to BUG-1220) and accepted none; each audit makes the list longer without making AutoCAD better.
11. **Stop opening PRs that are not on the C list or a train.** 1,327 PRs are open; 787 are already installed (triage class A). Closing those is your call, but it would let reviewers see what is left.
12. **Stop Structural fix PRs until after 9 Nov** (S-44 is already 37 bugs deep), except anything Codex finds broken on your own PC.

### Your question: would building plan items now distract from the bug list?

1. **Short answer: yes, and you have already ruled on it.** Your 20 Oct ruling pauses new plan items until you are back on Thu 29 Oct, or earlier only if the bug queue is finished. It is not finished: 60 pilot-critical bugs have no fix.
2. **It is not a token problem.** Team, Max and Codex are separate meters, so plan building on Team would not take tokens from bug fixing.
3. **It is a bottleneck problem.** Built is already far ahead: 242 bug fixes are built and not installed, and the plan is 75 per cent built against 1 item accepted. Plan work adds more PRs to review (Opus on Max), more clashes in each train, more to install, more Codex looks and more of your questions. Those are exactly the four things that are short.
4. **What spare Team capacity should do instead:** runner cases and their fixtures (section A1), the section C fixes, and fixtures for the A4 checks. That work moves accepted, which is the number furthest behind.
5. **After 29 Oct:** if C-63 and C-64 are installed and the daily checks are near 30 of 40, start the 9 Nov-scope plan items again, smallest first, one train at a time.

---

## Method, and what I did not check (RULES 5.9)

1. **Classes.** Closed = a Status line starting FIXED (not "FIXED IN SOURCE" or "FIXED IN CODE"), RETIRED, WONT FIX, NOT REPRODUCED or CLOSED. Installed = the bug number in a commit message reachable from f7f7d551 or e6d597c0 (slash lists and short ranges such as "BUG-652..655" expanded), plus the 49 named-elsewhere listed in section A. Built = the number in a commit on any other remote branch, in an open PR title, or a Status saying drafted or built. Everything else = no fix. My parse gives 503 / 255 / 236 / 43 for BUG-001 to BUG-1087 against the recount's 498 / 238 / 258 / 43; the differences come from the expanded number lists and from PRs opened since 02:00.
2. **Routes A1 to A4 and the case groups are my reading** of each entry's heading, area line, status and (for about 250) the full text. They are a sort, not a proof: a case writer may move a bug between cases or routes. Window-driven checks whose result is a value the runner reads by control text (the Inspector type, a schedule cell) I put in A1; anything about how it looks, in A2.
3. **Section C is my judgement of severity times use.** The carpark severity words were used as written; where none was given I judged from the symptom. Draft-PR search: bug number in PR titles and bodies, bug number in branch names, and the audit code (RD, T, F- and FB codes) in PR titles and bodies.
4. **Not checked:** I did not open any code to confirm a fix, run AutoCAD or the runner, or read every PR body in full. "Installed" stays an upper limit. I did not verify FIX_BRIEFS' 35 hunt-label matches one by one (ten spot checks only). The 22 non-briefed pilot bugs in FIX_BRIEFS are not listed there by number, so I could not reconcile them one for one. Unknown: the colleague's AutoCAD year, and whether #1286 covers BUG-587.

---

## Refresh Fri 30 Oct 2026 (CE 01 job q1)

Written by a read-only headless job for CE 01 (Fri 30 Oct 2026, Melbourne). Nothing was built, run, installed, committed or pushed. `BUG_CARPARK.md` was only read (file time 12:13 on 30 Oct, 1,205 numbered entries). This section is the only thing written; everything above it is unchanged. Tim's scope ruling of 30 Oct: every entry in the carpark, not only the 24 Oct 1,170.

### FOR TIM (reads on its own)

1. **The answer:** the 60 "pilot-critical, no fix" bugs of 24 Oct are almost all in hand now. Only 1 of the 60 (BUG-1173, the colleague pack backup step) has no draft and no build number. The rest of the carpark still has 134 bugs a builder can start today without waiting for you (61 Civil or Manager, 73 Structural).
2. **The 60 pilot-critical bugs, where they stand today:**
   1. **41** have a draft fix (a draft PR found by bug number).
   2. **3** have a draft under another name: BUG-1052 and BUG-1053 (#1716, #1727, on HOLD) and BUG-540 (#1192, which review rejected, so it needs rework).
   3. **6** have a build number but no draft yet: BUG-587, 648, 525, 866, 903, 907.
   4. **1** (BUG-865) has a Status line that says a fix exists; I did not verify it.
   5. **8** are held for a ruling or a fact, not code: BUG-685 and BUG-1148 need your word; BUG-855, 1166, 1169, 1170, 1209, 1210 need a fact (Max's AutoCAD year, his folders, a robot run).
   6. **1** has nothing: BUG-1173.
3. **The 35 newest bugs (BUG-1222 to BUG-1256):**
   1. **2** are finished (BUG-1222 and BUG-1225, you confirmed both on 3.0.85).
   2. **13** already have a build number or draft fix.
   3. **20** are new to the queue. **9 of the 35 are pilot-critical:** BUG-1227 (a copy landing on a pit steals its pipes), 1228 (DP takes 30 seconds), 1229 (grade shown flatter than you chose), 1233 (the window changes your grade choice without telling you), 1240 (Inspector says Unknown until you run CDSYNC), 1246 (a copied downpipe keeps the same tag), 1247 (Updates and Rollback opens the company-wide dashboard), 1251 (CDCHECK counts false unresolved joins), 1255 (Excel export fails on AutoCAD 2027).
4. **Four new questions only you can answer** (I have not asked you; CE 04 should batch them):
   1. **BUG-1236:** should the front overflow block say FO (your view) or keep the card's shared OF symbol?
   2. **BUG-1243:** what exactly did CE Blocks do wrong? Nothing is recorded, so no builder can start.
   3. **BUG-1245:** should Move + Rotate and Copy + Rotate work on a raingarden? Today they refuse it with a code word.
   4. **BUG-1224 (Structural):** should "Apply CE Standard Layers" leave locked and frozen layers alone and name them? I recommend yes.
   BUG-1252 (hand-placed labels) is already your Monday question 19.
5. **The build queue for the always-on builder:** 246 entries, ordered pilot-critical first, then wrong-answer risk, then the rest. 134 are ready to build (61 Civil or Manager, 73 Structural), 80 wait for a word or a fact, 28 are not real faults or duplicates, 4 may touch protected shared files. The first 40 are listed in full below.
6. **Your own mistakes to know about (mine, not yours):** one `git fetch` ran in the code repository (it only refreshes the list of remote branches, no files change). I could not read which build is installed right now, because the rules say not to touch your bundles; the newest I can prove installed is Civil 3.0.85.
7. **What you need to do:** nothing.

---

### How I did it, and the words used

1. **Sources read:** `C:\TimOS\RULES.md`, `areas\CE_SESSIONS_MAP_29OCT.md` (standing rules), the whole of this file, `areas\release-v3-colleagues-PILOT_NOFIX_TRIAGE_29OCT.md`, `areas\CARPARK_RETEST_TRIAGE_29OCT.md` (first 80 lines), `areas\release-v3-colleagues-BUILD_REGISTER.md` (all 159 lines), every heading and Status line of `BUG_CARPARK.md`, and the full text of BUG-1222 to BUG-1256.
2. **Open PRs read:** `gh pr list --state open --limit 3000` (1,464 open, 1,453 of them drafts; 1,327 on 24 Oct). I searched title, branch name and body for each BUG number. The task's own command used `--limit 500`, which only returns the newest 500, so I used 3,000 to be complete.
3. **Classes (as in the 24 Oct file):** BUILD-NOW = a safe fix needs no word from Tim; BUILD-ON-RECOMMENDED = build a draft on the recommended answer, Tim's word replaces it before it ships; NEEDS-TIM; FACTS = a fact or a look first, not code; PROTECTED = needs a shared or protected file; NOT-REAL or DUPLICATE.
4. **Acceptance routes (as on 24 Oct):** A1 the runner reads a value, a command-line line, a CE log line, a count or a file; A2 Codex must look (window, label position, picture); A3 Tim's word; A4 real job data or another PC.
5. **Pilot-critical** = a wrong answer on a council drawing, data loss, or a day-one colleague problem.

### TASK 1. The 35 entries newer than the 24 Oct file (BUG-1222 to BUG-1256)

BUG-1221 does not exist in the carpark (the number was never used). Each entry below was read in full. "Cover" says what already exists.

1. **BUG-1222** (CDEDIT size-only Save sends the flow arrow back uphill). **Class:** DONE. **Route:** A1, passed. **Pilot-critical:** yes (wrong answer), now fixed. **Cover:** PR #1832, installed in C-75; Tim confirmed it by hand on 3.0.85; Claude-accepted.
2. **BUG-1223** (CDFW on an inspection opening says "record changed while you picked", places nothing). **Class:** NEEDS-TIM (place it or refuse it, your call). **Route:** A1 (case R36e) after A3. **Pilot-critical:** no. **Cover:** PR #1833 installed in C-75; Status still OPEN.
3. **BUG-1224** (Structural, Apply CE Standard Layers silently unlocks and thaws CE layers; breaks the native protection rule). **Class:** BUILD-ON-RECOMMENDED (the entry gives a default that Tim's answer replaces). **Route:** A1 (layer state read from the drawing), A2 for the status line. **Pilot-critical:** no (Structural stays on Tim's PC), but it breaks "never silently unlock". **Cover:** none. Files named: `Modules/Structural/Services/LayerService.cs`, `UI/LayerManagerWindow.xaml.cs`.
4. **BUG-1225** (DP or OF refused after a drawing was closed unsaved and another opened). **Class:** DONE. **Route:** A1, passed 6 of 6; Tim confirmed. **Pilot-critical:** yes (reopening a drawing), now fixed. **Cover:** PR #1830, installed in C-74. The leftover wish (DP is slow) is BUG-1228.
5. **BUG-1226** (New Pipe window has no "Recent levels" row). **Class:** built. **Route:** A2. **Pilot-critical:** no. **Cover:** B-006, draft PR #1839 (Tim: "yep bring back").
6. **BUG-1227** (ROTATE or SCALE Copy landing on the original pit steals its pipes; the original kept 1 of 5). **Class:** built as a draft. **Route:** A1. **Pilot-critical:** yes (links and pipe ends). **Cover:** B-049a, draft PR #1867, written but at the last register not built or tested.
7. **BUG-1228** (DP takes about 30 seconds; PIT also slow). **Class:** built (DP half). **Route:** A1 timing. **Pilot-critical:** yes (daily tool, day one). **Cover:** B-004, PR #1837, in C-76. The PIT half is B-031, not started.
8. **BUG-1229** (New Pipe shows 1 in 102 where you chose 1 in 100). **Class:** built. **Route:** A1. **Pilot-critical:** yes (wrong answer). **Cover:** B-005, PR #1838, for C-77.
9. **BUG-1230** (plan preview does not show what the pipe will become). **Class:** NEEDS-TIM (Tim put it ON HOLD for the whole-functionality review). **Route:** A2. **Pilot-critical:** no. **Cover:** slice B-043e of the New Pipe declutter (no PR yet).
10. **BUG-1231** (EXPLODE, ERASE or COPY of a pit prints eight repeated "Pit schedule cell for C1 not updated" lines). **Class:** built plan. **Route:** A1 (count the lines). **Pilot-critical:** no (noise). **Cover:** B-049b, queued after B-049a.
11. **BUG-1232** (label tidy after MOVE treats the Drawing Border block as a clash; suspected). **Class:** FACTS (confirm by robot or hand first). **Route:** A1 (CE log line). **Pilot-critical:** no. **Cover:** B-032, not started.
12. **BUG-1233** (New Pipe or Edit Pipe silently switches Standard to Set my own). **Class:** BUILD-NOW. **Route:** A1 (grade box read by control text). **Pilot-critical:** yes (the window changes your choice; deceiving, Tim's word). **Cover:** B-041, no PR yet; same file as #1838.
13. **BUG-1234** (two new pipes ending at a pit: IL texts sit on the pit symbol, flow arrow runs through the label). **Class:** FACTS (Tim suspects the after-MOVE tidy-up; place the same two pipes with it switched off and compare). **Route:** A2. **Pilot-critical:** no (a wrong look, not a wrong value). **Cover:** none; same files as BUG-1253 and BUG-1034.
14. **BUG-1235** (silting warning prints "Grade 1:200 is shallower than minimum 1:200"). **Class:** BUILD-NOW (show a decimal when the two figures would print the same). **Route:** A1 (command line). **Pilot-critical:** no. **Cover:** none.
15. **BUG-1236** (FO places a block whose symbol text says OF). **Class:** NEEDS-TIM (the daily card D08 says the same symbol on purpose). **Route:** A3, then A2. **Pilot-critical:** no. **Cover:** none.
16. **BUG-1237** (CDRENUMBER stops with "No pit discharges outside the network" and no hint). **Class:** BUILD-NOW for the wording; the "pick the outlet pit" question is a bigger item. **Route:** A1. **Pilot-critical:** no. **Cover:** none. File named: `Rules/PitRenumberNetworkBuilder.cs` lines 124 to 133.
17. **BUG-1238** (recent sizes, materials and inverts are not one-click buttons). **Class:** built. **Route:** A2. **Pilot-critical:** no. **Cover:** B-040 = B-043a, draft PR #1861.
18. **BUG-1239** (pipe text sits about 450 units off the pipe; Tim: "450 is wrong"). **Class:** NEEDS-TIM (the right small gap is a Settings value to agree). **Route:** A1 (measure the distance), then A3. **Pilot-critical:** no. **Cover:** slice B-043e (no PR yet).
19. **BUG-1240** (Inspector says "Unknown" on a pit after Save As; Tim says he must run CDSYNC after every reopen). **Class:** BUILD-NOW. **Route:** A1 (Inspector value read by control text). **Pilot-critical:** yes (day one, every reopen). **Cover:** none. Same family as BUG-1225 (fixed) and BUG-1251.
20. **BUG-1241** (CDCHECKDWG says P2 has no invert though two pipes with levels meet there). **Class:** FACTS (Tim's later screenshot shows 17.780 after a sync; same cause as BUG-1240 is likely, not proven). **Route:** A1. **Pilot-critical:** no. **Cover:** none.
21. **BUG-1242** (source tags on the plan show OF, FO, DP with no number; RG shows nothing). **Class:** BUILD-NOW (default the plan tag to show the number). **Route:** A1 (plan text read from the drawing). **Pilot-critical:** no. **Cover:** none; the same area as B-007, PR #1845 (RG label), so build after it.
22. **BUG-1243** (CE Blocks does not work the way Tim wanted). **Class:** NEEDS-TIM (what he wanted is not recorded anywhere; RULES 12.1). **Route:** A3. **Pilot-critical:** no. **Cover:** none.
23. **BUG-1244** (CE Manager Refresh prints only its own name). **Class:** BUILD-NOW (one plain result line). **Route:** A1 (command line). **Pilot-critical:** no. **Cover:** none; Manager files.
24. **BUG-1245** (Move + Rotate and Copy + Rotate refuse a raingarden with a code word). **Class:** NEEDS-TIM (should they work on a raingarden?) and PROTECTED (the native transform component `Shared.Transform.Native2027`). **Route:** A1 (command line). **Pilot-critical:** no. **Cover:** none.
25. **BUG-1246** (Copy + Rotate of a downpipe: the copy keeps the original's tag, two DP2). **Class:** BUILD-NOW (Tim ruled copied CE objects get new tags, questions chat item 80). **Route:** A1 (tag read in the Inspector). **Pilot-critical:** yes (duplicate tags on a schedule). **Cover:** none; same copy code as B-049a and B-009.
26. **BUG-1247** (Updates and Rollback opens the company-wide Administrator Dashboard for a drafter; Tim: failed). **Class:** BUILD-NOW (open the user's own update and rollback screen). **Route:** A2 (window). **Pilot-critical:** yes (day-one colleague, Promote to All within reach). **Cover:** none; Manager files shared with B-047 and B-050.
27. **BUG-1248** (Survey Intake review is written in survey-software words). **Class:** BUILD-NOW (plain-words wording, details behind a fold). **Route:** A2. **Pilot-critical:** no. **Cover:** none.
28. **BUG-1249** (Inspector On plan tab says the pit label is "bottom right" when it is above). **Class:** BUILD-NOW; ask Tim which row he meant first (the Label position row is the wrong one on the screenshots). **Route:** A1 (control text). **Pilot-critical:** no (the Inspector already says recorded values may differ). **Cover:** none.
29. **BUG-1250** (double-click on a downpipe leaves one stray "Unknown command" line). **Class:** BUILD-NOW. **Route:** A1 (add "not contains Unknown command" to case R09s). **Pilot-critical:** no. **Cover:** none; same double-click redirect as B-001 (#1834) and B-014 (#1862).
30. **BUG-1251** (CDCHECK first on a reopened drawing shows 44 false Unresolved joins instead of 4). **Class:** built. **Route:** A1 (R21 is the expect-fail proof; N38 and C38 ready). **Pilot-critical:** yes (wrong answer from a QA check). **Cover:** B-055, draft PR #1866.
31. **BUG-1252** (a hand-placed pipe label shifts half the pit's move). **Class:** NEEDS-TIM (Monday question 19, keep or change the label rule). **Route:** A1, then A3. **Pilot-critical:** no. **Cover:** none; ON HOLD.
32. **BUG-1253** (after a 2 m pit move the upper-left IL text sits on the blue pipe strip). **Class:** BUILD-NOW (same root as BUG-1034, fix together). **Route:** A2 (Codex look G5). **Pilot-critical:** no. **Cover:** none; file `LinkService.TextClashTidyUp.cs`, same as #1875.
33. **BUG-1254** (CDCHECKDWG list shows a cut-off row at the bottom). **Class:** FACTS (CE 00's analysis says probably no fault; only Tim or a clean re-look closes it). **Route:** A2. **Pilot-critical:** no. **Cover:** none.
34. **BUG-1255** (Pit Schedule Export Excel fails on AutoCAD 2027: AutoCAD's own older ClosedXML wins). **Class:** built. **Route:** A1 for the file made, A2 for the window. **Pilot-critical:** yes (PILOT-BLOCKER). **Cover:** B-056, draft PR #1871, plus B-056b fixes.
35. **BUG-1256** (consultant drawing reader says "Import aborted at pre-flight gate"). **Class:** BUILD-NOW (plain cancelled sentence). **Route:** A1 (command line). **Pilot-critical:** no. **Cover:** none.

**Task 1 totals:**

1. **Cover:** 2 DONE (1222, 1225); 13 already have a B number or a draft (1223, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1238, 1239, 1251, 1255); 20 are new to the queue (1224, 1234, 1235, 1236, 1237, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1252, 1253, 1254, 1256).
2. **Class of the 20 new:** BUILD-NOW 12 (1235, 1237, 1240, 1242, 1244, 1246, 1247, 1248, 1249, 1250, 1253, 1256), BUILD-ON-RECOMMENDED 1 (1224), NEEDS-TIM 4 (1236, 1243, 1245 also PROTECTED, 1252), FACTS 3 (1234, 1241, 1254). None is NOT-REAL or a duplicate; BUG-1241 and BUG-1251 are relatives of BUG-1240, not copies.
3. **Route (primary, all 35):** A1 25, A2 8 (1226, 1230, 1234, 1238, 1247, 1248, 1253, 1254), A3 2 (1236, 1243), A4 0. A3 is also needed for 1223, 1224, 1239, 1245 and 1252.
4. **Pilot-critical (9 open):** 1227, 1228, 1229, 1233, 1240, 1246, 1247, 1251, 1255. Only BUG-1240, 1246 and 1247 have no draft; they are items 2, 1 and 4 of the queue below.

### TASK 2. Recount of the whole file by Status line (re-read 30 Oct 2026, file time 12:13)

**Entries:** 1,205 numbered (BUG-001 to BUG-1256 with gaps; the 24 Oct file had 1,170, so 35 are new). One more heading has no number (`BUG-CDCHECKIGNORE-UNDO-C60`, the renumbered second BUG-866); I did not count it.

1. **By what each Status line says (my rules; every entry counted once; the six figures add to 1,205):**
   1. **Closed: 47.** Status begins FIXED (not "FIXED IN SOURCE" or "FIXED IN CODE"), RETIRED, WON'T FIX, NOT REPRODUCED or CLOSED. On 24 Oct this was 43, so **+4**. Of the 47, 25 say Claude-accepted or Codex-accepted.
   2. **Tim-confirmed: 3** (BUG-665, 1222, 1225). Counted apart from closed because their Status line starts TIM-CONFIRMED and keeps an OPEN note.
   3. **In progress: 46.** CE 02's 29 Oct list of these says 47; I could not account for the one-entry difference.
   4. **Status says a fix is installed: 345.**
   5. **Status says built, drafted, coded or fixed in source: 72.**
   6. **Status says nothing about a fix: 692.** 53 of them have no Status line at all (BUG-176, 177, 376 to 378, 381 to 384, 386 to 389, 393, 394, 397 to 403, 405 to 424, 454, 459, 460, 466, 469, 560, 562, 565, 566, 588, 589).
2. **By bug number in commits, open PRs and the register (the 24 Oct method; applied to the 1,155 entries that are not closed or Tim-confirmed):**
   1. **In the installed line:** 532 numbers appear in commits reachable from `origin/claude/rel-20261026z` (Civil 3.0.85, the newest build I can prove is installed: C-75, 29 Oct 00:21 per CE_SESSIONS_MAP).
   2. **Only on the newer C-77 line** (`origin/claude/rel-20261030a`): 13. Whether C-77 is installed is Unknown (I did not read the bundle).
   3. **Only on other branches:** 279. **Only in an open PR title or branch:** 4. **Only in the build register:** 19.
   4. **Nowhere:** 308. This includes about 49 fixes installed under a hunt or audit label (found by FIX_BRIEFS on 23 Oct), so the real no-fix count is lower.
3. **How it differs from the 24 Oct counts (43 closed, 552 installed, 242 built not installed, 333 no fix):**
   1. **Closed 43 to 47.** Real movement: the Claude-accepted and Codex-accepted bugs.
   2. **Installed 552:** my 532 plus 13 is about 545, close to 552, but the two methods are not like for like. More trains have been installed since 24 Oct, which should push the figure up; my method cannot see the 49 label-named fixes, which pulls it down.
   3. **Built not installed 242:** my 315 (279 + 13 + 4 + 19) is an upper limit. A number named in a commit may be a test, a "related" mention or half a fix.
   4. **No fix 333:** 308 by number. A cleaner view is the queue below: of the 373 older entries in the 24 Oct no-fix lists, **153 now have a draft PR, a B number, a fixed or built Status or a commit** (90 by PR title or branch, 19 in the register, 29 by Status, 29 closed, in progress or Tim-confirmed by Status, 1 by a commit since 24 Oct), leaving 220. Add the 20 new bugs that need a queue place and the 9 register-only held items (below) and the queue is 246 entries after removing 3 whose drafts sit under audit-code names.
   5. **Open PRs:** 1,464 open (1,453 drafts), up from 1,327. Bug numbers appear in 726 PR titles or branches and in 89 more PR bodies only.
4. **Could verify:** the carpark text and Status lines, the live open PR list, the build register, the commit messages in the local clone.
5. **Could not verify:** which build is installed today; that any draft actually fixes its bug; the 49 label-named fixes one by one; PRs that name only an audit code (for example #1720); Status lines, which lag (345 say installed against about 545 by commits).

### TASK 3. The ordered build queue for an always-on builder

**What is in it:** every carpark entry with no draft PR, no B number and no installed or built fix that I could find. **246 entries:** 134 ready to build (BUILD-NOW 131, BUILD-ON-RECOMMENDED 3: BUG-1124, 1125, 1224), 30 FACTS, 50 NEEDS-TIM, 4 PROTECTED?, 28 NOT-REAL or DUPLICATE. Of the 134 ready, **61 are Civil or Manager and 73 are Structural.** Structural stays on Tim's PC for the pilot, so within each tier its groups come after the Civil and Manager groups.

**Order:** tier 1 pilot-critical (4), tier 2 wrong-answer or data-loss risk (16: 8 Civil or Manager, 8 Structural), tier 3 the rest (114). Inside a tier the entries are grouped by tool or area so two builders never edit the same file. The groups are my keyword reading of each entry; the exact file is Unknown until a builder reads the code, except where the entry itself names a file (shown).

**Groups:**

1. **C1** Pit Schedule (window and drawn schedule).
2. **C2** New Pipe and Edit Pipe windows and their save path.
3. **C3** Sources and drains: DP, OF, FO, RG, floor waste, AG and perimeter drains.
4. **C4** Labels, tidy-up, MOVE, COPY, link repair, Undo, check commands.
5. **C5** Design numbers: CDDESIGN, CDCALC, CDRULES, councils, cover, grades.
6. **C6** Survey, long section, imports, Xrefs, export.
7. **C7** Project record on open (Inspector, Save As, reopen).
8. **M1** Manager, install, update, colleague pack. **H1** Help pages and message wording.
9. **S1** Structural footings, members, tagging. **S2** Structural schedules, dimensions, text, sections, levels. **S3** Structural settings, layers, sheets.

**One builder at a time on each of these file sets** (conflicts with drafts that already exist; the builder waits for or stacks on the named PR):

1. **Tidy-up files** (`LinkService.TextClashTidyUp.cs`, `TidyLabelsCommand.cs`, `SegmentAnalysis.cs`): BUG-873, 890, 891, 1034, 1161, 1253 (and held 1252). Existing: B-025 (#1875) and B-025b, B-032. Build after B-025b.
2. **Edit Pipe save path** (`Update.cs`, `Persistence.cs`, `PipeEditCommand.cs`): BUG-658, 1157, 1164, and BUG-1235 (grade wording). Existing: B-005 (#1838), B-041, B-043. After #1838.
3. **Project record on open** (BUG-1240, 1249, 1141): one builder, after B-055 (#1866); BUG-1141 is a sibling of BUG-1142 (PR #1752), check that PR first.
4. **Design and sizing code** (`AutoDesignService.cs`, `MaterialVelocityLimits.cs`, cover and grade checks): BUG-080, 1092, 1093, 1144, 1152, 1153, 1156, 1158. Existing: B-017 (#1852), B-018 (#1872), B-019, B-020 (#1863), B-022, B-026, B-029 (#1874). After those merge on the C-78 line.
5. **Sources and copy code:** BUG-1246 after B-049a (#1867) and B-009; BUG-1242 after B-007 (#1845); BUG-1250 after B-001 (#1834) and B-014 (#1862).
6. **AG and perimeter drains** (`AgiCommand.cs`): BUG-1054 after the drafts #1716 and #1727 (BUG-1052).
7. **Manager files:** BUG-1173, 1247, 1244, 581, 1070, 1172, 1176, 1211, 1214, 775, 958, 959. Existing: B-003 (#1836), B-047, B-050 (#1860). One Manager builder, after B-047.
8. **Structural:** one builder per group S1, S2, S3, on the Structural S-trains.

#### The first 40 in full

1. **BUG-1246 (C3, tier 1, BUILD-NOW).** Copy + Rotate of a downpipe leaves the copy with the original's tag (two DP2). Area: copy clean-up for downpipes; file Unknown. After #1867 and B-009. Tim ruled copied CE objects get new tags.
2. **BUG-1240 (C7, tier 1, BUILD-NOW).** Inspector says "Unknown" on a pit until CDSYNC or the Pit Schedule has been run; Tim runs CDSYNC after every reopen. Area: attaching the drawing's record on open and after Save As. Same family as BUG-1225 and BUG-1251.
3. **BUG-1173 (M1, tier 1, BUILD-NOW).** The colleague pack's backup step saves only 2 of the CE settings folders. Files named: `CeAdminStorageService.cs`, `CeSuiteManagerMenuService.cs`. Whether this is code or pack wording: Unknown. The only one of the 24 Oct pilot-critical 60 with nothing at all.
4. **BUG-1247 (M1, tier 1, BUILD-NOW).** "Updates and Rollback" opens the company-wide Administrator Dashboard (Approve, Canary, Promote to All) for a drafter. It should open the drafter's own update and rollback screen. Manager window; needs a Codex look.
5. **BUG-873 (C4, tier 2, BUILD-NOW).** Tidy labels: answering No or pressing Esc can still leave the drawing changed. Files named: `TidyLabelsCommand.cs`, `CeCommandBase.cs`. A PR body names it (#1650): check cover.
6. **BUG-1253 (C4, tier 2, BUILD-NOW).** After moving a pit 2 m, its upper-left invert text sits on the blue pipe strip. File: `LinkService.TextClashTidyUp.cs`. Fix together with BUG-1034. Needs a Codex look.
7. **BUG-1141 (C4, tier 2, BUILD-NOW).** One unreadable pit record stops CE remembering any pit's links after open or Undo. Files named: `Persistence.cs`, `Cache.cs`. Data-loss family of BUG-1142.
8. **BUG-1112 (C5, tier 2, BUILD-NOW).** The WSUD export writes a sample site (1,000 m2 site, 200 and 700 m2 impervious, 630 mm rain) into the computations package as if it were the job's figures. Unknown stays Unknown: print nothing or say "not entered".
9. **BUG-1093 (C5, tier 2, BUILD-NOW).** The cover check is skipped when a pit lid is exactly RL 0.000 (a low coastal job gets no cover check). Same "zero means unknown" family as BUG-1019.
10. **BUG-1092 (C5, tier 2, BUILD-NOW).** A pipe up to 5 mm uphill is reported "essentially flat", not "flows uphill".
11. **BUG-1156 (C5, tier 2, BUILD-NOW).** An older CE wipes newer agreed-design answers from the Design draft. After B-029 (#1874), which edits the same window.
12. **BUG-1249 (C7, tier 2, BUILD-NOW).** Inspector On plan tab says the pit label is "bottom right" when it is drawn above. Ask Tim which row he meant first; the Label position row is the wrong one on his screenshots.
13. **BUG-467 (S1, tier 2, BUILD-NOW).** Structural: BT1, R1 (Point option) and FPFC put things in the wrong place in a rotated UCS. Files: `BracingCommands.cs`, `BracingService.cs`.
14. **BUG-1199 (S1, tier 2, BUILD-NOW).** Structural keeps and later re-saves footing sizes that Undo removed. Files: `CeTextService.cs`, `FstMemoryService.cs`.
15. **BUG-625 (S2, tier 2, BUILD-NOW).** Structural: Level Update overwrites ordinary notes without recognising a CE level mark. File: `LevelMarkCommands.cs`.
16. **BUG-1136 (S1, tier 2, BUILD-NOW).** Structural: a damaged footing register is read as empty, then saved over by the next footing command (data loss). Files: `FoundationRegistryService.cs`, `FoundationService.cs`.
17. **BUG-1183 (S2, tier 2, BUILD-NOW).** Structural: rearranging pier schedule rows can resize the wrong piers. Files: `ScheduleRowLink.cs`, `ScheduleService.cs`.
18. **BUG-1184 (S1, tier 2, BUILD-NOW).** Structural: separate bearer tagging runs give different sizes the same BR1 or SPR1 mark. Files: `TimberSubfloorService.cs`, `MemberMarkEngine.cs`.
19. **BUG-495 (S3, tier 2, BUILD-NOW).** Structural: Publish Issue (CESHEETS) fault rated HIGH, a colleague release gate candidate. Files: `CeSheetsWindow.xaml`, `CeSheetsIssueService.cs`.
20. **BUG-529 (S1, tier 2, BUILD-NOW).** Structural: three hard blocks that break Tim's R-27 (warn and carry on). Files: `FoundationService.cs`, `RebarCommands.cs`.
21. **BUG-1197 (C1, tier 3, BUILD-NOW).** Updating one pit schedule can change another schedule's depth heading through a shared block definition (an older copy gets "PIT DEPTH (m)" over its old figures). Files: `Schedule.cs`, `ScheduleLinkService.cs`.
22. **BUG-658 (C2, tier 3, BUILD-NOW).** Edit Pipe's cascade prints "Updated N pipes" even if the save is then refused (for example a locked label layer). File: `Update.cs`. Low.
23. **BUG-1157 (C2, tier 3, BUILD-NOW).** Edit Pipe stores the level in a separate write that fails silently: the schedule shows the new IL but the pipe keeps the old level. Files: `Update.cs`, `Persistence.cs`.
24. **BUG-1164 (C2, tier 3, BUILD-NOW).** On a PC set to comma decimals, Edit Pipe stores levels as typed ("18,14") and later readers see 1814. Files: `PipeEditCommand.cs`, `Update.cs`.
25. **BUG-1235 (C2, tier 3, BUILD-NOW).** Silting warning prints "Grade 1:200 is shallower than minimum 1:200"; show a decimal when the figures would print the same. After #1838.
26. **BUG-1054 (C3, tier 3, BUILD-NOW).** An open AG or perimeter drain can lose its last point and close itself in a metre drawing. Files: `Plan.cs`, `AgiCommand.cs`. After #1716 and #1727.
27. **BUG-1242 (C3, tier 3, BUILD-NOW).** The tag beside DP, OF, FO and RG on the plan shows letters only; the number shows only in the Inspector. After #1845.
28. **BUG-1250 (C3, tier 3, BUILD-NOW).** Double-click on a downpipe leaves one stray "Unknown command" line with the click coordinates. After #1834 and #1862.
29. **BUG-890 (C4, tier 3, BUILD-NOW).** Tidy labels leader-out planning can move a callout onto a plain label while CE reports a clear spot (switch OFF). File: `TextClashTidyUp.cs`. A PR body names it (#1653): check cover.
30. **BUG-891 (C4, tier 3, BUILD-NOW).** Tidy labels checks a layout pipe's labels against model-space text, and its search margin does not grow with the leader-out distance. Files: `TidyLabelsCommand.cs`, `TextClashTidyUp.cs`. PR body #1653.
31. **BUG-1034 (C4, tier 3, BUILD-NOW).** Tidy labels Apply moves the IL text "in from the pipe end" onto its own pipe line. Same root as BUG-1253.
32. **BUG-1046 (C4, tier 3, BUILD-NOW).** CDPARTS and CDLABELSTYLE refuse to open on a layout sheet or during REFEDIT. Files: `DrawingSafetyService.cs`, `PartsCatalogueCommands.cs`. Native protection rule: change the message or the layout case, never the REFEDIT refusal, without Tim's look.
33. **BUG-1050 (C4, tier 3, BUILD-NOW).** The last custom label style cannot be deleted. Files: `LabelStyleDialogViewModel.cs`, `LabelStyleDialog.xaml`. Window: Codex look.
34. **BUG-1161 (C4, tier 3, BUILD-NOW).** Moving or flipping a pipe label forgets its kept wording (for example "APPROX."). Files: `SegmentAnalysis.cs`, `Split.cs`.
35. **BUG-1195 (C4, tier 3, BUILD-NOW).** CDTEXTSEG writes a UCS angle into a World-plane text. Files: `Arrows.cs`, `DrawingService.cs`.
36. **BUG-1237 (C4, tier 3, BUILD-NOW).** CDRENUMBER stops with "No pit discharges outside the network" and does not say what to draw. File: `PitRenumberNetworkBuilder.cs` lines 124 to 133.
37. **BUG-080 (C5, tier 3, BUILD-NOW).** A UPVC pipe sized in CDEDIT is held to a 3.0 m/s scour ceiling while auto-design sizes the same pipe to another ceiling. Files: `AutoDesignService.cs`, `MaterialVelocityLimits.cs`. After #1863 (B-020) and #1852 (B-017).
38. **BUG-806 (C5, tier 3, BUILD-NOW).** Orifice detail mapper takes baffle head from the outlet invert and rounds the orifice up. Latent: no live caller yet. File: `OrificeDetailFieldMap.cs`. Low value.
39. **BUG-1033 (C5, tier 3, BUILD-NOW).** CDCALC Pump System tab is read-only but shows no read-only banner. File: `CalculationsV2Dialog.xaml`. Window: Codex look.
40. **BUG-1071 (C5, tier 3, BUILD-NOW).** CDCHECKIGNORE and CDRULEBOOK say "Ignored" or "set" when the save was skipped, so nothing was stored.

#### Items 41 to 134 (ready to build), as BUG numbers by group, all tier 3

1. **C5 design numbers (7):** 1144, 1152, 1153, 1158, 1212, 1213, 1217. BUG-1212 and BUG-1213 are AutoCAD 2022 to 2024 only.
2. **C6 survey, long section, imports, export (9):** 1248, 804, 898, 900, 962, 1155, 1163, 1175, 1256. BUG-962 has a PR body that names it (#1690, #1691): check cover. So do BUG-1155 (#1816).
3. **H1 Help pages and wording (3):** 822, 1218, 1220.
4. **M1 Manager and install (10):** 581, 775, 958, 959, 1070, 1172, 1176, 1211, 1214, 1244. BUG-958 and 959 have a PR body that names them (#1690, #1691). BUG-1214 is AutoCAD 2022 to 2024 only.
5. **S1 Structural footings and members (14):** 202, 300, 469, 474, 578, 613, 616, 1123, 1139, 1146, 1147, 1159, 1162, 1204.
6. **S2 Structural schedules, dimensions, text, sections, levels (33):** 304, 451, 472, 480, 579, 611, 615, 623, 626, 627, 630, 631, 634, 640, 749, 819, 1084, 1121, 1122, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1154, 1185, 1193, 1200. BUG-1124 and 1125 are BUILD-ON-RECOMMENDED. BUG-611, 819 and 1084 have a PR body that names them: check cover.
7. **S3 Structural settings, layers, sheets (18):** 383, 399, 409, 411, 470, 473, 493, 526, 533, 535, 536, 537, 1134, 1186, 1187, 1203, 1219, 1224. BUG-1224 is BUILD-ON-RECOMMENDED. BUG-533, 535 and 536 have a PR body that names them (#1063, #1154): check cover.

**Check the Structural lists before building:** the 24 Oct file called the old Structural entries (BUG-202 to BUG-1219) the "park list" because Structural stays on Tim's PC for the pilot and S-44 was already 37 bugs deep. Tim's 29 Oct rule says any builder can build any item, so I queued them, last in each tier. The Structural file groups are keyword guesses, not file lists.

#### Not ready to build (never marked BUILD-NOW or BUILD-ON-RECOMMENDED)

1. **NEEDS-TIM (50):** 3, 54, 56, 95, 213, 222, 245, 249, 311, 338, 397, 419, 431, 466, 475, 483, 492, 538, 539, 553, 554, 641, 685, 765, 883, 888, 908, 909, 910, 1056, 1057, 1058, 1059, 1060, 1094, 1100, 1104, 1105, 1109, 1114, 1116, 1117, 1119, 1120, 1148, 1160, 1236, 1243, 1245, 1252. BUG-685 and BUG-1148 are pilot-critical (QUESTIONS item 21 h and i).
2. **FACTS (30):** 16, 17, 22, 23, 24, 49, 206, 229, 235, 310, 319, 320, 340, 343, 410, 415, 436, 595, 855, 865, 1118, 1166, 1169, 1170, 1207, 1209, 1210, 1234, 1241, 1254. BUG-855, 865, 1166, 1169, 1170, 1209 and 1210 are the pilot-critical facts (a robot run, or Max's folders, Structural, Manager version and AutoCAD year). BUG-16, 24, 49, 229, 310, 319, 340, 343, 415 and 436 are old (May to early October) and need a re-test on a current build before any brief.
3. **PROTECTED? (4):** 494, 528, 1205, 1208. The entry text names CE_SHARED; I did not check that the fix really needs it.
4. **NOT-REAL or DUPLICATE (28):** test tools, test PC or evidence records (the 24 Oct "close candidate" group): 7, 240, 295, 307, 326, 345, 354, 361, 371, 374, 390, 391, 392, 395, 402, 404, 412, 421, 444, 455, 562, 567, 568, 569, 639. Plus **BUG-564** (same Esc fault family as BUG-469), **BUG-821** (works as designed, FIX_BRIEFS 23 Oct) and **BUG-1177** (the same weekly time export as BUG-1202, which has PR #1776). Nothing here is closed; that is Tim's call (D6).
5. **Draft exists but needs rework (not queued, because a draft PR exists):** BUG-540 (#1192, rejected in review B3), BUG-1052 and BUG-1053 (#1716 on HOLD and #1727).
6. **Fix installed but still failing on record (not queued, because an installed fix exists; a builder is needed):** BUG-027 (the label still says MIN), 073 (New Pipe preview blank), 173 (New Pit window has large empty areas), 396, 430, 642, 788, 861 (REDO lost after a pick; cause not in CE's own code on the evidence so far).

#### What I did not check

1. **No code was read, nothing built, run or opened.** File names are the ones the carpark entries themselves name; most are from entries filed against older builds, so a builder confirms each on the newest line first.
2. **Which build is installed now.** I did not read the bundle, so "installed" means reachable from `rel-20261026z` (Civil 3.0.85). C-76 and C-77 are Unknown.
3. **Classes of the older entries are my reading, not a full re-read.** For the 35 new entries I read every line. For the older queue entries I used the 24 Oct file's own groups (park list items 2, 3, 4 and 9), the entry's own words ("Tim's call", "needs your word", "recommended", "unproven") and the first 900 characters of each entry. Some BUILD-NOW marks may really need Tim's word, and some NEEDS-TIM marks may be ready to build on a recommendation (only 3 entries were marked BUILD-ON-RECOMMENDED, which is low).
4. **PRs that name only an audit code** (not a BUG number) could not be matched, so a few queue entries may already have a draft (for example under #1534, #1720 or #1810). BUG-1102 and BUG-1110 were excluded because #1810 and #1811 name them.
5. **PR bodies that mention a number** were not treated as cover (89 numbers); 33 queue entries are named in a PR body only and are flagged "check cover" in the lists above where I noticed them (BUG-16, 213, 245, 307, 320, 345, 483, 528, 533, 535, 536, 567 to 569, 611, 616, 641, 819, 873, 888, 890, 891, 958, 959, 962, 1056 to 1060, 1084, 1100, 1155).
6. **Sizes (S, M, L) are not given** for the queue items; the 24 Oct and 29 Oct files give them only for the pilot-critical set.
7. **Acceptance routes** are assigned for the 35 new entries only, not for the 246 queue entries.
8. **Carpark hygiene for CE 05** (I did not touch the file): a block of BUG-861 evidence (27 Oct) sits inside BUG-1224's text and another inside BUG-1225's; the heading `BUG-CDCHECKIGNORE-UNDO-C60` has no number; BUG-1221 is unused; 53 entries have no Status line.
9. **One `git fetch`** was run in `C:\Lisp Files\CE_ACAD_PLUGIN` to read current branch heads; no file in any working copy changed.
