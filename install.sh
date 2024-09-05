#!/bin/zsh

echo '🚀 Installing Alacritty Theme Autoswitcher...'

# Check if user installed theme files.
for file in "${HOME}/.alacritty-base.toml" "${HOME}/.alacritty-theme-light.toml" "${HOME}/.alacritty-theme-dark.toml"; do
    if [[ ! -f ${file} ]]; then
        echo "⛔ Error: Alacritty config file missing at ${file}"
        echo "Please install config and theme files first. See readme for instructions."
        exit 1
    fi
done

this_dir=${0:a:h}  # Find the directory of this file (repo).

# Copy the switching script to home directory, if does not yet exist there.
script_filename='.alacritty-theme-autoswitch.sh'

if [[ ! -f "${HOME}/${script_filename}" ]]; then
    cp "${this_dir}/${script_filename}" "${HOME}/${script_filename}"
    echo "✅ Script installed to '${HOME}/${script_filename}'"
else
    echo "🟡 Warning: Script already exists at '${HOME}/${script_filename}', skipping."
fi

# Launch the script as part of .zshrc
launch_command='(nohup zsh ${HOME}/.alacritty-theme-autoswitch.sh  >/dev/null 2>&1 &)  # Start Alacritty Theme Autoswitcher'

if [[ ! $(fgrep ${script_filename} ~/.zshrc) ]]; then
    echo "${launch_command} # Start Alacritty Theme Autoswitcher\n" >> ~/.zshrc
    echo '✅ .zshrc updated'
else
    echo "🟡 Warning: .zshrc already contains a command that includes ${script_filename}, skipping."
fi

eval ${launch_command}
echo "✅ Alacritty Theme Autoswitcher launched"

echo '🏁 Done!'
