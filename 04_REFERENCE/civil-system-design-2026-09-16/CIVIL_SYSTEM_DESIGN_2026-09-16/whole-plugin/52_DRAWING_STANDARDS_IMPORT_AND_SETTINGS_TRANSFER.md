# Drawing standards import and settings transfer — planning distinction

FOR TIM

Loading drawing standards must say what changed in this drawing. Transferring personal settings is a different action. Neither action approves a new engineering basis for the job.

Example: a drawing can acquire a text style without adopting a different rainfall rule or changing every existing label.

## Named evidence and limits

Read-only source: `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\Services\NativeTimToolsService.cs`, ImportUserSettings at555; `C:\Lisp Files\CE_ACAD_PLUGIN\Modules\Structural\Services\LegacyToolCommon.cs`, ResolveBlockAssetPath and EnsureBlockDefinition at208–265. This is the inspected checkout, not evidence of installed behaviour. No source asset was opened and no command executed.

LU resolves the named TIM SETTINGS IMPORT.dwg asset, calls EnsureBlockDefinition, then attempts to erase the nonanonymous/nonlayout block definition. The erase exception is swallowed; the final message says settings imported. The helper returns an already existing definition without re-reading the asset, otherwise reads and inserts the source DWG. It does not enumerate a verified list of imported settings, affected existing entities or successfully cleaned definitions. Do not infer AutoCAD's internal duplicate-style handling, actual imported resources, or a successful standards refresh from this text alone. The supplied asset's actual contents remain uninspected.

The source command has a drawing lock and undo-mark scope. That alone does not prove every intermediate change reverses together, no drawing side effects remain after failure, or the file has been saved. The helper import and subsequent cleanup are distinct steps in the inspected call path.

## Proposed ordinary sequence

| User action | Required visible meaning |
|---|---|
| Enter retained LU doorway | Identify the actual drawing and resolved approved standards asset/version. Preserve the approved alias transition; do not retire this route merely because shared Settings exists. |
| Inspect proposed effect | Where supported, distinguish missing definitions to add, already present definitions, collisions and unknown content. Unknown collision behaviour is not labelled safe replacement. Keep the interaction proportionate to a direct drafting command; no mandatory new settings wizard. |
| Confirm a qualified import | Approval is for the named drawing and asset/effect. No personal-settings transfer, firm-rule edit, project engineering adoption or blanket change to existing labels is implied. |
| Read result | Separate resources verified added/retained, unresolved collisions, cleanup failure and unknown outcome. Do not print a blanket success because the final handler was reached. |
| Continue drafting | Drawing changed in this session is separate from saved DWG. Existing output is only changed by its separately reviewed drawing action. |

If a same-name import definition already exists, the inspected helper may return that definition instead of reading the selected asset. A future receipt must not claim the new asset was imported without establishing which path actually ran. Do not automatically erase pre-existing content merely to force a refresh. Replacement/cleanup needs the affected-content review and native protection rules of its owner.

## Transferable settings remain a separate owner

[Approved requirements14](14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md) and [scope/concurrent edits27](27_SETTINGS_SCOPE_AND_CONCURRENT_EDIT_REVIEW.md) govern preference import/export. A transferable package excludes passwords, keys and client paths; it identifies supported preference scope and compatibility. Preview allowed differences before applying. Firm-governed values stay read-only for ordinary staff; candidate engineering values return to the project adoption owner. This card does not invent a file format, precedence rule, new import command or migration implementation.

Failure to read an import keeps the current settings and explains what remains unestablished. A partly applied owner reports saved/failed/unknown scopes separately; retry first checks the actual result. An import from another machine never quietly redirects the current project folder or restores secret placeholders as credentials.

## Future representative checks — not run

- Missing asset: show unavailable source; do not report an import.
- Asset valid but same-name definition already present: identify existing-definition path, no fabricated new-version receipt.
- Cleanup fails after resources changed: report actual imported/unknown scope and leftover definition separately; reopening/retrying does not blindly erase unrelated content.
- Drafting style import: inspect the actual drawing, existing manual labels and saved/reopened state; no claim from a success message alone.
- Preference package contains a synthetic key/path and a project-rule candidate: exclude the private fields, preview permitted preferences, keep engineering adoption separate.

Classification: retain approved doorway pending owner review; qualify/modify result reporting and scope as proposals. No source changes, runtime test, installation or new Tim acceptance. [Bounded source/proposal audit passed](audit/coverage/LU_CUSTOM_SOURCE_DAILY_AUDIT.md); this does not approve implementation.
