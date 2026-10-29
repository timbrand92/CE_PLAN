# GB-01 Pipe and pit checks: APPROVED 29 Oct 2026 (Tim, item 26); not built, tested or installed

**Commands grouped:** CD (pipe layout), PIT, Edit Pipe, Civil Design, CDRULES. **Classification:** Modify (falls, cover, lid class) and Missing (minimum pit depth, pipes under garages).

## 1. Tim's words (item 24)
"1. as the guidebook says" / "2. as the guidebook says" / "3. use the table, with a council figure still winning" / "4. warn for every pipe, using its real size" / "5. B for shared residential driveways, C where larger vehicles drive over" / "6. plain connecting drains may pass under in 150 SN8; detention pipes may not". Item 17 (22 Oct): cover is measured to the outside top of the pipe, wall thickness from pipe data.

## 2. What the drafter sees, change by change
1. **Flattest fall, ordinary pipes. Modify.** Today a size ladder (1:100 to 150, 1:200 at 225, 1:250 at 300, 1:300 at 375, 1:200 at 450 to 750). Intended: **1 in 100 at every size.** A flatter pipe gets a yellow warning on the Edit Pipe strip and in CDRULES. Example: an 18 m run of 300 with 70 mm fall (1 in 257) newly warns.
2. **Flattest fall, detention pipes. Modify.** Today 1 in 200 from 225 up, every council. Intended: 1 in 200 from 225 up **only for Darebin, Banyule, Manningham, Maroondah** (Settings per council); other councils use the 1 in 100 rule. Example: a 450 detention pipe at 1 in 200 in Kingston newly warns (the real company drawings do this today).
3. **Cover by surface. Modify.** Today one office number (300) plus a council figure. Intended: the AS/NZS 3500.3 Table 6.2.5 on Settings (plastics: 100 single dwelling unpaved, 300 other buildings unpaved, 450 vehicles unpaved, 100 or 75 below concrete or brick pavement, 600 sealed road, 750 unsealed road or construction), surface taken from the pit's surface use or lid class, council figure still wins (Frankston 250). Cover to the outside top of the pipe.
4. **Minimum pit depth. Missing.** Intended: warn when a pit is shallower than cover plus the pipe's outside diameter minus its wall, for **every pipe**, from pipe data. The book's StormPro list (150 = 459 ... 900 = 1236 at 300 cover) is the proof table, not the source. Example: a 450 pipe into a 700-deep pit warns (needs 781 at 300 cover).
5. **Lid class chart. Modify.** Intended: Settings chart A to E by use; shared residential driveway = B; where larger vehicles drive over = C. Today driveway = C.
6. **Pipes under garages. Missing.** Intended: a detention pipe under a dwelling or garage warns; a plain connecting drain under a garage is fine if 150 UPVC SN8, otherwise warns.
7. **Pit size by depth. Keep.** Same values (350 to 450 deep, 450 to 600, 600 to 900, 600 x 900 to 1200, 900 x 900 over); only change is they move onto Settings.

## 3. Where each value comes from
Settings (office), council profile (wins where stated), pipe data (outside diameter, wall), the drawing (pit depth, surface). Unknown surface or pipe size: say "Unknown, cover not checked", never assume.

## 4. Cancel, Escape, Undo, save
Checks only warn; they change no drawing. Cancel and Escape change nothing. Settings edits are saved with the Settings file.

## 5. Test (Tim does not test; Codex in AutoCAD plus numbers)
Guards: each rule against the examples above. AutoCAD look: Edit Pipe strip and CDRULES list show the new warnings on a copy; a pipe at exactly the limit passes.

## 6. Slices
1. Falls (items 1 and 2). 2. Cover table (3). 3. Minimum pit depth (4). 4. Lid class and garages (5 and 6). 5. Pit size table to Settings (7).

## 7. Open points for Tim
1. Manningham: the book says 1 in 200, the council's 2021 checklist says 1 in 180. Read as 1 in 200 for now.
2. 450 and larger gravity pipes now warn flatter than 1 in 100 (the book gives no ladder); confirm that is wanted.
3. Do charged and pumped pipes count as "gravity pipes"? Recommend not.
4. Retires the old R-03 ladder and the every-council R-32 rule once approved.

## 8. Tim's answers to the open points (29 Oct 2026, item 26 of the decisions file)
1. Manningham: 1 in 200 ("do as you recommend").
2. 450 and larger gravity pipes: "bigger pipes get their own figure". The book gives none, so this is its own Settings row, **left Unknown until a figure is named**; blank means "no minimum fall set for this size", no warning. Open: who names the figure.
3. Charged and pumped pipes are not held to the grade rule ("yes").
4. The old size ladder (R-03) and the every-council detention rule (R-32) are retired when slice 1 is built ("yes").
