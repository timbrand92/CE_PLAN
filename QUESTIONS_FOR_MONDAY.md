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

## G. Added Sun 18 Oct (Codex looks L3 and L4 on Civil 3.0.54 / Manager 1.1.54 / Structural 1.0.118)
1. **What should a double-click on a downpipe (DP1) do?** Today it prints the line 'Action for tag "DP1" [Set/Remove] <Set>:' on the command line and opens no window (Codex look L4-07). A double-click on a pipe or its invert text opens the CE Edit Pipe window, so the downpipe behaves differently from them. Recommend: open a small CE window for the downpipe (tag, name, Remove as a button), the same way pipes work; the command-line prompt stays for typed CDEDIT. On a job: a drafter double-clicks DP3 to rename it and gets a window, not a prompt they have to know the keywords for. Builders will not change it until you answer; it is not filed as a bug because it is a design call.
4. **Skip suspect survey points by default?** After the C-44 survey fixes, two raw survey points within 50 mm of each other but with different levels (a wall top and bottom shot) can refuse a whole CDSURVEY load in a millimetre drawing. Turning "skip suspect points" ON by default avoids that. Recommend ON (the old behaviour of refusing the whole load is the bug).

## H. Added Sun 18 Oct (Hunt Civil I, J, K: long sections, WSUD, raingardens)
1. **Should the old WSUD tab in CDCALC credit every ticked measure over the whole site?** Today a Rainwater Tank plus a gross pollutant trap plus a swale multiply their removal rates over the whole site: TSS 89.2%, PASS against 80%. A tank really only treats roof water, so if the swale alone treats the whole site the answer is 70%, a FAIL (HUNT_CIVIL_IJK, IJK-18). The tab is read-only for older drafts only (DFGH-45), so the risk is an old draft or its export showing a PASS that MUSIC would not give. Recommend: label the result "indicative, not a MUSIC result" now, and add a "share of site treated" box per measure later only if you want the tab kept. On a job: the label stops a client reading the tab's PASS as the council-accepted MUSIC result. (No number here is on the Settings page; the targets themselves stay on Settings.)

## I. Added Sun 18 Oct (Hunt Civil L and M: schedules, checks, repair)
1. **When you right-click Remarks on a deep pit and choose Delete cell, what should the drawn cell show?** Today it prints "DELETE With Step Irons" (BUG-783, LM-12). Two sensible answers: blank (you deleted the cell), or just "With Step Irons" (CE still adds the required wording for a pit deeper than the Settings step-iron depth). Recommend: "With Step Irons" only, because a deep pit without the wording is a safety note lost. On a job: a 1.2 m pit would still tell the builder about step irons even though you cleared your own remark.

## J. Added Sun 18 Oct (from the Opus review of drafts #1382 to #1409; REVIEWLANE_LOG entries 1192, 1194, 1218)
1. **[SUPERSEDED 18 Oct by Tim's CEMEMBER design, decisions/2026-10-18_CEMEMBER_DESIGN.md: lines and layers are settled there; do not ask again] SBEAM side elevation: keep the two lines just inside the flanges, and the dashed lines in the front elevation?** BUG-750: those inner lines are the flange-to-web lines a drafter normally draws on a UB, UC, WB or WC, and an existing test pins them. Recommend: keep both as they are (the new Settings switch is ON, so nothing changes) until you say otherwise. On a job: a side elevation of a UB keeps its four lines instead of becoming a bare outline.
2. **[Tim 18 Oct: do what the review recommends: tab stays visible by default; hide is one switch; revisit when CDPROFILE draws branch ticks] CDCALC "Older longitudinal" tab: hide it now, or only after CDPROFILE can draw branch ticks?** Your CD-BRANCH-01 check (a 100 DIA. BRANCH tick at 6.4 m) can only be done through that tab today. Recommend: keep it visible for now (the draft now does that by default; a Settings switch hides it), and hide it once CDPROFILE draws the branch tick. On a job: until then, a colleague can still draw a long section with branch ticks from CDCALC.
3. **LBUH dots spacing at 1:50 and 1:100:** already on this list in section F item 2 (same question as BUG-748). Not repeated here.

## G. CEMEMBER design follow-ups (added 18 Oct 2026 evening; Tim's decisions are in decisions/2026-10-18_CEMEMBER_DESIGN.md)
1. **DIMSCALE / LTSCALE check in CEMEMBER: warn or stop?** (LTSCALE is always 10 x DIMSCALE here, so the check only catches a wrong drawing set-up.) Recommend: warn and carry on, with the line recorded (rule R-27: no hard block unless really serious). Tim has not answered; this is his open item.
2. **Review of the corrected DRAFT section list** (17 types, on the design-session PC in CE_Reference/Corrected_Draft): when would you like to do it, and shall I ask for the files to be copied across? Nothing goes into the repo before you have reviewed it (BUG-818).
3. **Top hats and the ASI Design Capacity Tables:** top hats have no source; the paid ASI tables are the proper check for hollow-section properties. Do you want the tables bought, or are the InfraBuild and steelweb figures enough for now? (Open, no recommendation yet.)
4. **CEMEMBER: purlin lips in the elevations.** The old command draws the lips of Z and C purlins in the section but not in the elevations. Do the elevations need a line at the lip depth? (Open on the card; no recommendation yet beyond "show it, 18cont near side, 18hidden far side, if you draw lips by hand".)
5. **CEMEMBER: please confirm two rules the design chat inferred, not you:** (a) the C purlin rules (same as the PFC: side = flange lines 18cont toward / 18hidden away, top = web inner face 18hidden); (b) the Z purlin SIDE elevation (flange lines 18cont, 25cont edges). Only the Z top elevation was confirmed ("yes correct").
6. **CEMEMBER: tees (BT, CT) and round, square, flat bars:** the card has no line rules for them (never discussed). Do you want them in CEMEMBER at the start, or only the shapes you already draw? Who checks the section-list numbers before they go in? (Open.)

## H. CEMEMBER: answered 19 Oct 2026 (Tim's answers are in decisions/2026-10-19_CEMEMBER_ANSWERS.md; G1 to G6 above are answered except where noted here)
1. **START BUILDING CEMEMBER NOW, OR AFTER THE 9 NOV RELEASE?** The card is approved ("yes") but ruling A pauses new plan items; the desk has not read the approval as lifting the pause. Structural stays on your PC only (ruling B3), so there is no colleague deadline on it, and Structural builder lane 02 is idle ("no bug work left"). Recommend: build it now on lane 02 as DRAFT PRs behind a Settings switch (the old SBEAM and SBEAMEDIT stay untouched until you pass CEMEMBER in AutoCAD), so idle capacity is used and Civil + Manager are not delayed. It needs your yes because it is a new item under the pause.
2. **Lip line positions** (the picture shown to you on 19 Oct): flange line one thickness in from the edge, flange lip line one lip depth in from the edge, 18cont near side / 18hidden far side. Please answer the picture. Also open: lip lines in the TOP elevation, and the C purlin top elevation rule (web inner face 18hidden, inferred from the PFC).
3. **The ten-row check of the section numbers** (310UB32.0, 250UC72.9, 380PFC, 230PFC, 100x100x6 EA, 100x100x6 SHS, 200x100x6 RHS, 114.3 CHS, Z15015, 900WB282): not done yet. The draft list does not enter the repo until it is.
4. **Hollow-section properties and top hat data from "elsewhere":** please send them when you have them.
5. **The Tim AutoCAD checklist for CEMEMBER:** still to be written and agreed before code starts (the design chat proposed: one UB, one PFC in all four orientations, one angle in all four, one SHS, one Z purlin, section in front and beyond, break line sizes at 1:20 and 1:100, Escape, Undo, Enter-to-repeat). Recommend you approve that list as written.

6. **H2 update (19 Oct, later):** Tim confirmed the side-elevation lip line positions ("Yes, the lip picture is right"). Still to answer: lip lines in the TOP elevation, and the C purlin top elevation rule.
