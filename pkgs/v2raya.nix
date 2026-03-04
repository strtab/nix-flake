{
  pkgs,
  lib,
  ...
}:
let
  v2rayAssets = pkgs.linkFarm "v2ray-assets" [
    {
      name = "geoip.dat";
      path = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
    }
    {
      name = "geosite.dat";
      path = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
    }
  ];
  v2rayaCustom = lib.makeOverridable (
    {
      v2ray ? pkgs.xray,
    }:
    pkgs.stdenv.mkDerivation rec {
      pname = "v2raya";
      version = "2.2.7.5";

      src = pkgs.fetchurl {
        url = "https://github.com/v2rayA/v2rayA/releases/download/v${version}/v2raya_linux_x64_${version}";
        sha256 = "sha256-M7wfTu4PIbBqjhOTswZoO2ISM8MSPyup1/QFDOfVXTM=";
      };

      dontUnpack = true;
      dontBuild = true;

      installPhase = "install -Dm755 $src $out/bin/v2raya";

      meta = {
        description = "A web GUI client of Project V";
        homepage = "https://v2raya.org";
        mainProgram = "v2raya";
        license = lib.licenses.agpl3Only;
        platforms = [ "x86_64-linux" ];
      };
    }
  ) { };
in
{
  nixpkgs = {
    overlays = [
      (final: prev: { v2raya = v2rayaCustom; })
    ];
  };

  environment.systemPackages = with pkgs; [ xray ];
  services.v2raya.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          action.lookup("unit") == "v2raya.service") {
        return polkit.Result.YES;
      }
    });
  '';

  systemd.services.v2raya.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.v2raya}/bin/v2raya \
      --log-disable-timestamp \
      --v2ray-bin ${pkgs.xray}/bin/xray \
      --v2ray-assetsdir ${v2rayAssets}
  '';
}
