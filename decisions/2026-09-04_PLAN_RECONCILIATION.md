# CE ACAD — plan/board reconciliation, 4 September 2026

## Authority and scope

Tim approved items 1–4 of the preceding Codex review: refresh the existing GitHub board,
correct sequence/ownership, reconcile the two V3 drafts and refresh older master summaries.
He also answered D1–D10 explicitly. This is a documentation/board change, not permission to
modify plugin behaviour, build, deploy, merge Claude's code, remove folders or delete chats.
The attached storage screenshot is historical evidence, not a deletion instruction.

Authority order:
1. Tim's explicit current decisions and approved engineering/workflow cards.
2. GitHub [#24](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24) + [project 2](https://github.com/users/timbrand92/projects/2) for current delivery status.
3. V3_0_PLAN.md for consolidated Civil scope; CLEAN_SLATE_REBUILD.md for enduring architecture/safety.
4. Dated regression/test/deployment records for evidence; archived drafts/research for reference.

## D1–D10 — Tim's answers (verbatim choices, 2026-09-04)

| ID | User choice | Interpretation / boundary |
|---|---|---|
| D1 | Store centreline, compute all six (Recommended) | One geometry; six named derived lengths; no competing length truth |
| D2 | Explicit per-object command (Recommended) | No automatic-on-open upgrade; reversible per-object operation and older-version preservation need proof |
| D3 | Main stays one pipe with a node (Recommended) | Do not split the logical main merely because a branch meets it |
| D4 | Mark Stale, re-check on demand (Recommended) | Relevant edits invalidate results; re-check is deliberate; never silently fix |
| D5 | Project Explorer + Prospector + Vistas (Recommended) | Design reference for C4, not a Civil 3D dependency |
| D6 | Civil 3D field set plus a Stale link (Recommended) | Boundary, runoff coefficient, most-distant point, flow path, Tc, linked structure; source-geometry link can be Stale |
| D7 | AS/NZS 3500.3 + Rational Method + council matrix (Recommended) | Calculation-authority choice; individual values still sourced/approved |
| D8 | Yes, all three (Recommended) | Catalogue-size grip, consistent action-shape language, Reset Position; AutoCAD acceptance still required |
| D9 | Keep the DWG geometry as the model | Reject LandXML-authoritative replacement. Any supplementary reconciliation remains a reviewed C5 contract |
| D10 | Yes, replace and keep old as negative test (Recommended) | Accept bounded fixture correction; not blanket corpus/AI clearance |

Week-1 answers are preserved in [#25](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/25#issuecomment-5522032118).
C5 stays BEFORE C6. Claude owns behaviour/spine/deployment; Codex owns windows.
M1 remains independent and is required for S3. No repeated 13-question batch is required.
The multi-inlet/outlet pit-drop pairing choice is still open; D1–D10 did not answer it.

## Progress that must not be lost

| Evidence | State / exact reference | Limitation |
|---|---|---|
| Main branch | master e51ee3e9 at readback | Does not yet contain Claude's new spine branch |
| Combined Civil | claude/c1-shared-spine 9050f497 | Branch integration is not a merge to master |
| Latest recorded deployment | 2026.0904.1057, 11:07 Sydney; [receipt](https://github.com/timbrand92/CE_ACAD_PLUGIN/issues/24#issuecomment-5534208257) | Reported six matching DLL hashes; not independently remeasured here |
| Modern Civil test sweep | 5276 passed, 0 failed, 17 skipped per combined-candidate record | Not all-version runtime acceptance |
| Earlier C0 tests | Managed actions and twin selection passed on earlier exact builds, #26 timeline | Subsequent glyph changes mean newest package still needs its consolidated acceptance |
| C1 | Shared library, IDs, relationships, sources, attachments/slabs, CDCHECK and CSV; early 96/96 upgrade rollback field result | Full current C1 scope not accepted |
| C4 | 0/20/50 mm project setting and read-only pit-drop checks | Full review workspace and wider rulebook not built by this slice |
| Research | aba5e3e8, synthesis + R1–R8 | Evidence, not automatic approval of every proposal |
| LandXML test correction | 1801d1ce on claude/adoring-nightingale-e0d939 | Fixture/test change only; five desired-behaviour tests expose an unfixed parser |
| CI | PR #43 at ecdb1cdc; [run](https://github.com/timbrand92/CE_ACAD_PLUGIN/actions/runs/33823896659) | Three-lane build passed; one PP ribbon failure per Civil test lane; availability skips remain visible |
| PP ribbon | Existing uncommitted change in civil-ribbon-pp-gap | Keep protected; inclusion approved, placement/full acceptance unresolved |
| C2/UI | PRs #20/#22/#23 and preserved design drafts | Reuse bounded reviewed parts; no wholesale merge; no C2 start confirmation found |

## Completion hold-points, not fixes performed here

1. C1 upgrade writes object IDs and then project-record IDs; rollback restores only object IDs.
   LinkService can fall back to the retained project IDs. Review/guard Apply → Rollback → save/reopen
   and failure between the two writes before claiming fully reversible upgrade.
2. COPY currently duplicates IDs until a later upgrade repair; immediate new-identity behaviour is not complete.
3. SpineRecordStore exists but is not wired into commands. Decide cache/authority and prove round-trip
   before adoption; never create a second authority contrary to design rule 2.
4. CDRULES currently links by pit display names, not the spine relationship authority. Duplicate/renumbered
   marks need guarded evidence. Invalid stored drop falls back to 0; review fail-closed behaviour.
5. Multi-inlet/outlet pit-drop worst-case pairing remains an engineering decision; per-pipe overrides
   recorded in #25 are not proven implemented.
6. LandXML parser correctness remains open. D9 changes its role, not the need to reject wrong units,
   dummy pits and missing pipe ends if supplementary use is later approved.
7. net48 full runtime checks are not green merely because focused tests pass or unavailable tests skip.
8. DATA-01 remains blocked for broad client/corpus/AI work. D10 is bounded synthetic-fixture approval only.

Use existing chunk issues and consolidated Test Day checks; no new pile of individual AutoCAD tasks.

## Preservation and cleanup

[Original plan/design evidence](planning-evidence/2026-09-04/README.md) is retained. This isolated
docs branch does not check out corpus, runtime modules or release payloads. Claude's working
directories and branches are not edited. No history rewrite, branch deletion, chat deletion,
folder removal, build or deployment is part of this reconciliation.

The screenshot's 231 folders / 60.86 GB / 33 protected folders was measured on 3 September.
It is not current deletion evidence. See [working-copy preservation](WORKING_COPY_PRESERVATION_2026-09-04.md).
A new docs PR preserves these decisions on GitHub without claiming that pending runtime branches are merged.

## Verification / closeout

Documentation-only guards: changed-path allow-list, whitespace/diff checks, D1–D10 and D9 consistency,
source snapshot comparisons, unchanged source branches, GitHub issue/status readback.
No AutoCAD test is needed for this documentation change. Existing runtime acceptance remains with Claude.
