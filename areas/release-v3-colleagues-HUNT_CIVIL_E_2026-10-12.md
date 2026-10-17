# HUNT — Civil E: pits, pipes and network editing (read-only code audit)

**Run:** 17 Oct 2026 (Melbourne), headless Team usage-governor job, desk plan/03. File name carries the job's date (12 Oct) as briefed.
**Code audited:** the installed Civil lineage only, `origin/claude/rel-20261017c` @ `4e2bdfeb` ("Version: Civil 3.0.51 / Manager 1.1.51 (C-40)"), in a private read-only worktree `C:\ce-hunt\civil-e` (removed at the end). Not master.
**Method:** six parallel read-only auditors, one per slice (CD placement; PIT/PITEDIT; PIPEEDIT and cascade; MOVE/COPY/ERASE reactors; relink and repair; split/grips/attachments). Each finding was checked against `BUG_CARPARK.md` and the earlier HUNT, R00_CIVIL and AUDIT_01 files. The controller re-read the code behind the top findings (marked "re-read").
**Status words:** nothing here is built, tested, installed or Tim-accepted. None of these has been seen in AutoCAD. No BUG numbers filed — the controller does that.
**Not covered:** schedule-table refresh after the cascade, Structural, Manager, the PIT/PIPE windows' layout.

---

## FOR TIM — the 10 worst, in plain English

1. **Edit Pipe "Recalculate downstream levels?" wipes out every pit drop.** Lower a pipe arriving at P2 to 9.80 and press Yes. The pipe leaving P2 now also starts at 9.80, with no drop, and the same happens at every pit down the line. It should start at 9.75 (keeping the drop). Yes is the default answer.
2. **A pipe with a blank level throws the cascade out by metres.** If any pipe in the walk has one end with no level yet, CE reads that end as RL 0.00. One test case writes a downstream level of −0.15; another lifts the whole upstream network about 17 m. Affects CDPROPAGATE and Edit Pipe's cascade.
3. **A quiet whole-drawing relink reverses pipes drawn from their low end.** Draw a pipe from P1 (17.80) up to P2 (18.00); CE correctly records it as P2 → P1. Later, an ordinary command (PITEDIT, Edit Pipe, the Inspector) triggers a background relink. That relink resets the pipe to P1 → P2: uphill, and listed as P1's outlet in the Pit Schedule.
4. **Copying a pit or pipe by grip-Ctrl, ROTATE Copy or SCALE Copy makes a "twin" that still thinks it is the original.** Two pits show the same number. Deleting the copy (PITDELETE) deletes the original's label and cover text.
5. **Erasing a copied pipe can erase the original pipe's outline, twin barrels or breakline symbol.** COPY one half of a rising main or same-plan-break pipe, then ERASE the copy: parts of the original vanish.
6. **Erasing a pit label on its own breaks CE's link memory until you reopen the drawing.** After that, moving a pipe no longer moves its labels, and PITDELETE on that pit stops with an error.
7. **Edit Pit Save turns a detention tank back to a square angle.** Place a tank aligned to a pipe at 30°, open Edit Pit, change only the number and Save: the tank snaps to 0°. At about 180° the grate and solid sides swap. This is very likely the cause of BUG-561.
8. **Resizing several pits at once in CDEDIT leaves the pipe ends behind.** Grow two 450 pits to 900: each pipe end stays 225 mm inside the new pit wall, and lengths and labels are not updated. Single Edit Pit does this correctly.
9. **Answering the Uphill Pipe warning in CD leaves the plan and the Pit Schedule disagreeing.** Type 10.00 upstream and 10.50 downstream by mistake, then press Yes to flip. The plan shows the flipped levels, but the schedule row (already written) keeps the old pit order. The schedule and Edit Pipe then give opposite answers for the same pipe.
10. **A hand-typed level kept during the cascade can create a back-fall that the safety check never sees.** The check tests the new numbers, but the drawing gets the kept number, so a pipe can be written 150 mm uphill with no warning.

**What I recommend first:** items 1, 2 and 10 are all in one routine and can all be proven wrong with plain unit tests (no AutoCAD). Fix that routine first; it moves real levels on drawings.

---

## Full findings

Paths are relative to `Modules/Drainage` in the 3.0.51 tree. Each finding gives: where, trigger, wrong vs right, severity, confidence, fix idea, and whether a unit test can show it RED.

### A. Level cascade (Edit Pipe "Recalculate downstream", CDPROPAGATE) — shared routine

A1. **Downstream cascade removes every pit drop** (re-read)
- **Where:** `Services/LinkService.RepairAudit.InvertPropagation.cs:274-278` (downstream branch sets `newCurrentEndIL = currentRepIL`; the upstream branch adds `ComputeDropAtPit`). Reached from `Commands/PipeEditCommand.Update.cs:1906-1986`; CDPROPAGATE's fallback also uses it (`:545-551`).
- **Trigger:** P1→P2 arrives at 10.00, P2→P3 leaves at 9.95. In Edit Pipe change P1's downstream level to 9.80, Save, Yes, Apply.
- **Wrong vs right:** P2→P3 starts at 9.80 (no drop), and every pit below loses its drop the same way. It should start at 9.75. This breaks the locked rule "upstream change → hold the fall and re-base downstream", and the 5 mm default pit drop.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** at each pit in the downstream walk, subtract the existing drop (the drop table at `:162-169` is already built), or the default drop when none is found.
- **Unit test RED:** yes. Use the public `BuildPropagationPlan(NetworkGraph, anchor, 9.80, db:null, Downstream, null)` with a two-edge graph and expect 9.75.

A2. **A blank level is read as RL 0.00**
- **Where:** `Services/LinkService.RepairAudit.Graph.cs:212-232` (missing level → 0). In `InvertPropagation.cs:218` a pipe is only skipped when both ends are 0; `:228-229` then treats the whole level as the fall. The drop calculation at `:163-169` and `:402-421` takes 0 as the "lowest IL" at the pit.
- **Trigger (Edit Pipe):** P2→P3 upstream 9.95, downstream blank. Edit P1 to arrive at 9.80, Yes. **Trigger (CDPROPAGATE):** the LPD has inlet A (18.00/17.50) and a stub pipe B with no levels; run from the LPD at 17.40.
- **Wrong vs right:** in the first case P2→P3's downstream is written as −0.15, and everything below re-bases from that. In the second, A's "drop" becomes 17.50, so A's downstream becomes 34.90 and the upstream network rises about 17.5 m (or a negative grade blocks the whole run). The right result is to skip and name any pipe with an unknown end, as already happens for a pipe with no levels at all.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** carry "known" flags (or NaN) for each pipe end, leave unknown ends out of the drop, and stop the walk at them.
- **Unit test RED:** yes, the same pure overload.

A3. **A kept hand-typed level can write a back-fall past the flat-grade block**
- **Where:** `Models/PropagationPlan.cs:51` and `:147` (`IsFlatOrNegative` and `HasBlockingFlatGrade` test the NEW levels); `:91-96` (Apply writes the effective levels); `InvertPropagation.cs:335-339` and `:606-620` (the walk carries the new levels on).
- **Trigger:** P2→P3's upstream was typed by hand at 9.95 and its downstream is 9.85. Raise P1 to arrive at 10.20 and accept. Edit Pipe uses Keep without asking; CDPROPAGATE uses it when you press Enter.
- **Wrong vs right:** P2→P3 is written 9.95 → 10.10, a 150 mm back-fall. The check passed it because it compared 10.20 with 10.10. P3→P4 is re-based from a level the preview showed but that was never written. Either the levels actually written are checked (and blocked), or the walk stops at a kept end.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** test `Effective*IL` in the flat check, and continue from the effective level.
- **Unit test RED:** yes, on a `PipeUpdate` record with `DownstreamManuallySet`.

A4. **Downstream cascade ignores the other pipes arriving at a junction**
- **Where:** `InvertPropagation.cs:186-199` and `:274-278`.
- **Trigger:** P1→P3 arrives at 9.85, P2→P3 at 9.80, and P3→P4 leaves at 9.78. Raise P1's downstream to 10.00 and accept.
- **Wrong vs right:** P3→P4 starts at 10.00, so P2 now arrives 200 mm below the outlet. There is no warning in the preview or after Apply. The batch "Carry downstream" already uses the lowest arriving level; this path should too.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** use the lowest arriving level at the pit minus the drop, and warn as the batch does.
- **Unit test RED:** yes, with a three-edge graph.

A5. **The cascade re-links every pipe in the drawing, not just the previewed ones**
- **Where:** `InvertPropagation.cs:682` → `Services/LinkService.Geometry.cs:930-950`; `Services/RelinkedPipeRecordWriter.cs:156` writes with `respectOverride:false`.
- **Wrong vs right:** From/To and levels on pipes the preview never listed can be rewritten in the same Undo step. Only the plan's pipes should be relinked.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE (no case proven where the two stores differ).
- **Fix:** relink only the plan's pipes.
- **Unit test RED:** no.

A6. **The cascade can change one end's level text but not the record**
- **Where:** `InvertPropagation.cs:806-816` with `:627-634`.
- **Trigger:** the first level text can be written, but the second is on a locked layer.
- **Wrong vs right:** the first text shows the new value while the pipe's record keeps the old one. Both should be checked as writable before either is written.
- **Severity:** LOW. **Confidence:** CONFIRMED.
- **Unit test RED:** no.

A7. **The cascade question and preview open inside Edit Pipe's open drawing change**
- **Where:** `Commands/PipeEditCommand.Update.cs:524` → `:1906-1908` (the comment at `:335-337` says questions come after it closes).
- **Wrong vs right:** if the save is then refused (for example a locked label layer), "[CDEDIT-CASCADE] Updated N pipes" has already been printed and is false. Nothing is corrupted.
- **Severity:** LOW. **Confidence:** PLAUSIBLE.
- **Fix:** ask and apply after the edit commits, inside the same command (one Undo).

### B. Relink, repair and network records

B1. **Whole-drawing relink reverses the flow direction of pipes drawn from their low end** (re-read)
- **Where:** `Services/LinkService.RepairAudit.Linking.cs:83-127` (start owner → From, then `UpdatePipeEndpointsByHandle`), plus `:303-305` and `:372`. `Rules/RecordedPipeDirectionRule.cs:24-27` keeps drawn order unless `keepRecordedDirection` is set, and only Edit Pipe's save sets it. Callers: `Services/ProjectDataService.cs:852-853`, `ViewModels/PitScheduleViewModel.Data.cs:974-975` and `:2872-2873`, CDSYNC (`Commands/LinkCommands.cs:172-181`), CDUPGRADE (`:1098-1099`), CDREPAIR (`Services/LinkService.RepairAudit.Relink.cs:221`).
- **Trigger:** CD from P1 (IL 17.80) up to P2 (IL 18.00); CD records it as From P2, To P1 (`Commands/CdCommand.Schedule.cs:66`). Then do anything that makes the drawing-data merge run (a plain PLINE on the pipe layer, a pasted pit), and open PITEDIT, Edit Pipe or the Inspector.
- **Wrong vs right:** the record becomes From P1 17.80 → To P2 18.00. It runs uphill and is listed as P1's outlet in the Pit Schedule. It should stay From P2 → To P1.
- **Severity:** HIGH. **Confidence:** CONFIRMED by reading.
- **Related:** BUG-278 and BUG-268. BUG-278 was fixed only for the Edit Pipe save; these drawing-wide passes still use drawn order.
- **Fix:** use the recorded (level-based) direction in `UpdatePipeEndpointsFromProjectData` and `RelinkAllPipesToPits`.
- **Unit test RED:** yes. `RecordedPipeDirectionRule.FirstEndIsFrom(false, "P2", "P1", "P1", "P2")` returns true (P1 = From).

B2. **A pit relink takes a skipped pipe off the pit's own list**
- **Where:** `Services/LinkService.RepairAudit.Relink.cs:726-738` (the list is cleared and committed first), then `:783-794` and `:800-832`.
- **Trigger:** a relink of a pit that already lists pipes, while one listed pipe (or its far pit) is on a locked layer, or any error occurs.
- **Wrong vs right:** the pipe is "left as drawn" but has already been removed from the pit's list, which MOVE uses to carry pipes (`Services/LinkService.PipeMoveHelpers.cs:189`). Later MOVEs leave that pipe behind. The list should only lose pipes whose relink succeeds.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.
- **Related:** BUG-357 (that one is about label wording, not link loss).

B3. **PIPEPITLINK / CDPIPEOVERRIDE pick the wrong pipe end in a rotated UCS**
- **Where:** `Commands/LinkCommands.cs:1285-1292`; `Services/PipePickService.cs:53`.
- **Trigger:** a site-aligned (rotated or moved) UCS; pick near a pipe end.
- **Wrong vs right:** the pick point is in UCS but the vertices are in world coordinates, so the far end can be chosen and From/To written wrongly. The pick should be converted to world first, as `PitCommand.Orientation.cs:133` does.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED. A specific case of BUG-017.

B4. **CDUPGRADE "Merge" strips data from every pipe row**
- **Where:** `Commands/LinkCommands.cs:1061-1093`; `Services/ProjectDataService.Mutations.cs:755-760` replaces the whole row.
- **Wrong vs right:** it drops the typed-by-hand flags, the From/To pit keys, the system, fit openings and design flow. Later automatic writers then overwrite hand-typed levels. Merge should change only what the scan proves.
- **Severity:** MEDIUM (data loss). **Confidence:** CONFIRMED. The command is hidden from the ribbon but can still be typed.

B5. **CDREPAIR attaches a stray pit label up to 5,000 drawing units away (5 km in a metre drawing)**
- **Where:** `Services/LinkService.RepairAudit.Relink.cs:187-188`.
- **Wrong vs right:** in a metre drawing, a stray PIT LABEL is attached to whichever pit is nearest, anywhere on the job. The reach should be 5 m, converted to drawing units.
- **Severity:** LOW-MEDIUM. **Confidence:** CONFIRMED. Same family as BUG-270; this line is not on its list.
- **Unit test RED:** yes, once the distance is units-converted.

B6. **A pit rename leaves the old name in its pipes' ownership notes**
- **Where:** `Commands/PitEditCommand.cs:1839-1862` and `UpdatePitIdByHandle` (`ProjectDataService.Mutations.cs:1537-1575`) rename only From/To. The relink still reads `ExplicitFromPitId`/`ExplicitToPitId` (`LinkService.RepairAudit.Linking.cs:425-453`). New numbers fill gaps (`Mutations.cs:1804-1818`).
- **Trigger:** rename P5 → P9; place a new pit (it becomes P5); then a relink or CDREPAIR runs.
- **Wrong vs right:** the pipe end jumps to the new, distant P5. It should stay with P9.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.

### C. MOVE / COPY / ERASE and the link reactors

C1. **Grip-copy, ROTATE Copy and SCALE Copy make clones that keep the original's identity** (re-read)
- **Where:** `Services/ExternalMutationCommandPolicy.cs:13-46` lists GRIP_*, ROTATE and SCALE as transform-only, so `LinkService.Reactors.cs:52-56` never records their clones, and the copy clean-up (`LinkService.Utilities.cs:1230`) never runs.
- **Trigger:** select a pit, click its grip, hold Ctrl and click elsewhere. ROTATE → C and SCALE → C do the same.
- **Wrong vs right:**
  - The copy keeps the original's handle, pipe list and label list, and gets no schedule row or label of its own.
  - PITDELETE on the copy erases the original's label and cover text (`LinkService.cs:522-538` has no owner check).
  - A pipe copy takes over the original's entries in the cache (`Cache.cs:268-290`), so a later MOVE of the original's label is refused as "conflicting".
  - Right: the same clean-up a COPY gets.
- **Severity:** HIGH. **Confidence:** CONFIRMED in code. This assumes AutoCAD reports the copy under the GRIP_*, ROTATE or SCALE command name, which is usual.
- **Fix:** whenever a deep clone fires during these commands, record the clone ids and the copy map.
- **Unit test RED:** yes. `ExternalMutationCommandPolicy.CanCreateClones("GRIP_STRETCH")` returns false.

C2. **Erasing a copied pipe erases the original's outline, twin barrels or breakline symbol**
- **Where:** `Services/LinkService.Compound.cs:218-227` (`Take(...)` with no expected owner, so `SafeEraseHandle` skips its owner check). `RemapClonePipe` (`LinkService.Utilities.cs:787-806`) never clears `BreaklineGlyphHandle`, `SecondaryBreaklineGlyphHandle`, `LinkedHalfPipeHandle` or `SamePlanBreakPartnerHandle`.
- **Trigger:** COPY one half of a rising-main or same-plan-break pipe, then ERASE the copy. A grip-copied pipe (C1) does the same after a U or a reopen.
- **Wrong vs right:** the original's band, barrels and breakline symbols are erased. A MOVE of the copy also drags the original's symbol. Only members whose owner tag names the erased pipe should be erased.
- **Severity:** HIGH (silent loss of drawing content). **Confidence:** CONFIRMED.
- **Fix:** pass the root handle as the expected owner, and remap or clear the four fields in `RemapClonePipe`.
- **Unit test RED:** yes, once the field remap is a pure rule.

C3. **Erasing a pit label on its own breaks the link caches for the rest of the session** (re-read)
- **Where:** `Services/LinkService.Cache.cs:579-586` (and `:667-674` for sources). `TryGetObjectId` (`LinkService.Utilities.cs:3098`) returns ids of erased objects too, so the `tr.GetObject(..., ForRead)` that follows throws "was erased". `RebuildRuntimeCaches` has already cleared every cache (`:872-884`) and is not protected. The same applies in `LinkService.cs:524-527` (PITDELETE).
- **Trigger:** ERASE a pit's number label or cover text on its own, then press U after any later command, or open a CE editor whose idle refresh falls back to a full rebuild.
- **Wrong vs right:** the rebuild stops partway, so later pits, all sources and every pipe-member entry stay empty until the drawing is reopened. Pipe MOVE and STRETCH stop moving labels, erases leave dangling links and schedule rows, and PITDELETE on that pit fails with "Error during PITDELETE". Erased attachments should be skipped, as `MovePitAttachments` already does (`PipeMoveHelpers.cs:297`).
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** check `IsErased` (and catch the error) in both cache readers and in `DeletePitAndAttachments`.
- **Unit test RED:** no; needs the headless AutoCAD harness.

C4. **Pipe callouts land in the wrong place after a MOVE or ROTATE of a run**
- **Where:** `Services/LinkService.PipeAttachmentUpdates.cs:171-200`, via `Reactors.cs:1123` → `ApplyExternalModifiedPipeUpdates`.
- **Trigger:** MOVE pits, pipes and callouts together 5 m along the pipe, or ROTATE the run 90°. (A single straight pipe goes through the newer route and is not affected.)
- **Wrong vs right:** the saved arrow point is never transformed by AutoCAD, so it is projected onto the moved pipe at the wrong position (or the pipe end), and that wrong position is saved. The callout should keep its position along the pipe.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** shift the saved points by the pipe's own move, or trust the stored position along the pipe after a native transform.

C5. **A pit's labels stop following on the second move outside a tracked command**
- **Where:** `Services/LinkService.PipeMoveHelpers.cs:330-345`. `PitAttachmentsFollowedThisCommand` is cleared only by tracked commands (`Reactors.cs:818`, `1518`, `1624`, `1740`).
- **Trigger:** move a pit twice by a route other than MOVE, STRETCH or grips (the Properties palette, or CD's detention "MovePit") before any tracked command runs.
- **Wrong vs right:** on the second move the labels stay behind. They should follow every time.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.
- **Fix:** clear the set at every command start, or scope it to the call.

C6. **CDREBUILD permanently cuts an old copied pit off from its own labels**
- **Where:** `Services/LinkService.CloneRepair.cs:117-131` (calls `RemapClonePit` with an empty copy map). The BUG-346 recovery (`MakePitItsOwn`, `Registration.cs:481-489`) never fires afterwards.
- **Trigger:** an older drawing with a pit copied before CE re-mapped copies. Run CDREBUILD, then MOVE that pit.
- **Wrong vs right:** the label and cover text stay behind, and even CDREPAIR cannot reconnect them. CDREBUILD should use `MakePitItsOwn`, as CDREPAIR does.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

C7. **A pipe copied with only some of its labels gets the rest silently left off**
- **Where:** `Services/LinkService.CloneRegeneration.cs:75-113`.
- **Trigger:** COPY a pipe and only its size label, with a crossing window.
- **Wrong vs right:** because one label was copied, the level texts and flow arrow are not redrawn, and nothing is said. Each missing piece should be drawn.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, once the decision is extracted.

C8. **One locked pit-annotation layer stops every annotation on a copied pit**
- **Where:** `Services/LinkService.CloneRegeneration.cs:288-298` (returns 0 for the whole pit).
- **Trigger:** lock only the cover-text layer, then COPY a pit.
- **Wrong vs right:** the copy gets no number label either. It should copy what sits on open layers and report the one it skipped.
- **Severity:** LOW. **Confidence:** CONFIRMED.

C9. **`DisplacementCache` is keyed by the raw Database wrapper**
- **Where:** `Services/LinkService.PipeMoveHelpers.cs:229-240`.
- **Wrong vs right:** on AutoCAD 2027 every lookup misses, and the static map grows for the whole session. It should use `DatabaseIdentityComparer.Instance` and be cleared when the drawing closes.
- **Severity:** LOW. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, with a guard test for `Dictionary<Database,` without the comparer.

### D. Pit placement and Edit Pit

D1. **Edit Pit Save turns a detention tank back to its stored quarter-turn — likely cause of BUG-561**
- **Where:** `Commands/PitEditCommand.cs:1192-1195` and `2103-2116` (`ResolveDetentionRotation` prefers the stored text over the block's real rotation); `2118-2127` (written back on every Save through `UpdatePitBlock` at `:1258`). `Commands/PitCommand.cs:839-840` stores the dialog's "0 deg" even when Align to pipe or Align to building set a real angle (`PitCommand.Orientation.cs:47-105`).
- **Trigger:** place a detention pit with Align to pipe at 30° (or ROTATE a tank afterwards), open Edit Pit, change only the number or cover, then Save.
- **Wrong vs right:** the tank snaps to 0° or 180°. At about 180° the grate and solid sides swap, which is BUG-561's symptom. The tank should keep its drawn angle.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Related:** BUG-561 (its cause is still listed as unknown). A fix commit exists, `e54b0aa5` ("BUG-561: a number-only Edit Pit Save no longer swaps the detention pit's grate and solid-cover sides"), but it is NOT in the installed 3.0.51 tree. Nobody has checked whether it also covers the "align to pipe at 30° squared to 0°" case found here; whoever reviews it should test that case specifically.
- **Fix:** for detention, start from the block's real rotation, and only rewrite rotation when the lid-layout or rotation fields changed.
- **Unit test RED:** yes, once `ResolveDetentionRotation` is internal: stored "0 deg" with a block rotation of π gives a target of 0.

D2. **Resizing several pits at once never re-trims the pipe ends** (re-read)
- **Where:** `Commands/PitEditCommand.Batch.cs:625-647` and `708-714`. Only single Edit Pit (`PitEditCommand.cs:418`) and Resize (`PitEditCommand.Resize.cs:141`) call `LinkService.ReSnapLinkedPipesToPitBoundary`.
- **Trigger:** select two 450 pits, CDEDIT, tick Plan length/width = 900, Apply.
- **Wrong vs right:** the pipe ends stay 225 mm inside each grown pit (or stop short of a shrunk one), and lengths and labels are stale. They should be re-trimmed, as in single Edit Pit.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** after the batch commits, call the re-snap for each resized pit, in the same command.
- **Unit test RED:** no; a guard test can assert that the call exists.

D3. **The pit-fit check (CD → Upsize) ignores pit rotation**
- **Where:** `Commands/CdCommand.PitFit.cs:43-45` and `:71-74`; `Services/PipeFitsPitRule.cs:58-67`. (Found independently by two auditors.)
- **Trigger:** a 600 (X) × 900 (Y) pit rotated 90°; draw a 750 pipe along world X into it.
- **Wrong vs right:** the check compares against 900 and passes, but the real entry wall is 600. At other angles, Upsize enlarges the wrong side of the pit on the drawing and in the schedule.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** rotate the pipe direction into the pit's own frame (`PitData.RotationRadians`) before choosing the wall.
- **Unit test RED:** yes, once the pure rule takes a rotation.

D4. **Edit Pit Save (and CD Upsize) overwrites the lid wording**
- **Where:** `Commands/PitEditCommand.cs:1199` and `2236-2247` (keeps one letter, defaulting to "C"); `:1819` writes the rebuilt `GetLidTypeForSchedule()` (`ViewModels/PitViewModel.cs:1290-1316`); the same from `PitEditCommand.Resize.cs:143`.
- **Trigger:** lid typed in the schedule as "Class D Heelguard Grated Lid", "D400" or "Class-D"; Edit Pit changing only the cover.
- **Wrong vs right:** it becomes "Class D Grated Lid", or "Class C Grated Lid" for unrecognised wording — a silent downgrade of a trafficable lid on the schedule. The lid should be left alone unless the lid field was edited.
- **Severity:** MEDIUM-HIGH. **Confidence:** CONFIRMED.
- **Unit test RED:** yes (pure parsing plus view-model round trip).

D5. **Batch edit gives every pit without a CE record the same "next" number**
- **Where:** `Commands/PitEditCommand.cs:1181` (`GetNextPitId()`), called for each target at `Batch.cs:521-533` before any write; `AddPit` then deletes the other row with that number (`ProjectDataService.Mutations.cs:374-380`).
- **Trigger:** CDEDIT on two or more pits that have no record (old or recovered drawings), with "Pit label block" ticked On.
- **Wrong vs right:** both get, say, P12, and the batch is refused with "has different saved data". With one such pit, its drawn "P7" is overwritten to "P12" (`Batch.cs:735-743`). Each pit should get its own number, or keep the drawn one.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, once the no-record branch of `BuildPitData` is internal.

D6. **Label and cover text step the wrong way when a rotated pit is resized**
- **Where:** `Helpers/PitAnnotationShift.cs` (`ComputeShiftedPosition` works in world X/Y); used at `PitEditCommand.cs:1427`, `1483`, `1687` and `Batch.cs:938`.
- **Trigger:** a pit rotated 90°; Edit Pit X 600 → 1200.
- **Wrong vs right:** the text moves 300 in world X while the pit grows in world Y, so the text ends up inside the pit walls. It should move out along the pit's own axes.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** yes (pure helper, add a rotation input).

D7. **Rotating a pit in Edit Pit leaves its pipes behind, and the Align options do nothing**
- **Where:** `PitEditCommand.cs:413-418` re-snaps pipes only on a size change. `ApplyPitRotationTransform` (`:2118-2134`) reads only the manual angle, yet `Dialogs/PitDialog.xaml:383-403` still offers Align to pipe/building.
- **Wrong vs right:** after a 0 → 90 rotation, pipe ends are left inside or short of the walls. Picking Align to building does nothing, but "Pit updated." is still printed. Pipes should be re-snapped on rotation, and the Align modes hidden or made to work in edit mode.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

D8. **CD Upsize can take another pit's number without the duplicate check**
- **Where:** `Commands/PitEditCommand.Resize.cs:96-97` and `:143` (uses the label text as the id). Edit Pit refuses clashes at `PitEditCommand.cs:593-596`.
- **Trigger:** the record says P5 but the label attribute says P8 (another pit), for example after a direct attribute edit; then CD into the pit and choose Upsize.
- **Wrong vs right:** P8's record is deleted and this pit becomes P8. It should be refused, or keep its own record number.
- **Severity:** HIGH if it triggers. **Confidence:** PLAUSIBLE.

### E. CD — drawing a new pipe

E1. **Uphill warning: Yes (flip) or Point Order mode leaves the schedule, the stored levels and the plan disagreeing**
- **Where:** `Commands/CdCommand.cs:731` writes the schedule row before the flip at `:836`/`:863`; `LinkService.FlipPipeInverts` (`RepairAudit.InvertPropagation.cs:1348-1394`); the From/To choice is in `CdCommand.Schedule.cs:54-73`.
- **Trigger:** "draw the route first" switched off. CD P1 → P2, upstream 10.00, downstream 10.50, then Yes in the Uphill box.
- **Wrong vs right:** the plan shows P1 10.50 → P2 10.00, but the schedule row keeps From P2 10.50, To P1 10.00, and `UpdatePipeInvertsByHandle` changes nothing. In Point Order mode the stored levels swap but the plan text is not redrawn. "No, convert to Rising Main" (`:949`) never sets the rising-main destination. From/To and both levels should be set together after the decision.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Related:** HUNT-C-13 (that one is about the box appearing for a flat pipe; this is the result after answering it).
- **Fix:** ask the uphill question before anything is written (the levels are already known).

E2. **Cancel in the Uphill box says "Pipe cancelled and erased" but leaves earlier changes behind**
- **Where:** `Commands/CdCommand.cs:856`; the side effects are at `:723` (source polyline erased), `:731` (schedule row), `:739` (branch junction), `:405` (pit upsized) and `:426` (detention MovePit).
- **Wrong vs right:** only the pipe's own entities are erased. The drafter's polyline stays erased, the pit stays upsized or moved, and twin barrels may remain. Cancel should put everything back. (One U does reverse the whole command.)
- **Severity:** MEDIUM-HIGH. **Confidence:** CONFIRMED for the polyline, PLAUSIBLE for the schedule row.

E3. **Same-plan break: the worked-out level and the grade label use the drawn length, not the real length typed afterwards**
- **Where:** `Commands/CdCommand.cs:476-540` and `:586`; the real length is asked later in `CdCommand.SamePlanBreak.Atomic.cs:106`; `LinkService.SamePlanBreak.Apply/.Finalize/.Pair.cs` never re-work the level.
- **Trigger:** 1 in 100, upstream 20.00, 20 m drawn, real length typed as 50 m.
- **Wrong vs right:** the downstream end is drawn at 19.80 and labelled over 20 m. It should be 19.50 over 50 m. The worked-out level is never corrected.
- **Severity:** HIGH. **Confidence:** CONFIRMED by reading.
- **Fix:** ask for the real length before working out the level, or re-work it after the break is committed.

E4. **"Existing line" straightens arcs, drops a closed polyline's last side, then erases the original**
- **Where:** `Commands/CdCommand.ExistingLine.cs:159-161` (vertices only; bulge and Closed flag ignored) and `:253-288` (source erased).
- **Wrong vs right:** the pipe follows the chords, so it is shorter, and its grade, length label and worked-out level use that shorter length. The source line is then erased. Arcs and closed polylines should be refused (or warned about), and the source line kept.
- **Severity:** HIGH. **Confidence:** CONFIRMED.

E5. **"Work it out from the grade" rounds the level the drafter typed** — NEEDS TIM'S RULING (re-read)
- **Where:** `Helpers/MathHelper.cs:319-333` (`inlet = Math.Round(rawInlet, safeDecimals)`), reached from `CdCommand.cs:516` and `Rules/RulebookCalculations.cs:25`.
- **Trigger:** calculated decimals = 2, upstream typed 10.125, 1 in 100 over 10 m.
- **Wrong vs right:** the typed end becomes 10.13 and the other end 10.03. The code comment says "the known end is held exactly", and INT-059 item 23 says a typed level is never moved. However, the rulebook locks invert levels to 2 dp / nearest 10 mm. So whether 10.125 → 10.13 is a bug depends on which rule wins.
- **Severity:** MEDIUM until ruled. **Confidence:** CONFIRMED (code behaviour).
- **Unit test RED:** yes. `MathHelper.ApplyCalculatedInvertRule(10.125, 10.025, 2, 20, preserveInlet:true)` returns 10.13.

E6. **A level of exactly 0.00 makes the flow arrow ignore the levels** (re-read)
- **Where:** `Services/PipeCreationService.PreparedOutputs.cs:267` (`FirstInvert != 0 && SecondInvert != 0`).
- **Trigger:** a coastal job: first level 0.00, second 0.50.
- **Wrong vs right:** the arrow follows drawing order and points uphill, while the level labels say the opposite. Negative levels work; only exactly 0 fails.
- **Severity:** LOW-MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, through `ResolveArrowFlowInverts` with levels 0 and 0.5.

### F. Edit Pipe (other than the cascade)

F1. **Changing only the design flow (Q) in Edit Pipe is thrown away**
- **Where:** `Commands/PipeEditCommand.cs:295-408`. `HasDialogChanges` never compares `FlowLps`, so the save at `Update.cs:1865-1868` is never reached.
- **Wrong vs right:** "No changes detected - pipe unchanged." The Q is lost. It should be saved.
- **Severity:** MEDIUM (data loss). **Confidence:** CONFIRMED.
- **Unit test RED:** yes, if `HasDialogChanges` is made internal.

F2. **Batch Design grade rolls back the whole batch when a held end's level text is switched off**
- **Where:** `Commands/PipeEditCommand.Batch.cs:721-722`, `1520-1531` and `481` (count the level as known) versus `Update.cs:363-366` and `412-414` (need the text Enabled or Hidden).
- **Wrong vs right:** the preview shows "IL 9.95 (held)", then Apply throws "needs an Upstream value" and every pipe in the batch is rolled back. The held end should be switched on, as is already done for carried pipes (`PutInheritedUpstreamLevel`).
- **Severity:** MEDIUM (refuses real work). **Confidence:** PLAUSIBLE.

F3. **Batch Design grade that works out an upstream level never checks pipes arriving at that pit**
- **Where:** `Commands/PipeEditCommand.Batch.Cascade.cs:599-656` and `743-760`.
- **Trigger:** P2→P3 has only its downstream level (9.00); P1→P2, not selected, arrives at P2 at 9.20. Apply 1 in 100 to the 30 m P2→P3.
- **Wrong vs right:** P2→P3's upstream is written as 9.30, so P1 arrives 100 mm below the outlet, with no warning. The usual back-fall warning should name P1→P2.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** yes (the clash builders are pure).

### G. Split (pit placed on a pipe), crossings and attachments

G1. **Placing a pit on a pipe leaves the old pipe's connection decisions and junctions on the wrong half**
- **Where:** `Services/LinkService.Split.cs:1523-1788` (inline route). The tracked route moves these via `SourceChangeDecisionPolicy.cs:66-80`; the inline route does not. They are read at `LinkService.Spine.cs:301-315` and `BranchJunctionDisplay.cs:73-96`.
- **Wrong vs right:** the first half keeps the end decision naming the far pit, so the network check reads it as still ending at P3. A junction past the split silently disappears from the schedule (`Rules/BranchJunctionDisplay.cs:114`). Decisions and junctions should move to the half they sit on.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, once the transfer is pure.

G2. **Splitting one half of a breakline, same-plan-break or twin detention pipe gives a wrong level and breaks the pairing**
- **Where:** `Services/LinkService.Split.cs:1548-1553`, `1697-1709` and `1888-1909`. There is no paired-pipe guard like `HasUnsupportedTrackedSplitLinks` (`:1164`), whereas the same-plan code refuses (`SamePlanBreak.cs:68-70`).
- **Trigger:** a pipe broken across plans (6 m + 4 m, levels 20.00 → 19.90 on both); place a pit 3 m along the 6 m half.
- **Wrong vs right:** the split level is 19.95 (worked over 6 m). The right level is 19.97 (over the whole 10 m). The partner link, breakline glyph and real length stay on the wrong half, and the grade label is then wrong.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** refuse paired pipes on this route with one plain line, as the other routes do.

G3. **A callout label can go to the wrong half after a split**
- **Where:** `Services/LinkService.Split.cs:1628-1630` and `1016-1019` choose the half from the text position; `SegmentAnalysis.cs:180-228` uses the arrow point.
- **Wrong vs right:** with the arrow on one side of the new pit and the text pulled across to the other, the callout goes with its text. It should follow its arrow point.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

G4. **Splitting a pipe that has an arc draws wrong curves on both halves**
- **Where:** `Services/LinkService.Split.cs:2280-2333` (arcs never reset); `:1590`; chord stations at `:2007-2058`.
- **Wrong vs right:** both halves get the wrong curves. Curved pipes should be refused, as `SamePlanBreak.cs:76-77` already does.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

G5. **A level typed in the Pit Schedule on a breakline pipe updates one half only**
- **Where:** `Services/LinkService.ScheduleLevels.cs:59-134`; `ViewModels/PitScheduleViewModel.Data.cs:1870-1885` turns off the pass that would copy it.
- **Wrong vs right:** the hidden other half keeps the old levels. Both halves should take the new level, through `MirrorGradeLockToPartnerHalf`.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.

G6. **Downpipe on a run reports its chainage 1,000 times too small in a metre drawing**
- **Where:** `Services/LinkService.Split.cs:82` → `LinkService.NewPipeEnds.cs:292-311`.
- **Wrong vs right:** the message says "0.01 m from its start" instead of "12.50 m". Only the reported figure is wrong.
- **Severity:** LOW-MEDIUM. **Confidence:** CONFIRMED.

G7. **In a metre drawing, a crossing within 1 m of either end is never offered a split**
- **Where:** `Rules/PipeCrossingSplitPolicy.cs:46` and `:64-65` (1.0 treated as mm, fed drawing units by `LinkService.CrossingSplit.cs:38` and `:68`).
- **Severity:** LOW. **Confidence:** CONFIRMED.
- **Unit test RED:** yes. `PipeCrossingSplitPolicy.Splittable` with station 0.8 and length 30 drops the crossing.

---

## Already known — deliberately not repeated

1. BUG-160 (grade-held end grip drag) — the code path is still as described in the carpark.
2. HUNT-C-05 (10% mismatch tolerance), HUNT-C-06 (schedule rounding), HUNT-C-13 (uphill box on a flat pipe).
3. R00_CIVIL items 13, 14, 20, 54 and 55 (FLAT tolerance, pit-drop values, 20 mm default drop, mm values used as drawing units).
4. BUG-427 discussion (Custom grade label shown as typed).
5. Compound overrules: dead code (`PluginInitialization.cs:139-146`, wrapped in `if (false)`), so not audited.

## Unit tests that can go RED today, without AutoCAD

1. A1, A2, A3 and A4 — `BuildPropagationPlan` graph overload and `PipeUpdate`.
2. B1 — `RecordedPipeDirectionRule`.
3. C1 — `ExternalMutationCommandPolicy.CanCreateClones("GRIP_STRETCH")`.
4. E5 — `MathHelper.ApplyCalculatedInvertRule`.
5. E6 — `PipeCreationService.ResolveArrowFlowInverts`.
6. F3 — the batch clash builders.
7. G7 — `PipeCrossingSplitPolicy.Splittable`.
8. D3, D6 — once the pure rules take a rotation.

## Summary

This read-only hunt of the installed Civil 3.0.51 code found 46 defects in pit and pipe placement, editing and network linking. Two pairs, reported by two auditors each, are merged here. About 20 are HIGH, meaning wrong levels or sizes on the drawing, lost drawing content, or a broken session. None had been seen in AutoCAD, and only BUG-561 (detention tank rotation, now with a likely cause) was already filed.

The biggest risk is one shared level-cascade routine, used by Edit Pipe's "Recalculate downstream" and by CDPROPAGATE. It removes pit drops, reads blank levels as RL 0.00, ignores other pipes arriving at a junction, and lets kept hand-typed levels create back-falls past the flat check. All four can be proven RED with pure unit tests and fixed in one place.

The next most serious problems are:
1. A background relink that silently reverses pipes drawn from their low end.
2. Grip/ROTATE/SCALE copies that keep the original's identity, plus copy-erase deleting the original's parts.
3. An erased pit label that breaks the link caches for the session.
4. Batch pit resize that never re-trims pipes.
5. Edit Pit resetting detention tank rotation.

One item (E5, rounding a typed level to 2 dp) needs Tim's ruling, because two of his rules conflict there. Nothing was built, run or installed.
