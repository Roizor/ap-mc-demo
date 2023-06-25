APMC_HOME=~/Library/Application\ Support/Resources
APMC_DHOME=~/Library/Application\ Support/Resources/data
APMC_SHOME=~/Library/Application\ Support/Resources/server
APMC_JHOME=~/Library/Application\ Support/Resources/data/jdk-19.0.2.jdk/Contents/Home/bin

log () {
  if [[ $L = "1" ]] then
  echo $1;
  fi
}

if [[ $(uname -p) == 'arm' ]]; then
    log "Using Apple Silicon Java download"
    JDK_LINK="https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-19.0.2_macos-aarch64_bin.tar.gz"
else
    log "Using Intel Java download"
    JDK_LINK="https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-19.0.2_macos-x64_bin.tar.gz"
fi

log "Removing pre-existing APMC install"
rm -rf $APMC_DHOME $APMC_SHOME $APMC_HOME
mkdir $APMC_HOME $APMC_DHOME

cd $APMC_DHOME

log "Getting java & launcher..."
curl -s $JDK_LINK --output java.tar.gz
curl -Ls https://tlauncher.org/jar --output mc.zip
log "Unarchiving.."
unzip mc.zip
tar -xf java.tar.gz

vared -p "Host server? (h) " -c hostServerPrompt
if [[ $hostServerPrompt = "h" ]] then
    log "Creating server directory"
    mkdir $APMC_SHOME
    cd $APMC_SHOME
    
    log "Pulling 1.19 server"
    curl -s https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar --output server.jar
    $APMC_JHOME/java -jar server.jar # start server once to make eula
    log "Fixing EULA & some settings"
    rm eula.txt
    echo eula=TRUE >> eula.txt
    sed -i '' 's/online-mode=true/online-mode=false/' server.properties
    sed -i '' 's/motd=A Minecraft Server/motd=Apple Minecraft Demo Server/' server.properties
    screen -dmS mcs $APMC_JHOME/java -jar server.jar
    log "Server is up!"
    ampi=$(ipconfig getifaddr en0)
fi

# Wizardry..
log "Getting launcher"
curl https://raw.githubusercontent.com/roizor/ap-mc-demo/main/script2.sh >> $APMC_DHOME/launch.zsh
chmod +x $APMC_DHOME/launch.zsh
xattr -r -d com.apple.quarantine $APMC_DHOME/launch.zsh

log "Setting up dock application"
echo "cd \"$HOME/Library/Application Support/Resources/data\" && zsh launch.zsh" >> $APMC_DHOME/Launch\ Minecraft.command
chmod +x $APMC_DHOME/Launch\ Minecraft.command
xattr -r -d com.apple.quarantine $APMC_DHOME/Launch\ Minecraft.command

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/data/Launch Minecraft.command</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock

log "Time for launch!"
cd $APMC_DHOME
$APMC_JHOME/java -jar TLauncher*.jar

if [[ $hostServerPrompt = "h" ]] then
    log "Tell user a server is hosted here!"
    osascript -e 'tell application (path to frontmost application as text) to display dialog "Hey! This computer hosts a Minecraft server! Connect to '$ampi' in Multiplayer. The version is 1.19!" buttons {"OK"} with icon stop'
fi
