# The UI plan: how every window looks and behaves

**Status:** the Pit and Pipe windows are approved by Tim (D-068, D-069, D-070: "approve those new pit and pipe windows, all other windows should match"). This page writes down what those two windows do, so every other window is built the same way. The two mock-ups are the reference: `pictures\pit_window_full_size.html` and `pictures\pipe_window_full_size.html`. Where this page and a mock-up disagree, ask Tim. His standing rules are in `UI_UX_RULES.md` and always apply.

## 1. How a tool is driven (D-055 to D-061)

1. **Placing** always starts with a short typed command (or its ribbon button, which shows the short name in its tip).
2. **The window opens every time**, already filled in with what was used last.
3. **Editing** a drawn thing: AutoCAD's Properties, or double-click to get the same window back.
4. **Only placing has a typed name.** Changing has none.

## 2. The window frame (the same for every command)

1. **Size:** about 80% of the screen. Must work at 1920 x 1080 and 2560 x 1440, with no scrolling inside the window at either (D-065). The larger screen gets a bigger preview and more air, not just bigger text.
2. **Title bar:** what it is and which one ("Pit · P3", "Pipe · P4 to P3").
3. **Preview:** the exact thing in the real drawing, changing live as it is changed, with everything around it that is affected (D-064).
4. **Numbered cards** in the order the decisions are made, first to last.
5. **"What else changes" strip**, full width, directly above the buttons.
6. **Button bar**, always in the same place: Inspect and Match on the left; Cancel and OK on the right.
7. **Inspect** is on every window: it hides the window so the drawing can be seen and brings it back with everything typed still there (D-065).

## 3. The two styles (D-066, D-067)

1. **Style 1, square preview:** a thing at one spot. Preview on the left, cards beside it. Pit, downpipe, overflow, FO, IO, GIO, floor waste, tank.
2. **Style 2, wide preview:** a thing that runs along a line. Preview as a band across the top, cards in a row beneath. Pipe of every kind, AG drain, trench grate, spoon drain, strip drain.
3. **The preview's shape follows the shape of the thing shown (D-113).** A tall subject, such as the pit schedule, uses the left-hand full-height preview with the choices on the right, so a 16-row schedule is readable.
4. Which style a later tool uses is decided on that logic: one spot, or along a line. (Sorting by the planning chat on Tim's "THINK ABOUT IT LOGICALLY"; his to correct.) Windows that are neither (job facts, pit schedule, checks, issue, Manager) keep the same frame, cards, strip and button bar; their preview shape is decided when each is designed, with Tim.

## 4. What a card is

1. **Order inside a card:** short title, then ONE biggest bold answer, then the working, then a small grey note.
2. **The working is shown as a sum:** the sign in its own column, figures on one right edge, a line above the result, a double line under it.
3. **Every card shows its answer as a picture too** (a side view, a sketch, a preview of the label).
4. **Each value says where it came from** with a small grey chip: given, measured, chosen, worked out, assumed, standard, typed over (D-150: "typed over" is a standard that has been typed over, shown with the standard's figure beside it).
5. **Only values that can be typed have a box.**
6. **Three text levels only:** title, answer, row text and notes.

## 5. Colour

1. **One accent blue** (CE deep blue #1E5AA8 on light, a lighter shade on dark): only the OK button, the selected choice, ticked boxes, and the thing being changed in the preview. Never for data. (SUPERSEDED 18 Nov 2026 by D-166 and D-168: one scheme on AutoCAD grey, rose accent; see the end of this file)
2. **Status colours, always with a word:** green "Suits", amber "Needs a look" or "Check", red "Wrong". Nothing else is coloured.
3. **Warnings never block OK.** They sit straight under the card's answer, in one short line that says what is wrong.
4. **In "What else changes":** "Moves" and "Changes" are grey; "Check" is amber; "Wrong" is red.
5. **Theme:** the window follows AutoCAD. Dark all through or light all through; never a black panel beside white. (SUPERSEDED 18 Nov 2026 by D-166 and D-168: one scheme on AutoCAD grey, rose accent; see the end of this file)

## 6. Finish

1. Spacing only 8, 16, 24, 32. Field rows 40, sum rows 32.
2. One corner set: cards 12, inner controls 8. Thin quiet borders, soft shadows.
3. One shared set of parts used by every window: card, drop-down, number box, tick box, status pill, button.
4. Motion small and under 0.4 seconds: numbers roll to the new value, the previewed thing eases to its new size, Inspect hides and returns. (Not yet tested by anyone.)

## 7. Words

1. Easy, but logical to an engineer who uses AutoCAD (D-064). Drafting words, never IT words.
2. The same word for the same thing in every window.
3. A warning says what happened and what the figure is ("Wrong: arrives at 5.10, outlet is 5.13.").

## 8. Before any window is shown to Tim

1. A full-size, working mock-up with realistic made-up content, at both screen sizes and both themes (D-065). (Both themes SUPERSEDED 18 Nov 2026 by D-166: one scheme only.)
2. Looked at by the lead chat, and checked by a separate UI critic against the seven questions in `UI_UX_RULES.md`.
3. Tim is the only one who says it is accepted.

## 9. Not settled

1. Whether the choices, their order and their words in the Pit and Pipe windows are right in drafting terms (Tim approved the windows; the content has not been gone through line by line).
2. The ribbon tab that appears on selection (D-051) now only needs a button or two; which ones is open.
3. How the preview is produced inside AutoCAD is a Stage 4 trial.

## Added 18 Nov 2026 (Tim's rulings D-162 to D-167, after using the bench windows)

1. **One colour scheme only** (D-166). No light and dark versions; this replaces "dark or light all through". The window background is a grey like AutoCAD's own. The brand shows in the type (wide squared capitals) and the CE mark.
2. **Colour draws the eye, by normal UI convention** (D-164): the next action (OK), the box in use, the thing being changed, what just changed, the one answer per card, selected choice, held against worked out. Status keeps its own three colours with the word and they are used for nothing else.
3. **The button and highlight colour is unlike any colour in the drawing on screen** (D-166): chosen from a gap away from every office layer colour and the status colours. Which colour: picked, rose #FF70B3 (D-168); see the section "The colour scheme, picked 18 Nov 2026" below.
4. **The preview, in every window** (D-162, D-167): (a) the drawing as AutoCAD shows it, real layers, colours, linetypes, text and arrow, changing as you type; (b) "where on the plan": a small site locator in a corner; (c) "where in the system": a strip under the preview showing the run as a chain with this object lit; (d) the thing being changed highlighted the same way in all three. Nothing made up is shown as if it were the drawing: on the bench, stand-in scenery is labelled as stand-in.
5. **The Levels tool is to be renamed** (D-162): long section or pipe section; the word and short name are picked: LONGSECTION / LG (D-196).

## The colour scheme, picked 18 Nov 2026 (D-168: "B, ROSE", from `pictures\pick_a_ce_scheme_2.html`)

One scheme, everywhere. Values as drawn on the sheet Tim picked from:
1. **Window:** #3B4453 (AutoCAD 2027's own panel grey, read from its dark theme file).
2. **Cards:** #454F61 (AutoCAD's menu and preview grey).
3. **Input wells and hairlines:** #2E3440.
4. **Text:** #F5F5F5 main, #D9D9D9 second, #C7CFDB notes.
5. **Accent, rose:** #FF70B3, with dark text #10131A on it. Used for: OK (solid), the box in use, the thing being changed (plan, locator, chain), selected choice, ticked boxes, held padlock, the "changed" chip, the underline of the one answer per card. Nothing else.
6. **Keyboard focus:** a white ring (never AutoCAD's blue).
7. **Status, with the word, used for nothing else:** Suits #3EDC9B, Needs a look #FBBF24, Wrong #FF7A7A.
8. **Inside the preview:** the drawing's own colours on AutoCAD's model background (assumed #212830; the office's own background is not known).
9. **Buttons:** OK solid rose; Cancel, Inspect and Match outlined and quiet; states normal, hover, pressed, keyboard focus, disabled as on the sheet.
10. Why rose: it was measured against all 36 colours the office layers use on screen and the status colours; its nearest neighbours are the red tones (28 degrees of hue away). Watch in use: rose beside red "Wrong" and red invert text.
