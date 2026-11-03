# Opus pre-review: ten open draft PRs that had no Opus pre-review (#1657, #1621, #1622, #1644, #1521, #1519, #1445, #1471, #1381, #1004)

Written Monday 2 November 2026, evening, Melbourne, by a read-only Opus reviewer for CE 05 on the CE 00 order of Mon 2 Nov 20:45.
Output path note: the order named `C:\CE_PLANreas\...`. That folder does not exist; it reads as `C:\CE_PLAN\areas\` with the "\a" lost. This file is written there.
Fetch: `git fetch origin` was run first. Tips read after it: Civil base claude/rel-20261102a 3fbb9da5, Structural claude/rel-20261026s 204dfad2, b1 claude/rel-20261108a cf059dcf, b2 claude/rel-20261110a d4ce878e. Installed authority: Civil 3.0.89 = 61fd6fbc.
What I did: listed every open PR (1,580 open). Grepped `areas\OPUS_PREREVIEW_*.md` and `areas\DRAFT_BACKLOG_TRIAGE*.md` for each number: 381 have no pre-review. Ran `git merge-base --is-ancestor` on each of their heads against 61fd6fbc and the Structural line. Read the diffs of the ten below, their change-log entries, the carpark entries, and the 3.0.89 code each one touches. Ran read-only `git merge-tree` against b2.
Built: nothing. Tested: nothing. Installed: nothing. AutoCAD: not opened. No file edited except this one.

## FOR TIM

1. **Short answer: none of these ten should be merged as they stand.** Nine are old second copies of fixes that already reached your installed Civil 3.0.89 by another route. One (#1657) has half its work still missing.
2. **#1657, CE Manager update wording (BUG-917): CHANGE-NEEDED.** The window labels ("Approved", "Copied, waiting", "Starts next time") are already in 3.0.89. The status line still says "Update ready: 3.0.90" for both an approved update and a copied one. It should be redone as one small new PR on the current train. One wording catch: it would replace "Restart AutoCAD to use 3.0.90" with "Starts next time: 3.0.90". That drops the instruction to restart, so keep the restart words.
3. **#1621 (BUG-947, damaged prepared update), #1622 (BUG-1019, CDCALC levels below RL 0.00), #1644 (BUG-999, CDRUNSOLVE "nothing solved" message): HOLD, close as superseded.** A different fix for each is already in 3.0.89. #1622 would even put back an old rule: a real lid level of exactly 0.000 would be ignored again.
4. **#1521 (BUG-860) and #1519 (BUG-859), double-click on a downpipe: HOLD, close as superseded.** Later rounds of these fixes are in 3.0.89. One small piece of #1519 is not, and it may matter for a downpipe that has been resized. Robot case R09 should get a "resized DP1" variant before anyone rebuilds that piece.
5. **#1445 (Manager version numbers), #1471 (OneDrive administrator list) and #1381 (X-Civil import close pits): HOLD, close as superseded.** All three bugs were fixed by other PRs, which are installed in 3.0.89.
6. **#1004 (BUG-558 REDO, Project QA reads): HOLD.** Two of its three changes are already in 3.0.89. The third is a guess at a REDO cause. The carpark keeps BUG-558 as a watch item until it happens again, so leave it alone until then.
7. **Not reached:** about 60 more unreviewed open PRs whose code is not in any build. They are listed at the bottom. Most are October engine-only pieces with nothing calling them yet. The other roughly 320 unreviewed open PRs are already inside 3.0.89 or the Structural line, so reviewing them now would change nothing.
8. **Nothing here is proven in AutoCAD.** I read code only. No build, no test and no AutoCAD run was done by this review.

---

## DETAIL

### Group facts

1. **How the ten were chosen.** I took the open PRs with no pre-review whose head is not inside 61fd6fbc (installed Civil 3.0.89) and not inside claude/rel-20261026s (Structural). Then I put Civil and Manager first and picked the PRs that change real behaviour. Log-only, docs-only and engine-with-no-caller PRs came last.
2. **Every one of the ten conflicts with b2 (rel-20261110a) in `git merge-tree`.** For #1657, #1621 and #1521 the conflict includes the PR's *new test file*: a file of the same name already exists on 3.0.89, written by the fix that landed. That is the clearest sign of a duplicate.
3. **Share of each PR's own code already in 3.0.89.** I counted added code lines of 25 characters or more found word for word in the installed file: #1657 5 of 145, #1621 17 of 62, #1622 6 of 64, #1644 0 of 62, #1521 6 of 121, #1519 0 of 32, #1445 1 of 41, #1471 4 of 45, #1381 4 of 46, #1004 1 of 45. The low numbers mean a *different* fix landed each time, not this one. So each verdict below rests on comparing what the landed fix does, not on a straight ancestor check.
4. **Carpark state read.** BUG-917 and BUG-947 are OPEN in BUG_CARPARK.md. AUDIT_CLASS_ALL_02NOV.md calls both ALREADY-FIXED. BUG-1019 and BUG-999: OPEN. BUG-836, 837, 849 and 733: OPEN, "fix installed in Civil 3.0.70 via PR #1470 / #1454 / #1353". BUG-859: OPEN (R09 still fails as expected on 3.0.88). BUG-558: OPEN, kept as a note. This review changes no status.

---

### PR #1657: BUG-917, Manager update stage words (Manager), head ae113f75, base claude/rel-20261023l

1. **What it changes.** Status-line headlines in `Services/CeOneGlanceStatus.cs`: "Update ready: X" becomes "Approved: X" (office approved) or "Copied waiting: X" (copy checked). "Restart AutoCAD to use X" becomes "Starts next time: X". It also changes window labels in `PluginManagerWindow.xaml`, the copied-update pop-ups in `PluginManagerWindow.xaml.cs` ("is ready" becomes "is copied and waiting for installation"), and in the view model the `PreparationHeadline` and hover reason.
2. **Already landed.** Commit 4d4b9b9c ("Plain wording: update stage names…", PR #1665) is in 3.0.89. It put the window labels in as "Approved", "Copied, waiting" (with a comma) and "Starts next time". So #1657's XAML half is superseded and spelled differently.
3. **Not landed (checked in 61fd6fbc, cf059dcf and rel-20261110a).** `CeOneGlanceStatus.cs` lines 123, 129 and 137 still read "Update ready: " (twice) and "Restart AutoCAD to use ". `PluginManagerWindowViewModel.cs` 202 and 557 still read "Ready for next start" and "already ready. It goes in when AutoCAD next starts". The pop-ups at `PluginManagerWindow.xaml.cs` 623 to 690 still say "is ready" and "Update ready". So the window says "Copied, waiting" while the status line says "Update ready" for the same thing. That mismatch is exactly the complaint in BUG-917.
4. **Wording problem in the PR.** "Restart AutoCAD to use 3.0.16" becomes "Starts next time: 3.0.16". The old line tells the drafter what to do. The new one does not. This is also the line BUG-837 was about (it must appear going from 3.0.99 to 3.0.100). Keep an action in it, for example "Starts next time: 3.0.16. Restart AutoCAD to use it."
5. **Switch.** None. It is wording only, and the change-log entry says so. It touches no protected file and does no drawing write.
6. **Tests.** The change-log entry says "no unit pass is claimed here" (build lock). Its picture test writes PNGs into `docs/image/V3_WINDOWS` only when `CE_UPDATE_DOC_SCREENSHOTS=1`; otherwise it writes to the test work folder. The new test file clashes by name with the landed `Bug917UpdateStageWordsTests.cs`.
7. **Verdict: CHANGE-NEEDED.** Do not merge or rebase this branch. Write one small new PR on rel-20261110a that:
   1. changes only the four status-line strings, the two view-model strings and the pop-ups;
   2. uses the landed spelling "Copied, waiting";
   3. keeps a restart instruction in the "Starts next time" line;
   4. extends the existing `Bug917UpdateStageWordsTests` instead of adding a second file.
   Then close #1657 pointing at it. Robot or Codex check: open CEMANAGER with an approved-but-not-copied state and a copied state, and read the Status line and Updates tab side by side.

### PR #1621: BUG-947, Get update ready repairs a damaged prepared copy (Manager), head b00ffe75, base claude/rel-20261022m

1. **What it does.** When the prepared copy already on disk is missing a file, its folder or its signed files, it moves that copy to `.preparing-damaged-<id>` beside it. Then it moves the fresh verified copy in. Copies with all files present but different bytes still fail closed.
2. **Already landed.** 1899db50 "Fix BUG-947: Get update ready sets a damaged prepared copy aside and prepares a fresh verified one" is in 3.0.89 (`CeUpdateStagingService.cs` 417 and 816). It uses a separate `.damaged-staging\<plugin>\<version>\<id>` folder, and it treats "a file missing *or changed*" as damaged.
3. **Difference worth knowing, not a blocker.** The landed version is broader than #1621: it also replaces a copy whose bytes changed, where #1621 failed closed. That is still safe, because the replacement is the freshly verified copy and the live bundle is never touched. But it was a decision. If CE 00 wants "changed bytes = stop and tell the admin", that is a new carpark item, not this PR.
4. **Verdict: HOLD, close as superseded by 1899db50.** Merging would collide in the same function and add a second, different "damaged" folder scheme.

### PR #1622: BUG-1019, CDCALC treats levels below RL 0.00 as real (Civil), head 753af4cf, base claude/rel-20261023l

1. **What it does.** In CDCALC > Detention, a pipe invert or lid below RL 0.00 counts as a real level. It adds a switch, `detention.belowZeroLevelsAreReal` (ON), and its worked example is inverts -1.000 and -1.100, DN300, suggested water level -0.70.
2. **Already landed.** The change-log entry "BUG-1019: CDCALC uses pipe and lid levels at or below RL 0.00" in 3.0.89 uses the same example and answer. Its follow-up (PR #1625) treats an older trench grate's "0.000" placeholder as unknown. Both are in 3.0.89.
3. **Why merging would be harmful.** #1622 keeps "exactly 0.00 = not recorded" for every pit. The landed fix treats a real 0.000 on an ordinary pit as a real lid level, and only the trench-grate placeholder as unknown. Bringing #1622 in would put back the "zero means unknown" rule for coastal or low-lying jobs (the family of carpark finding T1-6).
4. **Verdict: HOLD, close as superseded.** No switch is needed on top of the landed fix: it corrects a wrong reading, and the landed entry says so.

### PR #1644: BUG-999, CDRUNSOLVE no longer says "every invert matches" when it solved nothing (Civil), head 2fd85563, base claude/rel-20261023l

1. **What it does.** It adds a new `RunSolveOutcomeWords.NothingToApply` helper. It says "could not solve this run … nothing was changed" unless every pipe was really solved.
2. **Already landed.** `ProposalApplyService.PlanBuilders.cs` 72 to 121 in 3.0.89 counts pipes that could not be solved or had no drawing pipe. If nothing changes, it prints "Nothing was changed. CE could not size these pipes because none of them has a design flow yet" or "…could not solve N pipe(s). The first was A to C: <reason>". That covers #1644's main case and its skipped-pipe case.
3. **One edge #1644 covers and 3.0.89 does not.** If the solver returns *no pipes at all* for the run, 3.0.89 still prints "every invert already matches the solved design" (`RunSolveCommand.cs` 178), because nothing counts as not-solved. This is unlikely on a real run and is wording only. Worth one carpark line, not this PR.
4. **Verdict: HOLD, close as superseded.** Add the empty-result edge to BUG-999's entry as a follow-up.

### PR #1521: BUG-860, double-click on the green DP label opens Edit source (Civil), head 2273c237, stacked on b04/bug-859-dp1-doubleclick

1. **Already landed.** c8df2e8c "BUG-860: a double-click on the green label of a downpipe opens the same Edit source window as the symbol (doubleClick.sourceLabelOpensEditSource, ON)" is in 3.0.89, with a test file of the same name as #1521's. AUDIT_CLASS_ALL_02NOV lists BUG-860 as ALREADY-FIXED (not AutoCAD-accepted).
2. **Verdict: HOLD, close as superseded by c8df2e8c.** It is also stacked on an old BUG-859 branch that later rounds replaced.

### PR #1519: BUG-859 round 1, double-click on DP1 in a drawing with no pits or pipes (Civil), head a49afd7e, base claude/rel-20261020l

1. **What it does.** It changes two things in `CompoundEditModeService.cs`:
   1. In a drawing with no pits or pipes, it lets a source block through (DP, IO, OF, FO, TG) when the switch is ON.
   2. It reads a source block's *real* name through the transaction, so a resized dynamic DP (shown to AutoCAD as `*U12`) is still recognised.
2. **Already landed, by later rounds.** The no-pits-or-pipes guard in 3.0.89 (line 297) now lets a watched source double-click through (`DoubleClickEditTable.IsWatchedForSourceWindow`). Round 4 (29 Oct, `doubleClick.sourceStopsAttributeEditorFirst`) stops EATTEDIT at the document-lock notice.
3. **Residual, not landed.** `IsSourceBlock(BlockReference br)` at 3.0.89 line 771 still reads `br.Name`. For a resized dynamic DOWNPIPE that is `*Unn`, so this test misses it. The tagged-source path (`IsTaggedSourceBlock`, read through the transaction) catches a DP that carries a CE source tag, which a placed DP1 normally does. So the gap only bites on an *untagged* resized downpipe block. I have not proven whether that happens in practice.
4. **Verdict: HOLD, close as superseded.** Before anyone rebuilds the real-name piece, add a robot variant of R09 that resizes DP1 in Properties and then double-clicks. Rebuild only if it fails.

### PR #1445: BUG-836 and BUG-837, versions "v1.0.118" and "3.0.99+abc" read as numbers (Manager), head e0cd6196, base claude/rel-20261019a

1. **Already landed.** The 3.0.89 change log has "BUG-835, BUG-836 and BUG-837: versions compare as numbers…" (installed via PR #1470 per the carpark). `CePluginInstallerService.cs` 182 strips the "+" tag in 3.0.89.
2. **Verdict: HOLD, close as superseded by #1470.** Note for #1657's replacement: BUG-837's "Restart AutoCAD to use 3.0.100" line is the one #1657 would reword. Keep the restart instruction.

### PR #1471: BUG-849, OneDrive online-only administrator list is "not downloaded", not "damaged" (Manager), head 6d66ec09, base claude/rel-20261019a

1. **Already landed.** `CeAdminPolicyService.cs` 140 and 296 to 333 in 3.0.89 carry the BUG-849 online-only check (Offline, RecallOnOpen and RecallOnDataAccess marks), installed via PR #1454 per the carpark. A half-written file is still treated as damaged.
2. **Verdict: HOLD, close as superseded by #1454.**

### PR #1381: BUG-733, X-Civil import keeps two close pits with different numbers (Civil), head c460911d, base claude/rel-20261018c

1. **Already landed.** `XcivilEntityScanner.Pits.cs` 476 in 3.0.89: "BUG-733: two pits with different numbers are two pits, even with the same cover level close together." Installed via PR #1353 per the carpark.
2. **Verdict: HOLD, close as superseded by #1353.**

### PR #1004: BUG-558 item 2, Project QA and XREF reads through open-close transactions (Civil), head 7c2630c2, base claude/bug558-global-redo-guard

1. **What it does.** It switches three read-only paths to open-close transactions, which cannot throw REDO away: the background XREF notice reader, the Project QA host read, and the Pit Schedule XREF discovery readers.
2. **Already landed.** In 3.0.89, `CivilBackgroundXrefReader` uses an open-close transaction. `PitScheduleHostInstanceService.ReadAll` (about line 93) is open-close at all times (the "BUG-558 sweep"), which is broader than #1004's "only while a REDO window is open".
3. **Not landed.** The `TryDiscover(hostDatabase, budget, …)` overload behind Project QA (3.0.89 line 39) still uses `ReadSourcePath` and `ReadProjectRecord` with normal transactions on the *XREF's* database. It is not proven that reading an attached XREF database through a normal transaction loses the host drawing's REDO. The measured rule is about the drawing being read.
4. **Verdict: HOLD.** BUG-558 is kept as a note "until it recurs". If it recurs with Project QA or a Pit Schedule XREF open, the one-line change to `TryDiscover` is the first suspect. Then it needs a fresh small PR on the current train, not this branch.

---

## Not reached, and why

1. **Civil and Manager, not in any build, no pre-review (not reached: limit of ten).**
   1. Change-log-only or routing notes: #1680, #1668, #1544, #1543, #1541.
   2. Behaviour fixes, likely superseded in the same way as above (bug has a later "fix installed" entry): #1296 (BUG-360 footer handle, carpark says installed via #560 and #1296 itself), #1241 (BUG-516(d), carpark FIXED Codex-accepted 3.0.65), #742 (BUG-406, replaced by #1781 and #1820, both in 3.0.89), #710 (BUG-403, replaced by #1782 and #1821, both in 3.0.89), #676 (BUG-331, installed via #516 and #646), #1079 (BUG-446 batch half).
   3. Engine-only or no-caller October slices (OFF or no command calls them): #1190, #1179, #1177, #1140, #1137, #1133, #1119, #1104, #1087, #1084, #1082, #1075, #1073, #1067, #1064, #1062, #1053, #1042, #1036, #1035, #996, #714, #712, #706, #701.
   4. Wider changes needing their own look: #1043 (INT-075, removes blue from Civil windows help and printed computations, 11 files), #983 (Settings > AI tick and title block area), #979 and #978 (test tooling).
2. **Structural, not in rel-20261026s, no pre-review (Structural after Civil and Manager by the order):** #1726, #1705 (tests only), #1602 (SBEAMEDIT on CEMEMBER), #1168, #1114, #1083, #1078, #1057, #1055, #1052, #1026, #1018, #1016.
3. **About 320 more open PRs with no pre-review whose head is already inside installed Civil 3.0.89 (61fd6fbc) or inside claude/rel-20261026s.** Their code shipped by train, so a pre-review now changes nothing. They are open-PR housekeeping (close as merged-by-train), not review work. Examples: #1835, #1834, #1833, #1832, #1830, #1827 to #1818, #1798, #1778 to #1748.
4. **Skipped on purpose:** #1989 to #1993 (own job, OPUS_PREREVIEW_1989_1993_02NOV.md).

## What is and is not proven

1. **Read:** the ten diffs; their change-log entries; the 3.0.89 versions of every file they touch; the BUG_CARPARK entries for each bug; AUDIT_CLASS_ALL_02NOV.md lines for BUG-917; CARD_DRAFTS_MANAGER_02NOV.md item 3.
2. **Ran (read-only):** `git fetch origin`, `git merge-base --is-ancestor`, `git merge-tree`, `git show`, `git grep`, `git log`, `gh pr list`.
3. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **AutoCAD:** not opened. **Robot:** not run.
4. **NOT proven:**
   1. That the landed fixes behave in AutoCAD; most are "built and unit-tested only" in their own entries.
   2. That an untagged resized DP exists in real drawings (#1519 residual).
   3. That an XREF-database read through a normal transaction loses REDO (#1004 residual).
   4. That the not-reached PRs are superseded. That is inferred from carpark lines, not read code.
