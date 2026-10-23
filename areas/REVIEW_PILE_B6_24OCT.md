# Opus review of the PR pile, batch 6 (class E, positions 55 to 66), Sat 24 Oct 2026

Headless job, desk plan/03, Team (Opus 5.5). Started 05:35 Melbourne time. Read only: no build, no test run, no AutoCAD, nothing pushed to a PR branch, nothing merged, closed or labelled. My own copy of the repo was the bare `C:\ce-tr\b6.git` (borrows objects from the triage copy; the local clone was not touched). Three Opus reviewers each took one group; I re-checked their key claims in the code myself (noted per item).

Input: `areas/PR_PILE_TRIAGE_2026-10-24.md`, class E, items 55 to 66: #1341, #1383, #1384, #1385, #1386, #1419, #1423, #1457, #1460, #1464, #1521, #1529.

**Skipped: #1423** (BUG-787), already reviewed in `REVIEW_PILE_B3_24OCT.md` item 10 (HOLD, rebuild on live code).

Compared against: installed Civil 3.0.72 / Manager 1.1.72 = `claude/rel-20261023m` f7f7d551; installed Structural 1.0.122 = `claude/rel-20261023s` e6d597c0; planned C-63 = `claude/rel-20261024m` 28987b73; S-43 = PRs #1695 to #1699. All 11 PRs are open drafts on GitHub and their heads match what was reviewed (checked 05:40).

## ANSWER FIRST

1. **Counts (11 reviewed, 1 skipped):** 6 MERGE, 2 MERGE-WITH-FIXES, 2 HOLD, 1 REJECT.
   1. **MERGE:** #1341 (Civil, C-64); #1385, #1386, #1529, #1460, #1464 (Structural, S-44).
   2. **MERGE-WITH-FIXES:** #1419 (Civil CDREBUILD, C-64), #1457 (Structural Reset Defaults, S-44).
   3. **HOLD:** #1383 (CEHATCH card pictures: needs re-cutting on the installed code), #1521 (green DP label double-click: the code is fine, but its bug entry says a command card must be approved first, and none exists).
   4. **REJECT:** #1384 (SBEAM flange-line switch). Tim's 18 Oct CEMEMBER design keeps the flange lines, so this switch is not wanted. Leave it open (D6).

2. **Top faults:**
   1. **#1457 Reset Defaults still wipes 28 groups of settings that have no page in the window.** That includes the wind-region rules, the lintel table and the CEMEMBER layer and break-line sizes. That is the same kind of loss as BUG-826 itself; the dated backup copy only softens it. Small fix: keep every group the window does not show.
   2. **#1383 carries an old copy of the BUG-748 dots fix.** The installed Structural already fixed BUG-748 another way (switch `HatchDensityFollowsPaper`, ON). Merging #1383 would add a second switch for the same thing and would not compile (the same method declared twice). Seven files clash.
   3. **#1419 can point a kept pit at somebody else's pipe** in an unusual case (a partly erased original, or a handle number shared with another job's drawing). One small fix and one test.
   4. **Earlier MERGE verdicts for #1383 and #1384 (entries 1193, 1194, 1228) no longer hold:** the code moved on (S-41) and Tim decided the flange-line question.

3. **Safe to merge today:** #1341 (C-64); #1385, #1529, #1460, #1464 (S-44). **#1386** also, but it changes a window, so it needs a Codex look in AutoCAD before it counts as accepted. Every one of these clashes only in `REGRESSION_LOG.md` (keep both) or not at all.

4. **Nothing here touches CE_SHARED, the installer or signed-update files.** No new hard block (#1464's "this box is not a number" message stops only Save; Cancel and the close button still work). No PR writes to the drawing or a system variable on an automatic path between a U and its REDO. The one bug-fix switch that is new (#1419) starts ON; #1383's starts ON on its current head. No hard-coded engineering value (the 50 mm in #1341 is a pick distance, not a design value).

5. **C-63 and S-43:** no PR here fixes a bug already fixed in C-63. Trial merges onto C-63 and S-43 show only `REGRESSION_LOG.md` clashes, except #1419 (`UserSettings.cs`, two neighbouring additions: keep both).

---

## Per PR

1. **#1341 @ 4771157c (BUG-710, Civil CDFALLSUGGEST on a metre drawing): MERGE, train C-64.**
   1. **Cause real (checked myself):** installed `Rules/FallArrowGeometry.cs` line 112 calls the raw drawing distance "millimetres" and line 188 divides by 1000. In a metre drawing a 20 m run reads as 0.02 m and gives "1:0.1". The spot-level search (50) is also used as drawing units, so it reaches 50 m in a metre drawing.
   2. **Fix does only that:** converts both with the existing drawing-units helpers. A Unitless drawing keeps today's millimetre assumption. The fix round cures entry 1187's MEDIUM (the 50 m search).
   3. **Test fails without it:** yes (the metre-drawing grade test and the search-distance test are on new code).
   4. **LOW:** a Unitless drawing really drawn in metres still gives 1:0.1, as today.
   5. **Conflicts:** `REGRESSION_LOG.md` only, on installed and C-63.
   6. **AutoCAD check:** on a copy of a metre drawing, a CDSL spot at 12.30 and a grated pit 20 m away at cover 12.10. CDFALLSUGGEST, pick the spot: it reads 12.30 and suggests 1:100. Pick 1 m away: it asks for a level. A millimetre drawing gives the same as before.

2. **#1383 @ 4a5db9f7 (BUG-751, CEHATCH cards show words instead of pictures; carries #1382's BUG-748): HOLD, re-cut as a BUG-751-only PR, then S-44.**
   1. **Cause real (checked myself):** installed `HatchPreviewGeometry.cs` line 273 still returns "No preview: the drawing scale is not valid." at DIMSCALE 1, so the Load-bearing wall, Earth and Concrete cards show words. The Waffle half is already fixed in the installed code.
   2. **Why HOLD:** its BUG-748 part is superseded. Installed #1498 (S-41) already keeps hatch density the same on paper, with switch `HatchDensityFollowsPaper` ON (`UserSettings.cs` line 1930, checked). #1383 adds a second switch for the same job, OFF, and a method with the same signature as an installed one, so it would not compile. Trial merge: 7 files clash; even the BUG-751 part alone clashes in 5.
   3. **The BUG-751 logic itself is sound:** pictures only, nothing written to the drawing, switch `HatchPreviewPictureAtAnyScale` starts ON, tests would fail on the installed code.
   4. **For the re-cut:** drop the dots switch, its helpers and its test; add the picture argument after the installed one; rename the tests' `dotsPaperSpacing:` to `paperDensity:`; fix the swapped notes in `DrawingScaleSetting.cs` (entry 1228 NIT 1).
   5. **AutoCAD check after the re-cut:** fresh drawing at DIMSCALE 1, CEHATCH: every card shows its pattern with a small note at the bottom. DIMSCALE 20: cards as today, no note. Placing a hatch at DIMSCALE 1 is still refused, as today.

3. **#1384 @ 3d35f602 (BUG-750, SBEAM side elevation inner flange lines switch): REJECT, superseded by Tim's decision.**
   1. `decisions/2026-10-18_CEMEMBER_DESIGN.md` section D item 1 (checked): #1384 "stays OPEN and is NOT merged". Tim: "we keep flange lines on that layer and keep them".
   2. It also carries the whole #1383 stack and its 7 clashes. Leave it open (D6); Tim may close it.

4. **#1385 @ cc6a5c58 (BUG-755, RCBEAM Type 2 and Type 6 pictures run off the top of their box): MERGE, S-44.**
   1. **Cause real:** installed `RCBeamPickerDialog.xaml.cs` lines 276 to 277 put Type 2's top 4.5 px above the box; line 333 puts Type 6's 12.5 px above. File unchanged since S-38.
   2. **Fix:** only those two pictures move down to the 8 px margin. The test measures all nine pictures against all four edges.
   3. **Conflicts:** `REGRESSION_LOG.md` only. Entry 1195 still holds.
   4. **AutoCAD check:** RCBEAM, Beam Types tab: Edge Upstand and Upturn + Rebate sit fully inside their boxes with a small gap at the top; the other seven look the same. A window, so a Codex look is needed for acceptance.

5. **#1386 @ e31f4c63 (BUG-752, CESETTINGS long folder paths cut off): MERGE, S-44, Codex look needed.**
   1. **Cause real:** installed `CeSettingsDialog.xaml` (unchanged since S-38) has no wrapping on the path boxes.
   2. **Fix:** nine path boxes wrap. None accepts Enter, so a wrap can never put a line break into a saved path.
   3. **Conflicts:** `REGRESSION_LOG.md` only. S-43's #1696 resizes this window, so do the Codex look on S-44 with #1696 in.
   4. **AutoCAD check:** CESETTINGS, put a 120-character folder in Schedules / Markup > Workbook files; open System > Installation and Markup service: long paths wrap onto a second line, nothing cut off, light and dark.

6. **#1419 @ 6199df19 (BUG-803, CDREBUILD treats an original pit as a copy when its stored handle is out of date): MERGE-WITH-FIXES, C-64, short Opus re-read after the fix.**
   1. **Cause real:** installed `LinkService.CloneRepair.cs` treats every pit or pipe whose stored handle differs from its own as a copy: new key, pipe list cleared. After WBLOCK, INSERT and EXPLODE, the original network loses its IDs.
   2. **Entry 1260's HIGH is cured:** an object keeps its identity only when its old handle names nothing, no other object carries that handle, and its key is unique. Two INSERT + EXPLODEs now give copies, never two pits sharing one ID (tested).
   3. **Entry 1260's MEDIUM is mostly cured:** kept objects' pipe lists and owner handles go through an old-to-new map.
   4. **NEW MEDIUM (checked myself, `StaleCloneIdentityRule.cs` lines 69 to 77):** the map lists every unchanged object's own handle as itself. If a kept pit lists old pipe handle X, and X happens to be a different live pipe here (partly erased original, or a handle shared with another job's drawing), the kept pit is pointed at that unrelated pipe instead of being cleared. **Fix:** leave out of the map any handle that is the stored handle of an object judged a copy; add one test.
   5. **LOW:** the spine-key count skips objects with a blank stored handle; count before the skip.
   6. **Other risks:** writes only inside CDREBUILD (one U undoes it); locked-layer pits fail and are counted as errors, never unlocked; switch `linking.rebuildKeepsOnlyCarrierIdentity` starts ON. Tests cover the rule, not the whole CDREBUILD run.
   7. **Conflicts:** `Models/UserSettings.cs` (two neighbouring additions, keep both and keep the opening comment line) and `REGRESSION_LOG.md`, on both installed and C-63.
   8. **AutoCAD check:** on a copy, WBLOCK pits P1 to P3 to a new file, INSERT and EXPLODE in an empty drawing, CDREBUILD: pits keep P1 to P3 and still list their pipes. INSERT + EXPLODE again, CDREBUILD: both sets are copies with new IDs, no two pits share an ID. One U undoes it.

7. **#1457 @ 3feb0668 (BUG-826, Structural Reset Defaults wipes the whole settings file): MERGE-WITH-FIXES, S-44.**
   1. **Cause real:** installed `CeSettingsDialog.xaml.cs` lines 459 to 462: one click, no question, a fresh settings file.
   2. **Earlier asks cured:** entry 1302 (keeps the six Excel lists the window does not show) and entry 1309 (the two existing window tests no longer hang; a question-box test hook).
   3. **NEW MEDIUM (checked myself):** the question says "settings shown in this window", but `SettingsResetPlanner.BuildReset` keeps only 6 hidden groups and resets 28 others that no page shows, including CeMember, WindClass (region, terrain and topography rules), LintelTable, Layouts and FoundationPlan. The window does not read CeMember, WindClass or LintelTable at all (0 references). **Fix:** start from a copy of the current settings and reset only the 18 groups the window shows (plus the one Issue preview tick box); add a guard test that every group the window does not read comes through unchanged. Also: the bearer span table and Python path ARE shown in the window but are kept; either reset them or say in the question and the log that they are kept.
   4. **LOW:** dated `.before-reset-` copies pile up with no limit.
   5. **Conflicts:** `REGRESSION_LOG.md` only, on installed, with #1460 and #1464 stacked, and with each S-43 PR.
   6. **AutoCAD check:** CESETTINGS, change the Beam offset, Reset Defaults, pick No: nothing changes. Again, pick Yes: offset back to standard, SBEAM favourites kept, a `CS_Settings.before-reset-<date>.json` beside the settings file. After the fix: a CEMEMBER break-line size you changed survives.

8. **#1460 @ c5e28d8f (BUG-840, a second AutoCAD's routine save puts back an old value): MERGE, S-44.**
   1. **Cause real:** installed `SettingsService.cs` lines 122 to 137 and 919 to 931: every routine save writes the whole in-memory settings over the file.
   2. **Fix:** a routine save now writes only what this AutoCAD changed since it last read or wrote the file, compared again under the save lock. A deliberate Save still writes everything. Unreadable text falls back to today's behaviour.
   3. **Test fails without it:** six cases on new code plus a source guard on the real save path.
   4. **LOW (entry 1303, still true):** the second AutoCAD keeps its old value in memory until restart, and a deliberate Save there still writes it. Not worse than today.
   5. **Conflicts:** `REGRESSION_LOG.md` only.
   6. **AutoCAD check:** two AutoCADs. In the first, change the Beam offset and Save. In the second (opened earlier), place an SBEAM. Close both, reopen: the changed offset is still there.

9. **#1464 @ 5cd70fe3 (BUG-841, Structural Settings ignores a mistyped number and closes as if saved): MERGE, S-44.**
   1. **Cause real:** installed `CeSettingsDialog.xaml.cs` line 242 has no check; line 257 silently skips a bad number; the window closes as if saved.
   2. **Fix:** Save checks the 57 number boxes first; a bad one gets a message naming the box as the window labels it, and its page comes forward. Blank boxes still keep the old value. Entry 1326's wording fix is in.
   3. **Not a new hard block:** only Save waits; Cancel, the close button and Reset still work.
   4. **LOW:** boxes that quietly lift a low number (backup copies 0 becomes 1) are untouched, so BUG-841 stays partly open for that.
   5. **Conflicts:** `REGRESSION_LOG.md` only (also with #1696, which edits the same file in a different place).
   6. **AutoCAD check:** CESETTINGS, Beam page, type 1,200 in Side 1 offset (North/West), Save: a message names that box and the window stays open. Type 1O0 (letter O) in "Apply confidence (0-1)" from another page: that page comes forward. Fix it and Save: it closes and keeps the value. Cancel still closes with a bad value in a box. It is a window message: Codex look needed.

10. **#1521 @ 2273c237 (BUG-860, double-click on the green DP label opens AutoCAD's text editor, not the downpipe's Edit source window): HOLD, command card owed; code is MERGE-ready for C-64.**
    1. **Not BUG-859 round 2:** #1520 and BUG-859's round 2 are already installed (checked: 9daa061d is in 3.0.72). This is the label only.
    2. **Cause real:** the label is plain text with no CE owner note, so it goes to AutoCAD's text editor before any downpipe test.
    3. **Fix:** only for a real double-click on TEXTEDIT/MTEDIT/DDEDIT, under the existing switch `doubleClick.sourceEditWindow` (ON). It opens Edit source only when exactly one downpipe's own label record names this text; otherwise AutoCAD's editor as before. Read-only lookup. Clean merge onto installed and C-63.
    4. **Why HOLD:** the carpark entry for BUG-860 says "Needs a command card before code (review gate)" and its status is "needs the command card" (checked). No card or Tim approval was found in `C:\CE_PLAN`. Per the review gate in AGENTS.md this stops at planning until the card is approved.
    5. **LOWs:** in a drawing with no CE pits or pipes (structural-only), the "no CE data" short cut is now skipped for every double-clicked text; also require at least one CE downpipe there. A typed TEXTEDIT within 1.5 s of a double-click counts as a double-click. Whether the text editor really stops when cancelled depends on the BUG-166 fix, installed but not yet robot- or Codex-tested.
    6. **AutoCAD check (after the card):** on a copy, place DP1 with its green label, double-click the label: DP1's Edit source window opens; Esc leaves no stray TEXTEDIT prompt. Double-click ordinary text: AutoCAD's editor. Copy DP1 so two downpipes name one label: AutoCAD's editor.

11. **#1529 @ 7bf04976 (BUG-864, CEMEMBER and SBEAM re-style an existing 18HIDDEN or 9HIDDEN2 layer): MERGE, S-44.**
    1. **Cause real (checked myself):** installed `StructuralDetailService.cs` lines 2005 to 2017 open an existing layer for write and set its linetype to HIDDEN or HIDDEN2, re-styling every line already on it.
    2. **Not superseded:** installed 871ad9716 (S-41) protects only layers an office has renamed. CE's own names still go through this code.
    3. **Fix:** leave any existing layer exactly as it is; only a missing layer is created. Removes a write, so better for locked layers and Redo. No switch needed. Tests are source guards that fail on the installed code.
    4. **Side effect (logged):** an 18HIDDEN that CE once made Continuous is no longer upgraded.
    5. **Conflicts:** none at all.
    6. **AutoCAD check:** on a copy, make 18HIDDEN with linetype Continuous and a line on it; CEMEMBER 310UB32 side elevation: 18HIDDEN stays Continuous. Same with 9HIDDEN2 and a "beyond" section, and with SBEAM. In a drawing without them, both are created dashed.

---

## Merge order

1. **S-44 (onto `claude/rel-20261023s` or S-43):** #1529, #1385, #1386, #1460, #1457 (after its fix), #1464. Keep both at every `REGRESSION_LOG.md` clash. #1383 only after its re-cut and a re-review.
2. **C-64 (onto C-63):** #1341, then #1419 (after its fix and a short re-read). #1521 only once the BUG-860 card is approved.

## What I did NOT check

1. **Nothing was built or run.** No net48 or net10 compile, no test. "Fails without the fix" is from reading the tests against the installed code. Trial merges used `git merge-tree` only; merged code was not compiled.
2. **No AutoCAD.** No window, card picture, message box or drawing was seen.
3. **#1419:** I did not trace whether CDREBUILD's later relink step repairs or worsens the wrong-pipe case.
4. **#1457:** I did not check whether the 18 shown groups also hold values with no box (those would also be reset).
5. **#1464:** I did not confirm every one of the 57 boxes finds its window label (the builder's test claims it does).
6. **#1529:** other places that change an existing layer's linetype (`LayerService.cs`, `BracingService.cs`, `DimensionCommands.cs`) were not checked.
7. **#1521:** I did not confirm in AutoCAD that a double-click on text leaves the item selected.
8. **Trial merges onto S-43** were done for the Settings PRs; for #1383 to #1386 and #1529 only the file lists were compared.
9. I posted no PR comments and closed, merged or labelled nothing.
