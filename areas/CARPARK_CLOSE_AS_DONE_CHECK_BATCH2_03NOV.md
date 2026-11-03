# Carpark close-as-done check, batch 2, Tue 3 Nov 2026 (read-only code read)

## FOR TIM

1. **Answer:** all 20 fixes are in the installed Civil 3.0.89 (commit 61fd6fbc). Every fix commit passes `git merge-base --is-ancestor` against it. So all 20 are CLOSE-CANDIDATE on code. Only 4 can be closed today, because only those have ledger acceptance.
2. **Already accepted, wording only:** BUG-854 and BUG-815 are marked "FIXED (Codex-accepted, Civil 3.0.64)". BUG-711 and BUG-684 are marked "FIXED (Claude-accepted, Civil 3.0.75)". Those four need no more testing. BUG-684 is only half proved (see below).
3. **13 are fixed in the build but still read OPEN:** BUG-729, 728, 725, 724, 723, 720, 719 (the LandXML import ones), 710, 693, 692, 690, 664 and 651. Nobody has run them in AutoCAD, so the ledger cannot accept them yet. They need a robot or Codex look first.
4. **Most important ones to look at first:** BUG-725 (millimetre LandXML scatters the network), BUG-724 (pipe material overwritten), BUG-710 (wrong grade on a metre drawing, "1:0.1" instead of "1:100") and BUG-690 (a junction could vanish from the Pit Schedule).
5. **Two are partial:** BUG-665 (ROTATE Copy hand-tested by you on 3.0.85, SCALE Copy never tested, and the fix is new in 3.0.89 so the 3.0.85 pass predates it) and BUG-672 (the wording fix is in, no look since). BUG-582 has a fix in the build but its entry has had no test since the fix.
6. **Nothing was built, tested or opened in AutoCAD.** Every verdict is from reading the carpark, the audit and git history. I did not edit BUG_CARPARK.md.
7. **Fetch:** `git fetch origin` ran first. The b1 line (rel-20261108a) and b2 line (rel-20261110a) both contain 61fd6fbc.
8. **Output path:** your order said `C:\CE_PLANreas\`, which looks like a missing backslash. I wrote to `C:\CE_PLAN\areas\`, same as batch 1.

---

## What I checked against

1. **Source of the 20:** the first 20 entries called ALREADY-FIXED in `AUDIT_CLASS_ALL_02NOV.md`, in the audit's order, after batch 1 (BUG-1229, 1215, 1217, 1233, 1230, which were not in that audit list). BUG-854 to BUG-582 below.
2. **Installed line:** Civil 3.0.89 = 61fd6fbc (1 Nov 2026), per the job brief. I did not read the DLL version string on Tim's PC.
3. **Ancestry:** each fix commit was tested against 61fd6fbc, rel-20261102a and rel-20261108a. Result was Y for every commit named below. rel-20261110a contains 61fd6fbc too.
4. **Ledger wording** is quoted from the Status line in `C:\CE_PLAN\BUG_CARPARK.md` as it reads today.

## Close now (ledger acceptance is already on the entry)

1. **BUG-854 (CDRULES R-06 says "diameter" when it means length):** CLOSE-CANDIDATE. Fix 039bedf6 (20 Oct) is an ancestor of 61fd6fbc. Status: "FIXED (Codex-accepted, Civil 3.0.64, 20 Oct 2026)", with robot runs 36, 37, 39, 40 and Codex V2-02. Nothing more is needed.
2. **BUG-815 (false "outside 225-600" on a Detention pipe with no length):** CLOSE-CANDIDATE. Fix 64e6751b (20 Oct) is an ancestor. Status: "FIXED (Codex-accepted, Civil 3.0.64, 20 Oct 2026)" for the R-06 wording and false rows. The status is scoped to that wording; anything wider is not covered.
3. **BUG-711 (typed spot level in metres):** CLOSE-CANDIDATE. Fixes 41d985c4 and c4e7611b are ancestors. Status: "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)", runner case R35 passed in two sessions. Not confirmed in Tim's own drawings.
4. **BUG-684 (CD Existing line keeps a curved source):** CLOSE-CANDIDATE for the half that was proved. Fixes c95e3264 and 6db4dc78 are ancestors. Status: "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)", runner case R39b. The audit notes the "pick an existing CE pipe" half is not proved, so the close should say that.

## Fixed in 3.0.89 but NOT yet accepted (NOT-YET: needs a look in real AutoCAD)

Every one of these still has Status OPEN in the carpark and no robot or Codex line. Fix commits are all ancestors of 61fd6fbc, so none needs new code. They need a robot or Codex run, then the ledger wording.

1. **BUG-725 (millimetre LandXML positions x1000, network scattered):** NOT-YET. Fix 2ed82768 (24 Oct): one position scale for the whole file. Look: import a millimetre LandXML and a no-Units file, check the pits land together.
2. **BUG-728 (LandXML, grouped with 725 and 729):** NOT-YET. Fix 2ed82768. The audit says the "real export" check was never done.
3. **BUG-729 (LandXML rim levels unrounded, large files):** NOT-YET. Fix 2ed82768. Look: a rim of 45.2299999 should read 45.23. The large-file half is a memory matter; I do not know how it can be shown in AutoCAD.
4. **BUG-724 (LandXML overwrites pipe material, "uPVC SN10" to "UPVC SN8"):** NOT-YET. Fix f9eebcfb (24 Oct) keeps the file's pipe class. Look: import a file with "uPVC SN10", "Stormpro sn16" and "Fibre reinforced concrete", and check the class is unchanged.
5. **BUG-723 (LandXML box pipes):** NOT-YET. Fix f9eebcfb flags box pipes.
6. **BUG-720 (LandXML control pit width):** NOT-YET. Fix f9eebcfb splits the control pit width.
7. **BUG-719 (LandXML refStart/refEnd):** NOT-YET. Fix f9eebcfb reads refStart and refEnd. The entry's own "confirm with a real export" step is not recorded.
8. **BUG-710 (CDFALLSUGGEST on a metre drawing, "1:0.1" for "1:100"):** NOT-YET. Fix d51a13cb (merge of PR #1341, 24 Oct). Look: Tim's own case, a spot at 12.30 and a grated pit 20 m away with cover 12.10, on a Metres drawing; Accept should write 1:100.
9. **BUG-693 (pit placed on a curved pipe gives wrong curves):** NOT-YET. Fix 69451402 (23 Oct), merge e428d31f (PR #1688). Look: place a pit on an arc pipe; it should be refused as the same-plan-break route already does.
10. **BUG-692 (grouped with 693):** NOT-YET. Same fix 69451402 and merge e428d31f.
11. **BUG-690 (pit on a pipe: junction past the split vanishes from the Pit Schedule):** NOT-YET. Fix 92ebe3a7 (merge of PR #1659, 24 Oct). Look: place a pit on a pipe that has a junction beyond it and check the Pit Schedule still lists the junction.
12. **BUG-664 (renamed pit, pipe end jumps to the new pit):** NOT-YET. Fix 19f02107 (23 Oct), merge edc3fb97 (PR #1682). Look: rename P5 to P9, place a new pit (P5), run a relink; the pipe end must stay with P9.
13. **BUG-651 (Esc at "Proceed with import?" still imports):** NOT-YET. Fix 2c35de86 (17 Oct). Look: run CDIMPORTXCIVIL, press Esc at the question, and check nothing was written.

## Partial or still open (NOT-YET, with reason)

1. **BUG-665 (ROTATE Copy and SCALE Copy of a pit leave a twin):** NOT-YET. Fix 6f7736c5 (28 Oct) is an ancestor. It adds the switch `linking.rotateScaleCopyLikeCopy`, shipped ON, and a test file of 34 tests. Tim confirmed ROTATE Copy on 3.0.85 on 29 Oct, which is before this commit, so that confirmation is on the older code. SCALE Copy was never hand-tested. The runner on 3.0.75 saw SCALE Copy fail with the old tick OFF. It needs a robot run on the current build for both routes. The Status line is "TIM-CONFIRMED 29 Oct ... OPEN", so the ledger has not accepted it.
2. **BUG-672 (copy of a pit with one annotation layer locked):** NOT-YET. Fix 6f7736c5 (PR #1831) makes the line name only what is missing, switch `linking.pitCopyLineNamesOnlyWhatIsMissing` ON. The 25 Oct runner finding (CE said "no label or cover text" when only cover text was missing) is what this answers. No robot run since. The Status line still says OPEN, not tested.
3. **BUG-582 (New Pipe preview and message show Unknown after the level is calculated):** NOT-YET. Commit ea85e9ee (17 Oct) is an ancestor, but the entry's last Status line is a tidy of 29 Oct saying it "is recorded as OPEN and not fixed". The entry's own tests on 15 Oct were on 3.0.49 and predate the fix. Nobody has re-run it on a build with the fix. The audit's note that "Status was never updated" fits what I see.

## Skipped, and why

1. **Test results:** I ran no test. "Test file exists" does not mean it passes. For 6f7736c5 I read the commit message, which says Civil net10 full suite 20721 passed, 0 failed. That is the author's report, not mine.
2. **Fix content for most commits:** I read commit titles and dates, and for 6f7736c5 the full message. I did not open the code of the other 12 fixes, so I cannot say each one fully answers its entry. The audit auditors made that call.
3. **Later commits:** I did not check whether a commit after 61fd6fbc changed these fixes. The b1 and b2 lines both contain 61fd6fbc.
4. **PR numbers:** for BUG-684 and BUG-711 I used the commit titles; the PR numbers in the audit (#1321, #1342) did not appear in a log search on rel-20261102a, so I name the fix commits instead.
5. **Robot logs and PENDING_TESTS:** I did not open them, only the carpark Status and Evidence lines. A robot PASS recorded elsewhere would not be seen here.
6. **Structural line (rel-20261026s):** not read. All 20 are Civil.
7. **Installed DLL:** I did not read the version string on Tim's PC. 61fd6fbc = 3.0.89 comes from the job brief.
8. **Not covered in this batch:** the other ALREADY-FIXED entries in the audit (BUG-570, 572, 582 tail, 414, 394, 418 and so on). They are next for batch 3.
