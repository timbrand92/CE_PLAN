# Workflow card drafts 5 of 15: Edit Pipe and level entry

Written Monday 2 November 2026 (Melbourne) by Sonnet (Team, read-only) for CE 05 at CE 00's request. Nothing in this file is approved. No code, setting, drawing or git state was changed; the only thing written is this file.

## FOR TIM

1. **Five cards are drafted below, one per command, each marked "DRAFT FOR TIM: nothing is approved".** They cover: a typed level with a comma on a European-region PC (#1969), the "level not saved" line (#1970), the downstream question after the save (#1972), the pit lid at RL 0.000 with the comma lid plus the repeated-figure grade warning (#1882 and #1967), and the 1 mm uphill pipe plus the "essentially flat" dash (#1887 and #989).
2. **Where each change is, read from the branches:** #1882 and #1887 are in C-79a, which is the build installed now (Civil 3.0.89, I read the DLL version). #1969, #1970 and #1972 are in C-79b1 (branch 20261108a), not installed. #1967 is in C-79b2 (branch 20261110a), not installed. #989 is in none of the C-79 branches. **None of the seven is on rel-20261102a**, which is the C-78 build before all of them.
3. **Two things could not be pinned down.** The pit lid change (#1882) shows in CDRUNSOLVE and in network redesign, not in Edit Pipe, and I could not find the network redesign command name or its ribbon button. And the exact word on the command line before the dash fix (#989) is quoted from the bug and the Opus review; I did not see it.
4. **Questions that need you are in field 18 of each card.** The main ones: should a failed level write ever stop the save (card 2, I recommend no); should the markup route keep its 1 mm uphill limit (card 5, I recommend yes for now); and does anyone in the office run a comma-region PC (card 1).
5. **Undo, plainly:** the code and its comments say one U takes back the pipe change and the downstream recalculation together (card 3). Nobody has seen that in AutoCAD, and I cannot say what AutoCAD does with several transactions inside one command.
6. **Read:** the Opus pre-reviews AC, R, AD, the re-check and BACKLOG2 R2, the build register, the train lists, the carpark entries, the change log and the code on the C-79 branches. **Not proven:** every one of these changes was built and unit-tested by its author only. Nobody has opened any of them in AutoCAD, and nobody has run any of this on a comma-region PC. None is Tim-accepted.

---

## Shared facts (read once, apply to every card)

1. **Branches, read with git on 2 Nov.** rel-20261102a tip 3fbb9da5 (C-78). claude/rel-20261106a head 61fd6fbc (C-79a, what is installed). claude/rel-20261108a head cf059dcf (C-79b1, build candidate Civil 3.0.90). claude/rel-20261110a head d4ce878e (C-79b2). claude/rel-20261112a head ccaf0783 (later). I counted each bug number in each branch's REGRESSION_LOG.md: BUG-1093 and BUG-1092 first appear on 20261106a; BUG-1164, BUG-1157 and BUG-658 first appear on 20261108a; BUG-1235 first appears on 20261110a; BUG-563 appears on none.
2. **What is installed.** I read the DLL version of the installed Civil bundle: 3.0.89+61fd6fbc. That is C-79a. The register says the b1 install (Civil 3.0.90) is GO for Tuesday 3 November after 17:30, conditional (items 271 to 273). I did not check whether it has happened since the register's last lines.
3. **C-79a smoke result.** The register (items 272 and 273) records CE 02's corrected area-plus-smoke on 3.0.89: 11 packs, 38 cases plus N91, all PASS. I did not find a case in the files I read that specifically proves #1882 (robot C93) or #1887 (robot C94) on 3.0.89. Treat those two as "smoke passed, change itself not seen".
4. **Tim does not test** (RULES 13.3 amendment, 20 Oct). The checklists in field 17 are written so a robot, a Codex look or Tim can follow them. Anything the drafter must see (a window, a label) needs a Codex look; engineering judgement needs Tim's word.
5. **Switches.** All switches below are read from the settings file `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` when AutoCAD starts (memory: "set before launch"). None has a Settings page row. I did not read Tim's real settings file.
6. **Ribbon and trigger for Edit Pipe.** Read from `Assets/Config/ce-tool-register.json` on 20261102a: id civil.edit, command CDEDIT, aliases PIPEEDIT and PITEDIT, label "Edit", location "CE Civil > Edit & Link > Edit". The older toolbar layout calls it "Edit Pit or Pipe" (`ce_toolbar_layout.json`). CDEDIT is a Modal command that uses the picked set (`HubCommands.cs`, CommandFlags.UsePickSet), so a pipe selected first goes straight to its editor.

---
---

# CARD 1 of 5. DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Edit Pipe stores a typed level with a full stop on a comma-decimal PC (#1969, BUG-1164, B-119). On a PC whose Windows region writes decimals with a comma, a level typed 18,14 is stored on the pipe and in the schedule as 18.14.
2. **Ribbon or trigger.** CE Civil > Edit & Link > Edit (CDEDIT, aliases PIPEEDIT and PITEDIT), then pick a pipe; or select the pipe first and type CDEDIT. The level boxes are under "Invert levels" in the Edit Pipe window (`PipeEditWorkshopDialog.xaml`, label "Invert levels").
3. **Works today.** On an Australian-region PC a level typed 18.14 is stored exactly as typed ("18.14", "18.140" unchanged). The window itself reads a typed level with a full stop first, then the PC's own region (`PipeEditCommand.cs` `TryParseDouble`, per Opus AC). Keep would protect: the typed text on the plan label still shows what was typed.
4. **What the train or PR changes.** #1969, head 1d411b28, first in C-79b1 (20261108a). Switch `pipe.editPipeStoresLevelsWithDecimalPoint`, **ON** by default. New file `Rules/EditPipeStoredLevelTextRule.cs`, used in `PipeEditCommand.Update.cs` (`UpdatePipeSchedule`) once per level box. ON: the PC's decimal mark is swapped for a full stop when that gives the same number; otherwise the number is written with a full stop. OFF: stored as typed, as before. A missing file or group reads ON. Not changed: the text drawn on the plan, old drawings already holding "18,14", and the audit's own reader.
5. **Suggested class: Modify.** One small change to what is stored; the window and every prompt stay the same. Suggestion only.
6. **Prompts and windows.** No new prompt or window. The existing Edit Pipe window; on success the command line says "Pipe updated." (read in `PipeEditCommand.cs`, `ApplyPipeEdit`). If nothing is pre-selected CDEDIT first asks "Select a pit, pipe, source or CE text to edit: ".
7. **Selection.** One pipe, picked or pre-selected. Two or more pipes go to the batch editor, which this change does not touch.
8. **Preview.** The Edit Pipe window shows its own pipe picture; this change adds none. Not changed.
9. **Drawing output.** The same two values go to the same two places (the pipe's own stored levels and the schedule row); only the characters differ. The level text drawn on the plan keeps what was typed. No new layer, Xref, REFEDIT or locked-layer path (Opus AC 4); the existing protections are untouched. What is NOT touched: other pipes, pits, old stored text.
10. **Cancel, Escape, Undo and Redo.** No new write or transaction, so nothing new to undo. Cancel or Escape at the window writes nothing and puts CE's record back (the "record write hold" in `PipeEditCommand.cs`, BUG-373 comment). One U takes back the Edit Pipe change exactly as before (what's-new line "One U takes back one edit"). Not seen in AutoCAD.
11. **Save and reopen.** The stored text is a plain "18.14" in the drawing's CE record, so it reads the same after save and reopen on any PC. Old drawings keep "18,14" if it was stored earlier (not repaired).
12. **Assets, data and Settings it reads or writes.** Reads the one switch above. Writes the pipe's stored invert text and the schedule row. No Settings page row.
13. **Performance.** One string conversion per level box on save. No measurable cost (GUESS: nothing loops or reads the drawing).
14. **Discovery.** No Help page change found. The change is silent on purpose: the drafter types as normal. The what's-new list on 20261108a has no line for it (I read `whats-new.json` there for Edit Pipe entries and found only the older ones).
15. **Example drawing and expected result.** PC set to a comma region (for example German). Pipe P3-P4, 225 mm, upstream IL 18,40 (typed 18.40 on an Australian PC), downstream IL typed 18,14. Expected after Save: pipe and schedule show 18.14; CDAUDIT does not read it as 1814. Control on an Australian PC: type 18.14; stored text is exactly "18.14".
16. **Older family card.** `docs/workflows/C2_EDITOR_TABS_2026-09-06.md` covers the Edit Pipe tabs and says fields, input constraints and drawing writers stay the same. It does not say what text is stored for a typed level, nothing about a comma region, and its tab layout (five tabs, behind a feature flag) is not the one-page layout now on the line (`PipeOnePageLayout.cs`).
17. **Tim's AutoCAD checklist.** (Only possible on a comma-region PC; on an Australian PC do the control only.)
    1. Set Windows region to one that uses a comma decimal. Start AutoCAD.
    2. Draw or open a drawing with pit P3, pit P4 and a CE pipe P3-P4.
    3. Select the pipe, type CDEDIT, Enter. The Edit Pipe window opens.
    4. In the downstream level box under "Invert levels" type 18,14. Press Save.
    5. Command line should end "Pipe updated." Type CDAUDIT. It should show 18.14, not 1814.
    6. Open the pipe again: the level box reads 18.14 (GUESS: the window shows the stored text).
    7. Control: on an Australian-region PC type 18.14 and Save. It must be stored exactly as "18.14".
    8. Switch-off twin: set `pipe.editPipeStoresLevelsWithDecimalPoint` to false before starting AutoCAD; repeat step 4; the stored text is "18,14" as before.
18. **Questions only Tim can answer.**
    1. **Does anyone in the office or a client run a comma-region PC?** Context: the fix only matters there. What I understand: nobody has run this on such a PC, and the robot may not be able to start AutoCAD in a comma region. **Recommendation: no card test beyond the Australian control unless a colleague actually uses a comma region** (cheap to skip, nothing changes for you). On a job: if yes, a colleague typing 18,14 today gets 1814 in CDAUDIT, a 1.8 km level error on a schedule; if no, the fix sits idle and harmless.
    2. **Should old drawings that already hold "18,14" be repaired?** Context: the PR does not repair them. I understand the carpark only asks for the writer fix. **Recommendation: not now; list it if a real drawing turns up.** On a job: yes means a separate repair command that rewrites stored levels (needs its own card); no means CDAUDIT still misreads old text.
19. **NOT proven.**
    1. **Built:** yes, by the author (net48 compile 0 errors, net10 focused tests; the C-79b1 finalizer ran the full Civil suite, 22,199 tests, 0 failed, register item 253).
    2. **Tested:** unit tests only, including a test that sets the culture to de-DE and calls the window's real number reader. No test runs `UpdatePipeSchedule`; the link to the save is a source-text guard. Nobody has run it in AutoCAD or on a comma-region PC.
    3. **Installed:** no. It is in the C-79b1 candidate, not in the installed 3.0.89.
    4. **Tim-accepted:** no. BUG-1164 is OPEN in the carpark. Nobody has done any of the last three. Also unchecked: whether Pit Edit has the same fault (Opus AC saw the same reader at `PitEditCommand.cs` line 2002 and `PitCommand.Orientation.cs` line 478; not verified).

---

# CARD 2 of 5. DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Edit Pipe says so when it could not write the level onto the pipe itself (#1970, BUG-1157, B-119). If the level write fails, one line on the command line tells the drafter to check the pipe and run Edit Pipe again.
2. **Ribbon or trigger.** Same as card 1: CE Civil > Edit & Link > Edit (CDEDIT, aliases PIPEEDIT, PITEDIT), pick a pipe, change a level, Save.
3. **Works today.** Edit Pipe writes the new level to the schedule and the plan, then separately onto the pipe's own stored record. That second write catches every failure and only logs it (carpark BUG-1157). Keep would protect: the write itself, the schedule and plan update, the save carrying on.
4. **What the train or PR changes.** #1970, head b3e76c82, first in C-79b1 (20261108a). Switch `pipe.editPipeLevelWriteSaysWhenNotSaved`, **ON**. New `LinkService.TryStorePipeInverts` (same write, now answers true or false); the old `StorePipeInverts` calls it and ignores the answer, so New Pipe, Xcivil import, linked text edits and CDLINK are unchanged. **Protected file touched: `LinkService.Persistence.cs`.** Opus AC says class FULL, KEEP-WITH-NOTE. Shares that file with #1892 (merges cleanly).
5. **Suggested class: Modify (small: one warning line).** Suggestion only. The train class FULL comes from the protected file, not from the size of the change.
6. **Prompts and windows.** No new window. One command-line line and the same line in the CE log (`Rules/EditPipeLevelWriteRule.cs`): "[CE] Warning: the level was not saved on pipe P3-P4 itself. The schedule and plan show the new level, but if its level text is deleted CE will go back to the old one. Check the pipe and run Edit Pipe on it again." The pipe name is substituted; "(unnamed)" if blank.
7. **Selection.** One pipe, as card 1.
8. **Preview.** None added.
9. **Drawing output.** No new write. The line prints after the schedule write, and the save carries on: nothing is rolled back or refused. What is NOT touched: locked layers are still never unlocked (`GetOrCreateLinkDictionary` skips a locked layer and says so in its own line, BUG-254). Opus AC found two quiet gaps that stay quiet: when the link dictionary cannot be made (a converted pipe with no record store, or an AutoCAD refusal) the write returns quietly and the new answer is still "true", so no line prints. Opus calls this a gap, not a regression. The PR's log wording "or AutoCAD refused it" overstates it (Opus asked for two wording fixes in the log entry).
10. **Cancel, Escape, Undo and Redo.** No new transaction or write. Cancel and Escape as card 1. Undo and Redo: same as today; the PR reports no new write and Opus judged it REDO-safe. Not seen.
11. **Save and reopen.** The line is not saved anywhere except the CE log. The level on the pipe is what CE falls back to if the level text is deleted, so a failed write shows up later as the old level coming back.
12. **Assets, data and Settings it reads or writes.** Reads the switch. Writes the pipe's stored level (unchanged).
13. **Performance.** None measurable: one extra true/false answer.
14. **Discovery.** Command line and CE log only. No Help page or what's-new line found for it.
15. **Example drawing and expected result.** Ordinary pipe P3-P4, 225 mm: change the downstream IL from 17.900 to 17.850 and Save. Expected: no "level was not saved" line; CDAUDIT agrees with the schedule. The damaged-record case from the carpark cannot be shown (see field 19).
16. **Older family card.** `docs/workflows/C2_ATOMIC_SAME_TYPE_BATCH_EDIT_2026-09-12.md` covers one-transaction batch edits for 2+ pipes and says nothing about the single-pipe level write or a "not saved" warning. `C2_EDITOR_TABS_2026-09-06.md` says drawing writers stay the same and has no line on a failed level write.
17. **Tim's AutoCAD checklist.**
    1. Open a test copy with a CE pipe P3-P4. Select it, type CDEDIT, Enter.
    2. Change the downstream level under "Invert levels" by 50 mm. Save.
    3. Expected: "Pipe updated." and no "level was not saved" line.
    4. Type CDAUDIT: the pipe's level agrees with the schedule.
    5. Do NOT try to build a damaged record (Opus AC: Edit Pipe refuses to open such a pipe before Save, so the line cannot be reached that way).
18. **Questions only Tim can answer.**
    1. **Should a failed level write ever stop the save?** Context: today it only warns. What I understand: the author left it open; the rule is warn, never block. **Recommendation: no, keep the warning only.** On a job: stop means a drafter is blocked from saving a level the schedule and plan already show; warn means they see one line and re-run Edit Pipe.
    2. **Do you want the two quiet gaps closed (no record store, AutoCAD refusal)?** Context: Opus AC says that needs another change in the same protected file. **Recommendation: a separate small PR later; not now.** On a job: until then a converted pipe with no record store saves quietly with the old stored level behind it.
19. **NOT proven.**
    1. **Built:** yes (author's report, net48 compile; finalizer's full Civil run, 22,199, 0 failed).
    2. **Tested:** unit tests: the line wording and "only when the write failed and the switch is on" are real logic tests; everything about the write and the call is source-text guards. No test makes a write fail. Not run in AutoCAD.
    3. **Installed:** no (C-79b1 candidate only).
    4. **Tim-accepted:** no. BUG-1157 is OPEN. Opus AC says it can only be accepted on the code reading plus an ordinary-pipe control run, because the carpark's damaged-record step is refused when the window opens (`PipeEditCommand.DataCollection.cs` lines 267 to 281, "PIPE-EDIT-WHY-01"). The carpark "Steps to confirm" still describe the impossible case and need rewriting. Nobody has done any of the last three.

---

# CARD 3 of 5. DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Edit Pipe's "Recalculate downstream pipe inverts?" question and the recalculation now come after the pipe change is saved (#1972, BUG-658, B-119). Behind the box the drawing already shows the new level.
2. **Ribbon or trigger.** CE Civil > Edit & Link > Edit (CDEDIT), pick one pipe, change its downstream level so it differs from the old one, Save.
3. **Works today.** Today the question, the preview and the cascade run inside Edit Pipe's own open drawing change. If the save is then refused (for example the pipe's label text is on a locked layer), the change is rolled back but "[CDEDIT-CASCADE] Updated N pipes" has already printed and the downstream levels were already rewritten (carpark BUG-658; found by reading code, never seen). Keep would protect: the Yes/No box, the preview, the cascade code, the batch rule (Edit 2+ pipes never asks), the dry-run picture rule (never asks), and no question when the save reversed the pipe's direction.
4. **What the train or PR changes.** #1972, first in C-79b1 (20261108a). Switch `pipe.cascadeQuestionAfterEditCommits`, **ON**; read when Edit Pipe saves. **Head: 32fc1a44** (the first head 556b3848 got Opus review AC "CHANGE-NEEDED, small"; CE 05's fix commit is the one on 20261108a, which I confirmed in the code: `CascadeAfterCommitRule.SkippedNotice` is there). Files: `Rules/CascadeAfterCommitRule.cs` (new), `PipeEditCommand.Update.cs`. ON: the question is held back and asked after the commit, after the "could not confirm" stop and the stale-grade-marker step, before the arrow or label "move to segment" prompts. OFF: asked inside the open change exactly as before. New behaviour to know about: if the cascade itself throws, the pipe stays saved and one line says so. Before, the throw rolled the whole save back.
5. **Suggested class: Modify.** It changes the order of a window, a transaction and a cascade, so Opus AC puts it in the FULL train class. Suggestion only.
6. **Prompts and windows (exact wording, from the code on 20261108a).**
    1. Yes/No box titled "CE — Recalculate downstream inverts?" with the text: "The downstream invert on pipe [id] changed from [old] to [new]." then "Recalculate downstream pipe inverts at each pipe's current grade?" then "You will see a preview of every affected pipe before anything is applied."
    2. Yes opens the "PropagationPreviewDialog" (preview of every affected pipe) with Apply or cancel.
    3. Command-line lines: "[CDEDIT-CASCADE] Downstream cascade skipped." (No), "[CDEDIT-CASCADE] No downstream pipes from this pipe - nothing to cascade.", "[CDEDIT-CASCADE] Cancelled." (preview cancelled), then the applied lines. Opus AC quotes the applied line as "[CDEDIT-CASCADE] Updated N pipes"; I read that from the review, not from the code, because the applied lines come from `ApplyPropagationPlan` (not opened line by line).
    4. If the pipe saved but "linked-object refresh needs the drawing to be reopened", the question is skipped and the command line says: "[CE] The downstream levels were not recalculated. Reopen the drawing, then run CDPROPAGATE from pit [To pit] if they need to follow." (only when the downstream level really changed).
    5. If the cascade throws: "[CE] Pipe updated. The downstream recalculation could not be completed; the pipe itself was saved."
7. **Selection.** One pipe only. Batch (2+ pipes) never asks; the cascade's own start pit is the pipe's downstream pit.
8. **Preview.** The PropagationPreviewDialog before anything is applied (existing, unchanged). The Edit Pipe window's own picture is unchanged.
9. **Drawing output.** The cascade is the same `PromptDownstreamCascadeIfInvertChanged` and `ApplyPropagationPlan` code, with its own transactions, as CDPROPAGATE uses. It rewrites downstream pipes' stored levels, their level text and the schedule. Locked layers, Xrefs and REFEDIT are protected exactly as in the cascade today (Opus AC 4.1; the writability check is BUG-657's, in PR #1378, whose status says not yet tested by robot or Codex). Nothing is unlocked. Layer names not read here. What is NOT touched: the pipes above the edited one, a batch, a dry-run preview.
10. **Cancel, Escape, Undo and Redo (read from the code; not seen).**
    1. **What opens the change.** `UpdatePipeFromViewModel` opens one transaction (`db.TransactionManager.StartTransaction()`, `PipeEditCommand.Update.cs` line 530 on 20261108a) and commits it at the end of the save. That one transaction holds the pipe, labels, level text, schedule row and arrow.
    2. **Where the cascade sits.** The cascade is now run after that commit, still inside the same CDEDIT command. It opens its own transactions (`LinkService.RepairAudit.InvertPropagation.cs`, `ApplyPropagationPlan`, a transaction at line 851).
    3. **What one U takes back, per the code.** The code comments say the cascade and the arrow or label placement "remain part of this single CDEDIT command and therefore one AutoCAD Undo step", and the BUG-446 comment says the stale grade marker is taken away "in this same command, so one Undo brings back the level and the marker together". The what's-new entry says "One U takes back one edit". The PR's AutoCAD step 9(a) expects one U to undo the Edit Pipe change and the cascade together. **I found no explicit undo-group call in the Edit Pipe files** (I searched for UndoRecord, StartUndo and UndoGroup in PipeEditCommand*.cs and HubCommands.cs; the only hit was a comment in the batch file calling one command "one implicit AutoCAD Undo group"). So this relies on AutoCAD treating the whole command as one step; **I cannot state what AutoCAD does inside itself** (RULES 12.5), and nobody has seen it. GUESS: one U brings back P1 and the pipes below it together.
    4. **Cancel and Escape.** Cancel or Escape at the Edit Pipe window writes nothing. A refused save (for example a locked label layer) throws inside the open change, the change is rolled back and the code never reaches the question: no box, no "Updated" line (Opus AC 1.2). **No** at the box: the pipe stays saved, the line says the cascade was skipped. Cancel at the preview: pipe stays saved, "[CDEDIT-CASCADE] Cancelled.". Escape at the Yes/No box or the preview: GUESS it behaves as the dialog's cancel; not read.
    5. **Redo.** The PR adds no new write beyond the cascade the drafter chose. The C-79b1 finalizer confirmed the assembler's two REDO-safe baseline lines (register item 253; I did not check which PRs they cover); nobody has run U then REDO here.
11. **Save and reopen.** Both the pipe and the downstream pipes are in the drawing's records and plan text after save, so reopening shows them. If the cascade fails or is skipped the downstream pipes keep their old levels and only the line above says so.
12. **Assets, data and Settings it reads or writes.** Reads the switch. Writes the pipe, then (on Yes plus Apply) the downstream pipes' stored levels, level text and the schedule. No Settings page row.
13. **Performance.** The cascade's work is the same as before; it now runs after the commit, so the transaction is shorter. Large networks: not measured (GUESS: the same cost as CDPROPAGATE).
14. **Discovery.** The question box itself. No Help page or what's-new line found for the new order. CDPROPAGATE is named in the new "not recalculated" line.
15. **Example drawing and expected result.** Pipes P1-P2, P2-P3, P3-P4 in a line, each 225 mm, levels falling 17.900, 17.800, 17.700, 17.600. Edit Pipe on P1-P2, change its downstream level from 17.800 to 17.850, Save. Expected: pipe P1-P2 already shows 17.850 behind the Yes/No box; Yes, then Apply in the preview; one cascade line naming the pipes below; then one U, which per the code takes back P1-P2 and the pipes below together (not seen).
16. **Older family card.** `docs/workflows/C2_ATOMIC_SAME_TYPE_BATCH_EDIT_2026-09-12.md` says same-type batch edits run as one reviewed, all-or-nothing operation and "the user sees one batch preview"; it covers the batch, not the single-pipe downstream question or its order. `C2_EDITOR_TABS_2026-09-06.md` does not mention the cascade question. Neither says the question comes after the save. Separate open bug BUG-1273 (Codex look S5-02, 2 Nov): the Cascade Preview summary versus the completion message; this card does not cover it.
17. **Tim's AutoCAD checklist.**
    1. Open a test copy with three CE pipes in a line (as in field 15). Select P1-P2, type CDEDIT, Enter.
    2. Change its downstream level by 50 mm. Press Save.
    3. Expected: the Edit Pipe window closes, then the Yes/No box "CE — Recalculate downstream inverts?" opens with the plan already showing P1-P2's new level behind it (Codex look: screenshot with the box up).
    4. Click Yes. The preview lists P2-P3 and P3-P4. Click Apply.
    5. Command line shows the cascade lines. Type U once. Check P1-P2, P2-P3 and P3-P4 all return to their old levels together.
    6. Repeat but put P1-P2's label text on a locked layer first. Change the level, Save. Expected: the save is refused, no Yes/No box, no cascade line, P2-P3 and P3-P4 unchanged.
    7. Switch-off twin: set `pipe.cascadeQuestionAfterEditCommits` false before AutoCAD starts; repeat step 6; the old order (box first, then refusal) appears.
    8. Click No at the box once: pipe saved, "[CDEDIT-CASCADE] Downstream cascade skipped.".
18. **Questions only Tim can answer.**
    1. **If the cascade fails after the pipe is saved, should the pipe stay saved?** Context: that is the new behaviour; before, the whole save rolled back. What I understand: Opus AC checked that a failed cascade already puts itself back, so the edited pipe stays safe, and judged no question needed. **Recommendation: keep it saved and warned (warn, never block).** On a job: stay saved means the pipe has its new level and the line tells you to run CDPROPAGATE; roll back means you lose the level change you typed because a later step failed. Your word only if you disagree.
    2. **Is one U for the pipe plus the downstream pipes what you want?** Context: the code intends that. **Recommendation: yes, one U, so a mistaken cascade is one step to undo.** On a job: if two U steps are needed instead, the first U leaves the downstream pipes unrecalculated against the edited pipe.
19. **NOT proven.**
    1. **Built:** yes (new head 32fc1a44; the C-79b1 assembler merged it, Civil full run 22,199, 0 failed).
    2. **Tested:** unit tests and source-order guards only; they prove the code shape, not what AutoCAD shows. The robot cases named by the author (N5_658_cascade_after_save, N5_658_locked_label, N5_658_locked_label_off) and Opus AC's Codex look at case 1 have not been run on a build that holds #1972, because none is installed. Not seen in AutoCAD.
    3. **Installed:** no. In C-79b1 candidate only.
    4. **Tim-accepted:** no. BUG-658 is OPEN. Nobody has done any of the last three. The one-U claim is read from comments and the absence of an undo group call, never seen.

---

# CARD 4 of 5. DRAFT FOR TIM: nothing is approved

Two changes on one card because both are about a typed or measured figure that was misread or printed twice. They are in different commands, and **#1882 is not an Edit Pipe change** (it shows in CDRUNSOLVE and network redesign).

1. **Name, and what it does for a drafter.**
    1. **#1882 (BUG-1093, B-069, C-79a): a pit lid at RL 0.000 and a lid typed with a comma.** A pit whose lid is exactly RL 0.000 now gets the cover check; a lid typed "12,5" reads as 12.5.
    2. **#1967 (BUG-1235, B-119, C-79b2): the minimum-grade warning never prints the same figure twice.** "Grade 1:200 is shallower than minimum 1:200" now shows a decimal when the two would otherwise match.
2. **Ribbon or trigger.**
    1. **#1882:** CDRUNSOLVE ("Solve Run Inverts (CDRUNSOLVE)", registry group Draft, subgroup Review; it asks "Select the start pit (upstream end) of the run to solve: "). Also network redesign. **I could not find the network redesign command name or its ribbon button in the registry or the tool register on 20261106a, so that trigger is not pinned down.** The tool register has no CDRUNSOLVE ribbon location either.
    2. **#1967:** the line appears after CD draws a pipe (Pipe: "CE Civil > Draw > Pipe", command CD) and after Edit Pipe saves (CE Civil > Edit & Link > Edit). It prints through `CdCommand.cs` (line 1096) and `PipeEditCommand.Update.cs` (line 635) as "[CE] Warning: ..." and is also in the Design Warnings window.
3. **Works today.**
    1. **#1882:** a lid typed as exactly 0.000 is treated as "not set", so no cover finding is raised, while a lid of RL 0.001 gets one. A blank lid is Unknown and is not checked, and the old trench-grate placeholder "0.000" stays Unknown. Keep would protect those two.
    2. **#1967:** the silting warning fires only when the real grade is flatter than the minimum by more than 1e-9, so a pipe at exactly 1 in 200 gets no warning. Keep would protect that. Opus AD read this; I confirmed the 1e-9 test in the code (`CheckGradeTooFlat`).
4. **What the train or PR changes.**
    1. **#1882, head 84d5a659, in C-79a (20261106a), installed in 3.0.89.** Switch `cover.zeroCoverLevelIsReal`, **ON**. New `CoverLevelKnownRule.TryReadLid`: reads "12,5" and "12.5" alike; "abc", "1,012.500" and blank are Unknown. Both producers (the CDRUNSOLVE proposal builder and the redesign projector) use it. The first head 58c4473d would have given a false cover warning on a comma lid; the fix is in. Opus re-check: KEEP. OFF: the old "0.0 means not set" rule exactly.
    2. **#1967, head ade56d0d, in C-79b2 (20261110a), not installed.** Switch `pipe.gradeWarningFiguresNeverMatch`, **ON**. New `Rules/GradeWarningFiguresRule.cs` adds decimals (up to nine) until the two figures differ. OFF: the old whole-number sentence, including the long dash, exactly.
5. **Suggested class: #1882 Modify, #1967 Modify** (both change what is shown or checked, neither changes a calculation or a stored level). Suggestion only.
6. **Prompts and windows.**
    1. **#1882:** findings only, no new window or prompt. Wording read in `NetworkDesignService.cs`: "COVER: pipe from '[pit]' upstream obvert cover [n] mm < minimum [n] mm", "COVER: pipe to '[pit]' downstream obvert cover ...", and "COVER: pit '[id]' depth [n] mm < minimum [n] mm". The minimum is the Settings or rulebook value (not read here).
    2. **#1967:** same one line, new figures. Before: "[CE] Warning: Grade 1:200 is shallower than minimum 1:200 — risk of silting" (the em dash prints oddly on the command line, see card 5). After, with a hair-flat pipe: "Grade 1:200.01 is shallower than minimum 1:200.00". If the figures already differ the sentence is unchanged ("Grade 1:202 is shallower than minimum 1:200").
7. **Selection.** #1882: CDRUNSOLVE picks a start pit; redesign works on its own selection (not read). #1967: the pipe just drawn or edited.
8. **Preview.** #1882: the existing solve preview (not changed). #1967: none; text only.
9. **Drawing output.** Neither changes a stored value or draws anything new. #1882 findings go to the same notes and warnings as before; Opus R checked every consumer of the COVER note and `CoverOk`: none refuses or changes a level. #1967 is text only. No layer, Xref, REFEDIT or locked-layer path is touched by either (Opus R 4, Opus AD 5). A comma lid now gets a real cover check at its real level where before it got none: a warning, never a block.
10. **Cancel, Escape, Undo and Redo.** No write, regen, view or system-variable change in either, so nothing new to undo or redo (Opus R and Opus AD).
11. **Save and reopen.** Nothing new is saved by either.
12. **Assets, data and Settings it reads or writes.** #1882 reads pit records and the switch; #1967 reads the minimum pipe grade (Settings, not read here) and the switch. Neither writes.
13. **Performance.** Negligible (one extra number reading per pit; up to nine string conversions for a warning).
14. **Discovery.** Command line and warnings only. No Help page or what's-new line found for either.
15. **Example drawing and expected result.**
    1. **#1882:** a coastal pipe run, pit P1 lid typed 0.000, upstream pipe obvert at RL -0.200 (cover 200 mm). Run CDRUNSOLVE. Expected: a "COVER: ... 200 mm < minimum ..." finding on P1 if the minimum is above 200 mm (minimum not read; GUESS it is above). Before: no finding at all. Comma lid: pit lid typed "12,5", pipe obvert RL 12.0: cover 500 mm is checked as 12.5; before the change it got no check, and without Opus's fix it would have been checked against RL 0.
    2. **#1967:** a 10.0004 m pipe with a 50 mm fall (a hair flatter than 1 in 200; ratio 200.008) with the minimum at 1 in 200. Expected: "Grade 1:200.01 is shallower than minimum 1:200.00". A pipe 10.000 m with a 50 mm fall: no warning. A 1 in 202 pipe: "Grade 1:202 ... minimum 1:200". Opus AD notes: a pipe a hair flatter can read "1:200.0002 is shallower than minimum 1:200.0000"; true but odd; that is the warn-or-not tolerance question already parked as BUG-1229.
16. **Older family card.** `docs/CARDS/CV-02_HYDRAULIC_DESIGN.md` (the nearest family card on the list; I read only the folder listing, not the card, so what it covers is **not checked**). `C2_EDITOR_TABS_2026-09-06.md` and the other three workflow cards say nothing about cover checks or the grade warning wording.
17. **Tim's AutoCAD checklist.**
    1. **#1882:** open a test copy with three pits in a line; type 0.000 as the lid of the first pit; make the pipe obvert below it so cover is less than the minimum. Type CDRUNSOLVE, Enter, pick the start pit. Expected: a COVER finding on that pit. Then repeat with a lid typed 12,5 (and obverts around RL 12): a cover figure based on 12.5, no cover figure against RL 0.
    2. **#1882 switch-off twin:** set `cover.zeroCoverLevelIsReal` false before AutoCAD starts; repeat with 0.000: no finding.
    3. **#1967:** type CD, draw a pipe 10.0004 m long between pits with a 50 mm fall (types IL 10.000 and 9.950). Expected command line: "Grade 1:200.01 is shallower than minimum 1:200.00" (Opus AD: draw it 10.0004 m long, as in the unit test). Then a pipe exactly 10.000 m: no warning.
    4. **#1967 switch-off twin:** set `pipe.gradeWarningFiguresNeverMatch` false before AutoCAD starts; the hair-flat pipe reads "Grade 1:200 is shallower than minimum 1:200".
    5. **#1967 with #1919:** if both are installed, place one hair-flat pipe and read every grade line (Opus AD: the New Pipe window's own "Levels typed give 1 in N" line from #1919 may or may not clash; not proven).
18. **Questions only Tim can answer.**
    1. **What should the warning say for a pipe that is a hair flatter than the minimum, say 1 in 200.0002?** Context: #1967 prints up to nine decimals. What I understand: BUG-1229 (the warn-or-not tolerance) is parked. **Recommendation: leave as is until BUG-1229 is decided.** On a job: a drafter sees "1:200.0002 vs 1:200.0000" on a 10 m pipe that is really at the minimum and may redraw it; a tolerance would hide it.
    2. **Do you want the 0.000 lid check as a ribbon-visible switch or file-only?** Context: all switches in this batch are file-only. Decision 126 already puts file-only switches on the planned "Switches" tab (Opus AC 5), so I am **not asking**; noted so it is not asked again.
19. **NOT proven.**
    1. **Built:** yes, both. #1882 is inside the installed C-79a build. #1967 is in the C-79b2 branch, whose finalizer reported a Civil full run of 22,517 tests with 22,485 passed (register item 258; I did not read the rest of that line, so the failed and skipped counts are not confirmed here).
    2. **Tested:** #1882 has behaviour tests on the real `NetworkDesignService.Design` (a 0.000 lid gives a COVER finding, blank gives none, OFF is old) and 4 of 25 tests fail with the two service files put back (author's run); the two producers are covered by text guards only. #1967 has a "hair flatter" test that fails on the old code. Neither seen in AutoCAD. C-79a smoke passed on 3.0.89 in general (item 272), not specifically for the lid.
    3. **Installed:** #1882 yes (inside C-79a, 3.0.89+61fd6fbc, read from the DLL). #1967 no.
    4. **Tim-accepted:** no, either. BUG-1093 and BUG-1235 are OPEN in the carpark. Nobody has done a lid-at-RL-0.000 run in AutoCAD that I could find, and the network redesign path (the redesign projector already refuses a pit whose lid will not read as a plain number, Opus recheck) is only text-guarded.

---

# CARD 5 of 5. DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** A pipe even 1 mm uphill is reported as flowing uphill (#1887, BUG-1092, B-069, C-79a), and the "Pipe is essentially flat" warning keeps a readable dash on the command line (#989, BUG-563).
2. **Ribbon or trigger.** The warning appears (1) in the warnings window after CD draws a pipe (CE Civil > Draw > Pipe, command CD), (2) in the Edit Pipe warnings after Save (CE Civil > Edit & Link > Edit, CDEDIT), (3) in CDDASHBOARD (CE Civil > Output > Design Review > Design Check Dashboard, per the tool register), (4) in the grade suggestion and (5) on the markup change route. **Not CDRULES**: Opus R found CDRULES uses the rulebook (`RulebookEngine.cs`), already says "flows uphill" for any uphill, and never calls this check (carpark BUG-1092 still says CDRULES; it is wrong).
3. **Works today.** A pipe up to 5 mm uphill reads amber "Pipe is essentially flat" (tolerance `designStandards.reverseFallToleranceMm`, 5 mm by default), not the red "Pipe flows uphill". A pipe 4 mm downhill over 2 m also reads "no measurable fall". Keep would protect: the red error for real uphill, the amber flat warning for a level pipe, the 5 mm tolerance for the flat wording.
4. **What the train or PR changes.**
    1. **#1887, head 0d5e3d98, in C-79a (20261106a), installed in 3.0.89.** Switch `grade.anyUphillFallIsError`, **ON**. ON: any uphill beyond 1e-9 m (rounding noise) is the red error; the 5 mm tolerance only decides the "flat" wording. A uphill of less than 1 mm prints to one decimal ("0.4mm"). OFF: the old limit and old sentence. **Review fix in:** the markup change route sets `KeepToleranceForUphill = true` (not saved; `MarkupToChangePlanService.cs` line 449), so that route keeps its old 1 mm limit and nothing new is refused there. Opus recheck: KEEP-WITH-NOTE.
    2. **#989 (head 8f90b09e) is not in any C-79 branch.** Opus BACKLOG2 R2 says KEEP-WITH-NOTE, "Civil area + smoke", taking only two one-line wording changes (the two `ed.WriteMessage` lines that print a design warning, in `CdCommand.cs` line 1096 and `PipeEditCommand.Update.cs` line 635, passed through the existing `CommandLineText.Plain`) plus the BUG-563 test. I confirmed on all five branches that those two lines still print `{w.Message}` raw. The other half of #989 (BUG-560) is already in the release, so it must be dropped when it is brought over. The branch is old (about 1,700 commits behind), so it needs a net-diff cherry-pick, not a rebase. **No switch** (display-only text; the open question about no-switch fixes is with CE 00).
5. **Suggested class: #1887 Modify. #989 Modify (wording only).** Suggestion only. Note the correction from Opus: the command line gets a short " - ", not a long dash, because the long dash is what the command line cannot print; the PR's log and any card that says "keeps its long dash" is wrong.
6. **Prompts and windows.**
    1. **#1887, red error text** (`DesignValidationService.cs`, `CheckReverseFall`): "Pipe flows uphill — upstream IL 10.000 is 4mm lower than downstream IL 10.004" (shown to one decimal when under 1 mm, whole millimetres otherwise). Amber flat text: "Pipe is essentially flat — no measurable fall". Opus R: the existing warning window after CD already opened for the flat warning, so no new window; it now shows a red uphill line.
    2. **#989:** the command line now reads "[CE] Warning: Pipe is essentially flat - no measurable fall". Before (per the carpark and Opus): "Pipe is essentially flat  no measurable fall", with two spaces where the dash should be. The same short dash now applies to the "flows uphill", "risk of silting" (from card 4) and the other warnings. The window text is unchanged. I did not see either wording.
7. **Selection.** CD: the pipe just drawn. Edit Pipe: one pipe. CDDASHBOARD: the whole drawing.
8. **Preview.** None beyond the existing warnings window.
9. **Drawing output.** Neither draws or changes anything: they only report. The markup route is the one place #1887 could have dropped a change; the review fix keeps it as it was (a markup that leaves a pipe 0.5 mm uphill goes through as "essentially flat"; 4 mm is still refused). No layer, Xref, REFEDIT or locked-layer path is touched.
10. **Cancel, Escape, Undo and Redo.** No write, regen, view or system-variable change in either. Nothing new to undo.
11. **Save and reopen.** Nothing stored. The warnings are recalculated each time.
12. **Assets, data and Settings it reads or writes.** #1887 reads `grade.anyUphillFallIsError` and `designStandards.reverseFallToleranceMm` (5 mm default, from `UserSettings.cs`). #989 reads nothing. Neither writes.
13. **Performance.** None.
14. **Discovery.** The warnings window and the command line. No Help page or what's-new line found.
15. **Example drawing and expected result.** CD a 1 m 225 pipe, IL 10.000 at the start and 10.004 at the end. Expected: the warnings window shows "Pipe flows uphill — upstream IL 10.000 is 4mm lower than downstream IL 10.004" in red, not "essentially flat". A level pipe (10.000 both ends): "Pipe is essentially flat" with the dash. Switch off: the 4 mm uphill pipe reads "essentially flat". A 1 m pipe 1 mm uphill reads red uphill. Related and parked, not part of this card: a real 4 mm fall over 2 m (1 in 500) still says "no measurable fall"; CE 00 ruled a wording-only fix queued as job 223 (B-164 provisional), with the question whether a downhill fall inside the 5 mm band should warn at all already with CE 04 (carpark BUG-1092 note, 2 Nov 17:20).
16. **Older family card.** `docs/workflows/C1_BENT_PIPE_LENGTH_DECISION_EXAMPLE_2026-09-13.md` is the only older card that talks about grade: it is a calculation-basis example for bent pipes (which length drives grade), preparation only. It says nothing about uphill, the 5 mm tolerance, the "flat" or "flows uphill" wording or the command-line dash. `C2_EDITOR_TABS_2026-09-06.md` has nothing on warnings.
17. **Tim's AutoCAD checklist.**
    1. Type CD, Enter. Draw a 1 m 225 pipe between two pits, IL 10.000 at the start and 10.004 at the end.
    2. Expected: the warnings window shows "Pipe flows uphill — upstream IL 10.000 is 4mm lower than downstream IL 10.004" in red, not "essentially flat" (Codex look: screenshot).
    3. Type CDDASHBOARD. The same pipe shows the uphill error.
    4. Draw a pipe with IL 10.000 at both ends. Expected: "Pipe is essentially flat" (amber). On the command line: "[CE] Warning: Pipe is essentially flat - no measurable fall" (only after #989 is in).
    5. Edit Pipe on the first pipe (CDEDIT, change nothing, OK): the same line appears.
    6. Switch-off twin: set `grade.anyUphillFallIsError` false before AutoCAD starts; the 4 mm uphill pipe reads "essentially flat".
    7. Markup route (Opus R's third check): a markup that leaves a pipe 0.5 mm uphill is not dropped; one that leaves it 4 mm uphill is still refused with "Requested grade fails design validation" (the wording read in Opus R).
    8. Do not use CDRULES to test #1887 (it cannot show the change).
18. **Questions only Tim can answer.**
    1. **Should the markup route keep its old 1 mm uphill limit?** Context: the rest of CE now calls any uphill a red error; the markup route keeps 1 mm so nothing new is refused there. What I understand: the review fix is in and CE 05 has no instruction otherwise. **Recommendation: keep it for now.** On a job: keep means a markup that leaves a pipe 0.5 mm uphill goes through as "flat"; change it and that markup is dropped with "Requested grade fails design validation", a new refusal (R-27).
    2. **Is any uphill acceptable as "flat" at all?** Context: the 5 mm tolerance is an engineering figure. The question of a downhill fall inside the band is already with CE 04, so I am not repeating it. **Recommendation: leave the 5 mm figure; it is Tim's to set.** On a job: red uphill on a 1 mm slip of the pencil is right if you want zero adverse fall; if site tolerance is 5 mm, the wording matters more than the colour.
19. **NOT proven.**
    1. **Built:** yes. #1887 is merged in C-79a (built, installed). #989 is built by its author only (October), unit-tested only, never run on the tip; it has not been brought onto any C-79 branch.
    2. **Tested:** #1887: behaviour tests on the real `ValidatePipe` (4 mm and 1 mm uphill red, 0.4 mm prints "0.4mm", level pipe flat, OFF exact) plus a markup-route test by reflection; not covered: the CD draw window and the CDDASHBOARD wording; C-79a smoke passed on 3.0.89 in general, not for this. #989: `EveryCommandLineWarningLine_GoesThroughPlain` is a source guard that fails before and passes after on the tip; its other test would have passed before. Neither seen in AutoCAD.
    3. **Installed:** #1887 yes (3.0.89). #989 no.
    4. **Tim-accepted:** no, either. BUG-1092 and BUG-563 are OPEN. Nobody has seen the red uphill line or the dash on the command line in AutoCAD that I could find.
