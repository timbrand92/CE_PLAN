# Independent review, round 2: older open PRs that carry a built-not-installed fix, Mon 26 Oct 2026

Reviewer: Opus 5.5 lead plus five Opus reviewers, independent (none of us built these PRs). Desk plan/03, Team, read only. Method and standard as `REVIEW_OPEN_PRS_25OCT.md` (round 1).

- **Bases:** Civil and Manager `origin/claude/rel-20261025r` at `d8840a09` (Civil 3.0.78 / Manager 1.1.78, C-68). Structural `origin/claude/rel-20261025s` at `3a3caac5` (Structural 1.0.124, S-44). I did not read the installed DLLs; these are the release lines, not a claim about what is installed.
- **Heads:** all 21 heads were read live from gh at 06:30. All match what was reviewed, and all are still OPEN and draft.
- **Nothing was touched:** no PR was closed, retargeted, commented on or merged, and no branch was deleted.

## ANSWER FIRST

1. **How the 21 were chosen:**
   - **Section B bugs:** 251 bug numbers (the 242, plus the six follow-ups and the three #1720 bugs the triage names in the same section).
   - **Open PRs older than #1479:** 1,067 of 1,369 open. **62** of them name a section B bug in their title or body (slash lists and ranges expanded).
   - **Already inside a base:** 17 (11 in Civil, 6 in Structural), checked one by one with `git merge-base --is-ancestor`.
   - **Already named in a review, a train list or a finalizer report:** 24 (most in `CODEX_PR_REVIEW_GROUP10_24OCT.md` and `REVIEW_PILE_B3` to `B8`).
   - **Too far behind to merge:** none dropped. All 21 that were left merge with the base apart from `REGRESSION_LOG.md` (keep both), and some `UserSettings.cs` keep-both clashes. #3 (May master) was already named in a review, so it is outside the count.
   - **Reviewed here: 21.** Under the cap of 25, so none of the 62 is left.
2. **Counts for the 21:** MERGE 1, MERGE-WITH-FIXES 17, HOLD 1, REJECT 2.
3. **MERGE candidates for the next Civil and Manager update, ranked by value (live heads at 06:30):** take the PR's own commits (cherry-pick), never the old branch.
   1. **#742** `0ed568a0`, BUG-406 (WRONG ANSWER): markup and the AI network tool read an older metre drawing's pipe lengths 1000 times short. **Fix first: one test line** (my run found it breaks an existing guard).
   2. **#710** `ef6937f6`, BUG-403 (daily paste): the "run CDREPAIR" line for pits pasted into a drawing with no Civil record. **Fix first: as written it does nothing on today's base** (BUG-1150 changed the read it uses). New read, plus a switch.
   3. **#1029** `55883cd3`, BUG-517(g) (blocks the 9 Nov gap plan): the printed computations sheet is black, not blue. **Fix first: one test; drop #1043's matching line.**
   4. **#1147** `d5b96269`, BUG-527 5.2 (design check): one pipe-speed limit everywhere, switch OFF. **Fixes first: the cascade caller, "Default:" notes.**
   5. **#1152** `117a631f`, BUG-545 part 2 (pit drop follows the one box, switch OFF). **Fixes first: whole-number check, saved-run staleness, notes.**
   6. **#1144** `1402c9f8`, BUG-543 (one orifice coefficient and one gravity). **Fixes first: gravity ON per your 17 Jul ruling, notes.**
   7. **#1150** `72e6b48e`, BUG-541 (slab minimum falls on Settings). **Fixes first: move into the `surface` group, notes, log text.**
   8. **#1156** `45f4f520` only, **#1159** `e3700167` and **#1161** `344a5742`, BUG-547 parts 1 to 3 (figures onto Settings, today's numbers). **Fixes first: notes, wording, one dead setting.**
   9. **#954** `78bea5b5`, BUG-552a (Manager uploads the plugins' outbox, switch OFF). **Fix first: skip .tmp and .bak files.** Ships OFF; turning it ON is your call.
4. **MERGE candidates for the next Structural update, ranked:**
   1. **#1157** `bce513a2`, BUG-503 S-13 (WRONG ANSWER): FADOPT Raft asks External or Internal for an unlabelled beam. **Fix first (HIGH, found here): an EB label is never seen**, plus wording and ship ON.
   2. **#1154** `542c1afe`, BUG-530 (an old pad with no size is no longer silently drawn at 600 without a word). **Fixes first: ship ON, add "mm".**
   3. **#1139** `6128420e`, BUG-550/557 (Enable MarkupAI is a real switch; Share learning data starts OFF). **Fixes first: leave CEMARKUPUNDO unlocked, one test.**
   4. **#1135** `17df5667`, BUG-519 (one plain start-up line). **Fixes first: the Plugin.cs clash, drop CE_VERSION, one test.**
   5. **#1146** `7bebd060`, BUG-503 S-15 (plain words in three commands). **Fix first: three sentences.**
   6. **#843** `85d74b19`, BUG-453 (no more "Settings page still to be built"). **Fix first: two plural sentences.**
   7. **#1247** `74a1f2d3`, BUG-439 (FADOPT names "an external beam line with no label"). MERGE as it is.
5. **Hold and reject:**
   - **HOLD #1204** (BUG-471, support blocks in metre drawings): with its switch ON, the label lands about 45 m from the column. Needs a design read and your word.
   - **REJECT #369** (BUG-069): never found the real cause and would turn every pit attribute on a rotated block.
   - **REJECT #817:** already on the base as #829. Its "805" was a PR number, not today's BUG-805.
6. **Section B bugs now covered (251):**
   - **130** are named on a current base (commit text, or an open PR whose head is already inside the base). This is an upper limit: a name can be a partial fix.
   - **15 more** now have a verdict from this round: BUG-403, 406, 439, 453, 471 (HOLD), 503, 517, 519, 527, 530, 541, 543, 545, 547, 550.
   - **92** sit only in other open PRs: newer ones (round 1 and the 24 Oct reviews), the docs-only audits, and older ones the Codex group 10 and pile reviews already judged.
   - **Inside those 92, BUG-069 and BUG-805** have no usable fix: #369 rejected, and #817 is a different bug.
   - **12 have no open PR at all:** BUG-080, 083 to 086, 088, 089, 091, 092, 094, 920 and 921. BUG-1042 and 1044 sit only in #1720 under its audit code; #1720 is outside every base and is still waiting for its later commits to be re-reviewed (C-64 to C-68 lists say so).
7. **What is left over (not in this job's scope):** 238 older open PRs (below #1479) are outside both bases and are named in no review. None of them names a section B bug. The round 1 leftovers (15 docs-only audits) are also still unreviewed.
8. **Tests I ran on combined trees** (Release, net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, one run at a time under `desk_jobs\build.lock`):
   - **Civil:** the base plus all 11 Civil PRs (#954 as a merge, the rest as their own commits). **531 of 536 pass, 3 skipped, 2 fail.** Both failures are caused by these PRs, not the base:
     1. `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault`: 33 new Settings keys have no "Default:" note. Reviewers predicted this; the fix is in each PR's item.
     2. `C5MixedUnitsTests.EveryCoverStripUsesTheRulebookCover_NotTheFixed600`: #742 adds a fourth argument to the line this guard pins. **Reviewer missed this; my run found it.**
   - **Manager:** same tree. **28 of 28 pass** (the 19 #954 tests, the test-hygiene guard and the CeAdminStorage tests).
   - **Structural:** the base plus all 8 Structural PRs (including the held #1204). **131 of 131 pass.** All 8 new test classes are in the built test file.
9. **Tim's question (one, not urgent):** #1204, how a support block should look in a metre drawing. See below. Everything else is safe without you once fixed.

## Checks I ran

1. **Containment:** all 1,369 open PR heads were fetched into a private clone (`C:\ce-rv\r`) and checked against both bases with `git merge-base --is-ancestor`: 713 inside Civil, 223 inside Structural, 433 inside neither.
2. **Already reviewed:** the PR number was searched (`#N`) in every `*REVIEW_*.md`, `TRAIN_*PR_LIST*.md` and `*FINALIZER_REPORT*.md` under `C:\CE_PLAN` (115 files).
3. **Trial merges:** each PR onto its base with `git merge-tree`, then the combined trees above.
   - **Clashes found:**
     1. **`REGRESSION_LOG.md`:** every PR. Keep both.
     2. **Civil `UserSettings.cs`:** #1029, #1161, #1147, #1152, #1150 and #1159 insert at the same places. Keep both; each block needs its own `/// <summary>` line. Resolved and built in my tree.
     3. **`ChargedSystemCalcViewModel.cs` (#1159):** take the base side, then change the one 0.82 line (item 11). Resolved and built.
     4. **Structural `Plugin.cs` (#1135):** take the PR side (the two-line loop). Resolved and built.
     5. **Structural `UserSettings.cs`:** #1154 with #1157. Keep both.
   - **#954 cherry-pick clashes; merge it instead.** Its branch has two merge-bases with the base. Merging the head changes only three Manager files and its test file beyond the log; all 48 old train commits (including both `PackageContents.xml` changes) are already in the base. `git cherry` shows only its five own commits.
4. **Protected files:** taken as their own commits (or #954 as a merge, see above), none of the 21 changes CE_SHARED / `Shared/`, the Installer, signing, deploy, version or PackageContents files.
5. **Live checks of reviewer claims (RULES 6.1):**
   - **#817:** `8650d036` (merged as #829, `863b60b1`) is an ancestor of the Civil base.
   - **#1204's parent #902:** merge `1c85c7eb` is an ancestor of the Structural base. #902 itself still shows open; the desk can treat it as done.
   - **The settings guard:** `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault` is on the base (line 154), and my run shows it failing on exactly the new keys.
   - **Gravity ruling:** `ENGINEERING_RULEBOOK.md` line 47, Tim's rulings of 17 Jul 2026: "**B6** Gravity | **9.81 everywhere** | correct the 9.8 site". So #1144's gravity is already decided; do not ask again.
   - **#710:** `cb3245e4` (BUG-1150) is on the base, and `HasCivilContentReadOnly` now counts pits in model space as content, so the PR's read answers "has content" right after a paste.
6. **Free space:** C: had 60 GB free.

## One item per PR

### Civil and Manager (base `d8840a09`)

1. **#742 BUG-406 (MEDIUM, WRONG ANSWER): markup and the AI network tool read an older metre drawing's pipe lengths in the drawing's units. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Cause is real:** `MarkupToChangePlanService.cs` lines 235, 287 and 379, and `GetProjectNetworkTool.cs` line 177, still read positions as millimetres. The other readers were fixed under BUG-330/393.
     - **On a job:** a 55 m pipe in an older metre drawing reads 0.055 m, so a marked-up "grade 1:200" sets the upstream invert 0.3 mm higher instead of 275 mm.
   - **The fix:** the four readers use the same units-aware reader as the rest, with the units from the facts already frozen for the AI. A mixed-units drawing (the BUG-287 hold) keeps the old reading.
   - **Fix needed (found by my run):** `C5MixedUnitsTests.EveryCoverStripUsesTheRulebookCover_NotTheFixed600` pins `authorityContext?.CreateProjectCopy(), markupStandards)` in `CeAssistantControl.xaml.cs`. #742 adds a fourth argument at line 411. Change the expected text to `authorityContext?.CreateProjectCopy(), markupStandards,` so the guard still proves the rulebook cover is passed.
   - **Switch:** none, accepted: the same reading already runs without a switch in six other readers, and a switch on these four would let two tools disagree about one pipe.
   - **Tests:** 6 in `Bug406MetreRecordLengthTests`. They pass on the combined tree. RED by compile only; the two source guards would fail on the base for the right reason.
   - **Redo, locked layers, wording:** nothing is written to the drawing; no new messages.
   - **Take:** `a799b616` and `0ed568a0`. Overlap: #772 needs a rebase after this.

2. **#710 BUG-403 (daily paste): pasting CE pits into a drawing with no Civil record prints the one "run CDREPAIR" line. Verdict MERGE-WITH-FIXES. Not safe as written; safe without Tim once fixed.**
   - **Cause is real:** `LinkService.ForeignClones.cs` lines 629 to 631 print the line only when the record is loaded or the paste woke Civil.
   - **Fix needed 1 (blocking, base changed since):**
     - **Why it no longer works:** BUG-1150 (`cb3245e4`, 25 Oct) made `HasCivilContentReadOnly` count CE pits in model space as content. At the end of a paste the pasted pits are there, so the PR's check says "has content" and **the line is still not printed**. Its tests use a fake for that read, so they pass anyway.
     - **The change:** add `ProjectDataService.HasCivilRecordContentReadOnly(Database db)` in `ProjectDataService.Persistence.cs`. It reads the record only, through an open-close transaction, returns `DrawingDisciplinePolicy.RecordJsonHasCivilContent(json)`, and returns true (no line) if the record cannot be read. Pass `() => ProjectDataService.HasCivilRecordContentReadOnly(db)`.
     - **Test:** update `Wiring_ThePasteEndAsksWhetherTheDestinationHasACivilRecord_ReadOnly` to expect the new name and `Does.Not.Contain("HasCivilContentReadOnly(db)")`.
   - **Fix needed 2 (switch rule):** add `linking.pasteLineForDrawingWithNoRecord`, ON; OFF passes `null` (today's answer). Tests: new object, `{}`, OFF.
   - **Tests:** 9 in `Bug403PasteIntoDrawingWithNoRecordTests` plus the edited `C6Adv2PasteOwnershipTests`. They pass on the combined tree, but see fix 1: they cannot see the fault.
   - **Redo, locked layers:** read only, open-close, no Undo step. The line text is the existing "[CE] 2 pits pasted from another drawing are not in the schedule yet: run CDREPAIR."
   - **Take:** `b9a77996`, `4b11f880`, `6ae0958c`, `e4cd9b04`, `ef6937f6`, plus the fix commit.
   - **Limit:** needs a real paste in AutoCAD (copy CE pits from a drainage drawing into a Structural drawing) to prove the line now prints.

3. **#1029 BUG-517(g) (blocks the 9 Nov gap plan): the printed computations sheet uses one Settings colour, black by default. Verdict MERGE-WITH-FIXES. Safe without Tim.**
   - **Cause is real:** `CalculationsV2ViewModel.cs` line 907 `CeBlue = #1E5AA8`, used for the practice name, its rule, the approved line and the headings.
   - **The fix:** `options.sheetAccentColour`, `#000000`. A bad value gives black and never blocks. Your INT-075 words ("ideally no blue please our colours are gold, black and white /grey") cover black; gold can be typed in.
   - **Fixes needed:**
     1. **Test:** `JsonConvert.DeserializeObject<OptionSettings>("{}").SheetAccentColour == "#000000"`.
     2. **Settings note:** the `/// <summary>` needs "Default: #000000 (black)." (the guard lists `sheetAccentColour`).
     3. **Overlap with #1043** (`codex/noblue-civil`, open): it changes the same line 907. Take #1029 for the sheet; drop #1043's `CalculationsV2ViewModel.cs` hunk and keep the rest of #1043.
   - **Tests:** 10 in `SheetAccentColourRuleTests`. They pass.
   - **Limit (RULES 5.1):** nobody has printed CDCALC to PDF and looked at page 1.
   - **Take:** `55883cd3`. Keep-both clash in `UserSettings.cs` after `CommandOutcomeLines`.

4. **#1147 BUG-527 5.2 (design check): one pipe-speed limit across the Inspector, the audit and the design check. Verdict MERGE-WITH-FIXES. Safe without Tim (switch stays OFF).**
   - **Cause is real:** the Inspector (`InspectorPaletteService.cs` 3327, 3437), audit Pass E and `DesignValidationService.cs` 381 judge against the office maximum, while CDRULES judges per material.
   - **The fix:** `pipeSpeedChecks.useMaterialLimit`, OFF; one reader `SettingsSizingStandards.CheckLimitMs`. OFF is exactly today.
   - **Fixes needed:**
     1. **Missed caller:** the CDPROPAGATE / Edit Pipe cascade warning (`LinkService.RepairAudit.InvertPropagation.cs` 193, 194 and 430) still uses the office figure. Read materials once with `ProjectDataService.TryPeekCurrent`, then use `SettingsSizingStandards.CheckLimitMs(material, maxVelocity)`. On a job, once ON: a uPVC pipe at 4 m/s warns in the Inspector but passes in the cascade. (Or carpark it as "BUG-527 5.2 remainder".)
     2. **Notes:** "Default: off." on `useMaterialLimit` and on `UserSettings.PipeSpeedChecks`.
     3. **Tidy:** two stacked `<summary>` blocks on `MaterialLimitOn`.
   - **Switch rule:** OFF is right. ON holds uPVC to 3 m/s instead of 6, and the per-material figures are still marked "PLACEHOLDER, Tim to confirm". Turning it on is a later question for you, not needed to merge.
   - **Tests:** 5 in `PipeSpeedLimitTests`. They pass. Add the defaults to the next train's new-switch defaults test.
   - **Take:** `2953867b`, `d5b96269`.

5. **#1152 BUG-545 part 2 (design check): the rulebook pit drop can follow the "Minimum outlet drop" box. Verdict MERGE-WITH-FIXES. Safe without Tim (switch stays OFF).**
   - **Cause is real:** CD, Edit Pipe and the cascade read `inverts.minOutletDropMm`, while CDRULES R-08, CD's suggestion and the cascade suggestion read `designStandards.pitInvertDropMm`.
   - **The fix:** `sharedValues.pitDropFollowsBox`, OFF. ON: the office drop comes from the box; a project's own recorded drop still wins.
   - **Fixes needed:**
     1. **Not a whole number:** with ON and the box at 25.5, R-08 becomes Unknown for every pit. Use the box only when it is a finite whole number of millimetres, else keep the Design Standards figure and add one warning line naming the figure kept. Add `[TestCase(25.5)]`.
     2. **Saved CDRULES run never goes stale:** with ON, add the box figure to the criteria fingerprint; leave the OFF fingerprint unchanged so no saved run turns stale.
     3. **Notes:** "Default: off." on the switch and the group.
   - **Overlap:** #1208 (BUG-546, already reviewed) adds two separate pit-drop rows: hold those rows until the name is settled.
   - **Tests:** 5 in `PitDropOneBoxTests`. They pass.
   - **Take:** `117a631f`.

6. **#1144 BUG-543: one orifice coefficient and one gravity for detention. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed (your 17 Jul ruling B6 already answers gravity).**
   - **Cause is real:** the Detention tab holds 0.6 and 9.81; CDDESIGN reads the council's coefficient and sizes with 9.8.
   - **The fix:** `OrificeBasis` gives one rule; the Detention tab reads the council's coefficient (ON; all 22 council profiles hold 0.6, so no hole changes).
   - **Fixes needed:**
     1. **Gravity ON (your ruling "9.81 everywhere"):** `OrificeUsesRuledGravity = true`, and `DetentionSystemViewModel` uses `OrificeBasis.RuledGravity`. OFF gives back 9.8.
        - **On a job:** the exact hole shrinks by about 0.025 per cent. The office example (4.27 L/s, 0.428 m head) goes 55.933 to 55.919 mm and still adopts 55. A hole moves 1 mm only when it sits within about 0.015 mm of a whole millimetre.
     2. **Notes:** "Default: on." on both switches.
     3. **Do not close BUG-543:** the 0.61 sites (`OrificeCalcViewModel.cs` 18, `DetentionDesignViewModel.cs` 25; your ruling B7) are not done. The carpark's "a quarter of a per cent" should read about 0.025 per cent.
   - **Tests:** 9 in `OrificeBasisTests`. They pass. Overlap: #1174 also edits the Detention tab; take #1144 first.
   - **Take:** `1402c9f8`.

7. **#1150 BUG-541: slab minimum falls (1 in 50 pavers, 67 asphalt, 100 concrete) become Settings values. Verdict MERGE-WITH-FIXES. Safe without Tim.**
   - **Cause is real:** `SlabService.cs` 242 to 249; every slab reader goes through it.
   - **No clash with #1753 (on the base):** a fall worked out without units compares correctly with 1 in N in any drawing.
   - **Fixes needed:**
     1. **One home:** put the group inside the existing `surface` group as `surface.slabMinimumFalls`, not a new top-level `surfaceFalls`. Renaming after release means moving keys in every user's file.
     2. **Notes:** "Default: 100." and so on.
     3. **Log text is backwards:** "pavers 1 in 40 lets a 1 in 45 slab pass" is wrong; 1 in 40 is stricter. Use "set pavers to 70: a 1 in 60 paver slab, flagged before, now passes".
   - **Tests:** 10 in `SurfaceFallSettingsTests`. They pass. The source of 50, 67 and 100 still needs your word before BUG-541 closes, not before merging.
   - **Take:** `72e6b48e`.

8. **#1156 BUG-547 part 1: the CDDESIGN connection pipe assumption (10 m of UPVC) on Settings. Verdict MERGE-WITH-FIXES: take `45f4f520` only. Safe without Tim.**
   - **Drop `93fdfef3`:** the X-Civil level range is already on the base as BUG-544 (`03913e47`, `xcivilImport.levelRangeFollowsSettings`). Taking it would make two settings for one job.
   - **Fixes needed:**
     1. **Note:** "Default: new ConnectionPipeAssumption() (10 m of UPVC, as before)."
     2. **Wording:** the note is added before sizing, so a failed sizing reads "sized as 10 m of UPVC" then "sizing failed", and it points to a Settings row that does not exist. Say "Connection pipe size assumes 10 m of UPVC (CE's assumption, not the drawn pipe)." and update `Sentence_SaysWhatWasAssumedAndWhereToChangeIt`.
   - **Tests:** 7 in `ConnectionPipeAssumptionTests`. They pass; the base's X-Civil tests still pass.

9. **#1159 BUG-547 part 2: WSUD tab and Charged system tab starting figures on Settings. Verdict MERGE-WITH-FIXES. Safe without Tim.**
   - **The clash in `ChargedSystemCalcViewModel.cs`:** do NOT take the PR side. It would wipe the BUG-597 Unknown results and the BUG-1097 minimum-head warning, and would not compile. Take the base side, then change base line ~204 to `double downpipeCo = Tab.EntryCoefficientUsed; // Settings chargedTab, 0.82 as before`. Done in my tree; it builds and the Charged and WSUD tests pass.
   - **Fixes needed:** "Default:" notes on 11 keys and the two groups; delete the never-shown `WsudTabSettings.SourceWords` and its test.
   - **Later for you (not blocking):** the WSUD runoff C of 0.85 may be a slip for 0.9, and the 0.82 downpipe coefficient is unverified. The PR keeps today's numbers, which is right.
   - **Tests:** 13 in `TabStartValueSettingsTests`. They pass.

10. **#1161 BUG-547 part 3: strip drain spacing, LPD search, JOIN reach and SPS clearance on Settings. Verdict MERGE-WITH-FIXES. Safe without Tim.**
    - **Fixes needed:**
      1. **Dead setting:** remove `trenchGrateLengthMm`; nothing reads it.
      2. **Wording:** `LpdCommand.cs` line 107 still says "within 2.5m"; build the distance from the setting.
      3. **Notes:** "Default 12000." must be "Default: 12000." and so on.
      4. **Tidy:** delete the unused `FLOOR_WASTE_MAX_SPACING_MM`.
    - **Units:** unchanged. LPD, strip drain and SPS still take raw numbers, wrong in a metre drawing as today.
    - **Tests:** 5 in `ReachSettingsTests`. They pass, and `C5MixedUnitsTests` still pins the JOIN line.
    - **All three BUG-547 PRs:** none edits a window. You cannot see these figures in Settings until Codex adds the rows, so BUG-547 stays open.

11. **#954 BUG-552a (PRIVACY): Manager also uploads the plugins' own outbox, switch `drainPluginOutbox` OFF. Verdict MERGE-WITH-FIXES. Safe without Tim while OFF.**
    - **Cause is real:** Civil and Structural write to `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox`; nothing on the base uploads or empties it.
    - **What would leave the PC with the switch ON:** Civil records only, each scrubbed (drawing paths become the job number; login and PC name removed). Structural records, anything older than the first ON, and files carrying the real login are deleted, never sent.
    - **Fix needed:** skip `.tmp` and `.bak` files in `UploadPluginOutbox` and in the backlog delete loop, as base `UploadOutbox` does since BUG-848. Add `SwitchOn_ATmpOrBakFileIsLeftAloneAndNeverSent`.
    - **Merge, do not cherry-pick** (see Checks 3). Manager version bump needed.
    - **Tests:** 19 in `CeAdminPluginOutboxDrainTests`. They pass (Manager 28 of 28).
    - **Turning it ON is your call later:** it sends Civil usage and fault records to the office share and permanently deletes Structural's queued records.

12. **#369 BUG-069 (mirrored text always readable). Verdict REJECT. Safe without Tim.**
    - **Why:** the builder never found where the mirrored imported labels come from, and added a broad guard. On today's base the first hunk lands in the loop every CE block insert uses, so every pit attribute on a block at 90 to 270 degrees would turn half a turn, with no switch. The base already has `ReadableTextRule` (card 1.9) doing the same maths.
    - **What unblocks BUG-069:** a reproduction on the consultant drawing type, then a narrow fix through `ReadableTextRule`.

13. **#817 "Pit Schedule: typed level says it is waiting". Verdict REJECT: already on the base as #829 (`8650d036`). Safe without Tim.**
    - **The number mix-up:** "805" in its title is PR #805 (the grade-check marker), filed under BUG-445. Today's BUG-805 is an X-Civil import bug. The triage counted BUG-805 as "in an open PR" because of this title; it has no fix.

### Structural (base `3a3caac5`)

14. **#1157 BUG-503 S-13 (WRONG ANSWER): FADOPT Raft asks External or Internal for a beam line with no label. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
    - **Cause is real:** `FoundationService.cs` line 1501 files every unlabelled raft beam as Internal.
    - **A question, not a block:** Enter keeps Internal (today); Esc stops before any write and says "Nothing was adopted".
    - **Fix needed 1 (HIGH, found in review): an EB label is never seen.** Line 1500 looks only for IB or BIB labels, so today every EB-labelled raft edge is adopted as Internal (an existing wrong answer). With the switch ON, an EB-labelled line is asked about as if it had no label. Add `TryFindBestBeamLabel` (the nearer of the IB and EB matches, only when the switch is ON) and a source guard. **For the desk: carpark the OFF-path mislabelling as a new bug.**
    - **Fix needed 2 (wording):** "Some beam lines in this raft have no label. Are they External or Internal beams? [External/Internal] <Internal>:".
    - **Fix needed 3 (switch rule):** it fixes a silent guess, so ship `AdoptAsksUnlabelledBeamKind = true`; add `{}` and OFF tests.
    - **Tests:** 13 in `AdoptBeamKindAskTests`. They pass. Keep-both with #1154 in `UserSettings.cs`.
    - **Take:** `48cfab71`, `bce513a2`.

15. **#1154 BUG-530: an old pad with no recorded size is still drawn at 600, but CE now says so. Verdict MERGE-WITH-FIXES, ship ON. Safe without Tim once fixed.**
    - **The title is out of date:** after its fix round the pad is not left alone; it is drawn at the placeholder size and listed as needing attention in FST.
    - **Fixes needed:**
      1. **Ship ON:** both positions draw the same lines; ON only stops the silence. Change the new-object test to ON and add `{}` ON.
      2. **Wording:** "PF3: size not recorded. Drawn at the 600 mm placeholder size. Set its size with FEDIT."
      3. **Log checklist:** the line is shown in FST, not on the command line.
    - **Still a wrong drawing (later, your call):** the plan still shows a 600 square nobody entered. A visible "SIZE NOT RECORDED" tag would need your ruling.
    - **Tests:** 8 in `UnknownPadSizeTests`. They pass.
    - **Take:** `f3c72688`, `542c1afe`.

16. **#1139 BUG-550/557: Enable MarkupAI really switches the markup commands; Share learning data starts OFF. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
    - **Privacy:** nothing leaves the PC in any switch position (since #949 the off-PC send is always refused). The PR makes the boxes tell the truth.
    - **Fixes needed:**
      1. **Leave CEMARKUPUNDO working** when MarkupAI is off, so a drafter can still undo a markup group. Remove its switch check; the guard test expects one fewer.
      2. **Test:** `{}` gives Enabled true and LearningDataOptIn false.
    - **Limit:** a PC that already saved the share box ticked keeps it ticked.
    - **Tests:** 6 in `MarkupAISwitchTests`. They pass.

17. **#1135 BUG-519: Structural prints one plain start-up line; the full list is behind a switch (OFF). Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
    - **Cause is real:** about 40 start-up lines, six naming commands Structural does not have.
    - **Fixes needed:**
      1. **Clash in `Plugin.cs`:** take the PR's two-line loop and drop the base list. Done in my tree; it builds.
      2. **Drop CE_VERSION** from the full list (Manager owns it since BUG-852) and add it to `FullListNeverNamesCommandsStructuralCannotRun`.
      3. **Test:** `{ "Diagnostics": {} }` keeps the short line.
    - **Start-up safety:** command-line text only, inside the existing start-up try. No drawing write.
    - **Tests:** 9 in `StartupBannerTests`. They pass.

18. **#1146 BUG-503 S-15: plain words in CSSOILREPORT, CSWINDCLASS and STRSCHEDREFRESH. Verdict MERGE-WITH-FIXES. Safe without Tim.**
    - **Fix needed (wording):** "switched on in Settings" points at a box that is not on the Settings page, and one sentence is printed twice. Use the three sentences in reviewer B's text: "[CE] This command does not place the note on the drawing. Copy it onto the sheet's geotechnical note by hand, or use the general notes command (CSGENNOTES) once general notes are switched on." / "[CE] CE does not work out the bracing needed yet. Type it with CSBRACINGREQUIRED." / "[CE] The wind class is saved with the job. The general notes command (CSGENNOTES) puts it in the design criteria line once general notes are switched on."
    - **Tests:** 6 in `StructuralPlainWordsTests`. They pass.

19. **#843 BUG-453: five OFF commands stop saying "The Settings page for it is still to be built". Verdict MERGE-WITH-FIXES. Safe without Tim.**
    - **The new text is true:** the rows are still not built (#1250, #1063 open), and the text matches lines already accepted on the base.
    - **Fix needed (grammar):** the lintel and roof point-load lines are plural: "They are still being tested; CE switches them on ... once they are approved."
    - **Left over:** three more "still to be built" lines (`MemberScheduleRead.cs` 121, `RoofPointLoadAcrossDrawings.cs` 404, `command-registry.json` 5503).
    - **Tests:** 12 in `OffEngineWordingTests`. They pass.

20. **#1247 BUG-439: the FADOPT width question says "an external beam line with no label", not "EB line". Verdict MERGE. Safe without Tim.**
    - **Tests:** 1 new, `FootingWidthAskTests` 13 in all. They pass.
    - **With #1157:** different lines; either order.

21. **#1204 BUG-471 slice 1: C1, C2, DS1 and TS1 convert units in a metre drawing instead of holding (switch OFF). Verdict HOLD. Needs Tim.**
    - **Why hold:** only the block's scale converts. With the switch ON, the label offset, the size-swap commands and the beam-link reach stay in millimetres, so in a metre drawing the label lands about 45 m from a 0.089 m column. There is no check for a drawing set to metres but drawn in millimetres.
    - **Its parent #902 is already in the base** (`1c85c7eb`), so the PR could land alone as `da59d7aa`; it should not until the label is converted too.
    - **Tests:** 15 in `Day1UnitsConvertTests`. They pass, but none checks the label position.
    - **What unblocks it:** a design read, and your answer below.

## Tim's question (one, not urgent)

1. **#1204: in a metre drawing, should C1, C2, DS1 and TS1 draw the column at real size, with the label and link distances converted too?** Today they refuse to run in a drawing that is not in millimetres.
   - **What is built:** the column converts, the label does not (it lands about 45 m away).
   - **Recommendation: yes, convert everything, and refuse only when the drawing looks mixed** (set to metres but drawn in millimetres), the same as the footing commands do. One rule for every support.
   - **On a job:** a drafter opens a metre site plan, types C1, and gets an 89 SHS column 0.089 m wide with its label beside it. In a drawing that says metres but is drawn in millimetres, CE says so and draws nothing.

## Train notes

1. **Civil and Manager:** #742, #710, #1029, #1147, #1152, #1144, #1150, #1156 (one commit), #1159, #1161 as their own commits after their fixes; #954 as a merge after its fix (Manager bump).
   - **New-switch defaults test:** pin `pipeSpeedChecks.useMaterialLimit` OFF, `sharedValues.pitDropFollowsBox` OFF, `drainPluginOutbox` OFF, the #1144 coefficient switch ON and gravity switch ON, the new #710 switch ON.
   - **Settings guard:** run `C60AuditSourcePinGuardTests` after every pick.
2. **Structural:** #1157, #1154, #1139, #1135, #1146, #843 after their fixes, and #1247 as it is. Keep-both #1154 with #1157. Hand-place the log entries at the top.
3. **For the desk (carpark lines this job may not write):** the EB-label raft fault (#1157), the BUG-543 remainder (0.61 sites), the BUG-527 cascade remainder if #1147 fix 1 is not taken, BUG-069 needs a reproduction, BUG-805's "in an open PR" count is wrong, and #902 is already in the base.

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing was opened in AutoCAD. Built and unit-tested only. Nobody has seen any of these work in AutoCAD.
2. **The fixes:** none of the fixes above was made or run. My test runs are of the PRs as they stand, combined.
3. **Full suites and net48:** only focused classes ran (536 Civil, 28 Manager, 131 Structural). Full suites and net48 were not run. I did not run the same filter on the bare base; the two Civil failures were traced to the PRs by reading the failure text against the base source.
4. **RED:** by reading. Most new tests fail on the base only because they do not compile there.
5. **The printed PDF (#1029) and the start-up line in AutoCAD (#1135):** not seen.
6. **Coverage counts:** bug numbers in commit text and PR bodies, not a check of each fix.
7. **Housekeeping:** my scratch `C:\ce-rv` (clone, two worktrees, test output) is removed at the end of this job. The build lock was mine only while a run was going and is gone.
