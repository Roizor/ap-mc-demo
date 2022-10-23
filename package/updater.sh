Version="2.0"
Online=$( curl https://raw.githubusercontent.com/Roizor/ap-mc-demo/main/version.ifo )

if [[ $CpuType =~ "Apple" ]]; then
    $ScriptRunner = "arm.sh"
fi
clear
bash $ScriptRunner

ampi=$(ipconfig getifaddr en0)