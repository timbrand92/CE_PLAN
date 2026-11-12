# Re-read 3: PR 2040 `claude/trust-reader` (head moved after GO)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:03 PC clock. **Head read:** `ebf7a21a` (one commit since the GO at `d93ebdc0`: "CETRUSTREAD, hidden typed read-only reader command (switch OFF)"). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The reader now has its own hidden typed command, CETRUSTREAD, so the test robot no longer needs a throwaway one. It is switched off unless a test setting is turned on.
2. It still changes nothing in the drawing; it writes the reading to the command line and to a text file in the temp folder.
3. Not seen in AutoCAD yet.

**Verdict: the GO holds** (robot, probe P3, on copies).

---

## What changed

1. **New command `CETRUSTREAD`** (`Modules\Drainage\Commands\TrustReaderCommand.cs`): typed only, marked hidden and expert in the command list (`Assets\Config\command-registry.json`), switch `diag.trustReaderCommand` OFF by default (`Models\DiagSettings.cs`), flagged "no Undo marker". Off: one line, nothing read. On: asks for a plain name (the prompt says never a client name), copies the drawing read only and writes the reading to the command line and to `%TEMP%\CE_TrustReader` (`Services\TrustReaderFill\TrustReaderRun.cs`), never beside the drawing. Every failure says "Nothing was changed".
2. **The command count guard** goes from 147 to 148 with the reason written beside it (`Drainage.Tests\Services\CrossModuleGuardTests.cs`): a recorded change, not a weakening.
3. Two comments now name the one caller.

## Worth knowing

1. CE's own end-of-command routine still runs after CETRUSTREAD like any command: if a save of CE's record happens to be waiting for that drawing (left by earlier work), it would be written at CETRUSTREAD's end. On a freshly opened copy nothing is waiting, which is how the robot row runs it; the row already checks the stored record text and the Undo list before and after.

## What I did not check

1. Nothing run; the new call-graph test (`TrustReaderCommandTests`) read by name only.
