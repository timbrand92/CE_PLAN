# Release 9 Nov: gap analysis and day-by-day plan (Civil + Manager to Max)

Written Thu 22 Oct 2026 (late) to Fri 23 Oct (early), Melbourne, by the release planner (Opus 5.5, Max account, desk plan/03). Read-only: nothing built, run, installed or opened in AutoCAD. The only file written is this one.

**Sources read:** `V3_RECOUNT_2026-10-22.md` (recount 3), recount 2 and recount 1, `START_HERE.md`, `release-v3-colleagues.md` (release gate and charter), `release-v3-colleagues-DESK_CONTINUITY_RECORD.md` (sections 1 to 32; the file has no section 31 or 33), `decisions/2026-10-20_TIM_ANSWERS.md`, `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `AUDIT_ENGINEERING_CIVIL_2026-10-22.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `TESTING_REBUILD_SPEC_2026-10-22.md`, `TESTING_RESEARCH_CODEX_2026-10-22.md`, `CODEX_ACCEPTANCE_BACKLOG_22OCT.md`, `QUESTIONS_FOR_MONDAY.md`, the two 21 Oct plan queues, the 17 Oct gap audit, `V3_UX_PLAN.md`, the 25 Sep rulings, BUG_CARPARK status lines for the gate bugs, and the DESK_LOG tail.

**Two corrections to the brief, said first (RULES 6.2):**

1. **"Acceptance = a runner pass in two sessions" is not yet a rule.** It is the spec's proposal (`TESTING_REBUILD_SPEC` section 4.2), waiting for Tim's word. Until he rules, acceptance stays "robot PASS plus Codex PASS" (decisions item 17). It is question 1 for Thu 29 Oct below.
2. **Mon 2 to Fri 6 Nov is not five working days.** Tue 3 Nov 2026 is Melbourne Cup Day, a public holiday. The soak on Tim's PC gets four working days unless the freeze moves to Sat 31 Oct.

---

## ANSWER FIRST (for Tim)

### Is 9 Nov achievable?

1. **Yes, with cuts.** Max can get a working Civil + Manager on Mon 9 Nov if it is a small pilot: the drafting tools already installed on your PC, bug-fixed and machine-tested, installed by hand with AutoCAD closed (the route you already approved on 20 Oct). It cannot be the whole 9 Nov plan scope.
2. **What the numbers say:** of the 390 items in the 9 Nov scope, 290 are built, 184 installed, 123 switched on, 5 tested on today's build, 0 accepted. About 100 are not built at all. Ten build days cannot close that, and no unbuilt item could be tested properly before the freeze.
3. **Two checkpoints decide it:** Fri 30 Oct (is the new test pack passing the daily tools?) and Fri 6 Nov (your word to hand it over). If either says no, the fallback date is **Mon 16 Nov**. One more week, same plan.

### What must be cut or moved to after 9 Nov

1. **The self-serve installer and the Manager update button.** The installer needs Windows administrator rights, has no normal "double-click to install" route, and approvals carry your PC's folder path. Max gets a hand install instead. You install his updates the same way.
2. **Every unbuilt plan item:** first-day welcome and tips, the "Send to admin" failure window, the one-tab ribbon, C01/C02 sheet set-up, council rules inside Checks, the detention chain, Level 3 proposals, pump stations, WSUD, site and slab, Settings search. All move to after 9 Nov.
3. **Switched-off features stay off** unless the pack and Codex pass them before Fri 30 Oct (Tidy labels, the Checks palette, ignore a finding, wrong-layer rows, pipe sizing, late survey).
4. **Structural stays on your PC only** (your 17 Oct ruling). Nothing from Structural ships to Max.

### The three biggest risks

1. **The new testing is not proven yet.** Its first piece is being built tonight. If it is not passing real checks by Tue 27 Oct, acceptance stays near zero and we cannot show Max's build works. Fallback: robot plus Codex on 15 core checks only.
2. **Getting it onto Max's PC.** Four installer faults block a normal install. The hand install avoids three of them, but it has never been rehearsed on a PC like Max's (ordinary user, no administrator rights). We need a spare Windows login to rehearse it by Fri 30 Oct.
3. **Wrong numbers on a drawing.** The engineering audit found three serious ones. Example: on two real Glen Eira jobs CDDESIGN's rainfall reads 6 to 8 per cent low, so storage comes out about 18 per cent short, while its note says the result is on the safe side. A 2.58 m3 tank would show as 2.12. These three get fixed before the freeze, or the tool gets a plain warning.

---

## 1. 9 Nov scope items NOT yet built, ranked by what Max would miss most

**How to read this.** The recount names about 100 unbuilt items in the 9 Nov scope (Civil 27, Manager 3, Shared 70). Ranking is my judgement of a drainage drafter's working day. Size: S = a day or less for one builder, M = two to three days, L = more than the time left. "Lane" = who would build it. My recommendation is in bold. Nothing unbuilt can be reviewed, trained, installed and tested twice before Mon 2 Nov unless it is S.

### 1a. Not plan items, but Max cannot be handed the build without them (build before the freeze)

1. **Delivered files must be byte-identical to the tested build.** Today the installer script rebuilds the native files instead of sealing the tested ones (the "payload 85" fault; Codex gate audit finding 4). M, lane 04 plus an Opus review. **Build: the packaging step takes the frozen candidate folder and refuses any file whose hash differs.** For the hand install, the desk copies the frozen candidate folder and reads every hash back.
2. **Hand-install procedure for a standard Windows user.** Copy the two bundle folders into the user's AutoCAD plug-ins folder with AutoCAD closed, plus your behaviour switches (sanitised: no recent files, no paths). S, desk. **Build, then rehearse twice on a spare login.**
3. **Engineering HIGH 3, the rainfall note.** CDDESIGN must stop calling the office curve "high". S, lane 03. **Build.** (Wording only; your question 2 below.)
4. **Engineering HIGH 2, the network solver assumes every pipe is UPVC.** On a concrete line it over-states capacity by about 23 per cent. S to M, lane 03. **Build: use the drawn material.** If it slips, hide CDRUNSOLVE from Max.
5. **Engineering HIGH 1, CDRULES and CDCHECKS measure grade pit-centre to pit-centre.** A dog-leg pipe can pass at 1 in 170 when the label says 1 in 240. M, lane 03. **Build: use the drawn route length** (the pipe-size review already does).
6. **Pit Schedule depth to the pit floor** (your 20 Oct ruling; the schedule still measures to the outlet). Example: cover 11.00, outlet 10.15, floor 10.05: the schedule says 0.85 m and no step irons, CDRULES says 950 mm and step irons. S to M, lane 03. **Build.**
7. **The command outcome log line says "cancelled" when PIT, CD or DP finished normally with Esc** (BUG-862). The test evidence reads these lines. Fix drafted 22 Oct. S, lane 04. **Train it.**
8. **CDCHECKIGNORE saves the drawing record while saying "Nothing was changed"** (BUG-863), and U after a re-list does not undo (BUG-866). Fixes drafted or building. S. **Train both, keep the switch OFF for Max.**
9. **Downpipe double-click still opens AutoCAD's attribute editor** (BUG-859 round 2, #1522; green DP label BUG-860, #1521). S, already built. **Train both; if the pack does not pass them, Max is told to select the downpipe and type CDEDIT.**
10. **No blue** (BUG-517, release gate item 9). Fix built, not installed. S. **Train it; Codex looks at three windows and the printed computations sheet.**
11. **The Glen Eira back-test fixture** (the one red test; the engine is right, the test feeds 2024 inputs). S, lane 03. **Fix the test, keep the 30 per cent band.**

### 1b. Unbuilt plan items, ranked by what Max would miss

1. **UX-MGR-04, quiet update at next start (the step that starts the installer).** Max would miss easy updates most. L (it runs a program; Opus wants a separate helper and a signature check). Lane 04 plus Opus design. **Cut: you update Max by hand install during the pilot.** First job after 9 Nov, together with the approval-path fix (gate audit finding 3, M).
2. **UX-FAIL-01 / 02, a failure window with "Send to admin".** M, lane 04 plus Codex window. **Cut: Max uses CDFEEDBACK (installed, sends to the office feedback folder) plus a screenshot to you.**
3. **UX-FIRST-01 to 03, UX-START-01, UX-HELP-01 / 06, the first day (welcome card, first-use tips, practice job).** M each, Codex windows plus lane 04. **Cut: replace with the one-page guide (section 5) and a 30-minute sit-down on 9 Nov.**
4. **UX-MIX-02 and UX-DWG-03, mixed AutoCAD years ("needs AutoCAD 2027" greying; drawings readable without CE).** M, lane 03. **Depends on Max's AutoCAD year, which is not recorded anywhere (question 7).** If Max is on 2027: not needed for the pilot. If older: the pack must open one of your drawings with one-piece CE pipes on that year before the freeze.
5. **UX-SCHED-01b, a value typed in the Pit Schedule updates the pit (all values).** M, lane 04 plus Codex. **Cut;** the schedule behaves as it does on your PC today.
6. **UX-TANK-01 (one-line tank callout without detention) and the detention chain (CDPITDETENTION).** M and L, lanes 03 / 04. **Cut.**
7. **C01 / C02 sheet set-up: UX-CPLAN-04, UX-DET-08, X-C11.** L, needs a card first; the engines sit on open PRs. **Cut.**
8. **Council rules: UX-CR-10 and X-C07 (sourced council values); UX-CR-01 to 17 are built but not installed.** L. **Cut.** CDRULES keeps the council values it has today.
9. **UX-RL-04 / 05, assumed datum when there is no survey; a later survey fills in.** M, lane 03. **Cut.**
10. **UX-LYR-03, colour ByLayer always.** S to M, lane 04. **Cut; add a check to the pack that CE objects plot correctly with your pen table.**
11. **UX-SET-01 / UX-SET-08, Settings search and "office changes hit new work only".** M, Codex plus lane 03. **Cut.**
12. **UX-PERF-01, progress with Cancel for slow commands.** Part built, OFF. M. **Cut; stays OFF.**
13. **UX-SITE-01, UX-SLAB-01 / 02, UX-SPS-02 to 04, UX-WSUD-02 to 04, UX-SCHED-04b, UX-L3-02 / 19 / 20, X-C09.** L, mostly uncarded. **Cut.**
14. **Shared, 70 items** (one-tab ribbon and CE panel, held by your ruling F2; Ask CE; keyboard access; the issue register; Civil-Structural reading; recent jobs; right-click CE group; Enter applies / Esc cancels everywhere). L in total, mostly uncarded. **Cut, all.**

### 1c. Built but not installed, worth a line

1. **The four Civil Settings pages (#1208, #1246, #1251, #1252)** are on stale bases. M, Codex lane. **Re-cut if a Codex lane is free by Mon 26 Oct; otherwise Max gets your switches as a file and no Settings rows for the new switches.**

### 1d. Lane orders this implies (from Fri 23 Oct)

1. **Lane 03 (Civil engine, Sonnet):** items 1a-3, 1a-4, 1a-5, 1a-6, 1a-11, in that order.
2. **Lane 04 (Civil drafting / installer, Sonnet):** 1a-1 (with Opus), then BUG-862 / 863 fix rounds, then the approval-path fix as a DRAFT for after 9 Nov.
3. **Lane 02 (Structural, Sonnet):** BUG-864 (CEMEMBER resets an existing hidden layer's linetype), then CEMEMBER as you ruled. No Civil release work.
4. **Codex lanes:** BUG-866, the Settings page re-cut, then window looks at the pack's pictures only (no more Codex driving AutoCAD once phase 2 passes).
5. **Desk Sonnet jobs:** runner phase 2, 3 and 4, and the 30 case files in section 2.
6. **Opus:** review of every PR above, train finalizers, a re-audit of the installer change, and the freeze report.

---

## 2. Built, installed, no test: the 30 the test pack should cover first

**How I chose them.** Daily tools Max will use on his first job, in the order he would meet them. All are Civil + Manager + Shared, all believed installed and switched on with your settings, none has a robot or Codex PASS on 3.0.70 (recount 3 section 5 and the backlog). **Caveat:** no recount ever saved a per-item installed list, so the case writer must confirm each ID is on the frozen line (`git log --grep` and the switch default) before writing its case. These are cases C41 to C70, after the spec's C01 to C40 (which are mostly bug checks).

1. **UX-STD-01b** PIT and CD carry on until Enter or Esc.
2. **UX-PIT-02** a pit catches a pipe end only within its outline plus 100 mm.
3. **UX-PIPE-02** a new pipe end auto-joins the only matching pit within 75 mm.
4. **UX-PIPE-03** Esc at CD's third point cancels cleanly.
5. **UX-PIPE-04** recent diameter, material and invert values in the New Pipe window.
6. **UX-PIPE-05** "Hide" grade on every pipe type.
7. **UX-SRC-05** DP and CDRG place like pits, before pipes.
8. **UX-SRC-01** OF and FO share one symbol, different tag.
9. **UX-CPLAN-21** pit label shows number and cover level.
10. **UX-CPLAN-23** pipe label mid-pipe along the line ("100 DIA. UPVC PIPE AT 1 IN 100").
11. **UX-CPLAN-24** a short pipe's label goes out on a leader.
12. **UX-CPLAN-26** one IL text per pipe end at the pit.
13. **UX-LBL-01** a hand-placed label stays where it was put after an edit.
14. **UX-EDIT-01** ERASE a pit: pipes stay with free ends, one U restores.
15. **UX-EDIT-02** COPY makes real CE copies, renumbered.
16. **UX-EDIT-04** EXPLODE allowed with a note of what left the schedule.
17. **UX-STD-06** editing part of a selection never changes the selection.
18. **UX-STD-03** CE never saves the drawing (the file date does not change).
19. **UX-UNDO-01** (whole item) every CE Undo step has a plain name.
20. **UX-CPLAN-18 / 19** pit numbering from the outlet, main line first.
21. **UX-SCHED-06** Pit Schedule in natural mark order (P1, P2 ... P10).
22. **UX-SCHED-04** a long Pit Schedule continues on the next sheet with headers.
23. **UX-SCHED-02** Excel export with a checking sheet.
24. **UX-LYR-01** CE objects land on office layers, current layer untouched.
25. **UX-LYR-04** existing greyed on EX layers, demolished dashed on DEMO.
26. **UX-SURV-03** CDSL shows the survey level as existing.
27. **UX-REP-01** CDSYNC and CDREBUILD warn before they run.
28. **UX-IMP-02** CDCHECKDWG ends with one summary line and opens the list.
29. **UX-WORD-03** CDFEEDBACK prints the one honest result line (sent, or saved on this PC). Max's bug route depends on it.
30. **UX-RIBBON-01** selecting a pipe or pit jumps to its contextual tab.

**Also run, every pack:** the spec's C03 (clean start-up log), C12 (About CE Suite, Manager-owned), C31 to C34 (REDO), C35 / C36 (import units), C37 to C40 (daily regressions).

---

## 3. Acceptance backlog: what must pass before the freeze (two-minute read)

**Rule used:** "pass" = robot or runner PASS plus a Codex PASS (today's rule), or two runner sessions if you say yes to question 1. Engineering judgement still needs your word.

1. **[ ] Hand install rehearsed twice** on a standard Windows login with no administrator rights. Both bundles arrive, About shows Civil and Manager, Structural "Not loaded".
2. **[ ] Delivered files = tested files.** Every file's hash in Max's package equals the frozen candidate on your PC. Zero missing, extra or changed.
3. **[ ] Civil and Manager carry the identical shared file** in all three AutoCAD lanes (2022-24, 2025-26, 2027).
4. **[ ] Nothing leaves the PC.** AI features OFF; X-Civil AI extraction and CDASK do not send; Max is told not to press CEMANAGERDIAG or the support bundle (BUG-488 has no fix).
5. **[ ] No blue** in the windows Max uses or on the printed computations sheet (BUG-517).
6. **[ ] Import units safe.** A metre drawing and a unitless drawing never come in 1000 times too big without a word (C35, C36).
7. **[ ] The daily tools pass:** PIT, CD, Edit Pipe cascade with U and REDO, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts, Tidy labels names the pipe, plus the 30 in section 2. Target: at least 30 of these 40 accepted.
8. **[ ] REDO.** C31 to C34 pass, or BUG-861 is written down as a known problem in Max's page.
9. **[ ] The three engineering HIGHs** are fixed and pass their tests, or each tool carries a plain warning.
10. **[ ] The outcome log line is honest** (BUG-862), because it is the evidence.
11. **[ ] Clean start-up** on a fresh profile: no CE error lines in the log.
12. **[ ] Max's switches = your behaviour switches**, compared value by value, differences listed for your yes.
13. **[ ] Your PC runs the frozen build** from Mon 2 Nov with no new serious bug through Fri 6 Nov.
14. **[ ] Max's AutoCAD year checked:** start-up and one of your drawings opened on that year.
15. **[ ] Your word** on the engineering questions below and "yes, hand it to Max" on Fri 6 Nov.

---

## 4. Day-by-day plan, Fri 23 Oct to Mon 9 Nov (Melbourne)

**Fixed facts:** until Thu 29 Oct AutoCAD testing runs at any hour (your ruling E1). From Thu 29 Oct testing runs only 2:00 to 3:00 pm, after 5:30 pm, before 8:30 am, weekends and the Cup Day holiday. One AutoCAD session at a time. Meters: Max resets Fri 23 Oct 13:00, Team Sat 24 Oct 14:00, Codex Tue 27 Oct 17:37 (or earlier if the announced reset lands).

1. **Fri 23 Oct (build).** Read and Opus-review driver v3 phase 1. Start runner phase 2 (C01 to C10). Lane 03 starts the rainfall note and the solver material. Lane 04 starts the packaging seal. Train C-61 assembled: BUG-862, 863, 864, 866, #1521, #1522, BUG-517.
2. **Sat 24 Oct (test).** Runner phase 2 self-test in real AutoCAD. Install C-61; pack C01 to C10, twice. Desk writes the hand-install procedure.
3. **Sun 25 Oct (build + test).** Runner phase 3 (C11 to C40). First full pack overnight. Desk sends Codex the first 3 KB look brief.
4. **Mon 26 Oct (build).** Second full pack session. Case files C41 to C70 written. Lane 03 starts the route length and the Pit Schedule floor. Codex re-cuts the Settings pages if free.
5. **Tue 27 Oct (test).** Pack C01 to C70 run. **Early checkpoint:** if the runner is not passing real checks by tonight, switch to robot plus Codex on 15 core checks. Codex reset 17:37.
6. **Wed 28 Oct (build).** Train C-62: engineering fixes, packaging seal, Pit Schedule floor, Settings pages if reviewed. Opus re-audits the installer change. Full pack twice overnight. Desk prepares your one-page question list.
7. **Thu 29 Oct (you are back).** 08:40, 15 minutes: the questions below. Pack runs only in the free windows. Results go into the acceptance list.
8. **Fri 30 Oct (checkpoint 1).** Desk and Opus decide GO or slip to 16 Nov: is the pack green on the daily tools, is the hand install written, is a spare Windows login ready? You or IT set up that login (it is a Windows security setting, so not ours to make).
9. **Sat 31 Oct (build the candidate).** Train C-63 = the freeze candidate, built from C-62 plus any blocker fixes only. Full pack twice. Codex looks.
10. **Sun 1 Nov (dry run 1).** Clean-PC rehearsal 1 on the spare login: hand install, About, one PIT, one CD, CDFEEDBACK, uninstall, reinstall. Install the candidate on your PC tonight.
11. **Mon 2 Nov (FREEZE).** No more changes except release blockers; any blocker fix = new candidate plus two full pack runs. Your weekly 08:40 questions, if any are left.
12. **Tue 3 Nov (Cup Day holiday).** Full-day free AutoCAD window: pack on the frozen build, mixed-year check if Max is not on 2027.
13. **Wed 4 Nov (package).** Build Max's package from the frozen folder (no rebuild); compare every hash. Clean-PC rehearsal 2 with that exact package.
14. **Thu 5 Nov (soak).** Nightly pack on the frozen build. Desk finishes Max's one-page guide with the real known-problems list.
15. **Fri 6 Nov (checkpoint 2).** Opus freeze report: what passed, what is known, how to roll back. **Your word: "yes, hand it to Max".** Then the package goes to the pilot folder (that is publishing, so it needs your word).
16. **Sat 7 and Sun 8 Nov.** Nothing changes. Nightly pack only.
17. **Mon 9 Nov (hand-over).** With Max's AutoCAD closed: hand install (about 20 minutes), read back versions, five-step check together (PIT, CD, Edit Pipe, Pit Schedule, CDFEEDBACK), give him the page. Daily check-in for the first week.

### Questions you answer first on Thu 29 Oct (recommendation in brackets)

1. **Acceptance rule:** a drawing value or log line counts as accepted when the runner passes it in two separate AutoCAD sessions; windows still need a Codex look at the picture (recommend yes).
2. **Rainfall note:** CDDESIGN says the office curve "may be high or low, by up to about 8 per cent; storage moves about 2.5 times as much" (recommend yes).
3. **Pit Schedule depth to the pit floor** where the pit has one, matching your 20 Oct ruling (recommend yes).
4. **Unitless import (BUG-505):** import as millimetres with one soft line "This drawing has no units set" (recommend yes).
5. **Pit label double-click:** turn the Edit Pit window on only after it passes a Codex look (recommend yes).
6. **Green DP label double-click (BUG-860):** opens the Edit source window when the label belongs to that downpipe (recommend yes).
7. **Max's AutoCAD year, and does his Windows login have administrator rights?** Not recorded anywhere. It decides the mixed-year check and the install route.
8. **Who sets up a spare standard Windows login** for the dry runs by Fri 30 Oct: you or IT? (recommend the spare work PC from your 17 Oct ruling D5)
9. **Delete cell in Pit Schedule Remarks on a deep pit:** blank, or "With Step Irons"? (old recommendation "With Step Irons"; the installed fix gives blank)
10. **Engineering items that wait until after 9 Nov,** unless you want them now: cover to the outside of the pipe, the obvert check where the pipe gets bigger, the minimum grade ladder (recommend after; Max's page says how CE measures today).

---

## 5. What to tell Max (one page, plain English)

**A fuller hand-over pack is being drafted in parallel (`areas/colleague-pack/`). This is the short version; the desk reconciles the two before Fri 6 Nov.**

### CE for AutoCAD: your pilot copy (9 Nov 2026)

1. **What it is.** CE Civil and CE Manager, the drainage drafting tools Tim uses every day. You are the first colleague to get them. Expect some rough edges; your reports shape the next versions.
2. **What is in.** Placing pits (PIT) and pipes (CD) that carry on until Esc; downpipes and sources; double-click a pipe or its IL text to open Edit Pipe; the Pit Schedule; pit and pipe labels in office style; CDTWL water levels; CDCALC and CDDESIGN calculations; CDRULES checks; CDSL spot levels and CDSURVEY; X-Civil import; CDHELP; CE_VERSION (About). Settings are Tim's own.
3. **What is not in yet.** Structural; automatic updates (Tim installs updates for you); the welcome tour; C01/C02 sheet set-up; council rules inside Checks; Level 3 proposals; AI features (switched off, nothing leaves your PC).
4. **Known problems (work-arounds in brackets).**
   1. Double-clicking a downpipe may open AutoCAD's attribute editor (select it and type CDEDIT).
   2. Double-clicking a pit label opens AutoCAD's own editor (that is normal for now).
   3. REDO is sometimes lost after picking a pit (U always works; redo the step by hand).
   4. CDRULES measures cover to the inside top of the pipe and only at the pits (allow for the pipe wall and check low points between pits).
   5. CDDESIGN storage on the office rainfall curve can read low (use the site's own rainfall for anything issued, or ask Tim).
   6. Tidy labels may leave a label where it is and say "No clear spot" (move it by hand).
   7. A drawing with no units set is read as millimetres (check the scale after import).
   8. Do not use Manager's "Get update ready", the support bundle or CEMANAGERDIAG yet.
5. **How to report a bug.** Type **CDFEEDBACK**, choose Problem, and write three lines: what you did, what you expected, what happened. Send Tim a screenshot on Teams. If a drawing looks wrong, do not save over it: close without saving and tell Tim the file name.
6. **How to tell which version you have.** Type CE_VERSION. Quote the Civil number in every report.
7. **Undoing the install.** Tim keeps a copy of your old setup; one step puts it back.

*(The known-problems list is fixed on Thu 5 Nov from the frozen build's test results. Items fixed by then come off it.)*

---

## 6. Where the evidence is thin (said plainly)

1. **Which of the 390 items are installed, one by one:** never saved by any recount. Section 2's 30 IDs are my selection and must be checked against the frozen line.
2. **The test pack:** nothing in it has run yet. All dates in section 4 assume phase 2 works by Sat 24 Oct. If it slips two days, every date after it slips two days and 16 Nov becomes likely.
3. **The installer and hand install:** all four blockers are from reading the code (Codex gate audit), not from a failed install. The hand install has never run on a standard-user login.
4. **Max's setup:** his AutoCAD year, his Windows rights and his company's Windows protection are unknown.
5. **The engineering HIGHs:** verified by reading and worked by hand against two issued sheets; not yet run in AutoCAD.
6. **Size guesses** (S/M/L) are mine, from similar past PRs; none was estimated by the lanes.
7. **Bugs:** 463 bugs wait for acceptance. This plan accepts only the ones on Max's daily path; the rest stay awaiting, honestly labelled.

---

## Summary (under 120 words)

9 Nov is achievable with cuts: a small pilot of the Civil + Manager tools already on Tim's PC, installed by hand with AutoCAD closed. About 100 unbuilt plan items, the self-serve installer and the Manager update button move after 9 Nov. Before the freeze (Mon 2 Nov): seal the delivered files to the tested build, rehearse the hand install on a standard-user login, fix three engineering HIGHs (rainfall note, solver material, route length) and the Pit Schedule floor depth, and get the new test pack passing 30 of 40 daily-tool checks. Checkpoints Fri 30 Oct and Fri 6 Nov; fallback date Mon 16 Nov. Biggest risks: unproven testing, the untried install route, wrong engineering numbers.
