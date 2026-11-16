# Tim's UI / UX rules (pasted 16 Nov 2026)

**Given by Tim in the chat "CE_ACAD / zero plan / 01" on Mon 16 Nov 2026, with the words "WITH UI / UX A LOT OF OUR STAFF HAVE BUILT MUSCLE MEMORY TO HOW THINGS LOOK AND FEEL NOW SO MAKE SURE IT ALIGNS WITH THAT VISION AND THAT UNDERSTANDING". His text is below the line, unchanged. This is a fuller version than the one saved on 15 Nov 2026 in `C:\CE_PLAN\04_REFERENCE\TIM_UI_UX_RULES_15NOV.md` (it adds motion, named parts and the UI critic); this one is the newer and governs the zero plan.**

**The planning chat's reading (mine, not Tim's words; his to correct):**

1. These rules apply to every plugin window and every page made for Tim.
2. Parts that cannot apply inside AutoCAD are named here rather than skipped silently: phone, folding phone and tablet sizes (AutoCAD is a desktop program; the pages made for Tim to read are still checked narrow and wide); the web building blocks named under PARTS (Vaul, Sonner, NumberFlow, Radix, Base UI) are for web pages, and AutoCAD windows need their own equivalents, to be named in Stage 4.
3. "Dark and light both designed properly" applies in full: AutoCAD has both themes.
4. Muscle memory rule (from Tim's covering words): what staff already know stays where they know it: typed names, symbols, layers, colours, wording, where grips are and how standard AutoCAD commands behave. New windows are calm and consistent, but the drawing and the hands-on feel stay familiar.
5. "Never say it's done until you've looked at the real screen yourself" and the UI critic apply to pages made in this planning chat too. Two pages were sent on 16 Nov before being looked at; from the third page on, every page is photographed and critiqued before it is sent.

---

How I want every screen designed (UI/UX rules — follow them exactly)

WHO I AM
- Visual thinker: I read screens like a maths teacher — numbers, sums,
  charts, diagrams, lined up vertically and horizontally.
- No coding knowledge. Show me, don't describe. Before building any
  screen, show me a mock-up with realistic made-up content and wait for
  my OK.

LOOK AND FEEL
- Apple-like: clean, calm, space, rounded cards, no clutter.
- One design language for every screen: build shared parts first (card,
  list, button, field, status pill, chart, pull-up panel) and build
  everything from them.
- One brand accent colour, only for main buttons and the selected item.
  Never for data.
- Dark and light both designed properly. No black panels beside white.
  Greys slightly tinted towards the brand colour.
- Works on phone, folding phone (folded and unfolded), tablet and
  desktop. Check every screen at all of them.

CARDS READ LIKE A MATHS TEACHER'S WORKING
1. One answer per card: one biggest, boldest number. The one thing the
   screen is for is the most obvious thing on it.
2. Order: short label → answer → working → small grey note.
3. Working shown as a sum: + and − in their own column, figures
   right-aligned, a line above the result, a double line under the
   final answer.
4. Three text levels only. Hierarchy from weight and colour, not just
   size. One or two fonts.
5. Bold the number, not the label. At most one bold item per line.
6. Every card shows its answer visually — chart, sum, tally or image.
   Cards of words alone don't work for me.
7. Squint test: blurred, each card still shows its answer and any
   warning, and nothing else.

COLOUR
- Colour means something or it isn't used. Always with a word, never
  colour alone.
- Green = good, amber = needs me, red = late / over / wrong. Status only.
- Charts: up to 5 series colours in a fixed order used everywhere,
  separate dark and light shades, contrast-checked:
  dark  #5AA2F0 #3CC4B2 #A08AF0 #E57AAE #A3AAB6
  light #2F6FC4 #13877A #6E4FCC #B8467F #5F6672
  More than 5 → top 4 plus "Other". Labels on the bars and lines, not
  in a legend.

FEWER TAPS, LESS SCROLLING, LESS TYPING
- Every common task has a tap budget, a scroll budget and a typed-fields
  count. Write them down and test them. Over budget = not finished.
- On a phone, the answer and anything urgent show on the first screen
  without scrolling.
- Detail one tap away (a summary line that opens a pull-up panel), not
  further down the page.
- Long lists: a summary and the few that need me on top; the rest behind
  filters. Bigger screens: cards side by side.
- Every field has a source, in this order: worked out → captured
  automatically → read by AI from email / PDF / photo / voice →
  pre-filled → typed only as a last resort.
- Undo instead of "Are you sure?". Actions on the card.
- Start from a "what needs me" home screen, ranked by urgency, each item
  with an owner and the reason it's red or amber.
- Icons on small buttons where words don't fit.

FINISH AND FEEL
- Spacing on a fixed scale (8, 16, 24, 32). Related things closer
  together than separate groups.
- One corner-rounding set (inner pieces slightly less rounded than their
  card), thin quiet borders, soft light shadows, icons one size and line
  weight, lined up with their text.
- Realistic made-up content on every screen and screenshot ("Smith
  Plumbing · $4,180 · rough-in"), never "John Doe" or "Lorem ipsum".

MOTION (nothing over 0.4 s; opens slightly slower than it closes; ease
out, never bouncy; respect "Reduce motion"; motion always shows where
something came from or went)
- Menus grow from the button I tapped (open 200 ms, close 140 ms).
- Pull-up panels follow my finger and settle (in 320 ms, out 220 ms).
- Undo messages slide in from the edge, up to 3 stack, gone after 4 s.
- Numbers roll to new values (300 ms). Done items tick, slide away, the
  list closes up (260 ms).
- A tapped card zooms into its page; Back shrinks it back (300 ms).
- Drag to hand over follows my finger.
- Charts grow from the baseline once, on first view (400 ms).
- Grey loading shapes, never spinners.

WORDS
- Every word understandable by a tradie or a regular person. Short
  sentences, everyday words, no IT words.
- Errors say what happened and what to do.
- Formal or accounting terms only in brackets after the plain word.
- Short labels, not questions, as titles.

PARTS
- Proven, accessible building blocks over home-made ones: e.g. Vaul
  (pull-up panels), Sonner (Undo messages), NumberFlow (rolling numbers),
  one of Radix or Base UI (menus, pop-ups). Never flashy libraries
  (glows, gradients, moving backgrounds). Name every new part you add.

BEFORE DESIGNING
- Look at how 3–4 well-made apps solve the same kind of screen. Tell me
  what you'd borrow and what you'd avoid. Never copy.

BEFORE YOU SHOW ME ANY SCREEN — UI CRITIC
A separate check (not the one that built it) screenshots it at phone,
folding, tablet and desktop sizes, light and dark, and answers these,
fixing what fails first:
1. One thing this screen is for — is it the most obvious thing on it?
2. Every gap on the spacing scale, related things grouped?
3. Hierarchy from weight and colour, not just size?
4. Colour only where it means something, always with a word?
5. All content realistic?
6. Corners, borders, shadows and icons match everywhere?
7. Every animation comes from where I acted?
Plus: tap, scroll and typing budgets met; plain words; chart colours.

HOW TO WORK WITH ME
- Answer first, then detail only if it changes what I do.
- Ask with clickable choices, one recommended, each with a real-world
  example.
- Tell me exactly what to click to test it, and what "right" looks like.
- Never say it's done until you've looked at the real screen yourself.
  I'm the only one who says it's accepted.
