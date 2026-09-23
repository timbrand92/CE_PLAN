# CE Drawing Intelligence — Programme Root

**Confirmed by Timothy Brand, 2026-08-12:** this folder (`C:\CE_DrawingIntelligence`) is the private,
non-synchronised home of the CE Drawing Intelligence and Drafting Standards programme.
It sits outside every OneDrive/SharePoint sync scope by construction (C:\ root; Known Folder Move
covers only Desktop/Documents/Pictures). **Never** move it into a synced location, never add it to a
cloud-sync tool, and never point a cloud backup at `01_Private_Index` or `90_Private_Scratch`.
Local-drive backups are fine.

**19 Sep 2026:** the plugin's CEMARKUP corpus (snapshots and index files named after real jobs) moved out of the plugin repository into `C:\CE_DrawingIntelligence\10_Plugin_CEMARKUP_Corpus\`. It grows there. Rule R-LEARN in `..\ENGINEERING_RULEBOOK.md`.

## Authority

- **Timothy Brand** — sole approver of CE drafting/engineering standards, engineering values and
  final AutoCAD behaviour; owns privacy/cost/scope boundaries.
- **Codex** (CE Drawing Intelligence Control Room + existing CE Plugin Control Room) — final
  implementation authority; issues every work card; owns CE_ACAD_PLUGIN lanes.
- **Claude** — planning, evidence-system design and independent review; advisory only.
- Live plugin status lives ONLY in `CE_ACAD_PLUGIN\docs\ACTIVE_REGISTER.md` (row `EVX-00` points here).
  This folder's status files are programme-detail, not competing live authority for the repository.

## Structure and privacy classes

| Folder | Privacy class | Contents |
|---|---|---|
| `00_Control` | Internal | Programme control: status, decisions log, stage plans, cards |
| `01_Private_Index` | **PRIVATE LOCAL — never model-visible, never synced** | Restricted raw-path crosswalk, private census outputs, checkpoints |
| `02_Anonymised_Evidence` | Anonymised local; `model-cleared` records only after scanner pass | Semantic evidence records, aggregate counts |
| `03_Review_Cards` | **PRIVATE LOCAL** (Tim-facing; may render local evidence imagery) | Visual exception batches for Timothy (≤30/batch) |
| `04_Standards_Manual` | Internal | Manual drafts: Part A General, B Civil, C Structural |
| `05_Master_DWG_DWT_Specification` | Internal | Master DWG/DWT specification (authoring is a later card) |
| `06_Machine_Catalogue` | Internal (runtime-destined records must be client-free) | One AS-01-shared schema/ID space — never a second catalogue |
| `07_Automation_Roadmap` | Internal | Automation Opportunity Register (Now/Next/Research/Do-not) |
| `08_Codex_Handoff` | Internal | Dated decision packets exchanged with Codex |
| `90_Private_Scratch` | **PRIVATE LOCAL**; ceiling **10 GB** (Tim, 2026-08-12) | Bounded temporary work incl. synthetic fixtures |
| `91_Tools` | Internal | EvidenceRunner standalone repo (created only under its Codex card) |

## Standing machine rules (Tim, 2026-08-12)

- Scratch limit **10 GB initial**; **stop before C: falls below 100 GB free**; do not consume the
  full ~28 GB allowance without another review.
- **Amended 2026-08-12:** P0.5 synthetic work does not require an exclusive night. Low-load code,
  build and micro-tests may run during the day within its issued limits. R0/release has immediate
  pre-emption; normal synthetic runs use genuinely idle windows; optional scale runs remain after-hours.
- Timothy's drafting must remain responsive. P0.5 checkpoints and pauses on user/AutoCAD/plugin
  pressure; this amendment applies to P0.5 only, not later real-evidence scans.
- One raw-source reader process ever; never-hydrate by default; no mass download/hash/copy;
  checkpoint/resume; tested 08:15 quiesce watchdog.
- The nominated evidence roots (`Creative Engineering - Projects`, `- Archive`, and the
  `- Drafting` estate) are read-only inputs for later carded stages — they are never opened,
  enumerated or hydrated except under an explicit Codex work card, and raw client content is never
  sent to any model or cloud service.
