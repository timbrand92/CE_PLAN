# Structural: 6 questions for Tim (4 Oct 2026)

**From:** team build worker 02 (runs 70-73). Checked first, not answered anywhere: `areas/structural.md`,
`04_REFERENCE/structural/cards/README.md` (open questions 6-8), `STRUC-REGISTER-ISSUE_CARD_2026-09-26.md`
(open question 4) and the Opus reviews on PRs #700 and #702.
**For the desk:** ask 1 and 2 first (they hold up two built PRs). Record Tim's words in quotes, dated.
Everything below is built switched OFF or not built at all; nothing reaches a drawing until Tim answers.

---

1. **Issuing the same revision twice on the same day: what happens to the saved copy of the drawings? (PR #700)**
   - **Context:** at Issue, CE can save a locked copy of the drawings beside the PDFs, so the next issue can
     cloud what changed. If you issue Rev B, fix a typo, and issue Rev B again the same day, it lands in the
     same folder. Today the old drawing copies stay and the new PDFs go beside them: they no longer match.
   - **Recommended:** replace the earlier copy. One folder, one issue, and it always matches its PDFs.
   - **On a job:** "Replace": the folder `2026-10-04 STR Rev B` holds only the second (corrected) set.
     "Dated sub-folder": it holds `14-05` and `16-40` sub-folders, both sets kept, clouds compare to the latest.

2. **The one joined PDF: in what order do the sheets go? (PR #702)**
   - **Context:** you ruled 25 Sep "One PDF, register order". CE currently sorts by sheet number. The Sheets
     window lists sheets in layout-tab order (a duplicated sheet goes in after the one you picked). These differ
     when the tabs are not in number order.
   - **Recommended:** sheet number, as built. It is what the drawing register prints, whatever the tab order is.
   - **On a job:** tabs run S001 cover, S100 notes, S010 footing plan. "Sheet number": S001, S010, S100.
     "Sheets window order": cover, notes, footing plan, exactly as the tabs sit.

3. **Markup QA: what counts as "the same item" from one markup round to the next?**
   - **Context:** when the engineer marks up Rev B, CE wants to tag which Rev A comments are now replaced.
   - **Recommended:** same place on the sheet plus the same meaning in the words. Anything unsure becomes a new
     item; CE never guesses that an old comment is replaced.
   - **On a job:** Rev A says "B1 250PFC" at grid C/3; Rev B says "B1 to 300PFC" at C/3: tagged "replaces".
     A note 2 m away saying "check B1" is a new item, not a replacement.

4. **Markup QA: when CE lists what the engineer changed, what does it compare against?**
   - **Context:** after the engineer drafts changes themselves, CE lists them for the drafter. It needs a "before".
   - **Recommended:** CE's own last saved snapshot; if there is none, the last issued revision. CE says which.
   - **On a job:** issued Rev A Monday, snapshot Wednesday, engineer edits Thursday: the list shows only
     Thursday's edits ("compared with Wednesday's snapshot"). No snapshot: everything since Rev A.

5. **Markup QA: may a marked-up page be sent to Claude to read under your 25 Sep permission?**
   - **Context:** the corpus privacy block (DATA-01) stops old jobs being sent anywhere. This is a different
     thing: today's markup page, title block blanked, read once, never used for training.
   - **Recommended:** yes, the corpus block does not cover this; the title-block rule you set 25 Sep still applies.
   - **On a job:** "yes": CE reads the red pen on the PDF and lists 12 items for you to tick. "No": you tag all
     12 by hand, CE only keeps the list.

6. **Issue check: what counts as a "differently set up" sheet? (register slice 8)**
   - **Context:** at Issue, CE checks every sheet against the office plot style, page setup and pens, and warns
     (never blocks) when one differs.
   - **Recommended:** warn on any difference from the named office standard, however small. It is a warning,
     so the issue still goes; it just names the sheet.
   - **On a job:** S105 uses `CE-mono-copy.ctb` with the same pens as `CE-mono.ctb`. "Any difference": warned.
     "Only if the print would look different": not warned; only a sheet plotting at the wrong pen width is.
