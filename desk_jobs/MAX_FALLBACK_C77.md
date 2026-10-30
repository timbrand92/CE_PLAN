# Max fallback for the C-77 chain (prepared by CE 01 at 13:25 on 30 Oct 2026; CE 00 agreed at 13:20)

Use ONLY if the Team session limit bites: chain_c77.log shows the session-limit line, or the Team 5-hour meter (desk_jobs\team_usage.ps1) reads 98 percent or more before the finalizer report exists. CE 01 then sends CE 00 ONE line: "LAUNCH MAX FALLBACK: finalizer" or "LAUNCH MAX FALLBACK: payload", with the branch head and this file's path. CE 00 starts the Max background Agent at once. At most 2 Max agents. No deploy: the install goes only through chain_install_c77 with the undo stated.

## Finalizer fallback
1. Brief to paste UNCHANGED: C:\CE_PLAN\desk_jobs\train_c77_finalizer_job.txt (it already says it is a restart and lists the FIX-FIRST items). Agent model: Opus (the only case for Opus on Max). Branch: claude/rel-20261030a at its live head (read it with git ls-remote). The finalizer's own worktree C:\fin77\w may hold partial work: reuse it with a hard reset of THAT worktree to the branch tip; commits already pushed to the branch stay.
2. BEFORE starting it: stop the Team finalizer and chain_c77c by their own pids (otherwise two finalizers push to one branch): the cmd whose command line names train_c77_finalizer_job.txt and its children, then pwsh chain_c77c.ps1.
3. After it writes areas\release-v3-colleagues-TRAIN_C77_FINALIZER_REPORT_2026-10-29.md with "GO at `<40 characters>`": start chain_c77d (copy of chain_c77c.ps1 without the finalizer RunJob; the CE 01 desk makes it in two minutes) so payload 113 follows, or use the payload fallback below.

## Payload fallback
1. Brief to paste UNCHANGED: C:\CE_PLAN\desk_jobs\payload113_c77_job.txt. Agent model: Sonnet (build, tests, packaging). It opens with the parallel-build note (-m:8) and the AutoCAD-closed override (the pin run, native proof and comparisons need AutoCAD closed; compile, tests and packaging do not).
2. It needs the finalizer's GO head on claude/rel-20261030a and Civil 3.0.86 installed (true). If chain_c77c is still alive waiting for the Team finalizer, stop it first so payload 113 is not run twice.
3. The report it writes is C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1073_REPORT.md; chain_install_c77 (pid 76272) is already waiting for it.
4. CE 01 still sends CE 02 the notices: CLOSED WINDOW IN 10 MIN, CLOSED NOW, C-77 installed, DLLs re-read.
