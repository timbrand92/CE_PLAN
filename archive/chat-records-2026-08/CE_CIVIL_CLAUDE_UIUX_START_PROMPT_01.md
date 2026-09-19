# Copy/paste prompt — Claude Civil UI/UX design start

Use this prompt after the 08:30 Civil behaviour handoff. This first Claude task is **design and planning only**. It must not build or edit plugin source until Tim approves the visible design and an exact clean source checkpoint is supplied.

---

You are the UI/UX design owner for the CE ACAD Civil plugin. Design an Autodesk-quality Civil experience that feels like a native extension of AutoCAD and forms one cohesive CE package.

## First task boundary

Perform a read-only UI/UX design and implementation-planning pass only.

- Do not edit production code, XAML, ribbon files, icons, plugin assets or project drawings.
- Do not build, package, deploy or control AutoCAD/ApplicationPlugins.
- Do not change Civil engineering behaviour or invent Civil design rules.
- Do not edit Structural, Manager or shared CE UI source.
- You may identify later Civil UI file ownership, but wait for Tim's visual approval and an exact clean branch/head before implementation.

Repository for read-only inspection:

`C:\Lisp Files\CE_ACAD_PLUGIN`

Authoritative behaviour handoff:

`C:\CE_DrawingIntelligence\05_Deliverables\CE_CIVIL_BEHAVIOUR_HANDOFF_FOR_CLAUDE_UIUX_01.md`

Also read:

- `C:\CE_DrawingIntelligence\03_Review_Cards\CIVIL_END_GOAL_REQUIREMENTS_AND_BUILD_ROADMAP_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_CONNECTED_ELEMENT_AUTOCAD_INTERACTION_MODEL_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CE_CIVIL_UNIVERSAL_CDEDIT_AND_LINKED_FIELD_CONTRACT_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CIVIL_PROJECT_ENTRY_AND_DAILY_WORKFLOW_UI_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CIVIL_PROJECT_LIFECYCLE_AND_USER_WORKFLOW_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\CIVIL_PROJECT_MANAGER_AND_DELIVERY_OUTCOME_MAP_01.md`
- `C:\CE_DrawingIntelligence\03_Review_Cards\STRUCTURAL_END_GOAL_REQUIREMENTS_REGISTER_01.md` for shared CE interaction language only; do not investigate or redesign Structural engineering.

## Product result

The user should work as they already work in AutoCAD:

- click the exact line, block, text or arrow;
- retain normal AutoCAD selection, grips, Move, Stretch, Copy, Mirror, Undo and Escape;
- see the owning Civil item and connected consequences without forced grouping;
- use one docked Civil Properties/Inspector and universal `CDEDIT` doorway;
- keep reasonable geometry when Civil meaning is uncertain;
- see evidence, inference, proposal and approved decision as visibly different;
- preview coordinated changes and apply an approved change as one AutoCAD Undo; and
- never have AI approve engineering.

The UI must use plain AutoCAD, drafting and engineering language. Do not expose terms such as handles, schemas, dictionaries, reactors, caches, object IDs or serialisation.

## Design these connected experiences

1. Civil ribbon hierarchy and a cohesive Autodesk-quality icon family.
2. Always-open docked Civil Properties/Inspector.
3. Universal `CDEDIT` for pipes, pits, tanks, pumps, wet wells, downpipes, IO/GIO, overflows, spoon drains, swales, AGI, trench/strip drains, raingardens, slabs, roofs, carparks, driveways, gardens and other approved Civil items.
4. Exact-child selection: normal grips plus clear Slide Along, Offset Across and Flip Side meanings.
5. Connection questions: Connected, Proposed connection, Several possible connections and End unresolved.
6. Non-printing surface/catchment overlay with shaded source areas and measured m².
7. Linked-value impact preview for plan, schedule, long section, calculation, detail and issue QA.
8. Fresh project, half-completed project, completed project and revised-project workflows.
9. Project Manager/Work Tracker context without duplicate entry or competing Civil time controls.
10. Consistent messages, warnings, empty states, locked/Xref/REFEDIT states and `Not linked` explanations.

## Current source truth the design must show honestly

- The present endpoint review uses a **2 mm 2D plan-contact tolerance**. That is visual plan evidence only; never call it an exact, physical or hydraulic connection.
- A candidate's identity and its availability when reviewed are separate. Show `Editable`, `Locked layer`, `Read-only reference` or `Availability unknown`, and require the core to recheck current protection before any later action.
- Exact Xref endpoint identity is not implemented yet. Keep it unresolved. Future overlapping Xrefs must be listed as separate named candidates and CE must not preselect one.
- Current mechanical evidence is **19/19 endpoint checks** and **113/113 expanded bounded checks** on both net10 and net48. These are source checks, not live AutoCAD acceptance.
- The current candidate is undeployed. Do not present any of these behaviours as released or field-proven.

## Fixed behaviour you must not redesign

- Visible pipe names remain exactly: Stormwater Pipe, Charged Pipe, Suspended Pipe, Rising Main, Detention Pipe and Existing Pipe.
- Selecting a child selects that child; the owner is identified but not forced into the selection set.
- `Select Whole Item` is deliberate.
- Flip Side changes drafting placement, never hydraulic direction.
- Unknown remains Unknown; identity outranks proximity.
- Ordinary/manual objects stay normal AutoCAD objects until explicitly linked.
- Xrefs are read-only.
- No compulsory wizard before drawing and no modal form after an ordinary drafting move.
- User rearrangement persists.
- No silent repair, design change, billing change or engineering approval.

## Return to Tim

Keep the presentation visual and concise. Provide:

1. a simple overall UI map;
2. current-versus-proposed ribbon comparison;
3. docked Inspector and universal CDEDIT screen concepts;
4. grip/tooltip and connection-question examples on plan;
5. fresh/half-complete/completed/revision user flows;
6. one consistent visual/message system for Civil and later shared CE use;
7. the exact Civil UI files you would later own;
8. implementation stages, dependencies and AutoCAD acceptance checks; and
9. one grouped list of genuine questions requiring Tim's visual or workflow decision.

Do not begin implementation until Tim approves the visible design and the Civil Control Room supplies the exact clean source checkpoint and permitted UI file list.

---
