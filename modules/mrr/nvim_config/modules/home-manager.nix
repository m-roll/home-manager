{
  rose-pine,
  nil,
  conform,
  nickel-lang-lsp,
  vim-nickel,
  ...
}:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  vimPlugins = pkgs.vimPlugins.extend (
    final': prev': {
      rose-pine = pkgs.vimUtils.buildVimPlugin {
        name = "rose-pine";
        src = rose-pine;
      };
      mrr-config = pkgs.vimUtils.buildVimPlugin {
        name = "mrr-config";
        src = ../src;
        dependencies = [
          prev'.telescope-nvim
          prev'.nvim-cmp
          final'.rose-pine
          final'.conform
          prev'.nvim-lspconfig
          prev'.nvim-surround
        ];
      };
      conform = pkgs.vimUtils.buildVimPlugin {
        name = "conform";
        src = conform;
      };
      vim-nickel = pkgs.vimUtils.buildVimPlugin {
        name = "vim-nickel";
        src = vim-nickel;
      };
    }
  );
in
{
  config = {
    programs.neovim = {
      enable = true;
      extraLuaConfig = ''
        NVIM_CONFIG_ELIXIR_LS_PATH = "${pkgs.elixir-ls}/lib/language_server.sh"
        require("mrr");
      '';
      plugins = [
        vimPlugins.telescope-nvim
        vimPlugins.nvim-lspconfig
        vimPlugins.nvim-cmp
        vimPlugins.diffview-nvim
        vimPlugins.rose-pine
        vimPlugins.conform
        vimPlugins.nvim-treesitter
        vimPlugins.mrr-config
        vimPlugins.vim-tmux-navigator
        vimPlugins.formatter-nvim
        vimPlugins.vim-nickel
        vimPlugins.vim-sexp
        vimPlugins.vim-sexp-mappings-for-regular-people
        vimPlugins.nvim-surround
        vimPlugins.conjure
        vimPlugins.cmp-conjure
        # todo: add the cmp conjure for nrepl
        # all grammars pulls in way too many deps that aren't really maintained
        # (vimPlugins.nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      ];
    };
    home.packages = [
      pkgs.lua-language-server
      pkgs.haskellPackages.haskell-language-server
      nil
      pkgs.elixir-ls
      pkgs.nixfmt-rfc-style
      pkgs.stylua
      nickel-lang-lsp
    ];
  };
}
