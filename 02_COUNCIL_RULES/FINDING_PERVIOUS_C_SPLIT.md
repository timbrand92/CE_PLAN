# Finding — the pervious runoff coefficient is 0.30 in some places and 0.35 in others

**15 September 2026.** Found while verifying CE's stored Boroondara rules against Council's own page.
**Nothing changed.** The correct value is Tim's call and has been pending as rulebook item **B2 STANDING
HOLD** since the rulebook was written.

---

## What the coefficient does

The pervious runoff coefficient is the number that says how much rain runs off a **soft** surface — lawn,
garden, landscaped area — rather than soaking in. It multiplies straight into the flow, so it feeds every
pipe size, every orifice and every detention volume on the job. A difference of 0.30 versus 0.35 is about
**17% more runoff from every soft area**.

## Where each value currently sits

**0.35:**

| Where | What it is |
|---|---|
| `AutoDesignService.cs:53` | `PerviousRunoffC = 0.35` — the automatic design |
| `council-profiles.json`, `perviousC` | **0.35 for 21 of the 22 councils** (Yarra Ranges is 0.3) |

**0.30:**

| Where | What it is |
|---|---|
| `PumpSizingService.cs:78` | `CPervious = 0.30` — pump sizing |
| `BoydsCalcViewModel.cs:17` | the Boyd's calculator window **opens showing 0.3** |
| `PumpSystemCalcViewModel.cs:16` | the pump calculator window **opens showing 0.3** |
| `CouncilProfileModels.cs:64` | the fallback used when a council record has no value |
| `preDevCFormula` text, 18 of 22 councils | `(0.3*pervious + 0.9*impervious)/site` |

So **the automatic design and the calculator window disagree with each other** on the same site, and the
pump sizing disagrees with both.

## The part that matters most — the shown working does not match the answer

`CouncilRuleValues.PreDevelopmentC` computes the pre-development coefficient from the `perviousC` **field**
(0.35). It then attaches the `preDevCFormula` **text** as the evidence line the engineer is shown:

```
computed with:   perviousC = 0.35
evidence shown:  "(0.3*pervious + 0.9*impervious)/site"
```

The formula string is never evaluated — it is display text only. So the number is produced from 0.35 while
**the working presented alongside it says 0.3**. Anyone checking the calculation by hand from the stated
formula would not reproduce the stated answer.

That is the serious half of this. A wrong-but-consistent coefficient is a judgement call; a number whose
own shown working contradicts it will not survive a council assessment. Mornington Peninsula asks in
writing for the calculations to be shown; Boroondara and Mornington both require computations signed off
by a qualified engineer.

## This is not new — it is rulebook B2

`docs/ENGINEERING_RULEBOOK.md`:

> **B2** Pervious C = **0.35** 🔒 STANDING HOLD · *Detention default `0.30`; a CDCALC test expects `0.3`* ·
> *Feeds every flow → every pipe/orifice/tank*

and

> Pervious runoff C **0.35 (code) vs 0.30 (guidebook)** — feeds every flow.

**What this pass adds** is that the split is wider than the rulebook records: it is not only the detention
default and one stale test, it is the pump sizing, both calculator windows, the fallback default and the
evidence text for 18 of 22 councils.

## Also worth noting

- **These are hard-coded constants** (`private const double`), which sits against the settings-first rule —
  every engineering value on the Settings page, nothing hard-coded.
- **The Boyd's calculator opens pre-filled with a real worked example** — 746 m² catchment, 414 impervious,
  332 pervious, 95.3 intensity, 7.9 L/s discharge. The areas would obviously be overwritten; the
  coefficient sitting quietly at 0.3 would not be.

## Update, same day — two councils suggest the two numbers are different things

Read after this finding was written:

- **Banyule** (*Stormwater Drainage Requirements*, 2019) states all three separately: **0.30 pervious**,
  **0.90 impervious**, and **0.35 for the whole site pre-development**, *"regardless of pre-existing
  impervious surfaces"*.
- **Darebin** (*LPD Guidelines*, June 2025) does the same: **0.30 pervious / 0.90 impervious** for the pump
  SSR, **0.4** as the pre-development site figure, and 0.35 in its rational-method example.

**Two independent councils use 0.30 for a pervious surface and 0.35 as a site-wide figure.** That points at
an explanation: `perviousC = 0.35` in CE's council records may be **a pre-development site coefficient
filed into the pervious-surface field**. It would also explain the split — the places using 0.30 (pump
sizing, both calculator windows) are using it as a *surface* coefficient, which is what it is, while
`AutoDesignService` at 0.35 is using a *site* figure as a surface figure.

Supporting detail: CE stores `preDevCFixed = 0.0` for Banyule, where Banyule publishes **0.35**. So for
that council the value may simply be sitting in the wrong field.

**This is a hypothesis with two councils behind it, not a ruling.** It does not change the question below
— it sharpens it.

## The question for Tim

**Is the runoff coefficient for soft ground — lawn, garden, landscaped area — 0.30 or 0.35?**

Right now the plugin uses both. The automatic design uses 0.35. The Boyd's calculator window opens at 0.3,
and so does the pump sizing. The council records mostly say 0.35, but the line of working printed next to
the answer says 0.3.

It is one number and it multiplies into every flow on the job, so both answers cannot stand. Once it is
settled, every one of the places listed above gets set to it, and the value moves onto the Settings page so
it can never drift apart again.
