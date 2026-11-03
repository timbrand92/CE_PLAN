# BUGFIX w1154 REPORT, 3 Nov 2026 (B-193): BUG-1154, NO PR OPENED

## FOR TIM

1. **Result:** I stopped without a PR. No code changed, nothing built, no worktree made, no test run (so no AutoCAD-folder listings needed; nothing could have written to them).
2. **Why:** Whether AutoCAD actually cuts or splits long saved records (footing register, footing sizes, schedule map, section data) when you DXFOUT then DXFIN, or save to an older DWG format, has never been tested. The carpark itself says "fix kind: code after a native check". Only AutoCAD can show that. I can't start AutoCAD in this job.
3. **Mostly Structural:** Five of the six places are Structural (footing register, footing memory, schedule map, member schedule). They live on the Structural branch, not the Civil base I was told to use. Only the CDPROFILE section record is Civil.
4. **Risk of a Civil-only fix:** Saving the section record in 255-character pieces would make it unreadable to colleagues on older CE builds (their reader insists on exactly one text value). It is only worth that cost if the native check proves AutoCAD cuts long values.
5. **Mistakes of my own:** none. **Not proven:** everything about the fault itself.

## The one question for Tim (needs AutoCAD, 5 minutes, when free)

1. In a drawing with about 40 footings (register over 5,000 characters), run DXFOUT, open a new drawing, DXFIN. Does the footing register still show all 40? Same for a long CDPROFILE section (DXFOUT, DXFIN, then reopen the section for edit).
2. If both survive: close BUG-1154 as not a fault (your word). If either breaks: reopen as a Structural-branch fix plus a Civil fix, with a switch.

## Technical detail

- Civil section record: `Modules/Drainage/Services/LongitudinalSectionService.cs` writer line 3408 (one `DxfCode.Text` value), readers lines 3301 and 3357 (reject unless exactly one Text value). Fix would be: split writer using the existing 255 splitter (`ProjectDataService.Persistence.cs:1600`), readers join all Text values (old single-value drawings must still read), Settings switch default on, test, REGRESSION_LOG entry.
- Structural writers on origin/claude/rel-20261102a: `FoundationRegistryService.cs:90,313`, `FstMemoryService.cs:173`, `ScheduleService.cs:338`. `MemberScheduleService.cs:209` already splits (a precedent).
- Robot case once built: write a 5,000-character register, DXFOUT, DXFIN, read back; with the switch off the old single value must return exactly.
- Disk: C: free unchanged (no worktree created).
