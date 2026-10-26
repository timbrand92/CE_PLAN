# Tim ruling, Mon 26 Oct 2026 (about 17:15 Melbourne): adopt ArchUnitNET; smaller, regular updates; the testing number must go up

Tim's words (chat, 26 Oct 2026): "adopt archunitnet, do smaller regular updated i need this testing number to go up, weve been doing hardly anything for weeks now"

## What this decides

1. **ArchUnitNET is ADOPTED** (answers QUESTIONS_FOR_MONDAY item 11, TOOL-ARCH-01). Scope as the trial recommended: the four "who may use whom" rules between CE_SHARED, Civil, Manager and Structural become permanent tests (start green, run on net48 and net10). The "no hidden download" and "never unlock a layer" rules are NOT guarded by ArchUnitNET alone (async blind spot): keep the Cecil-based read as a second check and do not claim more than the trial showed. The tests are test projects only: nothing in the shipped plug-in changes. Work: `team_archunit_adopt.txt` (Team, Sonnet) after C-70; the draft trial PR #1780 stays unmerged (the adoption is a new PR).
2. **Smaller, regular updates.** Rule from now: a train carries at most about 6 reviewed PRs (a single diagnostic PR is fine); a Civil/Manager or Structural update is started as soon as 3 or more reviewed PRs are waiting, not saved up; target one install about every 4 to 6 hours when PRs are waiting. C-69 (11 PRs, about 5 hours from assembly to install) is the largest acceptable size. Big review sets are split into two trains.
3. **The testing number comes first.** Tim: the tested/accepted numbers have hardly moved for weeks. From now the robot never idles: a standing queue (`ROBOT_QUEUE.txt`, run by `chain_robot_standing.ps1`) starts the next job on its own when the previous one ends, with a 3-minute AutoCAD gap for installs. Every install is followed by the two-session regrade of the accepted pack on that build. Codex keeps reviewing hardened cases inside its daily cap so cases reach Claude-accepted.
4. Plan-item pause (ruling A) is unchanged until Tim is back on Thu 29 Oct; this ruling is about bug-fix trains, tests and guards.

## Record

Written by the desk. The interpretation of "smaller regular updated" (point 2) is the desk's reading; Tim can change the numbers.
