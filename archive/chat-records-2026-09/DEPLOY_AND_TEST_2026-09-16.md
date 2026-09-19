# CE Civil — ready to deploy, and what to test

> ⛔ **SUPERSEDED BY THE TEST RESULTS.** Tim ran this list on 16 September and **most of it failed**. The
> authoritative record is **`TEST_DAY_RESULTS_2026-09-16.md`** in this folder. This document is kept for the
> deploy steps and the test wording only — **do not read its claims as working behaviour.**

**Written overnight 15–16 September 2026.** Everything below is built, builds clean on all three AutoCAD
lanes, and is **not installed**. Nothing has been deployed.

| | |
|---|---|
| **Worktree** | `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-civil-handoff-75-percent-671a19` |
| **Branch** | `claude/ce-civil-handoff-75-percent-671a19` (pushed) |
| **Commit to deploy** | **the tip of that branch.** It was **`c1af9781`** when this was written — check with `git log --oneline -1` and use what you actually see |
| **Live right now** | `817d482c` — unchanged; nothing was installed overnight |
| **Full suite (net10)** | **9042 passed / 23 failed / 17 skipped** at `c1af9781` — **+131 passing over the `326c1303` baseline, and the 23 failures are byte-for-byte the same tests that already fail there**, measured by checking that commit out into a throwaway worktree and running the same suite |
| **Builds** | net48, net8.0-windows, net10.0-windows — **0 errors** |

> **DEPLOYED 16 September 2026, 08:05 AEST.** Tim said "AutoCAD is closed, deploy" in the session, so that
> session was the one authorised to do it. Sections 1 and 2 are now history; **section 3 is the live task.**
>
> Verified at deploy: AutoCAD was not running; live was `817d482c` and had not moved overnight; the branch was
> clean and pushed; the lineage check printed nothing; and all three lane SHA256s matched the staged payload
> (Legacy `AB122FEA…`, Net8 `222F74C9…`, Modern `FF898FA2…`).
>
> **Two things the old handoff got wrong, corrected here:** `Deploy-Local-AsAdmin.ps1` has **no CE_SHARED
> line** at all — the instruction to read `0 blocked, 0 skipped` belongs to a different script, so CE_SHARED
> was checked directly instead. Civil now carries CE_SHARED stamped `c1af9781` while Manager still carries
> `817d482c`; both are assembly version `1.1.0.0`, identical in size, and
> `git diff 817d482c c1af9781 -- Shared/CE_SHARED/` is **empty** — same code, different stamp, so
> first-loaded-wins does not matter. **If CE_SHARED ever genuinely changes, Manager must be redeployed from
> the same commit.**

---

## 1. What this batch is

One payload, one tick-list — per Tim's ruling of 14 September: *"fix everything on the branch, ONE payload,
ONE consolidated tick-list; no one-fix-one-deploy."*

**This deploy installs 69 commits over the live bundle, not just the overnight batch.** Most of that work has
never been run in AutoCAD by anyone: the one-object pipe (C7), `CDTWL`, `CDDEST`, `CDDESIGN`, `CDFIXTAGS`,
split-on-draw, the LPD note, the pit label on resize, the water tank, and the pipe-grip guards for 2022–2024.
All of it is in section 3, folded in from `PENDING_TESTS.md` — that is what "one consolidated tick-list"
means here.

| Item | What it does, in drawing terms |
|---|---|
| **IFD-01** | A job now carries **its own rainfall**. New command **`CDRAINFALL`**. A job with none of its own is **told** it is using the office Melbourne curve instead of being given it silently. |
| **D2** | **Every figure says where it came from** — typed, from the rating report, measured from the drawing, required by the council, worked out from other figures, an office default, assumed, or not known. |
| **F1 + F2** | **CDCALC now produces the drainage computations sheet**, from one record shared with the plan block and the orifice detail, so they cannot disagree. |
| **BUG-156** | A network redesign no longer forgets the drawing's split answer, its recorded downpipe destinations, or its rainfall curve. |
| **What's New** | The page a colleague reads now covers this release: the per-job rainfall, the computations sheet, provenance, the top water level and downpipe destinations. |
| **Colleague-standalone guard** | CE Civil now *proves* it needs neither CE Manager nor CE Structural to run — see below. |

### The colleague-standalone gate, now measured and held

`V3_0_PLAN` §3: Version 3 is complete only when *"colleagues can install and use CE Civil without CE Manager
or CE Structural"*, and its first requirement is **"no runtime DLL or command dependency on Manager or
Structural"**.

**Measured 15 September: Civil already meets it.** Of seven mentions of the other two plugins in Civil's
source, six are comments and the seventh is `CDSURVEY` looking for CE Manager **at run time** and asking at
the command line when it is not there — which is what optional means. There is no assembly reference to
either.

**What was missing was anything holding it true.** One `using` added in passing would break a colleague's
install and would never show up on Tim's machine, because he has all three plugins. Five guard tests now hold
it, including the one that would have caught the Structural bundle's missing `CE_SHARED.dll`: **everything
Civil references must either come from AutoCAD or ship beside it.**

### The engineering reason IFD-01 matters

The plugin shipped **one** block of rainfall coefficients — the office Melbourne / OSD4W zone — and used it
for **every job in every council**. Measured against a real issued CE computations sheet it reads:

| Storm duration | CE's sheet | Plugin | |
|---:|---:|---:|---|
| 5 min | 98.6 | 105.0 | **+6.5%** |
| 15 min | 60.1 | 64.6 | **+7.6%** |
| 30 min | 40.9 | 44.4 | **+8.6%** |

Systematic and growing with duration — a different curve, not rounding. A job the plugin sized carried about
**7–9% more storage than the one CE issued**. Conservative, but not what CE issued.

**Tim's ruling, 15 September: *"yes, hold the coefficients per job."*** That is what this builds.

---

## 2. Deploy — the exact steps

**Close AutoCAD first.** The deploy script refuses to run while `acad.exe` is alive, and a build without the
skip flag would overwrite the live bundle.

```bash
cd "C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-civil-handoff-75-percent-671a19"
```

**Step 1 — prove the deploy would remove nothing that is already live.** This must print *nothing at all*:

```bash
git diff --diff-filter=D --name-only 817d482c HEAD
```

If it prints a filename, **stop** — do not deploy, and say so. *(It printed nothing when this batch was
finished at `ca7dcead`, and all four live ingredients — `10ac480d`, `fb192ec3`, `15a6d535`, `a482892a` — are
ancestors of this branch, so it is a strict content superset of what is live. Re-run it anyway at the moment
of deploying: the live bundle has moved once already without warning.)*

`Deploy-Local-AsAdmin.ps1` **will still print its "this deploy would remove work that is already live"
lineage warning**, because `817d482c` is a merge commit and is not an ancestor of this branch. On the
evidence above that warning is a false alarm — but the check is what proves it, not this sentence.

**Step 2 — build the release bundle.** *(Already done overnight at `c1af9781` and verified — the payload is
staged and waiting, so you can skip straight to step 3 unless something has changed since. Re-running it is
harmless: it carries every no-deploy flag itself and never touches the installed bundle.)*

```bash
pwsh -File Installer\build_installer.ps1
```

The overnight run finished with exit code 0 and verified all three lanes **plus the object enabler**, which
the one-object pipe steps in section J need:

| Staged file | SHA256 |
|---|---|
| `Contents\Win64\Legacy\CE_CVL_SUITE.dll` | `AB122FEA68A97C80660D92CDD4BE8925FA87CAF16111710E5EF24ACD5115B99C` |
| `Contents\Win64\Net8\CE_CVL_SUITE.dll` | `222F74C912E9609C6996097979BED78EDD0009C8A6DC412C4EDD6530B3988C66` |
| `Contents\Win64\Modern\CE_CVL_SUITE.dll` | `FF898FA297086BC4F32EDA5CEE7243AAA71C2B8FBB13BD9C86B8853C14D93344` |
| `Contents\Win64\Modern\CE_CVL_OBJECTS_2027.dbx` (the enabler) | `72194AD4243F7124700EA2B548F0BAD616468A3CCCBEE001AFDE6B91E51CF0D8` |

**`CE_SHARED.dll` is present in all three lanes** — checked deliberately, because that is exactly what the
Structural bundle is missing. The staged Modern DLL's version string is `3.0.0+c1af9781…`.

**Step 3 — install it** (as your normal user, **not** "Run as Administrator"):

```bash
pwsh -File Installer\Deploy-Local-AsAdmin.ps1
```

**Step 4 — read the output before believing it.** Two things must be true:

- the bundle DLL's **SHA256 equals the just-built bin DLL**; and
- the CE_SHARED line reads **`… 0 blocked, 0 skipped`**. Anything else means the CE plugins are on different
  CE_SHARED builds — that is not a clean deploy.

**Step 5 — confirm what actually landed:**

```bash
powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"
```

The version string ends in the commit it was built from. It should end in whatever `git log --oneline -1` showed before you built.

---

## 3. What to test in AutoCAD — the whole payload

**Read this first.** Deploying the tip of that branch installs **69 commits** of work over the live bundle, not just the
overnight batch. Most of it has **never been run in AutoCAD by anyone**. Tim's ruling of 14 September is ONE
payload and ONE consolidated tick-list, so this is that list — it folds in everything that was sitting in
`PENDING_TESTS.md` as well as what was built overnight.

Roughly 40 of those 69 commits are council research and planning documents that change no behaviour. What
follows covers the ones that do: **five newly registered commands** (`CDRAINFALL`, `CDTWL`, `CDDEST`,
`CDPIPEOBJ`, `CDC7UPGRADE`), plus `CDDESIGN` and `CDFIXTAGS`, and changed behaviour in `CD`, `CDLPD`,
`PITEDIT`, `CDWT`, `CDCALC` and the level propagation.

**Five sample coefficient files** were produced for section B. They are synthetic test files, not engineering
data for a real job.

| File | What it is |
|---|---|
| `SAMPLE_1_same_as_office.txt` | The office Melbourne block itself — loading it should give **the same rainfall as the office curve**, and CE should say exactly that |
| `SAMPLE_2_lighter_place.txt` | A different location, about 18% lighter |
| `SAMPLE_3_with_ari_column.csv` | The same numbers with a storm-frequency column and a header row, comma separated |
| `SAMPLE_4_BROKEN_only_three_rows.txt` | **Broken on purpose** — three rows instead of seven |
| `SAMPLE_5_BROKEN_wrong_order.txt` | **Broken on purpose** — rows in the wrong order |

> **A note on how to read this.** Where a step says *"Expect"*, that is what the code is written to do — not
> something anyone has watched happen. If it does something else, that is the finding, and it is worth more
> than a pass.

---

### A. Before anything else — 3 steps

1. **Confirm what actually installed.** The version string ends in the commit it was built from; it must end
   in the commit you built from.
2. **Open a drawing you know well and do nothing.** No errors on load, the CE ribbon appears, AutoCAD behaves
   normally. If anything is wrong here, stop — everything below is meaningless.
3. **Type `CDRAINFALL`.** It should exist. If "Unknown command", the bundle did not install and nothing below
   will work.

---

### B. `CDRAINFALL` — new. The rainfall a job is designed to *(both lanes)*

4. Open a drawing that already has CE drainage in it. Type **`CDRAINFALL`**.
   **Expect:** *"This job has no rainfall curve of its own, so CE is using the office Melbourne (office OSD4W
   zone) curve… it reads about 7 to 9 per cent high…"*, then intensities for a 1 in 10 year storm at 5, 10,
   15, 30 and 60 minutes. **The 5 minute figure should be about 105 mm/hr.**
5. Answer **File**, choose `SAMPLE_2_lighter_place.txt`. **Expect:** it asks *"What location are these
   coefficients for?"* with the **file name as the default**. Press Enter.
6. **Expect:** *"Read 7 storm frequencies…"*, the 1-in-10 table (**5 min now about 86 mm/hr**), a line saying
   it is **about 18 per cent lighter than the office Melbourne curve, so the storage this job needs changes
   by about the same amount**, then *"Design this job to that rainfall?"*
7. Answer **No**. **Expect:** *"Nothing was changed."* Run it again — it must **still** say the job has no
   curve of its own.
8. Run again, answer **Yes**. **Expect:** *"This job is now designed to the … rainfall curve."*
9. Run once more. **Expect:** *"Rainfall for this job uses the … curve, from the file …"* and **no warning**.
10. **Save, close, reopen, run `CDRAINFALL`.** The curve must still be there.
11. `SAMPLE_1_same_as_office.txt` → accepted, and the difference line says it gives **the same rainfall as the
    office Melbourne curve**.
12. `SAMPLE_3_with_ari_column.csv` → accepted (header row and frequency column both handled).
13. `SAMPLE_4_BROKEN_only_three_rows.txt` → *"needs 7 rows… 3 rows of numbers found. Nothing has been
    stored."* Then confirm the **previous** curve is untouched.
14. `SAMPLE_5_BROKEN_wrong_order.txt` → refused for being **out of order**; again nothing stored.
15. **Clipboard:** open a sample file, copy the seven rows, `CDRAINFALL` → **Clipboard**. Same flow.
16. With nothing copied, `CDRAINFALL` → **Clipboard** → *"There is nothing copied at the moment…"*
17. `CDRAINFALL` → **Clear** → **Yes** → back to the office-curve message.
18. `CDRAINFALL` → **Clear** on a job with no curve → *"…there is nothing to clear."*
19. `CDRAINFALL` → press **Enter** (default is Leave) → *"Nothing was changed."*
20. **Empty new drawing, no CE records:** `CDRAINFALL` → File → good file → Yes.
    **Expect:** *"…could not be recorded because this drawing has no CE records yet…"* — not a crash.

### C. The rainfall actually changes the design

21. On a job with **no** curve, run **`CDDESIGN`** through to the design. **Expect:** a note saying *"This job
    has no rainfall curve of its own…"*
22. Note the **storage required**. Set the 18%-lighter curve, run `CDDESIGN` again.
    **Expect: storage required goes DOWN** by roughly the same proportion. **If it does not move at all, the
    curve is not reaching the calculation — that is a failure, report it.**
23. Set `SAMPLE_1_same_as_office.txt`, run again. **Expect:** back to the **original** figure, and the "no
    rainfall curve" note is **gone**.

### D. `CDCALC` — the computations sheet *(new)*

24. `CDCALC` on a job with a detention system, filled in as usual. **Export PDF**, then **Export XLSX**.
    **Expect:** the export now **leads** with a **DRAINAGE COMPUTATIONS** sheet under **CREATIVE
    ENGINEERING**. In the XLSX it is the first tab, named **Computations**.
25. Header carries job number, site, **council**, engineer, revision, date, page, and an issue line reading
    **`DRAFT — NOT FOR CONSTRUCTION`** on an unissued sheet.
26. **BASIS OF DESIGN** names the storm frequency, **which rainfall curve**, and Boyd's method.
27. **Permissible site discharge** and **Storage required** each carry **the council's name in brackets**.
28. **STORAGE PROVIDED**: in the pipe runs / in the pits / in tanks and anything else / **TOTAL**, in both
    litres and m³ — and the total really is the three added up.
29. Make the storage **short on purpose** (reduce the pipes). **Expect:** *"THIS IS SHORT… by N L"* naming
    **how much**.
30. **VOLUME OF PIPE** (by diameter, smallest first) and **VOLUME OF PIT** tables are present.
31. **ORIFICE** block: **plate height will say "not known"** — that is correct and deliberate. Head,
    diameter, Co and flow should all be there.
32. The sheet **ends** with **WHERE THESE FIGURES CAME FROM**.
33. On a job with no rainfall curve, the header carries **`THIS SHEET HAS FIGURES THAT ARE NOT SETTLED`**.
    Set a curve, re-export — if nothing else is unsettled that line should be **gone**.
34. **Leave the council unset** and export. **Expect:** the sheet still comes out, PSD reads **"not known"** —
    **never `0`** — and the last block names it as not established. **Nothing blocked.**

### E. `CDTWL` — new. Top water level *(was on hold; the hold is lifted)*

35. `CDTWL` on a job with a detention pit or tank. **Expect:** it **offers every level the system could be
    held to, each with where it came from**, and does **not** assert one. The rulebook's usual figure (the
    obvert of the highest detention pipe) is offered and **labelled as the usual rule**, not applied.
36. Pick one. **Expect:** the storage below it, the head on the orifice, and any pit the water would come up
    out of. **It must change nothing in the drawing.**
37. Run it on a job with a **trench grate sitting above the highest pipe obvert** — the case that reopened
    this rule. The grate level must be among the candidates.

### F. `CDDEST` — new. Where each downpipe goes

38. `CDDEST` on a job with downpipes and drawn pipes. **Expect:** it follows the drawn pipes and says where
    each downpipe ends up — a tank, or out to the legal point of discharge.
39. Where the trail cannot be followed, **it names where it stopped** rather than guessing.
40. Where **more than one pipe leaves a source**, it reports a **Split** and does not pick one.
41. It offers to **record** those answers against the drawing. Accept, then re-run — the recorded answer is
    used.

### G. `CDDESIGN` — new. The design workflow

42. `CDDESIGN` on a job. **Expect:** it asks only for **what is missing**, and makes you **confirm the legal
    point of discharge**.
43. Give it a **roof area larger than the site**. **Expect:** it refuses that figure **without silently
    shrinking your number**.
44. It finishes by saying **nothing was drawn**. **Confirm the drawing is untouched.**
45. **The rating report offer:** on a job whose folder holds a STORM or Blue Factor report, CE should **offer**
    the site and roof areas from it — and must **never open anything in a client folder until you say yes**.
46. Where the report and what you typed **disagree**, it shows **both** and you pick; keeping what you typed
    is the default.
47. The council is filled in **only on an exact match** — a near-miss must never load a rulebook.

### H. `CDFIXTAGS` and repeated source names

48. In the job that failed before: `CDFW` at a free point, then on a pipe run, then on a free pipe end.
    **Each must place** (this was BUG-154).
49. After each placement the command line **names the repeated source name**, says **nothing was stopped by
    it**, and offers `CDFIXTAGS`.
50. `CDFIXTAGS` lists the repeated names and their blocks, proposes renames, and **changes nothing on No**.
51. Run again, answer **Yes** — the renamed blocks show their new labels.

### I. Splitting a pipe drawn across pits

52. Three pits in a line; draw **ONE** pipe through all three. **Expect:** it asks once. Answer **Yes** →
    four pipes, four schedule rows, and the middle pits have a pipe in and out.
53. Draw another across pits: **it must not ask again**.
54. In a **new drawing** answer **No** first time → stays one pipe, and does not ask again.
55. A pipe that starts and ends on pits but crosses nothing: says nothing, splits nothing.
56. **Escape** at the question: nothing split, pipe intact.

### J. The one-object pipe *(2027 only — the enabler was rebuilt and staged, so this is testable)*

57. `CDC7UPGRADE` a pipe, then `CDFW` on it. **Both halves must be CE pipe objects.**
58. **Move the top half aside and check there is no stray pipe underneath** — that is the whole point of it.
59. Labels and invert texts end on the **correct halves**; the new invert appears **both sides** of the floor
    waste. A **twin barrel** still draws as twins after the split.
60. Do the same on an **unconverted** pipe and confirm **nothing about it changed**.

### K. `CDLPD` — the legal point of discharge note

61. `CDLPD`, pick the street pipe end. **Expect** the list now offers **CouncilStub, ExistingStub, Easement**
    as well as Kerb / CouncilPipe / SideEntry.
62. Choose **CouncilStub**. The callout must read
    `CONNECT TO COUNCIL STUB AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS
    PRIOR TO THE COMMENCEMENT OF WORK.` with the level to **two decimals**.
63. Run it on a pipe end whose invert is **not set**. The note still appears and simply **leaves the level
    clause out** — no `IL m`, no zero.

### L. Pits, tanks and levels

64. **`PITEDIT` a 450 pit to 1200.** The label circle **steps out and keeps its distance from the pit**, like
    the cover level text. Check the CE log line `ShiftAnnotation [pit label]`.
65. **`CDWT`** — place a water tank. Its plan block and its details come from the Civil Standard Details
    folder. Check the callout, the riser and the dropper.
66. **A tank's storage is now counted.** On a job with a tank, check the detention total **includes** it —
    before this, tank-heavy jobs under-counted their own storage.
67. **Levels set by hand:** set an invert level by hand, then run the propagation. **The drawing and the
    record must agree.** Previously the drawing was written and the record refused it, silently.

### M. The 2022–2024 lane *(net48 — Tim ruled these users are in scope)*

68. On **AutoCAD 2024**: the plugin loads, the ribbon appears, no errors.
69. **`CDRAINFALL`** — repeat steps 4 to 9.
70. **Pipe grips (OVR-01):** drag a pipe end grip. **Expect:** the pipe **cannot be lifted off the plan**
    (its Z is flattened) and **cannot be collapsed** to nothing — a minimum of 1 mm is kept.
71. `CD`, `CDLPD`, `PITEDIT` behave as they do on 2027.

### N. Nothing that already worked has moved

72. Open a job you know well **with no rainfall curve set**. Run its detention calculation.
    **Expect: exactly the same numbers as before this update.** Any movement at all on a job with no curve of
    its own is a fault — report it.
73. Draw a pipe, edit a pipe, edit a pit, run the schedule. All as before.
74. **One accepted edit = one Undo**, throughout.

### O. A redesign must not forget things (BUG-156)

75. On one drawing: record a downpipe destination with `CDDEST`, answer the split-on-draw question, and set a
    rainfall curve.
76. Run a **network redesign and apply it**.
77. **Expect:** `CDDEST` still shows the recorded destination; the split question is **not** asked again; and
    `CDRAINFALL` still reports the job's own curve. **Before this fix all three were lost.**

---

**If you only have an hour**, do A (1–3), B (4–10), C (21–23), D (24–29), N (72–74) and O (75–77). Those cover
the new engineering, the new document, and whether anything old broke.

## 3b. Release notes and known limitations

`CHANGELOG.md` in the repo now carries this release's entry and a **Known limitations** section written for a
colleague rather than for us. It is the plain-English version of section 4 below, and it is the thing to hand
anybody who starts using this. The plugin's own **What's New** page also now covers this release.

## 4. What is NOT done, and is honest about it

- **Where new coefficient blocks come from** is still open. The Bureau publishes IFD data per location; the
  fitted 7 × 7 block is CE's own derivation from it, and **how that fit was produced is not recorded anywhere
  CE still has**. **No fitting method has been invented.** A block pasted by hand per job — exactly what the
  office spreadsheet already did — makes the plugin correct per job without needing that answer, so that is
  what was built. **This needs Tim.**
- **The plate height on the orifice** is not held by CDCALC, only the head. Recorded, not guessed.
- **The critical storm duration** is worked out by the sweep but is not carried through to the sheet's
  summary. Small change, not done tonight.
- **PSD provenance** reads "required by <council>" whenever a council is named on the job. That is the
  strongest honest claim the calculation window supports today; it does not yet prove the figure came from
  the council rulebook. That belongs with the council rulebook workstream (F4).
- **Two tank block names are still unreadable** — `A$C1cba1a13` and `A$C72c6940a`. Still needs Tim.
- **Structural packaging** still has no release script and its bundle carries no `CE_SHARED.dll`, so a joint
  Civil + Structural release from one commit is still blocked.

---

## 5. Evidence behind the claims above

- **Builds:** net48, net8.0-windows and net10.0-windows — **0 errors** on all three.
- **Tests:** full Drainage suite on net10, plus five new colleague-standalone guards. The **23 failures are byte-for-byte the same tests** that already
  fail at `326c1303`, measured by checking that commit out into a throwaway worktree and running the same
  suite there. **No new failure was introduced.**
- **The office curve's own numbers are unchanged**, proven by running the new code against the un-refactored
  service before changing it, at 1e-12 across all seven storm frequencies and nine durations, and by the
  existing characterisation test that pins the 6.5–8.6% gap against CE's real sheet.
- **DATA-01:** every test fixture is synthetic. No client name, address or job address appears anywhere.
