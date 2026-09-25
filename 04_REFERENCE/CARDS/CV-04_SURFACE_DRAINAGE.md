# CV-04 — Surface drainage and tanks

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-37`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# CV-04 — Surface and site drainage

### Current AutoCAD state

| Tool | What works | Required treatment |
|---|---|---|
| `CDSTRIP` | Later AutoCAD retest passed; strong corner/arrow tests | **Keep behaviour; rebuild as one compound** |
| `CDFW` | Placement was AutoCAD-confirmed | **Move onto CV-03 placement backbone** |
| `CDWT` | Tank capacities and Inspector display work | **Rebuild workflow and compound grouping** |
| `CDSOURCE` | Timothy rebased its block after the original 211 m offset | **Verify automatically; tighten identifiers** |
| `CDAGI` | Draws and registers an AGI polyline | **Rebuild—depends on Timothy’s personal template path** |

Key risks:

- `CDWT` can leave a partly created tank if cancelled after placement.
- Tank, callout, riser and dropper are not reliably grouped as one object.
- `CDAGI` relies on a path that will not exist on staff computers.
- `CDSOURCE` permits unrestricted identifiers and possible duplicates.
- Surface assets are currently stored as pretend pit records.
- `CDSTRIP` documentation conflicts, but the later code and Timothy’s later test confirm corner FWs on the centreline.

## CV4-1–CV4-15 recommendations

| ID | Recommended decision | AutoCAD example |
|---|---|---|
| CV4-1 | Keep all five familiar commands. | Existing typing and ribbon habits remain. |
| CV4-2 | Use one surface-drainage backbone sharing CV-03 identity, preview and connection rules. | CDFW and DP cannot drift into different tagging behaviour. |
| CV4-3 | Store strip drains, FWs, tanks, AGIs and generic sources as their real asset types—not fake pits. | QA can distinguish a floor waste from a drainage pit. |
| CV4-4 | `CDSTRIP` remains a 100 mm MLINE, open by default; `Close` explicitly closes it. | Drawing a channel along a wall does not unexpectedly form a loop. |
| CV4-5 | Lock the later Timothy ruling: corner FWs sit exactly at the strip centreline intersection for every justification. | No 0/25/50 mm corner offset conflict. |
| CV4-6 | Keep 50 mm end inset and 12 m maximum intermediate spacing as versioned CE office rules, with project override—not scattered fixed numbers. | A 25 m run receives the required intermediate FWs predictably. |
| CV4-7 | Preview FW positions, high-point lines and arrows before committing. Default to the approved two-way fall between adjacent FWs; allow a deliberate one-way choice. | A one-way strip to FW3 cannot receive invented opposing arrows. |
| CV4-8 | `CDFW` uses stable `FW` identities, non-recycled numbering and the shared placement/overlap preview. | Deleting FW4 leaves a safe numbering gap. |
| CV4-9 | `CDWT` starts with a clear mode: **adopt existing block**, **insert CE tank**, or **annotate existing detention pit**. | Picking a pit cannot silently change the command’s meaning. |
| CV4-10 | Total capacity is required; detention cannot exceed total; reuse remains total minus detention. Missing engineering values remain Unknown. | No false zero-capacity tank. |
| CV4-11 | Tank, callout, riser, dropper, capacities and connections form one compound with permanent relationships—not proximity matching. | Moving WT2 carries its entire annotation set. |
| CV4-12 | `CDSOURCE` keeps approved source categories first; Custom is advanced. Duplicate identifiers are blocked. | “ROOF DRAIN” cannot accidentally be created twice. |
| CV4-13 | Automatically prove that `SOURCE.dwg` inserts at the picked point. The old 211 m offset becomes a permanent regression check. | No repeat manual base-point test. |
| CV4-14 | `CDAGI` ships its approved line type with CE. Remove Timothy’s personal template dependency; preview open/closed geometry and store the actual entity—not copied coordinates in remarks. | CDAGI works identically on every staff computer. |
| CV4-15 | Apply each compound atomically with one Undo and targeted nearby updates. Automated evidence covers cancel, copy, UCS, block origin and large drawings; Timothy checks one strip, tank and AGI in about five minutes. | No partial tank and no drafting lag. |

**Recommendation:** approve CV-04 as presented. The visible drafting stays familiar while the storage, cancellation, portability and compound behaviour are rebuilt safely.

No files changed, builds run or deployment performed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-38

✅ Approve CV-04 as presented
Consistent with CV-03 — same backbone, real asset types (CV4-3), stable identity, atomic compounds, Unknown-not-false. Three things worth calling out because they're doing real work:

🎯 CV4-11 is the systemic fix — "permanent relationships, not proximity matching"
This phrase is bigger than tanks. Proximity matching — figuring out which callout/riser/dropper belongs to which tank by distance — is the same fragile heuristic that breaks beam links and strews pit labels. Move something and the associations swap or drop. Replacing it with permanent relationships stored by identity (CT2) — the callout belongs to WT2 no matter where either sits — is the cure, and it's the same move as everywhere else in the rebuild: fragile inference → stored authority. "Moving WT2 carries its entire annotation set" is that principle made visible. This is one of the more important lines in the whole civil section.

📖 CV4-5 resolves a real rulebook contradiction
The corner-FW inset was one of the genuine conflicts I flagged in the rulebook mining — two rules both marked "locked": early "corner FW on centreline, no inset" vs later "0/25/50 per justification." CV4-5 rules centreline for every justification, and crucially CV4-5 (corner = centreline) + CV4-6 (end = 50 mm inset) cleanly separate the two cases that were being conflated — corner vs end. That conflation is what caused the confusion. This is the rulebook governance working exactly as intended: contradiction surfaced → you ruled → locked, cleanly.

🔧 CV4-14 fixes two root causes at once
Portability: CDAGI depending on your personal template path means it's broken for every staff member but you. Shipping the linetype with CE fixes it — and this generalises: any tool with a personal-file dependency needs its asset shipped in the bundle (and updated via the RS12 hash mechanism). Worth a scan for other personal-path dependencies while you're here.
One authority: "store the actual entity, not copied coordinates in remarks" — remark-coordinates are a second source of truth that drifts from the drawn geometry. Storing the real entity is design rule #2, again.
✅ Two quick affirms
CV4-13 turns the old 211 m base-point offset into a permanent regression check — the "every fixed bug becomes a guard" discipline (rule #11). It can't silently come back, and you never hand-test the base point again.
CV4-10 — detention ≤ total is a real physical constraint (like HD9 feasibility), and "missing capacity = Unknown, no false zero-capacity tank" is the CV3-10 dangerous-false-value fix applied to tanks.
🔒 Locked, nothing starts
The visible drafting stays familiar; the storage, cancellation (no partial tank, CV4-15), portability and compound behaviour get rebuilt on the shared foundation. Ready for the next card.
