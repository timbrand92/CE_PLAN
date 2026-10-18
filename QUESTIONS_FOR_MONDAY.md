# Questions queued for Tim's Monday 08:40 session (desk plan/03 keeps this list)

Rule (Tim, 17 Oct 2026, RULINGS B5 in decisions/2026-10-17_V3_ALIGNMENT_RESET.md): questions for Tim wait for the weekly Monday morning session (scheduled task ce-monday-questions) unless something is urgent. Builders still never wait for answers: each question below has a recommended default that is built or kept as a DRAFT behind a Settings switch; Tim's answer replaces it. Last updated Sat 17 Oct 2026 by the desk.

## A. Open items repeated from REMINDERS_FOR_TIM.md
1. **Use the decompilation chat for real fix and feature work** (REMINDERS item 1).
2. **Stale Manager 1.0.0 (build cac19768)** in the all-users ApplicationPlugins folder (REMINDERS item 2): recommend remove; needs administrator rights; the desk will not touch it without his yes.
3. **Two Structural warnings are OFF in his own settings file** (REMINDERS item 3, stirrup cover under 10 mm and unusual reo spacing) while ON for new installs: recommend switch them on.

## B. Things the next installs will change (so he is not surprised)
1. **CDCHECKDWG reports** go to the CE logs folder instead of beside the checked drawing (switch checks.consultantCheckReportBesideDwg restores the old place). Civil train C-40.
2. **FASTSAVE** only saves now (switch Options.FastSaveAlsoCleans restores clean-up). Structural train S-38.
3. **Four Structural fixes are ON by default** because the old behaviour was the bug: colour/linetype/dimension style restore, dimension redraw after scale change, hatch and break line at any scale, Section Mark letter placement. S-38.
4. **Hatch density at 1:50** is a straight line between his 1:20 and 1:100 values (not an approved number): confirm or give the number.
5. **Window position memory** ships OFF; recommend switching ON only after a Codex run on two monitors.

## C. Standing question batches (already written, with recommendations)
1. **Codex bug triage, 11 questions:** areas/release-v3-colleagues-CODEX_BUG_TRIAGE_2026-10-16.md section 4.
2. **Gap audit, 15 questions:** areas/release-v3-colleagues-PLAN_GAP_AUDIT_2026-10-17.md section 3. Many are on hold under ruling A (new items paused); answer only the ones that decide fixes (office minimum cover 300 or 600 mm; show command names beside plain names, already ON by his ruling; clearances batch when features resume).
3. **Older batches:** TIM_BATCH_QUESTIONS_STRUC_LANES_2026-10-10 and TIM_BATCH_TESTING_AND_RELEASE_2026-10-10 (areas/), Batch 6 Q1 and Q5, Set C Q5, the BUG-466 FPFC question (reused mark PF9 becomes PF5 with the 600 mm default), markup same-place distance (15 mm recommended), WSUD runoff coefficient (0.85 or 0.9).
4. **Open design calls from the builders:** BUG-641 (how paving is shared between pits), BUG-648 (AG drain grade label needs its own link), BUG-454/531 (label heights), BUG-578/579 (Modify workflow card), BUG-587 (pit schedule row-height card).

## D. Release shape (from RULINGS B, for confirmation of the plan only)
1. Colleagues get Civil + Manager first, all working features, plain AutoCAD only. Structural installs on his PC only until he says it is ready.
2. His PC always gets the newest passing build of all three; colleagues only builds marked as a release; Manager to run both lanes (planned, not built, paused by ruling A).
3. A tool switches ON by default once Codex passes it in AutoCAD (Q4 = YES): the desk applies this in the next fix train for anything already Codex-passed.

## E. Added Sat 17 Oct evening
1. **BUG-531 text heights:** 25C text and EBT text come out different heights at DIMSCALE 50 (125 against 250). Which height is right, or should both follow the Label plot height setting? Recommend both follow one Settings value.
2. **H2 confirm (H5 is answered: CE does NOT go quiet, rulings I2):** the four working situations (from markup; designing and drafting at once; engineer designing only; two people at once) match the office, and an engineer-checks-the-drafter step gets its own flow.
4. **Robot staging by LISP:** may the robot use (setvar ...) lines to set CELWEIGHT or DIMSCALE on unsaved TEST copies (never on your real drawings)? Recommend yes.

## F. Added Sun 18 Oct (Codex looks L1B and L2 on Civil 3.0.54 / Structural 1.0.118)
1. **Should the Dimension tool (AD) accept 1:50, or stay 1:20 and 1:100 only?** Today at 1:50 it prints 'Warning: Current DIMSCALE is 50. Only DIMSCALE 20 or 100 is supported.' and places nothing (Codex look L2-03b). The hatches and break line now work at 1:50, so a drafter at 1:50 can draw the detail but not dimension it. Recommend: accept 1:50 (and any normal plotted scale) with the same 2.5 mm paper text height as 1:20 and 1:100; the Codex raster check also read the dimension digits at about 2.6 mm against the 1.75 mm capital height the look expected, which is approximate and worth settling with the same decision. On a job: a 1:50 footing detail gets its dimension from AD instead of a hand-made one. Not filed as a bug until you decide.
2. **DOTS hatch at 1:50 and 1:100: give the paper density, or accept 'same dots per square centimetre of paper as 1:20'?** BUG-748: DOTS is dots at 1:20, bands at 1:50 and a solid pink blob at 1:100. This is the same question as section B item 4 (1:50 is an unapproved straight line between your two values). Recommend: hold the paper spacing of your 1:20 value at every scale, so the dots look the same on the printed sheet; builders will use it as a draft default behind a Settings switch. On a job: the sand or fill pattern on a 1:100 plan stays readable dots instead of a pink block.

## F. Added Sun 18 Oct (from the Opus review of the survey and import fixes)
1. **Pit depth in imported pit schedules:** in the pit schedules you receive, is "pit depth" measured to the pit floor or to the outlet invert? It decides whether CE keeps that level as the pit floor for a one-pipe pit (PR #1366, BUG-737). Recommend: to the pit floor, and CE keeps today's behaviour until you confirm.
2. **BUG-685 on hold:** a typed 10.125 against the two-decimal rule (still open since 17 Oct).
3. **Hatch at 1:50 and AD at 1:50:** Codex saw the DOTS hatch turn solid at 1:100 and AD refuse 1:50. Should AD accept 1:50 (hatch density is currently a straight line between your 1:20 and 1:100 values, not an approved number)?
