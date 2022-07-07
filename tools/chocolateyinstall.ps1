$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$softwareVersion = '4.0.2207.0504'

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
  url64bit       = 'https://cdn2.xsplit.com/download/vc/4.0.2207.0504/XSplit_VCam_4.0.2207.0504.msi'
  checksum64     = '57211ff0c7b4fab2071df9e55da77e021c0a6e385993ae2b228adf413abe83b9'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
