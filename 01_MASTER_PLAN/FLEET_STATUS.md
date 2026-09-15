# Fleet release status

## NEEDS TIM — preserve installed Structural before coordinated shared-engine release

15 September 2026. PERF-001/PERF-002/SHARED-001 at96073d6d are mandatory before the next Civil/Structural release. Remote claude/cddebug-autocad-lag-31b690 currently resolves toa482892a; the difference from96073d6d is a single handoff document, not code. No deployment authorized or performed.

Read-only merge preview against codex/civil-edit-connections-20260915 confirms exactly seven conflicts: CouncilProfileModels.cs, CuiMenuGeneratorService.cs, SettingsService.cs, REGRESSION_LOG.md, CLEAN_SLATE_REBUILD.md, SPINE_INTERFACE_v1.md, V3_0_PLAN.md. No working files were merged or conflict resolutions applied in this check.

**Blocking step: selecting a complete preservation base for the mandated same-commit Civil and Structural payload.** Installed Structural5d723d41 is not an ancestor of96073d6d or the Civil edit candidate. Both candidates lack Modules/Structural/Commands/SbeamCommandRunner.cs and SbeamEditCommandRunner.cs. The current Civil candidate also differs from installed Structural in additional hatch/support/beam/architectural commands. Shipping it as Structural would discard installed work, despite a clean build.

Required owner integration: reconcile installed Structural5d723d41 (and approved narrow UI preservation60c41228) with Civil10ac480d plus the Civil edit candidate, preserve all live command behavior, then merge/qualify PERF/SHARED source on that common candidate. Do not use master as a deployment baseline. Codex must not invent or replace Claude-owned command behavior to resolve that preservation conflict.

Civil and Structural must be built and installed in the same coordinated round from that qualified common commit. Verify each payload includes the required CE_SHARED.dll; Manager consumes shared models and must also build against that source. Do not claim load compatibility from compilation alone. Supplied historical test totals are not current acceptance thresholds: measured Civil af7172e5 baseline has285 failing tests, so compare named failure sets at the actual integration base.

No safe combined payload is claimed yet. Codex can continue isolated window work and source review while the command-owner baseline is reconciled. Tim's installed ribbon/load, CDDEBUG performance, telemetry privacy, autosave protection and2024 checks remain required after an explicitly authorized owner deployment.
