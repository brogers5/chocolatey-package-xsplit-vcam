$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

[version] $softwareVersion = '4.1.2304.2701'
$installedVersion = Get-CurrentVersion
if ($softwareVersion -lt $installedVersion) {
  Write-Output "Current installed version (v$installedVersion) must be uninstalled first..."
  Uninstall-CurrentVersion
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'XSplit VCam'
  fileType       = 'MSI'
  url64bit       = 'https://cdn2.xsplit.com/download/vc/4.1.2304.2701/XSplit_VCam_4.1.2304.2701.msi'
  checksum64     = 'a1f6bb00c8df7ccd3a5a296f5a297efdb1ce37d25d1a6f2d719339d04e7e0269'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
