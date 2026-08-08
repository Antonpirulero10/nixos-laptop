{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/modules.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth = {
    enable = true;
    theme = "loader_2";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = ["loader_2"];		
      })
    ];
  };
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = ["quiet" "splash" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto"];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Disable hibernation
  systemd.sleep.settings.Sleep = {
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

  # Define your hostname.
  networking.hostName = "Antonpirulero10-Laptop"; 
  
  # Enable networking
  networking.networkmanager.enable = true;

  #Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
  # Enable Auto-Mount
  services.udisks2.enable = true;
  # Enable blueman Bluetooth Manager
  services.blueman.enable = true;
  # Enable virtualization
  virtualisation.libvirtd.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.antonpirulero10 = {
    isNormalUser = true;
    description = "Antonpirulero10";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  # Install fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  # Install KDEConnect
  programs.kdeconnect.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enables flatpak
  services.flatpak.enable = true;

  # Install fonts
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono
  	nerd-fonts.jetbrains-mono
  	nerd-fonts.terminess-ttf
  	liberation_ttf
  ]; 

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 53317 ];
   networking.firewall.allowedUDPPorts = [ 53317 ];

  system.stateVersion = "25.05";

}
