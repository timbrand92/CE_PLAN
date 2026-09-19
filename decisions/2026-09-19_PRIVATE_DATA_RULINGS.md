# Private data rulings — Tim, 19 September 2026

Recorded from the step 4 questions (SETUP_BRIEF v3). His words in quotes.

1. **The structural corpus in the plugin repo** (73 snapshot files named after real jobs plus eight root CSV/JSON files, about 15,000 address mentions, on GitHub since July): *"take it out of repo but make sure we still get access"*. Done the same day: the whole `Docs\CEMARKUP_Corpus` folder copied to `C:\CE_DrawingIntelligence\10_Plugin_CEMARKUP_Corpus\`; the removal from the repo is a plugin PR (see `areas\structural.md`). The code reads only the manifest, which stays.
2. **Probe reports, calibration notes and drainage tests naming real jobs:** replace with job numbers (recommended, accepted). Rule applied: where the street matches exactly one office job, `[job NN-NNN]`; where several jobs share the street, `[job address withheld]`; addresses that match no job are left, they are not real. In test code the swap happens in the plugin PR with a build, not by hand.
3. **The archive copies in CE_PLAN and the bug register line:** same treatment (accepted). Applied in this commit.
4. **The single matches in Hush, personal finance and the job manager:** *show each line with the address blanked*. Shown 19 Sep; his answer per line is still open.
5. **Rewriting GitHub history** so the addresses vanish from old versions: not decided; only after 1 to 4.
