# New Pipe window: declutter design brief (29 Oct 2026)

**Status:** DESIGN PROPOSAL. Not built, not decided, no code touched. Written for Tim to judge from the picture, then for the review gate in AGENTS.md (a card, Tim's approval, then code).
**Picture:** `areas\UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29.png` (source page `UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29.html`, same folder). Numbers in it are examples (Tim's P10 to P9, 100 UPVC, 9.2 m).
**Idea it answers:** UX-NEWPIPE-DECLUTTER in IDEAS_INBOX.md. **Related:** BUG-1229, BUG-1230 (on hold), BUG-1233, BUG-1238, PC-02 and PC-03 in `decisions\2026-10-29_TIM_PLANNING_CHANGES.md`.

**Tim, 29 Oct 2026 (H18):** "its in the more section which i dont really like that much, no one will know that exists. we need to implement these features but think about ui / ux so that theres not heaps of buttons that we dont know what to do with. think how would apple design this then give me an image".

---

## 1. Answer first

1. **Keep every feature. Remove the "More…" button.** What is under it today is regrouped under three tabs that are always on screen, each named for what is inside and each showing its current values in one line.
2. **The window asks five things, in the order a drafter thinks:** what size, what material, how steep, which level you know, what the label says. Each is one row with one plain control.
3. **"Show grade in pipe text" moves out of hiding** and sits in the label rows on the right, always visible.
4. **The two grade controls become one question** (PC-02): "Which level do you know: Upstream, Downstream, Both ends, Not set yet", right under "How steep".
5. **The preview sits directly under the label choices** and is drawn from the same numbers as the boxes.

---

## 2. What the window really is today (checked in the code, not seen in AutoCAD)

1. **New Pipe is `PipeEditWorkshopDialog`**, not `CdDialog`. `DialogService.Show` swaps CD's `CdDialog` for `PipeEditWorkshopDialog` whenever the "workshopLayout" switch is on, and it is on by default (`CeEditorShellFlagDefaults.WorkshopLayout = true`).
2. **`CdDialog` is only the fallback.** It appears if the window does not fit the AutoCAD work area at the current display scaling, if the user has chosen the retained creation controls, or when "Existing creation controls" is pressed. It is a long tabbed form (1267 lines of layout); I did not review it for this brief.
3. **`PipeEditWorkshopDialog.xaml` is only a parts bin.** Its own comment says the tabs are "the source of bound controls" and `PipeOnePageLayout` re-homes them. The real New Pipe is two columns, ENGINEERING and DRAFTING, with a PLAN PREVIEW underneath and a footer.
4. **Only a handful of rows were moved onto the page** (pipe kind, diameter and material, grade Standard / Set my own, "I know one end", the level boxes, pipe text on plan, extra text, flow arrow, level text above). **Everything else stays in the old tabs, which now open in a separate "More options" window** from the "More…" button (`CivilMoreOptions`). That includes "Show grade in pipe text", label layout, drawing preset, mask behind level text, drawing breaks, auto-place labels, auto-zoom, include in pit schedule, remember setup, design flow, end order and "Use last settings".
5. **Likely cause of BUG-1238 (code reading only, not seen live):** the "Recent:" size and material buttons and the "Recent levels" buttons are separate rows from the boxes, so they were not moved onto the page and also sit behind More…. That would match Tim answering "no" to "does the window offer your recent sizes, materials and inverts". To be confirmed by looking at the window.

---

## 3. What the drafter decides, in order

1. **What kind of pipe.** Stormwater, Suspended, Detention, Existing, Charged, Rising main. One row, one choice. It is first because it changes what the rest offers.
2. **What size** (diameter, mm). One box, recent sizes as one-click buttons directly under it.
3. **What material.** One box, recent materials as one-click buttons directly under it.
4. **How steep.** Two choices only: Standard (the CE default for that size, shown as "Standard 1 in 100") or My own (1 in __). The optional design flow and its suggested grade is one quiet line below. It shows a suggestion only when a flow has been typed.
5. **Which level do you know.** Four choices: Upstream, Downstream, Both ends, Not set yet. The other end is worked out from the fall, or both are typed, or neither is set (left Unknown, never zero). Below it: the two levels, each tagged **"you typed this"** or **"worked out from the fall"** (this also answers the question in PC-01 about whether a level is real), the recent levels, and one result line: "Fall 0.092 m over 9.2 m = 1 in 100".
6. **What the label says.** Pipe text on plan (Above / Below), **Show grade in pipe text**, level text at the ends, extra text. Then the preview.

---

## 4. Always visible, and the three named groups

**Always visible (the six things above):** kind, size, material, how steep, which level, the label rows, plus the preview, header and footer.

**Three tabs along the bottom, always on screen, each with a one-line summary of its current values** (so a drafter can see "levels above, auto layout" without opening anything). No collapsed expanders (Tim's rule), no "More…", no second window.

1. **Label style:** drawing preset and Save as preset, label layout (Auto / Inline / Callout), level text Above / Hidden for each end, mask behind level text.
2. **Arrow and breaks:** flow arrow on plan, adjust arrow position, reverse the flow arrow, cross-plan break, same-plan break, continuation of previous pipe, one continuous pipe, end order (By flow / By pick order).
3. **While placing:** auto-place labels (all, pipe text only, level text only), auto-zoom, include in pit schedule, remember this setup, Preferences, and "Existing creation controls" (the way back to the older window, kept until the new one is accepted).

**Not in a group:** "Same as last pipe" is a button in the header (it replaces "Use last settings", which was hidden). Inspect Drawing and Review changes stay in the footer. Flow direction (read only), pit names and the measured length move into the header line.

**Kinds that need extra fields** (Charged-to, required length, twin detention pipes) appear in one reserved line under the kind row. The line is always there, so nothing below it moves. Rows that do not apply to a kind (grade in pipe text on Charged and Rising Main today) are shown greyed with a short reason, not removed.

---

## 5. How the preview stays truthful

1. **One source.** The preview label, both level captions and the "Fall … = 1 in …" line are drawn from the same draft values as the boxes. They cannot disagree (BUG-1230).
2. **Replace, never stack.** When something changes, the old caption is replaced. No old gold caption left underneath a new one.
3. **Say where each level came from.** Typed levels are solid gold. Worked-out levels are italic and dim with "worked out".
4. **Unknown stays Unknown.** A level that cannot be worked out shows a hatched "?" box, never 0 and never a guess.
5. **Never switch a choice silently** (BUG-1233). When two typed levels give a different grade from Standard, Standard stays selected and one amber line says so in plain words, with two buttons: "Keep my levels" and "Make P9 follow Standard" (second picture in the mock-up). This is the only place the window uses amber.
6. **Rounding:** the window must use one rule for the level working, and show levels to the decimals set on the Settings page (BUG-1229 found two paths that disagree). Every number in this working comes from Settings, nothing hard-coded (R-00).
7. **Nothing is drawn until Place pipe.** One grey line says so under the preview.

---

## 6. What must not change

1. **Same layout every open.** Nothing reflows as values change. Reserved lines instead of appearing and disappearing rows.
2. **No motion, no decoration.** No animation, gradients, cards or decorative icons (UI cockpit test: "30 times in one day").
3. **Quiet unless one thing needs a decision.** Grey when healthy. Colour only where attention is needed: gold for what you typed and the selected choice, amber for the one decision, nothing else shouting. Emphasis rule still applies.
4. **Plain AutoCAD words.** No software jargon. Keep today's wording where Tim already knows it ("Show grade in pipe text", "Inspect Drawing", "Standard", "Set my own" becomes "My own" only if Tim agrees).
5. **High-use window never scrolls its layout.** Groups are tabs, not a scrolling form. It must still pass the existing "fits the AutoCAD work area at this display scaling" check, or it falls back as today.
6. **Gold on dark, no blue, no teal.** The mock-up uses the real dark theme colours (background #1C1C1C, gold #C9A84C, text #EEEAE1).
7. **Native behaviour, Cancel, Escape, Undo, Enter and the fixed bottom-right primary button all stay as they are.** Nothing is added to the drawing until Place pipe.

---

## 7. Questions for Tim (batch, with my recommendation)

1. **Merge "Pipe grade" and "I know one end" into the one question "Which level do you know"?** Recommend yes: it is your PC-02 point (two places to decide the same thing). On a job: you pick Upstream, type 19.45, and the other end follows the fall; you pick Both ends and type both.
2. **Are the three group names right** (Label style, Arrow and breaks, While placing)? Recommend yes; change any word you like.
3. **"Same as last pipe" in the header instead of "Use last settings" in a hidden tab?** Recommend yes.
4. **Keep "Existing creation controls" (the older window) under While placing until the new window is accepted, then retire it?** Recommend yes; hide and redirect before removing.

Until Tim answers, nothing here is a decision.

---

## 8. Where this sits and what is not done

1. **Process:** this feeds the whole-functionality review card (PC-02 + PC-03, with BUG-1229, BUG-1230, BUG-1233, BUG-1238 attached). Per the command and workflow review gate, the card needs Tim's approval before code. Robot, Codex and build jobs are off while Tim hand-tests.
2. **Not checked:** the real window's current size and exact look in AutoCAD (this is read from the code only); whether the mock-up's width fits the work area (proportions are indicative; the fit check decides); the older `CdDialog` layout; how the plan preview control draws its captions (BUG-1230 was read from Tim's screenshot only); what text the "Place pipe" button really carries (`WorkshopPrimaryActionText`).
3. **For the card, later:** the exact label wording of each choice, what each tab shows on a Detention or Existing pipe, the keyboard order (Tab through the five decisions in order), and Tim's AutoCAD checklist. Test steps must say what "right" looks like (RULES 13.4).
4. **Who owns it:** design only. A build chat takes it after Tim approves the card.
