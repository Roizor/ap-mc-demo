# This script assumes bootstrapper already did it's work

APMC_DHOME="$HOME/Library/Application Support/Resources/data"
APMC_SHOME="$HOME/Library/Application Support/Resources/server"
APMC_JHOME="$HOME/Library/Application Support/Resources/data/jdk-19.0.2.jdk/Contents/Home/bin"

cd $APMC_DHOME
$APMC_JHOME/java -jar TLauncher*.jar

if [[ -f "$APMC_SHOME" ]]; then # A server exists!
    cd $APMC_SHOME
    screen -dmS mcs $APMC_JHOME/java -jar server.jar
		ampi=$(ipconfig getifaddr en0)
		echo "Connect to the Minecraft server: $ampi"
fi