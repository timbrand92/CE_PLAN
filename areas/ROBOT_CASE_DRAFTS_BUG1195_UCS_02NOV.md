# Robot case drafts: BUG-1195 UCS label rotation, import scale warning, Updates and Rollback screen (Mon 2 Nov 2026, evening Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written.

---

## FOR TIM

1. **Six robot case texts drafted: three cases, each with a twin that must fail.** W1888 (UCS label angle), W1888P (the same route, position only) and W1876 (Updates & Rollback opens its own screen). Order numbers 750 to 755.
2. **The robot cannot read a label's angle today.** Its "read one object" step returns the text and its position for a text label, and no angle. So W1888 and its twin are written in full but must NOT be run until one reviewed one-line driver change adds the angle. I made no driver change.
3. **What runs today for BUG-1195:** W1888P. It draws the two-legged pipe under the turned UCS, moves the label to the other leg and back, and checks the label really moved each time. It does NOT prove the angle. The angle itself stays a Codex look (K2_01 below). Codex already saw it PASS SURE (report B2c, 2 Nov 1900).
4. **One thing in your brief is not quite right.** The label on the 135 degree leg is stored at 315 degrees (the same line, text turned round so it reads upright). Codex saw it at minus 45 degrees on screen. W1888 checks 315, not 135.
5. **The import window warnings (B2-02a and B2-02b) are Codex only.** The robot cannot press "Read source" or choose a file, so it never reaches the page. Exact Codex steps are K2_02 and K2_03. Codex already saw both PASS SURE (B2 report, 2 Nov 1646).
6. **Updates & Rollback (B3-01):** the robot can prove the window title ("CE Suite Manager" and not "Admin Dashboard"), not which tab is selected. The fix's own switch sits in a file the robot cannot set, so the twin is a wrong-on-purpose twin, not a switch-off twin. Codex already saw PASS SURE (B3 report, 2 Nov 1702).
7. **Not verified:** every printed line and window word marked DERIVED was read from reports or code, not seen on a run. The robot's AutoCAD may not be on the installed Civil 3.0.89 build, and fixture DRV1_B1 may already hold objects near the new pipe (first run will show). Nothing for you to test or decide.

---

## 1. Facts checked, and where each came from

1. **PR #1888 exists (read with `gh pr view 1888`).** Title "B-072 BUG-1195: CDTEXTSEG with a turned UCS leaves the pipe label at the wrong angle". State OPEN, a draft. Base `claude/rel-20261102a`, head `claude/b072-bug1195-textseg-ucs`. B-number: **B-072**.
2. **The switch is `linking.pipeTextMoveAngleFollowsUcs`, ON by default.** Read in the PR's `REGRESSION_LOG.md` entry and in `UserSettings.cs` and the test file `Bug1195TextSegUcsAngleTests.cs` on the PR head. Settings file: `CD_Settings.json`, group `linking`. OFF returns the old angle exactly (the PR says so).
3. **The fix is in the installed build.** Commit `61fd6fbc` (Civil 3.0.89, Manager 1.1.89, version commit of 1 Nov 04:24) holds the UCS key, `scaleNoteOnReviewPage` and `updatesButtonOpensOwnScreen`. Codex's reports name the same commit. **Mismatch to know about:** the `origin/claude/rel-20261102a` I fetched (tip `3fbb9da5`, Civil 3.0.88) does NOT contain `61fd6fbc`. The later release-train branches do. The case facts below were read at `61fd6fbc`, not at the 02 Nov tip.
4. **The rule in code (`PipeTextPlacementService.TextRotationForSegment`).** With the fix on, the label angle is the leg's direction in World, then the keep-it-readable rule: an angle between 90 and 270 degrees gets 180 added. Before the fix the angle was measured in the UCS and written as a World angle.
5. **DERIVED by me from the points (never seen on a run):** with UCS 45 degrees about Z the typed World points become, in UCS, leg A horizontal (56500,-164000 to 68500,-164000, 12 m) and leg B vertical (68500,-164000 to 68500,-156000, 8 m). That matches Codex's screen description of both runs ("horizontal first leg, vertical second leg" in the UCS view; a sideways V in the World view).
   1. **Fixed values:** leg A label 45 degrees = 0.7854 rad. Leg B leg direction is 135 degrees, but the stored angle is 315 degrees = 5.4978 rad (upright). Codex saw "+45" and "-45".
   2. **Old values with the switch OFF (DERIVED):** leg A 0 (flat, as the PR says). Leg B about 1.5708 rad (the UCS vertical), or 4.7124 if rounding lands just past 90 degrees. Not 0, so the old fault on leg B is "vertical", not "flat". Either value fails the check.
6. **The robot cannot read a text label's angle.** Read in `acad_driver_v3.ps1` (`Get-V3EntityInfo`, line 819 on): for a text or MText object it returns text and insertion point only; `rotation` exists only for block references. `Read-CaseMsItem` in `case_runner_lib.ps1` (line 241 on) gives index, handle, object, layer, name, text, x and y only. So `ent-read`, `select` and `field` cannot give the angle. The closest provable form today is the label's position (W1888P). The request to the desk: add `$info.rotation = [double](Get-ComV $e 'Rotation')` to the text branch of `Get-V3EntityInfo`. That is a read-only property read, but the driver is pinned by a reviewed hash, so it needs a reviewed edit. Not made.
7. **The Codex route that worked (B2c report).** In the first Codex run (B2, 1646) the CDTEXTSEG picks answered "Nothing Selected", because the view had been set in the wrong coordinates. In B2c the view `_.ZOOM _C 64000,-162000 22000` was typed after the UCS turn (these numbers are UCS values) and then both CDTEXTSEG moves worked. W1888 uses exactly that zoom.
8. **B2-02: two PRs, two switches (read with `gh pr list` and the regression log at `61fd6fbc`).**
   1. **#1926, B-112 BUG-505:** `xcivilImport.scaleNoteOnReviewPage`, ON. Puts the CHECK THE SCALE or no-units sentence at the top of the import window's "Pit and pipe schedule" page. OFF shows the two old sentences only.
   2. **#1853, B-010 BUG-505:** `xcivilImport.noUnitsNote`, ON. Adds "This drawing has no units set; CE read it as millimetres." (command line and window). OFF is the old silence.
   3. **Exact words Codex saw (B2 report, 2 Nov 1646, PASS SURE both).** B2-02a status: "CHECK THE SCALE: the source drawing records no units, so the 1000 times scale (metres to millimetres) is a guess from the size of the objects. Check the first pit and pipe look right after the import." then a new line "Check the schedule before accepting the import." B2-02b status: "This drawing has no units set; CE read it as millimetres." then "Check the schedule before accepting the import."
9. **B3-01: PR #1876, B-058 BUG-1247 (read with `gh pr view 1876`).** Title "Updates & Rollback opens the drafter's own Updates screen". OPEN draft, base `claude/rel-20261102a`. The switch is `updatesButtonOpensOwnScreen`, ON by default, in **`%APPDATA%\CE_SUITE\manager-switches.json`** (read in `CeOneGlanceStatus.cs` at `61fd6fbc`). That is not one of the four settings files the runner's SETTING line can set. Old fault (Tim's hand checks H44, H45, H47, Manager 1.1.85): the window opened as "CE Suite Manager | Admin Dashboard". An older fix, PR #1595 (BUG-948, no switch), already sent a non-administrator to the Updates tab.
10. **Which windows the robot may read.** The v3 allow-list (`acad_driver_v3.allowlist.json`) lists `*X-Civil import*` (press: Choose DWG..., Close, Cancel) but NOT "CE Suite Manager". "Read source", "Import to drawing", Install and Admin Dashboard are not pressable, and the file box ("Select File", "Open") only allows Cancel. `windows-snapshot` and `windows-new` list window titles of any AutoCAD window (accepted cases use them for "Edit source" and "Enhanced Attribute Editor").

---

## 2. Case texts

**How these are written.** README_CASES.md format. Every `type` chain is a complete command with no `(` and no SAVE-type word. Fixture DRV1_B1, SLOT fresh. REVIEWED_AGAINST is empty. Run alone, outside Tim's hours. Validate first, without AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_bug1195_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or bypasses a protection.

### Case 1 of 3: W1888 and W1888_BROKEN (rotation form, needs the driver change)

**Intended file:** `W1888_cdtextseg_label_angle_follows_turned_ucs.case.txt`

```
# W1888 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1888, B-072, BUG-1195 (carpark stays OPEN). Switch linking.pipeTextMoveAngleFollowsUcs, ON by default (this case sets nothing: it proves the shipped default, as Codex B2c did).
# DO NOT RUN until the driver reads a text label's angle: ent-read on a text or MText object returns text and insertion only (acad_driver_v3.ps1 Get-V3EntityInfo). Today the two 'matches ... rotation' checks would FAIL with "no rotation in the read", which is a tool gap and not a result. The one-line change wanted: add the label's Rotation to the text branch. Needs a reviewed driver edit and Tim's word. W1888P below runs today and proves the route and the label moves, not the angle.
# Route (Codex B2c, PASS SURE): UCS Z 45, view _C 64000,-162000 22000 (UCS values, typed AFTER the turn), CD with three typed WORLD points (CD switches to World: 'CD - UCS temporarily switched to World'), New Pipe 100 mm UPVC, levels 18.000 and 17.900, Set my own 1 in 200 (a 12 m leg then an 8 m leg falls 100 mm in 20 m, so no Grade mismatch window), Start Pipe, Esc for the 'move arrow AND text' question and the next-pipe prompt. Then CDTEXTSEG twice. The first pick of each CDTEXTSEG is ON THE PIPE LINE (not on the label, or CE says 'That is not a pipe'); the second pick is the leg to move to.
# Leg B: first pick 157191,-74743 (on leg A), second pick 161574,-64700 (on leg B). Back to leg A: first pick 159876,-63003 (on leg B), second pick 158040,-73894 (on leg A). All four are within 1 mm of the leg lines (checked by arithmetic: legs run at 45 and 135 degrees).
# What is judged (DERIVED, never read by a run): the label's stored angle. On leg B the leg runs at 135 degrees in the drawing and CE keeps text readable, so the stored angle is 315 degrees = 5.4978 rad (Codex saw -45 degrees on screen); on leg A 45 degrees = 0.7854 rad. Regex bands are about 1.5 degrees either side.
# Remembered values: YES. New Pipe saves Set my own 200, the two inverts and the size to CD_RecentValues.json; the guard does not restore that file (Codex B2c: the desk restores it).
CASE W1888
TITLE With the UCS turned 45 degrees, CDTEXTSEG lays the pipe label along the leg it moves to: 315 degrees (upright, along the 135 degree leg) on leg B and 45 degrees on leg A
PLAN_ITEM PR #1888 (B-072, BUG-1195) PART: the stored angle of the label after each CDTEXTSEG move, read from the drawing. NOT whole: that the label looks upright, readable and clear of the pipe is a Codex picture (K2_01); the CD and Edit Pipe 'move arrow AND text' prompts are not driven (Esc is used); the flow arrow on the CDEDIT route is a separate open item
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 750
TIMEOUT 1500
BUG BUG-1195
PROVES_BUGS BUG-1195 (the label angle half only, and only once the driver reads text angles)
REVIEWED_AGAINST
EXPECTED After UCS Z 45 (UCSXDIR about 0.7071,0.7071) and CD from World 155919,-76016 through 164402,-67527 to 158745,-61872 (levels 18.000 and 17.900, 1 in 200): one new pipe and one new label reading '100 DIA. UPVC PIPE AT 1 IN 200'. CDTEXTSEG with picks 157191,-74743 then 161574,-64700 prints 'Pipe text moved.' and the label angle reads 315 degrees (5.4978 rad). CDTEXTSEG with picks 159876,-63003 then 158040,-73894 prints 'Pipe text moved.' and the label angle reads 45 degrees (0.7854 rad). The UCS is back to World. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the angle sum on its own; only a live CDTEXTSEG under AutoCAD's real turned UCS shows what angle lands on the real label.
NOT_AUTOMATED How the label looks (upright, readable, parallel, clear of the pipe): Codex look K2_01.
NOT_AUTOMATED A pipe between pits, a pipe with more than two legs and a UCS about another axis are not driven. U after CDTEXTSEG is not driven.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs
  wait
  getvar UCSXDIR -> $xdir
  type "_.ZOOM _C 64000,-162000 22000" -Force
  wait
  type "CD{NL}155919,-76016{NL}164402,-67527{NL}158745,-61872{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $e1
  esc-prompt -> $e2
  esc-prompt -> $e3
  wait
  ms-new $c0 -> $after0
  select $after0 "object~^CeCvlPipeObject$" -> $pipe
  select $after0 "text~DIA\. " -> $lab0
  field $lab0 handle -> $hlab
  field $lab0 text -> $lab_text
  type "CDTEXTSEG{NL}157191,-74743{NL}161574,-64700" -Force -TimeoutSec 120 -> $ts_b
  wait
  ent-read "{$hlab}" -> $ent_b
  type "CDTEXTSEG{NL}159876,-63003{NL}158040,-73894" -Force -TimeoutSec 120 -> $ts_a
  wait
  ent-read "{$hlab}" -> $ent_a
  type "_.UCS{NL}_W" -Force -> $ucsw
  wait
  windows-snapshot -> $win_end
ASSERT
  matches $xdir "0\.70\d"
  count $pipe = 1
  count $lab0 = 1
  contains $lab_text "UPVC PIPE AT 1 IN 200"
  contains $ts_b "Pipe text moved."
  # DERIVED, and unreadable until the driver change: 315 degrees = 5.4978 rad (upright along the 135 degree leg)
  matches $ent_b "rotation.:5\.(4[7-9]|5[0-2])"
  contains $ts_a "Pipe text moved."
  # DERIVED, and unreadable until the driver change: 45 degrees = 0.7854 rad
  matches $ent_a "rotation.:0\.(7[6-9]|80)"
  history count "Pipe text moved." = 2
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $cd "FULL CD under the turned UCS"
  record $e3 "FULL after the third Esc"
  record $ts_b "FULL first CDTEXTSEG (to leg B)"
  record $ent_b "FULL label after the move to leg B (angle is in this read once the driver change is made)"
  record $ts_a "FULL second CDTEXTSEG (back to leg A)"
  record $ent_a "FULL label after the move back to leg A"
  record $lab_text "label text"
```

**Twin:** `W1888_BROKEN_cdtextseg_label_angle_follows_turned_ucs.case.txt`

```
# W1888_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off control (the style of R09s_new_switch_off_broken): linking.pipeTextMoveAngleFollowsUcs false before AutoCAD starts, so the old angle returns. Same route, same checks as W1888. It must FAIL on the two 'matches ... rotation' checks: DERIVED old values are 0 on leg A and about 1.5708 on leg B (the UCS angle written as a World angle; the PR says the label 'stayed flat').
# Same warning as W1888: do not run before the driver reads a text label's angle. Today it would also fail, but for the wrong reason (no angle in the read), so a red result today proves nothing. After the driver change, if it PASSES, the old build also gives these angles here and W1888 cannot tell old from new: send the item to Codex look K2_01 and say so.
CASE W1888_BROKEN
TITLE BROKEN VARIANT of W1888: the new switch is OFF, the old angle returns, the case still expects the label along the leg (must FAIL)
PLAN_ITEM red-before-green proof for W1888 (PR #1888, B-072, BUG-1195)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json linking.pipeTextMoveAngleFollowsUcs false
ORDER 751
TIMEOUT 1500
BUG BUG-1195
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1888
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the label is written at the UCS angle, so the angle checks fail on both legs; the route, the two 'Pipe text moved.' lines and the unchanged file still pass.
WHY_NOT_UNIT_TEST It exists only to prove W1888's angle checks can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs
  wait
  getvar UCSXDIR -> $xdir
  type "_.ZOOM _C 64000,-162000 22000" -Force
  wait
  type "CD{NL}155919,-76016{NL}164402,-67527{NL}158745,-61872{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $e1
  esc-prompt -> $e2
  esc-prompt -> $e3
  wait
  ms-new $c0 -> $after0
  select $after0 "object~^CeCvlPipeObject$" -> $pipe
  select $after0 "text~DIA\. " -> $lab0
  field $lab0 handle -> $hlab
  type "CDTEXTSEG{NL}157191,-74743{NL}161574,-64700" -Force -TimeoutSec 120 -> $ts_b
  wait
  ent-read "{$hlab}" -> $ent_b
  type "CDTEXTSEG{NL}159876,-63003{NL}158040,-73894" -Force -TimeoutSec 120 -> $ts_a
  wait
  ent-read "{$hlab}" -> $ent_a
  type "_.UCS{NL}_W" -Force -> $ucsw
  wait
ASSERT
  count $pipe = 1
  count $lab0 = 1
  contains $ts_b "Pipe text moved."
  matches $ent_b "rotation.:5\.(4[7-9]|5[0-2])"
  contains $ts_a "Pipe text moved."
  matches $ent_a "rotation.:0\.(7[6-9]|80)"
  copy-unchanged $copy0
  record $ent_b "FULL label after the move to leg B, switch OFF"
  record $ent_a "FULL label after the move back to leg A, switch OFF"
```

### Case 2 of 3: W1888P and W1888P_BROKEN (position form, runs today)

**Intended file:** `W1888P_cdtextseg_under_turned_ucs_moves_label_between_legs.case.txt`

```
# W1888P DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). The part of PR #1888 (B-072, BUG-1195) the robot CAN read today: with the UCS turned 45 degrees, the shipped route draws the two-legged pipe, and CDTEXTSEG moves the label to leg B and back to leg A. It reads WHERE the label is, never its angle (the driver returns no angle for text; see W1888).
# It guards the thing that blocked Codex's first run (B2, 1646: 'Nothing Selected' because the view was wrong): after the turn, the view and the typed picks are right and both moves are accepted. It does NOT tell the fix from the old build (the position probably does not depend on the switch; DERIVED, not known), so it is a PART claim of the route only. PROVES_BUGS is empty.
# DERIVED, never read by a run: the middle of leg A is World (160160,-71771) and of leg B (161573,-64699) (arithmetic from the typed points); CE puts a label beside the middle of its leg (P01 reads the x of the label for the same purpose); the label starts on leg A (Codex B2c: label along leg A after Start Pipe). The 4000 mm bands are the half the distance between the two middles (about 7400 mm).
# Route identical to W1888. Remembered values: YES (same as W1888).
CASE W1888P
TITLE Under a UCS turned 45 degrees, CDTEXTSEG moves the pipe label from leg A to leg B and back (the label sits beside the middle of the leg it was sent to)
PLAN_ITEM PR #1888 (B-072, BUG-1195) PART: the route under the turned UCS works and the label moves to the picked leg each time. NOT the angle (W1888 needs the driver change; Codex look K2_01)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 752
TIMEOUT 1500
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After UCS Z 45 and the three-point CD pipe (1 in 200, levels 18.000 and 17.900): one new pipe and one label reading 'UPVC PIPE AT 1 IN 200', within 4000 mm of the middle of leg A (160160,-71771). After CDTEXTSEG (picks 157191,-74743 then 161574,-64700) it prints 'Pipe text moved.' and the label is within 4000 mm of the middle of leg B (161573,-64699). After CDTEXTSEG (picks 159876,-63003 then 158040,-73894) it prints 'Pipe text moved.' and the label is within 4000 mm of the middle of leg A again. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests do not drive CDTEXTSEG under AutoCAD's live turned UCS, where the first Codex run got 'Nothing Selected'.
NOT_AUTOMATED The label angle (W1888) and how it looks (Codex look K2_01). Whether the fix is on: this case passes with the switch off as well (DERIVED).
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs
  wait
  getvar UCSXDIR -> $xdir
  type "_.ZOOM _C 64000,-162000 22000" -Force
  wait
  type "CD{NL}155919,-76016{NL}164402,-67527{NL}158745,-61872{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $e1
  esc-prompt -> $e2
  esc-prompt -> $e3
  wait
  ms-new $c0 -> $after0
  select $after0 "object~^CeCvlPipeObject$" -> $pipe
  select $after0 "text~DIA\. " -> $lab0
  field $lab0 handle -> $hlab
  field $lab0 text -> $lab_text
  dist $lab0 "160160,-71771" -> $dA0
  type "CDTEXTSEG{NL}157191,-74743{NL}161574,-64700" -Force -TimeoutSec 120 -> $ts_b
  wait
  ms-new $c0 -> $after1
  select $after1 "handle~^{$hlab}$" -> $lab1
  dist $lab1 "161573,-64699" -> $dB1
  type "CDTEXTSEG{NL}159876,-63003{NL}158040,-73894" -Force -TimeoutSec 120 -> $ts_a
  wait
  ms-new $c0 -> $after2
  select $after2 "handle~^{$hlab}$" -> $lab2
  dist $lab2 "160160,-71771" -> $dA2
  type "_.UCS{NL}_W" -Force -> $ucsw
  wait
  windows-snapshot -> $win_end
ASSERT
  matches $xdir "0\.70\d"
  count $pipe = 1
  count $lab0 = 1
  count $lab1 = 1
  count $lab2 = 1
  contains $lab_text "UPVC PIPE AT 1 IN 200"
  number $dA0 < 4000
  contains $ts_b "Pipe text moved."
  number $dB1 < 4000
  contains $ts_a "Pipe text moved."
  number $dA2 < 4000
  history count "Pipe text moved." = 2
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $cd "FULL CD under the turned UCS"
  record $dA0 "label distance from the middle of leg A at the start (mm)"
  record $dB1 "label distance from the middle of leg B after the first move (mm)"
  record $dA2 "label distance from the middle of leg A after the move back (mm)"
  record $ts_b "FULL first CDTEXTSEG"
  record $ts_a "FULL second CDTEXTSEG"
```

**Twin:** `W1888P_BROKEN_cdtextseg_under_turned_ucs_moves_label_between_legs.case.txt`

```
# W1888P_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Wrong on purpose: same route, one move to leg B, but the case expects the label to STILL be beside leg A. It must FAIL on 'number $dA1 < 4000' (the label is about 7400 mm away after a real move). This proves only that the position reading can go red; it is not a switch-off twin (a position read cannot see the angle fault). If it PASSES, the label did not move or the distance step reads the wrong object: stop and say so.
CASE W1888P_BROKEN
TITLE BROKEN VARIANT of W1888P: after the move to leg B the label is wrongly expected to still be beside leg A (must FAIL)
PLAN_ITEM red proof that W1888P's position check can fail
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 753
TIMEOUT 1200
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1888P
REVIEWED_AGAINST
EXPECTED Wrong on purpose: after the label is moved to leg B it is far from the middle of leg A, so the 'near leg A' check fails; 'Pipe text moved.' is printed.
WHY_NOT_UNIT_TEST It exists only to prove W1888P's position check can go red.
STEPS
  copy-info -> $copy0
  ms-count -> $c0
  type "_.UCS{NL}_Z{NL}45" -Force -> $ucs
  wait
  type "_.ZOOM _C 64000,-162000 22000" -Force
  wait
  type "CD{NL}155919,-76016{NL}164402,-67527{NL}158745,-61872{NL}" -Force -ExpectWindow "New Pipe" -TimeoutSec 150 -> $cd
  ui2-set "New Pipe" "C2.CreatePipeText" "on"
  ui2-set "New Pipe" "C2.AutoCalcSecondInvert" "off"
  ui2-set "New Pipe" "C2.IsGradeCustom" "on"
  ui2-set "New Pipe" "C2.CustomGrade" "200"
  ui2-set "New Pipe" "C2.FirstInvert" "18.000"
  ui2-set "New Pipe" "C2.SecondInvert" "17.900"
  ui-press "New Pipe" "New pipe, Start Pipe" -> $t2
  await-window-gone "^New Pipe" -Secs 120
  esc-prompt -> $e1
  esc-prompt -> $e2
  esc-prompt -> $e3
  wait
  ms-new $c0 -> $after0
  select $after0 "text~DIA\. " -> $lab0
  field $lab0 handle -> $hlab
  type "CDTEXTSEG{NL}157191,-74743{NL}161574,-64700" -Force -TimeoutSec 120 -> $ts_b
  wait
  ms-new $c0 -> $after1
  select $after1 "handle~^{$hlab}$" -> $lab1
  dist $lab1 "160160,-71771" -> $dA1
  type "_.UCS{NL}_W" -Force -> $ucsw
  wait
ASSERT
  count $lab0 = 1
  count $lab1 = 1
  contains $ts_b "Pipe text moved."
  number $dA1 < 4000
  copy-unchanged $copy0
  record $dA1 "label distance from the middle of leg A after the move to leg B (mm); must be large"
```

### Case 3 of 3: W1876 and W1876_BROKEN (B3-01, Updates & Rollback)

**Intended file:** `W1876_updates_and_rollback_opens_own_screen.case.txt`

```
# W1876 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1876, B-058, BUG-1247 (carpark stays OPEN). Manager switch updatesButtonOpensOwnScreen, ON by default, in %APPDATA%\CE_SUITE\manager-switches.json (not one of the four files the runner can set, so this case sets nothing and proves the shipped default, as Codex B3 did).
# Reads only the TITLE of the window the button opens. The old fault on an administrator PC was the title 'CE Suite Manager | Admin Dashboard' (Tim's hand checks H44, H45, H47). Fixed: the title is 'CE Suite Manager' (Codex B3-01, PASS SURE, Updates tab selected, Admin Dashboard button visible, no dashboard window).
# What the robot cannot do: 'CE Suite Manager' is not on the v3 read list, so the selected tab and the buttons are NOT read; nothing in the window is pressed (never Install, never Roll back, never Admin Dashboard). Which tab is selected is a Codex look (K2_04).
# DERIVED, never read by a run: that CEMANAGERUPDATES returns to the command line while the window stays open (Codex's history shows 'Command: CEMANAGERUPDATES' and the window afterwards); that windows-new lists the Manager window by the title 'CE Suite Manager'; that close-windows can close it (if it cannot, the next case's fresh drawing reopens AutoCAD's session anyway); that this PC's Windows account is a CE administrator (Codex's PC showed the Admin Dashboard button, so it was). On a non-administrator PC the old build ALSO opened the Updates tab (PR #1595), so the case would pass without proving BUG-1247: the case records the full window list so the reviewer can see.
# Needs the Manager bundle loaded in the runner's AutoCAD (it is part of the installed set per Codex B3).
CASE W1876
TITLE Clicking Updates & Rollback (CEMANAGERUPDATES) opens the window titled CE Suite Manager, not the Admin Dashboard
PLAN_ITEM PR #1876 (B-058, BUG-1247) PART: the window title only. NOT whole: that the Updates tab is the selected one, the words Running now and Starts next time, and that the Admin button still opens the dashboard are Codex looks (K2_04); the missing go-back step in the own screen is BUG-1247's open remainder and is not claimed
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 754
TIMEOUT 600
BUG BUG-1247
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CEMANAGERUPDATES opens one new window whose title contains 'CE Suite Manager' and does not contain 'Admin Dashboard'; no CE refusal line ('not set up as a CE administrator') is printed; nothing is imported, installed or changed; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the switch condition in the command; only a live click shows which window AutoCAD opens for the logged-in account.
NOT_AUTOMATED The selected tab, the window's words and buttons, the Admin button, and the look: Codex look K2_04.
STEPS
  copy-info -> $copy0
  windows-snapshot -> $w0
  type "CEMANAGERUPDATES" -Force -> $cmd
  sleep 8
  windows-new $w0 -> $opened
  windows-snapshot -> $w1
  close-windows
  wait
ASSERT
  contains $opened "CE Suite Manager"
  not-contains $opened "Admin Dashboard"
  not-contains $cmd "not set up as a CE administrator"
  copy-unchanged $copy0
  record $cmd "FULL CEMANAGERUPDATES reply"
  record $opened "FULL list of windows that opened"
  record $w1 "FULL window list while the Manager window is open"
```

**Twin:** `W1876_BROKEN_updates_and_rollback_opens_own_screen.case.txt`

```
# W1876_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). No switch-off twin is possible from the runner (the switch is in manager-switches.json, outside its four settings files). So this twin is wrong on purpose, as the 24 Oct rule allows ('a deliberately broken variant of the case'): same click, but it expects the OLD title 'Admin Dashboard'. It must FAIL on that check. If it PASSES, the window opened with the dashboard title and W1876's fixed behaviour is not in this build: say so. The real old-build red is already on record from Tim's hand checks H44, H45, H47 (Manager 1.1.85).
CASE W1876_BROKEN
TITLE BROKEN VARIANT of W1876: the opened window is wrongly expected to be the Admin Dashboard (must FAIL)
PLAN_ITEM red proof that W1876's title check can fail
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 755
TIMEOUT 600
BUG BUG-1247
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1876
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the window title has no 'Admin Dashboard', so the contains check fails; the Manager window itself opens and closes cleanly.
WHY_NOT_UNIT_TEST It exists only to prove W1876's title check can go red.
STEPS
  copy-info -> $copy0
  windows-snapshot -> $w0
  type "CEMANAGERUPDATES" -Force -> $cmd
  sleep 8
  windows-new $w0 -> $opened
  close-windows
  wait
ASSERT
  copy-unchanged $copy0
  contains $opened "Admin Dashboard"
  record $opened "FULL list of windows that opened"
```

---

## 3. Codex look notes (the robot cannot prove these; each is a short recipe for a Codex pass in real AutoCAD on a copy)

1. **K2_01, BUG-1195 (PR #1888): the label lies along the leg and reads upright.** Codex already saw PASS SURE on 3.0.89 (B2c, 2 Nov 1900, B2-01a and B2-01b). Repeat or audit:
   1. Open a copy of an empty-ground drawing. Type `_.UCS`, `Z`, `45`. Type `_.ZOOM _C 64000,-162000 22000`. Read UCSXDIR: about 0.7071,0.7071.
   2. Type `CD` and the three World points 155919,-76016, 164402,-67527, 158745,-61872. In New Pipe: 100 mm UPVC, Set my own 200, levels 18.000 and 17.900, pipe text On plan / Above. Start Pipe. Esc twice (the "move arrow AND text" question, then the next-pipe prompt).
   3. Type `CDTEXTSEG`, first pick 157191,-74743 (on the pipe), second pick 161574,-64700. Expect "Pipe text moved." Look: the label lies along leg B, parallel to it, upright (about minus 45 degrees on screen), readable.
   4. Type `CDTEXTSEG`, first pick 159876,-63003, second pick 158040,-73894. Look: the label lies along leg A, tilted up to the right about 45 degrees, parallel, readable.
   5. Old fault (switch `linking.pipeTextMoveAngleFollowsUcs` false before launch): the label moves to the right place but stays flat or vertical. Codex has not run the OFF control; run it only if the desk asks.
   6. Type `_.UCS` then `W`. Do not save.
2. **K2_02, B2-02a (PR #1926, BUG-505): the CHECK THE SCALE warning leads the import window's schedule page.** Codex already saw PASS SURE (B2, 2 Nov 1646).
   1. Open a copy of a drawing tagged Civil. Type `CDIMPORTXCIVIL`. The window "Creative Engineering | X-Civil import" opens with the tabs Source, Pit and pipe schedule, Results and review. "Read source" is greyed out.
   2. Press "Choose DWG...". In the box titled "Choose X-Civil drawing", type the full path of a COPY of LKB2_CONS.dwg (the made-up consultant drawing Codex used; the originals sit beside the look folders in `C:\Lisp Files\_TEST_COPIES_20260923`). Press Open. The footer reads "Source chosen. The schedule needs checking before the import is accepted."
   3. Press "Read source". The window changes to the "Pit and pipe schedule" page, heading "Check the schedule first".
   4. Look: the status lines read, in this order, "CHECK THE SCALE: the source drawing records no units, so the 1000 times scale (metres to millimetres) is a guess from the size of the objects. Check the first pit and pipe look right after the import." then, on a new line, "Check the schedule before accepting the import." All words visible, nothing clipped.
   5. Press Close only. Never "Import to drawing". The command line then shows "Import aborted at pre-flight gate — no entities were inserted." and the object count is the same as before.
   6. Control (optional): `xcivilImport.scaleNoteOnReviewPage` false before launch; the page then shows only the second sentence.
3. **K2_03, B2-02b (PR #1853 and #1926, BUG-505): the no-units note leads the schedule page.** Codex already saw PASS SURE (B2, 1646).
   1. Same steps 1 and 2 as K2_02, but choose a COPY of LKB2_XC.dwg (a made-up drawing whose units are unset and whose objects are millimetre-sized).
   2. Press "Read source". Look: the status reads "This drawing has no units set; CE read it as millimetres." then, on a new line, "Check the schedule before accepting the import." About 10 rows below, columns "Drawing label", "What the schedule says", "Check".
   3. Press Close only. The command line carries the same sentence twice and the abort line; the object count is unchanged.
   4. Control (optional): `xcivilImport.noUnitsNote` false before launch gives the old silence; `scaleNoteOnReviewPage` false removes the sentence from the window but leaves it on the command line.
4. **K2_04, B3-01 (PR #1876, BUG-1247): Updates & Rollback opens the Updates screen of its own.** Codex already saw PASS SURE (B3, 2 Nov 1702).
   1. Open a copy of a drawing on a PC whose Windows account is a CE administrator. Click the CE Tools tab, then Updates, then Updates & Rollback (command CEMANAGERUPDATES).
   2. Look: the window is titled "CE Suite Manager" (not "CE Suite Manager | Admin Dashboard"), the Updates tab is selected, and "Running now" and "Starts next time" are visible. The Admin Dashboard button is visible but the dashboard is NOT open.
   3. Do not press Refresh, Install, Roll back or Admin Dashboard. Close with the window's own X.
   4. Not claimed: the go-back step is still missing (BUG-1247 stays open). On a non-administrator PC the old build also showed this screen (BUG-948), so this check proves the fix only on an administrator PC.

---

## 4. Skipped items and why

1. **A robot case for B2-02a and B2-02b (the import window).** BLOCKED-FOR-ROBOT. The window's own page appears only after "Read source", and the robot's press list for `*X-Civil import*` allows only "Choose DWG...", Close and Cancel; the file box allows only Cancel. A case that only opens the window and records its first page would prove nothing about the warning, so I did not draft one. Codex looks K2_02 and K2_03 cover it.
2. **B2-02c, B2-03, B2-04** were named in the Codex B2c report as not run; they are outside this brief and I did not read them.
3. **B3-03 (the Net8 / Modern lane word)** is outside this brief. Codex found B3-03a not testable on a PC that only has AutoCAD 2027.
4. **A real switch-off twin for W1876.** Not possible from the runner (see W1876 header).
5. **A real red-before-green for W1888P.** Not possible: a position read cannot see an angle fault.

---

## 5. What was read, built, tested, and what is NOT proven

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md` in full; the Codex reports B2 (1646), B2c (1900) and B3 (1702) in full or in their result sections; `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (twin style) and the cases P01, K04, N48, R09s_new_switch_off_broken and the C32 rotation lines; the v3 allow-list; `Get-V3EntityInfo` and `Read-CaseMsItem`; the `REGRESSION_LOG.md` entries for BUG-1195, BUG-505 (both) and BUG-948/1247; `gh pr view` for #1888 and #1876; `gh pr list` for #1926, #1853 and #1595; the `TextRotationForSegment` code on the PR head. I did NOT read the `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` example in full, and did not read the runner's code for how `dist`, `matches` or `windows-new` behave beyond the lines named above.
2. **Built:** nothing. **Tested:** nothing. No case was validated with `case_runner.ps1 validate`; first runs may need small fix-ups. No AutoCAD, no robot, no settings file touched, no git write. The only side effect: `gh` was not on my shell's PATH, so I added its folder to the PATH of my own shell session.
3. **NOT proven:** every line marked DERIVED; that the angle values (315 and 45 degrees) are what the build writes (Codex judged "about 45 and minus 45" by eye, to the nearest 5 degrees); that DRV1_B1 is clear of other objects near the new pipe (it holds 1034 objects; Codex used a different, empty-ground drawing; if a CDTEXTSEG pick lands on another pipe the first run will say "Nothing Selected" or "That is not a pipe"); that the robot's AutoCAD runs the installed Civil 3.0.89 and Manager 1.1.89; that this PC's account is a CE administrator.
4. **Not agreed with the instructions I was given:** the brief names angles 45 and 135 degrees; the stored angle for the 135 degree leg is 315 degrees (see Facts 5 and 4). Also the `rel-20261102a` ref I fetched does not contain the installed commit (Facts 3).
