# Representative acceptance scenarios — Civil system

**Purpose:** A small, readable AutoCAD test batch for each family after it is built. These are future acceptance scenarios, not evidence that any workflow works today. Use a synthetic drawing/job only; do not put customer data in a test fixture.

## How to run a batch

1. Start from the named synthetic drawing/job state.
2. Follow one scenario exactly and look at the real window, drawing and any generated artefact.
3. Mark the result separately: **Built / automated checks / installed / Tim-accepted**. A green source test cannot tick the last box.
4. Stop a batch when a prerequisite fails. Record what was seen, without guessing the rest.

## A. Project and requirements

| ID | Start state | Do this in AutoCAD | Right result on the job |
|---|---|---|---|
| A-01 | Synthetic job folder has Civil, Architectural and Survey subfolders; one duplicate report and two different dated reports; base drawing has a candidate path but no confirmed project. | Open CDDESIGN. | It searches the relevant job folders, groups the duplicate, shows both dated reports and says the project/document choice is unresolved where evidence conflicts. It does not treat the current directory or newest file as confirmation. |
| A-02 | One report has selectable text; one is image-only. | Select each document in CDDESIGN. | A large preview shows the relevant page for both. The image-only report is not described as empty merely because a text reader finds no text. |
| A-03 | Two council sources propose different value; one manual/pinned working choice exists. | Refresh discovery and compare sources. | Both sources remain visible. The pinned value and its reason remain. CDDESIGN marks it for review but changes no calculation/drawing value. |
| A-04 | Job has no IFD block. | Open Design criteria, then Calculate. | It clearly says the job curve is Not set/needs confirmation; it never quietly applies Melbourne. Pasting a deliberately supplied block records its location and source. |
| A-05 | LPD has no invert. | Place/review the LPD through CDDESIGN/CDLPD. | The actual plan note has no false IL/zero. Entering an approved level produces the ordinary MLeader note at two decimals. Undo removes only the accepted placement. |

## B. Areas and physical drawing

| ID | Start state | Do this in AutoCAD | Right result on the job |
|---|---|---|---|
| B-01 | Existing roof catchment plan plus separate roof/driveway/garden outlines. | Open Catchments. | CE shows the existing catchment plan before asking to redraw; site extent, surface class and hydraulic catchment are clearly separate review rows. |
| B-02 | One confirmed 200 m² roof and two DPs. | Allocate 120 m² to DP1 and 80 m² to DP2. | Catchment total remains 200 m²; both portions reconcile and neither DP claims the full roof. There is no automatic equal split. |
| B-03 | Report says 200 m² and selected outline measures 212 m². | Inspect then choose manual 205 m² governing value. | All three values and their sources remain visible. The manual value has a reason and does not reshape the selected outline or rewrite report evidence. |
| B-04 | One closed outline is on locked layer; one relevant surface is in an Xref; another line crosses a pipe. | Try to select/allocate each. | Locked/Xref content is inspectable/read-only. CE does not unlock/detach/explode/clone. The crossing does not become a hydraulic connection. Escape removes any temporary shading. |
| B-05 | Branch endpoint touches a main; second branch crosses the main; third is slightly short. | Run CDCHECK or edit locally. | Exact touch connects, crossing stays unconnected and short endpoint is Possible Connection with a small choice. No broad whole-drawing scan interrupts normal editing. |
| B-06 | Pipe through pits with a branch and labels; pit needs resize. | Resize pit, edit an invert, then Undo and reopen. | Connected end geometry/labels are reviewed against actual drawing; accepted edit is one Undo; reopen preserves stable links and manual/presentation distinctions. |

## C. Calculations, treatment and storage

| ID | Start state | Do this in AutoCAD | Right result on the job |
|---|---|---|---|
| C-01 | Confirmed criteria/catchments plus physical storage. | Open CDCALC from CDDESIGN and calculate. | Inputs state their source/governing status. Result records its input revision; requirements, calculated result and drawn/provided capacity are separate. |
| C-02 | Detention has pipe-obvert and higher trench-grate candidate; floor level also visible. | Open TWL review and enter a documented value. | Candidates can be inspected, a typed documented level is allowed with reason, and floor level is only a separate freeboard check — never the source of TWL. |
| C-03 | Result is selected; then a catchment boundary changes. | Return to CDDESIGN/Review. | Old result/output remains readable but says why it is stale. CE does not overwrite the plan/sheet or silently recalculate. |
| C-04 | Treatment proposal has roof → raingarden/tank → reuse relationship. | Inspect and confirm according to Tim’s later decision. | Dependencies are visible; no physical pipe link is invented from geometry. A changed source does not create a mixed-version arrangement without warning. |
| C-05 | Calculation output is ready from a selected result. | Preview computations sheet, OSD criteria block and applicable detail. | Each shows a real rendered preview with CE layout, source/result identity and coherent figures. The PDF is opened visually; it is not accepted from plain-text assertions. |

## D. Outputs, review, recovery and support

| ID | Start state | Do this in AutoCAD | Right result on the job |
|---|---|---|---|
| D-01 | Network has profile, schedule and detail outputs linked to calculation/design state. | Change a pipe/area, then open Project Review. | Review lists only affected items, jumps/highlights the real plan item/source page, and marks affected outputs for deliberate regeneration. Merely inspecting does not alter the drawing. |
| D-02 | One accepted manual wording/position override is on a plan output. | Regenerate after a valid engineering change. | Engineering change updates its derived figures; the presentation override remains as presentation or is clearly offered for review, never silently lost. |
| D-03 | Legacy Civil object issue plus an Xref issue. | Run CDREPAIR scan, preview and accept one permitted repair. | Scan is read-only; Xref remains protected; only selected permitted repair changes and it becomes one Undo. Reopen shows repair history. |
| D-04 | Project folder is temporarily unavailable. | Open CDDESIGN/Review while offline. | Existing loaded evidence and drawing remain usable; source says unavailable/freshness unknown; CE does not claim a new full discovery or substitute a similar file. |
| D-05 | User cannot edit a protected object. | Follow Help/why-not-edit route. | Plain English explains the real limitation and the next safe action. No error route requires source-code knowledge. |

## E. Water Tank — last

No new CDWT scenario is defined in this planner. The temporary window ownership is Claude-only and its active task/cards must supply the later scenario. Any future tank scenario must separately verify retention, detention contribution and physical provided volume; it must not fold those quantities together.

---

## Technical appendix — scenario controls

Each scenario needs explicit fixtures for: source identity/page/revision; drawing identity; locked/Xref state; known/Unknown/manual/pinned/display state; and expected Save/Cancel/Undo/reopen outcome. Automated checks can prove deterministic calculations and persisted state, but Tim must view the real windows/drawing/PDF to accept a workflow.
