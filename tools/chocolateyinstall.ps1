$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://arqctb.ddns.net:8221/arq/prog/Programas/vc-ivs-bio-1.0.1.1.exe' 

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'VC IVS BIO 1.0.1.1'
  checksum      = '849AC8B3DDDC3B50AA3670A2A877C71D982F2210A32B4ABDDD6A44F53951C9E8'
  checksumType  = 'sha256' 
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" 
  validExitCodes= @(0)
  
}

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "Installvcivs.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList "`"$ahkFile`"" `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

Install-ChocolateyPackage @packageArgs 
