# How the board is kept (revision 1)

**Made:** Wed 18 Nov 2026, Melbourne time. **Why:** Tim, 18 Nov 2026 (D-226): "build the board, in future i dont want to be the one managing anything apart from what is in chat, that should all be done by you or anyone else or anything else. you need to ensure this is handled from now on with no issues". The board is `BOARD.md`. Tim edits nothing, tracks nothing and remembers nothing. The only things he sees are the questions put to him in chat.

**Who keeps it:** the planning chat, "CE_ACAD / zero plan / 01", with any helper or tool it needs. Nobody else edits the board's lists.

## 1. What triggers an update

1. **Every answer from Tim.** In the same reply as his words are recorded in `DECISIONS.md` (RULES 9.4, 9.7).
2. **Every report from a side chat.** The build chat, the tools interview chat, the trials chat, the clean-up chat and any new one. The planning chat reads their files at each wake-up and does not wait to be told.
3. **Every timed wake-up.** First job at each one, before the queue in `LOOP_QUEUE.md`.
4. **Before every progress answer** to Tim, so what he is told matches the board.
5. **Every night run of the checks** in section 4 below.

## 2. The routine at each update

1. **Read `BOARD.md`** and the places the sources live (the list in its section 9).
2. **A new item gets the next ID in its own list** (W, O, N, U or K). The next number is the highest used plus one. An ID is never reused, renumbered or deleted.
3. **Say where it came from** (document and ID), the date it was first raised, and for anything waiting on Tim how much it blocks (BLOCKS BUILDING NOW, needed before a named tool, can wait) and whether he can answer with one click, needs to be at the PC, or needs to supply a document.
4. **Merge duplicates.** The same question raised in two documents is one item listing both sources.
5. **An answered item moves to "CLOSED THIS WEEK"** at the bottom of the board with the decision number that closed it. It is never deleted. A closed item older than a week is moved to the closed list in the board's archive file (`BOARD_CLOSED.md`, made at the first move), still with its ID and decision number.
6. **If a question was answered in a way that raises a new one,** the new one gets its own ID and the old one closes.
7. **Redo the six counts** in "At a glance" so they equal the lists, and write the date and time at the top.
8. **If something waiting on Tim blocks building and was not put to him today,** put it to him as one clickable question with context and a real-world example, in a batch of at most 12 (LOOPS 4).
9. **Update the stale document** the change touches in the same reply (RULES 9.7). Never leave a closed question open in its home file.
10. **Commit by file name and push** (the planning chat's usual rule; nothing else in `C:\CE_PLAN` is staged).

## 3. What every chat reports (the fixed three-line form)

Every side chat reports its open items to the planning chat in exactly this form, at the end of every piece of work and whenever asked. Three lines, no more:

1. **WAITING ON TIM:** each item with the file and ID where it is recorded, or "none".
2. **IN PROGRESS OR OWED:** what the chat is doing or has promised, with its own ID if it has one, or "none".
3. **PROBLEMS AND UNPROVEN:** faults it found and things it did not test, or "none".

The planning chat copies these onto the board the same wake-up, with the next IDs. A chat that has nothing sends the three lines saying "none" so silence is never mistaken for nothing open.

## 4. The nightly check

Run once each night (after 5:30 pm), by the planning chat or a Haiku helper (read-only counting, RULES model routing). Each check is a plain yes or no:

1. **Every ID referred to exists in its home.** For every D-, TA-, FM-, OC-, OQ-, TQ-, CX-, BK-, R-, P-, Q-, T- mentioned on the board, the number is defined in the home file named in the board's section 9. Any reference to an undefined number fails.
2. **Nothing waiting on Tim is older than three working days** without having been put to him again. The age is today less the date first raised. Any older item that has not been put to him in the last three working days fails.
3. **Every DRAFT has an owner.** Each DRAFT list (the DRAFTS files, `PERFORMANCE.md` limits, the names marked draft) names the chat that owns it and the W item it feeds. A DRAFT with no owner fails.
4. **The counts in "At a glance" match the lists.** Count the W, O, N, U and K lines and the "under way" pieces; they must equal the six numbers.
5. **No question is open in one file and closed in another.** Search the home files for each closed ID on the board's closed tail; any file still showing it open fails.
6. **No private list.** No chat has a list of things waiting on Tim outside the board (see section 6).
7. **The disk and the loops are alive.** Free space on C:, the build chat and the clean-up chat each heard from in the last day, and a night AutoCAD run recorded in `TREND.md` when it was due.

## 5. When a check fails

1. **It goes in section 10 of the board,** "CHECKS THIS BOARD FAILED TODAY", with the date, the check, and what is wrong in one line. The failure is not hidden and is not tidied away.
2. **It is fixed before new work.** The planning chat does not start anything new from the queue until the failed checks are fixed or, for something only Tim can settle, put to him as a waiting item with its ID.
3. **When fixed,** the line stays in section 10 marked "fixed" with the date, until the next revision, then moves to the archive file. A check that fails two nights running is put in the director's summary under Problems.

## 6. The rule for other chats

1. **No chat keeps a private list of things waiting on Tim.** Not in a chat, not in a file of its own, not in a brief. If a chat finds one, it copies the items to the board through the planning chat and deletes its own copy, saying so.
2. **No chat asks Tim a decision question in a work chat.** Decisions go in one batch through the planning chat's clickable questions (memory note "Questions go to the questions chat"), each with context, a recommendation and a real example.
3. **A chat that raises something mid-task** writes it into its report in the three-line form and carries on (RULES 7.3). It does not wait for an answer.
4. **A chat does not edit `BOARD.md`.** Two chats must not touch the same file (RULES 6.4). The planning chat owns it.
5. **A chat that is finishing says what it left untested** (RULES 14.5) so it lands in the unproven list.

## 7. What Tim sees

1. A clickable question, only when something waiting on him blocks building and has not been put to him that day.
2. A short progress answer that ends with the six counts and the director's summary page.
3. Nothing to file, sort, number or chase. If he ever has to, that is a fault in the board and goes in its section 10.
