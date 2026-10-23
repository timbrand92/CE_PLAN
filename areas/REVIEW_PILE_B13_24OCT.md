# Opus review of the best unreviewed PRs, batch 13 (Sat 24 Oct 2026)

Headless job, desk plan/03, Team (Opus), about 06:55 to 07:15 Melbourne time. Input: `PR_PILE_TRIAGE_2026-10-24.md`, **class F (plan work), positions 13 to 24** of the full class F list: #1021, #1023, #1025, #1028, #1030, #1031, #1033, #1035, #1036, #1037, #1039, #1040. Read-only: no code changed, nothing built, merged, closed, pushed to a PR branch or deployed. AutoCAD and Codex not started. One read-only worktree, `C:\ce-tr\b13`, at the C-63 train tip (removed at the end).

## ANSWER FIRST

1. **Counts (12 PRs, all Civil, all opened 9 Oct on base `claude/rel-20261009r`):**
   1. **MERGE 3:** #1021, #1025, #1037.
   2. **MERGE-WITH-FIXES 5:** #1028, #1033, #1036, #1039, #1040.
   3. **HOLD 2:** #1030, #1035.
   4. **REJECT 2:** #1023 (already installed another way), #1031 (replaced by #1036).
   5. **#1037 and #1039 were already reviewed in batch 3.** I re-checked them against C-63 and the batch 3 verdicts stand.

2. **None of the twelve belongs in the 9 Nov pilot.** They are all plan work. Tim's ruling A (17 Oct, pause on new items) and ruling F (until 9 Nov, only bug fixes and testing) put them on a later plan train. Every one is behind a switch that starts OFF or has no caller, so leaving them out costs the pilot nothing.

3. **Top faults:**
   1. **#1030 would size an old SPS from whatever the drafter last typed in the PIT window.** The "Settings SPS radius" it reads is not an office figure. It is the PIT window's remembered last value (`PitViewModel.SaveSettings` writes it). Two PCs would put the same pipe end on different walls.
   2. **#1023 and #1028 build a second switch for something already installed.** BUG-544 items 21 and 30 (installed in Civil 3.0.72) already do the same two jobs. Two switches for one behaviour breaks design rule 1.
   3. **The installed BUG-544 item 30 has a hidden fault that #1028 had already found.** If someone turns it ON, a 900 mm pipe stops counting as standard, because the Settings size list stops at 750. The colour rule could then overwrite its size. The switch is OFF today, so no drawing is affected yet.
   4. **#1035 saves into the drawing with Undo switched off for the whole drawing.** The only other place Civil does this switches Undo off for one object, not the whole drawing. Nothing calls #1035 yet, so it cannot be judged until it is wired and a U then REDO is proved in AutoCAD.
   5. **Two switches start OFF although Tim already answered.** #1033: Tim ruled G7 on 17 Oct: "minimum pipe cover default 300 mm. YES (Settings value; Set C Q5 closed)". #1040: INT-075 says the "Name (COMMAND)" labels default ON (the planning chat reached the same reading on 17 Oct, GAP 3-9).

4. **Safe to merge today, on a plan train after C-64 (not C-63, not the pilot):** #1021, #1025, #1037. Then #1028, #1033, #1036, #1039 and #1040 once their small fixes are pushed. Each one clashes with C-63 in the change log only (keep both entries), except where item 6 below says otherwise.

5. **Risk checks, all twelve:**
   1. **Redo (U then REDO):** none adds an Idle, command-end or object-change hook. Only #1035 adds a new drawing write (see fault 4). #1036 writes through Edit Pit's own Save (one Undo).
   2. **Locked layers, Xrefs, REFEDIT:** only #1036 touches drawing objects. It runs the normal CE safety check first. A picked Xref is not a pit block, so it is refused. The change itself is Edit Pit's own Save.
   3. **Switches:** none of these is a bug fix, so starting OFF is allowed (Tim's rulings B, 17 Oct: a tool goes ON once Codex passes it). The exceptions are #1033 and #1040, where Tim has already given the answer (fault 5).
   4. **CE_SHARED, installer, signed-update files:** none touched, so nothing is held for that.
   5. **Hard-coded engineering values:** most of these PRs move a number onto Settings, which is the right direction. #1030 points at the wrong Settings value (fault 1). #1036's 450 mm fallback applies only if the Settings value is broken, and the drafter checks it in Edit Pit before Save.
   6. **New hard blocks:** none.
   7. **C-63 list (`claude/rel-20261024m`, 28987b73):** none of the twelve is in C-63, and none clashes with a C-63 PR's code. The merge test found these real code clashes, all with older installed code: #1023 (Detention view model, the BUG-544 item 21 duplicate), #1028 (X-Civil size test, BUG-544 item 30), #1031 (a cross-module guard test) and a side-by-side Settings insert in #1021, #1025 and #1028 (keep both).

6. **Two things for the desk (I did not edit the carpark):**
   1. **Raise a bug against BUG-544 item 30:** when ON, the Settings list must be the Settings sizes **plus** the import's own sizes, and the X-Civil "neighbour size" guess (`SnapToStandardDiameter`) must use the same list. #1028 already has the code for both. Fixing #1028 as below closes it.
   2. **`QUESTIONS_FOR_MONDAY.md` item 3 still lists "Set C Q5" (minimum cover) as open.** G7 closed it on 17 Oct. Take it off the list.

---

## Each PR

1. **#1021 Set C item 2 (Civil): the long section uses the Settings roughness table.** Head 78c629f2, +100/-3, 4 files. **MERGE, later plan train.**
   1. **Plan item:** Set C item 2 (TIM_SET_C_QUESTIONS, 9 Oct). **Completes the whole item**, behind switch `pipeSpeed.longSectionUsesSettingsRoughness` (OFF). Not 9 Nov.
   2. **Is the cause real?** Yes. On C-63, `ProfileRouteEvidenceCaptureService.ComputeEstablishedVelocity` (line 802) still has its own list: concrete 0.013, steel 0.012, everything else 0.010. So cast iron reads 0.010 on the long section and 0.012 in CDRULES. The long section's speed column calls this (`LongitudinalSectionViewModel` line 2044).
   3. **Does the fix do only that?** Yes. ON uses `DesignValidationService.GetManningsN`, the CDRULES table. OFF is today's list exactly.
   4. **Test that fails without it:** yes, 2 of 6 failed before the change (cast iron 0.012, GRP).
   5. **Note:** with the switch ON, a pipe with no material gets the Settings "not recognised" roughness, not 0.010. That matches CDRULES, which is the point.
   6. **Switch OFF is right for now.** Set C items 1 to 4, 6 and 7 still wait for Tim to confirm that INT-078 ("the rest I am happy with") covers them (build queue 10 Oct, item 21).

2. **#1023 Set C item 3 (Civil): the Detention Design tab opens at the Settings before-development C.** Head 44b31e34, +92/-0. **REJECT (already installed another way).**
   1. **Plan item:** Set C item 3. Already **completed** in the installed code by BUG-544 item 21 (switch `detention.designTabStartsAtSettingsPreDevC`, in Civil 3.0.72, f7f7d551).
   2. **Is the cause real?** It was on 9 Oct. The installed code now does exactly this in the same constructor. That is why the merge test clashes on the same lines.
   3. **Why reject:** merging would add a second switch (`designTabStartsFromSettings`) for the same behaviour, which breaks design rule 1. Its only extra is a not-a-number guard, and that case is already refused by the installed `> 0.0` test. Closing it is Tim's call. Nothing is lost.

3. **#1025 Set C item 4 (Civil): the CDCALC Pipe flow tab opens at the Settings uPVC roughness.** Head 5e969461, +80/-2. **MERGE, later plan train.**
   1. **Plan item:** Set C item 4. **Completes the whole item**, switch `pipeSpeed.pipeFlowTabStartsFromSettings` (OFF). Not 9 Nov.
   2. **Is the cause real?** Yes. On C-63, `PipeFlowCalcViewModel` still opens at the built-in 0.013.
   3. **Does the fix do only that?** Yes. It also changes the "has the drafter touched it?" test, so that picking a pipe still fills that pipe's roughness when the tab opened at 0.010. Without this, picking a concrete pipe would leave 0.010 on the tab.
   4. **Test that fails without it:** yes, 1 of 3 (ON opens at 0.010). **Optional extra test (not blocking):** none of the tests covers the change in point 3. One test would do it: switch ON, pick a concrete pipe, the tab shows 0.013.

4. **#1028 Set C item 6 (Civil): X-Civil import counts 675 as a standard size.** Head 8e7f35f0, +117/-2. **MERGE-WITH-FIXES, later plan train.**
   1. **Plan item:** Set C item 6. The plain switch is already installed as BUG-544 item 30. #1028 **completes the item properly**, because the installed version is incomplete (point 3).
   2. **Is the cause real?** Yes. The import's own list (100 to 900) has no 675.
   3. **What #1028 adds that the installed code lacks (checked on C-63):**
      1. **The installed item 30 reads the Settings list only.** The shipped Settings list stops at 750 (`UserSettings` line 1959). With item 30 ON, a 900 mm pipe would count as "not standard" and the colour rule could overwrite its size. #1028 uses the Settings list **plus** the import's own sizes.
      2. **The X-Civil neighbour-size guess** (`SnapToStandardDiameter`, used when a pipe's size is taken from its neighbours) still has its own list. A run of 675 pipes snaps to 600 or 750. #1028 makes it use the same list.
   4. **The fix (small):**
      1. Delete the new switch `xcivilImport.useSettingsPipeSizeList`. Have `StandardPipeSizes()` read the installed switch `xcivilImport.pipeSizesFollowSettingsLadder`.
      2. Settle the clash in `IsStandardPipeDiameter` by replacing item 30's body with the loop over `StandardPipeSizes()`.
      3. Point the tests at the installed switch. That leaves one switch, one list and both repairs.
   5. **Test that fails without it:** yes, 2 of 4 failed with the change switched off. After the fix, add one test: switch ON, 900 is still standard. It fails on today's installed item 30.

5. **#1030 Set C item 7 (Civil): an older SPS with no recorded radius uses the Settings SPS radius.** Head a97295f7, +111/-1. **HOLD.**
   1. **Plan item:** Set C item 7. **Part only.** It changes one place, the pipe-end wall (`PipeAttachmentPlacementMath.SpsWall`).
   2. **Is the cause real?** Yes. On C-63, line 65 still sets 700 when the record has no radius.
   3. **Fault (why HOLD):** `PitSettings.SpsRadius` is not an office figure. It is the PIT window's "remember last values" field: `PitViewModel.SaveSettings` writes whatever the drafter last typed (line 1237). With the switch ON, an old SPS would take its wall from that last value. Two PCs could put the same pipe end on different walls, and that is exactly the kind of number that must live on the Settings page.
   4. **What would unhold it:** a separate Settings value, for example "Older SPS with no recorded radius (mm)", default 900, shown on the Settings page. Read that instead.
   5. **Small extra point:** `PitData.SpsRadius` defaults to 900 in code, so a CE pit record read back without a radius field probably gets 900, not 700. If so, 700 is used only for a record that stores 0 (I did not trace every reader). The card should say how often that really happens before anyone builds more.

6. **#1031 DETENTION-PIT-ANNOTATE slices 1 and 2 (Civil).** Head 6696406f, +365/-1. **REJECT (replaced by #1036).**
   1. **Plan item:** DETENTION-PIT-ANNOTATE (card 25 Sep). #1036 does the same slices plus slice 3. Both create `Commands/PitDetentionCommand.cs` and the same Settings switch, so they cannot both merge.
   2. **#1031 also clashes with a cross-module guard test on C-63.** Closing it is Tim's call. Nothing is lost.

7. **#1033 Set C item 5 (Civil): the sizing tools start from the Settings minimum cover.** Head ea16bb07, +100/-1. **MERGE-WITH-FIXES, later plan train.**
   1. **Plan item:** Set C item 5. **Completes the item** for the sizing standards. CDRUNSOLVE and CDDESIGN already use the rulebook cover.
   2. **Is the cause real?** Yes. On C-63, `SettingsSizingStandards` line 97 still uses the built-in 600 mm (`PipeSizingModels.DefaultMinCoverMm`). The units are right: `MinimumCoverDepth` is in mm (300).
   3. **Fix 1, switch default:** Tim answered this one. G7, 17 Oct: "minimum pipe cover default 300 mm. YES (Settings value; Set C Q5 closed)". So `sizingStandardsUseSettingsCover` should start ON. Update the two pinned tests that expect 600 (`CL5OneSizingStandardsTests`, `MaterialVelocityLimitsTests`). Under rulings B, flip it ON in the same train as soon as Codex passes one CDEDIT-strip check.
   4. **Fix 2, one rule:** C-63 already has the rule "a zero, negative or broken office cover uses the fallback" in `MinimumCoverForChecks.Choose` (BUG-521, BUG-809). That file did not exist on #1033's base. Call `MinimumCoverForChecks.Choose(false, null, office.MinimumCoverDepth)` instead of a second copy of the same test (design rule 1).
   5. **Test that fails without it:** yes (the ON tests).
   6. **What a drafter would see once ON:** a shallow pipe that used to say "cover too small" at 450 mm of cover is now accepted against 300. That is Tim's ruled number.

8. **#1035 REPAIR-DECIDE-LATER slices 2 to 4, engine only (Civil).** Head 6bc3b1da, +575/-0. **HOLD until the wiring PR, reviewed together with it.**
   1. **Plan item:** REPAIR-DECIDE-LATER (card 25 Sep). **Part only:** this is the list engine and its drawing storage. The tab (Codex's window) and keeping parked items out of Preview and Apply are not built. Nothing calls it.
   2. **Is the claim real?** Yes. Today only a count of set-aside rows reaches the repair window. The new reader lists them. Slice 1 (the "everyone is an administrator" fallback) is closed on C-63: `CeAdminPolicyService` line 125 sets `isAdmin = false` when there is no policy file.
   3. **Test that fails without it:** yes, 14 of 14 against a do-nothing stub. The tests found and fixed a real date-reading fault.
   4. **Why HOLD (redo safety):** `WriteDecideLaterBook` turns Undo recording off for the **whole drawing**, then writes into the drawing's main dictionary, which every CE record shares. The one other place Civil does this (`LayerService` line 1087) turns it off for a single draw-order object only. Writing to a shared dictionary with Undo off can leave AutoCAD's Undo out of step when a later U goes back past an earlier CE change. The card's choice (no Undo step for a park) is fine, but this way of doing it must be proved in AutoCAD: park one item, U back past an earlier CE edit, REDO, save and reopen.
   5. **Privacy, for the wiring PR:** "ParkedBy", "ResolvedBy" and "DeletedBy" are saved inside the drawing. The caller must pass `DrawingPersonName.Current()` (the coded name, as #1638 does), never the Windows login.

9. **#1036 DETENTION-PIT-ANNOTATE slices 1 to 3 (Civil): hidden CDPITDETENTION makes an ordinary pit a detention pit.** Head af976e0a, +452/-0, 7 files. **MERGE-WITH-FIXES, later plan train.**
   1. **Plan item:** DETENTION-PIT-ANNOTATE. **Completes all three card slices in code** (hidden, switch `pit.detentionAnnotateCommand` OFF). Not yet proved in AutoCAD.
   2. **Is the claim real?** Yes. No such command exists on C-63. The reader types it relies on ("DETENTION PIT") are the ones the Pit Schedule and CDCALC count.
   3. **Does it do only that?** Yes. It picks a pit and works out a footprint that is never 0. It names the pipes that are not typed Detention and never retypes one. It then opens Edit Pit pre-filled. Edit Pit's own Save is the only write (one Undo), and Cancel changes nothing. The safety check runs first. An Xref is refused because it is not a pit block.
   4. **Fix 1 (small, real):** CDPITDETENTION sets two one-time notes (`PitEditCommand.PreselectedPitId`, `PendingDetentionConversion`) and then calls Edit Pit. If Edit Pit stops at its own safety check before it reads them, both stay set. The next plain PITEDIT would then open that same pit already turned into a detention pit. **Fix:** wrap the `EditPit()` call in `try { ... } finally { PitEditCommand.PendingDetentionConversion = null; PitEditCommand.PreselectedPitId = ObjectId.Null; }`.
   5. **Fix 2 (wording):** the summary says the sizes came "(from Settings)". They are really the detention sizes last typed in the PIT window (`PitViewModel` lines 1252 to 1254). **Fix:** "(the sizes last used in the PIT window)". The drafter checks them in Edit Pit before Save, so this is wording, not a hard-coded value.
   6. **Tests:** 7 of 12 failed against a stub. The 5 source checks were written after the wiring.

10. **#1037 K-REQ-01 slices 2 and 3, plan half (Civil).** Head 0cd5365a. **MERGE, later plan train (batch 3 verdict, still true).**
    1. **Plan item:** K-REQ-01 (card 25 Sep). **Part only:** it works out which Pit Schedule cells CDPROFILE Apply would write. The real write still waits for Tim's answer to card OPEN 2.
    2. **Re-checked on C-63:** it only adds a pit handle to the existing preview row. It clashes in the change log only.

11. **#1039 C4 B5 (Civil): pipe size check worded for the job mode.** Head deebc653. **MERGE-WITH-FIXES, later plan train (batch 3 verdict, still true).**
    1. **Plan item:** C4 B5. **Part only:** wording, no caller.
    2. **The fix (from batch 3):** take the design-from-scratch words from the installed `PipeFlowSizingAdvisorService.VerdictWords` (C-63 line 65) instead of a second copy.

12. **#1040 INT-075 (Civil): ribbon and menu labels read "Name (COMMAND)".** Head 4cc6b37d, +161/-5. **MERGE-WITH-FIXES, later plan train.**
    1. **Plan item:** INT-075 / UX-NAMES-03 transition names. **Part only:** the Civil ribbon and the CE CVL menu. Tooltips, window titles, help and Structural are not done.
    2. **Is the claim real?** Yes. On C-63, ribbon labels are the plain name only.
    3. **Does it do only that?** Yes. It adds one shared helper (`TransitionNames`). A label that already has brackets, or is the command itself, is left alone. One small side effect is a good one: a menu item with an empty name now shows the command instead of a blank item.
    4. **Fix (one value):** INT-075 says "defaulting ON". The planning chat's one-plan (17 Oct, Civil section 7, item 2) says: "the built PR #1040 has it OFF. Not a question; fix the PR". Set `showAutoCadCommandNames` to true and update the default test.
    5. **Why still not 9 Nov:** ON changes every ribbon label the pilot colleague sees. Ruling F holds ribbon changes until after the pilot, unless Tim says otherwise. Before it goes ON, Codex should look at a narrow ribbon for labels that are cut short.
    6. **Tests:** the first 6 were written with the code, not shown failing first. The 9 split-button and menu tests were red first.

---

## What I did NOT check

1. **No build and no test run.** Every "test fails without it" above comes from the PR's own log, plus my reading of the test against the code. I did not run them. C: had 18 GB free, but nothing here needed a build to reach a verdict.
2. **The merge test was against C-63 (28987b73) only**, using git's merge-tree. It was not against C-64 or the batch 1 to 12 lists, and nothing was compiled after the merge.
3. **Nothing was opened in AutoCAD.** I could not judge Edit Pit's locked-layer handling for #1036 beyond the fact that it is the existing Edit Pit Save. #1035's Undo-off write needs a real AutoCAD proof.
4. **#1037 and #1039:** I relied on batch 3 and only re-checked that C-63 has not changed the lines they touch.
5. **I did not check whether Tim has confirmed that INT-078 covers Set C items 1 to 4, 6 and 7.** I found the open question (build queue 10 Oct, item 21) and no answer to it. So I kept those switches OFF.
6. **The PR descriptions on GitHub were not read**, only titles, code and change-log entries.
