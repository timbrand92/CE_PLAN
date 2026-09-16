# Whole-job scenario review — proposals for later implementation checks

FOR TIM

The same job should remain understandable at the start, during design and before issue. The checks below describe what the engineer should see. They have not been run in AutoCAD.

| Situation | Expected guidance | What must remain under the engineer's control |
|---|---|---|
| New drawing, no pipes | Identify the job; discover documents; show missing discharge and area information | Select/change documents and confirm governing requirements |
| Drawing outside recognised job folders | Show project context unresolved; keep known drawing work available | Recovery choice is still for Tim to approve; do not assume the enclosing folder is the job |
| Same report in two folders | Show one document with two locations | Neither copy gets higher engineering authority because of its folder |
| New draft report arrives | Compare old and new values with pages, date, revision and draft status | Keep existing confirmed values until reviewed |
| Revised roof allocation belongs to an earlier architectural plan | Explain the plan/report mismatch; show both sources | Confirm current boundaries and destinations before transfer |
| Roof boundary is open | Show an incomplete proposal and offer select/draw/adjust | Never close a gap silently and call the area confirmed |
| PDF area is measurable but material unknown | Show measured area separately from surface classification | Unknown remains Unknown; the remainder does not become pervious |
| One roof feeds two DPs | Show one roof and its two portions, including any unallocated area | No automatic equal split or double counting |
| Area manually pinned, outline later changes | Show measured and pinned values, reason and changed boundary | Refresh preserves the pin; adopting new geometry is explicit |
| Pipe crosses another pipe | Show crossing geometry without inventing connectivity | Confirm connection through established network behaviour |
| Outlet invert is unavailable | Keep discharge evidence and mark relevant calculations incomplete | Do not turn Unknown into RL 0.000 or invent a gravity solution |
| Council supplies a new discharge limit | Show affected calculations, storage/outlet design and outputs | Review requirements separately from applying drawing changes |
| Required input is unavailable | Explain which result cannot be established while other work continues | No fabricated result, no blanket refusal to use unrelated drawing tools |
| A coefficient is disputed in the office rulebook | Show its authority and unresolved status | Do not select an answer from historical averages |
| Change affects a pinned pipe size | Identify the pipe and effect without overwriting it | Engineer may retain with a recorded reason or revise deliberately |
| Schedule text has been edited | Distinguish engineering facts from presentation and manual text | Preserve the approved label-authority rules; surface inconsistencies |
| Previously issued job receives revised architecture | Keep the issued record and compare the current work | Issue history must not be retrospectively rewritten |
| User cancels an evidence review | Return with confirmed values unchanged | Proposed selections and drawing overlays must not become design inputs |
| User accepts a drawing change then uses Undo | Restore the accepted operation together | One accepted drawing operation equals one Undo; document adoption and drawing application remain distinct actions |
| Save and reopen | Show confirmed sources, manual choices and unresolved changes consistently | Actual persistence needs future implementation verification |

## Evidence basis and limits

The approved scoped handover supports the report, geometry, override and lifecycle rows. START_HERE supports identity, native protections, unknown states, label authority and Undo. The private historical trial demonstrates selected report and PDF differences only. Synthetic situations above are acceptance proposals, not additional Tim-approved engineering rules.

The working-copy `DesignImpactModels.cs` already describes persistent pit/pipe identity, directed connections and Complete/Partial/Unknown/OutOfDate states. `DesignPackageModels.cs` holds inputs and multiple result branches including long sections and calculation summaries. Planning should extend sound existing concepts, not assume no dependency mechanism exists.

No source code, native drawing or installed behaviour was exercised. These rows are not passing tests.
