# EV-01 — Whole-practice corpus and automation evidence

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-75`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-01 — Whole-practice corpus and automation evidence

## What already exists

| Evidence | Current coverage | Gap |
|---|---:|---|
| Civil archive census | **1,933 jobs, 2020–2026** | Mainly filenames/archetypes, not drafting relationships |
| Existing project index | 1,123 projects; approximately 14,000 DWGs | Not yet filtered into reliable approved-input/output pairs |
| Markup/issue pairing candidates | Approximately 1,700 high-confidence pairs | Valuable, but privacy clearance and final-revision validation required |
| Structural snapshots | 89 extracted JSON drawings | Concentrated in 2023/2025/2026; incomplete for 2020 onward |
| Civil auto-design evidence | 14 approved calculation reproductions | Strong engineering calculations; full plan drafting remains unproven |
| Placement probes | Small samples for pits, XREFs and sheets | Too narrow for the complete drafting picture |
| Privacy readiness | Not cleared | Existing snapshots include identifying filenames/path metadata and remain Restricted |

## Evidence pipeline

```text
RAW LOCAL ARCHIVE
DWGs + XREFs + calculations + markups + final issue
                    ↓
      Local read-only extraction
                    ↓
De-identified relationship “scene records”
                    ↓
 ┌──────────────────┼──────────────────┐
Pattern atlas    Gold benchmarks    Similar-job library
 └──────────────────┼──────────────────┘
                    ↓
Context-aware drafting + engineering proposals
                    ↓
         Complete drawing preview
                    ↓
       Human checks exceptions/errors
```

## EV1-1–EV1-15 for approval

| ID | Recommended decision |
|---|---|
| **EV1-1** | Lock the North Star: project information goes in; CE proposes the engineering design and complete drawing; humans review exceptions, errors and final issue readiness. |
| **EV1-2** | Pause ST-03 onward until the corpus study establishes how the office actually draws and coordinates complete projects. Existing approved cards remain locked. |
| **EV1-3** | Raw client DWGs, PDFs and calculations stay local. Initial extraction is deterministic and provider-free. Codex/Claude receive only DATA-01-cleared records after separate provider approval. |
| **EV1-4** | Build matched project sets: architectural/survey/consultant inputs + engineering markups/calculations + final approved CE DWG/PDF. A final drawing alone shows *what*, but often not *why*. |
| **EV1-5** | Gold drawings must be verified approved/issued revisions. Exclude setup files, autosaves, recovered files, temporary markups and “largest file” guesses. |
| **EV1-6** | Extract a relationship-based drawing model: objects, layers, blocks, text, XREF transforms, viewports, scales, relative geometry, ownership and connections—not merely screenshots or entity counts. |
| **EV1-7** | Record contextual scenes for each drafting element: beam-to-support, column-to-wall/grid, label-to-owner, brace-to-wall/opening, rafter/joist-to-span and civil pit/pipe/source relationships. |
| **EV1-8** | Classify every finding as **Fixed input / Engineering decision / Drafting presentation / Exception / Unknown**. This stops a common drafting pattern being mistaken for an engineering rule. |
| **EV1-9** | The deterministic rulebook, calculations and standards remain engineering authority. The corpus supplies placement evidence, common solutions and constructability patterns. |
| **EV1-10** | Segment evidence by project archetype, discipline, sheet type, council, building type and era. Treat 2020–2022 as legacy evidence and weight recent approved work toward the current standard. |
| **EV1-11** | Use markup→final revision pairs to learn corrections: what moved, what was renamed, what was deleted and what the engineer deliberately changed. These pairs are more valuable than isolated final drawings. |
| **EV1-12** | Reserve entire unseen projects as the test set. Never test on another sheet or revision from a project used for pattern mining. Score placement, relationships, clashes, completeness and engineering agreement separately. |
| **EV1-13** | Start with interpretable pattern mining and similar-approved-job retrieval. Context suggestions come next; complete design/drawing previews follow only after those stages pass objective evidence gates. |
| **EV1-14** | The study produces four durable outputs: **Drafting Pattern Atlas**, **Engineering Context Map**, **Gold Drawing Benchmark**, and **Automation Opportunity Register**. Every proposed automation becomes a formal CE Tool card for approval. |
| **EV1-15** | Corpus processing runs outside active AutoCAD with no drafting lag. Automated comparison carries routine coverage; Timothy reviews visual pattern summaries, contradictions and low-confidence exceptions—not thousands of drawings or command combinations. |

Recommendation: **approve EV-01 all** and make it the next planning stage. This is the route from hundreds of isolated commands toward one context-aware system that can eventually design and draw the project as a coordinated whole.

No raw corpus analysis, file changes or implementation has started.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-76

This is the right pivot — and it's worth naming why it's right before the line-items. The entire thesis of this rebuild is "the tools encode rules that were never written down." The corpus is where those rules — and the drafting patterns around them — actually live. So grounding the remaining work in mined evidence, instead of continuing to guess command-by-command, is the logical next move, not a detour.

And your old → new inversion is the single biggest process improvement in the whole program:

Tim tests hundreds of situations → auto-compare against approved work, Tim reviews only exceptions.

That directly cures the two worst findings from the very start: the ~60 fixes that were never driven and the manual-test backlog too large to clear. It scales your review from "exercise everything by hand" to "adjudicate the exceptions." Big.

✅ Approve EV-01 all
🧠 The four disciplines that make corpus-mining safe — EV1-8, EV1-9, EV1-11, EV1-12
Mining historical drawings is dangerous if done naively: you'd learn from inconsistent old work and launder common patterns into false "rules." These four are the firewall:

EV1-8 (classify every finding) is the intellectual core. Observing that "the label is usually on the left" must be tagged Drafting presentation, not mistaken for an Engineering decision — and a 1:100 grade tagged Engineering, not a drafting convention. That classification is what keeps the corpus honest.
EV1-9 (rulebook stays engineering authority; corpus supplies placement/constructability) is the boundary. The corpus tells you where the office puts the label; the deterministic rulebook tells you the grade. Never let the corpus decide engineering — that's the confidently-wrong-at-scale trap, learned from potentially-inconsistent history.
EV1-11 (learn from markup→final diffs) is the deepest insight: the corrections are where the office's judgment lives. A final drawing shows what; the correction shows why. Those ~1,700 pairs are worth more than any pile of isolated finals.
EV1-12 (hold out entire unseen projects, score dimensions separately) is proper test hygiene — and it's the phantom-test problem solved at the evidence level. Testing on another sheet from a mined project is data leakage; a real held-out project is the only way "it works on the corpus" means anything.
Get those four right and the corpus is trustworthy evidence. Get them wrong and it's an expensive way to confirm your own biases. You've got all four.

⚠️ The one real risk — give the study an exit
The command cards were finite (15 decisions, done). The corpus study is open-ended — it can expand forever. EV1-13's "objective evidence gates" is the right mechanism, but define the gate thresholds up front: what held-out score, on which dimensions, is "good enough to resume ST-03"? Otherwise the study becomes an indefinite research project that quietly delays everything. Make EV-01 a bounded stage with a stated finish line, not a standing program.

💡 One option to keep in your back pocket
The 22 locked cards are grounded in the rulebook + bug history, not the corpus — so their mechanisms (the resolver, preview→apply, one-authority, atomic core) don't depend on it. If you ever want to unblock progress, those mechanisms could begin implementation in parallel with the corpus study, feeding corpus-derived defaults in later as advisory refinements (the CV5 "build the tool, refine the values" pattern). Purely your call — I know you're deliberately planning fully before building — but the dependency isn't as tight as "everything waits for the corpus."

🔒 Approved as the next planning stage
Local-and-deterministic extraction (DATA-01 enforced), relationship models not screenshots, era-weighted, staged behind evidence gates, four durable outputs, every automation routed through a Tool card. This is the honest route from hundreds of isolated commands toward one coordinated system — pursued in the one way that won't fool you. No raw analysis or implementation has started; nothing begins until the gates say so.
