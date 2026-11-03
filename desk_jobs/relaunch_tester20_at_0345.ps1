$tz=[TimeZoneInfo]::FindSystemTimeZoneById('AUS Eastern Standard Time')
$n=[TimeZoneInfo]::ConvertTime((Get-Date),$tz); $t=$n.Date.AddHours(3).AddMinutes(45); if($t -le $n){$t=$t.AddDays(1)}
Start-Sleep -Seconds ([int](($t-$n).TotalSeconds))
for($i=0;$i -lt 6;$i++){ if(-not (Get-Process acad -EA SilentlyContinue)){ & pwsh -NoProfile -File 'C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-acad-tim-desk-d44f6a\d6e0ff91-5f8e-4486-a3dc-c3a8f5052d5a\scratchpad\launch_tester20.ps1'; break }; Start-Sleep 600 }
