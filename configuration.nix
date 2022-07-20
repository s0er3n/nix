# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix <home-manager/nixos>];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

 services.xserver.libinput.naturalScrolling = true;
 services.xserver.libinput.middleEmulation = true;
 services.xserver.libinput.enable = true;
 # for showing the battery
 services.acpid.enable = true;

  networking.hostName = "soerens-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Enable the X11 windowing system.

  # Enable the awesome Desktop Environment.
  services.xserver = {
    enable = true;

  
    displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      
      luaModules = with pkgs.luaPackages; [
      ];

    };};


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.soeren = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Soeren";
    extraGroups = [ "networkmanager" "wheel" "video"];

  };
  home-manager.users.soeren = { pkgs, ... }: {


  # make a file with text in it and it will get sym linked
  home.file = {"rc.lua" = {
	source = "/etc/nixos/rc.lua";
	# recursive = true;
	target = ".config/awesome/rc.lua";
  	};
  };

  # add a battery widget to lua
  home.file = {"battery-widget.lua" = {
	source = "/etc/nixos/battery-widget.lua";
	# recursive = true;
	target = ".config/awesome/battery-widget/init.lua";
  	};
  };
  # nvim config
  home.file = {"init.lua" = {
	source = "/etc/nixos/init.lua";
	# recursive = true;
	target = ".config/nvim/init.lua";
  	};
  };

  home.file = {"./.config/fish/config.fish".text = "fish_vi_key_bindings";  };

  home.file = {"./.tmux.conf".text = "set-option -g default-shell $SHELL";  };

  nixpkgs.config.allowUnfree = true; 
  programs.fish = {
  	enable = true;
  };
  services.network-manager-applet.enable= true;

 programs.alacritty.enable = true; 
  home.packages = with pkgs; [
		tmux
		gcc

	       unzip
	       home-manager
	       neovim
	       git
	       gh
	       direnv
	       anki-bin
	       notion-app-enhanced
	       google-chrome
	       flameshot
  ];
};


programs.light.enable = true;
hardware.acpilight.enable = true;


  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "soeren";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  libinput
	home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
	programs.neovim.enable = true ;
	programs.neovim.defaultEditor = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

nix = {
	package = pkgs.nixFlakes;
	extraOptions = ''

	experimental-features = nix-command flakes
	'';
};
}
