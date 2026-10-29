# Tim's rulings: release freeze, hand checks, questions, test laptop (Thu 29 Oct 2026, about 12:05 Melbourne)

Source: Tim, in the Control Room chat, answering the list "what have I missed". Documents checked first: areas\RELEASE_SCOREBOARD.md, areas\COLLEAGUE_READINESS_29OCT.md, areas\TESTING_SPEED_OPTIONS_29OCT.md.

1. **Release freeze: option B.**
   1. Tim's words: "option b".
   2. Interpretation: the colleague release candidate is FROZEN on Fri 6 Nov 2026 and includes the pilot-critical fixes the desk can build now; the pilot is Mon 16 Nov 2026 (not Mon 9 Nov). Option A (freeze Sat 31 Oct, pilot 9 Nov) is not chosen.
   3. Desk must: plan trains up to the freeze (C-76, C-77, then C-78 and later as needed) so that the final candidate is INSTALLED by Fri 6 Nov before the pre-Max full re-test; CE 07 keeps the scoreboard on the 16 Nov schedule; CE 01 prioritises pilot-critical bugs without a fix; CE 02 schedules full re-tests Sat 31 Oct, Sat 7 Nov and the pre-pilot re-test after the freeze (re-test rule: decisions\2026-10-29_TIM_RETEST_RULE.md). Anything not frozen by 6 Nov goes in a later update after the pilot.
2. **Hand checks (CE 03): finish today, add more if testing is quick.**
   1. Tim's words: "ill complete today, maybe add more if we can get more tested quickly".
   2. Interpretation: Tim completes the 12 hand checks today and will take extra checks today if they are quick. CE 03 queues extras (the tools still without a Tim-confirmed pass, easiest first).
3. **Questions go to the CE 04 chat.**
   1. Tim's words: "send messages in questions chat" (for the release questions and the two engineering calls BUG-905 and BUG-1097).
   2. Desk must: nothing for Tim goes into the Control Room chat except a landed install or a plan number; all decisions are asked in CE 04.
4. **Test laptop with AutoCAD 2026.**
   1. Tim's words: "i cant do it now, can i do on a laptop with 2026 installed?" (about the spare work PC as a test PC; he cannot do the 30-minute setup now).
   2. Interpretation: a different machine: a laptop with AutoCAD 2026 (not 2027). NOT a decision to start; it is a request to assess. The 2026 line is a .NET 8 lane (the bundle already carries a Net8 folder); the robot driver was built for 2027.
   3. Desk must: CE 02 and CE 07 assess what the robot driver needs to run against AutoCAD 2026 and what the laptop needs (Claude session, repo access, install through the real install route, which doubles as the install rehearsal); CE 04 asks Tim the laptop questions (whose laptop, Windows user type, AutoCAD 2026 sign-in, when available, can it stay powered on, network/OneDrive access); nothing is installed on any other PC without Tim's word.
