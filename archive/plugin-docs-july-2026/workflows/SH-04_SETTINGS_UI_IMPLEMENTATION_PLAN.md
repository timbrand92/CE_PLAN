# SH-04 — CE Settings UI implementation plan

**Status:** visual direction and staged implementation plan approved for planning; production UI not started

**Depends on:** RS-01C3 completed before the first deployable UI package is built

**Command transition:** `CESETTINGS` becomes the one main command; `CDS` redirects to the relevant Civil page for one Stable release

**Safety:** normal builds always use `-p:SkipDevBundle=true`; deployment remains separately gated by the exact phrase `AutoCAD is closed, deploy.`

## User-visible target

Replace the small, dense `CDS` advanced-settings dialog with one full-size **CE Settings** window designed around the work a drafter is trying to do.

```text
CE Settings
├─ General
├─ Civil
│  ├─ Pipe drawing
│  ├─ Labels & inverts
│  ├─ OSNAP
│  └─ Survey
├─ Structural
├─ Project
├─ Firm standards
├─ Advanced
└─ Admin
```

The main pages use plain drafting language, larger controls, a search box, visible ownership and a preview where a setting changes drawing output. Engineering tolerances, compatibility switches and diagnostics do not appear on ordinary pages.

## Three-tier ownership

| Tier | What staff see | What can change | Where it lives |
|---|---|---|---|
| Personal | “My drafting preference” | Freely editable | User profile |
| Project | “This project uses …” | Preview → Apply → one Undo | With the drawing/project |
| Firm | “Creative Engineering standard” | Read-only for normal staff | CE Rulebook/admin authority |

The UI must show the source beside every project/firm-controlled value. A newer firm rule is shown as available for review; it never silently rewrites an existing project or existing drawing objects.

## Interaction rules

1. Start at a useful everyday page, not an advanced options list.
2. Use a minimum 44 px click target, visible keyboard focus, logical Tab order and text contrast of at least 4.5:1.
3. Put a one-sentence drafting explanation below unfamiliar settings; do not rely on tooltips.
4. Show a small drawing preview for label, pipe, colour and annotation changes.
5. Save only when **Save changes** is selected. Cancel/Escape changes nothing.
6. Reset is scoped to the current page, personal settings or project settings; no global reset.
7. Project changes require Preview → Apply and produce one AutoCAD Undo step.
8. Corrupt settings warn clearly and offer the recoverable backup.
9. Import/export excludes secrets, AI keys and client paths.
10. Dark and light themes must preserve the same information and behaviour across AutoCAD 2022–2027. Newer
    runtimes may use richer controls and visual effects under the three-tier plan in
    `SH-04_WPF_SURFACE_REVIEW_PLAN.md`.

## Incremental build order

| Increment | Deliverable | Gate |
|---|---|---|
| **RS-01C3** | Enrol the trusted release-authority public key and safely mint the signed package evidence. Private key remains outside Git and deployable packages. | Required before any deployable UI package is built. |
| **SH-04A** | Shared CE design tokens/components, runtime-tier presentation adapters, `CESETTINGS` shell, search/navigation, Personal/Project/Firm ownership display, `CDS` redirect. | Automated navigation/save/cancel/accessibility checks in net48/net8/net10; no settings behaviour migration yet. |
| **SH-04B** | Migrate the existing Civil pages: Pipe drawing, Labels & inverts, OSNAP and Survey. Preserve current stored values and command behaviour. | Behaviour parity tests plus one consolidated AutoCAD visual check. |
| **SH-04C** | Project and firm tiers, rulebook version/provenance, preview/apply/undo and scoped reset/import/export. | Fail-closed ownership, corrupt-config and no-silent-retroactive-change tests. |
| **SH-04D** | Review and migrate the remaining WPF windows in related workflow batches. | Each workflow card approved before material UI/command change. |

The old working window remains available internally until its replacement passes automated checks and Tim's representative AutoCAD acceptance. This is not a big-bang rewrite.

## Third-party decision

CE should **rebuild useful patterns into one CE experience**, not ship a collection of unrelated plugins.

| Candidate | Decision | Why it helps / ruling |
|---|---|---|
| CommunityToolkit.Mvvm 8.4.2 | **Keep; adopt gradually** | Already present. Reduces repetitive WPF view-model plumbing while leaving CE's UI and behaviour in our control. Pilot one page at a time. |
| ACadSharp | **Keep pinned; isolated upgrade trials** | Already supports headless DWG inspection/generation and automated drawing evidence without AutoCAD. High value for the external test program. |
| NetTopologySuite + MathNet.Numerics | **Keep** | Already present and suited to tested geometry and engineering calculations. They do not dictate the UI. |
| Serilog | **Keep, consolidate under PD-01** | Structured diagnostics are valuable, but version/binding compatibility with AutoCAD must be proven before consolidation. No UI-stage version change. |
| ScottPlot.WPF | **Isolated CDPROFILE trial later** | Could provide proper pan/zoom profile plotting. Its SkiaSharp/OpenTK dependency footprint must first pass AutoCAD load, memory and multi-target tests. |
| Linq2Acad | **Prototype only; not core** | May shorten transaction/query code, but its older AutoCAD-version-specific packaging and abstraction risk make it unsuitable for broad adoption without a measured trial. |
| WPF UI | **Approved isolated trial for net8/net10** | Use selected navigation, InfoBar, NumberBox and progress controls if AutoCAD load/theme/keyboard/shutdown checks pass. Keep it out of net48 and keep behaviour in shared view models. |
| Autodesk .NET Wizards | **Reference only** | Useful official project/manifest examples; not a runtime feature. |
| CADPythonShell | **Object-inspector ideas only** | Inspector patterns could help diagnostics. Do not ship an unrestricted scripting shell. |
| TotalLength-style tools | **Rebuild selected value natively** | A reviewed native CE total-length workflow could help drafting without adding another ribbon/plugin owner. |
| AutoCADCodePack / archived netDxf | **Reject as runtime dependencies** | Too old or duplicates the existing DWG library, increasing command/load/version risk. |
| Commercial App Store plugins | **Do not copy code or artwork** | We may study documented workflows and build our own reviewed implementation only. |

## Acceptance target

- 90% of settings behaviour is proven automatically.
- One representative AutoCAD acceptance takes no more than 10 minutes.
- The deployable candidate is signed, staged, restart-required and rollback-preserving through RS-01.
- `DATA-01` remains blocked and is not widened by this UI work.
