# ST-04 — Structural text and tag placement

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-135`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

## ST-04 — Structural text and tag placement

### Overall progress

| Status | Count |
|---|---:|
| Decision-complete sections | **31** |
| Current section | **ST-04** |
| Next section | ST-05 |
| Implementation | **Not started** |
| Shared corpus | Separate evidence task |

ST-04 mechanics can be planned now. The corpus will later refine contextual placement preferences.

### Current AutoCAD command state

| Commands/tools | Current result | Proposed treatment |
|---|---|---|
| `18L/R`, `25L/R`, `25T/B` | Useful familiar shortcuts | **Keep and modify** |
| `EBT/EBB`, `IBT/IBB`, `BEBT/BEBB` | Quickly create structural marks | **Keep aliases; rebuild shared placement** |
| `THL/THR`, `PFL/PFR`, `BPL/BPR` | Useful support tags | **Keep; add visible preview and ownership** |
| `SFT/SFB`, `BSFT/BSFB` | Text and footing behaviour mixed together | **Separate text from footing geometry** |
| Left/right/top/bottom selection | Spread across many commands | **Unify with Flip during preview** |
| Native TEXT/MTEXT | Editable with normal AutoCAD grips | **Keep native** |
| `R2LTXT` | Useful conversion but potentially broad | **Controlled preview and one Undo** |
| `THC/PFC/SF` | Text, rectangles and trimming mixed together | **Geometry moves to ST-06** |
| `COPYM/CEMCOPY` | Copy helper, not a text function | **Move to shared command ownership** |
| Palette text assets | Many anonymous/exploded dependencies | **Replace with Approved catalogue assets** |

The current oversized tool mixes text placement, footing geometry, trimming, copying and layer repair. ST-04 separates these responsibilities.

## Decisions ST4-1–ST4-15

| # | Recommended decision |
|---:|---|
| **ST4-1** | ST-04 owns structural text, short tags and controlled text conversion. Footing rectangles and strip geometry belong to ST-06; long standard notes belong to ST-07/AS-01. |
| **ST4-2** | Add one canonical **CE Text** workspace in the AutoCAD Plugin standards browser. Keep existing command aliases permanently for staff muscle memory. |
| **ST4-3** | Every alias becomes a preset containing its role, prefix, layer, plotted height, justification, preferred side and rotation behaviour. All presets use one placement backbone. |
| **ST4-4** | Create native TEXT/MTEXT using individually **Approved** CE styles and assets. Do not insert and explode anonymous palette blocks to create ordinary text. Candidate assets remain Preview-only. |
| **ST4-5** | Normal workflow: **select reference if applicable → enter text → live preview → Flip/Rotate → click**. The accepted preview and final result must be identical. |
| **ST4-6** | Prefix commands show the complete result before placement. Example: `EBT` + `1` previews `EB1`. Typing `EB1` must not create `EBEB1`. CE never invents the structural designation. |
| **ST4-7** | `L/R/T/B` aliases select only the starting position. During preview, **F = flip side**, **R = change reference/alignment**, and **Tab = ranked alternative** where available. |
| **ST4-8** | Heights are based on plotted paper size and drawing/viewport scale—not a blindly hard-coded model-space height. Existing 18/25/35/50/70 conventions begin as Baseline Candidates until catalogued as Approved. |
| **ST4-9** | Generic notes remain independent. Beam, support and foundation labels store an explicit relationship to their parent; proximity is never sufficient proof of ownership. |
| **ST4-10** | MOVE preserves a deliberate position. COPY gives owned labels fresh identity with the copied parent. EDIT preserves location and ownership. ERASE label does not erase its parent. TEXT↔MTEXT preserves links. |
| **ST4-11** | `R2LTXT` operates only on recognised eligible text. Before Apply, show the selected count and preview. Preserve content, rotation, position and ownership; complete as one Undo. |
| **ST4-12** | Last-used text may appear as a visible default within the current drawing/session. Engineering marks and values must not silently carry into another project. |
| **ST4-13** | The future Pattern Atlas can recommend clearer positions and flag plotted-sheet clashes. A manual position wins over soft preferences; genuine clashes remain visible QA findings. |
| **ST4-14** | Esc at any prompt leaves nothing behind. Restore the previous layer, style and snaps; no forced save; no hidden placement state; one Undo removes the complete result. |
| **ST4-15** | Test the shared behaviours rather than making Timothy test every alias. Automated checks verify every alias-to-preset mapping; Timothy performs about five representative AutoCAD placements in under ten minutes. |

## Exact AutoCAD behaviour

### Example 1 — beam tag

```text
Command: EBT
Select beam B4
Enter designation: 1

Preview: EB1 above B4
F: flips EB1 below B4
Click: places native editable text linked to B4
Esc: creates nothing
Undo: removes the complete placement
```

After placement:

| Action | Result |
|---|---|
| MOVE `EB1` | Position is retained—no snap-back |
| MOVE B4 | Linked label follows appropriately |
| COPY B4 | Copy receives its own linked label identity |
| EDIT `EB1` | Ownership and position remain |
| ERASE `EB1` | Beam remains |
| ERASE B4 | Label becomes unresolved or follows the approved compound rule—never silently attaches elsewhere |

### Example 2 — general structural note

```text
Command: 25L
Enter: PROVIDE 2-N12 TRIMMERS
Preview at approved plotted height
R: align to selected structural reference
Click: places native independent text
```

It does not become attached to a nearby beam merely because it is close.

### Example 3 — footing command boundary

```text
SFT / THC / PFC
```

The familiar alias remains available during transition, but:

- ST-04 owns its text placement.
- ST-06 owns its rectangle, footing and trimming geometry.
- Nothing is removed until the ST-06 replacement passes.

### Minimum Timothy test later

1. Place one generic `25L` note.
2. Place one prefixed `EBT` mark.
3. Flip and rotate one preview.
4. MOVE/COPY/EDIT/ERASE one owned beam label.
5. Preview and Undo one `R2LTXT` conversion.

No implementation, build or deployment begins with this approval.

Reply **“Approve ST-04 all”** or list the decision numbers to revise.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-136

✅ Approve ST-04 all
The win here is architectural, and it's the anti-sprawl fight moving down a level — from *commands* to *code*.

**🧱 ST4-1 + ST4-3 + ST4-15 — sprawl cured at the implementation level**
Two moves, both aimed at the god-command the audit flagged (text + footing + trimming + copying + layer-repair, all mixed):

**ST4-1 splits responsibilities.** ST-04 owns *text*; footing geometry goes to ST-06; long notes to ST-07/AS-01; copy to shared ownership. That's rule #10 (no god-objects — the exact 3,700-line-file pattern the log named as the breakline regression cause), applied to a command instead of a file.
**ST4-3 collapses the dozens of text aliases into one placement backbone + data-driven presets.** Every alias (18L/R, 25T/B, EBT/EBB…) becomes *data* — role, prefix, layer, height, side — on **one engine**. Same familiar aliases for muscle memory; one implementation underneath instead of dozens that drift apart (which is how PipeEditCommand.BuildGradeValue "drifted from" CdCommand.BuildGradeValue in the first place).
And **ST4-15 is the payoff of that architecture:** because it's one backbone + a preset table, you **test the backbone once and verify the alias→preset mappings as data** — not by driving every alias in AutoCAD by hand. The design is what makes the testing tractable. This is P8 ("too many commands") answered where it actually lives — in the code, not just the ribbon.

**🧩 ST4-4 brings AS-01 down to the text level**
Ordinary text should simply **be** native TEXT/MTEXT with an approved CE style — **not an inserted-then-exploded anonymous palette block.** That's the 145-exploding / 614-anonymous findings from AS-01, applied to text creation. Don't manufacture text by destroying a block.

**🧼 ST4-12 is a subtle data-hygiene catch**
A "last-used text" default is a fine convenience **within a drawing/session** — but **engineering marks and values must not silently carry into another project.** A level value or beam mark from project A surfacing as a default in project B is cross-project contamination, and for an engineering value that's a potential *wrong number* riding in as a helpful default. Scoping it to the current drawing is exactly right (SH-04 #4 — project data stays with its project).

**✅ Two quick affirms**
**ST4-9** — a generic note stays independent; a beam/support/foundation label stores an **explicit** parent relationship. Proximity never proves ownership (the recurring rule) — a "PROVIDE 2-N12 TRIMMERS" note near a beam doesn't become the beam's label.
**ST4-6** — EBT + 1 → EB1, and typing EB1 must **not** produce EBEB1. No double-prefixing, and CE never invents the structural designation. Small, real, correct.
**🔒 Approve — nothing starts**
Responsibilities separated, aliases preserved as presets on one backbone, native text not exploded blocks, ownership explicit, conversions bounded and previewed, no cross-project value leakage, everything atomic with settings restored. And the ST-06 boundary is respected — the familiar footing/trim aliases stay live until their ST-06 replacements pass. Ready for ST-05.
