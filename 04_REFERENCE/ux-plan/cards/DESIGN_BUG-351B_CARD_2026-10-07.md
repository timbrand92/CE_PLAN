# DESIGN CARD BUG-351 b: pipe label grade after a level typed in the Pit Schedule (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Your ruling stands (INT-046, 4 Oct): "BUG 351B - ONLY CHANGE THAT END". Only the end you type moves. This card is only about what the label and the warning say afterwards.

## What you would see in AutoCAD

1. You type a new IL for P2 in the Pit Schedule. Only P2's end of the pipe moves, as today.
2. On a pipe held at a set grade (say 1 IN 100), the label keeps 1 IN 100. The command line and the WARNING column on both pit rows say the levels now give about 1 in 67. This part is built and waiting to be installed.
3. On 3 Oct a review saw a label keep 1 IN 193 after a typed level, while its levels gave about 1 in 136. Question 1 covers pipes like that one.

## Questions

1. **On a pipe set to take its grade from its levels, should the label grade update when you type a level?**
   - **Recommended:** yes. The label then matches the levels it was worked out from.
   - **Job:** a 20 m pipe from 20.00 to 19.85 is labelled 1 IN 133. You type 19.80 at the low pit. The label becomes 1 IN 100. If you say no, it keeps 1 IN 133 and gets the warning instead.
2. **How far off may a held-grade label be before CE warns?**
   - **Recommended:** 10 %, changeable on the Settings page.
   - **Job:** label 1 IN 100, levels give 1 in 95: no warning. Levels give 1 in 67: a warning on both pit rows.
3. **Should the warning also show on the plan, next to the label?**
   - **Recommended:** no. It stays in the Pit Schedule window and on the command line, so issued sheets stay clean.
   - **Job:** you print the drainage plan the same afternoon. No extra text sits beside the pipe label.

## What stays safe

1. Esc in the window changes nothing. One typed level is one Undo, and the label change goes with it.
2. A label on a locked layer, in an Xref or in a reference edit is left as drawn. CE names it in plain words.
3. The 10 % sits on the Settings page (Drafting > Grade note tolerance), not fixed in the plugin.
4. CE warns and carries on. It never refuses your typed level. If CE cannot be sure of the pipe length (a drawing whose units and pit sizes disagree), it gives no warning rather than a wrong one.

## Once you approve

1. **Builders:** install the held-grade warning, which is already built and reviewed. If you answer yes to question 1, they make the label of a grade-from-levels pipe re-work its grade after a typed level.
2. **Test that proves it:** on a copy, set a 10 m pipe P3 to P2 to Custom 1 IN 100 (20.00 to 19.90). Type 19.85 at P2. The label stays 1 IN 100 and both rows say about 1 in 67. Set a second pipe to grade from levels, type a level, and its label changes. One U puts each one back.

---
For builders (Tim need not read): PR #643 (Opus MERGE @5197f71f, 2 LOW open: step-irons text via one-argument `ApplyCombinedWarning`, source pins for `SyncInvert`). Held = `LinkService.IsGradeHeld` (custom, defaultStd, defaultMin); not held = blank, "default", "inverts". Question 1 example source: BUG-353 item 2 (P3 to P2, 1 IN 193 vs about 1 in 136, 3.0.22); which grade mode that pipe had is NOT recorded, so check the label refresh path (`ScheduleLinkService.SyncPipeToPlanByHandle`) for "inverts" pipes before building. Read: BUG_CARPARK BUG-351, BUG-353; decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md line 416.
