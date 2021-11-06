Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1')

scoop install git

scoop bucket add spotify https://github.com/nexus-codes/Scoop-Spotify.git
scoop install spotify-latest blockthespot spicetify-cli spicetify-themes

spicetify config current_theme Sleek --quiet
spicetify config color_scheme Deep --quiet
spicetify-enable-devtool -quiet
