**ANSWER FIRST — independent project-data hunt, brief dated 22 October 2026; reviewed 23 October 2026, Melbourne**

1. **Counts: HIGH 4 / MEDIUM 3 / LOW 0.** Seven findings verified-by-reading. None has been reproduced in AutoCAD during this hunt. The tests below are for the later AI test lane, not a request for Tim to test.

2. **Most important: CDSYNC can give one pit another pit's schedule choices.** Two perfectly valid pits can exchange which one appears in the schedule; the first can also acquire the other's lid class and remarks. In a metre drawing, the recovery search reaches 200 metres. No missing or changed handle is needed.

3. **Other serious faults.** An unreadable drawing record can be overwritten by a rebuild; an old record on the PC can replace a valid drawing record after its last pit/pipe/manual row is removed; and the spine rollback command can delete permanent identities despite R-27.

4. **Next action.** Route the seven tests below to the builders and independent AutoCAD test lane before accepting the affected workflows. Civil + Manager delivery remains 9 November; Manager administrator work stays parked. This report changes no plugin behaviour.

---

1. **Scope and source.** Read RULES.md, ROUTER.md, the CE start/map and area M, `AUDIT_C58_C60_S40_S41_2026-10-22.md`, and the Civil, Structural and gate `CODEX_AUDIT_*_22OCT.md` reports. Also checked the existing Civil E/L/M hunts and relevant bug-register entries to avoid recounting their findings. The brief overrides its appended worktree/build/PR instructions. Only this findings file is authored.

2. **Pinned Git evidence.** Fetched `C:\Lisp Files\CE_ACAD_PLUGIN`. Civil/Manager ref `origin/claude/rel-20261022m` resolves to `40ee0a36f7960145743954b39859eb6c3af92869`; Structural ref `origin/claude/rel-20261022s2` resolves to `2c9a96942a024888a5ab520600f2d5025de83036`. Source references below are at the Civil commit. The brief identifies these as installed 3.0.70/1.1.70 and 1.0.121; this Git-only hunt did not independently inspect installed binaries. No new Structural fault is claimed.

3. **Meaning of verified.** VERIFIED-BY-READING establishes the executable branches and supplied fixture's predicted result. It does not mean native acceptance. SUSPECTED is reserved for host-dependent boundary risks in the coverage notes. Builds 0; unit tests 0; native tests 0; installs 0; sub-agents 0. No code checkout, branch, source edit or test fixture was created. All proposed fixtures are synthetic and remain to be prepared.

4. **Test convention.** Use separate disposable drawings and an isolated test profile on full AutoCAD 2027, then the 2024 lane where supported. Fixtures needing unusual saved-record states should be prepared by the test harness before opening the copy; never patch Tim's live drawings or profile. The project record is the concatenated DXF Text chunks at named-object dictionary `CE_CVL_SUITE_PROJECT/PROJECT_DATA`. An assertion on that JSON is a drawing-value assertion, not a claim that the command's success sentence proves correctness.

**Numbered findings**

1. **R-01 — HIGH — valid pits can take each other's saved choices during synchronisation. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProjectDataRecoveryGuardService.cs:113`, `:126`, `:184`, `:219`, `:230`; `Modules/Drainage/Services/ProjectDataService.cs:640`, `:662`; `Modules/Drainage/Services/ProjectDataService.Recovery.cs:794`.

   **What happens in AutoCAD:** P1 can disappear from the Pit Schedule while P2 reappears, even though neither pit moved and neither handle changed. P1 can also acquire P2's Class D lid and remarks. The drafter asked CE to reconnect records, not change those choices.

   **Exact failure scenario:** the saved list contains P1 first, P2 second. Both have distinct valid handles and numbers. P1 has the helper's complete default state: Class C Grated Lid, blank remarks/cover/invert/text, included, Main set, AddLabel/AddCoverText true, both text positions BR, no manual plastic admission. P2 is 10 m away in a metre drawing, Class D Grated Lid, remark `KEEP P2`, excluded. The helper compares raw XY coordinates against 200.0, without using PositionInsunits. It explicitly prefers a richer nearby snapshot over a weak default snapshot even when the latter matches P1's own identity. P2's snapshot is then consumed. P2 can receive P1's inclusion flag in the second iteration. Restoration runs on every full sync, not only on rebuilt rows; its caller requests a save.

   **DETERMINISTIC TEST — fixture and steps:** prepare that exact two-pit record, ordered P1/P2, at (0,0) and (10,0), INSUNITS 6, World UCS. Both 600 x 600 mm blocks already have correct self-handles; no pipes or orphan records. Keep Inspector/background conveniences off in the isolated profile. Type `CDSYNC`, then `PITSCHEDULE`. Read the two stored records and the window's pit rows; `QSAVE`, close and reopen the copy, then read again.

   **Assertion:** P1 must retain Class C, blank remarks and IncludeInSchedule=true; P2 must retain Class D, `KEEP P2` and false. Current code predicts P1 takes Class D/KEEP P2/false and P2 becomes included. The `[PitRestore] Restored user-set pit data from pre-sync snapshot (2 pits)` log line identifies the pass, but is not the oracle. A mm fixture with pits more than 200 mm apart is the control. A later regression must include two surviving, distinct pits, rather than only one rebuilt survivor.

   **Correction direction:** reserve surviving identity/handle matches before considering proximity, and use proximity only for genuinely unmatched records. Convert any matching distance consistently and expose its permitted value through Settings under R-00. The existing test `RestorePitUserDataFromSnapshot_OlderDrawingDefaultClassCAtSamePosition_KeepsEditedClassD` covers one surviving pit, so it does not protect this case.

2. **R-02 — HIGH — an unreadable saved drawing record can be replaced with a partial reconstruction. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProjectDataService.Persistence.cs:197`, `:208`, `:283`, `:823`, `:880`, `:895`, `:901`, `:1122`, `:1301`; `Modules/Drainage/Services/ProjectDataService.cs:831`, `:838`.

   **What happens in AutoCAD:** the visible pit can survive while manual schedule rows, remarks and other information stored only in the CE record disappear. Running CDSYNC after a bad record can replace the original evidence needed to recover those values.

   **Exact failure scenario:** PROJECT_DATA exists, but one saved value has the wrong JSON type. `TryLoadFromDrawingLight` returns false and recordExists=true. `LoadFromDrawingLight` discards recordExists and returns null; the ordinary loader eventually supplies a new ProjectData when no legacy file is available. The full sync rebuilds recognised geometry and saves it. `WriteXrecordString` assigns new Data to the existing Xrecord. This normal-load path has no preserved-original copy or unreadable-record write hold. The stricter detached reader and history-reload retry do not guard this route.

   **DETERMINISTIC TEST — fixture and steps:** start from a saved synthetic drawing with one recognised pit P1, a manual schedule row named `AUDIT-MANUAL`, and P1 remark `KEEP RECORD` stored only in PROJECT_DATA. In a fixture copy change only `lastPitNumber` from an integer to the string `BROKEN`; retain the complete original chunks as the test oracle outside the drawing. Ensure the isolated legacy projects folder has no matching file. Open the copy in a fresh session and type `CDSYNC`; inspect the record before and after `QSAVE`, close/reopen.

   **Assertion:** the unreadable original must remain recoverable and must not be silently replaced by a generated record. With no explicit recovery approval, require the original PROJECT_DATA bytes to remain unchanged, plus a visible explanation that the stored record could not be read. Current code predicts a load-error log followed by a successful project save and a valid replacement lacking AUDIT-MANUAL/KEEP RECORD. Capture `Failed to load project data from DWG` and `Project data saved to DWG successfully` with the drawing identity. This is the drawing-record defect, not the earlier Settings-file recovery finding.

   **Correction direction:** distinguish absent from unreadable data throughout loading. Preserve the original before any repair and hold replacement of that record while allowing unrelated drafting to continue; do not introduce a general command hard block.

3. **R-03 — HIGH — an old PC-side record outranks a valid drawing record when three lists are empty. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProjectDataService.Persistence.cs:209`, `:213`, `:224`, `:250`, `:261`, `:268`, `:277`, `:1337`; `Modules/Drainage/Models/ProjectData.cs:84`, `:106`, `:139`, `:149`.

   **What happens in AutoCAD:** after the last pit, pipe and manual schedule row are removed, reopening an older job can bring back obsolete choices from this PC. The same DWG on another PC without that old file can behave differently. The drawing can still contain valid rainfall, land-use, source-numbering and ignored-check information.

   **Exact failure scenario:** a successfully decoded drawing record returns immediately only if Pits, Pipes or ManualScheduleRows is nonempty. Otherwise the loader tries the legacy file and returns it ahead of the valid drawing record. Migration is not marked complete and the old file is not retired on this path. A legacy pit row queues a write; CDSYNC may remove that stale pit afterwards, but the replacement's job-level choices remain. This does not require corruption or a newer schema.

   **DETERMINISTIC TEST — fixture and steps:** prepare `AUDIT-LEGACY.dwg` with a valid embedded version 2.2 record, all three lists empty, sourceNumbering=`Never`, landUse=`residential`. In the isolated SettingsFolder/projects directory put its matching legacy file containing sourceNumbering=`Always`, landUse=`commercial`, and one stale pit P99 whose handle does not resolve. Use the production filename rule: `CD_ProjectData_AUDIT-LEGACY_<hash>.json`, hash = first four SHA-1 bytes of the exact drawing-path UTF-8 string, lowercase hexadecimal. Type `OPEN` for the copy, `CDSYNC`, `QSAVE`; close/reopen and inspect PROJECT_DATA. Repeat with that legacy file absent as a control.

   **Assertion:** both runs must keep the drawing's Never/residential choices and must not re-import P99. Current source predicts `Project data migrated from legacy file: 1 pits, 0 pipes`, then Always/commercial survives in the saved drawing even if P99 is cleaned away. Compare the exact fields, not only the final pit count.

   **Correction direction:** any successfully read embedded record is authoritative, including one with empty geometry lists. Consult the legacy store only when the embedded record is genuinely absent; unreadable data needs R-02's separate handling.

4. **R-04 — HIGH — spine rollback deletes identities that R-27 says must be protected. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/SpineUpgradeCommand.cs:40`, `:163`; `Modules/Drainage/Services/Spine/SpineRollbackStore.cs:61`; `Modules/Drainage/Services/LinkService.Spine.cs:205`, `:208`, `:713`, `:723`; `Modules/Drainage/Services/ProjectDataService.Spine.cs:230`, `:239`.

   **What happens in AutoCAD:** a drafter can give old pits and pipes their permanent identities, then remove those identities using a normal CE command. Their visible marks remain, concealing that permanent references have been cleared.

   **Exact failure scenario:** an initially unkeyed object receives a key through Apply. The rollback record stores an empty PreviousKeyText. Rollback verifies the current key is the one it assigned, then passes that empty value to WriteSpineKeyText, which removes SPINE_ID from the object's CE link dictionary. The same command blanks matching project SpineKey and endpoint keys and rewrites the durable snapshot. Locked-layer and changed-key guards exist; neither prevents the ordinary unlocked, unchanged-key deletion. This is a separate explicit command, not AutoCAD U undoing an uncommitted operation. No exception to the supplied R-27 ruling was established.

   **DETERMINISTIC TEST — fixture and steps:** use a saved synthetic legacy drawing whose loaded project has P1, P2 and their connecting polyline, all initially without SPINE_ID. Use an isolated rollback folder/profile. Type `CDSPINEUPGRADE`, `Apply`; capture the assigned object keys, project keys and `CE_CVL_SUITE_SPINE/RECORDS_V1`; `QSAVE`. Type `CDSPINEUPGRADE`, `Rollback`, then inspect the same values.

   **Assertion:** existing permanent identities must not be deleted. Require unchanged keys and a plain refusal of the destructive identity operation. Current code instead reports `Rolled back ... identities`, removes the object keys and clears the corresponding project fields. Save/reopen the disposable copy to check persistence. This is the allowed R-27 hard-block case; ordinary geometry deletion and general record warnings are not being reclassified as hard blocks.

   **Correction direction:** preserve assigned identities when rolling back other upgrade effects, or explicitly refuse rollback entries that would remove them. Do not delete the permanent command alias.

5. **R-05 — MEDIUM — successful handle recovery leaves schedule overrides and ordering attached to the old handle. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProjectDataService.cs:466`, `:470`; `Modules/Drainage/Services/ProjectDataService.Recovery.cs:636`; `Modules/Drainage/ViewModels/PitScheduleViewModel.Schedule.cs:478`, `:529`, `:651`; `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:267`, `:499`, `:923`.

   **What happens in AutoCAD:** CE says it has recovered the pit, but the schedule loses its typed override and saved place. The old override remains stored as an orphan rather than following the recovered pit.

   **Exact failure scenario:** a drawing contains a pit block at the stored position with a new handle, while its project pit, linked manual override and sort key retain the unresolved old handle. ReconcileOrphanedHandlesByPosition finds the unique block and updates only PitData.EntityHandle. It does not carry that proven mapping into ManualScheduleRows.SourcePitHandle, PitOutletOverrides or LinkedRowSortOrder. The manual-row restore checks the old handle and marks the override orphaned. Grid override lookup requires exact pit/inlet/outlet/set handles; the old row is also excluded from the pure-manual-row display.

   **DETERMINISTIC TEST — fixture and steps:** prepare a mm World-UCS post-handle-change fixture: one recognised P1 block at (0,0), actual handle H-new; one project P1 at (0,0), handle H-old which does not resolve anywhere. No pipes or competing pits. Store a linked override with SourcePitHandle=H-old, Main set, blank inlet/outlet handles, OverriddenFields containing Cover and Cover=`11.25`; actual pit cover is `10.00`. Include its H-old sort key. Type `CDSYNC`, then `PITSCHEDULE`.

   **Assertion:** once the log says `[Reconcile] Pit 'P1' handle ...` and the project pit points to H-new, the override must also point to H-new, retain Cover 11.25 and remain non-orphaned. Current code predicts SourcePitHandle stays H-old, IsOrphaned=true, and P1's displayed cover falls back to 10.00. Check the window and saved JSON; the source-lost status line alone is not sufficient. This fixture proves CE's handling of changed handles without assuming every WBLOCK/INSERT produces that state.

   **Correction direction:** apply a single, proven handle mapping to dependent records in the same recovery operation. Where identity is ambiguous, keep the evidence and ask for review; do not guess a new owner.

6. **R-06 — MEDIUM — adding one pit can discard a deliberately saved schedule order. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:904`, `:908`, `:937`; `Modules/Drainage/Services/PitScheduleRowOrder.cs:21`; `Modules/Drainage/ViewModels/PitScheduleViewModel.Filters.cs:533`; `Modules/Drainage/Dialogs/PitScheduleDialog.xaml:518`.

   **What happens in AutoCAD:** a drafter orders P2 before P1, adds P3, and reopens the schedule. The original pair silently returns to number order. The order was valid; the drawing simply grew.

   **Exact failure scenario:** the saved map covers two linked rows, then the drawing has three. Coverage 2/3 is below 90%, so ApplyPersistedSortOrder discards the whole map before calling the newer whole-pit ordering helper. The helper cannot preserve an order it never receives. This differs from the existing LM-05/BUG-786 fault where a new inlet was separated from its pit: each pit here has exactly one row, and both old rows still match their saved keys.

   **DETERMINISTIC TEST — fixture and steps:** mm drawing with scheduled P1 and P2, one row each, Main set, no manual overrides/pipes. Set linking.scheduleRowOrderByPit=true in the isolated profile. Type `PITSCHEDULE`; select P2's row, right-click `Move Up`; close and reopen to establish P2,P1 is remembered. Close; use `PIT` to place the next pit P3, keeping it included in Main; finish placement. Type `PITSCHEDULE` again. A prebuilt fixture containing P3 and the unchanged two-key saved map is the equivalent deterministic command-level test.

   **Assertion:** P2 must remain before P1; the new P3 may take its normal insertion place. Current source gives P1,P2,P3. Inspect linkedRowSortOrder before opening to prove it still contains both valid saved keys. The 90% cutoff cannot distinguish an obsolete map from normal additions.

   **Correction direction:** retain still-valid saved pit ordering and insert new pits predictably. Diagnose genuinely invalid references separately rather than inferring invalidity from a percentage.

7. **R-07 — MEDIUM — the spine repair says nothing needs writing before it can repair missing project identities. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/SpineUpgradeCommand.cs:96`, `:103`, `:119`; `Modules/Drainage/Services/LinkService.Spine.cs:74`, `:89`; `Modules/Drainage/Services/ProjectDataService.Spine.cs:41`, `:62`; `Modules/Drainage/Services/PitSpineRowBackfillService.cs:46`.

   **What happens in AutoCAD:** after a record reconstruction, pits can have their permanent identities on the drawing objects but not in the project record. Apply says every object already has an identity and does nothing, leaving the two records inconsistent.

   **Exact failure scenario:** all scanned objects have valid keys, so plan.NewKeyCount is zero. RunUpgrade returns before preparing the project snapshot and before the later code that explicitly copies KeepExistingKey entries into project rows. The comment says existing keys are repaired, but that branch is unreachable when all keys already exist. Source placement has a separate backfill route; that does not make this repair command work, and no claim is made that every downstream tool fails.

   **DETERMINISTIC TEST — fixture and steps:** saved synthetic drawing with P1, P2 and one pipe, each object carrying a distinct valid Civil SPINE_ID. Correct entity handles and marks remain in PROJECT_DATA, but the three SpineKey fields and pipe endpoint keys are blank, as can happen after reconstruction. Ensure all scanned attachments also have keys or omit them. Type `CDSPINEUPGRADE`, `Apply`; read PROJECT_DATA and the command line. Do not run a source-placement command between preparation and inspection.

   **Assertion:** existing object keys must be copied into the corresponding project rows, endpoint keys filled where the marks uniquely identify P1/P2, and existing object keys unchanged. Current code prints `Every object already has its identity. Nothing to write.` while the project fields stay blank. As a control, a separate fixture with one additional unkeyed pit reaches the later repair branch. This exposes the command-level early return that isolated ApplySpineKeys tests cannot catch.

   **Correction direction:** count missing project/snapshot identity writes separately from newly assigned object keys. Only return no-change when both stores agree.

**Coverage and limits — not additional findings**

1. **Copy/paste and INSERT protections found.** `LinkService.Utilities.cs:1248` captures clone maps; `LinkService.ForeignClones.cs:386` distinguishes foreign objects, remaps their owned labels and gives copies their own identities. Its deliberate log says `own identity, no record`; absence of an automatically copied source schedule row is not counted as a new defect. The protected-layer checks and ambiguous-map handling prevent a blanket claim that every paste reconnects to an equal-numbered host handle.

2. **WBLOCK and Xref bind remain SUSPECTED boundaries, not proven losses.** `ExternalMutationCommandPolicy.cs:35` lists COPY/PASTE/INSERT/EXPLODE but not WBLOCK or XREF. That absence alone does not prove AutoCAD's nested event behaviour or what it carries into the output DWG. Later test lane: create two synthetic networks with overlapping source/host handle numbers; separately COPYBASE/PASTECLIP, WBLOCK selected network then OPEN, INSERT with and without explode, and attach/bind a synthetic Xref then EXPLODE. After each explicit CDSYNC, assert no host pit/pipe is overwritten, each top-level copied object has an appropriate distinct identity, and its labels move only with that object. Record the actual clone event/command names. Do not mistake intentionally nested block contents for top-level scheduled pits.

3. **Save-as, DWG round trip and purge are not certified.** Later lane: record project JSON, object keys, label owners, overrides and row order from a healthy synthetic fixture; SAVEAS to a new name, close/reopen, run `-PURGE` All with confirmation, QSAVE and reopen again; separately round-trip through the supported 2024/2027 DWG lanes. Assert exact retained project-only values and valid ownership, allowing only intentional path/version metadata changes. Xrecord storage is JSON text chunks, not typed object references (`Persistence.cs:1295`), so changed handles require CE's own proven remapping. No undocumented Autodesk remapping or purge behaviour is assumed here.

4. **Earlier findings excluded.** No recount of disabled Ignore/cancelled Tidy initialisation writes, ignored-warning fingerprints, outcome logging, double-click selection, general REDO loss, the source-import losses, LM-05's detached inlet ordering, LM-45's Xref identity collision, or LM-52's duplicate pump labels. R-05 concerns dependent records after a successfully recovered pit handle; R-06 concerns discarding still-valid order before the grouping fix runs. No bug has been marked fixed or accepted.

5. **Rulings and handoff.** R-27's other hard block, publishing a failed build to colleagues, is outside this records hunt. R-00 governs configurable engineering/matching values; no new hard-coded value is proposed. The sole authorised change is this report in CE_PLAN; the plugin repository was fetched/read only. No PR, build, install or code commit is part of this deliverable.

**Summary — under 100 words**

1. **Summary.** Seven source-proven findings: four HIGH and three MEDIUM. Prioritise synchronisation transferring another pit's saved choices, preservation of unreadable drawing records, legacy-file precedence and spine identity deletion. Repair dependent schedule references after handle changes, retain valid ordering when pits are added, and remove the spine upgrade's premature no-change return. Every finding has a deterministic later test. Native copy/insert/bind, purge and DWG round trips remain unverified. Only this report was authored; nothing was built, tested, installed or accepted.
