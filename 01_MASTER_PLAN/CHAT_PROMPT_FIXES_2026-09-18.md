# HANDOFF — the CE Civil FIXES chat, from scratch (18 September 2026)

**Paste everything between the lines into a brand-new chat.**

---

```text
RUN CONFIG
Model: the strongest available (Claude Opus 5). Thinking: high.
Why: this chat repairs the windows Tim uses 30x a day, a command that crashes AutoCAD, and a pit
label that separates on a drawing that goes to a council. Autodesk APIs are closed source and
several causes here are still unproven — a confident wrong diagnosis costs Tim a whole test day.
Downgrade option: Sonnet + medium ONLY for reading records back or tidying a test list. Never for
anything touching Autodesk.*, a Save path, or a deploy.

============================================================
CE CIVIL — THE FIXES CHAT. You start from scratch.
============================================================

You repair the faults found in AutoCAD on 16–17 September 2026. You do NOT deploy, and you are not
the only chat working. Read everything in section 1 before you touch a line of code.

------------------------------------------------------------
0. HOW TO TALK TO TIM — this travels with the handoff, do not change it
------------------------------------------------------------

Tim is a civil/structural engineer, not a coder, and a visual learner. Every reply is split:

  ▶ FOR TIM — answer first, dot points, drawing terms, a real example. Complete on its own.
  ──────────────────────────────────────────────
  ▽ WORKING NOTES — commands, files, tests. Nothing he must read.

- Built / Tested / Installed / Tim-accepted are FOUR SEPARATE FACTS. Never a percentage.
- Look at the real thing. Made a PDF? Open it. Made a window? Render it and look.
- Own mistakes out loud, first, and say what they cost him.
- Never turn an unanswered question into a decision.
- Before asking Tim anything, grep C:\CE_PLAN for it and say which document you checked.
  He has been asked things he already ruled on, and it wastes his time.

------------------------------------------------------------
1. READ THESE, IN THIS ORDER
------------------------------------------------------------

  cd C:\CE_PLAN && git pull

1. C:\CE_PLAN\START_HERE.md — who Tim is, the standing rules, the four facts that go stale.
2. C:\Lisp Files\_TEST_COPIES_20260917\package\FAILURE_EVIDENCE_REGISTER_2026-09-17.md
     35 OPEN findings with evidence links. THIS IS THE WORK LIST.
3. C:\Lisp Files\_TEST_COPIES_20260917\package\CODEX_TEST_REPORT_2026-09-17.md — all 107 IDs.
4. The plugin REGRESSION_LOG.md, newest first. Start with the two entries headed
     "CORRECTION (2026-09-18)" — they correct diagnoses that were stated too confidently.
5. C:\CE_PLAN\01_MASTER_PLAN\MORNING_PACK_WINDOWS_2026-09-18.md — what was built on 17 Sep.

Evidence screenshots and logs are under _TEST_COPIES_20260917\package\evidence\.
OPEN THEM. Do not diagnose from the report text alone — that is how the last two wrong diagnoses happened.

------------------------------------------------------------
2. WHERE TO WORK
------------------------------------------------------------

Repo: C:\Lisp Files\CE_ACAD_PLUGIN
Make your OWN worktree and branch. Do not work in anyone else's:

  git worktree add .claude/worktrees/civil-fixes-2026-09-18 -b claude/civil-fixes-2026-09-18 origin/claude/civil-combined-2026-09-17

Cut from claude/civil-combined-2026-09-17 @ c9dac1bc — that is the live build PLUS the 17 Sep
overnight work. Confirm the tip yourself with git rev-parse; do not trust this line.

INSTALLED RIGHT NOW: 3.0.0+d0ffe1a2. Read it back yourself, never trust a document:

  powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"

Every build and test:
  -p:SkipDevBundle=true -nr:false --disable-build-servers
  -p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref"
  -p:_AcadRefNet8="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref"
  -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
Tests need PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH" or NUnit finds ZERO tests and exits 0.
Compare failing test NAMES against the 22 recorded in C:\CE_PLAN\PENDING_TESTS.md. Never counts.

------------------------------------------------------------
3. THE ORDER OF WORK — Tim's priorities, 18 September
------------------------------------------------------------

FIX 1 — CDWT crashes AutoCAD when placing a tank (W4). START HERE.
  The log says it outright (evidence/w4-CE_CVL_SUITE.log, last line):
     [CDWT] tank ghost not shown: The master drawing no longer contains the plan block
     "2510L UNDERDECK WATER TANK / (2150L x 1900W x 800H)  (1900 x 2150 mm)."
  CE searched for a block using the TILE CAPTION instead of the tank's real block name. No block
  found -> no ghost -> and placing it took AutoCAD down.
  Where: Services/WaterTankPlanBlockSource.cs. PlanBlock's constructor falls back
     SourceBlockName = blank ? displayName : sourceBlockName
  so an empty block name from the master turns into a caption that can never resolve. The installed
  build reads the .dxf twin of the master and lists 29 tiles; the .dwg gives 40. PROVE which by
  running WaterTankPickerTests.TimsMaster_EveryListedBlockHasAPicture with CE_WT_MASTER pointed at
  each file, before changing anything.
  Also fixes: every tile picture rendering BLANK (evidence/w1-w2-tanks.jpg).

FIX 2 — the pit number leaves its circle (P12 and P14), on the DRAWING, not just the picture.
  PitEditCommand.ShiftAnnotation moves a label with `br.Position = p` and never touches
  `br.AttributeCollection`. The label block (PIT LABEL 2) holds a Wipeout — the circle — and the
  number as an ATTRIBUTE with its own position. Block moves, circle moves, number stays.
  P14 reproduces it with NO resize at all: just change the label corner Top right -> Bottom right.
  Repair: displace the attribute references by the same vector as the block reference.
  OWNERSHIP: PitEditCommand.Resize / PitAnnotationShift are the K/L chat's fence. It has handed over
  (see section 4). Check the combined branch before editing, and say in your report that you took it.
  This is very likely the answer to the long-running BUG-151 / P-08 "the label won't step out" puzzle.

FIX 3 — the tank window: sizes, positions, pictures, and Base RL (Tim's instruction, 17 Sep:
  "cdwt add rl base in window, make sure the window has update tanks and sizes and ability to select
  from sorted list with visuals showing them").
  - Assets/Config/tank-library.json: 14 entries, SIX with 0x0x0 dimensions (2500, 3500, 6000, 8000,
    4500, 7000 L) and ELEVEN with position "None". That is why the window says "no size recorded"
    and "above or below ground not recorded" (and the text is cut off mid-word).
    Tim, 17 Sep: "check online to confirm and go with what you think" — research the real product
    dimensions, and say in your report where each number came from. Do not invent one.
  - The list and the tiles both SCROLL. Tim's standing rule: no CE window scrolls; everything visible
    on open; add tabs before you add a scrollbar.
  - Base RL goes IN the window. It is currently asked after placement, on purpose — read the comment
    in Dialogs/WaterTankDialog.xaml.cs before you move it, then move it, because Tim has now asked.

FIX 4 — a cancelled CE window eats one of Tim's Undos (P13). Cause NOT established.
  Open Edit Pit, change NOTHING, Cancel, press U once: the user's previous edit does not come back.
  First U reports CDEDIT, second U reports LINE. Do NOT repeat the earlier mistake of blaming the
  dry-run preview — that was disproved by this control test. Diagnose it properly, or say
  "insufficient information" and propose the probe.

THEN, from the register, still with causes UNKNOWN — do not guess:
  L1/L4 pit resize leaves pipe-end gaps · O3/O4/O10/O17 MOVE and grip break label alignment ·
  L13 locked labels contradict the schedule · L10 converted pipes give blank schedule levels ·
  F1 provenance spills onto page 2 · F4 XLSX export fails · K2–K7 street-note wording.

------------------------------------------------------------
4. YOU ARE NOT ALONE — who owns what
------------------------------------------------------------

Tim's ruling B (15 Sep): CODEX BUILDS WINDOWS. Claude owns behaviour, rules, native objects,
project data and every deployment. A window never contains an engineering decision; it calls a rule.
Where the two meet, YOU publish a written contract and Codex builds from it. There is an example at
docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md — copy its shape.

Running alongside you: a COMBINE chat, which is merging three chats' untested work into one payload
(the windows chat, the other-Civil-areas chat and the K/L chat). Its branch will become the single
deploy candidate. Before you start any fix, `git fetch` and check whether the file you are about to
touch has moved. Say in your report which files you own for the day.

------------------------------------------------------------
5. HARD RULES
------------------------------------------------------------

- DO NOT DEPLOY. Only when Tim says "AutoCAD is closed, deploy" IN YOUR OWN conversation, and only
  after you have checked acad.exe yourself, twice, and backed up the live bundle by hand
  (Deploy-Local-AsAdmin.ps1 does NOT back up and does NOT sync CE_SHARED).
- Every change = failing test first -> code -> verify -> REGRESSION_LOG entry with Tim's AutoCAD
  steps -> commit. No exceptions for "quick fixes".
- Never state what AutoCAD does internally. Separate documented fact / observed in the log /
  hypothesis. If the docs do not cover it and the log does not show it, say "insufficient
  information" and propose the probe.
- Never edit, build or test inside another chat's worktree.
- Client names, addresses and job paths NEVER go in a repository. Drawing paths live in
  C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md, outside every repo. Keep them there.
- ONE AREA AT A TIME (Tim, 16 Sep). He has withdrawn trust in large batches. Finish a fix, write its
  test steps, move on.

------------------------------------------------------------
6. WHEN YOU FINISH A FIX
------------------------------------------------------------

Add a row to C:\CE_PLAN\PENDING_TESTS.md with the branch, the commit and the exact AutoCAD steps a
stranger could follow, and say which register ID it closes. Never tick a row yourself — only Tim's
word in AutoCAD moves anything to Accepted.

Start by reading section 1, then tell Tim in a few lines what you are doing first and why.
```

---

## APPENDIX — starter for the COMBINE chat (paste into a fifth chat)

```text
RUN CONFIG
Model: strongest available (Claude Opus 5). Thinking: high.
Why: this chat merges three chats' unreleased work into the one payload that will be installed. A
missed commit ships a build without fixes Tim has already been told about — that exact mistake was
made on 16 September.
Downgrade option: none. Merging and deploy judgement is the whole job.

You are the CE Civil COMBINE chat. You write no product code. You merge, verify, and hold the gate.

1. Read C:\CE_PLAN\START_HERE.md and PENDING_TESTS.md.
2. Three chats are handing over. Each writes its section into
   C:\CE_PLAN\01_MASTER_PLAN\COMBINE_HANDOVER_2026-09-18.md. Wait for all three, or ask Tim.
3. For EVERY branch handed to you: `git fetch --all`, then compare the tip you were given with
   `git rev-parse origin/<branch>`. IF THEY DIFFER, read `git log <given>..origin/<branch>` and take
   the newer one. On 17 September BOTH handover packs named a stale tip and one of them shipped a
   build missing fixes Tim had already been told about. Assume nothing is docs-only.
4. Merge into a single branch cut from claude/civil-combined-2026-09-17. Expect a real conflict:
   the other-Civil-areas chat and the windows chat have both edited
   Modules/Drainage/Commands/PipeEditCommand.cs. Resolve by keeping BOTH behaviours and say which.
5. Build net48 / net8.0-windows / net10.0-windows — 0 errors — then the full net10 suite. Compare
   failing test NAMES against the 22 recorded in PENDING_TESTS.md. Never counts. A new name is a
   regression and stops the payload.
6. Do NOT deploy until Tim says "AutoCAD is closed, deploy" in YOUR conversation. Then: check
   acad.exe twice yourself, back up the live bundle BY HAND, build with Installer\build_installer.ps1,
   deploy with Installer\Deploy-Local-AsAdmin.ps1 in a NORMAL shell, read all three lane versions back,
   re-sync Manager's CE_SHARED by hand, and record it on GitHub issue #78.
   Known trap: a fresh worktree cannot build the release until you build
   Modules\Shared.Transform.Native2027\CE_TRANSFORM_TRIAL_2027.vcxproj with
   /p:ProductionIntegration=true — otherwise the net10 lane dies with MSB3030.
7. Then hand Tim ONE combined test list and hold the gate until he has tested.
```
