# Facts read from the installed code for the trust cards (12 to 13 Nov 2026)

**What this is:** answers to the "not known yet" items in cards TRUST-02 to TRUST-08, read from the installed code (Civil 3.0.90 at cf059dcf) by a reader for the controller. Nothing was run. Items marked INFERENCE are the reader's reasoning. The controller has not re-checked these lines unless it says so.

---

# FOR TIM

**Three of these change the cards.**

1. **The Pit Schedule Excel fault (BUG-1255) already has a fix in what is on your PC.** Nobody has seen it work in AutoCAD yet. Card TRUST-04 said no fix existed; that was wrong.
2. **A pit with no number is not left blank.** CE quietly gives it a meaningless internal code as its number. So the Pit Schedule never shows a blank; it shows that code.
3. **More tools fill in values than the audit found.** Edit Pipe fills "100" and "UPVC". Edit Pit fills lid "Class C". CDPROPAGATE assumes 225 when a pipe has no size. The pipe flow calculator keeps the last pipe's size, or 300. Step 6 has to cover all of these, not only the reading of old drawings.

## A. What each tool does with a blank size, material, lid or number

1. **Blank pit number:** replaced by an internal code during the record update (`Services\ProjectDataService.Mutations.cs:2005-2006`).
2. **Pipe flow calculator:** a blank size leaves the box at 300 or the previous pipe's size; a blank material uses the office speed limit. Silent.
3. **Detention calculation:** a pipe with no size is silently left out of the pipe storage volume.
4. **Size check from flow** (solver, size suggestions): blank material gives "Unknown: Set the pipe's material to check its size". Good.
5. **Rule checks (CDRULES):** blank size gives a warning; blank material and blank pit type give Unknown with a reason. No crash. Good.
6. **Design check dashboard:** a pipe with no size is skipped and listed with a reason; blank material uses a Settings value and is treated as a gravity pipe.
7. **Long section:** blank size refuses to draw, with a plain reason. Blank material falls back to a fixed roughness when a Settings switch is off.
8. **Pit Schedule:** blank lid shows a blank cell. Zero pit widths print "0 x 0". A blank pipe size is replaced by the size on the drawn pipe, and opening the schedule writes that back into CE's record.
9. **Pipe labels on the plan:** a blank size would print " DIA. UPVC PIPE"; charged pipes and rising mains always print UPVC.
10. **CDPROPAGATE:** uses 225 when the drawn pipe has no size.
11. **Edit Pipe:** fills "100" and "UPVC" in the window; pressing OK saves them (INFERENCE for the save).
12. **Edit Pit:** a blank lid becomes "Class C"; OK writes it. A blank pit type stays blank.
13. **Also filled with 100:** copies made by cloning, a pipe split, and CDUPGRADE (which also fills a blank material on an existing pipe).

## B. Pit Schedule row order

1. Your dragged order wins, unless it covers less than 90% of the rows.
2. Otherwise: pits named "LPD", then OG, then P numbers, then CP numbers, then the rest.
3. **The stored LPD plays no part in the order.** "LPD first" only matches a pit literally named LPD.

## C. How cover and invert text is recognised

1. **Everyday update:** only text that is linked to the pit, starting "CL " or "IL ". No layer test, no distance test.
2. **Pipe inverts:** only text linked to the pipe, starting "IL"; each goes to the nearer end, with no distance limit.
3. **CDUPGRADE:** any text on any layer containing CL or IL and a number, nearest within pit width plus 2500 (not adjusted for units).
4. **Gap:** CDREBUILD tells you to "add a CL text near the pit and re-run", but nothing in its path reads text that is near and not linked (INFERENCE; a test would confirm).

## D. CDREBUILD

1. It does not always re-read the whole drawing. If nothing has changed since the last full update it skips that part. Its own repairs always run.

## E. The two LPD records

1. **Older record (from CDLPD):** the point, the note position, the pipe and which end, the label, the pit, any target block, the connection type, the invert, the callout.
2. **Newer record (from Design):** a set of outlets, each with the same items plus a name and the pits and pipes that drain to it.
3. **When CDLPD is refused** because the newer record exists, the drafter sees only "Error during CDLPD - see CE log for details". The reason is in the log only.
4. **One reader already exists that returns the outlets from either record** (`LpdService.ReadLpdAuthoritySet`). Card TRUST-07's rewrite should use it rather than add anything.

## F. BUG-1255, Pit Schedule Excel export

1. A fix is in the installed build: when AutoCAD has already loaded its own copy of the Excel library, CE uses that copy (AutoCAD 2025 and later). A settings switch controls it, default on.
2. If it still fails the drafter sees: "Excel export could not start on this AutoCAD. Use Export CSV, it saves the same rows."
3. Not known: whether it works in AutoCAD. The log lines to look for start "[BUG-1255]".

## G. The held builds

1. Both held builds are present to read. Civil's is 120 changes and 169 files beyond what is installed; Structural's is 22 changes and 25 files.
2. The unsaved-work reminder, the schedule note and the Structural fixes each touch a small, named set of files, so each can be lifted alone.

## H. Remembered values

1. **New Pit:** the cover level opens blank unless a switch is on. **The invert has no such guard:** with "Remember last pit settings" on, the last invert is offered again, in any drawing.
2. **New Pipe:** the two inverts are offered again when its remember switch is on.
3. **Trench grate cover level (BUG-743):** remembered per drawing, in memory only.

## I. Pit symbol update on opening

1. In a drawing with no pit blocks it changes nothing.
2. In a drawing with the version 2 pit block, it replaces that block's definition with version 3's and renames it, even if no pit is placed. There is no Settings switch to turn it off.

## J. The read-only check

1. It counts pits, pipes, tanks, slabs and raingardens from CE's saved record only, and flags recorded items whose drawn object is gone, open pipe ends, and pipe-to-pit fit.
2. It does not count pits or pipe lines that are drawn but not recorded.
3. A scanner that finds those already exists, but today it is only reached through the path that writes (`ProjectDataService.Recovery.cs:19`). Step 1 can reuse it read-only (INFERENCE).

## Not checked

1. The Inspector, the X-Civil import and the label command.
2. Whether BUG-1255 is really fixed in AutoCAD.
3. Whether the held fixes still fit on top of what is installed.
4. How one U treats any of this.
