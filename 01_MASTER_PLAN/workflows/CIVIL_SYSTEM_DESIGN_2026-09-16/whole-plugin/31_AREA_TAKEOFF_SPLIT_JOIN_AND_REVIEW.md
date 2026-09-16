# Area take-off, split/join and governing-value review

FOR TIM

CE should find the existing catchment plan first, show its outlines against the drawing, and let us select, adjust or draw them. Splitting a roof must not silently divide its flow between DPs.

## Authority and scope

Interaction proposal expands approved source-first/manual-control intent in parent planner/workflow_cards B2 and automation_override_revision_contract sections Area and catchment rules and change propagation. Read with root23 and the DP removal/reconnection companion. Existing CDDESIGN/Drainage Items/CD/PIT owners remain unchanged. No implementation, private-project scan, AutoCAD action or engineering-default adoption. All areas below are fictional comparison data, not design criteria.

Site extent, surface classification and hydraulic catchment remain separate records, even where they refer to the same outline. Automatic recognition proposes candidates; only confirmed values govern. This record does not change the already agreed beginning/during/end-of-job CDDESIGN workflow or create a compulsory step-by-step wizard.

## 1. First take-off from the actual job

Open CDDESIGN Catchments in the automatically recognised project. Show existing confirmed catchments and known source catchment plans before suggesting new geometry. Large preview alternates drawing overlay and selected source page; visible actions are Select outline, Draw boundary, Adjust, Enter area and Review changes. These are proposed labels, not new approval requirements for settled manual options.

| Review state | What the engineer sees and can do |
|---|---|
| Confirmed project outline already present | Identity, source and governing area. Select/edit it instead of creating a duplicate from rediscovery |
| Detected outline from current drawing | Candidate geometry, measured area and units, evidence identity. Accept, adjust or reject; no governing value merely because recognition succeeded |
| Report has area but no usable outline | Report value/page/revision alongside Unknown geometry. Enter/confirm a governing number if appropriate; do not draw invented geometry to match it |
| Xref/foreign outline | Read-only evidence. No unlock, detach, explode or clone-around. Use the owner's approved reference-selection route or explicitly draw a separate boundary; eligibility of a referenced boundary must be qualified, not assumed writable |
| Open, self-crossing, ambiguous or unmeasurable outline | Specific unresolved geometry and Unknown measured area; repair through an approved explicit action or draw/select another. Never a zero or guessed closure |
| Units or scale uncertain | Show uncertainty before adopting measured area. No heuristic unit conversion presented as confirmed |

A manually drawn outline is a proposed local boundary until the accepted drawing action. Escape clears the pending overlay. Existing accepted geometry is not undone by closing a later review. The approved accepted boundary change has its qualified single-drawing Undo behaviour; manual numeric entry alone never reshapes the outline.

## 2. Compare values without merging them

Example row: report620m², measured600m², manually entered610m². Display all three with source/revision or manual reason. Show the last confirmed governing value separately from the pending choice. The engineer can use a reviewed source, use measured area or retain/enter the manual value. Do not average values, prefer the largest, or adopt the newest report automatically.

Where only a report or measured outline changes and the governing pin is retained, mark suitability Needs review. Existing results remain identified with their recorded inputs. Once a different governing area is confirmed, dependent calculations/outputs become Numerically out of date; preserve the old result until deliberate recalculation. Missing required basis means Cannot calculate, not zero flow.

An area acceptance cannot simultaneously imply impervious classification, runoff coefficient, treatment allocation or destination. These are separately visible attributes with their own authority. Example: a1200m² site with600m² classified roof leaves600m² Unclassified; it does not establish600m² pervious garden.

## 3. Split a boundary without guessing allocation

Fictional confirmed roof R01:600m² governing area, DP01 assigned240m² and DP02 assigned360m². These unequal portions are recorded decisions. The drafter proposes a geometric split into candidate outlines R01-A350m² and R01-B250m².

The split preview shows original outline/identity, both proposed geometries, measured total, governing total, existing DP portions, surface classes and every downstream reference. A geometric split alone does not establish that DP01 drains A or that DP02 drains B; the old assigned portions may have no geometric partition.

| Choice/stage | Result |
|---|---|
| Inspect split preview / Cancel | Last confirmed outline/area/allocations remain; temporary proposed lines clear |
| Accept drawing split only under an explicit retained-governing mode | Local geometry changes with a recorded relationship to R01; governing R01 area/portions remain the prior basis and are flagged for suitability review. Do not present the child geometry as two newly governing catchments |
| Review replacing R01 with two governing catchments | Show proposed child identities/areas and each existing DP portion as unresolved until deliberately assigned or retained through an explicit reviewed relationship |
| Confirm replacement and reviewed allocations | Show old-to-new identity mapping, exact assigned portions and any unassigned remainder. Superseded R01 is retained in history and cannot also count as an active contributing area |
| Geometry accepted but allocation confirmation cancelled | Keep the accepted geometry and prior governing basis visibly separate. Cancel does not undo the earlier drawing operation or adopt new child contributions |

The geometry-only acceptance mode is a proposal requiring owner review, not asserted existing functionality. If the implemented split requires an atomic governing replacement, it must resolve the full reviewed dependency set before acceptance; it must not silently approximate the above behaviour.

No equal redistribution, proportional rescaling, nearest-DP choice or tolerance is introduced. A confirmed unassigned remainder stays visible and is not sent to a destination. Whether enough basis exists for a particular calculation follows that calculation's required inputs; this record invents no blanket permission to calculate through unresolved allocations.

## 4. Join and overlap review

Joining two outlines shows both original identities, proposed geometry, surface-class differences and all allocation references. Different classes do not become one generic class. The engineer retains subareas/classification or reviews an explicit new classification; otherwise the affected class stays unresolved. Existing DP portions remain visible and are reconciled, not blindly added where they represent the same contributing area.

Coincident candidate geometry from a revised report is not a second catchment merely because it has a new file name. Compare evidence identity and intent; offer review against the existing record or a genuinely separate proposed record. No automatic deduplication by similar shape alone.

Overlap review names its purpose: site extent versus roof surface is expected cross-purpose overlap and is not summable as two site areas. Overlap between contributing portions for the same runoff calculation requires explicit resolution or an intentional-overlap explanation consistent with the calculation's counting method. A reason alone does not make double-counted flow mathematically valid. Do not silently clip either boundary or adopt the union as engineering truth.

A join's old identities remain traceable for evidence/results/history. New active geometry must not cause superseded records to contribute again. A manual area may differ from geometric union; retain both values and require a governing choice rather than forcing equality.

## 5. Changed source, drawing switch and recovery

Before accepting a boundary, classification or allocation change, recheck drawing/job, original identities, geometry and source basis. If any material value changed while review was open, invalidate affected acceptance and display old/current/pending comparison. Keep typed manual choices for review; no late extraction or drawing switch can retarget them to another job.

For a compound change distinguish proposed geometry, accepted drawing geometry, confirmed governing record and dependent output state. Partial/unknown persistence needs readback before retry. Never redraw a possibly created boundary or duplicate allocations because the response was lost. Save/reopen must show actual durable geometry and confirmed basis; a completion message is not proof both persisted.

## Proposed representative review

1. Reopen a project with an existing catchment plan: it appears before new candidates; no duplicate600m² catchment.
2. Compare620/600/610m² evidence without adopting any value on open; retain the manual pin and inspect Needs review.
3. Draw a replacement boundary, cancel its preview, then deliberately accept it: only the accepted action changes drawing geometry.
4. Split600m² into350/250m²: original240/360m² DP decisions remain visible; no automatic remapping or redistribution.
5. Cancel allocation review after accepted geometry: prior governing basis remains explicitly identifiable and unresolved suitability is visible.
6. Join unlike surface classes and inspect a duplicate source outline: no silent class merge, duplicate runoff or fabricated pervious remainder.
7. Change source or switch drawing during review, then reopen: no stale acceptance, cross-job adoption or duplicate retry.

These scenarios are future owner/AutoCAD acceptance requirements. This planning record does not prove area recognition, geometric validity, drawing persistence or calculation correctness.
