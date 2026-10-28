# Runner case review, cx_cr24: N24, N27, N28, N29 and R12 (Codex independent review, Thu 29 Oct 2026)

Written about 10:15 Melbourne by Codex (GPT-6), the second, different-model reviewer. I compared cards, current cases, hashes, installed versions and recorded runs, then compared Opus verdicts. Rules, model reviews, gate and certificates were read first. No AutoCAD, runner, guard, build, install or test was run. Only this report is written; certificates remain untouched.

## FOR TIM

1. **Answer: 0 of these 5 cases is ready for its whole card.** All five prove useful parts and have two matching passes on today's Civil 3.0.85. None adds a whole everyday-tool item or permits a bug to be marked fixed.
2. **Renumbering needs more than the three staged checks.** They check every existing plan label after No and Undo, including X1. They still do not prove that other named marks are protected or that cancelling leaves a clean drawing unchanged.
3. **The drawing examples explain the gaps.** A pipe label left alone by Tidy labels has not been checked after its pit moves. A label travelling about 2 m has not necessarily travelled in the right direction. A schedule with only P and C pits cannot prove the order of LPD, OG and CP pits.
4. **The recorded passes are real evidence, not fresh testing by me.** I found no current-text main-case failure. The deliberate failures do catch their intended changes; N29's is the weaker kind that asks for the wrong order.
5. **No action from you is needed now.** The desk has exact next checks below. Engineering choices remain yours; label appearance and window layout still need a separate Codex look.

---

## ANSWER FIRST

1. **Counts:** CLAUDE-ACCEPTED-READY 0; NEEDS BROKEN VARIANT 0; NEEDS STRONGER ASSERTION 0 as main verdict; PARTIAL 5 (all five); NEEDS CODEX LOOK 0 as main verdict; FAIL = real fault 0; NEEDS RUNS 0 for current texts. Stronger checks and visual limits remain within the partial findings.
2. **Installed DLLs:** Legacy, Modern and Net8 agree for each of the three products (nine DLLs read). Civil `3.0.85+09126560f98acc4fd6ca4be298d087307a89a259`; Manager `1.1.85+09126560f98acc4fd6ca4be298d087307a89a259`; Structural `1.0.125+204dfad268caf967f3404d876648480a94efe1cd`.
3. **Install boundaries, Melbourne:** live Contents creation: Civil 29 Oct 00:21:11.891617; Manager 00:21:12.6643014; Structural 27 Oct 06:23:15.428689. Preserved .84 Civil/Manager Contents: 28 Oct 12:59:39; preserved Civil DLL `3.0.84+94f521cc75811785800faf436d7c259c26337569`. Preserved .83 Contents: 27 Oct 19:40:43, not the brief's approximate 19:39. These are filesystem creation times, not deployment start guesses. No acceptance depends on .83.
4. **Build keys:** every current pair has `civil 3.0.85+09126560 / struc 1.0.125+204dfad2 / mgr 1.1.85+09126560`; shortened suffixes match full DLL/report versions. Older R12 evidence has `civil 3.0.84+94f521cc / struc 1.0.125+204dfad2 / mgr 1.1.84+94f521cc`. Builds are never combined.
5. **Ledger/hash audit:** 1,385 rows read. All scoped rows joined to my SHA256 readings. Current-hash PASS rows: N24/N27/N28 each 3 (one .84, two .85); N29 2 (.85); R12 5 (one .83, two .84, two .85). Zero current-hash main FAILs. Excluded obsolete-text rows: R12 18, R12_NOU_BROKEN 2; no others in scope. Historical reds not used below add no acceptance.
6. **Counted current pairs:** exact session IDs, ledger `at` times and run intervals follow. Reports confirm separate AutoCAD starts. Successful-entry totals include records, not only assertions.
   1. **N24, 34 entries each:** `RUN-20261029-0048-C3.0.85-n3c4-s1` / `RUN-20261029-0149-C3.0.85-n3d4-s1`; rows 00:50:24 / 01:51:11; runs 00:48:29-00:50:24 / 01:49:39-01:51:11.
   2. **N27, 11 each:** `RUN-20261029-0113-C3.0.85-n3c7-s2` / `RUN-20261029-0211-C3.0.85-n3d7-s1`; rows 01:19:49 / 02:15:03; main sessions 01:16:34-01:19:49 / 02:11:31-02:15:03. n3c7-s1 is the OFF twin, not another main PASS.
   3. **N28, 22 each:** `RUN-20261029-0122-C3.0.85-n3c8-s1` / `RUN-20261029-0218-C3.0.85-n3d8-s1`; rows 01:28:11 / 02:21:49; runs 01:22:55-01:28:11 / 02:18:09-02:21:49.
   4. **N29, 6 each:** `RUN-20261029-0024-C3.0.85-n3c1-s1` / `RUN-20261029-0131-C3.0.85-n3d1-s1`; rows 00:29:35 / 01:34:03; runs 00:24:51-00:29:34 / 01:31:27-01:34:03. The first ledger write follows report finish by one second.
   5. **R12, 61 each:** `RUN-20261029-0519-C3.0.85-aX11-s1` / `RUN-20261029-0534-C3.0.85-bX11-s1`; rows 05:24:46 / 05:39:18; runs 05:19:37-05:24:46 / 05:34:33-05:39:18.
7. **No counted run straddles installation:** all current runs start after 29 Oct 00:21:12.6643014 and finish before this unchanged installed-build reading. No next install is evidenced. Older R12 pair `RUN-20261028-1310-C3.0.84-b6a2-s1` / `RUN-20261028-1418-C3.0.84-b6a3-s1` ran 28 Oct 13:10:29-13:25:29 / 14:18:49-14:34:09, between .84 and .85 installation; row times are their finish times.
8. **Counted reds:** every row below has its variant's current hash, correct variant_of and from_check=true; none is a crash/timeout red.
   1. **N24_BROKEN F4B89D4BCC01:** n3c4, 00:50:24. No U; check 1 sees the old P9 block become P8, check 2 fails its return to P9. True action red.
   2. **N27_BROKEN 4AEA9A01ACE2:** n3c7-s1, row 01:19:49, session 01:13:20-01:16:34. Hand-placement switch OFF, Tidy ON. The 5 mm move passes; checks 2/3 fail the left-alone count and read 275 mm rather than zero. True switch red, not D13's unchanged-settings profile A.
   3. **N28_BROKEN 249965280AC8:** n3c8, 01:28:11. Placement passes; check 2 sees 0 instead of BLOCKS after the twin sets CLAYER. Planted state red, not a CE fault.
   4. **N29_BROKEN 26D68459ECD6:** n3c1, 00:29:35. Only check 2 demanding P10 before P8 fails. Flipped red: correct data, deliberately wrong expectation.
   5. **R12 reds on .84, both b6a2/b6a3:** NOU_BROKEN D45A8DB6C011 fails return checks 1-8 at 1990.3, 1988, 2000, 2000, 1899.4, 1925.7, 1999.1, 1894.2 mm; WIN_BROKEN 9A781115FF94 fails check 2 with About CE Suite present; NOMOVE_BROKEN A2125BF348D9 fails eight movement checks at zero. True reds for unchanged checks; no .85 twin rows. Older flipped R12_BROKEN BE0D5C18E2A4 is not needed.
9. **Whole cards/gap items added, installed build / any build: 0 / 0.** This is this batch's contribution, not a global recount of 40.
   1. **D20 / section 2 item 20:** maps, clean No path and protected marks incomplete.
   2. **D13 / item 13:** pit move and profile A missing.
   3. **D24 / item 24:** object-layer assertions, labelled pit and layer-table record missing.
   4. **D21 / item 21:** LPD/OG/CP groups missing.
   5. **C41 / section 3 item 7 quick MOVE:** exact displacement and placement rules missing.
10. **Bug wording authorised: none.** No BUG/PROVES_BUGS claim appears. No entry may be written "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)" from this review; never close/delete entries (D6). Related BUG-816 remains unproved: R12 records the no-clear-spot line but never checks its approved setting behaviour. No new CE fault established.
11. **Certificates:** all five existing certificates match current hashes and pass the gate's text conditions. N24/N27/N28/N29 reviewer: `Opus-Team-B7-review`; R12: `Opus-Team-B6-review`. I agree with their limited parts, not whole-card acceptance. R12's file still names .84; newer .85 evidence is above. No certificate replaced, deleted or added.

## How I applied the four conditions

1. **Values, sessions and reds:** the named parts need no visual judgement; all five have two current-hash .85 PASS sessions and qualifying limited reds. No standing current-hash main FAIL exists. Any edited case needs two new sessions on its new hash.
2. **Whole coverage:** none meets its whole card. The gate checks the READY prefix, hash and reviewer, not the meaning of PART. Looks and engineering decisions remain separate.

## The cases

1. **N24: CDRENUMBER plan labels (D20, UX-CPLAN-18/19). Verdict: PARTIAL (part only: same-block renumbering and selected Cancel/Undo guards). Hash 323E733AB1AC.**
   1. **Card comparison:** D20 lines 593-603 ask every label before/after No/Yes/U, unchanged DBMOD on No, preview agreement and protected non-P marks. Case lines 25-42 read four maps; 44-48 check the preview and outcome; 55-67 check P9->P8, P10->P9 and P1-P7/C1 unchanged on Yes. Lines 52-54 and 69-71 check only P9/P10 and no P8 on No/U. DBMOD at 72-73 is only recorded. Thus the title's every-label promise is too broad.
   2. **Evidence:** both runs show 11 labels: P9=11A09A and P10=119F9A become P8 and P9 on the same blocks. C1=1090F6 and X1=10933E remain. The no-U twin proves a different block now called P9 cannot satisfy the handle-bound return check.
   3. **Exact missing lines, already present in the staged file:** append these to ASSERT, then mirror relevant new checks into discriminating variants:

      ```text
      matches $jn "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"
      matches $ju "\Whits\W+(\[.*?\}\])\}\}.*@@AFTER@@.*\Whits\W+\1\}\}"
      matches $jy "handle\W+([0-9A-F]{4,8})\W[^}]*PIT_LABEL=X1\W.*@@AFTER@@.*handle\W+\1\W[^}]*PIT_LABEL=X1\W"
      ```

   4. **Staged judgement:** the file under C:\ce-fx\c75fixups_staged\cases has SHA256 `7F2B7FA6380D21F57746A4E55617F74AA44941BEFB6059529A474C71F58D3DD9`. These three lines close the three current-fixture map omissions in text, comparing hits including order/name/layer but excluding timestamps. I did not execute them. Live remains 323E733AB1AC; staged has zero ledger rows. Its map/X1 checks have no run-proven twin; N24_BROKEN keeps its two old checks.
   5. **DBMOD remains:** add `equals $m1 $m0`. Both recorded values are 1; another edit can leave that dirty flag unchanged. A meaningful clean-copy guard needs an approved fixture opening at 0, `number $m0 = 0` and `equals $m1 $m0`. Do not add a save. The clean fixture is not supplied.
   6. **Protected marks remain:** STORMWATER PIT LABEL excludes the card's AGI/TG/WT marks. X1 is not a substitute. N15 checks some AGI/WT schedule text but no TG and only records DBMOD. Exact scope: `NOT_AUTOMATED D20 whole remains unproved: clean-copy No path, protected AGI TG WT marks and Tim-approved numbering order are not all checked.` Supply the missing fixture and handle-bound attribute comparisons; no TG handle or engineering order can honestly be invented here.
   7. **Opus comparison:** AGREE with B7 PARTIAL and same-handle reasoning. DISAGREE with "three lines to make D20 whole" and N24's "with N15 the whole card". Those repair the current label-map part only. Label appearance needs a Codex look; engineering order needs Tim.

2. **N27: hand-placed text left alone by Tidy labels (D13 profile B). Verdict: PARTIAL (part only: clashing start invert text held during Tidy, both switches ON). Hash D86FA0A8F939.**
   1. **Card comparison:** D13 lines 418-425 ask the pipe label moved 1000 mm by hand, the pit moved 500 mm, P2=P1 within 1 mm, the left-alone summary, profile A records and restored settings. Case 30-41 instead moves a start invert text 5 mm; 43-57 creates a clash and runs Tidy; 59-66 check one text, 5 mm, the summary, zero subsequent movement and unchanged count. There is no pit-move step, no pipe-description label route and no profile A.
   2. **Evidence:** both ON runs read 5 mm then 0 mm; the OFF twin reads 275 mm. ON prints Will move 0 and No CE label needs to move, then Unknown command YES. Apply was not exercised. Reports show zero settings fingerprint differences and clear guards; live settings were not read.
   3. **Exact correction to the current route:** replace line 49 with `type "CDTIDYLABELS{NL}All" -Force -> $tidy`; keep its existing esc-prompt after the read, as D13 asks. Replace the loose count substring with `matches $tidy "Placed by hand \(left alone\) 1(?![0-9])"`. Remove "even when told Yes" from the title/claim. These edits change the hash and need two fresh sessions.
   4. **Exact supplementary D13 route:** after a fresh SETUP-R47, resolve the description label and P8, then make the card's two moves. These are proposed lines, not executed checks:

      ```text
      select $new_all "text~ DIA\. " -> $d13lab0
      field $d13lab0 handle -> $d13lh
      select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $d13pit
      field $d13pit handle -> $d13ph
      pick-first $d13lh
      type "_.MOVE{NL}0,0{NL}0,1000" -Force -> $d13hand
      wait
      ms-new $n0 -> $d13afterhand
      select $d13afterhand "handle={$d13lh}" -> $d13lab1
      field $d13lab1 x -> $d13x1
      field $d13lab1 y -> $d13y1
      pick-first $d13ph
      type "_.MOVE{NL}0,0{NL}500,0" -Force -> $d13pitmove
      wait
      ms-new $n0 -> $d13afterpit
      select $d13afterpit "handle={$d13lh}" -> $d13lab2
      dist $d13lab2 "{$d13x1},{$d13y1}" -> $d13shift
      ```

   5. **Checks:** profile B adds `count $d13lab0 = 1`, `count $d13pit = 1`, `number $d13shift = 0 +- 1` and `record $d13pitmove "what the pit MOVE printed"`. Retain the separate designed-clash Tidy-summary route. Profile A repeats the card route without SETTING overrides, records `record $d13lab2 "pipe label after pit MOVE with office settings"` and history, and does not assert a hold. Retain settings-restoration evidence and add a pit-move red.
   6. **Opus comparison:** AGREE with partial hold evidence and the missing pit move. Shared source rules do not prove the unrun description-label route. DISAGREE with the twin header's "also profile A": Tidy is ON there; profile A changes no setting. The unrun pit route is unknown, not a new bug. N24's staged edits do not help. Label overlap/readability needs a look.

3. **N28: current layer after PIT/CD endings (D24). Verdict: PARTIAL (part only: five completed paths keep BLOCKS; nothing new on 0/BLOCKS). Hash C7EFA22D70C4.**
   1. **Card comparison:** D24 lines 704-710 ask a layer-table before/after record, a labelled pit, each object's office layer and CLAYER after each Esc route. Case 26-63 reads CLAYER after the five endings; 72-77 assert BLOCKS. Lines 65-68/81-84 check no objects on 0/BLOCKS and one pit/pipe. Line 93 merely records every object's layer. There is no placed PIT LABEL and no layer-table read.
   2. **Evidence:** BLOCKS six times in both runs; final layers STORMWATER PIT, STORMWATER PIPE, 25TEXT, 20TEXT, 20TEXT, ARROW; start/Cancel counts 1034. The planted twin detects 0. These are five completed routes, not every possible cancellation or CLAYER while busy.
   3. **Exact added per-object checks:** after line 69, add the following STEPS; then the listed ASSERT lines. They turn today's records into checks, rather than accepting an arbitrary non-zero layer.

      ```text
      field $pipes layer -All -> $pipe_layers
      select $new "text~^IL " -> $iltexts
      field $iltexts layer -All -> $il_layers
      select $new "text~ DIA\. " -> $pipe_labels
      field $pipe_labels layer -All -> $label_layers
      select $new name=TIM_CVL_ARROW -> $arrows
      field $arrows layer -All -> $arrow_layers
      ```

      ```text
      equals $pipe_layers "STORMWATER PIPE"
      count $iltexts = 2
      equals $il_layers "20TEXT | 20TEXT"
      count $pipe_labels = 1
      equals $label_layers "25TEXT"
      count $arrows = 1
      equals $arrow_layers "ARROW"
      ```

   4. **Remaining routes:** add a labelled-pit companion using N25's existing placement. Check `select $new "name~^PIT LABEL" -> $labels`, `field $labels layer -All -> $label_layers`, then `count $labels = 1` and `equals $label_layers "STORMWATER PIT LABEL"`. Record colour/linetype before/after for STORMWATER PIT, STORMWATER PIT LABEL, ARROW, 25TEXT and pipe layers. No implemented layer-table reader was found in the inspected vocabulary; README_V3 lists layer-read as unimplemented. Exact interim line: `NOT_AUTOMATED D24 layer-table colour and linetype before and after are not read; a labelled-pit companion and per-object layer assertions are still required.` The desk must supply the reader; do not invent a verb.
   5. **Opus comparison:** AGREE on current-layer coverage. DISAGREE that N06 asserts all object layers: it records pipe/IL/description layers; only pit/arrow are asserted. D24 assertion 3 requires a record, even though the card says never-recolour behaviour is unbuilt. N24 edits do not help. Colour appearance needs a look; product build status was not re-audited from source.

4. **N29: newly placed P8 in Pit Schedule order (D21). Verdict: PARTIAL (part only: P-number order and P before C1 after insertion). Hash 87FAE114D808.**
   1. **Card comparison:** D21 lines 621-629 ask newly placed pit names, natural P order and the LPD/OG/P/CP/rest group order. Assertion 4 at 630 explicitly excludes the switched-off P1A/SPS refinement. Case 22-38 places one pit and reads the schedule; 41-45 check placement, one new pit, the P1-P10/C1 sequence and Close. No LPD, OG or CP rows are exercised.
   2. **Evidence:** N24's baseline has P9/P10, no P8; N29's matched evidence has P7, new P8, P9, P10, C1. The card's no-P10 premise is wrong; placing one P8 is fair. A lexical P1,P10,P2 order fails the main pattern. The flipped twin fails its wrong P10-before-P8 expectation.
   3. **Exact next check with a supplied LPD/OG/CP fixture:** retain the P sequence and add `matches $rows "Pit LPD[^=]*= .*Pit OG[^=]*= .*Pit P1= .*Pit P10= .*Pit CP[^=]*= .*Pit C1="`. Add a twin whose unchanged assertion sees deliberately misordered groups. Appending this to today's fixture cannot supply the absent rows.
   4. **Scope:** `NOT_AUTOMATED D21 group order LPD OG P CP then other marks is not exercised; this fixture covers P before C1 only. P1A and SPS refinement remains NOT TESTED as the card specifies.` The refinement later needs a switched-on fixture; it is explicitly excluded from today's card.
   5. **Opus comparison:** AGREE with PARTIAL, the fixture correction and flipped red. The FULL rows record is actually truncated to 4003 characters and omits C1; check 3's matched evidence reaches C1 in both reports. That is the evidence used here. N24 edits do not supply missing groups. Drawn schedule/layout needs a look.

5. **R12: quick MOVE (C41, W1-02, gap-plan section 3 item 7). Verdict: PARTIAL (part only: no new window, eight texts move a non-zero distance, and monitored positions return after one U). Hash 58A9ACD407FB.**
   1. **Card comparison:** C41 lines 904-910 ask monitored handles, MOVE by 0,2000 within 0.001 drawing units, linked texts following documented placement rules, no new CE window, and one U restoring all monitored positions. Case 17-55 reads old positions; 56-83 moves and reads; 84-129 undoes and reads. Lines 153/156 compare complete window lists; 174-191 compare raw x/y returns within 0.001. The pit's MOVE at 152 is still only a coordinate-prefix pattern; eight text movements at 136/139/140/145-147/161-162 check distance 2000 +/-150 mm, not direction or a documented rule.
   2. **Asks met:** all four missing IL movements are now assertions; pit, label, cover and six IL returns use raw x/y within 0.001; NOMOVE_BROKEN exists. B2/B2FIX/B3B and cx_cr21 omission/Undo asks are met. Both .85 reports read labels 2000 mm and ILs 1894.2, 1899.4, 1925.7, 1988, 1990.3, 1999.1 mm.
   3. **Exact pit-displacement fix:** after line 71's `ms-new 0 -> $z1`, add the reads below and append the assertions. The existing old-y read is also pinned to the fixture value, making the constant new-y expectation explicit.

      ```text
      select $z1 "handle=109D56" -> $pit_moved
      field $pit_moved x -> $pit_x1
      field $pit_moved y -> $pit_y1
      ```

      ```text
      number $pit_y0 = -25569.87543006733 +- 0.001
      number $pit_x1 = $pit_x0 +- 0.001
      number $pit_y1 = -23569.87543006733 +- 0.001
      ```

   4. **Placement contract missing:** a 2 m movement south can satisfy distance alone. Add `NOT_AUTOMATED C41 linked-text placement rules and movement direction are not proved by the 2000 mm plus or minus 150 mm distance checks.` The desk must supply each handle's approved target/offset rule, then x/y checks and a wrong-direction twin. Distances cannot supply honest exact targets for six IL texts; an observed-pass tolerance is not a drafting rule.
   5. **Red limit:** NOU_BROKEN uses rounded distances within 0.5 mm, not the new raw 0.001 mm comparisons. Copy the raw-field checks into it. NOMOVE catches zero movement, not direction; WIN catches a real extra CE window.
   6. **Opus comparison:** AGREE with B6's partial/displacement findings. Its .84 evidence is now supplemented by .85, not a past error. DISAGREE with any "pipes together" acceptance: endpoints and the P3->P2 description label printing no-clear-spot are not read among these eight texts. Monitored returns are sound; whole linked geometry is not proved. Appearance/overlap needs a look. N24 edits do not help.

## Things the desk should know first (RULES 6.2)

1. **Certificates are partial.** All five say READY for PART; the gate does not interpret scope. They are not five whole accepted tools.
2. **Corrections:** B7's three-line N24 cure is not whole D20. N27's ON route never applied Yes; its OFF twin is not default profile A. B7 overstates N06's per-object layer assertions. Exact reasons/lines are above.
3. **Stale evidence:** B7's no-.85-runs note for N15/N06 is now superseded: current-hash aX3-s1/bX3-s1 and aX2-s1/bX2-s1 rows exist. I do not count these neighbours as accepted. N24/N27/N28 have .84 passes, contradicting the brief's first-written-on-.85 claim. NOT RUN YET headers are stale; cosmetic edits would invalidate hashes.
4. **Records:** successful totals include records. N29's FULL record is truncated; check 3's matched evidence supplies C1.
5. **Setup gap:** N27 and twin use SETUP-R47, SHA256 `0CB83BDF78538F247ADEF2B37DF755B2370A2830F368C1D01E90BB211FD71C07`, last written 24 Oct 11:52:43. Reports show setup steps, but the ledger/review gate binds only the case. A setup edit can change N27 without invalidating its certificate. Modification time is not a recorded hash. The other four cases/twins name no SETUP.

## What I read

1. **Authority/method:** RULES and its amendment, ROUTER, plan entry material, the 24 Oct decision; B3FIX/B3B model reviews in full; Get-CaseIndependentReview 116-126; R16 format example and five existing certificates.
2. **History:** searched all RUNNER_CASE_REVIEW_*.md for all five IDs. Read R12 sections in R11_R20, B2, B2FIX, B3B and B3FIX references; no scoped N-case sections occur in that filename family. Searched Opus B2/B6/B7/B8; read applicable sections, especially B7 cases 2/5/6/7, B6 case 1, B2 N15, and cx_cr21 R12. A report named N27 is not case N27.
3. **Contracts/files:** D13 407-428, D20 582-606, D21 610-633, D24 690-713; C41 896-913; gap section 2 items 13/20/21/24 and section 3 item 7; BUG-816 650-662. Five cases, eight variants, SETUP-R47, relevant N06/N15/N25 text, staged N24 and its report.
4. **Evidence:** all scoped ledger rows; JSON assertions/relevant steps and Markdown records for n3c4/n3d4, n3c7/n3d7, n3c8/n3d8, n3c1/n3d1, aX11/bX11, b6a2/b6a3. Full IDs above. Nine DLL versions, live/backup Contents metadata; select/field/dist/number/matches and ent-find source as text. Every scoped hash was computed independently; prefixes above, setup/staged full hashes recorded.

## What I did NOT check

1. **No execution or look:** no AutoCAD, runner, driver, case, guard, lock, install, build or test, including offline case/regex tests; no screenshots viewed. Proposed lines are text review only.
2. **No wider acceptance:** no engineering decisions, label appearance, pipe endpoints or drawn schedule accepted. No missing reader/fixture built. Neighbours were inspected for specific claims, not re-reviewed for acceptance.
3. **No live-state proof:** restoration evidence is from saved reports. Live settings/drawings were not opened. Historical loaded DLL bytes cannot be recovered from today's files; report headers and install boundaries are used.
4. **Writes:** only this report. No ledger, case, variant, setup, certificate, settings, BUG_CARPARK, DESK_LOG or QUEUE changes. No bug marked fixed.

## Files written

1. **Report only:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr24.md. No review certificate is created or replaced. The report can be undone by reverting its named commit; the evidence files are unchanged.

## Summary

All five cases remain PARTIAL despite two matching PASS sessions on installed Civil 3.0.85. No whole daily-tool item or bug fix is added. N24's staged checks repair the current label-map gaps, not whole D20. N27 omits the pit move and true default profile; N28 omits layer assertions and records; N29 lacks other pit groups; R12 lacks precise displacement and documented label-placement rules. Existing Opus certificates remain untouched. Only this report is written; no AutoCAD or tests were run.