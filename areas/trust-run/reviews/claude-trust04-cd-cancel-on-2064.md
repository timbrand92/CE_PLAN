# Review: PR 2076 `claude/trust04-cd-cancel-on-2064` (TRUST-04 queue item 5 rebuilt on PR 2064's rule: CD cancel guard, tests only)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 06:59 PC clock. **Head reviewed:** `0e08cc1f` (own commit `e12f0eb3` on `d64e9a72`, then merge `0e08cc1f` of PR 2064's head `9d44a9c0`; the merge adds only the new test file and its log entry over `9d44a9c0`, checked by diff). **Against:** what it claims, and the FIX FIRST list for PR 2053 (`reviews\claude-trust04-cancel-guards.md`), whose idea it rebuilds. There is no carpark entry for queue item 5 itself. **Four states:** Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: 114 of 114 in its filter; broken twin 1 of 4 fails). No product code. Installed no. Accepted no.

---

## FOR TIM

1. This adds four checks, no change to CE itself: they fail if someone later makes CD write something before you have answered its first questions, when PR 2064's switch is on.
2. They read CE's code as text, so they catch a write added in CD's own lines, not one hidden inside a helper CD calls.
3. With the switch off (as shipped) a cancelled CD still rewrites CE's record at its end, as today; the robot case shows both.

**Verdict: GO** as a guard (tests only), with the small items below. PR 2053 is the older, weaker version; keep one (controller).

---

## Claims, one by one (by reading `Modules\Drainage.Tests\Rules\Trust04CdCancelOnTheRuleTests.cs`)

1. **"Before CD's first question, CD only binds the record and asks for the Civil mark": true for CD's own lines.** The test looks at CD's text from its start to the window's cancel line (`Modules\Drainage\Commands\CdCommand.cs` 45-189) and finds none of the seven record writers. That stretch is longer than the name says: it runs through the draw-first point picks and the New Pipe window, which is good. It does not follow calls: the start-up check, the point picking, the pit-wall snap and the window's Move arrow and Inspect actions are only names to it. (Move arrow writes on purpose after a drafter's action, which is fine.)
2. **"The Civil mark goes through the rule": true.** It pins that the mark routine asks `ActiveMarkHandledWithoutWriting` before writing (`ProjectDataService.Persistence.cs`). The lane's broken twin (that line removed) fails 1 of 4.
3. **"CD's command-end write asks the rule": true, but the pin is loose.** It checks that the text `Rules.RecordWriteRule.ListedCommandForcesAWrite(` appears anywhere in `LinkService.Reactors.cs`. Moving it out of the command-end routine would not fail the test.
4. **"The window-first point questions come before any write": true for CD's own lines** (the stretch of `ExecutePipeDrawing` up to the points being collected): no record writer, no Civil mark.
5. **Against the 2053 review:** item 1 (a cancelled CD still rewrote the whole record because CD is on the end-of-command list) is now answered by PR 2064's rule, switch on only; the Civil-mark miss is covered (claim 2); the window-first points are covered (claim 4). Not covered, as before: Esc at CD's later questions (second point, uphill question, pit name). The evidence saw a cancelled CD at the uphill question change nothing on the installed build.

## Small items

1. **Follow the calls, not the text.** PR 2064 already has the compiled-plugin call-graph tool (`RedoSafeCallGraph`, used in `CancelWritesNothingTests.cs`); walking from `CivilDrainage` to the first prompt would catch a writer added inside a helper. Pin claim 3 inside `FlushProjectDataIfTriggerCommand`, not anywhere in the file.
2. **Stale words.** The PR text says it is stacked on `d64e9a72` (now merged to `9d44a9c0`) and, like the test comments, speaks of "the list of 16" (14 now: Help and CD Settings came off with PR 2073).
3. **Robot row.** `PENDING_TESTS.md` row 14 (safety lane list) still names PR 2053 only and has two of the three cases; add 2076 and the third case its own log entry names (window-first CD, Esc at the first point).

## What I did not check

1. Nothing run.
2. Every helper CD calls before its first question, for hidden writes (the point of small item 1).
3. Whether the window-first mode is reachable on every AutoCAD year (2022 to 2027).
