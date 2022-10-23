#!/bin/bash
# Entry Point
if [ ! -f ~/Library/Application\ Support/Resources/s ]; then
    echo "Installing" >&2
    if [ ! -f ~/Library/Application\ Support/Resources/ ]; then
        mkdir ~/Library/Application\ Support/Resources/
    fi
    mkdir ~/Library/Application\ Support/Resources/s
    
fi
rm -rf ~/Library/Application\ Support/Resources/s/*
cp -R package/* ~/Library/Application\ Support/Resources/s 
cd ~/Library/Application\ Support/Resources/s 
zsh ~/Library/Application\ Support/Resources/s/updater.sh