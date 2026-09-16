# Schedule comparison visual — independent audit

FOR TIM

The comparison actions behave as intended: Cancel retains typing, Discard restores the saved override, a second source change requires fresh review, and updating the schedule leaves the source level unchanged in the concept. One correction remains: a negative numeric level is rejected.

---

Actual file: ce-schedule-change-review.html in the existing private visualization directory. SHA256 212291A4340798AAE6B56F7270BB513731369E4C31A446DD6C2185408D5926D9.

Ran own offline Playwright script against the actual file URL, not a copied HTML string or root check script. Evidence: SCHEDULE_INTERACTION_EVIDENCE.json. 22 Boolean checks: 21 pass, 1 fails; no browser page errors. Three extra layout measurement records are not counted as assertions. Opened all three actual screenshots using view_image.

| Finding | Result / required action |
|---|---|
| SV01 — numeric override validation | Entering -0.125 with a nonblank reason, then Review changes → Keep pending override, leaves Update disabled and asks for a numeric value. Source regex accepts only unsigned decimal strings. No positive-only cover-level policy is approved. Accept signed finite numeric levels; reject invalid/nonfinite input without inventing an engineering limit. |
| Layout limitation | At 1280×720 footer ends at 693px, no clipped action or horizontal overflow; document height721 is incidental one-pixel overflow. At1024×768 actions fit. At390×844 the readable stacked layout scrolls to footer around1202px. This is narrow-screen fallback, not no-main-scroll parity. |

Four initial values are visibly distinct (previous linked, new linked, saved override, pending override), including separate saved/pending reasons. Blank reason blocks override update. Keep pending updates only concept schedule; Use linked removes only that override. Source changes invalidate a selected choice. Escape from an input cancels review. No repeated Apply after completion. No actual DWG, schedule, engineering source, persistence or native acceptance is proved.

Root25's explicit Keep pending override wording was separately read back and closes UX02-A at proposal level. Visual SV01 remains open; whole-plugin work remains active.

## Signed-level correction closure

Reran the independent actual-file script after correction. SHA256 77B26F0BD86C9B06F11E17B8E92A10D4B790443CE1A78E4ADB0F56CF4BFEC415. All 22 Boolean checks now pass, including negative numeric RL; no page errors. SCHEDULE_INTERACTION_EVIDENCE.json contains this latest run. Layout measurements unchanged; earlier opened screenshots remain representative because the correction only changes input validation. SV01 closed for this offline concept. No native or full-product claim.
