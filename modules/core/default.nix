{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  console.keyMap = "fr";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    tmux

    # Default commande line tools
    
    nnn		# terminal file manager

    ###
    # archives
    ###
    zip
    unzip

    ###
    # utils
    ###
    gnugrep	# find in files
    ripgrep	# faster grep
    jq		# JSON parser

    ###
    # networking
    ###
    mtr		# ping + traceroute
    dnsutils	# dig + nslookup
    nmap	# network discovery
    ipcalc	# calculator for IPs

    ###
    # misc
    ###
    file	# file informations
    which	# binary localisation
    tree	# print directory tree
    glow	# CLI md renderer
  ];
  environment.variables.EDITOR = "vim";
}
