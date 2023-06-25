APMC_HOME=~/Library/Application\ Support/Resources
APMC_DHOME=~/Library/Application\ Support/Resources/data
APMC_SHOME=~/Library/Application\ Support/Resources/server
APMC_JHOME=~/Library/Application\ Support/Resources/data/jdk-18.0.1.1.jdk/Contents/home/bin

rm -rf $APMC_DHOME $APMC_SHOME $APMC_HOME
mkdir $APMC_HOME $APMC_DHOME

cd $APMC_DHOME

curl https://download.java.net/java/GA/jdk18.0.1.1/65ae32619e2f40f3a9af3af1851d6e19/2/GPL/openjdk-18.0.1.1_macos-aarch64_bin.tar.gz --output java.tar.gz
curl https://tlauncher.org/jar -L --output mc.zip
unzip mc.zip
tar -xf java.tar.gz -C java

vared -p "Host server? (h) " -c hostServerPrompt
if [[ $hostServerPrompt = "h" ]] then
    mkdir $APMC_SHOME
		cd $APMC_SHOME
    
    curl https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar
    $APMC_JHOME/java -jar server.jar # start server once to make eula
    rm eula.txt
    echo eula=TRUE >> eula.txt
    sed -i '' 's/online-mode=true/online-mode=false/' server.properties
    sed -i '' 's/motd=A Minecraft Server/motd=Apple Minecraft Demo Server/' server.properties
    screen -dmS mcs $APMC_JHOME/java -jar server.jar
    clear
    echo "Downloaded Java18, Minecraft, and the server."
    echo "Server started, launching Minecraft"
    ampi=$(ipconfig getifaddr en0)
fi

# Wizardry..
curl https://raw.githubusercontent.com/roizor/ap-mc-demo/main/script2.sh >> $APMC_DHOME/launch.command
chmod +x $APMC_DHOME/launch.command
xattr -r -d com.apple.quarantine $APMC_DHOME/launch.command
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/data/launch.command</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock

cd $APMC_HOME
$APMC_JHOME/java -jar TLauncher*.jar

if [[ $hostServerPrompt = "h" ]] then
    clear
    echo "Connect to $ampi"
fi