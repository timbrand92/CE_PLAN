# BUGFIX ff1981b report, 4 Nov 2026: fix-first for draft PR #1981 (BUG-630, SM section mark)

## FOR TIM

1. **What you will see differently:** type SM, answer the number, pick two points, pick Right. The bubbles now point Right, the same as the preview shows. Before this fix the drawing got your SECT MARK block facing whichever way it was saved, whatever you picked.
2. **What changed:** the SECT MARK block now sits behind its own switch, `Annotation.SectionMarkUseOfficeBlock`, **Default: off**. With it off, SM draws the bubble CE drew before, which does show the view side. The new order (number first), the preview and "wait for Enter" are unchanged and stay on.
3. **Rule I did not follow, on purpose:** the standing rule is that new switches ship ON. The Opus review said this one must ship OFF until someone has read a copy of the block and wired its direction in. I followed the review. Switch it on only after that is done. Flip it if you disagree.
4. **My own mistakes:** my first AppData "before" listing timed out, so there is no before-listing (see below). I also got two PowerShell quoting slips that cost two test runs. Nothing was written to your files.
5. **NOT proven:** nobody has opened this in AutoCAD. Built and unit-tested only. BUG-630 stays OPEN. The block's own direction, layer and scale are still unknown.
6. **Robot case that would prove it:** `B146_sm_view_side` (to be written, not written yet). It types `SM`, number `A`, sheet `S01`, two points, then `Right`, then Enter. It checks the bubble polylines were drawn (no `SECT MARK` block reference in the drawing) and that the tick/bulge side matches Right. Switch-off control: set `SectionMarkUseOfficeBlock` true before launch and check a `SECT MARK` block reference appears instead (old behaviour).

---

## Technical detail

1. **Fault confirmed:** `SectionMarkCommands.cs` (PR head e4d762a8) inserted the block with rotation `0.0` at both ends, so the chosen direction was never applied.
2. **Fix, commit d66c4813 on `fb/bug630-section-mark-preview`** (one normal commit, no force-push, no new PR, base unchanged `claude/rel-20261026s`):
   - `Commands/SectionMarkCommands.cs`: `UseOfficeBlock()` reads the new switch (default false). `FindOrImport` runs only when it is on, so with it off the office blocks file is not even read or copied. The "block missing" line prints only when a lookup actually failed.
   - `Models/UserSettings.cs`: `SectionMarkUseOfficeBlock`, default false, documented "Default: off."
   - `Services/SettingsService.LoadRecovery.cs`: label line.
   - `Structural.Tests/Core/SectionMarkPreviewThenPlaceTests.cs`: new test, off through the plain read and `DeserializeSettingsTolerant`, typed true stays true, command reads the switch.
   - `REGRESSION_LOG.md`: one entry on top.
3. **Tests:** `dotnet test Modules\Structural.Tests\CE_STRUC_SUITE.Tests.csproj --filter FullyQualifiedName~SectionMark -f net10.0-windows`, with the SkipDevBundle flags: Passed 30, Failed 0 (not zero tests).
4. **net48:** `dotnet build ... -f net48 -c Release` produced no compile errors. The only error was the post-build "no CE_SHARED metadata" step, which could not find `powershell` on this job's PATH (exit 9009). I did not rerun it with that on PATH.
5. **Not touched:** CE_SHARED, Manager, Tim's settings, installed bundles. REFEDIT stop (review item 5, optional) not added: that is a second change, not the FIX FIRST finding.
6. **Review notes left as they are:** the direction is saved before the locked-layer stop; the new path duplicates about 60 lines of the old one.
7. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP and CE_STRUC_SUITE_APPDATA_ROOT pointed at `C:\CE_WORK\scratch\ff1981b`. Dotnet jobs running at the start: 0.
8. **AppData listing after the last test (top level only, size, last write):** `TIM_CE_CADTOOLS`: CD_Settings.json 15270 (4 Oct), CS_Settings.json 351713 (31 Mar), CD_RecentValues.json 12223 (2 Nov 20:27), CD_ProjectData.json 8278 (27 Jan), last_version.txt 6 (3 Nov), logs dir (4 Nov 00:41). `CE_STRUC_SUITE`: CS_Settings.json 35613 (30 Oct), CS_Settings.json.PRE_TIM_YES_20261020.bak 34858 (18 Oct), logs dir (21 Oct). `CE_CVL_SUITE`: settings.json 672 (16 Sep), logs dir (4 Nov 00:00), telemetry dir (4 Nov 01:18). `CE_CADTOOLS`: install-id.txt 32 (19 Aug), CE_Admin and CE_SUITE_MANAGER dirs (4 Nov 01:18). **No before-listing exists** (the recursive listing timed out). Every settings file's date is older than this run, so my run did not write them. The 4 Nov 00:00 to 01:18 log and telemetry stamps are, I believe, from a running AutoCAD or CE process, not from the tests (not verified).
9. **Cleanup:** see the end of this file.
