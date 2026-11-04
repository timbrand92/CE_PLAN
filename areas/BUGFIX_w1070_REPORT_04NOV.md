# BUGFIX w1070 REPORT — Frankston driveway cover (decision 196, item 99), 4 Nov 2026

**Result: NO PR OPENED. It needs Tim's engineering call first (two questions below).** Built nothing, ran no tests, started no AutoCAD. Base checked: origin/claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88).

---

## FOR TIM

1. **What I found:** CE already has a Surface list on the Pit window (Garden, Footpath, Driveway, Driveway (larger vehicles), Road) and a cover table behind it. Driveway is 100 mm plus the slab (100 mm), so 200 mm. There is no Frankston-specific reinforced-concrete or brick row.
2. **Why I stopped:** the Frankston figures do not agree with each other, and the answer changes what a Frankston job is told.
3. **What would go wrong on a job:** on a Frankston job CE today uses the council figure 250 mm as a floor, so a pipe under a driveway is judged against 250 mm. If I add "reinforced concrete 100 mm" and "brick 75 mm" rows, the 250 floor still wins and the new rows would never show. If I let the new rows win, CE would pass a pipe at 100 mm cover that the OSD note says needs 250 mm.
4. **Mistakes of my own:** none that cost anything. I did not build, so nothing is unproven by a test; it is simply not built.
5. **NOT proven:** nothing about this was opened in AutoCAD. The carpark note from 31 Oct says the slab-thickness rule (decision 154) is built but still not seen in AutoCAD.

**Question 1 (needs your word). Which Frankston cover figure governs?** The Frankston Development Guidelines (lines 75 to 83) say: 500 mm with no pavement; 100 mm below the underside of a reinforced concrete pavement (heavy vehicles); 75 mm below brick or unreinforced concrete (light vehicles); roads 600 mm. The Frankston OSD note (2021) says storage pipes need 250 mm. The Frankston profile in CE holds 250.
- **Recommendation:** use the Development Guidelines rows for the Surface choice on Frankston jobs, and keep 250 as the plain figure for a pit with no surface picked. Reason: they are the more specific rule, and they are the figures you named in decision 196.
- **Example:** Frankston, Driveway (reinforced concrete) with a 200 mm slab. Today CE asks for 250 mm. With my recommendation CE asks for 100 + 200 = 300 mm to the top of the pavement.

**Question 2 (needs your word). Which one gets 75 mm?** Decision 154 says "100 mm (75 mm for reinforced concrete)". Decision 196 and the council file say reinforced concrete = 100 mm and brick or unreinforced = 75 mm. They are opposite.
- **Recommendation:** follow decision 196 and the council file (reinforced 100, brick or unreinforced 75). Reason: it matches the source document word for word.
- **Example:** a brick-paved driveway on a Frankston job would be judged at 75 mm below the pavement underside, not 100.

**When you answer:** I build it as one draft: two new Surface choices ("Driveway (reinforced concrete)" and "Driveway (brick or unreinforced)"), two Settings rows, one Settings switch ON by default, a unit test, a REGRESSION_LOG entry. Switch OFF brings back today's behaviour exactly.

---

## Technical detail

1. **Existing code (BASE):** `Modules/Drainage/Rules/RulebookValues.cs:111-137` `MinCoverFor`: a council figure with `CouncilFigureIsFloor` (default on, `UserSettings.cs:2697`) returns the council 250 unless the table row plus slab is bigger. `UserSettings.cs:2665-2673` ships the table (Garden 300, Footpath 100, Driveway 100, Driveway (larger vehicles) 450, Road 600). `UserSettings.cs:2695-2696` slab default 100 and paved list Footpath, Driveway. The Surface list is `ViewModels/PitViewModel.cs:594`. The lid class map is `UserSettings.cs:2268-2273` and `Services/LidClassChart.cs:70`.
2. **Frankston profile:** `Assets/Config/council-profiles.json` id frankston, `minCoverMm` 250 (line about 362).
3. **Source:** `docs/workflows/COUNCIL_FRANKSTON_DEV_GUIDELINES.md` lines 75 to 83 (the 83 and 82 rows are the pavement rows; line numbers in the decision are approximate by a few lines). `COUNCIL_FRANKSTON_OSD_2021.md:60` gives 250 for storage pipes.
4. **Size:** a new Surface name touches the PitViewModel list (not a window layout), the lid class map, the shipped cover table, the paved list, the stored-settings upgrade at `SettingsService.cs:298`, plus council-aware override of the 250 floor. That is more than one small change, and the floor interaction is the engineering call above. A Pit window layout change was not needed on my reading, so no Codex brief was written.
5. **Robot case (to write after the answer):** name `N_frankston_driveway_cover`. It types CDRULEBOOK, Council, frankston, then sets a pit Surface to "Driveway (brick or unreinforced)" with a 100 mm slab and runs CDRULES. It checks that the cover line asks for 75 + 100 = 175 mm. Switch-off control: same steps with the switch OFF must show the old 250 mm line.
6. **Isolation and disk:** no dotnet build or test was run, so the before and after AppData listings were not taken (nothing could have written them). The worktree C:\CE_WORK\build\w1070 was created on branch claude/w1070-frankston-driveway-cover (no commits) and then removed; the empty branch is left in place (no deletions).
7. **Carpark:** not edited (the desk owns it). Suggested wording for BUG-903's Frankston note: "w1070: stopped, needs Tim's word on 250 vs Development Guidelines figures and the 75/100 swap between decisions 154 and 196."
