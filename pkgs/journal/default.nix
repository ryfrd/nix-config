{ stdenv, pkgs, fetchFromGitLab }:

stdenv.mkDerivation {
  name = "journal";
  buildInputs = [
    pkgs.python3
  ];
  dontUnpack = true;
  installPhase = "install -Dm 0755 ${./journal.py} $out/bin/journal";
}
