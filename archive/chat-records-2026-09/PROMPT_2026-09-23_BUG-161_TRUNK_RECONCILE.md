```
RUN CONFIG
Model: Opus 5.5 (strongest)   Thinking: high
Why: release work. A wrong merge silently removes installed features or brings back private data.
Downgrade: none recommended. Sonnet 5 at high only for the final register/doc updates, after the merge is proven.
Chat name: CE_ACAD / TRUNK / fix / 01
```

# BUG-161: make the plugin's main line match what is installed in AutoCAD

You are fixing **BUG-161** for the CE AutoCAD plugin. **This chat does not deploy.**

## 1. Read first, in this order

1. `C:\TimOS\RULES.md`, then `C:\TimOS\ROUTER.md`, then `C:\CE_PLAN\START_HERE.md`.
2. `C:\CE_PLAN\BUG_CARPARK.md`, the **BUG-161** section.
3. `C:\CE_PLAN\decisions\2026-09-23_TRUNK.md` (Tim's "Live is the trunk" ruling) and
   `C:\CE_PLAN\decisions\2026-09-16_TEST_DAY_RESULTS.md` (what failed on 16 Sep).
4. GitHub issue **#78** on `timbrand92/CE_ACAD_PLUGIN` (deploy register), read fresh with `gh issue view 78 --comments`.

Work in a **fresh worktree** of `C:\Lisp Files\CE_ACAD_PLUGIN` branched from `origin/master`. Never the main
checkout. Never bare `git stash`.

## 2. What another chat found (23 Sep 2026, 09:40). Verify every line yourself before acting (RULES §6)

1. **Installed in AutoCAD:** `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll`
   reads product version `3.0.0+d0ffe1a281808c1837375785351581610dcc9c51` (16 Sep 22:38, the 16 Sep test-day payload).
   Check the Net8 and Legacy lanes and Structural/Manager bundles too, and say what each reads.
2. **Main line:** `master` = `3eb912d7`, set 23 Sep by merging master into `10ac480d`, because register #78's
   "LIVE RIGHT NOW" still says `10ac480d` (15 Sep 14:46). That register entry is stale.
3. `git merge-base --is-ancestor d0ffe1a2 3eb912d7` **fails**.
   `git log --no-merges --cherry-pick --right-only 3eb912d7...d0ffe1a2` lists **174** commits that are in AutoCAD
   and not on master: IFD-01 per-job rainfall and the CDCALC computations sheet, the C7 pipe-object rebuild,
   W-01 CDWT tank window, BUG-154 to 156, and `4f04b19d` (15 Sep: CDPROPAGATE stops writing over a level typed by hand).
4. **Consequence:** the next install from master silently takes all of that out of Tim's AutoCAD.

## 3. The job

1. **Re-run the checks in section 2** and report what you actually saw. If any claim is wrong, say so plainly.
2. **List other unmerged work beyond `d0ffe1a2`** that Tim may expect (for example
   `claude/civil-other-areas-2026-09-16-1c1ae6` @ `812f868f`, NOT installed). List it, don't merge it. That is a separate decision.
3. **Ask Tim ONE question**, in plain English with a recommendation. The question: bring everything installed in AutoCAD into
   the main line, or leave named parts out on purpose. Format: numbered, bold labels, no tables, a real example of each answer.
   **Recommendation to test against the evidence:** bring it ALL in, so the main line equals what he is using today. Things that
   failed on 16 Sep get fixed forward, not ripped out, unless the test-day record shows Tim wanted something removed.
   Never ask him a git question.
4. **After his answer only:** on a new branch from master, merge `d0ffe1a2` (or the branch tip that carries it). Then:
   - **Privacy (hard rule):** the merge must NOT bring back anything the 19 to 20 Sep privacy clean-up removed
     (PRs #79, #80, #81: job addresses in tests, docs, probes; the drainage import corpus). Watch for modify/delete
     conflicts; the delete side wins. The global leak-scan pre-push hook must pass. Never `--no-verify`.
   - `Modules/Manager/Assets/Config/blob-config.json` stays as master's empty placeholders (PR #82).
   - Build every lane with `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Reference DLLs fall back to
     `C:\TimOS\refs\autocad\`. The drainage test build needs the native transform file built first. State how many
     tests ran; zero is not a pass.
   - Proof: `git log --no-merges --cherry-pick --right-only <new tip>...d0ffe1a2` must be **empty** (apart from anything
     Tim ruled out), and `git log --no-merges --cherry-pick --right-only <new tip>...3eb912d7` must also be empty (nothing
     from master lost).
   - Open a PR. **Merge only on Tim's word.**
5. **Records, same reply as the work (RULES §9.7):**
   - Register #78: correct "LIVE RIGHT NOW" to the real installed commit, and add a dated comment.
   - `C:\CE_PLAN\decisions\2026-09-23_TRUNK.md`: add a dated **correction note** below Tim's words. Never edit his quotes.
   - `C:\CE_PLAN\BUG_CARPARK.md` BUG-161 status. Do not mark it FIXED until the PR is merged and the proof above passes.
     Tim's AutoCAD test is not needed for this one because nothing is installed.
   - `C:\CE_PLAN\areas\civil-E-pits-pipes-network-editing.md` item **E-HOLD-01**: remove "Waits for BUG-161" once merged.
     That work is waiting on this.
   - Commit and push `C:\CE_PLAN`.

## 4. Hard limits

1. **No deploy.** That needs Tim's own "AutoCAD is closed, deploy" in that chat.
2. `C:\CE_DrawingIntelligence` is never opened. No client names or addresses in any commit, branch name or message.
3. Report to Tim in plain English: what you found, the one question, then once done: what changed, what he needs to
   do (nothing in AutoCAD), and what you did NOT check.
