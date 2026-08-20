{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      nvim-treesitter.withAllGrammars
    ];

    extraLuaConfig = ''
      -- Leader
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Keybinds
      vim.keymap.set("n", "<leader>th", function()
        if vim.o.background == "dark" then
          vim.o.background = "light"
        else
          vim.o.background = "dark"
        end
      end, { desc = "Toggle Theme" })

      -- Base
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true

      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Theme
      vim.cmd([[colorscheme tokyonight]])

      -- Treesitter
      local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if status_ok then
        ts_configs.setup({
          ensure_installed = { "c", "java", "python", "typescript", "lua", "vim", "vimdoc" },
          highlight = { enable = true },
          auto_install = true,
        })
      end
    '';
  };
}
