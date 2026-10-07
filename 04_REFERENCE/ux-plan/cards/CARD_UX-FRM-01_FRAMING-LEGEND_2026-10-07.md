# CARD UX-FRM-01: framing plan legend built from what is drawn (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** Roof and upper floors. Class: **Missing** (the footing legend [CSFOOTINGLEGEND] already works this way; the framing plans have none).
Tim's words: UX-FRM-01 "Yes, build it automatically" (member types, stud walls, posts, symbols, office wording, built and updated from what is drawn). Evidence: "DENOTES ..." lines on the framing plans of 6 of 6 studied jobs.

1. **Before:** you type the framing legend by hand on every plan: "DENOTES LOADBEARING WALL UNDER", "DENOTES DOUBLE STUD", "DENOTES TYPE A BRACING". Add a post later and the legend can be out of date.
2. **After:** you run one command and pick a spot. CE reads the plan, lists only the symbols that are on it, and draws the legend in the office wording. Run it again after changes and it updates the same legend in place.
3. **Command and prompts (proposed name CSFRAMINGLEGEND):** "Pick legend corner (bottom-left):" first time only. Then a preview of the lines to add, change or drop, "Accept? [Yes/No] <Yes>".
4. **A symbol on the plan with no legend line:** CE adds the line. A legend line for a symbol no longer on the plan: CE offers to drop it and asks first. CE never changes wording you edited by hand; it says "legend line left as edited".
5. **Cancel and Undo:** Esc or No changes nothing. One accepted run is one U.
6. **Native protection:** the legend is drawn on its own layer; if locked, CE reports and stops. Never unlocked, no Xref or REFEDIT work.
7. **Settings values:** the office wording for each symbol (seeded from the studied jobs), legend layer, text height from the plan scale, which symbols are included (stud walls, posts, bracing types, set-downs, outline of floor over).
8. **Tested without AutoCAD:** which symbols are on a plan gives which lines, the update keeps hand-edited wording, a moved legend is found again by its title.
9. **Only Codex in AutoCAD can see:** the legend sits clear of the plan on a layout and in model space, a second run updates in place, one U.
10. **Questions for Tim (typed):**
    1. **Same box style as the footing legend?** Rec: yes, so the office sees one look. Job example: swatch on the left, "DENOTES ..." on the right, like the slab legend.
    2. **Does the legend repeat on every framing sheet, or once per job?** Rec: once per framing sheet, each showing only its own symbols. Job example: the roof sheet shows trusses and bracing, the first floor shows stud walls and posts.
    3. **Where does the bracing line come from?** Rec: from the bracing symbols on the plan (Type A strap, Type B ply). Job example: a plan with only Type B ply walls shows only the Type B line.
