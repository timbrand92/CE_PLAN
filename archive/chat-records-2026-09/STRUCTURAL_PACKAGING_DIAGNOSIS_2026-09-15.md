# Structural packaging — what is actually wrong, measured

**15 September 2026, read-only.** The handoff listed *"Structural packaging — no release script, and its
bundle carries no `CE_SHARED.dll`"* as an open item. This is that item checked against the machine rather
than repeated from a document. **Nothing was changed and no script was created** — creating a build,
versioning or deployment script needs Tim's explicit approval first.

---

## What was measured

| Check | Result |
|---|---|
| A Structural release or deploy script anywhere in the repo | **None.** `find Modules/Structural* -iname "*.ps1"` returns nothing. Civil has `Installer\build_installer.ps1` + `Installer\Deploy-Local-AsAdmin.ps1`; Structural has no equivalent. |
| `CE_SHARED.dll` in the installed Structural bundle | **Absent.** |
| `CE_SHARED.dll` in the other installed bundles | Present in **Civil** and **Suite Manager**, all three lanes each, all at `1.1.0+inspector-contract.1.817d482c…` |
| Does Structural actually *need* CE_SHARED? | **Yes.** `Modules/Structural/CE_STRUC_SUITE.csproj` line 142 carries `<ProjectReference Include="..\..\Shared\CE_SHARED\CE_SHARED.csproj" />`, and at least five source files use it (`CeSheetsModels`, `UserSettings`, `AdminTelemetryService`, `CeProjectSetupService`, `CeSharedTitleMappingService`). |
| Lanes in the Structural bundle | **`Modern` only** — no `Legacy` (net48) and no `Net8`. Civil and Manager ship all three. |
| Installed Structural version | `1.0.74+5d723d41…` |
| Installed Civil version | `3.0.0+817d482c…` |

---

## What that adds up to

**1. Structural is relying on another plugin to supply a DLL it needs.** It references CE_SHARED, uses it in
its own code, and does not ship it. It works today only because Civil or Suite Manager loads CE_SHARED into
the same AutoCAD session first. That is not a designed arrangement — it is a coincidence of load order, and
it is exactly the kind of thing that works on Tim's machine and fails on a colleague's.

*Documented fact:* the reference and the absence are both verified above.
*Hypothesis, not established:* whether AutoCAD would actually fail to load Structural in a session where
neither Civil nor Manager is installed. **That has not been tested** and would need an AutoCAD run with the
other two bundles removed. It is the probe that would settle it.

**2. Civil and Structural are already not shipping from the same commit.** Live Civil is `817d482c`; live
Structural is `5d723d41`. The rule that they must ship together is currently not being met, and there is no
script that could make them.

**3. The Modern-only bundle may well be deliberate** — Structural `1.0.74` is the trial B build, and Tim's
5 September ruling was 2027-only. The 15 September narrowing (*2022–2024 users are in scope*) was about
**Civil pipe behaviour via overrules**, not Structural. **Recorded as probably intended, not as a fault.**
Tim should confirm.

---

## What is proposed — needs Tim's approval before anything is written

Nothing here has been built. The global rule is that no new build, versioning or deployment script is created
without Tim saying so, and this is exactly that.

**Proposal, in one piece:** give Structural the same two-script shape Civil already has, rather than
inventing a different one —

1. `Modules/Structural/Installer/build_installer.ps1` — mirrors Civil's: builds the lanes Structural is meant
   to ship, stages a `CE_STRUC_SUITE.bundle` payload **including `CE_SHARED.dll`**, and carries the same
   no-deploy flags Civil's already does (`-p:SkipDevBundle=true -p:SkipItAdminPublish=true`).
2. `Modules/Structural/Installer/Deploy-Local-AsAdmin.ps1` — mirrors Civil's, including the SHA256 read-back
   and the CE_SHARED `N upgraded, N already matching, 0 blocked, 0 skipped` line.

**Two questions only Tim can answer:**

- **Which lanes should Structural ship?** Modern only (as now), or all three like Civil?
- **Should the joint release be one script that does Civil and Structural from the same commit**, or two
  scripts run in sequence with a check that the commits match? The rule is that they ship together; the
  shape of enforcing it is a decision.

**Until this is approved, a joint Civil + Structural release from one commit is not possible**, and this
batch's Civil deploy will continue to leave Structural on `5d723d41`. That is not a new problem introduced
tonight — it is the existing state, now measured.

---

## What was NOT done

- No script was created.
- Nothing was deployed or changed.
- The load-order hypothesis in §1 was **not** tested in AutoCAD.
