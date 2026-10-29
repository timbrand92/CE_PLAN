# B-010 BUG-505 fix report: one soft note when the source drawing has no units set (29 Oct 2026)

## ANSWER FIRST

**PR:** #1853 (draft) against claude/rel-20261026z, branch fb/bug505-no-units-note, commit accab5c9. Built and unit-tested only. Not installed. Nobody has opened it in AutoCAD. BUG-505 is NOT marked FIXED.

## FOR TIM

1. **What a drafter sees differently:** run CDIMPORTXCIVIL on a consultant drawing whose UNITS are "Unitless". The first line of the pre-flight list now reads: "This drawing has no units set; CE read it as millimetres." Once per import. The import still goes in as millimetres and the Yes/No question is unchanged. A note, never a block.
2. **What does not change:** a drawing with units set prints nothing new. A Unitless drawing that CE guesses is in metres keeps its existing CHECK THE SCALE line (CE did not read it as millimetres, so the new line would be wrong).
3. **Mistakes of my own:** none new in this job. An earlier stopped attempt had a run script that mangled the filter; I rewrote how it was called. Two full-suite tests that read compiled code failed only in a Debug build, and passed in Release (see below).
4. **Not proven:** nothing seen in AutoCAD; CDIMPORTLANDXML is not covered (it never reads a drawing's units); the target drawing's units are not read.
5. **Robot case to prove it:** N40_xc_nounits_note (switch-off control N40b). Open a copy of a millimetre X-Civil drawing, set UNITS insertion scale to Unitless, save. In a copy of a job: type CDIMPORTXCIVIL, choose that drawing, Read source. Check the first pre-flight line equals "This drawing has no units set; CE read it as millimetres." Control: set xcivilImport.noUnitsNote to false in CD_Settings.json BEFORE launching AutoCAD, repeat: that line must be absent. Second control: same drawing with units Millimetres: line absent.

---

## Technical detail

1. **Entry point:** Services/XcivilImportService.cs ~line 326-332, after ReadSourceInsunits; the existing XcivilSourceUnitsCheck.Evaluate is silent for INSUNITS 0 plus a millimetre guess. New XcivilSourceUnitsCheck.NoUnitsNote fills only that gap; the result goes through the existing sourceUnitsNote path (pre-flight lines index 0, warnings, command line).
2. **Switch:** xcivilImport.noUnitsNote (XcivilImportSettings.NoUnitsNote, Models/UserSettings.cs), default true; missing group or key reads ON.
3. **Files:** Models/UserSettings.cs, Services/XcivilSourceUnitsCheck.cs, Services/XcivilImportService.cs, Drainage.Tests/Services/Bug505NoUnitsNoteTests.cs, REGRESSION_LOG.md. CE_SHARED untouched. No write, command, regen, view or system variable added.
4. **Tests:** Bug505NoUnitsNoteTests (exact sentence, nothing for set/unreadable/metre guess, switch OFF = old silence over a grid, switch ON through DeserializeSettings and DeserializeSettingsTolerant, source guards). Focused net10 run: 44 passed, 0 failed (Bug505, C75NewSwitch, units check).
5. **Full suite net10 (Debug):** 20,815 total, 20,779 passed, 32 skipped, 4 failed: two IL-inspection tests (SourceAtomicCoordinatorDependencyTests: FinalLandingProducer..., RefusedNativeCallback...) which expect Release IL, and two HelpGuideWindowRenderTests (offline help render timeout). Re-run of both classes in Release: 26 of 26 pass. I did not run the base to compare names; the Release pass shows they are environment/configuration, not this change.
6. **net48 compile:** Drainage Release, 0 errors.
7. **Not run:** Manager, Structural, net48 tests, anything in AutoCAD.
8. **Not done:** Settings page row (the neighbouring importedPipeNoInventedGrade has none either); not added to C75NewSwitchDefaultsTests (own test file pins it instead).
