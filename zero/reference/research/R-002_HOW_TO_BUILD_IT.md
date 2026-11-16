# R-002 How to build it: what Autodesk provides, the traps, and the trials that would prove it

**Made:** Mon 16 Nov 2026, for the zero plan (Stage 4). **Asked by:** the four trials in `design\BUILD_APPROACH_DRAFT.md`, section 9 of `design\UI_PLAN.md`, and the "any direction" limit in `design\FOUNDATION.md`.
**Builds on:** R-001 (feeling native in AutoCAD). Nothing in R-001 is redone here. Three places where R-002 corrects or adds to R-001 are listed in the closing section.
**Status:** research and recommendations. Nothing here is a decision. **Nothing was tried in AutoCAD. AutoCAD was not started.** Every "trial" below is described for later.

## How to read

1. **Every finding has a source line** (page title, address, year or product version) and **how sure** (high / medium / low). "Unknown" means nobody could say from what was read. "Not found" means I looked and found nothing.
2. **Five kinds of source are used, and the line says which:**
   1. **Autodesk's site, read in full.** The best kind.
   2. **Read on this PC from the AutoCAD 2027 SDK help** (Managed .NET Developer's Guide, ObjectARX Developer's Guide, Managed API reference). These are Autodesk's own 2027 pages.
   3. **Read on this PC from AutoCAD 2027's own shipped program files** (a decompiled copy). This shows what the program contains, not what Autodesk promises, and nobody saw it run. Rule 12.5 of the owner's rules applies: it is evidence that something exists, never proof of how it behaves.
   4. **Search summary only.** Autodesk's forum and some PDF pages refused every request (error 403) or were scrambled, so forum evidence is second-hand and marked low or medium.
   5. **The office's own earlier probes** (the notes recorded in September 2026). Real measurements on this PC, but not Autodesk statements.
3. **Plain words first; the programming name is in brackets** after the plain statement.
4. **No people are named.** Authors of blog posts and handouts are described by where they published.
5. **Scratch files** made while reading were removed. Nothing else in the repository or on the drive was changed.

## Answers in one breath

1. **A. Notes on ordinary objects.** Three homes exist. Small notes on the object (extended data), a private folder on the object (extension dictionary), a drawing-wide shelf (named dictionary). The first two copy with the object; the shelf does not. Joins that point at other objects are the weak spot (see A).
2. **B. Keeping joins.** Autodesk gives drawing-wide events and "overrules" (a way to adjust how AutoCAD treats certain objects while the plugin is loaded). Autodesk's own rules say do not edit other objects in the middle of AutoCAD's save-up step. The 2027 .NET kit shows no "after everything is saved" event; the safe places are the end of the command or a hook on the object closing.
3. **C. Grips.** Custom grips with a right-click or hover menu exist in the .NET kit (a multi-mode grip helper). Dragging works on a temporary copy, which is the main trap.
4. **D. Properties palette.** The official route is C++/COM. A .NET route exists in the 2027 files for ordinary lines, polylines, text and blocks, but nobody could say whether the Properties palette reads it. Unknown until a trial.
5. **E. Live preview and Inspect.** An off-screen picture of the drawing works in 2027 (the office proved one for a block in September). Hiding the window while the user picks is a supported call.
6. **F. Ribbon tab on selection.** In 2027 the supported way is a small rules file that the bundle carries and AutoCAD compiles itself. Button tips have a field for the typed command name.
7. **G. Typed names.** A short name can simply be another command name on the same tool, so the user's alias file is never edited. A plugin command beats an ordinary alias. A step Autodesk lists before plugin commands (external commands in the alias file) was missed in R-001.
8. **H. Double-click.** AutoCAD's own double-click list works per object type only. A plugin can listen to the double-click but cannot cancel AutoCAD's own action on its own. The published workaround breaks one of Autodesk's event rules.
9. **I. One-click update.** The per-user bundle folder needs no administrator rights for copying, but AutoCAD wants unsigned code from non-Program-Files folders trusted. A loaded plugin file cannot be overwritten while AutoCAD runs. A small fixed loader plus versioned folders and a pointer file is the shape that fits.
10. **J. Headless.** The headless engine runs plugin code that has no window, ribbon or grips. Everything the owner sees on screen still needs the full program.
11. **K. Any direction.** Propagating from held values is an established technique with known limits (loops, "smallest of" rules, inequalities). A pure-code trial can prove it before anything is drawn.
12. **L. Inspection openings.** The standard's text could not be read. No spacing figure is given here. See L.

---

## A. Attaching the plugin's own facts to ordinary objects

### What Autodesk provides

1. **Extended data (XData): small notes carried on the object itself.** Saved in the drawing, copied with the object. One shared limit of 16 kB per object across every add-on. Autodesk's advice: on ordinary objects that any add-on can reach, stay under 2 kB and never go over 4 kB; each add-on name costs about 40 bytes of memory.
   Source: Use AcDbObject XDATA and Extension Dictionaries Conservatively, help.autodesk.com/cloudhelp/2021/ENU/OARX-IOP/files/GUID-752D0BE7-CF03-4AC1-8AA6-2DE5BE6A054A.htm (2021); also Managing Extended Data Memory Use, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
2. **What extended data can hold.** A fixed set of types only: text, numbers, 3D points, handles (the object's saved ID number, group 1005) and binary chunks of up to 127 bytes each. No nesting.
   Source: Extended Data and Extended Data Exclusive Data Types, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
3. **Extension dictionary: a private folder hanging off one object, holding any number of records (Xrecord).** Autodesk: "no maximum size" per entry, but each entry costs at least 250 bytes of memory while AutoCAD runs. One record can hold up to 2 GB. Autodesk's own guidance: use extended data for small amounts and records for larger amounts.
   Source: same 2021 page as item 1; Xrecord Objects, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
4. **Named dictionary in the drawing (named object dictionary): a drawing-wide shelf.** It accepts any record. Autodesk says entry names should be unique to the add-on, the same way an add-on registers its own name for extended data. It is attached to the drawing, not to any object, so it does not travel with a copied object (my reading of how it is built, not a stated Autodesk sentence).
   Source: Xrecord Objects, ObjectARX Developer's Guide (2027), read on this PC. Sure: high for the first two statements; medium for "does not travel".

### What happens on copy, mirror, explode, wblock and save

5. **Autodesk's own list of which commands copy in which way.** COPY, ARRAY, MIRROR (original kept), BLOCK, INSERT of a drawing, and EXPLODE of a block reference use a "deep clone" (copy the object and the things it owns). WBLOCK, COPYCLIP, CUTCLIP, PASTECLIP and XBIND use a "wblock clone" (follow only hard owners and hard pointers). MIRROR with the original erased does no copying: the object is only mirrored. EXPLODE of anything that is not a block reference: "no cloning is performed".
   Source: AutoCAD Commands That Use Deep Clone and Wblock Clone, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
6. **So the extension dictionary copies with its object in both kinds of copy.** A database object is the hard owner of its extension dictionary, and dictionary entries are hard-owned by it. This is my reading of two Autodesk statements put together, not a sentence on one page.
   Source: Types of Ownership and Deep Clone Basics, ObjectARX Developer's Guide (2027), read on this PC. Sure: medium.
7. **Handles stored in extended data are translated in some copies and not in others.** Autodesk lists them: translated by INSERT, XBIND and partial DXFIN; left unchanged by the BLOCK command (which gives the block's objects new handles); translated on EXPLODE of a block when the handle points at something inside the block. Autodesk's record page says outright that handle groups in extended data "are translated in some cases but not in others", while pointer fields in a record (codes 330 to 369) are maintained, and plain handle numbers stored in a record are left alone.
   Source: Using Handles in Extended Data and Xrecord Objects, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
8. **A hard pointer can drag its target into a WBLOCK as an orphan.** Autodesk warns that if a custom object holds a hard pointer to an entity, the default copy appends nothing and the copy ends up "ownerless" with "no current way to complete its append via the API". This is written for custom classes. Whether a hard pointer stored in an ordinary record behaves the same is Unknown; the safe reading is to test soft pointers.
   Source: Handling Hard References to AcDbEntities During wblockClone(), ObjectARX Developer's Guide (2027), read on this PC. Sure: medium that the warning exists; low that it applies to a record.
9. **Copying objects that point at each other.** A forum report (search summary only) says a copied polyline kept the original text's handle in its dictionary, with no event named for remapping. Autodesk provides the events to remap it yourself: a deep-clone-finished event on the database and a deep-clone hook on the object overrule (see B).
   Source: search summary of the Autodesk forum thread "Issue with Handle References in Copied Polylines in AutoCAD Plugin" (page refused); Database.DeepCloneEnded and ObjectOverrule.DeepClone, Managed API reference (2027), read on this PC. Sure: low for the report; high that the events exist.
10. **EXPLODE of a polyline: Unknown.** Autodesk says no cloning is performed, and says nothing about whether the new lines inherit the notes. A 2001 forum report (search summary only) says a block exploded through the programming interface lost its pieces' notes while the EXPLODE command kept them. Old, and about blocks.
    Source: item 5; search summary of a 2001 Autodesk forum thread on VBA explode versus the command (page not opened). Sure: low.
11. **Plain AutoCAD ignores the notes and writes them back.** Autodesk: AutoCAD "maintains the information but doesn't use it". Nothing in the notes changes what plain AutoCAD draws or plots.
    Source: Extended Data, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
12. **AutoCAD LT: Not found on any Autodesk page.** Forum users (search summary) report extended data was still there after working in LT and that LT cannot show or edit it. Saving down to an older drawing format "strips out or converts" product-specific information per the LT help summary (not opened). Treat as unproven.
    Source: search summaries of a CADTutor thread and the LT help page "About Saving Drawings to Previous Drawing File Formats". Sure: low.
13. **Undo.** Changes made through a transaction (the wrapper that keeps a drawing change safe) are recorded in AutoCAD's undo. Do not mix it with commands that use sub-command undo, such as PEDIT and SPLINEDIT, inside the same transaction.
    Source: Undo and Transactions, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.

### Known traps

14. **A copy of a pit and a pipe that point at each other.** If the join is a stored handle, a plain copy leaves the copied pipe pointing at the original pit (items 7 and 9). The plugin must remap on copy, or store joins in a form AutoCAD maps itself (a soft pointer in a record). Which one holds up through every command is the main thing the trial must find.
15. **The registered name must exist first.** Extended data cannot be written until the add-on's name is registered in the drawing; Autodesk's sample registers it if it is missing on every write. A command-line -PURGE with the registered-applications option removes unused names, so register-if-missing on every write.
    Source: Assign and Retrieve Extended Data (.NET), Managed Developer's Guide (2027), read on this PC; purge behaviour from search summaries of an Autodesk support article and forum threads (not opened). Sure: high for the sample; medium for purge.
16. **Dragging an overruled object works on a shallow copy, and the copy's extension dictionary cannot be read.** Autodesk's developer blog says the fix is to read the dictionary in the "clone for dragging" call and hand the values over. The post covers dictionaries, not extended data, so whether extended data travels on the drag copy is Unknown.
    Source: Accessing extension dictionary of an overruled entity while dragging, blog.autodesk.io/accessing-extension-dictionary-of-an-overruled-entity-while-dragging/ (undated). Sure: medium.
17. **Dictionary data has been lost between releases once.** Autodesk's blog says AutoCAD 2021 deleted custom dictionaries written by AutoCAD 2020 and earlier through the LISP data functions, with a workaround setting LISPSYS to 0 and "being addressed". Cause not stated. The lesson is a self-check on open, not a reason to avoid dictionaries.
    Source: AutoCAD 2021 issue of deleting custom dictionaries from previous versions, blog.autodesk.io/autocad-2021-issue-of-deleting-custom-dictionaries-from-previous-versions/ (2020). Sure: medium.

### How it would be used here (leaning, to be proven)

18. **Small identity and join notes in extended data; the bigger fact list in one record in the extension dictionary; drawing-wide things in the named dictionary.** Identity and join notes (what kind of thing, its ID, what it is joined to, a version) stay well under 1 kB so any event or overrule can read them fast; Autodesk's filters for overrules look for an extended-data name or an extension-dictionary entry (see B). Facts (levels, sizes) live once, in the record. The job facts and a register of the plugin's things live in the named dictionary. One place per fact (design rule 1).
    Source: items 1 to 7 and B item 6 put together. Sure: medium (my recommendation; not an Autodesk statement).

### Small trial that would prove it in real AutoCAD 2027

19. **What to do.** In a made-up drawing, make a polyline, a text and a block reference. Attach the same facts three ways to copies of each: extended data, a record in an extension dictionary, a named-dictionary entry keyed by the object's handle. Add a join from the polyline to the block three ways (stored handle in extended data; soft pointer in the record; hard pointer in the record). Then run each of: COPY (one object, then pair together), MIRROR (keep and erase originals), ROTATE, STRETCH, EXPLODE (polyline and block), BLOCK, WBLOCK to a new file, COPYCLIP then PASTECLIP into a second drawing, INSERT of a drawing, an Xref attach and bind, UNDO and REDO after each, SAVEAS to the oldest format the office still needs, close and reopen, open and save in plain AutoCAD on a PC without the plugin, open and save in AutoCAD LT (**needs an LT copy; Unknown whether one is available**), -PURGE with the registered-applications option, and AUDIT.
20. **What "pass" looks like.** After each step read the facts back from the original and the copy. Pass means: the notes are present where Autodesk's list says they should be; every join in a copy points at the copy of its partner and never at the original or at nothing; no orphan object appears after WBLOCK; AUDIT reports zero errors in plain AutoCAD; file size grows by the expected few kilobytes; the picture on screen and in a plotted PDF is identical with and without the plugin. Record per step which of the three homes survived, so the choice in item 18 is made from the recorded results.

---

## B. Keeping joined things together without a custom object

### What Autodesk provides

1. **Drawing-wide events, all in .NET.** Object appended, erased (also fires on un-erase), modified, opened for modify, and the undo pair: unappended (an undo removed it) and reappended (a redo put it back). On a single object: modified, modified-xdata, copied, erased, goodbye, modify-undone, sub-object-modified. Also copy and wblock events on the database (begin and end of deep clone, begin wblock), and command events on the document (command will start, ended, cancelled, failed) and a quiet-moment idle event on the application.
   Source: Handle Object Events (.NET), Managed Developer's Guide (2027), read on this PC; Document, Database and Application event pages in the Managed API reference (2027), read on this PC. Sure: high.
2. **Autodesk's rules for what a handler may do.** Do not rely on the order of events or of operations. No interactive calls (no prompts, no selection, no sending text to the command line). No dialog boxes. Avoid changing the object that raised the event. Do not do anything that raises the same event again (you get an endless loop). No events fire while a modal dialog is open.
   Source: Guidelines for Event Handlers (.NET), Managed Developer's Guide (2027), read on this PC. Sure: high.
3. **Change events arrive at "commit time", and other objects are locked then.** Autodesk's C++ guide says "modified", "erased" and "modify undone" notices are deferred until the object closes (or the outermost transaction ends). At that moment the object is read-only, and changing it, or starting a new transaction, aborts AutoCAD with an in-process-of-committing error. Autodesk's advice: write down the IDs, wait for the end of the transaction, then edit. The same engine sits under .NET.
   Source: Immediate versus Commit-Time Events and Commit-Time Guidelines, ObjectARX Developer's Guide (2027), read on this PC. Sure: high for the C++ statement; medium that it carries over to .NET events unchanged.
4. **Not found: an "all transactions ended" event in the 2027 .NET kit.** The C++ guide names one. I searched the managed API reference and a decompiled copy of the 2027 managed files for it and found none. The .NET stand-ins are the end of the command (command ended), the idle event, and the object overrule's close call.
   Source: search of Managed API reference (2027) and a decompiled copy of AutoCAD 2027's managed files, both read on this PC. Sure: medium (absence is hard to prove).
5. **Overrules: adjust what AutoCAD does with an object while the plugin is loaded.** Grip, transform (move, rotate, scale, mirror, explode, the drag copy), object (open, close, cancel, erase, deep clone, wblock clone), geometry, snap, visibility, properties (the list output) and draw. They must be registered per object class and switched on with one application-wide switch.
   Source: Managed API reference (2027), read on this PC; Runtime Registration, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
6. **Overrules can be limited to the plugin's own objects.** Each overrule has a filter that makes AutoCAD look for the plugin's extended-data name, or an extension-dictionary entry name, or a list of IDs, or a custom test, before calling the overrule. This is the cheap way to keep the overrule off every other object in a drawing.
   Source: SetXDataFilter and the matching pages on GeometryOverrule, GripOverrule, ObjectOverrule and TransformOverrule, Managed API reference (2027), read on this PC. Sure: high.
7. **Grip moves call the transform function.** Autodesk: the transform call "is called by the grip move, rotate, scale, and mirror modes". Whether the MOVE, COPY and ROTATE commands also pass through it is not stated. Unknown.
   Source: Transform Functions, ObjectARX Developer's Guide (2027), read on this PC. Sure: high for what is stated; the rest Unknown.

### What is safe inside these events, and what is slow or crashes

8. **Safe:** read the changed object's ID and the plugin's note on it; put the ID on a list; return. **Not safe:** write to another object while AutoCAD is committing; open a transaction inside the modified event; ask the user anything; show a window; send commands to the command line (items 2 and 3).
9. **The close-hook pattern.** An independent developer's blog (not Autodesk) keeps a linked pair in step by overriding the object overrule's close call, restricted to the pair by an extended-data filter, with a flag that stops it re-triggering. The author says the extra change is made "without reopening" the object and is simpler than watching command and modified events. Forum answers (search summary only) add that changes made in the close hook undo together with the original change, unlike changes made from the modified event.
   Source: using objectoverrule to force entities, knowledge-autodesk.blogspot.com/2014/08/using-objectoverrule-to-force-entities.html (14 Aug 2014); search summary of an Autodesk forum thread. Sure: medium for the blog; low for the undo claim.
10. **Undo and redo.** Events for them exist (item 1). Forum experts (search summary) say redo is the part that gets damaged when a handler edits other objects. The office's own September finding: a change made at idle time, after the command ended, becomes its own undo step. So a pipe fix made at idle needs two presses of undo.
    Source: search summary of Autodesk forum threads; office's own note on the idle-time undo step (B5 fault, 2026). Sure: medium.
11. **Known slow things.** The database "modified" event fires for every object in the drawing, so the handler must be tiny (search summary, forum). An overrule with no filter runs for every object of that class. Dragging an overruled object clones it; Autodesk's blog says avoiding the clone is only for objects too costly to clone.
    Source: search summary of Autodesk forum threads; blog.autodesk.io post in A item 16. Sure: medium.
12. **Known crash and abort.** Editing during commit aborts AutoCAD (item 3, Autodesk). A forum thread titled "Modified Event of BlockReference Causes Crash" exists; I did not open it and cannot say what it found. **Not found: an Autodesk statement that lists crash causes for overrules.**
    Source: Commit-Time Guidelines (above); thread title from a search result. Sure: high for the abort; Unknown for the rest.
13. **Grip overrules are not called for MOVE.** An Autodesk engineer's blog says grip overrules do not fire for commands such as MOVE that bypass grips; use the transform overrule to see those.
    Source: Knowing when an AutoCAD object is grip-edited using overrules in .NET, Through the Interface, keanw.com/2009/08/knowing-when-an-autocad-object-is-grip-edited-using-overrules-in-net.html (Aug 2009). Sure: medium (old, AutoCAD 2010-era).

### How it would be used here (leaning, to be proven)

14. **Watch cheaply, act once, act at a safe moment.** The handlers only note "this pit changed" (object ID, nothing else). The joined pipe ends are then moved in one write, taken under the document lock, either from a close hook on the plugin's own objects (so it joins the same undo step) or at the end of the command. Both routes have a known cost (item 10); the trial chooses between them.
    Source: items 2, 3, 9 and 10 put together. Sure: medium (my recommendation).

### Small trial that would prove it in real AutoCAD 2027

15. **What to do.** One pit block and three pipes joined to it, made-up data. Move the pit with MOVE, with a grip, with STRETCH, ROTATE, MIRROR, SCALE and by a typed coordinate. Copy the pit alone and with its pipes. Erase the pit, then UNDO, then REDO. Do each with route 1 (events plus end of command) and route 2 (close hook on the plugin's objects). Then repeat the move on a drawing with 500 pits.
16. **What "pass" looks like.** The pipe ends sit exactly on the pit after every step; one press of UNDO puts back both the pit and the pipes; REDO does the same; no AutoCAD abort or error line at any step; a drag of the pit in the 500-pit drawing stays smooth (no visible stutter; the Speed trial sets the limit); a copied pit never moves the original's pipes. Record which commands did and did not call the transform overrule (item 7).

---

## C. Custom grip behaviour on ordinary objects

### What Autodesk provides

1. **A grip is a small object you define (GripData) and an overrule that adds it (GripOverrule).** A custom grip can draw its own picture, react to a hover, a click (hot grip), a right-click, give a tip, and be told when it changes status. The overrule can also hide AutoCAD's built-in grips on that object if wanted.
   Source: GripData and GripOverrule, Managed API reference (2027), read on this PC; Using Custom Grip to Enhance User Interaction with AutoCAD Entities, Autodesk University 2022 class handout SD501372 (25 pages, Autodesk-hosted). Sure: high that the classes exist; medium for the handout (a speaker's sample code, not Autodesk's guidance).
2. **Menus on a grip.** Two routes in the 2027 .NET kit: a right-click menu from the grip's own right-click call (it returns a list of menu items), or the multi-mode grip helper (MultiModesGripPE), where the grip carries a list of modes that become menu entries; each mode can run at once or start a command. The handout says the helper already handles showing the menu, and that hovering the grip brings the menu up.
   Source: GripData.OnRightClick, Managed API reference (2027); AU 2022 handout SD501372 (above). Sure: medium (reference is thin; the handout is one speaker's example).
3. **Flip and slide are both possible in principle.** A flip is a mode that acts at once. A slide is the grip's drag handler writing a new position into the plugin's facts. Neither is an Autodesk-supplied behaviour; both are ours to write.
   Source: items 1 and 2 put together. Sure: medium.

### Limits and traps

4. **The object you are handed during a grip drag is a temporary copy with no ObjectId.** An Autodesk engineer's blog says this, and that identifying the object is therefore awkward; the sample keys on class name and position and calls that imperfect. Whether the plugin's extended-data note is present on the copy is Unknown.
   Source: Knowing when an AutoCAD object is grip-edited using overrules in .NET (as B item 13). Sure: medium.
5. **Grip overrules do not run for MOVE** and other commands that bypass grips (B item 13). The slide or push-off must be a grip action, never relied on for the command.
6. **Block references: reports of the default grip move stopping.** Commenters on that blog report that overruling grips on block references stopped the default grip move; the author said it was unclear whether that is by design. Old and second-hand.
   Source: comments on the same post. Sure: low.
7. **Hover menus from a custom grip may behave differently from AutoCAD's own.** A forum poster (search summary) says a menu added in the hover call stayed open until clicking elsewhere and hid the cursor. One report.
   Source: search summary of the Autodesk forum thread "GripData.OnHover() how to add a context menu" (page refused). Sure: low.
8. **Limits on how many custom grips or how they behave with several objects selected:** Not found beyond the "skip when shared" flag on the grip (Managed API reference, 2027). Sure: high for the flag; the rest Not found.

### How it would be used here (leaning, to be proven)

9. **One extra grip on the label that slides it along its pipe, with a small menu: Push off, Flip side.** The overrule is filtered by the plugin's extended-data name, so ordinary text and blocks keep AutoCAD's own grips untouched. The menu says the same words as the ribbon and right-click menu (R-001 recommendation 4: one action, three doors).
   Source: items 1 to 3 plus A item 18. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

10. **What to do.** Make a pipe with a text label that carries the plugin's note. Add the overrule with one slide grip and a two-entry menu. Select the label, drag the grip, hover it, right-click it, choose each menu entry, press Escape mid-drag, UNDO. Select an ordinary text elsewhere. Select the label and a plain text together. Repeat with the label as a block reference with an attribute.
11. **What "pass" looks like.** The slide stays on the pipe line and follows the pipe's angle; the menu shows up on hover or right-click and both entries work; Escape leaves nothing changed; UNDO restores the label and its note in one step; the plain text keeps AutoCAD's own grips and menus; the plugin note is readable during the drag (so the clone problem in item 4 is settled either way); on a PC without the plugin the label shows only AutoCAD's normal grips.

---

## D. The plugin's facts in AutoCAD's own Properties palette

### What Autodesk provides

1. **The official route is C++ and COM.** AutoCAD's Property Inspector (the engine behind the Properties palette) is a COM module; by implementing its interfaces "you can display your custom properties for both native and custom objects". "Dynamic properties" can be supplied for any native class, per class or per single object (a property source), they can be editable, and the application decides whether to keep the values in the drawing. The guide sits in the chapter "Using COM for ObjectARX Development".
   Source: Property Inspector and Properties Palette APIs, Dynamic Properties, Implementing Per-Instance Dynamic Properties, ObjectARX Developer's Guide (2027), read on this PC. Sure: high.
2. **A .NET property list API exists in 2027 and ordinary classes carry its hook.** The managed namespace Autodesk.AutoCAD.ComponentModel (in the AcDbMgd file) offers a type descriptor with "add a property" (a property description you write) and "add a per-instance property provider" (code that returns different properties per object). The shipped 2027 managed file marks Polyline, Line, Circle, DBText, MText, BlockReference and the base Entity class as using it. Autodesk's text says the type must be marked with that attribute; the base-class marks are visible in the decompiled copy.
   Source: Autodesk.AutoCAD.ComponentModel namespace, TypeDescriptor.AddProperty, IPropertyProvider, Managed API reference (2027), read on this PC; decompiled copy of AutoCAD 2027's managed files, read on this PC. Sure: high that the API and marks exist.
3. **Whether the Properties palette reads that list: Unknown.** What the decompiled files show reading it is AutoCAD's newer managed screens (ribbon bindings, value converters). The Properties palette is described by Autodesk as a COM module, so it may not. Autodesk's page gives no sentence either way.
   Source: Property Inspector pages (item 1); decompiled copy of AutoCAD 2027's window files, read on this PC. Sure: low.
4. **Forum answers say it cannot be done from .NET.** Several Autodesk forum answers (search summary; pages refused) say there is no .NET API for the palette, that the newer palette system is reachable only from ObjectARX, and that a palette window of your own is the usual answer. They are from 2012 to 2024 and predate the finding in item 2.
   Source: search summaries of Autodesk forum threads "Is it possible to add custom properties for object (for example Line) with .NET?" and "Add custom properties to the object properties palette". Sure: medium that the community view is that; low that it is still true in 2027.
5. **A third-party library exists.** OPMNetExt (MIT licence) says it exposes more of the palette to .NET, targets AutoCAD 2025 and .NET 8, and describes the existing .NET support as "far from complete". No 2027 build.
   Source: github.com/cyrillef/OPMNetExt (read; 12 commits, 2026 copyright, no date given). Sure: medium.
6. **Extended data and extension-dictionary notes do not show in the palette by themselves.** Forum reports (search summary).
   Source: search summary of Autodesk forum threads. Sure: medium.
7. **Quick Properties and roll-over tips showing the plugin's facts: Not found.** R-001 left this open; the pages read here do not close it.

### Known traps

8. **Editing in the palette needs the write-back to be under the same safety rules as any edit** (document lock, one undo step, no re-entry). Autodesk's page on the palette's interaction with commands exists in the C++ guide (title seen, not read).
9. **A native C++ helper would break the "no hand-built C++ unless a trial proves it is unavoidable" line** in the build approach (section "Build", item 1). Autodesk's ObjectARX wizard skill is installed on the owner's PC, so building one is possible; it is a decision, not a technical block.

### How it would be used here (leaning, to be proven)

10. **First choice: the .NET property list API, if the trial shows the palette reads it.** One list of facts per thing (the "view" block of FOUNDATION): the same list feeds the window, the palette and the label.
11. **Second choice: our own side palette that follows the selection** (a PaletteSet that shows the same cards). It cannot be AutoCAD's own Properties palette, and the "feels native" goal (D-048) is only partly met.
12. **Third choice: a thin native helper only for the palette.** Needs the owner's ruling because of the C++ line.
    Source: items 1 to 9. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

13. **What to do.** In a small test plugin, add one editable text property and one read-only number property, under a heading named "CE Pipe", to the polyline class and to the block reference class (item 2). Select an ordinary polyline and a block reference that carry the plugin's note, and also one that does not. Open the Properties palette and Quick Properties. Edit the text value.
14. **What "pass" looks like.** The heading and both rows appear for the objects that carry the note and not for the others (the property list can vary per object); the editable row writes back, with one UNDO undoing it; the rows show in Quick Properties if it is set up for that class; no error line; on a PC without the plugin the palette is unchanged. **If the rows do not appear, the answer is "no" for route 1 and the choice moves to routes 2 or 3.**

---

## E. A live preview inside the plugin window, and the Inspect button

### What Autodesk provides

1. **Draw part of the drawing off-screen and take a picture (graphics system: off-screen device, view, snapshot).** A device made for off-screen drawing is created from the graphics manager; a view on it is told what to draw and how big; a snapshot of a rectangle returns an ordinary bitmap for a WPF image. The 2027 reference lists the off-screen device call and the snapshot call on both device and view.
   Source: Manager.CreateAutoCADOffScreenDevice, View.GetSnapshot, Device.GetSnapshot, Managed API reference (2027), read on this PC. Sure: high.
2. **What the office already proved on this PC (15 Sep 2026, a block preview).** The "render to image" call throws on 2027 and leaves the view unusable; the snapshot call works. The 2D kernel option does not exist in 2027; the 3D one works. Only the off-screen device renders; the on-screen one gave a blank. The block must be appended to a scratch drawing's model space first, or its dynamic properties silently stay at defaults. Frame on the visible parts, not on the block's reported extents (a constant 1900 x 1900). In the headless engine the graphics manager is null: reading it twice kills the process, so read once and skip when null.
   Source: the office's own probe notes PROBE-75 (15 Sep 2026) and the headless probe note. Sure: high for this PC and build; these are measurements, not Autodesk statements.
3. **A saved picture of a block or the drawing:** a block definition's preview icon and the drawing's thumbnail are both readable bitmaps. Both are static and stale as soon as something changes.
   Source: BlockTableRecord.PreviewIcon and Database.ThumbnailBitmap, Managed API reference (2027), read on this PC. Sure: high.
4. **Our own drawing from the facts.** Not an Autodesk feature. The plugin draws the pit, pipe, label and levels itself in WPF from its own facts. Always fast and fully ours; but then it is a model of the drawing, not the drawing, and a second drawing path breaks design rule 1 (one code path per behaviour) unless the real drawing is made from the very same geometry.
   Source: design reasoning; no source. Sure: medium.
5. **Keeping the window responsive while a number changes: Not found.** I found no Autodesk statement on whether the snapshot call can run off AutoCAD's main thread, and no statement of how long it takes. Treat it as main-thread work (the office's own rule is that drawing writes need the document lock). Unknown until timed.
   Source: search of Autodesk's developer guides on this PC (no threading statement found). Sure: low.

### Hiding the window for Inspect

6. **A supported call hides a modal window while the user works in the drawing and brings it back.** "Start user interaction" takes the window (WPF or a handle), hides it, lets the editor take a prompt, and returns focus to the window when the object it returns is disposed. Autodesk's class text: it lets users interact with AutoCAD "from within an application-defined modal dialog". Forum answers advise this over calling Hide and Show on a modal window, which they call a known problem (search summary).
   Source: EditorUserInteraction class and Editor.StartUserInteraction(Window), Managed API reference (2027), read on this PC; search summary of Autodesk forum threads. Sure: high for the call; medium for the advice.
7. **WPF windows can be shown modal or modeless through AutoCAD** (Application.ShowModalWindow and ShowModelessWindow take a WPF window in 2027). Autodesk's guide says to use these rather than the form's own ShowDialog, "which may result in unexpected behavior". A modeless window must lock the document before it changes the drawing.
   Source: Application.ShowModalWindow and ShowModelessWindow, Managed API reference (2027); Extend the AutoCAD User Interface (.NET) and Lock and Unlock a Document (.NET), Managed Developer's Guide (2027), all read on this PC. Sure: high.
8. **Can the user pan and zoom while the window is hidden?** Autodesk says nothing. A forum title ("unable to pan and orbit while run from modal dialog") suggests it may not work from a modal window; I did not open it. Unknown until trial.
   Source: search-result title only. Sure: low.
9. **"With everything typed still there" is easy:** the same window object is only hidden and shown, so nothing typed is lost. What may change is the view of the drawing (the user's pan and zoom); whether to put the view back is a design choice.

### How it would be used here (leaning, to be proven)

10. **Preview from a snapshot of an off-screen view of a copy of the thing in a scratch drawing** (the method the office already proved for a block), redrawn only when a fact changes, at a size matched to the box, with the background set from AutoCAD's theme. Fall back to our own WPF sketch if the snapshot is too slow while a number is being typed. Inspect uses the hide call with a one-line prompt ("Pan and zoom, then press Enter"), then returns to the window.
    Source: items 1, 2 and 6 put together. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

11. **What to do.** In a test command, open an 80 percent WPF window with a preview box and a number box. Feed the preview from a snapshot of a scratch drawing holding a copy of a pit and two pipes at their real sizes; redraw on every keystroke in the number box. Time the redraw at 1920 x 1080 and 2560 x 1440, on the owner's laptop and desktop screens, in light and dark themes. Add an Inspect button that hides the window with the call in item 6, asks for Enter at a prompt, and returns. During the prompt try pan, zoom and a window-pick.
12. **What "pass" looks like.** The preview follows each keystroke without the number box lagging (target set in the Speed trial; as a first mark, key presses never queue up); the picture is crisp and the right way up at both sizes; background matches the theme; Inspect returns with every box unchanged and the preview refreshed; pan and zoom work during the prompt (if not, the result says so and a modeless route is tried); a second use of Inspect works; AutoCAD does not hang or lose focus; closing the window with Cancel leaves the drawing untouched.

---

## F. A ribbon tab that appears on selection, and button tips with the typed name

### What Autodesk provides

1. **AutoCAD's own mechanism is rule-based.** A contextual tab state is a named rule. In AutoCAD 2027's own program files a rule is a short true-or-false expression kept in a rules file (named `...ContextualTabSelectorRules.xaml`). It lists the tabs to show, whether to bring the tab to the front, a theme, and what triggers it (a change of selection, or a system variable). AutoCAD compiles all rules it finds into one small program kept in the user's own roaming folder, and re-compiles when a rules file is newer. The expression may look at the current selection, the running commands and system variables, and may call the plugin's own code. A rule that fails is skipped silently.
   Source: decompiled copy of AutoCAD 2027's window files (the Ribbon rule classes and the tab evaluator), read on this PC. Sure: medium (it shows what the shipped program contains; not seen running; Autodesk does not describe it on a page I could open).
2. **Where AutoCAD looks for rules files.** Its own folder, the language folder, the vertical's folder, and any file registered under a per-user registry key named `Loaded\#ContextualTabRules`.
   Source: same decompiled files. Sure: medium.
3. **A bundle can carry the rules file.** Autodesk's component reference for the bundle's PackageContents file lists a file type "Xaml" and says the XamlType must be "ContextualTabRule", and that the file using it must be listed after it.
   Source: Components Element Reference, help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-3C25E517-8660-4BB7-9447-2310462EF06F.htm (2025). Sure: high.
4. **The older way (2011) put a DLL and a rules file in AutoCAD's own folder, with the maker's registered prefix on both names.** An Autodesk engineer's blog says so, and warns to keep an eye on interactive speed because the rule runs on every selection change. This is superseded by item 3.
   Source: Displaying an AutoCAD ribbon tab contextually using .NET, Through the Interface, keanw.com/2011/10/displaying-an-autocad-ribbon-tab-contextually-using-net.html (7 Oct 2011). Sure: medium.
5. **How the tab is shown.** The 2027 reference names three display types for a contextual tab: Full (its own tab), Merged (folded into another tab) and FullWithoutFocus (its own tab; the page does not say what "without focus" means, though the name suggests the tab does not take the front). 
   Source: ContextualTabDisplayType enumeration, Managed API reference (2027), read on this PC. Sure: medium (what the third means is Unknown).
6. **A tab is also a live object the plugin can show and hide itself.** The ribbon tab class has "is visible", "is contextual tab", "is merged contextual tab" and a theme. A plugin could add a tab at start and flip its visibility from a selection-changed event.
   Source: RibbonTab class in AutoCAD 2027's own ribbon file, decompiled copy read on this PC. Sure: medium that the properties exist; Unknown how AutoCAD's own tab manager reacts to a plugin flipping them (workspace switch, reset).
7. **Speed.** The rule runs at every selection change. The owner's R-001 notes the user setting "Object Selection Maximum for Contextual Tab Display" which skips big selections.
   Source: R-001 A.8; the 2011 blog (item 4). Sure: medium.

### Button tips with the typed name

8. **A button tip has a field for the typed command.** The ribbon tip class has Title, Content, expanded content, expanded image, expanded video, a "Command" text, a "Shortcut" text and a "Mouse" text, and an "is progressive" switch.
   Source: RibbonToolTip class in AutoCAD 2027's own ribbon file, decompiled copy read on this PC. Sure: high that the fields exist.
9. **How AutoCAD draws the "Command" text, and whether it shows the typed short name like "CD": Unknown.** Nothing read says. A button made through the plugin's own menu file takes its tip from that file; not read.
   Source: none. Sure: low.

### How it would be used here (leaning, to be proven)

10. **Make the permanent tab and the come-and-go tabs in the menu file (CUIX) carried in the bundle, with one rules file for the three or four selection rules, listed in the bundle's PackageContents.** The rule expression is only a quick check of the note on the selected object (kept in extended data, A item 18). Each button's tip fills Title, Content and Command with the typed name.
    Source: items 1 to 3, 8. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

11. **What to do.** A test bundle in the per-user folder with a one-tab menu file, a rules file and one rule that shows the tab when exactly one polyline carrying the plugin's note is selected. Select it, deselect it, select two, select a plain polyline, switch workspace while the tab is showing, start and finish a command with it selected (so the Hatch-style behaviour is seen), restart AutoCAD. Fill the button's tip with a title, a sentence and the command text "CD".
12. **What "pass" looks like.** The tab appears within a blink of selecting the plugin's polyline, only then, and goes when deselected; it does not steal the front tab from what the user was doing if the rule says not to; it survives a workspace switch and a restart; the rules file recompiles at most once after an update and a failed rule hides only its own tab; on a PC without the plugin the rules file is simply absent and nothing shows. The tip shows "CD" in the form the owner wants (to be shown to the owner as a screenshot); if AutoCAD does not show the Command text, the tip's content carries it instead.

---

## G. Typed names: a full command name plus a short name

### What Autodesk provides

1. **One tool can carry more than one name.** The command attribute allows more than one on the same method (the 2027 file says repeated use is allowed), with a global name, a local name and a group. So the long name and the short name are both just commands pointing at the same method.
   Source: CommandMethodAttribute, Managed API reference (2027); the attribute's own file in the decompiled copy of AutoCAD 2027's core file (AllowMultiple = true), both read on this PC. Sure: high.
2. **A short name defined as a command needs no change to the user's alias file.** The alias file (acad.pgp) is never touched.
   Source: item 1 and item 3. Sure: high.
3. **What wins when two things have the same letters.** Autodesk's search order for a typed name: pressing Enter repeats the last command; then built-in commands; then commands defined by the display and device drivers; then **external commands listed in the alias file (acad.pgp)**; then commands defined by AutoLISP, ObjectARX and Managed .NET applications; then system variables; then aliases, AutoCorrect entries and synonyms from the alias file (and then the search restarts with the expanded name). So **a plugin command beats a user's ordinary alias**, but a built-in command name beats the plugin, and an "external command" line in the alias file beats the plugin.
   Source: About File Organization (Command Search Procedure), help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-25616676-EFF2-4060-A06F-19112622A78B.htm (2025). Sure: high.
4. **Forum reports match this.** Users report that a LISP-defined command overrides their alias so the alias "does nothing".
   Source: search summaries of a CADTutor thread and an Autodesk forum thread. Sure: medium.
5. **Duplicate alias lines in the alias file: the last one wins.** (Autodesk blog, search summary; the page refused.)
   Source: Becoming More Efficient with Command Aliases, autodesk.com/blogs/autocad/becoming-more-efficient-with-command-aliases/ (search summary). Sure: low.

### Traps

6. **The owner's own alias file has C = Copy, Q, Div, Ds and about 50 more (R-001 E.5).** A plugin command named C would silently replace that alias, so typing C would start the plugin's tool, not copy. The same for IO and RC against Autodesk's own aliases. It is a choice for the owner, not a bug (R-001 recommendation 7). The new fact here: the replacement is silent, and nothing warns the user.
7. **Same name in two loaded add-ons.** The first loaded keeps the name for the session (the office's own probe note from September: a rebuilt plugin loaded beside the old one did not rebind the name).
   Source: office's own probe notes. Sure: high for this PC.
8. **The built-in command list is not exposed by any call I found.** Not found: a documented .NET call that lists every built-in command name. R-001 checked 613 names from AutoCAD's menu file against the plan, which is not the full list.

### Detecting a clash at start-up

9. **A start-up check that reads, and never writes.** (a) Find the alias file with the support-path search call (HostApplicationServices.FindFile for "acad.pgp"); read it and also Autodesk's standard one in the AutoCAD folder; split each line into alias and command. (b) Compare each short name the plugin ships with every alias in both files. (c) Compare with a list of built-in names shipped with the plugin and rechecked on each AutoCAD release. (d) On a clash, tell the user once, in plain words ("In your alias file C means Copy; the CE tool C replaces it. Type CE-CIRCLE ...") and offer the long name; never edit the user's file. **Whether a second, user-profile copy of the file takes over from Autodesk's, and how AutoCAD merges them, is Unknown** (R-001 found both on this PC).
   Source: HostApplicationServices.FindFile, Managed API reference (2027), read on this PC; R-001 E.1 and E.5. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

10. **What to do.** A test plugin with one method carrying a long name and a short name that equals a user alias (set up in a scratch copy of the alias file), another that equals a built-in alias only, one that equals an "external command" line, and one that equals a real built-in command. Type each at the command line, from the ribbon button and from a script. Run the start-up check and print what it finds.
11. **What "pass" looks like.** The short name runs the plugin where Autodesk's order says it should and the user's alias is dead; the external-command line and the built-in win where they should (so the order in item 3 is confirmed on 2027, not only on the 2025 page); the start-up message names every clash and nothing in the user's file changes (compare file hash before and after).

---

## H. Double-click opening the plugin's window

### What Autodesk provides

1. **AutoCAD's own double-click list is by object type.** Each action names a DXF type (Polyline, Text, Insert and so on) and a command to run. "If a double-click action for an object is overridden, the new action takes precedence, and the old action becomes inactive." The .NET menu-file classes (DoubleClickAction, DoubleClickCmd) can set this from code. There is no way on those pages to say "only for objects that carry my note".
   Source: Double-click Action Customization (.NET), Managed Developer's Guide (2027), read on this PC; About Customizing Double Click Actions, help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-9171FB64-3BA3-4945-8A50-42D0901A0C4C.htm (2025). Sure: high.
2. **Behaviour with several customisation files defining the same object type, partial CUIX behaviour, and the DBLCLKEDIT system variable: Not found** on the 2025 page.
3. **The application can listen.** The application-level double-click event exists in 2027 and its data holds only the click point. It cannot cancel anything.
   Source: Application.BeginDoubleClick, Managed API reference (2027); BeginDoubleClickEventArgs in the decompiled copy of AutoCAD 2027's core file, both read on this PC. Sure: high.
4. **A published workaround.** An independent developer's blog (2012): listen to the event; read the implied selection to find the one selected object; if it is wanted, veto AutoCAD's own command when it tries to start (document-lock-mode-changed event, veto), then in the veto-follow-up event put the object back in the selection and start the custom command by sending its name to the command line. Stated limits: the veto only fires when a default action exists for that object type; single-object selections only; blocks with attributes caused selection problems.
   Source: custom double click action using Application.BeginDoubleClick, knowledge-autodesk.blogspot.com/2012/12/custom-double-click-action-using.html (27 Dec 2012). Sure: medium.
5. **That workaround breaks one of Autodesk's own event rules.** The guidelines say not to send text to the command line from an event handler (B item 2). So, even if it works, it is the kind of thing Autodesk says may cause "serious problems".
   Source: Guidelines for Event Handlers (.NET) (2027) and the blog in item 4. Sure: high for the rule; medium for the conflict.

### How it would be used here (leaning, to be proven)

6. **Recommended order of trial:**
   1. **Route 1 (menu-file route).** Replace the double-click for the three types the plugin uses (Polyline, Text, Insert) with a plugin command that checks for the plugin's note. If present, it opens the plugin's window. If not, it passes on to the original AutoCAD command (PEDIT, TEXTEDIT or the block editor). The cost: the plugin must reproduce what AutoCAD does by default for each type it takes over, including attributed blocks.
   2. **Route 2 (the published veto route).** Only if route 1 is too wide, and only after seeing it work on 2027 with real attributed blocks.
   3. **Route 3 (no double-click).** The window opens from Properties' own place or a right-click entry, which the plan already allows (UI_PLAN section 1, item 3).
   Source: items 1 to 5. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

7. **What to do.** A test bundle with route 1. A polyline that carries the note, one that does not, text with and without, a block with attributes with and without, a dynamic block, an Xref, a polyline inside a block being edited in place, a locked layer. Double-click each; also double-click with two objects pre-selected. Remove the bundle and repeat on a PC without the plugin.
8. **What "pass" looks like.** The plugin's window opens only for objects that carry the note; every other object opens what plain AutoCAD opens, exactly (compare with a PC without the plugin); a locked-layer or Xref object is not silently changed (AGENTS native-protection rule); Escape and Cancel leave nothing changed; no error line.

---

## I. One-click update with no administrator rights

### What Autodesk provides

1. **The per-user bundle folder.** Autodesk's folders: the general install folder under Program Files, an all-users profile folder, and `%APPDATA%\Autodesk\ApplicationPlugins` for the single user. Autodesk's text recommends Program Files but says nothing about the rights each needs (Not found). A forum white paper (search summary) says the per-user folder "requires lowest user administrative rights".
   Source: About Installing and Uninstalling Plug-In Applications, help.autodesk.com/cloudhelp/2025/ENU/AutoCAD-Customization/files/GUID-5E50A846-C80B-4FFD-8DD3-C20B22098008.htm (2025); search summary of the Autoloader white paper (page refused). Sure: high for the folders; medium for the rights.
2. **Trust.** Plugins in the Program Files folder are trusted and not checked for a signature. Every other bundle folder must be trusted in the AutoCAD options and should be digitally signed; each custom program file is checked and the user is warned for a missing or invalid signature. Secure mode (SECURELOAD 1 or 2) loads code only from trusted paths (TRUSTEDPATHS).
   Source: same 2025 page. Sure: high. So a per-user bundle needs either a trusted folder entry or a signature on every file; the office's notes record that a release signing key exists.
3. **When bundles load.** At start-up AutoCAD checks the folders and registers and loads what it finds; a bundle installed during the session is registered by default; the load setting "LoadOnAppearance" loads it when it appears with no restart; APPAUTOLOAD set to 0 loads nothing unless APPAUTOLOADER is used.
   Source: same 2025 page; Components Element Reference (2025). Sure: high. The other APPAUTOLOAD values: Not found.
4. **The PackageContents file.** Each component names its file (relative to the bundle), its type, and when to load (at start-up, on a command, on appearance). Components load from the bottom of the list upward, so dependencies go lower down. A run-time requirement (series min and max) stops a build made for one AutoCAD from loading into another; if the maximum is left out the Autoloader loads it anyway "even though .NET API changes can crash the app".
   Source: Components Element Reference (2025); AutoCAD 2025: Update Your PackageContents.xml with RuntimeRequirements, blog.autodesk.io/autocad-2025-update-your-packagecontentsxml-with-runtimerequirements/ (2024). Sure: high.
5. **The bundle can carry the menu file, rules file and the code** (component types: .NET code, menu file, XAML rules file and more).
   Source: Components Element Reference (2025). Sure: high.

### What cannot be replaced while AutoCAD runs

6. **A loaded plugin file is locked.** Forum users (search summary) say a loaded DLL cannot be rebuilt over or overwritten; one workaround loads the file as bytes. Dependencies must sit beside the plugin from AutoCAD 2025 on (.NET 8).
   Source: search summaries of Autodesk forum threads (e.g. "How do you deal with .net assembly locking"). Sure: medium.
7. **Windows lets a file in use be renamed, though not overwritten or deleted.** Microsoft's text: a DLL in use can be replaced by renaming it (in the same folder), copying the new one in, and scheduling the old one's deletion for restart; programs keep using the old one until they unload it.
   Source: Dynamic-Link Library Updates, learn.microsoft.com/windows/win32/dlls/dynamic-link-library-updates (undated). Sure: high.
8. **.NET can unload code only in a special load context.** Unloading works through a collectible load context and is "cooperative": it finishes only when nothing outside still holds the code, its types or its threads. C++/CLI parts are not supported. **Not found: any Autodesk statement that AutoCAD supports unloading a plugin.** The default load context (where AutoCAD puts a loaded plugin) cannot be unloaded.
   Source: How to use and debug assembly unloadability in .NET, learn.microsoft.com/dotnet/standard/assembly/unloadability (undated). Sure: high for the .NET facts; low for AutoCAD behaviour.
9. **The rules file compiled into the user's roaming folder and the menu file are also in use** while AutoCAD runs (F item 1). Whether AutoCAD holds the menu file open: Unknown.

### How it would be used here (leaning, to be proven)

10. **A small loader that never changes; real code in numbered folders; a pointer file.** The bundle holds the PackageContents, the menu and rules files, and one tiny loader. The loader reads a one-line pointer file at start-up, loads the real plugin and every one of its companion files from that version's own folder, and writes "started OK" when the first command is ready. **Update:** write the new version into a new folder (never into the running one), check every file's hash, then change the pointer (write to a temp name and rename). It takes effect next start; the running session is untouched. **Rollback:** if the new version fails to load, the loader marks it bad, loads the previous one and says so in plain words; keep the last two versions and delete older ones only after a good start. All of the plugin's files for one version load from the same folder, so "first loaded wins" cannot mix versions (the office's note on the shared-assembly rule).
    Source: items 1 to 9 put together; the office's note on the shared-assembly rule. Sure: medium (my design; each piece is sourced, the whole has not been tried).

### Small trial that would prove it in real AutoCAD 2027

11. **What to do.** A test bundle in the per-user folder with the loader and a version 1.0 of a tiny plugin. Start AutoCAD, run a command, then (AutoCAD still running) stage 1.1 beside it and flip the pointer. Check the running session. Close and start: version 1.1. Stage a deliberately broken 1.2: start again. Repeat as a standard user with no administrator rights, with SECURELOAD at 1, with the folder not trusted, with unsigned and then signed files, with a second AutoCAD window open during the update, and with the bundle appearing while AutoCAD is already running (LoadOnAppearance).
12. **What "pass" looks like.** Copying and flipping work with no administrator prompt; the running session never errors or locks up; the next start runs the new version and reports it; the broken version falls back to 1.1 with a one-line message and the pointer is marked bad; no version-mixing error appears; the trust prompt, if any, appears once and is the plain one the user can answer; a rollback by hand is one pointer change.

---

## J. Testing without a person: the headless engine

### What Autodesk provides

1. **The headless engine (accoreconsole) runs the AutoCAD core with no window.** It opens a drawing, runs a script, and supports AutoLISP, .NET assemblies and ObjectARX modules built for it. Switches: input drawing, script, product, language, read-only, profile, isolate (a separate user-data folder) and load-module.
   Source: AutoCAD Core Console, help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core-Console/files/AUTOCAD_CORE_CONSOLE.html (2026). Sure: high.
2. **What it cannot do.** Commands that open a dialog or palette (Autodesk lists, among others, PROPERTIES, LAYER, RIBBON, CUI, QUICKCALC, PAN, RTPAN, RTZOOM, NEW, CLOSE, PASTECLIP, OBJECTSCALE; the list is "a subset"); the ActiveX interface; any plugin code that uses the AutoCAD user-interface library (the UI file AcMgd.dll "could crash" the console); WPF and MFC windows; the ribbon. Plugin code must stay in a trusted location.
   Source: same page. Sure: high.
3. **Plugin rules from Autodesk's developer team.** For headless use the plugin may reference only the database and core files (AcCoreMgd, AcDbMgd). Loading a plugin by script: turn secure loading off, NETLOAD the file, run the command. A bundle can also be loaded with an undocumented switch, always with a separate user-data folder.
   Source: autocad-net-api skill (copied from the ADN-DevTech acad-api-skill, MIT, 2026), on this PC. Sure: medium.
4. **No grips, no selection by pointing, no pan or zoom.** Follows from item 2 (no palettes, no view commands).
5. **Plotting.** The Autodesk page says nothing about plotting. A release-note line in a search summary says publishing from the console uses software rasterising only. **On the owner's PC the plotter folder setting points at a missing folder, so plotting cannot be proven headless on this PC today.** Research cannot fix that; it is a setting on the PC.
   Source: the owner's note; search summary of the AutoCAD LT 2026 known issues page (not opened). Sure: low for the rasterising line.
6. **What the office has already learned on this PC.** The headless engine cannot start while the full AutoCAD is open (a machine-wide lock). The plugin's own start-up must be skipped or it writes to the live log, settings and outbox (23 Sep 2026 correction). The graphics manager is null (read twice kills the process). The idle event never fires, so anything done on idle is not exercised. Run from Git Bash only with path conversion off.
   Source: the office's own probe notes (accoreconsole plugin probe, Sep 2026). Sure: high for this PC.

### What therefore still needs the full program

7. **Needs the full program:** the ribbon and contextual tab; grips (pick, drag, menu); the Properties palette and Quick Properties; double-click; the live preview and Inspect; the plugin's window as seen by the owner; idle-time behaviour and its undo step; the screen look in the dark theme; the real printed sheet; Xref and locked-layer behaviour as the user sees it; and the first-run trust prompt.
8. **Can be done headless (so should be):** the brain (facts, sums, checks, standards); the hands (reading and writing the notes and records, copying, wblock and insert round-trips, undo through scripted commands); the events and overrules IF a scripted MOVE, COPY and MIRROR fires them (Unknown; the first new trial in the closing section); drawing-output geometry checks (coordinates, layers, text content). Trial J below tests that.

### Small trial that would prove it in real AutoCAD 2027

9. **What to do.** A test plugin referencing only the core and database files. Script a drawing with a pit and pipes; run MOVE, COPY, MIRROR and UNDO by script commands with typed coordinates; log which events and overrules fire (object modified, transform overrule, object overrule close). Also script WBLOCK and INSERT, and read facts back.
10. **What "pass" looks like.** The log lists every event in a repeatable order and the final coordinates match; the same script run in full AutoCAD gives the same log (so a headless pass predicts a full pass for the same commands); anything that differs is listed as "needs the full program".

---

## K. Working things out in any direction ("hold what is fixed, the rest is worked out")

### What is established

1. **The technique is called local propagation (constraint propagation from known values).** Write each sum so it can be solved for any one of its facts. Start from the held facts. Wherever a sum has exactly one fact unknown, work that one out, mark it "worked out" with the sum and the facts it came from, and repeat until nothing new appears. User-interface toolkits have done this since the 1980s (ThingLab, DeltaBlue: Sannella, Maloney, Freeman-Benson and Borning, 1993).
   Source: DeltaBlue and local propagation, constraints.cs.washington.edu/deltablue (the project's page); the 1993 paper cited there. Sure: high.
2. **Over-held (too many fixed to all be true) is found when a sum has every fact known and does not balance within a tolerance.** The report names the sum and the held facts that lead each side to its value (so the message can say "too little cover at P4 by 0.06, because the outlet invert and the grade of P5 and P4 are held"). Recording which facts each worked-out fact came from is the idea of a justification record in a truth-maintenance system (Doyle, 1978 to 1979; de Kleer, 1986), whose use is to find the statements responsible for a contradiction.
   Source: Reason maintenance, en.wikipedia.org/wiki/Reason_maintenance (read). Sure: medium (the idea transfers; the page does not describe a drainage use).
3. **Under-held (not enough fixed) shows up as a stall:** facts still unknown and no sum with a single unknown. The answer to the user is "hold one of these to finish". A more thorough check matches sums to facts so each sum is used for one fact (the Dulmage-Mendelsohn split); the page says it has been used to find specified, underspecified and overspecified sets of equations, and Modelica tools use the same split.
   Source: Dulmage-Mendelsohn decomposition, en.wikipedia.org/wiki/Dulmage%E2%80%93Mendelsohn_decomposition (read); search summary of a Modelica conference paper (BLT). Sure: medium.

### Known limits

4. **Loops.** Local propagation cannot solve a set of sums that depend on each other in a circle (simultaneous equations): the DeltaBlue project says it "cannot handle cyclic constraints", and its authors moved on to other solvers. A tree (a branched run with no loops) is safe; a looped network or a sum that needs the answer it is trying to produce (for example flow depending on the depth that depends on flow) is not.
   Source: constraints.cs.washington.edu/deltablue; search summary of the SkyBlue and DeltaBlue reports. Sure: high.
5. **Propagation can miss a contradiction** (it is "incomplete in general") and cannot choose between several possible answers; it only follows what is forced.
   Source: Local consistency, en.wikipedia.org/wiki/Local_consistency (read). Sure: medium.
6. **One-way sums.** A "smallest of the incoming levels" rule at a junction, a lookup of the next pipe size from a list, and a rounding rule cannot be turned round; they stay one-way and the user can only hold their outputs, not work backwards through them. (My reading of the technique; not a source statement.)
7. **Inequalities are checks, not sums.** Minimum cover, minimum grade and maximum velocity are tested after the working-out and shown by the status words; they never drive it. This matches FOUNDATION block 6.
8. **Rounding.** Held values are typed to the nearest millimetre; "balance" needs a tolerance the owner sets in Settings.

### How it would be used here (leaning, to be proven)

9. **Write the solver as pure code with no AutoCAD in it, with the sums in one list (SUMS.md).** The window, the palette and the label read only the result. It can be tested in seconds on made-up data.
   Source: FOUNDATION three-layer rule; items 1 to 8. Sure: medium (recommendation).

### Small trial that would prove it in real AutoCAD 2027

10. **What to do.** No AutoCAD needed for this one. A made-up branched run of 20 pits and three branches. Hold sets: (a) the outlet invert and every grade; (b) the outlet invert plus the upstream invert at every dead end; (c) a deliberately conflicting set; (d) a set missing one fact; (e) a looped pair of branches. Time the working-out for 200 pits.
11. **What "pass" looks like.** (a) and (b) agree with a hand calculation to 1 mm and with each other where they overlap; the answer does not depend on the order the sums are visited; (c) names the sum, the facts and the amount; (d) names the facts to hold; (e) is reported as "cannot be worked out here" within a set step count, never hangs; 200 pits finish well under a second.

---

## L. Fact check: AS/NZS 3500.3 inspection openings (where required, maximum spacing)

1. **The standard's own text could not be read.** The two copies on the open web were unreadable (an encrypted PDF) or an old edition (2003) whose excerpt did not include the clause. I did not try to get around the encryption.
2. **Where the clause is.** The store listings for the 2025 edition (published April 2025) show a heading "7.4 Inspection openings" with sub-clauses for location, size, access and plugs or caps, and "7.7 Junctions"; the 2003 edition's contents list it at 8.5. A regulator page says the 2025 edition applies to plumbing work from 20 October 2025. **The location sub-clause is the one that would give the spacing.**
   Source: store.standards.org.au listing for AS/NZS 3500.3:2025 and the 2003 contents, from search summaries (listings only); a Victorian regulator page (refused; search summary). Sure: medium for the clause numbers; low for the start date.
3. **Spacing: Not found for stormwater.** **Secondary sources only, none for this question:** a Western Australian government guide gives 30 m between inspection openings on **sanitary** drains under part 2 of the same series (not stormwater, not part 3); a New Zealand exam-prep page gives 50 m between rodding points and 100 m between access points under the New Zealand acceptable solution (another country and another document). Neither answers the Australian stormwater question. Not for use in the plugin.
   Source: search summaries only. Sure: low.
4. **Where inspection openings are required:** the owner's own records say: council checklist item 6.3 (no pipe bends or junctions under pavements without an inspection opening or a pit "per AS3500"), and the office's guidebook card GB-04 ("inspection openings at every change of direction"). These are the office's and one council's words, not the standard's.
   Source: `02_COUNCIL_RULES\COUNCIL_MONASH_CHECKLIST.md` line 46; `04_REFERENCE\guidebook-cards\GB-04_READY_TO_SUBMIT.md` line 17 (read on this PC). Sure: medium for what they say.
5. **What this means.** Do not hard-code a figure. Put it in Settings as "Inspection opening spacing" with the standard and council as sources, empty until read from the standard (rules R-00 and 12.2: Unknown stays Unknown). The owner or the office can read the clause in the 2025 edition once and type it in.

---

## What this means for the four trials

The four trials in `BUILD_APPROACH_DRAFT.md` stand. These findings change what each must include, and add new ones.

1. **Trial 1, Joins.** Add: EXPLODE, BLOCK, WBLOCK, COPYCLIP and PASTECLIP, INSERT, Xref bind, -PURGE with registered applications, and AUDIT (A trial). Test three ways of storing a join (handle in extended data; soft pointer; hard pointer) because Autodesk says handles in extended data are translated "in some cases but not in others" and warns about hard pointers in WBLOCK. Compare two ways of moving joined ends (events plus end of command; close hook on the plugin's own objects) for undo as one step (B trial). **New fact the trial must settle:** the 2027 .NET kit has no "all transactions ended" event, and edits made at idle become their own undo step.
2. **Trial 2, Grips.** Add: what the drag copy carries (does the note travel?), the multi-mode menu helper, hiding built-in grips, and that grips do not run for MOVE (C trial). The trial is more likely to pass than the draft feared, because the .NET kit has multi-function grip menus.
3. **Trial 3, No plugin.** Add AutoCAD LT (needs a copy; Unknown), saving to an older format, and the case where an outsider moves a pit with no plugin loaded: with no event running there, the only way to "report what changed" on return is a stamp of the geometry kept in the note and compared at open. That is a design change to the note, not just a trial step: **store a position stamp with the note.**
4. **Trial 4, Speed.** Add: the overrule filtered by the plugin's name versus unfiltered, the drag-copy cost, how often the drawing-wide modified event fires, and snapshot time for the preview (E trial).

**New trials needed (each described above; none run):**

5. **Trial 5, Properties.** Does the .NET property list reach the Properties palette (D)? **This one can change the build approach**: if it fails, the choice is our own side palette or a thin C++ helper, which touches the "no hand-built C++" line.
6. **Trial 6, Window, live preview and Inspect** (E). UI_PLAN section 9 already calls it a Stage 4 trial.
7. **Trial 7, Ribbon selection tab, tips and typed names** (F and G): the rules file in the bundle, the Command text in tips, and the clash check at start-up.
8. **Trial 8, Double-click** (H).
9. **Trial 9, Update, trust and rollback** (I): per-user folder, trusted path or signing, loader and pointer file.
10. **Trial 10, Headless predicts full** (J): do events and overrules fire for scripted commands in the headless engine; if yes, much of trials 1 and 4 can run unattended.
11. **Trial 11, Any direction** (K): pure code, no AutoCAD, can start at once.

**What did not change:** the three-layer split (brain, hands, face) fits the headless rule that plugin code the engine loads may not use the UI file; the "ordinary objects with notes" idea is supported by Autodesk's own words (AutoCAD keeps notes it does not use).

## Corrections and additions to R-001

1. **Command search order (R-001 E.2).** The search has one more step before plugin commands: external commands listed in the alias file (acad.pgp). R-001's claim stands for ordinary aliases, which come after plugin commands, but a user's external-command line beats a plugin command. (G item 3.)
2. **The "Merged" display (R-001 A.7).** The 2027 reference names three: Full, Merged and FullWithoutFocus. The meaning of Merged is still Unknown on screen. (F item 5.)
3. **The 2011 contextual-tab route (R-001 A.10)** is superseded by a rules file carried in the bundle (F item 3). **D.1 and D.10 in R-001** ("how it is done in 2027: to be proven") now have a candidate: the .NET property list, still unproven for the palette (D item 2).

## Not found

1. **Autodesk statement of how the Properties palette reads extra properties from .NET** (D item 3), and whether Quick Properties and roll-over tips can show the plugin's facts (D item 7).
2. **An "all transactions ended" event in the 2027 .NET kit** (B item 4).
3. **Whether the MOVE, COPY and ROTATE commands call the transform overrule** (B item 7).
4. **What EXPLODE does to a polyline's notes** (A item 10).
5. **Whether AutoCAD LT keeps and returns third-party notes**: no Autodesk page (A item 12).
6. **A threading rule or timing for the off-screen snapshot** (E item 5).
7. **Pan and zoom while a modal window is hidden** (E item 8).
8. **How AutoCAD draws the ribbon tip's "Command" text** (F item 9), and what "FullWithoutFocus" means (F item 5).
9. **A call that lists every built-in command name** (G item 8); how two alias files are merged (G item 9).
10. **Double-click: behaviour with several customisation files, partial menu files and the DBLCLKEDIT variable** (H item 2).
11. **Rights needed for the per-user bundle folder** (I item 1); the other APPAUTOLOAD values; any Autodesk statement that AutoCAD supports unloading a plugin (I item 8).
12. **The text of AS/NZS 3500.3 clause on inspection openings and any spacing figure** (L).
13. **A crash list for overrules** (B item 12).
14. **Pages that refused or could not be read:** Autodesk's forum (every thread, 403); the Autoloader white paper PDF (sign-in redirect); autodesk.com command-alias blog (403); the Victorian regulator pages (403); two PDFs of the standard (encrypted or text not readable); studylib (429). Everything taken from those places is "search summary only".
15. **Not tried in AutoCAD:** nothing in this note was tried in AutoCAD. AutoCAD was not started.
