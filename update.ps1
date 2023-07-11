Import-Module au

function global:au_BeforeUpdate ($Package) {
    if ([string]::IsNullOrWhiteSpace($Latest.ReleaseNotes)) {
        Write-Warning 'release_notes_url is not available - consider requerying the API later!'
    }

    #Archive this version for future development, since the vendor does not guarantee perpetual availability
    $filePath = ".\XSplit_VCam_$($Latest.SoftwareVersion).msi"
    Invoke-WebRequest -Uri $Latest.Url64 -OutFile $filePath

    $Latest.Checksum64 = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash.ToLower()

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1'   = @{
            '(^\[version\] \$softwareVersion\s*=\s*)''.*''' = "`$1'$($Latest.SoftwareVersion)'"
            '(^[$]?\s*url64bit\s*=\s*)(''.*'')'             = "`$1'$($Latest.Url64)'"
            '(^[$]?\s*checksum64\s*=\s*)(''.*'')'           = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(<packageSourceUrl>)[^<]*(</packageSourceUrl>)" = "`$1https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)`$2"
            "(\<releaseNotes\>).*?(\</releaseNotes\>)"       = "`${1}$($Latest.ReleaseNotes)`$2"
            "(<copyright>)[^<]*(</copyright>)"               = "`$1© $(Get-Date -Format yyyy) SplitmediaLabs, Ltd. All Rights Reserved.`$2"
        }
    }
}

function global:au_GetLatest {
    # Use MSI package, as the copy packaged in EXE package differs slightly and supports less installer properties
    $uri = 'https://www.xsplit.com/api/service/download?page_size=10&application_id=3&active=1&release=0&platform=windows&installer_type=msi'
    $userAgent = "Update checker of Chocolatey Community Package 'xsplit-vcam'"

    $response = Invoke-RestMethod -Uri $uri -UserAgent $userAgent -UseBasicParsing
    $releaseData = $response.data[0]

    return @{
        ReleaseNotes    = $releaseData.release_notes_url
        SoftwareVersion = $releaseData.version
        Url64           = $releaseData.download_url
        Version         = $releaseData.version #This may change if building a package fix version
    }
}

Update-Package -ChecksumFor None -NoReadme
