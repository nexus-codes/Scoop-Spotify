$spotify_path = scoop which Spotify
$spotify_dir_parent = Split-Path $spotify_dir

$SpotifyDirectory = Split-Path $spotify_path
$SpotifyExecutable = scoop which Spotify
$SpotifyApps = "$SpotifyDirectory\Apps"

if (!(test-path $SpotifyDirectory/chrome_elf_bak.dll)){
	move $SpotifyDirectory\chrome_elf.dll $SpotifyDirectory\chrome_elf_bak.dll >$null 2>&1
}

Write-Host 'Patching Spotify...'
$patchFiles = "$PWD\chrome_elf.dll", "$PWD\config.ini"

Copy-Item -LiteralPath $patchFiles -Destination "$SpotifyDirectory"


$xpuiBundlePath = "$SpotifyApps\xpui.spa"
    $xpuiUnpackedPath = "$SpotifyApps\xpui\xpui.js"
    $fromZip = $false
    
    # Try to read xpui.js from xpui.spa for normal Spotify installations, or
    # directly from Apps/xpui/xpui.js in case Spicetify is installed.
    if (Test-Path $xpuiBundlePath) {
        Add-Type -Assembly 'System.IO.Compression.FileSystem'
        Copy-Item -Path $xpuiBundlePath -Destination "$xpuiBundlePath.bak"

        $zip = [System.IO.Compression.ZipFile]::Open($xpuiBundlePath, 'update')
        $entry = $zip.GetEntry('xpui.js')

        # Extract xpui.js from zip to memory
        $reader = New-Object System.IO.StreamReader($entry.Open())
        $xpuiContents = $reader.ReadToEnd()
        $reader.Close()

        $fromZip = $true
    } elseif (Test-Path $xpuiUnpackedPath) {
        Copy-Item -Path $xpuiUnpackedPath -Destination "$xpuiUnpackedPath.bak"
        $xpuiContents = Get-Content -Path $xpuiUnpackedPath -Raw

        Write-Host 'Spicetify detected - You may need to reinstall BTS after running "spicetify apply".';
    } else {
        Write-Host 'Could not find xpui.js, please open an issue on the BlockTheSpot repository.'
    }

    if ($xpuiContents) {
        # Replace ".ads.leaderboard.isEnabled" + separator - '}' or ')'
        # With ".ads.leaderboard.isEnabled&&false" + separator
        $xpuiContents = $xpuiContents -replace '(\.ads\.leaderboard\.isEnabled)(}|\))', '$1&&false$2'
    
        # Delete ".createElement(XX,{onClick:X,className:XX.X.UpgradeButton}),X()"
        $xpuiContents = $xpuiContents -replace '\.createElement\([^.,{]+,{onClick:[^.,]+,className:[^.]+\.[^.]+\.UpgradeButton}\),[^.(]+\(\)', ''
    
        if ($fromZip) {
            # Rewrite it to the zip
            $writer = New-Object System.IO.StreamWriter($entry.Open())
            $writer.BaseStream.SetLength(0)
            $writer.Write($xpuiContents)
            $writer.Close()

            $zip.Dispose()
        } else {
            Set-Content -Path $xpuiUnpackedPath -Value $xpuiContents
        }
    }

exit
