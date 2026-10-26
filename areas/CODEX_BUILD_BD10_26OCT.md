1. **ANSWER FIRST — BUG-1143: DONE, build delivery.** [Draft PR #1803](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1803) targets `claude/rel-20261025r`. Branch: `cx4/bug-1143-design-draft-backup`. Built and unit-tested; no AutoCAD acceptance or installation is claimed.

2. **Heads checked.** Final branch head: `b76db8f3b415b3f20343a4ba21a3a761c47e92e3`. The brief's recorded head, the fetched untouched base used, and the final refreshed release head all match: `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. The release branch had not moved, so no merge was needed. Tested source commit: `fbd79ec95f5f4c694548a67c3f628f9e65c4db07`; the final commit changes only the validation entry in REGRESSION_LOG.md.

3. **Tests added: red first, then green.** The three exact requested names are in `Modules/Drainage.Tests/Services/CivilProjectStartDraftStorageTests.cs`. The damaged-data test has text and binary/non-text cases, making four cases across the three names. First, only those tests and a compiling pure stub returning false were added. Filter: `FullyQualifiedName~Bug1143`. Red: 3 failed, 1 passed, 0 skipped, 4 total. The actual failing lines were:

```text
Failed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(False)
An unreadable draft must be kept under a backup key before Save Draft.
Expected: True
But was: False

Failed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(True)
An unreadable draft must be kept under a backup key before Save Draft.
Expected: True
But was: False

Failed CivilProjectStartDraftStorage_Bug1143_ExistingBackup_IsNeverOverwritten
Expected: String containing "earlier backup" and containing "not been replaced"
But was: <string.Empty>
```

   After the real change, all 13 focused BUG-1143 cases passed. Actual passing lines:

```text
Passed CivilProjectStartDraftStorage_Bug1143_ExistingBackup_IsNeverOverwritten
Passed CivilProjectStartDraftStorage_Bug1143_ReadableExistingDraft_MakesNoBackup
Passed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(False)
Passed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(True)
Passed Bug1143_DesignDraftBackupRow_RendersEveryRealTabAt1080p("DarkTheme.xaml","dark")
Passed Bug1143_DesignDraftBackupRow_RendersEveryRealTabAt1080p("LightTheme.xaml","light")
Test Run Successful. Total tests: 13. Passed: 13.
```

4. **Full-suite totals, compared with the untouched base.** Before: 20346 passed, 2 failed, 32 skipped, 20380 total; 22 m 8 s. After: 20362 passed, 1 failed, 32 skipped, 20395 total; 1 h 11 m. All 15 added cases passed in the full run. No new failed name appeared. The failed-name sets differ because the baseline PDF failure did not recur; this is not a claim that BUG-1143 changes PDF behaviour.

   1. **Failed in both runs:** `CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile` — `Queued diagnostic never reached the log file. Expected: True; But was: False.`
   2. **Failed only on the untouched base:** `CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` — the PDF renderer produced only blank pages.
   3. **Also reported in both runs:** the SettingsIsolationSetup cleanup could not remove the synthetic `CE_CVL_SUITE.log` because it was still in use. This existing cleanup error was not changed.

5. **What Tim will see in AutoCAD once a reviewed build is installed.** If a Design draft in a drawing is damaged, CDDESIGN still starts a blank draft. When Save Draft or Confirm setup is pressed, the old contents are first kept in this drawing as a backup. CE then prints one line explaining that the CE administrator can recover it, rather than the agreed outlet, head and detention answers being silently replaced without a copy. Readable drafts save as before. If an earlier backup exists, it stays untouched and CE says so.

6. **Exact real-AutoCAD check — still required, not run here.** The AutoCAD runner should use a COPY of a synthetic drawing, after review and installation, in AutoCAD 2024 and 2027.

   1. **Fixture:** require that the copy has neither draft nor backup key. Under a document lock, make an Xrecord named `CE_CVL_DESIGN_START_DRAFT` with exactly one Text TypedValue: `{bad draft json`. Capture its original TypedValue type, value and bytes. Do not damage an existing production drawing or delete another record.
   2. **Carpark steps:** open CDDESIGN, observe the unreadable-draft/fresh-draft line, then press Save Draft.
   3. **Right result:** `CE_CVL_DESIGN_START_DRAFT_UNREADABLE_BACKUP` contains exactly the fixture's original TypedValue contents; the main draft can now be read. Command history and the CE log contain the exact line below.
   4. **Companion checks:** on separate fresh copies, repeat Confirm setup, binary/non-text contents, no data and a wrong-type record. With an earlier distinct backup already present, confirm that its contents do not change and the retained-backup line below appears. A readable existing draft creates no backup. With the switch OFF, saving gives the older replacement without a copy.
   5. **Undo and Redo:** U, then REDO; check that no backup write happens between those two commands. Opening or closing the drawing and opening Design without saving must create no backup.

```text
[CE] The old Design draft could not be read. It has been kept in this drawing as a backup; the CE administrator can recover it.

[CE] The old Design draft could not be read. An earlier backup is already kept in this drawing for the CE administrator to recover; it has not been replaced.
```

7. **What was not run.** AutoCAD, a real damaged drawing, the native fixture above, an installation or a deployment. The pictures are off-screen WPF renders, not AutoCAD screenshots. The drawing-side backup still needs the real AutoCAD check; the bug register was left for the desk.

---

8. **Small shared change and switch.** Save checks the existing contents through the same Decode method used by Read. Its one pure decision returns the original TypedValue array without decoding and rewriting it; the drawing wrapper copies those contents before replacement. A wrong-type record is kept whole under the backup name. Both changes share one transaction and document lock. All three existing callers in CivilDesignCommand still use that one Save; the source guard checks this and the backup-before-replacement order. The earlier `Starting a fresh draft.` line reads sensibly with the new line after saving, so the command source did not need editing.

   The switch is `linking.designKeepsUnreadableDraftBackup`, default ON, with the requested plain `Default: on.` documentation. OFF gives the older replacement without a copy. Tests pass the switch explicitly or use synthetic settings; none reads Tim's real settings files. Coverage includes SettingsService.DeserializeSettings for an older file and a typed OFF, both in-memory round trips, the existing row/search/reset checks and the existing save/reopen persistence test. Those two sibling-pattern cases plus the 13 focused cases make 15 additions, all passed in the full run.

9. **Three framework builds.** Civil Release net48: 0 errors, 242 warnings, 7 min 0.84 s. Net8.0-windows: 0 errors, 216 warnings, 9 min 51.06 s. Net10.0-windows: 0 errors, 214 warnings, 10 min 56.97 s. Every .NET build/test used absolute project paths, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, and these reference arguments:

```text
-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
-p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
-p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

   AutoCAD's library folder was added only to the test process's PATH. The three final builds and final suite used the already-restored packages. The final suite included the build/copy step. The Civil DLL in the test output exactly matches the final net10 build: SHA-256 `402433002B908CF609CBD05CB21972C5B7B6AD8ADF8CE22843B50EE91DB92E43`.

10. **Window and pictures.** The Newer tools tick row uses the existing Settings shell, fixed header/footer, SettingsPageStyle, SettingsTickTextStyle and Civil editor theme resources. The tallest tab stays 670 px in dark and light, under 673 px. The STA tests use RenderTargetBitmap on the real source window at 1080p scale 1. Every one of the 16 pictures was viewed; no new clipping, overlap or scrolling was found. All paths are committed and listed in the draft PR:

   1. **Drafting:** `docs/image/V3_WINDOWS/settings-dark-1-drafting.png`; `docs/image/V3_WINDOWS/settings-light-1-drafting.png`.
   2. **Pipes and pits:** `docs/image/V3_WINDOWS/settings-dark-2-pipes-pits.png`; `docs/image/V3_WINDOWS/settings-light-2-pipes-pits.png`.
   3. **Design:** `docs/image/V3_WINDOWS/settings-dark-3-design.png`; `docs/image/V3_WINDOWS/settings-light-3-design.png`.
   4. **Survey:** `docs/image/V3_WINDOWS/settings-dark-4-survey.png`; `docs/image/V3_WINDOWS/settings-light-4-survey.png`.
   5. **Display:** `docs/image/V3_WINDOWS/settings-dark-5-display.png`; `docs/image/V3_WINDOWS/settings-light-5-display.png`.
   6. **Advanced:** `docs/image/V3_WINDOWS/settings-dark-6-advanced.png`; `docs/image/V3_WINDOWS/settings-light-6-advanced.png`.
   7. **Newer tools:** `docs/image/V3_WINDOWS/settings-dark-7-newer tools.png`; `docs/image/V3_WINDOWS/settings-light-7-newer tools.png`.
   8. **Other existing switches:** `docs/image/V3_WINDOWS/settings-dark-8-fixes.png`; `docs/image/V3_WINDOWS/settings-light-8-fixes.png`.

11. **Safety.** Initial free space was 51097767936 bytes, safely above 8 GB. Own worktree: `C:\ce-cx\bd10`, from the requested release branch. No CE_SHARED or protected source was edited. Only the drawing's own draft and backup records are written; no drawing entity is changed, so locked layers, Xrefs and REFEDIT protection are not involved. No new open, close, U, UNDO or REDO writer was added. No layer was unlocked and no other drawing content was rewritten. Nothing was written under ApplicationPlugins or ProgramData. Only BUG-1143 is included.

12. **Fresh-worktree prerequisites and evidence.** The first baseline attempt stopped at the missing native transform build file. The main checkout's file was empty, so the existing native project was built inside this worktree with ProductionIntegration=true, SkipDevBundle=true and node reuse off; no native source was edited or installed. A discovery attempt without AutoCAD's library folder on PATH reported no tests and was rejected. Only the complete 20380-case run was used as the baseline. The final release refresh matched the initial base, so no merge was needed; nothing was rebased or force-pushed. REGRESSION_LOG.md keeps its earlier entries and has BUG-1143 at the top.

   Durable local evidence remains outside the removable worktree: `C:\ce-cx\bd10-evidence\bug1143-base.trx`, `bug1143-red.trx`, `bug1143-green.trx` and `bug1143-after.trx`; the matching logs are `C:\ce-cx\bd10-base-tests.log`, `bd10-red.log`, `bd10-green.log`, `bd10-after.log` and `bd10-build-<framework>.log`. The TRX counters include 28 additional unexecuted entries beyond each console total: base total 20408 / executed 20348 / passed 20346 / failed 2; after total 20423 / executed 20363 / passed 20362 / failed 1. The console totals above are the directly comparable results.

13. **Undo and hand-off.** Revert the two BUG-1143 code-branch commits, `fbd79ec95f5f4c694548a67c3f628f9e65c4db07` and `b76db8f3b415b3f20343a4ba21a3a761c47e92e3`, to undo this change. No deployment was made. Draft PR #1803 remains open for review. BUG_CARPARK.md, the desk log and the queue were not edited. This report is saved by name only in CE_PLAN; the own worktree is removed after the report push, as the brief requires.