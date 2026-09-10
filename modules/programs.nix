{ config, pkgs, inputs, ...}:
{
  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Install KDEConnect
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
  #Utility
  micro
  neovim
  fastfetch
  btop
  networkmanager_dmenu
  git
  wget
  wlogout     
  hunspell
  hunspellDicts.es_MX
  hunspellDicts.en_US
  bluez
  blueman
  bat
  tree
  #Programs
  #arduino-ide
  #octaveFull
  joplin-desktop
  #vesktop
  vscodium-fhs
  vlc
  qbittorrent
  speedcrunch
  libreoffice-qt
  gimp3
  #audacity
  #kdePackages.kdenlive
  gnome-font-viewer
  loupe
  freecad
  gnome-boxes
  kdePackages.krdc
  ];
}
