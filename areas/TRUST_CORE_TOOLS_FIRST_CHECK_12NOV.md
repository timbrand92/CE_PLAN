# Trust checklist, first pass on the 47 core tools (12 Nov 2026)

**Status: DRAFT from records, 12 Nov 2026. Nothing was run. A box marked passed here means the record says so, not that it was re-checked.**

Part of area TRUST. Checklist: `areas\TRUST_RULES_CHECKLIST_12NOV.md`. Tool list: `areas\CIVIL_COMMAND_SORT_06NOV.md` (CE Drainage tab and CE Design tab).

---

# FOR TIM

1. **Your hand pass is on record for 12 of the 47 tools** (PIT, CD, DP, CDRG, CDEDIT, CDRENUMBER, CDSL, PITSCHEDULE, MR, CR, CDFEEDBACK, CDINSPECTOR). For 6 of them it covers only part of the tool: CDEDIT (keeps the selection), PITSCHEDULE (order and Excel), MR and CR (ordinary objects only), CDFEEDBACK (Cancel only), CDINSPECTOR (half). All your 29 Oct hand checks were on scratch drawings, not real jobs.
2. **24 of 47 have an open fault that can lose or hide data** (my reading of the carpark, marked DATA below; PP is counted because it shares the schedule fault). Fix-installed-but-untested faults are counted as open.
3. **Five in the best state:** CDSL, CDRENUMBER, MR, DP, CDFEEDBACK. Each has your pass and no fault marked DATA. None is complete: CDRENUMBER stops with no help when there is no outlet pipe (BUG-1237), MR stops on a raingarden (BUG-1245), CDFEEDBACK is passed for Cancel only, and DP takes about 30 seconds (BUG-1228).
4. **Five in the worst state:** CDFW (cancelling clears stored pit inverts, BUG-650), PITSCHEDULE (leaves plastic pits out silently, BUG-1274; Excel export fails in 2027, BUG-1255), CDDESIGN (a damaged draft is overwritten, BUG-1143), CDPROFILE (19 open, several hide a level), CDWT (writes on a locked layer, BUG-1081).
5. **PIT, CD and CDEDIT are your most used and are accepted, but carry the most untested HIGH faults** (CD alone has four marked engineering-result risk: BUG-680, 681, 683, 874).
6. **Boxes never checked for any tool:** two Windows logins (rule 2 line 1); every value on Settings, tool by tool (rule 2 line 4); your three working days on real jobs (rule 4 line 4); your words "it is in" (rule 4 line 5); the whole of rule 5 (no tool note exists).
7. **Rule 1 line 3 (Cancel leaves everything as it was) is proven by the robot for no tool.** Faults on record show it fails for CDFW, CDSL, CD, CDRUNSOLVE and PITSCHEDULE.
8. **Rule 1 line 2 (changes shown first):** the hidden update that runs inside everyday tools is named for PIT, CDEDIT and CDSL only. The audit counts about 36 places and names five, so the other tools are "never checked", not "clean".

---

## How to read each block

1. **Accepted on record** means your hand pass, or "Codex-accepted" or "Claude-accepted" by name. "Fix installed", "built" or "robot passed" alone is not acceptance.
2. **Fault summaries** are five words, from the carpark entry's first lines. **DATA** marks a fault that loses stored data, hides a value, or leaves a value out without saying.
3. **"Fix installed, untested"** means the carpark says a fix went in at 3.0.70 and was not yet tested by robot or Codex (status as of 23 Oct). It is still open.
4. **Clicks** are ribbon clicks on your PC from 7 Sep to 4 Nov (`CORE_TICK_LIST_05NOV.md`). Typed commands are not counted.
5. **Rules that hold for every tool** unless the block says otherwise: Rule 1 line 5 (never saves) passed for CE in general (D18, your hand pass H27, robot N01 and R04), not tested tool by tool. Rule 5 is "none written yet" for all.

---

# CE DRAINAGE TAB

## Pits

**1. PIT (place a pit)**
1. **Used:** 9 ribbon clicks.
2. **Accepted on record:** Tim by hand 29 Oct (D01 keeps placing until Esc; D09 label and cover text; native ERASE, COPY and EXPLODE of a pit, D14 to D16). Claude-accepted (robot R01, R03, R05, N25) on 3.0.84 to 3.0.86.
3. **Open faults:** BUG-690 split on pipe loses link (HIGH, fix not seen). BUG-691 breakline half keeps wrong ends (DATA, fix installed, untested). BUG-693 arc pipe gets wrong curves. BUG-267 OOPS loses pit labels (fix installed, untested). BUG-793 block swap on every open (DATA). BUG-1042 blank cover refuses placing. BUG-458 runs inside REFEDIT. BUG-1231 eight stray "not updated" lines.
4. **Rule 1 (shows before it changes):** open. Runs the hidden update first (AUDIT_FOUNDATIONS, section 1 step 9, PitCommand). One U per pit passed by you (D19, H7). Cancel line not robot-proven. REFEDIT not protected (BUG-458).
5. **Rule 2 (same for everyone):** open. BUG-287 metre drawing with millimetre pits; BUG-663 hard-coded 2 km reach (fix installed, untested). BUG-1165 an old all-users bundle supplies the pit blocks first. 2022 to 2024 and two logins never checked.
6. **Rule 3 (no guesses as facts):** open. The hidden update fills "Class C" lid and the plastic-pit rule from settings without saying (AUDIT_FOUNDATIONS, section 1).
7. **Rule 4 (used on real drawings):** robot cases with a broken twin on record (R01, R03, R05, N25). Your hand checks were on scratch drawings. No three-day trial recorded.
8. **Rule 5 (tool note):** none written yet.

**2. PP (quick 350 x 350 plastic pit)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-458 runs inside REFEDIT. BUG-1274 plastic pits drop from the schedule (DATA, see PITSCHEDULE).
4. **Rule 1 (shows before it changes):** never checked for this tool. Shares the pit engine, so the hidden update probably applies, but the audit does not name PP.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** open. The plastic-pit schedule rule is why pits vanish from the schedule (BUG-1274).
7. **Rule 4 (used on real drawings):** a real job on 4 Nov had six plastic pits missing from its schedule. No trial evidence otherwise.
8. **Rule 5 (tool note):** none written yet.

**3. CDLPD (legal point of discharge)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1153 Redesign skips fixed outlet when record unreadable. BUG-1158 Save As copy keeps drawing identity.
4. **Rule 1 (shows before it changes):** never checked. The window was listed for a Cancel check in the old pending list; no result found.
5. **Rule 2 (same for everyone):** never checked. BUG-1158 is a Save As copy risk.
6. **Rule 3 (no guesses as facts):** never checked. The audit says there is no single master "start point" and CDRENUMBER forgets the outlet each run (AUDIT_FOUNDATIONS, section 4).
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**4. CDEDIT (edit the pit or pipe you pick)**
1. **Used:** 27 ribbon clicks, the most of any tool.
2. **Accepted on record:** Tim by hand 29 Oct for "keeps the selection" only (D17, from his own use); Edit Pipe swap-levels arrow passed 29 Oct (BUG-1222, Claude-accepted too). Claude-accepted R20. The whole tool: none.
3. **Open faults:** BUG-674 several pits resized leave pipes short (DATA, HIGH, fix installed, untested). BUG-677 pits with no record all get one number. BUG-291 batch design grade uses the wrong end. BUG-1043 blank invert refuses save. BUG-1049 one blank field blocks batch Apply. BUG-173 window still in progress. BUG-1239 pipe text 450 units off centre.
4. **Rule 1 (shows before it changes):** open. Runs the hidden update first (PitEditCommand, PipeEditCommand). Edit Pit preview exists. U and Redo: REDO after a pit pick fails in every robot session (BUG-861, open).
5. **Rule 2 (same for everyone):** never checked on two logins. BUG-1049 and BUG-1043 depend on blank values; remembered values (CD_RecentValues, about 60 fields) are named as a cause of different results per person.
6. **Rule 3 (no guesses as facts):** open. The hidden update may overwrite typed levels from drawing text (AUDIT_FOUNDATIONS, step 9.5).
7. **Rule 4 (used on real drawings):** your daily use is the evidence, but no dated trial is on record. Robot case R20 has a broken twin.
8. **Rule 5 (tool note):** none written yet.

**5. CDPITCOVERFLIP (move cover text to another corner)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** none on record (no carpark entry names it).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record. AUDIT_V3 only says the command exists.
8. **Rule 5 (tool note):** none written yet.

**6. CDRENUMBER (renumber pits from the outlet up)**
1. **Used:** typed only today, no ribbon button.
2. **Accepted on record:** Tim by hand (D20, H14 "passed": preview, Yes, U; the No path was not reported). Claude plus Codex accepted (N15, Codex G2 PASS, ledger 21). Your first run on 29 Oct (H8) printed "nothing to renumber", so the 29 Oct status file says the real work was not seen. Numbering order still needs your word.
3. **Open faults:** BUG-1237 stops with no help when no outlet. BUG-968 two opposite pipes confuse the outlet. BUG-1005 short side run numbered first.
4. **Rule 1 (shows before it changes):** passed on record (preview, default No, one U; H14). Cancel proven by the robot: not recorded.
5. **Rule 2 (same for everyone):** open. It asks for the outlet every run and remembers nothing (AUDIT_FOUNDATIONS, section 4), so the same drawing can number differently on another day.
6. **Rule 3 (no guesses as facts):** open. The default outlet is the lowest invert; with no inverts it says only "not available". BUG-968 and BUG-1005 can choose a wrong order.
7. **Rule 4 (used on real drawings):** robot and Codex only on record. No real-job trial.
8. **Rule 5 (tool note):** none written yet.

## Downpipes and tanks

**7. DP (downpipe)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** Tim by hand 29 Oct for "downpipe before any pipe exists" (D07, H30 "pass d07"). Close and reopen then DP again passed (BUG-1225, Tim). Placement time was not accepted (BUG-1228).
3. **Open faults:** BUG-859 double-click fix still fails in real AutoCAD. BUG-860 double-click on green label does nothing. BUG-1118 preview fixed at 100 units. BUG-1140 pasted downpipe keeps original's link. BUG-1209 cannot place on a pit in 2022 to 2024. BUG-1228 takes about 30 seconds. BUG-1242 tag shows no number.
4. **Rule 1 (shows before it changes):** never checked as a whole. BUG-1140 means MOVE or CDREPAIR can act on the wrong object after a paste.
5. **Rule 2 (same for everyone):** open. BUG-1118 (metre drawing, marker 200 m long) and BUG-1209 (2022 to 2024).
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** your hand pass on a scratch drawing. No real-job trial on record.
8. **Rule 5 (tool note):** none written yet.

**8. IO (inspection opening)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** none named for IO alone. It shares the source engine with DP: BUG-1209, BUG-1118 and BUG-1140 are likely to apply (not checked).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked. Shared-engine metre and 2022 to 2024 faults probably apply.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**9. OF (overflow)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** none. Robot accepted D08 but you did not pass it (H12).
3. **Open faults:** BUG-1242 tag shows no number. BUG-1225 reopen placement (Tim passed the fix 29 Oct).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** robot case N03 and Codex D7-02 only.
8. **Rule 5 (tool note):** none written yet.

**10. FO (front overflow)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** none. You refused D08: the FO symbol reads "OF" (BUG-1236).
3. **Open faults:** BUG-1236 symbol text reads OF. BUG-1242 tag shows no number.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** open. The plan label does not say what the object is (BUG-1236).
7. **Rule 4 (used on real drawings):** your hand check 29 Oct found the fault. No trial otherwise.
8. **Rule 5 (tool note):** none written yet.

**11. GIO (gross inlet)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-176 inlet landing on a pipe (diagnostics only, build queued).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**12. CDFW (floor waste)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-650 Cancel clears stored pit inverts (DATA, HIGH). BUG-1223 refuses a pick on an opening at pipe ends. BUG-647 refusal wording.
4. **Rule 1 (shows before it changes):** open and failing. BUG-650: Esc at the first question clears P1 and P2 invert records, and even a successful placement clears them; one U restores. Cancel line fails on record.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** found by Codex on a copy, 16 Oct. No real-job use recorded.
8. **Rule 5 (tool note):** none written yet.

**13. CDTG (trench grate)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-743 Enter reuses cover level from another drawing (DATA, fix installed, untested). BUG-745 (fix installed, untested). BUG-757 placeholder level 0.000 drawn as RL 0.00. BUG-432 Enter stores cover 0.000 instead of blank (DATA).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-743 carries a level from one drawing to the next for the whole AutoCAD session (rule 2 line 5).
6. **Rule 3 (no guesses as facts):** open. After a level is typed, Enter can no longer mean Unknown (BUG-743); BUG-757 prints a placeholder as a level.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**14. CDRG (raingarden)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** Tim by hand 29 Oct for "raingarden before any pipe exists" (D07, H30). RG label wording was still owed.
3. **Open faults:** BUG-1107 outlet pit never recorded (DATA). BUG-771 Enter or Undo cancels whole command. BUG-773 refuses a good garden (fix installed, untested). BUG-1242 tag shows no number. BUG-1245 stops MR and CR.
4. **Rule 1 (shows before it changes):** never checked. BUG-771: Enter finishing the outline cancels everything.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked. A garden with no recorded outlet pit hides a connection (BUG-1107).
7. **Rule 4 (used on real drawings):** robot case N04 (area 12.0 m2) and your scratch-drawing pass. No real-job trial.
8. **Rule 5 (tool note):** none written yet.

**15. CDWT (water tank)**
1. **Used:** 3 ribbon clicks.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1081 writes lettering on a locked layer. BUG-1083 accepts an Xref as the tank block. BUG-1115 typed detention 0 ignored. BUG-1174 skips its window with no reason. BUG-1212 loses tank pictures in 2022 to 2024. BUG-1102 and BUG-1104 council checks never run. BUG-1105 report tank not compared with drawn tank (DATA by omission).
4. **Rule 1 (shows before it changes):** open. Rule 1 line 6 fails on record (locked layer, Xref). Fixes for BUG-1081 and BUG-1083 exist only in the held build C-80.
5. **Rule 2 (same for everyone):** open. BUG-1212 (2022 to 2024); BUG-1166 office folders looked up in different places by Civil and Manager.
6. **Rule 3 (no guesses as facts):** open. Council tank checks are silent (BUG-1102, 1104, 1105).
7. **Rule 4 (used on real drawings):** none on record. The pre-Sep BUG-163 report was not reproduced by you on 24 Sep.
8. **Rule 5 (tool note):** none written yet.

**16. CDSOURCE (generic source)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-740 multi-word source names (fix installed, robot or Codex PASS observed, not accepted).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**17. CDTAG (tag or retag a source)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-927 says "removed" when nothing was tagged. BUG-814 retag refusal wording (fix installed, Codex BLOCKED). BUG-742 and BUG-740 (fix installed, not accepted).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** open. BUG-927 prints a result that did not happen.
7. **Rule 4 (used on real drawings):** robot runs 34 and 35 only; Codex W1-05 blocked on the test copy.
8. **Rule 5 (tool note):** none written yet.

## Pipes

**18. CD (draw a pipe)**
1. **Used:** 14 ribbon clicks.
2. **Accepted on record:** Tim by hand 29 Oct (D01 keeps placing; D03 joins a pit; D04 Esc at third point; D10 label text; D11 leader label; D12 one IL text each end; D06 hide grade). Claude-accepted R02, R17 (Esc half only), R03. Your New Pipe recent-buttons card (D05) was refused (BUG-1226, 1238).
3. **Open faults:** BUG-680 Upsize can delete another pit's record (DATA, HIGH, fix installed, untested). BUG-681 uphill flip leaves schedule levels swapped (DATA, HIGH, fix installed, untested). BUG-683 real length typed gives wrong level (HIGH, fix installed, untested). BUG-874 Esc drops callout link (DATA, HIGH). BUG-682 Cancel leaves drawn polyline. BUG-286 pit on locked layer links one-sided. BUG-675 rotated pit fit wrong. BUG-1043 blank invert refuses. BUG-1226 and 1238 recent buttons missing. BUG-1239 label 450 units off. BUG-1228 slow DP and CD. About 40 more open.
4. **Rule 1 (shows before it changes):** open. Cancel fails on record (BUG-682, 874). Locked layer handled one-sided (BUG-286). REFEDIT not protected (BUG-458). One U per pipe: passed through D19 for PIT, not CD's own [Undo] half.
5. **Rule 2 (same for everyone):** open. Metre drawing: BUG-331 refuses a pipe 1 m or shorter, BUG-337 level and direction wrong. Remembered values change the result per person (CD_RecentValues, audit). 2022 to 2024 not checked.
6. **Rule 3 (no guesses as facts):** open. The hidden update gives a size-less pipe "100" and "UPVC" (AUDIT_FOUNDATIONS, section 1). BUG-685 rounded typed level needs your ruling.
7. **Rule 4 (used on real drawings):** a real job on 4 Nov had 6 of 46 pipes converted on opening with no question (log). Your hand passes were on scratch drawings.
8. **Rule 5 (tool note):** none written yet.

**19. CDREVERSEFLOW (turn a pipe around)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1220 Help promises preview and Apply that do not exist.
4. **Rule 1 (shows before it changes):** open. Help says there is a preview; there is none (BUG-1220).
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record. AUDIT_V3 says the preview dialog is installed for CDRUNSOLVE, not for this tool.
8. **Rule 5 (tool note):** none written yet.

**20. CDTIDYLABELS (slide labels clear of other text)**
1. **Used:** no click count recorded (listed as ribbon, switch ON by default).
2. **Accepted on record:** Claude-accepted for "names the pipe", switch ON only (card C37, case R16). Hand-placed-label card not run by you (BUG-1252, on hold for your answer).
3. **Open faults:** BUG-873 writes start-up before switch and preview (DATA). BUG-1034 puts IL text on the pipe line. BUG-879 own moves not marked hand-placed. BUG-896 crowded drawing says nothing to move. BUG-890, 891, 893, 894, 895, 897, 962 (sub-switches, all OFF). BUG-1252 hand-placed label shifted.
4. **Rule 1 (shows before it changes):** open. BUG-873 writes before the preview; BUG-893 Apply differs from the preview. Cancel not robot-proven.
5. **Rule 2 (same for everyone):** open. BUG-897 and BUG-962 depend on drawing size and Settings.
6. **Rule 3 (no guesses as facts):** open. BUG-896 says "No CE label needs to move" when it abandoned the pipe.
7. **Rule 4 (used on real drawings):** robot case R16 only. No trial.
8. **Rule 5 (tool note):** none written yet.

**21. CDANNOTATIONEDIT (move one label or arrow)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** none on record (no carpark entry names it). BUG-879 says CE's own moves are not marked hand-placed.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**22. CDMA (move a flow arrow)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1218 Help page missing.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**23. CDTEXTSEG (move pipe text to another segment)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1161 moved label forgets kept wording (DATA, for example "APPROX."). BUG-1194 picks nearest midpoint, not clicked leg. BUG-1195 writes wrong angle plane.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-1195 depends on the UCS in use.
6. **Rule 3 (no guesses as facts):** open. BUG-1194 picks the nearer leg, not the one you clicked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**24. CDSL (spot level)**
1. **Used:** 2 ribbon clicks. Runs the hidden update first (SpotLevelCommand).
2. **Accepted on record:** Tim by hand 29 Oct (D26: typed level H17; stored survey level H51 "pass"). Claude-accepted R35 (typed levels and the refusal) on 3.0.75, Codex D5-02 passed.
3. **Open faults:** BUG-1201 Cancel leaves a SPOT LEVEL block definition. BUG-712 (fix installed, Codex observation PASS, not accepted). BUG-1175 wording points at Tim's folders.
4. **Rule 1 (shows before it changes):** open. Cancel leaves a real change (BUG-1201). Runs the hidden update (AUDIT_FOUNDATIONS, step 9, SpotLevelCommand).
5. **Rule 2 (same for everyone):** never checked. BUG-1175 wording is for your office only.
6. **Rule 3 (no guesses as facts):** passed on record for the typed half and the stored half (survey level shown as existing, you type the proposed level).
7. **Rule 4 (used on real drawings):** your scratch-drawing passes and a robot twin. No real-job trial.
8. **Rule 5 (tool note):** none written yet.

**25. MR (move and rotate)**
1. **Used:** no click count recorded.
2. **Accepted on record:** Tim by hand on an ordinary object only (29 Oct, listed under "also passed"). Not on a raingarden (BUG-1245).
3. **Open faults:** BUG-1245 stops with a code word when a raingarden is selected. No other entry names MR.
4. **Rule 1 (shows before it changes):** never checked beyond your ordinary-object pass.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** open. BUG-1245's message is a code word, not drafting words (rule 3 line 4).
7. **Rule 4 (used on real drawings):** "so far cr/mr work but not on all objects" (your words, 5 Nov). The first tool on trial.
8. **Rule 5 (tool note):** none written yet.

**26. CR (copy and rotate)**
1. **Used:** no click count recorded.
2. **Accepted on record:** Tim by hand on an ordinary object only. Not on a downpipe or raingarden.
3. **Open faults:** BUG-1245 stops on a raingarden. BUG-1246 copied downpipe keeps its tag (DATA). BUG-1246 line says "could not be given its own link on this AutoCAD".
4. **Rule 1 (shows before it changes):** open. BUG-1246: a copied downpipe is left linked as AutoCAD copied it.
5. **Rule 2 (same for everyone):** open. BUG-1246 wording says "on this AutoCAD", which hints at a version difference. Not checked on 2022 to 2024.
6. **Rule 3 (no guesses as facts):** open. BUG-1246 left tag DP2 on the copy without saying what to do.
7. **Rule 4 (used on real drawings):** your ordinary-object use on 5 Nov; same trial note as MR.
8. **Rule 5 (tool note):** none written yet.

**27. CDSTRIP (strip drain)**
1. **Used:** no click count recorded. Tim, 7 Nov: used on normal jobs.
2. **Accepted on record:** none (placed in the ribbon by Claude, not yet confirmed by Tim).
3. **Open faults:** BUG-647 stays loose geometry; MOVE strands its children (DATA). BUG-290 refresh overwrites pipe levels (fix installed, untested). BUG-022 end floor wastes (middle ones Tim-confirmed). BUG-028 and BUG-029 in progress.
4. **Rule 1 (shows before it changes):** open. BUG-647 means MOVE leaves part of the drain behind. Cancel not checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** your use on normal jobs (your words, 7 Nov). No dated trial.
8. **Rule 5 (tool note):** none written yet.

**28. CDAGI (AGI drain)**
1. **Used:** no click count recorded. Tim, 7 Nov: used on normal jobs.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1054 drain loses last point and closes itself in a metre drawing (DATA). BUG-1052 flat drain passes the grade check in a metre drawing. BUG-649 rising AGI passes the grade check. BUG-648 grade never labelled. BUG-290 (fix installed, untested).
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-1052 and BUG-1054 are metre-drawing faults.
6. **Rule 3 (no guesses as facts):** open. BUG-649 and BUG-1052 report a wrong grade as meeting the minimum.
7. **Rule 4 (used on real drawings):** your use on normal jobs (7 Nov). No dated trial.
8. **Rule 5 (tool note):** none written yet.

## Check this drawing

**29. CHECK THIS DRAWING (opens CDCHECKCURRENT today; the new door is not built)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none. The new button does not exist, so no box can be ticked for it.
3. **Open faults:** none on CDCHECKCURRENT. For the future door: the hidden update runs in about 36 places and in CDGRAPH, CEHEALTH, CDDIAG and CDDASHBOARD, all labelled read-only (AUDIT_FOUNDATIONS, section 3).
4. **Rule 1 (shows before it changes):** never checked in AutoCAD. Read in code only: CDCHECKCURRENT reads and writes nothing (AUDIT_FOUNDATIONS, section 5).
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**30. CDINSPECTOR (shows what you have selected)**
1. **Used:** 4 ribbon clicks.
2. **Accepted on record:** Tim by hand 29 Oct, a pit only, half passed (BUG-1249 and BUG-1240 found on it).
3. **Open faults:** BUG-994 drawn length wrong in a metre drawing. BUG-995 Drawing health buttons (open). BUG-1094 pipe 20 per cent flat shows amber. BUG-1240 after Save As says "not in CE's record" (DATA shown as Unknown). BUG-1249 says pit label is bottom right when it is above. BUG-098, 099 older wording faults.
4. **Rule 1 (shows before it changes):** never checked. The audit says it can run a full sync at open if the Workshop layout flag is off (AUDIT_FOUNDATIONS, section 1 step 7).
5. **Rule 2 (same for everyone):** open. BUG-994 (metre drawing). The scan switch depends on a per-user flag.
6. **Rule 3 (no guesses as facts):** open. BUG-1094 shows a failing grade as amber. BUG-1240 shows Unknown for a pit the schedule lists.
7. **Rule 4 (used on real drawings):** your 4 clicks and a half pass on a scratch drawing.
8. **Rule 5 (tool note):** none written yet.

## Schedules

**31. PITSCHEDULE (pit schedule)**
1. **Used:** 2 ribbon clicks.
2. **Accepted on record:** Tim by hand 29 Oct: natural order (D21, H16 "yes") and Excel export with Checking sheet (D23, H26 "pass"). Long schedule over two sheets not accepted. The records disagree on Excel: BUG-1255 (Codex, 30 Oct, after your pass) says export fails in AutoCAD 2027.
3. **Open faults:** BUG-1274 plastic pits left out with no message (DATA). BUG-1255 Excel export fails in 2027 (PILOT-BLOCKER). BUG-965 Refresh changes "2/375" to "375" (DATA, HIGH). BUG-787 typed levels slide to another row (DATA). BUG-1022 override lost after copy (DATA). BUG-1198 cancelled export still saves row order. BUG-817 opening leaves its own undo step. BUG-855 issues count rises after CDSYNC. BUG-1044 two Xrefs with a P1 give empty schedule. About 16 more open.
4. **Rule 1 (shows before it changes):** open. BUG-1198 writes on Cancel. BUG-817 opening adds a U step. The relink button runs the same hidden update as CDSYNC (AUDIT_FOUNDATIONS, section 3).
5. **Rule 2 (same for everyone):** open. Natural-order switch is OFF by default (AUDIT_V3 item 90). BUG-1035 hidden fixed 300 mm "Shallow" rule. BUG-1197 shared block heading changes another schedule.
6. **Rule 3 (no guesses as facts):** open. BUG-1274 omits pits silently; the fix exists only in the held build C-80.
7. **Rule 4 (used on real drawings):** BUG-1274 was found on a real council-issue drawing on 4 Nov. Codex W2-02 PASS (cell override) and W2-04 FAIL on 3.0.70.
8. **Rule 5 (tool note):** none written yet.

**32. CDPROFILE (long section)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none. AUDIT_V3: never Tim-accepted.
3. **Open faults:** BUG-762 invert above cover hidden as depth 0.00 (DATA, review says Ready). BUG-761 uphill pipe printed as falling (DATA). BUG-1192 real depression hidden by 1.20 m survey limit (DATA). BUG-760 level pipe with no grade stops the whole section. BUG-756 top line drawn at next pipe's size. BUG-765 any number in an Xref becomes a level. BUG-766 branch marks never drawn. BUG-1193, 764 curved boundary treated straight. About 8 more.
4. **Rule 1 (shows before it changes):** never checked. Has a Review then Apply step (BUG-1020 depends on a layout setting).
5. **Rule 2 (same for everyone):** open. BUG-1020 needs an office layout setting; BUG-1154 saves a large record as one long text value.
6. **Rule 3 (no guesses as facts):** open. BUG-762, 761 and 765 present guesses or hidden values as facts.
7. **Rule 4 (used on real drawings):** none on record. Codex W5-01 PASS covered the window half of the older tab only.
8. **Rule 5 (tool note):** none written yet.

## Everyday help

**33. CDHELP (help)**
1. **Used:** 7 ribbon clicks.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1175 wording points at Tim's own folders. BUG-1216 Help opens the wrong page for new tools. BUG-1215 Help promises a "Save report" step. BUG-1217 invites input to read-only calculators. BUG-1218 and BUG-1220 pages missing or wrong. BUG-555 makes off-PC calls.
4. **Rule 1 (shows before it changes):** not applicable (read only).
5. **Rule 2 (same for everyone):** open. BUG-1175 means a colleague sees your folders. BUG-555 calls off the PC.
6. **Rule 3 (no guesses as facts):** open. Help describes buttons that do not exist (BUG-1215, 1217, 1220).
7. **Rule 4 (used on real drawings):** your 7 clicks. No dated trial.
8. **Rule 5 (tool note):** none written yet.

**34. CDS (your preferences)**
1. **Used:** 5 ribbon clicks.
2. **Accepted on record:** none.
3. **Open faults:** BUG-839 Manager Settings page can undo a change just saved (DATA, fix installed, untested). BUG-957 Enter in empty search saves and closes. BUG-958 window position not remembered. BUG-227 (fix installed, untested).
4. **Rule 1 (shows before it changes):** open. BUG-957 saves the whole draft on a failed search.
5. **Rule 2 (same for everyone):** open. A new login gets colleague defaults; an existing login never does (AUDIT_FOUNDATIONS, section 2). About 574 settings, 255 on or off.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** your 5 clicks. No dated trial.
8. **Rule 5 (tool note):** none written yet.

**35. CDFEEDBACK (report a problem)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** Tim by hand for Cancel only (D29, H17: one honest line). Send report never pressed; it needs your yes and a spare login.
3. **Open faults:** BUG-1215 Help promises a send step that does not exist. BUG-1166 Civil and Manager look in different office folders.
4. **Rule 1 (shows before it changes):** never checked for Send. Sending writes a file into the shared office folder.
5. **Rule 2 (same for everyone):** open. BUG-1166.
6. **Rule 3 (no guesses as facts):** open. Help says saving is separate from sending (BUG-1215).
7. **Rule 4 (used on real drawings):** none on record for Send.
8. **Rule 5 (tool note):** none written yet.

**36. CEBLOCKS (office blocks palette)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1047 refuses a frozen layer before asking for the point. BUG-188 in progress, fixed and merged, awaiting acceptance. BUG-1017, 524, 1243 open.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked. Palette folder is a Manager setting.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**37. CDMANAGER (layer colours and draw order)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none. (The Manager Status tab you passed is a different tool.)
3. **Open faults:** BUG-229 draw-order list looked wrong to Codex (cause unknown, observation only).
4. **Rule 1 (shows before it changes):** never checked. Codex used no Add, Reset, Apply or Save.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** Codex read-only sweep C1, 30 Sep. No other evidence.
8. **Rule 5 (tool note):** none written yet.

**38. CDNEWDWG (new job drawing)**
1. **Used:** typed only today.
2. **Accepted on record:** none.
3. **Open faults:** BUG-969 title block shows the previous job's reference after changing the job folder (HIGH, DATA). BUG-1166 office folders looked up in different places.
4. **Rule 1 (shows before it changes):** open. The preview shows the wrong reference too (BUG-969).
5. **Rule 2 (same for everyone):** open. BUG-1166.
6. **Rule 3 (no guesses as facts):** open. A wrong reference is printed as the job's own.
7. **Rule 4 (used on real drawings):** none on record. AUDIT_V3 says A1 and A3 dialog files exist.
8. **Rule 5 (tool note):** none written yet.

---

# CE DESIGN TAB

**39. CDDESIGN (design inputs)**
1. **Used:** no click count recorded (listed as a ribbon button, "Design setup").
2. **Accepted on record:** none. Job mode per discipline (UX-DES-01) is in the code, never tested.
3. **Open faults:** BUG-1143 a damaged draft is replaced by the next Save Draft, losing the agreed design (DATA). BUG-1156 an older CE wipes newer answers from the draft (DATA). BUG-1088 sizer picks the smallest pipe at any grade. BUG-1091 minimum grade dropped for DN450 and larger. BUG-1095, 1096, 1099, 1100, 1102, 1104 council rules never applied (DATA by omission). BUG-1110 warns about values it never uses. BUG-1116 lots of 1,000 m2 and over get Tc 5 min with no note. BUG-1106 two-word council not found. BUG-866 open question. About 30 open.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-1156 (older build wipes answers). BUG-1158 Save As copy keeps identity.
6. **Rule 3 (no guesses as facts):** open. Rules that never run look as if they ran (BUG-1095, 1096, 1099, 1110, 1116).
7. **Rule 4 (used on real drawings):** none on record. AUDIT_V3: results never Tim-accepted.
8. **Rule 5 (tool note):** none written yet.

**40. CDCALC (drainage calculations)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1101 opens with a made-up catchment and 15-minute storm (DATA). BUG-1268 Export to XLSX writes no file. BUG-1112 WSUD export prints a sample site nobody typed. BUG-1036 roughness called "office Settings values". BUG-1089 own fixed speed limits, not Settings. BUG-1033 pump tab read-only with no banner. BUG-1097 300 mm head never checked. BUG-772 WSUD accepts negative areas. BUG-158 council sheet dropped (fix installed, untested). BUG-590 and BUG-591 export drops DRAFT. BUG-249 rainfall curve missing on sheet. About 23 open.
4. **Rule 1 (shows before it changes):** open. BUG-1030 closing with nothing changed leaves a U step.
5. **Rule 2 (same for everyone):** open. BUG-1036 and BUG-1089 use values not on Settings (rule 2 line 4 fails on record).
6. **Rule 3 (no guesses as facts):** open. BUG-1101 and BUG-1112 print invented values.
7. **Rule 4 (used on real drawings):** none on record. Codex W5-01 and W5-03 saw windows only.
8. **Rule 5 (tool note):** none written yet.

**41. CDRAINFALL (the job's rainfall curve)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1216 Help opens the wrong page.
4. **Rule 1 (shows before it changes):** never checked. An older test says Cancel closes with nothing drawn.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**42. CDTWL (top water level)**
1. **Used:** 1 ribbon click.
2. **Accepted on record:** Claude-accepted for the freeboard card only (C39): robot R14 and R14h, two clean starts on 3.0.86. Never Tim-accepted. What happens when two freeboard settings disagree has never been tried.
3. **Open faults:** BUG-1056 says "That is enough" 100 mm below a habitable floor (DATA, hides). BUG-1021 drops a pit with unknown floor from the lid check (DATA, hides). BUG-970 picks P2 without asking when two systems share numbers. BUG-777 default is highest invert, not obvert. BUG-871 metre-drawing units (draft PR, not installed). BUG-1032 pick list shows handle and "doubled pipe".
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-871 metre drawing. BUG-777 default switch OFF pending your ruling.
6. **Rule 3 (no guesses as facts):** open. BUG-1056 says nothing about not looking at the floor. BUG-1021 does not warn.
7. **Rule 4 (used on real drawings):** robot only on record.
8. **Rule 5 (tool note):** none written yet.

**43. CDRUNSOLVE (solve inverts down a run)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** BUG-868 treats every pipe as UPVC (concrete capacity over-stated about 23 per cent; draft PR, switch OFF). BUG-999 says "already matches" when it solved nothing. BUG-311 Cancel also rolls back a palette change (DATA). BUG-290 refresh overwrites typed levels (fix installed, untested). BUG-1088 sizer picks smallest pipe at any grade. BUG-1093 cover check skipped at lid RL 0.000. BUG-056 existing council line case. BUG-964 redesign fault.
4. **Rule 1 (shows before it changes):** open. A preview dialog is installed (AUDIT_V3 item 72) but BUG-311 shows Cancel undoes more than it should.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** open. BUG-868 and BUG-999 report results that are not true.
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**44. CDDEST (where each downpipe ends up)**
1. **Used:** 3 ribbon clicks.
2. **Accepted on record:** none.
3. **Open faults:** none on record (no carpark entry names it). Older BUG-156 (a redesign forgot a recorded destination) had a test queued: record a destination, then redesign; not found as passed.
4. **Rule 1 (shows before it changes):** never checked. The pending list says it "changes nothing" on an older drawing and points to CDTAG.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** your 3 clicks. No other evidence.
8. **Rule 5 (tool note):** none written yet.

**45. CDRULES (check against the engineering rulebook)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none. AUDIT_V3: none of its rules is Tim-accepted.
3. **Open faults:** BUG-1057 council speed limits never reach the speed checks (DATA by omission). BUG-1090 nothing says the hydraulic grade line was not checked. BUG-1092 up to 5 mm uphill called "essentially flat". BUG-1006 advice to cure a slow pipe makes it slower. BUG-907 pit drop checks inverts only. BUG-903 screens judge one pipe differently (your ruling 136: CDRULES wins). BUG-1059 one council minimum grade not applied. BUG-1060 new jobs show edition 2021. BUG-1111 formula text says 0.3, number uses 0.35. About 23 open.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** open. BUG-1213 older AutoCAD cannot open the council evidence.
6. **Rule 3 (no guesses as facts):** open. BUG-1090 and BUG-1057 leave checks unsaid.
7. **Rule 4 (used on real drawings):** none on record. The garage-drawing read was never run in AutoCAD (AUDIT_V3 item 86).
8. **Rule 5 (tool note):** none written yet.

**46. CDRULEBOOK (rulebook settings for the job)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none. Codex sweep C1 listed it among 11 small passes (start-up only).
3. **Open faults:** BUG-1071 says "set" when the save was skipped (DATA). BUG-1109 no council value can be edited anywhere (the records conflict: AUDIT_V3 item 4 says values are on Settings). BUG-1213 older AutoCAD cannot open the evidence.
4. **Rule 1 (shows before it changes):** open. BUG-1071 reports a change that was not saved.
5. **Rule 2 (same for everyone):** open. BUG-1213 (2022 to 2024). Rule 2 line 4 cannot be ticked while BUG-1109 stands.
6. **Rule 3 (no guesses as facts):** open. 284 values are marked Assumed with no council source (AUDIT_V3 item 4).
7. **Rule 4 (used on real drawings):** none on record.
8. **Rule 5 (tool note):** none written yet.

**47. CDSYSTEM (put pipes in a system)**
1. **Used:** no click count recorded.
2. **Accepted on record:** none.
3. **Open faults:** none found. No carpark entry names it by this command.
4. **Rule 1 (shows before it changes):** never checked.
5. **Rule 2 (same for everyone):** never checked.
6. **Rule 3 (no guesses as facts):** never checked.
7. **Rule 4 (used on real drawings):** no record found in any source read.
8. **Rule 5 (tool note):** none written yet.

---

# What this did not check

1. **Nothing was run.** No AutoCAD, no robot, no build, no test, no git.
2. **Bug status is as written in the carpark,** most of it dated 23 Oct to 5 Nov. A fix may have been installed since. "Fix installed, untested" is a 23 Oct reconciliation and may be stale at the installed 3.0.90.
3. **Carpark matching is by command name** in the entry's title and first lines. An entry that names two commands may be missing from one block, and a fault with no command name (about 422 entries have none) is not here. A fault listed under one tool may really belong to a shared engine.
4. **DATA marks are my reading** of each entry's first lines. I did not read each entry in full.
5. **Rule 2 line 1 (two Windows logins)** and **line 4 (every value on Settings)** are not recorded per tool anywhere I read, so they are "never checked" for all 47. Hard-coded values are only named in the foundations audit (the 2000 and 2500 reaches) and in a few bug entries.
6. **Rule 1 line 2 (hidden update)** is named for PIT, CDEDIT and CDSL only. The audit says about 36 call sites; I did not trace the others.
7. **Your hand passes come from `TIM_ACCEPTED_TOOLS_30OCT.md` and `EVERYDAY_TOOLS_STATUS_29OCT.md`** (29 Oct, scratch drawings). I did not re-read the acceptance ledger itself. Acceptance after 30 Oct is not covered unless a carpark or audit entry says so.
8. **Click counts** come from `CORE_TICK_LIST_05NOV.md` and cover only the tools it names.
9. **PENDING_TESTS.md was used as a to-do list, not as evidence.** `RELEASE_SCOREBOARD.md` was searched, not read in full (277 KB).
10. **No office project or drawing-intelligence folder was opened.** Job numbers, suburbs and addresses found in carpark entries were left out.
