# Version 3 to colleagues — Tim, 23 September 2026

**Area:** REL (`areas\release-v3-colleagues.md`). **Chat:** CE Civil merge gate setup (second chat of that name, worktree `ce-civil-merge-gate-8a60ae`).

## The goal, Tim's words

Tim, 23 Sep 2026, about 10:40am: *"can we continue working on trying to release the v3 for colleagues by tuesday next week"*

**Meaning (Claude's reading, not Tim's words):** a Version 3 build reaches colleagues' AutoCAD by **Tuesday 29 September 2026**. This is a target, not a ruling on scope. What ships, to whom, and how are open questions below until Tim answers them.

## Open questions put to Tim, 23 Sep 2026

1. **Who gets it on Tuesday** — one colleague first (Claude recommends) or everyone.
2. **What ships** — exactly what is in Tim's AutoCAD, frozen Thursday night (Claude recommends), or the newest saved work.
3. **Which AutoCAD the colleagues run** — 2027 only, or some on 2024 or older. Not visible from this PC.
4. **Structural** — whether colleagues' Structural moves with Civil. Claude recommends yes: every CE plugin shares one common library, and a colleague on Civil v3 with the July Structural and Manager risks the CE ribbon not loading.

_Answers go below, in Tim's words, dated, the moment he gives them. An unanswered question stays open._

## Answers — Tim, 23 Sep 2026, saved 10:46 (clickable choices; question 3 typed by Tim)

1. **Who gets it on Tuesday:** *"One colleague first"* (Claude's recommendation).
2. **What ships:** *"Newest saved work"* — **not** Claude's recommendation (a copy of Tim's AutoCAD frozen Thursday). Taken as given. Claude's reading: the colleague build is the saved main line (`master`) at the freeze, including changes Tim has not drawn with yet.
3. **Which AutoCAD colleagues run:** *"some on 2022 and some on 2027"*
4. **Structural moves too:** *"Yes, all three together"* (Claude's recommendation). Civil, Manager and Structural move as one, carrying the same common library.

### What these answers mean for the plan (Claude's reading, not Tim's words)

1. The **2022 lane is in scope** for the release, not only 2027. Tim's Structural 1.0.74 has no 2022 lane, so Structural must be built for 2022 from the same source before any 2022 colleague moves.
2. The pilot colleague's AutoCAD version decides what Tuesday needs. **Still open:** which colleague, and on which AutoCAD.
3. "Newest saved work" means anything another chat merges into `master` before the freeze reaches a colleague. The deploy register #78 is told the freeze time.

## Second round — Tim, 23 Sep 2026, saved 10:57

1. **Who tests in AutoCAD:** *"i can get codex to do all testing on autocad whenever up until tuesday"* — typed by Tim instead of choosing the pre-check plan. **Override recorded (RULES 14.6), scope: AutoCAD testing for this release, until Tuesday 29 Sep.** Codex produces evidence; only Tim's word accepts. Run list: `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`.
2. **Pilot colleague:** *"I'll tell you later"*. Needed by Monday 28 Sep.
3. **A 2022 PC for 30 minutes on Monday:** *"Yes, Monday"*.
4. **This chat controls deployment** — Tim's words as relayed by the E-HOLD chat ("Pipe points locking to grade/invert"), 23 Sep: *"CE_ACAD / release-v3-colleagues / plan / 01 this chat controls deployment"*. Relayed, not heard directly by this chat.

## Open, found 23 Sep before 10:57 — "newest saved work" and "Structural exactly as you use it" are different builds

Read from git, not from a document:

1. **Civil:** the saved main line is the installed `d90659cf` plus one change (CDWT-LINK-01, a tank finds its own plan). No conflict.
2. **Manager:** Tim runs `96e7d76a`. The saved main line has **38 more Manager changes** (including new Project QA pages) that **have never been installed on any PC**.
3. **Structural:** Tim runs `1.0.74+5d723d41`, which is **not on the saved main line at all**: it lives on the Codex Structural branches (`codex/structural-ui-preservation-20260915` and others). The saved main line has 53 different Structural changes (including SML and CHECKML), also never installed.

**Question put to Tim:** for Manager and Structural, ship exactly what he runs, or the saved main line. Claude recommends what he runs: it is the only combination anyone has used, and it builds for 2022 as well as 2027 (checked: `5d723d41` targets net48, net8 and net10). ~~**Unanswered — stays open.**~~

**Tim's answer, 23 Sep 2026, saved 11:00:** *"Newest saved for all three"* (not Claude's recommendation).

### CORRECTION — the evidence put to Tim for Structural was incomplete (Claude, 23 Sep, saved 11:00)

**Tim's words above are unchanged. The question he answered described the saved Structural as "a different mix that nobody has installed". It did not say that the saved one is OLDER.** Read from git after his answer:

1. **Saved main line Structural is version 1.0.42.** Tim runs **1.0.74**. Colleagues run 1.0.40 and 1.0.41.
2. **128 Structural changes in Tim's 1.0.74 are not on the saved main line** (patch-equivalent commits excluded), including the SBEAM repeat placement, SBEAM edit, picker and Undo corrections, the startup palette fix and CEARCHREVIEW.
3. **Tim's 1.0.74 does not use the common library at all** (`fix(structural): isolate standalone runtime from CE_SHARED`, 25 Aug). The saved 1.0.42 still does, so it would bring the shared-library risk back into Structural.
4. **Installing "newest saved" Structural on Tim's PC on Friday would roll his own Structural back from 1.0.74 to 1.0.42.**
5. The newest Structural work anywhere is `codex/structural-ui-preservation-20260915` @ `60c41228`: Tim's 1.0.74 plus 4 window recovery commits (Settings save and Cancel, Publish validation), never installed.

**So for Structural, Tim's answer is re-asked with these facts** (the BUG-161 lesson: a ruling made on incomplete evidence is re-put, not acted on). **Manager and Civil stand as answered:** the saved Manager genuinely contains Tim's installed `96e7d76a` plus 38 newer changes; the saved Civil is his installed build plus CDWT-LINK-01.

## Structural, re-asked with the corrected facts — Tim, 23 Sep 2026, saved 11:05

Offered: A his 1.0.74 (Claude's recommendation); B his 1.0.74 plus Codex's four window fixes of 15 Sep, never installed; C the saved 1.0.42.

**Tim:** *"Yours + Codex's 4 window fixes"* (option B).

**Meaning:** Structural for the colleague, and for Tim's PC on Friday, is built from `codex/structural-ui-preservation-20260915` @ `60c41228` (1.0.74 plus: Settings save confirmation, Settings Cancel/keyboard and load warning, Notes/Properties/Project Setup window connections, Publish validation and Cancel). It does not use the common library. The SML/CHECKML LISP port (saved main line only) is **not** in it; neither Tim nor any colleague has it installed today.

**Whole release, as ruled:** Civil = saved main line at the freeze; Manager = saved main line at the freeze (Tim's installed 7 Sep build plus 38 later changes, never installed); Structural = `60c41228`. One colleague on Tuesday; Codex tests in AutoCAD; 2022 check Monday on a colleague's PC.

## Third round — Tim, 23 Sep 2026, between 11:13 and 11:27 (clickable choices)

1. **What other chats build before the freeze:** *"Failures + new features"* (not Claude's recommendation, which was failures only). Anything merged to `master` by Thursday 24 Sep 5:30pm goes to the colleague; new features get one Codex check, in pass 2.
2. **Start a chat on the CDWT crash now:** *"Yes, start it now"* (Claude's recommendation). Brief written for the tanks chat ("CE Civil - LPD & Pits, Tanks, Level").

## Fourth round — Tim, 23 Sep 2026, after 11:31 (clickable choices)

1. **How the colleague gets it on Tuesday:** *"By hand, AutoCAD closed"* (Claude's recommendation). The colleague runs the three install files from the IT Admin folder with AutoCAD closed, talked through it; their current version is backed up first so it can go back in one step. Fixing automatic updates waits until after Tuesday.
2. **Does Tim see a crash message when he closes AutoCAD:** *"Sometimes"*. Recorded against BUG-164.

## STANDING OVERRIDE — Tim, 23 Sep 2026, saved 11:36: build, test and deploy whenever needed, until Tuesday

**Tim:** *"from now until tuesday we build, test and deploy whenever we need"*

**Recorded as an override (RULES 14.6). Scope: the Version 3 colleague release, from 23 Sep until the pilot on Tuesday 29 Sep 2026.**

**What it lifts:**

1. The AutoCAD-hours rule for builds and automated tests (RULES 1.8, ROUTER step 6). They run whenever needed.
2. Waiting for a fresh "AutoCAD is closed, deploy" before **each** install on Tim's PC (RULES 8.7). Installs to Tim's PC happen when the release needs them.

**What it does NOT lift — Claude's reading, CONFIRMED by Tim, 23 Sep: *"keep going, drop none of the limits"*:**

1. **AutoCAD must actually be closed** before an install, checked more than once (it has been caught still shutting down twice today). A chat never closes AutoCAD itself.
2. **Never install under a Codex run in progress.** It would test a different build from the one it gates on.
3. **Backups first, one-action undo named, every lane read back by hand** after each install.
4. **Publishing to colleagues** (the IT Admin folder, any approval, any colleague PC) is not "deploy" here. It still needs Tim's word for the exact package.
5. Installs go only through the two release chats (`CE_ACAD / release-v3-colleagues / deploy / 01` and `/ plan / 01`).

## Online storage — Tim, 23 Sep 2026, before 12:00 (clickable choice)

**Earlier, to the deploy chat:** *"publish the current build so the channel can go back on"* and *"make sure you and [the plan chat] are working together and you know whats going on"*.

**Facts put to Tim by the plan chat:** online storage reaches no Version 3 user (the new Manager reads signed OneDrive approvals only; colleagues' 1.0.2 link was signed with the key replaced in July); only Tim's old Manager would see it, until Friday. Offered: A don't publish, fix after Tuesday with signed approvals (Claude's recommendation); B publish anyway.

**Tim:** *"Publish anyway"* (option B).

**Meaning (Claude's reading):** the deploy chat publishes **Civil `3.0.0+b02f3ec7`**, the exact bundle installed on Tim's PC, as it proposed. Manager and Structural are **not** included: their candidates are not installed or tested, and Tim was not asked about them. Publishing to the IT Admin folder or approving a build for a colleague is still separate (limit 4).

**BLOCKED — cannot be carried out (recorded 23 Sep by the deploy chat, `decisions\2026-09-23_COLLEAGUE_UPDATE_CHANNEL.md`; the plan chat read that record and did not re-test the keys):** the storage **write** key in Tim's drawer is refused (HTTP 403) — the July SEC-001 reset re-made the read key but never the write key — and the release signing key in the drawer does not match the public key built into the plugin. **Nobody can publish until Tim signs in to Azure and re-makes the write key.** The options put to Tim did not mention this; his answer stands as a decision, blocked from outside. Queued for Tuesday. **Tuesday's one page must not promise colleagues a working update channel.**

## Work without Tim — Tim, 23 Sep 2026, about 12:10

**Tim:** *"keep going WITHOUT MY INVOLVEMENT"*

**Recorded as an override of how questions are handled (RULES 3, 14.6). Scope: this release, until Tuesday 29 Sep.** The release chat decides the ordinary engineering-of-the-release choices itself, records each one here as *Claude's call* with its reason, and does not stop to ask. **Unchanged:** the four confirmed limits (AutoCAD really closed, never under a Codex run, backups and read-back, no publishing to colleagues without Tim's word); no download or install of new tools without Tim's yes (the session's own safety rules); nothing Tim-accepted without Tim. Anything that genuinely needs Tim (the pilot colleague's name, publishing to a colleague, a real engineering ruling) is **queued in one list for Monday**, not asked piecemeal.

## Claude posts straight into the Codex test session — Tim, 23 Sep 2026 (clickable choice)

**Tim's other messages today:** *"can you keep building, deploy and testing between you, the other chat and codex until next tuesday so we can get close to the version3 release properly completed"*.

**Asked:** may the release chat post instructions straight into Tim's Codex test session with the Codex command line (`codex queue`), instead of Tim pasting? **Tim:** *"Yes, post into the test session"* (Claude's recommendation).

**Limits Claude set on itself:** only the one AutoCAD test session; never start a second Codex driving AutoCAD; every message posted is logged in the area file.

## Five days away — Tim, 23 Sep 2026, about 12:10

**Tim asked:** *"so in theory if i left today for 5 days and didnt check until then, you and codex could work together to get a colleague version ready for tuesday with as close to all functionality of the v3 plan as possible?"*

**Answer given:** mostly yes; three things only Tim can do (accept, hand to a colleague, the 2022 check). **Tim's answers (clickable, one typed):**

1. **Pilot colleague:** *"I'll tell you Tuesday"*.
2. **Tuesday's go-ahead:** *"15-minute look Tuesday morning"* (Claude's recommendation). Claude leaves one page: what passed, what is hidden or not ready, a five-step check. Tim looks, says yes, the colleague installs.
3. **AutoCAD 2022:** *"vm will have 2022 but i will test on tuesday"* — the virtual machine Tim is setting up will have AutoCAD 2022; **Tim runs the 2022 check himself on Tuesday.** Codex does not.

## Codex does the human jobs; the two work back to back — Tim, 23 Sep 2026, about 12:15

1. *"if you ever need something like that done like a human, ask codex to do it"* — said when AutoCAD had to be closed for an install. **Meaning:** anything that needs a person at the screen (close AutoCAD, answer a dialog, click through a window) is asked of Codex, through the deploy chat that drives it, instead of waiting for Tim. This replaces the plan chat's own limit "a chat never closes AutoCAD itself" for Codex only; the other three limits stand (AutoCAD really closed before an install, never under a Codex test run, backups and read-back).
2. *"so once i go you and codex run evrerything and go back to back with each other"* — **confirmed:** Claude fixes and installs, Codex tests, Claude fixes what Codex finds, repeat, until Tuesday.

## Claude's calls while Tim is away (recorded as calls, not Tim's words)

1. **23 Sep 12:32 — the shipping Manager and Structural installed on Tim's PC before the freeze**, so Codex tests what the colleague gets from its first real run. Reason: a pass on an in-between mix would prove nothing about the pilot.
2. **Structural built by the AutoCAD 2027 trial route**, not the three-version route, because the three-version route leaves out `CE_STRUC_NATIVE_2027.arx` that Tim's own install had. It matches Tim's answer *"Yours + Codex's 4 window fixes"* like for like. The 2022 question is queued for Tim.
3. **Codex set-up:** the deploy chat builds a GUI sandbox first; fallback at 18:00 to Tim's live AutoCAD under rules 13-14 with a registry and file snapshot taken first.

## Never idle — Tim, 23 Sep 2026, about 13:00

Tim, after the release chat had gone quiet waiting for Codex: *"why have you stopped?"*, then *"you said i didnt need to watch you, if codex is testing you build in the meantime"*, then *"basically you should never stop unless codex has sent you something in which you complete the current task and then review its finidngs and implement"*.

**Meaning:** the release chat always has a task in hand. When Codex's findings arrive, it finishes the current task, reviews the findings, then implements the fixes. The release chat's own admission: it had stopped because nothing woke it, not because the work was done.

**Claude's call, recorded as such:** after Thursday's 5:30pm freeze only fixes for what Codex finds go in (each re-tested), so the weekend proves the release rather than changes it. Before the freeze, failures and new features both go in (Tim's earlier answer).

## Note on times in this file

Clock times first written here were Claude's estimates, and several were wrong by up to an hour. **Corrected 23 Sep to the time each answer was saved** (`git log` of this repository), which is just after Tim gave it. Tim's words are unchanged.

**Claude's correction, 23 Sep about 15:20:** CD-ESC-01 (PR #96) made Escape at CD's third point keep the two-point pipe. It was withdrawn in PR #100 the same afternoon, because the 10 Sep CD card documents the opposite rule and Tim had not been asked. It was never installed. The question is now in the area file's Queued for Tim, item 12. Lesson recorded: a failing old check is not proof that the newer behaviour was accidental. Read the workflow cards first.

**Tim, 23 Sep 2026 about 16:05 (verbatim):** *"can you get codex to continue testing how it is but also make sure when it tests it test with context of how a human would control and use and look at the program and how it feels from an end user perspective then make updates to suit. the last sort of task on tuesday will be to get codex to draft a project from scratch with an existing project from our project folder. codex also needs to review the entirety of the plugin as a whole and provide recommendations on how it can be better for a ui ux persoective and from a usability standpoint then if it could also look in to the current state of the stductural module as well and provide audits and updates for you to fix and improve"*

**Claude's reading and plan:** brief `archive/chat-records-2026-09/CODEX_BRIEF_HUMAN_TESTING_UIUX_STRUCTURAL_2026-09-23.md`. It has four parts: H (a Feel line on every step), U (whole-plugin UI/UX review, read-only), S (Structural audit, read-only) and P (Tuesday, last: draft a project from an existing one). Tim names the project for P, because it is client data. Findings are tagged Behaviour (release chat fixes) or Window (Codex, ruling B). Reports stay outside the repositories.

## CDEDIT on older drawings, Structural alongside Civil, existing before new — Tim, 23 Sep 2026, about 17:45

1. *"With that CD edit thing we were talking about uh, that you asked me a question about before, yes is the answer to that. Do what you need to do in order to make it upgrade existing drawings as best as possible."* **Meaning:** the queued question (area file, Queued for Tim) is answered YES. On a pipe drawn before CE recorded which text is the pipe label, CDEDIT shows the older text and asks once whether it is the pipe label; the answer is recorded on the pipe so it edits normally from then on. When more than one text could be the label, the engineer picks it. CE still never guesses. Supersedes the "redraw with CD" advice in PIPE-EDIT-WHY-02 once built.
2. *"The structural module has its own plan. Make sure we're building towards this plan as well as we're updating and implementing. Obviously continue with what we're doing with civil and make that the main priority. But if we're going to make updates and progress, then let's try and do that for the structural module as well."* **Meaning:** Civil stays first; Structural fixes are made toward `04_REFERENCE\structural\STRUCTURAL_DELIVERY_PLAN_2026-09-14.md` (D1 card, then D2 connected framing), not as isolated patches.
3. *"with the structural implementation, can we make it look and feel organized like the civil one is now?"* **Meaning:** the CE STRUC ribbon and windows get the Civil treatment: named workflow panels with pictures, plain words.
4. *"let's focus on sort of the stuff that's already there and making that better. And then we'll move on to the new additions."* **Meaning:** improve existing commands first (V3 Stage 1 and 2), new additions after.
