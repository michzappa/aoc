{
  description = "a devshell for advent of code";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOs/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = (import nixpkgs { inherit system; });
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            [ (emacsWithPackages (epkgs: (with epkgs; [ dash f s ]))) ];
        };
      });
}
