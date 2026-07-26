{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # Grey auto-completion
    autosuggestion.enable = true;
    
    # Color the commande ligne
    syntaxHighlighting.enable = true;

    # Plugins Oh-My-Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" ];
    };

    shellAliases = {
      # Remplace ls for eza
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --git --group-directories-first";
      la = "eza -la --icons --git --group-directories-first";
      
      # Replace cat for bat
      cat = "bat";
    };

    initExtra = ''
      # Configuration for  completion engine
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^H" backward-kill-word # Ctrl+Backspace
    '';
  };

  # Interactive fuzzy search (Ctrl+R / Ctrl+T)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Inteligent cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # ls replacement
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  # cat replacement
  programs.bat = {
    enable = true;
  };

  home.packages = with pkgs; [
    zsh-completions
  ];
}
