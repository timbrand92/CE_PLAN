# Review: the robot cases for the opening line (`areas\trust-run\cases\UX-OPEN-01.md`)

**Reviewer:** lane trust-review (second run), 12 Nov 2026, about 23:55 PC clock. Read only.
**Read against:** card UX-OPEN-01, the made-up drawings file `cases\_MADE_UP_DRAWINGS_AND_READINGS.md`, the built branch `claude/trust-01-open-line` (PR 2041, head 00c3baf5) and the installed code (cf059dcf).

---

# FOR TIM

1. **The 28 cases are a good start and cover most of what the card asks.** But the Undo case, as written, would pass even if the line broke Undo.
2. **Four "say nothing" cases can pass just because the robot looked too early,** and a few steps are too loose to repeat the same way twice.
3. **Three cases expect the opposite of what was built,** so the plan chat must decide which side is right before the robot runs; three cases are missing, including the drawing that starts AutoCAD.

**Verdict: FIX FIRST** (the list in section 1).

---

## 1. FIX FIRST

1. **O11 (Redo) passes while the fault is there.**
   1. AutoCAD keeps Undo per drawing. The line runs once, at open, before the test LINE; and the MD-02 part puts any stray Undo step in MD-02's list, not MD-01's. A build whose check took an Undo step would pass both halves.
   2. The real risk is the line running in the same drawing straight after a U. That can happen only while the line is still waiting for CE's opening jobs (it waits up to 5 seconds, `DrawingStateLineOnOpenService.MaxWaitForOpeningJobsSeconds`).
   3. Rewrite: open a drawing whose opening jobs are held back (for example MD-03 straight after a U in another drawing, or a slow copy), draw a LINE and press U before the line appears, wait for the line, then REDO: the LINE must come back. The faulty partner (a check that starts a normal transaction) must lose it.
2. **"Say nothing" cases can pass because the robot read too early** (O15, O16, O20, O24, and the quiet half of O4).
   1. "Wait for the line" has no time limit, and silence is the pass.
   2. The built line writes `[OpenLine] ...` to the CE log every time it runs, including `[OpenLine] quiet (not a Civil drawing)` (`DrawingStateLineOnOpenService.Say`).
   3. Rewrite: a quiet case passes only when that log entry for this drawing is present and nothing was printed; no log entry within 30 seconds = BLOCKED, not PASS. Every case gets one fixed wait.
3. **O2 accepts the right number for the wrong reason.** "Only the number and needs checking are marked", so "needs checking. 1 pipe not linked" would pass. The stray line must be counted under its own words ("1 line on a pipe layer not in the CE record" in the built wording), and the palette's matching item named by its heading ("Line on a pipe layer is not in the CE record").
4. **O9 cannot be done as written.** "Read the changed counter at the moment CE's opening jobs finish" has no moment the robot can see. Rewrite as a pair: open the same fresh copy with the line switched off, then on; the counter and both readings after opening must be identical between the two runs. MD-01 alone also works if a switched-off run first shows its counter stays 0.
5. **Settle three disagreements between these cases and the build** (controller's decision; the losing side changes):
   1. **O18, damaged record:** the case expects `CE: could not check this drawing.`; the build says `CE: needs checking. The CE record in this drawing could not be read. Type CDCHECKCURRENT to see more.` (`DrawingStateLineRule.Compose`). The card's "could not check" is for the check itself failing; the build's line is arguably more useful.
   2. **O20, scripts:** the case expects no line in a SCRIPT open; the build skips only accoreconsole. Also, if scripted opens were skipped, a robot that opens files by script would see no line in any case. Say how the robot opens files.
   3. **Section 5 look:** "no word like record" fails the card's own approved line `CE: 14 pit blocks found, no CE record.` and the built "not in the CE record". Either exempt "CE record" (card wording Tim agreed) or put the word to Tim.
6. **Add three missing cases.**
   1. **The drawing that starts AutoCAD:** start AutoCAD by opening a test copy (and with a drawing already open when CE loads). The built line listens only for drawings opened after CE starts, so this is the likeliest silent failure.
   2. **Several drawings opened at once**, then each made current: one line each, when it becomes current.
   3. **Switch off returns CDCHECKCURRENT to before:** with the switch off, CDCHECKCURRENT lists no "not in the CE record" item on MD-02 (the card's undo covers both).
7. **Make O1 and O8 test the ends that may be miscounted.** O1 tests the LPD end only. Add a pipe that starts at a downpipe (MD-01-DP) and one at a connection point, each counted as linked, with a faulty partner that counts them.

## 2. Steps too loose to repeat

1. **O5:** "two pits copied through WBLOCK" does not say how they come in. Inserted as one block, the pits sit inside it and the line sees one unrelated block. Say COPYCLIP and PASTECLIP, or INSERT with Explode ticked.
2. **O5 "naming 2 pits":** the line gives counts, not names. Say "counting 2 pit symbols not in the CE record".
3. **O10 and O12** assume MD-01 starts no opening job (pipe conversion or symbol swap). On 2027 a drawing whose pipes are not yet CE pipe objects will be converted and ask to be saved regardless of the line. Run each first with the line switched off as the control.
4. **O14:** AutoCAD itself makes the lock files; compare the folder with the switch off and on rather than "no lock file created by CE".
5. **O15:** the question "This drawing isn't tagged yet. Is this a Civil drainage drawing?" (`Services\DrawingDisciplineService.cs:155`) only appears on an untagged drawing. Say whether MD-15 is untagged and not named Structural; if it is tagged Structural, PIT refuses with a different line. Note Enter there means Yes and tags the drawing Civil; the case must press Escape, as written.
6. **O11's second half** ("switch to MD-02, open it, switch back, repeat U and REDO"): write the exact order of steps.

## 3. Cases that cannot fail for the reason given

1. **O16** "the command list registered in MD-15-B equals MD-01's": commands are registered once for AutoCAD, not per drawing, so this is always equal. Keep only "each tool starts and opens its window".
2. **O17's faulty partner** is described by open time, which cannot differ on a small drawing. The text check already catches it (counts printed instead of the large-drawing line); say that.
3. **O23's faulty partner** (a reach of 2000 drawing units) has nothing to act on: the line matches by object identity, not distance. The case is still worth running for units; drop the partner or give it one that applies (for example a size limit read in the wrong unit).
4. **O28's faulty partner** ("a size limit from a per-login value") is the design: the card puts the limit on each person's Settings page. And "the card says the check ignores personal settings" is not in the card. Keep the two-login run with identical size limits, or move it to step 3.

## 4. Good

1. Every case names its drawing, what to read back and a faulty partner; RECORD is used honestly where the card is silent.
2. The answer sheet comes from how the drawing was built, never from CE's own record.
3. O3, O6 and O24 target the right traps (old job, spoiled blocks, Xref pits).
4. The made-up drawings carry no client data.

## 5. Not checked

1. Whether the robot driver can read the command line and the CE log as these cases need.
2. Whether MD-01 to MD-29 exist yet (they are described, not found on disk by this review).
3. The other card case files (TRUST-02 to TRUST-08).
