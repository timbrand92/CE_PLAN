# Three handover prompts — 18 September 2026

Each block below goes into **one existing chat**. They all do the same job: stop, package what you
built, push it, and write your section into one shared file so the COMBINE chat can merge all three
into a single payload. The COMBINE chat's own starter is the appendix of
`CHAT_PROMPT_FIXES_2026-09-18.md`.

**Shared handover file, all three write into it:**
`C:\CE_PLAN\01_MASTER_PLAN\COMBINE_HANDOVER_2026-09-18.md`

---

## 1 — paste into the WINDOWS / DEPLOY chat

```text
RUN CONFIG
Model: Claude Opus 5. Thinking: medium.
Why: packaging and verifying your own work, not writing new behaviour. High only if you find a fault
while checking.
Downgrade option: Sonnet + medium is acceptable for this task alone.

STOP building. Package what you have for the COMBINE chat.

Your branch: claude/civil-combined-2026-09-17.
The tip you believe you are on is c9dac1bc. VERIFY IT: git fetch && git rev-parse HEAD and
git rev-parse @{u}. Report both. If they differ, push before you write anything.

Write your section into C:\CE_PLAN\01_MASTER_PLAN\COMBINE_HANDOVER_2026-09-18.md, appending — never
overwriting anyone else's section. It must contain, and nothing may be left out:

1. Branch, exact tip commit, and "pushed: yes/no" verified with git, not remembered.
2. Every change since the installed build 3.0.0+d0ffe1a2, one line each, in drawing terms:
   W-06 (the tank picker stops putting the wrong name on tanks), W-07 (CDWT warns when it used a
   different standard detail), W-08 (the tank window explains an empty plan list), the DRYRUN-01
   withdrawal, and the Edit Pipe label-fit CONTRACT (a document, not a code change).
3. Files you changed, listed. Flag loudly that you edited
   Modules/Drainage/Commands/PipeEditCommand.cs — the other-Civil-areas chat has ALSO edited it and
   PipeEditCommand.Update.cs. That is a real conflict the COMBINE chat must resolve by keeping both.
4. Your last full test result: run it again now, do not quote an old one. Builds on all three lanes,
   and the full net10 suite with FAILING TEST NAMES compared against the 22 in PENDING_TESTS.md.
5. What is UNTESTED in AutoCAD — which is everything you built. Say so plainly.
6. The corrections you had to make: that the dry-run withdrawal does NOT fix P13, and that P12 is
   not preview-only. Both are already in REGRESSION_LOG under "CORRECTION (2026-09-18)". Point at
   them so the COMBINE chat does not re-import the wrong story.
7. Anything you left half-done, and anything only Tim can answer.

Then: confirm your worktree is clean and local == remote, and STOP. Do not start new work, do not
deploy, do not edit another chat's files. Reply to Tim with FOR TIM first: one short list of what you
handed over and where it is.
```

---

## 2 — paste into the OTHER CIVIL AREAS chat (C7 / labels / sources)

```text
RUN CONFIG
Model: Claude Opus 5. Thinking: medium.
Why: packaging and verifying your own work. High only if checking turns up a fault.
Downgrade option: Sonnet + medium for this task alone.

STOP building. Package what you have for the COMBINE chat.

Your branch: claude/civil-other-areas-handoff-d747af, believed tip 24d9230f.
VERIFY IT: git fetch && git rev-parse HEAD and git rev-parse @{u}. Report both, and push if behind.
On 17 September this chat handed over a tip that was already stale and it caused a bad install.
Do not let that happen twice.

Write your section into C:\CE_PLAN\01_MASTER_PLAN\COMBINE_HANDOVER_2026-09-18.md, appending only.
It must contain:

1. Branch, exact tip, pushed yes/no — verified with git.
2. Each of your seven commits since the installed build 3.0.0+d0ffe1a2, in drawing terms:
   IDENT-02 / P-07 (a pipe's own text recognised as CE's on a job you have just opened),
   BLANK-01 (emptying a level box deletes the level instead of the old one coming back),
   T-01 (CDFIXTAGS stops contradicting itself and says what it did once),
   P-02 (the split level sits at the pit the pipe was split at).
   Say for each whether it has EVER been opened in AutoCAD. If not, say "nobody has opened it".
3. Your changed files. Flag loudly that you edited
   Modules/Drainage/Commands/PipeEditCommand.cs and PipeEditCommand.Update.cs — the windows chat has
   also edited PipeEditCommand.cs (it removed the dry-run preview wiring). The COMBINE chat must keep
   BOTH. Say in one line what your change to that file does, so it can be merged without guessing.
4. Re-run your tests NOW and quote the result: three lanes 0 errors, full net10 suite, and failing
   test NAMES compared against the 22 in PENDING_TESTS.md.
5. Your open questions for Tim, and anything half-built.
6. Anything in Codex's failure register (C:\Lisp Files\_TEST_COPIES_20260917\package\
   FAILURE_EVIDENCE_REGISTER_2026-09-17.md) that your commits already fix — name the IDs. Several of
   the O-series and K-series findings may be yours. Do not claim one you have not actually addressed.

Then confirm the tree is clean and local == remote, and STOP. Do not deploy, do not start new work.
Reply to Tim with FOR TIM first: what you handed over, and which register IDs you believe you close.
```

---

## 3 — paste into the K / L chat (CDLPD · pit resize · tanks · propagation)

```text
RUN CONFIG
Model: Claude Opus 5. Thinking: medium.
Why: packaging and verifying your own work. High if checking turns up a fault.
Downgrade option: Sonnet + medium for this task alone.

STOP building. Package what you have for the COMBINE chat.

Your branch: claude/civil-k-l-2026-09-16, believed tip 457bf032.
VERIFY IT: git fetch && git rev-parse HEAD and git rev-parse @{u}. Report both, and push if behind.
IMPORTANT: only your work up to commit 26432227 reached the installed build. Your three later
commits — TWL-04/TWL-06, TWL-05 and PSD-01 — are NOT installed and Tim has never seen them.

Write your section into C:\CE_PLAN\01_MASTER_PLAN\COMBINE_HANDOVER_2026-09-18.md, appending only.
It must contain:

1. Branch, exact tip, pushed yes/no — verified with git.
2. The three uninstalled commits in drawing terms:
   TWL-04/TWL-06 (CDTWL takes the engineer's own level and stops losing the system),
   TWL-05 (the required volume was born as "0.0" and that zero reached a council drawing),
   PSD-01 (the permissible site discharge stays empty until entered or found).
   TWL-05 sounds serious — say exactly what a wrong figure would have looked like on a drawing.
3. Your changed files.
4. Re-run your tests NOW and quote the result, with failing test NAMES compared against the 22 in
   PENDING_TESTS.md — never counts.
5. Read these three items in Codex's evidence and say whether your commits address them, do not
   address them, or make them testable. Do not claim a pass you have not seen:
   - L1 / L4: growing a pit still leaves a gap between the pipe ends and the new outline.
   - L6 / L7 / L8: CDTWL could not be tested at all — "no records", then "no detention pit". Codex
     could not establish any system total. Say what a drawing must contain for CDTWL to work, in
     plain words, so Tim can pick a real job.
   - L10 / L13: converted pipes give blank schedule levels, and locked labels leave the drawing and
     the schedule saying different things.
6. ONE THING YOU MUST HAND OVER EXPLICITLY, because it is now the second repair on Tim's list:
   PitEditCommand.ShiftAnnotation moves a pit label with `br.Position = p` and never touches
   `br.AttributeCollection`. The label block holds a wipeout (the circle) and the number as an
   ATTRIBUTE with its own position — so the circle moves and the number is left behind, on the
   DRAWING, not just in the preview (Codex P12 and P14). PitAnnotationShift and
   PitEditCommand.Resize are in YOUR fence. State clearly whether you want to fix it or hand it to
   the FIXES chat, so two chats do not edit it at once. This may also be the answer to the
   long-running BUG-151 / P-08 "the pit label will not step out" puzzle.
7. Still unanswered by Tim: the street-note wrap width. Five versions were drawn for him on 17
   September and he has not picked one. Do not decide it for him — carry it forward as his.

Then confirm the tree is clean and local == remote, and STOP. Do not deploy, do not start new work.
Reply to Tim with FOR TIM first: what you handed over, and the ShiftAnnotation ownership answer.
```
