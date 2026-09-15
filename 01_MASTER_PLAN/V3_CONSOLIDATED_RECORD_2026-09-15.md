# CE_ACAD_PLUGIN — Version 3 consolidated record

**Read-only reconciliation, 15 September 2026.** No code changed, no branch merged, no build, no deploy.
Sources are named against every statement. Where a record could not be reached, it is listed in section E as a
gap rather than filled in.

---

## 0. STOP AND READ FIRST — the live bundle is not what the register says

The deploy register (#78) body says the live Civil bundle is `6a6d6bc7`, deployed 13:09. **It is not, and has not
been since 14:46 today.**

Measured from the installed bundle itself, not from any document:

| Evidence | Value |
|---|---|
| Installed `CE_CVL_SUITE.dll` (Modern) product version | **`3.0.0+10ac480df838edfe48c09334ad8837a347c4d528`** |
| File written | **15 Sep 14:46:05** |
| Modern / Net8 / Legacy SHA256 (first 16) | `EC84FFCA9557E9FD` / `BC8D99AE654F0E34` / `7B44D6BF0E51C2FD` |
| Rollback archive present | `CE_CVL_SUITE_PRE_10ac480d_20260915_144647.backup` |

**Today's real deploy sequence**, read from the rollback archive names on disk:

| Time | Commit deployed | In the register? |
|---|---|---|
| 10:19 | `8e52bb56` | yes (#24) |
| 10:53 | `8c9f6833` | yes (#24) |
| 11:17 | `38842c9c` | yes (#24) |
| 13:09 | `6a6d6bc7` | yes (#78 body — **now stale**) |
| 14:29 | `63bc7207` — PIT preview pane enlarged (#75) | **NO** |
| **14:46** | **`10ac480d` — CDPARTS Save + Reset to Defaults** | **NO — this is live now** |

Two deployments happened after the register was last updated and neither was recorded there. This is precisely
the failure #78 exists to prevent, and it is the reason the UI chat's "registered Civil live remains `10ac480d`"
reads as a contradiction of #78 when it is in fact **correct**.

### What this means for the C7/behaviour branch

`claude/c7-one-object` is **2 behind / 42 ahead** of the real live commit. The two live-only commits are
`63bc7207` and `10ac480d`. Under #78's own rule — *"if your branch is behind live, deploying it silently rolls
back whatever live has that you don't"* — **that branch is not combine-ready until it is rebased onto
`10ac480d`.** Any earlier statement in this session that it was "0 behind" was true against `6a6d6bc7` and is
now superseded.

### A second records fault: one bug number, two different bugs

| Number | Fault | Chat | Where |
|---|---|---|---|
| **BUG-152** | CDPARTS Save looked successful when it failed | CDPARTS chat | live `10ac480d` |
| **BUG-152** | CDFW/CDSOURCE would not place while four blocks shared the name 'AGI' | C7 chat | `claude/c7-one-object` |

Two unrelated faults share one number on the same day. Both regression entries are real; the numbering is not.
This must be resolved before the two histories are combined, or the log becomes unreadable.

### Native mismatch already present

The installed enabler `CE_CVL_OBJECTS_2027.dbx` is `667384066987062B`, dated **10:40** — it predates the last
three managed deployments. The C7 branch raises the enabler to **API version 3**. When that branch ships, the
enabler **must be rebuilt and shipped with it**; a v1/v2 enabler refuses the new operations in words rather than
misbehaving, but converted pipes then cannot be split.

---

## A. The Version 3 plan on one page

**Source:** `docs/V3_0_PLAN.md` §3, §5, §6, §11.

**What Version 3 is.** Colleagues can install and use CE Civil **without CE Manager or CE Structural**: its own
ribbon and command loading, no runtime dependency on the other two, reliable native grips and previews, complete
Pipe/Pit/CDEDIT workflows, evidence-driven Drawing Intelligence with no nearest-object guessing, visible Unknown
and provenance instead of invented values, safe Preview/Cancel/one-Undo, independent source and package audits,
standalone install/help/diagnostics/rollback, then Tim acceptance and a colleague pilot.

**The data spine — the shape everything hangs off:**

~~~text
Project sources + accepted user decisions
        ↓
Evidence + provenance + confidence + revision
        ↓
Stable Civil identity + relationships
        ↓
Canonical engineering data
        ↓
Drawing presentation + regenerable views
        ↓
QA + review + schedule + profile + calculation outputs
~~~

**The eight non-negotiable rules** (V3_0_PLAN §5): engineering data and presentation are separate · stable
identity outranks proximity · touching may prove a connection, **crossing alone does not** · Xrefs are evidence,
never live connection targets · important values expose provenance · Unknown / Assumed / Manual-Pinned / Display
Override stay distinct · accepted manual edits outrank later imports until reviewed · **one accepted operation =
one AutoCAD Undo**.

**The eight completion gates** (§6) — every item holds these separately, and only the last counts as 100%:

`Behaviour approved` → `Source complete` → `Integrated` → `Source audited` → `Package audited` →
`Tim accepted` → `Staff pilot accepted` → `Staff ready`

**The thirteen guided-workflow areas** (§11) — A Project setup · B Survey and imports · **C Legal point of
discharge** · D Catchments and CDCALC · **E Pits/pipes/grades/labels (the only ACTIVE area)** · F OSD and
detention · G Water tanks · H Pump stations · I WSUD · J Overland flow · K Profiles · L Schedules and issue QA ·
M Repair and legacy. **Twelve of the thirteen are "Planned".**

**Route** (#24): C0 → C1 + C2 (+R1) → C3 → C4 → C5 → C6 → Structural pilot → office pilot → single ribbon.
**Tim, 5 Sept: issue CE Manager + Civil to colleagues FIRST; Structural after.**

**Recorded progress** (§12, 1 Sept estimate, not re-measured since): behaviour/planning ~95%, intelligence and
source ~65%, UI/UX ~35%, **AutoCAD/staff acceptance ~20%**. Overall ~50%.

---

## B. Decision register

Tim's words are in **bold quotes**. Anything not quoted is an assistant proposal or interpretation and is marked
as such. A superseded answer is kept, with the date and source that replaced it.

### B1. Ownership and working method

| Topic | Question asked | Tim's answer | Final decision | Date / source | Superseded? |
|---|---|---|---|---|---|
| Ownership split | Who builds windows, who builds behaviour? | **"ownership = B"** | **Codex builds windows; Claude owns behaviour, spine, commands, services, rules, native objects and deploys** | 15 Sep, #24 comment 00:54 | **Supersedes** the 4 Sept reverse-ownership records and memory `civil-uiux-ownership-boundary` |
| Water Tank owner | — | recorded, not quoted | **CDWT stays Claude-owned** | 15 Sep, `CIVIL_EDIT_SAVE_RETURN_HANDOFF_20260915` | no |
| #77 overrules owner | Codex or Claude? | corrected same day | **Claude** — overrules are behaviour | 15 Sep, #24 comment 00:56 | **Supersedes** the comment 2 minutes earlier saying Codex |
| net48 / 2022–24 users | In scope? | **"2022-2024 users ARE in scope"** | In scope via overrules (#77). Test Days must include a **2024 (net48) pass** | 15 Sep, #24 / #25 / #77 | **Narrows** the 5 Sept 2027-only ruling |
| Testing cadence | One fix at a time, or batch? | build it ALL, ONE payload, test at the end | Fix everything on the branch, one payload, one consolidated tick-list | 14–15 Sep, #24 + REGRESSION_LOG R2 | Supersedes one-fix-one-deploy |
| Deployment | — | must state AutoCAD is closed | **Only Claude deploys, only on Tim's explicit closed-AutoCAD phrase, with hash readback** | #24 working rule 3 | no |
| Worker count | — | go easy on parallel agents | Two active workers by default, disjoint files | #24 working rule 2 | no |
| Deletion | — | — | **No working copy, chat or branch may be deleted** by a reconciliation | #24 working rule 6 | no |
| Full-function preservation | — | Tim, 4 Sept | **Before any window or command is replaced, every button, field, grip, prompt, right-click and double-click route is listed as Kept / Moved / Combined / Replaced / Retired. Retired only with Tim's explicit approval.** Visual tidying never removes a capability | 4 Sept, #24 working rule 7 | no |

### B2. Engineering rulings

| Topic | Question | Tim's answer | Final decision | Date / source | Superseded? |
|---|---|---|---|---|---|
| Model of record | LandXML-first or DWG? | D9 | **Keep DWG geometry as the model.** LandXML-first rejected | 4 Sept, #24 | no |
| Settings-first | Where do engineering values live? | R-00 | **Every engineering and council value lives on the Settings page. Nothing hard-coded** | week-2 rulings, #25 | no |
| Hard blocks | How strict? | R-27 | **No hard blocks. Warn and record.** Only two exist: deleting spine IDs, and pushing an update on a failed build | #24 / #25 | no |
| Pit drop | — | Tim, 4 Sept | **20 mm default, project-adjustable; lowest incoming pipe governs; main outlet only** | 4 Sept, #24 | no |
| Plan label authority | Label or stored ID? | Tim, 14 Sept | **The plan label is the authority.** The record follows the label; never rewrite plan text to match a record | 14 Sept | no |
| Pipe fit into pit | Pipe wider than the pit side | ruling 3 | **Ask to upsize** to the next Settings size. Warning only, never automatic | 15 Sep, BUG-138 | no |
| Twin barrels | Two pipes or one? | Tim, 15 Sep | **A twin barrel is ONE pipe object** holding both barrels; 50 mm clear gap; a band down each barrel; grips on the central non-print line | 15 Sep, BUG-150 | no |
| CDBREAK | — | Tim, 5 Sept | **Logical junction YES**; sources auto-connect; CDPIPE folds into CD | 5 Sept | no |
| Split on draw | Pipe drawn across pits | *"it crosses or intercepts with pits along the way"* | **Split at every pit / IO / FW crossed. Ask the first time and remember** | 15 Sep | no |
| **TWL definition** | What sets the top water level? | **"the TWL could be something other than the obvert of the highest detention pipe ... we had a trench grate which was a higher level than the detention obvert of the highest pipe in the system in this case we have to be careful"** | **The TWL is NOT always the pipe obvert.** The rulebook default is ONE candidate; a trench grate or other higher element can govern. CE must present the candidates and let Tim confirm — it must never assert one | **15 Sep, this session** | **Supersedes** `ENGINEERING_RULEBOOK` item 7 read as absolute, AND supersedes the volume-solved TWL proposed earlier this session |
| TWL vs floor level | Is floor level part of it? | **"WHY DO WE NEED FLOOR LEVEL FOR TWL?"** | **Floor level is NOT part of the TWL.** The check is freeboard below the **pit cover**. The floor-level line in `CDWT_DETENTION_TWL_PLAN.md` was wrong and is withdrawn | 15 Sep, this session | **Supersedes** that plan's checklist |

### B3. Tanks — answered 15 September 2026

| # | Question | Tim's answer | Consequence |
|---|---|---|---|
| 15 | Stretch blocks to size, or draw outline and use the block as a symbol? | **"stretching"** | Settles **T-01**. Five blocks, 34 real sizes — the block is scaled to the library L x W |
| 16 | Concrete tanks under driveways, or garden only? | **"it can depend on what tank has been specified by the architect, or specified by us. the lids need to be trafficable and some poly tanks have trafficable lids"** | **Trafficable is a property of the specified tank, not of its material.** CE carries a flag and must never infer it from concrete-vs-poly |
| 17 | Rename `A$C1cba1a13` / `A$C72c6940a`? | **"they can"** | New names still needed before the tank list can show them properly |
| 18 | Ten of 221 STORM reports come out below 100 — drafts or real? | **"the latest dated file is the most current"** | CE reads the **most recently dated** report and says which it used. A low rating is not itself a reason to skip a file |
| 19 | Sweep live jobs for tanks whose numbers disagree? | **"leave them, let's work for future projects"** | **No back-fix pass.** Forward-only: deriving re-use from total minus detention (T-02) stops recurrence |

### B4. Roof areas, downpipes and the LPD — answered 15 September 2026

| # | Question | Tim's answer | Consequence |
|---|---|---|---|
| 1 | Can CE read the ESD report from a folder? | **"CE COULD READ FROM FOLDER, TRY TO FIND ONE"** | **Found.** 533 jobs carry `<job>/Civil/STORM Report - WSUD/`. The PDFs have a real text layer. The table gives each catchment its impervious area and Treatment Type (Rainwater Tank / None), plus municipality and allotment site area |
| 2 | Can one downpipe split between tank and LPD? | **"ITS ALWAYS ONE DESTINATION"** | Tank-connected vs bypass roof is a **clean sum**, not an allocation problem |
| 3 | Roof area per downpipe, or ESD total per catchment? | **"ESD TOTAL PER CATCHMENT I THINK ITS A EASY CALC THOUGH"** | CE takes catchment totals; something must still record which downpipes belong to each catchment |
| 4 | One LPD per job, or more? | **"IT CAN HAVE MORE THAN ONE BUT OFTEN JUST ONE"** | Matches the existing `CV-01H5` plan: each outlet keeps its own authority, every pit and pipe belongs to exactly one |
| — | What must the LPD carry? | **"LPD IS NOT A REAL OBJECT BUT WE NEED A WAY TO SHOW THE PLUGIN WHERE IT IS AND WHAT LEVEL IT IS AT, WE ALSO NEED A WAY TO DENOTE AND IT ALSO HAS A TYPICAL NOTE WE PUT ON THE DRAWING"** | Four things: **position, level, denotation, typical note.** Today it is a bare text label on `GUIDELINES` |

**LPD note wording recovered from real jobs this session** (de-identified; source = corpus entity dumps):

| Job | Recorded text |
|---|---|
| 25-06 | `CONNECT TO EXISTING STUB AT APPROX IL594.03m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` |
| 2648 | `CONNECT TO COUNCIL STUB AT APPROX IL11.97m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` |
| 2648 | `EXISTING 450 DIA. COUNCIL PIPE` |
| 2602 | `2.0m WIDE DRAINAGE EASEMENT` |
| 25-06 / 22547 / 2603 | `KERB`, `STUB`, `LPD` |

Connection types observed: **existing stub · council stub · council pipe · kerb · easement.**
The note pattern is `CONNECT TO {type} AT APPROX IL{level}m TO COUNCIL SATISFACTION.` plus fixed boilerplate —
i.e. **a type and a level plus standard wording**, exactly what CV13 already proposes to store.

### B5. UI and presentation rulings

| Topic | Tim's answer | Date / source |
|---|---|---|
| No scrolling | Every CE window non-scrollable; everything visible on open; add tabs, never scrollbars or collapsed expanders | 4 Sept |
| Cockpit test | Judge every window as an instrument used 30x a day: same layout every open, quiet unless one decision, one glance answers "am I OK" | 4 Sept |
| Plain English | **No software jargon anywhere a user reads.** AutoCAD and engineering terms only | 4 Sept |
| Emphasis | Use colour, bold and highlight where attention is needed — decisions, Unknowns, Cannot save, changed values. Calm is not flat grey | 4 Sept |
| Palette | Accent gold on dark; CE deep blue `#1E5AA8` on light. **Tim dislikes teal** | 4 Sept |
| Ribbon | Single CE tab plus contextual tabs (R1 / #60) | 5 Sept |
| Icons | Full icon family required in the next release — 205 designs / 410 symbols. **"LOOKS GOOD LETS PROCEED PLEASE"** | 9 Sept, #24 |
| Questions to Tim | **"WORD THE QUESTIONS ALL THE TIME WITH CONTEXT AND SIMPLE PLAIN ENGLISH WITH NO SOFTWARE JARGON"** | 15 Sep, this session |

---

## C. Feature and window register

**Approved** = Tim's behaviour decision recorded. **Built** = source complete. **Connected** = reachable and
wired in the running product. **Deployed** = present in the installed bundle. **Accepted** = Tim passed it in
AutoCAD on a real drawing. These are five separate facts and a green build proves only the second.

### C1. Civil commands — behaviour lane (Claude)

| Command / window | Intended behaviour | Approved | Built | Connected | Deployed | Tim accepted | Remaining |
|---|---|---|---|---|---|---|---|
| **CD** (draw pipe) | Draw a pipe run, annotate, schedule | yes | yes | yes | yes | partly (R1–R5 rounds) | split-on-draw untested |
| **CD split-on-draw** | Pipe drawn across pits splits at each; ask once, remember | yes (15 Sep) | yes | yes | **no** | **no** | AutoCAD test |
| **CDFW / CDSOURCE** | Place floor waste / source; land on pit, pipe end or pipe run | yes | yes | yes | partly | **FAILED R4/R5 — refused to place anywhere** | BUG-152 fix untested |
| **CDFIXTAGS** (new) | List source names on more than one block, offer to renumber | yes (15 Sep) | yes | yes | **no** | **no** | AutoCAD test |
| **CDTWL** (new) | Top water level and storage check for a detention system | **partly — TWL definition reopened 15 Sep** | yes | yes | **no** | **no** | **Rework for the trench-grate case first** |
| **CDDESIGN** | Guided design: job, council, LPD, areas, route, detention, calculate | yes (card #45) | behaviour only | command line only | **no** | **no** | Codex window from `CDDESIGN_WINDOW_CONTRACT.md` |
| **CDEDIT** (pipe) | Edit a pipe; Update must honour a refused write | yes | yes | yes | yes | partly | **Update discards its false result and prints "Pipe updated"** |
| **PITEDIT** | Edit a pit; truthful outcome for the complete edit | yes | yes | yes | yes | partly | truthful outcome; label re-place on resize |
| **CDWT** (water tank) | Place tank at true plan size, derive re-use volume | yes | partly | yes | yes | **no** | **T-01 stretch-to-size; trafficable flag; tank not counted by CDTWL** |
| **CDLPD** | Legal point of discharge marker | yes | marker only | yes | yes | — | **no stored level, no connection type, no generated note** |
| **CDCALC** | Detention and calculation workspace | yes | yes | yes | yes | in use | TWL reconciliation; hard-coded 150 mm freeboard |
| **CDPARTS** | Parts catalogue; Save and Reset to Defaults | yes | yes | yes | **yes (live 10ac480d)** | **no** | AutoCAD test |
| **CDC7UPGRADE / CDPIPEOBJ** | CE pipe as one AutoCAD object | yes (card #74) | yes | yes | partly | **no** | **enabler API 3 must ship**; auto-upgrade stays OFF |
| **CDCHECK** | Network check, jump and actions | yes | partly | yes | yes | partly | converted-pipe writes |
| **CDPROFILE** | Long sections | yes | strong source | partial | partly | **no** | drawing workflow |
| **CDSLAB / slab system** | Slab and spoon drains | yes | strong source | partial | partly | **no** | drawing insertion, regeneration |
| **CDIMPORT / survey** | Unified reviewed import | yes | partial | partial | partly | **no** | unified path |
| **CDREPAIR** | Read-only scan then reviewed repair | yes | partial | partial | partly | **no** | unified command |
| **CDHELP / support** | Plain-language help and error reporting | requirement only | **no** | **no** | **no** | **no** | all of it |

### C2. Windows lane (Codex)

| Window | Chunk | Approved | Built | Connected | Deployed | Tim accepted | Remaining |
|---|---|---|---|---|---|---|---|
| 01 Ribbon (single CE tab + contextual) | R1 #60 | yes | partly | partly | partly | **no** | standalone ribbon unproven without Manager |
| 02 Pipe · 03 Pit · 04 Edit doorway · 05 Civil Properties | C2 #28 | yes | partly | yes | partly | **no** | typed save outcomes from the owner |
| 06 Sources · 07 Water Tank | C3 #29 | yes | partly | partly | **no** | **no** | source draft/preview/identity contract |
| 08 Slab · 13 Intake · 14 Settings · 15 Repair | C5 #32 | yes | partly | partly | **no** | **no** | importer/repair behaviour |
| 09 Review · 10 Calcs and Profiles · 11 Proposals · 12 Pit Schedule | C4 #30 | yes | partly | partly | **no** | **no** | rule consumers |
| 16 Help / Manager / Ask CE / What's New / Feedback | M1 #36 | yes | partly | partly | partly | **no** | update channel |
| 17 CDDESIGN (Start / During / Finish) | 0A | yes (card #45) | **no** | **no** | **no** | **no** | build from the contract |
| **PIT block preview** | #75 | yes | yes | yes | **yes (63bc7207, 14:29)** | 7 of 8 checks passed | **no-scroll failure OPEN**; AutoCAD 2024 check not done |

### C3. UI connection recovery — the current Codex candidate

**Source:** `UI_CONNECTION_RECOVERY_ACCEPTANCE_20260915.md`, `..._REMAINDER_...`, `UI_CANDIDATE_INSTALLED_BASELINE_AUDIT_...`

Five recoveries combined on baseline `10ac480d`: Pipe arrow draft return · Manager Escape · Sheets input refusal ·
Settings confirmed save · Issue Back draft.

**Explicit limits recorded by its own author:**
- PIT no-scroll failure remains open; the candidate inherits the taller preview and makes no acceptance claim.
- No held workflow activation, no new source editor, no catalogue scope system, no native enabler import.
- **A green source build is not payload verification.**
- Tim tests AutoCAD; focused tests establish only helper/handler/state/file evidence. **No overall V3-completion claim.**

**Not recovered** (kept visible rather than declared done): Manager unavailable-settings message · Project Setup
missing-templates state · Issue blocker status text and Show Problems · Reissue focus navigation · full
drawing/layout selection display · selected-sheet empty/clean feedback · the proposed read-only Before/After
review window (a **new** window, not a missing writer — Apply stays excluded) · Sheets/Issue and Shared Notes
appearance.

### C4. The Structural blocker on that candidate — do not skip this

**Source:** `UI_CANDIDATE_INSTALLED_BASELINE_AUDIT_20260915.md`, plus the Structural owner reply on #78.

| Installed module | Source commit | Relationship to the candidate |
|---|---|---|
| Manager, all lanes | `96e7d76a` | ancestor; **57 files differ** |
| **Structural, Modern** | **`5d723d41`** | **NOT an ancestor; 223 files differ** |
| Civil, all lanes | `10ac480d` | the candidate baseline |

The candidate **deletes** `SbeamCommandRunner.cs`, `SbeamEditCommandRunner.cs` and
`ArchitecturalChangeReviewCommands.cs` relative to the installed Structural source, and changes
`BeamPlacementCommands.cs`. The installed side also carries the CE idle-work safety change at `5d723d41`.

> **Do not replace the installed Structural bundle with a build of this candidate as-is.**

The Structural owner has ruled: **preserve `5d723d41` exactly**; adapt narrow Settings/standalone-window hunks
only; **never replace SettingsService wholesale**. Project/Sheets cannot move alone — installed `5d` has no
`CeProjectSheetsWorkspaceView` or bridge, and the candidate adds 387 XAML + 3,075 code-behind + 159 bridge lines.
Those patches are **banked pending an explicit integration-baseline choice by Tim.**

Shared library hashes also differ on disk between the Manager and Civil bundles (Modern `75A26D3D…` vs
`C4D7E1AF…`). Different hashes do not prove incompatibility — they prove **a single shared payload identity has
never been established.** Do not copy a shared DLL speculatively.

---

## D. Ownership map

**Authority: Tim's ruling B, 15 September 2026 (#24 comment 00:54), plus its correction at 00:56.**
Every earlier document describing a different split is superseded.

| Lane | Owner | Covers |
|---|---|---|
| **Windows** | **Codex** | Every WPF window, view model, XAML, control, appearance, layout, ribbon visuals. Windows 01–17 |
| **Behaviour / spine / deploys** | **Claude** | Commands, services, rules, native objects and the enabler, project data and spine identity, link records, the update channel, and **every deployment** |
| **Water Tank (CDWT)** | **Claude** | Explicitly recorded, even though 07 Water Tank is a Codex window |
| **Overrules (#77, OVR-01)** | **Claude** | Corrected 15 Sep — overrules are behaviour, not windows |
| **C7 one-object (#74, #76 OPM)** | **Claude**, the C7 chat | Native enabler, pipe object, grips, split |
| **Pit block preview (#75)** | **Codex** | After Claude supplied the native probe |
| **Structural runtime** | **Claude**, later | Not yet started |
| **Structural source baseline** | the Structural owner | Has ruled `5d723d41` is preserved exactly |

**Boundary rules that follow from ruling B:**
- A window must never contain an engineering decision. It calls a rule; the rule lives in the behaviour lane.
- A behaviour chat must never edit a window file (`Dialogs/`, `Controls/`, `ViewModels/`).
- Where the two must meet, the behaviour lane publishes a **written contract** — e.g.
  `docs/workflows/CDDESIGN_WINDOW_CONTRACT.md` — and the window is built from it.
- Only the behaviour lane deploys, and only on Tim's fresh explicit AutoCAD-closed instruction.

---

## E. Conflicts, gaps and unanswered decisions

### E1. Conflicts that must be resolved before anything is combined

| # | Conflict | Detail | Who resolves |
|---|---|---|---|
| **E1.1** | **The deploy register is stale** | #78 body says live is `6a6d6bc7`. The installed DLL says `3.0.0+10ac480d`, written 14:46. Two deploys (`63bc7207` 14:29, `10ac480d` 14:46) were never recorded | whoever deployed them, on #78, today |
| **E1.2** | **BUG-152 used twice** | CDPARTS Save (live `10ac480d`) and CDFW duplicate-tag (`claude/c7-one-object`). Two unrelated faults, one number, same day | the two chats, before combining |
| **E1.3** | **C7 branch is 2 behind live** | Deploying it as-is would roll back CDPARTS Save/Reset and the enlarged PIT preview | C7 chat — rebase onto `10ac480d` |
| **E1.4** | **Enabler older than the managed code it serves** | Installed `.dbx` is `667384066987062B` from 10:40; three managed deploys have landed since. C7 needs API v3 | C7 chat, at its deploy |
| **E1.5** | **TWL definition reopened** | `ENGINEERING_RULEBOOK` item 7 says obvert of the highest pipe. Tim: a trench grate can sit higher. The rule is a default, not a law | **Tim — see F1** |
| **E1.6** | **Two TWL numbers in the product** | CDCALC computes obvert-of-highest-pipe; CDTWL (unshipped) computes a volume-filled level. The number sets the baffle crest and therefore the orifice size | **Tim — see F1** |
| **E1.7** | **Structural candidate deletes installed commands** | SBEAM runners absent from the UI candidate; installed Structural `5d723d41` is not an ancestor | Structural owner + Tim |
| **E1.8** | **Shared payload identity never established** | `CE_SHARED.dll` differs between the Manager and Civil bundles on disk | deployment owner |
| **E1.9** | **Guidebook edition** | The overflow rule CDTWL cites comes from guidebook **v1 (2024)**; **v1.3 (Feb 2026)** now supersedes that ruleset where they disagree | someone with v1.3 open |
| **E1.10** | **Hard-coded 150 mm freeboard** | `DetentionSystemViewModel.UpdateTwlWarning` uses `pit.CoverLevel - 0.150` literally, against settings-first (R-00). It is a window view model = Codex lane | Codex |

### E2. Unanswered — do NOT treat any of these as decided

| # | Question | Why it is blocking |
|---|---|---|
| **E2.1** | Which TWL rule governs when a trench grate sits above the highest pipe obvert? | Sets the baffle crest, which sets the orifice size |
| **E2.2** | Where does the required detention volume live? | CDTWL asks for it every run; CE stores it nowhere |
| **E2.3** | What unit is CDCALC's `volumeRequired` in — litres or cubic metres? | A wrong unit is out by 1000x |
| **E2.4** | Should a computed TWL overwrite the one CDCALC shows? | Overwrites a value a person may have typed |
| **E2.5** | Is split-on-draw remembered per drawing or per settings file? | Currently per settings file, so it carries into every later job |
| **E2.6** | Which integration baseline for the Structural/UI candidate? | The UI owner has asked Tim and is waiting |
| **E2.7** | New names for the two unreadable tank blocks? | Tank list cannot show them until named |
| **E2.8** | The orifice head default of 0.45 m — Settings, and per council? | Currently a typed prompt default |
| **E2.9** | Which downpipes belong to which ESD catchment? | Tim ruled areas come per catchment; nothing links catchments to downpipes |
| **E2.10** | Does CE know floor levels at all, and from where? | Raised, then set aside — **not needed for TWL**, but still unanswered for other checks |

### E3. Records I could not reach — listed, not guessed

| Record | Status |
|---|---|
| **D1–D32 approvals** | **NOT recovered in full.** Referenced from memory as branch `codex/civil-ui-ux-area-plan @ 472ca53a` with visuals in a `.codex` visualizations folder. `docs/` holds only passing mentions in `C4_RULES_CODEX_HANDOFF.md` and `COMMAND_TO_CARD_COVERAGE.md`. **The approval record itself was not read.** Treat D1–D32 as approved-in-principle with unverified content |
| Consolidated Civil UI/UX behaviour contract | Authority order item 6 points outside the repo to `C:/Users/TimothyBrand/.codex/visualizations/2026/08/19/.../CE_CIVIL_CLAUDE_UI_UX_CONTRACT.md`. Not read |
| `C:\CE_DrawingIntelligence` governing records | Named on #24 as holding behaviour records (03_Review_Cards, 05_Deliverables, 02_Anonymised_Evidence). Not read |
| Drawing template LPD notes | `CE_A1_C01 - VERTICAL.dwg` text is compressed inside the DWG; a plain text scan returned nothing. **Needs an accoreconsole extraction.** Job-drawing notes were recovered instead |
| Issue #25 full rulings (R-00..R-29, CP-01..08, EV-01..08, D1–D10) | Referenced throughout #24; the issue itself was not opened in this pass |
| Guidebook v1.3 | Only the summary doc was read; the source PDF was not available to check the overflow rule |

---

## F. Ordered completion plan with dependencies

Nothing below is authorised by this report. It is the order the recovered records imply.

### F0. Today — records hygiene, before any code moves

| Step | Action | Depends on | Owner |
|---|---|---|---|
| F0.1 | Record the 14:29 and 14:46 deploys on #78 with their hashes, and correct the live line to `10ac480d` | — | whoever deployed |
| F0.2 | Renumber one of the two BUG-152 entries | F0.1 | the two chats |
| F0.3 | Rebase `claude/c7-one-object` onto `10ac480d` and re-measure | F0.1 | C7 chat |
| F0.4 | Confirm the enabler that must ship with the C7 payload | F0.3 | C7 chat |

### F1. Tim's decisions — these block real work

| Step | Decision needed | Blocks |
|---|---|---|
| **F1.1** | **The TWL rule** (E2.1) — what governs when a trench grate sits above the highest pipe obvert | CDTWL, CDCALC, orifice sizing, the whole detention chain |
| F1.2 | Which number drives the orifice (E1.6), and what CDCALC shows when the two disagree | same |
| F1.3 | Integration baseline for the Structural/UI candidate (E2.6) | every UI recovery reaching AutoCAD |
| F1.4 | Where the required detention volume lives (E2.2) and its unit (E2.3) | CDTWL, CDCALC, CDDESIGN |

### F2. The three that unlock everything else — Tim's stated unfinished work

Ordered by what each one makes possible, not by size.

| Step | Work | Why it comes first | Depends on |
|---|---|---|---|
| **F2.1** | **Make the LPD carry its four things** — position, level, connection type, generated note. Extend the existing `CDLPD` marker (CV13), do not invent an object | Everything downstream needs one thing meaning "this is where the site legally discharges". CDDESIGN already asks and has nowhere to put the answer. `CDRUNSOLVE` already anchors to this level | CV13, CV-01H5 (both already planned) |
| **F2.2** | **Record where each downpipe goes** — one destination each (Tim's ruling) | Makes tank-connected and bypass roof a sum. The `DetentionBranchCollector` walk then answers "what drains to this tank" for free | F2.1 |
| **F2.3** | **Tank plan size and orifice level into the drawing record** — plus the trafficable flag (answer 16) and T-01 stretch-to-size (answer 15) | Until this lands, **CDTWL cannot count a tank** and any tank-heavy job under-counts its storage | answers 15–17 (already given) |

### F3. Then — finish what is part-built

| Step | Work | Depends on |
|---|---|---|
| F3.1 | CDEDIT / PITEDIT truthful Update outcome; refused write keeps the draft; one edit = one Undo | the handoff contract (already written) |
| F3.2 | Read the STORM report — most recently dated file, name which was used | F2.2 |
| F3.3 | CDDESIGN window, built from the published contract | F1.4, the contract (already written) |
| F3.4 | CDTWL rework for the real TWL rule | **F1.1** |
| F3.5 | Prove the standalone Civil ribbon without Manager loaded | R1 / #60 |
| F3.6 | Finish C7: long section, schedule and CDCHECK writes for a converted pipe; then auto-upgrade-on-open | F0.3, F0.4, and Tim testing the split |
| F3.7 | CDHELP and support — requirement captured, nothing built | F3.5 |

### F4. Then — the release gates (V3_0_PLAN section 6)

Source audited → package audited → **Tim accepted** → staff pilot → help, rollback, release notes → **Staff ready = 100%**.

---

## G. One consolidated AutoCAD acceptance checklist

Everything outstanding, in one list, on a **copy** of a real job unless stated. Nothing here has been tested by
any assistant — a green build is not an AutoCAD result, and **zero discovered tests is not a passing test run**.

### G1. Already live and untested (`10ac480d`, deployed 14:46 today)

1. **CDPARTS → Save.** Make a change and save. It must say it saved only if it did. Make the file read-only and
   save again: it must say it failed, keep the window open and keep your edits.
2. **CDPARTS → Reset to Defaults, then Cancel.** The catalogue on disk and in the session must be unchanged.
3. **PIT window.** The block preview pane is larger. **Check nothing scrolls** and everything is visible on open.

### G2. On the C7 branch, once rebased and deployed with its enabler

4. **CDFW / CDSOURCE place at all.** In the job that failed: pick a free point, then a point on a pipe run, then
   a free pipe end. Each must place.
5. After each, the command line names the repeated source name, says **nothing was stopped by it**, and offers
   `CDFIXTAGS`.
6. **CDFIXTAGS.** It lists the repeated names and the blocks, proposes renames, and changes nothing on **No**.
   Run again, answer **Yes**, then check the renamed blocks show their new labels in the drawing.
7. **Split on draw.** Three pits in a line; draw ONE pipe through all three. It asks once; answer Yes; you get
   four pipes, four schedule rows, and the middle pits have a pipe in and out.
8. Draw another: it must **not ask again**. In a new drawing answer **No** the first time and confirm it stays
   one pipe and does not ask again.
9. Draw a pipe that starts and ends on pits but crosses nothing: **it must say nothing and split nothing.**
10. Press **Escape** at the split question: nothing split, pipe intact.
11. **Converted pipe split.** `CDC7UPGRADE` a pipe, then `CDFW` on it. Both halves must be CE pipe objects.
    **Move the top half aside and check there is no stray pipe underneath** — that is the whole point.
12. Labels and invert texts end on the correct halves; the new invert appears both sides of the floor waste.
13. Same on an **ordinary** pipe: nothing about it changed.
14. A **twin barrel** converted pipe: both halves still draw as twins.
15. **Pit label on resize.** PITEDIT a 450 pit to 1200. The label circle must step out and keep its distance from
    the pit, like the cover text. Check the CE log line `ShiftAnnotation [pit label]` — it names what moved.
16. **CDDESIGN.** It asks only for what is missing, makes you confirm the legal point of discharge, refuses a roof
    area larger than the site **without shrinking your number**, and finishes saying nothing was drawn. Confirm
    the drawing is untouched.
17. **AutoCAD 2024 (net48) pass** of items 4–14. Required since Tim ruled 2022–24 users are in scope.

### G3. From the UI recovery candidate, once its baseline is chosen

18. Pipe edit: unsaved diameter/invert, change tab, Move arrow, Escape — same draft and tab; pending edits stay
    unapplied; final Cancel discards; arrow Undo works; original drawing protected.
19. Manager: Escape closes an open dropdown before Manager; Escape cancels an editing Sheets cell first.
20. Sheets: an invalid cell refuses Move/Revision/issue-inclusion without changing selection or draft.
21. CESETTINGS: Cancel restores the opening appearance; Save then reopen preserves values; Reset is global.
22. Issue preparation: revisions/date/council/packing survive Review then Back. Cancel publishes nothing.

### G4. Refusal behaviour — the part that is easiest to skip

23. A refused Pipe Update, a refused label-only Update and a refused Pit Update each **keep the draft, give no
    success message**, and allow one retry.
24. **One accepted edit is one Undo** — everywhere.
25. Switching or closing the originating drawing mid-edit must **never** redirect the edit into another drawing.

---

## Provenance of this report

Read in full: `V3_0_PLAN.md` (sections 3–7, 11–13), `ENGINEERING_RULEBOOK.md` item 7, `GOLD_STANDARD_DRAWINGS_SPEC.md`
TWL evidence, `CDWT_DETENTION_TWL_PLAN.md`, `CE_DESIGN_GUIDEBOOK_RULESET.md`, `CE_GUIDEBOOK_V1_3_SUPERSEDES.md`,
`CV-01H5_MULTIPLE_LPD_AUTHORITY_PLAN.md`, `CV-01_DRAINAGE_NETWORK.md` (CV13, R3), the four
`*_20260915.md` recovery records via `git show`, issues #24 (body + 64 comments, newest 8 read in full), #78
(body + newest 3 comments), #28/#41/#75/#20 (titles and state), and the corpus of finished jobs 2603, 22547,
25-06, 2602, 2648.

Measured directly, not read from a document: the installed bundle hashes and product version, the rollback
archive names and times, branch ahead/behind counts, and the STORM report folder count and PDF structure.

**Not read** — see section E3. In particular the **D1–D32 approval record was not recovered**, so this report does
not claim all answers are recovered.

---

## H. Incident, 15 September 2026 — a rebase silently dropped the council rulebook

**Recorded because it nearly lost real work, and because it is the argument for where the master plan should live.**

### What happened

1. `claude/c7-one-object` was rebased onto the true live commit `10ac480d` (correct and necessary — the branch
   was 2 behind live).
2. The branch history contained a **merge commit** (`68e4e28b`) that had brought the council-rulebook work in
   from another line of work.
3. `git rebase` drops merge commits unless told otherwise. **Two commits were lost without a word:**
   - `64f56cad` — council rulebook becomes a V3 workstream; Manningham rules
   - `7cc288a0` — Maroondah orifice coefficient; a sentence wrongly copied onto five councils
4. That removed `docs/workflows/COUNCIL_RULES_V3_INTEGRATION.md` (284 lines) and the whole **Council rulebook
   (CR)** workstream row from `docs/V3_0_PLAN.md`, along with ten `COUNCIL_*.md` write-ups.
5. The rebase reported success. Three lanes built with **0 errors**. The full suite passed with **exactly the
   same 23 failures as before**. **Every check was green and the work was still gone.**

### How it was caught

Tim pointed at `V3_0_PLAN.md` in a *different* worktree. That copy was 43 lines longer and three hours newer
than the one on the rebased branch. Comparing the two exposed it.

**It was not caught by a build, a test, a diff summary or a commit count.** Restored by cherry-picking the two
commits; the plan now matches the other worktree byte for byte and the branch is 0 behind live.

### What this proves

- **A green build and an unchanged test count prove nothing about documents.** No test covers a plan file.
- **`git rebase` is not safe on a branch that contains merges** unless `--rebase-merges` is used, or the result
  is explicitly compared against the pre-rebase tip. The check that would have caught it is one line:
  `git log --oneline --no-merges --cherry-pick --right-only HEAD...<old-tip>` — it must be empty.
- **The same plan existing in several worktrees is the underlying hazard.** Two copies drifted for three hours
  and nothing detected it. That is Tim's point about where the master plan should live.

### Rule adopted

After **any** rebase or history rewrite on a shared branch:

1. run `git log --oneline --no-merges --cherry-pick --right-only HEAD...<old tip>` and require it to be empty;
2. keep the pre-rewrite tip on a throwaway branch until step 1 passes;
3. never rely on a build or test result as evidence that documents survived.
