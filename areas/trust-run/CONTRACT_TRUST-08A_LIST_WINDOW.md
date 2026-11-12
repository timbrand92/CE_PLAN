# Contract: the Check this drawing window, slice A (read-only list)

**Status: DRAFT, written Fri 13 Nov 2026 by lane trust-foundations (the behaviour side).** For the window builder. Card: `04_REFERENCE\ux-plan\cards\TRUST-08_CHECK_THIS_DRAWING_CARD_DRAFT_2026-11-12.md`, itself a DRAFT Tim has not approved. Nothing here is built as a window. The list behind it is built and unit-tested on branch `claude/trust-08a-check-list`.

---

# FOR TIM

**The window shows the same list the typed command already prints: what CE is Sure of, what it Proposes and why, and what is Unknown. In slice A it only shows; there is no Apply button.**

```before
CDCHECKDRAWING typed: the list scrolls past on the command line, 20 rows a group.
```

```after
One window, three groups, every row readable, click a row to see it on the plan.
Still no Apply in this slice.
```

---

## 1. Where the list comes from (already built)

1. **One call gives the whole list:** `CheckThisDrawingService.Read(document)` returns a `CheckThisDrawingList`. The window never reads the drawing itself and never calls anything else of CE's to get its rows.
2. **What the list holds:** how many objects are Sure, by kind (`SureByKind`: "pits" 12, "pipes" 19); the Proposed rows; the Unknown rows; blocks on drainage layers CE does not recognise (name and count); drawing-wide notes; the state line (the same line the drawing gets on opening); and whether the drawing stayed unchanged while it was read.
3. **Each row holds:** what it is (`What`: "Pit", "Pipe"), what CE found (`Found`), what CE proposes or what is not known (`Says`), why (`Why`), and the drawn object's permanent name (`Handle`) for zooming only.
4. **The grouping rule is the list's, not the window's:** every object is in exactly one group. The window never moves a row between groups and never re-words a row.

## 2. What the window must do

1. **Three groups, in this order:** Sure, Proposed, Unknown. Sure is a count that can be opened, not a list to read (card section 1, item 2).
2. **Each Proposed and Unknown row shows three things:** what was found, what is proposed or not known, and why. Use the row's own words.
3. **No tick boxes and no Apply button in slice A.** Nothing in the window may change the drawing or CE's record.
4. **Below the groups:** the unrecognised blocks line (if any), the notes (if any), the state line, and the closing line. The closing line is the list's: "Nothing has been changed..." or, when the drawing changed while it was being read, the list's own warning line. Do not replace the warning with the normal line.
5. **Nothing to check:** when the list says so (`NothingToCheck`), the window does not open; the command line shows `CE: all linked. Nothing to check.`
6. **Click a row:** zoom to the object and light up what it is linked to (card slice A). See section 4 for what this must not do.
7. **Two drawings open:** the list belongs to the drawing it was read from. When the drafter switches drawing the window closes or reads again; it never shows one drawing's rows over another.
8. **Refresh** reads again through the same one call.

## 3. What a drafter must never see

1. **The object's permanent name (the handle).** It is for zooming only.
2. **Software words:** record field names, "null", "handle", "snapshot", "certainty", a settings key.
3. **A settings key in the "not switched on" line.**

## 4. What the window must never do (each needs a check before it is called done)

1. **Change the drawing or CE's record.** Opening the window, clicking rows, refreshing and closing must leave AutoCAD's changed-drawing counter where it was and CE's stored record identical. The list's own read already proves this for itself in the compiled code; the window's clicks are new and need their own proof.
2. **Add an Undo step or lose Redo.** The reviewer's card review warns that zooming from a list adds Undo steps. Zoom the way CE's existing Show does where that has been measured safe, or prove the new way on a copy first.
3. **Unlock a layer, touch an Xref, or work round REFEDIT.** Rows on locked layers are shown as rows; nothing is unlocked to light them up.
4. **Run CE's record update.** Not on open, not on refresh, not on click.
5. **Scroll its layout.** The row lists may scroll; the window itself does not (UI rule for high-use windows).

## 5. How it gets proven

1. **Robot, on copies:** open the window and close it; click every row; refresh. Changed counter and stored record unchanged each time. A deliberately faulty window that writes on a click must fail.
2. **Codex look:** one glance says whether the job is OK; no software words; a small job and a large job.
3. **Tim:** on jobs he knows, the Sure count is right and each proposal's reason is one he agrees with.

## 6. Not decided (for Tim, through the controller)

1. Whether Sure opens into a list or stays a count.
2. How 200 rows are grouped (the card's own "not known" item 3).
3. Whether clicking a pit lights up its links from the Inspector too (card decision 6).
4. The command's name (CDCHECKDRAWING is a DRAFT default) and where the button sits (step 2's ribbon).
