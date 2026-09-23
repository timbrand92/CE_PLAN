# Structural D1 card (draft) — two beams on one column, their labels, grips and one member schedule

**Status:** draft for Tim's review on **Tuesday 29 September 2026**. Drafted by Claude, 23–24 September 2026 (Melbourne).
**What it is:** the "D1" step of the Structural plan: the reviewed workflow card for the first connected-framing piece, "D2".
**What it is not:** nothing here is built, installed or Tim-accepted. No code starts until Tim approves this card.
**Plan it serves:** `04_REFERENCE\structural\STRUCTURAL_DELIVERY_PLAN_2026-09-14.md`, "Delivery order and checks", D1 and D2.

---

## FOR TIM

### 1. What this card covers

1. **The piece of work:** two beams sitting on one shared column, each beam with its own label, grips that move things
   together or one at a time, and one member schedule that stays right.
2. **Why this one first:** you said on 23 Sep, *"let's focus on sort of the stuff that's already there and making that
   better. And then we'll move on to the new additions."* D2 improves beams 1, 2 and 4, which already work. It adds no new
   drawing commands.
3. **What you do on Tuesday:** tick or change the 12 choices in section 3, then approve or change the test drawing in
   section 5. About 15 minutes.

### 2. What works today, in drawing terms

Read from the code on the shipping Structural line (details for the builder are below the line).

1. **Placing a beam with 1, 2 or 4: works.** You pick the supports or points, see a preview, and the beam and its label
   go in as one step. Escape leaves nothing; one Undo removes it. CE also quietly records which two supports the beam sits
   on and which label is its own.
2. **Command 5 and BDL: still the older route.** They draw correctly, but they record no supports and no owned label
   unless "beam linking" is switched on in command 8. It has been off since 3 June 2026.
3. **Moving things together afterwards: switched off.** The old "move a column and the beam ends follow" behaviour still
   exists but is dormant. Commands 1, 2 and 4 refuse to run if you switch it back on.
4. **COPY: wrong for connections.** Copying a beam today throws away its label and support connections, and the copy
   needs BEAMLINKMIGRATE. Your approved rule is the opposite: the copy keeps its own copied label and gets no supports.
5. **The beam panel: read-only, and inside Civil's palette.** Selecting a beam can show its label and supports on the
   Structural page of the CE Inspector palette. It cannot change anything yet. That palette is Civil's, so it only exists
   when Civil is loaded too.
6. **Grips: missing.** Structural beams only have AutoCAD's ordinary line grips. There is no "Edit together / Edit this
   only" choice anywhere yet.
7. **Member schedule: only the imported one.** XCLMTXT brings the engineer's Excel schedule onto the drawing and
   remembers its rows (mark, size, type, note). Today only the support commands (DS, C1 and so on) read it, to suggest a
   size. Beams do not know which row is theirs, and nothing updates the schedule when a beam changes.
8. **A permanent name for each beam: missing.** Structural knows a beam only by AutoCAD's internal number, which changes
   on COPY, WBLOCK and INSERT. Civil pits and pipes already carry a permanent CE name that survives those.

### 3. Choices for Tuesday (12)

Each one says what I recommend and why. Anything you already ruled on is in section 4 and is not asked again.

**A. The permanent name**

1. **One permanent name system for Civil and Structural.**
   - **Recommend:** use the one Civil pits and pipes already carry (the "spine" name that CDSPINEUPGRADE writes). It
     already has a Structural slot. Each beam and each column gets its name the moment it is drawn, inside the same Undo.
   - **On a job:** copy B1 to make a third beam. The copy gets a new permanent name, the original keeps its own, and the
     copy's label belongs to the copy.
   - **Alternative:** Structural keeps a separate naming system of its own. Not recommended: two systems means two places
     for a beam to lose track of its column.

**B. How each edit starts.** You ruled on 14 Sep that the mode is shown before you commit and ends with the operation.
These choices only set which mode each operation *starts* in. You can always switch before pressing Enter.

2. **Column (support) grip.**
   - **Recommend: start in Edit together.** The preview shows every beam end on that column following. Switch to Edit
     this only and the column moves alone; the beam ends stay and the connection is flagged quietly.
   - **On a job:** drag C1 300 mm east with two B1s on it. Both beam ends follow in the preview; Enter commits; one Undo
     puts all three back.
   - **Why:** it matches your July rule "moving a support updates all linked beam ends" and your 14 Sep rule "does not
     silently stretch those beams", because you see the stretch before it happens.
3. **Beam end grip.**
   - **Recommend: start in Edit together.** The beam's own label slides to stay centred on the new length. The column
     stays put; if the end leaves it, the connection is flagged.
   - **Edit this only:** the label stays exactly where it is.
4. **Beam middle grip, or MOVE on the beam alone.**
   - **Recommend: start in Edit together.** Already approved: beam and its own label move; columns stay; connections are
     flagged for review.
   - **Edit this only** is still offered on right-click, for moving the line without its label.
5. **Typing over a label (double-click, change B1 to B3).**
   - **Recommend: start in Edit this only.** The text changes straight away, as normal AutoCAD. The QA panel quietly
     lists "Label says B3, beam is B1" with a one-click "Make the beam B3".
   - **Why:** you asked for quiet notices and nothing sticky. AutoCAD's own text editor cannot show a preview first.
6. **Changing a size in the beam panel when other beams share the mark.**
   - Already approved: CE asks "all B1s" or "this beam gets a new mark".
   - **Recommend:** Enter means **all B1s**, with the count shown ("2 beams").
   - **On a job:** change B1 from 240x45 LVL to 290x45 LVL. Both B1s and the B1 schedule row change together.
7. **AutoCAD's own MOVE on a column without its beams.** This is the one real conflict between two of your rulings.
   - Your July rule: moving a support updates all its beam ends.
   - Your September rule: nothing changes other objects without a preview; commands must not feel sticky.
   - **Recommend:** with MOVE, what you select is what moves. The beam ends stay and the connection is flagged quietly.
     To move beams with a column, use the column grip (choice 2), or STRETCH with a crossing window as you would today.
   - **Why:** MOVE cannot show CE's preview, so following beams would be a silent change.

**C. What an "Edit this only" change does to the schedule**

8. **How a difference shows.**
   - Already approved: the schedule does not change on its own, and there is no catch-up later.
   - **Recommend:** the beam is listed in the QA panel as "Different from schedule". The schedule row gets a review
     highlight that never prints, until you resolve it.
9. **A mark with no schedule row (you type B9).**
   - **Recommend:** no row is invented. QA says "B9 has no schedule row", with a one-click "Add a B9 row" that asks for
     the size. The size stays Unknown until you type it.
10. **The last B4 on the plan is erased.**
    - **Recommend:** the B4 row stays, because the schedule may cover other levels or sheets. QA notes "B4 is not on this
      plan".
11. **Where the member schedule's values live in D2.**
    - **Recommend:** the engineer's schedule that XCLMTXT already brings in stays the one member schedule. D2 links each
      beam to its row by mark.
    - An Edit together size change updates the row on the drawing. QA shows "Drawing 290x45, workbook 240x45" until the
      workbook is re-imported. This follows your July rule that the workbook stays the engineering authority and
      disagreements show both values.
    - **Alternative:** CE builds a new schedule table from the beams on the drawing. Not recommended for D2: it would be a
      second schedule.

**D. Which AutoCAD versions**

12. **Grips on AutoCAD 2027 first.**
    - Your 14 Sep choice was one shared drawing engine for all Structural grips and previews ("Shared native core across
      Structural"), with 2027 first and older versions kept working the way they work now.
    - **Recommend:** D2 grips go on 2027 first. On 2022 to 2026, beams keep AutoCAD's plain grips plus the right-click
      and beam-panel actions. Older-version grips come as a later step.
    - **On a job:** a colleague on AutoCAD 2024 can still change a beam from the panel or right-click, but will not see
      the new grips.

### 4. Already settled: not asked again, but tested

Your words and dates are in the Structural drawing-journey record of 14 Sep (the "Structural grip actions" and
"Independent editing controls" sections) and in cards ST-01 and ST-02.

1. **Label grip** moves only the label and remembers where you put it.
2. **Escape** leaves the drawing unchanged. **Accepting a grip operation is one Undo step.**
3. **The mode is shown before you commit** and ends with the operation; it is never a permanent switch.
4. **Edit this only keeps the connection** for later review unless you choose **Disconnect**.
5. **No automatic catch-up** when you go back to Edit together.
6. **Mismatches are quiet:** they go to the QA panel, never a pop-up.
7. **Shared mark:** a size change asks "all" or "new mark".
8. **Beam-only COPY** keeps the copied label and has no supports.
9. **Erasing a beam** removes its label only. **Erasing a column** flags the affected beam ends.
10. **Never reconnect silently** to nearby content.
11. **Locked layers, Xrefs and REFEDIT are never bypassed.**

### 5. The test drawing and what "right" looks like

**Drawing:** `D2-TWO-BEAMS.dwg`, made up for this test with no client content, saved beside the other Codex test copies.

1. **Layout:** two 90 mm stud walls 6.0 m apart, a DS1 on each wall, one C1 column halfway between.
2. **Schedule:** a two-row Excel file brought in with XCLMTXT: B1 = 240x45 LVL, B2 = 290x45 LVL.
3. **Beams:** B1 from the left DS1 to C1, and B1 from C1 to the right DS1. Two beams, one mark, one shared column.

**Steps. Codex runs them first; you do the short final look.**

1. **Place both beams with command 1.** Right: each label reads B1 on the correct side. The beam panel shows each beam
   sitting on its DS1 and on C1.
2. **Drag the C1 grip 300 mm (Edit together).** Right: the preview shows both beam ends following. After Enter, both
   ends are on C1 and both labels are re-centred. One Undo puts all three back.
3. **Same drag in Edit this only.** Right: only C1 moves. The QA panel lists two beam ends "not on C1". No pop-up.
4. **Drag one label, then drag that beam's middle grip.** Right: the label keeps the offset you gave it.
5. **Change the left B1 to 290x45 LVL in the panel, choose "all B1s".** Right: both B1s change; the B1 schedule row
   reads 290x45 LVL with a highlight that does not print. One Undo restores it all.
6. **Same change, choose "new mark".** Right: the left beam becomes B3, a B3 row appears (highlighted), and the right B1
   is untouched.
7. **Double-click a label and type B9.** Right: the text changes; QA says "Label says B9, beam is B1" and "B9 has no
   schedule row"; the schedule is unchanged.
8. **COPY the left beam alone, 2 m up.** Right: the copy has its own label and no supports; the original is unchanged.
9. **ERASE the right beam.** Right: its label goes; C1 stays; the left beam still sits on C1.
10. **Press Escape in the middle of every grip drag above.** Right: nothing changes.
11. **Save, close, reopen.** Right: every connection, label position, schedule row and highlight is as you left it.
12. **Protection:** put C1 on a locked layer and drag its grip. Right: CE refuses and says "C1 is on a locked layer",
    and nothing moves. Repeat with the beams inside an Xref, and during REFEDIT: CE changes nothing.

### 6. The full experience, from start to finish

1. **Where you start:** the Beams panel on the CE STRUC tab (commands 1, 2 and 4) for placing, exactly as today.
   Everything after that starts from **selecting the object**, not from a new command.
2. **Prompts:** placing keeps today's prompts. Grip drags add one line at the command line, for example
   "Moving C1 with 2 beam ends — Edit together (right-click to change)".
3. **Selecting:** click a beam or column as normal. CE grips appear beside AutoCAD's own. Right-click adds "Edit together",
   "Edit this only", "Disconnect" and "Connect to a support".
4. **Preview:** every Edit together shows the exact objects that will change, drawn highlighted, before Enter.
5. **What lands on the drawing:** only normal lines, text and blocks on CE's usual layers. Review highlights never plot.
6. **Cancel and Escape:** leave the drawing exactly as it was.
7. **Undo:** one Undo per accepted operation, including the schedule row and any QA note it made.
8. **Save and reopen:** every connection and permanent name is stored inside the drawing, so it survives a reopen, a
   colleague opening it, and a copy-paste to another drawing (with new names there).
9. **AutoCAD's protections:** locked layers, Xref content and a REFEDIT session are refused with a plain message.
   Nothing is unlocked, detached or edited around them.
10. **How people find it:** the ribbon tooltip and CEHELP entry for Beam mention the grips; the right-click menu names
    the choices; the QA panel explains every flag in one plain line.

---

*Everything below this line is for the builder. Nothing below needs Tim to read, decide or do anything.*

---

## For the builder: exact source and owners

### Pinned source (read 23–24 Sep 2026)

1. **Shipping Structural line:** branch `claude/struc-ribbon-organised`, tip `5ca35054` ("STRUC-TEST-LOAD-01: log a
   tried-and-reverted fix attempt"). D1 prep branch `claude/struc-d1-prep` starts there.
2. **Installed Structural (read from the bundle DLL 23 Sep):** `1.0.74+bf264cbb…`, an ancestor of `5ca35054`. The six
   later commits (ribbon, SBEAM words and preferences, layer case, beam words, test-load note) are not installed.
3. **Master (Civil owner of the spine):** `origin/master` at `3812120c`. `Shared/CE.Spine` exists only on master.
4. **Tim's 14 Sep journey rulings used here:** plugin repo `docs/workflows/STRUCTURAL_DRAWING_JOURNEY_2026-09-14.md`,
   only reachable at commit `3460f0c0` on `origin/codex/CIVIL3RESEARCH` (not on master or the Structural line). It also
   holds ST-NATIVE-01. Copied, with the real job's details removed, to
   `04_REFERENCE\structural\STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md` on 24 Sep.
5. **The two lines have split far apart:** common ancestor `01380d16` (26 Jul 2026); 402 commits on the Structural line,
   1,382 on master. Master has `Shared/CE.Spine`, `Modules/Drainage.NativeGrip2027`, `Modules/Shared.Transform.Native2027`;
   the Structural line has `Modules/Structural.Native2027` and neither of the others. **D2 cannot start until the
   Structural line can consume `CE.Spine` (and, for choice 12, the native grip pattern) without a big-bang merge.**

### Which file owns each behaviour today

1. **Commands 1, 2:** `Modules/Structural/Commands/BeamPlacementCommands.cs` routes to
   `Services/ConnectedDesign/Host/BeamCommandAutoCadRoute.cs` (preview, recheck, atomic commit). Pure planning in
   `Modules/Structural.DesignCore/ConnectedDesign/` (`BeamCommandPreviewPlanner`, `BeamPlacementPlanner`,
   `BeamAtomicCommitCoordinator`, …). **State: works, built and unit-tested; not Tim-accepted as connected framing.**
2. **Command 4:** `Host/BeamSpecialCommandAutoCadRoute.cs` → `Commit/AutoCadBeamSpecialAtomicWriter.cs`. **State: works.**
3. **Command 5 and BDL:** legacy `RunSpecialBeam` and inline BDL in `BeamPlacementCommands.cs`; links only through
   `RegisterBeamLinkAfterPlacement` → `BeamLinkService.RegisterBeam/RegisterAttachment`, gated by
   `BeamSettings.LinkingEnabled` (default false since 3 Jun 2026). BDL draws two independent beams, no pair identity.
   **State: partial.**
4. **Owned label and support record:** `Commit/BeamAtomicWriteSession.cs` always calls `WriteLegacyLink()`
   (`Commit/AutoCadBeamAtomicWriteGateway.cs` ~263–331; special writer ~425–480; BEXT `AutoCadBeamExtensionAtomicWriter`
   ~360) writing `BeamLinkData` (`Models/BeamLinkData.cs`) to `CE_STRUC_SUITE_LINKS/BEAM_LINK` in the beam's extension
   dictionary: beam handle, explicitly selected SupportStart/SupportEnd handles, BeamText handle and offsets.
   **Identity is AutoCAD handles only.** **State: partial (written, but locator-only).**
5. **Follow-on movement, erase cascade, copy detection:** `Services/BeamLinkService.Reactors.cs`,
   `.AttachmentUpdates.cs` (`ProcessMoves`, `ProcessClones`), `.CascadeErase.cs`. All gated off by `LinkingEnabled`, and
   `BeamCommandAutoCadRoute`/`BeamSpecialCommandAutoCadRoute` refuse with `LEGACY_LINKING_MUST_BE_DISABLED` when it is on.
   `ProcessClones` clears a copied beam's attachments and marks it orphaned (contradicts ST1-14). **State: dormant.**
6. **Connected record:** `Models/ConnectedDesign/ConnectedStructuralRecord.cs` (schema `ce.structural.connected-2d` v1,
   `MemberId`, label/support references, `PairId`), `ConnectedStructuralRecordCodec.cs`, `…Validator.cs`,
   `LegacyBeamLink*` read adapters. Its own comment: "Stage 3A1 deliberately does not persist it into a DWG. The existing
   BeamLinkData remains the only active drawing truth." **State: source-only, never written to a drawing.**
7. **Beam panel:** `Services/ConnectedDesign/SelectedBeamInspectorAutoCadService.cs`, `SelectedBeamInspectorPresenter.cs`,
   `UI/Palette/SelectedBeamInspectorPanel.xaml(.cs)`, hosted by `Services/StructuralInspectorContributor.cs` as a child
   page of the Civil-owned CE Inspector (no Structural host of its own). Approved as read-only in ST-01A.
   **State: read-only; edit actions missing.**
8. **Grips and transforms:** none in Structural (no `GripOverrule`/`TransformOverrule`). Civil's managed
   `Modules/Drainage/Services/CompoundGripOverrule.cs` and master's `Modules/Drainage.NativeGrip2027` are the reference
   patterns; ST-NATIVE-01 says reuse the pattern, never Civil identities or pipe rules. **State: missing.**
9. **Member schedule:** `Services/MemberScheduleService.cs` (NOD `CE_STRUC_SUITE.MEMBER_SCHEDULE`, rows Code/Size/Type/Note)
   written by `XclmTxtService.cs` after an XCLMTXT insert; read only by `Commands/SupportBlockCommands.cs` (~222).
   `Services/ScheduleService.cs` (STRSCHEDCREATE/REFRESH/SYNC) builds bracing and bored-pier tables only.
   `Structural.DesignCore/Schedules/SemanticScheduleRecord*` and `CeSchedule*` contracts have no callers in the plugin.
   **State: imported schedule works; beam-to-row link and update path missing.**
10. **Civil identity pattern to reuse:** master `Shared/CE.Spine/SpineKey.cs` (`CE-STR-MEMBER-<GUID>` text form already
    defined: `SpineDiscipline.Structural`, `SpineObjectKind.Member`), master
    `Modules/Drainage/Services/LinkService.NewPipeIdentity.cs` (`EnsurePipeSpineIdentity`, `EnsurePitSpineIdentity`:
    create at birth, keep an existing key, never write locked-layer/Xref/REFEDIT objects), `LinkService.Spine.cs`
    (`SPINE_ID` text under the object's CE link dictionary), `CloneOwnedSpineIdentityPolicy.cs` (COPY admission).

### Evidence in the plugin's REGRESSION_LOG (Structural line)

1. **"Stage 3A1 adds a pure connected-structural record without changing DWG behaviour" (2026-07-23):** the record is
   pure; `BEAM_LINK` stays the only drawing truth; no nearest-object guessing; one support may serve several beams.
2. **"Stage 3B2b-ii.c routes beam commands 1/2 through the accepted host" (2026-07-24):** 1 and 2 on the connected
   preview/commit route; 4, 5, BDL, BEXT, BTX then frozen (4 joined later, see "2026-08-03 — Command 4 connected Preview
   route").
3. **"ST-01A / P1-01 — selected-beam read-only Structural Inspector" (2026-08-03):** panel is read-only; supports stay
   Amber until confirmed; no repair or identity writes.
4. **"MODELSPACE-CASE-01" and "STRUC-LAYER-CASE-01" (2026-09-23):** the connected route had been refusing real 2027
   drawings; fixed, not yet Tim-accepted. **"STRUC-BEAM-WORDS-01" (2026-09-23):** plain names for command 1.
5. **"STRUC-TEST-LOAD-01" (2026-09-23):** the Structural plugin test project could not load on this PC, so none of the
   connected-route tests above had been re-run here since. Fixed on `claude/struc-d1-prep` (`e2c2d974`, 23 Sep):
   on net10, 1,356 of 1,365 pass outside the SBEAM compiled-route proofs, which do not finish (see that entry).

### Identity owner nomination (choice 1, technical detail)

1. **Nominee:** `CE.Spine.SpineKey`, one per beam and per support block, kind `Member` (columns and stud packs are
   members; the record's own `ConnectedObjectKind` says Beam or Column). Labels are owned children, not spine objects.
2. **Storage:** `SPINE_ID` text in the object's `CE_STRUC_SUITE_LINKS` dictionary, written inside the placing
   transaction by an `EnsureMemberSpineIdentity` that mirrors the Civil methods. `BeamLinkData` attachments gain the
   support's key beside its handle; handles stay locators. `ConnectedStructuralRecord.MemberId` becomes the key text.
3. **Conditions:** (a) the Structural line must consume master's `Shared/CE.Spine` first; (b) `CE.Spine.dll` would then
   ship in two bundles, so it needs the same one-version, lane-for-lane rule as CE_SHARED ("first loaded wins");
   (c) no new `SpineObjectKind` value is needed, so the shared enum (Civil-owned) is not touched.
4. **Rejected alternative:** persisting Structural's own `MemberId` GUIDs. That is a second identity system, against
   design rule 1 (one code path per behaviour), and CE.Spine already reserves the Structural discipline.

### Card amendments this card asks for (once Tim rules)

1. **ST1-13:** native MOVE of a support alone no longer drags beam ends (choice 7); the grip does it with a preview.
2. **ST1-14 / ST2-10:** COPY gives fresh spine names, links the copied label, and no supports unless copied together.
   Replaces `ProcessClones` orphaning.
3. **ST-01A:** the beam panel gains size/mark edits and the Edit together / Edit this only choice (window is Codex's
   to build, per the 15 Sep windows ruling).
4. **ST7-6 / ST7-10:** a coordinated drawing edit may update the imported schedule row on the drawing and must show the
   workbook value beside it as a conflict until re-import (choice 11).
5. **ST-NATIVE-01 N3:** support grips are the D2 pilot for the shared core (choice 12).
6. **ConnectedStructuralRecord:** moves from "never persisted" to persisted identity; needs its own preview-before-adopt
   step for drawings that already hold `BEAM_LINK` records (existing ST-01 "legacy migration becomes preview-based").

### What D2 must not do

1. No architectural inference, markup automation, detail library or whole-plan proposal (D3–D5).
2. No removal of commands 5, BDL, BEXT or BEAMLINKMIGRATE before their replacements pass Tim's AutoCAD test.
3. No re-enabling of the dormant `LinkingEnabled` reactors as the coordinated-edit engine; D2 edits are operation-scoped.
4. No silent write-back from the schedule to beams (ST7-10), and no invented sizes.

### Automated guards to write with D2

1. **Identity at birth:** every beam and support placed by 1, 2, 4 gets exactly one `CE-STR-MEMBER-…` key inside the same
   Undo group; locked-layer, Xref and REFEDIT objects are never written.
2. **COPY:** copy gets new keys and its own copied label; no supports; original byte-identical.
3. **Together plan:** a C1 move lists exactly C1, two beam ends and two labels; nothing else.
4. **This-only plan:** exactly one object changes; relationships kept; one QA item; schedule rows untouched.
5. **Shared mark:** "all" changes both beams and one row; "new mark" adds one row only after confirmation.
6. **Non-printing highlight:** review highlights sit on a no-plot layer and are absent from plotted output.
7. **Escape:** drawing fingerprint identical before and after an abandoned drag.
8. **Undo:** one Undo group per accepted operation (schedule row and QA note included).
9. **Reopen:** codec round-trip of every record (the existing `ConnectedStructuralRecordCodecTests` extended).
10. **The suite actually runs:** the Structural plugin test project must report a non-zero test count
    (STRUC-TEST-LOAD-01).

### Codex's short AutoCAD checklist (about 10 minutes, one drawing)

Run section 5 steps 1–12 on `D2-TWO-BEAMS.dwg` in AutoCAD 2027, recording PASS / FAIL / BLOCKED / NOT TESTED for each,
with the command line text for any FAIL. Then Tim's final look: steps 2, 5 and 11 only.

### Open dependencies before a builder starts

1. Tim's answers to the 12 choices.
2. A plan for bringing `Shared/CE.Spine` (and, if choice 12 stands, the native grip pattern) onto the Structural line
   without a big-bang merge.
3. The Structural plugin test project runs on this PC again (STRUC-TEST-LOAD-01, `e2c2d974`), but 9 stale or
   AutoCAD-only guards fail and the SBEAM compiled-route proofs loop; D2's guards must not depend on those.
4. Duration: not estimated until items 1 and 2 are settled; the plan's rule is no invented dates.
