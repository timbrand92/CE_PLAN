# The approved window style (Tim, 18 Nov 2026, D-295 and D-296)

**Status: APPROVED by Tim's look**, his screen rule 2: "His look approves the style. After that, a separate checker's look is enough for other screens in that style." Asked "Is this the style for every window?" of version 4 of the Detention mock-up, he answered: "Yes, this is the style". Asked where the preview sits: "Left side, as shown (Recommended)".

**The reference:** `pictures\detention_fixed_mockup.html` (version 4) and its three photographs `pictures\detention_fixed_suits.png`, `detention_fixed_short.png`, `detention_fixed_notknown.png`. When this page and the mock-up disagree, the mock-up wins. His 31 rules are in `design\SCREEN_RULES_18NOV.md`. This page replaces the look parts of `design\UI_PLAN.md` and the colour values of D-168 (the rose accent stands).

**How it is applied (his rule 3):** no rebuilds. Anything that shows a wrong figure or pretends to work is fixed first. Every other window is brought to this style when it is next touched. Each restyled window is looked at by a separate checker (never the chat that built it) before Tim sees it.

## 1. What every window is made of, in this order

1. **Title bar:** the tool and "this job" or the thing's name. Close at right.
2. **The drawing (preview), LEFT side, full height, about a quarter of the window.** A near-black model-space panel showing the real thing as AutoCAD shows it: office layers, colours, capital text, to the job's real dimensions. The parts this window is about are outlined in white. Under it, one line "where in the system" as a chain with this window's place lit, and one grey line saying what is lit. A small heading "The drawing" with a one-line grey why. Made-up scenery is labelled as made up; no build wording.
3. **The answer band, top of the right side, full width.** ONE answer in plain words with its figure, on a solid status fill with dark text: green "Suits", orange-red "Short" or "Wrong", amber "Needs a look". The second answer (if the window has one) sits at the right of the band, smaller, with its own word. This is the biggest and brightest thing on the window.
4. **Step 1, "What you type":** why-line "The few figures only you can give. Everything else is worked out." Holds EVERY input and nothing else: boxed fields, tick choices, method buttons. Its heading shows "Nothing needs you" or "N figures need you".
5. **Step 2, "What the drawing gives":** why-line "Read off what you drew. Change the drawing, not this window." Plain text only, no boxes, each figure with its source word (measured, worked out), shown as sums.
6. **Step 3, "The answers":** why-line in the form of the question the window answers. Each answer: its figure at answer size, a picture (bar or sketch), the working as a sum, one grey note.
7. **Bottom bar:** a quiet left button for the printed working where the window has one; Cancel and OK at right. OK is the only accent-filled button.

A small tool (Pit, Inlet) keeps the same order with fewer rows. A window with nothing to work out still has the drawing at left, the band, and step 1.

## 2. Inputs against worked-out figures (the rule Tim asked for)

1. **An input is a box:** lighter fill than its card, a light border, a bright figure, its unit inside in lighter grey. All inputs are together in step 1.
2. **A worked-out or read-off figure is plain text with no box.** It never looks like something to fill in.
3. **An input that still needs the drafter** (empty or assumed) has a 2 px amber border and a small solid amber "Needs you" tag; the band names it.
4. **An input the drafter changed** carries a grey outlined "Changed" tag, and the band says what it was.
5. **A figure shown in two places** says so in a grey note ("Same figures as on tank WT1; change either place").
6. **A missing value reads exactly "Not known"** on a window and "TBC" on the sheet. Never 0, never "unknown".

## 3. Colour

1. **One scheme, dark:** window #2B2D30, cards #383B40, wells #232528, input boxes #4A4D55, borders #4A4D53 (input border #8A8E96), preview ground #16181B. Neutral greys, no blue cast. No light version.
2. **Text:** answers near-white, body light grey, notes #A9AEB6; units inside boxes #C8CBD0; preview text #C8CBD0 or brighter. Nothing under 4.5 to 1.
3. **Status only, always with its word, as a solid fill with dark text #10131A:** green Suits; amber Needs a look and Needs you; orange-red #FF6B4A Short and Wrong (kept clear of the rose). "Changed" is a grey outline, never amber.
4. **Accent rose #FF70B3 with dark text:** OK and the one selected choice button. Nowhere else. Ticks, padlocks and icons are grey-white, one size.
5. **Chart colours** only where three or more parts must be told apart, in the fixed order of rule 17, labels on the bar, no legend.

## 4. Type and spacing

1. **One font family** for words and figures (IBM Plex Sans on the mock-up; the shipped font inside AutoCAD is the build's to prove, with Segoe UI as the fallback). Figures use tabular numerals; no slashed zero, no typewriter font.
2. **Three sizes only:** 24 answer, 14 body, 12 note. Preview text is drawing text, 12 minimum.
3. **Bold only on:** the band's figures, each answer figure, each double-lined final figure. Never on labels.
4. **Sums:** signs in their own narrow column, figures right-aligned, a single line above a result, a double line under the final answer; rows 32 apart. A sum must add up exactly as printed; when the result is a shortfall the rows swap so the sign is right.
5. **Gaps 8, 16, 24, 32.** One 8 px corner for cards, fields, tags and buttons (4 px on a 16 px tick box). Thin quiet borders, soft shadow.
6. **Plain words first, the formal word in brackets:** "Hole size (orifice)", "Water height above the hole (head)", "Council pit (LPD)".

## 5. Not settled by this approval

0. **THE PREVIEW PANEL IS OPEN (D-297).** A moment after approving, Tim: "IM NOT CONVINCED THAT WINDOW WILL SHOW THE PREVIEW WELL ENOUGH". Its place at the left stands (D-296) unless he changes it; its size and how it shows a real job are not approved. Section 1 item 2's "about a quarter of the window" is NOT a ruling. Options are being drawn for him.

1. Click budgets, undo and motion (rules 18, 21, 28): to be written and tested per tool.
2. How the window looks at 1080 and 1440 and over real model space: the mock-up was checked at one size (1536 by 864).
3. The plain names of the two detention methods ("Office method (Boyd's)", "Council tool (OSD4W)") are the planning chat's and not yet confirmed by Tim.
4. Small faults the builder listed on the mock-up itself (the spare label close to the needed marker; empty space at the right of step 2; two close labels in the drawing; 4 px chips in the chain) are to be fixed when the real window is built, not copied.
