# Re-review: PR 2078 `claude/trust-01b-other-drawings-data` (BUG-1456 follow-up, the opening line says when a drawing holds another drawing's CE data)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:35 PC clock. **Head reviewed:** `26f110fa`, since `5bde761b` (reviewed GO at 06:57, `reviews\claude-trust-01b-other-drawings-data.md`). One commit, tests only (`Modules/Drainage.Tests/Services/OtherDrawingsDataTests.cs`, 48 lines added). Read only.

---

# FOR TIM

1. **Only tests were added:** one built like the mixed-up drawing the robot actually saw (an older job holding the standard drawing's 11 pits and 49 pipes), which must get the warning line, and one for the same older job saved under a revision name, which must get the usual line.
2. **The product code is unchanged since the GO,** so that GO holds.
3. **The one-count change for Check Current Drawing (my earlier small item) is coded on the builder's PC but not pushed;** the robot case for it in the test list (row 13) will fail on this head until it is.

**Verdict: GO** holds for the robot on copies (rows 1 to 12 and 14 of its test list; row 13 waits for the push).

---

# Findings

1. **Tests only, made-up paths.** Both new cases use `C:\made-up\...` file names and made-up object numbers; no client data. They go through the same `Look` helper as the existing cases (the real rule and the real counting).
2. **The seen drawing.** 60 recorded pits and pipes, 55 not drawn here (92 percent), stored name another drawing's: the warning line. Above the 50 percent DRAFT default (`Rules/OtherDrawingsDataRule.cs:22`, `MostAreNotDrawnHere` line 41-47), and it models a few object numbers that happen to exist in both jobs, which the evidence makes likely. Good.
3. **The same job as a revision.** Its own record, every object drawn, only the file name new: the usual "all linked" line. This is the quiet case most likely in daily work. Good.
4. **Still open from the first review:** in Check Current Drawing the "not drawn here" count and the "not linked" items under it can disagree (the one-count change, lane item 10(b), coded locally, not on `26f110fa`). `PENDING_TESTS.md` row 13 already describes the one-count behaviour, so the robot must skip it on this head or wait.

# What I did not check

1. No build or test run (the lane reports 76 of 76 opening-line tests).
2. The unpushed one-count change.
