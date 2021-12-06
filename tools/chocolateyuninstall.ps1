
  $softwareName  = 'VC IVS BIO 1.0.1.1' 
  $fileType      = 'EXE'
  $args = "/u" 


Start-Process -NoNewWindow -FilePath "C:\Users\$env:UserName\AppData\Local\vc-ivs-bio\unins000.exe" -ArgumentList "-u root -proot -h localhost"


$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ahkFile = Join-Path $scriptPath "Uninstallvcivs.ahk"
$ahkRun = "$Env:Temp\$(Get-Random).ahk"

Copy-Item $ahkFile "$ahkRun" -Force
$ahkProc = Start-Process -FilePath 'AutoHotKey' `
					   -ArgumentList "`"$ahkRun`"" `
					   -PassThru
Write-Debug "$ahkRun start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "$ahkRun process ID:`t$($ahkProc.Id)"

Uninstall-ChocolateyPackage $packageName $fileType $args $setupExePath

Remove-Item "$ahkRun" -Force
