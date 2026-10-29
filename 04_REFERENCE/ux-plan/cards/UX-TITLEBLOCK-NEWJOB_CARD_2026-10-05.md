# UX-TITLEBLOCK-NEWJOB — a new job asks which title block (DRAFT card, 5 Oct 2026)

**Status: DRAFT, not approved.** Written by build/02 run 75 from Tim's ruling. Nothing built from it yet.

**Authority:** Tim, 5 Oct 2026 (INT-059 item 12, `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`): "both options are
needed". There is NO single default: a new job asks which title block (A1 horizontal or A3 classic) at creation; old jobs
keep theirs. Background: `04_REFERENCE\structural\JOBS_PROCESS_STUDY_2026-10-04.md` section 2.6 (3 of 6 jobs each).

## 1. What happens today (installed Structural 1.0.101)

1. The Structural job set-up window lists 10 built-in templates (A1 vertical and horizontal title and blank sheets,
   Structural and Civil; four A3 templates) and **quietly pre-selects the first one, A1 Structural Title Sheet -
   Vertical** (`CeProjectSetupDialog.xaml.cs`, `SelectedIndex = 0`). A drafter who presses Create without looking gets
   A1 vertical, which is neither of the two title blocks in use.
2. The engine (`CeProjectSetupService`) already needs an explicit template: it does not choose one itself.

## 2. What Tim wants

1. **New job:** the set-up window shows the two choices side by side, A1 horizontal (plotted reduced to A3, with the
   revision table) and A3 classic, with **nothing pre-selected**. Create stays unavailable until one is picked; a one-line
   hint says "Pick the title block for this job".
2. **Old jobs keep theirs:** set-up on a job that already has sheets never offers a change and never rewrites a title
   block. Nothing here touches an existing drawing.
3. **No silent default anywhere** (R-00): no Settings value picks one for the drafter.

## 3. Build (smallest slice)

1. **Window (any builder; ownership split removed, Tim, 29 Oct 2026):** remove the pre-selection; show the two choices first, the other templates under
   "More templates"; Create disabled until a choice. This is the whole change.
2. **Engine:** none needed. The engine already refuses to create without a template. Optional guard test: set-up with no
   template chosen creates nothing.
3. **Switch:** Settings `CeProjectSetup.AskTitleBlockAtCreation`, OFF until Tim accepts the window; OFF = today.

## 4. Questions for Tim (via the desk, not decided here)

1. The other templates (A1 vertical, Civil A1, basement A3 and the client-specific A3 sets): still offered under
   "More templates", or hidden? Recommended: still offered, below the two.
2. When a job has both kinds already (a mixed old job), set-up shows what it found and changes nothing. Agreed?

## 5. AutoCAD checks (after the window, on copies)

1. New job: nothing pre-selected; Create is greyed until A1 horizontal or A3 classic is picked; the job is made with that
   title block.
2. Existing job: set-up offers no title block change; its drawings are unchanged (compare file dates).
3. Cancel creates nothing.
