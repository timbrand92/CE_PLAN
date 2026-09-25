# AI-01 — Ask CE, MCP connection and workflow automation

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-18`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

## AI-01 — Current AutoCAD state

| Area | Classification | Current result |
|---|---|---|
| `CDASK` dockable palette | **Keep + Modify** | Opens and works. Becomes the unified Ask CE surface. |
| Progress, Stop and timeouts | **Keep—retest** | Fixes exist; final AutoCAD confirmation remains. |
| Seven Drainage AI tools | **Rebuild registration** | Useful tools, but hard-coded inside the Civil palette. |
| Read/write permissions | **Critical rebuild** | `IsWrite` is only a label—it currently blocks nothing. |
| “Read-only” project reviews | **Critical rebuild** | Some run `SyncWithDrawing`, which can reconcile data. Not genuinely read-only. |
| Claude provider path | **Modify** | CE Cloud/Claude works; direct fallback exists. Keep the design provider-neutral. |
| Codex/Claude MCP bridge | **Missing** | Approved architecture, not implemented. |
| AI drawing changes | **Gated** | Must use preview, approval, Apply and one Undo. |
| Engineering QA | **Keep authority separate** | CE engines/checklists decide; AI explains. |
| Structural MarkupAI | **Parked** | Not part of AI-01/v1 unless separately reviewed. |

## AI1–AI15 — Recommended decisions

| ID | Recommended approval | Practical AutoCAD result |
|---|---|---|
| **AI1** | One shared **Ask CE** palette. Canonical command `CEASK`; `CDASK` redirects for one Stable release. | Same assistant from Civil or Structural. |
| **AI2** | Keep it dockable and non-blocking. Show selected drawing, connection and permission level at the top. Retain progress and Stop. | Tim can keep drafting while CE works. |
| **AI3** | Replace the seven hard-coded registrations with the approved central Tool Register. | New tools appear consistently in Ask CE, Help and permissions. |
| **AI4** | Enforce permissions before a tool is shown, before it runs and before Apply. Unknown/missing permissions fail closed. | A read-only session physically cannot alter the drawing. |
| **AI5** | Read tools consume a frozen, genuinely non-writing snapshot. Ban `SyncWithDrawing` from read-only tools. | “Review this project” cannot silently reconcile pit/pipe records. |
| **AI6** | Keep the AI provider-neutral. Claude through CE Cloud remains the production route; direct keys are Tim-development fallback only. | Staff never manage provider keys. |
| **AI7** | Build one local/private MCP connection with pairing code, short-lived token, drawing/process selection, visible status and immediate Disconnect. | `AI Connected — W26-32_CVL.dwg — R3/W2` is always visible. |
| **AI8** | Expose only registered CE tools with checked inputs. Never expose C#, LISP, scripts, terminals or blind command strings. | AI cannot type arbitrary commands into AutoCAD. |
| **AI9** | Defaults: staff `R2/W1`; Timothy `R3/W2`; confidential projects `R0/W0`. Temporary elevation ends with AutoCAD. | Confidential drawing means Ask CE is visibly disabled. |
| **AI10** | Every write follows `Plan → Preview → explicit approval → Apply → one Undo`. Recheck the drawing before Apply; invalidate stale previews. | If a pipe changes after preview, CE refuses to apply an outdated proposal. |
| **AI11** | Rulebook, hydraulic engine and deterministic QA remain authoritative. AI shows source, confidence and `Unknown` where evidence is missing. | Missing cover level produces **Unknown**, never a guessed Pass. |
| **AI12** | Repetitive-work observations may offer **Propose CE Automation**. Approval creates a formal Tool Card—not automatic code. | Repeating six commands may suggest a batch tool without changing anything. |
| **AI13** | Codex/Claude may edit the source repository through branches, review and testing. Never hot-swap AutoCAD, silently change rules, create deployment machinery or deploy. | Loaded AutoCAD stays untouched until an approved release. |
| **AI14** | No continuous drawing scans or network waits. Heavy work uses snapshots, remains cancellable and pauses during commands/save/plot. Target ≥95% automated evidence plus one ≤10-minute Tim acceptance. | Pan, zoom, grips and selection must feel identical with CE loaded. |
| **AI15** | Claude’s privacy approval does **not** cover OpenAI/Codex. Keep Codex drawing access at `R0` until a separate approval records the exact product/account, training setting, retention, residency and confidential-project controls. | No project data reaches Codex until that provider route is signed off. |

OpenAI’s current official position is that Business, Enterprise and API data is not used for training by default; personal workspaces have different defaults. API abuse-monitoring content may be retained for up to 30 days unless approved retention controls apply. Therefore the exact account and connection route matter. [OpenAI business data privacy](https://openai.com/business-data/), [OpenAI API data controls](https://platform.openai.com/docs/models/default-usage-policies-by-endpoint), [consumer data controls](https://help.openai.com/en/articles/8983130-what-if-i-want-to-keep-my-history-on-but-disable-model-training).

### Approval

My recommendation is **approve AI1–AI15 as written**.

Reply:

- `Approve AI-01 all`, or
- changes such as `AI1 keep CDASK permanently; AI9 change…`

No files, builds or deployments were changed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-19

✅ Approve AI-01 all
This is the security-critical card, and it's built the right way — as layered defense, not a single wall. That's what makes an AI safe to put inside a professional engineering tool.

🛡️ The layers — and why they matter together
Even a fully prompt-injected Ask CE (someone feeds it malicious instructions through a drawing or a document) cannot do arbitrary harm, because four independent gates all have to fail:

AI8 — containment: it can only call registered CE tools with checked inputs. No C#, no LISP, no scripts, no raw command strings. The AI literally cannot type a command into AutoCAD.
AI4 — permissions, fail-closed: checked before the tool is shown, before it runs, and before Apply. Unknown = blocked.
AI10 — human gate: every write is Plan→Preview→explicit approval→Apply→one Undo, and a stale preview is refused.
AI13 — the coder can't reach production: Codex/Claude edit the repo through branches/review only; never hot-swap AutoCAD, never deploy, never silently change a rule.
Any one of those alone would be a real control. Together they mean the worst case is "the AI proposed something wrong and you didn't approve it." That's the correct bar. AI5 (read-only = a frozen snapshot, SyncWithDrawing banned) closes the specific hole where a "review" was quietly writing — critical.

🎯 The sharpest catch — AI15 × AI13 seam
AI15 correctly keeps Codex at R0 for drawings until its own privacy sign-off (right call — Claude's approval doesn't transfer to OpenAI, and you've got the retention facts right). But AI13 gives Codex access to the repository. Those two are only consistent if the repo contains no client-identifying data — and the risk is corpus/, which the audit found is built from real drawings. If those snapshots carry client names/addresses/job numbers, then "Codex can code but sees no client data" is quietly false.

Before Codex touches the repo: confirm corpus/ (and any committed fixtures) are sanitised — synthetic or de-identified. That's the seam that makes AI13 + AI15 actually hold together.

🔧 Three smaller reinforcements
AI4/AI5 must enforce at the write boundary, not the UI. "Physically cannot alter the drawing" means the executor itself refuses a write at R0/W0 — not just a hidden button. A hidden button + an unguarded executor is bypassable.
AI9's confidential flag should travel with the project (SH-04 #4). A confidential job must be R0/W0 on any machine, not reliant on one PC's setting — otherwise it's Ask-CE-disabled on your PC and wide open on someone else's.
AI7's MCP bridge binds localhost only (not 0.0.0.0) — a local/private bridge must not be reachable from another machine on the network.
(Minor, re your AI1 option: I'd lean CEASK canonical + keep CDASK as a permanent alias rather than retire it — it's civil muscle memory, same reasoning as keeping the Copy/Rotate aliases in TF3. Low stakes either way.)

📋 On your planning-record note — important, and you're right
The visible commits stop at TF, but SH-04, F/CT/TH/RS/PD, CV-01, CV-02, PS-01, QA-01 and now AI-01 are all chat-approved and not yet in the committed docs. They're safe in this conversation, but that's not durable enough. When records are next updated, all of those must be preserved — I'll fold them in as one consolidated pass: the foundation decisions (SH/F/CT/TH/RS/PD/SH-04) and the command cards (CV-01→QA-01, AI-01), each with its approved decisions and my review notes. Say the word (and CLEAN_SLATE_REBUILD.md vs a new docs/CARDS/ folder) and I'll write them all in so the git record matches where we actually are.

🔒 Locked, nothing starts
Provider-neutral, fail-closed, containment-first, human-gated, and honest about a second provider's privacy. This is how AI belongs in the tool. Ready for the next card.
