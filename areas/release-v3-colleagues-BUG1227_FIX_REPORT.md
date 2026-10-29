# BUG-1227 Part A: fix report (build item B-049a)

Fri 30 Oct 2026, Melbourne time. Draft PR **#1867** against `claude/rel-20261029a` (Civil 3.0.86). Branch `fb/bug1227-pit-copy-keeps-pipe-ends`, worktree `C:\ce-fx\c82a`.

---

## FOR TIM

1. **Answer first: the fix is written and a draft PR is open (#1867), but it has NOT been built or tested yet.** This PC never gave my job a free build slot (other jobs held both slots from 22:52 on Thursday to now). Nothing here has been run by a computer, let alone opened in AutoCAD.
2. **What you will see once it is built and installed.** Copy a pit on top of another pit (ROTATE then Copy, or SCALE then Copy, base point on the pit). The original pit keeps all of its pipes. The copy gets none of them. CE prints one line: "P11 sits on pipe ends already joined to P3; they stay joined to P3."
3. **What stays the same.** A copy placed 5 m away behaves as today. A copy dropped onto a loose pipe end still joins it. Moving a pit, dragging a grip, the PIT command and CDREPAIR are not touched.
4. **The switch.** `linking.pitCopyKeepsOriginalPipeEnds` in the `linking` group of `CD_Settings.json`, ON. Set it to false before AutoCAD starts and you get exactly today's behaviour (the control case).
5. **One thing I did differently from the plan, and why.** The plan held back only the new copy. In the robot's second command (the SCALE Copy) the copy from the first command (P11) sits even closer to P3's pipe ends than P3 does. Holding back only the new copy would have let P11 take P3's pipes on the second command. So every pit that is not already joined to a pipe end now holds back. The message still names only the new copy.
6. **My mistakes first.** My first test launcher passed its arguments wrongly, so when a slot finally opened at 02:08 the job did not run; I only saw it later. It cost one lost slot. Also my first design (copy-only) had the P11 gap above; I found it while writing the second-command test, before anything was committed.
7. **What to do next:** nothing from you. The build and tests will run when a slot opens; I will update PR #1867 and this report. After that CE 02 can run robot case N36_rotcopy_on_pit with control C36 (below).

---

## ANSWER FIRST (technical)

1. **PR number:** #1867 (draft). Files: `Modules/Drainage/Rules/CopiedPitEndOwnerGuard.cs` (new, headless), `Services/LinkService.Geometry.cs`, `Services/LinkService.RepairAudit.Relink.cs`, `Services/LinkService.PitRelinks.cs`, `Services/LinkService.Utilities.cs`, `Services/LinkService.State.cs`, `Services/LinkService.Cache.cs`, `Services/ScopePitClaimEvidence.cs`, `Models/UserSettings.cs`, `REGRESSION_LOG.md`, and new tests `Drainage.Tests/Services/Bug1227PitCopyKeepsPipeEndsTests.cs`. CE_SHARED unchanged.
2. **What a drafter sees differently:** see FOR TIM 2 and 3.
3. **Mistakes of my own first:** see FOR TIM 6. Also: the PR was opened before any build, because the build slot never opened; the PR title and body say so.
4. **NOT proven:** everything. No compile (net10 or net48), no unit test run, no focused or full suite, nothing in AutoCAD. The REGRESSION_LOG entry says "NOT YET BUILT OR TESTED when committed" and must be changed when results exist. I have not checked the C75/C76 switch-default test files for a list that must include the new key (I wrote my own pinning tests in the new test file instead).
5. **Robot case that proves it:** `N36_rotcopy_on_pit` (working title, N36 is taken by the DP-time case; **tell CE 02 to renumber**), control `C36` (`VARIANT_OF N36`).
   1. Setup: the R34 drawing, `linking.pitCopyKeepsOriginalPipeEnds true` in `CD_Settings.json` before AutoCAD starts (the switch is read at launch).
   2. Steps: `pick-first` P3 (handle 109D56), `type _.ROTATE`, base point `53777.7,-25569.9`, `C`, `90`; `wait`; `pick-first` P3 again; `type _.SCALE`, same base point, `C`, `1.5`.
   3. Checks: (a) no command-line line matching `Pit schedule cell for P3`; (b) CE log has no `Pipe endpoints updated: 10A901 .* to=P11`, nor for `10A98D` and `110136`, and no `109E23 from=P12` or `110179 .* to=P12`; (c) one line matching `P11 sits on pipe ends already joined to P3; they stay joined to P3` after the first command and one matching `P12 sits on pipe ends already joined to P3` after the second (so `stay joined to P3` appears once per command); (d) the R34 label checks (P11, P12) still pass.
   4. Control C36: same text with `linking.pitCopyKeepsOriginalPipeEnds false`. It must FAIL (a) (six lines then nine) and (b) (`10A901 from=WT9 to=P11` present) and (c) (no line), as the 3.0.86 run did.

---

## Where it lives (code read on `origin/claude/rel-20261029a`, 3.0.86; the plan's lines had moved)

1. Copy reconcile queues the copied pits: `Services/LinkService.Utilities.cs` near line 457 (`QueueClonePitRelinks`), now also filling the new `state.PendingClonePitRelinks` (`LinkService.State.cs`).
2. `LinkService.PitRelinks.cs` `ApplyPendingPitRelinks` passes the copied handles (when the switch is ON) to `RelinkAllPipesToPitsScoped` (`LinkService.RepairAudit.Relink.cs` ~664), which builds the guard and hangs it on the existing `ScopePitClaimEvidence.CopyGuard`.
3. `UpdatePipeLinksFromGeometry` (`LinkService.Geometry.cs` ~216) hands `scopePitClaims?.CopyGuard` down `ResolvePipeEndpointOwners` to `FindBestPitOwnerAtPoint` (~1269). The old behaviour is unchanged when the guard is null (every other caller) or inactive.
4. In `FindBestPitOwnerAtPoint` the walk collects each pit's touch and "already joined to this end" (`WasPitLinkedToPipeEnd`, unchanged) result, `CopiedPitEndOwnerGuard.Decide` says which are offered, and the offers go to the same `NearestPitPicker` in the same order.

## Tests written (not run)

`Bug1227PitCopyKeepsPipeEndsTests`: the P3/P11 example with real `PitOutline` boxes and the real picker (five ends: ON the original keeps five and the copy none, OFF the copy takes five); second command (P12 and the earlier P11 stay off); copy 5 m away unchanged and silent; copy near an unjoined end still joins; original moved away; two copies with no keeper; truth table; line wording; switch default through `DeserializeSettings` and `DeserializeSettingsTolerant`; typed false changes only itself; source guards (guard created in one place from the copied pits; reaches the owner search only through the clone relink's evidence).

## Build and test evidence

PENDING. See the final section, which a later edit replaces.

## Status of the wait

Waited for a free slot from Thu 22:52 to Fri 07:27 (several restarts: my launcher bug at 02:08, then two background-job time limits). At every check one or two other jobs' Drainage test or build commands were running.

---

## BUILD AND TEST (job B-049c, Fri 30 Oct 2026, Melbourne time)

### FOR TIM

1. **Answer first: PR #1867 now compiles and its unit tests pass.** It is still a draft. Nobody has opened it in AutoCAD, so nothing is proven on a drawing yet.
2. **What a drafter will see:** nothing new since the section above. Copy a pit on top of a pit and the original keeps its pipes.
3. **My mistakes first.** (a) One of my own tests had the wrong expected answer: with two overlapping copies, the copy 0.3 mm further east is the nearer one, and my test expected the other. I fixed the test, not the behaviour. (b) My extra argument on the relink call tripped an older BUG-288 check that reads the source text of that call; I updated its text match. The full suite found it, so the first full run failed 1 test of 20,935. (c) I blanked the PR description by mistake while updating it. I restored it from my earlier saved copy within a few minutes (draft status unchanged), with only the status line changed. (d) The first wait loop was killed by the 30 minute background limit and had to be restarted.
4. **What is NOT proven:** everything in AutoCAD. The robot case N36_rotcopy_on_pit with control C36 (section above) is the proof.
5. **Nothing for you to do.**

### Technical detail

1. **Worktree and commits:** `C:\ce-fx\c86a`, local branch `b049c-work` pushed to `fb/bug1227-pit-copy-keeps-pipe-ends` (normal push). Head `a6969702` on top of `28d8b972`. Two new commits: `9c466530` (test expectation) and `a6969702` (BUG-288 guard text match, REGRESSION_LOG result line). No behaviour change; switch `linking.pitCopyKeepsOriginalPipeEnds` still ON.
2. **Compile:** Civil net10.0-windows Release (via the test project): 0 errors. Drainage net48 Release (AutoCAD 2024 refs): Build succeeded, 0 errors, 242 warnings (none new from this change that I saw).
3. **Focused tests (net10, Release):** first run `FullyQualifiedName~Bug1227`: 14 tests, 13 passed, 1 failed (my test expectation, above). After the fix: Bug1227 plus C75 plus C76: 71 passed, 0 failed (count is not zero). After the second fix: Bug285To298C5Tests plus Bug1227: 42 passed, 0 failed.
4. **Full Civil suite, once, Release net10:** 20,935 tests: 20,902 passed, 32 skipped, 1 failed (`Bug288_Wiring_TheCopyQueuesItsSources_AndTheRelinkReadsThemInTheSameWalk`, caused by my change, fixed). The two Debug-only SourceAtomicCoordinatorDependencyTests failures did not appear because this was Release. I did NOT re-run the whole 43 minute suite after the one-line fix; the affected class re-ran green (item 3).
5. **Not run:** Manager and Structural suites (not touched), CE_SHARED unchanged, no AutoCAD, no accoreconsole, nothing deployed.
6. **Robot case:** unchanged from the ANSWER FIRST section: N36_rotcopy_on_pit (renumber if taken) with control C36.
