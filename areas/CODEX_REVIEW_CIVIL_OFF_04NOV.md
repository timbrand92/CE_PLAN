FOR TIM
1. **My mistakes:** I first looked for the theme at the brief's root path; it is under Modules/Drainage/Themes. Corrected; no drawing or code changed.
2. **Verdict:** FIX FIRST for #2015, #2016, #2017 and #2018 at the exact tips below.
3. **Main risk:** Undo can restore an OFF mark while CE still remembers ON; later slices also lack slice 1's latest protection fixes.
4. **Open question:** Escape cannot dismiss its Yes/No box. No still writes into the drawing; Yes still bypasses the full upgrade preview.
5. **Other gaps:** no visible Settings switches for these features; the banner still does not name the upgrade action; an ordinary save need not stamp the version.
6. **Read / built / tested:** read the four PR views, diffs and relevant callers; built nothing; tested nothing (0 tests run).
7. **NOT proven:** real drawing behaviour, Undo/REDO, Save prompts, protected content and appearance. No AutoCAD, robot, installation or live-bundle build.

---

1. **Review identity and scope — JOB N1, 5 November 2026, Melbourne.**

   This reviews the approved card and decision of 4 November, and checks the earlier Opus review against the actual code. No fixes were written. Paths below are relative to the plugin repository. Unless a different tip is named, shared downstream code references use #2018's tip. Findings are source conclusions, not observed AutoCAD results.

   #2015: `8041dfa501acda63b3dd57ddf4ecdf97ad283a42`, branch `claude/civil-off-1`, base `claude/rel-20261112a`.

   #2016: `95390f64d0d734502fc90daf48c10de1a9f4135b`, branch `claude/civil-off-2`, base `claude/civil-off-1`.

   #2017: `eb920bbe52018660d26c5f70541213735811a596`, branch `claude/civil-off-3`, base `claude/civil-off-2`.

   #2018: `328e2fb53263d04b19d4281da06435f837296202`, branch `claude/civil-off-4`, base `claude/civil-off-3`.

   All four were still OPEN and DRAFT when rechecked before writing. Their descriptions contain older claims and older base-tip references; these are not evidence of the current implementation.

2. **Stack finding — fixes have not propagated.**

   `git merge-base --is-ancestor` returns 1 for #2015's current tip in #2016, and for #2017's current tip in #2018. Slice 2, and hence the present slice 3 and 4 histories, still carry the old slice 1. Slice 4 carries the old slice 3 wording.

   This matters on a drawing: reviewing the latest #2015 gate does not prove that checking out #2018 stops CDSYNC or pit migration. At #2018, `Modules/Drainage/Services/PitBlockMigrationService.cs:161` proceeds to the normal-drawing check with no OFF check, then migrates at line 167 and regenerates at line 171. `CivilOffCommandGate.cs` is absent from that tip. The earlier Opus findings remain real there.

   Incorporate the fixes through the authorised integration route and review the resulting stack again. No merge, rebase, retarget or PR operation was performed by this review.

3. **#2015 — FIX FIRST: OFF is not reliably tied to the drawing after history changes (P1, new finding).**

   At #2015, `Modules/Drainage/Services/LinkService.Cache.cs:237` sets/clears `state.CivilOff`; line 256 returns that cached value. The new gate relies on it at `Modules/Drainage/Services/CivilOffCommandGate.cs:88`. The only calls to `ReevaluateCivilActivity` are CE's explicit tag write and clear at `Modules/Drainage/Services/DrawingDisciplineService.cs:388` and `:411`.

   Neither the Undo/REDO branch at `Modules/Drainage/Services/LinkService.Reactors.cs:867` nor the cache rebuild at `Modules/Drainage/Services/LinkService.Cache.cs:895` rereads that OFF flag. The early quiet return at `LinkService.Reactors.cs:584` can bypass the history branch entirely. The drawing-owned-key reload at `:1448` is not a discipline refresh.

   Concrete case for the eventual runner: open a saved OFF drawing, use CDDISCIPLINE to turn Civil ON, then U to restore the OFF tag. Memory still holds ON. CDSYNC/CDUPGRADE can pass the new cached gate; their existing implementations do not call the discipline preflight. The pending-record writer also trusts memory at `Modules/Drainage/Services/ProjectDataService.Persistence.cs:570`. Conversely, undoing an ON-to-OFF choice can leave CE blocked after the mark is removed. REDO must be checked in both directions. Refresh the authoritative state without writing or consuming REDO; the source gap is confirmed, the live sequence is NOT proven.

4. **#2015 — FIX FIRST: native grips still run Civil behaviour while OFF (P1, new finding).**

   `Modules/Drainage/Services/PipePlanGripOverrule.cs:49` accepts the polyline without consulting Civil OFF. `:94` enters the CE path, `:103` flattens the drag to the drawing plane, and `:116` passes that modified movement to AutoCAD. It is registered at `Modules/Drainage/PluginInitialization.cs:140`.

   This is a concrete route outside CE's typed-command gate: grip-drag an existing CE polyline with a Z offset while Civil is OFF. CE still changes the drag's meaning. The global gate recognises CE CommandMethod names, not native grip operations. Audit the remaining managed/native grip and object callbacks before claiming the whole plugin is inactive. The C7 native object's complete OFF behaviour was not proven by this review. No overrule or protected file was edited.

5. **#2015 — Opus findings checked, with corrections.**

   The already-OFF pit migration hole is addressed in the current #2015 source: `Modules/Drainage/Services/PitBlockMigrationService.cs:163` returns before migration and Regen, without marking the drawing migrated. It is NOT addressed in the present later-slice tips. The new check still does not hold an untagged old drawing pending the open question. At `:172` migration can run once Civil is ON; switching ON and reactivating the drawing can therefore catch up its pit blocks automatically, contrary to the “nothing is caught up by itself” message at `Modules/Drainage/Commands/DisciplineCommand.cs:77` and card answer 9.

   The missing per-command preflight finding is partly addressed by the new reflected command gate (`CivilOffCommandGate.cs:52`, `:78`). Do not repeat Opus's claim that the latest #2015 has no central gate. Its lock-event coverage is not host-tested, and findings 3 and 4 remain. The old unguarded command paths remain in the later tips: CDSYNC at `Modules/Drainage/Commands/LinkCommands.cs:118`, CDREBUILD at `:210`, and CDUPGRADE at `:904` on #2018; CDUPGRADE's actual writes include `:1084`, `:1085`, `:1115` and `:1119`.

   The OFF pipe-open return is present at `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeOnOpenService.cs:111`. Initial activity selection at `Modules/Drainage/Services/LinkService.cs:1617`, the wake stop at `LinkService.Cache.cs:206`, pending-record stop at `ProjectDataService.Persistence.cs:570`, kept-record stop at `ProjectDataService.KeptRecords.cs:257`, and MarkDrawingActive stop at `ProjectDataService.Persistence.cs:927` are real source protections. They do not justify Opus's blanket “every reactor path” assurance after Undo.

   Ribbon greying and the per-drawing toggle remain missing acceptance work, acknowledged in the PR. CE_SHARED is unchanged. This is an incomplete card requirement, even if intentionally deferred outside this slice.

   The strict-reader edge is real: `DrawingDisciplineService.cs:290` rejects a stored OFF value when the feature switch is false. Older code's reader treated anything other than CVL/STR as Unknown; the cross-version rollout concern is therefore valid. No claim is made here about which build any colleague currently has installed.

6. **#2016 — FIX FIRST: Escape/Cancel is not implemented as reported (P1, new finding and Opus correction).**

   At #2016, `Modules/Drainage/Services/OldProjectOpenPrompt.cs:110` selects `MessageBoxButton.YesNo`, with No as default. There is no Cancel button. WPF disables Escape and the close button for this combination; it does not return No for Escape. See [Microsoft's message-box documentation](https://learn.microsoft.com/en-us/dotnet/desktop/wpf/windows/how-to-open-message-box).

   The PR body, comments and Opus report say Escape/closing leaves it as it is. That is false for the actual box. The test override returning null (`:107`) is not evidence that a user can dismiss the real window that way. Enter selects No; No writes OFF. Provide a real dismiss/cancel route with the approved safe behaviour, and test the actual prompt later. While the modal box is open, U/REDO are not an alternate exit through the drawing command line.

7. **#2016 — FIX FIRST: No writes, and Yes takes a different upgrade route (P1, Opus confirmed).**

   `Modules/Drainage/Services/OldProjectOpenPrompt.cs:80` writes the OFF tag immediately under a document lock; `DrawingDisciplineService.cs:365` opens the drawing dictionary for write and commits at `:385`. `Modules/Drainage/Services/OldProjectPolicy.cs:26` nevertheless says nothing changed. This is an in-memory drawing mutation, not a save of the original DWG file. The resulting DBMOD value, save question and exact Undo grouping require AutoCAD proof; Opus presented those inferred outcomes too confidently.

   Yes falls through to `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeOnOpenService.cs:143` and stamps at `:148`. There is no common call to CDUPGRADEDRAWING, no full preview, no Merge/Replace refresh and no combined completion result. This remains true at #2018. The old route can reuse an earlier backup (`Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeService.cs:71`) rather than taking slice 4's fresh backup. Consolidate the routes without removing the old typed aliases.

   Failure is also reported as success: the tag writer catches and logs errors at `DrawingDisciplineService.cs:390`, returns no success flag, and the prompt still returns LeftAsItIs. The caller then removes the drawing from Pending. A failed OFF write must not be presented as a protected drawing.

   The pre-answer pit-work gap remains: the migration service and prompt have separate Idle schedules and no common “waiting for answer” guard. The current #2015 fix checks an existing OFF tag only; current #2016 has not even inherited that check. Do not depend on event subscription order to satisfy “nothing changed yet”.

8. **#2016 — remaining Opus points and Undo/REDO limits.**

   Missing or invalid stamps count as old at `Modules/Drainage/Services/OldProjectPolicy.cs:33`; `ShouldAsk` at `:47` also requires a CE record and no OFF tag. This matches Tim's already-decided point B. Opus's suggestion to change the default for already-converted jobs is not an approved ruling and is not adopted here.

   `OldProjectOpenPrompt.cs:70` does defer the answer while the REDO guard is open. However, the stamp is read earlier at `:64`; `OldProjectStampStore.cs:24` uses StartTransaction, not StartOpenCloseTransaction. Read-only intent alone does not prove REDO survives in this codebase. Measure U/REDO before the prompt becomes eligible, after No, after Yes, and after cancelling the later preview. Finding 3 separately identifies the missing state refresh after history changes.

   Opus's dependency on save-time stamping is valid, but slice 4 does not fully satisfy “every save” (finding 11). Read-only drawings are removed from Pending at `PipeObjectUpgradeOnOpenService.cs:106`, so neither prompt nor OFF banner is shown there; this limitation was not mentioned in the original review.

9. **#2017 — FIX FIRST: banner still gives no usable upgrade instruction (P2).**

   At the current #2017 tip, `Modules/Drainage/Services/OldProjectPolicy.cs:26` and `:54` no longer tell the drafter to run CDDISCIPLINE and reopen in AutoCAD 2027. Opus's specific wording finding has been partially addressed. They now say only “Upgrade it or turn Civil ON”, without naming “Upgrade this drawing” or CDUPGRADEDRAWING. The required toggle is not delivered, so a drafter still lacks a precise action from the banner. The No message also retains the false “Nothing ... changed” claim.

   The banner itself is read-only in source: `Modules/Drainage/Services/OldProjectOpenPrompt.cs:65` reads record/tag/stamp; `:80` only reports it. It does not unlock a layer or edit a reference. It is gated by `OlderProjectBanner` at `:57`. No visual result, darkness/lightness or clipping was tested. The current #2018 has not inherited this wording change and still carries the older CDDISCIPLINE instructions.

10. **#2018 — FIX FIRST: the common open action is still missing; the old Merge/Replace cancellation finding is addressed.**

    The open Yes path is still finding 7. Current `Modules/Drainage/Commands/UpgradeDrawingCommand.cs:85` asks Merge/Replace before backup at `:99`, Civil ON at `:113` and conversion at `:116`. Cancellation returns at `:94`. `Modules/Drainage/Commands/LinkCommands.cs:935` consumes the preset. Opus's original claim that this cancellation comes after pipe conversion is no longer true at `328e2fb5`.

    Preview Cancel is the default (`UpgradeDrawingCommand.cs:226`), with non-OK returning false. That is source evidence only. The whole command is not an atomic rollback on later failure: Civil ON is committed before the conversion, the conversion has its own committed work, and CDUPGRADE catches its own errors at `LinkCommands.cs:1126`. The done text at `Modules/Drainage/Services/OldProjectPolicy.cs:130` always starts “Upgrade done”, and at `:136` wrongly attributes any incomplete record step to cancelled Merge/Replace, even though that question has already completed. An exception during the record refresh can therefore be described as a cancellation after partial work (P2, new finding).

    The final stamp result at `UpgradeDrawingCommand.cs:141` is only logged, not included in the user's done message. The promised “U once” at `OldProjectPolicy.cs:137` remains NOT proven. The backup copies the last saved file (`PipeObjectUpgradeService.cs:250`); it does not contain unsaved edits, which the command correctly warns about at `UpgradeDrawingCommand.cs:108`.

11. **#2018 — FIX FIRST: “every save stamps the version” is not implemented (P2, new finding).**

    `Modules/Drainage/Services/ProjectDataService.Persistence.cs:1450` and `:1543` stamp only when CE writes its project record. The save hook at `Modules/Drainage/Services/LinkService.cs:1260` checks whether a CE record save is waiting; `:1271` returns when no record work is owed. There is no separate version-stamp write on that path.

    Concrete case: open an old CE drawing with the open question switched off, make only an ordinary AutoCAD change that leaves CE's record unchanged, then QSAVE. With no pending CE record save, the drawing can remain unstamped and be asked about again when the question is enabled. This does not meet decided point B's “every save”. Conversely, a CE record write can stamp before a file save or before all conversion work is complete. A CE-version stamp is therefore not proof that every pipe was upgraded; do not use it as such in user-facing wording.

    The baseline diff really adds four write-operation entries under seven existing hooks, plus its review comment: 29 added lines, including 28 operation entries. `OldProjectStampStore.cs:84` reuses the caller's transaction; `:113` guards the save-time stamp and adds no lock of its own. That supports the narrow “no new transaction here” claim, not a general REDO PASS. The pending OFF guard still has finding 3's stale-memory dependency. No baseline was changed by this review.

12. **Settings audit — FIX FIRST across the four slices: file keys exist, visible switches do not (P2, new finding).**

    All four defaults are explicitly true in `Modules/Drainage/Models/UserSettings.cs`: CivilOffPerDrawing at `:2491`, AskAboutOlderProjectsOnOpen at `:2502`, OlderProjectBanner at `:2515`, OneUpgradeAction at `:2525`. OldProjectBeforeVersion at `:2506` defaults to `3.0.89`. These line numbers use #2018; the earlier additions have the same positions.

    No matching property/key occurs in the slice-4 Dialogs or ViewModels trees. The existing AdvancedSettings view model uses explicit draft/load/save properties, not an automatic editor for every OptionSettings property. These PRs add JSON configuration and tests, not a switch the drafter can click in Settings. Supply the visible control, default and OFF explanation for each behaviour through the established Settings workflow.

    Civil OFF support false: the Off choice disappears and OFF reads as Unknown (`DrawingDisciplinePolicy.cs:180`, `DisciplineCommand.cs:42`). Existing cached OFF state is not immediately recalculated, so the documented old behaviour is not assured for an already-open drawing after a settings change; reopening/reinitialisation and strict-reader errors need checking.

    Ask-about-old-projects false: no question; the old pipe-open path resumes (`OldProjectOpenPrompt.cs:43`, `:92`). It also requires CivilOffPerDrawing true. The threshold has no separate ON/OFF switch; it is a parameter of this behaviour.

    Older-project-banner false: no extra banner/discipline upgrade-needed words (`OldProjectOpenPrompt.cs:57`, `:67`). The base Civil OFF notice still appears. This source switch is coherent.

    One-upgrade-action false: the new command declines (`UpgradeDrawingCommand.cs:35`), the startup ribbon omits the button (`CeCvlRibbonContributor.cs:175`), and record-write stamping stops (`OldProjectStampStore.cs:117`). The open Yes route and its direct stamp still run because they do not consult this switch. The ribbon requires restart to reflect a changed value. This is not an OFF switch for all new upgrade behaviour.

13. **Locked layers, Xrefs and REFEDIT — what was actually established.**

    Opus left CDUPGRADE's locked-layer record path untraced. It reaches RegisterPit/ClearPitPipeLinks at `Modules/Drainage/Commands/LinkCommands.cs:1084` and `:1085`, then `LinkService.Persistence.cs:1034` and `:1084`. The latter calls SkipRecordWriteOnLockedLayer at `:1091` before obtaining a writable dictionary. REFEDIT is refused at `:1184`; existing locked entities are refused by the layer rule at `:1205`; WriteXrecordString tolerates the null dictionary at `:1365`. This supports “no locked-layer record write” for that route, rather than treating the missing check in RegisterPit alone as a defect.

    Pipe conversion checks locked participants before conversion at `Modules/Drainage/Services/LinkService.PipeObjectUpgrade.cs:125`. Identity writes use `LinkService.NewPipeIdentity.cs:45` and `LinkService.Spine.cs:735`, which refuse locked layers, REFEDIT and external/overlay owners. CDUPGRADE scans host model space at `LinkCommands.cs:968`, not the contents of external block definitions. The new command's explicit REFEDIT protection is at `UpgradeDrawingCommand.cs:189`.

    The `IsLocked = false` match at `LinkService.Geometry.cs:1022` is an empty OwnerMatch data value, not an unlock of a LayerTableRecord. No new layer-unlock operation was found in these PRs. Do not report that search hit as an unlock.

    These are bounded source checks, not proof of every transitive operation or native enabler. Pit block migration redefines shared definitions, so it can change the appearance of references on locked layers without unlocking their layers; its OFF/pending-question hole remains blocking where described above. Reference-edit handling and native Xref safety still require real host tests on synthetic copies. No such content was opened or changed in this job.

14. **Save prompt, drawing writes and file saves are different facts.**

    I found no new SaveAs call, queued QSAVE or DBMOD-reset operation in the four changes. Backup uses File.Copy to a distinct PRE_C7 name. Writing the OFF mark, version stamp or CE record changes the open drawing; it is not itself saving the original DWG to disk.

    The existing close hook at `Modules/Drainage/Services/LinkService.cs:1385` can flush a waiting record before the save question; `:1407` leaves other unsaved changes to that question. Slice 4 adds its stamp to that existing record transaction. There is no basis here to claim “CE silently saves the original file”, nor to certify that every Save/Close/Cancel route preserves the prompt. Stale OFF memory can allow record writes, and the real close/Undo/REDO result is NOT proven.

15. **Evidence, limitations and handoff.**

    Read: gh pr view and gh pr diff for #2015–#2018; the named card, decision and Opus review; relevant product source and the new tests' assertions; the seven REDO baseline additions; Settings bindings/search results; the one-page editor/theme references and relevant Settings/Repair design-pack material. Older design material does not override the approved 4 November card. The theme actually lives at Modules/Drainage/Themes/CivilEditorShellTheme.xaml.

    Built: no. Tested: no — 0 executed, 0 passing/failing results claimed. The PRs' historical build/test counts were not repeated. No three-lane compilation, full Civil suite, message-box execution, off-screen render, AutoCAD, robot, drawing-copy test, installed-build inspection or acceptance run occurred. This was the authorised read-only review, not a fix or UI implementation job. Notion was not consulted; the named Git plan and decision were the authority.

    The next verification must cover saved OFF reopen, untagged old open before answering, No/Enter/Escape/Cancel, both Undo/REDO directions around OFF and ON, native grips, every CE command route, ordinary QSAVE with no pending CE record, close Yes/No/Cancel, reference editing and locked/Xref participants. Use synthetic copies under a separate authorised host-testing job. No test request is being handed to Tim to perform.

    Git/workspace: fetched origin first in the code repository, created the clean own branch codex/n1-civil-off-review-20261105 under C:/CE_WORK/build/n1-civil-off-review from origin/master at 650c0c19, fetched again and merged origin/master (already up to date). No uncommitted work existed in this new worktree to take over. Other chats' unsaved main-checkout and CE_PLAN files were not taken over or staged. PR source was read at pinned Git objects, not merged into the review worktree. CE_PLAN was fetched before writing this named report. A review-only REGRESSION_LOG entry preserves all earlier text on the own branch.

    Shared/CE_SHARED, Structural and Manager have no changes in the reviewed cumulative product diff. This job changed no product code, prohibited file, live bundle or PR state. No fixes or PR-branch pushes. The named report is the handoff and evidence record; fixes remain for the owning builders. Undo of this review is removal/reversion of its report and review-only log entry, with no drawing recovery required.
