# Robot case drafts, set 17: raingarden, Tidy labels default, pipe object, slab fall and CDSL (Mon 2 Nov 2026, Sonnet, Team, read-only drafter)

**What this is.** Three robot cases, each with a failing twin, and two Codex-only looks. Nothing was run, built, installed or opened in AutoCAD. The only file written is this one. No git write (git fetch, git log, git show and git grep only; gh read-only for the PR texts).

---

## FOR TIM

1. **Drafted:** 3 robot cases, each with a twin that must fail: W1847 (Tidy labels is on by default), W1759 (CDPIPEOBJ says metres in a metre drawing), W1813 (CDSL waits for both answers). That is 6 case texts.
2. **Skipped, already covered:** #1845 and #1870 (raingarden label). Cases N90 (plain RG label) and N90x (switch off, labels keep RG1 and RG2) already exist in `cases\drafts_c78_30oct`.
3. **Codex only (no robot case):** #1815 (the Inspector panel wording) and #1753 (slab fall). Steps are in section 4 below.
4. **A mistake in the brief, said first:** #1815 and #1813 are NOT in any release branch. Their code is only in the open PRs `pr/1815` and `pr/1813`; the newest Civil line (rel-20261102a, 3.0.88) has no raingarden-outlet switch and no CDSL change. So W1813 will fail on the installed build until that PR is merged and installed. Its twin cannot prove anything until then either.
5. **Needs an Opus review before it runs:** nothing in the three robot cases touches Undo, REDO, a locked layer or an Xref. The Codex look for #1753 does use Undo and REDO, so Codex should follow it exactly.
6. **Could not verify:** every printed line marked DERIVED was read from source, not seen on a run. W1759 only works if the pipe-upgrade gate is open on the robot's PC and the pipe object enabler is loaded (see its notes). W1847 reads the settings file as it stands: if that file already says `tidyLabelsEnabled` false, the main case goes red for that reason.
7. **Nothing for you to test or decide.** These go to the desk, then an Opus reviewer, then the robot.

---

## 1. How the drafts were written

1. **Format.** README_CASES.md format. Every `type` chain is a complete command, no `(`, no SAVE-type word. REVIEWED_AGAINST is empty in every case. Fixture DRV1_B1, SLOT fresh, order numbers 860 to 863.
2. **Twins.** W1847_BROKEN sets the PR's own switch OFF before launch through `SETTING CD_Settings.json` (the README mechanism; no settings file was read or written by me). W1813_BROKEN does the same with the PR's switch. W1759 has no switch, so its twin keeps the route and expects the old wrong answer ("0.0 m"), which a fixed build cannot print.
3. **What I read:** RULES.md; README_CASES.md and the allow-list (setvar may change INSUNITS; no refused button is pressed); the finished example TOP12_30OCT; the switch-off style in `variants\R09s_new_switch_off_broken`; cases R16, R24, N90 and N90x; the six PRs (bodies and diffs) and the source on `origin/claude/rel-20261102a` (3fbb9da5, Civil 3.0.88) and `pr/1813`; and a search of the cases folder (including every drafts_ folder), the ledger and the ROBOT_CASE_DRAFTS files by PR number, bug number, command and switch name.
4. **Built: nothing. Tested: nothing. Not proven:** every case below, and that the robot can reach any of them. Validate first with `pwsh -NoProfile -File case_runner.ps1 validate <folder>` (suggested folder `cases\drafts_set17_02nov\`).
5. **Check for an existing case (done).** No case id or draft covers #1815, #1847, #1759, #1753 or #1813. The existing Tidy cases (R16, N27, N57, N67) all set `tidyLabelsEnabled true` themselves, so none of them tests the default. N04 is DP and raingarden without a pipe and says nothing about the outlet wording.

---

## 2. The three robot cases

### Case 1 of 3: W1847, Tidy labels is on by default (PR #1847, B-008)

**Intended file:** `W1847_tidy_labels_on_by_default.case.txt`

```
# W1847 DRAFT (Sonnet read-only drafter, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR 1847 (B-008, Tim 29 Oct 2026: "yes"): linking.tidyLabelsEnabled ships ON.
# No SETTING line on purpose: the point is the shipped default. Per the PR body Tim's own CD_Settings.json holds no key, so it reads ON. If the settings file on the robot PC says tidyLabelsEnabled false, this case goes red for that reason (say so in the report, do not loosen the check).
# Prompt read from rel-20261102a TidyLabelsCommand.cs 159: 'Tidy labels on [All pipes/Select pipes] <All>: '. The off line and question are in TidyLabelsSummaryRule.cs 26 and 29.
# Nothing is moved: the case answers nothing and presses Esc at the first question.
CASE W1847
TITLE With nothing set, CDTIDYLABELS goes straight to its first question (All pipes or Select pipes) and does not say it is switched off
PLAN_ITEM B-008 (PR 1847) PART: the typed command with the shipped default. NOT whole: the Settings > Newer tools box showing ticked and the "Default: on." wording are a window look (Codex), and a PC whose file says false is the twin
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 860
TIMEOUT 600
BUG B-008
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDTIDYLABELS prints the scope question 'Tidy labels on [All pipes/Select pipes] <All>:' (DERIVED); the line 'Tidy labels is switched off. Nothing in the drawing was changed.' (DERIVED) never appears; Esc ends the command; the object count and the drawing file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST The unit tests read the default through two settings reads; only the live command shows what a colleague typing CDTIDYLABELS meets on a PC with no key in its file.
NOT_AUTOMATED The Settings window box (ticked) and its "Default: on." words, and the ribbon button, are not driven here (Codex look).
NOT_AUTOMATED Apply with Yes and the U of the move are covered by N67, not here.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDTIDYLABELS" -Force -TimeoutSec 90 -> $tidy
  esc-prompt -> $tidy_esc
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  contains $tidy "Tidy labels on [All pipes/Select pipes]"
  not-contains $tidy "switched off"
  history absent "Tidy labels is switched off"
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $tidy "FULL what CDTIDYLABELS printed (DERIVED wording)"
  record $tidy_esc "what the Esc printed"
```

**Twin:** `W1847_BROKEN.case.txt`

```
# W1847_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin: linking.tidyLabelsEnabled is set false before AutoCAD starts, so the command behaves as before the fix (says it is switched off and offers to switch it on). The case still expects the scope question, so it MUST FAIL on the first check. Same route, same checks. README: do NOT use hashes-unchanged in a case that sets a key.
CASE W1847_BROKEN
TITLE BROKEN VARIANT of W1847: Tidy labels switched OFF in Settings before launch, case still expects the scope question (must FAIL)
PLAN_ITEM red-before-green proof for W1847 (B-008)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 861
TIMEOUT 600
BUG B-008
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1847
SETTING CD_Settings.json linking.tidyLabelsEnabled false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch off the command prints 'Tidy labels is switched off. Nothing in the drawing was changed.' (DERIVED) and asks 'Switch Tidy labels on for this computer now?' (DERIVED), so 'contains Tidy labels on [All pipes/Select pipes]' fails.
WHY_NOT_UNIT_TEST It exists only to prove W1847's main check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDTIDYLABELS" -Force -TimeoutSec 90 -> $tidy
  esc-prompt -> $tidy_esc
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  contains $tidy "Tidy labels on [All pipes/Select pipes]"
  not-contains $tidy "switched off"
  history absent "Tidy labels is switched off"
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $tidy "FULL what CDTIDYLABELS printed with the switch off (DERIVED wording)"
```

---

### Case 2 of 3: W1759, CDPIPEOBJ says the length in metres in a metre drawing (PR #1759, BUG-1055)

**Intended file:** `W1759_cdpipeobj_length_in_metre_drawing.case.txt`

```
# W1759 DRAFT (Sonnet read-only drafter, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR 1759 (BUG-1055), in rel-20261102a (NativePipeObjectCommands.PipeObjectDrawnLine).
# Route as the PR body's own check: INSUNITS 6, CDPIPEOBJ, pick 0,0 then 10,0, Enter, width 100, Single; then INSUNITS 4 and the same pipe at x 10000. Both must say '10.0 m, 100 mm'.
# Prompts read from NativePipeObjectCommands.cs 57 to 87: 'First point of the pipe object:', 'Next point (Enter to finish):', 'Pipe width (mm) <..>:', 'Single or twin barrels? [Single/Twin] <Single>:'. Printed line (PipeObjectDrawnLine): '[CE] Pipe object drawn: 10.0 m, 100 mm, 2 points. ...' (DERIVED).
# GATE WARNING: CDPIPEOBJ is held on colleagues' PCs ('Pipe upgrade is held on this PC until it is proven on AutoCAD 2022-2024.', PipeObjectUpgradeGate.cs 40) and needs AutoCAD 2027 with the CE enabler ('CDPIPEOBJ needs the CE pipe object enabler (AutoCAD 2027 only). Nothing was drawn.'). On a PC where either holds, the first check fails with that line in the report; that is a setup fact, not a result about the fix. Whether the robot PC's gate is open is NOT known.
# INSUNITS is set with the driver's own setvar on a millimetre master (as case R24 does); the copy is never saved. The (0,0) area is not known to be empty on DRV1_B1 (its pits sit around x 100000 to 175000): the case counts new objects, not all objects.
CASE W1759
TITLE CDPIPEOBJ for a 10 m pipe prints '10.0 m, 100 mm' in a metre drawing and again in a millimetre drawing
PLAN_ITEM BUG-1055 (PR 1759) PART: the typed completion line, single barrel, two lengths. NOT whole: twin barrels, the width prompt in metre drawings, and the drawn pipe's own size are not checked; an unchanged 'Pipe object drawn' wording elsewhere is not read
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 862
TIMEOUT 900
BUG BUG-1055
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED With INSUNITS 6 the history holds 'Pipe object drawn: 10.0 m, 100 mm, 2 points.' (DERIVED); after INSUNITS 4 and a 10000 long pipe the same sentence appears a second time; the word '0.0 m' never follows 'Pipe object drawn:'; each run adds at least one new object; no CE window is left open.
WHY_NOT_UNIT_TEST The 5 unit tests read the sentence builder; only the live command shows which length it is handed in a drawing whose units were changed after CE loaded.
NOT_AUTOMATED Twin barrels and the held/enabler gate are not driven. A drawing AUTHORED in metres does not exist here: INSUNITS is switched on a millimetre master after CE has loaded (same artefact as R24), so a red could be that and not the fix.
STEPS
  v3 setvar INSUNITS 6
  getvar INSUNITS -> $iu6
  ms-count -> $c0
  type "CDPIPEOBJ{NL}0,0{NL}10,0{NL}{NL}100{NL}Single" -Force -TimeoutSec 120 -> $t_m
  wait
  ms-new $c0 -> $new_m
  v3 setvar INSUNITS 4
  getvar INSUNITS -> $iu4
  ms-count -> $c1
  type "CDPIPEOBJ{NL}0,5000{NL}10000,5000{NL}{NL}100{NL}Single" -Force -TimeoutSec 120 -> $t_mm
  wait
  ms-new $c1 -> $new_mm
  windows-snapshot -> $win_end
ASSERT
  equals $iu6 "6"
  equals $iu4 "4"
  history absent "Pipe upgrade is held"
  history absent "needs the CE pipe object enabler"
  history has "Pipe object drawn: 10.0 m, 100 mm"
  history count "Pipe object drawn: 10.0 m, 100 mm" = 2
  history absent "Pipe object drawn: 0.0 m"
  count $new_m >= 1
  count $new_mm >= 1
  not-contains $win_end "Creative Engineering"
  record $t_m "FULL what CDPIPEOBJ printed in the metre drawing (DERIVED wording)"
  record $t_mm "FULL what CDPIPEOBJ printed in the millimetre drawing"
```

**Twin:** `W1759_BROKEN.case.txt`

```
# W1759_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The old wrong answer: before the fix a 10 m pipe in a metre drawing read '0.0 m' (BUG-1055 body). Same route; the metre-drawing check is reversed to expect '0.0 m', which the fixed build cannot print, so the case MUST FAIL. All route checks kept.
CASE W1759_BROKEN
TITLE BROKEN VARIANT of W1759: the metre drawing is expected to say '0.0 m' (the old bug), must FAIL
PLAN_ITEM red-before-green proof for W1759 (BUG-1055)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 863
TIMEOUT 900
BUG BUG-1055
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1759
REVIEWED_AGAINST
EXPECTED Wrong on purpose: on the fixed build the history holds '10.0 m', so 'history has "Pipe object drawn: 0.0 m"' fails.
WHY_NOT_UNIT_TEST It exists only to prove W1759's main check can go red.
STEPS
  v3 setvar INSUNITS 6
  getvar INSUNITS -> $iu6
  ms-count -> $c0
  type "CDPIPEOBJ{NL}0,0{NL}10,0{NL}{NL}100{NL}Single" -Force -TimeoutSec 120 -> $t_m
  wait
  ms-new $c0 -> $new_m
  windows-snapshot -> $win_end
ASSERT
  equals $iu6 "6"
  history absent "Pipe upgrade is held"
  history absent "needs the CE pipe object enabler"
  count $new_m >= 1
  history has "Pipe object drawn: 0.0 m"
  not-contains $win_end "Creative Engineering"
  record $t_m "FULL what CDPIPEOBJ printed in the metre drawing (DERIVED wording)"
```

---

### Case 3 of 3: W1813, CDSL asks both questions before it brings in the block (PR #1813, BUG-1201)

**Intended file:** `W1813_cdsl_esc_changes_nothing.case.txt`

```
# W1813 DRAFT (Sonnet read-only drafter, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR 1813 (BUG-1201), switch linking.spotLevelImportsAfterPick (UserSettings.cs line 543 of pr/1813, default true).
# NOT IN ANY RELEASE BRANCH: the code exists only in the open PR pr/1813 (base rel-20261026u). rel-20261102a still prints 'CDSL command cancelled.' (SpotLevelCommand.cs 83). Run this ONLY after #1813 is merged and installed; before that it FAILS on the first check, known.
# What the PR says: Esc at the first question prints '[CE] CDSL command cancelled. Nothing was changed.' (pr/1813 SpotLevelCommand.cs 85; DERIVED); the older build printed 'CDSL command cancelled.' and left the SPOT LEVEL block definition behind.
# The block definition cannot be read by the robot (the model-space reads see inserted objects, not the block table), and DRV1_B1 may already hold a SPOT LEVEL definition (case R16 moves an existing one, handle 10EC5D). So the checkable difference is the sentence, plus the CE log not importing: 'Loaded block' lines (BlockService.cs 499 and 826) are RECORDED, not asserted, because a definition already in the drawing would give no such line on either build.
CASE W1813
TITLE CDSL answered with Esc at its first question prints 'Nothing was changed', draws nothing and leaves no window open
PLAN_ITEM BUG-1201 (PR 1813) PART: Esc at the FIRST question only. NOT whole: Esc at the level question, an accepted P18.600 placement that reuses the definition, the Settings box and the block table itself (the robot cannot read it) are not driven here
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 864
TIMEOUT 600
BUG BUG-1201
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDSL starts a point question (wording not known before a run); Esc ends it; the history holds '[CE] CDSL command cancelled. Nothing was changed.' (DERIVED); the object count and the drawing file on disk do not change; no CE window is left open.
WHY_NOT_UNIT_TEST The unit tests pass a stand-in for the prompts; only the live command shows what the drafter reads when pressing Esc and what stays in the drawing.
NOT_AUTOMATED The unused SPOT LEVEL definition (the real bug) cannot be read by the robot. The first-run reviewer must say whether DRV1_B1 already holds one; if it does, only the sentence is proven. A Codex step to read the block list (Insert > Blocks, or BLOCK names in the PURGE list, read only, never press Purge) is in section 4.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDSL" -Force -TimeoutSec 90 -> $t_sl
  esc-prompt -> $e_sl
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history has "CDSL command cancelled. Nothing was changed."
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $t_sl "FULL what CDSL printed (first question wording not known)"
  record $e_sl "what the Esc printed"
```

**Twin:** `W1813_BROKEN.case.txt`

```
# W1813_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off twin: linking.spotLevelImportsAfterPick false before AutoCAD starts, which the PR says restores the earlier order (block prepared before the first question, the older wording on Esc). The case still expects the new sentence, so it MUST FAIL on the first check. Note: 'log civil count "Loaded block" = 0' is removed here because a definition already in the drawing gives no line either way (see W1813's header); the sentence is the discriminator.
CASE W1813_BROKEN
TITLE BROKEN VARIANT of W1813: the new CDSL order switched OFF, case still expects 'Nothing was changed' (must FAIL)
PLAN_ITEM red-before-green proof for W1813 (BUG-1201)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 865
TIMEOUT 600
BUG BUG-1201
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1813
SETTING CD_Settings.json linking.spotLevelImportsAfterPick false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch off the older line 'CDSL command cancelled.' is printed (rel-20261102a SpotLevelCommand.cs 83), so 'history has "CDSL command cancelled. Nothing was changed."' fails.
WHY_NOT_UNIT_TEST It exists only to prove W1813's main check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "CDSL" -Force -TimeoutSec 90 -> $t_sl
  esc-prompt -> $e_sl
  wait
  ms-count -> $c1
  windows-snapshot -> $win_end
ASSERT
  history has "CDSL command cancelled. Nothing was changed."
  equals $c1 $c0
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $t_sl "FULL what CDSL printed with the switch off"
  record $e_sl "what the Esc printed"
```

**Order numbers:** the brief allows 860 to 869; the six texts use 860 to 865. W1813's first-run caveat (the case can only be red-then-green once #1813 is installed) means its ledger entry will read "still fails, known" until then.

---

## 3. Whole or part, in one place

1. **W1847:** PART. The typed command with the default only.
2. **W1759:** PART. One single-barrel pipe, two lengths. The enabler and held gate are a precondition, not checked.
3. **W1813:** PART, and not runnable until #1813 is installed. Esc at the first question only.

---

## 4. Codex look notes (BLOCKED-FOR-ROBOT)

### 4.1 #1815 (BUG-1107): the Inspector says "[CE] Outlet not tracked"

**BLOCKED-FOR-ROBOT, one line:** the wording is shown only in the Inspector panel (a window), and the robot has no read of that panel for a raingarden. Also not merged: the code is only in `pr/1815`, so this look is for after #1815 is installed.

1. **Setup.** Copy of DRV1_B1 (never the master). Switch `linking.raingardenOutletRecorded` is ON by default (older file reads ON).
2. **Draw.** Type `CDRG`, pick a raingarden whose grated inlet has a pipe to pit P3 (the PR's own scene). Then select the raingarden boundary and open the Inspector (Civil Properties).
3. **Right looks like:** the outlet reads `[CE] Outlet not tracked` (not `No outlet registered`, not `Unknown`). An outlet already saved as P3 still reads P3. A garden with no inlet pipe keeps the older words.
4. **Switch off.** Set `linking.raingardenOutletRecorded` false before AutoCAD starts: the older words come back.
5. **Evidence.** Screenshots in a new folder under `C:\CE_WORK\codex\bug1107_<date>\`. Never capture a folder a file box opened in.
6. **Not part of this look:** the Settings row, which the PR left out under its height limit.

### 4.2 #1753 (BUG-1051): slab fall worked out in physical units

**BLOCKED-FOR-ROBOT, one line:** CDSLAB opens the Slab Fall Design window, whose Save/Apply buttons the robot may not press, and a registered concrete slab is needed first. The check also uses U and REDO.

1. **Setup.** Two copies of one drawing. Copy A: INSUNITS 6 (metres), points A 0,0 / B 10,0 / C 0,10, levels FSL 10.001 / 10.000 / 10.001. Copy B: INSUNITS 4 (millimetres), every X and Y times 1000. Use a registered concrete slab.
2. **Run CDSLAB** on each copy, entering the three points.
3. **Right looks like:** in the Slab Fall Design window the metre copy warns the triangle is flatter than 1:100 (it must not say every triangle meets the minimum). The millimetre copy reads as before.
4. **Run CDSLABEREGEN**, pick the boundary, read FALL_GRADE on the arrow: 1:10000 on both copies.
5. **Undo.** Press U once: the arrows go. REDO brings them back. Check the slab outline is not changed.
6. **Evidence.** Screenshots of each window and a read of FALL_GRADE under `C:\CE_WORK\codex\bug1051_<date>\`. Do not save either copy.
7. **Honest limit:** the PR says the Slab Fall Design window used to claim every triangle meets 1:100 in a metre drawing; the PR does not give the window's exact warning wording, so Codex should record what it prints.

---

## 5. Fixes skipped, and why

1. **#1845 (B-007) and #1870 (B-007b):** skipped. Covered by `N90_plain_rg_label_on_guidelines` and its switch-off twin `N90x_plain_rg_switch_off` (plus `N90_plain_rg_label_on_guidelines_BROKEN`) in `cases\drafts_c78_30oct`, both for the final behaviour (plain RG on the plan, RG1 and RG2 in the tag). Both are builder-filled and still need an Opus review, so they are drafts, not accepted cases. Not re-drafted.
2. **#1815 and #1753:** Codex-only (section 4), not skipped for cover.

---

## 6. What was read, built, tested and NOT proven

1. **Read:** the files named in section 1, and the PR bodies and diffs for all six PRs (`gh` worked once I added its folder to PATH for my own shell; later calls without that PATH could not find it, so the local `pr/<number>` refs were used after that).
2. **Built:** nothing. **Tested:** nothing. **AutoCAD opened:** no. **Robot run:** no. **Settings files read or written:** none.
3. **NOT proven:** that any of the three cases validates, that the printed lines match a real run, that the robot PC's pipe gate is open for W1759, that DRV1_B1 has an empty (0,0) area, that the fixture holds no SPOT LEVEL definition for W1813, and that the settings file has no `tidyLabelsEnabled` key for W1847.
