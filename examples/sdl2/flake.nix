{
  inputs.nixpkgs.url = "nixpkgs";

  outputs = inputs: let
    supportedSystems = [
      "x86_64-linux"
    ];
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          SDL2
          # alsa-lib
          # xorg.libX11
          # xorg.libXi
          # xorg.libXcursor
          #
          # vulkan-headers
          # vulkan-loader
          # vulkan-validation-layers
        ];
      };
    });
  };
}
