# Independent review of the trust plan (Thu 12 Nov 2026, late evening)

**What this is:** a fresh reviewer was told to find the holes in `areas\trust-plan.md`, the cards and the supporting documents, not to praise them. It checked three code claims itself; the rest is from reading. This file records its ten worst holes and what the controller (chat CE_ACAD / trust plan / plan / 01) is doing about each. Nothing here is a decision by Tim.

---

# FOR TIM

**The reviewer found ten real holes. Four of them meant a test could pass while colleagues still saw faults. Each has a fix below; the ones that need your word are in the question queue.**

## The ten holes, worst first, and the action

1. **A wrong proposal was never marked wrong.** On an old job everything CE reads is "Proposed". The pass rule only failed values shown as fact, so an old job could pass with wrong proposals, and one tick would make them facts.
   - **Action:** the test set gets a fifth mark, "Proposed, wrong value", which fails the job. Sizes, levels and pit numbers cannot be ticked all at once. (Tick-all for links only is a question for Tim.)
2. **The right answers were going to be copied from CE's own old schedules.** Any "100 dia UPVC" CE made up last year would have become the truth.
   - **Action:** answer sheets come from the labels on the issued plan or a marked-up print, never from the schedule. A stored value with no note of where it came from reads as "stored, source unknown", not Sure. (Question for Tim.)
3. **Step 1 is bigger than its card says.** The existing check only looks inside CE's own record. It cannot see pits or pipe lines that are drawn but not recorded, and an old job with no record may get no line at all.
   - **Action:** the step 1 builder has been told to add a read-only scan of what is drawn. Step 1's risk goes from LOW to LOW-MEDIUM.
4. **The before-and-after check needs a reader that was not due until step 8.**
   - **Action:** a step 0 is added to the plan: test jobs picked, answer sheets confirmed, and the read-only reader running, before step 1 is trialled.
5. **An older CE version can quietly undo the core's work.** A colleague still on the old version opens a drawing the core has touched, and the old hidden update puts "100" back where the core wrote Unknown.
   - **Action:** a new test job, "a core-touched drawing opened on the previous version". Whether the whole office moves on one day is a question for Tim.
6. **"Copy Tim's settings to everyone" clashes with "no switched-off feature comes on".** Tim's PC may have trial switches on. And Tim's own trial of step 3 cannot fail, because his PC is never overwritten.
   - **Action:** before step 3 is approved, Tim's values are compared with the colleague starting values and the differences listed. Step 3 is trialled on a colleague-style login, not only on Tim's.
7. **Three ways back were not real.** The "old tabs" switch brings back an older three-tab layout, not today's. Step 6 named a backup that does not exist. Step 7 and one answer option promised "one U undoes it" before that has been tested.
   - **Action:** the ribbon builder has been told to keep today's layout as the default behind a new switch. Every "one U" promise is reworded to "once the Undo test proves it". Step 6 says plainly: values already written are not put back.
8. **The start point card contradicted Tim's answer.** He chose the LPD itself as one stored thing; the card still proposed a pit and added a third stored record. Pressing Esc there would also have stopped the Pit Schedule.
   - **Action:** card TRUST-07 is to be rewritten around confirming the LPD's position, with Esc carrying on in today's order with a warning line. Marked on the card.
9. **The trials add up to far more of Tim's time than he agreed.** About ten three-day trials, not six, and the checklist asked for three days per tool.
   - **Action:** question for Tim, with the recommendation that his own trials are kept for steps 4, 6 and 8, and the robot and Codex accept the rest.
10. **The release gate rested on five trust rules Tim has not approved,** and the checklist let a failing tool stay on.
    - **Action:** question for Tim: approve the five rules, and any exception is named and signed by him.

## Also corrected in the plan

1. **Voice-talk items were listed as "decided".** The two tabs, the testing order and "first release waits for Check this drawing" are agreed direction from the 6 Nov voice talk, not quoted rulings. The plan header now says so.
2. **Stale lines** saying "no answers yet" and "open" for things Tim answered on 12 Nov.
3. **Real-job cases no card covered,** now listed in the plan as cases every card must answer: a read-only drawing; Save As and pits copied between jobs; units not set; drainage inside an attached drawing; paper space; a colleague typing a hidden command; a drawing touched by another version; exploded or mirrored CE blocks; one job split over several drawings.
4. **Proof that could pass while broken:** the test set only checked reading, never the result after an edit; the same jobs both taught and tested the reader; "the button sent its command" does not prove the command worked; "Apply then U" never compared the linework. Each is added to the proof lists as the cards are revised.
5. **Privacy:** the old-drawing listing, logs and screenshots stay on the PC, never in a repository.
6. **Writing:** the reviewer found software words in the parts written for Tim ("hidden sync", "probe", "slice", "broken twin", "unit-blind"). They are being replaced as each file is next revised.

## What the reviewer did not check

1. Only three code claims: the old-tabs switch, what the drawing check contains, and where CDCHECKCURRENT leads.
2. Structural and Manager code.
3. Nothing was run; no drawing was opened.
