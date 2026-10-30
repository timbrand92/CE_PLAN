# Opus review of top-40 items 1 to 4 against their plan lines (Fri 30 Oct 2026, review 35, read only)

**What this is.** An independent Opus review of the four "review only" items at the top of `areas\TEST_NEXT_40_ITEMS_30OCT.md`. Nothing was built, run, installed or opened in AutoCAD. No runner, driver or validate call was made. No case, ledger or carpark file was edited. Written about 12:10 Melbourne time (PC clock).

## FOR TIM

1. **UX-LIVE-01, labels and schedule update straight after each edit: PART.** Pipe and pit labels updating straight after an Edit Pipe or a MOVE is proved. Not proved: a schedule table already placed on the sheet updating by itself, the OSD block updating, and big jobs showing a progress line with Cancel.
2. **"Downpipe and raingarden place like pits, before pipes": PART, and it carries the wrong plan number.** In the plan this is UX-SRC-05. UX-SRC-02 is "strip drain is its own type", which none of the three cited cases touches, so UX-SRC-02 itself is NO. For the downpipe item: a DP and a raingarden place on ground with no pipe, but the RG1 label is not drawn and a pipe drawn to the DP later is never tested.
3. **UX-WORD-01, "Free end" and "Not connected yet": PART, nearer NO.** Only the "Not connected yet" words are proved, in the message after you erase a pit. The words "Free end" appear nowhere in any run on today's build, and CDCHECK still prints the old "Not Connected" heading.
4. **UX-LBL-01, a label you moved by hand stays put: WAITING FOR TIM.** Your Monday question 19 (should a hand-moved label ride with its pipe end when you move the pit, or stay exactly put?) is still open. Separately, Codex saw it fail this morning (BUG-1252: the label moved 250 mm when the pit moved 500 mm), and the setting is OFF in your own file.
5. **Nothing for you to do except question 19.** None of the four can be ticked as whole today. Example of what this means on a job: change P3's invert in Edit Pipe and the IL texts on the plan update at once (proved), but a pit schedule table already on the C02 sheet has not been shown to update by itself.

---

## Common finding: the failing twins did not run on 3.0.86

The job's test is "passing cases with failing twins on one build". All passes below are on one build, Civil 3.0.86+5888ee75 (Structural 1.0.125+204dfad2, Manager 1.1.86+5888ee75), read from every report header I used. But the twins mostly ran on older builds:

1. **Twin red on 3.0.86:** only N36_BROKEN (aN36, a80D) and R32_BROKEN / R32b_BROKEN (a80F5, b80F5 area).
2. **Twin red on an older build only:** R11_BROKEN 3.0.83 (x83b1), N11_BROKEN 3.0.83 (n27a12), N26_BROKEN 3.0.85 (n3c6), R12_BROKEN 3.0.73 (p3b2fixB1), N04_BROKEN 3.0.83 (rn4t), R19_BROKEN 3.0.83 (x83b3), R19b_BROKEN 3.0.75 (b3bd1), N19_BROKEN 3.0.83 (n28a5), N23_BROKEN 3.0.85 (n3c3), N27_BROKEN 3.0.85 (n3c7).
3. **Twin never run on any build:** P02_BROKEN and N31_BROKEN (both still headed "NOT RUN YET").

The runner itself marks R11, N11, N26, R12, N04, R19, R19b, N19, N23 and N27 "ACCEPTED-READY" on 3.0.86, because its rule accepts a red from an earlier build. Under this job's stricter "one build" wording, each needs its twin re-run on 3.0.86. That is cheap (about 1 to 3 minutes each) and is listed against each item below.

## 1. UX-LIVE-01: PART

**Plan line (read whole).** Ruling 27 Sep 01:47 (`decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` line 1965): Tim: "Straight after each edit". "Live labels, schedule and OSD block update as each edit finishes; very large jobs batch with a status-bar progress line and Cancel (UX-PERF-01)." Summary line `V3_UX_PLAN.md` item 31: "live updates straight after each edit (batched with Cancel on big jobs)".

**What the cited cases prove (two clean passes each on 3.0.86):**

1. **R11** (a80F4, b80F4): Edit Pipe on P3 with new levels updates 4 pipes and 3 pits downstream; the IL texts on the plan carry the new levels straight after Apply; one U and REDO work. This is the "live labels" part.
2. **R12** (a80F8, b80F8, also a80X8): MOVE of a pit opens no CE window and its label, cover text and invert texts follow; one U puts it back. Also "live labels".
3. **N11** (a80F1, b80F1): after the cascade, U and REDO, the Pit Schedule window rows for P3 and P2 carry the new levels. Note it reads the schedule only after U and REDO, and through the PITSCHEDULE window, which rebuilds from CE's data when opened. It is not a read of a placed schedule table straight after the edit.
4. **N26** (a80F6, b80F6): CDSYNC after the cascade keeps every schedule row. CDSYNC is a manual resync command, so it is a neighbour of "live", not proof of it.

**Gaps, and the case that would close each:**

1. **Placed schedule table updates by itself straight after an edit.** This is the BUG-207 route (Edit Pit cover 21.00 to 21.10, placed schedule shows 21.10). Only Codex saw it, on 3.0.49 (14 Oct). Close with a new robot case: place a Pit Schedule table, Edit Pit cover on P1, read the table cells straight after Save (no PITSCHEDULE, no U or REDO in between); twin with the edit cancelled.
2. **OSD block updates straight after an edit.** No case reads an OSD block. Close with a case that edits the tank or outlet value and reads the OSD block attribute at once; twin without the edit.
3. **Big jobs batch with a progress line and Cancel.** Not covered by any case. Close with a Codex look on a large fixture (status bar line plus Cancel leaves the drawing whole), because the robot cannot read the status bar reliably.
4. **Twin reds on 3.0.86** for R11, R12, N11 (see the common finding).

## 2. "DP and CDRG place like pits, before pipes": plan number wrong; UX-SRC-02 is NO, the DP item (UX-SRC-05) is PART

**Plan line (read whole).** `V3_UX_PLAN.md` Sources line: "DP and CDRG place like pits, before pipes; OF/FO one symbol; strip drain its own type; RG tags; trench grate drag or type. (UX-SRC-01..05)". The rulings file (lines 468 to 476) gives **UX-SRC-02 (Q27): Tim: "Its own type (Recommended)". Strip drain is its own type in the Source window and asks for the run.** The DP and raingarden ruling is **UX-SRC-05** (26 Sep, Tim: "cdrg and dp are not pipe dependent if anything they are similar to pits which in most cases get placed prior to pipes connecting them"), as the UX-SRC-01-03 card, card D07, N04's own PLAN_ITEM line and the 28 and 29 Oct recounts all say. `TEST_NEXT_40_ITEMS_30OCT.md` item 2 has the wrong number.

**UX-SRC-02 as numbered in the plan: NO.** N04, P02 and N36 never run CDSTRIP. The UX-SRC-01-03 card names `SourceTypeRulingsTests` as unit tests only. Close with a robot case: CDSTRIP, three typed points, Accept, then one U; twin with no Accept.

**UX-SRC-05 (DP and raingarden), what is proved on 3.0.86:**

1. **N04** (a80F1, b80F1): a downpipe and a raingarden place where no pipe is nearby; "Downpipe placed. Tag: DP" and "The source connects when a pipe is drawn to it."; CDRG prints "Raingarden RG... placed"; one U takes back only the raingarden.
2. **P02** (aD1, bD1, p29a): about BUG-1140 (a pasted downpipe copy moved with MOVE leaves the original's label). It does not test "place before pipes". No review file and its twin has never run. Neighbour only.
3. **N36** (aN36, bN36, b80N36, b80X5a): DP places in under 20 s (BUG-1228 speed). Neighbour only. Note it FAILED once on 3.0.86 (a80D, the tighter 1.5 s / 10 s text) before the budget was loosened to 3 s / 20 s; no review of the loosened text beyond Opus review 32's PART.

**Gaps, and the case that would close each:**

1. **RG1 label not drawn** (N04 review; Monday question 15, B-007 build). Close after the build: N04 with a check for the RG1 text.
2. **A pipe drawn later to the placed DP joins it** (the "before pipes" half: the message promises it, nothing tests it). Close with a case: DP on empty ground, then CD ending on the DP, read "Flow: ... -> DP" or the link.
3. **Exact tag DP1, and a blank drawing.** N04 runs on DRV1_B1, not F-BLANK, and prints "Tag: DP", not the card's "DP1". Close by running N04 on F-BLANK with the tag asserted.
4. **DP after a reopen** (BUG-1225, open): N13 family.
5. **N04 twin red on 3.0.86.**

## 3. UX-WORD-01: PART, nearer NO

**Plan line (read whole).** Rulings line 353: Tim: ""Free end" / "Not connected yet" (Recommended)". "Your deliberate choice reads "Free end"; the undecided one reads "Not connected yet" in amber." Replaces the chip "Not connected" (used for "Keep as a free end") with **"Free end"** everywhere it appears (Pit window, Civil Properties, Inspector, checks). UX-EDIT-01 (line 1790) reuses "Not connected yet" for the pipe ends left by an erased pit.

**What the cited cases actually print on 3.0.86:**

1. **R19** (a80F8, b80F8, a80X7): "1 pipe now has an end that is Not connected yet." Proves the "Not connected yet" words in the ERASE message.
2. **R19b** (same runs): "6 pipes now have ends that are Not connected yet." Same.
3. **N19 and N23** (a80F7, b80F7): print "End is free: open end flagged, connect it later." and "Flow: Open end -> P8". Neither prints "Free end" or "Not connected yet". They prove the pit catch (UX-PIT-02), not this wording.
4. **R32** (aB1, b80F5, b80X6): prints only "Pipe updated." No chip words. Its 3.0.86 acceptance is PASS-UNREVIEWED (its review was for an older text).
5. **I searched every 3.0.86 report (.md and .json) for "Free end": zero hits.** The claim in `TEST_NEXT_40_ITEMS_30OCT.md` that all five cases "print these words" is wrong for N19, N23 and R32.
6. **Possible conflict with the ruling:** R19's own CDCHECK totals read "... 0 Not Connected, 0 Unknown." (95 hits in today's reports). If that CDCHECK category is the old "Not connected" chip, the ruling says it should read "Free end" in checks. I did not read the source to settle which status it counts.

**Gaps, and the case or look that would close each:**

1. **"Free end" for a deliberate free end, anywhere.** Close with a Codex look: Edit Pipe or Pit window, choose "Keep as a free end", screenshot the chip in the Pit window, Civil Properties and Inspector.
2. **"Not connected yet" in amber** in those same windows (colour is a Codex look).
3. **The checks wording.** Close with a robot case reading CDCHECK after a deliberate free end is kept: expect "Free end", not "Not Connected"; twin with an undecided end.
4. **Twin reds on 3.0.86** for R19 and R19b.

## 4. UX-LBL-01: WAITING FOR TIM (and failing today on a Codex route)

**Plan line (read whole).** Rulings line 861 (26 Sep 00:00): Tim: "Stays where you put it (Recommended)". "Hand-placed labels are remembered and never re-tidied; a new clash is listed quietly in Checks."

**What is proved on 3.0.86, both switches forced ON through the guard:**

1. **N27** (a80F5, b80F5): a hand-moved invert text that clashes is counted by Tidy labels as "Placed by hand (left alone) 1" and not moved. The review (Opus B7) says PART: the pit move is not driven, the typed Yes was never asked for, the default OFF setting is not covered.
2. **N31** (aD5, bD4): after a 10 mm pit move the hand-moved text moves between 1 and 20 mm. No review file, twin never run, and Codex cx_cr25 judged it WEAK (5 mm and 10 mm moves, not the card's 1000 mm and 500 mm).

**Why it waits, and what still fails:**

1. **Monday question 19 is open:** ride with the pipe end, or stay exactly put. The case to count depends on the answer (both drafts are in `CASE_DRAFTS_UNACCEPTED_TOOLS_30OCT.md` A3).
2. **BUG-1252, Codex G7 FAIL at 06:27 today on 3.0.86:** with the switch ON, a label moved by hand was shifted 250 mm when its pit moved 500 mm (neither answer), and Tidy labels counted zero placed by hand. So even after Tim answers, the item is EXPECT-FAIL until a fix is installed.
3. **The setting is OFF in Tim's own file** (`linking.handPlacedLabelsStay` false), so a drafter never sees the behaviour today.
4. **"A new clash is listed quietly in Checks"** is not covered by any case. Close with a case: hand-move a label onto a clash, run CDCHECK, read one quiet clash line; twin with the label left clear.
5. **"Remembered" across save and reopen** is not covered. Close with N27 plus a save, reopen, then Tidy labels.

## What I did NOT verify

1. I did not read the product source, so the CDCHECK "Not Connected" category point (item 3.6) is a reading of the words only.
2. I did not open any screenshot or window; colour (amber) and chips are unproved by me.
3. I did not read `case_runner.ps1`'s validate function, because I ran no validate (nothing was written to a case).
4. I read the case headers, checks, NOT_AUTOMATED lines, review verdicts and the 3.0.86 report lines for each case, not every step of every case.
5. I took the twin build list from the latest report that names each twin; a twin run under a different name could exist that I missed.
6. The time in the header is the PC clock at writing.
