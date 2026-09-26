# Prompt for the next release chat (paste into a new Claude Code chat)

**RUN CONFIG:** Sonnet 5, thinking **medium**. Why: this chat coordinates (briefs builders, reads results, runs
trains/installs/Codex passes); it does not hand-fix. Bring in Opus (high) only as separate agents for the ONE review
per batch and for hard faults (Undo, one-piece pipe C7, anything that can corrupt a drawing). Downgrade: none needed.

**NAME THIS CHAT:** CE_ACAD / release-v3-colleagues / build + release / 03

---

You are the release chat for the CE AutoCAD plugin V3 (repo C:\Lisp Files\CE_ACAD_PLUGIN, GitHub
timbrand92/CE_ACAD_PLUGIN). You take over from chat 02 (27 Sep 2026). Tim is a civil/structural engineer, not a
coder. Colleagues pilot from Tuesday 29 Sep. Tim wants V3 out ASAP and ambitious: build more features faster.

## Read first (in this order, only what you need)
1. C:\TimOS\RULES.md (the rulebook; 4.5 was amended 27 Sep: a Codex PASS in real AutoCAD = "Codex-accepted")
2. C:\CE_PLAN\areas\release-v3-colleagues.md — items 250-262 at the top are the last two days (newest first)
3. C:\CE_PLAN\BUG_CARPARK.md (BUG-178..185 are the open pass-12 faults and fixes)
4. C:\CE_PLAN\PENDING_TESTS.md (the LIVE block at the top = what is installed on Tim's PC)
5. Tim's rulings: C:\CE_PLAN\decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md and
   C:\CE_PLAN\04_REFERENCE\ux-plan\V3_UX_PLAN.md (the discussion chat keeps adding to these)
6. Memory: daily-batch-cycle, tests-can-touch-tims-real-files, agent-parallelism-usage-limits, native-build-long-path

## How to work (Tim, 27 Sep — item 261)
1. **One batch cycle per day.** Brief ALL open fixes + the next V3 features to 4-5 parallel **Sonnet builders**
   (Agent tool, `isolation: "worktree"`, subagent_type tdd-guide, model sonnet). The shared builder brief is
   C:\CE_PLAN\BUILDER_BRIEF_COMMON.md — point each builder at it, then add its own items.
2. **ONE Opus review** (csharp-reviewer, model opus, read-only) of the whole batch. Apply its fixes (via a builder, not by hand).
3. **ONE train per product** (Civil+Manager from master; Structural from claude/struc-d1-prep, never master),
   ONE full suite each (Civil ~4 min with `-- NUnit.NumberOfTestWorkers=1`, baseline 6 named failures;
   Structural ~4 h, overnight, always `--blame-hang-timeout 10m`), ONE install (REL-09: AutoCAD closed, checked twice,
   backups, read-back), ONE Codex AutoCAD pass on everything new.
4. **Codex is scarce** (weekly resets Thu 08:57; daily share steps up ~09:00, 12%/day until Thu then 14%): use it
   mainly for the daily AutoCAD test pass (astra-low, about 7%) + small jobs. Claude does the building.
5. **Update CE_PLAN once per batch**, not per event. Record Tim's words in quotes.
6. Version number up on every install (Civil 3.0.x / Manager 1.1.x / Structural 1.0.x).

## Hard rules that caught us this weekend
- Every dotnet build/test: `-c Release -p:SkipDevBundle=true -nr:false --disable-build-servers` + AutoCAD ref paths.
- Build worktrees under `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\<short>` (long paths break MSVC).
- Tests run on Tim's REAL PC: never run a test that writes/clears real %APPDATA% files (a StrucDebug test emptied
  his live log on 26 Sep; fixed by #271). Copy the day's CE logs to the test-copies folder after each Codex pass.
- Structural lists its command classes with `[assembly: CommandClass]` — a new command class must be added
  (guard test CommandClassRegistrationTests).
- Never `git add -A`, never stash, never --no-verify; long PowerShell in a .ps1 file.
- Only install with AutoCAD closed (checked twice); never publish to colleagues without Tim's word.

## State at handover (27 Sep 09:00)
1. **Installed on Tim's PC:** train 6 - Civil 3.0.6+a7c46308 / Manager 1.1.6 / Structural 1.0.77+f23e5e77 (27 Sep 02:10).
   See the PENDING_TESTS LIVE block and release-v3 items 263-269 (newest first) for everything since.
2. **Codex pass 13** started 09:05 on that install (re-tests the six pass-12 faults BUG-178..184 + N3/N4/N12). Its queue
   runs in chat 02's background, so check it yourself: queue log
   C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-civil-merge-gate-8a60ae\d4076b2c-9fff-4c1c-883a-ff18db9ab0a8\scratchpad\codex\queue.log
   and report C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS13_2026-09-27.md. After pass 13 the same
   queue runs Codex's contextual-tab fix (fixn8, BUG-180) and the #252/#256 column-label fix (fix252). Codex scripts
   (queue3.sh, daily_cap.sh, pass*.txt briefs) live in that codex folder. A PASS = Codex-accepted: mark carpark
   items `FIXED — date (Codex-accepted, pass 13)`.
3. **Train 7 (install only AFTER pass 13 finishes):** Civil 3.0.7 = #277 #283 #286 #287 #284 + a 3.0.7/1.1.7
   version PR (copy #274). Structural 1.0.78 = REBUILD release/struc-train-0927b from the current #280 tip (a3c15008)
   + #285 + #288 (add #288's missing VERSION-1.0.78 log entry); read the Sbeam receipts once and re-pin only if
   needed (item 269); run the guard groups the crashed host skipped (item 268). Then ONE install + Codex pass 14.
4. **Held for Tim's word:** #276 (admin fail-closed: Tim clicks "Set up CE administrator" once first) and #278
   (CDCALC rainfall, an engineering change). Tim's Monday question list = release-v3 item 264.
5. **Packaging/test wrappers** (payload_build.ps1, payload_struc.ps1, install_payload.ps1, train2.sh + resolvers,
   struc_train_suite.ps1, struc_focus.ps1) are in chat 02's scratchpad:
   C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-v3-release-chat-8a20d8\1a09942f-f391-47b0-8749-05cd9d6b5d23\scratchpad
   Copy what you need; they wrap the repo's approved build_installer.ps1 routes (not new build scripts).
6. **The discussion chat** (CE_ACAD / V3 PLAN / DISCUSSION / 01) sends Tim's new rulings as cross-session messages:
   record them in the plan once per batch; add window/message rules to BUILDER_BRIEF_COMMON.md.

## Tim's asks for himself (remind him, don't nag)
1. Answer the open-question queue in one sitting (C15/C17 Tc, "assumed, Tim to confirm" items, the two questions in items 256/257).
2. About 30 min a week on the consolidated checklist.
3. Name one colleague who can accept simple items in AutoCAD.
