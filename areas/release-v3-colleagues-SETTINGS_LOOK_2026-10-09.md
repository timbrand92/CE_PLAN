# Settings look: Tim's stored values for the keys the next trains read

**Made:** 9 Oct 2026, Melbourne. Controller 06 job. Read only: nothing was edited, copied, moved or rewritten, no build, no AutoCAD.

## Answer first

1. **0 keys are DIFFERENT FROM STOCK.** Every key the eleven pull requests read is either stored at the stock number or not stored at all (so the stock number applies). Nothing a drafter gets at an Enter or a number changes on install because of Tim's own settings.
2. **Stored and the same as stock (12 keys):** step irons 900, soft ground C 0.30, detention run 40 m, smallest 225, largest 600, both freeboards 150, Calculated decimals 2, label plot height 2.5, pier diameter 450, Rebar bar size N12, Rebar spacing 200 (all as stored today).
3. **Not stored, so the stock number applies (9 keys, all brand new):** the two pit cover text gaps (200 and 250), the new REBAR bar count (3), stirrup cover (30), stirrup warn-below (10), the two reo spacing limits (50 and 1000), and the two OFF switches.
4. **One thing to know, not a difference:** Tim's stored "Rebar number of bars" is 8, but the REBAR / RB tool will read a NEW key (default 3), not that one. So REBAR still starts at 3 bars as it does today. CSREOBAR keeps reading the 8.
5. **One trap to know about:** the old Structural file in the TIM_CE_CADTOOLS folder (dated 31 Mar) stores bar size N24, not N12. It is not the live file today (the live one is in the CE_STRUC_SUITE folder and says N12), so it changes nothing. It would only matter if the live file were ever lost and the old one were read in its place.
6. **#915 reads no Settings key at all** (it adds a warning sentence only).

## Files read (read only)

1. **CD_Settings.json** (Civil, `<profile>\AppData\Roaming\TIM_CE_CADTOOLS`): 15,270 bytes, SHA-256 starts ACD64E79. Last written 4 Oct.
2. **CS_Settings.json, live Structural** (`<profile>\AppData\Roaming\CE_STRUC_SUITE`): 28,872 bytes, SHA-256 starts D3890D56. Last written 9 Oct 06:00. AutoCAD rewrites it often, so this prefix will change.
3. **CS_Settings.json, old Structural** (`<profile>\AppData\Roaming\TIM_CE_CADTOOLS`): 351,713 bytes, SHA-256 starts 622A246F. Dated 31 Mar. Read only to compare the Rebar group.
4. **settings.json, old Civil** (`<profile>\AppData\Roaming\CE_CVL_SUITE`): 672 bytes, SHA-256 starts EFE307C4. It holds old CDD_ and PIT_ keys only. None of the keys below are in it.

Stock defaults came from the pull request diffs and from `origin/claude/rel-20261009g` (Civil) and `origin/claude/rel-20261009f` (Structural) `UserSettings.cs`. The keys are named group.property as in the file.

## Civil and Manager

### #914 Pit Schedule step-iron depth

1. **designStandards.stepIronMinDepthMm.** Stock 900. **What it changes:** the Pit Schedule's "With Step Irons" tick and the deep-pit warning now follow the same depth CDRULES uses, instead of a private 0.90 m. Tim stored: **900**. **SAME AS STOCK.**

### #918 Pump sizing and calc tabs, soft-ground runoff

1. **designStandards.postDevSoftGroundC.** Stock 0.30. **What it changes:** pump sizing, the Boyd's tab and the pump tab start with this runoff figure for grass and garden instead of their own 0.3. Tim stored: **0.3**. **SAME AS STOCK.**

### #920 CDDESIGN detention pipe limits (the three CDRULES keys)

1. **designStandards.detentionMaxRunM.** Stock 40 m. **What it changes:** CDDESIGN picks the smallest pipe whose run is no longer than this. Tim stored: **40**. **SAME AS STOCK.**
2. **designStandards.detentionMinDiameterMm.** Stock 225. **What it changes:** the smallest detention pipe CDDESIGN may pick. Tim stored: **225**. **SAME AS STOCK.**
3. **designStandards.detentionMaxDiameterMm.** Stock 600. **What it changes:** the largest detention pipe CDDESIGN may pick. Tim stored: **600**. **SAME AS STOCK.**

### #922 Suggested levels use Calculated decimals

1. **inverts.calculatedDecimals.** Stock 2 (kept between 0 and 4). **What it changes:** suggested levels (pit drop and upstream/downstream) round to this many decimals instead of a fixed 2. Tim stored: **2**. **SAME AS STOCK.**

### #925 CDTWL and CDRULES read one freeboard (the two FREEBOARD settings)

1. **designStandards.detentionFreeboardMm.** Stock 150. **What it changes:** CDTWL now checks this one, the same one CDRULES prints. Tim stored: **150**. **SAME AS STOCK.**
2. **pipe.detentionFreeboardMm.** Stock 150. **What it changes:** the older Pipe-group figure, kept only while the other is the factory 150 (so an old job keeps its number). Tim stored: **150**. **SAME AS STOCK.** Both at 150, so CDTWL gives 150 either way.

### #917 Pit cover text gap

1. **pit.coverTextGapMm.** Stock 200 mm (new key). **What it changes:** how far the cover level text sits off a pit. Tim stored: not stored, so the stock default applies. **NOT STORED.**
2. **pit.detentionCoverTextGapMm.** Stock 250 mm (new key). **What it changes:** the same gap beside a detention pit. Tim stored: not stored, so the stock default applies. **NOT STORED.**

### #915 Boyd's storage says when it is still rising

1. **No Settings key read.** Adds one warning sentence in the CDCALC Boyd's line and the CDDESIGN notes. Nothing to compare.

## Structural

### #921 One reader for the label text height

1. **Layouts.LabelPlotHeightMm** (Settings: Layouts, Label plot height). Stock 2.5 mm on paper. **What it changes:** eleven label places that had a bare 2.5 now follow this number times the drawing scale. Tim stored: **2.5**. **SAME AS STOCK.**

### #923 REBAR / RB start values come from Settings

1. **Rebar.DefaultSize.** Stock N12. **What it changes:** the bar size REBAR offers on its first use in a session. Tim stored: **N12** (live file). **SAME AS STOCK.** The old Structural file says N24 but is not live.
2. **Rebar.DefaultSpacing.** Stock 200 mm. **What it changes:** the spacing REBAR offers on first use. Tim stored: **200**. **SAME AS STOCK.**
3. **Rebar.DefaultBarCount** (new key). Stock 3. **What it changes:** the "Number of bars" answer REBAR offers on first use. Tim stored: not stored, so the stock default applies (3, the same as the tool always started with). **NOT STORED.** His stored Rebar.DefaultCount of 8 is a different key and this PR does not read it.

### #924 BP offers the Settings pier diameter on Enter

1. **BoredPierPlan.DefaultDiameterMm.** Stock 450 (only 300, 450 or 600 are accepted; anything else gives 450). **What it changes:** the number in the brackets and the answer when Tim presses Enter at "Select pier diameter". Tim stored: **450**. **SAME AS STOCK.**

### #919 Stirrup cover and reo spacing warn instead of change or refuse

All six keys are new and none are stored, so the stock numbers and the OFF switches apply (the PR says nothing a drafter sees changes until the switches are turned on).

1. **Rebar.StirrupCoverMm.** Stock 30. **What it changes:** the cover offered at the STR cover question. Tim stored: not stored, so the stock default applies. **NOT STORED.**
2. **Rebar.StirrupCoverWarnBelowMm.** Stock 10. **What it changes:** with the switch ON, a cover typed under this prints a warning line. Tim stored: not stored, so the stock default applies. **NOT STORED.**
3. **Rebar.WarnInsteadOfChangeStirrupCover.** Stock OFF. **What it changes:** OFF keeps today (a cover under 10 is quietly made 10); ON keeps what was typed and prints a line. Tim stored: not stored, so the stock default applies. **NOT STORED.**
4. **Rebar.SpacingLowestMm.** Stock 50. **What it changes:** the lowest reo spacing the question takes. Tim stored: not stored, so the stock default applies. **NOT STORED.**
5. **Rebar.SpacingHighestMm.** Stock 1000. **What it changes:** the highest reo spacing the question takes. Tim stored: not stored, so the stock default applies. **NOT STORED.**
6. **Rebar.WarnInsteadOfRefuseSpacing.** Stock OFF. **What it changes:** OFF keeps today (AutoCAD refuses a spacing outside 50 to 1000); ON keeps what was typed and prints a line. Tim stored: not stored, so the stock default applies. **NOT STORED.**

## What was not looked at

1. Remembered "last answers" files (for example CD_RecentValues.json) were not read. They are not Settings keys.
2. Only the values of the keys above were quoted. No job names, client names or user-name paths were read into this report.
