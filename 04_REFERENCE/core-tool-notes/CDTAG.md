# CDTAG: tool note (DRAFT, Tag or retag a source)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Facts are from the installed Civil code copy (commit cf059dcf), its shipped Help text and command list, and the records (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, `BUG_CARPARK.md`). "Not known" means no record or code line says. Nothing here was run in AutoCAD. Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.

```
TOOL NOTE (DRAFT): Tag or retag a source (CDTAG)
Core since: not yet
Build this note describes: Civil 3.0.90 (commit cf059dcf), as installed on 12 Nov 2026. Not checked in AutoCAD for this note.

1. WHAT IT DOES
   Numbers or repairs the tag of a source block you pick. It can also register an unusual block (AGI, water tank, council block) so CE knows it.

2. WHAT IT CHANGES IN THE DRAWING
   The tag on the picked block and its entry in CE's record. Not known: anything else.

3. WHAT IT WILL NOT DO
   Not known. A retag can be refused, and the refusal wording needs work (BUG-814).

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pick the block, then tag prompts. Enter: not known.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   BUG-927: it says "removed" when nothing was tagged. That is a result that did not happen.

6. HOW TO UNDO IT
   Not known. Never checked.

7. KNOWN FAULTS
   BUG-927: says "removed" when nothing was tagged.
   BUG-814: retag refusal wording (fix installed, Codex look was blocked).
   BUG-742 and BUG-740 (fix installed, not accepted).

8. ON AUTOCAD 2022 TO 2024
   Not known.

9. PROVEN BY
   Robot cases: 2 runs on record (runs 34 and 35). Codex looks: 1 blocked (W1-05, test copy). Tim's trial: none.
```
