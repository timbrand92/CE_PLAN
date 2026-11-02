# BRIEF W396: double-click on a placed Pit Schedule (BUG-396 item 1)

Written 3 Nov 2026 by Claude (job w396, B-178). No code built, no PR opened.

1. **What is unbuilt.** On origin/claude/rel-20261102a (3fbb9da5), `Modules/Drainage/Services/DoubleClickEditTable.cs` lists "pit-schedule" as a NoWindow row (about line 124): "it does not open on a chosen placed schedule yet; that needs its own workflow card (G5)". So a double-click on a schedule cell reaches AutoCAD's own text editor (MTEDIT), as Codex L4-08 saw on 18 and 19 Oct. Earlier BUG-396 commits cover only the Manager diagnostic wording (item 6) and the bare-8 rename rule (7a).
2. **Why it stops here (two stop rules).**
   1. It is a NEW double-click route (a table-cell double-click that opens CE), so it needs the command card (G5) and Tim's approval before code.
   2. It needs a window change: `PitScheduleDialog` has no way to open at a given pit or cell (no start-at entry point found). That is Codex-owned.
3. **Intended behaviour (D-pack, from the carpark).** Double-click on a placed schedule cell opens the Pit Schedule window at that cell's pit. Cancel, Esc and U must leave the drawing untouched. A locked layer, Xref or REFEDIT schedule keeps AutoCAD's normal protection (never unlock).
4. **Proposed build once the card is approved.**
   1. Settings switch `doubleClick.pitScheduleOpensWindow`, ON by default, "Default: on."; OFF returns AutoCAD's text editor exactly. Pinned in the new-switch-defaults test through both start-up reads.
   2. Civil: change the pit-schedule row to a real window kind; resolve the clicked table to the schedule record; hand the pit name to the window.
   3. Codex window brief: Pit Schedule window opens with that pit's row selected and visible. No new prompt.
5. **Questions for Tim (one line each).**
   1. Should a double-click on a cell of a LOCKED or Xref schedule open the window read-only, or leave AutoCAD's own behaviour?
   2. Should a double-click on a header or title cell open the window at the top, or do nothing CE-side?
6. **Robot case when built.** Place a schedule, double-click the P2 cell, expect the Pit Schedule window with P2 selected and no MTEDIT and no "Undefined shape" lines. A second case with the switch OFF expects MTEDIT as today.
