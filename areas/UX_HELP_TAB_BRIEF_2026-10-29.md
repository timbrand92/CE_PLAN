# Help tab in CE Manager: design brief (29 Oct 2026)

**Status:** DESIGN APPROVED by Tim, 29 Oct 2026: "Accept all five" (section 8; recorded as decision 84 in `decisions\2026-10-29_TIM_ANSWERS.md`). Not built, no code touched, not accepted until seen in AutoCAD.
**Picture:** `areas\UX_HELP_TAB_MOCKUP_2026-10-29.png` (source `.html`, same folder). Two states: how the tab opens, and after the button is pressed.
**Clickable version (open in a browser, same kind as the New Pipe v2 one Tim accepted):** `areas\UX_HELP_TAB_MOCKUP_2026-10-29_clickable.html`. Press the gold button, tick and untick the box and watch line 3 change, try the old command names. Checked by script that the button, the tick box and "Make another" work; not looked at by eye.
**Idea it answers:** UX-HELP-IN-MANAGER in IDEAS_INBOX.md. **Related:** UX-MANAGER-TABS (CEHEALTH as a tab, StrucPlus removed), UX-VERSION-IN-MANAGER, hand checks H34 and H37 in `areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`.

**Tim, 29 Oct 2026 about 17:05:** "one Help tab inside CE Manager with one button in plain words, such as 'Something is wrong: get help'. lets do this please, this whole plugin needs to be user friendly".
**Tim on the three commands (H34):** "can we unify this and also how does an end user know what and how to do this".

---

## 1. Answer first

1. **One button, "Something is wrong: get help", at the top of the existing Help tab.** The Manager already has a Help tab (section 2), so no new tab is added. The button sits in a fixed panel above the guides, visible the moment the tab opens.
2. **One press makes ONE zip** holding the diagnostics report, the CE logs and the health-check result. Three plain lines beside the button say what it collects, where it is saved and who can see it, before anyone presses.
3. **The three old commands stay, but only as shortcuts that open this tab.** CEHEALTH also shows here as a short list with "Check again".
4. **Recommended answers to Tim's questions are in section 8.** The two that matter: the zip is saved on the PC outside OneDrive, and an UNTICKED box (with the audience named beside it) that the user ticks to copy it to the shared IT folder (Tim, decision 90, replaced the ticked default).

---

## 2. What the Help tab holds today (read in the code)

**Caution:** I read `Modules\Manager` in this worktree, which is on `master`. Master is about 1100 commits behind what ships (memory: master-is-not-the-trunk), and Tim's installed Manager is 1.1.85. The tab names and the command wiring below are from that older tree. The builder must re-read the tab on the real release branch before changing it.

1. **The tab strip:** Status, Module, Updates, Help, Settings, Project / Sheets, Drawing Repair, Project QA, Survey Intake. Matches what Tim sees.
2. **The Help tab is titled "CE Help"** ("Complete installed module guides and existing support routes"). Underneath are four small tabs: **Civil** (the full Civil guide), **Task journeys**, **Structural** (a button that opens the old Structural help), and **Manager & Support**.
3. **"Manager & Support" holds only a few lines of facts text.** It has no buttons. So today the Help tab has no support action at all.
4. **A support route already exists, hidden:** the Civil "Task journeys" can call CESUPPORT (`OpenSupportFromCivilHelpJourney`). That route must open the new panel too, or two ways to make a bundle survive.
5. **Does the new button go into the existing Help tab?** Yes. Recommend: a fixed "Something is wrong?" panel at the top of the Help tab, above the four small tabs, so it is visible without clicking a sub-tab. The Manager & Support sub-tab is removed and its facts text moves into this panel. The Civil, Task journeys and Structural guides stay exactly as they are.

---

## 3. The layout (top to bottom, see the picture)

1. **Title "CE Help"** and one line: "Get help when something is wrong, check your setup, and read the guides."
2. **Panel "Something is wrong?"** (gold outline in the picture):
   1. Left: one sentence ("One click gathers what CE support needs to fix it. You do not need to know what is wrong or where the files are"), the **one gold primary button**, and one tick box, unticked when the tab opens: "Also copy it to the office IT folder, so Tim and IT get it straight away".
   2. Right, headed "Before you press it": the **three plain lines**, numbered 1 to 3 (section 4).
3. **Two cards side by side:**
   1. **Your setup · health check** (the CEHEALTH result as a list, OK in green, anything wrong in amber with the plain fix, a "Check again" button and "last checked" time).
   2. **Log folders** (section 6).
4. **Guides:** the existing Civil, Task journeys and Structural sub-tabs, unchanged.

Only one thing is gold and filled: the button. Amber appears only when the health check finds something. Same layout every time the tab opens (cockpit test); the panel changes in place after the press and nothing else moves.

---

## 4. The one button and the three plain lines

**Button wording:** "Something is wrong: get help" (Tim's own words).

The three lines, as they should read on screen:

1. **What it collects:** your CE setup, the CE log files, and the result of the health check below. Never your drawings. Drawing paths are cut down to the job number, and your login and computer name are coded.
2. **Where it is saved:** on this PC in a CE Support folder that is not in OneDrive, as one zip file named with today's date and time (Melbourne time).
3. **Who can see it:** only you, unless you tick the box. Ticked: you and Creative Engineering IT (the shared "CE Diagnostics" folder in IT Admin). Nobody outside the office.

Rules for these lines:

1. **Line 3 changes with the tick box.** Unticked is the default and reads "only you". Ticked: "you and Creative Engineering IT". Unticked: "only you". It can never say one thing while the code does another.
2. **If the IT folder is not reachable** (OneDrive not synced), the tab says so in line 3 and the zip stays on the PC only. It must not silently fall back to a Desktop folder, which is what the diagnostics code does today.
3. **"Never your drawings" is a requirement, not a checked fact.** I have not looked inside a real zip. The builder must prove it (a test that opens the zip and finds no .dwg), or the sentence is reworded to what is true.

---

## 5. What the one bundle contains

One zip, nothing else produced:

1. **Diagnostics report** (what CEMANAGERDIAG makes today): versions, builds, what loaded, where installed, whether the IT folder is reachable.
2. **The CE logs:** from the log folders in section 6, using today's rule (Tim's run on 29 Oct: 28 files in, 19 left out). I do not know why those 19 were left out; the builder must read the rule and keep it, not rewrite it.
3. **The CEHEALTH result** as a text file, the same lines the tab shows.
4. **A short readme in plain words:** when it was made, which builds, what is inside, and "this contains no drawings".
5. **Same scrubbing as today for everything inside:** drawing paths cut to job numbers, login and computer name coded. **One gap to close:** today's diagnostics report is saved with the real login in its file name and the real computer name as its folder (read in `CeDiagnosticsService`), so the diagnostics part is not coded the way the zip is. In the bundle it must be.
6. **Not included:** drawings, keys, settings that hold keys, anything under Tim's local-only list (RULES 11).

**File name (local time):** `CE_SUPPORT_<coded PC>_2026-10-29_15-12-40.zip`, the PC's own clock, Melbourne time, same date format as the diagnostic report already uses. Today the zip uses UTC (Tim's run: 040812 for 15:08). The report inside records both the local and UTC time, as today, so support can still read it.

---

## 6. The log folders as links

1. **Four plain links** (replacing the one command that opened four folders at once): Open Civil logs, Open Structural logs, Open Manager logs, Open older Civil logs.
2. **The four folders as Tim saw them on 29 Oct:** `TIM_CE_CADTOOLS\logs`, `CE_SUITE_MANAGER`, `CE_CVL_SUITE\logs`, `CE_STRUC_SUITE\logs`. Two of those hold Civil logs under old and new names, so the old one is labelled "older Civil logs" and only shown when it has files. Which folder is Civil's current one is for the builder to confirm on the real release.
3. **Each link has a few plain words saying what is in it.** They are labelled "you never need these to get help", so nobody thinks they must send them by hand.
4. **A link to a folder that does not exist** shows "No logs yet", never an error and never an empty Explorer window.

---

## 7. What happens to the three old commands, and how a user finds all this

1. **CESUPPORT, CEMANAGERDIAG and CEMANAGERLOGS become shortcuts.** Each opens CE Manager on the Help tab. CESUPPORT and CEMANAGERDIAG do **not** start the bundle by themselves (a typed command should never copy something to a shared folder before the user has read the three lines). CEMANAGERLOGS opens the tab with the log folders in view.
2. **CEHEALTH stays a typed command** and prints its lines as today, and the same result shows on the tab. This follows Tim's "ideally a ui window for this would be good, maybe in manager as a tab" (UX-MANAGER-TABS).
3. **The ribbon:** the three buttons (Support Bundle, Diagnostics, Logs) become one "Get help" button that opens the same tab. This touches the Manager ribbon layout and the command registry; the builder owns that.
4. **Other places must point here too:** the Civil Task journeys support route (section 2, item 4), and any CE message that today says "run CESUPPORT" should say "CE Manager, Help tab". Anything else the builder finds with a grep for the three command names.
5. **How a drafter finds it, answering "how does an end user know":** a "Get help" button on the ribbon, the Help tab in the Manager, and every plain error notice ending with "Open CE Manager, Help tab". No command name needs remembering.
6. **Order matters with the other Manager tab work.** This sits with UX-MANAGER-TABS and UX-VERSION-IN-MANAGER. The build desk (CE 01) schedules them together so the Manager's tabs are changed once, not three times.

---

## 8. Questions for Tim (batch, my recommendation first)

1. **Where is the zip saved?**
   1. **Recommend: on the PC in a CE Support folder outside OneDrive** (I would use the CE folder under the user's local application data; the builder confirms the exact spot). Today's Desktop "CE Support" folder is inside OneDrive, so every bundle is uploaded to Microsoft whether the user wanted that or not. On a job: the colleague presses the button, the file never leaves the PC unless they let it.
   2. Alternative: keep Desktop\CE Support (easy to find, but it syncs to OneDrive).
   3. I have not checked whether other users' Documents or Desktop are redirected into OneDrive. Tim's PC is, per the 29 Oct message.
2. **Who gets it, and who is told?**
   1. **Recommend: a tick box, "Also copy it to the office IT folder, so Tim and IT get it straight away", with line 3 saying exactly who can read it.** **SUPERSEDED 29 Oct (decision 90): Tim chose UNTICKED by default, "The user ticks it when they want you and IT to get the file straight away". My first recommendation (ticked) is kept here as written.** The user can tick or untick. The IT folder is shared, so the warning today's diagnostics skip is the point of line 3.
   2. **Recommend: CE sends no message itself** (no email or Teams code exists for this that I know of). The tab shows a ready-to-paste sentence with the file name and a "Copy this message" button.
   3. Alternative: never copy automatically; the user sends the file themselves. Safer, but the colleague has to know whom to send it to, which is the problem Tim raised.
3. **Does the button do everything in one go, with no "are you sure"?**
   Recommend yes. The three lines above it are the warning, read before pressing. A pop-up on top of them is the clutter the New Pipe work removed.
4. **Typed CESUPPORT / CEMANAGERDIAG: open the tab only (recommended) or make the bundle straight away?**
   Recommend open the tab only (section 7, item 1). Costs the colleague one extra click.
5. **Wording check.** Is "Something is wrong: get help" final, and is "Open older Civil logs" clear? Tim's own phrase is used for the button; the rest is mine.

**Tim's answer, 29 Oct 2026:** "Accept all five". Read as the five recommended answers above (my reading; if he wants any one different, his word replaces it).

---

## 9. What must not change

1. Same layout every open, no motion, no decoration (UI cockpit test).
2. Plain AutoCAD words, no software words (plain-English rule). "Zip" is the one borderline word; the line says "one zip file", and the success message says "help file". Tim can rule on it.
3. Gold on dark, CE deep blue on light (the real theme switches), no new colours.
4. Nothing is sent over the internet by CE. Every copy is to a folder, and the tab says which.
5. Nothing is silently dropped. If a log folder is missing, the bundle readme says "not found", not a quiet gap (never guess, RULES 12).
6. No hard block: if the IT folder is unreachable the bundle still saves locally and the tab says so (R-27).

---

## 10. Test for the builder (after Tim approves; nothing run yet)

1. **Press the button in AutoCAD on copies:** a zip appears in the named local folder, outside OneDrive, with a local-time name. Open the zip: diagnostics, logs, health result and readme are in it, no .dwg, no real login or computer name anywhere inside.
2. **Tick on:** a copy appears in the IT folder and the tab says so. **Tick off:** nothing appears there and line 3 reads "only you". **IT folder unreachable:** the tab says so, the local zip still exists.
3. **Typed CESUPPORT, CEMANAGERDIAG, CEMANAGERLOGS:** each opens the Help tab and makes nothing.
4. **Health result:** the tab and the typed CEHEALTH show the same lines (Tim's real PC currently warns of a double Manager install).
5. **Civil Task journey support route** lands on the same panel.
6. **Needs a look, not just a log line:** the tab is a window, so a Codex look at the real tab with a screenshot (RULES 4.5, 5.7).

---

## 11. Not checked

1. I have not seen the real Help tab on 1.1.85 in AutoCAD; I read an older source tree.
2. I have not opened a real support zip, so what the "28 in, 19 left out" rule is, and whether any drawing content is in a bundle, are unconfirmed.
3. I have not read the drive to confirm OneDrive redirection, the log folder names, or that the CE Support folder on Tim's Desktop is where he says.
4. The coded computer name in the picture ("PC4F2A") is an example I made up, not the real coding.
5. Nothing was built, tested or installed. Robot, Codex and build jobs were not started.
