# CE Civil overnight candidate — simple AutoCAD acceptance check

**Status:** Prepared only. Do not use until Codex confirms the candidate has been deployed after AutoCAD is closed.

## What this one check proves

```text
ordinary Structural drawing stays fast
                 +
pipe children keep native editing and show different CE grips
                 +
invert edit updates its grade wording
                 +
Flip Side and user placement survive Undo and reopen
                 +
reasonable pipe routes are kept when connection meaning is uncertain
```

## Part A — ordinary non-Civil drawing

1. Open a Structural or ordinary AutoCAD drawing containing many normal polylines.
2. With `CDDEBUG` off, try `MOVE`, `STRETCH`, `ROTATE`, `COPY` and `MIRROR` on ordinary objects.
3. Confirm each command starts immediately, no Civil message appears and nothing becomes a Civil pipe.
4. Press Escape during one COPY and confirm nothing further happens.

## Part B — one linked Civil pipe

1. Open a disposable copy of a Civil drawing containing one linked pipe with a pipe label, invert text and flow arrow.
2. Click each child separately.
3. Confirm the exact object keeps its normal AutoCAD grips, its owning pipe highlights and the Inspector names the selected part.
4. Confirm the CE marker differs by part: square for pipe label, X for invert and triangle for flow arrow.
5. Use Slide, Offset and Flip Side. Confirm only the chosen child's drafting position changes.
6. Repeat Flip Side on one newer MText invert and one older plain AutoCAD invert label. Confirm each moves cleanly above/below the pipe and stays readable.

## Part C — linked invert and grade

1. Note the current invert and pipe grade wording.
2. Edit that linked invert by the normal plan-text/CDEDIT path.
3. Confirm the Inspector shows the edited invert and the pipe grade wording updates from both end inverts.
4. Confirm the visible pipe type remains exactly the same.

## Part D — Undo and reopen

1. Move one label to a deliberate non-standard position.
2. Save, close and reopen the drawing. Confirm the chosen position remains.
3. Make one additional placement change and run one `UNDO`. Confirm the visible part and stored placement return together.

## Part E — assist-first route

1. On a disposable drawing, draw from a proven downpipe/source to a snapped point on one existing CE pipe.
2. Confirm the proven downpipe/source end is recognised from its stable identity, while the pipe meeting is reported only as a proposed **plan contact**. CE must not replace the source with a nearby pit, claim a proven pipe junction or invent an invert, direction, branch or LPD.
3. Draw a free-ended pipe. Confirm it remains drawn and the end is reported unresolved.
4. Repeat at a point with several possible CE pipes or an overlapping Xref. Confirm CE keeps the route and leaves the intended connection unresolved/ambiguous rather than guessing. The current candidate does not yet list an Xref pipe as a named connection choice.
5. Draw one pipe between two existing CE pipes, then one from free space to an existing CE pipe. Confirm CE reports both plan contacts accurately without calling them proven physical connections; one proposed/ambiguous end must not hide an unresolved opposite end.
6. Lock the layer of one existing CE pipe, then draw a new route to it. Confirm the new route remains and CE changes nothing in the locked pipe. The current review may record the plan contact, but no `Connect here` drafting action is expected yet.
7. Draw one linked pipe with `Include in schedule` turned off. Confirm the pipe still identifies normally in the Inspector and retains its connection review, while its row is absent from the plotted schedule.

## Part F — normal AutoCAD protections

1. Put one linked pipe label on a locked layer and select it. Confirm normal AutoCAD locking remains in charge and CE does not let Slide, Offset or Flip Side move it.
2. Start REFEDIT on a disposable external reference containing Civil-looking content. Confirm CE does not offer or run its extra direct-manipulation actions inside the reference edit.
3. Select Civil-looking text inside an Xref. Confirm it remains read-only and is not adopted as a linked CE child.
4. Finish REFEDIT and unlock the local test layer. Confirm the proven local CE child becomes editable again.

## Send back

For each part, reply only `PASS` or describe what was visible and what you expected. A short screen recording is ideal for any failure.
