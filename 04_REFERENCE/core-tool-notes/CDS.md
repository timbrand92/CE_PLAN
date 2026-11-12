# CDS: tool note (DRAFT, Settings)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Settings (CDS)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Opens the drafting and design defaults that control CE Civil drawing output: Drafting, Pipes and Pits, Design, Survey, Display and Advanced. They are your defaults on this computer. About 574 settings, 255 of them on or off.

2. WHAT IT CHANGES IN THE DRAWING
   Nothing in a drawing. It writes your settings file (CD_Settings.json). Saving writes every value, so anyone who has ever pressed Save keeps that day's values and later office changes do not reach them (audit).

3. WHAT IT WILL NOT DO
   It does not send one setup to everyone: there is no export, no import and no office file today (plan step 3).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Open a tab, change the named value, Save. Enter in an empty search saves the whole draft and closes the window (BUG-957).

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not known.

6. HOW TO UNDO IT
   Not known. The Manager Settings page can undo a change you just saved (BUG-839).

7. KNOWN FAULTS
   BUG-839: the Manager Settings page can undo a change just saved (loses a change, fix installed, untested).
   BUG-957: Enter in an empty search saves and closes.
   BUG-958: the window position is not remembered.
   BUG-227 (fix installed, untested).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: none. Codex looks: none. Tim's trial: his 5 clicks. No dated trial.
```
