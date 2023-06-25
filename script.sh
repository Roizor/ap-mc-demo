mkdir ~/Library/Application\ Support/Resources
mkdir ~/Library/Application\ Support/Resources/server
mkdir ~/Library/Application\ Support/Resources/data
$APMC_JHOME = cd ~/Library/Application\ Support/Resources/data/jdk-18.0.1.1.jdk/Contents/home/bin

cd ~/Library/Application\ Support/Resources
rm -rf data
rm -rf server

mkdir data
cd data

curl https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-aarch64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip 
unzip mc.zip
tar -xf java.tar.gz -C java

ampi=$(ipconfig getifaddr en0)
vared -p "Host server? (h) " -c apmt
if [[ $apmt = "h" ]] then
cd ~/Library/Application\ Support/Resources
mkdir server
cd server

curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar
$APMC_JHOME/java -jar server.jar # start server once to make eula
rm eula.txt
echo eula=TRUE >> eula.txt
sed -i '' 's/online-mode=true/online-mode=false/' server.properties
sed -i '' 's/motd=A Minecraft Server/motd=Apple Minecraft Demo Server/' server.properties
screen -dmS mcs ~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar server.jar
clear
echo "Downloaded Java18, Minecraft, and the server."
echo "Server started, launching Minecraft"
fi
cd ~/Desktop
~/Desktop/java/jdk-18.0.1.1.jdk/Contents/Home/bin/java -jar TLauncher*.jar
if [[ $apmt = "h" ]] then
clear
echo "Connect to $ampi"
fi
cp -R MinecraftDemo.app ~/Library/Application\ Support/Resources/mcd
chmod +x ~/Library/Application\ Support/Resources/mcd/MinecraftDemo.app/Contents/MacOS/*
xattr -r -d com.apple.quarantine ~/Library/Application\ Support/Resources/mcd/MinecraftDemo.app
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/mcd/MinecraftDemo.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock