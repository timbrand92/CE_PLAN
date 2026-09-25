# ST-03 — Structural annotation and dimensions

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-114`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-03 — Dimensions, leaders, level/section marks and breaklines

## Current AutoCAD command state

| Commands | Current state | Decision |
|---|---|---|
| `AD`, `LD` | Active wrappers around native AutoCAD dimensions | Keep familiar operation; strengthen state/version handling |
| `Q`, `QD` | Active native leader workflows | Keep and standardise |
| `MLL`, `MLR` | Working fixed-side MLeader with live placement preview | Refine and retest |
| `LM/FFL/RL/SSL/NGL` | Creates level graphic from manual value | Rebuild as linked compound with preview |
| `LMU` | Can replace any selected TEXT/MTEXT | **Unsafe—rebuild** |
| `SM/SECTION` | Creates cut line, bubbles and references | Rebuild as one editable compound with preview |
| `BL` | Two-point polyline; restores settings | Modify scale/current-space behaviour |
| `DSET/DSET1/DUP` | Legacy dimension conversion/update family | Consolidate; remove forced save behaviour |

## ST3-1 — One annotation family

Use one shared standards resolver for:

- layers;
- dimension and leader styles;
- plotted scale;
- text size;
- arrow size;
- current model/paper space.

Keep familiar aliases: `AD`, `LD`, `Q`, `QD`, `MLL`, `MLR`, `FFL`, `RL`, `SSL`, `NGL`, `SM`, `BL`.

**Recommendation: Approve.**

## ST3-2 — Styles must be local and portable

Commands use CE-shipped standards—not Timothy’s personal template path.

They may temporarily activate the required style, but must restore the drafter’s previous layer, style, snaps and other AutoCAD settings afterward.

Existing definitions are never rewritten globally just to place one annotation.

**Recommendation: Approve.**

## ST3-3 — Keep native associative dimensions

`AD` and `LD` should retain normal AutoCAD behaviour:

```text
Preselect or run command
→ pick geometry/definition points
→ finished dimension follows cursor
→ click position
→ native grips and associativity remain
```

- `AD`: dimension along the selected geometry.
- `LD`: horizontal/vertical linear dimension.
- Esc leaves nothing.
- CE applies the correct style without changing the native prompt sequence.

**Recommendation: Approve.**

## ST3-4 — Keep `Q` and `QD` fast and familiar

- `Q`: closed-filled arrow leader.
- `QD`: dot leader.
- Preserve the familiar native leader prompt flow.
- Do not inject hidden AutoCAD command strings after the workflow starts.
- Use native editable leader/text objects—not exploded graphics.

`MLL/MLR` remain the polished MLeader alternative.

**Recommendation: Approve.**

## ST3-5 — Retain arc/radius/diameter dimensions

`RD` workflow:

```text
Select arc/circle
→ choose Length/Radius/Diameter
→ preview native dimension
→ click placement
```

Unsupported or broken geometry is refused rather than producing an incorrect dimension.

**Recommendation: Approve.**

## ST3-6 — Refine `MLL` and `MLR`

```text
Pick arrow point
→ enter/paste note
→ complete leader follows cursor
→ F toggles side if needed
→ click
```

- `MLL` initially faces left.
- `MLR` initially faces right.
- Multi-line text remains supported.
- The actual landing, text and arrow appear during preview.
- Output uses a valid local CE layer, preventing the historical invalid-layer failure.

**Recommendation: Approve.**

## ST3-7 — Rebuild level marks as linked compounds

`FFL/RL/SSL/NGL` workflow:

```text
Choose type through command alias
→ select trusted level source or Manual
→ enter/confirm value
→ complete marker follows cursor
→ F flips side
→ click
```

The marker, tail, label, type, value and source relationship form one object set.

No source means Manual/Unknown—never `0.000`.

**Recommendation: Approve.**

## ST3-8 — Replace unsafe `LMU`

`LMU` may select only recognised CE level marks—not arbitrary text.

```text
Select level marks
→ enter new value/source
→ show affected marks and references
→ Preview
→ Apply
→ one Undo
```

A nearby general note cannot be accidentally changed into a level.

**Recommendation: Approve.**

## ST3-9 — Rebuild section-mark placement

`SM`/`SECTION` workflow:

```text
Enter or confirm section identifier
→ confirm sheet reference
→ pick cut start
→ pick cut end with full line/bubble preview
→ choose view side with cursor or F
→ click
```

Both bubbles, hatch direction, identifier and sheet reference must be visible before Apply.

**Recommendation: Approve.**

## ST3-10 — Section marks become one editable compound

Moving or editing the section mark keeps:

- cut line;
- both bubbles;
- hatch/view direction;
- identifier;
- sheet reference.

COPY creates a fresh internal identity but preserves the visible identifier. A duplicate section reference is flagged for confirmation—not silently renumbered.

**Recommendation: Approve.**

## ST3-11 — Modify `BL`, keep its simple workflow

```text
Pick first endpoint
→ breakline previews to cursor
→ pick second endpoint
```

Required changes:

- draw in the current model or paper space;
- size the zigzag by plotted scale;
- support scales beyond only 1:20 and 1:100;
- respect rotated UCS;
- produce one clean polyline;
- Esc leaves nothing.

Normal MOVE/COPY/STRETCH remains available.

**Recommendation: Approve.**

## ST3-12 — Consolidate dimension repair tools

Replace scattered `DSET/DSET1/DUP` behaviour with one controlled expert workflow:

```text
Select dimensions/leaders
→ show existing and proposed scale/style
→ preview scope
→ Apply
→ one Undo
```

- No whole-drawing conversion by accident.
- No forced `QSAVE`.
- Unrecognised styles remain unchanged and are reported.
- Familiar aliases may redirect to the controlled workflow.

**Recommendation: Approve.**

## ST3-13 — Normal AutoCAD editing remains authoritative

| Action | Result |
|---|---|
| MOVE native dimension | Normal AutoCAD associativity retained |
| MOVE generic leader | User position remains; no snap-back |
| MOVE level/section compound | Entire owned set moves together |
| COPY compound | Fresh identity and correct internal links |
| EDIT level/section mark | Edit the recognised compound, not loose nearby text |
| ERASE compound | Entire owned set removed |
| ERASE generic note | No unrelated object is affected |

**Recommendation: Approve.**

## ST3-14 — Hard-clash and command safety boundary

A drafter’s deliberate position overrides soft Atlas preferences.

However:

- text obscuring a mark;
- a leader crossing structural geometry;
- annotation leaving its viewport;
- an Unknown engineering value

remain visible QA findings.

Every command restores AutoCAD settings, cancels cleanly and applies as one Undo.

**Recommendation: Approve.**

## ST3-15 — Automated testing replaces repetitive Timothy testing

Automated AutoCAD 2022 and 2027 scenarios must cover:

- preselection and normal selection;
- model space and paper space;
- scales 1:20, 1:50 and 1:100;
- rotated UCS;
- missing/local/XREF-dependent styles and layers;
- cancel at every prompt;
- MOVE/COPY/EDIT/ERASE;
- Undo/Redo and reopen persistence;
- large-drawing cursor responsiveness.

Timothy’s final test is limited to approximately ten minutes: one dimension, leader, level mark, section mark and breakline.

**Recommendation: approve ST-03 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-115

we have a standard blocks / notes template can you review and see how you can implement this and also tool palettes and standard details files. it weould be good also once corpus is up and running for you to review this to see what the ce standard drawing looks like.
C:\Users\TimothyBrand\AppData\Roaming\Autodesk\AutoCAD 2027\R26.0\enu\Support\ToolPalette
"C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dxf"
"C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg"
"C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Standard Details"
"C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates"
✅ Approve ST-03 all
First, a strategic note — because this is the right subset to resume ST-03 with. You paused structural planning pending corpus evidence (EV1-2), and annotation is exactly the family where that pause doesn't bite: these are mechanics (native dimension/leader wrappers, compound marks, scale/space handling), not placement-pattern decisions. ST3-14 confirms it — the Atlas is a soft advisor plus QA layer here (a deliberate position overrides it; genuine problems surface as QA findings), not a hard dependency. So these commands can be built now, with the corpus refining their placement defaults later — the "build the mechanics, refine the values later" pattern from CV-05. Sensible place to restart.

🚨 ST3-8 is the sharpest safety fix — LMU was a data-corruption risk
"LMU can replace any selected TEXT/MTEXT" means running it and picking a stray note would turn that note into a level mark — silent data corruption. Restricting it to recognised CE level marks only, with a preview of affected marks before Apply, kills it: "a nearby general note cannot be accidentally changed into a level." Same family as ST2-9 (support switch capturing stray text) and CV8-10 (a polyline on a layer isn't proof of a pipe) — validate the target, never trust arbitrary selection. Good that you flagged it Unsafe rather than "modify."

🎯 ST3-3 + ST3-4 are the right restraint — keep native, don't reinvent it
Native associative dimensions and leaders are genuinely good — they auto-update when geometry changes and keep their grips. The correct treatment is exactly yours: CE applies the style, the native prompt sequence and associativity stay untouched. And the two anti-patterns you're forbidding are precisely the over-engineering that would break them:

No hidden command-string injection after the workflow starts (fragile, unpredictable — the AI8 principle applied to the command's own mechanics).
Native editable objects, not exploded graphics (an exploded leader is dumb lines you can't edit; a native leader stays a leader).
"Enhance what AutoCAD does well, don't replace it" is the right call for this whole family — it's "keep what works" applied at the command level.

✅ Two quick affirms
ST3-2 — CE-shipped styles (not your personal template path — the CDAGI portability lesson generalised), restore the drafter's previous layer/style/snaps afterward (kills the sysvar-leak class), and never rewrite a global definition just to place one annotation (rule #3). Three real fixes in one decision.
ST3-7 — level marks become a proper compound (marker + tail + label + type + value + source), and no source means Manual/Unknown, never 0.000. That's the recurring dangerous-false-value fix (CDTG's 0.000 AHD, the zero-capacity tank, the imported sea-level slab) applied to level marks — a false RL is exactly the kind of confident-wrong number that reaches construction.
🔒 Approve — nothing starts
Native tools kept native, unsafe LMU contained, marks rebuilt as editable compounds with provenance, styles portable and non-destructive, no forced saves, everything atomic with clean cancel. And it's the right family to resume on while the corpus builds underneath. Ready for the next.
