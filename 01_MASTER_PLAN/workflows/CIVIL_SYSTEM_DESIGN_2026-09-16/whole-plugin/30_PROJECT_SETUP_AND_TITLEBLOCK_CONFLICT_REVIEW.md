# Project setup and title-block conflict review

FOR TIM

Starting a job should show which drawings already exist and which will be created. Later, correcting a title block should show the exact sheet and field that will change. Neither operation should quietly replace existing work.

## Authority and status

Proposed interaction detail for root02 J01/J02, qualified by root12 and root21 and the existing shared Project-to-Issue owner. No new source inspection or native execution. This closes planning depth findings SHUX01/02 only when independently reviewed. It does not change automatic project recognition, introduce a folder-link wizard, or assert that these interactions are built. Existing approved shared draft, Save Project versus drawing Apply and Apply/Discard/Stay boundaries remain authoritative.

## 1. First setup: review an exact creation list

Entry remains the recognised drawing's shared project setup route. CDDESIGN uses that same context. An existing project opens review/update, not another blank project. Unknown context remains visibly unresolved under root21; this proposal does not decide its recovery policy.

The setup preview lists proposed drawing path, template/profile identity, intended sheet/layout identities, optional title Xref, and each action. Metadata suggestions remain editable within approved scope. Template masters are read-only. Choosing an existing drawing does not prove its content meets the selected template or standards.

| Target state | Visible choices and consequence |
|---|---|
| Target absent at review | Create the listed project copy after confirmation; recheck absence immediately before writing |
| Existing drawing with verified project/sheet identities | Review and use existing; show differences and retain its drawing content. Adoption is an explicit register proposal, not an automatic template conversion |
| Same filename, uncertain identity | Review identity, choose another available name, skip this target, or cancel pending setup. No use-existing shortcut based on name alone |
| Existing drawing belonging to another job | Keep untouched; choose another valid target name within the established project scope or skip. No silent re-context or duplicate project creation |
| Locked/unavailable target or unreadable identity | Show unresolved; do not treat as absent or ready to overwrite. Continue independent accepted targets only if the exact partial scope has been reviewed |
| Shared title Xref missing or ambiguous | Show affected drawings and unresolved dependency. Do not substitute the nearest filename or claim title blocks are ready |

Changing a filename updates the exact preview and its dependent references before confirmation. No overwrite-existing choice is introduced here. If the owner's retained route has a separately approved replacement operation, it requires its own preview and recovery contract.

### Example and receipt

Fictional job: C01 already exists, C02 is to be created, C03 cannot be created. Review C01 identity before use. If C02 is created successfully and C03 fails, show C01's adoption state separately from C02's file creation and C03's failure. Do not report the whole setup complete.

For each row distinguish: reviewed only; file created and verified; file state unknown; register saved; register save pending/failed; active drawing changed but not saved. An error is not proof no file exists. Read actual target identities and contents relevant to the operation before retry. A verified C02 must not be created again because saving its register row failed. Retry the remaining verified-safe stage under the existing owner, preserving successful work and linking it to the intended identities.

Cancel before acceptance creates nothing. Stop during creation requests a stop at a safe boundary; it does not reverse completed copies. Closing afterwards resolves remaining drafts through the existing Apply/Discard/Stay choice and reports existing outputs. Only explicit Discard drops remaining draft edits; completed copies remain. Any cleanup is a separately reviewed exact-file action, never deletion of pre-existing drawings or template masters. No general filesystem Undo is promised. Save/reopen reconstructs the unfinished list from verified file/register state, not a success message alone.

## 2. Title-block comparison: one field, exact scope

The sheet register preview shows the saved register value, any pending register edit, current drawing/title-block value, proposed result, target identity and direction of change. A field named Revision does not establish which layout it belongs to. Identify DWG, layout, block/attribute mapping and sheet identity before enabling a write.

| Scope | Comparison and restriction |
|---|---|
| Shared job metadata | Name/job number and other approved shared fields: show all affected project rows/drawings; a local correction is not silently promoted project-wide |
| Drawing summary properties | One DWG scope; show distinct from per-layout attributes. A single summary revision cannot stand for two different sheet revisions |
| Sheet number/title | Exact register sheet and mapped layout attribute; preserve legitimate numbering gaps and unaffected sheets |
| Sheet revision/date | Exact sheet's approved state; ordinary synchronisation is not a new issue. Included-versus-revised rules still govern |
| Shared title Xref | Identify its actual shared scope and protection; no write-through to foreign/protected content or assumption it has a separate value per sheet |
| Unmapped or ambiguous title block | Remap through the owner's reviewed route or skip; no guessed attribute writes or claimed synchronisation |

Proposed row actions:

- **Use register in this mapped field:** preview the precise value from the selected saved/pending register basis; if pending register edits are involved, resolve their save boundary explicitly before claiming durable agreement.
- **Keep drawing value for review:** leave that value untouched and keep the mismatch visible. This does not update the register, create a permanent exception, or mark the sheet synchronised.
- **Propose drawing value to register:** only for already-editable fields, show affected shared scope and require the owner's explicit register save/review. No automatic two-way propagation or revision-history rewrite.
- **Review mapping / Skip:** preserve values and explain what remains unresolved. A skipped required mapping is not a successful sync.

No blanket winner based on latest timestamp, nonblank text, or drawing-first load order. If Tim later approves a remembered exception, its scope and invalidation must be explicit; no exception is inferred here.

### Example: two layouts in one drawing

| Target | Saved register | Drawing attribute | Proposed review |
|---|---|---|---|
| C01 / Layout A / title | Drainage Plan | Drainage Layout | Use register changes only this mapped title, or retain mismatch |
| C01 / Layout A / revision | B | B | No change |
| C02 / Layout B / revision | A | A | No change; never copied from Layout A |
| C02 / Layout B / date | Earlier issued date | Earlier issued date | Retain; inclusion in a later pack does not make it revised |
| DWG summary revision | One drawing-level value | B | Cannot establish both sheet revisions; show scope limitation |
| Unmapped block | Known register row | Unknown mapping | Review mapping or skip; do not write |

These are fictional labels and values, not a real job or approved revision sequence.

## 3. Concurrent edits, partial changes and drawing save

Before Apply recheck the selected register basis, drawing/layout identity, mapping and current field values. A changed source invalidates affected preview rows. Show opening/current/proposed values again; do not reuse a prior choice against a new value. Independent unchanged rows may proceed only with an explicit exact-scope review, not an invisible partial application.

Respect locked layers, Xrefs, REFEDIT and unsupported-object protections. Unavailable targets stay unchanged. Report each field/drawing as changed in memory, saved to drawing, register saved, skipped, failed or unknown as applicable. A field write followed by manifest failure is not an all-or-nothing rollback. A failed response needs readback before retry. Reopening reads actual saved states; it must not claim in-memory edits survived.

Cancel before Apply retains original drawing values and resolves only draft under the existing owner's boundaries. Cancel after a completed write does not pretend to undo that write. Single-drawing Undo is qualified by the owner; multi-file updates have per-target recovery, not a global Undo promise. Updating fields does not itself publish, increment revisions, or finalise issue history.

## Proposed acceptance walkthrough

1. Recognised job with three setup targets: verify existing C01, create C02, fail C03. Reopen and retry without duplicating C02 or losing C01.
2. Change target availability after preview: invalidate the affected row before creation; no overwrite.
3. One DWG, two layouts, different revisions/dates: change only one title. Both original revision/date pairs remain.
4. Edit the register while comparison is open: show the new value and require a fresh affected-row choice.
5. Leave one title block unmapped and another protected: update only reviewed valid targets; both unresolved rows remain visible.
6. Drawing write succeeds but register save fails: show the actual split state and recover without rewriting unrelated fields or advancing an issue.

Planning only. No plugin built, tested in AutoCAD, installed or newly accepted by Tim.
