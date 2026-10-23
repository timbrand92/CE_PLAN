# MAX BUILD G report: review fixes pushed to 12 draft PRs (Sat 24 Oct 2026, Melbourne)

Builder: Sonnet 5.5 on the Max meter. Source reviews: `REVIEW_CX4_AND_BATCH4_24OCT.md` and `REVIEW_PILE_B1` to `B11_24OCT.md`. Every fix was made on the PR's own branch (new commit on top, normal push, no rebase, no force push, no other branch touched). Nothing deployed, AutoCAD and Codex not started, no PR closed, no branch deleted, no bug marked FIXED, CE_SHARED and Tim's settings, bundles and ProgramData not touched. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the ref paths from the C-62 assembly report. My worktrees were all under `C:\ce-mx4` (removed at the end, nothing else under any `C:\ce-*` folder touched).

## ANSWER FIRST

1. **Result:** 12 PRs now carry the review's fix, a test and a REGRESSION_LOG.md entry: #1728, #1722, #1731 (the three you named) and 9 from the PR pile (#1634, #1637, #1614, #1597, #1626, #1419, #1225, #1167, #1195). All 12 are built and unit-tested only. None has been opened in AutoCAD.
2. **New heads, in the order above:**
   1. **#1728** `115eeaf0` (branch `fb/b5-bug1036-roughness-note`).
   2. **#1722** `db50498a` (`fb/b5-bug1035-shallow-pit-setting`).
   3. **#1731** `2878e6c2` (`fb/b5-bug1038-typed-bar-count`, Structural).
   4. **#1634** `9354d130` (`b03/bug-944-plain-command-messages`).
   5. **#1637** `584fd168` (`b03/bug-945-plain-audit-messages`).
   6. **#1614** `d91e4dfb` (`b03/bug-1009-xref-row-no-host-zoom`).
   7. **#1597** `10ed4f53` (`b03/bug-1024-spine-upgrade-project-behind`).
   8. **#1626** `e852f258` (`b03/bug-998-redesign-before-levels`).
   9. **#1419** `f0a87b5a` (`b03/bug-803-rebuild-original-pit`).
   10. **#1225** `6ace3ae1` (`claude/b3-bug552-fault-report-scrub`).
   11. **#1167** `1cc57d9d` (`claude/bug-555-491-help-web-attribute-log`).
   12. **#1195** `f26ea66b` (`claude/m03-standard-files-repair`, Manager).
3. **Two review points turned out different when I tested them:**
   1. **#1626:** the review asked for the "before" levels to be swapped when an older pipe record runs the other way. I wrote that matching (and tested it on its own), but a record running the other way never reaches that code: the redesign's binding check already refuses it earlier ("Connection ... does not match its stored CE endpoints") and the preview reads Unknown. So the swap is a guard, not a visible fix. The other half (pipe limit 4,000, not the pit limit 2,000) is a real fix. The REGRESSION_LOG.md entry says this plainly.
   2. **#1722:** the Settings window stayed within its 670 px limit; the new box sits on the Pipes & Pits tab, which had room. No layout decision was needed from Tim (his answer would still replace the draft position).
4. **Tests that were red, and why:** one Civil test, `BackTest_GlenEira24115_Computed_WithinTolerance` (an engineering back-test, 34.6% error against a 30% allowance), fails on the older-base PRs (#1614, #1597, #1419, #1225, #1167). I proved it fails identically on the plain `claude/rel-20261022m` base (built it, ran that class: 9 of 10 pass, this one fails), so it is not from these fixes. It is a real open item for whoever owns that back-test, not something I changed. The PDF test `LoadAsync_ValidSinglePagePdf...` (blank page in this AutoCAD session) failed in some runs and passed in others under load; one Help-render timeout failed once. All other tests passed.
5. **Not done, with reasons:** see section 3. In short: PRs whose fix needs a rebase onto the C-63 train were skipped as instructed (#1643, #1593, #1588, #1657, #1691); #1198's wording needs Tim's choice; the other Structural fixes (#1590, #1592, #1596, #1598, #1560, #1572, #1457, #1212, #1245) were not attempted (a Structural build and test costs about 25 minutes each on this busy PC, and 9 of the allowed 10 pile fixes were already used on Civil and Manager first).

## 1. Per PR: what was fixed, tests, totals

Totals are the full test project for that PR's base, net10, Release. The Civil bases differ, so the totals differ.

1. **#1728 (BUG-1036, Civil, base C-62).** Fixed: the Pipe Flows Roughness box started at a fixed 0.013, so the new "per office Settings" note was untrue until a pipe was picked. It now starts from the Settings Manning's n for concrete pipe (0.013 with the office defaults). Tests: 2 new (Settings 0.015 gives a 0.015 start; source check that no fixed text remains). Totals: **19,552 total, 19,530 passed, 22 skipped, 0 failed**; the class alone 4 of 4.
2. **#1722 (BUG-1035, Civil, base C-62).** Fixed: added the "Shallow pit depth" box (mm, usually 300) to Settings > Pipes & Pits > PIT SCHEDULE under "Rows per sheet", with a catalog entry, draft/load/save/reset wiring and a plain warning line for zero, negative or unreadable figures (no hard block). Tests: 3 new plus the window's value list updated; the Settings-fit test (tallest tab 670 px or less) passes. Totals: **19,558 total, 19,536 passed, 22 skipped, 0 failed**.
3. **#1731 (BUG-1038, Structural, base `rel-20261023s`).** Fixed: Bars per face needs 2 or more (typed entry, live preview and OK), so a column can no longer be labelled 0N20; the message says each face has its two corner bars. Beam and round-column boxes still take 1 or more. Tests: 7 new in `Bug1038BarCountEntryTests`; that class **23 of 23 pass**. Totals: **the Structural net10 run passed 4,616 of 4,616 completed tests, 0 failed, then the test host hung on a later test and I stopped it** (my class passes alone, so the hang is not from the new tests, but I did not find which test hangs; the S-42 report says one Structural evidence class hangs and I had already excluded that one by name). So the remaining Structural tests (the S-42 chunked total was 5,704) did not run.
4. **#1634 (BUG-944, Civil, base `rel-20261023l`).** Fixed: the CDEDIT redirect now says "CE pit or downpipe block" (it never stops on a pipe), and the CDRUNSOLVE line says "CE has no record of this pit. Run CDREPAIR, click 2. Rebuild Project Data, then try again." The test and helper were renamed to match. Totals: **19,455 total, 19,432 passed, 22 skipped, 1 failed** (the PDF-render test, which also failed alone under load; it passed in other runs and this PR changes no PDF code).
5. **#1637 (BUG-945, Civil, base `rel-20261023l`).** Fixed: the read-only audit note says the drawing "may have been" copied or saved under a new name (the path can also simply be missing). One expected string in the test updated. Totals: **19,458 total, 19,436 passed, 22 skipped, 0 failed**.
6. **#1614 (BUG-1009, Civil, base `rel-20261022m`).** Fixed: double-click (and the inlet/outlet highlight buttons) on a Pit Schedule Xref row no longer looks the pipe up in the current drawing; the footer says the pipe is in an attached drawing. Tests: 2 new (behaviour through the real view model, and a source-order check that the guard comes before the lookup). Totals: **19,159 total, 19,139 passed, 19 skipped, 1 failed** (the pre-existing GlenEira back-test above).
7. **#1597 (BUG-1024, Civil, base `rel-20261022m`).** Fixed: a record-only CDSPINEUPGRADE Apply no longer saves an empty rollback file (which would hide the earlier real one); the closing line says no rollback file was needed. Tests: 2 new (including the two source checks the review asked for). Totals: **19,159 total, 19,139 passed, 19 skipped, 1 failed** (same back-test).
8. **#1626 (BUG-998, Civil, base `rel-20261023l`).** Fixed: the per-pipe level list uses the pipe limit (4,000); the level matching by pit name is in as a guard (see answer-first point 3.1). Tests: 5 new cases (matching rule, and 3,000 pipes accepted / 4,001 incomplete). Totals: **19,459 total, 19,436 passed, 22 skipped, 1 failed** (PDF-render test only, load-related).
9. **#1419 (BUG-803, Civil, base `rel-20261018d`).** Fixed: the old-to-new handle map leaves out the stored handle of any copy, so a kept pit is never redirected to an unrelated pipe; spine keys are counted before the blank-handle skip. Tests: 3 new. Totals: **18,451 total, 18,431 passed, 19 skipped, 1 failed** (same back-test).
10. **#1225 (BUG-552, Civil, base `rel-20261009w`).** Fixed: a bare drawing name with spaces and no job number is removed whole from fault reports, back to the start of the line or the last quote, colon or bracket ("Smith House Stage 2.dwg could not be opened" now gives "[drawing name removed] could not be opened"); plus the source check that the fault report, heartbeat and command record go through the scrub. Tests: 8 new; the class **24 of 24**. Totals: **16,791 total, 16,771 passed, 19 skipped, 1 failed** (same back-test).
11. **#1167 (BUG-555, Civil, base `rel-20261009w`).** Fixed: CDHELP says "could not be opened" (not "missing") when the guide file exists. Tests: 2 new. Totals: **16,781 total, 16,761 passed, 19 skipped, 1 failed** (same back-test).
12. **#1195 (Manager M03, base `rel-20261009w`).** Fixed: one missing optional file reads "It is not needed to run CE"; several keep "They are". Tests: 2 new. Totals: **Manager net10 702 total, 702 passed, 0 failed** (that old base's whole Manager suite is 702 tests, which is under the "thousands" mark; it is the full project, not a filtered run).

## 2. What I did NOT test

1. **Nothing was opened in AutoCAD.** Every fix is built and unit-tested only. Several fixes are command-line wording or Settings-window layout, which only a look in AutoCAD proves.
2. **Not rebuilt without the fix** to watch each new test go red. New tests either reference a name that did not exist before (so they cannot compile on the old code) or assert wording that changed; I did not run each one against its old code except the GlenEira base check above.
3. **Structural:** only #1731, and its full run did not finish (4,616 passed, then a hang I did not chase). Net48 and net8 were not built for any PR (net10 only), so the "must also load on net48" rule is not proven for these changes; none of them uses a net10-only feature as far as I saw, but I did not build it.
4. **The CE_TRANSFORM_2027 placeholder:** each worktree needed a 0-byte placeholder (untracked, never committed), as the C-62 assembly report describes, because no native build exists on this machine.
5. **Window pictures:** I did not look at the Settings window for #1722; only its automatic fit test ran.
6. **Merge conflicts with other open PRs** were not re-checked after my commits (my commits touch the same REGRESSION_LOG.md top as the other PRs, so keep both sides, as before).
7. **Shared build lock:** `C:\CE_PLAN\desk_jobs\build.lock` was present and 0 bytes since 23 Oct 20:24 the whole time (unreadable "busy"), so I did not take it. Other sessions' builds ran at the same time; I ran one build at a time and set my dotnet processes to Below Normal.

## 3. Skipped, and why

1. **Needs a rebase onto the C-63 train, skipped as instructed:** #1643 (BUG-982; rebase and use the C-63 helper), #1593 (BUG-1021; rebase onto installed and merge #1635 first), #1588 (BUG-994; rebase onto C-63), #1657 (BUG-917; rebase and keep C-63's labels), #1691 (BUG-961; rebase).
2. **Needs Tim's word:** #1198 and the repair-advice half of #1195 (which wording: "run the CE installer again" or "ask your CE administrator").
3. **Hold, not a fix list:** #1716 (needs a rebase across two LandXML PRs) and #1721 (waits on its own full suite). Neither was in my brief; named here only so nobody thinks they were looked at.
4. **Structural pile fixes not attempted:** #1590 (name the Setting in the warning), #1592 (CEHATCH preview switch), #1596 (two "(O)" texts), #1598 (CANNOSCALE 1:1), #1560, #1572, #1457, #1212, #1245. Each is a few lines but each needs a Structural build and a test run of 25 minutes or more on this PC; I stopped at 9 pile fixes, all Civil or Manager.
5. **Left out on purpose (the review says no change needed):** the #1637 follow-up lines ("Unknown" and "retained for review"), #1634's slab / CDRULEBOOK / CDREBUILDLINKS lines.

## 4. Things the desk should know

1. **Each pushed commit puts a new REGRESSION_LOG.md entry at the top of the file,** so every one of these PRs will clash with every other PR on that file when merged. Keep both sides each time.
2. **#1419 and #1167** still have the merge clashes the reviews listed (UserSettings.cs two groups side by side, and the log); I did not touch them.
3. **The GlenEira back-test failure** (`BackTest_GlenEira24115_Computed_WithinTolerance`, SSR 1.69 m3 against 2.58 m3 actual) is present on `claude/rel-20261022m` and on every older-base PR above. It does not show on the C-62 base (`rel-20261023m`), where the full suite had 0 failed, so the assembled trains should be clean of it. Whoever assembles a train from older-base PRs should expect to see it.
4. **Bug status:** none marked FIXED; BUG-1036, BUG-1035, BUG-1038, BUG-944, BUG-945, BUG-1009, BUG-1024, BUG-998, BUG-803, BUG-552, BUG-555 and Manager M03 all stay open until a Codex or Claude-accepted pass in AutoCAD.
