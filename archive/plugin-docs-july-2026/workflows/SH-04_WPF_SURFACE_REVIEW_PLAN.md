# SH-04 — WPF surface review and runtime tiers

**Planning:** runtime strategy approved by Tim on 2026-07-23; individual surface visuals remain review-gated

**Implementation:** not started

## Scope found

The monorepo currently contains **73 top-level WPF windows/palettes** requiring review:

| Module | Top-level surfaces |
|---|---:|
| Civil | 24 |
| Manager | 2 |
| Structural | 47 |

Theme dictionaries and reusable controls are excluded from that count. They become the shared CE design system
rather than separate user workflows.

## One product, three presentation tiers

The experience may look progressively richer on newer AutoCAD versions, but it must never develop different
engineering behaviour.

| AutoCAD | Runtime | Presentation target | Allowed difference |
|---|---|---|---|
| 2022–2024 | .NET Framework 4.8 | **CE Legacy** — native WPF using CE styles/components | Simpler visual effects; same information, controls, validation and keyboard path |
| 2025–2026 | .NET 8 | **CE Modern** — trial WPF UI controls plus CE colours/components | Modern navigation, InfoBar, NumberBox and progress controls after compatibility proof |
| 2027 | .NET 10 | **CE Fluent** — .NET 10 WPF/Fluent capabilities plus approved WPF UI controls | Fluent light/dark handling, smoother rendering and .NET 10 performance/accessibility improvements |

The shared view models, validation, commands, settings storage and AutoCAD operations compile once per behaviour.
Only resource dictionaries, control templates and explicitly approved presentation adapters may differ.

## Third-party adoption

| Library | Use |
|---|---|
| CommunityToolkit.Mvvm 8.4.2 | Adopt gradually for shared view models across all three runtime tiers. |
| WPF UI 4.3.x | Add only to .NET 8/.NET 10 after an isolated AutoCAD load/theme/keyboard/shutdown trial. Keep it out of net48. Record MIT attribution. |
| Built-in .NET 10 WPF Fluent theme | Trial in the 2027 presentation tier. Do not mix competing global theme dictionaries; prove window-scoped integration first. |
| ScottPlot.WPF | Trial only with `CDPROFILE`; it is not a general UI dependency. |
| ACadSharp | Continue headless DWG/test use; it does not run the UI. |
| NetTopologySuite / MathNet | Continue geometry/calculation use behind tested services. |
| Serilog | Keep pinned and consolidate only under PD-01 because AutoCAD 2027 supplies its own Serilog assembly. |

## Visual review rule for every WPF surface

Before a window is materially redesigned:

1. show Tim the current window or a faithful current-state sketch;
2. show the proposed CE design using the same visual language as the approved CE Settings concept;
3. label every value as Personal, Project or Firm where ownership matters;
4. review normal use, validation, Cancel/Escape, Apply, Undo, resize, keyboard and high-DPI behaviour;
5. show any intentional Legacy / Modern / Fluent visual difference;
6. record Tim's approval before implementation;
7. keep the old working surface until the replacement passes automated checks and one representative AutoCAD test.

## Review batches

| Batch | Surfaces | Purpose |
|---|---|---|
| UI-01 | Ribbon + CE Settings + OSNAP | Establish navigation, controls, spacing, themes and runtime-tier rules |
| UI-02 | Civil Pipe/Pit/Create/Edit windows | Everyday Civil drafting path |
| UI-03 | Civil schedules, calculations, dashboard, profile, repair and import/export | Review and output workflows; includes ScottPlot trial decision |
| UI-04 | Structural project setup, properties, beams, reinforcement and annotation | Everyday Structural drafting path |
| UI-05 | Structural sheets, notes, markups, reports, timers and palettes | Production/documentation workflows |
| UI-06 | Manager, Health, Support, About/version, Help, admin, alerts and progress windows | One suite-wide product shell and support experience |

Small confirmation/progress dialogs reuse an approved pattern rather than receiving unrelated bespoke designs.

## Gates before UI-01 implementation

- Tim approves the ribbon visual review.
- WPF UI and .NET 10 Fluent are proven in isolated non-deployed spikes across open/close, dark/light, keyboard,
  DPI, AutoCAD shutdown and assembly-load checks.
- No dependency introduces a second command owner or a different engineering code path.
- RS-01C3 signs the future candidate; deployment still requires `AutoCAD is closed, deploy.`
- `DATA-01` remains blocked.
