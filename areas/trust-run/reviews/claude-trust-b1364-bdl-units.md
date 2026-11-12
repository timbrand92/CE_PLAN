# Review: PR 2077 `claude/trust-b1364-bdl-units` (BUG-1364: BDL in a metre, centimetre or inch drawing)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:00 PC clock. **Head reviewed:** `35ec2928` (one commit on `8de95c34`, installed Structural 1.0.126, confirmed; the two files it touches or calls into are identical to the installed code copy in `C:\CE_WORK\scratch\audit_struc`, compared byte for byte without line endings). **Against:** BUG-1364 and the brief (a millimetre drawing provably unchanged; a drawing with units not set). **Four states:** Built yes (lane: net8 and net48 clean, net10 tests). Tested unit only (lane: 1,205 beam and units tests). Installed no. Accepted no.

---

## FOR TIM

1. BDL (the beam and lower beam pair) now stops with one line and draws nothing in a drawing set to metres, centimetres or inches, the same stop AB, BB and the other beam tools already make.
2. In a millimetre drawing BDL does exactly what it does today: the new check says nothing and lets it run.
3. In a drawing with no units set, BDL also runs as today, treating it as millimetres, so a drawing really drawn in metres with no units set would still get a lower line 100 m away. That is the same for every beam tool.

**Verdict: GO** for the robot on copies. Nothing to fix first; two things worth knowing.

---

## Findings

1. **Millimetre drawing unchanged: proven by reading.** The new line calls the shared hold (`Modules\Structural\Commands\BeamPlacementCommands.cs` 101). For millimetres the shared rule answers "do not hold" (`Modules\Structural\Core\Day1UnitsGuard.cs` 11-17) and the hold returns at once (`Services\FoundationService.Identity.cs` 119-128), before any line is printed or any record is read. It only reads the switch and INSUNITS (the units reader catches its own errors, `FoundationService.cs` 5417-5430). So BDL's path in a millimetre drawing is the installed one plus two reads.
2. **Units not set: unchanged, silent.** The same rule answers "do not hold" for units not set (`Day1UnitsGuard.cs` 16), so BDL runs as today. That matches the bug's "or stops as the other beam commands do" and every other beam tool, but not its first choice (convert).
3. **Metre, centimetre, inch: stops before anything is asked or drawn.** The hold prints one line, logs one line to the Structural log and returns false (`FoundationService.cs` 5635-5643); BDL then returns before reading its settings or asking for a point (`BeamPlacementCommands.cs` 101-102). Nothing is written to the drawing.
4. **Placed right:** after the read-only and REFEDIT pre-flight (97), before `NormalizeOffsets` and every prompt. BDL has one entry point (93).
5. **The Settings switch** (Day 1 units, hold in non-millimetre drawings) turns it off, as for the others: Settings-first rule kept.
6. **Tests** read the code order and the shared rule; they cannot draw (the PR says so). The bug's own fixture test (offset 0.1 drawing units in a metre drawing) belongs to the later "convert" change, not this stop.

## Worth knowing

1. **The stop line talks about footings.** BDL now prints the shared line: "This drawing's units are metres. This command draws footings, labels and text at millimetre size and cannot convert them yet, so CE has not run it. Check what the drawing is really drawn in (LIST one footing) before changing anything." (`Modules\Structural.DesignCore\DrawingUnitRule.cs` 326-332). AB, BB, BT1, R1, C1 and TS1 already print the same; for a beam tool "footings" and "LIST one footing" read oddly. One wording change for Codex's look, shared by all of them.
2. **Units not set** (above): a beam-tool decision for Tim, not this bug's.

## What I did not check

1. Nothing run.
2. The Structural log write (a text file, not the drawing).
3. Converting BDL's three figures (not done; the PR says so).
