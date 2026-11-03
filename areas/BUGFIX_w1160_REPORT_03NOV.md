# BUGFIX w1160 report, 3 Nov 2026 (BUG-1160, B-194)

**Result: STOPPED, no PR opened.** Needs one answer from Tim before any code.

## FOR TIM

1. **What I found:** the bug is real. A drawing only remembers "CVL" or "STR". It does not remember which CE build last saved it, or the highest build ever to touch it. So when an older build strips newer data (BUG-1135, BUG-1147) nobody can tell afterwards.
2. **Why I stopped:** the fix is not a small change. The marker is only written at the moment a drawing is tagged (the first-use question, or the discipline command). Nothing is written on a normal save. "Saving writes both fields" means a new write into the drawing on every save. That is a new save-time write, which the REDO rule says to avoid unless the fix truly needs it, and it can turn a clean drawing into an "edited" one.
3. **The question for Tim (one line):** when someone saves, should CE stamp the version only into drawings that already carry a CE tag or CE data (never into plain non-CE drawings)? My recommendation: yes, only tagged or CE drawings, stamped at save, and only when the stamp would actually change (so an unchanged build does not dirty the drawing).
4. **Mistakes of my own:** none made. No code changed, no build run, no test run, no AutoCAD, no worktree created.
5. **Not proven:** nothing was tested. The fault is confirmed by reading the code only.

## Technical detail

1. **Base:** origin/claude/rel-20261102a (3fbb9da5). Not ALREADY FIXED: no LastWrittenBy or HighestVersion fields exist anywhere under Modules/Drainage.
2. **Where the marker lives:** `Modules/Drainage/Services/DrawingDisciplineService.cs`, NOD dictionary `CE_CVL_DISCIPLINE`, key `DISCIPLINE`, one text value. Written by `WriteExplicitTag` (line ~314) and `ApplyCivilApprovalInTransaction` (line ~233). Callers: `DisciplineCommand.cs:68` and the first-use prompt (line ~137). Both are command paths, never a save hook.
3. **Strict reader:** `ReadExplicitCodeStrict` (line ~240) requires the DISCIPLINE xrecord to hold exactly one value. So the new fields must go in separate keys in the same dictionary, never inside DISCIPLINE.
4. **Why not small:**
   1. Needs a hook on QSAVE/SAVE/SAVEAS (`LinkService.Reactors.cs` flush path, a large shared file) to write at save time.
   2. Policy questions: which drawings get stamped, dirty-flag behaviour, and "a lower version never lowers the highest" needs a version compare against the running build.
   3. The same bug names Structural; the Structural marker is separate, so a Structural half needs its own PR on claude/rel-20261026s.
   4. CE_SHARED is not needed so far.
5. **Proposed design once Tim answers:** two new keys `LAST_WRITTEN_BY` and `HIGHEST_VERSION_WRITTEN` in `CE_CVL_DISCIPLINE`, written in the existing save flush only when the drawing already has the dictionary or CE data and the value would change. Settings switch ON by default (name to follow house pattern, "Default: on."), pinned through both start-up reads. Unit test on a pure compare helper (lower never lowers highest, blank or garbage treated as none).
6. **Robot case (when built):** `N_bug1160_version_stamp`: open a CE-tagged drawing, QSAVE, read the job record for both fields; save again from a lower build value and check the highest field did not drop; switch-off control: with the switch off, the dictionary holds only DISCIPLINE.
7. **Isolation and disk:** no dotnet test run, so no before/after APPDATA listings were needed. C: free about 76 GB, unchanged.
