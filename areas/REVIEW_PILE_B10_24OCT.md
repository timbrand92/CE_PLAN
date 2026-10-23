# Opus review of the best unreviewed PRs, batch 10 (Sat 24 Oct 2026, about 05:43 to 05:55 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 103 to 114 of the full list.

I read the code at each PR's exact head (heads re-checked on GitHub at about 05:50; none had moved). I compared the four Structural PRs with installed Structural 1.0.122 (`claude/rel-20261023s` @ e6d597c0) and the S-43 PRs #1695 to #1699. I compared the two Civil privacy PRs with installed Civil 3.0.72 / Manager 1.1.72 (`claude/rel-20261023m` @ f7f7d551) and the C-63 train (`claude/rel-20261024m` @ 28987b73). All merges were in-memory trial merges only. One test run (CE.AI.Core sender tests for #1618). Nothing merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts:** 12 PRs in range. **6 skipped**, already Opus-reviewed: #1607 and #1616 (batch 3), #1614 and #1628 (batch 2), #1626 and #1627 (batch 1). **6 reviewed:** MERGE 3, MERGE-WITH-FIXES 3, HOLD 0, REJECT 0.

2. **Top faults found:**
   1. **#1620 (heartbeat https only) lets the heartbeat go to any https address when the PC has no approved-address record.** The bug asked for https AND the approved address. On a PC with no record, a typo such as `https://ce-cloud.exmaple.com` still gets the PC's access key. Codex's audit #1678 found the same gap. This is Tim's call (see item 6 below). It does fix the main danger: a plain `http://` address no longer sends the key unencrypted.
   2. **#1606 (N/A asks why) saves the reason but nothing shows it.** You type "No Xref on this job", it is kept in the drawing, but no screen, tooltip or report ever shows it. An older N/A with no reason is not marked "needs review" on screen either. The PR says this is owed by the Codex window lane. So the bug cannot close on this PR alone.
   3. **#1608 (R2LTXT asks first) gives a count, not a picture.** The approved rule asks for a preview. You get "1 text will be changed, 0 left alone. Change these texts now? <No>". The text still visibly jumps down and left when converted. The PR says so and leaves it as Tim's call.
   4. **#1615 (F flips side at 25L) covers 25L only.** EBT still asks for rotation after the click. 25L still asks for a misleading "number after 25". Neither is touched. A drafter who used to type B after the click now has no B option: at the insertion question they must type F.
   5. **#1605 (checklist Undo) is the standard repair, not a proven one.** The real reason Undo lost the checklist was never seen inside AutoCAD. The change is low risk, but only a real U and REDO on a checklist proves it.

3. **Safe to merge today:**
   1. **Civil train C-64 (after C-63 and the batch 1 to 3 lists):** #1618 now. #1620 after Tim answers the question in item 6 below.
   2. **Structural train after S-43 (call it S-44), as one stack in this order:** #1605, then #1606, #1608 and #1615 once their small fixes are pushed. They are stacked: each PR's base is the one before, so they must go in together and in order.

4. **Two things to know before the trains are built:**
   1. **Every PR clashes only on `REGRESSION_LOG.md`.** That is the usual end-of-file clash: keep both entries. The Structural stack merges onto 1.0.122 and onto each S-43 PR with no other clash. #1618 and #1620 merge onto C-63, and onto each other, with no other clash.
   2. **The Structural stack adds three Settings switches to the Options group** (`ChecklistNotApplicableNeedsReason`, `R2lTextAskBeforeApply`, `TextSideAtInsertionPoint`), each with a Settings page label. All three start ON.

5. **Rules checks across the batch:**
   1. **Redo (U then REDO):** nothing new writes between a U and its REDO. No PR adds an Idle, command-end, object-change or drawing-switch hook. The checklist palette writes only when a button is clicked.
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. R2LTXT still opens each text for writing the normal way, so AutoCAD refuses a text on a locked layer. One small wording fault: the new count can promise "will be changed" for a locked text (see #1608).
   3. **Switches:** the three new bug-fix switches start ON, and an older settings file keeps ON (the setting starts ON when the file has no line for it). #1606's test named "an old settings file keeps it on" only checks a fresh setting. The behaviour is right; the test name claims more than it checks. #1605, #1618 and #1620 have no switch. They are a storage repair and two privacy fixes, where an OFF position would only bring back the fault.
   4. **CE_SHARED, installer, signed-update files:** none touched. No HOLD for that reason.
   5. **Hard-coded engineering values:** none.
   6. **Hard blocks:** none new. Cancel or No in every new question simply changes nothing. The two privacy fixes refuse to send, which is a quiet "send nothing" rather than a block on the drafter.
   7. **C-63 and S-43 lists:** none of these six bugs is fixed in C-63 or S-43. No duplicate PR, apart from Codex's #1678, which is an audit note only and changes no code.

6. **One question for Tim (work hours, not urgent): where may the start-up heartbeat go on a PC with no approved-address record?**
   1. **What it is:** each time AutoCAD opens, CE quietly sends a small "this PC is alive" note to the CE cloud address, with the PC's access key.
   2. **What #1620 does now:** http is always refused. https is allowed to any address if the PC has no approved-address record, and only to the approved address if it has one.
   3. **Example:** a PC set up by hand with a mistyped `https://ce-cloud.exmaple.com` and no record sends its key there every morning. With the stricter rule, that PC sends nothing until the record is installed.
   4. **My recommendation:** take #1620 as it is for the 9 Nov pilot. It closes the unencrypted-key hole. Then make the record compulsory once every pilot PC has one, so heartbeats do not silently stop on PCs set up before the record existed. Mark the bug as partly fixed until then.

## One item per PR

1. **#1605 BUG-610 (Structural, HIGH): a checklist save changes its two stored records in place, so one N/A click then U no longer loses the checklist.** Head eb7e41e0, base `claude/rel-20261022s2` (an ancestor of installed 1.0.122).
   1. **Cause real?** Partly proven. The code really did erase both checklist records and make two new ones under the same names on every click. That is a known fragile pattern for native Undo. But nobody has seen inside AutoCAD that this is what lost the checklist. The PR says so honestly.
   2. **Fix does only that?** Yes. One small writer changes the existing record's contents. It makes a new record only if none is there. Nothing on screen changes. The save is still one locked, one-transaction change.
   3. **Test fails without it?** Yes, but only as source-text checks (the save no longer contains an erase; it writes exactly two records in place). No test opens a drawing.
   4. **Small risk:** if something other than a plain record ever sat under those names, the save now fails quietly (logged, returns "not saved") instead of replacing it. Not seen in practice.
   5. **Verdict: MERGE. Train S-44, first in the stack.** AutoCAD check (Codex, copy only): four-item checklist, N/A on item 1 (0 of 3), U once (0 of 4, checklist still there), REDO straight away (0 of 3), save, close, reopen.

2. **#1606 BUG-608 (Structural): clicking N/A on a checklist item asks why.** Head 8688153f, stacked on #1605.
   1. **Cause real?** Yes. The N/A button called a plain on/off with no question. The checklist item had nowhere to keep a reason.
   2. **Fix does only that?** Yes. A small "Why is this item not applicable?" box appears. Blank or Cancel leaves the item and the count exactly as they were. A real reason is trimmed and saved in the drawing, with who and when. Taking N/A off never asks. Reset Checklist clears the reasons. Older checklists read as before. Pipes and new lines in a reason survive save and reopen (tested). An older CE build opening the drawing ignores the extra fields. If it saves the checklist, the reason is dropped, which is acceptable.
   3. **Test fails without it?** Yes. 11 tests did not compile before. One is a real save-and-reopen of an item; the rest are rule and source checks.
   4. **Gap:** the reason is never shown anywhere, and an older N/A is not flagged on screen. The bug's acceptance needs the reason visible after reopen and export. Owed by the Codex window lane, as the PR's log says.
   5. **Fixes (small):** (a) rename `TheSwitch_ShipsOn_AndAnOldSettingsFileKeepsItOn`, or add a real check that loads a settings file with no line for this switch and reads ON; (b) put a tooltip with the reason, who and when on the N/A item, or record a named Codex window task for it before the bug can close.
   6. **Verdict: MERGE-WITH-FIXES. Train S-44, after #1605.** Leave BUG-608 open until the reason is visible.

3. **#1608 BUG-645 (Structural): R2LTXT says how many texts it will change and asks Yes/No (default No) before changing them.** Head 5fece523, stacked on #1606.
   1. **Cause real?** Yes. R2LTXT converted straight after selection, with no question.
   2. **Fix does only that?** Yes. It counts, reading only, using the same two tests the conversion uses (pulled into shared helpers, so the count and the result cannot drift apart). Then it asks "Change these texts now? [Yes/No] <No>". No, Enter or Escape changes nothing. Yes converts exactly as before, in one transaction, so one U undoes it.
   3. **Test fails without it?** Yes, 4 tests did not compile before. All are switch and source checks. (The log says 5 in one place and 4 in another; 4 is right.)
   4. **Gap:** a count is not the picture the approved rule asks for. The lettering still jumps when converted; the PR leaves that as Tim's call. A text on a locked layer is counted as "will be changed", then AutoCAD refuses it and the whole command reports "Failed" and changes nothing. That is safe, but the count misleads.
   5. **Fix (small):** in the count, treat a text on a locked layer as "left alone (locked layer)", so the number matches what will really happen.
   6. **Verdict: MERGE-WITH-FIXES. Train S-44, after #1606.** Leave BUG-645 open for the jump and the preview.

4. **#1615 BUG-644 (Structural): at the 25L insertion question, F flips Top and Bottom, and the side is shown before the click.** Head 261aa2e9, stacked on #1608.
   1. **Cause real?** Yes. The question was a plain "Specify insertion point", so F gave "Invalid point". Top or Bottom was asked only after the click.
   2. **Fix does only that?** Yes. The question becomes "Specify insertion point or [Flip] <Top>:". F flips and asks again. A click places it with the side shown. No second question. Enter and Escape behave as before. The automatic placement path (a side already chosen elsewhere) is unchanged.
   3. **Test fails without it?** Yes, 3 tests did not compile before. All are switch and source checks.
   4. **Gap:** EBT's rotation after the click, 25L's misleading "number after 25" wording, and a live preview are not touched.
   5. **Fix (small):** also accept T and B at the new insertion question as well as Flip ("[Flip/Top/Bottom]"). A drafter with years of typing B does not then get "Invalid point".
   6. **Verdict: MERGE-WITH-FIXES. Train S-44, last in the stack.** Leave BUG-644 open for EBT and the wording.

5. **#1618 BUG-991 (Civil, PRIVACY): the shared AI sender no longer follows a redirect.** Head 004ece8d, base `claude/rel-20261023l` (an ancestor of installed 3.0.72).
   1. **Cause real?** Yes. The one shared sender (used by CDASK and the Civil AI paths) was a default web client. It follows redirects. On a "307" redirect it re-sends the whole question, the drawing facts and the access-key header to the new address. CE had only checked the first address.
   2. **Fix does only that?** Yes. One line: that shared client is told not to follow redirects. A redirect now ends as an error ("HTTP 307") and is not retried. Tests that use a fake connection are unaffected.
   3. **Test fails without it?** The new test uses the real shared client against two local addresses: A redirects to B, and B must receive nothing and no key. I ran the sender tests on this head: **15 run, 15 passed, 0 failed.** I did not re-run it on the pre-fix commit (one-build limit). Without the fix the default client follows a 307 with the body and the key, so it should fail there.
   4. **Not covered (outside this bug's fix):** the Structural markup AI senders (`MarkupAIChatService`, `MarkupAIVisionParser`) make their own clients and still follow redirects. Their key header is dropped on a redirect, but a 307 would still carry the request body. Worth its own carpark line.
   5. **Verdict: MERGE. Train C-64.** Nice-to-have, not required: a plain message for a 3xx ("the AI address tried to send you somewhere else; nothing was sent there").

6. **#1620 BUG-990 (Civil, PRIVACY): the start-up heartbeat goes only over https, never follows a redirect, and goes only to the approved address when there is one.** Head 9c7953ce, base `claude/rel-20261023l`.
   1. **Cause real?** Yes. The heartbeat posted to whatever `CE_CLOUD_URL` said, http included, with the access key, and followed redirects.
   2. **Fix does only that?** Mostly. http, or an address with a user name in it, sends nothing. Redirects are off. If the approved-address record is present, only that address is used. The same record checker as the AI seat check is reused, which keeps one rule in one place. Nothing is lost: the outbox is kept (it is already capped at 5 MB) for a later send.
   3. **Test fails without it?** Yes. 4 new tests: http sends 0, a wrong https address sends 0, the approved address still sends 1, and the real sender does not follow redirects. Not run by me.
   4. **Gap:** with no record, any https address is allowed (item 6 of the answer block). A record that is present but damaged blocks the heartbeat, which is the safe way round.
   5. **Verdict: MERGE, pending Tim's answer on item 6. Train C-64, after #1618.** If Tim wants the stricter rule, the fix is one line (`return false` when there is no record) plus flipping one test.

## What I did NOT check

1. **Nothing was opened in AutoCAD.** Every item still needs its AutoCAD check, especially the checklist U then REDO (#1605), the N/A box (#1606), the R2LTXT question (#1608) and F at the 25L question (#1615).
2. **I ran one test set only:** the CE.AI.Core sender tests on #1618 (net8.0). The Structural tests and the Drainage heartbeat tests were not run, so their pass counts come from the PR authors. Nothing was built for net48.
3. **I did not run #1618's test on the pre-fix commit**, so its "fails without the fix" is reasoned, not seen.
4. **Trial merges were against installed 1.0.122, each S-43 PR, installed 3.0.72 and C-63 only.** Not against every other open PR, and not against the batch 1 to 9 merge lists as one assembled branch.
5. **I did not check whether the office's pilot PCs have the approved-address record set**, which decides how much item 6 matters.
6. **Housekeeping:** an untracked `.codex/` folder appeared in the main checkout `C:\Lisp Files\CE_ACAD_PLUGIN` during this run. It is not mine, and I left it alone.
