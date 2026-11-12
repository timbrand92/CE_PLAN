# Trust checklist, second pass on the 47 core tools (13 Nov 2026)

**Status: DRAFT from records, written Fri 13 Nov 2026 from about 01:45 PC clock by lane trust-struc-mgr-plan. Nothing was run for this file.** A box passes only where a record says so: your hand pass, Codex-accepted, Claude-accepted, or a probe that saw it in real AutoCAD. Code reading alone never passes a box; it is written "code says yes, never seen".

Part of area TRUST. Same shape as the first pass (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`), with one more line per tool: the single next thing that would move it forward. Checklist: `areas\TRUST_RULES_CHECKLIST_12NOV.md`. Installed build in question: Civil 3.0.90 (commit cf059dcf).

**New evidence since the first pass:** the 47 tool notes rewritten from the installed code (`04_REFERENCE\core-tool-notes\`); 149 bugs the records list as open that the installed code appears to fix (`areas\trust-run\BUGS_FIXED_IN_CODE_NOT_PROVEN.md`); 81 new faults filed from the code reading, BUG-1280 to BUG-1360; the AutoCAD probes on the installed build (`areas\TRUST_PROBES_13NOV.md`); headless evidence on the trial builds (`areas\trust-run\EVIDENCE_BRANCHES.md`), which moves no installed tool because trial builds are not installed.

---

# FOR TIM

1. **No tool passes all five rules.** Every pass on record is partial, and most of your hand passes were on scratch drawings.
2. **Rule by rule, across the 47 tools:**
   1. **Rule 1 (shows before it changes):** 20 fail, 3 pass in part, 23 never checked, 1 not applicable.
   2. **Rule 2 (same for everyone):** 30 fail, none pass, 17 never checked.
   3. **Rule 3 (no guesses as facts):** 35 fail, 1 passes (CDSL, your hand pass), 11 never checked.
   4. **Rule 4 (used on real drawings):** 8 pass in part, 2 fail, 37 never checked.
   5. **Rule 5 (tool note):** a DRAFT note now exists for all 47 and matches the installed code by its own line; none is accepted yet.
3. **The biggest change since the first pass:** many faults are now known by number rather than "never checked". The code reading filed 81 new faults; one alone (BUG-1286) says 15 tools skip the start-up checks for a read-only drawing, Paper Space, REFEDIT and Structural drawings.
4. **The cheapest progress there is:** 149 bugs already have a fix in the installed code that nobody has seen work. Proving them on copies needs no new code (for example BUG-650, cancelling CDFW, and BUG-1255, the Pit Schedule Excel export).
5. **What the probes saw in real AutoCAD:** Edit Pit changes CE's record even when you press Cancel; a plain line on the pipe layer becomes "100 dia UPVC" and an unlabelled pit becomes P8, 350 x 350, plastic, all without a word; CDCHECKCURRENT does not change anything and runs in a fraction of a second.

**The ten tools closest to passing, and what each still needs:**

1. **CDCHECKCURRENT (the read-only check):** the only tool a probe saw leave CE's record untouched. Needs BUG-1338 (pits marked To be removed counted) and BUG-1339 (blank link never flagged) fixed, a metre drawing and second-login look, and a real drawing.
2. **CDRENUMBER:** your hand pass on preview, Yes and one U, plus a Codex pass. Needs BUG-968's fix proven (two opposite pipes must not close AutoCAD), BUG-1237 (no outlet, no help) fixed, and the No and Esc paths checked.
3. **CDSL (spot level):** your hand pass for rule 3. Needs BUG-1285 (a forced record update before the first question) and BUG-1201 (Cancel leaves a block definition) fixed, then a robot Cancel case.
4. **PIT:** your most used pit tool, robot cases with broken twins on record. Needs the made-up values the probe saw stopped (step 6) and the metre drawing size fault (BUG-287) fixed, then a robot Cancel case.
5. **MR (move and rotate):** your pass on ordinary objects. Needs BUG-1286 (no start-up checks), BUG-1245 (a code word on a raingarden) and BUG-1334 (2027 pipes cannot be moved) fixed, and a Codex look.
6. **CR (copy and rotate):** as MR, plus BUG-1246's fix (a copied downpipe gets its own tag) seen working.
7. **DP (downpipe):** your pass on a scratch drawing. Needs BUG-859 (double-click) seen in real AutoCAD, BUG-1118 (metre preview) and BUG-1209 (cannot land on a pit on older AutoCAD) fixed.
8. **CDFEEDBACK (report a problem):** your pass on Cancel. Needs Send pressed once on a spare login, BUG-1166 (two places for the office folder), BUG-1346 and BUG-1347 fixed.
9. **CDEDIT:** your partial pass and a robot case. Needs Edit Pit to stop updating the record when it opens (as the step 5 draft does for CDGRAPH), then a robot Cancel case.
10. **CDHELP:** reads only, so rule 1 does not apply. Needs BUG-1216 (wrong page), BUG-1217 (invites input to read-only calculators) and BUG-1344 (older AutoCAD opens a browser) fixed, then a Codex look.

---

## How to read each block

1. **PASS, FAIL or NEVER CHECKED** for each rule, with the source in brackets: the tool note, a probe, a bug entry, or the first pass.
2. **"Fix in code, unproven"** means the installed code appears to carry a fix that no robot or Codex has seen work; the bug stays open.
3. **Rule 5** is never marked PASS: a DRAFT note matching the code is not an accepted note.
4. **"Next single thing"** is the one action that would move the tool forward most, in the order you would do it.

---

# CE DRAINAGE TAB (tools 1 to 38) AND CE DESIGN TAB (39 to 47)

**1. PIT (place a pit)**
1. **Rule 1:** NEVER CHECKED as a whole. One U per pit passed by Tim (D19, H7, scratch drawing). Hidden record update runs first (note, code says yes, never seen in PIT itself). Refusing during REFEDIT: code says yes, never seen (BUG-458).
2. **Rule 2:** FAIL (BUG-287 metre drawing, mm pits). Probe: in a metre drawing one record held 350 beside 0.6 for pits of the same real size. Two logins and 2022 to 2024 never checked.
3. **Rule 3:** FAIL (probe: made-up pit values). A pit block with no label became P8, 350 x 350, plastic, left out of the schedule, written silently (probe saw it through Edit Pit; PIT runs the same update per note). Probe saw Class A lid, not Class C.
4. **Rule 4:** PASS in part. Robot cases with broken twin R01, R03, R05, N25 (Claude-accepted) and Tim's hand passes on a scratch drawing. No real job, no Tim 3 days.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1296 (shallow-pit warning fixed at 0.6 m), BUG-1297 (locked pit layer found after the window is filled in). Fix in code, unproven: BUG-458, 690, 691, 692, 693, 1165, 035. Probe: pit symbol swap on opening ran in a non-Civil drawing and printed nothing (BUG-793 part a).
7. **Next single thing:** robot case with a broken twin for Esc at the first point and Cancel at the window, checking the record before and after.

**2. PP (quick 350 x 350 plastic pit)**
1. **Rule 1:** NEVER CHECKED. Same engine as PIT; REFEDIT refusal is code says yes, never seen.
2. **Rule 2:** NEVER CHECKED. Note says metre drawing gets 350 mm at scale 1, no conversion (BUG-287 shared).
3. **Rule 3:** FAIL (BUG-1274 plastic pits left out of schedule). PP switches the schedule row off by default, which is why pits vanish. Probe saw a plastic pit with Class A lid appear through the hidden update; PP's own Class C fill-in was not seen.
4. **Rule 4:** NEVER CHECKED. A real job on 4 Nov had six plastic pits missing from its schedule.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New fault BUG-1294 (PP opens the older window, PIT opens the one-page window). Fix in code, unproven: BUG-458, 690 to 693. No new probe on PP itself.
7. **Next single thing:** Tim's ruling on whether a plastic pit belongs in the schedule, then a robot case that places one and reads the schedule.

**3. CDLPD (legal point of discharge)**
1. **Rule 1:** NEVER CHECKED. Note says nothing is written until the last answer and Esc leaves the drawing as it was (code says yes, never seen). Faults found: locked note layer (BUG-1299, old note stays, second added).
2. **Rule 2:** FAIL (BUG-1287 metre drawing finds nearest pipe end anywhere). Two logins never checked.
3. **Rule 3:** FAIL (BUG-1301 says "LPD set." with no note drawn). Also BUG-1300 (LPD left in the earlier pipe's From or To), BUG-1302 (real reason only in the CE log).
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1287, 1298 (any plain polyline taken as the pipe), 1299, 1300, 1301, 1302. Fix in code, unproven: BUG-1153 (it is a CDDESIGN fault). Partly fixed: BUG-1158.
7. **Next single thing:** robot case with broken twin: set an LPD on a copy where the note layer is locked, then read the drawing and record.

**4. CDEDIT (edit the pit or pipe you pick)**
1. **Rule 1:** FAIL (probe: Edit Pit updates record on Cancel). With the record behind the drawing, opening Edit Pit and pressing Cancel changed the record; one U put it back exactly. No bug number covers the Cancel case itself. Edit Pipe single Save has no locked-layer or Xref check (BUG-1288). Edit Pit saves next-pit defaults before checking it may write (BUG-1303). Redo after a pit pick fails (BUG-861).
2. **Rule 2:** NEVER CHECKED on two logins. Probe: in a metre drawing the hidden update gave a new pit 350 beside 0.6.
3. **Rule 3:** FAIL (probe: made-up values). Hidden update gave a plain line "100 dia UPVC" and an unlabelled pit P8, 350 x 350, plastic, Class A lid, all in the record after Cancel.
4. **Rule 4:** PASS in part. Tim by hand, "keeps the selection" only (scratch drawing); swap-levels arrow passed (BUG-1222); robot R20 with broken twin. No real job, no 3 days.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1288, 1303, 1304, 1305. Fix in code, unproven: BUG-1043, 1049, 070, 072, 078, 094, 186, 223, 291, 674, 071. Probe: Edit Pit with Save was not tested (driver cannot press it).
7. **Next single thing:** make Edit Pit stop updating the record on open (draft fix as for CDGRAPH), then a robot case with broken twin for Cancel at the window.

**5. CDPITCOVERFLIP (move cover text to another corner)**
1. **Rule 1:** NEVER CHECKED. Note: refuses locked layer, Xref, REFEDIT, and nothing else changes (code says yes, never seen).
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** NEVER CHECKED. Note says refusals print one plain line.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New fault BUG-1280 (the ribbon button Flip Cover Text does nothing; it only works from the cover text's own grip). The first check said no faults on record; that is now wrong.
7. **Next single thing:** Tim's ruling: fix the ribbon button, or remove it and keep the grip. Then Codex look at the grip route on a copy.

**6. CDRENUMBER (renumber pits from the outlet up)**
1. **Rule 1:** PASS in part (Tim H14, scratch drawing: preview, default No, Yes, one U; Claude plus Codex accepted, N15, G2). The No and Esc paths were not reported. Note: nothing written before Yes (code says yes, never seen).
2. **Rule 2:** NEVER CHECKED on two logins. First check: it forgets the outlet each run.
3. **Rule 3:** FAIL (BUG-1237 stops with no outlet and no way to pick one). Also BUG-1306 (separate branch numbered after main, old order) and BUG-1307 (8 and P8 treated as different).
4. **Rule 4:** PASS in part. Robot and Codex only on record; Tim's first run on 29 Oct printed "nothing to renumber". No real job.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1306, 1307. Fix in code, unproven: BUG-968 (loop could close AutoCAD) and BUG-1005. No probe.
7. **Next single thing:** prove BUG-968 fix on a copy with two opposite pipes between two pits (AutoCAD must stay open).

**7. DP (downpipe)**
1. **Rule 1:** NEVER CHECKED as a whole. Note: U once per downpipe; Esc at first point leaves layer, block and CE marker written (one U should undo, not proven). Pasted downpipe keeps original's link (BUG-1140).
2. **Rule 2:** FAIL (BUG-1118 preview fixed in drawing units; BUG-1209 cannot land on a pit in 2022 to 2024). Note says also 2025 and 2026.
3. **Rule 3:** NEVER CHECKED. Label "DP" without number is Tim's ruling 77, not a fault.
4. **Rule 4:** PASS in part. Tim by hand, downpipe before any pipe exists (D07, H30, scratch drawing); reopen then DP passed (BUG-1225). Placement time not accepted (BUG-1228, about 30 seconds). No real job.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308 (refusal printed twice), BUG-1309 (placing resets the DOWNPIPES colour and linetype you set). Fix in code, unproven: BUG-859 (failed once in real AutoCAD, second fix not installed), BUG-860. BUG-1242 is Tim's ruling, not a fault.
7. **Next single thing:** Codex look at double-click on a downpipe in real AutoCAD (BUG-859 failed once already).

**8. IO (inspection opening)**
1. **Rule 1:** NEVER CHECKED. Note: splits a pipe it lands on, U once per IO (not proven).
2. **Rule 2:** FAIL (BUG-1118, BUG-1209 shared with DP; pit landing refused on 2022 to 2026).
3. **Rule 3:** NEVER CHECKED.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308, BUG-1309 (shared). No faults of its own. Nothing fix-in-code listed for IO.
7. **Next single thing:** robot case with broken twin: place an IO on a pipe, Esc, and check the pipe and layer are untouched.

**9. OF (overflow)**
1. **Rule 1:** NEVER CHECKED. Note: splits a pipe it lands on; whether an overflow should split is a question for Tim.
2. **Rule 2:** FAIL (BUG-1118, BUG-1209 shared).
3. **Rule 3:** NEVER CHECKED. BUG-1242 is Tim's ruling (no number in label).
4. **Rule 4:** NEVER CHECKED by Tim (he did not pass it, H12). Robot N03 and Codex D7-02 only.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308, 1309 (shared). BUG-1145 (Xref schedule said OUT OF DATE) is fixed in code, unproven, but is not OF's own code.
7. **Next single thing:** Tim's ruling on whether an overflow should split a pipe, then Tim's hand pass on OF.

**10. FO (front overflow)**
1. **Rule 1:** NEVER CHECKED. Same engine as OF.
2. **Rule 2:** FAIL (BUG-1118, BUG-1209 shared).
3. **Rule 3:** FAIL (BUG-1236 symbol may read "OF"). Code gives FO no symbol text of its own; the green tag does read "FO". The block file was not opened.
4. **Rule 4:** FAIL. Tim's hand check on 29 Oct found the fault (BUG-1236). No trial otherwise.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308, 1309 (shared). BUG-1236 confirmed still open in code; Tim's ruling is FO inserts with FO as label. Nothing fix-in-code for FO.
7. **Next single thing:** fix the FO symbol to read FO, then Tim's hand look at the placed symbol.

**11. GIO (gross inlet)**
1. **Rule 1:** NEVER CHECKED. Note: draws on the raingarden outline layer, not DOWNPIPES.
2. **Rule 2:** FAIL (BUG-1118, BUG-1209 shared).
3. **Rule 3:** NEVER CHECKED.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308, 1309 (shared). BUG-176 (inlet landing on a pipe) is not in the note's list; status not known. Nothing fix-in-code for GIO.
7. **Next single thing:** Codex look at placing a GIO on a pipe run and on a locked outline layer.

**12. CDFW (floor waste)**
1. **Rule 1:** NEVER CHECKED (first check said FAIL on BUG-650). Note: Esc no longer clears pit inverts and the full update no longer runs before the pick (code says yes, never seen). The update can still switch a pit's "show invert" off.
2. **Rule 2:** NEVER CHECKED. Pit landing refused on 2022 to 2026 (shared).
3. **Rule 3:** NEVER CHECKED. BUG-1223 part 2: a pick on an opening is now refused, which outcome is right is Tim's call.
4. **Rule 4:** NEVER CHECKED. Found by Codex on a copy, 16 Oct.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1308, 1309 (it resets the DOWNPIPES colour and linetype). Fix in code, unproven: BUG-650, BUG-1223 part 1.
7. **Next single thing:** prove BUG-650 fix on a copy: run CDFW on a drawing with pit inverts, press Esc, compare every invert.

**13. CDTG (trench grate)**
1. **Rule 1:** FAIL (BUG-1285 forced full record update before the first question, Esc does not take it back). Also BUG-1310 (placed in separate steps, a failure leaves half a grate). No locked-layer check after the questions.
2. **Rule 2:** FAIL (BUG-1311 settings read once per AutoCAD session, not per drawing). Cover level remembered across drawings is fixed in code, unproven (BUG-743).
3. **Rule 3:** FAIL (BUG-1312 "enter to skip" when Enter takes the remembered level). BUG-757 placeholder level drawn as RL 0.00 still open per first check.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1285, 1310, 1311, 1312. Fix in code, unproven: BUG-743. Partly fixed: BUG-745, 432.
7. **Next single thing:** prove BUG-743 fix on a copy: type a level in one drawing, open a second, press Enter at the cover question.

**14. CDRG (raingarden)**
1. **Rule 1:** NEVER CHECKED. Note: one U for the lot (not proven); a locked layer is found only after every question (BUG-1315, reason only in the log).
2. **Rule 2:** FAIL (BUG-1313 close and same-end distances are 1 drawing unit, so 1 m in a metre drawing). Not metric: area shows Unknown, which is correct.
3. **Rule 3:** FAIL (BUG-1290 self-crossing outline accepted, wrong area). Also BUG-1107 outlet pit never recorded; the Inspector says "No outlet registered".
4. **Rule 4:** PASS in part. Tim by hand, raingarden before any pipe exists (D07, H30, scratch drawing); robot N04. No real job.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1290, 1313, 1314 (missing GIO block ends with only "CDRG command cancelled."), 1315. Fix in code, unproven: BUG-771. BUG-1245 (MR and CR stop on a raingarden) is a different tool's fault.
7. **Next single thing:** prove BUG-771 fix on a copy: four corners then Enter, see the outline close and Undo remove one point.

**15. CDWT (water tank)**
1. **Rule 1:** FAIL (BUG-1081 lettering on a locked layer; BUG-1083 accepts an Xref block; BUG-1285 forced record update before the window; BUG-1289 Esc skips the question instead of cancelling). Cancel keeps the record update and early block loads.
2. **Rule 2:** FAIL (BUG-1212 no window on 2022 to 2026; BUG-1166 office folders looked up differently; metre drawings have no unit handling).
3. **Rule 3:** FAIL (BUG-1102, 1104 council checks never run). Also BUG-1316 window route loses the library tank's make, size and lid, so the callout line never shows.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1285, 1289, 1316, 1317 (only first 9 library tanks on the command line). Fix in code, unproven: BUG-020. BUG-1081 and 1083 fixes exist only in held build C-80.
7. **Next single thing:** robot case with broken twin: CDWT with the tank layer locked, check nothing is written (BUG-1081).

**16. CDSOURCE (generic source)**
1. **Rule 1:** NEVER CHECKED. Note: locked layer reason not named on the usual route (BUG-1315).
2. **Rule 2:** FAIL (BUG-1118, BUG-1209 shared).
3. **Rule 3:** FAIL (BUG-1318 erased number reused; BUG-1319 name ending in a number gets another added). Both not proven.
4. **Rule 4:** NEVER CHECKED. No evidence on record; the BUG-740 pass was observation only, not accepted.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1315, 1318, 1319, 1308, 1309. Partly fixed: BUG-740 (multi-word names keep every word). Nothing in the fix-in-code list.
7. **Next single thing:** Codex look: place ROOF DRAIN 1 to 3, erase 3, place again, read the number (BUG-1318).

**17. CDTAG (tag or retag a source)**
1. **Rule 1:** NEVER CHECKED. Note: retag is one step; first tag is several steps in one command. Refuses Xref and locked layers with plain lines (code says yes, never seen).
2. **Rule 2:** NEVER CHECKED. No version differences found.
3. **Rule 3:** FAIL (BUG-1320 retag with No to the label leaves the old label showing old text). Also BUG-1321 retag moves a nudged connection point back; BUG-927 messages still partly say "saved together".
4. **Rule 4:** NEVER CHECKED. Robot runs 34 and 35; Codex W1-05 blocked.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1320, 1321, 1322 (used-name refusal only after every question). Fix in code, unproven: BUG-742 (a pass is on record, not accepted), BUG-814.
7. **Next single thing:** Codex look at a retag refused for a used name (BUG-814 was blocked on the test copy).

**18. CD (draw a pipe)**
1. **Rule 1:** FAIL (BUG-874 Esc drops callout link; BUG-286 locked-layer pit gives one-sided link; BUG-458 REFEDIT, fix in code unproven). Cancel after Upsize leaves the pit upsized until U (note). One U per pipe passed for PIT only.
2. **Rule 2:** FAIL (BUG-337 metre level and direction wrong; BUG-1323 default level-text side ignores Settings unless "remember" is on). 2022 to 2024 not checked.
3. **Rule 3:** FAIL (probe: made-up values; BUG-1281 answer to "Continues to another plan?" ignored; BUG-1282 reports success when a label failed). Probe: a plain line became "100 dia UPVC" through the hidden update; CD itself is not the one that ran it in the probe.
4. **Rule 4:** PASS in part. Tim by hand D01, D03, D04, D06, D10, D11, D12 (scratch drawing); robot R02, R17, R03 with twin. A real job on 4 Nov had 6 of 46 pipes converted on opening with no question. Recent-buttons card refused (BUG-1226, 1238).
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1281, 1282, 1323, 1324, 1325 (window starting levels run uphill). Fix in code, unproven: 35 bugs listed, among them BUG-680, 681, 682, 683, 874 (HIGH ones). Probe: opening a drawing converts pipes with no U; one U does nothing there.
7. **Next single thing:** prove BUG-683 fix on a copy (1 in 100, 20 m drawn, 50 m typed, expect 19.50).

**19. CDREVERSEFLOW (turn a pipe around)**
1. **Rule 1:** NEVER CHECKED. Note: asks Yes/No (Enter = No), nothing written before Yes, U once (code says yes, never seen). No start-up checks (BUG-1286); locked layer and REFEDIT caught only after Yes.
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** FAIL (BUG-1326 ribbon tooltip promises "lists what else changes" and schedule rows; it does not). BUG-1220 Help fixed in code, unproven.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1326, 1286 (no start-up checks). Fix in code, unproven: BUG-1220 (help wording only).
7. **Next single thing:** robot case with broken twin: run it on a read-only copy and a locked-layer pipe; read what it says.

**20. CDTIDYLABELS (slide labels clear of other text)**
1. **Rule 1:** FAIL (BUG-873 writes start-up before switch and preview; BUG-893 Apply differs from the count). Cancel: Enter = No, "Nothing was moved" (code says yes, never seen). No start-up checks (BUG-1286).
2. **Rule 2:** FAIL (BUG-897 and BUG-962 depend on drawing size and Settings; BUG-891 searches only Model Space).
3. **Rule 3:** FAIL (BUG-896 "No CE label needs to move" when it abandoned the pipe; BUG-895 reports moved when the writer refused).
4. **Rule 4:** PASS in part. Claude-accepted, "names the pipe", switch ON only (R16 with twin). Hand-placed card not run (BUG-1252). No real job.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New fault BUG-1286 only (no start-up checks). Fix in code, unproven: BUG-890 (switch OFF by default, so it cannot show). No probe.
7. **Next single thing:** stop it writing before the switch and the Yes (BUG-873), then a robot case with broken twin for Cancel.

**21. CDANNOTATIONEDIT (move one label or arrow)**
1. **Rule 1:** NEVER CHECKED. Locked layer refused before any point (code says yes, never seen). Esc at a point still rewrites the item's link record (note).
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** FAIL (BUG-1327 ribbon tooltip says Slide, Offset, Flip, Reset; command asks Move, Rotate, Mirror, Flip). BUG-1328 Flip turns a label upside down.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1284 (moves any text or block, not only CE labels), 1327, 1328. The first check said no faults on record; that is now wrong.
7. **Next single thing:** Tim's ruling: should it refuse non-CE text and blocks; then Codex look at Flip on a label.

**22. CDMA (move a flow arrow)**
1. **Rule 1:** FAIL (BUG-1283 Esc at the level or reverse question still places an arrow; BUG-1284 moves any block; BUG-1286 no start-up checks).
2. **Rule 2:** NEVER CHECKED. BUG-1331: in a rotated UCS the arrow can go on the wrong leg (not proven).
3. **Rule 3:** FAIL (BUG-1283 always says "Flow arrow moved." even after Esc or a locked layer; BUG-1332 invented fallback pipe size 100 and levels 1.0 and 0.9).
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1283, 1284, 1286, 1331, 1332. BUG-1218 (Help page missing) not covered by the note; status not known.
7. **Next single thing:** robot case with broken twin: Esc at the first level question, then check whether an arrow was placed.

**23. CDTEXTSEG (move pipe text to another segment)**
1. **Rule 1:** NEVER CHECKED. Nothing written before the second answer (code says yes, never seen). No start-up checks (BUG-1286).
2. **Rule 2:** NEVER CHECKED. BUG-1195 UCS angle fixed in code, unproven.
3. **Rule 3:** FAIL (BUG-1161 moved label forgets kept wording, for example "APPROX."). BUG-1330: not marked as placed by hand.
4. **Rule 4:** NEVER CHECKED. No evidence on record.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1286, 1329 (label can land on twin detention barrels), 1330. Fix in code, unproven: BUG-1194, BUG-1195 (both behind a switch).
7. **Next single thing:** prove BUG-1161 is still open on a copy: label with "APPROX.", move it, read the text.

**24. CDSL (spot level)**
1. **Rule 1:** FAIL (BUG-1201 Cancel leaves a SPOT LEVEL block definition; BUG-1285 forced record update before the first question, Esc does not take it back). Locked 25DIMS refused before any question (code says yes, never seen).
2. **Rule 2:** FAIL (BUG-1333 upper limit 9000 m in code, Settings holds 3000 m for survey levels; BUG-1175 wording points at Tim's folders). Two logins never checked.
3. **Rule 3:** PASS (Tim by hand, typed level H17 and stored survey level H51, scratch drawing: survey level shown as existing, you type the proposed one).
4. **Rule 4:** PASS in part. Tim's scratch-drawing passes (D26); robot R35 twin; Codex D5-02. No real job, no Tim 3 days.
5. **Rule 5:** DRAFT note written, matches installed code per its own line. Not accepted.
6. **Changed since the first check:** New faults BUG-1285, 1333. Partly fixed: BUG-712 (25DIMS now checked first). Nothing in the fix-in-code list.
7. **Next single thing:** stop the forced record update before the first question (BUG-1285), then a robot case with broken twin for Esc at the first point.

**25. MR (move and rotate)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks). Tim hand pass 29 Oct on an ordinary object, scratch drawing (first check). Code says it refuses REFEDIT, locked layers and Xrefs and unlocks nothing, one U; never seen [note].
2. **Rule 2:** NEVER CHECKED. Two logins and metre drawing never tried. On 2022 to 2024 it is a different tool (the office LISP), and the note says so, but nothing has been run there [note].
3. **Rule 3:** FAIL (BUG-1245, code word, not object named). [first check, note]
4. **Rule 4:** NEVER CHECKED on a real job. Tim hand pass on ordinary objects only (scratch drawing); his 5 Nov words "cr/mr work but not on all objects" [first check]. No robot twin, no Codex look on record.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** new fault BUG-1334 (pipes drawn on 2027 cannot be moved) and BUG-1286 (no start-up checks). No fixed-in-code bugs. No probe.
7. **Next single thing:** have Codex run MR on a copy holding a pipe, a raingarden and a pit, to see which ones it refuses and what the line says.

**26. CR (copy and rotate)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks). Code says it refuses REFEDIT, locked layers and Xrefs, one U; a copied downpipe gets its own tag; never seen [note].
2. **Rule 2:** NEVER CHECKED. Different LISP tool on 2022 to 2026; BUG-1246 wording mentions "this AutoCAD", unresolved [note].
3. **Rule 3:** FAIL (BUG-1245, code word; BUG-1246 fix in code, unproven). [note]
4. **Rule 4:** NEVER CHECKED on a real job. Tim hand pass on ordinary objects only, scratch drawing (first check). Not on a downpipe or raingarden.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-1246 now fix in code, unproven (copied downpipe given its own tag, switch on). New: BUG-1334 (pipes drawn on 2027 not copied), BUG-1286.
7. **Next single thing:** copy a downpipe on a 2027 copy and read the line it prints and the tag it gets (the exact test for BUG-1246).

**27. CDSTRIP (strip drain)**
1. **Rule 1:** FAIL (BUG-1295, overwrites TIM LEADER style). Code says preview with Accept or Cancel, one U, one step, refuses locked layer and REFEDIT; never seen [note]. BUG-290 now fix in code, unproven.
2. **Rule 2:** FAIL (BUG-1337, metre drawing 1000 times too wide; BUG-1335, layer name fixed). [carpark, note]
3. **Rule 3:** NEVER CHECKED. BUG-029 arrows: note cannot say if it matches Tim's latest ruling.
4. **Rule 4:** NEVER CHECKED as a dated trial. Tim's words 7 Nov: used on normal jobs [first check].
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-022 and BUG-290 now fix in code, unproven. BUG-028 partly fixed. New: BUG-1295, 1335, 1336 (Close offered after 2 points), 1337.
7. **Next single thing:** run CDSTRIP over a 10 m run on a metre copy and read the width; it decides BUG-1337.

**28. CDAGI (AGI drain)**
1. **Rule 1:** NEVER CHECKED. Code says preview with Accept or Cancel, one U, refuses locked layer and REFEDIT; Esc at the level questions skips instead of cancelling (BUG-1289, FAIL for the Cancel line) [note, carpark]. Rule 1 line 3 therefore FAIL (BUG-1289).
2. **Rule 2:** FAIL (BUG-1052 metre run read as millimetres; BUG-1313, 1 unit snap distances). [note, carpark]
3. **Rule 3:** FAIL (BUG-1052, flat drain reported as meeting the minimum grade). BUG-649 not named in the note: not known.
4. **Rule 4:** NEVER CHECKED as a dated trial. Tim's words 7 Nov: used on normal jobs.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-290 now fix in code, unproven. New: BUG-1289 and BUG-1313. BUG-1054 (loses last point, metre) not in the note: not known.
7. **Next single thing:** draw a flat 10 m AGI drain on a metre copy and read the grade line; it decides BUG-1052.

**29. CHECK THIS DRAWING (CDCHECKCURRENT, read only)**
1. **Rule 1:** PASS (part only): the probe on the installed build saw CE's record unchanged, and also unchanged with the record deleted (it did not create one) [probe]. Not probed: drawing objects, selection and view changes, a palette left open. Code says it never saves and has nothing to undo [note].
2. **Rule 2:** NEVER CHECKED. Two logins and metre drawing not probed. Code says no 2022 to 2024 difference; the pipe-to-pit clearances it uses come from Settings and are marked not yet confirmed [note].
3. **Rule 3:** FAIL (BUG-1338, "To be removed" pits counted; BUG-1339, blank link never flagged). It also does not count pits drawn but not in the record (no bug number). "5 items need checking" showed before and after CDSYNC and nobody read what the five are [probe].
4. **Rule 4:** NEVER CHECKED on a real drawing. Probe ran only on made-up and old test copies, up to 200 pits and 370 pipes [probe].
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted. It is the note for CDCHECKCURRENT; the "Check this drawing" button does not exist yet.
6. **Changed since the first check:** probe saw it very fast, 8 to 65 thousandths of a second on every copy; CDGRAPH, CDDIAG and the Project Review window change the record, this tool does not. New faults BUG-1338, BUG-1339. Draft fix seen headless: CDGRAPH and CDDIAG stop updating the record on the trial build, and the shared "needs checking" count is right for 1 stray line; the opening line itself was not seen.
7. **Next single thing:** have Codex open the palette on a copy with one "To be removed" pit and one blank-link pipe, so BUG-1338 and 1339 are seen on screen.

**30. CDINSPECTOR (shows what you have selected)**
1. **Rule 1:** NEVER CHECKED. Code says the default compact view reads only; the older full-detail view runs the whole-drawing update on each pick and "Use plan label" renames the pit in the record [note]. Not probed.
2. **Rule 2:** FAIL (BUG-994, pipe length in a metre drawing; BUG-1340, fixed 400 mm cover band). [note, carpark]
3. **Rule 3:** FAIL (BUG-1341, program wording "Not found in ProjectData"). BUG-1240 and BUG-1094 are not in the note: not known.
4. **Rule 4:** NEVER CHECKED on a real job. Tim hand pass, half, a pit only, scratch drawing (first check).
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-099 and BUG-995 now fix in code, unproven. BUG-098 partly fixed (full view only). New: BUG-1340, BUG-1341.
7. **Next single thing:** run Codex on a pipe and a pit in a metre copy, to see the length and cover colours (BUG-994, BUG-1340).

**31. PITSCHEDULE (pit schedule)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks; BUG-1309, resets a layer's colour on placing). Opening can still copy a drawn pipe size into the record (no bug number). Esc at the insertion point places nothing but the row order is already saved [note]. BUG-1198 and BUG-458 now fix in code, unproven.
2. **Rule 2:** FAIL (BUG-1044, repeated pit number across Xrefs empties it). No Excel on 2022 to 2024, the note says CSV instead. Natural-order switch OFF by default. [note, first check]
3. **Rule 3:** FAIL (BUG-1274, plastic and "not in schedule" pits drop out silently, still there in the installed code). [note, first check]
4. **Rule 4:** FAIL (Codex W2-04 FAIL on 3.0.70; BUG-1274 found on a real council-issue drawing 4 Nov). Tim hand pass 29 Oct for natural order and Excel on a scratch drawing; BUG-1255 says Excel fails on 2027 [first check].
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** 16 bugs now fix in code, unproven, including BUG-1255 (Excel), BUG-1198, BUG-780, BUG-785 area, BUG-965, BUG-1022, BUG-1035. Still there: BUG-1274, 787, 1023, 1044. New: BUG-1342 (CSV file open in Excel), BUG-1309, BUG-1286.
7. **Next single thing:** run the schedule on a copy with 2 plastic pits and read how many rows it lists; this is the fault that hit a real council drawing.

**32. CDPROFILE (long section)**
1. **Rule 1:** NEVER CHECKED. Code says opening and preview change nothing, Apply is one step and one U, refuses locked layers, REFEDIT and Xrefs [note]. Not seen.
2. **Rule 2:** FAIL (BUG-1343, sump depth, pipe stub and scales fixed in code; BUG-1020 depends on an office layout switch; BUG-1154 long text value). [note, carpark]
3. **Rule 3:** FAIL (BUG-765, any number in an Xref becomes a level; BUG-1193 curved boundary treated straight; BUG-1192 partly fixed, ground line still runs through covers). [note]
4. **Rule 4:** NEVER CHECKED. No trial and never Tim-accepted.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** 11 bugs now fix in code, unproven: BUG-756, 760, 761, 762, 763, 764, 766, 767, 768, 769, 1012. New: BUG-1343.
7. **Next single thing:** have Codex build one long section on a copy with an uphill pipe and an invert above cover, to see BUG-761 and BUG-762 on screen.

**33. CDHELP (help)**
1. **Rule 1:** NOT APPLICABLE (reads only). Code says nothing in the drawing or record changes; never seen [note].
2. **Rule 2:** FAIL (BUG-1344, 2022 to 2024 logs a warning on every call and opens a web browser). BUG-555 now fix in code, unproven (web fallback off by default). [note, carpark]
3. **Rule 3:** FAIL (BUG-1217, Help invites input to read-only calculators; BUG-1216 wrong page for several tools). [note]
4. **Rule 4:** NEVER CHECKED. Tim's 7 ribbon clicks only.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-555, 1215 and 1220 now fix in code, unproven (help wording only). BUG-1175 not in the note: not known. New: BUG-1344.
7. **Next single thing:** open Help from CDRAINFALL and from Reverse Flow and read which page opens (BUG-1216, BUG-1220).

**34. CDS (your preferences)**
1. **Rule 1:** NEVER CHECKED. Code says Cancel and the X write nothing, Save writes only changed values, U does not undo Settings [note]. BUG-839 (Manager page undoing a save) is not in the note: not known.
2. **Rule 2:** FAIL (BUG-958, window position not remembered; BUG-1345, tooltip says last page but opens on Drafting). New logins get colleague defaults, existing ones never [first check].
3. **Rule 3:** NEVER CHECKED.
4. **Rule 4:** NEVER CHECKED. Tim's 5 ribbon clicks only.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-957 now fix in code, unproven (search jumps to top match). BUG-825 and BUG-227 partly fixed. New: BUG-1345.
7. **Next single thing:** on a second Windows login, open CDS and compare what is on Settings with Tim's login (rule 2 line 1, never tried).

**35. CDFEEDBACK (report a problem)**
1. **Rule 1:** PASS (part only): Tim hand pass for Cancel, one honest line (D29, H17). Send never pressed. Code says nothing in the drawing changes [first check, note].
2. **Rule 2:** FAIL (BUG-1166, office folder looked up in a different place by Civil and Manager). [note]
3. **Rule 3:** FAIL (BUG-1347, 2,000-character cut with no word; BUG-1215 partly fixed, window footer still says "save a local file, then email it"). [note, carpark]
4. **Rule 4:** NEVER CHECKED for Send. Tim hand pass was Cancel only.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-1215 partly fixed (Help only). New: BUG-1346 (typed report lost if the save fails), BUG-1347.
7. **Next single thing:** Tim presses Send report once on a spare login with a short test line and reports which folder the file lands in.

**36. CEBLOCKS (office blocks palette)**
1. **Rule 1:** NEVER CHECKED. Code says it refuses REFEDIT, locked layers and Xref blocks; a frozen layer now warns and places; one U expected but not proven [note]. BUG-1047 fix in code, unproven.
2. **Rule 2:** FAIL (BUG-1166, office folders looked up under the user folder only). [note]
3. **Rule 3:** FAIL (BUG-1348, raw program message when a palette file is missing). [carpark]
4. **Rule 4:** NEVER CHECKED. No record.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line (it describes Manager code beside Civil 3.0.90); not accepted.
6. **Changed since the first check:** BUG-1047 and BUG-524 now fix in code, unproven. BUG-1243 could not be confirmed in code. New: BUG-1348, BUG-1349 (Help says fixed size, scale asked first).
7. **Next single thing:** place a block on a frozen layer on a copy and read the line (BUG-1047).

**37. CDMANAGER (layer colours and draw order)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks; Apply Now cannot be undone by U, no bug number). Esc and Close drop unsaved edits without asking [note].
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** FAIL (BUG-1292, says saved or applied when nothing was). [carpark]
4. **Rule 4:** NEVER CHECKED. Codex read-only sweep C1 of 30 Sep only (first check).
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-229 now fix in code, unproven (layer names no longer shown twice). New: BUG-1292, BUG-1286.
7. **Next single thing:** open Apply Now on a brand-new drawing with no CE mark and read what it says.

**38. CDNEWDWG (new job drawing)**
1. **Rule 1:** NEVER CHECKED. Code says the drawing you are in is untouched and the new drawing is never saved; U does not remove the copied file [note].
2. **Rule 2:** FAIL (BUG-1166, templates folder looked up under the user folder only). Not available below the 2027 build; typing it gives "Unknown command" [note].
3. **Rule 3:** FAIL (BUG-969, old job's reference in the title block; fix in code, unproven). [first check, note]
4. **Rule 4:** NEVER CHECKED. No record.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-969 now fix in code, unproven (window re-reads the job record for the folder in the box). No new bug numbers.
7. **Next single thing:** make a sheet in job folder A, then change the folder to B in the window and read the title block reference.

**39. CDDESIGN (design inputs)**
1. **Rule 1:** NEVER CHECKED. Code says it marks the drawing as a CE drawing before the window opens and keeps that on Cancel (no bug number); Confirm LPD refuses locked layers, Xrefs and REFEDIT, one U [note]. Not seen.
2. **Rule 2:** FAIL (BUG-1156, older CE wipes newer answers; BUG-1350, fixed rainfall curve, storm list and pump numbers). Council letters need 2027. [note, carpark]
3. **Rule 3:** FAIL (BUG-1099, 1110, 1116 still there; BUG-1143, damaged draft overwritten with no backup). [note]
4. **Rule 4:** NEVER CHECKED. Results never Tim-accepted.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** 12 bugs now fix in code, unproven (BUG-174, 259, 365, 506, 509, 510, 511, 967, 1004, 1091, 1095, 1106); four more (BUG-490, 783, 785, 812) fixed in other code. New: BUG-1350, BUG-1302 (Confirm LPD wording, shared with CDLPD).
7. **Next single thing:** Codex saves a draft, damages it, reopens and saves again, to see whether the agreed design is lost (BUG-1143).

**40. CDCALC (drainage calculations)**
1. **Rule 1:** FAIL (BUG-1293, cannot close without saving, a refused save traps you; BUG-1286, no start-up checks). BUG-1030 fix in code, unproven.
2. **Rule 2:** FAIL (BUG-1089, own fixed speed limits; fixed 0.9 and 9.81 values remain). [note]
3. **Rule 3:** FAIL (BUG-1352, Charged System and WSUD open with sample figures; BUG-1112 partly fixed). BUG-1101 fix in code, unproven.
4. **Rule 4:** NEVER CHECKED. Codex saw windows only (W5-01, W5-03).
5. **Rule 5:** note written, DRAFT, matches installed code per its own line (not every tab traced); not accepted.
6. **Changed since the first check:** 12 bugs now fix in code, unproven (BUG-1030, 158, 233, 515, 772, 905, 980, 997, 1019, 1036, 1097, 1101). New: BUG-1293, BUG-1352, BUG-1286. BUG-1268 (Export to Excel writes no file) not in the note: not known.
7. **Next single thing:** open Catchments and Charged System on a fresh copy and read what is already filled in.

**41. CDRAINFALL (the job's rainfall curve)**
1. **Rule 1:** FAIL (BUG-1353, record rebuilt and saved before the window opens, Close does not take it back; BUG-1286, no start-up checks). [carpark]
2. **Rule 2:** FAIL (BUG-1350, office curve fixed in the code, not on Settings).
3. **Rule 3:** NEVER CHECKED. Code says Save is offered only after preview and a ticked "I have checked this rainfall"; never seen [note].
4. **Rule 4:** NEVER CHECKED. No record.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** no fixed-in-code bugs. New: BUG-1350, BUG-1353, BUG-1286. BUG-1216 (Help opens the wrong page) still there.
7. **Next single thing:** run CDRAINFALL, press Close, and check whether the drawing now shows as changed.

**42. CDTWL (top water level)**
1. **Rule 1:** FAIL (BUG-1354, CE mark written before the first question, Esc does not take it back; BUG-1286, no start-up checks). [carpark]
2. **Rule 2:** FAIL (BUG-1351, fixed 0.5 L margin and 10 m ceiling; BUG-777 default switch OFF as installed). BUG-871 metre handling is fix in code, unproven.
3. **Rule 3:** FAIL (BUG-1056, "That is enough" with water below a floor; BUG-1021, pit with unknown floor left out). [note]
4. **Rule 4:** NEVER CHECKED on a real job. Claude-accepted for the freeboard card only, robot R14 and R14h (first check); never Tim-accepted.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-545, 871, 970 and 1032 now fix in code, unproven; BUG-777 fix present but switched off. New: BUG-1351, BUG-1354, BUG-1286.
7. **Next single thing:** run CDTWL on a copy with a habitable floor 100 mm above the water and read the answer (BUG-1056).

**43. CDRUNSOLVE (solve inverts down a run)**
1. **Rule 1:** FAIL (BUG-311, Cancel also rolls back a palette change). Code says the record is held in memory and put back on Cancel, one U for Apply, a locked-layer pipe is skipped and named; never seen [note].
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** FAIL (BUG-1291, every pit's design flow set to 0; BUG-1356, preview quotes sizes and grades Apply does not write; BUG-1355, run follows the first pipe at a branch). BUG-999 partly fixed.
4. **Rule 4:** NEVER CHECKED. No record.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** BUG-290 and BUG-868 now fix in code, unproven. New: BUG-1291, BUG-1355, BUG-1356.
7. **Next single thing:** run CDRUNSOLVE on a normal two-pit run and see whether it solves anything or stops with "none has a design flow".

**44. CDDEST (where each downpipe ends up)**
1. **Rule 1:** FAIL (BUG-1354, CE mark written before the first question, Esc does not take it back; BUG-1286, no start-up checks). Typed answers are saved one at a time; whether U takes them back was not traced [note].
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** NEVER CHECKED. Pipes drawn since the last record update may read "not known" (not proven).
4. **Rule 4:** NEVER CHECKED. Tim's 3 ribbon clicks only.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** no fixed-in-code bugs. New: BUG-1354, BUG-1286.
7. **Next single thing:** record a destination, press Esc part-way, then check the drawing and record for what changed.

**45. CDRULES (check against the engineering rulebook)**
1. **Rule 1:** FAIL (BUG-1358, every run adds its findings to the drawing with no trim; BUG-1286, no start-up checks). "Not applied" in Preview has already written the run record [note].
2. **Rule 2:** FAIL (BUG-1057 and BUG-1059, council values never reach the checks; BUG-1213, older AutoCAD cannot open the council source). [note]
3. **Rule 3:** FAIL (BUG-1090, nothing says the hydraulic grade line was not checked; BUG-1357, "results recorded" printed when the write was held back). [carpark]
4. **Rule 4:** NEVER CHECKED. None of its rules is Tim-accepted; never run in AutoCAD on a real drawing.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** 8 bugs now fix in code, unproven (BUG-239, 514, 540, 867, 901, 906, 907, 1092). New: BUG-1357, BUG-1358, BUG-1286.
7. **Next single thing:** run CDRULES ten times on a copy, save, and compare the file size (BUG-1358).

**46. CDRULEBOOK (rulebook settings for the job)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks). Each change is saved as you answer. BUG-1071 ("set" when the save was skipped) is not in the fixed list, but the note says it now says "not saved" with a switch on: code says yes, never seen.
2. **Rule 2:** FAIL (BUG-1109, no council value can be edited anywhere; BUG-1213, older AutoCAD cannot open the council source). [note]
3. **Rule 3:** NEVER CHECKED. 284 values marked Assumed with no council source (first check, still unchanged: not known).
4. **Rule 4:** NEVER CHECKED. Start-up only in the Codex sweep.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** no fixed-in-code bugs listed. New: BUG-1286.
7. **Next single thing:** change the pit drop with the settings file locked and read whether it says "not saved" (BUG-1071).

**47. CDSYSTEM (put pipes in a system)**
1. **Rule 1:** FAIL (BUG-1286, no start-up checks). Whether one U takes the change back was not traced; it changes only CE's record and says "Save the drawing to keep it" [note].
2. **Rule 2:** NEVER CHECKED.
3. **Rule 3:** FAIL (BUG-1359, count is pipes changed, not picked, "0 pipe(s) recorded" can print; BUG-1360, other objects dropped without a count). [carpark]
4. **Rule 4:** NEVER CHECKED. No record in any source.
5. **Rule 5:** note written, DRAFT, matches installed code per its own line; not accepted.
6. **Changed since the first check:** no fixed-in-code bugs. First faults filed: BUG-1359, BUG-1360, BUG-1286.
7. **Next single thing:** select 5 objects (3 pipes without CE records) and read the count it prints.

---

# What this did not check

1. **Nothing was run.** No AutoCAD, robot, build or test for this file.
2. **Two readers built the blocks** from the sources named at the top (tools 1 to 24 and 25 to 47); this lane checked ten of the new bug titles against the bug file and the rule counts above by counting the blocks. Individual blocks were not each re-checked against every source.
3. **Bug matching is by command name** in each entry's heading and first lines. A fault filed under a shared engine may be missing from a tool's block.
4. **"Fix in code, unproven" comes from one reading of the installed code.** None of those fixes has been seen in AutoCAD.
5. **The trial-build evidence** (CDGRAPH and CDDIAG stop changing the record) is about builds not installed; it moves no box here.
6. **No client or job names** were carried from any source.
