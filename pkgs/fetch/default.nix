{ stdenv, pkgs, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  name = "fetch";

  src = fetchFromGitHub {
    owner = "ryfrd";
    repo = "fetch";
    rev = "bfc855819a3e90337d36e190dcaf209b1d51b32e";
    sha256 = "1h0kflxjcfjrd9p3cgrzb4krjx3f5nid92alb1vjf8vx4jnb4byh";
  };

  buildInputs = with pkgs; [
    python3
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/fetch.py $out/bin/fetch
    chmod +x $out/bin/fetch
  '';
}
