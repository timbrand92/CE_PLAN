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

## Answers — Tim, 23 Sep 2026, about 10:55am (clickable choices; question 3 typed by Tim)

1. **Who gets it on Tuesday:** *"One colleague first"* (Claude's recommendation).
2. **What ships:** *"Newest saved work"* — **not** Claude's recommendation (a copy of Tim's AutoCAD frozen Thursday). Taken as given. Claude's reading: the colleague build is the saved main line (`master`) at the freeze, including changes Tim has not drawn with yet.
3. **Which AutoCAD colleagues run:** *"some on 2022 and some on 2027"*
4. **Structural moves too:** *"Yes, all three together"* (Claude's recommendation). Civil, Manager and Structural move as one, carrying the same common library.

### What these answers mean for the plan (Claude's reading, not Tim's words)

1. The **2022 lane is in scope** for the release, not only 2027. Tim's Structural 1.0.74 has no 2022 lane, so Structural must be built for 2022 from the same source before any 2022 colleague moves.
2. The pilot colleague's AutoCAD version decides what Tuesday needs. **Still open:** which colleague, and on which AutoCAD.
3. "Newest saved work" means anything another chat merges into `master` before the freeze reaches a colleague. The deploy register #78 is told the freeze time.

## Second round — Tim, 23 Sep 2026, about 11:30am

1. **Who tests in AutoCAD:** *"i can get codex to do all testing on autocad whenever up until tuesday"* — typed by Tim instead of choosing the pre-check plan. **Override recorded (RULES 14.6), scope: AutoCAD testing for this release, until Tuesday 29 Sep.** Codex produces evidence; only Tim's word accepts. Run list: `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`.
2. **Pilot colleague:** *"I'll tell you later"*. Needed by Monday 28 Sep.
3. **A 2022 PC for 30 minutes on Monday:** *"Yes, Monday"*.
4. **This chat controls deployment** — Tim's words as relayed by the E-HOLD chat ("Pipe points locking to grade/invert"), 23 Sep: *"CE_ACAD / release-v3-colleagues / plan / 01 this chat controls deployment"*. Relayed, not heard directly by this chat.

## Open, found 23 Sep about 11:20am — "newest saved work" and "Structural exactly as you use it" are different builds

Read from git, not from a document:

1. **Civil:** the saved main line is the installed `d90659cf` plus one change (CDWT-LINK-01, a tank finds its own plan). No conflict.
2. **Manager:** Tim runs `96e7d76a`. The saved main line has **38 more Manager changes** (including new Project QA pages) that **have never been installed on any PC**.
3. **Structural:** Tim runs `1.0.74+5d723d41`, which is **not on the saved main line at all**: it lives on the Codex Structural branches (`codex/structural-ui-preservation-20260915` and others). The saved main line has 53 different Structural changes (including SML and CHECKML), also never installed.

**Question put to Tim:** for Manager and Structural, ship exactly what he runs, or the saved main line. Claude recommends what he runs: it is the only combination anyone has used, and it builds for 2022 as well as 2027 (checked: `5d723d41` targets net48, net8 and net10). ~~**Unanswered — stays open.**~~

**Tim's answer, 23 Sep 2026, about 11:45am:** *"Newest saved for all three"* (not Claude's recommendation).

### CORRECTION — the evidence put to Tim for Structural was incomplete (Claude, 23 Sep, about 11:50am)

**Tim's words above are unchanged. The question he answered described the saved Structural as "a different mix that nobody has installed". It did not say that the saved one is OLDER.** Read from git after his answer:

1. **Saved main line Structural is version 1.0.42.** Tim runs **1.0.74**. Colleagues run 1.0.40 and 1.0.41.
2. **128 Structural changes in Tim's 1.0.74 are not on the saved main line** (patch-equivalent commits excluded), including the SBEAM repeat placement, SBEAM edit, picker and Undo corrections, the startup palette fix and CEARCHREVIEW.
3. **Tim's 1.0.74 does not use the common library at all** (`fix(structural): isolate standalone runtime from CE_SHARED`, 25 Aug). The saved 1.0.42 still does, so it would bring the shared-library risk back into Structural.
4. **Installing "newest saved" Structural on Tim's PC on Friday would roll his own Structural back from 1.0.74 to 1.0.42.**
5. The newest Structural work anywhere is `codex/structural-ui-preservation-20260915` @ `60c41228`: Tim's 1.0.74 plus 4 window recovery commits (Settings save and Cancel, Publish validation), never installed.

**So for Structural, Tim's answer is re-asked with these facts** (the BUG-161 lesson: a ruling made on incomplete evidence is re-put, not acted on). **Manager and Civil stand as answered:** the saved Manager genuinely contains Tim's installed `96e7d76a` plus 38 newer changes; the saved Civil is his installed build plus CDWT-LINK-01.
