# REPAIR-DECIDE-LATER workflow card — a "Decide later" tab in Drawing Repair, delete gated to Tim

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Sources of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` — UX-REP-02
("A tab in Drawing Repair (Recommended)": *the "Decide later" holding list is a tab in Drawing Repair, with
the count in its title*), UX-REP-03 ("Administrator only (Recommended)": *anyone can resolve a parked item;
only an administrator can delete one outright, and CE records who and why*), UX-ADMIN-01 ("Tim only
(Recommended)": *Tim is the only CE administrator on day one; adding someone is done in Manager*), and
UX-WORD-03b ("Decide later (Recommended)": *plain and says what happens; the item waits in the holding list
with your reason*, replacing the design pack's "Leave undecided"). This card is the scoped workflow card
draft PR #240 (`claude/ux-repair`) stopped and asked Tim for, quoting its own words below.

## 1. Why this card exists — quoting the blocker it answers

Draft PR #240 built UX-REP-01 (`CDSYNC`/`CDREBUILD` print a warning line before they write — separate,
already-scoped work) and then stopped on UX-REP-02/03, in its own words: *"Item 2 (a 'Decide later' tab in
Drawing Repair listing parked items) and item 3 (admin-gated delete on those items) don't map onto anything
in the code today... My question: do you want (a) a scoped workflow card for the 'Decide later' tab + admin
delete, written up and reviewed per AGENTS.md's command/workflow gate before any code starts, or (b) a
narrower first slice?"* This card is option (a).

## 2. What works today — Keep / Missing / Rebuild, verified on `origin/master` at `bf57f739` (24 Sep 2026)

1. **Drawing Repair today is one page, no tabs, no per-finding action — Missing the whole mechanism this
   ruling needs.** `Modules/Manager/UI/Pages/DrawingRepairPage.xaml` has no `TabItem` at all (confirmed:
   zero matches for `TabItem` in the file). `Modules/Manager/UI/ViewModels/DrawingRepairViewModel.cs` shows
   findings as read-only rows (`DrawingRepairFindingViewModel`: heading/detail/next-step text only, no
   command bound to an individual row) with simple page-forward/page-back paging
   (`PreviousFindingsCommand`/`NextFindingsCommand`). The whole session is one **Preview → Apply** block: the
   contract `Shared/CE_SHARED/Contracts/ICeDrawingRepairContributor.cs` exposes exactly `Preview(sessionId)`
   and `Apply(sessionId)` for the entire retained repair plan — there is no method or event for "the drafter
   chose X for this one finding." A per-finding "Decide later" click is new surface area, not a UI tweak to
   something already there.
2. **"Quarantine" today is an automatic side effect, not a reviewable list — Missing what UX-REP-02 needs to
   point at.** The only thing called quarantine today is written automatically by `CDSYNC`/`CDREBUILD`'s
   Apply: rows that cannot be safely auto-repaired are written into a Named Object Dictionary,
   `CE_CVL_REPAIR_QUARANTINE` (constant confirmed at
   `Modules/Drainage/Services/LinkService.RepairAudit.Apply.cs:17`). Only a **count** of that dictionary
   reaches the UI — `DrawingRepairViewModel.QuarantinedCount`, bound in
   `DrawingRepairPage.xaml:202` as "Quarantined rows: {count}". No individual row, reason or delete action
   is exposed anywhere today.
3. **The five-tab, "Decide later" design already exists as a document, not as code — a Rebuild target once
   Tim approves this card, not a Missing invention.** `docs/design/V3_UI/windows/15_REPAIR_UPGRADE.md` is
   where the "Decide later" wording and a tab layout for it originate; it is design intent, never built.
   This card turns the two relevant pieces of that document (the Decide-later tab, the admin-gated delete)
   into an approved, scoped build — it does not resurrect the rest of that document's five-tab shape
   wholesale, which is outside what Tim ruled on 25 Sep.
4. **The admin mechanism already exists and is reusable — Keep, with one confirmed security gap to close
   as part of this card.** `Modules/Manager/Services/CeAdminPolicyService.cs`, `GetPolicySnapshot()`: reads
   `admin-users.json` from a shared IT-Admin folder first, then a local per-machine copy, and is already
   consulted by `PluginManagerWindow`/`PluginAdminWindow` (shown read-only on the Policies tab). Verified
   directly (not just from the PR's own account): when **neither** file exists anywhere —
   `if (!hasPolicyFile) { isAdmin = true; policySource = "Fallback"; ... }` — **every current Windows user
   is treated as an administrator.** That is the opposite of UX-ADMIN-01 ("Tim only... on day one") and is
   the one real gap between what exists and what this ruling needs. No delete gate should ship on top of
   this fallback unfixed, or the first colleague to open a fresh install becomes an administrator by
   accident.

## 3. The full experience — today's state and the intended result

1. **Ribbon/trigger — Keep, unchanged.** Drawing Repair opens exactly as it does today; this card adds a
   tab inside it, not a new entry point.
2. **Prompts — not applicable**, no command-line prompt is involved.
3. **Selection — Missing, new.** Today no finding can be individually acted on. Intended: each finding in
   the main Preview list gains a **Decide later** action (per UX-WORD-03b's wording) alongside whatever
   action it already offers, asking for a short reason (consistent with UX-STD-04's "quick picks + note"
   pattern already ruled for override reasons elsewhere, though this card does not assume that exact control
   without Tim confirming it fits here — see OPEN 2).
4. **Preview — Modify.** Today's single Preview covers only what `Apply` is about to write. Intended: a
   parked item leaves the active Preview/Apply set (it is not applied, not ignored — it is set aside) and
   appears instead in the new **Decide later (n)** tab, where `n` is the live count in the tab's own title,
   per UX-REP-02.
5. **Drawing output — Modify.** Today Apply writes the reviewed plan as one block. Intended: Apply still
   writes only what remains in the active plan; a parked finding is excluded from that write until it is
   explicitly resolved later (moved back into an active Preview) — parking must never silently drop a
   finding from being fixed eventually, and must never silently include it either.
6. **Cancel — Keep the existing rule, extended.** Cancelling the whole Drawing Repair session today leaves
   the drawing untouched; intended: it also leaves the Decide-later list exactly as it was — parking a
   finding is its own committed action (recorded with who and why, per UX-REP-03), not staged inside the
   same Cancel/Apply the rest of the findings use.
7. **Escape — Keep, unchanged**, same extension as Cancel.
8. **One Undo — Missing, needs a decision.** Today's Apply is one Undo for the write it performs. Parking a
   finding does not write to the drawing at all (it is bookkeeping, not geometry), so it likely should not
   consume an AutoCAD Undo step the way a drawing edit does — flagged as OPEN 3, since the existing standing
   rule ("only deleting CE's link records still asks" / preview-then-one-click elsewhere) was written for
   drawing changes, not for a purely administrative park/resolve/delete action.
9. **Save/reopen — Missing, new.** The Decide-later list needs to persist with the drawing (or with the
   job) so it survives a close/reopen; today nothing like it is stored. Recommend storing it the same way
   the existing automatic quarantine NOD already proves out (a Named Object Dictionary keyed per finding,
   analogous to `CE_CVL_REPAIR_QUARANTINE`), rather than inventing a new storage mechanism — flagged as
   OPEN 4.
10. **Where values come from — new, Settings-adjacent.** The administrator list itself
    (`admin-users.json`) is exactly the kind of firm-wide value the standing Settings-first rule (R-00)
    already governs the pattern for, even though this particular file lives outside the drawing. This card
    treats "who is an administrator" as a Manager-owned policy value, not a hardcoded name — Tim's own
    Windows account is the seed value, not a literal "Tim" string baked into the code.

## 4. Resolve vs delete — exactly what UX-REP-03 draws the line on

1. **Resolve — anyone.** Any CE user can take a parked finding out of the Decide-later list by fixing it
   (running it back through the normal Preview/Apply) or by explicitly marking it resolved with a reason.
   No admin gate.
2. **Delete outright — administrator only, recorded.** Removing a parked finding **without resolving it** —
   i.e. discarding the record itself — is gated to `CeAdminPolicyService.IsCurrentUserAdmin()`, exactly as
   `PluginManagerWindow`/`PluginAdminWindow` already gate their own admin-only actions. CE records who
   deleted it, when, and the reason given, per UX-REP-03's "CE records who and why."
3. **On day one, "administrator" means Tim, and only Tim — UX-ADMIN-01.** This is the gap in §2.4: today,
   a machine with no policy file anywhere makes *its own current user* an administrator. **Recommended fix,
   not assumed without Tim's confirmation (OPEN 1):** do not auto-seed the admin list from "whoever happens
   to read the policy first" (that could be any colleague's machine, not Tim's). Instead, seed the
   **shared** `admin-users.json` once, deliberately, with Tim's own Windows account — a one-time action Tim
   takes himself (e.g. from a Manager screen, confirming his own username) rather than code guessing at
   installer time. Once that shared file exists, every other machine already reads it first and the
   dangerous "no file anywhere" fallback never triggers for a colleague again. "Adding someone is done in
   Manager" (UX-ADMIN-01) already implies this needs a real screen, not just a fixed JSON file someone edits
   by hand.

## 5. Example drawings

1. **DWG-A or DWG-B (Civil):** a job with at least two findings that Drawing Repair's existing engine can
   raise (the existing automatic quarantine path already proves findings can be generated — reuse whatever
   test drawing already exercises `CE_CVL_REPAIR_QUARANTINE` today) — one to park with a reason, one to
   apply normally, so the split between the active Preview and the new Decide-later tab is visible in one
   session.

## 6. Automated guards vs Tim's AutoCAD checklist

1. **Automated:** a unit test proving `CeAdminPolicyService`'s fallback no longer silently grants admin once
   the seeded shared file exists (and still fails closed — not admin — for a colleague when it does exist
   and they are not listed); a test proving a parked finding is excluded from the next Apply's written plan
   until resolved; a test proving delete is refused for a non-administrator and recorded (who, when, reason)
   for one who is; a test proving Cancel/Escape leaves the Decide-later list unchanged.
2. **Tim's AutoCAD checklist (DWG-A or DWG-B):** open Drawing Repair, park one finding with a reason.
   **Right result:** it disappears from the active Preview/Apply list and appears in a **Decide later (1)**
   tab with the reason shown. Apply the rest. **Right result:** the parked finding was not touched by that
   Apply. As Tim (the seeded administrator), delete the parked item. **Right result:** it is gone, and CE
   shows/records that Tim deleted it and when. Confirm a non-administrator account sees Resolve but not
   Delete on the same item (this half of the checklist needs a second Windows/AutoCAD account, or can be
   simulated in the automated guard above if a live second account is impractical).

## 7. Slices — smallest first

1. **Slice 1 — close the admin fallback gap.** Seed the shared `admin-users.json` with Tim's account through
   a deliberate Manager action; confirm the dangerous "no file anywhere → current user is admin" path can no
   longer be reached once that seed exists. This is worth shipping on its own regardless of the rest of this
   card, since it is a live security gap today.
2. **Slice 2 — read-only Decide-later tab over the existing automatic quarantine.** Surface
   `CE_CVL_REPAIR_QUARANTINE`'s individual rows (today only a count reaches the UI) as a new tab, read-only,
   with the count in the tab's title. Proves the tab/list mechanism before any new write path exists. This
   matches option (b) from PR #240's own question, folded in as this card's first real slice rather than a
   separate track.
3. **Slice 3 — per-finding "Decide later" from the main Preview.** Add the park action and reason capture to
   an active finding, excluding it from that session's Apply.
4. **Slice 4 — resolve and admin-gated delete**, with the recorded who/when/why, completing UX-REP-03.

## 8. OPEN questions, each with a recommended answer

1. **OPEN 1 — how exactly is the shared `admin-users.json` seeded with Tim, and where does that one-time
   action live?** *Recommended: a Manager screen Tim runs once himself (confirms his own Windows account,
   writes the shared file), not automatic code that seeds from "whoever reads it first" — that could seed
   the wrong person on a colleague's machine before Tim's own install ever runs.*
2. **OPEN 2 — does "Decide later" ask for a reason the same way UX-STD-04's override-reason quick-picks
   work (Survey / Council requirement / Engineer's judgement / Other + note), or does it need its own
   simpler set of reasons?** *Recommended: reuse UX-STD-04's existing quick-pick pattern rather than invent
   a second one — consistency across the plugin, and it is already an approved control.*
3. **OPEN 3 — does parking or resolving a finding consume an AutoCAD Undo step, given it does not write to
   the drawing?** *Recommended: no — Undo stays reserved for drawing writes; parking/resolving/deleting are
   administrative record changes with their own audit trail (who/when/why), not geometry changes.*
4. **OPEN 4 — does the Decide-later list live in the same per-drawing Named Object Dictionary pattern as the
   existing automatic quarantine, or does it need to survive independently of any one drawing (e.g. a
   project-level or Manager-level store)?** *Recommended: start per-drawing, alongside the existing
   `CE_CVL_REPAIR_QUARANTINE` pattern, since that is proven infrastructure; revisit only if Tim confirms
   parked items need to be visible across drawings.*
