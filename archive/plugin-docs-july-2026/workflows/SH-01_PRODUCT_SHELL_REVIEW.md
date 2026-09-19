# SH-01/SH-02 — AutoCAD Product Shell, Health and Recovery Review

**Canonical card ID:** `SH-01` (`SH-02` is merged scope, not a second card)
**Status:** CURRENT-STATE REVIEW + SH1–SH15 ✅ LOCKED · 2026-07-20

**Scope:** startup, ribbon, `CEMANAGER`, `CEHEALTH`, `CESUPPORT`, Help, version/status, suite palettes and
emergency recovery. No Civil/Structural drawing command behaviour changes in this batch.

## 1. What the code does today

```text
three standalone plugins + an undeployed unified-host skeleton
        ↓
multiple startup paths / ribbons / versions / logs
        ↓
same command name can run a different module depending on load order
```

| Surface | Current evidence | Starting class |
|---|---|---|
| Unified host | `CE.Host.Plugin` states it is a skeleton and is **not deployed anywhere**. It loads Manager → Drainage → Structural and logs duplicate commands but does not resolve them. | **Rebuild/finish** |
| Ribbon | Manager code builds `CE Suites`, each contributor tab, and `CE Tools`—five tabs are documented in the service. The unified builder is a no-op on net48/older supported AutoCAD. | **Rebuild to locked one-product design** |
| `CEMANAGER` | Opens Manager's modeless dashboard; separate Admin/Updates windows and refresh command exist. Current confidence audit says discovery may miss the live AppData path. | **Modify after Tim shows current UI** |
| `CEHEALTH` | Manager checks installed plugin files; Drainage checks active-drawing pits/pipes/blocks/layers; Structural checks its own system. Same global name exists in all three. | **Rebuild as one report with clear sections** |
| `CESUPPORT` | Manager collects only old `%APPDATA%\CE_CADTOOLS` + Desktop diagnostics; Structural has a different collector. Known audit: support bundle can succeed while omitting the real logs. | **Rebuild/consolidate** |
| Help | Drainage `CDHELP`, Structural `CEHELP`, command palettes and static guides are separate. | **Rebuild from central tool registry** |
| Version/status | Separate `CDVER`, `CE_VERSION`, Manager records and hardcoded runtime wording. | **Consolidate** |
| `CETOOLS` / `CESTRUC` | Opens separate Structural palette/window; Manager and Civil have other windows. | **Review useful parts; avoid competing hubs** |
| Failure visibility | Ribbon builders catch and suppress failures so AutoCAD survives, but users may simply get missing tabs/buttons with no visible recovery instruction. | **Modify: fail safely and visibly** |
| Logging | Host, Civil, Structural and Manager use different roots/collectors. | **Rebuild to one root/retention/support path** |

## 2. Recommended end-state

```text
AutoCAD starts
   ↓
one CE product identity + one clean ribbon/workspace
   ↓
Manager shows version / health / updates / recovery
   ↓
Health report
  ├─ Installation
  ├─ Active drawing
  ├─ Performance
  ├─ AI connection (optional)
  └─ recommended action
```

No internet or AI wait occurs during startup. If one discipline fails, the other tools remain available and
Manager shows the failure and recovery action.

## 3. Tim decisions — SH1–SH15 locked

Tim approved all 15 on 2026-07-20, with the startup budget and version-truth prerequisite below.

| ID | Locked decision | Why/example |
|---|---|---|
| `SH1` | Show one CE ribbon/workspace, not five separate CE tabs. | Civil and Structural remain clearly grouped inside the one product. |
| `SH2` | No startup pop-up; only a small status indicator. | A red indicator opens Manager if action is required. |
| `SH3` | Typical CE-added startup ≤0.5 s; hard release ceiling ≤1.0 s. Ribbon usable on first AutoCAD idle. | Measure CE-off versus CE-on across supported versions; heavy work deferred. |
| `SH4` | Make Manager the single product-status, update and recovery centre. | It does not become another drafting palette. |
| `SH5` | Make Manager own the one `CEHEALTH` command. | Report has Installation + Active Drawing sections instead of competing commands. |
| `SH6` | Make Manager own the one `CESUPPORT` command. | Collect all actual logs/version/hash/health; never include the DWG without approval. |
| `SH7` | Merge `CDHELP` and `CEHELP` into one contextual Help Centre. | Old names redirect during migration. |
| `SH8` | Show exact CE version/channel/commit/health inside Manager and a compact ribbon/status location. | Green=current, amber=update, red=mismatch/failure. Fix newest-AutoCAD runtime/version reporting first or the display cannot pass. |
| `SH9` | Preserve useful CETOOLS/CESTRUC functions but reach them through one workspace/search. | Avoid several competing “home” windows. |
| `SH10` | If one module fails to start, isolate it and keep the rest of CE/AutoCAD running. | Manager names the failed area and recovery action. |
| `SH11` | Provide an immediate per-feature/per-module disable switch. | No uninstall required for one bad command. |
| `SH12` | Give every supported AutoCAD version the same essential CE navigation. | Older AutoCAD cannot silently lose the unified ribbon. |
| `SH13` | Run no network/AI/update wait on the AutoCAD drawing/startup thread. | Updates and AI connect lazily in the background; existing delayed-update pattern is the starting reference. |
| `SH14` | Use one local log root with size/age caps and one truthful support bundle. | Support cannot return an empty “success.” |
| `SH15` | Accept this batch with one automated test-profile run plus one ≤10-minute Tim visual check. | Tim checks startup/ribbon/Manager/health/recovery once—not each internal fix. |

## 4. Locked classification outcome

| Item | Final class for implementation planning |
|---|---|
| Unified host/startup | **Rebuild/finish incrementally** |
| Manager hub | **Modify and retain as the one home** |
| `CEHEALTH` | **Rebuild/consolidate under Manager ownership** |
| `CESUPPORT` | **Rebuild/consolidate under Manager ownership** |
| Help | **Rebuild as one offline contextual source** |
| Version/status | **Modify/consolidate; fix incorrect newest-AutoCAD reporting first** |
| CETOOLS/CESTRUC useful palettes | **Keep useful workflow views; remove rival home screens** |
| Multi-tab/version-specific ribbon layouts | **Retire and redirect into the one consistent CE ribbon** |

## 5. Startup performance acceptance

```text
CE-off baseline versus CE-on
  typical added time ≤0.5 seconds
  every supported-version release run ≤1.0 second
  ribbon usable on first AutoCAD idle
  no network / AI / full drawing scan on the measured startup path
```

The hard ceiling is measured on representative office hardware and an agreed test drawing/profile. A single
outlier is investigated; repeated/95th-percentile results above 1.0 second block promotion. Background work must
yield to drawing commands and cannot make the ribbon merely look ready while AutoCAD remains busy.

## 6. Automation target

**Target: 90% automated evidence; Tim remainder ≤10 minutes.**

Automate:

- command ownership/duplicates/aliases;
- supported-version ribbon definitions and button destinations;
- version/path/hash truth;
- missing module/log/config simulations;
- startup/module failure isolation;
- support-bundle contents and privacy exclusions;
- no-network startup;
- startup timing capture.

Tim checks once:

1. one CE surface looks clean in real AutoCAD;
2. Manager/Health wording is practically useful;
3. disabling/re-enabling a test feature is understandable;
4. no noticeable startup/drawing lag.

## 7. Implementation authorization

The AutoCAD behaviour decisions are approved. No host/ribbon/Manager code changes begin until the related P0
foundation work cards (`FND-001`–`FND-006`) are broken into owned, testable slices and Tim approves the first
implementation card. The newest-AutoCAD version-reporting defect is a prerequisite inside `FND-006`, not a
post-release improvement.
