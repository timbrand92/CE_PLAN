# Opus pre-review, group C (Thu 29 Oct 2026, 21:50 Melbourne; job B-043a, CE 01)

Read-only code read. Nothing was built, run, installed or opened in AutoCAD. No PR was commented on, edited or closed.
PRs covered: #1840, #1844, #1845, #1848, #1851, #1852, #1853, #1854, #1855 (every open PR numbered 1851 or higher at 21:46; none newer existed).
No draft PRs for BUG-1088, 903, 1192, 905, 1097, 1099, 866 or 902 were open at 21:46, so none are reviewed here.

## FOR TIM

1. **Answer first: seven PRs are fine to carry with a note, one is fine as is, and one should be fixed first.** The one to fix is #1851, the new "minimum pit depth" check.
2. **#1851, minimum pit depth (FIX FIRST):** the new check has no off switch of its own. Every CDRULES run will gain a "Minimum pit depth" row for every pit, and the only way back is to take the code out.
   - It can also show a green pass when it does not know the pipe wall. Example: a UPVC 450 into a pit 760 mm deep passes, but with the 31 mm wall it needs 781 mm and should warn.
3. **#1848, cover measured to the outside of the pipe (keep, with notes):** the sums are right. Lid 10.000, invert 9.200:
   - UPVC 225: cover was 575 mm, now 555 mm.
   - Concrete 375: cover was 425 mm, now 380 mm.
   - Note 1: only those two sizes have a wall figure. Every other pipe (a UPVC 150, say) is still measured the old way, and can show a green pass. It should show "Unknown" instead.
   - Note 2: CD's own screens (the levels proposal, the cover tick in New Pipe) still use the old measure. So the same concrete 375 can show "320 mm cover" in CD and "275 mm, below 300" in CDRULES until B-022 lines them up.
4. **#1852, council minimum runoff C (keep, with a note):** correct. On a 600 m² site in a council with a 0.80 minimum and a calculated C of 0.70:
   - CDDESIGN storage goes from 2.84 m³ to 3.75 m³.
   - The permitted discharge stays at 4.45 L/s, because the before-development C is never touched.
   - Note: the robot's "switch off" control expects Boyd's to read 0.70. With today's settings it reads 0.767, because roofs count as 1.0. Fix the expected numbers first, or the robot will report a false fail.
5. **#1854, council data (keep, with notes):** I found no mistyped number.
   - Port Phillip now makes CDDESIGN size a tank (about 2.4 m³ on a 600 m² site) where it used to show nothing. The log should say this in numbers.
   - Cardinia's method is marked "sourced" when the log says "assumed".
6. **#1844, starting settings for a new colleague (keep, with a note; already waiting on your answer, question 40):**
   - An existing settings file is never touched, even a damaged or empty one.
   - The shipped file holds no folder path.
   - A damaged shipped file falls back quietly.
   - But it also copies your remembered water-tank plan choices. A colleague picking a 3000 L above-ground tank in CDWT would get your "U/G TANK" plan pre-selected, with a line saying they chose it before. They didn't. Recommend leaving those three tank picks out.
7. **#1845, raingarden label RG1, RG2 (keep, with a note):**
   - A locked layer is never unlocked, nothing is written into an Xref, and nothing runs during REFEDIT.
   - But the RG label is plain text, not tied to its raingarden. Move the outline and "RG2" stays behind; erase the outline and the text is left on the plan.
   - Numbers are never reused: draw three, erase the second, draw one more, and you get RG4.
8. **#1853, "no units set" note on import (keep, with a note):** it only adds one line and never changes the scale. Note: the wording "This drawing has no units set" could make a drafter think their own drawing is wrong. "The source drawing…" is clearer, and needs your OK.
9. **#1855, soakage sheet engine (keep, with a note):** nothing a drafter sees changes yet. It reproduces the guidebook's worked sheet exactly (25.35 m³ required at 2 hours, 28.04 m³ provided, 111 %).
   - Before a window uses it: when the soil factor is unknown, the rows show zero soakage and a huge storage. They should show "Unknown".
10. **#1840, wording in the repo instructions (keep):** one sentence. It says any builder can build any item, as you ruled.
11. **What is NOT proven:** none of this was run or seen in AutoCAD. The two pipe wall figures (20 mm and 45 mm) are your "about" figures, not checked against a pipe maker's table.

---

## Method and my own mistakes

1. **Who read what:** six Opus readers each took one PR (or a stacked pair) and read the full diff, the register line, the build report, the Sonnet pre-review section and Tim's rulings. I read #1840 myself.
2. **What I re-checked myself (rule 6.1):**
   - #1851 has no switch of its own and uses `wall ?? 0.0`: `RulebookEngine.cs:145` and `:797` on claude/gb01-slice3-pit-depth.
   - #1848 gives a Pass with an Unknown wall: `RulebookEngine.cs:514` on fb/cover-to-pipe-outside.
   - `boydsUsesHardGroundC` ships false (`UserSettings.cs:2593` on fb/bug1095-council-min-c), which makes the #1852 proof-plan control numbers wrong.
   - The other findings are the readers' code reads, not re-checked line by line by me.
3. **My mistakes:** none affecting the findings. GitHub returned 502 errors twice at the start, which cost a few minutes; I used the REST interface instead.
4. **Not covered:** #1850 (GB-01 slice 2, below 1851) sits under #1851 and was not reviewed here.

## #1840 Docs: AGENTS.md ownership sentence (B-038)

1. **What changes:** one line, `AGENTS.md:119`. "Claude owns behaviour/spine/deploys; Codex owns windows" becomes "any builder can build any item", quoting Tim's 29 Oct words. Acceptance, deploy and one-session-per-file are kept.
2. **Findings:** none. No code changes.
3. **Verdict: KEEP.**

## #1844 F-023 colleague starting settings (B-035; switch settings.firstStartUsesColleagueDefaults ON; waiting on QUESTIONS item 40)

**Tim's three checks**
1. **An existing profile is never touched: confirmed.** "First start" means only that the settings file does not exist (`SettingsService.cs:161`).
   - Empty, damaged, unreadable and older-version files all take the old road: a damaged file is copied aside and the built-in values are used (`:311`).
   - Tests drive the empty and damaged cases through the real start-up load.
2. **No folder path in the shipped file: confirmed.** All 27 lines read. No drive letter, backslash, share, OneDrive or login name. Path-like text is also stripped at load (`ColleagueDefaultsService.cs:68`).
3. **Damaged shipped file falls back: confirmed.** Bad JSON, an empty file, a list, null, a missing file or an unreadable file give the built-ins with one log line. No window, no block.

**Findings**
1. **MEDIUM, `Assets/Config/colleague-defaults.json:21-25`: Tim's remembered CDWT plan picks are exported.**
   - In `WaterTankPlanMatch.Arrange:138` a remembered plan beats the litres and above/below-ground match.
   - Drafter consequence: a colleague picks 3000 L round, above ground. CDWT pre-selects the "U/G TANK" plan and says "The plan you chose before for this tank is selected". They never chose it.
   - The 2000 L round tank is also paired with the slimline caption (2000 x 620 mm). That may be right if the master has one 2000 L plan; not verified.
   - Fix: drop `waterTank.planForTank` from the shipped file, or get Tim's yes on all three pairings.
2. **MEDIUM, scope: only a login that has never run CE gets these values.**
   - If Max's PC already has a settings file, he gets none of them, and the pipe object stays on Automatic, which means held for an ordinary login.
   - Fix: check Max's PC for an existing settings file before C-77; item 63 ("default on for everyone") then needs B-046 (#1846), not this PR.
3. **LOW, `colleague-defaults.json:18`:** `pit.lidType` is read by no code, so "Class A Grate" does nothing. Fix: drop the key.
4. **LOW, `colleague-defaults.json:11`:** text snaps 0 and OSMODE 1151 (instead of 5887 and 5247) are exported; the comparison report flags these as possible leftovers. Fix: Tim's yes on the list (already pending).
5. **LOW, `Models/UserSettings.cs:201`:** the switch is also saved into every user's own settings file, where it does nothing. The real switch is read from the shipped file (`ColleagueDefaultsService.cs:70`). Fix: remove the user-file copy, or say "read from the shipped file only" in its description.
6. **LOW, `ColleagueDefaultsService.cs:71`:** only a JSON false turns it off; a string "false" leaves it on. That is the safe direction. Fix: add a test.

**General checks**
1. **Switch OFF:** gives exactly the old start; a test compares the whole settings object with the plain built-ins.
2. **Switch ON pinned:**
   - The user-file property is pinned through both start-up reads, but that property gates nothing (finding 5).
   - The real gate is pinned by `ShippedFile_CarriesTheSwitchOn` and `KeyMissingFromTheShippedFile`.
3. **REDO, locked layers, Xref, REFEDIT:** REDO is clean: only files are read at start-up. The drawing is not touched.
4. **R-00 and R-27:** met.
5. **REGRESSION_LOG.md:** honest ("not approved by Tim").
6. **CE_SHARED:** unchanged.

**Sonnet claims**
1. **Confirmed:** switch OFF, tests on the real load, existing and damaged files untouched, the dead user-file switch, and personal choices exported.
2. **Overstated:** its CE_LOG_DIR_OVERRIDE risk. `Bug375NoLogOverrideIntoAutoCadTests` already guards it.
3. **Missed:** the CDWT pre-selection (finding 1) and the existing-profile scope (finding 2).

**Verdict: KEEP-WITH-NOTE.** The code is safe. Tim must approve the exported list, especially the three tank picks, and the desk must confirm that Max's PC has no settings file.

## #1845 Raingarden label RG1, RG2 (B-007; switch linking.raingardenTagLabel ON)

**Locked layers, Xrefs and REFEDIT (Tim's check)**
1. **Locked or Xref layer:** GUIDELINES is checked first (`SourcePlacementService.cs:944`). If it is locked or belongs to an Xref, the label is skipped with a warning line.
   - No layer is unlocked.
   - The layer write at `:951` comes after the check.
   - No object on a locked layer is opened for write, so the eLockedLayer crash cannot happen.
   - Locked raingarden layers already stop the placement earlier (`:849-858`).
2. **Xref:** the text only ever goes into the host model space.
3. **REFEDIT:** placement already refuses during REFEDIT (`:838`).

**Numbering**
1. **How the next number is found:** from the CE raingarden record, not the drawing and not Xrefs. It is the count plus one, skipping used names (`RaingardenPlacementPlan.cs:289`).
2. **Worked example:** draw RG1, RG2 and RG3, erase RG2, draw one more. The new one is RG4. RG2 is never reused, because erased rows stay in the record (`RemoveRaingardenByHandle` has no caller).
3. **Undo:** removes the record, outline and label together.

**Findings**
1. **MEDIUM, `SourcePlacementService.cs:955`: the label is not linked to its raingarden.** DP and OF tags are linked (`SourceTagService.cs:621`); Tim's answer asked for the same behaviour.
   - Drafter consequence: move or stretch the outline and "RG2" stays put. Erase the outline and hatch, and a stray "RG2" remains. Copying gives an "RG1" CE does not know.
   - Fix: store the label handle on the raingarden row, or log "text only for now" and have Tim accept it.
2. **LOW, `:944`:** a frozen or off GUIDELINES layer is not reported, so the label is invisible with no message. DP and OF behave the same. Fix: one information line, without thawing.
3. **LOW, `:960`:** the catch never aborts, so "could not be drawn" can print while the text exists. Fix: report failure only when no label was created.
4. **LOW, `:937/:951`:**
   - "GUIDELINES" and colour 75 are a second literal copy.
   - The layer is non-plot, so RG names never print, like DP and OF tags.
   - Fix: share the constant, and confirm with Tim that a non-plotting label is intended.
5. **LOW:** raingardens placed before this build get a number but no label. Fix: say so in the log.

**General checks**
1. **Switch OFF:** exact; the method returns before touching the drawing. The split-out of the DP, OF and WT code keeps their order and alignment.
2. **Default ON:** pinned through both start-up reads in `RaingardenLabelTests`, not in C75NewSwitchDefaultsTests (the report says so).
3. **REDO:** clean. It uses only the placement's own transaction. The 24 new REDO-baseline lines over-list the code but are safe.
4. **R-00:** the height comes from Settings (pipeTextHeight). The layer is the existing fixed DP and OF layer, which is disclosed.
5. **R-27:** met.
6. **REGRESSION_LOG.md:** honest, but omits the unlinked label.
7. **CE_SHARED:** unchanged.

**Sonnet claims**
1. **Confirmed:** most claims.
2. **Missed:** the unlinked label and the silent frozen layer.

**Verdict: KEEP-WITH-NOTE.** It is safe, and nothing is bypassed. The log should say the label is not tied to the outline, or the link should be added.

## #1848 BUG-901 cover to the outside top of the pipe (B-012; switch cover.measuredToPipeOutside ON)

**Worked examples** (lid RL 10.000, invert RL 9.200; formula (lid − invert) × 1000 − diameter − wall)
1. **UPVC 225:** before 575 mm, after 555 mm. At a 300 minimum it passes both times; at a 600 minimum it warns both times.
2. **RCP 375:** before 425 mm, after 380 mm. At 300 it passes both times; at 600 it warns both times.
3. **Cases that flip:**
   - UPVC 225 with invert 9.170 at a 600 minimum: 605 passes before, 585 warns after.
   - The report's lid 45.300 pipes: UPVC 225 goes 305 to 285, and RCP 375 goes 320 to 275. Both change from pass to warn at 300.
4. **What is added:** invert plus internal diameter plus one wall, so the bottom wall is not double-counted.
5. **Where the wall comes from:** the Settings table `cover.pipeWallThicknessMm`, keyed by material and size. It ships UPVC 225 = 20 and RCP, RRJ, CONCRETE and CONC 375 = 45, all Assumed.

**Unknown wall thickness (Tim's check)**
1. **Which pipes:** a material or size not in the table, a blank material, or a wall of 0 or less, not a number, or as big as the pipe.
2. **No quiet zero:** the old inside-top measure is kept, and the finding adds "Pipe wall Unknown (no wall in Settings for UPVC 150), so cover is measured to the inside top as before". This meets the "never a quiet zero" rule in the text.
3. **The outcome is the problem:** see finding 2.

**Findings**
1. **MEDIUM, CD's other screens still measure to the inside top.**
   - Where: `Services/Proposals/LevelsProposalEngine.cs:873`, `Services/PipeSizingSolver.cs:391`, `Services/NetworkDesignService.cs:407/423`, and `ViewModels/CdViewModel.GradeSuggestion.cs:252`.
   - Drafter consequence: CD says "320 mm cover" or shows a tick, while CDRULES says "275 mm, below 300". A pipe CD places at exactly the minimum then warns in CDRULES.
   - The log discloses this. Fix: B-022 routes every screen through `PipeCoverToOutsideRule.Measure`; ship it close behind.
2. **MEDIUM, `Rules/RulebookEngine.cs:514`: Unknown wall plus inside-top cover at or above the minimum gives a green Pass.**
   - Drafter consequence: a UPVC 150 with 310 mm to the inside top shows Pass, though the real cover is under 310 minus its wall. With only two rows shipped, most small pipes fall here.
   - Fix: when the switch is ON and the wall is Unknown, a Pass becomes Unknown. A Warn stays Warn, because adding a wall only lowers cover.
3. **MEDIUM, `Models/UserSettings.cs:313`: Tim's decision 50 is not yet met.** It asks for a full table from the pipe data or the standard, shown on the Settings page as Assumed until ticked. Two rows ship, with no Settings page row. Fix: a follow-up item.
4. **MEDIUM, `Rules/RulebookValues.cs:332`: the switch and the table are left out of the CDRULES "anything changed" check.**
   - Drafter consequence: a saved run is not marked Stale after the update and can still show OK for a cover a fresh run would warn on.
   - Fix: mark runs Stale once (as #1841 does), or add a log line "re-run CDRULES after the update".
5. **LOW, `Rules/PipeCoverToOutsideRule.cs:82`:** when two rows match with words of the same length (a "RCP / RRJ" pipe), the first in the table wins. It only matters if the figures differ. Fix: take the smaller wall on a tie.
6. **LOW:** the Unknown sentence is appended to Pass rows, which adds noise. Finding 2's fix resolves it.

**General checks**
1. **Switch OFF:** exact. Words, outcome, evidence and fix-planner wording are pinned by a 6 sizes × 6 materials × 5 levels grid.
2. **Default ON:** pinned through DeserializeSettings and DeserializeSettingsTolerant (empty file, missing group, empty group, null group).
3. **REDO, locked layers, Xref:** clean; nothing new opens a transaction. The "lower the pipe" Apply path is unchanged.
4. **R-00 and R-27:** met; a source guard keeps the figures out of the code.
5. **REGRESSION_LOG.md:** honest.
6. **CE_SHARED:** unchanged.

**Sonnet claims**
1. **Confirmed:** switch OFF, both reads, the Stale gap, the Pass-row noise and the missing Settings page row.
2. **Missed:** findings 1 and 2.

**Verdict: KEEP-WITH-NOTE**, with finding 2 strongly recommended before C-78 is finalised. Unknown must not show green.

## #1851 GB-01 slice 3, rule R-34 minimum pit depth (B-052; stacked on #1850 on #1848)

**Worked examples** (pit lid 10.000, lowest invert 9.200, so 800 mm deep; required depth = minimum cover + pipe diameter + wall, deepest pipe governs)
1. **Garden surface, 300 minimum:**
   - UPVC 225 needs 545 mm.
   - RCP 375 needs 720 mm, which governs, so the pit passes.
2. **Road surface, 600 minimum:** RCP 375 needs 1020 mm, so it warns: "pit is 800 mm deep; DN375 RCP / RRJ needs at least 1020 mm (600 minimum cover + 375 pipe + 45 wall) (Road surface, office cover table)".
3. **Cover switch OFF:** the same pit needs 975 mm and still warns, so R-34 is not removed.
4. **Book check:** 300 + 450 + 31 = 781 mm, which matches the guidebook list.

**Findings**
1. **MEDIUM, `Rules/RulebookEngine.cs:145` and `:751`: R-34 has no switch.**
   - The register says "R-34 follows the same cover switch". In fact it only drops the wall when that switch is OFF; the rule still runs.
   - Drafter consequence: every CDRULES run gains one "Minimum pit depth" row per connected pit, and cannot be turned off except by reverting.
   - No switch-OFF test exists. This breaks the Settings-switch rule (R-00 and R-27: a new behaviour ships behind a switch, ON).
   - Fix: add `pit.minimumDepthRule` (or similar), default ON, pinned through both start-up reads, with a test that OFF gives no R-34 rows.
2. **MEDIUM (wrong answer), `Rules/RulebookEngine.cs:797`: an Unknown wall is counted as `wall ?? 0.0`.**
   - Worked example: a UPVC 450 into a pit 760 mm deep. The pit passes against 750, but with the book's 31 mm wall it needs 781 mm and should warn.
   - The GB-01 card says Unknown is reported as Unknown, never assumed.
   - Fix: when the switch is ON and any connected pipe's wall is Unknown, a Pass becomes Unknown.
3. **LOW, `:803`:** only the governing pipe's Unknown wall is mentioned. Fix: list every pipe whose wall is Unknown.
4. **LOW, `:802/:809`:** the row never says "Assumed" for the wall, and the evidence leaves out the diameter and wall inputs. Fix: reuse `WallNote` and add both inputs.
5. **LOW:** one shallow pipe can warn under both R-04 and R-34. This is disclosed.

**General checks**
1. **REDO, locked layers, Xref:** clean; read only.
2. **R-00 values:** from Settings (MinCoverFor surface, then the wall table).
3. **R-27:** warns only.
4. **Tests:** seven tests with real book numbers (150 = 459 up to 900 = 1236), but none with the cover switch OFF.
5. **REGRESSION_LOG.md:** honest ("Undo: revert this commit").
6. **CE_SHARED:** unchanged.

**Verdict: FIX-FIRST.** It needs its own switch, ON, and Unknown must not show as Pass.

## #1852 BUG-1095 council minimum runoff C (B-017; switch detention.councilMinimumRunoffCApplied ON)

**Worked examples** (a 600 m² site in a council with a 0.80 minimum C and a 0.40 before-development C: 400 m² roof and paving, 200 m² garden)
1. **CDDESIGN:**
   - Calculated C = (400 × 0.9 + 200 × 0.30) / 600 = 0.70, which becomes 0.80.
   - The permitted discharge is 4.45 L/s before and after; the before-development C is untouched, so storage is not wrongly shrunk.
   - Q minor goes from 7.78 to 8.89 L/s.
   - Storage goes from 2.84 m³ (10 min storm) to 3.75 m³ (15 min storm).
2. **Pump sizing:** the C goes from 0.70 to 0.80, so the inflow volume rises 14.3 %.
3. **CDCALC Boyd's at shipped defaults** (boydsUsesHardGroundC OFF, so roof counts as 1.0):
   - Before: C 0.767, effective area 460 m², 4.01 m³.
   - After: C 0.80, effective area 480 m², 4.36 m³.
   - The note reads "Runoff C = 0.80 (calculated 0.7667)".
4. **Logic:** max(calculated, council minimum), applied only to the after-development C, only in "floor" mode (`CouncilRuleValues.cs:103-119`).
   - Applied once per path.
   - A null or missing minimum returns the calculated C, never 0.
   - Notes never block.

**Findings**
1. **MEDIUM, the proof plan expects the wrong Boyd's control numbers** (`release-v3-colleagues-BUG1095_FIX_REPORT.md` lines 55-57).
   - The plan expects 0.70 and 420 m² with the switch OFF, and "calculated 0.70" in the ON note.
   - With shipped settings Boyd's reads 0.767 and 460 m² (I checked that `boydsUsesHardGroundC` defaults to false at `UserSettings.cs:2593`). The test at `CouncilMinimumCBug1095Tests.cs:27` hides this by turning that switch ON.
   - Consequence: case N32 or the Codex look H8 reports a false fail, or someone "fixes" a correct number.
   - Fix: correct the plan's numbers, and add one test at shipped defaults.
2. **LOW, `PumpSystemCalcViewModel.cs:127-135`:** the CDCALC Pump System tab is not changed, so it gives a smaller pump volume than CDDESIGN. Acknowledged. Fix: a carpark entry.
3. **LOW:** saved CDCALC Boyd's drafts on floor-council jobs show as changed once on reopen. That is correct, but it is not in the log. Fix: one log line.
4. **LOW:** no Settings page row; OFF only by editing the settings file. Acknowledged.

**General checks**
1. **Switch OFF:** exact in all three paths.
2. **Default ON:** pinned through both start-up reads.
3. **REDO:** clean.
4. **R-00:** minimums come from council data.
5. **CE_SHARED:** unchanged.
6. **REGRESSION_LOG.md:** honest.

**Verdict: KEEP-WITH-NOTE.** The arithmetic and the switch are right; correct the Boyd's control numbers before the robot or Codex runs the proof.

## #1854 GB-02 part A council data (B-053; stacked on #1852; no switch)

**Values against the guidebook audit:** no mistyped figure found. Every new profile was diffed against its template.
1. **Glen Eira:** the underground share goes from 50 to 0 (book p34).
2. **Port Phillip:** method goes to Boyd's (Table 1; Tim item 27 "follow book").
3. **Cardinia:** a copy of the growth-area figures, plus a registration-number line on the submission list.
4. **Brimbank and Greater Dandenong:** generic figures, council-provided method.
5. **Hobsons Bay, Nillumbik and Merri-bek:** the generic default.

**Glen Eira removal:** nothing that calculates reads `minUndergroundPct`, so no answer changes. A saved CDRULES run goes Stale once.

**Port Phillip worked example** (600 m², 400 m² hard)
1. **Before:** CDDESIGN shows "Permitted discharge not given", with no tank.
2. **After:** permitted discharge 0.35 × 88.8 × 0.06 / 0.36 = 5.18 L/s, built on Assumed office figures. Storage is about 2.40 m³ at 1 in 10 (10 min), and an orifice is sized.
3. **Warning:** the council note says to check the planning permit; it does not block.

**Findings**
1. **MEDIUM, `REGRESSION_LOG.md` (lines 1-17 on the branch):** the entry does not say that every Port Phillip job now gets a sized tank from Assumed figures.
   - Drafter consequence: a tank is issued on a job whose permit needs none.
   - Fix: put the numbers in the log, say "no switch (council data, Tim item 27)", and tell drafters to turn detention off where the permit says so.
2. **MEDIUM, `council-profiles.json:1351-1356`:** Cardinia's method is marked Sourced (Table 1), but the log line 9 says "all Assumed", and the audit places Cardinia on the growth-area pages (p46). The test skips this field (`Gb02CouncilDataTests.cs:52`).
   - Consequence: no "warn on use" line on a value that may not be sourced.
   - Fix: mark it Assumed, or cite the real page and correct the log.
3. **LOW:** `guidebookVersionChecked` shows under its raw field name in "Show exact council source". Fix: add a label.
4. **LOW:** Brimbank and Greater Dandenong can never give a CDDESIGN storage, because there is no box for a council-provided discharge (same as Kingston today). Fix: note it in the log.

**Loading:** council profiles load only from the bundle file, not Settings, so the two start-up reads do not apply. There is no user copy to overwrite. The two new fields are kept out of the CDRULES fingerprint (tested).
**REDO and CE_SHARED:** clean (data and model only) and unchanged.

**Verdict: KEEP-WITH-NOTE.** Fix the log (Port Phillip numbers) and Cardinia's source status before it joins a train.

## #1853 BUG-505 one soft note when the source drawing has no units (B-010; switch xcivilImport.noUnitsNote ON)

**How it works**
1. **Reading the units:** the source INSUNITS is read from the source file opened read-only (`XcivilImportService.Pipeline.cs:111-126`, existing). There is no SetSystemVariable and the open drawing is not touched.
2. **When it fires:** only when the switch is ON, the source is Unitless, the scale guess is ×1, and the old check said nothing (`XcivilImportService.cs:328-331`). Once per CDIMPORTXCIVIL run.
3. **Scale:** never changed; it still comes from the object-size guess.

**Worked example**
1. **Unitless source with millimetre-sized objects:** scale 1. Before: silent. After: "This drawing has no units set; CE read it as millimetres." first in the pre-flight lines and under Warnings in the report.
2. **Unitless source with metre-sized objects:** ×1000 and the existing CHECK THE SCALE line; unchanged.
3. **Millimetre or metre sources:** unchanged.

**Findings**
1. **LOW, `XcivilSourceUnitsCheck.cs:49`:** "This drawing" prints in the drafter's own job drawing and reads as their drawing. Fix: "The source drawing has no units set; CE read it as millimetres." This needs Tim's OK, because his approved wording is used.
2. **LOW, `XcivilImportService.cs:858`:** the note also goes into the report's Warnings list, so it can show two or three times, and a clean import no longer reads "Warnings: none". Disclosed. Fix: leave it out of the warnings list, or accept it.
3. **LOW (existing):** in the window route the line lands behind the modal window (`LinkCommands.ImportXcivil.cs:167-185`). This is a separate item.

**General checks**
1. **Switch OFF:** exact.
2. **Default ON:** pinned through both start-up reads.
3. **REDO, locked layers:** clean.
4. **R-27:** never blocks.
5. **REGRESSION_LOG.md:** honest (BUG-505 stays open for a metres target).
6. **CE_SHARED:** unchanged.

**Verdict: KEEP-WITH-NOTE** (the wording question for Tim).

## #1855 GB-03 slice 4 soakage sweep engine (B-054; engine only)

**Engine-only:** confirmed. Nothing outside the tests calls `SoakageSweepService`. The existing `SoakageSizingService` is untouched, so no switch is needed. The new `soakage` group restores on both settings reads.

**Worked example against the guidebook sheet** (801 m², C 1.0, Kh 100 mm/h, factor 1, tank 6.85 × 4.896 × 0.88 m, porosity 0.95)
1. **Wetted area:** 33.54 + 23.49 × 0.44 = 43.87 m².
2. **120 minutes:** inflow 34.12 m³, outflow 8.78 m³, required 25.35 m³.
3. **Provided:** 28.04 m³ (111 %); emptying 6.39 h. All match the book.
4. **180 minutes:** 25.77 m³ governs.
5. **Units:** mm/h ÷ 1000 to m/h, minutes ÷ 60, area in m². Outflow uses the base plus half the wall height, capped at inflow.

**Findings**
1. **MEDIUM, `SoakageSweepService.cs:111/113/119`:** with an Unknown soil factor every row gets outflow 0, storage equal to the full inflow, and a percent provided. "Governing" becomes the 7-day storm, about 140 m³ on the book tank.
   - The overall result is correctly Unknown, but a future window or sheet printing the rows shows invented figures.
   - The test checks for outflow == 0.0.
   - Fix: make outflow, required and percent nullable, and leave Governing empty when the soil rate is Unknown.
2. **LOW, `:122/:136/:159`:** a rejected input gives 0 provided and NaN emptying. Fix: nullable values.
3. **LOW, `:63/:75`:** with no soil table passed, every soil is reported "not in the Settings soil table". Fix: default to the Settings table.
4. **LOW:** the emptying time is computed but never judged. Fix: ask the engineers whether a limit applies.
5. **LOW, `UserSettings.cs:1914-1915`:** porosity and the design storm are in Settings but not read by the engine yet. Fix: wire them in the window slice.
6. **Engineering points (flagged in the PR, not defects):**
   - The geotech rate is multiplied by the soil factor.
   - The worst storm (180 min, 25.77 m³) is judged rather than the book's highlighted 2-hour 25.35 m³.
   - Both need Tim's or the engineers' word.

**General checks**
1. **REDO:** clean.
2. **R-27:** warnings only; no divide-by-zero.
3. **Tests:** check the book sheet value by value.
4. **REGRESSION_LOG.md:** honest.
5. **CE_SHARED:** unchanged.

**Verdict: KEEP-WITH-NOTE.** Finding 1 must be fixed before any window or printed sheet uses the rows.

## Robot cases that would prove the main findings (proposed, not written)

1. **C78_r34_switch (proves the #1851 fix once a switch exists):**
   - Steps: a copy drawing with one pit, lid 10.000 and lowest invert 9.200, with an RCP 375 on a Road surface. Type CDRULES, then All.
   - ON: the saved findings file has the row "Minimum pit depth … needs at least 1020 mm". Switch-OFF control (set before launch): no R-34 row.
2. **C78_cover_unknown_wall (proves #1848 finding 2 once fixed):**
   - Steps: a UPVC 150 with 310 mm to the inside top against a 300 minimum. Type CDRULES, then All.
   - ON: the R-04 row is Unknown with "Pipe wall Unknown". Switch-OFF control: the row is Pass, "cover 310 mm to obvert".

## Summary

Nine PRs reviewed by code read only.
1. **FIX-FIRST:** #1851 (no switch of its own for R-34; Unknown wall counted as 0).
2. **KEEP-WITH-NOTE:** #1844, #1845, #1848 (Unknown wall shows Pass), #1852 (Boyd's control numbers wrong in the proof plan), #1853, #1854 (log and Cardinia status) and #1855.
3. **KEEP:** #1840.
