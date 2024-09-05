# alacritty-theme-autoswitch-macos
Automatically adjust [Alacritty](https://github.com/alacritty/alacritty) theme according to your current system theme. (dark/light)

This is a shell script running indefinitely in the background, checking for system theme change every 0.5 seconds using AppleScript.
If change is detected, it updates `~/.alacritty.toml` with the appropriate theme.

## Requirements
- MacOS 14 (Sonoma)
- `zsh >= 5.9`, set as your shell
- `alacritty >= 0.13.2`
- Alacritty config must contain `live_config_reload = true`

The autoswitcher might work on earlier versions of MacOS, but it is not guaranteed.


## Install
**Before installing the autoswitcher**, you need to prepare Alacritty configuration files in your home directory:

- Place all your configuration excluding theming part in `~/.alacritty-base.toml`
- Place only the light theme in `~/.alacritty-theme-light.toml`
- Place only the dark theme in `~/.alacritty-theme-dark.toml`

**Install the autoswitcher** by running the installation script:
``` zsh
./install.sh
```

**Alternatively**, use any method of your choice to ensure `.alacritty-theme-autoswitch.sh` is launched at login, terminal launch etc.

> See [examples](./examples/) on how the config files should look like.

> The installation script copies `.alacritty-theme-autoswitch.sh` to your home directory and adds a command to `.zshrc` to launch it automatically. Launching autoswitcher is idempotent, as it uses file lock to ensure it only runs once at a time.


## Start
The autoswitcher is started automatically.


## Stop
To stop the script:
``` zsh
pkill -fx "zsh $HOME/.alacritty-theme-autoswitch.sh"
```

Please note, that as long as `.zshrc` contains the launch command, autoswitcher will re-launch every time you open a new shell session.


## Uninstall
To remove autoswitcher:
- Remove launch command from `.zshrc`
- Delete the `.alacritty-theme-autoswitch.sh` from your home directory
- Stop the autoswitcher using the command provided above


## FAQ

#### Can I do this cleaner using AppleScript?
Implementing the same in pure AppleScript is possible and results in similar looping logic. It would have to be compiled as a "stay open application"; making it hidden in the background requires some effort and is arguably less clean. The shell script method is easier.

#### Why not use `import` and update the reference?
I dislike inline file editing. The method of joining two source files is robust and easy to understand.


