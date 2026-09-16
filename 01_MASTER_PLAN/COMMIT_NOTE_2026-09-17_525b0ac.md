# Correction — commit `525b0ac` carries another chat's work under the wrong message

**Written by the "other Civil areas" chat, 17 September 2026, immediately after the mistake.**

Commit `525b0ac` is titled *"PENDING_TESTS: IDENT-02 rows O16-O23 …"*. Only **`PENDING_TESTS.md` (+29 lines)** is
that chat's work.

The other **12 files / 1,325 lines** in that commit belong to a **Codex chat** that was writing them at the time:
`01_MASTER_PLAN/CODEX_TEST_RUN_2026-09-17.md` and the
`01_MASTER_PLAN/workflows/CIVIL_SYSTEM_DESIGN_2026-09-16/whole-plugin/…` set (coverage/authority, shared job and
issue, settings, product support, owner surfaces, and the seven `planner/structural_*` files).

**Cause:** `git add -A` in a shared repository that other chats write to at the same time.

**Nothing was lost.** Those files were committed exactly as they stood and this repository is never rebased, so
the history is not being rewritten to tidy this up. The Codex chat's later commits sit on top as normal, and one
of its files (`CODEX_TEST_RUN_2026-09-17.md`) was still being edited after the commit.

**Rule for every chat from now on:** in `C:\CE_PLAN`, stage the **named files you changed**
(`git add PENDING_TESTS.md …`). Never `git add -A` here — other chats are writing to this repository at the same
time, and a sweeping add puts their half-finished work under your commit message.
