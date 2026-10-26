# Runner case review, cx_cr15: R15, R16 and R17 (Codex independent review, Mon 26 Oct 2026)

Written Mon 26 Oct 2026, about 17:55 Melbourne, by Codex (GPT-6). I read the rules, acceptance decision, both model reviews in full, relevant earlier sections, cards, bugs, installed versions, cases, variants, setup, ledger and selected reports. I ran no AutoCAD, runner, driver, case, guard, build, install or test. Only this report and R15/R16 review files are written; only this report is committed and pushed.

## FOR TIM

1. **None of these three cases is accepted on installed Civil 3.0.79.** Recover Inverts and Tidy labels have sound narrow checks and two passes on 3.0.78. Each needs two separate AutoCAD starts on 3.0.79.
2. **R17 covers part of its card.** Esc left no extra objects by the checks used; Enter made one pipe. It never reads the required two vertices: on a job, an unwanted bend could pass unnoticed.
3. **No bug gets a new fixed claim.** Recover Inverts prints the expected totals, but this case does not prove missing invert text is redrawn. Tidy labels is proved only with its switch on.
4. **The morning figures are out of date.** Civil 3.0.79 and Manager 1.1.79 arrived about 16:58 today. The later 3.0.78 passes are historical evidence, not proof of this newer install.

---

## ANSWER FIRST

1. **Counts: one main verdict per case, three cases.**
   1. **CLAUDE-ACCEPTED-READY on installed build: 0.**
   2. **NEEDS RUNS: 2.** R15 and R16: zero passing sessions on Civil 3.0.79+d3f9c5df; each needs two.
   3. **PARTIAL (part only): 1.** R17: cancellation wording, no New Pipe window, unchanged count/no appended objects, one cancelled outcome, and one pipe after Enter. Whole D04 is not accepted.
   4. **NEEDS BROKEN VARIANT: 0. NEEDS STRONGER ASSERTION as main verdict: 0. NEEDS CODEX LOOK as main verdict: 0. FAIL = real fault: 0.** R17's missing assertions sit under PARTIAL.
   5. **Older-build text exception: 2 CLAUDE-ACCEPTED-READY texts.** R15 for C38's totals and R16 for C37's named preview, on Civil 3.0.78 only. The brief permits these review files with an older-build qualification. They add nothing to installed-build acceptance.

2. **Build and install checks, read from disk.**
   1. **Civil:** Legacy, Modern and Net8 each report ProductVersion 3.0.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Bundle Contents created **26 Oct 16:57:58.752 Melbourne**.
   2. **Manager:** all three lanes report 1.1.79+d3f9c5dfc6241815d587f335a7ae49ca603c58fa. Contents created **26 Oct 16:57:59.828**.
   3. **Structural:** all three lanes report 1.0.124+3a3caac5db7687f1b5d1a6e09571976c52b2b05a. Contents created **25 Oct 17:41:13.577**.
   4. **Installed ledger key:** civil 3.0.79+d3f9c5df / struc 1.0.124+3a3caac5 / mgr 1.1.79+d3f9c5df. The runner shortens commits to eight characters; I compared that form with the full DLL strings. These cases have no rows on this key.
   5. **Previous installs read from retained Contents and DLL versions:** Civil 3.0.72+f7f7d551: 23 Oct 18:27:04.196; 3.0.73+5467f705: 24 Oct 11:35:55.809; 3.0.75+2c805a39: 25 Oct 03:33:02.026; 3.0.77+0d885094: 25 Oct 20:42:01.593; 3.0.78+d8840a09: 26 Oct 05:41:30.579. Manager backup versions match; 1.1.78 Contents created 05:41:31.142. The intervening a15b414c backup Contents was created 24 Oct 17:19:58.
   6. **Counted pass window:** all six 3.0.78 reports start between **26 Oct 10:58:05 and 12:27:22**, finish between **11:03:05 and 12:30:47**. Every selected ledger 'at' is after the 05:41 install and before the 16:58 replacement. Structural 1.0.124 was already installed. No selected run straddles an install.
   7. **Counted red windows:** R15_BROKEN ran 24 Oct 06:39:47-06:48:45; R17_BROKEN 05:57:55-06:04:14. Both fit the 3.0.72 interval, 23 Oct 18:27 to 24 Oct 11:35. R16_BROKEN ran 24 Oct 15:06:07-15:21:40; R16_OFF_BROKEN 16:05:08-16:10:17. Both fit 3.0.73's interval, 24 Oct 11:35 to 17:19. Structural 1.0.123 arrived 24 Oct 12:42:11, between these red groups.
   8. **Precision:** Contents creation provides independently read install boundaries, not exact copy-completion times. Selected runs are well away from boundaries. Report headers do not independently prove which DLL AutoCAD loaded.

3. **Ledger checks and selected pairs.**
   1. **Snapshot:** 602 rows, SHA-256 EEA8271E660142E1F11F2EF19253B7893363DD0AA19A81B91EF89D754B0C027E, read about 17:49. All relevant rows were read; current-hash inventory follows below.
   2. **R15:** 12 main-case rows; 10 current-hash PASS rows, 2 obsolete rows excluded. Two current-hash passes each on 3.0.72, .73, .75, .77 and .78. Current-hash FAIL rows: 0.
   3. **R16:** 12 main-case rows; 8 current-hash PASS rows, 4 obsolete rows excluded. Two current-hash passes each on 3.0.73, .75, .77 and .78. Current-hash FAIL rows: 0.
   4. **R17:** 12 main-case rows; 8 current-hash PASS rows, 4 obsolete rows excluded. Two current-hash passes each on 3.0.73, .75, .77 and .78. Current-hash FAIL rows: 0. PASS cannot fill a missing assertion.
   5. **R15 pair counted:** RUN-20261026-1130-C3.0.78-g78a8-s1 and RUN-20261026-1224-C3.0.78-g78b8-s1.
   6. **R16 pair counted:** RUN-20261026-1133-C3.0.78-g78a9-s1 and RUN-20261026-1227-C3.0.78-g78b9-s1.
   7. **R17 pair, checked part only:** RUN-20261026-1058-C3.0.78-g78a2-s1 and RUN-20261026-1149-C3.0.78-g78b2-s1.
   8. **Identical build key:** civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09. Each pair has different session IDs/runs; reports record clean ends and zero AutoCAD processes left. No standing current-hash FAIL was found.
   9. **Reds:** R15_BROKEN flips 26 recovered to 27; R17_BROKEN expects New Pipe after Esc; R16_BROKEN flips P8 to P9. These are weaker flipped reds. R16_OFF_BROKEN genuinely disables the preview; eight checks fail on the switched-off result. Selected reds have current variant hashes, correct variant_of, FAIL and from_check=true, with failed assertions rather than crashes/timeouts.
   10. **Setup binding:** R15/R16 and their variants use SETUP-R47; R17 and its variant have no SETUP. The 22 current executable setup lines exactly match the recorded sequence in all four selected R15/R16 pass reports; every setup step reported success.
   11. **Review gate:** case_runner.ps1 lines 116-126 require the READY prefix, matching case hash and non-builder REVIEWER line. They do not bind setup hash or inspect review build wording. A case REVIEWED_AGAINST line alone does not count.
   12. **Pack limit:** the four setup-using pass reports share wider pack hash DA974F414C9B77E5AF6B1A23300DBF9C95B857404CD760A75D2BC074DACE95CC. This is not just one case plus SETUP-R47; FullPackFiles can include unselected cases. I did not reconstruct that wider pack. Exact recorded setup steps, current hash and modification time are the evidence used here.
   13. **Settings:** selected R15/R16 reports show equal start/end fingerprints. This is recorded evidence; no guard was operated by me.

4. **Daily cards and gap-plan items: this three-case contribution only.**
   1. **Installed Civil 3.0.79: 0 whole gap-plan items; 0 D-number cards.**
   2. **Any build: Recover Inverts, C38's recorded totals, accepted on 3.0.78.** One whole narrow named check.
   3. **Any build: Tidy labels names the pipe, C37's preview wording with switch ON, accepted on 3.0.78.** One whole narrow named check.
   4. **Any build total: 2 whole named checks; 0 whole D-number cards.** D04 is partial. Do not count R17 again as generic CD.
   5. **Denominator:** gap plan section 3 item 7 says 40 but lists eight named checks plus the 30 in section 2: 38 entries. I retain its stated denominator and invent no missing items. This is not a release-wide recount.

5. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.79+d3f9c5df, 26 Oct 2026)": none.**
   1. **BUG-856:** already FIXED (Codex-accepted, Civil 3.0.67, 21 Oct 2026). Suggested evidence note only: "R16 independently reviewed for C37 preview wording; PASS g78a9/g78b9 on Civil 3.0.78, true switch-off red f12 on 3.0.73; two sessions still needed on installed 3.0.79." Do not replace earlier acceptance.
   2. **BUG-820:** only its totals-line half is Codex-accepted on 3.0.64. R15 does not assert "21 already had invert text" or corrected comma spacing. Whether CE should redraw one missing end remains Tim's question.
   3. **BUG-789:** OPEN; R15 neither erases IL texts nor exercises locked-layer exclusion. Its output says zero invert texts written. No redraw acceptance.
   4. **R17:** no bug claim. All three cases have empty BUG lines and no PROVES_BUGS lines; R16 names BUG-856 in PLAN_ITEM. They do not establish the whole command-outcome BUG-862.
   5. **D6:** never close or delete a bug entry. No status was changed.

## How I applied the four conditions

1. **Nothing seen:** C37/C38 concern printed words, counts and outcomes. They do not accept label appearance or placement. R17's missing geometry is measurable in principle.
2. **Two sessions:** selected pairs are on older 3.0.78; zero on installed 3.0.79.
3. **Red before green:** failed check lines were inspected in JSON and Markdown. Flipped expectations are separated from the genuine switch-off red.
4. **Card and full coverage:** C37 lines 808-829, C38 lines 833-849 and D04 lines 178-199 were compared with the cases. Narrow C37/C38 outputs are covered; whole D04 is not.

## The cases

1. **R15: Recover Inverts totals (C38).** Verdict: **NEEDS RUNS** on installed 3.0.79. Hash **6626D75574C6**. Secondary text verdict: **CLAUDE-ACCEPTED-READY** for C38's recorded totals on older 3.0.78. Review file replaced under the brief's exception.
   1. **Asks met:** earlier reviews accepted C38's assertions and requested reruns after installs. The 3.0.78 pair meets that historical request; 3.0.79 needs two more sessions.
   2. **Card lines:** C38 assertion 1 (844) maps to case line 21: 50 pipes, 26 with stored inverts. Assertion 2 (845) maps to lines 22-24: 26 recovered, 24 skipped, 5 with only one text. Assertion 3 (846) maps to line 25: exactly one completed outcome. Both selected reports pass all five checks; line 26 records only.
   3. **Preparation difference:** C38 references all C37 setup steps and its Tidy switch. SETUP-R47 moves P3 and places P8 plus a pipe; R15 omits the initial Tidy call, obstruction move/zoom and Tidy setting. These prepare Tidy preview rather than recovery totals. Selected reports directly establish C38's expected totals on this stated preparation; it is not every historical preparation step.
   4. **Red:** RUN-20261024-0639-C3.0.72-p3b1run1C, R15_BROKEN check 1: contains $rec "27 pipes recovered" fails against 26. Current variant hash, weaker flipped red. It predates the current setup edit; it proves the wrong total fails, not today's setup bytes.
   5. **Exact next action:** no mandatory new case line for C38. Run this unchanged case and hashed SETUP-R47 in **two separate sessions on Civil 3.0.79+d3f9c5df**, after 26 Oct 16:58. Older-build runs cannot fill that gap.
   6. **Optional BUG-820 improvement:** after line 24 add: history has "26 pipes recovered, 0 invert texts written, 21 already had invert text, 24 skipped". Then give the changed hash two passes and a matching intended red. This still does not decide missing-end behaviour.
   7. **Codex look / Tim:** no look needed for printed totals. Actual redraw/placement is outside C38. Engineering or intended-behaviour choices remain Tim's.

2. **R16: Tidy labels names the pipe (C37; BUG-856 wording guard).** Verdict: **NEEDS RUNS** on installed 3.0.79. Hash **92E250C4F0FC**. Secondary text verdict: **CLAUDE-ACCEPTED-READY** for C37 on older 3.0.78, switch ON. Review file replaced.
   1. **Asks met:** case lines 38-41 contain all four requested additions: hand-placed count, no-clear count, named P3 -> P2 line and SPOT LEVEL check. Both requested reds exist.
   2. **Card lines:** C37 assertion 1 (824) maps to case lines 36-37; assertion 2 (825) to 35 and 38-40; assertion 3 (826) to 43 and 46. All 12 checks pass in both selected reports: P8, 275 mm, summary 1/0/1, cancellation words and one cancelled outcome.
   3. **Recipe detail:** C37 step 2's initial no-move Tidy call is omitted; the final named no-clear line is asserted. Step 5 wrongly calls 10EC5D newly placed: the case reads that existing fixture SPOT LEVEL before moving it and places no such block. The earlier review identified the same card error.
   4. **Reds:** f5 check 2 fails P9 against actual P8. Broad regex check 3 still passes. f12 fails eight preview/message checks because Tidy is switched off, including the exact P8 line; the cancelled outcome still passes. It proves preview gating, not unique preview-cancellation behaviour.
   5. **Weak check, covered by stronger one:** line 37's regex spans the P3 -> P2 and P8 lines. Keep the exact full P8 line at 36; it guards BUG-856. Count equality 1040=1040 cannot prove unchanged positions. C37 assertion 3 asks for the printed cancellation result, which is covered; no geometry acceptance is inferred.
   6. **Exact next action:** no mandatory text addition for narrow C37. Two sessions of this current hash/setup on installed Civil 3.0.79, including existing line 10: SETTING CD_Settings.json linking.tidyLabelsEnabled true.
   7. **Current setting fact:** actual CD_Settings.json has no linking.tidyLabelsEnabled member; hash ACD64E79A33BE9C152149FF2145A3CD2C29CABE11245F211183FD5C7DE783140. The historical OFF variant used that fingerprint. I have not established 3.0.79's loaded default, so "OFF today" is not proved by absence.
   8. **Stale text:** lines 15, 19 and 20 say checks are absent/record-only; lines 38-41 now assert them. Correct at the next case edit; even a comment change invalidates prior hashes.
   9. **Codex look:** Apply/Yes, actual label positions, readable spacing and U/REDO after applying remain outside this wording card. A 275 mm regression baseline is not engineering approval.

3. **R17: CD Esc at the third point (D04; UX-PIPE-03).** Verdict: **PARTIAL (part only: cancellation words, no New Pipe window, count/no-appended-object guard, and one pipe after Enter)**. Hash **E252738D9455**. No review file written; existing review left untouched.
   1. **Asks met:** Enter placement is lines 26-33; exactly one pipe is asserted at 41. Requested zero-new-object check is at 38; TIMEOUT is 900. Two 3.0.78 sessions passed these checks.
   2. **D04 lines 194-195:** case 35-39 gives the cancellation sentence, no New Pipe, count 1034 before/after, zero objects from index 1034 onwards and one cancelled outcome. Enter produces one CeCvlPipeObject, three MText objects and an arrow block.
   3. **Gap 1, D04 line 196:** "one pipe with two vertices". Case line 41 counts pipes only. Library line 227 reads a bounding-box corner for CeCvlPipeObject, not vertices. Two typed input points do not prove the generated pipe has only two vertices.
   4. **Exact addition contract:** after case line 33 add: pipe-vertices $pipe_new -> $vertices_c. In ASSERT add: count $vertices_c = 2. **pipe-vertices is a proposed new read-only verb, not supported today.** The runner owner must implement/review actual ordered vertex reads, failing closed if unreadable; never manufacture vertices from input or a bounding box.
   5. **Required geometry red:** place a pipe using three non-collinear points, then use the same count $vertices_c = 2 check. It must fail with actual count 3. The old Esc/window red does not exercise Enter geometry.
   6. **Gap 2, exact H1=H0 at D04 line 194:** case 37 compares only counts; ms-new starts at the old count. Replacing an existing object while retaining count 1034 would evade both. Add complete handle reads using today's syntax.
   7. **Before line 18:** ms-new 0 -> $h0a; ms-new 500 -> $h0b; ms-new 1000 -> $h0c. Then field $h0a handle -All -> $ha0; field $h0b handle -All -> $hb0; field $h0c handle -All -> $hc0. Each semicolon separates proposed case lines; write each on its own line.
   8. **After Esc and before Enter:** repeat those six lines with h1a/h1b/h1c and ha1/hb1/hc1. ASSERT equals $ha1 $ha0; equals $hb1 $hb0; equals $hc1 $hc0, each on its own line. Three 500-item reads cover this 1034-object fixture; extend if a later fixture exceeds 1500. A deliberate replacement at unchanged count must fail.
   9. **Then:** two new sessions of the changed case on installed 3.0.79 and the new intended reds. There are zero 3.0.79 sessions even for the old text.
   10. **Existing red:** RUN-20261024-0557-C3.0.72-p3b1run1A, R17_BROKEN check 1, contains $win_a "New Pipe", fails because no window exists. Correct weaker flipped red for the window check only.
   11. **Stale text/review:** line 11 says the contrast pipe is not drawn; that is now false. The old review still matches this hash and says READY on 3.0.73. I disagree with full D04 acceptance; the gate can still accept that file. Its presence is not this review's approval.
   12. **Codex look:** no appearance judged. Missing vertex/handle measurements are deterministic gaps; do not substitute a visual verdict.

## Things the desk should know first (RULES 6.2)

1. **Morning leads are stale:** current-hash main PASS rows are now 10/8/8 for R15/R16/R17. Each gained two 3.0.78 sessions. Installed Civil is 3.0.79.
2. **B2's R17 reasoning is too strong:** "a third vertex cannot arise" from two supplied points is an inference, not an output check. B2FIX/B3FIX/B3B carried full D04 acceptance forward; this review counts only the checked part.
3. **The runner's READY line is not a fresh coverage decision.** Latest R17 reports print it because an older matching review exists. The gate does not inspect the card.
4. **Setup hashes matter:** SETUP-R47 was last written 24 Oct 11:52:43, after R15's original 3.0.72 pair. Old case hashes cannot establish current setup text. The four selected 3.0.78 reports match all 22 executable setup lines.
5. **R16 default:** absent key and historical OFF evidence do not prove the installed 3.0.79 loaded default. Acceptance is switch ON only.
6. **R15 scope:** C38 is the recorded totals check. BUG-789 also requires locked-layer exclusion; erase-both-texts alone would still not cover that whole bug. BUG-820's missing-end choice remains Tim's.

## What I read

1. **Authority:** RULES.md and acceptance decision in full; ROUTER.md; START_HERE/MASTER_PLAN context; B3FIX/B3B in full; every R15/R16/R17 match and relevant section in RUNNER_CASE_REVIEW_*.md, including R11_R20, B2, HARDEN, B3 and B2FIX.
2. **Contracts:** C37/C38, D04, gap plan 3.7 and its 30-item list, BUG-856/820/789.
3. **Local files:** three cases, four variants, SETUP-R47, three existing reviews; review gate, pack-hash logic, model-space reader and field syntax. No script loaded or invoked.
4. **Reports:** JSON and Markdown check sections of g78a8/g78b8, g78a9/g78b9, g78a2/g78b2, p3b1run1C, p3b1run1A, f5 and f12. All relevant ledger rows inspected.
5. **Installation/settings:** all nine current DLL version resources; current/named backup Contents timestamps; selected backup versions; actual CD settings linking members/hash.
6. **Publishing:** CE_PLAN branch/status, configured hook and TimOS leak-scan skill. Another job's staged report and other uncommitted files are excluded from this commit.

## What I did NOT check

1. **No execution:** no AutoCAD, runner, case, driver, lock, guard, build, install, test or subagent.
2. **No appearance/engineering acceptance:** no picture, window, label position or preview looked at; no council value, design rule or sizing choice approved.
3. **No wider feature acceptance:** no missing-IL redraw, locked-layer recovery exclusion, Tidy Apply/U/REDO, or output pipe vertex measurement.
4. **Historical limits:** old ledger rows are inventoried, not every old full report re-audited. No wider pack hash reconstructed; no independent loaded-DLL measurement.
5. **Protected files:** cases, variants, setups, settings, ledgers, run reports, BUG_CARPARK, DESK_LOG and QUEUE were not edited. R17's old review remains despite the disagreement.

## Files written

1. **Report:** C:\CE_PLAN\areas\CODEX_CASE_REVIEW_cx_cr15.md.
2. **R15 review:** C:\Lisp Files\_ACAD_DRIVER\cases\R15_recover_inverts_totals.review.txt, older-build qualification.
3. **R16 review:** C:\Lisp Files\_ACAD_DRIVER\cases\R16_tidy_labels_names_the_pipe.review.txt, older-build/switch-on qualifications.

## Hashes and row inventory

Full hashes are computed with Get-FileHash -Algorithm SHA256. Historical rows are inventory, not additional acceptance pairs. Only the selected 3.0.78 pairs and named reds support this review.


1. **R15_recover_inverts_totals.case.txt:** 6626D75574C6B81E6147C1962A618154B354412D9C11E85E343B766480DE9B9D
2. **R16_tidy_labels_names_the_pipe.case.txt:** 92E250C4F0FC2FA67B2142966ED845B2C62CFABB7E2483B30B46D3EA0A935218
3. **R17_cd_esc_at_third_point.case.txt:** E252738D9455E7E90F0D12E8A301A92841D72532E1D6C024AEE67F0DE6F62F87
4. **R15_broken.case.txt:** C287A88ED7BF72E3251384E872797A624307A3B580C3A3ED1371EF1F9CDF2AA5
5. **R16_broken.case.txt:** 04DA332F3DB48EE01CBA2D335CD8741B0E9E67FE281407B1B4C74E4BDEFAD134
6. **R16_off_broken.case.txt:** 54B33C7AD833B85A5E51279763FEBDA4D1A666D35D7D485506ADD19DB278D651
7. **R17_broken.case.txt:** 0E7EB3448105B27A8172E8ECB5E8D697BD87AA4CF640C505D278379E0E97AFA3
8. **SETUP-R47.setup.txt:** 0CB83BDF78538F247ADEF2B37DF755B2370A2830F368C1D01E90BB211FD71C07

### Current-hash ledger rows

1. **R17_BROKEN FAIL:** session RUN-20261024-0557-C3.0.72-p3b1run1A-s1; at 2026-10-24 06:04:14 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of='R17'; from_check=True.
2. **R15_BROKEN FAIL:** session RUN-20261024-0639-C3.0.72-p3b1run1C-s1; at 2026-10-24 06:48:45 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of='R15'; from_check=True.
3. **R17_BROKEN FAIL:** session RUN-20261024-0728-C3.0.72-p3b1run2A-s1; at 2026-10-24 07:35:36 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of='R17'; from_check=True.
4. **R15_BROKEN FAIL:** session RUN-20261024-0735-C3.0.72-p3b1run2C-s1; at 2026-10-24 07:43:56 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of='R15'; from_check=True.
5. **R15 PASS:** session RUN-20261024-0812-C3.0.72-p3b1run3C-s1; at 2026-10-24 08:19:14 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of=''; from_check=False.
6. **R15 PASS:** session RUN-20261024-0838-C3.0.72-p3b1run4C-s1; at 2026-10-24 08:45:53 Melbourne; civil 3.0.72+f7f7d551 / struc 1.0.122+e6d597c0 / mgr 1.1.72+f7f7d551; current hash equals file; variant_of=''; from_check=False.
7. **R17 PASS:** session RUN-20261024-1500-C3.0.73-f4-s1; at 2026-10-24 15:06:03 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
8. **R16 PASS:** session RUN-20261024-1506-C3.0.73-f5-s1; at 2026-10-24 15:21:40 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
9. **R16_BROKEN FAIL:** session RUN-20261024-1506-C3.0.73-f5-s1; at 2026-10-24 15:21:40 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of='R16'; from_check=True.
10. **R17 PASS:** session RUN-20261024-1521-C3.0.73-f6-s1; at 2026-10-24 15:30:04 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
11. **R16 PASS:** session RUN-20261024-1530-C3.0.73-f7-s1; at 2026-10-24 15:37:39 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
12. **R16_OFF_BROKEN FAIL:** session RUN-20261024-1605-C3.0.73-f12-s1; at 2026-10-24 16:10:17 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of='R16'; from_check=True.
13. **R15 PASS:** session RUN-20261024-1705-C3.0.73-r15a-s1; at 2026-10-24 17:10:36 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
14. **R15 PASS:** session RUN-20261024-1710-C3.0.73-r15b-s1; at 2026-10-24 17:14:56 Melbourne; civil 3.0.73+5467f705 / struc 1.0.123+4af3f37d / mgr 1.1.73+5467f705; current hash equals file; variant_of=''; from_check=False.
15. **R17 PASS:** session RUN-20261025-0807-C3.0.75-b2c1-s1; at 2026-10-25 08:12:57 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
16. **R15 PASS:** session RUN-20261025-0813-C3.0.75-b2a1-s1; at 2026-10-25 08:17:39 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
17. **R16 PASS:** session RUN-20261025-0817-C3.0.75-b2b1-s1; at 2026-10-25 08:23:11 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
18. **R17 PASS:** session RUN-20261025-0827-C3.0.75-b2c2-s1; at 2026-10-25 08:33:44 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
19. **R15 PASS:** session RUN-20261025-0833-C3.0.75-b2a2-s1; at 2026-10-25 08:39:11 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
20. **R16 PASS:** session RUN-20261025-0839-C3.0.75-b2b2-s1; at 2026-10-25 08:44:33 Melbourne; civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39; current hash equals file; variant_of=''; from_check=False.
21. **R17 PASS:** session RUN-20261025-2113-C3.0.77-g77a3-s1; at 2026-10-25 21:18:50 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
22. **R15 PASS:** session RUN-20261025-2202-C3.0.77-g77a9-s1; at 2026-10-25 22:06:52 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
23. **R16 PASS:** session RUN-20261025-2206-C3.0.77-g77a10-s1; at 2026-10-25 22:12:04 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
24. **R17 PASS:** session RUN-20261025-2215-C3.0.77-g77b3-s1; at 2026-10-25 22:21:02 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
25. **R15 PASS:** session RUN-20261025-2306-C3.0.77-g77b9-s1; at 2026-10-25 23:11:25 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
26. **R16 PASS:** session RUN-20261025-2311-C3.0.77-g77b10-s1; at 2026-10-25 23:16:38 Melbourne; civil 3.0.77+0d885094 / struc 1.0.124+3a3caac5 / mgr 1.1.77+0d885094; current hash equals file; variant_of=''; from_check=False.
27. **R17 PASS:** session RUN-20261026-1058-C3.0.78-g78a2-s1; at 2026-10-26 11:03:05 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.
28. **R15 PASS:** session RUN-20261026-1130-C3.0.78-g78a8-s1; at 2026-10-26 11:33:43 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.
29. **R16 PASS:** session RUN-20261026-1133-C3.0.78-g78a9-s1; at 2026-10-26 11:37:17 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.
30. **R17 PASS:** session RUN-20261026-1149-C3.0.78-g78b2-s1; at 2026-10-26 11:53:17 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.
31. **R15 PASS:** session RUN-20261026-1224-C3.0.78-g78b8-s1; at 2026-10-26 12:27:20 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.
32. **R16 PASS:** session RUN-20261026-1227-C3.0.78-g78b9-s1; at 2026-10-26 12:30:47 Melbourne; civil 3.0.78+d8840a09 / struc 1.0.124+3a3caac5 / mgr 1.1.78+d8840a09; current hash equals file; variant_of=''; from_check=False.

## Summary

Zero of these cases is accepted on installed Civil 3.0.79. R15 and R16 cover their narrow cards on older 3.0.78 and each needs two current-build sessions. Their review files state that limit. R17 is partial: it counts one pipe but never reads two vertices or compares all original handles after Esc. Its old review is untouched and must not override this finding. No bug gets a new fixed status. No AutoCAD, runner, build or test was run.