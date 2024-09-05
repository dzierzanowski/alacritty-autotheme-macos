#!/bin/zsh
# Run this script in background as part of your .zshrc
# It includes an endless loop repeated every 0.5 seconds.

# Use AppleScript to find whether dark mode is enabled.
# Returns `true` / `false` string.
getDarkMode() {
    osascript -e 'tell application "System Events" to get dark mode of appearance preferences'
}

# Concatenate the base config and the appropriate theme, then write to ~/.alacritty.toml
setTheme() {
    isDarkMode=$1
    if [[ $isDarkMode == 'false' ]]; then
        theme=light
    elif [[ $isDarkMode == 'true' ]]; then
        theme=dark
    fi
    cat ~/.alacritty-base.toml \
        ~/.alacritty-theme-${theme}.toml \
        > ~/.alacritty.toml
}

main() {
    # Check initial state and set theme accordingly.
    lastRecordedState=$(getDarkMode)
    setTheme $lastRecordedState

    # Every 0.5 second, check the current state.
    # If it changed from last recorded state, set theme accordingly.
    while true; do
        currentState=$(getDarkMode)
        if [[ $currentState != $lastRecordedState ]]; then
            setTheme $currentState
            lastRecordedState=$currentState
        fi
        sleep 0.5
    done
}

# Use a lockfile and shlock to prevent the same script from running concurrently.
# This allows to include this script as part of .zshrc, as it will run on every opening of the terminal.
#
# Note: flock should be used instead of shlock, but is unavailable by default on MacOS (can be installed.)
#       See https://stackoverflow.com/a/10526800/6417161
lockfile="/tmp/alacritty-autotheme.lock"
if shlock -f ${lockfile} -p $$
then
    main
else
    # Uncomment for debugging purposes; not desired under normal operating conditions.
    # echo Lock ${lockfile} already locked.
fi


