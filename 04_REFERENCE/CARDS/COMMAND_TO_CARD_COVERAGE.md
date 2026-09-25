# Command-to-card coverage

**Source:** the three current module registry JSON files · **Generated for planning:** 2026-07-23

This is a planning reconciliation of the current registry inputs, not the future authoritative Tool Register.
It maps 354 registry rows and their 42 declared aliases. `UNMAPPED` fails closed as `Hidden + Review Pending`.

**AI-01 connection — 2026-09-13:** `CEASK` is now the canonical shared Ask CE registry name and `CDASK` its retained Civil alias. The dated CT-01 comparison tables below preserve the command sets inspected at those checkpoints.

## Civil corrective baseline — updated 2026-07-24

The Civil migration input now matches its compiled Staff DLL exactly: **97 compiled command names and 97
registry names/aliases, with zero Civil compiled-only or registry-only differences**. The registry contains 95
rows: active/visible commands, declared aliases and working/internal commands recorded as
`Hidden + Review Pending`. Six removed catalogue ghosts were deleted; `TG` is a working hidden redirect to
`CDTG`; Civil Spot Level is `CDSL`; Structural retains `SL`; `PP` is the approved
CV-01J3D shortcut into the existing PIT flow.

The unified Civil ribbon now maps both `Draft` and `Layout` groups to the Layout panel. A permanent test proves
every visible Civil registry entry appears on the ribbon, including `CDSL`, `CDSRZ` and `CDTPZ`. This correction
does not declare the remaining Structural historical drift resolved.

## CT-01A compiled baseline — 2026-07-22

The first non-blocking comparison now reads the AutoCAD command records directly from the compiled CE DLLs.
It does not open AutoCAD, load the plugin or load Autodesk runtime assemblies. This first slice covers the
current AutoCAD 2027 / `net10.0-windows` outputs; cross-runtime comparison remains pending under `CT12`.

| Module | Compiled command names | Registry names and aliases | Inspected DLL SHA-256 |
|---|---:|---:|---|
| Civil | 99 | 79 | `325FC35EF3E9289BC539DAC824F6CF3CEC4315311C1D8DF8CBAEBD9EA1FBC5BC` |
| Manager | 8 | 8 | `16130A7E9F397A56C9F2A010640277FB56FAAFFEDCAC19A23D037FDE28CC32E9` |
| Structural | 306 | 276 | `321DFFDE8624AE050BF8215A27DBB5A64C8F42F2DB786D440509D81138E66855` |

The baseline contains **86 visible differences**: 66 compiled-only names, 16 registry-only names and four
commands with more than one compiled module owner. These are a migration backlog, not permission to hide or
remove working commands. The first report is deliberately non-blocking under `CT15`.

| Difference | Commands |
|---|---|
| Duplicate compiled owners | `CEHEALTH` (Civil/Manager/Structural); `COPYROT` and `MOVEROT` (Civil/Structural); `CESUPPORT` (Manager/Structural) |
| Civil compiled-only (29) | `C`, `CDASK`, `CDAUDITDETAIL`, `CDGRAPH`, `CDIMPORTAUDIT`, `CDLEGACYAUDIT`, `CDLPD`, `CDLPDRESET`, `CDMENU`, `CDPARTS`, `CDPIT1200`, `CDPIT350`, `CDPIT450`, `CDPIT600`, `CDPIT900`, `CDPROPAGATE`, `CDREBUILDLINKS`, `CDSL`, `CDSLABEDIT`, `CDSLABEREGEN`, `CDSTARTUPAUDIT`, `CDTEST_RUNSCENARIO`, `CDTRENCHGRATEAUDIT`, `CECDTESTSPIKE`, `CEHEALTH`, `COPYROT`, `CR`, `MOVEROT`, `MR` |
| Structural compiled-only (37) | `?CE`, `BPC`, `BPFC`, `BSFC`, `BTHC`, `CEMARKUPDWGEXPORT`, `CEPROJECTPROPS`, `CEPROPS`, `CESETTINGS`, `CESHEETS`, `CESHEETSCLASSIC`, `CESHEETSMANAGER`, `CE_FFL`, `CE_INSPECT`, `CE_NGL`, `CE_RL`, `CE_SSL`, `CE_STRUC_SUITE`, `CML`, `EXCELCAPTUREAREA`, `EXCELCAPTURESELECTION`, `JOBTIMERDEBUG`, `JOBTIMEREDIT`, `LBW`, `ML`, `NGL`, `P1`, `PFC`, `R2LTXT`, `RL`, `SCREWPILE`, `SF`, `SFC`, `SSL`, `STUMPFOOTING`, `THC`, `WALLSTRS` |
| Civil registry-only (9) | `CDCALCOLD`, `CDEXPLODE`, `CDLINK`, `CDMOVE`, `CDMOVEALL`, `CEMANAGER`, `PIPEINFO`, `SL`, `TG` |
| Structural registry-only (7) | `BMT2TXT`, `BTXT2MT`, `C`, `CEP`, `CR`, `MR`, `XCLMTXTINDEX` |

No Manager-only mismatch was found. No command behaviour, ribbon, Help entry or live bundle changed in CT-01A.

## CT-01B cross-runtime parity — 2026-07-22

The compiled check now covers all three supported AutoCAD runtime lanes. Each module exposes exactly the same
case-insensitive command-name set in every lane; there are **zero runtime-only or runtime-missing command names**.

| Module | AutoCAD lane | Runtime | Commands | Inspected DLL SHA-256 |
|---|---|---|---:|---|
| Civil | 2022–2024 | `net48` | 99 | `B60822F6CBBF3899D334251E4DCD0C15008B32F6596C8B56B619F164EC33EB7E` |
| Civil | 2025–2026 | `net8.0-windows` | 99 | `DC73D2E950D50C6D05310319031657694E3E9372A11EBB718CE427EC0AA37914` |
| Civil | 2027+ | `net10.0-windows` | 99 | `23F73A9CA53DB6CDDB726205225840CCED17CA0FF97F6CE27384D6EDFE05855F` |
| Structural | 2022–2024 | `net48` | 306 | `8390B6F799F0019B6F1FEB7B953CDA242C02FFAD4ED5E690AA5CC0A8C6715070` |
| Structural | 2025–2026 | `net8.0-windows` | 306 | `93037048FF6DAE8AEB9D95AD1C00ACC015367DA4E93672667C071EA3E085B589` |
| Structural | 2027+ | `net10.0-windows` | 306 | `F66DB9A2ADD646A21D515AB9A2741D3BE0CF4AB9F9B50CCB245BBBF93FB6C2B7` |
| Manager | 2022–2024 | `net48` | 8 | `13F1085D4102F041E27EFF3201D0CEAEE18F6D98B2B439C8ED5DCFE628996B42` |
| Manager | 2025–2026 | `net8.0-windows` | 8 | `E8ADBD0CA8EE43F7FA499D799AE3350319905FBE8701D3E9A0A79780CD8AF35F` |
| Manager | 2027+ | `net10.0-windows` | 8 | `38BD32F8D81FF2B5106C6E18C2A3E04654130853652FCC071A71D48DB70A6E15` |

CT-01B also closed the missing `CE_SHARED` 2025–2026 build lane and the Manager icon-library restore gap that
prevented that DLL from compiling. No command body, ribbon layout, Help entry or installed bundle changed.
The existing 86 command/register differences remain the next ownership/treatment backlog.

## CT-01C approved global-command ownership — 2026-07-22

Manager is now the sole compiled, registry and manifest owner of `CEMANAGER`, `CEHEALTH` and `CESUPPORT` in
all three AutoCAD runtime lanes. Civil and Structural health/support methods remain in source for later Manager
service consolidation, but no longer register competing AutoCAD commands. The separate TF-01
`MOVEROT`/`COPYROT` overlap remains visible.

| Module | AutoCAD lane | Commands | Inspected DLL SHA-256 |
|---|---|---:|---|
| Civil | 2022–2024 | 98 | `AB3BB442F7E9AE57BC710E3F9439DFC0E39ECE5264D84DAD2305970ABF6F4D56` |
| Civil | 2025–2026 | 98 | `0E74A852480ABD0A9C196BA4757522D4822E4077DAE439123049AF6431CB7221` |
| Civil | 2027+ | 98 | `A3FB8FF122702BF16BB1E7DD89AB7248B84049B6A4B00CB11BF2B915E6DC83C7` |
| Structural | 2022–2024 | 304 | `E2B1D509A1E97EFFEF3A106A439BA5BCC655B12DAD0E53B6DEC71633951EE818` |
| Structural | 2025–2026 | 304 | `D3348F7125B11FDC93A495C16FE11F374C7254833072005BF27A7DBF0D153D06` |
| Structural | 2027+ | 304 | `EA66820F5A477599B6A791404A360AD465C156E02B535FB811279811300CC7CE` |
| Manager | 2022–2024 | 8 | `C6EB3C4E3D51F2D87EDFC5BE5A11F723D9F05FCAD6C78DC5AC3771AC123BCC4D` |
| Manager | 2025–2026 | 8 | `594CF4809CDD86EE97C100AF5CCF633B4B5EC23BBB7E79E6A6D6A40B9B09F236` |
| Manager | 2027+ | 8 | `E2F6975A4567BEBCE4451E1D225DC7C702BB4D9FE23A5FF4635698D471A1D741` |

The current baseline has **82 visible differences**: 65 compiled-only names, 15 registry-only names and the
two TF-01 transform-owner overlaps. CT-01C itself needs no AutoCAD test and did not deploy a bundle.

## TH-01 Staff/test command separation — 2026-07-22

The two historical Civil test commands are removed from all Staff Civil DLLs. A separate Test-only package owns
one entrypoint, `CE_TEST_RUN`, and the official release gate rejects that command, the retired command names or
any `CE_TEST_HARNESS` file in a Staff-capable package.

| Assembly | AutoCAD lane | Commands | Inspected DLL SHA-256 |
|---|---|---:|---|
| Staff Civil | 2022–2024 | 96 | `11C0930FE37CE80595A29434E912A8E9A6C2C392293FED9875EE50FF0BB32A79` |
| Staff Civil | 2025–2026 | 96 | `13818DE685095E913BB4DB4919C01DE0C8F45E28F64C08FCEEEE20FD359668AB` |
| Staff Civil | 2027+ | 96 | `D421A61F851726FFE484683BAAE0C72D36FB15F26B7BB7523EEDAC9CA65DE121` |
| Test Harness | 2022–2024 | 1 | `4FA6F10FCEA93AC2169CA49CBDEF77BE65B95E157D455A60C7BFE229BB3DDFB0` |
| Test Harness | 2025–2026 | 1 | `3913D4E40A1F1CEB297F5C41914A57DF691F07B73BB70136DF1487BEDF81824E` |
| Test Harness | 2027+ | 1 | `B5F79693666D35F71E75C8B10B22E976FD7DB551AC1F6CD91B853136F45EB5BF` |

The current command/register baseline is therefore **80 visible differences**: 63 compiled-only names, 15
registry-only names and the two TF-01 transform-owner overlaps. TH-01 did not deploy a bundle; its first
synthetic AutoCAD scenario and Tim visual acceptance remain pending.

## CT-01D/E central Tool Register foundation — 2026-07-23

`Assets/Config/ce-tool-register.json` is now the permanent identity authority for the first ten qualified
tools. Runtime surfaces remain on their legacy module files until later incremental migration.

| Permanent tool ID | Owner | Command | Status |
|---|---|---|---|
| `manager.suite-manager` | Manager | `CEMANAGER` | Active + Approved |
| `manager.health` | Manager | `CEHEALTH` | Active + Approved |
| `manager.support` | Manager | `CESUPPORT` | Active + Approved |
| `civil.pipe-layout` | Civil | `CD` | Active + Approved |
| `civil.pit-layout` | Civil | `PIT` | Active + Approved |
| `civil.edit` | Civil | `CDEDIT` (`PIPEEDIT`, `PITEDIT`) | Active + Approved |
| `civil.inspector` | Civil | `CDINSPECTOR` | Active + Approved |
| `civil.pit-schedule` | Civil | `PITSCHEDULE` | Active + Approved |
| `civil.hub` | Civil | `CDHUB` | Active + Approved |
| `civil.design-review` | Civil | `CDDASHBOARD` | Active + Approved |

The central record pins the 95 Civil, 251 Structural and 8 Manager legacy rows by path/count/SHA-256. Offline
validation rejects duplicate IDs or global command/alias ownership and incomplete qualified-tool evidence.
The seven qualified Civil destinations are additionally pinned Active + Approved and must retain one Civil
compiled/registry owner in all three runtime lanes.
`migrationComplete=false`; no command, ribbon or Help surface changed.

| Measure | Count |
|---|---:|
| Drainage registry rows | 95 |
| Structural registry rows | 251 |
| Manager registry rows | 8 |
| Declared aliases | 42 |
| Unmapped rows that fail closed | 7 |

| Module | Command | Declared aliases | Canonical card | Planning decision |
|---|---|---|---|---|
| Drainage | `CD` | — | `CV-01` | Mapped to approved card; implementation not started |
| Drainage | `PIT` | — | `CV-01` | Mapped to approved card; implementation not started |
| Drainage | `PP` | — | `CV-01J` | Approved quick 350×350 plastic-pit entry into the existing PIT workflow |
| Drainage | `CDEDIT` | `PIPEEDIT`, `PITEDIT` | `CV-01` | Mapped to approved card; implementation not started |
| Drainage | `SL` | — | `CT-01` | Mapped to approved card; implementation not started |
| Drainage | `CDINSPECTOR` | — | `CV-01` | Mapped to approved card; implementation not started |
| Drainage | `CDRUNSOLVE` | — | `CV-01` | Mapped to approved card; implementation not started |
| Drainage | `DP` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `IO` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `OF` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `FO` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `CDTG` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `CDRG` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `CDSLAB` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `CDSLABIMPORT` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `CDSPOON` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `GIO` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `CDSURVEY` | — | `CV-07` | Mapped to approved card; implementation not started |
| Drainage | `CDTAG` | — | `CV-03` | Mapped to approved card; implementation not started |
| Drainage | `PITSCHEDULE` | — | `PS-01` | Mapped to approved card; implementation not started |
| Drainage | `CDHUB` | — | `SH-01` | One approved Civil Hub doorway; NH-01B2 |
| Drainage | `CDPROFILE` | — | `CV-06` | Mapped to approved card; implementation not started |
| Drainage | `CDDASHBOARD` | — | `QA-01` | Mapped to approved card; implementation not started |
| Drainage | `CDCALC` | — | `CV-06` | Mapped to approved card; implementation not started |
| Drainage | `PITDELETE` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDMA` | — | `CV-02` | Existing registry Hidden; review before exposure |
| Drainage | `CDTEXTSEG` | — | `CV-02` | Existing registry Hidden; review before exposure |
| Drainage | `CDFALL` | — | `CV-02` | Mapped to approved card; implementation not started |
| Drainage | `CDANNOTATIONEDIT` | — | `CV-02` | Mapped to approved card; implementation not started |
| Drainage | `CDMANAGER` | — | `SH-04` | Mapped to approved card; implementation not started |
| Drainage | `CDS` | — | `SH-04` | Mapped to approved card; implementation not started |
| Drainage | `CDIMPORTCOMPARE` | — | `CV-07` | Mapped to approved card; implementation not started |
| Drainage | `CDEXPORTENTITIES` | — | `CV-07` | Mapped to approved card; implementation not started |
| Drainage | `CDREPAIR` | — | `CV-08` | Mapped to approved card; implementation not started |
| Drainage | `CDDISCIPLINE` | — | `CV-08` | Mapped to approved card; implementation not started |
| Drainage | `CDFEEDBACK` | — | `PD-01` | Mapped to approved card; implementation not started |
| Drainage | `CDDIAG` | — | `PD-01` | Retire/redirect to Manager diagnostics |
| Drainage | `CDHELP` | — | `SH-01` | Mapped to approved card; implementation not started |
| Drainage | `PIPEEDIT` | — | `CV-01` | Duplicate/alias row — consolidate |
| Drainage | `PITEDIT` | — | `CV-01` | Duplicate/alias row — consolidate |
| Drainage | `PIPEINFO` | — | `UNMAPPED` | Hidden + Review Pending |
| Drainage | `CDCALCOLD` | — | `CV-06` | Retire superseded calculator |
| Drainage | `TG` | — | `CV-03` | Existing registry Hidden; review before exposure |
| Drainage | `CDEXPLODE` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDLINK` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDMOVE` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDMOVEALL` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDLABELSTYLE` | — | `SH-04` | Existing registry Hidden; review before exposure |
| Drainage | `CDIMPORTXCIVIL` | — | `CV-07` | Hidden until CV-07 quality gate |
| Drainage | `CDIMPORTLANDXML` | — | `CV-07` | Existing registry Hidden; review before exposure |
| Drainage | `CDEXPORTCORPUS` | — | `DATA-01` | Blocked by DATA-01 Gate 0 |
| Drainage | `CDCHECKDWG` | — | `CV-07` | Mapped to approved card; implementation not started |
| Drainage | `PIPEPITLINK` | `LINKPIPEPIT` | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `PIPEPITUNLINK` | `CLEARPIPEPITLINK` | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDSYNC` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDREBUILD` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDLINKDANGLINGPIPES` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDUPGRADE` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDRECOVERINVERTS` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDAUDIT` | — | `CV-08` | Rebuild as physically read-only audit |
| Drainage | `CDDEBUG` | — | `CV-08` | Internal/expert — exclude from Staff surface |
| Drainage | `CDFOCUS` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDVER` | — | `SH-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDTRIAGE` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDREFRESHBLOCKS` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDREFRESHLINKS` | — | `CV-08` | Existing registry Hidden; review before exposure |
| Drainage | `CDPIPEOVERRIDE` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDPIPEOVERRIDECLEAR` | — | `CV-01` | Existing registry Hidden; review before exposure |
| Drainage | `CDJOINT` | — | `CV-05` | Preview-only until joint rules approved |
| Drainage | `CDCJ` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `CDSC` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `CDSTRIP` | — | `CV-04` | Mapped to approved card; implementation not started |
| Drainage | `CDWT` | — | `CV-04` | Mapped to approved card; implementation not started |
| Drainage | `CDFW` | — | `CV-04` | Mapped to approved card; implementation not started |
| Drainage | `CDSOURCE` | — | `CV-04` | Mapped to approved card; implementation not started |
| Drainage | `CDAGI` | — | `CV-04` | Mapped to approved card; implementation not started |
| Drainage | `CDSRZ` | — | `CV-05` | Mapped to approved card; implementation not started |
| Drainage | `CDTPZ` | — | `CV-05` | Mapped to approved card; implementation not started |
| Structural | `CEADMIN` | — | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CEHELP` | `CE_HELP` | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CEADMINSETTINGS` | `CEADS` | `SH-04` | Mapped to approved card; implementation not started |
| Structural | `CE_VERSION` | `VER` | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CE_SECTIONMARK` | `SECTION`, `SM` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_LEVELMARK` | `LM` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_LEVELUPDATE` | `LMU` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_ARCDIM` | `RD` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_REBARLINE` | `RBL`, `REBARLINE` | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `CE_REBARCIRCLE` | `RBC`, `REBARCIRCLE` | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `CE_STIRRUP` | `STR`, `STIRRUP` | `ST-06` | Retire under ST-06 ruling |
| Structural | `CE_BARWEIGHT` | `BWT`, `BARWEIGHT` | `ST-06` | Retire under ST-06 ruling |
| Structural | `CE_MEMBERLABEL` | `LABEL` | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `CEMARKUP` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPBENCH` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPLOAD` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPPARSE` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPPLAN` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPPREVIEW` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPREGISTER` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPRUN` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPSTATUS` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPUNDO` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `CEMARKUPVIEW` | — | `ST-09` | Park/rebuild under ST-09; unsafe legacy executors prohibited |
| Structural | `STRIPLAYERSMERGE` | — | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `STRUCLINKTEXT` | — | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CECHECKLIST` | — | `ST-09` | Mapped to approved card; implementation not started |
| Structural | `CENOTES` | — | `ST-09` | Mapped to approved card; implementation not started |
| Structural | `CESTRUC` | — | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CETOOLS` | `CETOOLSTOGGLE` | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CETOOLSTOGGLE` | — | `SH-01` | Duplicate/alias row — consolidate |
| Structural | `AD` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `DSET` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `DSET1` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `DUP` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `LD` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `Q` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `QD` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_MLEADERRIGHT` | `MLR` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CE_MLEADERLEFT` | `MLL` | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `BL` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `10H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `141H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `201H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `21DH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `21H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `21LH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `238H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `242H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `31H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `51H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `74H` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `BLH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `CH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `EH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `H2A` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `LBH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `LBUH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `PH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `WH` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `EXCELMAPFLOOR` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `EXCELMAPFLOORAREA` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `XCLMTXT` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `EXCELMTEXT` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `EXCELMTEXTNEW` | — | `ST-07` | Existing registry Hidden; review before exposure |
| Structural | `XCLMTXTINDEX` | — | `ST-07` | Ghost/duplicate — reconcile under CT-01 |
| Structural | `STRSCHEDCREATE` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `STRSCHEDREFRESH` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `STRSCHEDSYNC` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `1` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `2` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `4` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `5` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `8` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BEXT` | `BEXTEND` | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BEXTEND` | — | `ST-01` | Duplicate/alias row — consolidate |
| Structural | `BDL` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BSET` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BSETRESET` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BSETLIST` | — | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BMT2TXT` | — | `ST-01` | Ghost/duplicate — reconcile under CT-01 |
| Structural | `BTX` | `BTXT2MT`, `BMT2TXT` | `ST-01` | Mapped to approved card; implementation not started |
| Structural | `BTXT2MT` | — | `ST-01` | Ghost/duplicate — reconcile under CT-01 |
| Structural | `AB` | `STRUCAB` | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `ABFLIPAUTO` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `ABS` | `ABSWITCH`, `STRUCABS` | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `ABSWITCH` | — | `ST-02` | Duplicate/alias row — consolidate |
| Structural | `BB` | `STRUCBB` | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `BT1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `STRUCAB` | — | `ST-02` | Duplicate/alias row — consolidate |
| Structural | `STRUCABS` | — | `ST-02` | Duplicate/alias row — consolidate |
| Structural | `STRUCBB` | — | `ST-02` | Duplicate/alias row — consolidate |
| Structural | `FJ1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `R1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `RJSET` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `BATLINE` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `BATTER` | `BATLINE` | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `C1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `C2` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `DS` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `DS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `SC1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `SC2` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `SDS` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `SDS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `STS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `SUPTEXTAUTO` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `TC1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `TDS` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `TDS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `TS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `TTS1` | — | `ST-02` | Mapped to approved card; implementation not started |
| Structural | `18B` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `18L` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `18R` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `18T` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25B` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25C` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25L` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25LC` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25R` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25RC` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `25T` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BEBB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BEBT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BIBB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BIBT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPFCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPFCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BPR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BSFB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BSFCB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BSFCT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BSFT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BTHCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `BTHCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `C` | — | `ST-04` | Retire CE registration; PGP/native COPY owns C |
| Structural | `CEDEBUG` | — | `ST-04` | Internal/expert — exclude from Staff surface |
| Structural | `CEMCOPY` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `CL1` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `COPYM` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `CR1` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `DSL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `DSR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `EBB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `EBT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `IBB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `IBT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PFCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PFCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PFL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `PFR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SFB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SFCB` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SFCT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SFT` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `SR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `THCL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `THCR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `THL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `THR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `TSL` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `TSR` | — | `ST-04` | Mapped to approved card; implementation not started |
| Structural | `CLEAN` | `FASTSAVE` | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `FASTSAVE` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `STRUCEXPORTBLOCKS` | — | `AS-01` | Mapped to approved card; implementation not started |
| Structural | `STRUCEXPORTCSV` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `STRUCEXPORTPDF` | — | `ST-07` | Mapped to approved card; implementation not started |
| Structural | `CENTERLINE` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CENTRELINE` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CJ` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CJSS` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CL` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `CLINE` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `COPYROT` | — | `TF-01` | Mapped to approved card; implementation not started |
| Structural | `CPB` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `CR` | — | `TF-01` | Mapped to approved card; implementation not started |
| Structural | `DIV` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `DIVX` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `FFL` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `FFLMARKER` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `FLMK` | — | `ST-03` | Mapped to approved card; implementation not started |
| Structural | `LU` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `MOVEROT` | — | `TF-01` | Mapped to approved card; implementation not started |
| Structural | `MR` | — | `TF-01` | Mapped to approved card; implementation not started |
| Structural | `MTS` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `RB` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `RBL` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `RC` | — | `ST-09` | Mapped to approved card; implementation not started |
| Structural | `REBAR` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `REBARLINE` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `SCAB` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `SCABBLE` | — | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `SPW` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `SPW3` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `SPW6` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `SPWC` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `SSC` | — | `UNMAPPED` | Hidden + Review Pending |
| Structural | `CXREF` | `PXREF` | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `PXREF` | — | `ST-05` | Duplicate/alias row — consolidate |
| Structural | `XRL` | `XRLFAST`, `XRLSILENT`, `XRLCONFIG`, `XRLINFO` | `ST-05` | Mapped to approved card; implementation not started |
| Structural | `XRLCONFIG` | — | `ST-05` | Duplicate/alias row — consolidate |
| Structural | `XRLFAST` | — | `ST-05` | Duplicate/alias row — consolidate |
| Structural | `XRLINFO` | — | `ST-05` | Duplicate/alias row — consolidate |
| Structural | `XRLSILENT` | — | `ST-05` | Duplicate/alias row — consolidate |
| Structural | `FTHC` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FPFC` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FSF` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `REB` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `RIB` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `BP` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FEDIT` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FDELETE` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FADOPT` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FREGEN` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FREGENALL` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FST` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `FSTEXPORT` | — | `ST-06` | Mapped to approved card; implementation not started |
| Structural | `CEPALETTE` | `CEP` | `SH-01` | Mapped to approved card; implementation not started |
| Structural | `CEEXPORTNOTES` | — | `ST-09` | Mapped to approved card; implementation not started |
| Structural | `CERECOVERY` | — | `PD-01` | Mapped to approved card; implementation not started |
| Structural | `SBEAM` | — | `ST-08` | Mapped to approved card; implementation not started |
| Structural | `RCBEAM` | — | `ST-08` | Mapped to approved card; implementation not started |
| Structural | `RCRECTCOL` | — | `ST-08` | Mapped to approved card; implementation not started |
| Structural | `RCCIRCCOL` | — | `ST-08` | Mapped to approved card; implementation not started |
| Structural | `BSSLAB` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `LIGS` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `COLTIES` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `WALLREO` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `STLCONN` | `STLCONN1`, `STLCONN3` | `ST-08` | Mapped to approved card; implementation not started |
| Structural | `PORTAL` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `TRUSS` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `PURLINS` | `PPURLINS` | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `ANGLES` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `BOLTS` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `BRACE` | `SWBRACE` | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `BASEDET` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `GUSSETS` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `RIDGE` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `KNEE` | — | `ST-08` | Missing — hide until own approved Tool card |
| Structural | `BEAMLINKMIGRATE` | — | `ST-01` | Existing registry Hidden; review before exposure |
| Structural | `BEAMLINKDEBUG` | — | `ST-01` | Internal/expert — exclude from Staff surface |
| Structural | `CEAUTOSUPPORT` | — | `ST-02` | Existing registry Hidden; review before exposure |
| Structural | `CEAUTOSUPPORTCLEAR` | — | `ST-02` | Existing registry Hidden; review before exposure |
| Structural | `CEAUTOSUPPORTREF` | — | `ST-02` | Existing registry Hidden; review before exposure |
| Structural | `CEAUTOSUPPORTREFCLEAR` | — | `ST-02` | Existing registry Hidden; review before exposure |
| Manager | `CEMANAGER` | — | `SH-01` | Sole owner confirmed by CT-01C |
| Manager | `CEMANAGERREFRESH` | — | `SH-01` | Mapped to approved card; implementation not started |
| Manager | `CESURVEYREVIEW` | — | `CV-07` | Manager Review workspace doorway for Survey Intake (CV7-2); built 2026-09-13, native acceptance pending |
| Manager | `CEMANAGERDIAG` | — | `PD-01` | Mapped to approved card; implementation not started |
| Manager | `CEMANAGERLOGS` | — | `PD-01` | Mapped to approved card; implementation not started |
| Manager | `CEMANAGERADMIN` | — | `SH-01` | Mapped to approved card; implementation not started |
| Manager | `CEMANAGERUPDATES` | — | `RS-01` | Mapped to approved card; implementation not started |
| Manager | `CEHEALTH` | — | `PD-01` | Sole owner confirmed by CT-01C |
| Manager | `CESUPPORT` | — | `PD-01` | Sole owner confirmed by CT-01C |

## Known truth gaps outside the registry rows

- The confidence audit identifies compiled/off-register commands including `JOBTIMERDEBUG`, `JOBTIMEREDIT`, `CEMARKUPDWGEXPORT` and `P1`.
- The current AI entrypoint and any provider bridge commands must be reconciled against compiled output during `CT-01`; absence from these three registries does not authorise exposure.
- `BMT2TXT`, `BTXT2MT` and `XCLMTXTINDEX` are registry ghosts/duplicates in current evidence and cannot pass command truth unchanged.
- `C` and duplicate Shared transforms remain for the owner corrections locked in `SH-01` and `TF-01`; CT-01C cleared the `CEHEALTH`/`CESUPPORT`/`CEMANAGER` overlaps.

## Release rule

Every row must ultimately resolve to one permanent Tool ID, one owner, one canonical command, safe aliases, Help, permissions, status and automated guard. Any unexplained compiled/register/ribbon/Help difference blocks promotion.
