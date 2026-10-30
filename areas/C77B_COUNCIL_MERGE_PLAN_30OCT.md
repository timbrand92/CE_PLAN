# C-77b plan: merging the two council PRs the C-77 assembler skipped (#1854 GB-02, #1855 GB-03), Fri 30 Oct 2026

CE 01 Build job B-043a, Opus 5.5 (claude-opus-5-5), headless. **Read-only planning job.** No build, no test, no AutoCAD, no repo edit, no PR touched. I made a throwaway trial of both merges in a detached checkout (`C:\ce-fx\o8`, removed at the end; nothing pushed from it). Real clock 12:01 to about 12:20 Melbourne (Git Bash `date`).

## FOR TIM

1. **These two are NOT in C-77.** The C-77 build this morning took 23 of 25 changes plus #1866. These two were left out because they clash with the GB-01 slice 1 change (the 1 in 200 detention grade) in the same council files. Nothing is wrong with them; they just arrived second.
2. **What #1854 (GB-02, council data) gives a drafter:**
   1. **Glen Eira:** no more "50 per cent of detention must be underground" rule (the Guidebook p34 says the whole of it may be in tanks).
   2. **Port Phillip:** CDDESIGN now sizes a tank by Boyd's method instead of waiting for the council's emailed figure. Example: a 600 m² site with 400 m² hard area gets a 2.4 m³ tank and 5.18 L/s permitted discharge.
   3. **Six more councils in the council list:** Cardinia, Brimbank, Greater Dandenong, Hobsons Bay, Nillumbik, Merri-bek. They have no suburb lists, so an address never picks them by itself. Pick them by name. Most of their figures are marked "Assumed".
   4. **"Checked against Guidebook 1.3"** is shown on the councils this change touched. Cardinia also lists "Professional registration number" as a submission item.
3. **What #1855 (GB-03, soakage) gives a drafter: nothing visible yet.** It is the calculation engine for the Guidebook's soakage sheet. It reproduces the book's own worked sheet figure for figure. No window or printed sheet uses it yet. Kingston, Frankston and Mornington Peninsula now record "soil rate at least 100 mm/h".
4. **The merge is easy.** Every clash is "both changes add lines in the same spot": keep both. I tried it on a copy and both merges then match their PRs line for line.
5. **One thing to check after the build, not a fault yet:** a #1854 test pins the Port Phillip tank at 2.4 m³. I checked that nothing in C-77 changes that calculation (the Boyd's change in C-77 only affects the Boyd's tab). The test run will prove it.
6. **Nothing for you to decide now.** Two engineering questions from the PRs themselves are still open for the engineers (item 5 of the risks below). Neither stops the merge.

---

## ANSWER FIRST (technical)

1. **No PR number: this job writes a plan, not a PR.** The plan is for a Sonnet builder to make branch `claude/rel-20261030b` (C-77b) from `origin/claude/rel-20261030a` at **`c87249c6`** ("C-77 finalizer: draftingChecks group states its default"). The C-77 train has moved past the assembler's `9889c01a`: it now holds `#1866` (`cf71af0d`) and the finalizer's one-line fix (`c87249c6`). Both trials below used `c87249c6`.
2. **PR heads used (from `git ls-remote origin refs/pull/N/head`, 12:05):** #1854 = `07fdd419` (branch `claude/gb02-council-data-a`, base branch on GitHub `fb/bug1095-council-min-c`, draft, open); #1855 = `8d40c424` (branch `claude/gb03-soakage`, base `claude/rel-20261026z`, draft, open). Merge bases: #1854 with the train = `b531c85e` (#1852's head, already in the train); #1855 with the train = `09126560` (C-75). **Neither PR was tested on C-76 or C-77 code.**
3. **Order: #1854 first, then #1855.** The desk ruling says GB-02 after GB-01 slice 1 and GB-03 after GB-02 (TIM_ANSWERS items 28 and 29).
4. **Conflicts.** #1854: 3 files, one hunk each: `CouncilProfileModels.cs`, `CouncilSweepParityTests.cs`, `REGRESSION_LOG.md`. #1855 on top of #1854: 5 files, 6 hunks: the same 3 files, `UserSettings.cs` (2 hunks) and **`Rules/RulebookValues.cs` (1 hunk)**. The assembler's report did not list the `RulebookValues.cs` hunk. It appears only after #1854 is in, because both PRs edit the same "kept out of the CDRULES fingerprint" line. Every hunk is resolved by keeping both sides. The final text is in section 1.
5. **Proof that the trial resolution is exact:** after each trial merge, `git diff --numstat` against the first parent equals the PR's own numstat against its merge base, file by file. #1854: 10 files, 1,037 added, 19 removed. #1855: 10 files, 517 added, 4 removed. The trees were **after #1854 = `e8487aa27142719115fc05c7e2a17f5404ee2a87`** and **after #1855 = `ef821f23f19724305dd9d802d124fcb9cc3328dd`**. If the builder starts from `c87249c6` and resolves exactly as below, `git rev-parse HEAD^{tree}` must print the same two hashes. That is a one-line check that nothing was lost.
6. **Logical build check (read, not compiled):** no name clash. `DetentionGuideGradeN`, `GuidebookVersionChecked`, `SubmissionItems` and `MinSoilKhMmPerHr` are four different properties. `DraftingChecks` and `Soakage` are two different settings groups. No test that counts councils or settings is broken by the pair. Details in section 2.
7. **My own mistakes in the trial, so the builder avoids them:** (a) twice the log merge put a `## ` heading directly under the previous entry with no blank line. I fixed it in the trial. (b) My first fix used `sed` to insert the blank line and wrote a literal `r` line instead. I caught it in the byte dump, restored the file and redid it with the Edit tool. **Use the Edit tool for every resolution, never sed or awk.** awk under Git Bash also drops the CR of each line (git normalises it, but it is noise). Cost: about five minutes, all in the throwaway copy.
8. **NOT proven:** nothing was compiled or run. The Port Phillip 2.4 m³ pin, the 384 Assumed count and the 27 profile checksums are read, not run. The net48 compile is not run. The robot case is named in section 5 but not written.

## 1. Every conflict hunk and its final text

Rule for every hunk: keep both sides, the train's text first, then the PR's. The only exception is the log, where the newest entry goes on top. Resolve each with the Edit tool. Check that no `<<<<<<<`, `|||||||`, `=======` or `>>>>>>>` line is left (`grep -rn '^<<<<<<<\|^>>>>>>>\|^|||||||' Modules REGRESSION_LOG.md` prints nothing).

### Merge 1: #1854 (`git merge --no-ff origin/claude/gb02-council-data-a`)

**Hunk 1A: `Modules/Drainage/Models/CouncilProfileModels.cs`, line 89 (after `DetentionMinGradeN`).** Both sides add properties. The shared `/// <summary>` line sits above the markers, so the PR's first block needs its own `/// <summary>` line added back. Final text:

```csharp
        [JsonProperty("detentionMinGradeN")]
        public double? DetentionMinGradeN { get; set; }

        /// <summary>
        /// GB-01 slice 1 (Tim, 29 Oct 2026, decisions items 24 and 26): the flattest fall, 1 in N, this council allows for DETENTION
        /// ... (the train's six lines unchanged) ...
        /// but Tim read the book as 1 in 200 for this rule. Read by CDRULES, so it is part of the criteria fingerprint.
        /// </summary>
        [JsonProperty("detentionGuideGradeN", NullValueHandling = NullValueHandling.Ignore)]
        public double? DetentionGuideGradeN { get; set; }

        /// <summary>
        /// GB-02 (Tim, 29 Oct 2026, decision 28): the version of the Civil and Drainage Design Guidebook this profile was last checked against
        /// ("1.3"). Null (not written) = not recorded yet. Shown on the profile viewer; read by nothing that calculates, so it is kept out of
        /// the CDRULES criteria fingerprint.
        /// </summary>
        [JsonProperty("guidebookVersionChecked", NullValueHandling = NullValueHandling.Ignore)]
        public string GuidebookVersionChecked { get; set; }

        /// <summary>
        /// GB-02 items 4 and 7: extra things this council asks to see with a submission, in the council's words (Cardinia: "Professional registration
        /// number"). Null (not written) = none recorded. Information only; no engineering effect, so it is kept out of the CDRULES fingerprint.
        /// </summary>
        [JsonProperty("submissionItems", NullValueHandling = NullValueHandling.Ignore)]
        public List<string> SubmissionItems { get; set; }

        // ── Average Recurrence Intervals (1-in-N year) ───────────────────────
```

**Hunk 1B: `Modules/Drainage.Tests/Services/CouncilSweepParityTests.cs`, line 45 (the `SourcedChanges` list).** Git already merged the comma both sides put after `"kingston/preDevCCapBySiteCase"`, so line 44 is fine as it is. The real clash is the two new groups. The train's last entry (`maroondah`) needs a comma added. Final text:

```csharp
            "kingston/tcLotAreaLimitM2BySiteCase", "kingston/preDevCCapBySiteCase",
            // GB-01 slice 1 (Tim, 29 Oct 2026, decisions 24 and 26): the flatter detention-pipe grade (1 in 200) is a per-council figure
            // for the four councils the Design Guidebook names. New nullable field, written for those four only.
            "darebin/detentionGuideGradeN", "banyule/detentionGuideGradeN",
            "manningham/detentionGuideGradeN", "maroondah/detentionGuideGradeN",
            // GB-02 (Tim, 29 Oct 2026, decisions 27 and 28): Glen Eira loses the 50 per cent underground rule (book p34); Port Phillip follows the
            // book (Boyd's method). Both are stamped with the guidebook version they were checked against.
            "glen-eira/minUndergroundPct", "glen-eira/warnings", "glen-eira/guidebookVersionChecked",
            "port-phillip/psdMethod", "port-phillip/warnings", "port-phillip/guidebookVersionChecked"
        };
```

(The PR's `AddedSinceSweep` array and its other edits further down merge on their own.)

**Hunk 1C: `REGRESSION_LOG.md`, line 1.** Both sides add entries at the top. Final order:
1. #1854's two entries, exactly as in the PR: "## GB-02 part A follow-up (Opus pre-review C ...)" and then "## GB-02 part A: council data ...", 25 lines.
2. **One blank line.**
3. The train's whole top block unchanged, starting "## C-77 finalizer: the `draftingChecks` settings group ...".

Check: `git diff --numstat HEAD^1 HEAD -- REGRESSION_LOG.md` = `26 0`. `grep -c '^## ' REGRESSION_LOG.md` goes 1543 → 1545.

Commit message: `Merge PR #1854 (B-053 GB-02 council data) at 07fdd419`. Check tree = `e8487aa2…`.

### Merge 2: #1855 (`git merge --no-ff origin/claude/gb03-soakage`), on top of merge 1

**Hunk 2A: `CouncilProfileModels.cs`, same place.** Keep 1A's final text, then add the PR's property after `SubmissionItems`, with its own `/// <summary>` line put back:

```csharp
        [JsonProperty("submissionItems", NullValueHandling = NullValueHandling.Ignore)]
        public List<string> SubmissionItems { get; set; }

        /// <summary>
        /// GB-03 slice 4 (Design Guidebook v1.3, council pages): the lowest soil rate (Kh, mm/h from the geotechnical report) this council accepts
        /// for a soakage system. 100 for Kingston, Frankston and Mornington Peninsula. Null (not written) = the council states none. A job below
        /// it is warned, never blocked. Read only by the soakage sheet, so it is kept out of the CDRULES fingerprint.
        /// </summary>
        [JsonProperty("minSoilKhMmPerHr", NullValueHandling = NullValueHandling.Ignore)]
        public double? MinSoilKhMmPerHr { get; set; }

        // ── Average Recurrence Intervals (1-in-N year) ───────────────────────
```

**Hunk 2B: `CouncilSweepParityTests.cs`, same list.** Add a comma after `"port-phillip/guidebookVersionChecked"`, then the PR's two lines:

```csharp
            "port-phillip/psdMethod", "port-phillip/warnings", "port-phillip/guidebookVersionChecked",
            // GB-03 slice 4 (Design Guidebook v1.3 council pages): the lowest soil rate for a soakage system, 100 mm/h, three councils.
            "kingston/minSoilKhMmPerHr", "frankston/minSoilKhMmPerHr", "mornington-peninsula/minSoilKhMmPerHr"
        };
```

**Hunk 2C: `Modules/Drainage/Rules/RulebookValues.cs`, about line 474 (`FingerprintContractResolver.CreateProperty`).** This hunk is new: the assembler did not see it. Both PRs add names to the same "kept out of the fingerprint" condition. Final text (three lines; the PR's new `InformationOnlyProvenanceFilter` lines below it merge on their own):

```csharp
                if (member.DeclaringType == typeof(CouncilProfile) &&
                    (property.PropertyName == "orificeMethod" || property.PropertyName == "orificeFormulaK" || property.PropertyName == "minSoilKhMmPerHr" ||
                     property.PropertyName == "guidebookVersionChecked" || property.PropertyName == "submissionItems" ||
                     property.PropertyName == "reuseCredit" || property.PropertyName == "pumpStormAri"))
                    property.ShouldSerialize = _ => false;
```

**Hunk 2D: `Modules/Drainage/Models/UserSettings.cs`, line 113 (after `PipeSpeed`).** Both sides add a settings group. Final text:

```csharp
        public PipeSpeedSettings PipeSpeed { get; set; } = new PipeSpeedSettings();

        /// <summary>GB-01 slice 4 (Tim, 29 Oct 2026): where CE finds dwellings and garages, and what may run under a garage. See <see cref="DraftingChecksSettings"/>. Default: new DraftingChecksSettings(), every value blank (no outline layer named, so R-33 reports Unknown).</summary>
        [JsonProperty("draftingChecks")]
        public DraftingChecksSettings DraftingChecks { get; set; } = new DraftingChecksSettings();

        /// <summary>GB-03 slice 4 (Tim, 29 Oct 2026): the soakage sheet's soil table and sweep. See <see cref="SoakageSettings"/>. Default: new SoakageSettings() (every value blank, so the Design Guidebook figures).</summary>
        [JsonProperty("soakage")]
        public SoakageSettings Soakage { get; set; } = new SoakageSettings();
```

(Keep the finalizer's `draftingChecks` text with "Default: ..." exactly as it is on `c87249c6`.)

**Hunk 2E: `UserSettings.cs`, about line 2029 (new classes after `AnnotationOffsetSettings`).** Both sides add classes. The shared `    /// <summary>` sits above the markers and the shared `    }` below. Final text: the train's classes `DraftingChecksSettings`, `LidClassRow` and `PitDepthBand`, unchanged, then:

```csharp
        [JsonProperty("lengthMm")]
        public double LengthMm { get; set; }
    }

    /// <summary>
    /// GB-03 slice 4 (Tim, 29 Oct 2026, decision 29): the soakage sheet's Settings. Nothing here is written to the file while blank; blank means the
    /// Design Guidebook v1.3 figures (Melbourne Water WSUD Procedures Tables 11.1 and 11.2 and the book's own sheet).
    /// </summary>
    public class SoakageSettings
    {
        ... (the PR's class body unchanged, ending with EffectiveAriYears) ...
    }
```

**The file must keep its UTF-8 byte-order mark** (`head -c3 Modules/Drainage/Models/UserSettings.cs | od -An -tx1` = `ef bb bf`). C-77 lost it once (`bbaf7ec3`).

**Hunk 2F: `REGRESSION_LOG.md`, line 1.** #1855's entry ("## GB-03 slice 4 (engine part) ...", 17 lines) on top, **one blank line**, then the #1854 entries from merge 1. Check: numstat `18 0`, heading count 1545 → 1546.

Commit message: `Merge PR #1855 (B-054 GB-03 soakage engine) at 8d40c424`. Check tree = `ef821f23…`.

**Files that merge on their own (no action; listed so the builder checks them):** `council-profiles.json` (each PR edits different councils from #1841: #1841 Darebin/Banyule/Manningham/Maroondah, #1854 Glen Eira, Port Phillip, six new ones and the document's guidebook version, #1855 Kingston/Frankston/Mornington Peninsula); `KingstonStormFrequencyTests.cs` (different dictionary lines; the end result holds 27 entries and asserts 27); `RulebookValues.cs` in merge 1; `CouncilProfileServiceTests`, `JobLandUseTests`, `KingstonStorageStormEverywhereTests` (22 → 28); and the new files `Gb02CouncilDataTests.cs`, `Gb03SoakageSweepTests.cs`, `SoakageSweepModels.cs`, `SoakageSweepService.cs`.

## 2. Does each PR still build and pass, logically, on the train?

1. **Names:** no clash. Four separate council properties. Two separate settings groups (`draftingChecks` from #1849, `soakage` from #1855). Separate new classes (`DraftingChecksSettings`/`LidClassRow`/`PitDepthBand` against `SoakageSettings`, with `SoakageSoilRow` in its own file). `record` is already used in product code (`AutoDesignInputs`) with `IsExternalInitPolyfill.cs`, so #1855's `record SoakageSweepInputs` compiles on net48 too. Tests have `LangVersion latest`, so the `!` in `Gb03SoakageSweepTests` is fine.
2. **Council-count pins:** after both merges, every count reads 28 profiles (27 non-Kingston checksums). `CouncilSweepParityTests` line 75 `AreEqual(22, baseline.Count)` is the frozen CR-D1 baseline file and is meant to stay 22. No test added since C-75 pins 22 (searched the diff `b531c85e..c87249c6` and `09126560..c87249c6`).
3. **The Assumed count, 384 (#1854's figure):** it counts provenance entries whose status is "Assumed". #1841 added only `OfficeRule` entries and #1855 only `Sourced` ones, so 384 should hold.
4. **Profile checksums (`KingstonStormFrequencyTests.OtherProfilesBefore`):** #1841 changed Darebin, Banyule, Manningham and Maroondah, #1854 Glen Eira and Port Phillip plus the six new councils, #1855 Frankston and Mornington Peninsula. No council is changed by two PRs, so every pinned checksum was made on a block nobody else touches.
5. **#1841's sweep `NoOtherCouncilCarriesAFlatterDetentionFigure`:** the six new councils carry no `detentionGuideGradeN`: passes. **#1855's sweep (only Kingston, Frankston and Mornington Peninsula carry `minSoilKhMmPerHr`):** the six new councils carry none: passes.
6. **Fingerprint:** #1854's two fields and #1855's field are all kept out of the CDRULES fingerprint (hunk 2C). #1855's `InformationOnlyProvenanceFilter` drops only the `minSoilKhMmPerHr` source record. If #1854 added source records for `guidebookVersionChecked`, those stay in the fingerprint. That only moves Glen Eira and Port Phillip, which change anyway (their rules changed) and #1854's own test covers it. Not a merge problem.
7. **Settings guards:** `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault` reads only `[JsonProperty("key")]` with nothing after the name. So it sees the top-level `soakage` line, which has "Default: new SoakageSettings()" and an initialiser: passes. The nested `SoakageSettings` keys carry `NullValueHandling` and are not scanned (same as #1849's nested keys). `F023ColleagueDefaultsTests.SwitchOff_InTheShippedFile_GivesTheOldBuiltInStartExactly` compares two serialised `UserSettings`; the blank `soakage` group writes `{}` on both sides: passes.
8. **The Port Phillip pin (the one real behaviour risk):** `Gb02CouncilDataTests.PortPhillip_NowSizesATank_ForAJobWithNoCouncilFigure` pins `AutoDesignService.Design(600 m², 400 m², "port-phillip")` at SSR 2.4 m³ and PSD 5.18 L/s. It was measured on C-75 + #1852. What changed since then: C-76; #1856 flipped `boydsUsesHardGroundC` ON, but that switch is read only in `ViewModels/BoydsCalcViewModel.cs:238` (the Boyd's tab), not in `AutoDesignService`; #1841 changed `RulebookValues` (grades, not storage). No `AutoDesignService`/`DetentionSizing` file changed in `b531c85e..c87249c6`. **Expected to pass. Read, not run.**
9. **Switch rule (R-00, R-27):** neither PR has an ON/OFF switch. #1854 is council data Tim approved in so many words ("approve gb02", TIM_ANSWERS item 28; Port Phillip and Glen Eira in item 27); its undo is a revert. #1855 has no caller, so there is no behaviour to switch. Its values come from the new Settings group or the council file: nothing hard-coded except the Guidebook defaults behind blank Settings values. **The finalizer should say whether #1854's Port Phillip change needs a switch.** I did not add one; that is a judgement for the reviewer, not a merge step.

## 3. Order

1. **#1854 then #1855.** That is the dependency order: GB-03 after GB-02 (TIM_ANSWERS 29), GB-02 after GB-01 slice 1 (#1841, already in C-77; item 28). Hunk 2C and the stacked comma in 2B also only make sense in this order.
2. **Also queued for C-77b, NOT part of this plan, checked only with merge-tree:** the moved heads of #1848/#1850/#1851 (desk log 12:12). `#1851` at `7c547ebb` contains the new `#1850` (`d363c129`) and `#1848` (`21a3bbb4`) heads. On top of my trial result it merges with **no conflict**. `#1848` alone conflicts in `Rules/RulebookEngine.cs` and the log, against the train as well, because #1851 already carries that resolution. **If C-77b takes them, merge #1851's head once, after #1855, not #1848 separately.** BUG-1227 Part A (#1867) and the other "C-77b candidates" were not checked.

## 4. Step list for the Sonnet builder (ready to run)

Rules as in the build brief: foreground only; below-normal priority; `-p:SkipDevBundle=true -nr:false --disable-build-servers`; the two-slot check `.ps1` before every dotnet; under 8 GB free on C: means wait; no AutoCAD; never close, retarget or merge #1854/#1855 on GitHub (D6); do not push to `claude/rel-20261030a` (the finalizer and payload own it).

1. **Start point:** `cd "C:\Lisp Files\CE_ACAD_PLUGIN"; git fetch origin`. Read `git rev-parse origin/claude/rel-20261030a`. If it is **not** `c87249c6`, the train moved: re-run `git merge-tree --write-tree --name-only <tip> origin/claude/gb02-council-data-a`, say so in the report, and skip the tree-hash checks.
2. **PR heads unchanged?** `git ls-remote origin refs/pull/1854/head refs/pull/1855/head` must print `07fdd419…` and `8d40c424…`. If either moved, merge the live head and say it moved.
3. **Worktree:** `git worktree add C:\ce-fx\c77b -b claude/rel-20261030b origin/claude/rel-20261030a` (check first that `claude/rel-20261030b` does not exist locally or on origin; if it does, reuse it and read its log).
4. **Merge 1:** `git merge --no-ff origin/claude/gb02-council-data-a -m "Merge PR #1854 (B-053 GB-02 council data) at 07fdd419"`. Resolve 1A, 1B and 1C with the Edit tool. Check: no markers; after `git add` of the three files, `git diff --cached --numstat HEAD -- <3 files>` against the PR's own `git diff --numstat b531c85e origin/claude/gb02-council-data-a` (11/4, 19/0, 26/0); log heading blank line; then commit and check tree `e8487aa2`.
5. **Merge 2:** `git merge --no-ff origin/claude/gb03-soakage -m "Merge PR #1855 (B-054 GB-03 soakage engine) at 8d40c424"`. Resolve 2A to 2F. Check: numstat against `git diff --numstat 09126560 origin/claude/gb03-soakage` (all ten files equal: 3/1, 206/0, 2/2, 6/0, 8/0, 36/0, 41/0, 34/1, 163/0, 18/0); UserSettings BOM `ef bb bf`; commit; tree `ef821f23`.
6. **(Only if the desk says so) merge 3:** `#1851` live head, as in section 3 item 2.
7. **REGRESSION_LOG.md entry (separate commit, on top of the log, blank line after it):**

   ```
   ## C-77b assembly: GB-02 council data (#1854) and GB-03 soakage engine (#1855) merged onto C-77 (30 October 2026)

   Built and unit-tested only. Nobody has opened this in AutoCAD. Not installed. No bug marked FIXED. Merge-only: no product line written beyond the two PRs.

   1. **Why separate:** the C-77 assembler skipped both on clashes with #1841's new council field (`detentionGuideGradeN`). Every clash was two additions in the same place; both sides kept (`CouncilProfileModels.cs`, `CouncilSweepParityTests.cs` allow-list, `UserSettings.cs` group and classes, `RulebookValues.cs` fingerprint exclusion, the log).
   2. **Proof nothing was lost:** per-file numstat of each merge equals the PR's own; tree hashes match the plan C77B_COUNCIL_MERGE_PLAN_30OCT.md.
   3. **What a drafter sees:** see the two entries below (#1854: Glen Eira, Port Phillip, six councils; #1855: nothing visible yet).
   4. **Tests:** <focused count> focused and <full count> full on net10, 0 failed; net48 compile 0 errors.
   5. **Undo:** revert the merge commit(s).
   ```

8. **Build (one slot free first):** Civil tests project, Release, net10:
   `dotnet build Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -c Release -f net10.0-windows -m:8 -p:SkipDevBundle=true -nr:false --disable-build-servers -p:_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs -p:_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref "-p:_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027" -p:_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`
   with AutoCAD 2027 on PATH, the untracked 0-byte `CE_TRANSFORM_2027.arx` placeholder, and a fresh TEMP and CE log folder inside TEMP (as the C-62/C-77 assemblers did).
9. **Focused tests first (`--no-build`, same flags):** filter
   `FullyQualifiedName~Gb02CouncilDataTests|FullyQualifiedName~Gb03SoakageSweepTests|FullyQualifiedName~CouncilSweepParityTests|FullyQualifiedName~CouncilProfileServiceTests|FullyQualifiedName~KingstonStormFrequencyTests|FullyQualifiedName~KingstonStorageStormEverywhereTests|FullyQualifiedName~JobLandUseTests|FullyQualifiedName~Gb01Slice1FallsTests|FullyQualifiedName~C60AuditSourcePinGuardTests|FullyQualifiedName~F023ColleagueDefaultsTests|FullyQualifiedName~HardGroundRunoffCTests|FullyQualifiedName~CouncilMinimumCBug1095Tests|FullyQualifiedName~RulebookEngineTests|FullyQualifiedName~Int068DetentionFingerprintTests|FullyQualifiedName~C75NewSwitchDefaultsTests`
   **Expect:** count not 0; `Gb02CouncilDataTests` 10 and `Gb03SoakageSweepTests` 20 (as the PRs report) present; 0 failed. Watch `PortPhillip_NowSizesATank_ForAJobWithNoCouncilFigure` and `CRD1b_AllTwentyTwoProfiles_KeepAssumedValuesAndWarn` (384) by name.
10. **Full Civil net10 suite once:** 0 failed. The floor is the C-77 assembler's 21,424 total plus #1866's tests plus about 30 new (Gb02 10, Gb03 20). Re-run the one PDF page test alone if it fails on the renderer.
11. **net48 compile:** the same build with `-f net48` for `Modules/Drainage/CE_CVL_SUITE.csproj` and the tests project: 0 errors. Compare any net48 test failures by name with the 106-name C-76 baseline, if a net48 run is wanted.
12. **Scope check:** `git diff --stat c87249c6..HEAD -- Shared Installer Modules/Manager Modules/Structural` is EMPTY. `Modules/Drainage/Assets` changes only `council-profiles.json`, so the bundle file count stays 829.
13. **Push** `claude/rel-20261030b` (no force). No PR needed for a train branch; do not retarget #1854/#1855. Clean `bin/obj` with `git clean -fdXq` inside `C:\ce-fx\c77b` only. Write the assembly report in `C:\CE_PLAN\areas` and push by name.

## 5. Risks and what is unproven

1. **Nothing compiled or ran in this job.** Every "passes" in section 2 is read from the code.
2. **Port Phillip 2.4 m³ / 5.18 L/s pin:** expected to hold (section 2 item 8). If it fails, the cause is a C-76 or C-77 change in the design path, **not** the merge. Report the new figure; do not re-pin it without the finalizer, because it is an engineering number.
3. **No switch on #1854's data changes** (Port Phillip's method and Glen Eira's underground share change for every job that picks those councils, once installed). Tim approved the data. Whether R-27 needs a switch is for the finalizer.
4. **Saved CDRULES runs on Glen Eira and Port Phillip jobs go Stale once** (their rules changed). That is #1854's design and is in its log. A drafter reruns CDRULES.
5. **Open engineering points carried by the PRs (for the engineers, not blocking):** (a) #1855: is the soakage sheet judged on the worst storm (180 minutes, 25.77 m³) or the book's highlighted 2-hour row (25.35 m³)? (b) #1855: Table 11.1 moderation factor, multiply (as built) or divide? (c) #1841: Manningham 1 in 200 against its own 1 in 180.
6. **Train moved:** if `claude/rel-20261030a` gets more commits before C-77b starts (for example a finalizer fix), the tree hashes in this plan no longer apply. The hunk texts still do.
7. **Robot case (proof in AutoCAD, with a control):**
   1. **`N53_council_portphillip_design` (control `C53`).** Open a fresh drawing on the C-77b build. Type `CDDESIGN`, set the council to **Port Phillip**, site 600 m², hard area 400 m², and read the result line. (I did not check CDDESIGN's exact prompts or window fields; the case writer must read them first.) **Pass:** SSR 2.4 m³ and PSD 5.18 L/s are shown (before: no tank, waiting for the council's figure). **Control C53:** the same steps with council **Glen Eira** read the same as on 3.0.87 apart from the underground line (no "50 per cent underground" wording). There is no switch, so the control is a council the change does not size differently.
   2. **`N54_council_cardinia_pick`.** Open CE's council list (the project council picker) and check that **Cardinia**, **Brimbank**, **Greater Dandenong**, **Hobsons Bay**, **Nillumbik** and **Merri-bek** are listed, and that Cardinia shows "Professional registration number". Typing a Cardinia suburb address must NOT pick Cardinia by itself.
   3. **#1855:** no AutoCAD case possible (no window calls it); the unit tests are the proof.
