# TRUST-08: Check this drawing, one door

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Rebuild of the Repair window into one door. The old typed commands are not removed until this passes Tim's test.
**Source:** Tim, 4 Nov: "ONE ACTION - PROMPT ON OPENING OF DRAWING". Tim, 5 Nov: "rebuild, sync, all of these other commands, which could just all be folded into one and just super simple and useful". Voice talk 6 Nov: Check this drawing is the goal for the first colleague release. Step 8 of `areas\trust-plan.md`.

---

## FOR TIM

**One button. It reads the drawing and shows you three groups: Sure, Proposed and Unknown. You tick what to accept. CE backs up, applies it as one step, and one U takes it back. CE does not save; you do.**

```before
A revision comes back. Something is off.
CDSYNC? CDREBUILD? CDREBUILDLINKS? CDUPGRADE? CDFIXPIPEENDS?
Each writes straight away. Each can give a different result. Order matters.
```

```after
Check this drawing.
Sure (31): P1 to P12 and their pipes, matched by CE's own identity.
Proposed (4): "Line on the Stormwater layer, 150 wide. Proposed: 150 pipe from P3 to P4, because both ends touch."
Unknown (2): "Pit block with no label. Number Unknown."
Outlet: P1, confirmed.
[Apply the 4 ticked]   then: "Applied. Not saved yet. U undoes it."
```

**It is built in four slices, each its own trial. The first changes nothing in a drawing.**

1. **Slice A, the list (read only).** The three groups, with reasons. Click a row and CE zooms to it and lights up what it is linked to. No Apply button yet.
2. **Slice B, Apply for links.** Accept proposals that link a pipe end to a pit or a label to its pit.
3. **Slice C, Apply for the record.** Add, remove and re-read items, with the outlet step.
4. **Slice D, bringing an old drawing up to date,** and the three "fix" rows (repeated tags, flattened pipes, swapped pipe ends).

## 1. What you'd see

1. **Trigger:** the Check this drawing button on CE Drainage, or the command typed. The opening line (step 1) points to it. It never opens by itself.
2. **Sure:** matched by CE's stored identity. Shown as a count you can open, not as a list to read.
3. **Proposed:** each row says what CE found, what it proposes, and why, in drafting words. Each has a tick box. Nothing is ticked for you where two answers were possible.
4. **Unknown:** what CE could not match. Left as Unknown. You can fill a value in, or leave it for later.
5. **The outlet step:** the question from step 7, if not already confirmed.
6. **Before Apply:** "This will change 4 items in the drawing's CE data and move 0 objects. A backup will be made first."
7. **After Apply:** one line with the counts, "Not saved yet", and what U does.
8. **Nothing to do:** "CE: all linked. Nothing to check." and the window does not open.

## 2. The full experience

1. **Preview:** the list is the preview. It is worked out from a copy of CE's data, so reading it changes nothing.
2. **Cancel and Escape:** at any point before Apply, nothing has changed. Checked with AutoCAD's changed-drawing counter.
3. **Undo:** one accepted Apply = one U. This is a promise that must be proven by probe P2 before the words go on screen.
4. **Backup:** made before every Apply. The backup that exists today copies the last saved file, so work since your last save is not in it. So: if the drawing has unsaved changes, CE says "Save first so the backup is complete" and lets you carry on if you choose (no hard block).
5. **Save and reopen:** CE never saves. After Apply the drawing is marked changed and you save. Reopen: the same list, minus what was applied.
6. **Locked layers:** rows on locked layers are listed as "locked, left alone" and cannot be ticked. Nothing is unlocked.
7. **Xrefs and REFEDIT:** items inside an Xref are listed for information and cannot be ticked. During REFEDIT the check refuses to Apply, with a plain line.
8. **Drawings with no CE record at all** (old LISP work): every pit and pipe arrives as Proposed or Unknown. Nothing is Sure. This is the case C-80's question never covered.
9. **Large drawings:** a progress line; the list can be cancelled while it builds.
10. **AutoCAD 2022 to 2024:** the same window. Rows that need the 2027 pipe object say "needs AutoCAD 2027" and cannot be ticked.
11. **Two drawings open:** the list belongs to the drawing it was made from. Switch drawings and it closes or re-reads; it never applies to the wrong one.
12. **The drawing changed while the list was open:** Apply re-checks first and refuses stale rows, as the exact-link repair already does.

## 3. What folds in, and what stays out

1. **Folds in, as slices land:** the 14 read-only checks and audits (slice A); CDREBUILDLINKS and the hand-link commands (slice B); CDSYNC, CDREBUILD, CDLINKDANGLINGPIPES, CDPROPAGATE (slice C); CDUPGRADE Merge, the pipe conversion, the identity upgrade, and the three fix commands (slice D).
2. **Stays separate, typed only, because of risk or subject:** CDUPGRADE Replace (it wipes the record), CDREFRESHBLOCKS, CDRECOVERINVERTS, CDXREFREPAIR, CDREFRESHLINKS, CDLEGACYAUDIT.
3. **The old commands keep working** until Tim says the door has replaced them. Then they are hidden, not deleted.

## 4. Settings

1. **"Tools update CE's record by themselves":** on today. When slice C is accepted, the core switches this off, and tools that find a drifted drawing say "needs checking" instead. Switching it back on is the undo.
2. **"Back up before Apply":** on. Not offered as off in the core.

## 5. What it reuses

1. **The read-only check** behind step 1.
2. **The exact-link repair,** which already plans, re-checks and sets aside what it will not touch.
3. **The copy-then-apply-once pattern** from the identity upgrade, with its roll-back file.
4. **The reader** (`areas\TRUST_READER_DESIGN_12NOV.md`) for what each object is and which version.
5. **The backup code.**
6. **The existing Repair window's place on the ribbon.**

**New work, stated plainly:** one scanner in place of five; rows with reasons and tick boxes (the Manager repair page has neither, and its Apply is all or nothing); the window itself (Codex builds it from a written contract); the drifted-drawing behaviour in everyday tools.

## 6. How it gets proven

**Before any code:** probe P2 (Undo), probe P3 (what is in each test-set drawing).

**Robot and Codex, on every test-set job, copies only** (pass rules in `areas\TRUST_TEST_SET_12NOV.md`):

1. The list against the written answers: nothing wrong shown as Sure; every Proposed has a true reason; every Unknown is genuinely not in the drawing.
2. Open the list and close it: the drawing is unchanged (changed counter and a comparison of CE's data).
3. Apply, then U once: CE's data is exactly as before.
4. Apply, save, reopen: the applied items are Sure; the rest are as before.
5. Run the list twice on fresh copies: identical, row for row.
6. Locked layer, Xref and REFEDIT cases behave as section 2.
7. The same job on 2027 and 2024.
8. A deliberately broken version that ticks a two-answer row by itself must fail.

**Codex:** looks at the window on a small and a large job: one glance tells you if the job is OK; no scrolling of the layout; no software words.

**Tim, about three working days on real jobs, then colleagues:** open revisions as they come in. Right = the Sure group is right, each proposal's reason is one you agree with, and after Apply the schedule matches the plan.

## 7. Decisions for Tim

1. **The 25 Sep ruling (UX-REP-01)** keeps CDSYNC and CDREBUILD as direct typed commands. Do they stay typed and direct for you while colleagues get only the door? Recommended yes, until slice C is accepted. OPEN (interview C1).
2. **Everyday tools on a drawing that needs checking:** carry on with what CE knows and say "needs checking", never block. Recommended, and it matches no-hard-blocks. OPEN (C2).
3. **What one Apply may do:** only what you ticked, in one step. Old-drawing upgrade (slice D) is always its own Apply, never mixed with link fixes. Recommended. OPEN (C3).
4. **Unsaved changes before Apply:** warn and allow, as above. OPEN.
5. **Pipe conversion and the pit symbol swap that run on opening today:** move them behind this door as rows, so opening a drawing changes nothing. ANSWERED 12 Nov (interview B5). Tim chose "Nothing changes on open": "Opening only reads. The pipe conversion and symbol update become rows in Check this drawing, which you tick and apply. One U undoes it." This supersedes the 16 Sep and 4 Nov answers for the core.
6. **Clicking a pit lights up what it is linked to** (voice talk): in slice A, inside this window. Whether it also works from the Inspector with no window open is a separate small card. OPEN.

## 8. Not known yet

1. How AutoCAD's U treats an Apply made from a window. Not answerable from code.
2. How long the list takes on a large job.
3. How many rows a typical revision produces. If it is 200, the window needs grouping that this card does not yet describe.
4. What old LISP drawings actually contain.
5. Whether one scanner can reproduce everything the five do; one of the five appears to have no caller at all.

Written from reading Civil 3.0.90 (commit cf059dcf). Nothing here was run in AutoCAD.
