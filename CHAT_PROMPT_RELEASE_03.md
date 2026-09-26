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

## State at handover
See release-v3 items 253-262 for the exact tips. In short: installed = Civil 3.0.5 / Manager 1.1.5 / Structural 1.0.76
(26 Sep 16:58) unless item 263+ says train 6 (Civil 3.0.6 / Manager 1.1.6 / Structural 1.0.77) was installed.
Wave 1 of V3 feature builders (A UX standards, B sources + Pit Schedule, C repair + import, D CDCALC, E Structural
beam engine) was started 27 Sep ~00:40 by chat 02; their draft PRs are on GitHub. Next: ONE Opus review of wave 1 +
Codex's #252/contextual-tab fixes, then train 7, install, Codex pass.

## Tim's asks for himself (remind him, don't nag)
1. Answer the open-question queue in one sitting (C15/C17 Tc, "assumed, Tim to confirm" items, the two questions in items 256/257).
2. About 30 min a week on the consolidated checklist.
3. Name one colleague who can accept simple items in AutoCAD.
