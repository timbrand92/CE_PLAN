# Contract: the Check this drawing window, slice A (read-only list)

**Status: DRAFT, written Fri 13 Nov 2026 by lane trust-foundations (the behaviour side); changed the same day after the review of draft PR 2051 (`reviews\claude-trust-08a-check-list.md`, section 3): the zoom, link lighting, and four missing cases.** For the window builder. Card: `04_REFERENCE\ux-plan\cards\TRUST-08_CHECK_THIS_DRAWING_CARD_DRAFT_2026-11-12.md`, itself a DRAFT Tim has not approved. Nothing here is built as a window. The list behind it is built and unit-tested on branch `claude/trust-08a-check-list`.

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
2. **What the list holds:** how many objects are Sure, by kind (`SureByKind`: "pits" 12, "pipes" 19); the Proposed rows; the Unknown rows; blocks on drainage layers CE does not recognise (name and count); drawing-wide notes; the state line; and whether the drawing stayed unchanged while it was read.
3. **The state line speaks for CE's record and links only** (pits and pipes in the record, a pipe not linked, a pit in the record with no object). Drawn objects that are not in the record are rows, and are not counted a second time under them. **A count in the state line can have no row behind it** (a pit in the record whose object is gone has nothing to zoom to): the window shows the line as text and does not try to make rows for it.
4. **Each row holds:** what it is (`What`: "Pit", "Pipe"), what CE found (`Found`: only what was read or stored, never a proposal), what CE proposes or what is not known (`Says`), why (`Why`), and the object to zoom to (`Handle`), for zooming only.
5. **A row's `Handle` can be blank.** An LPD is a stored record, not a drawn object: its row carries its pipe (or, failing that, its pit) to zoom to, and nothing when neither is in the drawing. A row with a blank `Handle` is shown and cannot be zoomed to.
6. **The words are the list's, and they hold no object codes.** The list rewrites the reader's reasons so an object is named by its pit number or by what it is. The window never re-words a row and never needs to hide anything in one. If a code is ever seen in a row, that is a fault in the list, to be fixed there.
7. **The grouping rule is the list's, not the window's:** every object is in exactly one group. The window never moves a row between groups.

## 2. What the window must do

1. **Three groups, in this order:** Sure, Proposed, Unknown. Sure is a count that can be opened, not a list to read (card section 1, item 2).
2. **Each Proposed and Unknown row shows three things:** what was found, what is proposed or not known, and why. Use the row's own words.
3. **No tick boxes and no Apply button in slice A.** Nothing in the window may change the drawing or CE's record.
4. **Below the groups:** the unrecognised blocks line (if any), the notes (if any), the state line, and the closing line. The closing line is the list's: "Nothing has been changed..." or, when the drawing changed while it was being read, the list's own warning line. Do not replace the warning with the normal line.
5. **Nothing to check:** when the list says so (`NothingToCheck`), the window does not open; the command line shows `CE: all linked. Nothing to check.` and any notes. **Nothing found is different** (`FoundNothing`): the command line shows `CE found no pits or pipes in this drawing's model space.` and the notes (attached drawings are not checked; only model space is read). It is never shown as "all linked".
6. **Click a row:** zoom to the object. **Lighting up what it is linked to is NOT in slice A:** a row holds one object, and working out its links in the window would be engineering in the window. It comes back when the list supplies each row's linked objects (a later slice), or not at all.
7. **Two drawings open:** the list belongs to the drawing it was read from. When the drafter switches drawing the window closes or reads again; it never shows one drawing's rows over another.
8. **Refresh** reads again through the same one call.

## 3. What a drafter must never see

1. **The object's permanent name (the handle).** It is for zooming only.
2. **Software words:** record field names, "null", "handle", "snapshot", "certainty", a settings key.
3. **A settings key in the "not switched on" line.**

## 4. What the window must never do (each needs a check before it is called done)

1. **Change the drawing or CE's record.** Opening the window, clicking rows, refreshing and closing must leave AutoCAD's changed-drawing counter where it was and CE's stored record identical. The list's own read already proves this for itself in the compiled code; the window's clicks are new and need their own proof.
2. **Add an Undo step, lose Redo, or change what is selected.** Do NOT use CE's existing Show (`CeZoomHighlightService.ZoomAndHighlight`): it sets AutoCAD's selection, which wakes CE's selection watcher and the Civil Properties palette, and it zooms inside a normal transaction, the kind of call this step's own write guard rejects. Nothing has measured it as safe. The window's zoom must: read the object's extents with an open-close read; change only the view; show the object without touching the selection (a temporary highlight that is taken off again); and be proven on a copy first (probe P2: Undo list, Redo, CE's record, the drawing's object events, and AutoCAD's changed flags, which list "view changed" as a flag of its own, so a zoom may move that value; measure it and say so).
3. **Unlock a layer, thaw or switch on a layer, touch an Xref, or work round REFEDIT.** A row whose object is on a layer that is off or frozen zooms to nothing that can be seen: the window says "this object is on a layer that is off or frozen" and changes no layer. Rows on locked layers are shown as rows; nothing is unlocked.
4. **Switch to Model by itself.** The list reads model space only. With a layout tab in front, clicking a row says "switch to Model to see it"; the window does not change the tab (that changes a drawing setting).
5. **Run CE's record update.** Not on open, not on refresh, not on click.
6. **Scroll its layout.** The row lists may scroll; the window itself does not (UI rule for high-use windows).

## 5. How it gets proven

1. **Robot, on copies, each case from a FRESHLY OPENED drawing:** open the window and close it; click every row; refresh. CE's stored record identical each time, and no object changed, added or erased (counted from the drawing's own object events). AutoCAD's DBMOD is not proof: it is a set of flags that is already set once a drawing has unsaved work. A deliberately faulty window that writes on a click must fail.
2. **Codex look:** one glance says whether the job is OK; no software words; a small job and a large job.
3. **Tim:** on jobs he knows, the Sure count is right and each proposal's reason is one he agrees with.

## 6. Not decided (for Tim, through the controller)

1. Whether Sure opens into a list or stays a count.
2. How 200 rows are grouped (the card's own "not known" item 3).
3. Whether clicking a pit lights up its links from the Inspector too (card decision 6).
4. The command's name (CDCHECKDRAWING is a DRAFT default) and where the button sits (step 2's ribbon).
