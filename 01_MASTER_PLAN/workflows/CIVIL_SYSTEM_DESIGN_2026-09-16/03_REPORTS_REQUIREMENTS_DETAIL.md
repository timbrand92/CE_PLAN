# CDDESIGN Reports and requirements — proposed detailed behaviour

FOR TIM

CDDESIGN should find the job's documents, show what each requirement comes from, and tell the engineer what needs attention. Reading a report, loading it, confirming a requirement and changing the drawing are separate actions.

Example: a revised roof plan changes an area. CE shows the old report area, the new measured area and the chosen design area together. It preserves the current design until the engineer decides what governs.

## Status and authority

This detail implements the approved planning direction in the scoped 15/16 September handover. The interaction details below remain proposals unless explicitly identified as settled. Automatic ingestion is not built or verified by this planning exercise.

Settled: automatic project identification; select/change loaded documents; document/page/revision evidence; conflict and revision review; explicit confirmation before values affect design; manual override; no main-page scrolling; large relevant preview; no compulsory job-stage wizard.

Unsettled: exceptional project-recognition recovery and whether connected roof/treatment/reuse values are accepted together or individually. Nothing below decides either question.

**Multiple discharge points are already approved.** Consolidated record §B4 quotes Tim on 15 September: "IT CAN HAVE MORE THAN ONE BUT OFTEN JUST ONE". One shared LPD record means one record **per outlet**, used by all relevant windows, not one outlet for the entire project. Show the selected outlet/network scope; each outlet retains its authority and associated catchments/calculations. Do not blend different outlet requirements into one project-wide discharge limit. The same record quotes Tim for a DP: "ITS ALWAYS ONE DESTINATION". A roof may contribute unequal portions to several DPs; an individual DP still has one confirmed destination.

## One visible sequence, available throughout the job

| Engineer action | What CE proposes to do automatically | Result and boundary |
|---|---|---|
| Open CDDESIGN | Recognise drawing/project context and search the recognised job for relevant sources | Show project identity and discovery state. A plausible folder is not proof of the job |
| Select/change documents | Group relevant reports/plans, identify identical copies and possible revisions | Loading selects evidence to inspect. It does not approve any extracted value |
| Select a requirement | Show the proposed meaning, units and source page | Keep original wording beside interpretation; ambiguous wording stays unresolved |
| Compare a revision | Show changed, unchanged, added and removed information | A newer draft does not silently replace an older governing requirement |
| Confirm a governing choice | Record the chosen value/source and affected dependencies | Calculations become eligible for explicit review/recalculation; no drawing change merely from confirming |
| Override | Retain source and measured values beside the engineer's working choice/reason | Refresh does not erase the override; it is not an amendment to the source document |
| Review design | Compare requirements, calculations and the physical provision | Missing or stale evidence remains visible. A favourable report score is not whole-design acceptance |

## Required evidence beside a value

| Evidence | Why the engineer needs it |
|---|---|
| Document identity and available locations | An identical PDF copied into another folder is still the same evidence |
| Document title, internal date, revision and status | Distinguish issued, preliminary, draft and unknown status; folder names are only discovery hints |
| Page and marked source passage/table/plan region | Open the exact evidence without hunting through a whole report |
| Original value and units | Detect m²/ha, L/kL/m³, depth/level and rate/volume confusion |
| Interpreted engineering meaning | Site coverage, roof catchment, floor area and garden area are not interchangeable |
| Scope | Site, dwelling, subcatchment, device, design case or a whole-system total |
| Qualification | Preserve conditions, exclusions, assumptions and the report's own result wording |
| Reading method and limitation | Image-only pages need visual/OCR reading; an empty text layer is not an empty report |
| Current confirmed choice | Show which evidence currently governs and what remains a proposal |
| Override and reason | Keep a deliberate engineering choice distinguishable from imported evidence |
| Affected work | Identify allocations, calculations, drawings and issue checks that need review |

No arbitrary confidence percentage is proposed. Explain whether evidence is clear, ambiguous, incomplete or unverified and why. Reading confidence, document authority, geometric accuracy and hydraulic connectivity are separate matters.

## Source families and interpretation checks

| Source family | Useful proposals | Do not infer |
|---|---|---|
| Council discharge advice | Connection location/type, nominated restrictions, conditions and referenced details | Outlet invert where absent; installed pit dimensions/existence merely because required |
| Council design criteria | Source edition, development/site case, required method and values where stated | A universal coefficient or event from one council/job |
| STORM / ESD / Blue Factor / WSUD | Named catchments, areas, treatment allocation, reuse assumptions, device requirements, reported results/targets | A headline score proves every objective; reuse storage is detention; draft is approved |
| OSD calculation sheet | Input basis, calculated versus nominated/adopted discharge, required storage, events and assumptions | Historical results are current authority or can be adopted without their input basis |
| Architectural / catchment plans | Reported schedules, explicit allocated roof portions, candidate boundaries and revisions | Coverage equals drainage area; an older allocation can be transferred onto changed geometry unchanged |
| Survey / authority asset evidence | Levels, datum, locations and surveyed/existing status where stated | A design level is surveyed; relative depth is an AHD level; a crossing is a connection |

## Revision and exception handling

| Event | Proposed response | Kept unchanged until explicitly reviewed |
|---|---|---|
| Identical content, different filename/location | Group copies and retain locations | Confirmed requirement and its identity |
| Same filename, changed content | Record a new candidate revision even if filename/date appears unchanged | Governing source and design values |
| Internal revision conflicts with folder chronology | Show both facts and flag the discrepancy | Which revision governs |
| New report omits a previously stated value | Mark removal/not stated; do not carry it forward as newly sourced | Existing chosen value, shown with its older source and review warning |
| Loaded document deselected | Explain if current design still cites it; retain the decision/evidence history | Governing values; deselection alone does not delete design history |
| Source unavailable/offline | Show retained confirmed evidence with unavailable-source status | Working design and manual choices; do not fabricate a refresh |
| Report cannot be read or is password protected | Name the affected document/pages and offer manual evidence entry or replacement | Other readable evidence and unrelated drafting work |
| Extraction finds contradictory values in one document | Show both passages and their scopes | Governing choice; do not choose the last match |
| Units or datum are unclear | Show the original text and unresolved interpretation | Any converted/calculated value; Unknown is not zero |
| Project changes while review is open | Suspend that review and identify the drawing/job it belongs to | Other job's evidence and design; no cross-job carry-over |
| User cancels or presses Escape | Discard the unaccepted review draft and temporary overlays | Confirmed document choices, governing values and original reports |

These responses are proposed interface contracts. Their persistence, multi-drawing behaviour and actual cancellation need implementation verification later.

**Review needed is not always numerically out of date.** If a measured roof changes while the governing area remains deliberately pinned, the engineering basis needs review. The calculation may still match its recorded numeric inputs. Recalculate when confirmed inputs change; preserve the distinction between an unreviewed change, a result based on superseded inputs and a calculation that cannot be established. A retained override does not automatically clear the review of its suitability.

## Review without overwhelming the main window

- The overview contains Discharge, Design criteria and Catchments plus the most relevant next action.
- Reports opens a focused review with a short selected-item list beside a large source page. A return action retains the engineer's place in CDDESIGN.
- A detailed record opens only when chosen. The overview does not become an all-fields form or an endless list of report text.
- Main actions remain visible. Longer document lists/pages may use their own deliberate page/list navigation; the main overview does not scroll.
- Any suggested confirmation grouping must still show affected dependencies. The choice of whole connected arrangement versus individual values remains Tim's decision.
- Proposed discovery is cancellable and shows useful progress; do not run a full job scan on each pipe edit or keystroke.

## Evidence used and what this does not prove

The scoped handover contains the approved direction and the bounded historical Blue Factor/area trial outcomes. `01_INTEGRATION_EVIDENCE.md` distinguishes actual source helpers from proposed CDDESIGN behaviour. `02_SCENARIO_REVIEW.md` contains future review cases.

This is a planning contract, not a report parser, a calculation engine, a tested AutoCAD window or a council compliance opinion. No new numerical engineering rule is adopted here.
