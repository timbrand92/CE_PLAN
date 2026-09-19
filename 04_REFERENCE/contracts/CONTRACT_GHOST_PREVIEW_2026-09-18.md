# CONTRACT — the ghost preview in Edit Pit / Edit Pipe

**Tim's ruling, 18 September 2026.** Offered options A (ghost on top) and B (scratch copy); he chose:

> **"1. A — ghost on top … Leave the photograph alone. Draw the new outline and where the label/text would land
> on top of it, as a ghost."**

**Published by the behaviour side (Claude) under ruling B. The window is built by Codex from this document.**

---

## 1. Why this exists — the history, so it is not rebuilt the same way

**16 September.** Tim asked for the picture in Edit Pit / Edit Pipe to show what Save *would* do. It was built
(`DRYRUN-01`) and it worked: type 1200 into a 450 pit and the picture redrew with a bigger pit and the label
stepped out.

**17 September — withdrawn.** The picture is **a render of the live drawing** (`PlanAreaRenderer.Render` against
`document.Database`). The only way to show the change was to genuinely apply it, render, then abort. **The abort
did not hold:** the writers it called open and commit transactions of their own —
`PitEditCommand.ShiftAnnotation` and `ProjectDataService.SaveToDrawing` each start and commit one. Codex's
structured log shows **`Project data saved to DWG successfully` six times while the preview was only
redrawing**.

**18 September — the correction that matters here.** The withdrawal was also credited with fixing **P13** (a
cancelled editor window still costing one Undo). **That was wrong and is corrected in `REGRESSION_LOG.md`.**
P13 happens on a window that wrote nothing, is **still OPEN**, and its cause is **not established**.

> **So the score is honest: Tim lost a feature he had asked for and liked, and the fault it was blamed for was
> never its fault.** The one true reason the dry-run went is that **a preview must never write to the drawing.**

**This contract restores the feature without a writer.**

---

## 2. The rule this design exists to satisfy

> **Nothing in the preview path may open a write transaction, modify an entity, or call a service that saves.**

Not "aborts afterwards". **Never writes at all.** If a future change needs a write to show something, that
something does not go in the preview.

---

## 3. What already exists — build on this, do not invent a parallel mechanism

The overlay this contract needs **is already working** for the end-markers.

| Piece | Where | What it does today |
|---|---|---|
| `_marks` | `Controls/CdPlanPreviewControl.cs`, `Controls/PitBlockPreviewControl.cs` | A `Canvas` sitting **on top of** the rendered photo |
| `PlaceMarkers()` | same files | Clears `_marks` and re-adds WPF shapes each time an input changes |
| `PitPreviewEntryGeometry.TryToPreviewFraction(eastingMm, northingMm, frame, out across, out down)` | `Helpers/PitPreviewEntryGeometry.cs` | **World millimetres → a fraction across/down the picture.** This is the whole coordinate problem, already solved |
| `PitPreviewFrame` | same file | `CentreXMm`, `CentreYMm`, `WidthMm`, `HeightMm` — returned by the renderer with every snapshot |
| `OnInputsChanged` `default:` branch | `CdPlanPreviewControl.cs:109` | Already calls `PlaceMarkers()` on **every** typed change. **The captions already update live.** |

**The ghost is `PlaceMarkers` with more shapes.** No new rendering, no new transaction, no new timer.

---

## 4. The shape of the contract

### 4a. One read, at open. Then pure arithmetic.

The behaviour side takes **one read-only snapshot** when the window opens — using
`StartOpenCloseTransaction`, per the Autodesk guardrails — and never reads the drawing again while the window
is open.

```csharp
// Rules/EditGhostSnapshot.cs — plain data, no Autodesk types
public sealed class EditGhostSnapshot
{
    public double PitCentreEastingMm { get; init; }
    public double PitCentreNorthingMm { get; init; }
    public double CurrentPlanWidthMm  { get; init; }
    public double CurrentPlanDepthMm  { get; init; }
    public double LabelEastingMm { get; init; }     // where the pit-number block sits now
    public double LabelNorthingMm { get; init; }
    public double LabelTextHeightMm { get; init; }
    public IReadOnlyList<GhostPipeEnd> ConnectedEnds { get; init; }
}
```

**Why one read:** it keeps every later recomputation pure, unit-testable without AutoCAD, and incapable of
touching the drawing. It also means typing is arithmetic, not database work — no debounce needed for the ghost
itself.

### 4b. The ghost is computed by a pure rule

```csharp
// Rules/EditGhostPlan.cs — pure. No Autodesk.* calls. Fully unit-testable.
public enum GhostKind { Outline, Text, Leader }

public sealed class GhostShape
{
    public GhostKind Kind { get; init; }
    /// World millimetres. Outline/Leader: the polyline points. Text: one point, its insertion.
    public IReadOnlyList<GhostPoint> Points { get; init; }
    public string Text { get; init; }          // Kind == Text only
    public double TextHeightMm { get; init; }  // Kind == Text only
    public double RotationDeg { get; init; }
    /// Why this shape is on screen, in Tim's words, for the tooltip. e.g. "where the pit number will move to"
    public string Because { get; init; }
}

public static class EditGhostPlan
{
    public static IReadOnlyList<GhostShape> ForPit(EditGhostSnapshot now, PitGhostInputs typed);
    public static IReadOnlyList<GhostShape> ForPipe(EditGhostSnapshot now, PipeGhostInputs typed);
}
```

`PitGhostInputs` / `PipeGhostInputs` are the **typed values from the view model** — plan width, plan depth,
label corner, cover-text corner, diameter, text side, inverts. Nothing else.

**The placement arithmetic already exists and must be reused, not re-derived:**
`Rules/LabelPlacementRule.Spots(...)`, `LabelPlacementRule.EffectiveSlideLimitMm(...)`,
`LabelPlacementRule.CalloutShifts(...)`. **PLACE-01 (slide ≤ Settings, never > 500 from the end, then flip)
governs the ghost exactly as it governs the real placement** — otherwise the ghost would promise something Save
would not do, which is worse than no ghost at all.

### 4c. What the view model exposes

```csharp
public IReadOnlyList<GhostShape> Ghost { get; }   // recomputed on every relevant PropertyChanged
public bool GhostAvailable { get; }               // false when the snapshot could not be taken
```

`Ghost` is **empty** — never null — when there is nothing to show.

---

## 5. What Codex builds

In `CdPlanPreviewControl` and `PitBlockPreviewControl`, extend `PlaceMarkers()`:

1. After placing the existing end-markers, iterate `_viewModel.Ghost`.
2. For each shape, convert **every** point with `PitPreviewEntryGeometry.TryToPreviewFraction(...)` and map it
   through the same `left / top / width / height` letterboxing `PlaceMarkers` already computes.
3. Draw:
   - **`Outline`** → a `Polyline`/`Path`, **dashed**, accent colour, ~1.5 px.
   - **`Leader`** → a thin dashed line, same colour.
   - **`Text`** → a `TextBlock` with the real text, **at the size it will actually be on the drawing** (scale
     `TextHeightMm` through the same picture scale), **~60 % opacity**.
4. Set each element's `ToolTip` to `shape.Because`.
5. **Skip any shape whose points fall outside the picture.** Never clamp a ghost to the edge — a ghost in the
   wrong place is a lie.

**Styling:** accent colour via `SetResourceReference`, as `PlaceMarkers` already does. Dashed and semi-transparent
so it can never be mistaken for what is on the drawing. **No animation, no fade, no motion** — the cockpit rule.

**One line of plain English under the picture when `Ghost` is not empty:**

> **`Dashed = where this will land when you press Save.`**

Plain English, no jargon (R-00 / the plain-English UI rule). **Not** "preview overlay", **not** "dry run".

---

## 6. What it must NOT do

| Must not | Why |
|---|---|
| Open a write transaction, or call `ApplyPitEdit`, `ShiftAnnotation`, `SaveToDrawing`, `RegisterPipe` | The whole reason the last one was withdrawn |
| Re-read the drawing while the window is open | Keeps it pure; keeps typing fast |
| Show a ghost that PLACE-01 would not actually produce | A ghost that lies is worse than none |
| Clamp an off-picture ghost to the edge | Same reason |
| Scroll, animate, or add a legend panel | No-scroll rule; cockpit rule |
| Claim to fix P13 | It does not. P13 is open and its cause is not established |

---

## 7. How it is proven

**Pure rule — unit tests, no AutoCAD (mine):**

- `ForPit_PlanGrows450To1200_LabelGhostStepsOutByTheSameRulePlacementUses`
- `ForPit_LabelCornerChanged_GhostMovesTextAndLeaderTogether` — **the BUG-151 shape**: the number and its
  circle must move as one. The real fix landed on 18 September (`AnnotationMoveService.MoveWithAttributes`);
  the ghost must agree with it.
- `ForPit_SlideWouldExceed500FromEnd_GhostFlipsInsteadOfSliding` — PLACE-01 parity.
- `ForPipe_TextSideChanged_GhostTextCrossesThePipe`
- `ForPipe_DiameterChanged_GhostTextReadsTheNewSize`
- `ForPit_SnapshotUnavailable_ReturnsEmptyNotNull`
- **A source guard: no file under `Rules/EditGhostPlan*` may reference `Autodesk.` or `Transaction`.** This is
  the rule that stops the last mistake coming back quietly.

**In AutoCAD — Tim's steps, for the test list:**

1. Open Edit Pit on a 450 pit. Change 450 to 1200. **A dashed bigger outline appears; the pit on the drawing
   does not change.**
2. **Cancel. Press `U` once.** Your own previous edit undoes. *(Note: the extra-Undo fault P13 may still be
   present — it is unrelated and unfixed. Record what happens either way.)*
3. Change the pit label corner. **The dashed number and its dashed circle move together.**
4. Save. **What lands is where the ghost was.** If the ghost and the result disagree, that is the fault worth
   reporting — not the ghost being ugly.
5. Type quickly. **No flicker**, and the photo underneath never redraws.
6. Blank the pit size. **The ghost disappears**; no error.
7. Edit Pipe: change diameter and text side. **The dashed pipe text reads the new size on the new side.**

---

## 8. Ownership and order

| | |
|---|---|
| `Rules/EditGhostPlan.cs`, `Rules/EditGhostSnapshot.cs`, the snapshot read, the view-model property | **Claude** (behaviour) |
| `CdPlanPreviewControl`, `PitBlockPreviewControl`, the styling, the caption line | **Codex** (windows, ruling B) |

**Order:** the rule and the view-model property land first, with the unit tests and the source guard. The
window can then be built against a property that already returns real shapes. **Codex is not blocked on the
window** — it can build against the types in §4 before the rule is finished.

**Not started at the time of writing.** This is a published contract, not a claim of work done.
