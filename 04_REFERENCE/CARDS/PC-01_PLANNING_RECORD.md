# PC-01 — Planning record, residual-command coverage and implementation sequencing

**Planning:** PC1–PC15 approved 2026-07-22
**Implementation:** document-only recording pass complete; product implementation not started
**AutoCAD verification:** not applicable
**Design rules enforced:** one authority, command truth, fail closed, evidence before confidence, nothing done
until AutoCAD-confirmed

## Current state at approval

- 37 earlier workflow cards were approved; only seven had complete durable card files.
- Civil and Structural family inventories existed, but no command-to-card coverage table existed.
- Implementation remained 0% and no deployment was authorised.
- DATA-01 had not passed.

## Binding recording conditions

1. Perform the pass only on `claude/autocad-plugin-architecture-b3c751`.
2. Use one canonical `AREA-NN` scheme and map the seven existing `FND-*`/`SH-*` files into it; legacy IDs
   remain searchable references only.
3. Inspect committed corpus history as a mandatory part of DATA-01 Gate 0.
4. Add a `Design rules enforced` field to every completed card.
5. Mark transcript-only cards `Record incomplete—retrieve approved source`; never reconstruct them.

## Approved decisions

| ID | Decision |
|---|---|
| PC1 | Use `docs/CARDS/` for the durable card catalogue; reference rather than duplicate existing workflow files; use one `AREA-NN` canonical ID scheme. |
| PC2 | Maintain one visual master index with separate Planning, Implementation and AutoCAD states. |
| PC3 | Each completed card records current AutoCAD state, exact workflow, decisions, examples, dependencies, evidence, Tim check, review notes and design rules enforced. |
| PC4 | Preserve approved wording. Missing source is recorded as incomplete and blocks implementation. |
| PC5 | Use controlled Planning and Implementation status vocabularies so approval cannot be mistaken for completion. |
| PC6 | Preserve Timothy's reasoning and the bugs/principles each decision closes. |
| PC7 | Map every current registry command and alias to one canonical `AREA-NN` tool/card/owner/status. |
| PC8 | Aliases are entry points to one workflow, not separate tools or implementations. |
| PC9 | Unmapped commands fail closed as Hidden + Review Pending or Test-only. |
| PC10 | Record asset, project-data, rulebook, calculation, corpus and provider dependencies. |
| PC11 | DATA-01 is Gate 0; current files, coordinates, metadata, warning-positive samples and committed history are mandatory checks. |
| PC12 | Implement in dependency order: Gate 0 → foundation → shell/assets → vertical Civil/Structural workflows → QA/coordination → AI bridge → corpus assistance → controlled release. |
| PC13 | A card enters implementation only with an approved workflow, authority boundaries, command/assets mapping, object lifecycle, tests, short AutoCAD check and cleared prerequisites. |
| PC14 | Use automated/corpus comparison plus one short representative AutoCAD check; Timothy reviews exceptions. |
| PC15 | Complete the planning-document reconciliation only—no product code, build, helper script, deployment or corpus extraction. |

## DATA-01 audit result recorded during PC-01

The local history-aware audit returned counts only and did not print client filenames or coordinates:

| Measure | Result |
|---|---:|
| Current tracked corpus files | 141 |
| Obvious identifier-bearing snapshot filenames | 89 |
| Unique historical corpus paths | 142 |
| Historical corpus objects | 163 |
| Local/remote refs whose tips still contain the corpus | 65 |

**Result: Gate 0 failed.** Current-file renaming is insufficient. Remediation requires a separately approved,
coordinated history rewrite with clone/force-push planning, or an approved restriction that prevents AI from
reading repository history. This card does not authorise either destructive action.

## Implementation entry sequence

```text
DATA-01 clearance
      ↓
FND-01/CT-01/TH-01/RS-01/PD-01/SH-01 foundation and one Tool Register
      ↓
AS-01 assets + project data/settings
      ↓
Civil and Structural vertical workflow slices
      ↓
QA/schedules/coordination
      ↓
AI-01 local MCP bridge
      ↓
EV-gated corpus suggestions
      ↓
Controlled release
```

Normal builds, when later authorised, must use `-p:SkipDevBundle=true`. Deployment still requires Timothy's
exact instruction: **“AutoCAD is closed, deploy.”**
