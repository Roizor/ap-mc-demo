ScriptRunner="arm.sh"
cd scripts
vared -p "Intel mac? (y) " -c apmt
if [[ $apmt = "y" ]] then
    ScriptRunner="intel.sh"
fi
zsh $ScriptRunner
clear
ampi=$(ipconfig getifaddr en0)
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/MinecraftDemo.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock
echo "If you are running a server, connect to $ampi"
