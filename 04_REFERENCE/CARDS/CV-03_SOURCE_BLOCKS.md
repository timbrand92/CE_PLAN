# CV-03 — Drainage source blocks

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-31`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# CV-03 — Drainage source blocks

### Current AutoCAD state

| Tool | Current position | Treatment |
|---|---|---|
| `DP / IO / OF / FO` | Historically AutoCAD-confirmed; shared placement works | **Modify and automate tests** |
| `CDTG` | Strongest source tool; direction, size, class, level and linking work | **Keep and refine** |
| `GIO` | AutoCAD-confirmed; block shipping checked | **Modify—direct placement tests missing** |
| `CDTAG` | Works for standard and consultant blocks | **Rebuild safety around retag/remove** |
| `CDRG` | Working raingarden outline, hatch and optional GIO | **Include in CV-03; strengthen atomic Undo** |
| Simple placements | Perform a full drawing sync and endpoint relink | **Replace with targeted updates to avoid lag** |

Important findings:

- `FO` currently uses the same block as `OF`, with only its internal type changed.
- `CDTG` can display `CL 0.000 m AHD` when the level was actually skipped.
- Source overlap is detected after placement rather than safely during preview.
- `CDTAG` accepts unrestricted typed identifiers.
- Direct insertion, cancellation and Undo evidence is weak for most source tools.

## CV3-1–CV3-15 recommendations

| ID | Recommended decision | AutoCAD example |
|---|---|---|
| CV3-1 | Include `CDRG` because it creates and manages the GIO source relationship. | No orphaned raingarden command. |
| CV3-2 | Keep all familiar command names. Keep `TG` as a hidden redirect to `CDTG`. | Existing typing habits continue working. |
| CV3-3 | Preserve the proven placement behaviour but use one common source-placement backbone. | DP and IO follow the same safe rules. |
| CV3-4 | Remove full drawing scans from ordinary placement. Update only the new source and nearby pipes. | Placing DP40 stays instant in a large plan. |
| CV3-5 | Every source receives a live ghost preview before the confirming click. | See the OF block and label before placement. |
| CV3-6 | Internal identifiers use the next highest number and are never silently recycled. | Deleted `DP4` does not cause a new unrelated DP to become `DP4`. |
| CV3-7 | Drawing labels may remain `DP`, `IO`, `OF` etc.; unique numbers remain stored internally. | Clean plan appearance with reliable connections. |
| CV3-8 | `DP`, `IO`, `OF`, `FO` and `GIO` are source nodes; TG is a network node; CDRG remains a surface asset linked to its GIO—not a fake pit. | QA understands what each object represents. |
| CV3-9 | `FO` remains a distinct engineering type. Sharing the OF graphic is allowed only if the approved block catalogue confirms they are visually identical. | No accidental OF/FO misclassification. |
| CV3-10 | Missing levels remain **Unknown/blank**, never `0.000 m AHD`. | Skipping TG cover level cannot create a false RL. |
| CV3-11 | Show overlap and proposed pipe-split during preview. Ambiguous connections are blocked until repositioned or deliberately overridden. | Two nearby pipes cannot silently claim one IO. |
| CV3-12 | Respect the current UCS. Direction-sensitive blocks offer a simple Rotate option without adding another compulsory prompt. | Place an OF along a rotated building wall. |
| CV3-13 | `CDTAG` uses approved source types by default. Duplicate identifiers are blocked; custom types require an advanced choice. | Tag a council block as `IO`, not arbitrary mistyped `I0`. |
| CV3-14 | Retag/remove previews affected pipes. Block, label, callout, data and connections act as one compound object with one Undo. | Removing `IO3` shows its two affected pipes first. |
| CV3-15 | Automated tests cover every source, UCS, overlap, split, cancel, Undo and large-network timing. Timothy performs one short final sample only. | Place DP + TG + CDRG, retag one block, Undo—about five minutes. |

**Recommendation:** approve CV-03 as presented. It keeps the drafting experience familiar while rebuilding the hidden linking and safety plumbing.

No files changed, no build run and no deployment performed. Planning-record consolidation remains pending.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-32

✅ Approve CV-03 as presented
Clean card — it's the source-block application of the same discipline that runs through everything: one shared placement backbone (CV3-3), stable identity (CV3-6/7), atomic compound objects (CV3-14), Unknown-not-false (CV3-10), preview-time checks (CV3-11), and input validation (CV3-13). Familiar on top, rebuilt plumbing underneath — exactly right.

🚨 CV3-10 is the critical safety fix
A skipped level showing 0.000 m AHD is the most dangerous kind of false value — 0.000 is a real, plausible-looking RL, so a drafter reads it as "cover level is 0.000" when it's a ~45 m error, not an obvious blank. Making it Unknown/blank is the same honesty rule as HD12 (no surface → Unknown, never Pass), and here it prevents a genuinely hazardous silent wrong number. Strongly endorsed.

🎯 CV3-9 (OF/FO) — the one thing to actively confirm
The fix (keep FO a distinct type in data; share the graphic only if the catalogue says they're visually identical) is right. But the real question underneath it is a drafting-standard call only you can make:

Are OF and FO meant to look identical on the plan?

Yes → share the graphic; the data (CV3-8) keeps them distinct, and QA reads the type, not the symbol.
No → they need distinct symbols, and the current shared block is itself the bug.
If you go "visually identical," note the consequence: a human/QA can then only tell OF from FO by the data — so the type field has to be rock-solid (which CV3-8/CV3-9 give you). Just make it a deliberate "yes they're the same symbol," not an accident inherited from the current shared block.

🔗 One connection — CV3-14 × CV20
A source block is a compound object (block + label + callout + data + connections). So when one is copied, CV20 must re-identify the whole set — new internal identity for the block and its label/data — not just the block. Otherwise a copied DP silently shares identity with the original (the exact trap CV20 exists to close). Consistent with CV3-6's never-recycle rule: copies get fresh numbers, deletions leave safe gaps.

📝 Minor
CV3-6's non-recycling means numbering can have gaps (delete DP4 → next is DP5, DP4 stays retired). That's intentional and safe — gap-free renumbering is the explicit PS18 operation, never silent recycling. Worth saying so staff don't file the gap as a bug.

🔒 Locked, nothing starts
CV3-3 (one backbone) and CV3-11 (overlap/split shown during preview, ambiguous connections blocked) are the two that kill the most bugs here — the source tools stop drifting apart, and you can't commit an ambiguous connection you'd only discover afterward. Ready for the next card.

## C3-A complete landing and pit association (2026-09-10)

The Control Room approved a dependent complete-preview/receipt then actual-placement bundle under CV3-3/4/5/8/11/12/14/15. Its source-only pit association design is recorded before schema code in `docs/workflows/C3A_SELECTED_SOURCE_ROUTING_2026-09-09.md`: one optional source `PIT_LINK` relationship binds exact source/pit permanent identities; the pit retains hydraulic ownership. Retag preserves it, removal clears it, unresolved records refuse, and COPY requires the exact placement map. No reverse list or nearest-pit reassignment is introduced. Latest corrections let one proved free pipe end take precedence over its own nearby run while retaining all pipe XYZ; keep placed schedule cells current in the same source transaction, including exact split-half bindings and indirect FROM changes through IO nodes; and preserve authored overrides and unrelated stale cells. Shared endpoint-claim reads retain the existing ownership proof. The final local Release matrix passed 622 targeted checks on each of net48, net8.0-windows and net10.0-windows, with no failures or skipped checks. Native COPY support remains AutoCAD 2027-only; root integration, independent review and the existing single consolidated AutoCAD acceptance batch remain pending. This does not complete all C3 workflows. The verbatim approved card above is unchanged.

## C3-A atomic pipe-run dependencies (2026-09-09)

- Landing now has a fail-closed internal receipt: zero tracked pipes means no split, one means a target may proceed, and multiple means ambiguous/refuse. It checks only pipe handles in the detached drawing snapshot; it does not scan ModelSpace or pick the nearest candidate.
- A target-only internal preflight proves the exact straight planar pipe, its two recorded owners, writable layers, project/link identity, child ownership and snapshot writability before a future source insert starts.
- A newly appended source can receive one verified `SPINE_ID` through the existing spine writer in the caller's transaction. Existing identities are refused.
- The embedded project snapshot can be read, bounded and cloned through the caller's transaction without changing the process cache.
- Command routing is deliberately unchanged. The current working placement path remains active until the final outer coordinator and native AutoCAD acceptance are reviewed.

### Internal outer coordinator

The coordinator proves one exact target before its first drawing write, then performs block append, stable tag allocation, fresh source identity, label, connection ownership and the prepared tracked split in one AutoCAD transaction. It writes the final detached project snapshot once and commits once. Only after commit does it adopt the project snapshot and publish runtime positions. A cache failure reports the source as already placed and attempts a bounded cache repair; it never reports a rollback after commit. Prompted placement routes here only for the supported receipt described below; free-standing, pit, pipe-end, legacy-owner and unsupported placement retain their established owners pending native acceptance.

### Live placement preview and narrow prompted routing

- The shared block jig has an optional internal feedback callback. Prompted DP/IO/OF/FO/GIO placement uses it; supplied-point/programmatic callers retain the established placement owner, UCS conversion, block scale and rotation.
- The source callback reads one detached embedded snapshot and builds one lightweight immutable pipe-geometry grid before dragging. At each changed cursor point and again after the confirming click, it uses that spatial grid to reopen only nearby snapshot-listed handles for exact current checks. It does not scan the tracked network, write drawing/project data or copy the full project per mouse movement.
- The confirming click performs one authoritative tracked-handle refresh. A newly registered, removed or moved pipe rebuilds the grid and refuses that click so the drafter can see the refreshed result and repick; ordinary mouse movement still uses nearby candidates only.
- A green line and words are shown only when one tracked straight pipe, both exact endpoint owners, the current pipe entity and the current cached project row prove the prepared split. The line is centred on the exact prepared split point.
- More than one tracked crossing, a stale/corrupt identity or handle, an unlocatable tracked row, protected target/child or failed exact-target check shows red refusal feedback. The click is not accepted; the drafter can move and pick again or press Escape. Zero matches and independently validated legacy geometry unsupported by the new coordinator stay neutral. Missing optional legacy endpoint overrides alone do not make the pipe corrupt; any override that is present must resolve to its matching writable owner.
- A supported final receipt is accepted only when it still matches the jig's final WCS insertion point. The coordinator reopens that exact pipe/owner receipt and compares its geometry, link and project fingerprints before its first append; it never selects a different pipe at the same point. Neutral valid legacy geometry continues through the established linked-placement owner. Refused or changed evidence returns to the jig for repick/Escape, and a failed coordinator returns without falling back to a second insertion path.
- Native AutoCAD acceptance still has to confirm ghost rendering, repeated repick, Escape, UCS, rotation, one Undo, save/reopen and that established neutral pit/end/legacy paths remain unchanged.
