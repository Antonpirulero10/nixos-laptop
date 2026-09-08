{ config, lib, inputs, ... }:
{
  imports = [
        inputs.plasma-manager.homeModules.plasma-manager
  ];
  programs.plasma = {
    enable = false;

    workspace = {
     lookAndFeel = "leaf-dark";
      cursor = {
        theme = "Vimix";
        size = 24;
      };
      iconTheme = "Newaita-reborn-dark";
    };
  };  
}
