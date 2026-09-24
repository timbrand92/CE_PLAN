# StrucPlus inventory against V3 Structural — 24 Sep 2026

**Why:** Tim, 24 Sep about 11:15 (verbatim): *"IS THERE ANYT OTHER USEFUL STUFF IN STRUC PLUS FO OUR V3 PLAN?"*

**How:** a read-only helper (Sonnet) read Tim's StrucPlus copy in OneDrive IT Admin (`StructPlus\CE_StrucPlus\`:
`menu\CE_StrucPlus.mnu`, `lisp\`, `data\`, `config\`) and compared it with the shipping Structural line
(`claude/struc-d1-prep`: `command-registry.json`, 307 commands incl. 29 "Legacy" ports) and the Structural plan
(`STRUCTURAL_BUILD_AREAS.md`: Sections & Details is ST-08, queued, not built). Nothing was copied from IT Admin.
**This is the helper's reading; the release chat spot-checked two points only** (see "Checked" below).

**Already decided, left out:** Pen & Linetypes (being built, `STRUCTURAL_LINE_STYLES_CARD_DRAFT_2026-09-24.md`);
Change Colour and Change Linetype toolbars (Tim: no).

**Already covered by V3** (helper): the section-detail commands (SBEAM, RCBEAM, RCRECTCOL, RCCIRCCOL, BSSLAB, STLCONN,
PORTAL, TRUSS, PURLINS, ANGLES, BOLTS, BRACE, BASEDET, GUSSETS, RIDGE, KNEE).

## Missing from V3, ranked by likely daily drafting value

1. **Reinforcement accessory marks:** hook, cog, crank, lap splice, step and U-bar marks on bar lines. `lisp/Reoacces.lsp`
   (`reohook`, `reocog`, `reocrank`, `reolap`, `reostep`, `reoubar`). V3 has plain rebar lines, circles and ligatures only.
2. **Weld symbols:** general weld symbol, CFW and FSBW weld lines, site weld, all-round, special. `lisp/Weld.lsp`.
   No V3 equivalent.
3. **Slab-on-ground detail library:** six slab-edge profiles, four internal rib profiles, slab step, slab-to-wall step,
   sump pit, sawcut, dowel and keyed joints, scaled to the drawing. `lisp/Slog.lsp`, `Slogwall.lsp`, `Slogsump.lsp`.
4. **Retaining wall sections:** twelve standard sections (RC simple and cantilever, masonry cantilever, counterfort,
   segmental block). `lisp/Retwall1.lsp` to `Retwal10.lsp`.
5. **Stairs:** stair plan and section, typical and double flights, supports, key diagram. `lisp/Stair*.lsp`.
6. **Steel connection variants:** ten beam-beam and beam-column connections, seven portal knee joints, base plates,
   ridges, web side plate and flexible end plate cleats. `lisp/Stlconn1-3.lsp`, `Wsplate.lsp`, `Feplate.lsp`,
   `Kneedet.lsp`. V3 has one generic command for each family, not the variants.
7. **Bolt tags and material lists:** field bolt, DynaBolt, TruBolt, Chemset and generic tags; bolt summary; material
   leader, list and extract. `lisp/MATLIST.lsp`.
8. **Drafting extras:** mend lines, add length, arrow, underline, arc running dimension, arc length, array, match line,
   scale bar, grid bubble, revision triangle, logo, soil and rubble symbols.

## Data worth reusing

1. **Steel section tables** (`data/aus_steel_sections.txt`, `Unisects`, `Pfcsects`, `Angsects`, `Sqtubes`, `Purlsect`,
   `Teesects`): UB, UC, PFC, angles, RHS, SHS, CHS, purlins, with mass and section properties. **Checked:** V3 already
   has `Modules/Structural/Assets/Config/section-catalogue.json` with AS/NZS names, so this is a **compare and fill
   gaps** job, not a port.
2. Rebar table (`data/aus_rebar.txt`), text-height table (`Sptextht.ini`), RC beam and slab mass tables
   (`Beamprop.txt`, `Rcslabvol.txt`, `Mass.dat`), and the `blocks/*.dwg` library (title blocks, north point, arrows).

## Obsolete, skip

The dimension toolbar (plain AutoCAD commands), the R12/R13 leader toggle, the "Edit LISP / Edit INI" buttons, the
licensing file, and the slide-picker dialogs themselves (V3 uses its own windows).

## Checked by the release chat

1. No weld command or weld symbol exists on `claude/struc-d1-prep` (only the word in the section catalogue and a
   checklist template).
2. The section catalogue exists (above), which corrects the helper's "port the tables" to "compare".

## Tim's answer, 24 Sep about 11:50

Weld symbols (item 2) only; the rest "WE DONT REALLY USE IF YOU LOOK AT EVIDENCE / DATA MODEL". Steel connections to be updated to what CE uses (evidence study). See the decision file entry of that time.

## Next step (superseded 24 Sep 11:50 by the answer above)

Tim picks which of 1 to 8 go into the Structural plan (ST-08 Sections & Details) and in what order. Each then needs a
command card before any code (AGENTS.md review gate). **None is a Tuesday item.**
