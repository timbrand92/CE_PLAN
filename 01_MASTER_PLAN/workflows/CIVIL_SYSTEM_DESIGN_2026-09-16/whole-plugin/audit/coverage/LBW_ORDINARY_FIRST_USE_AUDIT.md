# LBW ordinary first-use audit

FOR TIM: The draft needs to distinguish picking points from changing an Xref, and show that the current command writes into model space. No drawing was changed.

---

Planning/source read only. Actual reads: full planner structural_load_bearing_wall_daily_card.md; named LoadBearingWallCommands.cs33–249 and251–431; canonical ST-02 lines1–95. No assets, client files, helper internals or native execution inspected.

| ID | Severity | Exact issue | Required correction |
|---|---|---|---|
| LBW01 | Medium | Proposed step1 refuses Xref/protected selection despite source50/60 GetPoint and251–431 read-only Xref evidence. This conflates reference picking with modification. | Allow legitimate reference/snapping under native protections; forbid modifying protected/foreign content. Do not claim preflight implementation. |
| LBW02 | Medium | Proposed active layout/view entry omits explicit source130 ModelSpace writer. | Expose actual current output space; propose a qualified model-space route or reviewed coordinate/output-space boundary, not current-layout output. |
| LBW03 | Medium | Failure row describes Pending/Absent without explicitly distinguishing dynamic-property failure from missing asset. Source145/155 false results do not gate Commit179 or ForceQuickSave182. | Preserve/read back any committed marker; Complete cannot follow unmet required property. Distinguish partial/unknown geometry from proven absence before retry. |

Additional source precision: CMDECHO=0 at48 precedes both prompts; finally191 restores captured variables and193 ends Undo. Current layer work100–108 precedes asset check110. Block import may occur separately; insertion transaction commits before ForceQuickSave call. Actual save, Undo, helper outcomes and native coordinates remain untested. Wall-layer/proximity evidence does not prove load-bearing intent; ST-02 does not approve an LBW engineering rule. Proposed explicit bearing and approved-asset gates correctly remain unaccepted planning.

Working pack delta: actual MORNING_PACK26 retains inside/outside examples and hidden unapproved lap rule, explicitly bounded/non-exhaustive; its structural choice link exists. W0 owner presentation row in choice review12 is correct; host approval gate27 remains. Final08:00 handover still outstanding.

## Correction readback — 2026-09-17T03:40:44.2720492+10:00
Actual full revised card read. LBW01–03 closed at planning level: legitimate reference snapping distinguished from prohibited foreign-content edits; explicit current ModelSpace writer plus Proposed qualified initial route; early CMDECHO/finally exact; missing asset distinct from false property result that still permits committed geometry. Readback and no-duplicate retry required, full preview/final match remains future evidence. No native behavior accepted or tested.

## Shared pick clarification — 2026-09-17T03:41:43.1243560+10:00
Actual root32 new29–39 read. No material correction: qualified read-only snapping/evidence distinguished from edit/adopt/transform eligibility; source identity retained, no unlock/clone/proximity authority, local output-space checks separate. Explicit CV7 no-manual-alignment rule and command-context qualification prevent a blanket new picking permission. Planning wording only; no native claim.
