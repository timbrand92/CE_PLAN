# Train C-42 finalizer report (Civil + Manager), Sun 18 Oct 2026 (about 01:25 to 01:55, Melbourne time)

**Answer first: GO.** Train `claude/rel-20261018b`, final head `1bd133b9` (was 6c700e2c; one finalizer commit on top, pushed as a normal fast-forward). Built and unit-tested only. Nobody has opened any of it in AutoCAD; nothing was installed, deployed or version-edited. All six fix rounds really cure the Hunt Civil E examples (read line by line against the review entries 1089 to 1103, not only the builders' tests). The four switches that ship ON stay ON (the old behaviour is the bug in each); the copy-and-grip switch stays OFF.

**Manager does not need to ship with this train:** nothing under `Shared/` or `Modules/Manager` changed, and `ce-tool-register.json` was not touched, so CE_SHARED is the same as the one installed with 3.0.52 / 1.1.52.

## 1. What I changed (one commit, `1bd133b9`)

1. **Pit on one half of a broken pipe (BUG-691, plain words):** the pit is placed and the pipe left alone (right), but the drafter only saw "The pipe under this pit could not be split automatically. Run CDCHECK to review it." The real reason went to the CE log only, and it said "Nothing was changed" although the pit had just been placed. Now the command line says: "The pipe under this pit was not split: it is one half of a broken pipe (a breakline or a same-plan break), and splitting one half would give it the wrong levels, so the pipe was left as it was. Take the break off first if it should be split here." Same for a trench grate or a tagged block. Every other refused split still says the old line. Red first.
2. **Recalculate downstream, skipped pipe (BUG-653, review LOW 2):** the preview line showed the pipe's drawing handle in brackets. Now the pit names only. Red first.
3. **Recalculate downstream, back-fall refusal (BUG-654, review LOW 1):** it said "run it again and choose to overwrite the typed level", which Edit Pipe never offers. Now: "run CDPROPAGATE and choose Overwrite when it asks about levels set by hand". Same refusal, nothing written, as before. Red first.
4. **net48 reds, test only (assembler flag 7.5):** the four `Bug687DesignFlowOnlyChangeTests` and the four `PreparedPipeAggregateTests.MissingAnyAcceptedAnnotationRefusesBeforeOutputStarts` rows threw InvalidProgramException on the AutoCAD 2024 reference stubs. Same lane-aware habit as C-41: the AutoCAD 2027 lane runs them for real and re-throws (no weakening); only the stub lane builds the edit context without its AutoCAD field set-up, or checks the four comparisons in the source. Red on net48 at 6c700e2c (8 failed, my own run), green after. The PreparedPipeAggregate test is unchanged from the C-41 base, so it was red there too whenever net48 ran it.
5. **Comments only:** two method summaries sat on the wrong method (#1318 in `CdCommand.PitFit.cs`, #1328 in `LinkService.Compound.cs`, review LOW 2 of entry 1100); moved back.
6. **REGRESSION_LOG:** one entry, 13 lines added, 0 removed.

## 2. The fix rounds, judged against the review entries

1. **#1317 c14f04c8 (entry 1089 HIGH and MEDIUM): right.** Edit Pipe now hands the cascade the arriving level from the record snapshot taken BEFORE the save (`oldToInvertSnapshot`, from a cloned row, so AddPipe cannot change it). At the anchor pit the edited pipe counts at its OLD level for the pit drop and is still left out of "other arriving pipes". Worked again: raise 10.00 to 10.20 over outlet 9.95, outlet goes to 10.15 (50 mm kept); lower to 9.80, outlet 9.75 (not the rulebook drop). A blank old level means "no level", never RL 0.00. The preview's grade edits keep the edited pipe and its old level (the plan carries both). LOW 1 and LOW 2 fixed by me (section 1.2 and 1.3).
2. **#1318 4a56a72d (entry 1090 MEDIUM): right.** CD's fit check now reads the pit block's own turn (one open-close read, so no Undo step) and falls back to the record only when the block cannot be read. A pit turned with ROTATE is now checked on its real side.
3. **#1321 6db4dc78 (entry 1093 MEDIUM): right.** A closed polyline is no longer closed up into a loop pipe; the points are used as drawn and the line is kept, with one plain sentence. Still possible (LOW, as before the PR): a closed line whose last corner sits on its first still gives a pipe that starts and ends at one spot.
4. **#1322 2f6cfca5 (entry 1094 MEDIUM): right.** Orienting by the record and rewriting the pit keys are now two separate decisions. Only Edit Pipe's save passes the flag (checked: `PipeEditCommand.Update.cs:637` is the only caller with it), so only Edit Pipe rewrites the stored pit keys, exactly as before; CD, COPY, the pit relink, CDREPAIR and CDSYNC only orient. Tested.
5. **#1327 2644c197 (entry 1099 MEDIUM): right.** The held end is marked Hidden (present, not drawn) instead of switched on, so no IL text appears that the drafter had switched off.
6. **#1331 5af6ef3e (entry 1103 MEDIUM): right.** The reader turns the stored millimetres into drawing units only for the "past the end" compare and gives the wording real millimetres, so a metre drawing keeps its downpipe junctions. The other readers only use the ratio or the order (scale-free) and the spine does not use the number. Older metre drawings that stored drawing units read the same as before (they said "0.0 m" before and still do; not worse).
7. **#1323 3c539f02 (entry 1095 LOW): fixed.** "Nothing was changed" is gone from the record/label mismatch line; CD still carries on drawing. PITEDIT is a real command.

## 3. The five switches and what Tim will notice

1. `linking.cascadeKeepsPitDrop` **ON, keep.** Only after he answers Yes to "Recalculate downstream" (Edit Pipe) or runs CDPROPAGATE. He will see in the preview the next pipe start one pit drop (for example 50 mm) under the pipe he changed, instead of level with it. Today's level-with-it result is the bug.
2. `linking.relinkKeepsRecordedDirection` **ON, keep.** A pipe drawn from its low end keeps its From and To (P2 to P1) when CE relinks it after a COPY, a pit move or CDREPAIR. Today it turns round, which flips its levels and arrow: the bug. A pipe with no record, or a record that does not match its ends, behaves as today.
3. `linking.refuseSplitOfPairedPipe` **ON, keep; not a hard block.** It refuses only CE's automatic split of one half of a broken pipe; the pit (or grate, or tag) is still placed, the command carries on, and the line now says why and what to do. Today the split gives a wrong level and leaves the break symbol on the wrong half: the bug. There is no prompt, so nothing to Cancel or Escape; U removes the pit as usual; the way through is "take the break off first", and the office can switch it off in CE Settings.
4. `linking.copyCleanUpKeepsEveryPiece` **ON, keep.** A copied pit or pipe gets all its own labels; today some go missing. One visible side effect (review LOW): if the original's level text had been deleted by hand but the level is still recorded, the copy shows that level text.
5. `linking.cleanUpGripRotateScaleCopies` **OFF, keep.** Grip, ROTATE and SCALE copies behave exactly as today.
6. **None of the five has a Settings window row** (R-00, standing). For Codex after 22 Oct: one Settings-page card should add all five.

## 4. Tim's ruling I2: nothing pops up to block a quick edit

1. **No modal window, message box, new command-line question or held lock added by any of the 21.** Scanned every added non-test line of the train for windows, prompts, picks, locks, hooks and timers. The only new lock is a short one inside CDEDIT's own pit batch, after its Apply (#1326 re-snap, released at once). The Edit Pipe "Recalculate downstream inverts?" question already existed; it is not new. Grips, MOVE and Properties gain no window.

## 5. Redo-safe (guardrail 8 item 17)

1. **#1333's three baseline lines: accepted.** `RestoreSkippedPipesToPitLists` is called only from `RelinkAllPipesToPitsScoped`, which is called only from `ApplyPendingPitRelinks`, which runs at the end of a NON-history command (inside that command's Undo step). At the end of U, UNDO, REDO or MREDO the command-end handler takes the history branch and returns before any link work (`LinkService.Reactors.cs`, the `IsUndoCommand` branch ends in `return`). The three lines sit under OnCommandEnded, OnCommandCancelled and OnCommandFailed, next to the already-reviewed `RelinkAllPipesToPitsScoped` line. So it cannot run between U and REDO. No other new watched call. Redo guard green on net10 (whole suite) and net48 (focused).

## 6. Rules re-checked

1. **Settings-first:** every new behaviour has a Settings value with a C# default; the pit drop comes from the rulebook. **No hard blocks:** see 3.3. **No blue:** no window or XAML changed. **Plain English:** after my commit no new drafter line names a setting or a handle; commands are named (PITEDIT, CDPROPAGATE). **Locked layers, Xref, REFEDIT:** the re-snap uses the pipe mutation guard and never unlocks; the copy clean-up skips a locked pit-annotation layer; the pit relink leaves a pit on a locked layer alone; nothing bypasses Xref or REFEDIT. **CE_SHARED:** nothing under `Shared/` changed.

## 7. Builds and tests (build lock round every run; Below Normal; skip-bundle, no node reuse, no build servers; logs to scratch)

1. **Whole solution, Release, at 6c700e2c:** 0 errors, 885 warnings (assembler: 0 / 885), 3 min 42 s. After my commit: 0 errors (incremental).
2. **Civil net10, whole suite, final head:** 18,119 run, 18,099 pass, 19 skipped, 1 failed = `BackTest_GlenEira24115_Computed_WithinTolerance` (on the plain base too). Assembler: 18,115 / 18,095 / 19 / 1. The four extra are mine.
3. **Civil net48 focused** (the assembler's class list): at 6c700e2c 380 run, 355 pass, 17 skipped, 8 failed (the eight in 1.4, same as the assembler). Final head: 384 run, 365 pass, 19 skipped, 0 failed. The skipped ones are the cascade class (it skips itself when it cannot load AutoCAD on that lane) and the rotated-UCS pick class, as before.
4. **Manager 751/751, CommandTruth 64/64, TestHarness 101/101, Spine 81/81, Diagnostics 19/19, AI.Core 42/42, ReleaseTests 16/16.** All equal to the assembler.
5. **Not run:** Installer.Tests, Structural tests, the net8 test lane, anything in AutoCAD.
6. **Tim's files, unchanged before, after every suite and at the end:** `CD_Settings.json` 15,270 bytes ACD64E79; Civil `CS_Settings.json` 351,713 bytes 622A246F; Structural `CS_Settings.json` 34,858 bytes 24D8E5F7; live CE folders CE_CVL_SUITE 102 files, CE_STRUC_SUITE 2,474, TIM_CE_CADTOOLS 22,193, byte totals identical. AutoCAD not running. Disk 21.6 GB free; ignored build output cleaned.

## 8. Risks still open (none HIGH)

1. **LOW: a pipe copied BEFORE #1328 from a broken pipe** still carries the original's break-symbol record, so placing a pit on that copy is now refused as "one half of a broken pipe" although it shows no break. The tracked split already did the same. Put it in the Codex recipe.
2. **LOW:** Properties-palette pit moves twice in a row (#1334 note may still be set); erase a pipe in an older drawing (#1328 stale owner); both already in the review's Codex list.
3. **Housekeeping:** the assembler's worktree (`agent-adbd3ed46fc93c149`) is now 1 commit behind origin; fast-forward it before reuse.

## 9. What Codex should check in AutoCAD (copies only)

1. **Edit Pipe raise and lower with a 50 mm pit drop:** P1 to P2 arrives at 10.00, P2 to P3 leaves at 9.95. Edit Pipe on P1 to P2, set the downstream level 10.20, OK, Yes to "Recalculate downstream": the preview shows P2 to P3 starting at 10.15. Repeat with 9.80: 9.75.
2. **ROTATE then CD:** ROTATE a 600 x 900 pit 90 degrees, CD a 750 pipe into its 600 side: the Upsize / Continue / Cancel question appears.
3. **CD E on a closed polyline and a curved one:** the line is kept, one plain sentence, no loop pipe.
4. **Same-plan break:** PIT on one half: pit placed, pipe not split, the new line from 1.1 shown.
5. **Metre drawing:** a downpipe 12.5 m along a 30 m pipe, then Pit Schedule and Inspector: junction worded at 12.5 m.
6. **Plus the review's list** (entry 1112.2): two Properties-palette pit moves in a row; Pit Schedule level on one half of a breakline pipe; erase a pipe in an older drawing; #1328 with #1337 copy clean-up; #1317 with #1327 two cascade routes.

## 10. Not tested

No window, palette, ribbon or drawing was looked at; nothing ran in AutoCAD; Installer and Structural tests and the net8 test lane were not run.

OPUS SIGN-OFF train claude/rel-20261018b GO (1bd133b978a247943b1e9c42f3d22fa03d666271)
