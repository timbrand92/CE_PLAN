# MORNING PACK — 19 September 2026

**Overnight block. Nothing was deployed. Your AutoCAD is exactly as you left it: `3.0.0+d0ffe1a2`.**

---

# ▶ FOR TIM

## Two things are waiting for you

| | Branch | What it is |
|---|---|---|
| **A** | `claude/civil-combine-2026-09-18` @ `0a84eb07` | **Last night's four chats, merged and proven.** The safe one |
| **B** | `claude/civil-overnight-2026-09-19` @ `a438b73d` | **A + the eight overnight fixes**, audited and corrected |

**To install either, say to this chat: "AutoCAD is closed, deploy" — and tell me A or B.**

## What the overnight block added

| What you would see | |
|---|---|
| **Your LPD notes stop coming out short** — the old wording was stuck in your settings file, so changing the code did nothing | ✅ |
| **A locked layer can no longer let the schedule run ahead of the drawing** | ✅ |
| **A refused pipe now says which pipe** | ✅ |
| **The orifice detail** can no longer silently draft a different detail | ✅ |
| **Converted pipes** stop showing blank IL cells in the schedule | ✅ |
| **FALL / LEVEL / DP / WT tags** carry their text when moved | ✅ |
| **Both halves of a split pipe keep their own text** — the one you raised | ⚠️ partly, see below |
| **The ghost preview** — your ruling A | rule only; Codex builds the panel |

## The most important thing that happened last night

**I built the split fix on top of a bug I had not found, and it did nothing at all.**

The auditor caught it. In plain terms:

> When CE splits a pipe it rebuilds the labels on each half — **and it was forgetting what each label WAS.**
> The pipe text, the flow arrow and both level labels all came out as "unclassified". **And it threw away any
> wording you had typed yourself**, putting CE's wording back.

That is **older and worse** than the thing I set out to fix, and it has been happening on **both** ways of
splitting — drawing a pipe across pits, *and* dropping a pit onto a pipe.

**It is now fixed**, and my split fix works on top of it.

**Why my own tests missed it:** all six checked that the *code looked right*. None checked what it *did*. Same
mistake as the computations sheet with 27 green tests and `Note:` printed on every line. It is written into the
record so it is not repeated.

## One deliberate limit on the split fix

**If your pipe text is a block** (rather than plain text), CE now **refuses to copy it** and says so.

Why: a block keeps its words in a separate place, and I could not verify that copying a block brings its words
with it. If it does not, you would get **an empty box with no words** on a council drawing — exactly the fault
we just fixed twice. **There is a 30-second check that would settle it**, and I would rather ask than guess.

## What else the audit found, all fixed

A callout copied on top of itself · the orifice detail's new search being *wider* than the old one, not
narrower · a refused pipe reported as "kept your level" while also being refused · a message telling you to do
something that would be undone next time you opened AutoCAD · two places that failed silently where they should
speak up · and **two of my own tests that could never have failed** (one checked for the word "try", which is
inside "geometry").

## Your safety net

**`0a84eb07` is untouched and still installable on its own.** If anything overnight turns out wrong, that is
still there.

## Testing

- **76 steps** for last night's payload — `01_MASTER_PLAN/CODEX_TEST_RUN_2026-09-18.md`
- **18 steps** for the overnight work — rows **V1–V18** in `PENDING_TESTS.md`

**V12 is the one I most want an answer to:** after this, do labels still stay behind when you move or grip a
pipe? I fixed a *mechanism* that does that. Whether it is *your* mechanism is still a guess, and only you can say.

## Questions waiting on you — none decided for you

1. **Deploy A or B?**
2. Three tank tiles read "PLAN VIEW (7560 x 4800 mm)", "… 2", "… 3" — name them properly?
3. Two tiles read "Untitled tank plan" — leave honest, or name?
4. **The MELRO pair** — 4500 on a 5600x1760 block, 5500 on a 4622x1760. Still odd; **the online check has still
   not been done.**
5. `NOT SET` in the detention block — my wording. What should it say?
6. The street-note wrap width — five versions drawn for you on 17 Sep; not picked.
7. Should CDDESIGN outrank the Boyd's tab for permissible discharge?
8. Should CDTWL become a window?
9. The computations sheet — do you want me on it?

---
---

# ▽ WORKING NOTES

## State

| | |
|---|---|
| Overnight branch | `claude/civil-overnight-2026-09-19` @ **`a438b73d`**, pushed, tree clean |
| Frozen candidate | `claude/civil-combine-2026-09-18` @ **`0a84eb07`**, unmoved and independently deployable |
| Installed | **nothing deployed.** Live is `3.0.0+d0ffe1a2`, read from the DLL |

## Proof at `a438b73d`

- **Builds:** net48 / net8.0-windows / net10.0-windows — **0 errors**, rebuilt after every stage.
- **Full net10 suite:** **10,102 run · 10,063 passed · 22 failed · 17 skipped**. Failing **names** set-compared
  against the 20 recorded distinct names → **NEW: NONE · now-passing: NONE.**
- **+50 tests** over `0a84eb07`.

**Two of my own measurement mistakes, caught and corrected rather than reported:**

1. A per-fixture tally showed 0 tests for every overnight fixture — the trx stores bare method names, so the
   tally was broken, not the tests. Re-verified 17 by name.
2. A dict keyed by method name reported 2 recorded failures "now passing" while the count stayed at 22 — it
   collapsed parameterised cases. The set-based comparison used everywhere else shows identical.

## The eight commits

`0943a909` SET-01 · `bb72782d` L13/L12 · `3f4e3c04` ORF-01 + GHOST-01 · `160abe10` L10 · `75716280` ATTR-01 ·
`07325a2b` P-05 · `583437c0` ATTR-01 derivation · `a438b73d` **audit fixes**

Every guard was verified **RED** against its own pre-fix commit before being accepted.

## The audit

An independent auditor (Opus, read-only) reviewed all eight. Full write-up at the top of `REGRESSION_LOG.md`
under **AUDIT (2026-09-19)**. One CRITICAL, three HIGH, four MEDIUM, plus dead code and unfalsifiable tests —
all fixed.

**The CRITICAL:** `BuildAttachmentData(ent, half)` in the split's partition loop passes neither `semanticRole`
nor `previous`, so every rebuilt attachment resolved to `Unclassified` and lost `DisplayMode`,
`CustomDisplayText` and `ExtensionData`. P-05's `HasPipeText` therefore always answered "neither half", and the
fix could never fire. `CarrySplitIdentity` now carries role, linked field, display mode, custom wording,
CD-WORD-01 prefix/suffix and extension data; the four `Original*` placement fields are deliberately **not**
carried, because each half is a different, shorter polyline.

**Confirmed correct by the audit**, so it is not re-litigated: the ATTR-01 matrix composition, the P-05
perpendicular convention (including degenerate and bent pipes), that an ordinary pipe is unaffected by L10,
that GHOST-01 is pure and cannot write, and that SET-01's `Resolve` is right on every claim.

## Open, and named

- **PROBE needed before a block-type pipe label can be copied** (accoreconsole 2027): clone an attributed
  `BlockReference`, append it, print `AttributeCollection.Count`. If attributes come with `Clone()`, add
  `BlockReference` to `CanPlaceCopiedPipeText`; if not, it needs a deep clone with an `IdMapping`.
- **ATTR-01 is a hypothesis for O3 / O4 / O10 / O17**, not a claim. Row **V12** settles it.
- **GHOST-01 is not wired to anything** — no caller exists. Contract for Codex:
  `01_MASTER_PLAN/CONTRACT_GHOST_PREVIEW_2026-09-18.md`.
- **The CDWT crash (W4)** is still not fixed and its cause is still not established. Step N9 is a probe.
- **Not audited for the same shape:** other writers that set `BlockReference.Position`/`.Rotation` directly,
  and other drafters that find a block by an anonymous name.

## Deploy readiness (checked, not performed)

Both installer scripts present. Native `.arx` built in this worktree (the `MSB3030` trap). `acad.exe` was not
running at the last check — **that is not authorisation.** Manual steps still required at deploy: hand backup of
the live bundle, CE_SHARED sync into Manager, and Structural is **not** redeployed.
