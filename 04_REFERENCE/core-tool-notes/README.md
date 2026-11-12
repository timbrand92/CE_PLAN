# Core tool notes: rewritten from the installed code, not yet seen in AutoCAD

**Status, Fri 13 Nov 2026, about 01:15 PC clock:** all 47 notes were rewritten overnight from the installed code (Civil 3.0.90). Each note ends with "Where this comes from", listing the file and line for its facts, and the line "Checked against the installed code".

**What that does and does not mean:**

1. **It replaces the first set,** which was written from old records and was wrong in every note sampled (`areas\trust-run\reviews\core-tool-notes-sample.md`).
2. **Read from code, not seen working.** Nothing in these notes was run in AutoCAD. A note is a DRAFT until the tool has passed its own checks on copies.
3. **Helpers read the code for 42 of the 47 tools;** the writer re-checked the surprising claims and read three tools itself. The notes have not yet had their own independent review.
4. **Section 9, "Proven by", says "not counted" on every note.** The code cannot show what has been proven.

**Two lists that came out of the rewrite:**

1. `areas\trust-run\BUGS_FIXED_IN_CODE_NOT_PROVEN.md`: about 170 bugs the records still list as open that the installed code appears to fix. None may be marked fixed until seen in AutoCAD.
2. Sixteen new faults seen in the code with no bug covering them; being added to `BUG_CARPARK.md`.

Format: `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3.
