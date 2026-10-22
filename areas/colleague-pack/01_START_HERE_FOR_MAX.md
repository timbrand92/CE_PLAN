# Start here, Max: CE Civil in one page

**DRAFT, written Thu 22 Oct 2026 for the hand-over on Mon 9 Nov 2026. Not final until Tim checks it (see 06).**
Anything marked [CHECK] was not confirmed in the plugin's code and must be confirmed before this page is handed over.

---

## 1. What CE Civil is for

1. **It draws and checks stormwater drainage in plain AutoCAD.** Pits, pipes, downpipes, labels, the Pit Schedule, long sections and detention, all from one CE ribbon tab.
2. **Every pit and pipe knows what it is.** Change a pipe size or a level and its labels, its schedule row and its checks follow.
3. **It warns, it never stops you.** A warning tells you something looks wrong as an engineer. You decide. Only two things are ever blocked, and neither is something you will meet day to day.
4. **"Unknown" means CE could not tell, never zero.** A blank level stays blank until you type it.

## 2. What you get

1. **CE Civil 3.0.70 and CE Manager 1.1.70** (the versions on Tim's PC on 22 Oct). The exact numbers you receive are set when the release is frozen, about Mon 2 Nov. [CHECK]
2. **The same set-up Tim uses**: his version and his working switches, not a separate build.
3. **For AutoCAD 2027.** [CHECK: confirm Max's PC runs 2027]
4. **Not included:** CE Structural. It stays on Tim's PC until he says it is ready.
5. **Help inside AutoCAD:** type `CDHELP`.

---

## 3. The 10 commands to learn first

1. **`PIT`: place a pit.** Click the spot, type the cover level in the New Pit window, place the label. Esc to stop.
2. **`CD`: draw a pipe.** Click the first pit, then the second, Enter for straight, type both invert levels, press Start Pipe.
3. **`DP`: place a downpipe** (a DP1 source block). [CHECK: exact prompts]
4. **`CDEDIT`: edit anything CE drew.** Pick a pit, pipe, downpipe or CE text and its Edit window opens. Use this when a double-click does not work (see page 04).
5. **`PITSCHEDULE`: the Pit Schedule window.** Every pit with its levels, sizes and warnings. Opening it changes nothing.
6. **`CDCHECKS`: the Checks list.** A palette listing what CE thinks is wrong on the drawing. [CHECK: confirm it is switched on in the shipped set-up]
7. **`CDRULES`: the design rules check.** Press Enter for Problems only, or type A for everything. "Unknown" means a level is missing, not a pass.
8. **`CDPROFILE`: draw a long section** along a run of pits.
9. **`CDS`: CE Settings.** Office values (cover, grades, text heights). Look, but change nothing in week one without asking Tim.
10. **`CDHELP`: the CE Help Centre.**

**Two habits that save trouble:**
1. **One `U` takes back one whole CE action** (a pit with its label, a pipe with its arrow and labels).
2. **For REDO, type nothing and pick nothing after `U`.** Then type `REDO`. See page 04, item 4.

---

## 4. Your first 10 minutes (on a COPY, never a real job)

**Before you start:** open the practice drawing Tim gives you, or a copy of a finished job saved to your desktop. [CHECK: Tim to name the practice drawing; no sample drawing ships with CE]

1. **Place two pits.** Type `PIT`. Click a spot. Type cover level `19.000`. Press Continue placement. Place the label. Click a second spot 20 m away, cover `18.900`. Press Esc.
   - **Right looks like:** two pits, numbered P1 and P2 (or the next free numbers), each with a label.
2. **Draw a pipe between them.** Type `CD`. Click P1, then P2. Press Enter (straight). Type `18.000` and `17.900`. Press Start Pipe. Press Esc.
   - **Right looks like:** a pipe with a flow arrow, a size and grade label, and an invert text at each end.
3. **Change the pipe size.** Type `CDEDIT`, pick the pipe, change 150 to 225, press Save.
   - **Right looks like:** the label now says 225.
4. **Take it back.** Type `U` once.
   - **Right looks like:** the label says 150 again.
5. **Look at the schedule.** Type `PITSCHEDULE`. Find P1 and P2. Close the window.
6. **Run the checks.** Type `CDRULES`, press Enter. Read the first line (how many warnings and unknowns).
7. **Open the help.** Type `CDHELP` and find "Getting started". [CHECK: section name]
8. **Close the drawing without saving.**

**Something odd?** Do not fix it by hand. Write it down and send it the way page 05 says.

---

## 5. The other pages

1. **02 Install and update:** how CE gets onto your PC and how to go back.
2. **03 What's in this release:** what is new, by job step.
3. **04 Known problems:** what does not work yet, and what to do instead.
4. **05 How to report a problem:** exactly what to send.
