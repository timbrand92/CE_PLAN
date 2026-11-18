# R-014 — Garden (pervious) runoff coefficient for Melbourne OSD sums

## Checked at source, 19 Nov 2026

Checked against the office's own spreadsheets (the two Boyd's method sheets and the detention comparison sheet), the OSD4 folder, AS/NZS 3500.3:2018, and council guideline documents in the office Councils folder. Spreadsheet formulas were read cell by cell with Excel opened read-only.

### Plain answer

1. **The office Boyd's sheet uses 0.35 for garden, not 0.30.** "BOYDS METHOD In Liters.xls" has 0.35 written into its runoff-coefficient formula. With 0.35 it reproduces its own stored result of 2,711 L. With 0.30 the same sheet gives about 2,589 L.
2. **Council documents favour 0.30 for garden (pervious) areas, with 0.90 for impervious.** That is the figure in Banyule, Bayside 2026, Brimbank (5-year), Maroondah and the earlier Yarra guideline. 0.35 appears in councils mainly as a whole-site pre-development figure (Banyule, Bayside, Boroondara, Darebin), not as a garden figure.
3. **The two figures share one root.** Brimbank's frequency table takes a 10-year grass value of 0.35 and multiplies it by the ARR 1987 frequency factor, giving 0.33 at 5 years and 0.30 at 2 years. So 0.35 is a 10-year garden value and 0.30 is roughly a 2-to-5-year value.
4. **OSD4W has no built-in garden coefficient.** The user types the coefficient for each sub-area.
5. **How sure:** high for the spreadsheets (formulas read directly) and OSD4W (user guide); medium-high for councils (text read directly; dates and versions as printed).

### The office spreadsheets

1. **BOYDS METHOD In Liters.xls (the office example):**
   - **Roof and paved:** not split. One "impervious area" with 0.9, written inside the formula in cell E35. There is no 1.0 roof coefficient.
   - **Garden/pervious:** 0.35, written inside the same formula. Pervious area is worked out as total area minus impervious area.
   - **Pre-development:** 0.4, typed in cell D30, next to a 5-year intensity of 87 mm/h. The permissible discharge (4.70 L/s, cell E30) is typed, not calculated. From the sheet's own inputs (87 mm/h, 0.4, 595 m²) it would be 5.75 L/s, so the 4.70 came from somewhere else.
   - **Storm intensities:** typed, 10-year, for 5 to 30 minutes.
   - **Method:** inflow = intensity x (C x A) / 3600 in L/s; volume = minutes x 60 x inflow; storage = volume x (1 − outflow / inflow); answer = largest storage.
   - **Rounding:** none. No ROUND functions. The sheet only shows 2 decimals; full values are used. Inflow is not rounded before storage is worked out.
   - **Printed (stored) storage:** 2,711 L, at 10 minutes.
   - **Re-run with 0.30 garden:** C x A falls from 431.0 to 421.5 m², and storage falls to about 2,589 L (still at 10 minutes). **0.35 reproduces the sheet; 0.30 does not.**
2. **BOYDS METHOD calculations_SWS November 2013.xls:** a generic demonstration sheet from an outside consultant (10 ha catchment, 100-year). One whole-catchment coefficient of 0.6, typed. No roof, paved or garden split and no pre-development coefficient. Outflow 0.2 m³/s typed. Same method, with /360 for hectares. Largest storage 2,214 m³ at 90 minutes. No rounding.
3. **DETENTION CALCULATIONS_COMP_SAM.xlsx:** no runoff coefficients at all. It takes the site storage requirement as a typed figure (4.36 m³ in the office example), adds up pit and pipe volumes below top water level, and shows the shortfall to put into rainwater tanks. It also works out pipe cover (cover level − invert − pipe diameter) but has no minimum-cover check value.

### AS/NZS 3500.3:2018, clause 5.4.6 (office copy)

1. **Roof 1.0, paved 0.9** (Australia).
2. **Pervious:** Cp = m x (0.0133 x 10I60 − 0.233), where 10I60 is the 10-year, 1-hour intensity (use 25 if less, 70 if more). Add 0.1 for clay, take off 0.1 for sand, never below 0.1. This is the same as the ARR 1987 formula quoted earlier, written differently.
3. **Multiplier m (Table 5.4.6(A)):** 0.95 for 5 years, 1.0 for 10 years, rising to 1.2 for 100 years.
4. **Melbourne worked example (Appendix K):** 10I60 = 28.6 mm/h, loam: Cp = 0.147 x 0.95 = 0.14 for 5 years.

### OSD4 folder

1. **OSD4W user guide (v1.07.3):** "just enter the appropriate coefficients against the sub-areas". No default pervious or impervious value. The only fixed values are 0.0 for runoff fully captured and 1.0 for uncontrolled runoff (notional). The zones file holds rainfall coefficients, not runoff coefficients.
2. **onsitestormwaterdetention.pdf:** scanned, no readable text. Not checked.
3. **Not opened:** the "user key details" file (a keys file), the jobfiles and the .osd job file.

### Council by council (coefficient, document, page or clause)

1. **Banyule, Stormwater Requirements for New Developments (amended 30 Sep 2019):** page 12, minimum C 0.30 for grassed/landscaped, 0.90 for paved, 0.65 residential lots. Page 17 (OSD): pre-developed site 0.35 regardless of existing hard surfaces; post-developed 0.9 impervious, 0.3 pervious. Page 13 note 1: PSD on site C = 0.35.
2. **Bayside, Developer Drainage Design Guideline 2026 (March 2026), section 5.1:** 0.3 pervious (grass, open space), 0.9 impervious (roofs and driveways). Section 3.1: PSD from the whole site at 0.35, 5-year, 5-minute storm. Same in the May 2024 draft.
3. **Boroondara, Stormwater Drainage and Build Over Easement Guidelines (January 2017), Table 3-3 and note 1:** PSD at combined 0.35 whatever the existing site; post-development at land-use value or 0.65, whichever is greater. No garden figure.
4. **Brimbank, OSD Guidelines (Word file), "Run-off Coefficient":** roof 1.00, paved 0.90, landscaped/grassed 0.30, stated for 5-year. Its frequency-factor table gives grass 0.28, 0.30, 0.33, 0.35, 0.36, 0.40, 0.42 for 1, 2, 5, 10, 20, 50, 100 years. Its worked example uses 0.33 for pervious and 0.9 for impervious. The text (0.30) and its own table (0.33 at 5 years) do not agree.
5. **Darebin, Design and Legal Point of Discharge guidelines, PSD section (about page 7):** text says PSD at an average C of 0.4 (5-year), but the formula beside it says C = 0.35. Design criteria table: residential pre 0.4, post at least 0.8; commercial pre 0.6, post at least 0.90. Darebin uses OSD4.
6. **Kingston, Civil Design Requirements Part A v4.4:** residential PSD at C = 0.4 whatever the existing site (5-year); commercial and industrial the lower of existing or 0.7. Pipe design: residential 0.6, commercial 0.9, industrial 0.9. No garden figure.
7. **Maribyrnong, Stormwater Drainage Requirements Guidelines, 1.4.3:** pre-development C 0.4; post-development at least 0.75. No garden figure.
8. **Maroondah, Engineering Development Design Guidelines, page 15:** 0.9 impervious, 0.3 pervious. Pre-development worked at 35% coverage = 0.51 (or less if the site is less covered). Table 1: vacant-land values by lot size.
9. **Melton, Engineering Design and Construction Manual 2019, 13.7, pages 92 to 97:** ARR formula (pervious C'10 = 0.1 + 0.0133 (10I1 − 25)); impervious 0.9; frequency factors 0.80 to 1.20. Table 17 regional pervious C'10: about 0.115 (Cardinia and Casey), 0.154 (Wyndham and Melton), 0.160 (Hume, Whittlesea, Mitchell).
10. **Merri-bek (office copy titled Moreland, "Drainage design criteria for developments", March 2009), step 4:** pre-development pervious 0.4, impervious 0.6, OSD pre-development 0.4; post-development pervious 0.2, impervious 0.8 (5-year, ARR 1987); commercial and factory pervious 0.1, impervious 0.9 (10-year).
11. **Whittlesea, Guidelines for Urban Development (2015), 13.7.4:** ARR method with Table 16 fraction impervious; OSD base case fraction impervious 0.35. Table 17 values not read.
12. **Wyndham, Drainage Design Guidelines (October 2020), 4.1.5:** defers to VPA engineering standard 13.7; OSD impervious 0.9; no pervious figure stated.
13. **Yarra, earlier Development Engineering Guidelines (v1.2), 5.1.6:** impervious (roof or paved) 0.9, pervious 0.30, 5-year. The July 2026 Drainage Design Guidelines use a 70% impervious site for PSD and state no garden coefficient.
14. **Greater Geelong, stormwater detention storage design (Word file):** Table 3 runoff coefficient by fraction impervious (ARR style); the table is an image, values not read.
15. **Casey, Frankston, Manningham, Monash, Moonee Valley, Nillumbik:** no runoff coefficient found in the guideline text. (Nillumbik refers to its Appendix A by fraction impervious.)
16. **Knox:** no Knox folder in the office reference set. Not checked.
17. **Melbourne Water folder:** a raingarden leaflet only. No coefficient.

### Verdict on each earlier claim

1. **"No single Melbourne-wide figure":** CONFIRMED.
2. **"0.35 is supported by Knox only":** WRONG as stated. Knox is STILL NOT CHECKED (not held), but 0.35 is also the garden value in the office Boyd's sheet and Brimbank's 10-year grass value, and the whole-site pre-development value in Banyule, Bayside, Boroondara and Darebin.
3. **"0.30 is supported by Merri-bek (post-development pervious 0.30, impervious 0.90)":** WRONG for the office copy (March 2009): post-development pervious 0.2, impervious 0.8. 0.30 with 0.90 is supported by Banyule, Bayside 2026, Brimbank, Maroondah and the earlier Yarra guideline.
4. **"Nothing states the pervious coefficient OSD4W uses":** CONFIRMED. OSD4W has none built in; the user types it.
5. **"The old office sheet reproduces its printed storage with 0.30":** WRONG for the office Boyd's sheet in litres. It uses 0.35, which reproduces 2,711 L; 0.30 gives about 2,589 L. No other office sheet with a garden coefficient was found in the permitted folders.
6. **ARR 1987 pervious formula and C10 = 0.9f + C'10(1 − f):** CONFIRMED through AS/NZS 3500.3:2018 clause 5.4.6 and Melton 13.7 (which cites ARR 2003 edition, Book VIII 1.5.5). ARR itself not opened.
7. **Frequency factors "no table values":** now found: 0.80, 0.85, 0.95, 1.00, 1.05, 1.15, 1.20 for 1, 2, 5, 10, 20, 50, 100 years (Melton 13.7, Brimbank). CONFIRMED.
8. **"Melbourne's 10I1 is below 25 mm/h" (from memory):** WRONG for the standard's Melbourne example, which uses 28.6 mm/h. The conclusion still holds: the formula gives about 0.11 to 0.16 (Melton regions) or 0.14 (3500.3 example), well under 0.30.
9. **Knox 0.35 / 0.90, cap 0.4:** STILL NOT CHECKED.
10. **Merri-bek "sources disagree" (0.4/0.6 and 0.3/0.9 against 0.1/0.9):** the office 2009 copy has all three sets: 0.4/0.6 pre, 0.2/0.8 post residential, 0.1/0.9 commercial. Which version is current is STILL NOT CHECKED.
11. **Melton "pre-development coefficient from Council":** the 2024 OSD guideline is not held. STILL NOT CHECKED. The 2019 manual gives the ARR method above.
12. **Monash developer report figures:** STILL NOT CHECKED (not a guideline document).
13. **OSD4W conference abstract and Boyd 1993 paper:** STILL NOT CHECKED.
14. **Recommendation "default 0.30 for OSD4W, 0.35 for Knox-style":** the council documents support 0.30 with 0.90 as a default. The office's own Boyd's sheet uses 0.35, which matches a 10-year storm. Make it an editable setting and show which storm it belongs to.


Researched 19 Nov 2026 (Melbourne). Public web only. No job data used.

## ANSWER FIRST

1. **No single Melbourne-wide figure was found.** Both 0.30 and 0.35 are council-adopted values, not figures derived from Australian Rainfall and Runoff.
2. **0.35 is supported by Knox only** (pervious 0.35, impervious 0.90, in a modified Swinburne method). Not checked at source: I saw it only in a search snippet.
3. **0.30 is supported by Merri-bek** (post-development pervious 0.30, impervious 0.90 for residential). Not checked at source: search summary of a Word file.
4. **I found nothing that states the pervious coefficient OSD4W uses.** So the office ruling of 0.30 for OSD4W is not confirmed or contradicted by any source I opened.
5. **The old office sheet reproducing its printed storage with 0.30** is consistent with a 0.30 pervious coefficient being what that sheet used. That is a fact about the sheet, not about a standard.

Nearly every document was a PDF or Word file that the research tool could not read directly. Everything below is therefore "not checked at source" unless stated.

## 1. Australian Rainfall and Runoff 1987 (urban rational method)

1. **Pervious coefficient formula:** C'10 = 0.1 + 0.0133 x (10I1 − 25), where 10I1 is the 10-year, 1-hour rainfall intensity in mm per hour. Not checked at source. I saw it quoted through search summaries that said a Victorian road design manual (Victorian Planning Authority engineering manual, draft 2011) and an Austroads road design guide reproduce it. I did not open either, nor ARR 1987 itself.
2. **Impervious value and blending:** C10 = 0.9 x f + C'10 x (1 − f), where f is the fraction impervious. Same status.
3. **Frequency factors:** said to multiply C10 for other ARIs. I found no table values. Not confirmed.
4. **What it gives for Melbourne:** not computed. I found no source for Melbourne's 10I1. A software help page says the formula is valid from about 25 mm/h upward; that limit is not from ARR. From memory (not checked) Melbourne's 10I1 is below 25 mm/h, which would put the formula at or below about 0.1, far under 0.30 or 0.35. Treat that as a lead to check, not a finding.
5. **Conclusion:** ARR 1987 does not give 0.30 or 0.35 for Melbourne gardens by that formula. Councils use higher, more conservative values.

## 2. Council sources

1. **Knox City Council, Stormwater Drainage Guidelines (2006 per search).** Pervious 0.35, impervious 0.90 for a weighted coefficient. Site discharge limited to a weighted coefficient of 0.4. Modified Swinburne method with Q = CIA/360. Coefficients said to follow the VicRoads drainage chapter. Clause numbers and design ARI not obtained. Not checked at source.
2. **Merri-bek City Council, Drainage Design Criteria for Developments (Word file; a 2009 PDF also exists).** Residential: pre-development pervious 0.4, impervious 0.6; post-development pervious 0.3, impervious 0.9; 5-year ARI; times of concentration 12 minutes pre and 7.5 minutes post; ARR 1987 intensities. Commercial and factory: 10-year ARI, pervious 0.1, impervious 0.9. Not checked at source. **Sources disagree:** the 2009 PDF reportedly gives pervious 0.1 and impervious 0.9 only. I could not tell which version is current.
3. **Melton City Council, On Site Stormwater Detention Guidelines (2024 per search).** The pre-development coefficient has to be obtained from Council. No numbers found.
4. **Monash City Council, a 2024-era stormwater report for a Glen Waverley site.** This is a developer's worked example, not a council standard. Pre-development C 0.634 (fraction impervious 0.645), post-development C 0.704, used OSD4. Not checked at source. It shows how a weighted C is stated, nothing more.
5. **Maroondah, Maribyrnong, Yarra, Yarra Ranges, Frankston, Wyndham, Whittlesea, Casey, Boroondara and others.** Could not read or did not reach. Maroondah has a rational-method section and a vacant-land coefficient table by lot size; values not seen.
6. **Melbourne Water.** Page refused access. Nothing found.

## 3. OSD4W and the modified rational method

1. **OSD4W.** An IPWEA Victoria conference abstract (2026, opened) says OSD4w is the common Victorian tool for the Swinburne Method (Phillips, 1995), is no longer maintained, uses 1987 rainfall data and has no climate change adjustment. It does not state its pervious coefficient. I found no source that does.
2. **Boyd 1993 ("Pervious and impervious runoff in urban catchments", Hydrological Sciences Journal).** Seen only as a citation. Not opened. I found nothing on a Boyd-style sum used by councils.

## 4. Which figure each source supports

1. **0.35 pervious:** Knox (snippet).
2. **0.30 pervious (post-development):** Merri-bek (summary of file).
3. **0.40 pervious (pre-development):** Merri-bek, residential. Knox caps weighted site C at 0.4.
4. **0.10 pervious:** Merri-bek commercial, and its 2009 PDF (reportedly).
5. **ARR 1987 formula:** a much lower figure than either, if the Melbourne intensity is as I recall (not checked).
6. **OSD4W:** no source.

## RECOMMENDATION

1. **Make the pervious coefficient a visible, editable setting, shown with its source name**, not a hidden constant.
2. **Default 0.30 for OSD4W-style sums** (keeps the office ruling, matches Merri-bek and the old sheet) and **0.35 for the Knox-style modified Swinburne sum** (keeps the office ruling, matches Knox). Impervious 0.90 for both.
3. **Do not claim either figure is "the standard."** Label them "council value, not checked at source".
4. **Engineering judgement and council values need Tim's word.** The two figures should be confirmed by reading the Knox and Merri-bek documents directly, and by checking which coefficient the OSD4W programme itself applies, before they become locked rules.

## What I could not confirm

1. The text of ARR 1987 (the pervious formula, impervious value, frequency factors) and Melbourne's 10-year 1-hour intensity.
2. Any figure from a document I actually opened for Knox, Merri-bek, Melton, Maroondah.
3. Which Merri-bek version is current (0.4/0.6 and 0.3/0.9 against 0.1/0.9).
4. What coefficient OSD4W uses.
5. Boyd's formula and any Melbourne council's modified rational sum.
6. Melbourne Water and Victorian planning guidance on OSD coefficients.
7. Pre-development rules for every other Melbourne council.
