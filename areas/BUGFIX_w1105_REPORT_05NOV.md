# BUGFIX w1105 (BUG-1105) report, 5 Nov 2026

## FOR TIM
1. **PR number:** none. STOPPED - the fix is not small.
2. **What a drafter sees now:** no change. A rating report naming a 3,000 L tank against a drawn tank with 2,000 L of reuse still passes silently.
3. **Why I stopped:** the fix is three connected pieces, not one: (a) store the rating, report file, date and each report tank size on the job's project record, (b) make CDWT read that record and compare it with the drawn reuse litres, (c) a typed-reason override prompt saved on the job. The project record (ProjectData) has nowhere to hold any of this today.
4. **Built / tested:** nothing built, nothing tested. No dotnet run, so no real %APPDATA% files could have been touched.
5. **NOT proven:** the fault is confirmed by reading only; not driven in AutoCAD.
6. **Own mistakes:** none that cost anything. Worktree and branch created, then removed.
7. **Question for you (engineering call):** when the report tank (3,000 L) differs from the drawn reuse (2,000 L), compare the report against the drawn REUSE share or the drawn TOTAL? The bug text says reuse; a 3,000 L tank could legitimately be 1,000 L detention plus 2,000 L reuse. Recommend reuse-vs-reuse only where the report row says reuse, else total-vs-total.
8. **Recommended split:** 3 small jobs: A, store the fields on the project record (with Settings switch); B, the pure comparison rule plus CDWT command-line warning; C, the typed-reason override.

## Technical detail
- Base: origin/claude/rel-20261112a at 7cc4d306 (Civil 3.0.92). Civil bug, not Structural-only.
- Not already fixed: `StormReport.cs:32` keeps `TreatmentVolumeLitres` per tank row (read at line 315). No other file in Modules/Drainage uses it (grep confirms).
- `StormReportOffer.BuildNotes` (lines about 170-185) prints only the STORM rating as a note; nothing stores it. `OfferTheStormReport` in `CivilDesignCommand.cs:466-530` has the report path and facts but writes nothing to the job.
- `CivilDesignState` (Rules/CivilDesignWorkflow.cs:78) is rebuilt each CDDESIGN session, so it cannot carry the report to CDWT. `WaterTankFactsData` (Models/PitData.cs) holds total, detention and size only, with no report link.
- `WaterTankCommand.Apply.cs:343-357` (`BuildTankFacts`) is where a drawn tank gets its litres; the comparison would hook in at plan time (`WaterTankCommand.Plan.cs:126`, `ReuseLitres`).
- Robot case when built: type CDDESIGN on a copy with a 3,000 L report, then CDWT with 2,000 L reuse; check the command line shows the mismatch warning; control with the switch OFF shows none.
- No window change is needed (command-line prompt), so no Codex window brief.
