{ pkgs, lib, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "v2raya";
  version = "2.2.7.5";

  src = pkgs.fetchurl {
    url = "https://github.com/v2rayA/v2rayA/releases/download/v${version}/v2raya_linux_x64_${version}";
    sha256 = "sha256-M7wfTu4PIbBqjhOTswZoO2ISM8MSPyup1/QFDOfVXTM=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/v2raya
    chmod +x $out/bin/v2raya
  '';

  meta = {
    description = "A web GUI client of Project V";
    homepage = "https://v2raya.org";
    mainProgram = "v2raya";
    license = lib.licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
