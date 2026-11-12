# Re-check: PR 2083 `claude/bug-1456b-record-change-door` (BUG-1456, the change door): the failed core-console check

**Reviewer:** lane trust-review (fifteenth run). **Written:** 2026-11-13 08:53 PC clock. **Head:** `522e5502`, unchanged since the first review (`reviews\claude-bug-1456b-record-change-door.md`, 07:32), so the code is not re-reviewed. This file answers one question: the evidence lane's `CEPROOFCROSSCHANGE` (BUG-1456-CROSS-02) FAIL in `EVIDENCE_BRANCHES.md` section H: is the fault in the check or in the cure? Read only.

---

# FOR TIM

1. **The fault is in the check, not in the cure.** The part that matters passed in that run: while CE held another drawing's record, adding a pit, changing a pipe's ends and clearing everything all left the record alone (2 pits before, 2 after).
2. **Why the check then said "fail":** CE makes a fresh list of pits every time it saves its record. The check kept the old list and counted it at the end, so it saw 3 pits when CE's real record was back to 2.
3. **The same flaw also hid something:** "clear everything" swaps CE's whole record for a new one, so the old check could not have seen it if that one change had NOT been refused. The builder's correction (written, not yet pushed) reads CE's record afresh each time, which fixes both. It must be run again in the 2:00pm window before this counts as seen.

**Verdict: GO stands** (for the core-console checks first, then the robot on copies), with `CEPROOFCROSSCHANGE` to be rerun on the corrected check.

---

# Findings (file and line at `522e5502` unless stated)

1. **The check's measure goes stale on every save.** `Modules/Drainage.HeadlessProof/CrossDrawingChecks.cs` (the new BUG-1456-CROSS-02 block) takes `pits` and `pipes` once from CE's record and counts them in `state()` throughout. But every save runs `NormalizeProjectData(_currentProject)` first (`Services/ProjectDataService.Persistence.cs:306`), which sets `data.Pits = DeduplicatePits(data.Pits)` (`ProjectDataService.Mutations.cs:2061`), and `DeduplicatePits` returns a new list whenever there are two or more pits (`Mutations.cs:2120-2145`, `.ToList()`). `AddPit` asks for a save (`Mutations.cs:414`, `RequestSaveIfReady`, which calls `SaveProjectData`); `RemovePitByHandle` saves at once (`Mutations.cs:553`).
2. **What that does to the run's numbers** (section H detail item 2: 2, 2, 3, 3, 3): the refused phase made no save, so its count (2) was read from the live list and is true. The own-drawing `AddPit` added to the live list (3, true) and its save then replaced the list. `RemovePitByHandle("FFFF03")` removed the pit from the NEW list and saved; the check counted the OLD list, still 3. By reading, CE's real record at the end held 2 pits: the remove is not refused, because the record's own drawing is in front (`ProjectDataService.RecordChangeDoor.cs`, `RefusesChangeFor`, `frontIsRecords`). So the failure is the check's own tidy-up, as the foundations lane says.
3. **A blind spot from the same flaw (new):** `ClearAllData` replaces the whole record object (`Mutations.cs:1848`, `_currentProject = new ProjectData()`). Had it been let through while the other two were refused, the check's kept lists would still have shown 2 pits and an unchanged pipe, and it would have passed. The run is still good evidence (it was refused: the guard is on `Mutations.cs:1843`), but the check as pushed could not have caught that one fault.
4. **The correction:** local commit `8a6decef` on the branch (not pushed, not compiled, rule 3b) reads `Current` afresh in every count (`pitsNow`, `pipesNow`, the check's pipe found by handle, "GONE" if missing) and blocks if its own faulty pit cannot be taken out again. By reading, that fixes the false failure and closes the blind spot in item 3. It must be compiled, pushed and rerun (2:00pm window) before BUG-1456-CROSS-02 is "seen to pass".

# What I did not check

1. Nothing run (Tim's hours). The real end-of-run record was not read; "2 pits at the end" is by reading the code, not measured.
2. `8a6decef` read in full only for the measuring part shown in its diff; it is not on GitHub yet, so its final form may differ.
