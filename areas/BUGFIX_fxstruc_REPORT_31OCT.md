# BUGFIX fxstruc report: nine review fixes on open Structural draft PRs (31 Oct 2026)

Builder: Claude Sonnet 5.5, Saturday 31 October 2026 evening (Melbourne). Base of every PR: claude/rel-20261026s. Source of the findings: OPUS_PREREVIEW_X_1918_GROUP_31OCT.md, OPUS_PREREVIEW_Y_1933_GROUP_31OCT.md, OPUS_PREREVIEW_Z_1902_GROUP_31OCT.md (for #1906), and the coordinator's added items. Every change is one normal commit on the PR's own branch, pushed normally, no force-push. Each Settings switch behaves as before (OFF returns the old behaviour).

## FOR TIM

Nothing here has been opened in AutoCAD. Each fix is built and unit-tested only; none is marked fixed.

1. **#1929 Publish Issue with nothing ticked.** In the Sheets Manager, after a "no sheets" issue is recorded, Publish Issue with a blank revision used to pick the empty row and fail with an error box. It now skips "no sheets" rows: it publishes the earlier real issue, or says "Create an issue snapshot first". Tested: the lookup (three new cases). Not tested: the Sheets Manager window itself.
2. **#1931 RC beam part-move warning.** After COPY, MIRROR or ARRAY of an RC beam or column detail, moving a whole copy no longer says "only 13 of 26 parts moved ... Press U to undo". A detail that was never copied still warns as before. Trade-off: a part-move of a copied detail is not warned either (full grouping ST-08 is the real answer). Also: the move watch now starts first and in its own guarded step with a log line, so a telemetry set-up failure cannot stop it silently. This is a start-up change (FULL train). Tested: the rule with two outlines sharing one id, and the start-up order. Not tested: a real COPY then MOVE in AutoCAD, speed on a large drawing.
3. **#1932 supplier section names.** Editing an SBEAM beam drawn as 310UB32 (now listed as 310UB32.0) is no longer refused. The edit window finds it under the new name and accepts it only when every size and mass is unchanged; Apply saves it under the new name. Tested on the real section list, all 35 renamed rows. Not tested: the SBEAM window in AutoCAD, the Apply write.
4. **#1933 and #1934 FFL.** The FFL preview no longer turns the cursor point by the UCS a second time, so in a turned UCS the mark lands under the cursor. #1934 now contains the #1933 fix through a normal merge commit. Tested: a source check that the jig uses the answer as World, and the FFL and group tests (17 pass). Not tested: the real UCS case (UCS Z 30, FFL at a snapped point). The robot case is still needed.
5. **#1901 XRL.** Pressing Enter at "Apply or Cancel? <Apply>" now applies. Only the Cancel word or Escape cancels. Tested: the answer rule (five cases) and a source check. Not tested: which status AutoCAD returns for Enter; the robot Enter case decides that.
6. **#1899 CSPOINTLOAD.** It no longer refuses when the saved point-load list is damaged (that was a hard block against R-27). It keeps a copy of the damaged list inside the same drawing (a second record, no folder), prints one plain line, places the load and carries on with the readable loads. Switch OFF is the old behaviour. Tested: the rule, the line wording, the copy name, and that the copy is written before the list is rewritten. Not tested: the real write in AutoCAD, Undo of it.
7. **#1898 footing size memory.** Two tidy-ups. A refused size save (library from a newer CE) is no longer remembered for the session, so THCL cannot offer a size that is not in the drawing. The register version this build writes is now one number, not two. Tested: a source check for each plus an equality test.
8. **#1930 PF1 library.** When PF1 and the old bare 1 hold the same pad at the same size and the 1 row is removed, CE now says exactly one line: "CE kept PF1 and removed the duplicate 1 row; sizes are the same." It is shown once per drawing (steadier key: the drawing's file name when saved) and always written to the CE log. If sizes differ, both rows are still kept and the line names both sizes (unchanged). Tested: both cases.
9. **#1906 THCL family.** The temporary outline shown while you pick the text spot is now turned with the pad (a 1200 x 600 pad rotated 30 degrees shows at 30 degrees, not flat). It shows the outline before any slab nudge. Tested: the geometry. Not tested: the picture on screen. The Codex look (THCL 83, 1200 and 600, rotation 30) is still needed.

**What I did NOT do or check.** No AutoCAD, no robot, no Codex. net48 was compiled only on the #1906 tip (0 compiler errors). Only focused test classes ran, never the full suite. Mistakes of mine: none that reached a push; one broad test filter hung a test host and I stopped it.

## New head commits

1. **#1929** claude/b101-publish-issue-nothing-ticked: 77f53a0f
2. **#1931** claude/x6-b105-bug613-rc-move-warning: 563ef353
3. **#1932** claude/b106-cemember-section-rename: 2ffc95fb
4. **#1933** claude/z1-ffl-source-preview: 49151e90
5. **#1934** claude/z2-ffl-group: aeca169f (merge of the #1933 branch, REGRESSION_LOG.md kept both sides)
6. **#1901** claude/bug616-xrl-confirm-31oct: bfb779fa
7. **#1899** claude/s3-links-loads: e3873ac2
8. **#1898** claude/s2-footing-memory: 18ca497f
9. **#1930** claude/b104-pf1-footing-library-name: ce69c24f
10. **#1906** claude/s8-bug1185-1200: 9f5e8b3c

---

## Technical detail

1. **Environment.** One worktree C:\CE_WORK\build\fxstruc (removed at the end). Every build and test ran with CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP and TMP under C:\CE_WORK\scratch\fxstruc (printed each run; the script refuses a path containing AppData), -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2, net10.0-windows test lane with AutoCAD 2027 on PATH, one filter per run. C: free stayed above 27 GB (29.3 GB at the start). First build needed `dotnet restore Modules/Structural/CE_STRUC_SUITE.csproj -p:EnableUnifiedHostAdapters=true` (the Hosted assets file was missing).
2. **net48 after-build step.** The MSBuild step that checks the Standalone binary for CE_SHARED metadata could not start powershell (exit 9009). I ran its check by hand on the built net48 CE_STRUC_SUITE.dll (#1906 tip): the text CE_SHARED is not in it.
3. **Branch already checked out elsewhere.** claude/bug616-xrl-confirm-31oct is checked out in another worktree (C:/ce-fx/s4), and the #1899, #1898, #1930 and #1906 branches were pushed from local branches fx-1899 etc. with `git push origin fx-NNNN:<branch>`. Normal fast-forward pushes. That other worktree's local branch is now behind and will need a pull.
4. **"Fails first".** For new code (new methods) the new tests do not compile on the old head, which counts as red-before; where behaviour was reworded or changed, the new test asserts the new text/behaviour and the old text fails it (#1930 wording, #1899 refusal tests replaced, #1933 and #1898 source checks, #1901 rule).
5. **Pre-existing failure.** CompiledProductionRoute_BindsRealEntryNativeProtectionDirectStorageAndC0 (R4 database comparison flow mismatch) fails on #1932's old head 5813608b too (checked by restoring the old SteelSectionPickerDialog.Edit.cs); it is not caused by these fixes.
6. **#1932 detail.** SbeamEditCommandRunnerCompiledProof requires the edit route to call MembersMatchExactly, so the route calls it first and the former-name rule only as a second chance. Also looks the stored key up under the current name (ListKeyForStoredMember) and puts the current name in the search box.
7. **#1899 detail.** The setting name RoofPointLoads.RefuseWhenAGroupIsDamaged is kept (pinned by tests and the settings file); its comment now says it no longer refuses. The copy is a second named-object record CE_ROOF_POINT_LOADS_DAMAGED (then _DAMAGED2 ...). If the copy cannot be written the line says so and it still carries on. New tags restart from the readable loads only.
8. **#1931 detail.** Rule: a detail id with more than one outline in the same space is treated as copied and not reported. The review's other point (scan of all model space after each MOVE) is unchanged.
9. **#1930 detail.** Removal was already one line in the first draft with different words; the real risks fixed are the wording the coordinator asked for, an unsteady once-per-drawing key, and no record when the line is suppressed.
10. **Not done (outside the asked list).** #1932 PR body still says 34 rows and 250UC73 held; #1934 source guard that both FFL paths call GroupIfOn; #1930 optional polish; #1906 tidy of the unused TryMidpointAlong. Nobody has edited BUG_CARPARK.md.
