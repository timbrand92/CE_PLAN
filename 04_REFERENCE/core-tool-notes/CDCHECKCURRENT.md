# CDCHECKCURRENT: tool note (DRAFT, Check this drawing (today's button))

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Check this drawing, today's button (CDCHECKCURRENT)
Core since: not yet. The new "Check this drawing" door (plan step 8) is not built. Until then the button opens this read-only check.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Shows what CE can read in the open drawing and what needs checking. It prints "[CE] Drawing check complete. N items need checking. Nothing has been fixed automatically." (read from the code). If "the one Checks list" switch is on (off by default) it opens that list instead.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing. It reads and does not sync, migrate or save (the code says so, and a changed-drawing counter check is built in). Not run in AutoCAD for this note.

3. WHAT IT WILL NOT DO
   It reads CE's own record. It cannot see pits or pipe lines that are drawn but not in the record (plan, step 1). General notes such as "No attached source drawings found" still appear in its list.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Nothing. It opens a window.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Each item says what it found and how sure CE is, for example "Observed in the saved Civil information" or "Needs engineering confirmation". If the check fails it says "CE could not check the current drawing. Nothing has been changed. Try the command again or close and reopen the drawing."

6. HOW TO UNDO IT
   Nothing to undo.

7. KNOWN FAULTS
   None on record.

8. ON AUTOCAD 2022 TO 2024
   Not known. It needs no ribbon.

9. PROVEN BY
   Robot cases: none recorded. Codex looks: none. Tim's trial: none. Never checked in AutoCAD for the five rules.
```
