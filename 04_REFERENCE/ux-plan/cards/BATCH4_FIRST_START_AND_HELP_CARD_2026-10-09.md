**Code read on rel-20261009c 446162c2** (installed Civil 3.0.39, with the Manager module from the same commit; read with `git archive` into a scratch folder, no checkout).

# Batch 4 card: first start and getting help, 9 Oct 2026

**Status: DRAFT. Not approved by Tim.** Under INT-073 (Tim, Fri 9 Oct about 05:50: "the builds should not be hung on me answering
questions") builders MAY build this card on the **Recommended** answers below, as DRAFT PRs, tests red first, every new behaviour behind
a Settings value and OFF or hidden where it changes what a drafter sees, nothing retired. Tim's answer by number in
`TIM_BATCH_QUESTIONS_4_5_2026-10-09.md` (questions 1 to 8) replaces any recommended default in a follow-up.
Written by design lane run 7 (headless, Opus), Fri 9 Oct 2026 about 06:10 Melbourne (PC clock). Read-only on plugin code. "Today"
below is read from the Civil release commit `446162c2` (branch `claude/rel-20261009c`, NOT `master`, which stopped at `650c0c19` on
28 Sep) and from the Codex reports in `C:\Lisp Files\_TEST_COPIES_20260923` (named per line). Code lines are not proof of what installed
Civil 3.0.39 does on screen. File references are at the end.

**Items (10):** UX-START-01, UX-FIRST-01, UX-FIRST-02, UX-FIRST-03, UX-HELP-06, UX-HELP-07, UX-FAIL-02, UX-RECENT-01, UX-PANEL-01,
UX-PANEL-02.
**Commands touched:** AutoCAD start-up (CE's load banner and What's New), CESTARTHERE (Start Here tour), CDHELP (Help Centre), the
first-use tip in the New Pipe and New Pit windows, CDFEEDBACK (Feedback / Report a problem), CESUPPORT (support zip), Manager's admin
set-up, CDDISCIPLINE (the "Civil" button on the CE panel), CEFIND, CDSETUP (job mode), and three new things: a **start-up splash**, a
**welcome card**, and a **job button with recent jobs** on the CE panel.
**Why now:** this is the first five minutes of every colleague. Day 1 starts here, and today a new colleague gets a command-line banner
listing typed commands ("Start with CD, PIT, PITSCHEDULE, or CDEDIT."), then a What's New window.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`: "Help and first run" 25 Sep 23:57 (UX-HELP-02..05), "Helping
colleagues learn CE" 26 Sep 01:28 (UX-HELP-06..09), "Admin route, right-click, Ctrl+1, startup" 26 Sep 12:03 (UX-FAIL-02, UX-START-01),
"Undo names, resuming, recent jobs" 27 Sep 01:34 (UX-RECENT-01), "A colleague's first day" 27 Sep 01:35 (UX-FIRST-01..03), "The CE
panel" 27 Sep 02:01 (UX-PANEL-01, 02); UX-MODE-01 (26 Sep 10:12, the role question is replaced by a per-job mode); `V3_UX_PLAN.md`
section 1 rules 18, 25, 26, 39 and section 2 items 6 and 7.
**Related cards (do not build twice):** `UX-MSG_CARD_2026-09-29.md` (the CE bell: built, hidden behind a Settings switch, default OFF);
`UX-RIBBON-01_CARD_2026-09-25.md` (contextual Pipe/Pit/Source tabs); `UX-DES-01_CDSETUP_JOB_MODE_CARD_2026-09-26.md` (job mode, merged
#348); the Batch 3 card (UX-TIP-01 ribbon tooltips); Batch 2 card 2.2 (the Checks palette the health line opens).

**Two rulings disagree; this card follows the LATER one and asks Tim (questions 3 and 4):**
1. **Practice drawing:** UX-HELP-07 (26 Sep 01:28) Tim: **"No"** ("colleagues learn on real jobs"). UX-FIRST-03 (27 Sep 01:35, a day
   later) Tim: **"Yes, a practice drawing"**. Recommended: follow the later one (build the Help item), behind a Settings switch.
2. **How many times a tip shows:** UX-HELP-08 (26 Sep) "First 3 uses, then quiet", which is what is BUILT. UX-FIRST-02 (27 Sep) "One-line
   tip, once". Recommended: the number of showings becomes a Settings value; default **1** (the later ruling).

**Who does what (INT-073: windows stay Codex's):**
1. **Behaviour work (any builder):** when things show and when they never show again, what is remembered and where, the headless/accoreconsole
   skips, the job-folder and recent-jobs logic, the admin routing, the ribbon panel contents and the discipline switch, all Settings
   values, tests.
2. **Window work (any builder):** the look and layout of the splash, the welcome card, the practice-job entry in the Help Centre, the clip player
   in the Help Centre, the recent-jobs drop-down list, and the Feedback window wording changes; and the AutoCAD acceptance runs.

---

## Card 4.1 — UX-START-01: a small CE splash while CE loads

1. **Tim ruled (26 Sep 12:03):** "Splash for a second" (not the recommended silent line). A small CE splash shows while CE loads, closes
   by itself, needs no click. Refines SH2: SH2 still bars anything that stops the drafter or needs a click.
2. **Today:** no splash anywhere (no "splash" in Modules or Shared). At start-up CE waits for AutoCAD to go idle, then prints on the
   command line "CE CVL loaded: CE_CVL_SUITE v3.0.39 [Release]", "Start with CD, PIT, PITSCHEDULE, or CDEDIT." and "Use CDHELP for
   workflow guidance and CDREPAIR for recovery." (`PluginInitialization.cs:507-510`), then opens What's New once after an update
   (modeless since BUG-356), and adds the "CE CVL SUITE v3.0.39 ..." pane to the status bar. Structural and Manager each print their own
   lines.
3. **What works:** the idle-time start (CE never slows AutoCAD's own opening); the status-bar version pane; What's New modeless.
4. **Wrong or missing:** the splash. The banner speaks in typed commands to a person who has never used CE.
5. **Classification: MISSING** (splash) / **MODIFY** (banner wording).
6. **Proposed:**
   - One splash for the whole of CE (Civil, Structural and Manager together, not three): CE logo, "Creative Engineering", the versions
     in one small line ("Civil 3.0.39 · Structural 1.0.110 · Manager 1.1.x").
   - Shown from the moment the first CE module starts loading until the last one has loaded, **at least 1 second, at most 3 seconds**
     (Settings, question 1), then closes by itself. No buttons, never takes the keyboard, never sits on top of another program, never
     shown in accoreconsole, a headless run, or when AutoCAD is started by a script.
   - If loading fails, the splash closes and the failure follows today's route (the log; the failure window, UX-FAIL-01).
   - Settings > General: "Show the CE splash at start-up" (default ON, per Tim's ruling).
   - The banner shrinks to one line: "CE ready. New? Click Start Here on the CE tab." (the typed list moves to the Help Centre).
7. **Cancel / Esc / Undo:** nothing to cancel; writes nothing; not an undo step.
8. **Discovery:** it is seen at every start.

## Card 4.2 — UX-FIRST-01: one welcome card on the very first start

1. **Tim ruled (27 Sep 01:35):** "One welcome card". After the splash on the very first start: one card, three pictures (draw a pipe,
   place a pit, run checks), "Show me" and "Got it"; never again unless reopened from Help. Consistent with SH2 as a one-time first-ever card.
2. **Today:** no welcome card. The first-run help is the **Start Here** button on the CE panel (CESTARTHERE, UX-HELP-02, built): it carries
   an amber highlight until opened once (`FirstRunTourService.cs:24`), opens a one-page tour "Start here — the CE tab in five things"
   (Pipe, Pit, Edit, Checks, Help) and its footer opens the Help Centre. Codex PASS 12 N10 (26 Sep): opened directly, no role question;
   Sweep C1 item 311 PASS (footer opens Help Centre). The role question was removed (UX-MODE-01).
3. **What works:** Start Here, its once-only highlight, the opened-once record in the per-user settings file.
4. **Wrong or missing:** the card itself.
5. **Classification: MISSING** (card) / **KEEP** (Start Here).
6. **Proposed:**
   - On the very first start of CE for that Windows user (no record in the per-user settings file), after the splash: one small card,
     **not blocking** (AutoCAD stays usable behind it, like What's New since BUG-356), three pictures with one line each: "Draw a pipe",
     "Place a pit", "Run the checks".
   - **"Show me"** opens the Start Here tour (one code path: the card does not hold its own tour). **"Got it"** closes it. Esc and the
     window's X count as Got it.
   - Recorded as shown the moment it opens (same crash-safety as Start Here: a crash never makes it come back).
   - On that very first start **What's New does not also open** (the version is still remembered, so it will not open later either).
     "Quiet start after an update" (Settings, Advanced, BUG-356) also stops the card.
   - Help Centre gets "Show the welcome card again".
7. **Undo:** writes nothing to the drawing.

## Card 4.3 — UX-FIRST-02 (with UX-HELP-08): a one-line tip the first time a command is used

1. **Tim ruled:** UX-HELP-08 (26 Sep 01:28) "First 3 uses, then quiet", switchable off in Settings; then UX-FIRST-02 (27 Sep 01:35)
   "One-line tip, once", once per person per command, in the command line or window footer.
2. **Today (built for two windows only):** `UsageTipService` shows a tip the first **three** times (`UsageTipService.cs:21`), counted per
   Windows user, switch "tips on" in the settings file (`UserSettings.cs:327-332`). Only two callers (`DialogService.cs:115-120`): New
   Pipe ("Tip: click a recent size, material or invert button below to reuse your last pipe, or press Enter to keep placing pipes one
   after another.") and New Pit ("Tip: press Enter to place another pit straight after this one, or Escape when you're done."). Never on
   an edit. No command-line tips for typed commands. UX-HELP-09 (suggest the faster way once) is built for CDEDIT only.
3. **What works:** one code path, the counting, the off switch, never on edits.
4. **Wrong or missing:** the count follows the older ruling; only 2 of the main commands have a tip.
5. **Classification: MODIFY.**
6. **Proposed:**
   - Settings > General: "Show a tip the first [1] time(s) I use a command" (default **1**, question 4) and the existing on/off.
   - Tips for the Day 1 commands: Edit Pit, Edit Pipe, CDEDIT, PITSCHEDULE, CDCHECK, CDRULES, CDCALC, Start Here, the Checks palette, and
     the Structural Beam, Column and Footing commands (one line each, written in the card for the builder to copy: below).
   - In a window: the footer line (today's place). For a command-line command: one line before the first prompt, starting "Tip:".
   - Never during a script, a headless run or a repeated command in the same run.
7. **Tip lines (proposed wording, plain):**
   - CDCHECK: "Tip: type a number to jump to that item, or press Enter to finish."
   - CDRULES: "Tip: 'Explain' tells you why each problem was raised and where the rule comes from."
   - PITSCHEDULE: "Tip: click a row to zoom to that pit."
   - CDEDIT: "Tip: select several pits or pipes first to change them together."
   - CDCALC: "Tip: the sheet is rebuilt from the drawing each time; nothing in the drawing changes."
8. **Undo:** none (no drawing change).

## Card 4.4 — UX-FIRST-03 and UX-HELP-07: a practice job in Help

1. **Tim ruled:** UX-HELP-07 (26 Sep) "No" practice drawing; UX-FIRST-03 (27 Sep) "Yes, a practice drawing": Help > "Open practice job",
   an anonymised small residential job (DATA-01), drawn and checked freely, never counted in time or reports.
2. **Today:** nothing. No practice job; the Help Centre is offline help pages only.
3. **Classification: MISSING.**
4. **Proposed (if Tim keeps the later "Yes", question 3):**
   - A **made-up** small residential job, not a copy of a client job (safer than anonymising one; DATA-01): one house, about 6 pits and
     8 pipes, a survey with levels, a title block reading "PRACTICE JOB, NOT FOR CONSTRUCTION". Drawn once by Codex on Tim's PC from the
     office template; kept with the plugin's own files, never in a job folder.
   - Help Centre > "Open practice job" opens a **fresh copy** in the user's temporary folder every time (the shipped one is never
     changed), so it can be wrecked and re-opened.
   - The job timer and reports ignore it (the drawing carries a "practice" mark; job time, Manager's counts and pilot results skip it).
   - Settings: "Show the practice job in Help" (default ON once the drawing exists; hidden until it exists).
5. **Undo:** a normal drawing; nothing outside it changes.

## Card 4.5 — UX-HELP-06: short silent clips for the main tasks

1. **Tim ruled (26 Sep 01:28):** "Yes, for the main tasks". 5 to 10 second silent clips for the top tasks (pipe run, pit, edit, check,
   issue), made from the real windows so they stay current.
2. **Today:** no clips. The Help Centre (CDHELP) is the offline guide; F1 in a CE window opens that window's page (UX-HELP-04, built).
3. **Classification: MISSING.**
4. **Proposed:**
   - Five clips first: draw a pipe run, place a pit, edit a pipe, run the checks, issue (Civil); then beam, column, footing (Structural).
   - Recorded by Codex on a test copy (the practice job once it exists), silent, 5 to 10 seconds, no client data on screen, one file each,
     shipped with the help files.
   - Shown at the top of that task's Help page and from the welcome card's three pictures ("Show me").
   - Each clip records the CE version it was made on; a guard lists clips older than the window they show (so a changed window prompts a
     re-record rather than showing an out-of-date clip).
5. **Any builder** can build the recording and the player, the version guard and where each clip appears (ownership split removed, Tim, 29 Oct 2026: "lets remove the codex or claude ownship rubbish").

## Card 4.6 — UX-FAIL-02: "Send to admin" reaches the office admin named in Manager

1. **Tim ruled (26 Sep 12:03):** "Office admin in Manager". A Manager setting names the office admin (Tim for now); reports land in the
   office feedback folder and show as a count in the admin's Manager.
2. **Today:**
   - **Feedback** (CDFEEDBACK, ribbon Settings > Feedback): a window titled "Creative Engineering | Feedback", "Report a problem or suggest
     an improvement." It saves a file under `%APPDATA%\CE_CVL_SUITE\feedback\` and tries a second copy in the shared IT Admin "CE
     Diagnostics\feedback" folder; the footer says save the file then email it to Tim, and "This does not confirm Tim has received it."
     (`FeedbackDialog.xaml:47, 139-159`). Codex PASS 7 Y12, PASS 12 N13 (Cancel prints "CDFEEDBACK cancelled", nothing sent).
   - **CESUPPORT** (Manager): makes a support zip with a "what is in this zip" list (`PluginManagerCommands.cs:230-245`).
   - **Admin:** Manager can make "this Windows account the office administrator" (`PluginManagerWindow.xaml.cs:799`, seeded by
     `CeAdminPolicyService`). Manager counts "N feedback notes waiting" on whichever PC can read the shared folder
     (`CeFeedbackInboxService.cs:10-13`), not specifically the admin's.
   - The failure window (UX-FAIL-01) route exists as `CeMessages.Failure(...)` (`Core/Messages/CeMessages.cs:30`).
   - No button says "Send to admin" anywhere.
3. **What works:** the two-copy save, the honest "does not confirm" line, the support zip and its contents list, the admin seed.
4. **Wrong or missing:** the admin's NAME shown to the colleague; one "Send to admin" route (UX-MGR-06 merges Feedback and the support
   zip into one "Report a problem"); the count only on the admin's Manager.
5. **Classification: MODIFY.**
6. **Proposed:**
   - Manager > Settings: "Office admin: [name]" (default: the Windows account already seeded as administrator; display name typed once).
   - The button in Feedback, the failure window and Help reads **"Send to admin ([name])"**. It saves the report (with versions and the
     recent log, the drawing only if ticked) into the office feedback folder, and says honestly what happened: "Saved for Tim in the
     office feedback folder." or "Could not reach the office folder; saved on this PC: [path]. Email it to Tim." (UX-WORD-03).
   - The waiting count shows only in the named admin's Manager (other PCs show nothing), and the admin's CE bell gets one line per new
     report when the bell is switched on.
   - No email is sent by CE (no new outward route; question 5).
7. **Cancel / Esc:** closes the window, nothing saved (today's behaviour, keep). **Undo:** not a drawing change.

## Card 4.7 — UX-RECENT-01: the job button lists the last 10 jobs

1. **Tim ruled (27 Sep 01:34):** "CE panel job button". The job name on the CE panel drops down the last 10 jobs; one click opens that
   job's main drawing.
2. **Today:** no recent-jobs list (no "recent job" in Modules or Shared). CE already finds a drawing's job folder by walking up from the
   drawing (`LastPipeChoiceService.cs:35-47`, `JobFolderFromDrawing`) and the job number for the job timer (`JobTimeSession.cs:142`).
   AutoCAD's own recent files list exists (File menu), per drawing, not per job.
3. **Classification: MISSING.**
4. **Proposed:**
   - Each time a drawing in a job folder becomes current, CE records the job (folder, job number, the drawing) at the top of a per-user
     list of 10 (Settings file, per Windows user; never in the drawing).
   - **"Main drawing"** = the drawing in that job the user opened most recently (question 6: Tim may prefer the job's C01 or S01).
   - The job button (card 4.8) drops down "25-123 · C01 stormwater plan.dwg · yesterday". One click opens it (or switches to it if open).
     A drawing that no longer exists shows greyed "moved or deleted" with "Remove from list".
   - Practice job and temporary folders are never listed.
5. **Undo:** none (opening a drawing is AutoCAD's own action).

## Card 4.8 — UX-PANEL-01 and UX-PANEL-02: the CE panel

1. **Tim ruled (27 Sep 02:01):** PANEL-01, all four: job name + mode (with recent jobs), a health line (one green/amber/red line, "Network
   OK" or "3 items to check", click opens Checks), the CE bell count, the find box. PANEL-02: "Follows the drawing": the Civil/Structural
   switch changes to the drawing's discipline when drawings change; it can still be flipped by hand.
2. **Today:**
   - The CE panel (`CeCvlRibbonContributor.cs:35-44`) holds: Start Here (highlighted until opened), Ask CE, Help Centre, CE Blocks, and a
     button labelled **"Civil"** (CDDISCIPLINE: "Show or set whether this drawing is Civil or Structural ... for this drawing only").
   - Every panel carries a Civil/Structural/Any tag, but the shared ribbon builder never reads it (no "discipline" in `RibbonBuilder.cs`),
     so **the middle panels do not switch today**; Structural has its own "CE STRUC" tab (Codex W22 START CHECK: "CE and CE STRUC tabs
     visible").
   - The CE bell is built and hidden behind a Settings switch, default OFF (UX-MSG card).
   - CEFIND is a typed command (`CeFindCommand.cs:30`), not a box on the panel.
   - Job mode is stored per job and per discipline by CDSETUP (UX-DES-01, merged #348).
3. **What works:** Start Here, Help Centre, Ask CE, the per-drawing discipline record, CEFIND, the bell, the job mode.
4. **Wrong or missing:** job name + mode, health line, bell count copy, find box on the panel; the switch following the drawing.
5. **Classification: MODIFY** (panel) / **MISSING** (health line, job button, find box, switching).
6. **Proposed panel, left to right:**
   - **Job button:** "25-123 · From markup" (job number from the job folder; mode from CDSETUP; "No job" when the drawing is not in a job
     folder). Click: the recent-jobs list (card 4.7) and "Job set-up..." (CDSETUP).
   - **Health line:** one line, green "Network OK", amber "3 items to check", grey "Not checked yet". Same numbers as the Checks palette
     (Batch 2 card 2.2). Click opens Checks. Refreshes after CE's own quiet re-check, never runs a check by itself.
   - **Bell count:** "CE 3", the same count as the status-bar bell; shown only when the bell switch is on.
   - **Find box:** type P7, WT1 or FB3, Enter: the same as CEFIND (zoom, highlight, Back).
   - Start Here, Help Centre, Ask CE, CE Blocks stay.
   - **Discipline switch (PANEL-02):** the button shows the CURRENT drawing's discipline ("Civil" or "Structural") and changes when
     another drawing becomes current; clicking it still sets it by hand for that drawing (today's CDDISCIPLINE, kept). Making the middle
     panels actually switch is UX-RIBBON-01's work and is NOT in this card; this card only makes the button and the panel follow.
7. **Undo:** none of these change the drawing, except CDDISCIPLINE's existing record (one U, unchanged).
8. **Discovery:** the panel is on the CE tab at all times.

---

## Recommended answers a builder may use now (INT-073)

1. Splash 1 s minimum, 3 s maximum; switch default ON (Tim's ruling).
2. Welcome card instead of What's New on the very first start; Quiet start stops both.
3. Practice job: build the Help item behind a switch, using a MADE-UP job, hidden until the drawing exists.
4. Tips: Settings count, default 1.
5. "Send to admin" saves to the office folder; CE sends no email.
6. "Main drawing" = most recently opened drawing of that job.
7. Health line refreshes only from CE's existing quiet re-check.
8. Discipline button follows the drawing now; the middle-panel switch waits for UX-RIBBON-01.

## Tests (automated, before Codex)

1. Splash: not shown when the process is accoreconsole or headless; closes within 3 s; Settings OFF shows nothing.
2. First start with an empty settings file: the welcome card's "shown" record is written before the window opens; What's New does not open
   that start; second start: neither opens (unless the version changed, then What's New only).
3. Tip count from Settings: 1 shows once, 3 shows three times, OFF never; never on an edit window.
4. Recent jobs: 12 job folders opened gives 10, newest first; a drawing outside a job folder is not listed; a deleted drawing shows as
   "moved or deleted"; the practice job never appears.
5. "Send to admin": office folder missing gives the honest local-save line; the admin count rises only on the named admin's account.
6. Discipline button text equals the current drawing's discipline after a drawing switch (pure policy test on `DrawingDisciplinePolicy`).
7. Health line numbers equal the Checks palette's numbers on DWG-B.
8. Practice job: opening it twice gives two fresh copies; the shipped file's hash is unchanged; job time records nothing for it.

## Example drawings

1. `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B.dwg` copied into a test job folder named like a job number (for the job button and recent
   jobs), plus a second and third copy in two other job-numbered folders.
2. A drawing outside any job folder (Desktop copy) for the "No job" case.
3. A Structural test drawing (Codex's C1 column copies) for the discipline switch.
4. A fresh Windows profile is NOT needed: tests reset the per-user settings file in a test folder (CE_LOG_DIR_OVERRIDE pattern used by
   the What's New tests).

## Tim's AutoCAD checklist (about 8 minutes, Codex does it first)

1. **Splash:** start AutoCAD. **Should see:** a small CE splash for a second or two, gone by itself; no click needed; the command line
   says "CE ready. New? Click Start Here on the CE tab."
2. **Welcome card (Codex resets the first-start record first):** **Should see:** one card, three pictures; AutoCAD still usable behind
   it. "Show me" opens Start Here. Restart: no card, no What's New.
3. **Tip:** type `PITSCHEDULE` the first time. **Should see:** one "Tip:" line, once only.
4. **Job button:** open the test job drawing. **Should see:** "25-xxx · From markup" (or the mode you set) on the CE panel; click it:
   the recent jobs, newest first; click another: it opens.
5. **Health line:** move a pipe off its pit. **Should see:** the panel line turns amber "2 items to check"; click: Checks opens.
6. **Discipline:** switch to a Structural drawing. **Should see:** the button reads "Structural"; back to Civil: "Civil".
7. **Send to admin:** Feedback > "Send to admin (Tim)". **Should see:** "Saved for Tim in the office feedback folder." Your Manager shows
   1 waiting.
8. **Practice job (once it exists):** Help Centre > Open practice job. Draw, save, close, open again: a clean copy.

## Code references (Civil release commit 446162c2; Manager module from the same commit)

Under `Modules\Drainage\`: `PluginInitialization.cs:495-517` (idle banner), `:531-554` (What's New once, Quiet start, modeless),
`:674-682` (status pane text); `Services/WhatsNewVersionGate.cs:23-24` (quiet-start line); `Commands/StartHereCommand.cs:20-44`;
`Services/FirstRunTourService.cs:24, 32-42`; `Dialogs/StartHereTourDialog.xaml:39-71`; `Models/UserSettings.cs:305-348`
(OnboardingSettings: tour opened, tip counts, tips on, CDEDIT faster-way); `Services/UsageTipService.cs:21, 32-48`;
`Services/DialogService.cs:110-123` (the two tips, F1 help); `Services/CeCvlRibbonContributor.cs:35-44` (CE panel), `:271-291` (Start
Here button); `Services/LastPipeChoiceService.cs:21-47` (job folder from drawing); `Core/JobTime/JobTimeSession.cs:135-153`;
`Commands/DisciplineCommand.cs:19`; `Services/DrawingDisciplineService.cs:8-16`; `Commands/CeFindCommand.cs:30`;
`Commands/FeedbackCommand.cs:30`; `Dialogs/FeedbackDialog.xaml:4, 44-47, 122-162`; `Services/CeBellStatusBarService.cs` (header);
`Core/Messages/CeMessages.cs:30`; `Commands/CivilDesignCommand.cs:399` (CDSETUP). `Shared\CE_SHARED\Contracts\ICeRibbonContributor.cs:48`
(panel discipline tag) and `Shared\CE_SHARED\Services\RibbonBuilder.cs` (no "discipline" in the file). Under `Modules\Manager\`:
`Commands/PluginManagerCommands.cs:230-245` (CESUPPORT); `UI/Dialogs/PluginManagerWindow.xaml.cs:790-810` (admin seed);
`Services/CeFeedbackInboxService.cs:9-90`. Not found anywhere in Modules or Shared on that commit: a splash, a welcome card, a recent-jobs
list, a practice job, help clips, a "Send to admin" button.
Codex: `CODEX_TEST_REPORT_PASS12_2026-09-26.md` items 18, 21; `CODEX_TEST_REPORT_PASS7_2026-09-24.md` item Y12;
`CODEX_SWEEPC1_2026-09-30.md` items 8, 13, 14, 311; `C9_OPUS_FINALIZER_2026-10-03.md` item 7 (What's New once, modeless, Quiet start);
`CODEX_VERIFYC1_2026-10-01.md` item 11 (displayed versions); `CODEX_VERIFYW22_2026-10-08.md` item 9 (CE and CE STRUC tabs).
