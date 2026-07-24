{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    tmux
    
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
