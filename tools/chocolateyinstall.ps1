﻿$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

[version] $softwareVersion = '4.2.2402.0903'
$installedVersion = Get-CurrentVersion

if ($installedVersion -and $installedVersion -eq $softwareVersion -and !$env:ChocolateyForce) {
  Write-Output "$softwareName v$installedVersion is already installed."
  Write-Output 'Skipping download and execution of installer.'
}
else {
  if ($softwareVersion -lt $installedVersion) {
    Write-Output "Current installed version (v$installedVersion) must be uninstalled first..."
    Uninstall-CurrentVersion
  }

  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'XSplit VCam'
    fileType       = 'MSI'
    url64bit       = 'https://cdn2.xsplit.com/download/vc/4.2.2402.0903/XSplit_VCam_4.2.2402.0903.msi'
    checksum64     = 'f9c4e001a786f1f7d9afb903b86edc66bc657c08844ec2afced3c5a9b8acb2e7'
    checksumType64 = 'sha256'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes = @(0, 3010, 1641)
  }

  Install-ChocolateyPackage @packageArgs
}
