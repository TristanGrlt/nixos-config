{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
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
}
