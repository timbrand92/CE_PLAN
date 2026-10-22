# Driver v3 phase 1: pointer actions, window reading and safe lifecycle (Fri 23 Oct 2026, built Thu night 21:31 to Fri 01:25 Melbourne, Team, Sonnet)

Job: desk plan/03, `tester_run48_driver_v3_phase1`. Contract: `TESTING_REBUILD_SPEC_2026-10-22.md` sections 1, 2 and 6 phase 1. Real AutoCAD 2027 on Civil 3.0.70, Structural 1.0.121, Manager 1.1.70 (read from the About window), test copies only.
**Four words: built and self-tested by the builder in real AutoCAD, twice. Installed (it is a test tool). Not reviewed by Opus. Not Tim-accepted. No CE bug was raised or fixed.**

## ANSWER FIRST

1. **Item 1, UI Automation fix: PASS.** A fresh `pwsh` process loads UI Automation (type loaded, desktop root readable). `ui-dump` listed 22 controls of About CE Suite, 80 of the Settings window (CDS) and 37 of the Checks palette (CDCHECKS). Each was closed by `ui-press`: About by its **Close** button, Settings by **Cancel**, the Checks palette by **Close**. Each reported "window closed = True" and AutoCAD was idle afterwards. The robot that could not close About now can. The Settings window was only opened after `settings-temp arm`; no key was pressed in it.
2. **Item 2, pointer actions: PASS.** `pt-click`, `pt-dblclick`, `pt-rclick`, `pt-hover`, `pt-drag` are built. Only click, double-click were exercised in AutoCAD (see "not tested"). Calibration at three zoom levels and after a pan: **maximum pixel error 1.22 px** (limit 2). Click on the circle line selected exactly the circle every time (4 of 4). Click on the circle's centre (empty) selected nothing every time (4 of 4).
3. **Item 3, first real use (BUG-859 data): PASS as a measurement, and the answer is bad news for #1499.** On Civil 3.0.70 a double-click on the downpipe DP1's outer circle, its centre and its angled DP text, and on the pit label P3, **all four open AutoCAD's own "Enhanced Attribute Editor". None opens CE's "Edit source" window.** Each window was dumped and closed with Cancel. This is what the BUG-859 diagnosis predicted for the installed build (fix is in draft PR #1520, not installed).
4. **Item 4, safe lifecycle: PASS.** `session-run throwaway` started and ended AutoCAD cleanly three times in a row, and the same again inside each full self-test: no `acad.exe` left, lock free, the four settings fingerprints unchanged, copies removed. No kill was needed (first QUIT closed AutoCAD every time).
5. **Item 5, self-test: PASS twice.** `v3_selftest.ps1`, run 1 and run 2 on the final code: OFFLINE, ITEM1, ITEM2, ITEM3, SESSION, ITEM4 all PASS (both runs, about 16 to 18 minutes each). At the end: no `acad.exe`, no lock file, no stray test copies, fingerprints ACD64E79A33B, 622A246F7D3B, EFE307C4FC74, 2972CE70C514 (all as expected).
6. **Mistakes first (what it cost).**
   1. A background job of mine hit its 30 minute limit at 23:58 and was killed while the third lifecycle session was running. That left AutoCAD open and the lock held by `Claude-driverv3` for about a minute until I ended it with the v2 `quit` (clean, settings restored by hash, nothing lost). Cost: one wasted 16 minute run. Fix: README now says to start the self-test with a 40 minute or longer limit.
   2. A bug of mine (report was copied instead of shared) meant the first live runs ended AutoCAD correctly but did not put one profile variable back: **OSMODE (object snap) in Tim's AutoCAD profile stayed at 0 for one launch** (run at 22:20 read "0 to 0"). Fixed the same night: the recorded original (5375) is now put back at the start of every session and again at the end, and the read-back must match. Every session since reads 5375 at start and reports "restored, read-back matches" at the end. **Unexplained:** the Windows registry key `Profiles\Tim\General\Osmode` reads 0x1025 (4133, AutoCAD's factory default), not 5375. AutoCAD reads 5375 at each start, so the live value comes from somewhere else; I did not find where. Worth Tim glancing at his object snaps (F3) in the morning.
   3. My first double-click data (run `final`) was wrong for two parts: the "angled DP text" click had missed the letters (it started a selection window) and was reported as "no window". I added a hit test (a single click at the same point must select the intended block) and a Real Esc to clear grips, then re-ran everything. Results above are from the corrected runs only. Lesson recorded in README_V3: **a selected block shows grips, and a double-click on the grip at its centre starts STRETCH instead of the editor.**
7. **I waited for Codex.** The lock `Codex-V10` (taken 20:56, expiring 22:26) and its AutoCAD (open since 20:57, spinning about one core) were still there when I started at 21:31. I did not touch them. AutoCAD closed and the lock freed at 21:47 (16 minutes wait, inside the 60 allowed).
8. **Not tested / not built (full list in section 5).** `pt-rclick`, `pt-hover`, `pt-drag` have never been run in AutoCAD. `ui-set`, v3 `dialog-path` / `dialog-cancel`, `layer-read`, `ent-count` and the spec's item "dialog-path on the X-Civil Choose DWG dialog" are NOT built. Twist and UCS are refused, not supported. No Opus review yet.

## 1. Item 1 detail: what each window lists (run 2, final code)

1. **About CE Suite (CE_VERSION), 22 controls.** Title bar, system menu, a title-bar Close button, then text: CE SUITE, Loaded CE versions, AutoCAD tools for Creative Engineering, **Civil Suite v3.0.70, Structural Suite v1.0.121, Suite Manager v1.1.70, AutoCAD 26.0, Runtime .NET 10.0.12** (each version in its own box with an id: txtCivilVersion, txtStructuralVersion, txtManagerVersion, txtAutocadVersion, txtRuntimeVersion), "Hover over a version to see which file was loaded.", Creative Engineering Pty Ltd, and one **Close** button (the body one). Why the old robot failed: two buttons are called Close (title bar and body); v3 sets the title-bar one aside, as v2 does. Pressed through UI Automation (Invoke); window gone.
2. **Settings window "Creative Engineering | Settings (CDS)", 80 controls.** Eight tabs: **Drafting, Pipes and Pits, Design, Survey, Display, Advanced, Newer tools, Fixes** (the spec expected six). Pressed **Cancel**: closed. The four settings fingerprints did not change. (Only the first tab's controls exist in the tree at one time; the other tabs are not read until selected: ui-dump of each tab is phase 2.)
3. **Checks palette "Creative Engineering | Checks (CDCHECKS)", 37 controls** (needed settings key `checks.checksCommandEnabled` true, set through the v2 guard before launch and restored by hash). Header "Checks: 42 to look at, 234 OK, 342 not known (CE could not check)"; two tabs **Look at** and **Ignored**; a list of rows; buttons **Show where** (disabled), **Check again**, **Close**. Closed by **Close**. **Finding for the checks wording:** the list rows' control names read `CE_CVL_SUITE.Services.Checks.ChecksListEntry` (a code type name leaking through the accessibility tree; the row text itself is plain English). It only shows to screen readers and tools like this one, but C15 in the spec ("no row shows a raw handle") should say it checks the row text, not the row name.
4. The palette and CE windows appear twice in UI Automation (as a top-level window and as a docked pane); v3 lists each window once and treats the same button seen through two panes as one.

## 2. Item 2 detail: pointer calibration

1. **How:** AutoCAD idle; read VIEWCTR, VIEWSIZE, SCREENSIZE, VIEWDIR, VIEWTWIST, WORLDUCS, PERSPECTIVE, CTAB through COM (plan view, world UCS, no twist, Model tab only; anything else is refused). Find the drawing-area window inside AutoCAD whose client size equals SCREENSIZE (or the same shape at a measured ratio). Pixel = canvas left + width/2 + (x - centre x) x (height / VIEWSIZE), pixel y the same, flipped. The thread declares itself per-monitor DPI aware (awareness 2), so all rectangles are real pixels. AutoCAD to the front; the window under the pixel must be the drawing area (checked before and after moving); `SetCursorPos`, then `GetCursorPos` must read the same pixel (0 px difference in every click); `SendInput` (the 40 byte struct checked); mouse put back.
2. **Display facts read on this PC:** Windows sees two 1920 x 1080 monitors side by side (not 5120 x 1440 as the brief assumed); AutoCAD's drawing area was 1330 to 1604 wide and 569 high; scale vs SCREENSIZE 1.0; window DPI 96 (100 percent). **The 5120 x 1440 / scaled case was not available here, so the DPI-scaled path (ratio fallback) is untested.**
3. **Independent error measurement:** OSMODE set to 0 (restored after), `_.ID` left waiting for a point, `pt-click` at a known world point, then AutoCAD's own LASTPOINT read back and compared:
   1. zoom height 1000, asked 1200,900: AutoCAD reports 1201.459,901.582: error **1.22 px** (dx 0.83, dy 0.90).
   2. zoom 5000, asked 2000,500: 2007.294,507.909: **1.22 px**.
   3. zoom 20000, asked 5000,-1000: 5029.176,-968.366: **1.22 px**.
   4. after a PAN, asked 2000,500: 2002.282,500.967: **0.28 px**.
   5. **Maximum 1.22 px.** The constant 0.83/0.90 px offset (same at every zoom) is probably AutoCAD's pixel-centre convention; I did not chase it.
4. **Selection checks** at each of the four views: `pt-click` on the circle line (1200,1000 on a circle of radius 200 at 1000,1000) selected exactly one object, the circle (handle 11C558); `pt-click` at the circle centre selected nothing. (The spec's C02 point: a click on the centre of an unfilled circle selects nothing; confirmed.) The selection is read through COM (pick-first set), no LISP.
5. **Real behaviour learned:** a click on empty space starts a selection window and AutoCAD then refuses COM until a real Esc key; `esc-key` (new verb, one Esc only) ends it. A candidate "empty" point must be checked by a real click: at zoom 20000 a point 11000 units away picked a SOLID hatch (handle 102048, layer HATCH 141) that the geometry search did not see.

## 3. Item 3 detail: BUG-859 acceptance data (Civil 3.0.70, test copy of DRV1_B1)

Placed with the DP command at 3000,3000 ("Downpipe placed. Tag: DP1.", the command then asks for the next DP; ended with the one v2 `esc-prompt`). Block "DOWNPIPE DYNAMIC WITH MASK": a hatch (centre), a circle radius 75 on layer DOWNPIPES (the visible outline, the "outer circle"), a circle radius 175 on DEFPOINTS (mask), and attribute DP (height 250, middle-left, rotated 315 degrees). Each point was proved to hit the block first (single click selects exactly the DP block), nothing selected before the double-click, then:

1. **Outer circle** (world 3075,3000, pixel 2789,706): opened **Enhanced Attribute Editor** (AutoCAD's own). 30 controls: grid with Tag DP / Value DP, boxes "Value: DP", "Block: DOWNPIPE DYNAMIC WITH MASK", "Tag: DP", tabs Attribute, Text Options, Properties, buttons Select block, Apply, OK, Cancel, Help. Cancel pressed: closed.
2. **Red centre** (the block's centre, world 3000,3000): opened **Enhanced Attribute Editor** (same 30 controls). Cancel: closed.
3. **Angled DP text** (middle of the rotated text, world 2660.8,3339.2): opened **Enhanced Attribute Editor** (same). Cancel: closed.
4. **Pit label P3** (block PIT LABEL, handle 109E08, attribute PIT_LABEL = P3): opened **Enhanced Attribute Editor** (29 controls, "Value: P3", "Block: PIT LABEL"). Cancel: closed.
5. **What this means for BUG-859 / #1499:** no part of the downpipe opens CE's "Edit source" on the installed build; the pit label does not open CE's Edit Pit (its switch is OFF by default, so this is expected). It matches the diagnosis (CE only watches EATTEDIT behind the pit-label switch). The same test run again after the fix is installed is C04/C07 of the spec: expected window "Edit source" with Tag DP1.
6. **Not the Tag box:** the attribute shows DP, not DP1; the full tag DP1 is stored by CE, not in the attribute (as the diagnosis said).
7. Side finding, not a bug claim: a double-click exactly on the centre of a block that was still selected (grips showing) started STRETCH instead of opening the editor (seen once in an uncorrected run). The test now presses a real Esc first.
8. Evidence files: `pack_runs\v3_selftest_final2_run1\item3_windows.txt` and `..._run2\item3_windows.txt` (full control lists), local only.

## 4. Item 4 and 5 detail: lifecycle and self-test

1. **Start:** no acad.exe; lock free (waits up to 60 min); the four fingerprints read; lock taken through v2 as `Claude-driverv3`; settings changed only through the v2 guard before launch; fresh copy `CLDV3<time><n>_B1.dwg` of DRV1_B1 (master hash 34BBE37C2EA4 untouched); v2 `launch` (about 24 s); echo round trip (`_.ID <number>,0` must print the number).
2. **End, always:** close any CE window still open by its Cancel/Close button; put profile variables back; `quit`; `quit` again; `quit -Kill` (v2 kills only its own AutoCAD); v2 settings restore by hash; lock released; no acad.exe; the four fingerprints compared with the start; the run's copies, `.dwl`, `_PRE_` files removed. The first QUIT closed AutoCAD every time (about 8 s); the second QUIT and the kill never ran in these runs, so **they are built but not exercised**.
3. **Self-test items and their checks:** OFFLINE (checks: fresh-process UI Automation load, per-monitor DPI, SendInput struct size 40, pixel maths, `ui-press Save` and `ui-press "Delete pipe"` refused, `pt-click` without the lock refused, a case containing SAVE refused). ITEM1 (3 windows: dump, press, idle check). ITEM2 (four views: pixel measurement, line click, centre click). ITEM3 (4 double-clicks, each with hit test, dump and Cancel). SESSION (the one session for items 1 to 3 ended clean). ITEM4 (3 sessions).
4. **Run times:** about 16 to 18 minutes per self-test (one session about 11 minutes, three lifecycle sessions about 2 minutes each).
5. **Hours:** every run was Thursday night or Friday before 8:30 am Melbourne, outside Tim's in-use hours; the verbs refuse inside those hours.

## 5. What was NOT built, NOT tested, or limited

1. **Not run in AutoCAD:** `pt-rclick`, `pt-hover`, `pt-drag`, the second QUIT and the kill step, the "PC in use" wait (nobody used the PC during the runs, so the human-at-the-PC guard only ever passed), a lock held by someone else at start (it waited 16 minutes for Codex but I did not test the 60 minute give-up).
2. **Not built (spec phase 1 verb list):** `ui-set`, v3 `dialog-path` and `dialog-cancel` (spec item 2.4, the X-Civil "Choose DWG" dialog; the 20 Oct fault in v2's `dialog-path` is explained in spec 1.4 item 11 but v3 has no replacement yet), `layer-read`, `ent-count`, the `setvar` drawing-variable cases (only OSMODE and PICKFIRST were used). `ent-find` iterates model space (about 1000 objects here, fast); capped at 60000.
3. **Limits:** pointer needs plan view, world UCS, no twist, Model tab (refused otherwise). The DPI-scaled / 5120 x 1440 case is untested (this PC reported two 1920 x 1080 monitors at 100 percent). Window reading of the other CE tabs (Settings has eight) needs a tab-select verb (phase 2). The right-click menu (spec C33) was not tried.
4. **Review:** not reviewed by Opus. The spec (6) asks for an Opus review of phase 1 before phase 2.
5. **The unexplained OSMODE registry value** (mistakes, item 2).

## 6. What the witness and allow-list rules require for a new file (and what I did)

1. **The v2 witness recorder pin** (`$script:WitnessPinnedSha256` in the v2 drivers) pins the recorder DLL only, not driver scripts; a new driver file does not touch it. I did not touch it. v3 never calls `witness load`.
2. **The v2 allow-list** (`acad_driver_witness_v2.allowlist.json`, SHA-256 5B542F2145F4...) is pinned inside v2 and is for v2 verbs only. Not edited; hashes re-checked at the end of the job: v2 script 120EE24D15B2, allow-list 5B542F2145F4, unchanged. `calls_v2.json` was only changed by v2 itself (call counters).
3. **The v3 allow-list** is mine to write per spec 6.6 and was written with its pin: `acad_driver_v3.allowlist.json` pinned by full SHA-256 `613F479421D0FDF7712EB2565F3D6300A78FA7E081403BD1CAD38A5DF110F023` inside `acad_driver_v3.ps1` (`$script:V3AllowPinnedSha`). It holds the never-press words copied from v2 plus Save*, Apply, Continue placement; the windows About CE Suite, Edit source, Settings (Cancel/Close only), Checks, X-Civil import, Enhanced Attribute Editor, Edit Pit, Edit Pipe, New Pipe, Cascade Preview, Open and the generic "Creative Engineering*"; and the setvar lists (drawing: DIMSCALE, INSUNITS, CLAYER, LTSCALE; profile: OSMODE, PICKFIRST, DBLCLKEDIT, SHORTCUTMENU, SELECTIONPREVIEW, ROLLOVERTIPS, PICKBOX).
4. **For the desk (not done by me):** (a) queue the Opus review of `acad_driver_v3.ps1`, `acad_driver_v3_session.ps1` and the allow-list (spec 6.6); (b) record the hashes below in `release-v3-colleagues-DESK_CONTINUITY_RECORD.md` and in the hash-check line of the briefs; (c) the driver folder is not in git, so these files have no history: copy them somewhere versioned if Tim wants that; (d) `DRIVER_TESTER_GUIDE.md` and `README.md` were NOT edited (README_V3.md is the new guide); (e) I did not edit DESK_LOG.md.

## 7. File list (folder `C:\Lisp Files\_ACAD_DRIVER`, not in git)

1. `acad_driver_v3.ps1`: 69,827 bytes, SHA-256 B420501841914DC7B27143551F9D6658A74B5F1540D5815F2B072DCC5FD25F3E
2. `acad_driver_v3_session.ps1`: 20,001 bytes, SHA-256 263A958E8BC78FC9645DE570F857B5D3D11E3CA26DA4C7FF712E730EA9434F7A
3. `acad_driver_v3.allowlist.json`: 3,221 bytes, SHA-256 613F479421D0FDF7712EB2565F3D6300A78FA7E081403BD1CAD38A5DF110F023
4. `v3_selftest.ps1`: 19,163 bytes, SHA-256 C28B7D125DF509B844ED7C731BE36F6E10A3B651CA368A570D6B8E59EC0A4C9E
5. `v3_selftest_item3.ps1`: 8,269 bytes, SHA-256 8023790C9ED72B9EACE21664E2F2629A94932F72F0AC2601F77C4BC36C8D801B
6. `README_V3.md`: 6,180 bytes, SHA-256 E057D736FA026D82225E2E7E24ECABB4896E40BFADDE432EFFA7711A81D22CBD
7. `v3_cases\throwaway.case.txt`: 318 bytes, SHA-256 AE09460BDB87949B94A68B145DF664B17E10CF30985A3512417B3DD938795FB8
8. Run evidence (local only, pictures not taken): `C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\v3_selftest_final2_run1` and `..._run2` (selftest.md/json, item1_controls.txt, item3_windows.txt, session json), `pack_runs\ui_dumps\*.json` (full control JSON), `pack_runs\v3_<time>\report.json/md` (session-run reports).
9. Verbs (all in `acad_driver_v3.ps1`): ui-windows, ui-dump, ui-press, view-read, pick-read, deselect, esc-key, ent-read, ent-find, setvar, pt-click, pt-dblclick, pt-rclick, pt-hover, pt-drag, session-run, v3-status.

## 8. Final state (checked 01:25 Fri 23 Oct)

No acad.exe. No lock file. No CLDV3 copies. Settings fingerprints ACD64E79A33B, 622A246F7D3B, EFE307C4FC74, 2972CE70C514, the expected four. v2 files unchanged. Nothing was saved over any drawing; all work was on `CLDV3...` copies of DRV1_B1.

## What was not checked

1. Nothing was shown to Tim; no window was judged for looks (no picture was taken: ui-dump only).
2. Whether the ribbon-triggered versions of these commands behave the same as typed commands.
3. Any Structural window or command (Structural 1.0.121 was only read from the About window).

