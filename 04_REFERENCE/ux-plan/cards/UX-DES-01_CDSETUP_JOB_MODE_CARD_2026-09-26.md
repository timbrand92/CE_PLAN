# Design / CDSETUP workflow card — job mode at setup

**Built, not yet AutoCAD-tested (28 Sep 2026).** Not installed, not Tim-accepted.
Authority: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` UX-DES-01..03 and UX-MODE-01..04.
This card records the Design/CDSETUP workflow that previously lived only in `../V3_UX_PLAN.md`.

**28 Sep 2026 build note:** the core of this card is built in `Modules/Drainage` (CE_ACAD_PLUGIN, branch
`claude/ux-des-01-cddesign-job-mode`) — `CivilJobMode` replaces the old Engineer/Draftsperson route in
`CivilDesignWorkflow`/`CivilDesignState`/the CDDESIGN window, the setup suggestion reads the job folder for a
markup or supplied design (`SuppliedDesignLookupService`), a "Confirm setup" button returns to drafting in
From-markup mode, and CE offers to switch a Design-from-scratch job when a markup later appears
(`LateMarkupOfferRule`). **Deferred, flagged honestly in the PR:** the "Not in markup" quiet chip (the pure
comparison rule `NotInMarkupChecker` is built and tested, but it is not yet wired to real drawn items or to a
window); the "differs from supplied design" conflict marking (no structured supplied-design figures are read
yet — only that a file exists); the late-markup QA comparison list beyond the mode switch itself; and any CE
ribbon/panel indicator of the current mode outside the CDDESIGN window. None of this has been driven in
AutoCAD — see the PR and `REGRESSION_LOG.md` for exact build/test evidence.

## Tim's ruling and supersession

1. **UX-MODE-01:** Tim asked, *"what if engineer drafts their own job"* and *"well if youre drafting
   from a markup, its different to drafting from scratch with no set design"*. He chose *"Yes, per job,
   CE suggests it (Recommended)"*. The old Engineer/Draftsperson person role (UI-03) is superseded.
2. **UX-DES-01, refined by UX-MODE-01:** The earlier draftsperson `Confirm setup` route now belongs to
   **From markup / supplied design** job mode; confirming setup closes Design and returns to drafting.
3. **UX-MODE-02:** Tim chose *"Allow it, list as \"Not in markup\" (Recommended)"*.
4. **UX-MODE-03:** Tim chose *"CE offers to switch (Recommended)"* when a markup arrives later.
5. **UX-MODE-04:** Tim said *"Everything, as suggestions"* for Civil proposals in From-markup jobs.

## What the user sees

1. **At setup:** CE suggests a mode separately for each discipline of the job. An engineer markup or supplied
   design in the job folder suggests **From markup / supplied design**; otherwise suggest **Design from scratch**.
   The user can change the suggestion. No choice asks who the user is or locks a person out.
2. **On the CE panel:** show the current mode for the active discipline and a way to switch it at any time.
   Design/CDDESIGN still opens straight on a known job and opens on `During` for an unchanged, partly drawn job
   (UX-DES-02/03). The setup route follows the selected job mode.
3. **From markup / supplied design:** follow the supplied instructions, compare drawn work against the named
   markup or design, and show design figures as checks. `Confirm setup` returns to drafting. Drawn items absent
   from the markup remain allowed and appear quietly as `Not in markup`, with `Agree and remember` or `Remove`.
   All Civil sizing, levels, layout and detention proposals remain visible as suggestions. Mark conflicts
   `differs from supplied design`; never change the supplied design until the particular change is accepted.
4. **Design from scratch:** design tools lead with sizing, level and layout proposals, `Design this member` in
   Structural, and `Accept all` after preview where that proposal supports it.
5. **Markup arrives later:** CE offers to switch that discipline to From markup and check the design against
   the new markup. Switching keeps everything already drawn and adds the QA list. Declining leaves the current
   mode in place; CE does not discard work.

## Plan checks for the future build

1. **Setup:** a job with a supplied Civil design suggests From markup; a job without one suggests Design from
   scratch. The CE panel shows the Civil choice and permits a switch without a person-role lock.
2. **From markup:** confirm setup and return to drafting; draw an extra pit and see a quiet `Not in markup`
   item with `Agree and remember` and `Remove`. A conflicting proposal stays a suggestion until accepted.
3. **Late markup:** add a markup to a partly drawn Design-from-scratch job. CE offers a switch; switching
   retains all drawn pipes and pits and adds a QA comparison list.
