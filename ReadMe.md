# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-xsplit-vcam@7ddfa2f456eb462820f4e95f5d38652e15316f98/xsplit-vcam.png" width="48" height="48"/> Chocolatey Package: [XSplit VCam](https://community.chocolatey.org/packages/xsplit-vcam)

[![Chocolatey package version](https://img.shields.io/chocolatey/v/xsplit-vcam.svg)](https://community.chocolatey.org/packages/xsplit-vcam)
[![Chocolatey package download count](https://img.shields.io/chocolatey/dt/xsplit-vcam.svg)](https://community.chocolatey.org/packages/xsplit-vcam)

## Install

[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved stable version from the Chocolatey Community Repository:

```shell
choco install xsplit-vcam --source="'https://community.chocolatey.org/api/v2'"
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-xsplit-vcam/releases). The `nupkg` can be installed from the current directory (with dependencies sourced from the Community Repository) as follows:

```shell
choco install xsplit-vcam --source="'.;https://community.chocolatey.org/api/v2/'"
```

## Build

[Install Chocolatey](https://chocolatey.org/install), clone this repository, and run the following command in the cloned repository:

```shell
choco pack
```

A successful build will create `xsplit-vcam.w.x.y.z.nupkg`, where `w.x.y.z` should be the Nuspec's `version` value at build time.

>[!Note]
>As of Chocolatey v2.0.0, [leading zeros will no longer be used/honored within version numbers](https://github.com/chocolatey/choco/issues/1174). Legacy package versions that contain these will be normalized to remove them from the resulting filename. Going forward, `version` will be normalized accordingly for behavior consistency between v1 and v2 Chocolatey releases.

>[!Note]
>Chocolatey package builds are non-deterministic. Consequently, an independently built package's checksum will not match that of the officially published package.

## Update

This package should be automatically updated by the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au). If it is outdated by more than a few days, please [open an issue](https://github.com/brogers5/chocolatey-package-xsplit-vcam/issues).

### AU Setup

AU expects the parent directory that contains this repository to share a name with the Nuspec (`xsplit-vcam`). Your local repository should therefore be cloned accordingly:

```shell
git clone git@github.com:brogers5/chocolatey-package-xsplit-vcam.git xsplit-vcam
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):

```shell
mklink /J xsplit-vcam ..\chocolatey-package-xsplit-vcam
```

### VirusTotal Setup

While not strictly necessary to produce a working package, it's recommended to [install VirusTotal's CLI](https://community.chocolatey.org/packages/vt-cli) and [configure an API key](https://virustotal.github.io/vt-cli/#configuring-your-api-key). An API key can be [procured for free with a VirusTotal account](https://docs.virustotal.com/docs/please-give-me-an-api-key).

This should enable automated submission of the installer package to VirusTotal, which would improve the user experience for Chocolatey Pro+ users. They have access to Chocolatey's [Runtime Malware Protection feature](https://docs.chocolatey.org/en-us/features/virus-check), which by default is [enabled and configured for VirusTotal integration](https://docs.chocolatey.org/en-us/features/virus-check#virustotal).

Normally, the Community Repository's Package Scanner service would upload the installer package to VirusTotal, as a prerequisite to the moderation process's Scan Testing step. Unfortunately, the package is currently incompatible with it (due to the installer package [exceeding the current 200MB file size limit](https://github.com/chocolatey/home/issues/247)), and will therefore fail to submit the installer package.

As new XSplit VCam releases are unlikely to have been scanned prior to an updated package's publication, this would avoid burdening users with [a run-time prompt to optionally upload the installer binary to VirusTotal for scanning](https://docs.chocolatey.org/en-us/features/virus-check#what-if-virustotal-doesnt-have-results-for-a-binary).

### Execution and Testing

Once created, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) using the [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
