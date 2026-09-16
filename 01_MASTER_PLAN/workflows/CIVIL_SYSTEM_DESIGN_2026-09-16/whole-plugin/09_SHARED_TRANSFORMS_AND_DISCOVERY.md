# Shared copy/move/rotate — preservation contract

FOR TIM

Select objects, pick a base, place them, then rotate. Copy leaves the originals; Move does not. Escape cancels the unfinished operation and one Undo reverses a completed operation. These remain drawing tools, not another setup window.

## Authority reconciliation

Read on16September2026: root `docs/workflows/SH-05_SHARED_TRANSFORM_REVIEW.md` and `TF-01_OBJECTARX_COPY_MOVE_ROTATE.md`; then the named owner's actual source in `C:\Lisp Files\CE_ACAD_PLUGIN_OBJECTARX_TRANSFORMS`.

Tim's later instruction **“CAN YOU ADD TO MAIN PLUGIN AND REMOVE THE LISP NEED”** supersedes the earlier requirement to keep a LISP fallback for AutoCAD2027. Older-runtime routes are retained. The planning must not reintroduce a2027 fallback or mistake the older root checkout for the latest prepared implementation.

Direct source observation: owner `Modules/Drainage/Commands/CopyRotateCommands.cs:1–63` has the2027 conditional branch, normal MR/MOVEROT/CR/COPYROT declarations at24–31, assembly-relative native component resolution at40–44 and synchronous exported call at53–56. It does not call LISP in that branch. `Modules/Structural/Services/NativeTransformToolsService.cs:1–15` routes Structural use to CR/MR rather than owning a competing transform. `Modules/Shared.Transform.Native2027/TransformCommands.cpp:357–359` still has trial registrations; those trial names alone therefore do not establish that normal-command integration is absent. The actual normal-command bridge is separate.

The owner's card reports prepared combined source and historic trial acceptance. No git ancestry, build result, current installed identity or production acceptance was independently checked here. Source inspection is not a deployment claim. An initially searched `Modules/Shared` directory and guessed `NativeObjectArxTransformService.cs` do not exist in that checkout; the verified bridge is the file above.

## Retained workflow and acceptance cases

| Step or condition | Required drawing experience | Evidence still needed before a future production claim |
|---|---|---|
| Preselect or start empty | Use the selected set or ask once for objects | Actual normal commands, both routes |
| Base and destination | Live placement preview, snaps, typed coordinates and active UCS | Rotated UCS and typed/snapped inputs |
| Rotation | Rotate about the placed destination; Enter/zero accepts unrotated placement | Input feel and pivot in the actual drawing |
| Copy | Exactly one copied set, originals unchanged | Attributed block and mixed ordinary entities |
| Move | Original set moved, no abandoned source copy | Preview may retain source originals until commit; preserve recorded limitation |
| Escape before completion | Restore starting geometry and temporary drafting state | Both placement and rotation stages |
| One Undo after completion | Reverse that operation only | Normal commands in the combined package |
| Protected content | Respect locked layers/Xrefs/unsupported entities; REFEDIT blocked | Representative protected selections, no bypass |
| Save and reopen | Ordinary DWG entities remain usable without a new custom-object dependency | Reopened synthetic drawing |
| Missing/incompatible component | Explain installation problem; no silent fallback with different behaviour | Actual recovery presentation, not run here |

Historic Tim acceptance recorded in the source card covers trial basics, no-preselection, full Escape and one Undo. It does not prove the remaining cases or current main-command integration. This is a consolidated future owner checklist, not a request for Tim to repeat tests tonight.

## Access and product boundary

- Preserve short and long aliases and the shared ribbon/context route where approved. Do not add another transform home page.
- Preserve the approved return of `C` to the user's native COPY alias; do not edit a user's PGP or external LISP during planning.
- Source currently carries the normal owner in the Civil assembly despite shared product responsibility. Keep ownership distinct from packaging; do not claim Structural-only availability without verifying its approved package dependency.
- Standalone Civil must remain usable under the later V3 decision. No proposed shared workspace may make these basic drafting tools depend on opening Manager.
- Tool-register/ribbon/Help reconciliation is being recorded separately by the planning worker; counts of source declarations do not establish discoverability or installed ownership.

No source, drawing, installation, process or git state was changed. Whole-plugin audit pending.
