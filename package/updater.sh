Version="2.0"
Online=$( curl https://raw.githubusercontent.com/Roizor/ap-mc-demo/main/version.ifo )

if [[ $Version =~ $Online ]]; then
    echo "You are running an outdated version of APMC!"
fi
zsh scripts/main.sh
