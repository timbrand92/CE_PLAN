# CE 02 Fri 30 Oct 2026: build a rerun spec for the cases that came back BLOCKED in pass a of the C-77 full set (BLOCKED is never a result). Each blocked case gets its own AutoCAD start (one case per pack) so one case cannot leave a command active for the next. Output: C:\ce-fx\retest\spec_c77_blocked_rerun.txt. Usage: pwsh -NoProfile -File make_blocked_rerun.ps1 [-Pass a|b]
param([string]$Pass = 'a')
$week = @{}; foreach ($l in Get-Content C:\ce-fx\retest\spec_full_weekend.txt) { if ($l -match '\|' -and $l -notmatch '^x') { $p = $l -split '\|'; foreach ($c in ($p[2] -split ',')) { $week[$c] = $p[1] } } }
$blocked = New-Object System.Collections.Generic.List[string]
foreach ($f in Get-ChildItem C:\ce-fx\c75regrade3 -File | Where-Object { $_.Name -cmatch "^($Pass)(L|F\d|V)\.txt$" -and $_.LastWriteTime -gt [datetime]'2026-10-30 14:30' }) {
  foreach ($x in Get-Content $f.FullName) { if ($x -match '^\s+(\S+)\s+BLOCKED\s') { $blocked.Add($Matches[1]) } } }
$passed = New-Object System.Collections.Generic.List[string]
$out = @("# spec_c77_blocked_rerun.txt (built $(Get-Date -Format 'HH:mm')): one case per start for the cases BLOCKED in pass $Pass of the C-77 full set.")
$i = 0; foreach ($c in ($blocked | Select-Object -Unique)) { if ($week.ContainsKey($c)) { $i++; $out += ("r{0}{1:D2}|{2}|{3}" -f $Pass,$i,$week[$c],$c) } }
[IO.File]::WriteAllLines('C:\ce-fx\retest\spec_c77_blocked_rerun.txt', $out, (New-Object Text.UTF8Encoding($false)))
"blocked cases queued for rerun: $i"