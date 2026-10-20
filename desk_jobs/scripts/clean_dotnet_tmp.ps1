# Remove leftover .NET workload-manifest extraction folders in the user Temp (each build job leaves ~5.5 GB; they hold Android.Manifest-*, Emsdk.*.Manifest-* folders). Only folders older than 10 minutes that contain an Android.Manifest-* subfolder.
$t = Join-Path $env:LOCALAPPDATA 'Temp'
$before = (Get-PSDrive C).Free / 1GB
$n = 0
foreach ($d in Get-ChildItem $t -Directory -Force -ErrorAction SilentlyContinue) {
  if ($d.LastWriteTime -lt (Get-Date).AddMinutes(-10) -and (Get-ChildItem $d.FullName -Directory -Filter 'Android.Manifest-*' -ErrorAction SilentlyContinue | Select-Object -First 1)) {
    Remove-Item $d.FullName -Recurse -Force -ErrorAction SilentlyContinue; $n++
  }
}
'cleaned {0} dotnet temp folders; C: free GB before {1:N1} after {2:N1}' -f $n, $before, ((Get-PSDrive C).Free / 1GB)
