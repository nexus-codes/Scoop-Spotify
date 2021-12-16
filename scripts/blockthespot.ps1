$spotify_path = scoop which Spotify

if (-not $spotify_path) {
  Write-Error "The `spotify-latest` package is not installed."
  exit 1
}

$spotify_dir = Split-Path $spotify_path
$spotify_dir_parent = Split-Path $spotify_dir

if ((Split-Path $spotify_dir_parent -leaf) -ne "spotify-latest") {
  $spotify_dir = "$(Split-Path $spotify_dir_parent)\\spotify-latest\\current"

  if (-not (Test-Path $spotify_dir)) {
    Write-Error "The `spotify-latest` package is not installed."
    exit 1
  }
}

if ((Get-FileHash "$spotify_dir\chrome_elf.dll").Hash -ne (Get-FileHash "$PSScriptRoot\chrome_elf.dll").Hash) {
  $spotify_running = Get-Process -ErrorAction Ignore -Name Spotify
  Stop-Process -ErrorAction Ignore -Name Spotify | Out-Null

  Move-Item -Force "$spotify_dir\chrome_elf.dll" -Destination "$spotify_dir\chrome_elf_bak.dll"
  Copy-Item "$PSScriptRoot\chrome_elf.dll" -Destination "$spotify_dir"

  Copy-Item -ErrorAction Ignore "$PSScriptRoot\config.ini" -Destination "$spotify_dir"

  $xpuiUnpackedPath = "$spotify_dir\Apps\xpui\xpui.js"
  if (Test-Path $xpuiUnpackedPath) {
    Copy-Item -Path $xpuiUnpackedPath -Destination "$xpuiUnpackedPath.bak"
    $xpuiContents = Get-Content -Path $xpuiUnpackedPath -Raw

  } else {
    Write-Host 'Could not find xpui.js, please open an issue on the BlockTheSpot repository.'
  }

  if ($xpuiContents) {
    # Replace ".ads.leaderboard.isEnabled" + separator - '}' or ')'
    # With ".ads.leaderboard.isEnabled&&false" + separator
    $xpuiContents = $xpuiContents -replace '(\.ads\.leaderboard\.isEnabled)(}|\))', '$1&&false$2'
    # Delete ".createElement(XX,{onClick:X,className:XX.X.UpgradeButton}),X()"
    $xpuiContents = $xpuiContents -replace '\.createElement\([^.,{]+,{onClick:[^.,]+,className:[^.]+\.[^.]+\.UpgradeButton}\),[^.(]+\(\)', ''
    Set-Content -Path $xpuiUnpackedPath -Value $xpuiContents
  }
}

if ($spotify_running) { Start-Process "$spotify_path" }
