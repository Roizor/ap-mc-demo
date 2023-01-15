ScriptRunner="arm.sh"
cd scripts
vared -p "Intel mac? (y) " -c apmt
if [[ $apmt = "y" ]] then
    ScriptRunner="intel.sh"
fi
zsh $ScriptRunner
clear
ampi=$(ipconfig getifaddr en0)

echo "If you are running a server, connect to $ampi"
