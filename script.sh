#!/bin/bash
# Entry Point
if [ ! -f ~/Library/Application\ Support/Resources/s ]; then
    echo "Installing" >&2
    if [ ! -f ~/Library/Application\ Support/Resources/ ]; then
        mkdir ~/Library/Application\ Support/Resources/
    fi
    mkdir ~/Library/Application\ Support/Resources/s
    
fi
rm -rf ~/Library/Application\ Support/Resources/s/*
cp -R package/* ~/Library/Application\ Support/Resources/s 
cp -R MinecraftDemo.app ~/Library/Application\ Support/Resources/s
cd ~/Library/Application\ Support/Resources/s 

# Download & run game

clear
echo "[Downloader] Starting (Step 1/4)"

cd ~/Library/Application\ Support/Resources/s
rm -rf mc 
rm -rf jdk-18.0.2.1.jdk
rm -rf mcs
rm -rf README-*.txt
rm -rf TLauncher-*.jar
curl https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_macos-x64_bin.tar.gz --output java.tar.gz
# https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_macos-aarch64_bin.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 

unzip mc.zip
tar -xf java.tar.gz

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/s/MinecraftDemo.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock

~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar


# vared -p "Host server (1.19.3)? (h) " -c apmt
# if [[ $apmt = "h" ]] then

# clear
# echo "Starting download"

# mkdir mcs
# cd mcs
# curl https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar --output server.jar

# ~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar
# rm eula.txt
# echo eula=TRUE >> eula.txt
# sed -i '' 's/online-mode=true/online-mode=false/' server.properties
# sed -i '' 's/motd=A Minecraft Server/motd=Impostor Server/' server.properties

# screen -dmS apmcs ~/Library/Application\ Support/Resources/s/jdk-18.0.2.1.jdk/Contents/Home/bin/java -jar server.jar
# fi