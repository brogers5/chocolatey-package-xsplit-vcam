
---

### [choco://xsplit-vcam](choco://xsplit-vcam)

To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support](https://community.chocolatey.org/packages/choco-protocol-support)

---

## XSplit VCam: Webcam Background Software

XSplit VCam makes cutting edge background removal and blurring possible with any webcam, without the need for expensive green screens, and complicated lighting setups.

When connected to the XSplit Connect mobile companion app, your mobile device's camera can also be used as a virtual webcam device.

![XSplit VCam Screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-xsplit-vcam@722c25cd4691ebbc1a359cc61a7f7fd08738d355/Screenshot.png)

---

## Package Notes

This package depends on downloading from XSplit's official distribution point. Therefore, supportability should be expected to follow [XSplit's support policy](https://www.xsplit.com/blog/xsplit-version-updates). Notably, once a given version is no longer supported, availability of the installer binary cannot be guaranteed. Consequently, this package version should generally be considered obsolete and unsupported once the consumed software version reaches end-of-support.

Consider [internalizing this package](https://docs.chocolatey.org/en-us/guides/create/recompile-packages) if you require the ability to install this specific version after it reaches end-of-support.

---

The installer executed by this package was built using Advanced Installer. However, this package consumes an alternate Windows Installer MSI distribution intended for enterprise deployments, and does not execute the bootstrapper that is typically consumed by end-users.

Notable properties include:

* `ProductLanguage` - Overrides the default language configuration. [Uses a `LANGID` value](https://docs.microsoft.com/en-us/windows/win32/msi/localizing-the-error-and-actiontext-tables).

    Supported `LANGID` values include:

    |LANGID|Language|
    |-|-|
    |1028|Chinese - Taiwan|
    |1030|Danish - Denmark|
    |1031|German - Germany|
    |1033|English - United States|
    |1036|French - France|
    |1041|Japanese - Japan|
    |1042|Korean - Korea|
    |1046|Portuguese - Brazil|
    |1049|Russian - Russia|
    |2052|Chinese - China|
    |3082|Spanish - Modern Sort - Spain|

* `AI_DESKTOP_SH` - Add shortcut to the Desktop. Defaults to `1`, disable with `0`.
* `AI_STARTMENU_SH` - Add shortcut to the Start Menu. Defaults to `1`, disable with `0`.
* `XI_ONBOARD` - Show onboarding messages. Defaults to `1`, disable with `0`.
* `XI_AUTOUPDATE` - Allows the end-user to upgrade the software. Defaults to `0`, enable with `1`. If enabling, consider [pinning this package](https://docs.chocolatey.org/en-us/choco/commands/pin) after installation.

Any desired arguments can simply be appended to the package's default install arguments using Chocolatey's `--install-arguments` option.

### Example

```shell
choco install xsplit-vcam --install-arguments "ProductLanguage=3082 AI_DESKTOP_SH=0 XI_ONBOARD=0"
```

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable -n=useRememberedArgumentsForUpgrades
```
