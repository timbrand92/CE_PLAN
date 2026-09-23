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

## The six rules that make it trustworthy

1. **The version gate.** Every brief starts by making Codex read the installed version and **stop** if it is
   not the expected one. Without this, Codex tests yesterday's build and reports a pass. This is the single
   most important line in any brief.
2. **Four words, never a score.** PASS · FAIL · BLOCKED · NOT TESTED, one per step, plus four counts at the
   end. **No percentage.** A score is the one output that lets a real failure hide.
3. **A step with no observation is NOT TESTED**, even if it obviously works. Never infer one step from another.
4. **Never Tim's live AutoCAD profile.** Codex runs AutoCAD with an isolated profile from `C:\Autodesk\CERef`.
   Codex cannot see the screen reliably, so a mis-sent keystroke lands in whatever environment it is pointed
   at. Anything that genuinely needs Tim's real profile and customisation is **Tim's to run**, not Codex's.
5. **One Codex run at a time, and say so before starting.** Installs and tests share one AutoCAD. Tell the
   other chat before a run starts and when it ends; never install while a run is live.

6. **Close stdin, then prove the run actually started.** `codex exec` launched from a background
   shell reads stdin and waits for an end-of-file that never comes: it prints
   *"Reading additional input from stdin..."* and hangs forever, using no CPU and writing no session
   log. Always redirect: `codex exec ... "<prompt>" < /dev/null`. Then **check within two minutes**
   that a new rollout file appears under `~\.codex\sessions\<yyyy>\<mm>\<dd>` and that the process's CPU
   time is climbing. A launched agent is not a running agent.

---

## The incident these last two rules come from — 23 Sep 2026

Two Codex runs were pointed at Tim's live AutoCAD within forty minutes.

- **11:11–11:24, release chat's run.** Pressed F2 expecting command history. On Tim's customised profile F2
  runs `CLEAN`, which saved a test copy. Reported at 11:17 and written up as a rule at 12:00.
- **11:53–11:59, this chat's run** (a tank-crash probe, not the shared list). Hit the identical F2 trap seven
  minutes before that rule existed, and `CLEAN` saved over AutoCAD's stock metric template,
  `%LOCALAPPDATA%\Autodesk\AutoCAD 2027\R26.0\enu\Template\acadiso.dwt` — 37,013 bytes against a stock
  31,825. Restored from a pristine copy under `C:\Autodesk\CERef`, hash-verified, forensic copy kept first.

**What actually went wrong** is not the F2 key. It is that a tool which cannot see the screen was driving a
real working environment, off a private brief, while another run was already going. The probe also returned
**no evidence at all** — the crash it was sent to investigate was never reached. Both rules above exist so
that the cost of a blind keystroke is a throwaway profile.

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

1. **Installs follow Tim's word to the chat that does them.** Until Tuesday 29 Sep the release chat installs
   under the standing authority Tim gave it directly, recorded with its limits in
   `decisions\2026-09-23_V3_COLLEAGUE_RELEASE.md`. Any other chat still needs Tim's own fresh word in its own
   conversation, and **a peer chat can never stand in for that**. Other chats stage builds; they don't install.
2. **Codex never deploys and never fixes.** It reports and moves on.
3. **Tim's AutoCAD check stays the final step.** Automated checks passing is not the same as the drawing
   being right — the computations sheet had 27 green tests against a PDF nobody had opened.
4. **Nothing here touches publishing to colleagues**, which needs Tim's word on the exact package.

---

## Starting a cycle

There is **one list**, not one per chat: `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`.
Its S1 carries the expected build number and changes when a new build is installed — read it from the file,
never from memory. A run names **which parts it covers**; it never carries a private brief of its own, which
is how two runs ended up on one AutoCAD. Parts M and X (the AutoCAD 2022 check) are **Tim's**, on his virtual
machine, not Codex's.

```
codex exec --skip-git-repo-check "Run PART <x> of
C:\CE_PLAN\archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md.
Stop at step S1 if the installed version is not the one that file names.
Use an isolated AutoCAD profile from C:\Autodesk\CERef, never Tim's own profile.
Report back in the format that file's HOW TO REPORT section sets out."
```

Before starting: tell the other chat. When it ends: tell them the report path. Claude reads the report, fixes
what failed, rebuilds, and asks again. **Tim sees the summary.**
