# Civil automation, override and revision contract

**Proposed contract for review.** This tells a drafter what CE may propose, what must be confirmed, and what remains visible when the job changes. It is not yet Tim-approved and does not authorise implementation.

## The promise in plain drawing terms

CE may find documents, read likely values, measure a selected outline and point out what a changed boundary affects. It must never quietly turn that proposal into the number used on the plan, in a calculation or on an issued sheet.

## Adoption and basis stay separate

**Adoption status** says whether a value may drive engineering. **Basis/provenance** says where it came from and how certain it is. A source or measurement is not automatically governing merely because it is newer or more precise.

| Adoption status | What the user sees | Can it drive design/drawing? | Refresh behaviour |
|---|---|---|---|
| Evidence — not adopted | “Found in [document/page/revision]” or “Measured from selected outline” | No | It is compared again; original evidence remains. |
| Proposal — not adopted | “CE suggests …” with confidence/limits where known | No | A later source may add another proposal; neither replaces a governing value. |
| Governing / confirmed | “Using this value” plus decision | Yes | It remains until the engineer changes it; conflicting evidence creates **Needs review**. |
| Manual / pinned governing | “Manual/Pinned — reason …” | Yes, where the engineer chose it | It is never overwritten. Competing evidence stays visible and may require review. |
| Display override | “Plan wording/position differs” | Never changes engineering by itself | It stays presentation-only; it cannot overwrite an authoritative plan label. |

| Basis / provenance | Visible treatment | Review consequence |
|---|---|---|
| Source evidence | Document/page/revision/status and extraction context | It may be evidence or a confirmed governing value; those are separate facts. |
| Measured | Selected geometry, unit, measurement method/limits | A changed measurement is evidence first; it does not rewrite a governing pin. |
| Manual | User-entered value and reason | It may be governing only after explicit adoption. |
| Assumed | Explicit **Assumed** badge, stated reason/source basis and scope | A confirmed assumption remains visibly **Assumed**; confirmation does not convert it into measured/source certainty. It remains review-relevant when its basis changes. |
| Unknown | Explicit **Unknown** badge | It cannot be silently treated as an assumption, zero, blank default or quiet Melbourne/council default; a required Unknown gives **Cannot calculate**. |

## Source hierarchy and governing choice

1. Keep every discovered source as evidence with identity, internal date/revision/status, page/location and discovery path(s).
2. Detect byte-identical copies as one evidence item with multiple locations. Do not count it twice.
3. Compare non-identical versions. File/folder name and newest timestamp help discovery but do not select the governing source.
4. Show changes in value, scope, date/revision/status and the dependent values they may affect.
5. Engineer chooses **Use this source**, **keep current governing value**, **enter/manual pin**, or **leave unresolved**. A reason is required for manual/pinned choice and a clear description is shown later.
6. Only a chosen governing value may feed calculation or drawing application. A proposal can stay visible while drafting continues.

## Plan label authority and reconciliation

The standing Civil rule is that the **plan label is the authority** and the record follows it; CE must never rewrite plan text merely to make it match a record. This coexists with the source model as follows:

1. A legitimate plan-label edit is read/reconciled into the corresponding engineering record when the established label contract supports that field.
2. If CE cannot safely parse/reconcile the label, it shows a label-versus-record conflict and offers the owner workflow; it does not silently take either side.
3. A display-only position/wording override is separate. It cannot masquerade as an engineering input or hide a label/record disagreement.
4. Report/document extraction remains source evidence. It cannot overwrite either a confirmed engineering value or an authoritative plan label without an explicit reviewed decision.

## User actions by record type

| Record | Actions | Confirmation door | Saved result |
|---|---|---|---|
| Document | View, compare, mark governing, exclude with reason, Select/change documents | “Use this version for these values?” | Source identity, page/revision/status, decision/reason. |
| Requirement / criteria | Accept proposal, choose alternative, manual/pin, clear override | “This will affect calculations/output” | Governing value, source and override trail. |
| Site boundary | Accept proposed outline, adjust, select existing outline, draw, manual area | “Use this boundary for site extent?” | Boundary identity/geometry, measured area/unit and source/decision. |
| Surface | Confirm/change class, split/join, exclude/intentional overlap | “This changes surface take-off, not catchment allocation by itself” | Surface class/basis and reason. |
| Hydraulic catchment / allocation | Select/draw/link, set contributing portion, assign treatment/destination, remove assignment | “This changes calculation inputs; review affected results” | Catchment identity, portion, destination and dependent-state flags. A DP has one confirmed destination; a roof can still have unequal portions assigned to different DPs. |
| Physical object | Place/edit/connect through its owner command | Owner editor preview then Save | Civil identity/geometry/engineering/presentation state. |
| Calculation | Inspect inputs, calculate, choose reviewed output application | “Apply selected result to drawing outputs?” | Result ID/input revision, outputs generated and dependency state. |

## Area and catchment rules

- Site extent answers “what land is in the job”. Surface classification answers “what this area is made of / how it behaves”. Hydraulic catchment answers “what runoff is collected and where it goes”. They may refer to overlapping geometry but they are not interchangeable records.
- Before proposing a new roof/catchment boundary, inspect known catchment-plan evidence and existing confirmed project catchments.
- A DP references a confirmed contributing portion. Several DPs may reference one catchment, but their portions must reconcile against the catchment total. CE does not equal-divide the roof without an explicit user choice.
- Existing report area, measured outline area and manual area are all shown. A manual number does not reshape the outline. A measured outline does not rewrite a source report.
- Overlap, duplicate counting, unallocated remainder and conflicting treatment destination create warnings. Intentional exceptions require a visible reason.
- CE does not infer hydraulic links from lines that cross, are near one another or sit on a similar looking roof. Explicit link or proven connection is required.
- Unclassified remainder stays Unclassified. It does not become pervious, impervious, treated or untreated automatically.

## Dependency and result-state model

```text
New source / measured geometry / manual decision
                ↓
Compare with the current governing input
      ↙ retained pin                 ↘ confirmed governing change
Needs review: result remains           Numerically out of date: retain old
matched to recorded inputs;             result/output and offer deliberate review
suitability review remains                     ↓
                    Required basis missing/inconsistent/unsupported
                                  ↓
                           Cannot calculate
```

| Change | Mark for review | What CE must not do |
|---|---|---|
| Source document revision or governing-source change | Values extracted from it, decisions depending on those values | Adopt newest values, delete old evidence or change drawing. |
| Boundary geometry/area change with governing pin retained | Suitability of surface/catchment/DP portions and calculations using the pin: **Needs review** | Rescale allocations, change governing area or recalculate without confirmation. |
| Confirmed governing boundary/area/portion/destination change | Dependent calculation/output: **Numerically out of date** | Replace the old result/output or recalculate silently. |
| Surface class change | Runoff assumptions and calculation input using it | Treat it as a hydraulic connection. |
| Catchment split/join/allocation change | Treatment/destination and all dependent results/outputs | Double count/erase accepted portions. |
| Council/IFD criteria change | Related calculations, report and OSD output | Fall back to an office default without showing it. |
| Pipe/pit/device geometry or capacity change | Provided-storage/physical-check and output drawings | Rewrite designed requirement or accepted manual presentation. |
| Manually pinned value reset | Downstream calculations/outputs that used it | Reveal a source value as governing without a new choice. |

The old calculation/result is retained with its input revision and explicit state/reason. **Needs review** means new evidence conflicts with, or needs suitability review against, retained governing inputs; the result can still match its recorded inputs. **Numerically out of date** means a confirmed governing input changed after the result. **Cannot calculate** names a required missing, inconsistent or unsupported basis. None means the prior result was wrong when calculated.

## Preview, save, cancel and reset

| Action | Drawing | Project/design data | Evidence/override ledger |
|---|---|---|---|
| Inspect / Show source | No change | No change | Read-only. |
| Temporary overlay / preview | Temporary, non-printing; clear on Escape/hide/close/drawing change | No change | May record only user-requested review history, never a governing decision. |
| Save a design decision | No drawing change unless explicitly applying a reviewed drawing effect | Saves governing/manual state | Appends decision/reason/revision. |
| Apply reviewed drawing change | One accepted operation = one Undo | Links applied output to selected revision | Records result/output identity. |
| Cancel / Escape | Restore exact preview start state | Does not promote proposal or alter governing value | No override reset. |
| Reset override | No automatic drawing change | Removes only the named manual/pinned override after confirmation | Retains prior override history and exposes candidates for a new governing choice. |

## Multi-drawing, Xref, missing source and offline behaviour

| Situation | Required user experience | Prohibited behaviour |
|---|---|---|
| Multiple drawings in one project | Identify current drawing and project record; show which evidence/decisions are project-wide versus drawing-specific. Permit deliberate selection of another drawing only. | Merge objects/records merely because labels/proximity look similar. |
| Xref or REFEDIT content | Inspect evidence and identify it as external/read-only. Permit a user to create a local proposal/reference only if the workflow is reviewed. | Unlock, detach, explode, clone around, write Civil identity into or infer live topology from Xref content. |
| Locked layer / foreign object | Explain why editing is unavailable; show safe owner workflow where applicable. | Silently unlock, bypass or create a substitute link to evade protection. |
| Missing moved/deleted source | Show “Source unavailable” with last known identity/page and affected values. Keep existing governing/pinned values intact. | Replace with a similarly named document or clear the source history. |
| Offline / unavailable project folder | Work with already-loaded local evidence and draw normally. Queue no hidden cross-folder mutation; show discovery freshness. | Claim a full search completed or make a fresh governing choice from no evidence. |
| Duplicate/copy found | Show one content identity and every known location. | Treat every copy as a separate requirement. |
| Ambiguous project recognition | Show unresolved state and Select/change documents. | Guess another job or create an empty project record without warning. |

## Revision and audit record — minimum visible facts

Every governable value/change needs: record identity; adoption status; basis/provenance including Assumed/Unknown where applicable; old/new state; source identity/page/revision or manual reason; who/when; confidence/measurement basis where applicable; related project/drawing; dependent result state; and resolution history. The ordinary user sees a compact summary and `Why?`/`History…` when needed; a permanent heavy evidence rail is not required.

## Definition of complete for a future implementation

The implementation is not complete until a synthetic project proves all of these after save/reopen:

1. A newer conflicting document appears and does not overwrite a pinned/guiding value.
2. A report area and a measured boundary coexist until a governing choice.
3. A roof shared by two DPs neither double-counts nor equal-splits automatically.
4. A changed measured boundary with a retained governing pin is **Needs review** while result/output remain matched to their recorded inputs; deliberately adopting the new governing boundary makes consuming result/output **Numerically out of date**. A required missing basis says **Cannot calculate**. In each case the old result/output identity remains readable.
5. Escape clears an area overlay and makes no persistent change.
6. Xref/locked/missing/offline cases state their limits without modifying protected content.
7. Resetting an override retains the historic reason and asks for a new governing choice.

---

## Technical appendix — design constraints

This contract assumes stable Civil identities, separate engineering/presentation records and a source/revision ledger. Bounded source reconciliation already identifies Design Package concepts for inputs, branches/results/details/long section/calculations/warnings/refusals and Design Impact concepts for stable pit/pipe identities, directed connections, presentation and Complete/Partial/Unknown/OutOfDate status. Reuse/adapt those concepts before creating a parallel model. Exact storage/API representation is deliberately unspecified; the behaviour must be implemented once, then shared by CDDESIGN, calculation, Review and output routes. No calculation, report rendering, drawing overlay or AutoCAD lifecycle proof was run for this planning record.
