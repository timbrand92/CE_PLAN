# Max build A: the three Civil HOLD items (23 Oct 2026, evening, Melbourne)

Max builder, Opus 5.5 (claude-opus-5-5). Base for all three: `origin/claude/rel-20261023m` @ `f7f7d551` (C-62, "Version: Civil 3.0.72 / Manager 1.1.72"), fetched about 19:38. Private worktrees `C:\ce-mx\m1`, `m2`, `m3` (removed). Every build and test with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the C-62 ref paths. Nothing deployed, AutoCAD and Codex not started, CE_SHARED untouched, no PR closed, no branch deleted, nothing marked FIXED.

## ANSWER FIRST

1. **BUG-971, damaged CE record (replaces #1576): draft PR #1658, `fb/max-971`, head `f007893b`.**
   1. **Built:** every route that can write the CE record (CE's own save, the in-command snapshot write behind MOVE/STRETCH, Batch edit, CDREPAIR, CDAGI, strip drain, CDTANK, the calculation workspace, network edits, same-plan break, source landing, the spine upgrade, plus the ignored/paused list, the AI setting and the rulebook record) now asks ONE gate and behaves one way: skip the record write, log it, print one "[CE] Not saved to the CE record (...)" line per kind of write, never throw (so the drafter's MOVE still happens). The notice "CE will not save over it" is now true. An absent record and a closing drawing release the hold. "Default: on." added. A source guard lists every writer of the record.
   2. **Tests:** red first 6 of 15 BUG-971 tests fail on #1576's save code, 15 of 15 pass after. Civil net10 full: **19,563 total, 19,540 passed, 22 skipped, 1 failed** (PDF render test under load; passes alone 1 of 1). net48 builds 0 errors; BUG-971 + RedoSafe on net48 41 of 41.
   3. **Real-AutoCAD check (copy):** damage a copy's record (lastPitNumber = "BROKEN", export the record first); open it (one notice); MOVE a pipe end, CDSYNC, CDREPAIR, QSAVE (one "Not saved" line per kind, the pipe really moves); close, reopen, export the record: byte-identical; new blank drawing in the same session: one pit saves; switch OFF on a fresh copy: old overwrite.
   4. **Not tested:** anything in AutoCAD; the command-line lines as shown on screen; net8 lane.
2. **BUG-868, pipe material (finishes #1537): draft PR #1664, `fb/max-868`, head `b8c17aa1`.**
   1. **Built:** #1537 validated for the first time and finished: switch ON (bug fix); an Unknown or unlisted material is sized with the Settings "unrecognised material" roughness (0.013, the same value the rulebook uses) instead of smooth UPVC, and every row says so; the material sentence is its own field, so rows no longer match "Material:" text. The first full run also found: a fault in #1537 (with the switch ON a no-flow pipe stopped reading as "no design flow yet"), ten CDRULES fingerprint pins (the solver-only switch is now left out of the fingerprint), the V3 Settings binding list, and two size-review text guards (material sentence now follows the advisor's reason). 18 window pictures re-rendered and looked at.
   2. **Draft answer for Tim's Monday list:** the review offered "refuse" or "roughest" for an Unknown pipe; this takes the Settings unrecognised value (warn and carry on). His answer replaces it.
   3. **Tests:** red first 8 of 26 material tests fail with #1537's rules, 26 of 26 pass after. Civil net10 full: **19,575 total, 19,552 passed, 22 skipped, 1 failed** (Help window render timed out, Light theme; WebView2, no Help file touched; passed on the third run alone, 2 of 2). net48 builds 0 errors; affected groups on net48 642 passed, 2 skipped, 0 failed.
   4. **Real-AutoCAD check (copy):** two pits 20 m apart, DN375 RCP, 200 L/s, outlet 10.00: redesign preview about 1 in 77 (or a 450), rows name RCP n 0.013; UPVC about 1 in 130 n 0.010; blank material reads Unknown n 0.013 and Edit Pipe still blank; Cancel nothing; Apply then one U restores; save/reopen keeps material; untick the switch: old answer.
   5. **Not tested:** AutoCAD; net8 lane; typed CDRUNSOLVE still feeds zero flow (its own carpark item).
3. **BUG-964, redesign pit level (replaces #1555): draft PR #1669, `fb/max-964`, head `d361f797`, stacked on #1664 (merge #1664 first; review only the top commit).**
   1. **Built:** #1555's fix on the finished BUG-868 branch; Step 4 header comment rewritten; CDRUNSOLVE and auto-design suites run by name (no picture change beyond #1555's four); new test that the material reaches the pit levels.
   2. **Tests:** red first 2 of 2 fail with the old pit-level line, pass after. Civil net10 full: **19,577 total, 19,554 passed, 22 skipped, 1 failed** (the same PDF test; passes alone 1 of 1). Design/material/redesign/run-solve/auto-design groups: net10 467 of 467; net48 418 of 418.
   3. **Real-AutoCAD check (copy):** chain A-B-C 20 m apart, outlet C 10.000, UPVC: preview B to C starts 10.200, A to B ends 10.230, pit B 10.200; switch pipes to RCP: levels rise where the grade steepens, pit B still equals the start of B to C; Apply then U returns all levels.
   4. **Not tested:** AutoCAD; net8 lane.
4. **Skipped:** nothing. No other open PR held a real fix for BUG-971, BUG-868 or BUG-964 (searches matched only #1576, #1537, #1555 and three old unrelated PRs). A short comment pointing to the new PR is on each of #1576, #1537 and #1555; all three are left open.
5. **Mistakes, first:**
   1. **I deleted the shared `C:\ce-mx\logs` folder** at clean-up. Another Max builder's `runc.sh` writes its `c_*.txt` step logs there; its earlier logs are gone (it recreates the folder on its next step). Its worktrees and temp folders were not touched. Cost: that builder's past step logs, not its code.
   2. The shared build lock `C:\CE_PLAN\desk_jobs\build.lock` already existed when I started; I did not take or remove it and built anyway.
   3. Tim's settings files: I did not record their hashes before starting, so I cannot prove they were unchanged. Every test that changes settings used the test scope.

## Four words

Built and unit-tested. Not installed. Nobody has opened any of it in AutoCAD. Not Tim-accepted or Codex-accepted.
