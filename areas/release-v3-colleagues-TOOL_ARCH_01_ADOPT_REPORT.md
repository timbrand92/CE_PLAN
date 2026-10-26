# TOOL-ARCH-01 adoption report (Tue 27 Oct 2026, Melbourne, Team Sonnet, headless)

Four words: **built and tested (as a test tool). Not installed. Not Tim-accepted.** Nothing was opened in AutoCAD (none of this touches AutoCAD). Nothing merged, closed or deleted.

## ANSWER FIRST — FOR TIM

1. **Done: ArchUnitNET is now in a draft PR as permanent checks.** Draft PR **#1828**, "TOOL-ARCH-01 adopt:", against `claude/rel-20261026u`. Tests only. Nothing a drafter will see changes.
2. **What is now guarded (the test run goes red if any of these break):**
   1. **CE_SHARED** uses no Civil, Manager or Structural code.
   2. **Manager** uses no Civil or Structural code.
   3. **Civil** uses no Manager or Structural code.
   4. **Structural** uses no Civil, Manager or CE_SHARED code.
   All four were green on today's code. A rule that matches nothing fails loudly (tested), and a deliberately bad case turns a rule red (proved).
3. **What is NOT guarded:** "no hidden download" and "never unlock a layer" are only **reported**, never failed, because ArchUnitNET cannot see code inside async methods (it missed 2 of 4 network callers). Those two reads are done a second way (Mono.Cecil) and printed side by side. Also not guarded: the value a lock is set to, which file is written, anything on screen, the AI library. The three trial rules that raised false alarms (view-models and the drawing database, services using window types, settings-file writers) are counted in a report-only class and can never fail.
4. **Run time and pass counts:** about 25 seconds per project.
   1. **Civil/Manager/CE_SHARED project:** 14 of 14 pass on net10.0-windows (22 s) and 14 of 14 on net48 (25 s).
   2. **Structural project:** 4 of 4 pass on net10.0-windows (11 s) and 4 of 4 on net48 (15 s).
5. **Red proof:** in a throwaway copy (never committed) a Manager type that used a Civil type turned the Manager rule red and named the type. The other rules stayed green.
6. **For the next train: include PR #1828; tests only.**
7. **One thing to know:** a newer Structural branch exists, `claude/rel-20261026s` (Structural 1.0.125, S-45). I measured Structural on the branch the job named (S-44, `rel-20261025s`). The rule is a who-uses-whom check, so S-45 should pass; I did not run it.

---

Everything below is detail for the desk; nothing here needs Tim.

## 1. What was built

1. **Branch** `fb/tool-arch-01-adopt` from `origin/claude/rel-20261026u` (270215aa, Civil 3.0.80 / Manager 1.1.80 C-70). One commit, normal push. Trial draft PR #1780 untouched.
2. **Projects (from the trial, cut down):** `Modules/Arch.Tests/CE_ARCH.Tests.csproj` and `Modules/Arch.Tests.Structural/CE_ARCH.Structural.Tests.csproj`. net48 and net10.0-windows. Packages pinned exactly: TngTech.ArchUnitNET 0.13.4, TngTech.ArchUnitNET.NUnit 0.13.4 (Apache-2.0); test stack Microsoft.NET.Test.Sdk 17.9.0, NUnit 3.14.0, NUnit3TestAdapter 4.5.0.
3. **Guards (Category "Guard"):** ARCH-01, ARCH-02, ARCH-03 (`ArchitectureRulesTests`), S-01 (Structural), a canary that a bad reference is caught, a test that a rule matching nothing fails with "requires positive evaluation", and a Cecil canary that proves the Cecil read sees an async download.
4. **Report-only (Category "Report"):** `CecilCrossCheckTests` (System.Net users and layer-lock/Xref calls, ArchUnitNET against Cecil, with the async note in every output, plus a blind-spot line that only reports); `ArchitectureMeasureTests` (load time, ARCH-04, ARCH-05, ARCH-08 counts, external-type visibility); Structural S-02 and S-03 reads (S-02 still lists `LayerService` and `NativeCopyPasteXrefService`; S-03 shows only the two known AI markup types).
5. **Left out as guards:** ARCH-04, ARCH-05, ARCH-08 (false alarms, no written rule); ARCH-06 and ARCH-07 (blind spot) are report-only; S-02 and S-03 report-only.
6. **Fix to the trial project:** the Structural project copied the Structural DLL with an item `Exists()` condition, judged before the build, so on a clean checkout every test failed with "file not found" (I hit this: 4 of 4 red on first run). Replaced by an after-build copy step. A permanent project needed this.
7. **Slnx:** NOT wired in. Adding them would make every solution build restore the new packages and build Structural from the solution, and installer tests read the slnx. Leaving them stand-alone changes nothing about how the shipped plug-in or any existing test project builds. Run each by name.
8. **REGRESSION_LOG.md:** entry "TOOL-ARCH-01 adoption" added at the top.

## 2. Measurements

1. **Load of the compiled code:** about 12 s on a cold run here for Civil + Manager + CE_SHARED (3,421 types net10; 3,380 net48); Structural 7.5 s net10, 8.9 s net48 (1,699 and 1,698 types). The trial measured 3 to 6 s on a quieter machine; the rules themselves take 10 to 160 ms.
2. **Whole test runs:** Civil half 22 s (net10) and 25 s (net48); Structural 11 s and 15 s. Builds: first Civil net10 2 min 53 s, net48 1 min 27 s; Structural 1 min 25 s and 41 s.
3. **Disk:** C: had 36 GiB free before every build (floor 8 GiB, no waiting).

## 3. Not done, not tested

1. Not run: Structural on S-45; net8.0-windows; the unified-host build of Structural; the AI library; anything in AutoCAD.
2. The independent Opus read of the rules that the desk planned has not happened; the guards are the four simplest rules, but it is still owed.
3. Both extra worktrees and my scratch files under `C:\ce-fx` removed after the push (only my own, no wildcard).
4. `DESK_LOG.md` and `BUG_CARPARK.md` not edited. No bug added (`LayerService` is still an open question for the Structural lane, see REVIEW_STRUC_LAYERSERVICE_UNLOCK_25OCT.md).

## Summary

ArchUnitNET adopted as draft PR #1828: four who-uses-whom guards (CE_SHARED, Manager, Civil, Structural) green on both runtimes (14/14 and 4/4, about 25 s), canary and empty-rule checks, report-only Cecil and measure groups. A bad reference turned ARCH-02 red. Tests only; next train: include #1828.
