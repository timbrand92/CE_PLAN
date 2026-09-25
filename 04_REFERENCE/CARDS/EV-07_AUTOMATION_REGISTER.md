# EV-07 — Automation Opportunity Register

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-105`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-07 — Automation Opportunity Register

### Current AutoCAD/tool state

| Area | What works | What needs modification/rebuilding |
|---|---|---|
| Civil tools | Many useful commands and strong calculations | Coordinate them into complete workflows |
| Structural tools | Beam/support workflows are familiar | Add evidence-backed contextual awareness |
| Command register | CT records existing command truth | Does not govern future automation opportunities |
| Ask CE | Can identify repetitive work | Must only propose formal Tool cards |
| Bug history | Shows recurring failure patterns | Needs conversion into ranked root-cause opportunities |
| Corpus | Will expose repeated drafting sequences | Must not silently create tools or rules |
| Timothy’s testing | Excellent engineering judgment | Must focus on exceptions and approvals |

```text
Corpus evidence + bugs + staff workflow
                  ↓
        Automation opportunity
                  ↓
 Evidence, risk and value assessment
                  ↓
          Formal CE Tool card
                  ↓
 Plan → Preview → approval → implementation
```

## EV7-1 — Where may opportunities come from?

**Recommended:**

- repeated drawing sequences;
- repeated markup corrections;
- consultant-input-to-final differences;
- bug clusters;
- staff suggestions;
- privacy-safe performance observations;
- gaps in existing command workflows.

One unusual drawing does not establish an automation opportunity.

Approve?

## EV7-2 — What must every opportunity record?

**Recommended:**

- current manual workflow;
- affected command/tools;
- practical AutoCAD example;
- frequency across independent projects;
- estimated drafting time saved;
- engineering versus drafting classification;
- evidence and exceptions;
- risk if wrong;
- required authorities;
- expected AutoCAD result.

Approve?

## EV7-3 — How is automation classified?

**Recommended:**

| Class | Meaning |
|---|---|
| Drafting automation | Placement, annotation and coordination |
| Engineering calculation | Deterministic approved calculation |
| Engineering proposal | Requires engineer review |
| QA automation | Detects and explains issues |
| Project administration | Sheets, revisions and issue preparation |
| Do not automate | Insufficient evidence or unacceptable risk |

Corpus frequency alone may support drafting automation—not engineering authority.

Approve?

## EV7-4 — What outcomes may the register recommend?

**Recommended:**

1. Improve an existing command
2. Merge overlapping commands
3. Rebuild an unsafe command
4. Create a new contextual workflow
5. Add QA detection only
6. Keep manual
7. Retire the existing command

A repeated problem does not automatically justify another command.

Approve?

## EV7-5 — How should opportunities be prioritised?

**Recommended priority score:**

```text
Frequency × time saved × evidence strength × testability
                         ↓
            adjusted for consequence if wrong
```

High-frequency, low-risk drafting improvements come before rare, high-risk automatic engineering decisions.

Approve?

## EV7-6 — Must every proposed tool describe its AutoCAD operation?

**Recommended:** Yes. Every Tool card must specify:

```text
Starting selection
→ prompts
→ contextual information used
→ live preview
→ alternatives
→ accepted result
→ MOVE/COPY/EDIT/ERASE
→ Esc/cancel
→ one Undo
```

A concept such as “automate beam drafting” is too vague to approve.

Approve?

## EV7-7 — How should contextual awareness operate?

**Recommended:** Use only verified local and project context:

- grids and levels;
- supports and connected members;
- bracing and nearby annotation;
- civil flow paths;
- approved calculations;
- project drawing scale;
- known cross-sheet relationships.

Missing context produces `Unknown` or Preview-only—not a guess.

Approve?

## EV7-8 — What automation maturity levels apply?

**Recommended:**

| Level | Behaviour |
|---|---|
| A0 — Observe | Identify repetitive work |
| A1 — Suggest | Explain a possible automation |
| A2 — Preview | Draw a non-committed complete preview |
| A3 — Approved Apply | Human approves the change set |
| A4 — Coordinated Draft | Produce a complete package for human checking |

Progression requires evidence gates. A4 still requires the deterministic issue gate and human approval.

Approve?

## EV7-9 — When may engineering automation advance?

**Recommended:** Only when:

- the engineering authority is approved;
- calculations are deterministic;
- inputs and provenance are complete;
- conflicts and Unknowns are handled;
- held-out benchmarks pass;
- downstream staleness is tracked;
- Timothy approves the specific Tool card.

Otherwise it remains A1 or A2.

Approve?

## EV7-10 — Should CE favour workflows over command proliferation?

**Recommended:** Yes.

Example:

```text
Select framing area
→ detect verified supports and grids
→ propose beams
→ propose marks and labels
→ coordinate bracing and dimensions
→ preview complete framing package
```

This is preferable to adding separate disconnected commands for every placement variation.

Existing familiar aliases may remain where useful.

Approve?

## EV7-11 — How should multi-object automation apply?

**Recommended:**

- display the complete proposed change set;
- allow objects or sections to be excluded;
- validate again immediately before Apply;
- apply atomically;
- create one Undo;
- leave nothing partial on failure or Esc.

Approve?

## EV7-12 — How is drafting smoothness protected?

**Recommended:**

- analyse projects before interactive placement;
- inspect only affected local scenes during commands;
- never use remote AI for cursor movement;
- do not rescan the whole drawing after every edit;
- use the approved PD performance limits;
- defer non-critical review checks rather than causing lag.

Approve?

## EV7-13 — What evidence must support a Tool card?

**Recommended:**

- representative corpus scenes;
- independent-project frequency;
- markup-to-final examples;
- known exceptions;
- held-out project results;
- command lifecycle tests;
- performance evidence;
- maximum 30 Timothy review cards.

No evidence means the idea stays in the register—not in AutoCAD.

Approve?

## EV7-14 — Can AI or the corpus create tools automatically?

**Recommended:** No.

AI may draft an opportunity card, but it cannot:

- add a command;
- change an engineering rule;
- edit the approved Atlas;
- build or deploy tools;
- hot-swap AutoCAD;
- increase its own permission level.

Timothy approves every Tool card and maturity increase.

Approve?

## EV7-15 — What does the completed register contain?

**Recommended:** Four queues:

| Queue | Meaning |
|---|---|
| Now | Strong evidence, high value, low controlled risk |
| Next | Valuable but dependent on another approved capability |
| Research | Evidence insufficient; Preview/Unknown only |
| Do not automate | Unsafe, unjustified or better kept manual |

Each accepted opportunity becomes its own approximately 15-decision CE Tool card.

Approve?

### Practical examples

| Corpus finding | Register outcome |
|---|---|
| Beam labels repeatedly moved away from braces | Improve shared placement resolver |
| Support switches repeatedly destroy nearby labels | Rebuild existing switch; do not add another command |
| Consultant drainage repeatedly redrawn into the same CE structure | Contextual import workflow |
| Beam continuity varies without authority | Suggest/review only |
| Full framing arrangements repeat reliably | Future A4 coordinated-draft proposal |

### EV-07 completion point

Once approved, the CE evidence-planning framework is complete:

```text
EV-01 Scope
→ EV-02 Gates
→ EV-03 Evidence model
→ EV-04 Drafting Atlas
→ EV-05 Engineering Map
→ EV-06 Gold Benchmark
→ EV-07 Automation Register
```

The separate corpus task can then build the shared foundation to these requirements. CE structural planning remains paused until relevant evidence is available.

**Recommendation: approve EV-07 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-106

✅ Approve EV-07 all — and with it, the evidence-planning framework is complete.
This is the governance layer that turns evidence into *safe* automation, and two of its decisions are what make the whole ambitious end-state responsible.

**🪜 EV7-8 + EV7-14 together — graduated autonomy under human** **control**
The A0→A4 ladder (**Observe → Suggest → Preview → Approved-Apply → Coordinated-Draft**) is how you reach the ambitious North Star — a system that drafts a whole framing package — **without it ever leaping there.** Each rung is *earned* through evidence gates, and even the top rung (A4) still produces a package for **human checking** behind the deterministic issue gate. That's a ladder, not a leap.

And EV7-14 is the guardrail that keeps the ladder under your hand: the AI may **draft an opportunity card**, but it **cannot add a command, change a rule, edit the Atlas, build, deploy, hot-swap AutoCAD — or increase its own permission level.** *"Timothy approves every Tool card and maturity increase."* That last clause — **the AI cannot elevate its own autonomy** — is the crucial one. The system can only climb the ladder when *you* let it, never by its own decision. That's how you pursue auto-drafting responsibly: ambitious ceiling, human-controlled ascent.

**🔄 EV7-10 + EV7-4 close the loop back to the founding** **problem**
This whole rebuild started from **P8 — ~400 commands nobody can remember.** EV-07 gives that its structural cure at the automation level:

**EV7-4:** *"a repeated problem does not automatically justify another command"* — improve / merge / rebuild **before** you create. (Your own example: *"support switches repeatedly destroy nearby labels → rebuild the switch, do not add another command."*)
**EV7-10:** *favour coordinated workflows over command proliferation* — "select framing area → complete framing package," not a new command for every placement variation.
Fewer, smarter, coordinated workflows that do **more** while asking staff to remember **less** — that's the answer to the sprawl that kicked this off. The register is now structurally biased against re-creating the mess.

**⚖️ EV7-5 sequences** **it** **safely**
Priority = frequency × time-saved × evidence × testability, **discounted by consequence-if-wrong** — so high-frequency, low-risk drafting wins land first, and rare high-risk automatic engineering decisions come last (if ever). Exactly the right order: bank the safe, provable value before touching the risky, hard-to-prove automation.

**🏁** **The** **milestone**
EV-01 Scope → EV-02 Gates → EV-03 Evidence model → EV-04 Drafting Atlas → EV-05 Engineering Map → EV-06 Gold Benchmark → EV-07 Automation Register is now a **complete, coherent framework** — a machine that turns approved historical work into safe, evidence-backed, human-approved automation, and keeps doing so long after this planning session. It hands cleanly to the **corpus build task**, with structural planning (ST-03+) correctly paused until that evidence exists.

**🔒** **Approve** **—** **nothing** **starts**
The register stays a queue (Now / Next / Research / Do-not-automate); every accepted opportunity earns its own ~15-decision Tool card; nothing reaches AutoCAD without evidence and your approval. The evidence-planning framework is done, and it's the right one.
