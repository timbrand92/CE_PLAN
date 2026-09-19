# CV-04 — CDWT: water tanks only, one mode question, plan blocks from the office master, one Undo

**Authority:** `docs/CARDS/CV-04_SURFACE_DRAINAGE.md` — approved CV4-9 (CDWT starts with a clear mode: adopt
existing block / insert CE tank / annotate existing detention pit), CV4-10 (total required; detention cannot
exceed total; reuse = total − detention; missing values stay Unknown), CV4-11 (tank, callout, riser, dropper,
capacities and connections form one compound with permanent relationships), CV4-15 (one atomic Apply, one Undo);
**Tim's ruling of 13 September 2026 (late evening):** "This command is for water tanks only … update to be water
tanks only and then get details and water tank plan blocks from civil details folder" — so the CV4-9 "annotate an
existing detention pit" mode is NOT in CDWT (the BUG-040 branch is retired from this command; a detention-pit
annotation tool needs its own card), and the tank plan blocks come from the office Civil Standard Details masters.
`docs/CLEAN_SLATE_REBUILD.md` §6.10 rules 1, 3, 5, 11, 12; AGENTS.md native protection rule; settings-first rule.
**Classification:** Modify — same command name, capacity rules, callout wording, R/D sub-block tags and WT record;
the start of the command and its write route change. No engineering value invented.
**Built by:** Claude, branch `claude/ce-autocad-civil-90-percent-db893b`. Codex-owned files untouched.
**Status:** Built (managed evidence, AutoCAD 2027 / net10 compile and tests). Not Native Accepted.

## Drawing outcome (what Tim sees)

1. `CDWT` asks one question first: **Adopt** a block already in the drawing, or **Insert** a plan block from the
   office master (`[Adopt/Insert] <Insert>`). Picking a pit can no longer silently turn the command into
   "annotate detention".
2. **Adopt:** pick any block (anonymous or client blocks included, as before — BUG-019). A block that is already a
   tagged source is refused ("Tags are never recycled; nothing was changed").
3. **Insert:** the capacity comes first (tank library from Settings offered first, typing stays a choice), then the
   plan block — a library tank whose entry records a `planBlockName` needs no further question; otherwise the
   master's tank plan blocks (names containing TANK or RWT, e.g. `3000 LITRE TANK`, `POLYMASTER UNDERGROUND 5000
   LITRE TANK`, `4500lt-MELRO-UG POLY RWT-PLAN`) are offered by keyword — then the insertion point.
4. Callout text location, RISER point and DROPPER point are each asked once (Enter skips), marked on screen as
   transients only, then `Place this water tank? [Accept/Cancel] <Accept>` summarises the whole compound.
5. Accept writes, in ONE transaction: DOWNPIPES / 25DIMS / GUIDELINES layers if absent, the plan block definition
   cloned from the read-only master (Insert only; never the whole master, never patched), the tank block (or the
   adopted block moved to DOWNPIPES), the next `WT<n>` tag + label + connection point, the callout MLeader (same
   style as CD callouts), RISER and DROPPER with their own `R<n>` / `D<n>` tags (attribute text synced), the
   callout/riser/dropper as attachments of the tank (CV4-11: moving WT1 moves its parts), and the unchanged WT record
   (`PitType "WT"`, capacity notes). Exact readback precedes the commit; one `U` removes all of it; Escape or Cancel
   at any prompt leaves nothing — not even an imported definition.
6. The master folder is a Settings value (`standardDetailsCivilFolder`, default = the office OneDrive layout under
   the current user profile). The first present master wins: `CE Civil WATER TANK PLANS & DIAGRAMS Details.dwg`,
   then `CE Civil WATER TANKS - PUMP STATIONS Details.dwg`. **Finding for Tim:** on 13 September the PLANS &
   DIAGRAMS master existed in the folder only as a `.bak` (no `.dwg`); CDWT therefore uses the TANKS - PUMP
   STATIONS master, which carries the same plan blocks, until the `.dwg` is restored.

## How it is wired (one code path)

- `WaterTankCommand.cs` — prompts and flow (`CommandPreFlightForDeferredApply`; picks admitted to host-world
  XY / Z = 0); `WaterTankCommand.Plan.cs` — pure `TryResolveMode`, `TryResolveCapacity` (unchanged rule),
  `TryBuildPlan`, callout/notes/inspector text builders (unchanged wording); `WaterTankCommand.Preview.cs` —
  transient markers over `TransientDrawableSet`; `WaterTankCommand.Apply.cs` — `AtomicDrawingChangeRunner`
  lifecycle with the caller-transaction attachment journal (`BeginCallerTransactionAttachmentJournal` →
  `RegisterPitAttachmentInCallerTransaction` → `ConfirmCallerTransactionAttachmentCommit` →
  `PublishCallerTransactionAttachmentJournal`), `RegisterSourceBlockInTransaction` receipts published after the
  confirmed commit, snapshot seams for the WT record, exact readback.
- `Services/WaterTankPlanBlockSource.cs` — master path resolution (settings-first), read-only ACadSharp catalogue
  (`SelectTankPlanBlocks`, `Keywords`), and `EnsurePlanBlockDefinitionInTransaction` (WBLOCK-clones exactly one
  block definition from the master opened for shared read).
- `TextService.CreateCalloutMLeaderInTransaction` (new, same builder and layout as the existing source callout);
  `BlockService.EnsureShippedDefinitionInTransaction` (import RISER / DROPPER inside the transaction, never patch).
- `UserSettings.Options.StandardDetailsCivilFolder`; `TankLibraryEntry.PlanBlockName` (optional).
- Retired from CDWT: `TryRunDetentionPitMode`, `BuildPitDetentionCalloutText`, `ResolvePitTag` (BUG-040 branch),
  `PromptInsertBlock` jig, per-part transactions, `RelinkAllPipeEndpoints`, in-memory `AddPit`.

## Decisions banked (not invented)

- Water tanks only (Tim). The detention-pit annotation (BUG-040 R4.10) is not deleted as a need — it is out of CDWT
  and waits for its own card.
- Plan-block catalogue rule = named, non-anonymous definitions whose name contains TANK or RWT; the names come from
  the master, never from code.
- Capacity rules, callout wording, WT notes format and inspector capacity display are byte-for-byte the previous ones.

## Automated evidence (work PC, AutoCAD 2027 / net10, 13 September 2026)

`WaterTankAtomicPlacementTests` (10): mode question, capacity rule, plan refusals, callout/notes wording, master
catalogue filter + keywords, master path order, `planBlockName` round trip, water-tanks-only/atomic wiring guard,
settings-first folder guard; `WaterTankCompoundContractTests` (1, updated to the in-transaction attachment route);
existing `WaterTankCapacityTests` (8) and `TankLibraryTests` (3) unchanged and green. Receipts
`claude-cdwt-drainage-net48.log`, `claude-cdwt-drainage-net8.log`, `claude-cdwt-civil-full-net10.trx` under
`C:\Autodesk\CERef\Colleague-20260913\verification\` (numbers in the master status). Not native block / MLeader /
master-clone / Undo evidence.

## AutoCAD acceptance (joins the consolidated batch)

1. `CDWT` → Enter (Insert) → pick a library tank or type litres → choose a plan block → pick the tank point,
   callout point, riser and dropper → Accept: tank block from the master appears on DOWNPIPES with `WT1` label,
   callout on 25DIMS, `R1` and `D1`; CDINSPECTOR shows WT1 with the entered capacity; move WT1 → callout, riser and
   dropper move with it; one `U` removes the whole compound.
2. `CDWT` → Escape at the Accept prompt in a fresh drawing → no tank, no plan block definition (`PURGE` lists
   nothing new), no layers created.
3. `CDWT` → Adopt → pick an existing client block → it becomes WT2 with label and connection point; pick a block that
   is already DP1 → refused, nothing changed.
4. Detention greater than total → refused before any pick; Enter at riser/dropper skips them and the summary says so.
5. Rename the TANKS - PUMP STATIONS master (with no PLANS & DIAGRAMS `.dwg` present) → Insert refuses before any
   pick, naming both master files; Adopt still works.
