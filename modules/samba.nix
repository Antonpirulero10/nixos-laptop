{ config, pkgs, inputs, ...}:
{
 services.samba = {
    package = pkgs.samba4Full;
    usershares.enable = true;
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "server min protocol" = "SMB3";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "private" = {
        "path" = "/home/antonpirulero10/Projects/private";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
 };
 services.samba-wsdd = {
   enable = true;
   openFirewall = true;
 };
 services.avahi = {
  publish.enable = true;
  publish.userServices = true;
  # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
  nssmdns4 = true;
  # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
  enable = true;
  openFirewall = true;
};
systemd.targets.samba = {
  wants = [ "network-online.target" ];
  after = [ "network-online.target" ];
};

}