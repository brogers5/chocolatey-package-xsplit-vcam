﻿$ErrorActionPreference = 'Stop'

Confirm-Win10

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

[version] $softwareVersion = '4.2.2407.1901'
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
    url64bit       = 'https://cdn2.xsplit.com/download/vc/4.2.2407.1901/XSplit_VCam_4.2.2407.1901.msi'
    checksum64     = '24c8ab9e0899dca6e04b6d17967193ae80076d7658232c946a812eb335ddd618'
    checksumType64 = 'sha256'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes = @(0, 3010, 1641)
  }

  Install-ChocolateyPackage @packageArgs
}
