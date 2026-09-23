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
4. **There is no sandbox. Codex tests on Tim's own AutoCAD, and the protection is measurement.**
   *(Rewritten 23 Sep after the sandbox was built and proven impossible — see below. The earlier
   version of this rule told you to use an isolated profile from `C:\Autodesk\CERef`. Do not.)*
   Codex still cannot see the screen, so the standing guards are: never F2, **No** to every save prompt,
   copies only, never save a template or a profile or a setting, and never type a credential.
   Around every run, **measure and repair** these, because nothing else protects them:
   - **Inside AutoCAD, at its command line** — `OSMODE` must read **21759**, `CPROFILE` must read
     `"Tim" (read only)`. **Never read or write these in the registry.** *(Corrected 23 Sep: this rule
     first said `OSMODE` = 4133 and `Profiles\(default)` = `<<Unnamed Profile>>`, both read from `HKCU`.
     Measured inside AutoCAD, the live value is 21759 and the live profile is `Tim` — which does not
     exist in `HKCU` at all. Writing 4133 back would have stripped Tim's snaps to four modes. The
     registry key is a different, probably stale profile; AutoCAD persists profiles on a clean exit,
     and BUG-164 crashed 18 of its closes between 15 and 23 September.)*
   - **On disk** — `acadiso.dwt` = `12B46B17C114D235…`, and `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`
     against its backup in `setup-snapshot-20260923\`.

   Expect `OSMODE` to be wrong straight after Part T: `CDWT` sets it to 512 for the callout pick and
   restores it when the prompt closes, and T is designed to kill AutoCAD mid-pick. Check it there first.
   Anything needing Tim's real judgement is still **Tim's to run**, not Codex's.
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
**no evidence at all** — the crash it was sent to investigate was never reached.

## Why there is no sandbox — proven, 23 Sep 2026, don't try it again

A sandbox was built properly: 780 MB clone of Tim's AutoCAD support folders, its own `ApplicationPlugins`,
its own `Template` folder, its own `CE_SANDBOX` profile, `APPDATA`/`LOCALAPPDATA`/`TEMP` all redirected.
**It cannot isolate CE, and it never will.**

- CE resolves its folders with `Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)` in at
  least ten places (`LoggingService.cs:61`, `SettingsService.cs:51`, `PluginInitialization.cs:65`,
  `BlockService.cs:107`…). **That API asks Windows for the known folder and ignores the `APPDATA`
  environment variable.** Measured: with the redirect fully in place, CE loaded and wrote to Tim's real log
  and read his real `TIM_CE_CADTOOLS\CD_Settings.json`. No CE log was created in the sandbox at all.
- Worse than useless: a run everyone *believes* is isolated, writing to Tim's real settings.
- Two further blockers even if that were fixed: the CUIX failed to load (`File not found: acad`), so **no CE
  ribbon appeared** and a sandbox run would not have been representative; and closing it raised a **Flexera
  licence prompt**, which no unattended run can answer and which returns whenever a token expires.
- One hazard it introduced: **every `/p` launch rewrote `Profiles\(default)`**, so Tim's next ordinary start
  would have opened in the sandbox profile. Demonstrated three times. The `CE_SANDBOX` key has since been
  exported and deleted so it cannot happen again.

If someone proposes sandboxing AutoCAD again, the question to answer first is not "can we redirect AppData"
— it is "how does CE find its folders", and today the answer is: by asking Windows, not the environment.

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
Never press F2, answer No to every save prompt, work on copies only, and never type a credential.
Report back in the format that file's HOW TO REPORT section sets out." < /dev/null
```

Before starting: tell the other chat. When it ends: tell them the report path. Claude reads the report, fixes
what failed, rebuilds, and asks again. **Tim sees the summary.**

---

## Usage budget - Codex and Claude (set 24 Sep 2026 after Codex ran out)

**What happened:** overnight 23-24 Sep the release chat ran two or three `codex exec` jobs at once, every window build on
gpt-6-astra at HIGH effort, plus AutoCAD passes of up to five hours. Codex's weekly Pro allowance went from 41% at 22:23 to
100% at 07:45. Tim reset it on 24 Sep.

**Tim (24 Sep, verbatim):** *"you need to manage its usage better so it lasts for the full week, if you need it to use astra low or
sol extra high or other models to manage the usage then do so, same in claude, if theres a smarter way to build with lesser models
and only audit with better ones then set that up, only if its better and still mainatain the speed and quality and lower usage. i will
reset codex usage now but it will have to last until next thursday at the same time"* and *"you can use codex to build as well after i reset"*.

### Codex - one week, 24 Sep to Thu 1 Oct (about 09:20)

**Reset by Tim at about 09:20 on 24 Sep** (his usage page: weekly limit 100% left, resets in 7 days). The limit is **shared across Codex, ChatGPT Work, Workspace Agents and ChatGPT for Excel** (not chat conversations), so Tim's own use of those comes out of the same week.

1. **Read usage before every job.** Every run records `rate_limits` (weekly used_percent, reset time) in its rollout under
   `~\.codex\sessions`. The release chat's runner (`queue2.sh` + `codex_usage.sh`, session scratchpad) refuses to START a job
   when usage is at or above that job's cap.
2. **Daily ceilings (cumulative weekly %):** Thu 24: 15; Fri 25: 28; Sat 26: 40; Sun 27: 52; Mon 28: 65; Tue 29 (release): 80;
   Wed 30: 90; Thu 1 Oct: 97. About 1 AutoCAD pass plus 2-3 builds a day. Keep a reserve for release-day testing.
3. **Model and thinking level per job** (Tim, 24 Sep: *"make sure with codex you know which to use of all the models astra, sol,
   luna and terra and what thinking level as well"*). The four models, as Codex describes them:
   - **astra (gpt-6-astra):** frontier, the strongest and dearest.
   - **sol (gpt-6-sol):** the workhorse for coding.
   - **luna (gpt-6-luna):** fast and affordable, for easier tasks.
   - **terra (gpt-5.6-terra):** older and balanced, for straightforward work.

   | Job | Model | Thinking level | Why |
   |---|---|---|---|
   | AutoCAD test pass (drives AutoCAD, judges screens, follows a strict list) | astra | **low** | Best at reading the screen and keeping the rules; the brief does the thinking, so low is enough |
   | Diagnosing a FAIL from logs and code, read-only | sol | medium | Code reading, no screen |
   | Building a whole new or rebuilt window (layout, view model, tests, pictures) | sol | **high** (**xhigh** for the largest windows: Edit Pipe, CDCALC, Civil Hub) | Design judgement and many files |
   | Behaviour or code fix with clear evidence | sol | medium | Well-scoped coding |
   | Follow-up tweak to a window already built (scroll list, rewording, one control) | luna | medium | Small and clear |
   | Chores (merge master, keep both log sides, rename labels, re-render pictures) | luna | low | Mechanical; Claude often does these itself |
   | Second-opinion review of a PR diff, read-only | astra | medium | Short, and needs the best judgement |
   | Plain records or documents (CE_PLAN notes, handover text) | luna | low | Straightforward writing; luna is the cheapest |

   Escalate only on failure: luna, then sol, then astra, one step at a time, and say so in the queue log. Never ultra or max.
   **Do not use the older models (gpt-5.6-sol, gpt-5.6-terra, gpt-5.6-luna, gpt-5.5).** OpenAI's API price list, checked 24 Sep 2026, prices each of them the same as or dearer than its gpt-6 counterpart (per million tokens, input / output: gpt-6-luna $0.10 / $0.50; gpt-6-sol $2 / $10; gpt-6-astra $10 / $50; gpt-5.6-terra $2 / $12; gpt-5.6-sol $4 / $20; gpt-5.6-luna $0.20 / $1.20; gpt-5.5 $5 / $30). Terra was in this list for an hour on 24 Sep and is withdrawn. Sources: https://developers.openai.com/api/docs/pricing and https://developers.openai.com/api/docs/models. "ultra" is a Codex-app-only level, not an API value.
   Never astra at high or above unless a job has already failed on sol at high.
4. **Concurrency:** one AutoCAD pass plus at most one build at a time.
5. **Measure:** the runner logs usage before and after each job (`queue.log`), so the cost per model and effort becomes known;
   adjust the ceilings from the measurements.

### Claude - resets Friday 12:00 each week

1. **Build cheap, audit strong.** Builders run on **Sonnet** for scoped work, which is most window, wording, test and behaviour
   fixes with clear evidence. **Opus** builds only spine / undo / C7-object / cross-cutting work, or a task Sonnet has
   failed. Before a Sonnet PR is merged, one **Opus review** (a reviewer agent on the diff, not a rebuild) checks it. The
   release chat runs the tests and merges.
2. **Pace:** about 14% of the week a day on average. Build-heavy days (Fri afternoon to Mon) up to about 18%. Release day
   about 10%. Keep about 10% in reserve.
3. **The release chat itself** makes fewer, larger turns and doesn't re-read big files. The orchestrator's own context is
   the largest single cost.
4. **Only where it holds speed and quality:** if a Sonnet build comes back wrong twice, that task goes to Opus.
