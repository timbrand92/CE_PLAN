# ST-01 — Beams and explicit structural links

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-64`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Ideas for later — needs Tim's drawing examples

| Idea | Intended drafting result | Before it can be built |
|---|---|---|
| **ST1-I1 — automatic house inside/outside** | While drawing beams with `1`, `2`, `4` or `5`, CE understands the building interior. A beam or lintel on the outside wall places its label on the outside of the house automatically. | Tim walks through simple, L-shaped, stepped and courtyard examples so “inside” is defined correctly. Then fold the rule into ST1-5/ST1-7's one preview-and-placement side resolver. |

This is banked only. It does not change the approved ST-01 implementation scope until the examples and edge cases
are reviewed with Tim.

## Approved source card — verbatim

# ST-01 — Structural beams and links

## Current AutoCAD state

| Tool | What works | Required direction |
|---|---|---|
| `1` / `2` | Strong regular/lower beam core; unified point/support input | Refine final XREF, UCS and cancellation behaviour |
| `4` / `5` | Shared special/offset-beam engine | Direct workflow evidence is weaker; rebuild prompts and atomicity |
| Label placement | Beam-relative resolver, wall/opening logic and preview exist | One resolver everywhere; remove remaining conflicting offsets |
| `BDL` | Draws paired upper/lower beams with outside labels | Pair currently behaves as two separate beams |
| `BEXT` | Extension geometry has strong automated evidence | Currently finds label by proximity; cancelling after extension can retain the change |
| `BTX` | TEXT↔MTEXT conversion and visual centring work | Conversion replaces the entity without clearly preserving its beam ownership |
| Beam links | Beam/support/text movement and deletion reactions exist | Copy becomes orphaned; migration and support linking rely on nearest-object guesses |
| Beam placement generally | Familiar numbered commands | Currently forces a drawing save after successful placement—remove for control and smoothness |

## ST1-1–ST1-15 for approval

| ID | Recommended decision | AutoCAD result |
|---|---|---|
| **ST1-1** | Keep `1`, `2`, `4`, `5`, `8`, `BDL`, `BEXT` and `BTX`. Do not revive separate `1A/2A/4A`; support input belongs inside `1/2/4`. | Existing primary muscle memory remains unchanged. |
| **ST1-2** | A beam compound owns its geometry and label. Supports are linked structural objects—not beam-owned children. | Moving or deleting a beam cannot silently destroy a column/support. |
| **ST1-3** | Input order: use valid preselection → support/line picks → point input. Prompts appear only when required. | Preselect two supports and type `1`; CE proceeds directly to beam text. |
| **ST1-4** | Store geometry in drawing coordinates and make decisions in beam-local coordinates. Pick direction and rotated UCS must not reverse label behaviour. | Picking left-to-right or right-to-left produces the same readable result. |
| **ST1-5** | Use one side/clearance resolver for Preview and final placement across `1/2/4/5/BDL/BEXT`. Site and unknown XREF layers cannot drive placement. | The accepted preview cannot flip sides when committed. |
| **ST1-6** | Adopt one 45 mm base label offset and 70 mm extra lift for suffix-style MTEXT. Context may push text outward but never closer. Retire routine Regular/Large prompts. | A wall may move the label farther away; an empty area uses 45 mm. |
| **ST1-7** | Wall/opening evidence drives ordinary side selection. Stored inside-points remain an optional lintel aid and are visible/resettable; a cancelled beam cannot leave a new inside-point behind. | `BSET` assists unusual footprints without becoming another hidden authority. |
| **ST1-8** | Perpendicular auto-trim must appear in Preview. A midspan support may suggest `CONT.`, but the suffix requires confirmation unless an approved beam relationship proves continuity. | A nearby support cannot silently convert two beams into one continuous member. |
| **ST1-9** | Command `5` remains distinct because it offsets beam geometry. Keep standard presets, permit an entered distance and show the actual offset side before placement. | “100 below picked axis” is visible before committing. |
| **ST1-10** | `BDL` creates one paired assembly with a stable pair identity, fixed separation and two outside labels. | Moving or copying the pair retains its offset and label sides. |
| **ST1-11** | `BEXT` uses the beam’s owned label—not the nearest text. Preview the chosen end, boundary hit and trim-back; Cancel changes nothing. | Extending B2 cannot drag B3’s nearby label. |
| **ST1-12** | `BTX` preserves visual centre, rotation, style, text and beam ownership in one operation. `BTXT2MT/BMT2TXT` become genuine hidden aliases to `BTX`. | Converting a label does not break later beam movement. |
| **ST1-13** | AutoCAD selection governs movement. Beam-only MOVE carries its label, not unselected supports. Moving a support updates all explicitly linked beam ends. Deleting a beam removes its label only; deleting a support marks affected ends unresolved. | A shared column cannot disappear because one attached beam was erased. |
| **ST1-14** | COPY gives the complete copied assembly fresh identities and links copied labels—not originals. Legacy migration becomes preview-based; ambiguous nearby supports/text remain unresolved. | Copying B1 creates an independent B2, not an orphan requiring manual relinking. |
| **ST1-15** | Every command is atomic: Cancel leaves nothing, one Undo removes the complete result, and beam commands never force `QSAVE`. Link updates run once at command end and only inspect touched objects. Automated tests cover most cases; Timothy performs one ≤10-minute beam test. | No partial beam after Esc, no surprise save and no drafting lag. |

**Recommendation: approve ST-01 all.** The sharpest safety correction is ST1-13: supports may be shared, so they must never be treated as disposable children of one beam.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-65

WHAT IS ALSO IMPORTANT IS HOW THE COMMANDS WORK IN AUTOCAD NOT JUST SAFETY AND HOW THEY WORK

✅ Approve ST-01 all
Good first structural card — and the important thing is that it doesn't blindly copy the civil model. It adapts it where structural is genuinely different, which is exactly where the sharpest decision lives.

🏛️ ST1-2 + ST1-13 — the keystone, and you're right it's the sharpest
The key insight is a difference in ownership between the two disciplines:

Civil: a pit owns its pipes — compound-owns-its-children (CV3-14, etc.).
Structural: a support is shared — a column holds up several beams, so it's owned by none of them.
If you applied the civil "compound owns its children" pattern here, deleting one beam would delete a column that's holding up three others — real structural-model destruction. ST1-13 gets the shared-resource lifecycle exactly right:

Action	Result
Beam-only MOVE	carries its owned label, not the shared supports
Move a support	updates all explicitly linked beam ends
Delete a beam	removes its label only — the shared column stays
Delete a support	affected ends marked Unresolved — not silently deleted, not silently re-linked
"A shared column cannot disappear because one attached beam was erased" is the guarantee, and it's the most important structural-correctness call on the card. Deleting a support flagging the orphaned beam ends (rather than guessing) is the fail-loud, engineer-decides behaviour.

📋 ST1-14 — probably the single most-wanted structural fix
Copy was broken badly enough (BEAMLINKMIGRATE, orphaned copies) that beam-linking was switched off by default. ST1-14 gives a copied assembly fresh identities and copied-label links (not the originals) — so "copying B1 creates an independent B2," no manual relinking step. That's CV20 applied to beams, and it's the thing that makes the whole beam-link system usable again. Big one.

🔩 ST1-8 — a real structural-correctness catch
"CONT." isn't a label — it's a structural designation. A continuous beam over a support behaves differently than two simply-supported beams meeting there. So auto-merging two beams into one continuous member because a support is nearby is a silent change to the structural model driven by proximity. Requiring confirmation (unless an approved relationship proves continuity) is right: continuity is an engineering decision, not a distance guess.

✅ Three quick affirms
ST1-5 — one side/clearance resolver for preview and final placement means the accepted preview cannot flip sides on commit (HD2/rule #1 applied to label placement — the classic beam-label-flip bug, gone).
ST1-12 — BTX preserves beam ownership through the TEXT↔MTEXT conversion, so converting a label no longer silently breaks later beam movement (the CV4-14 "keep the ownership through the entity swap" principle).
ST1-15 — killing the forced QSAVE after placement is a genuine everyday-smoothness fix, and "link updates run once at command end, inspecting only touched objects" is the safe, non-scanning reactor model (rule #4 + the no-lag budget).
🔒 Locked, nothing starts
Beam owns its label; supports are shared and protected; copy works; previews don't flip; no surprise saves. The structural section is off to a strong, correctly-adapted start. Ready for the next.
