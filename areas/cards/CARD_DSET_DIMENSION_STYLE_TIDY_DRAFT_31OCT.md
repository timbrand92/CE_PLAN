# DRAFT FOR TIM: DSET, turn every other dimension style into TIM LEADER or TIM DOT LEADER (BUG-634)

**Status:** DRAFT FOR TIM. Mandatory card: this CHANGES DRAWING CONTENT, so no code starts until Tim approves it. Not built, not tested, not installed. Written 31 Oct 2026 (job z4).
**Classification:** MODIFY and in part REBUILD. Keep: the DSET and DSET1 names, selection of dimensions, the 1.0 to 0.2 measurement factor change, the locked-layer rule. Add (this is new, nothing like it exists today): recognise the two office styles, convert every other style to one of them, then purge the old style.
**Source:** Tim decisions 165 ("5yes purge the rest out automatically by making them mine") and 172 ("tim leader or if its a dot leader then use tim dot leader"). Bug entries BUG-634 and BUG-633 (C:\CE_PLAN\BUG_CARPARK.md). Code read on Structural origin/claude/rel-20261026s: Commands/DimensionCommands.cs.

## 1. What works now (read from the code)
1. **DSET:** pick one dimension; CE sets its measurement factor to 0.2 (so a drawing at 1:5 reads right) and says so. It does not look at the style at all.
2. **DSET1:** select dimensions (a window or a crossing); each one whose factor is 1.0 becomes 0.2; others are skipped. It prints "DSET1 complete. Converted: n, Skipped: n". It does not look at the style either.
3. **The two office styles** TIM LEADER (arrow) and TIM DOT LEADER (dot) exist as named styles; CE brings them in from the office import drawing when a drawing lacks them, and Q, QD, LD, AD and RD use them.
4. **Native protection already respected:** a dimension on a locked layer is left alone and counted with one plain line. CE never unlocks a layer.
5. **BUG-633 (selection of an ordinary dimension)** carries a change on this line; it is a separate bug and its AutoCAD look is not part of this card.

## 2. What is wrong or missing
1. **BUG-634:** DSET1 accepts a dimension in a style CE does not know (the test style CODEX_UNRECOGNISED) and changes it straight away, with no list of what it will touch and no Apply.
2. **No tidy-up of foreign styles.** Drawings from other offices or older jobs carry styles such as RS DIMSTYLE, STANDARD$7 (the copy AutoCAD makes when drawings are pasted together), Annotative, SP_ARROW, 1-100, 2_0mm, POINT_TICK_2_0mm and Arrow. These stay in the drawing and keep appearing in the style list. (Those names are from the office's own analysis of past drawings: STANDARD is in every drawing; TIM LEADER is in 33 of 40 structural drawings.)

## 3. Tim's words
1. "5yes purge the rest out automatically by making them mine" (decision 165).
2. "tim leader or if its a dot leader then use tim dot leader" (decision 172). This settles the mapping, so it is no longer a guess.
3. House rules that apply: never touch Xref or locked-layer content (native protection rule); warnings never block (R-27); one Undo.

## 4. The rule (Tim's word, with the detail a drafter needs)
1. **Recognised styles:** TIM LEADER and TIM DOT LEADER. Dimensions in these are left exactly as they are.
2. **Every other dimension style** becomes TIM LEADER, **except a dot-leader style, which becomes TIM DOT LEADER** (decision 172).
3. **Then the old style is purged** (removed from the drawing's style list).
4. **How CE decides "dot leader" (UNCONFIRMED: my suggestion, Tim has not said how):** the old style's arrowhead is one of AutoCAD's dot heads (DOT, DOTSMALL, DOTBLANK), or the style's name contains the word DOT. Anything else, including a style with no arrowhead set, becomes TIM LEADER. A style that is unclear is shown in the list with the word "assumed arrow".
5. **Leaders:** dimension styles are also used by leaders and quick leaders. UNCONFIRMED whether they are in scope; recommendation: yes, because a leftover style on a leader blocks the purge.

## 5. Full experience
1. **Trigger:** the existing DSET1 (select dimensions) and DSET (one dimension). Plus one new typed entry for the whole drawing, **DSET1 then type All at the selection prompt** (recommendation; no new command name and no new ribbon button).
2. **Prompts, in order:**
   1. Select dimension(s) (as today), or All for the whole drawing.
   2. **A plain list, before anything changes**, for example:
      - "RS DIMSTYLE: 14 dimensions, will become TIM LEADER."
      - "SP_ARROW: 6 dimensions, will become TIM DOT LEADER (dot arrowhead)."
      - "STANDARD$7: 3 dimensions, will become TIM LEADER."
      - "Left alone: 2 dimensions on a locked layer; 5 inside an Xref."
      - "Cannot be removed afterwards: STANDARD (AutoCAD keeps it)."
   3. **Apply or Cancel**, default Apply. Because Tim said "automatically", one Enter is all it takes; there is no question per style.
3. **Preview:** the list is the preview. No picture on the drawing. (Question 2 asks whether Tim wants a picture as well.)
4. **Drawing output after Apply:** every dimension in an old style takes its new style. The old style is then purged only if nothing else still uses it. The measurement factor change of DSET1 (1.0 to 0.2) is applied exactly as it is today and is not mixed up with the style change.
5. **What is left alone, and named in the list:** anything on a locked layer, anything inside an Xref (the Xref's own styles show as "xref|NAME" and are never touched or purged), anything inside a REFEDIT in progress, and a style that is still used by something CE did not touch (it is kept, and the list says which one and why).
6. **Cancel / Escape:** at the list or at any prompt, nothing changes, no style is added, none removed.
7. **Undo:** the whole run, conversion and purge together, is one Undo and one Redo. (To be proved in AutoCAD: AutoCAD sometimes restores a purged style in a separate step.)
8. **Save and reopen:** converted dimensions reopen in TIM LEADER or TIM DOT LEADER; purged styles stay gone. Nothing forces a save.
9. **After the run, one result line:** "Converted 23 dimensions: 17 to TIM LEADER, 6 to TIM DOT LEADER. Removed 3 styles. Left alone 7 (list above)." Warn and record, never block (R-27): a dimension CE cannot convert is named and the rest carry on.
10. **Dependencies:** the two office styles must exist; if the drawing lacks them CE brings them in from the office import drawing first (as it does today for Q and QD). If that file is missing: one plain line and nothing is converted.
11. **Performance:** one pass over the selected dimensions; the whole-drawing option reads every dimension once.
12. **How a drafter discovers it:** DSET1 Help text and the DSET1 ribbon tooltip say "converts other dimension styles to TIM LEADER or TIM DOT LEADER and removes them".
13. **Switch (R-00):** a Settings switch "Convert other dimension styles" shipped ON; OFF gives today's DSET1 exactly (measurement factor only).

## 6. Things that could change what a drafter sees (each is named in the list, none blocks)
1. **Look:** text height, arrow size and colours come from TIM LEADER; a converted dimension may look different from the old one. That is the point of the tidy-up.
2. **Annotative dimensions (style named Annotative):** converting may drop their extra scale pictures. CE says so in the list.
3. **Individually overridden dimensions** (a number typed over the measurement, a changed scale on one dimension): the dimension's own override is kept, never reset. Recommendation; to be proved.
4. **The displayed number must not change** because of the style swap; if CE sees that it would, the dimension is listed under "check these".

## 7. Example drawings and expected results
1. **Foreign style.** Copy of a job with 3 dimensions in RS DIMSTYLE. DSET1, select all, Enter. Expected: the list names RS DIMSTYLE, 3 dimensions to TIM LEADER; Apply; the style list no longer shows RS DIMSTYLE; one Undo puts all 3 and the style back.
2. **Dot style.** A dimension style with a DOT arrowhead. Expected: becomes TIM DOT LEADER.
3. **Locked layer.** Put one of the dimensions on a locked layer. Expected: listed as left alone; its old style stays because it is still used; the line says so; no layer unlocked.
4. **Xref.** A dimension inside an attached Xref. Expected: untouched, named in the list.
5. **Escape.** At the list. Expected: nothing changed.
6. **Already tidy.** A drawing with only TIM LEADER and TIM DOT LEADER. Expected: "Nothing to convert."

## 8. Guard tests and Tim's AutoCAD checklist (proposal)
1. **Guards (no AutoCAD):** the mapping (every other name goes to TIM LEADER, dot heads to TIM DOT LEADER); a recognised style is never altered; locked-layer and Xref objects are never opened for write; switch OFF gives today's behaviour; switch default ON through both start-up reads; the list text for each case.
2. **Checklist (a robot run on a copy, then a Codex look for the list screen):** examples 1 to 6, one Undo then Redo, save and reopen, and a count of dimension styles before and after.
3. **Not provable without AutoCAD:** that the purge really removes the style, that Undo restores it in one step, and the look of converted dimensions.

## 9. Open questions for Tim (each has a recommendation)
1. **The plain STANDARD style:** AutoCAD can never remove it. Do dimensions drawn in STANDARD convert to TIM LEADER (the style itself staying in the list)? Recommendation: yes, convert the dimensions; say plainly that STANDARD itself stays.
2. **One Enter to Apply after the list, or fully automatic with the list shown afterwards?** Recommendation: one Enter after the list, because it changes drawing content and the approved ST3-12 asks for Apply.
3. **Whole drawing (type All) or only what is selected?** Recommendation: both, as above.
4. **Leaders in scope?** Recommendation: yes.
5. **UNCONFIRMED:** how CE recognises a dot-leader style (arrowhead is a dot, or the name has DOT in it). Recommendation: as in section 4.
6. **Annotative dimensions:** convert with a warning (recommended), or leave alone?
