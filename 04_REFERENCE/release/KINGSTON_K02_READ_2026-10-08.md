# Kingston K02 read: commercial PSD figures (BUG-251)

Thu 8 Oct 2026, 05:30-05:50 PC clock. Design run 3 (headless, Opus). Read-only. Text extracted with pypdf from a scratchpad script; nothing copied into a repo. Wording below is PARAPHRASED (copyright).

## FOR TIM

1. **Answer: Tim's two rulings stand. The manual agrees with both.** K02 page 14 says a commercial or industrial lot under 1000 m² uses a 7-minute time of concentration (INT-071 16b). The pre-development C is the lower of the existing site C and 0.7 (INT-071 16c). The PSD storm and the storage storm are both 1 in 10.
2. **Which file is K02:** the file in the Kingston council folder named `Civil-Design-requirements-for-Developers-Part-A.pdf` (dated 7 Apr 2020 on disk). Its SHA-256 `47d5c743...f6b1` matches the K02 fingerprint recorded on 10 Sep. Its cover says **Version 5, September 2018**.
3. **LOUD FLAG: the plan file's label is wrong, but its figures are right.** `02_COUNCIL_RULES/COUNCIL_KINGSTON_ISSUE5_2025.md` calls its source "Issue 5, 2025". It quotes AS/NZS 3500.3:**2021** and writes the storms as AEP (20 %, 10 %). None of the three Kingston PDFs on this PC says that:
   - **K02 (Version 5):** dated September 2018, writes the storms as ARI ("1 in 10 year"), and names AS/NZS 3500.3:**2015**.
   - **2021-dated file:** an OLDER edition.
   - **2025 file:** a different document.

   Either the September reader used a newer Kingston edition that is not saved on this PC, or the label and the 2021 quote are wrong. **The commercial figures do not change either way.** The standards-edition claim (STD-02: "Kingston requires 3500.3:2021") is NOT supported by any local Kingston PDF. Treat it as unverified until the source document is found.
4. **Nothing for Tim to decide here.** The figures are already ruled. The flag in item 3 matters only to whoever relies on "Kingston requires the 2021 edition".

---

## 1. The three documents (what each actually is)

1. **`Civil-Design-requirements-for-Developers-Part-A.pdf`**: 29 pages, on-disk date 7 Apr 2020. Cover: Part A Integrated Stormwater Management, **Version 5, September 2018**. Revision table: version 5 approved 11/09/2018 ("reformatting and minor revisions"). SHA-256 `47d5c7438459a3b7dd3292bcc58cd60bb5602874ce5c5cc2aff910748203f6b1` = **K02**. Cites AS/NZS 3500.3:2015 throughout.
2. **`Civil-Design-requirements-for-Developers-Part-A-Integrated-Stormwater-Management-Version-4-4.pdf`**: 27 pages, on-disk date 7 Apr 2021. Cover dated **May 2016**. The revision table ends at **Issue 4** (23/5/16). **This is the OLDER edition (Issue 4).** Only the file's on-disk date is newer. SHA-256 `2d93d41a...53b5`.
3. **`kingston-stormwater-guide-for-developers-2025_v2.pdf`**: 4 pages, on-disk date 21 Mar 2025. This is the **stormwater quality in-lieu contribution guide**. It has no PSD storm, Tc or runoff-coefficient figures. **It is not a Part A edition and holds none of the K02 values.**

A wider file-name search of the Creative Engineering folders found one more Part A copy: a superseded-folder file named "dated 09-2018" (presumably K02 again, not hashed). It found a second copy of the Version 4 file. **It found no 2025 Part A.**

## 2. Figure by figure

1. **PSD storm, commercial: 1 in 10 year ARI.**
   - **Where:** K02 printed page 14 (PDF page index 13), section 4.1 (ii), which covers industrial and commercial developments together.
   - **Paraphrase:** industrial and commercial PSD is calculated on a 1 in 10 year ARI storm.
   - **Plan file:** says 10 % AEP. **MATCHES** (same storm, other notation).
   - **Issue 4 (2016):** same, on page 9.
2. **Pre-development C, commercial: lower of the existing site C and 0.7.**
   - **Where:** K02 page 14, same bullet.
   - **Paraphrase:** use the lower of the existing site imperviousness (where C is below 0.7) or C = 0.7. The manual gives the reason for the 0.7 ceiling: council's existing drainage lacks capacity. The same page also allows an alternative: the designer may investigate council's downstream pipes, down to where the pipe is at least 600 mm, and put the result to council.
   - **Plan file:** **MATCHES**, including the 600 mm alternative.
   - **Issue 4:** identical, page 9.
   - **INT-071 16c:** consistent. The manual gives no default existing C, so "Unknown until typed" is the right reading.
3. **Tc, commercial: 7 minutes for lots under 1000 m².**
   - **Where:** K02 page 14, the next bullet.
   - **Paraphrase:** 7-minute time of concentration for lots smaller than 1000 sq m. For larger lots the designer determines it (the manual refers to 2016 IFD data).
   - **Plan file:** **MATCHES**.
   - **Issue 4:** identical, page 9, except it points to its own Appendix A rainfall charts, not 2016 IFD.
   - **INT-071 16b:** consistent.
   - The 10 Sep source-regions note marked Tc as "not covered" by its inspected region. The Tc bullet IS on page 14, just below that region (by text extraction; no new region coordinates were measured today).
4. **The 1000 m² limit.**
   - **Where:** K02 page 14 for commercial ("1000 sqm"). Residential (5 min, C = 0.4, 1 in 5) is on page 13.
   - **Plan file:** **MATCHES**.
   - **Not stated in any of the documents:** whether a lot of exactly 1000 m² counts as under or over. The manual says "smaller than" and "greater than", so exactly 1000 is not covered. Recommend that 1000 m² and over → Unknown, the designer sets it (as the card already says).
5. **Storage storm, commercial: 1 in 10 year ARI.**
   - **Where:** K02 page 14.
   - **Paraphrase:** two bullets, one for industrial and one for commercial. Each says to store the difference between the PSD rate (1 in 10) and the developed-site rate in a 1 in 10 year storm.
   - **Plan file:** **MATCHES** (the BUG-251 card already says the storage storm is 1 in 10).
   - **Issue 4:** identical.

**Do not confuse with:** K02 page 17, section 6.1. It gives Council's OWN drainage design storms: residential 1 in 5 with C 0.6, **commercial 1 in 20 with C 0.9**, industrial 1 in 10 with C 0.9. That table is for assets handed to Council, NOT the private-site PSD. A builder must not take "commercial 1 in 20" from it for BUG-251. The same page also gives council pipe speeds of 1 to 3 m/s running full (for council assets only).

## 3. What differs between the documents

1. **Issue 4 (May 2016) vs Version 5 (Sep 2018):** the commercial PSD, C rule, Tc and storage storm are **word-for-word the same in substance**. The only change is the rainfall reference (Issue 4 Appendix A charts → Version 5 "2016 IFD data"). Version 5 also adds a bullet: soakwell / infiltration designs calculate PSD from the soil permeability and the infiltration area.
2. **2025 file:** not comparable. It is the water-quality in-lieu guide and carries no PSD figures.
3. **Plan file "Issue 5 (2025)":** its figures agree with K02. Its AEP notation and its AS/NZS 3500.3:2021 quote are found in **no** local Kingston PDF (see FOR TIM item 3). `docs/workflows/COUNCIL_KINGSTON_DIFF_2013_2025.md` in the plugin repo makes the same "2025" claim. Its source is not recorded in either file.

## 4. Proposed Settings rows (Kingston council profile; every value nullable, Unknown never 0)

Every row cites "Kingston Part A Version 5 (Sep 2018), page 14" and shows "Confirmed by Tim" only where INT-071 says so.

1. **PSD storm, commercial/industrial:** 1 in 10 year (10 % AEP). Source K02 p14. Read from the document. Tim has not separately ruled it.
2. **Storage storm, commercial/industrial:** 1 in 10 year. Source K02 p14. Already in the profile per the BUG-251 card.
3. **Tc, commercial/industrial, lot under the area limit:** 7 minutes. Source K02 p14. **Confirmed (INT-071 16b).**
4. **Tc lot-area limit:** 1000 m². Source K02 p14 (p13 for residential). At and above the limit, Tc = Unknown, and CE asks the designer.
5. **Pre-development C cap, commercial/industrial:** 0.7. Rule: pre-development C = the lower of the existing site C and 0.7. Source K02 p14. **Confirmed (INT-071 16c).**
6. **Existing site C (per job, not per council):** blank. While blank, the pre-development C shows Unknown with a warning, and CE never assumes 0.7 (INT-071 16c).
7. **Residential rows (already present, for comparison):** 1 in 5, C = 0.4 regardless of the existing site, Tc 5 min under 1000 m² (K02 p13).
8. **Not a Settings row:** the 600 mm downstream-capacity alternative. It is a note on the report only; CE does not calculate it.

Builders: map the site case through the existing `siteCaseByLandUse` (industrial and commercial share one case in K02). The report's "Q minor (1-in-5 yr)" line must follow the land use.
