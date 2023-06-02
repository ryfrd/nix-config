{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "fetch";
  buildInputs = [
    pkgs.python3
  ];
  dontUnpack = true;
  installPhase = "install -Dm 0755 ${./fetch.py} $out/bin/fetch";
}
