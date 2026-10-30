# Closed-window notice file (CE 00 request 14:26, 30 Oct 2026; CE 01 writes it)

At the 10-minute notice of EVERY closed AutoCAD window (payload final steps, install), CE 01 writes ONE line to
C:\CE_PLAN\desk_jobs\CLOSED_WINDOW_NOTICE.txt : the closed time as `yyyy-MM-dd HH:mm` (PC clock, Melbourne), for example `2026-10-30 22:10`.
CE 02's chain, the Codex conveyor and the watchdog read it: no pack that cannot end before that time, no Codex look unless it can end 20 minutes before it,
no filler within 25 minutes of it. After "C-77 installed, DLLs re-read" (or the next install) CE 01 deletes the file so testing restarts.
Today's stop-by-pid ("CLOSED NOW" message) stays the fallback if the notice is skipped.
Next closed window: C-78 (tonight, Civil 3.0.88 / Manager 1.1.88): write the line when the C-78 payload reports it is about to start its pin run.
