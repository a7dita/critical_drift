{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            manim
            python3Packages.numpy
            python3Packages.pandas
            python3Packages.matplotlib
            python3Packages.seaborn
            # python3Packages.pathlib # TODO solve version conflict
            python3Packages.scipy
            python3Packages.scikit-learn
            python3Packages.networkx
            # python3Packages.unittest
            python3Packages.jupyterlab
            # python3Packages.jupyterthemes
            python3Packages.ptpython
            python3Packages.termcolor
            python3Packages.python-lsp-server
            python3Packages.pydub
          ];
        };
      });
    };
}
