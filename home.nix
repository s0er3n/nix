{ config, pkgs, ... }:

{

  home.username = "soeren";
  home.homeDirectory = "/home/soeren";

  home.stateVersion = "23.05"; 


  home.packages = with pkgs; [
    tree
    # nerdfonts
    ripgrep
    docker
    fd
    gcc
    python3Full
    nodejs
    lazygit
    unzip
  ];

  home.file."${config.xdg.configHome}" = {
	  source = ~/dotfiles;
	  recursive = true;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/soeren/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
		enable = true;
		userName = "Sören Michaels";
		userEmail = "soeren.michaels+git@gmail.com";
	};
  programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		withPython3 = true;
		withNodeJs = true;
	};
}
