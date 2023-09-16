APMC_HOME=~/Library/Application\ Support/Resources
APMC_DHOME=~/Library/Application\ Support/Resources/data
APMC_SHOME=~/Library/Application\ Support/Resources/server
APMC_JHOME=~/Library/Application\ Support/Resources/data/jdk-19.0.2.jdk/Contents/Home/bin

clear

log () {
  if [[ $L = "1" ]] then
  echo $1;
  fi
}

log "---===-Welcome to APMC-===---"
log "=-SETTINGS-="
log "Logs enabled (L=1)"
if [[ $S = "1" ]] then
    log "Server download (S=1)"
fi
if [[ $U = "1" ]] then
    log "Exit after server download (U=1)"
fi

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

# Wizardry..
log "Getting launcher"
curl --progress-bar -s https://raw.githubusercontent.com/roizor/ap-mc-demo/main/script2.sh >> $APMC_DHOME/launch.zsh
chmod +x $APMC_DHOME/launch.zsh
xattr -r -d com.apple.quarantine $APMC_DHOME/launch.zsh

log "Setting up dock application"
echo "cd \"$HOME/Library/Application Support/Resources/data\" && zsh launch.zsh" >> $APMC_DHOME/Launch\ Minecraft.command
chmod +x $APMC_DHOME/Launch\ Minecraft.command
xattr -r -d com.apple.quarantine $APMC_DHOME/Launch\ Minecraft.command

defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$HOME/Library/Application Support/Resources/data/Launch Minecraft.command</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
killall Dock

if [[ $S = "1" ]] then
    log "Creating server directory"
    mkdir $APMC_SHOME
    cd $APMC_SHOME
    
    log "Pulling 1.20.1 server"
    curl -s https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/183/downloads/paper-1.20.1-183.jar --progress-bar --output server.jar
    $APMC_JHOME/java -jar server.jar # start server once to make eula
    log "Fixing EULA & some settings"
    rm eula.txt
    echo eula=TRUE >> eula.txt
    sed -i '' 's/online-mode=true/online-mode=false/' server.properties
    sed -i '' 's/motd=A Minecraft Server/motd=Waiting on APMCUtil for MOTD../' server.properties
    log "Pulling APMCUtils."
    curl -s https://ifarded.lol/apmcu.jar --progress-bar --output plugins/apmcu.jar
    screen -dmS mcs $APMC_JHOME/java -jar server.jar
    log "Server is up!"
    ampi=$(ipconfig getifaddr en0)
    echo "Started server on IP $ampi"
    if [[ $U = "1" ]] then
        clear
        echo "You may now close this window."
        exit
    fi
fi

log "Getting java..."
curl -s $JDK_LINK --progress-bar --output java.tar.gz
log "Getting launcher..."
curl -Ls https://tlauncher.org/jar --progress-bar --output mc.zip
log "Unarchiving.."
unzip -qq mc.zip
tar -xf java.tar.gz

log "Time for launch!"
cd $APMC_DHOME
$APMC_JHOME/java -jar TLauncher*.jar

if [[ $S = "1" ]] then
    log "Tell user a server is hosted here!"
    osascript -e 'tell application (path to frontmost application as text) to display dialog "Hey! This computer hosts a Minecraft server! Connect to '$ampi' in Multiplayer. The version is 1.20.1!" buttons {"OK"} with icon stop'
fi

clear
echo "You may now close this window."
exit