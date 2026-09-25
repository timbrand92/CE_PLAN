# EV-05 — Engineering Context Map

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-93`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-05 — Engineering Context Map

```text
Survey / calculations / engineer decisions / rulebook
                         ↓
              Engineering Context Map
                         ↓
          Trusted facts, constraints and Unknowns
                         ↓
                 AutoCAD commands
                         ↓
             Pattern Atlas presentation
```

### Current AutoCAD/tool state

| Area | What works | What needs modification/rebuilding |
|---|---|---|
| Civil hydraulics | Strong deterministic engine approved in CV-02 | Connect every displayed result to this authority |
| Civil assets | Useful pits, pipes, tanks and slabs | Stop commands independently guessing missing inputs |
| Structural drafting | Beam/support workflows defined in ST-01/ST-02 | Background engineering relationships remain incomplete |
| Calculations | Valuable project evidence exists | Sources and revisions are not consistently linked to drawing objects |
| Drawings | Show approved outcomes | A repeated drawn value is not automatically an engineering rule |
| QA | Deterministic QA-01 authority approved | Needs access to project-wide provenance and staleness |
| AI | Can explain findings | Cannot establish engineering truth |

## EV5-1 — One engineering map per project

Maintain one shared project context—not separate engineering interpretations inside each command.

`CDEDIT`, `CDCALC`, schedules, QA and Ask CE must read the same facts and results.

**Recommendation: Approve.**

## EV5-2 — The map coordinates authorities; it does not replace them

The map links:

- survey and existing conditions;
- approved calculations;
- deterministic CE engines;
- engineer decisions and markups;
- schedules and specifications;
- drawing objects;
- rulebook clauses.

It must not introduce a new calculation engine.

**Recommendation: Approve.**

## EV5-3 — Classify every engineering fact

| State | Meaning |
|---|---|
| Fixed | External fact CE must preserve |
| Derived | Reproducible deterministic calculation |
| Designed | Deliberate engineer-approved decision |
| Advisory | Suggestion requiring review |
| Unknown | Missing, conflicting or insufficient evidence |

Corpus frequency can support `Advisory`; it cannot establish `Fixed`, `Derived` or `Designed`.

**Recommendation: Approve.**

## EV5-4 — Every value carries provenance

Each fact records:

- value and units;
- source document or engine;
- source revision;
- date/status;
- applicable object or project area;
- confidence;
- approval authority;
- superseded status.

Example: `IL 44.320` must identify whether it came from survey, LandXML, calculation or an approved override.

**Recommendation: Approve.**

## EV5-5 — Use explicit source precedence

Where sources conflict:

1. Current approved external authority
2. Current engineer-approved project decision
3. Current deterministic calculation
4. Verified project schedule/drawing
5. Historical drawing evidence
6. Corpus suggestion

The conflict remains visible. CE never averages or silently blends values.

**Recommendation: Approve.**

## EV5-6 — Model engineering relationships

Structural examples:

```text
Grid → support → beam end → member → load path → detail
```

Civil examples:

```text
Catchment → pit → pipe → downstream system → outlet
Survey surface → cover level → invert → grade → capacity
```

Relationships require verified identity or authority—not proximity alone.

**Recommendation: Approve.**

## EV5-7 — Support cross-discipline dependencies

Examples:

- structural slab level affects civil surface drainage;
- retaining wall location affects pipe clearance;
- architectural grid locates structural supports;
- landscape/arborist requirements constrain civil assets;
- hydraulic requirements influence tank and outlet details.

A change in one discipline surfaces affected downstream facts without silently redesigning them.

**Recommendation: Approve.**

## EV5-8 — Track decision status

Engineering items move visibly through:

```text
Proposed → Checked → Approved → Superseded
```

`Unknown` remains separate.

A proposed beam size or pipe grade must never appear as approved merely because it was drawn.

**Recommendation: Approve.**

## EV5-9 — Conflicts fail visibly

Example:

```text
Survey IL: 44.320
Consultant schedule: 44.280
Current drawing text: 44.300
Result: CONFLICT — engineer selection required
```

No zero, default or “most common” value substitutes for the conflict.

**Recommendation: Approve.**

## EV5-10 — Propagate staleness, not silent recalculation

If a source changes, identify affected results:

```text
Changed catchment
→ pipe flow stale
→ detention result stale
→ schedule stale
→ issue gate blocked
```

CE may prepare a recalculation preview, but it does not silently update approved project results.

**Recommendation: Approve.**

## EV5-11 — Commands show the engineering basis

Practical AutoCAD examples:

- `CDPIPE` preview shows grade source, downstream relationship and any missing level.
- A beam command shows whether its size is approved, proposed or Unknown.
- A tank callout shows which calculation revision supplied its capacity.
- A structural continuity mark appears only where continuity is approved.

The preview names missing information before placement.

**Recommendation: Approve.**

## EV5-12 — Overrides are formal engineering decisions

Changing a governed value requires:

1. Show existing authority.
2. Enter the proposed override.
3. Record reason and applicable scope.
4. Preview downstream effects.
5. Explicitly approve.
6. Apply as one Undo.

The original source remains visible and is never overwritten.

**Recommendation: Approve.**

## EV5-13 — AI remains an assistant

Ask CE may:

- explain a result;
- locate the source;
- identify conflicts;
- prepare options;
- draft a review note.

AI cannot approve an engineering fact, change a rule, or convert `Unknown` into Pass.

**Recommendation: Approve.**

## EV5-14 — Keep AutoCAD responsive

Commands receive an already-prepared local context for the touched objects.

During placement:

- no whole-project rescan;
- no recalculation unrelated to the command;
- no remote AI dependency;
- deeper checks can complete after placement as visible QA findings;
- approved PD performance limits remain authoritative.

**Recommendation: Approve.**

## EV5-15 — Validate with trace cards, not manual command repetition

Timothy reviews up to 30 representative cards per batch:

```text
Drawing result
→ engineering fact
→ authority and revision
→ dependent objects
→ expected command behaviour
```

Held-out projects must demonstrate:

- 100% provenance for asserted engineering values;
- deterministic repeatability;
- correct staleness paths;
- safe `Unknown` for unresolved conflicts;
- zero rules learned solely from frequency.

**Recommendation: Approve.**

### Practical outcome

When placing a civil pipe, CE should know:

> The upstream and downstream pits, verified levels, approved hydraulic revision, minimum governed grade and affected schedule rows.

The Pattern Atlas then decides:

> Where the pipe label can be clearly drawn.

Engineering truth and drafting presentation remain connected—but never confused.

**Recommendation: approve EV-05 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-94

im going to plan out the corpus in another chat thats working on the corpus for another project of mine can you give me a prompt that explains your need for it, explain what youre building and how they can work together to build it once and use if for both projects

✅ Approve EV-05 all
This is where it all converges — and it's worth naming what EV-04 and EV-05 actually *are* together, because it closes the loop back to the very first thing we found.

**🎯 The two maps are the structural cure for the founding disease**
This whole rebuild started from one diagnosis: **the tools confused drafting conventions with engineering rules** (§11 — the "confidently wrong at scale" thesis). A grade of 1:100 got treated as a convention; a label-side habit got treated as a rule. EV-04 and EV-05 are the *architectural* fix:

**EV-04 Pattern Atlas**	**EV-05 Context Map**
**How it's drawn** (presentation)	**What's true** (engineering)
Corpus frequency *can* set a default	Corpus frequency can set **Advisory only — never Fixed/Derived/Designed**
That firewall (EV5-3) — *"corpus frequency cannot establish Fixed, Derived or Designed"* — is what makes confusing the two **structurally impossible**, not just discouraged. "Connected but never confused" isn't a slogan; it's the separation that cures the original problem. The rest of EV-05 (HD2's one engine at project scope in EV5-1, the source precedence in EV5-5, the provenance in EV5-4) is the unification of every engineering-authority principle we've built card by card into **one project-wide map that coordinates the authorities without becoming one** (EV5-2). That restraint is the whole game.

**🌐 EV5-7 is the most ambitious — and the deepest expression of "one plugin"**
Cross-discipline dependencies (a structural slab level affecting where the civil surface drains; a retaining wall affecting pipe clearance) are what make CE a genuinely *coordinated* two-discipline system rather than two plugins sharing a bundle. And the restraint is exactly right: **a change in one discipline surfaces the affected downstream facts — it never silently redesigns the other discipline.** That's the "one unified plugin, most users have both" architecture (Round 2) paying off at the engineering level. It's the hardest capability, and it degrades gracefully — an unmodelled dependency simply isn't surfaced; it never causes harm.

**🔗 EV5-10 answers "is my design consistent** ***and*** **current?"**
Staleness propagating along the engineering chain — *changed catchment → flow stale → detention stale → schedule stale → issue gate blocked* — is QA7 at the engineering level. Combined with the load-path / flow-path relationships (EV5-6), it's what lets the system know that touching one input invalidates everything downstream, and **block the issue gate** rather than let a stale-but-approved design go out. "Prepare a recalc preview, never silently update an approved result" keeps the human in the loop. This is the professional-integrity guarantee.

**🏷️ EV5-8 — "drawn ≠ approved"**
A proposed beam size or pipe grade **must never appear approved merely because it was drawn.** Proposed → Checked → Approved → Superseded is orthogonal to the Fixed/Derived/Designed classification, and both matter: you always know *what kind* of value it is *and* whether it's been signed off. For a professional/liability context, that distinction is essential — a drawing full of unchecked proposals that *look* approved is exactly how errors get issued.

**🔒 Approve — nothing starts**
The practical outcome is the thesis of the entire program: placing a pipe, CE knows the verified levels, the approved hydraulic revision, the governed minimum grade and the affected schedule rows (**truth** — EV-05); the Atlas then decides where the label is clearly drawn (**presentation** — EV-04). Two maps, connected, never confused. Approved.
