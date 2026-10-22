# Install, update and go back: CE Civil + Manager on your PC

**DRAFT, Thu 22 Oct 2026, for Mon 9 Nov 2026.** [CHECK] = not confirmed in the code or the plan yet. [SCREENSHOT: ...] = a picture still to be taken on a test copy before hand-over.

---

## Answer first

1. **Tim (or the CE desk) installs CE for you, by hand, with AutoCAD closed.** It takes about 5 minutes. You do not run an installer yourself.
2. **Updates come the same way for now.** The automatic update button in Manager is not switched on yet. Do not press it.
3. **Going back takes 2 minutes** and loses nothing in your drawings.

Why by hand: Tim ruled on 20 Oct 2026 that colleague installs go "by the deploy chat's route" until two installer faults (BUG-823, BUG-824) are proven fixed. The fixes are built but have not been seen working in AutoCAD.

---

## 1. Before the install (Max)

1. **Save your work and close AutoCAD.**
2. **Open Task Manager** (Ctrl+Shift+Esc). Check there is no `acad.exe` running. If there is, wait a minute and look again.
   [SCREENSHOT: Task Manager, Details tab, sorted by name, showing no acad.exe]
3. **Tell Tim which AutoCAD year you use.** This release is for AutoCAD 2027. [CHECK: Max's PC is 2027]

## 2. The install (done by Tim or the desk, every step visible)

1. **Open File Explorer** and paste `%APPDATA%\Autodesk\ApplicationPlugins` into the address bar. Press Enter.
   [SCREENSHOT: Explorer showing the ApplicationPlugins folder with the old CE folders]
2. **Rename the old CE folders.** Add `_PRE_V3.backup` to the end of `CE_CVL_SUITE.bundle` and `CE_SUITE_MANAGER.bundle`. This is your way back. AutoCAD does not load a folder whose name ends in `.backup`.
   [SCREENSHOT: the two renamed folders]
3. **Leave the Structural folder alone** unless Tim says otherwise. [CHECK: Tim to decide, see 06]
4. **Copy your settings aside.** Copy the folders `%APPDATA%\TIM_CE_CADTOOLS` and `%APPDATA%\CE_CVL_SUITE` to the same place with `_PRE_V3` on the end. Version 3 may rewrite some settings. Nobody has proved whether your old version still reads them after going back.
5. **Check the all-users plugin folder.** Open `C:\ProgramData\Autodesk\ApplicationPlugins`. If a CE `.bundle` folder there still has a file named exactly `PackageContents.xml`, **stop and tell Tim.** An old Manager there loads first and can hide the CE ribbon. Renaming it needs administrator rights.
   [SCREENSHOT: the ProgramData folder, with or without a CE folder]
6. **Copy in the two new folders,** `CE_CVL_SUITE.bundle` and `CE_SUITE_MANAGER.bundle`, from the release folder Tim gives you. [CHECK: where the frozen release copy will sit; putting it in the shared IT Admin folder counts as publishing and needs Tim's word]
7. **Civil and Manager always go in together.** They share one file. One new and one old gives a missing CE ribbon.

## 3. First start, and checking it worked

1. **Open AutoCAD.**
2. **AutoCAD may ask whether to load the CE files.** Choose "Always Load". [CHECK: whether AutoCAD 2027 asks on a PC that has never loaded CE 3.0; take the picture on the install day]
   [SCREENSHOT: AutoCAD security prompt for CE, if it appears]
3. **The CE ribbon tab appears.** Its Civil panels are Draw, Sources, Edit, Design, Review, Site, Import and Settings. [CHECK: tab name as seen on screen]
   [SCREENSHOT: the CE ribbon tab, full width]
4. **Type `CEHEALTH`.** Every line should start `[OK]`. One `[WARN]` about the office IT folder is fine if you are offline.
   [SCREENSHOT: the CEHEALTH lines on the command line]
5. **Type `CE_VERSION`** (or CE Tools > Version). The About window shows Civil and Manager. Check the numbers match the ones Tim gave you.
   [SCREENSHOT: the About CE Suite window]

---

## 4. What the Manager does

1. **`CEMANAGER`: the Manager window.** It shows which CE plugins are installed, their versions, and whether each starts with AutoCAD.
   [SCREENSHOT: CEMANAGER Status page]
2. **`CEHEALTH`: a quick check** that Civil and Manager are present, start with AutoCAD, and match each other.
3. **`CESUPPORT`: makes a support zip** of your CE logs for Tim. It never sends anything by itself. See page 05.
4. **`CEMANAGERLOGS`: opens the CE log folder.**
5. **`CE_VERSION`: the About window** with the versions.
6. **Buttons NOT to press yet:** Roll Back Release, Get update ready (or any "update" button), Set up CE administrator, and the Admin Dashboard. They are for Tim, or not finished. See page 04, section E.

## 5. How updates arrive (for now)

1. **Tim tells you a new version is ready** and what it fixes.
2. **You save your work and close AutoCAD.**
3. **Tim or the desk repeats section 2** with the new folders. The previous version is kept as a `.backup` folder.
4. **You check with `CEHEALTH` and `CE_VERSION`.**
5. **Later:** Manager will get updates ready by itself and finish them when AutoCAD closes. That route is built in part, has no button yet, and is switched off until Tim approves it (BUG-478, ruling F2, 17 Oct). [CHECK: whether this changes before 9 Nov]

---

## 6. If AutoCAD says it cannot load CE

**First, do not reinstall anything.** Note the exact words, then work down this list.

1. **No CE ribbon at all.** Type `CEHEALTH`.
   - **"Unknown command":** Manager did not load. Check the two folders in section 2 step 6 are there with exactly those names (no `.backup` on the end).
   - **"its program file is missing":** a folder was copied only partly. Ask Tim to copy it again.
   - **"does not start with AutoCAD":** in `CEMANAGER`, use Enable on Restart, then restart AutoCAD.
2. **A line saying the shared CE file is not its own** (a Civil and Manager mismatch). Civil and Manager came from different releases. Ask Tim to copy both again together.
3. **"Menu item failed to load: CE_CVL_SUITE_MENU..." at start-up.** This is harmless and the CE tabs still work. [CHECK: whether this line still appears on 3.0.70 on a clean PC]
4. **A security prompt every start.** Choose "Always Load". If it keeps asking, tell Tim. [CHECK]
5. **AutoCAD crashes or hangs on start.** Go back (section 7), then report it (page 05).

## 7. Going back (roll back)

**Only go back if the install itself is broken:** no CE ribbon, AutoCAD crashes or hangs, drawings will not open, or every CE command says "Unknown command". One wrong message is a bug report, not a reason to go back.

1. **Close AutoCAD.** Check Task Manager for `acad.exe`.
2. **Open** `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Rename the new folders** by adding `.REMOVED.backup` to the end, rather than deleting them. [CHECK: the desk prefers rename over delete; Tim to confirm]
4. **Take `_PRE_V3.backup` off the two old folder names.**
5. **If settings look wrong,** put the `_PRE_V3` settings copies from section 2 step 4 back.
6. **Open AutoCAD** and type `CEHEALTH`.

**Never use Manager's Roll Back Release button.** It is not proven to work on a colleague PC (BUG-441, BUG-477). [CHECK: whether it is hidden in 1.1.70]
**Your drawings are safe either way.** CE keeps its records inside each drawing. An older CE may not show the newest features in a drawing you worked on in 3.0. [CHECK: mixed-version behaviour has not been tested]
