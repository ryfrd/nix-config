{ lib
, python3
, fetchPypi
}:

python3.pkgs.buildPythonApplication rec {
  pname = "podge";
  version = "0.0.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "36ef08ecdaca0d80e5b4aa1e4649bc7c3b126425eb6df18c6fc8a5973439baa0";
  };

  propagatedBuildInputs = with python3.pkgs; [
    requests
    feedparser
    pyyaml
    sqlalchemy
    setuptools
  ];

}

