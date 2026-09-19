# Integration evidence — bounded read-only inspection

FOR TIM

- Project recognition needs to distinguish a recognised job from an ordinary folder. A drawing opened from Downloads must not silently become a new job.
- Finding reports needs a different search scope from finding Civil sheets. Architectural and survey folders can contain governing evidence.
- A catchment calculation needs a traceable link to the areas, rainfall and requirements used. The inspected calculation quantities alone do not establish that history.

These are planning findings. No plugin behaviour was changed or run.

---

## Source checks, 16 September 2026

Paths below are relative to `C:\Lisp Files\CE_ACAD_PLUGIN`; this working copy is evidence, not an assertion about the installed binary.

| Source inspected | Observed | Planning implication |
|---|---|---|
| `Modules/Structural/Services/CeSheetsPathService.cs`, GetProjectRootForPath | Parses one named project-root marker; absent marker returns the supplied directory | Existing helper is not evidence of complete CDDESIGN automatic recognition. Ambiguous/unrecognised context needs explicit unresolved status; recovery interaction remains unapproved |
| Same file, IsIgnoredFolder | Sheet scan excludes Architectural, Survey and Xref folders among others | Do not carry those exclusions into report discovery. This is appropriate scope separation, not a claim the sheet scanner is wrong |
| `Modules/Structural/Services/CeProjectSetupService.cs`, ApplySetup | Requires existing ProjectRoot and creates project folders/drawings | Existing setup is a distinct operation. Do not impose its folder-first interaction on approved CDDESIGN review |
| `Modules/Drainage/Models/ProjectData.cs` | DrawingPath and pit/pipe/raingarden/slab/schedule collections | No catchment/calculation identity is present in this inspected class; this does not prove absence elsewhere |
| `Modules/Drainage/Models/CatchmentModels.cs` | Surface quantities and weighted coefficient; RationalFlowResult quantities | These inspected models do not carry source revisions or persistent catchment identity. Empty surfaces return zero internally; proposed user experience must preserve Unknown rather than imply a confirmed zero-area job |

## Council requirements

`02_COUNCIL_RULES/COUNCIL_RULES_V3_INTEGRATION.md` explicitly distinguishes published values, values issued by Council, and site calculations to ARR. Its opening states the specification is not built. The source describes field gaps including development type, freeboard reference levels, outlet hardware and issue requirements.

`02_COUNCIL_RULES/OPEN_QUESTIONS.md` contains unresolved choices. Later dated rulings must be checked before reproducing any question. This planning block does not approve coefficients, storm events, orifice rounding or council exceptions, and has not independently revalidated council documents online.

## Runtime evidence boundary

Read-only installed Modern Civil DLL inspection found ProductVersion `3.0.0+6505fb5a3908fe1bf0c78087b0a2c63e992398fc`. This check did not inspect other lanes or exercise AutoCAD.

Deploy issue #78 latest comment dated 16 September 2026 06:07 UTC records the same Civil revision. Its issue body retains an older baseline; use dated comment evidence rather than treating that body alone as current. Test-day findings and later CD/PIT ownership remain separate from installation.

No source, git state, build, deployment, original project document or parent-task process was touched by these checks.
