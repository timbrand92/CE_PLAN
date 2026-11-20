# Answer: the design page `design\SHAPED_GRIPS.md` at 93eb70c (branch design/shaped-grips)

**Answer: FIX THE PAGE FIRST. Five reasons, each a short edit to the page; none needs AutoCAD.** Written Fri 20 Nov 2026, about 5:55 pm, by the check room. A check of a page by reading; nothing was run. One reader: Team helper, Claude Opus 5.5, read-only tools: `C:\CE_WORK\check\reports\shaped-grips_read_REPORT.md`.

## 1. What is sound

The cause of the old crash is named and closed; the SHAPE is one small piece that can be swapped for a plain square without touching what a grip does; a fall-back is put to Tim with pictures; the night proof stops at a "Fatal Error" box with nothing closed; nothing on the page needs a mouse or key robot, a profile, a saved AutoCAD setting or the registry; the test-only command lives in a separate file that is never in the plug-in's folder, with a build check that the plug-in names no such command and a second lock to the test folder; the page admits the test route's Undo group is not AutoCAD's own. No grip is added that no ruling gives.

## 2. Reasons to fix the page

1. **The pit's size grips: Tim ruled four at the wall midpoints; the page delivers two arrows at corners.** D-402 item 6: "centre, four wall midpoints stepping the size". The page says "Four wall midpoints. Shape: the office block's own size arrows", but the page's own evidence (research note R-011) found on PIT BLOCK 3 two stretch arrows at opposite corners, a look-up triangle and the insertion square. Either say plainly that the pit gets two corner arrows and put that change to Tim, or add four grips of the tool's own at the wall middles. Say also what the block's look-up triangle does when clicked.
2. **The pit number's "Next spot" steps through the COVER LEVEL's corners.** The number's spots are 900 mm above the pit centre, then below, then right, then left (D-366, D-400); the four corners are the cover level's (D-402 item 1). Give each its own list, its own hover words and its own bench test.
3. **The typed test route can reach a part a real drag cannot.** It takes a part by its handle and calls the grip code on it; a real drag starts only from a grip AutoCAD shows, and it shows none on a locked layer and cannot pick a part on an off or frozen layer. The page lists no lock, off, frozen, xref or reference-edit check for the test command. An earlier night probe that touched a part on a locked layer raised AutoCAD's own error box (which stops a night: D-364), and a hidden part could be changed and reported PASS. The test command must ask the same guard, and whether the layer is off or frozen, BEFORE any grip code, and refuse in words; add a night step for a locked, an off and a frozen part.
4. **The page leans on "the existing edit doorway", which is not built** (it is a design on branch codex/doorway), and does not say how a drag grip's own write enters it. D-348, and Tim's rule of one fact in one place: every change goes through one gate. Say that a grip of the tool's is treated exactly like AutoCAD's own grip edit (it moves only the text AutoCAD hands it; the doorway checks and follows up at the end of the command, with the same put-back if it refuses); that the doorway's source check names that one allowed write; and that the grip build starts after the doorway is merged, or which interim follow-up it rides on and that this has no lock check.
5. **A half-promise of an "arrow flip".** D-402 item 5 gives a flip to each TEXT; the arrow is a block, and D-408's words do not list an arrow flip. The page's typed list still holds "only once section 4 has an arrow flip grip". Take it out and ask Tim (question 1): a flip of the arrow could mean the other side of the pipe or reversing the flow, which are very different on a job.

## 3. To add while the page is open (does not hold the build alone)

1. **The night gate:** "first night" must read: only once the check room has passed both halves of the night runner and the picture route, the AutoCAD test room has said go, and Tim has been told in writing (D-364, D-388). The page's step that reads the grips from a view picture uses the picture route, which is itself held. D-407 puts this proof at the FRONT of the AutoCAD test room's list: say so.
2. **Loading the test file:** by the same route and from the same kind of folder as the plug-in, with no setting touched; AutoCAD's unsigned-file box stops the night like any unknown window. The page cites "D-364 item 6" for the test-folder lock: D-364 has no such item; give the real source or call it the builder's own.
3. **AutoCAD's own grips through the typed route** (pipe end, bend, pit centre, the block's size arrows): what AutoCAD does inside its own grip code when called this way is NOT KNOWN: mark it so.
4. **What follows a drag, where the page is silent:** a label moved by a grip is remembered as moved by hand (so a later pipe leaves it, with the marker: D-406 item 4); a pit moved with a joined pipe on a locked layer goes back, with Tim's words (D-348); a plastic pit stretched bigger becomes Junction (D-402); a typed length kept with the marker when an end is dragged (D-410, D-413); the 1,000 mm slide limit and "never across a bend" under a hand drag; the number sits in the circle tag, a block, so the block overrule must tell pit, tag and arrow apart.
5. **The mid-length triangle sits on AutoCAD's own middle grip:** say which is picked. Many parts selected: AutoCAD hides grips past its own limit; the tool never changes that limit or any grip setting.
6. **"The result is right" at night** is checked against the same sums it tests: write the expected end points by hand on the test sheet. "Not a real drag" goes in the night's log lines and the morning report too.
7. **Tim's steps sheet is not on the page:** for each grip: which part to select on the test copy, which grip to hover and the words he should see, what to drag and where, what right looks like, U once and what comes back; plus a part on a locked layer (no grips), Ctrl during a drag, and the pit with a locked joined pipe.
8. **Hover words** ("Pull out a bend", "Next spot (clockwise)") are wording on a screen: mark them DRAFT. Give one drafting example per grip in place of the code names.

## 4. For the control room (no ruling found; settle 1 to 3 before a build)

1. **The flow arrow and "flip":** no flip, slide only (recommended); or the other side of the pipe; or reverse the flow?
2. **Pit size grips:** the block's two corner arrows, or four of the tool's own at the wall middles (which Tim asked for)?
3. **Who may throw the "Plain squares" switch,** and where it lives: only on Tim's word, an office setting not shown in the Settings window, saying once at load when it is on squares (recommended)?
4. **A label, level or number dragged by hand past its rules** (more than 1,000 mm, across a bend, onto the pipe): allowed with the marker (recommended), or stopped at the limit?
5. **Ctrl during a drag of one of the tool's grips** (AutoCAD makes a copy carrying the same identity; D-414 already uses Ctrl as the corner key): nothing on the tool's grips in Stage 1 (recommended)?
6. **The page recommends plain squares for pipe ends, bends and the pit centre** (AutoCAD's own grips): Tim's words were grips whose shape shows what they do: it must be asked, not built, first. And its question 4 (a grip falling back to a square by itself after a fault) is close to the silent fall-back D-407 forbids: not built until he answers.

## 5. Owed in AutoCAD

The whole proof of D-408: the night steps as corrected above, and Tim's hands with the steps sheet. Nothing may run until the night runner and the picture route have passed the check room and the test room has said go.

## 6. Ruled since (control room, about 5:58 pm, D-418)

1. **The arrow HAS a flip grip** (Tim's ruling, TR-139; "slide only" is not taken). DRAFT: the flip puts the arrow on the other side of the pipe; reversing the flow is the Reverse flow action, never a grip. So reason 5 is closed the other way: the page adds the arrow's flip grip, with that meaning.
2. **DRAFT: Stage 1 uses PIT BLOCK 3's OWN two size grips and adds none;** the difference from his "four at the wall midpoints" is put to him with a picture. The page says so plainly (reason 1).
3. **The "Plain squares" switch:** only on Tim's word; an office setting; not in the Settings window.
4. **A hand drag past the rules:** allowed, with the marker.
5. **Ctrl during a grip drag:** nothing in Stage 1.
6. **Plain squares for pipe ends, bends and the pit centre:** asked of Tim, not built on; the build starts with the TEXT grips.

---

# Second answer: the page at db13df1 (after its five edits and D-418)

**Answer: FIX THE PAGE FIRST, on two short edits; the check room will read those two back itself, with no new full read.** Written Fri 20 Nov 2026, about 6:40 pm. By reading only. Reader: Team helper, Claude Opus 5.5, read-only tools: `C:\CE_WORK\check\reports\shaped-grips_reread_REPORT.md`.

## 7. The five reasons: all CLOSED

The pit uses PIT BLOCK 3's own two size grips, marked DRAFT and put to Tim with a picture; the pit number steps above, below, right, left and the cover level through its four corners, each with its own list, words and test; the typed test route asks the edit guard and whether the layer is off or frozen before any grip code, refuses in words, with a night step; the edit doorway is said to be not built, a drag grip enters it like AutoCAD's own grip edit, and the grip build WAITS for it; the arrow's flip is a real grip meaning the other side of the pipe, never a reverse of flow. D-418 is followed on all six points. Tim's steps sheet is on the page (seventeen lines); hover words are marked DRAFT; nothing needs a run on this PC (D-420); no second edit path and no silent fall-back was added.

## 8. Two new contradictions, both in the text grips the build starts with

1. **The label slide says two opposite things.** The steps sheet for Tim, item 4: the label "never crosses the bend"; section 4A item 5 and D-418 item 4: a hand drag across a bend is ALLOWED, with the amber marker. Make the steps sheet say the ruled behaviour, and say at the bench test which straight length the label goes onto and that it is marked as moved by hand.
2. **"Hidden the same way as the pit's".** Section 4 item 8a says that if the arrow block carries a flip grip of its own it would be hidden as the pit's are; but the page now hides no pit grip, and no ruling lets the tool remove a block's own grip. A flip built into the arrow block could also mirror the arrow to point against the flow: a grip that reverses the drawn flow, which D-418 forbids. Replace the line: read TIM_CVL_ARROW on the bench BEFORE the arrow grips are built; if it carries its own flip, stop and put it to the control room.

## 9. Not holding the build (improve when the page is next open)

The night gate should name D-420 items 1, 3 and 7; say the test file loads with no AutoCAD setting touched and that the unsigned-file box stops the night; expected night results written by hand, and "not a real drag" in the night log and morning report; whether a Flip or a Next spot click counts as moved by hand; the 150 mm circle gap on Next spot; 45 degrees to the sheet on a turned pit; the arrow's flip needs its own numbered question for Tim; the text grips also wait on the label placing build and the amber marker; the one allowed write must be written on the doorway's own page too. **A correction:** the first answer said the page cited a "D-364 item 6" that does not exist. It does exist (in the additions to D-364: the test drawing is known by its FULL path). The check room was wrong on that point.


---

# Third answer: the page at 04b4034 (the two edits read back)

**Answer: BUILD FROM IT.** Written Fri 20 Nov 2026, about 7:25 pm. By reading only, by the check room itself (the change between db13df1 and 04b4034: one file, 20 lines added, 6 removed), as the second answer said.

1. **The label slide now says one thing.** Tim's steps sheet item 4: a hand drag past the bend is allowed (D-418 item 4), the label lands on the next straight, lined up with it, with the amber marker; U once puts it back with no marker. The bench item says which straight (the one nearest the drop point: the designer's call, said as such) and that it is recorded as moved by hand.
2. **"Hidden the same way as the pit's" is gone.** TIM_CVL_ARROW is read on the bench BEFORE the arrow grips are built; if it carries its own flip the arrow grips STOP and it goes to the control room; the other text grips do not wait. Question 9 for Tim is on the page.
3. **Also taken up:** D-420 items 1, 3 and 7 at the night gate; the test file loads with no AutoCAD setting touched and the unsigned-file box stops the night; the D-364 item 6 citation kept.

**What this pass means:** the page may be built from, text grips first, inside its own waits (the edit doorway; the label placing build; the amber marker). It is a design page checked by reading: every grip is still owed on the bench and then in AutoCAD, and nothing of it runs on Tim's PC under D-420. Still open from section 9, for when the page is next open: whether a Flip or a Next spot click counts as moved by hand; the 150 mm circle gap on Next spot; 45 degrees to the sheet on a turned pit.
