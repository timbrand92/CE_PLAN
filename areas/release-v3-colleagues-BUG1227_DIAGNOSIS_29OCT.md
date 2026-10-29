# BUG-1227 and BUG-1231: diagnosis and draft fix plan (build item B-049, job B-043a)

Thu 29 Oct 2026, 22:20 Melbourne time. Read-only diagnosis: no build, no branch, no PR, no AutoCAD started.
Code read on `origin/claude/rel-20261026z` (Civil 3.0.85, commit 09126560). Evidence: the robot's run tonight
on Civil 3.0.86 (driver transcript `session_20261029_205902.log`, 21:00) and the Civil CE log for the same minute.

---

## FOR TIM

### Answer first

1. **The copy is stealing P3's pipes. It is not just noise.** When a ROTATE Copy or SCALE Copy lands on top of P3,
   CE reconnects the pipes at that spot. Some of P3's pipes end up joined to the new copy (P11) instead of P3.
   The "not updated" lines are CE noticing that P3's schedule row now lists pipes that no longer belong to P3.
2. **What it looks like on the drawing.** In tonight's robot run, the ROTATE Copy took three of P3's five incoming
   pipes (from WT9, from P4 and from WT4) and gave them to P11. A SCALE Copy straight after took P3's outgoing pipe
   (P3 to P2) and one more incoming pipe (from WT3) and gave them to P12. In the end P3 had just one pipe left, and the
   copies had the rest.
3. **Why it happens.** Both pits sit within a fraction of a millimetre of each other, and both touch the same pipe ends.
   CE gives each pipe end to whichever pit's insertion point is a hair closer. It knows two pits are touching but still
   picks one without telling you. When the copy is 5 m away, no pipe end touches it, so nothing changes and no lines print.
4. **Why the lines repeat after EXPLODE, ERASE and COPY (BUG-1231).** CE re-checks every Pit Schedule cell in the
   drawing after any command that reconnects a pit. Every cell that is out of step gets its own line, every time, with
   nothing to stop the same line printing again. C1's seven lines (one outlet size plus three inlet rows) were already out
   of step before your first check at 10:22, so they printed after every pit change.
5. **What I could not find.** Why C1's cells were out of step in the first place. The log shows nothing touching C1's
   pipe this morning. My best guess is that C1's schedule row was drawn when C1 had different pipes. It is a guess.

### The fix I recommend (draft only, not built)

1. **Part A, stop the theft (the real fault).** When a copied pit lands on pipe ends that are already joined to another
   pit, and that pit still touches those ends, the pipes stay with the original. The copy only picks up loose pipe
   ends, which is what copying onto an empty junction already does. CE prints one plain line, for example:
   "P11 sits on pipe ends already joined to P3; they stay joined to P3."
   Settings switch: **linking.pitCopyKeepsOriginalsPipes**, ON.
2. **Part B, say it once (the noise).** Each pit gets one line instead of one line per cell, for example:
   "Pit schedule row for C1: 7 cells (outlet pipe size, inlet from, inlet pipe size) no longer match the drawing and were
   left as drawn. Run Update existing schedule in PITSCHEDULE." A pit the command did not touch is reported once per
   drawing per AutoCAD session, not after every command.
   Settings switch: **linking.scheduleStaleCellLinesOncePerPit**, ON.
3. **Order.** Build Part A first, because it changes drawing data. Part B is wording only.

### What to check in AutoCAD once it is built (not yet)

1. Pick P3 and type ROTATE. Snap the base point to P3, choose C (Copy) and type 90.
   - **Right:** the copy is numbered P11, no "Pit schedule cell for P3" lines print, and the Inspector on each of
     P3's pipes still says P3.
2. Do the same with SCALE, C and 1.5. P3's outgoing pipe must still start at P3.
3. U once. Everything goes back to how it was before.
4. Explode or erase any other pit on a drawing whose schedule has stale cells.
   - **Right:** at most one short line per pit, then the line about your pit.

### What is not proven

1. Nobody has watched this by hand. The evidence is one robot run tonight on 3.0.86, plus the same 6-then-9 pair
   of counts in the CE log 12 times between 02:36 and 04:05 this morning (earlier robot runs).
2. If you snap exactly to P3's insertion point, the code says P3 should win every tie because it is older, so you might
   see nothing. The robot typed a base point rounded to 0.1 mm, which put the copy a hair off. I have not proven which
   way a real snap goes.
3. **One question for CE 04, not a blocker.** After the fix, if you copy a pit onto P3 on purpose and then erase P3, do
   you want the copy to pick up P3's pipes automatically? I have not checked whether ERASE does that today.

---

## ANSWER FIRST (technical)

1. **PR number:** none. This job was diagnosis and plan only; nothing was built.
2. **What a drafter will see differently (after Part A + B):** a pit copy landing on an existing pit no longer rewires that
   pit's pipes; no "Pit schedule cell for P3" lines; repeated schedule lines collapse to one per pit, said once.
3. **Mistakes of my own first:** my first reading of the code said an exact tie is won by the older pit (drawing order, strict
   `<` in the picker), which would have meant "nothing is disturbed". I almost wrote that. Only the CE log proved the
   opposite: pipes did move. That was because the robot's base point was rounded, so it was never an exact tie. Cost: about
   ten minutes, and nothing was written on that wrong reading.
4. **NOT proven:** an exact-snap ROTATE Copy (true tie); any by-hand run; the cause of C1's stale cells in BUG-1231;
   whether ERASE of the original later hands its freed ends to the copy.
5. **Robot case that proves Part A: N36_rotcopy_on_pit, with switch-off control C36** (details at the end).

---

## Where the lines come from

1. **The per-cell line:** `Modules/Drainage/Services/ScheduleCellRefreshGate.cs:153-159` `BuildSkippedCellLine`
   ("Pit schedule cell for P3 (inlet from) not updated: " + reason). The reason text for this case is at `:123-124`
   (`ScheduleCellProtection.StaleSource`). The advice line ("A pit schedule cell whose pit or pipe no longer matches was
   left as drawn...") is `StaleSourceAdvice`, at `:318-320`.
2. **Printed by:** `ScheduleLinkService.cs:1002-1029` `NotifySkippedCellLines`, which writes one `[CE]` line per entry of
   `ScheduleCellSkipReport.BuildCommandLineLines()` (`ScheduleCellRefreshGate.cs:358-382`), up to 12 named cells.
3. **The cell is classed as stale here:** `ScheduleLinkService.cs:831-843` (C-7 builder item 2). After the cell text is
   built, `CellRowPipeTurnedAway` (`:3138-3147`) asks whether the row's inlet or outlet pipe still meets this pit on the
   column's side (`RowPipeMeetsPitOnColumnSide` / `PipeMeetsPitOnSide`, `:3089-3115`). A pipe whose To end is now P11
   names "only other pits", so it returns false and the cell is added as `StaleSource`, naming P3.
4. **Why "inlet from" and "inlet pipe size" repeat:** the de-duplication key is the cell entity's handle
   (`ScheduleCellRefreshGate.cs:288-296`). Each inlet row of P3 has its own cells, so three inlet rows give three identical-looking
   pairs. It is one line per cell, not a double print. The second block the robot transcript shows after `esc-prompt` is the
   driver re-reading the command-line tail. The CE log has exactly one WARN per command: 21:00:09.708 (6 cells) and
   21:00:26.185 (9 cells).

## Cause (BUG-1227): the copy's relink hands P3's pipe ends to the copy

1. A copied pit is queued for the scoped pit relink: `LinkService.Utilities.cs:457` (`QueueClonePitRelinks`, BUG-210).
   The copy's own pipe list is emptied first (`RemapClonePit`, `LinkService.Utilities.cs:734-765`), so it claims nothing.
2. `LinkService.RepairAudit.Relink.cs:794-798` (`SelectPipesAtScopePits`) adds every pipe with an end inside the copy's
   outline as a candidate. With the copy on top of P3, these are all of P3's pipes ("pipesExamined=6 directionWriter=6" in
   the log).
3. Each candidate goes through `RelinkPipeThroughDirectionWriter` (`:842`) and then `UpdatePipeLinksFromGeometry`
   (`LinkService.Geometry.cs:216-...`). That calls `ResolvePipeEndpointOwners` and then `FindBestPitOwnerAtPoint`
   (`LinkService.Geometry.cs:1265-1311`), which scans every pit that touches the end.
4. **The defect:** `NearestPitPicker.OfferIfTouching` (`Rules/PitOutline.cs:707-721`) keeps the pit whose insertion point is
   strictly nearer (`:714`). Where two pits touch, it flags `IsAmbiguous` (`LinkService.Geometry.cs:1309`), but that flag only
   stops the end KEY being vouched for (`PipeEndSpineKeyPolicy.CanVouch`). The owner itself is still written to the copy, and
   nothing prefers the pit the end was already joined to. `WasPitLinkedToPipeEnd` (`:1319-...`) is used only to widen the reach
   (`TouchesExistingLink`), never to break a tie.
5. **The log proves the original's record is disturbed.** Civil CE log, 21:00:09:
   `Pipe endpoints updated: 10A901 from=WT9 to=P11`, `10A98D from=P4 to=P11`, `110136 from=WT4 to=P11`. These were all `to=P3`
   at 10:05 the same day. Then at 21:00:25, SCALE Copy gave `109E23 from=P12 to=P2` (P3's outlet) and `110179 from=WT3 to=P12`.
   The `[R6.11 attach]` lines show the copy sitting about 0.1 mm off P3 (`delta=(-0.1,0.0)`), because the typed base point
   `53777.7,-25569.9` is rounded.
6. **Not specific to PR #1831.** PR #1831 (`LinkService.CloneRegeneration.cs:280-287`, `RotateScaleCopyRule`) only copies the label
   and cover text by displacement. It does not touch pipes. The Opus reviewer saw the same lines on 3.0.84, before #1831 was in.
   Any pit copy that lands on another pit's pipe ends (COPY with 0,0, or a copy dropped on a joined junction) takes the same
   path.

## Second suspect (BUG-1231 repeats), and C1

1. **Repeats after every pit command:** `LinkService.Reactors.cs:1922-1923`. When a pit relink is pending (copy, erase,
   explode), the FULL `ScheduleLinkService.RefreshLinkedCells(db)` runs. That full pass (`ScheduleLinkService.cs:525-537`,
   full scan `:589-628`) re-classifies every linked cell in the drawing. `NotifySkippedCellLines` prints every stale-source cell
   each time. A copied schedule is said once per drawing per session (`AddCopiedSchedule` with `CopiedScheduleAnnouncements.FirstTime`,
   `ScheduleCellRefreshGate.cs:273-286`). Stale-source cells have no such gate. That is why C1's seven lines followed
   EXPLODE, ERASE and COPY of unrelated pits.
2. **C1's own cells: cause not found (ranked suspects):**
   1. C1's schedule row was drawn when C1 had different pipes, or a different flow at its one pipe. C1 is a detention pit
      with one recorded pipe, P1 to C1 (`1135E9`, log 10:05:15). A row with one outlet and three inlet rows does not match
      that, so `CellRowPipeTurnedAway` marks them stale (`ScheduleLinkService.cs:831-843`).
   2. An earlier copy-on-top (this bug) stole C1's pipes on that drawing before the morning session.
   3. The cells' stored pipe identity no longer equals the pipe's record (`ClassifyCellSource`, `ScheduleLinkService.cs:913-924`).
   This is less likely, because the line would then also name the cover and size columns.

---

## DRAFT FIX PLAN (not built)

### Part A: a pit copy never takes pipe ends already joined to another pit that still touches them

1. **Switch:** `linking.pitCopyKeepsOriginalsPipes` in `LinkingSettings`
   (`Modules/Drainage/Models/UserSettings.cs`, the group with `rotateScaleCopyLikeCopy` at `:838`).
   - Documented "Default: on."
   - Pinned in `C75NewSwitchDefaultsTests` (or its C-76 successor) through BOTH `SettingsService.DeserializeSettings` and
     `DeserializeSettingsTolerant`.
   - Shown on the Settings page if its neighbours are.
   - Missing file or group reads ON (R-27).
2. **Where:** the clone-relink route only. `RelinkAllPipesToPitsScoped` already knows its scope pits. Pass a
   "scope pits are copies" set from `QueueClonePitRelinks` (`state.PendingPitRelinks` handles that came from clone reconcile)
   into `UpdatePipeLinksFromGeometry` through the existing `ScopePitClaimEvidence` object (no new parameter chain).
3. **Rule (pure, testable, in `Rules/`):** `CopiedPitEndOwnerRule.Choose(incumbentTouches, incumbentIsLive, winnerIsScopeCopy, switchOn)`.
   When the end's current owner (its pit link record or the record's From/To, as `WasPitLinkedToPipeEnd` reads it) is a live
   pit that still touches the end, and the nearest-pit winner is a copy from this command, the incumbent keeps the end.
   Open ends, and ends whose pit was erased (BUG-210), go to the copy as today. Everything else is unchanged: MOVE, grip edits,
   PIT and CDREPAIR never reach this rule.
4. **Message (warn, never block, R-27):** one line per copy that sat on joined ends, for example
   "P11 sits on pipe ends already joined to P3; they stay joined to P3." Built in `CloneCleanupMessages.cs`.
5. **REDO-safe:** no new write. It removes writes: the stolen pipe records, link lists and arrows are no longer rewritten.
   No new regen, view or system-variable change.
6. **Tests (no AutoCAD):**
   1. The rule's truth table.
   2. The switch default through both start-up reads.
   3. The switch OFF gives today's nearest-wins choice exactly.
   4. The `PipeMeetsPitOnSide` result for P3's rows stays true after a copy-on-top (fixture: P3 with five pipes, copy 0.1 mm off).
   5. A source guard that the incumbent check sits only on the clone-relink route.
7. **Note:** `NearestPitPicker` is in `Rules/PitOutline.cs`, inside Drainage, not CE_SHARED. CE_SHARED does not change.

### Part B: one line per pit, said once

1. **Switch:** `linking.scheduleStaleCellLinesOncePerPit`, ON, declared, documented and pinned the same way as Part A.
2. **Where:** `ScheduleCellSkipReport` (`ScheduleCellRefreshGate.cs:227-383`).
   - Group stale-source cells by pit into one line ("Pit schedule row for C1: 7 cells (outlet pipe size, inlet from, inlet
     pipe size) no longer match ... left as drawn.") plus the existing advice line once.
   - In `NewSkipReport` (`ScheduleLinkService.cs:965-982`), gate pits that were NOT touched by this command once per
     drawing per session. Use the same `CopiedScheduleAnnouncements`-style key (drawing identity + document name). A pit
     this command touched is always said.
   - Locked-layer, Xref and REFEDIT lines are unchanged.
3. **Tests:**
   1. Seven C1 cells give one line.
   2. A second refresh in the same session, with C1 not touched, gives no line.
   3. A touched pit is always said.
   4. The switch OFF gives exactly today's per-cell lines.
   5. Both start-up reads.

---

## Robot cases (each with a switch-off control)

### N36_rotcopy_on_pit (Part A), control C36

1. **Setup:** the R34 drawing, `SETTING CD_Settings.json linking.pitCopyKeepsOriginalsPipes true`.
2. **Steps:**
   1. `pick-first` P3 (handle 109D56 in that drawing).
   2. `type _.ROTATE`, base point `53777.7,-25569.9` (the same rounded point tonight's run used), `C`, `90`.
   3. `wait`, then `pick-first` P3 again.
   4. `type _.SCALE`, same base point, `C`, `1.5`.
3. **Checks:**
   1. The command line has no line matching `Pit schedule cell for P3`, after either command.
   2. The CE log for the run has no `Pipe endpoints updated: 10A901 .* to=P11`, nor the same for `10A98D` and `110136`, and no
      `109E23 from=P12` or `110179 .* to=P12`.
   3. A line matching `stay joined to P3` appears once per command.
   4. The R34 label checks (P11, P12) still pass.
4. **Control C36:** the same text with `linking.pitCopyKeepsOriginalsPipes false` and `VARIANT_OF N36`.
   - It must FAIL check 1 (six lines, then nine) and check 2 (`10A901 from=WT9 to=P11` present), as tonight's 3.0.86 run did.

### N37_stale_once (Part B), control C37

1. **Setup:** a drawing whose Pit Schedule has C1's row out of step (the BUG-1231 hand-check drawing, as a robot copy).
2. **Steps:** `type _.COPY` one other pit 5 m away, then `_.ERASE` another, then `_.EXPLODE` a third.
3. **Checks:**
   1. Exactly one line matching `Pit schedule row for C1` across all three commands.
   2. No line matching `Pit schedule cell for C1`.
4. **Control C37:** `linking.scheduleStaleCellLinesOncePerPit false`. It must show the 7 per-cell lines after each command.
