# New findings filed to the carpark, batch B (24 Oct 2026)

133 new carpark entries, BUG-1088 to BUG-1220, from five Opus Team audits and ten Codex read-only audits written on 24 Oct. The next free number is BUG-1221. Every entry is OPEN. Nothing was marked fixed, nothing was reworded or deleted. The pure to-do items from T5 are in `areas/RELEASE_9NOV_TODO_FROM_T5_2026-10-24.md`.

**Counts by severity (as the audits ranked them):** 18 HIGH, 67 MEDIUM, 48 LOW.

1. **TEAM_AUDIT_T1_24OCT.md (hydraulics):** 7 entries, BUG-1088 to BUG-1094 (1 HIGH, 3 MEDIUM, 3 LOW).
2. **TEAM_AUDIT_T2_24OCT.md (water-sensitive design and council rules):** 26 entries, BUG-1095 to BUG-1120 (5 HIGH, 10 MEDIUM, 11 LOW). Finding 26 (three wording questions for Tim) is one entry, BUG-1120.
3. **TEAM_AUDIT_T3_24OCT.md (Structural sections and schedules):** 14 entries, BUG-1121 to BUG-1134 (0 HIGH, 4 MEDIUM, 10 LOW).
4. **TEAM_AUDIT_T4_24OCT.md (data integrity):** 30 entries, BUG-1135 to BUG-1164 (3 HIGH, 18 MEDIUM, 9 LOW), one per T4 finding in the report's own order.
5. **TEAM_AUDIT_T5_24OCT.md (9 Nov install readiness):** 14 entries, BUG-1165 to BUG-1178 (0 HIGH, 6 MEDIUM, 8 LOW). The 30-item checklist gave no further faults: every NOT MET item that is a real defect already has a number (see the to-do file).
6. **CODEX_AUDIT2_RD13_24OCT.md (Manager windows):** 4 entries, BUG-1179 to BUG-1182.
7. **CODEX_AUDIT2_RD14_24OCT.md (Structural commands):** 5 entries, BUG-1183 to BUG-1187.
8. **CODEX_AUDIT2_RD15_24OCT.md (LandXML and survey):** 4 entries, BUG-1188 to BUG-1191.
9. **CODEX_AUDIT2_RD16_24OCT.md (long section):** 4 entries, BUG-1192 to BUG-1195.
10. **CODEX_AUDIT2_RD17_24OCT.md (Pit Schedule and network editing):** 3 entries, BUG-1196 to BUG-1198.
11. **CODEX_AUDIT2_RD18_24OCT.md (undo, redo, dirty drawing):** 3 entries, BUG-1199 to BUG-1201.
12. **CODEX_AUDIT2_RD19_24OCT.md (startup and loading):** 3 entries, BUG-1202 to BUG-1204.
13. **CODEX_AUDIT2_RD20_24OCT.md (shared library):** 4 entries, BUG-1205 to BUG-1208.
14. **CODEX_AUDIT2_RD21_24OCT.md (2022 to 2024 compatibility):** 6 entries, BUG-1209 to BUG-1214.
15. **CODEX_AUDIT2_RD22_24OCT.md (help and tooltips):** 6 entries, BUG-1215 to BUG-1220.

**Reports not yet written:** RD23, RD24 and RD25 (first-run install, diagnostics and logging, transform module) did not exist when this was filed. They are not covered here; file them in a later batch starting at BUG-1221.

**Skipped, and why (none were skipped as an exact duplicate):**

1. **Known bugs the audits already named by number:** not re-filed. Examples: BUG-868, BUG-999, BUG-542, BUG-1036 (T1); BUG-538, BUG-544, BUG-546, BUG-547 (T2); BUG-818, BUG-819 (T3); BUG-971, BUG-665, BUG-1070, BUG-799 (T4); BUG-882 to BUG-888, BUG-477, BUG-948 (T5); and the exclusion lists at the top of each RD report.
2. **T1 "listed in AUDIT_ENGINEERING_CIVIL_2026-10-22.md with no BUG number found":** items 17 (nominal size used, not the bore), 18 (CDTWL orifice head), 19 (Casey banker's rounding), 25 (grade ladder lookup), 26 (600 mm cover default), 28 (self-cleansing uses full-bore speed). These belong to the 22 Oct audit, not to this report's new findings. If they are not already entries, they need filing from that audit; I did not re-check them. BUG-1091 (T1 finding 4) overlaps item 25 and says so.
3. **T3 hand checks and the T1 and T2 "hand calculations that match":** these are confirmations, not faults.
4. **Related but distinct, filed with a cross-reference:** BUG-1179 against HUNT-M-05 (office folder unreachable); BUG-1196 against BUG-785 (earlier step-iron refresh); BUG-1146 and BUG-1199 (same footing-size cache); BUG-1177 and BUG-1202 (same weekly time export); BUG-1209 and BUG-1137 (same older-lane COPY receipt gap); BUG-1174 and BUG-1212 (CDWT window); BUG-1114 against BUG-546.

**Flag for the owner of BUG-665:** T4 notes that its "fixed in 3.0.70" depends on a setting that is off by default (`CleanUpGripRotateScaleCopies = false`), so on a default install grip-Ctrl copy, ROTATE Copy and SCALE Copy still make twins. BUG-665 itself was not edited.

**Duplicate checking:** each audit grepped the carpark (to BUG-1087) before filing; I re-grepped the main words of a sample of findings and read the hits. The carpark's next-ID line was BUG-1088 before this batch and no other session had appended in the meantime.

**Top five HIGH to look at first:** BUG-1135 (an older CE silently deletes newer job data), BUG-1136 (a damaged Structural footing register is wiped by the next footing command), BUG-1137 (on 2022 to 2024 one downpipe in a COPY leaves every copied pit as a twin), BUG-1095 (council minimum C never applied, tanks too small), BUG-1183 (rearranged pier schedule rows resize the wrong piers).
