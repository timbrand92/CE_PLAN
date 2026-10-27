# Opus independent case review N27: the 11 new N cases (N01 to N09, N11, N12) on Civil 3.0.83 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026, about 04:51 to 05:20 Melbourne (PC clock), by the Team Opus job "INDEPENDENT CASE REVIEW OF THE 11 NEW N CASES ON CIVIL 3.0.83" (desk plan/03), standing in for Codex (at its weekly cap). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, settings, DESK_LOG.md or BUG_CARPARK.md edit. Files written: this report and nine `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Shape: the B5 review of 27 Oct.

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first: none that cost anything.** One look-up of the CE log ran too long and I let it go; I judged from the robot's run records instead (said below).
2. **Result:** all 11 robot checks passed twice on the installed Civil 3.0.83. **9 are ready to count; 2 are not yet.**
3. **Ready as whole tools (2):**
   1. **CDREBUILD warns and never saves (N01).**
   2. **EXPLODE a pit (N02):** one plain sentence, the pit leaves the schedule, U brings it back.
4. **Ready for part of their tool only (7):** pit label and cover level, office layers, Undo names, CDRENUMBER, Pit Schedule order, the cascade levels in the schedule, COPY of a pit.
5. **Not ready (2):**
   1. **OF and FO (N03):** the check only looks at the start of the tag ("OF", not "OF1"), and its deliberately wrong twin failed for the wrong reason (see item 7).
   2. **Downpipe and raingarden (N04):** held until item 7 is explained.
6. **Everyday tools you may now mark "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)", whole:**
   1. **D16 EXPLODE.**
   2. **D18 CE never saves** (N01 plus the older R04 check, both passing on 3.0.83).
   3. **D27 CDSYNC and CDREBUILD warn first** (N01 plus the older R13 check).
7. **Something new the robot's report missed: a downpipe and an overflow were refused.** In two of tonight's runs, after the first test drawing was closed without saving and a fresh copy opened in the same AutoCAD, DP and OF said: "The source landing could not be refreshed. Nothing will be placed here." A drafter could hit this after reopening a drawing. Nobody has looked at the cause yet. It needs a bug number.
8. **Nothing for you to decide or test.**

---

### Counts and the named tools (the desk's detail)

1. **Counts (one verdict per case):**
   1. **CLAUDE-ACCEPTED-READY, whole claim: 2.** N01, N02.
   2. **PARTIAL, ready for the exact part named: 7.** N05, N06, N07, N08, N09, N11, N12.
   3. **NEEDS STRONGER ASSERTION: 1.** N03 (and its twin needs one clean failing run).
   4. **NEEDS RUNS (held on a new finding): 1.** N04.
   5. **NEEDS BROKEN VARIANT: 0. NEEDS CODEX LOOK: 0 for what the cases claim** (the label position in N05 is left to Codex and not claimed). **FAIL = real fault in a case: 0.** One possible CE fault found outside the cases' own checks (finding 1 below).
   6. **Review files written: 9.** N01, N02, N05, N06, N07, N08, N09, N11, N12, each naming the exact current SHA-256; the seven partial ones name their part in the VERDICT line. None for N03 or N04. A copy of the gate's three checks passes for all nine.
2. **Named tools, which may now be written "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)" and for which part:**
   1. **D16 EXPLODE: whole** (N02). Not driven: the wording for a pit with no pipe (the card states it as a branch).
   2. **D18 CE never saves: whole** with R04 (PASS x83a3-s2 and x83b3-s2 on 3.0.83, review current at 443604166CC0, true red R04_SAVE_BROKEN) for PIT, CD, CDSYNC, CDRECOVERINVERTS and PITSCHEDULE, and N01 for CDREBUILD and its two no-save sentences.
   3. **D27 CDSYNC and CDREBUILD warn first: whole** with R13 (PASS x83a1-s1 and x83b1-s1 on 3.0.83, review current at BE176845E3D2) for the CDSYNC half and N01 for the CDREBUILD half (assertions 2 and 3).
   4. **D18 with R04 and D27 with R13** as above. R04 and R13 remain "part" on their own; the pair is whole.
   5. **D09 pit label and cover level: part.** Covered: one label reading P8 on STORMWATER PIT LABEL, one cover text reading exactly "CL 19.000" (no IL line), one U removes the pit, label and cover text. Missing: label position within 1 unit of the point (the mouse click landed 8.3 mm away) and the cover text corner: a Codex look.
   6. **D19 Undo names: part, switch-on only** (both switches are OFF in Tim's file, like R16). Covered: "Undid: point 3 of the pipe route.", Esc cancels with nothing drawn, U echoes PIT and MOVE. Missing: the U echo after a placed CD pipe (the card names CD), and the plain U echoes on Tim's own switches.
   7. **D20 CDRENUMBER: part.** Covered: outlet question, the list P9 -> P8 and P10 -> P9, the No and Yes sentences, the Pit Schedule follows (P8 in, P10 out), two U bring P10 back. Missing (exact lines in the case detail): proof that No changed nothing, full schedule equality after U, non-P marks untouched. The numbering rule itself is Tim's word.
   8. **D21 Pit Schedule order: part** (the basic number order, which is what Max gets with the switch off). Missing: group order beyond P and C1 (this drawing has no LPD, OG or CP pits) and the P1A/SPS refinement (switch off).
   9. **D15 COPY: part.** Covered: the "1 pit copied and numbered as new. Check levels: ..." sentence, one new pit and label reading P8, one U removes it, file unchanged. Missing: one line asserting the original label still reads P3 (it did in both runs).
   10. **D24 office layers: part, as already known.** Covered: current layer stays BLOCKS, nothing new on 0 or BLOCKS, pit on STORMWATER PIT, arrow on ARROW. Missing: "never recolour a layer" (not built), current layer after each Esc path, the layer-table record.
   11. **Edit Pipe cascade with U and REDO: part** (R11 texts plus N11 stored levels). Newly covered: the P3 and P2 schedule levels after U and REDO equal the cascade (17.50, 17.45, 17.33, 17.28) and every schedule cell returns after U. Still missing: the STUB to X1 warning, the Recalculate box body, which text belongs to which pipe.
   12. **D08 OF and FO: nothing yet.** **D07 downpipe and raingarden: nothing yet.**
3. **Bugs:** none newly FIXED. N04 names BUG-176 only in its PLAN_ITEM (no PROVES_BUGS line); it is held.

## Findings for the desk (RULES 6.2)

1. **New, possible CE fault (desk to file a BUG number; I may not edit BUG_CARPARK.md).**
   1. **What happened:** RUN-20261028-0231-C3.0.83-n27a3 (case N03_BROKEN) and RUN-20261028-0237-C3.0.83-n27a4 (case N04_BROKEN). Each twin was the second case in its AutoCAD session, on a fresh copy reopened with the runner's reopen-copy (the earlier case's unsaved work discarded). The first OF (n27a3) and the DP (n27a4) at 150000,-80000 printed "[CE] The source landing could not be refreshed. Nothing will be placed here. Reason: The complete landing index has missing or unreadable drawing evidence (Source evidence changed during capture: 1091A0:pipe-row [first ...". The second OF in n27a3 was refused the same way. Outcome lines "OF cancelled".
   2. **What was expected:** the same placement that worked a minute earlier in the same session's first drawing (OF1, DP1).
   3. **Pattern seen:** both times the first drawing had placed a source (OF and FO; DP and CDRG) before the reopen. When the first case placed no source (n27b2: N02 then N03), OF and FO placed normally.
   4. **Where the words come from:** `SourcePlacementService.cs` line 282, `LinkService.SourceLanding.cs` line 129 and `LinkService.SourceChanges.cs` line 39 at 96455f13: one pipe row (1091A0) was read twice during one capture with different contents.
   5. **Never seen before:** no other run report holds this sentence, and it is not in BUG_CARPARK.md.
   6. **Test that catches it (proposal):** a case that places DP, reopens the fresh copy (as the runner does), then places DP again and asserts "Downpipe placed. Tag: DP" and history absent "could not be refreshed".
   7. **Not established:** whether a drafter's own close-without-save and reopen does the same, or only the runner's reopen. An Opus root-cause job should look first.
2. **The robot's validation report is wrong on two points.**
   1. It says "No CE behaviour differed from its card" and "N03_BROKEN: OF typed twice, so the FO line is missing". In fact the twin's OF never placed at all (finding 1), so its check 1 failed too. The twin's red is real only by accident.
   2. Its section E item 4 for N04_BROKEN is right about the failing check (1036 against 1034), but in that run the downpipe was refused, so the count after the downpipe (1034) is the count before it.
3. **Card D07 asks for an "RG1 label"; the robot saw none.** Both N04 passes added only a polyline and a hatch ("object types CDRG added = AcDbPolyline | AcDbHatch"), and the place line names the raingarden RG2 (this drawing already holds an RG1). I found no raingarden label code in the source. Either the card is wrong or a label is missing: the desk should check with the card's author before D07 is counted.
4. **An engineering observation for Tim's word, not a fault:** in N11 the typed upstream level 17.60 puts pipe P3's start 150 mm above the pipe arriving at pit P4 (P4 row: inlet 17.45, outlet 17.60, was 17.40). CE did what was typed and cascades downstream only. Nobody has said whether CE should warn about it.
5. **Draft headers still say "NOT RUN YET" and the N10 do-not-run note is only in the drafts folder.** Leave them: any comment edit changes the hash and voids these passes and reviews. Tidy at the next real edit.

## The cases

1. **N01: CDREBUILD warns first and never saves (D27 and D18, CDREBUILD half). Verdict: CLAUDE-ACCEPTED-READY. Hash DD27359CAA38.**
   1. **Against the source:** the warning, "CDREBUILD complete: {pits} pits, {pipes} pipes" and the last line are word for word `LinkCommands.cs` lines 222, 265 and 314 at 96455f13 (the installed commit). The 270-character warning matched whole in both runs.
   2. **Against the cards:** D27 assertion 2 (warning first, contains "it does not save the drawing itself", last line; order checked by `matches $rb`), assertion 3 (U echo CDREBUILD; one "Command outcome: CDREBUILD completed"); D18 assertion 1 (SHA-256 and time unchanged), 2 (both sentences), 3 (no new file beside the drawing; the pattern allows any `_PRE_C7_` .dwg, as R04).
   3. **Runs:** PASS n27a1-s1 (02:16) and n27b1-s1 (03:58), separate AutoCAD starts. Red: N01_BROKEN (driver save-copy after CDREBUILD) fails only copy-unchanged (6790A1485D9D against 34BBE37C2EA4), n27a14.
   4. **Values the planner derived:** 11 pits and 49 pipes are this fixture's own, as Codex D4-02 saw; the case pins them, which is right for a fixed fixture.
2. **N02: EXPLODE a pit (D16). Verdict: CLAUDE-ACCEPTED-READY. Hash 7428272CD63B.**
   1. **Against the card:** assertion 1 (exact line with P3 and 6 pipes), 2 (109D56 gone, no "Pit P3=" row), 3 (109D56 back on STORMWATER PIT, P3 row back after the two U). The six pipes stay on STORMWATER PIPE.
   2. **Runs:** PASS n27a1-s1, n27a2-s1, n27b2-s1. Red: N02_BROKEN (no U) fails `equals $p3_back` in n27a2, the right reason.
   3. **Not covered:** the no-pipe wording branch; whether every schedule cell is equal after U (recorded); linework look.
3. **N03: OF and FO (D08). Verdict: NEEDS STRONGER ASSERTION, then one clean twin run. Hash 7A7AEF23FDD4. No review file.**
   1. **What it proves:** OF and FO each place one OVERFLOW insert at their own point, print "Overflow placed. Tag: OF..." and "Front overflow placed. Tag: FO...", offer the next one, and two Esc each print the stop line. PASS n27a3-s1 and n27b2-s1.
   2. **What the card asks and the case does not assert:** tags counting from 1 (both runs printed OF1 and FO1) and the plan labels "OF" and "FO" (both runs recorded new texts "OF" and "FO"). Lines to add, then two new runs: `history has "Overflow placed. Tag: OF1."`, `history has "Front overflow placed. Tag: FO1."`, `matches $new_texts "(^|\| )OF( \||$)"`, `matches $new_texts "(^|\| )FO( \||$)"`.
   3. **Twin:** its only run (n27a3) failed because OF itself was refused (finding 1), not because FO was missing. Run N03_BROKEN again as the first case of its own session so the red is the intended one.
4. **N04: downpipe and raingarden with no pipe nearby (D07). Verdict: NEEDS RUNS, held on finding 1. Hash 74CA6C503ADD. No review file.**
   1. **What it proves:** DP1 placed with "Nothing nearby. The source connects when a pipe is drawn to it.", one DOWNPIPE DYNAMIC WITH MASK insert; CDRG with the four typed corners, Close and Skip prints "Raingarden RG2 placed. 4 vertices, 12.0 m²"; one U echoes CDRG and leaves the downpipe. PASS n27a4-s1 and n27b3-s1. Red: N04_BROKEN (no U) fails the count (1036 against 1034).
   2. **12.0 m²** is guaranteed by the source (`RaingardenPlacementPlan.AreaText`: one decimal plus " m²", converted with INSUNITS; 4000 by 3000 mm), not an accident of the drawing.
   3. **Why held:** the same night DP was refused in the twin's session (finding 1), so I cannot say DP "works as intended" yet. Also only "no pipe nearby" is proved (the card's blank drawing is not used), and the card's RG label was not found (finding 3). At best PARTIAL once finding 1 is explained.
5. **N05: pit label and cover level (D09). Verdict: PARTIAL, ready for the part. Hash 4C28CE66C02F.**
   1. **Covered:** pit block count 1; one label block (name "PIT LABEL 2", which `BlockService.cs` lines 220-221 lists as a valid pit label name, so the robot's `name~^PIT LABEL` fix is sound) on STORMWATER PIT LABEL with PIT_LABEL P8; one cover text exactly "CL 19.000"; "Pit placed successfully."; U echoes PIT and no new object remains.
   2. **Not covered:** the label position (8.3 mm from the click in both runs, recorded) and the cover corner. Cover text layer recorded 25TEXT.
   3. **Runs:** PASS n27a6-s1 and n27b4-s1 on hash 4C28CE66 (the a5 FAIL was the earlier text). Red: N05_BROKEN fails both counts (n27a5 and n27a6).
6. **N06: office layers (D24, installed part). Verdict: PARTIAL, ready for the part. Hash 4A402A8FB2CF.**
   1. **Covered:** CLAYER still BLOCKS; nothing new on 0 or BLOCKS; pit on STORMWATER PIT; arrow on ARROW. Recorded the same in both runs: pipe STORMWATER PIPE, IL texts 20TEXT, label 25TEXT (the card says "pipe-text layer"; the source has 20TEXT for IL text: recording rather than asserting is right until the desk settles the card).
   2. **Runs:** PASS n27a7-s1 and n27b3-s1. Red: N06_BROKEN (CLAYER set to 0) fails check 1.
7. **N07: Undo names, switches on (D19). Verdict: PARTIAL, ready for the part. Hash 57A7624D75F9.**
   1. **Covered:** see the named-tools list. The twin printed "Last point taken back." instead (switch off), the right reason.
   2. **Runs that count:** n27a15-s2 (03:53) and n27b4-s2 (04:27). The n27a8 pass is not relied on (AutoCAD closed for only about 4 s before it, as the robot disclosed).
   3. **To make D19 whole for the switch-on setting:** add a CD pipe placed and one U asserting the echo names CD (card assertion 1).
8. **N08: CDRENUMBER (D20). Verdict: PARTIAL, ready for the part. Hash 35C4E2C9193.**
   1. **The robot's text fix is sound:** AutoCAD's log doubles the keyword list ("[Yes/No] [Yes/No] <No>"); the case still asserts the CE wording and the count of 2.
   2. **Derived rows check out:** P9 and P10 are unconnected 450 x 450 pits; after Yes the rows read P1 to P7, P8, P9, C1; after the two U they read exactly as before in both runs.
   3. **Lines to make D20 whole, then two new runs:** `equals $rows2 $rows0`; `history count "P9 -> P8" = 2` and `history count "P10 -> P9" = 2` (the second preview proves No changed nothing); `matches $rows1 "Pit P9=.*Pit C1="`.
9. **N09: Pit Schedule natural order (D21). Verdict: PARTIAL, ready for the basic order. Hash 6597D8D540B3.**
   1. **Covered:** P1 to P7, P9, P10 in order; P10 never before P1 or P2 ("Pit P1=" cannot match "Pit P10=" because of the "="). Close works; file unchanged.
   2. **Red:** flipped order only (as R21 and R26 in B5). Accepted because a wrong order would fail the first regex directly.
   3. **Optional line:** `matches $rows "Pit P10=.*Pit C1="` (group order as far as this drawing allows).
10. **N11: cascade levels in the schedule (C40 stored-level half). Verdict: PARTIAL, ready for the part. Hash C13A2B8D3120.**
    1. **Derived cells check out:** after U and REDO both runs read P3 17.50/17.45 and P2 17.33/17.28 with two decimals, the same set R11's accepted texts show; P1 17.18/17.13 and P4 outlet 17.60 recorded. After the final two U every row equals the rows before.
    2. **Runs:** PASS n27a12-s1 and n27b6-s1. Red: N11_BROKEN (no U) fails the full-row comparison.
11. **N12: COPY of a pit (D15 plain COPY). Verdict: PARTIAL, ready for the part. Hash 9E2E8556D1BC.**
    1. **Covered:** see the named-tools list. P8 is the lowest free number on this drawing (P1 to P7, P9, P10 exist), as Codex D3-04 saw.
    2. **Line to make D15 whole, then two new runs:** `matches $p3_label1 "text.:.P3.,.insertion"` (both runs recorded P3).
    3. **Red:** N12_BROKEN (expects P3 on the copy) fails, a flipped red; the count after U has its own logic.

## Build and run checks (read myself)

1. **Installed now (04:55):** Civil `3.0.83+96455f13fa2df1e63f8bc7cf9d48bd7dc2c14737` in the Legacy, Modern and Net8 folders, files written 27 Oct 18:56 to 19:01. Every n27 run header reads civil 3.0.83+96455f13 / struc 1.0.125+204dfad2 / mgr 1.1.83+96455f13. First n27 run 02:16, last 04:45: no install between them, so no run straddles one.
2. **Hashes:** all 11 cases and all 11 twins hash today exactly as in the validation report section D and the ledger rows of their passing runs (ledger.json working copy at 04:55).
3. **Sessions:** every counted pair is two different run calls, each its own AutoCAD start; each ended clean (AutoCAD left 0, lock none, settings fingerprint differences 0).
4. **An AutoCAD (pid 86360, started 04:50) was running while I worked.** Not mine; I did not touch it.

## What I read

1. `C:\TimOS\RULES.md` in full with amendments; `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`; the validation report, the spec, the pre-flight and the B5 review in full.
2. Cards D07, D08, D09, D15, D16, D18, D19, D20, D21, D24, D27 and C40 in full.
3. All 11 case files and their twins; R16, R04 and R13 review files; `case_runner.ps1` lines 100 to 140 (the gate).
4. Every n27 run report (failing checks of every twin) and the run JSON for the recorded values quoted above; ledger rows for every N case and for R04, R11, R13 on 3.0.83.
5. Source at 96455f13 by `git show` / `git grep` only: `LinkCommands.cs`, `SourceBlockInsertCommands.cs` (CDRG), `RaingardenPlacementPlan.cs`, `BlockService.cs`, `SourcePlacementService.cs`, `LinkService.SourceLanding.cs`, `LinkService.SourceChanges.cs`.

## What I did NOT check (RULES 5.9)

1. Nothing in AutoCAD and no picture was looked at.
2. The full CE log text behind finding 1 (my search of the log folders was still running when I finished; I relied on the run JSON, which clips the reason).
3. Whether the cascade, renumber or CDREBUILD results are right as engineering: Tim's word.
4. SETUP-P8 bytes at run time (N06 uses it; the gate binds only the case hash).
5. N10 and its twin (not run, not reviewed).
6. I ran a copy of the gate's three checks against my nine files (all pass, one file per case); I did not run the runner.

## Files written

1. This report.
2. Nine review files beside the cases in `C:\Lisp Files\_ACAD_DRIVER\cases\`: `N01_cdrebuild_warns_never_saves.review.txt`, `N02_explode_pit_leaves_schedule_u_restores.review.txt`, `N05_pit_label_number_and_cover_level.review.txt`, `N06_office_layers_current_layer_kept.review.txt`, `N07_undo_names_and_route_undo_sentence.review.txt`, `N08_cdrenumber_no_then_yes_then_u.review.txt`, `N09_pit_schedule_natural_order.review.txt`, `N11_cascade_schedule_levels_u_redo.review.txt`, `N12_copy_pit_new_number_check_levels.review.txt`. Copies of the same nine in `areas\runner-reports\reviews\`.
3. Scratch on this PC only: `C:\ce-fx\opus_n27rev\gatecheck.ps1`. Undo: delete the nine review files and revert this commit.

## Summary (under 100 words)

All 11 N cases passed twice on Civil 3.0.83 with no install between runs. N01 (CDREBUILD) and N02 (EXPLODE) are ready whole; seven are ready for part (N05, N06, N07, N08, N09, N11, N12); N03 needs exact tag and label lines plus a clean twin run; N04 is held. D16, D18 (with R04) and D27 (with R13) may be written Claude-accepted on 3.0.83. New finding: DP and OF were refused ("source landing could not be refreshed") in a reopened drawing; it needs a bug number and a root cause. Nine review files written.
