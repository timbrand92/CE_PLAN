# Review: draft PR 2047, `claude/trust04-s-b499-trusses-out` (BUG-499 Structural, roof trusses in the wall bracing totals)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:58 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 8de95c34...origin/claude/trust04-s-b499-trusses-out` at head `4bb65787` (one commit, 3 files), PR 2047's description, the BUG-499 entry in `BUG_CARPARK.md` (only that entry, with Codex's 14 Oct observation), and in the installed Structural code at `C:\CE_WORK\scratch\audit_struc` (`8de95c34`, checked): `BracingPanelCalculator.cs`, `BracingPanelService.cs`, `BracingWallLineTotals.cs` and its tests, `BracingCommands.cs` (the BT1 command) and the panel window `BracingPanelWindow.xaml.cs`. PR base = `8de95c34`, the installed Structural 1.0.126 (checked).

---

# FOR TIM

1. **The bracing panel (CSBRACINGPANEL) would stop adding roof bracing trusses placed with BT1 into the wall totals.** One 2700 AB brace plus one 4000 BT1 truss, both north-south, would read 2700 provided, not 6700.
2. **This changes an engineering total, so it is your call, and it is marked that way.** One thing for you to weigh: BT1 draws its truss on a layer called "WALL BRACING TYPE BT1", so the office layer standard files them with wall bracing.
3. **The panel would not say it left the trusses out.** A drafter who places trusses sees the total drop with no word why; it errs on the safe side (short, not over).

**Verdict: GO** for the robot and Codex on copies (the numbers can be checked now). Before you are asked to confirm the rule: the panel should say what it left out (2.1), and your question should carry the layer name (2.2). Not a merge or install decision. Built yes (lane: net48 and net10, 0 errors). Tested unit only (lane: DesignCore 72 of 72 on net48, net8 and net10; panel calculator 25 of 25; broken twin with the skip line removed, 2 of 25 failed; not re-run here). Installed no. Accepted no.

---

## 1. What the brief asked

1. **Is the rule for what counts as a wall brace stated plainly? YES.** The change log item 2: "a brace tagged BT followed by a number (or plain BT) is left out of both wall totals", with the worked example (2700 provided against 5000 required, short; before, 6700). The code says the same (`BracingPanelCalculator.IsRoofTruss`, `Modules/Structural.DesignCore/BracingPanelCalculator.cs` 54).
2. **Is it a Setting, or clearly Tim's to confirm? Clearly Tim's to confirm, not a Setting.** The PR title ends "engineering rule for Tim", the PR body says "ENGINEERING RULE: Tim to confirm", and change log item 4 says "Tim to confirm the rule itself, because it decides what counts as wall bracing". The code comment beside the rule does not carry the "DRAFT default, Tim to confirm" words (small, 3.4). Whether it should be a Setting is a conflict for the controller (3.1).
3. **Would the test fail if trusses were added back? YES.**
   1. The skip is one line inside the one summing loop (`BracingPanelCalculator.cs` 93). With it removed, `Summarise_RoofTrussBt_IsLeftOutOfTheWallBracingTotals` (test file 112) gets 6700, not 2700, and `Summarise_OnlyRoofTrusses_GiveNoWallBracing` (128) gets non-zero totals. I checked both by reading the installed sum; the lane ran that broken twin (2 of 25 failed).
   2. The panel's only source of numbers is that method: `BracingPanelService.BuildSnapshot` hands every BRACING block to `Summarise` (`BracingPanelService.cs` 29-31), and the window shows `BuildSnapshot` (`BracingPanelWindow.xaml.cs` 115). So a truss cannot reach the panel another way today.
   3. Not covered by a test: a change that adds trusses back by a second summing path (see 2.3).
4. **What it does on the installed rules, checked:** before, one A brace plus one BT1 in a direction made the direction "types differ", so the panel showed no tick even at 6700 (BUG-950, `BracingPanelCalculator.cs` at `8de95c34`, `IsSufficient`). After, the truss is not counted at all, so a direction of A braces plus trusses can now show a plain tick or cross from the A braces alone. That is the intended result if the rule is right.
5. **The BT1 tags really are "BT" and a number:** BT1 asks "Bracing truss number [1-9]" and tags `BT{n}` (`BracingCommands.cs` 287-304), matching Codex's "BT9" of 14 Oct. Wall types A, B, BB and blank are untouched (test cases at 147).

## 2. Before Tim is asked to confirm (not blocking the robot)

1. **Say what was left out.**
   1. The panel shows only the totals and, when types differ, "(lengths only, brace types not weighted)" (`BracingPanelWindow.xaml.cs` 133). After this change four metres of truss simply vanish from a direction with no word. The bug entry's own "right result" says to "show them separately".
   2. Fix: carry a count and length of the trusses left out with each direction (or once for the panel) and show one plain line, for example "Not counted: 1 bracing truss (BT1), 4.0 m". The words in the window are Codex's; the count is behaviour.
2. **The question to Tim should carry the layer name.** BT1 draws on the layer "WALL BRACING TYPE BT1" (`BracingCommands.cs` 250 and 324), so the office's own layer standard puts these trusses with wall bracing. The bug hunt's "a roof truss is not wall bracing" was marked "I think". Both readings should be in front of Tim: "Leave BT trusses out of the wall totals (recommended by the bug hunt)" and "Count them (the layer name suggests the office does)".
3. **One rule, not two (design rule 1).** The wall-line engine (`BracingWallLineTotals`, built for the panel but not shown in any window yet) still counts trusses; the change log says so. Its own test checks that its line totals add up to the panel's totals (`BracingWallLineTotalsTests.cs` 43-45) but uses no BT brace, so the two can now disagree without any test failing. Put the BT rule where both read it (for example where `BracingPanelService` hands the blocks over) and add a BT brace to that agreement test, before any window shows wall lines.

## 3. For the controller

1. **Card TRUST-04 section 2 ("no off switch") against rule R-00 ("every engineering value lives on the Settings page").** The lane followed the card. If Tim's answer may be "count them", a Settings value "Bracing trusses (BT) count toward wall bracing: No" would hold the engineering rule rather than act as an off switch for a fault. Recommend: DRAFT default as built (left out, no Setting) until Tim answers; record the choice in the questions file.
2. **The two older HUNT2-S-05 points stay open and are listed:** a brace with no type tag still counts (the bug entry says it is read as type A; not re-checked here), and how A and B combine against "required" is unchanged (BUG-950). Both are Tim's.
3. **`PENDING_TESTS.md` section "TRUST-04 core safety fixes" row 8,** named in the PR, is not in `PENDING_TESTS.md` on `main` (checked 00:56).
4. **The code comment beside `IsRoofTruss` should say "DRAFT default, Tim to confirm"** (run rule 2.5), not only the change log.

## 4. Checked and sound

1. Only the calculator changes; no prompt, no drawing write, no layer, Xref or REFEDIT path; no units; `Shared\CE_SHARED` untouched; no existing test changed.
2. Fresh build on the installed commit, not a lift of the October branch (298 commits behind); the October off switch `PanelCountsRoofTrusses` is not brought in.
3. No real job data in the change, the tests or the change log.

## 5. Not checked

1. Did not build or run tests; the counts are the lane's.
2. Nothing run in AutoCAD: the panel's numbers on a copy (the change log's steps are right), the panel's live refresh after placing a truss.
3. Whether anything outside Structural (CE Ask, the MCP tool list, Manager) reads bracing totals from somewhere else.
4. AutoCAD 2022 to 2024.
