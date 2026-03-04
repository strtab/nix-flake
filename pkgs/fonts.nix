{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "custom-fonts";
  version = "1.0";
  src = ./fonts;
  nativeBuildInputs = [ pkgs.unzip ];
  unpackPhase = ''
    cp $src/*.zip .
    for zip in *.zip; do
      unzip -o "$zip"
    done
  '';
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    find . -name "*.ttf" -o -name "*.otf" | xargs -I{} cp {} $out/share/fonts/truetype/
  '';
}
