# Robot case drafts: BUG-1273 Cascade Preview pit count (PR #1994). BUG-1094, 1272 and 1270 depth skipped, no new PR (Tue 3 Nov 2026 early hours Melbourne, read-only drafter, Sonnet)

**What this is.** Case drafts as plain text, each under the file name it should get. Nothing was built, tested, installed or opened in AutoCAD. No case file was created anywhere. This is the only file written. (The brief named the folder as `C:\CE_PLANreas`. That is not a real folder, so I read it as `C:\CE_PLAN\areas`.)

---

## FOR TIM

1. **One case pair drafted, not four.** Only BUG-1273 (job 242) has a draft PR: #1994. Its case is W1273 (order 790) and its twin W1273_BROKEN (order 791) that must fail. Orders 792 to 799 are unused.
2. **What the case checks, in drawing terms.** Edit Pipe on pipe P3, change the levels to 17.60 and 17.50, answer Yes to "Recalculate downstream", and stop at the Cascade Preview window. It should read "4 pipes, 3 pits will change". After Apply the command line says "Updated 4 pipes and 3 pits". The two pit numbers must match. Before the fix they read 5 and 3.
3. **The fix is NOT in any build you can test today.** I checked: PR #1994 (head 1e310948) is not in the installed Civil 3.0.89 (61fd6fbc), not in 3.0.90 (cf059dcf), and not in rel-20261106a. The b2 branch (rel-20261110a) does not exist on GitHub yet, so I cannot say. Run W1273 only on a build that contains 1e310948. On 3.0.89 it will fail on the pit wording, which is the old fault itself.
4. **The twin only proves something on a build that has the fix.** On 3.0.89 both the case and its twin fail for the same reason, so that red proves nothing. On the fixed build the case passes and the twin fails: that pair is the proof.
5. **One decision of yours is not recorded.** Your open question 3 (batch of 2 Nov) offered two wordings: "5 pits including the one you picked", or count only changed pits. I found no answer from you. The PR took the second. I did not treat that as your decision. If you want the first, this case's expected wording changes.
6. **Skipped, and why (details at the bottom).** BUG-1094: no new PR, only a Codex window brief. BUG-1272: stopped before any PR, because real AutoCAD data files changed during its test run. BUG-1270 depth half: diagnosis only, and it needs your choice (a) or (b). BUG-1270 decimals (#1990) was job 221, not in this batch.
7. **Not verified.** Every wording marked DERIVED was read from code or reports, not seen on a run. The robot has never read this window. The case reads it with the "ui-dump" window reader, which has read other modal windows, but not this one. If that read fails, the case is BLOCKED, not failed. The count of 5 pits before the fix comes from Codex's look S5-02 on 3.0.89, which may have been on a different drawing from the robot's.
8. **Nothing for you to test or decide today** apart from item 5.

---

## 1. Facts checked, and where each came from

1. **Fetch.** I ran `git fetch origin` first. Remote release branches now present: `claude/rel-20261102a` (tip 3fbb9da5, Civil 3.0.88), `claude/rel-20261106a`, `claude/rel-20261108a` (tip cf059dcf, Civil 3.0.90). There is no `claude/rel-20261110a`.
2. **Which PRs exist (read with `gh pr list --state open --search "BUG-1094 OR BUG-1272 OR BUG-1273 OR BUG-1270"`).** Four came back: #1994 (BUG-1273, job 242), #1990 (BUG-1270 decimals, job 221), #1962 (BUG-1094, B-131, from 31 Oct, an older PR) and #1402 (BUG-785, older, not in scope).
3. **PR #1994 (read with `gh pr view 1994`).** Title "B-168: BUG-1273 Cascade Preview states the pits that will change". Open, draft. Base `claude/rel-20261102a`. Head `claude/w1273-preview-count`, commit 1e310948. Files: `PropagationPitCount.cs` (new), `PropagationPreviewViewModel.cs`, `UserSettings.cs`, `REGRESSION_LOG.md`, and a new test file.
4. **Ancestry (checked with `git merge-base --is-ancestor`).** 1e310948 is NOT an ancestor of 61fd6fbc (installed Civil 3.0.89), of cf059dcf (3.0.90, candidate b1 = c1076), or of `rel-20261106a`. Its parent is 3fbb9da5, the 3.0.88 line. So nothing installed or in b1 holds this fix.
5. **The switch.** `linking.cascadePreviewCountsChangedPits`, default ON, in `CD_Settings.json` under group `linking`. Read in `UserSettings.cs` on the PR head (JSON name `cascadePreviewCountsChangedPits`, default true). CE reads settings at AutoCAD start, so the twin sets it before launch.
6. **The wording in code (read on the PR head, `PropagationPreviewViewModel.cs` around line 215-222).** Switch on: `"<pipes> pipes, <M> pits will change — ready to apply"`. M leaves out the anchor pit and any pit with no CE record. Switch off: `"<pipes> pipes, <every pit row> pits — ready to apply"`. The dash in the text is an em dash. The case avoids it and matches on "ready to apply".
7. **The window text is readable.** The summary is a plain text block bound to `SummaryText` (`PropagationPreviewDialog.xaml` line 86). It has no AutomationId, so the robot reads it as part of the window text. The v3 allow-list has `*Cascade Preview*` (press Cancel and Close). The v2 allow-list has it with Apply (slow press, 120 s).
8. **Route precedent.** W658 (`cases\drafts_c79b1_01nov\W658_cascade_after_edit_save.case.txt`, a draft written for the C-79b1 area test plan, NOT shown to have run) and R11 use this exact route on DRV1_B1 with SETUP-R47v: select pipe P3 (handle 10A98D), `CDEDIT{NL}Y`, set 17.60 and 17.50, press "Edit pipe, Save", `msgbox-answer "*Recalculate*" Yes`, then `ui2-press "Cascade Preview" "Apply" -Secs 120`. Its expected history line is "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50). Min grade: 1:16." That is the same 4 pipes and 3 pits as BUG-1273's carpark entry (Codex S5-02: "4 pipes, 5 pits", then "Updated 4 pipes and 3 pits from P3 (IL 17.50)"). I assumed S5-02 was this fixture and route. I did not confirm it.
9. **The Apply press.** `Apply` is in the v2 press list and is NOT in the v3 list (v3 never-buttons holds "Apply"). So the read uses v3 `ui-dump`, and the press uses v2 `ui2-press`, as W658 does.
10. **BUG-1273 carpark entry** (`C:\CE_PLAN\BUG_CARPARK.md` line 18033): status OPEN, "fix-ready only after an owner decision on the wording". The PR chose "count only changed pits". Tim's answer is not in the open-questions file I read (`OPEN_QUESTIONS_FOR_TIM_BATCH_02NOV.md` item 3 shows a default of the other wording). Not edited by me.
11. **Overlap.** PR #1994's report says draft #1989 also edits `PropagationPreviewViewModel.cs`. A merge should keep both sides. Not a case issue.

---

## 2. Case texts

**How these are written.** README_CASES.md format. Fixture DRV1_B1, SLOT fresh, SETUP-R47v. Every `type` chain is a complete command, no `(`, no SAVE-type word. REVIEWED_AGAINST is empty. Run alone, outside Tim's hours (not 8:30am to 2:00pm or 3:00pm to 5:30pm Melbourne, Monday to Friday). Validate first with no AutoCAD: copy each block to its file in a new folder (suggested `cases\drafts_w1273_03nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`. No case unlocks a layer, detaches an Xref or bypasses a protection. No Save, Delete, Publish or Send button is pressed.

### Case 1 of 1: W1273 and W1273_BROKEN

**Intended file:** `W1273_cascade_preview_states_pits_that_change.case.txt`

```
# W1273 DRAFT (read-only drafter, Sonnet, Tue 3 Nov 2026; NOT RUN, NOT REVIEWED). PR #1994 (B-168, BUG-1273; carpark stays OPEN). Switch linking.cascadePreviewCountsChangedPits, ON by default (this case sets nothing: it proves the shipped default).
# RUN ONLY ON A BUILD THAT HOLDS COMMIT 1e310948. It is NOT in Civil 3.0.89 (61fd6fbc), 3.0.90 (cf059dcf) or rel-20261106a (checked with git merge-base --is-ancestor on 3 Nov). On 3.0.89 this case FAILS on the pit wording ('5 pits'), which is the old fault itself and not a tool problem.
# Route copied from W658 and R11 (DRV1_B1, SETUP-R47v): pipe P3 (10A98D), CDEDIT, Y to the older-version question, first invert 17.60, second 17.50, Edit pipe Save, Yes to the Recalculate box. Then the Cascade Preview window is read BEFORE Apply with ui-dump (v3, read only), then Apply with ui2-press (v2).
# DERIVED, never seen on a run: the preview line 'N pipes, M pits will change - ready to apply' with N = 4 and M = 3. Source: Codex S5-02 on 3.0.89 (preview '4 pipes, 5 pits', Apply line 'Updated 4 pipes and 3 pits from P3 (IL 17.50)'), the carpark entry BUG-1273, and the PR's own example ('4 pipes, 3 pits will change'). If S5-02 was not this fixture the numbers differ; the first run decides. Keep the 'equals' of the two pit numbers as the real test and re-write the literals only if the first run proves the fixture differs.
# The dash in 'ready to apply' is an em dash in code; this case matches on 'ready to apply' only.
CASE W1273
TITLE Edit Pipe on P3 then Recalculate downstream: the Cascade Preview says 3 pits will change, and after Apply the command line says 3 pits (the same number)
PLAN_ITEM PR #1994 (B-168, BUG-1273) PART: the summary line of the Cascade Preview window and the count on the completion line, read from the real window and the command line. NOT whole: that the pit rows listed in the window are unchanged, and how the window looks, are a Codex look (K3_01); the other wording choice (including the anchor, Tim's open question 3) is not covered
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-R47v
ORDER 790
TIMEOUT 1500
BUG BUG-1273
PROVES_BUGS BUG-1273 (the count half only, on a build that holds 1e310948)
REVIEWED_AGAINST
EXPECTED After SETUP-R47v: select pipe P3 (10A98D), CDEDIT, Y, first invert 17.60, second 17.50, Edit pipe Save, Yes to Recalculate. The Cascade Preview window opens and its summary reads '4 pipes, 3 pits will change - ready to apply' (it must NOT contain '5 pits'). Apply prints '[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50)'. The pit number in the preview (3) equals the pit number on the completion line (3). The window is closed at the end. The drawing file on disk is unchanged.
WHY_NOT_UNIT_TEST The unit tests prove the counting rule and the wording on and off. Only a live Cascade Preview on a real drawing shows which pit rows exist (the anchor, a pit with no CE record) and that the real Apply writes the same number the preview now states.
NOT_AUTOMATED How the window looks and that the pit rows still list every pit including P3: Codex look K3_01.
NOT_AUTOMATED Which pit in the drawing has no CE record (Codex did not list the five in S5-02): not read. The case only proves the two numbers agree.
NOT_AUTOMATED The settings-read at start-up on the real file (both read paths are pinned in unit tests only). The twin sets the key before launch, so it proves the real read once.
NOT_AUTOMATED U after Apply is not driven here (W658 and R11 cover the cascade undo).
STEPS
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}50000,-30000{NL}80000,-20000" -Force
  wait
  pick-first "10A98D"
  type "CDEDIT{NL}Y" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $edit_t1
  ui2-set "Edit Pipe" "C2.FirstInvert" "17.60"
  ui2-set "Edit Pipe" "C2.SecondInvert" "17.50"
  ui-press "Edit Pipe" "Edit pipe, Save" -> $save_press
  sleep 4
  msgbox-answer "*Recalculate*" Yes
  sleep 4
  ui-dump "Cascade Preview" -TimeoutSec 120 -> $pv
  ui2-press "Cascade Preview" "Apply" -Secs 120
  wait
  sleep 3
  history-tail -> $h_after
  windows-snapshot -> $win_end
ASSERT
  contains $pv "pipes, 3 pits will change"
  contains $pv "4 pipes"
  contains $pv "ready to apply"
  not-contains $pv "5 pits"
  history has "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50)"
  history count "Updated 4 pipes and 3 pits" = 1
  not-contains $win_end "Cascade Preview"
  not-contains $win_end "Edit Pipe"
  copy-unchanged $copy0
  record $pv "FULL Cascade Preview window text before Apply (summary line and pit rows)"
  record $h_after "FULL command line after Apply"
```

**Twin:** `W1273_BROKEN_cascade_preview_states_pits_that_change.case.txt`

```
# W1273_BROKEN DRAFT (Tue 3 Nov 2026; NOT RUN). The switch-off control (the style of R09s_new_switch_off_broken): linking.cascadePreviewCountsChangedPits false before AutoCAD starts, so the older count of every pit row returns. Same route and same checks as W1273. It must FAIL on the preview-wording checks (it reads 'N pipes, K pits - ready to apply', K = every pit row, DERIVED 5 from S5-02); the route, the Apply line and the unchanged file still pass.
# Same build rule as W1273: it proves anything only on a build that holds 1e310948. On 3.0.89 it fails for the same reason as W1273, so a red twin there proves nothing.
# If this twin PASSES on the fixed build, the switch did not take effect (the key was not read at start) and W1273 cannot tell old from new: send it to Codex look K3_01 and say so.
CASE W1273_BROKEN
TITLE BROKEN VARIANT of W1273: the new switch is OFF, the preview counts every pit row again, the case still expects 'pits will change' (must FAIL)
PLAN_ITEM red-before-green proof for W1273 (PR #1994, B-168, BUG-1273)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-R47v
SETTING CD_Settings.json linking.cascadePreviewCountsChangedPits false
ORDER 791
TIMEOUT 1500
BUG BUG-1273
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1273
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the preview reads 'N pipes, K pits - ready to apply' (no 'will change'), so the preview checks fail. The Apply line still reads 'Updated 4 pipes and 3 pits', so the history checks pass.
WHY_NOT_UNIT_TEST It exists only to prove W1273's preview checks can go red.
STEPS
  copy-info -> $copy0
  type "_.ZOOM{NL}_W{NL}50000,-30000{NL}80000,-20000" -Force
  wait
  pick-first "10A98D"
  type "CDEDIT{NL}Y" -Force -ExpectWindow "Edit Pipe" -TimeoutSec 120 -> $edit_t1
  ui2-set "Edit Pipe" "C2.FirstInvert" "17.60"
  ui2-set "Edit Pipe" "C2.SecondInvert" "17.50"
  ui-press "Edit Pipe" "Edit pipe, Save" -> $save_press
  sleep 4
  msgbox-answer "*Recalculate*" Yes
  sleep 4
  ui-dump "Cascade Preview" -TimeoutSec 120 -> $pv
  ui2-press "Cascade Preview" "Apply" -Secs 120
  wait
  sleep 3
  history-tail -> $h_after
  windows-snapshot -> $win_end
ASSERT
  contains $pv "pipes, 3 pits will change"
  contains $pv "4 pipes"
  contains $pv "ready to apply"
  not-contains $pv "5 pits"
  history has "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50)"
  history count "Updated 4 pipes and 3 pits" = 1
  not-contains $win_end "Cascade Preview"
  not-contains $win_end "Edit Pipe"
  copy-unchanged $copy0
  record $pv "FULL Cascade Preview window text before Apply (the old count is in the summary line)"
  record $h_after "FULL command line after Apply"
```

**Do not use `hashes-unchanged` in the twin.** It sets a key, so the settings file differs while the guard holds it (README_CASES, phase 3 batch 1, item 2). Both cases use `copy-unchanged` only.

---

## 3. BLOCKED-FOR-ROBOT: Codex look steps

**K3_01 (Cascade Preview, BUG-1273).** Run on a build that holds commit 1e310948. Use a copy of the drawing, never the master. Say in the report which Civil version the About window shows.

1. **Set up.** Use the same drawing and route as S5-02 (the one where the preview said "4 pipes, 5 pits"). If you cannot, use DRV1_B1 after SETUP-R47v: pipe P3.
2. **Open the window.** Select pipe P3, type `CDEDIT`, answer Y, set the first invert 17.60 and the second 17.50, press Edit pipe Save, answer Yes to "Recalculate downstream inverts?".
3. **Look at the Cascade Preview summary line.** It should read "4 pipes, 3 pits will change - ready to apply". Take a picture and write down the exact words.
4. **Count the pit rows listed in the window.** Write the number. The fix keeps the rows as they were, so the list should still show every pit including P3, the one you started from. Write down which pit is P3 and which one, if any, shows no CE data.
5. **Press Apply.** Read the command line. It should say "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50)". Write down the exact line.
6. **Compare.** The pit number in step 3 should equal the pit number in step 5. PASS only if they match and the rows in step 4 are unchanged. If you can, name the two pits the count leaves out (P3 and the pit with no record).
7. **Switch-off control, optional.** Close AutoCAD, set `linking.cascadePreviewCountsChangedPits` to false in `CD_Settings.json` under `linking`, start AutoCAD and repeat steps 2 and 3. The line should read "4 pipes, 5 pits - ready to apply" with no "will change". Then put the setting back to true.
8. **Do not decide the wording.** If the line reads differently from step 3 above, record it and stop. The choice between "count only changed pits" and "5 pits including the one you picked" is Tim's.

**K3_02 (the robot cannot see how the window looks).** Same session as K3_01. Look at the whole Cascade Preview window and confirm the summary line is not cut off, nothing overlaps it, and the wording is plain. Report with a picture.

---

## 4. Skipped items and why

1. **BUG-1094 (Inspector "no Grade line"), job 240.** No PR from this job. The report (`BUGFIX_w1094_REPORT_02NOV.md`) says "No PR opened" and wrote a Codex window brief (`BRIEF_W1094_INSPECTOR_HEALTH_02NOV.md`). The fix PR #1962 (B-131) is an older PR from 31 Oct and is inside 3.0.89 per the carpark note. The report already names a robot case, `B1_04c_inspector_checks_grade`, with a switch-off control on `grade.inspectorFlatterThanMinimumShowsRed`. I did not write it out: the brief says skip a job with no PR. Its steps are in that report, item 6. It needs a Codex look at the Checks tab first, because the report's open doubt (technical item 4) is whether the stored levels reach the check at all.
2. **BUG-1272 (Material conflict sentence twice in Edit Pipe), job 241.** Stopped without a PR, on purpose. The branch `claude/w1272-editpipe-banner` (commit 640b2578) is not on origin (checked with `git branch -r`; only `w1270-cdsync-decimals` and `w1273-preview-count` show). The report stopped because 17 real data files changed and 42 appeared between its two folder listings, and some could not be told apart from other jobs' writes. It waits for a word from you or CE 01: "files in the real data folder are fine, push the PR" or "stop". The report's robot case name is `W1272_ep_banner_once` with switch `pipe.editPipeWarningShownOnce`. The typed strings were never written. Not drafted.
3. **BUG-1270 depth half (job 243, `BUGFIX_w1270b_REPORT_03NOV.md`).** Diagnosis only, no PR. By code read, the 1.00 to 1.10 depth step on P8 is the BUG-605 first-time pit-floor fill plus your 20 Oct depth rule, not a coding fault. It needs your choice (a) keep filling from the lowest pipe end, or (b) leave it blank and measure to the lowest pipe straight away. No driver edits before 9 Nov per that report. Not drafted.
4. **BUG-1270 decimals half, #1990 (B-162, job 221).** Not in jobs 240 to 243. It is covered by `ROBOT_CASE_DRAFTS_FIXES_1989_1993_02NOV.md` (job 226).

---

## 5. What was read, built, tested, and NOT proven

1. **Read.** `C:\TimOS\RULES.md`; `README_CASES.md`; the style file for BUG-1195; the four fix reports (w1094, w1270b, w1272, w1273) and the w1270 report names; `gh pr list` and `gh pr view 1994`; PR #1994's `PropagationPreviewViewModel.cs`, `PropagationPitCount.cs`, `UserSettings.cs` and the dialog XAML on the PR head; the carpark entry for BUG-1273; the W658 and N50 case drafts; the two driver allow-lists. After `git fetch origin`.
2. **Built.** Nothing. **Tested.** Nothing. No AutoCAD, no robot, no driver edit, no settings file read or written, no agent spawned, nothing pushed.
3. **NOT proven.** That W1273 validates in the runner. That the v3 window reader returns the Cascade Preview text while the window is open and a CE command waits behind it. That the fixture gives 4 pipes and 3 pits (DERIVED from S5-02 and the W658 draft, which has not been shown to run). That the old build reads "5 pits" on this fixture. That 1e310948 will be in b2: I could not check, the branch is not on GitHub.
