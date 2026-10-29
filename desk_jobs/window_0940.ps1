# CE 02 Fri 30 Oct 2026 06:40: the planned C-77 payload and install window (agreed with CE 01). 08:25: stop starting new Codex looks (a look needs about 75 minutes); 09:40: AutoCAD may be idle until 12:15 (ACAD_IDLE_OK.txt makes the watchdog treat it as allowed). The chain started by wait_install_then_run.ps1 takes over when the install lands; if C-77 slips, the watchdog releases the flag once ACAD_IDLE_OK.txt expires.
$d = 'C:\CE_PLAN\desk_jobs'; $log = 'C:\ce-fx\c75regrade3\window_0940.log'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function WaitUntil([datetime]$t) { while ((Get-Date) -lt $t) { Start-Sleep 20 } }
$day = (Get-Date).Date
WaitUntil $day.AddHours(8).AddMinutes(25)
[IO.File]::WriteAllText("$d\STOP_CODEX.flag", "CE 02 window $(Get-Date -Format 'HH:mm') Fri 30 Oct: no new Codex look starts after 08:25 so AutoCAD is free for CE 01's payload final steps (09:45) and the C-77 install (about 11:00). Released by wait_install_then_run.ps1 or by the watchdog after 12:15.`n")
L 'STOP_CODEX.flag placed (08:25)'
WaitUntil $day.AddHours(9).AddMinutes(40)
[IO.File]::WriteAllText("$d\ACAD_IDLE_OK.txt", "until $($day.ToString('yyyy-MM-dd')) 12:15`nCE 01 C-77 payload final steps (09:45) and install (about 11:00 to 12:00); AutoCAD and accoreconsole must be closed`n")
L 'ACAD_IDLE_OK.txt written until 12:15'
$a = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue)
if ($a.Count) { L ("AutoCAD still running at 09:40: " + (($a | ForEach-Object { "$($_.Name) $($_.Id) started $($_.StartTime.ToString('HH:mm'))" }) -join '; ') + " (a Codex look overran; not killed here, CE 01 and CE 02 decide)") }