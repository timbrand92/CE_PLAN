# Opus pre-review FILL_EDIT: PRs #1417, #1328, #1430, #1429 and #1176 (queue filler 6)

Written Monday 2 November 2026, 03:07 Melbourne, by an independent read-only Opus reviewer for CE 05 at CE 00's request.
Current release tip checked: `claude/rel-20261108a` at cf059dcf (Civil 3.0.90, C-79b1), fetched at the time of review.
Heads reviewed: #1417 c9a1b94d, #1328 59255e05, #1430 46918bbd, #1429 8a39c193, #1176 ee555ea9. All five are DRAFT and still open on GitHub.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the PR diffs, the carpark entries and the code as it stands on the current tip. I ran read-only `git fetch`, `git ls-remote`, `git log` and `git merge-tree` only. No test was run and no settings file was opened.

## FOR TIM

1. **The big finding: all five are already in your AutoCAD.** Each one was merged into a release train between 17 and 19 October. #1176 has been in since Civil 3.0.52, #1328 since 3.0.53, and #1417, #1429 and #1430 since 3.0.56. Merging any of them now would change nothing. The GitHub pages were simply never closed. Three of them (#1417, #1429, #1430) also had an Opus review fix round in October, so "no Opus pre-review" was not quite right.
2. **#1417, CDXREFREPAIR never re-points an Xref at the drawing itself, and asks you to save an unsaved drawing first (BUG-795): KEEP-WITH-NOTE, no train needed.** Example: in SITE.dwg, a broken Xref is saved as ..\Arch\SITE.dwg. Before, CE offered to point it at SITE.dwg itself. Now it says it could not find a replacement. If BASE.dwg is in two folders, CE picks the one whose folder names match the old path. It names the other folder, and Enter now means No. The robot and Codex have not tested it.
3. **#1328, grip, ROTATE and SCALE copies cleaned up like COPY (switch OFF), and erasing a copied pipe leaves the original's symbols alone (BUG-665/666): KEEP-WITH-NOTE, and the robot must check one thing first.** The second part has no switch. I think it can leave the copy's own twin barrels or band behind when you erase a copied pipe, if they were copied with it. I could not prove this without AutoCAD. If the robot sees that happen, it needs a small fix, and that fix would need the full test run.
4. **#1430, closing What CE Found keeps a selection you made while it was open (BUG-809 item 4): KEEP-WITH-NOTE, no train needed.** Example: you open the panel, click a row, then pick pit P5 yourself and close the panel. P5 stays selected. Before, CE put back your selection from when the panel opened. Codex's attempt on 23 October was blocked, so nobody has seen it work.
5. **#1429, CDTAG and CDFIXTAGS say a refused tag change in plain words (BUG-814 parts 1 and 2): KEEP-WITH-NOTE, no train needed.** Example: "CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed." The robot passed the CDFIXTAGS wording on 19 October (run 32). The CDTAG retag wording has still never been reached in AutoCAD.
6. **#1176, double-click on a pit label opens Edit Pit (BUG-430 item 1, switch OFF): CHANGE-NEEDED. Close the PR as replaced; do not rebase it.** Its switch was later renamed and widened to "double-click opens the Edit window", and #1923 built on top of it. Both are OFF by your 22 October ruling. Codex tested it with the switch ON twice (18 and 19 October). Both times AutoCAD's own attribute editor opened instead of Edit Pit. So it is still not fixed.
7. **Merging:** nothing to merge. Every PR's code is already on the current release line, so a merge would add nothing. The GitHub "conflict" on #1176 is only the top of the change log (REGRESSION_LOG.md). The fix would be to keep both entries, but it does not matter now. No test touched your real settings: the test project points CE at its own temporary settings folder.
8. **Bottom line:** built, unit-tested and installed, yes. Robot or Codex-accepted, no; only the BUG-814 CDFIXTAGS wording has a robot PASS. All five bugs stay OPEN in the carpark. CE 05 should close the five GitHub pages and send the robot the five checks under "AutoCAD scenario" below.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Already shipped.** `git merge-base --is-ancestor` puts every head inside `claude/rel-20261108a`. `git merge-tree --write-tree` of each head against the tip returns the tip's own tree (42e2f670), so a merge would add nothing. First trains to carry each head:
   1. #1176 ee555ea9: `claude/rel-20261018a`, C-41, Civil 3.0.52 (merge commit 84c7213e).
   2. #1328 59255e05: `claude/rel-20261018b`, C-42, Civil 3.0.53 (merge commit dfbd9b98).
   3. #1417, #1429 and #1430: `claude/rel-20261019a`, C-45, Civil 3.0.56 (merge commits ddf23c84, ad605c73 and f32612d6, 19 Oct 02:30).
2. **Earlier reviews.** #1417's second commit answers "Opus review 1253". #1429 and #1430 each carry an "Opus review PR 14xx, 19 Oct" fix round in their REGRESSION_LOG entries. #1176 and #1328 went through the C-41 and C-42 Opus finalizers. The brief's description, "no Opus pre-review", is not quite right for any of the five.
3. **Bases are stale.** The bases are rel-20261009w (#1176), rel-20261018a (#1328) and rel-20261018d (the other three). The release line is now at rel-20261108a. #1176 is 2 commits behind its base. The GitHub CONFLICTING flag comes from REGRESSION_LOG.md only (`git merge-tree` against rel-20261009w: one conflict, REGRESSION_LOG.md).
4. **Shared lines in this group.** No two PRs edit the same method. #1429 and #1430 both insert a new `LinkingSettings` property at exactly the same place in UserSettings.cs (after `PitLabelMaxDistanceMm`, line 467 on the base), so a pairwise merge conflicts there and in REGRESSION_LOG.md. #1417 conflicts with both only in REGRESSION_LOG.md. The train builders already resolved these as keep-both: all three properties are on the tip (UserSettings.cs:897, :1027, :1315).
5. **Real settings.** On these bases the test project has `SettingsIsolationSetup` (a SetUpFixture). It points `SettingsService` at `%TEMP%\ce-cvl-unit-settings-<guid>\CD_Settings.json` and the log at a temp folder, so no test in this group can read or write `%APPDATA%\TIM_CE_CADTOOLS`. #1328's tests do set `SettingsService.Current.Linking.CleanUpGripRotateScaleCopies` in memory. TearDown puts it back to false rather than to the earlier value. That is harmless because the default is false.
6. **Protected files.** #1328 touches `LinkService.Compound.cs` and `LinkService.Utilities.cs`. #1429 touches `LinkService.SourceChanges.cs`. None touches LinkService.Persistence.cs, ProjectDataService.Persistence.cs or RulebookEngine.cs. I read the LinkService lines with extra care (see #1328 Q4).

---

### PR #1417: BUG-795, CDXREFREPAIR (head c9a1b94d, base rel-20261018d, in C-45 / 3.0.56)

1. **What changes for the drafter.**
   1. **Unsaved drawing:** `BrokenXrefRepairCommand.cs:42-47` (PR lines). An unsaved drawing gets "save the drawing first, so CE knows which job folder to search. Nothing changed." Before, CE searched AutoCAD's working folder and could throw.
   2. **Host never offered:** `BrokenXrefPathRepairService.cs` (smart branch). A candidate equal to the host path is skipped (`SamePath`, full-path compare ignoring capitals).
   3. **Matching folder preferred:** `TrailingFolderScore` counts how many of the last folder names agree, ignoring `.` and `..`. A stored `C:\OldJob\Xref\BASE.dwg` now picks `C:\Job\Xref\BASE.dwg` over `C:\Job\BASE.dwg`. With no better match, the first folder still wins, as before.
   4. **Ambiguity shown:** the listing line adds "; the same file name also exists in: ... Check it is the right one" (`ListingLine`). The Yes/No prompt then defaults to No (`PromptAccept(..., defaultNo)`).
   5. **Against the carpark:** BUG-795 asks to "Exclude the host path; prefer the candidate whose trailing folders match and flag ambiguity instead of choosing; Save the drawing first". All three are met. "Instead of choosing" is met in spirit: CE still proposes one folder, but it names the others and Enter means No.
2. **Settings switch.** `linking.xrefRepairAvoidsHostAndPrefersMatchingFolder`, ON (UserSettings.cs, PR +8). No Tim ruling specifically on this key that I found. It follows the house pattern for a fault fix ("fixes a fault, so ships ON").
   1. **OFF behaviour:** OFF runs the old first-match loop unchanged, and `alsoExists` stays empty, so `ListingLine` equals the old line and the prompt defaults to Yes. **One unswitched difference:** the save-first line runs even with the switch OFF. The REGRESSION_LOG entry says so openly ("a plain protection and has no switch").
   2. **Defaults pin:** the PR pins it only with `new LinkingSettings()` (test `SwitchOnByDefault`). On the tip, `Bj34SettingsPersistenceTests` round-trips it through the Settings window, and `SettingsWindowV3Tests` / `Bj34CivilSettingsRowsTests` cover the row. **I found no test reading it through both start-up reads** (`DeserializeSettings("{}")` and `DeserializeSettingsTolerant`) as the C-75 to C-79 default tests do for newer keys. It reads ON from a missing key because the property initialiser is `true`, but that is not pinned. LOW.
   3. **R-00:** no engineering value involved.
3. **No hard blocks (R-27).** The save-first line is a stop, but nothing could sensibly be searched without a folder. It is a command-line line, not a modal window. Acceptable. Default-No on an ambiguous choice is not a block: typing Y still applies.
4. **Native protection and REDO.** The command re-points Xref paths, which is its whole purpose, behind a list and a Yes/No. The PR did not touch the apply step, Preview or relative-path code. No new write path, so no new REDO exposure. Not checked: what happens if CDXREFREPAIR is run during REFEDIT. That is unchanged by this PR.
5. **Merge.** Already merged (C-45). Pairwise with #1429 and #1430 only REGRESSION_LOG.md conflicts, and that was resolved keep-both on the train. No later commit touched either file (`git log c9a1b94d..tip` on both files is empty).
6. **Tests.** `BrokenXrefRepairHostTests` has 8 tests on the head. The REGRESSION_LOG entry still says "(5), 3 failed first". The 3 listing and ambiguity tests came with the review-1253 round, so the count in the log is stale. LOW. The "3 failed first" claim is the author's; I could not re-run it. The source-guard test only checks that two method names appear in the command file.
7. **Not proven, and the AutoCAD scenario.** Not run in AutoCAD by anyone (carpark: "not yet tested by robot or Codex"). net48 was not built at PR time, though it has since ridden 30+ trains. Robot scenario (copies only):
   1. Host `C:\ce-fx\<job>\SITE.dwg` with a broken Xref whose saved path is `..\Arch\SITE.dwg`. CDXREFREPAIR: expect it to report no replacement, and never offer SITE.dwg.
   2. BASE.dwg in the job folder and in `Xref\`, with the stored path ending `\Xref\BASE.dwg`. Expect the `Xref\` copy offered, the other named, and the prompt default `<No>`. Press Enter: nothing changes.
   3. A new unsaved drawing with an Xref: expect "save the drawing first" and no error.
   4. Switch OFF (set before AutoCAD starts): case 2 offers the first folder with default `<Yes>`.
8. **Verdict: KEEP-WITH-NOTE.** Notes: correct the REGRESSION_LOG test count when next touched, add a both-start-up-reads pin for the key, and close the PR on GitHub as already merged. Train class: none now. Any follow-up is Civil area + smoke.

---

### PR #1328: BUG-665 / BUG-666, grip, ROTATE and SCALE copies, and erasing a copied pipe (head 59255e05, base rel-20261018a, in C-42 / 3.0.53)

1. **What changes for the drafter.**
   1. **Switch ON only (`ExternalMutationCommandPolicy.cs`, `TransformCommandsThatCanCopy`):** a pit or pipe made by a grip Ctrl-copy, ROTATE Copy or SCALE Copy gets COPY's clean-up: its own number, schedule row, labels and no link to the original. A plain grip move or rotate that adds nothing is left alone (`ShouldReconcileCloneCandidates(cmd, 0)` is false).
   2. **Always on, plain COPY too (`LinkService.Utilities.cs` `RemapClonePipe`, tip lines 856-859):** a copied pipe's four partner links (breakline symbol, second breakline symbol, other half of a rising main, same-plan partner) follow only items copied with it. Otherwise they are cleared (`CloneLinkHandles.RemapOrClear`).
   3. **Always on (`LinkService.Compound.cs` `Take`, tip line 214, and `IsMemberOfAnotherPipe`, tip 264-275):** erasing a pipe skips any listed member whose owner record names a different pipe.
   4. **Against the carpark:** BUG-665 expects "the copy gets the same clean-up a COPY gets". Met behind an OFF switch. Tim's 29 Oct confirmation of ROTATE Copy came through the later #1831 switch `rotateScaleCopyLikeCopy`, not this one. BUG-666 expects "only members whose owner tag names the erased pipe are erased". Met in a softer form: untagged members are still erased.
2. **Settings switch.** `linking.cleanUpGripRotateScaleCopies`, OFF. It is OFF because the pinned `LinkServiceCommandPerformanceContractTests` says these commands never look for copies. On the tip it is pinned OFF through both start-up reads (`C75NewSwitchDefaultsTests.cs:161`, `C76...:159`, `C77...:380`, `C78...:185`), and it has a Settings window row (`CivilSettingsView.xaml:288`). OFF restores the old list exactly (`CanCreateClones` falls back to `CloneCapableCommands`). **Parts 2 and 3 have no switch.** They change plain COPY and ERASE for everyone. The author argues they "only stop a wrong erase"; see Q4 for why part 3 may not be that simple. No engineering value involved.
3. **No hard blocks.** None added.
4. **Native protection, REDO, protected files (extra care).**
   1. **Locks and Xrefs:** `SafeEraseHandle` still runs `IsSpineWritable`, so locked or Xref members are still never erased. The new check only reads.
   2. **REDO:** the erase cascade runs in its own transaction inside the erase's undo group (unchanged). The new owner read opens objects for read only.
   3. **The risk (PLAUSIBLE, not proven).** AutoCAD COPY deep-clones a member's extension dictionary, so a copied band, twin barrel or breakline symbol keeps an owner record holding the ORIGINAL pipe's handle as plain text (`WriteAttachmentOwner` stores it as `DxfCode.Text`, `LinkService.Persistence.cs:583-606`). I found no step in the COPY clean-up that rewrites that owner on copied pipe members. `RemapClonePipe` remaps the handles on the pipe's own record only. `OnBeginDeepCloneTranslation` (Utilities.cs:1251) only notes the map. The `WriteAttachmentOwner` callers are moves, splits, registration and repair, none in the clone path.
      - **What could go wrong:** COPY a pipe together with its band or twin barrels, then ERASE the copy. `RemapClonePipe` correctly points the copy at its own copied band. But `IsMemberOfAnotherPipe` reads that band's owner as the original pipe and skips it, so the copied band or barrels stay behind as loose objects.
      - **Who carries an owner record:** twin barrels do (comment at `LinkService.Compound.cs:115-118`, "carry an exact attachment-owner record back to the centreline"). Bands replaced after a native edit do (`PipeMoveHelpers.cs:745`, `:843-846`, `:954`). A band from first draw may not; I could not confirm.
      - **Before this PR:** the copy's own copied band was erased with it, because `Take` checked no owner.
      - **What the fix would be if confirmed:** at COPY clean-up, rewrite the owner record of each mapped band, barrel and glyph to the copy's handle. Better still, check "owner names another pipe AND the copy's record does not list it as its own mapped member".
   4. **Is part 3 still needed?** Part 2 already stops new copies pointing at the original's members. Part 3 only protects pipes copied BEFORE 3.0.53.
5. **Merge.** Already merged (C-42). Later commits on the same files: 6f7736c5 (#1831, BUG-665/672 ROTATE/SCALE Copy labels) and 1bd133b9 (C-42 finalizer). Both are on the tip. No conflict with the other PRs in this group except REGRESSION_LOG.md.
6. **Tests.** `CopyOfAPitOrPipeKeepsNoIdentityTests` has 24 cases ("12 red first", the author's claim). The policy tests are pure. The two "erase" and "remap" proofs are source guards: they check that `IsForeignMember` and `CloneLinkHandles.RemapOrClear(data.<field>` appear in the file, not what happens to the drawing. No test covers the copied-band-with-stale-owner case in Q4.3.
7. **Not proven, and the AutoCAD scenario.** Robot evidence on 25 Oct (3.0.75, R34) covers COPY, ROTATE Copy and SCALE Copy labels only. Nobody has run ERASE of a copied pipe (carpark BUG-666: "not yet tested by robot or Codex"). Robot scenario, in priority order:
   1. **Q4.3 check first.** Draw a twin-barrel (or detention) pipe and, separately, a normal pipe with a band. COPY each with a crossing window that takes the band, barrels and labels. ERASE the copy. Expect every copied band and barrel gone, and the original untouched. Read the object count before and after.
   2. COPY one half of a rising-main or same-plan-break pipe, then ERASE the copy. The original's breakline symbol, band and barrels must stay.
   3. With `cleanUpGripRotateScaleCopies` ON (set before start-up): a grip Ctrl-copy of a pit gives a new number and a schedule row. Then U once: the copy and its clean-up go together. Then REDO.
   4. With the switch OFF, a plain grip STRETCH of a pit: no copy-discovery log line.
8. **Verdict: KEEP-WITH-NOTE.** It is already shipped. Robot check 7.1 must run before BUG-666 can be called fixed. If 7.1 leaves loose bands or barrels, this becomes CHANGE-NEEDED: rewrite the owner on mapped copied members at COPY clean-up (Q4.3). Train class for that follow-up: Civil + FULL, because the erase cascade runs on every pipe erase.

---

### PR #1430: BUG-809 item 4, What CE Found palette close (head 46918bbd, base rel-20261018d, in C-45 / 3.0.56)

1. **What changes.** `DrawingCheckPaletteService.cs` notes the handles the palette itself selected to show a row (`ShownByPaletteHandles`, set in `ShowSelectedItem`, cleared in `ClearHighlight`). On close, `RestoreOriginalSelection` reads the current pick-first selection (`SelectImplied`). It puts back the opening selection only when the current one is empty or exactly the palette's own (`PaletteSelectionRestorePolicy.ShouldRestore`). This matches the carpark: "palette close leaves the selection alone".
2. **Settings switch.** `linking.paletteCloseKeepsYourSelection`, ON. OFF makes `ShouldRestore` return true at once, which is exactly the old outcome; the extra selection read is harmless. On the tip: Settings window row, `Bj34SettingsPersistenceTests` round-trip, and `UneditedNewRowPreservesAValueChangedWhileWindowWasOpen` (which uses this key). **Not pinned through both start-up reads**, the same LOW gap as #1417. No engineering value involved.
3. **No hard blocks.** None.
4. **Native protection and REDO.** Selection only; nothing in the drawing changes. If `SelectImplied` fails (for example on a close outside document context), the catch empties the list, so CE restores the old way. That fails safe to old behaviour.
5. **Merge.** Already merged (C-45). Against #1429: UserSettings.cs (same insertion point) and REGRESSION_LOG.md. Resolved keep-both on the train. No later commit touched the two service files.
6. **Tests.** `PaletteSelectionRestorePolicyTests` (6). The log says honestly: "Written with the change, not run red first." The policy tests are pure. The wiring is a source guard. Nothing proves that `SelectImplied` returns the drafter's selection at palette close time.
7. **Not proven, and the AutoCAD scenario.** Codex W5-06 was BLOCKED on 23 Oct ("the row clicked was not a drawing object"). Robot scenario:
   1. Select pit P1 and run CDCHECKCURRENT.
   2. Click a row that names a real pit or pipe; check it highlights.
   3. Pick pit P5 with the mouse, close the palette: P5 is still selected.
   4. Repeat without picking anything: P1 is selected again.
   5. Repeat after pressing Esc to clear: P1 comes back (by design).
8. **Verdict: KEEP-WITH-NOTE.** Close the PR as merged and add the start-up-read pin. Train class: none now. Any follow-up is Civil area + smoke.

---

### PR #1429: BUG-814 parts 1 and 2, plain refusals (head 8a39c193, base rel-20261018d, in C-45 / 3.0.56)

1. **What changes.**
   1. **The message itself:** `LinkService.SourceChanges.cs:243` adds the tag to the refusal ("The requested source tag WT2 is not unique in the drawing.").
   2. **The plain-words line:** `SourceChangeRefusalText.Plain` turns that refusal, and the "spine identity" one, into plain words. CDTAG uses `SourceTagNameFreeRule.UsedNameLine`, the same words the untagged route already printed.
   3. **CDFIXTAGS:** `SourceTagRepairCommand.cs:179,187` uses the non-CDTAG wording ("WT2 is already on another source, so CDFIXTAGS left this block as it was.").
   4. **CDTAG:** `SourceTagCommand.cs:172,195` replaces the generic "stopped before its tag transaction committed" line.
   5. **Against the carpark:** matches parts 1 and 2 ("Plain words naming the tag; the same refusal wording on every route"). Parts 3 and 4 were left out, and the PR says so.
2. **Settings switch.** `linking.sourceTagRefusalsInPlainWords`, ON. **OFF is not byte-exact:** the raw exception text now carries the tag (SourceChanges.cs:243 is unswitched). With OFF, CDFIXTAGS shows "The requested source tag WT2 is not unique in the drawing." where it used to show the same sentence without "WT2". This is harmless and arguably better, but OFF does not give exactly the old words. LOW. Pins: Settings row and Bj34 round-trip on the tip; **not pinned through both start-up reads** (same LOW gap). No engineering value involved.
3. **No hard blocks.** These are refusals that already existed. The PR only changes their wording, and none is a modal window.
4. **Native protection, REDO, protected file.** `LinkService.SourceChanges.cs` is a LinkService file: one string at line 243, no logic change. Nothing else writes to the drawing.
5. **Merge.** Already merged (C-45). Later commits on the same files reworded further: 0ea77f4b (BUG-927), 4d4b9b9c (BUG-917/934/942/943), ce977899 and 66744813 (BUG-813, "another kind of object"), and 3563aa9d/3df1f44d (BUG-859 and the source Edit window). The tip's `SourceChangeRefusalText.cs` now has extra branches (lines 39-43). This PR's own lines are intact.
6. **Tests.** `SourceChangeRefusalTextTests` (8 on the head). The log says "not run red first". The text tests are pure. Wiring is checked by a source guard, including an exact-text match on SourceChanges.cs:243.
7. **Not proven, and the AutoCAD scenario.** Robot run 32 (3.0.56): part 2 PASS. Part 1 (CDTAG retag of an already-tagged source) is still UNPROVEN, because pick-first CDTAG skipped the retag route (BUG-821). Robot scenario:
   1. Two source blocks tagged WT1 and WT2. Run CDTAG with NO pick-first, pick WT1, retag to WT2. Expect "CDTAG: WT2 is already on another source. Choose a different number. Nothing was changed." and no change.
   2. The same with the switch OFF: the older wording.
8. **Verdict: KEEP-WITH-NOTE.** Notes: OFF is not word-exact (the tag appears in the raw sentence); add the start-up-read pin; close the PR as merged. Train class: none now. Any follow-up is Civil area + smoke.

---

### PR #1176: BUG-430 item 1, pit label double-click (head ee555ea9, base rel-20261009w, in C-41 / 3.0.52)

1. **What changes.** `CompoundEditModeService.cs` adds EATTEDIT to the watched commands. Behind `doubleClick.pitLabelOpensEditPit` (OFF), an EATTEDIT that a double-click started within 1.5 seconds is treated like the PROPERTIES one and sent to Edit Pit. A typed EATTEDIT, the ribbon and Ctrl+1 keep AutoCAD's editor. Tim's G2 ruling of 17 Oct asks for exactly this ("double-click any CE object opens its Edit window").
2. **Settings switch: superseded on the tip.** `Models/DoubleClickSettings.cs` on the tip has `opensEditWindow` (OFF, `OpensEditWindowDefault`), covering every newer double-click kind. It reads the old `pitLabelOpensEditPit` key once through a write-only private setter (`LegacyPitLabelOpensEditPit`) that is never written back. #1923 then added `pitLabelStopsAttributeEditorFirst` (OFF, Tim 22 Oct "stays OFF until Codex has looked"). Both are pinned OFF through both start-up reads (`Bug430PitLabelStopsAttributeEditorTests.cs:57-105`, `C79b1NewSwitchDefaultsTests.cs:57`). **Gap:** no test reads a file holding only the old key `pitLabelOpensEditPit: true` and checks that `OpensEditWindow` comes out true. LOW. With OFF, the PR returns before touching the double-click note, and EATTEDIT was not watched before, so OFF was exactly the old behaviour.
3. **No hard blocks.** None. It swaps one window for another, and only after a double-click.
4. **Native protection and REDO.** Opening Edit Pit writes nothing. The tip's later code adds explicit locked-layer, Xref and REFEDIT exemptions (DoubleClickSettings doc comments, `CompoundEditModeService.cs:1045-1049` log lines). Nothing here needs REDO care.
5. **Merge, and how the GitHub conflict would be resolved.** GitHub shows CONFLICTING because rel-20261009w moved 2 commits after the PR was cut (1f7495c9 C-36 finalizer, 2388c329 version 3.0.46). `git merge-tree` shows the only conflict is REGRESSION_LOG.md, at the top of the file. The resolution would be keep-both: the BUG-430 entry, then the C-36 finalizer entry. **But do not do it.** The head is already in the tip (84c7213e, C-41), and its key and gate have since been reworked. Rebasing or re-merging would at best change nothing, and at worst bring the narrower `PitLabelOpensEditPit` code back beside `OpensEditWindow`.
6. **Tests.** `PitLabelDoubleClickTests` (5; "did not compile before", so they were red by construction) are still on the tip. Gating only; the author says the proof needs a driver run.
7. **Not proven, and the AutoCAD scenario.** Codex look L4 with the switch ON failed twice (18 Oct on 3.0.54, 19 Oct on 3.0.56): AutoCAD's Enhanced Attribute Editor opened, not Edit Pit. The carpark entry is OPEN, and the follow-up is #1923 (B-110). Any new robot or Codex run belongs to the #1923 lane, with both `opensEditWindow` and `pitLabelStopsAttributeEditorFirst` ON (set before start-up):
   1. Double-click the P8 pit label: expect Edit Pit only.
   2. Type EATTEDIT and pick the label: expect AutoCAD's editor.
   3. Put the label on a locked layer and double-click it: expect AutoCAD's editor.
8. **Verdict: CHANGE-NEEDED. Close #1176 as superseded and already merged; do not rebase it.** Optional LOW follow-up: a test that the legacy key carries over. Train class: none.
