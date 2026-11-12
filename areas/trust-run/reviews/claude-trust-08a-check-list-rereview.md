# Re-review: PR 2051 `claude/trust-08a-check-list` (step 8 slice A, the read-only "Check this drawing" list, CDCHECKDRAWING, switch OFF)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:14 PC clock. **Head reviewed:** `58111dd4` (own fix commit `574c96e6`; `58111dd4` merges step 6's head `98d81717`). Against `reviews\claude-trust-08a-check-list.md` (at `29847f4d`). Read by a helper reader; the remaining internal-code line re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The list no longer shows a guessed pit number as found, keeps every proposal with its reason, refuses "Sure" for two pits with one number, and never says "all linked, nothing to check" on a drawing where it found nothing.
2. It still writes nothing and no row can arrive ticked.
3. One narrow leak is left: a pit whose CE record holds CE's internal stand-in code, but whose label shows a number, can still print that code.

**Verdict: GO** for the robot on copies, with one small fix to carry before Codex's look. GO means fit for testing on copies, never merge or install.

---

## Earlier FIX FIRST items

1. **Internal object codes in rows: PARTLY FIXED.** Reasons are rewritten to name each object by its pit number or what it is (`Modules\Drainage\Rules\CheckThisDrawingListRule.cs` 189-258); LPD rows no longer show "LPD-1" (406-427). **Left:** the reader writes "CE's record says <number> but its label reads <label>" (`Services\TrustReader\TrustDrawingReader.cs` 585, read by me); when CE's record holds its stand-in code for an unnumbered pit, that code is printed, and the rewrite has no rule for it (the stand-in check at `CheckThisDrawingListRule.cs` 139 does not catch it, because the number is already Unknown). No made-up test drawing has a stand-in number, so the new all-drawings test (`CheckThisDrawingListTests.cs` 338-357) cannot see it. Fix: rewrite "says <code>" too, and add a made-up case.
2. **A pit number guessed from the nearest label printed as found: FIXED** ("what CE found" carries only read or stored values, `CheckThisDrawingListRule.cs` 429-436).
3. **Unknown rows dropping proposals: FIXED** (378-399).
4. **Sure with no same-number check: FIXED** (two pits with one number both go to Unknown, 145-147, 269-321). No separate identity check, but a pasted pit is caught by its number.
5. **A record number no label shows: FIXED** (now a proposal, 140, 289-300, 345).
6. **CE's stand-in code read as a real number: FIXED** through step 6's own rule (139); the one leak is item 1.
7. **False "all linked, nothing to check": FIXED.** "CE found no pits or pipes in this drawing's model space." (65, 535-541); "all linked" needs at least one Sure object (71-75); notes for Xrefs not checked, model space only, layers renamed in this PC's Settings (`Services\CheckThisDrawingService.cs` 56-58, 66-91), kept on the all-clear (547).
8. **Two walks with different pipe-layer rules: FIXED** (the state line speaks only for CE's record and links, 167-180). Left: "N pipes not linked" has no row behind it (the window contract now says so), and the line still points to CDCHECKCURRENT.
9. **Window contract items: FIXED** in `C:\CE_PLAN` (commit fe18cd90): CE's existing Show not used for the zoom; link lighting out of slice A; off or frozen layer said, no layer changed; a layout tab in front says "switch to Model"; LPD rows may have nothing to zoom to.
10. **DBMOD is flags: FIXED in the code** (the drawing's own changed, added and erased object events are counted, `CheckThisDrawingService.cs` 36-61). Not proven in AutoCAD.
11. **Re-stack onto step 6: DONE.** The merge brings step 6's files unchanged and keeps this PR's own; only `REGRESSION_LOG.md` conflicted and both sides were kept.

## Still sound

1. **Writes nothing:** the new Xref check is an open-close read (68); no lock, write, save, record update, selection change or zoom anywhere in the command, service, filler or list rule.
2. **No row can arrive ticked:** rows hold only Handle, What, Found, Says and Why.

## New, minor

1. Downpipes and tanks are named "(no number)", so a reason can read "tag DP1 is on 2 blocks ((no number), (no number))" (206).
2. Two pits with the same number read "(P1, P1)".

## What I did not check

1. Built nothing, ran nothing.
2. The reader's own rules beyond what the list relies on; step 6's own commits (reviewed elsewhere).
3. Nothing in AutoCAD.
