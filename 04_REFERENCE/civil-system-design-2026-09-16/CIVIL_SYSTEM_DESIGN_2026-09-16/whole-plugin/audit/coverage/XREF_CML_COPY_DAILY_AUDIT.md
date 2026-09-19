# Xref and CML/copy utility audit — pending corrections

FOR TIM

The Xref proposal must distinguish an applied drawing change from a saved DWG. The CML/copy proposal must keep the familiar native command flow and avoid implying that capped Mline ends require a closed route.

---

| Finding | File | Required correction |
|---|---|---|
| XREFDAILY01 medium | planner/structural_xref_daily_copy_layer_card.md step4 | Do not require save/reopen before an applied operation can be Complete. Separate verified applied components from DWG saved and future native save/reopen qualification. |
| XREFDAILY02 low | same step2 | Paste target is actual active drawing, revalidated before Apply. CDDESIGN Select/change document/evidence override cannot retarget an Xref paste. |
| CMLCOPY01 low | planner/structural_closed_mline_copy_utility_card.md source row | Actual helper sets COPYMODE=1; source name does not prove multiple-copy mode semantics. State exact attempted numeric setting pending authoritative/native qualification. |
| CMLCOPY02 low | same CML steps | CLOSED-ENDS style/caps are distinct from route closure. Caller queues plain MLINE; it supplies no Close keyword. Do not impose a closed polygon. |
| CMLCOPY03 medium, parent concern | same native utility path | Preserve direct native prompts/transient preview/status. A proposed label does not justify a mandatory new Main/More/header/review-pane setup flow for a quick utility. Optional inspection and conditional owned-copy choice can remain. Await actual revision. |

Actual reads: full two cards; NativeCopyPasteXrefService.cs58–207; NativeXrefLayerService.cs24–168; CeTextService.cs1320–1411 and1766–1825; preceding CeTextCommands aliases; canonical ST5-11/12 already read. Copy captures path/insertion/scale/rotation/layer states/Xclip; paste uses AttachXref then insertion and subsequent layer/Xclip calls. Overlay/unit/pick/preview preservation is correctly target, not proven source. XRL target-layer setup precedes batch reference changes, with cancellation checked inside transaction. No runtime execution or internal AutoCAD behavior claim.

Corrections sent to planner. Final visual map audit is separate; its clearance does not close these planning findings or the whole run.

## Final correction readback
Actual Xref row now says activate intended drawing and revalidate, no document override retarget; applied components and saved state separate. Actual CML card is direct native prompts/status with optional inspection, exact COPYMODE=1, CLOSED-ENDS distinct from route closure, and no stale Main/More claim. XREFDAILY01/02 and CMLCOPY01/02/03 closed at this bounded planning level.

