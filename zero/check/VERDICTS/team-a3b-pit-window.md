# Verdict: team/a3b-pit-window at 3ae3e9f (Stage 1 item A3b: the Pit window Tim approved, with his D-390 additions)

**Verdict: HOLD. Six blockers.** Written Fri 20 Nov 2026, about 6:25 pm, by the check room. Checked on the bench only. First verdict on this branch (it replaces the held team/acad-windows). The compile gate passed: the whole solution builds, the AutoCAD plug-in project included.

**Who checked.** Honest check: Team helper, Claude Opus 5.5: `C:\CE_WORK\check\reports\a3b_honest_REPORT.md` (84 pictures in `a3b_honest_pics\`; seven fixes taken out, six caught). Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a3b_adv_REPORT.md`, proofs in `a3b_adv_proofs\`. The check room's own pictures: `C:\CE_WORK\check\reports\a3b_pics\`. The adversarial pass listed fifteen blockers; graded again here.

## 1. Suite seen

Hands 711 passed, 1 skipped (it waits for the flag marker: honest); bench 518 passed; saved-drawing reader 19 passed, 2 skipped (main's own); brain 748 passed and 2 or 3 timing tests over their one second (medians 138 to 261 ms; this branch changes no brain code; they passed when run together later: taken as load on the PC, not proven on main). One check was LOOSENED: the style check now measures `pit_full`, a sheet no tool opens, not the window the drafter gets (`bench/CeCivil.Bench/StyleCheck.cs:59, 485-551`).

## 2. What is right

The two set sizes and where the window opens, on every work area tried; nothing is written to the drawing before OK; Flip beside Size (greyed when square); a typed size ("600x900", "600 x 900", "900X600") taken and nonsense refused and kept in the box; Plastic sets 350 by 350; Match a pit copies size, kind and lid, never number or level; a fork is refused before anything changes; "P6", "p6" and " P6 " are refused when P6 exists; the remembering file is written only by a real use (it did not exist before or after the checks); rose on OK only; every status colour carries its word.

## 3. Blockers

1. **Step 3 is cut off at the laptop size Tim approved.** At 1000 by 620, a pit joined both ways whose pipes' figures are "given" and "measured" (what a drawn pipe holds) loses the "= Depth" row: 0 of its 24 units show; with a notice as well, "Outlet invert" goes too and the size pictures are sliced (`bench/CeCivil.Bench.Core/windows/pit.csv:55-56` pushes step 2 to three lines). D-386: nothing cut off at either size. The builder's states use the short word "(chosen)", and its cut-off test cannot see a part clipped by a smaller box (`bench/CeCivil.Bench.Tests/AcadWindowHostTests.cs:178, 232-251`): with step 3 clipped to nothing, all four size checks still passed. The desktop size is whole in every state.
2. **The depth is taken from the FIRST pipe out, not the lowest.** Cover 12.82 with outlets at 12.37, 12.17 and 11.97: the window says 0.45 m deep; the lowest outlet gives 0.85 m. Step 2 reads one pipe each way (`src/CeCivil.Hands/Pit/PitTool.cs:706-720`; `bench/CeCivil.Bench.Core/ToolWindow.cs:23`). D-392, D-407 item 5: cover less the LOWEST outlet invert (plus a sump value, 0 in Stage 1, which the sum does not yet carry: `src/CeCivil.Brain/data/sums.csv:8`). A wrong depth on the window, the schedule and the size check.
3. **Renumber changes pits on locked, off and frozen layers, in an xref and under reference editing.** The plan and the write never ask the edit guard (`PitTool.cs:737, 783, 811-824`), and it runs after the new pit is drawn (`src/CeCivil.Acad/PitCommand.cs:97-102`). With a second adapter that refuses the protected write, ten writes had already been made. D-348, standing brief 3.5: tested before any edit, said in words, nothing half done.
4. **Renumber reaches pits it should not, and its count is wrong.** Clicking P2 on one run renamed a separate run elsewhere (P10, P11, P3A became P4, P5, P6) (`PitTool.cs:766`). The control room's draft is every pit JOINED to the clicked one, no others. The number just typed for the new pit is silently replaced (P99 became P3), and the window said three numbers change where four did. A name he gave (P3A) is lost; the schedule follows.
5. **The sum and the plan text do not agree with the figures.** Cover 5.755 over an outlet of 5.18: step 3 prints 5.755 − 5.18 = 0.58 (it is 0.575); the plan panel says CL 5.76, "What else changes" says CL 5.755, and the drawing gets "CL 5.755", three decimals on the sheet. Cover 5.00495 over 4.995: the depth shows 0.00 where D-341 gives 0.01, and the panel CL 5.00 where it gives 5.01. D-341, D-380, the approved style: a sum adds up exactly as printed.
6. **A cover level of 1,000 m and over is lost.** Type 1000.125, OK, reopen: the drawing holds "1,000.125" with a comma, the window cannot read it back and shows no cover; a second OK removes the stored level and leaves the old text on the plan (`bench/CeCivil.Bench.Core/ToolWindow.cs:58, 177`). A figure he typed is lost. (The comma fix exists on team/held-depth, not merged.)

## 4. To fix in the same round (not blockers alone)

1. **A refused cover leaves the old depth on show:** paste "5.75 m" over 12.82: the box is refused but step 3 still reads 12.82 − 12.37 = 0.45 under an amber band. A typed mistake reads red "Wrong" and the answers that depend on it "Cannot check yet" (D-414 item 8; the held page's ruling).
2. **An outlet above a pipe in reads green "Suits";** D-390: red. A pit too deep for its size reads amber, not red.
3. **A bare "6", "P 6" and "p7" are accepted beside P6** (D-414: "p4", " P4 " and "4" are P4; "p3a" is P3A). The duplicate-number job owns the rule; this window must not contradict it.
4. **The plan panel:** a grated pit and a junction pit look the same; a pit already turned 45 degrees is shown square; the number is plain text, not the circle tag; "CL TBC" shows in the panel but no cover text is drawn; only one pipe in is shown when four arrive; a long number overlaps the cover text.
5. **A plastic pit stretched to 600 stays Plastic** (D-402: Junction, said once). **Retyping "CL 12.82" as "CL 13.10" on the plan leaves the pit at 12.82** (D-402: it sets the level).
6. **The Lid as last used is forgotten when AutoCAD is restarted;** a drawing with no units set gets its line only after OK, not in the window (D-403 item 1).
7. **Words and look:** Inspect's line, the "1:100" note, the "Live" line and the size pictures' caption are gone; the band says "Not known" with no noun and "Cover level was Not known." after every change; sentences start in lower case; the greyed Flip is 2.54 to 1; the size limit has no grey source word (D-413).
8. **A saved window size of 700 by 430 is honoured** and cuts the depth row: never open smaller than the set size.
9. **Tests:** put the real Pit window back under the style check; make the cut-off test see a clipped part and use real pipe words; the Match test cannot tell a copied lid from one that follows its kind.

## 5. For the control room

1. **Renumber:** which branch first at a fork (today: refused); does the new pit being placed take part, with its final number shown before OK; a typed name for Renumber.
2. **A cover typed to three places (5.755):** show 5.76 everywhere it is printed, keep 5.755 as typed? (Recommended.)
3. **"P04" beside P4:** the same number?
4. **The depth limit for 900 by 600** (the builder used 600 by 900's 1.20 m, marked for Tim) and for the 19 size pairs with no limit in the office list.
5. **Plastic then back to Junction:** 450 by 450, or the size he had before?
6. **Neighbours on off or frozen layers:** shown in the plan panel or not? **A pit inside an xref:** may Match copy from it, and does its number count as in use?
7. **"600 by 900" typed as words:** accepted?

## 6. Owed in AutoCAD (when a build of this is merged; test copies only)

PT, Renumber, click the lowest pit of one of two runs, OK: only the joined pits change and one U puts every number and the new pit back; the same with the pit layer locked: refused in words, nothing changed or drawn; a pit joined to two drawn pipes in a 1280 by 720 AutoCAD window: the whole of step 3 shows; Match a pit; the plan panel over a real drawing with an architect's xref and circle tags; Inspect, Escape and Cancel; the window's place remembered after a real close; cover 5.755 typed: read the text on the plan; a pit with three pipes out: the depth.

## 7. Ruled since (control room, about 6:30 pm, D-421; all DRAFT for Tim; the fix round is held to these)

1. **Renumber:** at a fork the MAIN first (the bigger pipe arriving; if equal, the first drawn), then each branch in the order met going upstream; only pits JOINED to the clicked one; it never changes a pit on a locked, off or frozen layer or in an xref: one in the way refuses the whole Renumber, naming it; the pit being placed takes part, its final number shown before OK; no typed name, the button only.
2. **5.755 is kept as typed and exact in every sum;** two places, half up, wherever printed (5.76); sums never from rounded figures; three places never on the plan.
3. **"P04" is P4.**
4. **900 by 600 has 600 by 900's limit;** a size pair with no office limit shows grey "Cannot check yet: no office limit for this size", never an invented limit.
5. **Plastic then back to Junction:** the size he had.
6. **Off or frozen neighbours** are not shown in the plan panel, and still count for joins and numbers in use. **A pit in an xref is never looked at:** no Match from it, its number not counted.
7. **"600 by 900", "600x900" and "600 x 900" are all accepted.**


---

# Second verdict: team/a3b-pit-window at fa127bd (fix round one)

**Verdict: HOLD; fix round two (the last) follows, and it is built together with the pit levels page (D-436), which already answers several of these.** Written Sat 21 Nov 2026, about 12:31 am. Checked on the bench only. This tip does NOT contain the rounding branch (D-432), checked.

**Who checked.** Honest: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\a3b2_honest_REPORT.md`: HOLD on one blocker. Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\a3b2_adv_REPORT.md`, proofs in `a3b2_adv_proofs\`: HOLD. Of the six original blockers: CLOSED the lowest known outlet with its sump, and covers of 1,000 m and over; PARTLY the other four.

## 8. Blockers

1. **The depth is cut off at 1000 by 620 with many pipes** (both halves): four pipes in and four out (or seven pipes, or four in plus a refused number): step 3 loses its outlet and "= Depth" rows and the size pictures; step 2 grows a line per pipe without limit and the cards cannot scroll (`src/CeCivil.Window/Parts/Std/StdSteps.cs:762-775`). The desktop size was whole in all 24 combinations. (A cut-off at an approved size, D-346; the control room may rule how many pipes is ordinary.)
2. **Clearing an existing pit's cover leaves the old level on the drawing:** clear 12.82 with the tick on and press OK: the record loses the level and the preview says "CL TBC", but the drawing still reads "CL 12.82" (`src/CeCivil.Hands/Pit/PitTool.cs:300`). On a new pit with the cover blank, no "CL TBC" is drawn at all (D-392).
3. **Renumber can leave a duplicate number:** with separate pits P7 and P01, renumbering from P7 ends with P1 and P01; a bare "1" escapes the check too (D-401 item 6, D-428 item 1).
4. **Renumber can leave a partial edit:** a write that fails after the checks pass leaves the new pit P99 behind (one Undo, all or nothing: D-348).
5. **Paste repeats an occupied number:** pasting into a drawing holding an older pit named "p1" or "1" gives a new P1 (D-428 item 2; with P1 or P01 it rightly gives P2).
6. **Printed working can still be false:** 5.754 over 5.246 prints "5.75 − 5.25 = 0.51", whose printed figures make 0.50 (D-421 item 2; the pit levels page's group 8 names exactly this).

## 9. To fix in the same round

An outlet above an inlet on a mixed branch shows only amber, not red; a pit over its office depth limit reads amber (`checks.csv:63`); a refused cover shows "Not known" where "Cannot check yet" is due; the new pit and its final number are missing from the Renumber preview; at two forks the farther branch numbered before the nearer one (D-421 item 1, draft).

## 10. For the control room

1. **How many pipes is ordinary for the Pit window at laptop size?** Recommended: the window must stay whole at 1000 by 620 for any number of pipes (step 2 lists the first few and says "and N more", or the cards share the space), since a pit with eight pipes is rare but real.

## 11. Ruled since (control room, about 12:33 am, DRAFT, for Tim to confirm with a picture)

The Pit window stays whole at 1000 by 620 and at 1240 by 780 for ANY number of pipes; it never grows and nothing is cut off (D-386). Step 2 lists the first few pipes, the LOWEST outlet always among them (it sets the depth), then "and N more", which opens the full list in its own panel where a long list may scroll. Round two goes with the pit levels build, after the rounding fix (D-432, D-436).


---

# Final verdict: team/a3b-pit-window at 45eaaaf (its LAST fix round)

**Verdict: HOLD, final. Both halves hold it. Two rounds are spent, so under D-346 it goes to the control room with this open list.** Written Sat 21 Nov 2026, about 3:44 am. The checks ran on the bench only. Rounding and depth figures were not counted against this round, as ruled.

**Who checked.**
- **Honest half:** one Claude helper on Sonnet. Report: `C:\CE_WORK\check\reports\a3b3_honest_REPORT.md`. It holds on (a).
- **Adversarial half:** Codex gpt-6.2-astra. Report: `C:\CE_WORK\check\reports\a3b3_adv_REPORT.md`, with proofs in `a3b3_adv_proofs\`. It holds on three.

**Closed:**
- Renumber refuses the whole operation when it clashes with an outside pit (P1, P01, 1 and p1 forms), on visible and locked layers. It also refuses for a protected or xref pit, and it rolls back cleanly after an interrupted write.
- A cleared cover writes "CL TBC", and a new pit with no cover draws "CL TBC".
- The 55 earlier suite failures are cleared. The five seen in the honest half's full run were load effects and pass when run alone.
- The window is whole at 1240 by 780 for every pipe count tried.

## Open list (one page)

1. **Step 3 is cut off at the approved 1000 by 620 size (both halves).** With exactly five pipes at a pit, or with four pipes all arriving, the "= Depth" row and the size labels fall outside the card. The cause is `compact = morePipes.Count > 3` at about line 764 of `src/CeCivil.Window/Parts/Std/StdSteps.cs`. With five pipes and a refused number, none of the depth row shows. Every other count from 1 to 12, and 40, is whole. Ruling: section 11 (DRAFT) and D-346, a cut-off at an approved size.
2. **Renumber can throw away a valid edit (adversarial half).**
   - **The case:** with P1 joined upstream of P7, the drafter edits P1's cover from 12.82 to 13.10, chooses Renumber and picks P7 first. The preview accepts the swap (P7 to P1, P1 to P2).
   - **What goes wrong:** after OK the window closes, but the numbers stay P7 and P1, and the cover stays 12.82. The drafter's edit is silently lost. The cause is the comparison at `PitCommand.cs:105`.
   - **A second case of the same fault:** P2 edited to P99 leaves P1 and P99, although the preview said the joined pits would follow in order.
   - **Rulings:** D-421 item 1 and D-428 items 1 and 4.
3. **Paste can give two pits the same number (adversarial half).** The Pit window accepts and saves P2147483647. Beside an older pit "p1", pasting a P1 from another drawing twice creates two pits both numbered P-2147483648. Ruling: D-428, no duplicate number. The fix needs an upper limit on typed pit numbers, plus a paste that never wraps past it.

**What it needs:** one bounded round on these three items only, or a ruling from the control room. Each item already has its replay ready in the proofs folder.

**Owed in AutoCAD:**
- One Undo after a connected placement or Renumber.
- Pasted numbers and "CL TBC" after save and reopen.
- The native Pipe invert-label position, which stays WAITING (D-399).

---

# Read-back of the ONE bounded round: team/a3b-pit-window at e8badad

**Answer: READ-BACK FAILS. Both halves say so (honest on item 3; adversarial on all three). It goes back to the control room.** Written Sat 21 Nov 2026, about 5:05 am. Both halves ran on Codex under D-440, each in its own folder:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\a3b4_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `a3b4_adv_REPORT.md`, with proofs in `a3b4_adv_proofs\`.

The change stayed within the three items. It touches no depth or rounding sums.

**What is now fixed:** every earlier example passes.
- **Depth line:** the five-pipe and four-arriving cases are whole at both sizes.
- **Renumber:** the connected P1 swap and the P2-to-P99 edit finish at P1/P2 with CL 13.10. The upstream, downstream, fork and loop cases keep the edited cover.
- **Paste numbering:** pasting beside P2147483647 and p1 gives P2 and P3, never a wrapped number.

## Still open

1. **The depth line is still cut off at 1000 by 620** (adversarial half). The case:
   - three pipes in and two out, with drawing units unset and an already-used number typed: only 11 of 24 units of the Depth row show;
   - with the units warning alone: 19 of 24 show.

   That is 2 of 404 laptop layouts; all are whole at 1240 by 780. This is a cut-off at an approved size (D-346).
2. **Renumber can still lose a cover edit** (adversarial half).
   - **The case:** a separate P8 is edited to P2 with its cover changed from 12.82 to 13.10, then P7 is picked first on a joined P7-P9 run.
   - **What goes wrong:** the preview accepts it, and OK closes the window before it finds that the run also needs P2. All three pits keep their old numbers, and P8 reopens at CL 12.82.
   - **The fix:** the clash must be caught while the window is still open (D-421 item 1, D-428).
   - **A related case:** after a valid pick, a refused second pick (a locked P51) replaces the notice, but OK still renumbers the first run.
3. **Pit numbers: the limit leaks, and a pasted tag shows the wrong number** (both halves).
   - **Entries that get past the 1 to 9,999 limit:** P10,000, bare 10,000, P10,001A, P10000AA and P10000.0. Each is saved and printed exactly as typed. The check at `PitTool.cs:211` lets through any input it does not recognise. This is the DRAFT range in D-440 item 3.
   - **The pasted tag:** pasting P1 together with its number tag beside an existing P1 gives the new pit the record P2, but its tag still reads P1, so the plan shows two P1 tags. Beside P9998 the record reads P9999 and the tag P1. That is a wrong figure on the sheet (D-377 item 2, D-428 item 2).

**What it needs:** a ruling from the control room. Its fix rounds and its one bounded round are all spent. Each case already has its replay in the proofs folder.

**Follow-up (not a blocker):** after the P2-to-P99 edit, the "What else changes" line still promises schedule row P99.
