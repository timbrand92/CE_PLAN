# Robot weak-check repair: N61 (ignored finding stays ignored, switch ON)

Drafted Mon 2 Nov 2026 (Melbourne) by Sonnet, read-only. Nothing was run, built, installed or pushed. The only file written is this one.

## FOR TIM

1. **Verdict: REPAIRABLE-BY-ROBOT, for the part "the ignored finding is no longer offered".** Two new steps and two new checks fix it. The "Checks window tab" and "an edit brings it back" parts stay with Codex.
2. **What N61 claims:** with ignoring switched on, you ignore finding 1 (reason: Engineer's judgement), CE says it "stays hidden", and the Unignore list holds it.
3. **Why it is weak:** it proves the finding was saved. It never proves the finding is hidden. Nothing in the case looks at the finding list after the ignore. A CE that saved the note and still offered the same finding would pass.
4. **Why the twin is weak:** it only claims the wrong reason ("Survey"). That fails on a wrong word. It does not fail because a finding came back.
5. **The fix:** after the Unignore list, ask CDCHECKIGNORE for its Ignore list again. The ignored finding must be gone from it. The new twin skips the ignore step, so the finding is still there and the same check must go red.
6. **Not proven even after the repair:** the Checks window's "ignored" tab, "Asked again" after you edit the pit or pipe, save and reopen, and Undo. Codex look steps are at the bottom. Nothing here has been run.

---

## Technical part (nothing in it is needed to act)

### 1. What was read

1. **Case files:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_next40_b_30oct\` holds the case, its twin `N61_..._BROKEN.case.txt`, the review file, and a `.pre_weakfix` backup. CE 02 already made one repair on 1 Nov: check 5 now quotes the full finding text (the `"1. "` check could not fail).
2. **Reports:** `RUN-20261031-2310-C3.0.88-BaN11` and `RUN-20261101-0009-C3.0.88-BbN11` (both PASS, build 3.0.88+3fbb9da5). `RUN-20261102-0047-C3.0.88-peR3` (PASS, this run is the repaired check 5). The twin FAILED check 2 (`(Survey`) in BaN11, as intended.
3. **Review:** `N61_cdcheckignore_on_stays_ignored.review.txt` (Opus, 1 Nov) says ACCEPT PART. It lists "that the finding stays hidden" as NOT covered. It also hashes the old case text. The case changed after that review, so the review no longer matches (see "What the desk must do").
4. **Source** (`origin/claude/rel-20261102a`, tip 3fbb9da5, read with git show, not built):
   - `CheckIgnoreCommand.cs`: Ignore builds the numbered list from the live checks (`IgnoreFindingPicker.CandidatesForCurrentState`).
   - `IgnoreFindingPicker.Candidates`: skips any finding whose key is already in the ignored list. So after an ignore, the same finding is not offered again.
   - If nothing is left, CE prints "[CE] There is no finding to ignore. Nothing was changed."
   - Otherwise it prints each finding as `n. (!) subject: text`, then asks "Number of the finding to ignore: ".
   - Esc at that prompt changes nothing.
5. **Structural line:** `rel-20261026s` not read. This case is Civil only.

### 2. The weak line

1. **Exact lines in the current case:**
   - `contains $list "(Engineer's judgement"` (line 37) and `contains $list "1. unnamed pipe and WT4: ... (Engineer's judgement"` (line 38). Both read the Unignore list only. They prove the finding was recorded with a reason.
   - The header comment already says it: "NOT FIXED: 'stays hidden' is still not checked".
2. **What would still pass with a broken CE:** one that records the ignore but forgets to filter the list. Both PASS lines above and `history has "It stays hidden..."` would stay green.
3. **Twin:** `contains $list "(Survey"` goes red because reason 3 was typed. The review calls this "only flips the claim".

### 3. REPAIRED case: N61

Header and steps. Whole-or-part claim: **PART** (the hidden-from-the-Ignore-list half; not the Checks window, not "Asked again", not save and reopen, not Undo). DERIVED marks and `REVIEWED_AGAINST` left empty.

```
# N61 REPAIR DRAFT (Sonnet, Mon 2 Nov 2026; NOT RUN YET, NOT REVIEWED). Adds the missing 'stays hidden' check: after the ignore, a second CDCHECKIGNORE (Ignore) must not offer the same finding. The twin N61_BROKEN now skips the ignore and must go red on that check.
# Source: IgnoreFindingPicker.Candidates skips any finding already in the ignored list (3fbb9da5). The list text 'unnamed pipe flows to WT4' was seen in RUN-20261031-2310-C3.0.88-BaN11, RUN-20261101-0009-C3.0.88-BbN11 and RUN-20261102-0047-C3.0.88-peR3.
# DERIVED (never seen): that the second Ignore list prints without the WT4 line (never seen on a run); that '[CE] There is no finding to ignore' or 'Number of the finding to ignore' is what follows. Both are read from source only.
CASE N61
TITLE With ignoring switched on, CDCHECKIGNORE ignores finding 1 for Engineer's judgement, the Unignore list holds it, and a second Ignore list no longer offers it
PLAN_ITEM UX-DI-03 ignored finding stays ignored (top-40 item 25), switch ON half; R10 is the OFF half
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.allowIgnoreFinding true
ORDER 610
TIMEOUT 900
BUG
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CDCHECKIGNORE (Enter for Ignore, 1, 3 for Engineer's judgement, Enter for no note) prints '[CE] Ignored:' and 'It stays hidden until the pit, the pipe or the rule value changes.' and never 'Ignoring a finding is switched off'. CDCHECKIGNORE Unignore then lists one ignored finding marked '(Engineer's judgement'. A second CDCHECKIGNORE (Ignore) either prints 'There is no finding to ignore' or lists findings that do not include 'unnamed pipe flows to WT4'. No command is left waiting.
WHY_NOT_UNIT_TEST The finding list comes from the real drawing and the ignore is written into the live drawing's project record; only the live command shows what the drafter sees.
NOT_AUTOMATED 'Until something changes' (an edit to the pit or pipe the finding names brings it back, 'Asked again: ...' in the palette) is not driven: the subject of finding 1 is not known before the run and the runner cannot pick it out of a line. Recorded only.
NOT_AUTOMATED The Checks window's ignored tab and the CDCHECKS ' · 1 ignored' header are not read (they need checks.checksCommandEnabled and a window look: Codex).
NOT_AUTOMATED Save and reopen: the ignore is not checked after the drawing is closed and opened again.
NOT_AUTOMATED The Undo half (BUG-CDCHECKIGNORE-UNDO-C60: list again, Esc, then U) is not driven.
STEPS
  type "CDCHECKIGNORE{NL}{NL}1{NL}3{NL}" -Force -> $ig
  wait
  sleep 2
  type "CDCHECKIGNORE{NL}Unignore" -Force -> $list
  esc-prompt -> $list_esc
  wait
  sleep 2
  type "CDCHECKIGNORE{NL}" -Force -> $again
  esc-prompt -> $again_esc
  wait
  getvar CMDACTIVE -> $ca
  windows-snapshot -> $win_end
ASSERT
  history absent "Ignoring a finding is switched off"
  history has "[CE] Ignored:"
  history has "It stays hidden until the pit, the pipe or the rule value changes."
  # Positive control: finding 1 really was offered before the ignore, so its absence below means something.
  contains $ig "unnamed pipe flows to WT4"
  contains $list "1. unnamed pipe and WT4: unnamed pipe flows to WT4: Unresolved (not confirmed from the other side) (Engineer's judgement"
  # Positive control: the second Ignore command really ran and reached its list or its empty message.
  matches $again "Number of the finding to ignore|There is no finding to ignore"
  # THE NEW CHECK: the ignored finding is no longer offered.
  not-contains $again "unnamed pipe flows to WT4"
  equals $ca 0
  record $ig "FULL what CDCHECKIGNORE printed (the finding list and the Ignored line)"
  record $list "FULL the Unignore list"
  record $again "FULL the second Ignore list (the ignored finding must be missing)"
  record $again_esc "what the Esc on the second list printed"
```

Changes against the case now on disk:

1. **Added:** steps 3 and 4 (the second Ignore list and its Esc), plus two positive controls and the one new check `not-contains $again`.
2. **Dropped:** `not-contains $win_end "Ignore"` (it reads only the AutoCAD title bar, so it could never fail) and the old `record $list_esc` (the Esc text is now recorded after the second list instead).
3. **Kept:** every other check, unchanged.

### 4. REPAIRED twin: N61_BROKEN

This twin goes red for the right reason: the ignore is never done, so the finding is still offered, and the same check must catch it. Positive control passes, so the red cannot be a step that did not run.

```
# N61_BROKEN REPAIR DRAFT (Sonnet, Mon 2 Nov 2026; NOT RUN YET). Skips the ignore. The Ignore list therefore still offers finding 'unnamed pipe flows to WT4', and the N61 check 'not-contains $again' must FAIL on exactly that line while every step runs.
CASE N61_BROKEN
TITLE BROKEN VARIANT of N61: the finding is never ignored, so it is still offered (must FAIL on the not-contains check)
PLAN_ITEM red-before-green proof for N61 (UX-DI-03)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETTING CD_Settings.json checks.allowIgnoreFinding true
ORDER 611
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF N61
REVIEWED_AGAINST
EXPECTED This variant is wrong on purpose: nothing is ignored, so the first Ignore list still holds 'unnamed pipe flows to WT4' and 'not-contains $again' fails. The Ignore list check ('Number of the finding to ignore') passes, which proves the red is the check, not a broken step.
WHY_NOT_UNIT_TEST It exists only to prove N61's 'stays hidden' check can go red.
STEPS
  type "CDCHECKIGNORE{NL}" -Force -> $again
  esc-prompt -> $again_esc
  wait
ASSERT
  matches $again "Number of the finding to ignore|There is no finding to ignore"
  not-contains $again "unnamed pipe flows to WT4"
```

The old twin (wrong reason "Survey") is no longer needed and can be retired after the new twin has failed once.

### 5. Why the robot alone is enough for this part

1. **It reads a command-line list, not a picture.** The result is a count of lines and a phrase, which the robot can read from the command line.
2. **Red before green is available:** the new twin is the red. The run order is N61 then N61_BROKEN in the same group, as before (same SETTING, fresh slot).
3. **Risks to check when it first runs:**
   - **List length:** `type` returns the whole list at a prompt (the Unignore list came back whole on BaN11, BbN11 and peR3), so the same should hold for the second Ignore list. If the runner returns only the last few lines, `matches` would still pass but the absence check could miss the WT4 line. The positive control on `$ig` (which came back whole) is the hint; look at the `record $again` line on the first run.
   - **The finding numbering:** other findings may move up to number 1 after the ignore. The check names the finding by text, not by number, so this does not matter.
   - **A different finding might also say 'unnamed pipe flows to WT4'** (a second row with the same text but another subject). Not seen on any run. If the first run shows it, the check text needs the subject added.

### 6. What is NOT proven even after the repair

1. **Not read, built, or run by me.** I did not run the robot, AutoCAD or any build. The new case text is a draft; its first run will show whether the steps fit.
2. **The Checks window (palette) hiding the finding** and the ignored tab: a look, not a robot read.
3. **"Until something changes":** an edit to the pit or pipe bringing the finding back with "Asked again".
4. **Save and reopen,** and **Undo** (BUG-CDCHECKIGNORE-UNDO-C60).

### 7. Codex look steps (for items 2 and 3 above; needs checks.checksCommandEnabled on)

1. **Setup:** in a copy of the test drawing (never Tim's), switch ON "ignoring a finding" and the Checks window command in CE Settings. Type CDCHECKS. Screenshot the list, noting finding 1 (for example "unnamed pipe flows to WT4").
2. **Ignore it:** type CDCHECKIGNORE, press Enter, type 1, then 3, then Enter. The command line should say "[CE] Ignored: ... It stays hidden until the pit, the pipe or the rule value changes."
3. **Hidden:** type CDCHECKS again. The finding must be gone from the main list. The header should read "· 1 ignored". The ignored tab should show it with "(Engineer's judgement, <date>)". Screenshot all three.
4. **Comes back:** move the pipe or pit the finding names by about 100 mm, then CDCHECKS again. The finding should be back in the main list with "Asked again: ... changed since you ignored this on <date>". Screenshot it.
5. **Do not save the drawing.** Record: pass or fail on each of steps 3 and 4, with screenshots.

### 8. What the desk must do (not done by me)

1. **Case hash:** the review's `CASE_SHA256_REVIEWED` (01D98793...) matches the pre-repair case. Because CE 02's 1 Nov check 5 edit already changed the file, and this draft changes it again, the old review no longer matches. A new independent Opus review is needed for the repaired case before any "Claude-accepted".
2. **Runs on 3.0.88:** the repaired N61 and the new N61_BROKEN each need a first run. Under the 1 Nov pilot, the second session may not be needed (family first passed in two sessions).
3. **Ledger wording once it passes:** "Claude-accepted, build 3.0.88, <date>, for PART: ignored finding saved and no longer offered by CDCHECKIGNORE". Not for the palette, "Asked again", reopen or Undo.
4. **Install of this draft into the cases folder:** CE 05 or CE 02 (I changed nothing there).
