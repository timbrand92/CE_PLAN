# Civil system journey and window map

**Planning-only map.** This is a proposed whole-Civil ownership and journey map for Tim review. It must reuse retained working routes and data concepts where present, rather than inventing a second owner, second record or second window. Water Tank is intentionally last.

## The job at a glance

```text
Open base drawing
   ↓
CDDESIGN — documents, discharge, requirements and areas
   ↓                         ↘
Survey/import + surface evidence  Drainage Items / pipes / pits / grades
   ↓                         ↙
Confirmed project record ──► calculations / detention / treatment review
   ↓
Drawing outputs — profiles, schedules, details, notes
   ↓
Project Review — revise, compare, resolve, issue
   ↓
Repair / settings / assets / help support every step
```

No box above is a compulsory stage. A user can keep drafting while a separate input is unresolved; the overview says what to do next and what that uncertainty affects.

## One record, clear ownership

| Information | Owns the working value | May show it | Must not silently replace it |
|---|---|---|---|
| Project identity and loaded documents | Project/design record | CDDESIGN, Review, Import | Folder search, file name or “newer” copy. |
| Discharge / LPD | Design record with source evidence | CDDESIGN, Drainage Items (opens same information), calculations, issue review | An item window or a calculation result. |
| Council/design criteria and IFD data | Settings/project criteria record | CDDESIGN, calculation review, issue review | Report extraction or a default curve. |
| Site extent / surface / hydraulic catchment | Three linked but distinct project records | CDDESIGN, area tools, Drainage Items DP allocation, calculations | Each other or a generic remainder. |
| Physical pits, pipes, drainage items and grades | Drawing/Civil object record; plan label content is reconciled as authority where the established rule applies | Editing, profile, schedule, review | Document evidence or a proximity inference. |
| Calculation inputs and results | Calculation record | CDDESIGN, CDCALC, issue review | An older sheet or an unreconciled display string. Where a plan label is the authority, its edit must be parsed/reconciled into the engineering record or shown as a conflict — never overwritten to suit the record. |
| Drawing presentation | Drawing presentation record | Editors, schedule/profile/detail output | Engineering value. |
| Override/revision evidence | Override/revision ledger beside the governed value | Everywhere that shows the value | Refresh, recalc, save/reopen or import. |

## Journey map and doors

| Job moment | What the engineer sees/does | Main doorway | Handoff / door | Result that stays visible |
|---|---|---|---|---|
| 1. Open / take over a job | Open CDDESIGN. It finds the likely project and relevant documents across its folders; any ambiguity is plainly unresolved. | `CDDESIGN` | **Select / change documents** only when needed. | Which documents are loaded, duplicates, dates/status and unresolved project recognition. |
| 2. Read requirements | Select a document row; source page fills the large preview. Review council/ESD/STORM/Blue Factor/OSD items as proposals. | `CDDESIGN` | **Confirm governing values** or retain as unresolved. | Source/page/revision and proposed-versus-governing value. |
| 3. Set discharge | Review LPD location/type/level/note evidence before physical connection is available. | `CDDESIGN` / `CDLPD` | **Open/locate LPD**; Drainage Items only links to the same LPD record. | Not set is allowed; what it blocks/warns is clear. |
| 4. Bring in survey/context | Review survey, base geometry, existing/proposed levels and consultant information without changing protected content. | `CDIMPORT` / survey workflow | **Inspect / choose import update / draw manually**. | Source, date, coordinate/level confidence, locked/Xref read-only state. |
| 5. Establish areas | See existing catchment-plan evidence first, then proposed outlines or measured/report values. | `CDDESIGN` area review | **Accept, adjust, select existing outline, draw, enter manual area**. | Site boundary, surface class and hydraulic catchment kept as separate rows. |
| 6. Draft the system | Place/edit pits, pipes, drainage items, slab/site-grade and surface-drain geometry through their established commands. | Existing Civil commands/editors | **Open item/edit/connection view** from plan or overview. | Actual drawing preview, identities, connections and local warnings. |
| 7. Allocate and treat runoff | Link confirmed catchment portions to DPs/treatments; inspect raingardens, soakage, pumps or detention as applicable. | CDDESIGN + Drainage Items + specialised workflows | **Open treatment/device workflow**; no link is inferred from crossing/proximity. | Allocated, unallocated and intentionally excluded areas. |
| 8. Calculate | Use confirmed criteria, catchments and physical storage. Compare requirements, calculated results and drawn/provided capacity. | CDCALC from CDDESIGN | **Open calculation detail / resolve stale input / apply reviewed output**. | Calculation version, stale warning, critical conditions and source provenance. |
| 9. Produce drawings | Generate/review profiles, schedules, standard details, notes, plan criteria and construction output from their source records. | Profile/schedule/detail workflows | **Preview / insert/update / review output**. | What is derived, what is manually presented and what needs review. |
| 10. Revise and issue | Compare changed documents/boundaries/drawing objects; resolve conflicts and issue readiness. | Project Review | **Review affected items / regenerate / issue check**. | Revision comparison, unresolved risks, issue evidence. |
| 11. Recover/support | Inspect legacy state, assets/settings and help; scan first, then explicitly choose repairs. | CDREPAIR / Settings / Help | **Read-only scan / repair preview / support guidance**. | What can be repaired, what is protected and what needs a human decision. |

## Window family map

| Family | Primary window/route | Main page purpose | Preview | Main actions | More / secondary route |
|---|---|---|---|---|---|
| Project/design | CDDESIGN | Job overview plus Discharge, Design criteria, Catchments | Document page for evidence; actual drawing for area/network work | Confirm, review, calculate, open related item | Select/change documents, revision comparison. |
| Survey/import | CDIMPORT / survey | Bring external/context information in safely | Source/reference drawing and change list | Inspect, map, accept update, reject | Source options, import log. |
| Drainage Items | One item window preselected by existing command | Engineering left, drafting right, large plan preview below | Actual plan/item location | Place/save, cancel | Less-used item controls. |
| Network editing | Pipe/Pit/CDEDIT and native grips | Change real network object safely | Actual plan/selected object | Save and close, preview where safe, cancel | Connections, presentation, diagnostics. |
| Surface drains / slab / grades | Existing specialised workflows | Draw/edit physical drainage and civil surfaces | Actual plan geometry | Draw, edit, preview, cancel | Standards/options. |
| Calculations / detention | CDCALC + specialised detention/TWL/orifice workflow | Confirm inputs, calculate and compare provided capacity | Relevant drawing/storage evidence | Calculate, review, generate reviewed outputs | Calculation basis, historic comparison. |
| Treatment / pumps / soakage | Specialised device workflow | Set physically selected device and its proven dependencies | Actual plan/device | Place/edit/verify | Device-specific settings. |
| Outputs | Profile, schedule, detail and notes workflows | Generate/check the drawing representation | Actual output preview | Insert/update/export reviewed output | Output scope and presentation. |
| Review / issue | Project Review | One place for outstanding changes and issue readiness | Actual plan + source/revision evidence | Jump, resolve, regenerate, issue review | Filters, history. |
| Settings / repair / help | Settings, CDREPAIR, CDHELP | Standards, safe recovery and plain-English support | Read-only report/diagnostic as relevant | Inspect, preview repair, apply approved repair | Logs/assets/support detail. |
| Water Tank — last | CDWT | Tank selection/engineering/drawing route after other families | Actual plan and physical/treatment context | Selected by its separate owner | Do not duplicate it in this map. |

## Doors that prevent duplicate work

| From | To | Door rule |
|---|---|---|
| CDDESIGN LPD row | CDLPD / LPD detail | Both show one LPD record. Drainage Items never creates a competing LPD. |
| CDDESIGN catchment row | Existing catchment plan / draw/select/manual | First recognise plan evidence; confirmation creates/updates one catchment record. |
| DP item | Catchment allocation | DP references a confirmed contributing portion. It cannot own the full roof merely because it is connected. |
| Physical drawing object | Calculation | Calculation consumes reconciled engineering/drawing values and records the input revision. An authoritative plan-label change is reconciled into its record first; an unreconciled display string is not silently used. |
| Calculation | sheet/criteria/detail | One computed result is selected for derived output; a user reviews affected outputs before issue. |
| Review row | drawing object/source page | Selection highlights/zooms the actual thing, and closing the review does not alter it. |
| Repair | any Civil record | Scan first; repairs require a preview and cannot bypass locked/Xref/foreign protections. |

## Required shared interaction rules

- **Cancel/Escape:** remove temporary overlay/preview and return the drawing/state to its starting point; no source, working value or document selection changes merely because the user inspected them.
- **Save/Apply:** one accepted operation becomes one AutoCAD Undo step. Saving a window never means engineering or issue approval.
- **Save/reopen:** loaded-document identity, source page, governing decision, pinned override, stale flag and drawing-link identity remain readable after reopen.
- **Plan label authority:** where a plan label carries the authoritative value, CE reads/reconciles that label and makes the record follow it. A display-only override stays presentation-only; it must never be used to erase or disguise a label/record disagreement.
- **Performance:** discovery, extraction and broad scans are deliberate/background review work with visible progress; normal pipe/pit edits use local reassessment only.
- **Discovery:** keep the everyday route visible; commands, context actions and selected plan objects open the matching existing family. Do not make users hunt through a new navigation shell.
- **Access:** locked/Xref/REFEDIT/foreign items can be inspected but state plainly why changing them is unavailable. No automatic unlock, detach, explode, clone-around or surrogate link.

---

## Technical appendix — status

This map is a proposed architecture for workflow-card review. It deliberately uses **Unknown** for unverified command status outside the named records. It does not claim any map family is Built, Tested, Installed or Tim-accepted.
