{ pkgs, inputs, ... }:
{
imports = [
  inputs.nixvim.homeManagerModules.nixvim
];
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraPlugins = with pkgs.vimPlugins; [ 
      neovim-ayu 
      vim-parinfer
      yuck-vim
    ];

    # Theme

    colorscheme = "ayu-mirage";

    # Options

    options = {
      number = true;
      relativenumber = true;
    };

    # Plugins

    plugins.nvim-colorizer = {
      enable = true;
    };

    plugins.bufferline = {
      enable = true;
    };

    plugins.nvim-autopairs = {
      enable = true;
    };

    plugins.lualine = {
      enable = true;
    };

    plugins.neo-tree.enable = true;

    # Languages
    plugins.lsp.enable = true;
    plugins.treesitter.enable = true;

    plugins.nix.enable = true;

    # Keybindings

    globals.mapleader = " ";

    maps = {
      normalVisualOp."<leader>e" = {
        action = "<cmd>NeoTreeFocusToggle<CR>";
      };
    };
  };
}
