# MLINE alias and point-label route — separate drawing actions

FOR TIM

The earlier inventory incorrectly described ML as a member-label route. The inspected source sends ML to AutoCAD MLINE. The separate LABEL / CE_MEMBERLABEL route places manually entered annotation; picking a point does not link it to a beam or schedule.

## Evidence and limits

Read the complete named `Modules/Structural/Commands/SchedulingCommands.cs` in the root checkout. ML at93–99 queues `_.MLINE`; CE_MEMBERLABEL/LABEL at18–19 invokes MemberLabel. This is source evidence, not installed alias resolution, completed MLINE execution or AutoCAD testing. The initial guessed ST-07 filename was absent; the actual canonical record is ST-07_SCHEDULES_SHEETS_EXCEL.md. Its schedule authority does not turn every command in a scheduling-named file into a schedule tool.

The planner registry disposition is being corrected independently. ST-03 native annotation/manual-position principles and ST-07 semantic schedule authority remain distinct. No new ribbon exposure, retirement, linked-label redesign or replacement native workflow is approved here.

## Actual point-label sequence in the inspected file

| Step | Source-observed action | Meaning and limitation |
|---|---|---|
| Start LABEL / CE_MEMBERLABEL | Pick or Help prompt | Help returns from this route. No schedule selection is performed. |
| Pick element point | GetPoint accepts coordinates | No entity selection, stable member identity or engineering link is established by this point in the inspected method. |
| Enter label text | Free text with spaces; empty/non-OK returns | Text is trimmed and upper-cased. It is manually supplied wording, not a verified member designation or calculation result. |
| Pick landing | Second point is requested | The inspected method has no complete moving-label preview. Do not describe the source as already having the approved preview experience. |
| Choose None / Box / Circle | Cancel returns; default None | Explicit retained graphic choices. Exact approved asset/appearance review still applies. |
| Create geometry | Two lines, DBText and optional polyline box/circle in current space | Helper comment says MText, actual construction is DBText. No arrowhead or compound member ownership is established by this helper. |
| Finish | Commit then message | Current in-memory drawing result is distinct from saved/reopened output; no runtime proof is claimed. |

The method converts the picked points through its WCS helper, uses2.5 × DIMSCALE for text height and ensures25DIMS/25TEXT before entering the label Undo scope/transaction. These are source observations, not adopted plotted-scale values or proof of UCS/Undo safety. Layer creation can precede a later geometry failure; therefore a blanket failure-leaves-nothing claim is unproved. Cancellation at the ordinary prompts occurs before those layer calls in this method.

## Proposed ordinary-use contract for later owner review

Keep native/direct drawing access. A drafter requesting a manual point callout should see the complete intended annotation before its confirming placement, retain explicit text/landing/surround choices and normal manual-position control. Do not add a schedule/member-selection prerequisite to this manual route merely because of its filename.

A genuinely linked member label is a different reviewed intent: it requires the actual member and its governing relationship through the existing beam/text owner. This record does not invent automatic conversion between a manual point callout and that linked object. Moving or editing manual text does not rewrite a beam, approve an engineering designation or update a schedule.

ML preserves its observed native-Mline alias meaning pending central-register qualification. Dispatching the native command is not proof of completion, clean cancellation, current alias precedence or geometry output. No alternative MLINE implementation is proposed.

## Future representative checks

Use a synthetic drawing to establish actual ML alias resolution and ordinary native output separately from LABEL. For LABEL, check each Cancel boundary, None/Box/Circle, current space, rotated UCS, approved plotting scale, protected/local-layer handling, one qualified Undo and save/reopen. Inspect actual text type/geometry and confirm no member/schedule link was invented. Check failure after layer preparation separately from prompt cancellation. These checks were not run.

No source edit, build, installed-state claim, AutoCAD action or client scan occurred. This corrects a bounded planning classification error and preserves owner review before product changes.

[Independent bounded source/planning audit](audit/coverage/ML_ALIAS_POINT_LABEL_AUDIT.md) passed. The separate planner registry correction is recorded in the later shared-prerequisite audit readback; neither receipt proves native alias resolution.
