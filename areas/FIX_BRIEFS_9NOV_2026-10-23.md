# Fix briefs for the 9 Nov Civil + Manager release (Fri 23 Oct 2026, Melbourne)

**Who wrote it and how.** The CE fix-brief author (Opus 5.5), read-only on the source and on `BUG_CARPARK.md`. Nothing was built, tested, installed or opened in AutoCAD. Code was read with `git` only, at `origin/claude/rel-20261022m` = `40ee0a36` (installed Civil 3.0.70 / Manager 1.1.70). The only file written is this one.

**Sources read:** `C:\TimOS\RULES.md`; `areas/V3_RECOUNT_2026-10-22.md` (the 252 list); `areas/RELEASE_9NOV_GAP_PLAN_2026-10-22.md`; `areas/AUDIT_C58_C60_S40_S41_2026-10-22.md`, `AUDIT_ENGINEERING_CIVIL_2026-10-22.md`, `AUDIT_UI_WORDING_2026-10-22.md`; `areas/CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`; `areas/CODEX_HUNT_IMPORT_22OCT.md`, `CODEX_HUNT_LABELS_22OCT.md`, `CODEX_HUNT_UNDO_22OCT.md`; every one of the 252 carpark entries (heading, area and status), and the full text of about 100 of them.

---

## ANSWER FIRST

### The numbers

1. **Screened: all 252 bugs that recount 3 lists as "open with no fix".** (The carpark holds 253 headings for them: BUG-866 is used twice, for two different bugs.)
2. **Correction, said first (RULES 6.2): 50 of the 252 are already fixed in the installed Civil 3.0.70.** The fixes were named by their hunt label ("HUNT-C-01", "IJK-07", "HUNT-M-05", "privacy finding 5") or as a group ("BUG-670/671/672"), so the recount's number search missed them. 3 more are built on a branch, not installed. So the real "open, no fix" count is about **199, not 252**. List in "Left out", group 1.
3. **9 Nov relevant and still open: 53.** That means a colleague would meet it in the daily Civil + Manager tools, and nothing fixes it yet.
4. **In the 25 briefs: 31 of those 53 bugs** (some briefs carry two to four bugs that share one piece of code). The other 22 are left out because they need your engineering or design word (13), already have their own brief or a built fix (6), or have no known cause, work as designed, or may no longer be reachable (3).
5. **Sizes: S 18, M 7, L 0.** S = a day or less for one builder; M = two to three days.
6. **No Manager bug made the 25.** Every open Manager entry is either already fixed (the HUNT-M batch), parked (administrator, installer, publishing), or belongs to the shared help that drives a Structural tool.
7. **Recommendation:** FB-01 to FB-10 go into train C-62 (Wed 28 Oct) if each passes its Opus review; the rest run as lanes come free and are trained after 9 Nov unless they are ready by Sat 31 Oct. Nothing here asks you to test: robot PASS plus Codex PASS is the acceptance.

### The 25, in priority order

1. **FB-01, BUG-668 (M):** moving or rotating a run of pits, pipes and callouts puts the pipe callouts in the wrong place, and saves it.
2. **FB-02, BUG-690 (M):** placing a pit on an existing pipe leaves the first half "ending" at the far pit; a branch junction drops out of the Pit Schedule.
3. **FB-03, BUG-793 (S):** opening any drawing with pits redefines PIT BLOCK 3, so an untouched drawing asks "Save changes?".
4. **FB-04, BUG-373 (S):** Edit Pipe, then Cancel, still marks the drawing changed.
5. **FB-05, BUG-817 (S):** opening and closing the Pit Schedule leaves its own Undo step.
6. **FB-06, BUG-664 (S):** after Edit Pit renames P5 to P9, a later relink can jump a pipe end to a new, distant P5.
7. **FB-07, BUG-692 + BUG-693 (M):** pit on an existing pipe: a callout goes to the wrong half; a curved pipe is split wrongly.
8. **FB-08, BUG-572 (S):** the CE Inspector says "Type Unknown" for new CE pipes.
9. **FB-09, BUG-799 (S):** the Pit Schedule says "SOURCE MISSING" for an Xref that is only unloaded.
10. **FB-10, BUG-707 (M):** CDSURVEY can store the old levels under the new survey file's fingerprint.
11. **FB-11, BUG-570 (S, window):** the Edit Pit preview keeps showing the old pit number and cover level.
12. **FB-12, BUG-225 (S):** the Close button on the Pit ribbon tab does nothing.
13. **FB-13, BUG-771 (S):** CDRG: Enter to finish a raingarden outline cancels the whole command.
14. **FB-14, BUG-796 report half (S):** Repair Center buttons report what they tried, not what they did.
15. **FB-15, BUG-855 (S):** the Pit Schedule "data issues" count goes up by one after the first CDSYNC.
16. **FB-16, BUG-719 + 720 + 723 + 724 (M):** LandXML import: real files lose every pipe; control pits drawn double length; box pipes and pipe classes wrong.
17. **FB-17, BUG-725 + 728 + 729 (S):** LandXML import: position scale, falling-pipe grade, unrounded cover levels.
18. **FB-18, BUG-648 (M):** AG drain grade is checked but never labelled on the drawing.
19. **FB-19, BUG-760 (S):** long section: a level pipe with no grade label stops the whole long section.
20. **FB-20, BUG-764 (M):** long section: boundary marks measured on a straight line, not along a bent pipe.
21. **FB-21, BUG-765 (S):** long section: any bare number in an Xref can become a surface level.
22. **FB-22, BUG-766 (S):** long section through CDPROFILE never draws branch junction marks.
23. **FB-23, BUG-811 cascade half (S):** level cascade can leave a step at a pit where two branches rejoin.
24. **FB-24, BUG-810 (S):** the audit commands write to the drawing, misread metre drawings, and can crash.
25. **FB-25, BUG-812 (S):** redesign Apply puts new pits at the bottom of the schedule; a copied pump pit is dropped without a word.

---

## Rules for every brief (builders read this once)

1. **Base:** `origin/claude/rel-20261022m` at `40ee0a36` (installed Civil 3.0.70 / Manager 1.1.70). A fresh worktree under `.claude/worktrees/<short name>` (long paths break the native build). Never master: it is about 1,100 commits behind what ships.
2. **Build and test:** `dotnet build CE_ACAD_PLUGIN.slnx -p:SkipDevBundle=true -nr:false --disable-build-servers` with the AutoCAD ref paths (net48 refs at `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`). net48 and net10.0-windows both 0 errors. Check how many tests ran; zero is not a pass. Never deploy, never start AutoCAD, never touch Tim's settings files; the desk trains and installs.
3. **Test first:** the unit test fails on the base, then passes with the fix.
4. **Every change =** code + a `REGRESSION_LOG.md` entry + the unit test + the robot case text (the "Real-AutoCAD check") handed to the test pack queue.
5. **Settings switch rule:** new behaviour goes behind a Settings switch that starts OFF, unless the old behaviour is the bug. All 25 briefs fix a bug, so each says either "no switch" or "a switch that starts ON" (a switch ON lets the desk turn the old behaviour back without a build). Any new value goes on the Settings page (R-00). No new hard block (R-27): warn and carry on.
6. **CE_SHARED is one assembly identity.** No brief here changes it. If a builder finds it must, stop and ask the desk: Manager then needs the same file, lane for lane.
7. **Native protection:** never unlock a layer, never write into an Xref or during REFEDIT.
8. **Redo safety:** nothing may write between a U and the REDO after it. Anything that touches reactors, first-open work, Idle work or Undo gets an Opus review (model routing rule, 21 Oct).
9. **Commit messages name every bug number in full** ("Fix BUG-692 and BUG-693", never "BUG-692/693" or a hunt label alone). This screen found 50 fixed bugs the recount could not see because of that.
10. **Words a drafter reads** are plain English and start "[CE]". No code words.
11. **Codex briefs:** do not use the verb spelled f-o-l-l-o-w anywhere in the text (it was typed into AutoCAD as stray text, BUG-421).
12. **The carpark is the desk's.** Builders do not edit `BUG_CARPARK.md`; the desk adds the status lines after each train.
13. **Robot check conventions:** a synthetic DWG made by the case script on a fresh copy under `C:\Lisp Files\_TEST_COPIES_20260923\FIXBRIEFS\`; model space, World UCS, INSUNITS 4 (mm) unless the brief says metres; Civil-tagged; packaged PIT BLOCK 3; AutoCAD 2027 driven by the desk's driver (`C:\Lisp Files\_ACAD_DRIVER`), complete commands only. Evidence = CE log lines, `(getvar ...)` values, `entget` or `vlax` reads, and a screenshot for anything in a window. Robot PASS plus Codex PASS = Codex-accepted.

---

## FB-01 · BUG-668 · Moving or rotating a run puts the pipe callouts in the wrong place

1. **Size and severity:** M. HIGH: a wrong position is saved on the drawing. Daily tool: MOVE and ROTATE.
2. **Plain symptom:** select a run of pits, pipes and their callouts (the "100 DIA. UPVC PIPE AT 1 IN 100" leaders) and MOVE it 5 m along the pipe, or ROTATE it 90°. The callouts land part-way along the wrong segment or at the pipe end, and that wrong spot is saved. A single straight pipe is not affected. Found by reading code (HUNT Civil E, finding C4); not yet seen in AutoCAD.
3. **Expected:** each callout keeps its place along its own pipe (same distance from the upstream end, same side) after the whole set moves or turns.
4. **Where to look (read at 40ee0a36):** `Modules/Drainage/Services/LinkService.PipeAttachmentUpdates.cs`, the MLeader branch of the attachment update (about lines 150 to 215). It reads the callout's stored placement (`TryReadCalloutPlacementData`: an anchor and a text point in world co-ordinates, saved before the move), projects that OLD anchor onto the moved pipe with `TryGetClosestSegment`, and rewrites `SegmentIndex`, `T`, `CalloutDx` and `CalloutDy`. Called from `ApplyExternalModifiedPipeUpdates` (`LinkService.PipeUpdates.cs:213`) through `LinkService.Reactors.cs:1123`.
5. **Smallest safe fix:** before trusting the stored anchor, check whether the callout itself moved with the pipe in this command: its current arrow point (leader line 0, first vertex) lies on the moved pipe within tolerance and the stored anchor does not. Then take the segment and T from the current arrow point and refresh the stored placement. Otherwise keep today's logic (stored anchor, then the drift repair). Put the choice in a pure helper (for example `Rules/CalloutAnchorChoice.cs`) so it is testable without AutoCAD.
6. **Must NOT change:** the repair for a callout left behind when only the pipe moved or stretched (`repairTolerance`); hand-placed labels staying put (UX-LBL-01); the re-tidy inside an edit (UX-LBL-02, robot PASS run 47); a quick MOVE opening no CE window; one U undoing the MOVE.
7. **Settings switch:** the old behaviour is the bug. Add `linking.calloutKeepsPlaceOnGroupMove`, starting ON, under Labels on the Settings page.
8. **Unit test (red first):** `CalloutAnchorChoiceTests`: (a) a bent run and its callout moved 5000 along X together: current arrow chosen, T unchanged within 0.001; (b) the same run rotated 90° about 0,0: current arrow chosen; (c) the pipe stretched alone, callout not moved: today's stored-anchor answer.
9. **Real-AutoCAD check (robot):** fixture FX-01: pits P1 at 0,0, P2 at 20000,0 and P3 at 20000,15000; CD P1 to P2 and P2 to P3, 375 UPVC, callouts at mid-pipe. Steps: (1) read each callout's arrow point with `(vlax-invoke (vlax-ename->vla-object e) 'GetLeaderLineVertices 0)` and its distance along its pipe; (2) `_.MOVE _ALL  0,0 5000,0`; (3) read again; (4) `_.ROTATE _ALL  0,0 90`; (5) read again; (6) `_.QSAVE`, close, reopen, read again. **Assert:** after steps 3, 5 and 6 every arrow lies on its own pipe within 1 mm, at the same distance along it within 1 mm; one U reverses each step and REDO restores it.
10. **Builder and review:** Sonnet (Team) builds; Opus reviews (reactor path, redo safety).

---

## FB-02 · BUG-690 · Pit placed on an existing pipe: the first half still "ends" at the far pit, and a branch junction disappears

1. **Size and severity:** M. HIGH: the network check and the Pit Schedule go wrong without a word. Daily tool: PIT on a pipe.
2. **Plain symptom:** place a pit onto an existing pipe P1 to P3 (the inline split). The first half keeps the connection decision that names P3, so CDCHECK still reads it as ending at P3, and a branch junction recorded beyond the split disappears from the Pit Schedule. From code (HUNT Civil E, finding G1).
3. **Expected:** connection decisions and branch junctions move to the half they sit on, with their distance measured from that half's start, exactly as the tracked route already does.
4. **Where to look:** `Modules/Drainage/Services/LinkService.Split.cs`, `TrySplitPipeAtCandidate` (starts at line 1524; the inline route). It gives the second half its own spine key (`GiveSplitHalfItsOwnIdentity`, line 236) but never moves the decisions. The tracked route does it at `LinkService.SourceChangeApply.cs:141` with `SourceChangeDecisionPolicy.After(...)` (`Services/SourceChangeDecisionPolicy.cs`). Decisions are read in `LinkService.Spine.cs` (about 290 to 320, `SpineDecisionLedger.Find`, `Services/Spine/SpineDecisionLedger.cs`); junction rows come from `Rules/BranchJunctionDisplay.cs` (about 73 to 96 and 114).
5. **Smallest safe fix:** in the inline route, inside the same transaction and after the second half has its spine key, call the same decision policy the tracked route uses (no second copy of the rule: design rule 1), and re-base junctions beyond the split point onto the second half.
6. **Must NOT change:** the tracked route; BUG-691 (a pit placed on one half of a broken pipe leaves the pipe alone, switch ON); the level worked out at the split (`Rules/SplitHalfRule.cs`); one U removing the pit and putting the pipe back whole with its old decisions.
7. **Settings switch:** `linking.inlineSplitMovesDecisions`, starting ON (the old behaviour is the bug), under Pipes.
8. **Unit test:** `InlineSplitDecisionTests`: a 20 m pipe with an end decision naming P3 and a junction at 14.0 m, split at 8.0 m: the first half carries no decision naming P3; the second half does; the junction sits on the second half at 6.0 m.
9. **Real-AutoCAD check:** FX-02: P1 at 0,0 and P3 at 20000,0, CD P1 to P3 375; a branch from DP1 at 14000,5000 joined to the main at 14000,0; CDCONFIRM on the P3 end. Steps: (1) save the Pit Schedule rows (Export) and the CDCHECK list; (2) `PIT` at 8000,0, defaults, Esc; (3) save both again. **Assert:** the branch junction row is still there, under the new pit to P3 half at 6.0 m; CDCHECK shows the first half ending at the new pit, not at P3; one U gives rows identical to step 1 (0 differences); REDO puts the split back.
10. **Builder and review:** Sonnet; Opus review. Same lane as FB-07 (same file); FB-02 first.

---

## FB-03 · BUG-793 · Opening any drawing with pits redefines PIT BLOCK 3, so an untouched drawing asks "Save changes?"

1. **Size and severity:** S. MEDIUM. Every colleague, every drawing with CE pits.
2. **Plain symptom:** on the first activation of a drawing, CE redefines PIT BLOCK 3 from the shipped master even when it is already current. The drawing is marked changed, so AutoCAD asks "Save changes?" on a drawing nobody touched. It also adds history, and it is one of the first-open writers `CODEX_AUDIT_CIVIL_22OCT.md` names as a BUG-861 (lost REDO) suspect.
3. **Expected:** no write when the drawing's PIT BLOCK 3 already matches the shipped one. Drawings with PIT BLOCK or PIT BLOCK 2 still migrate as today.
4. **Where to look:** `Modules/Drainage/Services/PitBlockMigrationService.cs`: `Plan` (about 205 to 240) always puts "PIT BLOCK 3" in the redefine list when present (the comment says "refreshes even an existing PB3"); the Idle runner (about 140 to 175) runs `Migrate(db)` (line 254) under a document lock after the REDO deferral.
5. **Smallest safe fix:** a geometry stamp. When CE redefines PB3 it also writes a small stamp on the block definition (an Xrecord in its extension dictionary holding a fingerprint of the shipped master, for example its SHA-256). `Plan` takes a "stamp matches" input: PB3 present, no older names, stamp equal to the shipped fingerprint gives `MigrationPlan.None`. A drawing with no stamp is redefined once, as today, and stamped in that same write.
6. **Must NOT change:** Tim's June 2026 ruling that the migration is automatic; the PB / PB2 rename and redefine; the REDO deferral (`RedoWindowGuard.DeferWhileRedoOpen`); never running inside a command. Part (a) of the bug (a consultant's own block called "PIT BLOCK" being taken over) is not in this brief: narrowing the migration is Tim's call.
7. **Settings switch:** `pits.skipCurrentPitBlockRedefine`, starting ON.
8. **Unit test:** `PitBlockMigrationPlanTests`: {PB3} with matching stamp gives None; {PB3} with no stamp gives one PB3 redefine; {PB2} and {PB3, PB2} as today.
9. **Real-AutoCAD check:** FX-03: a drawing with three CE pits, opened once on the fixed build and saved (so it holds the stamp). Steps: open it; wait 10 s; read `(getvar "DBMOD")`; read the CE log tail; `_.CLOSE`. **Assert:** DBMOD 0; no "[PitBlockMigration] auto-migrated" line; no Save question. Control: an old PB2 drawing still migrates once (log line present) and gets the stamp.
10. **Builder and review:** Sonnet; Opus review (first-open writer, redo safety).

---

## FB-04 · BUG-373 · Edit Pipe, then Cancel, still marks the drawing changed

1. **Size and severity:** S. LOW-MEDIUM, and part of the REDO family. Daily tool: CDEDIT and double-click on a pipe.
2. **Plain symptom:** open Edit Pipe on a pipe, change nothing (or type a value) and Cancel: DBMOD went from 17 to 21 (desk driver session 15). A Cancel must write nothing.
3. **Expected:** Cancel leaves DBMOD unchanged, adds no Undo step, and REDO is still available.
4. **Where to look:** `Modules/Drainage/Commands/PipeEditCommand.cs`, `EditPipe` (about line 53): `ProjectDataService.EnsureDrawingDataCurrent(doc.Database)` runs before the window opens, so the sync can save CE's record into the drawing even when the drafter cancels. A reader that changes nothing already exists: `ProjectDataService.TryReadProjectWithoutChanging` (`ProjectDataService.cs:170`).
5. **Smallest safe fix:** open the window from a read that changes nothing. Lane 04's BUG-863 fix (CDCHECKIGNORE) uses the same pattern: reuse its helper, do not fork it. Run the sync only on Save or Apply, inside the same command and before the write, so Save stays one U.
6. **Must NOT change:** what the window shows (prove it with a snapshot test that the read-only path fills the same fields); Save; the cascade (robot regression "Yes, Apply, U, REDO", runs 32 to 47); `CheckIgnoreCommand.cs` (lane 04 owns it).
7. **Settings switch:** none if the snapshot test shows the same window contents; otherwise `editing.openWithoutSync`, starting ON.
8. **Unit test:** a source guard that the EditPipe path calls none of `EnsureDrawingDataCurrent`, `SyncWithDrawing` or `SaveProjectData` before the Save handler; plus the snapshot equality test.
9. **Real-AutoCAD check:** FX-04: two pits and one pipe, saved. Steps: `_.QSAVE`; `(getvar "DBMOD")` reads 0; `CDEDIT`, pick the pipe; the driver presses Cancel; read DBMOD; type `U`. **Assert:** DBMOD 0, and U names the command before CDEDIT, not CDEDIT or PIPEEDIT. Control: change the diameter, Save, one U undoes it.
10. **Builder and review:** Sonnet; Opus review.

---

## FB-05 · BUG-817 · Opening and closing the Pit Schedule leaves its own Undo step

1. **Size and severity:** S. LOW. Daily tool: PITSCHEDULE.
2. **Plain symptom:** after a cascade Apply, the first U echoes "PITSCHEDULE" and only the second U undoes the real command. A drafter who only looked at the schedule loses a U (robot runs 30 and 31).
3. **Expected:** looking at the schedule adds no Undo step unless it really changed the drawing, and then it says what it changed.
4. **Where to look:** `Modules/Drainage/Commands/PitScheduleCommand.cs` (REFEDIT check, `CurrentLayerGuard.RememberOrRepair`, `PitScheduleDialog`, then `CurrentLayerGuard.RepairIfLost`); its own comment says opening must not write. Candidates for the write: `CurrentLayerGuard.RepairIfLost`, a refresh of the drawn table on Close, or a project save at command end. `ViewModels/PitScheduleViewModel.Data.cs` `RelinkAndRecalc` (about 984) is a button, not the open path.
5. **Smallest safe fix:** find the object that changes (DBMOD plus a database ObjectModified log on a headless accoreconsole probe of open and close, the desk's probe recipe), then skip that write when no row was edited.
6. **Must NOT change:** schedule edits (one U each); Stop overriding; the CHECK marker; the read-only view (HUNT-C-07).
7. **Settings switch:** none.
8. **Unit test:** a guard on the writer found: no write when no row changed.
9. **Real-AutoCAD check:** FX-05 = FX-04 plus a placed schedule. Steps: `_.QSAVE`; `PITSCHEDULE`; the driver presses Close; read DBMOD; type `U`. **Assert:** DBMOD 0, and U names the command before PITSCHEDULE.
10. **Builder and review:** Sonnet; Opus review.

---

## FB-06 · BUG-664 · Edit Pit rename: the pipes still remember the old number

1. **Size and severity:** S. MEDIUM. Daily tool: Edit Pit renumbering.
2. **Plain symptom:** rename P5 to P9 in Edit Pit, place a new pit (it becomes P5), then a relink or CDREPAIR runs: the pipe end jumps to the new, distant P5, because each pipe's own note in the drawing still holds the old name.
3. **Expected:** the pipe ends stay with P9; the rename updates the pipes' own notes too.
4. **Where to look:** `Modules/Drainage/Commands/PitEditCommand.cs`, `RenamePitInPipes` (about 1844 to 1867) changes only the project record's From and To. The pipe's own note (`PipeLinkData.ExplicitFromPitId` and `ExplicitToPitId`) is read first by the relink (`LinkService.RepairAudit.Linking.cs` about 446 to 450, `BuildOwnerFromPitId`). Today's writer, `LinkService.SetExplicitPipeOwnership` (`LinkService.Registration.cs` about 632), opens its own transaction and relinks, so do not call it here.
5. **Smallest safe fix:** a new internal `LinkService.RenameExplicitPitOwnership(Database, Transaction, oldId, newId)` that rewrites only the matching explicit names on pipe notes, called from the Edit Pit rename step (the ledger step "connected pipe names") inside the same command, so one U undoes the whole rename.
6. **Must NOT change:** the BUG-408b refusal of a rename onto an existing number; the ledger wording; one U.
7. **Settings switch:** none.
8. **Unit test:** `PitRenameOwnershipTests`: three notes naming P5 (from), P5 (to) and P6; after P5 to P9 the first two read P9 and the third is untouched; the match ignores case.
9. **Real-AutoCAD check:** FX-06: P4, P5 and P6 in a row with pipes P4 to P5 and P5 to P6. Steps: Edit Pit on P5, number P9, Save; `PIT` at 60000,0 (it becomes P5); `CDREPAIR`, accept; save the Pit Schedule rows and the CDCHECK list. **Assert:** the pipes read P4 to P9 and P9 to P6; no pipe ends at the new P5; U back past the Edit Pit step restores the P5 names.
10. **Builder and review:** Sonnet; Opus review not needed beyond the normal train review.

---

## FB-07 · BUG-692 + BUG-693 · Pit on an existing pipe: a callout goes to the wrong half; a curved pipe is split wrongly

1. **Size and severity:** M (after FB-02, same file). MEDIUM. Daily tool: PIT on a pipe.
2. **Plain symptom:** (692) a callout whose text was dragged across the new pit goes with its text to the wrong half. (693) a pipe with an arc segment gets both halves rebuilt with the wrong curves. From code (HUNT Civil E, findings G3 and G4).
3. **Expected:** (692) the callout stays with the half its arrow points at. (693) curved pipes are not split on this route: the pit is placed, the pipe stays whole, and one plain line says so (the same-plan break already refuses curves).
4. **Where to look:** `LinkService.Split.cs`, the attachment loop in `TrySplitPipeAtCandidate` (about 1636 to 1665): `GetEntityPosition(ent)` gives an MLeader's TEXT point, not its arrow. Curves: `TryBuildInlineSplitPaths` (line 2002) and `ReplacePolylineVertices` (line 2292) work on points only; the bulge is read only at vertex 0 (`HasBulge`, about 587 and 788). Pattern to copy: `LinkService.SamePlanBreak.cs` lines 76 to 77.
5. **Smallest safe fix:** (692) for an MLeader, measure the station from its arrow point (leader line 0, first vertex, or the stored callout anchor). (693) before splitting, if any segment's bulge is not zero, do not split and print "[CE] The pit was placed. Pipe P1 to P3 has a curve, so CE did not split it; split it by hand if needed." Warn and carry on (R-27).
6. **Must NOT change:** straight-pipe splits; FB-02's decision move; one U.
7. **Settings switch:** none (the old behaviour is the bug).
8. **Unit test:** `InlineSplitCalloutHalfTests` (arrow at 5 m, text at 15 m, split at 10 m: first half); `InlineSplitCurvedPipeTests` (bulge 0.3 on segment 2: no split, the plain reason).
9. **Real-AutoCAD check:** FX-07a: CD P1 at 0,0 to P3 at 20000,0 with its callout arrow at 5000,0 and the text dragged to 15000,1500; `PIT` at 10000,0; then `ERASE` the second half pipe. **Assert:** the callout still exists (it belongs to the first half); U twice restores. FX-07b: a CE pipe whose segment 2 has bulge 0.3 (set by the case script); `PIT` at the arc's mid-point. **Assert:** pipe count unchanged, the bulge unchanged (DXF 42 read), the plain line printed, the pit placed.
10. **Builder and review:** Sonnet, same lane as FB-02.

---

## FB-08 · BUG-572 · The CE Inspector says "Type Unknown" for new CE pipes

1. **Size and severity:** S. MEDIUM. Daily: the Inspector on every pipe pick.
2. **Plain symptom:** a new stormwater pipe drawn with CD shows "Type Unknown" and a heading with no end names in the Inspector, while Edit Pipe correctly says Stormwater (Codex, 14 Oct, real AutoCAD).
3. **Expected:** the Inspector shows the type Edit Pipe shows; a pipe with no type recorded stays Unknown.
4. **Where to look:** `Modules/Drainage/Services/InspectorPaletteService.cs` about 855 to 860: the type comes only from the old pipe XData (`PipeDrawableOverrule.GetPipeXData`), which the 2027 CE pipe object does not carry. The pipe's own note has it: `PipeLinkData.PipeType` (`LinkService.State.cs:369`), read by the private `LinkService.ReadPipeLinkData` (`LinkService.Persistence.cs:765`).
5. **Smallest safe fix:** an internal read-only `LinkService.TryReadPipeTypeForDisplay(Polyline, Transaction, out PipeType)` that uses the palette's existing transaction, ForRead only. Order: the pipe note, then the old XData; an invalid value stays Unknown.
6. **Must NOT change:** no write on a pick (the Inspector refresh runs close to REDO); pipes with the old XData; the other Inspector rows.
7. **Settings switch:** none.
8. **Unit test:** `InspectorPipeTypeResolverTests`: note Stormwater and no XData gives Stormwater; XData only gives the XData type; neither gives Unknown; an out-of-range value gives Unknown.
9. **Real-AutoCAD check:** FX-08: `CD` a new 100 UPVC stormwater pipe between two pits; click it; the driver reads the Inspector's Type row by its accessible text. **Assert:** "Stormwater". Then `U` and `REDO`: REDO works, and the pick left DBMOD unchanged.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-09 · BUG-799 · The Pit Schedule says "SOURCE MISSING" for an Xref that is only unloaded

1. **Size and severity:** S. MEDIUM. Pit Schedule on any job with a Civil Xref as a source.
2. **Plain symptom:** with a Civil Xref attached by a relative path and then unloaded, PITSCHEDULE says "SOURCE MISSING: the linked source could not be found" instead of telling the drafter to load it.
3. **Expected:** "SOURCE UNLOADED: Load <name> to check the linked schedule." A file that is really gone still says missing.
4. **Where to look:** `Modules/Drainage/Services/PitScheduleXrefDiscoveryService.cs`, `ReadSourcePath` (about 265 to 295): an unloaded Xref falls back to `BlockTableRecord.PathName`, often relative (".\name.dwg"). `Services/PitScheduleStatusService.cs` (about 95 to 115) compares it with the stored full path through `SameDisplayPath`: no match, so it lands in "missing" before the Unloaded check at about 121. Two unloaded nested Xrefs grouping into one row: `PitScheduleXrefDiscoveryCore.cs` about 172.
5. **Smallest safe fix:** resolve a relative `PathName` against the HOST drawing's folder (`Path.GetDirectoryName(hostDb.Filename)`), never the process's current folder, before comparing. Group unloaded nested Xrefs by block name plus resolved path.
6. **Must NOT change:** the identity rule (a path never qualifies rows); the Conflict and Changed states.
7. **Settings switch:** none.
8. **Unit test:** `PitScheduleStatusServiceTests.Evaluate_UnloadedRelativeXref_IsUnloaded`: stored `C:\JobX\src.dwg`, fresh unloaded `.\src.dwg`, host folder `C:\JobX`: Unloaded. A file that does not exist: Missing.
9. **Real-AutoCAD check:** FX-09: host and source DWG in the same test folder, the source attached relative. Steps: PITSCHEDULE, link and place the schedule; `-XREF _Unload <name>`; PITSCHEDULE. **Assert:** the header reads "SOURCE UNLOADED" with the load sentence. Then `-XREF _Reload <name>`; PITSCHEDULE shows the linked status again.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-10 · BUG-707 · CDSURVEY can store the old levels under the new survey file's fingerprint

1. **Size and severity:** M. MEDIUM (plausible by reading). CDSURVEY on every job with a survey.
2. **Plain symptom:** the surveyor's Rev B file replaces Rev A on disk, but the drawing still shows the loaded Rev A. CDSURVEY reads the levels from the loaded Rev A and fingerprints the Rev B file on disk, so later staleness checks say the levels are current.
3. **Expected:** when the loaded Xref and the file on disk differ, the revision is stored as Unknown with a plain line to reload, never with the new fingerprint.
4. **Where to look:** `Modules/Drainage/Commands/CdSurveyCommand.cs`: levels from `SurveyService.ReadSurveyFromXref(pick.ObjectId, db)` (about line 87, the loaded copy); sources from `DescribeSources(db, pick.ObjectId, xrefPath, rawPath)`. `Services/SurveyIntakeCaptureService.cs` about 46 to 52 hashes the file on disk; `Services/SurveyIntakeStalenessService.cs` about 52 compares hashes later.
5. **Smallest safe fix:** in `DescribeSources`, compare the loaded Xref database's last-save stamp with the disk file's (read the disk header through a side database, read-only). If they differ, leave `Sha256` empty and add a finding: "The survey XREF file changed on disk after it was loaded. Reload it and run CDSURVEY again." Warn and carry on (R-27): the drafter may still store, with the revision Unknown.
6. **Must NOT change:** zero writes during the review; the raw DWG step; the transform step.
7. **Settings switch:** none.
8. **Unit test:** `SurveyIntakeCaptureServiceTests.BuildSnapshot_LoadedDiffersFromDisk_FingerprintUnknown`.
9. **Real-AutoCAD check:** FX-10: a host with survey Xref RevA.dwg (spot level texts); the case script copies RevB.dwg (one level changed) over the Xref file on disk without reloading. Steps: `CDSURVEY`, pick the Xref, Continue. **Assert:** the review lines carry the changed-on-disk finding and the stored source reads "fingerprint Unknown". Then `-XREF _Reload <name>`, CDSURVEY again: the fingerprint is known and the Rev B level appears.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-11 · BUG-570 · The Edit Pit preview keeps showing the old pit number and cover level

1. **Size and severity:** S. MEDIUM. Daily tool: Edit Pit. A window, so Codex builds it.
2. **Plain symptom:** in Edit Pit, change P13 to P77 (or the cover 21.00 to 21.10): the header and footer change, but the large plan preview still draws P13 and CL 21.00, and an existing pit is captioned "Pit — not yet saved" (Codex, 14 Oct, real AutoCAD, screenshot-backed).
3. **Expected:** the preview shows the typed number and cover before Save; an existing pit's caption says it is saved with changes waiting.
4. **Where to look:** `Modules/Drainage/Controls/PitBlockPreviewControl.cs`, `OnInputsChanged` (about 166 to 190): size and rotation redraw at once; every other value (label, cover) refreshes only through the dry-run path when `DryRunPreview != null`, and the dry run is withdrawn (DRYRUN-01), so nothing redraws. Renderer: `Controls/PitPlanPreviewRenderer.cs`.
5. **Smallest safe fix:** when there is no dry run, redraw the label and cover-text overlay from the view model's typed values (no drawing access). Change the caption for an existing pit to plain words.
6. **Must NOT change:** Save; the pit keeping its identity when renumbered; the dry-run withdrawal; no drawing write while the window is open.
7. **Settings switch:** none.
8. **Unit test:** an STA WPF test that changing the number on the view model changes the overlay label to P77 in one render pass; a caption test.
9. **Real-AutoCAD check (Codex look):** FX-11: a detached grated pit P13, 900 x 450, CL 21.000. Steps: click the pit body, Pit tab, Edit Pit; type P77; wait 1 s; screenshot; set the cover to 21.10; screenshot; Cancel. **Assert:** the screenshots show P77 and CL 21.10 in the preview; after Cancel DBMOD is unchanged and the plan still shows P13.
10. **Builder and review:** Codex gpt-6.1-sol (windows are Codex's); Opus review of the diff.

---

## FB-12 · BUG-225 · The Close button on the Pit ribbon tab does nothing

1. **Size and severity:** S. LOW-MEDIUM. Daily: the contextual tab (UX-RIBBON-01 is in the test pack's 30).
2. **Plain symptom:** click a pit, the Pit tab appears, click Close: the command line runs CDCLOSETAB but the pit stays selected and the tab stays open, twice (Codex sweep C1, 30 Sep, Civil 3.0.15). Typing CDCLOSETAB works.
3. **Expected:** Close clears the selection and the tab goes, as its tooltip says.
4. **Where to look:** `Modules/Drainage/Commands/RibbonContextCommands.cs`, `CloseContextualTab` (UsePickSet; `SetImpliedSelection(new ObjectId[0])`; `CeContextualTabController.HideAll()` only on non-net48 builds). The click is sent by `Shared/CE_SHARED/Services/RibbonBuilder.cs` (`BuildSendString` and `Execute`, about 676 to 712, through `SendStringToExecute`). The button: `Services/CeCvlRibbonContributor.cs:296`.
5. **Smallest safe fix:** reproduce on 3.0.70 first (the evidence is from 3.0.15; BUG-828 has changed the send string since). If it still fails: after CDCLOSETAB ends, clear the selection and hide the tab once more on the next Idle (a one-shot handler, no drawing access), in Civil code, not CE_SHARED. Make the net48 lane hide the tab too.
6. **Must NOT change:** typed CDCLOSETAB; every other button's send string; CE_SHARED.
7. **Settings switch:** none.
8. **Unit test:** the Idle one-shot is scheduled once and removes itself.
9. **Real-AutoCAD check:** FX-12: any drawing with a pit. Steps: the driver clicks the pit; clicks the Pit tab's "Close" by its accessible name; reads `(ssgetfirst)` and the ribbon's visible tabs. **Assert:** nothing selected, no Pit tab. Repeat twice. A Codex click with a screenshot completes the acceptance (a robot cannot prove the ribbon picture).
10. **Builder and review:** Sonnet; normal train review.

---

## FB-13 · BUG-771 · CDRG: Enter to finish a raingarden outline cancels the whole command

1. **Size and severity:** S. MEDIUM. CDRG (raingardens).
2. **Plain symptom:** pick four corners and press Enter or right-click to finish, the normal AutoCAD way: CE says "CDRG command cancelled" and draws nothing. Undo at the second point also cancels everything.
3. **Expected:** with 3 or more points, Enter closes the outline; with fewer, CE asks for more. Undo removes the last point only (as PLINE does); at the second point it says there is nothing to undo yet.
4. **Where to look:** `Modules/Drainage/Commands/SourceBlockInsertCommands.cs`: the CDRG loop (about 440 to 490) and `RaingardenPolylineJig.Sampler` (the class at about 895, Sampler about 915 to 934). Enter gives `PromptStatus.None`, the Sampler returns Cancel with no keyword, and the loop treats it as Esc. Undo with one point prints "cancelled".
5. **Smallest safe fix:** the Sampler records a `FinishRequested` flag when the status is None. In the loop: FinishRequested with 3 or more points closes; with fewer, print "[CE] Pick at least 3 points (N so far)." and carry on. Undo with one point prints "[CE] Nothing to undo yet. Pick the next point." and carries on. Esc still cancels.
6. **Must NOT change:** Esc cancelling; the Close keyword; the outline and its record; one U.
7. **Settings switch:** none.
8. **Unit test:** move the decision into a pure `RaingardenOutlineStep`: Enter with 4 points closes; Enter with 2 keeps asking; Undo at 1 keeps asking; Esc cancels.
9. **Real-AutoCAD check:** FX-13: an empty Civil drawing. Steps: `CDRG`, points 0,0 / 4000,0 / 4000,3000 / 0,3000, Enter, then accept the remaining prompts at their defaults. **Assert:** one closed raingarden outline drawn (closed polylines on the raingarden layer go up by 1); one U removes it. Second run: `CDRG`, 0,0, `U`: the prompt still asks for the next point; Esc prints "cancelled" and nothing is drawn.
10. **Builder and review:** Sonnet or Codex; normal train review.

---

## FB-14 · BUG-796 (report half) · Repair Center buttons report what they tried, not what they did

1. **Size and severity:** S. LOW-MEDIUM. Repair Center: CDREBUILDLINKS, CDLINKDANGLINGPIPES, CDPROPAGATE.
2. **Plain symptom:** CDLINKDANGLINGPIPES reports the candidate count even when a registration failed; CDREBUILDLINKS reports pits plus sources plus pipes as "registered" though that step does not register pipes; the CDPROPAGATE "Min grade" line uses the planned levels, not the ones kept.
3. **Expected:** every report counts what was really done and names what failed.
4. **Where to look:** `Modules/Drainage/Commands/HubCommands.cs` line 636 (CDREBUILDLINKS) and 669 (CDLINKDANGLINGPIPES); `Services/LinkService.RepairAudit.Relink.cs` about 225 and 278; `Services/LinkService.RepairAudit.InvertPropagation.cs` about 803.
5. **Smallest safe fix:** count successes from each step's result; report failures as "N could not be linked: see the CE log"; work out Min grade from the kept levels.
6. **Must NOT change:** what the commands write; the warning lines UX-REP-01 added. The missing Yes/No before these buttons write is NOT here: it changes the approved UX-REP-01 workflow (see Left out).
7. **Settings switch:** none.
8. **Unit test:** report builders with 3 candidates and 1 failure give "2 linked, 1 could not be linked".
9. **Real-AutoCAD check:** FX-14: three loose polylines on the stormwater pipe layer, one of them on a locked copy of that layer. Steps: `CDLINKDANGLINGPIPES`. **Assert:** the line says 2 linked and 1 not, naming the lock; CDCHECK lists 2 newly linked pipes.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-15 · BUG-855 · The Pit Schedule "data issues" count goes up by one after the first CDSYNC

1. **Size and severity:** S. LOW, but the robot reads this count as evidence.
2. **Plain symptom:** the header "Drawing check: 95 data issues may affect this schedule" reads 96 after one CDSYNC on an unchanged drawing; every row identical; a second CDSYNC changes nothing (robot run 35).
3. **Expected:** CDSYNC on an unchanged drawing leaves the count alone, or the new issue is one the drafter can see and act on.
4. **Where to look:** the header text in `Modules/Drainage/Services/PreFlightSummaryFormatter.cs` (about 30 to 38); the issue list from `Services/PitScheduleQaService.cs` and `PitScheduleQaAdapterService.cs`; CDSYNC in `Commands/LinkCommands.cs` 118 to 188 (`ClearPitPipeLinks`, `RegisterPipe(..., ObjectId.Null)` for every pipe with no recorded owner, then `SyncWithDrawing`).
5. **Smallest safe fix:** list the issues before and after on a headless probe (accoreconsole running the real CE code), name the new one, then fix its cause in CDSYNC (suspect: the pipe with a flagged open end at P8 losing a recorded end decision when it is registered again) or show it as a named row.
6. **Must NOT change:** CDSYNC keeping the schedule rows (BUG-698; robot PASS runs 41 to 46).
7. **Settings switch:** none.
8. **Unit test:** on whichever helper the probe names, with the open-end case.
9. **Real-AutoCAD check:** FX-15: the run 35 shape (a pit with a pipe whose far end is open and flagged). Steps: PITSCHEDULE, read the header count, Close; `CDSYNC`; PITSCHEDULE, read it again. **Assert:** the same count, or the extra issue appears as a named row.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-16 · BUG-719, BUG-720, BUG-723, BUG-724 · LandXML import: real files lose every pipe; control pits double; box pipes and pipe classes wrong

1. **Size and severity:** M. HIGH when used (a wrong engineering result on the drawing). CDIMPORTLANDXML.
2. **Plain symptom:** (719) a Civil 3D or 12d LandXML file imports pits only ("12 pits, 0 pipes"): CE reads `startRef` and `endRef`, while the LandXML 1.2 schema names them `refStart` and `refEnd`. (720) a control pit RectStruct 0.9 x 0.9 is drawn 1800 x 900. (723) a 1200 x 600 box pipe becomes "1200 RCP" marked as read from the file; egg and elliptical pipes fall to the 375 placeholder. (724) the file's class is overwritten: "uPVC SN10" becomes "UPVC SN8", "Stormpro sn16" becomes "STORMPRO SN12", "Fibre reinforced concrete" becomes "RCP".
3. **Expected:** every pipe read (a blank reference gives a "pipe not drawn" line); the control pit 900 x 900 (solid = width / 2, grated = width minus solid); the box size carried with the size marked Check, egg and elliptical Unknown (Unknown stays Unknown); the class in the file kept.
4. **Where to look:** `Modules/Drainage/Helpers/LandXmlParser.cs`: 322 to 326 (`startRef` / `endRef`); 246 to 250 plus `Services/XcivilPipeInsertionService.cs` 1110 to 1111 (control pit widths); 346 to 351 (`diamMm = Math.Max(w, h)` and the explicit flag); 466 to 484 (material; the case-sensitive test at 473).
5. **Smallest safe fix:** (719) read `refStart` / `refEnd` first and keep `startRef` / `endRef` as a second spelling (CE's own test files and the BUG-605 fixtures use it); check the spelling against one real export on the office drive before merge, and quote only the job number in any note. (720) split the widths as stated. (723) RectPipe: record width x height in the pipe note and mark the size Check, not "Read"; egg and elliptical: Unknown with a line. (724) keep the file's text; map only when the file gives no class.
6. **Must NOT change:** the review window; X-Civil import; the code path of `CODEX_HUNT_IMPORT_22OCT.md` finding 3 (the single-level shortcut giving an invert to the wrong pipe), which has its own brief; the BUG-605 named-invert behaviour.
7. **Settings switch:** none (each change makes the read more faithful to the file).
8. **Unit test:** `LandXmlParserTests` with new synthetic files: refStart / refEnd gives N pipes; RectStruct 0.9 gives 900 x 900; RectPipe 1.2 x 0.6 gives a Check size; "uPVC SN10" kept; the old startRef fixtures still pass.
9. **Real-AutoCAD check:** FX-16: a synthetic LandXML (2 pits, 1 pipe, refStart / refEnd, metres) in the test folder. Steps: `CDIMPORTLANDXML`, choose it, Read, Import. **Assert:** the review says 2 pits and 1 pipe; one CE pipe drawn between them; its material label matches the file.
10. **Builder and review:** Codex gpt-6.1-sol or Sonnet (pure parser work); normal train review. Same lane as FB-17, FB-16 first.

---

## FB-17 · BUG-725, BUG-728, BUG-729 · LandXML import: position scale, falling-pipe grade, unrounded cover levels

1. **Size and severity:** S (after FB-16). MEDIUM and LOW.
2. **Plain symptom:** (725) `linearUnit="millimeter"` with local co-ordinates is still multiplied by 1000; with no Units element, a pit at E = 95 is not scaled and one at E = 105 is, scattering the network. (728) a negative slope for a falling pipe drops the "1:100" grade from the label. (729) `elevRim` is copied as written ("45.2299999") onto the drawing.
3. **Expected:** one scale decision for the whole file, from the file's own unit; the grade shown whichever sign the export uses; cover levels to the Settings decimals.
4. **Where to look:** `Modules/Drainage/Helpers/LandXmlParser.cs`: 189 and 446 to 460 (scale); 371 to 373 (`slopeVal > 0.0`); 236 (`CleanNumericString(elevRimStr)`).
5. **Smallest safe fix:** read Units once and use one factor for the file; take `Math.Abs` of the slope (levels, not the sign, decide direction); round the cover level to `Inverts.CalculatedDecimals` the same way IL texts are written.
6. **Must NOT change:** the import units warning (BUG-505, release gate item 6, test cases C35 and C36); X-Civil import.
7. **Settings switch:** none.
8. **Unit test:** millimetre file; a file with no Units and E values 95 and 105 (same factor); slope -0.01 gives "1:100"; rim 45.2299999 gives "45.23".
9. **Real-AutoCAD check:** FX-17: a synthetic LandXML with `linearUnit="millimeter"`, imported into a mm drawing. **Assert:** both pits at the file's positions within 1 mm; the pipe label carries 1:100; the cover text reads CL 45.23.
10. **Builder and review:** same builder as FB-16.

---

## FB-18 · BUG-648 · AG drain grade is checked but never labelled on the drawing

1. **Size and severity:** M. MEDIUM. CDAGI. Approved as UX-SURF-04 (Tim, 27 Sep: "CE run, own style", with "grade check and label only").
2. **Plain symptom:** a 10 m AG run with levels 20.200 to 20.000: the preview reports 1:50 and stores it, but Accept draws only the polyline and its AG tag; no grade label (Codex, 15 Oct, real AutoCAD).
3. **Expected:** a grade label on the run, as approved.
4. **Where to look:** `Modules/Drainage/Commands/AgiCommand.Apply.cs`: `AppendTagLabel` (about 162 to 170) draws the AG tag and registers it to the drain; `plan.GradeCheckText` goes only into the command-line message (about 140). Text formatter to reuse: `Services/PipeAnnotationTextFormatter.cs`.
5. **Smallest safe fix:** when the grade is known, draw a grade label (DRAFT wording "AG DRAIN AT 1 IN 50"; same text style, layer and height as the AG tag; at mid-run), registered to the drain the way the tag is, so ERASE, OOPS, U and REDO treat them together. No label when the grade is Unknown, and the message says so.
6. **Must NOT change:** the AG linetype and tag; the perimeter drain PD tag (BUG-258); the grade check wording.
7. **Settings switch:** `agDrain.drawGradeLabel`, starting ON (the approved card says label, so the old behaviour is the bug). The wording is a recommended default Tim can change later.
8. **Unit test:** the label text builder: known 1:50 gives "AG DRAIN AT 1 IN 50"; Unknown gives no label.
9. **Real-AutoCAD check:** FX-18: a mm drawing, DIMSCALE 100. Steps: `CDAGI`, points 5000,5000 / 10000,5000 / 10000,0, finish open, start level 20.200, end level 20.000, Accept. **Assert:** one new text containing "1 IN 50" on the AG tag's layer; ERASE the run removes the label too; U brings both back.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-19 · BUG-760 · Long section: a level pipe with no grade label stops the whole long section

1. **Size and severity:** S. MEDIUM. CDPROFILE.
2. **Plain symptom:** a pipe with equal inverts and no "1 IN N" label (a flat detention storage pipe or a charged line) gets no grade, so the route stays Unknown ("pipe grade") and the section can never be drawn.
3. **Expected:** the section draws, with PIPE GRADE "LEVEL" and the speed and full-flow rows blank.
4. **Where to look:** `Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs`, `ComputeEstablishedGrade` (line 733) returns 0 for `startInvert <= endInvert` (the IJK-06 rising rule); the caller at about 610 to 628; readiness in `Services/ProfileRouteReviewService.cs` about 446 to 450; drawn rows in `Services/LongitudinalSectionService.cs` about 224 to 231.
5. **Smallest safe fix:** tell "equal" from "rising": equal inverts (to the Settings decimals) give a known LEVEL grade with velocity and flow left blank; rising stays as IJK-06 (Unknown with its reason).
6. **Must NOT change:** IJK-06 rising pipes; known grades; the datum and sump rule (IJK-04).
7. **Settings switch:** none. "LEVEL" is a DRAFT word Tim may change.
8. **Unit test:** `ComputeEstablishedGrade(20, 10.00, 10.00)` gives a level result; `Prepare` gives Ready; 10.00 to 10.20 is still Unknown.
9. **Real-AutoCAD check:** FX-19: P1 IL 10.00 to P2 IL 10.00, 20 m, no grade label. Steps: `CDPROFILE` P1 to P2, Review, Apply. **Assert:** the section is drawn; PIPE GRADE reads LEVEL; the speed row is blank.
10. **Builder and review:** Sonnet; normal train review. Same lane as FB-20 to FB-22.

---

## FB-20 · BUG-764 · Long section: boundary marks measured on a straight line, not along a bent pipe

1. **Size and severity:** M. MEDIUM.
2. **Plain symptom:** on a pipe with a bend, a boundary that crosses the real pipe can be missed, or a mark shown where the pipe never crosses. At the end pit the boundary distance is straight-line (1.0 m shown where it is about 1.41 m along a pipe leaving at 45°).
3. **Expected:** the boundary is intersected with the pipe's own centreline and measured along it.
4. **Where to look:** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs`: `ProjectBoundaryMarkers` (line 1301), `AddEndpointBoundaryProjection` (1343); boundary segments from `CollectBoundarySegments` (1181).
5. **Smallest safe fix:** move the projection into a pure helper that takes the pipe's own polyline points; intersect each boundary segment with each pipe segment; measure the distance along the pipe.
6. **Must NOT change:** marks on straight pipes (identical results); the boundary layer rule (`IsBoundaryLayer`, 1287).
7. **Settings switch:** none.
8. **Unit test:** an L-shaped pipe crossing a boundary on its second leg gives one mark at the right distance; a straight pipe gives today's answer.
9. **Real-AutoCAD check:** FX-20: a dog-leg pipe P1 at 0,0, bend at 10000,0, P2 at 10000,10000; a boundary line from 9000,5000 to 11000,5000 on the boundary layer. `CDPROFILE` P1 to P2. **Assert:** one boundary mark at chainage 15.0 m (within 0.05 m).
10. **Builder and review:** same lane as FB-19.

---

## FB-21 · BUG-765 · Long section: any bare number in an Xref can become a surface level

1. **Size and severity:** S. LOW-MEDIUM (engineering result risk).
2. **Plain symptom:** a survey Xref that writes pit or kerb inverts as bare numbers ("18.60" between covers of 19.20) is read as a natural-surface spot, and the existing-surface line dips 0.6 m.
3. **Expected:** only level texts on recognised survey layers, or the points CDSURVEY already understands, count.
4. **Where to look:** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs`: `SurveyLevelRegex` (line 45), `TryParseSurveyLevel` (1258), `TryEstimateSurveyLevel` (1573). The shared spot-level reader from the BUG-711, BUG-713 and BUG-714 fix (`Services/SpotLevelReader.cs`) is the one to reuse.
5. **Smallest safe fix:** take surface levels from the same reader CDSURVEY uses (survey layers, RL and spot blocks), not from any numeric text.
6. **Must NOT change:** CDSURVEY; spot-level blocks still count.
7. **Settings switch:** none.
8. **Unit test:** a bare "18.60" on a non-survey layer is ignored; "RL 19.20" on the survey layer is used.
9. **Real-AutoCAD check:** FX-21: a survey Xref with "RL 19.20" spot texts every 5 m and one bare "18.60" text on a non-survey layer beside the run. `CDPROFILE`. **Assert:** the existing-surface line has no vertex at 18.60 (read its vertices).
10. **Builder and review:** same lane as FB-19.

---

## FB-22 · BUG-766 · Long section through CDPROFILE never draws branch junction marks

1. **Size and severity:** S. LOW.
2. **Plain symptom:** a tick with "100 DIA. BRANCH" at 6.4 m never appears on a section made through CDPROFILE; it can appear only through CDCALC's older tab.
3. **Expected:** junction marks on the CDPROFILE section too.
4. **Where to look:** `Modules/Drainage/Services/LongitudinalSectionService.cs`: `TryProjectReviewedSection` (line 912) never fills `JunctionMarkers`; `AddJunctionMarkers` (1450) draws them when present. Junction facts: `LinkService.ReadBranchJunctionFacts` (the Inspector already uses it).
5. **Smallest safe fix:** fill `JunctionMarkers` in the reviewed projection from the same junction facts.
6. **Must NOT change:** the older CDCALC tab; the CD-BRANCH-01 branch-profile engine (branch `claude/b4-branch-profile`, not installed).
7. **Settings switch:** none.
8. **Unit test:** a pure test that a junction at 6.4 m on the route becomes one marker; a source guard that the reviewed path sets the markers.
9. **Real-AutoCAD check:** FX-22: main P1 to P2, 20 m, with a branch joined at 6400 (CD branch). `CDPROFILE` P1 to P2. **Assert:** a "BRANCH" text sits at chainage 6.4 m (within 0.05 m).
10. **Builder and review:** same lane as FB-19.

---

## FB-23 · BUG-811 (cascade half, LM-33) · Level cascade can leave a step where two branches rejoin

1. **Size and severity:** S. LOW (plausible by reading).
2. **Plain symptom:** in a network that splits and rejoins, the rejoining pit's outlet is worked out before the second incoming pipe is recalculated, so a step can be left at that pit.
3. **Expected:** a pit's outlet is worked out after all its incoming pipes.
4. **Where to look:** `Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs` about 302 to 353 (the order of recalculation).
5. **Smallest safe fix:** recalculate pits in flow order (every incoming pipe before the outlet), using the existing "lowest arriving level" rule from the BUG-652 to BUG-655 fix.
6. **Must NOT change:** the BUG-652 to BUG-657 fixes (pit drops kept; the preview list equals the relinked list; both level texts written together); the Edit Pipe cascade regression. The other half of BUG-811 (the AI vision import log) is left out: AI is off for colleagues.
7. **Settings switch:** none.
8. **Unit test:** a diamond network A to B, A to C, B to D, C to D; raising A gives D an outlet from the lower of the B and C arrivals.
9. **Real-AutoCAD check:** FX-23: the diamond network. Steps: Edit Pipe on A's outlet pipe, raise its upstream level, Yes to the cascade, Apply. **Assert:** D's outlet IL = the lower arrival minus the pit drop (read the IL texts); one U reverses everything.
10. **Builder and review:** Sonnet; Opus review (cascade, one U).

---

## FB-24 · BUG-810 · The audit commands write to the drawing, misread metre drawings, and can crash

1. **Size and severity:** S. LOW-MEDIUM. CDIMPORTAUDIT, CDAUDIT, CDLEGACYAUDIT.
2. **Plain symptom:** CDIMPORTAUDIT, run first in a drawing, can save CE's record into it (DBMOD, an Undo step) though an audit should only read. CDAUDIT pass C compares the line scale (drawing units) with the diameter (mm), so every pipe is flagged in a metre drawing; pass B measures from the pit insertion point against 500 mm, though pipes stop at the pit wall. CDLEGACYAUDIT crashes on a folder it cannot read and flags APPLOAD history as a "legacy start-up conflict".
3. **Expected:** audits only read; units and the pit wall respected; an unreadable folder is reported, not a crash.
4. **Where to look:** `Modules/Drainage/Commands/LinkCommands.cs` 711 (CDIMPORTAUDIT; the write at about 722), 374 (CDAUDIT), 315 (CDLEGACYAUDIT); `Services/LinkService.RepairAudit.AuditPasses.cs` pass C (about 163) and pass B (about 102 to 123); `Services/LegacyEnvironmentAuditService.cs` (the folder scan).
5. **Smallest safe fix:** read with `ProjectDataService.TryReadProjectWithoutChanging`; convert with the existing drawing-units helper; measure pass B from the pit outline (the existing outline helper in `LinkService.PitOutline.cs`); catch "access denied" per folder and report it; stop flagging APPLOAD history.
6. **Must NOT change:** audit findings on mm drawings.
7. **Settings switch:** none.
8. **Unit test:** pass C on a metre drawing raises no false flag; the scanner with an unreadable folder reports one line and does not throw.
9. **Real-AutoCAD check:** FX-24: a metre drawing (INSUNITS 6) with three correct pipes. Steps: `_.QSAVE`; `CDIMPORTAUDIT`; read DBMOD; `CDAUDIT`. **Assert:** DBMOD 0 and no pass C flags.
10. **Builder and review:** Sonnet; normal train review.

---

## FB-25 · BUG-812 · Redesign Apply puts new pits at the bottom of the schedule; a copied pump pit is dropped without a word

1. **Size and severity:** S. LOW.
2. **Plain symptom:** new pits from a CDDESIGN redesign Apply sort to the bottom (P2A after P10). A copied CE_PUMP_PIT block with the same LABEL is skipped, and any read failure returns a partial pump-pit list with only a log line.
3. **Expected:** new pits take their natural place; a skipped or failed pump pit is reported on screen.
4. **Where to look:** `Modules/Drainage/Services/NetworkRedesignScheduleReviewService.cs` about 886 to 905 (the append); `Services/PumpPitScheduleReader.cs` about 212 to 213.
5. **Smallest safe fix:** insert new rows by the schedule's natural mark order (the comparator UX-SCHED-06 uses, `Services/PitScheduleRowOrder.cs`); report a skipped duplicate pump pit, and any read failure, on the command line.
6. **Must NOT change:** a manual row order the drafter set; redesign approvals.
7. **Settings switch:** none.
8. **Unit test:** P1, P2, P10 plus new P2A gives P1, P2, P2A, P10; two CE_PUMP_PIT blocks with LABEL SPS1 give one row and one screen line.
9. **Real-AutoCAD check:** FX-25: a CDDESIGN redesign that adds pit P2A. Steps: Apply; PITSCHEDULE. **Assert:** P2A sits between P2 and P3.
10. **Builder and review:** Sonnet; normal train review.

---

## Left out and why (221 of the 252)

1. **Already fixed in the installed Civil 3.0.70 (50).** Named in commits by hunt label or as a group, so the recount missed them; the desk should add status lines and send them to the Codex acceptance queue, not to builders. BUG-458, 461, 462, 463, 464 (HUNT-C-01, C-04 to C-07); 459, 460 (fix #1090, Codex W59b PASS); 477, 479, 480, 482, 488, 489 (HUNT-M-02, M-04/05, M-07, the fault-report and support-zip fixes); 490 (privacy finding 5, `DrawingPersonName`, coded by default); 506, 507, 508, 510 (HUNT2-C-02 to C-04 and C-06; 508 sits behind a switch that starts OFF; 507's window part is #1257); 756, 757, 759, 761, 762, 763, 774, 776, 778 (IJK-01, 02, 04, 06, 07, 08, 23, 26, X2); 414 (BUG-408b rename refusal); 386 ("Stop overriding", #641); 651 (Esc at "Proceed with import?" now declines, `XcivilImportService.PreflightAnswerDeclines`); 400 (W8-09, no "_Dot" line); 248 (BUG-258); 593, 596, 598 (#1259 and the fixes after it); 602, 604 (Fix BUG-605/604/602); 637 (Civil half); 655 (Fix BUG-652..655); 666, 671, 672, 678, 689, 696 (Civil E group fixes); 713, 714 (spot-level reader); 732, 741 (X-Civil Replace, CDFIXTAGS); 797 (Fix BUG-782/797).
2. **Built on a branch, not installed (3).** BUG-525 (the other blues: `codex/noblue-civil`, `-manager`, `-shared`); BUG-540 (step-iron depth from Settings: `claude/b4-r00-step-iron-depth`); BUG-866, CDCHECKIGNORE Undo (Codex `cx/ignore-undo-c60`).
3. **Structural only, not shipped to colleagues on 9 Nov (61).** BUG-049, 050, 051, 096, 202, 300, 304, 349, 383, 399, 409, 410, 411 (F2 runs Structural's CLEAN), 448, 449, 451, 466, 467, 469, 470, 472 to 475, 493, 494, 495, 526, 529, 533, 535, 536, 537, 553, 564, 567, 568, 569, 578, 579, 608, 610, 611, 613, 615, 616, 623, 625, 626, 627, 630, 631, 634, 636, 638, 640, 644, 645, 749, 818, 819.
4. **Need Tim's engineering or design word, a command card, or parked (26).** BUG-003 (orifice detail drawing: a feature); 054 (REFEDIT, parked pending diagnosis); 056 (Tim handling); 063, 068 (X-Civil import design); 095, 307 (Glen Eira back-test: gap plan item 1a-11 has it); 213 (re-placing an older schedule needs a workflow card); 222 (Manager Settings layout: the Settings page re-cut is in flight); 245 (pit-to-open-end ruling); 249 (Boyd's rainfall rows); 283 (X-Civil import unlocking layers: Tim's command review); 311 (palette edits during CDRUNSOLVE); 337, 338 (metre drawings: Tim's BUG-287 question); 419, 538, 539 (council and engineering values in code); 431 (Kingston edition check); 483 (publishing); 492 (time logs named by login: Tim's call); 554 (installer, cut for 9 Nov); 587 (drawn Pit Schedule remarks crossing the row lines: the table writer was not found by reading and the fit needs a Codex look; worth a brief once located); 641 (catchment halves: a visual design choice); 685 (CD rounding: needs Tim's ruling); 857 (Grade mismatch box: Tim's question). Also kept out of the chosen briefs: BUG-796's Yes/No (changes approved UX-REP-01) and BUG-793 part (a) (narrowing Tim's automatic migration).
5. **Covered by another brief or audit, latent, or AI only (7).** BUG-861 (REDO after a pick: `AUDIT_C58` finding 4 and the `CODEX_AUDIT_CIVIL` protocol); 865 (with BUG-859 round 2); 802 (`CODEX_AUDIT_CIVIL` finding 2); 816 (labels hunt, and on Max's known-problems page); 775 and 806 (no caller yet); 804 (AI vision, switched off for colleagues).
6. **Test tools, environment, or evidence records, not product faults (24).** BUG-097, 240, 295, 326, 345, 354, 361, 371, 374, 390, 391, 392, 395, 402, 404, 412, 421, 441, 444, 445, 455, 456, 562 (start-up text from stale menus in Tim's own profile; the test pack's fresh-profile start-up case C03 covers colleagues), 639.
7. **Old (May to early October), no evidence on a V3 build: re-test before any brief (43).** BUG-002, 005 to 008, 014 to 017, 020 to 026, 028 to 038, 041, 042, 052, 061, 066, 083, 206 (OSMODE: BUG-380's snap guard since), 229 (the settings list-append cause is fixed; old files may keep duplicates), 235 (the copy rebuild has changed this path), 310, 319, 320, 340, 343, 415, 436.
8. **Low value, working as designed, cause unknown, or maybe unreachable (7).** BUG-658 (the false "Updated N pipes" line needs an Edit Pipe save refused after the cascade question, and the HUNT-C-02/03 lock checks now refuse before it; re-check before a brief); BUG-821 (CDTAG hands over only a single selected CE source, by design); 822 (no "What's New" palette exists in Civil or Manager; most likely Structural's); 528 (shared helper DLL versions, LOW); 397 (Manager load list, superseded by the CEHEALTH work); 581 (the Move and rotate guide starts Structural's MR, and the fix would be in CE_SHARED help); 595 (AutoCAD wedged after a nested CDCALC window; a fresh session works; the test harness is the suspect).

**Check on the count:** 31 chosen + 50 + 3 + 61 + 26 + 7 + 24 + 43 + 7 = 252.

---

## What I did not do

1. Nothing was built, run, installed or opened in AutoCAD; every symptom above is from the carpark and from reading code at `40ee0a36`.
2. Line numbers are "about": they were read at `40ee0a36` and will move as lanes merge.
3. The 50 "already fixed" are fixed in code by commit name and, for a sample, by reading the code. None is accepted: each still needs its robot and Codex check.
4. I did not edit `BUG_CARPARK.md` (read-only brief). The desk should add status lines for the 50, and settle the doubled BUG-866 heading.

## Summary

All 252 "open, no fix" bugs were screened. 50 are already fixed in the installed Civil 3.0.70 (named by hunt label, so the recount missed them) and 3 more are built on branches, so about 199 are truly open. 53 matter for the 9 Nov Civil + Manager pilot; 31 of them are in 25 ready-to-run briefs (18 small, 7 medium), led by callouts landing wrong after MOVE or ROTATE, pit-on-pipe splits losing junctions, and drawings that ask "Save changes?" untouched. Each brief names the code at `40ee0a36`, the smallest fix, what must not change, the switch rule, a unit test and a robot check. No Manager bug made the list.
