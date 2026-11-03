# EV-04 construction methods, stage B: footing systems (30 Oct 2026 onwards)

**Mapping:** confirmed by Tim, 30 Oct 2026 ("Mapping is right", decisions item 17). Pad footings stay Unknown (no CE layer named). Counts only; per-job detail local in `C:\ce_evidence_local\ev04_library\`.
**Read:** structural drawings of 1122 jobs scanned (984 with at least one structural drawing read). A system counts as used when its layer or block carries 10 or more objects (waffle pods 30 or more).

## 1. Footing system by job type (jobs where it is drawn as used)

1. **Alterations and additions (of 331):** Stiffened raft (internal beams) 257; Bored piers 68; Stumps 33; Screw piles 10; Strip footings 10; Waffle raft 2; none found 63
2. **Single dwelling new (of 229):** Stiffened raft (internal beams) 197; Bored piers 64; Screw piles 54; Waffle raft 37; Strip footings 12; Stumps 11; none found 24
3. **Townhouses / multi-unit / dual occ (of 215):** Stiffened raft (internal beams) 209; Waffle raft 95; Screw piles 90; Bored piers 60; Strip footings 15; Stumps 4; none found 2
4. **Basement (of 79):** Stiffened raft (internal beams) 45; Bored piers 29; Screw piles 6; Strip footings 5; Waffle raft 3; none found 24
5. **Civil stormwater drainage (of 15):** Stiffened raft (internal beams) 10; Bored piers 5; Screw piles 5; Waffle raft 3; Strip footings 2; none found 5
6. **Civil roads / subdivision / services (of 3):** none found 3
7. **Commercial / community (of 26):** Stiffened raft (internal beams) 7; Bored piers 3; Screw piles 1; none found 18
8. **Industrial / steel frame (of 16):** Bored piers 1; Strip footings 1; Stiffened raft (internal beams) 1; none found 14
9. **Small elements (of 21):** Stiffened raft (internal beams) 14; Screw piles 7; Bored piers 4; Waffle raft 2; none found 6
10. **Deck / small outbuilding (of 19):** Stiffened raft (internal beams) 16; Bored piers 3; Screw piles 3; Stumps 1; Waffle raft 1; none found 3
11. **Pool only (of 9):** Stiffened raft (internal beams) 4; Bored piers 3; Strip footings 1; Stumps 1; Waffle raft 1; none found 4
12. **Retaining wall only (of 6):** Stiffened raft (internal beams) 1; none found 5
13. **Other (of 5):** Stiffened raft (internal beams) 1; none found 4
14. **No readable text (type unknown) (of 10):** Stiffened raft (internal beams) 2; none found 8

**All 984 jobs:** Stiffened raft (internal beams) 764; Bored piers 240; Screw piles 176; Waffle raft 144; Stumps 50; Strip footings 46; none found 183
**Systems per job:** 0 systems on 183 jobs; 1 systems on 375 jobs; 2 systems on 257 jobs; 3 systems on 145 jobs; 4 systems on 24 jobs

## 2. What could not be read, and why

1. **Jobs with no structural drawing at the top of the job folder:** 126.
2. **Jobs where no structural drawing could be read:** 4 (drawings that would not open, or the reader timed out: 0 timeouts).
3. **Drawings that would not open, total:** 5. **Copy or read errors:** 4.
4. **"None found" is not "no footings":** pad footings, other layer names, or footings drawn in an xref.
5. **Not checked against a real drawing on screen.** Counts from the drawing scan only.

## 3. Doubts to keep in mind

1. **Waffle raft jobs probably also count as stiffened raft.** Waffle slabs have beams on the same "SLAB INTERNAL BEAM" layer, so most of the 144 waffle jobs will also sit in the 764. Read "stiffened raft" as "a raft slab with beams".
2. **Stiffened raft may be high on small jobs** (small elements 14 of 21, decks 16 of 19): standard beam details share that layer. Tim kept the cut-off at 10 (decisions item 17).
3. **Commercial and industrial jobs are mostly "none found"** (18 of 26, 14 of 16): those drawings use other layer names (pad footings, piles in xrefs). Not read, not guessed.
4. **The scan ran Fri 30 Oct to Wed 4 Nov 2026,** only in free AutoCAD windows with AutoCAD closed; 0 timeouts.
