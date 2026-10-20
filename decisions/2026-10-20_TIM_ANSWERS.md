# Tim's answers, Tue 20 Oct 2026 evening (to the desk's list of 15 decisions)

Source: desk chat CE_ACAD / ideas / plan / 03, after the recount (V3_RECOUNT_2026-10-20.md) and the list sent to him. His words are quoted; the desk's reading follows each. Supersedes where they differ: ruling A of 17 Oct (QUESTIONS K11), QUESTIONS H1 and the open items named below.

1. **Ruling A and 9 Nov.** Tim: "pause until im back and then full steam ahead to v3, unless we finish bug fixes before then, if we do then full steam ahead to full v3. we want to get the colleague issue ready for 9th november".
   - Reading: the pause on new plan items stays until Tim is back (Thu 29 Oct). EARLIER trigger: if the bug-fix queue is finished before then (the lanes report "no bug work left" AND every fix named in this answer list is built, reviewed and in a train), plan items resume at once, in this order: the 9 Nov scope first (Civil + Manager + Shared, 390 items), then the rest of V3 ("full V3"). The colleague release (Civil + Manager) must be ready for Mon 9 Nov; candidate freeze about Mon 2 Nov stands.
2. **CEMEMBER.** Tim: "build now". Supersedes QUESTIONS H1 and the pause for this item only. Rules that still bind: the draft section list stays OUT of section-catalogue.json until Tim has reviewed the ten-row check; the Tim AutoCAD checklist is written and attached before he tests; Structural stays on his PC only (ruling B3).
3. **Main pipes marked Detention with no stored length read "not judged".** Tim: "yes". (BUG-815 follow-on; the row tells the drafter to enter the length or untick Detention.)
4. **A label with no clear spot because of SC slab notes (BUG-141).** Tim: "yes leave it". Leave it where it is; he moves it by hand. BUG-141 may be proposed for closure when Tim confirms in AutoCAD.
5. **Colleague installs go by the deploy chat's route until BUG-823 and BUG-824 are fixed.** Tim: "yes".
6. **Pipe step irons: the 1000 to 900 mm move runs once only (BUG-825).** Tim: "yes".
7. **Old installer packages: warn plainly and carry on; refuse a build older than the one the office approved for that PC (BUG-834).** Tim: "yes".
8. **CE Tools > Version on a PC without Structural (BUG-852).** Tim: "move version into manager".
9. **25C and EBT text heights follow one Settings value (BUG-531).** Tim: "yes".
10. **Robot may use (setvar ...) lines for CELWEIGHT or DIMSCALE on TEST copies only.** Tim: "yes".
11. **Double-click on a downpipe (DP1) opens a small Edit window like pipes.** Tim: "yes".
12. **All scales (AD, hatch density, break lines, text heights and so on).** Tim: "all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale does that make sense?"
    - Reading (desk answer: yes, it makes sense): one scale source, the drawing scale from DIMSCALE (LTSCALE = 10 x DIMSCALE, warn only, as in the CEMEMBER design). No scale is a special case: AD accepts every DIMSCALE (1:50 included, no "only 20 or 100" refusal), hatch density is the same dots per square cm of paper at every scale (BUG-748, section B4/F2 closed by this rule), break lines, text and hatch sizes derive from the same value. Open for Tim to correct if the desk read it wrongly: any value he wants fixed per scale is a Settings value, not code (R-00).
13. **Imported pit schedules: "pit depth" is measured to the pit floor.** Tim: "pit floor". (PR #1366, BUG-737.)
14. **Remove the stale Manager 1.0.0 in C:\ProgramData\Autodesk\ApplicationPlugins.** Tim: "yes". NOT DONE: the rename is denied without administrator rights (tried 20 Oct 18:55, non-elevated). Its PackageContents.xml is already renamed DISABLED-duplicate-appdata-wins, so AutoCAD does not load it. For Tim at home: run PowerShell as administrator and paste: `Rename-Item -LiteralPath 'C:\ProgramData\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle' -NewName 'CE_SUITE_MANAGER.bundle.REMOVED-stale-1.0.0'`.
15. **Switch on the two Structural warnings (stirrup cover under 10 mm; unusual reo spacing).** Tim: "yes" (twice). DONE 20 Oct 18:57 on his PC: `CE_STRUC_SUITE\CS_Settings.json` keys `WarnInsteadOfChangeStirrupCover` and `WarnInsteadOfRefuseSpacing` false -> true (byte-level, backup `CS_Settings.json.PRE_TIM_YES_20261020.bak`, JSON valid). That file's SHA-256 changed from 24D8E5F7D87B to F68EEB5E343C: every robot brief that lists 24D8E5F7D87B must now expect F68EEB5E343C (Tim changed it himself).

Also done on his instruction today: deleted `C:\Lisp Files\_TEST_COPIES_20260923\V3UX_20261013` (7.3 GB) after "delete 7.2gb".
