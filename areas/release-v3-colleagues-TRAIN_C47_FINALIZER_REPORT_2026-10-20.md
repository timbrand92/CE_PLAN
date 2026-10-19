# Train C-47 finalizer report (Civil + Manager), Tue 20 Oct 2026 early morning (about 04:05 to 04:55, Melbourne time)

**ANSWER FIRST**

1. **Verdict: GO.** Train `claude/rel-20261020a`, final head `65507bc34beca79927e31533d8d0d98ac20668c9` (input head ad43f0cd matched origin before I started; one finalizer commit on top, normal fast-forward push, leak scan clean). Built and unit-tested only. Nobody has opened it in AutoCAD. Nothing installed, deployed or version-edited.
2. **Nothing reverted.** All 6 PRs stay in: #1474, #1475, #1477, #1478, #1479, #1480.
3. **What I changed (commit 65507bc3):** one `REGRESSION_LOG.md` entry, the train record. **No code, no default, no test changed.** The code I built and tested is exactly the ad43f0cd code.
4. **Fix rounds:** every one does what its review entry asked, and nothing more (diffs read, not titles). Section 1.
5. **Manager must ship: yes.** One Manager file changes (#1474, the support zip). The Installer also changes (#1475). CE_SHARED does not change. Ship Civil, Manager and the Installer together from this commit.
6. **The installer's signed-update check cannot be affected.** #1475 only clears read-only marks inside the installer's own leftover folders, just before it deletes them. That happens after the signed-release check has already passed (or on the failure clean-up). The check itself, its inputs and the signed files are untouched.
7. **New Settings switches: two, both ON, both left ON.** Each one stops a false result, so the old behaviour is the bug (section 3). Neither has a Settings page row yet.
8. **#1441's new commit (not in this train):** right, with one missing space in the message. Verdict **MERGE-INTO-NEXT-TRAIN after a one-character fix.** I did not add it.
9. **Tests at the final code:**
   1. **Whole solution, Release:** 0 errors, 889 warnings (same as C-46).
   2. **Civil net10 full:** 18,863 run, 18,843 pass, 19 skipped, **1 failed**: the known Glen Eira back-test.
   3. **Manager net10:** 824 of 824.
   4. **Civil net48 focused:** 269 of 269.
10. **Your settings files:** unchanged (checksum read before and after).

---

## 1. Fix rounds (reviewed head to merged head, diffs read)

1. **#1474 (BUG-847, support zip):** only `CeSupportBundleScrub.cs`, its test file and the log entry change against the installed line. The CE_SHARED `CePiiHash` half and its `ResetForTests` hook are really gone (searched: no `CePiiHash.ResetForTests` anywhere). **No file under `Shared/` changes in the whole train.**
   1. In plain words: under AppData or Temp, a path stays readable in the support zip only if it is a CE folder or Autodesk's own. A job PDF or an AutoCAD autosave sitting in Temp is coded like any other client file. AutoCAD's autosave and backup file types now count as drawings everywhere.
   2. The older LOW stands: a Temp file whose name starts "CE " would stay readable. Note only.
2. **#1475 (BUG-838, installer half):** only `Installer/SafeBundleInstaller.cs` (+20 -1) and two tests.
   1. Read-only marks are cleared only after the existing safety test passes: the folder must sit beside the bundle and carry the installer's own marker (`.retiring-`, `.installing-`, `.failed-`, or the just-installed bundle on the existing roll-back path). Nothing new is deleted; the same folders as before, now fully.
   2. Links inside the folder are never followed. **New LOW:** if the leftover folder ITSELF were a link, the clear-marks step would walk through it and clear read-only marks on the files it points to (marks only, nothing deleted; the delete removes only the link). Someone would need write access to the ApplicationPlugins folder to plant that, and the installer makes those folders itself. Carpark suggestion: skip the clear step when the top folder is a link (one line).
   3. A test guards that a folder without the marker is never touched.
3. **#1477 (BUG-430, diagnostic):** log lines only. The four early exits for a double-click command CE watches each write one Information line first; same exits, same order, no behaviour change. Commands CE does not watch still leave before any of it. Command name and block name only, no drawing name.
4. **#1478 (BUG-813, diagnostic):** words only. The "another kind of object" sentence now names CDTAG when CDTAG asks, and says "such as a pit" instead of "a CE pit or pipe". Which blocks are refused is unchanged.
5. **#1479 (BUG-815):**
   1. **#1436's two later commits, reviewed in full:**
      1. 82ceaf4e: CD and Edit Pipe store the twin-pipes tick only on a detention pipe. I checked the drawing side: CD only ever draws twin lines for a detention pipe, so the stored tick and the drawing now agree.
      2. 9769e1d0: one shared "real detention length" rule (a number above 0) for CDCHECKS, the pipe window's type and the pipe-size review. A stored "0" no longer makes an ordinary pipe a detention pipe.
   2. **The 14 false rows:** a pipe marked Detention with no length and no twin tick is no longer judged on its diameter. It moves from "to look at" to "not known".
   3. **A real detention pipe with no length still shows:** its "not known" row reads, for example, "the 150 mm diameter was not judged against the detention range 225–600 mm (enter the length or untick Detention)", using your Settings range.
   4. The merged change is the PR's change exactly (compared file by file).
6. **#1480 (BUG-141, Tidy labels and the border block):** merged at its reviewed head 3ccbda24; the merge's change equals the PR's change.

## 2. #1441's new head 438ed483 (not in this train)

1. **What it does:** the Recover Inverts totals line no longer counts a pipe with only one of its two IL texts as "already had invert text". The next line already names those pipes.
2. **Right:** those pipes are counted inside the same counter, so taking them away gives the true number.
3. **Fault (LOW):** the message lost a space: "22 already had invert text,5 skipped". Fix: put the space back after the comma.
4. **Verdict: MERGE-INTO-NEXT-TRAIN after that one-character fix.** Not added here.

## 3. New defaults

1. **`detention.detentionWithoutLengthNotDiameterChecked`, ON (BUG-815).** Changes what you see: yes, the false "detention diameter 100 mm outside 225-600 mm" rows on downpipes leave "to look at". Old behaviour is the bug: yes. A pipe marked Detention with no length cannot be told apart from a real one, and the row still shows the size and range. **Left ON.**
2. **`linking.tidyIgnoresSheetFrame`, ON (BUG-141).** Changes what you see: yes, Tidy labels stops saying "No clear spot" because of the border. Old behaviour is the bug: yes, a label inside the sheet border is not "on" the border. **Left ON.**
3. **Changes with no switch, each curing the bug itself:** the twin tick stored only on detention pipes; a stored "0" length not making a detention pipe; the support zip hiding client file names in Temp; the installer finishing its own clean-up.
4. **Nothing turned OFF.**

## 4. Switches without a Settings page row

1. `detention.detentionWithoutLengthNotDiameterChecked` (new).
2. `linking.tidyIgnoresSheetFrame` (new).
3. Plus C-45's 32 (standing R-00 LOW). Not built, per the job; windows are Codex's.

## 5. What you will see in AutoCAD after this train is installed (none of it seen in AutoCAD yet)

1. **CDCHECKS on the run-33 drawing:** the 14 "detention diameter 100 mm outside 225-600 mm" warnings on downpipes are gone from "to look at". Each now sits under "not known", saying the length is missing and to enter it or untick Detention.
2. **A real detention pipe drawn at 150 mm with the length left blank:** its "not known" row names 150 mm and the range 225–600 mm.
3. **Tidy labels on a sheet with a border block:** labels can move again; no line says (on "the block Drawing Border").
4. **CDFIXTAGS or CDTAG refusing a block:** the line says which of two causes it was (a copied block, run CDREPAIR; or a block that is really another CE object). CDTAG names itself.
5. **Double-click on a pit label:** nothing new on screen. The CE log says why CE left it to AutoCAD.
6. **CESUPPORT zip:** a job PDF or autosave in Temp shows as [job 25-123] or "name removed"; CE's own log folders still read in full.
7. **On colleagues' PCs:** an update no longer leaves a "...bundle.retiring-..." folder beside the bundle when a file was read-only.

## 6. Do not mark FIXED

1. **Everything in this train is built and unit-tested only:** not installed, not tested in AutoCAD, not Tim-accepted, not Codex-accepted.
2. **Stays OPEN even after an AutoCAD pass:**
   1. BUG-813 (diagnostic only; the rename still fails).
   2. BUG-815 (why 14 downpipes carry a drawn Detention type is still unknown).
   3. BUG-141 (border half only; the pit P8 half is unproven).
   4. BUG-430 (diagnostic only).
   5. BUG-847 and BUG-838 (built only; BUG-838's installer half is first exercised on a real colleague update).
3. **Plus everything on review entries 1308, 1333, 1341 and 1350.**

## 7. Risks

1. **Unit tests and source guards only.** The drawing-level proof is the Codex pass.
2. **Installer tests never run on this PC.** #1475 is read, compiled and reviewed, not exercised.
3. **One intermittent test:** an extra net10 run I did not plan (see 8.3) failed the blank-PDF render test once (timed out at 30 s). It passed in the main run; the train touches no PDF code. Same on-off test C-46 saw.
4. **#1475 LOW:** the top-level link case, section 1 item 2.2.

## 8. Builds and tests

1. Private worktree `C:\ce-fin\c47`, detached at ad43f0cd, then my commit. Release, Below Normal, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, `_AcadRef48` CERef 24.3.0, `_AcadRefNet8` the TimOS 2026 ref folder, Git path given, AutoCAD 2027 on PATH, an empty placeholder transform file made, CE logs in fresh Temp folders. Build lock taken only while each command ran.
2. **Whole solution:** 0 errors, 889 warnings, 11 min 28 s.
3. **My own mistake, cost about 20 minutes:** my script dropped the test options twice, so two runs tested both frameworks in full instead of one. No harm to anything; it gave extra evidence:
   1. **Full net48 lane (twice):** 18,714 run, 370 failed. Every one is the same test-stub fault ("invalid program" when a test touches AutoCAD geometry on the net48 stubs), none in a test class this train changes. Not compared with the base on net48; the full net48 lane is not a gate.
   2. **Second net10 run:** 2 failed, Glen Eira plus the intermittent PDF test (risk 3).
4. **Civil net10 full (main run):** 18,863 run, 18,843 pass, 19 skipped, 1 failed (Glen Eira). Same totals as the assembler.
5. **Manager net10:** 824 of 824.
6. **Civil net48 focused** (Bug141SheetFrame, Bug815DetentionNoLength, RulebookDetentionPipe, Bug430OwnerAnswerLogged, SourceChangeRefusalText, RedoSafe, DoubleClick, PipeWindowPrefill, PipeSizeNetworkReview, PipeRecordType, RulebookEngine): 269 of 269.
7. **Not run:** Installer tests (rule), CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural (no Structural file), each PR alone, AutoCAD, accoreconsole.

## 9. Hygiene

1. **Your settings files, size and first 8 of SHA-256, before the build (about 04:09) and at 04:52, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
2. AutoCAD and accoreconsole not running. Nothing deployed, nothing written to the application plugins folder, no version edited. No PR closed, merged or retargeted; no branch deleted. `DESK_LOG.md` not edited.
3. **Cleaned up:** worktree `C:\ce-fin\c47` (1.8 GB) removed with `git worktree remove --force`, my log folder and Temp CE log folders deleted.
4. **Left by earlier jobs, not mine, not deleted:** `C:\ce-fin\logs` (64 MB, earlier finalizers) and `C:\ce-asm` (23 MB, the assembler's scripts and logs).
