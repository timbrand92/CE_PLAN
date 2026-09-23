# The build–test–fix loop: Claude builds, Codex tests, neither accepts

**Set up 23 September 2026 on Tim's instruction. Proven end to end before this was written.**

---

## The point

Tim carried every test result by hand. He no longer has to. **Claude asks Codex, Codex answers Claude.**
What Tim gets is one summary at the end, not every round trip.

---

## The cycle

1. **Claude builds and installs.** Nothing installs without Tim's own *"AutoCAD is closed, deploy"*.
2. **Claude tells Codex the exact version string** that must be installed, and which steps to run.
3. **Codex tests and answers Claude directly** — four words per step, plus evidence.
4. **Claude reads the failures and fixes them**, then builds again.
5. **Tim accepts, or does not.** *(Rule 4 — built, tested, installed, Tim-accepted are four separate facts.)*

**Neither Claude nor Codex may accept anything.** Codex produces evidence. Claude produces fixes.
Only Tim's word in AutoCAD makes something accepted.

---

## How the connection actually works

`codex exec` — Codex's non-interactive mode. Claude launches it and reads what comes back on stdout.

```
codex exec --sandbox read-only --skip-git-repo-check "<the brief>"
```

**Proven 23 Sep 2026:** Codex was asked for the installed plugin's version and returned
`VERSION=3.0.0+b02f3ec7988e9666199aab5bbd16dee482acd09b`, matching the deploy exactly.

### What had to be fixed to make it work

The CLI was **0.152.1** and the configured model (`gpt-6-astra`) needs **0.156.0** — every run failed with
*"requires a newer version of Codex"*. Older models were tried first to avoid touching the machine; none are
supported on a ChatGPT account. **The CLI was upgraded to 0.156.0**, which fixed it. If this breaks again
after an update, check that first.

### Sandbox

`--sandbox read-only` for anything that only reads. **Testing in AutoCAD needs write access** — raise the
sandbox for those runs, and only those.

---

## The three rules that make it trustworthy

1. **The version gate.** Every brief starts by making Codex read the installed version and **stop** if it is
   not the expected one. Without this, Codex tests yesterday's build and reports a pass. This is the single
   most important line in any brief.
2. **Four words, never a score.** PASS · FAIL · BLOCKED · NOT TESTED, one per step, plus four counts at the
   end. **No percentage.** A score is the one output that lets a real failure hide.
3. **A step with no observation is NOT TESTED**, even if it obviously works. Never infer one step from another.

---

## What Codex must send back

1. The **exact version string** it read.
2. Whether **diagnostics were on**.
3. One row per step: ID, result, what it actually observed, evidence file.
4. On a FAIL: what it did, what it expected, what happened, the exact command-line text, and the CE log lines
   for that minute.
5. **Four counts.** Not a percentage.
6. Drawings referred to by their label, **never by job address** (DATA-01).

---

## What this does NOT change

1. **Claude alone installs**, and only on Tim's fresh word in his own conversation.
2. **Codex never deploys and never fixes.** It reports and moves on.
3. **Tim's AutoCAD check stays the final step.** Automated checks passing is not the same as the drawing
   being right — the computations sheet had 27 green tests against a PDF nobody had opened.
4. **Nothing here touches publishing to colleagues**, which needs Tim's word on the exact package.

---

## Starting a cycle

The current list is `CODEX_TEST_RUN_2026-09-23.md`, gated on `3.0.0+b02f3ec7`. A cycle is:

```
codex exec --skip-git-repo-check "Run C:\CE_PLAN\CODEX_TEST_RUN_2026-09-23.md.
Stop at step S1 if the installed version is not 3.0.0+b02f3ec7.
Report back in the format that file's HOW TO REPORT section sets out."
```

Claude reads the report, fixes what failed, rebuilds, and asks again. **Tim sees the summary.**
