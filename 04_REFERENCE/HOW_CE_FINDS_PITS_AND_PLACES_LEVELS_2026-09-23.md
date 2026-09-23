# How CE finds pits, knows their outline, and places level (IL) text

**Why this exists:** Tim, Test Day 16 Sep (P-06): *"NEED TO BETTER UNDERSTAND HOW THE PLUGIN FINDS PITS AND THE OUTLINE AND
HOW INVERT TEXT SHOULD BE PLACED IN RELATION TO THAT"*. Read from the code installed on 23 Sep 2026 (Civil `a2f56f43`), not from
older notes. All sizes are millimetres. **(Setting)** marks a value you can change on the Settings page; everything else is fixed
in code today.

---

## 1. How CE decides which pit a pipe end belongs to

1. **The search box.** Around every pit, CE draws an imaginary box: the pit's own size (its X and Y widths), plus **100 mm** all
   round. A pipe end inside that box "touches" the pit. An SPS (round pit) uses a circle of its radius plus 100 mm.
2. **Only real pit blocks count:** PIT BLOCK, PIT BLOCK 2 and PIT BLOCK 3. Anything else, however pit-shaped, is not a pit to CE.
3. **Two pits touch the same end:** CE takes the one whose centre is nearest. When drawing with CD, it refuses instead:
   *"Endpoint evidence is ambiguous; CE did not choose a nearby object"*. It never guesses on a new pipe.
4. **No pit touches the end:** the end is left unconnected. The name you gave it (the From/To in the schedule) is kept as text.
5. **What CE remembers is stronger than where things sit.** When you draw with CD, CE records which pit each end started and
   ended at. Later, that record wins over "which pit is nearest now".
6. **When it re-checks:** every time the drawing's CE data loads, when the pit schedule is made, and when a pit moves.

## 2. How CE knows a pit's outline

1. **The size comes from the pit block's own settings:** its X width and Y width (and, for detention and SPS pits, their own widths
   and radius).
2. **Rotation is mostly ignored** for the outline: the box is square to the drawing. Only a detention tank's direction is
   snapped to 0, 90, 180 or 270 degrees.
3. **A detention tank** uses the shape actually drawn, because its insertion point is at one end, not the middle.
4. **Drawing a pipe with CD does not trim it.** The end stays exactly where you picked.
5. **Resizing a pit** (PIT's Edit and Save, or CD's Upsize) pulls each connected pipe end onto the pit's **near wall**, along
   the line of the pipe, within 5 mm. Grade, length text and the text tidy-up then re-run. Upsize steps through the pit size
   ladder **450, 600, 900, 1200, 1500 (Setting)**, and it will not upsize a detention tank or an SPS.
6. **Moving a pit with AutoCAD's MOVE** carries the pipe ends the same distance, but does **not** re-snap them to the wall.
7. **Pipe length on the pipe text** is the length of the line as drawn, end to end. After a re-snap, that is wall to wall.

## 3. How the level (IL) text is placed

1. **Along the pipe:** **200 mm (Setting)** in from the pipe end. At an SPS the distance allows for the round pit's size.
2. **Off the pipe:** half the pipe's diameter, plus **70 mm (Setting, the mask gap)**, on the chosen side.
3. **Which side:** Top or Bottom, chosen per end in the CD window. The default is **Top (Setting)**. Top means the upper side of
   the pipe; on a pipe running straight up and down, it means the left (west) side.
4. **Size and angle:** 180 mm high, turned to follow the pipe at that end, and never upside down.
5. **If something is in the way (PLACE-01, your 16 Sep ruling):**
   - CE first slides the text along the pipe in steps of **125 mm (Setting)**, up to **500 mm (Setting)** from the pipe end.
     500 is also a hard ceiling: a higher setting is capped at 500.
   - Then it tries the other side of the pipe, then the other side with slides, then a lane 275 mm further out.
   - The smallest move that clears wins. The text never goes past the middle 90% of that stretch of pipe.
   - If no spot is clear, it leaves the text where it is and says so.
   - Text you placed by hand in the same command is never moved.
6. **What counts as "in the way":** any text, leader, dimension, table or block (not an Xref) nearby; a pit's body (not its
   label); and other CE pipes, taken as their full width.
7. **When it re-places:** on drawing, after MOVE or a grip drag, after a pit re-snap, and after a split. In between, a level
   text keeps its place as a fraction of the way along the pipe. It does not jump back to 200 mm.

---

## 4. Where the code does not agree with itself (found 23 Sep; to be fixed so there is one rule)

1. **A split pipe's level text follows older rules than CD's:**
   - the Top text gets no 70 mm gap;
   - the Bottom text uses a fixed 70 instead of the Setting;
   - it uses the old justification and the old "up and down means west" rule.

   After a split, the level can therefore sit slightly differently from one CD would draw.
2. **CD's pit search and the drawing's pit link use slightly different outlines** (CD uses the box around the insertion point;
   the link also includes the shape as drawn). A detention tank, or a pit whose insertion point is off-centre, can be linked in
   the drawing but missing from CD's From/To.
3. **Detention width differs by 100 mm** between the stored value (solid + grated + 100) and CD's search (solid + grated).
4. **An SPS is found as a circle but snapped to as a square.**
5. **Two misleading messages:**
   - the SPS log says "within 200 mm" where the search is 2000;
   - the detention length prompt says "pit-to-pit" but measures the length as drawn.

**Queued:** 1 to 4 are behaviour fixes (one rule for one job, design rule #1). Item 1 is the likeliest cause of any "level in the
wrong place after a split" still seen; Codex's pass-2 step L4 records it on a real split first.

---

### For whoever fixes section 4 (developers only)

1. Split level text: `LinkService.Split.cs` `CreateInlineSplitInvertText` (about line 1935, and 1978, 2021-2055), against
   `TextService.PrepareAutomaticInvertText` and `GeometryHelper` (line 183).
2. Pit outline: `CdCommand.Schedule.cs` 294-343 against `LinkService.Cache.cs` 865-903.
3. Detention width: `LinkService.PitRelinks.cs` 176-185 against `CdCommand.Schedule.cs` 310-311.
4. SPS: `LinkService.Cache.cs` 849-853; message `PipeTruthLogic.cs` 677 against `PipeAttachmentPlacementMath.cs` 22; prompt
   `CdCommand.cs` 1154 and 1169.
