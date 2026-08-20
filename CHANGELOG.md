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
