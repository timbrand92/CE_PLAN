# Draft test cases, 22 October 2026

ANSWER FIRST
1. **Scope:** 48 cases: C01-C40 follow design section 5 in order; C41-C48 add eight open acceptance-backlog cases. This is a document draft, not an executed test pack.
2. **Counts:** KIND deterministic 35; KIND needs a window look 13. ROUTE UNPROVEN 37; this overlaps both kinds. Eleven case-specific routes are labelled PROVEN from the records; this is not an executed test count. C08 and C36 are record-only pending a ruling and cannot earn behavioural PASS.
3. **Evidence:** written from existing briefs, robot reports and fixture files. No AutoCAD, build, test, settings change or runner execution was performed for this document. No bug is accepted or closed here.
4. **Main gaps:** new downpipe fixture and component handles; named pit-label/title-block targets; window-control selectors; a genuine failed-command trigger; the complete CEMEMBER section chain. An unexecuted brief is a proposed route, not proof that it works.

RECIPE CONVENTIONS
1. These plain-text blocks are neutral recipes. Fields beginning CASE, TITLE, PLAN ITEM, BUILD, FIXTURE, SETTINGS NEEDED, ROUTE, STEPS, ASSERTIONS, KIND, FAIL MEANS and WHY A UNIT TEST CANNOT CATCH THIS are literal field labels. Each numbered step expands in order. Nothing asks an AI to decide what to do at run time.
2. TYPE "..." sends the full command chain plus final Enter. The literal token <LF> means an Enter inside that chain; adjacent <LF><LF> means an empty answer. It is not PowerShell code. PICK-FIRST means the existing guarded v2 handle lookup and preselection. READ ENTITY means HandleToObject/COM reads, including block attributes; READ SELECTION means the implied selection handles through COM. Do not send new raw LISP: run 47 wedged on one. The old briefs' LISP reads are translated to read operations; that translation is not claimed proven.
3. Every case begins on a fresh byte-identical writable copy in C:\Lisp Files\_TEST_COPIES_20260923\pack_runs\<run>\copies\CASEID.dwg. FIXTURE names below resolve to the existing files listed here. Never alter a fixture master or reuse a drawing changed by an earlier case. Missing fixture or failed unique lookup = BLOCKED before editing.
4. CD = %APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json; OLDCS = %APPDATA%\TIM_CE_CADTOOLS\CS_Settings.json; CVL = %APPDATA%\CE_CVL_SUITE\settings.json; STR = %APPDATA%\CE_STRUC_SUITE\CS_Settings.json. These are four distinct files. Every case inherits hash checks on all four. Settings keys named under a case apply in the named file only, through the settings guard before AutoCAD starts; read each value back from that same file. Never assume a similarly named key in CVL controls CD. Restore exact original bytes even on failure and compare full SHA-256 after AutoCAD ends. A default needed by a case must be read/confirmed; an absent key uses only the documented build default stated below.
5. START: no other AutoCAD/core-console writer, lock free, guard clear; capture four settings hashes and fixture hash; acquire the existing driver lock; apply only the case settings; launch the copy; answer the Civil untagged question Y, or choose Structural for a Structural fixture. Capture log lengths BEFORE launch. Ready check proposed by spec: TYPE "_.ID<LF>221022.1,0" and require new history X = 221022.1. It is not a historical run-44-to-47 proof. Read actual DLL product versions; a different build is BLOCKED for this baseline, never silently judged against another build.
6. BASELINE: after launch and idle, capture four session hashes, command-history byte offset and byte length of every current CE log, plus the exact log filenames. Civil logs: %APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log and ce_cvl_structured_<date>.log. Structural: %APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log and %APPDATA%\TIM_CE_CADTOOLS\logs\ce_struc_structured_<date>.log. Include Manager logs found by the session's log inventory; no Manager filename is supplied by these reports. Absent-before/new file starts at byte 0; truncation/rotation must be reported, never treated as an empty successful tail. LOG NEW always reads added bytes from the matching offset. Each sub-command in an outcome case gets a new offset. Do not sum the same outcome duplicated in plain and structured logs.
7. END: Cancel/Close named windows, close the copy without saving, quit through the existing driver, retry once after 60 s and use only its launched-process quit -Kill after another 60 s if required; restore settings, release lock, verify no launched acad.exe remains and hashes equal pack start. A start-up rewrite, such as STR in run 46, is separately recorded with before/after hashes and time; it is never quietly allowed as unchanged. Any remaining mismatch stops the pack. Do not add cleanup/delete scripts in these cases. C01 explicitly exercises this entire lifecycle; other cases inherit it.
8. Every case inherits assertions: fixture-master hash unchanged; four settings hashes unchanged after END; no new [ERR] in the case's CE-log interval, unless an explicitly identified forced-error case specifies otherwise. Read hashes before guard restore as well in C14. A profile/system variable changed for a case is read before, restored in finally, and read back. Drawing variables affect the copy only. Numeric comparisons are exact unless a tolerance is written.
9. Pointer preconditions: Model space, world plan view, no twist/perspective, PICKFIRST=1; double-click cases also DBLCLKEDIT=1. Read/record SHORTCUTMENU, SELECTIONPREVIEW and ROLLOVERTIPS. Restore any profile variables changed. Resolve target by handle and geometry, then map its named world point to the current drawing viewport, checking foreground and obstruction. Never select by picture position. Do not type Esc between PICK-FIRST and its consuming command. Before every pointer action require no human input in the preceding 120 s. Missing pointer calibration or named component geometry = BLOCKED. C02 is the prerequisite calibration; its own proof is outstanding.
10. All new window actions mean read window controls as text, choose a unique named control, and wait for its state change (10 s, or 120 s where stated). Duplicate/missing names are BLOCKED, never a guessed click. Look cases additionally capture the actual window or named drawing view, checking blank/duplicate image hashes; visual judgement occurs afterwards. Text assertions alone do not accept appearance. Ordinary case deadline 90 s; C13 180 s; C22/C26/C27/C31-C34/C37/C40 600 s. Lifecycle is outside the case deadline.
11. ROUTE PROVEN means the recorded command/action chain worked in a cited robot report; assertions added here still await execution. ROUTE UNPROVEN blocks automatic conversion until its named gaps are filled. The known parts remain useful recipes. PASS needs every applicable assertion, FAIL records actual versus expected and is retried once on a fresh copy; FAIL then PASS is FLAKY, not accepted. A refused action is BLOCKED, not a CE failure. EXPECT-FAIL remains a real failing check. Record-only cases record observations and common safety assertions but never decide the pending behaviour.
12. Draft-specific authority: Tim's 22 October brief authorises writing, committing and pushing only this document in C:\CE_PLAN on its current main branch; fetch then merge origin/main, no rebase. The appended code-worktree/build/PR instructions are explicitly excluded. This document records findings and gaps without changing any other plan/status file.

EXISTING FIXTURES AND SOURCE ALIASES
1. DRV1_B1 = C:\ce_rc_drv\DRV1_B1.dwg; 1,080,181 bytes; SHA-256 34BBE37C2EA43857BED81D141AE277DA57564455944358FABD4D91A3BD7BEC53. Pit P3 handle 109D56; pipe P3 handle 10A98D, validated by the cited routes before use.
2. DRV2_S1 = C:\ce_rc_drv\DRV2_S1.dwg; 85,871 bytes; SHA-256 950AFDF6E5232A5AFF5776592EDB0D07030F45201015B9B803E7D1BDC5B22C87.
3. DRV15_METRE = C:\ce_rc_drv\DRV15_METRE.dwg; 283,981 bytes; SHA-256 5C16AFFD66C7BBF24ACD7DF7194B9F888D906F610911081436FB26A14E2F0E41. Its name/existence does not prove that its geometry and INSUNITS disagree.
4. V8_METRE = C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\V8_20261022_1506\copies\LKV8_XSRC_M.dwg; 21,123 bytes; SHA-256 5435CD8B3AC850BE258F9B02FBAED07C9B3E448A7032164AE5574099E170FADF. V8_UNITLESS = same folder\LKV8_XSRC_Z.dwg; 32,956 bytes; SHA-256 24C92A0B7EB515D936C0E99665CFDD9AACE08269556E1FDC5ED95D9E3421A763. Both exist; INSUNITS/geometry must still be read when opened. They are the forced-source copies named by V8, not silently substituted for DRV15_METRE.
5. V10_BLANK = C:\Lisp Files\_TEST_COPIES_20260923\LOOKS\V10_20261022_2056\copies\LKV10_K1.dwg; 10,056 bytes, exists. This is the downpipe-only starting copy in V10; it is not a proved PKFIX_DP1. PKFIX_DP1 and PKFIX_TB are future fixture names in the spec, not existing masters found in the inspected inventory. Do not create them in this desk task.
6. V9B_SECTIONMARKS = C:\Lisp Files\_TEST_COPIES_20260923\V3UX_20261014\structural-annotations\CODEX_SECTIONMARKS_20261015.dwg; exists. V9b uses this instead of DRV2_S1; do not silently apply its fixture-specific coordinates to DRV2_S1.
7. SPEC = C:\CE_PLAN\areas\TESTING_REBUILD_SPEC_2026-10-22.md, sections 1, 2 and 5. RESEARCH = same folder\TESTING_RESEARCH_CODEX_2026-10-22.md. BACKLOG = same folder\CODEX_ACCEPTANCE_BACKLOG_22OCT.md (exists now; SPEC's earlier statement that it did not exist is historical).
8. R44/R45/R46/R47 = C:\CE_PLAN\areas\release-v3-colleagues-CLAUDE_DRIVER_RUN44_V2_2026-10-21.md, RUN45_V2_2026-10-21.md, RUN46_V2_2026-10-22.md, RUN47_V2_2026-10-22.md, with the same release-v3-colleagues-CLAUDE_DRIVER_ prefix. B.x refers to each report's B section.
9. V8/V10/V9b = C:\Lisp Files\_CODEX_RUNNER\verifyV8_c59_full.txt, verifyV10_c60_full.txt, verifyV9b_s41_full.txt. W2/W5/W6 = verifyW2_c60_full.txt, verifyW5_c60_full.txt, verifyW6_c60_full.txt in the same folder. These are instructions; quoted previous observations are identified as such. No brief alone proves its whole proposed route.

---

CASE C01
TITLE Start AutoCAD and leave it properly closed
PLAN ITEM SPEC 5.1 C01; repeated first-quit delay in R44-R46
BUILD Civil 3.0.70 / Structural 1.0.121; Manager 1.1.70 alongside
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE key changed; all four files read and hashed.
ROUTE UNPROVEN: launch, quit and restore worked in R47 A; spec's ready echo and bounded session-run cleanup have not been proved in those reports.
STEPS
1. Perform START, recording pre-launch process, lock, guard and hashes.
2. TYPE "_.ID<LF>221022.1,0"; read new command history for the echo; wait idle.
3. Close only the run copy without saving through closeonly.
4. Perform END, recording every quit attempt, whether kill was needed, settings restoration and released lock.
ASSERTIONS
1. Ready history contains X = 221022.1, with numeric tolerance 0.0001 drawing units.
2. No launched acad.exe or accoreconsole.exe remains; guard clear and lock free.
3. Four settings hashes and fixture hash equal their pre-launch values.
4. Pre-launch-to-END CE-log tails have zero [ERR] lines. A forced kill is reported as a lifecycle recovery, never called a graceful close.
KIND deterministic
FAIL MEANS AutoCAD, its lock or changed settings were left behind, or start-up raised an error.
WHY A UNIT TEST CANNOT CATCH THIS The installed plugin, real AutoCAD process and on-disk guard must all start and finish together.

---

CASE C02
TITLE A drawing click lands on the object at every zoom
PLAN ITEM SPEC 5.1 C02; pointer calibration prerequisite
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE key changed; PICKFIRST=1 with original profile value restored; Model/world plan view required.
ROUTE UNPROVEN: R44-R47 never exercised the new world-to-screen pointer verbs. Exact pan vector and visible empty-ground view are specified here as draft inputs, not a proven route.
STEPS
1. Read circle handles; TYPE "_.CIRCLE<LF>1000,1000<LF>200"; resolve the one new circle by handle, centre 1000,1000 and radius 200.
2. For each view height 1000, 5000, 20000: TYPE "_.ZOOM<LF>_C<LF>1000,1000<LF><height>"; click world point 1200,1000 on the circumference; read implied selection, requested pixel and actual cursor pixel before pointer restoration; clear selection.
3. At each height, TYPE "_.ZOOM<LF>_C<LF>5000,5000<LF><height>"; click world point 5000,5000; read implied selection; clear selection. Verify this point contains no fixture entity first; otherwise BLOCKED, never choose another point from a picture.
4. TYPE "_.ZOOM<LF>_C<LF>1000,1000<LF>20000"; TYPE "_.-PAN<LF>1000,1000<LF>1500,1000"; repeat the circle click/read and the empty-point click/read while both are visible.
ASSERTIONS
1. Each circle click selects exactly the new circle handle; each empty-point click selects nothing.
2. Maximum absolute difference in either pixel axis between computed target and actual cursor position is <=2 pixels for every event.
3. Every target is inside an unobstructed drawing viewport; out-of-view is BLOCKED, not a successful empty click.
KIND deterministic
FAIL MEANS The runner's mouse could select the wrong pit or miss a symbol after a zoom or pan.
WHY A UNIT TEST CANNOT CATCH THIS Pixel mapping depends on the actual AutoCAD viewport, Windows scaling and foreground window.

---

CASE C03
TITLE Starting the plugin adds no error lines
PLAN ITEM SPEC 5.1 C03; R44 B.3 start-up regression
BUILD Civil 3.0.70 / Structural 1.0.121; Manager 1.1.70 alongside
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE key changed; all four files read and hashed.
ROUTE PROVEN: launch and start-up log reading in R44 B.3 and R47 A.9; byte-offset reading specified by V8 rule j replaces historical timestamp filters.
STEPS
1. Capture filenames and byte lengths for all CE logs immediately before launch.
2. Launch the copy, finish start-up and wait idle without running a further user CE command.
3. Read only bytes added since those offsets; list all warning lines separately from errors.
ASSERTIONS
1. Every observed CE start-up log has zero [ERR] lines.
2. The known pit-block untrusted-location warning, if present, is recorded as a warning and does not become an error or get hidden.
3. New/rotated log handling follows recipe convention 6; inability to read an expected log is BLOCKED.
KIND deterministic
FAIL MEANS Loading CE itself has raised an error before the drafter starts work.
WHY A UNIT TEST CANNOT CATCH THIS The fault can depend on installed bundles, drawing contents and real start-up order.

---

CASE C04
TITLE Double-clicking a downpipe circle opens its tag window
PLAN ITEM SPEC 5.2 C04; BUG-859, #1499/#1520
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_DP1; existing starting copy V10_BLANK, with DRV1_B1 retained as the spec's proposed F01 source
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true (absent loads ON per V10); CD doubleClick.opensEditWindow=false (absent loads OFF); PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: PKFIX_DP1 does not yet exist in the inspected inventory. V10-01a proposes DP at 150000,-80000 but R47 B.5 did not run it. Need a saved/hash-pinned fixture, unique downpipe handle, TAG/value mapping and outer-circle geometry; the block name CE_DP in SPEC's example is not proved.
STEPS
1. Once supplied, open a fresh PKFIX_DP1 copy and read the unique downpipe block/attribute handles; require tag DP1. Stop BLOCKED while the fixture/lookup is missing.
2. Resolve a point on that block's outer circle from geometry; double-click it once.
3. Read controls as text in "Creative Engineering | Edit source"; read "Tag (one word, for example DP2)" and capture the window.
4. Press its Cancel; wait for window gone and idle.
ASSERTIONS
1. The opened window is CE Edit source, not Enhanced Attribute Editor.
2. The Tag control value is DP1, not empty; Cancel and OK controls exist.
3. A usable window capture is available for a look at clipping, spacing and readability.
KIND needs a window look
FAIL MEANS A downpipe opens the wrong editor or loses its tag when opened.
WHY A UNIT TEST CANNOT CATCH THIS AutoCAD's double-click redirection and the installed window must work on a real block.

---

CASE C05
TITLE Cancelling the downpipe tag window changes nothing
PLAN ITEM SPEC 5.2 C05; BUG-859, #1499/#1520 Cancel path
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_DP1; existing precursor V10_BLANK
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true; CD doubleClick.opensEditWindow=false; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: same missing fixture/component handles as C04; expected Cancel wording is supplied by V10-01b, not by an executed R47 downpipe test.
STEPS
1. Resolve the supplied DP1 fixture and outer-circle target as C04; read its TAG and drawing DBMOD; capture history offset.
2. Double-click the outer circle; require CE Edit source and Tag=DP1.
3. Press Cancel; wait for window gone; read TAG and DBMOD again and new history.
ASSERTIONS
1. New history contains "[CE] Nothing was changed.".
2. TAG remains DP1, DBMOD equals its value immediately before the double-click, and the window is gone.
KIND deterministic
FAIL MEANS Merely inspecting and cancelling a downpipe writes a change or leaves its window open.
WHY A UNIT TEST CANNOT CATCH THIS Cancel must leave AutoCAD's actual drawing and command state alone after a native double-click.

---

CASE C06
TITLE A downpipe tag change can be undone and redone
PLAN ITEM SPEC 5.2 C06; BUG-859, #1499/#1520 tag edit
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_DP1; existing precursor V10_BLANK
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true; CD doubleClick.opensEditWindow=false; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: C04 fixture and tag/label handles missing. V10-01b proposes DP2 and U, but does not prove REDO; need actual label linkage, unique Tag control and no existing DP2.
STEPS
1. Open fresh DP1 fixture; read all tag values and require DP2 unused; capture original DP1 attribute and linked label text handles.
2. Double-click outer circle; set "Tag (one word, for example DP2)" to DP2 by its control value; press OK; wait idle.
3. Read block tag and linked label; TYPE "U"; read both again.
4. Wait 12 s with no intervening command; TYPE "REDO"; read both again and new history.
ASSERTIONS
1. After OK, tag and linked label read DP2; after U they read DP1; after REDO they read DP2.
2. REDO history contains "Everything has been redone" and not "Nothing to redo".
KIND deterministic
FAIL MEANS The label and saved tag disagree, or one Undo/Redo cannot restore the edit.
WHY A UNIT TEST CANNOT CATCH THIS The block attribute, drawn label and AutoCAD undo record are updated together in the installed editor.

---

CASE C07
TITLE The centre mark and angled downpipe text open the same editor
PLAN ITEM SPEC 5.2 C07; BUG-859, #1520 component targeting
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_DP1; existing precursor V10_BLANK
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true; CD doubleClick.opensEditWindow=false; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: no named subentity handles/local geometry for the red centre and angled DP text. V10-01b supplies expected CE Edit source for both; a picture coordinate is not an acceptable replacement.
STEPS
1. Resolve DP1 block and its centre-mark and angled-text subentities by handle/geometry.
2. Double-click the centre-mark geometry; read window title and Tag; press Cancel; require window gone.
3. Double-click the angled DP-text geometry; read window title and Tag; press Cancel; require window gone.
ASSERTIONS
1. Each target opens "Creative Engineering | Edit source" with Tag=DP1.
2. Neither target opens Enhanced Attribute Editor; each Cancel leaves tag DP1.
KIND deterministic
FAIL MEANS Different parts of one downpipe send the drafter to different or empty editors.
WHY A UNIT TEST CANNOT CATCH THIS Native double-click hit targets differ between the nested block geometry and its text.

---

CASE C08
TITLE Record what opens from the green downpipe label
PLAN ITEM SPEC 5.2 C08; BUG-860; Monday question 3
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_DP1; existing precursor V10_BLANK
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: DP1 fixture and linked green-text handle missing. V10-01d records earlier TEXTEDIT behaviour but provides a picture target, not a deterministic handle target.
STEPS
1. Resolve green label text linked to the supplied DP1 block; read original TextString and DBMOD.
2. Double-click the named text at its geometric insertion/bounds target; record active command, editor title and controls as text; capture editor/drawing.
3. Cancel the actual editor through its proved close route, or stop BLOCKED if none is available; reread label and DBMOD.
ASSERTIONS
1. Record the exact editor/command and words. TEXTEDIT is the previous observation, not a required accepted behaviour.
2. Cancel leaves label text and DBMOD equal to baseline; capture is usable.
3. Behaviour verdict is RECORD ONLY pending Tim's ruling, never PASS because TEXTEDIT appeared.
KIND needs a window look
FAIL MEANS A safety assertion failed during recording; the preferred green-label editor remains undecided.
WHY A UNIT TEST CANNOT CATCH THIS Only a real text double-click shows which native editor AutoCAD actually chooses.

---

CASE C09
TITLE A pit label keeps AutoCAD's editor when the CE switch is off
PLAN ITEM SPEC 5.2 C09; pit-label switch OFF
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, pit P3 body 109D56; label handle not yet supplied
SETTINGS NEEDED CD doubleClick.opensEditWindow=false (absent loads OFF); CD doubleClick.sourceEditWindow=true; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: V10-01d identifies the body but asks a person to find its label. Need the actual label/attribute handle, linkage to 109D56 and geometric click target; 109D56 must not be used as if it were the label.
STEPS
1. Read 109D56 ObjectName/Layer and pit name; require BlockReference/STORMWATER PIT/P3; resolve its linked label block and attribute handle.
2. Double-click that label attribute; read Enhanced Attribute Editor title and Block/Tag/value controls.
3. Press Cancel; read tag and window list.
ASSERTIONS
1. Enhanced Attribute Editor opens on the resolved pit-label block, not DOWNPIPE.
2. No CE Edit Pit/Edit source window opens; pit label is unchanged after Cancel.
KIND deterministic
FAIL MEANS Switching CE label editing off still redirects a pit label or opens the editor on the wrong block.
WHY A UNIT TEST CANNOT CATCH THIS The native attribute editor must receive the right real drawing block through the double-click event.

---

CASE C10
TITLE The switched-on pit label opens Edit Pit for the right pit
PLAN ITEM SPEC 5.2 C10; pit-label switch ON; Monday question 2
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, P3 body 109D56; same missing label handle as C09
SETTINGS NEEDED CD doubleClick.opensEditWindow=true, set before launch and read back; CD doubleClick.sourceEditWindow=true; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: key path is supplied by V10 pass B, resolving SPEC's unknown key; real label target and named pit-name/Cancel controls still unproved by R44-R47.
STEPS
1. Verify pit body P3 and resolve its linked label attribute by handle; read baseline DBMOD.
2. Double-click the named label; read "Creative Engineering | Edit Pit" controls, including pit name; capture the whole window.
3. Press "Cancel without saving" if that unique control exists; otherwise BLOCKED and record actual controls, never guess Cancel.
4. Read DBMOD and window list after closing.
ASSERTIONS
1. CE Edit Pit opens and its pit-name value equals P3; Enhanced Attribute Editor does not open.
2. Cancel leaves DBMOD unchanged and no edit window open.
3. Whole window is captured for fit/readability review; this case does not authorise changing the default switch.
KIND needs a window look
FAIL MEANS A label opens the wrong pit, or cancelling leaves a drawing change.
WHY A UNIT TEST CANNOT CATCH THIS The event must resolve a separate pit-label block back to its pit in the live drawing.

---

CASE C11
TITLE CE leaves a title block's attributes to AutoCAD
PLAN ITEM SPEC 5.2 C11; #1520 non-CE attribute regression
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Intended PKFIX_TB; existing candidate DRV1_B1
SETTINGS NEEDED CD doubleClick.sourceEditWindow=true; CD doubleClick.opensEditWindow=true to exercise the widest redirection; PICKFIRST=1, DBLCLKEDIT=1, restored.
ROUTE UNPROVEN: V10-01d explicitly allows no suitable attributed block. No confirmed title-block fixture/handle/layout or control selector exists in R44-R47. Supply a synthetic title-block fixture rather than choosing a client title block.
STEPS
1. Require a pinned PKFIX_TB copy and named non-CE title-block attribute handle, block name and layout; read its original value.
2. Select its recorded layout/view, resolve geometry and double-click the named attribute.
3. Read Enhanced Attribute Editor Block/Tag/value; press Cancel; read original attribute again.
ASSERTIONS
1. AutoCAD's Enhanced Attribute Editor opens on that exact title-block name; no CE Edit source/Edit Pit window opens.
2. Attribute value is unchanged after Cancel.
KIND deterministic
FAIL MEANS CE intercepts an ordinary title-block edit or AutoCAD opens it on a different block.
WHY A UNIT TEST CANNOT CATCH THIS Double-click interception must distinguish unrelated attributed blocks in a real layout.

---

CASE C12
TITLE About CE Suite shows the loaded versions and closes
PLAN ITEM SPEC 5.3 C12; BUG-852, V5-02 clipping
BUILD Civil 3.0.70 / Structural 1.0.121; Manager 1.1.70 alongside
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE key changed; read actual installed/loaded version evidence before comparison.
ROUTE UNPROVEN: CE_VERSION opens About in R44 B.1 and R46 B.12, but v2 refused its contents/close. Need proved UI text access and unique Close selector. Five-row grouping is SPEC's requirement; W6 also mentions Runtime/help, so do not drop extra text to force a count.
STEPS
1. Read product-version strings for Civil, Structural and Manager DLLs and record AutoCAD/runtime version evidence.
2. TYPE "CE_VERSION"; read "About CE Suite" controls as text; capture full window.
3. Read each version row, AutoCAD/runtime text and hover-help text; press its named Close; wait idle.
ASSERTIONS
1. Five version rows required by SPEC are present, including the three suites, AutoCAD and runtime; any additional help text is retained in evidence.
2. Suite rows match DLL baseline versions; no row contains "CONFLICT" or "Not loaded" when that suite is loaded.
3. Window is gone and AutoCAD idle; look checks all text visible and readable, including lower rows.
KIND needs a window look
FAIL MEANS About shows the wrong loaded build, reports duplicate/missing suites, clips a row or cannot close normally.
WHY A UNIT TEST CANNOT CATCH THIS The window reads real installed/loaded modules and is displayed within the actual desktop scale.

---

CASE C13
TITLE All six Settings pages fit and show saved values
PLAN ITEM SPEC 5.3 C13; V8-03 Advanced fit
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE value changed; settings-temp arm before CDS, per SPEC gate; four original hashes retained.
ROUTE UNPROVEN: V8-03 proposes Advanced read/Cancel only; no six-tab control dump/count and no successful Settings arm/read/close in R44-R47. Need named tab selectors and actual window title verified.
STEPS
1. Record current screen size/scaling; arm the Settings read gate; TYPE "CDS"; read its exact window title and controls.
2. Select tabs in order: Drafting; Pipes and Pits; Design; Survey; Display; Advanced. For each, read visible page controls as text and capture the full window once; count controls in that page, excluding hidden pages and shared shell.
3. Read saved-status text; press Cancel; read all four file hashes before END.
ASSERTIONS
1. Six named tabs exist and each page has more than 30 controls, per SPEC; actual count is retained if the contract proves wrong.
2. Status reads "No changes. Everything shown is saved.".
3. Six distinct usable page captures show no clipped/overlapping content or layout scrolling; four file hashes remain unchanged.
4. Record this PC's scale; do not claim the separate 1920 x 1080 at 150 percent case was tested.
KIND needs a window look
FAIL MEANS A Settings page is missing, unreadable, unexpectedly dirty or silently writes on Cancel.
WHY A UNIT TEST CANNOT CATCH THIS The installed six-page window and the settings files it really reads must agree at desktop scale.

---

CASE C14
TITLE Cancel throws away an unsaved Settings change
PLAN ITEM SPEC 5.3 C14
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No persisted CE value changed; transient UI field "Minimum fall on a pipe, millimetres" set from baseline B to B+1 mm. File-key binding not recorded; hash all four files.
ROUTE UNPROVEN: no proved editable control selector or field-to-file key binding in supplied routes. SPEC explicitly proposes this edit; V8 authorised read-only viewing and is not proof of the Cancel-discard path.
STEPS
1. Read four hashes H0; arm Settings gate; TYPE "CDS"; read the named field's numeric baseline B and its file binding once supplied.
2. Set that control's value to B+1 without sending Enter or clicking Save/Apply.
3. Press Cancel; wait window gone; immediately read hashes H1 BEFORE settings-restore.
4. Reopen CDS, read the field, Cancel again; only then perform END and read H2.
ASSERTIONS
1. H1 equals H0 for all four files; guard restoration must not hide a Cancel write.
2. Reopened field reads B, not B+1; H2 equals H0.
KIND deterministic
FAIL MEANS Cancel saved the trial fall value or a later restore merely hid that write.
WHY A UNIT TEST CANNOT CATCH THIS The real window's Cancel path and the actual files must be observed before the safety restore.

---

CASE C15
TITLE The Checks window shows the same totals as the command line
PLAN ITEM SPEC 5.3 C15; BACKLOG W3 counts and plain names
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD checks.checksCommandEnabled=true; CD layerChecks.wrongLayerRows=true; before launch, read back both.
ROUTE UNPROVEN: CDCHECKS launch/summary proven R45 B.4; its UI tree exposed only header/buttons, not findings. Need a complete enumerable row/control list or a proved text-read route through every bounded list page.
STEPS
1. TYPE "CDCHECKS"; read new summary counts A to look at, B OK, C not known.
2. Read "Creative Engineering | Checks (CDCHECKS)" controls and all finding rows as text; require explicit complete-list/end evidence rather than first 20 command lines.
3. Capture the full palette; press Close; wait palette gone.
ASSERTIONS
1. Window category totals equal A, B, C; total row count equals A+B+C, counting headers separately and allowing only explicitly enumerated category rows.
2. No visible finding name exposes a raw object handle as the object's name; expected plain names such as P3 or unnamed pipe are used.
3. Look confirms readable rows, buttons and summary; do not assert the historic 42/234/342 numbers as fixed expected values.
KIND needs a window look
FAIL MEANS The visible list disagrees with its summary or gives a drafter unexplained handle names.
WHY A UNIT TEST CANNOT CATCH THIS Real drawing findings must populate the installed palette and its displayed category totals.

---

CASE C16
TITLE Ignoring a finding stays off unless enabled
PLAN ITEM SPEC 5.4 C16; #1517 OFF path
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD checks.allowIgnoreFinding=false; absent loads OFF as verified in R47. Other keys unchanged.
ROUTE PROVEN: R47 B.6 and answer item 2; OFF sentence and outcome captured on 3.0.70.
STEPS
1. Read DBMOD, selection handles and Civil log/history offsets.
2. TYPE "CDCHECKIGNORE"; wait idle; read new history, Civil plain-log tail, DBMOD and selection again.
ASSERTIONS
1. New history contains "[CE] Ignoring a finding is switched off in CE Settings. Nothing was changed." and no finding-number question/window.
2. New plain-log tail has exactly one "Command outcome: CDCHECKIGNORE completed <integer> ms" line.
3. DBMOD and selection equal baseline; no Command outcome text appears on the command line.
KIND deterministic
FAIL MEANS The switched-off command asks to ignore something, changes the drawing or misses its outcome line.
WHY A UNIT TEST CANNOT CATCH THIS CE must load the real setting and execute its installed command without opening a prompt.

---

CASE C17
TITLE One Undo immediately brings an ignored finding back
PLAN ITEM SPEC 5.4 C17; #1517 immediate-U control
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1; two separate fresh copies A and B under the same ignore-on session
SETTINGS NEEDED CD checks.allowIgnoreFinding=true before launch; no Checks palette required.
ROUTE PROVEN: R47 B.6.1, B.6.3, B.6.5 and B.6.7 give the complete chains. Correction to SPEC wording: a list read cannot sit between Ignore and the immediate-U control; R47 demonstrates why.
STEPS
1. On copy A TYPE "CDCHECKIGNORE<LF>"; read the numbered list and "and N more" line; esc-prompt at the finding-number question. Record first subject S and total T = numbered rows + N (or numbered rows if no tail).
2. TYPE "CDCHECKIGNORE<LF><LF>1<LF>1<LF>"; require completed Ignore, with empty note. TYPE "CDCHECKIGNORE<LF>"; read list/count; esc-prompt. Record Tminus and first-subject absence.
3. Close A without saving and open fresh copy B. Repeat only step 1 to capture its baseline S/T.
4. TYPE "CDCHECKIGNORE<LF><LF>1<LF>1<LF>"; once idle TYPE "U" immediately, with no intervening list, getvar, selection or other AutoCAD command.
5. TYPE "CDCHECKIGNORE<LF>"; read list/count; esc-prompt.
ASSERTIONS
1. Copy A's Ignore names S; its next list lacks S and Tminus=T-1. R47 observed WT4 and 384->383; compare the actual baseline, not those hard-coded totals.
2. Copy B's U echoes CDCHECKIGNORE and its subsequent list contains S at the original total T.
3. Complete Ignore writes one completed outcome line; list-only Escape is recorded separately as cancelled.
KIND deterministic
FAIL MEANS Ignoring fails to hide exactly one finding, or an immediate Undo fails to bring it back.
WHY A UNIT TEST CANNOT CATCH THIS The drawing's ignore record and AutoCAD's real undo stack must change together.

---

CASE C18
TITLE Undo still brings a finding back after looking at the list
PLAN ITEM SPEC 5.4 C18; R47 finding C.2; fix planned after C-60
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD checks.allowIgnoreFinding=true before launch.
ROUTE PROVEN: R47 B.6.3-B.6.6, including the list read between each U. EXPECT-FAIL on this baseline; a later passing build needs its own version-labelled run.
STEPS
1. TYPE "CDCHECKIGNORE<LF>"; record first subject S and total T; esc-prompt.
2. TYPE "CDCHECKIGNORE<LF><LF>1<LF>1<LF>"; require Ignore S.
3. TYPE "CDCHECKIGNORE<LF>"; read shorter list; esc-prompt.
4. TYPE "U"; TYPE "CDCHECKIGNORE<LF>"; read list/count; esc-prompt.
5. TYPE "U" a second time; TYPE "CDCHECKIGNORE<LF>"; read list/count; esc-prompt.
ASSERTIONS
1. Immediately after Ignore, S is absent and count=T-1.
2. At latest after the second U, S is present and count=T. Record each U echo and both intermediate lists.
3. EXPECT-FAIL: R47 saw S still absent and T-1 after both Us. Do not turn that observation into the desired assertion.
KIND deterministic
FAIL MEANS Looking at the list consumes undo steps and leaves the ignored finding hidden after Undo.
WHY A UNIT TEST CANNOT CATCH THIS Only the real command sequence reveals read-only commands interfering with AutoCAD's undo history.

---

CASE C19
TITLE Un-ignore puts the finding on the list again
PLAN ITEM SPEC 5.4 C19; #1517 Unignore
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD checks.allowIgnoreFinding=true before launch.
ROUTE PROVEN for command chain: R47 B.6.8; post-Unignore list equality was expressly not checked there and is a new assertion in this recipe.
STEPS
1. TYPE "CDCHECKIGNORE<LF>"; record first subject S and total T; esc-prompt.
2. TYPE "CDCHECKIGNORE<LF><LF>1<LF>1<LF>"; require Ignore S completed.
3. TYPE "CDCHECKIGNORE<LF>Unignore<LF>1" in one chain; require idle.
4. TYPE "CDCHECKIGNORE<LF>"; read list/count; esc-prompt.
ASSERTIONS
1. New history contains "[CE] Brought back: <S>. It shows on the Checks list again. Type U to undo. Nothing else was changed." with actual S substituted literally.
2. Subsequent list contains S and total equals T; the message alone is insufficient.
KIND deterministic
FAIL MEANS Un-ignore says it brought a finding back but the real list still hides it.
WHY A UNIT TEST CANNOT CATCH THIS The live list must be rebuilt from the drawing's persisted ignore choices after the command.

---

CASE C20
TITLE A pipe on layer zero gets one named wrong-layer finding
PLAN ITEM SPEC 5.5 C20; #1511/#1512
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, pipe P3 handle 10A98D
SETTINGS NEEDED CD checks.checksCommandEnabled=true; CD layerChecks.wrongLayerRows=true, before launch; PICKFIRST=1 restored.
ROUTE UNPROVEN: V8/V10 propose the layer mutation for the PIT, not a proved pipe run; R45 could not see wrong-layer findings. Need proof that CDRULES All uses this switch/path, exact complete chain, emitted full-list filename/header and row identity. The first 20 CDCHECKS rows cannot substitute for the full list.
STEPS
1. Read 10A98D ObjectName, Layer and P3 identity; store original layer L. Stop if it is not the expected pipe.
2. Once supplied, run the complete CDRULES All chain, read the full findings file it names, and record wrong-layer row count W and the P3 row identities. This is SPEC's proposed baseline route, not a new guessed command.
3. PICK-FIRST "10A98D"; TYPE "_.CHPROP<LF>_LA<LF>0<LF>" without intervening Esc. Read pipe Layer.
4. Repeat the proved full-list route and record Wafter and the P3 finding.
5. TYPE "U" exactly once; read Layer; repeat full-list route and record Wend. If U names a list command, retain that failure rather than adding more Us.
ASSERTIONS
1. After mutation pipe Layer="0" and Wafter=W+1, with exactly one new wrong-layer row naming pipe P3, actual layer 0 and expected office layer L.
2. After U Layer=L, P3's new row is absent and Wend=W.
KIND deterministic
FAIL MEANS A wrongly layered pipe goes unreported, is identified by a handle, or the finding stays after its layer is restored.
WHY A UNIT TEST CANNOT CATCH THIS The installed finding collector must inspect the real pipe entity and refresh after a native layer edit/Undo.

---

CASE C21
TITLE A pit on layer zero gets one named wrong-layer finding
PLAN ITEM SPEC 5.5 C21; #1511/#1512
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, pit P3 body 109D56
SETTINGS NEEDED CD checks.checksCommandEnabled=true; CD layerChecks.wrongLayerRows=true, before launch; PICKFIRST=1 restored.
ROUTE UNPROVEN: V10-04 supplies INSERT/STORMWATER PIT handle guard and layer-edit proposal; R45 B.4 never proved the wrong-layer row. Same full-file CDRULES All route/output contract missing as C20.
STEPS
1. Read 109D56 ObjectName and Layer; require BlockReference on STORMWATER PIT; PICK-FIRST it and read Inspector name Pit P3; clear selection.
2. Run the supplied complete CDRULES All route; read full-list wrong-layer baseline W.
3. PICK-FIRST "109D56"; TYPE "_.CHPROP<LF>_LA<LF>0<LF>"; read Layer.
4. Run full-list route again; read P3 pit row and wrong-layer count.
5. TYPE "U" once; read Layer; run full-list route again and read final count.
ASSERTIONS
1. Layer becomes "0"; exactly one new row identifies pit P3, layer 0 and office layer STORMWATER PIT; count=W+1.
2. One U restores STORMWATER PIT and count W, with that row gone.
KIND deterministic
FAIL MEANS A pit on the wrong layer is missed or Undo leaves the warning behind.
WHY A UNIT TEST CANNOT CATCH THIS The test depends on the actual pit block, selected-object identity and drawing-wide findings after CHPROP.

---

CASE C22
TITLE Each of ten Civil commands writes one honest outcome line
PLAN ITEM SPEC 5.6 C22; C-59/C-60 command outcomes
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1; use a fresh copy for each independent sub-command, except the C37 setup needed for Tidy preview
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true; CD checks.checksCommandEnabled=false for old CDCHECKCURRENT path; commandOutcomeLines absent/default ON as R46/R47 observed (parent key path not guessed).
ROUTE UNPROVEN: as a complete ten-command case: R46 B.1/R47 B.3 prove outcomes for executed commands, not every proposed cancel path. Need reviewed window close selectors, CD first-prompt cancel, CDINSPECTOR explicit rerun and CDCHECKCURRENT close/outcome proof. Do not count start-up CDINSPECTOR as a user invocation.
STEPS
1. Before EACH sub-command capture fresh plain/structured Civil log and history offsets; run only that sub-command, wait idle after its named finish, then read its tails.
2. CDINSPECTOR: TYPE "CDINSPECTOR"; expected completed. CDTWL: TYPE "CDTWL<LF>10<LF>18.70"; expected completed.
3. CDTIDYLABELS: use C37's full fixture setup, then TYPE "CDTIDYLABELS<LF>All" and esc-prompt at "Move this label now?"; expected cancelled. Baseline no-move completion is a different route.
4. PIT: TYPE "PIT<LF>150000,-80000" to New Pit, Cancel by its proved control; expected cancelled. CD: start at its first point prompt and esc-prompt; expected cancelled. These cancellation variants require route proof before conversion.
5. CDEDIT: PICK-FIRST 10A98D; TYPE "CDEDIT<LF>Y" with expected Edit Pipe; press "Cancel without saving" once selector is proved; expected cancelled. This is distinct from R47's completed cascade.
6. TYPE "CDRECOVERINVERTS"; expected completed. TYPE "PITSCHEDULE", read window, close by proved Close route; expected completed.
7. TYPE "CDSYNC"; expected completed. TYPE "CDCHECKCURRENT", close its old findings window through proved Close; expected completed.
ASSERTIONS
1. Each invocation has exactly one new outcome in EACH Civil log where outcomes are normally duplicated: "Command outcome: <NAME> <expected state> <nonnegative integer> ms". Do not add counts across the two files.
2. No sub-command's new history contains "Command outcome:"; native setup commands add no CE outcome of their own.
3. No old/start-up outcome is credited to a sub-command; cancelled and completed must match the route stated above.
KIND deterministic
FAIL MEANS The log misses, duplicates or mislabels a command's finish, so later reports cannot tell what actually ran.
WHY A UNIT TEST CANNOT CATCH THIS Command lifecycle hooks must fire once around real prompts/windows and write to the installed log sinks.

---

CASE C23
TITLE A real command failure is logged as failed
PLAN ITEM SPEC 5.6 C23; forced-failure outcome coverage
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1 candidate; exact failure fixture/input not known
SETTINGS NEEDED Civil outcome logging default ON; no other key selected until a safe failure trigger is proved.
ROUTE UNPROVEN: BLOCKED, no failure trigger known. R46 B.1.3 shows CDEDIT on a LINE completed and CDTWL with abc cancelled; neither is a failed example. Source-derived safe input and its complete route must be supplied; no corrupt drawing or install is authorised.
STEPS
1. Stop BLOCKED before launching until the failure command, complete input chain, precise expected diagnostic and safe test-copy recovery are supplied.
2. Once supplied, capture log/history offsets, run that one failure chain, wait for the documented finish and read new log lines.
3. Read database/selection values named by that trigger and perform END.
ASSERTIONS
1. Exactly one new outcome in the command's plain log says "Command outcome: <supplied command> failed <integer> ms".
2. The supplied diagnostic is present and completed/cancelled outcomes for that invocation are absent.
3. Only the trigger's explicitly expected error is exempt from the inherited zero-error assertion; all other errors remain failures.
KIND deterministic
FAIL MEANS A proven command exception is reported as success, cancellation or silence; without the trigger the result is BLOCKED.
WHY A UNIT TEST CANNOT CATCH THIS The installed command wrapper must catch a real in-AutoCAD failure and flush its actual outcome log.

---

CASE C24
TITLE A slow drawing check reports progress and a quick one stays quiet
PLAN ITEM SPEC 5.6 C24; #1514
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD checks.showProgressWhenSlow=true; CD checks.checksCommandEnabled=false; other files unchanged. This is deliberately a separate profile from Checks ON.
ROUTE UNPROVEN: R45 answer item 5 says progress applies only to the OLD path; Checks ON folds the command into the new list. Need proved old-panel close selector and timing definition; command outcome time may include window lifetime, so it cannot yet be assumed equal to check duration.
STEPS
1. Confirm both CD keys before launch; capture command/history and Civil log offsets.
2. TYPE "CDCHECKCURRENT"; read all new command lines and old panel controls; record time to "Drawing check complete" separately from window-close/outcome time.
3. Read duration from its outcome line; close the old findings window through proved Close route; retain raw timings and progress text.
ASSERTIONS
1. Completion text contains "Drawing check complete" and "Nothing has been fixed automatically.".
2. Once the timing definition is proved: check duration <500 ms means zero progress lines; >=500 ms means one or two plain progress lines before completion. Exactly 500 ms follows the slow branch.
3. Do not score the timing branch while its measurement is unresolved; mark BLOCKED, not PASS from an outcome duration inflated by an open panel.
KIND deterministic
FAIL MEANS Quick checks make needless noise or a genuinely slow check gives no useful progress; unresolved timing is a route gap.
WHY A UNIT TEST CANNOT CATCH THIS Real drawing-check duration, command-line repainting and the installed old/new route switch interact.

---

CASE C25
TITLE Structural and Manager commands also record their finish
PLAN ITEM SPEC 5.6 C25; R46 outcome-line finding
BUILD Civil 3.0.70 / Structural 1.0.121; Manager 1.1.70 alongside
FIXTURE DRV2_S1 for Structural; separate fresh DRV1_B1 for CE_VERSION
SETTINGS NEEDED No new CE key changed; Structural/Manager outcome logging key/file not documented, so do not invent a switch.
ROUTE UNPROVEN: as a complete case: CSREOBAR route proven R44 B.11/R47 B.4.7; LBUH selection adaptation and About close/Manager log filename missing. EXPECT-FAIL: R46 found no Structural or Manager outcomes; R47 again found none for CSREOBAR.
STEPS
1. On DRV2_S1 take log/history offsets; TYPE "CSREOBAR<LF>N16<LF>3<LF>100<LF>tAndB<LF>0,8000<LF>@5500,0<LF>Yes"; wait idle; read Structural plain/structured and other CE tails.
2. On fresh DRV2_S1 perform the LBUH boundary/select route once supplied under C26; expect completed; read fresh log tails.
3. On fresh DRV1_B1 TYPE "CE_VERSION"; read About; press named Close once proved; wait idle; read Manager and all CE tails.
ASSERTIONS
1. After the intended fix each invocation has exactly one "Command outcome: <NAME> completed <integer> ms" in its suite's authoritative plain log, with structured duplication counted separately.
2. No outcome text is added to command history; missing outcomes remain FAIL/EXPECT-FAIL, never accepted as current desired behaviour.
KIND deterministic
FAIL MEANS Structural or Manager activity is invisible to the outcome-based test reports.
WHY A UNIT TEST CANNOT CATCH THIS Independently loaded suite commands must use their installed logging path inside AutoCAD.

---

CASE C26
TITLE Under-wall dots keep their density at three drawing scales
PLAN ITEM SPEC 5.7 C26; BUG-748, #1498
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV2_S1; V9B_SECTIONMARKS is the separately recorded V9b fixture, not silently substituted
SETTINGS NEEDED STR HatchDensity switch ON/default ON per V9b (full JSON parent path not recorded); read actual binding before setting any override. Drawing DIMSCALE=20/50/100 and LTSCALE=200/500/1000, respectively.
ROUTE UNPROVEN: for neutral conversion: R46 B.10 proved LBUH at scale 50 with LISP boundary variable !r1; V9b-02 supplies three scales. Need a non-LISP complete boundary-selection chain for new runner and exact HatchDensity binding if not default. Never retain the old order-dependent "last hatch" lookup.
STEPS
1. For each S in 20,50,100 use a fresh DRV2_S1 copy. Set drawing DIMSCALE=S and LTSCALE=10*S; read back both.
2. TYPE "_.RECTANG<LF>150000,-80000<LF>153000,-78000"; resolve its new polyline handle from the before/after handle sets; capture hatch handles H0.
3. Run LBUH -> Objects -> the resolved boundary -> empty selection terminator, in one proved chain once supplied. R46's literal route was "LBUH<LF>O<LF>!r1<LF>" after binding r1; do not type !r1 without that binding.
4. Read only HATCH handles added since H0: PatternName, Layer, PatternScale. TYPE "_.ZOOM<LF>_C<LF>151500,-79000<LF><297*S>" with arithmetic resolved to a number; capture the drawing view.
ASSERTIONS
1. Exactly one new hatch; PatternName=DOTS; Layer="HATCH 231 - LOAD BEARING WALL UNDER".
2. PatternScale=20,50,100 for S=20,50,100, respectively, tolerance 0.0001.
3. At the three sheet-equivalent views, look confirms separate dots and paper spacing within 20 percent of the 1:20 capture, not a solid blob.
KIND needs a window look
FAIL MEANS Under-wall hatch becomes too dense or changes its printed appearance with drawing scale.
WHY A UNIT TEST CANNOT CATCH THIS AutoCAD creates and renders the real hatch using the current drawing variables and loaded pattern.

---

CASE C27
TITLE Over-wall hatch keeps its density at three drawing scales
PLAN ITEM SPEC 5.7 C27; #1498 LBH
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV2_S1, independent fresh copy for each S
SETTINGS NEEDED STR HatchDensity ON/default ON with same unresolved parent binding as C26; drawing DIMSCALE=20/50/100 and LTSCALE=200/500/1000.
ROUTE UNPROVEN: for neutral boundary selection: R46 B.10 proves LBH scale 125 at 50; V9b-02 supplies the remaining scales but uses !r2. Need the resolved-handle selection chain and default/key check as C26.
STEPS
1. For S=20,50,100 set and read DIMSCALE=S and LTSCALE=10*S on fresh copies.
2. TYPE "_.RECTANG<LF>155000,-80000<LF>158000,-78000"; resolve new boundary handle; record pre-command hatch handles.
3. Run LBH -> Objects -> resolved boundary -> empty terminator using the proved chain once supplied.
4. Read new hatches only; TYPE "_.ZOOM<LF>_C<LF>156500,-79000<LF><297*S>" after numeric expansion; capture the view.
ASSERTIONS
1. Exactly one new hatch; PatternName=ANSI31; Layer="HATCH 11 - LOAD BEARING WALL OVER".
2. PatternScale=50,125,250 for S=20,50,100, tolerance 0.0001.
3. Look finds paper line spacing within 20 percent across all three captures.
KIND needs a window look
FAIL MEANS Over-wall hatch prints at inconsistent density between 1:20, 1:50 and 1:100.
WHY A UNIT TEST CANNOT CATCH THIS The installed LBH command and AutoCAD's real hatch rendering must agree at three drawing scales.

---

CASE C28
TITLE A section member does not ask elevation-only questions
PLAN ITEM SPEC 5.7 C28; #1518, V9-04
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV2_S1; V9b's separate fixture is V9B_SECTIONMARKS
SETTINGS NEEDED No CE key changed; drawing DIMSCALE=20, LTSCALE=200; STR CeMember settings read only.
ROUTE UNPROVEN: R46 B.9 proves only View prompt and Esc; separate SE answer was refused BUSY. V9b gives a complete TOP chain, not a SECTION chain. Need every SE question/answer including orientation/base point and termination, proved as one chain; do not copy Top's Centreline/Break answers into SE.
STEPS
1. Read model-space entity handles/count and DBMOD; set/read DIMSCALE 20 and LTSCALE 200.
2. Once supplied, TYPE the entire CEMEMBER -> SE -> 310UB32 -> documented section answers -> named base point chain in one send.
3. End with the documented single Esc after placed confirmation; read new history and new member entities.
ASSERTIONS
1. History includes a placed/finished CEMEMBER result and no "Centreline/Top/Bottom" question on the SE path.
2. New member entity count is greater than baseline; a mere prompt without placement does not pass.
KIND deterministic
FAIL MEANS The section route asks the wrong questions or finishes without drawing the member.
WHY A UNIT TEST CANNOT CATCH THIS AutoCAD's installed keyword prompt sequence and actual member placement must be driven together.

---

CASE C29
TITLE Check the disputed 25C text prompt against the real route
PLAN ITEM SPEC 5.7 C29; V9-03 contract discrepancy
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV2_S1; V9b-03 uses V9B_SECTIONMARKS instead
SETTINGS NEEDED No CE key changed; drawing DIMSCALE=50 and LTSCALE=500.
ROUTE UNPROVEN: for SPEC's requested text-then-point MTEXT route: V9b correction says first prompt is a NUMBER, then point, and expected entity is TEXT "257". No evidence supports inventing a text-first chain; this is a requirements mismatch, not a silently corrected test.
STEPS
1. On a fresh copy set/read DIMSCALE=50 and LTSCALE=500; record text/MTEXT handles.
2. Use the recorded V9b-03 sequence as the diagnostic candidate: TYPE "25C<LF>7<LF>150000,-80000"; read the full prompt history and newly added text entities. If a different prompt waits, esc-prompt and BLOCKED rather than answering by guess.
3. Read ObjectName, TextString, Height and Layer of every new text entity; retain actual prompt and values.
ASSERTIONS
1. SPEC's requested acceptance contract: prompt asks for text rather than a number, and one new MTEXT contains the supplied note with Height=125 drawing units (tolerance 0.01).
2. Contract conflict evidence: V9b expects TEXT "257" on 25TEXT, Height=125, after the number 7. If observed, report CONTRACT MISMATCH against assertion 1; do not claim the recorded number route proved the text route.
3. No corrected contract is selected here; this case stays blocked for executable conversion pending plan reconciliation.
KIND deterministic
FAIL MEANS The agreed prompt/entity contract is not met; currently the plan and recorded route disagree and must first be reconciled.
WHY A UNIT TEST CANNOT CATCH THIS The actual installed 25C prompt mode, remembered defaults and drawn text type determine what a drafter receives.

---

CASE C30
TITLE Member hidden lines use the office layer without changing it
PLAN ITEM SPEC 5.7 C30; #1518, V9-05 existing-layer preservation
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV2_S1; separate fresh copy, not C28's section output
SETTINGS NEEDED STR CeMember.HiddenInsideLayer="S-HID", guarded before launch; drawing DIMSCALE=1 and LTSCALE=10. Existing S-HID must be colour 3, linetype DASHED. CD/OLDCS/CVL unchanged.
ROUTE UNPROVEN: V9b-04/05 uses CE-NEWHID, not S-HID, and its full Top route is source-derived. Need proved S-HID fixture setup/linetype availability and single-chain Top placement. A 310UB32 SECTION has no hidden web lines; use TOP to exercise the layer, explicitly correcting the ambiguous "after C28" setup.
STEPS
1. Require S-HID already present, colour 3, DASHED; read its baseline property tuple and entity handles. If absent or different, BLOCKED until a synthetic existing-layer fixture is supplied; do not expect a NEW layer to be created green/DASHED (V9b says new defaults are colour 8/HIDDEN).
2. Set/read DIMSCALE=1 and LTSCALE=10. Proposed V9b Top chain, pending one-send proof: "CEMEMBER<LF>Top<LF>310UB32<LF>Centreline<LF>None<LF>150000,-80000<LF>153000,-80000"; single esc-prompt after placed line.
3. Read S-HID properties and newly added entities on it; read hidden-line layer of the new member.
ASSERTIONS
1. S-HID remains colour 3/DASHED and its original property tuple is unchanged.
2. New member hidden-line count on S-HID is >0; no new hidden line is on hard-coded 18HIDDEN.
KIND deterministic
FAIL MEANS The member ignores the office layer or silently changes the appearance of existing objects on it.
WHY A UNIT TEST CANNOT CATCH THIS Real layer-table state and the installed member drawing command must preserve an existing office layer.

---

CASE C31
TITLE A typed pit selection leaves Redo available five times
PLAN ITEM SPEC 5.8 C31; BUG-861 single-drawing control
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1; five independently fresh copies, each the only drawing open in its session
SETTINGS NEEDED No CE key changed; PICKFIRST=1 restored; no palette/zoom/pan command between U and REDO.
ROUTE UNPROVEN: for the one-drawing combination: R47 B.1.1 proves LINE/U/wait/REDO without selection, B.1.2 proves typed selection with TWO drawings and loses REDO. The requested single-drawing typed-pick control was expressly not completed.
STEPS
1. Repeat five independent trials; record active drawing and require drawing count=1. Clear selection and validate pit 109D56 before LINE.
2. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt once to end LINE; verify idle before U.
3. Capture log offsets outside AutoCAD; TYPE "U"; PICK-FIRST "109D56"; wait 12 s with no other AutoCAD command.
4. TYPE "REDO"; read history, new line existence and log tails with timestamps; perform END before the next single-drawing trial.
ASSERTIONS
1. Each of five Us echoes LINE; each REDO says "Everything has been redone", never "Nothing to redo".
2. The named test line is restored; typed pit selection is recorded as a typed lookup, never described as a mouse pick.
3. Record [CivilGripProbe]/[REDO] log lines from U-to-REDO without inferring cause from their presence.
KIND deterministic
FAIL MEANS Selecting a pit by typed handle consumes Redo even with only one drawing open.
WHY A UNIT TEST CANNOT CATCH THIS Real AutoCAD selection callbacks and the native redo stack are involved after Undo.

---

CASE C32
TITLE A mouse pick of a pit leaves Redo available five times
PLAN ITEM SPEC 5.8 C32; BUG-861 real-pointer comparison
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1; five fresh single-drawing trials
SETTINGS NEEDED No CE key changed; PICKFIRST=1 restored; pointer preconditions and C02 calibration required.
ROUTE UNPROVEN: R47 explicitly left mouse picks to V10-05. Need a proved body-geometry world target for 109D56 and live pointer calibration. A typed preselection cannot stand in for this case.
STEPS
1. For each trial, verify one drawing open and read pit 109D56 body geometry. Before LINE, zoom to its bounds through its handle and set a named point on visible pit geometry; require no obstruction.
2. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt; TYPE "U".
3. Click the named pit body world point once; read implied selection through COM without a typed command; wait 12 s.
4. TYPE "REDO" with command-strip focus, without an intervening drawing command; read new history and test-line existence.
ASSERTIONS
1. The mouse selected exactly 109D56; failure to hit the pit is BLOCKED for this behavioural case.
2. All five REDOs say "Everything has been redone" and restore the line.
KIND deterministic
FAIL MEANS A genuine mouse selection costs Redo after Undo.
WHY A UNIT TEST CANNOT CATCH THIS Real pointer selection fires native grip/selection events that a mocked or typed selection does not reproduce.

---

CASE C33
TITLE The CE right-click selection item does not consume Redo
PLAN ITEM SPEC 5.8 C33; BUG-416 and BUG-861
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh single-drawing copy
SETTINGS NEEDED No CE key changed; PICKFIRST=1; SHORTCUTMENU value enabling selected-object context menu must be proved/read/restored, not guessed.
ROUTE UNPROVEN: R44 B.4 and R47 D.3 did not drive the menu. Need calibrated pit target, context-menu UI text and unique item "CE: Select this run" (BACKLOG item 19); exact selector not proved. SPEC's "no save question" also conflicts with its undoable test LINE and an already-dirty Civil copy; retain as an unresolved contract.
STEPS
1. Resolve pit 109D56 geometry and zoom before the undo sequence. Record DBMOD and baseline entity state.
2. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt; TYPE "U".
3. Click the named pit body point; right-click the same world target; read menu controls as text.
4. Press only the unique "CE: Select this run" menu item if present; Esc to leave selection; TYPE "REDO"; read history and line existence.
5. Close the test copy without saving; record whether a save question appears, answering No through the guarded route.
ASSERTIONS
1. REDO says "Everything has been redone" and restores the line; menu selection itself adds no drawing geometry/attribute/layer edit.
2. Menu must be text-readable; otherwise BLOCKED, never click an inferred menu position.
3. Record SPEC's requested no-save-question result separately as CONTRACT UNRESOLVED: test-line restoration already changes the copy. Do not call the natural save question a CE failure until this contract is reconciled.
KIND deterministic
FAIL MEANS The CE menu consumes Redo or changes the drawing during what should be selection only.
WHY A UNIT TEST CANNOT CATCH THIS The installed AutoCAD context menu, actual selection event and native undo/redo history must run together.

---

CASE C34
TITLE A typed pit selection keeps Redo with two drawings open
PLAN ITEM SPEC 5.8 C34; BUG-861 R47 Run B reproduction
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Two fresh DRV1_B1 copies per trial; five trials, active second copy, first remains open
SETTINGS NEEDED No CE key changed; PICKFIRST=1 restored; same settings as C31.
ROUTE PROVEN for one trial: R47 B.1.2 reproduced "Nothing to redo" on second copy after typed pick. Five-repeat requirement is expanded here. EXPECT-FAIL BUG-861 on baseline.
STEPS
1. Launch first DRV1_B1 copy; open second fresh copy writable, leaving first open; verify second is active and count=2 BEFORE LINE.
2. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt; TYPE "U"; PICK-FIRST "109D56"; wait 12 s.
3. TYPE "REDO"; read history and test-line existence; record U-to-REDO CE-log tail with timestamps.
4. End session and repeat from two fresh copies until five trials are recorded. Do not switch drawing tabs between U and REDO.
ASSERTIONS
1. Each REDO must say "Everything has been redone" and restore the test line.
2. Record any "Nothing to redo" as FAIL/EXPECT-FAIL BUG-861, with active drawing/count. Do not claim typed pick alone caused it.
KIND deterministic
FAIL MEANS The two-drawing typed-selection sequence reproduces the known lost-Redo fault.
WHY A UNIT TEST CANNOT CATCH THIS Multiple live AutoCAD documents and their selection/reactor state are absent from ordinary unit tests.

---

CASE C35
TITLE X-Civil warns when the source says metres but its size disagrees
PLAN ITEM SPEC 5.9 C35; BUG-505 CHECK THE SCALE
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Target fresh DRV1_B1; source fresh DRV15_METRE as required by SPEC; separate named candidate V8_METRE for the forced-mismatch route
SETTINGS NEEDED No CE key changed; target units read, never silently changed; source INSUNITS must be read as 6 and geometry mismatch established before expecting a warning.
ROUTE UNPROVEN: SPEC names DRV15_METRE, but V8-01b uses V8_METRE and a BLANK target; these are different fixtures. Need proof of mismatch on DRV15_METRE, working guarded Choose DWG/Read source/Close selectors and fixed dialog-path. v2's AutomationElement failure must not be bypassed.
STEPS
1. Read source copy INSUNITS, extents and relevant object dimensions without changing it; read target INSUNITS, entity handles/count N and DBMOD. If no mismatch can be established, BLOCKED for warning coverage, not FAIL.
2. Capture Civil/TIM_CE_CADTOOLS log offsets, including xcdimport report offset/existence. TYPE "CDIMPORTXCIVIL"; require X-Civil import Source page.
3. Press "Choose DWG..."; set "Choose X-Civil drawing" File name to the run source copy through fixed dialog-path; accept Open; press "Read source" (required by V8 and omitted from SPEC's shorthand).
4. Require "Pit and pipe schedule" / "Check the schedule first"; read controls/warnings as text; capture window; read newly added CHECK THE SCALE/[SCALE] log bytes.
5. Press "Close"; read new history, target handles/count and DBMOD. Never press Import to drawing.
ASSERTIONS
1. For a proved mismatch, a new "CHECK THE SCALE:" line names metres; record its presence/absence in window, command history, normal logs and new debug report separately. The window capture is reviewed for wording/readability.
2. Debug source-unit evidence agrees with INSUNITS=6; a scale-agrees report means mismatch precondition was not met, not a warning PASS.
3. After Close entity handles/count N and DBMOD equal baseline; no entities were imported.
KIND needs a window look
FAIL MEANS A proved metre-size disagreement is hidden or mislabelled, or merely reviewing the import inserts objects.
WHY A UNIT TEST CANNOT CATCH THIS The real file reader, unit interpretation, import preview and cancellation must work across two DWG files.

---

CASE C36
TITLE Record the scale warning for a source with no units
PLAN ITEM SPEC 5.9 C36; BUG-505; Monday question 1
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE Target fresh DRV1_B1; existing unitless candidate V8_UNITLESS; SPEC's unitless derivative of DRV15_METRE has not been made
SETTINGS NEEDED No CE key changed; read source INSUNITS=0. No fixture saving is performed by this document task.
ROUTE UNPROVEN: same preview/dialog selectors and target-fixture difference as C35. Existing V8_UNITLESS avoids inventing a saved derivative; prove its INSUNITS and geometry first. Tim's soft-note-versus-nothing ruling remains pending.
STEPS
1. Read source INSUNITS and geometry; require 0, else BLOCKED. Read target entity handles/count and DBMOD; capture fresh log/history offsets.
2. TYPE "CDIMPORTXCIVIL"; Choose DWG... -> fixed file dialog with the run copy of V8_UNITLESS -> Read source.
3. Read schedule-page window controls/warnings, CHECK THE SCALE/[SCALE] lines since offsets and capture actual window.
4. Press Close; reread target handles/count and DBMOD.
ASSERTIONS
1. Record exact no-units wording and its location, including an explicit absent result for each location read.
2. Source evidence records INSUNITS=0; target handles/count and DBMOD remain unchanged.
3. Behaviour verdict is RECORD ONLY pending the ruling. Absence/presence of a soft note alone is neither PASS nor FAIL.
KIND needs a window look
FAIL MEANS Preview/Close changes the drawing or misreads the source; the preferred note remains a pending decision.
WHY A UNIT TEST CANNOT CATCH THIS The installed import preview must interpret a real unitless DWG and leave its target unchanged.

---

CASE C37
TITLE Tidy labels names the pipe and the distance it would move
PLAN ITEM SPEC 5.10 C37; BUG-856
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy; reproduce R44-R47's full in-session setup, not CDTIDYLABELS alone
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true before launch; PICKFIRST=1 restored.
ROUTE PROVEN: R44 B.5, R46 B.3, R47 B.4.1-B.4.2. Start Pipe/Apply can exceed a driver watchdog; a timeout is BLOCKED for the runner, not permission to assume success.
STEPS
1. PICK-FIRST "109D56"; TYPE "_.MOVE<LF>0,0<LF>0,2000"; wait idle. This pit move is part of the recorded setup.
2. TYPE "CDTIDYLABELS<LF>All"; require the baseline no-move result with P3 -> P2 no-clear-spot line, and idle. If it waits unexpectedly, stop BLOCKED and record the prompt.
3. TYPE "PIT<LF>150000,-80000" expecting New Pit; set C2.CoverLevel=19.000; press "Continue placement" with 120 s allowance; esc-prompt three times through pit-label/cover placement and next-pit prompt, requiring "Pit placed successfully." and "Stopped".
4. TYPE "CD<LF>150000,-80000<LF>170000,-80000<LF>" expecting New Pipe; set C2.FirstInvert=18.000 and C2.SecondInvert=17.900; press "Start Pipe" with 120 s allowance; esc-prompt once after placement; require pipe placed/P8 -> Open end and stopped.
5. Resolve handle 10EC5D and require the newly placed SPOT LEVEL block, not a pre-existing object. PICK-FIRST "10EC5D"; TYPE "_.MOVE<LF>0,0<LF>81839,-53713".
6. TYPE "_.ZOOM<LF>_W<LF>148500,-81500<LF>152500,-78500"; capture new history/log offsets.
7. TYPE "CDTIDYLABELS<LF>All"; read preview; esc-prompt at "Move this label now? [Yes/No] <No>:"; require idle.
ASSERTIONS
1. Preview history matches "pipe P[0-9]+ -> .* would move [0-9]+ mm"; recorded expected line on this setup is "pipe P8 -> open end start invert text would move 275 mm (further out).".
2. Summary says Will move 1, Placed by hand 0, No clear spot found 1; no-clear-spot line names pipe P3 -> P2 label.
3. Escape prints "Nothing was moved." and gives one cancelled CDTIDYLABELS outcome in the Civil plain-log interval.
KIND deterministic
FAIL MEANS The preview no longer tells the drafter which pipe's label would move and by how much.
WHY A UNIT TEST CANNOT CATCH THIS A real placed pit, open-ended pipe and obstructing label must produce the installed preview's actual words.

---

CASE C38
TITLE Recover Inverts reports the recorded recovered and skipped totals
PLAN ITEM SPEC 5.10 C38; Recover Inverts regression
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1 plus the exact R47 setup in C37 steps 1-6 on this fresh copy
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true for the recorded setup; no Recover Inverts override.
ROUTE PROVEN: R44 B.6, R46 B.4, R47 B.4.3. The reports ran after adding the C37 pit/pipe; their 50-pipe totals are not proved on an untouched 49-pipe copy. Setup is inherited as ordered steps, never an already-modified fixture.
STEPS
1. Perform C37 steps 1-6 on a fresh DRV1_B1 copy; require successful placement and idle.
2. Capture fresh history and Civil log offsets; TYPE "CDRECOVERINVERTS"; wait idle; read new history/log text.
ASSERTIONS
1. New text contains "Found 50 pipes in project data, 26 with stored invert values.".
2. It contains "26 pipes recovered", "24 skipped" and "5 pipes have only one of their two invert texts"; no unproved claim that new text was drawn is inferred from the recovered count.
3. Command outcome is completed exactly once in the Civil plain log.
KIND deterministic
FAIL MEANS Stored inverts are skipped/recovered differently on the same proven drawing state or the partial-text warning disappears.
WHY A UNIT TEST CANNOT CATCH THIS Recovering levels depends on both real drawing entities and project data stored inside the DWG.

---

CASE C39
TITLE The water-level warning says the pit needs 150 millimetres
PLAN ITEM SPEC 5.10 C39; freeboard regression
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1 plus C37 steps 1-6 to reproduce the recorded pit-list context
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true for setup; existing water/freeboard keys unchanged. Expected 150 mm is a regression baseline, not new engineering approval.
ROUTE PROVEN: R44 B.7, R46 B.5, R47 B.4.4, complete CDTWL answers 10 and 18.70.
STEPS
1. Perform C37 steps 1-6 on a fresh copy; capture history/log offsets.
2. TYPE "CDTWL<LF>10<LF>18.70"; wait idle; read all new history and matching new Civil-log lines.
ASSERTIONS
1. New result contains "Only 40 mm between the water and the lid of pit C1 (150 mm is wanted).".
2. It also records "Only 110 mm" warnings for P1 and P7, each naming 150 mm, and "That is enough.".
3. One completed CDTWL outcome exists in the Civil plain-log interval.
KIND deterministic
FAIL MEANS The drawing's water-level result loses the recorded clearance or asks for the wrong baseline freeboard.
WHY A UNIT TEST CANNOT CATCH THIS The actual pit selection, cover levels and installed settings must feed the command's real output.

---

CASE C40
TITLE A pipe cascade changes the network and Undo restores the old levels
PLAN ITEM SPEC 5.10 C40; Edit Pipe cascade, UX-LBL-02
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, pipe P3 handle 10A98D; include C37 steps 1-6 for exact R47 context
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true for setup; PICKFIRST=1 restored; C2.FirstInvert=17.60/C2.SecondInvert=17.50 are transient Edit Pipe values, not settings-file keys.
ROUTE UNPROVEN: for full database assertion: edit/Yes/Apply/U/REDO chain proven R44 B.8/R47 B.4.5; these reports explicitly did NOT read invert text after U. Need exact linked invert-text handles and project-data read mapping before scoring restored values; a command echo is insufficient.
STEPS
1. Perform C37 steps 1-6 on fresh copy. Resolve linked invert-text handles for 10A98D and downstream affected pipes; store text/level values OLD. Stop BLOCKED if linkage is not unique.
2. TYPE "_.ZOOM<LF>_W<LF>50000,-30000<LF>80000,-20000"; PICK-FIRST "10A98D"; TYPE "CDEDIT<LF>Y" with expected Edit Pipe.
3. Set C2.FirstInvert=17.60, C2.SecondInvert=17.50; press "Save pipe and close"; require the Recalculate message showing downstream 17.30 ->17.50.
4. Answer Yes once through msgbox-answer "*Recalculate downstream inverts*"; press Cascade Preview "Apply" with 120 s allowance; require idle and record new linked values NEW.
5. TYPE "U" once; read linked text/database values; wait 12 s with no intervening typed command; TYPE "REDO"; reread values and history.
ASSERTIONS
1. History contains "Updated 4 pipes and 3 pits from P3 (IL 17.50)" and "Min grade: 1:16"; missing-level STUB -> X1 warning is retained.
2. Applied P3 values equal 17.60/17.50 within 0.005 m and downstream changed values are recorded; after U every monitored value equals OLD; after REDO every value equals NEW.
3. U echoes CDEDIT; REDO contains "Everything has been redone". A timed-out Apply is BLOCKED even if some update text appeared.
KIND deterministic
FAIL MEANS A cascade cannot be undone/redone as one drawing change, or printed success hides levels that did not restore.
WHY A UNIT TEST CANNOT CATCH THIS The real dialog, downstream recalculation, text entities, project data and AutoCAD undo stack all participate.

---

CASE C41
TITLE Moving a pit quickly opens no CE window
PLAN ITEM BACKLOG W1-02; quick-edit gate, ruling I2
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, pit P3 109D56
SETTINGS NEEDED No CE key changed; PICKFIRST=1 restored; run before opening any findings/schedule palette.
ROUTE UNPROVEN: for full label assertion: body MOVE/no-window chain proven R44 B.10/R47 B.4.1; linked-label handles/expected offsets and post-U geometry still need supplying. Do not claim R47 proved label positions.
STEPS
1. Resolve pit 109D56 and its linked label/cover/invert handles; read their positions OLD and current window list.
2. PICK-FIRST "109D56"; TYPE "_.MOVE<LF>0,0<LF>0,2000"; wait idle; read positions and window list.
3. TYPE "U" once; read all monitored positions and history.
ASSERTIONS
1. MOVE reports 1 found and pit displacement is 0,2000 drawing units within 0.001; linked labels follow the documented placement rules supplied with their handles.
2. No new Edit Pit, Edit Pipe, New Pit, New Pipe, Cascade, Design Warnings or CE message window opens.
3. One U restores all monitored positions to OLD within 0.001 drawing units.
KIND deterministic
FAIL MEANS A normal pit move interrupts drafting, leaves its labels behind or cannot be undone together.
WHY A UNIT TEST CANNOT CATCH THIS Native MOVE must drive CE's live link updates without opening a blocking window.

---

CASE C42
TITLE Sync leaves the Pit Schedule figures alone
PLAN ITEM BACKLOG W1-03; BUG-855 header count reported separately
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1 with C37 steps 1-6 and the completed Edit Pipe cascade, reproducing R46's 12-pit/50-pipe state; start from a fresh copy
SETTINGS NEEDED CD linking.tidyLabelsEnabled=true for recorded setup; no schedule key changed.
ROUTE PROVEN for schedule comparison chain: R44 B.9/R46 B.7, not run on R47. Use the recorded preparation if exact 12/50 counts are asserted; a fresh drawing-only run needs its own baseline counts.
STEPS
1. Reproduce C37 steps 1-6. PICK-FIRST 10A98D; TYPE "CDEDIT<LF>Y"; set C2.FirstInvert=17.60 and C2.SecondInvert=17.50; press Save pipe and close; msgbox-answer "*Recalculate downstream inverts*" Yes once; Cascade Preview Apply (120 s); require update complete; TYPE "U", wait 12 s, TYPE "REDO". This repeats R46's command setup without relying on C40's missing invert-text mappings.
2. TYPE "PITSCHEDULE"; read full Rows-view control text at depth sufficient for every row; store row values and header separately; close Pit Schedule via its window-close route.
3. TYPE "CDSYNC"; wait idle; read result.
4. TYPE "PITSCHEDULE"; read all row values/header again; close by the same route.
ASSERTIONS
1. CDSYNC reports "Pits relinked: 12, Pipes relinked: 50" on the full recorded setup.
2. Every schedule row/cell value equals baseline; exclude only the drawing-check issue-count header and driver counters, never entire rows.
3. Record header count before/after (R46 95->96) as BUG-855 observation; do not hide it or fail unrelated row equality for it.
KIND deterministic
FAIL MEANS Relinking changes schedule figures even though the drawing geometry did not change.
WHY A UNIT TEST CANNOT CATCH THIS CDSYNC must reconcile real drawing entities and the live schedule's displayed project records.

---

CASE C43
TITLE The schedule keeps the number in an inlet pit's name
PLAN ITEM BACKLOG W2-01; BUG-784, #1413
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1 candidate; needs an inlet FROM a real non-P pit such as C1, not merely a receiving C1 group
SETTINGS NEEDED CD scheduleFromKeepsPitNumber=true/default ON per W2; full parent key path unrecorded, so read the binding before any guarded override.
ROUTE UNPROVEN: PITSCHEDULE opens in R44-R46, but W2-01 says DRV1_B1 likely has no qualifying inlet. Need the exact fixture/pipe/pit handles and expected FROM cell, plus row/cell text selector.
STEPS
1. Require supplied real non-P inlet mapping and confirm its source pit's name from drawing data. If DRV1_B1 lacks it, BLOCKED fixture; do not pass because no C-only cell was found.
2. TYPE "PITSCHEDULE"; read all inlet rows and pit-group names as text, using stable group/column names, not grid coordinates.
3. Read the supplied pipe's FROM cell and any other inlet from the same source; close without editing.
ASSERTIONS
1. At least one qualifying inlet is actually present and its FROM cell keeps the complete real pit name, e.g. C1 rather than C or Cs.
2. Source tags DP/AGI/TG/WT are not incorrectly treated as real numbered pit names.
KIND deterministic
FAIL MEANS A pit number is lost in the schedule, so the inlet can be confused with a different pit.
WHY A UNIT TEST CANNOT CATCH THIS The installed schedule must resolve real drawing pit identities and render the corresponding inlet row.

---

CASE C44
TITLE Deleting a schedule cell leaves it blank after Sync
PLAN ITEM BACKLOG W2-03; BUG-783, #1412
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, P3 group associated with 109D56
SETTINGS NEEDED CD scheduleDeleteCellStaysBlank=true/default ON per W2; full parent binding not recorded; do not invent an override path.
ROUTE UNPROVEN: W2-03 supplies named menu "Delete cell", but no R44-R47 execution or stable row/column/menu UI selector. Need text-addressable P3 Cover cell and successful menu interaction, not a picture position.
STEPS
1. TYPE "PITSCHEDULE"; resolve row group P3 and column Cover by text; record old value and control selector.
2. Right-click that named cell; read menu as text; press unique "Delete cell"; read cell again; close schedule through its recorded close route.
3. TYPE "CDSYNC"; wait idle; TYPE "PITSCHEDULE" again; reread P3 Cover and all cell text; close without further edit.
ASSERTIONS
1. P3 Cover is empty immediately after Delete cell and remains empty after Sync/reopen.
2. No cell contains the literal sentinel word DELETE/Delete as its displayed value; do not match a button/menu label as a cell.
KIND deterministic
FAIL MEANS An internal delete marker appears on the schedule or the deleted cover value comes back.
WHY A UNIT TEST CANNOT CATCH THIS A real schedule edit must survive close, drawing relink and window reconstruction.

---

CASE C45
TITLE Opening the Pit Schedule does not add its own Undo step
PLAN ITEM BACKLOG W2-04; BUG-817, open
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy; independent of C44 edits
SETTINGS NEEDED No CE key changed; four settings files hashed.
ROUTE PROVEN for PITSCHEDULE open/close and U commands in R44-R46 and W2's recorded earlier observations; this exact no-edit undo assertion remains to be executed. EXPECT-FAIL BUG-817 where the reported schedule undo step persists.
STEPS
1. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt; read its new line handle and DBMOD B.
2. TYPE "PITSCHEDULE"; close immediately without selecting/editing a cell; read DBMOD C.
3. TYPE "U" once; read echo and the test line's existence; wait 12 s; TYPE "REDO"; read echo and line existence.
ASSERTIONS
1. C=B; U echoes LINE and removes the test line, not PITSCHEDULE.
2. REDO restores the line and reports "Everything has been redone".
3. If U echoes PITSCHEDULE, report FAIL/EXPECT-FAIL BUG-817; equal DBMOD alone is not proof of no undo step.
KIND deterministic
FAIL MEANS A drafter must press Undo through a window they only looked at before reaching their actual drawing edit.
WHY A UNIT TEST CANNOT CATCH THIS AutoCAD's native undo sequence exposes unwanted transactions left by a real modal window.

---

CASE C46
TITLE Calculations keeps its older longitudinal page and tabs only change the view
PLAN ITEM BACKLOG W5-01/W5-02/W5-04; BUG-758 window half, #1408
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED CD showOlderLongSectionTab=true/default ON per W5; full parent binding unrecorded; no override until read from actual binding.
ROUTE UNPROVEN: W5 supplies CDCALC and tab names from window source; no completed route/unique controls in required R44-R47. Need actual window title and close selector.
STEPS
1. TYPE "_.LINE<LF>150000,-90000<LF>151000,-90000"; esc-prompt; read line handle and DBMOD B.
2. TYPE "CDCALC"; read actual title, tab list and selected tab as text; capture full window.
3. Select Profiles, then Older longitudinal by unique tab name; read controls and capture each page. On Older longitudinal read Route and scales, Preview, Levels; press no drawing/calculation/export buttons.
4. Close by proved Close/Cancel; read DBMOD; TYPE "U" once and read echo/test-line existence.
ASSERTIONS
1. Older longitudinal exists with its default ON; Profiles and Older longitudinal are reachable.
2. DBMOD remains B; U echoes LINE and removes that line, not CDCALC.
3. Look confirms tab strip/pages are readable, no overlapping/cut-off text or layout scrolling; hidden tab names are recorded rather than omitted.
KIND needs a window look
FAIL MEANS A promised page is missing, a page switch draws/writes something, or a read-only look adds an Undo step.
WHY A UNIT TEST CANNOT CATCH THIS The installed modal tab layout and actual drawing/undo state must be observed together.

---

CASE C47
TITLE The older calculators clearly stay read-only
PLAN ITEM BACKLOG W5-03; older calculator banners; BUG-772 is BLOCKED-by-design
BUILD Civil 3.0.70 / Structural 1.0.121
FIXTURE DRV1_B1, fresh copy
SETTINGS NEEDED No CE key changed; all four files hashed; no calculation/save/export/draw action.
ROUTE UNPROVEN: W5-03 proposes two tabs and a box click but does not name a unique field. Need named field selectors on WSUD and Pump System and proved CDCALC close. Never choose an arbitrary box by its picture position.
STEPS
1. Read DBMOD and entity count; TYPE "CDCALC"; select "Older calculators - WSUD" by text.
2. Read banner and enabled/read-only states for the supplied named field; capture page. Attempt digit 7 in that named field through the proved input route and read back its unchanged value. If the driver refuses a disabled control, record that state/refusal without bypassing it.
3. Repeat step 2 on "Older calculators - Pump System" and its supplied named field.
4. Close window through proved Close/Cancel; reread DBMOD and entity count.
ASSERTIONS
1. Both banners begin "Read-only - an Older calculator, under review before its rules are signed."; named fields remain disabled/read-only and unchanged.
2. DBMOD and entity count equal baseline; captures show a clear readable read-only explanation.
3. BUG-772's WSUD area calculation is NOT TESTED; a read-only page cannot prove its engineering calculation.
KIND needs a window look
FAIL MEANS An older calculator accepts edits despite its read-only promise or gives an unreadable explanation.
WHY A UNIT TEST CANNOT CATCH THIS Actual input focus, disabled controls and banner presentation are properties of the running window.

---

CASE C48
TITLE Manager's pages are readable and reopening keeps the same size
PLAN ITEM BACKLOG W6-01/W6-03/W6-04; BUG-754, #1388; About version coverage stays in C12
BUILD Civil 3.0.70 / Structural 1.0.121; Manager 1.1.70 alongside
FIXTURE Existing V10_BLANK copied fresh, matching W6's blank-drawing requirement
SETTINGS NEEDED No CE key changed; theme read only from OLDCS/CVL as W6 instructs; actual theme binding/value recorded, never guessed or changed.
ROUTE UNPROVEN: W6 proposes CEMANAGER and Status/Module/Updates/Help; required R44-R47 did not execute its tab/read/close sequence. Need unique tab controls, exact window title and Close selector. No administrator/update button is pressed.
STEPS
1. Read DBMOD B; TYPE "CEMANAGER"; read actual title, tabs, theme evidence and window bounds; capture the whole window.
2. Select Status, Module, Updates, Help in that order by unique text selector. On each read headings/section/button names and enabled states; capture window after page settles; press no page buttons.
3. Close through proved window Close; TYPE "CEMANAGER" again; read bounds and DBMOD after closing again.
ASSERTIONS
1. All four tabs exist and their page text is readable, with no clipping/overlap or page-layout scrolling; selected tab is visually distinct and text contrasts with its face.
2. Reopened window width/height equal original in physical pixels on the same monitor/scale; record theme and actual dimensions.
3. DBMOD remains B and four settings hashes remain unchanged. Any Manager close-time file write is reported explicitly, not silently allowed as unchanged.
KIND needs a window look
FAIL MEANS Manager pages are difficult to read, reopen at a different size or change settings/drawing merely by being viewed.
WHY A UNIT TEST CANNOT CATCH THIS The installed Manager window, current theme and actual monitor scale determine readability and restored size.

---

SUMMARY
The draft covers all 40 specified cases and eight backlog cases. Proven command chains are preserved; unresolved fixtures, control selectors, prompt sequences and plan conflicts are marked ROUTE UNPROVEN. C08 and C36 record pending decisions without claiming a behavioural pass. All cases require drawing-copy isolation, new-log-byte evidence and verified settings restoration. No AutoCAD checks, builds or tests were run; nothing here marks a bug accepted. Only this document is authorised for commit and push.
