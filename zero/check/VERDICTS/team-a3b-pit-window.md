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
