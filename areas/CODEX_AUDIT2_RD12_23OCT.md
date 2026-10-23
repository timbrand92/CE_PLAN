**ANSWER FIRST — RD12 native protection audit, 23 October 2026, Melbourne**

1. **Counts: HIGH 2 / MEDIUM 3 / LOW 0.** Four findings are SURE, verified-by-reading. One MEDIUM finding is UNSURE, suspected native behaviour. No finding was reproduced in AutoCAD in this read-only audit.

2. **Most important — locked symbols can change during Refresh Blocks.** `CDREFRESHBLOCKS` replaces a shared symbol definition without checking the layers of its placed copies. A locked riser can therefore change shape even though its layer stays locked.

3. **Second — Water Tank bypasses the lock on riser/dropper lettering.** The placement code explicitly permits writing an attribute on a locked layer. It checks the main output layers, but not the attribute's own layer.

4. **Third — level marks can be added to locked layers.** FFL, RL, SSL, NGL and LM use a layer-creation helper as though it also checks permission to draw. It does not. The new symbol and lettering are appended without checking the layer locks.

5. **Other results.** Water Tank can adopt a whole attached Xref as its tank, changing the host drawing's Xref reference and adding a tank record. Hatch Change has no REFEDIT guard; its native behaviour needs the specific test below. These are findings for the builders and AI test lane, not a request for Tim to test.

---

1. **Source and method.** Read `C:\TimOS\RULES.md`, `ROUTER.md`, CE_PLAN start/map and R-00/R-27. Searched `BUG_CARPARK.md` first and checked the supplied earlier audit plus `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md` and `CODEX_AUDIT_GATE_22OCT.md` for overlap. Source was fetched and inspected using Git in the detached audit worktree `C:\ce-cx\rd12`; no code branch or code commit was created.

2. **Pinned versions.** Civil/Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (source versions 3.0.72 / 1.1.72). Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9` (source version 1.0.122). Structural files were read with `git show` at that reference from the same audit worktree. File and line references below belong to these commits. Installed binaries were not inspected, so these version labels identify the requested source, not an independently verified installation.

3. **Meaning of certainty.** SURE means the inspected command-to-writer path establishes the defect; it does not mean a native test passed or failed. UNSURE means a host-dependent step remains unresolved. Every deterministic test below is proposed, not executed. Use synthetic millimetre drawings, World UCS, with snap and dynamic input off. Run the relevant cases in AutoCAD 2027 and 2024 later. Preserve test settings and discard drawing copies afterwards.

4. **Known candidates excluded — BUG numbers only.** BUG-367; BUG-417; BUG-418; BUG-432; BUG-458; BUG-459; BUG-460; BUG-472; BUG-473; BUG-565; BUG-583; BUG-625; BUG-638; BUG-793; BUG-864; BUG-876; BUG-997.

**Numbered findings, ranked**

1. **RD12-01 — HIGH — SURE — Refresh Blocks changes the definition used by locked references. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/RefreshBlocksCommand.cs:54`, `:67`, `:114`, `:121`; `Modules/Drainage/Services/BlockService.cs:684`–`:689`; context helper `Modules/Drainage/Commands/CeCommandBase.cs:19`–`:24`.

   **What the drafter sees:** A riser or pit-label symbol that was locked to protect finished work changes appearance after `CDREFRESHBLOCKS`. The layer remains locked, so looking only at the layer flag gives false reassurance.

   **Exact failure scenario and evidence:** A resident RISER definition differs from the trusted RISER source file and has a reference on a locked layer. The command checks only whether the name exists and whether a source file exists. It passes the definition to `InsertQuietly`, which calls `db.Insert(blockName, sourceDb, true)`. No reference-layer or containing-block protection check occurs before replacement. Changing the shared definition changes the geometry displayed by every reference; opening the locked reference itself for write is unnecessary. The same explicit loop includes DROPPER, PIT LABEL and PIT LABEL 2. This finding uses the non-pit refresh loop, not the automatic pit-migration name/version issue. There is also no REFEDIT check at this command entry, but no additional native REFEDIT outcome is claimed here.

   **DETERMINISTIC TEST — fixture:** Synthetic host DWG containing no PIT BLOCK definitions, a resident ordinary RISER block, and a resolvable trusted RISER source asset. Give the resident definition one unmistakable extra circle of radius 123 mm centred at local 7000,7000, absent from the source asset. All definition members are on unlocked layer 0. Insert RISER at 0,0 on layer AUDIT-LOCK; lock AUDIT-LOCK, with current layer 0. Record the reference handle and the definition's member geometry.

   **Typed steps:** Type `CDREFRESHBLOCKS`, then `REGEN`. Read the RISER definition and the reference's layer flag through a read-only native inspection; inspect the extra circle on screen.

   **Assertion:** While AUDIT-LOCK stays locked, the definition and the protected reference's displayed geometry must remain unchanged. A plain message must name the skipped protected symbol/layer. Current source predicts the extra circle disappears and the CE log contains `CDREFRESHBLOCKS: redefined 'RISER' from ...`. A normal refresh message is not a protection warning. Repeat with the protected RISER nested inside a locked parent insert, to cover indirect use.

   **Smallest fix:** Before replacing a definition, inspect all affected references, including containing references. If any affected occurrence is protected or cannot be proved safe, leave that definition unchanged and report the skipped symbol/layer. Add the reference-edit check before any refresh work. Do not unlock, clone around the protected reference, or replace it with another block.

2. **RD12-02 — HIGH — SURE — Water Tank explicitly force-writes riser/dropper attributes on locked layers. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/WaterTankCommand.Apply.cs:39`–`:46`, `:133`–`:142`, `:245`–`:259`, `:281`–`:289`; `Modules/Drainage/Services/BlockService.cs:1018`–`:1024`, `:1436`–`:1457`.

   **What the drafter sees:** With a lettering layer locked, placing a tank with a riser or dropper still puts its R/D lettering on that protected layer. There is no warning that the lock was bypassed. The layer itself remains locked.

   **Exact failure scenario and evidence:** RISER has a nonconstant attribute definition on locked AUDIT-ATTR. WATER TANK, DOWNPIPES, 25DIMS and GUIDELINES remain unlocked. `DescribeMissingResources` checks only the first three output layers. The existing RISER definition is reused; `AppendAttributesFromDefinition` creates attributes from that definition. `SyncAllAttributesInTransaction` then calls `GetObject(attId, OpenMode.ForWrite, false, true)` and sets `TextString`. The fourth argument explicitly permits opening on a locked layer. Later readback checks the part's layer, position and source tag, not its attribute-layer protection. DROPPER uses the same route. These are newly inserted attributes, not a claim that unrelated existing attribute text is overwritten.

   **DETERMINISTIC TEST — fixture:** Synthetic Civil DWG with an untagged ordinary block AUDIT-TANK at 0,0; resident RISER definition containing a circle on layer 0 and one visible, nonconstant attribute with tag R and default text KEEP, on AUDIT-ATTR. Preload DROPPER as well, so optional ghost preparation does not depend on asset availability. Lock AUDIT-ATTR only. Confirm that the existing RISER definition is reused and that the other named layers are unlocked.

   **Typed steps:** Type `CDWT`; click **Tag a block already in the drawing** (or choose `Adopt` on the command-line fallback). Pick AUDIT-TANK. If asked, choose AboveGround, Type, total 4500 L, detention 0 L. Press Enter to skip the callout; give `2000,0` for RISER; press Enter to skip DROPPER. Placement follows the last answer; there is no separate Accept question on this route.

   **Assertion:** The protected attribute layer must receive no new attribute and remain locked. CE must explain the protected layer before accepting the compound. Current source instead creates a RISER attribute on AUDIT-ATTR and sets its text to the allocated R tag, normally R1 in this fresh fixture; the placement message reports the tank and riser. Read the attribute's own LayerId and TextString, not just the block's DOWNPIPES layer. Repeat independently with a DROPPER attribute on AUDIT-ATTR.

   **Smallest fix:** Preflight the actual attribute-definition layers of each requested part before appending anything, and recheck inside Apply. Remove the forced locked-layer write argument. Report the protected part/layer and leave the unaccepted compound unchanged; do not move the attribute to another layer to evade the lock.

3. **RD12-03 — MEDIUM — SURE — Structural level-mark placement writes onto locked output layers. VERIFIED-BY-READING.**

   **File:line:** `Modules/Structural/Commands/LevelMarkCommands.cs:147`–`:150`, `:188`–`:205`, `:218`–`:235`; `Modules/Structural/Services/LegacyToolCommon.cs:15`–`:21`; `Modules/Structural/Services/LayerService.cs:177`–`:188`.

   **What the drafter sees:** Locking 25DIMS or 25TEXT does not stop FFL placing its triangle, tail and level value there. It prints `Level mark created.` The new work is on a layer the drafter deliberately protected.

   **Exact failure scenario and evidence:** The current layer is unlocked 0; 25DIMS and 25TEXT already exist and are locked. `RunDirect` only acquires the active drawing. `EnsureLayer` returns an existing layer without testing its lock. The command then appends new geometry on 25DIMS and a new DBText on 25TEXT, and commits. Keeping an existing layer's lock flag intact is different from checking permission to add objects to it. FFL, RL, SSL, NGL and LM share this placement writer. This is not the separate ordinary-note recognition fault in Level Update.

   **DETERMINISTIC TEST — fixture:** Blank synthetic Structural mm drawing, DIMSCALE 100, existing unlocked layers 0, 25DIMS and 25TEXT. Lock 25DIMS and 25TEXT through Layer Properties; keep 0 current. Record entity counts on both protected layers.

   **Typed steps:** Type `FFL`, point `0,0`, side `Right`, value `10.000`.

   **Assertion:** Both protected-layer entity counts must remain unchanged, both locks must remain set, and the command must explain the skipped locked output. Current source predicts two additional entities on 25DIMS, one DBText `10.000` on 25TEXT, and `[FFL] Level mark created.` Repeat with each output layer locked alone. As a control, run the same command with both layers unlocked and require the ordinary three-entity mark.

   **Smallest fix:** Check both required output layers in the placement transaction before the first append. Keep the shared layer helper create-only; a separate permission check should leave protected output unchanged and name the layer. The same entry also lacks a REFEDIT check; add that guard, but this finding's SURE verdict rests on the locked-output path.

4. **RD12-04 — MEDIUM — SURE — Water Tank accepts an attached Xref as the block to adopt. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/WaterTankCommand.cs:348`–`:385`; `Modules/Drainage/Commands/WaterTankCommand.Apply.cs:87`–`:97`, `:223`–`:230`, `:263`–`:273`; `Modules/Drainage/Services/SourceTagService.cs:415`–`:439`; `Modules/Drainage/Services/LinkService.Registration.cs:705`–`:744`.

   **What the drafter sees:** Clicking the referenced background when asked for an existing tank can turn the whole Xref reference into WT1. Its host layer becomes WATER TANK and it acquires a tank label and CE tank record. Turning off the water-tank layer can then hide the whole background.

   **Exact failure scenario and evidence:** The selected object is the top-level reference of an attached or overlaid DWG, on an unlocked host layer, with no CE source tag. `AddAllowedClass(BlockReference, true)` accepts its class. Neither the pick validation nor Apply reads the selected reference's BlockTableRecord to check `IsFromExternalReference` / `IsFromOverlayReference`. Apply checks the current space instead; model space passes. It then changes `existing.Layer`, writes source metadata and registers the reference as a tank. The downstream registration does not reject the selected definition either.

   **Boundary:** This alters the Xref reference in the host drawing. It does not prove, and this report does not claim, that CDWT edits the external DWG file or its nested entities. It is nevertheless an unsupported-Xref adoption, contrary to the native-protection requirement.

   **DETERMINISTIC TEST — fixture:** Attach synthetic AUDIT-REFERENCE.dwg, containing a rectangle from 0,0 to 5000,3000, to a fresh Civil host at 0,0, scale 1, angle 0. Put its reference on unlocked AUDIT-XREF. Keep all tank output layers unlocked. Record the host reference handle, layer, extension dictionary and external file hash.

   **Typed steps:** Type `CDWT`; click **Tag a block already in the drawing** or select `Adopt` on fallback. Pick the rectangle's edge so the chosen object is the top-level Xref reference. Supply 4500 L total and 0 L detention if asked. Press Enter at callout, RISER and DROPPER prompts.

   **Assertion:** The selected reference must retain AUDIT-XREF and have no CE tank/source tag; no tank record may name its handle. CE must identify it as an Xref. Current source predicts WATER TANK, a WT tag and the `Water tank placed. Tag:` message. Check the external DWG hash separately: it should remain unchanged, avoiding a false claim of external-file corruption.

   **Smallest fix:** At the pick and again inside Apply, inspect the selected reference's definition and reject external/overlay definitions before changing its layer or metadata. Reuse that check for any definition selected for a new tank part. Do not bind, detach, explode or clone the Xref to make the selection acceptable.

5. **RD12-05 — MEDIUM — UNSURE — Hatch Change can reach its writer during REFEDIT; native selection/write behaviour still needs proof. SUSPECTED.**

   **File:line:** `Modules/Structural/Commands/HatchUpgradeCommands.cs:202`–`:218`, `:248`–`:267`, `:499`–`:523`; `Modules/Structural/Services/DrawingSafetyService.cs:19`–`:45`; `Modules/Structural/Commands/HatchPersistencePolicy.cs:761`–`:813`.

   **What the drafter may see:** While editing a block or Xref in place, applying a CE hatch preset may change the hatch instead of explaining that CE editing is paused during REFEDIT.

   **Verified code versus uncertainty:** `CEHATCHCHANGE` calls the basic `CommandPreFlight`, which checks document/database presence and read-only status only. It does not call the separate reference-edit guard. The rollback snapshot does not establish REFEDIT safety either. Once selection succeeds, the writer opens the selected hatch for write and changes its layer/pattern. No REFEDIT check was found on that route. Whether the exact REFEDIT working-set hatch is selectable and writable through this entry point in each AutoCAD version was not observed; that uncertainty is why this is not SURE. Do not promote a missing-check search hit to a reproduced external-file edit.

   **DETERMINISTIC TEST — fixture:** Synthetic host containing ordinary block AUDIT-HATCH with a closed rectangle and one SOLID hatch on unlocked AUDIT-HATCH-LAYER. DIMSCALE 100, LTSCALE 1000. Use an isolated test profile and preload the target preset's dependencies. Record the hatch's properties and the block definition. First run the same preset change outside REFEDIT on a separate copy to prove the fixture can reach the writer.

   **Typed steps:** In the untouched copy, type `REFEDIT`, pick AUDIT-HATCH, accept a working set containing its hatch and rectangle. Verify REFEDITNAME is nonblank. Type `CEHATCHCHANGE`, pick that hatch, Enter; choose **Solid 10** and click **Apply preset**. Read the working hatch before closing REFEDIT. Afterwards use `REFCLOSE` and Discard on this test copy. Repeat separately with AUDIT-HATCH supplied by an attached synthetic DWG.

   **Assertion:** While REFEDITNAME is nonblank, no hatch property, layer, draw order or block-definition value may change, and CE must give a plain reference-edit explanation. A `Changed 1 hatch(es)` line plus changed native hatch properties proves failure. If the native host refuses selection or write first, record that refusal and leave the suspected outcome unconfirmed; a generic error is not evidence that CE's guard ran. No persistence to an external DWG is asserted without a separate Save-reference check on a disposable fixture.

   **Smallest fix if confirmed:** Add a reference-edit guard that works in either model or paper space, before prompts and immediately before Apply; preserve the existing hatch rollback checks. Do not use the model-space-only guard to introduce an unrelated layout restriction.

**Coverage and limits**

1. **Protection paths inspected beyond findings.** Reviewed the native 2027 MR/CR writer: it checks REFEDIT before selection and again before commit, checks selected entity and attribute layers, rejects unsupported top-level classes and external/overlay block definitions, and revalidates before cloning. Reviewed Civil source-retag repair's route into source-change admission, the tank compound writer, selected forced-write sites, and Structural layer/preflight helpers. A forced-write text match alone was not treated as a defect: some sites check protection first.

2. **What I did NOT check.** No builds, unit tests, native tests, AutoCAD/accoreconsole, installation, window rendering or sub-agents. No claim of complete coverage of every command, overrule, nested block, proxy, dynamic-block state, long transaction or older-runtime transform fallback. No claim that an external DWG file was changed. No installed-file or live-setting verification. Native prompt acceptance, transactions, Undo/Redo, saving/reopening and the REFEDIT case remain for the later AI test lane. Manager administrator work and engineering-number policy changes were outside scope.

3. **Only authorised deliverable.** This report is the sole authored repository file. Existing work in the code checkout and CE_PLAN was left alone. No BUG_CARPARK, DESK_LOG, QUEUE, code, build output or settings edit; no bug marked fixed. The disposable detached worktree is removed after the read. CE_PLAN delivery uses the named file only, fetch and merge from origin/main, and a normal push through the leak-scan hook.

4. **Summary — under 100 words.** Four code-proven protection faults and one suspected REFEDIT route were found. Prioritise shared-block refresh around locked references and CDWT's forced attribute writes. Also guard Structural level-mark output layers and stop Water Tank adopting Xrefs. The hatch REFEDIT result needs native confirmation. No plugin change or test was performed; each finding includes a reproducible synthetic case and a narrow fix. Existing bugs are excluded, and nothing is declared fixed or accepted.
