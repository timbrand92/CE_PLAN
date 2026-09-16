# Settings scope and competing edits — proposed end-user review

FOR TIM

Changing a label preference should tell you which future action it affects. Changing an engineering rule requires its project basis to be reviewed. Saving one editor must not suggest every module has been saved.

This deepens [shared settings actions](11_SHARED_SETTINGS_ACTION_CONTRACT.md) and [approved settings/assets authority](14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md). Existing shared-owner draft and Apply/Discard/Stay behaviour remains authoritative. The comparisons below are proposed interaction detail, not proof of an implemented all-module transaction or a new permission scheme.

## 1. A setting tells the user its actual scope

Each editable field has a concise scope/use description beside it or in its immediate preview: **Personal appearance**, **Future drafting preference**, or **Project engineering basis** as applicable. Do not reclassify a numerical consumer as cosmetic because it appears in Settings. The inspected calculated-invert precision changes calculated values and needs the engineering qualification already recorded in11.

**Firm rulebook** is a separate governed tier under SH04#5 in [14](14_SHARED_APPROVED_ASSET_AND_SETTINGS_REQUIREMENTS.md): ordinary staff inspect the rule/source/version read-only. Administration belongs to the authorised Rulebook route. Ordinary Settings must not offer Use my pending value, Reset, or an editable override for a firm-governed field. A permitted project-specific departure follows its separately reviewed engineering authority and cannot rewrite the firm rulebook.

**Example:** a beam-label offset preview shows the next new label and a hand-positioned existing label. Saving the preference changes the former; the existing label stays where placed. No “Apply to all” is implied. A separate already-approved drawing action, if available, must show its own affected selection and preview.

| Action | Proposed visible result | Existing authority retained |
|---|---|---|
| Open a settings section | Show saved value, field meaning/units and owner scope. Load failure shows unavailable/last-known explicitly. | Opening is not saving, resetting or adopting a new project rule. |
| Change personal appearance | Preview within the supported owner/editor scope and mark pending. | Discard restores authoritative saved appearance; never claim the DWG changed. |
| Change a future drafting default | Relevant mini-preview and next-command consequence, plus note that existing manually placed output is retained. | Current unfinished command state is not silently rewritten. |
| Change a project rule candidate | Show winning source/version and any council/project conflict. **Review project basis** opens the existing adoption owner rather than treating a personal settings save as project adoption. | No new numerical default, source priority or rules edition is invented. Existing jobs do not upgrade silently. |
| Reset page | Show changed fields and pending status before Apply; list unchanged project/adopted values where needed to prevent confusion. | Existing staged versus immediate reset behaviours remain source-qualified; the target never disguises an immediate library reset as a harmless draft action. |
| Open a separate retained editor | Resolve the current owner draft through its actual Apply/Discard/Stay path; then open the other editor with its own save scope. | Civil hosted save cannot claim Structural, OSNAP or company settings were saved too. |

## 2. Another editor changes a value while this window is open

**Example:** two settings views opened from different drawing tasks edit the same personal label preference. This does not create two project-specific versions of a personal setting.

Proposed comparison on Apply:

This comparison applies only to fields the current user is already authorised to edit in the relevant owner. It cannot grant edit rights, bypass a firm rule or convert a read-only value into a personal preference.

- **Value when this editor opened** identifies the basis of the edit.
- **Latest saved value** shows the intervening change from the authoritative owner, when it can be read.
- **Your pending value** remains visible and editable.
- **Keep latest saved / Use my pending value / Continue editing** are proposed choices for the conflicting field. Show scope and exact values before accepting either; no timestamp-wins or silent last-save-wins policy is introduced.

Unaffected fields need not be re-entered. If the owner cannot qualify which fields conflict, show that limitation and retain the draft; do not falsely merge an unknown saved document. Replacing a complete settings file requires its own qualified owner contract, not a UI assertion that only the displayed field changed.

**Discard** intentionally restores latest authoritative saved values and loses the local pending edits; it is not “restore the value from when I opened the window”. **Continue editing** retains the pending draft without saving. Invalid text must not trap Discard. A failed Apply keeps the draft and identifies which scope, if any, was written; no single all-modules success banner.

This comparison is a proposal to prevent hidden conflicts. It is not a claim current source detects simultaneous edits or that a preference update is AutoCAD-Undo-able.

## 3. Switch drawings without retargeting a pending project change

Personal settings remain personal when the active drawing changes. Project-specific pending changes remain visibly tied to their original project identity. A new active drawing must not silently become the destination of an old project's adoption or Apply.

Proposed treatment: retain the draft with its original project heading and show **Active drawing changed**. Offer return to that project/context or close through the draft-resolution path. Viewing the new project's settings starts with that project's own saved basis, not copied pending values. Automatic folder recognition remains automatic; this is not a new folder-link wizard.

If the original project/source is unavailable, preserve pending work and show why Apply is unavailable. Continue unrelated appearance/drafting work where its owner supports it. Do not blank or zero the unavailable engineering settings.

## 4. Failure and recovery details

| Situation | Required proposed response |
|---|---|
| Owner unavailable before opening | Keep any existing draft; show actual unavailable editor and permitted fallback, not an empty substitute that appears saved |
| Apply writes one owner but another fails | Separate saved, failed and unknown scopes; avoid replaying already-saved effects when reviewing retry |
| Settings file changed during conflict review | Refresh the saved comparison while retaining pending text; previous approval cannot cover a different saved version |
| Reset followed by switching module | Resolve staged reset through current owner's draft path; no hidden save merely because navigation occurred |
| Crash/reopen | Claim recovered pending draft only if supported and read back; otherwise distinguish saved settings from unknown unsaved work |
| Preview unavailable | State preview unavailable and retained value/scope; do not fabricate a diagram proving effect. Whether Apply is permitted follows the field's existing reviewed authority |

## 5. Synthetic review cases

1. Change a label offset, switch drawing, save personal preference: existing labels in both drawings stay; next placement shows the new default only under its qualified consumer.
2. Open two views, change/save one, then Apply a different pending value in the other: comparison shows opening/latest/pending values, no silent overwrite.
3. Type invalid text, then Discard: latest saved value returns without a save or drawing mutation.
4. Stage a project-rule change, switch jobs: original project remains named; no update of the newly active project's basis.
5. Save Civil preferences, then fail to open Structural fallback: Civil receipt stays truthful; Structural is unavailable, not saved.

This is planning only. Existing native focus, owner sizing, binding commits, save/readback and actual preference consumers need implementation evidence. The proposal does not interrupt or edit the shared-settings owner.
