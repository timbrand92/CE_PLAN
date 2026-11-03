# BUGFIX w528 (B-191) report, 3 Nov 2026

**Item:** BUG-528 items 6.3 (CE_SHARED note) and 6.2 (Microsoft helper-file versions, 2022-2024 lane).
**Base read:** origin/claude/rel-20261102a at 3fbb9da5.
**Result:** NO PR OPENED. Nothing built, nothing tested, no files in the repo changed.

## FOR TIM

1. **Nothing changes on your drawings.** Both items are builder-side. No PR, no new switch, no AutoCAD test for you.
2. **Item 6.3 (the wrong note) is blocked by my own rules.** The note lives inside CE_SHARED (Shared/CE_SHARED/Services/CeUnifiedHostGuard.cs, line 24). This job is not allowed to change CE_SHARED, so I stopped.
3. **The carpark's reason for 6.3 may be out of date.** It says Structural ships no CE_SHARED. On this base Structural does reference CE_SHARED (Modules/Structural/CE_STRUC_SUITE.csproj line 147). So the note may now be right and not wrong at all. I have not checked what the built Structural bundle actually contains.
4. **Item 6.2 (version alignment) is not small.** The seven files come in indirectly, through other packages. Lining them up means pinning versions in both Civil and Structural for the 2022-2024 lane. That is a different change from the one this job allows:
   - It is a build-time change. A Settings switch that you can turn off cannot undo it, so the "switch ON, OFF restores the old behaviour" rule does not fit.
   - It changes which files ship to colleagues on 2022-2024.
   - Structural has its own base branch (claude/rel-20261026s), so it would need its own PR.
5. **What I did NOT do:** I did not look at any installed bundle's Legacy folder, did not compare file hashes, and did not run or build anything. The carpark's version numbers are taken from the 9 Oct hunt and are unverified by me.

**Your call (one question):** Do you want the 2022-2024 helper-file versions aligned as a separate build-lane job? My recommendation is yes, but only after someone compares the Legacy folders of the current Civil and Structural bundles. That tells us whether the mismatch still exists. It could be a Codex or Claude release-check job rather than a code change.

**Robot case:** none. There is no AutoCAD-visible behaviour to prove. A release-check script comparing the hashes of the seven files across the two Legacy folders would be the right test. A new script needs your approval.

## TECHNICAL DETAIL

1. **Isolation rule:** no dotnet build or test was run, so no APPDATA before/after listing was needed. Nothing was written under APPDATA. No worktree or scratch folder was created, so there is nothing to clean up and no C: space moved.
2. **6.3 evidence (read with git show on the base):**
   - CeUnifiedHostGuard.cs lines 24-25 say each of the three bundles (CVL, STRUC, Manager) ships its own copy of CE_SHARED.dll.
   - CE_STRUC_SUITE.csproj lines 144-147 contain `<ProjectReference Include="..\..\Shared\CE_SHARED\CE_SHARED.csproj" />`, so Structural builds against CE_SHARED. The carpark says "does not use CE_SHARED", which is no longer true on this base.
   - Whether Structural's bundle copies CE_SHARED.dll was not checked. The csproj lines the carpark cites (158-166, 379-380) have moved, so the entry's line numbers are stale.
   - The only fix the carpark names is editing a comment in CE_SHARED. That breaks "CE_SHARED must not change". Status: SKIPPED, needs a decision on whether CE_SHARED may carry a comment-only change.
3. **6.2 evidence:**
   - No PackageReference for System.Memory, System.Buffers, System.Runtime.CompilerServices.Unsafe, System.Threading.Tasks.Extensions, System.Numerics.Vectors, System.IO.Packaging or Microsoft.Bcl.AsyncInterfaces appears in CE_CVL_SUITE.csproj, CE_STRUC_SUITE.csproj or CE_SHARED.csproj.
   - Explicit references that could pull those files in include ClosedXML 0.102.3 (both), System.Text.Json 8.0.5 (Structural), System.Text.Encoding.CodePages 8.0.0 (Structural), System.Net.Http 4.3.4 (Civil) and Serilog 4.0.0 (both). I did not run `dotnet list package --include-transitive` to confirm which one brings in which file.
   - The Civil 10.0.0.1 versus Structural 8.0.0.0 Microsoft.Bcl.AsyncInterfaces gap suggests a Civil package on the 2022-2024 lane pulls in the newer one. Not confirmed.
   - Aligning needs explicit pins in both csprojs plus a hash comparison of the two Legacy folders. It is not a one-line change and has no Settings-switch form. Status: SKIPPED as not small, needs a scope decision (above).
4. **Not done:** no REGRESSION_LOG.md entry (no change was made). BUG_CARPARK.md was not edited. The entry stays OPEN, and this report's findings 3 and 4 can be added to it by the desk.
