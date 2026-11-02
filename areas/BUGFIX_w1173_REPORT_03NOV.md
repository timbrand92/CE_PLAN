# BUGFIX w1173 report, BUG-1173 colleague pack wording (B-175), Tue 3 Nov 2026

## FOR TIM

1. **Result: ALREADY FIXED in the pack. No PR opened, no code changed.** Page 02 of the colleague pack (`C:\CE_PLAN\areas\colleague-pack\02_INSTALL_AND_UPDATE.md`) already has what the bug asked for.
2. **Step 4 (line 31)** lists all five settings folders to copy aside: `TIM_CE_CADTOOLS`, `CE_CVL_SUITE`, `CE_CADTOOLS`, `Creative Engineering\CE Suite Manager` and `CE_SUITE_MANAGER\logs`. That is the original two plus the three missing ones.
3. **Going back, step 5 (line 91)** says to restore all five folders and, if the CE Manager pull-down menu stays loaded, to type `MENULOAD`, find `CE_SUITE_MANAGER_MENU` and unload it.
4. **Added by commit db6bbd79** in C:\CE_PLAN (the pilot-critical batch 4 report).
5. **The pack is not in the plug-in repo.** `origin/claude/rel-20261102a` has no pack text (no `_PRE_V3` or pack page there), so a plug-in PR has nothing to change. No Settings switch: a switch is not meaningful for hand-read pack wording, so none was added.
6. **Mistakes of my own:** none. I did not build, test or start AutoCAD, and made no worktree.
7. **NOT proven:** the pack's own [CHECK] note stands, that unloading the menu this way removes it has not been rehearsed on a spare login. That rehearsal is the bug's test, so BUG-1173 stays OPEN until Tim accepts it.
8. **Two wording items from the 30 Oct p1 report are still NOT in the page** (pack changes need approval through the pack-changes list, so I did not edit): "also `%APPDATA%\CE_SUITE` if it exists" (optional hand-written Manager switch file), and "if a `_PRE_V3` folder already exists, stop and tell the desk; never copy over it". One-line question for CE 05/Tim: approve adding both to page 02 step 4?

## Technical detail

1. Checked: page 02 lines 31 and 91 (above); carpark entry BUG-1173 and both evidence notes; p1 report `BUGFIX_p1_REPORT_30OCT.md` item 9.
2. Code files named in the entry are where the folders are written, not backup code, so no code fault exists.
3. Robot case: none applies (document-only fix). The proof is the manual rollback rehearsal: after rollback on a spare login, no `CE_CADTOOLS` or `CE Suite Manager` folder remains and the CE Manager menu is gone. No switch-off control, since there is no switch.
4. Isolation listing of %APPDATA% folders: not taken, because no test was run and nothing was written.
5. C: free space: unchanged (no worktree or build created).
