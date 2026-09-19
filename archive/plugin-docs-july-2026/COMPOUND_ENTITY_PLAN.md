# Compound Pit + Pipe Entity Model — Implementation Plan

**Date**: 2026-05-01
**Status**: Approved for implementation
**Plugin**: CE_CVL_SUITE (civil engineering drainage for AutoCAD)

---

## Problem

CE_CVL_SUITE currently represents each pit as 3+ separate AutoCAD entities (block + label + cover text) and each pipe as 4-6 separate entities (polyline + mline + pipe text + 2 invert texts + arrow). Users must Ctrl+click to multi-select, use CDMOVE/CDMOVEALL to move groups, and manage entities individually. This is confusing and error-prone compared to Civil 3D's compound object model.

## Goal

Make pits and pipes behave as single compound entities — click one sub-entity, the whole group selects/moves/deletes together — while keeping all geometry as standard AutoCAD entities so drawings work without the plugin.

## Key Constraints

- **No custom objects (ObjectARX)** — All entities remain standard polylines, blocks, MLines, and MText. Compound behavior is provided by overrules that activate only when the plugin is loaded.
- **MLINE stays** — Keep the existing MLINE as a separate AutoCAD entity. It becomes part of the pipe compound (moves/selects with the pipe) but is NOT replaced or removed.
- **Without plugin**: Entities display and behave as individual AutoCAD objects. No data loss.
- **With plugin**: Overrules make entities behave as compounds.

---

## Architecture Overview

### How It Works

Build on the existing overrule pattern (`PipeDrawableOverrule` / `PipeOsnapOverrule` in `Services/PipeOverruleService.cs`) and the existing link data infrastructure (`LinkService.Persistence.cs`).

The `LinkService` already stores `PIT_ATTACHMENT` and `PIPE_ATTACHMENT` reverse-lookup keys on every sub-entity's extension dictionary. A new `CompoundResolver` reads these in O(1) to find the parent entity — no scanning needed. The existing `MoveLinkedPipes` reactor handles pit-pipe endpoint stretching, so there's no duplication.

### Compound Entity Composition

**Pit compound** (all move/select/delete together):
- BlockReference (pit block) — root entity
- MText (pit label)
- MText (cover text)
- Tag guideline text (if tagged via CDTAG) — see Phase 5

**Pipe compound** (all move/select/delete together):
- Polyline (pipe centerline) — root entity
- MLINE (pipe border) — stays as-is, just grouped into compound
- MText (pipe text — diameter/grade)
- MText x2 (invert texts at endpoints)
- BlockReference (flow arrow)
- Tag guideline text (if tagged via CDTAG) — see Phase 5

---

## CompoundResolver — The Core Algorithm

**New file**: `Services/CompoundResolver.cs`

Static class that maps any entity back to its compound root and returns all sibling ObjectIds.

```
ResolveCompound(entityId, tr, db) -> CompoundSet { Kind, RootId, OwnedMembers }
```

**Resolution logic** (all O(1) via existing extension dictionary reads):

1. Entity is pit block? -> Read `PitLinkData.Attachments` -> return pit compound
2. Entity is pipe polyline? -> Read `PipeLinkData` -> return pipe compound (mline + all attachments)
3. Entity has `PIT_ATTACHMENT` xrecord? -> `ReadPitAttachmentOwner()` -> resolve pit handle -> step 1
4. Entity has `PIPE_ATTACHMENT` xrecord? -> `ReadAttachmentOwner()` -> resolve pipe handle -> step 2
5. Entity is MLINE matched by a pipe's `MlineHandle`? -> reverse lookup -> step 2
6. None? -> return `CompoundSet.None`

**Existing infrastructure leveraged**: `LinkService.ReadPitLinkData`, `LinkService.ReadPipeLinkData`, `ReadAttachmentOwner`, `ReadPitAttachmentOwner`, `TryGetObjectId` — all proven and in production.

---

## Phase 1: CompoundTransformOverrule (Move Propagation)

**Goal**: Moving any sub-entity of a pit or pipe moves the entire compound.

### New files

**`Services/CompoundResolver.cs`** — as described above.

**`Services/CompoundTransformOverrule.cs`** — `TransformOverrule` implementation:

- Registered on `RXClass.GetClass(typeof(Entity))` — filtered by extension dictionary presence
- `TransformBy(entity, matrix)`: resolve compound via `CompoundResolver`, apply same matrix to all siblings
- Re-entrancy guard (`[ThreadStatic] static bool _isTransforming`) in `try/finally` prevents infinite recursion
- **Pit compounds**: Move pit block + label + cover text together. Connected pipes stretch at endpoints (handled by existing `LinkService.MoveLinkedPipes` reactor — NOT duplicated)
- **Pipe compounds**: Move polyline + MLINE + all text + arrow together

### Files to modify

- `PluginInitialization.cs` — Register/unregister `CompoundTransformOverrule` alongside existing overrules (~line 47)
- `Services/SettingsService.cs` / `Models/UserSettings.cs` — Add `CompoundBehaviorEnabled` toggle (default: true)

### Key design decisions

- **TransformOverrule over ObjectModified reactor** — Intercepts transform BEFORE commit, so all siblings move in same transaction (no visual lag)
- **Existing LinkService reactors stay active** — They handle pit-pipe connectivity (endpoint stretching). CompoundTransformOverrule handles compound-internal movement. Both are needed, no duplication
- **Safety toggle** — `CompoundBehaviorEnabled` setting lets users disable compound behavior if issues arise

### Verification

1. Open existing drawing with pits and pipes
2. Click a pit label -> MOVE -> pit block and cover text move together
3. Click a pipe invert text -> MOVE -> polyline, MLINE, all text, arrow move together
4. Click a pit block -> MOVE -> labels move, connected pipes stretch at endpoints only
5. UNDO reverses all entities correctly
6. Save, close, reopen without plugin -> all entities display correctly
7. Toggle `CompoundBehaviorEnabled = false` -> entities revert to individual behavior

---

## Phase 2: Compound Selection + Compound Delete

**Goal**: Clicking any sub-entity highlights the entire compound. Deleting any sub-entity prompts for compound deletion.

### New file

**`Services/CompoundSelectionService.cs`** — Hooks `Editor.SelectionAdded` event:

- When selection fires, resolve each selected entity via `CompoundResolver`
- Add all sibling ObjectIds to selection via `Editor.SetImpliedSelection`
- Works with single-click, window, and crossing selection modes

### Compound delete behavior

Enhance `LinkService.ProcessPendingErasures`:
- Sub-entity erased -> prompt "Delete entire compound? [Yes/No/Sub-entity only]"
- Root entity erased -> auto-erase all sub-entities
- "Sub-entity only" unlinks the entity from the compound and lets the erasure stand

### Files to modify

- `PluginInitialization.cs` — Initialize `CompoundSelectionService`
- `Services/LinkService.cs` — Compound delete prompts in `ProcessPendingErasures`

### Verification

1. Click a pit label -> entire pit compound highlights (block + label + cover text)
2. Window-select across pipes -> all pipe sub-entities included in selection
3. DELETE a pipe text -> prompted to delete entire pipe compound or just the text
4. DELETE a pit block -> all pit attachments auto-deleted

---

## Phase 3: Sub-Entity Editing Mode (Double-Click)

**Goal**: While compound behavior is the default, users can still reposition individual sub-entities (invert text, cover level text, labels) via double-click.

### Interaction model

| Action | Behavior |
|--------|----------|
| Single click | Select entire compound |
| MOVE after single click | Move entire compound |
| Double-click sub-entity | Enter sub-entity edit mode — only that entity is selected, can be moved independently |
| ESC from sub-entity edit | Return to compound mode |

### Implementation

**`Services/CompoundEditModeService.cs`** — Hooks `Editor.PointMonitor` or `Document.BeginDoubleClick`:

- On double-click of a compound sub-entity: temporarily suppress `CompoundSelectionService` and `CompoundTransformOverrule` for that entity
- Set `Editor.SetImpliedSelection` to just the double-clicked entity
- Store the entity's offset from compound root in `PIT_ATTACHMENT_OFFSET` xrecord after move completes
- When the compound root is subsequently moved, sub-entities preserve their relative offset

### Sub-entity offset persistence

Already exists: `PIT_ATTACHMENT_OFFSET` key is defined in `LinkService.cs` (line 29). Extend the pattern to pipe attachments via a `PIPE_ATTACHMENT_OFFSET` key.

When the compound root moves, each sub-entity is displaced by root delta + its stored offset correction. This means a user can nudge a label to their preferred position, and it stays at that relative offset when the pit is moved later.

### Files to modify

- `Services/LinkService.cs` — Add `PIPE_ATTACHMENT_OFFSET` support
- `Services/CompoundTransformOverrule.cs` — Apply stored offsets when propagating transforms

### Verification

1. Double-click pit cover text -> only cover text selected, can drag independently
2. Move cover text to new position -> offset stored
3. Now select pit (single click) -> MOVE -> cover text moves with pit, maintaining its offset
4. Double-click pipe invert text -> can reposition independently, offset preserved on subsequent pipe moves

---

## Phase 4: Grips, Vertices, Context Menu + Command Cleanup

**Goal**: Unified grip points, easy vertex insertion on pipes, right-click context menu, and deprecate CDMOVE/CDMOVEALL.

### CompoundGripOverrule

**`Services/CompoundGripOverrule.cs`** — `GripOverrule`:

- **Pit compounds**: Center grip (move whole pit) + edge grips if resizable
- **Pipe compounds**: Vertex grips on polyline only (move vertices, text follows parametrically)
- Sub-entity grips suppressed in compound mode (they reappear in double-click edit mode)

### Easy pipe vertex insertion

Add a midpoint grip on each pipe segment. When the user drags a midpoint grip, a new vertex is inserted into the polyline at that location. The MLINE is updated to match. Text attachments recompute their parametric positions (`PipeAttachment.SegmentIndex`, `PipeAttachment.T`).

This follows the standard AutoCAD pattern for polyline editing but applies it through the compound grip overrule so the MLINE and attachments stay in sync.

### Right-click context menu

**`Services/ContextMenuService.cs`** — via `ContextMenuExtension` on `Editor`:

- "Edit Pit..." / "Edit Pipe..." -> opens existing PitDialog / CdDialog
- "Edit Sub-Entity" -> enters double-click edit mode for the clicked entity
- "Add Vertex" -> enters vertex insertion mode on the pipe
- "Select All Connected" -> selects pit + all connected pipes
- "Inspect" -> opens Inspector palette

### Command deprecation

| Command | Replaced By |
|---------|-------------|
| CDMOVE | Native AutoCAD MOVE (compound overrule handles grouping) |
| CDMOVEALL | Native AutoCAD MOVE |
| PITDELETE | Native AutoCAD DELETE (compound reactor handles cleanup) |

These commands remain functional but display a tip: "Tip: you can use native MOVE — compound behavior is automatic."

### Files to modify

- `Commands/CdMoveCommands.cs` — Add deprecation messages
- `Assets/Config/command-registry.json` — Update command descriptions
- `PluginInitialization.cs` — Register new services

---

## Phase 5: Bounding Boxes + Tag Integration

**Goal**: All CE compound objects show visual bounding boxes. Tagged objects include tag text in their compound.

### Bounding boxes

All CE_CVL compound entities display a dashed bounding box outline:
- **Color**: 251 (light gray)
- **Linetype**: Dashed
- **Non-printable**: Created on a non-plot layer or via overrule rendering
- **Exception**: If the bounding box would match the block outline exactly (e.g., a simple rectangular pit block), skip it — redundant

Implementation approach — two options:

**Option A: DrawableOverrule rendering (recommended)**
- Extend `PipeDrawableOverrule` pattern to render a bounding box via `WorldDraw`
- No extra entities in the drawing — the box is drawn by the overrule at display time
- Without plugin: no bounding box visible (clean fallback)
- Bounding box computed from compound root + all sub-entity extents

**Option B: Physical entity on non-plot layer**
- Create a lightweight polyline rectangle on a `CE_BOUNDS` layer (non-plot, color 251, dashed)
- Add to compound as another sub-entity
- Without plugin: layer exists but non-plot, so it won't print
- Downside: more entities in the drawing

**Recommendation**: Option A (overrule-rendered) is cleaner — no extra entities, perfect fallback.

### Tag guideline integration

When an object is tagged via CDTAG, the tag's guideline text and leader become part of the compound:
- Register tag entities as compound attachments via `LinkService.RegisterAttachment`
- `CompoundResolver` includes them in the compound set
- They move/select/delete with the parent entity

### Files to modify

- `Services/PipeOverruleService.cs` (or new `Services/BoundingBoxOverrule.cs`) — Bounding box rendering
- `Commands/TagCommand.cs` — Register tag as compound attachment on creation
- `Services/LinkService.Registration.cs` — Ensure tag registration uses existing attachment pattern

---

## Phase Summary

| Phase | Delivers | New Files | Est. Effort |
|-------|----------|-----------|-------------|
| 1 | Compound move (move one, all follow) | `CompoundResolver.cs`, `CompoundTransformOverrule.cs` | 2-3 weeks |
| 2 | Compound selection + compound delete | `CompoundSelectionService.cs` | 1-2 weeks |
| 3 | Double-click sub-entity editing | `CompoundEditModeService.cs` | 1-2 weeks |
| 4 | Grips, vertex insertion, context menu, command cleanup | `CompoundGripOverrule.cs`, `ContextMenuService.cs` | 2-3 weeks |
| 5 | Bounding boxes + tag integration | `BoundingBoxOverrule.cs` (or extend existing) | 1-2 weeks |

Each phase is independently shippable and non-breaking.

---

## No Data Migration Required

The existing extension dictionaries with `PitLinkData` and `PipeLinkData` already contain all the information `CompoundResolver` needs. Existing drawings open and work immediately with compound behavior — no conversion step.

---

## Fallback Behavior

### Without the plugin loaded
- All polylines, MLines, text, blocks display correctly as standard AutoCAD entities
- Extension dictionary data persists in DWG (invisible to users, survives save/open/copy/wblock)
- Users select/move/edit entities individually (current behavior)
- No bounding boxes visible (overrule-rendered)

### With plugin but compound behavior disabled (`CompoundBehaviorEnabled = false`)
- All existing functionality works as before
- CDMOVE/CDMOVEALL remain fully functional
- Overrules unregistered, no compound selection/move/grip behavior

---

## Critical Files Reference

| File | Role |
|------|------|
| `Services/PipeOverruleService.cs` | Existing overrule pattern to follow (singleton + Register/Unregister) |
| `Services/LinkService.Persistence.cs` | `ReadPitLinkData`, `ReadPipeLinkData`, `ReadAttachmentOwner`, `ReadPitAttachmentOwner` — core data access for CompoundResolver |
| `Services/LinkService.cs` | Reactors (`OnObjectModified`, `OnObjectErased`, `OnCommandEnded`), link constants (`PIT_ATTACHMENT`, `PIPE_ATTACHMENT`, `PIT_ATTACHMENT_OFFSET`) |
| `Services/LinkService.Registration.cs` | `RegisterPipe`, `RegisterPit`, `RegisterAttachment` — attachment registration patterns |
| `PluginInitialization.cs` | Overrule registration at lines 47-51 |
| `Models/PitData.cs` | PitData + PipeData models (no changes needed to existing models) |
| `Commands/CdMoveCommands.cs` | CDMOVE/CDMOVEALL — to deprecate |
| `Commands/TagCommand.cs` | CDTAG — to integrate into compound system |
| `Services/SettingsService.cs` | Settings toggle for `CompoundBehaviorEnabled` |

---

## Architectural Decisions

1. **Overrules, not custom objects** — No Object Enabler distribution. Without plugin, entities are standard AutoCAD objects.
2. **TransformOverrule, not ObjectModified reactor** — Intercepts transform BEFORE commit, so all siblings move in same transaction (no visual lag).
3. **Existing LinkService reactors stay active** — They handle pit-pipe connectivity (endpoint stretching). CompoundTransformOverrule handles compound-internal movement. Both needed, no duplication.
4. **MLINE stays as separate entity** — Kept as-is for rendering fidelity. Becomes part of pipe compound (moves together) but is not replaced by overrule rendering.
5. **Double-click for sub-entity editing** — Compound behavior is default (single click). Double-click enters isolated edit mode for repositioning individual labels/text.
6. **Bounding boxes via overrule rendering** — No extra entities in drawing. Clean fallback without plugin.
7. **Safety toggle** — `CompoundBehaviorEnabled` setting lets users disable compound behavior if issues arise.
