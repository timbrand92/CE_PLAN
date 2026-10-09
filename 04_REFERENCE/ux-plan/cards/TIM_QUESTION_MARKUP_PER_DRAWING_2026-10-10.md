# Tim: one question, which drawing does a loaded markup belong to? (10 Oct 2026, Structural build run 129)

Answer by letter, e.g. "a". Builders go on the **Rec** (a) until you say otherwise (INT-073). Raised by the Opus review of PR #957 (markup check list).

**The problem, in drawing terms.** Today CE keeps ONE loaded markup for the whole AutoCAD session. Example: you read the markup PDF while
S01 is in front, switch to S02, and run the markup check: CE says "markup loaded for this drawing" but it is S01's markup. Nothing is
changed in either drawing; the list would just be about the wrong job.

1. **Where should the loaded markup be remembered?**
   - **a (Rec): per drawing, in memory only.** Each open drawing has its own loaded markup; switching drawings never mixes them; closing AutoCAD forgets it (you read the PDF again). Nothing is written into the drawing file.
   - **b: per drawing, saved inside the drawing file.** Survives closing and reopening; adds data to the DWG (a changed file leaves a trace, and a colleague opening it sees the markup record).
   - **c: leave as it is, but say the drawing name.** CE says "markup loaded from S01 (this is S02)" and asks before checking. Smallest change, still one markup at a time.
