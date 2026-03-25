{
  description = "solfunmeme-dioxus — WASM frontend with Solana wallet + DAO governance";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
          targets = [ "wasm32-unknown-unknown" ];
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            pkg-config openssl
            wasm-pack wasm-bindgen-cli
            trunk
            binaryen  # wasm-opt
            chromium chromedriver  # headless testing
            nodePackages.tailwindcss
          ];

          shellHook = ''
            echo "🦀 solfunmeme-dioxus dev shell"
            echo "  cargo build          — native check"
            echo "  dx build --release   — WASM build"
            echo "  dx serve             — dev server"
            echo "  make test-headless   — headless browser tests"
            export CHROME_BIN="${pkgs.chromium}/bin/chromium"
            export CHROMEDRIVER="${pkgs.chromedriver}/bin/chromedriver"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "solfunmeme-dioxus";
          version = "1.1.0";
          src = ./.;
          nativeBuildInputs = with pkgs; [
            rustToolchain pkg-config wasm-bindgen-cli binaryen
          ];
          buildInputs = with pkgs; [ openssl ];
          buildPhase = ''
            export HOME=$TMPDIR
            cargo build --release --target wasm32-unknown-unknown
            wasm-bindgen --out-dir dist --target web \
              target/wasm32-unknown-unknown/release/solfunmeme_dioxus.wasm
            wasm-opt -Oz -o dist/solfunmeme_dioxus_bg.wasm dist/solfunmeme_dioxus_bg.wasm || true
          '';
          installPhase = ''
            mkdir -p $out
            cp -r dist/* $out/
            cp -r assets $out/ 2>/dev/null || true
          '';
        };
      }
    );
}
