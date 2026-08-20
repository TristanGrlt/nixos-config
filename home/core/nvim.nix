{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Leader
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Base
    opts = {
      number = true;
      cursorline = true;
      termguicolors = true;
      background = "dark";
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      ignorecase = true;
      smartcase = true;
    };

    # Theme
    colorschemes.tokyonight.enable = true;

    # Treesitter
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
      };
    };

    # Explorer
    plugins.neo-tree = {
      enable = true;
    };

    # Keybinds
    keymaps = [
      {
        mode = "n";
        key = "<leader>th";
        options.desc = "Toggle Theme";
        action.__raw = ''
          function()
            if vim.o.background == "dark" then
              vim.o.background = "light"
            else
              vim.o.background = "dark"
            end
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>e";
        options.desc = "Toggle Explorer";
        action = "<cmd>Neotree toggle<CR>";
      }
    ];
  };
}
