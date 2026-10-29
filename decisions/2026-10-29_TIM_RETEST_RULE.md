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
