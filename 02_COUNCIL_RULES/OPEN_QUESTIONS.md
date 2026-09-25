# Council rules — the open questions

**Every question raised by reading seventeen council documents that Tim has not yet answered.** They are
scattered one-by-one through the `COUNCIL_*.md` files; this is the single list.

**Nothing here is a decision.** An unanswered question stays on this list until Tim answers it, in his own
words, and then moves to the council file it belongs to with the date.

Started 15 September 2026.

---

## A. Numbers that go into every job

These change flows, pipe sizes and orifice sizes on every drawing. They matter most.

### A1 — The runoff coefficient for soft ground: 0.30 or 0.35?

**ANSWERED by Tim, 25 Sep 2026 13:10 — CR-A1: two numbers, 0.35 whole site before development (hold unchanged), 0.30 soft ground after development. Tim's words and detail: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`.**

**What it is.** The number that says how much rain runs off lawn, garden and landscaping rather than
soaking in. It multiplies straight into the flow, so it decides every pipe size, every orifice and every
detention volume.

**What we found.** The plugin uses **both**. The automatic design uses 0.35. The Boyd's calculator window
opens showing 0.3, and so does the pump sizing. Worse, when the plugin works out the pre-development
coefficient it uses 0.35 but **prints working beside the answer that says 0.3** — so anyone checking the
sum by hand from what we showed them would not get the number we showed them.

**What the councils say.** Three state 0.30 for a soft surface and 0.90 for a hard one — Banyule, Darebin
and Maroondah. **Five use 0.35 as a whole-site figure** — Banyule, Maroondah, Darebin, Frankston and
**Boroondara**, which says so outright: *"sparsely developed land with a combined runoff coefficient equal
to 0.35… not influenced by the actual (existing) site coverage."*

So the explanation now has five councils behind it: **0.35 is a site number, 0.30 is the soft-ground number,
and CE has the site number sitting in the soft-ground field.**

**The question.** Is the soft-ground coefficient 0.30, is it 0.35, or are they two different numbers for
two different sums?

**Blocks:** correcting the printed working; every flow the plugin calculates.

### A2 — The orifice discharge coefficient: 0.6 everywhere?

**ANSWERED by Tim, 25 Sep 2026 13:10 — CR-A2: 0.6 everywhere, Darebin 1.0 shown as a note on Darebin jobs. Tim's words and detail: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`.**

**What it is.** How freely water escapes through the hole that limits the site's discharge. A bigger
coefficient means a smaller hole for the same permitted flow.

**What the councils say.** **Yarra and Maroondah both state 0.6 for a round pipe, in the same words**
(*"coefficient of round shaped pipe"*), Maroondah with a worked example. Frankston has 0.6 built into its
one-step formula. **Darebin alone says 0.6 for a square or rectangular hole and 1.0 for a round one.**

**Four councils at 0.6, one at 1.0.** This looks ready to close on Tim's word: *0.6 everywhere, Darebin
recorded as the exception.* The difference between 0.6 and 1.0 is a hole about 29% bigger in diameter — roughly 60 mm
where Darebin's own formula gives 46.

**The question.** Is it simply 0.6 everywhere, with Darebin recorded as the one exception? Or does each
council get its own?

**Blocks:** every orifice we draw.

### A3 — Rounding the orifice: up, down, or nearest?

**ANSWERED by Tim, 25 Sep 2026 13:10 — CR-A3: round DOWN to the whole mm, never below the council minimum. Tim's words and detail: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`.**

**What it is.** The sum gives an awkward number like 42 mm; the hole has to be a real size.

**What the councils say.** Maroondah works out 42 mm and **adopts 40** — it rounds down to the nearest size
off the shelf, from 32 · 40 · 50 · 65 · 80 · 90 · 100 · 150. Manningham says **nearest standard pipe
diameter ±2 mm**. Our own recorded answer was to snap **up** to the next standard size at or above the
minimum.

**Why it matters.** Rounding up lets out *more* than the permitted discharge. Rounding down lets out less
and holds more water back.

**The question.** Which are we doing?

**Blocks:** every orifice we draw; the detention volume that goes with it.

### A4 — The Australian Standard edition

**What we found.** The councils name different editions of AS/NZS 3500.3: Darebin **2025**, Kingston
**2021**, Frankston and Manningham **2018**, Banyule **2015**, Boroondara names none. CE holds 2018.

Tim has already ruled: *"work with australian standard issue we hold currently."* That is right for
Frankston and Manningham and differs elsewhere.

**The question that remains.** Should the plugin **record which edition each council names and show it on
the job**, so the difference is visible rather than assumed — while still working to the copy we hold?

**Blocks:** nothing urgent. It is a display and record decision.

### A5 — Step irons: 900 deep everywhere, or each council's own?

**ANSWERED by Tim, 25 Sep 2026 13:10 — CR-A5: 900 mm everywhere, one office rule. Tim's words and detail: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`.**

**What we found.** Tim ruled *"LET'S DO OVER 900 DEEP."* Maroondah's own table requires step irons above
**900**. Banyule and Manningham both say **1 metre**.

**The question.** Do we hold 900 everywhere as the office rule, or follow each council's own depth?

**Blocks:** the pit schedule remark; which pits get step irons drawn.

---

## B. Drawing rules the councils publish and we do not hold

### B1 — Twin pipes: 200 mm clear between the outside faces

Manningham publishes it plainly for pipes up to 600 diameter. It is a rule for exactly what the twin-barrel
pipe object draws, and it is measured **outside face to outside face**, not centre to centre.

**The question.** Is 200 mm clear what CE draws today, and does it change by council?

### B2 — The biggest pipe a pit can take

Banyule caps it: a 600 × 600 pit may take a 300, anything larger takes up to 600. We hold no such rule for
any council, so a 375 into a small pit would go out unflagged.

**The question.** Should the plugin warn when a pipe is too big for the pit it enters?

### B3 — The pit lid chosen by where the pit sits

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-02: suggest from the surface. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Manningham names a class for each place: driveway, vehicle crossover, landscaped area, backyard.

**The question.** Is the drafter picking that each time? Should the plugin offer it?

### B4 — Agricultural drains bypass the detention

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-04: own system, rule per council. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Manningham requires AGI drains to **bypass the detention system entirely** and discharge to the outlet
chamber — or, if connected in, at least 150 mm above the top of the baffle wall.

**The question.** Is that how we draw them, and should the plugin treat an AGI run as a separate system
rather than part of the drainage network?

### B5 — Minimum flow velocities

Frankston: 0.7 m/s running half full or more, 1.0 running less than half, 6.0 maximum. Banyule: 1.0 to 6.0.
Maroondah: 0.75, 1.0, and 5.0 maximum.

**The question.** Are minimum velocities being checked on CE designs today, or only capacity? A pipe can
have plenty of capacity and still run too slowly to keep itself clean.

### B6 — Pipe class and pipe material change by council

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-08: default from council + warn. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

**Class:** Mornington Peninsula requires **Class 3** minimum concrete; Darebin, Banyule and Manningham
accept **Class 2**.
**Material:** Maroondah **will not accept fibre reinforced concrete or vitrified clay**; Darebin and
Manningham both explicitly accept FRC.

**The question.** Is pipe class and material being set per job now, or is one specification used everywhere
out of habit?

### B7 — Multi-cell flow control units

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-09: warn with source. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Banyule, Manningham, Frankston and Darebin all accept them. **Maroondah refuses them outright**, along with
above-ground storage on a driveway.

**The question.** Have we ever specified a multi-cell on a Maroondah job?

### B8 — The detention volume written on the plan

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-10: always show volume. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Whitehorse requires the **volume** on the drawing, not only in the computations, alongside location, levels
and dimensions.

**The question.** Is it on our plans today?

### B9 — Contour intervals

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-11: check survey contours and tell. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Whitehorse asks for existing and design contours at **0.1 m on flat sites, 0.2 m elsewhere**, extending
**10 m into adjoining properties**.

**The question.** Is that what our survey drawings carry, or would a Whitehorse job need the survey redrawn?

### B10a — Pipe lengths must match the manufacturer's lengths

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-05: warn on short offcuts. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Yarra requires it explicitly, *"to avoid small pipe sections adjacent to pit"*.

**The question.** When the plugin splits a pipe where a new pit is placed, should it be trying to land on
real pipe lengths rather than leaving a short offcut beside the pit?

### B10b — Several councils share the same base text

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-06: shared base + overrides. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Yarra's checklist repeats Manningham's lines word for word, and Yarra's time-of-concentration table is
identical to Maroondah's, number for number.

**The question.** Should the plugin hold **one shared default set that each council inherits and
overrides**, rather than 22 separate records filled in by hand? It would also prevent the kind of copying
error found on the 1:200 grade.

### B10c — The impervious threshold that triggers detention

Yarra: no detention needed below **70%** hard surface. Banyule: detention required above **65%** (and 35%
for a carpark).

**The question.** Is that threshold being checked per council, or is detention assumed on every multi-unit
job?

### B10d — How far an outfall drain must be extended

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-07: checked at Design start. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

Boroondara publishes a table of the *"reasonable length of drain required"* before Council accepts that an
outfall cannot be built — 15 m to a kerb for a small lot, up to 150 m to an easement for more than six
dwellings. No other council read has a rule of this kind, and it decides whether a job carries an outfall
drain at all.

**The question.** Is that being checked at the start of a Boroondara job?

### B10e — Council drains with no easement on title

**ANSWERED by Tim, 26 Sep 2026 — UX-CR-03: show 1 m band and warn. See decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.**

A Council drain crossing a property with no registered easement still carries an **implied easement** under
the Water Act — **no structure or filling within one metre either side**. Boroondara has many such
"Health Act" drains.

**The question.** Are those drains being shown on our plans, or only the registered easements?

### B10f — The impervious threshold that triggers detention is a per-council value

Five different figures found: **Maribyrnong 40%** · Banyule **65%** (35% for a carpark) · Yarra **70%** ·
Boroondara **80%**, which also excuses detention on any lot under 300 m². Maribyrnong's is by far the
lowest, so detention is required on far more jobs there.

**The question.** Is that threshold being checked per council, or is detention assumed on every multi-unit
job? *(Supersedes B10c, which recorded only Yarra and Banyule.)*

### B10 — The critical storm duration

Mornington Peninsula requires the submission to say **which storm duration was the critical one** for the
detention volume, not just the volume.

**The question.** Is that stated on CE's computations today?

---

## C. Things only Tim knows — has this been happening on real jobs?

Each of these is a case where a council's own document differs from what the plugin holds, or from what an
office habit would produce. None can be answered from a document.

| # | Question | Why it matters |
|---|---|---|
| **C1** | **Basements — which council rule have we been working to?** **Boroondara**: Council *"is not required to accept this water"*; sub-surface drains run almost continuously and are a nuisance at a kerb outlet; where no alternative exists an outfall drain must be built to the boundary. **Yarra** is strictest: tank the basement if within 2 m of groundwater, **no pumping groundwater into Council's network at all**, and the agricultural drains at the building interface must be kept from letting it in. Manningham allows a basement pump into the detention if the rising main invert sits at or above the top of the baffle wall. Darebin forbids basement seepage in the stormwater system altogether. Boroondara forbids basement groundwater to laneways, kerbs and channels. Maroondah wants an **extra** 1-in-100, 60-minute store for the basement catchment on top of the normal detention, unless there is an automatic backup pump and generator. | **Six councils, six answers — the most divergent rule found.** One of them is probably being applied everywhere. |
| **C2** | **Where did Whitehorse's 90 mm minimum orifice come from?** It is more than twice every other council (Darebin 30, Banyule 40, Manningham 40, Maroondah 40). A 90 mm hole passes about five times the flow of a 40 mm one. | If right it shapes every Whitehorse job; if wrong, every Whitehorse orifice has been drawn too large. It is the least-supported number in the council file. |
| **C3** | **Is CE using Frankston's 3-minute time of concentration on multi-dwelling jobs?** | It is the shortest of any council. A longer time out of habit makes the design *less* conservative than Frankston asks. |
| **C4** | **Frankston gives flats and units a runoff coefficient of 0.8** — the same as a factory, double a house on a big block. Is that what we apply? | Most of CE's work is multi-unit. |
| **C5** | **Have we done commercial work in Darebin?** Commercial uses 0.6 before and 0.90 after, not the residential 0.4 and 0.8 we hold. | We only store the residential pair. |
| **C6** | **Have we done Mornington Peninsula jobs?** That Shire will not accept a table of coefficients — they must be calculated for the site to Australian Rainfall and Runoff with Bureau rainfall for that location. | A different way of working. Better known before a job lands than at assessment. |
| **C7** | **Have Manningham jobs been drawn at 1 in 200?** Manningham requires detention pipes no flatter than **1 in 180**. We had 1:200 recorded for them. | A pipe at 1:200 there is flatter than Council allows. |
| **C8** | **Have Maroondah jobs been drawn at 1 in 200?** Maroondah publishes a ladder by size — 1:150 for a 150, **1:250** for 225 to 450, 1:400 for 525 and up. | We had a single 1:200 recorded for them. |
| **C9** | **Has an orifice ever gone out smaller than a council's own minimum?** We hold no minimum at all for Darebin, Banyule or Maroondah, all of which publish one. | |
| **C10** | **Does our Boroondara orifice pit detail show a sump and weepholes?** Council's own drawing SD999 Rev J has a **300 mm sump** and **25 mm weep holes**, and photographs both at inspection as a mandatory item. Also: does it show the mesh fixed to 40 × 40 × 5 angle, and the plate at the greater of 300 × 300 or 3 × the orifice? | If the detail does not show them the builder may not build them, and the inspection fails after the pour. |
| **C15** | **Have Boroondara jobs been designed with a 5-minute time of concentration?** Boroondara uses **15 minutes on every site**, deliberately, for consistency. We have 5 recorded. | Fifteen is the longest of any council. A longer time means lighter rainfall and a smaller flow, so 5 would oversize. |
| **C16** | **Is Boroondara's post-development coefficient floor of 0.65 being applied?** The rule is the proposed land use figure **or 0.65, whichever is greater**. | |
| **C11** | **Is Banyule's rear-fall rule being picked up?** Their design storm steps from 1 in 10 to **1 in 20 if the site falls to the rear**. | A rear-falling Banyule site would otherwise be designed to 1 in 10 by default. |
| **C12** | **Are the water-level-to-floor freeboards being checked?** Darebin: 400 mm below habitable floors, 200 below garages. Manningham: 300 and 150. Banyule: 300 below floors and 300 below any grated inlet. | These sit **alongside** our own 150 mm water-to-pit-lid rule, not instead of it. |
| **C13** | **ANSWERED 26 Sep (UX-CR-01): CE writes the enquiry from the drawing.** **Is the Boroondara enquiry being written by hand?** Council needs five figures before they will issue the permitted discharge — site coverage, total site area, roof area, paved area, landscaped area — and answers in 10 working days. All five are measurable off the drawing. | The design cannot be finished until Council answers, so it wants sending early. Also a small, high-value feature. |
| **C17** | **Have Maribyrnong jobs been run at a 5-minute time of concentration?** Their detention criteria are tc **10** minutes and tso **6**. The stored 5 looks to have come from their *other* table — the 5-minute minimum for commercial drainage design, a different thing. | |
| **C18** | **Has any Maribyrnong job been given 1-in-20 storage?** Council's storage storm is **1 in 10**; the 20 is their overflow requirement. | |
| **C19** | **Is Maribyrnong's post-development coefficient floor of 0.75 being applied?** It is the highest floor seen — Boroondara's is 0.65. | |
| **C14** | **Have we done Kingston jobs since the ×0.5 porous paving rule was issued?** | Carried over from the Kingston Issue 5 read; still unanswered. |

---

## D. Housekeeping — I can start these without a decision

### D1 — Sweep the whole council file for copied and wrong values

Two error patterns are proven, not suspected:

- **Above-ground storage.** `minUndergroundPct` was wrong for Boroondara (fixed earlier as audit item D1)
  and is wrong the same way for **Banyule**, which bars above-ground tanks outright. Two found, both only
  because a document happened to arrive.
- **The copied grade sentence.** *"Min pipe grade 1:200 for detention pipes 225 and greater"* is stored
  against **five** councils. Correct for two (Darebin, Banyule), **wrong for two** (Manningham 1:180,
  Maroondah's ladder), unverified for one (Knox).

Also: `orificeMinMm` is **zero for 16 of 22 councils**, including **five** that publish a minimum — Darebin
30, Banyule 40, Maroondah 40, **Maribyrnong 40**, and Manningham 40 (the only one stored).

**A third error pattern has now appeared: a value taken from the wrong row of the right document.**
Maribyrnong's `storageAri` is stored as **20**, which is Council's *overflow* storm; the storage storm is
**10** — and the warning stored beside the field already says 10. So the field and its own warning
contradict each other.

That makes three patterns to sweep for, not two: values copied from another council, values in the wrong
field, and values from the wrong row.

**Ask:** shall I sweep all 22 councils for these patterns, rather than catching them one at a time as
documents arrive?

### D2 — Bring the evidence file onto the live branch

Every council value in the plugin carries a "where this came from" link pointing at
`docs/evidence/COUNCIL_PROFILE_EVIDENCE_2026-09.md`. That file exists on other branches but **not on the
live line**, so the links do not resolve where the data actually ships.

**Ask:** bring it across?

---

## Where the answers go when Tim gives them

Into the council file the question belongs to, **in Tim's own words, in quotes, with the date** — then
struck from this list with a pointer to where it landed. Never summarised into a decision here.
