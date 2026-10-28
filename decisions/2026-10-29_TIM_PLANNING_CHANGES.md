# Tim's planning changes, 29 Oct 2026 (carpark and planning intake chat)

Words in quotes are Tim's. "Interpretation" lines are the intake chat's guess and are not decisions.

## PC-01 — Settings for the automatic grade and level working

Tim: "in the cd window or cdedit window it automatically gives you a grade say i put 19.45 in for one invert it automatically gives me the closest to 1 in 100 downstream. the issue i have is there needs to be settings for this, like what is the automatic number do you set it on your own does it update the engineering invert level or is it just for the presentation?"

Facts read from the code (commit 09126560, Civil 3.0.85, not seen in AutoCAD): the worked-out end is a real level written to the pipe record, not presentation only; the fall is length / grade rounded UP to the next 10 mm (ignores the "calculated decimals" setting); minimum drop 20 mm is in Settings; no box controls the round-up. Related: AUDIT_ENGINEERING_CIVIL_2026-10-22.md, R00_CIVIL item 14.
Interpretation (guess): Tim wants every number in this working on the Settings page (R-00), and the window to say plainly whether a level is real or display only. Not yet agreed with Tim what the Settings should be.

## PC-02 — "I know one end - work the other out from the grade" to be built into the whole system

Tim: "the i know one end - work out from the other grade could be implemented far better into the whole system do you get what i mean?"

Interpretation (guess, NOT confirmed): today the option is a tick in the CD and CDEDIT windows only; Tim may want the same working wherever a level is set or a pit or pipe moves (pit move, Pit Schedule, CDPROPAGATE, long section). Question open with Tim: where does he want it to work that it does not now.

## PC-02 update (Tim, 29 Oct, later) — replaces the interpretation above

Tim: "what i meant was theres that button but then theres also the pipe grade above so it feels likes theres two points of contact and as an end suer what do you use if youve never used the program before, surely thsi can eb designed for better end user experience"

Meaning (Tim's own words, little to interpret): in the CD and CDEDIT windows the "I know one end - work the other out from the grade" button and the "Pipe grade" row both control how the levels and grade are worked out, so a new user does not know which one to use. Wants it designed better for a first-time user. The earlier guess (wire it into pit move, Pit Schedule and so on) is NOT what he meant; it is withdrawn.
Process: this is a user-facing workflow change, so it goes through the command and workflow review gate (AGENTS.md): a review with Tim, a card, his approval, before any code.

## PC-03 — Review the whole CD / CDEDIT preview and grade-and-level working before it is formally a bug

Tim: "with bug 1230 - we need to look into this entire fucntionality more overall before formally putting it in, how does it work in all situations and how it looks and feels for end user"

Meaning: BUG-1230 is held (kept as evidence, not fixed on its own). Wanted: one review of how the plan preview, the grade box, the "I know one end" choice and the worked-out levels behave in every situation (new pipe, edit pipe, upstream or downstream known, custom grade, standard grade, flat, existing levels) and how it looks and feels, together with PC-02. Not a fix yet. Interpretation (guess): this becomes one workflow card for the review gate, with BUG-1229 and BUG-1230 attached.

## PC-03 update (Tim, 29 Oct, later)

Tim on the proposed BUG-1230 wording: "yoru understanding is perfect lets get this as ready to go whenever possible". BUG-1230 now carries the agreed wording. Interpretation (guess): get the whole-functionality review and its workflow card (PC-02 + PC-03, with BUG-1229 and BUG-1230) ready for the review gate as soon as possible, so it can be built when approved. No code change is authorised by this line. Desk chat to schedule the review with Tim.

## PC-04 — Council RFI letters: ingest and handle them (extends UX-RFI-01..03)

Tim: "need to be able to ingest and handle rfis from council, here is example how and what can we do with this?" (three City of Kingston RFI letters attached; PDFs stay in Tim's Downloads, they name client addresses and are not copied into any repo).

Already ruled (25 Sep, UX-RFI-01..03): CE finds the RFI PDF in the job folder, lists every item as a to-do in a Council RFI tab in Project Review, checks what it can against the drawing (Met / Not met / Can't tell, Show where), learns what councils keep asking, no response-letter drafting.

What the three letters add (anonymised; counted by the intake chat from the PDFs):
1. **Standard wording on the notes (about half of the asks):** a Kingston notes library CE can check against the drawing's notes and offer to insert before submission. Contact phone numbers differ between letters (two different Assets Engineer numbers), so they must come from council data in Settings and be flagged to verify, never hard-coded.
2. **Checks from CE's own numbers:** permit discharge limit versus the calculated flow (7.7 versus 8.21 L/s in one letter), drawn orifice versus calculated orifice (90 mm versus 58 mm), roof area per tank (council minimum 50 m2), charged pipes under a dwelling (150 mm UPVC minimum in one letter), cover versus pipe class.
3. **Details to add:** retaining wall section, concrete driveway paving section. Detail work for the drafter, listed as to-dos.
4. **Human decisions, CE only lists them:** who maintains a shared drainage system (owners corporation, s173 agreement, easement), whether to split the system per unit.
5. **Letter housekeeping:** 90-day deadline before the application is closed (CE can count it down), the application reference number, the subject address and a covering letter with bubbled changes on the plans.

Interpretation (guess, not a ruling): the cheapest first step is a pre-submission Kingston checklist built from these asks (so the RFI never comes), then the RFI reader. Both need a workflow card and Tim's approval before code. Open question for Tim: the 25 Sep ruling says no response-letter drafting, but Kingston wants a covering letter listing the changes; does Tim want a plain change list produced from the to-do tick-offs?
Related: BUG-538 (Kingston rules written into the code); the Kingston council rules in 02_COUNCIL_RULES should be checked for the 50 m2 per tank rule.

## PC-04 update (Tim, 29 Oct, later) — checklist, other councils, learning

Tim: "we have lots of rfis and from other councils, the checklist sounds good, automation is key and also machine learning to know what to add for next time would be great"

Meaning (Tim's words, little to interpret):
1. There are many more RFI letters, from other councils too, not only Kingston. They are the source material.
2. The pre-submission checklist (PC-04 item "cheapest first step") "sounds good": Tim likes it. Interpretation (guess): approval in principle only; it still needs a workflow card and Tim's approval before any code.
3. "Automation is key": the checklist and the RFI to-dos should be ticked and filled by CE itself wherever it can, not by the drafter by hand.
4. Learning: CE should learn from past RFIs what each council keeps asking, so the next job's checklist already contains it. This is the same learning ruled on 25 Sep as UX-LEARN-01 and in UX-RFI (what councils keep asking feeds council rules and checklists); it is a Tim-confirmed use of it, not a new rule. Existing safeguards still apply: every suggestion shows why, nothing changes an engineering rule silently, the engineer promotes a learned default.
5. Privacy (DATA-01): the RFI letters name clients and addresses. They are read for evidence only when Tim names the folder; the anonymised lesson goes to the repo, the letters stay local-only.
Open question for Tim: where do the other councils' RFIs live (job folders, an email folder, one drawer)? Not guessed.

## PC-04 update 2 (Tim, 29 Oct) — where the RFIs live (read from the drive, counts only)

Tim: "check in job folders". The intake chat looked at the office project folders (read-only, counted files by folder name only; no job names, client names or addresses read or recorded). Office folder: C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects, years 2020 to 2026, 1,979 job folders.

1. **Council letters sit in the job's Civil folder, in folders with no fixed name.** Counted across all years (jobs that have files in the folder / PDF files): "Council Feedback" 71 jobs / 58 PDFs; "From Council" 47 jobs / 55 PDFs (plus one job with the misspelling "From Coucil", 3 PDFs); "Council Coordination" 6 jobs / 9 PDFs; one job has a folder named by date and "Council RFI". So roughly 125 jobs have council letters in a council-named folder. Not every file in them is an RFI (they also hold approvals and other letters): not yet checked.
2. **"LPD & OSD" (282 jobs, 418 PDFs)** holds legal point of discharge and on-site detention papers, some of them council replies; it is not an RFI folder as such.
3. **The job's own "RFI's" folder is NOT the council drainage RFIs.** It exists in about 1,900 jobs but has files in only about 130 (2020 to 2026), and is the general queries folder. Its contents were not opened.
4. **Letters are PDFs with a 7-digit file name** (the three Kingston samples are 4067823, 4095355, 4095421): the file name carries no council or job, so CE must read the letter text (council name, application number DCA-year/number, address) to place it.
5. A 2024 and a 2025 file search in Civil (depth 3) found only 45 files whose name says RFI, request for information or council comment, so most councils' letters are NOT named RFI. CE must recognise a council RFI by its content and folder, not by its file name.

Interpretation (guess, not a ruling): the learning pool is the Civil council folders above (about 125 jobs), read one anonymised lesson at a time; Tim names the folders or years before any is opened (DATA-01). Nothing was copied or opened beyond counting.

## PC-04 update 3 (Tim, 29 Oct) — first read of the council folders (counts only)

Tim: "yes" to reading "Council Feedback" for 2025 and 2026. Result, read-only, nothing copied, no names recorded:
1. **"Council Feedback" holds almost nothing in 2025 and 2026** (2025: 1 job, 0 PDFs; 2026: 0). The recent jobs use **"From Council"** instead (2024: 18 jobs, 16 PDFs; 2025: 13 jobs, 15 PDFs; 2026: none yet). The folder name changed over time, so CE cannot rely on a fixed folder name.
2. **Read the first three pages of the 15 PDFs in 2025 "From Council":** 8 look like RFIs (asking for more information), 3 approvals or permits, 4 other (2 had no readable text, probably scanned). Classified by wording only, not by a person: treat 8 of 15 as approximate.
3. **Councils could not be counted yet.** The simple text search picked up junk, so this chat does not claim any per-council figure. Needs a proper pass (council name from the letter head and the application-number pattern).
4. **The 2026 jobs have no council folder files at all**, so recent letters (for example the three Kingston samples, kept in Tim's Downloads) are not yet filed in the job folders. Not checked where else they arrive (email?).
Interpretation (guess): enough RFI letters exist (roughly 8 per year per folder pattern, plus the older years' "Council Feedback" and "From Council" folders) to learn from. Next step, if Tim wants it, is a proper read of all years by a builder with an anonymising output (council, request type, wording only).

## PC-04 update 4 (Tim, 29 Oct)

Tim: "looks like its from council"
Interpretation (guess, the intake chat read it as an answer to "where do the RFIs live"): the council RFIs are in the job's "From Council" folder (Civil\From Council), the folder used by recent jobs; "Council Feedback" is the older name. CE should look in both, plus any date-named council RFI folder. Not yet answered: the full all-years read (the question is still with Tim) and where letters arrive before they are filed (the 2026 jobs have none filed).
