# SH-01 — CE ribbon visual review

**Planning:** approved by Tim on 2026-07-23

**Implementation:** SH-01R1 Civil and SH-01R2 Structural/Tools increments complete in source

**AutoCAD verification:** not started

## Tim's approved visual decisions

1. The final product has three tabs: `CE Civil`, `CE Structural` and `CE Tools`; the separate `CE Suites` tab retires.
2. Panel order, large everyday buttons and task-labelled flyouts follow the reviewed mock-up.
3. `CE Settings` and `Help` sit beside `Ask CE` on both discipline tabs.
4. `Move + Rotate` and `Copy + Rotate` belong quietly under `CE Tools`, without prominent placement or discipline-tab duplication.

## Locked foundation

The existing approved ribbon architecture remains:

- one installed CE product;
- `CE Civil`, `CE Structural` and `CE Tools` tabs;
- entitlement hides an entire discipline tab, not individual unexplained buttons;
- panels follow normal job order from left to right;
- everyday tools are large and the long tail is kept in labelled flyouts;
- `Ask CE` is available on both discipline tabs;
- the same command names, engineering behaviour and safety rules apply in AutoCAD 2022–2027.

## Implementation result

The modern AutoCAD ribbon source now matches the approved visual shape:

| Implemented source | Approved target |
|---|---|
| `CE Suites` builder removed after Tools command-coverage proof | Only `CE Civil`, `CE Structural`, `CE Tools` |
| Large, compact and labelled-flyout presentation is shared | Everyday actions are large; specialist actions live in flyouts |
| Civil panels follow the approved drafting sequence | Import / Draw / Levels & Falls / Edit & Link / Output / CE |
| Structural panels follow the approved drafting sequence | Beams / Columns & Footings / Rebar & Bracing / Annotate / Schedules / CE |
| Registry long tail is grouped into meaningful labelled flyouts | No numbered overflow panels |
| Overall and per-contributor failures are traced and isolated | Ribbon failure is visible to diagnostics without crashing AutoCAD |

The visual review gate passed on 2026-07-23.

## Proposed visual rules

1. Keep AutoCAD's host ribbon appearance; CE should look native, not like a separate application pasted on top.
2. Use one consistent CE icon family with a clear silhouette at 16 px and 32 px.
3. Large buttons represent the everyday drafting path. A flyout label describes the task, not “More”.
4. Put panels in job order, not alphabetical order.
5. Show the plain-English label first. The command name belongs in the tooltip and Help search.
6. Put `CE Settings` and `Help` beside `Ask CE` on both discipline tabs.
7. Keep `CE Health`, Support, version, update and rollback status on `CE Tools`.
8. Tooltips state what the command will ask for and what it changes in the drawing.
9. Missing permission, unavailable module or disabled feature is explained; it is not a dead button.
10. The ribbon layout remains materially consistent across all supported AutoCAD releases. Runtime-specific visual improvements belong mainly inside CE's WPF windows.

## SH-01R1 implementation boundary

- The shared modern ribbon description now supports large, compact and labelled-flyout items.
- `CE Civil` now follows Import / Draw / Levels & Falls / Edit & Link / Output / CE job order.
- Nine everyday Civil actions are large: Import Survey, Pipe, Pit, Spot Level, Fall, Edit, Pit Schedule,
  Calculations and Ask CE.
- Every visible Civil registry command plus the approved Ask CE entry appears exactly once.
- CE Settings and Help are compact beside Ask CE. Transform commands do not appear on the Civil tab.
- The AutoCAD 2022–2024 CUIX path remains unchanged. AutoCAD 2025–2027 use the shared modern presentation.
- `CE Suites` stays temporarily until the rebuilt `CE Tools` tab contains every update/admin command. Removing it
  earlier would hide working tools. It retires in the Tools increment after automated and AutoCAD checks.

## SH-01R2 implementation boundary

- `CE Structural` now follows Beams / Columns & Footings / Rebar & Bracing / Annotate / Schedules / CE.
- Eleven everyday destinations are large: Beam, RC Beam, Column, Footing, Rebar Line, Rebar Circle, Level Mark,
  Section Mark, Excel to Schedule, Sheets and Ask CE.
- Every visible Structural registry entry is mapped once. `CE_VERSION` and the four MR/CR names are deliberately
  removed from the discipline tab because their single visible home is `CE Tools`.
- `CE Tools` now contains every Manager registry command plus Version, compact Move + Rotate and compact
  Copy + Rotate. Manager, Health and Updates & Rollback are the three large status actions.
- The redundant `CE Suites` source is retired only after the Tools definition's exact command-coverage test.
- AutoCAD 2025–2027 use this modern presentation. The existing AutoCAD 2022–2024 CUIX path remains unchanged
  until the separate aligned-CUIX increment is reviewed and verified.
- No command implementation, drawing behaviour, transform ownership or entitlement behaviour changed.

## SH-01R2 AutoCAD acceptance

1. Start AutoCAD and confirm the CE tabs are `CE Civil`, `CE Structural`, `CE Tools`; no `CE Suites` tab remains.
2. Confirm the Structural panels and large buttons match the approved order above.
3. Open one labelled flyout in each Structural panel and confirm the labels are readable and commands launch.
4. On `CE Tools`, open Manager, Health, Updates & Rollback and Version.
5. Confirm Move + Rotate and Copy + Rotate are compact under Shared Drafting and absent from both discipline tabs.
6. Run `CEMANAGERREFRESH`; confirm the three tabs rebuild once without duplicates or missing panels.
