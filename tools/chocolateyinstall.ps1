$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$softwareVersion = '4.1.2210.2601'

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
  url64bit       = 'https://cdn2.xsplit.com/download/vc/4.1.2210.2601/XSplit_VCam_4.1.2210.2601.msi'
  checksum64     = '879d586ef1d91ced65b6cf0a0c2f381ed6b609ebefc570293114c7fd86dbdd3c'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
