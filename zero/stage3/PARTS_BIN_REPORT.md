# Parts bin report: the old Civil plugin judged against the new design

**Stage 3, read-only. Written 16 Nov 2026.** Nothing in the old repository was changed, built, installed or run.

## What was read, and how

1. **Ref read:** `origin/claude/rel-20261114a`, commit `a6809594` (5 Nov 2026, Civil release "C-80" merge). It is the newest Civil release branch. `rel-20261026s` is newer by hours but is the Structural line, so it was left out. The checked-out working files in the worktree were not used.
2. **How:** the Civil, Manager, shared and installer folders were copied out of that ref with `git archive` into `C:\CE_WORK\scratch\zero_study\S_partsbin\src` (a scratch copy; the repository was untouched). Line counts are all lines in code files, comments and blanks included.
3. **Tests were counted, not run.** A "test" below means a test attribute found by text search. Whether they pass today is Unknown.
4. **Scope:** Civil program (`Modules/Drainage`), Manager (`Modules/Manager`), `Shared/CE_SHARED`, `Shared/CE.Spine`, `Shared/CE.Diagnostics`, `Shared/CE.Release`, `Installer`, `ReleaseAuthority`, `CE.AI.Core` and `CE.Cloud` only as far as Civil uses them. Structural not touched.
5. **Size of the whole:** Civil program 1,870 files and about 444,000 lines of code; Civil tests 1,641 code files and about 23,300 tests; Manager 138 files and about 25,000 lines; shared library about 10,000 lines; installer about 3,100 lines.
6. **One fact that shapes every verdict below:** the Civil program has a folder of "rules" (`Modules/Drainage/Rules`, 304 files, about 37,900 lines) of which only 5 files touch AutoCAD at all. By contrast 339 of the 682 files in `Services` touch AutoCAD. So a clean "brain" already exists inside the old plugin, and it can be told apart from the part that reaches into drawings.

Paths below are from the repository root of that ref.

---

## The pieces

### 1. Orifice (restrictor) sums

1. **What it is:** The sum that turns a head of water and a permitted flow into an orifice size, and back (flow through a given hole). Includes the rule that rounds up to a standard size and the note about a council's minimum.
2. **Where it lives:** `Modules/Drainage/Services/Hydraulics.cs` (92 lines), `OrificeSizer.cs`, `OrificeBasis.cs`, `OrificeMinimumNote.cs`; about 4 files and 250 lines in all.
3. **Verdict:** TAKE.
4. **Why:** It is one short, pure piece of arithmetic with no AutoCAD in it, and it works both ways (flow from size, size from flow), which is the "any direction" shape the new design wants. Two numbers are written into the code as defaults (discharge coefficient 0.6 and gravity 9.8). The coefficient is also held per council in the council data, so the code default is only a fallback; both must come from the office list in the new build. Tested by `Services/OrificeSizerTests` (26 tests) plus three smaller orifice test files; the forward and backward arithmetic has no test file of its own by name.
5. **Evidence:** `Hydraulics.OrificeFlowLps`, `Hydraulics.OrificeDiameterMm`, `OrificeSizer`; `Modules/Drainage.Tests/Services/OrificeBasisTests.cs`.
6. **Risk if taken:** the fallback numbers get copied in as hard-coded values; mitigate by reading them from the office list. **Risk if left:** a proven sum is rewritten and may be written less carefully.

### 2. Storage held in pipes, pits and tanks

1. **What it is:** How many litres a part-full pipe, a graded pipe, a pit or a tank holds below a given water level.
2. **Where it lives:** `Modules/Drainage/Rules/DetentionStorageMath.cs` (169 lines), `DetentionFreeboardRule.cs`, `DetentionPipeLimitsRule.cs`.
3. **Verdict:** TAKE.
4. **Why:** Pure arithmetic with no AutoCAD and no settings. It treats a part-full pipe as a circle segment (its own comment says a rectangle would overstate storage by up to a fifth), and steps along a graded pipe rather than assuming a flat one. It takes any water level, so it does not care which end was typed. Tested only inside `Rules/DetentionTwlSolverTests` (the TWL test files hold 23 tests between them); the storage maths has no test file of its own.
5. **Evidence:** `DetentionStorageMath.PartFullPipeAreaMm2`, `DetentionStorageMath.PipeBarrelLitres`.
6. **Risk if taken:** very low; add direct tests of its own. **Risk if left:** the storage figure appears on a council-facing sheet, so a rewrite carries real risk.

### 3. Top water level and detention sizing

1. **What it is:** Works out the top water level from a tank or detention pipe run and its orifice, and sizes the storage needed by Boyd's method (worst storm duration). Includes the twin-pipe layout and the "volume required" rule that stops an unknown volume printing as zero.
2. **Where it lives:** `Rules/DetentionTwlSolver.cs` (219), `DetentionVolumeRequired.cs` (123), `DetentionBranchCollector.cs` (367); `Services/DetentionSizingService.cs` (327), `DetentionTwlService.cs` (427), `DetentionTwinPipeLayoutLogic.cs` (378); window code `ViewModels/DetentionSystemViewModel.cs` (1,370). Roughly 3,300 lines.
3. **Verdict:** REPAIR.
4. **Why:** The solver and sizing are pure and worth keeping. Two named repairs: (a) the top water level is worked out starting from the orifice and stepping out, so it is one direction; the new design must also let the water level be the held value; (b) the state that decides "do we know the volume" lived inside a window class, which is how a zero got saved and printed on a drawing once (the rule file records this). Tests: TWL 23 across two files, detention sizing 15.
5. **Evidence:** `DetentionTwlSolver`, `DetentionSizingService`, `DetentionVolumeRequired.IsKnown`.
6. **Risk if taken:** the window-bound parts come along unless separated. **Risk if left:** the Boyd's-method sweep and the "never print a made-up zero" rule are rediscovered the hard way.

### 4. Pipe capacity and flow sums

1. **What it is:** Full-bore speed in a pipe (Manning), the pipe size search that picks the smallest standard size that works, the speed limits by material, and the rational-method flow from area, runoff and rainfall.
2. **Where it lives:** `Services/DesignValidationService.cs` (481), `PipeSizingSolver.cs` (506), `MaterialVelocityLimits.cs` (219), `RationalFlowService.cs` (429), `Models/PipeSizingModels.cs`. About 1,900 lines.
3. **Verdict:** REPAIR.
4. **Why:** Pure and AutoCAD-free, and the roughness and speed limits are already read from the settings table rather than written into the sums. Named repairs: (a) the maximum speeds in the shipped table are marked in the code as placeholders awaiting the owner's confirmation (plastic 3.0, concrete 6.0, cast iron and steel 4.0 m/s); do not carry them forward as fact; (b) the pipe-size search assumes the upstream invert is higher than the downstream one (its header says so), which is the one-direction assumption. Tested: pipe sizing 38 tests, material limits 39, rational flow 38, design validation 57, and a stored parity fixture of expected answers (`Modules/Drainage.Tests/Fixtures/PipeFlowSizingParity_a6e0cc87_net10.txt`).
5. **Evidence:** `DesignValidationService.ComputeFullBoreVelocity`, `PipeSizingSolver`, `MaterialVelocityLimits`.
6. **Risk if taken:** placeholder numbers quietly become design values. **Risk if left:** the stored parity answers are a ready-made check of any rewrite; losing them removes a cheap safety net.

### 5. Rainfall data and curves

1. **What it is:** The Melbourne rainfall intensity curve (seven storm frequencies, seven coefficients each) and the maths that turns a duration into an intensity, with a copy held per job.
2. **Where it lives:** `Modules/Drainage/Assets/Config/ifd-melbourne.json` (about 4.8 KB); `Rules/RainfallCurve.cs` (467), `RainfallCurveStorage.cs` (148), `RainfallCurveReport.cs` (117).
3. **Verdict:** TAKE.
4. **Why:** One small data file and one pure formula. The file states that the old coarse table is kept for reference only and must not be used for new output, so the authoritative method is clear. It holds the facts once (the curve), and the sum is a formula over them. Melbourne only: other locations are Unknown. Tested: 59 tests across three rainfall test files.
5. **Evidence:** `ifd-melbourne.json` (polynomial block, `authoritativeMethod`), `RainfallCurve`.
6. **Risk if taken:** the source note names an office spreadsheet by file name; fine in a planning file, tidy before shipping. **Risk if left:** the coefficients are hard to recover by hand.

### 6. Council rules data (and the "where did this value come from" model)

1. **What it is:** Each council's drainage rules (storm frequencies, runoff, time of concentration, minimum cover, reuse allowance, standard drawings) with, for every figure, a record of whether it was sourced from the council document, an office rule, or assumed. Also the council letter and request-for-information drafters and a page viewer for the source document.
2. **Where it lives:** `Modules/Drainage/Assets/Config/council-profiles.json` (about 183 KB, 22 profiles); `Models/CouncilProfileModels.cs` (442), `Services/CouncilProfileService.cs` (628), `Rules/CouncilRuleValues.cs` (643), `CouncilLetter.cs`, `CouncilRfi.cs`, `CouncilSourceWords.cs`; the source-page viewer in `Dialogs/CouncilSourceDialog` and `ViewModels/CouncilSourceViewModel.cs`.
3. **Verdict:** REPAIR.
4. **Why:** The structure is what the new design wants: a value, where it came from, and a plain-words note, with the order council, then project, then office already coded. But the data is thin: of 410 recorded figures across the 22 profiles, 287 are marked Assumed, 79 Sourced and 44 Office rule, and every one of the 22 profiles has some assumed figures. Only Kingston has more than 10 sourced figures; ten profiles have none. The edition of AS/NZS 3500.3 each council cites is unrecorded for 16 of 22. Take the structure and the 123 sourced and office-rule figures; treat the 287 as a to-do list, not as rules. Tested: 62 council-profile tests, 9 council-rule tests, plus a baseline fixture (`Drainage.Tests/Fixtures/CRD1CouncilBaseline.json`). The letter and request-for-information drafters were not read beyond headers.
5. **Evidence:** `council-profiles.json` (`fieldProvenance`, `editionStatus`); `CouncilRuleValues.Value`, `RuleValueSource` in `Rules/RulebookValues.cs`.
6. **Risk if taken:** assumed figures display as if confirmed (the old code does warn on them; the new build must too). **Risk if left:** the work of reading council documents is repeated.

### 7. The standards and settings store

1. **What it is:** The page of office settings: sizes, text heights, offsets, tolerances, speeds, defaults.
2. **Where it lives:** `Models/UserSettings.cs` (4,569 lines, about 625 settable items by text count), `Services/SettingsService.cs` (1,234), `ViewModels/AdvancedSettingsViewModel.cs` (1,850), plus the Manager's settings bridge (`Modules/Manager/Services/CeCivilSettingsBridgeSession.cs`, 668). About 630 tests mention settings.
3. **Verdict:** IDEA ONLY.
4. **Why:** The idea (every number lives in one list, each says its default and its source) is right and is what the new design asks for. The build is one giant class with one property per setting and a hand-written help line per property, so adding a value means new code and a new screen, the opposite of "a new line in a list". About 176 properties carry a written "Default:" line; the code enforces that with a source-reading test. Settings files sit in more than one folder (see the install report). Keep the list of what the office actually tunes; rewrite the store as data.
5. **Evidence:** `UserSettings.cs`; `SettingsService.SettingsFilePath`; `INSTALL_TODAY.md` fragility items 4 and 18.
6. **Risk if taken:** the one-class shape drags in the "new thing equals new screen" problem. **Risk if left:** the list of what matters is lost; extract the names and defaults first.

### 8. Tank library

1. **What it is:** The eleven round tank sizes the office specifies most, seeded from 266 past rating reports, offered as shortcuts and never as a limit.
2. **Where it lives:** `Assets/Config/tank-library.json` (about 5 KB); `Rules/TankLibrary.cs` (215), `WaterTankFacts.cs` (195); the tank command and window are about 2,000 lines more.
3. **Verdict:** TAKE.
4. **Why:** Small, real, sourced from the office's own jobs, and already says typing any other size stays allowed (matches the pick-or-type ruling). Tested: 28 tests. The tank command and window code is separate and tied to the old window style, so take the data and the facts rule, not the window.
5. **Evidence:** `tank-library.json`, `TankLibrary`.
6. **Risk if taken:** none of note. **Risk if left:** a quick win is lost.

### 9. Office blocks shipped in the bundle

1. **What it is:** The office's own drawing blocks: pit block (two versions), pit label, pit schedule, downpipe, inspection opening, overflow, gross inlet, floor waste, trench grate, riser, dropper, fall symbol (two), spot level, source, arrow, on-site detention criteria.
2. **Where it lives:** `Installer/source_blocks/` (18 drawing files, 54 KB to 95 KB each). The block palette code is in `Modules/Manager/Services/CeBlocks*.cs` (8 files, 1,055 lines). The Structural bundle carries its own pit block files.
3. **Verdict:** REPAIR.
4. **Why:** These are the office's look and the new design says to use them exactly as drawn (D-015, D-039). Named repairs: (a) the pit block, pit label and pit schedule files exist in both the Civil and Structural bundles at different sizes, so one set must be chosen; (b) it is Unknown which are dynamic blocks and which attributes the code relies on (not opened); (c) no test opens the blocks, beyond the harness sample drawing. They hold facts only as text attributes, which suits the new design if each attribute is tied to one fact.
5. **Evidence:** `Installer/source_blocks/` (the pit block files and their siblings); `Modules/Structural/Assets/Blocks` (not read); `TOOLS_TODAY.md` T-035 item 4.
6. **Risk if taken:** an old attribute name is baked into code. **Risk if left:** the office loses its own symbols.

### 10. The special one-piece pipe object

1. **What it is:** A custom AutoCAD object type for a pipe (walls, band and labels as one object), with its own grips, written in C++ plus a C# bridge, and a service that upgrades old pipes to it, including automatically when a drawing is opened.
2. **Where it lives:** `Modules/Drainage.NativeObjects2027/` (8 files, about 2,550 lines of C++), `Modules/Drainage.NativeGrip2027/` (1,224 lines), `Modules/Drainage.NativeObjects2024/` (one project file), `Modules/Drainage/Services/NativeObjects/` (6 files, 1,349 lines), `LinkService.PipeObjectUpgrade.cs`, `LinkService.UnloadedPipeObjects.cs`.
3. **Verdict:** LEAVE BEHIND.
4. **Why:** The new design forbids it: only ordinary AutoCAD objects may print. It exists for AutoCAD 2027 only, needs the plugin or an enabler to open, and the upgrade-on-open service converts drawings without being asked, which is the opposite of "looks and plots identical without the plugin". It is heavily tested (about 99 tests with pipe object in the file name and 356 with Native) but those guard the object itself. One idea is worth keeping: the "upgrade gate" and the proxy-graphics guard show how much effort went into stopping data loss.
5. **Evidence:** `CeCvlPipeObject.cpp`, `PipeObjectUpgradeOnOpenService.cs`, `INSTALL_TODAY.md` section 3 item 7 and fragility item 21.
6. **Risk if taken:** the problem the owner reported on a live drawing returns. **Risk if left:** none for the new build; old drawings that already contain these objects need a reader, which is a Stage 4 question (Unknown how many).

### 11. Where facts are held in the drawing today

1. **What it is:** The project record (pits and pipes as saved facts), a second store of links, slabs, survey levels, legal point of discharge and others, all kept inside the drawing.
2. **Where it lives:** `Services/ProjectDataService*.cs` (23 files, about 9,400 lines), `Models/PitData.cs` (98 settable items), `Models/ProjectData.cs`; dictionary names include `CE_CVL_SUITE_PROJECT`, `CE_CVL_SUITE_LINKS`, `CE_CVL_SUITE_SPINE`; extra data on individual objects as well.
3. **Verdict:** LEAVE BEHIND.
4. **Why:** The new design holds each fact once. Today the same fact can be in the project record, the link record, the spine copy, a block attribute and label text. The spine's own file says it is "a durable, human-readable copy" and "not a replacement" for the other two, which is the several-places problem stated by the code itself. A whole recovery file (`ProjectDataService.Recovery.cs`, 1,150 lines) exists to cope when they disagree. Saved text is split into 255-character chunks and that chunking code is copied in three places rather than shared.
5. **Evidence:** `SpineRecordStorageContract` (in `Services/Spine/SpineRecordStore.cs`), `ProjectDataService.Persistence.cs`, `LinkService.Persistence.cs`.
6. **Risk if taken:** the drift between stores comes too. **Risk if left:** old drawings need a one-way reader to bring their facts into the new model (Unknown how many are in play).

### 12. Permanent identities and field provenance (the Spine library)

1. **What it is:** A small pure library that gives each pit and pipe a lasting key, records for each field who or what decided it and why (observed, inferred, proposed, human decision), and lists relationships between things.
2. **Where it lives:** `Shared/CE.Spine/` (12 files, about 1,500 lines, no AutoCAD references); the Civil side that builds records is `Modules/Drainage/Services/Spine/` (7 files, 2,542 lines).
3. **Verdict:** REPAIR.
4. **Why:** The library is close to the new "fact has a value, a source and a hold" model, and it is independent of AutoCAD. Named repairs: it was designed as a copy projected from the other stores (piece 11), so it must become the primary holder, not a mirror; and the Civil projector is tied to the old stores. Tested: 87 tests in `Shared/CE.Spine.Tests` plus about 171 Civil tests with Spine in the file name.
5. **Evidence:** `SpineObjectRecord`, `SpineAuthority`, `SpineRelationship`, `SpineFingerprint`.
6. **Risk if taken:** its vocabulary (authority layers) is richer than the new design needs. **Risk if left:** the one existing, tested home for "where it came from" is thrown away.

### 13. Pipe-to-pit linking

1. **What it is:** The behaviour that moves a pipe end when its pit moves, splits a pipe when a pit is dropped on it, keeps text and arrows attached, and copes with copy and undo.
2. **Where it lives:** `Modules/Drainage/Services/LinkService*.cs` (101 files, about 54,700 lines, the largest single area in the program), `Commands/LinkCommands*.cs` (about 4,000 lines).
3. **Verdict:** IDEA ONLY.
4. **Why:** The approach (watch the drawing's change events and help, not lock things together) is the one the new design chooses, so the thinking is valuable: the files record dozens of cases about copy, undo, redo, clones, foreign drawings and split. But 54,700 lines in one static class split across 101 files, written around the special pipe object and the old stores, is not a base to extend. Use it as a list of cases to prove in Stage 4 trial 1 (move, copy, mirror, rotate, stretch, undo, save, copy between drawings). Tested: about 107 tests with LinkService in the file name, plus the headless proof set (piece 28).
5. **Evidence:** `LinkService.Reactors.cs`, `LinkService.Split.cs`, `LinkService.ForeignClones.cs`; headless proofs `UndoChecks.cs`, `RedoPrimitiveChecks.cs`.
6. **Risk if taken:** the whole old tangle. **Risk if left:** the case list is not re-learned; mine it before closing the book.

### 14. Label placement

1. **What it is:** The rule for where a pipe's text, invert text and arrow sit on its line, and how they slide, flip or step out when something clashes, with a ceiling on the slide.
2. **Where it lives:** `Rules/LabelPlacementRule.cs`, `LabelTextHeightRule.cs`, `HandPlacedLabelRule.cs`; application in `Services/LinkService.TextClashTidyUp.cs` (1,125), `Commands/TidyLabelsCommand.cs`.
3. **Verdict:** REPAIR.
4. **Why:** The rule is pure and matches the owner's stated behaviour (same standard spot; slide then flip when clashing; hand placement holds). The 500 mm ceiling is written into the rule and enforced "whatever the setting says"; in the new build it should be an office-list value. The part that moves objects is tied to the old linking. Tested: 10 tests on the rule, plus tidy-up tests (count Unknown).
5. **Evidence:** `LabelPlacementRule.SlideFromPipeEndCeilingMm`.
6. **Risk if taken:** the hard 500 ceiling. **Risk if left:** the slide-then-flip order is rediscovered.

### 15. Grips and the "along or off" behaviour

1. **What it is:** The clickable handles on a selected thing: grips for the pit cover-level flip, pipe attachments and pipe plan.
2. **Where it lives:** `Services/*GripOverrule*.cs`, `PipeOverruleService.cs` (7 overrule files, about 2,300 lines), grip files about 3,400 lines, `Services/PitCoverTextFlipMath.cs` (118), `Drainage.NativeGrip2027/NativeGripProbe.cpp` (1,224).
3. **Verdict:** IDEA ONLY.
4. **Why:** The new design's trial 2 asks whether ordinary text and arrows can be given along, off and flip grips. The old code answers it partly (it uses AutoCAD's grip override hooks) but mainly for the special object. One small pure file (the flip maths) can be reused. Tested: about 165 tests with Grip in the file name.
5. **Evidence:** `PitCoverTextFlipGripOverrule.cs`, `PipeAttachmentActionGripOverrule.cs`.
6. **Risk if taken:** object-type coupling. **Risk if left:** trial 2 starts with no prior art.

### 16. Working out levels along a run

1. **What it is:** "CE proposes levels": picks a start pit, fits inverts and grades down the run, holds typed values and shows by how much a run falls short; an apply step that makes it one undo.
2. **Where it lives:** `Services/Proposals/LevelsProposalEngine.cs` (1,062) and the rest of `Services/Proposals/` (4 files, 1,679 lines), `Commands/RunSolveCommand.cs`, `Services/ProposalApplyService*.cs` (about 1,300).
3. **Verdict:** REPAIR.
4. **Why:** Pure, honest, and already partly in the new shape: typed or fixed levels are never moved, an unknown outlet stays unknown, shortfalls are named by pit and amount, minimum grade and pit drop are applied. Named repair: it always works from the outlet upstream (its own header says direction is "always toward the outlet"); the new design needs hold-anything, work-out-the-rest. Keep it as the oracle: its tested answers say what a correct level run looks like. Tested: 44 tests.
5. **Evidence:** `LevelsProposalEngine.Propose`, `LevelsProposalSelection.Select`.
6. **Risk if taken:** the one-direction shape sets in. **Risk if left:** the "never invent a level" guarantees go untested.

### 17. Pit schedule maker

1. **What it is:** Builds, reviews, overrides, compares and places the pit schedule table on a sheet.
2. **Where it lives:** about 61 files and 26,000 lines, split across `Services/PitSchedule*.cs` (about 35 files), `ScheduleLinkService.cs` (3,903), `ViewModels/PitSchedule*` (about 7,800), `Dialogs/PitScheduleDialog.xaml` (1,306).
3. **Verdict:** REPAIR.
4. **Why:** Used (about 39 runs in the IT records, the most-used drawing command after pit editing and pipe). The row-building rules (grade note, level text, remarks, continuation, merged row overrides, row order) are small files and are the part worth taking; so is the largest test set in the program (about 953 tests, 69 test files). Named repairs: it draws from its own project record, not from the facts; much of it is window code; the schedule exists in two other forms (an Excel path and the pit schedule block). In the new design a schedule row is a view and holds nothing.
5. **Evidence:** `PitScheduleBuilder.cs` (1,332), `PitScheduleOverrideMarkPolicy.cs`, `PitScheduleContinuationLayout.cs`.
6. **Risk if taken:** the 26,000-line shell comes too. **Risk if left:** 953 tests of known-good row behaviour are not reused.

### 18. Checks

1. **What it is:** Checks of the design against the rulebook (speed, grade, cover, pit drop, level agreement), reported in plain sentences, with several different views of the same checks.
2. **Where it lives:** `Rules/RulebookEngine.cs` (1,050), `RulebookValues.cs` (576), `RulebookLevelsCheck.cs`, `Services/Checks/` (13 files, 2,251 lines), `CurrentDrawingCheckService.cs`, `InspectorPaletteService.cs` (3,563), `Commands/HubCommands.cs`; about 6,250 lines of rules and checks code, plus the inspector and views.
3. **Verdict:** REPAIR.
4. **Why:** The rules read their numbers from council, project and office values (the value type carries its source and an "assumed" flag), and each result carries its evidence. That matches "a check is a sum with a status in words". The old plugin has five or more overlapping views of the same drawing (check, dashboard, hub, rules, inspector), which the new design does not want. Tested: 142 tests on the rulebook. Whether any check blocks work: Unknown, not read.
5. **Evidence:** `RulebookEngine`, `RuleSourceEvidence`.
6. **Risk if taken:** the several views. **Risk if left:** the set of checks the office cares about has to be reinvented.

### 19. The repair and audit commands

1. **What it is:** The repair centre and about 20 commands that rebuild links, fix pipe ends, upgrade, audit and triage a drawing that has gone wrong.
2. **Where it lives:** `Services/LinkService.RepairAudit*.cs`, `Commands/Repair*`, audit services; about 15 files and 8,800 lines (more spread elsewhere); `Shared/CE_SHARED/Services/CeDrawingRepairRegistry.cs`; the Manager "Drawing Repair" page.
3. **Verdict:** LEAVE BEHIND.
4. **Why:** The new design replaces repair commands with a self-check on open (does what is drawn still match the notes?). Repair commands exist because facts live in several places and drift (piece 11). Keep only the list of drift cases found (useful input to the self-check). About 206 repair and 164 audit tests exist, mostly pinning the old behaviour.
5. **Evidence:** `LinkService.RepairAudit.Analysis.cs`, `LinkService.RepairAudit.Apply.cs`; `TOOLS_TODAY.md` T-047.
6. **Risk if taken:** the drift machinery stays. **Risk if left:** old drawings with drifted facts need a one-off reader.

### 20. Import of other formats and other packages

1. **What it is:** Reads another civil package's drawing (pits, pipes, schedule), LandXML, and survey points, and compares them with the drawing.
2. **Where it lives:** `Services/Xcivil*.cs` (41 files, about 20,900 lines), `LandXml*` (5 files, about 900), survey (`SurveyService.cs` 955 and about 20 files, about 4,100 lines), Manager `CeCivilSurveyIntakeBridgeSession.cs`.
3. **Verdict:** IDEA ONLY.
4. **Why:** The other-package reader is large, was used about 9 times (one PC) in the IT records, and the August notes record it going wrong (lost the control pit, made 47 false pits out of labels). The owner has reopened the whole question (D-049, "how the plugin consumes existing projects"). Keep the lessons and test cases (about 507 Xcivil tests), not the code. LandXML is small (108 tests) and could be taken later with a repair, but was not read in depth. Survey intake is tied to Manager windows (about 301 survey tests).
5. **Evidence:** `XcivilImportService.cs`, `XcivilEntityScanner.cs`; `TOOLS_TODAY.md` T-045.
6. **Risk if taken:** false pits from label text. **Risk if left:** losing 500 tests of real mess to learn from; mine them.

### 21. Long section

1. **What it is:** Draws a long section from a picked upstream pit, with survey and route review.
2. **Where it lives:** about 14 files and 10,300 lines: `Services/LongitudinalSectionService.cs` (3,411), `ViewModels/LongitudinalSectionViewModel.cs` (2,251), `ProfileRoute*` services (about 2,500).
3. **Verdict:** IDEA ONLY.
4. **Why:** Not in the new design's current tool list. Not read beyond file size, headers and test count (53 tests); judged on size and on being window-heavy. Revisit when the long section is designed with the owner.
5. **Evidence:** `LongitudinalSectionService`, `ProfileRouteReviewService`.
6. **Risk if taken:** a 10,000-line import without a design. **Risk if left:** little; the owner's use is Unknown.

### 22. Slabs, paving and site

1. **What it is:** Slab falls, saw-cut grid, spoon drains, kerbs, paved areas and catchment overlay.
2. **Where it lives:** about 40 files and 12,700 lines: `Services/SlabService.cs` (2,553), `Commands/SlabCommand.cs` (2,041), `SlabFallRegenerationPlan.cs`, `Commands/Catchment*`.
3. **Verdict:** IDEA ONLY.
4. **Why:** The new design lists Slab as a thing; the owner has ruled that nothing optional is forced (D-050). About 430 tests, many of them source pins. Not read in depth; judged on size and on the rulings.
5. **Evidence:** `SlabService`, `SlabFallRegenerationPlan`.
6. **Risk if taken:** forced saw cuts and old behaviour. **Risk if left:** slab fall sums (likely pure) are re-worked; look for them first.

### 23. Placing pits, pipes and sources

1. **What it is:** The commands that place a pit, draw a pipe, and place downpipe, inspection opening, overflow, front overflow, floor waste, trench grate and generic sources; tagging and name-fixing for sources.
2. **Where it lives:** `Commands/PitCommand.cs` (1,148), `PitEditCommand*.cs` (about 5,000), `CdCommand*.cs` (about 3,000), `Services/PipeCreationService.cs` (1,350), `SourcePlacementService.cs` (1,700), `SourceTagService.cs` (997).
3. **Verdict:** IDEA ONLY.
4. **Why:** These are the daily tools (pit edit about 74 runs, pipe 155, in the IT records), so the behaviour matters; but the new design sets a single window plan, short names and one place for every number, and these commands are written around the old stores and object. Take the case lists and tests as the specification of how placement should feel; rewrite the code. Each also goes through the owner's command review gate before anything is rebuilt.
5. **Evidence:** `PitEditCommand.cs`, `CdCommand.cs`, `SourcePlacementService.cs`.
6. **Risk if taken:** muscle memory is kept but the foundation is not. **Risk if left:** staff habits change; the owner has asked that the feel is kept (D-032).

### 24. Whole-network auto design

1. **What it is:** Works out sizes and levels for a whole drawn network from outfall upstream, including a "network redesign" review, apply and ticket system.
2. **Where it lives:** `Services/NetworkDesignService.cs`, `AutoDesignService.cs` (784), `AutoDesignOrchestrator.cs`, and about 40 `NetworkRedesign*` files; about 17,300 lines.
3. **Verdict:** IDEA ONLY.
4. **Why:** The design routes every link towards one fixed outfall (a spanning tree), which is the one-direction assumption in its purest form, and discards loops with a warning. The new design's hold-anything model must be proven first (FOUNDATION, honest limit 1). Take its outputs as comparison data. Tested: 50 tests on network design.
5. **Evidence:** `NetworkDesignService`, `AutoDesignService`.
6. **Risk if taken:** one direction and a large review machine. **Risk if left:** a comparison oracle is lost; keep its test answers.

### 25. Ribbon, command list and windows

1. **What it is:** The CE tab and its panels, the command registry and tool register data files, the contextual tabs, icon sets, and the old drafting windows (about 116 dialogs and 110 view models).
2. **Where it lives:** `Shared/CE_SHARED/Services/RibbonBuilder.cs` (733), `CeRibbonIconCatalog.cs` (652), `CeContextualTabController.cs` (292); `Modules/Manager/Services/CeUnifiedRibbonService.cs` and menu files (1,643); `Modules/Drainage/Assets/Config/command-registry.json` (47 KB), `ce_toolbar_layout.json` (two different layouts ship), `Services/CuiMenuGeneratorService.cs` (1,150); windows in `Dialogs/` (116 files, about 22,300 lines), `ViewModels/` (110 files, about 42,400 lines), `Controls/` (about 8,000), `Themes/`; 230 icon images in Civil and 824 files in the shared icon set.
3. **Verdict:** LEAVE BEHIND.
4. **Why:** The ribbon and every window are being redesigned (D-044, D-047, D-051, D-065 to D-070); the old windows hold their own state and per-window logic. The command registry is a third list of command names beside the code and the contents file (TOOLS_TODAY finds 51 of 145 Civil commands under-reported). Two ideas are worth keeping: the "command truth" tests that prove the list of commands matches what is compiled (`Tests/CE.CommandTruth.Tests`) and the icon set if the owner approves its look (Unknown).
5. **Evidence:** `RibbonBuilder.cs`, `command-registry.json`, `Tests/CE.CommandTruth.Tests/CompiledCommandMetadataReader.cs`.
6. **Risk if taken:** the old look and old naming. **Risk if left:** the command-truth idea is not carried over unless noted.

### 26. The Manager window

1. **What it is:** The CE Suite Manager window: status, updates, settings, help, project and sheets, project QA, survey intake, drawing repair, and an admin dashboard.
2. **Where it lives:** `Modules/Manager/UI/` (32 files, about 8,400 lines; `PluginManagerWindow.xaml.cs` 1,518), `Services/CeProjectSheetsBridgeSession.cs`, `Shared/CE_SHARED/Services/CeProjectQaRegistry.cs` (687); Manager tests about 1,280.
3. **Verdict:** IDEA ONLY.
4. **Why:** The new design wants job tracking in the Manager (D-044, D-045) and nothing like it exists today; the current window is a bundle of eight unrelated pages. Reuse: the project and sheet naming rules (`JobDrawingNamingPatternService`, 325 lines) and the job record service are small pieces worth reading again when the Manager is designed.
5. **Evidence:** `PluginManagerWindow.xaml.cs`, `JobDrawingNamingPatternService.cs`, `JobRecordService.cs`.
6. **Risk if taken:** the eight-page shape. **Risk if left:** small reusable naming rules may be missed.

### 27. Update and install machinery

1. **What it is:** Building, checking, signing, publishing, approving and installing a release: signature and file checks, staged rollout, swap with roll-back, install into AutoCAD's plug-in folder.
2. **Where it lives:** `Installer/` (9 source files and scripts, about 3,100 lines), `ReleaseAuthority/` (3 files, about 1,560), `Shared/CE.Release/` (one file, 3,242 lines), Manager install and update services (11 files, about 3,700 lines), `CE.Cloud/worker`. Installer tests: 328.
3. **Verdict:** IDEA ONLY.
4. **Why:** The new design asks for one program, one install and one update. Today there are four install routes, at least twelve things that must agree for a colleague to end up working (INSTALL_TODAY section 4), and a shared library that must be byte-identical in two bundles. Keep these ideas: refuse when a signature or file hash does not match, keep the old folder and put it back if a swap fails, refuse while AutoCAD is open. Leave the code. Caution on tests: the installer tests include ones that run the live deploy scripts on the PC they run on (project notes), so they must never be run casually.
5. **Evidence:** `Installer/SafeBundleInstaller.cs`, `ReleaseAuthority/`, `Modules/Manager/Services/CeUpdateStagingService.cs`.
6. **Risk if taken:** the fragility the install report lists. **Risk if left:** the signing key is held in one Windows login, so a signing design must be made on purpose.

### 28. Tests and test drawings

1. **What it is:** The automated checks: pure-rule tests, source-reading tests, a headless AutoCAD proof set, stored golden answers, and a baseline sample drawing.
2. **Where it lives:** `Modules/Drainage.Tests/` (1,641 code files, about 324,000 lines, about 23,300 tests); `Modules/Manager.Tests` (about 1,280); `Shared/CE.Spine.Tests` (87); `Installer.Tests` (328); `Tests/` (139 across harness, command-truth and diagnostics); `Modules/Drainage.HeadlessProof` (23 check files, about 6,300 lines); fixtures in `Drainage.Tests/Fixtures` (council baseline, calculation golden rows, pipe parity); `Tests/CE.TestHarness/Fixtures/TH01_Civil_Baseline_v1.dwg`.
3. **Verdict:** REPAIR.
4. **Why:** The count is large but not all of it is behaviour. By a text search, about 498 test files read the program's own source text to pin its wording (a "source pin"), and about 269 use the AutoCAD test host or stubs. The project notes already warn that an old failing guard is not proof. Take: the pure-rule tests (rules, rainfall, council, orifice, pipe sizing, levels) with their golden fixtures; the headless AutoCAD checks (undo, redo, save, layer lock, proxy graphics, same-drawing), which are the closest thing to the new design's four trials; the baseline drawing. Leave: the source pins. The unit tests need AutoCAD's program files present on the PC (the 2027 lane runs real AutoCAD code); the headless set needs AutoCAD's console engine installed. Tests on this PC have touched the owner's real files before (project notes), so run them only on a copy.
5. **Evidence:** `Modules/Drainage.Tests/AutoCadStubLane.cs`, `Modules/Drainage.HeadlessProof/UndoChecks.cs`, `Drainage.Tests/Fixtures/C4CalcGolden/`.
6. **Risk if taken:** pins that guard stale wording. **Risk if left:** the golden answers and headless checks are the cheapest proof the new build has.

### 29. Logging, usage and fault reports

1. **What it is:** Log writing, command outcome and timing records, a support bundle that removes private details, a hash for names, usage and failure records written to the office IT folder, and the "send a fault report" path.
2. **Where it lives:** `Shared/CE_SHARED/Services/CeLogWriter.cs` (387), `CeTelemetryStore.cs`, `CePiiHash.cs` (160); `Shared/CE.Diagnostics/` (3 files, 1,113); Manager `CommandOutcome*`, `CeSupportBundleService.cs` (320), `CeSupportBundleScrub.cs`, `CeDiagnosticsService.cs` (383), `CeAdmin*` (6 files, about 2,000).
3. **Verdict:** REPAIR.
4. **Why:** Worth keeping: the scrub of private text before a bundle leaves the PC, and the one-record-per-run idea, which already gave real evidence (2,637 usage records, 1,029 failure records). Named repairs: only commands the plugins wrap are recorded; records pile up one file per run in a synced folder; log folders sit in at least seven places. Client and job names appear in log file names (INSTALL_TODAY fragility item 23), which the new build must stop. Tested: two diagnostics test files (`Tests/CE.Diagnostics.Tests`) plus Manager tests.
5. **Evidence:** `CeSupportBundleScrub.cs`, `CePiiHash.cs`, `CeTrackedCommandRunner.cs`.
6. **Risk if taken:** private names in file names. **Risk if left:** the new build is blind about what goes wrong on colleagues' PCs.

### 30. The AI assistant and the help pages

1. **What it is:** An optional "Ask CE" assistant (switched off by default), the shared AI core, a small cloud worker, and the help centre pages and tours.
2. **Where it lives:** `CE.AI.Core/` (11 files, 1,335 lines), `Modules/Drainage/AI/` and `Controls/CeAssistantControl` (about 4,600 lines in all), `CE.Cloud/worker/`, `Services/CeAiMasterSwitch.cs`; help in `Assets/Help/` (guide pages and script, about 45 KB), `Services/CivilHelpHost.cs` (965), `Shared/CE_SHARED/Help`.
3. **Verdict:** LEAVE BEHIND.
4. **Why:** No decision in D-001 to D-087 asks for an assistant or for in-plugin help (searched for "AI" and "assistant"; none found), and the AI path can send drawing text off the PC, which the code's own switch comment flags for a privacy review. The help text describes the old commands. Revisit only if the owner asks. Not judged in depth.
5. **Evidence:** `CeAiMasterSwitch.IsOn`, `CE.AI.Core/`.
6. **Risk if taken:** privacy and upkeep for a feature nobody asked for. **Risk if left:** none yet.

---

## The ten most valuable things to take

1. **Orifice sums** (piece 1): short, pure, both directions.
2. **Storage in pipes, pits and tanks** (piece 2): the part-full pipe maths behind the council-facing storage figure.
3. **Rainfall data and curve** (piece 5): one small file, one formula, tested.
4. **The council data structure and its sourced figures** (piece 6): value, source, plain note, council then project then office order.
5. **Pipe capacity sums with their stored golden answers** (piece 4): the parity fixtures are a ready check on any rewrite.
6. **The office blocks** (piece 9): the office's own symbols, exactly as drawn.
7. **The pure rules folder as a whole** (see the fact at the top): 304 files, only 5 touch AutoCAD; this is the real "brain" to mine.
8. **The levels engine as a test oracle** (piece 16): "never invent a level", shortfall by pit and amount.
9. **The pit schedule row rules and their tests** (piece 17): about 953 tests of row behaviour.
10. **The headless AutoCAD checks and baseline drawing** (piece 28): undo, redo, save, layer lock and proxy graphics are the new design's trial list in miniature.

## The things most likely to drag the old problems in if taken

1. **The special pipe object and its upgrade-on-open service** (piece 10): breaks "looks and plots identical without the plugin".
2. **The linking code** (piece 13): 54,700 lines in one class, written around the object and several stores.
3. **The several places where one fact is held** (piece 11): taking the project record or the spine mirror brings drift and recovery code with it.
4. **The one-class settings store** (piece 7): a new value means new code, the opposite of a new line in a list.
5. **Assumed council figures** (piece 6): 287 of 410 look like data but are placeholders.
6. **Placeholder speed limits** (piece 4): marked as unconfirmed in the code.
7. **One-direction level sums** (pieces 4, 16, 24): upstream above downstream, always toward one outlet.
8. **Source-pin tests** (piece 28): about 498 test files that guard wording rather than behaviour.
9. **The old windows and view models** (piece 25): about 42,400 lines of window logic, and state kept inside windows.
10. **Install machinery and its live-deploy tests** (piece 27): four routes, byte-identical shared library, administrator rights.

## What I could not judge and why

1. **Whether any tests pass today.** Tests were counted by text, not run (rule: no builds).
2. **Which of the 23,300 tests are source pins.** The 498 figure is a text-search estimate (files that read source text or use pin and repo-root helpers), not an exact count.
3. **Block contents.** The 18 office blocks and the Structural duplicates were not opened; which are dynamic blocks and which attributes the code relies on is Unknown.
4. **Long section, slabs, network design, survey intake, LandXML, council letters, the AI assistant.** Judged from size, headers, test counts and the rulings; not read in depth.
5. **Check behaviour.** Whether any check blocks work was not read.
6. **How much of the old code a colleague actually uses.** Only the IT-folder counts in `TOOLS_TODAY.md` (two PCs, mostly April) were available.
7. **Whether the 22 council profiles agree with the councils' current documents.** Only the recorded provenance was read, not the council documents.
8. **Structural, the Excel binding library and the C++ self-test files** were outside the scope or not read.
9. **Job-tracking pieces for the Manager:** the old code has nothing for it, so there was nothing to judge.
10. **Line counts include comments and blank lines**, so sizes are generous. Source comments in the old code also quote the owner and name people; none of that was copied here, but it must be cleaned out before any file is taken.

## Tally

1. **Pieces:** 30.
2. **TAKE:** 4 (orifice, storage, rainfall, tank library).
3. **REPAIR:** 11 (top water level and sizing, pipe capacity, council data, office blocks, spine library, label placement, levels, pit schedule, checks, tests, logging).
4. **IDEA ONLY:** 10 (settings store, linking, grips, import, long section, slabs, placing commands, network design, Manager window, install).
5. **LEAVE BEHIND:** 5 (special pipe object, drawing data stores, repair and audit, ribbon and windows, AI and help).
