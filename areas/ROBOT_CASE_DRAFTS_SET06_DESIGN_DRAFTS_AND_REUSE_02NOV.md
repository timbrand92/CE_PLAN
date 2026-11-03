# Robot case drafts, set 06: CDDESIGN saved drafts, outlets and rainwater reuse (Mon 2 Nov 2026, read-only drafter, Sonnet)

**Nothing was built, run, installed or opened in AutoCAD.** The only file written is this one. No git write, no push. Tim's real settings files were not read or written.

---

## FOR TIM

1. **Result: one robot case with its twin (2 case texts), and three fixes that are Codex-only.** The robot cannot honestly prove the other three. I did not force weak cases.
2. **The one case is W1945 (and W1945_BROKEN).** It checks the new warning "the approved outlets in this drawing were approved when it was saved under another file name or folder". It is a PART claim, and it is **not runnable yet**: it needs one new test drawing that a person makes first (steps in the case notes). The twin runs the same drawing with the fix's own switch OFF, so it must fail.
3. **Codex-only fixes.** #1954 (Manningham 2,000 L minimum), #1956 (Save Draft keeps newer fields) and #1961 (Manningham reuse credit on its council profile). Each has numbered steps below. #1954 cannot be looked at at all yet: the box that feeds it does not exist.
4. **Why the robot cannot do them.**
   1. **#1956:** the only route is the Save Draft button, which the robot is never allowed to press, on a drawing that already holds a newer build's draft.
   2. **#1954:** CDDESIGN has no box for the litres kept for detention, so nothing feeds the number. The tank box it builds on (#1874) is also not on the release line yet.
   3. **#1961:** on a Manningham job nothing changes on screen by design (same numbers, new home), and no typed command prints the reuse credit.
5. **Needs an Opus review before it is run:** W1945 only, for its made-up test drawing and its guesses about the printed line. None of the four touches Undo, REDO, a locked layer or an Xref in a way the robot would drive.
6. **Not proven (all four):** nobody has opened any of these in AutoCAD. No drawing, window or printed line below was seen on a run. Everything marked DERIVED comes from the PR text and source, not from a run.
7. **Order matters:** #1954 and #1956 are stacked on #1874, which is not in `origin/claude/rel-20261102a` (checked: it is not an ancestor). Nothing for them can run on the release build until #1874 merges.
8. **Nothing for you to decide or test now.**

---

## 1. How the drafts were written

1. **What I read.** `C:\TimOS\RULES.md`; `cases\README_CASES.md` (all of it) and the refused-button list in `acad_driver_v3.allowlist.json`; `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; `R09s_new_switch_off_broken.case.txt`; `W657` from the wave 1 cases; `R27_cddesign_window_opens` (the one existing CDDESIGN case); the four PRs (`gh pr view`, `gh pr diff`); the carpark entries BUG-1108, BUG-1156, BUG-1158, BUG-538; reports `BUGFIX_n6`, `BUGFIX_n7`, `BUGFIX_fx1945`, `BUGFIX_n17`; and the 1945 REGRESSION_LOG entry.
2. **No case exists for any of the four.** I searched the cases folder (including every `drafts_*` folder), every `ROBOT_CASE_DRAFTS_*.md`, and `ledger.json` for the bug numbers, PR numbers and the three switch names. Nothing found. The only CDDESIGN cases are R27 (window opens), W780, N46, N61 and the probes; none touches these fixes.
3. **Settings.** Only the `SETTING CD_Settings.json <key> <value>` line from README_CASES.md is used. A switch cannot be changed mid-case, so the twin sets it before AutoCAD starts.
4. **Format.** README header, `STEPS`, `ASSERT`; fixture and slot as the README requires; `REVIEWED_AGAINST` empty; every type chain is a complete command with no `(` and no SAVE-type word.
5. **Draft build state.** The Civil line is `origin/claude/rel-20261102a` at 3fbb9da5 (3.0.88). #1945 is a draft on that line; the case cannot run until it is installed.
6. **DERIVED** marks everything taken from the PR text and not seen on a run.

---

## 2. The case texts

### W1945: CDDESIGN prints one warning when the approved outlets were approved under another file path

**Intended file:** `W1945_cddesign_warns_outlets_approved_in_another_file.case.txt`

**FIXTURE PREPARATION (a person does this once; the robot never does it):**

1. On the installed build that contains #1945 (switch ON, which is the default), open a copy of a job in a folder such as `C:\ce_rc_drv\_prep\`.
2. Run CDLPD (or approve the Design outlets in CDDESIGN) so the outlets are approved. Save that drawing there. **Check the saved path is the one the approval ran under:** the fix records the path at the moment of approval, so approve it after the drawing has its final name.
3. Copy the saved drawing into `C:\ce_rc_drv` as `DRV1_LPD_B1.dwg` (name to be agreed). The runner copies it to a different file for each run, so the copy's path differs from the recorded one. This is the Save As situation without the robot ever saving anything.
4. Never edit it afterwards.

```
# W1945 DRAFT (Sonnet drafter, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED, BUILD PENDING: needs PR #1945 installed AND the fixture DRV1_LPD_B1 above, which does not exist yet). PR #1945 (B-121, BUG-1158), switch linking.lpdWarnsWhenOutletsApprovedInAnotherFile, default ON.
# The runner opens a COPY of the master, so the copy's file path is not the path recorded when the outlets were approved: the fix must print ONE warning line when CDDESIGN opens and carry on. DERIVED from the PR: the line starts "[CE] Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder." (CivilDesignCommand.cs; LpdSaveAsCopyRule.Warning).
# The robot approves nothing, saves nothing and never touches an Xref, locked layer or protection. CDDESIGN is opened and closed (as R27 does).
# DERIVED, never seen on a run: that the warning prints before the window opens; that it is on the command line and so in 'history'; that the copy's Filename differs from the recorded path for every run copy.
CASE W1945
TITLE On a drawing whose outlets were approved under another file path (the robot's copy), CDDESIGN opens, loads as before and prints the Save As warning exactly once
PLAN_ITEM PR #1945 (BUG-1158) PART: the warning line when the recorded path differs. NOT whole: that a real Save As copy warns, that the original file does NOT warn, and that a drawing approved before this build never warns, are Codex look 1 below; that approved outlets are not un-approved is read only as far as the window opening
KIND deterministic
FIXTURE DRV1_LPD_B1
SLOT fresh
SETTING CD_Settings.json linking.lpdWarnsWhenOutletsApprovedInAnotherFile true
ORDER 750
TIMEOUT 600
BUG BUG-1158
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDDESIGN prints one line beginning "[CE] Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder" (DERIVED) and opens the Design window as normal; the line appears once; closing the window leaves no CE window and the drawing file on disk unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the path rule with made-up paths. Only a live drawing shows that the path really recorded by CDLPD differs from the copy's real file name and that the line reaches the command line.
NOT_AUTOMATED Making the fixture, and a true Save As, need a Save the robot may not do (Codex look 1).
NOT_AUTOMATED The original file not warning, a pre-fix drawing never warning, and a never-saved drawing recording no path are not driven.
NOT_AUTOMATED The warning is printed once per CDDESIGN open; a second open is not tried.
STEPS
  copy-info -> $copy0
  type "CDDESIGN" -Force -ExpectWindow "Design" -TimeoutSec 120 -> $d1
  ui-dump "Design" -> $dd
  close-windows -> $closed
  esc-prompt
  wait
  windows-snapshot -> $win_end
ASSERT
  history has "the approved outlets in this drawing were approved when it was saved under another file name or folder"
  history count "approved when it was saved under another file name or folder" = 1
  control-text $dd has "Start"
  not-contains $win_end "Design (CDDESIGN)"
  copy-unchanged $copy0
  record $d1 "FULL what CDDESIGN printed when it opened"
  record $closed "FULL what close-windows did"
```

**Twin:** `W1945_BROKEN.case.txt` (the fix's own switch OFF before AutoCAD starts)

```
# W1945_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). The switch-off control of W1945: linking.lpdWarnsWhenOutletsApprovedInAnotherFile false before AutoCAD starts (the style of cases\variants\R09s_new_switch_off_broken.case.txt). OFF is the old behaviour exactly (no path read, no warning), so the warning check must go red while the window still opens.
CASE W1945_BROKEN
TITLE BROKEN VARIANT of W1945: the Save As warning switch OFF, so the warning is not printed (must FAIL)
PLAN_ITEM red-before-green proof for W1945 (BUG-1158)
KIND deterministic
FIXTURE DRV1_LPD_B1
SLOT fresh
SETTING CD_Settings.json linking.lpdWarnsWhenOutletsApprovedInAnotherFile false
ORDER 751
TIMEOUT 600
BUG BUG-1158
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1945
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF CDDESIGN opens as on 3.0.88 and prints no warning, so the two warning checks fail; the window check still passes, which proves the window opened.
WHY_NOT_UNIT_TEST It exists only to prove W1945's warning check can go red.
STEPS
  copy-info -> $copy0
  type "CDDESIGN" -Force -ExpectWindow "Design" -TimeoutSec 120 -> $d1
  ui-dump "Design" -> $dd
  close-windows -> $closed
  esc-prompt
  wait
  windows-snapshot -> $win_end
ASSERT
  control-text $dd has "Start"
  history has "the approved outlets in this drawing were approved when it was saved under another file name or folder"
  history count "approved when it was saved under another file name or folder" = 1
  not-contains $win_end "Design (CDDESIGN)"
  copy-unchanged $copy0
  record $d1 "FULL what CDDESIGN printed when it opened"
```

---

## 3. Codex look notes (BLOCKED-FOR-ROBOT)

Rules for every look: copies only, never a real job file; one evidence folder per look under `C:\CE_WORK\codex\<look id>\` holding a screenshot of each window and the command-line text; never accept or capture a folder a Save box opened in.

### Look 1: #1945 (BUG-1158), the real Save As copy

**BLOCKED-FOR-ROBOT:** needs Save As (a Save box and a second file), which the robot never does. Evidence folder `C:\CE_WORK\codex\w1945`.

1. **Setup (switch ON, the default).** Open a copy of a job. Approve the Design outlets (CDLPD, or in CDDESIGN). Save it.
2. **Same file:** run CDDESIGN. **Right:** the outlets list as before and **no** warning line. Close the window.
3. **Save As copy:** Save As a new name in a new folder. Run CDDESIGN. **Right:** the same outlets list as before, **plus one** command-line line starting "[CE] Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder" (DERIVED). The outlets are still listed as approved, not cleared.
4. **Clear it:** approve the outlets again in CDLPD, save, run CDDESIGN. **Right:** no warning.
5. **Switch OFF** (set before AutoCAD starts; Tim's real settings file is never used): repeat steps 1 to 3 on a fresh copy. **Right:** no warning at any step.
6. **Older approval:** open a job approved before this build. **Right:** no warning, ever.
7. **Never saved:** start a new drawing, approve outlets, run CDDESIGN before saving. **Right:** no warning (a never-saved drawing records no path).
8. **Report:** what the warning really said, and what a drawing started from a template did after its first save. The fix report says what a never-saved drawing's file name really is has not been seen.

### Look 2: #1954 (BUG-1108), the Manningham 2,000 L minimum

**BLOCKED-FOR-ROBOT, and cannot be looked at yet.** The fix tests the minimum against the reuse share (tank less litres kept for detention), but CDDESIGN has no box for the detention litres. The report (`BUGFIX_n6_REPORT_31OCT.md`) says: "cannot be driven until the detention box exists." Today the credit reads as before, whatever is typed. Also stacked on #1874 (not on the release line). Evidence folder, when it can run: `C:\CE_WORK\codex\w1954`.

1. **Wait for:** #1874 merged and the Codex window brief done (a box "Of which kept for detention (litres)" in the Rainwater reuse group).
2. **Then:** on a copy of a Manningham job, in CDDESIGN, set the reuse tank to 3000 L, detention 1500 L, roof 300 m², impervious 500 m², storage 10 m³. **Right:** no reuse credit, net storage stays 10 m³, and a plain reason on the sheet: "reuse share is 1500 L", "3000 L tank less 1500 L kept for detention" (DERIVED from the unit test).
3. **Control:** same job with detention blank or 0. **Right:** credit 0.25 x 10 x 300/500 = 1.50 m³, net 8.50 m³.
4. **Boundary:** 3000 L tank with 1000 L detention gives the credit; 1001 L does not (DERIVED, unit-test cases).
5. **Switch OFF** before launch (`detention.reuseMinimumUsesReuseShare` false): the 3000 L / 1500 L case gives the credit again.
6. **Judgement for Tim:** whether "the majority of the tank must be reuse" is read as tank less detention. That is an engineering call; the desk does not decide it.

### Look 3: #1956 (BUG-1156), Save Draft keeps a newer build's fields

**BLOCKED-FOR-ROBOT:** the route is the Save Draft button (on the refused-button list: `*Save Draft*`), on a drawing that already holds a newer build's draft, which no fixture has. The n6 report's own plan for this was a Codex-owned look (case name C120b). Stacked on #1874. Evidence folder `C:\CE_WORK\codex\w1956`.

1. **Setup (a person):** a copy of a job whose draft record `CE_CVL_DESIGN_START_DRAFT` holds two extra keys no build knows: one at the top (the report calls it `futureRoot`) and one inside the agreed design (`futureLitres`). Read the record text first and keep it in the evidence folder.
2. **Run:** CDDESIGN, press Save Draft, close. Read the record again. **Right:** both extra keys are still there; the answers the build does know are as before.
3. **Switch OFF** (`detention.designDraftKeepsUnknownFields` false, set before launch): repeat on a fresh copy. **Right:** both extra keys are gone (the old fault, so the look shows the switch works).
4. **Ordinary draft:** a draft without extra keys saved with the switch ON. **Right:** same text as before.
5. **Not covered by this fix:** "Agree the design" on an older build records that build's own view. Do not mark it a fault.
6. **Report:** the exact record text before and after, in the evidence folder.

### Look 4: #1961 (BUG-538 part), Manningham reuse credit on its council profile

**BLOCKED-FOR-ROBOT:** by design nothing changes on a Manningham job (same numbers, now read from the council profile), and no typed command prints the reuse credit. The credit reaches only the CDDESIGN window and the computations sheet, and the tank box it needs is in #1874 (not on the line). The fix's own guards are unit tests. Evidence folder `C:\CE_WORK\codex\w1961`.

1. **Wait for:** #1874 on the release line (so the reuse tank box exists).
2. **Run:** on a copy of a Manningham job, CDDESIGN with reuse tank 3000 L, roof 300 m², impervious 500 m², storage 10 m³, tank plumbed for reuse. **Right:** credit 1.50 m³ and net 8.50 m³, exactly as on the previous build (carpark BUG-1096 gives these numbers).
3. **Source named (DERIVED):** the credit line or the computations sheet names the Manningham OSD Guidelines (March 2021) as the source. If it does not say so anywhere you can find, report that plainly; do not guess.
4. **Other councils unchanged:** the same inputs on a Kingston job and a Casey job give the same credit as the previous build (only Manningham moved).
5. **Saved CDRULES run:** on a Manningham job, run CDRULES All and save it on the previous build; install this build; open the same drawing. **Right:** the saved run does not show as out of date (the fix leaves the new source entry out of the fingerprint). This step needs two builds, so it is the desk's; mark it NOT TRIED if only one build is available.
6. **Judgement for Tim, not the desk:** the Kingston, Casey and Bayside figures were not built (no council document is held). They are questions in the n17 report.

---

## 4. Fixes skipped, and why

1. **#1954:** no case and no look yet (the detention box does not exist). Look 2 is parked until it does.
2. **#1956:** no robot case (Save Draft is refused; no fixture holds a newer draft). Look 3.
3. **#1961:** no robot case (nothing visible changes; no command prints the credit). Considered and rejected: a CDRULEBOOK Council manningham then CDRULES Values case. CDRULES never reads the reuse credit, so it would pass on the old build as well and prove nothing. Look 4.
4. **#1945, a no-fixture case:** considered and rejected. On DRV1_B1 no outlets are approved, so CDDESIGN prints no warning with the fix ON or OFF; a case on it could not tell the two builds apart. That is why W1945 asks for the one new fixture.

---

## 5. What was read, built, tested and not proven

1. **Read:** the files and PRs listed in section 1, read-only. `git fetch` only.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Opened in AutoCAD:** nothing.
3. **Not proven:** every printed line, window word, value and path behaviour here. The PR text and source were the only evidence. The state of PR #1945 may have moved since 2 Nov (the report shows heads changing on 31 Oct); re-read it before the case is built.
4. **Sources not read in full:** the whole `BUGFIX_n17` report (only its #1961 lines), and the council PDF (the PR says that was not opened either).
