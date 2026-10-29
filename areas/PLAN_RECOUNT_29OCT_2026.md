# Plan recount 6, Counted Thu 29 Oct 2026 13:27 Melbourne (PC clock, read with `date`)

Refreshes `PLAN_RECOUNT_28OCT_2026.md` (counted Wed 28 Oct, about 18:12). Read-only: nothing built, run, installed or opened in AutoCAD; no Codex job; no git; no other file edited. The only file written is this one.

**Method and definitions, restated from the 28 Oct recount (same rules used here):**

1. **The lists.** The same 548 plan items (Civil 212, Manager 25, Shared 153, Structural 158). The 390 is Civil + Manager + Shared. The everyday tools (the "40") and the bugs are kept apart and never added in.
2. **Built** means merged into the line installed on Tim's PC. A second figure counts open unshipped draft PRs as well. **Installed** is read from the DLLs, not from a document.
3. **Tested** means a whole plan item with a runner case (independent review says the whole card, two passes on one installed build, failing twin red) or a Codex PASS look covering the whole item. "Part" is counted separately, and the item is taken from each case's own `PLAN_ITEM` line. Bug and regression cases are not plan items.
4. **Accepted by Tim** is a separate fact, and only Tim's own word counts. Built, Tested, Installed and Tim-accepted are four facts and are never merged into one percentage (RULES section 4).
5. **Daily tools** use the ledger's figure (`ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`) and are not re-derived; unknown stays UNKNOWN.

**Installed, read by me from the nine DLLs at 13:2x today:** Civil 3.0.85 and Manager 1.1.85, build 09126560 (all three lanes: Legacy, Modern, Net8); Structural 1.0.125, build 204dfad2. That is one install since the 28 Oct count: C-75 (QUEUE item 310, Thu 29 Oct 00:21). C-76 is NOT installed and is not counted.

---

## ANSWER FIRST

1. **548-item plan: Built 55% / Tested 3.1%.** Built 300 of 548 in the plugin (412 of 548, 75%, counting unshipped drafts), unchanged. Tested whole 17 of 548 (was 12), and 27 of 548 (4.9%) counting parts (was 26).
2. **390-item 9 Nov scope: Built 47% / Tested 4.4%.** Built 184 of 390 in the plugin (290, 74%, with drafts), unchanged. Tested whole 17 of 390, and 27 of 390 (6.9%) counting parts.
3. **40 everyday tools: Built 90% / Claude-accepted 47.5% / Tim-confirmed 42.5% official.** Claude-accepted 19 of 40 (CE 00's official figure). Tim-confirmed 17 of 40 in `PROGRESS.json`, but the ledger's later hand checks support 19 of 40 (21 counting two half-checks).
4. **60 pilot-critical bugs: closed 0 of 60 / fix installed 26 of 60 (43%).** Built not installed 5, no fix 27. Two draft robot cases exist for the bugs and neither has ever run.
5. **Why the plan numbers moved:** the only install since 28 Oct was a bug-fix train (C-75), so Built did not move. Tested rose because five Civil plan items were completed by new robot and Codex evidence.

---

## FOR TIM (where it stands, in drawing terms)

1. **The plugin on your PC has not gained a single new plan feature since last night.** The only install was C-75 (ROTATE Copy, Edit Pipe arrow, floor-waste wording). Those are bug fixes, so the "built" figures stay put.
2. **More of what is built is now proved.** Example: you place a pipe 90 mm off a pit and it snaps to the pit wall, while one 110 mm off is left free. You checked that yourself at about 11:50 this morning, and the robot has now proved the same thing twice. That is the plan item for the pit catch (UX-PIT-02), and it now counts as tested. The pit label landing where you click (UX-CPLAN-21) and the short-pipe label on its leader (UX-CPLAN-24) joined it. CDRENUMBER's labels on the plan (UX-CPLAN-18 and 19) are the fifth and sixth lines of the same group.
3. **Your own checks this morning count separately, as your word, not as a robot test.** You passed about 14 plan items by hand in your own AutoCAD (PIT and CD, pipe joins pit, ERASE, COPY, EXPLODE, CDRENUMBER and others). Three of them were not robot-tested at all: the mid-pipe label, Hide grade and the ribbon tab jump.
4. **Two things you looked at did NOT pass:** the FO symbol reads "OF" (BUG-1236), and the recent-value buttons are missing from the New Pipe page (BUG-1238). CDRENUMBER needed set-up first: it said "nothing to renumber", then stopped on a drawing with no outlet pipe (BUG-1237); it passed once you added an outlet pipe.
5. **The 60 pilot-critical bugs are all still open.** 26 have a fix on your PC, 5 are built and waiting for a train, 27 have no fix yet. Nobody has proved a single one of them in AutoCAD.
6. **Where it is most solid:** the everyday drawing tools. **Where it is thinnest:** the 60 bug fixes, and the window items nobody has looked at (existing and demolished layers is not built).

---

## DETAIL

### 1. The 548-item plan

1. **Built: 300 of 548 (54.7%) in the plugin; 412 of 548 (75.2%) counting open drafts. Unchanged since 28 Oct.**
   1. **Evidence:** QUEUE item 310 is the only install since the 28 Oct count (C-75, Civil 3.0.85 / Manager 1.1.85, 29 Oct 00:21). Its PRs are #1831 (BUG-665, BUG-672), #1832 (BUG-1222) and #1833 (BUG-1223). `TRAIN_C75_PR_LIST_2026-10-28.md` names no UX plan ID.
   2. **C-76 (3.0.86):** four PRs (#1834 BUG-859, #1835 BUG-372, #1836 BUG-090, #1837 BUG-1228). Not installed, no UX ID, not counted.
   3. **Drafts:** I found no new draft that completes a whole plan item. B-006 (#1839, recent buttons, UX-PIPE-04 part) is "code written and read only, NOT built" per the build register. B-007 (RG1 label) and the others are queued or not started. The 412 stays at the 28 Oct figure.
   4. **Carried, not re-derived:** the 300 and 412 are the 18 Oct item count carried through every recount. I confirmed only that no whole plan item has shipped since (this is the 28 Oct recount's own limit).
2. **Tested, whole: 17 of 548 (3.1%). Was 12 (2.2%). Tested counting parts: 27 of 548 (4.9%). Was 26 (4.7%).**
   1. **The five new whole items (all Civil, all inside the 390):**
      1. **UX-CPLAN-21, pit label and cover level (D09).** Case N25, whose `PLAN_ITEM` line says "the whole card". Opus B7 whole (`release-v3-colleagues-OPUS_CASE_REVIEW_B7_29OCT.md`, ledger item 24), Codex cx_cr23 agrees (ledger item 28). Two passes on 3.0.85 in `ledger.json` (the label lands within about 0.1 mm of the click; cover text "CL 19.000"; one U removes all three). On 28 Oct this was part (N05, the label spot needed a Codex look).
      2. **UX-PIT-02, pit catch (D02).** Case N23 with N19. Opus B7 whole, Codex cx_cr23 agrees, two passes on 3.0.85. Caveat from Codex: N23 tests 90 mm caught and 110 mm free, not a literal 100 mm. Tim's hand check H9b (90 caught, 110 free) is the same test.
      3. **UX-CPLAN-24, short-pipe label on a leader (D11).** Case N20 (robot part; wording and arrow position needed a Codex look) completed by Codex G1-01 PASS, SURE (ledger item 22, report `CODEX_VERIFY_G1_20261028_2032.md`, Civil 3.0.84). N20 has two passes on 3.0.85.
      4. **UX-CPLAN-18 and UX-CPLAN-19, CDRENUMBER (D20).** Cases N15 and N24 (robot part; the plan labels were not read one by one) completed by Codex G2-01 PASS, SURE (ledger item 21, report `CODEX_VERIFY_G2_20261028_1947.md`, Civil 3.0.84). Both cases have two passes on 3.0.85.
   2. **How firm the five are:** UX-CPLAN-21 and UX-PIT-02 stand on a robot review alone. UX-CPLAN-24, 18 and 19 rest on a robot "part" plus a Codex look that supplies the missing half; the ledger itself says "both halves" (items 21 and 22) but N24 and N15 are still "part" in the reviews (ledger items 19, 24; cx_cr24). **Read strictly, the whole count is 14 of 548 (2.6%), not 17.** I counted 17 because the 28 Oct method counts "a Codex PASS look that covers the whole item". That reading is a judgement call.
   3. **The 12 carried wholes (unchanged items):** UX-STD-01b, UX-PIPE-02, UX-PIPE-03, UX-SRC-01, UX-CPLAN-26, UX-EDIT-01, UX-EDIT-02, UX-EDIT-04, UX-STD-06, UX-STD-03, UX-UNDO-01, UX-REP-01. Each passed twice on 3.0.84 (ledger item 23; 98 passing case-runs, 0 failures).
   4. **On the build actually installed (3.0.85):** 13 of the 17 have two passes (I counted them in `runner-reports\ledger.json`). **4 hold on 3.0.84 only:** UX-STD-01b (R01), UX-PIPE-02 (R02, R02b), UX-CPLAN-26 (R03) and UX-STD-03 (R04). Those cases are the "12 owed" of ledger item 26 (R01 R02 R02b R03 R04 R05 R07 R10 R14h x3 R16), not yet run on 3.0.85. No run exists after 29 Oct 08:14 in `ledger.json`. C-76 is a FULL-class train (`C76_PROOF_PLAN_29OCT.md`), so installing it tonight restarts every two-pass clock.
3. **Tested, part: 10 items (was 14).** Five moved up to whole (UX-CPLAN-18, 19, 21, 24 and UX-PIT-02). One is new: UX-LBL-01, hand-placed label stays (N27, Tidy labels switch ON only; Opus B7 and Codex cx_cr24 say part). The 10: UX-SCHED-06, UX-SRC-05, UX-LYR-01, UX-WORD-03, UX-LBL-01, UX-LBL-02, UX-LBL-03, UX-DI-03, UX-SURV-03, UX-SCHED-02.
4. **Accepted by Tim, plan items (my mapping, not recorded in any plan file): 14 whole, 6 part, 2 refused.**
   1. **Whole (Tim's own AutoCAD, 29 Oct, ledger H1 to H20):** UX-STD-01b (H1, H2), UX-PIPE-02 (H15), UX-CPLAN-26 (H15), UX-EDIT-01 (H5, one pipe only), UX-EDIT-02 (H6), UX-EDIT-04 (H4), UX-STD-06 (H17), UX-CPLAN-21 (H15), UX-CPLAN-23 (H15), UX-PIT-02 (H9b), UX-PIPE-05 (H20), UX-RIBBON-01 (H18), UX-CPLAN-18 and 19 (H14).
   2. **Part:** UX-UNDO-01 (PIT half only), UX-REP-01 (warn-first, U not tried), UX-LYR-01, UX-SCHED-06, UX-SURV-03, UX-WORD-03 (Cancel only).
   3. **Refused:** UX-SRC-01 (the FO symbol reads "OF", BUG-1236); UX-PIPE-04 (recent buttons missing, BUG-1238).
   4. **Not the same as Tested.** Three of the 14 (UX-CPLAN-23, UX-PIPE-05, UX-RIBBON-01) have Tim's pass and no robot or Codex pass. If Tim's passes were also counted as tests, tested whole would be 20, but that is not the 28 Oct definition.
   5. **Official figure:** none. `PROGRESS.json` has no plan-item Tim-accepted count (only tools), and the 28 Oct recount said 0 of 548. UNKNOWN officially.
5. **Codex look as well:** unchanged at 4 on the whole-runner-plus-look definition (UX-PIPE-03, UX-SRC-01, UX-EDIT-04, UX-REP-01). The three Codex-completed items above are a different case (robot part plus look).
6. **Source for the official number:** `PROGRESS.json` still shows tested 12 of 548 (`planCountedAt` 28 Oct 18:12). My 17 is higher than the file; this recount should replace it if the desk accepts the five items.

### 2. The 390-item 9 Nov scope

1. **Built installed: 184 of 390 (47.2%). Counting unshipped drafts: 290 of 390 (74.4%).** Both unchanged from 28 Oct, for the reasons in 1.1.
2. **Tested whole: 17 of 390 (4.4%) (was 12, 3.1%). Counting parts: 27 of 390 (6.9%) (was 26, 6.7%).** Strict reading: 14 of 390 (3.6%).
3. **What changed:** the same five items as group 1 (UX-CPLAN-18, 19, 21, 24, UX-PIT-02), all Civil, all in the 390. The new part is UX-LBL-01. Structural still has none (108 built, 0 tested, outside the 390).
4. **Not built in the 390:** about 100 items (390 minus 290), unchanged, mostly paused by Tim's 17 Oct ruling A.
5. **The 9 Nov scope no longer matches the calendar.** Tim's 29 Oct items 68 and 69 superseded the Fri 6 Nov freeze; the pilot takes the newest tested build on Fri 13 Nov, pilot Mon 16 Nov (BUILD_REGISTER train calendar, scoreboard section 5). The "9 Nov scope" is kept as the fixed list for this count only.

### 3. The 40 everyday tools

1. **What the 40 is.** 30 daily cards (D01 to D30) plus 8 named checks. The plan names 38. **CE 00's ruling (DESK_LOG 29 Oct 11:32, scoreboard section 4):** PIT and CD are the same checks as D01 and D12 and are not counted twice, which leaves 36 distinct named tools. Two slots of the 40 were never named and none has been invented. A note on the ruling: D12 on the cards is "one IL text at each pipe end", so "D01 and D12" looks like a slip for D01 alone covering PIT and CD. I quote the ruling and do not alter it.
2. **Built: 36 of 40 (90%). Unchanged.** One tool is half built (D24 office layers), one is not built (D25), two slots unnamed. D05 and D07 builds (B-006, B-007) are still draft or queued.
3. **Claude-accepted: 19 of 40 (47.5%). This is the OFFICIAL count** (CE 00 ruling, ledger item 28; `PROGRESS.json` `claudeAccepted` 19; scoreboard section 4). Was 14 on 28 Oct 18:12. The five added since:
   1. **D11, short pipe label:** N20 plus Codex G1 PASS (ledger 22, 23).
   2. **D20, CDRENUMBER:** N15 plus Codex G2 PASS (ledger 21, 23).
   3. **D02, pit catch:** N23, Opus B7 whole, Codex agrees (ledger 24, 28).
   4. **D09, pit label:** N25, same reviews.
   5. **CDSYNC keeps the schedule (named check):** N26, same reviews. CE 00's item 28 added it by the same "named by the plan" rule used for Recover Inverts and Tidy labels.
   6. **The 19:** D01, D02, D03, D04 (Esc half), D08, D09, D11, D12, D14, D15, D16, D17, D18, D19, D20, D27, Recover Inverts, Tidy labels (switch ON only), CDSYNC keeps the schedule.
   7. **The 20th:** CDTWL freeboard counts once R14h x3 have two passes on 3.0.85. They have only run on 3.0.84 (`ledger.json`). The 28 Oct recount asked the desk to rule on this; CE 00 did (item 28).
   8. **On 3.0.85 itself:** 5 of the 19 hold on 3.0.84 only (D01, D03, D12, D18, Tidy labels) until the 12 owed cases run. That leaves 14 of 40 with two passes on the installed build.
4. **Tim-confirmed: official 17 of 40 (42.5%) in `PROGRESS.json` (countedAt 12:47). My count from the ledger: 19 of 40 (47.5%) whole, or 21 of 40 (52.5%) counting two half-checks.** The official figure is stale: H16 to H20 were written after 12:47.
   1. **Whole (19):** D01 (PIT and CD, H1, H2), D02 (H9b), D03 (H15), D06 (H20), D09 (H15), D10 (H15), D12 (H15), D14 (H5), D15 (H6), D16 (H4), D17 (H17), D20 (H14), D21 (H16), D24 (H16), D26 (H17), D29 (H17, Cancel only), D30 (H18), quick MOVE (H10), Recover Inverts (H3).
   2. **Part (2):** D19 (PIT half; the MOVE half was a grip stretch, H7) and D27 (warn-first passed; U not tried, H11).
   3. **Refused (2):** D08 (FO symbol reads "OF", H12, BUG-1236) and D05 (recent buttons not there, H16, BUG-1238).
   4. **Overlap of the two counts:** 11 tools are in both (D01, D02, D03, D09, D12, D14, D15, D16, D17, D20, Recover Inverts). 8 are Tim-only (D06, D10, D21, D24, D26, D29, D30, quick MOVE). 6 are Claude-only (D04, D08, D11, D18, CDSYNC keeps the schedule, Tidy labels). D19 and D27 are both, as halves.
5. **The differences between the three documents, and which one to use:**
   1. **`PROGRESS.json` (12:47):** Claude-accepted 19; Tim-confirmed 17. Use the 19. The 17 is behind the ledger.
   2. **`TESTED_NOT_TESTED_LIST_29OCT.md` (list A):** 21 tested, 12 in part, 5 not tested, on 38 lines. It counts anyone's test (robot, Codex or Tim) and counts PIT, CD and D01 as three lines. It rates D04 (Esc half) and Tidy labels (switch ON) as part, which CE 00's 19 counts whole. It is a different question from the official count, as the file itself says at the top.
   3. **Ledger item 28 (CE 00):** 19, the official count. Items 21 to 24 carried 16 and 18 on the way, depending on build and rule.
   4. **Ledger H17 and H20 (the hand-check text):** "19 tools or parts" at 13:15 and "21" after D06 and D30. This matches my 19 whole plus 2 half-checks.
   5. **`EVERYDAY_TOOLS_STATUS_29OCT.md` (11:20):** 19 accepted. Its estimate of 20 to 22 by Fri 30 Oct is its own and not a record.
6. **The official count is CE 00's:** Claude-accepted 19 of 40 (ledger item 28). The Tim-confirmed count has no ruling; use the ledger's 19 (21 with halves) until CE 00 refreshes `PROGRESS.json`.

### 4. The 60 pilot-critical bugs

(Source: `PILOT_CRITICAL_TEST_LIST_29OCT.md` of 10:55, the scoreboard section 3 of 13:19, `TESTED_NOT_TESTED_LIST_29OCT.md` list B, the build register. They agree.)

1. **Closed (Claude-accepted or Tim-confirmed): 0 of 60.** The bugs Tim confirmed today (BUG-1225, BUG-1222, BUG-665 ROTATE half) and the one Claude accepted on 28 Oct (BUG-460) are not on the list of 60 (not found in `PILOT_CRITICAL_TEST_LIST_29OCT.md`).
2. **Fix installed on Tim's PC, awaiting acceptance: 26 of 60 (43.3%).** Another 2 carry a fix but are not live in the normal sense: BUG-905 (installed, switched OFF; Tim ruled ON on 29 Oct, the default flip is B-033) and BUG-1173 (a document fix). So 28 of 60 (46.7%) have a fix of some kind. All 26 were checked by the pilot list in the installed source and git history, not in the DLL.
3. **Built, not installed: 5.** BUG-1189, BUG-1149, BUG-1090, BUG-1052, BUG-1053.
4. **No fix: 27.** Per the build register, B-016 to B-034 cover them; "none started at the last register read" (scoreboard section 3). B-017, B-019, B-020, B-033, B-034 are Tim's named freeze fixes. The triage splits the 27 into 11 build now, 6 build on a recommended answer, 2 needing Tim's ruling (BUG-685, BUG-1148), 7 facts to gather, 1 on the protected shared file (`PILOT_NOFIX_TRIAGE_29OCT.md`).
5. **Newer evidence since the list:** none. C-76 holds no pilot-critical bug (BUG-859, 372, 090, 1228 are not on the 60). The two draft robot cases, P01 (BUG-1194) and P02 (BUG-1140), have no rows in `ledger.json`: they have never run. Tested figure for the 60: 0 tested, 0 part, 60 not tested.
6. **Proof routes the list gives for the 28 with a fix built:** 18 need a new case (8 a test drawing or a reviewed runner change, 10 another PC or login or an older AutoCAD), 6 need a Codex look, 2 need Tim's word, 2 the robot can drive now (P01, P02). The engineering fixes (BUG-905, 1097, 1095, 1091, 1088) are proved by Codex looks H1, H7 and H8, not robot cases (BUILD_REGISTER, DESK_LOG 13:35).
7. **Two figures:** fix installed 26 of 60 (43.3%) / closed 0 of 60 (0%).

### 5. The wider bug side

1. **The 28 Oct recount had no bug section.** Its section 7, item 5 says bugs were "not recounted here". So there is no same-method 28 Oct figure to compare, and I did not invent one.
2. **The last counted figure is the 24 Oct triage** (`BUG_REGISTER_TRIAGE_2026-10-24.md`, 1,170 entries): 43 closed, 552 fix installed awaiting acceptance, 242 built not installed, 333 no fix. That method needed git ancestry over the installed lines and I did not repeat it. **Current totals: UNKNOWN.**
3. **What can be read as changed since 24 Oct:**
   1. **New entries:** the carpark has BUG-1240 as its highest number (1,220 on 24 Oct), about 20 new entries, none with a fix at filing.
   2. **Written FIXED, Claude-accepted, since 24 Oct:** BUG-711 and BUG-684, BUG-697, BUG-863 (25 Oct, Civil 3.0.75); BUG-460 (28 Oct, Civil 3.0.84, ledger item 20); BUG-1222 (29 Oct, Civil 3.0.85). Other earlier acceptances (ledger items 1 to 5) are not mapped to bug numbers here.
   3. **Tim-confirmed in his own AutoCAD (29 Oct):** BUG-1225 (DP after close and reopen), BUG-1222 (Edit Pipe second Save), BUG-665 (ROTATE Copy half; SCALE Copy not hand-tested, so the entry stays OPEN).
   4. **Installed since 24 Oct:** 14 trains (C-63 to C-75 and S-43 to S-45, QUEUE items 296 to 310), which raise the awaiting-acceptance count by an unknown amount.
   5. **Real faults proven and still open:** BUG-861 (REDO after a pit pick), BUG-859, BUG-372, and BUG-1223 (floor waste at an inspection opening; Tim's ruling open). BUG-859, 372 and 090 are fixed in the unshipped C-76. New bugs from Tim today: BUG-1228 (DP/PIT slow), 1231 (eight "not updated" lines), 1234, 1235, 1236, 1237, 1238, 1239.
4. **Closed / fix installed awaiting acceptance / built not installed / no fix:** UNKNOWN for today. Needs the 24 Oct method repeated; I recommend it as its own job.

---

## What I could NOT verify

1. **Nothing was run or opened in AutoCAD.** Every status comes from files. I read `runner-reports\ledger.json` (1,385 rows, last row 29 Oct 08:14), not the individual run `.md` reports.
2. **The 300 / 184 built figures are still the 18 Oct item count** carried forward. I have no item-by-item installed list. I confirmed only that C-75 and C-76 carry no UX plan ID.
3. **The five newly "tested" items are a judgement.** Three of them (UX-CPLAN-18, 19, 24) rest on a robot part plus a Codex look. Strictly the whole count is 14, not 17.
4. **The Tim-accepted mapping to plan items is mine.** No plan file records it. Some of Tim's passes were on one case only (ERASE with one pipe, EXPLODE with a pipe), and his CDRENUMBER "No" path result was not given.
5. **Clock mismatch in the ledger:** H20 and H21 (and some DESK_LOG lines) carry times of 14:00 to 14:15, but the PC clock read 13:22 when I started and the ledger file was last saved at 13:17. I took the content as written, as it stood at 13:17, and could not tell which times are right.
6. **The 12 owed cases may have run since 08:14.** `ledger.json` shows none, but the robot may have written elsewhere since. C-76 is expected to install this evening and would restart the clocks.
7. **The Tim-confirmed 19 of 40 comes from reading the ledger H entries** (the last edit 13:17). `PROGRESS.json` (12:47) says 17. The desk has not ruled between them.
8. **Not recounted:** the wider bug totals (group 5), open PRs, and switch defaults in Tim's settings file. Pilot-critical state for the 60 is from the files above and was not re-checked in source or the carpark entry by entry.
9. **Installed versions** were read by me from the nine DLL product-version strings today (Civil/Manager 3.0.85 / 1.1.85 at 09126560; Structural 1.0.125 at 204dfad2). The bundle folders also hold two add-on bundles (`CE.AutoCADLink.2027`, `CE.Transform.Trial.2027`) that I did not inspect.
10. **Tools used:** no helper agents; a short Python read of `ledger.json` and `BUG_CARPARK.md`; file reads only.
