<!-- markdownlint-disable MD010 -->
<!-- markdownlint-disable MD014 -->
<!-- markdownlint-disable MD037 -->
<!-- markdownlint-disable MD040 -->
<!-- markdownlint-disable MD046 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->

<h1 align="center" style="margin-top: 0px;">Scoop-Spotify</h1>

<div align="center" >

[![GitHub branch checks state](https://img.shields.io/github/checks-status/zwxi/Scoop-Spotify/main?label=Excavator&logo=github&style=for-the-badge)](https://github.com/zwxi/Scoop-Spotify/actions) [![Appveyor](https://img.shields.io/appveyor/build/zwxi/Scoop-Spotify?label=checks&logo=appveyor&style=for-the-badge)](https://ci.appveyor.com/project/zwxi/scoop-spotify)
</div>

A [Scoop](https://github.com/lukesampson/scoop) bucket for Spotify, Spicetify and related packages.

    scoop bucket add spotify https://github.com/zwxi/Scoop-Spotify.git

...I've spent an unhealthy amount of time on automating all of this.

## Fork notes

- Be sure to check the [spicetify-cli repo](https://github.com/khanhas/spicetify-cli/issues) and [spicetify-themes repo](https://github.com/morpheusthewhite/spicetify-themes/issues) for open issues if you face any errors. Feel free to open an issue here too.
- Forked from the original repo and remaintained fixing all errors.
- All instances of the [original](https://github.com/TheRandomLabs/Scoop-Spotify) are replaced in this README. This is not an attempt to steal credit
- Rewritten some parts to update with the current status of the spicetify project
- PRs to the original repo merged to this one. All of them are mentioned in their respective commit descriptions too
  - [Use Windows SID instead of the name Everyone for better system language compatibility #47](https://github.com/TheRandomLabs/Scoop-Spotify/pull/47) by [dionysius](https://github.com/dionysius)
  - [Fix init-spicetify-config script for spicetify v2 #51](https://github.com/TheRandomLabs/Scoop-Spotify/pull/51) by [SaifAqqad](https://github.com/SaifAqqad)
  - [Update the config init script to handle both the profiles #61](https://github.com/TheLabs/Scoop-Spotify/pull/61) by [Lunchb0ne](https://github.com/Lunchb0ne)

## hash check failed

- If the manifest has been recently updated due to very recent changes to the respective repos this error might occour.
- Feel free the click the link that pops up when this happens to report the issue (you can also manually report an issue)
- You can also use the `-s` or `--skip` flag when installing/updating to skip the hash-check step

## scoop-update error

If it shows any error while running `scoop update`, you can

- Try again after some time to see if it goes away
- Remove and re-add the bucket with `scoop bucket rm spotify` and `scoop bucket add spotify https://github.com/zwxi/Scoop-Spotify.git` all apps will stay installed

## Notes

- None of the packages in this bucket can be installed globally.
- If you have the means, please buy Spotify Premium instead of installing BlockTheSpot.
- All of the Spicetify packages require Spotify to be installed either through this Scoop bucket or
  the official installer.
- All themes, extensions and custom apps for Spicetify should be installed to `~\.spicetify`
  instead of the spicetify-cli installation directory.
- Installing or updating any of the packages in this bucket automatically applies the Spicetify
  configuration and preserves BlockTheSpot if it is installed.
- All Spicetify packages apart from spicetify-cli depend on spicetify-cli.
- `--purge` or `-p` should be used to fully uninstall all packages apart from `blockthespot`,
  `google-spicetify` and `spicetify-themes`.

### BlockTheSpot

- This blocks advertisements for the latest version of Spotify.
- This package depends on `spotify-latest`.
- This is not an executable program. `spotify-latest` will be patched automatically every time this
  package or any of the Spicetify packages are installed or updated.
- If BlockTheSpot is ever reset, `blockthespot` can be run to reapply it. This usually happens
  after running Spicetify commands, and running `spicetify-apply` rather than `spicetify apply`
  ensures that BlockTheSpot is enabled if it is installed.

### spicetify-autoVolume

- See
  [here](https://github.com/amanharwara/spicetify-autoVolume#changing-the-intervalminimum-volume)
  to modify the configuration. `autoVolume.js` can be found at
  `~\.spicetify\Extensions\autoVolume.js`.

### spicetify-cli

- Experimental features, fast user switching and all
  [default extensions](https://github.com/khanhas/spicetify-cli/wiki/Extensions) apart from Auto Skip
  Videos and all [default apps](https://github.com/khanhas/spicetify-cli/wiki/Custom-Apps) are enabled by default.
  Note: Default apps in the sidebar can be toggled to be hidden from the 'sidebar config' menu in compatible themes or by removing the apps from `config-xpui.ini`
- `spicetify-apply` is should be run instead of `spicetify apply` if BlockTheSpot is installed, as
  it ensures that BlockTheSpot is enabled if it is installed.
- It should be noted that `spicetify-apply` also runs `spicetify restore` and `spicetify backup`
  before running `spicetify apply` to ensure that changes are applied every time.
- For similar reasons, `spicetify-enable-devtool` and `spicetify-disable-devtool` should be run
  instead of `spicetify enable-devtool` and `spicetify disable-devtool`.
- The three above commands also support the `-quiet` switch.

### spicetify-canary

- Nightly builds of the [spicetify-cli](https://github.com/khanhas/spicetify-cli) repo built by my own Github Actions hosted [here](https://github.com/zwxi/spicetify-builds)
- Recommended to be installed and updated with the `-k` flag to avoid the cached copy
- This version should be uninstalled before using the release version of spicetify
- Recommended only if the release version has bugs which were recently fixed

### spicetify-jqbx

- This requires Spotify Premium.

### spicetify-themes

- Installs [morpheusthewhite/spicetify-themes](https://github.com/morpheusthewhite/spicetify-themes)

### Spotify (latest)

- This is the latest version of Spotify.
- Unlike [Ash258's version](https://github.com/Ash258/scoop-Ash258/blob/master/bucket/Spotify.json),
  this version installs completely silently and to the Scoop directory.
- Spotify's built-in updater is disabled, and Scoop should be used to update it instead.
- Spotify should be installed locally and not globally.
- This cannot be installed concurrently with `spotify-with-blockthespot`.

### Spotify with BlockTheSpot

- Absolutley not recommended at all. Not updated and not guaranteed to work
- This is an outdated version of Spotify (1.1.4.197.g92d52c4f) with an
  [old version of BlockTheSpot](https://github.com/master131/BlockTheSpot).
- Spotify's built-in updater is disabled.
- Spotify with BlockTheSpot should be installed locally and not globally.
- Installation and uninstallation of this package require administrator privileges.
- This cannot be installed concurrently with `spotify-latest`.

## Installing and customizing Spotify

First, the latest version of Spotify should be installed:

      scoop install spotify-latest

Note that Spotify should not be installed globally, as it stores files in user-specific directories.

Once Spotify is installed, [spicetify-cli](https://github.com/khanhas/spicetify-cli) can be
installed to customize the Spotify client:

      scoop install spicetify-cli

Again, spicetify-cli should be installed locally, as it also stores files in a user-specific
location.

[spicetify-themes](https://github.com/morpheusthewhite/spicetify-themes) can be installed for
a collection of community-created themes for Spicetify. Obviously, this should also be installed
locally:

      scoop install spicetify-themes

[google-spicetify](https://github.com/khanhas/google-spicetify) is also available:

      scoop install google-spicetify

I can recommend the
[Default](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Default)
theme, which can be applied by running the following:

      spicetify config current_theme Default
      spicetify-apply

To install spicetify-cli and apply a theme silently, the theme can be configured before installing
spicetify-themes. When any of the Spicetify packages are installed, the current configuration
is applied, and if Spotify was open previously, it is reopened.

      scoop install spicetify-cli
      spicetify config current_theme Default
      scoop install spicetify-themes

[spicetify-autoVolume](https://github.com/amanharwara/spicetify-autoVolume#changing-the-intervalminimum-volume)
can be installed to automatically decrease the volume at specific intervals of time:

      scoop install spicetify-autovolume

[BlockTheSpot](https://github.com/mrpond/BlockTheSpot) can be installed to block advertisements:

      scoop install blockthespot

All of the above packages can be updated through Scoop.

**If you don't care about reading any of this** and just want a quick way to install ad-blocked
Spotify with the Default theme, and developer tools, copy and paste this into
PowerShell:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install git sudo

scoop bucket add spotify https://github.com/zwxi/Scoop-Spotify.git
scoop install spotify-latest blockthespot spicetify-cli spicetify-themes spicetify-autovolume

spicetify config current_theme Default --quiet
spicetify-enable-devtool -quiet
```

**Or even shorter**, but with Sleek theme and Deep color config as I like it :

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; iwr -useb https://raw.githubusercontent.com/zwxi/Scoop-Spotify/master/basic-setup.ps1 | iex
```

I wrote the above script mostly for people who don't care about using Scoop and just need a
foolproof way to set everything up automatically.

And in the future, if you want to update any installed packages:

```powershell
  scoop update *
```
