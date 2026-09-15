# EV-03 — Project evidence model

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-84`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-03 — Project and drafting-scene evidence model

### Current AutoCAD/tool state

| Area | What currently works | What must change |
|---|---|---|
| Existing snapshots | Find layers, blocks, text and basic geometry | Rebuild to capture relationships and context |
| Final DWGs | Show approved drafting outcomes | Identify which revision is genuinely final |
| Markups | Contain Timothy’s corrections | Pair each correction with its final result |
| Structural drawings | Show beams, columns and labels | Capture support, ownership, continuity and bracing relationships |
| Civil drawings | Show networks, levels and annotation | Link drawn objects to calculations and source evidence |
| Existing commands | Mixed working/modified/rebuild states already recorded | No command changes during EV-03 |
| AutoCAD use | Not required for extraction planning | Corpus study must not interrupt active drafting |

### Intended evidence flow

```text
Inputs + calculations + markups
              ↓
       Verified final DWG
              ↓
Objects → relationships → drafting scenes → correction history
              ↓
Contextual command behaviour and automatic drafting proposals
```

## EV3-1 — Preserve the complete project set

Treat each job as one evidence package:

- source drawings and XREFs;
- consultant revisions;
- calculations and schedules;
- markups;
- issued drawings;
- revision history.

A detached DWG is not automatically treated as a complete project example.

**Recommendation: Approve.**

## EV3-2 — Establish the authoritative final

The latest file date does not automatically mean “approved final.”

Use drawing revision, issue register, PDF issue and project records together. Conflicts become `Unknown` and are excluded from gold evidence.

**Recommendation: Approve.**

## EV3-3 — Read drawings without altering them

Corpus examination must be physically read-only:

- no `SyncWithDrawing`;
- no save;
- no object upgrade;
- no drawing recovery;
- no changes to XREF paths;
- no opening thousands of drawings in Timothy’s active AutoCAD session.

This becomes a governed CE evidence component—not an informal helper script.

**Recommendation: Approve.**

## EV3-4 — Preserve real drawing geometry

Capture:

- model-space geometry;
- UCS and rotation;
- XREF transforms;
- mirrored references;
- levels and Z values;
- paper-space viewports and scales.

For privacy-cleared evidence, translate the entire project to an arbitrary origin while preserving relative distances, angles and levels.

**Recommendation: Approve.**

## EV3-5 — Record each drafting object properly

Each object record includes:

- object family and type;
- geometry and orientation;
- layer, colour and linetype role;
- block attributes;
- text style, height and alignment;
- source drawing and revision;
- confidence and provenance.

Client text is not copied into AI-safe records.

**Recommendation: Approve.**

## EV3-6 — Capture relationships, not proximity guesses

Record relationships such as:

- beam **supported by** column;
- label **belongs to** beam;
- brace **connects** two supports;
- pipe **connects** two pits;
- callout **describes** an object;
- viewport **shows** a model area;
- object is merely **near**, with no assumed ownership.

**AutoCAD example:** a note 120 mm from B4 is not declared B4’s label unless ownership or repeated evidence proves it.

**Recommendation: Approve.**

## EV3-7 — Build contextual drafting scenes

Create small, meaningful scenes around drafting situations:

- beam meeting one shared column;
- three beams meeting a support;
- brace crossing a beam line;
- dense beam and column annotation;
- pit beside boundary and services;
- pipe label near competing objects.

The system learns the whole local arrangement—not an isolated block.

**Recommendation: Approve.**

## EV3-8 — Classify every observation

Every extracted finding is labelled:

| Classification | Meaning |
|---|---|
| Fixed | Verified source fact |
| Engineering | Governed by calculation/rulebook |
| Drafting | Presentation convention |
| Exception | Deliberate project-specific departure |
| Unknown | Insufficient or conflicting evidence |

Frequency alone can never promote a drafting pattern into an engineering rule.

**Recommendation: Approve.**

## EV3-9 — Capture text meaning without leaking text

Classify text as:

- member mark;
- size;
- level;
- material;
- construction note;
- title;
- revision note;
- general annotation.

AI-safe evidence stores meanings and placements, not client names, addresses or raw notes unless specifically approved.

**Recommendation: Approve.**

## EV3-10 — Convert markups into correction events

Record:

```text
Before → markup instruction → final result
```

Example:

```text
Beam label below member
→ markup arrow: move above
→ final label above, clear of bracing
```

This distinguishes a real drafting correction from a coincidental difference between revisions.

**Recommendation: Approve.**

## EV3-11 — Link engineering values to their authority

A level, beam size, pipe grade or detention volume must point to:

- calculation;
- approved schedule;
- engineer’s markup;
- survey;
- consultant source;
- deterministic CE rule.

No authority means `Unknown`, even when the value appears repeatedly in final drawings.

**Recommendation: Approve.**

## EV3-12 — Understand multi-drawing context

Keep relationships across:

- floor plans;
- framing plans;
- sections;
- details;
- schedules;
- civil plans;
- long sections;
- XREFs;
- multiple buildings.

**Example:** a column shown on Level 1 may support a beam on Level 2 even though they are not in the same DWG.

**Recommendation: Approve.**

## EV3-13 — Confidence must remain visible

Each relationship receives:

- evidence source;
- confidence;
- conflict status;
- reason for classification.

Ambiguous support, ownership or revision relationships remain `Unknown`. They are never silently resolved using nearest-object logic.

**Recommendation: Approve.**

## EV3-14 — Keep evidence reproducible

Evidence records are versioned and traceable to their source revision.

If extraction rules improve, the corpus can be regenerated and differences explained. Old results are not silently overwritten.

Raw client material remains locally restricted.

**Recommendation: Approve.**

## EV3-15 — Timothy reviews scenes, not thousands of DWGs

Verification uses no more than **30 visual scene cards per review batch**.

Each card shows:

```text
Source situation | Extracted relationships | Final interpretation
```

Timothy approves only disputed drafting interpretations. No AutoCAD command testing is required during EV-03.

**Recommendation: Approve.**

### Proposed EV-03 result

The corpus will understand:

> “This is a shared column supporting three beams, this text belongs to B4, this brace controls the available label side, and this placement was corrected during markup.”

It will not merely understand:

> “There are four lines, one block and three pieces of text nearby.”

**Recommendation: approve EV-03 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-85

✅ Approve EV-03 all
The whole model is coherent, but the property that matters most is a **meta** one: **the extraction itself is built with the same discipline as the tools it will inform.** It refuses to guess relationships by proximity (EV3-6 — a note 120 mm from B4 isn't B4's label without proof), and it refuses to launder a repeated value into a rule (EV3-11 — no authority means Unknown even if it appears in a hundred finals). That's the integrity guarantee: **the evidence base cannot teach the system the exact bugs you're removing.** If the extraction cut corners on proximity or provenance, the corpus would quietly re-infect everything downstream. It doesn't. That's the single most important thing to get right here, and it's right.

**🏗️ EV3-12 is the most ambitious — and the most valuable**
Cross-drawing context — "a column on Level 1 supports a beam on Level 2, in a different DWG" — is what turns *"understand a drawing"* into *"understand the project."* It's what the coordinate-the-whole-project North Star actually requires, and it's the hard part most tools never attempt.

**One dependency worth naming:** cross-drawing linking leans on a **consistent grid/mark system across sheets** — that's how you know the Level-1 column and the Level-2 beam are the same grid location. Where the office's drawings carry that consistency, this is powerful; where a project *doesn't* cross-reference cleanly, those links correctly fall to **Unknown** (EV3-13) rather than being guessed. So it degrades gracefully — but its *reach* will track how consistently your sheets reference each other. Worth watching in the holdout scores (EV2-8) as a signal of where the office's own drawing standards could tighten.

**🎯 Two refinements that keep the evidence clean**
**EV3-10 — the markup** ***instruction*** **is the trustworthy signal.** Not every difference between a draft and a final is a deliberate correction; some are coincidental revision noise. Capturing the actual markup arrow ("move above") is what distinguishes an *instructed* correction from a *coincidental* diff. Learning from instructed corrections — not every delta — is what makes EV1-11's correction-learning honest.
**EV3-9 — semantic role + placement, never raw content.** Storing "this is a member mark, here" without storing what the mark *says* lets you learn placement without leaking client text. Sophisticated, and exactly aligned with DATA-01.
**🔁 EV3-14 treats the evidence like the rulebook**
Versioned, traceable to source revision, and **re-generable** — improve the extraction rules, regenerate, and *explain the differences* rather than silently overwriting. An evidence base you can't reproduce or diff is one you can't trust; this one you can. Same rigor as the code and the rulebook.

**🔒 Approve — nothing starts**
The result is the right one: the corpus will understand *"shared column supporting three beams, this text belongs to B4, this brace controls the label side, this placement was a markup correction"* — not *"four lines, a block and some nearby text."* That difference is the entire point of the evidence stage. Approved; nothing begins until you say so.
