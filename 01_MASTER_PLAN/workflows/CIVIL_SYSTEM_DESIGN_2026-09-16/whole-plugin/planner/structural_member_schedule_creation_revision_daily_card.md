# Structural member schedule creation and revision daily card

**Planning checkpoint:** 2026-09-17T01:43:29.4671512+10:00. This card deepens approved [ST-07 Schedules, calculations, Excel and publishing](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md>) ST7-1–11. It covers a normal schedule creation and a later member/source revision. It does not calculate a member, choose an engineering value, publish a sheet, or claim a current schedule route is safe or built.

> **Read with:** [W8 interaction cards](structural_w7_w11_interaction_cards.md), [XCLMTXT writer/recovery supplement](structural_mts_xcl_writer_recovery_supplement.md), [workflow card W8](structural_workflow_cards.md), [approved-card reconciliation](structural_approved_card_reconciliation.md), and [ST-07](<C:/Lisp Files/CE_ACAD_PLUGIN/docs/CARDS/ST-07_SCHEDULES_SHEETS_EXCEL.md>). Current source observations: [STRSCHEDCREATE / refresh / sync](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Commands/UtilityCommands.cs:62>), [current separate table writer](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ScheduleService.cs:30>) and [current selected-table refresh](<C:/Lisp Files/CE_ACAD_PLUGIN/Modules/Structural/Services/ScheduleService.cs:101>). The target controls below are **Proposed** except for the approved ST-07 rules.

## Entry and source-member scope

| Daily entry | Current source fact / approved direction | Proposed visible result |
|---|---|---|
| XCLMTXT / EXCELMTEXT | ST7-2 retains direct spreadsheet intake; ST7-9 requires source → worksheet/profile → rows/Unknowns → schedule sections → actual preview → Apply → one Undo. Existing writer/recovery terms remain in their companion. | **Main: Import schedule evidence** shows source identity/revision, worksheet/profile, selected rows, stored floor identities, Candidate status and exceptions. A workbook is evidence, not schedule or engineering authority by itself. |
| STRSCHEDCREATE | Current source scans drawing data after the command begins, asks one insertion point and creates separate Bracing and Bored-pier tables with type-specific maps/writers. Several rendered sections or views can still come from the approved one semantic authority; the source does **not** establish unified row identity, provenance, revision/approval or shared authority across those type-specific outputs. | **Main: Create schedule** first names the candidate source-member scope: selected local member identities and/or reviewed imported rows, each with drawing/layout/view/level, source/revision and inclusion state. If the proposed scope cannot be identified, it is Unknown and creation cannot quietly scan or combine an entire job. |
| Existing schedule table | Current STRSCHEDREFRESH requests one Table and then refreshes according to its stored map; current STRSCHEDSYNC is a source route that writes selected-table values back into drawing objects. | **More: Existing schedule** shows stable schedule-view identity, selected row/member links, last reviewed source/revision, manual row/presentation overrides and output placement. It separates a normal one-way refresh from a requested engineering change plan. |

## First creation — review before placement

| Step | What the drafter selects or checks | Proposed output and boundary |
|---|---|---|
| **1. Name the scope** | Select local member(s), reviewed imported row(s), or an explicit existing schedule view for review. Header shows each member/row stable identity, drawing/layout/view/level, schedule/calc/source revision, floor identity and current inclusion. | Same mark on another floor is a separate row/candidate. Mezzanine and Second stay distinct unless an explicit project mapping is selected. No inferred floor, nearest member or cross-job learned answer fills an Unknown. |
| **2. Reconcile values and provenance** | Preview each candidate row with member/drawing value, schedule value if already present, calculation/workbook source, cell/named-result where recorded, revision/hash/import time, approval/status and Manual/Assumed/Unknown state. | A disagreement displays both values as a conflict. The schedule is a coordinated view, not a calculator, and it never silently selects a winning value. Private source paths do not become schedule or support-log content. |
| **3. Choose schedule sections and placement** | Main shows requested section(s), native-table/approved-AS-01 output intent, row count, existing schedule views that would be affected, insertion location, drawing/layout/view/level and all Manual row/presentation exceptions. | **Preview actual schedule** shows selected scope and exact before/after drawing output. It cannot create an independent bracing/pier/foundation/Excel authority or an issue output; it may render multiple named sections/views from the one semantic model. Unknown source/floor/row links remain visibly excluded or Needs review rather than becoming a blank default. |
| **4. Apply one schedule view** | Explicit Apply names included rows/sections, placement identity and one intended Undo scope. | The approved target creates one semantic schedule model with stable row identity, element links, values, source, revision, approval and staleness; it may render one or more native approved schedule sections/views. The current source's type-specific maps/writers are observation only, not proof of that unified result. |

## Later member or source revision

| Trigger | Main comparison and actions | Scope safeguard |
|---|---|---|
| A selected member's linked calculation/workbook revision changes | Select the member or schedule row. Show **Before / Current / Pending** for drawing, schedule, calculation/workbook source, detail link and each Manual/pinned row or presentation override. | A changed calculation/source makes the affected schedule/detail **Needs review**; it does not redraw a member, revise a schedule or change a Manual override automatically. Unrelated rows/floors stay unchanged. |
| A drafter edits a schedule cell that would alter engineering | Main states that the requested edit affects linked engineering and shows exact linked element(s), current source evidence and downstream drawing/detail impact. Actions: **Preview change plan**, **Keep schedule view**, **Mark Needs review**, or **Cancel**. | It must never call the legacy direct STRSCHEDSYNC behavior as a side effect of cell typing. A pending change is not a calculation result or a confirmed drawing revision. |
| A drafter moves/formats a schedule view or has a manual row/presentation change | Show presentation/move scope separately from row engineering source. Keep current row identity/provenance in the schedule. | MOVE affects view placement only. A Manual presentation edit does not make a calculation numerically stale, overwrite an imported value or trigger member changes. |
| User asks to refresh | **More: Refresh selected schedule** lists only the selected schedule-view identity and its consumed authoritative elements/calculations, source revisions, conflict rows and Manual exceptions. Preview row-level result before Apply. | Refresh normally goes authoritative elements/calculations → schedule. It does not broaden to other schedule views, issue sheets or unrelated drawing members. |

## Copy, erase, cancellation, receipt and reopen

| Event | Proposed truthful outcome |
|---|---|
| **COPY schedule view** | Ask whether this is a project-specific snapshot or a deliberately requested another linked view. Create a fresh view identity and show source/row relation. No copy silently creates a second schedule authority or duplicates member data. |
| **ERASE schedule view** | Remove only the selected rendered view after scope confirmation. The semantic schedule rows, members, calculations and other views remain intact. |
| **Cancel/Escape before Apply** | Leaves source draft, selected member scope, existing schedule view and drawing unchanged. The draft/review state is distinct from drawing Undo. |
| **Partial placement or refresh** | Separate schedule graphics, row/link receipt, provenance/snapshot state and any changed view identity. Use Complete/Partial/Absent/Unknown per selected section/row. Inspect/read back before retry; retry requires verified absence or a qualified safe-resume boundary and never repeats Complete schedule views. |
| **Save/reopen** | Future proof must read schedule-view identity/placement, row identities, linked elements, source revision/provenance, Manual exceptions, conflict/stale state and copy type separately. Visible table text alone is not proof. |

## Fictitious daily drawing example

On a synthetic two-level structural plan, the drafter starts **Create schedule** and selects one local Level 1 member plus two reviewed imported candidates. One candidate has an Unknown floor and is excluded visibly; a matching mark on Level 2 is a distinct candidate. The preview shows the selected member rows, source revisions, one retained Manual note and an intended native schedule view at the chosen drawing location. Apply creates the planned one schedule view; it does not issue a sheet or alter any member.

Later, the selected Level 1 member has a newer source revision. Opening that row shows drawing/schedule/source values and the linked detail side by side. A user types a value into the schedule row: the screen offers **Preview change plan** or **Cancel**, rather than changing the member. They choose Keep schedule view and leave the row Needs review. They move the schedule view for clearer drawing layout; this retained presentation change does not alter the member or its calculation state. A COPY creates a snapshot, then the original view is erased; the selected member evidence remains available.

## Future representative acceptance

In AutoCAD, use a synthetic two-level member set and small reviewed workbook fixture to inspect: explicit member/row scope; distinct floors and Unknown exclusion; provenance/conflict display; actual schedule preview before placement; one semantic native schedule view; selected-source revision comparison; engineering-cell change plan rather than direct sync; Manual row/presentation retention; selected refresh; MOVE/COPY/ERASE boundaries; Cancel; partial receipt/retry protection; and save/reopen evidence. Inspect the real table and linked member before claiming Tested or Tim-accepted.

**Built:** not assessed. **Tested:** no runtime or AutoCAD test. **Installed:** not assessed. **Tim-accepted:** not assessed. No source edit, build, AutoCAD/process execution, deployment, issue action, provider/corpus access or client-project scan occurred.

