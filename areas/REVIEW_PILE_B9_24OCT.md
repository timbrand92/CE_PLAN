# Opus review of the best unreviewed PRs, batch 9 (Sat 24 Oct 2026, about 05:28 to 05:45 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 91 to 102 (counted within class E only).

I read the code at each PR's exact head (fetched about 05:30). I compared each one with installed Structural 1.0.122 (`claude/rel-20261023s` @ e6d597c0), with the S-43 list (#1695 to #1699) and with the C-63 train (`claude/rel-20261024m` @ 28987b73). The trial merges ran in memory only. This was read-only: nothing was built, tested, merged, installed or pushed to a PR branch, and AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts (12 PRs in the slot, 7 reviewed, all Structural):**
   1. **MERGE:** 3 (#1589, #1603, #1604).
   2. **MERGE-WITH-FIXES:** 4 (#1590, #1592, #1596, #1598).
   3. **HOLD:** 0. **REJECT:** 0.
   4. **Skipped, because they already have an Opus review:**
      1. #1588 is in `REVIEW_PILE_B2_24OCT.md` item 5.
      2. #1593 and #1597 are in `REVIEW_PILE_B1_24OCT.md` items 7 and 6.
      3. #1599 is in `REVIEW_PILE_B2_24OCT.md` item 6.
      4. #1601 is in `REVIEW_PILE_B3_24OCT.md` item 7.
   5. **#1592 and #1604 were reviewed here.** `REVIEW_CODEX_LF_A_23OCT.md` only lists them under "Not checked". The other grep hits for #1589 and #1596 were a commit hash and a log entry number, not reviews.

2. **Top faults found:**
   1. **#1598 (EBT and 25C text height) makes text 100 times too small in one common setup.** The setup is DIMSCALE 0 with AutoCAD's default annotation scale of 1:1. The new rule now reads "1:1" as the drawing scale. Example: an EBT tag that used to come out 250 high (2.5 mm at 1:100) would come out 2.5 high, which is invisible on the plot. Because #1596 routes every tag through the same height, TH, PF, BP and 18 text would shrink the same way.
   2. **#1596 (tag heights follow the scale) leaves the "C1(O)" column-over text fixed.** At 1:20 a BPC tag's main text drops to 50 high, but the "C1(O)" beside it stays 180 high. That plots 9 mm next to 2.5 mm. The bug names column tags, so this half is still broken.
   3. **#1592 (hatches drawn with a warning) does not update the CEHATCH picker preview.** Example: at DIMSCALE 100 and LTSCALE 1, the hatch now places with a warning. But the preview box in the hatch picker still says "No preview: the drawing scale is not valid". That is two rules for one behaviour (design rule 1).
   4. **#1590 (CEMEMBER uses the office default scale) never names the Setting.** The carpark asks for that. The warning says "used 1:50" but not where the 1:50 came from.

3. **Safe to merge today:**
   1. **Structural, into S-44 (after S-43), in this order:** #1589, #1604, #1603.
   2. **Then, once their fixes are pushed:** #1590 (after #1604), #1592 (after #1577 from batch 8), #1596, #1598 (after #1596).
   3. **Known code clash:** #1592 and #1596/#1598 both add a line at the same spot in the Settings label list (`SettingsService.LoadRecovery.cs`). Keep both lines. Every other clash is `REGRESSION_LOG.md` only (keep both entries).

4. **Rules checks across the batch:**
   1. **Redo (nothing writes between a U and its REDO):** no PR adds a drawing write, a system-variable change, a regen, a typed command or an event hook. #1589 writes the member schedule in the same place as before, after a successful insert. It now writes fewer rows.
   2. **Locked layers, Xrefs, REFEDIT:** nothing is unlocked, detached or bypassed.
   3. **Switches:** two new bug-fix switches, and both start ON.
      1. **"Layouts: HatchCarryOnWhenScalesDisagree" (#1592):** ON. A test pins the default, and an older settings file without the key gets ON too.
      2. **"Bracing: UnknownWhenTypesDiffer" (#1603):** ON.
      3. **Existing switches reused:** #1596 and #1598 use the existing "Tag text follows label height" switch (ON). #1604 uses the existing "Day 1 units: hold in non-millimetre drawings" switch (ON).
   4. **CE_SHARED, installer, signed-update files:** none touched. Every file is under `Modules/Structural`, `Modules/Structural.DesignCore`, their test folders, or `REGRESSION_LOG.md`.
   5. **Hard-coded engineering values:** none new. #1596 keeps the old 250, 200 and 180 sizes, but now only as shares of the label-height Setting (100, 80 and 72 per cent). #1603 adds no brace ratings; it only refuses to show green.
   6. **Hard blocks:** none new. #1604 stops CEMEMBER in a metre, centimetre or inch drawing with one plain line and draws nothing. That is the same reviewed hold that AB, BB, BT1, R1 and the support blocks already use (HUNT-S-06), and it has its own Settings switch. #1592 removes a refusal.
   7. **C-63 and S-43:** C-63 touches no Structural file. No PR here touches an S-43 file in a way that clashes. #1590 and #1604 both edit `CeMemberCommands.cs`, which S-43's #1698 also edits, but all three merge cleanly with each other.

## One item per PR

1. **#1589 BUG-974 (Structural): XCLMTXT rows you left out are not saved for C2 and the other support commands.** Head cecf3506, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. In installed 1.0.122, `XclmTxtService.TryPersistMemberSchedule` (line 310) saved every non-title row with a mark. It never checked the Include tick. So excluding "C2 = 200 SHS" still saved C2, and typing C2 later used 200 SHS without asking.
   2. **Fix does only what it says?** Yes. The row filter moves into a small method that also requires Include to be ticked. Mark, size and group are saved exactly as before. The saved schedule replaces the old one in full (`MemberScheduleService.WriteSchedule`), so a re-run that now excludes C2 also takes C2 out.
   3. **Test fails without it?** Yes. The new method did not exist, so the tests would not compile. The "C2 excluded" case would fail on the old filter.
   4. **Small leftover (not a blocker):** if every row is excluded, nothing is written and an older saved schedule stays as it was. That was already the case before this PR.
   5. **Verdict: MERGE. Train S-44.**

2. **#1590 BUG-912 (Structural): CEMEMBER uses the office default scale when DIMSCALE is 0.** Head bd91dbd7, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. The command read the office default only for the case where DIMSCALE could not be read. A DIMSCALE of 0 is a real reading, so `CeMemberScale.Resolve` replaced it with the fixed 1:100. At 1:50 that drew 150 / 200 break marks instead of 75 / 100.
   2. **Fix does only what it says?** Yes. The office default now reaches the scale rule, and a value that is not usable still falls back to 1:100. A DIMSCALE that is set is never replaced (tested).
   3. **Test fails without it?** Yes. The new three-value rule did not exist, and a source check makes sure the command passes the office default.
   4. **Fix needed (small):** the carpark asks for the Setting to be "named in the warning". The line says "The drawing scale (DIMSCALE) is not set, so CEMEMBER used 1:50." When the office default is used, add the words "the office default scale on the Settings page". Pin that wording in the new test.
   5. **Verdict: MERGE-WITH-FIXES. Train S-44, after #1604.** Both PRs edit `CeMemberCommands.cs` in different places and merge cleanly.

3. **#1592 BUG-953 (Structural): EH, CH, LBH and LBUH draw the hatch with a warning, not a refusal, when LTSCALE is not 10 x DIMSCALE.** Head 602bc901, base `claude/tl2-r501-bug881-hatch-repair-scale` (#1577, MERGE in batch 8).
   1. **Cause real?** Yes. With "Follow any drawing scale" ON, the rule (`DrawingScaleRule.StatedHatchPatternScale`) returned "no answer" for any pair that was not LTSCALE = 10 x DIMSCALE. `HatchCommands.ResolveScale` then printed "Invalid DIMSCALE/LTSCALE combination" and drew nothing. The pattern scale only depends on DIMSCALE.
   2. **Fix does only what it says?** Mostly. With the new switch ON, any DIMSCALE above 0 gives a hatch, plus one plain line saying the two scales do not agree. A DIMSCALE of 0 or a broken one is still not guessed. The 1:20 and 1:100 pairs are unchanged. CEHATCHAUDIT uses the same rule, so it expects what placement draws (tested at 1:50 with LTSCALE 1).
   3. **Test fails without it?** Yes. The "DIMSCALE 100, LTSCALE 1 gives 40" case returns nothing on the old rule.
   4. **Fix needed (small):** the CEHATCH picker preview has its own copy of the call (`HatchPreviewGeometry.ResolveScale`, line 211, called from `CeHatchPresetDialog.cs` line 398). That copy does not pass the new switch. So the preview says "the drawing scale is not valid" for a hatch that will now place. Pass `DrawingScaleSetting.HatchCarryOnWhenScalesDisagree()` through, and add one preview test at DIMSCALE 100 / LTSCALE 1.
   5. **Note (no change asked):** CEHATCHAUDIT will now repair hatches to the DIMSCALE scale in a drawing whose LTSCALE disagrees, without printing the "do not agree" line. That is consistent with placement, but the audit could say it too.
   6. **Verdict: MERGE-WITH-FIXES. Train S-44, after #1577.** When it meets #1596 or #1598 in `SettingsService.LoadRecovery.cs`, keep both new label lines.

4. **#1596 BUG-951 (Structural): TH, PF, BP, column, 18 and setout tags keep their size on paper at every scale.** Head be6e198f, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. `CeTextService` (installed lines 663 to 780) gave these tags a fixed 250, 200 or 180 at every scale. At 1:20 a PFL tag was 12.5 mm on paper.
   2. **Fix does only what it says?** Partly. All 27 tag call sites now use "the old 1:100 size as a share of the 2.5 mm label height, times the scale". At 1:100 nothing changes. In a converted (metre) drawing they also pick up the drawing's units, because they go through the 25C height.
   3. **Test fails without it?** Yes. The new rule did not exist, and the tests check the 1:20, 1:50 and 1:100 values.
   4. **Fix needed (small):** two "(O)" column-over texts are still fixed at 180:
      1. `CeTextService.cs` line 1308 (THC and PFC with a column over, `QuickFootingDrawn(180.0)`).
      2. Line 1421 (BPC, `180.0`).
      Use `FixedTagHeight(180)` for both. Drop the `QuickFootingDrawn` wrapper at 1308, because the label height already includes the drawing's units. Add a source check.
   5. **Leftover (say so on the PR, not a blocker):** the gaps between the text and its rectangle (for example `QuickFootingDrawn(150.0)`) are still 1:100 sizes. At 1:20 the "(O)" text will sit a little far from its line.
   6. **Note:** the switch is the existing BUG-531 "Tag text follows label height" switch (ON), so beam tags and these tags turn off together. Its Settings label was updated to say so.
   7. **Verdict: MERGE-WITH-FIXES. Train S-44.**

5. **#1598 BUG-911 (Structural): EBT and 25C text height follows the drawing's units and annotation scale.** Head 55502890, stacked on #1596.
   1. **Cause real?** Yes. `Get25TextHeight` outside the quick footing commands returned DIMSCALE x 2.5 in every unit (125 m in a metre drawing at 1:50). At DIMSCALE 0 it fell back to 250 whatever the annotation scale was.
   2. **Fix does only what it says?** Yes for the two cases named. A millimetre drawing with DIMSCALE set is exactly as before (tested at 20, 50 and 100). A metre drawing is converted with the footing rule that is already reviewed (0.125 at 1:50). DIMSCALE 0 now uses the annotation scale.
   3. **Test fails without it?** Yes. The new method did not exist, and the metre case gives 125 on the old code.
   4. **Fix needed (MEDIUM):** `ScheduleService.ParseAnnotationScale("1:1")` returns 1. So DIMSCALE 0 with CANNOSCALE 1:1 (AutoCAD's default) now gives 2.5-high text instead of 250. Treat an annotation scale of 1 or less as "no usable scale", which keeps the earlier 250. Add `[TestCase("1:1")]` to `DimscaleZeroWithNoUsableAnnotationScale_KeepsTheEarlier250`. The carpark also allows "the command says the scale is unavailable", so one line saying so would help.
   5. **Note:** the metre branch goes through `FootingLabelTextHeight`, which has the same 1:1 reading when DIMSCALE is 1 or less. That was already the case in footing labels; it is not new here.
   6. **Verdict: MERGE-WITH-FIXES. Train S-44, right after #1596.**

6. **#1603 BUG-950 (Structural): the bracing panel shows unknown, not green, when brace types differ.** Head b86a2f01, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. `BracingPanelCalculator.Summarise` (DesignCore, installed lines 62 to 100) added up the metres of every brace type in a direction and showed green once the total met the requirement. A weak brace could count as much as a strong one.
   2. **Fix does only what it says?** Yes, and it is the carpark's stated interim ("lengths only, types not weighted" and unknown when the types differ). If a direction mixes types and has enough metres, it now shows the grey triangle instead of a green tick, with "(lengths only, brace types not weighted)". A shortfall in metres is still red. One type only behaves as before.
   3. **Test fails without it?** Yes. The new result field and setting did not exist, so the tests would not compile. The mixed-types case was green on the old code.
   4. **Engineering judgement:** none is decided here. The real fix (a rating per brace type in kN on the Settings page) still needs Tim's word, so **BUG-950 must stay OPEN after this merges**.
   5. **Small notes (not blockers):**
      1. The new setting has no plain label in the Settings label list, the same as the other bracing settings. The Settings row is owed by the Codex window lane.
      2. One line was added in `BracingPanelWindow.xaml.cs`, a window file. It is a text suffix only.
      3. A brace with no type counts as a type of its own, which is the safe way round.
   6. **Verdict: MERGE. Train S-44.**

7. **#1604 BUG-880 (Structural): CEMEMBER holds in a non-millimetre drawing.** Head c857bdf9, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. `CeMemberCommands` drew section sizes from the millimetre table as drawing units. In a metre drawing a 310UB32 came out 298 m deep.
   2. **Fix does only what it says?** Yes. CEMEMBER calls the same shared hold as AB, BB, BT1, R1 and the support blocks (`FoundationService.Day1CommandUnitsAllowed`). It runs before any question, gives the same one plain line, and draws nothing. Millimetre and unset drawings are unaffected, and the "Day 1 units" switch (ON) turns it off. The carpark accepts "a plain warning" as the fix. Tim's 2 Oct ruling to convert rather than hold was for footings, so holding here matches the other member commands.
   3. **Test fails without it?** Yes. The source check finds no hold call on the old code.
   4. **Verdict: MERGE. Train S-44, before #1590.**

## What I did NOT check

1. **No build and no test run.** "Test fails without it" is read from the code, not run. The PR authors' own test counts were not re-run.
2. **Nothing was driven in AutoCAD.** These parts are AutoCAD-only and unproven:
   1. The XCLMTXT insert-then-C2 path (#1589).
   2. The hatch warning on the command line and the picker preview (#1592).
   3. Tag sizes on a real plot at 1:20 and 1:50 (#1596, #1598).
   4. The bracing panel's grey triangle (#1603).
   5. The CEMEMBER hold line (#1604).
3. **Not read line by line:** the test files of #1596 and #1603. I read only their test names and asserts.
4. **Not looked at:** the Settings page window (rows and fit) for the two new switches.
5. **Pinned file fingerprints:** I searched the Structural test folders for hash pins on the touched files and found none. The search was by file name only, so a pin that names a file another way could be missed. The S-43 finalizer's full run would catch it.
6. **#1589:** I did not check rows under an excluded floor title, or floors not chosen for insert. Those rows can still be saved if their own tick is on.
7. **Heads:** read at about 05:30. A later push to any PR is not covered by this review.
