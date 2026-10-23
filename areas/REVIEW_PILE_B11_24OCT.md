# Opus review of the best unreviewed PRs, batch 11 (Sat 24 Oct 2026)

Headless job, desk plan/03, Team (Opus). Input: `PR_PILE_TRIAGE_2026-10-24.md`, class E, positions 115 to 134 (20 PRs). Read-only: no code changed, nothing merged, closed, pushed to a PR branch or deployed. AutoCAD and Codex not started. One build attempted (for #1661 only, in my own worktree `C:\ce-tr\b11`, since removed). It never started, because the shared build lock stayed busy.

## ANSWER FIRST

1. **Twelve of the twenty already had an Opus review, so I skipped them.** #1629, #1631, #1641 and #1644 are in batch 2; #1642, #1643 and #1672 in batch 1 (and 2); #1640, #1655, #1656, #1657 and #1691 in batch 3. I reviewed the other **eight**.

2. **Verdicts for the eight:** MERGE 4 (#1633, #1638, #1690, #1703). MERGE-WITH-FIXES 2 (#1634, #1637). HOLD 1 (#1661, until it has been built and tested once). REJECT 1 (#1670).

3. **Top faults:**
   1. **#1634 points the drafter at the wrong thing.** One new message says "That is a CE pipe or pit", but the check is for a pit or a downpipe (source) block, never a pipe. Another says "CE has no levels for this pit yet" when the real cause is that CE has no record of the pit at all. It also says "Run CDREPAIR > Rebuild", but the CDREPAIR window has two Rebuild buttons.
   2. **#1661 had never been compiled or tested when it was opened.** Its own log says "Builds executed: 0". I tried one build tonight: the shared build lock was held by another job for my whole 30-minute wait (06:03 to 06:33), so it is still unbuilt. The code reads correctly, but nobody knows yet that it compiles.
   3. **#1670 changes no code.** It only adds a "nothing done here" note to the change log, so it fixes none of its five bugs. It belongs in `C:\CE_PLAN`, where it already is (`CODEX_LEDGER_FIX_BATCH16_23OCT.md`).
   4. **#1703 is tests only.** It closes none of its six bugs. Those fixes were installed earlier and still need their AutoCAD test. The triage's label "fixes BUG-..." overstates it.

4. **Safe to merge today, into C-64 (after C-63, after the batch 1 to 3 lists), in this order:** #1638 (privacy), #1633, #1690, #1703. Then #1634 and #1637 once their small wording fixes are pushed.

5. **Risk checks, all eight:**
   1. **Redo (U then REDO):** nothing new writes between a U and its REDO. No PR adds an Idle, command-end or object-change hook. #1690 repaints two palettes when the theme changes, and that touches window colours only, never the drawing.
   2. **Locked layers, Xrefs, REFEDIT:** nothing new touches drawing objects. #1633, #1634 and #1637 change wording only. #1638 changes the name saved inside the ignore record, through the same write CDCHECKIGNORE already made.
   3. **Switches:** none of these PRs adds one, and that is correct. Six are wording, display, tests or notes. #1638 reuses the existing Settings > Privacy > "Name stored in the drawing" choice (coded by default; an office can still choose the login).
   4. **CE_SHARED, installer, signed-update files:** none touched, so none is held for that. #1703 only reads the signed rollback fields in a test; it does not change them.
   5. **Hard-coded engineering values:** none new. #1661's display format (mm sizes, levels to 3 decimals) is presentation, not an engineering value.
   6. **New hard blocks:** none.
   7. **C-63 list (`claude/rel-20261024m`):** every PR clashes with C-63 **only in the change log** (`REGRESSION_LOG.md`). Keep both entries. The code merges cleanly in all eight. C-63 also rewrote the lines just above #1634's CDREBUILDLINKS line, using its own repair-wording helper. They do not clash, but the follow-up note in item 2 suggests one tidy-up.
   8. **Protected files:** the Codex PRs (#1661, #1670, #1690, #1703) touch only windows, tests and the change log. The b03 PRs touch command files on no protected list.

6. **Nothing here needs a decision from Tim.** One item to tell him in work hours: after #1638, the Ignored list shows a coded name ("ce-..." letters) instead of the drafter's login. An office that wants real names can choose "login" in Settings > Privacy.

---

## Each PR

1. **#1633 BUG-927 (Civil): CDTAG's two messages in plain words.** Head 0ea77f4b, base `claude/rel-20261023l`, +69/-2, 4 files. **MERGE, train C-64.**
   1. **Is the cause real?** Yes. In `SourceTagCommand.cs`, pressing Enter on an empty tag goes one of two ways. A block that already has a tag goes to the real Remove path. A block with no tag reaches the line that printed "CDTAG removed.", so the old message claimed a removal that never happened. The success line printed "CDTAG applied: tag=DP2. Pipes linked to this block: 2." exactly as the bug says.
   2. **Does the fix do only that?** Yes. Two messages move into a small wording helper. The new text matches the carpark's "Expected behaviour" word for word.
   3. **Test that fails without it:** yes. The RED commit has the helper with the old text, and a source check that the command no longer prints the old lines.
   4. **Small nit (optional, not blocking):** with no pipes, two lines in a row now say so: "No pipes are connected to it yet." and then the older hint "[CE] No pipes found connected to this block. If ...". Shorten the first one, or drop the "yet" sentence, in a later tidy-up.
   5. **Not in scope, noted:** on a block with no tag, the Enter path still runs a "remove tag" write, although nothing changes. This is old behaviour, made inside the command, so it is not a redo risk.

2. **#1634 BUG-944 (Civil): five command-line messages in plain words.** Head 1108ee05, base `claude/rel-20261023l`, +96/-7, 9 files. **MERGE-WITH-FIXES, train C-64.**
   1. **Is the cause real?** Yes. All five developer-word messages are in the base, at the lines the carpark names.
   2. **Fault 1, wrong object named.** `AnnotationEditCommand.cs` refuses when the picked object is a **pit block or a source (downpipe) block** (`IsPitBlock(br) || IsSourceBlock(br)`), never a pipe. "That is a CE pipe or pit" is wrong. **Fix:** "[CE] That is a CE pit or downpipe block. Use CDEDIT."
   3. **Fault 2, wrong cause.** CDRUNSOLVE stops when `GetPitByHandle` finds **no CE record of the pit at all**. A pit that has a record but no levels does not reach this line. **Fix:** "[CE] CE has no record of this pit. Run CDREPAIR, click 2. Rebuild Project Data, then try again."
   4. **Fault 3, unclear next step.** The CDREPAIR window has "2. Rebuild Project Data" and "Rebuild Compound Links". "CDREPAIR > Rebuild" does not say which. The fix in fault 2 names the button.
   5. **Fine as is:** the slab, CDRULEBOOK and CDREBUILDLINKS lines. CDRULEBOOK > Council already lists the councils before its question, so "Type CDRULEBOOK Council to see the list" is accurate.
   6. **Tests:** RED first, with a source check on each of the five commands. Update the two expected strings in `Bug944PlainCommandMessagesTests` with the fixes above.
   7. **C-63:** C-63 added `RepairReportText` for the CDREBUILDLINKS "rebuilt" and "could not be linked" lines, just above this PR's "skipped" line. No clash. A later tidy-up could move `ItemsSkipped` into `RepairReportText`, so CDREBUILDLINKS has one wording home (design rule 1).

3. **#1637 BUG-945 (Civil): CDAUDIT, Recover Inverts and the read-only audit notes in plain words.** Head 53409864, base `claude/rel-20261023l`, +125/-5, 5 files. **MERGE-WITH-FIXES (one wording change), train C-64.**
   1. **Is the cause real?** Yes. `LinkCommands.cs` printed "pits=12, pipes=14, pipes-without-handle=0, duplicate-handle-groups=1". `LinkCommands.ReadOnlyAudit.cs` printed "cached ownership Unknown".
   2. **Does the fix do only that?** Yes. The summary now counts the pipes in copy groups rather than the number of groups, and the new label ("2 pipes are copies of one another") matches that count. It writes "Type CDREPAIR to review them" rather than the carpark's "fix them", and says why in its log. That is the honest choice.
   3. **The one fix.** The "copied" note also fires when the stored drawing path is simply **missing**: a drawing never saved, or an older record. Saying it "was copied or saved under a new name" states as fact something CE does not know. **Fix:** "this drawing may have been copied or saved under a new name, so CE checks only what is in this file. Nothing was repaired." Then update the one expected string in `Bug945PlainAuditMessagesTests`.
   4. **Left for a follow-up (not blocking):** two neighbouring lines in the same read-only audit still use "Unknown" and "retained for review" ("unreadable item row(s)" and "could not be read completely - Unknown"). Worth one more line in BUG-945, or a new bug.
   5. **Tests:** RED first, with source checks on both files.

4. **#1638 (no bug number, PRIVACY): CDCHECKIGNORE stores the coded name, not the Windows login, in the drawing.** Head 14c8272c, base `claude/rel-20261023l`, +46/-1, 3 files. **MERGE, train C-64, first in this batch.**
   1. **Is the cause real?** Yes. `CheckIgnoreCommand.cs` line 163 passed `Environment.UserName` into the ignore record, and `IgnoredChecks.cs` saves it as "By" inside the drawing. Drawings go to councils and clients.
   2. **Does the fix do only that?** Yes, one argument. It now calls `DrawingPersonName.Current()`, the same rule pipe-connection decisions already use (BUG-490). The default is a one-way coded id ("ce-" and letters), "none" stores nothing, and "login" is the office's own choice. If the coding fails, it stores nothing, never the login.
   3. **Side effects checked:** the only reader of "By" is the Checks list, which shows ", ce-..." after the finding and copes with an empty name. Nothing matches on the name. Ignore records already saved keep the login they hold, because no drawing is rewritten.
   4. **Test that fails without it:** the source check (no `Environment.UserName` in the command) is RED on the base. The coded-name rule test passes both before and after, and the PR says so.
   5. **Switch:** none, and none needed. The office already controls this with the existing Privacy setting. CDCHECKIGNORE itself is OFF by default (`checks.allowIgnoreFinding`).
   6. **Missing:** no carpark BUG number. Give it one when it merges, so the fix can be traced.

5. **#1661 BUG-925 (Civil): saved council-check values shown in plain words.** Head caf3244a, base `claude/rel-20261023l`, +299/-5, 5 files. **HOLD until it has one build and its 15 tests run, then MERGE, train C-64. No code change asked for.**
   1. **Is the cause real?** Yes. `CouncilSourceViewModel.ForSavedFinding` printed `input.UsedValueJson` raw, so a saved pipe showed braces, `EntityHandle` and `SpineKey`.
   2. **Does the fix do only that?** Yes, display only. A new `SavedRuleInputDisplay` lists **only named fields**: From/To pit, Diameter (mm), Material, upstream and downstream IL (m, 3 decimals), Cover RL, Pit IL, pit width and length, detention length and remarks. It skips anything else, so a new internal field can never leak through by default. Ids and handles are dropped, including ones nested inside a known field. The saved evidence itself is not changed (a test pins this). Numbers use the same format whatever the PC's regional settings. Three heading sentences become plain English.
   3. **Both new files are net10-only** (`#if NET10_0_OR_GREATER`), like the window itself. The AutoCAD 2024 (net48) build does not compile this window, so it cannot break there.
   4. **Build and test:** **still none.** The author recorded "Builds executed: 0, compiled tests executed: 0" (build lock held). My one build attempt (`C:-trb11`, net10 Release, filter Bug925, all safety flags) waited 30 minutes for the same shared lock and never started. The test file builds its fixtures with exact constructor shapes (`RuleSourceInput` with 7 values, `RuleFinding` with 8), which only a compile can confirm. The theme reset in the render test is correct (`ThemeService.CurrentTheme` is lower-case "dark"). **What clears the HOLD:** one net10 build of Drainage.Tests plus `--filter FullyQualifiedName~Bug925`, 15 cases, 0 failed, and one look at the dark and light pictures.
   5. **Small points, not blocking:** a saved size stored as text such as "DN225" shows as "Diameter DN225" (no "mm"), which is fine. The render test only saves pictures when `CE_BUG925_DOC_SCREENSHOTS=1`, so nobody has looked at the window yet (RULES 5.2).

6. **#1670 BUG-948 to BUG-952: "batch 16 coverage and protected-work audit".** Head 62c94cef, base `claude/rel-20261023l`, +10/-0, 1 file. **REJECT (Tim's call to close).**
   1. **What it is:** one change-log entry saying all five bugs were skipped and nothing changed. No code, no test.
   2. **Why reject:** the change log records changes, and a "nothing changed" entry clashes with every other PR at the top of the same file. The routing notes are already in `C:\CE_PLAN\areas\CODEX_LEDGER_FIX_BATCH16_23OCT.md`, where plan text belongs.
   3. **Its claims checked:** the three PRs it names are real and open. They are #1595 (BUG-948, Manager Updates page for colleagues), #1603 (BUG-950, mixed brace types) and #1596 (BUG-951, tag heights). BUG-949 and BUG-952 wait on Tim's open Structural questions. None of these five bugs is fixed by #1670.

7. **#1690 BUG-960 (Civil): Checks and What CE Found palettes follow theme changes.** Head a39b638b, base `claude/rel-20261023l`, +197/-17, 19 files (12 are pictures). **MERGE, train C-64.**
   1. **Is the cause real?** Yes. Both palette bodies loaded their own colour set once, when first built (`ApplyThemeToControl` in the constructor). `ApplyResolvedTheme` only refreshed the program-wide colours. AutoCAD keeps a closed palette in memory, so reopening it showed the old theme.
   2. **Does the fix do only that?** Yes. Both palettes register with `ThemeService.FollowThemeChanges` through a weak reference, so a discarded palette is not kept alive. On a real theme change, including a CDS preview and Discard, only their colour set is refreshed, on their own window thread. Contents and the selected tab stay. The buttons switch from fixed to live styles, so they repaint too. The removed `PanelPagerButtonStyle` has no other user. Its size and padding are now set on the three buttons directly.
   3. **Test that fails without it:** four real-control cases, claimed 0/4 on the C-61 base. Builds for all three AutoCAD versions and full suites are claimed green (Civil net10 19,433 passed, 0 failed). I did not re-run them.
   4. **Pictures:** twelve dark and light tab pictures, claimed inspected. I opened none of them.
   5. **Risk:** window colours only. No drawing write, no setting write, no switch. The Checks palette stays OFF by default.

8. **#1703 (Manager): regression cases for BUG-425, 832, 835, 842, 848 and 1028.** Head 4cb41a0b, base `claude/rel-20261023m`, +201/-0, 2 files. **MERGE, train C-64.**
   1. **What it is:** tests only (nine new Manager cases) and a change-log entry. No product code.
   2. **Do the tests check the right thing?** Yes, each against its carpark "Expected behaviour":
      1. **BUG-832:** Manager is not staged alone when Civil fails, but Structural still stages.
      2. **BUG-425:** a locked approval file does not hide the others, and it comes back once unlocked.
      3. **BUG-835:** all five signed "go back to" fields survive a second approval.
      4. **BUG-842:** a locked CE Blocks settings file keeps its original, with no stray `.tmp` copy.
      5. **BUG-848:** a half-written TMP or BAK report is neither sent nor copied.
      6. **BUG-1028:** two failing ribbon tabs give two log lines but one notice, and a broken switch file gets its own notice.
   3. **Safety of the tests:** every file sits under a private temporary folder. I checked that `CeBlocksSettings.FilePath` follows `CE_LOG_DIR_OVERRIDE`, so the BUG-842 test cannot touch the real CE Blocks settings. The override is under TEMP, as the containment guard needs.
   4. **Does it "fix" the six bugs?** No. The fixes were installed earlier, and BUG-425 says "fix installed ... not yet tested". These bugs still need their AutoCAD or Codex check. Do not mark any of them FIXED because of this PR.

## What I did NOT check

1. **No build or test ran at all.** My one attempt, for #1661, never got the build lock (see item 5). The pass counts quoted for #1690 and #1703 are the PR authors', not mine.
2. **No pictures opened** (the twelve in #1690, none produced for #1661). Nobody has looked at either window in AutoCAD.
3. **No AutoCAD.** All wording, theme and privacy results are built (and, where stated, unit-tested) only. Not installed, not Tim-accepted.
4. **The C-63 clash check is `git merge-tree` against `claude/rel-20261024m` at 28987b73.** It shows text clashes, not behaviour clashes. I read C-63's own changes to the four shared command files (none touch the same messages).
5. **The twelve skipped PRs were not looked at again.** Their verdicts stand as written in batches 1 to 3.
6. **Not checked against the other open batch 1 to 10 PRs.** Many of those also add entries at the top of `REGRESSION_LOG.md`, so expect more change-log clashes, each settled by keeping both entries.
