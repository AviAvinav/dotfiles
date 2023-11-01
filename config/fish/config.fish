if status is-interactive
    # Commands to run in interactive sessions can go here
    alias v nvim
    alias g git
    alias p pnpm
    alias y yarn
	alias ll "exa --long --icons -h"
	alias mcd "mkdir $arg && cd $arg"
	alias c code
	alias eww "~/eww/target/release/eww"
	alias bright "~/.config/xmonad/bright.sh"
	set --universal nvm_default_version v20.5.1
	set -gx LANG "en_IN.utf-8"
end
fish_add_path /home/avi/.spicetify
fish_add_path /home/avi/.cargo/bin
fish_add_path /home/avi/.avm/bin
fish_add_path /home/avi/.local/share/solana/install/active_release/bin
fish_add_path /home/avi/.local/share/nvim/
fish_add_path /home/avi/.config/xmobar/
fish_add_path /home/avi/.local/bin
fish_add_path /home/avi/.local/share/nvim/mason/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opam configuration
source /home/avi/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
