# R-014 — Garden (pervious) runoff coefficient for Melbourne OSD sums

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
