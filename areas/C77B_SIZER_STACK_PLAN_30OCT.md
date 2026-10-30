# C-77b plan: the pipe sizer stack, #1863 (BUG-1088) and #1868 (BUG-1091), Fri 30 Oct 2026

CE 01 Build job B-043a, Opus 5.5 (claude-opus-5-5), headless. **Read-only planning job.** No build, no test, no AutoCAD, no repo edit, no PR touched. I made throwaway trial merges in a detached checkout (`C:\ce-fx\o9`, removed at the end; nothing pushed from it). Real clock 12:12 to about 12:35 Melbourne (Git Bash `date`).

## FOR TIM

1. **What these two fixes do, in one line each:**
   1. **BUG-1088 (#1863):** when CE picks a pipe size, it tries the flattest fall each size is allowed and goes up a size before making a pipe steeper. A 40 L/s connection pipe comes out DN225 at 1 in 100, not DN100 at 1 in 3.
   2. **BUG-1091 (#1868):** when you fill in the minimum fall for pipes 450 mm and larger in Settings, Civil Design and the network redesign obey it too, not just Edit Pipe and CDRULES. A 450 carrying 30 L/s gets 1 in 200 if you typed 200, not about 1 in 890.
2. **They do not fight each other.** One changes how the sizer searches. The other changes which falls the sizer is given. Together they fit: with your large-pipe fall typed in, a big flow steps up a size rather than going steeper on a 450.
3. **Why #1863 clashes with the C-77 build:** only because both edited the same two spots: the list of settings CDRULES ignores, and the top of the change log. Nothing in the engineering clashes. The fix is "keep both". I tried it on a throwaway copy and it comes out exactly right.
4. **Order:** #1863 first, then #1868. #1863 has already passed its own tests; #1868 has never been built, so if it breaks, the builder knows which one did it.
5. **Today, with the large-pipe row blank (as shipped), #1868 changes nothing at all.** It only matters once someone types a figure in that row.
6. **One thing to check with your own eyes later (not a fault):** when you said yes to BUG-1088 you said "about 1 in 200". The fix gives 1 in 100, because your guidebook ruling made 1 in 100 the flattest fall for every ordinary size. If you want 1 in 200 for connection pipes, that is a Settings change, not a code change.
7. **What a drafter will see after C-77b:** CDDESIGN's connection pipe and CDRUNSOLVE propose larger, flatter pipes. Network redesign holds big pipes to your large-pipe fall when you have typed one.
8. **Nothing is built or tested by this job.** This is the plan for the builder. Nothing goes to AutoCAD until the builder's tests pass.
9. **Nothing for you to decide now.** Point 6 is for when you look at it in AutoCAD.

---

## ANSWER FIRST (technical)

1. **No PR number: this job writes a plan, not a PR.** The plan is for a Sonnet builder to merge #1863 then #1868 onto C-77b (`claude/rel-20261030b`), add one test file, build, test.
2. **The train moved while I worked.** At 12:13 `origin/claude/rel-20261030a` was `c87249c6`; at 12:18 it was **`b40fa2a4`** ("Merge PR #1844 (B-035b ...)"; it now also holds #1851 at `7c547ebb`). Every trial below was redone on `b40fa2a4`. **The tree hashes in `C77B_COUNCIL_MERGE_PLAN_30OCT.md` were taken on `c87249c6` and no longer apply as written** (its conflict hunks are still the same; see 2.4).
3. **Heads (`git ls-remote`, 12:13):** #1863 = `30990e61` (`fb/bug1088-sizer-grade-ladder`), #1868 = `c88cd7dc` (`fb/bug1091-redesign-reads-min-fall`), #1841 = `ead7c837` (`claude/gb01-slice1-falls`, merged in the train as `f495fcc5`). **Both PRs branch from `78fda55b`** (slice 1 before its Opus fix `ead7c837`). Neither PR has `ead7c837`. Neither has been tested on C-76 or C-77 code.
4. **Conflicts.** #1863 on the train: 2 files, 1 hunk each (`Rules/RulebookValues.cs`, `REGRESSION_LOG.md`). #1868 after #1863: 2 files, 1 hunk each (`Models/UserSettings.cs`, `REGRESSION_LOG.md`). Every hunk is "keep both". `PipeSizingSolver.cs`, `SettingsSizingStandards.cs`, `AutoDesignService.cs` and `NetworkDesignService.cs` merge cleanly. `PipeSizingModels.cs` is touched by neither PR.
5. **Proof the trial resolution is exact:** after each trial merge, `git diff --numstat HEAD^1 HEAD` equals the PR's own `git diff --numstat 78fda55b <head>`, file by file. #1863: 8 files, 446 added, 3 removed. #1868: 4 files, 147 added, 6 removed. Trees from `b40fa2a4`: **after #1863 = `92a6881bd04b928c0845783bf66ed0b31c1ecb35`**, **after #1868 = `d30a2bdda2f094a5f221ae2d57a8317ff0e164d5`**.
6. **One code path (question 4): yes, once both are in.** Every designer gets its falls from `PipeSizingStandards.CreateDefault()`, which reads the one Settings ladder through `SettingsSizingStandards.GradeLadder`; inside the sizer both the minimum-grade clamp and the new step-up pass read `PipeSizingSolver.LookupMinGrade`. Detail in section 4.
7. **NOT proven:** #1868 has never compiled. #1863 has compiled and passed 72 focused tests on its own base, but its full suite and net48 compile never ran. The combined stack has never been compiled. Nothing has been in AutoCAD.
8. **Robot case:** `N90_redesign_450_fall` with control `C90` (section 6), plus the existing `N88_sizer_grade` / `C88` from the BUG-1088 report.

## 1. Why #1863 conflicts, and the final text of each hunk

**Why:** #1863 was written on slice 1 at `78fda55b`. The train has since taken slice 1's Opus fix `ead7c837`, slice 2/3 (#1851) and about twenty other changes. Two of them add lines in the very spots #1863 adds lines:

1. `RulebookValues.cs`: slice 2 (via #1851) added the cover-table "kept out of the plain office object" block straight after the `networkUsesPipeMaterial` exclusion, which is where #1863 adds the `sizerStepsUpBeforeSteepGrade` exclusion. Both share the closing line `property.ShouldSerialize = _ => false;`, so git cannot place them.
2. `REGRESSION_LOG.md`: every train change adds its entry at the top, and so does #1863.

`ead7c837` itself only clashes through the log (its `RulebookValues.cs` change is in the fingerprint method, about 130 lines away, and merged cleanly).

Rule for every hunk: keep both sides. Resolve with the **Edit tool**, never sed or awk (the council plan's trial lost five minutes to sed writing a literal `r`). After each merge check no marker is left: `grep -n '^<<<<<<<\|^|||||||\|^=======$\|^>>>>>>>' Modules/Drainage/Rules/RulebookValues.cs Modules/Drainage/Models/UserSettings.cs REGRESSION_LOG.md` prints nothing.

### Merge 1: #1863 (`git merge --no-ff origin/fb/bug1088-sizer-grade-ladder`, expect head `30990e61`)

**Hunk 1A, `Modules/Drainage/Rules/RulebookValues.cs`, about line 481** (inside `FingerprintContractResolver.CreateProperty`). The train's block first, with its own closing line, then #1863's two lines and its own closing line. Final text from the `networkUsesPipeMaterial` exclusion to `return property;`:

```csharp
                if (member.DeclaringType == typeof(DesignStandards) && property.PropertyName == "networkUsesPipeMaterial")
                    property.ShouldSerialize = _ => false;
                // GB-01 slice 2: the cover table decides an answer only for a pit with a surface picked, so it joins the fingerprint through
                // RulebookEngine.Fingerprint, and only for a job that has such a pit; it is kept out of the plain office object here.
                if (member.DeclaringType == typeof(DesignStandards) &&
                    (property.PropertyName == "minCoverBySurfaceMm" || property.PropertyName == "minCoverPavedSlabMm" ||
                     property.PropertyName == "minCoverPavedSurfaces" || property.PropertyName == "minCoverCouncilFigureIsFloor"))
                    property.ShouldSerialize = _ => false;
                // BUG-1088 (29 Oct 2026): sizerStepsUpBeforeSteepGrade is read only by the pipe sizer, never by CDRULES.
                if (member.DeclaringType == typeof(DesignStandards) && property.PropertyName == "sizerStepsUpBeforeSteepGrade")
                    property.ShouldSerialize = _ => false;
                return property;
```

The trap: the conflict shows ONE `property.ShouldSerialize = _ => false;` below the `>>>>>>>` marker. It belongs to both `if`s, so the resolution must write it twice (once after the cover-table `if`, once after the BUG-1088 `if`). Writing it once would make the cover-table `if` govern the BUG-1088 `if` and the cover table would no longer be excluded.

**Hunk 1B, `REGRESSION_LOG.md`, line 1.** The base side is empty. Final text: #1863's whole entry (16 lines, from `## BUG-1088: CDDESIGN and network sizing now try each pipe size ...` to `9. **Undo:** revert this commit, or set the switch false.`) on top, one blank line, then the train's entries unchanged starting at `## B-035b (follow-up to F-023, DRAFT PR #1844) ...`, down to the slice 1 Opus entry ending `... This follow-up changes only the fingerprint.`, a blank line, then `## GB-01 slice 1: the flattest fall is 1 in 100 ...` as before.

Commit message: `Merge PR #1863 (B-020, BUG-1088, the sizer tries the flattest allowed grade first) at 30990e61`.

### Merge 2: #1868 (`git merge --no-ff origin/fb/bug1091-redesign-reads-min-fall`, expect head `c88cd7dc`)

**Hunk 2A, `Modules/Drainage/Models/UserSettings.cs`, about line 1440** (the `PipeSettings` group, after `editPipeReverseArrowReadsDrawnEnds`). The shared `/// <summary>` line sits ABOVE the `<<<<<<<` marker, so the second block needs its own `/// <summary>` line added back. Final text:

```csharp
        [JsonProperty("editPipeReverseArrowReadsDrawnEnds")]
        public bool EditPipeReverseArrowReadsDrawnEnds { get; set; } = true;

        /// <summary>
        /// BUG-1229 (MEDIUM, wrong answer): ... (the train's text unchanged) ...
        [JsonProperty("suggestedLevelNeverFlatterThanGrade")]
        public bool SuggestedLevelNeverFlatterThanGrade { get; set; } = true;

        /// <summary>
        /// BUG-1226 (card D05): ... (unchanged) ...
        [JsonProperty("recentInvertButtonsOnMainPage")]
        public bool RecentInvertButtonsOnMainPage { get; set; } = true;

        /// <summary>
        /// B-043 (New Pipe declutter v2, slice S1, BUG-1238): ... (unchanged) ...
        [JsonProperty("declutteredLayout")]
        public bool DeclutteredLayout { get; set; } = true;

        /// <summary>
        /// BUG-1091 (HIGH): ON = Civil Design, auto-design and the network redesign hold a pipe of 450 mm and larger to the SAME
        /// ... (the PR's six lines unchanged) ...
        /// moves; nothing is written. Fixes a fault, so ships ON. Not a block (R-27). Default: on.
        /// </summary>
        [JsonProperty("largePipeRedesignReadsMinFall")]
        public bool LargePipeRedesignReadsMinFall { get; set; } = true;

        /// <summary>
        /// Tim, 15 Sep 2026: when a newly drawn pipe runs ACROSS existing pits, ...
```

Three Edit-tool edits do it: delete the `<<<<<<< HEAD` line under the first `/// <summary>`; replace the three lines `||||||| 78fda55b` / `=======` / (nothing) with one blank line plus `        /// <summary>`; delete the `>>>>>>> c88cd7dc` line.

**Hunk 2B, `REGRESSION_LOG.md`, line 1.** Final text: #1868's entry (11 lines, `## BUG-1091: Civil Design, auto-design and the network redesign now hold ...` to `6. **REDO and layers:** ...`) on top, one blank line, then `## BUG-1088: ...` (from merge 1) and everything below unchanged. The log heading order after both merges: BUG-1091, BUG-1088, B-035b, C-77 finalizer, ...

Commit message: `Merge PR #1868 (B-019, BUG-1091, redesign reads the large-pipe minimum fall) at c88cd7dc`.

## 2. Do #1863 and #1868 overlap or contradict? Order

1. **No contradiction. They are two halves of one rule.**
   1. #1863 changes HOW the sizer searches (`PipeSizingSolver.TrySize`, new three-argument overload: a first pass that takes the smallest size whose answer sits exactly at that size's minimum grade, then the old search unchanged as the fall-back). It is called with the switch only from `AutoDesignService.SizeConnectionPipe` and the two calls in `NetworkDesignService.Design` (sizing and re-check).
   2. #1868 changes WHAT the sizer is given (`SettingsSizingStandards.ForEveryMaterial` stops dropping the DN450-and-up rows that `DesignStandards.EffectiveMinGradeLadder()` adds when `largeGravityMinGradeN` has a figure).
2. **Files.** Shared: `UserSettings.cs` (different groups: #1863 adds `designStandards.sizerStepsUpBeforeSteepGrade`, #1868 adds `pipe.largePipeRedesignReadsMinFall`) and `REGRESSION_LOG.md`. Only #1863 touches `PipeSizingSolver.cs`, `RulebookValues.cs`, the callers and the new `Rules/SizerGradeLadderRule.cs`. Only #1868 touches `SettingsSizingStandards.cs`. **Neither touches `PipeSizingModels.cs` or the `largeGravityMinGradeN` row itself** (slice 1 owns it; both only read it).
3. **Where they meet:** `PipeSizingSolver.LookupMinGrade`. With #1868 ON and the row filled, DN450-and-up sizes have a minimum, so #1863's first pass treats them as "has a flattest grade" instead of "Unknown, take as before". Worked through:
   1. **Row blank (as shipped):** #1868 gives the same list ON and OFF (its own test pins this), so the stack behaves exactly as #1863 alone. #1863's test "300 L/s steps to DN450 at the grade the flow needs" still holds (it also uses hand-built standards, not Settings).
   2. **Row = 200, network redesign keeping the existing 450 at 30 L/s (concrete):** redesign runs `NetworkDesignService.Design` in `PreserveExistingSizes` mode, so the size list is just {450} (`NetworkDesignService.PreserveExistingSizes.cs`, `TryBuildPreservedStandards`, about line 77). The flow wants about 1 in 890 (self-cleansing 0.6 m/s governs); `TryDiameter` steepens it to 1 in 200; #1863's pass accepts it (exactly at the minimum). **Answer 1 in 200.** #1868 does the work; #1863 changes nothing here.
   3. **Row = 200, free sizing of a large flow (CDRUNSOLVE), say 250 L/s concrete:** DN450 at 1 in 200 carries only about 200 L/s, so #1863's pass steps up to **DN525 at 1 in 200** (about 300 L/s) instead of DN450 steeper. That is Tim's "a size up before steeper" rule applied to big pipes with the figure he typed. Without #1868 the 450 had no minimum and #1863 took DN450 at the steeper grade.
   4. **Small flows (CDDESIGN connection pipes):** unaffected by the large row; 30 L/s concrete is DN225 at 1 in 100 with either row value.
4. **Order: #1863 first, then #1868.** Textually the order does not matter (I trial-merged #1868 directly on the train: the same two files clash). Choose #1863 first because (a) it has compiled and passed 72 focused tests on its own base (B-020b), #1868 never compiled, so a compile error after merge 2 points at #1868; (b) it matches the job's own wording ("#1868 stacked on #1841, touches the sizing code too"); (c) the tree hashes in section 1 assume it.
5. **Against the council half of C-77b (#1854, #1855):** independent. I trial-merged #1854 and #1855 each onto the train with and without this stack: the same files conflict, with the same hunk count (#1855's `UserSettings.cs` conflicts stay at 2 hunks, only shifted 11 lines). #1855's `RulebookValues.cs` change (the `CouncilProfile` block and the new `InformationOnlyProvenanceFilter` class) does not touch the lines #1863 adds. Recommended C-77b order: **#1863, #1868, then #1854, #1855** (the sizer stack is pilot-critical, decision 32: "build all three before 6 Nov"). If the council builder has already pushed `claude/rel-20261030b`, start from its head instead; the hunks above are the same, but my tree hashes then do not apply (use the numstat check).

## 3. Ready-to-run step list for the Sonnet builder

Read first: memory notes `build03-worktree-and-leak-scan-traps`, `drainage-tests-run-on-net10-with-placeholder-arx`, `bash-heredoc-mangles-backslashes`. All slot rules of the brief apply (count top-level `dotnet build|test|msbuild|publish|restore` processes with your own `.ps1`; run only at 0; below-normal priority; never match claude or pwsh processes).

1. **Start point.** `git fetch origin`. Read `git ls-remote origin refs/heads/claude/rel-20261030a refs/heads/claude/rel-20261030b refs/pull/1863/head refs/pull/1868/head`.
   1. Expect `30990e61` for #1863 and `c88cd7dc` for #1868. If either head moved, stop and report (the PR changed after this plan).
   2. If `claude/rel-20261030b` does NOT exist: `git worktree add -b claude/rel-20261030b C:\ce-fx\s77 origin/claude/rel-20261030a`. Note its head; if it is `b40fa2a4` the tree hashes in step 2 and 3 apply.
   3. If it DOES exist (the council merges went first): `git worktree add C:\ce-fx\s77 claude/rel-20261030b` after a fetch; the tree-hash checks do not apply, use the numstat checks.
2. **Merge #1863:** `git merge --no-ff --no-commit origin/fb/bug1088-sizer-grade-ladder`. Resolve hunks 1A and 1B exactly as section 1, with the Edit tool. Marker grep must print nothing. `git add` the two files by name, commit with the message in section 1 plus the Co-Authored-By line. Checks: `git diff --numstat HEAD^1 HEAD` equals `git diff --numstat 78fda55b 30990e61` (8 files, 446/3); on `b40fa2a4`, `git rev-parse HEAD^{tree}` = `92a6881bd04b928c0845783bf66ed0b31c1ecb35`.
3. **Merge #1868:** same with `origin/fb/bug1091-redesign-reads-min-fall`, hunks 2A and 2B. Checks: numstat equals `git diff --numstat 78fda55b c88cd7dc` (4 files, 147/6); tree = `d30a2bdda2f094a5f221ae2d57a8317ff0e164d5`. Git warns "LF will be replaced by CRLF" on the log; that is normal (autocrlf is on). If the tree differs but numstat matches, run `git diff d30a2bdd HEAD` to see the difference before going on.
4. **Add the stack tests** in a new file `Modules/Drainage.Tests/Services/C77bSizerStackTests.cs`, `[TestFixture, NonParallelizable]`, each test inside `SettingsService.BeginTestScope(new UserSettings(), <temp path>)` (as `Bug1091RedesignReadsMinFallTests` does). Concrete pipe, 30 m long, the BUG-1091 report's example:
   1. `Redesign450At30Lps_BothOn_Row200_IsOneIn200`: `NetworkDesignService.Design` in `PreserveExistingSizes` mode (model the inputs on `NetworkDesignPreserveExistingSizesTests.Request`, one pipe A to OUT, existing DN450, 30 L/s, standards `null` so `CreateDefault()` is used), `LargeGravityMinGradeN = 200`: feasible, DN450, grade within 1e-6 of 200, `RevalidatesClean` true (the re-check reads the same switch and the same list).
   2. `Redesign450At30Lps_Switch1091Off_GivesTheOldFlatterAnswer`: same with `Pipe.LargePipeRedesignReadsMinFall = false`: grade greater than 200, and equal (1e-6) to the answer with both switches OFF. Do not pin 890 exactly; it depends on the Settings self-cleansing speed.
   3. `Redesign450At30Lps_Switch1088Off_StillOneIn200`: `SizerStepsUpBeforeSteepGrade = false`, 1091 ON: still 1 in 200 (the clamp in `TryDiameter` holds the minimum on its own; #1863 adds nothing on a one-size list).
   4. `RowBlank_TheStackEqualsBug1088Alone`: row blank, both ON: the 450 answer equals the 1091-OFF answer, and `CreateDefault().MinGradeByDiameter` has no key "450".
   5. `FreeSizing250Lps_Row200_StepsUpToDn525AtOneIn200`: `PipeSizingSolver.TrySize(request, CreateDefault(), true)` (or a free-sizing `NetworkDesignService.Design`), 250 L/s, row 200: DN525 at 1 in 200, capacity at least 250 L/s; with the row blank: DN450, grade steeper than 200. Read the size list from `CreateDefault()` first and skip with a clear message if 525 is not in it.
   6. `ConnectionPipe30Lps_Row200_Unchanged`: CDDESIGN's `SizeConnectionPipe` (by reflection, as `Bug1088SizerGradeLadderTests` does): 30 L/s gives the same diameter and grade with row 200 and row blank (DN225 at 1 in 100 expected).
   7. `OneValue_EveryScreen`: with row 200, the DN450 figure is 200 in `PipeSizingStandards.CreateDefault()`, `SettingsSizingStandards.ForEveryMaterial`, `SettingsSizingStandards.ForMaterial(office, "Concrete")`, `NetworkRedesignNominationService.WithRulebookCover()` standards (or `PipeFlowSizingAdvisorService.StandardsWithRulebookCover()`) and `RulebookValues.Resolve(office, null, null).MinGradeFor(450)`.
   8. Commit: `C-77b: tests for the sizer stack (BUG-1088 plus BUG-1091): a 450 at 30 L/s holds 1 in 200 in redesign, both switches checked`.
5. **Build (one slot, count must be 0), from the worktree:** `dotnet build Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -c Release -f net10.0-windows -m:8 -p:SkipDevBundle=true -nr:false --disable-build-servers` with the refs from the C-62 report (`_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`), AutoCAD 2027 on PATH, the 0-byte `CE_TRANSFORM_2027.arx` placeholder (untracked), TEMP and CE log override inside the worktree's own scratch. 0 errors required.
6. **Focused tests (`--no-build`, same flags):** filter `FullyQualifiedName~Bug1088|FullyQualifiedName~Bug1091|FullyQualifiedName~C77bSizerStack|FullyQualifiedName~Gb01Slice1|FullyQualifiedName~C75NewSwitch|FullyQualifiedName~C76NewSwitch|FullyQualifiedName~CL5OneSizingStandards|FullyQualifiedName~PipeSizingSolver|FullyQualifiedName~NetworkDesign|FullyQualifiedName~NetworkRedesign|FullyQualifiedName~AutoDesign|FullyQualifiedName~ConnectionPipeAssumption|FullyQualifiedName~PipeFlowSizingParity|FullyQualifiedName~PipeGradeAdvisor|FullyQualifiedName~NewSettingsKeys|FullyQualifiedName~RulebookEngine`. **Check the count is not 0** (B-020b's narrower filter ran 72). 0 failed.
7. **If a sizing test turns red** (most likely in `AutoDesignServiceTests`, `AutoDesignBackTestTests`, `AutoDesignCalibrationBatchTests`, `NetworkDesignServiceTests`, `NetworkDesignSnapshotTests`, `NetworkRedesignSolverServiceTests`; #1863's full suite never ran): it is a real behaviour change, not a broken test. Follow the BUG-905 pattern: make the old pin set `sizerStepsUpBeforeSteepGrade` (or `largePipeRedesignReadsMinFall`) false so it still pins the old answer exactly, and add the ON answer next to it. Never just change the expected number. List every such test by name in the report.
8. **Full Civil suite once** (net10, Release). Expected known failures: the two Debug-only IL-shape tests in `SourceAtomicCoordinatorDependencyTests` and the one PDF page test that needs AutoCAD's renderer (re-run it alone). Compare failing names with the C-77 assembly report; anything else is ours.
9. **net48 compile:** `dotnet build Modules\Drainage\CE_CVL_SUITE.csproj -c Release -f net48 ...` same flags and refs. 0 errors.
10. **Log wording:** one more commit that changes the first paragraph of the BUG-1088 entry ("WRITTEN, NOT YET COMPILED OR RUN ...") and the BUG-1091 entry ("NOT YET BUILT OR RUN ...") to the real results, and adds a short `## C-77b: sizer stack` entry (both switches, the 450 at 30 L/s answer, test names). Keep both sides; newest on top.
11. **Push** `claude/rel-20261030b` (never force). Do not open, retarget, close or merge #1863 or #1868; add a comment on each naming the C-77b merge commit only if the brief allows comments. Clean bin/obj with `git clean -fdXq` inside `C:\ce-fx\s77` only.

## 4. One code path: how CDDESIGN, auto-design and network redesign read the same minimum fall

After both merges, there is one figure and one reader:

1. **The figure:** `designStandards.largeGravityMinGradeN` (`Models/UserSettings.cs`, about line 2556) for DN450 and up, and `designStandards.minGradeByDiameter` (about 2529) for 90 to 375.
2. **The one list:** `DesignStandards.EffectiveMinGradeLadder()` (about 2582) joins them; a blank large row adds no 450-and-up key.
3. **The one reader into the sizer:** `SettingsSizingStandards.GradeLadder` (shared by `ForMaterial` and `ForEveryMaterial`). Before #1868, `ForEveryMaterial` filtered to the six 90 to 375 keys and dropped the large rows; after, it keeps them (switch ON).
4. **Every designer goes through `PipeSizingStandards.CreateDefault()`** (`Models/PipeSizingModels.cs` 111 to 112, which is `ForEveryMaterial(CurrentOffice())`):
   1. CDDESIGN connection pipe: `AutoDesignService.SizeConnectionPipe` (`AutoDesignService.cs` about 695).
   2. CDDESIGN window / auto-design: `AutoDesignOrchestrator.cs` 210 (`inputs.Standards ?? CreateDefault()`).
   3. CDRUNSOLVE: `NetworkDesignService.Design` (`NetworkDesignService.cs` 97, `inputs.Standards ?? CreateDefault()`).
   4. Network redesign (Civil hub, `CivilHubService.cs` 83 and 109; `NetworkRedesignApplyCoordinator.cs` 291): `NetworkRedesignNominationService.WithRulebookCover()` (line 49) calls `PipeFlowSizingAdvisorService.StandardsWithRulebookCover()` (95 to 100), which is `CreateDefault()` plus the rulebook cover; the evidence copies it; `NetworkRedesignSolverService` (23, 239) runs `NetworkDesignService.Design` in `PreserveExistingSizes` mode, which copies the same ladder into the one-size list.
5. **Inside the sizer, one lookup:** `PipeSizingSolver.LookupMinGrade` (about line 454) feeds both the clamp in `TryDiameter` (about 272) and #1863's new step-up pass. So the minimum and "the flattest grade it is allowed" can never be two numbers.
6. **The checkers read the same list:** Edit Pipe and CDRULES through `ForMaterial` (`MaterialVelocityLimits.cs` 85 and 190) and `RulebookValues.Resolve` (`RulebookValues.cs` 295, `EffectiveMinGradeLadder()`).
7. **Two switches, two groups:** `designStandards.sizerStepsUpBeforeSteepGrade` (how to search) and `pipe.largePipeRedesignReadsMinFall` (which rows the designers see). Both "Default: on.", both pinned through `DeserializeSettings` and `DeserializeSettingsTolerant` in their own test files (not in `C75NewSwitchDefaultsTests`). Neither is on the Settings page.
8. **Exception, not closed by either PR:** a caller that passes its own `inputs.Standards` bypasses `CreateDefault()`. I did not trace who sets `AutoDesignInputs.Standards` or `NetworkInputs.Standards` outside tests.

## 5. Risks and what is unproven

1. **#1868 has never compiled.** Read-checked only (by its author and by me). Things that must compile: `office.LargeGravityFromMm`, the `out double dn` pattern (fine on net48's C# level), `SettingsService.Current?.Pipe?.LargePipeRedesignReadsMinFall`. The file now ends without a newline (cosmetic).
2. **#1863's full suite never ran.** Its switch is ON by default and changes CDDESIGN and CDRUNSOLVE sizes, so older sizing tests may pin the old sizes (step 7). This is the biggest unknown.
3. **#1868 reaches further than its report says.** Its report names Civil Design, auto-design and network redesign. `CreateDefault()` is also used by the CD (New Pipe) grade suggestion (`CdCommand.GradeSuggestion.cs` 381, `CdViewModel.Inverts.cs` 910), `PipeFlowSizingAdvisorService` (97, 105), `PipeGradeAdvisorService` (51), `MarkupToChangePlanService` (99) and `ProposalApplyService.PlanBuilders.cs` (268, 546). With a large-pipe figure typed in, those now hold DN450-and-up to it too. Same direction as Edit Pipe and CDRULES, so it serves "one value", but nobody has looked at those screens with the row filled. With the row blank (as shipped) nothing changes anywhere.
4. **Tim's words vs the answer:** decision 37 says "DN225 at about 1 in 200"; the code gives 1 in 100 (slice 1 made 1 in 100 the flattest fall at every ordinary size). Stated in the BUG-1088 report too. Not a code fault; Tim may want to see it.
5. **Test isolation:** `Bug1088SizerGradeLadderTests` has no `BeginTestScope`; its CDDESIGN and network cases read the global `SettingsService.Current`. If any test leaves `largeGravityMinGradeN` filled or a switch OFF, they turn order-dependent. The new stack tests must use their own scope.
6. **Redesign staleness:** `NetworkRedesignNominationService` names its standards with fixed text (`"PipeSizingStandards.CreateDefault+rulebook-cover/office-seed-v1/advisory-only"`, lines 17 and 22). A preview made before the large row was typed may not read as out of date after. Not checked.
7. **Gaps carried from the BUG-1091 report:** sizes between 375 and 450 have no minimum; DN1000 and sizes not in the 15-size large list get none (exact-key lookup).
8. **The council plan's tree hashes are stale** (train moved from `c87249c6` to `b40fa2a4` at about 12:15). Its hunk-by-hunk text still applies.
9. **Not proven anywhere:** compile of the stack, any test of the stack, net48, anything in AutoCAD (CDDESIGN result text and sheet, CDRUNSOLVE, the redesign preview).

## 6. Robot case that proves the stack, with a switch-off control

1. **Name:** `N90_redesign_450_fall` (Civil), control `C90`. Keep `N88_sizer_grade` / `C88` (BUG-1088 report) for the connection pipe.
2. **Set-up (before AutoCAD starts; CE reads Settings at start-up):** a fixture copy holding one DN450 concrete pipe whose design flow is about 30 L/s (the case writer records the flow); in the copy's settings file `designStandards.largeGravityMinGradeN` = 200.
3. **N90 types:** open the Civil hub and run the network redesign preview for that network, keeping existing sizes (the case writer confirms the exact route; it goes through `CivilHubService` lines 83/109). **Checks:** the proposed grade for the 450 reads **1:200** (pass) and not about 1:890 (fail). Then Edit Pipe on the same pipe: the strip's minimum fall reads 1:200 (same value).
4. **C90 (control):** same copy, `pipe.largePipeRedesignReadsMinFall` set to false before AutoCAD starts. Same steps. Pass = the 450 grade reads the old, flatter answer (about 1:890), proving this switch alone makes the difference. A second control with the row blank and both switches ON must equal C90's grade.
5. **Not known:** which fixture has a 450 at about 30 L/s, and the redesign's exact click route under the runner (robot reach facts note).

Four words: **not built, not tested, not installed, not Tim-accepted.** This is a plan.
