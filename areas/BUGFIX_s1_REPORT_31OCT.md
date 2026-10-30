# BUGFIX s1 report: Structural batch S-1 (Sat 31 Oct 2026, about 00:10 Melbourne)

## ANSWER FIRST

1. **PR number: none. No PR was opened.** All three entries in batch S-1 (BUG-529, BUG-300, BUG-474) are already fixed in the code on the Structural train line (origin/claude/rel-20261026s, head 204dfad2, installed Structural 1.0.125). Nothing was left to build. No build or test was run, so nothing could have touched Tim's settings.
2. **No build number:** the BUILD_REGISTER has no entry for these BUG numbers, and no PR was made, so none is needed.
3. **Mistakes of my own:** (a) my first listing of the real folders ran over the whole AppData tree and picked up job drawing names in the auto-save folder; it stayed in my scratch folder (C:\ce-scratch\s1) and none of it is in this report. (b) The 'git' and 'gh' commands were not on the PowerShell path; I used Bash. No harm done.
4. **NOT proven:** nobody has run these fixes in AutoCAD. The carpark entries say "OPEN", and I have not changed them (I must not edit BUG_CARPARK.md, and a bug is never FIXED without AutoCAD evidence).

## FOR TIM

1. **BUG-529 (footing size 12000 refused, stirrup cover 5 silently becomes 10, spacing 40 or 1200 refused):** already fixed in the installed code. Typing 12000 now gives a warning and carries on; a typed cover 5 is kept with a warning; a spacing outside the usual range is kept with a warning. Each has a Settings switch that is ON.
2. **BUG-474 (renaming a pad in FEDIT to a mark that already exists silently overwrites that mark's saved size):** already fixed. FEDIT now asks "Change / Leave / Another" before it changes the saved size. Switch is ON.
3. **BUG-300 (ERASE a footing line, then OOPS, the footing stays set aside and its outline is not redrawn):** already fixed in the code. The next footing command notices the line is back, lifts the "set aside" mark, redraws the outline and says "PF1 is back; CE redrew its outline." One thing to know: this happens at the next footing command, not the instant you type OOPS. I cannot tell without AutoCAD whether a drafter would see the outline missing in between.
4. **What I need from you:** nothing. These three just need an AutoCAD look on 1.0.125. A robot case for each is named below.
5. **Not touched:** your settings files, the installed bundle, AutoCAD, the other batches.

---

## TECHNICAL DETAIL

### Evidence per entry (all at head 204dfad2 of origin/claude/rel-20261026s, worktree C:\ce-fx\s1, branch fb/s1-footing-warn-carry-on, no commits)

1. **BUG-529 (a) footing size and depth.** Modules/Structural/Services/FoundationService.cs 4197-4198: `MaxSizeLimit` and `SizeWarningThreshold` come from `FootingWidth.LargeSizeLimitMm` and `FootingWidth.LargeSizeWarningMm` (labelled HUNT-S-12). `PromptDoubleWithinLimit` (4314-4334) reads `FootingWidth.WarnInsteadOfRefusingOverLimit` (default true, "also when no Settings can be read"), calls `FootingSizeLimitRule.Decide` and on `AcceptWithWarning` writes the warning and keeps the typed value; with the switch off the old refusal returns. `ConfirmLargeSize` (4298) is the existing Yes/No warning. Used by FPFC (4217-4288) and FEDIT (1930-1947).
2. **BUG-529 (b) stirrup cover.** Modules/Structural/Commands/RebarCommands.cs 311-330: offered cover from `Rebar.StirrupCoverMm`; `ReoEntryRules.ResolveStirrupCover(typed, WarnInsteadOfChangeStirrupCover, StirrupCoverWarnBelowMm)` keeps the typed value and prints a warning when the switch is on; off gives the earlier floor of 10.
3. **BUG-529 (c) spacing.** RebarCommands.cs 533-562 `PromptSpacing`: range from `SpacingLowestMm` and `SpacingHighestMm`; with `WarnInsteadOfRefuseSpacing` on, nothing is refused at the question and `ReoEntryRules.SpacingWarning` is printed (zero and below still cannot be drawn).
4. **BUG-474.** FoundationService.cs 1977-2007 (HUNT-S-11): `FeditSavedSizeRule.NeedsAsk(...)` with `FootingWidth.AskBeforeRenameChangesSavedSize` (default true); keywords Change / Leave / Another; `writeSavedSize` gates the `fst.Upsert` at 2048-2055. Another or Esc stops FEDIT with a line and changes nothing.
5. **BUG-300.** FoundationService.cs 896-911 (`SyncRegistryWithDrawingState`, S2 Opus review 4 finding 2): an orphaned element whose reason passes `IsErasedOrphanReason` and whose driver is live again has `ClearOrphanMark` applied, and 986-995 redraws the system and says `RestoredFootingWords`. The carpark text cites line 1651 from release 9babe787 (1 Oct); that code has moved. The drawing check runs at the start of each footing command; there is no reactor on OOPS itself, so a gap between OOPS and the next footing command remains (unseen in AutoCAD).

### Why the carpark and the batches file were out of date

The entries quote code at 9babe787 (1.0.110, 9 Oct). The batches file says it was made by a keyword sort and not checked against code. Fixes landed between 1.0.110 and 1.0.125 (HUNT-S-11, HUNT-S-12, S-31 finalizer). The carpark status lines were not updated. Suggest CE 05 add a line to each entry: "code fix on rel-20261026s, awaiting robot/AutoCAD look".

### Shared-file clashes seen (gh pr list on the line, base claude/rel-20261026s)

1. Open draft PRs touching Modules/Structural/Models/UserSettings.cs: #1895 (BUG-1184), #1886 (B-065 BUG-1183), #1885 (B-065 BUG-625). None touches FoundationService.cs. No edit of mine, so no clash.

### Robot cases proposed (not built; each needs the 1.0.125 build and a switch-off control)

1. **S01_fpfc_size12000:** type `FPFC`, mark PF9, X size `12000`, Enter, Enter, depth Enter. Check the command line has the "over the limit" warning line and the saved PF9 size reads 12000 x 12000. Control: set `FootingWidth.WarnInsteadOfRefusingOverLimit` to false before launch; the line must be "Value must be 10000 or less." and the question asked again.
2. **S01_str_cover5:** type `STR`, answer cover `5`; check the cover warning line appears and the stirrup is drawn with cover 5 (LIST). Control: `Rebar.WarnInsteadOfChangeStirrupCover` false gives 10 and no line.
3. **S01_rbl_spacing40:** `RBL`, spacing `40`; check the warning and that the label reads -40. Control: `WarnInsteadOfRefuseSpacing` false.
4. **S01_fedit_rename_clash:** place PF1 600 x 600 and PF5 700 x 600, `FEDIT` PF5, new mark `PF1`; check the prompt text "PF1 already exists at 600 x 600" and that answering `Leave` keeps the saved PF1 at 600 x 600 (read the FST memory). Control: `AskBeforeRenameChangesSavedSize` false, saved PF1 becomes 700 x 600.
5. **S01_erase_oops_footing:** place a strip footing, `ERASE` its line, `OOPS`, then run `FEDIT`; check "is back; CE redrew its outline." and the outline exists. This one also checks the gap between OOPS and the next command.

### Real-files comparison (no dotnet build or test was run by this job, so none could have written to these folders)

Listing taken with C:\ce-scratch\s1\list.ps1 (names, sizes, last-write times; no contents) of %APPDATA%\TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS and CE_SUITE, 32,308 lines each time (the full listings stay in C:\ce-scratch\s1\listing_before.txt and listing_after.txt because they carry job drawing names, which must not go in a repo).

1. **Before (00:03):** settings files: CD_Settings.json 15,270 bytes, 2026-10-04 08:22:30; CS_Settings.json 351,713 bytes, 2026-03-31 13:18:00; a second CS_Settings.json 35,613 bytes, 2026-10-30 19:54:14; settings.json 672 bytes, 2026-09-16 12:13:17.
2. **After (00:10):** the same four settings files with the same sizes and times. Total file count equal.
3. **Only difference:** two small recovery or lock-style json files named CE_CVL_SUITE__...json and CE_STRUC_SUITE__...json (508 to 544 bytes and 498 to 480 bytes) were rewritten at 00:03:50 to 00:04:07. They changed between my two listings while my job was only reading. They are not settings files; they are written by another running session (the robot or a live AutoCAD). Not written by this job.

### Left behind

1. Worktree C:\ce-fx\s1 and local branch fb/s1-footing-warn-carry-on exist with no commits and no bin/obj (nothing was built). Not pushed, nothing deleted.
2. BUG_CARPARK.md and DESK_LOG.md untouched.
