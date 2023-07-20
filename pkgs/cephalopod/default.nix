{ version, pkgs, buildPythonPackage, fetchFromGitHub, ... }:
buildPythonPackage {
  pname = "cephalopod";
  version = "7289034f9f736bec1d52bdbae605308838ba2b76";

  src = fetchFromGitHub {
    inherit version;
    owner = "ryfrd";
    repo = "cephalopod";
    rev = "${version}";
    sha256 = "0549v1dhrf2ivcn55r8yma7a53gcrkv811wr2xkvw678smz12iri";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    requests
    pyyaml
    sqlalchemy
    feedparser
  ];

  dontUnpack = true;

  installPhase = ''
    install -Dm 0755 $src/cephalopod.py $out/bin/cephalopod
  '';
}

