# CE Civil behaviour handoff for Claude-owned UI/UX

**Purpose:** fixed Civil behaviour and engineering boundaries for Claude to express visually. This record does not choose window layout, colours, icons, spacing or visual styling.

## One-sentence product rule

CE Civil should feel like normal AutoCAD with connected Civil understanding: the user draws and edits familiar objects, CE shows what each part belongs to and what else is affected, and uncertain engineering meaning remains visible rather than stopping the drafting action.

## Normal daily interaction

```text
Click the exact line, block, text or arrow
                |
                +-- normal AutoCAD grips remain on that exact part
                +-- its owning Civil item is identified lightly
                `-- docked Civil Properties shows known facts and open questions

Normal Move / Stretch / Rotate / Mirror / Copy / text edit
                |
                +-- drafting-only change: retain it automatically
                +-- linked value change: show every affected display/row first
                `-- uncertain engineering change: keep drawing + mark for confirmation
```

The Civil Properties palette is normally open and docked. Escape clears CE highlights/previews. CE must not force a project wizard, persistent special edit mode or extra form after an ordinary drafting move.

## Fixed selection behaviour

| User clicks | What AutoCAD selects | What CE shows |
|---|---|---|
| Pipe line/barrel | Exact clicked geometry | Owning pipe and its connected representations |
| Pipe label, arrow or invert text | Exact text/arrow with its normal grips plus approved placement grips | Owning pipe, selected part role and linked field |
| Pit/tank/pump/source block | Exact block | Civil family, subtype and connected items |
| Proven child label/callout | Exact child | Owning Civil item; no proximity adoption |
| Ordinary object | Ordinary AutoCAD selection | `Not linked` only; no forced adoption |

`Select Whole Item` is deliberate. Related children are not forced into the selection set merely because they share an owner.

A linked pipe with `Include in schedule = No` remains a real Civil network item. It stays available to the Inspector, connection review and later editing; only its plotted schedule row is hidden.

## Fixed editing doorway

`CDEDIT` and the docked Civil Properties palette are two entrances to the same Civil item and data. They must recognise:

- Stormwater, Charged, Suspended, Rising Main, Detention and Existing pipes;
- pits and authority nodes;
- downpipes, inspection openings, overflows, GIO/IO and other source nodes;
- spoon drains, swales, strip/threshold drains, trench grates and AGI;
- slabs, hardstands, carparks, driveways, gardens/pervious areas and roofs;
- water tanks, OSD/storage devices, pump stations and wet wells;
- raingardens/treatment devices;
- plan, schedule and long-section representations where a proven link exists.

The visible pipe type names above are permanent CE drafting names and must not be renamed by the UI.

## Field behaviour Claude must communicate clearly

| Field/action | Required result |
|---|---|
| Move/slide/offset/flip/rotate a label or arrow | Drafting placement only; engineering value unchanged; user position persists |
| Edit a linked invert, level, size or grade | Show the proposed working value and every linked plan/schedule/profile effect before Apply |
| Type custom displayed wording | Keep the wording and state `Displayed value differs from linked Civil value` |
| Edit calculated output | Preserve the edit as a visible difference; never overwrite the calculation silently |
| Change engineer/authority-approved evidence | Allow a working revision, retain the accepted source and state `Approval to be confirmed` |
| Unknown/conflicting connection | Keep `Unknown`/`Unresolved`; never choose the nearest pipe, pit or LPD |

Editing one linked value must update the one Civil data record first, then every representation reads that accepted value. It must not be a series of unrelated text edits.

## Assist-first connection states

When the user draws from a downpipe/source to a point on another pipe:

| Evidence | Required visible state |
|---|---|
| Exact existing stored junction | `Connected` — show recognised From/To items |
| 2D plan contact within the current 2 mm review tolerance with one current-drawing CE pipe | Keep route; `Proposed connection` — plan evidence only, not a proven physical/hydraulic connection |
| More than one CE pipe within the current 2 mm plan-contact tolerance | Keep route; `Several possible connections` |
| No proven owner | Keep route; `End unresolved` |
| Exact read-only Xref item | Offer it as read-only evidence; never modify Xref |
| Locked/foreign/unsupported target | Refuse only the prohibited link/write; keep ordinary drawn geometry |

Plain choices when needed: `Connect here`, `Choose another item`, `Leave end unresolved`.

No state may invent a pit, invert, diameter, grade, hydraulic direction, branch duty or LPD.

## Surface review behaviour

`Check Current Drawing` may show a temporary non-printing overlay for Roof, Driveway/Carpark, External/Infill Slab/Hardstand, Garden/Pervious and Unknown areas.

- Each area shows measured m² and its source drawing.
- Screen shading is review evidence, not an accepted catchment or runoff coefficient.
- Selection works both ways: row to plan and plan to row.
- Hide, Escape, panel close and drawing change remove the overlay.
- It creates no hatch, layer, Civil record or calculation input until the user/engineer confirms classification.

## Pipe placement grips — fixed meaning

- Native AutoCAD grips always remain.
- CE adds visually distinguishable drafting grips for `Slide Along`, `Offset Across` and `Flip Side`.
- Flip Side swaps above/below placement; it never reverses hydraulic flow.
- `Reverse Flow` is a separate protected engineering action.
- Older DBText and newer MText invert labels must reach the same result.

Claude chooses the Autodesk-quality visual form, colour, size and hover presentation, while keeping those meanings distinct and accessible without colour alone.

## Change preview language

Every proposed coordinated change should answer, in plain AutoCAD/engineering language:

1. What did I select?
2. What will visibly move or change?
3. What linked schedule, long section, calculation or detail is affected?
4. Is this drafting-only, a working engineering value, or approved evidence?
5. What remains unknown or needs engineer confirmation?
6. What will one Undo restore?

## Do not introduce

- compulsory groups that prevent editing individual line/text/arrow parts;
- hidden automatic repair or design approval;
- proximity-based connection or LPD selection;
- modal forms after normal Move/Stretch of drafting children;
- special terminology such as handles, dictionaries, schemas, reactors or object IDs;
- dead-end errors that cancel reasonable new geometry;
- UI changes to Structural, Manager or shared ribbon without a separately controlled CE-wide handoff.

## Current implementation truth for visual planning

The current undeployed Civil source now has these behaviour candidates:

- selected pipe children retain native grips and gain `Slide Along`, `Offset Across` and `Flip Side` placement grips;
- pipe labels, invert labels and flow arrows expose different centre-marker shapes while the action colour continues to identify the drafting action;
- newer MText and older proven CE invert text use the same CDEDIT above/below footprint rule when flipped;
- linked placement is retained separately from pipe type and engineering values;
- CE's added placement actions remain unavailable on locked layers, Xref-owned content, outside the active drawing and during REFEDIT, while normal AutoCAD control remains;
- non-Civil drawings are gated before external-transform and `CLEAN`/`FASTSAVE` Civil cache work;
- nested `C`/`CR`/`MR` commands stay suspended until their outer AutoCAD command finishes; and
- CD creates the route before endpoint review, then stores `Connected`, `Proposed`, `Ambiguous` or `Unresolved` evidence without choosing direction or an LPD; an unresolved end now produces a visible plain-English question instead of a blank result. A 2D plan contact is labelled as plan evidence and never presented as a proven physical or hydraulic connection.

Current endpoint checks: **19/19 passed on net10 and 19/19 passed on net48**, including save/reopen of X/Y/Z picked points, candidate availability and the explicit `PlanEndpointContact2DWithinTolerance` evidence basis. The expanded bounded set passed **113/113 on net10 and 113/113 on net48**, including proof that the intentional full-drawing legacy clone repair remains available only through explicit `CDREBUILD`. The final proportionate full net10 Civil run passed **3689 tests**, with the same five known unrelated repository-state failures and 13 skips (3707 total).

Live AutoCAD acceptance is still required for:

- selected pipe-child grips and older/newer invert Flip Side behaviour;
- the assist-first downpipe/source-to-pipe endpoint states;
- universal CDEDIT recognition, especially SPS block/label/cover text;
- the screen-only surface overlay;
- bounded Civil command tracking without Structural-drawing lag.

Known endpoint gap for UI planning: an exact Xref endpoint is presently kept safe by remaining unresolved; the core does not yet capture it as a named read-only candidate. The existing surface-overlay Xref evidence is not sufficient because it does not identify the attached Xref instance and external pipe object. Do not present that future choice as working until the core provides immutable Xref evidence. If several Xrefs overlap, the eventual UI must list each named source as a separate candidate and never preselect one.

Locked local CE pipes may appear as review-only plan-contact candidates because the core reads them without changing them. Candidate identity and availability-at-review are stored separately (`Editable`, `Locked layer`, `Read-only reference` or `Availability unknown`). The UI should show that captured evidence but must recheck current protection before offering a future action; it must not discard the candidate or substitute another one.

Claude must treat these as candidate behaviours needing acceptance, not already released product truth.

## Source ownership boundary

- **Claude:** UI/UX planning and UI files only after Tim starts a bounded Claude Code task from an exact clean source checkpoint.
- **Codex:** Civil data behaviour, AutoCAD linking, persistence, safety, non-UI source, regression checks, build/audit/release evidence.
- Work is sequential. Claude and Codex must not edit the same files at the same time.

## Acceptance examples

1. Click one invert label: only it has grips; pipe is lightly identified; Civil Properties says `Last-point invert label`.
2. Flip it: it moves cleanly above/below the pipe; grade/direction do not change; Undo restores it.
3. Edit an invert value: preview names the grade wording and schedule/profile fields that will update.
4. Draw DP1 to a snapped point on one CE pipe: DP1 remains the proven source owner; the pipe meeting is only `Proposed plan contact`; no invented level or LPD.
5. Open a Structural plan with hundreds of ordinary polylines: COPY/MOVE/MIRROR remain normal and no Civil message appears.
6. Click an SPS label: it resolves to the SPS item while the exact label remains normally editable; unconfirmed duty/head/levels stay unconfirmed.
