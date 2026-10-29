# Tim's ruling: re-testing after an install (Thu 29 Oct 2026, about 11:05 Melbourne)

1. **Question (from CE 02's testing-speed report, areas\TESTING_SPEED_OPTIONS_29OCT.md):** after an install, may a tool that the fix never touched keep its earlier Claude-accepted pass until the weekend re-test?
2. **Tim's words:** "Yes, recommended" (the recommended answer: after an install re-test only what the fix touched; a tool the fix never touched keeps its earlier pass until the weekend re-test and before Max).
3. **Interpretation:** the "two passes in two separate AutoCAD starts on the current build" rule of 24 Oct stays for NEW acceptances and for every tool or case the install touched. For a case in an area the install did not touch (decided by the fix reports and the finalizer's changed-files list, written down per install), the earlier pass on the previous build stays counted. A full re-test of every accepted case runs every weekend and before anything goes to Max (the 9 Nov pilot). This is not a change to any other part of the Claude-accepted rule.
4. **Desk must:** each install's robot job lists the areas the fix touched, re-tests those, and records the untouched cases as "carried from <build>"; CE 02 schedules the full weekend re-test (Sat 31 Oct and Sat 7 Nov) and the pre-pilot re-test. The ledger counts a carried pass as accepted but says so.

## Addendum 1 (Thu 29 Oct 2026, afternoon): a fix that only adds a new switch

5. **Question (from CE 00 and CE 02, asked by CE 04):** may a fix that only ADDS a new settings switch (new name, nothing existing edited or removed) count as touching only its own tool?
6. **Tim's words:** "yes. An Edit Pipe fix then re-tests 7 checks (about 1 hour) instead of all 66 (about 6 h 40 min)" (the recommended answer).
7. **Interpretation:** yes. A fix whose only settings change is a brand-new switch with a new name is treated as touching only its own tool: the robot re-tests that tool's checks and carries the rest. Editing or removing an EXISTING setting still means a full re-test (stated in the question; Tim did not change it). The weekend full re-test (Sat 31 Oct, Sat 7 Nov) and the pre-pilot re-test remain the safety net.
8. **Desk must:** stop treating every settings change as FULL; CE 02 checks each install's changed-files list for edited or removed existing settings (full re-test) versus added new names only (area re-test); record which in the job.

## Addendum 2 (Thu 29 Oct 2026, night; relayed by CE 00 and recorded by CE 04): trains from C-77 on

9. **Question (asked by CE 00 in the Control Room, about 23:3x; QUESTIONS item 61):** from C-77 on, (1) recommended: re-test only what the train touches plus a small smoke set for each shared file touched, carry the rest, one full re-test before Max (by Fri 13 Nov) and at the weekends as already planned; or (2) full re-test of all 66 after every install. Background: Tim, 23:10: "why do things need to repass surely if code is not modified and worked on previous versions it counts as accepted or surely we redo these checks at the end... it feels like were going in circles".
10. **Tim's words (relayed by CE 00, not seen by CE 04):** "do your recommendation".
11. **Interpretation (CE 00's, marked as such):** option 1 is chosen. Unknown or unmapped files stop forcing a FULL re-test once CE 02 places them in areas; tonight's running pass is unchanged; the weekend full re-tests and the pre-Max full re-test stay.
12. **Desk must:** from C-77, CE 02 places every changed file in an area, runs the area re-test plus a small smoke set per shared file touched, records the rest as "carried from <build>", and keeps one full re-test before Max by Fri 13 Nov plus the weekend full re-tests. Question 12 / item 61 is closed; do not ask it again.
