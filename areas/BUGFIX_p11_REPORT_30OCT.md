# BUGFIX p11 report: BUG-1246, a copied downpipe keeps the original's tag (Fri 30 Oct 2026, 21:05 to 23:00 Melbourne)

## ANSWER FIRST

1. **Draft PR #1891**, titled "B-071 BUG-1246: a copied downpipe is given its own next tag". The register already names B-071 for BUG-1246 (item 94), so the title uses it. Base `claude/rel-20261102a`, branch `fb/bug1246-copied-downpipe-new-tag`, commit `7e19a867`.
2. **Stacking:** #1867 (B-049a) is "not yet built" in its own title, but its three commits are already inside `claude/rel-20261102a` (merge "3c75396c Merge PR #1867"), so there was nothing to stack on: I branched from the C-78 line and targeted it. B-009 (the grip, ROTATE and SCALE copy clean-up) is on that line too. No file clash with #1867.
3. **Built and unit-tested. Nobody has opened this in AutoCAD.** BUG-1246 is not marked fixed.

---

## FOR TIM

1. **What you will see differently.** Copy + Rotate (CR) of downpipe DP2 now gives the copy the next free number, DP3 (the same number New DP would give), with its own plan label beside it. One line says so: "The copied downpipe was given its own tag DP3 (the original stays DP2). Check where it connects." Before, the copy stayed DP2 and the line said it "could not be given its own link on this AutoCAD".
2. **Why it happened.** When a downpipe is copied on its own, CE could not finish its clean-up and left the copy exactly as AutoCAD made it, tag and all. The pits and pipes were fine; the downpipe never got a new tag.
3. **What to check in AutoCAD (the robot will do this; a Codex look is needed for the label):** place DP1 and DP2, run CR on DP2, then read the copy's tag in the CE Inspector. Right = DP3. Wrong = DP2 again. Then undo the CR: the copy and its label go together.
4. **What I did NOT prove.** Nothing here has run in AutoCAD. Two things I cannot promise: (a) the copy is not yet joined to any pit or pipe (I deliberately cleared the copy's links to the original's pit and pipes, so it is a clean, unjoined downpipe until it is placed or joined); (b) the new label sits a fixed distance up and right of the copy, it is not turned with the rotation.
5. **My mistakes, first.** (a) My first build wrote the copy's own pit link directly and could create the GUIDELINES layer; two existing safety tests (the pit-owner guard and the REDO-hook list) caught both. I removed the layer creation (the copy's label now goes on the same layer as the original's, nothing is created) and re-ordered the link write. Cost: one extra full test run of about 10 minutes. (b) I started one wait in a background job that died when the call ended: about 10 minutes lost.
6. **Settings files (your rule): two real files changed during my run. I am saying it first.** See "Settings listings" below. Both files are in `%APPDATA%\TIM_CE_CADTOOLS`. CD_Settings.json changed at 22:48:26 and AutoCAD (acad.exe) started at 22:48:30, four seconds later: that is the robot lane writing a setting before it launches, not my tests. CD_RecentValues.json changed at 21:53:36, a time at which I was only waiting for a build slot (no test of mine was running). I cannot prove that none of my test runs touched them, only that the times match something else. The Structural settings file did not change; the Civil settings.json did not change.

---

## TECHNICAL DETAIL

### Cause and entry point (confident, read from the code, not run)

1. `LinkService.ReconcileClones` (`Modules/Drainage/Services/LinkService.Utilities.cs`, the BUG-1137 step, about line 228): a copied downpipe whose exact AutoCAD copy record is missing (`CloneSourceCopyRule.CanBeCompleted` false) is removed from the clean-up and "left as AutoCAD copied it". The copy carries the original's tag in its extension dictionary, so it is a second DP2. This is exactly the line Tim pasted (hand check H39).
2. Compare the complete path `RemapCloneSourceInTransaction` (`LinkService.SpineClones.cs`): it already does `AllocateNextTag`, clears the label and hit-box references, `SetTag`, a fresh identity key and its own label. That path only runs when the copy record exists.

### The change

1. New `Services/LinkService.CopiedSourceOwnTag.cs` (`GiveCopiedSourcesOwnTag`): for each leftover copy, in its own transaction: refuse if not writable (`IsSpineWritable`: locked layer, Xref, REFEDIT), or the original is erased (a MIRROR that erased it hands the tag on); `SourceTagService.AllocateNextTag` (New DP's rule); clear the label and hit-box references; `SetTag`; `AssignFreshSpineKeyToClone`; record names itself (`PitHandle` set to the copy's own handle, attachments, pipes and pit association cleared); own label on the original label's layer with text from `GetSourceNumberingMode` (item 77: plan label plain, number in the tag); `RegisterSourceBlockInTransaction`; read the tag back; commit. A failure writes nothing for that copy and the old line still says it.
2. New `Rules/CopiedSourceOwnTagRule.cs`: the switch read and the one command-line line.
3. `LinkService.Utilities.cs`: the BUG-1137 step now collects the leftover copies, and when the switch is ON gives them tags; the old "left as AutoCAD copied" line now counts only those that could not be tagged.
4. **Switch** `linking.copiedDownpipeGetsOwnTag` in `UserSettings.cs` (documented "Default: on."), JSON `copiedDownpipeGetsOwnTag`. OFF = the old behaviour exactly: nothing subtracted, the old line counts every leftover. Not on the Settings page (the neighbouring `copyContinuesWhenDownpipeCannotFollow` is not either). Not pinned in a CxxNewSwitchDefaultsTests class (the C-78 one is the finalizer's); pinned in my own test class through both start-up reads instead.
5. `REGRESSION_LOG.md` entry added. `RedoSafeReviewedHooks.baseline.txt`: six reviewed lines (two reaches times the three command-end hooks) with the REDO gate written beside them.
6. REDO-safe: the write sits inside `ReconcileClones`, after `RedoHistoryCommandEndRule.MayWriteAtCommandEnd`; no new layer, command, regen, view or system variable change.

### Tests

1. `Bug1246CopiedDownpipeOwnTagTests` (8 tests): the line (one, several, none); the switch ON for `{}` and a C-77-shaped file through both `DeserializeSettings` and `DeserializeSettingsTolerant`; typed false turns only itself off and the neighbours stay ON; the write is called from one place, behind the switch, with the OFF arithmetic intact; the source never unlocks, never creates a layer, commits once per copy.
2. Focused net10 run (Bug1246, Bug1137, Bug1227, every NewSwitchDefaults class): 265 passed, 0 failed (count not 0).
3. Full Civil net10 suite (final run): 21,538 passed, 32 skipped, 2 failed (the PDF page test and the real-window render test, both need AutoCAD's renderer under load); re-run alone with `--no-build`: 3 of 3 passed. The first full run had 2 other failures (the pit-owner guard C7BuilderPitOwnTests and the REDO-hook guard), both fixed as above.
4. Drainage net48 Release compile: 0 errors.
5. Builds ran at below-normal priority, one at a time, always `-p:SkipDevBundle=true -nr:false --disable-build-servers`, TEMP, logs and Structural root redirected to `C:\ce-scratch\p11`. I ran no Manager tests and no Structural tests. Worktree: `C:\ce-fx\p11` (placeholder 0-byte arx, untracked).

### Settings listings (names, times, sizes only)

Before (21:05) and after (22:55). Only the files that exist are listed; `%APPDATA%\CE_SUITE` does not exist.

1. `CE_STRUC_SUITE\CS_Settings.json`: 2026-10-30 19:54:14.577, 35613 bytes. Unchanged.
2. `CE_CVL_SUITE\settings.json`: 2026-09-16 12:13:17.038, 672 bytes. Unchanged.
3. `TIM_CE_CADTOOLS\CD_Settings.json`: before 2026-10-04 08:22:30.000, 15270 bytes. **After 2026-10-30 22:48:26.217, 15357 bytes. CHANGED** (acad.exe started 22:48:30).
4. `TIM_CE_CADTOOLS\CD_RecentValues.json`: before 2026-10-30 21:03:50.996, 11947 bytes. **After 21:53:36.372, 11948 bytes. CHANGED** (not during any run of mine).
5. `TIM_CE_CADTOOLS`: CD_ProjectData.json (2026-01-27 12:06:06, 8278), CS_Settings.json (2026-03-31 13:18:00, 351713), jobtime_resume.json (2026-01-14, 314), label_styles.json (2026-04-28, 526), parts_catalogue.json (2026-09-15, 5910), theme.json (2025-12-19, 1390). All unchanged.

### What is NOT proven

1. Everything in AutoCAD: the tag, the label, Undo, save and reopen.
2. That Tim's CR really takes the "no copy record" route (his pasted line says it does) on every AutoCAD version. If a copy record IS complete and the downpipe is rotated, the complete path refuses it ("not a qualified translation", `RemapCloneSourceInTransaction`) and the whole clean-up for that command is abandoned. Suspect, not tested; the robot case below will show it.
3. What happens to the copy's connection to a pit afterwards (CDSYNC or CDCHECK behaviour on the unjoined copy).
4. The label's position on a rotated copy, and no label at all when the original had none.

### Robot case

1. **`N38_dp_copy_tag`** (working title; CE 02 renumbers). Fresh drawing with a few pits and pipes. Type New DP twice so DP1 and DP2 exist. Run CR, select DP2 only, base point on it, a destination 5 m away, rotate 90 degrees. Check: (a) the command line contains "The copied downpipe was given its own tag DP3 (the original stays DP2)"; (b) the CE log contains "[BUG-1246] copied downpipe" with "own tag DP3"; (c) the copy's tag read through the driver or Inspector is DP3 and the original's is still DP2; (d) no line "could not be given its own link". Then U: the copy is gone and DP2 is still the original's.
2. **Control `C38`** (switch OFF): set `linking.copiedDownpipeGetsOwnTag` to false in Settings BEFORE launching AutoCAD (settings are read at start), then the same steps. Expected: the old line "could not be given its own link on this AutoCAD" and the copy's tag reads DP2 (two DP2). If C38 shows DP3, the case is not testing this change.
3. Also add to the run: CR with the base point off the downpipe, and a locked GUIDELINES layer (expected: copy stays DP2 with the old line, nothing unlocked).

### Files

`Modules/Drainage/Models/UserSettings.cs`, `Modules/Drainage/Services/LinkService.Utilities.cs`, new `Modules/Drainage/Services/LinkService.CopiedSourceOwnTag.cs`, new `Modules/Drainage/Rules/CopiedSourceOwnTagRule.cs`, new `Modules/Drainage.Tests/Services/Bug1246CopiedDownpipeOwnTagTests.cs`, `Modules/Drainage.Tests/Services/RedoSafeReviewedHooks.baseline.txt`, `REGRESSION_LOG.md`.

For CE 05 to record (I did not edit BUG_CARPARK.md): BUG-1246 cause above, draft PR #1891, B-071, needs robot N38 / C38 and a Codex look at the label.
