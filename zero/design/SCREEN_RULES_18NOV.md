# Screen design rules (Tim, interim, 18 Nov 2026)

**Status:** Tim's own text, pasted into the planning chat on Wed 18 Nov 2026 at about 4:35 pm (decision D-286). It is the standard for every screen, page and window in this project. It is replaced by the TimOS screen-design guide when that lands. Where it disagrees with an earlier UI ruling (for example the rose accent of D-168 or anything in `design\UI_PLAN.md`), this text wins until Tim says otherwise; the disagreement is listed, not silently fixed.

**His words, unchanged:**

SCREEN DESIGN RULES (Tim, interim 18 Nov 2026). Every screen, page and window in this project is to match these. They are replaced by the TimOS screen-design guide when it lands.

WHAT TO DO WITH THIS
1. Change nothing yet. List every screen in groups and mark each group against the rules below: meets / fails / not checked. Give the count as "N of M".
2. Show Tim one mock-up of the worst offender, fixed, with realistic made-up content. His look approves the style. After that, a separate checker's look is enough for other screens in that style.
3. Then fix by risk: anything that shows a wrong figure or pretends to work first; the rest when each screen is next touched. No rebuilds.

LOOK AND FEEL
4. Calm and clean: space, rounded cards, no clutter. One design language. Build the shared parts first (card, list, button, field, status pill, chart, pull-up panel) and build every screen from them.
5. Web and phone apps: dark and light, both designed properly, no black panel beside white. Windows inside AutoCAD: ONE colour scheme only.
6. Works on phone, folding phone, tablet and desktop. Check every screen at each.

EVERY CARD READS LIKE A MATHS TEACHER'S WORKING
7. One answer per card: one biggest, boldest number. The one thing the screen is for is the most obvious thing on it.
8. Order: short label, the answer, the working, a small grey note.
9. Working shown as a sum: + and - in their own column, figures right-aligned, a line above the result, a double line under the final answer.
10. Three text levels only. Bold the number, not the label. One or two fonts.
11. Every card shows its answer as a picture: a chart, a sum, a tally or an image. A card of words alone is a fail.
12. Squint test: blurred, each card still shows its answer and any warning, and nothing else.

COLOUR
13. Colour means something or it is not used, and always comes with a word.
14. Status only: green = good, amber = needs me, red = late, over or wrong.
15. Brand colour sets the base, not the whole scheme. Use it for main buttons and the selected item. Never for data.
16. Inside AutoCAD the button accent must be unlike any colour the drawing itself shows.
17. Charts: up to 5 series colours in a fixed order, used everywhere. Dark: #5AA2F0 #3CC4B2 #A08AF0 #E57AAE #A3AAB6. Light: #2F6FC4 #13877A #6E4FCC #B8467F #5F6672. More than 5: top 4 plus "Other". Labels on the bars and lines, not in a legend.

FEWER TAPS, LESS SCROLLING, LESS TYPING
18. Every common task has a tap budget, a scroll budget and a count of typed fields. Write them down and test them. Over budget is not finished. In AutoCAD: commands, clicks and picks, and one undo per command.
19. On a phone, the answer and anything urgent show on the first screen without scrolling. Detail is one tap away in a pull-up panel, not further down.
20. Every field has a source, in this order: worked out, captured automatically, read by AI from an email, PDF, photo or voice, pre-filled, typed only as a last resort. Type once.
21. Undo instead of "Are you sure?".
22. The home screen starts from "what needs me", ranked by urgency, each item with an owner and the reason it is red or amber.

HONEST SCREENS
23. Nothing pretends to work. No button looks like it saves when it does not.
24. A missing value shows "Not known" or "TBC". Never 0, never a guess. Unfinished is normal: warn, do not block.
25. A preview shows the real thing as it will look, where it sits in the whole, and updates as he types. Made-up scenery is labelled as made up.
26. Software suggests; the person decides. Never overwrite a value he typed or locked: show both.

FINISH AND WORDS
27. Spacing on a fixed scale: 8, 16, 24, 32. Related things sit closer than separate groups. One set of corner rounding, thin quiet borders, soft shadows, icons one size.
28. Motion comes from where he tapped, nothing over 0.4 seconds, eases out, never bounces, respects "Reduce motion". Grey loading shapes, never spinners.
29. Every word on screen is one a tradie or a regular person understands. Errors say what happened and what to do. Formal terms only in brackets after the plain word. No build wording on any screen.
30. Realistic made-up content in every mock-up and screenshot ("Smith Plumbing · $4,180 · rough-in"). Never "John Doe" or "Lorem ipsum".

BEFORE TIM SEES ANY SCREEN
31. A separate checker, never the chat that built it, screenshots it at every size (and light and dark on web) and answers: Is the one thing it is for the most obvious thing? Is every gap on the scale? Does hierarchy come from weight and colour? Is colour only where it means something, with a word? Is the content realistic? Do corners, borders and icons match? Are the budgets met? Does anything pretend to work?

Reply to Tim: answer first, plain words, FOR TIM above a line, ending Completed / Not completed / Next.
