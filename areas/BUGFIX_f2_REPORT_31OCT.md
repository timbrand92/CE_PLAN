# BUGFIX f2 report: BUG-642, the CDCATCHMENT label no longer sits on the pipe wording (B-111)

Job f2, Sat 31 Oct 2026, Melbourne time. Draft PR **#1924** off `claude/rel-20261102a` (Civil 3.0.88, head 3fbb9da5). Built and unit-tested only. Nobody has opened it in AutoCAD.

## FOR TIM

1. **What you will see:** run CDCATCHMENT on the two-pit drawing and the "P1 catchment: 42 m²..." label now stands clear of "225 DIA. UPVC PIPE AT 1 IN 48". CE tries up-right of the pit (where it stood before), then up-left, down-right, down-left, then the same four twice as far out, and uses the first spot where the whole label (about 8 m long) clears existing text and the other catchment label.
2. **If nowhere is clear:** the label stays where it was before and the command line says "[CE] P1 catchment label could not find a clear spot; check it." It never stops the command.
3. **One new switch, ON:** `surface.catchmentOverlayLabelAvoidsText`. Switch it OFF and the label goes exactly where it did before (300 mm up and right, 200 mm high). The label height (typed into the code as 200 until now) is now the Settings value `surface.catchmentOverlayLabelHeightMm`, 200.
4. **Nothing else changes:** it only reads the text already in the drawing; it writes nothing extra, unlocks nothing, and does not touch the fill, colour or Hide/Show.
5. **What I did NOT prove:** nothing was run in AutoCAD. A Codex look is needed because it is a picture. Pit symbols and pipe lines are not counted as things to avoid, only TEXT and MTEXT. Text inside blocks or attributes is not read.
6. **Mistake of my own:** my first edit put the new warning line into the Hide/Show part of the command as well; the build caught it at once and I removed it (no run was affected).

---

## Technical detail

1. **Fault confirmed still present** on `claude/rel-20261102a` (Civil 3.0.88 installed): `Services/CatchmentOverlayStyle.cs` `LabelPoint` returned pit + (300, 300) always, and `GratedPitCatchmentOverlayService.Draw` wrote `TextHeight = 200.0` typed in. No open Civil PR touches either file (searched). z3's cause is still true.
2. **Change (Modules/Drainage only; CE_SHARED untouched):**
   1. `CatchmentOverlayStyle.ChooseLabelSpot` (pure): candidate spots in order up-right, up-left, down-right, down-left at the Settings offset, then at twice the offset; first spot where the label box has no clash by `TextClashTidyUpRule.FirstClash`; none clear returns today's spot with `Clear = false`. `LabelHeight` and `AvoidsText` helpers.
   2. `GratedPitCatchmentOverlayService.Draw` now returns the warnings. It reads TEXT and MTEXT boxes once (`ReadTextBoxes`, read-only, same transaction, no outline means left out as in the tidy-up), writes each label, measures it with MText `ActualWidth`/`ActualHeight` (estimate only if AutoCAD gives none), then moves only that label's location. Labels already placed in the run count as obstacles. A failure in the search is logged and the label stays put.
   3. `CatchmentOverlayCommand` prints the warnings.
   4. `UserSettings` `SurfaceDrainageSettings`: `catchmentOverlayLabelAvoidsText` (true) and `catchmentOverlayLabelHeightMm` (200), both documented "Default:".
   5. REGRESSION_LOG.md entry. No Settings page row exists for the older three BUG-642 values (the grep shows none), so none was added for these.
3. **Tests (net10, one project per command with a filter):** `Bug642LabelClearSpotTests` plus the existing `Bug642CatchmentOverlayStyleTests`: 21 of 21 pass. A pit-note box over the old spot gives a clear spot (down-right, 300, -500) where today's `LabelPoint` clashes; nothing near keeps today's spot; all spots blocked returns today's spot with the no-clear flag; the second label avoids the first; switch OFF is exactly pit + 300 and height 200 even with a different height typed; bad heights use 200; defaults ON and 200 through both `DeserializeSettings` and `DeserializeSettingsTolerant`; the read holds no `ForWrite`. A pin was added to `C75NewSwitchDefaultsTests`. Second focused run (C75 and C78 new-switch defaults, the C60 settings-key guard, UserSettings, SettingsLoad, CatchmentOverlay, RedoSafe): 159 passed, 3 skipped, 0 failed (162 ran, not zero). Civil net48 build of `CE_CVL_SUITE.csproj`: 0 errors. The full suite was not run (the job brief said focused only).
4. **Proposed robot case N97_catch_label_clear / C97** (z3 called it N96; this job's brief named N97):
   1. **Drawing:** a copy of CODEX_CATCHMENT_OVERLAY_20261015, the two-pit 84 m² drawing.
   2. **Types:** `CDCATCHMENT`, New, pick the outline, P1, P2, Enter.
   3. **Checks:** take the extents of each MText on layer `CE CATCHMENT OVERLAY` and of the "225 DIA. UPVC PIPE AT 1 IN 48" text; pass = no box intersects another and no "could not find a clear spot" line on the command line.
   4. **Switch-off control (N97_off):** set `surface.catchmentOverlayLabelAvoidsText` false, repeat: P1's label insertion point equals pit centre + (300, 300) and its box intersects the pipe note.
   5. **Codex look still needed** for readability.
5. **Not proven:** AutoCAD behaviour of `ActualWidth`/`ActualHeight` on a just-added MText (the estimate fallback is 0.9 x height x characters); the drawing-units side fault (300 and 200 are drawing units, so a metres drawing would get 300 m, same family as BUG-209) is unchanged and not fixed here.
6. **Test isolation:** the four variables pointed at `C:\CE_WORK\scratch\f2\...` for every test (printed each time; the log folder stayed empty). No Manager tests, no full suite. Each dotnet test named one csproj and a filter. AutoCAD (acad.exe, started 16:33 by Tim) was open throughout; I did not start AutoCAD, Codex or accoreconsole.
7. **Real-files compare (summaries, names/sizes/times from the full listings taken 16:36 and 16:41):**
   1. Before: TIM_CE_CADTOOLS 29,550 files, 1,140,755,522 bytes, newest 16:36:25. CE_STRUC_SUITE 2,500 files, 2,100,102,429 bytes, newest 16:34:04. CE_CVL_SUITE 302 files, 81,052,550 bytes, newest 16:36:26. CE_CADTOOLS 1,022 files, 110,300,293 bytes, newest 16:35:46. CE_SUITE: folder does not exist.
   2. After: TIM_CE_CADTOOLS 29,553 files, 1,140,756,683 bytes, newest 16:40:14. CE_STRUC_SUITE 2,500 files, 2,100,103,318 bytes, newest 16:37:47. CE_CVL_SUITE 302 files, 81,135,027 bytes, newest 16:40:15. CE_CADTOOLS 1,022 files, 110,300,293 bytes, newest 16:40:46. CE_SUITE: still absent.
   3. **Changed files, all explained by Tim's live AutoCAD, not by my run:** `CD_RecentValues.json`, `ledger\suggestions.jsonl`, the Civil structured and CE_CVL_SUITE logs, `ce_struc_suite.log`, `runtime_snapshot.json`, the two `CE_Admin\outbox\machines` files, `CE_SUITE_MANAGER.json` session heartbeat, and three new `CE_Admin\outbox\usage` files. One of them was read: it records command PIT, plugin 3.0.88, AutoCAD 26.0, started 05:38 UTC, i.e. a drafter command in the open AutoCAD. No settings file (settings json) is in the changed list. My test runs wrote nothing to the real folders as far as the listing shows (the scratch log folder was empty), but I cannot prove that no AutoCAD-session write overlapped with a test write in the same minute.
8. **C: free space:** 48.3 GB at the start (16:30), 46.9 GB at the end before cleaning; after cleaning 47.2 GB (net movement about 1.1 GB down at the end of the job; the worktree and scratch folder were removed, but the empty folder shell C:CE_WORKbuild2ModulesDrainage could not be deleted because another process held it; it holds no files). Finished at 16:42 Melbourne time.
