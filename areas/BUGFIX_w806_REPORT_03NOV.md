# BUGFIX w806 report: BUG-806 orifice detail head (B-179, 3 Nov 2026)

## FOR TIM

1. **What you will see differently:** nothing yet. The orifice detail filler has no command calling it, so no drawing changes until it is wired in. When it is, the "HIGH" callout will count from the orifice level (Bayside example 420 HIGH, was 670 HIGH), and an orifice sized at 55.6 mm will read 55 DIA. ORIFICE, never 56.
2. **Draft PR:** #2000, Civil, base `claude/rel-20261102a`. Built and unit-tested only. Never opened in AutoCAD. BUG-806 stays OPEN.
3. **Switch:** Settings key `detention.orificeDetailHeadFromOrificeIl`, ON by default. OFF gives the old 670 HIGH and round-to-nearest orifice exactly.
4. **One question for you (not guessed):** the centre invert tag on the detail (PIT_IL_CENTRE) is still filled with the orifice level. The carpark says "the right level" but the filler is only given the inlet, outlet and orifice levels, so I could not tell which one the template wants. Question: "On the orifice pit detail, should the centre IL show the pit floor (the lower of the inlet and outlet inverts), the outlet IL, or the orifice IL as now?"
5. **Mistakes of my own:** my first scripted edit failed (no scratch folder, no pwsh in the shell) and a sed on a Windows path dropped the backslashes; both caught before any test ran. Nothing reached a real file.
6. **NOT proven:** no AutoCAD run. The mapper's inputs do not carry the PSD, so "never above the PSD" is done by cutting the supplied diameter down to the whole millimetre; this is correct only if the caller passes the sized (largest allowed) diameter, as OrificeSizer does.
7. **Robot case:** none can reach it today, because there is no command or window that calls the mapper. When it is wired in, the case would be `N_orifice_head`: run the orifice detail on the Bayside job (TWL 33.42, orifice IL 33.00, outlet IL 32.75, orifice 55.6), read the baffle callout text (expect "420 HIGH") and the orifice callout (expect "55 DIA. ORIFICE"); control: Settings `detention.orificeDetailHeadFromOrificeIl` false before launch, expect "670 HIGH" and "56 DIA. ORIFICE".

## Technical detail

1. **Fault confirmed on base 3fbb9da5 (rel-20261102a):** `Modules/Drainage/Services/OrificeDetailFieldMap.cs` lines 98-100 (head from `OutletInvertM`), 113 (`Math.Round` on the diameter), 110 (PIT_IL_CENTRE = orifice IL). Not already fixed.
2. **Fix:** `Build(inputs, bool? headFromOrificeIl = null)`; switch read from `SettingsService.Current?.Detention?.OrificeDetailHeadFromOrificeIl ?? true`. ON: datum = `OrificeInvertM`, diameter = floor(dia + 0.000001). OFF: the old two lines.
3. **Files:** `Services/OrificeDetailFieldMap.cs`, `Models/UserSettings.cs` (DetentionSettings), `Drainage.Tests/Services/Bug806OrificeHeadTests.cs` (new, 6 tests incl. both start-up reads), `OrificeDetailFieldMapTests.cs` (old-value tests now pass `headFromOrificeIl: false`), `REGRESSION_LOG.md`. CE_SHARED untouched.
4. **Tests:** one project, filter `OrificeDetailFieldMapTests|Bug806OrificeHeadTests`, net10: 36 passed, 0 failed. net48 compile of the Civil project: 0 errors. Run with SkipDevBundle and isolated CE_LOG_DIR_OVERRIDE/TEMP/TMP/CE_STRUC_SUITE_APPDATA_ROOT under C:\CE_WORK\scratch\w806. Manager tests not run.
5. **Real AppData listings** (TIM_CE_CADTOOLS incl. CE_Admin and logs, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS): 36,469 lines before and after, identical (no file changed). Listings: `C:\CE_WORK\scratch\w806\before.txt` and `after.txt`.
6. **Open drafts touching the same file:** none found (search "OrificeDetailFieldMap" returned []). No stack.
7. **Windows:** no window change needed.
