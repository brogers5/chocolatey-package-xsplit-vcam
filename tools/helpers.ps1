$softwareName = 'XSplit VCam'

function Uninstall-CurrentVersion {
    $packageArgs = @{
        packageName    = $env:ChocolateyPackageName
        softwareName   = $softwareName
        fileType       = 'MSI'
        silentArgs     = '/qn /norestart'
        validExitCodes = @(0, 3010, 1605, 1614, 1641)
    }
    
    [array] $keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
    
    if ($keys.Count -eq 0) {
        Write-Warning "$packageName has already been uninstalled by other means."
    }
    elseif ($keys.Count -le 2) {
        #XSplit VCam adds a couple keys. We need to use the one named after the product code GUID.
        $key = $keys | Where-Object { [System.Guid]::TryParse($_.PSChildName, $([ref][guid]::Empty)) }

        $packageArgs['silentArgs'] = "$($key.PSChildName) $($packageArgs['silentArgs'])"
        $packageArgs['file'] = ''
        
        Uninstall-ChocolateyPackage @packageArgs
    }
    elseif ($keys.Count -gt 2) {
        Write-Warning "$($keys.Count) matches found!"
        Write-Warning 'To prevent accidental data loss, no programs will be uninstalled.'
        Write-Warning 'Please alert package maintainer the following keys were matched:'
        $keys | ForEach-Object { Write-Warning "- $($_.PSChildName) ($($_.DisplayName))" }
    }
}

function Get-CurrentVersion {
    [array] $keys = Get-UninstallRegistryKey -SoftwareName $softwareName

    if ($keys.Count -ge 1) {
        return $keys[0].DisplayVersion
    }

    return $null
}
