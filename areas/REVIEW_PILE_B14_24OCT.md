# Opus review of the best unreviewed PRs, batch 14 (Sat 24 Oct 2026)

Headless job, desk plan/03, Team (Opus), about 07:08 to 07:20 Melbourne time. Input: `PR_PILE_TRIAGE_2026-10-24.md`, **class F (plan work), positions 25 to 36** of the full class F list: #1042, #1045, #1046, #1047, #1048, #1049, #1052, #1053, #1054, #1055, #1056, #1057. Read-only: no code changed, nothing built, merged, closed, pushed to a PR branch or deployed. AutoCAD and Codex not started. I read the code from the triage's own copy of the repo (`C:\ce-tr\repo.git`); no worktree was made, so none needed removing.

## ANSWER FIRST

1. **Counts (12 PRs, all opened 9 to 10 Oct, none in C-63 or S-43):**
   1. **Civil 7:** #1042, #1046, #1047, #1048, #1053, #1054, #1056. **Structural 5:** #1045, #1049, #1052, #1055, #1057.
   2. **MERGE 6:** #1042, #1046, #1047, #1048, #1052, #1056.
   3. **MERGE-WITH-FIXES 5:** #1045, #1049, #1053, #1054, #1055.
   4. **HOLD 1:** #1057. **REJECT 0.**
   5. **#1048 was already reviewed in batch 3 (MERGE).** I checked it again against C-63 and that verdict stands.

2. **9 Nov scope:** only **#1047** is really a bug fix: a plastic pit's "PP" line gets saved into the pit as typed text above. It is small, has no switch and fits the pilot. **#1056** is tests only, so it changes nothing a drafter sees and is safe on any train. The other ten are plan work. Tim's rulings A and F (17 Oct) put them on a later plan train. The five Structural PRs are outside the Civil + Manager + Shared pilot anyway.

3. **Top faults:**
   1. **#1054 can check a tank against the wrong report row.** It matches a STORM row to a drawn tank on the row's FIRST word only. A row called "Roof A" would match a tank whose catchment is "Roof B", and CE would say "Passes" or "Short" for the wrong tank. It is safe for "D1" against "D10", which is what the tests cover.
   2. **#1055 would move footing columns with no heading if switched on.** With the switch ON, footings with their own concrete strength move to the right-hand end of the schedule. But the "40 MPa CONCRETE" band heading is not drawn yet, so the drafter sees columns in a new order with nothing to say why. Today nothing can give a footing its own strength yet, so nothing happens. But the switch must not go ON as built.
   3. **#1049 prints the same warning twice and can contradict itself.** On a plan with no level, CSLOADPATH would show "This plan's level is not set" twice. If a level was recorded but not yet confirmed, the new line says "not set" while the next line says "recorded as First, confirm it".
   4. **#1057 makes its own PDF writer.** Structural already writes PDFs through one shared PDF library (used by the job-wide issue PDF). A second writer breaks design rule 1. It also prints "?" for Ø, °, ² and ± (common in structural markups), and a long line in capitals can run past the right edge of the page. **HOLD:** rebuild it on the existing PDF library.
   5. **#1053 posts "CDCALC did not finish… press U" to the whole job's bell with no name or drawing.** Under Tim's UX-MSG-03 ruling a failure follows the job, so a colleague would see it with no idea whose drawing it was. The bell is OFF today, so nobody sees it yet.
   6. **Two PRs put a new Settings description in the wrong place** (#1045 and #1054). The new note was pasted between an existing class and its own description. So the existing class (Detention settings, roof point-load settings) loses its explanation, and the new one gets two. It changes nothing in AutoCAD, but it misleads the next person who reads the code.

4. **Safe to merge today:**
   1. **C-64 (Civil fix train after C-63):** #1047, but file a carpark bug for it first (I did not edit the carpark). #1056 can ride along (tests only).
   2. **A later Civil plan train (not the pilot):** #1042, #1046, #1048. #1046 and #1048 both add lines at the same spot in the council profile file: keep both.
   3. **A later Structural plan train after S-43:** #1052. It also clashes with #1055 in the Structural Settings files: keep both.
   4. **After their small fixes are pushed:** #1045, #1049 (stacked on #1045), #1053, #1054, #1055.

5. **Risk checks, all twelve:**
   1. **Redo (U then REDO):** none adds an Idle, command-end or object-change hook. Only #1052 writes to the drawing, in one Undo step, through the CSLINTELTABLE code that is already installed. #1053 writes only to the bell's message file, never the drawing, and only when the bell is ON.
   2. **Locked layers, Xrefs, REFEDIT:** #1052 keeps CSLINTELTABLE's checks (read-only drawing, REFEDIT open, a locked layer here or locked on S01). Nothing is unlocked. None of the others touches drawing objects.
   3. **Switches:** the plan PRs all start OFF or have nothing that calls them. Starting OFF is allowed for plan work (ruling B, 17 Oct). #1047 is a fix with no switch, which matches the identical rule already in Edit Pit. None is a bug fix whose switch starts OFF.
   4. **CE_SHARED, installer, signed-update files:** none touched, so nothing is held for that.
   5. **Hard-coded engineering values:** #1054's tank tolerances (0 L shortfall, 5 % or 5 m²) are in the Settings file, marked "Assumed until Tim says". But there is **no Settings page row** for them yet. They need page rows and Tim's figures before the switch goes ON. #1042 adds no tolerance, per ruling 222-223. #1048's and #1046's council values are empty until sourced. #1052's "S01" and "TRIMMER" are file-finding words, not engineering values, but S01 is an assumption Tim has not confirmed (build queue 10 Oct item 13).
   6. **New hard blocks:** none of the twelve adds a new hard block. One borderline case: #1042's future Issue step will refuse with "Pick the responsible engineer to issue." That is Tim's own UX-CALC-03 ruling ("Anyone, names the engineer"). The desk should decide whether it counts toward the two allowed hard blocks before the Issue window is built.
   7. **C-63 (`claude/rel-20261024m`, 28987b73) and S-43 (`claude/rel-20261024s`, 9ad9f605):** none of the twelve is in either list. A merge test of each PR onto its train tip clashes only in `REGRESSION_LOG.md` (keep both entries). Between themselves: #1046 with #1048 (council profile), and #1052 with #1055 (Structural Settings). Keep both sides each time.

---

## Each PR

1. **#1042 C4 B7 (Civil): the computations Issue record and the "drawn storage differs from issued" warning (engine only).** Head 4395b901, +265/-0, 3 files. **MERGE, later Civil plan train.**
   1. **Plan item:** C4 B7 = D+F slice 4, Issue (UX-CALC-03, build queue 10 Oct item 8). **Part only:** the record and the comparison. Not built: the Issue window, writing the record into the drawing in one Undo, "FOR CONSTRUCTION" on the sheet, and the list of engineers. Not 9 Nov.
   2. **Is the cause real?** Yes. C-63 has no Issue record. `ComputationsSheetV3` and `ComputationsRecord` print DRAFT and have nowhere to keep who issued it, which engineer, which revision or the issued storage.
   3. **Does it do only that?** Yes. Two new pure pieces, with nothing that calls them. An unknown storage stays "not known", never 0. There is no tolerance: 12.341 and 12.344 both read 12.34 and say nothing, as ruling 222-223 asks. A system drawn since the issue, or no longer drawn, is said. It never refuses Issue because of a warning (R-27). The date is converted to Melbourne time.
   4. **Test that fails without it:** yes, 8 of 8 (the classes do not exist on C-63).
   5. **Example of what Tim would see later:** "System 1: issued 12.34 m3, drawn 12.80 m3, difference 0.46 m3."

2. **#1045 Batch 13 card 13.1 (Structural): one "Roof-down help" switch turns the four roof-down commands on together.** Head 0e6d8de5, +104/-5, 9 files. **MERGE-WITH-FIXES, Structural plan train after S-43.**
   1. **Plan item:** card 13.1 (UX-STRUC-13), the "one switch" bullet. **Part only.** Not built: CSPLANLEVEL asking itself, the full "where am I" line (see #1049), footings-last listing, and the ribbon tooltip. Structural, so not 9 Nov.
   2. **Is the cause real?** Yes. On S-43 the four commands each read their own switch (`PointLoadCommandService` line 34, `LevelCarryCommandService` line 35, `FoundationService.LoadPath` line 86, `FoundationService.Proposal` line 55). No single switch exists.
   3. **Does it do only that?** Yes. The master switch is ORed with each command's own switch. It does not turn on "the plans share one base point" or "carry the load down across drawings", and a test checks that. Commands still hidden from the ribbon stay hidden.
   4. **Test that fails without it:** yes (the new class and the master setting are missing).
   5. **Fixes (small):**
      1. Move the new `RoofDownHelpSettings` description so it sits directly above its own class. At present it sits between the UX-SUB-04 description and `RoofPointLoadSettings`, so roof point loads lose their description.
      2. In `LevelCarryCommandService`, write the check as `!RoofDownHelp.Applies(settings.Enabled)` like the other three, and update the pinned text test. The current form `!settings.Enabled && !RoofDownHelp.Applies(false)` gives the right answer but was bent to fit an old test, and its comment says so.

3. **#1046 UX-CR-09 (Civil): council refused-storage items and the warning rule (engine only).** Head f7663de7, +196/-0, 4 files. **MERGE, later Civil plan train.**
   1. **Plan item:** UX-CR-09 (Tim, 26 Sep, B7: "Warn, with source"). **Part only:** the council list and the rule. Not built: the "Storage type" and "Location" choices on the detention record, and the CDCHECK line. Not 9 Nov.
   2. **Is the cause real?** Yes. C-63 has no refused-storage field on the council profile (`StorageKind`, `refusedStorageItems` and `UX-CR-09` appear nowhere).
   3. **Does it do only that?** Yes. Shipped council files stay byte for byte the same, because the list is left out when empty. A storage with no type recorded is never reported as refused. Above-ground storage with no location is never guessed to be on a driveway. It never blocks.
   4. **Test that fails without it:** yes, 8 tests (the rule does not exist).
   5. **Note:** it clashes with #1048 at the same lines of `CouncilProfileModels.cs`. Keep both blocks.

4. **#1047 Batch 1 Q3 (Civil): a plastic pit's "PP" line is no longer saved as the drafter's text above.** Head 65276f4d, +66/-2, 3 files. **MERGE, C-64 (bug fix; file a carpark bug first).**
   1. **Plan item:** Batch 1 Q3 (INT-074). **Completes it.** It is really a bug fix, so it fits the 9 Nov pilot under ruling F.
   2. **Is the cause real?** Yes. On C-63, `ProjectDataService.TryParsePitCoverText` (line 1146) reads the cover text off the plan when the drawing's CE data is refreshed (line 671). It has no "PP" rule, so the label "PP / CL 10.250" saves "PP" into the pit as text above. Edit Pit's own reader (`PitEditCommand.cs` line 1983) already skips "PP". The two readers disagree today.
   3. **What goes wrong on a job:** the pit record holds "PP" as typed text. Edit Pit loads it from the record (`PitEditCommand.cs` line 1205) and the PIT window copies it (`PitViewModel.cs` line 1188). The next rewrite of the label can then print PP twice, and the Pit Schedule can show "PP" as a note the drafter never typed.
   4. **Does it do only that?** Yes. One skip line, the same rule as Edit Pit's. "PP" inside a longer line ("PP SPECIAL") is kept.
   5. **Test that fails without it:** yes, 3 of 4 (TextAbove would be "PP"; the read-back and rewrite would not match; a "PP"-only label would count as something to save).
   6. **Small side effect (acceptable):** a NON-plastic pit whose only typed text above is "PP" would also lose it on refresh. Edit Pit already behaves this way.

5. **#1048 UX-CR-08 class half (Civil): council minimum concrete pipe class, default and warning (engine only).** Head e500ef05, +158/-0, 4 files. **MERGE, later Civil plan train** (batch 3 verdict stands).
   1. **Plan item:** UX-CR-08 (Tim, 26 Sep: "Default from council + warn"). **Part only:** no Class field on the pipe yet, no Pipe Schedule column, no CDCHECK line, no council values filled in.
   2. **Re-checked on C-63:** still not present there. `MaterialVelocityLimits.IsConcrete` exists (line 100). It never assumes Class 2, never blocks and only applies to concrete.
   3. **Note:** it clashes with #1046 in `CouncilProfileModels.cs`. Keep both.

6. **#1049 Batch 13 card 13.1 (Structural): CSLOADPATH's first line names this plan and the level above (stacked on #1045).** Head 583e9d8b, +64/-0, 4 files. **MERGE-WITH-FIXES, after #1045.**
   1. **Plan item:** card 13.1, the "where am I" bullet. **Part only.** The card wants the drawing and what was found there ("Level above: Roof (S07 roof framing.dwg, 4 point loads, 6 posts)") and "not found in the job folder. Draw the roof first". This gives level names only.
   2. **Is the cause real?** Yes. On S-43 there is no such line; only `LevelNote` explains a missing level.
   3. **Faults:**
      1. With no plan level set, the drafter gets two near-identical lines. The new "This plan's level is not set. Type CSPLANLEVEL to set it, or carry on." is followed by the existing "This plan's level is not set, so the markers say…".
      2. A level recorded but not yet confirmed (`HasUnconfirmedLevel`) is called "not set" by the new line. The next line then says "recorded as First; type CSPLANLEVEL and press Enter to confirm it." Those contradict each other.
   4. **Fix (small):** print the new line only when the level is known (`WhereAmILine` returns empty otherwise), and leave the unknown and unconfirmed cases to `LevelNote`. Add one test for the unconfirmed case.
   5. **Test that fails without it:** yes (the method and the setting are missing).

7. **#1052 Batch 14 card 14.2 (Structural): CSSILLTABLE copies the office windowsill trimmer table from S01 (OFF).** Head 4812bdce, +197/-43, 9 files. **MERGE, Structural plan train after S-43.**
   1. **Plan item:** card 14.2, the windowsill trimmer part (build queue 10 Oct item 13). **Completes that part.** The lintel part is already installed.
   2. **Is the cause real?** Yes. S-43 has only CSLINTELTABLE.
   3. **Does it do only that?** Yes. It is one code path for both tables (design rule 1). The lintel wording is unchanged, and a test checks that. Each table has its own copy mark, so one never makes the other say "already here". It keeps all of CSLINTELTABLE's protections: read-only drawing, REFEDIT, a locked layer here, and a layer locked on S01 and missing here. Escape copies nothing; one copy = one U. Typed command only, hidden, Settings switch OFF.
   4. **Test that fails without it:** yes (the new kind and setting are missing).
   5. **Before the switch goes ON:** Tim to confirm the trimmer table really sits on S01 (an assumption the PR states). If the office lintel table also contains the word TRIMMER, CE will find two tables and copy nothing. That is safe, and the fix is to type a second word in Settings.
   6. **Note:** it clashes with #1055 in `UserSettings.cs` and `SettingsService.cs` (side-by-side inserts). Keep both.

8. **#1053 UX-MSG producer 1 (Civil): a CE command that stops on an error also tells the CE bell (bell OFF).** Head 6b69e206, +82/-0, 4 files. **MERGE-WITH-FIXES, later Civil plan train.**
   1. **Plan item:** UX-MSG producers (build queue item 22), the first piece. **Part only.**
   2. **Is the cause real?** Yes. On C-63 `CeCommandBase.Fail` (used by 21 commands) writes only "[CE] Error - see CE log for details." and the bell is never told.
   3. **Does it do only that?** Yes. One line in the shared failure path. While the bell is OFF (the default) it does nothing. It never throws and never touches the drawing, so nothing lands between U and REDO. Unlike the existing `Failure` message, it rightly does not promise "Your drawing was not changed".
   4. **Fault:** under Tim's UX-MSG-03 ruling a failure message follows the **job**, so every colleague on that job sees "CDCALC did not finish… press U to step back". It does not say whose drawing it was, and U means nothing to them.
   5. **Fix (small):** add the person and the drawing, e.g. "CDCALC did not finish for Tim in C01.dwg. The details are in Tim's CE log." Keep the U advice out of the shared text, or make the message Personal if Tim prefers (his call; recommend adding the names and keeping Job, per his ruling).
   6. **Test that fails without it:** yes (`CommandStopped` is missing). One of the four tests only reads the source text; that is the accepted pattern here.

9. **#1054 I-WSUD-02 (Civil): drawn rainwater tanks checked against the STORM rating report (engine only, OFF).** Head 01d292af, +318/-0, 4 files. **MERGE-WITH-FIXES, later Civil plan train.**
   1. **Plan item:** UX-WSUD-02 (Tim, 25 Sep: "Check and warn"), the tanks-first slice. **Part only.** Not built: reading the drawn tanks from the drawing, the Checks line, the Settings page rows, buffer strips and raingardens.
   2. **Is the cause real?** Yes. C-63 reads the STORM report (`StormReport.cs`) but never compares it with the drawn tanks.
   3. **Faults:**
      1. **Wrong-tank match.** `NamesCatchment` matches the row's first word against any word of a tank's catchment names. "Roof A" matches a tank fed by "Roof B" (both have "Roof"). CE would then say "Passes" or "Short 1000 L" against the wrong tank. **Fix:** match the whole row name, or the row's first word against the catchment's first word, and add a "Roof A" against "Roof B" test.
      2. **Description in the wrong place.** The new Settings description sits between the CL3 Detention description and `DetentionSettings`, so Detention loses its description. **Fix:** move it above `WsudCheckSettings`.
   4. **Engineering values:** 0 L shortfall and "5 % or 5 m², whichever is larger" are Settings values marked "Assumed until Tim says". There is no Settings page row yet. Both must exist before the switch goes ON.
   5. **Test that fails without it:** yes, 10 of 11 against a stub.

10. **#1055 Batch 14 card 14.4 (Structural): footing schedule strength band in the schedule model (engine only, OFF).** Head 090d32c2, +212/-4, 8 files. **MERGE-WITH-FIXES, Structural plan train after S-43.**
    1. **Plan item:** card 14.4 (UX-SSCHED-01), the strength band (question 14, INT-078 "as recommended"). **Part only.** The band row is not drawn, and FEDIT cannot set a footing's strength yet.
    2. **Is the cause real?** Yes. On S-43 a footing has no strength of its own and the schedule has no band.
    3. **Fault:** with the switch ON, `ApplyStrengthBands` moves banded footings to the right-hand end of `model.Columns`, but the "40 MPa CONCRETE" heading is not drawn yet. Once anything can set a footing's strength, the drafter would see PF2 jump to the end with no heading.
    4. **Fix (small):** fill `StrengthBands` but leave the column order alone until the band row is drawn, or draw the band in the same PR. Say in the Settings description that the switch stays OFF until then.
    5. **Good:** it never invents a strength. An unknown strength is warned when the title has none. A mark drawn at two strengths is warned and shows the most common one. Older footing records save exactly as before, because a 0 strength is not written.
    6. **Test that fails without it:** yes (the new fields and the band logic are missing).

11. **#1056 L3-LEVELS (Civil): pin that the "check these levels" step and the classic solve use the same minimum cover (tests only).** Head db02b151, +80/-3, 4 files. **MERGE, any Civil train (C-64 fine).**
    1. **Plan item:** plan-L3-LEVELS slice 2 item 3 (the open point of the #697 review). **Completes it.** That is a check, not a feature.
    2. **Is the claim real?** Yes, I checked the code, not the PR text. On C-63, CDRUNSOLVE, CivilDesignService, the Design Check dashboard and network redesign all call `StandardsWithRulebookCover()`. That uses `ResolveMinCoverMm`, the same council, then project, then office cover the levels check uses. The old "matching is still open" comment in `RulebookLevelsCheck` is now out of date, and this corrects it.
    3. **Does it do only that?** Yes. Two test files and one comment. Nothing a drafter sees changes.
    4. **Test that fails without it:** not applicable. It is a guard that passes today and fails if someone later splits the two covers again.
    5. **Optional:** use `double.Parse(il, CultureInfo.InvariantCulture)` in the new test so it also passes on a PC with a comma decimal point.

12. **#1057 Batch 15 card 15.7 (Structural): the clarification list written as a PDF in the job's Markups folder (engine only).** Head 26dee7a3, +308/-0, 3 files (its base, #1006, is already installed). **HOLD.**
    1. **Plan item:** card 15.7 (UX-QA-07; Tim, 25 Sep: "Yes, a PDF list with snippets"). **Part only:** text list, no snippets, no CEMARKUPCLARIFY command.
    2. **Is the cause real?** Yes. #1006 decides what goes on the list and the file name, but nothing writes the file.
    3. **Why HOLD:**
       1. **A second PDF writer.** It builds the PDF by hand, character by character. Structural already makes PDFs with the PdfPig library (`CeIssueJobWidePdfService` uses its `PdfDocumentBuilder`). Two ways to make one kind of file breaks design rule 1.
       2. **Lost characters.** Anything outside plain ASCII prints as "?". On a structural markup that hits Ø (pier and bar diameters), °, ², ± and the like. Example: "450Ø PIER" prints as "450? PIER".
       3. **Text off the page.** Lines are wrapped at 88 characters whatever their width. A long line in capitals (normal in engineers' markups) can run past the right margin of the A4 page.
    4. **What to do:** rebuild the writer on the PdfPig builder that is already used, with its standard fonts and text measuring, and keep this PR's good parts: the empty-list rule, same-day replace, the "open in another program" message and the never-sent source test. Then open the PDF and look at it (RULES 5.1); the PR says nobody has.
    5. **Test that fails without it:** yes (the writer is missing). The tests read the PDF back with PdfPig, but nobody has looked at it.

---

## What I did NOT check

1. **No build and no test run.** I read the code and ran merge tests only (`git merge-tree` of each PR onto the C-63 tip 28987b73 or the S-43 tip 9ad9f605, and the pairs that touch the same files). "Fails without it" comes from reading whether the test needs code the PR adds, plus the PR's own RED-first notes. I did not re-run any test.
2. **Nothing was opened in AutoCAD or a PDF viewer.** #1057's PDF was not looked at.
3. **Real office files:** I did not open an S01 sheet to see whether the lintel and trimmer tables (#1052) would be told apart, and I did not open a real STORM report to see how row names are written (#1054).
4. **Carpark:** I did not search for an existing bug number for #1047's "PP saved as text above". The desk should file one (or find it) before C-64. I did not edit the carpark, DESK_LOG or QUEUE.
5. **Housekeeping:** to read the S-43 tip I ran one `git fetch` of `claude/rel-20261024s` into the triage's copy `C:\ce-tr\repo.git`. That added objects only and changed no branch there. Nothing in `C:\Lisp Files\CE_ACAD_PLUGIN` was changed.
