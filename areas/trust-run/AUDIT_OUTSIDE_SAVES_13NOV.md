# Audit: every place outside CE's record service that asks for the record to be saved (BUG-1456, the door the change check cannot close)

**Lane:** trust-foundations. **Written:** Fri 13 Nov 2026, 10:15 PC clock. **Read at:** `claude/bug-1456d-refusal-said-on-screen` `39e489e9` (Civil 3.0.90 plus the four BUG-1456 drafts 2073, 2083, 2089, 2090). Read only: no build, no test, no AutoCAD. Asked for by the review of pull request 2083 (finding 5: "36 call sites ask for a save from outside the service ... not traced for all 36").

## FOR TIM

1. **Nothing new was found.** Every one of the 36 places was read. None changes CE's pits and pipes for a drawing it has not first picked up, by reading.
2. **25 of the 36 only ask CE to write what is already waiting.** Those are covered by the cure (pull request 2073): CE refuses to write when the data it holds is another drawing's.
3. **11 change something and then ask for a save.** Six pick up the drawing's own data first, in the same routine. Five do not, but every tool that reaches them does so first; two of those routes are not fully traced (below).
4. **A guard that checks this automatically on every build has NOT been written.** It is the next piece if the controller wants it.

## What was looked for

The change check (pull request 2083) stops CE's own record routines changing another drawing's record. It cannot see code elsewhere that takes a pit or pipe out of the record, edits it directly, and then asks for a save. So each place outside the record service that asks for a save was read for two things: does anything edit the record directly before it, and is the record this drawing's at that moment.

## A. Only asks for a write of what is waiting: 25 places

No direct edit sits in front of these; they call the flush. The cure's three write checks cover them.

1. `Commands/FlatPipeRepairCommand.cs:58` and `Commands/PipeEndRepairCommand.cs:67`: after repairs made through the record service's own checked routines.
2. `Commands/PitEditCommand.cs:437`: Edit Pit, after it has picked up the drawing's data.
3. `Dialogs/PitScheduleDialog.xaml.cs:163`: as the Pit Schedule window closes, for the drawing it was opened on.
4. `Services/InspectorPaletteService.cs:3197`: after binding to the drawing in front.
5. `Services/LinkService.LinkedTextEdits.cs:314` and `:514`: after linked text edits made through the checked routines.
6. `Services/LinkService.PipeOops.cs:267`, `LinkService.PitOops.cs:253`, `LinkService.SurfaceDrainTags.cs:443`: each binds the record to the drawing first.
7. `Services/LinkService.Reactors.cs:2062` and `:2094`: the end of a command.
8. `Services/LinkService.cs:1285`, `:1290`, `:1419`: as a drawing is saved or closed.
9. `Services/PitRenumberApplyService.cs:164`: after renumbering through the checked routine.
10. `ViewModels/PitScheduleViewModel.Data.cs:1121`, `:1234`, `:1388`, `:1687`; `PitScheduleViewModel.Filters.cs:316`; `PitScheduleViewModel.Schedule.cs:52`, `:116`, `:817`, `:923`: the Pit Schedule window. It is opened by a command that picks up the drawing's data first, and it must be closed before another drawing can be brought forward.

## B. Changes something, then asks for a save, after picking up the drawing's data in the same routine: 6 places

1. `Commands/LinkCommands.ImportXcivil.cs:580` (CDEXPORTCORPUS).
2. `Commands/LinkCommands.cs:252` (CDREBUILD).
3. `Services/LinkService.PitCoverText.cs:167`: binds first.
4. `Services/LinkService.PitRelinks.cs:347`: attaches first.
5. `Services/XcivilImportService.cs:1384` and `:1407`: after the record update for the target drawing, which makes the record that drawing's first.

## C. Changes something directly, then asks for a save, with nothing in the same routine picking up the drawing's data: 5 places

Each was followed back to the tools that reach it.

1. `Commands/PitEditCommand.cs:1907` (renames a pit in the pipes that name it; edits pipe ends directly). Reached only from Edit Pit, which attaches at its start. **Safe by its caller.**
2. `Services/LinkService.TidyPitText.cs:74` (CDTIDYLABELS). The command does not attach, but every change it makes goes through the pit cover text mover, which binds the record to the drawing first. **Safe by the routine it calls.**
3. `Services/LinkService.RepairAudit.InvertPropagation.cs:836` and `:972` (the level cascade; edits the anchor pit's level directly). Reached from CDPROPAGATE (attaches first), Edit Pipe (attaches first), and the proposals route below.
4. `Services/ProposalApplyService.cs:885` (pit-only proposal changes; edits a pit's remarks or level directly). Reached from the proposals route below.
5. **The proposals route** (`ProposalApplyService.Apply`): from CDRUNSOLVE (attaches first) and from the Dashboard (its command attaches first, and the window checks it holds this drawing's data). **Not fully traced:** the two Project Review windows and the CE Assistant panel. The Assistant checks that the drawing in front is the one the proposal was reviewed for; I did not confirm that CE's record is that drawing's at that moment. If it were not: the pipe changes go through checked routines and are refused (2083); the whole-record write is refused (2089); the two direct edits look the pit up by its object number in the record CE holds, so with another drawing's record they find nothing, except by a chance match of numbers.

## Also read on the way

1. **CDRULES and its approved fix** do not use the record in memory at all: they read the drawing's own stored record, change a copy of that, and write it back. Safe, and not affected by the four drafts.
2. **CDTIDYLABELS and CDRULES never attach the record themselves.** That is the same shape Help and CD Settings had, but neither is on the list of commands whose end writes the record, and neither changes the record in memory except through routines that bind first.

## What this audit did NOT do

1. It started from the 36 save requests. A direct edit of a pit or pipe taken from the record that is NOT followed by a save request in the same routine was not searched for.
2. The Project Review windows and the CE Assistant panel were not traced to a proof that the record is the drawing's own when they apply.
3. No guard was written. One could be: on the compiled plugin, list every routine outside the record service that asks for a save or edits a record object, and require each to be on a reviewed list with the reason it is safe, so a new one fails the build until someone looks. That is a test only, about half a day, and needs the controller's word.

## D. The batch-edit write, and the two routes into it that had not been traced (added 11:45, for the controller's item of 11:25)

The review of the three BUG-1456 drafts together named one gap: the batch-edit write (`Services/CeBatchEditApplyCoordinator.cs` about 197 to 198) puts a copy of CE's record into a drawing with no owner check, and the CE Assistant and CDRULES routes into it were not traced. Both are traced now, by reading, and the gap is closed by its own small draft.

1. **The gap is closed by draft pull request 2089** (`claude/bug-1456c-snapshot-write-door`, head `e938d0d4`, on 2083's branch, no switch): the copy the batch edit writes now remembers which drawing's record it was taken from, and the one routine that writes it, and the one that then makes it the live record, refuse another drawing's copy. Core console: `CEPROOFCROSSCOPY` PASS (evidence lane, about 09:35).
2. **Who reaches the batch-edit write (two doors in):**
   1. The pit batch of CDEDIT (`Commands/PitEditCommand.Batch.cs:612`) and the pipe batch of CDEDIT (`Commands/PipeEditCommand.Batch.cs:1074`, through `Services/PipeBatchWriteService.cs:57`). Both are reached only through the Hub's routing, which attaches the record to the drawing first.
   2. Pipe size changes from a proposal (`Services/PipeSizeWriteService.cs:460`), reached from `ProposalApplyService.Apply` (lines 665 to 697).
3. **The CDRULES route does NOT reach the batch-edit write.** CDRULES reads the drawing's own stored record, and its approved fix changes a copy of THAT and writes it back (`ProposalApplyService.ApplyApprovedRuleFix`, line 208 on). It never uses the record in memory, so it cannot carry another drawing's record. Safe before and after the drafts.
4. **The CE Assistant route does reach it, and never attaches the record itself.** The panel (`Controls/CeAssistantControl.xaml.cs` about 610) calls `CeAiProposalApplyCoordinator.Apply`, which calls `ProposalApplyService.Apply`, which for a size change calls `PipeSizeWriteService.Write`, which calls the batch-edit write. Nothing on that route attaches CE's record to the drawing (searched the panel, its panel service, the coordinator, the size writer and the batch writer: no attach, no bind, no check that the record is this drawing's). What stands in the way:
   1. The panel refuses unless the drawing in front is the one the proposal was reviewed for, and the size writer refuses unless that drawing is the one in front (`PipeSizeWriteService.cs` about 396).
   2. The size writer looks each pipe up, by its object number, in the record CE holds (line 415). With another drawing's record in memory the pipe is not found and the whole write is refused with "Nothing was changed", unless the same object number happens to name a pipe in both jobs.
   3. Only in that chance case would the installed build go on to write a copy of the other job's whole record into this drawing. With 2083 the per-pipe changes are refused; with 2089 the whole-record write is refused and the copy is not adopted.
5. **The two Project Review windows** are opened from the Dashboard, whose command attaches the record first and whose window checks it holds this drawing's record (`ViewModels/DesignCheckDashboardViewModel.cs:206`). Same size-writer protections as above.
6. **So, for today's install trial:** with 2073 and 2083 only (State A), the one remaining way through is the CE Assistant applying a pipe-size proposal as the first CE action in a second drawing, AND an object number matching a pipe in the other job. Pipe size proposals are also off by default (`DesignStandards.PipeSizeProposalsEnabled`). 2089 closes it; whether 2089 joins State A is the controller's call.
