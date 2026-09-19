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
