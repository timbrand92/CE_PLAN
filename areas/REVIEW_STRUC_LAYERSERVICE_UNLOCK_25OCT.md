# Review: does Structural ever unlock a layer the drafter locked? (25 Oct 2026)

**Read-only code reading by an independent Opus reader.** Branch read: `origin/claude/rel-20261025s` at `3a3caac5` (installed Structural 1.0.124). Nothing was built, run, edited in the plugin, committed or pushed. Nothing here has been checked in AutoCAD.

## ANSWER FIRST

**One real gap, and it is small.** The **"Apply CE Standard Layers" button** in CEADMINSETTINGS (also CEADS) unlocks every CE layer the drafter had locked, in one click, with no list and no warning. It also thaws and turns on any CE layer they had frozen or turned off. Nothing is drawn or moved afterwards, so no object on a locked layer is changed by this button. Every other path the trial flagged is **SAFE**.

## FOR TIM

1. **What happens:** you lock BEAM to protect it. Later you open Drafting Standards and press "Apply CE Standard Layers" to fix colours. BEAM is now unlocked. The status line only says "CE standard layers applied." Nothing tells you BEAM was unlocked.
2. **Why it matters:** your next MOVE or ERASE can now touch the beams you meant to protect. The native protection rule says CE must never unlock silently.
3. **How bad:** low. You have to press that button yourself, and nothing is drawn on the layer by it. No command does this on its own any more (that was BUG-367, fixed in 1.0.121).
4. **Everything else is fine:** drawing commands never change an existing layer's lock. "Save Layer Changes" only changes the lock if you tick or untick the Locked box yourself. PXREF (paste Xref) only sets the lock on the brand-new Xref layers it just made, copied from your source drawing.
5. **Recommended fix (default, change it if you disagree):** "Apply CE Standard Layers" resets colour, linetype, lineweight and plot, but leaves lock, freeze and on/off as you set them, and names the layers it left alone. Filed text below as BUG-1224.

---

## Path by path

1. **Path 1: the "Apply CE Standard Layers" button. Verdict: UNSAFE (LOW).**
   - **Where:** `Modules/Structural/UI/LayerManagerWindow.xaml.cs:141-153` (`BtnApplyStandards_Click`) calls `LayerService.ApplyStandardLayers` (`LayerService.cs:325-345`), which calls `ApplyStandard` (`LayerService.cs:522-541`) for every standard layer.
   - **Which commands reach it:** only CEADMINSETTINGS and its alias CEADS (`Commands/LayerManagerCommands.cs:11-15`; ribbon label "Drafting Standards", Administration group, `command-registry.json:355-371`). The only caller of `ApplyStandardLayers` in the whole Structural module is this button.
   - **Order:** no capture of the drafter's lock first, no restore after. Line 535 writes `layer.IsLocked = standard.IsLocked` on every existing CE layer; lines 536-537 do the same for off and frozen. The standard comes from the office layer template DWG, or from the fallback list in the code, where every layer is unlocked, on and thawed (`LayerService.cs:84-119`, default `isLocked = false` at line 57).
   - **Locked layer skipped or reported:** neither. The status line is the fixed text "CE standard layers applied." (line 147). The "Expected" column in the grid shows "Locked No" before the click, which is the only hint.
   - **Edit afterwards that writes to a locked layer:** none. The button changes layer settings only; it draws, moves or erases nothing. The harm is that the drafter's protection is gone for their next edits.
   - **Known already:** source audit 7 Oct finding 5 (`04_REFERENCE/release/SOURCE_AUDIT_2026-10-07.md:120`, LOW). It was never filed as its own carpark entry. BUG-367's guard test deliberately allows it (`Modules/Structural.Tests/Services/Bug367LayerKeepTests.cs:98-112`, "Allowed... because the drafter asked for exactly that change"). The native protection rule (AGENTS.md) says any exception needs "its own reviewed workflow, visible preview and explicit user approval"; this button has the click but not the preview or the list.

2. **Path 2: "Save Layer Changes" (a row edit). Verdict: SAFE.**
   - **Where:** `LayerManagerWindow.xaml.cs:187-202` (`BtnSaveRow_Click`) calls `LayerService.UpdateLayer` (`LayerService.cs:453-489`; the lock write is line 480).
   - **Which commands reach it:** only CEADMINSETTINGS / CEADS, the "Save Layer Changes" button. No other caller.
   - **Order:** the row is filled from the drawing when the window opens (`GetLayers`, line 398 reads the real lock), shown in the editable "Locked" tick box (`LayerManagerWindow.xaml:62`), and saved back for the one selected row. The lock only changes if the drafter changed the tick box. The window opens as a modal dialog (`AutoCadWindowHostHelper.ShowPaletteModalDialog`), so the drawing cannot change underneath it.
   - **Edit afterwards:** none. This is the same as unticking the padlock in AutoCAD's own Layer Properties Manager.
   - **Side note, not a lock problem:** BUG-1187 (a typo in the Lineweight cell silently becomes Default, RD14-05) is already filed for this same button.

3. **Path 3: drawing commands that make sure a layer exists (`EnsureLayer` / `CreateIfMissing`). Verdict: SAFE (one UNCLEAR edge).**
   - **Where:** `LayerService.cs:177-202` and `494-520`. An existing layer is returned untouched (lines 184-186, 198-200, 497-498); line 510 sets the lock only on a layer that did not exist a moment ago.
   - **Commands:** about 30 drawing commands (RBL, RBC, STR, CSREOBAR, footings, schedules and others, per BUG-367). They cannot unlock a layer the drafter locked, because they never open an existing layer for change. The guard test `NoOtherStructuralCode_RewritesAnExistingLayer` keeps it that way.
   - **UNCLEAR edge (not checked, needs the office template opened):** if the office layer template DWG has any layer saved as locked, a command that has to create that layer creates it locked and then draws on it in the same step (the API allows adding new objects to a locked layer). That would not unlock anything, so it is not this rule, but it would surprise a drafter. The fallback list in the code has no locked layer.

4. **Path 4: PXREF (paste Xref), `NativeCopyPasteXrefService`. Verdict: SAFE. The trial's "false alarm" is confirmed, but its reason needs one correction.**
   - **Where:** CXREF (`NativeCopyPasteXrefService.cs:58-115`) reads the lock, freeze, off, colour, linetype, lineweight, plot and transparency of every layer of the picked Xref (`CaptureLayerStates`, 235-269) into the CE clipboard file. PXREF (`173-233`) attaches the same file under a name that is checked to be new (`GenerateUniqueXrefName`, 387-405), then `ApplyLayerStates` (315-352; lock at line 346) writes the copied settings onto that new Xref's layers only (`BuildTargetLayerName` gives "newname|layer", and line 327 skips anything not found).
   - **Correction to the trial:** it does not "restore captured state" onto the same layers. It copies the drafter's own settings from the source drawing onto layers that PXREF itself has just created. A layer locked in the source drawing comes out locked; one unlocked comes out unlocked. It cannot touch any layer the drafter locked in the target drawing, because those layers did not exist before the paste.
   - **Edit afterwards:** the Xref insert goes on the current layer (normal AutoCAD behaviour, which also lets you draw on a locked current layer); the Xclip is done with AutoCAD's own XCLIP command, which keeps AutoCAD's own protections.
   - **Side notes, not lock problems (not checked in AutoCAD):** the layer settings and the Xclip run after the undo group closes (lines 198-226), so one U after PXREF may not undo them; the Xref reload failure is swallowed (line 222, source audit finding 4). Copying itself currently fails on Codex's test drawing with eInvalidKey (BUG-618, OPEN).

5. **Other places that read a lock (not setters).** Every other `IsLocked` hit on this branch only reads the lock to skip or refuse (for example `LayerService.FirstLockedLayer` 219-232, `LockedLayerNameOf` 239-240, FoundationService, LintelProposalService, LevelCarryDrawService, WeldMarkCommands, BeamAtomicLayerWriter). `MarkupAIDrawingStandardsExportService.cs:55` and `LayerManagerWindow.xaml.cs:336,377` copy the value into a list, not onto a layer. No other code in Structural sets a layer's lock.

## Existing carpark links

1. **BUG-367:** the fix that stopped drawing commands resetting existing layers (create-only rule). It names the Apply button as the one allowed reset. Related, not a duplicate.
2. **BUG-417:** the Civil X-Civil import unlocks layers (HIGH). Same rule, other module.
3. **BUG-618:** CXREF fails with eInvalidKey. Same Xref copy flow, not about locks.
4. **Source audit 7 Oct finding 5:** this exact finding, LOW, never filed. No existing BUG entry for it (grep of `BUG_CARPARK.md` for LayerService, IsLocked, Apply standards, Apply CE Standard, CEADMINSETTINGS, CEADS).

## Proposed carpark entry (not filed by this reader; the highest number in the file is BUG-1223, re-check before filing)

## BUG-1224

**Command / Area:** CEADMINSETTINGS (also CEADS), Drafting Standards, Drawing Layers page, "Apply CE Standard Layers" button, Structural 1.0.124. LOW, SURE (read; source audit 7 Oct finding 5, never filed).

**Symptom:** a drafter locks BEAM (or any CE standard layer), then presses "Apply CE Standard Layers". Every locked CE layer is unlocked, and every frozen or turned-off CE layer is thawed and turned on. The status line says only "CE standard layers applied." It does not name a single layer it unlocked. Breaks the native protection rule "never silently unlock".

**Expected behaviour:** recommended default (Tim's answer replaces it): the button resets colour, linetype, lineweight and plot to the standard, but leaves lock, freeze and on/off exactly as the drafter set them, and the status line names them: "Left 2 locked layers as you set them: BEAM, 25TEXT." Alternative if Tim prefers: before applying, list the layers that would be unlocked, thawed or turned on and ask once, Yes or No.

**Reference:** `Modules/Structural/Services/LayerService.cs:325-345` (ApplyStandardLayers) and `522-541` (ApplyStandard; lock at line 535, off and frozen at 536-537); `Modules/Structural/UI/LayerManagerWindow.xaml.cs:141-153`; `04_REFERENCE/release/SOURCE_AUDIT_2026-10-07.md:120`; review `areas/REVIEW_STRUC_LAYERSERVICE_UNLOCK_25OCT.md`. Related, not duplicates: BUG-367 (allows this button in its guard test, `Bug367LayerKeepTests.cs:98-112`), BUG-417.

**Test that catches it:** a unit test on the pure "what would Apply change" step: a layer that is locked in the drawing and unlocked in the standard stays locked and appears in the "left as you set them" list; same for frozen and off. Update the BUG-367 guard comment so it no longer lists the Apply button as allowed to change lock, freeze or on/off. Codex AutoCAD case below.

**Steps to confirm in AutoCAD:** test copy of any Structural drawing. Lock BEAM, freeze 25TEXT. Type CEADMINSETTINGS, Drawing Layers, press "Apply CE Standard Layers", close. Type LAYER. Right looks like: BEAM still locked, 25TEXT still frozen, and the status line named both before you closed. Then one U: check whether the colour reset undoes in one step.

**Status:** OPEN
