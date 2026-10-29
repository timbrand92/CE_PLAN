# New Pipe window: declutter design brief, VERSION 2 (29 Oct 2026)

**Status:** DESIGN COMPLETE (version 2), registered by CE 01 as B-043 (slices a to e). Not built, no code touched. Tim said "i am happy with that" on 29 Oct after trying the clickable mock-up (see section 7); the four questions in section 7 are treated as answered "recommended".
**Picture (v2):** `areas\UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29.png` (source `.html`, same folder). Example numbers (Tim's P10 to P9, 100 UPVC, 9.2 m).
**Previous version (v1, kept):** `areas\UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29_v1_tabs_and_columns.png` and `..._v1_tabs_and_columns.md` / `.html`. v1 = two columns, preview beside the label rows, three tabs with their controls open under the preview.
**Idea it answers:** UX-NEWPIPE-DECLUTTER in IDEAS_INBOX.md. **Related:** BUG-1229, BUG-1230, BUG-1233, BUG-1238, BUG-1239, B-006 (Recent levels), PC-02 and PC-03 in `decisions\2026-10-29_TIM_PLANNING_CHANGES.md`.

**Tim, 29 Oct (H18):** "its in the more section which i dont really like that much, no one will know that exists. we need to implement these features but think about ui / ux so that theres not heaps of buttons that we dont know what to do with. think how would apple design this then give me an image".
**Tim on v1, 29 Oct about 14:00:** "i like the new pipe decluttered version but it still feels too cluttered, how can we keep the preview at the bottom how it is now, then have all tools above it but merge or clean the tools properly so we still have all functionality we just dont have that much clogging things up, the language is better though".

---

## 1. Answer first, and what changed from v1

1. **Plan preview stays at the bottom, full width, exactly as it is now.** Same box, same title "PLAN PREVIEW", same hint line, same footer selector. Nothing about it moves or is restyled.
2. **Every tool sits above it, and there are far fewer on screen.** Counted from the two pictures: **51 controls visible in v1, 32 in v2** (24 if the quiet Recent buttons are not counted). All the functions are kept; the difference is how they are merged.
3. **The merges (v1 to v2):**
   1. **Six pipe-kind buttons become one "Kind" box.** Kind is set once per job, so it does not need six buttons on every open.
   2. **Kind, size and material share one line.** One quiet "Recent" line under it holds the recent sizes, materials and levels (all one click).
   3. **"Which level do you know" (four buttons) disappears.** The two level boxes say for themselves "you typed" or "worked out". Type in either box, the other end follows the fall. This is the PC-02 answer with the fewest controls. Section 4 shows the exact mapping so no function is lost.
   4. **Label rows go from six controls to a short stack:** Pipe text on plan (Above or Below), **Show grade in pipe text**, Level text at the ends, Extra text.
   5. **Three tabs with ten controls open under them become three named buttons.** Each shows its current values in one line and opens its group over the window. Nothing in the window moves when one opens.
4. **Plain wording kept** (Tim: "the language is better though").
5. **Bonus from the same change:** the real window gives the preview all the height the fields do not use (`PipeOnePageLayout.PreviewRow` is the star-height row). Fewer rows above means a taller preview than today.

---

## 2. What the window really is today (checked in the code, not seen in AutoCAD)

1. **New Pipe is `PipeEditWorkshopDialog`**, not `CdDialog`. `DialogService.Show` swaps CD's `CdDialog` for `PipeEditWorkshopDialog` whenever the "workshopLayout" switch is on, and it is on by default (`CeEditorShellFlagDefaults.WorkshopLayout = true`).
2. **`CdDialog` is only the fallback.** It appears if the window does not fit the AutoCAD work area at the current display scaling, if the user has chosen the retained creation controls, or when "Existing creation controls" is pressed. I did not review its 1267-line layout.
3. **`PipeEditWorkshopDialog.xaml` is only a parts bin.** Its own comment says the tabs are "the source of bound controls" and `PipeOnePageLayout` re-homes them. The real New Pipe is two columns, ENGINEERING and DRAFTING, with the PLAN PREVIEW underneath and a footer.
4. **Only a handful of rows were moved onto the page** (pipe kind, diameter and material, grade Standard / Set my own, "I know one end", the level boxes, pipe text on plan, extra text, flow arrow, level text above). **Everything else stays in the old tabs, which open in a separate "More options" window** from the "More…" button (`CivilMoreOptions`): "Show grade in pipe text", label layout, drawing preset, mask behind level text, drawing breaks, auto-place labels, auto-zoom, include in pit schedule, remember setup, design flow, end order, "Use last settings".
5. **Likely cause of BUG-1238 (code reading only, not seen live):** the "Recent" size and material buttons and the "Recent levels" buttons are separate rows from the boxes, so they were not moved onto the page and also sit behind More…. To be confirmed by looking at the window.

---

## 3. What the drafter decides, in order (v2)

1. **Kind of pipe** (a box, Stormwater by default): Stormwater, Suspended, Detention, Existing, Charged, Rising Main.
2. **1 Size and 2 Material:** two boxes on the same line as Kind. The "Recent" line under them offers recent sizes, materials and levels as one-click buttons.
3. **3 How steep:** Standard (the CE default for that size, shown as "Standard 1 in 100") or My own (1 in __). An optional design flow box sits on the same line; it offers a suggested grade only when a flow has been typed.
4. **4 Levels:** the two level boxes, each tagged **"you typed"** or **"worked out"** (this also answers PC-01: is a level real or only worked out). Under them one line: "Fall 0.092 m over 9.2 m = 1 in 100".
5. **5 What the label says** (right-hand column): Pipe text on plan (Above or Below), **Show grade in pipe text**, Level text at the ends, Extra text.
6. **Three named buttons** (Label style, Arrow and breaks, While placing), then the **PLAN PREVIEW**, then the footer (Inspect Drawing, Review changes, Cancel, Place pipe).

**Header:** "New Pipe", the two pit names, the measured length and flow direction (read only), a status chip, and the "Same as last pipe" button (replaces the hidden "Use last settings").

---

## 4. The merges in detail (nothing is lost)

### 4.1 Levels and "I know one end" (PC-02, BUG-1233)

The old window has the Pipe grade row, the "I know one end" button, the "end I know" pair and two "Set" ticks. v2 replaces the "end I know" choice with the boxes themselves:

1. **You type P10 only:** P10 is "you typed", P9 is "worked out" from the fall. (Old: I know one end, upstream.)
2. **You type P9 only:** P9 is "you typed", P10 is "worked out". (Old: I know one end, downstream.)
3. **You type both:** both "you typed", the fall is the result. (Old: I know one end switched off, both Set ticks on.)
4. **You type neither:** both left Unknown, never zero. (Old: both Set ticks off.)
5. **To hand an end back to CE:** click its "you typed" tag. It turns into "worked out" and the box follows the fall again.
6. **Never silently changes your grade choice (BUG-1233):** with both levels typed, if they give a different grade from the one chosen, Standard stays selected and one amber line says so, with two buttons: "Keep my levels" and "Make P9 follow Standard". This is the only amber in the window (second block of the picture).
7. **Builder note:** these four states are the same four combinations the old toggles (`AutoCalcSecondInvert`, `IsAutoCalcUpToDown`, `IsAutoCalcDownToUp`, the two Set ticks) already produce. The model keeps those properties; the new control only sets them. If the old four-way choice is wanted back, it is one row of buttons in the same place.

### 4.2 The three named buttons: every control that was under More…

1. **Label style:** drawing preset and Save as preset, label layout (Auto / Inline / Callout), level text for each end (Above / Hidden), mask behind level text.
2. **Arrow and breaks:** flow arrow on plan, adjust arrow position, reverse the flow arrow, cross-plan break, same-plan break, continuation of previous pipe, one continuous pipe, end labels follow (By flow / By pick order).
3. **While placing:** auto-place all labels, pipe text only, level text only, auto-zoom to pipe, include in pit schedule, remember this setup, Preferences, "Older window" (today "Existing creation controls", the way back until the new window is accepted).
4. **Each button always shows its current values in one line** (for example "Line + arrow · auto layout · level text above"), so the state is readable without opening it. It opens over the window; the layout never reflows.
5. **Rule check:** Tim's 24 Sep rule says no collapsed expanders. These are not expanders (they do not push the layout) and, unlike "More…", they are named and show their values. If Tim reads them as the same thing, fall back to v1's tabs, kept in the previous-version files.

### 4.3 Other places the controls went

1. **Recent size and material buttons (B-040 / BUG-1238) and Recent levels (B-006 / BUG-1226):** one "Recent" line directly under Kind, Size and Material. B-006 already puts the level buttons on the page behind `pipe.recentInvertButtonsOnMainPage`; in v2 they join this one line. One code path, not two.
2. **Design flow and its suggested grade:** small box on the "How steep" line.
3. **Charged-to, required length, twin detention pipes:** one reserved line under the Levels rows. The line is always there (empty for Stormwater), so nothing below it moves.
4. **Flow direction, pit names, measured length, "Use last settings":** header.
5. **Grade row on Charged and Rising Main:** stays in place, greyed, with a short reason, instead of disappearing as it does today (`ShowGradeToggle`). On an Existing pipe it reads "Include known grade", as today.

---

## 5. How the preview stays truthful (unchanged position, corrected content)

1. **One source.** The preview label, both level captions and the "Fall … = 1 in …" line are drawn from the same draft values as the boxes (BUG-1230).
2. **Replace, never stack.** The old caption is replaced, never left underneath.
3. **Say where each level came from.** Typed levels are gold and bold; worked-out levels are italic and dim with "worked out".
4. **Unknown stays Unknown:** a level that cannot be worked out shows a hatched "?" box, never 0.
5. **Where the label sits must match the drawing.** BUG-1239 (Tim, 29 Oct: pipe text placed about 450 units off the middle, at right angles) is a separate fault in the drawing, but it matters here: if the preview shows the text on the pipe while the drawing places it 450 off, the preview is lying. S5 must read where the drawing puts the label and show that. (Not verified in code.)
6. **Rounding:** one rule for the level working, levels shown to the decimals in Settings (BUG-1229 found two paths that disagree). Every value from Settings, nothing hard-coded (R-00).
7. **Nothing is drawn until Place pipe.** The existing hint line under the preview says so.

---

## 6. What must not change

1. **Same layout every open.** Nothing reflows as values change; reserved lines instead of rows that appear and disappear.
2. **No motion, no decoration** (cockpit test: "30 times in one day"). Quiet unless one thing needs a decision; amber only for that one thing.
3. **Plain AutoCAD words.** Keep wording Tim already knows ("Show grade in pipe text", "Inspect Drawing", "Standard"). "Set my own" shortened to "My own" only if Tim agrees.
4. **High-use window never scrolls its layout.** It must still pass the "fits the AutoCAD work area at this display scaling" check, or it falls back as today.
5. **Gold on dark, no blue, no teal.** The picture uses the real dark-theme colours (background #1C1C1C, gold #C9A84C, text #EEEAE1).
6. **Native behaviour, Cancel, Escape, Undo, Enter and the fixed bottom-right primary button stay as they are.** Nothing is added to the drawing until Place pipe.

---

## 7. Questions for Tim (batch, with my recommendation)

1. **Drop the four "which level do you know" buttons, and let the two boxes say "you typed" / "worked out"?** Recommend yes: fewest controls, same four functions. On a job: you type 19.45 at P10 and P9 follows the fall; type both and CE tells you the grade it gives.
2. **Three named buttons that open over the window (Label style, Arrow and breaks, While placing) instead of v1's open tabs?** Recommend yes; it is the biggest clutter cut, and each shows its values. If you read them as the same as More…, we go back to v1's tabs.
3. **Kind of pipe as one box instead of six buttons?** Recommend yes.
4. **"Same as last pipe" in the header, and "Older window" kept under While placing until the new window is accepted?** Recommend yes.

**Tim's answer, 29 Oct 2026 (after trying the clickable v2 mock-up, areas/UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29_v2_clickable.html):** "i am happy with that".
Interpretation (not a quote): Tim accepts the v2 design as shown, which contains my recommended answer to all four questions above (level boxes say "you typed" / "worked out", three named buttons, Kind as one box, "Same as last pipe" with "Older window" kept). GUESS: he did not read the four questions one by one. If he wants any one different, his word replaces it. This approves the design only; nothing is built, and it is not accepted until Tim or a Codex look has seen the real window in AutoCAD.

**Status:** Tim ruled "nothing waits for the pilot" (decisions\2026-10-29_TIM_ANSWERS.md items 68 and 69). Built as a DRAFT on my recommended answers; his answer replaces the default. Nothing is accepted until Tim or a Codex look has seen it in AutoCAD.

---

## 8. Not checked

1. The real window's current size and exact look in AutoCAD (code reading only); the picture's proportions are indicative and the fit check decides.
2. The older `CdDialog` layout; how `CePipePreviewControl` and `CdPlanPreviewControl` draw their captions; what `WorkshopPrimaryActionText` really says ("Place pipe" is illustrative).
3. Whether the four break toggles can be combined or are exclusive (the picture keeps them as four ticks); what the "Hidden" toggle does beyond hiding (the picture keeps Above / Hidden as the old window has it).
4. BUG-1239's cause (it is in the carpark, unverified).

---

## 9. Build handover for CE 01 (updated for v2, 29 Oct 2026)

Register: B-043a to e. Existing items touched: B-006 (BUG-1226, PR #1839), B-040 (BUG-1238), B-041 (BUG-1233, file of PR #1838). D06 (card in areas\DAILY_TOOLS_TEST_CASES_2026-10-23.md) is the placement test for slice b.

1. **One rule for every slice: same controls, same bindings, only moved.** Add one guard test: the set of binding keys on the old page plus everything in the old More… window equals the set on the new page plus the three named groups. Nothing dropped, nothing renamed in the model.
2. **One switch, ON by default:** `pipe.declutteredLayout` in the C75 pattern ("Default: on.", pinned through `DeserializeSettings` and `DeserializeSettingsTolerant`, shown on the Settings page). OFF returns today's page with More…. Both New Pipe and Edit Pipe use this layout (`IsEditMode`), so both change. The `CdDialog` fallback is untouched.
3. **Slices** (times are guesses):
   1. **a (S1), Recent line (B-040).** One "Recent" line under Kind, Size, Material: sizes, materials and, via B-006's switch, levels. After #1839 is verified. About 0.5 day.
   2. **b (S2), label column and D06 placement.** Pipe text on plan (Above / Below), Show grade in pipe text, Level text at the ends, Extra text as one stack. "Include known grade" on Existing; greyed with a reason on Charged and Rising Main. About 0.5 day.
   3. **c (S3), the level boxes say for themselves (B-041, PC-02).** Remove the "end I know" buttons; tags "you typed" / "worked out" set the same old properties (section 4.1); amber line replaces the silent switch to Set my own in `TryApplyUpstreamDownstreamSuggestion`; one result line. Same file as #1838 (`CdViewModel.Inverts.cs`), so after #1838 is in a train. About 2 days.
   4. **d (S4), Kind box, header and the three named buttons.** Kind as a box; Same as last pipe in the header; flow direction, pit names and length in the header; reserved line for Charged-to, required length and twin pipes; three named buttons with live summaries opening the old More… groups (reuse the `CivilMoreOptions` content, regrouped). Retire the More… button only after Tim accepts (hide first, per the review gate). About 2 days.
   5. **e (S5), preview content (BUG-1230, and read BUG-1239).** Position and look unchanged. Replace, never stack; Unknown as "?"; label position matches the drawing. Read `CePipePreviewControl` / `CdPlanPreviewControl` first. About 1.5 days.
4. **One session per file.** Files across the slices: `PipeOnePageLayout.cs`, `CivilMoreOptions.cs`, `PipeEditWorkshopDialog.xaml` and `.xaml.cs`, `CdViewModel.Inverts.cs`, `CdViewModel.PipeType.cs`, the preview controls, `UserSettings.cs` and the Settings page, `REGRESSION_LOG.md`.
5. **Proof for each slice.** A robot case per slice that reads the control by its binding key and asserts the drawn result (D06-style: label with and without "AT 1 IN", levels unchanged), each with a switch-OFF control run. **A Codex look at the window is needed** (RULES 5.7): New Pipe and Edit Pipe at the real size and a small laptop scale, nothing scrolls, nothing moves when the kind changes, gold on dark with no blue, Place in the fixed corner, the preview box exactly where and how it is today.
6. **Wording:** the label in the picture is "100 DIA. UPVC PIPE AT 1 IN 100" (pattern from D06); the picture's preview text and decimals are illustrative until S5 reads the real preview.
7. **Not decided, builder must not invent:** final words on each button (Tim's call after he sees the real window), what the three buttons show on Detention and Existing pipes, and the keyboard order.
