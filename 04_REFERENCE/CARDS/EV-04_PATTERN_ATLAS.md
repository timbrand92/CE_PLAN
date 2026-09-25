# EV-04 — Drafting Pattern Atlas

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-89`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-04 — Drafting Pattern Atlas and contextual placement

```text
Engineering authority
        ↓
Fixed geometry and constraints
        ↓
Drafting Pattern Atlas
        ↓
Ranked AutoCAD previews
        ↓
Drafter accepts or adjusts
        ↓
QA checks exceptions
```

### Current AutoCAD command state

| Area | Current strength | Modification/rebuild needed |
|---|---|---|
| Beam commands | Useful placement behaviour exists | Replace scattered placement logic with one resolver |
| Support commands | Existing blocks and workflows are familiar | Rebuild relationships and type switching per ST-02 |
| Civil commands | Strong calculations and drafting examples | Evidence-refine placement without changing engineering |
| Labels and notes | Many good results in final drawings | Current commands do not understand the entire scene |
| MOVE/COPY/EDIT | Normal AutoCAD actions work | Preserve ownership and deliberate manual positions |
| Dense drafting | Timothy resolves clashes manually | Atlas should propose clear positions and expose exceptions |

## EV4-1 — Atlas is an approved drafting reference

The Atlas records explainable office drafting patterns. It is not a black-box model and cannot invent engineering.

**Recommendation: Approve.**

## EV4-2 — Store each pattern as a practical rule

Each pattern contains:

```text
Context → preferred placement → alternatives → clearances → exceptions → evidence
```

Example: beam label above member, aligned with beam, unless bracing occupies that side.

**Recommendation: Approve.**

## EV4-3 — Keep patterns context-specific

Separate patterns by:

- discipline and object family;
- plan, section, detail or schedule;
- drawing scale;
- building/project type;
- drafting era;
- normal versus dense conditions.

Current approved practice receives greater weight than legacy drafting.

**Recommendation: Approve.**

## EV4-4 — Lock the placement authority order

1. Deliberate user position or project instruction
2. Verified engineering constraint
3. Approved markup correction
4. Current-project drafting pattern
5. Office Atlas default
6. Preview alternatives
7. `Unknown/manual placement`

A general default can never override Timothy’s deliberate placement.

**Recommendation: Approve.**

## EV4-5 — Measure readability on the plotted sheet

Clearances and text spacing must account for:

- viewport scale;
- annotation scale;
- text height;
- sheet orientation;
- model-space versus paper-space placement.

A label that is 200 mm clear in model space may still overlap when printed at 1:100.

**Recommendation: Approve.**

## EV4-6 — Separate hard and soft constraints

| Constraint | Treatment |
|---|---|
| Do not obscure a member mark | Hard |
| Do not cross a structural object | Hard |
| Keep inside the relevant detail/viewport | Hard |
| Prefer labels above beams | Soft preference |
| Match neighbouring label alignment | Soft preference |
| Minimise leader length | Soft preference |

Hard conflicts block automatic placement. Soft preferences rank alternatives.

**Recommendation: Approve.**

## EV4-7 — Produce ranked alternatives

The resolver generates up to three valid positions:

1. Recommended
2. Acceptable alternative
3. Manual placement

It must not force one apparently “smart” answer when several drafting arrangements are legitimate.

**Recommendation: Approve.**

## EV4-8 — Check the complete visible scene

Placement checks include:

- beams, columns and bracing;
- grids and dimensions;
- levels and callouts;
- hatches and boundaries;
- civil assets and services;
- viewport edges;
- existing notes and leaders.

Nearby objects influence clearance but do not automatically establish ownership.

**Recommendation: Approve.**

## EV4-9 — Coordinate the drawing in a stable order

For future automatic drafting:

```text
Engineering geometry
→ primary member/asset marks
→ dimensions and levels
→ supporting notes
→ general annotations
→ final clash review
```

Changing one beam should re-check its local annotation group—not rearrange the entire drawing.

**Recommendation: Approve.**

## EV4-10 — Make placement visible in AutoCAD

Typical command behaviour:

1. Select or create the engineering object.
2. CE displays the recommended complete result.
3. `Next` cycles approved alternatives.
4. `Flip` changes side where valid.
5. `Move` allows free cursor placement.
6. Click accepts.
7. Esc leaves nothing changed.

The final result must exactly match the accepted preview.

**Recommendation: Approve.**

## EV4-11 — Respect normal AutoCAD editing

| Action | Required result |
|---|---|
| MOVE label | Position becomes deliberately authored; it does not snap back |
| MOVE object | Owned annotation follows while shared objects remain protected |
| COPY compound | Fresh identities; relative placement retained and clashes flagged |
| EDIT geometry | Keep authored placement if valid; preview an alternative if invalid |
| ERASE parent | Remove only owned children; shared supports remain |
| UNDO | One command restores the complete previous state |

**Recommendation: Approve.**

## EV4-12 — Never silently learn from live drafting

A user moving a label does not instantly change the office standard.

Repeated corrections become evidence proposals, then formal Atlas or CE Tool cards for Timothy’s approval.

**Recommendation: Approve.**

## EV4-13 — Handle uncertain situations honestly

If the context is outside the approved evidence:

- show Preview-only alternatives;
- explain the uncertainty briefly;
- allow manual placement;
- record an evidence gap;
- never silently choose a “most likely” position.

**Recommendation: Approve.**

## EV4-14 — Keep AutoCAD smooth

Context checks must:

- inspect only the affected local scene;
- reuse already-known drawing information;
- avoid full-drawing scans during cursor movement;
- obey the approved PD performance budgets;
- reduce optional preview detail instead of freezing drafting.

**Recommendation: Approve.**

## EV4-15 — Atlas acceptance and Timothy review

The Atlas passes when:

- EV-02 held-out thresholds are met;
- every pattern shows its supporting projects;
- legacy/current conflicts are visible;
- exceptions remain Preview-only;
- Timothy reviews no more than 30 visual scene cards per batch;
- automation opportunities become separate CE Tool cards.

**Recommendation: Approve.**

### Practical target

When placing a beam label, CE should understand:

> The upper side is normally preferred, but bracing occupies it, the lower side clashes with a dimension, and the approved office alternative is beyond the support with a short leader.

It must show that result before placement and preserve Timothy’s adjustment afterward.

**Recommendation: approve EV-04 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-90

✅ Approve EV-04 all
This is the culmination — it turns the mined evidence into a working, honest, governed placement system. Very consistent with everything; the ranking, the hard/soft split, the honest previews, the governance are all right. One interaction is worth making explicit, then three affirmations.

🎯 EV4-4 × EV4-6 — state the human-vs-safety boundary
"Deliberate user position wins" sits at the top of the authority order (EV4-4), and "hard constraints block" is a separate rule (EV4-6). Those need a stated interaction so "user beats everything" isn't misread as "the user can silently create a hard clash." The right resolution:

A user's deliberate placement is respected (no snap-back, EV4-11) — it wins over soft preferences and office defaults. But a hard-constraint violation (obscuring a member mark, crossing a structural object, leaving the viewport) is flagged as a QA finding — never silently accepted, never silently overridden.

So: the human wins the drafting judgment; the safety constraint still surfaces the problem for the human to resolve. Getting this wrong in either direction is a known bug — auto-override is the snap-back bug; silent-accept is the QA gap. Worth one explicit line in the card.

📐 EV4-5 is real drafting knowledge, not a nicety
Measuring readability on the plotted sheet, not in model space, is exactly where naive clash-detection fails. A label 200 mm clear in model space, seen through a 1:100 viewport, is 2 mm on paper — an overlap the model-space check never sees. Accounting for viewport/annotation scale is the difference between a tool that looks clear on screen and one that's actually clear when issued. Strong call.

🛡️ EV4-12 is the critical governance boundary
"Never silently learn from live drafting" keeps the whole system deterministic and governed. If a user moving a label once quietly retrained the office standard, you'd get (a) one person's idiosyncrasy drifting everyone's defaults, and (b) the "why is the tool behaving differently today?" unpredictability that erodes trust. Routing repeated corrections through proposals → formal cards → your approval (the AI12 "observe, propose, never self-modify" boundary) means the Atlas is a versioned reference you control, not a model that mutates under you. Affirm strongly — this is what keeps the system predictable.

🔧 Two quick affirms
EV4-9 — local re-check, not global rearrange. Changing one beam re-checks its annotation group, not the whole drawing. A tool that reshuffles 200 labels because you nudged one beam is unusable; locality is the stability property (and the performance one).
EV4-7 — three ranked alternatives, never one forced "smart" answer. Drafting often has several legitimate placements; pretending there's one optimum is presumptuous and frequently wrong. Recommended / Acceptable / Manual is the right humility.
🔒 Approve — nothing starts
The target is exactly right: CE understands "upper side preferred, but bracing occupies it, lower side clashes with a dimension, so the approved alternative is beyond the support with a short leader" — shows that before placement, and preserves your adjustment after. That's contextual drafting that assists without overriding. Approved.

(Record note, still just one line: you're ~25 sections deep and the committed plan doc stops at TF — the whole CV/ST/EV run lives in this chat. Say the word + destination and I'll bank it all in one pass.)
