# BUGFIX S-10 report (Sat 31 Oct 2026, 02:55 Melbourne time, key s10)

## ANSWER FIRST

**No PR opened. Both items (BUG-630 and BUG-631) were skipped on purpose.** Both are still faulty on the installed Structural line (origin/claude/rel-20261026s, head 204dfad2, Structural 1.0.125). Neither is a small, safe change: each is a rebuild of how the Section Mark tool behaves, and the plan says that needs Tim's card approval before any code. Nothing was built, no test was run, no settings file was touched.

## FOR TIM

1. **BUG-630 (SM asks for points before the number and sheet, then draws at once).** Still true on 1.0.125. SM still asks start point, end point, view direction, then the identifier and the sheet, and then draws the line and both bubbles immediately. There is no final picture and no "accept" step. Skipped because the fix is a new interactive preview, which cannot be seen or proved without AutoCAD, and because the plan (AS-01 card, 04_REFERENCE) says the bubble graphics must come from your approved CE blocks (SECT MARK) and not from newly drawn geometry. That block-or-drawn question is unanswered.
2. **BUG-631 (a normal MOVE of the cut line leaves both bubbles and the A/S02 labels behind).** Still true on 1.0.125. The five pieces of a section mark (line, two bubbles, their hatches and texts) are separate objects with nothing joining them, so MOVE only takes what you pick. Making them move together needs a new link between the pieces (a group, or a watcher on the drawing). That adds new writes and behaviour that can disturb Undo and Redo, so it needs a reviewed design and an AutoCAD run. The entry itself says not to solve it by grabbing nearby objects.
3. **What I need from you (questions go to CE 04):**
   1. Should the section-mark bubble be drawn from your approved SECT MARK block, or stay as drawn geometry? Recommendation: the block, as the AS-01 card already says. On a job this decides whether a moved or edited bubble keeps your standard look.
   2. Approve the SM card (ST3-9, ST3-10) in review order: number and sheet first, then points, then direction, then a full preview you accept with Enter. Recommendation: yes, with a Settings switch ON so the old order can be brought back.
4. **Mistakes of my own:** none that cost anything. I did not build, so nothing in your AutoCAD or on disk changed.
5. **Not proven:** nothing was tested. I did not run AutoCAD, the robot, or any test.

---

## Technical detail

1. **Start point:** origin/claude/rel-20261026s at 204dfad2 (fetched 02:51). Nothing else was read from other branches.
2. **BUG-630 evidence:** `Modules/Structural/Commands/SectionMarkCommands.cs`, `CreateSectionMark()`. Prompt order is: start point (GetPoint, around line 49), end point, view direction (GetKeywords), then `AskIdentifier` / `AskSheet` (lines 73 to 92), then one `UndoMarkScope` plus transaction that appends the cut line and both `CreateBubble` calls and commits (lines 107 to 140). No preview, jig or transient graphics, no final confirm. One existing switch only changes the order of sheet and identifier (`Annotation.SectionMarkOfferNextIdentifier`, default off, UX-SEC-01 slice 1). BUG-632's switch (`SectionMarkIdentifierInClearHalf`, default off) is unrelated.
3. **BUG-631 evidence:** the only code that mentions the section tag is `SectionMarkRegistry.WriteTag` (XData on the cut line only, for numbering) and `NextIdentifier`. The bubbles, hatches and texts carry no tag and no link to the cut line. No overrule, `ObjectModified` handler or group exists for section marks (the only reactor in the Structural module is `BeamLinkService.Reactors.cs`, beams only). So MOVE cannot move the set.
4. **Why no switch-guarded patch:** a preview and Apply step is new interactive behaviour with approved-card wording I cannot check without Tim (mandatory command review gate in AGENTS.md: card approved before code). A compound move needs a linking mechanism (new data on the bubbles, a handler on modify) that adds writes during MOVE, which collides with the REDO-safe rule (BUG-861) unless designed and driven in AutoCAD.
5. **Ranked suspects if someone builds it later:**
   1. BUG-631: tag every part with the same record as the cut line (`SectionMarkRegistry`), then a database-modified handler that moves the siblings by the same displacement; Undo must undo them together, so a single command-ended pass is safer than a per-object handler.
   2. BUG-630: reorder to identifier, sheet, points, direction using the existing `AskIdentifier` and `AskSheet`; preview with transient graphics built from the same `CreateBubble` geometry (or the block); final GetKeywords Accept/Cancel.
6. **Shared files:** `SectionMarkCommands.cs`, `SectionMarkRegistry.cs`, `UserSettings.cs`. `gh` is not available in this shell, so I could not run `gh pr list --state open --search`; I looked at worktree branch names instead (p15 BUG-467, p5 BUG-1183): neither touches section marks. Clash check is therefore NOT done through GitHub; whoever builds this should run it.
7. **Carpark:** BUG_CARPARK.md not edited. Both entries stay OPEN, as they are.
8. **Tests:** none run (no test command issued). Test-isolation variables were not needed.
9. **Real-files listing (before and after, taken at 02:52, no test code ran, so these are only to show nothing of mine changed):** Both listings are the same moment because nothing ran in between. The big folders hold tens of thousands of auto-save and log files written by other sessions, so only the settings files are listed. Names, sizes, last-write:
   1. `%APPDATA%\TIM_CE_CADTOOLS`: CD_Settings.json 15270 B, 04 Oct 08:22:30; CS_Settings.json 351713 B, 31 Mar 13:18:00; CD_ProjectData.json 8278 B, 27 Jan 12:06:06; parts_catalogue.json 5910 B, 15 Sep 15:33:16; label_styles.json 526 B, 28 Apr; theme.json 1390 B, 19 Dec 2025; CD_RecentValues.json 12222 B, 31 Oct 02:52:03 (written by the running robot, not by me); 28653 files in total, newest write 31 Oct 02:52:44 (robot logs).
   2. `%APPDATA%\CE_STRUC_SUITE`: CS_Settings.json 35613 B, 30 Oct 19:54:14; CS_Settings.json.PRE_TIM_YES_20261020.bak 34858 B, 18 Oct 10:00:24; 2499 files, newest write 31 Oct 02:52:20 (logs).
   3. `%APPDATA%\CE_CVL_SUITE`: settings.json 672 B, 16 Sep 12:13:17; settings.PRE_WORKSHOP_20260916.json.bak 672 B, 16 Sep 11:55:58; 269 files, newest write 31 Oct 02:52:44 (logs).
   4. `%APPDATA%\CE_CADTOOLS`: install-id.txt 32 B, 19 Aug 16:17:45; 1022 files, newest write 31 Oct 02:51:49 (logs).
   5. No settings file changed during my session. A full per-file listing of CE_Admin\outbox and logs was not put here (about 29,000 lines, client names inside auto-save paths); the script is `C:\ce-scratch\s10\list.ps1`.

## Questions for CE 04 (via QUESTIONS_FOR_MONDAY.md, sent by CE 05)

1. Section-mark bubble: approved SECT MARK block, or drawn geometry as now? Recommendation: block.
2. Approve SM card order and the full-preview-then-Enter step (ST3-9) and the move-together rule (ST3-10)? Recommendation: yes, switch ON.
