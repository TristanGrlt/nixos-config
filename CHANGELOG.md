## 0.8.0 (2026-10-17)

### Feat

- add an official documentation and a license
- **sops**: make sops secret management per user and also global
- **host**: removed lap-greycanyon that no longer exist
- **shell**: move all shell realted thing to a dir of this name to clean up the home dir
- **prompt**: move startship config to a file in home
- **term**: move alacatry config to a file in home
- **nixpkgs**: define nur as a global overlay
- **flake**: syncronise all inputs with nixpkgs
- add steam
- **virtu**: add virtualisation support and CLI abd GUI for it
- **db**: add configuration for univ database with host config and sops password
- add oracle database tools for DB course
- **kanshi**: set scale to .9 for my laptop screen at all time
- add back ollama
- remove ollama
- add ollama
- **gpu**: add nvidia config for the GPU
- **nvim**: beter auto-completion
- **lap-grassfield**: add ollama service
- **nvim**: add beter errors indications
- **mime**: make firefox the default and fix nvim as the default text editor
- **vpn**: add the vpn off the dpi of the urn
- **games**: add configuration folder for games and add minecraft launcher prism
- **ssh**: add a pinetry pakage
- **discord**: add vesktop with custom theme
- **wifi**: config wifi networks in nix with sops
- **ssh**: add ttl
- **ssh**: add gpg agent for ssh cache ttl
- **mail**: add thunderbird
- **nvim**: add formater for nix that follow the rfc
- **sops**: add sops for nix
- **config**: add dev tools options for grassfields
- use correct style for the greeting screen
- . . pfff
- **firefox**: add missing add-ons
- **terminal**: add a keybind to open a new terminal window in the same path
- **aliases**: remove cat by bat aliases and added spf for superfile aliases
- **rofi**: add menus to do actions simplier

### Fix

- remove build warning
- **lap-grassfield**: import kanshi
- **email**: remove email password of sops because it is not working
- **sov**: remove sov, it is not usefull at all
- **ssh-agent**: set cache time to 2h and renamed file to match the content
- **wifi**: make config persistent trought reboot
- remove unused file
- **editor**: use the right package to format nix code

### Refactor

- **kanshi**: kanshi config is now per user per host by checking the host name when building the system
- **user**: now view users forlder as a collection of user situations thats can be imported for each host depending of what the user will do with the host
- **explorer**: change from nautilus to thunar

## 0.7.0 (2026-08-25)

### Feat

- **wayland**: migrate from wofi to rofi and add GNOME apps
- **browser**: add brave-origin browser
- **firefox**: add firefox with a full nix declarative config
- **explorer**: switch file explorer from nnn to superfile
- **nvim**: add formating for multiple language
- **nvim**: add toglable floating term
- **nvim**: add Which-key
- **nvim**: add lualine
- **nvim**: add gitsigns

### Fix

- **nvim**: fix include and package name for auto format

## 0.6.0 (2026-08-20)

### Feat

- **nvim**: add LSP and autocomplete
- **nvim**: add the neo-tree explorer
- **nvim**: add base config for nvim
- **wl-copy**: add wl-copy and clipboard history visible throught wofi
- **screeshot**: add flameshot to be able to make screenshot
- **overview**: add an overview for sway trigered by holding mod+tab
- **lock**: auto lock activation and keybind to turn off screens
- **transmission**: add torrent clieny*t
- **host**: added a new host lap-grassfields
- **pkgs**: add disko for reproductible disk configuration
- **host**: add a new host config
- **swaync**: add more options to swaync
- **swayfx**: add config for swayfx
- **sway**: add small gaps between windows
- **waybar**: set explicit no margin on bar

### Fix

- **lock**: add pam right to hyprlock
- **lock**: fix border
- **app**: add crackng
- **host**: fix missspeled host and update flake disko
- **disko**: add mising attribut
- **disko**: add missing nixosModules disko
- **sway**: fix gap for windows

### Refactor

- **nvim**: use nixvim instead of hand made nvim config
- **font**: make default and monospace font configurable along side other theme configuration

## 0.5.0 (2026-07-30)

### Feat

- **lockscreen**: add conf for hyprlock
- **wallpaper**: define theme option for per user wallpapers
- **workspace**: waybar only show screen local workspace and keybind adapted for azerty layout

### Fix

- **warning**: all warning have been fixed

## 0.4.0 (2026-07-29)

### Feat

- **bluetooth/stray**: add always on bluetooth applet in the stray
- **waybar**: write a simple starting waybar
- **style**: add the rest of style to what is here
- **style**: wofi
- **style**: add wallpaper and stylix

### Fix

- **style**: sway borders
- **style**: main palette
- **style**: sway
- **style**: define base for color stylisation
- return to a more stable state

### Refactor

- **waybar**: clean up config

## 0.3.0 (2026-07-26)

### Feat

- **zsh**: add zsh and a lot of plugins

## 0.2.0 (2026-07-26)

### Feat

- **allacritty**: set SpaceMono Nerd Font as alacritty default font
- **fonts**: add space-grotesk as default font
- **light/volume**: add UI for light and volume with keybindings
- **sway/keybinding**: add a lock session keybind and document it
- **lock**: add swaylock to lock the session
- **kanshi**: configure kanshi to my screens

### Fix

- **fonts**: fix google sourced fonts
- **light**: switch to supported light options
- **lap-greycanyon/user**: remove unwanted comma
- **sway/keybindings**: add missing pkgs
- **sway/keybindings**: add media and volume control keybinds
- **lock**: fixed path to swaymsg
- **kanshi**: fix screen position
- **kanshi**: screen position
- **kanshi**: deleted duplicated kanshi config conflicting
- **git**: add missing char
- **cz**: add mising cz config file

### Refactor

- **homemanager**: renamed home.nix to default.nix
- **user**: split into different files the user config
- **git**: move user git config from global module to per user conf

## 0.1.0 (2026-07-26)

### Feat

- **home/core**: add git config for aliases and split config into diff files
