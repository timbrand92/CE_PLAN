# BUG-859 diagnosis report: the DP1 Edit window (#1499) never opens on a double-click (Thu 22 Oct 2026, about 10:30, Team, Sonnet)

## ANSWER FIRST

1. **Cause: PROVEN FROM CODE, not yet from a live log.** A placed downpipe carries an attribute, so AutoCAD answers its double-click with the Enhanced Attribute Editor (command EATTEDIT). CE watched EATTEDIT only behind a DIFFERENT switch, `doubleClick.opensEditWindow` (the pit-label switch, default OFF). The #1499 switch `doubleClick.sourceEditWindow` (default ON) is read later, inside CDTAG, after the double-click has already been let through to AutoCAD. With the shipped defaults the window could never open from a double-click. This is candidate (d) with a twist: the wrong switch, not the right one read as OFF.
2. **Fix head:** `3563aa9d` on `b04/bug-859-dp1-doubleclick` (off `origin/claude/rel-20261020l` 33ef049e). **Draft PR #1520** against `claude/rel-20261020l`.
3. **Tests:** new `Bug859SourceDoubleClickTests` (18 cases). Civil net10 full run: 19,092 run, 19,062 passed, 19 skipped, **11 failed, and the same 11 fail by name on the untouched base** (compared by name, run in a second worktree). RED was by construction (the new helpers did not exist, so the test project did not compile); I did not show it failing on a built old copy. Not run: net48, Manager, Structural, Installer.Tests, anything in AutoCAD.
4. **Not fixed by this PR:** the green label's TEXTEDIT (separate cause, section 4) and the older pit-label finding L4 (same gate, but turning on the pit-label switch is a decision, section 5).
5. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. Not FIXED.

## 1. The chain of evidence

1. **What a double-click starts.** The block `DOWNPIPE DYNAMIC WITH MASK` has an attribute (Tag DP), so AutoCAD runs EATTEDIT. Codex V4 item 8 and V5 item 4 saw exactly that dialog on the outer circle, the red centre and the angled DP text.
2. **What CE watches.** `DoubleClickEditTable` lists EATTEDIT in the "switched" column only (kinds `pit-label` and `source`). `OnCommandWillStart` in `CompoundEditModeService.cs` returns early, logging "left to AutoCAD: the double-click switch reads OFF", when `IsIntercepted(cmd, opensEditWindow)` is false. `OpensEditWindowDefault` is `false` (DoubleClickSettings.cs, with its own comment: "OFF until Codex passes it").
3. **The two switches.** #1499 added `sourceEditWindow` (default ON) but it is read only in `SourceTagCommand.ReadTagPromptsAndPrepareOrApplyLegacy`, which runs after CDEDIT has been started. The double-click never gets that far, so the ON default changes nothing.
4. **Settings.** Tim's settings files carry neither key (per the brief), so the defaults decide: pit-label switch OFF, source switch ON. I did not open Tim's settings files.
5. **Candidates ruled out.**
   1. (a) record not written at placement: not the cause. The hook never asks, it stops at the command name first. (The tag is read from the block, `SourceTagService.TryGetTag`.)
   2. (b) AutoCAD's editor runs before CE: not the cause. `CommandWillStart` fires before the command runs and CE already cancels and re-routes it for pit labels the same way.
   3. (c) registered too late: not the cause. `CompoundEditModeService.Initialize` runs at plugin start (`PluginInitialization.cs:138`); the same hook works for a pit and a pipe.
   4. (e) attribute says DP, record says DP1, lookup fails: not the cause, and the DP reading is by design. The default numbering mode shows the family only on the plan label ("Labels show the family only: DP"); the full tag DP1 is stored and is what CDTAG reads. So the two texts reading DP is correct, not a fault.

## 2. The fix (smallest)

1. With `doubleClick.sourceEditWindow` ON, CE also watches the attribute editor (`DoubleClickEditTable.IsWatchedForSourceWindow`).
2. With the pit-label switch OFF, the attribute editor is redirected ONLY for a block that carries a CE source tag (`AttributeEditorMayRedirect`, applied first in `ResolveCompoundRoot`). A pit, a pit label and any other block keep AutoCAD's own editor exactly as before. With the pit-label switch ON, behaviour is unchanged.
3. The source switch default now lives in one constant (`DoubleClickSettings.SourceEditWindowDefault`), read by the setting, CDTAG and the double-click gate.
4. One existing source guard (`OvernightLabelDoubleClickAndCopyTests`) pins the text of the gate call; it was widened for the fourth argument and nothing else in it changed.
5. Not changed: the compound-behaviour setting still has to be ON for the attribute editor to be inspected (as for the pit label).

## 3. Residual risk and the precise Codex probe

The code proof is complete for the gate, but I cannot see the live log. Two things only AutoCAD can show:

1. **Does the click land on the block?** If a click on the angled DP text hands CE the attribute itself rather than the block, CE bypasses it as plain text (`ATTRIB` is on the bypass list). Codex saw the same attribute editor on all three parts, which suggests the block is picked, but that is an inference.
2. **Does the dynamic block name matter?** The fix uses the tag test, not the block name, so a renamed anonymous copy (`*U12`) still resolves.

**Probe for Codex (copies only, after Opus review and an install):**

1. Place a downpipe with DP. Double-click the red centre.
2. Read the CE log (`CE_CVL_SUITE` log folder) for these lines in order: `TryRedirectToCdEdit ENTRY - cmd=EATTEDIT`, `clickedId=...`, then `intercepted EATTEDIT ... -> CDEDIT`. If the first line is missing, the gate is still wrong. If `nothing picked` appears, the pick set is empty. If `plain ATTRIB bypass` appears, the click delivered the attribute, and the next change is to resolve an attribute to its owning block.
3. Before the install (to prove the cause on the CURRENT build): double-click the same downpipe and read the log. Expected: `EATTEDIT left to AutoCAD: the double-click switch reads OFF`. That one line proves the cause on Tim's installed bundle.
4. Command-line cross-check without a double-click: type `(setq e (car (entsel)))`, click the downpipe, then `(cdr (assoc 0 (entget e)))` gives INSERT and `(cdr (assoc 66 (entget e)))` gives 1 (has attributes). That proves the block carries the attribute that makes AutoCAD pick EATTEDIT.

## 4. The green label (TEXTEDIT) and the older pit-label finding L4

1. **Green label: a different cause, not explained by this fix.** The source label is a plain `DBText` (`SourceTagService`, `new DBText`), tied to its block only by the block's own record (label id), with no owner note on the text. In `TryRedirectToCdEdit` a DBText is "plain text" and is returned to AutoCAD's TEXTEDIT unless a pipe-owner cache proves otherwise, and that exception is for pipes only. So a double-click on the green label stays TEXTEDIT by design of the current code, even with every switch ON. The table row `source-tag-text` is therefore dead for DBText. Fixing it needs the label to be proved as the source's label (the block's label record names the text) and a command-review card for how that should behave. Not changed here.
2. **L4 (pit label opens AutoCAD's own editor): the same gate, the same cause.** A pit label is also a block with an attribute, so it starts EATTEDIT, which waits for `doubleClick.opensEditWindow` (OFF). My change does NOT fix it: with the pit-label switch OFF a pit label still keeps AutoCAD's editor, by intention. L4 is fixed by turning that switch ON, which is the "flips to ON in the same commit as the Codex PASS" decision already written in `DoubleClickSettings.cs`.

## 5. Questions for Tim (queue for work hours)

1. **Should the pit-label switch now go ON?** Context: Codex has now seen twice that CE's double-click does nothing for an attributed block while it is OFF. Recommendation: not in this PR; flip it only in a commit that carries its own Codex PASS (the rule in the code). Example: with it ON a double-click on a pit number opens Edit Pit; OFF it opens AutoCAD's attribute editor.
2. **Green label.** Should a double-click on a source's green label open the same Edit source window? Recommendation: yes, as its own reviewed card. Example: double-click DP1's label, get the small window, not in-place text editing.

## 6. Hygiene

1. Worktrees `C:\ce-fx\w859` and `C:\ce-fx\base` created for this job and removed at the end. No PR closed, no branch deleted, no version edited, DESK_LOG.md and BUG_CARPARK.md not edited. Tim's settings files, installed bundles and ProgramData not touched. No AutoCAD, Codex or accoreconsole started.
2. Build lock `C:\CE_PLAN\desk_jobs\build.lock` held only while each test run ran.
3. Environment: Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, refs as in the C-57 assembly report, AutoCAD 2027 folder on PATH, 0-byte `CE_TRANSFORM_2027.arx` placeholder, fresh TEMP and CE log folder per run. Full Civil net10 run 5 m 33 s.
4. The 11 reds (same names on base): `BackTest_GlenEira24115_Computed_WithinTolerance` (known), seven "ResolvesAwayFromTheReal...AppData" tests (likely my redirected TEMP and log folder; not investigated), two `EmptyWordListsWarnInTheWindowAndStillSave` cases and `Settings fits 1920x1080 at 150% (dark)` (window layout tests; not investigated). They fail the same without my change.
