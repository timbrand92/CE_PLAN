# Opus pre-review G: PR #1872 (B-018, BUG-1099 council detention Tc), Fri 30 Oct 2026

Independent read-only review, Opus 5.5, about 17:45 Melbourne time (shell clock). No repository file changed, no build, no test run, no AutoCAD, no push. The only git actions were a read-only fetch, `git show`/`git diff`/`git log`, and `git merge-tree --write-tree` dry runs, which change no branch, index or working copy. Reviewed head `336bc513b193959db02df8073fc54c42ee8b58b4` (it matches GitHub: draft, open, base `claude/rel-20261026z`).

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE.** The council figures are right and come from the council write-ups: Maroondah's lot-size table (6, 7, 8, 9, 12 min), Boroondara 15 min, Maribyrnong 10 min. No other council's answer moves.
2. **What you would see:** on a bare 600 m² Maroondah lot the permitted discharge drops from 5.18 to 4.29 L/s, so the tank gets bigger. The pipe flows stay the same. The council's figure is 3.68 L/s, so CE is still about 17% high (it was 41% high). The other half of the fix (the council's own before-development C) is not built.
3. **It needs your word, not just a test.** This is a council engineering value, and your "yes" to question 21b was a GUESS read from your pasted example (decisions file, item 38). Until you say yes, it can be built and robot-tested but not accepted.
4. **It will not merge on its own.** On today's C-77 and C-78 lines it clashes in three places with the 1 in 200 detention-grade change (#1841). All three are "keep both sides". One checksum needs a new value, which I worked out below.
5. **Two small gaps to record, not fix now:** (a) on Boroondara and Maribyrnong jobs, a saved CDRULES run will show Stale once after install, which the report does not say; (b) Yarra Ranges is named in the BUG-1099 title and has the same lot-size table on file, but this change leaves it at 5 min.
6. **Nothing is proven in AutoCAD.** It is built and unit-tested only, and only on the old C-75 code. The robot case is at the end of section 4.

---

## DETAIL

### 1. Are the three councils' Tc values right, sourced, and not hard-coded?

1. **Maroondah: right.** `council-profiles.json` line 839 sets `"detentionTcFromLotAreaTable": true`. It reads the table already stored at line 838: `{"0":6,"350":7,"500":8,"750":9,"4000":12}`. That matches the write-up `C:\CE_PLAN\02_COUNCIL_RULES\COUNCIL_MAROONDAH_GUIDELINES.md` lines 95 to 101 (≥4000 12, ≥750 9, ≥500 8, ≥350 7, <350 6). The provenance at line 859 is "Sourced", and it points to Council Table 2, write-up section 4.
   1. The write-up's sixth row, "High density unit developments 5" (line 102), is not used. The note text at `Rules/CouncilRuleValues.cs` line 199 tells the drafter that CE reads the whole site as one lot. That is honest, but on a high-density Maroondah job CE will use the table and get 6 to 12 min, where the council says 5.
   2. The lookup is the existing `CouncilRuleValues.TimeOfConcentration` (line 142). It takes the largest threshold that does not exceed the lot area. Tests pin the edges at 349.9 to 6, 350 to 7, 499 to 7, 500 to 8 and so on up to 4000 to 12 (`Bug1099CouncilDetentionTcTests.cs` lines 43 to 52).
2. **Boroondara 15: right.** It is at `council-profiles.json` line 520, with Sourced provenance at line 557. The write-up `COUNCIL_BOROONDARA_GUIDELINES_2017.md` line 36 quotes the council: "Tc = 15 minutes", for all locations. Line 189 says the same.
3. **Maribyrnong 10: right.** It is at `council-profiles.json` line 1173, with Sourced provenance at line 1203. The write-up `COUNCIL_MARIBYRNONG_GUIDELINES.md` lines 20 to 21 and 89 give a pre-development "Time of Concentration (tc) 10 minutes". The write-up's other set (5/7/9 pipe-design minimums, line 31) is correctly not used.
4. **Pipe Tc not moved:** `tcMinutes` stays at 5 for all three. The test is at `Bug1099CouncilDetentionTcTests.cs` line 229. The pipe-flow code does not read the new fields: a source guard checks this at line 233, and `RationalFlowService.cs` line 386 still reads `councilProfile?.TcMinutes`.
5. **Hard-coded? No engineering value is hard-coded.** All three figures live in the council file. The only fallback is the office Tc, which `RationalFlowService.OfficeDefaultTcMinutes` (lines 70 to 75) reads from Settings `detention.defaultTcMinutes`. The C# holds only the note wording.
6. **Switch:** `detention.councilTcForStorage` is at `Models/UserSettings.cs` lines 2540 to 2541, default `true` (ON). `CouncilRuleValues.CouncilTcForStorageIsOn` (line 162) reads a missing settings group as ON. With the switch OFF, the chooser returns exactly the old Tc. I checked this by reading lines 175 to 186 against the old expressions at `DetentionSizingService.cs` 323 and `AutoDesignService.cs` 419 on base `09126560`. It agrees for a missing council, a council Tc of 0, and the Kingston site-case Tc. The test at line 161 pins OFF against the old figure to 1e-9.
7. **Settings-first (R-00):** the switch is in the settings file only, with no Settings page row. The report says so (item 6), and the same is true of the other recent switches. This is a known, recorded deviation, not something new here. I did not check whether the council file's figures can be edited from any Settings page.

### 2. Does it change any other council's results?

1. **Not by design, and the code agrees.** The chooser only returns a different figure when a profile carries `detentionTcFromLotAreaTable: true` or `detentionTcMinutes`. Only Maroondah, Boroondara and Maribyrnong carry them, on both the PR head and the merged trees (checked by grep). The other 19 councils are swept ON and OFF across every land use and several site areas (test at line 85, which asserts 19 councils).
2. **Kingston:** its commercial site-case Tc (7 min) still wins, because the chooser checks `site.TcMinutes` first (line 182; test at line 109).
3. **Yarra Ranges: unchanged, but this needs a note.** Its profile already holds a lot-size Tc table (`council-profiles.json` lines 1135 and 1148, office ruling "Tim CP-06"). Its own `tcMinutes` note at line 1127 says "use lot-size table, never this scalar for the site". The BUG-1099 title in `BUG_CARPARK.md` line 14897 names "Maroondah and Yarra Ranges".
   1. The report's line "no write-up exists" is true of `02_COUNCIL_RULES`. The file `COUNCIL_YARRA_DDG.md` there is the City of Yarra, a different council, although its table is identical (lines 38 to 47).
   2. Leaving Yarra Ranges at 5 min is the safe choice: whether that table is a detention Tc or a pipe Tc is Tim's call. But BUG-1099 stays open for Yarra Ranges as well as for the before-development C half, and the carpark entry should say so.
4. **Darebin:** unchanged. Its single Tc of 10 min still sizes both the pipe and the permitted discharge. This existed before and the report flags it.
5. **Saved CDRULES runs go Stale once on three councils (not stated in the report or the log).**
   1. The CDRULES fingerprint serialises the whole council profile (`Rules/RulebookValues.cs` lines 300 to 311).
   2. The fingerprint already leaves out fields that only the detention sizer reads (`orificeMethod`, `orificeFormulaK`, `reuseCredit`, `pumpStormAri`, lines 330 to 333). The two new fields are not on that list, and their new provenance entries are counted too.
   3. Effect: once installed, a saved CDRULES run on a Boroondara or Maribyrnong job shows Stale once and needs re-running. Maroondah goes Stale on the train anyway, because #1841's `detentionGuideGradeN` is a CDRULES value.
   4. This is harmless and other councils are untouched. It is still inconsistent with the "kept out of the fingerprint" rule. Either add the two names to that list (Int068 fingerprint tests then need re-running) or write it in the log.
6. **Council sweep tests:** `CouncilSweepParityTests` adds the three fields to the sourced-change allow-list. `KingstonStormFrequencyTests` moves three checksums. I recomputed all three new checksums independently and they match the PR (section 3, item 4).
7. **Interaction with BUG-1095 (council minimum C, already in the train):** that change replaces the developed catchment with a single surface of the same total area (`AutoDesignService.cs` on `rel-20261102a`, about line 103). So the lot-size lookup sees the same site area.
   1. The BUG-1095 tests on the train compare ON against OFF, and pin the C. They pin no absolute permitted-discharge figure for Boroondara or Maribyrnong. I expect them to pass, but I have only read them, not run them.
8. **The #1841 / #1854 / #1855 clash:** #1854 and #1855 are in neither train (no `cardinia` profile on `rel-20261102a`; no `claude/rel-20261030b` branch on origin). The clash for #1872 is with #1841 alone, and the next section has it. If C-77b lands #1854/#1855 later, #1872 will clash again in the same three spots: the allow-list, the checksum dictionary and the log. #1854 also moves the checksum list to 27 entries. Every one of those is resolved by keeping both sides.

### 3. Does the base matter? Will it go onto `claude/rel-20261030a` (C-77, 3.0.87) or `claude/rel-20261102a`?

1. **Ancestry:** the base `09126560` (C-75, 3.0.85) is an ancestor of both trains. `rel-20261102a` (`91963bd0`) contains `rel-20261030a` (`f5dd72a0`, "Version: Civil 3.0.87"). The PR has never been compiled or tested on C-76, C-77 or C-78 code.
2. **Dry-run merge (`git merge-tree`) gives the same result on both trains: 3 conflicting files, 8 clean.**
   1. **`CouncilSweepParityTests.cs`, about line 45:** #1841's four `detentionGuideGradeN` entries and #1872's three detention-Tc entries are added at the same spot. Keep both, and put a comma after `"maroondah/detentionGuideGradeN"`.
   2. **`KingstonStormFrequencyTests.cs`, about line 293:** both sides changed the Maroondah checksum, and #1841 also changed Manningham. Keep the train's Manningham line (`EF2BEE6D...`). **Neither side's Maroondah value is right after the merge.** I worked out the merged Maroondah value: **`179905094CF0170269C84AA49AC281A6B3D5835BADA47C4AEA6D91BEE21471D0`**.
      1. How: a Python copy of the test's `HashOf`, compact JSON with SHA-256. It reproduced every pinned value I checked: the PR's 2D88.../FD27.../BAD4..., C-75's 301E.../AF4E.../1FC9..., and the train's DCC8.../EF2B....
      2. The same value comes out on both trains. Boroondara (`FD273C31...`) and Maribyrnong (`BAD45DE0...`) keep the PR's values.
      3. Only the C# test itself can prove it.
   3. **`REGRESSION_LOG.md`, line 1:** both sides add entries at the top. Put the PR's entry on top, then one blank line.
3. **Clean merges I checked by reading:**
   1. `CouncilProfileModels.cs`: the merged tree has `DetentionGuideGradeN` at line 98 and the two new fields at lines 212 and 219.
   2. `council-profiles.json`: the merged Maroondah block has both `detentionGuideGradeN: 200.0` (line 842) and `detentionTcFromLotAreaTable: true` (line 846), and it parses.
   3. `AutoDesignService.cs`: merges cleanly with BUG-1095.
   4. `CouncilRuleValues.cs`: merges cleanly with BUG-1095's new method.
   5. `DetentionSizingService.cs`: not changed on the train.
4. **Which line to take:** `rel-20261030a` is already versioned 3.0.87, so adding to it would mean re-cutting a finished train. `rel-20261102a` (C-78) is the natural home, or the train after it. The conflicts and the checksum are the same either way.

### 4. What is NOT proven, and the AutoCAD scenario

1. **Not proven:**
   1. Any AutoCAD behaviour, and what the CDDESIGN notes look like on screen.
   2. The Council source window labels (`CouncilSourceViewModel.cs` lines 22 to 23).
   3. Storage volumes: tests show only that storage goes up (test line 181), not by how much.
   4. The before-development C half (3.68 L/s).
   5. Maroondah's high-density 5 min case, and multi-unit "average lot size".
   6. Yarra Ranges.
   7. Every result on C-76/77/78 code: the PR's 69 focused and 20,798 full test passes are on the C-75 base.
   8. The merged Maroondah checksum (computed outside C#).
   9. net48 behaviour (compiled only).
2. **4.29 against 4.30:** the arithmetic is 0.35 × 73.63 × 0.06 / 0.36 = 4.295. The test checks within ±0.01 (line 151), so it cannot tell 4.29 from 4.30. The report's "corrected it" claim is therefore not proven either way. The difference does not matter to the result.
3. **Agreed-design record:** `Rules/AgreedDesignRules.cs` lines 104 to 106 still record the council's single Tc (5 min). Its own comment (lines 87 to 93) says it follows "the same order the design engine uses", and that is no longer true for these three councils. So the agreed-design panel will say Tc 5 min for a Maroondah job whose permitted discharge was worked at 8. Turning the switch on or off is not seen as a change. The report admits the first part (log item 6); the panel wording is worth a carpark line.
4. **Robot scenario (case `N99_dp_tc`, on the installed train build, copies only):**
   1. Open a copy of a Maroondah job. Type `CDDESIGN`. Set site area 600 m², roof (hard area) 400 m², 1 in 5, and no council-provided figure.
   2. Read the permitted discharge line and the notes. **Right:** the permitted discharge is lower than in the control run. The notes carry "Maroondah's own detention time of concentration, 8 min ... The pipe flows keep the 5 min Tc." Q minor, Q major and the connection pipe size are identical to the control run.
   3. **Second step, same session:** change the site area to 900 m². **Right:** the note says 9 min. This also proves the table reads the site area and not the 400 m² roof, which would give 7 min.
   4. **Maribyrnong copy:** the same inputs. **Right:** the note says 10 min.
   5. **Control `N99_dp_tc_off`:** set `"councilTcForStorage": false` in the `detention` group of `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` before AutoCAD starts. Repeat step 1. **Right:** the figures are exactly the ones 3.0.87 gives, and there is no detention-Tc note.
   6. **Boroondara copy:** type a council figure of 3.0 L/s. **Right:** 3.0 L/s is used and there is no Tc note.
   7. **Optional:** run CDRULES on a saved Boroondara job and expect Stale once (section 2, item 5).
   8. Acceptance still needs Tim's word on 21b, because it is an engineering value (RULES 4.5).

### 5. Verdict

**KEEP-WITH-NOTE.** Take it into `claude/rel-20261102a` (C-78) or the next train, not the finished 3.0.87 line. The note:

1. **Merge:** resolve the three hunks by keeping both sides. Set the Maroondah checksum to `179905094CF0170269C84AA49AC281A6B3D5835BADA47C4AEA6D91BEE21471D0`. Then run the focused set on the merged tree: Bug1099, CouncilSweepParity, KingstonStormFrequency, Gb01Slice1Falls, CouncilMinimumCBug1095, Int068 fingerprint and warnings, C78NewSwitchDefaults. Then run the full Civil net10 suite and the net48 compile. The PR has never run on C-76 or later code.
2. **Stale CDRULES runs:** either add `detentionTcMinutes` and `detentionTcFromLotAreaTable` to the CDRULES fingerprint's "kept out" list (`RulebookValues.cs` lines 330 to 333), or state in the log that saved CDRULES runs on Boroondara and Maribyrnong jobs go Stale once.
3. **Carpark:** BUG-1099 stays OPEN for three things: the before-development C half; Yarra Ranges (its table is on file, and whether it is a detention Tc is Tim's call); and Maroondah high-density at 5 min. Also add a line for the agreed-design panel still showing the pipe Tc.
4. **Tim's word:** the install report must say plainly that 21b was read as yes (GUESS). It counts as accepted only on Tim's word, because it is a council engineering value.
