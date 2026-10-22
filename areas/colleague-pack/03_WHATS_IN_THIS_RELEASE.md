# What's in this release: CE Civil 3.0 and Manager 1.1

**DRAFT, Thu 22 Oct 2026.** This page is based on the change log at the head of the installed line (Civil 3.0.70 / Manager 1.1.70, 22 Oct).

**How to read it:**
1. **Built** means the change is in your version.
2. **Seen** means the CE robot or Codex watched it work in real AutoCAD on a test copy. Most items have not been seen yet, so each one says which it is.
3. **OFF** means it is in your version but switched off until it passes a test in AutoCAD. Leave it off.

[CHECK] Your old version was probably Civil 2.1.14 from July 2026, so nearly everything in Version 3 is new to you. This page lists the changes you will notice most, not every change. The change log itself does not mark versions after 3.0.65, so the version for each item comes from dates.

---

## 1. Pits and pipes

1. **New Pit, New Pipe, Edit Pit and Edit Pipe are one-page windows** with a picture of the plan. Built, seen on earlier 3.0 builds.
2. **PIT and CD keep placing** until you press Esc. Each pit or pipe is its own Undo step. Built, seen.
3. **One `U` takes back one whole CE action** (a pit with its label and cover text, a pipe with its arrow and level texts). Built, seen.
4. **A blank level stays blank ("Unknown").** The New Pit cover box opens empty. CE never makes up a level. Built, seen.
5. **Pit numbers stay exactly as you type them.** C2 stays C2. A bare 8 next to an existing P8 is refused, and "C 2" next to C2 gets a warning. Built, seen.
6. **CDEDIT edits a downpipe (DP1)** in a small "Edit source" window: the tag, show the tag label, remove the tag. Built 20 to 21 Oct, not seen. The double-click route does not work yet (page 04).
7. **Edit several pipes at once** to one design grade, with a preview and one Undo. Built.
8. **The level cascade** (recalculating downstream inverts) keeps the end you typed, keeps pit drops, and refuses a pipe on a locked layer. Built 18 Oct, partly seen.
9. **A same-plan break in CD** asks for the real total length, and the downstream level follows it. Built 18 Oct.
10. **Step-iron depth:** an old 1000 mm setting moves to 900 mm once only. A 1000 you type on purpose now stays. Built, seen by Codex 21 Oct.
11. **Clicking a CE ribbon button while another command is waiting** now cancels that command first. Before, it typed "CD" into your TEXT. Built 19 Oct.
12. **Copy, paste, rotate and scale** keep pits and pipes linked, and labels follow their pit. Built 18 Oct.
13. **Locked layers are never changed.** CE skips them and names the layer. Built.

## 2. Checks

1. **CDRULES** checks the design rules (grade, cover, speed, pit drop, detention) against your office and council values. "Unknown" means a level is missing, not a pass. Built, seen.
2. **CDCHECKS, the Checks list palette.** One list of findings, with "Show where" zooming to each one. Built. [CHECK: whether it is ON in the shipped set-up]
3. **Plainer wording.** "CE could not check" where a list failed to read, never "Network OK". "Unnamed pipe" instead of a code. FLAT on a level pipe. Built.
4. **A typed maximum pipe velocity (for example 3.0 m/s) stays as typed.** Before, it went back to 6.0 at every start. Built 19 Oct.
5. **Design review reads your office Settings** for grade, velocity and run length. An office minimum cover of 0 no longer passes every pipe. Built 18 Oct.
6. **Downpipes are no longer judged as detention pipes.** A pipe marked Detention with no length reads "not judged" and tells you to enter the length. Tim agreed 20 Oct. Built, wording seen by Codex.
7. **OFF for now:**
   - CDCHECKIGNORE (ignore one finding).
   - Wrong-layer rows.
   - Leaving out pits marked To be removed.
   - A progress line on slow checks.

## 3. Labels

1. **Tidy labels (CDTIDYLABELS)** counts first, moves only after you type Yes, and one Undo takes it all back. It no longer treats the drawing border or a pit's hidden circle as an obstacle. Built. The border and pit fixes were seen by Codex 20 Oct. [CHECK: whether it is ON]
2. **A label with no clear spot is left where it is.** Move it by hand. Tim ruled this on 20 Oct.
3. **A pipe label you moved by hand can stay put.** OFF.
4. **Label and text heights come from Settings** (pipe text, level text, cover text). Built.
5. **Recover Inverts** (in Repair) redraws missing level text and says how many texts it drew. Built.

## 4. Long section

1. **CDPROFILE** has a route review and a readable preview. Built.
2. **Long section fixes:**
   - Each pipe's top line is drawn at its own size.
   - A trench grate with no cover no longer draws the ground at RL 0.
   - A 600 x 600 pit is drawn 600 wide.
   - The frame takes in existing-pipe stubs.
   - The schedule set defaults to the route's pits.

   Built 18 Oct, not seen.
3. **An INVERT DEPTH row** can be added in the office row order. Built.

## 5. Detention and OSD

1. **Office rulings are built in.**
   - Soft-ground runoff C is 0.30 after development.
   - The orifice rounds down to the whole millimetre.
   - Orifice coefficient 0.6.
2. **Kingston:** residential uses a 1 in 5 storage storm, commercial uses 10 years, and there is a Land use field in job set-up. Built.
3. **CDDESIGN job mode** remembers the council, areas and orifice head. Built. **Read page 04 before trusting its storage figure.**
4. **CDTWL and CDRULES read one freeboard value.** Built, seen by Codex.
5. **CDTWL offers the highest pipe top (obvert)** as its usual top water level. Built.
6. **Missing data prints Unknown, never zero.** Calculation pages are stamped DRAFT. Built.
7. **WSUD tab:** the impervious area is limited to the site area. **CDRG** records the true centre of a raingarden. Built.

## 6. Schedules and imports

1. **Pit Schedule (PITSCHEDULE) fixes:**
   - Rows below a merged "DPs" row keep their own sizes.
   - A new inlet stays with its pit.
   - A sheet break carries the pit number across.
   - Names like C1 print in full.
   - A blanked cell stays blank.
   - Moving the drawn table never writes into the pits.

   Built 18 Oct, not seen.
2. **A level typed in the Pit Schedule** reaches the plan, the pipe and the schedule in one Undo. Built.
3. **X-Civil and LandXML import (CDIMPORTXCIVIL)** has a window, about 25 reading fixes, Esc to cancel, and a "check the scale" warning when the units disagree. Built.
4. **Survey (CDSURVEY)** reads levels written as multi-line text, and accepts levels above RL 500 and below 0. Built.
5. **CDTAG and CDFIXTAGS** explain a refused source name in plain words. Built.

## 7. Settings

1. **CDS has tabs, a search box and history for each value.** Built, seen on earlier builds.
2. **New tick boxes on the "Newer tools" and "Fixes" tabs** for each old-fault fix. Unticking one brings the old fault back, so leave them. Built 20 Oct, window not seen.
3. **The Civil settings file is saved safely,** through a copy beside it. A locked file is never overwritten with standard values. Built 19 Oct.
4. **Reset Civil in CEMANAGER resets only what that page shows.** Built 19 Oct. Do not use Reset in week one.
5. **A fresh install behaves like Tim's PC** (same starting switches). Built 24 Sep. [CHECK: re-confirm against Tim's settings at the freeze]

## 8. Manager, install and version

1. **CE Tools > Version works without Structural.** The Version command moved into Manager (Tim, 20 Oct). Built.
2. **CEHEALTH** checks that Civil and Manager match. **CESUPPORT** makes a support zip with coded names that never uploads by itself. Built, seen.
3. **Installer safety fixes:**
   - Manager's own receipt no longer blocks an update (BUG-823).
   - The pipe-object file no longer blocks Civil (BUG-824).
   - An older build gets a warning, and one older than the office approved is refused (BUG-834).

   Built 19 to 20 Oct, **not used for your install yet** (page 02).
4. **A failed Civil update no longer lets Manager update alone.** Built.
5. **Privacy:**
   - Logins and PC names are coded in reports.
   - The "AI features" master switch is OFF.
   - The old Azure upload code is removed.
   - The ribbon click log no longer records drawing names.

   Built.

## 9. Other

1. **Help Centre (CDHELP)** describes Version 3, with a first-run Start Here tour and F1 help in CE windows. Built.
2. **Selecting a pipe, pit or source** opens its own ribbon tab. Built.
3. **Crash fixes:** closing a saved drawing, and Manager windows that closed or locked AutoCAD. Built, seen.
4. **Every old typed command name still works.** Built.
5. **CE writes one log line for each command that ends.** This helps Tim read your logs. Built 21 Oct. The line can wrongly say "cancelled" for a pit or pipe placed and finished with Esc (page 04).
