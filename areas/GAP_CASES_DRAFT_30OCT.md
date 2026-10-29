# Gap cases drafted after the five 3.0.86 proofs (Fri 30 Oct 2026)

Written Fri 30 Oct 2026, 07:51 to about 08:15 Melbourne (PC clock read with `date`), by the Team Opus job CE_ACAD / robot / draft / 31. Drafting only: no AutoCAD, no runner run, no driver call, no build. The only runner action was the offline format check, after I read its code and confirmed it only reads files.

## ANSWER FIRST

### FOR TIM

1. **Pit Schedule natural order (card D21): new case N40. The robot can drive it.**
   1. **What it proves:** six pits typed P10A, SPS10, P9A, P1B, SPS2, P1A, placed in that scrambled order. The schedule must read P1, P1A, P1B, P2 ... P9, P9A, P10, P10A, C1, SPS2, SPS10.
   2. **Why it is stronger than N34:** every row is checked in its place, with no other pit allowed between two neighbours. A plain text sort puts P10A above P1A and fails.
   3. **Its twin** has the switch off and must fail on four order checks while all six pits are still listed.
2. **CDCHECK wording after STRETCH and MOVE (BUG-372): new case N41. The robot can drive it.**
   1. **What it proves:** move pit P3 up 2 m, draw a new pipe, stretch its open end 2 m east, then type CDCHECK. No line may show a code such as "handle 1197BB" or "CE-CIV-PIPE-...".
   2. **New ground:** the open pipe end line ("one end is not connected") is now reached. Your original drawing for R22 never had one.
   3. **Not judged:** the old "(on the block Drawing Border)" wording. The fix never touched it, so it is only recorded.
3. **Double-click on a downpipe (BUG-859): three new cases.**
   1. **N42, robot can drive it:** double-click DP1's red centre, then its angled DP text. Each time CE's Edit source window must open with DP1, and AutoCAD's attribute editor must never appear.
   2. **N42g, robot can drive it, meant to fail today:** the green DP label still opens AutoCAD's text editor. That is BUG-860, which has no fix yet.
   3. **N42s, needs a robot permission first:** type DP7 in the tag box, press OK, double-click again and read DP7. Today the robot may not type in that box or press OK. The two small permissions are listed below for a Codex look.
4. **Office layers (card D24): three new cases.**
   1. **N43, robot can drive it, meant to fail today:** recolour ARROW, 20TEXT and the stormwater layers magenta, then run PIT and CD. Your rule says they stay magenta. CE today sets them back to the office colours; I read this in the source, so it is not a guess.
   2. **N44, robot can drive it:** a Charged pipe, a Suspended pipe and a Rising main must each land on their own office pipe layer, with IL texts on 20TEXT. A normal pipe is drawn last so CE remembers the normal type for you.
   3. **N44b, partly drivable:** AutoCAD's own LIST shows the pit label block and its number inside. The layers of the lines inside the block need one new read step, so that part needs a Codex look.
5. **One question for your D24 card later (no action today):** which layer should the pit number inside the label block use? The card does not say, so N44b only records it.
6. **Nothing here needs you in AutoCAD.** None of these has been run yet.

---

## Per gap: the cases, the reasons, and what is DERIVED

Folder: `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_gap_30oct\` (new). 16 files: 8 cases, 8 twins. Offline check: **16 files checked, 0 invalid** (`case_runner.ps1 validate`, run once, no fix needed). No existing case, the runner, the driver, ledger.json, the ACCEPTANCE_LEDGER, BUG_CARPARK.md or DESK_LOG was edited.

Numbers: N40 to N44 were free (checked `cases\` and every drafts folder; N38 is the last used). I used N40, N41, N42 (with N42g and N42s), N43 and N44 (with N44b).

### Gap 1: D21 natural order, whole (N40 and N40_BROKEN)

1. **Hashes:** N40 `7730D5F5B9A9`, twin `64D04627642D`.
2. **Route:** N33's exact steps (PASS on 3.0.86 in a80K1-s3 and b80K1-s2), six times. One SETTING line (`linking.pitScheduleNaturalOrder true`).
3. **Source read:** `Helpers/PitIdComparer.cs` on `origin/claude/rel-20261029a`. Switch ON: P plus digits plus letters is the P group; CompareRuns compares digit runs by size, and a shorter name sorts first. Switch OFF: P1A, P1B, P9A and P10A fall to "the rest" and sort as plain text.
4. **Checks:** one strict whole-chain check (cx_cr25's gap pattern between every pair, P4 to P6 included) and five single trap checks (P10A/P1A, P10/P2, P10/P9A, P10A/P9, SPS10/SPS2).
5. **Offline regex test** (scratch `C:\ce-fx\gap30\regex_test.ps1`, made-up rows, not AutoCAD): natural order passes all 6; text order fails exactly chain, P10A/P1A, P10/P9A and SPS10/SPS2; a misplaced P4 fails the chain.
6. **Twin:** switch OFF plus six presence checks. Expected red on those four checks only; presence and placement checks must pass.
7. **DERIVED:** the row text for suffix names, and that New Pit accepts P1B, P9A and P10A as typed.
8. **Together with N29 (assertion 1 and 2) and N33 (assertion 3), N40 covers D21's checked assertions whole,** once it has two passes and an independent review.

### Gap 2: BUG-372 STRETCH and MOVE (N41 and N41_BROKEN)

1. **Hashes:** N41 `662BFC2C0413`, twin `E978CC5625FB`.
2. **Route:** SETUP-R47 unchanged (MOVE of P3 109D56 by 2000 mm, pit P8, pipe to the open end 170000,-80000). Then ZOOM Window and a typed `_.STRETCH` with a crossing window round 170000,-80000, 2000 mm east. Then R22's CDCHECK lines word for word.
3. **Checks:** STRETCH "found"; the IL 17.900 text within 800 mm of the new end 172000,-80000; one new pipe; "[CE] CDCHECK:"; "is not connected"; then R22's five absence checks over the whole case history (so the MOVE and STRETCH lines are swept too).
4. **Twin:** `checks.cdcheckLinesShowNoInternalIds false` (the same switch R22_OFF_BROKEN uses, which failed correctly on 3.0.86 in a80D-s1). Expected red on "handle " and "CE-CIV-PIPE-".
5. **DERIVED:** the STRETCH prompt chain (never typed by any case before), that the end IL text follows the stretched end, and the open-end wording after the stretch.

### Gap 3: BUG-859 parts not tested (N42, N42g, N42s and twins)

1. **Hashes:** N42 `E263EEDD90D7`, twin `3BF47E63678D`; N42g `5FAF6B94C4A5`, twin `94ECB1CC6CC5`; N42s `33DE54CCFD3E`, twin `A2F16EB88992`.
2. **N42 route:** R09s word for word (PASS on 3.0.86 twice), done twice on one DP1: `-Part insertion` (red centre) and `-Part attrmid:DP` (angled DP text). The structured log must say "EATTEDIT stopped before AutoCAD" exactly twice. Twin: R09S_NEW_SWITCH_OFF_BROKEN's switch (`doubleClick.sourceStopsAttributeEditorFirst false`).
3. **N42g:** EXPECT-FAIL BUG-860. The green label is a plain text with no owner note (BUG-860 entry); #1834 does not change it. Twin: `doubleClick.sourceEditWindow false`, useful only once N42g passes (said in its header).
4. **N42s needs two permissions (smallest safe additions, NOT made, need a Codex look and the reviewed re-pin of both lists, as in ROBOT_MORE_BUTTON_B5_29OCT.md section 1):**
   1. **Driver v2 list** (`acad_driver_witness_v2.allowlist.json`): one window entry, title `*| Edit source`, press none, set `Source tag` / set_ids `SourceEdit.Tag`.
   2. **Driver v3 list** (`acad_driver_v3.allowlist.json`): one new entry before `Creative Engineering*`, title `Creative Engineering | Edit source`, press `Accept source changes` (SourceEdit.OK, `SourceEditDialog.xaml` line 60). `Remove source tag` stays refused.
   3. Until then both steps are refused: the case is BLOCKED, never a result. It is left out of the spec.
5. **N42s twin:** a reversed read-back (expects DP1 after OK); no switch turns off the saving, and turning off the window would fail on a step, not a check.
6. **DERIVED:** that the block's insertion point is the red centre; the attribute tag DP; the label's object type and text; that DP7 is a free tag; that OK closes the window.

### Gap 4: D24 parts not tested (N43, N44, N44b and twins)

1. **Hashes:** N43 `5B3519890862`, twin `9957022F59ED`; N44 `B3A2DB01C423`, twin `D689B2CC55BB`; N44b `EE5CBD1C73ED`, twin `4190936C0D06`.
2. **N43, existing layer colours (EXPECT-FAIL UX-LYR-01):**
   1. **Source fact:** `Services/LayerService.cs` EnsureLayerCore, about lines 470 to 486 on 3.0.86, sets an existing unlocked layer's colour back to the office colour whenever it differs. Only a locked layer is left alone. This matches card D24's "not built".
   2. **Route:** `_.-LAYER _COLOR 6` on seven layers (the same `-LAYER` form with spaced names that R23 passed with), AutoCAD's `-LAYER ?` listing before and after, SETUP-P8's steps typed inline after the recolouring.
   3. **Control:** BLOCKS (never prepared by CE) must stay 6. **Twin:** reverses that one control check to 7 and drops the six not-built checks.
   4. **DERIVED:** the listing's line text. Offline regex test on made-up lines: it reads 6 where 6 is, and is not fooled by the PIT LABEL line when checking STORMWATER PIT.
3. **N44, other pipe types:** Charged, Suspended and Rising main from the radio buttons K08 names (`C2.IsChargedPipe` and so on), then a Stormwater pipe last to restore the remembered type. Layers from `GetPipeLayerDefinition`. Twin: N32_BROKEN's proven rename `layerNames.names.20TEXT CETWIN20TEXT`. **DERIVED:** two IL texts per type, the CE pipe object on the type's layer, no extra question.
4. **N44b, objects inside blocks (partial):** N32's labelled-pit click route, then pick-first the label and AutoCAD's own LIST (R08c_I's form). It judges the block's layer and that a PIT_LABEL attribute is present, and records the attribute layer. **Missing read step for the rest (Codex look):** a read-only `ent-parts <handle> -> $list` in `case_runner_lib.ps1` returning the rows `Get-V3BlockParts` already builds, plus a `layer` field per attribute in `Get-V3EntityInfo`. Twin: reversed presence check.

### The chain spec

`C:\ce-fx\retest\spec_gap_cases.txt`: 12 a lines (twins once) and 7 b lines (mains only). One line per settings group; pointer cases one per line. N42s and its twin are left out (permission). An offline check of the runner's own `-Only` rule (scratch `spec_test.ps1`) shows every line picks exactly its intended files.

## What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** Every case is NOT RUN, NOT REVIEWED. Every DERIVED item above is unseen.
2. **The regex tests used made-up text,** not a real schedule dump or a real `-LAYER ?` listing.
3. **I did not read the D24 card's own source file history** beyond `DAILY_TOOLS_TEST_CASES_2026-10-23.md` lines 610 to 735, nor run reports for SETUP-R47 beyond the review's citations.
4. **I did not check that the coordinates of the new pipes and pits are clear** of existing drawing objects, beyond their use by passing cases (R32, C32, N33).
5. **Not checked:** whether `history` reads lines written by the SETUP before the case's own steps (N41's MOVE sweep relies on it); README_CASES says the setup's log start is reused, which I read as yes.

## Files written

1. 16 case files in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_gap_30oct\`.
2. `C:\ce-fx\retest\spec_gap_cases.txt`.
3. Scratch only: `C:\ce-fx\gap30\` (twin headers, two offline test scripts).
4. This report.

## Summary

Eight new cases with twins close the four gaps on paper. N40 checks the whole natural-order schedule. N41 sweeps CDCHECK after a real MOVE and STRETCH. N42 covers the red centre and the DP text. N44 covers three more pipe types. N43 and N42g are meant to fail today: the source still recolours existing layers, and BUG-860 is open. N42s needs two small robot permissions, and N44b one new read step, so both need a Codex look. All 16 files pass the offline check. Nothing has been run.
