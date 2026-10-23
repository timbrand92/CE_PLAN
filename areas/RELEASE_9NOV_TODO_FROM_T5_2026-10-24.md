# 9 Nov hand install: to-do list taken from Team audit T5 (24 Oct 2026)

Source: `areas/TEAM_AUDIT_T5_24OCT.md`, the checklist of 30 must-be-true items (6 met, 14 not met, 10 unknown). These are jobs to do or facts to find out, not faults in the plug-in, so they are listed here and not in the bug carpark. The 14 real faults T5 found are BUG-1165 to BUG-1178. Checklist items that are already faults with a number are not repeated here: BUG-882 and BUG-883 (installer), BUG-885 (unsealed package), BUG-477, BUG-478 and BUG-948 (update and roll back buttons), BUG-888 (no uninstall), BUG-483 (stale ProgramData copies), BUG-488 and BUG-492 (diagnostics and privacy), MGR-01 and F-023.

Nothing here is done. Tim's word makes the hand-over decision (due Fri 6 Nov); the jobs below prepare it.

1. **Rehearse the hand install twice on a spare standard Windows login** (checklist 7). Copy the two bundles into `%APPDATA%\Autodesk\ApplicationPlugins`, start AutoCAD, write down whether AutoCAD asks "Load / Always Load" for each CE file. Target before Fri 30 Oct.
2. **Rehearse the rollback on that same login** (checklist 18). Include the three extra settings folders and the CE Manager menu (BUG-1173).
3. **Seal the package to the tested files** (checklist 6). Copy the frozen `C:\ce_rc_scratch\c1058` folder and read every file hash back; do not rebuild. Install the seal (#1649) first if it is ready.
4. **Find out Max's AutoCAD year** (checklist 8, colleague pack page 06 question 2). Then drive this build in that year (checklist 9): nothing on 3.0.72 has been driven in 2022 to 2026.
5. **Look at Max's all-users plug-in folders** (checklist 10, page 06 question 4): `C:\ProgramData\Autodesk\ApplicationPlugins` and `C:\Program Files\Autodesk\ApplicationPlugins`. An administrator clears any old CE copy the week before (BUG-1165).
6. **Read Max's old July Structural** (checklist 11, page 06 question 3): AppVersion, date, and whether it holds a CE_SHARED.dll. Switch it off or move it aside before the first start (BUG-1169).
7. **Record Max's current Manager version** (BUG-1170). If it is older than 22 Jul, plan the rollback steps and the ProgramData check.
8. **Check where Max's OneDrive puts "Creative Engineering - Drafting"** and the Standard Details and Drawing Templates folders (checklist 13 and 24, BUG-1166). Confirm it shows fully synced before his first AutoCAD start (BUG-1168).
9. **Decide the "Load / Always Load" answer and the trust setting** (checklist 12). The pack marks it [CHECK]; the installer sets SECURELOAD and installs WebView2, a hand copy does neither.
10. **Run a first start on a fresh profile and read the CE log** (checklist 22, gap plan 3.11). It should be clean.
11. **Get an approved colleague-defaults export** (checklist 14, F-023), with every folder path blanked (BUG-1167). Do not copy Tim's settings file as it stands.
12. **Switch on the Windows Sandbox feature** (checklist 7) so the install rehearsal harness can run.
13. **Finish the known-problems page** (checklist 27). It is still the 22 Oct draft.
14. **Decide where the frozen release copy sits** (checklist 28, page 06 question 5). That is publishing, so it is Tim's call.
15. **Take the old July install scripts out of the IT Admin folder** (checklist 29, BUG-483, page 06 question 6).
16. **Deliver the package from USB or the synced pilot folder, not as a downloaded zip** (BUG-1176).
17. **Confirm folder sharing for CDFEEDBACK reports** (checklist 24, page 06 question 11), so Tim sees what Max sends.
18. **Close the three engineering HIGHs or attach a warning** (checklist 25): HIGH 1 is installed (#1530), HIGH 2 is in C-63 and not installed, HIGH 3 has no PR.
19. **Reach 30 of the 40 daily-tool checks accepted** (checklist 26). It is 1 of 40 today (recount 4).
20. **Ask Max for his AutoCAD year as well as the version line** until the status bar names the lane properly (BUG-1172).
21. **Tim's word "yes, hand it to Max"** (checklist 30), due Fri 6 Nov.
