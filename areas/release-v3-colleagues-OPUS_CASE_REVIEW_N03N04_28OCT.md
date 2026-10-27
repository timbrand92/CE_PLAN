# Opus independent case review: N03 (OF and FO) and N04 (downpipe and raingarden) on Civil 3.0.83 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026, about 08:31 to 08:40 Melbourne (PC clock), by the Team Opus job "INDEPENDENT CASE REVIEW OF N03 AND N04" (desk plan/03), standing in for Codex (at its weekly cap). Read-only on the product: no AutoCAD, no runner, no case, variant, runner, driver, ledger, settings, DESK_LOG.md or BUG_CARPARK.md edit. Files written: this report and two `.review.txt` files. Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Judged against the asks for N03 and N04 in `release-v3-colleagues-OPUS_CASE_REVIEW_N27_28OCT.md` (the cases items 3 and 4), with the robot report `release-v3-colleagues-ROBOT_N03_N04_BUG1225_28OCT.md` beside it.

## ANSWER FIRST

### FOR TIM

1. **My own mistakes first: none that cost anything.** I first wrote the wrong time (08:45) into the two review files and corrected it to 08:35 before copying them. One look-up tool was missing on this PC and I used another.
2. **Result: both are ready to count. N03 for the whole of its card, N04 for part.**
3. **N03, overflow (OF) and front overflow (FO): ready, whole card.** Both use the same symbol. The tags are OF1 and FO1, each counting from 1. The plan labels read "OF" and "FO". Each one offers the next and stops on Esc. It passed in two separate AutoCAD starts, and the deliberately wrong copy failed for the right reason (no FO line, while OF placed normally). Everything my earlier review asked for is now in the case.
4. **N04, downpipe (DP) and raingarden (CDRG) with no pipe nearby: ready for part.** Covered: the downpipe places on its own, the raingarden places with an area of 12.0 m² and nothing is refused, and one U takes back only the raingarden. Not covered: the card asks for an "RG1" label, and CE draws no raingarden label at all. Either the card is wrong or a label is missing. The desk needs an answer before D07 can count whole.
5. **The reopen fault (BUG-1225) does not change what these two prove, but it limits it.** Every counted run was the first drawing of its AutoCAD start, where DP and OF work. Placing a DP or OF, closing without saving, and reopening in the same AutoCAD still gets refused (BUG-1225, open). So these results say "works in the first drawing", not "works after a reopen".
6. **You may now write "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)":**
   1. **D08 OF and FO: the whole card.** Add the note "after a reopen in the same AutoCAD, see BUG-1225 (open)".
   2. **D07 downpipe and raingarden: part only.** The part is: both place with no pipe nearby, 12.0 m², and U takes back the raingarden only. Not the RG label and not a fully blank drawing.
7. **Nothing for you to decide or test now.**

---

### Counts and the named tools (the desk's detail)

1. **Counts (one verdict per case, N03 and N04 only):**
   1. **CLAUDE-ACCEPTED-READY, whole claim: 1.** N03 (card D08 as written).
   2. **PARTIAL, ready for the exact part named: 1.** N04 (card D07).
   3. **NEEDS STRONGER ASSERTION, NEEDS BROKEN VARIANT, NEEDS CODEX LOOK, NEEDS RUNS, FAIL: 0.**
   4. **Review files written: 2,** each naming the exact current SHA-256: `N03_of_fo_same_symbol_own_tags.review.txt` (AADE74748DAF) and `N04_dp_and_raingarden_without_pipe.review.txt` (74CA6C503ADD, VERDICT names its part). A copy of the gate's three checks (`case_runner.ps1` lines 116-126) passes for both: one candidate file each, verdict line, hash equal to the case file now, reviewer not starting with builder.
2. **Named tools, which may now be written "FIXED (Claude-accepted, Civil 3.0.83, 28 Oct 2026)" and for which part.** Only D08 and D07 change in this review. The others are as the N27 review left them, repeated so the list is in one place:
   1. **D08 OF and FO: whole card** (N03). Note beside it: BUG-1225, OF refused after a source placement and a reopen in the same AutoCAD.
   2. **D07 downpipe and raingarden: part** (N04). The part is: DP and CDRG place on empty ground with no pipe nearby, nothing is refused, the area reads 12.0 m², one U removes only the raingarden. Missing: the RG1 label (card assertion 2; no label code in the source, so the card or the product must be settled), an assertion that the outline is closed, the exact tag DP1 (printed both runs, asserted only as "DP"), the blank drawing F-BLANK, DP after a reopen (BUG-1225).
   3. **D16 EXPLODE: whole** (N02, unchanged).
   4. **D18 CDREBUILD and CE never saves: whole with R04** (unchanged).
   5. **D27 warn first: whole with R13** (unchanged).
   6. **D09 pit label and cover level, D19 Undo names, D20 CDRENUMBER, D21 Pit Schedule order, D15 COPY, D24 office layers, the Edit Pipe cascade: part only,** exactly as the N27 review lists (unchanged; nothing new was run for them).
3. **Bugs:** none newly FIXED. N04 names BUG-176 only in its PLAN_ITEM and has no PROVES_BUGS line, so BUG-176 is not marked by this review. BUG-1225 stays OPEN (8 of 8 reproduced); N13 and N14 are its guards and need no review until a fix is installed.

## Findings for the desk (RULES 6.2)

1. **BUG-1225 bounds both verdicts; it does not void them.** Every counted run of N03 and N04 (rn3a, rn3b, rn4a, rn4b, and for N04 also n27a4 and n27b3) has the observation "fresh drawing: first case of this session". The robot showed the refusal only follows a source placement and a reopen in the same AutoCAD (0 of 2 with nothing placed first). One extra clue I read: in n27b3 N04 ran first and N06 (PIT and CD, no source) ran second after a reopen without trouble; that run did not place a source after the reopen, so it says nothing about a pit as the trigger.
2. **Card D07 asks for an RG1 label that CE never draws.** The CDRG code at 96455f13 (`SourceBlockInsertCommands.cs` lines 595-623) commits the outline and prints "Raingarden {name} placed..."; it calls no label writer. Both new runs added only a polyline and a hatch. The desk should ask the card's author whether the card or the product is wrong.
3. **N03's comment and NOT_AUTOMATED lines are now out of date** (they still say only prefixes are asserted and the labels are recorded only). Leave them: any edit changes the hash and voids these passes and this review. Tidy at the next real edit, then re-run twice.
4. **The N03 twin proves only the FO history check can go red.** The new label and tag checks have no red of their own. I accept this: the label regex needs a space, a bar or the line end after OF, so a label reading OF1 fails it, and the tag lines need the exact digit.

## The cases

1. **N03: OF and FO (D08). Verdict: CLAUDE-ACCEPTED-READY, whole card. Hash AADE74748DAF.**
   1. **Hash:** the case file hashes AADE74748DAFB64B... now, the same as both ledger PASS rows (rn3a-s1 07:11, rn3b-s1 07:16). The twin hashes 9B3809FF2506, the same as its ledger FAIL row (rn3t-s1 07:21). The earlier passes on 7A7AEF23FDD4 no longer count, as the robot said.
   2. **Runs:** PASS RUN-20261028-0708-C3.0.83-rn3a-s1 and RUN-20261028-0714-C3.0.83-rn3b-s1, separate AutoCAD starts, each N03 alone and first, clean end, settings differences 0. Installed build 3.0.83+96455f13 on every header. The DLLs on disk (Legacy, Modern, Net8) still read 3.0.83+96455f13, written 27 Oct 18:56 to 19:01, so no run straddles an install.
   3. **Twin:** N03_BROKEN alone in RUN-20261028-0719-C3.0.83-rn3t-s1: check 1 "Overflow placed. Tag: OF" passed (OF1 placed, two "OF completed" outcome lines); check 2 "Front overflow placed. Tag: FO" failed. That is the intended reason, and the wrong-reason red of n27a3 (OF refused) is now replaced.
   4. **The asks of the N27 review, all met:** `history has "Overflow placed. Tag: OF1."`, `history has "Front overflow placed. Tag: FO1."`, `matches $new_texts "(^|\| )OF( \||$)"` (matched '| OF |'), `matches $new_texts "(^|\| )FO( \||$)"` (matched '| FO'), and a clean twin run as the first case of its own session.
   5. **Against card D08:** assertion 1 (both history lines), assertion 2 (`count $ovs = 2` with name=OVERFLOW, one within 50 of each point), assertion 3 (OF1 and FO1; labels OF and FO). The insert itself has no attributes (the run's entity read shows `"attributes":[]`), so the tag cannot be read from an attribute as the card's step 4 imagines. The printed tag is the stored tag: `SourcePlacementService.cs` lines 996-997 write `actualTag` with `SourceTagService.SetTag` and line 1060 returns the same value, which `SourceBlockInsertCommands.cs` prints as "Tag: {placed.Tag}".
   6. **Values the source guarantees, not accidents of the drawing:** `AllocateNextTag` numbers each family on its own (live tags plus the drawing's stored high-water), so OF1 and FO1 on a fixed fixture with no OF or FO are guaranteed. The label is `GetLabelDisplayText`: with `SourceNumbering.Default` (Only when scheduled) OF and FO are not scheduled families, so the label shows the family only, "OF" and "FO". The case does not read the drawing's Number sources setting itself; "Never" would give the same labels, which does not change the card's claim.
   7. **Not covered:** the blank drawing F-BLANK (it matters only for "counting from 1", which holds on this fixture); the label position; the look of the two symbols (Codex D7-02 on 3.0.78); OF and FO after a reopen (BUG-1225).
2. **N04: downpipe and raingarden with no pipe nearby (D07). Verdict: PARTIAL, ready for the part named. Hash 74CA6C503ADD.**
   1. **Hash:** unchanged, the same in all four PASS ledger rows (n27a4-s1, n27b3-s1, rn4a-s1, rn4b-s1). Twin DE3C4B2DB50B, the same as both FAIL rows.
   2. **Runs:** PASS RUN-20261028-0724-C3.0.83-rn4a-s1 and RUN-20261028-0729-C3.0.83-rn4b-s1, separate AutoCAD starts, N04 alone and first in each. The earlier n27a4-s1 and n27b3-s1 passes were also first case of their sessions. Same build and no install, as for N03.
   3. **Twin:** N04_BROKEN alone in RUN-20261028-0734-C3.0.83-rn4t-s1 fails `equals $c3 $c1` (1038 against 1036). DP placed normally in that session ("DP completed 27765 ms"), so the count it compares is the right one. This replaces the n27a4 twin run, where DP had been refused.
   4. **Why the hold is lifted:** the N27 review held N04 until the refusal was explained. It is not yet root-caused, but the robot bounded it: it happens only after a source placement and a reopen in the same AutoCAD, never in a session's first drawing. Every N04 pass is a first drawing, so DP "works as intended" there.
   5. **Covered:** "Downpipe placed. Tag: DP" with "The source connects when a pipe is drawn to it." (the full line read "Tag: DP1. Nothing nearby. ..." in all runs; the "Nothing nearby" sentence is `SourceLanding.cs` line 465), the next-DP offer, one DOWNPIPE DYNAMIC WITH MASK insert; the CDRG prompts, the GIO question, "Raingarden RG2 placed. 4 vertices, 12.0 m²." (12.0 m² is guaranteed by `RaingardenPlacementPlan.AreaText` with INSUNITS 4 and a 4000 by 3000 outline, as the N27 review found), no cancel, error or "was not placed" line; the count rises; one U echoes CDRG and the count returns to the count after the downpipe.
   6. **Missing for the whole card:** the RG1 label (finding 2); an assertion that the boundary is closed (the polyline was recorded, not read for closed); `history has "Downpipe placed. Tag: DP1."` (one line to add, as was done for N03); the blank drawing F-BLANK; DP after a reopen (BUG-1225). The name RG2 is right for this fixture, which already holds RG1.

## What I read

1. `C:\TimOS\RULES.md` (the acceptance amendment and the rules around it), the robot report `release-v3-colleagues-ROBOT_N03_N04_BUG1225_28OCT.md` in full, the N27 Opus review in full, the N lines of the spec, pre-flight and validation report, the R16 and N05 review files for the format, and `case_runner.ps1` lines 100-140 (the gate).
2. Cards D07 and D08 in full; the BUG-1225 entry in BUG_CARPARK.md (read only).
3. Both case files and both twins (full text and a line-by-line comparison); the run reports rn3a, rn3b, rn3t, rn4a, rn4b, rn4t and the session order in n27b3; the ledger rows for N03, N03_BROKEN, N04, N04_BROKEN.
4. Source at 96455f13 by `git show` and `git grep` only: `SourceBlockInsertCommands.cs`, `SourcePlacementService.cs`, `SourceTagService.cs`, `SourceNumbering.cs`, `ProjectDataService.Rulebook.cs`, `SourceLanding.cs`. Commit 96455f13 is on origin/claude/rel-20261026x.

## What I did NOT check (RULES 5.9)

1. Nothing in AutoCAD and no picture was looked at; I did not run the runner.
2. The root cause of BUG-1225; whether a drafter's own close and reopen does the same.
3. The drawing's own Number sources value (the case does not read it either).
4. The CE log behind the six runs (I relied on the run reports and ledger).
5. The other nine N cases (reviewed in the N27 review, not re-reviewed), N10, N13 and N14.

## Files written

1. This report.
2. Two review files beside the cases in `C:\Lisp Files\_ACAD_DRIVER\cases\`: `N03_of_fo_same_symbol_own_tags.review.txt` and `N04_dp_and_raingarden_without_pipe.review.txt`, with copies in `areas\runner-reports\reviews\`.
3. Scratch on this PC only: `C:\ce-fx\opus_n03n04rev\gatecheck.ps1`. Undo: delete the two review files and revert this commit.

## Summary (under 100 words)

N03 and N04 both passed twice on Civil 3.0.83 in separate AutoCAD starts, with no install between, and each broken twin failed for the right reason as the first case of its own session. N03 (OF and FO) is ready for the whole of card D08: same symbol, tags OF1 and FO1, labels OF and FO. N04 is ready for part of D07: DP and the raingarden place with no pipe nearby, 12.0 m², and U removes only the raingarden. The RG1 label is not drawn at all. BUG-1225 limits both to a session's first drawing. Two review files written.
