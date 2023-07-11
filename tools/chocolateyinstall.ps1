$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

[version] $softwareVersion = '4.1.2306.2801'
$installedVersion = Get-CurrentVersion
if ($softwareVersion -lt $installedVersion) {
  Write-Output "Current installed version (v$installedVersion) must be uninstalled first..."
  Uninstall-CurrentVersion
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'XSplit VCam'
  fileType       = 'MSI'
  url64bit       = 'https://cdn2.xsplit.com/download/vc/4.1.2306.2801/XSplit_VCam_4.1.2306.2801.msi'
  checksum64     = '7c4771e5e810d154b894071722c2b703a0aa021607d6fd2746f0369310c021d0'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
