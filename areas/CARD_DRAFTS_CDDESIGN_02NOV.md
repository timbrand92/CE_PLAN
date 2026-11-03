# CDDESIGN: five workflow card drafts (8 of 15), Mon 2 Nov 2026

Written by Sonnet on Team for CE 05, at CE 00's request. Read-only: nothing built, tested, installed or opened in AutoCAD; no robot run; no real settings file read. Only this file was written.

## FOR TIM

1. **Five cards below**, one per command. Every card is headed "DRAFT FOR TIM: nothing is approved". The class (Keep, Modify and so on) is a suggestion only.
2. **None of these PRs is on the line `claude/rel-20261102a`.** The outlet warnings (#1940, #1943, #1945) first appear on `rel-20261108a` (C-79b1). The reuse boxes (#1874), #1954, #1956 and #1965 first appear on `rel-20261110a` (C-79b2). #1803 (Save Draft backup) and #1984 (STORM "None" wording) are on no train: they are drafts. #1217 and #1215 are not merged at all; Opus says the same fix is already on the line (card 5).
3. **Two things in the brief did not fit and I could not pin them down.** (a) #1940 and #1943 are not in the CDDESIGN window. They are in the Redesign Apply message (the Civil Hub's network redesign). I found no ribbon button for it, so its exact button name is not pinned. (b) #1965 is CDCALC's Pump system and Rational tabs, not the CDDESIGN window (it also moves CDDESIGN's pump figure). #1984's change is a CDDESIGN command-line line, not a window field.
4. **Questions that need you** (full text in each card, field 18): (a) Kingston credit: 500 L per complete 2,000 L, or the two-step rule (QUESTIONS 115.1, open, and #1874 ships the two-step rule on); (b) may CDDESIGN get one optional box for the council's permitted discharge (without it BUG-1096 can never pass); (c) the Save As folder warning: whole path, once per session, or name plus folder only (QUESTIONS 109 and 110, open); (d) the new STORM "None" sentence is the builder's wording, not yours; (e) CDCALC's Detention Design and WSUD tabs still start at 0.85 for roof and paving, not 0.9.
5. **Read:** the Opus pre-reviews I, T, the re-check, 1984 to 1988, AD, BACKLOG R4 and R6; the train lists; the b2 finalizer report; the carpark; QUESTIONS_FOR_MONDAY; Tim's 29 Oct answers; the four older family cards (headings and searches only); and the code on the lines by `git show` and `git grep`.
6. **Not read or not checked:** I did not open the window, run anything, or read the b1 finalizer report in full. I did not re-check the 9 Oct commits (6ae16dde, 9793b9e7) that Opus says already fix BUG-511 and BUG-509. I did not check whether #1803's small fix (Opus said CHANGE-NEEDED) has been added since 1 Nov.
7. **Not proven for any of the five:** Built and unit-tested only (for the ones in a train). Installed: no. Nobody has opened any of them in AutoCAD. Tim-accepted: no. No bug here is FIXED.
8. **Newer drafts that could change these cards:** the latest Civil line I looked at is `rel-20261112a`. The brief named `rel-20261102a` as the latest; it is the older base. Cards describe code as it is on `rel-20261110a` and `rel-20261112a` unless said.

---

## Facts common to all five cards (checked in files and code)

1. **Ribbon.** CDDESIGN is registered as label "Design setup", group Calculations, subgroup Core (`Modules/Drainage/Assets/Config/command-registry.json`, entry CDDESIGN). Short description: "Review the current drawing's design inputs and work out the design. Nothing is drawn." In the toolbar layout it sits in the section named "Design", with "Rainfall" and "Legal point of discharge" (`ce_toolbar_layout.json`). The ribbon tab title is "CE Civil" with classic tabs, otherwise "CE" (`CeCvlRibbonContributor.cs`). I could not confirm from files which panel name the unified ribbon shows. GUESS: the "Design" panel on the CE tab.
2. **Window.** Title "Design". Tabs: Start, Setup, Areas and route, Results. Buttons along the bottom: Next missing input, Work out design, Save Draft, Confirm LPD, Confirm setup, Cancel (Start tab) or Close (other tabs). Fixed size 1280 by 800, cannot be resized (Opus review I).
3. **Switches.** All new switches in these PRs live in the Settings file and default ON. A missing file or group reads ON. OFF restores the old behaviour, except where a card says otherwise.
4. **Protection.** None of the five cards draws or edits a drawing object. Layers, Xrefs and REFEDIT are not touched by any of them. Details per card, field 9.
5. **Accepting.** Per RULES 4.5, a Codex PASS in real AutoCAD counts as "Codex-accepted"; items needing engineering judgement (council values, Kingston credit) still need Tim's word.

---

# CARD 1 of 5: Rainwater reuse boxes and the Kingston credit

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Rainwater reuse group in the CDDESIGN window: type the reuse tank size, the roof connected to it and whether it is plumbed for reuse, and the result shows the council's credit beside the storage (never taken off it). Also Manningham's 2,000 L minimum now tested on the reuse share (#1954).
2. **Ribbon or trigger.** Ribbon "Design setup" (command CDDESIGN), then the tab "Areas and route". The group is headed "Rainwater reuse" and sits on the right of that tab.
3. **Works today (what Keep would protect).** On `rel-20261102a` there is no reuse group, so the credit is never worked out on a real job (carpark BUG-1096). The Areas and route tab has: Whole site area (m²), Roof and paved area (m²), Job mode, a "Detention is required" tick and "Head on the orifice (m)". Councils CE works out itself give a storage figure. Councils that give the permitted discharge (eight at the base: Kingston, Bayside, Monash, Boroondara, Manningham, Casey, Growth Areas, Port Phillip) show "Site Storage Requirement (SSR): not sized".
4. **What the train or PR changes.**
   1. **#1874 (B-029, BUG-1096 with BUG-1098), head 1b8b4af1.** Switch `detention.rainwaterReuseBoxes`, ON. Adds the three boxes below, the credit section on the result, "needs confirmation" for a council with no recorded rule, and Kingston's own two-step rule instead of 500 L per complete 2,000 L. OFF: no group, no credit, exactly as before. The PR's base is the older `claude/rel-20261026z`, about 110 commits old. On `rel-20261110a` it arrived as 14 files of its own (b2 finalizer report). First on `rel-20261110a` (C-79b2); not on `rel-20261102a`.
   2. **#1954 (BUG-1108), head da8e8f68, stacked on #1874.** Switch `detention.reuseMinimumUsesReuseShare`, ON. Manningham's 2,000 L minimum is tested against the reuse share (whole tank less litres kept for detention), not the whole tank. Latent: no box sets the detention litres yet, so with nothing typed the whole tank is tested as before. First on `rel-20261110a`.
   3. **Later wording (already in the code on the line):** when a council gives the permitted discharge, the warning now names the council and says CDDESIGN has no box for it (see field 6).
5. **Suggested class: Modify.** The tab and its output change; the engine is kept. Reason: new group and a new result section on a window drafters already use.
6. **Prompts and windows (exact wording from the code and window).**
   1. Group heading: "Rainwater reuse". Labels: "Reuse tank size (litres)", "Roof connected to the tank (m²)", and a tick "Plumbed for reuse (toilets or year-round demand)" (`CivilDesignWindow.xaml` 216 to 221).
   2. No storage figure, council gives the discharge: "Reuse tank entered. Kingston gives the permitted discharge, and CDDESIGN has no box for it yet, so there is no storage figure and no reuse credit. Take the permitted discharge from the council's letter and work the credit by hand." (`AutoDesignOrchestrator.cs` about 311; council name varies.)
   3. Detention off: "Reuse tank entered, but detention is switched off for this design, so there is no storage figure to credit. No reuse credit has been worked out."
   4. Council with no reuse rule but a storage figure: "Reuse tank entered, but {council} has no recorded reuse-credit rule: the credit needs confirmation with the council. No credit has been taken." and on the sheet "Credit:               NEEDS CONFIRMATION (Unknown) — no credit taken" (the dash is an em dash).
7. **Selection.** No drawing selection. Typing only. The roof box is pre-filled from a STORM rating report if one was read; Opus noted it sums the roof of every tank row, so on a two-dwelling job both roofs go into one box (Opus I, not proven on a real report).
8. **Preview.** The Results tab "Design result" is the preview. The credit shows as "Net SSR (if claimed)" beside the gross figure, with a note that council approval is typically required. Nothing is drawn.
9. **Drawing output.** None. Nothing drawn, no layer, no Xref, no REFEDIT involvement. The boxes are not saved in the drawing (Opus I), so a second run without retyping drops the reuse section.
10. **Cancel, Escape, Undo and Redo.** Close or Cancel leaves the drawing as it was. Nothing is written by Work out design, so nothing to undo. Save Draft is card 2.
11. **Save and reopen.** The three reuse boxes are not saved (Opus I, item 6.1.5). GUESS: unchanged by #1954. Not re-checked on the later lines.
12. **Assets, data and Settings.** Reads: Settings switches `detention.rainwaterReuseBoxes` and `detention.reuseMinimumUsesReuseShare`; the council profile file (`council-profiles.json`). The shipped council file has no `reuseCredit` rule for any council, so Kingston, Manningham and Casey use numbers built into the code (2,000 L minimum, 500 L credit, 2,500 L step, 1,000 L credit, 50 m² roof). Writes: nothing.
13. **Performance.** Not measured. The page has no scroll area; if the left column ever grew too tall it would be cut off, not scrolled (Opus I, by estimate). At 150 % scaling on a 1920 by 1080 laptop the bottom button row is off the screen on every CDDESIGN page; that was true before this PR.
14. **Discovery.** Ribbon button "Design setup"; command line CDDESIGN. Help page text for CDDESIGN (`guide-content.js`) says "Design setup tabs: Setup; Areas and route; Results". It does not mention the reuse group. GUESS: Help is not updated.
15. **Example drawing and expected result.**
   1. Engine example Tim agreed (carpark BUG-1096): a Manningham job with 10 m³ gross storage, 300 m² roof to a 3,000 L plumbed tank, 500 m² impervious. Credit 0.25 × 10 × 300 ÷ 500 = 1.50 m³, net 8.50 m³. **Cannot be reached in CDDESIGN yet:** Manningham gives the permitted discharge and there is no box for it, so the sheet shows no storage and no credit. It is proved only through the engine (unit test, permitted discharge 6.0 L/s supplied).
   2. Kingston 6,000 L tank: new rule gives 1,000 L = 1.00 m³; old rule gave 1,500 L. Unit-test fact only, for the same reason.
   3. A council CE works out itself (Opus suggests Frankston, 600 m² lot, roof and paved 400 m², tank 6,000 L, roof 150 m², plumbed ticked): "RAINWATER-TANK REUSE CREDIT" section, "NEEDS CONFIRMATION (Unknown)", "(the gross figure stands)", one "Watch out:" line, storage identical to the run with the tank box blank. GUESS on the council: confirm the right test council with Tim.
   4. #1954: Manningham, 3,000 L tank with 1,500 L of detention would have 1,500 L of reuse and no credit. Not reachable in CDDESIGN (no detention-litres box).
16. **Older family card.** `docs\workflows\CDDESIGN_WINDOW_CONTRACT.md` (15 Sep 2026): defines the order of questions and what may block, says nothing of a reuse group (its text search finds no "reuse"). `CE_DESIGN_GUIDEBOOK_RULESET.md` line 89 holds Manningham's "0.25 × SSR × (roof connected ÷ total site impervious)" but not Kingston's two-step rule. `ROOF_AREAS_DOWNPIPES_AND_WHERE_THEY_GO.md` covers tanks and the STORM report as a finding, "Nothing here is built". `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md` is the gravity pipe engine and does not cover detention reuse.
17. **Tim's AutoCAD checklist** (on an installed build of `rel-20261110a` or later, a copy of a job drawing, settings set before AutoCAD starts).
   1. Open the copy. On the CE ribbon click "Design setup".
   2. Click the tab "Areas and route". **Expect:** a group "Rainwater reuse" on the right with the three boxes, no scroll bar, nothing cut off at the bottom.
   3. Setup tab: choose council Kingston. Areas and route: site 600, Roof and paved 400, tick "Detention is required". Type 6000 in "Reuse tank size (litres)" and 150 in "Roof connected to the tank (m²)". Click "Work out design", then the Results tab. **Expect:** "Site Storage Requirement (SSR): not sized", one "Watch out:" line saying Kingston gives the permitted discharge, no reuse credit section.
   4. Change the council to a council CE works out itself (for example Frankston, GUESS). Type the same figures and tick "Plumbed for reuse". Work out design. **Expect:** a reuse credit section reading "NEEDS CONFIRMATION (Unknown)" and the storage the same as with the tank box blank.
   5. Settings: set `detention.rainwaterReuseBoxes` to false before AutoCAD starts. **Expect:** no "Rainwater reuse" group and the result as on the old build.
   6. Look at the window at 100 % scaling, light and dark, and tell me anything cut off.
18. **Questions only Tim can answer.**
   1. **Kingston credit.** Context: #1874 ships a two-step Kingston rule; QUESTIONS 115.1 (open) recommends your stricter 10 Jun reading. What I understand: Kingston's own note says 500 L for a 2,000 L tank and 1,000 L for 2,500 L or more; the older code credited 500 L per complete 2,000 L. Recommendation (from the finalizer report, not mine): keep the stricter reading until the council document is re-read, because the credit goes on a sheet a council reads. On a job: a 3,000 L tank shows 500 L credit (stricter) or 1,000 L (two-step). Nothing is decided.
   2. **One optional box for the council's permitted discharge.** Context: all councils with a reuse rule give the discharge themselves, so no reuse credit can show in CDDESIGN today. What I understand: Opus recommended yes; decision 123 notes BUG-1096 stays open until it exists. Recommendation: yes, one optional box, because otherwise BUG-1096 can never pass its own AutoCAD step. On a job: you could type 6.0 L/s from the council letter and see 1.50 m³ on a Manningham job instead of "not sized". Unanswered; not a decision.
   3. **Shorten the group's grey hint to one line?** Opus suggested "Optional. Shown on the result beside the storage, never taken off it." Recommendation: yes. Small.
19. **NOT proven.**
   1. **Built:** yes, #1874 and #1954 were built and unit-tested on net10 inside C-79b2 (the finalizer's focused run: 2,906 passed, 3 skipped, 0 failed across its 120 class filters). Net48 shows 129 reds the finalizer calls reference-only; 4 are in #1956's tests, none named for #1874.
   2. **Tested:** unit tests only. The window has never been looked at, at 100 % or 150 %. Nothing run in AutoCAD.
   3. **Installed:** no. The b2 train was assembled; no install is recorded in the files I read.
   4. **Tim-accepted:** no. BUG-1096 and BUG-1098 stay OPEN.

---

# CARD 2 of 5: Save Draft

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Save Draft in CDDESIGN keeps what the job's Design draft holds: #1956 keeps fields a newer build wrote; #1803 keeps a damaged draft as a backup first.
2. **Ribbon or trigger.** Ribbon "Design setup" (CDDESIGN), then the button "Save Draft" at the bottom of the window. "Confirm setup" uses the same save (Opus R6: all three Design save buttons go through one `Save`).
3. **Works today.** Save Draft writes the Design draft into the drawing's own record. Today, a colleague on an older build who presses Save Draft leaves out the fields a newer build wrote (the orifice head and "detention required" of 3.0.72), so on the newer build the check says "could not be checked". A damaged saved draft is replaced by the next Save Draft; the old answers are lost for good (carpark BUG-1143). The old code refuses with "The saved Design draft has the wrong drawing type." when the stored object is the wrong kind.
4. **What the train or PR changes.**
   1. **#1956 (B-120, BUG-1156), head 8b7ade95, stacked on #1874.** Switch `detention.designDraftKeepsUnknownFields`, ON. Keeps unknown fields and writes them back. OFF: strips them on read, the old behaviour. Opus: KEEP-WITH-NOTE. The finalizer names it separately (Rule 14 d): it changes what Save Draft writes into the drawing's draft; additive, no key renamed or removed. First on `rel-20261110a`. Not on `rel-20261102a`.
   2. **#1803 (BUG-1143), head b76db8f3, base `claude/rel-20261025r` (384 commits behind at 1 Nov).** Switch `linking.designKeepsUnreadableDraftBackup`, ON, with a row on the Newer tools tab of both Settings windows. When the saved draft cannot be read, Save Draft or Confirm setup first copies it into a second record `CE_CVL_DESIGN_START_DRAFT_UNREADABLE_BACKUP`, then saves. **Not on any train.** It is a draft.
5. **Suggested class: Modify** for both (saved data and a message change; the command and window stay). #1803: Opus BACKLOG R6 says **CHANGE-NEEDED (small)**, then Civil area plus smoke and a Codex window look.
6. **Prompts and windows.** #1803 message after save: "[CE] The old Design draft could not be read. It has been kept in this drawing as a backup; the CE administrator can recover it." If a backup already exists, the earlier one is kept and a different message prints. The Newer tools tab gets one new Settings row; at 670 px high against a 673 px limit measured on an old base, so the assembled line must be re-checked (Opus R6). #1956 adds no wording.
7. **Selection.** None.
8. **Preview.** None. The saved draft is read back when CDDESIGN is next opened.
9. **Drawing output.** Only the drawing's own named records (CE's dictionary) are written, inside the existing document lock and transaction. No object, layer or Xref is touched. A failed write rolls back both records and prints nothing (Opus R6). The fault Opus found in #1803: if the stored entry is not a drawing record of the expected kind, and either the switch is OFF or a backup already exists, the old entry is removed with no copy and no clear message. Before, CE refused. So OFF does not restore the old behaviour in that rare case. Fix suggested: with OFF keep the old refusal; with an earlier backup keep the object under a second name.
10. **Cancel, Escape, Undo and Redo.** Cancel or Close writes nothing. #1803: the backup and the new draft are written in one change, so one U should remove both and REDO return both (Opus R6 says "by reading only"; the robot must prove it).
11. **Save and reopen.** The point of both PRs. #1956: draft with newer-build fields, saved by this build, reopens with those fields intact. #1803: a backup record is still there after Save, close and reopen. Nobody has proven either in a real drawing.
12. **Assets, data and Settings.** Reads and writes the drawing's Design draft record. Settings switches as above. `DraftUnknownFieldsRule` holds the unknown fields as a catch-all.
13. **Performance.** Not measured. Records are small. GUESS: no noticeable cost.
14. **Discovery.** Button "Save Draft" in the window. Help does not mention backups (GUESS; not checked).
15. **Example drawing and expected result.**
   1. #1956: a draft saved by 3.0.72 holds orifice head 0.5 m and "detention required". On an older build open CDDESIGN, press Save Draft. On 3.0.72 reopen: the orifice head is still 0.5 m and the check no longer says "could not be checked". (Numbers illustrative, GUESS.)
   2. #1803: on a copy, put `{bad draft json` into the Design draft record. Open CDDESIGN (it says it starts a fresh draft). Save Draft. **Expect:** the backup record holds exactly `{bad draft json`, the new draft is saved, the message above prints.
16. **Older family card.** `CDDESIGN_WINDOW_CONTRACT.md` describes the questions and what may block; it has nothing about unknown fields or a backup of a damaged draft, and predates the 3.0.72 draft fields. No other older card covers Save Draft.
17. **Tim's AutoCAD checklist** (a robot case is better for the damaged-record steps; drawing copies only).
   1. Open a copy. Click "Design setup". On Setup, type a job name; on Areas and route, tick "Detention is required" and type 0.5 for "Head on the orifice (m)". Click "Save Draft". Close the window. Reopen "Design setup". **Expect:** the same entries are there.
   2. Close and reopen the drawing (save first), open "Design setup". **Expect:** same entries.
   3. Press U after Save Draft. **Expect:** the draft goes back to how it was before; press REDO and it returns.
   4. For #1803 (only once it is on a train): Settings, Newer tools tab, find the row for the backup (name not shown in the files I read), confirm it is ON, and read that the row fits with no scroll bar.
18. **Questions only Tim can answer.** None on #1956. On #1803: Opus found no Tim answer on BUG-1143 in the 29 Oct file, and the warn-and-keep-a-copy choice fits the "only two hard blocks" rule (R-27). Question: **should #1803 ride a train once its small fix is in, or wait for the Codex window look?** Recommendation: wait for the small fix, then include it with a Codex look at the Newer tools tab. On a job: a colleague whose draft was damaged keeps a recoverable copy instead of losing the agreed design.
19. **NOT proven.**
   1. **Built:** #1956 yes (inside C-79b2; 4 of its tests show reds on net48 only, "reference-only" per the finalizer, all pass on net10). #1803 built by its author only; not in a train.
   2. **Tested:** unit tests and source-order guards only. The backup write, rename, message, U and REDO are not proven in a real drawing. The #1803 red was taken against a stub, not the old Save (Opus R6).
   3. **Installed:** no.
   4. **Tim-accepted:** no. BUG-1156 and BUG-1143 stay OPEN.

---

# CARD 3 of 5: Approved outlets warnings

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** Three warnings about the approved outlet record: a damaged saved outlet-roles record (#1940), an unreadable CDLPD record (#1943), and approved outlets that were approved under another file path (#1945). Each warns once and carries on.
2. **Ribbon or trigger.** **#1940 and #1943 are not in CDDESIGN.** They are in the network Redesign Apply (the Civil Hub's network redesign), which ends with the message "Redesign applied: … pits and … pipes." I found no registry or ribbon entry for it; the code calls `NetworkRedesignApplyCoordinator.Apply` from `CivilHubService.cs`. GUESS: opened from the Civil Hub. **#1945** is on the CDDESIGN command line after CDDESIGN loads the approved outlets, and writes its record when CDLPD ("Legal point of discharge" on the ribbon) approves Design outlets.
3. **Works today.** Redesign Apply with a damaged outlet-roles record skips the outlet check silently and overwrites the record. With an unreadable CDLPD record it treats the drawing as having no Fixed outlet and says nothing. CDDESIGN decides approved outlets belong to the drawing by its identity number, which a Save As copy keeps, so a Save As copy loads the old job's approved outlets without a word.
4. **What the train or PR changes.** All three are first on `rel-20261108a` (C-79b1) and are not on `rel-20261102a`.
   1. **#1940 (B-121, BUG-1144), head c55494e0.** Switches `linking.redesignApplyNoticesDamagedOutletRoles` ON and `linking.redesignApplyStopsOnDamagedOutletRoles` OFF. One warning, a kept copy of the damaged record (`OUTLET_ROLES_DAMAGED_COPY`), Apply carries on. OFF on the notice restores the old write exactly.
   2. **#1943 (BUG-1153), head 62c8f363, stacked on #1940.** Switches `linking.redesignApplyNoticesUnreadableLpd` ON and `linking.redesignApplyStopsOnUnreadableLpd` OFF. One warning that the Fixed-outlet check was skipped.
   3. **#1945 (BUG-1158), head 7c31c33c on the train list.** Switch `linking.lpdWarnsWhenOutletsApprovedInAnotherFile`, ON. CDLPD records the drawing's file path when it approves Design outlets; CDDESIGN prints one line when the path differs. Opus asked for fixes: no template or `.dwt` path is recorded, wording "Approve the outlets again in CDLPD to clear this warning", and the never-saved check must compare the drawings with `==` not `ReferenceEquals`. All three are in the code on `rel-20261110a` (checked: `LinkService.SameDatabase` is used, and the warning carries the clearing sentence).
5. **Suggested class: Modify** (each adds a warning to an existing command; none removes or replaces one). Carpark asked for a block; R-27 and CE 04 made it a warning, with a second OFF switch that would stop (#1940, #1943).
6. **Prompts and windows (exact wording).**
   1. #1940: "Warning: the outlet roles saved in this drawing at the last redesign could not be read, so the check of the nominated outlets against them was skipped." plus, only when a copy was really made: " CE kept a copy of the damaged record in this drawing (CE_CVL_NETWORK_REDESIGN, OUTLET_ROLES_DAMAGED_COPY) before writing the new roles." (`RedesignOutletRecordRule.cs` 42 to 47). A second sentence is used when no copy could be made.
   2. #1943: "Warning: this drawing has a legal point of discharge (CDLPD) record that CE cannot read, so the check that keeps a Fixed outlet where it is was skipped. Apply does not change the CDLPD record. Open CDLPD to check or re-confirm the outlet." The stop version (switch ON): "…Apply is stopped so a Fixed outlet is not changed by mistake. Open CDLPD to check or re-confirm the outlet, then run the redesign again."
   3. #1945: "Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder. If this is a new job started with Save As, check the outlets are right for it before relying on them. Approve the outlets again in CDLPD to clear this warning." (`LpdSaveAsCopyRule.cs` 21 to 22.)
7. **Selection.** None. #1940 and #1943 come with the redesign's own nominated outlets. The Redesign result shows as an information message window.
8. **Preview.** The warnings appear after Apply, in the result message, not in the redesign preview (Opus T, accepted under R-27). #1945's line prints on CDDESIGN's command line.
9. **Drawing output.** #1940 writes one hidden record (Xrecord) in the drawing's own network-redesign dictionary, inside the existing Apply transaction. No layer, so locked layers cannot apply; it goes to the active drawing's database, never an Xref's; Apply refuses while REFEDIT is active (existing behaviour). Rest of Apply (pits, pipes, schedule) is unchanged by this PR. A damaged wrong-type record still ends in "Nothing was applied" (existing, Opus T item 4). #1943 only reads. #1945 writes one more hidden record `DESIGN_APPROVED_PATH` in CDLPD's own dictionary inside CDLPD's existing transaction; CDDESIGN only reads and prints.
10. **Cancel, Escape, Undo and Redo.** One Undo removes the kept copy and the redesign together (Opus T, by reading). #1945: one U after CDLPD approval removes the path record with the outlets. Not proven in a drawing.
11. **Save and reopen.** The copy and the recorded path are in the drawing and should survive save and reopen. A second damaged Apply overwrites the earlier copy: only the latest damage is kept (Opus T). A drawing approved before this build records no path, so never warns.
12. **Assets, data and Settings.** Five Settings switches above. Drawing records: `OUTLET_ROLES`, `OUTLET_ROLES_DAMAGED_COPY`, the CDLPD record, `DESIGN_APPROVED_PATH`.
13. **Performance.** Not measured. #1943 reads the CDLPD record a second time only when the first read fails (Opus T, optional tidy).
14. **Discovery.** Only through the message and the command-line line themselves. No Help change that I found.
15. **Example drawing and expected result.**
   1. #1940: on a test copy that has been through one Apply, replace the `OUTLET_ROLES` text with `xx`, run the redesign and Apply. **Expect:** Apply completes; the warning above; `OUTLET_ROLES_DAMAGED_COPY` holds `xx`; `OUTLET_ROLES` is valid again; one U removes both records and the redesign.
   2. #1943: a copy with an old `DATA` record and a newer `AUTHORITY_SET` record. **Expect:** the CDLPD warning; the CDLPD record unchanged.
   3. #1945: in a saved copy, approve Design outlets with CDLPD, save, Save As "2611 Stage 2.dwg", run CDDESIGN. **Expect:** the outlets as before plus the one warning line. In the original file: no warning. A job moved from Z:\Jobs\2611\ to \\server\Jobs\2611\ would also warn with the whole-path test.
16. **Older family card.** None of the four older cards covers outlet approvals. `CDDESIGN_WINDOW_CONTRACT.md` section "What already exists" and the legal point of discharge confirmation tick are the nearest, and predate BUG-1144, 1153 and 1158.
17. **Tim's AutoCAD checklist** (copies only; the damaged-record steps need a robot or Codex).
   1. Open a saved test copy. On the ribbon click "Legal point of discharge", approve the Design outlets, save.
   2. Click Save As and name it "2611 Stage 2.dwg" (or any new name). Click "Design setup". **Expect:** one command-line line starting "Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder."
   3. Open the original file and click "Design setup". **Expect:** no such line.
   4. Start a new drawing from the CE template, approve outlets before saving, save, click "Design setup". **Expect:** no such line.
   5. Settings: set `linking.lpdWarnsWhenOutletsApprovedInAnotherFile` to false before AutoCAD starts and repeat step 2. **Expect:** no line.
   6. #1940 and #1943 need a drawing with a deliberately damaged record: leave that to the robot, then look at the "Redesign applied" message for wording and length.
18. **Questions only Tim can answer.**
   1. **How the Save As folder warning should compare (QUESTIONS 109 and 110, open).** Context: a colleague opening the same job from their own OneDrive folder or another drive letter sees the warning on every CDDESIGN run. What I understand: as built, the whole file path is compared. Three options: (a) warn every time the path differs; (b) once per drawing per session; (c) compare only the drawing name and its folder name. Recommendation (Opus, desk): (c) plus (b), because it keeps quiet when a job moves drive but still catches a Save As to a new name. On a job: with (c), Z:\Jobs\2611\ moved to \\server\Jobs\2611\ stays quiet, "2611 Stage 2.dwg" still warns. Tim's wording question on the folder comparison is still open; the PR ships as built.
   2. **Stop instead of warn?** The carpark asked for Apply to stop. R-27 makes the stop opt-in (a second switch, OFF). Recommendation: leave the stop OFF. No answer needed unless Tim wants a stop.
19. **NOT proven.**
   1. **Built:** yes, inside C-79b1 (finalized per the train lists; I did not read the b1 finalizer report in full).
   2. **Tested:** unit and source-guard tests only. The damaged-record copy, the CDDESIGN warning line and the unreadable-record read were never run on a real drawing or in AutoCAD. The "damaged" fact is set by hand in the tests. What `Database.Filename` returns for a never-saved drawing was not checked in AutoCAD (Opus).
   3. **Installed:** no.
   4. **Tim-accepted:** no. BUG-1144, 1153 and 1158 stay OPEN.

---

# CARD 4 of 5: STORM note for an area marked "None"

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** After CDDESIGN reads a STORM rating report, the note for an area marked "None" (no water-quality treatment) stops saying the area "goes straight out" and asks the drafter to check where it drains.
2. **Ribbon or trigger.** Ribbon "Design setup" (CDDESIGN). The line appears on the command line after CDDESIGN reads a STORM report (`CivilDesignCommand.cs` about line 500 calls the note builder). It is not a window field.
3. **Works today.** The note reads, for example: "Of that, 120.00 m2 goes to a tank and 49.38 m2 goes straight out. Only the part that reaches the tank is detained." (the first half is the existing wording; the code on the line has "goes straight out" in `StormReportOffer.cs` 183 and the `StormReport.cs` meaning "No treatment - this area goes straight out to the legal point of discharge"). CDCALC's catchment proposal also says "Goes straight out" (`CatchmentReportIntake.DestinationWords`).
4. **What the PR changes.** **#1984 (B-151, BUG-1120 part a), head 2c5bd044, DRAFT, Civil area plus smoke, Opus KEEP-WITH-NOTE.** Switch `detention.stormNoneNoteWording`, ON. The second half becomes: `has no water-quality treatment ("None" in the report). That does not mean it skips detention, but CE counts only the part that reaches the tank as detained, so check where it drains.` OFF returns the old sentence byte for byte. **Not on any train.** One commit on `rel-20261102a` (3fbb9da5); the code on `rel-20261110a` does not have the new wording (I searched; no match for "no water-quality treatment").
5. **Suggested class: Modify** (words only; no area or figure moves). Opus: KEEP-WITH-NOTE.
6. **Prompts and windows.** The new sentence above. The sentence is the builder's own wording, not Tim's (report q8, item 6, via Opus). The carpark entry asked for "wording that says 'no water-quality treatment'".
7. **Selection.** None. STORM report is read from the job folder as before.
8. **Preview.** None; command-line text.
9. **Drawing output.** None. Text only. No layer, Xref or REFEDIT involvement.
10. **Cancel, Escape, Undo and Redo.** Nothing written, so nothing to undo.
11. **Save and reopen.** Not saved.
12. **Assets, data and Settings.** Reads the STORM report figures and the switch `detention.stormNoneNoteWording`. Writes nothing.
13. **Performance.** No change expected (GUESS).
14. **Discovery.** Command line only. No Help change.
15. **Example drawing and expected result.** A STORM rating report with 120.00 m² to a tank and 49.38 m² marked "None": **Expect:** "…49.38 m2 has no water-quality treatment ("None" in the report). That does not mean it skips detention, but CE counts only the part that reaches the tank as detained, so check where it drains." Areas and the 120.00 and 49.38 figures are unchanged. Switch OFF: the old "goes straight out" sentence. (Areas are the Opus review's example numbers.)
16. **Older family card.** `ROOF_AREAS_DOWNPIPES_AND_WHERE_THEY_GO.md` covers the STORM report as machine-readable ("533 job folders") and the tank-versus-LPD split; it was written before the "None" sentence existed and says nothing of the wording.
17. **Tim's AutoCAD checklist** (once the PR is on a train).
   1. Open a copy of a job that has a STORM rating report with at least one area marked "None". Click "Design setup".
   2. Let CDDESIGN read the report. **Expect:** the note says the area "has no water-quality treatment" and tells you to check where it drains. The areas stay the same.
   3. Set `detention.stormNoneNoteWording` to false before AutoCAD starts and repeat. **Expect:** the old "goes straight out" sentence.
   4. Run CDCALC's catchment proposal for the same report. **Expect (known):** it still says "Goes straight out" (left alone on purpose).
18. **Questions only Tim can answer.**
   1. **Is this sentence right for a drafter?** Context: the exact wording is the builder's. What I understand: the report's "None" means no water-quality treatment, not "does not drain through a tank". Recommendation: accept it, because it tells the drafter to check the drain and does not claim the area skips detention. On a job: a 49.38 m² roof marked "None" no longer reads as if it goes to the street untouched.
   2. **Change CDCALC's matching "Goes straight out" too?** Recommendation: yes, as a follow-up, so both screens agree. Unanswered.
19. **NOT proven.**
   1. **Built:** yes, by its author; 101 of 101 tests per the report (via Opus).
   2. **Tested:** unit only. No test was run red before (the new tests cannot compile on the old code). Not run on a real STORM report.
   3. **Installed:** no. Not on any train.
   4. **Tim-accepted:** no. BUG-1120 stays OPEN (this is part a only).

---

# CARD 5 of 5: Pump system and Rational tabs read one roof-and-paved C; the detention pipe and summary C lines

## DRAFT FOR TIM: nothing is approved

1. **Name, and what it does for a drafter.** The roof-and-paved runoff C (shipped 0.9) is read from one Settings figure in CDCALC's Pump system and Rational tabs (#1965). Two older lines are also covered: CDDESIGN's detention pipe follows the Settings run limit and size range (#1217 / BUG-511) and the CDDESIGN summary prints the council's own C (#1215 / BUG-509).
2. **Ribbon or trigger.** #1965: ribbon CDCALC, tabs "Pump system" and "Rational" (the exact ribbon label for CDCALC was not read; GUESS "CDCALC" in the Calculations group). It also reaches CDDESIGN's pump path ("Design setup"). #1217 and #1215: ribbon "Design setup", Results tab.
3. **Works today.**
   1. **C:** Settings `detention.hardGroundRunoffC` (default 0.9, a blank, zero, negative or above 1 falls back to 0.9) is read by CDDESIGN and CDCALC's Boyd's tab (ON by default since 29 Oct). The Pump system tab had a fixed 0.90 and the Rational tab started a new row at 0.9. CDCALC's Detention Design tab and the WSUD tab start at 0.85.
   2. **#1217:** on the line since 9 Oct (commit 6ae16dde per Opus R4), CDDESIGN's detention pipe size and length read the Settings run limit (40 m) and size range (225 to 600 mm at the defaults) through `DetentionPipeLimitsRule`. The tip's list runs 225 to 1200 mm limited by Settings.
   3. **#1215:** on the line since 9 Oct (HUNT2-C-05, commit 9793b9e7 per Opus R6), the summary line "Before-development C (whole site)" prints, for example, "0.40  (the council's own figure)" through the one chooser the calculation uses, and keeps the office figure (0.35) when no C was used (a council-provided discharge).
4. **What the train or PR changes.**
   1. **#1965 (B-133, BUG-539), head 2f7549e6.** Switch `detention.pumpAndRationalUseHardGroundC`, ON. First on `rel-20261110a`. Not on `rel-20261102a`. At the shipped 0.9 nothing on screen moves. If the office figure is changed in Settings, the Pump weighted C and a new Rational row follow it. Saved Rational sessions keep their saved C. It also moves CDDESIGN's pump figure (the report and log mention only CDCALC).
   2. **#1217, #1215: nothing to merge.** Opus R4 says close #1217 as superseded by 6ae16dde; Opus R6 says close #1215 as superseded by HUNT2-C-05. Both are on `rel-20261009w` bases (1,668 commits behind). I did not re-verify the commits. **Closing is for CE 00 or Tim; I have closed nothing.**
5. **Suggested class: Keep** for #1217 and #1215 (already on the line; the PRs are duplicates). **Modify** for #1965 (one value, two more tabs).
6. **Prompts and windows.** #1965 working note example with office C of 0.8: "Weighted C = (120.0 m² × 0.8 + 80.0 m² × 0.3) / 200.0 m² = 0.6000" (was always 0.9, giving 0.66). The Rational tab's new row should show "0.8" in the C column. #1215's line: "Before-development C (whole site)  0.40  (the council's own figure)".
7. **Selection.** None.
8. **Preview.** Calculation tabs only; nothing drawn.
9. **Drawing output.** None. Calculation tabs and a report line. No layer, Xref or REFEDIT involvement. No protected file touched by #1965.
10. **Cancel, Escape, Undo and Redo.** Nothing is written to the drawing; no undo step.
11. **Save and reopen.** Rational tab rows reloaded from a saved session keep their saved C (Opus AD).
12. **Assets, data and Settings.** Reads `detention.hardGroundRunoffC` and `detention.pumpAndRationalUseHardGroundC`; `designStandards.detentionMaxRunM` and the diameters for the detention pipe. **There is still no box for the C on the Settings page**; it is a file-only key (Opus AD; carpark asks for one). Writes nothing.
13. **Performance.** No change expected (GUESS).
14. **Discovery.** Through the calculation tabs and the Results summary themselves. No Help change that I found.
15. **Example drawing and expected result.**
   1. Pump system, with office C changed to 0.8: 120 m² roof and paved at 0.8 plus 80 m² soft ground at 0.3 gives weighted C 0.60 (was 0.66 at the fixed 0.9). At 0.9, 0.66 in both.
   2. Not yet matching (Opus AD): 400 m² roof and paving on a 700 m² site with the rest soft ground at 0.3 gives weighted C 0.64 at 0.9 instead of 0.61 at 0.85; CDCALC's Detention Design and WSUD tabs still start at 0.85, so their storage would rise if moved.
   3. #1217: set `designStandards.detentionMaxRunM` to 30 and diameters 300 to 450, run CDDESIGN. **Expect:** a pipe of 300 to 450 mm with a run of 30 m or less, or the "needs a long pipe run" note; CDRULES shows no detention run warning for it (Opus R4 scenario).
   4. #1215: council Darebin with detention on. **Expect:** the summary reads "0.40 (the council's own figure)"; a council with no fixed C reads 0.35.
16. **Older family card.** `CE_DESIGN_GUIDEBOOK_RULESET.md` (15 Sep) seeds council figures as Settings-first and names pump and soakage as out of the guidebook's scope (open question line 115). `CDDESIGN_WINDOW_CONTRACT.md` predates the 0.9 figure. `CARDS\CV-02_HYDRAULIC_DESIGN.md` says charged pipes, pumps and detention "receive dedicated workflow reviews", so a pump card is still owed.
17. **Tim's AutoCAD checklist** (settings set before AutoCAD starts; copy of Settings).
   1. In the Settings copy set `detention.hardGroundRunoffC` to 0.8. Start AutoCAD. Click CDCALC, the "Pump system" tab, enter 120 m² roof and paved and 80 m² soft ground. **Expect:** weighted C 0.6000 and the working line above.
   2. Open the "Rational" tab and add a catchment row. **Expect:** C shows 0.8 (not "0,8" or "0.800").
   3. Click "Design setup" and run the pump line on the same areas. **Expect:** it also reads 0.8.
   4. Set `detention.pumpAndRationalUseHardGroundC` to false and restart. **Expect:** back to the fixed 0.9 in both places.
   5. For #1217 and #1215, use the CDDESIGN scenarios in field 15.
18. **Questions only Tim can answer.**
   1. **Should CDCALC's Detention Design tab and WSUD tab start at 0.9 instead of 0.85?** Context: your decision 177 asked for one figure used by CDDESIGN and CDCALC starting at 0.9. What I understand: these two tabs still start at 0.85, and moving them raises their storage results. Recommendation: yes, move them to 0.9, but tell the office the stored figure rises, because it makes one site give one storage. On a job: a 400 m² roof and paved on a 700 m² site gives weighted C 0.64 instead of 0.61. Unanswered; BUG-539 stays OPEN until you rule.
   2. **Put a box for this C on the Settings page?** Recommendation: yes, one box, so it can be changed without editing a file. Unanswered.
   3. **Close #1217 and #1215?** I did not close them. Recommendation: close both as duplicates, branches kept, after the robot has checked the code already on the line.
19. **NOT proven.**
   1. **Built:** #1965 yes, in C-79b2 (B133RoofPavedCTests 14 cases pass on net10 per the finalizer). #1217 and #1215 are old drafts; their fix is on the line by other commits that I did not rebuild.
   2. **Tested:** unit tests only. Nobody has opened CDCALC with the change. The robot case N19_hard_c is reported sound by Opus but has not been run. The code already on the line for BUG-511 and BUG-509 has not been robot or Codex checked either.
   3. **Installed:** no.
   4. **Tim-accepted:** no. BUG-539, BUG-511 and BUG-509 stay OPEN, none marked FIXED.
