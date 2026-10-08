# W40 / BUG-447: why the X-Civil import pulls BOTH ends of one short pipe onto one spot

Written by build/03 run 63, Fri 9 Oct 2026, from reading the code on claude/rel-20261008g (3e59c62a). Read-only; nothing was run in AutoCAD.

## In plain English
1. **What happens.** A short consultant pipe (the 1.68 m, 100 mm pipe B365D beside P8) has BOTH its ends within a pit's "snap distance" of P8. The import snaps each end separately onto P8's wall. The first end is pushed along the pipe's own line onto the wall. The second end is then pushed along the line from that already-snapped point, which is ON the wall, so it lands on the same point. The pipe collapses to a dot.
2. **Why the earlier guard did not stop it.** The existing "no self-pipe" guard (SelfPipeGuard) only stops both ends being given the same pit NAME. It does not stop both ends being moved to the same SPOT. #814 now skips the dot and says so, but the real pipe is still lost.

## Where (file:line, branch claude/rel-20261008g)
1. **Entry:** `Modules/Drainage/Services/XcivilPipeInsertionService.cs:653` `SnapImportedPipeEndpointsToOwners` snaps start then end of every pipe (called from `XcivilImportService.cs:641` and `:1822`).
2. **The snap:** `XcivilPipeInsertionService.cs:668-710` `SnapImportedPipeEndpointToOwner`, Phase A. Two routes can move an end onto a pit wall: `TryProjectImportedEndpointToPitBoundary` (`:813-849`) and the wider `TryFallbackSnapToPit` (`:943-989`). Both end in `TryIntersectImportedPitBoundary` (`:913-935`), which aims from the OTHER end's current position through this end. The end is read after the first end moved (`:679-680`), so for the second end the "other end" is already on the wall.
3. **Ownership (names only):** `ResolveImportedPipeEndpointOwnership` (`:717-786`) uses `SelfPipeGuard.SelectNearestDistinctPitId`: second end takes the next different pit or stays blank. This part already works.
4. **Late safety net:** `XcivilImportService.Insertion.cs:353` `SelfPipeRepairService.RepairSelfPipes` clears a To pit when From == To. It cannot restore a moved point.

## Which tolerance decides it, and is it a Setting?
1. **Tight snap:** `GetImportedPitEndpointSnapTolerance` (`XcivilPipeInsertionService.cs:851-861`): 0.8 times the pit footprint, kept between 500 mm and 1600 mm. **Not a Settings value** (hard-coded).
2. **Wide snap and ownership:** `XcivilLayerRecognition.PipeEndpointPitTolerance = 3200 mm` (`XcivilLayerRecognition.cs:22`). **Not a Settings value.** For a pit this size, an end up to 3.2 m from P8 is still pulled onto it by the fallback, so a 1.68 m pipe beside P8 has both ends inside it.
3. **R-00:** both are existing hard-coded numbers (R-00 breach, older than this change). The smallest safe change below adds NO new number: it reuses the existing tight snap distance. Moving the three numbers onto the Settings window is a separate item for Tim to approve.

## Smallest safe change
1. In `SnapImportedPipeEndpointsToOwners`, per pipe, find the nearest pit of each end (same distance rule as today, within the existing wide tolerance).
2. **If both ends belong to the SAME pit and the pipe's true length is longer than that pit's tight snap distance:** snap only the end nearer the pit (it goes first, so it owns the pit name). The far end keeps its true position, is NOT pulled onto the wall, and its pit name is resolved by the existing guard (another pit if there is one, otherwise blank = open end "Unknown"). The pipe keeps about its true length.
3. **If the pipe is genuinely no longer than the snap distance** (it really sits inside one pit): behave exactly as today (#814 / the self-pipe repair then handle it).
4. **Pipes between two DIFFERENT pits, or with one end near a pit, or no pit: unchanged.**
5. **Report line:** one plain line per such pipe: "Pipe (source object B365D on layer ...) ends at P8 but its other end is also near P8: CE kept that end where the consultant drew it, as an open end, instead of pulling both ends onto P8. Check it."
6. **Risk:** a pipe whose far end is really meant to be at the pit (a stub into a pit's far wall) now keeps an open far end instead of a dot: a drafter closes it with CD; before, it was a dot anyway.
