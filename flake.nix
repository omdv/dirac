{
  description = "Dirac coding agent dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = fn:
      nixpkgs.lib.genAttrs systems (system: let
        pkgs = import nixpkgs {inherit system;};
      in
        fn {inherit system pkgs;});
  in {
    devShells = forAllSystems ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          # Node.js & npm
          nodejs_22

          # Protobuf tooling
          buf
          protobuf
          grpcurl

          # Native build deps (better-sqlite3, esbuild, etc.)
          python3
          gcc
          gnumake
          pkg-config

          # Linting & formatting
          biome

          # Typescript language server
          typescript-language-server
        ];

        shellHook = ''
          echo "Node $(node -v) | npm $(npm -v)"

          if [ ! -d "node_modules" ]; then
            echo "Installing dependencies (skip-scripts)..."
            # --script-shell=true makes all lifecycle scripts no-ops so the cli
            # workspace prepare hook doesn't fail (it needs generated protos).
            npm install --ignore-scripts --script-shell="$(command -v true)"

            echo "Rebuilding native addons..."
            npm rebuild better-sqlite3 esbuild
            npx --yes @mapbox/node-pre-gyp install --directory=node_modules/grpc-tools

            echo "Generating protobuf files..."
            npm run protos

            echo "Installing webview dependencies..."
            cd webview-ui && npm install && cd ..

            echo ""
            echo "Setup complete. Run 'npm run compile' to build, or 'node esbuild.mjs' for a quick build."
          fi
        '';
      };
    });
  };
}
