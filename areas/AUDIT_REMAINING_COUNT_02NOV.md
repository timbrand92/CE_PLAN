# Carpark recount by status and class, Mon 2 Nov 2026

Written by Sonnet (Team) for CE 05, Melbourne time. Read-only job. The only file I wrote is this one.

Note on the output path: the order named `C:\CE_PLANreas\...`. I took that as a lost backslash and wrote to `C:\CE_PLAN\areas\AUDIT_REMAINING_COUNT_02NOV.md`.

## FOR TIM

1. **Carpark size now:** 1,222 numbered entries (carpark as at commit cc76aa89, Mon 2 Nov 21:20). The audit covered 1,217 of them. Six are not in the audit: BUG-1269 to BUG-1273 (added after it) and BUG-195.

2. **Still OPEN:** 1,056 entries carry the word OPEN. Of those, 157 are really fixed with stale text (audit reading), 472 are on the release line waiting for proof, and 196 have a draft fix that is not on the line.

3. **FIXED the ledger way:** 27 entries (21 "Codex-accepted" and 6 "Claude-accepted"). Another 6 are FIXED on Tim's own word. The other 42 entries that start with FIXED carry no ledger wording (old May to September entries, many only "FIXED IN SOURCE"). Do not count those as accepted.

4. **Built but not accepted:** about 732 entries by the audit's reading: 534 are on the line and nobody has proved them in AutoCAD, and 198 have a draft fix that is not on the line. The carpark's own "IN PROGRESS" label covers 48.

5. **Needing Tim:** 91 entries (his engineering or design call). A further 65 are UNCLEAR and need a test drawing or a re-test before anyone can say what is wrong.

6. **No job yet (nothing built, no draft):** 75 are FIXABLE-NOW by the audit. My own check found 38 of those with no commit, no branch and no carpark PR note at all; the other 37 have something I did not size.

7. **Correction to the audit's top 25:** BUG-497, 498, 1080, 1081, 1083, 1064, 1065 and 1175 do have fix work already (see item 4 under the content). They are not "no PR". The real ten that could be built today are in item 5 below.

8. **NOT proven:** I opened no AutoCAD, read no installed DLL, built and tested nothing, and could not run `gh` (not installed on this tool path), so "no PR" means "no commit, no branch, no PR note in the carpark".

---

## 1. What I read, built and tested

1. **Read:** `C:\CE_PLAN\BUG_CARPARK.md` (counted every entry by its last Status line, by script), `areas\AUDIT_CLASS_ALL_02NOV.md` (parsed all 1,217 merged lines by script; I read the first 245 lines by eye), `C:\TimOS\RULES.md` (top part).
2. **Git:** `git fetch origin` run first (done, no error). Read-only `git log`, `git branch -r` and `git merge-base --is-ancestor` only. About 7,900 commit subjects since 1 Sep and 5,082 remote branches were searched by bug number.
3. **Not read:** the 21 chunk files one by one. The merged file carries the same lines, so I used it.
4. **Built:** nothing. **Tested:** nothing. **Run:** no robot, no AutoCAD, no `gh`.

## 2. The line heads I used

1. **Installed authority:** Civil 3.0.89 = commit 61fd6fbc ("Civil 3.0.89 / Manager 1.1.89 (C-79a)"). It sits on `origin/claude/rel-20261106a`.
2. **Candidate b1:** `origin/claude/rel-20261108a` = cf059dcf (Civil 3.0.90).
3. **Candidate b2:** `origin/claude/rel-20261110a`. Also present on origin: `rel-20261112a`.
4. **The old line in the order:** `origin/claude/rel-20261102a` head is 3fbb9da5 (Civil 3.0.88), one release behind the authority. The audit used it as "the line". Its "on the line" calls were not re-checked against 61fd6fbc, except for the fixes named in section 5.
5. **Structural line:** `origin/claude/rel-20261026s`.

## 3. Counts by the carpark's own Status word (1,222 entries)

I took the last Status line in each entry.

1. **OPEN:** 1,056.
2. **FIXED (starts with the word):** 75. By wording: 21 Codex-accepted, 6 Claude-accepted, 6 on Tim's word, 42 with no ledger wording.
3. **IN PROGRESS:** 48.
4. **WONT FIX:** 23.
5. **DUPLICATE OF:** 7 (plus 8 more still reading OPEN that the audit calls duplicates, so 15 in all).
6. **Other first words:** 13 (TIM x3, and one each of investigated, closed, SEEN, RULED, RESTORED, REOPENED, NOT, MEDIUM, DECIDED). BUG-865 has no Status line of its own (its status sits under a neighbouring heading).
7. **Check:** 1,056 + 75 + 48 + 23 + 7 + 13 = 1,222.

Caveat: the word-matching is mine. The carpark has two older formats (Status inside the paragraph, and "Status (round 3)"), so a few entries could sit one bucket out.

## 4. Counts by audit class (1,217 audited entries)

1. **INSTALLED-WAITING-PROOF:** 534 (on the release line, not proved in AutoCAD).
2. **ALREADY-FIXED:** 205 (the audit's reading; the ledger wording was not checked for each).
3. **HAS-DRAFT:** 198 (draft fix exists, not on the line).
4. **NEEDS-TIM:** 91.
5. **FIXABLE-NOW:** 75.
6. **UNCLEAR:** 65.
7. **CLOSED-OR-WONT-FIX:** 34.
8. **DUPLICATE:** 15.
9. **Check:** 534 + 205 + 198 + 91 + 75 + 65 + 34 + 15 = 1,217.

How the 1,056 OPEN entries fall by audit class: 472 on the line waiting for proof, 196 draft not on the line, 157 already fixed with stale text, 83 needs Tim, 74 fixable now, 58 unclear, 8 duplicates, 2 closed or won't fix, 6 not audited.

## 5. The ten with the highest pilot impact, no PR yet, buildable today

Rule used: audit class FIXABLE-NOW, pilot-critical yes, and my search found no commit, no branch and no carpark PR note for the number. Wrong numbers on a drawing first, then the colleague install, then workflow.

1. **BUG-1052:** CDAGI treats drawing units as millimetres, so run lengths are wrong in a metre drawing. The entry gives the fix and a 1:10000 test.
2. **BUG-1053:** the LandXML import reads rim levels with no unit conversion. Fix: convert to metres, otherwise show Unknown. The entry has the rule and a test.
3. **BUG-1042:** the Civil tip blocks with "Enter the cover level." It should warn and keep cover Unknown, as the sibling BUG-1043 already does.
4. **BUG-027:** Grade still adds "MIN." against Tim's UX-CPLAN-05 ruling (CdCommand.Grade.cs 212 to 221). The older band rule in the entry must be replaced by the ruling.
5. **BUG-1105:** store tank rating, file, date and litres; warn on a mismatch; allow a typed-reason override. Adds a new warning step, so check the card first (review gate).
6. **BUG-1205:** one crash record per session; call it a crash only if the owner process is gone. It touches a shared file, so Manager has to be synced by hand.
7. **BUG-1208:** write the settings file with a lock, re-read, change one entry, then replace atomically. Same shared-file caution as BUG-1205.
8. **BUG-1166:** one shared office-folder lookup for Civil and Manager (Manager's order already exists). Where Max's OneDrive puts the folder is a separate hand check.
9. **BUG-1173:** wording only. Add three folders and the "MENULOAD, unload CE_SUITE_MANAGER_MENU" line to the colleague pack. The pack's own notes say the code is correct. Fastest of the ten.
10. **BUG-213:** older schedule has no working "Replace older schedule" button (Codex FAIL again on 3.0.49). It adds a button, so it needs the command card approved before code.

Next in line if any of these drop out: BUG-900 (X-Civil PDF reads only one page), then BUG-648, BUG-1148, BUG-1154 and BUG-1160 (none have a pilot flag in the audit; I took them from its top-25 order).

Build-today caution: 1205 and 1208 are shared with Manager, and 1105 and 213 change what the drafter sees, so they come after the card check. 1052, 1053, 1042, 027, 1173 and 1166 are the cleanest starts.

## 6. Corrections to the audit (entries it called "no PR" that have work)

I checked each with `git merge-base --is-ancestor` against 61fd6fbc, rel-20261102a, cf059dcf and rel-20261026s. The first four are on none of those four lines, so they are not installed on 3.0.89.

1. **BUG-497 (bracing and pier table one row short):** commit d30d5a0f, branch `origin/claude/tl2-r132-bug497-sched-rows` (ref `pr/1008`). Not on 61fd6fbc, b1 or the Structural line.
2. **BUG-498 (schedule refresh leaves old rows):** commit ba61da8b, branch `origin/claude/tl2-r132-bug498-refresh-rows` (ref `pr/1011`). Not on any of the four lines.
3. **BUG-1080, 1081, 1083 (locked layer and Xref protection):** commits dc7870a6, 6416f5ca, e6164630, 0d4df01c and fd669805 on branch `origin/cx4/fa07-native-protection` (ref `pr/1721`). Not on any of the four lines. These need Opus review as protection-rule work.
4. **BUG-1175 (CDSL and trench-grate audit name Tim's folder):** commit 3993061a ("B-123 BUG-1175") is on `rel-20261110a` (b2) and `rel-20261112a`. It is NOT in 3.0.89 and NOT in b1.
5. **BUG-1064 and BUG-1065 (installer):** commit fe99515f routes them to the protected installer owner. No code fix found.
6. **BUG-396 (double-click opens Pit Schedule):** has several commits, but they cover only "item 6" (Manager diagnostic wording) and sit on an older line, so the double-click part is still unbuilt. The audit's FIXABLE-NOW call may still be right; I did not settle it.
7. **Effect on the audit's number:** 75 FIXABLE-NOW falls to about 38 truly with nothing built, once entries with any commit, branch or carpark PR note are taken out. This is a keyword match on bug numbers, so a fix committed under a train label (for example "C-79") without the bug number would be missed.

## 7. Skipped items and why

1. **`gh pr list` and `gh pr view`:** `gh` is not on the tool path in either shell. I used remote branches and commit subjects instead. A PR open with no branch or subject naming the bug would not show.
2. **Per-entry re-check of the audit's classes:** not done (not asked, and 1,217 entries is far beyond this job).
3. **Which ALREADY-FIXED entries carry the ledger wording:** not checked, so I report 27 ledger-accepted (Codex or Claude) by the carpark's own words, not 205.
4. **BUG-195 and BUG-1269 to BUG-1273:** no audit class, so left out of the class counts.
5. **Installed DLL version:** not read. 3.0.89 is taken from the order and from the commit subject on 61fd6fbc.
6. **Pilot-critical for the 1,222 as a whole:** not recounted; only the FIXABLE-NOW set was filtered.
