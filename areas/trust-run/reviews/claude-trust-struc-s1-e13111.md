# Review: draft PR 2054, `claude/trust-struc-s1-e13111` (step S1: the Structural tab cut to the KEEP buttons behind a new switch, OFF)

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:32 PC clock. Read only: nothing built, installed or merged by this lane.
**What was read:** PR 2054's description; its one commit `6abdc171` on `claude/trust04-base-struc-1.0.126` = `8de95c34` (installed Structural 1.0.126, confirmed by ancestry); card TRUST-S1; `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`; the four product files and two test files; today's builder; the four failing tests' source; the installed Structural bundle's files (read only: file hashes, product version, type names); Tim's Structural `CommandHub` settings (the four layout switches only); `PENDING_TESTS.md` section TRUST-S1.

---

# FOR TIM

1. **With the new switch off, today's Structural tab is built exactly as now.** The only change on that path is one check that does nothing while off, and today's tab (298 buttons in seven panels) is pinned line by line by a test. I checked that the installed Structural 1.0.126 draws this same tab from the same command list, with your Structural layout settings at the defaults the pin uses.
2. **With it on: 28 buttons in four panels, roof down.** Two things to fix: 20 of the 27 buttons get new words that their own tooltip does not use (the button says "Beam pair", its tooltip "Beam Dual Layer"; "Joist marks" against "Floor Joist Marker"), which the card did not ask for; and the "Known fault" lines in the tooltips carry bug numbers and plan words ("BUG-584", "card S3", "the installed code").
3. **No button is dead on an AutoCAD year it shows on, by reading.** The four failing tests check only the steel section edit code, which this change does not touch, so "they fail without my change" is very likely true, but it was not run on the base. **Verdict: FIX FIRST** (three items). Built yes (lane: net10, net8, net48 0 errors). Tested unit only (lane, net10 subsets: 761 passed, 4 failed; net48 and net8 tests not run). Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Switch off means today's Structural ribbon exactly: YES, by reading.** The guard sits after `tab.Panels.Clear()` and returns only when the switch is on (`RibbonCommandHubService.cs` 171-184 on the branch: clear at 171, guard 175-184); the rest of `BuildRibbonFromRegistry` is unchanged (the diff is the guard and the word `partial`). The tab id and the words "CE STRUC" are unchanged. The switch is read once per AutoCAD session and kept (`CeStrucCoreRibbon.cs` 17-30), so a ribbon refresh cannot mix the two layouts.
2. **The 329-line pin: does it match the installed layout? YES, as far as the data and settings go.**
   1. 329 lines: 7 panels, 298 buttons, the slide-out lists with their children, each button's words, size and the command it sends (`RibbonCommandHubServiceTests.TodaysTab.cs` 20-351, list ends at 350).
   2. The command list it is built from is the installed one: the installed bundle's `command-registry.json` (Legacy, Net8 and Modern, all one file) equals `8de95c34`'s apart from line endings (both hash f37b1910... with carriage returns removed).
   3. The settings it is built with are the defaults; Tim's Structural settings have the four layout switches (one name per tool, split long lists, beam drop-down, tag drop-down) all off, which are the defaults.
   4. The installed DLLs (Legacy, Net8, Modern; product version `1.0.126+8de95c34`) contain `RibbonCommandHubService` and no `CeStrucRibbonContributor`, so the installed build draws its own "CE STRUC" tab only. **This answers card TRUST-S1 section 6 item 1:** the builder this PR changes is the live one.
3. **Would a moved button fail it? Mostly yes, with one gap.** The pin is read from the test's own copy of today's builder (`TodaysPanels`, `RibbonCommandHubServiceTests.CoreTab.cs` 38-63), not from the shipping method. So a button moved by the shared helpers, the panel order or the command list fails it. A change made only in the shipping method's own lines is caught only through the eight text fragments the second test checks (`TodaysTab.cs` 363-377), and `.GetVisible(includeExpert: true)` is not one of them: dropping expert buttons from the shipping tab would pass. Add that fragment. The pin does not hold tooltips, pictures or the greyed state; the diff does not touch those.
4. **Today's tooltips kept: YES** for both layouts. Core buttons are made by the same `BuildButton`, whose tooltip comes from the command list (`RibbonCommandHubService.cs` 1025-1048); the core tab only adds a "Known fault" line to six of them. But see item 2.2: the button words change.
5. **Any button dead on an AutoCAD year it is shown on: NONE found, by reading.** Every core command's `[CommandMethod]` is in a file with no `#if` (RafterJoist, BeamPlacement, BeamInsidePoint, SupportBlock, Bracing, LegacyPort, Admin, CeSettings command files), and none of those files is in the project's compile exclusions. The only "needs AutoCAD 2027" list holds CEARCHREVIEW (`RibbonCommandHubService.cs` 614-619), not in the core list, and core buttons go through the same greying code anyway. CE Blocks gives AutoCAD's "Unknown command" on a PC without Manager, the same as today's tab.
6. **The four failing IL tests: very likely not caused by this change, but not checked as claimed.**
   1. The names given are truncated (`CompiledProductionRoute_R17...` and `CompiledProductionRoute_R8...`). Those families are in `SbeamEditAutoCadEvidenceReaderCompiledExactProof.cs` 335-399 (R8) and `SbeamEditAutoCadEvidenceReaderCompiledR11Proof.cs` 2292-2369 (R17). They analyse the compiled code of the steel section edit reader only; the message "R4 current database comparison/result flow mismatch" counts branches inside that reader (`SbeamEditAutoCadEvidenceReaderCompiledFlowProof.cs` 561-571). This PR touches no steel section file, so by what they cover they cannot be affected.
   2. But the claim "they predate this change" rests on the 31 Oct report, which names a different test (`CompiledProductionRoute_BindsRealEntryNativeProtectionDirectStorageAndC0`, same R4 message) on an older line, and the PR says they were "not re-run on 8de95c34 itself". RULES 6.1: compare the actual names.
   3. One of the R8 tests reads release builds of all three years from the worktree's own bin folder (`...CompiledExactProof.cs` 346-351); a missing or stale build there fails it whatever the code says.

## 2. FIX FIRST

1. **Software and plan words in tooltips a drafter reads.** `CeStrucCoreRibbonList.cs` line 31 (R1: "BUG-584; a fix is in the installed code but nobody has proven it in AutoCAD"), 49 (DS: "card S3 is not in yet; the support block fault bites only when ..."), 53 (C1: "BUG-501, card S3"), 60 (SC2: "BUG-975"), 78 (CLEAN: "card S2"), 81 (CESETTINGS: "card S2"). Plain-English rule: no bug numbers, card names or "code" in what a drafter reads (the same finding as PR 2038's Front Overflow tooltip). Say the fault in drafting words only. The test `CoreTab_FaultsAreInTheTooltip_InPlainWords` checks only that "Known fault: " is there; make it also refuse "BUG-", "card " and "code". `PENDING_TESTS.md` TRUST-S1 row 5 expects "plain words" and would fail on today's text.
2. **20 of 27 buttons get new words, and their own tooltip keeps today's.** The core list gives every button its own label; the tooltip title stays the command list's label. They differ on R1 (Rafter Marks / Rafter Marker), P1 (Purlin Marks / Purlin Marker), 1, 2 and 4 (Regular beam / Beam Regular and so on), BDL (Beam pair / Beam Dual Layer), BSET, BSETLIST, BSETRESET, DS, DS1, TS1, C2 (Column type / Column Type Picker), SC1, FJ1 (Joist marks / Floor Joist Marker), AB and BB (A bracing / A-Bracing), ABS, CLEAN (Clean and save / Clean), CEHELP (Help / Command Help), CESETTINGS (Settings / CE Settings). The card asks only for the beam types in words (decision 4; sort question 3 recommends "Beam, Lower beam, Special beam, Offset", not this PR's "Regular beam ... Beam offset"). Fix: today's words on every button except the Beam group (pass no label), or list each rename as a "DRAFT default, Tim to confirm". "Clean and save" is new wording on the one tool whose open fault is that its words disagree with what it does (card S2).
3. **Name the four failing tests in full and run them on `8de95c34`** in the same worktree, so "they fail without my change" is a check, not an inference (item 1.6).

## 3. Worth knowing

1. **Not built, as the PR says:** the Settings row for the switch (card section 3.1, and the Settings-first rule), the pull-down menu made from the same list (card section 2.5; 2022 to 2024 colleagues see only the menu), the hosted tab (not used by the installed build, item 1.2.4).
2. **The robot's way to turn it on** (`PENDING_TESTS.md` TRUST-S1 row 2) edits "the Structural settings file". Say a test Windows login or the Structural settings-folder override, never Tim's own file.
3. **28, not the card's 27:** CE Blocks is added (CE Blocks card answer 3) and listed as a DRAFT default. Fine.
4. **The switch is read at the first ribbon build and kept.** If Settings were not loaded by then it would stay off for the session; not checked.
5. **No client name, job number, street or suburb** in the diff.

## 4. Not checked

1. Not built or run by me; the lane's tests not re-run.
2. The look of the core tab (Codex), the net48 and net8 test lanes, AutoCAD 2022 to 2026.
