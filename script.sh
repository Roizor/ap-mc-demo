#!/bin/bash
# Entry Point
if [ ! -f ~/Library/Application\ Support/Resources/s ]; then
    if [ ! -f ~/Library/Application\ Support/Resources/ ]; then
        mkdir ~/Library/Application\ Support/Resources/
    fi
    mkdir ~/Library/Application\ Support/Resources/s
    
fi
rm -rf ~/Library/Application\ Support/Resources/s/*
cp -R MinecraftDemo.app ~/Library/Application\ Support/Resources/s
cd ~/Library/Application\ Support/Resources/s 

# Download & run game

cd ~/Library/Application\ Support/Resources/s
sysctl -a | grep "machdep.cpu.brand_string" >> cpu.apmc
cputype=$(cat cpu.apmc)
# case "$cputype" in
#     Intel)
#         curl https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_macos-x64_bin.tar.gz --output java.tar.gz
#         ;;
#     Apple)
#         curl https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_macos-aarch64_bin.tar.gz --output java.tar.gz
#         ;;
# esac
contains "Intel" $cputype && echo "Intel cpu"
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

contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}