# CDTWL: tool note (DRAFT, Top water level)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Top water level (CDTWL)
Core since: not yet. Two open faults hide a warning, see item 7.
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Works upstream from a detention pit or tank outlet and lists every level the system could be held to, with where each came from. Once you pick one it reports the storage below it, the head on the orifice and any pit the water would come up out of.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing in the drawing (the command list says so). Not run in AutoCAD for this note.

3. WHAT IT WILL NOT DO
   It does not look at the floor level in some cases (BUG-1056). A pit with an unknown floor level drops out of the lid check with no warning (BUG-1021).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick the detention pit or tank outlet, select a level, read the effects. When two systems share pit numbers it picks P2 without asking (BUG-970). The default is the highest invert, not the obvert (BUG-777; the switch is off pending Tim's ruling).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   It says "That is enough" when the level is 100 mm below a habitable floor and says nothing about not looking at the floor (BUG-1056). It does not warn about the dropped pit (BUG-1021).

6. HOW TO UNDO IT
   Nothing to undo (it changes nothing).

7. KNOWN FAULTS
   BUG-1056: says "That is enough" 100 mm below a habitable floor (hides a warning).
   BUG-1021: drops a pit with an unknown floor level from the lid check (hides a warning).
   BUG-970: picks P2 without asking when two systems share numbers.
   BUG-777: the default is the highest invert, not the obvert.
   BUG-871: metre drawing units (draft pull request, not installed).
   BUG-1032: the pick list shows a handle and "doubled pipe".

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 2 (R14 and R14h, two clean starts on 3.0.86, Claude-accepted for the freeboard card only). Codex looks: none. Tim's trial: none. When two freeboard settings disagree has never been tried. 1 ribbon click.
```
