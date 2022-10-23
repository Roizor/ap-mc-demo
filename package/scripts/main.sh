$CpuType=$( sysctl -a | grep brand )
$ScriptRunner = "intel.sh"

if [[ $CpuType =~ "Apple" ]]; then
    $ScriptRunner = "arm.sh"
fi
clear
bash $ScriptRunner

ampi=$(ipconfig getifaddr en0)