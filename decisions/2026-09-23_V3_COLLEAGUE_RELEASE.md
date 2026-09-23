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
