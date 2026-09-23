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

## Codex covers acceptance, parallel build lanes managed by Claude — Tim, 23 Sep 2026, about 17:55 to 18:05

1. *"Civil accepted by me and AutoCAD can be covered by Codex as well, with me doing the final, final last pass in a really small sort of different style check as opposed to what Codex is doing, which is checking literally everything. Let's try and get civil to a really good level as fast as we possibly can."* **Meaning:** a new status, **Codex-proven**, sits between installed and Tim-accepted: Codex's AutoCAD evidence (every step) is the acceptance evidence, and Tim's own pass is a short, different-style final check. Nothing is marked Tim-accepted without that final check.
2. *"What if we created two or three chats that could simultaneously build, let's say one doing structural, one doing simple, one doing another simple, let's say to get codex testing more often and faster."* and *"And you manage the new chats yourself and make sure that they're consistently working on building, deploying, and getting tested by Codex."* **Meaning:** the release chat runs up to three build lanes (within the 2-3 at a time limit): itself (Civil release, triage, the only installer), a Civil builder and a Structural builder, each in its own worktree. Builders never deploy; the release chat reviews, merges, installs at clean boundaries (never while a Codex run is live) and tells the deploy chat what to re-run.
3. *"with a visual. Can you show me how everything's going to work on the way to Tuesday?"* Shown in chat, 23 Sep about 18:05 (lanes, the loop, Wed-Tue timeline, Tuesday targets).
4. **Deploy chat's advice, adopted as Claude's call:** split the Codex list into steps that need a human-like tester and steps a headless probe can assert in minutes (today's BUG-163, Z8d and model-space proofs), so coverage grows faster than GUI time allows; and sweep for assumptions about the shape of AutoCAD 2027 return values (case, braces, set order), the cause of three separate faults today.

## Five builders; a usage report at 60%; a Civil UI/UX review — Tim, 23 Sep 2026, about 18:45 to 19:00

1. *"lets go with 5 builders please and dont worry about the usage until you hit 60% of weekly usage then give me a report of how its going"* **Meaning:** five background build lanes managed by the release chat; at 60% of the weekly (all models) limit, report usage and progress to Tim. At the time: weekly 36%, resets Fri 25 Sep about 12:00.
2. *"continue my mistake"* — Tim's interruption (a rejected tool call) was not meant to stop the work. It had stopped two builders; their finished work was saved (Structural `9ec20c5c` pushed; the layer-name work committed as WIP `c8aafc85`) and two replacement builders continue from it.
3. *"we did the look, feel, UI, UX, review pass on the structural by Codex. Can you do the same for the civil module as well?"* **Meaning:** Codex runs Part UC, a Civil look/feel/UI/UX review (read-only), after the short re-run list, judged against Tim's standing rules (no scrollbars, the 30-times-a-day test, colour where attention is needed with gold on dark and CE blue #1E5AA8 on light and no teal, plain English) and discoverability for a colleague's first week. Output: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_CIVIL_UIUX_REVIEW.md`, top ten first; Behaviour items go to the build lanes, Window items to Codex (ruling B).

## Evidence rule for many small installs — agreed with the deploy chat, 23 Sep 2026 about 19:15 (Claude's call)

1. Every install message carries the S1 string, the re-runs it adds, and **INVALIDATES:** — which earlier results no longer describe the installed build.
2. **A result stays valid until the code under it changes, not until the next install.**
3. Results gathered against an AutoCAD that was interfered with (e.g. closed under a live run, as with pass 2's tail) are marked separately, because no commit hash shows that.
4. Each Codex result is tagged with the Civil build it ran against.

## Do not hold back: build as much of the plan as possible for Tuesday — Tim, 23 Sep 2026, about 22:00

Tim (verbatim): *"dont hold back on anything because you wont be able to implement i want you to try and implemennt, on tuesday i want a good version with as much built and then i will continue working from there. i dont want you to condense plans or go easy i want you to achieve big things and not be scared to go through with the plan and its objectives"*

**Meaning:**
1. Nothing is deferred to "after Tuesday" because it is big. **Supersedes** the 21:30 call (Claude and the deploy chat) to hold the tabs-instead-of-scrollbars restructure until after the pilot: it goes ahead now, window by window, each on its own branch, merged and installed as each passes its tests and Codex's check.
2. Build toward the V3 plan's objectives in full (MASTER_PLAN stages 2-5 and the Structural delivery plan), starting with work already approved in CE_PLAN (approved workflow cards, the 2 Sep visual approvals D1-D32, the V3 UI design pack), not only fixes.
3. Tuesday's pilot takes the best tested build at that time; Tim continues from there.
4. Unchanged: Civil first; ruling B (Codex builds window layouts; Claude owns behaviour, spine and deploys; Codex window-builder runs are code-only and do not take AutoCAD time from testing); every change tested and logged; never deploy while a Codex run is live; report usage to Tim at 60% of the weekly limit.

## Claude builds everything, windows included; the CD window is the design reference — Tim, 23 Sep 2026, about 22:10

Tim (verbatim): *"i want you to build everything including windows and if codex needs to help then do so but youre the primary builder, also ui should be like the cd window and work and feel like a product apple or autodesk would design but with a creative engineering feel"*

**Meaning:**
1. **Supersedes ruling B of 15 Sep** (Codex builds windows, Claude owns behaviour): Claude is now the primary builder of windows as well as behaviour; Codex helps where useful and remains the AutoCAD tester.
2. **Design reference: the CD window (New Pipe).** Every CE window should look, work and feel like it: product quality of the kind Apple or Autodesk ship, with a Creative Engineering feel (CE deep blue #1E5AA8 on light, accent gold on dark, no teal), under Tim's standing UI rules: no scrollbars or collapsed expanders (tabs instead), the 30-times-a-day instrument test, colour where attention is needed, plain English.

## At 60% weekly usage: three builders, keep going — Tim, 23 Sep 2026, about 22:15

Tim (verbatim): *"once you get to 60% weekly just reduce to 3 builders but continue"*. **Meaning:** below 60% of the weekly (all models) limit the release chat runs as many build lanes as the work needs (seven at 22:15: five Civil/Structural lanes plus two Claude window lanes, besides Codex's two window builders); at 60% it drops to three and continues, and reports usage and progress to Tim.

## Codex: testing first, building too — Tim, 23 Sep 2026, about 22:20

Tim (verbatim): *"that doesnt mean codex cant build to help as well ideally it also does the testing as priority and some building"*. **Meaning:** Claude is the primary builder (22:10 ruling), and Codex also builds with any spare sessions; its AutoCAD testing always comes first. Handed to Codex builders at 22:20: Print, Help Centre and Feedback windows (plus CDCALC Detention and CDWT already running), all to the CD-window standard.

## Pace Claude to Friday midday; Codex does the heavy lifting — Tim, 23 Sep 2026, about 23:30

Tim (verbatim): *"overnight can you build so that we run all the way until friday at midday. and then use codex to do more heavy lifting until then"*

**Meaning (release chat's reading):**
1. Claude's weekly allowance must last until it resets on Friday 25 Sep at about 12:00. At 23:30 it stood at 62%, so the budget line runs straight from 62% to about 97% at Friday 12:00: about 1% an hour. Checkpoints: Thu 07:30 about 70%, Thu 12:00 about 74%, Thu 18:00 about 80%, Fri 00:00 about 86%, Fri 06:00 about 92%. When above the line, no new Claude builder starts until it is back under.
2. Codex takes the building load: whole windows, code only, in their own worktrees, launched by the release chat with `codex exec` (two runs at a time, queued). Codex also keeps AutoCAD testing as its priority, one AutoCAD run at a time.
3. Claude keeps behaviour, the object spine, reviews, merges and installs. The deploy chat stands down from Codex runs overnight so that only one Claude chat is driving Codex (agreed 23:36).

## Scrolling: allowed instead of page buttons; never in high-use windows where design can do better — Tim, 24 Sep 2026, about 00:00

Tim (verbatim): *"With the windows, I am happy to scroll in places when you would have to implement a next page button like in the help window i just dont want high use windows to have scrolling areas where the ui and ux could be designed far better, does that make sense?"*

**Meaning (release chat's reading). It refines the 4 Sep no-scroll rule; it does not replace it:**
1. **A long list or reading page may scroll** inside a bounded area, instead of Previous / Next page buttons. This covers Help pages, catalogues, schedules, finding lists and the tank sizes list.
2. **A high-use window's layout must not scroll** where a better design would fit it. That means CD / New Pipe, New Pit, CDWT, Edit Pipe and Edit Pit, CDCALC, Settings and the Inspector. The answers there are still tabs, grouping and a tighter layout, never a scrolling form.
3. **Still no collapsed expanders.**
4. Windows built tonight with page buttons for lists (CDWT capacities, Help Centre pages) change to a scrolling list where that reads better.

## Keep building overnight, paced — Tim, 24 Sep 2026, about 00:00

Tim (verbatim): *"continue with the building overnight as well just manage usage until Friday midday or when weekly resets please, you manage that"*

**Meaning:** Claude builders continue overnight alongside Codex, held to the budget line in the 23:30 entry (about 1% of the week an hour, to about 97% at Friday 12:00). In practice that is one Claude builder at a time, on Civil behaviour first. A second one (Structural) runs when usage is under the line at a checkpoint. The release chat manages this, not Tim.

## LU stays as it is; Codex pass 8 now — Tim, 24 Sep 2026, about 07:50

Tim (verbatim): *"keep lu as is, it stands for layer update. can you get codex to do pass 8 now on autocad"*

1. Structural's LU (layer update) keeps importing the office layer settings straight away, with no confirmation.
2. Codex pass 8 was started at about 07:50 on Tim's AutoCAD, at his request, covering the overnight windows.
3. Tim, minutes later (verbatim): *"yes to windows"*, answering queued item 20. CDDESIGN, CDRAINFALL and CDLPD switch from command-line prompts to their new windows (PR #146), with named Design entries on the ribbon.
