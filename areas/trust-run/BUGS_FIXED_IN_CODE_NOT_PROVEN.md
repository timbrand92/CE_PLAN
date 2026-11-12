# Bugs the installed code already appears to fix, none yet seen working in AutoCAD

**Written Fri 13 Nov 2026, from the 47 core tool notes (Civil 3.0.90, commit cf059dcf). Nothing here was run in AutoCAD. No status in `C:\CE_PLAN\BUG_CARPARK.md` was changed.**

---

# FOR TIM

**1. How many.** 149 different bugs. Because a few show up under more than one tool, the lists below hold 159 lines across 32 of the 47 tools. The other 15 tools have none: CDPITCOVERFLIP, IO, FO, GIO, CDSOURCE, CDANNOTATIONEDIT, CDMA, CDSL, MR, CDCHECKCURRENT, CDFEEDBACK, CDRAINFALL, CDDEST, CDRULEBOOK, CDSYSTEM.

**2. The rule.** NONE of these may be marked fixed until it is seen working in AutoCAD. The notes read the code, not the drawing. "A change is in the code" is not proof. Every one stays OPEN (or IN PROGRESS where the carpark already says so) until the robot and Codex have seen it pass in real AutoCAD.

**3. The ten that matter most to a drafter.** Picked because each one puts a wrong number on a drawing, loses typed work, or stops the job.
1. **BUG-683, CD:** the downstream level was worked over the drawn length, not the real length you typed. A broken pipe could carry a wrong level on the plan. (HIGH, engineering result.)
2. **BUG-681, CD:** answer Yes to the uphill box and the schedule row could read the opposite way round to the plan. (HIGH, engineering result.)
3. **BUG-290, CDAGI, CDSTRIP, CDRUNSOLVE:** a hidden record refresh ran before the first question and overwrote levels you had typed. No and Esc could not put them back.
4. **BUG-968, CDRENUMBER:** two pipes running opposite ways between the same two pits could close AutoCAD before the list appeared. You lose unsaved work.
5. **BUG-650, CDFW:** pressing Esc in the floor waste command wiped the stored pit inverts, with nothing placed. This is the open fault marked "fix before it goes in" in the ribbon sort.
6. **BUG-674, CDEDIT:** resize two pits together and the pipe ends stayed inside the old pit wall, with stale lengths and labels. (HIGH, engineering result.)
7. **BUG-780, PITSCHEDULE:** when two inlets merged into "DPs", the wrong pipe size and level landed on the next inlet row. The table goes to council.
8. **BUG-785, PITSCHEDULE:** the depth printed in a placed schedule changed after the next edit to the pit, because the after-edit refresh used a different rule from the window.
9. **BUG-756, CDPROFILE:** every pipe just before a size increase was drawn one size too tall on the long section, so cover looked smaller than it was.
10. **BUG-969, CDNEWDWG:** a new sheet made in a different job folder carried the old job's number, client and address in the title block.

**4. What to watch for in the lists.**
1. **Switched off:** BUG-777 (CDTWL) has its fix but the switch is off as installed, so it cannot show until the switch is turned on.
2. **Failed once already:** BUG-859 (DP) was seen still failing in real AutoCAD on 22 Oct. The second fix is not installed.
3. **A pass is already on record, not Tim-accepted:** BUG-791 and BUG-742 have a Codex or robot pass in their carpark entry. They are still OPEN until the ledger accepts them by name.
4. **Fixed in another part of the code:** BUG-490, 783, 785 and 812 are listed under CDDESIGN because the note says so, but the fix sits in the redesign sign-off and the Pit Schedule.
5. **Not included here:** the "partly fixed" items. They are in each tool note.

**5. How each line reads.** The "fix is at" file and line come from the tool note's "Where this comes from" list, under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\` unless a path says otherwise. The "what must be seen" line is taken from the carpark entry's own steps where it has them (BUG-1229, 1238, 1246 and 1255 do). For all the others the entry gives only the expected result, so the line is that expected result written as a quick test.

---

# BY TOOL, IN RIBBON ORDER

## PIT: Place a pit (7)

1. **BUG-458, PIT, PP, CD and the schedule ran during REFEDIT.**
   - **Fix is at:** `DrawingSafetyService.cs:78-90`.
   - **What must be seen in AutoCAD to prove it:** Open an Xref with REFEDIT then run PIT, PP and PITSCHEDULE: each refuses and changes nothing.

2. **BUG-690, Pipe split under a new pit left links and junctions on the first half.**
   - **Fix is at:** `LinkService.Split.cs:1555-1573`, `1624-1626`, `1653-1665`.
   - **What must be seen in AutoCAD to prove it:** Split a pipe under a new pit: the junction past the split stays in the Pit Schedule and the links sit on the right half.

3. **BUG-691, Split of a pipe broken across plans worked the level over one half.**
   - **Fix is at:** `LinkService.Split.cs:1555-1573`, `1624-1626`, `1653-1665`.
   - **What must be seen in AutoCAD to prove it:** A pipe broken across plans (6 m + 4 m) with a pit placed on it is refused with one plain line, not given a wrong split level.

4. **BUG-692, Callout went to the wrong half of a split pipe.**
   - **Fix is at:** `LinkService.Split.cs:1555-1573`, `1624-1626`, `1653-1665`.
   - **What must be seen in AutoCAD to prove it:** Split a pipe with the arrow on one side of the new pit and the text pulled across: the callout follows its arrow.

5. **BUG-693, Both halves of a split arc pipe got the wrong curves.**
   - **Fix is at:** `LinkService.Split.cs:1555-1573`, `1624-1626`, `1653-1665`.
   - **What must be seen in AutoCAD to prove it:** Place a pit on an arc pipe: the arc pipe is left whole with a line saying so.

6. **BUG-1165, Old all-users folder supplied the pit blocks first.**
   - **Fix is at:** `Services\BlockService.cs:124-128`, `PitMigrationSettings.cs:13`.
   - **What must be seen in AutoCAD to prove it:** Pit blocks come from the running bundle, not an old all-users copy.

7. **BUG-035, Pit turned by itself after CD in a rotated UCS.** (carpark says IN PROGRESS)
   - **Fix is at:** `PitCommand.cs:405-426`.
   - **What must be seen in AutoCAD to prove it:** Rotate the UCS, run CD, then PIT: the pit comes in at the rotation you asked for.

## PP: Quick plastic pit (5)

1. **BUG-458, PIT, PP, CD and the schedule ran during REFEDIT.**
   - **Fix is at:** `Services\DrawingSafetyService.cs:78-90` (as in the PIT note).
   - **What must be seen in AutoCAD to prove it:** Open an Xref with REFEDIT then run PIT, PP and PITSCHEDULE: each refuses and changes nothing.

2. **BUG-690, Pipe split under a new pit left links and junctions on the first half.**
   - **Fix is at:** `Services\LinkService.Split.cs:1555-1573, 1624-1626, 1653-1665` (as in the PIT note).
   - **What must be seen in AutoCAD to prove it:** Split a pipe under a new pit: the junction past the split stays in the Pit Schedule and the links sit on the right half.

3. **BUG-691, Split of a pipe broken across plans worked the level over one half.**
   - **Fix is at:** `Services\LinkService.Split.cs:1555-1573, 1624-1626, 1653-1665` (as in the PIT note).
   - **What must be seen in AutoCAD to prove it:** A pipe broken across plans (6 m + 4 m) with a pit placed on it is refused with one plain line, not given a wrong split level.

4. **BUG-692, Callout went to the wrong half of a split pipe.**
   - **Fix is at:** `Services\LinkService.Split.cs:1555-1573, 1624-1626, 1653-1665` (as in the PIT note).
   - **What must be seen in AutoCAD to prove it:** Split a pipe with the arrow on one side of the new pit and the text pulled across: the callout follows its arrow.

5. **BUG-693, Both halves of a split arc pipe got the wrong curves.**
   - **Fix is at:** `Services\LinkService.Split.cs:1555-1573, 1624-1626, 1653-1665` (as in the PIT note).
   - **What must be seen in AutoCAD to prove it:** Place a pit on an arc pipe: the arc pipe is left whole with a line saying so.

## CDLPD: Legal point of discharge (1)

1. **BUG-1153, Redesign skipped fixed-outlet protection on an unreadable record.** (this is a CDDESIGN fault, not CDLPD)
   - **Fix is at:** `NetworkRedesignCurrentDrawingReader.cs:878-893`, `Services\NetworkRedesignApplyTicketService.cs:894-905`, `UserSettings.cs:805, 813`.
   - **What must be seen in AutoCAD to prove it:** Make the LPD record incomplete: Redesign Apply shows the warning that it cannot be read.

## CDEDIT: Edit pit or pipe (11)

1. **BUG-1043, Blank invert blocked New Pipe and Edit Pipe saving.**
   - **Fix is at:** `Models\UserSettings.cs:1633-1639`, `Rules\PipeStartReadiness.cs:195-208`.
   - **What must be seen in AutoCAD to prove it:** Leave one invert blank: Start Pipe and Save work with a warning, and the blank stays Unknown.

2. **BUG-1049, One blank ticked field stopped the whole batch Apply.**
   - **Fix is at:** `UserSettings.cs:626-629`, `ViewModels\Shell\CeBatchEditViewModel.cs:288-300`.
   - **What must be seen in AutoCAD to prove it:** Tick Diameter 375 and a blank Material: Apply works, materials stay, one U restores.

3. **BUG-070, Suggestion strips showed 3 decimals not 2.** (carpark says IN PROGRESS)
   - **Fix is at:** `ViewModels\CdViewModel.GradeSuggestion.cs:486, 540-544`.
   - **What must be seen in AutoCAD to prove it:** The CDEDIT and pit suggestion strips show levels to 2 decimals (18.50).

4. **BUG-072, Pit label jumped to the wrong place on resize.** (carpark says IN PROGRESS)
   - **Fix is at:** `Helpers\PitAnnotationShift.cs`, `PitEditCommand.cs:1693`.
   - **What must be seen in AutoCAD to prove it:** Make a pit bigger then smaller: the P label keeps its side and gap and never crosses the circle.

5. **BUG-078, CDEDIT Above/Below invert text choice did nothing.** (carpark says IN PROGRESS)
   - **Fix is at:** `PipeEditCommand.Attachments.cs:418-520`.
   - **What must be seen in AutoCAD to prove it:** Toggle Above/Below in CDEDIT: the invert text moves to that side and stays.

6. **BUG-094, CDEDIT opened differently on a pipe's MLINE and polyline.** (carpark says IN PROGRESS)
   - **Fix is at:** `HubCommands.cs:110, 141, 199`.
   - **What must be seen in AutoCAD to prove it:** Pick the pipe's MLINE, then its polyline: the same pipe editor opens for the same pipe.

7. **BUG-186, CDEDIT batch Apply refused with Carry downstream.** (carpark says IN PROGRESS)
   - **Fix is at:** `PipeEditCommand.Batch.cs:849-862`.
   - **What must be seen in AutoCAD to prove it:** Select three pipes at 1 in 100 with Carry downstream: Apply writes all three as previewed and one U puts them back.

8. **BUG-223, CDEDIT flow direction ignored the levels at two open ends.**
   - **Fix is at:** `PipeEditCommand.Update.cs:1779-1800`.
   - **What must be seen in AutoCAD to prove it:** CDEDIT a pipe between two open ends and type levels the other way round: direction follows the levels, or a plain warning appears.

9. **BUG-291, Pipe drawn from its downstream end turned round.**
   - **Fix is at:** `PipeEditCommand.Update.cs:239-250`.
   - **What must be seen in AutoCAD to prove it:** Draw a pipe starting at its downstream end with Design grade: the recorded upstream end stays upstream.

10. **BUG-674, Multi-pit resize left pipe ends inside the pit wall.**
   - **Fix is at:** `PitEditCommand.Batch.cs:681-731`.
   - **What must be seen in AutoCAD to prove it:** Select two 450 pits, set 900 x 900, Apply: each pipe end sits on the new pit wall and the labels update.

11. **BUG-071, Grade and rising-main pop-ups clipped long messages.** (carpark says IN PROGRESS; the two pop-ups belong to CD)
   - **Fix is at:** `Dialogs\GradeMismatchDialog.xaml:6`, `Dialogs\ContinueRisingMainDialog.xaml:6`.
   - **What must be seen in AutoCAD to prove it:** A long grade-mismatch or rising-main message shows in full with nothing cut off.

## CDRENUMBER: Renumber pits (2)

1. **BUG-968, CDRENUMBER could close AutoCAD on a pipe loop.**
   - **Fix is at:** `PitRenumberCommand.cs:71-79`, `PitRenumberPlanner.cs:98-110`, `205-242`.
   - **What must be seen in AutoCAD to prove it:** On a drawing with two pipes running opposite ways between two pits: a plain message names the loop and AutoCAD stays open.

2. **BUG-1005, CDRENUMBER numbered a short side run before the main run.**
   - **Fix is at:** `PitRenumberPlanner.cs:150-152`, `UserSettings.cs:1264`.
   - **What must be seen in AutoCAD to prove it:** A 20 m side run into the same pit as a 100 m run: the longer run keeps the main-line numbers.

## DP: Downpipe (2)

1. **BUG-859, Double-click on a downpipe opened AutoCAD's attribute editor.** (Codex saw it still fail in real AutoCAD on 22 Oct; a second fix is not installed)
   - **Fix is at:** `Services\CompoundEditModeService.cs:425-443`, `978-1070`, `Models\DoubleClickSettings.cs:35, 52, 80`.
   - **What must be seen in AutoCAD to prove it:** Double-click anywhere on DP1: CE's Edit window opens showing DP1.

2. **BUG-860, Double-click on a downpipe label opened plain text edit.**
   - **Fix is at:** `Services\CompoundEditModeService.cs:425-443`, `978-1070`, `Models\DoubleClickSettings.cs:35, 52, 80`.
   - **What must be seen in AutoCAD to prove it:** Double-click the label: CE's Edit source opens when the block's own record names that text.

## OF: Overflow (1)

1. **BUG-1145, Xref schedule said OUT OF DATE when nothing on it changed.** (not OF's own code)
   - **Fix is at:** `Models\UserSettings.cs:701-706`, `Services\ProjectDataFingerprintService.cs:45-91`, `Services\PitScheduleStatusService.cs:196`.
   - **What must be seen in AutoCAD to prove it:** Ignore a finding: the schedule does not turn OUT OF DATE (schedules placed after this change).

## CDFW: Floor waste (2)

1. **BUG-650, Cancelling CDFW wiped stored pit inverts.**
   - **Fix is at:** `FloorWasteCommand.cs:41-45`, `Services\ProjectDataService.Mutations.cs:244-289`; `Services\ProjectDataService.cs:984-998`.
   - **What must be seen in AutoCAD to prove it:** Run CDFW on a drawing with pit inverts, press Esc: the stored pit inverts are unchanged.

2. **BUG-1223, Pick on an inspection opening said the record changed.**
   - **Fix is at:** `LinkService.SourceLanding.cs:443-450, 501-509`, `Rules\SourcePickPipeRecordRule.cs:26-31`, `Models\UserSettings.cs:774-775`.
   - **What must be seen in AutoCAD to prove it:** CDFW on an inspection opening places the floor waste, or gives one plain reason, never "changed while you picked".

## CDTG: Trench grate (1)

1. **BUG-743, Cover level reused from another drawing at Enter.**
   - **Fix is at:** the note gives `Rules\TrenchGrateCoverMemory.cs:16-32` for the remembered cover level, but no line for the fix itself.
   - **What must be seen in AutoCAD to prove it:** Type a cover level in job A, open job B, press Enter at the prompt: it means Unknown, not job A's level; Blank is offered.

## CDRG: Raingarden (1)

1. **BUG-771, Enter at the end of the outline cancelled CDRG.**
   - **Fix is at:** `SourceBlockInsertCommands.cs:438-518`, `923-934`, `Commands\RaingardenOutlineStep.cs:27-40`.
   - **What must be seen in AutoCAD to prove it:** Pick four corners and press Enter: the outline closes and the raingarden is drawn; Undo removes one point.

## CDWT: Water tank (1)

1. **BUG-020, Tank riser and dropper were tagged DP.** (carpark says IN PROGRESS)
   - **Fix is at:** `WaterTankCommand.Apply.cs:134, 141, 281-290`.
   - **What must be seen in AutoCAD to prove it:** After CDWT, the riser tags R and the dropper D with attributes filled, and the next downpipe is still DP1.

## CDTAG: Tag or retag a source (2)

1. **BUG-742, CDTAG did not check the name was free on an untagged block.** (a robot/Codex observation PASS is recorded in the entry)
   - **Fix is at:** `Models\UserSettings.cs:1128`.
   - **What must be seen in AutoCAD to prove it:** Tag a second block DP3 when DP3 exists: it is refused in plain words.

2. **BUG-814, Retag refusal printed "stopped before its tag transaction".**
   - **Fix is at:** `SourceTagCommand.cs:173-174, 196`, `UserSettings.cs:1027`.
   - **What must be seen in AutoCAD to prove it:** Retag to a name already in use: plain words name the tag.

## CD: Draw a pipe (35)

1. **BUG-331, Pipes 1 m or shorter refused in metre drawings.**
   - **Fix is at:** `CdCommand.cs:1296-1317`.
   - **What must be seen in AutoCAD to prove it:** In a metre drawing draw a 0.5 m pipe with CD: it is accepted.

2. **BUG-1043, Blank invert blocked New Pipe and Edit Pipe saving.**
   - **Fix is at:** `UserSettings.cs:1633-1639`, `PipeStartReadiness.cs:195-208`.
   - **What must be seen in AutoCAD to prove it:** Leave one invert blank: Start Pipe and Save work with a warning, and the blank stays Unknown.

3. **BUG-1226, Recent levels row missing from the one-page New Pipe window.**
   - **Fix is at:** `PipeOnePageLayout.cs:82-85`, `UserSettings.cs:1736, 1747`.
   - **What must be seen in AutoCAD to prove it:** Place two pipes then run CD again: a Recent row offers recent sizes, materials and levels.

4. **BUG-1238, Recent diameters, materials and levels not one-click buttons.**
   - **Fix is at:** `PipeOnePageLayout.cs:82-85`, `UserSettings.cs:1736, 1747`.
   - **What must be seen in AutoCAD to prove it:** Place two pipes of different size and material then run CD: buttons for the recent sizes, materials and levels show.

5. **BUG-675, Pit fit used the wrong wall of a rotated pit.**
   - **Fix is at:** `CdCommand.PitFit.cs:64-66`.
   - **What must be seen in AutoCAD to prove it:** A 600 x 900 pit rotated 90 degrees with a 750 pipe along X: the fit check uses the real 600 wall and Upsize grows the right side.

6. **BUG-676, Edit Pit changed a typed lid name.**
   - **Fix is at:** `ViewModels\PitViewModel.cs:1302-1305`.
   - **What must be seen in AutoCAD to prove it:** Type D400 as the lid in the schedule then Edit Pit another field: the lid stays D400.

7. **BUG-680, Upsize deleted another pit's record on a number mismatch.**
   - **Fix is at:** `PitEditCommand.Resize.cs:97-104`.
   - **What must be seen in AutoCAD to prove it:** Pit label P8 but record P5: CD into it and Upsize is refused, or keeps P5, and P8's record is not deleted.

8. **BUG-681, Uphill Yes left schedule From/To opposite to the plan.**
   - **Fix is at:** `CdCommand.cs:865-910`, `UserSettings.cs:1053, 1061`.
   - **What must be seen in AutoCAD to prove it:** CD P1 to P2 with 10.00 and 10.50, answer Yes: the schedule row matches the plan (P1 10.50 to P2 10.00).

9. **BUG-682, Uphill Cancel left the polyline erased and pit changed.**
   - **Fix is at:** `CdCommand.cs:865-910`, `UserSettings.cs:1053, 1061`.
   - **What must be seen in AutoCAD to prove it:** Cancel at the uphill box: your polyline, the pit size and the schedule row are all back as before.

10. **BUG-011, West-side pipe label text set right-justified.**
   - **Fix is at:** `TextService.cs:474, 1467-1480`.
   - **What must be seen in AutoCAD to prove it:** Place a label west of a pipe with CD, then edit it in CDEDIT: the text reads left to right with the leader on its left edge.

11. **BUG-014, Grades typed as 1:80 or 80 MIN. were refused.**
   - **Fix is at:** `MathHelper.cs:80-110`.
   - **What must be seen in AutoCAD to prove it:** Type 1:80, 1 in 80 and 80 MIN. as the grade: each is accepted and the level works out.

12. **BUG-015, Grade typed 1:80 printed as AT 1 IN 1:80.**
   - **Fix is at:** `CdCommand.Grade.cs:198, 392`.
   - **What must be seen in AutoCAD to prove it:** Whatever way the grade is typed, the label reads AT 1 IN 80.

13. **BUG-016, Number typed in the Custom 1-in box was ignored.**
   - **Fix is at:** `ViewModels\CdViewModel.Grade.cs:188-191`.
   - **What must be seen in AutoCAD to prove it:** Type 80 in the Custom box without clicking its button: the label reads AT 1 IN 80.

14. **BUG-021, Invert text set Above landed below on tilted pipes.** (carpark says IN PROGRESS)
   - **Fix is at:** `TextService.cs:1070`.
   - **What must be seen in AutoCAD to prove it:** Draw pipes at about 92 and 96 degrees with Above chosen: the invert text sits on the upper side, clear of the pipe.

15. **BUG-025, Typed invert 1.10 showed as 1.11 on short pipes.** (carpark says IN PROGRESS)
   - **Fix is at:** `MathHelper.cs:229`.
   - **What must be seen in AutoCAD to prove it:** Type 1.10 on a short pipe: it reads 1.10 and the worked-out end is exactly the typed level plus or minus length over grade.

16. **BUG-041, Custom grade stopped a pipe after two points.** (carpark says IN PROGRESS)
   - **Fix is at:** `CdCommand.cs:1244-1248`.
   - **What must be seen in AutoCAD to prove it:** Draw a four-point pipe with Custom grade: all four points are accepted and the label uses the total length.

17. **BUG-042, Break-across-plans choice offered only for rising mains.** (carpark says IN PROGRESS)
   - **Fix is at:** `ViewModels\CdViewModel.PipeType.cs:148-149`.
   - **What must be seen in AutoCAD to prove it:** The break choice shows for gravity pipes too, and the two halves link.

18. **BUG-073, Draw-first preview did not show real length or fall.** (carpark says IN PROGRESS)
   - **Fix is at:** `Commands\CdCommand.GradeSuggestion.cs:131`.
   - **What must be seen in AutoCAD to prove it:** The preview shows the real drawn length, fall and invert on/off, updating as you move.

19. **BUG-074, Pipe text always on longest segment, moved by typing a number.** (carpark says IN PROGRESS)
   - **Fix is at:** `CdCommand.Arrows.cs:64-129`.
   - **What must be seen in AutoCAD to prove it:** Text and arrow go to the clearest segment, and one click moves them to another segment.

20. **BUG-075, Invert text set Below landed on near-vertical pipes.** (carpark says IN PROGRESS)
   - **Fix is at:** `TextService.cs:1139`.
   - **What must be seen in AutoCAD to prove it:** On a near-vertical pipe with Below chosen the text sits clear under the pipe, and flips if it clashes, in CD and in CDEDIT.

21. **BUG-076, No suggested downstream level when upstream changed.**
   - **Fix is at:** `CdViewModel.Inverts.cs:770-836`.
   - **What must be seen in AutoCAD to prove it:** Change the upstream invert in CD: a downstream level and fall are suggested, holding the fall already set.

22. **BUG-077, Pit inlet-to-outlet drop not carried down the run.** (carpark says IN PROGRESS)
   - **Fix is at:** `CdCommand.GradeSuggestion.cs:474-478`.
   - **What must be seen in AutoCAD to prove it:** Down a run, the small drop between each pit's inlet and outlet (5 mm by default) is applied automatically.

23. **BUG-091, CD refused free-point pipes ("identities must be proven").** (carpark says IN PROGRESS)
   - **Fix is at:** `Services\LinkService.NewPipeEnds.cs:50-57`.
   - **What must be seen in AutoCAD to prove it:** Draw a free-point pipe with CD: it draws and works out the level with no identity refusal. (The entry has no steps; read from its symptom.)

24. **BUG-205, CD flow direction wrong between two open ends.**
   - **Fix is at:** `Services\CdDrawFirstFlowService.cs:98-104`.
   - **What must be seen in AutoCAD to prove it:** Open-end levels 18.00 and 17.80: the pipe flows 18.00 to 17.80 with no uphill warning, and the choice shows the real levels.

25. **BUG-286, CD into a pit on a locked layer left a one-sided link.**
   - **Fix is at:** `Services\LinkService.PitMoves.cs:105-115`.
   - **What must be seen in AutoCAD to prove it:** CD into a pit on a locked layer then move the pit: the pipe goes with it.

26. **BUG-427, Flat pipe label lost its grade wording.**
   - **Fix is at:** `CdCommand.Grade.cs:187-194, 371-373`.
   - **What must be seen in AutoCAD to prove it:** CD with both inverts at 18.50: the label reads 100 DIA. UPVC PIPE FLAT, both levels read 18.50, and one flat warning shows.

27. **BUG-463, Levels typed in the Pit Schedule rounded to 2 decimals unseen.**
   - **Fix is at:** `ViewModels\PitScheduleViewModel.Data.cs:1806, 1906`.
   - **What must be seen in AutoCAD to prove it:** Type a 3-decimal level in the Pit Schedule: it is kept, or the rounding is said plainly. (The entry has no steps.)

28. **BUG-669, Pit labels stayed behind on a second move.**
   - **Fix is at:** `Services\LinkService.Reactors.cs:1707-1710`.
   - **What must be seen in AutoCAD to prove it:** Move a pit twice with MOVE: its labels follow each time.

29. **BUG-683, Level worked on drawn length, not the typed real length.**
   - **Fix is at:** `CdCommand.cs:440-453`.
   - **What must be seen in AutoCAD to prove it:** 1 in 100, upstream 20.00, 20 m drawn, real length typed 50 m: downstream reads 19.50 and the label says 50 m.

30. **BUG-686, Flow arrow wrong when a level is exactly 0.00.**
   - **Fix is at:** `Services\PipeCreationService.PreparedOutputs.cs:267`.
   - **What must be seen in AutoCAD to prove it:** Levels 0.00 and 0.50: the arrow points downhill, following the levels.

31. **BUG-874, Esc after a labelled pipe dropped the callout link.**
   - **Fix is at:** `UserSettings.cs:623`.
   - **What must be seen in AutoCAD to prove it:** Draw a pipe with a callout then Esc at the next pipe: erase the pipe and the label goes with it.

32. **BUG-996, Mirrored pipe text stayed behind when the pipe moved.**
   - **Fix is at:** `UserSettings.cs:1293`, `MirrorService.cs:142`.
   - **What must be seen in AutoCAD to prove it:** Answer Yes to mirror the text then move the pipe: the mirrored label moves with it.

33. **BUG-1229, Own grade with one end known ended shallower (1 in 102).**
   - **Fix is at:** `CdViewModel.Inverts.cs:783-818`, `UserSettings.cs:1693`.
   - **What must be seen in AutoCAD to prove it:** P10 to P9, own 1 in 100, upstream 19.45: the downstream level gives 1 in 100 or steeper and the grade box keeps 100.

34. **BUG-030, Rising-main continue question showed [Yes/Ce].** (carpark says IN PROGRESS)
   - **Fix is at:** `CdCommand.Breakline.cs:73-87`.
   - **What must be seen in AutoCAD to prove it:** The continue question offers Yes and No.

35. **BUG-031, Rising-main continue question was only a command-line prompt.** (carpark says IN PROGRESS)
   - **Fix is at:** `CdCommand.Breakline.cs:73-87`.
   - **What must be seen in AutoCAD to prove it:** A window asks whether to continue from the previous rising main, with Yes and No buttons.

## CDREVERSEFLOW: Turn a pipe around (1)

1. **BUG-1220, Reverse Flow help promised a preview and Apply.** (help wording only)
   - **Fix is at:** `Assets\Help\guide-content.js:103`.
   - **What must be seen in AutoCAD to prove it:** Help says no preview and no Apply, and Enter at "Continue?" leaves the inverts unchanged.

## CDTIDYLABELS: Tidy labels (1)

1. **BUG-890, Leader-out planning reserved room using a label that stays put.**
   - **Fix is at:** `Rules\TextClashTidyUpRule.cs:250-264`, `UserSettings.cs:1458`.
   - **What must be seen in AutoCAD to prove it:** With the switch on, the final tidy never overlaps a label that stays.

## CDTEXTSEG: Move pipe text to another segment (2)

1. **BUG-1194, Moved text used the nearest leg midpoint, not the leg clicked.**
   - **Fix is at:** `Helpers\PipeTextSegmentChooser.cs`, `NearestSegmentToPick`, `PipeTextPlacementService.cs:48`, `Models\UserSettings.cs:931`.
   - **What must be seen in AutoCAD to prove it:** Click the long leg near a bend: that leg is used.

2. **BUG-1195, UCS angle written into a World text object.**
   - **Fix is at:** `PipeTextPlacementService.cs:193-206`, `UserSettings.cs:940`.
   - **What must be seen in AutoCAD to prove it:** With the UCS at 45 degrees move a diagonal pipe's label: back in World the label is at 45 degrees.

## CR: Copy and rotate (1)

1. **BUG-1246, Copied downpipe left without its own tag.**
   - **Fix is at:** `Drainage\Services\ExternalMutationCommandPolicy.cs:45`, `Drainage\Services\LinkService.Utilities.cs:231-248`, `Drainage\Services\LinkService.CopiedSourceOwnTag.cs:19-100`, `Drainage\Rules\CopiedSourceOwnTagRule.cs:60-70`, `Drainage\Rules\CloneSourceCopyRule.cs:28-35`, `UserSettings.cs:1360-1372`.
   - **What must be seen in AutoCAD to prove it:** Copy and rotate a DP then open the Inspector on the copy: it has its own tag (DP2) and is linked.

## CDSTRIP: Strip drain (2)

1. **BUG-022, Strip drain floor wastes sat on the polyline, not the centreline.**
   - **Fix is at:** `StripDrainCommand.Plan.cs:81-124`.
   - **What must be seen in AutoCAD to prove it:** CDSTRIP floor wastes sit on the strip centreline at corners, ends and spacing points.

2. **BUG-290, Record refresh before the question overwrote typed levels.**
   - **Fix is at:** `StripDrainCommand.cs:87-93`, `Commands\CeCommandBase.cs:53-58`.
   - **What must be seen in AutoCAD to prove it:** Type levels, run the command, answer No or press Esc at its question: the typed levels are unchanged.

## CDAGI: AGI drain (1)

1. **BUG-290, Record refresh before the question overwrote typed levels.**
   - **Fix is at:** `AgiCommand.cs:84-93`, `Commands\CeCommandBase.cs:53-58`.
   - **What must be seen in AutoCAD to prove it:** Type levels, run the command, answer No or press Esc at its question: the typed levels are unchanged.

## CDINSPECTOR: Inspector (2)

1. **BUG-099, Cover check printed garbled tick and cross marks.**
   - **Fix is at:** `InspectorPaletteService.cs:3253-3262`.
   - **What must be seen in AutoCAD to prove it:** The Inspector cover line shows a proper tick, warning or cross, not garbled characters.

2. **BUG-995, Health buttons zoomed to empty space in a user UCS.**
   - **Fix is at:** `InspectorPaletteService.cs:2980-2982`, `Services\DrawingService.cs:576-645`.
   - **What must be seen in AutoCAD to prove it:** With a UCS set, click Unconnected pits: the view zooms to those pits.

## PITSCHEDULE: Pit schedule (16)

1. **BUG-1255, Pit Schedule Excel export failed on 2027.**
   - **Fix is at:** `PitScheduleViewModel.Schedule.cs:126-147`, `PluginInitialization.cs:61-63`, `Models\UserSettings.cs:3643-3644`.
   - **What must be seen in AutoCAD to prove it:** Export Excel opens the Windows save box and no rendering-error line follows.

2. **BUG-1198, Cancelled export still saved the row order.**
   - **Fix is at:** `PitScheduleViewModel.Schedule.cs:48-53, 113-117`.
   - **What must be seen in AutoCAD to prove it:** Export CSV then Cancel: no "Project data saved" line and the record is unchanged.

3. **BUG-458, PIT, PP, CD and the schedule ran during REFEDIT.**
   - **Fix is at:** `PitScheduleCommand.cs:30-40`, `Services\DrawingSafetyService.cs:51-59`.
   - **What must be seen in AutoCAD to prove it:** Open an Xref with REFEDIT then run PIT, PP and PITSCHEDULE: each refuses and changes nothing.

4. **BUG-464, Pit Schedule skipped the read-only drawing check.**
   - **Fix is at:** `PitScheduleViewModel.cs:352, 401-421`.
   - **What must be seen in AutoCAD to prove it:** Open PITSCHEDULE on a read-only drawing: it opens to view only and says changes cannot be made.

5. **BUG-780, Wrong pipe on an inlet row when two inlets merged into DPs.**
   - **Fix is at:** `PitScheduleBuilder.cs:282-332`.
   - **What must be seen in AutoCAD to prove it:** P5 with inlets P3, DP1, DP2, AG1: rows read P3, DPs, then AG with its own size and level 19.90.

6. **BUG-786, Saved row order split a pit's rows once a pipe was added.**
   - **Fix is at:** `PitScheduleViewModel.Data.cs:936-946`.
   - **What must be seen in AutoCAD to prove it:** With 10 or more rows add a second inlet to P5 and reopen: P5's new row sits with P5 in invert order.

7. **BUG-791, Pit size and untouched cells marked as overridden.** (a Codex PASS on 3.0.70 is recorded in the entry)
   - **Fix is at:** `PitScheduleDialog.xaml.cs:225-243`.
   - **What must be seen in AutoCAD to prove it:** Type 900 x 900 then PITEDIT to 1200 x 1200: the schedule shows 1200 x 1200.

8. **BUG-965, Refresh turned 2/375 and 3000 into 375 and 300 x 300.**
   - **Fix is at:** `Services\ScheduleLinkService.cs:2625-2638`, `UserSettings.cs:1161-1167`.
   - **What must be seen in AutoCAD to prove it:** Press Refresh on a placed schedule: 2/375, the grate length and a blank pump pit stay as they were.

9. **BUG-981, Second Xref's pit printed blank in a combined schedule.**
   - **Fix is at:** `PitScheduleViewModel.Schedule.cs:470-476`.
   - **What must be seen in AutoCAD to prove it:** A combined schedule from two Xref drawings keeps each drawing's pits separate, with numbers.

10. **BUG-1008, Double-click on a Remarks cell said "cannot be edited".**
   - **Fix is at:** `PitScheduleDialog.xaml.cs:380-383`.
   - **What must be seen in AutoCAD to prove it:** Double-click a Remarks cell: a typing box opens, and Restore and Delete cell work on it.

11. **BUG-1009, Xref row click selected an unrelated host object.**
   - **Fix is at:** `PitScheduleDialog.xaml.cs:268-277`.
   - **What must be seen in AutoCAD to prove it:** Click a row that comes from an Xref: nothing in your drawing is selected, and it zooms into the Xref or says plainly it cannot.

12. **BUG-1011, Depth typed with auto-depth off changed no levels.**
   - **Fix is at:** `PitScheduleViewModel.Data.cs:1275-1280`.
   - **What must be seen in AutoCAD to prove it:** With Auto-calculate depth off, type a depth: the pit levels change and Stop overriding keeps it.

13. **BUG-1022, Re-found pit lost its override and row place.**
   - **Fix is at:** `Services\ProjectDataService.cs:484-487`.
   - **What must be seen in AutoCAD to prove it:** Copy a pit so its handle changes: its typed cover override and row order follow it.

14. **BUG-1031, No Delete cell on the cell right-click menu.**
   - **Fix is at:** `PitScheduleDialog.xaml:529-535`.
   - **What must be seen in AutoCAD to prove it:** Right-click a Pit Schedule cell: the menu offers Delete cell.

15. **BUG-1035, Shallow warning used a hidden fixed 300 mm.**
   - **Fix is at:** `PitScheduleViewModel.cs:39-40`.
   - **What must be seen in AutoCAD to prove it:** A Settings box (CDS, Pipes and Pits) sets the shallow depth, starting at 300 mm: 0.29 reads Shallow and 0.30 reads OK.

16. **BUG-1197, Updating one schedule changed another's depth heading.**
   - **Fix is at:** `PitScheduleViewModel.Schedule.cs:1522-1579`.
   - **What must be seen in AutoCAD to prove it:** Two schedules share a heading and B is locked: update A and B keeps DEPTH TO OUTLET and its depth; one U undoes it.

## CDPROFILE: Long section (11)

1. **BUG-756, Long section drew each pipe top at the next pipe's size.**
   - **Fix is at:** `LongitudinalSectionService.cs:1481-1489, 1513`.
   - **What must be seen in AutoCAD to prove it:** A 225 followed by a 375: the 225 top line sits 225 above its invert.

2. **BUG-760, A level pipe with no grade label stopped the long section.**
   - **Fix is at:** `ProfileRouteEvidenceCaptureService.cs:620-625, 754-761`.
   - **What must be seen in AutoCAD to prove it:** A flat pipe with no label draws with PIPE GRADE LEVEL and blank speed rows.

3. **BUG-761, Uphill pipe printed as a normal grade with a speed.**
   - **Fix is at:** `ProfileRouteEvidenceCaptureService.cs:744-750, 777-785`.
   - **What must be seen in AutoCAD to prove it:** A pipe from 10.00 up to 10.20 is flagged adverse with no velocity.

4. **BUG-762, Invert above cover hidden as depth 0.00, review said Ready.**
   - **Fix is at:** `ProfileRouteReviewService.cs:437-448`.
   - **What must be seen in AutoCAD to prove it:** Cover 10.00 and invert 10.20: the review says Unknown with the reason before Apply.

5. **BUG-763, Review grid row mixed two pipes' size and grade.**
   - **Fix is at:** `ProfileRouteReviewViewModel.cs:46-51`.
   - **What must be seen in AutoCAD to prove it:** Row B reads 375, 1 in 200 and the speed of the pipe leaving B.

6. **BUG-764, Boundary marks found on a straight line, not the bent pipe.**
   - **Fix is at:** `LongitudinalSectionViewModel.cs:854-935, 1402-1470`.
   - **What must be seen in AutoCAD to prove it:** A bent pipe crossing a boundary gets a mark only where it really crosses.

7. **BUG-766, Long section never drew branch junction marks.**
   - **Fix is at:** `LongitudinalSectionService.cs:857-859, 967-990`.
   - **What must be seen in AutoCAD to prove it:** A branch at 6.4 m shows its "100 DIA. BRANCH" tick on the section.

8. **BUG-767, Existing-pipe stub drawn through the table frame.**
   - **Fix is at:** `LongitudinalSectionService.cs:1823-1845`, `UserSettings.cs:905`.
   - **What must be seen in AutoCAD to prove it:** The frame widens so the existing-pipe stub stays inside it.

9. **BUG-768, Every pit counted at least 1800 wide in the profile.**
   - **Fix is at:** `Rules\ProfilePitWidthRule.cs:25-52`.
   - **What must be seen in AutoCAD to prove it:** A 600 x 600 pit records 600, and a boundary 0.9 m from its centre is kept.

10. **BUG-769, Long section started on the first schedule set, not the route's.**
   - **Fix is at:** `ProfileRouteReviewViewModel.cs:143-149`.
   - **What must be seen in AutoCAD to prove it:** Sets A and Main with the route in Main: the first Preview is not refused and the set defaults to Main.

11. **BUG-1012, Closing side of a closed boundary gave no boundary mark.**
   - **Fix is at:** `LongitudinalSectionViewModel.cs:1274-1322`.
   - **What must be seen in AutoCAD to prove it:** A pipe crossing the last side of a closed boundary gets its mark on the long section.

## CDHELP: Help (3)

1. **BUG-555, Help fell back to a web address that is not the company's.**
   - **Fix is at:** `Models\HelpSettings.cs:14`, `CdHelpService.cs:147-148`, `HelpLauncher.cs:79`, `Assets\Config\command-registry.json:26, 34, 54`.
   - **What must be seen in AutoCAD to prove it:** With the switch off, Help never opens a web address.

2. **BUG-1215, Help promised a separate Save report step.**
   - **Fix is at:** `guide-content.js:100`.
   - **What must be seen in AutoCAD to prove it:** Help says Send report saves a copy and tries the office folder in one step.

3. **BUG-1220, Reverse Flow help promised a preview and Apply.** (help wording only)
   - **Fix is at:** `guide-content.js:103`.
   - **What must be seen in AutoCAD to prove it:** Help says no preview and no Apply, and Enter at "Continue?" leaves the inverts unchanged.

## CDS: Preferences (1)

1. **BUG-957, Enter on an empty Settings search saved and closed.**
   - **Fix is at:** the note cites no file and line for this fix.
   - **What must be seen in AutoCAD to prove it:** Search for something not there then press Enter: Settings stays open and nothing is saved.

## CEBLOCKS: Office blocks (2)

1. **BUG-1047, Frozen layer refused a block before the point question.**
   - **Fix is at:** `CeBlocksInsertService.cs:57-65, 251-261`, `Services\CeBlocksLayerGate.cs:20-35`, `CeBlocksSettings.cs:30`.
   - **What must be seen in AutoCAD to prove it:** Place a block on a frozen layer: it warns the block will be hidden and places it.

2. **BUG-524, Ribbon buttons showed no AutoCAD command name.**
   - **Fix is at:** `Shared\CE_SHARED\Services\RibbonBuilder.cs:268-270`, `Modules\Drainage\Models\UserSettings.cs:3668-3669`.
   - **What must be seen in AutoCAD to prove it:** Ribbon buttons and tips show the plain name with the AutoCAD command in brackets.

## CDMANAGER: Layer colours and draw order (1)

1. **BUG-229, Draw order list showed each layer twice.**
   - **Fix is at:** `LayerManagerViewModel.cs:99`, `LayerService.cs:1207-1238`, `SettingsService.cs:776, 788`.
   - **What must be seen in AutoCAD to prove it:** Open CDMANAGER on a new drawing: Draw Order lists each layer once.

## CDNEWDWG: New job drawing (1)

1. **BUG-969, New sheet title block carried the old job's number.**
   - **Fix is at:** `NewJobDrawingCommand.cs:51, 128-145`, `NewJobDrawingDialog.xaml.cs:62, 122`, `Rules\NewJobDrawingRecordSource.cs`.
   - **What must be seen in AutoCAD to prove it:** Change the job folder in CDNEWDWG: the preview and the new sheet show the new job's number, client and address.

## CDDESIGN: Design inputs (16)

1. **BUG-174, A [CE] tag printed inside a Yes/No question.**
   - **Fix is at:** `CivilDesignCommand.cs:476, 545`.
   - **What must be seen in AutoCAD to prove it:** The question reads "... [Yes No]" only, with no [CE] text inside it.

2. **BUG-259, Confirm setup lost the outlet and the agreed design.**
   - **Fix is at:** `CivilDesignCommand.cs:160-176, 226-237`.
   - **What must be seen in AutoCAD to prove it:** After Confirm setup the window reopens with the outlet kept and the During page showing the agreed design, or a plain statement of what is missing.

3. **BUG-365, Window controls had no names for screen readers.**
   - **Fix is at:** `CivilDesignWindow.xaml`.
   - **What must be seen in AutoCAD to prove it:** Controls in CDDESIGN carry plain names when read with an accessibility viewer.

4. **BUG-506, Summary printed connection pipe grade as 1:0.**
   - **Fix is at:** `Services\DesignProposalReport.cs:308-316`.
   - **What must be seen in AutoCAD to prove it:** The CDDESIGN calculation summary shows the real connection pipe grade.

5. **BUG-509, Summary printed the office C, not the council C used.**
   - **Fix is at:** `DesignProposalReport.cs:173`.
   - **What must be seen in AutoCAD to prove it:** The summary shows the C that the discharge actually used.

6. **BUG-510, Roof and paved C was 0.9 in one tool and 1.0 in another.**
   - **Fix is at:** `AutoDesignService.cs:62-69`.
   - **What must be seen in AutoCAD to prove it:** CDDESIGN and CDCALC both use the one Settings value for hard surface C.

7. **BUG-511, Detention pipe sized on fixed 40 m and fixed sizes.**
   - **Fix is at:** `CivilDesignService.cs:164-166`.
   - **What must be seen in AutoCAD to prove it:** Change the detention pipe values in Settings: CDDESIGN follows them.

8. **BUG-967, Blue Factor report took the whole site as roof and paved.**
   - **Fix is at:** `Rules\BlueFactorReport.cs:89-107`.
   - **What must be seen in AutoCAD to prove it:** Roof 400, drive 100, garden 300, lawn 200 on 1000 m2: Roof and paved area reads 500.

9. **BUG-1004, "Nothing changed since agreed" ignored an orifice head change.**
   - **Fix is at:** `Rules\AgreedDesignRules.cs:224-229`.
   - **What must be seen in AutoCAD to prove it:** Agree at 0.45 m head, change to 0.60 m, Save Draft and reopen: the change is listed.

10. **BUG-1091, Auto design dropped minimum grade for DN450 and over.**
   - **Fix is at:** `Services\SettingsSizingStandards.cs:133-136`.
   - **What must be seen in AutoCAD to prove it:** DN450 at 30 L/s comes out at 1 in 200 or steeper.

11. **BUG-1095, Council minimum C was never applied.**
   - **Fix is at:** `AutoDesignService.cs:102-111`.
   - **What must be seen in AutoCAD to prove it:** A 600 m2 lot with 400 hard and 200 soft, on a council with a 0.80 floor: C reads 0.80 and the sheet says the council minimum governs.

12. **BUG-1106, A two-word council in a rating report was not found.**
   - **Fix is at:** `Rules\StormReportOffer.cs:123-130`.
   - **What must be seen in AutoCAD to prove it:** A report naming a two-word council sets that council's own profile.

13. **BUG-490, Windows login name written inside the drawing at sign-off.** (fixed in the redesign sign-off and Pit Schedule code, not in this window)
   - **Fix is at:** `Services\NetworkRedesignSignOffService.cs:31-32`.
   - **What must be seen in AutoCAD to prove it:** Confirm a pipe end and sign off a redesign, then save: the drawing holds no Windows login name.

14. **BUG-783, Deleted schedule cell came back as the word DELETE.** (fixed in the redesign sign-off and Pit Schedule code, not in this window)
   - **Fix is at:** `Services\ScheduleCellOverrideText.cs`.
   - **What must be seen in AutoCAD to prove it:** Delete a cover cell, place the schedule, then PITEDIT: the cell stays blank.

15. **BUG-785, Schedule depth changed after the next edit.** (fixed in the redesign sign-off and Pit Schedule code, not in this window)
   - **Fix is at:** `Services\ScheduleLinkService.cs:2734-2755`.
   - **What must be seen in AutoCAD to prove it:** Cover 10.50, inlet 9.00, rising main outlet 10.00: depth 1.50 stays 1.50 after any pit command.

16. **BUG-812, Redesign Apply put new pits at the bottom; pump pit skipped.** (fixed in the redesign sign-off and Pit Schedule code, not in this window)
   - **Fix is at:** `Services\NetworkRedesignScheduleReviewService.cs:920`.
   - **What must be seen in AutoCAD to prove it:** New pits from Apply sit in natural order, and a skipped pump pit is reported on screen.

## CDCALC: Drainage calculations (12)

1. **BUG-1030, Closing CDCALC untouched left an undo step.**
   - **Fix is at:** `Dialogs\CalculationsV2Dialog.xaml.cs:136-146`, `Services\CalculationWorkspacePersistenceService.cs:59-116`, `ViewModels\CalculationsV2ViewModel.cs:523-545`, `CalculationsCommand.cs:71-84`, `Services\CalculationDraftUnchangedGate.cs:25-30`.
   - **What must be seen in AutoCAD to prove it:** Open the CDCALC tabs, change nothing, Close: no U step and no save line.

2. **BUG-158, Council computations sheet silently dropped from the export.**
   - **Fix is at:** `CalculationExportPackage.cs:88-96, 380-391`.
   - **What must be seen in AutoCAD to prove it:** With four tabs ticked the export has five sections, the computations sheet first, or a plain warning says why not.

3. **BUG-233, Council sheet sources showed file paths and web links.**
   - **Fix is at:** `Rules\CouncilSourceWords.cs`.
   - **What must be seen in AutoCAD to prove it:** The CDCALC sheet PDF shows every source as a document name and page.

4. **BUG-515, Boyd's storage too small when worst storm was longer.**
   - **Fix is at:** `BoydsCalcViewModel.cs:281`.
   - **What must be seen in AutoCAD to prove it:** On the Boyd's tab, when the worst storm is longer than the last row, it says so.

5. **BUG-772, WSUD took impervious area over the site and negative areas.**
   - **Fix is at:** `WsudViewModel.cs:183`.
   - **What must be seen in AutoCAD to prove it:** Site 1000 m2 with impervious 1200 m2 is refused, and so is a negative area.

6. **BUG-905, Detention and Boyd's used different hard-ground C.**
   - **Fix is at:** `BoydsCalcViewModel.cs:236-242`.
   - **What must be seen in AutoCAD to prove it:** Both tabs use the one Settings hard-ground C.

7. **BUG-980, Pipe Flows kept the first pipe's grade on picking a second.**
   - **Fix is at:** `PipeFlowCalcViewModel.cs:170, 211-218`.
   - **What must be seen in AutoCAD to prove it:** Pick a 1 in 50 pipe then a 1 in 200 pipe: grade, diameter and roughness refill and the note names the pipe used.

8. **BUG-997, Update Existing changed a copied long section too.**
   - **Fix is at:** `LongitudinalSectionService.cs:503-530`.
   - **What must be seen in AutoCAD to prove it:** Copy a long section then update the original: the copy keeps its old content, even on a locked layer.

9. **BUG-1019, CDCALC invented a top water level of 0.00 below RL 0.**
   - **Fix is at:** `DetentionSystemViewModel.cs:633, 749-755, 861-883`.
   - **What must be seen in AutoCAD to prove it:** Pipes at -1.000 and -1.100: water level -0.700 is suggested, and a level above a -0.500 lid warns.

10. **BUG-1036, Pipe Flows note quoted fixed roughness values.**
   - **Fix is at:** `CalculationsV2Dialog.xaml:586-590`.
   - **What must be seen in AutoCAD to prove it:** With UPVC and PVC both at 0.015, the note and hover text show 0.015 or no number.

11. **BUG-1097, 300 mm minimum head on a charged downpipe never checked.**
   - **Fix is at:** `ViewModels\ChargedSystemCalcViewModel.cs:229-262`.
   - **What must be seen in AutoCAD to prove it:** The Charged System tab and CDRULES warn when the head is under the minimum (250 against 300).

12. **BUG-1101, CDCALC Catchments opened with a made-up catchment and storm.**
   - **Fix is at:** `CalculationsV2ViewModel.cs:387`.
   - **What must be seen in AutoCAD to prove it:** A new job opens Catchments with no rows and the storm at the Settings Tc.

## CDTWL: Top water level (5)

1. **BUG-545, Two Settings values for one freeboard.**
   - **Fix is at:** `DetentionTwlService.cs:416-423`, `Rules\RulebookValues.cs:355-362`, `Rules\DetentionFreeboardRule.cs:13-24`.
   - **What must be seen in AutoCAD to prove it:** CDTWL freeboard follows one Settings value (150 mm by default).

2. **BUG-871, CDTWL ignored the drawing units.**
   - **Fix is at:** `DetentionTwlService.cs:194, 207`, `DetentionBranchCollector.cs:351-352`, `Models\UserSettings.cs:3363`.
   - **What must be seen in AutoCAD to prove it:** In a metre drawing the volumes and freeboard come out right (switch on).

3. **BUG-970, Two detention systems with the same pit numbers were mixed.**
   - **Fix is at:** `DetentionTwlCommand.cs:107-135`, `DetentionTwlService.cs:171-183`.
   - **What must be seen in AutoCAD to prove it:** Two sets both using P1-P2: CDTWL asks which outlet and counts only that system.

4. **BUG-1032, Top water level list showed handles and "pipe pipe".**
   - **Fix is at:** `TopWaterLevelCandidates.cs:34-37`, `DetentionBranchCollector.cs:266-273`.
   - **What must be seen in AutoCAD to prove it:** The usual-rule row names the pipe pit to pit, with no handle and no doubled word, and a level above the lid reads ABOVE the lowest lid.

5. **BUG-777, Default top water level used invert plus pipe, not highest obvert.** (the fix is in the code but SWITCHED OFF as installed)
   - **Fix is at:** `TopWaterLevelCandidates.cs:97-118`, `UserSettings.cs:1346`.
   - **What must be seen in AutoCAD to prove it:** Switch the setting on, then a 225 at 10.000 and a 375 at 9.990 offers 10.365.

## CDRUNSOLVE: Solve inverts down a run (2)

1. **BUG-290, Record refresh before the question overwrote typed levels.**
   - **Fix is at:** `RunSolveCommand.cs:77-80, 212`, `Services\ProjectDataService.RecordWriteHold.cs:19-24, 84-86`.
   - **What must be seen in AutoCAD to prove it:** Type levels, run the command, answer No or press Esc at its question: the typed levels are unchanged.

2. **BUG-868, Every pipe sized as UPVC.**
   - **Fix is at:** `Services\NetworkDesignService.cs:98, 262, 708-726`, `Models\UserSettings.cs:2737`.
   - **What must be seen in AutoCAD to prove it:** A concrete 375 at 1 in 130 is sized for about 154 L/s, not 200 (switch on).

## CDRULES: Rulebook check (8)

1. **BUG-239, CDRULES sources showed file paths and web links.**
   - **Fix is at:** `Rules\CouncilRuleValues.cs:19-22, 48-52`.
   - **What must be seen in AutoCAD to prove it:** CDRULES findings and the auto-design report show every source as a document name and page.

2. **BUG-514, CDRULES warned "assumed roughness" on every pipe.**
   - **Fix is at:** `RulebookEngine.cs:488-490`.
   - **What must be seen in AutoCAD to prove it:** Confirm the roughness then run CDRULES: no assumed-roughness warning on that pipe.

3. **BUG-540, "With Step Irons" used two different depths.**
   - **Fix is at:** `ViewModels\PitScheduleViewModel.cs:41-43`.
   - **What must be seen in AutoCAD to prove it:** The Pit Schedule step-iron wording follows the one Settings depth.

4. **BUG-867, Grade and speed judged on straight centre distance.**
   - **Fix is at:** `RulebookEngine.cs:64-80`.
   - **What must be seen in AutoCAD to prove it:** A 225 drawn at 1 in 240 warns against the 1 in 200 minimum.

5. **BUG-901, Cover measured to the inside top of the pipe.**
   - **Fix is at:** `UserSettings.cs:317`, `RulebookEngine.cs:546-564`.
   - **What must be seen in AutoCAD to prove it:** Concrete 375 shows about 275 mm cover, using the Settings wall thickness.

6. **BUG-906, R-30 judged a 100 mm downpipe that R-06 did not.**
   - **Fix is at:** `RulebookEngine.cs:631-636`.
   - **What must be seen in AutoCAD to prove it:** R-30 says Unknown for the same reason as R-06.

7. **BUG-907, No warning when outlet top sat above inlet top.**
   - **Fix is at:** `UserSettings.cs:1918`, `RulebookEngine.cs:804-820`.
   - **What must be seen in AutoCAD to prove it:** A 150 in at 10.000 and 300 out at 9.980 warns that the outlet top is above the inlet top.

8. **BUG-1092, A pipe up to 5 mm uphill was called essentially flat.**
   - **Fix is at:** `Services\DesignValidationService.cs:318-349`, `RulebookEngine.cs:384-386`.
   - **What must be seen in AutoCAD to prove it:** A 1 m pipe with the downstream end 4 mm higher gives the uphill error.
