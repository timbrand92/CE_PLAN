$root = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins'
foreach ($n in 'CE_CVL_SUITE','CE_SUITE_MANAGER','CE_STRUC_SUITE') {
  foreach ($lane in 'Legacy','Net8','Modern') {
    $p = Join-Path $root "$n.bundle\Contents\Win64\$lane\$n.dll"
    if (Test-Path $p) {
      $v = (Get-Item $p).VersionInfo.ProductVersion
      $h = (Get-FileHash $p -Algorithm SHA256).Hash.Substring(0,12)
      "{0,-18} {1,-7} {2,-40} {3}" -f $n,$lane,$v,$h
    } else { "{0,-18} {1,-7} MISSING" -f $n,$lane }
  }
}
$d = Get-PSDrive C
"C: free GB = {0:N1}" -f ($d.Free/1GB)
