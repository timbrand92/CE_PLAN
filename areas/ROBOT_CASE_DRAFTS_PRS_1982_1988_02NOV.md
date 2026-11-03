# Robot case drafts: fix PRs #1982 to #1988 (Mon 2 Nov 2026, evening Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get, plus Codex look notes for what the robot cannot prove. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written.

**Path note.** The brief named `C:\CE_PLANreas\...`. That folder does not exist, so I wrote to `C:\CE_PLAN\areas\` beside the other drafts. Say if you wanted it elsewhere.

---

## FOR TIM

1. **Two robot cases drafted, each with a twin that must fail (four case texts, orders 776 to 779).** W1988 (OOPS after ERASE of a footing brings the outline back at once, plus one U and one REDO) and W1986 (BP says so when the Settings pier diameter is not on the pier block). Nothing to test or decide.
2. **W1988 can run as soon as a Structural build holding #1988 is installed.** It needs no setting. It touches Undo and REDO, so an Opus review comes BEFORE its first run.
3. **W1986 cannot run today.** It needs the Settings pier diameter at 500 before AutoCAD starts. The runner only accepts a bare file name or letters in a SETTING line, and the Structural settings file sits in a folder it cannot name (the check is at line 129 of `case_runner_lib.ps1`). One reviewed one-line runner change fixes it. I made no runner change.
4. **Five fixes are Codex-only: #1982, #1983, #1984, #1985, #1987.** Each has numbered Codex look steps below (K1982, K1983, K1984, K1985, K1987). Reasons in plain words: file pick boxes the robot cannot drive (#1982, #1987), a Save As box (#1983), a rating report file the robot may not place in the job folder (#1984), and the Project Review window, which the robot cannot read or close (#1985).
5. **None of the seven fixes is in any build.** I checked each PR head against Civil 3.0.89 (`61fd6fbc`, the installed one), candidate b1 (`cf059dcf`, rel-20261108a) and b2 (rel-20261110a): all five Civil heads are in NONE of them. The two Structural heads are not in `rel-20261026s` either. So every case below is expected to FAIL on today's installed build, and that is not a fault.
6. **No case existed.** I searched the cases folder (every drafts folder and `variants`) and `ledger.json` for the PR numbers, the seven bug numbers and the case names the builders proposed. Nothing. Earlier paper drafts for #1982, #1984, #1986, #1987 and #1988 do exist in sets 05, 07, 18 and 21: this file replaces the W1986 (orders 900 and 901) and W1988 (orders 872 and 873) texts there. Use one version only.
7. **One gap in W1988's twin you should know.** The twin types REGEN in place of OOPS, so it proves the "back at once" checks can go red. It does not prove the U and REDO checks can go red. Those two checks are only as good as the Opus review.
8. **Not proven by any of this:** every printed line and window word marked DERIVED came from the PR text, the builders' reports or the source, not from a run. Whether Structural is loaded in the robot's AutoCAD today is unchecked.

---

## 1. Facts checked, and where each came from

1. **`git fetch origin` run first (Mon 2 Nov, evening).** Tips read: Civil base `claude/rel-20261102a` = `3fbb9da5`; `rel-20261108a` = `cf059dcf` (b1, Civil 3.0.90); `rel-20261110a` = `d4ce878e` (b2); Structural `rel-20261026s` = `204dfad2`.
2. **The authority for what is installed:** Civil 3.0.89 = `61fd6fbc` ("Version: Civil 3.0.89 / Manager 1.1.89 (C-79a)", read with `git log`). It is an ancestor of `rel-20261106a`, `rel-20261108a`, `rel-20261110a` and `rel-20261112a`.
3. **Ancestry (`git merge-base --is-ancestor`, read-only), PR head in 61fd6fbc / in cf059dcf / in rel-20261110a:**
   1. #1982 `b6dd9dbb`: no / no / no.
   2. #1983 `4fcf82b4`: no / no / no.
   3. #1984 `2c5bd044`: no / no / no.
   4. #1985 `ad5f254c`: no / no / no. Its parent #1857 (`718ec21c`) IS in `rel-20261108a` (the Opus pre-review says so; I did not re-check it).
   5. #1987 `5770235a`: no / no / no.
   6. #1986 `f2bd8aeb` and #1988 `7d358fd2`: not in `rel-20261026s`. I did not check the Structural train commits that may be newer than it.
4. **PR facts (read with `gh pr view`, and the Opus pre-review `OPUS_PREREVIEW_1984_1988_GROUP_01NOV.md`, plus the builders' reports q7, q8, q5, q10, t1, t3).**
   1. #1982, B-150, BUG-908: `xcivilImport.levelRangeFollowsSettings` now ON. Import keeps levels inside the Settings range (-50 to 1000 m at the shipped values) instead of only above 0 and up to 250 m.
   2. #1983, B-157, BUG-1268: `excel.confirmCalcXlsxSaved` ON. CDCALC Export to XLSX logs every outcome and says when nothing was saved. The PR itself names the proof as Codex look K1-02b.
   3. #1984, B-151, BUG-1120 part a: `detention.stormNoneNoteWording` ON. The STORM "None" note now says "has no water-quality treatment".
   4. #1985, B-148, BUG-1258: `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial` ON. Project Review Pipe sizes uses the office Maximum pipe velocity when a material has no speed limit, as CDRULES does.
   5. #1986, B-153, BUG-536 BP part: `FootingWidth.BoredPierBlockFollowsDiameter` ON. BP prints one line when the Settings diameter is not 300, 450 or 600.
   6. #1987, B-158, BUG-805: `xcivilImport.scheduleReadsMetresAndDepthColumn` ON. Reads "0.9 m" as 900 mm, reads the DEPTH column, leaves a half-blank pipe row unassigned with a warning.
   7. #1988, B-160, BUG-300: `FootingWidth.OopsRestoresOutlineAtOnce` ON. OOPS after ERASE of a footing line restores the record and outline at once.
5. **The wording of the BP line is read from the PR branch** (`BoredPierDiameterChoice.FallbackWarning`, read with `git show origin/claude/q10-bp-block-follows-diameter`): "\n[BP] The pier diameter in Settings (Bored pier plan, default diameter) is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead. Pick 300, 450 or 600 here, or change the Settings value." The question after it is "Select pier diameter [300/450/600] <450>: ". The warning sits inside the switch check, before the question. Read at the PR head, not seen on a run.
6. **The STORM offer is read from the PR branch** (`CivilDesignCommand.OfferTheStormReport`): CDDESIGN asks "Look through this job's folders for its rating report and offer the site and roof areas?" (Yes or No, Yes is the default), only when the drawing is saved inside a job folder AND the site area, roof area or council is not already recorded. The report folder is named "STORM Report - WSUD". The notes print as "[CE]    <note>" lines.
7. **The runner's SETTING rule (read in `case_runner_lib.ps1`).** Line 129 accepts only `CD_Settings.json`, `CS_Settings.json`, `settings.json`, `STRUC\CS_Settings.json` or letters, underscores and backslashes ending `.json`. A path with `%` or `:` fails `validate`. A bare `CS_Settings.json` expands to `%APPDATA%\TIM_CE_CADTOOLS\CS_Settings.json` (case_runner.ps1 line 229), but Structural reads `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (the driver allow-list lists both files). So today there is no valid way to set a Structural switch or the pier diameter in a case header. I did not run `validate`.
8. **Fixtures.** DRV1_B1 (Civil) exists in `C:\ce_rc_drv`. DRV2_S1 (Structural: pads PF1 to PF4 and a footing schedule) also exists, so it fits both Structural cases better than DRV1_B1. Pad centre 19700,-3300 is the empty point an earlier Structural case used on DRV2_S1 (read in the set 18 draft, not re-checked).
9. **Order numbers.** The range 770 to 789 is partly used by other paper drafts (770 to 775 in set 08, 780 and 781 in set 09). I used 776 to 779 so no number repeats.

---

## 2. Case texts

**How these are written.** README_CASES.md format. Every `type` chain is a complete command with no `(` and no SAVE-type word. SLOT fresh. REVIEWED_AGAINST empty. Run alone, outside Tim's hours. Validate first without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_prs_1982_1988_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or goes round a protection.

### Case 1 of 2: W1988 and W1988_BROKEN (#1988, B-160, BUG-300). NEEDS AN OPUS REVIEW BEFORE IT RUNS (Undo, REDO, OOPS)

**Intended file:** `W1988_oops_restores_footing_outline.case.txt`

```
# W1988 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1988 (B-160, BUG-300), switch FootingWidth.OopsRestoresOutlineAtOnce ships ON (this case sets nothing). TOUCHES UNDO, REDO AND OOPS: an Opus review is needed before the first run.
# BUILD PENDING: the head 7d358fd2 is in no train yet (checked Mon 2 Nov). On the installed Structural build this case should FAIL on the OOPS line and the count checks.
# Route (the set 18 draft, read from the code at 204dfad2): FPFC PF7 600 x 600 depth 350 at 19700,-3300 on DRV2_S1, then the pad's own closed polyline on STRIP FOOTINGS is ERASEd (picked first by handle) and _.OOPS is typed. No footing command is typed after OOPS, so a pass proves the 'at once' part.
# DERIVED, never seen on a run: the printed line 'PF7 is back; CE redrew its outline.' (the PR text gives it for mark PF1); that the pad polyline is the only object on STRIP FOOTINGS the first select finds; the answer order of FPFC (as the S467d case).
# What the Opus pre-review asked for (item 7 of its #1988 entry): the object count right after OOPS must equal the count before ERASE. That catches a missing outline and a DOUBLE redraw. Two number checks (>= and <=) do it. Then ONE U must take the OOPS back (count falls to the after-ERASE count) and REDO must bring it back (count rises to the before-ERASE count). Those two are the REDO-sensitive part: review them first.
CASE W1988
TITLE After ERASE of a pad footing's line, OOPS brings the line and outline back at once with the same object count as before; one U takes the OOPS back and REDO puts it back
PLAN_ITEM PR #1988 (B-160, BUG-300) PART: a pad footing placed by FPFC, ERASE of its line, OOPS, then U and REDO, judged by object counts and the command line. NOT whole: a strip footing placed by FST, a locked footing layer ('is back, but its layer is locked'), REFEDIT and a layout tab, the footing schedule refresh after OOPS and the footing record's 'set aside' mark (none can be read by the robot)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 778
TIMEOUT 900
BUG BUG-300
PROVES_BUGS BUG-300 (the OOPS-restores-at-once half only)
REVIEWED_AGAINST
EXPECTED After FPFC one pad (PF7) is on the drawing. After ERASE its polyline is gone and the object count has fallen. After OOPS the same polyline (same handle) is back, the command line holds 'PF7 is back; CE redrew its outline.', the object count equals the count before ERASE, and no footing command was typed after OOPS. One U brings the count back down to the after-ERASE count. REDO brings it back up to the before-ERASE count. No CE window is left open. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests are policy tests and source guards; none drives an Undo or a REDO (Opus pre-review, 1 Nov). Only a live OOPS shows whether CE's redraw joins OOPS's own Undo step, and the pattern was measured for MOVE and ERASE but never for OOPS.
NOT_AUTOMATED Strip footings (FST), a locked footing layer, REFEDIT, a layout tab, the schedule refresh and the footing record mark.
NOT_AUTOMATED How the outline looks on screen: a Codex look if Tim wants it.
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
  ms-count -> $c_pre
  pick-first "{$hpad}"
  type "_.ERASE" -Force -> $er
  wait
  sleep 3
  ms-count -> $c_erased
  ms-new $c0 -> $after_erase
  select $after_erase "handle~^{$hpad}$" -> $pad_e
  type "_.OOPS" -Force -> $oops
  wait
  sleep 4
  ms-count -> $c_oops
  ms-new $c0 -> $after_oops
  select $after_oops "handle~^{$hpad}$" -> $pad_back
  select $after_oops "layer=STRIP FOOTINGS" -> $strip_back
  select $after_oops "text~^PF7$" -> $lbl_back
  windows-snapshot -> $win_end
  type "U" -Force -> $u1
  wait
  sleep 3
  ms-count -> $c_u
  type "REDO" -Force -> $r1
  wait
  sleep 3
  ms-count -> $c_redo
ASSERT
  count $pad = 1
  count $lbl = 1
  count $pad_e = 0
  number $c_erased < $c_pre
  count $pad_back = 1
  count $strip_back >= 1
  count $lbl_back >= 1
  history has "PF7 is back; CE redrew its outline."
  number $c_oops >= $c_pre
  number $c_oops <= $c_pre
  number $c_u <= $c_erased
  number $c_redo >= $c_pre
  number $c_redo <= $c_pre
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $er "FULL what ERASE said"
  record $oops "FULL what OOPS said"
  record $u1 "FULL what U said (the Undo name)"
  record $r1 "FULL what REDO said"
  record $c_pre "object count before ERASE"
  record $c_erased "object count after ERASE"
  record $c_oops "object count after OOPS"
  record $c_u "object count after one U"
  record $c_redo "object count after REDO"
```

**Twin:** `W1988_BROKEN_regen_for_oops.case.txt` (REGEN in place of OOPS; needs no setting, so it does not depend on the runner's Structural settings gap)

```
# W1988_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Deliberately broken copy of W1988: the typed _.OOPS is replaced by _.REGEN, so nothing brings the pad line or its outline back. Same route to the ERASE.
# Expected red: 'count $pad_back = 1', 'count $strip_back >= 1', 'count $lbl_back >= 1', 'number $c_oops >= $c_pre' and 'history has "PF7 is back; CE redrew its outline."'. The route checks (one pad, the line gone, the count fallen) still pass, which proves FPFC and ERASE ran.
# This twin stops before U and REDO on purpose: with no OOPS in the history a U would undo the ERASE itself and say nothing about the fix. So it proves the 'at once' checks can go red, and NOT the U and REDO checks. State that in the report.
# If it PASSES, the old build also brings the line back in this route (or REGEN restored it) and W1988 cannot tell old from new: say so.
CASE W1988_BROKEN
TITLE BROKEN VARIANT of W1988: REGEN instead of OOPS, so the pad line and its outline are not back (must FAIL)
PLAN_ITEM red-before-green proof for W1988 (PR #1988, BUG-300), the 'at once' checks only
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
ORDER 779
TIMEOUT 900
BUG BUG-300
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1988
REVIEWED_AGAINST
EXPECTED Wrong on purpose: OOPS is never typed, so the pad line stays erased after the REGEN. The back counts read 0, the count after the step is below the count before ERASE, and the OOPS line is missing: five checks fail.
WHY_NOT_UNIT_TEST It exists only to prove W1988's checks can go red.
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
  field $pad handle -> $hpad
  ms-count -> $c_pre
  pick-first "{$hpad}"
  type "_.ERASE" -Force -> $er
  wait
  sleep 3
  ms-count -> $c_erased
  ms-new $c0 -> $after_erase
  select $after_erase "handle~^{$hpad}$" -> $pad_e
  type "_.REGEN" -Force -> $oops
  wait
  sleep 4
  ms-count -> $c_oops
  ms-new $c0 -> $after_oops
  select $after_oops "handle~^{$hpad}$" -> $pad_back
  select $after_oops "layer=STRIP FOOTINGS" -> $strip_back
  select $after_oops "text~^PF7$" -> $lbl_back
  windows-snapshot -> $win_end
ASSERT
  count $pad = 1
  count $pad_e = 0
  number $c_erased < $c_pre
  count $pad_back = 1
  count $strip_back >= 1
  count $lbl_back >= 1
  history has "PF7 is back; CE redrew its outline."
  number $c_oops >= $c_pre
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $er "FULL what ERASE said"
  record $oops "FULL what REGEN said (in place of OOPS)"
  record $c_pre "object count before ERASE"
  record $c_oops "object count after the REGEN"
```

### Case 2 of 2: W1986 and W1986_BROKEN (#1986, B-153, BUG-536 BP part). CANNOT RUN UNTIL THE RUNNER ACCEPTS A STRUCTURAL SETTINGS PATH

**Intended file:** `W1986_bp_says_settings_diameter_not_on_block.case.txt`

```
# W1986 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1986 (B-153, BUG-536 BP part), switch FootingWidth.BoredPierBlockFollowsDiameter ships ON (this case does not set it). BUILD PENDING: head f2bd8aeb is in no train yet (checked Mon 2 Nov); the installed Structural build has neither the line nor the switch, so this case should FAIL on it.
# BLOCKED TODAY BY THE RUNNER, NOT BY THE CASE: the SETTING line below holds a full path. validate refuses it (case_runner_lib.ps1 line 129 allows only letters, underscores and backslashes), and a bare CS_Settings.json goes to the Civil folder TIM_CE_CADTOOLS while Structural reads %APPDATA%\CE_STRUC_SUITE\CS_Settings.json. The allow-list (acad_driver_v3.allowlist.json lines 38 and 39) already lists the right file. The wanted change is one reviewed edit to that regex and to the expansion at case_runner.ps1 line 229. Not made. Until then run this as Codex look K1986 (section 3).
# Route: BoredPierPlan.DefaultDiameterMm is 500 before AutoCAD starts (the block has 300, 450 and 600 only). BP is typed alone; CE prints the line BEFORE the question 'Select pier diameter [300/450/600] <450>:'. The case stops at the question with Esc, so no pier is drawn.
# DERIVED, never seen on a run: that the type reply holds the whole line and the question (history is checked as well, in case it does not); that the key BoredPierPlan.DefaultDiameterMm is already in the file.
CASE W1986
TITLE With the Settings pier diameter at 500 (not on the pier block), BP prints one line saying 450 is offered instead, and still asks the diameter question
PLAN_ITEM PR #1986 (BUG-536 BP part) PART: the warning line for a Settings diameter the block does not have, read from the command line. NOT whole: that BP then draws the 450 pier, a 600 control (Settings 600: no line, question reads <600>, block reads '600 DIA.'), and how the pier block looks (Codex look K1986)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json BoredPierPlan.DefaultDiameterMm 500
ORDER 776
TIMEOUT 600
BUG BUG-536
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED BP prints one line naming the 500 mm Settings value, saying the block only has 300, 450 and 600 and that 450 is offered; the next prompt reads "Select pier diameter [300/450/600] <450>:"; Esc ends BP and no pier block is added; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the wording and the switch; only a live BP reads the real Settings value and prints on the real command line before its question.
NOT_AUTOMATED What happens after the question: the 450 pier placed and the pier look (Codex look K1986). The 600 control.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "BP" -Force -> $bp
  wait
  esc-prompt -> $bpe
  wait
  ms-new $c0 -> $new
  windows-snapshot -> $win_end
ASSERT
  contains $bp "is 500 mm"
  contains $bp "only has 300, 450 and 600"
  contains $bp "450 is offered instead"
  contains $bp "Select pier diameter [300/450/600] <450>"
  history count "The pier diameter in Settings" = 1
  count $new = 0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $bp "FULL BP (the warning line and the diameter question)"
  record $bpe "what the closing Esc printed"
  record $new "objects added to Model space (none expected)"
```

**Twin:** `W1986_BROKEN_switch_off.case.txt` (the switch OFF before AutoCAD starts, as in `R09s_new_switch_off_broken`; it has the same runner gap)

```
# W1986_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control ('OFF gives the old silent 450'): FootingWidth.BoredPierBlockFollowsDiameter false before AutoCAD starts, same 500 mm Settings value, same route. It must FAIL on the warning-line checks. The check on the question '<450>' must still PASS, which proves BP ran and offered 450.
# Same runner gap as W1986: both SETTING lines hold a full path.
# If it PASSES, the old build also prints the line (or the switch was ignored) and W1986 cannot tell old from new: say so and use Codex look K1986.
CASE W1986_BROKEN
TITLE BROKEN VARIANT of W1986: the new switch is OFF, the old silent 450 returns, the case still expects the warning line (must FAIL)
PLAN_ITEM red-before-green proof for W1986 (PR #1986, BUG-536 BP part)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json BoredPierPlan.DefaultDiameterMm 500
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json FootingWidth.BoredPierBlockFollowsDiameter false
ORDER 777
TIMEOUT 600
BUG BUG-536
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1986
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF BP offers 450 without saying so, so the warning checks fail; the question "Select pier diameter [300/450/600] <450>" still appears.
WHY_NOT_UNIT_TEST It exists only to prove W1986's warning checks can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "BP" -Force -> $bp
  wait
  esc-prompt -> $bpe
  wait
  ms-new $c0 -> $new
  windows-snapshot -> $win_end
ASSERT
  contains $bp "Select pier diameter [300/450/600] <450>"
  contains $bp "is 500 mm"
  contains $bp "only has 300, 450 and 600"
  contains $bp "450 is offered instead"
  history count "The pier diameter in Settings" = 1
  count $new = 0
  copy-unchanged $copy0
  record $bp "FULL BP with the switch OFF"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

**Common rules for every look.** Use a COPY of a drawing, never a job drawing. Use made-up data only (no client names, no addresses). AutoCAD must have a build holding the PR (none is installed: see section 1 item 3). Save screenshots yourself under `C:\CE_WORK\codex\<look name>\`, one folder per look. Where a look needs a switch OFF, set it by hand in the settings file BEFORE AutoCAD starts (CE reads settings at start), and put the file back afterwards. Window words marked DERIVED come from the PR text or reports, not from a run.

### K1982: #1982 (B-150, BUG-908), the X-Civil import keeps levels inside the Settings range. BLOCKED-FOR-ROBOT

1. **Why not the robot.** The import starts from a file pick box, and the runner's press list allows only Cancel in that box. A made-up consultant file also cannot be placed by the robot.
2. **Make the file.** Evidence folder `C:\CE_WORK\codex\k1982\`. Build a made-up LandXML with two pits: one at invert 300.000 m, one at invert -10.000 m. (The builder's own suggestion was one pit at 300.000: report q7, item 7.) Keep it on this PC only.
3. **Run 1 (the fix ON, the default).** On a copy of DRV1_B1, run the X-Civil import command (q7 names `CDIMPORTXCIVIL`) or the LandXML import window, pick the file, and read the import preview or results page. Screenshot it.
4. **Right looks like, run 1.** Both pits show their level (300.000 and -10.000). The shipped Settings range is -50 to 1000 m (DERIVED, q7).
5. **Run 2 (the broken twin).** Set `xcivilImport.levelRangeFollowsSettings` to false in the settings file, restart AutoCAD, repeat. The 300 and the -10 levels are blank (the old range was above 0 and up to 250 m). This is the "red before green" proof.
6. **Run 3.** Switch back ON, set the Markup level maximum (`markup.levelMaxM`) below 300, restart, repeat. The 300 level is blank again; -10 stays.
7. **What the look cannot settle.** If a consultant file uses 0.00 as "no level", that pit now shows a level of 0 (q7, item 4). Record what the preview shows; do not decide it.

### K1983: #1983 (B-157, BUG-1268), CDCALC Export to XLSX says what happened. CODEX-ONLY (Save As box)

1. **Why not the robot.** The Save As box is a Windows file box. The PR names this proof itself as Codex look K1-02b.
2. **Evidence folder** `C:\CE_WORK\codex\k1983\`. Open a copy of a drawing with a finished CDCALC result. Type `CDCALC`, choose Export to XLSX.
3. **Run A, a real save (ON, the default).** In the Save As box type a full path in your evidence folder, press Enter in the File name box. Then repeat with a click on Save, with the box fully on screen (the PR says the first Codex look had the box partly off the captured area).
4. **Right looks like, run A.** The file exists and its size is above 0. It has one sheet per ticked section. The window's status line reads "XLSX saved: <name> in <folder>". The CE log holds one "saved" line with the file name and size and no folder. The Save As box opened in the same folder the Pit Schedule uses (DERIVED, PR text).
5. **Run B, Cancel.** Choose Export to XLSX, press Cancel. Right looks like: no file, no message box, one "cancelled" line in the log.
6. **Run C, a folder that does not exist.** Type a path in a folder that is not there. Right looks like: the plain box "The XLSX file was not created in <folder>. Nothing was saved." and one ERROR line in the log.
7. **Run D, the broken twin.** Set `excel.confirmCalcXlsxSaved` to false before AutoCAD starts. Repeat run A. Right looks like: no starting folder, no status line, no box (today's behaviour). The log still holds the outcome lines (the PR says those are always on).
8. **Not settled by this look.** Why Windows said "not saved" after the Save click in the earlier look (BUG-1268's root cause) is still unproven. If run A with a Save click shows "cancelled" after a confirmed Save, report it: a second job must look at the Save As window's owner and position (PR text).
9. **Log location.** The Civil log is `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log` (read in the runner). Read it as a file; do not edit it.

### K1984: #1984 (B-151, BUG-1120 part a), the STORM "None" note. CODEX-ONLY (a report file must sit in the job folder)

1. **Why not the robot.** CDDESIGN reads a STORM rating report from the folders around the saved drawing, and the robot may not add files there. It is command-line text only, so no picture is needed, just the lines.
2. **Make the job.** Evidence folder `C:\CE_WORK\codex\k1984\job\`. Save a COPY of any drawing inside it. Make a folder named `STORM Report - WSUD` (read in `StormReport.cs`) and put one made-up STORM rating report in it with one tank roof (346.64 m2) and one driveway row with Treatment "None" (49.38 m2). Those figures are the builder's own made-up values (report q8).
3. **Run 1 (ON, the default).** Open that copy, type `CDDESIGN`. The offer appears only when the site area, roof area or council is not already recorded in the drawing. Answer Yes to "Look through this job's folders for its rating report and offer the site and roof areas?".
4. **Right looks like, run 1.** CE prints "[CE] Read <report file name>." then a line starting "[CE]    Of that, 346.64 m2 goes to a tank and 49.38 m2 has no water-quality treatment" and ending "…check where it drains." The words "goes straight out" do not appear. The areas and the split are the same as before (only the sentence changes).
5. **Run 2 (the broken twin).** Set `detention.stormNoneNoteWording` to false before AutoCAD starts, repeat. Right looks like: "…49.38 m2 goes straight out. Only the part that reaches the tank is detained."
6. **Tim's wording.** The new sentence is the builder's own, not Tim's. Record the line for Tim to read; do not accept it.
7. **If the offer does not appear.** The drawing already holds the areas. Use a fresh copy of a drawing with no site area recorded, and say what you used.

### K1985: #1985 (B-148, BUG-1258), Project Review "Pipe sizes" agrees with CDRULES. CODEX-ONLY (Project Review window)

1. **Why not the robot.** The Project Review Pipe sizes screen is a window the robot cannot read or close (the builder says the same, report q5, and the Opus pre-review asks for a Codex look). The CDRULES half is already #1857's and is not this PR's change.
2. **Set up.** Evidence folder `C:\CE_WORK\codex\k1985\`. Before AutoCAD starts, in a copy of the settings: Design standards UPVC speed limit blank (0); office Maximum pipe velocity 6.0; `pipeSpeedChecks.unsetMaterialUsesOfficeFigure` true and `pipeSpeedChecks.projectReviewUsesOfficeVelocityForUnsetMaterial` true.
3. **Draw.** On a copy of DRV1_B1 draw one gravity pipe in UPVC with a flow set and levels drawn (report q5, item 8).
4. **Run 1.** Type `CDRULES`, answer All. Read the speed line for that pipe: it says "office Maximum pipe velocity of 6.0 m/s; UPVC has no speed limit set in Settings, so the office figure is used" (DERIVED, q5). Then open Project Review > Proposals > Pipe sizes. Screenshot.
5. **Right looks like.** The pipe gets a real answer (Keep or Upsize) and the figure read is 6.0 m/s, the same as CDRULES. It does NOT say "Unknown: no speed limit is set in Settings for UPVC".
6. **Run 2 (the broken twin).** Set `projectReviewUsesOfficeVelocityForUnsetMaterial` to false, restart, repeat. Right looks like: Pipe sizes says "Unknown…" as before while CDRULES still says 6.0.
7. **Run 3.** Change the office Maximum pipe velocity to 5.5 and restart: both screens use 5.5 (the unit test pins this; look for it).
8. **Careful.** A pipe that used to be Unknown can now be offered an Upsize that the drafter can apply. Do not click apply on a drawing you care about; use the copy.

### K1987: #1987 (B-158, BUG-805), X-Civil import reads metres, the depth column and half-blank pipe rows. CODEX-ONLY (file pick box, results window)

1. **Why not the robot.** Same reason as K1982: the import starts from a file box, and the drawn-table route needs a drawing with a GN-ANNO-TABL table plus a vision-reply file.
2. **Make a made-up source drawing.** Evidence folder `C:\CE_WORK\codex\k1987\`. A copy of any drawing with a GN-ANNO-TABL pit table. Rows: one with a DEPTH header and "1.20m" under it plus an unlabelled "CL 8.45m"; one without a DEPTH header holding both "CL 8.45m" and "1.20m"; one pit width written "0.9 m". A pipe table with one row that has a blank end. (Use made-up numbers only.)
3. **Run 1 (ON, the default).** Import it; open the import results window. Screenshot the pit list, the pipe list and the warning lines.
4. **Right looks like.** Row 1: pit depth 1,200 mm (not 8,450). Row 2 (no DEPTH header, two candidates): depth Unknown, with a WARNING line saying so. Row 3: 900 mm (not 0.9 mm). The half-blank pipe row goes to no pipe, with a WARNING line. The results window shows both warnings (the Opus pre-review could not confirm they reach it; the PR has no end-to-end test).
5. **Run 2 (the broken twin).** Set `xcivilImport.scheduleReadsMetresAndDepthColumn` to false before AutoCAD starts, repeat. Right looks like the old answers: 8,450 for row 1, 0.9 mm for row 3, and the half-blank row assigned to a pipe.
6. **Extra look (Opus pre-review item 7.1).** Give the DEPTH column a BLANK cell on a row that also holds another "number m" figure. Record whether that other figure is taken as the depth. Do not decide it.
7. **What nobody knows yet.** Whether real consultant tables carry a DEPTH header. Record what a real-style (made-up) table does without one.

### K1986: #1986 (B-153, BUG-536 BP part), BP warns about an off-block Settings diameter. Use only until W1986 can run

1. **Set up.** Evidence folder `C:\CE_WORK\codex\k1986\`. Before AutoCAD starts set `BoredPierPlan.DefaultDiameterMm` to 500 in `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (copy the file first, put it back after).
2. **Run.** On a copy of DRV2_S1 type `BP`. Right looks like: one line "[BP] The pier diameter in Settings (Bored pier plan, default diameter) is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead. Pick 300, 450 or 600 here, or change the Settings value." then "Select pier diameter [300/450/600] <450>:". Press Enter, pick a point: a 450 pier is drawn.
3. **Control (600).** Settings 600, restart, `BP`: no warning line, the question reads <600>, Enter, pick a point: "[BP] 600 DIA. placed." and the placed block's visibility reads "600 DIA." (DERIVED, report q10). Screenshot the pier.
4. **Twin.** Set `FootingWidth.BoredPierBlockFollowsDiameter` to false with Settings 500, restart, `BP`: no warning line, the question still reads <450>.

---

## 4. Skipped items, and why

1. **No robot case for #1982, #1983, #1984, #1985, #1987.** Each needs something the robot may not do: a file pick box (#1982, #1987), a Save As box (#1983), a file placed in the job folder (#1984), a window it cannot read or close (#1985). Offering a half case that could only come back BLOCKED would waste a runner slot and could be mistaken for proof.
2. **No 600 control case for #1986.** It would carry the same runner gap. It is inside K1986.
3. **No locked-layer, REFEDIT or layout-tab case for #1988.** Those need a locked layer or a protected place; they need their own reviewed workflow before the robot touches them.
4. **No second twin for #1988 (a switch-off twin).** It would need the Structural settings path the runner does not accept. The REGEN twin covers the "back at once" checks.
5. **Order numbers 770 to 775 and 780 to 781 unused by me** because set 08 and set 09 already use them. I used 776 to 779. Orders 782 to 789 remain free.
6. **Read:** `C:\TimOS\RULES.md`; README_CASES.md in full; the style example `ROBOT_CASE_DRAFTS_BUG1195_UCS_02NOV.md`; the Opus pre-review of #1984 to #1988; the builders' reports q7, q8, q5, q10 and t3 (parts of t1 only through the pre-review); the earlier set 18 and set 21 drafts; the PR texts for #1982 to #1983 (`gh pr view`); the sources at the PR branches for the BP line and the STORM offer; the runner's SETTING code. **Not read:** the diffs of #1982, #1983, #1985 and #1987 line by line; the carpark entries; the ledger beyond a search for names. **Built:** nothing. **Tested:** nothing. **Not proven:** every DERIVED line, that Structural is loaded in the robot's AutoCAD, and that the runner's `number` check accepts two variables (existing cases use a variable against a variable with `>` and `<`; `>=` and `<=` against a variable are inferred from the README).
