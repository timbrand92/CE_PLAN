# Robot case drafts, SET 18: Structural footings and footing registers (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** Three robot cases, each with a broken twin, drafted on paper for footing fixes #1909, #1894 and #1988. The other three fixes (#1893, #1898, #1930) cannot be driven by the robot, so they have Codex looks instead. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder: the only file written is this one. No git write.

---

## FOR TIM

1. **3 robot cases drafted, each with a broken twin (6 case texts).** W1909 (FPFC keeps the depth you type), W1894 (a footing size removed by Undo is not kept), W1988 (OOPS after ERASE of a footing line brings the outline back at once).
2. **Codex-only (BLOCKED-FOR-ROBOT, 3 fixes).** #1893 (needs a drawing whose footing register is already damaged; none exists), #1898 (needs two drawings, and hand-damaged size entries), #1930 (the pad size library is only visible in the FST window). Codex looks are below.
3. **Needs an Opus review BEFORE it is run:** W1988 (touches OOPS and Undo). W1894 also uses Undo (a single U), so review it with W1988.
4. **Example of what W1988 checks.** Place a pad PF7, ERASE its outline line, type OOPS. Right = the line is back AND the command line says "PF7 is back; CE redrew its outline." with no other footing command typed. The twin types REGEN instead of OOPS and must fail.
5. **Could NOT verify:** the robot's settings guard may not accept the Structural settings file (see part 1, item 3). If it refuses, the two switch-off twins come back BLOCKED, not red. W1988's twin does not depend on it.
6. **Not proven by anything here:** every line marked DERIVED was read from the PR text or the source, not seen on a run. The side-pick prompt after THCL and the schedule's text format are not known.
7. **Nothing for you to test or decide now.** These wait for the desk and an Opus review. All three bug entries stay OPEN.

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `README_CASES.md` in full; the finished examples `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the S467d FPFC case; the W248 case and its twin (OOPS, same style); `R09s_new_switch_off_broken`; `CASE_WRITING_STRUC_REPORT_30OCT.md`; the six PR texts (`gh pr view`); the diffs of #1909, #1988 and #1894 (read-only); the footing text commands in `CeTextService.cs` on `origin/claude/rel-20261102a` (read with `git show`); `BUG_CARPARK.md` entries; and `runner-reports\ledger.json` and every cases folder.
2. **Is there already a case?** No, checked again by name and by command words. `FPFC` appears only in S467d (the rotated-UCS fix, a different bug). `OOPS` appears only in the W248, W267, W285 and W325 cases, which are Civil pit and pipe labels. No case or draft names BUG-1136, 1199, 1146, 1147, 1159, 579, 578 or 300. The ledger holds no case for them. I did not find a `BUGFIX_*_REPORT` that names these PRs by number except `BUGFIX_s2_REPORT_31OCT.md` and `BUGFIX_s12_REPORT_31OCT.md` (read only as titles; the PR texts carry the same information).
3. **The switch-off twin problem (important).** The runner's bare name `CS_Settings.json` expands to `%APPDATA%\TIM_CE_CADTOOLS\CS_Settings.json`, but Structural reads `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (the 30 Oct Structural report says so). The driver's allow-list does list both full paths. So the two switch-off twins below use the FULL path in the SETTING line. UNPROVEN: nobody has run a SETTING line with that full path, and the key may not exist in the file yet. If the runner refuses it, the twin comes back BLOCKED. Fix to try then: a route twin (W1909: type depth 0; W1894: type no U) instead of the switch.
4. **Switch names read from the code.** `FootingWidth.FootingDepthKeptOnPlacement` (#1909, default on, confirmed by its test JSON). `Options.FootingSizesReadFromDrawing` (#1894, default on, key section confirmed by its tests). `FootingWidth.OopsRestoresOutlineAtOnce` (#1988, from the PR text, DERIVED).
5. **Fixture.** DRV2_S1 for all three, not DRV1_B1: it is the Structural drawing (pads PF1 to PF4, a footing schedule), and the Structural robot cases of 30 Oct and robot run 2 used it. DRV1_B1 is a Civil drawing and has no footing schedule. If the Structural plugin is not loaded in the robot AutoCAD, FPFC and THCL print "Unknown command" and every case here comes back FAIL or BLOCKED for that reason; say so, do not loosen the check.
6. **Order numbers** 870 to 874. **SLOT fresh.** `REVIEWED_AGAINST` left empty. Every `type` chain is a complete command with no `(` and no SAVE-type word. No case unlocks a layer, touches an Xref or goes around any AutoCAD protection.
7. **To validate offline:** copy each block to its file name in a new folder (suggested `cases\drafts_struc_footings_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run this.
8. **Empty ground.** Centre 19700,-3300 is the point the S467d case used on DRV2_S1 (World UCS here). Pad centres below are 19700,-3300 (W1909, W1988) and 19700,-6000 (W1894).

---

## 2. The case texts

### Case 1 of 3: W1909, FPFC keeps the typed depth on the new footing (#1909, B-088, BUG-579)

**Intended file:** `W1909_fpfc_keeps_typed_depth.case.txt`

```
# W1909 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1909 (B-088, BUG-579), switch FootingWidth.FootingDepthKeptOnPlacement, default ON, on origin/claude/rel-20261026s.
# Route: FPFC PF7, 600, 600, depth 350, centre 19700,-3300, Enter at the rotation question. The first five prompts are the S467d route read from the code at 204dfad2 (Services/FoundationService.cs ExecuteCreateRectElement, TryGetOrPromptRectSize); DRV2_S1 holds PF1 to PF4 and (UNCONFIRMED) no remembered size for PF7, so the size questions appear. If it does remember one, the chain goes out of step: the type reply shows it.
# What is read: the whole text of the drawing before and after (ms-new 0 reads from the start; DRV2_S1 is small). The footing schedule is rewritten by FPFC. DERIVED and UNCONFIRMED: the depth appears in the schedule text as 350 (the PR says 'the footing schedule shows 350 deep'; its exact text format is not known, and if the schedule is edited in place and not as new objects the check still reads it because it reads every object). UNKNOWN count must not rise.
CASE W1909
TITLE FPFC PF7 600 x 600 with depth 350 puts 350 in the footing schedule and the schedule does not gain an UNKNOWN row
PLAN_ITEM BUG-579 (B-088, PR #1909) PART: FPFC only, a typed depth reaches the footing schedule. NOT whole: FSF strip footings, FEDIT offering <350> and FADOPT / screw pile / stump routes are not driven (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 870
TIMEOUT 900
BUG BUG-579
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After FPFC PF7 600 600 350 at 19700,-3300 and Enter: one new closed polyline on layer STRIP FOOTINGS; at least one text containing 350 now in the drawing that was not there before; the number of texts containing UNKNOWN is the same as before FPFC; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the rule and two source lines; only a live FPFC writes the footing record and the real schedule that FEDIT and the schedule read.
NOT_AUTOMATED FSF strips, FEDIT offering <350> (its first prompt is not known), FADOPT, screw pile and stump routes, and the Undo or Redo half of BUG-579 (the PR did not trace it).
NOT_AUTOMATED How the schedule looks (column, wording). The text is recorded, not judged.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-new 0 -> $all0
  select $all0 "text~350" -> $t350_before
  select $all0 "text~UNKNOWN" -> $unk_before
  ms-count -> $c0
  type "FPFC{NL}PF7{NL}600{NL}600{NL}350{NL}19700,-3300{NL}" -Force -TimeoutSec 120 -> $pf
  wait
  esc-prompt -> $pfe
  wait
  ms-new $c0 -> $new
  select $new "object~Polyline" "layer=STRIP FOOTINGS" -> $pad
  ms-new 0 -> $all1
  select $all1 "text~350" -> $t350_after
  select $all1 "text~UNKNOWN" -> $unk_after
  windows-snapshot -> $win_end
ASSERT
  count $pad = 1
  count $t350_before = 0
  count $t350_after >= 1
  equals $unk_after $unk_before
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $pf "FULL FPFC (each question, to see whether the size questions came out in step)"
  record $t350_after "every text holding 350 after FPFC"
  record $unk_before "UNKNOWN texts before FPFC"
  record $unk_after "UNKNOWN texts after FPFC"
```

**Known weak point.** `equals $unk_after $unk_before` compares the two lists as text, so a changed schedule row that still has the same count of UNKNOWN texts but different handles could read as a difference. If the first run shows that, change it to two `count` checks with the number the first run printed.

**Twin:** `W1909_BROKEN_switch_off.case.txt` (the switch OFF before AutoCAD starts, as in R09s_new_switch_off_broken)

```
# W1909_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1909: the PR's own switch FootingDepthKeptOnPlacement set OFF before AutoCAD starts, so the footing record gets no depth (the old behaviour: FEDIT offered 0, the schedule drew UNKNOWN). Same route and the same checks.
# UNPROVEN: the SETTING line uses the FULL path because a bare CS_Settings.json expands to the Civil folder. If the runner refuses the path or the key, this comes back BLOCKED (see the set's part 1 item 3). Do NOT add hashes-unchanged (the settings file differs while the guard holds it).
# Expected red: 'count $t350_after >= 1' (no 350 text) and 'equals $unk_after $unk_before' (the schedule gains an UNKNOWN row). The route checks (one pad polyline, no window left open) still pass, which shows FPFC itself ran.
CASE W1909_BROKEN
TITLE BROKEN VARIANT of W1909: the depth switch OFF, so the typed 350 does not reach the schedule (must FAIL)
PLAN_ITEM red-before-green proof for W1909 (BUG-579, PR #1909)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 871
TIMEOUT 900
BUG BUG-579
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1909
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json FootingWidth.FootingDepthKeptOnPlacement false
REVIEWED_AGAINST
EXPECTED Same checks as W1909. With the switch OFF the depth stays in the size list only: no new text holds 350 and the schedule shows one more UNKNOWN, so two checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1909's two checks can go red.
NOT_AUTOMATED As W1909.
STEPS
  copy-info -> $copy0
  ms-new 0 -> $all0
  select $all0 "text~350" -> $t350_before
  select $all0 "text~UNKNOWN" -> $unk_before
  ms-count -> $c0
  type "FPFC{NL}PF7{NL}600{NL}600{NL}350{NL}19700,-3300{NL}" -Force -TimeoutSec 120 -> $pf
  wait
  esc-prompt -> $pfe
  wait
  ms-new $c0 -> $new
  select $new "object~Polyline" "layer=STRIP FOOTINGS" -> $pad
  ms-new 0 -> $all1
  select $all1 "text~350" -> $t350_after
  select $all1 "text~UNKNOWN" -> $unk_after
  windows-snapshot -> $win_end
ASSERT
  count $pad = 1
  count $t350_before = 0
  count $t350_after >= 1
  equals $unk_after $unk_before
  not-contains $win_end "Creative Engineering"
  record $pf "FULL FPFC with the switch OFF"
  record $t350_after "texts holding 350 (expected none)"
```

---

### Case 2 of 3: W1988, OOPS after ERASE of a footing line puts the footing and outline back at once (#1988, B-160, BUG-300). NEEDS AN OPUS REVIEW (Undo, OOPS)

**Intended file:** `W1988_oops_restores_footing_outline.case.txt`

```
# W1988 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1988 (B-160, BUG-300), switch FootingWidth.OopsRestoresOutlineAtOnce (default ON), on origin/claude/rel-20261026s. TOUCHES UNDO AND OOPS: an Opus review is needed before this is run.
# Same style as W248 (Civil pad drain text), with FPFC in place of CDPERIMETER. Route: FPFC PF7 600 x 600 depth 350 at 19700,-3300 (the S467d route, read from the code at 204dfad2), then the pad's own closed polyline on STRIP FOOTINGS is ERASEd (picked first by handle, then _.ERASE) and _.OOPS is typed.
# DERIVED from the PR text, not seen on a run: the printed line is 'PF7 is back; CE redrew its outline.' (the PR says 'PF1 is back; CE redrew its outline.' for mark PF1). Whether the OOPS message appears on the command line (history) is the main check. The PR says the fix covers OOPS only, not U or REDO; so U and REDO are NOT asserted here, only recorded.
# The PR notes that with the switch OFF the outline comes back only at the next footing command. This case types no footing command after OOPS, so a pass proves the 'at once' part.
CASE W1988
TITLE After ERASE of a pad footing's line, OOPS brings the line back and CE says the footing is back and its outline redrawn, before any other footing command
PLAN_ITEM BUG-300 (B-160, PR #1988) PART: a pad footing placed by FPFC, ERASE of its line, OOPS. NOT whole: a strip footing placed by FST, the one-U-takes-all-three claim, REDO, a locked footing layer, REFEDIT and a layout tab (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 872
TIMEOUT 900
BUG BUG-300
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After ERASE the pad polyline is gone. After OOPS the same polyline (same handle) is back; the command line holds 'PF7 is back; CE redrew its outline.'; at least one object on layer STRIP FOOTINGS is on the drawing and a PF7 text is on the drawing; no footing command was typed after OOPS; no CE window is left open; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST OOPS brings back only what ERASE picked, and CE's refresh runs at the end of the live OOPS command; only a real AutoCAD session runs that, and the PR says the Undo/REDO behaviour is source-guarded only.
NOT_AUTOMATED Strip footings (FST), whether one U now removes line, record and outline together, REDO, locked footing layer ('is back, but its layer is locked' line), REFEDIT and layout tab. U is typed at the end and RECORDED, never judged: a judged U after OOPS touches the REDO window this PR was written to protect, and an Opus reviewer should decide that, not this drafter.
STEPS
  settings-arm
  copy-info -> $copy0
  ms-count -> $c0
  type "FPFC{NL}PF7{NL}600{NL}600{NL}350{NL}19700,-3300{NL}" -Force -TimeoutSec 120 -> $pf
  wait
  esc-prompt -> $pfe
  wait
  ms-new $c0 -> $new
  select $new "object~Polyline" "layer=STRIP FOOTINGS" -> $pad
  select $new "text~^PF7$" -> $lbl
  field $pad handle -> $hpad
  pick-first "{$hpad}"
  type "_.ERASE" -Force -> $er
  wait
  sleep 3
  ms-new $c0 -> $after_erase
  select $after_erase "handle~^{$hpad}$" -> $pad_e
  type "_.OOPS" -Force -> $oops
  wait
  sleep 4
  ms-new $c0 -> $after_oops
  select $after_oops "handle~^{$hpad}$" -> $pad_back
  select $after_oops "layer=STRIP FOOTINGS" -> $strip_back
  select $after_oops "text~^PF7$" -> $lbl_back
  windows-snapshot -> $win_end
  type "U" -> $u1
  wait
ASSERT
  count $pad = 1
  count $pad_e = 0
  count $pad_back = 1
  count $strip_back >= 1
  count $lbl_back >= 1
  history has "PF7 is back; CE redrew its outline."
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $er "FULL what ERASE said"
  record $oops "FULL what OOPS said"
  record $after_oops "FULL objects of the pad after OOPS"
  record $u1 "FULL what U said (recorded, not judged)"
```

**Twin:** `W1988_BROKEN_regen_for_oops.case.txt` (the W248 style: REGEN in place of OOPS, no setting needed, so this twin does not depend on the unproven Structural settings path)

```
# W1988_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1988, in the style of W248_BROKEN: the typed _.OOPS is replaced by _.REGEN, so nothing brings the pad line or its outline back. It needs no settings change.
# Expected red: 'count $pad_back = 1', 'count $strip_back >= 1' and 'history has "PF7 is back; CE redrew its outline."'. The route checks (one pad, the line gone after ERASE) still pass, so FPFC and ERASE ran. A switch-off twin (OopsRestoresOutlineAtOnce false by the full-path SETTING line, see the set's part 1 item 3) is a second possible twin; with it OOPS still brings the line back and only the message and the outline check would fail.
CASE W1988_BROKEN
TITLE BROKEN VARIANT of W1988: REGEN instead of OOPS, so the pad line and its outline are not back (must FAIL)
PLAN_ITEM red-before-green proof for W1988 (BUG-300, PR #1988)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 873
TIMEOUT 900
BUG BUG-300
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1988
REVIEWED_AGAINST
EXPECTED Same checks as W1988. Because OOPS is never typed the pad line stays erased after the REGEN, so the 'back' counts read 0 and the OOPS line is missing: three checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1988's checks can go red.
NOT_AUTOMATED As W1988.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "FPFC{NL}PF7{NL}600{NL}600{NL}350{NL}19700,-3300{NL}" -Force -TimeoutSec 120 -> $pf
  wait
  esc-prompt -> $pfe
  wait
  ms-new $c0 -> $new
  select $new "object~Polyline" "layer=STRIP FOOTINGS" -> $pad
  field $pad handle -> $hpad
  pick-first "{$hpad}"
  type "_.ERASE" -Force -> $er
  wait
  sleep 3
  ms-new $c0 -> $after_erase
  select $after_erase "handle~^{$hpad}$" -> $pad_e
  type "_.REGEN" -Force -> $oops
  wait
  sleep 4
  ms-new $c0 -> $after_oops
  select $after_oops "handle~^{$hpad}$" -> $pad_back
  select $after_oops "layer=STRIP FOOTINGS" -> $strip_back
  windows-snapshot -> $win_end
  type "U" -> $u1
  wait
ASSERT
  count $pad = 1
  count $pad_e = 0
  count $pad_back = 1
  count $strip_back >= 1
  history has "PF7 is back; CE redrew its outline."
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $er "FULL what ERASE said"
  record $oops "FULL what REGEN said (in place of OOPS)"
  record $u1 "FULL what U said"
```

---

### Case 3 of 3: W1894, a footing size removed by Undo is not kept (#1894, BUG-1199). Uses Undo: review with W1988

**Intended file:** `W1894_undo_removed_size_not_kept.case.txt`

```
# W1894 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1894 (BUG-1199), switch Options.FootingSizesReadFromDrawing (default ON), on origin/claude/rel-20261102a (it is a PR against that train, not rel-20261026s). USES ONE U: an Opus review is needed before this is run.
# The PR's own scenario: THCL 81 at 600 x 600, Undo, THCL 82, then typing 81 again asks for sizes (the old fault reused 600 x 600 from a once-per-drawing memory).
# Prompts DERIVED from the code on origin/claude/rel-20261102a (Services/CeTextService.cs ExecuteRectWithText and TryGetOrPromptRectSize), not seen on a run: 'Enter text or <last>:' (the first answer 81), 'Add column over text? [Y/N] <N>:' (answered N), 'Enter X size (width):' (600), 'Enter Y size (height) <same as X>:' (Enter), 'Specify insertion point (center):' (the centre), then a side pick prompt whose wording is NOT KNOWN (a second typed point, 19700,-5200, is a GUESS; esc-prompt ends whatever is left).
# The size is written when the sizes are typed (before the centre), so even if the side pick goes out of step the entry exists. Whether U takes the entry back when the command did not finish normally is UNCONFIRMED; the PR scenario assumes a finished THCL, which is why the side point is typed.
CASE W1894
TITLE After THCL 81 (600 x 600) and U, typing 81 again asks for the X size instead of silently reusing 600 x 600
PLAN_ITEM BUG-1199 (PR #1894) PART: a size removed by one U is not kept. NOT whole: the two-drawings-with-the-same-name half (needs a second drawing), close and reopen, and BUG-1200 (Escape) are not driven
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 874
TIMEOUT 900
BUG BUG-1199
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED THCL 81 asks for X and Y sizes; U takes THCL back; THCL 82 asks for its sizes; the next THCL 81 asks 'Enter X size (width):' and does NOT jump to 'Specify insertion point (center):'; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the lookup rule; only a real U in AutoCAD removes the size from the drawing, and only the live command shows whether it asks again.
NOT_AUTOMATED Two new drawings from one template (BUG-1146 style, a second drawing), close and reopen, and the Escape case (BUG-1200). The side pick prompt after the centre is not known; its wording is recorded.
STEPS
  settings-arm
  copy-info -> $copy0
  type "THCL{NL}81{NL}N{NL}600{NL}{NL}19700,-5200{NL}19700,-4800" -Force -TimeoutSec 120 -> $t81
  esc-prompt -> $e81
  wait
  type "U" -> $u1
  wait
  type "THCL{NL}82{NL}N{NL}600{NL}{NL}22000,-5200{NL}22000,-4800" -Force -TimeoutSec 120 -> $t82
  esc-prompt -> $e82
  wait
  type "THCL{NL}81" -Force -TimeoutSec 120 -> $t_again
  esc-prompt -> $e_again
  wait
  type "U" -> $u2
  wait
ASSERT
  contains $t81 "Enter X size (width):"
  contains $t82 "Enter X size (width):"
  contains $t_again "Enter X size (width):"
  not-contains $t_again "Specify insertion point (center):"
  copy-unchanged $copy0
  record $t81 "FULL first THCL 81"
  record $u1 "FULL what the first U said"
  record $t_again "FULL the second THCL 81 (the main check)"
  record $e81 "FULL what the Escape printed after THCL 81 (side pick wording)"
  record $u2 "FULL what the last U said"
```

**Twin:** `W1894_BROKEN_switch_off.case.txt`

```
# W1894_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). DELIBERATELY BROKEN copy of W1894: the PR's own switch Options.FootingSizesReadFromDrawing OFF before AutoCAD starts, which restores the old once-per-drawing memory, so THCL 81 after the U silently reuses 600 x 600. Same route and checks.
# UNPROVEN: the SETTING line uses the FULL path (a bare CS_Settings.json expands to the Civil folder). If the runner refuses it, BLOCKED. Fallback route twin if it does: type no U between the first THCL 81 and the last one, and keep the check 'contains $t_again "Enter X size (width):"'.
# Expected red: 'contains $t_again "Enter X size (width):"' and 'not-contains $t_again "Specify insertion point (center):"'. THCL 81 and THCL 82 still ask for their sizes the first time.
CASE W1894_BROKEN
TITLE BROKEN VARIANT of W1894: the size-from-drawing switch OFF, so the size Undo removed is remembered and reused (must FAIL)
PLAN_ITEM red-before-green proof for W1894 (BUG-1199, PR #1894)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 875
TIMEOUT 900
BUG BUG-1199
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1894
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json Options.FootingSizesReadFromDrawing false
REVIEWED_AGAINST
EXPECTED Same checks as W1894. With the switch OFF the second THCL 81 goes straight to 'Specify insertion point (center):', so the two checks on it fail.
WHY_NOT_UNIT_TEST It exists only to prove W1894's checks can go red.
NOT_AUTOMATED As W1894.
STEPS
  copy-info -> $copy0
  type "THCL{NL}81{NL}N{NL}600{NL}{NL}19700,-5200{NL}19700,-4800" -Force -TimeoutSec 120 -> $t81
  esc-prompt -> $e81
  wait
  type "U" -> $u1
  wait
  type "THCL{NL}82{NL}N{NL}600{NL}{NL}22000,-5200{NL}22000,-4800" -Force -TimeoutSec 120 -> $t82
  esc-prompt -> $e82
  wait
  type "THCL{NL}81" -Force -TimeoutSec 120 -> $t_again
  esc-prompt -> $e_again
  wait
  type "U" -> $u2
  wait
ASSERT
  contains $t81 "Enter X size (width):"
  contains $t82 "Enter X size (width):"
  contains $t_again "Enter X size (width):"
  not-contains $t_again "Specify insertion point (center):"
  record $t_again "FULL the second THCL 81 with the switch OFF"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Evidence for every look goes in `C:\CE_WORK\codex\<look name>\`. Work on a COPY of a drawing only. Never accept, save or capture a folder the Save or Open box opened in.

### Look A: #1893 (BUG-1136), a damaged footing register is kept, never saved over. BLOCKED-FOR-ROBOT

**Why:** it needs a drawing whose footing register is stored but unreadable. The robot cannot make one: it cannot type LISP, edit the drawing's stored data or open a file picker. No such drawing is in `C:\ce_rc_drv`. Needs a prepared copy first (the desk makes it; a second, healthy copy of DRV2_S1 is the control).

1. **Setup (desk, once).** Make a copy of DRV2_S1 with its footing register damaged, in `C:\CE_WORK\codex\L1893\`. Not made by this drafter.
2. **Steps.** Open the damaged copy. Type THC (or THCL) and place footing 41 (any size). Close the drawing without saving.
3. **Right looks like.** One plain line on the command line saying the footing register could not be read and a copy was kept; a recovery copy of the stored text appears in the CE settings folder (Recovery). Footings 1 to 40 are still listed after the placement. Nothing is saved over the damaged register.
4. **Wrong looks like.** No such line; footings 1 to 40 gone from the schedule.
5. **Evidence.** Screenshot of the command line, a file listing of the Recovery folder, and a before and after count of footings.
6. **Switch off check.** Set `Options.KeepDamagedFootingRegister` to false by hand in the Structural settings before AutoCAD starts, repeat: footings 1 to 40 are dropped (old behaviour). Restore the settings file afterwards.

### Look B: #1898 (B-077: BUG-1146, 1147, 1159), per-drawing size memory, newer data kept, unreadable entries kept. BLOCKED-FOR-ROBOT

**Why:** BUG-1146 needs two new drawings from one template (a second drawing); BUG-1147 and BUG-1159 need a drawing saved by a newer CE build and a size list with a hand-damaged entry, which the robot cannot make.

1. **BUG-1146.** Start AutoCAD, NEW from the same template twice (Drawing1, Drawing2). In Drawing1: THCL, 81, N, 600, Enter, a centre and a side point. Switch to Drawing2: THCL, 81. **Right looks like:** it asks "Enter X size (width):". **Wrong:** it goes straight to "Specify insertion point (center):".
2. **BUG-1147.** Needs a drawing whose footing record carries a newer version number (desk makes a prepared copy). Open it, run FPFC. **Right:** a plain line says the data is from a newer CE build and was left as it is; the command carries on; the unknown fields are still in the record afterwards.
3. **BUG-1159.** Needs a size list with one entry CE cannot read (desk makes a prepared copy). Add one new size, then check the old unreadable entry is still in the list. **Right:** it is. **Wrong:** it is gone.
4. **Evidence.** Screenshot of each command line, in `C:\CE_WORK\codex\L1898\`.

### Look C: #1930 (B-104, BUG-578), the pad size library names a footing PF1 everywhere. BLOCKED-FOR-ROBOT (window only)

**Why:** the pad library is only visible in the FST window (a window press the robot's list does not allow), and the library cannot be read without LISP. Two-minute check.

1. **Steps.** Open a COPY of DRV2_S1 (it already holds PF1). Type FPFC, answer PF8, sizes 600 and 600, depth 350, a centre, Enter. Then open the FST window and find the pad size library.
2. **Right looks like.** One row named PF8 (not a row named 8). No second plain-number row appears next to it. For the older row, if one named 1 exists: it shows as PF1 with the same sizes, and one plain line says so, once.
3. **Wrong looks like.** A row named 8 appears beside PF8.
4. **Evidence.** Screenshot of the library in `C:\CE_WORK\codex\L1930\`.
5. **Switch off check.** `FootingWidth.PadLibraryKeyIsFullMark` false before AutoCAD starts: the second row appears (old behaviour).

---

## 4. Fixes skipped, and why

1. **#1893 (BUG-1136), #1898 (B-077) and #1930 (B-104):** no robot case; Codex looks above (a damaged drawing, a second drawing, a window-only library).
2. **A robot case for FSF (the strip-footing half of #1909) and for FEDIT offering <350>:** the first prompt of FEDIT is not known and its selection step is not known, so only the schedule readback is drafted (W1909, PART claim).
3. **U and REDO after OOPS (#1988):** recorded only, not judged. Left for an Opus review.

---

## 5. What was read, built and tested (plain)

1. **Read:** the rules, the case README, the finished example drafts, the S467d and W248 cases, the six PR texts, the diffs of #1909, #1988 and #1894, the footing text command code on the Structural train, the carpark entries (by line), the ledger and the cases folders.
2. **Built:** nothing. **Tested:** nothing. **AutoCAD:** not opened. **The case runner:** not run, not even its offline validate.
3. **NOT proven:** that any of the three cases runs; that the Structural plugin is loaded in the robot AutoCAD; that the full-path SETTING line is accepted; the prompts after THCL's centre point; what the footing schedule text looks like; that a single U removes a size when the command ended early. Every printed line quoted from the PRs is DERIVED, not seen on a run.
4. **Time note:** the PRs name the footing switches as Settings checkboxes that do not exist yet (#1893, #1894 say "no Settings-window checkbox (owed to Codex)"), which is why the twins use the settings file.
