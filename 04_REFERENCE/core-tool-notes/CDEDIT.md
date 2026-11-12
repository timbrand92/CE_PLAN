# CDEDIT: tool note (DRAFT, Edit a pit or pipe)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Edit a pit or pipe (CDEDIT)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens Edit Pipe or Edit Pit for the pit or pipe you pick. Edit Pipe is one page with a "Review changes" step before Save. Edit Pit has tabs for the pit, levels, connections and drawing choices. It is the most used button (27 ribbon clicks, 7 Sep to 4 Nov).

2. WHAT IT CHANGES IN THE DRAWING
   The size, levels and text of the item you save. First it runs CE's quiet update of the record (the audit names Edit Pit and Edit Pipe). The window remembers about 60 last-used values (CD_RecentValues), which can make results differ from person to person.

3. WHAT IT WILL NOT DO
   Help says one item at a time. The bug records talk about editing several pits at once (BUG-674, BUG-1049). Which is true is not known.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick one pipe or pit, then a window. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known. The quiet update may overwrite typed levels from drawing text (audit). BUG-1043: a blank invert refuses Save. BUG-1049: one blank field blocks a batch Apply.

6. HOW TO UNDO IT
   Not fully known. REDO after a pit pick fails in every robot session (BUG-861). The swap-levels arrow in Edit Pipe passed (BUG-1222).

7. KNOWN FAULTS
   BUG-674: several pits resized leave pipes short (HIGH, fix installed, untested).
   BUG-677: pits with no record all get one number.
   BUG-291: batch design grade uses the wrong end.
   BUG-1043: a blank invert refuses Save.
   BUG-1049: one blank field blocks a batch Apply.
   BUG-173: the window is still in progress.
   BUG-1239: pipe text 450 units off centre.
   BUG-861: REDO after a pit pick fails.

8. ON AUTOCAD 2022 TO 2024
   Not known. Never checked.

9. PROVEN BY
   Robot cases: 1 on record (R20, with a faulty twin, Claude-accepted). Codex looks: not known. Tim's trial: hand pass 29 Oct for "keeps the selection" only (D17) and the swap-levels arrow. The whole tool has no acceptance. Daily use, no dated trial.
```
