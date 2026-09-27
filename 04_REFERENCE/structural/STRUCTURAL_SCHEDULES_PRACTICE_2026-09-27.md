# Structural schedules — CE practice (DRAFT, 27 Sep 2026)

Read-only look at recent structural issue PDFs (Tim chose this study, 27 Sep). Evidence so far is ONE job's footing
and slab sheets (S02/S03, construction issue); no beam schedule found yet in the sample. Anonymised (DATA-01). Items 1-6 CONFIRMED by Tim 27 Sep
(UX-SSCHED-01..03). Beam schedule table: exists (UX-SSCHED-04), layout still to read.

1. **Footing schedule is sideways:** each footing mark is a COLUMN (PF1, PF2 ... SF1 ... GEB1), with its type written
   small under the mark (PAD FOOTING, STRIP FOOTING, PILE CAP, EDGE BEAM, INTERNAL BEAM). Rows: FOOTING TYPE, WIDTH
   MINIMUM, DEPTH MINIMUM, REINFORCEMENT, COMMENTS. A band above groups columns by concrete strength
   ("40 MPa CONCRETE"); the title carries the default strength ("FOOTING SCHEDULE (F'c = 25MPa) U.N.O.").
2. **Bored pier schedule:** same sideways layout, own title ("BORED SCHEDULE (F'c = 40MPa)"), capping beam included.
3. **Slab-plan footing schedule:** a second, small sideways schedule for slab beams (EB1 edge beam, IB1 internal beam).
4. **Wall schedule is the normal way round:** one ROW per wall mark; columns WALL TYPE | WALL TYPE (THICKNESS) | WALL
   REINFORCEMENT (VERTICAL, HORIZONTAL) | STARTER BARS | FIRE RATING; notes box under it.
5. **Masonry lintel schedule:** rows by SPAN range (<1200, 1200-1500 ...) with LINTEL SPECIFICATION; a standard table.
6. **Marks carry a type prefix:** PF pad footing, SF strip, CF continuous, PC pile cap, BP bored pier, CB capping beam,
   EB/IB/GEB/GIB edge and internal beams, GPF, W/BW walls, RC column; "(O)" on existing items (e.g. RC1(O)).
7. **Slab legend boxes** beside the schedule: slab type swatch, thickness, mesh, cover, f'c, membrane and sand notes.

## Framing member schedule (second job, framing details sheet, read 27 Sep)

8. **Title per floor:** "FIRST FLOOR MEMBER SCHEDULE" (one per level). Two columns only, **MARK | SIZE**, repeated in
   three side-by-side blocks on the sheet, with group subheadings inside (Floor Beams, Lintels, Lower Roof Beams).
9. **SIZE cell = size + description:** e.g. "140 x 45 MGP10 TRIMMER BEAM", "2 No 90 x 45 F17 KDHW DOUBLE STUDS",
   "250 UC 90 2500mm MAX. CANTILEVER", "250 x 90 PFC OUTRIGGER FULLY WELDED TO FB1".
10. **Prefixes:** DS double studs, TS triple studs, C steel column, PC portal column, FJ floor joist, RT roof trusses,
    R rafters, TR trimmer, WB wind beam, WP wind post, BL block lintel, GL garage lintel, L lintel, FB floor beam,
    B beam, OR outrigger, LRB lower roof beam, NP nailing plate.
11. **Same size, different marks:** many floor beams share one section (e.g. several FB = 250 x 90 PFC) yet each has its
    own mark, because span/cantilever/connection notes differ. Tim 27 Sep: own mark per beam (UX-MARK-07). Items 8-13 CONFIRMED (UX-SSCHED-05).
12. **Revision clouds** (red dashed) around changed rows; masonry lintel schedule and timber/steel notes beside it.
13. **RC beam schedule** on the footing sheet: sideways like footings (BB1, BB2 band beams; width, depth,
    reinforcement), titled "R.C BEAM SCHEDULE (F'c = 32MPa)".

## What the current code already does (read-only review, 27 Sep, after Tim: "my framing member schedule block has version with multiple columns review currnet code")

Plugin master, Modules/Structural/Services/ExcelMTextService.cs (XCLMTXT path) and MemberScheduleService.cs:
14. The office **MEMBER SCHEDULE.dwg** dynamic block is inserted per floor section, with a visibility state
    **"1 COLUMN" / "2 COLUMNS" / "3 COLUMNS"** picked from the row count, and a stretch distance (Distance2/3/4) set
    to the column depth. Row spacing 750, column depth capped at 23,250 (about 31 rows per column).
15. **Maximum is 3 columns.** A floor needing more is refused before insert ("Max supported is 3. Increase
    Rows/Column or split the schedule before inserting"); nothing continues to another block or sheet.
16. Title attributes MEMBER_SCHEDULE1..3: with one column the title reads plain "MEMBER SCHEDULE"; with 2-3 columns
    each block title carries the floor title (e.g. "FIRST FLOOR MEMBER SCHEDULE").
17. If the block file cannot be loaded, XCLMTXT falls back to text-only placement.
18. MemberScheduleService only stores the rows (mark, size, type, note) in the drawing so other commands can look a
    size up by mark; it does not draw anything.
