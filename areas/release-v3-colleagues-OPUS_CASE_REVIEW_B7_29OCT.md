# Opus independent case review B7: the 7 batch-3 cases N23 to N29 on Civil 3.0.85 (Thu 29 Oct 2026)

Written Thu 29 Oct 2026, about 02:30 to 02:50 Melbourne (PC clock read with `date`), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE 7 BATCH-3 CASES N23 TO N29 ON CIVIL 3.0.85" (desk plan/03), standing in for Codex (at its weekly cap). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, settings, DESK_LOG.md or BUG_CARPARK.md edit. Files written: this report and seven `.review.txt` slips (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Shape: the B2, B6 and N27 reviews of 28 Oct.

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first: two small ones, no cost.** Two of my scratch look-ups used a file filter Windows does not understand and returned nothing. I noticed both and redid them the right way (about two minutes).
2. **Result:** all 7 robot checks are good tests. **3 now prove a whole everyday tool; 4 prove part of one.** Nothing failed and nothing was wrong in a case.
3. **Whole tools, which may now be written "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)":**
   1. **D02 pit catch:** a pipe ending 90 mm outside a 450 pit's opening joins the pit and is pulled to the inside wall; one ending 110 mm outside stays a free end.
   2. **D09 pit label and cover level:** the P8 label lands within 0.1 mm of where you click, on the right layer; the cover text reads exactly "CL 19.000"; one U removes all three.
   3. **"CDSYNC keeps the schedule":** after an Edit Pipe cascade with U and REDO, CDSYNC changes nothing in the Pit Schedule, character for character.
4. **Part of a tool only (write the part in the wording):**
   1. **D20 CDRENUMBER:** Yes renames the right two labels on the plan and leaves the others; No and U put those two back. Missing: proof that EVERY label is back after No and after U, and that X1 is left alone. Three lines to add (below the line), then two new runs.
   2. **D13 hand-placed label:** only with its switch ON. **Your own file has it OFF** (and Tidy labels OFF), so Max and the team do not get this today. Proven: Tidy labels leaves a text you moved by hand where you put it. Not proven: moving the pit 500 mm (the card's step 3).
   3. **D24 office layers:** your current layer stays the same after all five ways of ending PIT and CD. Not proven here: the layer of each new object (recorded only).
   4. **D21 Pit Schedule order:** a pit placed today slots in at its number (P7, P8, P9, P10, then C1). Not proven: the LPD, OG and CP groups (none in the test drawing).
5. **Bugs:** none of these 7 checks was written to prove a bug, and none found a fault. **No bug gains new evidence of being real.** BUG-698 (CDSYNC leaves the schedule alone) now also holds after a cascade on 3.0.85; it is already marked fixed.
6. **Effect on the count:** up to three more whole items (D02, D09 and "CDSYNC keeps the schedule"), all on Civil 3.0.85. I did not recount the 16; the desk does.
7. **What you need to do:** nothing.

---

### Counts and named tools (the desk's detail)

1. **Counts (one verdict per case):**
   1. **CLAUDE-ACCEPTED-READY, whole claim: 3.** N23 (D02), N25 (D09), N26 (named check "CDSYNC keeps the schedule", card C42).
   2. **PARTIAL, ready for the exact part named: 4.** N24 (D20), N27 (D13, switch ON only), N28 (D24), N29 (D21).
   3. **NEEDS STRONGER ASSERTION:** 0 as a main verdict. N24 needs three lines to become whole (The cases item 2).
   4. **NEEDS BROKEN VARIANT, NEEDS CODEX LOOK, NEEDS RUNS: 0** for what the cases claim. **FAIL = real fault in a case: 0.**
   5. **Review slips written: 7**, each naming its case's exact current SHA-256; the four partial ones name their part in the VERDICT line. Copies, byte for byte, in `areas\runner-reports\reviews\`. A copy of the runner's own gate function (`Get-CaseIndependentReview`, run offline) reads all 7 as ok and reads the twins N23_BROKEN, N24_BROKEN and N29_BROKEN as "no review", so no slip leaks onto a twin.
2. **Cards that may be written "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)":**
   1. **D02 (UX-PIT-02): whole** (N23 alone covers card assertions 1, 2 and 3). Previously part (N19, 50 / 150 mm, on 3.0.83 and 3.0.84).
   2. **D09 (UX-CPLAN-21): whole** (N25 alone covers assertions 1, 2 and 3). Previously part (N05, label position missing).
   3. **"CDSYNC keeps the schedule" (gap plan section 3 item 7, card C42): whole for C42 assertions 1 and 2 with the cascade preparation** (N26 alone). C42 assertion 3 is a record of the BUG-855 header count, not a pass/fail check; it is not recorded. R13 has no 3.0.85 runs and is not needed for C42.
   4. **D20: part** (N24): the plan-label Yes path and the two renumbered labels after No and U. N15's schedule half has no 3.0.85 runs (3.0.84 only) and builds are never combined.
   5. **D13: part, switch ON only** (N27): the Tidy labels half.
   6. **D24: part** (N28): assertion 1 whole (all five endings) and "nothing on 0 or on the current layer".
   7. **D21: part** (N29): assertions 1 and 2, and "P before C1" of assertion 3.
3. **Neighbour cases have no 3.0.85 runs:** N19, N15, N05, N06, N09 and R13 passed twice on 3.0.84 only (ledger rows aX1 to aX6, bX1 to bX6, 28 Oct). They do not add to any 3.0.85 claim above.

## Findings for the desk (RULES 6.2)

1. **Another job's settings guard was active while I worked.** At 02:37 Tim's `CD_Settings.json` hashed 96E3135F472..., not the pack's ACD64E79A33B, and `C:\ce_rc_scratch\settings_guard\20261029_023619_1_CD_Settings.json` (written 02:36, after the validation job ended at 02:25) holds ACD64E79A33B. So a guarded robot session started at 02:36. Not mine; I read the guard original for Tim's switch values and touched nothing.
2. **Tim's switches, read from the guard original (ACD64E79A33B):** `linking.pitCatchMarginMm` 100.0; `linking.tidyLabelsEnabled` and `linking.handPlacedLabelsStay` absent, so both OFF (default false). N27's acceptance is for the switch-ON setting only.
3. **Card D21 is wrong about the fixture:** it says "F-B1 ... has no P10, so the case places P8 to P10 itself". F-B1 already has P9 and P10 (N24's label read, N29's schedule). N29's one new pit P8 is the fair test. The card should be corrected at its next edit.
4. **Card D20's "DBMOD is unchanged" after No cannot be shown on this fixture:** DBMOD is already 1 when the copy opens (N15, N24). Either drop it from the card or give it a fixture that opens at 0.
5. **Card D13 step 3 still does not match the product** (the spec's finding 3, confirmed at 09126560): `HandPlacedLabelRule` is read only in `LinkService.TextClashTidyUp.cs`. Whether a pit move must keep a hand-placed label is a card question for Tim, not a robot check.
6. **N27's typed "Yes" is never asked** ("Will move 0", then "No CE label needs to move.", then `Unknown command "YES"`). Harmless to the proof; the title's "even when told Yes" is not exercised. Tidy at the next real edit of N27 (any edit changes the hash).
7. **N26's "11 / 49" is a fixture count, not a behaviour:** in `LinkCommands.cs` CDSYNC counts every pit block and pipe line in model space. It is guaranteed by the fixture (34BBE37C2EA4) and a cascade cannot change it. The real proof in N26 is the full schedule comparison.

## The cases

1. **N23: pit catch at the 100 mm line (D02). Verdict: CLAUDE-ACCEPTED-READY, whole. Hash 58FBD1B465E0.**
   1. **Runs:** PASS n3c3-s1 (00:39) and n3d3-s1 (01:42), separate AutoCAD starts, both civil 3.0.85+09126560, both on the final hash. Twin N23_BROKEN (B41A66C01A42) fails only `history has "Flow: Open end -> P8"` in n3c3: a real-action red (the same pipe 20 mm further out), the right reason.
   2. **Against the source:** `PitOutline.Touches` for a box pit is `u <= _maxU + margin` (inclusive), measured from the OPENING (X_WIDTH), and `TouchesExistingLink` (drawn extents) is not used for new ends. The opening's east edge is 150225, the reach ends at 150325 (which is also the drawn wall line). 150315 is inside, 150335 outside. The sentence is `PipeEndWallSnap.Words` with `Math.Round(MovedMm)`.
   3. **Against the card:** assertion 1 (near end: "-> P8", box x 150225 = Xe, the inside wall), assertion 2 (far end: "-> Open end", box x 150335 within 1 mm), assertion 3 ("Flow: " count 2). "No End is free line for the end at the pit" is pinned by the count of 3 (near start, far start, far end).
   4. **Boundary (question d):** the main case asserts both sides (90 caught, 110 free); the twin proves the catch check goes red 20 mm out. The exact 100 / 101 mm line is not pinned, and the card does not ask for it. The 110 mm free end also proves the drawn block no longer widens the catch (the drawn wall plus 100 would reach 150425).
   5. **Fixture values:** the 450 opening is the remembered New Pit size, not set by the case; another size makes the x checks fail, never pass. OSMODE was 5375 and set to 0 by v3 in both runs.
   6. **Strictness notes (not blocking):** `history count "Flow: Open end -> P8" = 1` reads the start of the token (it would also match "-> P80"); the wall sentence "of P8 (was 90 mm" pins the pit, and this drawing has no P80.
2. **N24: CDRENUMBER, the plan labels one by one (D20). Verdict: PARTIAL, ready for the part. Hash 323E733AB1AC.**
   1. **Runs:** PASS n3c4-s1 (00:48) and n3d4-s1 (01:49), both 3.0.85, final hash. Twin N24_BROKEN (F4B89D4BCC01), no U, fails only the same-block "P9 again" check in n3c4.
   2. **The label read is real:** `v3 ent-find` listed 11 blocks on STORMWATER PIT LABEL in both runs: C1 1090F6, X1 10933E, P1 1096B3, P2 10981A, P3 109E08, P6 10A18D, P7 10A56D, P5 10A68C, P4 10A7AB, P10 119F9A, P9 11A09A. After Yes both runs read 11A09A = P8 and 119F9A = P9, all others unchanged (X1 included).
   3. **The handle binding is proven by the twin (question e):** the patterns use `handle\W+([0-9A-F]{4,8})\W` and `\1`; every block's JSON has no `}` inside, so `[^}]*` keeps each match inside one block. In the twin, after Yes with no U, the old P10 block reads P9; a check without the handle binding would have passed on it. It failed, so the "same block" binding is real.
   4. **What the twin does NOT pin:** the "every label" part. The main case asserts after No only P9, P10 and "no P8"; after U only P9, P10 and "no P8"; after Yes 10 of the 11 labels (X1 is read but not asserted). Card D20 asks M0b = M0 and M2 = M0 (the whole map) and "C1, AGI, TG and WT tags untouched".
   5. **Lines to make D20 whole (add to ASSERT, then two new runs; I tested all three offline in PowerShell against the n3d4 text: the whole-map line matches the same read and refuses both the after-Yes read and a read with one label changed; the X1 line matches the after-Yes read and refuses a changed X1; not yet tested through the case parser):**
      1. `matches $jn "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"` (every label after No equals before)
      2. `matches $ju "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"` (every label after U equals before)
      3. `matches $jy "handle\W+([0-9A-F]{4,8})\W[^}]*PIT_LABEL=X1\W.*@@AFTER@@.*handle\W+\1\W[^}]*PIT_LABEL=X1\W"` (X1 untouched)
   6. **Not provable here:** DBMOD unchanged (finding 4), a TG mark (not in the fixture), the numbering rule (Tim's word).
3. **N25: pit label lands where you click (D09). Verdict: CLAUDE-ACCEPTED-READY, whole. Hash 05DD2856042C.**
   1. **Runs:** PASS n3c5-s1 (00:53) and n3d5-s1 (01:54), both 3.0.85, final hash. Twin N25_BROKEN (83BD8186D7EF) fails only `$ld <= 1` (4.9) in n3c5. The earlier BLOCKED n3a3 and the 3.0.84 passes are not counted.
   2. **0.1 mm is a real landing check (question f):** the label's insertion read 150000.088,-78500.000 in both runs; the driver mapped the target to pixel 2728,706 (exact 2727.50), so the 0.088 mm is half a pixel in a view of about 0.18 mm a pixel. The twin, clicked 5 mm lower, landed at -78504.92: the label follows the click. So the pass is not a fixed default position that happens to sit at the point.
   3. **The one text fix did not weaken anything:** only the cover click moved (30 mm to 10 mm below the label point). The cover point is not asserted, and if the label had taken the second click it would sit 10 mm off and fail.
   4. **Against the card:** assertion 1 (PIT_LABEL exactly P8 via `.P8.,`, layer STORMWATER PIT LABEL, insertion within 1 unit), 2 (cover text exactly "CL 19.000"), 3 (one U echoes PIT, no new object left). Route substitutions, all stated in the case: a click at high zoom for the typed label point, a click for the cover corner instead of Enter, snaps off.
   5. **Not covered (a Codex look, and not card assertions):** the cover corner and the look of the label and text.
4. **N26: CDSYNC keeps the schedule after a cascade (card C42). Verdict: CLAUDE-ACCEPTED-READY for the named check. Hash 2E6AC04D844F.**
   1. **Runs:** PASS n3c6-s1 (01:04) and n3d6-s1 (02:03), both 3.0.85, final hash. Twin N26_BROKEN (FACB359D32E4) fails only `equals $rows1 $rows0` in n3c6 (P3 erased between the reads, a real-action red).
   2. **The comparison covers the whole schedule:** `ui-cells` read 297 row and cell entries, 4806 characters, both times, with every pit row P1 to P7, P9, P10 and C1. The cascade is proven in place before CDSYNC (P3 at 17.50 / 17.45 asserted).
   3. **11 / 49 (question g):** guaranteed by the fixture, not an accident and not a behaviour (finding 7).
   4. **Strictness note (not blocking):** `contains $u1 "CDEDIT"` reads the start of a token; the P3 row values pin the cascade state, so it is harmless.
   5. **Not covered:** C42 assertion 3 (header count, BUG-855), U after CDSYNC.
5. **N27: hand-placed text left alone by Tidy labels (D13, switch ON). Verdict: PARTIAL, ready for the part. Hash D86FA0A8F939.**
   1. **Runs:** PASS n3c7-s2 (01:13) and n3d7-s1 (02:11), separate AutoCAD starts, both 3.0.85, final hash. Twin N27_BROKEN (4AEA9A01ACE2, switch false) in n3c7-s1 fails the count line and moves the text 275 mm: a real red, the switch is what keeps it.
   2. **Both runs printed** `[CE] Will move 0 · Placed by hand (left alone) 1 · No clear spot found 1`, then the unrelated "No clear spot found: pipe P3 -> P2 label", then `No CE label needs to move.`; hand move 5 mm, tidy move 0 mm.
   3. **The invert text is a fair stand-in for "the pipe label":** the mark is written for any pipe attachment moved on its own and read for every movable role (`TextClashTidyUp.cs` lines 244-313 at 09126560).
   4. **Part claim (question h):** switch ON only (Tim's file OFF, finding 2); the Tidy labels half of assertion 1 only. Missing: card step 3 (pit move, P2 = P1), profile A, the Yes path (finding 6).
   5. **Strictness note (not blocking):** "Placed by hand (left alone) 1" would also match "... 10"; only one text was moved by hand in this case.
6. **N28: current layer kept on every Esc path (D24). Verdict: PARTIAL, ready for the part. Hash C7EFA22D70C4.**
   1. **Runs:** PASS n3c8-s1 (01:22) and n3d8-s1 (02:18), both 3.0.85, final hash. Twin N28_BROKEN (249965280AC8) fails only `equals $cl4 "BLOCKS"` (it sets CLAYER to 0 itself): a planted red, accepted as for N06.
   2. **Each path really ended where claimed:** the CD Esc came at "Select point 3"; New Pit Cancel printed "PIT command cancelled."; object counts 1034 at the start and after both window Cancels; the placed pipe printed "Flow: P8 -> Open end".
   3. **Part claim (question h):** assertion 1 whole. Assertion 2 only "nothing on 0 or the current layer"; the per-object layers were recorded (STORMWATER PIT, STORMWATER PIPE, 25TEXT, 20TEXT, 20TEXT, ARROW) and are asserted only in N06, which has no 3.0.85 runs. Assertion 3 and "never recolour" are not built.
7. **N29: a new pit takes its number's place in the schedule (D21). Verdict: PARTIAL, ready for the part. Hash 87FAE114D808.**
   1. **Runs:** PASS n3c1-s1 (00:24) and n3d1-s1 (01:31), both 3.0.85, final hash. Twin N29_BROKEN (26D68459ECD6) fails only its "P10 then P8" pattern: a flipped expectation, accepted as for N09.
   2. **What the order proves:** a creation-order list would put P8 last (fails the first pattern and the lookahead); a text sort would put P10 before P2 (fails the first pattern). `Pit P1= ` cannot match `Pit P10= ` because of the "=".
   3. **Part claim (question h):** assertions 1 and 2, and "P before C1". Missing: the LPD, OG and CP groups (not in the drawing) and the P1A / SPS refinement (switch off; the card itself marks it NOT TESTED).

## Build, hash and run checks (read myself)

1. **Installed now (02:33):** Civil `3.0.85+09126560f98acc4fd6ca4be298d087307a89a259` in the Legacy, Modern and Net8 folders (files 28 Oct 23:41 to 23:46). Commit 09126560 is on `origin/claude/rel-20261026z` (its tip, "Version: Civil 3.0.85 / Manager 1.1.85 (C-75)"). All source reads were `git show` / `git grep` at that commit.
2. **Hashes now (SHA-256):** all 7 cases and all 7 twins equal the validation report's list and the `case_sha256` of every counted ledger row.
3. **Ledger (working copy at 02:35):** every N23 to N29 row on 3.0.85 is a PASS for the main case and a FAIL for its twin; no main-case FAIL on 3.0.85. The 3.0.84 rows (n3a1 to n3a6, n3a3b) are not counted.
4. **Sessions:** every counted pair is two different run calls, each its own AutoCAD start (each report says "1 AutoCAD session(s)", N27's says 2, one per setting). All 16 n3c and n3d reports name the same build.

## What I read

1. `C:\TimOS\RULES.md` in full with amendments; `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`.
2. The validation report and the B3 spec in full; the N27 review in full and the B6 and B2 reviews in part (method, N15 / N19 parts).
3. Cards D02, D09, D13, D20, D21, D24 (DAILY_TOOLS_TEST_CASES_2026-10-23.md) and C42 (TEST_CASES_DRAFT_22OCT.md); the R13, R16 and N19 review slips; `case_runner.ps1` lines 100-140.
4. All 7 case files and their twins (full text and a line-by-line comparison).
5. The run JSON of all 14 counted reports (every failing check of every twin, and the recorded values quoted above); ledger rows for N23 to N29 and the neighbour cases on 3.0.84 and 3.0.85.
6. Source at 09126560: `Rules/PitOutline.cs`, `Rules/PipeEndWallSnap.cs`, `Rules/HandPlacedLabelRule.cs`, `Services/LinkService.TextClashTidyUp.cs`, `Commands/LinkCommands.cs` (CDSYNC).
7. BUG_CARPARK.md (read only, grep for the tools concerned).

## What I did NOT check (RULES 5.9)

1. Nothing in AutoCAD and no picture was looked at.
2. The three N24 lines through the case parser (tested only as PowerShell regexes on the recorded text).
3. N30 (out of scope) and the CD_RecentValues.json question (the desk's).
4. Whether any renumbering, cascade or catch result is right as engineering: Tim's word.
5. Which robot job holds the settings guard started at 02:36 (finding 1).

## Files written

1. This report.
2. Seven review slips beside the cases in `C:\Lisp Files\_ACAD_DRIVER\cases\`: `N23_pit_catch_boundary_90_caught_110_free.review.txt`, `N24_cdrenumber_plan_labels_one_by_one.review.txt`, `N25_pit_label_lands_on_the_picked_point.review.txt`, `N26_cdsync_keeps_schedule_after_cascade.review.txt`, `N27_hand_placed_label_left_alone_by_tidy.review.txt`, `N28_current_layer_kept_on_every_esc_path.review.txt`, `N29_new_pit_takes_its_number_place_in_schedule.review.txt`. The same seven, byte for byte, in `areas\runner-reports\reviews\`.
3. Scratch on this PC only: `C:\ce-fx\opus_b7rev\` (`summ.ps1`, `rec.ps1`, `rx24.ps1`, `gatecheck.ps1`). Undo: delete the seven slips beside the cases and revert this commit.

## Summary (under 100 words)

All 7 batch-3 cases passed twice on Civil 3.0.85, on their final hashes, with twins failing for the right reason. Whole and ready: N23 (D02 pit catch at 90 / 110 mm), N25 (D09 label within 0.1 mm of the click) and N26 (CDSYNC keeps the schedule after a cascade). Ready for part: N24 (D20; three lines would make it whole), N27 (D13, switch ON only, Tim's file OFF), N28 (D24 current layer) and N29 (D21 order). No bug gains evidence of being real. Seven review slips written and copied to CE_PLAN.
