$CpuType="$( sysctl -a | grep brand )"
$ScriptRunner = "intel.sh"

if [[ $CpuType =~ "Apple" ]]; then
    $ScriptRunner = "arm.sh"
fi
clear
zsh $ScriptRunner

ampi=$(ipconfig getifaddr en0)

echo "If you are running a server, connect to $ampi"