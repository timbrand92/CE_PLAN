# Tim's ruling: testing pilot, data pilot and design research, 1 Nov 2026 (about 03:10 Melbourne)

Recorded by CE 00 (desk chat).

Tim asked (Sun 1 Nov, in the desk chat):

> "we need to build a better system of managing all of our data and planning and building and bugs and everything all together, so it's stored in a much better way ... with 1200 bugs, there's no feasible way where we can test U-test, codex test, and another pass all the time for every single release ... do we always need a double check from both codex and claude? Like, surely Claude just does all of the testing of the command, and then codex just tests only the commands that require you to be seeing and clicking."

CE 00 proposed three things (testing in three levels, a read-only data pilot, and an Opus research design before any build) and asked for a yes or no on each. Tim answered:

> "as you recommend for all"

Read as: YES to all three, exactly as proposed, nothing wider. Evidence for the reading: the three items were the only open question; "all" followed a message that listed them as 1, 2, 3.

## 1. Testing pilot on C-79b1 (and its cases), measured, then Tim decides

1. **Three levels of proof.** (a) Claude's robot alone, for anything whose answer is a number, text, count, layer or object property in the drawing ("Claude-accepted", 24 Oct amendment). (b) Codex only for what must be SEEN (labels, overlaps, windows). (c) Tim for engineering judgement.
2. **Changes to the 24 Oct conditions, for the pilot only:** (1) the second AutoCAD session is not needed for a case that belongs to a family whose first case already passed in two sessions; (3) the independent Opus review is done once per batch of cases, not per case. Conditions (2) broken twin once per case family, and (4) full coverage, stay.
3. **Codex audit:** about 1 in 10 Claude-accepted results is repeated by Codex as an audit; any disagreement sends the family back to full double proof. Tim's weekly spot-check stays.
4. **Unit-test evidence:** for pure-logic bugs (calculation, parsing, wording) a test that fails before and passes after the fix may count as the evidence, with no AutoCAD run, if the reviewer writes that down.
5. **Headless runs:** CE 02 measures how many commands can run headless (accoreconsole) instead of through the window.
6. **Measure:** minutes of AutoCAD time per accepted case, before and after; number of audit disagreements. Report to Tim after C-79b1's area test; Tim decides whether the new rule stays, changes or goes back. Until then it applies to C-79b1 cases only.

## 2. Data system: read-only pilot (after the design)

One database in plain files under C:\CE_PLAN (history in git), as the only record of bugs, fixes (PRs), trains, cases, runs, acceptances, decisions and questions. Pages Tim reads are GENERATED from it, never typed. First step is a read-only import of BUG_CARPARK.md with counts compared against the old numbers, plus one generated page. The Markdown files stay untouched until Tim approves a switch. Old and new side by side (foundations skill).

## 3. Research first

An Opus researcher writes the design (options, table layout, import plan, generated pages, test plan, migration safety) to `C:\CE_PLAN\areas\DATA_SYSTEM_DESIGN_01NOV.md` BEFORE any build. Tim approves the design before the pilot is built.

## Not covered by this ruling

Any change to what counts as "fixed" beyond the pilot above; retiring the Markdown files; moving anything to GitHub Issues or Notion.
