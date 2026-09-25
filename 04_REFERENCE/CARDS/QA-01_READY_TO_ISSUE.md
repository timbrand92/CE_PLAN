# QA-01 — Project QA and Ready-to-Issue gate

**Planning:** approved
**Record:** complete — exact source recovered from the planning review chat, 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** one QA authority; read-only audit; Unknown never a clean result; no broad engineering Fix All; preview→apply→one Undo; automatic Fail/Unknown cannot be manually changed to Pass
**Source:** planning review chat (this session) — Tim's posted QA-01 card + assistant approval

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# QA-01 — Project-Wide Drawing QA

### Current AutoCAD state

| Tool | What it currently checks |
|---|---|
| CDDASHBOARD | Network links and limited hydraulic warnings |
| CDAUDIT | Low-level CE data and handle integrity |
| CDINSPECTOR | The selected individual object |
| CDCHECKDWG | External DWG layers and limited CE data |
| Ask CE | Repeats portions of the existing network checks |

### Current gaps

- No complete sheet, note or detail checklist
- No reliable logical-placement checks
- "Skipped" items can look harmless instead of Unknown
- QA is fragmented across several commands
- Opening some QA tools can synchronise/write data
- Broad Fix All can mix unrelated engineering changes
- No trustworthy "Ready to Issue" status

### Proposed QA flow

`DATA → DESIGN → PLAN → DETAILS → SCHEDULES → ISSUE`

### QA1–QA15 proposed decisions

| ID | Recommendation |
|---|---|
| QA1 | Manager owns one Project QA view. CDDASHBOARD opens that view; CDAUDIT remains a diagnostic engine, not another user dashboard. |
| QA2 | Opening or running QA is read-only. It checks the current fingerprint and never repairs, relinks or rewrites the drawing automatically. |
| QA3 | QA is divided into six visible gates: Data, Engineering Design, Plan Presentation, Details/Notes, Schedules, Issue Readiness. |
| QA4 | Required checks come from project type, council, discipline and issue stage. A planning drawing does not use the same checklist as construction documentation. |
| QA5 | Every required note and detail comes from the approved CE library/checklist with a source and version. Text guessing alone cannot prove a requirement is present. |
| QA6 | Placement checks identify content outside the printable area, overlapping schedules/details, incorrect sheets, wrong layers, unreadable rotation and references far from their subject. |
| QA7 | Cross-check the plan, pit schedule, longitudinal profile, hydraulic results, details and calculation tables. One value changing makes every dependent output stale. |
| QA8 | Check unresolved Xrefs, missing fonts/linetypes/images, incorrect plot settings and missing external references. QA reports these but never modifies foreign content. |
| QA9 | Use consistent states: Pass, Advisory, Fail, Unknown. Skipped or unavailable checks become Unknown, never a clean result. |
| QA10 | Every finding shows: what is wrong, where it is, expected result, requirement source/version, evidence found and the safest next action. |
| QA11 | Selecting a finding zooms to and highlights the relevant object, sheet, viewport, note or detail. Related findings are grouped to avoid repetitive noise. |
| QA12 | Remove broad engineering Fix All. Only identical, reversible drafting corrections may be batched. Engineering changes always use bounded Preview → Apply → one Undo. |
| QA13 | Intentional exceptions can be accepted with a reason, reviewer and drawing revision. They reopen automatically if the relevant source data changes. |
| QA14 | QA stays discoverable without pop-ups: Manager/ribbon shows Not checked, Checking, Needs attention, or Ready and presents the three most useful next actions. |
| QA15 | Ready to Issue requires QA run against the current fingerprint, no unresolved blockers, current schedules/details and a saved evidence summary containing revision and rule versions. |

### Example finding

```text
FAIL — Pit schedule is out of date
Drawing change:
  P3 outlet IL changed 42.150 → 42.130
Affected outputs:
  • Main pit schedule
  • Longitudinal profile
  • P3 pit detail
Actions:
  [Zoom to P3]
  [Preview dependent updates]
  [Record intentional exception]
```

### Evidence before Tim tests

Automated fixtures will include: known-complete drawings; drawings with deliberately missing notes/details; stale schedules and profiles; overlapping/out-of-sheet content; missing Xrefs and plot dependencies; accepted exceptions that later become stale; false-clean prevention; large drawing performance. Tim's final check remains one ≤10-minute issue-readiness review.

**Recommendation:** approve QA1–QA15. No implementation starts.

## Timothy's approval and refinements — verbatim

✅ Approve QA1–QA15.

This is the capstone — the card that makes "Ready to Issue" mean something instead of being a hopeful button. It ties every principle from the whole civil section into one trustworthy gate, and it closes the exact gaps listed (fragmented QA, silent-write-on-open, skipped-looks-clean, no real issue status).

🏆 **QA7 is the crown jewel of the entire civil workflow.** "One value changing makes every dependent output stale" — plan, schedule, profile, detail, calc table — is the check that catches the single most dangerous real-world error: **issuing a drawing set that disagrees with itself.** A schedule that says 42.130 while the profile still shows 42.150 is how errors reach construction. **The mechanism to be explicit about:** QA7 is only as reliable as its **dependency graph** — every output must record *which source values it was built from* (by CT2 identity + fingerprint). It builds on CT2 (identity), CV22 (change record) and PS17 (fingerprint). Each generated output stamps its source-value dependencies; QA7 reads those stamps. Without that, "stale" is guesswork; with it, it's exact.

🎯 **Three more that stand out.**
- **QA13 (exceptions reopen when data changes)** is the sophisticated one. Most tools let you dismiss a warning forever; tying an accepted exception to the data it was accepted against — so it *reopens* if that data moves — is professional-grade. It's the staleness principle applied to your own sign-offs.
- **QA12 (no broad engineering Fix All)** is a key safety decision. Batching unrelated engineering changes behind one button is how you apply 20 edits you never individually reviewed. Only identical, reversible *drafting* fixes batch; engineering always goes through bounded Preview→Apply→one Undo.
- **QA5 + Ask CE — the AI boundary is exactly right.** AI is a *detector* ("does this required note appear present?"); the **approved checklist is the authority**; and when the AI can't genuinely verify, the answer is **Unknown, never a guessed Pass**.

🔧 **One fingerprint, everywhere.** Staleness now drives five things: PS16 (dialog), PS17 (schedule currency), QA2/QA7 (QA currency), QA13 (exception staleness), and the CV-01 compat check. One data-fingerprint mechanism, built once and reused — not five detectors.

🧭 **The section arc is complete and coherent:** CV-01 (workflow) → CV-02 (hydraulics) → PS-01 (schedules) → QA-01 (issue-readiness). QA sits at the top, verifying that the outputs of all three below it are consistent and defensible. QA15's "Ready to Issue" — QA run against the current fingerprint, no blockers, current downstream outputs, saved evidence with revision + rule versions — is the professional payoff of the entire civil rebuild: a status you can actually trust to sign off on.

🔒 Locked, nothing starts. The evidence list is right, especially "false-clean prevention" and "accepted exceptions that later become stale" — those two test the honesty guarantees that make the whole thing trustworthy.
