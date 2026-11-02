# CE 02 Tue 3 Nov 2026 (CE 00 order 06:45, Tim "clean up c drive"): zips logs_start and logs_end inside Codex look folders older than 3 days whose report exists and whose look id is named in the ledger/desk log. Verifies each zip (file count and total bytes) before the original folder is removed. Screenshots, exports and reports are never touched. Runs at idle priority after batchN7_codex.ps1 has ended. Not a build script.
Add-Type -AssemblyName System.IO.Compression.FileSystem
$root = 'C:\Lisp Files\_TEST_COPIES_20260923'; $looks = "$root\LOOKS"; $man = 'C:\CE_WORK\scratch\zip_looks_manifest_0303.csv'; $log = 'C:\CE_WORK\scratch\zip_looks_0303.log'
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
while (Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'batchN7_codex' }) { Start-Sleep 30 }
(Get-Process -Id $PID).PriorityClass = 'Idle'
L 'zip job starts (idle priority)'
$ledger = (Get-Content 'C:\CE_PLAN\areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md','C:\CE_PLAN\areas\release-v3-colleagues-DESK_LOG.md' -Raw -ErrorAction SilentlyContinue) -join "`n"
$cut = (Get-Date).AddDays(-3)
if (-not (Test-Path $man)) { 'folder,state,GB_before,GB_after,files' | Set-Content $man }
$freed = 0.0
foreach ($f in (Get-ChildItem $looks -Directory | Sort Name)) {
  if ($f.Name -notmatch '^([A-Za-z0-9]+)_(\d{8})_(\d{4})$') { continue }
  $id = $Matches[1]; $dt = [datetime]::ParseExact($Matches[2], 'yyyyMMdd', $null)
  if ($dt -gt $cut.Date) { continue }
  $rep = Get-ChildItem $root -Filter "CODEX_*_$($id)_$($Matches[2])_$($Matches[3]).md" -ErrorAction SilentlyContinue
  if (-not $rep) { $rep = Get-ChildItem $root -Filter "CODEX_*_$($id)_$($Matches[2])_*.md" -ErrorAction SilentlyContinue }
  $inLedger = $ledger -match [regex]::Escape($id)
  if (-not $rep -or -not $inLedger) { "$($f.Name),SKIPPED (report=$([bool]$rep) ledger=$inLedger),,," | Add-Content $man; L "$($f.Name) skipped"; continue }
  foreach ($sub in 'logs_start', 'logs_end') {
    $src = Join-Path $f.FullName $sub; $zip = Join-Path $f.FullName "$sub.zip"
    if (-not (Test-Path $src)) { continue }
    try {
      $files = @(Get-ChildItem $src -Recurse -File -Force); $bytes = ($files | Measure-Object Length -Sum).Sum; $before = $bytes / 1GB
      if (Test-Path $zip) { Remove-Item $zip -Force }
      [IO.Compression.ZipFile]::CreateFromDirectory($src, $zip, [IO.Compression.CompressionLevel]::Optimal, $false)
      $za = [IO.Compression.ZipFile]::OpenRead($zip); $ents = @($za.Entries | Where-Object { $_.Name -ne '' }); $zn = $ents.Count; $zb = ($ents | Measure-Object Length -Sum).Sum; $za.Dispose()
      if ($zn -ne $files.Count -or $zb -ne $bytes) { Remove-Item $zip -Force; "$($f.Name)/$sub,VERIFY FAILED (files $($files.Count) vs $zn),$([math]::Round($before,3)),,$($files.Count)" | Add-Content $man; L "$($f.Name)/$sub verify failed: zip removed, original kept"; continue }
      $after = (Get-Item $zip).Length / 1GB
      Remove-Item $src -Recurse -Force
      $freed += ($before - $after)
      "$($f.Name)/$sub,zipped,$([math]::Round($before,3)),$([math]::Round($after,3)),$($files.Count)" | Add-Content $man
      L "$($f.Name)/$sub zipped: $([math]::Round($before,3)) GB -> $([math]::Round($after,3)) GB"
    } catch { L "$($f.Name)/$sub error: $($_.Exception.Message): original kept"; if (Test-Path $zip) { Remove-Item $zip -Force -ErrorAction SilentlyContinue } }
  }
}
L "zip job ends; freed $([math]::Round($freed,2)) GB; C: free $([math]::Round((Get-PSDrive C).Free/1GB,1)) GB"
