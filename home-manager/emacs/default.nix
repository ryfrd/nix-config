{ pkgs, config, writeText, ... }:
let
  scheme = config.colorscheme;
in

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;

		extraPackages = epkgs: with epkgs; [
      use-package
      base16-theme
			doom-modeline 
			evil
			all-the-icons
			all-the-icons-dired
      projectile
      ivy
      counsel
      swiper
      # do things for me
      company
      flex-autopair
      smart-comment
			# language support
			lua-mode
			nix-mode
			markdown-mode
			go-mode
			eglot
      writeroom-mode
    ];			
	};

  # emacs client
	services.emacs = {
    enable = true;
    defaultEditor = true;
		client = {
	 		enable = true;
	 	};
  };

  # lsp
  home.packages = with pkgs; [
    gopls
    rnix-lsp
    python3Packages.python-lsp-server
    luaPackages.lua-lsp
    nodePackages.bash-language-server
  ]; 

  # dynamic colors
	home.file = {
		".emacs.d/init.el" = {
			source = ./init.el;
		};
		".emacs.d/themes/jdysmcl-theme.el" = {
			text = ''
        (require 'base16-theme)
    		(defvar jdysmcl-theme-colors
      			'(:base00 "#${scheme.colors.base00}"
        		:base01 "#${scheme.colors.base01}"
        		:base02 "#${scheme.colors.base02}"
                :base03 "#${scheme.colors.base03}"
                :base04 "#${scheme.colors.base04}"
                :base05 "#${scheme.colors.base05}"
                :base06 "#${scheme.colors.base06}"
                :base07 "#${scheme.colors.base07}"
                :base08 "#${scheme.colors.base08}"
                :base09 "#${scheme.colors.base09}"
                :base0A "#${scheme.colors.base0A}"
                :base0B "#${scheme.colors.base0B}"
                :base0C "#${scheme.colors.base0C}"
                :base0D "#${scheme.colors.base0D}"
                :base0E "#${scheme.colors.base0E}"
                :base0F "#${scheme.colors.base0F}")
                "All colors for jdysmcl are defined here.")
            ;; Define the theme
            (deftheme jdysmcl)
            ;; Add all the faces to the theme
            (base16-theme-define 'jdysmcl jdysmcl-theme-colors)
            ;; Mark the theme as provided
            (provide-theme 'jdysmcl)
            (provide 'jdysmcl-theme)
            '';
		};
	};


}
