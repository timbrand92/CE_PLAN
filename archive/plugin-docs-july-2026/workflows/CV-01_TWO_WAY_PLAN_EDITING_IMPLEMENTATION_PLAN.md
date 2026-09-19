# CV-01E — Two-way plan editing and connected pipe flow

**Decision:** approved by Tim, 2026-07-23
**Implementation:** CV-01E1/E2/E3 code complete — AutoCAD verification pending
**AutoCAD verification:** pending
**Deployment:** not authorised
**DATA-01:** remains blocked and is not used by this work

## What the drafter should experience

```text
CD / CDEDIT ────────┐
                    ├── identify the two connected ends
Native plan edit ───┘            ↓
                         resolve the real flow
                                  ↓
                     data + labels + arrow + schedule
```

`CDEDIT` remains a fully supported, equal way to work. Direct plan editing is an
additional doorway into the same Civil data and drawing-update path.

## Connection-aware reversal

Example:

```text
Before: P1 IL 18.50  ─────→  P2 IL 18.00

Edited: P1 IL 17.90  ←─────  P2 IL 18.00
        result shown as P2 → P1
```

The invert stays attached to its physical pit/end. CE changes the hydraulic
`FROM`/`TO` meaning; it does not swap the entered numbers between pits.

## Failure matrix

| Situation | CE action |
|---|---|
| Two different connected ends + two unequal gravity inverts | Resolve high IL → low IL; update direction, endpoint roles, labels, arrow and schedule |
| Pick-order mode | Keep first picked end → last picked end |
| Rising main | Keep its stored pump/design direction; do not infer pump direction from gravity fall |
| Missing or equal inverts | Flow is **Unknown**; preserve the existing stored direction |
| One/no proven connection | Preserve current stored behaviour; do not guess from the nearest unrelated pit |
| Both ends resolve to the same pit | Treat as invalid/ambiguous; do not create a loop or silently reverse |
| User-moved pit | At command end, update pit position, linked pipe ends, labels and linked schedule |
| User-moved/stretched CE pipe | At command end, refresh its proven connections, length/grade display, labels and linked schedule |
| User-moved owned label | At command end, retain the new label position and keep its linked value |
| User directly edits CE-owned label text | After the native text command ends, update the exact linked field, related labels, arrow and schedule. Invalid/ambiguous text remains visible but linked data stays unchanged and CE directs the user to `CDEDIT` |
| XREF object | Read-only; never write through the host drawing |
| Locked layer / unsupported object | Respect AutoCAD protection; do not unlock or bypass |
| Cancel / Escape | No CE apply pass; clear captured edit state |
| Undo / Redo | Rebuild CE caches from the restored drawing state |

## Safe technical shape

1. `ObjectModified` records **identity only** (the changed entity handle).
2. CE waits for AutoCAD's command to finish.
3. A clean command-end transaction classifies the changed CE object.
4. Existing link/update services apply the one change to drawing data,
   annotations and linked schedule cells.
5. The runtime caches rebuild from the resulting drawing.

No database object is opened from inside `ObjectModified`. This preserves the
AutoCAD 2027 / .NET 10 crash guard established by BLK-009 and BUG-053.

## Increment boundary

### CV-01E1 — now

- one pure, tested connected-flow resolver;
- `CDEDIT` live preview and saved `FROM`/`TO` use that resolver;
- reversed gravity direction updates endpoint roles without moving values to the
  wrong pit;
- missing/equal/unconnected cases preserve the current stored direction.

### CV-01E2 — now

- capture native MOVE/STRETCH/grip-style CE object changes by handle only;
- after command end, feed changed pits, pipes and owned labels into the existing
  safe link, annotation and schedule refresh path;
- update moved pit positions in Civil project data.

### CV-01E3 — code complete; AutoCAD proof pending

- snapshot the exact CE-owned field before AutoCAD opens its text editor;
- capture only the changed handle while AutoCAD owns the command;
- after command end, parse and apply the final value through a dedicated path;
- update linked network data, proven flow, related labels and schedule without
  rewriting the text object the user just edited;
- invalid or ambiguous engineering text remains visible, leaves linked authority
  unchanged and directs the user to review it in `CDEDIT`;
- Cancel/Escape clears the snapshot and makes no linked change;
- release still requires the corruption, one-Undo and save/reopen AutoCAD proof.

### CV-01E4 — approved; build before the CD window rebuild

- repair the draw-first sequence so AutoCalc opens only after the new pipe's
  two endpoints have been identified;
- show the proven connection, for example `PP → P3`, in the initial preview
  and Flow / Inverts page;
- keep polyline drawing direction separate from hydraulic flow direction;
- prompt when the entered levels indicate the opposite flow, with no silent
  reversal or endpoint-invert swap;
- keep missing/equal/ambiguous flow as `Unknown`;
- update the confirmed arrow, text, endpoint roles and schedule together;
- preserve staff-entered/locked values, OSNAP, UCS, Cancel, one Undo and
  save/reopen behaviour;
- use the exact approved plan in
  [`CV-01E4_CD_DRAW_FIRST_AUTOCALC_PLAN.md`](CV-01E4_CD_DRAW_FIRST_AUTOCALC_PLAN.md).

### Later reviewed slices

- a visible Inspector `Needs review` queue for ambiguous engineering edits;
- full change history and Fixed/Designed provenance;
- XREF-host schedule refresh through PS-01D.

### CV-01E3 field behaviour

```text
Edit owned plan text
        ↓
CE identifies the exact pipe/end and field
        ↓
Update network data
        ↓
Direction + arrow + labels + PITSCHEDULE
```

| Edited CE object | Required result |
|---|---|
| Pipe-end invert text | Keep the value attached to that physical end; recalculate proven flow, grade, arrow, endpoint roles and schedule |
| Pipe size text | Update the linked pipe size and schedule; show design review when capacity may be affected |
| Grade or length text | Apply only when the text maps unambiguously to an editable CE field; otherwise show review rather than guessing |
| Pit number or level text | Update the owned pit record, connected labels and schedule after duplicate/level validation |
| Free remark or supplementary text | Preserve it as annotation; do not reinterpret it as engineering data |
| Unowned/ambiguous text | Make no linked change and offer `Review in CE Civil` |

The text reactor remains identity-only while AutoCAD owns the command. CE reads
and validates the final text only after `DDEDIT`, `TEXTEDIT` or equivalent has
ended. Invalid text, Cancel and Escape leave linked data unchanged. A successful
linked update must be one AutoCAD Undo action.

## Banked smart-Civil ideas

These stay parked until CV-01E1/E2/E3 is tested in AutoCAD.

| Candidate | User-visible result | Suggested order |
|---|---|---:|
| NH-01 Network health checker | Highlights disconnected pipes, duplicate pit IDs, flat/backfall pipes and missing levels | 1 |
| CV-01F Pit level assistant | Suggests inlet/outlet levels from proven connected pipes and flags impossible combinations | 2 |
| PS-01D Plan–schedule difference viewer | Shows exactly what will change before a broad schedule update | 3 |
| CV-01G Design-change impact preview | Shows downstream pipes and schedule rows affected before applying a change | 4 |
| CV-01H Network redesign assistant | Uses nominated top/bottom control points or a relocated LPD to preview reuse, reversal and regrading of existing pits/pipes; Apply always requires user sign-off | 5 |
| PS-01E XREF network watcher | Warns when the drainage XREF changed and the main drawing schedule needs refreshing | 6 |
| CV-01I Smart annotation tidy-up | Reduces label/arrow clashes while preserving manually placed offsets | 7 |
| CV-02A Assisted automatic pipe sizing | Uses design flow, grade and material to suggest the smallest suitable pipe; separates `Drafting from designed plan` from `Designing from scratch`, and never applies without user sign-off | 8 |

### Approved product rule for design assistance

Every design-assistance surface must ask which job the user is doing:

1. **Drafting from a designed plan** — preserve the supplied engineering design,
   enter it quickly and report inconsistencies without silently redesigning it.
2. **Designing from scratch** — CE may calculate and recommend alternatives, but
   must show a before/after impact preview and require explicit end-user sign-off
   before changing the drawing, linked data, labels or schedule.

The network redesign assistant must support a preliminary LPD being moved to the
opposite side of a site. It should reuse pit locations and pipe routes where
practical, recalculate direction/levels/sizes as a proposal, identify elements
that cannot meet the new control point, and keep the current network unchanged
until the user approves the reviewed proposal.

## Automated guards

- connected gravity pipe reverses when endpoint levels reverse;
- entered invert values remain bound to the correct physical endpoint;
- missing connection, equal/missing levels and same-pit loop fall back safely;
- pick-order and rising-main design direction stay stable;
- `ObjectModified` performs no transaction/open/read of related DB objects;
- native plan-edit handles are processed only after command completion;
- Cancel clears captured edits;
- a resolved reversal refreshes only the owned CE flow-arrow block; Unknown
  direction leaves the current arrow untouched;
- direct text parsing covers pipe-end inverts, pipe diameter, explicit grade,
  pit CL/IL and pit ID without guessing from free remarks or length text;
- the text reactor performs no transaction, database open or linked mutation;
- the just-edited attachment is excluded from CE's own refresh pass;
- CE suppresses its own `ObjectModified` callbacks while applying linked text;
- attribute editors, Cancel and invalid text follow the same fail-closed path;
- schedule refresh remains after link/data updates.

## AutoCAD version compatibility

| Lane | Compile reference | Runtime proof |
|---|---|---|
| AutoCAD 2022–2024 | Lowest supported API: AutoCAD 2022 / API 24.1 reference assemblies | Still requires a licensed AutoCAD 2022 machine |
| AutoCAD 2025–2026 | Existing .NET 8 lane | Requires matching AutoCAD runtime |
| AutoCAD 2027 | .NET 10 lane | Requires AutoCAD 2027 |

The 2022 compile lane must use a documented reference-only Autodesk source
(ObjectARX 2022 managed references or Autodesk `AutoCAD.NET` 24.1.51000). A
separate AutoCAD 2022 installation is not required to compile, but compile proof
does not replace real load, WPF, command and save/reopen testing.

**Release follow-up:** obtaining and pinning the AutoCAD 2022/API 24.1 reference
set remains an RS-01 compatibility task. The current legacy compile proof used
the available AutoCAD 2024 reference set and must not be described as AutoCAD
2022 runtime proof.

## Tim's later AutoCAD acceptance

1. `CDEDIT` a P1–P2 gravity pipe; reverse the two end levels. Confirm the preview
   changes from `P1 → P2` to `P2 → P1`, then confirm labels, arrow and schedule.
2. Repeat with one endpoint disconnected. Confirm CE preserves the existing
   direction and does not attach to a nearby unrelated pit.
3. MOVE a pit only. Confirm connected pipe end and pit labels follow, then open
   `PITSCHEDULE` and confirm the linked result remains current.
4. STRETCH one CE pipe endpoint to another pit. Confirm the pipe, labels and
   schedule refresh only after STRETCH finishes.
5. MOVE a pipe label independently, then MOVE/STRETCH the pipe. Confirm the
   manually chosen label placement is retained.
6. Cancel a MOVE and Undo a completed edit. Confirm CE makes no extra change and
   the drawing returns cleanly.
7. Double-click a connected pipe-end IL and make the fall reverse. Confirm the
   invert stays on that physical pit, while FROM/TO, arrow, grade and schedule
   change together.
8. Edit pipe diameter and grade text. Confirm pipe graphics and schedule update;
   diameter shows the capacity-review reminder.
9. Edit a pit's CL/IL, then rename `P1` to `P10` with the attribute editor.
   Confirm every linked label, pipe endpoint and schedule row follows.
10. Try a duplicate pit ID, invalid IL, length text and a free remark. Confirm CE
    does not guess or silently alter linked engineering data.
11. Cancel each supported text editor. Confirm no linked value changes.
12. Critical corruption proof: edit ordinary DBText, MOVE it, REGEN, save, close
    and reopen. Confirm it remains visible and selectable. Undo each successful
    CE text edit once and confirm the whole linked result returns together.
