# CDDEST: tool note (DRAFT, Where each downpipe ends up)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Where each downpipe ends up (CDDEST)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Follows the pipes that are drawn from each downpipe and says where it ends up: a tank, or straight out to the legal point of discharge. It names where the trail stops when it cannot be followed. It offers to record those answers against this drawing.

2. WHAT IT CHANGES IN THE DRAWING
   Only if you accept: it records a destination against the drawing. Otherwise nothing. The pending list says it changes nothing on an older drawing.

3. WHAT IT WILL NOT DO
   It records a destination only when you ask and the drawing supports it (Help). It does not follow a trail it cannot see.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Check each traced route, then choose whether to record. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It names where a trail stops when it cannot be followed.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   None on record. An older fault (BUG-156, a redesign forgot a recorded destination) had a test queued; no pass was found.

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: his 3 ribbon clicks. No other evidence.
```
