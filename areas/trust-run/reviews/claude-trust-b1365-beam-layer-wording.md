# Review: PR 2069 `claude/trust-b1365-beam-layer-wording` (BUG-1365: beam tools name the layer that is locked, off, frozen or set differently)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:39 PC clock. Read only. **Head reviewed:** `44e1ac66`, one own commit on the installed Structural `8de95c34` (ancestor, checked). **Read against:** the BUG-1365 carpark entry; the installed beam route at `C:\CE_WORK\scratch\audit_struc` from the layer writer to the command line, for tools 1 and 2 and for tools 4 and 5. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. When the BEAM, BEAM LOWER or 25TEXT layer is locked, off, frozen, not plotting, a different colour or linetype, or HIDDEN is not loaded, beam tools 1, 2, 4 and 5 now say which layer and what is wrong ("Beam not placed: layer BEAM is locked. Nothing was drawn and nothing was changed. CE does not change your layers. Unlock it in the Layer command, then run the command again.") instead of "CE hit an internal problem".
2. CE still changes nothing on your layers; the beam is still refused in exactly the same cases as today, only the words change.
3. Worth your eye: a 25TEXT or BEAM layer that is simply a different colour from CE's still stops the beam (that was already so); the line now says so plainly.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Findings

1. **The layer code really reaches the line, for both routes (traced by reading).**
   1. Tools 1 and 2: the layer writer throws its known-failure code (`Services\ConnectedDesign\Commit\BeamAtomicLayerWriter.cs`, branch 45-76); the write gateway turns it into "not committed" with that code (`Commit\BeamAtomicWriteSession.cs` 120-125, installed); the coordinator puts "COMMIT_NOT_COMPLETED" first and adds the writer's codes after it (`Structural.DesignCore\ConnectedDesign\BeamAtomicCommitCoordinator.cs` 107-117); the host passes the list through unchanged (`BeamCommandHostFlow.cs` 381-384; `BeamCommandHostModels.cs` 338-346); the result sink now looks through the whole list for a layer code first (`Host\BeamCommandAutoCadRoute.cs`, branch 450-453). On the installed build it read only the first code, COMMIT_NOT_COMPLETED, which has no wording, hence "internal problem".
   2. Tools 4 and 5: the special writer calls the same layer writer (`Commit\AutoCadBeamSpecialAtomicWriter.cs` 111) and returns the same code (172-177); the special commit puts "SPECIAL_ATOMIC_NOT_COMMITTED" first and the code after (`BeamSpecialAtomicCommit.cs` 160-168); the special route reports through the same sink (`Host\BeamSpecialCommandAutoCadRoute.cs` 22, 173-195). So the layer line wins there too.
   3. Nothing on the way checks the shape of a code; the colon and the layer name pass through (`BeamAtomicCommitModels.cs` 540-555 only limits the count to 32).
2. **Nothing unlocked, thawed or bypassed.** The existing-layer branch only reads and compares; a missing layer is still created as before (branch 79-88). One U: nothing is drawn, so nothing to undo.
3. **Words are plain and name the layer.** Eight lines (`Structural.DesignCore\ConnectedDesign\BeamLayerProblem.cs` 62-88), each with "Nothing was drawn and nothing was changed. CE does not change your layers." and what to do in the Layer or Linetype command. No codes, no "STRUCDEBUG".
4. **The wording backlog guard still holds:** the new codes are found by its scan and have wording, so `EveryCodeInTheBeamRoute_HasItsOwnLine_OrIsOnTheWordingBacklog` stays meaningful (`Structural.DesignCore.Tests\BeamRefusalWordingTests.cs` 312-361). "REQUIRED_LINETYPE_MISSING" is left on the backlog list though no code says it any more; harmless (the guard only flags worded leftovers).
5. **Tests: half through the real code path.** The line-building half runs the real functions (`BeamLayerProblem.TryDescribe`, the real sink `BuildMessage`) and fails on the installed build (the class does not exist; the sink gives "internal problem"). The writer half is a text search of the source (`Structural.Tests\...\Host\Bug1365BeamLayerWordingTests.cs` 53-69), and the hand-built code lists stand in for what the coordinator produces; no test drives the coordinator with a writer that returns a layer code (possible without AutoCAD, the coordinator is in DesignCore).

## Small (not blocking the robot)

1. **One problem at a time.** A layer that is both locked and the wrong colour says only "locked"; after unlocking, the next run says "not colour 4". Listing every problem with that layer in one line would save a round.
2. **"Comes from an attached reference drawing" cannot happen for a layer named exactly BEAM** (a reference drawing's layer is named "drawing|BEAM"), so that line is unreachable. Harmless.
3. Add one DesignCore test that runs the real coordinator with a stand-in writer returning "REQUIRED_LAYER_LOCKED:BEAM" and checks the drafter's line, so the hand-built list cannot drift from the real one.

## For Tim (engineering or office standard, not this bug)

1. Should a BEAM, BEAM LOWER or 25TEXT layer that is merely a different colour or not plotting stop the beam at all, or should CE draw on it and say so? Today it stops; this PR keeps that and names it.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: each layer state for each of tools 1, 2, 4 and 5 (the robot's list is the change log's AutoCAD check).
3. Whether an earlier stage (preview or recheck) can refuse a bad layer before the writer with another code; I found layer-state reads only on picked source lines (`Host\BeamCommandAutoCadReadScope.cs` 655-673) and in the special reconciliation for an earlier attempt (`Commit\AutoCadBeamSpecialAtomicReconciliation.cs` 161-162).
4. No client name, street, suburb or job number in the diff (checked).
