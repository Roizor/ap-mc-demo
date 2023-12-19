# This script assumes bootstrapper already did it's work

APMC_DHOME="$HOME/Library/Application Support/Resources/data"
APMC_SHOME="$HOME/Library/Application Support/Resources/server"
APMC_JHOME="$HOME/Library/Application Support/Resources/data/jdk-19.0.2.jdk/Contents/Home/bin"

clear
echo "Launching!"
cd $APMC_DHOME
$APMC_JHOME/java -jar TLauncher*.jar

if [[ -d "$APMC_SHOME" ]]; then # A server exists!
    cd $APMC_SHOME
    screen -dmS mcs $APMC_JHOME/java -jar server.jar
		ampi=$(ipconfig getifaddr en0)
		osascript -e 'tell application (path to frontmost application as text) to display dialog "Hey! This computer hosts a Minecraft server! Connect to '$ampi' in Multiplayer. The version is 1.20.1!" buttons {"OK"} with icon stop'
fi

clear
echo "You may now close this window."