#requires -Version 5.1
<#
Desk-only clean-PC rehearsal. Default is read-only inspection, never installation.
Prepare writes a NEW, minimal input folder; it does not open Windows Sandbox.
Guest runs only as WDAGUtilityAccount with the supplied read-only Sandbox mapping.
See areas/CODEX_BUILD_SANDBOX_INSTALL_22OCT.md before use. No downloads or feature changes.
#>
[CmdletBinding()]
param(
    [ValidateSet('Inspect','Prepare','Guest','SelfTest')][string]$Mode = 'Inspect',
    [string]$CandidateRoot = 'C:\ce_rc_scratch\c1056',
    [string]$InstallerPath,
    [string]$InstallerSha256,
    [string]$ReleaseEvidenceRoot,
    [string]$DefaultsPath,
    [string]$InputRoot = 'C:\ce-sandbox\input'
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$script:Checks = New-Object 'System.Collections.Generic.List[object]'
$script:Pins = @{
    'CE_CVL_SUITE.bundle' = @{ Version='3.0.70'; Count=828; Hash='2399820EC49ED1661B42C138A1D33B7C0BF6F861E9BB2D735BCEEB61BE5766D5' }
    'CE_SUITE_MANAGER.bundle' = @{ Version='1.1.70'; Count=75; Hash='404D31A017A2CE139A2F14DB78AF96271442B58A0940B30D97B4F3F4647E6C23' }
}
function Assert-That([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Hash-Bytes([byte[]]$Bytes) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return [BitConverter]::ToString($sha.ComputeHash($Bytes)).Replace('-','') } finally { $sha.Dispose() }
}
function Hash-File([string]$Path) { (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash }
function Safe-Child([string]$Root, [string]$Relative) {
    Assert-That (-not [IO.Path]::IsPathRooted($Relative) -and $Relative -notmatch '[:\x00]') "Unsafe package path: $Relative"
    Assert-That (@($Relative.Replace('\','/').Split('/') | Where-Object { $_ -in @('.','..') -or $_ -match '[. ]$' }).Count -eq 0) "Ambiguous package path: $Relative"
    $base = [IO.Path]::GetFullPath($Root).TrimEnd('\') + '\'
    $full = [IO.Path]::GetFullPath((Join-Path $base $Relative))
    Assert-That ($full.StartsWith($base,[StringComparison]::OrdinalIgnoreCase)) "Path leaves its test folder: $Relative"
    return $full
}
function Tree-Files([string]$Root) {
    $rootItem = Get-Item -LiteralPath $Root
    Assert-That (($rootItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) 'Linked bundle root refused.'
    $items = @(Get-ChildItem -LiteralPath $Root -Recurse -Force)
    Assert-That (@($items | Where-Object { ($_.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 }).Count -eq 0) 'Linked bundle content refused.'
    $map = @{}
    foreach ($f in @($items | Where-Object { -not $_.PSIsContainer })) {
        $rel = $f.FullName.Substring($rootItem.FullName.TrimEnd('\').Length + 1).Replace('\','/')
        $map[$rel] = [pscustomobject]@{ RelativePath=$rel; Length=$f.Length; Sha256=(Hash-File $f.FullName) }
    }
    [string[]]$names = @($map.Keys)
    [Array]::Sort($names,[StringComparer]::OrdinalIgnoreCase)
    foreach ($n in $names) { $map[$n] }
}
function Tree-Hash([object[]]$Files) {
    $lines = @($Files | ForEach-Object { '{0}|{1}|{2}' -f $_.RelativePath,$_.Length,$_.Sha256 })
    Hash-Bytes ([Text.Encoding]::UTF8.GetBytes([string]::Join("`n",[string[]]$lines)))
}
function Check-Layout([string]$Bundle) {
    $xml = New-Object Xml.XmlDocument
    $xml.XmlResolver = $null
    $xml.Load((Join-Path $Bundle 'PackageContents.xml'))
    $entries = @($xml.SelectNodes('//Components/ComponentEntry'))
    Assert-That ($entries.Count -gt 0) 'No AutoCAD loading entries.'
    foreach ($entry in $entries) {
        $module = $entry.GetAttribute('ModuleName') -replace '^\./',''
        $path = Safe-Child $Bundle $module
        Assert-That (Test-Path -LiteralPath $path -PathType Leaf) "AutoCAD loading file missing: $path"
    }
    # Manifest series, not installed AutoCAD registry keys, determine each lane.
    $expected = @(@('R24.1','R24.9','Legacy'),@('R25.0','R25.9','Net8'),@('R26.0','R27.0','Modern'))
    foreach ($lane in $expected) {
        $matches = @($entries | Where-Object {
            $_.GetAttribute('ModuleName') -match ('/Win64/'+$lane[2]+'/[^/]+\.dll$') -and
            $_.ParentNode.RuntimeRequirements.SeriesMin -eq $lane[0] -and
            $_.ParentNode.RuntimeRequirements.SeriesMax -eq $lane[1]
        })
        Assert-That ($matches.Count -eq 1) "Wrong or absent AutoCAD lane: $($lane[2])"
    }
    return $xml.DocumentElement.GetAttribute('AppVersion')
}
function Check-Candidates([string]$Root) {
    $top = @(Get-ChildItem -LiteralPath $Root -Force)
    Assert-That ($top.Count -eq 2) 'Package must contain exactly Civil and Manager bundles.'
    foreach ($name in @($script:Pins.Keys | Sort-Object)) {
        $bundle = Safe-Child $Root $name
        $files = @(Tree-Files $bundle)
        $hash = Tree-Hash $files
        $pin = $script:Pins[$name]
        Assert-That ($files.Count -eq $pin.Count -and $hash -eq $pin.Hash) "Candidate changed: $name ($($files.Count) files, $hash). Stop for a new approved fingerprint."
        Assert-That ((Check-Layout $bundle) -eq $pin.Version) "Wrong version: $name"
        [pscustomobject]@{ Bundle=$name; Version=$pin.Version; Files=$files.Count; Sha256=$hash }
    }
}
function Load-PayloadReader {
    if ('CeDryRunPayload' -as [type]) { return }
    # Reads bytes only: never loads or executes the installer assembly.
    # .NET bundle format: dotnet/runtime HostModel Bundle/{Bundler,Manifest,FileEntry}.cs.
    Add-Type -TypeDefinition @'
using System;
using System.IO;
using System.IO.Compression;
using System.Collections.Generic;
public static class CeDryRunPayload {
  static void Need(bool b, string m) { if (!b) throw new InvalidDataException(m); }
  static int Rva(byte[] pe, uint rva) {
    int p=BitConverter.ToInt32(pe,0x3c), count=BitConverter.ToUInt16(pe,p+6);
    int section=p+24+BitConverter.ToUInt16(pe,p+20);
    for(int i=0;i<count;i++,section+=40) {
      uint va=BitConverter.ToUInt32(pe,section+12), size=BitConverter.ToUInt32(pe,section+16);
      if(rva>=va && (ulong)rva<(ulong)va+size)
        return checked((int)(rva-va+BitConverter.ToUInt32(pe,section+20)));
    }
    throw new InvalidDataException("Managed resource address is outside the assembly.");
  }
  public static byte[] ResourceZip(byte[] pe) {
    int p=BitConverter.ToInt32(pe,0x3c), opt=p+24;
    int directories=opt+(BitConverter.ToUInt16(pe,opt)==0x20b?112:96);
    int cli=Rva(pe,BitConverter.ToUInt32(pe,directories+14*8));
    int start=Rva(pe,BitConverter.ToUInt32(pe,cli+24));
    int size=checked((int)BitConverter.ToUInt32(pe,cli+28));
    Need(start>=0 && size>0 && (long)start+size<=pe.Length,"No bounded managed resources.");
    var found=new List<byte[]>();
    // CLI resources are length-prefixed and aligned to 8 bytes. Search within
    // this directory only; a ZIP merely appended to an EXE is not evidence.
    for(int i=start;i+8<=start+size;i++) {
      if(pe[i+4]!=0x50 || pe[i+5]!=0x4b || pe[i+6]!=3 || pe[i+7]!=4) continue;
      int n=BitConverter.ToInt32(pe,i);
      if(n<=0 || (long)i+4+n>start+size) continue;
      byte[] zip=new byte[n]; Buffer.BlockCopy(pe,i+4,zip,0,n); found.Add(zip);
    }
    Need(found.Count==1,"Expected exactly one ZIP in the installer's managed resources.");
    return found[0];
  }
  public static byte[] Read(string path) {
    byte[] exe=File.ReadAllBytes(path);
    byte[] marker={0x8b,0x12,0x02,0xb9,0x6a,0x61,0x20,0x38,0x72,0x7b,0x93,0x02,0x14,0xd7,0xa0,0x32,0x13,0xf5,0xb9,0xe6,0xef,0xae,0x33,0x18,0xee,0x3b,0x2d,0xce,0x24,0xb3,0x6a,0xae};
    long header=0; int markers=0;
    for(int i=8;i<=exe.Length-marker.Length;i++) {
      if(exe[i]!=marker[0]) continue;
      int k=1; while(k<marker.Length && exe[i+k]==marker[k]) k++;
      if(k==marker.Length) { header=BitConverter.ToInt64(exe,i-8); markers++; }
    }
    Need(markers==1 && header>0 && header<exe.Length,"Not a supported .NET single-file installer.");
    using(var r=new BinaryReader(new MemoryStream(exe))) {
      r.BaseStream.Position=header;
      uint major=r.ReadUInt32(); r.ReadUInt32(); int count=r.ReadInt32(); r.ReadString();
      Need((major==2 || major==6) && count>0 && count<10000,"Unsupported bundle header.");
      r.BaseStream.Position+=40;
      byte[] assembly=null;
      for(int i=0;i<count;i++) {
        long offset=r.ReadInt64(), size=r.ReadInt64(), compressed=major>=6?r.ReadInt64():0;
        byte type=r.ReadByte(); string name=r.ReadString();
        if(name!="CE_CVL_SUITE_Installer.dll") continue;
        Need(assembly==null && type==1 && size>0 && size<536870912,"Invalid installer assembly entry.");
        long stored=compressed>0?compressed:size;
        Need(offset>=0 && stored>0 && offset<=exe.Length-stored,"Assembly is outside its EXE.");
        using(var s=new MemoryStream(exe,(int)offset,(int)stored)) {
          if(compressed>0) using(var d=new DeflateStream(s,CompressionMode.Decompress))
            using(var dest=new MemoryStream()) { d.CopyTo(dest); assembly=dest.ToArray(); }
          else { assembly=new byte[(int)size]; s.Read(assembly,0,assembly.Length); }
        }
        Need(assembly.LongLength==size,"Wrong expanded assembly length.");
      }
      Need(assembly!=null,"Installer assembly is not embedded.");
      return ResourceZip(assembly);
    }
  }
}
'@
}
function Expand-Payload([byte[]]$Bytes, [string]$Destination) {
    Add-Type -AssemblyName System.IO.Compression
    $stream = New-Object IO.MemoryStream(,$Bytes)
    $zip = New-Object IO.Compression.ZipArchive($stream,([IO.Compression.ZipArchiveMode]::Read))
    try {
        $seen = @{}; $total = 0L
        foreach ($e in $zip.Entries) {
            $name = $e.FullName.Replace('\','/')
            Assert-That (-not $seen.ContainsKey($name)) "Duplicate ZIP path: $name"
            $seen[$name] = $true
            $dest = Safe-Child $Destination $name
            Assert-That ($name -match '^(CE_CVL_SUITE|CE_SUITE_MANAGER)\.bundle/') "Unexpected payload entry: $name"
            $total += $e.Length
            Assert-That ($total -lt 2GB) 'Payload is unexpectedly large.'
            if ($name.EndsWith('/')) { continue }
            [IO.Directory]::CreateDirectory((Split-Path -Parent $dest)) | Out-Null
            $src=$e.Open(); $out=[IO.File]::Create($dest)
            try { $src.CopyTo($out) } finally { $out.Dispose(); $src.Dispose() }
        }
    } finally { $zip.Dispose(); $stream.Dispose() }
}
function Same-Json($A, $B) {
    # Compare the complete JSON tree, including false/null, keys and array order.
    if ($null -eq $A -or $null -eq $B) { return ($null -eq $A -and $null -eq $B) }
    if ($A -is [pscustomobject] -and $B -is [pscustomobject]) {
        [string[]]$ak=@($A.PSObject.Properties.Name | Sort-Object)
        [string[]]$bk=@($B.PSObject.Properties.Name | Sort-Object)
        if (($ak -join '|') -cne ($bk -join '|')) { return $false }
        foreach ($k in $ak) { if (-not (Same-Json $A.$k $B.$k)) { return $false } }
        return $true
    }
    if ($A -is [array] -and $B -is [array]) {
        if ($A.Count -ne $B.Count) { return $false }
        for ($i=0;$i -lt $A.Count;$i++) { if (-not (Same-Json $A[$i] $B[$i])) { return $false } }
        return $true
    }
    return (($A | ConvertTo-Json -Compress -Depth 100) -ceq ($B | ConvertTo-Json -Compress -Depth 100))
}
function Check-DefaultsContract($Contract) {
    Assert-That ($Contract.SourceCommit -eq '40ee0a36f7960145743954b39859eb6c3af92869') 'Defaults need a reviewed source commit, not a copy of personal settings.'
    Assert-That ($Contract.CivilVersion -eq '3.0.70' -and $Contract.ManagerVersion -eq '1.1.70') 'Defaults contract has wrong versions.'
    Assert-That (@($Contract.Files).Count -ge 2) 'Supply reviewed Civil and Manager default files.'
    $seen=@{}
    foreach ($f in $Contract.Files) {
        $null=Safe-Child 'C:\FakeAppData' $f.RelativePath
        Assert-That (-not $seen.ContainsKey($f.RelativePath)) 'Repeated settings file.'
        $seen[$f.RelativePath]=$true
        Assert-That ($f.Format -in @('Json','Xml')) 'Settings format must be Json or Xml.'
        Assert-That (-not [string]::IsNullOrWhiteSpace($f.ExpectedText)) 'Expected settings must not be blank.'
        if ($f.Format -eq 'Json') { $null=$f.ExpectedText | ConvertFrom-Json }
        else { $null=[xml]$f.ExpectedText }
    }
    Assert-That ($seen.ContainsKey('TIM_CE_CADTOOLS\CD_Settings.json')) 'Civil default file missing from contract.'
    Assert-That ($seen.ContainsKey('Creative Engineering\CE Suite Manager\ce-blocks-settings.xml')) 'Manager default file missing from contract.'
}
function Guest-Guard {
    Assert-That ($env:USERNAME -eq 'WDAGUtilityAccount' -and $env:USERPROFILE -eq 'C:\Users\WDAGUtilityAccount') 'Installation is allowed only in the Windows Sandbox guest.'
    Assert-That ($PSScriptRoot -eq 'C:\CE_DryRun_Input') 'Run only through the supplied Sandbox mapping.'
    Assert-That (Test-Path 'C:\CE_DryRun_Input\input.json' -PathType Leaf) 'Prepared input record is missing.'
    foreach ($p in @('C:\TimOS','C:\CE_PLAN','C:\Lisp Files')) {
        Assert-That (-not (Test-Path -LiteralPath $p)) "Host folder visible: $p"
    }
    Assert-That (-not (Get-Process acad,accoreconsole -ErrorAction SilentlyContinue)) 'AutoCAD must remain closed.'
    $identity=[Security.Principal.WindowsIdentity]::GetCurrent()
    $principal=New-Object Security.Principal.WindowsPrincipal($identity)
    Assert-That ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 'Inside Sandbox only: open Windows PowerShell as administrator and rerun C:\CE_DryRun_Input\clean_pc_install_dryrun.ps1 -Mode Guest. The installer requires administrator rights.'
}
function Record-Check([string]$Name, [scriptblock]$Action) {
    try { & $Action | Out-Null; $status='PASS'; $detail='Checked.' }
    catch { $status='FAIL'; $detail=$_.Exception.Message }
    $script:Checks.Add([pscustomobject]@{ Check=$Name; Status=$status; Detail=$detail })
    Write-Host "$status - $Name - $detail"
}
function Save-Json($Value, [string]$Path) {
    [IO.File]::WriteAllText($Path,($Value | ConvertTo-Json -Depth 100),[Text.UTF8Encoding]::new($false))
}
function Invoke-Installer([string]$Stage, [string]$Target, [string]$Label, [string]$Approved='') {
    $args=@('--activate-staged',"--stage-record=$Stage","--target=$Target",'--rollback-root=C:\CE_DryRun\rollback',"--result-root=C:\CE_DryRun\attempts\$Label")
    if ($Approved) { $args += "--approved-version=$Approved" }
    $psi=New-Object Diagnostics.ProcessStartInfo
    $psi.FileName='C:\CE_DryRun\installer.exe'
    # Every generated argument is checked, then quoted as one Windows argument.
    foreach ($arg in $args) { Assert-That ($arg -notmatch '["\r\n]') 'Unsafe installer argument.' }
    $psi.Arguments=($args | ForEach-Object { '"'+$_+'"' }) -join ' '
    $psi.UseShellExecute=$false; $psi.CreateNoWindow=$true
    $psi.RedirectStandardOutput=$true; $psi.RedirectStandardError=$true
    $p=New-Object Diagnostics.Process; $p.StartInfo=$psi
    $null=$p.Start()
    $stdout=$p.StandardOutput.ReadToEndAsync(); $stderr=$p.StandardError.ReadToEndAsync()
    if (-not $p.WaitForExit(120000)) { $p.Kill(); throw 'Installer timed out after 120 seconds; do not continue this rehearsal.' }
    $text=$stdout.Result+"`r`n"+$stderr.Result
    [IO.File]::WriteAllText("C:\CE_DryRun\$Label.txt",$text)
    $code=$p.ExitCode; $p.Dispose()
    return [pscustomobject]@{ Code=$code; Text=$text }
}
function Make-Stage([string]$Name, [string]$Target) {
    $folder=Join-Path 'C:\CE_DryRun\stage' $Name
    [IO.Directory]::CreateDirectory($folder) | Out-Null
    foreach ($n in @('ce-release.json','ce-release.sig')) {
        Copy-Item -LiteralPath (Join-Path "C:\CE_DryRun_Input\release\$Name" $n) -Destination (Join-Path $folder $n)
    }
    $candidate=Join-Path 'C:\CE_DryRun\payload' $Name
    $files=@(Tree-Files $candidate)
    $record=[ordered]@{ PluginId=$Name.Replace('.bundle',''); Version=$script:Pins[$Name].Version
        CandidateBundlePath=$candidate; IntendedBundlePath=$Target; CandidateContentHash=(Tree-Hash $files)
        ReleaseRecordPath=(Join-Path $folder 'ce-release.json'); ReleaseRecordSha256=(Hash-File (Join-Path $folder 'ce-release.json'))
        ReleaseSignaturePath=(Join-Path $folder 'ce-release.sig'); ReleaseSignatureSha256=(Hash-File (Join-Path $folder 'ce-release.sig'))
        RestartRequired=$true; Files=$files }
    $path=Join-Path $folder 'ce-update-stage.json'; Save-Json $record $path; return $path
}
function Snapshot-Protected {
    # Hashes plus event monitoring below. Access failures make the result incomplete, never green.
    $map=@{}
    foreach ($root in @($env:ProgramFiles,${env:ProgramFiles(x86)},$env:ProgramData)) {
        foreach ($f in @(Get-ChildItem -LiteralPath $root -Recurse -Force -File -ErrorAction Stop)) { $map[$f.FullName]=Hash-File $f.FullName }
    }
    return $map
}
function Run-Guest {
    Guest-Guard
    Assert-That (-not (Test-Path 'C:\CE_DryRun')) 'This guest is not fresh. Close it and open a new Sandbox.'
    [IO.Directory]::CreateDirectory('C:\CE_DryRun') | Out-Null
    $watchers=@(); $eventIds=@(); $before=$null
    try {
        $input=Get-Content 'C:\CE_DryRun_Input\input.json' -Raw | ConvertFrom-Json
        Assert-That ((Hash-File 'C:\CE_DryRun_Input\installer.exe') -eq $input.InstallerSha256) 'Installer fingerprint changed.'
        $defaults=Get-Content 'C:\CE_DryRun_Input\defaults.json' -Raw | ConvertFrom-Json
        Check-DefaultsContract $defaults
        Copy-Item 'C:\CE_DryRun_Input\installer.exe' 'C:\CE_DryRun\installer.exe'
        Load-PayloadReader
        Expand-Payload ([CeDryRunPayload]::Read('C:\CE_DryRun\installer.exe')) 'C:\CE_DryRun\payload'
        $null=Check-Candidates 'C:\CE_DryRun\payload'
        $scan=Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins'
        foreach ($f in $defaults.Files) { Assert-That (-not (Test-Path (Safe-Child $env:APPDATA $f.RelativePath))) 'Settings already exist; guest is not clean.' }
        foreach ($name in $script:Pins.Keys) { Assert-That (-not (Test-Path (Join-Path $scan $name))) 'Bundle already exists; guest is not clean.' }
        foreach ($root in @($env:ProgramFiles,${env:ProgramFiles(x86)},$env:ProgramData)) {
            $w=New-Object IO.FileSystemWatcher($root)
            $w.IncludeSubdirectories=$true; $w.InternalBufferSize=65536
            foreach ($eventName in @('Created','Changed','Deleted','Renamed','Error')) {
                $id='CE_DRYRUN_'+[guid]::NewGuid().ToString('N')
                $null=Register-ObjectEvent $w $eventName -SourceIdentifier $id
                $eventIds+=$id
            }
            $w.EnableRaisingEvents=$true; $watchers+=$w
        }
        Record-Check 'Protected folders can be fully read' { $script:ProtectedBefore=Snapshot-Protected }
        if ($null -ne $script:ProtectedBefore) { $before=$script:ProtectedBefore }
        foreach ($name in @($script:Pins.Keys | Sort-Object)) {
            $target=Join-Path $scan $name; $stage=Make-Stage $name $target
            $version=$script:Pins[$name].Version
            $v=[version]$version; $higher='{0}.{1}.{2}' -f $v.Major,$v.Minor,($v.Build+1)
            $id=$name.Replace('.bundle','')
            # Synthetic office approval, inside this guest only. Candidate is not altered.
            $approval=Join-Path $env:USERPROFILE "Creative Engineering\Creative Engineering - IT Admin\CE Plugin Admin\releases\$id\approved.json"
            [IO.Directory]::CreateDirectory((Split-Path $approval -Parent)) | Out-Null
            Save-Json @{ ApprovedVersion=$higher; RolloutStatus='Approved' } $approval
            Record-Check "$id refuses older than office approval (BUG-834)" {
                $r=Invoke-Installer $stage $target "$id-refused-office"
                Assert-That ($r.Code -eq 20 -and $r.Text -match 'older than version' -and -not (Test-Path $target)) "Expected refusal and plain warning, got $($r.Code): $($r.Text)"
            }
            Record-Check "$id refuses older than explicit approval (BUG-834)" {
                $r=Invoke-Installer $stage $target "$id-refused-explicit" $higher
                Assert-That ($r.Code -eq 20 -and $r.Text -match 'older than version' -and -not (Test-Path $target)) "Expected refusal, got $($r.Code): $($r.Text)"
            }
            Save-Json @{ ApprovedVersion=$version; RolloutStatus='Approved' } $approval
            Record-Check "$id clean install from embedded candidate" {
                $r=Invoke-Installer $stage $target "$id-clean"
                Assert-That ($r.Code -eq 0) "Install failed ($($r.Code)): $($r.Text)"
                Assert-That ((Tree-Hash @(Tree-Files $target)) -eq $script:Pins[$name].Hash) 'Installed files differ from embedded candidate.'
                $null=Check-Layout $target
            }
            Record-Check "$id older-than-installed warning when approval unknown" {
                Assert-That (Test-Path $target) 'Clean install failed; warning check cannot run.'
                # Change installed version only to exercise the warning branch, never signed candidate.
                $manifest=Join-Path $target 'PackageContents.xml'
                $xml=[xml](Get-Content $manifest -Raw); $xml.ApplicationPackage.AppVersion=$higher; $xml.Save($manifest)
                $oldHash=Tree-Hash @(Tree-Files $target)
                Save-Json @{ ApprovedVersion=$higher; RolloutStatus='Canary' } $approval
                $r=Invoke-Installer $stage $target "$id-warning"
                Assert-That ($r.Code -eq 0 -and $r.Text -match 'Warning:.*older than version') "Expected warning, got $($r.Code): $($r.Text)"
                $attempts=@(Get-ChildItem "C:\CE_DryRun\attempts\$id-warning" -Filter '*.json')
                Assert-That ($attempts.Count -eq 1) 'One durable install record was expected.'
                $attempt=Get-Content $attempts[0].FullName -Raw | ConvertFrom-Json
                Assert-That ($attempt.Outcome -eq 'Installed') 'No installed result record.'
                $rollback=[IO.Path]::GetFullPath($attempt.RollbackBundlePath)
                Assert-That ($rollback.StartsWith('C:\CE_DryRun\rollback\',[StringComparison]::OrdinalIgnoreCase)) 'Rollback record points outside guest rollback folder.'
                Assert-That ((Tree-Hash @(Tree-Files $rollback)) -eq $oldHash) 'Installer did not retain exact previous bytes.'
                # Documented file rollback: move new copy out of scan, restore retained old copy.
                $quarantine="C:\CE_DryRun\$id-new-off.bundle"
                Assert-That ($target.StartsWith($scan+'\',[StringComparison]::OrdinalIgnoreCase)) 'Rollback target outside guest scan folder.'
                Move-Item -LiteralPath $target -Destination $quarantine
                Move-Item -LiteralPath $rollback -Destination $target
                Assert-That ((Tree-Hash @(Tree-Files $target)) -eq $oldHash) 'File rollback did not restore previous bytes.'
                # Leave a normal candidate installed for the subsequent settings check.
                Save-Json @{ ApprovedVersion=$version; RolloutStatus='Approved' } $approval
                $r=Invoke-Installer $stage $target "$id-after-rollback"
                Assert-That ($r.Code -eq 0 -and (Tree-Hash @(Tree-Files $target)) -eq $script:Pins[$name].Hash) 'Reinstall after file rollback failed.'
            }
        }
        foreach ($f in $defaults.Files) {
            Record-Check "Settings created with reviewed defaults: $($f.RelativePath)" {
                $path=Safe-Child $env:APPDATA $f.RelativePath
                Assert-That (Test-Path -LiteralPath $path -PathType Leaf) 'Installer did not create this settings file. No AutoCAD was started.'
                $actual=Get-Content -LiteralPath $path -Raw
                Assert-That ($actual -notmatch '(?i)TimothyBrand|C:\\\\TimOS|C:\\\\Lisp Files') 'Personal host path leaked into colleague settings.'
                $expected=$f.ExpectedText.Replace('%USERPROFILE%',$env:USERPROFILE).Replace('%APPDATA%',$env:APPDATA)
                if ($f.Format -eq 'Json') { Assert-That (Same-Json ($actual | ConvertFrom-Json) ($expected | ConvertFrom-Json)) 'Settings differ from reviewed defaults.' }
                else { Assert-That (([xml]$actual).OuterXml -ceq ([xml]$expected).OuterXml) 'Settings XML differs from reviewed defaults.' }
            }
        }
        Record-Check 'Vendor uninstall command' { throw 'This installer has no uninstall command. Manual bundle removal below is separate evidence.' }
        Record-Check 'Automatic rollback after an interrupted install' { throw 'No public fault/recovery test entry point. File rollback is checked above; interruption recovery remains unproven.' }
        Record-Check 'Documented manual removal of both bundles' {
            $settingsBefore=@{}
            foreach ($f in $defaults.Files) { $p=Safe-Child $env:APPDATA $f.RelativePath; if (Test-Path $p) { $settingsBefore[$p]=Hash-File $p } }
            foreach ($name in $script:Pins.Keys) {
                $target=Join-Path $scan $name
                Assert-That (Test-Path -LiteralPath $target) "Nothing installed to remove: $name"
                $null=Safe-Child $scan $name
                Move-Item -LiteralPath $target -Destination (Join-Path 'C:\CE_DryRun' ($name+'.uninstalled'))
                foreach ($root in @($scan,(Join-Path $env:LOCALAPPDATA 'Autodesk\ApplicationPlugins'),(Join-Path $env:ProgramData 'Autodesk\ApplicationPlugins'))) {
                    Assert-That (-not (Test-Path (Join-Path $root $name))) "Bundle still enabled under $root"
                }
            }
            foreach ($p in $settingsBefore.Keys) { Assert-That ((Hash-File $p) -eq $settingsBefore[$p]) 'Manual removal changed saved settings.' }
        }
        Record-Check 'No unexplained write under Program Files or ProgramData' {
            $events=@(Get-Event | Where-Object { $_.SourceIdentifier -in $eventIds })
            $events | ForEach-Object {
                $args=$_.SourceEventArgs
                [pscustomobject]@{ Source=$_.SourceIdentifier; EventType=$args.GetType().Name; Detail=($args | Out-String) }
            } | ConvertTo-Json -Depth 5 | Set-Content 'C:\CE_DryRun\protected-events.json'
            Assert-That ($null -ne $before) 'Baseline incomplete; cannot prove protected folders unchanged.'
            $after=Snapshot-Protected
            Assert-That ($after.Count -eq $before.Count) 'Protected folder file count changed; review evidence.'
            foreach ($key in $before.Keys) { Assert-That ($after.ContainsKey($key) -and $after[$key] -eq $before[$key]) "Protected file changed: $key" }
            Assert-That ($events.Count -eq 0) 'Protected folder events occurred (including possible Windows activity or watcher errors). Review protected-events.json; no automatic allow-list.'
        }
    } catch { $script:Checks.Add([pscustomobject]@{Check='Rehearsal prerequisites';Status='FAIL';Detail=$_.Exception.Message}) }
    finally {
        foreach ($w in $watchers) { $w.Dispose() }
        foreach ($id in $eventIds) { Unregister-Event -SourceIdentifier $id; Get-Event -SourceIdentifier $id -ErrorAction SilentlyContinue | Remove-Event }
        $failed=@($script:Checks | Where-Object Status -eq 'FAIL').Count
        $result=[ordered]@{ Status=$(if ($failed) {'FAIL'} else {'PASS'}); TimeMelbourne=[TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([datetime]::UtcNow,'AUS Eastern Standard Time').ToString('o'); Passed=@($script:Checks | Where-Object Status -eq 'PASS').Count; Failed=$failed; Checks=@($script:Checks.ToArray()); AutoCADStarted=$false }
        Save-Json $result 'C:\CE_DryRun\result.json'
        # The only writable host mapping is a dedicated, empty results folder.
        $dest='C:\CE_DryRun_Results\run-'+[guid]::NewGuid().ToString('N')
        [IO.Directory]::CreateDirectory($dest) | Out-Null
        Copy-Item 'C:\CE_DryRun\*' $dest -Recurse
        Write-Host "Result: $($result.Status). $($result.Passed) passed; $failed failed. Evidence: $dest"
    }
    if ($failed) { exit 1 }
}

switch ($Mode) {
    'Inspect' {
        try { $feature=Get-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -ErrorAction Stop; Write-Host "Windows Sandbox: $($feature.State)" }
        catch { Write-Warning ('Windows Sandbox state UNKNOWN: '+$_.Exception.Message) }
        Check-Candidates $CandidateRoot | ConvertTo-Json
    }
    'Prepare' {
        Assert-That ($InstallerSha256 -match '^[A-Fa-f0-9]{64}$') 'Supply the independently approved installer SHA-256.'
        Assert-That ((Hash-File $InstallerPath) -eq $InstallerSha256) 'Installer fingerprint does not match the approved EXE.'
        $null=Check-Candidates $CandidateRoot
        $contract=Get-Content -LiteralPath $DefaultsPath -Raw | ConvertFrom-Json
        Check-DefaultsContract $contract
        foreach ($name in $script:Pins.Keys) {
            foreach ($file in @('ce-release.json','ce-release.sig')) {
                Assert-That (Test-Path -LiteralPath (Join-Path $ReleaseEvidenceRoot "$name\$file") -PathType Leaf) "Signed release input is missing: $name/$file"
            }
        }
        Assert-That (-not (Test-Path -LiteralPath $InputRoot)) 'Input folder exists. Use a new folder; never overwrite evidence.'
        Assert-That ([IO.Path]::GetFullPath($InputRoot) -eq 'C:\ce-sandbox\input') 'The supplied WSB maps only C:\ce-sandbox\input.'
        Load-PayloadReader
        $bytes=[CeDryRunPayload]::Read($InstallerPath)
        [IO.Directory]::CreateDirectory($InputRoot) | Out-Null
        $payload=Join-Path $InputRoot 'payload-verification'
        Expand-Payload $bytes $payload
        $null=Check-Candidates $payload
        foreach ($name in $script:Pins.Keys) {
            $dest=Join-Path $InputRoot "release\$name"
            [IO.Directory]::CreateDirectory($dest) | Out-Null
            foreach ($file in @('ce-release.json','ce-release.sig')) { Copy-Item -LiteralPath (Join-Path $ReleaseEvidenceRoot "$name\$file") -Destination (Join-Path $dest $file) }
        }
        Copy-Item -LiteralPath $InstallerPath -Destination (Join-Path $InputRoot 'installer.exe')
        Assert-That ((Hash-File (Join-Path $InputRoot 'installer.exe')) -eq $InstallerSha256) 'EXE changed while preparing.'
        Copy-Item -LiteralPath $PSCommandPath -Destination (Join-Path $InputRoot 'clean_pc_install_dryrun.ps1')
        Copy-Item -LiteralPath $DefaultsPath -Destination (Join-Path $InputRoot 'defaults.json')
        Save-Json @{ InstallerSha256=$InstallerSha256; SourceCommit='40ee0a36f7960145743954b39859eb6c3af92869' } (Join-Path $InputRoot 'input.json')
        [IO.Directory]::CreateDirectory('C:\ce-sandbox\results') | Out-Null
        Write-Host 'Prepared only. Windows Sandbox was not opened. Read the checklist before opening the WSB.'
    }
    'Guest' { Run-Guest }
    'SelfTest' {
        # Loaded separately below during development and retained as a desk smoke check.
        $test=Join-Path $env:TEMP ('ce-dryrun-check-'+[guid]::NewGuid().ToString('N'))
        [IO.Directory]::CreateDirectory($test) | Out-Null
        function Expect-Refusal([scriptblock]$Action) { $refused=$false; try { & $Action | Out-Null } catch { $refused=$true }; Assert-That $refused 'Unsafe input was accepted.' }
        Record-Check 'Ordinary relative path' { Assert-That ((Safe-Child $test 'a/b.txt') -eq (Join-Path (Get-Item $test).FullName 'a\b.txt')) 'Wrong resolved path.' }
        foreach ($bad in @('../escape','C:\escape','/escape','file:stream','a/../../escape','a./file','a /file')) {
            Record-Check "Refuse path $bad" { Expect-Refusal { Safe-Child $test $bad } }
        }
        Record-Check 'Full JSON accepts property order' { Assert-That (Same-Json ('{"a":false,"b":2}'|ConvertFrom-Json) ('{"b":2,"a":false}'|ConvertFrom-Json)) 'Order should not matter.' }
        Record-Check 'Full JSON refuses changed default' { Assert-That (-not (Same-Json ('{"a":false}'|ConvertFrom-Json) ('{"a":true}'|ConvertFrom-Json))) 'Changed default accepted.' }
        Record-Check 'Full JSON refuses extra field' { Assert-That (-not (Same-Json ('{"a":1}'|ConvertFrom-Json) ('{"a":1,"b":0}'|ConvertFrom-Json))) 'Extra default accepted.' }
        Record-Check 'Full JSON preserves array order' { Assert-That (-not (Same-Json @(1,2) @(2,1))) 'Array order lost.' }
        Record-Check 'Full JSON distinguishes null from false' { Assert-That (-not (Same-Json $null $false)) 'Null treated as false.' }
        Record-Check 'Guest refuses this host' { Expect-Refusal { Guest-Guard } }
        Record-Check 'Payload reader compiles in this PowerShell' { Load-PayloadReader }
        Add-Type -AssemblyName System.IO.Compression
        function Test-Zip([string[]]$Names) {
            $memory=New-Object IO.MemoryStream
            $z=New-Object IO.Compression.ZipArchive($memory,([IO.Compression.ZipArchiveMode]::Create),$true)
            foreach ($n in $Names) { $entry=$z.CreateEntry($n); $w=New-Object IO.StreamWriter($entry.Open()); $w.Write('fixture'); $w.Dispose() }
            $z.Dispose(); $bytes=$memory.ToArray(); $memory.Dispose(); return ,$bytes
        }
        # Synthetic format fixtures are never executed. No SDK or plugin build is needed.
        Add-Type -TypeDefinition @'
using System; using System.IO; using System.IO.Compression;
public static class CeDryRunFixture {
  public static byte[] Build(byte[] zip, bool compressed, uint major) {
    byte[] pe=new byte[0x304+zip.Length];
    using(var w=new BinaryWriter(new MemoryStream(pe))) {
      w.BaseStream.Position=0x3c; w.Write(0x80);
      w.BaseStream.Position=0x86; w.Write((ushort)1);
      w.BaseStream.Position=0x94; w.Write((ushort)0xf0);
      w.BaseStream.Position=0x98; w.Write((ushort)0x20b);
      w.BaseStream.Position=0x178; w.Write((uint)0x2000);
      w.BaseStream.Position=0x194; w.Write((uint)0x2000); w.Write((uint)(pe.Length-0x200)); w.Write((uint)0x200);
      w.BaseStream.Position=0x218; w.Write((uint)0x2100); w.Write(zip.Length+4);
      w.BaseStream.Position=0x300; w.Write(zip.Length); w.Write(zip);
    }
    byte[] stored=pe;
    if(compressed) using(var m=new MemoryStream()) {
      using(var d=new DeflateStream(m,CompressionLevel.Optimal,true)) d.Write(pe,0,pe.Length);
      stored=m.ToArray();
    }
    using(var m=new MemoryStream()) using(var w=new BinaryWriter(m)) {
      w.Write(new byte[128]); w.Write(stored); long header=m.Position;
      w.Write(major); w.Write((uint)0); w.Write(1); w.Write("test"); w.Write(new byte[40]);
      w.Write((long)128); w.Write((long)pe.Length); if(major>=6) w.Write(compressed?(long)stored.Length:0L);
      w.Write((byte)1); w.Write("CE_CVL_SUITE_Installer.dll");
      m.Position=24; w.Write(header);
      w.Write(new byte[]{0x8b,0x12,0x02,0xb9,0x6a,0x61,0x20,0x38,0x72,0x7b,0x93,0x02,0x14,0xd7,0xa0,0x32,0x13,0xf5,0xb9,0xe6,0xef,0xae,0x33,0x18,0xee,0x3b,0x2d,0xce,0x24,0xb3,0x6a,0xae});
      return m.ToArray();
    }
  }
}
'@
        $zipBytes=Test-Zip @('CE_CVL_SUITE.bundle/a.txt','CE_SUITE_MANAGER.bundle/b.txt')
        foreach ($compressed in @($false,$true)) {
            Record-Check "Reads embedded .NET 6-format ZIP, compressed=$compressed" {
                $path=Join-Path $test ('bundle-'+$compressed+'.exe')
                [IO.File]::WriteAllBytes($path,[CeDryRunFixture]::Build($zipBytes,$compressed,6))
                Assert-That ((Hash-Bytes ([CeDryRunPayload]::Read($path))) -eq (Hash-Bytes $zipBytes)) 'Wrong extracted ZIP.'
            }
        }
        Record-Check 'Reads embedded .NET 2-format ZIP' {
            $path=Join-Path $test 'v2.exe'; [IO.File]::WriteAllBytes($path,[CeDryRunFixture]::Build($zipBytes,$false,2))
            Assert-That ((Hash-Bytes ([CeDryRunPayload]::Read($path))) -eq (Hash-Bytes $zipBytes)) 'Wrong v2 ZIP.'
        }
        Record-Check 'Refuses unknown .NET bundle format' {
            $path=Join-Path $test 'v99.exe'; [IO.File]::WriteAllBytes($path,[CeDryRunFixture]::Build($zipBytes,$false,99))
            Expect-Refusal { [CeDryRunPayload]::Read($path) }
        }
        Record-Check 'Expands ordinary embedded bundle ZIP' {
            $dest=Join-Path $test 'expanded'; Expand-Payload $zipBytes $dest
            Assert-That ((Get-Content (Join-Path $dest 'CE_CVL_SUITE.bundle/a.txt') -Raw) -eq 'fixture') 'ZIP content changed.'
        }
        foreach ($badZip in @('CE_CVL_SUITE.bundle/../../escape.txt','CE_STRUC_SUITE.bundle/a.txt','/absolute.txt')) {
            Record-Check "ZIP refuses $badZip" { Expect-Refusal { Expand-Payload (Test-Zip @($badZip)) (Join-Path $test 'bad') } }
        }
        Record-Check 'ZIP refuses case-insensitive duplicate path' {
            Expect-Refusal { Expand-Payload (Test-Zip @('CE_CVL_SUITE.bundle/a','CE_CVL_SUITE.bundle/A')) (Join-Path $test 'duplicate') }
        }
        Record-Check 'Payload reader refuses ordinary EXE' { $path=Join-Path $test 'fake.exe'; [IO.File]::WriteAllBytes($path,(New-Object byte[] 256)); Expect-Refusal { [CeDryRunPayload]::Read($path) } }
        Record-Check 'Candidate file hash detects edits' {
            $folder=Join-Path $test 'tree'; [IO.Directory]::CreateDirectory($folder) | Out-Null
            [IO.File]::WriteAllText((Join-Path $folder 'a'),'first'); $a=Tree-Hash @(Tree-Files $folder)
            [IO.File]::WriteAllText((Join-Path $folder 'a'),'other'); Assert-That ($a -ne (Tree-Hash @(Tree-Files $folder))) 'Changed bytes missed.'
        }
        Record-Check 'Candidate set refuses an unexpected bundle' { Expect-Refusal { Check-Candidates $test } }
        Record-Check 'Defaults require independent source evidence' { Expect-Refusal { Check-DefaultsContract ([pscustomobject]@{SourceCommit='unknown'}) } }
        Save-Json @($script:Checks.ToArray()) (Join-Path $test 'selftest.json')
        $failed=@($script:Checks | Where-Object Status -eq 'FAIL').Count
        Write-Host "Self-tests: $($script:Checks.Count) total; $($script:Checks.Count-$failed) passed; $failed failed."
        Write-Host "Self-test evidence: $test"
        if ($failed) { exit 1 }
    }
}
