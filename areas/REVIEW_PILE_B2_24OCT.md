# Opus review of the best unreviewed PRs, batch 2 (Sat 24 Oct 2026, about 04:47 to 05:10 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 11 to 20, then class F plan-work items 1 to 5.

I read the code at each PR's exact head (all heads re-fetched from GitHub at about 04:50; none had moved since the triage). I compared each one with the installed Civil 3.0.72 / Manager 1.1.72 line (`claude/rel-20261023m` @ f7f7d551) and with the assembled C-63 train (`claude/rel-20261024m` @ 28987b73), using in-memory trial merges. Read-only: nothing built, tested, merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts (15 PRs reviewed):**
   1. **Class E, items 11 to 20:** MERGE 7, MERGE-WITH-FIXES 2, HOLD 0, REJECT 1.
   2. **Class F, items 1 to 5:** MERGE 2, MERGE-WITH-FIXES 2, HOLD 0, REJECT 1.

2. **Top faults found:**
   1. **#1644 (CDRUNSOLVE wording) is already fixed in the installed version.** #1617 put the "Nothing was changed. CE could not size these pipes..." line into 3.0.72. #1644 adds a second, differently worded message after it, and that message can hardly ever be reached. Two code paths for one message breaks design rule 1. Do not merge. Closing it is Tim's call.
   2. **#1190 (Checks "Explain") is a second copy of CDRULES Explain.** The `RuleExplainer` explanation has been in the code since 5 Sep. #1190 builds a separate one with its own wording, and nothing uses it. Do not merge. The one useful idea (say where the number came from, and "not confirmed" when it was assumed) should go into the existing Explain.
   3. **#1614 (Xref row in the Pit Schedule) fixes the single click but not the double-click.** Double-click an Xref row and CE still looks up that row's inlet or outlet pipe handle in your own drawing. It can still select and zoom to an unrelated object, which is exactly what the bug says must never happen.
   4. **#1588 (Inspector drawn length) clashes with C-63.** C-63 rewrote the same three lines (the pipe-type fix, #1546). It needs a rebase that keeps both changes.
   5. **#1198 and #1195 (Manager wording rules) tell a colleague to "run the CE installer again".** #1672 (batch 1, BUG-918) moved Manager away from that advice: "ask your CE administrator to finish the update". The two should say the same thing before either is wired in.

3. **Safe to merge today, into C-64 (after C-63, after batch 1's list), in this order:** #1628, #1629, #1631, #1573, #1599, #1561, #1641, and #1314 (Tidy labels, only matters with its switch ON). Then #1588 and #1614 once their fixes are pushed. The Manager rules #1200, #1198 and #1195 are safe but nothing uses them yet. They belong on a later Manager plan train, not the 9 Nov pilot train.

4. **Two things to know before the train is built:**
   1. **Every PR clashes on `REGRESSION_LOG.md`.** That is the usual end-of-file log clash, settled by keeping both entries.
   2. **#1628, #1629, #1631 and #1641 each add a Settings switch at the same spot in the settings file.** So do batch 1's #1642, #1643 and #1627. Seven switches in one place means seven small clashes. Keep every switch each time.

5. **Rules checks across the batch:**
   1. **Redo (U then REDO):** nothing new writes between a U and its REDO. #1629 adds to a match-and-save that already runs when a drawing loads. It does not add a new write. #1641 changes one command step (CD's mirror) inside its own transaction. The rest only read, or change what a window shows.
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. #1641 still opens the text for writing the normal way, so text on a locked layer is still refused by AutoCAD. #1614 makes CE stop reaching into the host drawing for an Xref row.
   3. **Switches:** the four new bug-fix switches (#1628, #1629, #1631, #1641) start ON, and an older settings file also gets ON. Each one has a test that pins this. #1573, #1588, #1599, #1614 and #1561 have no switch, which matches the carpark ("no switch").
   4. **CE_SHARED, installer, signed-update files:** none touched. Every file is under `Modules/Drainage`, `Modules/Manager` or the log.
   5. **Hard-coded engineering values:** none new. #1573 uses a 1 mm "no direction" distance. That is a pick tolerance, not an engineering value.
   6. **Hard blocks:** none new. #1195 is information only and never blocks.
   7. **C-63 list:** none of these bugs is already fixed in C-63. Only #1588 has a real code clash with it. #1644 clashes with the installed code in behaviour, not in text.

## One item per PR

### Class E, items 11 to 20

1. **#1628 BUG-1005 (Civil): CDRENUMBER counts the joining pipe when it picks the main line.** Head 3851df80.
   1. **Cause real?** Yes. To choose which branch continues the main-line numbers, CDRENUMBER scored each branch by the pipes above its first pit. The pipe joining that pit to the junction was left out. So a single 100 m pipe scored 0 m and lost to a 10 m + 10 m side run.
   2. **Fix does only that?** Yes. It is one line in the planner: the score is now the branch's longest run plus its joining pipe. P1 stays at the outlet, other numbering schemes are untouched, and the preview and the Apply question are unchanged. Settings switch `linking.renumberScoresJoiningPipe`, ON.
   3. **Test fails without it?** Yes. A RED commit (6807788e) holds the order test: P10, P11, P12, P13. On the old scoring it gives P10, P12, P13, P11.
   4. **Risk:** low. Only renumber plans on networks shaped like the bug change. Numbers on the drawing change only when the drafter presses Apply.
   5. **Verdict: MERGE. Train C-64.**

2. **#1629 BUG-1022 (Civil): a pit CE re-finds keeps its schedule override and its row position.** Head 01c299c8.
   1. **Cause real?** Yes. When a pit block comes back under a new handle (after a copy or re-insert), CE re-attaches the pit record by position and keeps its levels. But the typed Pit Schedule override rows and the saved row order are keyed on the old handle, and nothing moved them. So the schedule showed the drawing value and a "lost source pit" row.
   2. **Fix does only that?** Yes. At the moment CE re-attaches the pit, a small helper moves that pit's override rows and saved-order entries to the new handle. It never overwrites a place the new handle already holds. The key format matches the one the schedule builds, with the pit handle first and in capitals. Settings switch `linking.refoundPitKeepsScheduleOverrides`, ON.
   3. **Test fails without it?** Yes. A RED commit (e4104791) stubbed the helper, and the move tests fail on it. A source check also pins that the move happens before the handle is changed.
   4. **Risk:** low. The re-attach already saves the record when a drawing loads, so no new write path is added. One gap, not a reason to hold: if the inlet or outlet pipes also got new handles, the saved-order entry still carries the old pipe handles. That is a separate case.
   5. **Verdict: MERGE. Train C-64.** The drawing scan that finds the new block is AutoCAD-only and untested, as the log says.

3. **#1631 BUG-981 (Civil): a Pit Schedule built from two Xrefs keeps each drawing's pits as separate groups.** Head 2c481e58.
   1. **Cause real?** Yes. The schedule decides which rows belong under one pit by the pit's internal handle alone. Two copies of one job often have equal handles, so the second drawing's pit was read as one more inlet of the first. Its pit number, size, outlet and cover were blanked.
   2. **Fix does only that?** Yes. For Xref rows only, the source drawing becomes part of the group key. The open drawing's own pits and manual rows group exactly as before. The same key also drives the "first row of the group" check used by CSV export and placed text, so those are fixed as well. Settings switch `linking.scheduleXrefGroupsKeepDrawing`, ON.
   3. **Test fails without it?** Yes. The two-drawings test fails on the old key, and the same-drawing-inlets test passes before and after.
   4. **Risk:** low. The change is display only and writes nothing.
   5. **Verdict: MERGE. Train C-64.**

4. **#1573 BUG-1007 (Civil): the CDFALL arrow points the way you picked in a metre drawing.** Head 1d034492.
   1. **Cause real?** Yes. A direction pick closer than 1.0 drawing unit counted as "no direction" and the arrow pointed east. In a metre drawing that is 1 m, so a pick 0.5 m north gave an east arrow.
   2. **Fix does only that?** Yes. The "no direction" distance is now 1 mm in the drawing's own units, using the shared conversion. Millimetre and unitless drawings get exactly 1.0 as before.
   3. **Test fails without it?** Yes. The metre case (0.001) and the source check fail on the old line. There is no RED commit, but the log records it red first.
   4. **Risk:** none found. No switch, which matches the carpark.
   5. **Verdict: MERGE. Train C-64.**

5. **#1588 BUG-994 (Civil): the normal Inspector shows a pipe's drawn length through the drawing's units.** Head 8ae9c2f3.
   1. **Cause real?** Yes. The compact Inspector printed the raw length as "mm", so a 10 m pipe in a metre drawing read "10 mm".
   2. **Fix does only that?** Yes. It uses the same conversion the full-detail Inspector already uses (`RouteLengthMillimetres`).
   3. **Test fails without it?** Yes. The metre case reads 10 on the old code, and the source check pins the call.
   4. **Fixes needed (small):**
      1. **Rebase onto C-63.** C-63 (#1546, pipe type) replaced the same three lines. Keep C-63's three pipe-type lines and change only the length argument: `vm.ShowCivilPipeRecord(pipe, type, DrawnLengthText(line.Length, LinkService.InsunitsOf(line.Database)));`.
      2. **Move the new `DrawnLengthText` method and its comment above the existing comment of `RefreshInspector`.** At present it sits between that comment and its method, so `RefreshInspector` loses its description and the new method carries two.
   5. **Verdict: MERGE-WITH-FIXES. Train C-64 (after C-63 is in).**

6. **#1599 BUG-995 (Civil): Inspector health buttons zoom to the right pits when the UCS has been moved.** Head fc905d69.
   1. **Cause real?** Yes. An object's extents are world points, but the zoom routine treats its points as UCS points and converts them again. With a moved UCS, the view jumped to empty space. The Civil Hub already converts first.
   2. **Fix does only that?** Yes. The Inspector health buttons and the shared zoom-and-highlight service now convert the extents to UCS first, as the Civil Hub does. That service is also used by Pit Schedule row clicks and CEFIND, which get the same correction.
   3. **Test fails without it?** Yes, but only through source checks (2 of 3 fail on the base). No test checks the actual numbers.
   4. **Risk:** low. In a rotated UCS, converting only two opposite corners can crop the view slightly. The Civil Hub has the same limit. An optional follow-up is to convert all four corners.
   5. **Verdict: MERGE. Train C-64.**

7. **#1614 BUG-1009 (Civil): clicking an Xref row in the Pit Schedule no longer looks in the current drawing.** Head 26fcd655.
   1. **Cause real?** Yes. A row's pit handle comes from the Xref drawing, but a click looked it up in the host drawing.
   2. **Fix does only that?** Only half of it. A single click and Enter now print "Pit P3 is in an attached drawing (Xref), so CE cannot zoom to it from here." But a double-click calls `HighlightBestPipeForRow`. That looks up the row's inlet or outlet pipe handle in the host drawing, then highlights, selects and zooms to whatever it finds. On an Xref row that can be an unrelated host object, which is the same fault.
   3. **Test fails without it?** Yes. The "Xref row cannot be zoomed to" test fails on the base. Nothing covers the double-click.
   4. **Fixes needed (small):**
      1. **Guard the double-click the same way.** At the top of `PitScheduleViewModel.HighlightPipeFromRow`: if `row.IsExternalSource`, set the status "This pipe is in an attached drawing (Xref), so CE cannot highlight it from here." and return.
      2. **Add one test or source check for that guard.**
   5. **Verdict: MERGE-WITH-FIXES. Train C-64.**

8. **#1561 BUG-980 (Civil): CDCALC Pipe Flows refills the grade when a second pipe is picked.** Head 81e64f7d.
   1. **Cause real?** Yes. The fill-in only fills a box that is blank or at its default. After the first pick the grade box held 50, so the second pick left it there and the flow shown was about double.
   2. **Fix does only that?** Yes. CE now remembers what it filled itself. Before the next pick it puts back the default in any box that still holds CE's own value. A value the drafter typed is never touched. The grey note is set only when something was filled, so it names the pipe really used.
   3. **Test fails without it?** Yes. Two of the three new tests (second-pick grade, and second-pick roughness) fail on the base. The "typed value is kept" test passes before and after.
   4. **Risk:** low. If the second pipe has no grade CE can work out, the box now goes back to the default instead of keeping the first pipe's grade. That is correct, but the drafter will see the default.
   5. **Verdict: MERGE. Train C-64.**

9. **#1641 BUG-996 (Civil): mirrored CD text keeps its link to the pipe.** Head c0a03bc1.
   1. **Cause real?** Yes. After CD registers the text as the pipe's attachment, answering Yes to "mirror the text?" made a mirrored copy and erased the original. The pipe stayed linked to the erased text.
   2. **Fix does only that?** Yes. The same mirror is applied to the text itself, so it keeps its handle and its link. The old copy-and-erase stays for switch OFF. Settings switch `linking.cdMirrorKeepsPipeTextLink`, ON. It also stops CD's later text-segment step from working on an erased text.
   3. **Test fails without it?** Yes. A RED commit (ae2dc242) stubbed the switch. The source check pins "switch first, then mirror in place, then the old copy below".
   4. **Risk:** low. The mirrored result is the same geometry as before, because the copy was mirrored with the same matrix. Text on a locked layer is still refused by AutoCAD when CE opens it for writing, as before. One question is not proven without AutoCAD: when the pipe later moves, does CE's label follow keep the mirrored look or re-place the text normally?
   5. **Verdict: MERGE. Train C-64.**

10. **#1644 BUG-999 (Civil): CDRUNSOLVE stops saying every invert matches when it solved nothing.** Head 2fd85563.
    1. **Cause real?** It was. But the installed 3.0.72 already fixes it (#1617). The plan builder now adds "Nothing was changed. CE could not size these pipes because none of them has a design flow yet." (or "could not solve N pipe(s). The first was ...") when any pipe was not solved and nothing changes. CDRUNSOLVE prints that line and stops before the old sentence.
    2. **Fix does only that?** It adds a second helper with different words ("CE could not solve this run, so no levels were worked out...") after the installed check. It is reached only in corner cases: no pipes in the result at all, or "not all feasible" with every pipe feasible. That gives two messages for one outcome.
    3. **Test fails without it?** Its own tests do, but they test the duplicate helper, not the installed behaviour.
    4. **What to keep:** only the "no pipes in the result" case is new. If it is wanted, it is a two-line addition to the installed BUG-999 check in `ProposalApplyService.PlanBuilders.cs`.
    5. **Verdict: REJECT (superseded by #1617, already installed).** Closing it is Tim's call.

### Class F, items 1 to 5

11. **#1314 (Civil, Tidy labels): a label held as "no clear spot" is never slid aside later.** Head c2e297a6, 17 Oct.
    1. **What it is:** the triage line called this "CDTIDYLABELS whole stack with a ribbon button". It is not. That stack is already installed. This PR is a one-line fix from the Opus round 4 review.
    2. **Cause real?** Yes. With `linking.tidyRearrangeNeighbours` ON, a label that found no clear spot was listed as "left where it is". A later label could then slide it aside as a neighbour, so it was counted both as left and as moved. The installed code still has the gap.
    3. **Fix does only that?** Yes. The held label is marked as settled for the rest of the pass. With the switch OFF the result is identical, because only the neighbour step reads that mark.
    4. **Test fails without it?** The new test is built for exactly that case. I did not run it.
    5. **Risk:** none with the switch OFF, which is its default (a feature switch, not a bug-fix switch).
    6. **Verdict: MERGE. Train C-64 (small, harmless).**

12. **#1198 (Manager M05): a plain-words result for each update attempt, never "unknown".** Head d7ee14a6.
    1. **What it is:** a wording rule only. Nothing calls it, and the signed staging, activation and rollback code is untouched. An earlier Opus fix (19 Oct) is already in: "still on the old version and working" may only be used after the old install was checked, and the time shows UTC when Melbourne time cannot be found.
    2. **Sound?** Yes. Every result has words. An unknown result counts as "needs recovery", never as good. Melbourne daylight saving is handled.
    3. **Fixes needed (small):**
       1. **Align the repair advice with #1672 (BUG-918).** The "LeftBroken" and unknown cases say "Close AutoCAD and run the CE installer again." Batch 1 accepted "ask your CE administrator to finish the update" for colleagues. Pick one wording, then use it in both. Tim's call if unsure.
    4. **Verdict: MERGE-WITH-FIXES. Train: a later Manager plan train, not the pilot train.**

13. **#1200 (Manager M07): support information is never called complete with a part missing.** Head e28f54d6.
    1. **What it is:** a rule only, with nothing calling it. An earlier Opus fix (19 Oct) is already in: only an engineer closes an engineering matter, unknown evidence closes nothing, and a part listed twice counts once.
    2. **Sound?** Yes. "Complete" only when every listed part was collected. Nothing listed reads "not known". A successful install closes only a software matter, never a drawing or engineering one.
    3. **Verdict: MERGE. Train: a later Manager plan train.**

14. **#1195 (Manager M03): names the exact missing standard files, with one repair line.** Head 951ab206.
    1. **What it is:** a rule only, with nothing calling it. No Opus review before this one.
    2. **Sound?** Mostly. It shows only file names, never a path on someone's PC, and it never offers a substitute file. It is information only and never blocks.
    3. **Fixes needed (small):**
       1. **Grammar with one optional file.** It currently reads "...To restore it, run the CE installer again. They are not needed to run CE." Use "It is not needed" when one file is missing.
       2. **The same repair-advice wording as #1198** (see item 12).
    4. **Verdict: MERGE-WITH-FIXES. Train: a later Manager plan train.**

15. **#1190 (Civil, Checks "Explain"): one plain explanation per finding, citing the rule and source.** Head 2d44ab7d.
    1. **What it is:** a new `FindingExplanation` that turns a Checks finding into one paragraph. Nothing calls it.
    2. **Problem:** CE already has this. `RuleExplainer.Explain(finding)` (CDRULES Explain, since 5 Sep) gives one plain paragraph per finding with the value's source and the fix. A second explainer with different wording breaks design rule 1 (one code path per behaviour). The two would drift as soon as either is wired into a window.
    3. **What to keep:** two lines are better than what `RuleExplainer` does today. One lists the recorded sources by name. The other says "This value is not confirmed (Assumed)." Add those to `RuleExplainer` in a small new PR, with a test.
    4. **Verdict: REJECT as written.** Closing it is Tim's call.

## What I did NOT check

1. **No build and no test run.** Each "test fails without it" above comes from reading the test against the old code and from the RED commits, not from running them. Nothing was built for net48 or net10.
2. **Trial merges only against C-63 (28987b73) and against each other**, plus batch 1's #1642, #1643 and #1627. Not against every other open PR.
3. **Nothing was driven in AutoCAD.** These parts are AutoCAD-only and unproven: the block re-find in #1629, the mirror in #1641, the zoom views in #1599, and the arrow in #1573.
4. **The Settings window rows** for the four new switches are Codex's and were not looked at.
5. **#1314's test** was read, not traced through every step of the placement rule.
6. **Carpark status** was read from each entry's Status line (all OPEN). I did not edit the carpark.
