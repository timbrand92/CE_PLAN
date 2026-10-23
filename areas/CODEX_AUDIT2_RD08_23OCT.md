1. **ANSWER FIRST — RD08 update and installer safety, 23 October 2026, Melbourne.** NEW findings: **HIGH 1 / MEDIUM 2 / LOW 0**. All three are **SURE, verified-by-reading** for the stated failure conditions. No failure was reproduced on this PC. Tests below are instructions for the test lane, not results.

2. **Most important — RD08-01.** Two overlapping updates can disagree about what is installed. One can say the new Civil is installed successfully; the other can then put the older Civil back. If Manager has moved forward, the two can be left from different releases.

3. **Second — RD08-02.** When adding a missing bundle fails at the last step, cleanup can fail silently and leave its active loading file behind. The next AutoCAD start can encounter files from an installation reported as failed.

4. **Third — RD08-03.** If putting the old bundle back also fails, the installer discards the backup location from its result and saved attempt record. The backup may be sound, but the office is not told which copy belongs to this failed update.

5. **Scope decision.** This is a report on existing behaviour, not permission to restart parked Manager administrator development. It does not change the Civil + Manager delivery date of 9 November. No drawing, setting, installed bundle or signing key was touched.

---

1. **Source and method.** Fetched the plugin repository and created a detached, unedited audit worktree at `C:\ce-cx\rd08`; no branch. Read Git objects with `git show`, `git grep` and `git diff`. Primary source: `origin/claude/rel-20261023m`, pinned at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, whose version commit names Civil 3.0.72 / Manager 1.1.72. Line references below belong to this commit. These are source versions, not a fresh inspection of installed DLLs.

2. **Structural boundary.** `origin/claude/rel-20261023s` resolved to `e6d597c0fbc25e78118760887a70810e0890c9a9`; its manifest says 1.0.122. Read its manifest and shared-reference packaging conditions only. Did not substitute Structural from the Civil branch or audit Structural commands.

3. **Prior findings screened.** Read the relevant findings in `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md` and `CODEX_AUDIT_STRUCTURAL_22OCT.md`. Grepped `BUG_CARPARK.md` first and checked the relevant entries, the earlier Manager/installer hunt and second source audit. Known findings excluded from the new count: **BUG-425, BUG-478, BUG-522, BUG-823, BUG-824, BUG-832, BUG-833, BUG-834, BUG-835, BUG-838, BUG-882, BUG-883, BUG-884, BUG-885, BUG-886, BUG-887, BUG-888, BUG-914, BUG-918, BUG-947, BUG-948**.

4. **Reachability.** The three new findings concern the compiled `--activate-staged` installer path: `Installer/Program.cs:13` calls `CeInstallerApplication.Run`; `Installer/CeInstallerApplication.cs:134` calls `CeSafeBundleInstaller.Install`. Manager stages files through `CePluginInstallerService.cs:242`; it does not itself activate them. Production reference searches still find no caller of `CeFinishUpdatePlanner` or `CeFinishUpdateStartRule`. An ordinary Manager window opening therefore does not, by itself, trigger these installer failures.

5. **Evidence standard.** SURE means the branch and resulting state follow from the source under the explicit fixture. It does not mean these conditions have occurred in the office. Installer messages and saved JSON are the observable assertions because AutoCAD must be closed during installation. No guessed Autodesk loading order is required to prove these findings.

---

1. **RD08-01 — HIGH — overlapping activations can undo another run's successful install. SURE; verified-by-reading.**

   **File:line:** `Installer/SafeBundleInstaller.cs:293`, `:308`, `:334`, `:340`, `:347`, `:358`, `:361`; entry point `Installer/CeInstallerApplication.cs:134`. The active entry point and installer have no cross-process installation lock.

   **For Tim:** An office operator retries an update while the first copy is still finishing. The retry says it worked, but the first copy later fails and puts the old Civil back. On reopening AutoCAD the drafter gets the older Civil despite the successful result. A Manager update completed in the meantime can leave the pair mismatched.

   **Exact failure scenario:** Start with old Civil O. Installer A promotes new Civil N and pauses before its final attempt-record save completes. Installer B activates the same valid N stage at the same target, backs up N and completes successfully. A's attempt-record save then throws an I/O error. A moves whatever now occupies the target to its own failed folder, restores its saved O and removes the failed folder. It never checks that the live target still belongs to A. B's successful result remains true in its record but false on disk. Distinct generated temporary names prevent temporary-folder collisions; they do not protect the shared live target.

   **DETERMINISTIC TEST — not run:** Use the existing `SafeBundleInstallerTests` signed fixture structure in disposable folders, with target O and candidate N, distinct full-tree hashes, and a probe returning no AutoCAD processes. Call A with the existing `beforeCommit` callback. Inside that callback call `Install` again for B using the same request, assert B returns `Installed`, then throw `IOException("fixture completion-record failure")`. This fixes the ordering without sleeps or timing guesses. Assert that B's result message says `The signed verified bundle was installed.` while the final target hash must remain N if B was allowed to complete. Current control flow instead restores O and A returns `Restored`. After a fix, a second real process must wait for the first run to finish; it must not complete inside that protected interval. Do not run this against live plugin folders.

   **Smallest fix:** Serialise CE activations across processes using one machine-wide installation lock, held from the final state checks through result recording and recovery. Wait with a plain message when another run owns it. Recheck the target after acquiring it. This schedules an update safely; it adds no new permanent hard block under R-27.

2. **RD08-02 — MEDIUM — failed first activation uses silent cleanup on the live bundle. SURE; verified-by-reading.**

   **File:line:** `Installer/SafeBundleInstaller.cs:363`, `:365`, `:383`, `:661`, `:674`, `:677`; completion-record failure enters this recovery path from `Installer/CeInstallerApplication.cs:140` and `:141`.

   **For Tim:** CE is adding a missing suite. If the last record save fails and another process holds a new file open, the installer reports failure but can leave the suite's active loading file in place. On the next AutoCAD start it may load the rejected installation or fail because only part of it remains. Which of those happens depends on which files cleanup managed to remove; neither was observed here.

   **Exact failure scenario:** The intended target did not exist before activation, so there is no retired old target. The new bundle is promoted successfully, then `beforeCommit` throws. The recovery branch calls `DeleteGeneratedDirectory` on the live target itself. That helper suppresses every cleanup exception, assuming generated folders are inert. This particular folder is the live `.bundle`, and its active `PackageContents.xml` may survive. No readback checks that the live target or its manifest is gone, and `restoreError` stays blank.

   **DETERMINISTIC TEST — not run:** Use a valid existing installer fixture with an initially absent target. In `beforeCommit`, open the promoted target's `PackageContents.xml` for reading with sharing that does not permit deletion; retain the handle outside the callback, then throw `IOException("fixture completion-record failure")`. Keep the handle open until `Install` returns. Assert a failed result cannot leave an active `PackageContents.xml` at the target. Current path returns `Blocked`, with `Installation failed before a safe cutover completed:` in its message, while the held manifest remains. Also assert an explicit recovery/cleanup-failure sentence if removal cannot finish. Dispose the handle in the test's finally block. No AutoCAD is needed to prove the active-manifest leak.

   **Smallest fix:** Separate live recovery from best-effort disposal of inert temporary folders. Attempt to retire the rejected live bundle before deletion, check the result, and return an explicit recovery-needed result with the surviving path if either operation fails. Never treat a failed live-folder cleanup as harmless. Keep recoverable files rather than deleting them blindly.

3. **RD08-03 — MEDIUM — failed automatic restoration loses the verified backup location in the durable result. SURE; verified-by-reading.**

   **File:line:** `Installer/SafeBundleInstaller.cs:85`, `:316`, `:318`, `:368`, `:383`; `Installer/CeInstallerApplication.cs:147`, `:149`, `:176`.

   **For Tim:** The update fails, then Windows prevents the old files being put back. The office receives an error but the saved installation record's backup field is blank. With several retained backups, support must guess which one was made immediately before this attempt. Restoring the wrong Civil copy can disagree with Manager.

   **Exact failure scenario:** An old installed bundle exists. The installer copies it to its uniquely named rollback folder and verifies every file. After promotion, the final record write fails. Moving the promoted target away or returning the retired target also fails. The catch returns `Blocked(...)`, whose factory always supplies an empty rollback path. `CompleteAttempt` writes that empty value to `RollbackBundlePath`, even though this attempt already created a verified backup. The local `rollbackBundle` variable is discarded precisely when manual recovery needs it. A normal caught failure whose automatic restore succeeds does retain the path; that successful case does not cover this branch.

   **DETERMINISTIC TEST — not run:** Use target O and candidate N in the existing installer fixture. In `beforeCommit`, retain the supplied installed result's `RollbackBundlePath`; find A's generated `.retiring-<operation>` sibling; create the corresponding `.failed-<operation>` directory with a synthetic sentinel, then throw `IOException("fixture completion-record failure")`. The existing destination makes the subsequent `Directory.Move` fail deterministically, without relying on an antivirus race. Assert the returned message contains `Automatic restore also failed`, the retained backup hashes exactly as O, and the returned `RollbackBundlePath` equals that backup. Current code returns an empty string. The application-level assertion is that the completed attempt JSON retains the same path, since `CompleteAttempt` copies this result field directly. Remove only fixture-created files afterwards.

   **Smallest fix:** Let failure results retain the rollback, retired and remaining-live paths, and persist them when recovery fails. Include the known backup location in the plain recovery message. Do not report an intact backup as restored until live-file readback proves restoration.

---

1. **What was checked beyond the new findings.** Traced office-folder discovery, signed approval pinning, pair approval/promotion/rollback, background staging, the manual preparation route, stage reuse and the installer cutover. Read existing tests for ordinary after-retirement, after-promotion and final-record failures. Those tests restore an old bundle without overlapping activations or a second recovery failure; their assertions do not prove the cases above. No test execution or current pass count is claimed.

2. **What I did NOT check.** No build, test run, AutoCAD session, installation, live DLL hash comparison, real office-approval read/write, executable signing inspection, signing-key access, corporate protection rehearsal, power-loss experiment or sub-agent. Proposed fixtures were not created. No claim that Civil and Manager are currently mismatched on Tim's PC. Other command behaviour, drawings and engineering Settings are outside this audit.

3. **Delivery boundary.** Only this findings file was authored for CE_PLAN. BUG_CARPARK, DESK_LOG and QUEUE were not edited. The detached audit worktree was verified clean and removed; its path no longer exists. No plugin commit, branch or PR was created.

4. **Summary.** Three new source-proven faults remain under explicit failure conditions: overlapping installers can reverse a successful activation; failed first activation can leave an active manifest because cleanup errors are swallowed; and failed automatic restoration omits its verified backup path from the result record. Existing pairing and office-approval findings are excluded. Each new finding includes a deterministic test and a narrow fix. Nothing was built, tested, installed or opened in AutoCAD. Manager administrator development remains parked.
