{ config, pkgs, inputs, ...}:
{
  virtualisation.podman = {
    enable  = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enable = true;  
  };
  
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
        sqlserver = {
        image = "mcr.microsoft.com/mssql/server:2022-latest";
        ports = [ "1433:1433" ];
        environment = {
          "ACCEPT_EULA" = "Y";
          "MSSQL_SA_PASSWORD" = "Qq@111222";
        };  
        extraOptions = [ "--memory=4g" ];
        autoStart = false;
      };
    };
  };
}