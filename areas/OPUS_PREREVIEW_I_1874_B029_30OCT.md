# Opus pre-review I: PR #1874 (B-029, BUG-1096 with BUG-1098), rainwater reuse boxes in CDDESIGN (Fri 30 Oct 2026)

Independent, read-only review of head `d1f3cb401d7e22025dd68ae7c8df9a4be252b285` (branch `fb/bug1096-reuse-boxes`) on base `claude/rel-20261026z` @ `09126560`. Head checked against GitHub: it matches. I built nothing, ran no tests, opened no AutoCAD and changed no repository file. Every claim below is from reading the code at that head.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE.** The boxes and the Kingston fix are sound, and the page does not scroll. But on the drawing the change is close to invisible today, so it is not a fix you will see yet.
2. **Your Manningham example cannot appear in CDDESIGN.** All three councils that have a reuse rule (Manningham, Kingston, Casey) are councils that give you the permitted discharge, and CDDESIGN has nowhere to type it. On those jobs the sheet says "no detention storage figure" and shows no credit. Kingston's 6,000 L tank showing 1.00 m³ is proved only in the unit tests.
3. **Where a storage figure does exist** (Frankston, Darebin, Whitehorse and the other councils CE works out itself), a typed tank gives "NEEDS CONFIRMATION (Unknown), no credit taken" and the full storage stands. That is safe: nobody gets a smaller tank by mistake.
4. **A second chat fixed the Kingston credit too.** Draft PR #1817 (Codex, 26 Oct) changes the same file in a different way and adds a second Kingston switch. Only one can go in. My recommendation: keep #1874 and close #1817 as replaced.
5. **One question for the questions chat, not for now:** "May CDDESIGN get one optional box for the council's permitted discharge?" Without it BUG-1096 can never pass its own AutoCAD check. My recommendation is yes.
6. **Not proven:** nobody has looked at the window, at 100 % or at 150 % scaling. Nothing has been run in AutoCAD. The robot case in the author's report would fail on a dash character before it tested anything (DETAIL 6).

---

## DETAIL

### 1. The new page layout: no-scroll rule, cockpit test, plain English

1. **No scroll bar is added.** The Areas and route page is a plain two-column grid with no scroll area: `Modules/Drainage/Dialogs/CivilDesignWindow.xaml:189-224` (left column `*`, right column `Auto`). The reuse group is a fixed 360 wide with a 32 margin (`:215`). It collapses entirely when the switch is OFF (`Visibility` bound to `ReuseBoxesVisible`, `ViewModels/CivilDesignWindowViewModel.cs:689`). The author's report says an earlier attempt wrapped the page in a scroll bar. That is gone at this head (checked: no `ScrollViewer` in the tab).
2. **Width at 100 %.** The window is fixed at 1280 × 800 and cannot be resized (`CivilDesignWindow.xaml:2`, `ResizeMode="CanMinimize"`). The right-hand council panel takes 350 + 14 (`:29-33`). By my reading that leaves the tab about 860 wide. After the 22 margins, the left column is about 420 and the reuse column about 390. Every field fits. The hint texts use the shell hint style, which wraps (`Themes/CivilEditorShellTheme.xaml:71-75`), so nothing is cut off sideways. The job-mode explanation and the "Suggested: ... CE found <file>" line now wrap onto two or three lines instead of one, because the left column is half as wide as before.
3. **Height at 100 %.** By estimate the left column is about 400 to 430 high and the reuse column about 270. The space inside the tab is about 530. **It fits by estimate only: nobody has looked at it.** If the left column ever grows past the tab, it will be **cut off at the bottom, not scrolled**. The page has no scroll area, and the last field is "Head on the orifice".
4. **150 % scaling on a laptop.** 1280 × 800 at 150 % needs 1920 × 1200 screen pixels. A 1920 × 1080 laptop at 150 % has about 1280 × 690 usable, so the bottom of the CDDESIGN window (its 78-high button row) is off the screen. **That is true before this PR and on every CDDESIGN page.** This PR neither causes it nor fixes it. No scroll bar appears at 150 % either: the window is simply taller than the screen. I could not verify any of this by looking.
5. **Cockpit test.** The layout is the same on every open. It changes only when the Settings switch changes, never with the values typed. Good. One weakness: the group carries a permanent grey hint of about 230 characters, four lines in 360 width (`CivilDesignWindowViewModel.cs:697-699`). The cockpit rule says no repeated hints. **Suggest cutting it to one line:** "Optional. Shown on the result beside the storage, never taken off it."
6. **Plain English.** The new labels are plain: "Reuse tank size (litres)", "Roof connected to the tank (m²)", "Plumbed for reuse (toilets or year-round demand)" (`CivilDesignWindow.xaml:216-222`). Small leftovers on the Results text:
   1. **"Method: none"** is printed on a no-credit section (`Services/AutoDesignOrchestrator.cs:309`).
   2. **The council's internal id in quotes,** for example "Council 'frankston' has no reuse-credit rule in the rulebook." (`Services/ReuseCreditService.cs:74`). This sentence existed before, but it now reaches the sheet.
   3. **"Gross SSR / Net SSR (if claimed)".** These are existing words, defined on the same sheet as "Site Storage Requirement (SSR)".
   None of these blocks a merge.

### 2. The Kingston credit, 1.50 to 1.00 m³ for a 6,000 L tank

1. **Where it comes from: hard-coded, with a door left open for data.** The numbers are constants in code: `Services/ReuseCreditService.cs:38-42` (2,000 L minimum, 500 L credit, 2,500 L step, 1,000 L credit, 50 m² roof). They are used only when the council profile carries no `reuseCredit` rule (`:113`). A profile rule wins (tested, `Bug1096ReuseBoxesTests` "AProfileRuleWins"). The shipped `council-profiles.json` carries **no** `reuseCredit` for any council (grepped at this head and at both trains), so the built-in numbers are what runs. The source is `docs/workflows/COUNCIL_KINGSTON_ISSUE5_2025.md:42-48` ("500 L of storage for each 2,000 L tank, or 1,000 L for tanks of 2,500 L or greater", single dwellings only). The PR's reading matches that source.
2. **This falls short of BUG-1098's own "Expected".** The carpark says "stored as council-profile data (R-00)" (`C:\CE_PLAN\BUG_CARPARK.md`, BUG-1098). The old per-block rule was also hard-coded, so this is no step backwards. But it is not the R-00 finish, and that should be a follow-up.
3. **Switch or data:** both. The rule kind `tiered` is data-shaped (`Models/CouncilProfileModels.cs` new fields `minTankL`, `lowCreditL`, `highTankL`, `highCreditL`). Which Kingston rule runs is chosen by the switch `detention.rainwaterReuseBoxes` (`Models/UserSettings.cs:2614-2615`), passed as `ReuseKingstonCouncilTiers` (`Services/CivilDesignService.cs:170`). OFF hands no tank to the engine at all (`CivilDesignService.cs:248-256`), so with OFF, CDDESIGN is exactly as before.
4. **Other councils: unchanged.** `LegacyRule` changes only the `kingston` case (`ReuseCreditService.cs:113`). Manningham and Casey are untouched, and the test "TheOtherCouncils_AreUnchangedByTheKingstonFlag" pins this. The only caller of the reuse engine in product code is CDDESIGN (`CivilDesignService.cs:169` is the only place a `ReuseTank` is set; grepped).
5. **Saved jobs and CDRULES.** No CDRULES run goes Stale:
   1. The switch sits in the `detention` group, not `designStandards`.
   2. The criteria fingerprint is built from the office design standards and the council profile (`Rules/RulebookValues.cs:300-311`), and the whole `reuseCredit` block is already left out of it (`:332`). So even a future profile rule for Kingston would not turn saved runs stale.
   3. The three boxes are not saved in the drawing, so no saved job changes.
6. **Council sweep parity tests:** `CouncilSweepParityTests.cs` has no reuse content and this PR does not touch it. The shipped council file is unchanged, so parity cannot move.
7. **Behaviour note, not a defect.** The tiered rule does not look at the "plumbed for reuse" tick (Kingston's text does not ask for it). It credits with a note "confirm this job is a single dwelling with its own tank" (`ReuseCreditService.cs:233`) rather than refusing. On a shared apartment tank Kingston gives nothing, so the sheet's "Net SSR (if claimed)" would be optimistic there. The design itself still uses the full storage. #1817 took the stricter line (DETAIL 5.3).

### 3. The "needs confirmation" wording

1. **Plain English:** yes. On the sheet it reads "Credit: NEEDS CONFIRMATION (Unknown) — no credit taken", then "Net SSR: x.xx m3 (the gross figure stands)" (`AutoDesignOrchestrator.cs:311-315`). There is one "Watch out:" line naming the council by its proper name (`:161-162`), and a note "ask the council how a reuse tank is credited" (`ReuseCreditService.cs:75`).
2. **It appears only when it should.** It needs a tank typed, a storage figure above zero, and a council with no rule (`AutoDesignOrchestrator.cs:156-162`, `ReuseCreditService.cs:70-77`). A council that has a rule never says it, even when it gives no credit (test "ACouncilThatHasARule_NeverSaysNeedsConfirmation").
3. **Could it make a result look final when it is not?** No: it errs to the safe side. The storage stands in full, and the word "Unknown" is on the credit line. The one repetition worry is cockpit noise. The drafter reads the same fact four times: the Watch out line, the Credit line and two Notes. Acceptable on a reading page, but the second Note could go.
4. **The opposite case is the one to watch.** Where a credit IS worked out (Manningham, Kingston, Casey with a storage figure), the sheet prints "Net SSR (if claimed)" with the approval note "typically requires council approval — confirm before relying on the net SSR" (`ReuseCreditService.cs:44`, added by `Credited`). That path is reachable today only in the unit tests (DETAIL 4).

### 4. The limit: councils that give the permitted discharge

1. **There are more than five such councils.** At the base, eight profiles have `psdMethod: council-provided`: Kingston, Bayside, Monash, Boroondara, Manningham, Casey, Growth Areas and Port Phillip (`Assets/Config/council-profiles.json:19, 224, 278, 509, 744, 866, 924, 977`). Open PR #1854 adds Cardinia, Brimbank and Dandenong. The author's "five" undercounts.
2. **What CDDESIGN shows today on those councils.** CDDESIGN never passes a permitted discharge (`CivilDesignService.cs:147-173` has no `CouncilProvidedPsdLps`; grepped the window, model and service). The engine therefore returns no storage (`Services/AutoDesignService.cs:191-212`), and the sheet prints "Site Storage Requirement (SSR): not sized" (`Services/DesignProposalReport.cs:231-233`). With a tank typed, the result adds one Watch out line: "Reuse tank entered, but there is no detention storage figure to credit yet (the permitted discharge is not known, or detention is switched off). No reuse credit has been worked out." (`AutoDesignOrchestrator.cs:164-169`).
3. **Can a drafter be misled into a wrong storage figure?** Not into a wrong number: no storage and no credit are printed, and nothing is invented. The real risk is a wasted trip. Every council with a recorded reuse rule is council-provided, so **no council can ever show a reuse credit figure in CDDESIGN at this head**. A drafter on a Manningham job types a tank and the roof, gets only the Watch out line, and may assume the tool is broken. Or they may work the credit by hand without the 50 m² or 2,000 L checks.
4. **Smallest safe guard: one wording change, no new box, no layout change.** When the reason is that the council provides the permitted discharge, say so by name instead of "not known, or detention is switched off". For example: "Reuse tank entered. Kingston gives the permitted discharge and CDDESIGN has no box for it yet, so there is no storage figure and no reuse credit. Take the council's figure from its letter and work the credit by hand." The information is already there, because the proposal carries `PsdUnknown`. Keep "detention is switched off" as a separate sentence for that case.
5. **Tim's approval was given on this example.** Decisions 29 Oct item 39 quotes Tim: "yes. On a Manningham job a 3,000 L plumbed tank credits 1.50 m³ and today the sheet shows none". The BUG-1096 carpark test says "unit case through CivilDesignService: Manningham inputs must produce a 1.50 m3 credit line". The PR proves 1.50 / 8.50 only through the engine with a permitted discharge of 6.0 L/s supplied (`Bug1096ReuseBoxesTests.cs:73`), not through CivilDesignService. **BUG-1096 cannot reach its own acceptance step until a permitted-discharge box exists.** The author says so plainly, and that is correct.

### 5. Clashes with the open trains and the council PRs

I checked this by a read-only three-way merge (`git merge-tree` old form, nothing written) of the PR head against each head as fetched on 30 Oct.

1. **`claude/rel-20261030a` @ f5dd72a0 (C-77, 3.0.87) and `claude/rel-20261102a` @ 91963bd0 (C-78; it contains 1030a).** Two textual conflicts, both mechanical:
   1. **`Models/UserSettings.cs`.** The new `rainwaterReuseBoxes` block lands right beside the doc comment that GB-01 slice 1 (#1841) rewrote to "RETIRED" on `minDetentionPipeGradeRatio`. Keep both: the new switch first, then GB-01's retired comment. Take care not to restore the old "Read by CDRULES rule R-32" wording.
   2. **`REGRESSION_LOG.md`.** Top-of-file entries. Keep both.
   `CouncilProfileModels.cs` merges cleanly, because GB-01 adds near line 89 and this PR near line 405. None of the CDDESIGN window, view-model, service or orchestrator files are changed by either train.
2. **#1841 (GB-01 slice 1):** the same UserSettings conflict as above (it is already inside both trains). **#1854 (GB-02 part A), #1855 (GB-03 soakage), #1872 (BUG-1099 council Tc):** REGRESSION_LOG conflict only. Each merges cleanly in `CouncilProfileModels.cs`, `CouncilSweepParityTests.cs`, `council-profiles.json` and `UserSettings.cs`. #1872 changes how storage is sized on computed councils, so it moves the gross figure a credit would be taken from. There is no code overlap, and those councils have no reuse rule anyway.
3. **A real clash that the brief did not name: draft PR #1817** (`cx6/bug-1098-bd29` @ 9688b6b9, base `claude/rel-20261026u`, Codex, 26 Oct). It is a second fix for BUG-1098. It edits the same `ReuseCreditService.cs` and `ReuseCreditModels.cs` with a different rule kind (`individualDwellingTank`) and different profile fields (`creditL`, `largerTankL`, `largerCreditL`). It adds a second Kingston switch (`KingstonReuseCreditRule`), writes Kingston's rule into `council-profiles.json`, and adds a Settings page row. Its stricter gate needs "single dwelling" and "not shared" confirmed, and CDDESIGN has no box for either, so through CDDESIGN it would never give a Kingston credit. Merging both would conflict and leave two Kingston switches. It is in neither train and no CE_PLAN record disposes of it (grepped). **Recommendation:** close #1817 as replaced by #1874. Carry its two good ideas into a follow-up: the Kingston rule as profile data (meets R-00 and BUG-1098's "Expected"), and a Settings page row.

### 6. What is NOT proven, and the AutoCAD scenario

1. **Not proven:**
   1. Nothing has been opened in AutoCAD.
   2. The window has never been looked at, at 100 % or 150 %, in light or dark.
   3. The page height is my estimate.
   4. The STORM pre-fill of the roof box has not been seen on a real rating report. It sums the roof of every tank row, so on a two-dwelling job it fills both roofs into one box (`Rules/StormReport.cs:71-72`, `Rules/StormReportOffer.cs:124-125`).
   5. Typed boxes are not saved, so a second CDDESIGN run without retyping silently drops the reuse section.
   6. I did not re-run the author's test counts (20,807 passed, net48 0 errors). I counted 33 test cases in the new file, which matches the report.
2. **Defect in the proposed robot case N100.** The author's report expects the line "Credit: NEEDS CONFIRMATION (Unknown) - no credit taken" with a hyphen. The code prints an em dash, "—" (`AutoDesignOrchestrator.cs:313`, confirmed byte by byte). The case must match on "NEEDS CONFIRMATION (Unknown)" only, or use the em dash, or it fails for the wrong reason.
3. **Scenario for the robot (copies only), on the C-78 line after merge and install:**
   1. **Kingston 600 m² lot.** Set the council to Kingston, enter site 600 m², roof and paved 400 m², land use residential, detention required, then on the Areas and route page tank 6000 and roof connected 150. Choose Work out design. Right looks like: "Site Storage Requirement (SSR): not sized", exactly one "Watch out:" line containing "no detention storage figure", and no "REUSE CREDIT" section. Failing twin: switch `detention.rainwaterReuseBoxes` false gives no such line and no reuse group on the page.
   2. **Frankston 600 m² lot** (CE works out the discharge): same typing, plus "Plumbed for reuse" ticked. Right looks like: a "RAINWATER-TANK REUSE CREDIT" section, a line containing "NEEDS CONFIRMATION (Unknown)", "(the gross figure stands)", and exactly one "Watch out:" line containing "needs confirmation". The SSR figure is the same as with the tank box blank.
   3. **Kingston 6,000 L = 1.00 m³** cannot be shown in AutoCAD at this head (DETAIL 4). It stays a unit-test fact until a permitted-discharge box exists.
4. **Codex look (screenshots needed):**
   1. The Areas and route page at 1280 × 800 at 100 %, light and dark: two columns, nothing cut off at the bottom, the hint wraps.
   2. The same on a 1920 × 1080 screen at 150 %: report whether the window's own button row is reachable. This is a long-standing problem, not one this PR made.
   3. Switch OFF: the group is gone and the left side fills the page.
   4. After a STORM rating report with a tank row: the roof box is filled and the command line says "Roof connected to a tank set to ... m2".

### 7. Verdict

**KEEP-WITH-NOTE.** The code is careful: OFF is exact, no figure is invented, the storage is never reduced, nothing goes stale and the tests are good. The notes:

1. **Settle #1817 first.** Close it as replaced by #1874, and never merge both.
2. **Change the no-storage Watch out line** to name the council and say it gives the permitted discharge (DETAIL 4.4). Optionally shorten the group's hint to one line.
3. **Fix the robot case wording** (the em dash).
4. **BUG-1096 and BUG-1098 stay OPEN.** Neither can pass its own AutoCAD step until CDDESIGN has a permitted-discharge box. Send that one question to the questions chat (recommend yes).
5. **Follow-up:** move Kingston's numbers into the council profile (R-00), taking the approach from #1817.

**Train:** not 3.0.87 (C-77, `rel-20261030a`) and not the finalised C-78. It fits the next train built on the C-78 line (`claude/rel-20261102a` final head), alongside #1872. Resolve the UserSettings conflict by keeping GB-01's "RETIRED" comment.
