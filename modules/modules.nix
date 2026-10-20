{ config, pkgs, inputs, ...}:
{
  imports = [
  	./programs.nix
  	./sqlserver.nix
    #./samba.nix
  ];
}
