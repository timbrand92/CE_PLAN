# Codex look briefs G1 to G7 (Wed 28 Oct 2026)

Written Wed 28 Oct 2026, 18:20 to 18:45 Melbourne (PC clock), by the Opus desk assistant. Codex weekly use 0 percent after the 17:53 reset, mode PACE, today's cap 16 percent. Nothing started by me: no AutoCAD, no build, no Codex launch. No existing brief, case, ledger or desk log was edited. The briefs live outside CE_PLAN and stay uncommitted (see below the line).

## ANSWER FIRST

### FOR TIM

1. **My mistakes first: none that cost anything.** I wrote 7 briefs, not 8: everything still owed fitted in 7.
2. **What happens now.** Codex had nothing to do. It now has 7 new "look" jobs: it opens AutoCAD on test copies and LOOKS at what a robot cannot judge. 2 run tonight, 3 on Thursday evening, 2 on Friday evening. The first one started at 18:29.
3. **The seven looks, in the order they run:**
   1. **G1, tonight: a short pipe's label on a leader (daily tool D11).** Draw a 2 m pipe. Does the leader say the full pipe description, does its arrow touch the pipe, is the text clear of everything? If yes, D11 is whole.
   2. **G2, tonight: CDRENUMBER (D20).** Do the pit numbers on the plan change exactly as the preview says (P9 to P8, P10 to P9), and does one U put them back? If yes, D20 is done except your word on the numbering order.
   3. **G3, Thursday: a downpipe and a raingarden on an empty drawing (D07).** It reports exactly what CE draws for the raingarden, including whether any "RG1" label exists. It does not judge it. That gives you the facts for your Monday question 15.
   4. **G7, Thursday: a pipe label you dragged stays put when its pit moves (D13).** This runs with the "hand-placed labels stay" switch ON. Your own file has it OFF, so a pass proves the switch-on behaviour only.
   5. **G4, Thursday: two windows.** The CDCHECKDWG results list (D28): readable, nothing cut off, Close visible. And About CE Suite: probably still cut off at the bottom (BUG-090), because no fix has gone in since it failed on 1.1.79.
   6. **G6, Friday: a copied pit (D15).** Is the copy a whole pit with its own number and a "check levels" warning? D15 is already counted; this adds the picture.
   7. **G5, Friday: quick MOVE of a pit.** Do the moved pit's number, cover level and invert levels land clear of each other and of the pipes? Not one of the 40 everyday tools.
4. **What it can do to the count (now 14 of 40 everyday tools accepted).** Best case: 16 of 40 (D11 and D13). D20 would then wait only on your numbering-order word. D07 waits on your question 15. D28 also needs a desk decision about where its report file goes.
5. **Cost.** About 6 percent of Codex's week per look, 42 percent for all seven. Tonight 12 percent, inside today's 16 percent limit. Thursday 18 percent, Friday 12 percent.
6. **Nothing for you to do or decide now.**

---

### For the desk

1. **Files written (14), all in `C:\Lisp Files\_CODEX_RUNNER\`, not a git repository, so uncommitted.** Each look has a short launcher `verifyGn_c84.txt` and a full brief `verifyGn_c84_full.txt`, for n = 1 to 7. The full briefs copy the F-series rules block word for word from `verifyF5_cur_full.txt` (N1 to N17, including the N17 fix that a zoom line printing nil is normal, the changes (a) to (h), the standard build steps, SETUP and CLEAN END). Two changes only: N14 names Civil 3.0.84 / Manager 1.1.84 / Structural 1.0.125, and N6 carries the settings hashes read at 18:25 (ACD64E79A33B, 622A246F7D3B, EFE307C4FC74, B3B5A004B929). Report names: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_Gn_<yyyyMMdd_HHmm>.md`; lock names Codex-Gn.
2. **Queue (`desk_jobs\CONVEYOR_QUEUE.txt`, appended only), each line `gpt-6.1-sol|medium|97|3` like the F-series:**
   1. **Active:** verifyG1_c84, verifyG2_c84. The running conveyor (pid 97908, started 13:02) logged "starting verifyG1_c84 (look id G1)" at 18:29.
   2. **Held as `#HOLD ` lines under a `# tomorrow` comment:** G3, G7, G4 (release after 17:53 Thu, when the cap rises to 30), then G6, G5 (release after 17:53 Fri, cap 44). Release = delete the leading `#HOLD `.
   3. **Why held rather than plain lines under a comment:** the conveyor runs every line that does not start with #. In PACE it only refuses a START when usage + 1 is over the cap, so a third plain line would start at about 12 percent and finish near 18, over today's 16.
   4. **The cost field (3) is not used** when the cap field is a number: `queue3.sh` uses it only with "auto". The real cost is about 6 each.
   5. **Watch:** the conveyor stops itself after 6 hours with no runnable line. After G2 finishes the held lines do not count as runnable, so it will probably stop overnight. Restart it on Thursday when the first held lines are released.
3. **What each look proves and which tool it moves:**
   1. **G1 (N20, D11):** the leader's words, the arrowhead on the pipe within 50 mm (picture plus a typed reading of the leader's first vertex), the text clear of the pipe and the IL texts. It names both callout prompts from the installed source (`TextService.cs` at 94f521cc: "Snap callout arrow to pipe:", "Specify callout elbow point:"). That ends the D7-04 block. Step 12 also reports the layers of every new object, which is the part of D7-04 that was never reached. **PASS + N20 part = D11 whole.**
   2. **G2 (N15, D20; re-brief of D5-01 and E2-01):** both tags in one view, using E2's handles 11A09C (P9) and 119F9C (P10), read again first. Then No, Yes and one U, each with a picture and a typed tag reading. **PASS + N15 = D20 whole, except the numbering rule (Tim's word).**
   3. **G3 (N04, D07):** on F-BLANK. It judges the DP tag, the closed filled outline, no refusal and the U. It REPORTS every object and attribute, with a separate "RG LABEL:" line for Monday question 15. **D07 stays part until Tim answers.**
   4. **G4 (R40, D28; and R06 BUG-090):** the results window look; the About rows measured on 1.1.84. **D28 also needs the D28-line-817 against BUG-606 ruling and a folder-check red.** BUG-090: no commit after 1.1.79 touches About (git log of 94f521cc read at 18:30), so FAIL is expected.
   5. **G5 (R12, C41):** new overlaps after the quick MOVE, against a before picture. The "P3 -> P2 label: no clear spot" label is REPORTED. No U is typed (the U is proved by R12 and D3-02).
   6. **G6 (D15; re-brief of D3-04 and E1-01):** the copy is placed in the upper part of the view, plus the Inspector's mark if the palette is on screen. **No count change: D15 is already whole on 3.0.83.**
   7. **G7 (D13; re-brief of D6-01 and E3-01):** a settings pass sets two keys through the guard: `linking.handPlacedLabelsStay` and `linking.tidyLabelsEnabled`. Both are in `LinkingSettings`, default false, absent from Tim's file. The pit is accepted by layer STORMWATER PIT and its real (effective) name, not by its anonymous *U name, which is what stopped E3-01. **PASS = D13 Codex-accepted, switch-ON profile.**
4. **Earlier blocked looks NOT re-briefed, and why:**
   1. **D4-04 / E1-02 (CE never saves):** nothing to see; D18 is already Claude-accepted whole (N01 with R04).
   2. **D6-04 / E4-02 (CDEDIT gives back the selection):** D17 is already Claude-accepted (R20).
   3. **D6-03 / E4-01 (long schedule placed in parts):** D6-03 was stopped because "Continue to Place / update" stayed disabled. That may be CE behaviour, not the brief, so it was not re-briefed. **The desk should check this first.** No carpark entry names it (I searched for "Continue to Place").
   4. **D6-02 / E3-02 (Tidy labels):** not blocked by its brief. E3-02 was DIFFERENT: CE said no label needed to move. G7 step 7 reads the Tidy summary again.
5. **Checks I ran on the 14 files:**
   1. **Clean text:** "follow" 0 times; ASCII only, no control characters (written from raw strings, scanned after).
   2. **Brackets:** every typed LISP reading is bracket-balanced (checked by a script that I first proved catches a broken line).
   3. **Hashes:** the case hashes cited (N20 AA6B716294DF, N15 A78CC824FFF3, N04 74CA6C503ADD, R40 D24E373852FC, R12 58A9ACD407FB, N16 068633409A51, R34a 1A7904894EE6) were re-read at 18:26 and are equal. Fixtures: DRV1_B1 34BBE37C2EA4, BLANK 9A8AA4DDCC29.
   4. **Installed build:** read at 18:20: Civil 3.0.84+94f521cc and Manager 1.1.84+94f521cc in Legacy, Modern and Net8; Structural 1.0.125+204dfad2.
   5. **Prompts:** the CDRENUMBER outlet question and the CDRG GIO question were read from the installed source. Every other prompt in the briefs is quoted from an earlier Codex report.
6. **Not verified (RULES 5.9):**
   1. **The new typed readings have never run in AutoCAD:** LEADER (GetLeaderLineVertices), OBJ-ALL and PB-NEAREST (EffectiveName). LEADER has a fallback reading, and the picture carries each look.
   2. **Typed answers to the callout drag:** whether "Specify callout elbow point:" takes a typed point is unproven; G1 step 6 orders one mouse pick if it refuses.
   3. **The Inspector:** whether its palette is on screen in a Codex session (D3 saw it).
   4. **Tag handles:** the P9 and P10 handles come from E2 on 3.0.77. G2 reads them again before use.

## Summary (under 100 words)

Seven Codex look briefs (G1 to G7) are written in the runner folder; they are uncommitted, and the queue lines are appended. G1 (short pipe leader, D11) and G2 (CDRENUMBER numbers on the plan, D20) are active, and G1 started at 18:29. G3 (raingarden facts for Monday question 15), G7 (hand-placed label, D13, switch on) and G4 (CDCHECKDWG window and About) are held for Thursday after 17:53. G6 (copied pit) and G5 (quick MOVE overlaps) are held for Friday. Cost is about 6 percent each, 12 percent today. Best case: 14 rises to 16 of 40 everyday tools.
