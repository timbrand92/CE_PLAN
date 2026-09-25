# UX-LEARN-01 workflow card — CE decisions learn, from four sources, always with a shown reason

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Pass 2, batch 2,
and the learning principle — 25 Sep 2026, 13:57", UX-LEARN-01. **Tim, verbatim: "decision within the plugin
should have a machine learning element."** Asked where CE should learn from, Tim ticked all four: your own
habits, the whole office (via Manager), past CE projects (anonymised), and your corrections. Standing
limits carried over: every suggestion shows its reason; learning proposes and never silently changes an
engineering rule (master plan Part C §5); a learned default becomes a company default only when an
engineer promotes it (R-10 pattern); Unknown is never filled by a guess. Also logged as a build request in
`IDEAS_INBOX.md`, 25 Sep 13:57.

## 1. What works today, source by source — Keep / Missing, so this card builds on what exists rather than restating it

1. **Your own habits — partially built, currently a seed with nothing reading it back.**
   `Modules/Drainage/Services/SuggestionLedgerService.cs` ("FEATURE 10 SEED, 2026-07-02") already appends
   one compact JSON line per suggestion event to `%APPDATA%\CE_CVL_SUITE\ledger\suggestions.jsonl`
   (append-only, rotates at 5 MB, same shape as `LoggingService`'s own log file) for nine named features:
   `pipe_grade`, `pit_setup`, `cd_drawfirst`, `pipe_flow_sizing`, `run_solve`, `dashboard_fix`,
   `dashboard_fix_all`, `markup_analysis`, `markup_plan`. It already records **Shown / Used / Committed /
   Cancelled / Applied / ApplyFailed / RecoveryRequired** per event, through
   `CeSuggestionStrip.xaml.cs`/`PitSuggestionViewModel.cs` on the UI side. **Missing:** nothing today reads
   this ledger back to change what CE suggests next. It is exactly what its own header comment says it is —
   seed data for a learning loop that has not been built. The privacy rule is already hard-coded at the
   source, not a policy to add later: the header states events "NEVER carry a drawing path, client/project
   name, or AutoCAD entity handle," and `SuggestionLedgerValues` "only exposes numeric fields for exactly
   this reason." This card's "own habits" slice is genuinely additive — reading a ledger that already
   exists safely, not inventing new tracking.
2. **The whole office, via Manager — Missing, but a shared-distribution channel already exists to build on.**
   Nothing today aggregates suggestion data across users. What does exist:
   `Modules/Manager/Services/CeAdminStorageService.cs` already defines a shared root
   (`GetSharedPoliciesRoot()`) alongside a local per-machine one (`GetLocalPoliciesRoot()`), the same
   shared-folder-first, local-fallback pattern already used for the admin allow-list (see the
   `REPAIR-DECIDE-LATER` card) and for diagnostics/feedback (`CeDiagnosticsService`,
   `CeFeedbackInboxService`, both writing to a shared "IT Admin" folder). This is the natural channel for
   office-wide learned defaults to travel through — it is already how CE moves firm-wide, non-drawing data
   between machines. Building a second, unrelated sync mechanism would be new and unjustified complexity.
3. **Past CE projects, anonymised — a separate, existing, much larger system; not this card's job to
   rebuild.** `C:\CE_DrawingIntelligence\` (local only, never in a repository) and the EV-03 evidence model
   (`03_DRAWING_INTELLIGENCE\`) already exist for exactly this purpose, governed by the standing rule
   R-LEARN (`ENGINEERING_RULEBOOK.md`, 19 Sep 2026): *"every job worked on feeds the evidence... the
   anonymised rule or pattern in this repository... the identifying evidence in the local-only store."*
   R-LEARN's point 4 is the same DATA-01 line this card must also honour: *"Client names and addresses
   never enter a repository; the corpus grows on disk, the lessons grow in git."* This card's UX-facing
   scope is to make a CE window's suggestion able to **cite** an anonymised pattern already recorded through
   that existing pipeline, not to build a second evidence store.
4. **Your corrections — the same ledger as §1.1 already half-covers this.** `RecordDialogCancelled` and the
   `Cancelled`/`ApplyFailed` event types already capture "the drafter didn't take the suggestion," which is
   the raw signal a corrections feature needs. **Missing:** nothing today turns a rejected suggestion into
   "CE remembers and suggests their version next time," and nothing surfaces "how often it has been
   corrected" anywhere in the UI, as Tim's ruling asks for.

## 2. The full experience — today's state and the intended result

1. **Ribbon/trigger — not applicable.** Learning is not a command; it changes what an existing window
   already offers (a pre-filled value, a suggestion strip), not where a drafter goes to find it.
2. **Prompts — Keep, unchanged.** No new command-line prompt.
3. **Selection — Keep, unchanged.**
4. **Preview — Modify, everywhere a learned suggestion appears.** Today's existing suggestion strips
   (`CeSuggestionStrip`) already show a proposal; intended: every one of them gains the plain-English reason
   line Tim asked for — *"You usually pick 450 here"* is the literal example he gave — reusing the "shows
   why" pattern already required elsewhere (e.g. UX-WORD-02's "Suggestion only: not an office rule yet").
   No suggestion may appear with no stated reason.
5. **Drawing output — unchanged by this card on its own.** Learning changes what is proposed, never what is
   drawn without the drafter's own accept action — same rule as every other CE suggestion today.
6. **Cancel — Keep, unchanged**, and itself becomes a learning signal (§1.4).
7. **Escape — Keep, unchanged.**
8. **One Undo — unchanged.** A learned suggestion, once accepted, is drawn through whatever existing
   command already draws it (pipe grade, pit setup, etc.) and inherits that command's existing Undo
   behaviour; this card adds no new drawing-write path of its own.
9. **Save/reopen — Missing, new, for the "corrections" and "own habits" data specifically.** The ledger
   already persists per-user on disk across sessions (§1.1); nothing today persists a per-user "usual
   choice" derived from it, or an office-wide learned default derived from the whole-office aggregate.
10. **Where values come from — this is the crux of the ruling.** Every learned suggestion must say which of
    the four sources it came from and why, and must never be confused with a Settings/council value: a
    learned default is a suggestion until an engineer explicitly promotes it to an office rule (the R-10
    pattern already named in Tim's ruling), at which point it becomes an ordinary Settings value like any
    other (R-00) — not a silently-changing background process.

## 3. Example drawings

1. **DWG-A or DWG-B (Civil):** any job where the same drafter has previously accepted or overridden a pit
   size or pipe grade suggestion enough times for a pattern to exist, to prove the "own habits" slice
   surfaces the right pre-fill with the right reason text, and that declining it again is itself recorded as
   a further correction rather than silently ignored.

## 4. Automated guards vs Tim's AutoCAD checklist

1. **Automated:** a test proving the ledger reader never emits a drawing path, client/project name or
   entity handle even when fed a synthetic events file crafted to try to leak one (defence in depth on top
   of the existing write-side guarantee); a test proving a suggestion with no reason text fails to build /
   fails a lint-style check, so "always shows why" cannot silently regress; a test proving a learned default
   never writes to Settings on its own — only an explicit "promote to office rule" action does.
2. **Tim's AutoCAD checklist (DWG-A or DWG-B):** repeat the same pit-size choice several times across a
   session (or several sessions, per whatever slice 1 below actually ships). **Right result:** the pit
   window starts pre-filling that size, with a plain-English reason shown. Decline it once. **Right result:**
   CE does not nag on the very next pit, and the decline itself is recorded, visible in whatever "corrected
   N times" indicator slice 3 below adds.

## 5. Slices — smallest first

1. **Slice 1 — own habits, read-only suggestion.** Read `SuggestionLedgerService`'s existing local ledger
   for one already-instrumented feature (recommend `pit_setup`, since `PitSuggestionViewModel` already
   exists) and pre-fill/propose based on the drafter's own past accepted choices, with the reason shown.
   No office sharing, no evidence-model citation, no promotion path yet — proves the read-back loop end to
   end on the smallest existing surface.
2. **Slice 2 — corrections close the loop.** A declined/overridden suggestion changes what is proposed next
   time for that same drafter, and a visible "corrected N times" indicator appears per Tim's ruling.
3. **Slice 3 — whole office, via the existing shared-folder pattern.** Aggregate the same ledger data
   through `CeAdminStorageService`'s existing shared root, so a new colleague's first pit sees the office's
   already-common choice rather than nothing; still with a shown reason distinguishing "your own habit" from
   "the office's usual choice."
4. **Slice 4 — promote a learned default to an office rule.** The explicit engineer action (R-10 pattern)
   that turns a learned suggestion into an ordinary Settings value, closing the loop Tim's ruling opened with
   "an engineer promotes it."
5. **Slice 5 — cite past CE projects.** Only once slices 1–4 are proven, connect a suggestion's reason line
   to an anonymised pattern already recorded through the existing EV-03/R-LEARN pipeline, rather than
   building any new corpus mechanism.

## 6. OPEN questions, each with a recommended answer

1. **OPEN 1 — which feature ships first in slice 1: `pit_setup`, `pipe_grade`, or something else Tim uses
   more often?** *Recommended: `pit_setup` — it already has a dedicated view model
   (`PitSuggestionViewModel`) and a ledger feature id (`pit_setup`), the smallest possible surface to prove
   the loop.*
2. **OPEN 2 — how many repeats of the same choice justify calling it "your habit" and pre-filling it (a
   threshold), and should that threshold itself be a Settings value or a fixed constant?** *Recommended: a
   Settings value with a sensible built-in default, consistent with R-00 ("nothing should be hardcoded"),
   rather than a fixed number buried in code.*
3. **OPEN 3 — for "the whole office," does a new colleague's very first session already see office-learned
   suggestions, or only once they've made a few choices of their own?** *Recommended: yes, from the first
   session — that is explicitly the example Tim gave ("a new colleague gets the office's usual choice
   first") in the fuller wording recorded in `areas/windows-and-ribbon.md`'s UX plan summary.*
4. **OPEN 4 — what does "shows how often it has been corrected" look like in the window: a number, a small
   history, both?** *Recommended: a simple count next to the suggestion (e.g. "corrected 3 times"), not a
   full history list — keeps the window calm per the standing cockpit/no-clutter rule, and a full history is
   always available in the underlying ledger file for support/diagnostics if ever needed.*
