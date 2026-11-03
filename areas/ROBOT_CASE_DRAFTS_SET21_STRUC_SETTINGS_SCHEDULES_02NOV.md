# Robot case drafts, SET 21: Structural Settings, load path, schedules and Help (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

**What this is.** One robot case with its broken twin, drafted on paper for fix PR #1986 (BP). The other five fixes (#1886, #1910, #1911, #1914, #1916) cannot be driven by the robot as things stand, so each is marked BLOCKED-FOR-ROBOT with a Codex look. Nothing was built, run, installed or opened in AutoCAD. No case file was created in the cases folder: the only file written is this one. No git write.

---

## FOR TIM

1. **1 robot case drafted with its broken twin (2 case texts).** W1986: BP says in one line that the Settings pier diameter (500 mm) is not on the pier block (300, 450, 600) and that 450 is offered. The twin turns the fix's switch off and must fail.
2. **Codex-only (BLOCKED-FOR-ROBOT, 5 fixes).** #1910 (the CE Settings window), #1916 (CEHELP wording), #1911 (CSLOADPATH needs a drawing with linked beam ends on a slab that the robot cannot build), #1914 (CSMEMBERSCHED needs two beams drawn by the beam commands, whose typed answers are not known), #1886 (needs two table rows swapped, which means typing into a table cell or typed LISP). Codex looks with exact steps are below.
3. **Needs an Opus review BEFORE it is run:** none. W1986 stops at the first question of BP (Esc), so it touches no Undo, no REDO, no locked layer and no Xref.
4. **Example of what W1986 checks.** Set the pier diameter in Settings to 500, type BP. Right = the command line says "The pier diameter in Settings (Bored pier plan, default diameter) is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead." and the question reads "<450>". The twin has the switch off, so that line is missing and the case must go red.
5. **The installed Structural build (1.0.125) does not have this fix**, so W1986 should FAIL on it. That is expected until a build holding #1986 is installed.
6. **Could NOT verify:** that the Structural plugin is loaded in the robot's AutoCAD today; that the runner accepts a SETTING line with the full Structural settings path (nobody has run one); that the key `BoredPierPlan.DefaultDiameterMm` is already in the settings file. If the runner refuses either, W1986 comes back BLOCKED, not red.
7. **Not proven by anything here:** every printed line marked DERIVED was read from the PR text and source, not seen on a run. What the pier looks like when drawn is not touched.
8. **Nothing for you to test or decide now.** Every bug entry stays OPEN.

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `areas\CASE_WRITING_STRUC_REPORT_30OCT.md`; `cases\README_CASES.md` in full; `acad_driver_v3.allowlist.json` (the press list and the settings-file list); the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` shape (through `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`, which I read in full) and the Structural sets 18, 19 and 20 of today (grep for the settings-path problem); `cases\variants\R09s_new_switch_off_broken.case.txt`; `cases\R07_settings_window_cancel.case.txt`. After `git fetch`, with `gh pr view` and `gh pr diff` (read only): the six PRs; the source of BP (`FoundationService.cs` on `origin/claude/rel-20261026s`), CSLOADPATH (`FoundationService.LoadPath.cs`), CSMEMBERSCHED (`MemberScheduleCommandService.cs`, `MemberScheduleReaderService.cs`) and the BDL start (`BeamPlacementCommands.cs`); the carpark line numbers for BUG-1183, 1134 and 1219; the BUGFIX reports `s1` and `s13` (read in part).
2. **Is there already a case or draft? No, checked again.** I searched the cases folder (including every `drafts_*` folder and `variants`), all 22 `ROBOT_CASE_DRAFTS_*.md` files and `runner-reports\ledger.json` for the PR numbers, the bug numbers (1183, 535, 536, 1134, 1219), the switch names and the command names. The only hits for words like 1886 or 1914 are in unrelated Civil files (W1892 and W1952 drafts match by chance on other digits). Sets 18 to 20 are Structural drafts for other PRs (#1909, #1894, #1988, #1900, #1932, #1895, #1906, #1912, #1907). BUGFIX report `q10` names #1986 and proposes the robot case that W1986 follows ("Robot case (proposed)" in the PR text).
3. **The fixture.** DRV2_S1 (the Structural copy, millimetres), not DRV1_B1, as in sets 18 to 20: BP needs the Structural plugin and DRV2_S1 is the copy Structural cases already use. BP's first prompt needs no drawing content.
4. **The switch-off twin.** `R09s_new_switch_off_broken` style: the PR's own switch set OFF with a SETTING line before AutoCAD starts. Structural reads `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`, and a bare `CS_Settings.json` would be read as the Civil folder, so the lines use the FULL path (it is on the driver's `settings_files` list). UNPROVEN: nobody has run a SETTING line with that path. The main case also needs a SETTING line (the 500 mm diameter), so if the runner refuses the path BOTH come back BLOCKED. Fallback: a Codex look (look F below).
5. **No `settings-arm` and no `hashes-unchanged`** in these two cases: the SETTING guard holds and restores the file by its hash, and the file differs while the guard holds it.
6. **Order numbers** 900 and 901. **SLOT fresh.** `REVIEWED_AGAINST` is empty. Every `type` chain is a complete command with no `(` and no SAVE-type word. Nothing here unlocks a layer, touches an Xref or goes around any AutoCAD protection.
7. **To validate offline:** copy each block to its file name in a new folder (suggested `cases\drafts_struc_set21_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. I did not run this.
8. **Build pending.** The case needs a Structural build that holds #1986 (the installed 1.0.125 has no `BoredPierBlockFollowsDiameter` switch and prints no such line).

---

## 2. The case texts

### Case 1 of 1: W1986, BP says so when the Settings pier diameter is not on the pier block (#1986, B-153, BUG-536 BP part; order 900)

**Intended file:** `W1986_bp_says_settings_diameter_not_on_block.case.txt`

```
# W1986 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1986 (B-153, BUG-536 BP part), switch FootingWidth.BoredPierBlockFollowsDiameter, ships ON, on origin/claude/rel-20261026s. BUILD PENDING: Structural 1.0.125 (installed) has neither the switch nor the line, so this case should FAIL on it.
# Route: BoredPierPlan.DefaultDiameterMm is set to 500 before AutoCAD starts (the block has 300, 450 and 600 only). BP is typed alone; CE prints one line BEFORE it asks 'Select pier diameter [300/450/600] <450>:' (FoundationService.cs ExecuteBoredPier, read at the PR branch). The case stops there with Esc, so no pier is drawn and nothing is undone.
# DERIVED, never seen on a run: the wording of the line (from BoredPierDiameterChoice.FallbackWarning in the PR diff: '[BP] The pier diameter in Settings (Bored pier plan, default diameter) is 500 mm, and the pier block only has 300, 450 and 600. 450 is offered instead. Pick 300, 450 or 600 here, or change the Settings value.'); that the type reply holds the whole line and the prompt; that the SETTING line with the full Structural path and the key BoredPierPlan.DefaultDiameterMm is accepted (the key may not be in the file yet). If the runner refuses it, this case is BLOCKED.
# The switch is NOT set in the main case (it ships ON; the key may not be in the file). The twin sets it OFF.
CASE W1986
TITLE With the Settings pier diameter at 500 (not on the pier block), BP prints one line saying 450 is offered instead, and still asks the diameter question
PLAN_ITEM PR #1986 (BUG-536 BP part) PART: the warning line for a Settings diameter the block does not have (500), read from the command line. NOT whole: that BP then draws the 450 pier, that a 600 in Settings gives the 600 pier and no line (a control), and the look of the pier block's visibility states are not driven (Codex look F)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json BoredPierPlan.DefaultDiameterMm 500
ORDER 900
TIMEOUT 600
BUG BUG-536
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED BP prints one line naming the 500 mm Settings value, saying the block only has 300, 450 and 600 and that 450 is offered; the next prompt reads "Select pier diameter [300/450/600] <450>:"; Esc ends BP and no pier block is added; the drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests pin the wording and the switch; only a live BP reads the real Settings value and prints on the real command line before its question.
NOT_AUTOMATED What happens after the question: the 450 pier placed, the hatch question for 450, and the pier look (a Codex look F). A 600 control (Settings 600, no line, prompt <600>).
NOT_AUTOMATED The Settings page does not show this value in a box named in the PR; the line says "Bored pier plan, default diameter" and that wording is recorded, not judged against a window.
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
  contains $bp "only has 300, 450 and 600"
  contains $bp "450 is offered instead"
  contains $bp "is 500 mm"
  contains $bp "Select pier diameter [300/450/600] <450>"
  history count "The pier diameter in Settings" = 1
  not-contains $win_end "Creative Engineering"
  copy-unchanged $copy0
  record $bp "FULL BP (the warning line and the diameter question)"
  record $bpe "what the closing Esc printed"
  record $new "objects added to Model space (none expected)"
```

**Twin:** `W1986_BROKEN_switch_off.case.txt` (the switch OFF before AutoCAD starts, as in `R09s_new_switch_off_broken`)

```
# W1986_BROKEN DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN). The PR's own switch-off control (#1986: 'OFF gives the old silent 450'): FootingWidth.BoredPierBlockFollowsDiameter false before AutoCAD starts, with the same 500 mm Settings value. Same route, same checks. It must FAIL on the warning-line checks ('only has 300, 450 and 600' and the count of 1). The check on the prompt '<450>' should still PASS, which proves BP ran and offered 450.
# If it PASSES, the old build also prints the line on this drawing (or the switch was ignored) and W1986 does not tell old from new: say so and send the item to Codex look F.
# UNPROVEN: the FULL-path SETTING lines (see the set's part 1 item 4). If the runner refuses a path or a key this comes back BLOCKED, not red.
CASE W1986_BROKEN
TITLE BROKEN VARIANT of W1986: the new switch is OFF, the old silent 450 returns, the case still expects the warning line (must FAIL)
PLAN_ITEM red-before-green proof for W1986 (PR #1986, BUG-536 BP part)
KIND deterministic
FIXTURE DRV2_S1
SLOT fresh
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json BoredPierPlan.DefaultDiameterMm 500
SETTING %APPDATA%\CE_STRUC_SUITE\CS_Settings.json FootingWidth.BoredPierBlockFollowsDiameter false
ORDER 901
TIMEOUT 600
BUG BUG-536
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1986
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF BP offers 450 without saying so, so the warning checks fail; the prompt "Select pier diameter [300/450/600] <450>" still appears.
WHY_NOT_UNIT_TEST It exists only to prove W1986's warning checks can go red.
STEPS
  copy-info -> $copy0
  type "BP" -Force -> $bp
  wait
  esc-prompt -> $bpe
  wait
  windows-snapshot -> $win_end
ASSERT
  contains $bp "Select pier diameter [300/450/600] <450>"
  contains $bp "only has 300, 450 and 600"
  contains $bp "450 is offered instead"
  history count "The pier diameter in Settings" = 1
  copy-unchanged $copy0
  record $bp "FULL BP with the switch OFF"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Common rules for every look: use a COPY of a drawing, never Tim's job drawing; AutoCAD must have the Structural build that holds the PR (the installed 1.0.125 has none of these fixes); take the screenshots yourself and save them under `C:\CE_WORK\codex\<look name>\` (one folder per look); never accept or capture a folder a file box opened in. If a look needs a switch OFF, set it by hand in the Structural settings before AutoCAD starts and put the file back afterwards. Every window word below marked DERIVED comes from the PR text, not from a run.

### Look A: #1910 (B-089, BUG-535 part), CESETTINGS shows the footing widths and wall brace lengths. BLOCKED-FOR-ROBOT (window only)

1. **Why not the robot.** The window is titled "CE Settings". The driver's press list has no entry that matches that title (its entries are "Settings*", "*| Settings*" and "Creative Engineering*"), so the robot could open and read it but could not close it. A read-only case would leave a window open.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_A_1910_cesettings\`. On a copy of any drawing type `CESETTINGS`. Open the Bracing page: it has two boxes, "Longest wall brace before CE warns (mm)" showing 2700 and "Brace length when you press Enter (mm)" showing 2700 (DERIVED). Open the new Footings page: "Strip footing width offered (mm)" 300 and "Footing beam width offered (mm)" 300 (DERIVED). Screenshot both pages.
3. **Right looks like.** Four boxes with those names and values, matching the Structural settings file. Type 350 in the strip footing width and Save: reopen, 350 is still there. Type 0 in a footing width and Save: refused, the old width stays. Type a word in a brace box: Save refused and the message names that box. A blank box keeps the stored value. Typed 0 in a brace length means "not set".
4. **Control.** Cancel (not Save) after typing: reopen shows the old values.

### Look B: #1916 (B-092, BUG-1219), CEHELP for Beam Settings (8) and RJSET. BLOCKED-FOR-ROBOT (window only)

1. **Why not the robot.** CEHELP opens a Help window the robot cannot read or close.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_B_1916_cehelp\`. Type `CEHELP`; find the entry "Beam Settings" (command 8) and the entry "Rafter/Joist Settings" (RJSET). Screenshot each entry's detail pane. Then type `8`, then `RJSET`, and screenshot the window each opens.
3. **Right looks like.** Both Help entries say nothing is asked on the command line, that CE Settings opens on the Beam page (or the Rafter / Joist page), and that Save keeps changes while Cancel leaves them. None of these words appear: Start point, End point, Direction selection, Extent selection, Tag text. Typing `8` and `RJSET` opens CE Settings on the named page with no question on the command line (DERIVED from the PR text).

### Look C: #1911 (B-090, BUG-536 part), CSLOADPATH reads the pad round-up and unsized-pier size from Settings. BLOCKED-FOR-ROBOT

1. **Why not the robot.** CSLOADPATH only offers a pad for a post that "lands on a slab with nothing under it". Posts are read from beam ends linked by the beam commands (`CollectLoadPathPosts` looks for linked beam curves), and a raft slab must be in the footing registry. The case would need a drawing with a linked beam over a raft with no footing; none exists in the fixtures, and the beam commands' typed answers are not known. The keys `LoadPath.PadRoundUpMm` and `LoadPath.UnsizedPierDiameterMm` may not be in the settings file yet. This is a data-and-drawing set-up job, not a typing job.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_C_1911_loadpath\`. On a copy: draw a raft slab with CE's raft command (find it in CEHELP, Foundations group; I do not know its typed name) with no footing inside it; draw one beam with BDL whose end lies on the raft; leave the Structural settings as they are (round-up 50). Type `CSLOADPATH`. Right looks like: "[LOADPATH] Offered pad footing 450x450 under <post> ..." (20 kN at 100 kPa is 447 mm, rounded up to 450). Answer No.
3. **Change the number.** Close AutoCAD, set `LoadPath.PadRoundUpMm` to 100 in the Structural settings file by hand, start AutoCAD, repeat. Right looks like: "Offered pad footing 500x500" (DERIVED: 447 rounded up to the next 100 is 500).
4. **Control.** Set `LoadPath.ReadsPadRoundUpAndUnsizedPierFromSettings` to false, restart, repeat: 450x450 again.
5. **Second half (a pier that prints no size).** Needs a bored pier with no printed diameter in the footing registry: not known how to make one. If Codex cannot, say so; the unit tests cover the number (225 becomes 300 for 600) and nothing in AutoCAD does.

### Look D: #1914 (B-092, BUG-1134), CSMEMBERSCHED counts 310UB32 and 310 UB 32 as one size. BLOCKED-FOR-ROBOT (for now)

1. **Why not the robot.** The result IS a command-line printout (CSMEMBERSCHED writes nothing to the drawing), so a robot case is possible later. What stops me today: it reads only beams drawn by the beam commands that carry a link record and a label text; I could not confirm the typed answers of BEAM 1, 2 or BDL (BDL asks for two points, then a side keyword, then more; BEAMs 1, 2, 4 and 5 use a Preview and Accept route). The member schedule is OFF by default (`MemberSchedule.Enabled`) and the SETTING route for that key is unproven. A first step for the desk: a probe case that types one BDL with typed points and reads the label text.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_D_1914_membersched\`. Set `MemberSchedule.Enabled` to true in the Structural settings before AutoCAD starts (put the file back afterwards). On a copy: draw two beams with the beam commands and label them FB3 `310UB32` and FB3 `310 UB 32` (the labelling route is Codex's to find; CEMEMBER and the beam text routes are the candidates). Type `CSMEMBERSCHED`.
3. **Right looks like.** One row "FB3 | 310 UB 32" (the spelling with more spaces is shown) and NO line saying "FB3 is drawn with different sizes". Control one: label one beam `250 UB 26` instead: the row reads "FB3 | Unknown" and the "drawn with different sizes (... and ...)" line appears. Control two: set `MemberSchedule.CompareSizesIgnoringSpaces` to false, restart, repeat the first run: "FB3 | Unknown" and the "different sizes" line (the old behaviour).
4. **Also note** the command prints "Checking N other drawing(s) of the job for marks on other floors" when other drawings sit in the same folder: use a folder with only the copy.

### Look E: #1886 (B-065, BUG-1183), pier schedule SYNC checks which pier each row is. BLOCKED-FOR-ROBOT

1. **Why not the robot.** The fault only shows after two data rows of the Bored Pier Schedule are swapped. The robot cannot type into a table cell, and typed LISP is refused (it wedged AutoCAD). The PR's own test, RD14-01, uses a supplied AutoLISP routine for the swap.
2. **Steps (the PR's RD14-01, from its REGRESSION_LOG entry).** Evidence folder `C:\CE_WORK\codex\look_E_1886_pier_sync\`. On a copy: `BP`, answer 300, pick 0,0, Esc; `BP`, answer 600, pick 3000,0, Esc; `STRSCHEDCREATE` and place the table; `STRSCHEDREFRESH`; swap data rows 2 and 3 of the table by hand (cut and paste the two rows, or the supplied LISP); `STRSCHEDSYNC`.
3. **Right looks like.** The 300 pier is still 300 and the 600 pier is still 600 (check by `LIST` on each pier block, visibility state "300 DIA." and "600 DIA."), and one plain line says the rows were matched by their HANDLE.
4. **Second run.** Set the Bored Pier Schedule to print without the LAYER and HANDLE columns (the "Batch 14" setting) and repeat the swap: rows matched by MARK, DIA MM and VISIBILITY, same right result.
5. **Real edit still works.** Change one row from 600 to 300 without moving any row and sync: that pier becomes 300.
6. **Control.** Set `ScheduleSet.PierSyncChecksRowIdentity` to false, restart AutoCAD, repeat the swap: the piers swap sizes (the old fault). Put the settings file back afterwards.
7. **Honest gap from the PR itself.** Rows rearranged AND edited in the same sync, on a table with no HANDLE column, are written by position. Do not expect that case to pass.

### Look F: #1986 rest (what W1986 does not reach)

1. **When to use it.** Always, after W1986: the robot stops at the question. If the runner refuses the SETTING line, run all of this instead.
2. **Steps.** Evidence folder `C:\CE_WORK\codex\look_F_1986_bp\`. Set `BoredPierPlan.DefaultDiameterMm` to 500, start AutoCAD, type `BP`: the one line, then `<450>`. Press Enter, then No to the hatch question, pick 3000,3000: a pier block is placed with visibility state "450 DIA.". Esc. Screenshot the command line.
3. **Control A.** Set the value to 600 and restart: no warning line, the prompt reads `<600>`, Enter places the pier with state "600 DIA.".
4. **Control B.** Set `FootingWidth.BoredPierBlockFollowsDiameter` to false with the value at 500, restart: no warning line, `<450>` offered (the old silent 450).
5. Put the settings file back afterwards.

---

## 4. Fixes skipped as robot cases, and why

1. **#1886 (BUG-1183):** BLOCKED-FOR-ROBOT, Look E (a swapped table row needs a typed cell or typed LISP).
2. **#1910 (BUG-535 part):** BLOCKED-FOR-ROBOT, Look A (window "CE Settings" is not on the press list, so the robot could not close it).
3. **#1911 (BUG-536 load-path part):** BLOCKED-FOR-ROBOT, Look C (no drawing with linked beam ends over an unfooted slab; the typed route to make one is not known).
4. **#1914 (BUG-1134):** BLOCKED-FOR-ROBOT for now, Look D (a command-line result, so a later robot case is possible once a beam-draw probe case proves the typed answers).
5. **#1916 (BUG-1219):** BLOCKED-FOR-ROBOT, Look B (Help window).
6. **Not skipped, drafted:** #1986 (W1986 and its twin).

---

## 5. What I read, built, tested, and what is NOT proven

1. **Read.** The files and PRs listed in part 1 item 1. I did not open Tim's real settings files, the Keys folder, `C:\CE_DrawingIntelligence` or AutoCAD.
2. **Built.** Nothing. **Tested.** Nothing. I did not run `case_runner.ps1 validate`, so the two case texts may need a first-run fix-up.
3. **Installed.** I did not read the product version of the installed Structural bundle, so I do not know it is 1.0.125 today.
4. **NOT proven.** That the Structural plugin is loaded in the robot AutoCAD; that the runner accepts the full-path SETTING lines and the key `BoredPierPlan.DefaultDiameterMm`; that the type reply holds the whole warning line and the prompt; every line marked DERIVED; that the old build prints no such line (the twin's red result will show it); anything about the five Codex-only fixes beyond what their PR texts say.
5. **Housekeeping.** `gh` ran only after adding `C:\Program Files\GitHub CLI` to the PATH of my own shell. I ran `git fetch` (read-only) for the PR branches. No file other than this one was written.
