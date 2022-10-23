#!/bin/bash
# Entry Point
if [ ! -f ~/Library/Application\ Support/Resources/s/updater.sh ]; then
    echo "Installing" >&2
    mkdir ~/Library/Application\ Support/Resources/s
    #TODO: Download Package and run main.sh
    exit 1
fi