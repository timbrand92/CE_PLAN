# BUGFIX co4 report: CIVIL-OFF-4, one Upgrade action and the version stamp (Wed 4 Nov 2026)

**PR:** #2018 (DRAFT), branch `claude/civil-off-4`, one commit f39d2226. **Build number:** CIVIL-OFF-4 (B-XXX to be assigned by CE 01).
**Status in the four words:** Built. Unit-tested. NOT installed. NOT accepted. Nobody has opened it in AutoCAD.

---

## FOR TIM

1. **My own mistakes first.**
   1. The brief said to base this on origin/master. I did not: slices 1 to 3 (PRs #2015, #2016, #2017) are not on master, they are stacked on the release line, and the brief also says slice 4 must branch from slice 3. So #2018 sits on #2017 (head 3c76b8ac). master (650c0c19) has none of slices 1 to 3. CE 01 needs to know that when it assembles C-80.
   2. Cost me two wasted test runs: a quoting slip in my own run script, and one wrong capital letter in my own test. No effect on the product.
   3. I built the tests in Debug, which made two unrelated tests look red. I re-ran them in Release: 24 of 24 pass. They are not caused by this change.
2. **What a drafter will see (once installed):** a new button "Upgrade this drawing" on the CE panel, next to Civil. You can also type CDUPGRADEDRAWING.
   1. A box lists what will change in plain words, for example "46 pipes become pipe objects", how many pipes get a CE identity, how many pits CE has on record, and the backup file name. Buttons: OK (Upgrade) and Cancel.
   2. On OK, in this order: a dated backup copy of the drawing is saved beside it (PRE_C7 style); the pipes are converted (what CDC7UPGRADE does); CE's list is refreshed (what CDUPGRADE does, and it still asks Merge or Replace); then the drawing is stamped with the CE version.
   3. A done message gives the backup file name, the counts and the undo: type U once, or restore the backup file.
   4. In a drawing that was left as it is (Civil OFF), the same button is the way out: OK turns Civil ON and then upgrades.
   5. CDC7UPGRADE and CDUPGRADE still work exactly as before.
3. **When it cannot run it says why and changes nothing:** AutoCAD 2022 to 2024 ("open it in AutoCAD 2027"); the pipe upgrade switched Off in Settings; the drawing not saved yet ("save it with QSAVE first"); the backup could not be written; pipe objects this AutoCAD cannot read; read-only drawing; REFEDIT open. A pipe on a locked layer is left as drawn and the done message says to unlock that layer yourself and run it again. Xrefs are never touched. Nothing is unlocked by CE.
4. **Every save now stamps the CE version** into the drawing (your answer B). An upgraded or newly saved drawing therefore stops counting as "older" and CE stops asking about it. It is written inside the save CE already does, so it adds no extra undo step.
5. **One thing I changed that you should know about:** the stamp-on-save trips CE's REDO safety check, which is the check that stopped slice 2 from doing this. An independent Opus review read the code and said it is safe, and I added only the seven matching lines to the reviewed list. That is a judgement call on a protection, so the draft PR says it plainly.
6. **What is NOT proven:**
   1. Nothing was run in AutoCAD. The box, the button, the backup file, the conversion and the done message have only been unit-tested as text and by reading the code.
   2. "U once undoes the whole upgrade" is not proven.
   3. Your example "5 pits get a CE identity" is not produced. The two existing steps give pipes an identity, not pits, so the box says how many pits CE has on record instead.
   4. If you press Cancel at Merge or Replace after the pipes were converted, the pipes stay converted, the record is not refreshed, the drawing is not stamped, and the message says to run it again.
   5. The old (classic) ribbon layout has no button. A changed switch needs an AutoCAD restart for the button to appear or go.
7. **Robot case that would prove it (proposed name N40_upgrade_drawing, not written yet), in the style of N31_dp_time:** copy of an older job with a CE record and no stamp, saved to a file. It types `CDUPGRADEDRAWING`, answers OK on the box, answers `Merge` at the prompt, then reads (a) the command-line line starting "[CE] Upgrade done. Backup saved as" and that a file named `*_PRE_C7_*.dwg` now exists beside the drawing, (b) the count in "N pipes became pipe objects" against the pipe count read from the drawing, (c) the stamp entry CE_CVL_VERSION_STAMP reads the installed CE version. Switch-off control: set `options.oneUpgradeAction` false before launch (settings are read at AutoCAD start), type `CDUPGRADEDRAWING`: the only line is "Upgrade this drawing is switched off in Settings", no backup file appears, no stamp is written, and the button is absent from the CE panel. Broken twin: same drawing on AutoCAD 2022 to 2024 (or pipe upgrade set Off), expect the "cannot be upgraded ... Nothing has been changed" line and no backup file. Needs a Codex look for the box and the button.
8. **To check by hand (after an install, copies only):** open a copy of an older job, click Upgrade this drawing, read the box, press Cancel (drawing unchanged), click again, press OK, answer Merge, read the done message, type U once and see whether the pipes go back, then save and reopen and see CE no longer asks.

---

## Technical detail

1. **Base:** `claude/civil-off-3` head 3c76b8ac (PR #2017, base `claude/civil-off-2`, whose base is `claude/civil-off-1`, PR #2015 base `claude/rel-20261112a`). origin/master at fetch: 650c0c19. Slices 1 to 3 are not on master. PR #2018 base is `claude/civil-off-3`.
2. **Files (Civil, Modules/Drainage only; CE_SHARED, Structural, Manager untouched):**
   1. New `Commands/UpgradeDrawingCommand.cs`: `CDUPGRADEDRAWING` (free name, checked). Order: switch, gate, "cannot run" checks, counts, preview, backup (`PipeObjectUpgradeService.TryBackupDrawingFile`, always a fresh dated copy), Civil ON if OFF, `PipeObjectUpgradeService.UpgradeDrawing(doc, takeBackup:false)`, `new LinkCommands().CdUpgrade()`, stamp, done message. Uses the ordinary Windows message box (OK/Cancel). No new window.
   2. `Services/OldProjectPolicy.cs`: pure wording and decisions (`PreviewText`, `DoneText`, cannot-run lines, `ShouldWriteStampOnSave`, `ShouldStampAfterUpgrade`).
   3. `Services/OldProjectStampStore.cs`: one writer `PutInTransaction` shared by the upgrade and the save; `StampInRecordWrite` runs inside the caller's transaction, skips Civil OFF drawings, never lowers a stamp, swallows its own errors.
   4. `Services/ProjectDataService.Persistence.cs`: one line in `SaveToDrawing` and one in `WriteSnapshotInTransaction`.
   5. `Commands/LinkCommands.cs`: three counters set when CDUPGRADE reaches its end (CDUPGRADE otherwise unchanged; `CdUpgrade()` keeps its name because source guards read it).
   6. `Services/LinkService.cs`: command added to the record-flush list. `Services/CeCvlRibbonContributor.cs`: button behind the switch. `Assets/Config/command-registry.json`: registry entry.
   7. `Models/UserSettings.cs`: one block, `options.oneUpgradeAction`, "Default: on." **UTF-8 BOM checked: EF BB BF before and after.**
   8. Tests: new `CivilOff4Tests`; `CivilOff2Tests` test renamed and tightened (`NoStandaloneWriteOfTheStampBetweenCommands`); `RedoSafeReviewedHooks.baseline.txt` +28 lines (+1 comment line). `REGRESSION_LOG.md` entry added.
3. **Switch:** `options.oneUpgradeAction`, ON by default, pinned through `DeserializeSettings` and `DeserializeSettingsTolerant` for four file shapes, typed false/true, and the OFF behaviour (no button, no stamp on save, the plain "switched off" line). It also gates the stamp on save, as the brief asked for one switch.
4. **REDO:** `RedoSafeCallGraphTests.EveryHookBetweenCommands_IsRedoSafe_OrReviewed` failed on `PutInTransaction` reached from seven hooks via `SaveToDrawing`. Independent Opus review (agent a5398f9199abba748, read-only): SAFE TO BASELINE; no transaction, lock or Undo step of its own; cannot run where the record write does not. Its two edge notes: an error between `SetAt` and `AddNewlyCreatedDBObject` could leave a half-added object (very unlikely); a foreign object under the STAMP key would be replaced. I added only the seven `PutInTransaction` blocks to the baseline (not the regenerated file, which reorders and drops hand notes).
5. **Tests run (net10, ONE test project per command, with a filter, SkipDevBundle, `-nr:false --disable-build-servers -m:2`, BelowNormal, test count never 0):**
   1. `CivilOff4Tests`: 34 run, 34 pass (after fixing my own capital letter).
   2. Neighbours (CivilOff, DrawingDiscipline, PipeObjectUpgrade, B046, RedoSafe, UserSettings, NewSwitch, CommandRegistry, TypedCommandNames, Ribbon, CdDiag, TidyLabelsGate, Atomic, C5RefreshDirection, Bug1138, ScaledPitRecord, SettingsLoad, ProjectDataPersist, Bug971): 1156 run, 1154 pass in Debug. The two reds (`SourceAtomicCoordinatorDependencyTests`, IL shape) pass 24 of 24 in Release.
   3. net48 compile of Modules/Drainage: 0 errors (246 warnings).
   4. The B-099 real-folder guard says "inconclusive: an AutoCAD was running", so it cannot prove my run wrote nothing; see the listings below.
6. **Isolation (rule 1):** every test shell echoed `CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\co4\celog TEMP=TMP=C:\CE_WORK\scratch\co4\tmp`. Listings of `%APPDATA%\TIM_CE_CADTOOLS` (with CE_Admin\outbox and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE` and `CE_CADTOOLS` taken before (15:50, 36,973 files) and after (16:12, 36,978 files) were kept in scratch while I worked and removed with the scratch folder at the end, as the brief says (the folder names carry client addresses, so they were never going into this repo file). C: free space went from 80.4 GB at the start to 74.1 GB after clean-up (worktree and scratch removed; other jobs also use the disk, so the whole drop is not mine). 17 differences, in 11 files: 5 new Manager usage files in `CE_Admin\outbox\usage` (15:53 to 16:01), the Structural log and its runtime diagnostics, `ce_struc_suite.log`, the Civil structured log, and `CE_SUITE_MANAGER.json`. **I did not run Manager or Structural tests.** The Civil log's new lines are an MTEDIT in a structural drawing at 16:00 and Civil-quiet performance lines at 16:00 and 16:10, which is Tim's live AutoCAD session; the scratch log folder stayed empty. No settings file, no bundle and nothing in ProgramData changed. I cannot prove from the listing alone that none of these was mine; the content says they were Tim's session.
7. **Not done / for others:** no robot case written (named above); no Codex look; no Settings page row; classic ribbon not changed; no install. Nothing closed, deleted or force-pushed.
8. **Undo:** revert commit f39d2226, or set `options.oneUpgradeAction` to false.
