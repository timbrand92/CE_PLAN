# CV-05 — Slab and site layout

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** partial — missing-level authority increment implemented; full constrained surface/editor work remains
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-43`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# CV-05 — Slab and site layout

### Current AutoCAD state

| Tool | Current position | Treatment |
|---|---|---|
| `CDSLAB` | Strong calculation tests; drawing workflow mostly developed | **Keep engine, rebuild workflow/compound** |
| `CDSLABIMPORT` | Can adopt existing slabs | **Modify—currently substitutes missing RLs with zero** |
| `CDSLABEDIT` | Timothy-confirmed crash history | **Hide; rebuild before exposure** |
| `CDSPOON` | Draws boundary and hatch | **Modify—store permanent slab ownership** |
| `CDJOINT` | Grid mechanics tested | **Blocked—the engineering rules are unapproved** |
| `CDCJ / CDSC` | Manual joint drafting works | **Keep and strengthen** |
| `CDSRZ / CDTPZ` | Draw basic circles/hatch | **Rebuild as real site constraints** |

Critical findings:

- Imported slab vertices can receive `FSL = 0.000` when no level exists.
- Current automatic joint spacings—3000/3500/4000/4500 mm—have no confirmed engineering authority.
- The slab minimum-fall values are tested, but their standards authority is not recorded.
- Nearby pit levels can be inferred using distance rather than confirmed ownership.
- SRZ/TPZ are currently visual circles with no stored tree or report information.

## CV5-1–CV5-15 recommendations

| ID | Recommended decision | AutoCAD example |
|---|---|---|
| CV5-1 | Include slab create/import/edit/regenerate, spoon drains, joints and SRZ/TPZ in this card. | No orphan site-layout tools. |
| CV5-2 | Keep familiar command names. Hide `CDSLABEDIT` until its replacement passes automated AutoCAD testing. | Staff cannot launch the known crash path. |
| CV5-3 | A slab becomes one compound: boundary, levels, TIN, hatch, falls, spoons, joints and drainage nodes. | Moving the slab does not strand its arrows. |
| CV5-4 | `CDSLAB` offers three clear modes: draw new, use existing boundary or adopt existing drawing. | Import is no longer a separate mystery workflow. |
| CV5-5 | Missing FSLs are **Unknown**, never `0.000`. No fall result is produced without enough known control points. | An imported slab cannot appear to sit at sea level. |
| CV5-6 | Every level records its source: survey, selected pit, existing spot level or manual entry. Nearby pits are suggestions requiring confirmation. | A pit 1.4 m away cannot silently supply the wrong CL. |
| CV5-7 | TIN triangles must remain inside the slab boundary and respect spoon drains and nominated breaklines. | No fall arrow crosses a concave corner or spoon drain. |
| CV5-8 | Current minimum falls remain advisory until their rulebook authority is approved. Unknown authority cannot produce a compliance Pass. | “Proposed 1:100” rather than “AS-compliant.” |
| CV5-9 | Preview the TIN, low points, ponding risks, arrows and warnings before Apply. Apply once; Undo once. | Timothy sees the drainage result before anything is committed. |
| CV5-10 | A spoon drain becomes a permanently linked slab child—not rediscovered later merely because it sits inside the boundary. | Moving a spoon cannot attach it to another slab. |
| CV5-11 | Slab editing uses a controlled editor for boundary and level changes, followed by a complete preview regeneration. | Changing one FSL updates all affected arrows together. |
| CV5-12 | Keep manual `CDCJ` and `CDSC`. `CDJOINT` stays hidden or preview-only until joint design rules are approved. | A drafter may place a specified CJ; CE cannot invent a joint plan. |
| CV5-13 | Treat current automatic spacing and pit-clearance numbers as unapproved proposals. Preserve proven mechanics: start from a real corner, clip flush to boundary and keep labels readable. | Geometry can be trusted without claiming the spacing is correct. |
| CV5-14 | SRZ/TPZ become stored site constraints with tree ID, entered radius, information source and revision. CE does not calculate radii without an approved method. | “Tree T4 — TPZ 6.2 m from arborist report Rev B.” |
| CV5-15 | Automated evidence covers Unknown levels, concave slabs, islands, imports, cancel/Undo, copied compounds and large boundaries. Timothy reviews one representative slab preview only—about five minutes. | No historical slab checklist replay. |

**Recommendation:** approve CV-05 as presented. The slab calculation core is retained, but false levels, unsafe editing and unauthorised joint design are blocked.

No files changed, builds run or deployment performed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-44

✅ Approve CV-05 as presented
The slab calculation core stays; the false levels, the crash path, the unauthorised joint design, and the fragile inference all get blocked. Consistent with everything before it — and one theme is now unmistakable.

🔁 Proximity-matching is the disease of site-layout — and this card cures it three times
The same root cause shows up in three tools here, and CV-05 replaces it with stored identity every time:

CV5-3 — slab as one compound (boundary/TIN/falls/spoons/joints), not a loose pile that strands its arrows when moved
CV5-6 — a pit 1.4 m away is a suggestion requiring confirmation, not a silent level source
CV5-10 — a spoon is a permanently linked child, not "rediscovered because it sits inside the boundary"
Inferring relationships by distance is fragile (move something, the associations swap); storing them by identity (CT2) is the fix. This is the same move as CV4-11 — it's now clearly the systemic pattern for the site tools.

🛡️ The two problem tools are handled exactly right
CV5-2 — hide CDSLABEDIT until its rebuild passes. It has a confirmed crash-on-every-path history. Don't leave a known landmine where staff can step on it — remove it from reach, rebuild, then expose. Correct safety call (F6/CT9).
CV5-12/13 — CDJOINT stays preview-only until the joint rules are approved. Keeping manual CDCJ/CDSC (a drafter places a joint they specify) while blocking auto-invented joint plans is the right line: CE never invents engineering from unapproved rules. And CV5-13's split — trust the mechanics (start from a real corner, clip flush, readable labels) but mark the 3000/3500/4000/4500 spacing as unapproved proposals — is the clean "the tool works, the numbers aren't authorised yet" separation.
🚨 CV5-5 — the dangerous-false-level fix, again
"Imported FSL = 0.000 → appears to sit at sea level" is the same ~45 m false value as CDTG's 0.000 AHD and the zero-capacity tank. Unknown, never zero. And "no fall result without enough known control points" correctly refuses to build a surface from insufficient data. This principle has now earned its place in five cards — good.

🧭 Two domain nods
CV5-7 (constrained TIN) is real surface-modelling correctness: an unconstrained triangulation spans concave corners and ignores spoon drains, producing fall arrows that cross a channel they should drain into. Respecting boundary + breaklines is the right fix — good that it's specified, not assumed.
CV5-14 (TPZ/SRZ stored with source, not computed). Storing "TPZ 6.2 m — arborist report Rev B" is correct: the arborist is the authority for a specific tree. (If you ever want an advisory calc, AS 4970 gives TPZ ≈ 12 × trunk diameter — but as Designed/advisory, never overriding the arborist's Fixed value. Storing the report figure with provenance is the right primary behaviour.)
🔒 Locked, nothing starts
Engine kept, crash path hidden, joint auto-design gated, false levels blocked, ownership made explicit. Ready for the next card.

## Missing-level authority increment — 9 September 2026

Slab control points now retain a nullable `fslKnown` authority flag in the
drawing record. An explicitly known finite value is usable, including a genuine
`0.000`. An explicit false flag is Unknown. For an older record with no flag, a
finite non-zero value remains usable, while `0.000` is Unknown because the old
importer used the same number for both a real zero and a missing level. CE does
not bulk-upgrade old drawings or guess which legacy zero was intended; the
engineer must supply the missing authority through the approved slab workflow.

The existing point set, point order and triangulation engine are retained. A
fall surface, low point, outlet result or fall-symbol regeneration is admitted
only with at least three control points and a known finite FSL on every point.
Unknown points are not silently removed to make another surface. A refused
regeneration leaves existing fall symbols and the stored slab record unchanged.

`CDSLABIMPORT` now records unmatched boundary levels as Unknown instead of a
false sea-level FSL. Parsed spot, survey, confirmed pit and manual values record
known authority. Manual blank, malformed and non-finite input is requested again;
an intentional entered `0.000` remains valid. The repair audit reports Unknown
and skips minimum-fall and outlet-level comparisons when level authority is
incomplete. Copied slabs and frozen read snapshots preserve the authority flag.

This increment does not select a governing hydraulic level for an outlet,
constrain the TIN to concave boundaries/breaklines, expose the held slab editor,
or redesign slab geometry. Those remain separate CV-05 work.

`CDSLABEREGEN` also refuses before drawing or record writes when the current
boundary is no longer the exact closed, straight-segment vertex sequence owned
by the stored control points. The current record has no safe authority for
assigning old FSLs after vertices are added, removed, reordered, curved or
moved; it therefore preserves the original point set and existing fall symbols
until the approved slab editor owns that remapping. Civil Properties likewise
shows the nearest-outlet readout as Unknown when the complete slab level set is
not authoritative, so an old missing-level `0.000` cannot become the apparent
low point. A proved intentional `0.000` remains valid.

Fall-symbol regeneration is now an atomic replacement of the existing CE-owned
symbols and the authoritative slab record. CE reloads the drawing record, prepares
the complete triangulation and fall placements, and rechecks the known levels and
exact boundary before opening anything for write. It refuses unchanged while
REFEDIT is active, when the boundary or any recorded fall child is missing,
foreign, on a locked layer or no longer the expected object, or when the existing
`FALL SYMBOL` block definition and `25CONT` layer are unavailable or protected.
This regeneration path deliberately does not create those resources: an existing
slab is expected to have them, and resource creation through the current separate
transactions cannot be included in the same all-or-nothing replacement. Once all
checks pass, new symbols, removal of the old symbols and the NOD slab record are
committed in one transaction; the live project cache is adopted only afterwards.
Native AutoCAD Undo and protected-object acceptance remain pending.

Level provenance now distinguishes an existing spot level from manual entry while
preserving the established persisted values for Manual, Survey and Pit. A parsed
spot-level block and a boundary vertex that the existing importer already marks
known from a spot level record `ExistingSpotLevel`; unmatched vertices remain
explicitly Unknown. The importer's existing nearest-spot inheritance within
500 mm is unchanged by this provenance correction and remains unapproved
engineering semantics rather than a newly endorsed relationship rule.

For a manually picked control point, Survey or Pit is retained only when the
finite submitted value accepts or numerically matches the three-decimal suggestion
shown in the command line. Entering a different value records Manual. This does
not change the suggestion distance, level value, control-point geometry or the
existing spot-block stacking output, and it does not retrospectively rewrite old
slab records. The held slab editor still requires its separate authority-aware
integration before exposure.

## Held detached editor increment — 9 September 2026

The existing, currently uncalled slab dialog now keeps an immutable detached
baseline instead of editing the live project record. Untouched control points
preserve their exact nullable `fslKnown` value and source, including a proved
real `0.000`; changing a finite FSL records a known Manual value, and reverting
exactly restores the original authority and source. Blank, malformed and
non-finite editor input cannot be applied. Preview refresh is read-only and the
same complete level and fall-plan gates used by regeneration suppress both fall
rows and the nearby-pit suggestion when any participating level is Unknown.
The existing proximity check is labelled suggestion-only and creates no stored
relationship or governing outlet choice.

Apply reloads the authoritative NOD record and compares its complete canonical
fingerprint with the editor baseline. It refuses stale data or any staged change
outside slab name, surface type and existing control-point FSLs. The shared
atomic regeneration owner prepares and protects all replacement fall geometry,
writes the geometry and slab record in one transaction, and returns a detached
cache snapshot only after commit. Preview, Cancel and Escape perform no drawing,
NOD or cache writes; the old competing dialog writer has been removed.

This increment remains held. `CDSLABEDIT` still follows its established
grip/STRETCH route and the dialog is not wired to the command or newly exposed.
Controlled boundary editing and the full constrained TIN, breakline, ponding
and outlet preview required by CV5-7/CV5-9/CV5-11 remain separate work before
the replacement can pass native acceptance and replace that working path.

The held dialog is also bound to the exact Document and Database on which it was
opened. Its passive outlet suggestion receives a detached snapshot from the
already-loaded project cache; opening, refreshing or cancelling the dialog cannot
initialize, migrate or save project data. Apply refuses if another drawing is
active, even when that drawing happens to contain the same slab handle and record
fingerprint. Cache adoption likewise rechecks the opening drawing and uses a
detached prepared project snapshot without reading or mutating the global
`Current` object. This closes a review gap in the held increment; command exposure
and native multi-document acceptance remain pending.

## Held graphical preview increment — 9 September 2026

The held Falls page now draws the stored-order slab boundary, every control level,
the current TIN lines calculated from those stored/edited values, calculated fall
arrows and local low controls before Apply.
The drawing is a presentation-only projection of the same immutable
SlabFallRegenerationPlan geometry used by atomic regeneration; the ViewModel no
longer performs a second triangulation or fall calculation. A proved real 0.000
is labelled 0.000. Any Unknown participating level remains visibly Unknown and
suppresses all derived TIN, arrow and low-control output without removing the point
or changing the stored boundary.

The readout explicitly identifies the **stored boundary + edited levels** as its
inputs and labels the result **Current unconstrained TIN computed from these
values**. It does not claim that the live DWG boundary is current; that parity is
checked only on Apply. The current calculation does not yet meet CV5-7 for concave
boundaries, spoon drains or nominated breaklines. A highlighted point means only
“local low control in the current unconstrained TIN”; it is not a hydraulic
ponding conclusion. Ponding is shown as Unavailable because no approved
calculation currently combines the constrained surface, breaklines and confirmed
outlet routing.

The plan-to-card projection uses finite half-span calculations, so even opposite
finite coordinate extremes cannot overflow its scale or canvas coordinates.
Degenerate extents centre safely. If a viewport or stored coordinate cannot be
projected to finite output, the held page shows graphical preview Unavailable and
does not draw unsafe geometry. This projection remains AutoCAD-free and changes no
drawing object, project data or command route; CDSLABEDIT remains hidden.
Controlled boundary editing and full CV5-7/CV5-9 native acceptance remain future
work.

## Constrained surface increment — 10 September 2026

The held editor, fall regeneration and held flow overlay now share one exact
constrained surface plan. It clips faces to the registered concave boundary,
keeps permanently linked spoon rings clear and respects explicitly stored
breakline handles. Every constraint vertex needs an exact known control FSL;
missing, changed or unsupported evidence is Unknown rather than inferred.
Only confirmed stored outlets participate, and Apply recaptures their exact
current geometry with all surface evidence in the existing single transaction.
No command exposure or automatic joint decision is included. Full behavior,
checks and the final native acceptance are recorded in
`docs/workflows/C5_B1_CONSTRAINED_SLAB_SURFACE_2026-09-10.md`.

## Held nomination editor completion — 10 September 2026

The same held dialog stages explicit existing-DWG breakline and named outlet
nominations through AutoCAD's normal window-to-drawing picker. Pick/Remove is
detached and zero-write; Apply recaptures exact selected identities and geometry.
Only ordinary world-plan `+Z` polylines are supported, preventing OCS coordinates
from being mistaken for WCS plan geometry. Boundary vertex remapping remains
refused and the replacement command route remains held.

## Held controlled boundary editor increment — 10 September 2026

The held slab editor now treats the drawn perimeter as a named boundary ring over stable slab control-point identities. Reordering or moving a vertex changes that exact point, not whichever old point happens to be closest or in the same list position. Interior control points are retained in the slab record outside the boundary ring.

Any present point/ring identity must be complete, unique and internally consistent. CE refuses blank, duplicate, partly populated or missing-reference identities instead of renaming points or dropping ring rows. Only a fully legacy record with no identities may receive provisional IDs, after the live closed boundary maps exactly and uniquely to its stored control points; the held editor does not persist that upgrade until Apply.

New boundary vertices begin with Unknown FSL. Moving an existing vertex also makes its level Unknown until the engineer explicitly confirms it as Manual, including a matching value or 0.000. Boundary edits are refused when legacy unclassified/source spot-level labels are still linked to the slab. Only exact, confirmed CE-owned spot labels may move/update with their point. When an owned output label moves with its point, the spot block, `LEVEL` text anchor and any active justification anchor are written at world Z=0.

Legacy label promotion is an explicit engineer action in the held editor: select the exact handle, link it to the exact point and classify it as CE-owned output, then review the proposed link before Apply. Distance, list position and matching level text never make that decision. Unclassified and Source Evidence labels remain protected.

Apply keeps the boundary polyline replacement, owned spot-label updates, fall-symbol replacement and NOD slab record in the existing single transaction. Elevated or curved existing picked boundaries retain their public `CDSLAB` creation as legacy records without held-editor authority, projected rings, flattened geometry or guessed levels. The public `CDSLABEDIT` command is still not cut over; Tim must continue using the existing grip/STRETCH path until this held route passes representative AutoCAD testing. Full review and acceptance checklist: `docs/workflows/C5_B2_CONTROLLED_SLAB_BOUNDARY_EDITOR_2026-09-10.md`.
