# LANE ORDERS, Tue 20 Oct 2026 evening (from Tim's answers: decisions/2026-10-20_TIM_ANSWERS.md; READ THAT FILE FIRST)

These orders OVERRIDE the PAUSE paragraph in your job text where they differ. Everything else in your job text (RED test first, DRAFT PRs, Settings switches, R-27 no hard blocks, plain wording, redo-safe, short log lines) stands.

**Tim's ruling in his words:** "pause until im back and then full steam ahead to v3, unless we finish bug fixes before then, if we do then full steam ahead to full v3. we want to get the colleague issue ready for 9th november". So: bugs first; when the bug queue is truly empty (the desk decides), plan items resume at once, 9 Nov scope first (Civil + Manager + Shared, 390 items), then the rest of V3. When your lane's bug work and these orders are done, write 'no bug work left' in your TEAMLANE log and END; the desk then issues the plan queue.

## Lane 02 (Structural builder) - CEMEMBER: BUILD NOW (Tim: "build now")
1. CEMEMBER replaces SBEAM. Sources, read in order: areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md (approved), decisions/2026-10-18_CEMEMBER_DESIGN.md, decisions/2026-10-19_CEMEMBER_ANSWERS.md, areas/structural.md (CEMEMBER updates), BUG_CARPARK BUG-818/819, memory note cemember-replaces-sbeam-design-18-oct.
2. Hard rules that still bind: the draft section list (04_REFERENCE/section_data_2026-10-18) is REFERENCE ONLY and must NOT be copied into section-catalogue.json until Tim has reviewed the ten-row check; scale comes from DIMSCALE (default 100), LTSCALE = 10 x DIMSCALE (warn only); layers 25cont, 18cont, 18hidden, 9hidden2, HATCH 10 with the 10H hatch; never two lines on top of each other; four orientations; Z-kink break lines on 18CONT; everything numeric on the Settings page (R-00); protect locked layers/Xref/REFEDIT; redo-safe; Structural stays on Tim's PC only.
3. Build in small stacked DRAFT PRs on the newest Structural head (S-38 line claude/rel-20261017s or newer): (a) engine for one section (UB) with tests from the card; (b) the other section types in the card; (c) the command and its prompts; (d) the Tim AutoCAD checklist as a file in areas/ (one UB, one PFC in all four orientations, one angle in all four, one SHS, one Z purlin, section in front and beyond, break line sizes at 1:20 and 1:100, Escape, Undo, Enter-to-repeat) for Tim to approve. Tag every PR 'needs Opus review'.
4. After CEMEMBER foundations, continue the Structural bug queue.

## Lane 03 (Civil/Manager builder) - scale model and wording fixes
1. **All scales come from the drawing scale** (Tim item 12: "all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale"). One scale source: DIMSCALE (LTSCALE = 10 x DIMSCALE, warn only). Make the Dimension tool (AD) accept every DIMSCALE (no 'only 20 or 100' refusal, BUG-748 related), hatch density the same dots per square cm of paper at every scale (BUG-748; replaces the unapproved straight-line value), break lines/text/hatch sizes derive from the same value; any per-scale number a drafter may want to change is a Settings value. Start with a survey PR that lists every place the code branches on 20/50/100, then fix them one by one, RED test first, behind the existing Settings pattern.
2. **BUG-531**: 25C and EBT text heights follow ONE Settings value (the Label plot height setting).
3. **DP1 double-click**: opens a small Edit window like pipes (Tim: yes); follow the pipe Edit window pattern, wired through the existing double-click path.

## Lane 04 (Civil/Manager/installer builder)
1. **BUG-825**: the 1000 -> 900 mm step-iron move runs ONCE only, so a later deliberate 1000 stays 1000 (record that the move was done; Settings, today's behaviour on first run).
2. **BUG-834**: old installer packages: warn plainly and carry on (R-27), but REFUSE a build older than the one the office has approved for that PC. Installer tests are compile-only on this PC.
3. **BUG-852**: move the CE_VERSION command into Manager so CE Tools > Version works on a PC without Structural (Tim: "move version into manager"). Manager and Civil ship together; keep CE_SHARED byte-identical; the Manager release build must still say Complete 75-file (or the new exact count: change the guard in the same PR if a file is added).
4. **BUG-737 / PR #1366**: imported pit schedules: "pit depth" is measured to the PIT FLOOR (Tim: "pit floor"): make that the behaviour and update tests/wording.
5. The two Tidy labels wording/diagnostic PRs already in review (#1485, #1486) are not yours.

## Robot and desk notes
1. The robot may now use (setvar ...) lines for CELWEIGHT or DIMSCALE on TEST copies only (never on real drawings).
2. Tim switched ON the two Structural warnings in his own settings file (CE_STRUC_SUITE\CS_Settings.json, new SHA-256 F68EEB5E343C, previously 24D8E5F7D87B): the robot briefs must expect the new hash.
3. Colleague installs go via the deploy chat's route until BUG-823/824 are fixed (Tim: yes).

## Desk answers to lane 02's CEMEMBER questions (Tue 20 Oct 2026 20:35; builders never wait on Tim: INT-073)
1. **Command route:** REUSE SbeamAtomicPlacementWriter and the compound store, so SBEAMEDIT edits CEMEMBER members (your recommendation, accepted).
2. **Z purlin orientations:** the card is silent. Take the naming and the 'flange nearer the viewer' rule from the existing Z purlin code and tests in the repo (search for ZP / Z purlin orientation in Modules/Structural and the CEMEMBER design files), implement it as a DRAFT DEFAULT behind a Settings value, mark it 'draft default, Tim to confirm' in the PR and in areas/structural.md; if the repo shows no convention, use: orientation = which way the top flange points (left/right) viewed along the member, flange nearer the viewer = the one on the viewer's side of the web. Tim will confirm on Monday (QUESTIONS_FOR_MONDAY.md).
3. **Settings rows** for break overshoot 1.5 mm and kink 2 mm: build them with the command (Codex adds the window rows later).
4. **The 'Tim AutoCAD checklist' file is no longer for Tim** (Tim 20 Oct: all checking and testing is done by AI). Keep the file, rename its heading to 'CEMEMBER acceptance checklist (robot and Codex)'; the desk will give it to Codex as a verify brief.
5. Keep going: next PRs = remaining section types in the card, the CEMEMBER command and prompts, Escape/Undo/Enter-to-repeat. Write 'no bug work left' only when CEMEMBER foundations through the command are all DRAFT PRs.
