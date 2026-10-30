# BUG-1255 Excel export fix design — Fri 30 Oct 2026, about 12:30 Melbourne

Read-only analyst pass (CE 00 request). Nothing built, nothing installed, no CE log copied or written, BUG_CARPARK.md not
edited. Installed builds read from the DLLs just now: Civil 3.0.86+5888ee75, Structural 1.0.125+204dfad2. Source read at
those two commits, not master. A fix branch already exists: `fb/bug1255-closedxml-autocad-2027` (job B-056, Sonnet,
started 12:13 per the carpark). This design is for that job; one writer at a time.

## FOR TIM

1. **The answer.** Confirmed. AutoCAD 2027 carries its own copy of the Excel-writing part, one notch older than CE's.
   Only one copy can be in use in an AutoCAD session. On 30 Oct AutoCAD's copy got in first, so Pit Schedule
   Export Excel crashed with no save box.

2. **One correction to this morning's note.** It is not "AutoCAD always wins". The same export worked on the same
   AutoCAD 2027 on 14 Oct. Whichever copy is used first in a session wins. That is why it looked fine before.

3. **Recommended fix (one).** When CE asks for the Excel part, CE first checks whether AutoCAD already has a copy of
   the same family in use, and uses that one. If not, it uses its own. Plus a safety net: if Excel still cannot start,
   the drafter reads "Excel export could not start on this AutoCAD. Use Export CSV — it saves the same rows." instead
   of "rendering error".

4. **What you will see after the fix.** Click Export Excel in the Pit Schedule window. The Windows save box opens
   every time, whatever else ran earlier in the session. CDCALC's Export XLSX saves without an error box.

5. **The switch.** Settings, "Use the Excel part AutoCAD already has" (`excel.useAutoCadLoadedClosedXml`), ON by
   default. OFF goes back to today's behaviour, but with the plain sentence instead of the crash.

6. **CE Structural.** Same fault, by design: same part, same version, same AutoCAD session. Not seen in a log yet.
   It touches Structural's schedule Excel export (STRUCEXPORTCSV, which saves a .xlsx), the Sheets register Excel
   export, and the member catalogue palette when it reads a .xlsx. The same fix goes into Structural in the same
   build, otherwise fixing one product can break the other.

7. **AutoCAD 2022 to 2024.** Very low risk: that older system lets two copies sit side by side. **2025 and 2026:**
   Unknown, neither is installed on this PC. The fix covers them anyway at no cost.

8. **Nothing for you to do.** The robot and Codex test it. No question for you.

---

## 1. What was verified, and how (read-only)

1. **AutoCAD 2027's copy.** `C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll`, assembly version 0.102.2.0,
   publisher token fd1eb21b62ae805b, dated 30 Apr 2026 (the install day; acad.exe R26.0.60 has the same date). It is
   the only ClosedXML in the AutoCAD folder tree.
2. **AutoCAD also ships two of ClosedXML's partners at CE's exact versions:** DocumentFormat.OpenXml 2.16.0.0 and
   SixLabors.Fonts 1.0.0.0. It does **not** ship the other three that ClosedXML needs: ExcelNumberFormat 1.1.0.0,
   XLParser 1.5.2.0, Irony 1.0.11.0 (read from the 0.102.2 file's own reference list).
3. **CE's copies.** Civil and Structural bundles both ship ClosedXML 0.102.3.0 (same token) in all three lanes,
   Legacy, Net8 and Modern. Same in every Civil backup bundle back to 10 Oct. Manager ships none.
4. **Lane map** (PackageContents.xml): Civil Legacy = R24.1–24.9 (2022–2024), Net8 = R25.x (2025–2026), Modern =
   R26.0–R27.0 (2027 and 2028). Structural Modern = R26.0–R26.9.
5. **csproj.** `Modules/Drainage/CE_CVL_SUITE.csproj:192` and `Modules/Structural/CE_STRUC_SUITE.csproj:213` (at
   204dfad2; line 193 at 5888ee75) both reference ClosedXML 0.102.3. The earlier note's line numbers are right for
   5888ee75.
6. **The log.** `%APPDATA%\CE_CVL_SUITE\logs\ce_cvl_structured_20261030.log` lines 22682–22737 and
   `CE_CVL_SUITE.log` lines 4125–4126 (08:13:13 and 08:13:22): FileLoadException for ClosedXML 0.102.3.0, and the
   inner failure is loading CE's own `...\CE_CVL_SUITE.bundle\Contents\Win64\Modern\ClosedXML.dll`, "manifest
   definition does not match" (0x80131040). The load was attempted by .NET's own load-from helper on the
   AppDomain resolve event. That only fails like this when a different ClosedXML is already bound in AutoCAD's main
   load space.
7. **Line 113 is the first line of ExportExcel**, not the save line. The try/catch in ExportExcel starts at line 136.
   So the failure fires on entry to the method, outside the try, and escapes to the window guard as "rendering
   error". This is the second, smaller fault, and it is real.
8. **Structural logs.** `%APPDATA%\TIM_CE_CADTOOLS\logs` and `%APPDATA%\CE_STRUC_SUITE`: no ClosedXML or
   FileLoadException line. Structural's Excel paths were not driven on 2027 in the kept logs. Not seen is not proof
   either way.
9. **The 14 Oct pass.** `areas/release-v3-colleagues-CODEX_UI_FUNCTIONAL_REPORT_2026-10-14.md` line 439, with line
   203 naming real AutoCAD 2027 and Civil 3.0.49: Pit Schedule exported 31 rows plus a Checking sheet, opened in
   Excel. Same AutoCAD file (dated 30 Apr), same CE version 0.102.3. So the clash depends on order in the session.
10. **A live AutoCAD (pid 59960, started 12:13:56, probably B-056's probe)** had CE Civil and Structural loaded and
    no ClosedXML loaded yet. AutoCAD does not load its copy at start-up.

**Not established (Unknown, say so to anyone who asks):**

1. **Who loaded AutoCAD's 0.102.2 first on 30 Oct.** Candidates only: an AutoCAD feature, or the Manager's resolve
   hook (`Modules/Manager/Plugin.cs` ~58–90), which falls back to `LoadFrom(<acad folder>\<name>.dll)` when its own
   folder lacks a DLL. Manager ships no ClosedXML, so any ClosedXML request that reaches that hook gets AutoCAD's
   older copy. The probe in section 6 should check this with the Manager loaded and not loaded.
2. **Whether AutoCAD lists its folder's DLLs as "always preferred" (.NET's trusted list) or loads them on demand.**
   The 14 Oct pass suggests on demand. Autodesk's loader is closed; the fix below works either way.
3. **Whether AutoCAD 2022–2026 ship any ClosedXML.** Not installed here.

## 2. Why it happens, in one paragraph

On .NET 8 and .NET 10 (AutoCAD 2025–2028) every plug-in shares AutoCAD's main load space, and that space can hold
only one version of an assembly with a given name. A request for an equal or older version is happily served by a
newer one already there; a request for a newer one than what is already there fails. CE asks for 0.102.3. If
AutoCAD's 0.102.2 is already in, CE's request fails, and CE's own 0.102.3 cannot be added beside it. If CE's 0.102.3
went in first, AutoCAD's later request for 0.102.2 is served by CE's copy and nobody notices. On .NET Framework 4.8
(AutoCAD 2022–2024) two versions of a signed assembly can sit side by side, so this clash is very unlikely there.

## 3. Every option, with pros and cons

### Option A — Pin the Modern (and Net8) lane to ClosedXML 0.102.2

1. **What:** `<PackageReference Include="ClosedXML" Version="0.102.2" Condition="'$(TargetFramework)' != 'net48'" />`
   in both csproj files; net48 keeps 0.102.3.
2. **net48:** untouched.
3. **net8/net10 pros:** tiny; compiled against the exact API AutoCAD 2027 has; works in both load orders on 2027.
4. **net8/net10 cons:** guesses Autodesk's version. Breaks again the day an AutoCAD 2027 update or AutoCAD 2028 (the
   Modern lane also serves R27.0) ships a different ClosedXML. Unknown for 2025/2026. Civil and Structural must
   change together or one breaks the other. AutoCAD's copy still needs XLParser, Irony and ExcelNumberFormat, which
   AutoCAD does not ship, so CE must still serve those (Civil has no resolve hook of its own today).
5. **Verdict:** works today, fragile. Keep as the fallback if the probe shows Option B's rebind is refused.

### Option B — Rebind at run time to the copy already in use (RECOMMENDED)

1. **What:** CE registers a handler on `AssemblyLoadContext.Default.Resolving` at start-up. When ClosedXML (or one of
   its five partners) is asked for and cannot be bound, the handler returns, in order: (a) a copy already loaded in
   this session from the same family (same publisher token, same major.minor, here 0.102); (b) CE's own copy beside
   the CE DLL; (c) AutoCAD's own copy by name without a version. Anything else returns nothing and the safety net
   speaks.
2. **Why Resolving and not AppDomain.AssemblyResolve:** the log shows .NET's load-from helper runs first on
   AssemblyResolve and throws, so any CE handler added there (as Structural's `CeToolsInitializer.OnAssemblyResolve`
   is today) never gets a turn. Resolving runs before AssemblyResolve. The probe must confirm this on AutoCAD 2027.
3. **net48:** compiled out (`#if NET`). Not needed: side-by-side loading.
4. **net8/net10 pros:** no version guessing; covers both load orders; covers 2025–2028 without knowing what Autodesk
   ships; one source file for both products; no build or bundle file-list change; about 80 lines plus tests.
5. **net8/net10 cons:** CE may run on AutoCAD's 0.102.2 instead of its own 0.102.3, a patch-level difference. CE is
   compiled against 0.102.3, so if any member CE uses were missing from 0.102.2 it would fail at first use. The probe
   proves the real Pit Schedule and CDCALC workbooks save on 0.102.2. If Autodesk moves to a different family (for
   example 0.104), the handler refuses, logs it, and the safety net tells the drafter to use CSV; then Option C or D2
   becomes the next job.
6. **Verdict:** smallest change that is right in every load order. Recommended, with the safety net.

### Option C — CE's own private load space for the Excel part

1. **What:** a small `CE.ExcelWriter` assembly that alone references ClosedXML, loaded with its partners into a
   private `AssemblyLoadContext` from a bundle sub-folder. CE hands it plain rows (text, numbers, bold, merges, widths)
   and a file path; no ClosedXML type crosses the boundary.
2. **net48:** not available (no load contexts); keep direct ClosedXML there.
3. **net8/net10 pros:** immune to whatever AutoCAD ships, forever; CE always runs its own tested 0.102.3.
4. **net8/net10 cons:** new project, new bundle sub-folder, signed-manifest and deploy file-list change (needs Tim's
   approval under the no-new-build-script rule); the test seam `BuildExcelWorkbook` returning an XLWorkbook must
   change; Structural's catalogue read must go through it too. About two days.
5. **Verdict:** the permanent cure if Option B's guard ever trips. Not for the 13 Nov cut-off.

### Option D1 — Write the workbook with the OpenXML SDK directly

1. **What:** drop ClosedXML, write cells with DocumentFormat.OpenXml 2.16.
2. **Cons that sink it:** AutoCAD 2027 ships that same assembly, so the same clash moves one layer down the day either
   side changes version. Far more code than ClosedXML for the same styles. No gain over B.

### Option D2 — CE's own small .xlsx writer (no third-party part)

1. **What:** a few hundred lines that write the zip and XML parts of a workbook with `System.IO.Compression` and
   `XmlWriter`: sheets, bold, merges, wrap, alignment, number formats, fills, freeze row, column widths. Reads in
   Structural move to ExcelDataReader, which Structural already ships and AutoCAD does not.
2. **net48 and net8/net10:** identical code on every lane; nothing can ever clash; six DLLs leave both bundles.
3. **Cons:** five call sites to move (Civil: Pit Schedule, CDCALC; Structural: schedule, Sheets register, catalogue
   read); column auto-fit becomes a character-count estimate (ClosedXML measures fonts with SixLabors.Fonts); the
   BUG-571 layout (numbers as numbers, merged headings, minimum widths) must be re-proved. Two to three days.
4. **Verdict:** best long-term shape, wrong size for a pilot blocker. Park as the follow-on with Option C.

### Option E — CSV only

1. **What:** already exists in the Pit Schedule window (Export CSV).
2. **Verdict:** not a fix; colleagues want the formatted two-sheet workbook. It is the safety net's advice only.

### Option F — Rename CE's copy at build time (ILRepack "internalise")

1. **What:** merge ClosedXML into the CE DLL under a private name so no clash is possible.
2. **Cons:** new build step (needs Tim's approval), WPF and signing complications, partners still shared. Listed for
   completeness; not recommended.

## 4. Recommended design (Option B plus the safety net)

1. **One source file, linked into both products** (one code path, rule #1; not in CE_SHARED, so no Civil/Manager
   byte-identical resync): `Shared/ExcelBinding/ExcelLibraryBinding.cs`, added to each csproj with
   `<Compile Include="..\..\Shared\ExcelBinding\ExcelLibraryBinding.cs" Link="Services\ExcelLibraryBinding.cs" />`.
2. **Register first thing** in Civil's `IExtensionApplication.Initialize` and in Structural's
   `CeToolsInitializer.Initialize`, before any window or palette is built. A process-wide flag
   (`AppDomain.CurrentDomain.GetData("CE.ExcelBinding")`) makes the second product's call a no-op.
3. **Switch:** `excel.useAutoCadLoadedClosedXml`, ON by default, on the Settings page (R-00 settings-first). Plain
   label: "Use the Excel part AutoCAD already has". This is the name already written in BUG-1255's 30 Oct update; use
   it, do not invent a second. OFF = handler returns nothing (today's behaviour), safety net still on.
4. **Safety net:** move every ClosedXML touch out of the button methods into a `[MethodImpl(NoInlining)]` helper that
   is called inside the try, so a load failure is caught. Catch the library-load family and print the plain line.
5. **Log line, once per session:** `[BUG-1255] Excel part: CE asked for ClosedXML 0.102.3; using the copy already in
   this AutoCAD session (0.102.2, C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll).` This makes the AutoCAD check
   provable from the log without a picture.

### Code sketch (for the builder; not compiled)

```csharp
// Shared/ExcelBinding/ExcelLibraryBinding.cs  (linked into Civil and Structural)
#if NET
using System.Runtime.Loader;
#endif
internal static class ExcelLibraryBinding
{
    private static readonly string[] Family =
        { "ClosedXML", "DocumentFormat.OpenXml", "SixLabors.Fonts", "ExcelNumberFormat", "XLParser", "Irony" };

    // Pure decision, unit-tested without loading anything.
    internal static int PickIndex(AssemblyName requested, IReadOnlyList<AssemblyName> loaded, bool switchOn)
    {
        if (!switchOn || Array.IndexOf(Family, requested.Name) < 0) return -1;
        for (int i = 0; i < loaded.Count; i++)
            if (string.Equals(loaded[i].Name, requested.Name, StringComparison.OrdinalIgnoreCase)
                && SameToken(loaded[i], requested)
                && loaded[i].Version?.Major == requested.Version?.Major
                && loaded[i].Version?.Minor == requested.Version?.Minor)
                return i;
        return -1;
    }

    internal static bool IsLibraryLoadFault(Exception ex) =>
        ex is FileLoadException || ex is FileNotFoundException || ex is TypeLoadException
        || ex is MissingMethodException || ex is BadImageFormatException
        || (ex.InnerException != null && IsLibraryLoadFault(ex.InnerException));

#if NET
    [ThreadStatic] private static bool _busy;
    internal static void Register(string ownFolder, Func<bool> isOn, Action<string> log)
    {
        if (AppDomain.CurrentDomain.GetData("CE.ExcelBinding") != null) return;
        AppDomain.CurrentDomain.SetData("CE.ExcelBinding", true);
        AssemblyLoadContext.Default.Resolving += (alc, name) =>
        {
            if (_busy || Array.IndexOf(Family, name.Name) < 0 || !SafeIsOn(isOn)) return null;
            _busy = true;
            try
            {
                var loaded = AppDomain.CurrentDomain.GetAssemblies();          // 1. already in this session
                int i = PickIndex(name, loaded.Select(a => a.GetName()).ToList(), true);
                if (i >= 0) { LogOnce(log, name, loaded[i]); return loaded[i]; }
                string own = Path.Combine(ownFolder, name.Name + ".dll");      // 2. CE's own copy
                if (File.Exists(own))
                    try { return alc.LoadFromAssemblyPath(own); } catch (FileLoadException) { }
                try                                                             // 3. AutoCAD's copy, no version
                {
                    var a = alc.LoadFromAssemblyName(new AssemblyName(name.Name));
                    if (PickIndex(name, new[] { a.GetName() }, true) == 0) { LogOnce(log, name, a); return a; }
                }
                catch (Exception) { }
                log($"[BUG-1255] Excel part: no usable {name.Name} for {name.Version}; Excel export will offer CSV.");
                return null;
            }
            finally { _busy = false; }
        };
    }
#endif
}

// Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs  (ExportExcel, after the save box)
try
{
    SaveExcelWorkbook(exportRows, dialog.FileName);
    SetStatus("Excel export complete — sheet 1 the schedule, sheet 2 the checking sheet.");
}
catch (Exception ex) when (ExcelLibraryBinding.IsLibraryLoadFault(ex))
{
    LoggingService.Error("[BUG-1255] Pit Schedule Excel export could not start", ex);
    SetStatus(ExcelCouldNotStartLine);   // "Excel export could not start on this AutoCAD. Use Export CSV — it saves the same rows."
}
catch (Exception ex) { /* existing branch unchanged */ }

[MethodImpl(MethodImplOptions.NoInlining)]
private static void SaveExcelWorkbook(IReadOnlyList<PitScheduleRow> rows, string path)
{
    using (XLWorkbook workbook = BuildExcelWorkbook(rows)) workbook.SaveAs(path);
}
```

Same NoInlining split for CDCALC (`CalculationsV2ViewModel` ~line 859, which today would show the drafter a box
with "Could not load file or assembly 'ClosedXML...'"), Structural STRUCEXPORTCSV (`ExportService.WriteScheduleXlsx`),
the Sheets register (`CeSheetsWindow.xaml.cs` ~575) and the catalogue palette read (`MemberCataloguePanel.xaml.cs`
lines 45, 68, 171, 216; the palette shows "Excel catalogue could not be read on this AutoCAD" instead of crashing).

## 5. Which AutoCAD years each part touches

1. **2022–2024 (net48, Legacy):** handler compiled out. Safety net and NoInlining split still apply (harmless).
2. **2025–2026 (net8, Net8):** handler on. Whether these AutoCADs ship ClosedXML is Unknown; the handler is a no-op
   if they do not.
3. **2027–2028 (net10, Modern):** handler on; this is the fixed case.

## 6. The test

### Unit tests (Civil.Tests net10, and the Structural test project; CI-safe, no AutoCAD)

1. **`ExcelBinding_UsesAlreadyLoadedSameFamily`:** requested ClosedXML 0.102.3, loaded list has 0.102.2 same token,
   switch ON: picks it.
2. **`ExcelBinding_RefusesOtherFamily`:** loaded 0.104.0: picks nothing.
3. **`ExcelBinding_RefusesOtherPublisher`:** same name, different token: picks nothing.
4. **`ExcelBinding_SwitchOff_PicksNothing`.**
5. **`ExcelBinding_IgnoresNamesOutsideFamily`:** Newtonsoft.Json: picks nothing.
6. **`IsLibraryLoadFault_RecognisesWrappedLoadFailures`:** FileLoadException inside TargetInvocationException: true.
7. **`ExportExcel_KeepsExcelPartBehindTheGuard` (the failing twin in code):** reflection over
   `PitScheduleViewModel.ExportExcel`'s method body: no ClosedXML type in its locals or member references; the only
   ClosedXML user is the NoInlining helper. **Fails on 5888ee75** (ExportExcel declares an XLWorkbook local) and
   passes on the fix. Same guard for `CalculationsV2ViewModel`'s XLSX method and the three Structural sites.
8. **Existing `BuildExcelWorkbook` and BUG-571 tests must stay green** (numbers as numbers, headings not clipped).
9. **Count the tests that ran** (rule 5.4); on net10 the test host needs AutoCAD 2027 on PATH or it finds 0 tests.

### Real-runtime probe (accoreconsole 2027, automated, no window)

1. **Worst case forced:** the probe `Assembly.LoadFrom("C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll")`
   first, then loads the candidate `CE_CVL_SUITE.dll` (Modern), registers the binding, builds a three-row Pit Schedule
   with `BuildExcelWorkbook` and saves to `%TEMP%\ce_bug1255\pit.xlsx`. Pass: file exists, reopens with sheets "Pit
   Schedule" and "Checking", A1 reads "PIT No.", one inlet invert cell is a number. Also save one CDCALC package.
2. **Reverse order:** CE first, then load AutoCAD's copy by name. Pass: no exception.
3. **Partners:** the save must not throw for XLParser, Irony or ExcelNumberFormat (they come from CE's folder).
4. **Failing twin:** the same probe against the installed 3.0.86 DLL throws FileLoadException at step 1. That is the
   recorded 30 Oct 08:13 behaviour.
5. **Structural twin pair:** same probe calling `ExportService.WriteScheduleXlsx` and
   `CeSheetsRegisterExportService.ExportToExcel` from 1.0.125 (expected FAIL) and from the fix (PASS). This is the
   "one robot check" the earlier note asked for before filing the Structural bug.
6. **Manager question:** run step 1 without the forced load, with and without Manager's DLL loaded, and log which
   ClosedXML ends up loaded. Answers "who loaded 0.102.2 first".

### AutoCAD look (robot driver for the steps; Codex look only for the save box)

1. **Set-up:** a copy of the H3 fixture (a drawing with schedule rows). Through the AutoCAD driver, with FILEDIA 0:
   `NETLOAD` then `C:\Program Files\Autodesk\AutoCAD 2027\ClosedXML.dll`. This forces the 30 Oct situation every time.
2. **Pit Schedule:** `PITSCHEDULE`, click Export Excel. **Right:** the Windows save box opens; save as
   `C:\CE_TEST\BUG1255\Pit_Schedule.xlsx`; the window's status reads "Excel export complete — sheet 1 the schedule,
   sheet 2 the checking sheet."; no "rendering error" line on the command line after closing; the CE log has the one
   `[BUG-1255] Excel part:` line naming 0.102.2. Open the file in Excel: two tabs, headings readable at 100%, levels
   right-aligned as numbers.
3. **Second session, no NETLOAD:** same steps, same result (the other load order).
4. **CDCALC:** Export XLSX on the same copy after the NETLOAD. **Right:** file saved, no error box.
5. **Structural:** after the NETLOAD, `STRUCEXPORTCSV` (saves a .xlsx) and the Sheets register Excel export. **Right:**
   both files saved, no error.
6. **Safety net:** Settings, turn "Use the Excel part AutoCAD already has" OFF, repeat step 1 then step 2. **Right:**
   no save failure crash; the status reads "Excel export could not start on this AutoCAD. Use Export CSV — it saves
   the same rows."; Export CSV still works. Turn the switch back ON.
7. **Failing twin in AutoCAD:** steps 1–2 on the installed 3.0.86. **Expected:** no save box, "rendering error" twice,
   FileLoadException in the CE log. The 30 Oct 08:07 Codex run (H3) already recorded this; one rerun with the NETLOAD
   proves the set-up reproduces it on demand.
8. **Acceptance route:** file exists, file hash, log line and status text can be Claude-accepted (two sessions, twin
   fails, Opus reviewed against BUG-1255). The save box opening is a "seen" item and needs a Codex look.

## 7. Does CE Structural have the same fault?

1. **Yes, by construction.** Same ClosedXML 0.102.3, same token, same Modern lane, same shared load space as Civil.
2. **Places:** `Services/ExportService.cs` (STRUCEXPORTCSV writes `structural_schedule.xlsx`),
   `Services/CeSheetsRegisterExportService.cs` (CESHEETS register to Excel), and
   `Services/MemberCatalogue/XlsxMemberCatalogueProvider.cs` (the member catalogue palette reads .xlsx through
   ClosedXML, including when the palette opens and on every project change).
3. **Its existing resolve hook does not help:** `CeToolsInitializer.OnAssemblyResolve` sits on AppDomain.AssemblyResolve,
   behind .NET's load-from helper, which throws first.
4. **Not seen in AutoCAD.** No Structural log line. File the Structural bug only after the probe in section 6 step 5
   fails on 1.0.125, as the earlier note said.
5. **Cross-product rule:** ship the binding in Civil and Structural in the same install. Fixing one product only can
   leave the other failing, depending on which loads the Excel part first.

## 8. Notes for the builder and the desk

1. **Model:** Sonnet builds; Opus reviews (touches the load path of both products).
2. **Do not upgrade** ClosedXML or DocumentFormat.OpenXml in any net8/net10 lane without the probe; AutoCAD ships
   OpenXml 2.16 and SixLabors.Fonts 1.0 too, so a CE upgrade there would start a second clash.
3. **REGRESSION_LOG.md entry** with the 14 Oct pass and 30 Oct fail as the order evidence.
4. **Follow-on to park in the ideas file:** Option D2 (own writer) or C (private load space) as the permanent cure,
   triggered by the first `[BUG-1255] Excel part: no usable` log line from any user.
5. **Not tested by this pass:** nothing was run in AutoCAD or accoreconsole; the probe results above are expectations,
   not evidence.
