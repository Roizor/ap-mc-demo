mkdir ~/Library/Application\ Support/Resources
mkdir ~/Library/Application\ Support/Resources/s
mkdir ~/Library/Application\ Support/Resources/mcd
cp -R MinecraftDemo.app ~/Library/Application\ Support/Resources/mcd
chmod +x ~/Library/Application\ Support/Resources/mcd/MinecraftDemo.app/Contents/MacOS/*
xattr -r -d com.apple.quarantine ~/Library/Application\ Support/Resources/mcd/MinecraftDemo.app
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/mcd/MinecraftDemo.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock