# UX-RIBBON-01 workflow card — jump to the contextual Pipe/Pit/Source tab

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Front door,
batch 1 — 25 Sep 2026, 13:50", UX-RIBBON-01: **Tim: "Jump to it (Recommended)".** The choice he clicked read:
*Same as AutoCAD's Hatch and Text editors: select a pipe and its tools are in front of you. Escape or Close
returns to the CE tab.* Applies to the contextual **Pipe**, **Pit** and **Source** tabs alike.

## 1. Correcting a stale premise before anything else

This card was briefed on the basis that "the ribbon comes from CE_SHARED, which has no contextual-tab
support today," citing the memory note `civil-ribbon-shared-contract-blocker` (modified 24 August 2026).
**That memory note is now stale and this card does not repeat its claim.** Reading `origin/master` at
`bf57f739` (24 Sep 2026) in `C:\Lisp Files\CE_ACAD_PLUGIN`:

1. `Shared/CE_SHARED/Contracts/CeRibbonContractV3.cs` (the "R1" additions, dated in-code to the 5 Sep 2026
   ribbon design authority) already adds `CeContextualTabDefinition`, `CeSelectionFamily`,
   `ICeRibbonContributorV3` and the `Split` / `Toggle` / `Gallery` presentations the old note said were
   missing.
2. `Shared/CE_SHARED/Services/CeContextualTabController.cs` already raises and hides a contextual ribbon
   tab from the drawing's pick-first selection, going through
   `RibbonControl.ShowContextualTab(tab, activate, false)` / `HideContextualTab` so AutoCAD's own
   contextual-tab manager keeps it up (comment: "Test Day 5-09, 2026-09-07" records why a plain
   `IsVisible` toggle was rejected).
3. `Modules/Drainage/Services/CeCvlRibbonContributor.cs` already implements `GetContextualTabs()` and
   returns three built tabs — `CE_CVL_CTX_PIPE`, `CE_CVL_CTX_PIT`, `CE_CVL_CTX_SOURCE` — each ending in a
   Close panel (`CDCLOSETAB`), each opening on Edit first. This is tested:
   `Modules/Drainage.Tests/Services/CeCvlRibbonContributorTests.cs`,
   `GetContextualTabs_PipePitSource_EachEndWithClose_AndReverseFlowIsProtected`.
4. `Modules/Drainage/Services/StandaloneCivilRibbonService.cs` already registers these three tabs
   (`CeContextualTabController.Register(...)`) and feeds them from `CivilSelectionObserver` /
   `CivilSelectionClassifier`, which already classifies the pick-first selection into
   `CeSelectionFamily.Pipe / Pit / Source` (and Slab / Schedule / Device, unused by these three tabs).

**The only thing standing between today's code and Tim's ruling is one flag.** Every one of the three tab
definitions leaves `CeContextualTabDefinition.ActivateOnSelect` at its default, `false` — "show the tab,
don't switch to it." The test file says so explicitly, in words that are the literal open question Tim has
now answered:

> `Assert.That(tab.ActivateOnSelect, Is.False, "open question 5 (#63): show only until Tim answers");`

Question 5 / #63 in `04_REFERENCE\ux-plan\DESIGN_PACK_QUESTIONS_SORTED_2026-09-25.md` **is** UX-RIBBON-01.
Tim has answered it: jump to it. So this card is not asking for a CE_SHARED change — CE_SHARED already
carries everything this needs, in the identity that Civil and Manager both ship (CE_SHARED 1.1.0.0, first
loaded wins). It asks for `ActivateOnSelect = true` on the three Civil contextual tab definitions, and the
one test above updated to match.

**Note for the record, not a blocker for this card:** Structural ships its own older CE_SHARED
(1.0.74, no R1 additions), so this change reaches Civil's Pipe/Pit/Source tabs only, which is exactly what
Tim's ruling covers — pipes, pits and sources are Civil objects. Structural picking up contextual tabs of
its own is a separate, later request if Tim wants it.

## 2. What works today — Keep / Modify

1. **Selecting a CE pipe, pit or source — Keep the tab, Modify the switch.** Clicking one CE pipe, pit or
   source block already raises its contextual tab (green header) beside the CE tab, built from the real
   command registry (`CDEDIT`, `CDANNOTATIONEDIT`, `CDREVERSEFLOW` on Pipe; `CDEDIT`, `CDPITCOVERFLIP`,
   `CDFOCUS` on Pit; `CDEDIT`, `CDTAG`, `CDSOURCECHANGETYPE`, `CDFOCUS` on Source). Today the CE tab stays
   the active/front tab and the drafter must click across to the new contextual tab themselves. Tim's
   ruling changes this one behaviour: the contextual tab becomes the active tab the moment it appears, the
   way AutoCAD's own Hatch Editor and Text Editor contextual tabs work.
2. **Reverse Flow stays protected — Keep, unchanged.** The Pipe tab's `CDREVERSEFLOW` button is already
   marked `IsProtected` (confirms first, one Undo). Nothing in this card touches that.
3. **Closing the tab — Keep, unchanged.** `CDCLOSETAB` already clears the selection and hides every
   contextual tab (`RibbonContextCommands.CloseContextualTab` → `CeContextualTabController.HideAll()`).
   Pressing Escape in the drawing already clears the pick-first selection, which already fires the same
   selection-changed path down to `CeContextualTabController.Show(CeSelectionFamily.None)`, hiding every
   contextual tab. **Modify to confirm, not to build:** returning focus to the CE tab once the contextual
   tab is hidden is AutoCAD's own `RibbonControl` default when a contextual tab is dropped — this needs a
   real-AutoCAD look, not a code change, because it has never been driven with `ActivateOnSelect = true`
   before.
4. **Mixed or non-CE selection — Keep, unchanged.** `CivilSelectionClassifier.Classify` already returns
   `CeSelectionFamily.None` for a selection it cannot resolve to one CE family, which already hides every
   contextual tab. Not touched by this card.
5. **Reselecting while a tab is up — Keep, unchanged.** The controller's watchdog (`SetWatchdog`, "Test Day
   5-10, 2026-09-07") already re-raises a contextual tab AutoCAD's own ribbon manager tried to take down
   while a CE selection is still active (e.g. during the twin-barrel redirect). Not touched.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Modify.** Today: click a CE pipe/pit/source → its tab appears but the CE tab stays
   focused. Intended: click a CE pipe/pit/source → its tab appears **and becomes the active tab at once**,
   exactly like Hatch Editor. No new command, no new button — a data change to three existing tab
   definitions plus the shared "activate" flag already built to carry it.
2. **Prompts — Keep, unchanged.** No command-line prompt is involved in raising or hiding the tab.
3. **Selection — Keep, unchanged.** Pick-first only; the classifier already ignores a selection that mixes
   families or contains anything that isn't a CE object.
4. **Preview — not applicable.** This changes which ribbon tab is in front, not the drawing; nothing to
   preview.
5. **Drawing output — none.** No drawing entity changes.
6. **Cancel — not applicable.** There is nothing to cancel; the tab switch is instantaneous ribbon state.
7. **Escape — Keep/Modify as above (§2.3).** Escape already clears the selection and hides the contextual
   tab; whether focus lands back on the CE tab (not some other AutoCAD tab) needs the AutoCAD checklist
   below, since it was never exercised with `ActivateOnSelect = true`.
8. **One Undo — not applicable.** No drawing change, so nothing goes on the Undo stack because of this
   card. `CDREVERSEFLOW`'s own one-Undo behaviour, reached from the now-active Pipe tab, is unchanged.
9. **Save/reopen — not applicable.** Ribbon tab focus is session state, not saved with the drawing.
10. **Where values come from — not applicable.** No Settings value is introduced; `ActivateOnSelect` is a
    fixed per-tab design choice, not something a drafter edits.

## 4. Example drawings

1. **DWG-A or DWG-B (Civil):** any job with at least one CE pipe, one CE pit and one CE source (a downpipe
   or overflow) already drawn. Nothing new needs to be inserted for this check.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated (update existing tests, add one):**
   - `CeCvlRibbonContributorTests.GetContextualTabs_PipePitSource_EachEndWithClose_AndReverseFlowIsProtected`
     — change `Assert.That(tab.ActivateOnSelect, Is.False, ...)` to `Is.True`, with the comment updated to
     cite UX-RIBBON-01 instead of "open question 5 (#63)".
   - A focused unit test on `CeContextualTabController.Show` confirming it passes `activate: true` through
     to `RibbonControl.ShowContextualTab` when the definition's `ActivateOnSelect` is true (the controller
     logic already reads the flag; this proves the wiring, not the visual result).
2. **Tim's AutoCAD checklist (nothing else proves this):**
   - Open DWG-A. Click one drawn pipe. **Right result:** the Pipe tab appears and is immediately in front,
     the way selecting a hatch opens Hatch Editor in front.
   - Press Escape (or click the Pipe tab's Close button). **Right result:** the tab disappears and the CE
     tab is back in front, not some other AutoCAD tab.
   - Repeat for one pit and one source.
   - Click a pipe, then Ctrl-click a pit so the selection mixes families. **Right result:** no contextual
     tab claims the selection (unchanged behaviour); the CE tab (or whatever was already in front) stays
     in front.
   - Click a pipe, run `CDREVERSEFLOW` from the now-active Pipe tab. **Right result:** the existing confirm
     step and single Undo are unchanged.

## 6. Slices — smallest first

1. **Slice 1 (this card's whole scope):** set `ActivateOnSelect = true` on the Pipe, Pit and Source
   `CeContextualTabDefinition` entries in `CeCvlRibbonContributor.GetContextualTabs()`; update the one test
   named above. No other file changes expected. Given how small this is, one slice covers it.

## 7. OPEN questions, each with a recommended answer

1. **OPEN — does "jump to it" also apply the first time a drafter selects a CE object in a session, or only
   after the ribbon has already built once?** *Recommended: no distinction — the moment the tab exists it
   activates on select, same as every later selection; there is no code path that would treat the first
   selection differently.*
2. **OPEN — should Reverse Flow's confirm step (already protected) change in any way now that the Pipe tab
   is in front rather than behind?** *Recommended: no — `IsProtected` behaviour is independent of which tab
   is active; nothing in the existing code ties the confirm step to tab focus.*
3. **OPEN — Structural's own objects (beams, columns) have no contextual tab today at all. Does Tim want
   that raised as a separate later request, or left alone?** *Recommended: leave it alone for now — it is
   outside UX-RIBBON-01's wording ("a CE pipe/pit/source") and Structural ships an older CE_SHARED without
   the R1 contract, so it would need its own scoped card.*
