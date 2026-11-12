# Re-review 2: PR 2038 `claude/trust-core-ribbon-e13111` (step 2, the core ribbon), moved after its GO

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:21 PC clock. Read only. **Head reviewed:** `8da2ec4b` (one commit since `b4c46bd3`, the head given GO in `reviews\claude-trust-core-ribbon-e13111-rereview.md`). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The three small things the last review asked for before Codex reads the tooltips are done: Pit and Generic Source no longer carry words about a drop-down arrow they do not have; no bug number appears in any tooltip; the change log no longer says you chose to leave the 2022 to 2024 menu alone.
2. Nothing else on the two tabs changed.
3. The GO still holds.

**Verdict: GO** (unchanged) for the robot's layout checks and Codex's look on copies. GO means fit for testing on copies, never to merge or install.

---

## What changed since the GO, item by item

1. **Drop-down words on plain buttons: FIXED.** When today's words are gathered, a drop-down face (a button with a gallery, children or a default action) now gives only its short line, never its long words (`Services\CeCvlCoreRibbon.cs` 117-129); its children are still gathered with their own words. A test checks Pit and Generic Source have no "arrow" or "gallery" and no core button says "The arrow".
2. **Bug number in Front Overflow's tooltip: FIXED,** and also taken out of Floor Waste's and Pit Schedule's fault lines (`Services\CeCvlCoreRibbonList.cs` 49, 53, 89); a test checks no tooltip or fault line holds "BUG-".
3. **Change log item 6 credited Tim: FIXED.** It now says the menu was left unchanged on the plan chat's reading of Tim's 12 Nov answer, and that Tim has not said to leave it.

## New problems

None found. Small: buttons that are drop-down faces today now show only their short line on the core tabs (the long words were about the arrow); for Codex's look.

## What I did not check

1. Built nothing and ran no test.
2. Nothing in AutoCAD; no picture of either tab.
3. No client name, street, suburb or job number in the diff (checked).
