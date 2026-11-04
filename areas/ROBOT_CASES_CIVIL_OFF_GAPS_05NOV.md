# Civil OFF: gaps in CE 05's robot cases and Codex brief (CE 02, Thu 05 Nov 07:28, paper only)

Reviewed ROBOT_CASES_AND_BRIEF_CIVIL_OFF_04NOV.md (CE 05 job 426, orders 970 to 982) against CODEX_REVIEW_CIVIL_OFF_04NOV.md (Codex, 5 Nov 00:37) and REVIEW_CIVIL_OFF_SLICES_04NOV.md (Opus). Nothing was built, run or validated; no AutoCAD. Cases below use orders 983 to 989, the unused part of CE 05's range.

## FOR TIM

1. **What is good:** 13 robot cases and a five-part Codex look already cover the question box, Leave it as it is, the OFF refusal for CD and CDSYNC, a quiet open of an OFF drawing, the switch-off control, and Upgrade this drawing once with one backup. I changed none of them.
2. **One wrong expectation in the Codex brief (L1 step 4):** it says pressing Escape on the question must count as No. Codex's own source reading says Escape cannot dismiss the Yes/No box (a plain Windows Yes/No box ignores Escape). Change the step to RECORD what Escape does; do not mark it a fail. Same for the X button: record.
3. **Biggest gap: Undo.** Codex's main risk is that Undo can restore the OFF mark while CE still remembers Civil ON (the drawing and CE then disagree). The brief has one U in L2 step 2; no robot case. I added CO11 and CO12 (Undo and REDO of Leave it as it is, and of the CDDISCIPLINE Off answer).
4. **Four commands that skip the OFF check have no case** (CE 05 held them back until the fix exists). The review names them, so I drafted one case each (CO13 to CO16, orders 985 to 988), all marked as a known gap that fails today, like CO04. Add them to the run once the fix is in, or run them now to prove the gap.
5. **Codex brief additions:** (a) run the whole look on the slice 4 tip (#2018) AND on the slice 1 tip (#2015), because Codex found the later slices lack slice 1's newest protection fixes; (b) new step: a drawing already on the new build, saved and reopened, carries the version mark (Codex says an ordinary save need not stamp it); (c) new step: look in the Settings window for rows named for options.civilOffPerDrawing, askAboutOlderProjectsOnOpen, olderProjectBanner and oneUpgradeAction (Codex says none are visible); (d) in L4 step 6 also type REDO after the U and record what the pipes and CD do.
6. **Not proven:** none of this was run, validated or seen in AutoCAD; box titles and log words are the ones CE 05 derived from code.

## Added robot cases (paper)

```
# CO11 DRAFT (CE 02, 5 Nov 2026; NOT RUN, NOT REVIEWED). Codex main risk: Undo restores the OFF mark while CE remembers ON.
CASE CO11
TITLE After Leave it as it is, one U leaves the drawing and CE agreeing: CD either refuses everywhere or works everywhere, never half
PLAN_ITEM Civil OFF card; Codex review 5 Nov, main risk (slice 1 Undo)
KIND deterministic
FIXTURE DROMANA_PRE_C7
SLOT launch
ORDER 983
TIMEOUT 900
BUG
EXPECT-FAIL CIVIL-OFF-UNDO
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED After answering No to the older-project question, CD refuses (OFF). After one U, the Civil log OFF line and the answer of CD agree: if CD refuses, the drawing is still marked OFF; if CD works, the log says Civil is ON. Mixed (log OFF, CD works, or log ON, CD refuses) is the fault.
WHY_NOT_UNIT_TEST Undo restores the stored mark in the drawing; CE keeps its own copy in memory; only a live U shows whether they stay together.
NOT_AUTOMATED REDO is case CO12. The Save changes question (Codex L2).
STEPS
  type "CD" -Force -TimeoutSec 60 -> $cd_before
  esc-prompt -> $e1
  wait
  type "U" -Force -TimeoutSec 60 -> $undo
  wait
  type "CD" -Force -TimeoutSec 60 -> $cd_after
  esc-prompt -> $e2
  wait
ASSERT
  contains $cd_before "Civil is OFF in this drawing."
  record $undo "FULL what U printed"
  record $cd_after "FULL what CD printed after U"
  history-tail-has-pair "Civil is OFF for this drawing" "$cd_after" agree
```
(The last line is a placeholder for the runner's existing way to compare a Civil log line with a command-line line; the case writer picks the real verb, for example two "log civil count" lines read with the same case.)

```
# CO12 DRAFT: same as CO11, then REDO. ORDER 984. EXPECT-FAIL CIVIL-OFF-UNDO.
CASE CO12
TITLE After Leave it as it is, U then REDO returns to Civil OFF and CD refuses again, with the log saying OFF
STEPS: as CO11, then  type "REDO" -Force -TimeoutSec 60 -> $redo ; wait ; type "CD" -Force -TimeoutSec 60 -> $cd_redo ; esc-prompt
ASSERT: contains $cd_redo "Civil is OFF in this drawing."   (and the log has no line saying Civil is ON after the REDO)
```

```
# CO13 to CO16 DRAFT (orders 985 to 988): one case each, copy of CO04 with the command changed. Known gap, fails today.
CO13: CDTIDYLABELS  CO14: PITSCHEDULE (answer the window by pressing Close; the robot reads the first line)  CO15: CDCHECK  CO16: CDUPGRADE
Each:  FIXTURE DROMANA_PRE_C7_OFF ; EXPECT-FAIL CIVIL-OFF-FIX2 ; ms-count -> $cnt0 ; type "<COMMAND>" -Force -TimeoutSec 60 ; esc-prompt twice ; ms-count -> $cnt1
ASSERT: contains <printed> "Civil is OFF in this drawing." ; equals $cnt1 $cnt0 ; record the printed text
```
Order 989 is left spare. CDREBUILD (named in CO04's note) can be CO17 once the others pass the validate check.

## Codex brief edits (apply to ROBOT_CASES_AND_BRIEF section 3)

1. L1 step 4: replace "Right: counts as No" with "RECORD what Escape and the X do (Codex's code reading says Escape does nothing). Wrong only if the upgrade runs."
2. Header of section 3: add "Run the whole look first on the slice 1 tip (#2015), then on the slice 4 tip (#2018)."
3. L2: add step 4 "Type U, then REDO. After each, type CD and read the Civil log: record whether the drawing's mark and CE's answer agree."
4. Add L6 "Version mark and Settings rows (about 10 minutes)": open a drawing made on the new build, save, close, reopen: record whether the Civil log shows a version mark. Open the CE Settings window and write down whether any row mentions the four Civil OFF switches.
