# Carpark tidy plan (29 Oct 2026, carpark and planning intake chat)

**Why:** Tim, 29 Oct 2026: "can we start tidying the carpark and bugs?". **Status: PLAN ONLY. Nothing in `BUG_CARPARK.md` has been changed by this plan.** Counts are from a script over the file at about 13:30 Melbourne (1,195 entries, about 2.08 MB). Nothing is deleted or closed (rulings D6 and RULES 10.4: any bulk removal needs Tim's yes with the list).

## 1. What the carpark looks like today

1. **Status:** about 1,013 OPEN (23 of them on hold), 47 IN PROGRESS, 74 FIXED (27 of them Codex- or Claude-accepted), 3 TIM-CONFIRMED, about 19 with a custom status, 1 won't fix, 1 closed.
2. **41 entries have no Status line at all:** BUG-195, 558, 567, 568, 569, 580, 581, 582, 587, 612 to 619, 621 to 640, 647 to 650.
3. **5 entries have more than one Status line** (a later line added under an old one): the latest line is the one that counts; ids not yet listed.
4. **47 IN PROGRESS entries, most of them old and stuck:** about 30 date from 20 to 21 May and 3 to 4 Jul 2026 ("coded, awaiting Tim's AutoCAD test", for example BUG-020 to 042, 058 to 078). Tim no longer hand-tests (20 Oct ruling), so these cannot move until the robot or Codex checks them. Others point at a PR that has since merged (BUG-170, 171, 172, 173, 177, 185, 186, 187, 188).
5. **Generic repeated titles:** BUG-139 to 143 and BUG-144 to 147 all carry the same title ("see REGRESSION_LOG R3 / R4 fix batch"); BUG-590 and 591, and BUG-507 and 515, share a title each.
6. **The file is about 2 MB.** The biggest single entries are very long (BUG-168 about 30 KB, BUG-042 about 25 KB, BUG-079 about 20 KB). The header carries a long id-range history that goes stale (it said BUG-1221 was next when the file had reached 1228).

## 2. Proposed tidy steps, safest first. None deletes anything.

1. **T-1 Header:** keep the template and rules, replace the long id-range history with one line ("next free number = highest in the file plus one; always re-read before writing") and move the history word for word to `areas\CARPARK_ID_RANGES_HISTORY.md`. Nothing is lost; every chat stops reading a wrong "next number".
2. **T-2 The 41 entries with no status:** read each one, then add a Status line that says what it really is (OPEN, or a record of a result). No status is ever changed to FIXED.
3. **T-3 The 5 entries with two status lines:** keep both lines, mark the older one "(older)" so the latest is clear.
4. **T-4 The 47 IN PROGRESS entries:** do NOT change their status. Instead list them (id, what was coded, build or PR, what test is waiting) in one table-free list `areas\CARPARK_IN_PROGRESS_RETEST_LIST.md` and hand it to CE 02 (robot and Codex testing) as a retest queue. A bug moves to "FIXED (Codex-accepted)" only after a real AutoCAD pass (RULES 13.3 amendment).
5. **T-5 Entries already fixed or already tested elsewhere:** for each OPEN entry, check the acceptance ledgers and the robot reports for a PASS on the same case and add a one-line "Evidence" note under the entry. Opus job, read-only against the ledgers; status still changes only by the acceptance rules. Biggest saving of Tim's time.
6. **T-6 Groups:** give the repeated generic titles a one-line pointer ("batch of five, see BUG-139 to 143") and group the Civil, Structural and Manager findings from the read-only audits (BUG-549 to 650, 699 to 853, 873 to 1087) by command in `areas\CARPARK_BY_COMMAND_INDEX.md` so a builder can see all open bugs for one command at once. A derived index, not a second bug file (RULES 7.4): the carpark stays the only record.
7. **T-7 Duplicates:** list suspected duplicates (same command, same symptom) for Tim or the desk to confirm. Never merge or close without a yes; the older entry stays and points at the newer.
8. **T-8 Ranking:** a short list of the open bugs that block the 9 Nov colleague release, from the existing pilot-critical lists, so the carpark answers "what matters this week" without reading 1,000 entries.

## 3. Rules while tidying

1. **One writer at a time.** Other chats append to `BUG_CARPARK.md` all day (this chat, CE 01, the robot). A tidy edit is done in one short step: fetch, merge, edit by exact text, commit, push, then re-read; never a rewrite of the whole file.
2. **Never mark FIXED** and never close or delete an entry. Status words follow the acceptance rules.
3. **Tim's words stay verbatim.** A tidy line is marked "(tidy 29 Oct)" so it is not mistaken for his.
4. **Each step is checked:** entry count before and after must match (except new bugs), no entry text lost, the push is level with origin.

## 4. What I recommend doing first

T-1 (header) and T-4 (the retest list for CE 02) today, because they need no judgement and remove the most confusion. T-2 and T-3 next, each entry read first. T-5 and T-6 are Opus jobs for the desk's meters. Needs Tim's yes through CE 04 before any edit to the carpark.

## 5. Progress (updated 29 Oct 2026)

1. **Tim said yes:** "8. yes" (decisions/2026-10-29_TIM_ANSWERS.md item 108).
2. **T-1 done (ccf3c8ae):** the 43 KB "Next BUG ID" line in the carpark header is now one short line; the old line is word for word in `areas/CARPARK_ID_RANGES_HISTORY.md` (checked identical). Entry count before and after: 1,196 and 1,196.
3. **T-4 done:** `areas/CARPARK_IN_PROGRESS_RETEST_LIST.md` lists all 47 IN PROGRESS entries in four groups; no status changed; handed to CE 02.
4. **Next:** T-2 and T-3 (read each of the 41 no-status and 5 two-status entries first), then T-5 to T-8 as desk review jobs.
