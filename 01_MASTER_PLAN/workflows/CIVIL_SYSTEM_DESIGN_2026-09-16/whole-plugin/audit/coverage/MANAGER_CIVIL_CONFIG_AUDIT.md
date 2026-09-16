# Manager and Civil configuration audit

FOR TIM

Manager staging and startup settings are correctly distinguished. Two Civil success claims need tightening: Parts Reset attempts a save, and Label Apply All can return a count before successful drawing commit is established.

---

Source-only bounded audit on 16 September 2026; exact clock in paired receipt. No installed manifest read, Manager operation, settings write, drawing action, build, git or runtime test.

## Findings sent to root

| ID / severity | Evidence | Required correction |
|---|---|---|
| CFG-01 / medium | PartsCatalogueService85–108 resets memory, calls void SaveInternal which catches errors, fires changed event. Contract calls reset “already persisted”. | Say immediate in-memory mutation plus attempted file persistence. Later Cancel does not restore memory or any successful write; file success remains unknown without receipt. |
| CFG-02 / medium | LabelStyleService181–246 increments updated per attempted MText rewrite, commits later, catches exceptions and returns counter. ViewModel183–209 reports returned count. | Distinguish attempted versus successfully committed output. A positive count after failure is not committed-result proof. Future failure-after-first-update scenario must inspect actual drawing and truthful status. No native rollback assumption. |
| CFG-03 / low status | Label remaining-source map Next1 asks for survey consumer trace now supplied in root13 and independently checked. | Link completed sampled trace; retain only unsampled governing-use/quality contracts as remaining. Do not repeat completed work or imply every consumer proven. |

## Actual verification

- ManagerWindow163–268, Registry157–224, Installer208–269: startup toggle writes descriptor manifest and restart flag; NETLOAD queues only if descriptor not Loaded/path nonblank and active document exists; active installer stages and returns PendingRestart; old live mutation is below #if false. Root04 correctly refuses to treat inactive branch as current write or queued load as completed load. Remote acquisition is an optional service branch, not proof that every button constructs that option.
- LayerManagerViewModel197–219,292–347: reset changes draft; Apply invokes draw-order service; Save settings separate; invalid nonblank ACI refuses entire override update; reset colour cells requires Save. These observed boundaries match contract. Downstream native effects not established by this VM read.
- PartsCatalogueService30–108: cached per-user file, unreadable defaults in memory, missing-file seed attempt, Replace/Reset memory then save/event. Failure logging and no returned success substantiate CFG-01.
- LabelStyleDialogViewModel183–237 and LabelStyleService181–270,283–349: Save preserves prior active name if present, service catches write errors, cache invalidated; Apply continues and uses current style. Apply walks only qualifying pit attachment MText. It does not establish pipe refresh, review preview or manual-text protection. CFG-02 is additional result-receipt qualification.
- Label load fallback may attempt to overwrite a corrupt existing file with defaults; that is a recovery boundary, not proven successful restoration. Native file/consumer/current-owner acceptance remains unperformed.

## Finite remaining planning gaps

1. Correct CFG-01/02 and read back; link root13 for CFG-03.
2. TPZ/SRZ stored identity/radius/source/revision and edit lifecycle remain source-answerable in planner map.
3. Source-tag explicit selection/inline-split trigger needs reconciliation against approved connection scope if not already closed by command-discovery owner.
4. Label active-selection interaction is a product review choice; source absence of editor activation is now known. Do not ask Tim what source does.
5. Source-traced reset/save/apply routes still need explicit truthful receipt/recovery target and owner handoff. Native acceptance stays future; no need to implement the feature merely to complete planning.
6. Final end-user action coverage and whole-plugin morning pack remain pending. Counts cannot close these semantics.

No overall pass. Built, installed and Tim-accepted not assessed; no runtime tested.
