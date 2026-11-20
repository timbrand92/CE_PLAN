# MODEL ROUTING RULE: the right model for the right task (Tim, 21 Oct 2026: "make it a rule to use haiku for the correct tasks")

**Why:** usage is a budget (Max, Team, Codex). Cheap models for cheap tasks keeps building and testing running without burning the weekly allowance; strong models are kept for work where a mistake costs a bug. Rule owner: the desk. Applies to every headless job (launch_job.ps1 -Model haiku|sonnet|opus), every subagent and every lane.

## 1. HAIKU (cheapest): mechanical, text-only or read-only work
1. Job-file hygiene checks (control characters from eaten backslashes, damaged paths, wrong versions/heads): first trial JOBFILE_CHECK_2026-10-21.md.
2. Inventories and digests: list open PRs with heads and bases, which PRs have an Opus entry, disk scans, process lists, log tails, "what changed since time T" summaries of lane logs, report answer-first extraction.
3. Copying a brief or job file with listed substitutions (heads, versions, names), then a script check of the result.
4. Appending plain log lines (DESK_LOG, QUEUE) from facts the desk supplies; formatting reports; spell and format checks.
5. Wording-only string edits in plugin code ONLY on a trial basis: one string, a test that pins it, and an Opus review before it joins a train.

## 2. SONNET: building and testing
Builders and fixers (lanes), assemblers, payload builders, robot testers, brief writers, filing jobs that decide a bug status (BUG_CARPARK PASS / Codex-accepted), CE log tools, scripts. Anything that writes plugin code with logic, a test, a version commit, a train branch or an installer.

## 3. OPUS: judgement
Reviews, finalizers (GO / NO-GO), root-cause investigation of a failing behaviour, design and plan recounts, adversarial checks, anything touching REDO-safety, transactions, Settings migration, Shared, installers and the signed-update gate.

## 4. Never Haiku for
Code with logic in AutoCAD/.NET (transactions, undo/redo, ObjectIds, database writes, overrules, native modules), installers, Settings keys or defaults, CE_SHARED, version commits, release builds, marking a bug FIXED or Codex-accepted, deleting anything, or any decision Tim must later rely on without a second check.

## 5. How the desk applies it
1. Choose the model when writing the job: default Sonnet for build, Opus for review, Haiku for section 1.
2. Haiku output is never trusted blind: a script (control-character scan, hash, count) or the desk reads it before use.
3. If a Haiku job gets a fact wrong twice, move that task class up to Sonnet and note it here.
4. Record each Haiku trial result below (task, did it get it right, cost note).

## 5b. Codex models (added 20 Nov 2026, Tim: "Rest agreed" on `areas\rules.md`)
For Codex CLI jobs use the newest Codex models Tim named: "if you use codex cli make sure you use astra and sol 6.2 recently added" (Tim, 18 Nov 2026, zero plan D-303). Every Codex job names its model and effort, like every Claude job (RULES 15.12).

## 6. Trial log
- 21 Oct 2026: JOBFILE_CHECK (job-file damage scan) on Haiku, 74 files: it found the 2 files with real 0x07 control characters (fix_1478_1479, train_c48_finalizer: both old and already used) and 0 version mismatches (correct). It also reported 18 "damaged paths" that are mostly false positives of a too-loose pattern (e.g. "(C: Civil ..."). Verdict: GOOD for mechanical scans, tighten patterns; its output is read by the desk.
