# ST-09 — Markup, checklist, notes and time

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-162`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# ST-09 — Markups, Checklists, Project Notes and Job Time

## Current AutoCAD state

| Tool | What works now | What needs attention |
|---|---|---|
| `CEMARKUP` | Loads markups, produces review items and has preview concepts | **Rebuild:** can freeze AutoCAD for five minutes; unsafe execution and Undo paths |
| Bluebeam import | Reads exported markup information deterministically | **Keep and improve** |
| AI markup reading | Direct OpenAI path exists | **Replace:** separate provider, privacy and blocking problems |
| `CECHECKLIST` | Per-drawing checklists, categories, Checked/N/A | **Merge with QA-01:** currently a second checklist authority |
| `CENOTES` | Shared project-folder notes, search and tags | **Rebuild storage:** simultaneous edits can overwrite each other |
| Job timer | Tracks active drawings, switching, pause and resume | **Rebuild records:** known idle, job-identity and data-loss defects |
| Reports | Some time reports work | Idle values are unreliable; checklist report is unfinished |
| `CETOOLS` | Separate palette for these tools | Redirect into the unified CE Manager |

## ST9-1 — One coordination workspace

Create one CE Manager **Coordination** workspace with four sections:

```text
Markups | QA Checklist | Project Notes | Time
```

This is not another dashboard. It is part of the same Manager surface approved under SH and QA-01.

**Recommendation: Approve.**

---

## ST9-2 — Familiar commands remain

Keep the muscle-memory commands:

- `CEMARKUP`
- `CECHECKLIST`
- `CENOTES`
- `CETOOLS`

Each opens the corresponding Manager section. Separate competing windows and palettes retire after transition.

**Recommendation: Approve.**

---

## ST9-3 — Markup intake and privacy

Markup intake order:

1. Bluebeam FDF/XML extraction where available.
2. Local PDF text and geometry extraction.
3. Provider-neutral visual interpretation only when explicitly approved.

Before any external provider receives pages, CE shows:

```text
File: Structural Markups Rev C.pdf
Pages: 1–6
Provider: Claude / Codex
Client content may be transmitted
Upload / Use local extraction only / Cancel
```

OpenAI access remains blocked until its separate privacy approval. Confidential projects remain completely disabled.

**Recommendation: Approve.**

---

## ST9-4 — Select the exact drawing target

Never fit markup onto a drawing using overall extents alone—title blocks and Xrefs distort that.

Workflow:

```text
Choose markup revision
        ↓
Match PDF sheet to DWG/layout
        ↓
Confirm two or more known alignment points
        ↓
Preview markup overlay
        ↓
Register the match
```

Uncertain sheet, scale, rotation or revision becomes **Unknown** and cannot Apply.

**Recommendation: Approve.**

---

## ST9-5 — Every markup becomes a traceable item

Each item records:

- Source PDF, revision and page.
- Original markup image/text.
- Target drawing, layout and element.
- Classification and confidence.
- Reviewer, decision and date.
- Resulting CE change plan, if any.

Selecting an item zooms AutoCAD to the affected location and shows the source markup beside it.

**Recommendation: Approve.**

---

## ST9-6 — Separate drafting instructions from engineering decisions

Markup classifications:

| Type | Example | Behaviour |
|---|---|---|
| Drafting correction | “Move B4 label above beam” | May prepare a drawing preview |
| Drawing coordination | “Add section reference here” | Preview using approved CE tools |
| Engineering decision | “Increase B4 to 240 PFC” | Creates a decision/check item—not an automatic change |
| Unclear | Unreadable cloud or ambiguous arrow | **Unknown; manual review** |
| Already resolved | Final drawing already contains correction | Mark complete with evidence |

A red pen note is not automatically engineering authority.

**Recommendation: Approve.**

---

## ST9-7 — Safe markup Apply workflow

```text
Read markup
    ↓
Review individual findings
    ↓
Select approved findings
    ↓
Plan
    ↓
Preview actual AutoCAD result
    ↓
Explicit Apply
    ↓
One Undo
```

Only registered CE tools with checked inputs may execute.

Prohibit:

- Python/pyAutoCAD workers.
- External COM control.
- LISP or scripts.
- Blind AutoCAD command strings.
- Arbitrary C# or terminal actions.

**Recommendation: Approve.**

---

## ST9-8 — Correct cancellation, staleness and Undo

Before Apply, CE rechecks:

- Drawing revision.
- Target object identities.
- Markup revision.
- Calculation and schedule status.
- Preview geometry.

A changed drawing refuses the stale preview.

Undo reverses the exact applied markup batch. It must never issue a context-blind AutoCAD `U`, which could undo unrelated drafting performed afterward.

**Recommendation: Approve.**

---

## ST9-9 — One checklist authority

`CECHECKLIST` becomes the working face of the already-approved QA-01 checklist.

There will not be:

```text
Old structural checklist + Project QA checklist
```

There will be one deterministic checklist containing Civil, Structural, Coordination and Issue sections.

**Recommendation: Approve.**

---

## ST9-10 — Checklist behaviour in AutoCAD

Items can be:

- Automatic Pass/Fail/Unknown from CE checks.
- Manual confirmation.
- Not Applicable with a compulsory reason.
- Assigned for review.
- Checked/Approved with user and time.

Example:

```text
☑ Beam schedule current — automatic
⚠ B4 calculation link stale — blocked
☐ Verify existing wall construction — Timothy
N/A Pool structure — reason recorded
```

Users cannot manually turn an automatic Fail or Unknown into Pass. Ready-to-Issue remains blocked until resolved or formally approved.

**Recommendation: Approve.**

---

## ST9-11 — Notes have clear roles

Every note must be classified:

- General project note.
- Drafting task.
- Engineering decision required.
- Engineering decision recorded.
- Site/query item.
- Markup item.
- Superseded.

Notes may link to a project, drawing, layout, AutoCAD element, calculation, schedule row or markup.

A general note never silently becomes an engineering rule.

**Recommendation: Approve.**

---

## ST9-12 — Conflict-safe notes and drawing placement

Replace the current last-save-wins behaviour.

If two staff edit the same note:

```text
Your version          Current shared version
----------------      ----------------------
“Check beam size”     “Beam checked — Rev D”

Keep mine / Keep shared / Merge / Cancel
```

No version is silently lost.

Placing a note into the DWG uses:

```text
Select note
    ↓
Choose approved AS-01 note style
    ↓
Preview
    ↓
Place native CE annotation
```

The project note and drawn annotation retain a relationship; neither silently overwrites the other.

**Recommendation: Approve.**

---

## ST9-13 — Job timer uses stable project identity

Current folder-name guessing has already confused distinct clients. Replace it with stable project identity.

Recommended behaviour:

```text
Open registered project drawing → timer starts visibly
Switch drawing               → time moves to that project
No activity for 5 minutes    → timer pauses and excludes idle time
Return                        → toast offers Restore idle time
Unknown drawing              → Unassigned, not billable
```

The status bar always shows:

```text
25-142 | Tracking 01:24:18
```

or:

```text
UNASSIGNED | Not billable
```

**Recommendation: Approve.**

---

## ST9-14 — Time records cannot be silently rewritten

Use an append-only time ledger: corrections add a traceable adjustment instead of rewriting an old CSV snapshot.

This prevents:

- A timer append being erased while someone edits time.
- Unreadable rows disappearing during repair.
- Midnight sessions duplicating or collapsing.
- One client’s time being attributed to another.

Reports must show genuine:

- Active time.
- Excluded idle time.
- Manual adjustments.
- User, project, drawing and session.
- Reasons for corrections.

The unfinished checklist report remains hidden until real.

**Recommendation: Approve.**

---

## ST9-15 — Corpus connection, performance and testing

Approved markup→final corrections can later become valuable corpus evidence, but only after DATA-01 sanitisation and governance.

The corpus may propose:

> “This markup pattern repeatedly means move the member mark outside the bracing zone.”

It cannot silently change the Atlas, engineering rules or commands.

Performance requirements:

- PDF interpretation runs away from AutoCAD’s drafting thread.
- Visible progress, Stop and timeout.
- No whole-project scan while moving the cursor.
- Notes/checklists load only the active project and use a safe cache.

Automated tests cover parsing, alignment, stale previews, exact Undo, checklist authority, note conflicts and time-ledger integrity.

Timothy’s final check should be approximately:

1. Load one Bluebeam/PDF markup.
2. Preview and Apply one drafting correction.
3. Confirm exact Undo.
4. Complete one checklist item.
5. Create/edit one shared note conflict.
6. Confirm timer switch and idle return.

Target: **under 15 minutes**, with no AutoCAD freeze or drafting lag.

**Recommendation: Approve.**

## Proposed outcome

ST-09 replaces a risky collection of side tools with one traceable coordination workflow:

```text
Markup evidence
      ↓
Review and engineering decisions
      ↓
Approved drawing changes
      ↓
Deterministic QA checklist
      ↓
Project notes and time record
```

If approved, **structural planning ST-01→ST-09 will be complete: 9 of 9.** No implementation, build or deployment has started.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-163

✅ Approve ST-09 all — structural is now 9 of 9
This card closes something I flagged in the very first audit review and spun off as a standalone task — and it closes it properly.

💰 ST9-13 + ST9-14 — the money bug, fixed at the root
The JobTime client-misattribution (Centrum and Ben+Ben sharing folder "04", so every Ben+Ben job billed to Centrum) was one of the first things the audit surfaced. This doesn't patch the symptom — it fixes the cause:

ST9-13 replaces the folder-name guess that collided with stable project identity (CT2 — distinct identity per distinct thing, the same fix as the ST7-7 Mezzanine/Second collision). Plus the idle handling repairs the IdleDetector tick-wrap (the "5-minute idle never fires" bug), and Unknown drawings are Unassigned, not billable — never guessed.
ST9-14's append-only ledger is the right architecture for the data loss. A rewritten CSV loses rows on concurrent-write, repair, crash, or the midnight boundary — exactly the failures you listed. An append-only ledger never loses committed data, and corrections become new adjustment records, not silent rewrites. That's billing-data integrity done properly — and since it's real money, getting the architecture right rather than patching symptoms is exactly the call.
🤖 ST9-6 + ST9-7 — MarkupAI made safe (which is why you parked it)
ST9-6 is the firewall: "a red pen note is not automatically engineering authority." A markup saying "increase B4 to 240 PFC" becomes a decision/check item for the engineer — never an automatic change — while "move the B4 label" is a drafting correction that can be previewed. Drafting can be automated; engineering needs approval, even when it arrives as a scribble.
ST9-7 is the containment: the PROHIBIT list — no Python/pyAutoCAD workers, no external COM, no LISP/scripts, no blind command strings, no arbitrary C#/terminal — is the AI8 boundary. The markup can only drive registered CE tools through preview→apply. The old MarkupAI spawned an external Python process and called OpenAI directly; both are banned. This is the parked feature rebuilt genuinely safe.
↩️ ST9-8 — a subtle Undo fix that prevents real data loss
The markup Undo must reverse the exact applied batch, never a context-blind AutoCAD U. A blind U would undo whatever you did after the markup — your later drafting — not the markup itself. Targeted batch-undo is the fix, and it's the kind of thing that quietly eats an afternoon's work if you get it wrong.

🔀 ST9-12 — CENOTES stops losing work
Replacing last-save-wins with a real conflict resolution (Keep mine / Keep shared / Merge / Cancel, no version silently lost) is the concurrent-edit safety any shared-notes system needs. It's the same discipline the multi-chat/fleet coordination requires — two people touching one thing get a merge decision, not a silent overwrite.

✅ Three quick affirms
ST9-10 — the checklist can't be gamed: users cannot flip an automatic Fail/Unknown to Pass. That's what makes Ready-to-Issue mean something — you can't tick your way past a real problem.
ST9-3 — markup privacy: deterministic Bluebeam/PDF first, explicit consent before any external transmission, OpenAI blocked until its own approval (AI15), confidential projects fully disabled.
ST9-9 + ST9-15 — one checklist authority (CECHECKLIST becomes the face of QA-01), and the 5-minute AutoCAD freeze is fixed (PDF interpretation moves off the drafting thread, with progress/Stop/timeout).
🏁 The milestone
ST-01 → ST-09 is complete — 9 of 9 structural cards locked. Together with the 8 civil cards (CV-01→CV-08), the foundations (SH/F/CT/TH/RS/PD/SH-04, AS-01) and the 7-card evidence framework (EV-01→EV-07), the command-level planning is now largely done. What remains is smaller command families and the corpus build (a separate task) — and every one of these cards is decision-complete, not implemented. This has been an enormous, disciplined planning effort, and it holds together as one coherent system.

🔒 Approve — nothing starts
A risky pile of side tools becomes one traceable coordination workflow; the billing data is finally trustworthy; the parked markup AI is safe; notes stop losing edits. Ready for whatever's next.
