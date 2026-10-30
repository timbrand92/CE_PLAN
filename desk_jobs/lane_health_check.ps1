$now = Get-Date
"now " + $now.ToString('HH:mm')
$rows = @()
foreach ($p in Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh|powershell' -and $_.CommandLine -match '\.ps1' }) {
  $m = [regex]::Match($p.CommandLine, '([A-Za-z]:\\[^''" ]+\.ps1)')
  if (-not $m.Success) { continue }
  $sc = $m.Groups[1].Value
  $base = [IO.Path]::GetFileNameWithoutExtension($sc)
  $d = Split-Path $sc
  $logs = @(Get-ChildItem $d -Filter "$base*.log" -ErrorAction SilentlyContinue)
  $logs += @(Get-ChildItem $d -Filter "$base*.txt" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'log|out' })
  $latest = $logs | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $age = if ($latest) { [int]($now - $latest.LastWriteTime).TotalMinutes } else { -1 }
  $kids = @(Get-CimInstance Win32_Process -Filter ("ParentProcessId=" + $p.ProcessId) | Where-Object { $_.Name -notmatch 'conhost' }).Count
  $rows += ('{0,6}  {1,-30} started {2:ddd HH:mm}  own log: {3,-28} last write {4,5} min ago  children {5}' -f $p.ProcessId, $base, $p.CreationDate, $(if ($latest) { $latest.Name } else { 'none' }), $age, $kids)
}
$rows | Sort-Object
