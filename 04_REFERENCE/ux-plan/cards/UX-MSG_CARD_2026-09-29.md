# UX-MSG-01..03 - the CE bell (command/workflow card)

Status: behaviour built and tested, hidden behind a Settings switch (default OFF) until Codex accepts it in AutoCAD.
Classification: **Missing** (new build) (nothing existed; checked `git log --all --grep=UX-MSG` and the code).

## What Tim ruled (25-27 Sep 2026 rulings, "Where CE's quiet messages collect")
1. **UX-MSG-01, one place:** "CE bell on status bar". Small CE icon on the status bar with a count; click for a short
   list; each item has one action (Review, Open, Dismiss); nothing pops over the work.
2. **UX-MSG-02, what may interrupt:** ticked Failures, Colleague has DWG, Update ready (not New RFI). Only these show a
   small self-fading balloon near the status bar; everything else waits in the bell.
3. **UX-MSG-03, scope:** "The drawing/job". Drawing and job messages show to whoever opens the job next until someone
   reviews them; personal ones (update, save reminder) stay with the person.
Related: UX-VOICE-01 (calm, direct, plain, what and what to do, no blame), UX-FAIL-01 (failure window is what "Open" shows).

## What the drafter clicks and sees
1. With the switch off (default): nothing. No pane, no file, no balloon. Existing command-line lines stay as they are.
2. With the switch on: a small **CE** box on the status bar (next to the job timer). Nothing waiting: "CE". Things
   waiting: "CE 3". Hover: "3 things need a look. Click to see them."
3. Click it: the list window opens (Codex builds it, see contract below). Until that window exists, the click prints the
   waiting items on the command line, one plain line each.
4. A brand new Failure, Colleague-has-DWG or Update-ready message also shows one small balloon near the status bar that
   fades by itself (AutoCAD's own tray-notification time). Everything else only changes the count.
5. Same thing raised again (or by a colleague) is one item, not two. Something already reviewed/dismissed stays quiet
   unless its wording changed (then it returns as new).
6. Job messages are saved in the job folder (`CE_JobMessages.json`); personal ones in the person's own CE settings folder
   (`CE_Messages.json`). Saved at quiet moments: switching drawing, closing a drawing, closing AutoCAD; never while
   raising a message. Two colleagues saving at once are merged (latest change per item wins). Reviewed/dismissed items are
   forgotten after N days (Settings, default 30); waiting items never are.
7. Which message kinds may show a balloon is a Settings list (default = Tim's three). Everything is Settings-driven (R-00).

## Prompts, Escape, Undo, save/reopen
1. **Prompts:** none. The bell never asks a question and never stops a command. No hard blocks.
2. **Escape:** nothing to cancel; the bell is not modal.
3. **Undo:** the bell never touches the drawing, so it creates no Undo step. (Actions that a message offers, e.g. "Review",
   run their own command with its own one-Undo rule.)
4. **Save/reopen:** job messages persist in the job folder and appear for whoever opens the job next; personal ones return
   for that person only. An unreadable file means an empty bell (warning logged), never a crash. A drawing not in a job
   folder keeps only personal messages saved; job-type messages live for the session.
5. **Performance [PERF]:** raising a message is memory only (measured well under 5 ms for 200 posts, no disk). Disk writes
   happen only on drawing switch/close/shutdown. The status-bar handler only sets a text string.

## Window contract for Codex (no XAML written here)
The list window opens from `CeBellStatusBarService.BellClicked`. Data: `CeMessageService.Centre.OpenMessages()` (newest
first). Each row: plain line (`Text`), optional second line (`Detail`), one action button labelled `ActionLabel` (Review or
Open; hidden when empty) and a **Dismiss** link. Action button: `Centre.Activate(id, out command)` then run `command`.
Dismiss: `Centre.Dismiss(id)`. A "Dismiss all" link: `Centre.DismissAll()`. Re-read on `Centre.Changed`. Shows "Nothing
waiting" when empty. Same look as the one-page shell; no motion; symbol as well as colour for a Failure (UX-ACC-02).
Times shown in Melbourne time. The Settings page needs three controls under a "Messages" group: the on/off switch
(`Messages.Enabled`), the balloon list (`Messages.BalloonKinds`) and "forget handled items after N days"
(`Messages.ForgetHandledAfterDays`).

## Producers not wired yet (other builders own these files, so listed for later)
1. Failure reports: UX-FAIL-01 window ("Open") - `CeMessages.Failure(...)`.
2. Colleague has DWG: UX-SHARE-01 - `CeMessages.ColleagueHasDwg(...)`.
3. Update ready: Manager update flow - `CeMessages.UpdateReady(...)` (Manager module, separate).
4. FFL heads-up (UX-XDISC-03), new RFI, revised Xref (`CivilBackgroundXrefNoticeService` today prints a command-line line),
   foreign drawing review (UX-DWG-01), office wording changed (UX-SET-09), proposals ready (UX-L3-24), save reminder.
Each caller keeps its current command-line line as fallback when `Post` returns `BellOff`.

## Tests
1. Automated (39, `Core/Messages`): default off and Tim's three balloon kinds; quiet by default; only those three kinds
   balloon, list editable in Settings; de-duplication and re-raise on changed wording; Dismiss/Review; job messages follow
   the job until reviewed; personal never in the job file; colleague merge; forgetting handled items; unreadable/unsaveable
   file; speed; settings round trip; wording of the three ready-made messages.
2. Codex in AutoCAD (after the switch is turned on and the list window exists): see the steps in the regression log entry.
   Only a producer can raise a real message, so the balloon and job-follows-job steps need one wired producer first.

## Questions for Tim (each with a recommendation)
1. **Colleague has DWG - whose message?** Built as personal (it is true only right now, so it would be stale for the next
   person). The ruling text lists only update and save reminder as personal. Recommend personal.
2. **Save reminder** - how often, and after how long unsaved? Not built (needs a number; belongs in Settings).
3. **Failure wording** - built as "<command> did not finish. <what happened> Your drawing was not changed." Recommend keeping.
