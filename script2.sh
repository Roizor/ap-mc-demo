# This script assumes bootstrapper already did it's work

APMC_HOME=~/Library/Application\ Support/Resources
APMC_DHOME=~/Library/Application\ Support/Resources/data
APMC_SHOME=~/Library/Application\ Support/Resources/server
APMC_JHOME=~/Library/Application\ Support/Resources/data/jdk-18.0.1.1.jdk/Contents/home/bin

if [[ -f "$APMC_SHOME" ]]; then # A server exists!
	cd $APMC_SHOME
	screen -dmS mcs $APMC_JHOME/java -jar server.jar
fi

cd $APMC_DHOME
$APMC_JHOME/java -jar TLauncher*.jar