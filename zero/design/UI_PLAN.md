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
3. Which style a later tool uses is decided on that logic: one spot, or along a line. (Sorting by the planning chat on Tim's "THINK ABOUT IT LOGICALLY"; his to correct.) Windows that are neither (job facts, pit schedule, checks, issue, Manager) keep the same frame, cards, strip and button bar; their preview shape is decided when each is designed, with Tim.

## 4. What a card is

1. **Order inside a card:** short title, then ONE biggest bold answer, then the working, then a small grey note.
2. **The working is shown as a sum:** the sign in its own column, figures on one right edge, a line above the result, a double line under it.
3. **Every card shows its answer as a picture too** (a side view, a sketch, a preview of the label).
4. **Each value says where it came from** with a small grey chip: given, measured, chosen, worked out, assumed.
5. **Only values that can be typed have a box.**
6. **Three text levels only:** title, answer, row text and notes.

## 5. Colour

1. **One accent blue** (CE deep blue #1E5AA8 on light, a lighter shade on dark): only the OK button, the selected choice, ticked boxes, and the thing being changed in the preview. Never for data.
2. **Status colours, always with a word:** green "Suits", amber "Needs a look" or "Check", red "Wrong". Nothing else is coloured.
3. **Warnings never block OK.** They sit straight under the card's answer, in one short line that says what is wrong.
4. **In "What else changes":** "Moves" and "Changes" are grey; "Check" is amber; "Wrong" is red.
5. **Theme:** the window follows AutoCAD. Dark all through or light all through; never a black panel beside white.

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

1. A full-size, working mock-up with realistic made-up content, at both screen sizes and both themes (D-065).
2. Looked at by the lead chat, and checked by a separate UI critic against the seven questions in `UI_UX_RULES.md`.
3. Tim is the only one who says it is accepted.

## 9. Not settled

1. Whether the choices, their order and their words in the Pit and Pipe windows are right in drafting terms (Tim approved the windows; the content has not been gone through line by line).
2. The ribbon tab that appears on selection (D-051) now only needs a button or two; which ones is open.
3. How the preview is produced inside AutoCAD is a Stage 4 trial.
