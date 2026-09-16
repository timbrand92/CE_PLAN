# Parts catalogue — edit a row, then choose it for new work

FOR TIM

A catalogue label must not conceal a different size or material. Save the intended row, then deliberately select that exact part in the existing placement window. Existing pits and pipes keep their confirmed values.

Example: two pit rows may have the same width but different lid classes. A size shortcut alone cannot tell the engineer which class was chosen. This plan adds clear review of the chosen row; it does not redesign active PIT/CD windows or approve a part's engineering suitability.

## Existing authority and actual source

Read with [configuration controls and boundaries](planner/civil_configuration_layer_and_parts_contract.md), [asset/settings authority14](14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md) and [concurrent settings27](27_SETTINGS_SCOPE_AND_CONCURRENT_EDIT_REVIEW.md). Current per-user parts data is candidate input, not a competing firm or project engineering authority. Source defaults are not endorsed by this card.

Named root source read: PartsCatalogueViewModel.cs, PartsCatalogueCommands.cs, PartsCatalogueService.cs and PartsCatalogueData.cs under Modules/Drainage. The view model clones pit/pipe rows; duplication clears DisplayName while retaining dimensions/type/material fields. Models return an entered custom label instead of the auto-generated descriptive text; a label can therefore differ from the numeric fields. These row classes show no separate stable row-ID property. That does not establish identities or selection behaviour in every consumer.

Save replaces both service collections, attempts persistence, raises CatalogueChanged and closes the editor. SaveInternal catches failure without returning success; refresh or editor closure is not a verified saved-file receipt. Reset changes memory and attempts persistence immediately, so subsequent Cancel does not restore the previous catalogue. Loading can seed defaults. These inherited source boundaries remain explicit; no settings file was read or written in this pass.

The quick square-pit caller selects the first exact X/Y square match, otherwise constructs a fallback entry. Its comment mentions matching X-only fallback, but the inspected expression does not implement that branch. It then supplies fields to the existing PitViewModel/PitDialog and delegates placement to PlacePitCore. The caller does not select a particular same-size variant by custom label, lid class or a durable catalogue-row identity. Source observation only: no shortcut, PIT dialog or placement was executed, and no additional PIT internals were traced.

## Proposed ordinary journey

| Stage | What the user does | Required distinction |
|---|---|---|
| Inspect current catalogue | Open CDPARTS and choose pit or pipe rows | Actual scope and saved/loaded status are visible. It is not a list of automatically approved project selections. |
| Duplicate or add | Duplicate the intended starting row or enter a new row | A duplicate is a new candidate, not an approved equivalent. The original remains distinguishable; any cleared label is visible. |
| Edit fields | Review actual dimensions in displayed units, pit type/lid/plastic fields or pipe diameter/material, plus optional label | Show the actual properties beside the label. Do not derive engineering fields from free text or assume a custom label validates them. Missing/invalid required data cannot masquerade as a valid part. |
| Resolve ambiguity | Compare same-label or same-size rows side by side by their actual properties | Same dimensions do not mean same material/class/suitability. Do not silently merge, overwrite or use the first row as the engineer's choice. Exact validation/duplicate policy remains owner-qualified. |
| Save catalogue | Review the changed scope and persist through its owner | Separate saved file, in-memory update and failed/unknown persistence. A row is not firm-approved or project-adopted merely because Save succeeded. |
| Return to new-item work | Through the existing PIT/CD owner, deliberately select the intended saved candidate and inspect the populated values | Retain the specific row/version/evidence used where supported; no new part editor or competing placement path. A shortcut still exposes its actual selected/fallback values before placement. |
| Confirm the new item | Complete the existing owner's size/type/material and project-input review, then its normal preview/placement | Catalogue choice is only a proposed input. Hydraulic/structural adequacy, connection, cover/invert and schedule identity follow their existing owners. |

A future exact-selection contract cannot use display name alone as stable identity. The implementation owner must qualify how the chosen entry/version and values remain traceable when labels are edited or rows reordered. This card does not pretend the inspected schema already provides that identity, nor prescribe a second catalogue format.

## Existing objects and open drafts

- Saving or deleting a catalogue row does not resize, reclassify or erase existing drawing objects. Their confirmed values remain available even if the former catalogue entry is missing.
- An existing placement draft retains its selected candidate and explicit field edits. CatalogueChanged must not silently replace it with the latest same-name row. Show changed catalogue evidence and let the existing owner refresh/review affected proposed fields.
- A candidate row is no permission to expose unapproved office assets through ordinary commands. Keep the existing catalogue approval/suitability gates and permitted project/manual choices distinct; no blanket new Candidate-use permission is introduced.
- Changing only custom wording does not change stored dimensions/material. If wording becomes misleading, surface that discrepancy; do not silently alter engineering fields to make it match.
- A quick size route with several same-size variants must make its chosen variant clear under the existing owner. This proposal supplies no new default class/material or automatic preference among variants.

## Failure, reset and later use

Ordinary unsaved row edits can be discarded through their actual owner. The current immediate Reset is different: show that memory and possibly the file already changed, then recover through a qualified settings action. Do not promise drawing Undo restores a settings file. A proposed staged/recoverable Reset needs its existing owner review before implementation.

For a save failure, retain the pending row and distinguish the actual file from cached memory. Reopening in the same process is not alone proof of disk persistence. A retry must not replace another editor's intervening changes without the comparison in27. No full-file overwrite may be described as saving only one row unless qualified by the actual owner.

## Future combined check — not run

Duplicate a synthetic row; give two entries the same label but distinct properties; save and select the intended variant for one new item; retain a manual field in an already-open draft; edit/delete the catalogue entry and confirm existing geometry unchanged; inspect shortcut fallback; cancel a normal edit versus immediate Reset; simulate a save failure; reopen and inspect the actual file/selected part. These are representative owner checks, not a new manual backlog for Tim tonight.

Planning only. No source/settings changes, build, native test, installation or Tim acceptance. [Independent bounded audit passed](audit/coverage/PARTS_CATALOGUE_DAILY_AUDIT.md). CD/PIT ownership remains protected.
