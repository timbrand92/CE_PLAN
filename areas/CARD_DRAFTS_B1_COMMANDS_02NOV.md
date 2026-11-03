# Card drafts: commands touched by the b1 train (C-79b1), no new card needed (Mon 2 Nov 2026, Melbourne)

Written by Sonnet (Team, read-only) on CE 00's order. Only this file was written. Nothing was built, tested, installed or opened in AutoCAD. The robot was not run. Tim's settings files were not read. Nothing here is approved.

The brief named the output file as `C:\CE_PLANreas\...` (a lost backslash). I wrote it to `C:\CE_PLAN\areas\` beside the other card drafts. CE 05: move it if you meant somewhere else.

---

## FOR TIM

1. **Answer: no new cards are needed.** All 17 user-facing pull requests on the b1 train already have a card in the other 02 Nov card drafts. The one left over (#1922) changes no command.
2. **What "b1" is.** C-79b1 is Civil 3.0.90, branch `rel-20261108a`, head cf059dcf (checked after a fresh fetch). The branch `rel-20261110a` (b2) is at d4ce878e.
3. **What is installed.** The brief says Civil 3.0.89 = commit 61fd6fbc. I did not read the installed DLL, so I took that from the brief. None of the 18 b1 pull requests is inside 61fd6fbc, so none of them is in 3.0.89. All 18 are new in b1.
4. **The one pull request with no card: #1922 (BUG-1257).** It stops Structural test runs writing into the real CE folders. You never see it in AutoCAD, so there is nothing to approve as a command.
5. **Nothing for you to decide here.** The questions for these changes are already in field 18 of the existing cards.
6. **Not proven, anywhere:** none of this has been opened in AutoCAD. The b1 build is made but not installed. No robot PASS, no Codex PASS, and none of it is accepted.
7. **What I read:** RULES.md, the b1 first-parent list, each PR head's ancestry against 61fd6fbc, each PR's changed files, and the headings and PR lines of the existing card drafts. **What I did not do:** read the PR text or code in depth (I relied on the existing cards for that), build, test, or open AutoCAD.

---

## Skipped: already covered (17 pull requests)

Card file names are in `C:\CE_PLAN\areas\`. Each PR head is NOT in 61fd6fbc (read with `git merge-base --is-ancestor`).

1. **Edit Pipe and level entry** (`CARD_DRAFTS_EDIT_PIPE_02NOV.md`):
   1. #1969 (BUG-1164, comma-decimal PC level)
   2. #1970 (BUG-1157, level not saved message)
   3. #1972 (BUG-658, downstream levels not recalculated message)
   4. #1892 (BUG-1141, one unreadable record no longer stops the link memory), also carded in the Inspector file
2. **Inspector, CDCHECK, saved record and Undo** (`CARD_DRAFTS_INSPECTOR_CHECKS_02NOV.md`):
   1. #1880 (BUG-1240), #1953 (BUG-1263), #1955 (BUG-1264), #1958 (BUG-1266), #1951 (BUG-1265), #1952 (BUG-1070), #1892 (BUG-1141)
3. **Labels** (`CARD_DRAFTS_LABELS_02NOV.md`):
   1. #1923 (BUG-430, pit-label double-click; default OFF)
   2. #1891 (BUG-1246, copied downpipe gets its own tag)
4. **Redesign Apply and CDDESIGN outlet warnings** (`CARD_DRAFTS_CDDESIGN_02NOV.md`):
   1. #1940 (BUG-1144), #1943 (BUG-1153), #1945 (BUG-1158)
5. **Cover and CDRULES minimum fall** (`CARD_DRAFTS_COVER_RULES_02NOV.md`):
   1. #1868 (BUG-1091, redesign reads the minimum fall)
6. **Twin detention pipe upgrade** (`CARD_DRAFTS_LONGSECTION_MISC_02NOV.md`):
   1. #1950 (BUG-1152, a refused upgrade puts the main line back)

I checked that each of these is a real card or card section, not just a passing mention. For example, #1940, #1943 and #1945 are card 3 of the CDDESIGN file, and #1970 is card 3 of the Edit Pipe file.

## Skipped: not a user-facing command

1. **#1922 (BUG-1257)**: Structural test runs write nothing into the real CE folders. It touches Structural logging code and test support only. Per the AGENTS.md review gate, no command or workflow is changed, so no card.
2. **The finalizer and version commits** (6e24ea6d, f5eebc77, 2363cc1a, 24c8e539, 4445c243, 79636fcc, bab2dbf8, cf059dcf): tests, a safety baseline list, a byte-order fix on the settings file, the change-log cleanup and the version number. None changes a command.

## Things worth knowing

1. **The existing card files carry old branch wording.** Some say "C-79b1 is not installed" or give the install slot as Tue 3 Nov. That is the same position as the brief. Do not treat those lines as live truth.
2. **Manager and Structural.** Between 61fd6fbc and cf059dcf, Manager has no user-facing change. Structural has only the test-isolation change in #1922 (logging folder redirect).
3. **Two open points from the existing cards, not settled by me:** the finalizer says area re-test but Opus said full re-test for #1952 and #1955 (Inspector file, point 6). The pit-label double-click ships OFF until Codex has looked (Tim, 22 Oct).
