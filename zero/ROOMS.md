# The rooms: who does what, and how work flows (CE_ACAD, from 20 Nov 2026)

**Why this page exists.** Tim, 20 Nov 2026: "can you create a plan on how many sessions/side sessions work with you as the control room, then maybe add one for tim interviews and general chat so we dont waste your context. ideally i want to just keep getting interviewed on the plan and how things work so you dont have any unknowns at all. i want to get this right, how will we do so. also in that chat we need something research and thinking outside the box to fix bugs, improve speed of build and testing, improve functionality, improve simplicitiy for end user and anything else". Recorded as D-353. The control room keeps this page.

## 0. REVISED 20 Nov 2026, 11:05 am: FIVE ROOMS (Tim: "i asked for you to plan out all the side sessions including new ones or logical ones to help you keep on top all the different areas of the building, testing and whatever else and archive what you no longer need making sure everything is saved")

Section 1 below named three rooms. The build room was carrying building, checking and AutoCAD testing at once, and things sat unchecked and unseen. Two rooms are split out of it, so each area has one owner:

1. **CONTROL ROOM** (this chat): the plan, the board, decisions, order of work, what Tim is told.
2. **TIM'S ROOM** ("CE_ACAD / Tim / interview and ideas"): interviews him down `UNKNOWNS.md`, his general chat, research and fresh thinking. Writes `interview\ANSWERS_TIM.md`.
3. **BUILD ROOM** ("CE_ACAD / zero build / 01"): builders only (Codex lanes and Team builders), tests first, and the merge to the main line once the check room says MERGE. It no longer checks its own work.
4. **CHECK ROOM** (new, "CE_ACAD / check / 01"): the gate. Every finished branch gets its independent check here (D-346): an honest check of the acceptance list and one adversarial pass, blockers only, verdict MERGE or HOLD with a plain list. It also checks every mock-up against the 31 screen rules before Tim sees it, and keeps the follow-up list of non-blockers per part. It never builds or fixes.
5. **AUTOCAD TEST ROOM** (new, "CE_ACAD / acad test / 01"): owns everything that runs in a test AutoCAD at night on test copies: the safe runner, the test drawings made from the office master, the pictures taken inside AutoCAD after each command, the owed-in-AutoCAD lists, and the nightly report with pictures. It is the only room that may start a test AutoCAD, under rule 1.9 in full. It takes over from the build room after shadowing one night.

**How a piece of work moves:** Tim's room (his words) → control room (decision, order) → build room (tests first, build) → check room (MERGE or HOLD) → build room merges → AutoCAD test room (pictures and proof in AutoCAD) → control room looks at the pictures → Tim's own hands.

**Closed, with where their work is saved:**
1. **Trials chat** ("CE_ACAD / zero plan / trials 01"): retired 19 Nov. Its findings are in `reference\research\R-011` and `R-012` and the board; its trial code is on disk at `C:\CE_WORK\trials\zero` (not in a repository). The chat is left closed, not archived, because it shares this chat's working folder.
2. **Tools interview chat** ("Interview Tim: Tools, Manager and shared structural commands"): paused with the tools (P-09). All 141 answers pushed (`interview_tools\`, last commit db74320b).
3. **Old desk robot's hourly chats** ("CE desk hourly check", "CE holiday run watchdog"): about 40 idle chats made by two old hourly scheduled jobs from 30 Sep that are still firing. They belong to the old plan. Asked of Tim on 20 Nov whether to switch the two jobs off and archive the chats.
4. **TimOS chat:** a separate project; not this plan's to close.

## 1. The rooms (three live chats, no more) (superseded by section 0: now five)

1. **CONTROL ROOM** (this chat, "CE_ACAD / zero plan / 01"). Keeps the plan, the scope page, the board, the board file his bar reads, and the decisions record. Checks every result before it counts. Hands out work in order. Gives Tim the director's summary. Tim comes here for "how are we going" and for rulings that cannot wait. It does not interview at length and it writes no code.
2. **TIM'S ROOM** (new, "CE_ACAD / Tim / interview and ideas"). Where Tim spends his time. Two jobs:
   1. **Interview.** Works down the list of unknowns (`UNKNOWNS.md`) with him: how he drafts, what each tool must do in each real situation, what he expects to see. One subject at a time, through the question window, each question with its context and a real job example, a mock-up first where a screen is involved. Also his general chat: anything he wants to talk through.
   2. **Research and fresh thinking.** Looks outside the box at four things and brings back short, checked pages: fixing whole classes of bugs; making building and testing faster; better function; a simpler tool for the drafter. It may use research helpers on the Team account and Codex. It proposes; it never changes the plan or the code.
3. **BUILD ROOM** (existing, "CE_ACAD / zero build / 01"). The only place code changes. Runs the Codex lanes and the Team builders and checkers, the AutoCAD night tests on test copies, and merges to the main line under the gate (D-346).

**Not rooms:** Codex jobs and Team helpers are hands the build room and Tim's room use; they have no say. **Closed or paused:** the trials chat (retired 19 Nov); the tools interview chat (paused with the tools, carpark P-09; its work folds into Tim's room when tools return). **Separate project:** the TimOS chat.

## 2. How work flows (one direction, so nothing is decided twice)

1. **Tim's room asks; Tim answers.** His words are written at once, in quotes, to `interview\ANSWERS_TIM.md` with a number of its own (TR-001 onward) and the unknown it closes. Tim's room never edits `DECISIONS.md`, the scope page, the board or any code.
2. **Tim's room tells the control room** in one short note: the TR numbers, what they change.
3. **The control room files them** as decisions (D-numbers), resolves any clash with an earlier ruling by asking Tim once, updates the scope and the Stage 1 page, and passes what the build room needs.
4. **The build room builds,** tests first, and reports merges and holds.
5. **The control room checks,** moves the board file, and tells Tim in the two R-72 lines.
6. **Research pages** go to `reference\research\` and one line each to `IDEAS.md`; the control room decides with Tim what is taken up and when. An idea outside the stage in hand goes to the carpark, not to the builders.

## 3. How we get it right (the standing method)

1. **No unknowns by design.** `UNKNOWNS.md` lists every question not yet answered, by part of the release. Its count is shown: "N of M closed". A part is not built past its unknowns; where the build must not wait, the control room makes a draft call, marked as such, and it goes on the list for Tim to confirm.
2. **Walk the real job first.** Before a tool is built or rebuilt, Tim's room walks him through the situations a drafter meets with it, start to finish, and writes them as a numbered list. That list becomes the tests.
3. **Picture before build.** A screen is drawn and checked by something that did not draw it, then shown to Tim, before it is built.
4. **Seen in AutoCAD, not on the bench.** A thing counts only when pictures from inside AutoCAD show it, and then when Tim has done it with his own hands (`stage6\STAGE1_TIMS_EYES.md`).
5. **Design before patch.** A fault that survives two fixes gets a one-page design first (D-346).
6. **One stage at a time.** Stage 1, Pit and Pipe, before anything else (D-347). Everything else waits in the carpark and is read back to him.
7. **Honest counts.** Built, checked, installed, accepted: four facts, from one file, at the top of every reply (R-72).

## 4. Rules every room keeps

Tim's rules in `C:\TimOS\RULES.md` and `C:\CE_PLAN\zero\RULES.md`; rule 1.9 on AutoCAD's profile and licence in full; no client names, job addresses or job numbers anywhere; no AutoCAD in Tim's hours and never his own; answer first, plain words, FOR TIM above a line, numbered lists with bold labels, no tables, ending Completed / Not completed / Next; questions through the question window, at most four at a time, never opened when he has been quiet for half an hour; the clock is read before any time is written.
