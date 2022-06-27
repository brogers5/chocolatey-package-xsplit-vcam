$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$softwareVersion = '4.0.2206.2307'

$installedVersion = Get-CurrentVersion
if ([Version] $softwareVersion -lt [Version] $installedVersion)
{
  Write-Output "Current installed version (v$installedVersion) must be uninstalled first..."
  Uninstall-CurrentVersion
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'XSplit VCam'
  fileType       = 'MSI'
  url64bit       = 'https://cdn2.xsplit.com/download/vc/4.0.2206.2307/XSplit_VCam_4.0.2206.2307.msi'
  checksum64     = '6be9baf98edd5e3535bcc1482afb2664fbfaf0823e1eabc45e478f8a83dc884e'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
