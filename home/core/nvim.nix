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

    # Finder
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          options.desc = "Find Files";
        };
        "<leader>fg" = {
          action = "live_grep";
          options.desc = "Live Grep";
        };
        "<leader>fb" = {
          action = "buffers";
          options.desc = "Find Buffers";
        };
      };
    };

    # LSP
    plugins.lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        ts_ls.enable = true;
        pyright.enable = true;
        nil_ls.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "K" = "hover";
      };
    };

    # Autocomplete
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
      };
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
