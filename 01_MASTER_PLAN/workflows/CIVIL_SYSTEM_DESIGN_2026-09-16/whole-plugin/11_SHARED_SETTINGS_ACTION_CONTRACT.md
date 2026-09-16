# Shared settings — retained actions and field meaning

FOR TIM

Keep appearance, drafting preferences and engineering rules visibly different. For example, changing a label gap affects future placement; accepting a new minimum cover requirement is a project design decision with affected checks to review.

This extends03_SETTINGS_ASSETS_AND_HELP.md and the static control ledger. It does not replace the approved master or authorise implementation.

## Inspected source and authority

The named shared owner is `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN`. Read actual SettingsWorkspacePage and HelpWorkspacePage XAML, PluginManagerWindow.Settings.cs/Help.cs, and Civil AdvancedSettingsViewModel.cs. The approved SH-04A first slice retains a complete Structural fallback while hosting Civil. General and Civil share one Civil draft; this is not a proven all-module settings transaction.

## Actions, scope and departure

| Visible action | Inspected route | Preserved behaviour / future qualification |
|---|---|---|
| General ↔ Civil | Settings.cs265–288; same Civil-owner sections | Keep one draft; changing section must not discard edits or claim a separate save |
| Apply | Settings.cs290–300,430–464; VM475–504 | Commit current editor text, validate, call owner save. Failure retains draft/error. Success does not redraw existing geometry |
| Discard | Same host path; VM511–521 | Restore latest saved owner values/theme without saving; discard remains possible with invalid input |
| Leave Civil owner | Settings.cs466–509 | Apply / Discard / Stay. Invalid input or failed Apply keeps user in place; no silent loss |
| Existing Civil settings | Settings.cs549–582 | Resolve actual loaded fallback availability; resolve draft before dispatch; release hosted session only through successful dispatch path |
| Existing Structural settings | Same dispatch with Structural identity | Complete retained editor, not an empty substitute; hosted Apply must not imply it saves Structural fields |
| Company controls | Settings.cs599–613 | Resolve draft and verify administrator policy; this is a separate admin window |
| Reset General | VM342–345 | Stages Follow AutoCAD theme; no immediate saved reset |
| Reset Civil | VM347–372 | Stages Civil defaults; still requires Apply. Existing numeric defaults are source facts, not newly endorsed project engineering values |
| Open OSNAP settings | VM375–399 | Dirty parent draft resolved through Apply / Discard / Stay before separate editor opens; it is not silently part of the same save |
| Help Civil / Task journeys | Help.cs104–112,134–185 | Open the owner-provided content and preserve its lifecycle callbacks; failure remains visible |
| Help Structural | HelpWorkspacePage.xaml30–35; Help.cs123–126 | Keep full existing guide while embedded adapter is incomplete |

The host validates bindings before Apply and deliberately permits Discard despite invalid editor text. Preserve this detail: typing a non-number and pressing Discard must not trap a drafter in Settings. The current shared window has General/Civil/Structural/Manager sections; proposed Project/Advanced organisation in03 is a planning destination, not a claim those sections exist in this source.

## Retained Civil fields and proposed meaning

Source: CivilSettingsView.xaml and CivilGeneralSettingsView.xaml; bindings retained in06. Categories below organise the experience; they do not grant an unapproved default or change the present owner.

| Fields / controls | Meaning to the drafter | Proposed scope and visible consequence |
|---|---|---|
| Theme | Appearance only | Personal preview; Apply saves, Discard restores authoritative appearance |
| Invert position; mirror text | Preferred annotation placement | Future placement defaults; existing hand-positioned labels retained |
| Invert inward distance; text/invert gap | Distances controlling placement | Explicit units; preview example. Existing source labels inward distance only “units”, so physical versus drawing units requires consumer verification before relabelling |
| Minimum grade label; standard grade label | CD fixed-grade choices with no entered inverts | Show1:N meaning; do not confuse this label preference with the governing minimum permitted pipe grade |
| Calculated invert decimals | Calculated-level rounding and displayed precision in the inspected source | Not merely cosmetic: CD/CDEDIT pass this value into the calculated-invert rule. Preserve approved common rounding and engineering authority; do not offer it as harmless appearance-only setting |
| Minimum outlet drop | Level-assistance input | Engineering assumption/source shown and project adoption reviewed; changing personal default is not a network recalculation |
| Remember Quick Mode; default auto-zoom; draw run before options | Drafting interaction preferences | Clear next-command behaviour; do not erase current unfinished command state |
| OSNAP drawing/text modes | Selection/placement aids | Separate retained editor and its own save/cancel scope; restore temporary drafting state after command |
| Minimum pipe grade; maximum velocity; minimum cover; maximum run length | Design checks | Source/version/project authority visible; no universal reset number silently becomes governing council rule |
| LPD pit identifier | Recognition preference in inspected source | Text match cannot establish legal discharge authority or create hydraulic topology by itself |
| Survey workflow mode | Design suggestion versus passive markup reference | Retain explicit adoption/manual cover entry; newer survey does not replace accepted levels silently |
| Cover-level tolerance | Comparison threshold against survey | Units and purpose visible; disagreement is a review finding, not automatic level repair |
| Diagnostic logging | Support evidence collection | Personal/support scope; distinguish from calculation precision and engineering checks |

## Representative review sequences

1. Edit a Civil number, leave keyboard focus in its field, press Apply: the actual typed value is validated/saved once, not the previous bound value.
2. Type invalid text, press Discard: restore saved values and leave clean. No save and no drawing change.
3. Stage General and Civil changes; move between those sections, then open Structural settings: resolve the shared Civil draft once; do not call Structural's independent editor already saved.
4. Reset Civil, inspect changed values, then Discard: existing project engineering remains unchanged. Apply is a settings save, not AutoCAD Undo-able geometry change.
5. Change theme while another legitimate preference update occurs; Discard uses latest authoritative saved appearance, not a stale start-of-window copy.
6. Open an unavailable module's Help/settings: explain unavailable route and retain permitted fallback; no false successful editor launch.

## Remaining qualification

Actual consumer units/precision and latest Civil engineering-rule ownership need tracing before new labels or grouping are approved. Structural candidate settings fixes remain with the recorded owner; this pass does not infer them absent from an older file. Native keyboard/focus, window close/Escape, OSNAP save failure, cross-module conflict and actual owner sizing remain untested. No source or installed settings were changed; independent planning audit is ongoing.

### Bounded consumer read-back — 16 September

Root source `Modules/Drainage/Commands/CdCommand.cs:426–436` and `PipeEditCommand.Update.cs:228–244` pass CalculatedDecimals and minimum outlet drop into ApplyCalculatedInvertRule, then use the returned inverts. `LinkService.Split.cs:578` formats an interpolated split invert with that precision; `LinkService.Utilities.cs:1048–1065` formats a changed endpoint for the project pipe. Therefore this preference can affect resulting engineering values in these paths; the earlier display-only suggestion is corrected above. No active owner's newer calculation code was changed or runtime result asserted.

Root `QuickModeService.cs:41–45,183–184` and `TextService.cs:50–59,1542–1565` use inward/mask distances directly in drawing-coordinate geometry without a conversion in these inspected functions. This supports “drawing distance” for those paths, not a universal paper-mm interpretation. Before relabelling the current “units” field, qualify actual drawing units and all owner paths; a property name ending Mm alone is insufficient proof. This is a concrete remaining field-semantics check, not a request for Tim to decide what the code does.
